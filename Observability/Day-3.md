# 📘 Observability Zero to Hero — Episode 3: Prometheus Architecture (Practical) & Grafana

> **Series Recap:** Day 1 = Observability Fundamentals | Day 2 = Metrics & Monitoring + Prometheus Setup | **Day 3 = Prometheus in Action + PromQL + Grafana**

---

## 📌 Table of Contents
1. [Prometheus Architecture — Deep Dive](#1-prometheus-architecture--deep-dive)
2. [Node Exporter — What It Does & How to Verify](#2-node-exporter--what-it-does--how-to-verify)
3. [Kube State Metrics — What It Does & How to Verify](#3-kube-state-metrics--what-it-does--how-to-verify)
4. [Time Series Database — How Prometheus Stores Data](#4-time-series-database--how-prometheus-stores-data)
5. [PromQL — Prometheus Query Language](#5-promql--prometheus-query-language)
6. [Live Demo — Pod Crash Monitoring with Prometheus](#6-live-demo--pod-crash-monitoring-with-prometheus)
7. [Grafana — Why It Exists & How to Use It](#7-grafana--why-it-exists--how-to-use-it)
8. [Creating Custom Grafana Dashboards](#8-creating-custom-grafana-dashboards)
9. [What's Coming in Day 4](#9-whats-coming-in-day-4)
10. [Common Mistakes & Best Practices](#10-common-mistakes--best-practices)
11. [Interview Prep — Key Points](#11-interview-prep--key-points)

---

## 1. Prometheus Architecture — Deep Dive

### 🧠 What is Prometheus?
Prometheus is an **open-source monitoring and alerting toolkit** specifically designed for **cloud-native and Kubernetes environments**. Its primary job is to **scrape (pull) metrics** from various sources at regular intervals and store them.

### 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                  PROMETHEUS SERVER                        │
│                                                           │
│   ┌─────────────┐    ┌──────────────────┐               │
│   │   Scraper   │───▶│ Time Series DB   │               │
│   │  (Puller)   │    │  (TSDB)          │               │
│   └─────────────┘    └──────────────────┘               │
│          ▲                    │                           │
│          │                    ▼                           │
│   ┌──────┴──────┐    ┌──────────────────┐               │
│   │   /metrics  │    │   HTTP Server    │◀── PromQL      │
│   │  endpoints  │    │   (Query API)    │                │
│   └─────────────┘    └──────────────────┘               │
└─────────────────────────────────────────────────────────┘
          ▲
          │  scrapes /metrics
  ┌───────┴──────��───┐
  │                  │                  │
  ▼                  ▼                  ▼
Node            Kube State         Custom App
Exporter         Metrics            /metrics
(per node)    (1 instance)       (your services)
```

### 🔑 Key Metric Sources (Scrapers/Exporters)

| Source | What It Collects | Runs As |
|--------|-----------------|---------|
| **Node Exporter** | CPU, Memory, Disk, Network of K8s Nodes (EC2 instances) | DaemonSet (one per node) |
| **Kube State Metrics** | Pod status, Deployment status, ReplicaSets, Services, ConfigMaps, Secrets, CRDs | Deployment (one replica) |
| **Custom Metrics** | HTTP request latency, user signups, transactions, login counts | Your application pods |
| **MySQL Exporter** | MySQL DB performance, query times, connections | Pod/Sidecar |

> 🔑 **Key Insight:** Without Node Exporter and Kube State Metrics, Prometheus is nearly blind. These two are the **backbone of Kubernetes observability**.

### ⚡ Why Two Instances of Node Exporter but One Kube State Metrics?

- **Node Exporter** = reads from **local system files** (`/proc`, `/sys`) of each node → must run on **every node** → deployed as a **DaemonSet**
- **Kube State Metrics** = talks to **Kubernetes API Server** (centralized) → one replica is enough → deployed as a **Deployment**

```yaml
# Node Exporter runs as DaemonSet
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitoring
# Runs on EVERY node automatically
```

```yaml
# Kube State Metrics runs as Deployment
kind: Deployment
metadata:
  name: kube-state-metrics
  namespace: monitoring
replicas: 1
# Talks to API Server — one instance is sufficient
```

---

## 2. Node Exporter — What It Does & How to Verify

### 🧠 What is Node Exporter?
Node Exporter is a **Prometheus exporter** that collects **hardware and OS-level metrics** from your Kubernetes worker nodes (EC2 instances on AWS).

**It collects:**
- CPU utilization per core
- Memory usage (total, free, used, cached)
- Disk I/O (reads, writes)
- Network traffic (bytes in/out)
- System load averages
- Running processes and threads
- Go routines (if applicable)
- Filesystem usage

### 🔬 How to Verify Node Exporter is Working

**Step 1 — Find Node Exporter Service**
```bash
kubectl get svc -n monitoring | grep node-exporter
# Output:
# prometheus-node-exporter   ClusterIP   10.100.x.x   <none>   9100/TCP
```

**Step 2 — SSH into the Node (AWS EKS)**
```
AWS Console → EC2 → Select Node → Connect → Session Manager
```

```bash
# For Minikube users
minikube ssh
```

**Step 3 — Hit the /metrics Endpoint**
```bash
# Replace with your node-exporter ClusterIP
curl http://10.100.x.x:9100/metrics
```

**Sample Output:**
```
# HELP node_cpu_seconds_total Seconds the CPUs spent in each mode.
# TYPE node_cpu_seconds_total counter
node_cpu_seconds_total{cpu="0",mode="idle"} 12345.67
node_cpu_seconds_total{cpu="0",mode="user"} 234.56

# HELP node_memory_MemAvailable_bytes Memory available in bytes
# TYPE node_memory_MemAvailable_bytes gauge
node_memory_MemAvailable_bytes 2.5e+09

# HELP node_filesystem_size_bytes Filesystem size in bytes
node_filesystem_size_bytes{device="/dev/xvda1",mountpoint="/"} 2.147e+10
```

> 💡 **Important:** Every exporter exposes a `/metrics` endpoint. This is the **standard contract** between exporters and Prometheus. Prometheus knows to always poll `/metrics`.

### 🌍 Real-World AWS Example

```
Production Scenario:
Your EKS cluster has 5 worker nodes (m5.large EC2 instances).
Node Exporter runs as a DaemonSet = 5 pods, one per node.

At 2 AM your node runs out of memory.
→ Node Exporter detects: node_memory_MemAvailable_bytes drops to near 0
→ Prometheus scrapes this every 15 seconds
→ Alert fires to PagerDuty/Slack
→ On-call engineer gets notified
→ Incident resolved before users notice
```

---

## 3. Kube State Metrics — What It Does & How to Verify

### 🧠 What is Kube State Metrics?
Kube State Metrics (KSM) is an exporter that **listens to the Kubernetes API Server** and generates metrics about the **state of Kubernetes objects** — not the node hardware, but the **logical cluster objects**.

**It collects:**
- Pod status (Running, Pending, Failed, CrashLoopBackOff)
- Container restart counts
- Deployment desired vs. available replicas
- ReplicaSet status
- Service endpoint counts
- ConfigMap and Secret creation times
- Node readiness
- PersistentVolumeClaim status
- Custom Resource states (Validating Webhooks, etc.)

### 🔬 How to Verify Kube State Metrics

```bash
kubectl get svc -n monitoring | grep kube-state
# kube-state-metrics   ClusterIP   10.100.y.y   <none>   8080/TCP,8081/TCP
```

```bash
# From inside a node (via Session Manager or minikube ssh)
curl http://10.100.y.y:8080/metrics
```

**Sample Output:**
```
# HELP kube_pod_container_status_restarts_total Total restarts of a container
# TYPE kube_pod_container_status_restarts_total counter
kube_pod_container_status_restarts_total{
  namespace="default",
  pod="my-app-7d9f8b-xk2p1",
  container="my-app"
} 3

# HELP kube_deployment_status_replicas_available Replicas available
kube_deployment_status_replicas_available{
  namespace="production",
  deployment="payment-service"
} 3
```

**Filter specific metrics using grep:**
```bash
# Find container restart info
curl http://10.100.y.y:8080/metrics | grep "container"

# Find restart counts specifically
curl http://10.100.y.y:8080/metrics | grep "restart"

# Find init container metrics
curl http://10.100.y.y:8080/metrics | grep "init_container"
```

### 🌍 Real-World AWS Example

```
Production Scenario:
Your payments microservice has been restarting silently at 3 AM.
Devs don't notice because pods recover quickly (CrashLoopBackOff).

→ KSM tracks: kube_pod_container_status_restarts_total
→ Prometheus stores this over time in TSDB
→ Grafana dashboard shows spike in restarts at 3 AM
→ Team investigates → finds OOMKilled (Out of Memory)
→ Fix: Increase memory limits in deployment YAML
```

---

## 4. Time Series Database — How Prometheus Stores Data

### 🧠 What is a Time Series Database (TSDB)?

A **Time Series Database** stores data points **indexed by time**. Unlike a traditional SQL database that stores just key-value pairs (e.g., `employee_name = "John"`), a TSDB stores:

```
metric_name{labels} value @timestamp
```

**Traditional DB:**
```
| employee_name | salary |
|---------------|--------|
| John          | 50000  |
```

**Time Series DB (Prometheus):**
```
cpu_usage{node="worker-1", mode="user"} 45.2  @1700000000
cpu_usage{node="worker-1", mode="user"} 47.8  @1700000015
cpu_usage{node="worker-1", mode="user"} 43.1  @1700000030
```

> ⏰ **Why time matters:** In monitoring, the **trend over time** is what tells you if something is going wrong. A single CPU value of 80% means nothing. But CPU at 80% for 30 consecutive minutes means your node is in trouble.

### 📦 Prometheus Data Format

Every metric in Prometheus has this structure:

```
metric_name{label1="value1", label2="value2"} numeric_value
```

**Example:**
```
kube_pod_container_status_restarts_total{
  namespace="default",
  pod="busybox-crash",
  container="busybox-crash",
  uid="abc-123"
} 8
```

---

## 5. PromQL — Prometheus Query Language

### 🧠 What is PromQL?
PromQL is the **query language of Prometheus**. Just like SQL queries a relational database, PromQL queries Prometheus's time series database (TSDB).

Prometheus exposes an **HTTP Server** with a UI at port `9090`. You write PromQL queries there to fetch and visualize metrics.

### 🔤 PromQL Syntax Basics

```
metric_name{label_selector="value"}
```

**Examples:**

```promql
# All container restarts across all namespaces
kube_pod_container_status_restarts_total

# Filter by namespace
kube_pod_container_status_restarts_total{namespace="default"}

# Filter by namespace AND pod name
kube_pod_container_status_restarts_total{namespace="default", pod="my-app-xyz"}

# Init container restarts
kube_pod_init_container_status_restarts_total

# Number of ConfigMaps in kube-system namespace
kube_configmap_created{namespace="kube-system"}

# Node CPU usage
node_cpu_seconds_total{mode="idle"}

# Available memory on nodes
node_memory_MemAvailable_bytes
```

### 📊 PromQL Aggregation Functions

These are **critical for real-world use** — raw metrics are hard to read, aggregations make them meaningful.

| Function | Purpose | Example |
|----------|---------|---------|
| `sum()` | Total across all labels | Sum of all pod restarts in a namespace |
| `avg()` | Average value | Average CPU across all nodes |
| `max()` | Highest value | Node with highest memory usage |
| `min()` | Lowest value | Node with lowest disk space |
| `count()` | Count of time series | Number of running pods |
| `rate()` | Per-second rate of increase | HTTP requests per second |

**Real-World PromQL Examples:**

```promql
# Average CPU usage across all nodes grouped by node name
avg(rate(node_cpu_seconds_total{mode!="idle"}[5m])) by (instance)

# Total memory usage per namespace
sum(container_memory_usage_bytes) by (namespace)

# Pod restart count in last 5 minutes (useful for alerting)
increase(kube_pod_container_status_restarts_total[5m]) > 0

# Number of pods NOT in Running state
kube_pod_status_phase{phase!="Running"} == 1

# Deployment availability (desired vs available)
kube_deployment_status_replicas_available / kube_deployment_spec_replicas
```

### 📅 Time Range Selectors

```promql
# Look back 5 minutes
kube_pod_container_status_restarts_total[5m]

# Rate of increase over 10 minutes
rate(http_requests_total[10m])

# Increase over 1 hour
increase(kube_pod_container_status_restarts_total[1h])
```

> 💡 **Prometheus UI Tip:** Use the **autocomplete feature** in the Prometheus query box. Start typing `kube_` and it shows all available metrics — a great way to explore what data you have.

---

## 6. Live Demo — Pod Crash Monitoring with Prometheus

### 🎯 Goal
Create a pod that always crashes and watch Prometheus capture the crash metrics in real time.

### Step 1 — Create a Pod That Always Crashes

```bash
kubectl run busybox-crash \
  --image=busybox \
  --restart=Always \
  -- /bin/sh -c "exit 1"
```

> ⚠️ `exit 1` causes the container to fail immediately. Kubernetes will restart it, but with increasing back-off delays — this is **CrashLoopBackOff**.

### Step 2 — Watch the Pod Status

```bash
kubectl get pods -w
# NAME             READY   STATUS             RESTARTS   AGE
# busybox-crash    0/1     CrashLoopBackOff   3          2m
```

### Step 3 — Query in Prometheus

```promql
# Query 1: All restarts in default namespace
kube_pod_container_status_restarts_total{namespace="default"}

# Query 2: Only for our crashing pod
kube_pod_container_status_restarts_total{
  namespace="default",
  pod="busybox-crash"
}
```

### 📈 What You See in the Graph

```
Restarts
  8 |                              ●
  7 |                         ●
  6 |                    ●
  5 |               ●
  4 |          ●
  3 |     ●
  2 |  ●
  1 |●
  0 +---------------------------------> Time
    17:10  17:12  17:14  17:16  17:18
```

> 🔍 **CrashLoopBackOff Pattern:** The time between crashes **increases exponentially** (1m → 2m → 4m → 8m...). This is visible in the graph as the gaps between restart increments get wider over time.

### 🔄 The Full Data Flow (What Happened Behind the Scenes)

```
You ran: kubectl run busybox-crash
            │
            ▼
    Kubernetes API Server  ◀── KSM is watching this continuously
            │
            ▼
    Scheduler assigns pod to a Node
            │
            ▼
    Kubelet starts container → container exits with code 1
            │
            ▼
    Kubernetes marks pod as: CrashLoopBackOff
            │
            ▼
    KSM detects this state change from API Server
    → updates metric: kube_pod_container_status_restarts_total++
    → exposes it at /metrics endpoint
            │
            ▼
    Prometheus scrapes KSM /metrics every 15-30 seconds
    → stores {namespace="default", pod="busybox-crash"} = 3
    → stores again = 4 (next scrape)
            │
            ▼
    You query PromQL → see the graph → alert can fire
```

---

## 7. Grafana — Why It Exists & How to Use It

### 🧠 What is Grafana?

Grafana is an **open-source visualization and dashboard platform**. It is **NOT a monitoring tool** — it is a **front-end UI layer** that connects to monitoring tools (like Prometheus) and makes data beautiful and actionable.

### 🆚 Prometheus UI vs. Grafana

| Feature | Prometheus UI | Grafana |
|---------|--------------|---------|
| Graph type | Basic line charts | Rich charts, gauges, heatmaps, bar charts |
| Dashboards | No saved dashboards | Full dashboard management |
| Auth/RBAC | None | SSO, OAuth, LDAP, role-based access |
| Multiple data sources | Only Prometheus | Prometheus, InfluxDB, MySQL, Elasticsearch, CloudWatch, Loki, Jaeger, etc. |
| Alerting | Basic | Advanced (with notification channels) |
| Sharing | Not possible | Share dashboards via links or PDFs |
| Pre-built dashboards | None | Thousands via grafana.com/dashboards |

### 🔐 Authentication & Authorization in Grafana

This is a **huge advantage** of Grafana over raw Prometheus:

```
Grafana RBAC Roles:

Admin     → Can create/edit/delete dashboards, manage users, add data sources
Editor    → Can create and edit dashboards  
Viewer    → Can only VIEW dashboards (read-only)

Use Cases:
- Your Management team   → Viewer role (only see dashboards)
- DevOps team            → Editor/Admin role (create & manage dashboards)
- Dev team               → Viewer role (see their app metrics only)
- QA team                → Viewer role (specific dashboards only)
```

```
Grafana → Administration → Users → Add New User
         → Set role: Viewer / Editor / Admin

For SSO Integration:
Grafana → Administration → Authentication
         → SAML / OAuth / GitHub / Google / LDAP
```

### 🔌 Multiple Data Source Support

```yaml
# Grafana supports these data sources natively:

Metrics:
  - Prometheus
  - InfluxDB
  - Graphite
  - AWS CloudWatch

Logs:
  - Loki
  - Elasticsearch
  - Splunk

Tracing:
  - Jaeger
  - Zipkin
  - Tempo

Databases:
  - MySQL
  - PostgreSQL
```

> 🌍 **Real-World Benefit:** If your company migrates from Prometheus to another monitoring tool in 2 years, your **Grafana dashboards remain the same**. You just change the data source. Your team doesn't need to relearn the UI.

### 🔑 Accessing Grafana (Quick Reference)

```bash
# Get Grafana service
kubectl get svc -n monitoring | grep grafana

# Port forward (works on any K8s cluster)
kubectl port-forward svc/prometheus-grafana 3000:80 -n monitoring

# Access at: http://localhost:3000
# Default credentials:
# Username: admin
# Password: prom-operator
```

### 🗂️ Pre-Built Grafana Dashboards

The kube-prometheus-stack installs **pre-built dashboards** automatically. Key ones include:

| Dashboard | What it Shows |
|-----------|--------------|
| **Kubernetes / Nodes** | CPU, Memory, Disk per node |
| **Kubernetes / Pods** | Pod CPU, Memory, Network |
| **Kubernetes / Namespaces** | Resource usage by namespace |
| **Kubernetes / Persistent Volumes** | PVC usage and status |
| **Kubernetes / API Server** | API server request rates, errors |
| **Node Exporter / Full** | Deep OS-level node metrics |

> ⚠️ **Common Mistake:** When you first open a pre-built dashboard, you might see "No Data". Fix: Change the **data source dropdown** from "default" to **"Prometheus"** at the top of the dashboard.

---

## 8. Creating Custom Grafana Dashboards

### 🎯 When to Create Custom Dashboards

Pre-built dashboards cover infrastructure. But your **application-specific metrics** (pod restarts in a specific namespace, secret counts, custom SLIs) need **custom dashboards**.

### Step-by-Step: Create a Pod Restart Dashboard

**Step 1 — Open Grafana → Click "New" → "Dashboard"**

**Step 2 — Add a Panel → Select Data Source: Prometheus**

**Step 3 — Write the PromQL Query**

```promql
kube_pod_container_status_restarts_total{namespace="default"}
```

**Step 4 — Customize the Visualization**
- Change time range: Last 5 minutes, 30 minutes, 1 hour, 24 hours
- Set graph type: Time series (default)
- Add legend, units, thresholds

**Step 5 — Save the Dashboard**
```
Click "Save Dashboard" → Give it a name: "Pod Health - Default Namespace"
→ Save to folder: "Production Monitoring"
```

### 📊 Sample Dashboard Panel Queries for Production

```promql
# Panel 1: Total pod restarts in production namespace
sum(kube_pod_container_status_restarts_total{namespace="production"}) by (pod)

# Panel 2: Pods not in Running state
count(kube_pod_status_phase{phase!="Running", namespace="production"}) by (phase)

# Panel 3: Node CPU usage %
100 - (avg by (instance)(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)

# Panel 4: Node Memory usage %
(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100

# Panel 5: Number of secrets per namespace
kube_secret_info{namespace="production"}

# Panel 6: ConfigMap count
count(kube_configmap_info) by (namespace)
```

### 📥 Importing Community Dashboards

Instead of building from scratch, import battle-tested dashboards:

```
Grafana → Dashboards → Import
→ Enter Dashboard ID from grafana.com/grafana/dashboards

Popular IDs:
  - 315  → Kubernetes cluster monitoring (via Prometheus)
  - 6417 → Kubernetes Cluster (Prometheus)
  - 1860 → Node Exporter Full
  - 3119 → Kubernetes pod and cluster monitoring
  - 13770 → 1 Node Exporter for Prometheus Dashboard
```

### 🔌 Adding a New Data Source (e.g., InfluxDB)

```
Grafana → Connections → Data Sources → Add Data Source
→ Select: InfluxDB
→ Fill in:
    URL: http://influxdb-service:8086
    Database: mydb
    User: admin
    Password: ****
→ Save & Test
```

---

## 9. What's Coming in Day 4

### 📋 Preview of Day 4 Topics

#### 1. Custom Metrics (Application Instrumentation)

```python
# Example: A Python Flask app exposing custom metrics
from prometheus_client import Counter, Histogram, start_http_server

# Counter: number of HTTP requests
http_requests_total = Counter(
    'http_requests_total',
    'Total HTTP requests',
    ['method', 'endpoint', 'status']
)

# Histogram: request duration
http_request_duration = Histogram(
    'http_request_duration_seconds',
    'HTTP request duration in seconds',
    ['endpoint']
)
```

#### 2. Types of Metrics in Prometheus

| Type | Description | Example Use Case |
|------|-------------|-----------------|
| **Counter** | Always increases, never decreases | Total HTTP requests, total errors |
| **Gauge** | Can go up or down | Current CPU usage, active connections |
| **Histogram** | Samples observations into buckets | Request latency distribution |
| **Summary** | Like histogram but calculates quantiles client-side | P50, P95, P99 latency |

#### 3. Service Monitor

```yaml
# ServiceMonitor tells Prometheus WHICH services to scrape
# Without this, Prometheus would try to scrape all 10,000 services!

apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: payment-service-monitor
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: payment-service   # Only scrape services with this label
  endpoints:
  - port: metrics            # Port name on the service
    path: /metrics           # Endpoint to scrape
    interval: 30s            # How often to scrape
  namespaceSelector:
    matchNames:
    - production             # Only in production namespace
```

> 💡 **Why ServiceMonitor matters:** If you have 500 microservices but only 20 expose metrics, ServiceMonitor ensures Prometheus only watches those 20 — saving CPU and memory.

---

## 10. Common Mistakes & Best Practices

### ❌ Common Mistakes

| Mistake | Problem | Fix |
|---------|---------|-----|
| Not installing Node Exporter | No node-level metrics | Always include it in kube-prometheus-stack |
| Not installing Kube State Metrics | No pod/deployment state metrics | Always include it |
| Using port-forward in production | Not reliable, drops connections | Use Ingress with ALB controller on EKS |
| Storing metrics forever | Prometheus TSDB grows huge | Set `retention.time=15d` (default) |
| Querying without labels | Returns too many time series, slow | Always filter with `{namespace="..."}` |
| Giving everyone admin in Grafana | Security risk | Use RBAC — Viewer for most, Editor for DevOps |
| No alerting rules | Metrics collected but nobody notified | Set up AlertManager rules |

### ✅ Best Practices

```yaml
# 1. Set Prometheus retention period
prometheus:
  prometheusSpec:
    retention: 15d          # Keep 15 days of data
    retentionSize: 50GB     # Or limit by size

# 2. Use persistent storage for Prometheus
    storageSpec:
      volumeClaimTemplate:
        spec:
          storageClassName: gp2  # AWS EBS
          resources:
            requests:
              storage: 50Gi

# 3. Set resource limits to prevent Prometheus from eating your cluster
    resources:
      requests:
        cpu: 500m
        memory: 2Gi
      limits:
        cpu: 2000m
        memory: 8Gi
```

```promql
# Best Practice: Always test queries with small time ranges first
# Bad (too broad, slow):
kube_pod_container_status_restarts_total

# Good (filtered, fast):
kube_pod_container_status_restarts_total{
  namespace="production",
  pod=~"payment.*"
}[5m]
```

### 🔧 Debugging Tips

```bash
# 1. Check if Prometheus is scraping a target
# Go to: http://localhost:9090/targets
# Look for "State: UP" — if DOWN, check the /metrics endpoint manually

# 2. Check Prometheus config
kubectl get configmap prometheus-server -n monitoring -o yaml

# 3. Check if node-exporter is running on all nodes
kubectl get pods -n monitoring -l app=node-exporter -o wide

# 4. Check kube-state-metrics logs
kubectl logs -n monitoring -l app.kubernetes.io/name=kube-state-metrics

# 5. Verify a metric exists before writing a dashboard
# In Prometheus UI → type metric name → check if data comes back

# 6. Grafana shows "No Data"
# → Check data source is set to "Prometheus" (not "default")
# → Check time range (maybe data is older than selected range)
# → Test the query directly in Prometheus UI first
```

---

## 11. Interview Prep — Key Points

### 🎯 Most Asked Questions & Answers

**Q: What is the difference between Node Exporter and Kube State Metrics?**
> Node Exporter collects **infrastructure-level** metrics (CPU, memory, disk of EC2 nodes) and runs as a **DaemonSet**. Kube State Metrics collects **Kubernetes object-level** metrics (pod status, deployment replicas, restart counts) by querying the **API Server** and runs as a single **Deployment**.

**Q: Why does Node Exporter run as a DaemonSet?**
> Because it needs to collect metrics from the **local system files** (`/proc`, `/sys`) of each individual node. It cannot query these remotely — it must run **on every node**.

**Q: What is a Time Series Database?**
> A database that stores data points **indexed by time**. Prometheus stores metrics as `metric_name{labels} value @timestamp`. This allows you to query "what was the CPU usage of node-1 over the last 30 minutes?" which a traditional database cannot efficiently answer.

**Q: What is PromQL?**
> Prometheus Query Language — used to query the time series database. You can filter by labels (`{namespace="production"}`), aggregate with functions (`sum()`, `avg()`, `rate()`), and apply time ranges (`[5m]`).

**Q: Why use Grafana if Prometheus already has a UI?**
> Grafana provides: (1) **Better visualization** (multiple chart types, rich dashboards), (2) **RBAC/Authentication** (SSO, role-based access), (3) **Multiple data sources** (works with InfluxDB, Elasticsearch, CloudWatch — not just Prometheus), (4) **Pre-built dashboards** from the community.

**Q: What is ServiceMonitor?**
> A Kubernetes CRD (Custom Resource Definition) from the Prometheus Operator that tells Prometheus **which services to scrape**. Without it, Prometheus would need to be manually reconfigured every time a new service is deployed.

**Q: What is CrashLoopBackOff and how can Prometheus help detect it?**
> CrashLoopBackOff is when a container repeatedly fails and Kubernetes restarts it with increasing delays. Prometheus (via Kube State Metrics) tracks the metric `kube_pod_container_status_restarts_total`. You can set an alert: if restarts > 3 in 5 minutes, notify the team via Slack/PagerDuty.

### 📝 Key Metrics to Remember for Interviews

```promql
# Pod health
kube_pod_status_phase
kube_pod_container_status_restarts_total
kube_pod_container_status_ready

# Deployment health  
kube_deployment_status_replicas_available
kube_deployment_spec_replicas

# Node health
node_cpu_seconds_total
node_memory_MemAvailable_bytes
node_filesystem_avail_bytes

# Resource counts
kube_configmap_info
kube_secret_info
kube_namespace_status_phase
```

---

## 📝 Quick Revision Summary

```
Day 3 Key Takeaways:

1. Prometheus Architecture
   → Scrapes metrics from Node Exporter, KSM, Custom metrics
   → Stores in Time Series DB
   → Exposes via HTTP Server + PromQL

2. Node Exporter
   → Runs as DaemonSet on every node
   → Collects: CPU, Memory, Disk, Network
   → Endpoint: /metrics on port 9100

3. Kube State Metrics  
   → Runs as Deployment (single replica)
   → Talks to K8s API Server
   → Collects: Pod status, restarts, deployment state
   → Endpoint: /metrics on port 8080

4. PromQL
   → Query language for Prometheus
   → Supports: filtering (labels), aggregation (sum/avg), time ranges
   → Autocomplete available in Prometheus UI

5. Grafana
   → Visualization platform (NOT a monitoring tool)
   → Supports multiple data sources
   → RBAC for team-based access control
   → Pre-built + custom dashboards

6. Coming Next (Day 4):
   → Custom Metrics (instrumentation)
   → Metric types: Counter, Gauge, Histogram, Summary
   → ServiceMonitor CRD
```

---

> 📌 **Pro Tip:** Spend 15-20 minutes after reading these notes to go into your Prometheus UI and try 5 different PromQL queries using autocomplete. Then go to Grafana and create one custom dashboard. Hands-on practice is the fastest way to retain this.
