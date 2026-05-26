For this JD, “Observability” mainly means **ElasticSearch/ELK (Elastic + Kibana), Grafana, Prometheus, logging, monitoring, alerting, dashboards** and how you use them to operate complex systems. Let’s set up **Observability Q1–Q15** first (ELK, logs, metrics, dashboards) in the same interview‑handbook style you’re building. [datadoghq](https://www.datadoghq.com/knowledge-center/observability/)

***

```md
# Observability – ELK, Grafana, Prometheus (Q1–Q15)

> Focus: logs, metrics, traces basics; ElasticSearch/Kibana; Grafana; Prometheus; alerting; dashboards; how to use them in production for debugging and SRE work.[web:130][web:132]
```

***

## 1. Observability basics and pillars

### Q1. What is observability and how is it different from monitoring?

**Answer (simple):**  
- **Monitoring** usually means predefined dashboards + alerts to tell you when something is wrong (e.g., CPU > 80%). [datadoghq](https://www.datadoghq.com/knowledge-center/observability/)
- **Observability** means having enough rich data (logs, metrics, traces) so that you can understand *why* something is wrong – even for new, unknown issues. [en.wikipedia](https://en.wikipedia.org/wiki/Observability_(software))

**Key points:**

- “Three pillars”: **metrics, logs, traces**. [dynatrace](https://www.dynatrace.com/news/blog/what-is-observability-2/)
- Observability lets you ask new questions about the system without redeploying code.

**Follow-up question:**  
How would you explain logs vs metrics vs traces to a non-technical stakeholder?

***

## 2. Logs and ELK (Elastic + Kibana)

### Q2. How would you design logging for a microservices system that uses ELK?

**Answer:**

- **Apps emit structured logs** (JSON) with fields like `timestamp`, `service`, `env`, `trace_id`, `level`, `message`.
- Logs are collected (Filebeat/Fluentd/Fluent Bit/Logstash) and sent to **ElasticSearch**. [elastic](https://www.elastic.co/what-is/observability)
- **Kibana** is used to search, filter, visualize, and build dashboards on top of these logs.

**Production practices:**

- Use **consistent fields** across all services (`service`, `env`, `correlation_id`).
- Configure **retention** and indices (e.g., per environment or per app) to control cost.

**Common mistakes:**

- Unstructured free‑text logs only, very hard to query.
- Logging too much debug info in production → high cost.

**Follow-up question:**  
How would you debug a “user request is slow” incident using Kibana?

***

### Q3. What is ElasticSearch used for in observability? How would you index logs?

**Answer:**

- ElasticSearch is a **search and analytics engine** used to store and query large volumes of log data efficiently. [elastic](https://www.elastic.co/what-is/observability)
- Logs are stored as JSON documents; each document has fields for easy querying and aggregation.

**Indexing strategy:**

- Time-based indices: e.g., `logs-YYYY.MM.DD` or `logs-app1-YYYY.MM`.
- Templates for field mappings (e.g., `status` as keyword, `duration_ms` as number).

**Common mistakes:**

- Using default mappings and then discovering fields are analyzed text instead of keywords.
- Not managing index lifecycle → cluster runs out of disk.

**Follow-up question:**  
How would you handle log retention and rollover for high-volume logs?

***

### Q4. How do you use Kibana to investigate an error spike?

**Answer:**

Typical flow:

1. **Start from a dashboard** showing error rates per service.
2. Click on the service with spike → open Discover with filtered logs.
3. **Filter** on `level: ERROR` and relevant `service`, `env`, `trace_id`.
4. Examine stack traces and context fields to understand cause.
5. Use `trace_id` (if present) to link logs across services.

**Follow-up question:**  
What filters and fields would you define as standard in all logs to make this workflow easy?

***

## 3. Metrics and Prometheus

### Q5. What is Prometheus and how is it used in observability?

**Answer (simple):**

- Prometheus is a **metrics collection and querying system**. [mia-platform](https://mia-platform.eu/blog/observability-software-engineering/)
- It **pulls metrics** from exporters or apps via HTTP `/metrics` endpoints (usually text format).
- Stores time‑series metrics and lets you query them with PromQL.

**Use cases:**

- CPU, memory, request rate, error rate, latency, queue depth, etc.
- SLO/SLI calculations (e.g., error rate over past 30m).

**Follow-up question:**  
How would you expose custom metrics from a Python/Go microservice?

***

### Q6. How would you design service-level metrics for a REST API (Prometheus style)?

**Answer:**

Common metrics:

- `http_requests_total{service="api", method="GET", status="200"}`  
- `http_request_duration_seconds_bucket{le="0.1", ...}` (histogram for latency)
- `http_requests_in_progress` gauge

**Principles:**

- Use **labels** (`service`, `env`, `endpoint`, `status`) to slice and dice the metrics.
- Keep cardinality reasonable (no per-user labels).

**Follow-up question:**  
How would you use these metrics to build alerts for high error rates and high latency?

***

## 4. Grafana and Dashboards

### Q7. What is Grafana and how would you use it with Prometheus and Elastic?

**Answer:**

- Grafana is a **visualization and dashboard tool** that can connect to many datasources (Prometheus, ElasticSearch, Loki, etc.). [vfunction](https://vfunction.com/blog/software-observability-tools/)
- For metrics: connect to Prometheus; build dashboards for CPU, latency, error rates.
- For logs: connect to Elastic or Loki; add log panels for drill‑down.

**Interview angle:**

- Combine **metrics panels** (e.g., latency spike) with **logs panels** underneath for correlation.
- Use templating (variables like `service`, `env`) for reuse.

**Follow-up question:**  
How would you design a “Service Overview” dashboard for one microservice?

***

### Q8. What kind of panels and KPIs would you put on a production “Platform Health” Grafana dashboard?

**Answer (simple list):**

- Overall **API error rate** and **latency** (p50/p95/p99) per environment.
- **Infrastructure**: node CPU/memory, pod count, node disk usage.
- **Database**: connections, CPU, slow query count.
- **Queues**: message backlog, processing rate.
- **Business metrics**: requests per second, logins, trades, etc.

**Follow-up question:**  
In a banking context, which business metrics would you include and why?

***

## 5. Alerts and SLOs

### Q9. How would you design alerts to avoid both alert fatigue and missing real issues?

**Answer:**

- Base alerts on **SLIs/SLOs** (e.g., 99% of requests under 300ms, error rate < 1%). [datadoghq](https://www.datadoghq.com/knowledge-center/observability/)
- Use **multi-window, multi-burn rate** alerts: short window for fast detection, long window for confidence.
- Use **warning** vs **critical** levels.

**Practical steps:**

- Start with dashboards, observe normal behavior.
- Then set alerts slightly outside normal range.

**Follow-up question:**  
Give an example Prometheus alert expression for “5xx error rate too high”.

***

### Q10. What is an SLO and how does observability help you enforce it?

**Answer:**

- SLO (Service Level Objective) is a target for reliability, e.g., “99.9% of requests in 30 days succeed”.  
- Observability gives the **data** (logs/metrics) to measure **SLIs** (Service Level Indicators) like error rate and latency.

**Use:**

- Prometheus keeps metrics.
- Grafana shows SLO burn down.
- Alerts fire when burn rate suggests SLO violation risk.

**Follow-up question:**  
How would you explain to a manager that you prefer SLO‑based alerts instead of only CPU/Memory alerts?

***

## 6. Traces and Distributed Systems (high level, even if JD doesn’t explicitly say “traces”)

### Q11. What are traces and when do you need them?

**Answer (simple):**

- A **trace** is a record of a single request as it flows through multiple services, broken into **spans**. [opentelemetry](https://opentelemetry.io/docs/concepts/observability-primer/)
- Useful when:
  - Many microservices and hops.
  - Need to see where time is spent (which service is slow).
  - Need to correlate logs and metrics using trace IDs.

**Examples of tools:**

- Jaeger, Zipkin, Tempo, X-Ray, OpenTelemetry. [opentelemetry](https://opentelemetry.io/docs/concepts/observability-primer/)

**Follow-up question:**  
How would you propagate a trace ID across services?

***

### Q12. How would you debug a “transaction latency is high” issue using metrics, logs, and traces together?

**Answer:**

1. Metrics (Grafana/Prometheus):  
   - See which service/endpoint shows high latency.
2. Traces:  
   - Look at traces for that endpoint; find where the longest span is (DB, external API, etc.).
3. Logs (Kibana):  
   - Use trace ID to filter logs for detailed error/stack trace context.

**Follow-up question:**  
If traces are missing, how could you approximate the same investigation with only logs + metrics?

***

## 7. ELK / Prometheus / Grafana in Kubernetes

### Q13. How would you collect logs from Kubernetes pods into Elastic/Kibana?

**Answer (simple flow):**

- Each container writes logs to **stdout/stderr**.
- Kubernetes writes container logs to files on the node (e.g., `/var/log/containers`).
- A **log agent** (Filebeat/Fluent Bit) runs as a DaemonSet:
  - Reads log files on each node.
  - Parses them (JSON, multi-line stack traces).
  - Sends to ElasticSearch with labels like `namespace`, `pod`, `container`.

**Follow-up question:**  
Which Kubernetes labels/fields do you always include with logs to make debugging easier?

***

### Q14. How would you scrape metrics from Kubernetes pods with Prometheus?

**Answer:**

Two common patterns:

- **Service annotations**:
  - Add annotations like `prometheus.io/scrape: "true"` and `prometheus.io/port: "8080"` to Service or Pod.
  - Prometheus config discovers pods/services based on label/annotation.
- **Prometheus Operator / ServiceMonitor**:
  - Define `ServiceMonitor` resources specifying which Services to scrape.

**Follow-up question:**  
What do you need to expose in your application for Prometheus to scrape it?

***

## 8. Production Incident Example with Observability

### Q15. Production scenario: Users report “login is slow” – how do you use your observability stack (ELK + Grafana/Prometheus) to handle this?

**Answer (step by step):**

1. **Metrics first (Grafana)**  
   - Check dashboard for login endpoint: see latency and error rate graphs.
   - Confirm if the issue is real and when it started.
2. **Zoom in on time range**  
   - Focus on the spike time window.
3. **Logs (Kibana)**  
   - Filter logs for `service=auth` and `endpoint=/login`, `level=ERROR` or high latency.
   - Look for errors like DB timeouts, external IdP issues.
4. **Correlate with infrastructure metrics**  
   - Node CPU/memory, DB CPU/IO, network latency.
5. **Hypothesis + action**  
   - If DB is slow: check DB metrics and logs.
   - If external IdP is slow: check any outbound API metrics/logs.

**Follow-up question:**  
What observability gaps could make this investigation hard, and how would you fix them (e.g., missing request IDs, missing latency metrics)?

***

## 9. ElasticSearch / Kibana – Indexing, Retention, and Performance (Q16–Q20)

### Q16. How would you design index patterns and ILM (Index Lifecycle Management) for logs in ElasticSearch?

**Answer:**
- Use **time‑based indices** such as `logs-prod-YYYY.MM.DD` or `logs-prod-app1-YYYY.MM` depending on volume.
- Use **Index Lifecycle Management (ILM)** policies to:
  - Keep recent data in “hot” nodes (fast disks).
  - Move older data to “warm/cold” nodes.
  - Finally delete or snapshot after retention period.[web:132]

**Key practices:**
- Differentiate by **environment** (`dev`, `qa`, `prod`) and sometimes by app.
- Balance between index size and number of indices (too many small indices is also bad).

**Follow-up question:**
How would you decide retention time for application logs vs audit/compliance logs?

---

### Q17. How do you avoid ElasticSearch performance issues when log volume grows?

**Answer:**
- Use **structured logs** and avoid storing huge unnecessary fields (e.g., large payloads).
- Limit **field cardinality** (avoid labels like `user_id` as separate fields if millions of unique values).[web:132]
- Use **ILM** to delete or move old data.
- Size the cluster correctly (CPU, memory, disk, node count) and monitor heap usage.

**Common mistakes:**
- No ILM → indices grow forever.
- Very high cardinality fields → heavy memory and slow queries.

**Follow-up question:**
What metrics/dashboards would you watch to detect ElasticSearch stress (e.g., heap, GC, query latency)?

---

### Q18. How would you design a Kibana dashboard specifically for error analysis?

**Answer:**
Include:
- A **time chart** of error count over time, filtered by `env=prod`.
- A **top services** panel: errors per service.
- A **top error messages** table (grouped by message or exception type).
- A **filter bar** for `service`, `env`, `status_code`, `trace_id`.

**Usage:**
- Start from spike → drill down to service → drill into specific errors and trace IDs.

**Follow-up question:**
How would you add saved searches or visualizations to quickly compare today vs yesterday’s error patterns?

---

### Q19. How do you handle multi‑line logs (like Java stack traces) in ELK?

**Answer:**
- Configure the **log shipper** (Filebeat/Fluent Bit/Logstash) with a multi‑line pattern:
  - E.g., new log line starts with a timestamp, everything else is part of previous log.[web:132]
- This way, stack traces are ingested as a single log event.

**Common mistakes:**
- Not configuring multi‑line → stack trace breaks into many log entries, hard to read and search.

**Follow-up question:**
Describe a simple multi‑line pattern for logs that start with ISO timestamps.

---

### Q20. How would you secure Kibana and ElasticSearch in a banking environment?

**Answer:**
- Use **authentication and authorization** (e.g., Elastic security features, SSO, RBAC).
- Restrict access by **roles** (e.g., only SREs can see production logs).
- Use **TLS** for all connections.
- Control log content: avoid logging **PII** and secrets.

**Follow-up question:**
How would you handle masking of sensitive fields (like card numbers) in logs?

---

## 10. Prometheus – Queries and Alerts (Q21–Q25)

### Q21. Give a simple PromQL query to get the error rate of an HTTP service.

**Answer:**
Assume metrics:
- `http_requests_total{service="api", status="200"}` etc.

Example query (error percentage over 5 minutes):

```promql
sum(rate(http_requests_total{service="api",status=~"5.."}[5m]))
/
sum(rate(http_requests_total{service="api"}[5m]))
* 100
```

**Explanation:**
- `rate(...[5m])` = per-second rate over last 5 minutes.
- Numerator = only 5xx requests; denominator = all requests; multiply by 100 to get percentage.

**Follow-up question:**
How would you adjust this query to look at one specific endpoint or environment?

---

### Q22. How would you create a Prometheus alert for high 5xx error rate?

**Answer:**
Alert rule example (pseudocode):

```yaml
- alert: HighErrorRate
  expr: |
    sum(rate(http_requests_total{service="api",status=~"5.."}[5m]))
    /
    sum(rate(http_requests_total{service="api"}[5m])) > 0.05
  for: 10m
  labels:
    severity: critical
  annotations:
    summary: "High 5xx error rate for API"
    description: "More than 5% of requests failing for 10 minutes"
```

**Key points:**
- Use `for: 10m` to avoid flapping on a short spike.
- Compare error fraction against threshold (0.05 = 5%).

**Follow-up question:**
How would you differentiate between warning and critical levels for the same metric?

---

### Q23. How do you use recording rules in Prometheus and why?

**Answer:**
- Recording rules pre‑compute and store complex or expensive expressions as new metrics.
- Example: compute `api_error_rate` once, then dashboard and alerts read `api_error_rate` directly.

**Benefits:**
- Faster dashboards.
- Simpler alert expressions.
- Less load on Prometheus.

**Follow-up question:**
Give an example of a metric you would convert into a recording rule and why.

---

### Q24. How would you monitor Kubernetes nodes and pods with Prometheus?

**Answer:**
- Use **node-exporter** on nodes to expose CPU/memory/disk metrics.
- Use **kube-state-metrics** for Kubernetes objects (deployments, pods, etc.).
- Scrape `/metrics` from these exporters via Prometheus:
  - Node metrics: `node_cpu_seconds_total`, `node_memory_MemAvailable_bytes`, etc.
  - K8s metrics: `kube_pod_container_status_restarts_total`, `kube_deployment_status_replicas_available`, etc.

**Follow-up question:**
What alerts would you create using `kube_pod_container_status_restarts_total`?

---

### Q25. What are some common pitfalls when writing Prometheus metrics?

**Answer:**
- **High cardinality labels** (e.g., per user, per request ID) → memory explosion.
- Using **counters** incorrectly (counters only increase, gauges go up and down).
- Not using **histograms** for latency; only averages hide tail problems.

**Follow-up question:**
How would you design a good latency metric for an HTTP endpoint?

---

## 11. Grafana – Dashboards and On‑Call Use (Q26–Q30)

### Q26. How would you design a Grafana dashboard for on‑call engineers?

**Answer:**
Include:
- Top row: **SLO view** – error rate, latency (p95/p99), request volume.
- Second row: **infra** – node CPU/memory/disk, pod counts, restart counts.
- Third row: **dependencies** – DB metrics, cache metrics, queue depths.
- Add **templating variables** (`service`, `env`, `region`) so on‑call can switch context quickly.

**Follow-up question:**
How do you avoid cluttering dashboards while still giving enough detail?

---

### Q27. What is the difference between dashboards for engineers vs dashboards for management?

**Answer:**
- **Engineering dashboards**:
  - Detailed technical metrics (CPU, memory, GC, queue depth).
  - Many panels, logs links, per‑service breakdowns.
- **Management dashboards**:
  - High‑level SLIs (availability, latency, error rate).
  - Business KPIs (transactions per second, failures per day).
  - Simple, few panels, clear green/yellow/red indicators.[web:123]

**Follow-up question:**
In a SocGen‑style environment, what 3 business metrics would you show to management?

---

### Q28. How would you integrate logs and metrics in Grafana for faster debugging?

**Answer:**
- Add a **logs panel** below metrics for the same service/time range.
- Use labels like `trace_id`, `service`, `env` as query parameters.
- Click on a spike in metrics → automatically filters logs for that time window and service.

**Follow-up question:**
What key labels/fields must be present in both logs and metrics to make this correlation easy?

---

### Q29. How do you manage dashboard sprawl and keep Grafana organized?

**Answer:**
- Use **folders** by team or domain (e.g., `Platform`, `Payments`, `Data Platform`).
- Mark some dashboards as **“official”** (owned by SRE/platform) and others as “personal”.
- Keep dashboards under **version control** (e.g., JSON in Git) and deploy via CI/CD.

**Follow-up question:**
How would you ensure every new microservice gets a standard set of dashboards by default?

---

### Q30. Runbook example: “High error rate detected on service X” – what steps do you include using observability tools?

**Answer (simple sequence):**
1. **Confirm alert** in Grafana/Alertmanager (time window, severity, affected service/env).
2. **Open service dashboard**:
   - Check error rate graph, latency, traffic volume.
3. **Check related infra**:
   - Node CPU/memory, pod restarts, DB metrics.
4. **Open logs (Kibana)** for the same time window:
   - Filter `service=X`, `env=prod`, `level=ERROR`.
   - Look at stack traces, error messages.
5. If needed, check **traces** to see slow spans.
6. **Decide action**:
   - Roll back deployment, scale up, failover DB, etc.
7. **Document incident** with screenshots and timeline.

## 12. Deeper ELK / Kibana Usage (Q31–Q36)

### Q31. How do you design log fields so that Kibana queries stay fast and useful?

**Answer:**
- Use a **standard log schema** across services: `timestamp`, `service`, `env`, `level`, `message`, `trace_id`, `span_id`, `user_id` (if allowed), `request_id`.
- Keep **important fields as keywords or numbers**, not analyzed free text (e.g., `status_code`, `service`).
- Avoid putting variable blobs into structured fields (like entire JSON payloads).

**Best practices:**
- Define mappings in index templates.
- Limit number of fields per index to avoid mapping explosion.[web:132]

**Follow-up question:**
What is mapping explosion in ElasticSearch and how would it affect your cluster?

---

### Q32. How would you search in Kibana for all login failures for a given user in the last 24 hours?

**Answer:**
- Time filter: `Last 24 hours`.
- Query example (KQL-style):
  - `service: "auth-service" and action: "login" and outcome: "failure" and user_id: "12345"`
- Use a table visualization showing timestamp, user_id, IP, error reason.

**Follow-up question:**
If user_id can’t be logged for privacy, what alternative fields could you use for troubleshooting?

---

### Q33. How do you detect noisy logs that hurt observability and cost?

**Answer:**
- Build a Kibana dashboard:
  - Top 10 services by log volume.
  - Top 10 log messages by count.
- Look for:
  - Massive volume of repeated info logs.
  - Debug logs left enabled in production.

**Actions:**
- Reduce log level for noisy messages.
- Aggregate or sample logs if necessary (while staying compliant).

**Follow-up question:**
How would you prevent developers from accidentally enabling DEBUG logs in production?

---

### Q34. How would you implement correlation IDs in logs across microservices?

**Answer:**
- On the **edge** (API gateway or first service), generate a `correlation_id` (or reuse `trace_id` if available).
- Pass it in:
  - HTTP headers (e.g., `X-Correlation-ID`).
  - Or message metadata (Kafka, SQS).
- Each service:
  - Reads the header.
  - Logs the same ID in all log entries.

**Benefits:**
- Single ID to trace a request across multiple logs and services.

**Follow-up question:**
How would you use this `correlation_id` in Kibana and Grafana together?

---

### Q35. How do you handle log ingestion failures (e.g., Elastic is down or slow)?

**Answer:**
- Use **buffers** in log agents (Filebeat/Fluent Bit) with disk spooling.
- Apply **backpressure**: if Elastic is slow, log agent slows ingestion but doesn’t lose data immediately.
- Set alerts on:
  - Log pipeline backlog.
  - Error rates in beats/logstash.

**Follow-up question:**
What is your strategy if log pipeline is completely down for 30 minutes; how do you minimize impact?

---

### Q36. How would you verify that all services are actually logging correctly to Elastic/Kibana?

**Answer:**
- Create an inventory of services + expected log index pattern.
- Build a scheduled report / dashboard:
  - Show log volume per service over last X minutes/hours.
  - Highlight services with zero logs.
- Test by forcing known log events (e.g., startup log) and checking they appear.

**Follow-up question:**
What could cause one service to suddenly stop sending logs, even though it is still running?

---

## 13. Deeper Prometheus / Alerting (Q37–Q42)

### Q37. How would you alert on pod restarts in Kubernetes with Prometheus?

**Answer:**
Using `kube_pod_container_status_restarts_total`:

```yaml
- alert: PodRestartingTooOften
  expr: |
    increase(kube_pod_container_status_restarts_total[10m]) > 3
  for: 10m
  labels:
    severity: warning
  annotations:
    summary: "Pod {{ $labels.pod }} is restarting too often"
```

**Explanation:**
- `increase(...[10m])` captures how many restarts happened in last 10 minutes.
- Threshold > 3 indicates crash loop or instability.

**Follow-up question:**
How would you tune this for dev vs prod environments?

---

### Q38. How do you detect “no traffic” or “no metrics” for a service (silent failures) with Prometheus?

**Answer:**
- Use alerts on **absence** of expected metrics:
  - `absent(rate(http_requests_total{service="api"}[5m]))`
- Or check that total request rate is below an expected minimum:
  - `sum(rate(http_requests_total{service="api"}[5m])) < 0.1`

**Use case:**
- Detect misconfigurations (traffic not reaching service), broken exporters, or misrouted traffic.

**Follow-up question:**
What’s the risk of alerting directly on `absent` and how do you avoid noise?

---

### Q39. How do you prevent Prometheus alerts from firing during deployments or known maintenance?

**Answer:**
- Use **silences** in Alertmanager during planned maintenance.
- Label metrics with `env`, `service`, `cluster` and silence specific targets.
- Optionally integrate with deployment tools to automatically create silences for short periods.

**Follow-up question:**
What’s the difference between silence and disabling an alert rule, and why is silence safer?

---

### Q40. How would you use Prometheus for basic capacity planning?

**Answer:**
- Track:
  - CPU and memory usage over time for services and nodes.
  - Requests per second and DB load over weeks/months.
- Use Grafana to:
  - Show usage trends.
  - Extrapolate lines to see when usage will cross safe limits.

**Follow-up question:**
Which metrics would you watch to know when to scale an EKS node group vs scale just the pods?

---

### Q41. How do you alert on “latency is high only in one AZ or one region”?

**Answer:**
- Ensure latency metrics have `zone` or `region` labels.
- Alert on per‑zone metrics:

```promql
histogram_quantile(
  0.95,
  sum(rate(http_request_duration_seconds_bucket{service="api"}[5m]))
  by (le, zone)
)
> 0.3
```

**Explanation:**
- Compute p95 latency per zone; alert if above threshold.

**Follow-up question:**
How would you react if one zone shows high latency but the others are normal?

---

### Q42. How would you reduce noise from flapping alerts?

**Answer:**
- Use `for:` in alert rules (e.g., condition must hold for 10 minutes).
- Apply **hysteresis** (different thresholds for firing vs resolving).
- Group alerts in Alertmanager (e.g., group by service).

**Follow-up question:**
Give an example where you would use different thresholds for firing vs resolving.

---

## 14. Combined Observability Scenarios (Q43–Q50)

### Q43. Scenario: Your Grafana dashboard shows CPU at 90% but users are not complaining. What do you do?

**Answer:**
- Check **application latency and error metrics** first:
  - If latency and errors are normal, high CPU might be acceptable.
- Check **saturation signals**:
  - Queue length, thread pool usage, request backlog.
- Tune alerts to focus on **user impact** (SLOs) rather than raw CPU.

**Follow-up question:**
How would you explain to management why high CPU alone is not always a problem?

---

### Q44. Scenario: Error rate is normal, but business KPI (e.g., successful trades) drops. How do you investigate?

**Answer:**
1. Check **business metrics dashboards** (trades per minute, logins).
2. Check logs for **validation errors**, **user errors**, or **upstream/downstream** changes.
3. Compare **traffic**: maybe fewer incoming requests, not more errors.
4. Check external dependencies (market data feeds, partner APIs).

**Follow-up question:**
What extra observability data would you add to detect “silent business failures” earlier?

---

### Q45. Scenario: You see many 500 errors from one API in Grafana. Logs show database timeouts. What next?

**Answer:**
- Confirm:
  - DB metrics: CPU, IOPS, connections, slow query count.
  - DB logs for lock waits, deadlocks.
- Short‑term:
  - Scale DB or reduce load.
  - Add circuit breakers/retries in the service.
- Long‑term:
  - Optimize queries, add indexes, redesign data model if needed.

**Follow-up question:**
How would you adjust your dashboards and alerts so next time this type of issue is even faster to detect?

---

### Q46. Scenario: Log volume suddenly doubles. How do you handle observability and cost?

**Answer:**
1. Kibana:
   - Top services by log volume; top messages by count.
2. Cause:
   - New debug logs?
   - New noisy error path?
3. Actions:
   - Temporarily throttle or sample logs.
   - Ask team to reduce log volume (change log level).

**Follow-up question:**
What log sampling strategies could you use without losing important information?

---

### Q47. Scenario: Prometheus shows `up == 0` for a critical exporter. What are your steps?

**Answer:**
- `up == 0` means Prometheus cannot scrape that target:
  - Check network: DNS, service IP, firewall.
  - Check exporter pod/container status.
  - Check TLS/cert errors if using HTTPS.
- Temporarily use alternative observability signals if exporter is down.

**Follow-up question:**
How would you avoid “false up” where exporter responds but returns stale or invalid metrics?

---

### Q48. Scenario: You are designing observability for a new Python FastAPI microservice. What do you include from day one?

**Answer:**
- **Logging**: structured JSON logs with `service`, `env`, `request_id`, `user`, `status_code`, `latency_ms`.
- **Metrics**: request count, error count, latency histograms, DB/cache metrics.
- **Tracing**: trace ID and spans for incoming requests and DB calls.
- **Dashboards**: basic Grafana dashboard per service.

**Follow-up question:**
How do you ensure every new FastAPI endpoint automatically gets basic metrics and logging?

---

### Q49. Scenario: During an incident, team wastes time jumping across tools. How can you improve observability UX?

**Answer:**
- Implement **deep links** from:
  - Alerts → relevant Grafana dashboard.
  - Grafana panel → filtered logs in Kibana.
  - Logs → trace viewer.
- Use consistent labels/fields across all tools.
- Build **runbooks** with clickable links for each incident type.

**Follow-up question:**
What standardized naming conventions would you enforce for labels and fields?

---

### Q50. In interviews, how would you summarize your observability experience for this SocGen DevOps role?

**Answer (structure you can reuse):**
- Mention tools: **Elastic/Kibana, Prometheus, Grafana, (optionally OpenTelemetry/Jaeger)**.[web:132][web:133]
- Highlight:
  - Designed **structured logging** and **log pipelines**.
  - Built **service and platform dashboards** with key metrics (latency, errors, saturation).
  - Implemented **alerts** tied to SLOs and reduced alert noise.
  - Used observability to **debug real production incidents** (give 1–2 concrete stories).

**Follow-up question:**
Which specific incident from your experience best showcases your observability skills, and how would you narrate it in 2–3 minutes?

