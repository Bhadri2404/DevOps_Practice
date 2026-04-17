# 📘 Observability Zero to Hero — Complete Notes Days 2 to 7
### Beginner-Friendly | Every Concept from Every Transcript Included

---

## 🗺️ Series Roadmap

```
Day 2 → What is Metrics, Monitoring & Prometheus Setup
Day 3 → Prometheus Architecture + PromQL + Grafana
Day 4 → Custom Metrics Instrumentation + AlertManager
Day 5 → Logging + EFK Stack
Day 6 → Distributed Tracing + Jaeger
Day 7 → End-to-End Project with OpenTelemetry Demo App
```

---

# 📗 DAY 2 — Metrics, Monitoring & Prometheus

## What is Observability — Quick Recap

Before jumping into metrics, remember from Day 1:

> Observability is how well you can understand what is happening inside your system just by looking at the data it produces from the outside.

There are **three pillars of observability:**
```
1. Metrics  → What is the state of the system?
2. Logs     → Why is something failing?
3. Traces   → How to find and fix the root cause?
```

In Day 2, we focus on the **first pillar — Metrics.**

---

## What is a Metric?

A **metric** is simply a **number** that represents the state of your system at a given point in time.

```
Real examples of metrics:
  → CPU usage of your server is 80%
  → Your application pod restarted 3 times today
  → 500 HTTP errors happened in the last 1 minute
  → Memory usage is 4GB out of 8GB total
  → Disk usage is at 70%
```

> Think of metrics like your **car dashboard.** The speedometer shows speed, the fuel gauge shows fuel level, the temperature meter shows engine heat. All of these are metrics. They tell you the health of your car at any point in time. If a metric crosses a limit, a warning light turns on — that is your alert.

---

## What is Monitoring?

**Monitoring** means continuously watching these numbers over time and alerting someone when something goes wrong or when a number crosses a threshold.

```
Without Monitoring (what happens in reality):
  → Your server runs out of memory at 3 AM
  → The application crashes
  → Nobody knows about it
  → Customers start complaining at 9 AM
  → You wake up, check, realize it happened 6 hours ago
  → You lost 6 hours of business and customer trust

With Monitoring (what should happen):
  → Memory hits 85% at 2:50 AM
  → Alert fires to your phone immediately
  → You wake up, scale the server or restart the service
  → Application never actually crashes
  → Customers never face any issue
```

---

## Why Monitoring is Important in the World of Microservices

In the old days, you had one big application running on one server. If something went wrong, you checked that one server.

Today, in the world of **microservices**, you might have:

```
Your application on Kubernetes:
  → 50 microservices
  → Running across 10 nodes
  → Deployed in 3 different namespaces
  → Hundreds of pods running at the same time

Question: If something goes wrong, how do you know:
  → Which microservice is failing?
  → Which node is running out of CPU?
  → Which pod is restarting repeatedly?

Answer: You need a proper monitoring system.
That monitoring system in the Kubernetes world is PROMETHEUS.
```

---

## What is Prometheus?

**Prometheus** is a free and open-source monitoring tool. It is the **most popular monitoring tool in the Kubernetes and cloud-native world.**

Prometheus does these things:
1. **Collects (scrapes) metrics** from your applications and servers automatically
2. **Stores** them in its own special database called a Time Series Database
3. **Lets you query** those stored metrics using a language called PromQL
4. **Supports alerting** through a component called AlertManager

```
Simple way to understand Prometheus:

Think of Prometheus like a security guard in a big office building:
  → The guard walks around every 15 seconds
  → Checks the temperature, power, water levels of every room
  → Writes down all the numbers in a notebook (database)
  → If any number is dangerous, guard raises an alarm (alert)
  → You can ask the guard: "What was room 5 temperature at 3 PM?"
  → Guard checks the notebook and gives you the answer
```

---

## How Prometheus Collects Metrics — The Scraping Concept

Prometheus uses a **pull mechanism** — it goes and pulls (scrapes) the metrics from your applications. It does not wait for applications to send it data.

```
How scraping works:
  → Every application or exporter exposes a /metrics endpoint
  → Prometheus visits that endpoint every 15-30 seconds
  → It reads all the numbers from that endpoint
  → It stores those numbers with a timestamp in its database

Example:
  → Node Exporter is running on your server
  → It exposes data at http://node-ip:9100/metrics
  → Prometheus scrapes this URL every 15 seconds
  → Gets CPU = 75%, Memory = 4GB, Disk = 60%
  → Stores all these with timestamp
```

---

## Prometheus Architecture — Full Explanation

```
┌──────────────────────────────────────────────────────────────────┐
│                    KUBERNETES CLUSTER                             │
│                                                                   │
│  ┌──────────────────┐      ┌──────────────────────────────────┐  │
│  │   NODE EXPORTER  │      │      KUBE STATE METRICS          │  │
│  │  (DaemonSet)     │      │      (Deployment)                │  │
│  │                  │      │                                  │  │
│  │  Reads data from │      │  Talks to Kubernetes API Server  │  │
│  │  /proc and /sys  │      ��  Gets pod status, restarts,      │  │
│  │  of each node    │      │  deployment replicas, etc.       │  │
│  │                  │      │                                  │  │
│  │  Exposes at:     │      │  Exposes at:                     │  │
│  │  :9100/metrics   │      │  :8080/metrics                   │  │
│  └─────────┬────────┘      └──────────────┬───────────────────┘  │
│            │                              │                       │
│            └──────────────┬───────────────┘                       │
│                           │                                       │
│                           │ Prometheus scrapes every 15-30 sec   │
│                           ▼                                       │
│                 ┌─────────────────────┐                          │
│                 │     PROMETHEUS      │                          │
│                 │                     │                          │
│                 │  Time Series DB     │                          │
│                 │  (stores all data)  │                          │
│                 │                     │                          │
│                 │  HTTP Server        │ ◀── PromQL queries       │
│                 │  (query API)        │                          │
│                 └─────────┬───────────┘                          │
│                           │                                       │
│                           ▼                                       │
│                  Prometheus UI (port 9090)                        │
│                  or Grafana Dashboards                            │
└──────────────────────────────────────────────────────────────────┘
```

---

## Node Exporter — What It Is and What It Does

**Node Exporter** is a Prometheus exporter that collects metrics from your **Kubernetes worker nodes** (which are EC2 instances on AWS).

```
Node Exporter collects:
  → CPU usage per core
  → Memory usage (total, free, used, cached)
  → Disk usage and I/O
  → Network traffic (bytes in and out)
  → System load averages
  → Running processes
```

**Why does Node Exporter run as a DaemonSet?**

```
Node Exporter reads data from local system files:
  → /proc (process information)
  → /sys (system hardware information)

These files only exist ON that specific node.
You cannot read them remotely from another machine.

So Node Exporter MUST run physically ON every node.

DaemonSet = one pod automatically on every node.
If you have 3 nodes → 3 Node Exporter pods
If you add a 4th node → 4th Node Exporter pod added automatically
```

---

## Kube State Metrics — What It Is and What It Does

**Kube State Metrics** is an exporter that talks to the **Kubernetes API Server** and collects metrics about the state of Kubernetes objects.

```
Kube State Metrics collects:
  → Pod status (Running, Pending, Failed, CrashLoopBackOff)
  → Container restart counts
  → Deployment desired vs available replicas
  → ReplicaSet status
  → Service endpoint counts
  → ConfigMap and Secret information
  → Node readiness
  → PersistentVolumeClaim status
```

**Why does Kube State Metrics run as a Deployment (not DaemonSet)?**

```
Kube State Metrics talks to the Kubernetes API Server.
The API Server is a centralized component — there is only one.
You only need to talk to it once from one place.

So one single instance of Kube State Metrics is enough.
No need to run on every node.

Deployment = runs one (or more) pods anywhere in the cluster.
```

---

## The Key Difference — Visualized

```
NODE EXPORTER                    KUBE STATE METRICS
─────────────────                ──────────────────
Reads from:                      Reads from:
Local node files                 Kubernetes API Server
(/proc, /sys)                    (central location)

Knows about:                     Knows about:
Server hardware                  Kubernetes objects
CPU, Memory, Disk                Pods, Deployments, Services

Runs as:                         Runs as:
DaemonSet                        Deployment
(one per node)                   (one total)

Example question it answers:     Example question it answers:
"What is the CPU of node-1?"     "How many times did pod-x restart?"
```

> 💡 **Important Point from the video:** Without Node Exporter and Kube State Metrics, Prometheus is nearly blind. These two are the backbone of Kubernetes observability. Always make sure both are installed.

---

## Installing Prometheus Using Helm

The easiest way to install Prometheus along with all its related tools is using the **kube-prometheus-stack** Helm chart. This one chart installs:

```
kube-prometheus-stack installs:
  ✅ Prometheus          → Collects and stores metrics
  ✅ Grafana             → Dashboards and visualization
  ✅ AlertManager        → Sends alerts via email/Slack
  ✅ Node Exporter       → Collects node-level metrics
  ✅ Kube State Metrics  → Collects Kubernetes object metrics
  ✅ Pre-built dashboards → Ready to use without any extra work
```

```bash
# Step 1: Add the Prometheus community Helm repository
helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts

# Step 2: Update the repository to get latest charts
helm repo update

# Step 3: Install the complete stack in 'monitoring' namespace
helm install prometheus \
  prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace

# Step 4: Verify all pods are running
kubectl get pods -n monitoring

# You should see these pods:
# prometheus-prometheus-0               ← Main Prometheus
# prometheus-grafana-xxx                ← Grafana dashboard
# prometheus-alertmanager-0             ← AlertManager
# prometheus-node-exporter-xxx          ← Per node (DaemonSet)
# prometheus-kube-state-metrics-xxx     ← One instance
```

---

## Accessing Prometheus, Grafana and AlertManager

```bash
# Access Prometheus UI
kubectl port-forward svc/prometheus-operated 9090:9090 -n monitoring
# Open: http://localhost:9090

# Access Grafana UI
kubectl port-forward svc/prometheus-grafana 3000:80 -n monitoring
# Open: http://localhost:3000
# Default Username: admin
# Default Password: prom-operator

# Access AlertManager UI
kubectl port-forward \
  svc/prometheus-kube-prometheus-alertmanager 9093:9093 -n monitoring
# Open: http://localhost:9093
```

---

## 🎤 Day 2 Interview Questions & Answers

**Q1: What is Prometheus and what does it do?**

> Prometheus is an open-source monitoring tool that is very popular in the Kubernetes world. It collects metrics like CPU, memory, and pod restarts from applications and servers by scraping their /metrics endpoints every 15-30 seconds. It stores this data in a time-series database and lets you query it using PromQL. It also works with AlertManager to send alerts when something goes wrong.

**Q2: What is the difference between Node Exporter and Kube State Metrics?**

> Node Exporter collects hardware and OS-level metrics from each Kubernetes worker node like CPU, memory, and disk usage. It must run on every node so it is deployed as a DaemonSet. Kube State Metrics talks to the Kubernetes API Server and collects metrics about Kubernetes objects like pod restart counts, deployment replica counts, and ConfigMap counts. Since it only needs to talk to the API Server once, it runs as a single Deployment.

**Q3: Why does Node Exporter run as a DaemonSet and not a Deployment?**

> Node Exporter reads data from the local system files of each node like /proc and /sys. These files only exist locally on each node and cannot be read from another machine remotely. So Node Exporter must physically run on every single node. A DaemonSet automatically ensures one pod runs on each node in the cluster.

**Q4: What does kube-prometheus-stack install?**

> It installs Prometheus for metric collection and storage, Grafana for visualization and dashboards, AlertManager for sending alerts, Node Exporter for node-level metrics, and Kube State Metrics for Kubernetes object metrics — all with a single Helm install command.

**Q5: What is the scraping mechanism in Prometheus?**

> Prometheus uses a pull mechanism. It does not wait for applications to send it data. Instead, it actively goes and visits the /metrics endpoint of each application or exporter every 15-30 seconds, reads the numbers, and stores them with a timestamp in its database. This is called scraping.

---

# 📗 DAY 3 — Prometheus Architecture in Practice + PromQL + Grafana

## Recap of What We Learned So Far

In Day 2 we installed the Prometheus stack and learned about Node Exporter and Kube State Metrics. In Day 3, we go deeper — we actually see the metrics, query them using PromQL, and use Grafana.

---

## Verifying Node Exporter is Working

Node Exporter exposes all metrics at a /metrics endpoint. You can verify it is working by hitting that endpoint directly.

```bash
# Step 1: Find the Node Exporter service and its ClusterIP
kubectl get svc -n monitoring | grep node-exporter
# prometheus-node-exporter  ClusterIP  10.100.x.x  9100/TCP

# Step 2: SSH into a Kubernetes node
# On AWS EKS: Go to EC2 Console → Select node → Connect → Session Manager
# On Minikube: minikube ssh

# Step 3: Hit the /metrics endpoint from inside the node
curl http://10.100.x.x:9100/metrics
```

**What you see when you hit the /metrics endpoint:**

```
# HELP node_cpu_seconds_total Seconds the CPUs spent in each mode
# TYPE node_cpu_seconds_total counter
node_cpu_seconds_total{cpu="0",mode="idle"} 12345.67
node_cpu_seconds_total{cpu="0",mode="user"} 234.56

# HELP node_memory_MemAvailable_bytes Memory available in bytes
# TYPE node_memory_MemAvailable_bytes gauge
node_memory_MemAvailable_bytes 2500000000

# HELP node_filesystem_size_bytes Filesystem size in bytes
node_filesystem_size_bytes{device="/dev/xvda1",mountpoint="/"} 21474836480
```

> 💡 **Important Point from the video:** Every exporter exposes a /metrics endpoint. This is the standard contract between exporters and Prometheus. Prometheus always knows to go to /metrics to get the data. This is the same for every exporter — Node Exporter, Kube State Metrics, custom application metrics, all of them.

---

## Verifying Kube State Metrics is Working

```bash
# Step 1: Find Kube State Metrics service
kubectl get svc -n monitoring | grep kube-state
# kube-state-metrics  ClusterIP  10.100.y.y  8080/TCP

# Step 2: Hit the /metrics endpoint from inside a node
curl http://10.100.y.y:8080/metrics

# Step 3: Filter for specific metrics using grep
# Find container restart info
curl http://10.100.y.y:8080/metrics | grep "restart"
```

**Sample output from Kube State Metrics:**

```
# HELP kube_pod_container_status_restarts_total
# Total restarts of a container
kube_pod_container_status_restarts_total{
  namespace="default",
  pod="my-app-7d9f8b-xk2p1",
  container="my-app"
} 3

# HELP kube_deployment_status_replicas_available
kube_deployment_status_replicas_available{
  namespace="production",
  deployment="payment-service"
} 3
```

---

## What is a Time Series Database?

Prometheus stores all its data in a **Time Series Database (TSDB).**

Let's understand what makes it different from a normal database.

**Normal Database (like MySQL):**
```
| employee_name | salary |
|---------------|--------|
| John          | 50000  |
| Jane          | 60000  |
Just stores current values. No history.
```

**Time Series Database (Prometheus):**
```
metric_name{labels}  value  @timestamp

cpu_usage{node="worker-1"}  45.2  @1700000000
cpu_usage{node="worker-1"}  47.8  @1700000015
cpu_usage{node="worker-1"}  43.1  @1700000030
cpu_usage{node="worker-1"}  89.5  @1700000045  ← spike!
cpu_usage{node="worker-1"}  91.2  @1700000060  ← still high!

Stores values OVER TIME with timestamps.
```

> 💡 **Why time matters:** A single CPU reading of 80% means nothing. But CPU at 80% for 30 consecutive minutes means your node is in serious trouble. Time series data lets you see trends, patterns, and spikes over time — which is essential for monitoring.

**Every metric in Prometheus has this format:**

```
metric_name{label1="value1", label2="value2"}  numeric_value

Example:
kube_pod_container_status_restarts_total{
  namespace="default",
  pod="busybox-crash",
  container="busybox-crash"
} 8

Breaking it down:
  metric_name  = kube_pod_container_status_restarts_total
  namespace    = default       ← label
  pod          = busybox-crash ← label
  container    = busybox-crash ← label
  value        = 8             ← numeric value
```

---

## PromQL — Prometheus Query Language

**PromQL** is the query language of Prometheus. Just like SQL is used to query a MySQL database, PromQL is used to query the Prometheus time series database.

Prometheus has an **HTTP Server** running on port 9090 with a UI where you type PromQL queries and see results.

### Basic PromQL Syntax

```
metric_name{label_selector="value"}
```

### PromQL Examples — From Simple to Useful

```promql
# Get ALL container restarts across all namespaces
kube_pod_container_status_restarts_total

# Filter: only restarts in 'default' namespace
kube_pod_container_status_restarts_total{namespace="default"}

# Filter: restarts for a specific pod
kube_pod_container_status_restarts_total{
  namespace="default",
  pod="my-app-xyz"
}

# Init container restarts
kube_pod_init_container_status_restarts_total

# Number of ConfigMaps in kube-system namespace
kube_configmap_created{namespace="kube-system"}

# Node CPU usage
node_cpu_seconds_total{mode="idle"}

# Available memory on nodes
node_memory_MemAvailable_bytes
```

> 💡 **Tip from the video:** Use the **autocomplete feature** in the Prometheus query box. Start typing `kube_` and it shows all available metrics. This is the best way to explore what data you have without memorizing all metric names.

### PromQL Aggregation Functions

These are very important for real-world use. Raw metrics are hard to read — aggregations make them meaningful.

```promql
# sum() → Total across all labels
sum(kube_pod_container_status_restarts_total)

# avg() → Average value
avg(node_memory_MemAvailable_bytes)

# max() → Highest value
max(node_cpu_seconds_total)

# min() → Lowest value
min(node_memory_MemAvailable_bytes)

# count() → Count of time series
count(kube_pod_info)

# rate() → Per-second rate of increase (for counters)
rate(http_requests_total[5m])
```

### Time Range Selectors in PromQL

```promql
# Look at data over last 5 minutes
kube_pod_container_status_restarts_total[5m]

# Rate of increase over 10 minutes
rate(http_requests_total[10m])

# How much did restarts increase in last 1 hour
increase(kube_pod_container_status_restarts_total[1h])
```

---

## Live Demo — Creating a Crashing Pod and Watching Prometheus

This is a hands-on demo from the video. We create a pod that always crashes and watch Prometheus capture it.

**Step 1 — Create a Pod That Always Crashes**

```bash
kubectl run busybox-crash \
  --image=busybox \
  --restart=Always \
  -- /bin/sh -c "exit 1"

# exit 1 means the container immediately fails
# Kubernetes restarts it automatically
# But it keeps crashing → this is CrashLoopBackOff
```

**Step 2 — Watch the Pod Status**

```bash
kubectl get pods -w
# NAME             READY   STATUS             RESTARTS   AGE
# busybox-crash    0/1     CrashLoopBackOff   3          2m
```

**Step 3 — Query in Prometheus UI**

```promql
# Query all restarts in default namespace
kube_pod_container_status_restarts_total{namespace="default"}

# Query specifically for our crashing pod
kube_pod_container_status_restarts_total{
  namespace="default",
  pod="busybox-crash"
}
```

**What the Graph Looks Like:**

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
  0 +-------------------------------------> Time
    17:10  17:12  17:14  17:16  17:18
```

> 💡 **CrashLoopBackOff Pattern:** Notice the gaps between restarts get wider over time. This is because Kubernetes adds a backoff delay — 1 min, 2 min, 4 min, 8 min and so on. This is visible in the graph as increasing gaps. This is exactly what CrashLoopBackOff means.

**The Complete Flow — What Happened Behind the Scenes:**

```
You ran: kubectl run busybox-crash
              │
              ▼
    Kubernetes API Server
    Kube State Metrics is watching this!
              │
              ▼
    Kubelet starts container
    Container runs exit 1 and dies immediately
              │
              ▼
    Kubernetes marks pod: CrashLoopBackOff
              │
              ▼
    Kube State Metrics detects this state change
    Updates metric: kube_pod_container_status_restarts_total++
    Exposes at its /metrics endpoint
              │
              ▼
    Prometheus scrapes KSM /metrics every 15-30 seconds
    Stores the new restart count with timestamp
              │
              ▼
    You query PromQL → see the graph rising
```

---

## Grafana — What It Is and Why You Need It

**Grafana** is an open-source visualization and dashboard platform. It is **not a monitoring tool** — it is a **front-end UI** that connects to monitoring tools like Prometheus and makes data look beautiful and easy to understand.

**Why Grafana when Prometheus already has a UI?**

```
Prometheus UI:
  → Basic line charts only
  → No saved dashboards
  → No authentication or user management
  → Only works with Prometheus data
  → Cannot share dashboards with team

Grafana:
  → Rich charts: gauges, heatmaps, bar charts, tables
  → Full dashboard management with saved dashboards
  → SSO, OAuth, LDAP, role-based access control
  → Works with Prometheus, MySQL, Elasticsearch,
    CloudWatch, Loki, Jaeger, and many more
  → Share dashboards with links or PDFs
  → Thousands of pre-built community dashboards
```

### Authentication and Authorization in Grafana

This is a **huge advantage** of Grafana over using raw Prometheus:

```
Grafana RBAC (Role-Based Access Control):

Admin   → Can create/edit/delete dashboards, manage users
Editor  → Can create and edit dashboards
Viewer  → Can ONLY VIEW dashboards (read-only, cannot edit)

Real-world usage:
  Management team   → Viewer (only see dashboards)
  DevOps team       → Admin (create and manage)
  Dev team          → Viewer (see their app metrics)
  QA team           → Viewer (specific dashboards only)

How to add users:
  Grafana → Administration → Users → Add New User → Set Role
```

### Multiple Data Sources in Grafana

Grafana can connect to many different tools — not just Prometheus:

```
Metrics:    Prometheus, InfluxDB, Graphite, AWS CloudWatch
Logs:       Loki, Elasticsearch, Splunk
Tracing:    Jaeger, Zipkin, Tempo
Databases:  MySQL, PostgreSQL
```

> 💡 **Real-World Benefit from the video:** If your company migrates from Prometheus to another monitoring tool in 2 years, your Grafana dashboards stay the same. You just change the data source. Your team does not need to relearn anything.

### Accessing Grafana

```bash
# Port forward Grafana
kubectl port-forward svc/prometheus-grafana 3000:80 -n monitoring

# Access at: http://localhost:3000
# Default Username: admin
# Default Password: prom-operator
```

### Pre-Built Dashboards in Grafana

The kube-prometheus-stack automatically installs pre-built dashboards:

```
Kubernetes / Nodes         → CPU, Memory, Disk per node
Kubernetes / Pods          → Pod CPU, Memory, Network
Kubernetes / Namespaces    → Resource usage by namespace
Kubernetes / API Server    → API server request rates
Node Exporter / Full       → Deep OS-level node metrics
```

> ⚠️ **Common Problem from the video:** When you first open a pre-built dashboard, you might see "No Data". Fix: Change the data source dropdown from "default" to "Prometheus" at the top of the dashboard.

### Creating Custom Grafana Dashboards

```
Step 1: Open Grafana → Click "New" → "Dashboard"
Step 2: Add a Panel → Select Data Source: Prometheus
Step 3: Write your PromQL query

Example query:
kube_pod_container_status_restarts_total{namespace="default"}

Step 4: Choose visualization type (Time series, Gauge, Bar chart)
Step 5: Set time range (Last 5 min, 30 min, 1 hour, 24 hours)
Step 6: Click "Save Dashboard" → Give it a name
```

### Importing Community Dashboards

Instead of building from scratch, you can import dashboards that others have already made:

```
Grafana → Dashboards → Import → Enter Dashboard ID

Popular Dashboard IDs:
  315   → Kubernetes cluster monitoring
  6417  → Kubernetes Cluster (Prometheus)
  1860  → Node Exporter Full
  3119  → Kubernetes pod and cluster monitoring
```

---

## 🎤 Day 3 Interview Questions & Answers

**Q1: What is PromQL and when do you use it?**

> PromQL is the Prometheus Query Language. Just like SQL is used to query a relational database, PromQL is used to query data from the Prometheus time-series database. You use it to filter metrics by labels, aggregate data using functions like sum, avg, and rate, and apply time ranges to get trends. You write PromQL queries in the Prometheus UI or in Grafana dashboard panels.

**Q2: What is a Time Series Database and why does Prometheus use it?**

> A Time Series Database stores data points indexed by time. Unlike a normal database that only stores the current value, a TSDB stores every value along with its timestamp. Prometheus stores metrics in this format so you can ask questions like "what was CPU usage over the last 30 minutes?" or "when did pod restarts start increasing?" A single data point means nothing for monitoring — you need history to identify trends and patterns.

**Q3: What is Grafana and how is it different from Prometheus UI?**

> Grafana is a visualization and dashboard platform. Prometheus UI only gives basic charts and has no authentication. Grafana provides rich visualization types, saved dashboards, role-based access control, supports multiple data sources beyond Prometheus, and allows team sharing. Grafana is what teams actually use day to day — Prometheus UI is mainly for quick debugging.

**Q4: What is CrashLoopBackOff and how can Prometheus help?**

> CrashLoopBackOff is when a container repeatedly fails and Kubernetes keeps restarting it with increasing delay intervals. Prometheus captures this through Kube State Metrics which tracks the metric kube_pod_container_status_restarts_total. By querying this metric in PromQL or viewing it in Grafana, you can see the restart count increasing over time. You can also set an alert so that when restarts exceed a threshold, your team gets notified automatically.

**Q5: Why should you use rate() with counter metrics in PromQL?**

> Counters only ever increase. If you graph a raw counter it just shows a line going up forever which is not useful. The rate() function calculates how fast the counter is increasing per second over a time window. For example, rate(http_requests_total[5m]) gives you requests per second over the last 5 minutes, which is much more meaningful and actionable.

---

# 📗 DAY 4 — Custom Metrics Instrumentation + AlertManager

## What is Instrumentation?

In Day 1, the instructor mentioned that **observability is a collective responsibility.** Now in Day 4, we see what that actually means in practice.

Let's say you have a great DevOps or SRE team and they have built a complete observability stack:
```
✅ Prometheus is set up for monitoring
✅ Grafana is set up for dashboards
✅ EFK Stack is set up for log aggregation
✅ Jaeger is set up for distributed tracing
Everything is ready to use.
```

**But what if the applications in your organization are not giving this stack any data?**

```
What if developers of the payment service never wrote any logs?
What if there are no metrics coming from the login service?
What if traces are not defined in the checkout service?

Then it does not matter how good your Prometheus or Grafana is.
It is completely useless.
```

> This is exactly the point — **Instrumentation** is the process of writing metrics, logs, and traces inside the application code so that your observability stack has data to work with.

**What instrumentation means in practice:**

```
Instrumentation means developers write code like:
  → "Count how many times the login API was called"
  → "Measure how long each payment transaction takes"
  → "Track how many users created accounts today"
  → "Record a trace every time a request enters this service"

Without this, exporters cannot help you.
```

**Why can't exporters like Node Exporter do this?**

Exporters are plugins built to do specific predefined tasks:

```
Node Exporter → can give CPU, memory, disk of your nodes
MySQL Exporter → can give database performance metrics
Kube State Metrics → can give pod restarts, deployment status

But NONE of them can tell you:
  → How many users logged into YOUR application today?
  → What is the HTTP request latency of YOUR specific API?
  → How many orders were placed in YOUR e-commerce app?

These are application-specific metrics.
Only developers of that application can instrument them.
```

---

## Observability is a Team Responsibility

```
┌──────────────────────────────────────────────────────────────┐
│              WHO DOES WHAT IN YOUR ORGANIZATION              │
│                                                              │
│  DEVELOPERS                    DEVOPS / SRE                  │
│  ─────────────────────         ─────────────────────────     │
│  ✅ Instrument metrics          ✅ Set up Prometheus          │
│  ✅ Write structured logs       ✅ Set up Grafana             │
│  ✅ Add distributed traces      ✅ Set up EFK stack           │
│  ✅ Expose /metrics endpoint    ✅ Set up Jaeger              │
│  ✅ Define SLIs in code         ✅ Create dashboards          │
│                                 ✅ Configure alerts           │
│                                 ✅ Set up ServiceMonitors     │
└──────────────────────────────────────────────────────────────┘

In some organizations, DevOps engineers also do instrumentation.
In others, developers handle it.
It depends from organization to organization.
But BOTH sides must do their part — one without the other fails.
```

---

## Prometheus Metric Types — The Four Types

Just like every programming language has **data types** (string, integer, list, dictionary) because not all data is the same — Prometheus has **metric types** because not all metrics behave the same way.

```
Programming language analogy:
  String      → stores text data
  Integer     → stores whole numbers
  List        → stores multiple values
  Dictionary  → stores key-value pairs

Prometheus metric types:
  Counter     → always increasing numbers
  Gauge       → numbers that go up and down
  Histogram   → distribution of values in buckets
  Summary     → pre-calculated percentiles
```

> The key point: you need to know the **nature of your metric** to choose the right type. Just like you need to know the nature of your data to choose the right programming language data type.

---

### Metric Type 1 — Counter

A **Counter** is a metric that **only ever goes up.** It can never decrease. It can only increase or stay the same.

```
Visual:
  ▲
10│                              ●
 8│                         ●
 6│                    ●
 4│               ●
 2│          ●
 1│     ●
  │●
  └────────────────────────────▶ Time
```

**When to use Counter:**

> Use Counter when the count of something is always increasing. Once something happens, it happened — you don't subtract it.

```
Real examples of Counter metrics:
  → Number of user logins (users keep logging in, count goes up)
  → Number of accounts created (accounts created never decreases)
  → Number of HTTP requests received
  → Number of errors that occurred
  → Number of payments processed
```

**Code example in Node.js:**

```javascript
const promClient = require('prom-client');

// Define a Counter
const httpRequestsTotal = new promClient.Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests',
  labelNames: ['method', 'route', 'status_code']
});

// Increment when a request comes in
app.use((req, res, next) => {
  res.on('finish', () => {
    httpRequestsTotal.inc({
      method: req.method,
      route: req.path,
      status_code: res.statusCode
    });
  });
  next();
});
```

---

### Metric Type 2 — Gauge

A **Gauge** is a metric that **can go up and come down.** It represents the current state of something.

```
Visual:
  ▲
80│     ●         ●
60│  ●     ●   ●     ●
40│           ●         ●
20│                        ●
  └────────────────────────────▶ Time
```

**When to use Gauge:**

> Use Gauge when the value can increase and decrease over time — like a temperature or a level.

```
Real examples of Gauge metrics:
  → CPU utilization (goes up during peak, comes down after)
  → Memory usage (increases as apps run, decreases when freed)
  → Number of active connections (users connect and disconnect)
  → Number of ConfigMaps in Kubernetes (created and deleted)
  → Number of pods running right now
```

From the video example:
```
At 11:00 PM — CPU was 67%
At 11:15 PM — CPU dropped to 50%
At 11:20 PM — CPU went back up to 72%

This cannot be a Counter because it goes up AND down.
This must be a Gauge.
```

**Code example in Node.js:**

```javascript
const activeConnections = new promClient.Gauge({
  name: 'active_connections',
  help: 'Number of active connections right now'
});

// When connection opens
activeConnections.inc();  // +1

// When connection closes
activeConnections.dec();  // -1

// Or set to exact value
activeConnections.set(42);
```

---

### Metric Type 3 — Histogram

A **Histogram** samples observations and **counts them in pre-configured buckets.** It is used when you need to understand the **distribution of values** — especially latency and duration.

**The bucket concept explained simply:**

From the video:
> "Let's say your manager asks you: how many times did an HTTP request take less than 5 milliseconds? Or how many times did it take more than 100 milliseconds? If you use Counter or Gauge, you cannot answer this. That's why you create buckets."

```
Histogram buckets example for HTTP request duration:

┌────────────┬───────────���┬────────────┬────────────┐
│  ≤ 5ms     │  ≤ 10ms    │  ≤ 100ms   │  ≤ 1000ms  │
│  Bucket 1  │  Bucket 2  │  Bucket 3  │  Bucket 4  │
└────────────┴────────────┴────────────┴────────────┘

When a request comes in and takes 3ms → goes into bucket 1
When a request comes in and takes 8ms → goes into bucket 2
When a request comes in and takes 75ms → goes into bucket 3
When a request comes in and takes 500ms → goes into bucket 4

Now if manager asks: "How many requests took under 10ms?"
You say: Bucket 1 + Bucket 2 = your answer
```

**When to use Histogram:**

```
Real examples of Histogram metrics:
  → HTTP request duration (how long each request takes)
  → Database query time
  → Payment processing time
  → File upload time
```

**Code example in Node.js:**

```javascript
const httpRequestDuration = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'HTTP request duration in seconds',
  labelNames: ['method', 'route', 'status_code'],
  buckets: [0.5, 1, 5, 10]  // buckets at 0.5s, 1s, 5s, 10s
});

app.use((req, res, next) => {
  const end = httpRequestDuration.startTimer();
  res.on('finish', () => {
    end({
      method: req.method,
      route: req.path,
      status_code: res.statusCode
    });
  });
  next();
});
```

---

### Metric Type 4 — Summary

**Summary** is similar to Histogram but it calculates **quantiles (percentiles) on the client side** — inside the application itself.

> From the video: "At this point I will not go into the details of Summary because it might confuse beginners. Summary is exactly same as Histogram but we will cover it as we progress in the series during the dedicated instrumentation video using OpenTelemetry."

**Quick difference to know:**

```
Histogram vs Summary:
  Histogram  → Buckets calculated server-side, can be aggregated
               across multiple pods (preferred in Kubernetes)
  Summary    → Quantiles calculated client-side, cannot be
               accurately aggregated across multiple pods
               (less useful in multi-pod K8s deployments)
```

---

## The Demo Application — Node.js with Custom Metrics

The instructor uses a Node.js application from the Day 4 folder in the GitHub repository. Let's understand how metrics are instrumented in it.

```javascript
// index.js - How metrics are instrumented in the application

// Step 1: Import Prometheus client (the SDK)
const promClient = require('prom-client');

// Step 2: Instantiate the registry
const register = new promClient.Registry();

// Step 3: Define your metric types

// COUNTER - HTTP requests total (always increasing)
const httpRequestsTotal = new promClient.Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests received',
  labelNames: ['method', 'route', 'status_code'],
  registers: [register]
});

// HISTOGRAM - HTTP request duration (needs buckets)
const httpRequestDuration = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status_code'],
  buckets: [0.5, 1, 5, 10],
  registers: [register]
});

// Step 4: Track requests in middleware
app.use((req, res, next) => {
  const end = httpRequestDuration.startTimer();
  res.on('finish', () => {
    httpRequestsTotal.inc({
      method: req.method,
      route: req.path,
      status_code: res.statusCode
    });
    end({ method: req.method, route: req.path });
  });
  next();
});

// Step 5: Expose the /metrics endpoint
// This is what Prometheus will scrape
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});
```

---

## Deploying the Application on Kubernetes

```bash
# Step 1: Create namespace
kubectl create namespace dev

# Step 2: Deploy using Kustomize
# Go to the day4 folder in the GitHub repo
kubectl apply -k ./kubernetes-manifests/

# Step 3: Verify pods are running
kubectl get pods -n dev
# service-a-xxx   1/1   Running
# service-b-xxx   1/1   Running

# Step 4: Get the service URL
kubectl get svc -n dev
# service-a  LoadBalancer  10.100.x.x  abc.elb.amazonaws.com  3000:32000
```

---

## The Problem — Why Prometheus Is Not Showing Custom Metrics Yet

After deploying the application, if you go to Prometheus and search for:

```promql
http_requests_total
```

You get **nothing.** Zero results.

> "Why? The instrumentation is done. Why is Prometheus not showing my custom metrics?" — This is the important question.

**The answer is: Service Discovery is missing.**

```
You have:
  ✅ Prometheus running
  ✅ Application running with /metrics endpoint
  ✅ Metrics instrumented in the code

But Prometheus does NOT know about your application yet!

Imagine you have 100 applications on your cluster.
How does Prometheus know which ones have /metrics endpoints?
How does it know which ones to scrape?

It cannot guess. You have to TELL it.
This is called Service Discovery.
```

---

## Service Discovery — Telling Prometheus About Your Application

To tell Prometheus which applications to scrape, you create a **ServiceMonitor** resource.

**ServiceMonitor** is a Kubernetes Custom Resource (CRD) provided by the Prometheus Operator. It acts as a bridge between your application and Prometheus.

```yaml
# service-monitor.yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: service-a-monitor
  namespace: monitoring
spec:
  # Which namespace to look in
  namespaceSelector:
    matchNames:
    - dev

  # Which service to monitor (by label)
  selector:
    matchLabels:
      app: service-a

  # How to scrape it
  endpoints:
  - port: metrics         # Port name on the Service
    path: /metrics        # Endpoint to hit
    interval: 1m          # Scrape every 1 minute
```

**Apply the ServiceMonitor:**

```bash
kubectl apply -f service-monitor.yaml

# Wait about 1 minute, then in Prometheus UI run:
http_requests_total

# Now you will see data! ✅
```

> From the video: "It just took less than 2 minutes for the service monitor to reflect the configuration. I can see the graph now."

**The Three Steps to Get Custom Metrics Working:**

```
Step 1: INSTRUMENT
  → Developer adds prom-client to app
  → Defines Counter, Gauge, Histogram
  → Exposes /metrics endpoint

Step 2: SETUP PROMETHEUS STACK
  → helm install kube-prometheus-stack
  → Gets Prometheus + Grafana + AlertManager + Exporters

Step 3: SERVICE DISCOVERY
  → Create ServiceMonitor YAML
  → Tells Prometheus which services to watch
  → Custom metrics start flowing automatically
```

---

## AlertManager — How to Fire Real Alerts

Now that we have metrics, we want to be **notified** when something goes wrong. This is where **AlertManager** comes in.

**AlertManager** receives alerts from Prometheus and routes them to the right destination — email, Slack, PagerDuty, etc.

### Setting Up Gmail App Password

To send alerts to email using Gmail, you need an **App Password** (not your regular Gmail password):

```
Steps:
1. Go to: myaccount.google.com
2. Search: "App Passwords"
3. You must have 2-Factor Authentication enabled first
4. Create App Password → Name it "alertmanager"
5. Google gives you a 16-character password
6. Save this password — you will use it in AlertManager config
```

### Converting Password to Base64

Kubernetes Secrets require values in base64 format:

```bash
echo -n "your-app-password-here" | base64
# Output: eW91ci1hcHAtcGFzc3dvcmQ=
# Copy this output
```

### Creating the Email Secret

```yaml
# email-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: alertmanager-email-secret
  namespace: monitoring
type: Opaque
data:
  smtp-password: eW91ci1hcHAtcGFzc3dvcmQ=  # base64 encoded password
```

### AlertManager Configuration

```yaml
# alert-manager-config.yaml
apiVersion: monitoring.coreos.com/v1alpha1
kind: AlertmanagerConfig
metadata:
  name: alert-manager-config
  namespace: monitoring
spec:
  route:
    receiver: 'send-email'
    routes:
    - matchers:
      - name: alertname
        value: PodCrashLooping
      receiver: 'send-email'

  receivers:
  - name: 'send-email'
    emailConfigs:
    - smarthost: 'smtp.gmail.com:587'
      authUsername: 'your-email@gmail.com'
      authPassword:
        name: alertmanager-email-secret
        key: smtp-password
      from: 'your-email@gmail.com'
      to: 'recipient@gmail.com'
      requireTLS: true
```

### Alert Rules Configuration

```yaml
# alert-rules.yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: pod-alert-rules
  namespace: monitoring
  labels:
    release: prometheus
spec:
  groups:
  - name: pod-alerts
    interval: 1m
    rules:
    # Alert when pod restarts more than 2 times in 5 minutes
    - alert: PodCrashLooping
      expr: |
        increase(
          kube_pod_container_status_restarts_total[5m]
        ) > 2
      for: 1m
      labels:
        severity: critical
      annotations:
        summary: "Pod {{ $labels.pod }} is crash looping"
        message: "Pod restarted {{ $value }} times in 5 minutes"
```

### Deploying AlertManager Config

```bash
kubectl apply -k ./alert-manager-service-monitor/

# Verify resources created
kubectl get alertmanagerconfig -n monitoring
kubectl get prometheusrule -n monitoring
```

### Testing the Alert — Crash the Application

```bash
# Hit the /crash endpoint of the application
# The application is written so that /crash causes it to exit
curl http://<EXTERNAL-IP>:3000/crash

# Watch pod status
kubectl get pods -n dev
# service-a-xxx   0/1   CrashLoopBackOff   1   30s

# Crash it again
curl http://<EXTERNAL-IP>:3000/crash
```

> From the video: "As soon as it crashed, you can see on my mobile I got the notification. AlertManager has notified me that your application has crashed — the pod restart notification is sent to my mobile because I have Gmail configured on my mobile."

---

## 🎤 Day 4 Interview Questions & Answers

**Q1: What is instrumentation and why is it important?**

> Instrumentation is the process of writing metrics, logs, and traces inside your application code so that your observability stack has data to work with. Even if you have the best Prometheus and Grafana setup, without instrumentation the observability stack is useless because it has no application-specific data. Exporters can give you infrastructure metrics but they cannot give you business-specific metrics like how many users logged in or what is the latency of a specific API.

**Q2: What are the four Prometheus metric types and when do you use each?**

> Counter is for metrics that only increase like total HTTP requests or total logins. You never subtract from a counter. Gauge is for metrics that go up and down like current CPU percentage or active connections. Histogram is for measuring distributions like request latency — it samples values into pre-configured buckets so you can answer questions like how many requests took under 100ms. Summary is similar to Histogram but calculates percentiles on the client side and is less preferred in multi-pod Kubernetes setups because it cannot be accurately aggregated.

**Q3: What is a ServiceMonitor and why is it needed?**

> ServiceMonitor is a Kubernetes CRD from the Prometheus Operator. It tells Prometheus which services to scrape for metrics. Without it, even if your application has a working /metrics endpoint, Prometheus will not scrape it because Prometheus does not automatically discover all services in a cluster. ServiceMonitor acts as the bridge between your application service and Prometheus configuration.

**Q4: What is AlertManager and how is it different from Prometheus?**

> Prometheus evaluates alert rules and fires alerts when conditions are met. AlertManager receives those fired alerts and handles routing — deduplication, grouping, silencing, and delivery to receivers like email, Slack, or PagerDuty. Prometheus creates the alert signal. AlertManager decides who gets notified and through which channel.

**Q5: Why do Kubernetes Secrets need to be base64 encoded?**

> Kubernetes Secrets store sensitive data like passwords. The values must be base64 encoded because Kubernetes expects this format for secret data. It is not encryption — base64 is just an encoding format. The actual security comes from Kubernetes RBAC controlling who can read Secrets, and from encryption at rest at the etcd level.

---

# 📗 DAY 5 — Logging + EFK Stack

## What is Logging?

If you remember from Day 1, there are three pillars of observability:
```
Metrics → What is the state of the system?
Logs    → Why is something failing?
Traces  → How to find and fix the root cause?
```

Day 5 focuses on the **second pillar — Logs.**

**Logs are messages that developers write in the application** to help users understand:
- What the application is doing at each step
- Why the application is not working as expected so you can debug it

**Simple Example — A Program Without Logs vs With Logs:**

```python
# WITHOUT logs — user has no idea what is happening
a = input()    # What does this ask for? A string? A number?
b = input()    # Why is it asking again?
c = int(a) + int(b)
print(c)       # What does this number mean?
```

```python
# WITH logs — user understands exactly what is happening
print("Starting addition program")
print("Please enter the first number:")
a = input()

print("Please enter the second number:")
b = input()

print("Adding the two numbers...")
c = int(a) + int(b)

print(f"Addition complete. Your result is: {c}")
```

**Shell Script Example Without and With Logs:**

```bash
# WITHOUT logs
a=$1
b=$2
echo $((a + b))
```

```bash
# WITH logs
echo "[INFO] Starting addition process"
echo "[INFO] First number: $1"
echo "[INFO] Second number: $2"
a=$1
b=$2
result=$((a + b))
echo "[INFO] Addition process complete"
echo "[INFO] Result: $result"
```

---

## Why Logs Are Critical in Real Applications

From the video:
> "Assume if the application has 10,000 lines of code and suddenly the application has stopped working. How would you know at which point the application has failed? Did it fail at line 5,000? Did it break at line 6,000? And why did it fail? Is it an index out of bounds? Is it an unhandled exception?"

```
Without logs in a 10,000 line application:
  → Application stops working
  → You have NO idea where or why it failed
  → You look through 10,000 lines manually
  → Takes hours or days to find the bug

With logs:
  → "[ERROR] Database connection failed at payment processing"
  → "[ERROR] Null pointer exception in function calculateTax()"
  → You instantly know where and why it failed
  → Fix in minutes, not days
```

> If you look at any open-source application or any well-written application in your organization, you will find log messages at every critical step. At every important point, a log message is written so that if that step fails, the log tells you exactly what went wrong.

---

## The Problem With Logs in Kubernetes — Why You Need Centralized Logging

Imagine you have hundreds of microservices on your Kubernetes cluster:

```
Your EKS Cluster:
  namespace: production
    payment-service     (3 pods)
    order-service       (5 pods)
    user-service        (2 pods)
    login-service       (2 pods)
    ... more services

  namespace: staging
    payment-service     (1 pod)
    order-service       (1 pod)

Total: 100+ pods across multiple namespaces
```

**Real Scenario from the video:**

> "There is a log4J issue or there is an issue with the database connection among some applications. How would you know among the 100 services running in different namespaces, which of these services has a database connection issue? Maybe it's a temporary or intermittent connection issue — sometimes the issue is there and sometimes it is not."

**Without centralized logging:**

```bash
# You have to do this for EVERY pod manually:
kubectl logs payment-service-pod-1 -n production | grep "connection"
kubectl logs payment-service-pod-2 -n production | grep "connection"
kubectl logs payment-service-pod-3 -n production | grep "connection"
kubectl logs order-service-pod-1 -n production | grep "connection"
# ... repeat 100 more times
# Takes HOURS. Not practical.
```

**With Centralized Logging (EFK Stack):**

```
One search in Kibana:
  Search: "connection timed out"

Result in seconds:
  Found in: payment-service (47 occurrences)
  Found in: order-service   (12 occurrences)
  Found in: user-service    (3 occurrences)

Now you can tell developers: "Fix these 3 services."
Response time: 30 seconds instead of 3 hours.
```

> From the video: "When there are critical vulnerabilities like the log4J issue — if you have a centralized logging system, it would be easy to identify the vulnerable services very quickly and react immediately."

---

## What is EFK Stack?

```
E = Elasticsearch   → The database that stores all logs
F = Fluent Bit      → The log collector that reads and forwards logs
K = Kibana          → The dashboard where you search and view logs
```

> From the video: "If you have followed the monitoring classes — just like how you have Prometheus where Prometheus has a Time Series Database and uses exporters like Node Exporter to get metrics, and then Grafana provides the dashboard — the EFK stack follows the exact same architecture pattern."

---

## EFK Architecture — How Each Component Works

```
┌──────────────────────────────────────────────────────────────────┐
│                    KUBERNETES CLUSTER (EKS)                       │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │               APPLICATION PODS                              │  │
│  │  service-a    service-b    payment-service    order-service │  │
│  │  (writes logs to stdout → Kubernetes captures them)        │  │
│  └───────────────────────────┬────────────────────────────────┘  │
│                               │                                   │
│                               │ Logs written to:                  │
│                               │ /var/log/containers/*.log         │
│                               │                                   │
│  ┌────────────────────────────▼────────────────────────────────┐  │
│  │               FLUENT BIT (DaemonSet)                         │  │
│  │  Node 1: fluent-bit-pod-1  → reads logs from Node 1         │  │
│  │  Node 2: fluent-bit-pod-2  → reads logs from Node 2         │  │
│  │                                                              │  │
│  │  What it does:                                               │  │
│  │  → Reads container logs from the node filesystem            │  │
│  │  → Adds metadata: namespace, pod name, node name            │  │
│  │  → Filters out unwanted namespaces                          │  │
│  │  → Forwards logs to Elasticsearch                           │  │
│  └───────────────────────────┬────────────────────────────────┘  │
│                               │ Forwards logs (push)              │
│                               ▼                                   │
│  ┌───────────────────────────────────────────────────────────┐   │
│  │              ELASTICSEARCH (StatefulSet)                    │   │
│  │  → Stores and indexes all the logs                         │   │
│  │  → Mounted on EBS volumes for persistence                  │   │
│  │  → Port: 9200                                              │   │
│  └───────────────────────────┬───────────────────────────────┘   │
│           ↑                   │                                   │
│      EBS Volume               │ Queries                          │
│      (Persistent)             ▼                                   │
│                     ┌───────────────────┐                        │
│                     │      KIBANA        │ ← You search logs here │
│                     │  (port 5601)       │                        │
│                     └───────────────────┘                        │
└──────────────────────────────────────────────────────────────────┘
```

---

## EFK vs ELK — Fluent Bit vs Logstash

This is a very common question. Both stacks use Elasticsearch and Kibana. The only difference is the middle component.

```
EFK: Elasticsearch + Fluent Bit  + Kibana
ELK: Elasticsearch + Logstash    + Kibana
                        ↑
                   Only difference
```

| | Fluent Bit | Logstash |
|--|--|--|
| **Role** | Log forwarder | Log aggregator and processor |
| **Resource usage** | Very lightweight (~450KB) | Heavy (~512MB+ memory) |
| **Filtering** | Basic to moderate via Lua scripts | Advanced with many plugins |
| **Transformation** | Limited | Rich data transformation |
| **Reliability** | Very stable, few issues | More complex, more issues |
| **Vendor neutral** | Yes — works with many backends | Less flexible |
| **Best for** | Most Kubernetes use cases | Complex log pipelines |

> From the video: "Many organizations don't need the advanced features of Logstash. Fluent Bit is more than enough, it is very lightweight, and the chance of issues with Fluent Bit is very less compared to Logstash. If you are starting, start with Fluent Bit."

> "Another advantage of Fluent Bit is that it is vendor neutral. Tomorrow if you want to move from Elasticsearch to Splunk or any other log management platform, Fluent Bit can work as-is. With Logstash you can be restricted to a particular platform."

---

## AWS EKS Setup — IAM Role, EBS, and CSI Driver

Before installing EFK on EKS, you need to set up the permission system so Elasticsearch can use EBS volumes for storage.

**Why is this needed?**

```
The problem:
  Elasticsearch runs inside EKS cluster
  EBS volumes are outside the EKS cluster (but in same AWS account)
  
  EKS pod → wants to use → EBS volume
  
  But an EKS pod cannot talk to EBS by default.
  AWS services need IAM roles to communicate with each other.
  
  But a Pod is not an AWS service — it is inside Kubernetes.
  How does a Pod get an IAM role?
```

**The Solution — Three Steps:**

```
Step 1: Create an IAM Role
  → This role has permission to create, attach, detach EBS volumes

Step 2: Create a Kubernetes Service Account
  → Link this service account to the IAM role using OIDC
  → Now when Elasticsearch pod uses this service account,
    it inherits the IAM role permissions

Step 3: Install EBS CSI Driver
  → This driver acts as the translator between
    Kubernetes PVC requests and actual EBS volume creation
  → When Elasticsearch requests 10Gi storage,
    CSI driver creates a real EBS volume and attaches it
```

```bash
# Step 1: Create IAM Service Account
eksctl create iamserviceaccount \
  --name elasticsearch-sa \
  --namespace logging \
  --cluster observability-one \
  --attach-policy-arn \
    arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve \
  --override-existing-serviceaccounts

# Step 2: Get the IAM Role ARN (save this!)
ARN=$(aws iam get-role \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --query 'Role.Arn' \
  --output text)
echo $ARN

# Step 3: Install EBS CSI Driver
aws eks create-addon \
  --cluster-name observability-one \
  --addon-name aws-ebs-csi-driver \
  --service-account-role-arn $ARN

# Step 4: Create the logging namespace
kubectl create namespace logging
```

---

## Installing Elasticsearch

```bash
# Step 1: Add Elastic Helm repository
helm repo add elastic https://helm.elastic.co
helm repo update

# Step 2: Install Elasticsearch with EBS storage
helm install elasticsearch elastic/elasticsearch \
  --namespace logging \
  --set persistence.enabled=true \
  --set volumeClaimTemplate.storageClassName=gp2 \
  --set volumeClaimTemplate.resources.requests.storage=10Gi \
  --set replicas=1

# Step 3: Get the username (default is: elastic)
kubectl get secret elasticsearch-master-credentials \
  -n logging \
  -o jsonpath='{.data.username}' | base64 -d

# Step 4: Get the password (SAVE THIS!)
kubectl get secret elasticsearch-master-credentials \
  -n logging \
  -o jsonpath='{.data.password}' | base64 -d
```

> From the video: "Keep a note of the username and password. It is very important because when we deploy Fluent Bit, we are going to pass that username and password in the Fluent Bit configuration so that Fluent Bit can talk to Elasticsearch."

---

## Installing Kibana

```bash
# Install Kibana with LoadBalancer type
# (so you can access from browser)
helm install kibana elastic/kibana \
  --namespace logging \
  --set service.type=LoadBalancer \
  --set service.port=5601

# Get Kibana URL
kubectl get svc kibana-kibana -n logging
# NAME            TYPE           EXTERNAL-IP
# kibana-kibana   LoadBalancer   abc.elb.amazonaws.com

# Access Kibana at:
# http://<EXTERNAL-IP>:5601
# Username: elastic
# Password: <password you saved from Elasticsearch>
```

---

## Fluent Bit — The Four Sections of Configuration

Before installing Fluent Bit, you need to understand its configuration file. Do not worry about the length — you only need to change a couple of things.

**The four main sections:**

```
SERVICE  → Global settings for Fluent Bit
INPUT    → Where to read logs from
FILTER   → Which logs to keep and which to skip
OUTPUT   → Where to send the logs
```

```yaml
# fluent-bit-values.yaml

config:
  # ════════════════���══════════════════════
  # SECTION 1: SERVICE — Global settings
  # ═══════════════════════════════════════
  service: |
    [SERVICE]
        Flush         1
        Log_Level     info
        Daemon        off

  # ═══════════════════════════════════════
  # SECTION 2: INPUT — Where logs come from
  # ═══════════════════════════════════════
  inputs: |
    [INPUT]
        Name              tail
        Path              /var/log/containers/*.log
        # Read ALL container logs from the node
        Tag               kube.*
        Refresh_Interval  10

  # ═══════════════════════════════════════
  # SECTION 3: FILTER — Transform and filter
  # ═══════════════════════════════════════
  filters: |
    [FILTER]
        Name                kubernetes
        Match               kube.*
        # Adds: namespace, pod name, node name to each log
        Kube_URL            https://kubernetes.default.svc:443
        Merge_Log           On

    [FILTER]
        Name    lua
        Match   kube.*
        script  /fluent-bit/scripts/filter.lua
        call    exclude_namespaces

  # ═══════════════════════════════════════
  # SECTION 4: OUTPUT — Where to send logs
  # ═══════════════════════════════════════
  outputs: |
    [OUTPUT]
        Name            es
        Match           kube.*
        Host            elasticsearch-master
        Port            9200
        HTTP_User       elastic
        HTTP_Passwd     <YOUR-ELASTICSEARCH-PASSWORD>  # ← Update this!
        tls             On
        tls.verify      Off
        Logstash_Format On
        Logstash_Prefix fluent-bit

# ═══════════════════════════════════════
# Lua script to exclude certain namespaces
# ═══════════════════════════════════════
luaScripts:
  filter.lua: |
    local excluded = {
      ["logging"] = true,     -- Don't log Elasticsearch's own logs
      ["kube-system"] = true  -- Skip K8s system logs
    }
    function exclude_namespaces(tag, timestamp, record)
      local ns = record["kubernetes"] and
                 record["kubernetes"]["namespace_name"]
      if ns and excluded[ns] then
        return -1, timestamp, record  -- DROP this log
      end
      return 1, timestamp, record     -- KEEP this log
    end
```

> From the video: "Why do we exclude the logging namespace? Because Fluent Bit would read Elasticsearch's own logs, forward them to Elasticsearch, which creates more logs, which Fluent Bit reads again — an infinite feedback loop that would fill up your storage!"

**The only things you need to change in the config file:**

```
1. HTTP_Passwd → Replace with your Elasticsearch password
2. That's it! Everything else stays the same.
```

---

## Installing Fluent Bit

```bash
# Step 1: Add Fluent Helm repository
helm repo add fluent https://fluent.github.io/helm-charts
helm repo update

# Step 2: Update the password in values.yaml first!
vim fluent-bit-values.yaml
# Find HTTP_Passwd and update with your Elasticsearch password

# Step 3: Install Fluent Bit
helm install fluent-bit fluent/fluent-bit \
  --namespace logging \
  --values fluent-bit-values.yaml
```

---

## Verifying Everything is Running

```bash
kubectl get pods -n logging
# NAME                          READY   STATUS    RESTARTS
# elasticsearch-master-0        1/1     Running   0
# kibana-kibana-xxx             1/1     Running   0
# fluent-bit-xxx (node 1)       1/1     Running   0  ← DaemonSet
# fluent-bit-xxx (node 2)       1/1     Running   0  ← DaemonSet
```

> From the video: "We are running a 2-node Kubernetes cluster. That's why we have 2 pods of Fluent Bit. That is the concept of DaemonSet — n number of nodes that you have, you will see n number of replicas of Fluent Bit."

---

## Deploying a Test Application to Verify Log Flow

```bash
# Deploy the Day 4 application to test logging
kubectl create namespace dev
kubectl apply -k ./day4/kubernetes-manifests/

# Check pod logs directly
kubectl logs -l app=service-a -n dev
# [INFO] Service A is running on Port 3000

# Check if Fluent Bit found the application
kubectl logs fluent-bit-xxx -n logging | grep "service-a"
# [info] found container: service-a
# [info] flushed chunks with records
```

---

## Setting Up Kibana Data View and Searching Logs

```
Step 1: Open Kibana at http://<EXTERNAL-IP>:5601
Step 2: Login with elastic / <your-password>
Step 3: Go to Discover (left sidebar)
Step 4: Click "Create data view"
Step 5: Fill in:
          Name: log-management
          Index pattern: fluent-bit-*
          Timestamp: @timestamp
Step 6: Click "Save data view to Kibana"
Step 7: You can now see all logs from all namespaces!
```

> From the video: "As soon as you do it, you can see the logs that are already recorded. You have logs coming from different namespaces, logs coming from your application. You can also see the timestamps."

**Kibana Query Language (KQL) examples:**

```
# Show logs from dev namespace only
kubernetes.namespace_name : "dev"

# Show ERROR logs only
log.level : "ERROR"

# Search for specific text
message : "database connection"

# Combine filters
kubernetes.namespace_name : "production" AND log.level : "ERROR"

# Exclude a namespace
NOT kubernetes.namespace_name : "kube-system"
```

> From the video: "You also have something called Kibana Query Language using which you can filter out particular log messages. For example, some of them are coming from kube-proxy namespace — if you want to get rid of that and only want to see the dev namespace, you can do that."

---

## 🎤 Day 5 Interview Questions & Answers

**Q1: What is the EFK stack and what does each component do?**

> EFK stands for Elasticsearch, Fluent Bit, and Kibana. Elasticsearch is the database that stores and indexes all the logs, making them searchable. Fluent Bit is the log collector deployed as a DaemonSet on every node — it reads container logs from the node filesystem and forwards them to Elasticsearch. Kibana is the web dashboard where you query and visualize logs. Together they form a centralized logging system for Kubernetes.

**Q2: Why does Fluent Bit run as a DaemonSet?**

> Container logs are stored on the local filesystem of each node at /var/log/containers/. Fluent Bit must run on the node itself to read these local files. It cannot read them remotely. A DaemonSet ensures exactly one Fluent Bit pod runs on every node so no node's logs are missed.

**Q3: What is the difference between EFK and ELK stacks?**

> Both use Elasticsearch and Kibana. The difference is the middle component. ELK uses Logstash which is a heavy log aggregator with advanced filtering and transformation. EFK uses Fluent Bit which is a very lightweight log forwarder. Fluent Bit uses minimal memory compared to Logstash's high memory needs. For most Kubernetes use cases, Fluent Bit is sufficient. Logstash is used when complex log processing pipelines are needed. Also, Fluent Bit is vendor neutral — you can switch backends easily.

**Q4: Why do you need an IAM role and EBS CSI driver for Elasticsearch on EKS?**

> Elasticsearch needs persistent storage so logs survive pod restarts. On AWS EKS this means using EBS volumes. But pods inside EKS cannot access EBS volumes by default. The IAM Role for Service Account gives the Elasticsearch pod permission to interact with EBS. The EBS CSI Driver acts as the bridge between Kubernetes PersistentVolumeClaim requests and actual EBS volume creation and attachment.

**Q5: Why do you exclude the logging namespace in Fluent Bit?**

> Without excluding it, Fluent Bit would read Elasticsearch's own logs, forward them to Elasticsearch, which generates more logs, which Fluent Bit reads again ��� creating an infinite feedback loop that rapidly fills your storage and degrades performance.

---

# 📗 DAY 6 — Distributed Tracing + Jaeger

## What is Distributed Tracing?

To understand tracing, the instructor starts with a real-world story:

**The Hyderabad to Boston Story:**

> "You are in Hyderabad, India and you have a friend in Boston, USA who invited you. You have never traveled to Boston before so you prepare a travel itinerary with time for each step."

```
Your Travel Itinerary:
  Home → Hyderabad Airport (cab)      45 minutes
  Hyderabad Airport → Dubai (flight)  3.5 hours
  Dubai → Boston (flight)             12 hours
  Boston Airport → Friend's house     2.5 hours
  ─────────────────────────────────────────────
  Total journey time:                 ~25 hours
```

> "Your friend said: usually this journey takes 23 hours but in your case it took 25 hours. Your friend decided to trace what went wrong. You shared your travel itinerary and your friend noticed that the cab from Boston Airport to his house should only take 30 minutes but it took 2.5 hours. That's where you realized you took the wrong cab!"

> "How were you able to trace the issue? Because of the travel itinerary and the timings you noted."

**Now apply the same concept to software:**

```
User wants to make a payment in an e-commerce application.
The request travels through multiple services:

  User Request
      ↓
  Login Service    → authenticates the user
      ↓
  Service A        → some business logic
      ↓
  Service B        → more business logic
      ↓
  Payment Service  → processes the payment

The user expects this to take 1 second.
But it is taking 4 seconds.

Without tracing:
  → You know it is slow (from metrics)
  → But you don't know WHICH service is causing the 3 second delay

With tracing:
  → You can see each hop and how long each one took
  → Service B to Payment took 3 seconds (should be 30ms)
  → Now you know exactly where the problem is
```

---

## Tracing as the Third Pillar of Observability

```
THREE PILLARS:

METRICS (Prometheus/Grafana)
  → WHAT is happening?
  → "Payment service has 500 errors per minute"
  → "CPU is at 90%"

LOGS (EFK Stack / Kibana)
  → WHY is it failing?
  → "DB connection timed out in payment service"

TRACES (Jaeger)
  → HOW to find the root cause across services?
  → "Request went: Login(50ms) → ServiceA(30ms) →
     ServiceB(3000ms ← PROBLEM!) → Payment(20ms)"
```

---

## Key Tracing Concepts — Trace and Span

**Trace:**
> A trace is the complete journey of a single request through your entire system from start to finish.

```
One Trace = One user request's complete lifecycle
           across ALL services it touches

Trace ID: abc-123-xyz-789
  → This ID follows the request through every service
```

**Span:**
> A span is one single unit of work within a trace — one service hop, one function call, one database query.

```
Trace abc-123-xyz-789
  ├── Span 1: login-service       [0ms to 50ms]
  ├── Span 2: service-a           [50ms to 80ms]
  ├── Span 3: service-b           [80ms to 3080ms]  ← SLOW!
  └── Span 4: payment-service     [3080ms to 3100ms]

Each span tells you:
  → Which service
  → Which function
  → How long it took
  → Any errors
```

From the video using the application demo:
> "Spans are nothing but basically points. In the Hyderabad to Boston example, Hyderabad International Airport is a span, Dubai is a span, Boston International Airport is a span. Traces are divided into spans."

---

## How Tracing is Implemented — Two Responsibilities

Just like custom metrics require both instrumentation (developer) and Prometheus setup (DevOps), distributed tracing requires work from both sides:

```
DEVELOPERS:                        DEVOPS / SRE:
───────────────────                ─────────────────────
✅ Instrument traces in code        ✅ Deploy Jaeger on K8s
✅ Use OpenTelemetry SDK            ✅ Configure Elasticsearch
✅ Define meaningful spans          ✅ Set up namespaces
✅ Add span attributes              ✅ Expose Jaeger UI
✅ Ensure context propagation       ✅ Share Jaeger URL with team
```

> From the video: "Only if both of these things are done you can implement distributed tracing. If one of these things is not there — let's say you as a DevOps engineer created the cluster, installed Jaeger using Helm, but the developers did not instrument traces — there is no point."

---

## OpenTelemetry for Tracing

**OpenTelemetry** is the preferred standard for instrumentation. The reason is vendor neutrality:

> "There are multiple programming languages, each has some modules and plugins. But a preferred standard is to use OpenTelemetry. OpenTelemetry is gaining significance and it is vendor neutral — tomorrow if you want to move from one tracing tool to another, it would be easy."

**How developers instrument tracing in the application:**

Looking at the Day 4 application's `tracing.js` file:

```javascript
// tracing.js — must be loaded BEFORE your app code
'use strict';

const { NodeSDK } = require('@opentelemetry/sdk-node');
const { JaegerExporter } = require('@opentelemetry/exporter-jaeger');
const { getNodeAutoInstrumentations } =
  require('@opentelemetry/auto-instrumentations-node');
const { Resource } = require('@opentelemetry/resources');
const { SemanticResourceAttributes } =
  require('@opentelemetry/semantic-conventions');

// Configure where to send traces (Jaeger)
const jaegerExporter = new JaegerExporter({
  endpoint: process.env.JAEGER_ENDPOINT ||
    'http://jaeger-collector.tracing.svc.cluster.local:14268/api/traces',
});

// Set service identity (appears in Jaeger UI)
const resource = new Resource({
  [SemanticResourceAttributes.SERVICE_NAME]: 'service-a',
});

// Start the SDK
const sdk = new NodeSDK({
  resource: resource,
  traceExporter: jaegerExporter,
  // Auto-instruments HTTP, Express, DB calls automatically
  instrumentations: [getNodeAutoInstrumentations()],
});

sdk.start();
```

```javascript
// index.js — Load tracing.js as FIRST line
require('./tracing');  // ← Must be first!

const express = require('express');
const axios = require('axios');
const app = express();

// Service A calls Service B — this creates a distributed trace
app.get('/call-service-b', async (req, res) => {
  const response = await axios.get(
    'http://service-b.dev.svc.cluster.local:3001/hello'
  );
  res.json({ message: 'Service B called', data: response.data });
});
```

> Note: Service B also has its own `tracing.js` with `SERVICE_NAME: 'service-b'`. Same pattern, different service name.

---

## Tracing can be done at Function Level too

From the video:
> "Tracing can be even more deep — not only from service to service, you can also define tracing at the function level. You can understand from which function of a service the application routed to another function. It's up to you how much level of tracing you want to implement."

```javascript
const { trace } = require('@opentelemetry/api');
const tracer = trace.getTracer('service-a');

app.post('/process-order', async (req, res) => {
  // Create a span at function level
  const span = tracer.startSpan('process-order');
  try {
    const validateSpan = tracer.startSpan('validate-order');
    await validateOrder(req.body);
    validateSpan.end();

    const paymentSpan = tracer.startSpan('process-payment');
    await processPayment(req.body);
    paymentSpan.end();

    span.end();
    res.json({ success: true });
  } catch (error) {
    span.recordException(error);
    span.end();
    res.status(500).json({ error: error.message });
  }
});
```

---

## Jaeger Architecture — Four Components

> From the video: "Whether it is Prometheus, EFK stack, or Jaeger — all of them kind of have similar architecture. If you know one, it becomes very simple to understand the others."

```
THE SAME PATTERN ACROSS ALL THREE STACKS:

METRICS (Prometheus):
  Node Exporter → reads from node → Prometheus scrapes
  → stores in TSDB → Prometheus UI / Grafana

LOGS (EFK):
  Fluent Bit → reads from nodes → pushes to Elasticsearch
  → stores in ES DB → Kibana UI

TRACES (Jaeger):
  Jaeger Agent → gets from app → sends to Collector
  → stores in Elasticsearch → Jaeger Query UI
```

**The Four Jaeger Components:**

```
1. AGENT
   → Gets trace data from your instrumented application
   → Can only get traces if developers have instrumented them
   → Deployed as DaemonSet or sidecar

2. COLLECTOR
   → Receives spans from the Agent
   → Processes and validates them
   → Writes to storage (Elasticsearch)

3. STORAGE (Elasticsearch)
   → Stores all trace data
   → Jaeger is NOT opinionated — you choose the database
   → Can use Elasticsearch (preferred), Cassandra, ScyllaDB
   → Elasticsearch is preferred because it is fast
     and you may already have it for EFK logs

4. QUERY / UI (port 16686)
   → Web interface for searching and viewing traces
   → User fires a query
   → Query hits the Collector
   → Collector gets data from Elasticsearch
   → Shows trace visualization to user
```

> From the video: "The reason why I did not represent Jaeger separately in the architecture diagram is because Jaeger stores data in Elasticsearch itself — the same Elasticsearch we used for logs."

---

## Complete Observability Architecture — All Three Pillars Together

From the video, the instructor shows the complete architecture:

```
┌─────────────────────────────────────────────────────────────────┐
│              COMPLETE OBSERVABILITY ON AWS EKS                   │
│                                                                  │
│  Three collectors running on the cluster:                        │
│                                                                  │
│  1. Node Exporter (DaemonSet)                                    │
│     → Collects node metrics (CPU, Memory, Disk)                  │
│     → Prometheus scrapes it                                      │
│                                                                  │
│  2. Fluent Bit (DaemonSet)                                       │
│     → Collects container logs                                    │
│     → Pushes to Elasticsearch                                    │
│                                                                  │
│  3. Jaeger Agent (DaemonSet/sidecar)                             │
│     → Collects distributed traces                                │
│     → Sends to Jaeger Collector                                  │
│     → Stored in same Elasticsearch                               │
│                                                                  │
│  Storage:                                                        │
│  → Prometheus TSDB (for metrics)                                 │
│  → Elasticsearch on EBS (for logs AND traces)                    │
│                                                                  │
│  Three UIs you share with your team:                             │
│  → Grafana  (port 3000) → Metrics dashboards                     │
│  → Kibana   (port 5601) → Log search                             │
│  → Jaeger   (port 16686) → Distributed traces                    │
└─────────────────────────────────────────────────────────────────┘
```

> From the video: "At the end of the day if you are the DevOps engineer or SRE engineer, you are going to share these three URLs with your team — Grafana URL for metrics, Jaeger URL for distributed tracing, and Kibana URL for logs."

---

## Setting Up Jaeger on AWS EKS — Step by Step

### Step 1: Ensure Elasticsearch is Running (from Day 5)

```bash
kubectl get pods -n logging | grep elasticsearch
# elasticsearch-master-0   1/1   Running   0

# Save the password
ES_PASSWORD=$(kubectl get secret elasticsearch-master-credentials \
  -n logging \
  -o jsonpath='{.data.password}' | base64 -d)
echo "ES Password: $ES_PASSWORD"
```

### Step 2: Create Tracing Namespace

```bash
kubectl create namespace tracing
```

> From the video: "Create a namespace for tracing. It is better to use different namespaces even though you are implementing observability — create a namespace for monitoring, a namespace for logging, and a different namespace for tracing. That way you can implement different RBAC, it is easier for troubleshooting."

### Step 3: Extract Elasticsearch CA Certificate

```bash
# Jaeger needs this to communicate securely with Elasticsearch
kubectl get secret elasticsearch-master-certs \
  -n logging \
  -o jsonpath='{.data.ca\.crt}' | base64 -d > /tmp/es-ca.crt
```

### Step 4: Create ConfigMap for CA Certificate

```bash
kubectl create configmap elasticsearch-ca-cert \
  --from-file=ca.crt=/tmp/es-ca.crt \
  -n tracing
```

### Step 5: Create Secret for Elasticsearch Credentials

```bash
kubectl create secret generic elasticsearch-credentials \
  --from-literal=username=elastic \
  --from-literal=password=$ES_PASSWORD \
  -n tracing
```

### Step 6: Update Jaeger Values File with Password

```yaml
# jaeger-values.yaml
# Only update the password section — everything else stays the same

storage:
  type: elasticsearch
  elasticsearch:
    host: elasticsearch-master.logging.svc.cluster.local
    port: 9200
    scheme: https
    user: elastic
    password: "<YOUR-ELASTICSEARCH-PASSWORD>"  # ← Update this!
    tls:
      enabled: true
      ca: /es-certs/ca.crt
```

> From the video: "Before running the Jaeger installation command, you need to update the values.yaml. There are two output sections in the file — one for collector and one for query. Make sure the password is provided in both places. Without updating the password, do not start the Jaeger installation."

### Step 7: Install Jaeger

```bash
# Add Jaeger Helm repo
helm repo add jaegertracing \
  https://jaegertracing.github.io/helm-charts
helm repo update

# Install Jaeger
helm install jaeger jaegertracing/jaeger \
  --namespace tracing \
  --values jaeger-values.yaml

# Verify all four pods are running
kubectl get pods -n tracing
# jaeger-agent-xxx       1/1   Running  (DaemonSet — one per node)
# jaeger-collector-xxx   1/1   Running
# jaeger-query-xxx       1/1   Running  (this is the UI)
```

### Step 8: Access Jaeger UI

```bash
# Port forward Jaeger UI
kubectl port-forward svc/jaeger-query 16686:16686 -n tracing

# If using EC2 instance, add address flag:
kubectl port-forward svc/jaeger-query 16686:16686 \
  -n tracing \
  --address 0.0.0.0
# Then access: http://<ec2-ip>:16686

# Open browser: http://localhost:16686
```

---

## Deploying Demo Application and Viewing Traces

```bash
# Deploy the Day 4 application (it has tracing.js already)
kubectl create namespace dev
kubectl apply -k ./day4/kubernetes-manifests/

kubectl get svc -n dev
# service-a  LoadBalancer  abc.elb.amazonaws.com  3000

# Hit some endpoints to generate traces
curl http://abc.elb.amazonaws.com:3000/healthy
# Response: {"message":"Observability series by Abhishek","status":"healthy"}

curl http://abc.elb.amazonaws.com:3000/call-service-b
# Response: {"message":"Service B called","data":{"message":"Hello from Service B"}}
```

---

## Viewing Traces in Jaeger UI

> From the video: "The reason why I like Jaeger a lot is it does not complicate the tracing. It's very simple — provide the name of the service, provide the operation, click find traces and you get the complete details."

**Searching for traces:**

```
1. Go to Jaeger UI: http://localhost:16686
2. Select Service: service-a
3. Select Operation: all
4. Click "Find Traces"
5. You will see traces listed with span count and duration
```

**What a single service trace looks like (/healthy endpoint):**

```
Trace: service-a GET /healthy
Total Duration: 13 microseconds
Spans: 6

  service-a
  ├── middleware             2µs
  ├── express.init          1µs
  ├── logger                1µs
  ├── anonymous             2µs
  └── GET /healthy          7µs   ← actual handler

Click on "GET /healthy" span → you see:
  Duration: 7 microseconds
  http.method: GET
  http.status_code: 200
```

**What a distributed trace looks like (service-a calling service-b):**

```
Trace: service-a → service-b
Total Duration: 168 microseconds
Services: 2
Spans: 12

  service-a
  ├── middleware
  ├── express.init
  ├── logger
  ├── GET /call-service-b
  │     │
  │     │ HTTP call to service-b
  │     ▼
  │   service-b
  │   ├── middleware
  │   ├── express.init
  │   ├── logger
  │   └── GET /hello       ← service-b's handler
  │
  └── Response received
```

> From the video: "See — number of services became two! And if you select service-b and click find traces, you will find that the request to service-b came from service-a with 12 spans. First it went to middleware, then logger, then anonymous, then from service-a request went to call-service-b function, from there it called the middleware of service-b, express init, logger, and finally the /hello endpoint of service-b which returned the output."

**How to use this in real work:**

> From the video: "Imagine how useful this is for developers when you have a request that goes through 10 services. This information will help developers identify where there is a latency. This took 62 microseconds, this took 168 microseconds — why did it take 168? They will go to the code, try to understand: can we make it 100 microseconds in the next release? That can be a story they work on."

---

## Troubleshooting — Jaeger CrashLoopBackOff (Real Debug Story from Video)

> From the video: "Let's use the port forward command and access the UI. Okay it says there is some problem loading."

```bash
kubectl get pods -n tracing
# jaeger-query-xxx   0/1   CrashLoopBackOff   5   5m
```

**Debugging step:**

```bash
kubectl describe pod jaeger-query-xxx -n tracing
# Events section shows:
# Warning: Liveness probe failed
# Warning: Readiness probe failed
```

> From the video: "I immediately understood there should be something with the configuration because I use them a lot. There should be an issue with the certificate or the CSR file."

**Root cause found:**

```
The developer (instructor) had a previous Elasticsearch instance.
They deleted it and created a new one.
BUT forgot to delete the old ConfigMap and Secret.

The old ConfigMap had the OLD certificate.
The new Elasticsearch has a NEW certificate.
Jaeger tried to use the OLD certificate → connection failed.
Jaeger could not start → Liveness probe failed → CrashLoopBackOff.
```

**The Fix:**

```bash
# Step 1: Delete the stale certificate ConfigMap
kubectl delete configmap elasticsearch-ca-cert -n tracing

# Step 2: Delete the stale credentials Secret
kubectl delete secret elasticsearch-credentials -n tracing

# Step 3: Re-extract the NEW CA certificate
kubectl get secret elasticsearch-master-certs \
  -n logging \
  -o jsonpath='{.data.ca\.crt}' | base64 -d > /tmp/es-ca-new.crt

# Step 4: Recreate ConfigMap with NEW certificate
kubectl create configmap elasticsearch-ca-cert \
  --from-file=ca.crt=/tmp/es-ca-new.crt \
  -n tracing

# Step 5: Recreate Secret with new password
kubectl create secret generic elasticsearch-credentials \
  --from-literal=username=elastic \
  --from-literal=password=$ES_PASSWORD \
  -n tracing

# Step 6: All four Jaeger pods now running
kubectl get pods -n tracing
# jaeger-agent-xxx       1/1   Running
# jaeger-collector-xxx   1/1   Running
# jaeger-query-xxx       1/1   Running  ✅ Fixed!
```

> From the video: "This is how you need to troubleshoot as well. As soon as you see liveness probe and readiness probe failing, you understand the application has not started. The most common reason is a configuration or connection issue."

---

## Jaeger UI — Additional Features

> From the video: "You can also go to the system architecture — you can go to the monitoring part where it requires the Prometheus time series database which we haven't integrated yet — but you can get information such as P99 latency and other things."

```
Jaeger UI Tabs:

1. Search       → Find traces by service, operation, duration
2. Compare      → Compare two traces side by side
3. Monitor      → P99/P95 latency (requires Prometheus integration)
4. System Arch  → Auto-generated service dependency map
                  Shows which services call which services
                  Automatically generated from trace data!
```

---

## 🎤 Day 6 Interview Questions & Answers

**Q1: What is distributed tracing and why is it needed in microservices?**

> Distributed tracing tracks a single request's complete journey across multiple microservices. In a monolith, debugging is simple — one codebase, one log file. In microservices, a single user request can touch 10 or more services. When there is latency or an error, distributed tracing shows you exactly which service, which function, and how long each hop took. Without it, identifying a problem across 15 services could take days.

**Q2: What is the difference between a Trace and a Span?**

> A trace is the entire end-to-end journey of one request through the whole system. It has a unique trace ID that follows the request everywhere. A span is one individual unit of work within that trace — one function call, one service hop, one database query. A trace is made up of multiple spans organized in a parent-child hierarchy.

**Q3: What are the four components of Jaeger?**

> Agent receives span data from the instrumented application. Collector receives spans from the Agent, processes them, and writes to storage. Storage is the database backend — Elasticsearch is preferred and can be shared with the EFK logging stack. Query or UI is the web interface on port 16686 for searching and visualizing traces.

**Q4: How does Jaeger store trace data and which database is recommended?**

> Jaeger is not opinionated about storage — you can use Elasticsearch, Cassandra, or ScyllaDB. Elasticsearch is the preferred option because it is fast, supports rich queries, and if you are already using it for log storage through EFK stack, you can reuse the same instance for traces too — saving resources.

**Q5: What would you check if Jaeger Query pod is in CrashLoopBackOff?**

> First run kubectl describe pod on the Jaeger query pod and look at the Events section — if liveness and readiness probes are failing, the application is not starting. Then check the logs with kubectl logs and the --previous flag to see the actual crash reason. The most common causes are a stale TLS certificate in the ConfigMap after Elasticsearch was reinstalled, or a wrong password. Fix by deleting and recreating the ConfigMap and Secret with fresh values.

---

# 📗 DAY 7 — End-to-End Observability Project with OpenTelemetry Demo App

## What is the OpenTelemetry Demo Application?

> From the video: "The demo application that you see here is developed for demonstrating OpenTelemetry and maintained by top observability companies like Datadog, Dynatrace, Microsoft, Alibaba, Grafana Labs — all of them together work on developing and contributing to the source code of this application so that anybody who wants to learn about OpenTelemetry or observability can use it for demo purpose."

```
GitHub: github.com/open-telemetry/opentelemetry-demo

Maintained by:
  ✅ Datadog
  ✅ Dynatrace
  ✅ Microsoft
  ✅ Alibaba
  ✅ Grafana Labs
  ✅ And many more CNCF contributors
```

**Why this application is the best for learning observability:**

> From the video: "This is the best project available on GitHub. It is a multi-microservice architecture application just like any real e-commerce application. It has cart service, currency service, payment service, email service, recommendation service, shipping service and each is written in different programming languages."

```
Services and Languages:
  Cart Service           → .NET / C#
  Checkout Service       → Go
  Product Catalog        → Go
  Payment Service        → Node.js
  Shipping Service       → Rust
  Email Service          → Ruby
  Recommendation         → Python
  Currency Service       → Node.js
  Ad Service             → Java
  Frontend               → TypeScript
  Load Generator         → Python (generates fake traffic automatically)
```

---

## Observability = Instrumentation + Implementation (Full Explanation)

> From the video: "If you want to add this to your resume or want to learn observability, something important that I mentioned in the series — in order to have a well set up observability, there are two things."

```
THING 1: INSTRUMENTATION OF METRICS
  → Your development team who are writing the microservices
  → These microservices should emit metrics
  → They should emit logs
  → They should emit traces
  → No matter how simple or complex the microservice is

THING 2: IMPLEMENTATION OF OBSERVABILITY
  → You are a DevOps or SRE engineer
  → You deploy the tracing tools (Jaeger)
  → You deploy the monitoring tools (Prometheus, Grafana)
  → You deploy the logging tools (EFK)
  → You set up Kubernetes clusters
  → You configure everything
```

**How to check if an application is instrumented (as a DevOps engineer):**

> From the video: "The first thing that you should ask is: is the microservice instrumented with Telemetry data? Telemetry data is nothing but metrics, logs, and traces. You can go to the source code and check what libraries they are using."

**Checking the Python Recommendation Service:**

```python
# If you go to recommendation_server.py and see:
from opentelemetry import trace, metrics  # ← OTel imported!

# And in the code:
tracer = trace.get_tracer("recommendation-service")

# And metrics defined:
recommendations_counter = meter.create_counter(
    "app.recommendations.counter",
    description="Number of recommendations made"
)
# ✅ This service IS instrumented
```

**Checking the Go Checkout Service:**

```go
// If you go to main.go and see:
import (
    "go.opentelemetry.io/otel"          // ← OTel imported!
    "go.opentelemetry.io/otel/trace"    // ← Trace module
    "go.opentelemetry.io/otel/metric"   // ← Metrics module
)

// And in the code:
tracer := otel.Tracer("checkout-service")

// And metrics defined:
orderCounter, _ = meter.Int64Counter("app.orders.placed")
// ✅ This service IS instrumented
```

---

## Why OpenTelemetry? The Vendor Lock-in Problem

> From the video: "Why should your development team use OpenTelemetry? This question can be asked in DevOps interviews. The reason is there are hundreds of observability tools in the market."

**The problem without OpenTelemetry:**

```
Imagine your company uses Prometheus today.
Developers write code using Prometheus client SDK:
  → service-a uses prom-client (npm)
  → service-b uses prometheus_client (python)
  → service-c uses client_golang (go)
  ... 100 microservices total

Now your company decides to move to Datadog.

What happens?
  → 100 developers need to change code in every service
  → They need to replace Prometheus SDK with Datadog SDK
  → Test everything again
  → This takes MONTHS
  → Risk of bugs during migration
  → Temporary loss of observability during changeover

This is vendor lock-in. It is a real and costly problem.
```

**The solution — OpenTelemetry:**

> From the video: "What a common thing that CNCF has come up with is a project called OpenTelemetry where they said: instead of using Prometheus client, use OpenTelemetry APIs and SDKs. And in the exporter, you can define whether metrics should go to Prometheus, traces to Jaeger, etc."

```
With OpenTelemetry:
  ALL services use OTel SDK (same standard for everyone)
  → service-a uses @opentelemetry/sdk-node
  → service-b uses opentelemetry-sdk (Python)
  → service-c uses go.opentelemetry.io/otel

Now company decides to move from Jaeger to Datadog:
  → Change ONE config file (the exporter configuration)
  → Update: exporter = datadog instead of jaeger
  → Deploy the updated config
  → ALL 100 services automatically send to Datadog
  → Zero changes in any application code ✅

This is vendor neutrality.
```

> From the video: "OpenTelemetry has become a standard so that tomorrow if you want to move from X to Y it will not be a problem because all of these observability companies have agreed to accept the standard that is OpenTelemetry."

---

## How OpenTelemetry Actually Works — The Architecture

> From the video: "Let me explain the architecture so that you will find things much much easier."

**The complete flow:**

```
STEP 1: Developer writes microservice
  → Along with application code
  → They use OpenTelemetry APIs and SDKs
  → To emit metrics, logs, and traces

STEP 2: OTel RECEIVER
  → A receiver component of OpenTelemetry
  → Receives this telemetry information from the app

STEP 3: OTel PROCESSOR
  → Processes all the telemetry information
  → Can filter, batch, enrich, sample the data

STEP 4: OTel EXPORTER
  → Exports metrics/logs/traces to any backend
  → This is defined in the exporter configuration file
  → Change this file = change your backend

Full flow:
  App code (OTel SDK)
    ↓
  OTel Receiver
    ↓
  OTel Processor
    ↓
  OTel Exporter
    ↓
  Backend (Jaeger / Prometheus / Elasticsearch / Datadog)
```

**How it connects to Jaeger:**

```
OTel Exporter sends traces to Jaeger:
  → Jaeger AGENT receives them (like receiver)
  → Jaeger COLLECTOR processes them
  → ELASTICSEARCH stores them
  → JAEGER UI lets you view them

If you want to switch to Datadog tomorrow:
  → Change exporter to send to Datadog agent
  → Datadog receives, processes, stores, shows
  → Application code unchanged ✅
```

**How it connects to Prometheus:**

```
OTel Exporter sends metrics:
  → OTel Collector exposes /metrics endpoint
  → Prometheus SCRAPES that endpoint
  → Prometheus stores in TIME SERIES DB
  → PROMETHEUS HTTP SERVER answers PromQL queries
  → GRAFANA shows dashboards
```

> From the video: "This is how OpenTelemetry has become vendor agnostic."

---

## Deploying the OpenTelemetry Demo App on EKS

> From the video: "You don't need to search for these applications on the internet. Just go to the day4 folder — I mean go to the OpenTelemetry official demo application documentation. Two simple steps."

**How to find the deployment steps:**

```
1. Go to the OpenTelemetry Demo GitHub repository
2. Scroll down → click on "Kubernetes" in the documentation
3. Two steps:
   Step 1: Add the Helm chart
   Step 2: Run helm install
```

```bash
# Step 1: Add OTel Demo Helm repository
helm repo add open-telemetry \
  https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update

# Step 2: Install the demo application
helm install my-otel-demo open-telemetry/opentelemetry-demo

# Wait for all pods to come up (may take 3-5 minutes)
kubectl get pods
# You will see 20+ pods — all the microservices plus
# Jaeger, Prometheus, Grafana, OTel Collector all bundled!
```

> From the video: "This demo application already comes with Jaeger installed using this Helm chart. If you do kubectl get pods, you can see that Jaeger is already installed. You don't have to go to Jaeger official files or my GitHub repository — it is all bundled."

**All pods you will see:**

```
kubectl get pods
# my-otel-demo-adservice-xxx              ← Ad Service
# my-otel-demo-cartservice-xxx            ← Cart Service
# my-otel-demo-checkoutservice-xxx        ← Checkout Service
# my-otel-demo-currencyservice-xxx        ← Currency Service
# my-otel-demo-emailservice-xxx           ← Email Service
# my-otel-demo-frontendservice-xxx        ← Frontend
# my-otel-demo-frontendproxy-xxx          ← Envoy Proxy
# my-otel-demo-loadgenerator-xxx          ← Fake traffic generator!
# my-otel-demo-paymentservice-xxx         ← Payment Service
# my-otel-demo-productcatalogservice-xxx  ← Product Catalog
# my-otel-demo-recommendationservice-xxx  ← Recommendation
# my-otel-demo-shippingservice-xxx        ← Shipping Service
# my-otel-demo-jaeger-xxx                 ← Jaeger (bundled!)
# my-otel-demo-prometheus-xxx             ← Prometheus (bundled!)
# my-otel-demo-grafana-xxx                ← Grafana (bundled!)
# my-otel-demo-otelcol-xxx               ← OTel Collector
```

---

## Accessing the Application and Observability Tools

```bash
# Access the frontend application
kubectl port-forward svc/my-otel-demo-frontendproxy 8080:8080
# Open: http://localhost:8080

# If using EC2 instance:
kubectl port-forward svc/my-otel-demo-frontendproxy 8080:8080 \
  --address 0.0.0.0
# Access via: http://<ec2-public-ip>:8080
```

> From the video: "Because you want to learn about observability, try to add few applications to the cart, try to perform some actions. Once you have Jaeger, once you have Grafana, you can see the traces. Only if you execute things will you see those request traces. Of course this application also has a fake load generator so even if you don't perform actions you can see the load."

```bash
# Access Jaeger UI
# From the documentation: just append /ui to get Jaeger
kubectl port-forward svc/my-otel-demo-jaeger-query 16686:16686
# Open: http://localhost:16686/ui

# Access Grafana
kubectl port-forward svc/my-otel-demo-grafana 3000:80
# Open: http://localhost:3000
# No username/password required (disabled in demo)

# Access Prometheus
kubectl port-forward svc/my-otel-demo-prometheus 9090:9090
# Open: http://localhost:9090
```

---

## Exploring Traces in Jaeger UI

> From the video: "You can see all 17 services. There is a fake load generator in the project which is generating fake load so you can understand different traces."

**Looking at Cart Service trace:**

```
1. Select Service: cartservice
2. Click "Find Traces"
3. You can find complete traces of this application
```

> From the video: "Which microservices called the cart service? The frontend application called the cart service and the request propagated. Context propagation happened from frontend-web to the frontend-proxy — as explained in architecture first there is a frontend proxy, from there frontend, from there we look at the cart service. From there the request goes to the checkout service. From checkout a gRPC request is made to the cart service."

**What you see when you click on a trace:**

```
Trace: frontend → frontendproxy → cartservice → get_cart function

When you click on the cart service span, you see:
  container_id: abc123
  cloud.region: us-east-1
  k8s.pod.name: cartservice-xxx
  k8s.namespace.name: default
  rpc.method: GetCart
  rpc.service: hipstershop.CartService
  rpc.system: grpc
  Duration: 13 microseconds
```

> From the video: "If you want more details just click on this arrow and you get complete details in a well-formatted structure — everything that Jaeger provides."

**Looking at Checkout Service (more complex trace):**

> From the video: "There are 47 spans to reach the checkout service! Because to checkout you first need to add an item to the cart — only if you add an item to the cart can you go to checkout. So the trace clearly explains: from frontend it goes to cart service, from there it goes to checkout service. And if anything goes wrong, you can see it in the traces very clearly."

---

## Exploring Metrics in Grafana

```bash
# Access Grafana
kubectl port-forward svc/my-otel-demo-grafana 3000:80
# http://localhost:3000
# No login required for this demo
```

**Pre-built dashboards:**

> From the video: "In the Grafana dashboard you can see there is a predefined demo dashboard. You can see the latency that occurred for the frontend, the error rate for the frontend."

```
Grafana → Dashboards → Demo Dashboard
Shows:
  → Frontend latency (P50, P95, P99)
  → Error rate
  → Request rate
```

**Creating a custom dashboard:**

> From the video: "If you don't want to use the default dashboards, click on New → Create a Dashboard → Add visualization. Of course your backend has to be Prometheus and you can fire your PromQL queries as well."

```promql
# Example custom PromQL queries for this application:

# HTTP Server Duration for flagd service
http_server_duration_milliseconds_bucket{job="flagd"}

# Recommendation counter (custom metric from Python service)
app_recommendations_counter_total

# Filter for last 5 minutes
rate(app_recommendations_counter_total[5m])
```

**Why some metrics are missing:**

> From the video: "This Prometheus instance or this Prometheus data source does not scrape metrics information related to the nodes or Kubernetes cluster. For example if I search for 'pod' there is no information. Or node CPU — there is nothing. Why? As I explained in previous classes, for Prometheus to scrape metrics from nodes or Kubernetes cluster, it needs exporters. If you look at the pods installed, you will not see Kube State Metrics or Node Exporter. That's why Prometheus cannot get any information about the underlying nodes."

```bash
kubectl get pods | grep -E "node-exporter|kube-state"
# → No results! Not installed in the demo.

# To fix this and get infra metrics:
# Go to Day 3 or Day 4 folder and install the full
# kube-prometheus-stack which includes node-exporter
# and kube-state-metrics
```

---

## How to Use This Project for Your Resume

> From the video: "If you want to add it to your resume or if you want to talk about observability in your interviews, this project is going to help you a lot. Multi-microservices written in different programming languages — whichever programming language you are comfortable with, identify the color in the architecture diagram, go to that particular microservice, see how telemetry is instrumented."

**Steps for learning from the codebase:**

```
1. Look at the architecture diagram on GitHub
2. Each service has a color representing the language
   → Green = Go
   → Blue = Python
   → Orange = Java
   → etc.

3. Pick the language you know best
4. Go to that microservice folder in the GitHub repo
5. Open the main code file
6. Look for:
   → What OTel library/module is imported?
   → Where are the spans created?
   → Where are the metrics defined?
   → How are traces sent to the collector?

Example:
  You know Python → Go to recommendationservice folder
  Look at recommendation_server.py
  See: from opentelemetry import trace, metrics
  See: tracer.start_as_current_span("ListRecommendations")
  See: recommendations_counter.add(len(product_ids))
  → Now you understand Python instrumentation!
```

**Resume bullet point example:**

```
• Deployed OpenTelemetry Demo Application (15+ microservices
  in Go, Python, Java, Node.js, .NET, Rust) on AWS EKS cluster

• Implemented distributed tracing using Jaeger, analyzing
  request flows across 15 microservices with span-level
  latency analysis

• Configured Prometheus for application metrics and created
  custom Grafana dashboards for real-time monitoring

• Identified performance bottlenecks using Jaeger traces
  showing latency spikes in service-to-service communication

Technologies: AWS EKS, Kubernetes, Helm, OpenTelemetry,
              Jaeger, Prometheus, Grafana, Docker
```

---

## OTel Collector Configuration — Receiver, Processor, Exporter

```yaml
# otel-collector-config.yaml
# Full configuration showing all three components

# ═══════════════════════════════════════
# RECEIVER: Accept telemetry from apps
# ═══════════════════════════════════════
receivers:
  otlp:                     # Standard OTel protocol
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317   # gRPC port
      http:
        endpoint: 0.0.0.0:4318   # HTTP port

# ═══════════════════════════════════════
# PROCESSOR: Transform and filter
# ═══════════════════════════════════════
processors:
  batch:
    timeout: 1s              # Send every 1 second in batches
    send_batch_size: 1024    # Or when 1024 items collected
  memory_limiter:
    check_interval: 1s
    limit_mib: 512           # Prevent OOM

# ═══════════════════════════════════════
# EXPORTER: Send to backends
# ═══════════════════════════════════════
exporters:
  # Traces → Jaeger
  jaeger:
    endpoint: jaeger-collector:14250
    tls:
      insecure: true

  # Metrics → Prometheus
  prometheus:
    endpoint: "0.0.0.0:8889"  # Prometheus scrapes this

  # If you want to switch to Datadog tomorrow:
  # Just change this exporter!
  # datadog:
  #   api:
  #     key: ${DATADOG_API_KEY}

# ═══════════════════════════════════════
# PIPELINES: Wire everything together
# ═══════════════════════════════════════
service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [memory_limiter, batch]
      exporters: [jaeger]
    metrics:
      receivers: [otlp]
      processors: [memory_limiter, batch]
      exporters: [prometheus]
```

---

## 🎤 Day 7 Interview Questions & Answers

**Q1: What is the OpenTelemetry Demo Application and why is it useful?**

> It is an official CNCF open-source e-commerce application with 15 or more microservices written in multiple languages including Go, Python, Java, Node.js, .NET, and Rust. It is maintained by companies like Datadog, Dynatrace, Microsoft, and Grafana Labs. It comes pre-instrumented with OpenTelemetry and bundles Jaeger, Prometheus, and Grafana. It is the best project for learning observability because it reflects real production complexity, provides professional-grade instrumentation examples in multiple languages, and can be deployed on any Kubernetes cluster with a single Helm command.

**Q2: What is OpenTelemetry and why has it become the industry standard?**

> OpenTelemetry is a CNCF project that provides a vendor-neutral, open-source SDK for instrumenting metrics, logs, and traces in applications. It became the standard because previously developers used vendor-specific SDKs like Prometheus client or Jaeger client. When a company wanted to switch monitoring tools, they had to update every single microservice — which could be hundreds of services. With OpenTelemetry, you instrument code once using standard APIs and only change the exporter configuration to switch backends. All major observability companies have agreed to support the OpenTelemetry standard.

**Q3: What are the three components of the OpenTelemetry Collector pipeline?**

> Receiver accepts telemetry data from applications in various protocols like OTLP over gRPC or HTTP. Processor transforms, filters, batches, and enriches the telemetry — for example adding environment labels, redacting PII, or sampling. Exporter forwards the processed telemetry to backend systems like Jaeger, Prometheus, Elasticsearch, or Datadog. Multiple exporters can run at the same time, sending the same data to multiple backends simultaneously.

**Q4: How does switching observability backends work with OpenTelemetry?**

> Because all services use the OpenTelemetry SDK to instrument code, the application code is completely decoupled from the backend. The OTel Collector's exporter configuration determines where data goes. To switch from Jaeger to Datadog, you only update the exporter in the OTel Collector config from Jaeger to Datadog. All your microservices continue working without any code changes. This is the vendor neutrality that makes OpenTelemetry so valuable.

**Q5: Why does the bundled Prometheus in the OTel demo not show node or pod metrics?**

> The Prometheus bundled with the OpenTelemetry demo application is configured only to scrape application-level metrics from the OTel Collector. It does not have Node Exporter or Kube State Metrics installed. Node Exporter is needed to collect CPU, memory, and disk metrics from nodes. Kube State Metrics is needed to collect Kubernetes object metrics like pod restarts and deployment status. To get infrastructure metrics, you need to separately install the kube-prometheus-stack Helm chart which includes both of these exporters.

---

## 📝 Complete Series Summary — Days 2 to 7

```
DAY 2 — Metrics & Prometheus
  → Metrics = numbers describing system health
  → Prometheus = scrapes metrics every 15-30s, stores in TSDB
  → Node Exporter = server metrics (DaemonSet, one per node)
  → Kube State Metrics = K8s object metrics (one Deployment)
  → Install: helm install prometheus-community/kube-prometheus-stack

DAY 3 — PromQL + Grafana
  → PromQL = query language for Prometheus (like SQL for TSDB)
  → Time Series DB = stores data points with timestamps
  → CrashLoopBackOff = pod restarts visible in kube_pod_container_status_restarts_total
  → Grafana = rich dashboards, RBAC, multiple data sources
  → Common issue: "No Data" in Grafana → change datasource to Prometheus

DAY 4 — Custom Metrics + AlertManager
  → Instrumentation = writing metrics/logs/traces inside app code
  → Observability = Team effort (Dev instruments, DevOps implements)
  → Counter → always increasing (total requests, total logins)
  → Gauge → goes up and down (CPU%, active connections)
  → Histogram → distribution in buckets (request latency)
  → Summary → client-side percentiles (less preferred in K8s)
  → ServiceMonitor → tells Prometheus which services to scrape
  → 3 steps: Instrument → Setup Prometheus → ServiceMonitor
  → AlertManager → routes alerts to email/Slack/PagerDuty

DAY 5 — Logging + EFK Stack
  → Logs = messages in code explaining what app is doing
  → EFK = Elasticsearch (database) + Fluent Bit (collector) + Kibana (UI)
  → Fluent Bit = DaemonSet (one per node, reads /var/log/containers/)
  → Elasticsearch = StatefulSet with EBS volumes for persistence
  → Kibana = web UI for searching logs (port 5601)
  → EFK vs ELK: Fluent Bit lighter, vendor neutral
