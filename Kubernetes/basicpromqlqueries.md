If an interviewer asks you about PromQL, don't just memorize the query. Understand what each function and metric does.

---

# 1. Pod CPU Usage

### Query

```promql
sum(rate(container_cpu_usage_seconds_total{namespace="production"}[5m])) by (pod)
```

---

## Breakdown

### container_cpu_usage_seconds_total

This metric is collected by Prometheus from Kubernetes containers.

Example:

```text
Pod-A = 1000
Pod-B = 500
```

This means:

* Pod-A has consumed 1000 CPU seconds since it started.
* Pod-B has consumed 500 CPU seconds since it started.

This value continuously increases.

---

### rate()

```promql
rate(container_cpu_usage_seconds_total[5m])
```

`rate()` calculates how fast the value is increasing.

Example:

```text
5 minutes ago = 1000
Now = 1030
```

Increase:

```text
30 CPU seconds
```

Prometheus calculates CPU consumption per second.

Without rate():

```text
1000 → 1030 → 1050
```

You only see increasing numbers.

With rate():

```text
0.1 CPU
0.2 CPU
0.3 CPU
```

You see actual CPU usage.

---

### [5m]

```promql
[5m]
```

Means:

"Look at the last 5 minutes of data."

Prometheus calculates CPU usage based on the previous 5 minutes.

---

### sum()

```promql
sum(...)
```

Adds all CPU values together.

Example:

```text
Container-1 = 0.2 CPU
Container-2 = 0.3 CPU
```

Result:

```text
0.5 CPU
```

---

### by(pod)

```promql
by(pod)
```

Groups results by pod.

Without:

```text
Total CPU = 5 CPUs
```

With:

```text
frontend-pod = 1 CPU
backend-pod = 2 CPU
api-pod = 2 CPU
```

---

## Output

```text
frontend-pod = 0.4 CPU
backend-pod = 0.8 CPU
api-pod = 0.2 CPU
```

---

## Production Usage

> When users reported slowness, I checked pod CPU utilization in Grafana. If a pod was consuming excessive CPU, I verified application logs and increased CPU requests/limits if required.

---

# 2. Pod Memory Usage

### Query

```promql
sum(container_memory_working_set_bytes{namespace="production"}) by (pod)
```

---

## Breakdown

### container_memory_working_set_bytes

Shows actual memory used by a container.

Example:

```text
frontend = 500 MB
backend = 1 GB
api = 700 MB
```

---

### sum()

Adds memory usage of all containers inside a pod.

Example:

```text
Container-A = 400 MB
Container-B = 300 MB
```

Result:

```text
700 MB
```

---

### by(pod)

Groups memory usage per pod.

Output:

```text
frontend-pod = 700 MB
backend-pod = 1.2 GB
```

---

## Production Usage

> If a pod was getting OOMKilled, I checked memory consumption in Grafana. If memory utilization was consistently high, I increased memory limits after validation.

---

# 3. Pod Restart Count

### Query

```promql
increase(kube_pod_container_status_restarts_total[1h])
```

---

## Breakdown

### kube_pod_container_status_restarts_total

Tracks total restarts.

Example:

```text
Current restart count = 10
```

Means:

Container restarted 10 times since creation.

---

### increase()

Calculates how much the value increased.

Example:

```text
1 hour ago = 4
Now = 10
```

Result:

```text
6 restarts
```

---

### [1h]

Means:

```text
Look at the last one hour.
```

---

## Output

```text
frontend-pod = 0
backend-pod = 3
api-pod = 5
```

---

## Production Usage

> If application outages occurred, I checked pod restart metrics. Multiple restarts usually indicated application crashes, memory issues, or failed health checks.

---

# 4. Node CPU Utilization %

### Query

```promql
100 - (avg by(instance)(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

---

## Breakdown

### node_cpu_seconds_total

Tracks total CPU time of a node.

---

### mode="idle"

Idle means CPU is doing nothing.

Example:

```text
Idle CPU = 80%
```

Node is mostly free.

---

### rate()

Calculates idle CPU percentage over last 5 minutes.

Example:

```text
Idle = 0.8
```

Means:

```text
80% CPU idle
```

---

### avg by(instance)

Calculates average idle CPU for each node.

Example:

```text
worker-1 = 80%
worker-2 = 70%
```

---

### *100

Converts decimal to percentage.

```text
0.8 × 100 = 80%
```

---

### 100 -

We want CPU utilization, not idle.

Example:

```text
Idle = 80%
```

CPU Utilization:

```text
100 - 80 = 20%
```

---

## Output

```text
worker-1 = 20%
worker-2 = 30%
worker-3 = 75%
```

---

## Production Usage

> I monitored worker node CPU utilization. If utilization consistently exceeded 80%, I checked pod distribution and planned cluster scaling activities.

---

# 5. Node Memory Utilization %

### Query

```promql
(
(1 -
(
node_memory_MemAvailable_bytes
/
node_memory_MemTotal_bytes
)
) * 100
)
```

---

## Breakdown

### node_memory_MemTotal_bytes

Total memory available on node.

Example:

```text
16 GB
```

---

### node_memory_MemAvailable_bytes

Currently available memory.

Example:

```text
4 GB
```

---

### Division

```promql
node_memory_MemAvailable_bytes
/
node_memory_MemTotal_bytes
```

Example:

```text
4 / 16
=
0.25
```

Means:

```text
25% memory available
```

---

### 1 -

```text
1 - 0.25
=
0.75
```

Means:

```text
75% memory used
```

---

### *100

Converts to percentage.

```text
75%
```

---

## Output

```text
worker-1 = 75%
worker-2 = 40%
worker-3 = 90%
```

---

## Production Usage

> I monitored node memory utilization through Grafana. If memory usage exceeded 85%, I checked which workloads were consuming memory and coordinated resource optimization or cluster scaling.

---

# Simple Interview Summary

> In production, I used Grafana dashboards connected to Prometheus. The main PromQL queries I used were pod CPU utilization, pod memory utilization, pod restart count, node CPU utilization, and node memory utilization. Functions like `rate()` helped calculate resource consumption over time, `sum()` aggregated values from multiple containers, `increase()` tracked changes such as restart counts, and `by()` grouped metrics by pod or node. These dashboards helped me identify high resource usage, frequent pod restarts, and node capacity issues before they impacted applications.
