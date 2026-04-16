# 📊 Observability Zero to Hero — Episode 2: Metrics & Monitoring with Prometheus + Grafana

> **Series:** Observability Zero to Hero | **Episode:** 2 of N
> **Topics Covered:** Metrics, Monitoring, Prometheus Architecture, Node Exporter, kube-state-metrics, Grafana, AlertManager, EKS Setup

---

## 📌 Table of Contents

1. [What Are Metrics?](#1-what-are-metrics)
2. [What Is Monitoring?](#2-what-is-monitoring)
3. [Difference: Metrics vs Monitoring](#3-difference-metrics-vs-monitoring)
4. [Common Metrics in Real DevOps Work](#4-common-metrics-in-real-devops-work)
5. [What Is Prometheus?](#5-what-is-prometheus)
6. [Prometheus Architecture (Deep Dive)](#6-prometheus-architecture-deep-dive)
7. [Exporters: Node Exporter & kube-state-metrics](#7-exporters-node-exporter--kube-state-metrics)
8. [Application-Level Metrics (/metrics endpoint)](#8-application-level-metrics-metrics-endpoint)
9. [Installing Prometheus on EKS (with Helm)](#9-installing-prometheus-on-eks-with-helm)
10. [Grafana: Visualization Layer](#10-grafana-visualization-layer)
11. [AlertManager: Smart Alerting](#11-alertmanager-smart-alerting)
12. [Prometheus Competitors](#12-prometheus-competitors)
13. [PromQL Basics (Preview)](#13-promql-basics-preview)
14. [Best Practices, Common Mistakes & Debugging Tips](#14-best-practices-common-mistakes--debugging-tips)
15. [Quick Reference Summary](#15-quick-reference-summary)

---

## 1. What Are Metrics?

### 🏥 Real-Life Analogy (Hospital Patient)

Imagine a patient is admitted to a hospital. A nurse visits every 15–30 minutes and records:

| Time     | Heartbeat (bpm) | Blood Pressure |
|----------|-----------------|----------------|
| 10:00 AM | 76              | 120/80         |
| 10:15 AM | 81              | 122/82         |
| 10:30 AM | 62 ⚠️           | 118/78         |

- The doctor uses this **historical, periodic data** to understand the patient's health.
- Without this data, the doctor **cannot make informed decisions**.
- If the data shows a spike or drop at a specific time, the doctor knows something went wrong.

> This periodic, historical, time-stamped data is called a **Metric**.

### ✅ Definition

> **Metrics** = Historical data of events, collected periodically, used to understand the health and behavior of a system over time.

### 🔑 Key Characteristics of Metrics

| Property | Description |
|---|---|
| **Periodic** | Collected at regular intervals (every 15s, 1min, 5min) |
| **Numerical** | Always a number (CPU %, request count, memory bytes) |
| **Time-stamped** | Every data point has a timestamp |
| **Aggregatable** | Can be summed, averaged, or graphed over time |

### ⚠️ Problem with Raw Metrics

Raw metrics = numbers in a spreadsheet or log file.

```
10:00AM - CPU: 23%
10:01AM - CPU: 24%
10:02AM - CPU: 89%  ← You may MISS this spike in raw data!
10:03AM - CPU: 25%
```

Raw data is hard to read, easy to miss anomalies, not actionable by itself → That's where **Monitoring** comes in.

---

## 2. What Is Monitoring?

### 🖥️ Hospital Machine Analogy

Instead of a nurse manually checking every 30 seconds, a **machine is connected to the patient** that:
1. **Continuously reads** the heartbeat metrics
2. **Displays** them on a screen (graph/dashboard)
3. **Sounds an alarm** when heartbeat goes above 110 bpm

This machine = **Monitoring System**

### 📐 In the IT World

A **monitoring system**:
1. **Scrapes/pulls** metrics from various sources (or receives pushed metrics)
2. **Stores** them in a time-series database
3. **Visualizes** them as graphs and dashboards
4. **Fires alerts** when thresholds are breached

```
 [Application / Infrastructure]
           |
           |  (metrics scraped every 15s/30s/1min)
           ↓
   [Monitoring System]  ← Prometheus
           |
    ┌──────┼──────┐
    ↓      ↓      ↓
[Dashboard] [Alerts] [Storage]
 (Grafana)  (AlertMgr) (TSDB)
```

### 📈 Stock Market Dashboard Analogy

When you visit a stock market app and select **"Last 1 Month"** view — that graph is drawn from **historical metrics** collected every second/minute. The monitoring system takes raw numbers and renders them as meaningful visuals.

---

## 3. Difference: Metrics vs Monitoring

This is a **very commonly confused concept** — even in interviews.

| Aspect | Metrics | Monitoring |
|---|---|---|
| **What it is** | Raw numerical data points | System that uses metrics to provide insight |
| **Format** | Numbers with timestamps | Dashboards + Alerts + Storage |
| **Action** | Just data collection | Visualization + Alerting + Analysis |
| **Analogy** | Nurse's notebook of heartbeat readings | The ICU machine + alarm system |
| **Example tools** | `/metrics` endpoint, node_exporter | Prometheus, Grafana, CloudWatch |
| **Relationship** | Metrics is INPUT to Monitoring | Monitoring is SUPERSET of Metrics |

> 🧠 **Golden Rule:** Monitoring = Metrics + Dashboards + Alerts

---

## 4. Common Metrics in Real DevOps Work

In a real AWS + Kubernetes environment, metrics are grouped into **3 layers**:

### 🖥️ Layer 1: Infrastructure Metrics (AWS EC2 / Kubernetes Nodes)

| Metric | Why It Matters |
|---|---|
| CPU Utilization (%) | Node overload detection |
| Memory Usage (bytes/%) | OOM kill prevention |
| Disk I/O (read/write bytes) | Storage bottleneck detection |
| Network In/Out (bytes) | Bandwidth monitoring |
| Disk Utilization (%) | Alert before disk fills up |

**Real-world scenario:**
> "At 6 PM every evening our CPU shoots to 95% on 2 nodes — we discovered it was a batch job. We scheduled it to run at 2 AM instead."

### ☸️ Layer 2: Kubernetes Cluster Metrics

| Metric | Why It Matters |
|---|---|
| Pod Status (Running/Pending/Failed) | Detect broken deployments |
| CrashLoopBackOff count | App stability tracking |
| Deployment replicas (desired vs available) | Deployment health |
| HPA replica count over time | Auto-scaling behavior |
| ConfigMap/Secret changes | Audit trail |
| Node pressure (Memory/Disk/PID) | Scheduler health |

**Real-world scenario:**
> "Our pod was in CrashLoopBackOff 47 times between 2 AM–4 AM. The kube-state-metrics showed it spiked right after a new deployment. We rolled back."

### 🚀 Layer 3: Application-Level Metrics

| Metric | Why It Matters |
|---|---|
| HTTP requests/second | Traffic load monitoring |
| HTTP error rate (4xx, 5xx) | App health |
| Request latency (p50, p95, p99) | User experience |
| Active users | Business health |
| User signups per hour | Feature adoption |
| User deactivations | Churn detection |
| Time spent on platform | Engagement tracking |
| Payment failures | Revenue impact |

**Real-world scenario:**
> "Our /checkout endpoint latency went from 200ms to 2000ms at 5 PM. The HTTP request latency metric alerted us. We traced it to a slow DB query."

---

## 5. What Is Prometheus?

### 🔵 Overview

> **Prometheus** is the most popular **open-source monitoring system** in the Kubernetes ecosystem.

- A **CNCF (Cloud Native Computing Foundation)** graduated project
- The **second CNCF project after Kubernetes** itself
- Pull-based (scrape) monitoring by default
- Uses its own query language: **PromQL**
- Stores data in a **time-series database (TSDB)**
- Integrates tightly with **Grafana** for dashboards

### Why Prometheus Dominates in Kubernetes

- Native Kubernetes integration
- Massive community + ecosystem
- Works with **Helm** for easy installation
- Has a rich exporter ecosystem (100+ exporters)
- Many commercial tools (Datadog, New Relic, AWS CloudWatch) support Prometheus metrics format
- CNCF backing = long-term stability

---

## 6. Prometheus Architecture (Deep Dive)

```
┌─────────────────────────────────────────────────────────┐
│                    PROMETHEUS SERVER                     │
│                                                         │
│  ┌─────────────┐    ┌──────────────────────────────┐   │
│  │  RETRIEVAL  │◄───│   Service Discovery           │   │
│  │  (Scraper)  │    │   (K8s, file_sd, DNS, etc.)   │   │
│  └──────┬──────┘    └──────────────────────────────┘   │
│         │                                               │
│         ▼                                               │
│  ┌──────────────────┐                                   │
│  │  Time Series DB  │  ← Stores all scraped metrics     │
│  │  (TSDB / local)  │                                   │
│  └──────┬───────────┘                                   │
│         │                                               │
│  ┌──────▼──────┐    ┌────────────────┐                 │
│  │ HTTP Server │    │ Alert Manager  │                  │
│  │  (PromQL)   │    │ (Alerts/Notif) │                  │
│  └─────────────┘    └────────────────┘                 │
└─────────────────────────────────────────────────────────┘
         ▲                        ▲
         │                        │
┌────────┴──────────┐   ┌─────────┴──────────┐
│    Exporters       │   │    Push Gateway     │
│ - Node Exporter    │   │  (for short-lived   │
│ - kube-state-      │   │   jobs/batch jobs)  │
│   metrics          │   └────────────────────┘
│ - App /metrics     │
└────────────────────┘
         ▲
┌────────┴────────────────────────────┐
│  Your Infrastructure                │
│  - EC2 Nodes (Kubernetes Workers)   │
│  - Kubernetes API Server            │
│  - Your Applications                │
└─────────────────────────────────────┘
```

### 🔧 Components Explained

#### 1. Retrieval (Scraper)
- The **heart of Prometheus**
- Periodically **pulls (scrapes)** metrics from configured targets
- Default scrape interval: **15 seconds** (configurable)
- Uses **HTTP GET** to hit the `/metrics` endpoint of targets

#### 2. Time Series Database (TSDB)
- Stores metrics as **time + labels + value**
- Data format: `metric_name{label1="val1", label2="val2"} value timestamp`

```
# Example of how data is stored in TSDB
node_cpu_seconds_total{cpu="0", mode="idle", instance="10.0.1.5:9100"} 12345.67  1713200000
node_memory_MemAvailable_bytes{instance="10.0.1.5:9100"} 2147483648  1713200000
```

- Data is stored locally by default (on disk)
- Retention: **15 days** by default (configurable)

#### 3. HTTP Server
- Exposes a **REST API** for querying
- Powers the **Prometheus Web UI**
- Accepts **PromQL queries**
- Used by Grafana as a **data source**

#### 4. Alert Manager
- Separate component (but part of the stack)
- Receives alerts fired by Prometheus **alerting rules**
- Routes alerts to: **Slack, Email, PagerDuty, OpsGenie, webhook**, etc.
- Handles: deduplication, grouping, silencing, inhibition

#### 5. Push Gateway
- For **short-lived jobs** (batch jobs, cron jobs) that don't live long enough to be scraped
- The job **pushes** metrics to Push Gateway
- Prometheus **scrapes** Push Gateway
- Use case: A 30-second batch job completes before Prometheus can scrape it

#### 6. Service Discovery
- Tells Prometheus **which targets to scrape**
- In Kubernetes: automatically discovers Pods, Services, Nodes
- You don't manually list every pod IP — Kubernetes SD does it automatically

```yaml
# Example: Prometheus scrape config with Kubernetes SD
scrape_configs:
  - job_name: 'kubernetes-pods'
    kubernetes_sd_configs:
      - role: pod
    relabel_configs:
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
        action: keep
        regex: true
```

---

## 7. Exporters: Node Exporter & kube-state-metrics

Exporters are **plugins/add-ons** that collect metrics from specific sources and expose them in Prometheus format.

### 📦 Node Exporter

| Property | Detail |
|---|---|
| **Purpose** | Collects OS/hardware metrics from each Kubernetes node |
| **Deployed as** | DaemonSet (runs on every node) |
| **Port** | 9100 |
| **Source of data** | Linux `/proc` and `/sys` filesystem |

**Metrics it provides:**

```
node_cpu_seconds_total          → CPU usage per core/mode
node_memory_MemAvailable_bytes  → Available RAM
node_filesystem_avail_bytes     → Disk space remaining
node_network_receive_bytes_total → Network traffic in
node_load1                      → 1-minute load average
```

**Real-world scenario:**
> "Node exporter DaemonSet runs on all 5 worker nodes. At 3 AM, `node_filesystem_avail_bytes` dropped to 2% on node-3. AlertManager fired a Slack alert. We cleaned up old container images before the disk filled completely."

### ☸️ kube-state-metrics

| Property | Detail |
|---|---|
| **Purpose** | Exposes Kubernetes object state as metrics |
| **Data source** | Kubernetes API Server |
| **Deployed as** | Single Deployment |
| **Port** | 8080 |

**Metrics it provides:**

```
kube_pod_status_phase                   → Pod phase (Running/Pending/Failed)
kube_deployment_status_replicas_available → Available replicas
kube_node_status_condition              → Node conditions (Ready/NotReady)
kube_pod_container_status_restarts_total → Container restart count
kube_job_status_succeeded               → Job completion status
kube_horizontalpodautoscaler_status_current_replicas → HPA replica count
```

**Real-world scenario:**
> "`kube_pod_container_status_restarts_total` showed our payment service restarted 200+ times in 6 hours overnight. We set an alert: if restarts > 5 in 10 minutes → PagerDuty alert to on-call engineer."

### 🔄 Node Exporter vs kube-state-metrics

| | Node Exporter | kube-state-metrics |
|---|---|---|
| **What it monitors** | The physical/virtual machine (OS level) | Kubernetes objects (API level) |
| **Where it runs** | On every node (DaemonSet) | Single pod (Deployment) |
| **Data source** | `/proc`, `/sys` files | Kubernetes API Server |
| **Example metric** | CPU utilization % | Pod crash count |

---

## 8. Application-Level Metrics (/metrics endpoint)

### The Problem
Node Exporter and kube-state-metrics cover infrastructure and Kubernetes. But they **cannot know**:
- How many users signed up today
- How many HTTP 500 errors your `/checkout` API returned
- What's the p99 latency of your payment service

### The Solution: Instrument Your Application

Developers must add a **`/metrics` HTTP endpoint** to the application that exposes custom metrics in Prometheus format.

```python
# Python example using prometheus_client library
from prometheus_client import Counter, Histogram, start_http_server

# Define metrics
http_requests_total = Counter(
    'http_requests_total',
    'Total HTTP requests',
    ['method', 'endpoint', 'status_code']
)

request_duration = Histogram(
    'http_request_duration_seconds',
    'HTTP request duration',
    ['endpoint']
)

user_signups_total = Counter(
    'user_signups_total',
    'Total user signups'
)

# In your request handler:
@app.route('/signup', methods=['POST'])
def signup():
    with request_duration.labels('/signup').time():
        # ... business logic ...
        user_signups_total.inc()
        http_requests_total.labels('POST', '/signup', '200').inc()
        return jsonify({"status": "ok"})
```

**What Prometheus scrapes from `/metrics`:**

```
# HELP http_requests_total Total HTTP requests
# TYPE http_requests_total counter
http_requests_total{method="POST",endpoint="/signup",status_code="200"} 1523
http_requests_total{method="POST",endpoint="/signup",status_code="500"} 7

# HELP http_request_duration_seconds HTTP request duration
# TYPE http_request_duration_seconds histogram
http_request_duration_seconds_bucket{endpoint="/signup",le="0.1"} 1200
http_request_duration_seconds_bucket{endpoint="/signup",le="0.5"} 1500
http_request_duration_seconds_bucket{endpoint="/signup",le="+Inf"} 1523

# HELP user_signups_total Total user signups
# TYPE user_signups_total counter
user_signups_total 1523
```

### Prometheus Service Discovery for Applications

You tell Prometheus which apps to scrape using annotations:

```yaml
# Kubernetes Deployment with Prometheus scrape annotations
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payment-service
spec:
  template:
    metadata:
      annotations:
        prometheus.io/scrape: "true"      # ← Enable scraping
        prometheus.io/port: "8080"        # ← Port of /metrics
        prometheus.io/path: "/metrics"    # ← Path (default is /metrics)
    spec:
      containers:
        - name: payment-service
          image: my-payment-service:v1.2
          ports:
            - containerPort: 8080
```

### The 3 Layers Summary

```
┌─────────────────────────────────────────────────────┐
│             Prometheus Scrape Sources                │
│                                                     │
│  Layer 1: Infrastructure                            │
│  └── Node Exporter → CPU, RAM, Disk, Network        │
│                                                     │
│  Layer 2: Kubernetes Objects                        │
│  └── kube-state-metrics → Pod/Deploy/HPA status     │
│                                                     │
│  Layer 3: Application                               │
│  └── /metrics endpoint → Business + App metrics     │
└─────────────────────────────────────────────────────┘
```

---

## 9. Installing Prometheus on EKS (with Helm)

### Prerequisites
- EKS cluster running
- `kubectl` configured
- `helm` installed
- OIDC provider associated (needed for AWS service integration later)

### Step-by-Step Installation

**Step 1: Install Helm (if not installed)**

```bash
# On Linux/Mac
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Verify
helm version
```

**Step 2: Add Prometheus Helm Repository**

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

**Step 3: Create Monitoring Namespace**

```bash
kubectl create namespace monitoring
```

**Step 4: Create Custom Values File**

```yaml
# custom-values.yaml
alertmanager:
  enabled: true          # Enable AlertManager component

prometheus:
  prometheusSpec:
    retention: 15d       # Keep metrics for 15 days
    scrapeInterval: 15s  # Scrape every 15 seconds

grafana:
  enabled: true
  adminPassword: prom-operator  # Default password (change in production!)
```

**Step 5: Install the Helm Chart**

```bash
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  -f custom-values.yaml
```

**Step 6: Verify Installation**

```bash
kubectl get pods -n monitoring
```

**Expected output:**

```
NAME                                                  READY   STATUS    RESTARTS
alertmanager-prometheus-kube-prometheus-alertmanager-0  2/2   Running   0
prometheus-grafana-7d8c9b6f5-xk2pq                     3/3   Running   0
prometheus-kube-prometheus-operator-5d9b7c8f4-nm3qr    1/1   Running   0
prometheus-kube-prometheus-prometheus-0                 2/2   Running   0
prometheus-kube-state-metrics-6c8b9d7f5-pj4rs          1/1   Running   0
prometheus-prometheus-node-exporter-2xkqp               1/1   Running   0  ← node1
prometheus-prometheus-node-exporter-7mnbv               1/1   Running   0  ← node2
prometheus-prometheus-node-exporter-9qwrt               1/1   Running   0  ← node3
```

> 📝 **Note:** Node exporter appears once **per node** (DaemonSet behavior).

**Step 7: Access via Port Forwarding (Dev/Learning)**

```bash
# Prometheus UI → http://localhost:9090
kubectl port-forward svc/prometheus-kube-prometheus-prometheus \
  9090:9090 -n monitoring &

# Grafana UI → http://localhost:3000
kubectl port-forward svc/prometheus-grafana \
  3000:80 -n monitoring &

# AlertManager UI → http://localhost:9093
kubectl port-forward svc/prometheus-kube-prometheus-alertmanager \
  9093:9093 -n monitoring &
```

> ⚠️ **Production Note:** In production, use **Ingress + Ingress Controller** instead of port-forward. Port-forward is only for local/dev access.

**Step 8: Login to Grafana**

- URL: `http://localhost:3000`
- Username: `admin`
- Password: `prom-operator`

---

## 10. Grafana: Visualization Layer

### What Is Grafana?

> **Grafana** is an open-source **visualization and dashboarding** platform. It does NOT collect metrics itself — it reads from data sources like Prometheus.

```
Prometheus (stores metrics) ──data source──► Grafana (visualizes metrics)
```

### Why Grafana + Prometheus Together?

| Capability | Prometheus Alone | Prometheus + Grafana |
|---|---|---|
| Basic graphs | ✅ Simple | ✅ Rich, interactive |
| Dashboard templates | ❌ | ✅ 1000s of community dashboards |
| Multiple data sources | ❌ | ✅ Mix Prometheus + Loki + CloudWatch |
| Alerting UI | Basic | ✅ Rich alerting UI |
| User-friendly | ❌ Dev-oriented | ✅ Non-engineers can use it |
| Custom panels | Limited | ✅ Bar, Pie, Stat, Gauge, Heatmap |

### Adding Prometheus as Data Source in Grafana

```
Grafana UI → Connections → Add new connection → Search "Prometheus"
→ Provide URL: http://prometheus-kube-prometheus-prometheus.monitoring.svc:9090
→ Save & Test
```

Or via provisioning YAML:

```yaml
# grafana-datasource.yaml (provisioned automatically)
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    url: http://prometheus-kube-prometheus-prometheus.monitoring.svc:9090
    access: proxy
    isDefault: true
    jsonData:
      timeInterval: "15s"
```

---

## 11. AlertManager: Smart Alerting

### What Is AlertManager?

AlertManager receives **firing alerts** from Prometheus and routes them to the right people via the right channels.

### AlertManager Flow

```
Prometheus detects threshold breach
         ↓
Prometheus fires alert to AlertManager
         ↓
AlertManager: deduplicates + groups + routes
         ↓
Notification sent to:
 - Slack channel #devops-alerts
 - PagerDuty (on-call rotation)
 - Gmail / Email
 - Webhook (custom integrations)
```

### Example AlertManager Config

```yaml
# alertmanager-config.yaml
global:
  slack_api_url: 'https://hooks.slack.com/services/YOUR/SLACK/WEBHOOK'

route:
  receiver: 'slack-devops'
  group_by: ['alertname', 'cluster']
  group_wait: 30s       # Wait 30s before sending grouped alert
  group_interval: 5m    # How often to re-send grouped alerts
  repeat_interval: 4h   # Repeat if alert still firing after 4h
  routes:
    - match:
        severity: critical
      receiver: 'pagerduty-oncall'
    - match:
        severity: warning
      receiver: 'slack-devops'

receivers:
  - name: 'slack-devops'
    slack_configs:
      - channel: '#devops-alerts'
        text: '{{ range .Alerts }}{{ .Annotations.summary }}{{ end }}'

  - name: 'pagerduty-oncall'
    pagerduty_configs:
      - routing_key: 'YOUR_PAGERDUTY_ROUTING_KEY'
```

### Example Prometheus Alerting Rule

```yaml
# alerting-rules.yaml
groups:
  - name: infrastructure
    rules:
      # Alert if CPU > 80% for 5 minutes
      - alert: HighCPUUsage
        expr: (1 - avg by(instance)(rate(node_cpu_seconds_total{mode="idle"}[5m]))) * 100 > 80
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High CPU usage on {{ $labels.instance }}"
          description: "CPU usage is {{ $value }}% on {{ $labels.instance }}"

      # Alert if disk > 75%
      - alert: DiskSpaceLow
        expr: (1 - node_filesystem_avail_bytes / node_filesystem_size_bytes) * 100 > 75
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "Low disk space on {{ $labels.instance }}"

      # Alert if pod is crash looping
      - alert: PodCrashLooping
        expr: rate(kube_pod_container_status_restarts_total[15m]) * 60 * 15 > 5
        for: 0m
        labels:
          severity: critical
        annotations:
          summary: "Pod {{ $labels.namespace }}/{{ $labels.pod }} is crash looping"

      # Alert if HTTP error rate > 5%
      - alert: HighHTTPErrorRate
        expr: rate(http_requests_total{status_code=~"5.."}[5m]) / rate(http_requests_total[5m]) * 100 > 5
        for: 3m
        labels:
          severity: critical
        annotations:
          summary: "High error rate on {{ $labels.endpoint }}"
```

---

## 12. Prometheus Competitors

| Tool | Type | Strength | Use Case |
|---|---|---|---|
| **Prometheus** | Open Source | Kubernetes-native, CNCF | Standard for K8s monitoring |
| **Nagios** | Open Source | Traditional infra monitoring | Legacy systems, on-prem |
| **InfluxDB** | Open Source | High write throughput TSDB | IoT, high-frequency metrics |
| **Graphite** | Open Source | Simple, time-series | Legacy applications |
| **Datadog** | Commercial | Full observability platform | Enterprise, multi-cloud |
| **New Relic** | Commercial | APM + Infrastructure | Application performance |
| **AWS CloudWatch** | Commercial | AWS native | AWS-only environments |
| **Dynatrace** | Commercial | AI-driven monitoring | Enterprise auto-discovery |

### Why Prometheus Wins in Kubernetes

1. **CNCF Graduate Project** (same foundation as Kubernetes)
2. **2nd CNCF project after Kubernetes** — trusted & battle-tested
3. Huge **exporter ecosystem** (100+ exporters)
4. **Commercial tools adopt it**: Datadog, AWS, GCP all support Prometheus metrics format
5. Strong **community** → Stack Overflow, GitHub, Slack
6. Works perfectly with **Grafana** (also CNCF)
7. **OpenMetrics** standard built on Prometheus format

---

## 13. PromQL Basics (Preview)

PromQL = **Prometheus Query Language** — used to query the TSDB.

### Basic Queries

```promql
# Get current CPU usage per node
node_cpu_seconds_total

# Get memory available on all nodes
node_memory_MemAvailable_bytes

# Get pod restart count
kube_pod_container_status_restarts_total

# Filter by label
node_cpu_seconds_total{mode="idle"}

# Calculate CPU usage % over last 5 minutes
(1 - avg by(instance)(rate(node_cpu_seconds_total{mode="idle"}[5m]))) * 100

# HTTP request rate per second over last 5 min
rate(http_requests_total[5m])

# Error rate %
rate(http_requests_total{status_code=~"5.."}[5m]) 
  / rate(http_requests_total[5m]) * 100

# 99th percentile latency
histogram_quantile(0.99, rate(http_request_duration_seconds_bucket[5m]))
```

> 📝 Deep PromQL + Grafana dashboard building will be covered in the next episode.

---

## 14. Best Practices, Common Mistakes & Debugging Tips

### ✅ Best Practices

**Metrics Collection:**
- Always use **3 layers**: Node Exporter + kube-state-metrics + App `/metrics`
- Set **scrape_interval** based on criticality (15s for prod, 60s for dev)
- Use **labels** consistently: `{env="prod", app="payment", region="us-east-1"}`
- Don't over-collect: start with 20–30 key metrics, add more as needed
- Set **retention** based on compliance needs (default 15 days, often extended to 30–90 days in prod)

**Alerting:**
- Always set a `for:` duration to avoid **alert flapping** (noisy alerts from brief spikes)
- Use **severity labels**: `critical`, `warning`, `info`
- Route `critical` alerts to PagerDuty (wakes someone up), `warning` to Slack
- Add **runbook links** in alert annotations

**Grafana:**
- Use **community dashboards** from grafana.com/dashboards (Node Exporter ID: `1860`, K8s cluster: `7249`)
- Keep dashboards **role-specific**: infra team, app team, business team
- Use **variables** in dashboards to filter by namespace/pod/node

### ❌ Common Mistakes

| Mistake | Problem | Fix |
|---|---|---|
| Using port-forward in production | Not stable, breaks | Use Ingress + Ingress Controller |
| No `for:` in alert rules | Alert noise / flapping | Always add `for: 3m` or appropriate duration |
| Storing Grafana admin password in plain text | Security risk | Use Kubernetes Secret or Vault |
| Default Prometheus retention (15d) | Metrics lost after 15 days | Increase retention or use Thanos/Cortex for long-term |
| Scraping every pod in the cluster | Performance overhead | Use annotations/selectors to control which pods are scraped |
| Not setting resource limits on Prometheus | OOM kills in prod | Set memory/CPU requests and limits |
| Alerting on every spike | Alert fatigue | Use `for:` duration + rate() smoothing |

### 🐛 Debugging Tips

**Prometheus not scraping a target?**
```bash
# Check Prometheus targets UI
http://localhost:9090/targets  # Look for "DOWN" targets

# Check if /metrics endpoint is reachable
kubectl exec -it prometheus-pod -n monitoring -- \
  wget -O- http://your-service:8080/metrics

# Check pod annotations
kubectl get pod your-pod -o yaml | grep prometheus
```

**Pod not appearing in kube-state-metrics?**
```bash
# Check if kube-state-metrics is running
kubectl get pods -n monitoring | grep kube-state

# Query directly
kubectl port-forward svc/prometheus-kube-state-metrics 8080:8080 -n monitoring
curl http://localhost:8080/metrics | grep kube_pod
```

**Grafana can't connect to Prometheus?**
```bash
# Use the internal K8s service DNS, not localhost
# Correct URL:
http://prometheus-kube-prometheus-prometheus.monitoring.svc.cluster.local:9090

# Wrong (won't work inside cluster):
http://localhost:9090
```

**AlertManager not sending notifications?**
```bash
# Check AlertManager config is valid
kubectl exec -it alertmanager-pod -n monitoring -- amtool check-config /etc/alertmanager/config.yml

# Check firing alerts
http://localhost:9093/#/alerts
```

---

## 15. Quick Reference Summary

```
┌─────────────────────────────────────────────────────────────────┐
│                    EPISODE 2 SUMMARY                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  METRICS = Periodic, time-stamped, numerical data points        │
│  MONITORING = Metrics + Dashboards + Alerts (SUPERSET)          │
│                                                                 │
│  PROMETHEUS = Open-source monitoring (CNCF) for Kubernetes      │
│    ├── Retrieval → Scrapes metrics from targets                 │
│    ├── TSDB → Stores time-series data locally                   │
│    ├── HTTP Server → Serves PromQL queries                      │
│    ├── AlertManager → Routes alerts to Slack/PD/Email           │
│    ├── Push Gateway → For short-lived batch jobs                │
│    └── Service Discovery → Auto-discovers K8s targets           │
│                                                                 │
│  EXPORTERS (3 Primary):                                         │
│    1. Node Exporter → CPU/RAM/Disk on each node                 │
│    2. kube-state-metrics → K8s object state (pods/deploys)      │
│    3. App /metrics endpoint → Custom business metrics           │
│                                                                 │
│  GRAFANA = Visualization layer on top of Prometheus             │
│                                                                 │
│  INSTALL: helm install prometheus                               │
│           prometheus-community/kube-prometheus-stack            │
│           --namespace monitoring -f custom-values.yaml          │
│                                                                 │
│  ACCESS (dev only):                                             │
│    Prometheus:    kubectl port-forward ... 9090:9090            │
│    Grafana:       kubectl port-forward ... 3000:80              │
│    AlertManager:  kubectl port-forward ... 9093:9093            │
│    Grafana login: admin / prom-operator                         │
└─────────────────────────────────────────────────────────────────┘
```

---

## 📚 Reference Links

| Resource | Link |
|---|---|
| Course Repository | `github.com/[instructor]/observability-zero-to-hero` → `day2/` folder |
| Prometheus Docs | https://prometheus.io/docs |
| kube-prometheus-stack Helm | https://github.com/prometheus-community/helm-charts |
| Grafana Community Dashboards | https://grafana.com/grafana/dashboards |
| Node Exporter Dashboard | Grafana Dashboard ID: `1860` |
| K8s Cluster Dashboard | Grafana Dashboard ID: `7249` |
| PromQL Basics | https://prometheus.io/docs/prometheus/latest/querying/basics |

---

## 🔮 What's Coming Next (Episode 3 Preview)

- Writing **PromQL queries** in depth
- Exploring **kube-state-metrics** and **node exporter** metrics live
- Building **Grafana dashboards** from scratch
- Importing **community dashboards**
- Setting up **Ingress** for production access (replacing port-forward)
- Configuring **AlertManager** with Slack integration

---

> 💡 **Interview Tips:**
> - "Monitoring is a superset of metrics" — this distinction is frequently tested
> - Know the **3 scrape layers**: Node Exporter, kube-state-metrics, app /metrics
> - Understand why `for:` is critical in alerting rules (prevents flapping)
> - Prometheus is **pull-based** by default; Push Gateway handles the push pattern
> - Prometheus is the **2nd CNCF project** after Kubernetes — shows maturity/trust
