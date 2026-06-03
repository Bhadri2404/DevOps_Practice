If you are saying you worked on monitoring Kubernetes workloads using Prometheus and Grafana, these are some commonly used PromQL queries that are realistic for day-to-day production support.

## 1. Pod CPU Usage

**Query:**

```promql
sum(rate(container_cpu_usage_seconds_total{namespace="production"}[5m])) by (pod)
```

### What it does

* Shows CPU consumption of each pod.
* Helps identify pods consuming high CPU.

### Production Use Case

"If users reported slowness, I checked pod CPU utilization in Grafana to identify any pod consuming excessive CPU resources."

---

## 2. Pod Memory Usage

**Query:**

```promql
sum(container_memory_working_set_bytes{namespace="production"}) by (pod)
```

### What it does

* Shows current memory usage of each pod.
* Helps detect memory leaks.

### Production Use Case

"If pods were restarting with OOMKilled errors, I checked memory utilization through Grafana dashboards."

---

## 3. Pod Restart Count

**Query:**

```promql
increase(kube_pod_container_status_restarts_total[1h])
```

### What it does

* Shows how many times containers restarted in the last hour.

### Production Use Case

"If applications were unstable, I checked restart counts to identify problematic pods."

---

## 4. Node CPU Utilization %

**Query:**

```promql
100 - (avg by(instance)(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

### What it does

* Shows node CPU utilization percentage.

### Production Use Case

"If nodes were under heavy load, I verified CPU usage before deciding whether cluster scaling was required."

---

## 5. Node Memory Utilization %

**Query:**

```promql
(
(1 - (
node_memory_MemAvailable_bytes
/
node_memory_MemTotal_bytes
)) * 100
)
```

### What it does

* Shows percentage of memory utilized on worker nodes.

### Production Use Case

"I monitored worker node memory to ensure enough resources were available for Kubernetes scheduling."

---

# Bonus Query (Very Common)

## Pod Status

```promql
kube_pod_status_phase
```

### What it does

Shows pod states:

* Running
* Pending
* Failed
* Succeeded

### Production Use Case

"When applications were not available, I checked pod states to quickly identify failed or pending pods."

---

# How I Used Grafana in Production

### Step 1

Login to Grafana.

### Step 2

Go to:

```text
Dashboards → New Dashboard
```

### Step 3

Click:

```text
Add Visualization
```

### Step 4

Select:

```text
Prometheus
```

as datasource.

### Step 5

Paste the PromQL query.

Example:

```promql
sum(rate(container_cpu_usage_seconds_total{namespace="production"}[5m])) by (pod)
```

### Step 6

Click:

```text
Run Query
```

### Step 7

Choose visualization type:

* Time Series
* Gauge
* Stat
* Table

### Step 8

Save dashboard.

---

# Interview Answer (Simple)

> In my project, I used Prometheus and Grafana for Kubernetes monitoring. I regularly monitored pod CPU usage, memory usage, pod restart counts, node CPU utilization, and node memory utilization. Whenever an application issue occurred, I checked Grafana dashboards using PromQL queries to identify resource bottlenecks, pod restarts, or node resource exhaustion. Based on the findings, I either increased resources, restarted pods, or escalated application-related issues to developers.

These 5 queries are very common and believable for a Kubernetes Production Support/DevOps Engineer role.
