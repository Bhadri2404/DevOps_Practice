# Observability Zero to Hero — Day 3 (Episode 3): Prometheus Scraping in Practice + PromQL + Grafana — End-to-End Notes (Deep)

## 1) Context recap (Days 1–2)
### Day 1 (Episode 1)
- Fundamentals of observability:
  - what is observability
  - three pillars (metrics, logs, traces)
  - monitoring vs observability

### Day 2 (Episode 2)
- Metrics + Monitoring in depth (real-world analogy).
- Prometheus basics:
  - architecture overview
  - install/configure on EKS
  - install Prometheus stack: **Prometheus + Alertmanager + Grafana**
  - access from browser (via port-forward)

---

## 2) Day 3 goal (what this episode focuses on)
This episode is practical-heavy:
- Understand Prometheus architecture **practically**:
  - how Prometheus scrapes metrics in real time
- See how Prometheus collects metrics from:
  - **node-exporter**
  - **kube-state-metrics**
  - other sources
- Learn **PromQL** (Prometheus Query Language):
  - what it is
  - how to write basic queries
- Play with:
  - Prometheus UI
  - Grafana dashboards
  - live metrics
- After video: revise using notes (spend ~10–15 minutes).

---

## 3) Prometheus architecture (whiteboard explanation — practical view)

### 3.1 Prometheus is a monitoring tool
Primary responsibility:
- **scrape metrics** from important sources
- store metrics in a **time series database**
- enable querying via **PromQL**
- enable alerting via **Alertmanager**

### 3.2 Primary metric sources Prometheus scrapes

#### A) Node Exporter (infrastructure / node-level)
- Runs on Kubernetes as a **pod** (typically as a DaemonSet).
- Collects information from **all Kubernetes nodes**:
  - CPU metrics
  - memory metrics
  - other system-level metrics
- Reads from node system files / runs programs to collect data.
- In AWS Kubernetes environment:
  - nodes are EC2 instances / virtual machines.

#### B) kube-state-metrics (cluster state / Kubernetes API)
- Also runs as a pod (exporter/plugin).
- Talks to Kubernetes **API server**.
- Collects a lot of Kubernetes resource info periodically, such as:
  - pod status
  - deployment status
  - replica sets
  - services
  - configmaps
  - custom resources (e.g., validating webhook)
- Exposes these as metrics.

#### C) Custom metrics (application-level)
- Related to application/business behavior, such as:
  - time taken to process an HTTP request
  - number of users created in last 24 hours / 15 min / 1 week
- Developers create these by **instrumentation** (covered in Day 4).
- Instrumentation tools mentioned:
  - OpenTelemetry (developer POV)
  - other sources

### 3.3 Why these sources matter
- If node-exporter or kube-state-metrics are missing:
  - Prometheus can scrape far fewer metrics.
  - Prometheus “loses visibility” because these are key sources.

### 3.4 Other exporters (org-specific)
- Example: **MySQL exporter**
  - If you run MySQL and want DB performance metrics:
    - run MySQL exporter as a pod/service
    - configure it with MySQL IP/address
    - exporter talks to MySQL and exposes metrics for Prometheus to scrape
- Key DevOps/SRE idea:
  - many exporters already exist; you mostly need to deploy/configure them.

---

## 4) Time Series Database (TSDB) — why “time” matters
- Prometheus stores scraped metrics into a **time series database**.
- Time series DB stores:
  - metric values (like key/value or label/value sets)
  - **plus timestamp**
- Why:
  - in metrics, “when” is critical (values are meaningful over time).
- Contrast:
  - traditional DB might store employee name/value, etc.
  - Prometheus needs: “at time T, metric value was X”.

---

## 5) PromQL (Prometheus Query Language) — why it exists
Problem:
- Prometheus holds a huge amount of raw metric data; raw output is hard to read.

Solution:
- PromQL lets users query/aggregate/filter metric data from the TSDB.
- Prometheus has an **HTTP server** component.
- PromQL queries are like SQL queries but for time-series metrics.

PromQL helps you:
- fetch data for a specific time range
- aggregate (sum/avg, etc.)
- view in:
  - raw format
  - graph format

---

## 6) Alertmanager (where alerting fits)
- If a metric crosses a threshold (e.g., CPU abnormal):
  - configure alert rules
  - send alerts to:
    - Slack channel
    - email addresses
- Alertmanager is part of the Prometheus stack used for firing alerts (covered later).

---

## 7) Practical verification: are exporters really collecting metrics?

### 7.1 Why port-forward was used (instead of Ingress)
- Port-forward works uniformly across clusters.
- Ingress setup differs across environments; could confuse beginners.
- Ingress config is provided (especially for AWS ALB), but not focused in this video.

### 7.2 Confirm pods installed in `monitoring` namespace
- After installing the Prometheus stack, it also installs:
  - node-exporter
  - kube-state-metrics
- These are essential for Prometheus to scrape lots of metrics.

### 7.3 Why node-exporter has multiple instances but kube-state-metrics doesn’t
- **node-exporter runs as a DaemonSet**
  - one per node (collect node-specific metrics)
- **kube-state-metrics runs as a single replica**
  - it only needs to talk to the API server
  - node placement doesn’t matter for API calls

---

## 8) Directly hitting exporter `/metrics` endpoints (proof)

### 8.1 Node Exporter `/metrics`
- node-exporter service is ClusterIP (internal only).
- To test it:
  - enter a node (EKS: connect to EC2 via Session Manager; Minikube: `minikube ssh`)
  - run curl:
    - `curl <node-exporter-clusterip>:9100/metrics`
- Output shows huge metric list:
  - CPU, memory, processes/threads, (even goroutines mentioned), etc.
- Key concept:
  - exporter exposes metrics at **`/metrics`**
  - in a format Prometheus understands

### 8.2 kube-state-metrics `/metrics`
- kube-state-metrics service is ClusterIP.
- Test similarly from inside cluster/node:
  - `curl <kube-state-metrics-clusterip>:8080/metrics`
- Output includes metrics about Kubernetes objects.
- You can `grep`:
  - container metrics
  - restart metrics (`grep restart`)
- Example metric mentioned:
  - `kube_pod_container_status_restarts_total`
- Metrics include **labels** (namespace, pod name, etc.) used for filtering.

---

## 9) Querying in Prometheus UI (PromQL in action)

### 9.1 Verify Prometheus has stored exporter data
- Open Prometheus UI via port-forward.
- Use the metric:
  - `kube_pod_container_status_restarts_total`
- Execute query → returns restart counts per container.
- Switch to **Graph** tab to visualize.

### 9.2 Filtering with labels (curly braces)
- PromQL label selector format:
  - `metric_name{label="value"}`
- Example used:
  - filter by namespace:
    - `namespace="default"`
- If no pods in default namespace:
  - query shows nothing (empty graph)

---

## 10) Practical demo: create a crashing pod to generate metrics

### 10.1 Why create a crashing pod?
- To prove kube-state-metrics is collecting restarts and Prometheus is storing and graphing it.

### 10.2 Create a pod that always crashes
- Run a pod that exits with code 1 → goes into CrashLoopBackOff.
- Example approach from transcript:
  - `kubectl run busybox-crash ... -- /bin/sh -c "exit 1"`
- Then:
  - `kubectl get pods`
  - observe restarts increase over time

### 10.3 Re-run PromQL query
- Execute `kube_pod_container_status_restarts_total`
- Now graph shows spikes/points for restarts.
- Adjust time range (1 hour → 1 minute) to see the changes clearly.

### 10.4 Why this is useful in organizations
- Even if someone doesn’t have cluster access:
  - you can create a dashboard/graph and share it.
- With labels you can filter:
  - all namespaces vs one namespace
  - specific pod vs all pods

### 10.5 Data flow explanation (what happened internally)
1. `kubectl run` sends request to Kubernetes API server.
2. kube-state-metrics continuously watches the API server.
3. kube-state-metrics collects pod metrics (like restart totals).
4. kube-state-metrics exposes them on `/metrics`.
5. Prometheus continuously scrapes kube-state-metrics `/metrics`.
6. Prometheus stores metrics into TSDB.
7. User runs PromQL query → Prometheus returns the time-series data.

---

## 11) Exploring more metrics (how to discover “what exists”)

### 11.1 Use Prometheus autocomplete
- In Prometheus UI, start typing `kube...`
- Autocomplete suggests available metrics (e.g., configmap created metrics).

### 11.2 Example exploration: configmaps created
- Query:
  - `kube_configmap_created`
- Filter by namespace:
  - `kube_configmap_created{namespace="kube-system"}`
- Graph/time range changes reveal multiple configmaps and changes.

### 11.3 Do you need to memorize all metrics?
- No.
- You should:
  - research based on org needs
  - know common interview-ready metrics like:
    - pod crash/restarts
    - configmaps/secrets counts
    - CPU/memory/disk utilization
    - HTTP requests and user metrics (custom metrics)

---

## 12) Why Grafana if Prometheus already has graphs?

### 12.1 Prometheus can do the 3 monitoring functions
Prometheus can:
- scrape metrics
- visualize basic graphs
- set up alerts (covered later)

So Prometheus qualifies as a monitoring system.

### 12.2 Grafana’s role (why it’s widely used)
Grafana is primarily:
- a **dashboard/visualization platform**
- not a full monitoring collector like Prometheus

Key benefits:
1. **Better visualization**
   - richer dashboards than Prometheus UI
2. **Multiple data sources**
   - if org moves away from Prometheus (Nagios/Graphite/InfluxDB), Grafana can still be used
3. **Authentication & authorization**
   - Prometheus UI does not provide strong auth/authz controls
   - Grafana supports:
     - users/roles
     - SSO integration
     - permissions:
       - managers: view-only
       - DevOps: create/edit dashboards
       - dev/QA: different levels of access

---

## 13) Grafana practical walkthrough (what was shown)

### 13.1 Access Grafana
- Access via port-forward URL (from Day 2).
- Login:
  - user: `admin`
  - password: `prom-operator`

### 13.2 Admin and user management
- In Grafana admin area:
  - create users
  - integrate SSO
  - define roles and permissions

### 13.3 Pre-built dashboards (out-of-the-box)
- Grafana comes with dashboards with predefined PromQL queries.
- Example: pod CPU usage dashboard.
- Important step:
  - select correct **data source**
  - choose Prometheus (instead of “default”)
- Then you can see:
  - pods in default namespace
  - CPU usage of busybox pod (tiny CPU)
  - switch to `kube-system` and view multiple pods
  - click a pod to see its memory utilization graph
- Change time range:
  - last 1 hour, 30 minutes, 1 day, etc.
- Auto refresh exists (timeline control)

---

## 14) Creating your own Grafana dashboard (custom graph)

### 14.1 Why create custom dashboards?
- Some metrics (like pod restarts) may not be visible in default dashboards.
- Management may want specific “daily health” dashboards.

### 14.2 Steps (as demonstrated)
1. Click **New** → **Dashboard**
2. Select **Prometheus** as data source
3. Paste PromQL query, example:
   - `kube_pod_container_status_restarts_total{namespace="default"}`
4. Run query → get panel/graph
5. Adjust time range (5 min / 30 min) to see restart timestamps clearly
6. Save dashboard with a name
7. Share with management (view access), while teams have edit rights based on permissions

### 14.3 Kubernetes CrashLoopBackOff note (why spacing increases)
- CrashLoopBackOff uses backoff:
  - initial crash quickly
  - then crashes happen after increasing delays (3m, 5m, 7m, etc.)
- This pattern becomes visible on the restart graph.

---

## 15) Grafana supports other data sources (not just Prometheus)
- Add new data source:
  - InfluxDB (example)
  - Nagios
  - Graphite
  - others
- Prometheus was auto-detected in this setup, so config was minimal.

---

## 16) What’s left for Day 4 (tomorrow)
Key missing piece so far: **Custom metrics** and deeper metric types.

### 16.1 Custom metrics (developer instrumentation)
- Need to learn:
  - how devs expose HTTP requests, logins, business metrics, etc.
- Covered tomorrow via instrumentation (OpenTelemetry, etc.)

### 16.2 Metric types in Prometheus (to be covered)
Prometheus metric types mentioned:
- **Gauge**
- **Counter**
- **Summary**
- **Histogram**

Developers/engineers define metric type when instrumenting.

### 16.3 ServiceMonitor (controlling what Prometheus scrapes)
Problem:
- Kubernetes can have hundreds/thousands of services.
- If Prometheus scrapes everything:
  - Prometheus load increases heavily
  - CPU/memory usage rises
  - can impact cluster

Solution:
- Use **ServiceMonitor** to tell Prometheus:
  - which services expose `/metrics`
  - which apps should be scraped
- Example idea:
  - only scrape login and payments services (not every service)

Tomorrow’s practical:
- implement custom metrics
- implement ServiceMonitor
- demonstrate end-to-end.

---

## 17) PromQL aggregator functions (extra note mentioned)
- In Day 3 notes, there are examples for aggregation:
  - `avg` (average)
  - `sum`
- Common use cases:
  - average memory usage grouped by namespace
  - sum CPU utilization of pods in a namespace
- Suggested action:
  - review aggregator functions in notes
  - practice writing queries using `sum` and `avg`

---

## 18) Takeaways / Homework (from this session)
1. Explore node-exporter and kube-state-metrics `/metrics` endpoints (inside cluster).
2. Practice PromQL queries:
   - restarts
   - configmaps created
   - filtering using labels (namespace/pod/etc.)
3. Explore Grafana:
   - prebuilt dashboards
   - change datasource to Prometheus
   - change time ranges and filters
4. Read Day 3 notes for:
   - more queries
   - aggregation examples (`sum`, `avg`)
5. Prepare for Day 4:
   - custom metrics instrumentation
   - metric types (gauge/counter/summary/histogram)
   - ServiceMonitor

---

## 19) One-page revision snapshot (fast recall)
- Prometheus scrapes metrics from:
  - node-exporter (node CPU/memory/disk)
  - kube-state-metrics (API server → pod/deploy/service/configmap/etc.)
  - app `/metrics` (custom metrics)
- Exporters expose metrics at `/metrics` in Prometheus-readable format.
- Prometheus stores in TSDB (time + values).
- PromQL queries TSDB; label selectors filter (namespace/pod/etc.).
- Grafana = richer dashboards + multiple data sources + auth/authz + SSO.
- Create custom dashboards by writing PromQL queries in Grafana panels.
- Next: custom metrics, metric types, ServiceMonitor.
