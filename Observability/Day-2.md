# Observability Zero to Hero — Day 2 (Episode 2): Metrics + Monitoring + Prometheus — End-to-End Notes (Deep)

## 1) Episode goal (what Day 2 is about)
- Day 2 is about the **first pillar of observability: Metrics**.
- Along with metrics, Day 2 teaches **Monitoring** (because metrics become useful only when a monitoring system reads them, visualizes them, and alerts on them).
- The practical tool used: **Prometheus** (monitoring) + **Grafana** (dashboards) + **Alertmanager** (alerting).

---

## 2) What you learn in this episode (full outline)
1. What is **metrics** (real-life example).
2. Difference between **metrics vs monitoring**.
3. Examples of commonly used metrics by **DevOps / SRE** teams.
4. What is **Prometheus**.
5. **Prometheus architecture** and components (conceptually):
   - retrieval (scraping)
   - exporters
   - pushgateway
   - time series database (TSDB)
   - HTTP server / UI
   - alertmanager
6. Install Prometheus on **EKS**.
7. Configure **Prometheus as a Grafana data source** and visualize.

---

## 3) Notes & revision workflow (how to study after watching)
- Notes are in the GitHub repo in the **Day 2** folder (`README.md`).
- The notes contain:
  - diagrams and architecture references
  - commands used in the video
- Suggested revision routine:
  - after watching, spend **15–20 minutes** reviewing the Day 2 notes.

---

## 4) What is Metrics? (real-life analogy explained end-to-end)

### 4.1 Hospital patient analogy
- A patient is admitted in a hospital.
- A nurse is assigned to attend the patient periodically:
  - every 15 minutes / 30 minutes / once an hour depending on criticality.
- The nurse collects key information/data points:
  - heartbeat
  - blood pressure
  - and other important information.

### 4.2 Why data is collected periodically
- Nurse maintains a record of values over time.
- Example (heartbeat):
  - 10:00 AM → 76
  - 10:15 AM → 81
- Similarly, records blood pressure and other values throughout the day.

### 4.3 How the doctor uses it
- At the end of the day, a doctor checks the periodic historical information to decide:
  - whether the patient’s health is stable
  - whether something abnormal happened at a specific time
  - whether patient needs more time in the hospital or critical observation.

### 4.4 Core definition derived from the analogy
- These periodic/historical measurements (heartbeat, BP, etc.) are **metrics**.
- **Metrics = historical data of events to understand the health of a system.**

---

## 5) Why metrics alone are not enough (raw data problem)
- Metrics are often raw numeric data stored in:
  - a notepad
  - an Excel sheet
- This is hard to read and easy to miss anomalies because:
  - there is too much numerical data
  - spikes and unusual patterns are not visually obvious.

---

## 6) What is Monitoring? (how monitoring system works)

### 6.1 Monitoring system responsibilities
A monitoring system does 3 key things:
1. **Reads/collects metrics**
   - typically via **pull** (scraping)
   - sometimes via push (depending on design)
2. **Represents metrics in a readable way**
   - dashboards
   - graphs
   - charts
3. **Sends alerts when something is wrong**
   - notify nurse/doctor in hospital analogy
   - notify DevOps/SRE/dev teams in IT systems

### 6.2 Monitoring analogy in hospital
- Heartbeat cannot always be recorded manually (e.g., every 30 seconds).
- A machine continuously reads heartbeat and displays it.
- Alerts:
  - heartbeat > 90 → notify nurse
  - heartbeat > 110 → notify doctor

### 6.3 Final conclusion: metrics vs monitoring
- **Metrics** are the raw periodic historical measurements.
- **Monitoring** = metrics + dashboards + alerting.
- Metrics are a **subset**; monitoring is the **superset**.

---

## 7) Mapping the same concept to IT systems (end-to-end)

### 7.1 The “patient” becomes your IT system
Assume:
- You have an application deployed on AWS on a Kubernetes cluster.
- Kubernetes nodes are AWS virtual machines.
- Networking exists (VPC, etc.)
To keep the system healthy:
- you need to monitor application + cluster + infrastructure.

### 7.2 Infrastructure metrics examples (AWS VM / Kubernetes nodes)
- CPU utilization over time:
  - CPU at 10:00 AM
  - CPU at 12:00 PM
  - detect spikes (e.g., evening traffic)
- Memory utilization
- Disk utilization

### 7.3 Kubernetes metrics examples
- Pod status
- CrashLoopBackOff counts over the day + timestamps
- Deployment status
- HPA replica changes throughout day (2 replicas vs 10 replicas)

### 7.4 Application metrics examples
- HTTP requests received:
  - total in a day
  - received traffic during specific time windows
- Business/user metrics (depends on org):
  - number of signups (last 30 days)
  - what time of day signups occur
  - deactivations
  - time spent on platform
- You might collect 10 metrics or 50 or hundreds; it depends on your needs.

---

## 8) Monitoring in IT (exact responsibilities)
- Metrics are either:
  - pushed to the monitoring system, or
  - pulled/scraped by the monitoring system.
- “Scraping” is a key term used to mean **pulling** metrics.
- Monitoring system:
  - visualizes metrics as graphs
  - allows selecting time windows (10 days / 30 days / 1 year)
  - similar to stock market graphs (historical data → chart)

### 8.1 Alerting in monitoring system (IT examples)
- CPU > 80% → fire alert
- Disk > 75% → Slack message to DevOps/SRE group
- Latency issue example:
  - normal: 5 seconds
  - observed: 10 seconds
  - if observed 30 times/day → alert dev team (Slack/Gmail)
- DevOps/SRE create alert rules:
  - when to fire
  - where to fire (Slack/email/etc.)

---

## 9) Prometheus (where it comes in)

### 9.1 What Prometheus is
- Prometheus is a very popular open-source monitoring platform in Kubernetes.
- Prometheus can:
  - scrape/pull metrics from different sources
  - sometimes accept pushed metrics (commonly via Pushgateway)

### 9.2 What Prometheus provides as a monitoring system
- collects/scrapes metrics from AWS/Kubernetes/apps
- stores them
- exposes querying via UI/HTTP server
- includes alerting capabilities using **Alertmanager**
- commonly integrated with **Grafana** for rich dashboards

---

## 10) Prometheus architecture (explained end-to-end)

### 10.1 Prometheus server and retrieval
- Prometheus server is the component installed.
- Inside Prometheus server, **retrieval** pulls (scrapes) metrics from sources.

### 10.2 Exporters and Pushgateway
- Retrieval pulls metrics from:
  - exporters (common)
  - Pushgateway (optional) where apps push metrics to Pushgateway then Prometheus scrapes it
- In the lesson: for beginners, focus on:
  - retrieval scrapes exporters → stores in TSDB.

### 10.3 Time Series Database (TSDB)
- Metrics depend heavily on time.
- TSDB stores:
  - timestamp + key/value (and labels conceptually)
- Example mapping: at 10:00 AM, heartbeat=81.

### 10.4 HTTP server + PromQL
- To get data from Prometheus, you query via:
  - Prometheus HTTP server/UI
  - using **PromQL**
- Example: “give me last 30 minutes data”
- Prometheus returns the requested series.

### 10.5 Alertmanager
- Prometheus stack includes Alertmanager
- Alertmanager is used to fire alerts based on rules.

### 10.6 Service discovery (targets)
- Prometheus can be configured to scrape only selected apps/targets:
  - e.g., scrape 50 apps out of 100
- This is done using Prometheus service discovery / target configuration.

---

## 11) Grafana in the stack
- Grafana provides very rich dashboards and visualization.
- Prometheus + Grafana together are commonly used:
  - Prometheus supplies metrics & queries
  - Grafana supplies dashboards
  - Alerts are part of the monitoring stack (Prometheus/Alertmanager; Grafana also has alerting features, but in this video focus is Prometheus stack with Alertmanager)

---

## 12) Practical installation (EKS + Helm) — end-to-end steps covered

### 12.1 Prerequisites: Kubernetes cluster
- Can use minikube/microk8s, but video uses **EKS** for real-time feel.

### 12.2 EKS setup notes mentioned
- Day 2 repo notes include EKS creation commands:
  - create cluster
  - associate OIDC provider
  - associate node group
- Why OIDC provider matters:
  - enables Kubernetes service account ↔ AWS IAM roles/policies mapping
  - important when in-cluster apps need AWS access

### 12.3 Helm setup
- Ensure Helm is installed.
- Add helm repositories for Prometheus (commands in notes).

### 12.4 Namespace creation
- Create a namespace like `monitoring` to install:
  - Prometheus
  - Grafana

### 12.5 Clone repo and run helm install with custom values
- Clone the Observability Zero to Hero repository.
- Go to Day 2 folder locally.
- Run helm command using the provided custom values file.

#### Why custom values file?
- Enables Alertmanager (for future lessons).
- Default stack includes server/retrieval/TSDB/HTTP server; custom adds alertmanager.

### 12.6 Validate installation
- `kubectl get pods -n monitoring`
- Expect to see:
  - Prometheus pods
  - kube-state-metrics
  - node-exporter
  - Grafana
  - Alertmanager

### 12.7 Accessing UIs
In the lesson, access is done via `kubectl port-forward` (not Ingress to avoid complexity early):
- Prometheus UI (9090)
- Grafana (3000)
- Alertmanager (9093)

Grafana login shown:
- username: `admin`
- password: `prom-operator`

Real org approach:
- expose via **Ingress + Ingress controller** (later videos)

### 12.8 Grafana dashboards and datasource
- Grafana already has default dashboards (to explore next class).
- Add Prometheus datasource:
  - Connections → add connection → Prometheus datasource → provide Prometheus URL.
- More metrics and dashboards exploration will be done in next class.

---

## 13) How Prometheus scrapes “tons of metrics” (key mechanism)

### 13.1 Exporters concept
- Exporters are add-ons/plugins that expose metrics in Prometheus format.
- Prometheus scrapes exporters.

### 13.2 Node exporter (infrastructure/node metrics)
- Usually installed by default with Helm chart.
- Runs on/for nodes and collects:
  - CPU, memory, disk, etc.
- Collects data from node system files (like proc/system sources).
- Prometheus scrapes node exporter → gets node metrics.

### 13.3 kube-state-metrics (Kubernetes resource metrics)
- Collects data from Kubernetes API server:
  - pod status
  - deployment status
  - crashes
  - events
  - resource states (configmaps, secrets, etc.)
- Exposes them as metrics.
- Prometheus scrapes kube-state-metrics → gets cluster metrics.

### 13.4 Application-level metrics via `/metrics` endpoint
- For app metrics (HTTP requests, signups, user actions):
  - developers expose a metrics API endpoint, usually `/metrics`.
- Prometheus uses service discovery/targets to scrape specific applications’ `/metrics`.

### 13.5 “Three primary sources” summary
1. Node exporter → infrastructure metrics
2. kube-state-metrics → Kubernetes resource/cluster metrics
3. Application `/metrics` endpoint → application/business/user metrics

---

## 14) Prometheus competitors (awareness)
Mentioned alternatives:
- Nagios
- InfluxDB
- Graphite
- open source + closed source options exist

Why Prometheus is common:
- Strong community
- CNCF ecosystem adoption
- Many companies/tools build on Prometheus rather than building monitoring from scratch

---

## 15) Next class preview (what you should be ready for)
- Next class focuses on:
  - **PromQL**
  - querying metrics from:
    - node exporter
    - kube-state-metrics
  - visualizing those metrics on Grafana dashboards (graphs/representation)

---
