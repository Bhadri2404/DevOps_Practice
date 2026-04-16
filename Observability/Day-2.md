# Observability Zero to Hero — Day 2 (Episode 2): Metrics + Monitoring + Prometheus — Revision Notes

## 1) What you learn in Episode 2
- First pillar of observability: **Metrics**
- **Monitoring** (metrics + dashboards + alerts)
- **Prometheus** (most common monitoring tool in Kubernetes)
- Install Prometheus on **EKS**
- Connect **Grafana** with Prometheus for visualization

---

## 2) Metrics (core concept)
### Definition (as explained)
- **Metrics = periodic + historical data of events** used to understand the **health of a system**.

### Real-life analogy: hospital patient
- Nurse records heartbeat/BP periodically (every 15/30/60 mins).
- Doctor uses the historical values to decide:
  - patient stable vs abnormal at certain times.
- Without history, you can’t reliably understand what happened.

### Key point
- Metrics alone are **raw numbers** (hard to interpret in a sheet/notepad).

---

## 3) Monitoring vs Metrics (difference)
### Monitoring system does 3 things
1. **Scrapes/collects metrics** (pulling = “scraping”; can also accept push in some setups)
2. **Visualizes metrics** in dashboards/graphs (easy to spot spikes)
3. **Fires alerts** when something is wrong (threshold-based notifications)

### Hospital analogy mapping
- Machine displays heartbeat graph continuously.
- Alerts:
  - heartbeat > 90 → notify nurse
  - heartbeat > 110 → notify doctor

### Conclusion
- **Metrics ⊂ Monitoring**
- **Monitoring = Metrics + Dashboards + Alerts**

---

## 4) Metrics examples in IT (what teams track)
### Infrastructure / Node (AWS VM / Kubernetes node)
- CPU utilization (historical)
- Memory utilization
- Disk utilization

### Kubernetes cluster
- Pod status
- CrashLoopBackOff count + timestamps
- Deployment status
- HPA replicas over time

### Application / business metrics
- Total HTTP requests per day / per time window
- Traffic patterns by hour (e.g., 5–6 AM)
- Domain metrics:
  - user signups (when they happen)
  - deactivations
  - time spent on platform
- Number of metrics depends on what you need (no fixed rule).

---

## 5) Alerts (why monitoring matters)
Examples alert rules:
- CPU > 80% → alert
- Disk > 75% → Slack to DevOps/SRE channel
- Latency trend:
  - normally 5s, now 10s
  - if repeated (e.g., 30 times/day) → alert dev team (Slack/Gmail)

DevOps/SRE configure:
- when to fire
- where to send

---

## 6) Prometheus (where it fits)
### What Prometheus is
- Popular open-source **monitoring platform** for Kubernetes.
- Usually **pull-based** (scrapes metrics), can support push patterns via Pushgateway.

### What Prometheus provides
- Scraping/collection of metrics
- Storage in a **Time Series Database (TSDB)** (time + key/value)
- Query via **PromQL**
- Alerting via **Alertmanager**
- Often paired with **Grafana** for rich dashboards

---

## 7) Prometheus architecture (high level)
Core flow:
- **Retrieval** (Prometheus component) **pulls** metrics from targets
- Stores in **TSDB**
- Query via **HTTP server/UI** using **PromQL**
- Alerts managed through **Alertmanager**

Important concept:
- **Service discovery / targets**: control which apps/endpoints Prometheus scrapes (e.g., only 50 out of 100 apps).

---

## 8) Grafana + Prometheus (monitoring stack)
- Grafana = strong visualization / dashboards.
- Common stack: **Prometheus + Grafana**
  - Prometheus: metrics + querying + alert manager integration
  - Grafana: dashboards (rich graphs)

---

## 9) Installation summary (Episode practical)
- Use Helm to install monitoring stack into a `monitoring` namespace.
- Stack includes:
  - Prometheus
  - Grafana
  - Alertmanager (enabled via custom values file)
  - node-exporter
  - kube-state-metrics
- Access UIs in demo via `kubectl port-forward`
  - In org setups, typically expose via **Ingress** + controller.
- Grafana login shown:
  - user: `admin`
  - password: `prom-operator`
- Configure Grafana → add **Prometheus data source** (Prometheus URL).

---

## 10) How Prometheus scrapes “everything” (3 main sources)
1. **node-exporter**
   - node/VM metrics: CPU, memory, disk
2. **kube-state-metrics**
   - Kubernetes API server data: pod/deploy status, crashes, events, resources
3. **Application `/metrics` endpoint**
   - Developers expose metrics endpoint (like `/metrics`)
   - Prometheus scrapes selected apps via service discovery/targets

---

## 11) Competitors (mentioned)
- Nagios, InfluxDB, Graphite, plus closed-source tools.
- Prometheus is widely used because:
  - strong community
  - CNCF ecosystem adoption
  - many vendors build on Prometheus instead of reinventing monitoring

---

## 12) Next episode (what’s coming)
- Learn **PromQL**
- Explore actual metrics from:
  - kube-state-metrics
  - node-exporter
- Use Grafana dashboards to visualize graphs and patterns
