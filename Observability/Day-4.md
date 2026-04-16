# 📘 Observability Zero to Hero — Episode 4: Custom Metrics Instrumentation & AlertManager

> **Series Recap:** Day 1 = Observability Fundamentals | Day 2 = Metrics & Monitoring + Prometheus Setup | Day 3 = Prometheus Architecture + PromQL + Grafana | **Day 4 = Custom Metrics Instrumentation + AlertManager**

---

## 📌 Table of Contents
1. [What is Instrumentation & Why It Matters](#1-what-is-instrumentation--why-it-matters)
2. [Observability is a Collective Responsibility](#2-observability-is-a-collective-responsibility)
3. [Prometheus Metric Types — Deep Dive](#3-prometheus-metric-types--deep-dive)
4. [Instrumenting Custom Metrics — Node.js Example](#4-instrumenting-custom-metrics--nodejs-example)
5. [Deploying the Application on Kubernetes](#5-deploying-the-application-on-kubernetes)
6. [Service Discovery — The Missing Link](#6-service-discovery--the-missing-link)
7. [ServiceMonitor — Telling Prometheus What to Watch](#7-servicemonitor--telling-prometheus-what-to-watch)
8. [AlertManager — Configuration & Real-Time Alerts](#8-alertmanager--configuration--real-time-alerts)
9. [End-to-End Flow Summary](#9-end-to-end-flow-summary)
10. [Common Mistakes & Best Practices](#10-common-mistakes--best-practices)
11. [Interview Prep — Key Points](#11-interview-prep--key-points)

---

## 1. What is Instrumentation & Why It Matters

### 🧠 Definition

**Instrumentation** is the process of **adding observability code inside your application** so that it emits:
- **Metrics** (e.g., HTTP request count, latency, login count)
- **Logs** (e.g., structured application events)
- **Traces** (e.g., distributed request flow across microservices)

Without instrumentation, your observability stack (Prometheus, Grafana, Jaeger, etc.) is **set up but blind** to what your application is actually doing internally.

### 🔍 Analogy

```
Think of your car's dashboard:
  → Speedometer        = Gauge metric (can go up and down)
  → Odometer           = Counter metric (always increases)
  → Warning lights     = Alerts

Without sensors inside the engine feeding data to the dashboard,
the dashboard is just a screen — useless.

Instrumentation = the sensors inside your application.
```

### 🌍 Real-World AWS Example

```
Scenario: E-commerce platform running on EKS

You have:
  ✅ Prometheus installed
  ✅ Grafana dashboards ready
  ✅ AlertManager configured

But your Payment Service has NO instrumentation.

Result:
  ❌ You cannot see how many transactions failed in last 1 hour
  ❌ You cannot see payment API latency spikes
  ❌ You cannot alert when checkout failure rate exceeds 1%
  ❌ You cannot debug why revenue dropped at 3 PM

Fix:
  → Developers add instrumentation to the Payment Service
  → Expose /metrics endpoint
  → Prometheus scrapes it
  → Grafana dashboards show payment health in real time
```

---

## 2. Observability is a Collective Responsibility

### 🤝 Who Does What?

This is a concept introduced in Day 1, but becomes **crystal clear** in Day 4 when you try to monitor custom application behavior.

```
┌──────────────────────────────────────────────────────────────┐
│              OBSERVABILITY RESPONSIBILITY MAP                 │
│                                                              │
│  DEVELOPERS                    DEVOPS / SRE                  │
│  ─────────────────────         ──────────────────────────    │
│  ✅ Instrument metrics          ✅ Set up Prometheus          │
│  ✅ Write structured logs       ✅ Set up Grafana             │
│  ✅ Add distributed traces      ✅ Set up EFK/Loki stack      │
│  ✅ Expose /metrics endpoint    ✅ Set up Jaeger/Zipkin       │
│  ✅ Define SLIs in code         ✅ Create dashboards          │
│                                 ✅ Configure alerts           │
│                                 ✅ Set up ServiceMonitors     │
└──────────────────────────────────────────────────────────────┘
```

### 🔑 Key Insight

**Exporters (Node Exporter, Kube State Metrics, MySQL Exporter) can NEVER give you application-specific metrics.**

| What Exporters CAN give you | What ONLY Instrumentation can give you |
|----------------------------|---------------------------------------|
| Node CPU, Memory, Disk | HTTP request latency of your login API |
| Pod restart count | Number of users who signed up today |
| MySQL query performance | Payment transaction failure rate |
| Kubernetes object states | Custom business KPIs (orders/minute) |

> 💡 **Bottom Line:** Exporters cover infrastructure. Instrumentation covers **business logic and application behavior**.

---

## 3. Prometheus Metric Types — Deep Dive

### 🧠 Why Different Metric Types?

Just like programming languages have different **data types** (String, List, Dictionary) because not all data is the same, Prometheus has different **metric types** because not all metrics behave the same way.

```
Programming Data Types      ↔     Prometheus Metric Types
─────────────────────────────────────────────────────────
String (text)               ↔     Labels (metadata on metrics)
Integer (whole number)      ↔     Counter (always increasing)
Float (decimal, up/down)    ↔     Gauge (can go up or down)
Array/Buckets               ↔     Histogram (distribution)
Percentile/Quantile         ↔     Summary (pre-calculated percentiles)
```

---

### 📊 Type 1: Counter

**Definition:** A metric that **only ever increases** (or resets to zero on restart). It can never go down.

**Use when:** You are counting occurrences of events.

```
Visual Representation:
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

**Real-World Examples:**
| Metric | Why it's a Counter |
|--------|-------------------|
| `http_requests_total` | Every request adds 1, never subtracts |
| `user_signups_total` | Users only sign up, count always grows |
| `errors_total` | Errors accumulate over time |
| `payments_processed_total` | Each payment adds to the count |

**Code Example (Node.js with prom-client):**

```javascript
const promClient = require('prom-client');

// Define a Counter metric
const httpRequestsTotal = new promClient.Counter({
  name: 'http_requests_total',           // Metric name (used in PromQL)
  help: 'Total number of HTTP requests', // Description
  labelNames: ['method', 'route', 'status_code'] // Labels for filtering
});

// Usage: Increment when a request is received
app.use((req, res, next) => {
  res.on('finish', () => {
    httpRequestsTotal.inc({
      method: req.method,          // GET, POST, etc.
      route: req.path,             // /login, /checkout, etc.
      status_code: res.statusCode  // 200, 404, 500, etc.
    });
  });
  next();
});
```

**PromQL Queries for Counter:**

```promql
# Total HTTP requests across all services
http_requests_total

# Total requests to /login endpoint only
http_requests_total{route="/login"}

# Rate of requests per second over last 5 minutes (most useful for counters!)
rate(http_requests_total[5m])

# Total requests in the last 10 minutes
increase(http_requests_total[10m])

# Error rate (5xx responses / total requests)
rate(http_requests_total{status_code=~"5.."}[5m])
  /
rate(http_requests_total[5m])
```

> ⚠️ **Common Mistake:** Never use raw counter values in graphs — they just show a line going up forever. Always use `rate()` or `increase()` to get **meaningful rates** from counters.

---

### 📊 Type 2: Gauge

**Definition:** A metric that **can go up AND down**. It represents a value at a specific point in time.

**Use when:** You are measuring a current state or level.

```
Visual Representation:
  ▲
80│     ●         ●
60│  ●     ●   ●     ●
40│           ●         ●
20│                        ●
  └────────────────────────────▶ Time
     (CPU % over time — rises and falls)
```

**Real-World Examples:**
| Metric | Why it's a Gauge |
|--------|-----------------|
| `cpu_utilization` | Goes from 20% to 80% and back |
| `memory_usage_bytes` | Increases and decreases as apps run |
| `active_connections` | Users connect and disconnect |
| `kube_configmap_count` | ConfigMaps are created and deleted |
| `queue_size` | Messages added and consumed |

**Code Example (Node.js):**

```javascript
const promClient = require('prom-client');

// Define a Gauge metric
const activeConnections = new promClient.Gauge({
  name: 'active_connections',
  help: 'Number of active WebSocket connections',
  labelNames: ['service']
});

// Increase when connection opens
websocketServer.on('connection', (socket) => {
  activeConnections.inc({ service: 'chat-service' }); // +1

  socket.on('close', () => {
    activeConnections.dec({ service: 'chat-service' }); // -1
  });
});

// Or set to an absolute value
activeConnections.set({ service: 'chat-service' }, 42);
```

**PromQL Queries for Gauge:**

```promql
# Current memory usage per pod
container_memory_usage_bytes{namespace="production"}

# Average CPU across all nodes
avg(node_cpu_seconds_total{mode!="idle"})

# Pods that are NOT in Running state
kube_pod_status_phase{phase!="Running"} == 1

# Memory usage percentage
(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes)
  /
node_memory_MemTotal_bytes * 100
```

---

### 📊 Type 3: Histogram

**Definition:** Samples observations and **counts them in configurable buckets**. Useful for measuring **distributions** of values like latency or request sizes.

**Use when:** You need to answer "how many requests took less than X ms?" or "what is the P95 latency?"

```
Visual Representation (Buckets):

HTTP Request Duration Buckets:
┌─────────────┬─────────────┬─────────────┬─────────────┐
│  ≤ 0.5s     │  ≤ 1s       │  ≤ 5s       │  ≤ 10s      │
│  1,200 reqs │  300 reqs   │  45 reqs    │  5 reqs     │
└─────────────┴─────────────┴─────────────┴─────────────┘
(Most requests are fast, a few are slow — this is a typical distribution)
```

**Real-World Examples:**
| Metric | Why it's a Histogram |
|--------|---------------------|
| `http_request_duration_seconds` | Response time can vary — need distribution |
| `db_query_duration_seconds` | Query times need P50, P95, P99 analysis |
| `payment_processing_duration` | SLA requires 95% of payments under 2s |

**Code Example (Node.js):**

```javascript
const promClient = require('prom-client');

// Define a Histogram metric
const httpRequestDuration = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'HTTP request duration in seconds',
  labelNames: ['method', 'route', 'status_code'],
  buckets: [0.005, 0.01, 0.025, 0.05, 0.1, 0.5, 1, 5, 10]
  //        5ms   10ms   25ms  50ms 100ms 500ms  1s  5s 10s
});

// Usage: Measure request duration
app.use((req, res, next) => {
  const end = httpRequestDuration.startTimer(); // Start timer

  res.on('finish', () => {
    end({                           // Stop timer and record
      method: req.method,
      route: req.path,
      status_code: res.statusCode
    });
  });
  next();
});
```

**PromQL Queries for Histogram:**

```promql
# P50 (median) latency over last 5 minutes
histogram_quantile(0.50,
  rate(http_request_duration_seconds_bucket[5m])
)

# P95 latency — 95% of requests complete within this time
histogram_quantile(0.95,
  rate(http_request_duration_seconds_bucket[5m])
)

# P99 latency — used for SLA/SLO monitoring
histogram_quantile(0.99,
  rate(http_request_duration_seconds_bucket[5m])
)

# Average request duration
rate(http_request_duration_seconds_sum[5m])
  /
rate(http_request_duration_seconds_count[5m])

# How many requests took longer than 1 second
rate(http_request_duration_seconds_bucket{le="1"}[5m])
```

> 💡 **Why Histogram over Counter for latency?**
> A counter can tell you "1000 requests were made." A histogram can tell you "950 completed in under 500ms, 45 in under 1s, and 5 took more than 5 seconds." Histograms reveal the **distribution and tail latency** — critical for SLO monitoring.

---

### 📊 Type 4: Summary

**Definition:** Similar to Histogram but calculates **quantiles on the client side** (inside the application). Less flexible for aggregation across multiple instances.

**When to use:** When you need very accurate quantiles for a single instance and don't need to aggregate across replicas.

> 📌 **Note from the video:** Summary is an advanced topic covered in a dedicated instrumentation video. For now, understand that **Histogram is preferred** in most production Kubernetes setups because it allows server-side aggregation across multiple pods. Summary calculates quantiles at the client which **cannot be accurately aggregated** across multiple instances.

```
Quick Comparison: Histogram vs Summary
──────────────────────────────────────────────────────
Feature              Histogram         Summary
─────────────────────────────────────────────────────
Quantile calc        Server-side       Client-side
Aggregatable         ✅ Yes             ❌ No (inaccurate)
Configurable buckets ✅ Yes (flexible)  ❌ No
Best for             Multi-pod apps    Single instance
──────────────────────────────────────────────────────
→ In Kubernetes: ALWAYS prefer Histogram
```

---

## 4. Instrumenting Custom Metrics — Node.js Example

### 📁 Application Structure

```
day4/
├── application/
│   ├── service-a/
│   │   ├── index.js        ← Main app with metrics instrumentation
│   │   ├── package.json
│   │   └── Dockerfile
│   └── service-b/
│       ├── index.js
│       └── Dockerfile
├── kubernetes-manifests/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── kustomization.yaml
└── alert-manager-service-monitor/
    ├── service-monitor.yaml
    ├── alert-manager-config.yaml
    └── email-secret.yaml
```

### 📝 Complete Instrumented Node.js App (index.js)

```javascript
const express = require('express');
const promClient = require('prom-client');  // Step 1: Import Prometheus client
const axios = require('axios');

const app = express();

// ─────────────────────────────────────────────
// Step 2: Initialize Prometheus Registry
// ─────────────────────────────────────────────
const register = new promClient.Registry();

// Collect default Node.js metrics (memory, CPU, event loop, etc.)
promClient.collectDefaultMetrics({ register });

// ─────────────────────────────────────────────
// Step 3: Define Custom Metric Types
// ─────────────────────────────────────────────

// COUNTER: Total HTTP requests (always incrementing)
const httpRequestsTotal = new promClient.Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests received',
  labelNames: ['method', 'route', 'status_code'],
  registers: [register]
});

// HISTOGRAM: HTTP request duration in seconds
const httpRequestDuration = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status_code'],
  buckets: [0.5, 1, 5, 10],  // Buckets: 0.5s, 1s, 5s, 10s
  registers: [register]
});

// GAUGE: Active in-flight requests right now
const activeRequests = new promClient.Gauge({
  name: 'http_active_requests',
  help: 'Number of HTTP requests currently being processed',
  registers: [register]
});

// ─────────────────────────────────────────────
// Step 4: Middleware to Track Every Request
// ─────────────────────────────────────────────
app.use((req, res, next) => {
  activeRequests.inc();                          // Gauge: +1 active request
  const end = httpRequestDuration.startTimer();  // Start latency timer

  res.on('finish', () => {
    const labels = {
      method: req.method,
      route: req.path,
      status_code: res.statusCode
    };

    httpRequestsTotal.inc(labels);    // Counter: +1 to total requests
    end(labels);                       // Histogram: record duration
    activeRequests.dec();              // Gauge: -1 active request
  });

  next();
});

// ─────────────────────────────────────────────
// Step 5: Expose /metrics endpoint for Prometheus
// ─────────────────────────────────────────────
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());  // Returns all metrics in text format
});

// Application Routes
app.get('/health', (req, res) => {
  res.json({ status: 'running' });
});

app.get('/logs', (req, res) => {
  console.log('Log endpoint hit');
  res.json({ message: 'Log generated' });
});

// This endpoint intentionally crashes the app (for demo/testing)
app.get('/crash', (req, res) => {
  process.exit(1);  // Kubernetes will restart the pod → triggers alert
});

app.listen(3000, () => {
  console.log('Service A running on port 3000');
});
```

### 🔍 What the /metrics Endpoint Returns

When Prometheus (or you via `curl`) hits `/metrics`:

```
# HELP http_requests_total Total number of HTTP requests received
# TYPE http_requests_total counter
http_requests_total{method="GET",route="/health",status_code="200"} 142
http_requests_total{method="GET",route="/logs",status_code="200"} 37
http_requests_total{method="GET",route="/crash",status_code="200"} 2

# HELP http_request_duration_seconds Duration of HTTP requests in seconds
# TYPE http_request_duration_seconds histogram
http_request_duration_seconds_bucket{le="0.5",route="/health"} 140
http_request_duration_seconds_bucket{le="1",route="/health"} 141
http_request_duration_seconds_bucket{le="5",route="/health"} 142
http_request_duration_seconds_bucket{le="+Inf",route="/health"} 142
http_request_duration_seconds_sum{route="/health"} 8.324
http_request_duration_seconds_count{route="/health"} 142

# HELP http_active_requests Number of HTTP requests currently being processed
# TYPE http_active_requests gauge
http_active_requests 1
```

> 💡 This output is in **Prometheus text format** — the standard format all exporters use. Prometheus knows how to parse this automatically.

---

## 5. Deploying the Application on Kubernetes

### Step 1 — Install Prometheus Stack (if not already installed)

```bash
# Add Helm repo
helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts
helm repo update

# Install kube-prometheus-stack
helm install prometheus \
  prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace
```

### Step 2 — Create Application Namespace

```bash
kubectl create namespace dev
```

### Step 3 — Deploy Application Using Kustomize

```yaml
# kubernetes-manifests/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: service-a
  namespace: dev
  labels:
    app: service-a
spec:
  replicas: 1
  selector:
    matchLabels:
      app: service-a
  template:
    metadata:
      labels:
        app: service-a
    spec:
      containers:
      - name: service-a
        image: <your-dockerhub-username>/service-a:latest
        ports:
        - containerPort: 3000
          name: metrics      # ← Important: name the port "metrics"
        resources:
          requests:
            cpu: "100m"
            memory: "128Mi"
          limits:
            cpu: "200m"
            memory: "256Mi"
```

```yaml
# kubernetes-manifests/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: service-a
  namespace: dev
  labels:
    app: service-a           # ← ServiceMonitor will match on this label
spec:
  selector:
    app: service-a
  ports:
  - name: metrics            # ← Port name referenced in ServiceMonitor
    port: 3000
    targetPort: 3000
  type: LoadBalancer         # External access for demo
```

```yaml
# kubernetes-manifests/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - deployment.yaml
  - service.yaml
```

```bash
# Deploy using Kustomize
kubectl apply -k ./kubernetes-manifests/

# Verify pods are running
kubectl get pods -n dev
# NAME                         READY   STATUS    RESTARTS   AGE
# service-a-7d9f8b-xk2p1      1/1     Running   0          2m
# service-b-6c8f7a-ym3q2      1/1     Running   0          2m

# Get the LoadBalancer URL
kubectl get svc -n dev
# NAME        TYPE           CLUSTER-IP      EXTERNAL-IP        PORT(S)
# service-a   LoadBalancer   10.100.12.34    abc.elb.aws.com    3000:32000/TCP
```

### Step 4 — Verify Application Endpoints

```bash
# Health check
curl http://<EXTERNAL-IP>:3000/health
# {"status":"running"}

# View raw metrics (what Prometheus will scrape)
curl http://<EXTERNAL-IP>:3000/metrics

# Generate some test traffic
curl http://<EXTERNAL-IP>:3000/logs
curl http://<EXTERNAL-IP>:3000/health
```

---

## 6. Service Discovery — The Missing Link

### 🧠 The Problem

Even after:
- ✅ Instrumenting metrics in your app
- ✅ Exposing `/metrics` endpoint
- ✅ Deploying the app on Kubernetes
- ✅ Installing Prometheus

**Prometheus still won't scrape your app's metrics!**

```bash
# In Prometheus UI, run this query:
http_requests_total

# Result: No data found 😱
```

### 🔍 Why?

Prometheus needs to know **WHERE to look**. With potentially hundreds of services in your cluster, Prometheus cannot and should not scrape everything blindly.

```
Your Kubernetes Cluster:
  ┌──────────────────────────────────────────────────────┐
  │  100+ Services running...                             │
  │                                                       │
  │  payment-service     ← Has /metrics ✅               │
  │  login-service       ← Has /metrics ✅               │
  │  email-service       ← No /metrics ❌                │
  │  notification-svc    ← No /metrics ❌                │
  │  ... 96 more services                                 │
  └──────────────────────────────────────────────────────┘

Without ServiceMonitor:
  Prometheus doesn't know WHICH services have /metrics
  → Scrapes nothing (or tries everything and wastes resources)

With ServiceMonitor:
  Prometheus knows EXACTLY which services to scrape
  → Efficient, targeted metric collection
```

---

## 7. ServiceMonitor — Telling Prometheus What to Watch

### 🧠 What is ServiceMonitor?

`ServiceMonitor` is a **Kubernetes Custom Resource Definition (CRD)** provided by the Prometheus Operator. It acts as a **configuration bridge** between your application services and Prometheus.

Think of it as: *"Hey Prometheus, watch these specific services for metrics."*

### 📝 ServiceMonitor YAML

```yaml
# alert-manager-service-monitor/service-monitor.yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: service-a-monitor
  namespace: monitoring       # Must be in monitoring namespace
  labels:
    release: prometheus       # Must match Prometheus operator's label selector
spec:
  # Which namespaces to look for services
  namespaceSelector:
    matchNames:
    - dev                     # Look in the 'dev' namespace

  # Which services to monitor (by label)
  selector:
    matchLabels:
      app: service-a          # Match services with label: app=service-a

  # How to scrape those services
  endpoints:
  - port: metrics             # Port name from the Service YAML
    path: /metrics            # Endpoint to hit
    interval: 30s             # Scrape every 30 seconds
    scrapeTimeout: 10s        # Timeout per scrape
```

### Step-by-Step: How ServiceMonitor Works

```
1. You create ServiceMonitor YAML
        │
        ▼
2. Prometheus Operator reads the ServiceMonitor CRD
        │
        ▼
3. Operator updates Prometheus configuration automatically
   (no manual prometheus.yml editing needed!)
        │
        ▼
4. Prometheus now knows:
   "Scrape services with label app=service-a
    in namespace=dev
    at /metrics every 30 seconds"
        │
        ▼
5. Prometheus polls service-a:3000/metrics every 30s
        │
        ▼
6. Custom metrics now appear in Prometheus UI ✅
```

### Deploy the ServiceMonitor

```bash
kubectl apply -f service-monitor.yaml

# Verify it was created
kubectl get servicemonitor -n monitoring
# NAME                  AGE
# service-a-monitor     30s
```

### ✅ Verify It's Working

After applying the ServiceMonitor, wait ~1 minute, then in Prometheus UI:

```
Go to: Status → Targets
Look for: service-a target with State: UP
```

```promql
-- Now run this query in Prometheus UI:
http_requests_total

-- You should now see data! ✅
-- Filter for your service specifically:
http_requests_total{namespace="dev"}
```

> ⚠️ **Common Mistake:** ServiceMonitor `namespace` should be in the **monitoring** namespace, but `namespaceSelector` should point to the **dev** (app) namespace. These are two different things — one is where the ServiceMonitor lives, the other is where it looks for services.

---

## 8. AlertManager — Configuration & Real-Time Alerts

### 🧠 What is AlertManager?

AlertManager is a component of the Prometheus ecosystem that handles **alert routing, deduplication, grouping, and delivery**. When Prometheus detects a metric crossing a threshold, it fires an alert to AlertManager, which then **routes it to the right destination** (email, Slack, PagerDuty, etc.).

### 🔄 AlertManager Flow

```
┌──────────────────────────────────────────────────────────────────┐
│                     ALERTING PIPELINE                            │
│                                                                  │
│  Prometheus          AlertManager           Receivers            │
│  ─────────           ───────────────        ─────────────────    │
│                                                                  │
│  Metric exceeds  →   Deduplicates     →     📧 Email            │
│  threshold           Groups alerts          💬 Slack             │
│  (every 1min)        Routes by labels       📟 PagerDuty         │
│                      Silences/Inhibits       🔔 OpsGenie          │
└──────────────────────────────────────────────────────────────────┘
```

### 📝 Step 1: Gmail App Password Setup

For Gmail to work with AlertManager SMTP, you need an **App Password** (not your regular Gmail password):

```
1. Go to: myaccount.google.com
2. Search: "App Passwords"
3. Prerequisite: Enable 2-Factor Authentication first
4. Create new App Password → Name: "alertmanager"
5. Copy the generated 16-character password
```

### 📝 Step 2: Create Email Secret

AlertManager needs credentials stored as a Kubernetes Secret (base64 encoded):

```bash
# Encode your Gmail App Password to base64
echo -n "your-16-char-app-password" | base64
# Output: eW91ci0xNi1jaGFyLWFwcC1wYXNzd29yZA==
```

```yaml
# alert-manager-service-monitor/email-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: alertmanager-email-secret
  namespace: monitoring
type: Opaque
data:
  # base64 encoded Gmail App Password
  smtp-password: eW91ci0xNi1jaGFyLWFwcC1wYXNzd29yZA==
```

```bash
kubectl apply -f email-secret.yaml
```

### 📝 Step 3: AlertManager Configuration

```yaml
# alert-manager-service-monitor/alert-manager-config.yaml
apiVersion: monitoring.coreos.com/v1alpha1
kind: AlertmanagerConfig
metadata:
  name: alert-manager-config
  namespace: monitoring
spec:
  # ─────────────────────────────────────
  # Route: How to direct incoming alerts
  # ─────────────────────────────────────
  route:
    receiver: 'send-email'          # Default receiver
    groupBy: ['alertname', 'namespace']
    groupWait: 30s                   # Wait 30s before sending (groups alerts)
    groupInterval: 5m                # Resend grouped alerts every 5 min
    repeatInterval: 1h               # Repeat same alert every 1 hour
    routes:
    - matchers:
      - name: alertname
        value: PodCrashLooping        # Route pod crash alerts to email
      receiver: 'send-email'
    - matchers:
      - name: alertname
        value: HighCPUUsage            # Route CPU alerts to email
      receiver: 'send-email'

  # ─────────────────────────────────────
  # Receivers: Where to send alerts
  # ─────────────────────────────────────
  receivers:
  - name: 'send-email'
    emailConfigs:
    - smarthost: 'smtp.gmail.com:587'          # Gmail SMTP server
      authUsername: 'your-email@gmail.com'     # Your Gmail address
      authPassword:
        name: alertmanager-email-secret         # Reference to the Secret
        key: smtp-password
      from: 'your-email@gmail.com'
      to: 'recipient@gmail.com'                # Who receives the alert
      requireTLS: true
      headers:
        subject: '🚨 Kubernetes Alert: {{ .GroupLabels.alertname }}'
      html: |
        <h2>Alert: {{ .GroupLabels.alertname }}</h2>
        <p>Namespace: {{ .GroupLabels.namespace }}</p>
        {{ range .Alerts }}
        <p>Pod: {{ .Labels.pod }}</p>
        <p>Message: {{ .Annotations.message }}</p>
        {{ end }}
```

### 📝 Step 4: Define Alert Rules (PrometheusRule)

```yaml
# alert-rules.yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: application-alert-rules
  namespace: monitoring
  labels:
    release: prometheus             # Must match Prometheus operator selector
spec:
  groups:
  - name: pod-alerts
    interval: 1m                    # Evaluate every 1 minute
    rules:

    # Alert 1: Pod is crash looping
    - alert: PodCrashLooping
      expr: |
        increase(
          kube_pod_container_status_restarts_total[5m]
        ) > 2
      for: 1m                       # Must be true for 1 minute before firing
      labels:
        severity: critical
      annotations:
        summary: "Pod {{ $labels.pod }} is crash looping"
        message: "Pod {{ $labels.pod }} in namespace {{ $labels.namespace }} has restarted {{ $value }} times in 5 minutes"

    # Alert 2: High CPU usage on node
    - alert: HighCPUUsage
      expr: |
        100 - (
          avg by (instance)(
            rate(node_cpu_seconds_total{mode="idle"}[5m])
          ) * 100
        ) > 80
      for: 5m                       # Must be above 80% for 5 minutes
      labels:
        severity: warning
      annotations:
        summary: "High CPU on node {{ $labels.instance }}"
        message: "CPU usage on {{ $labels.instance }} is {{ $value }}%"

    # Alert 3: High HTTP error rate (custom application metric)
    - alert: HighErrorRate
      expr: |
        rate(http_requests_total{status_code=~"5.."}[5m])
          /
        rate(http_requests_total[5m]) > 0.05
      for: 2m
      labels:
        severity: critical
      annotations:
        summary: "High error rate on {{ $labels.route }}"
        message: "Error rate on {{ $labels.route }} is {{ $value | humanizePercentage }}"

    # Alert 4: High HTTP latency (P95 > 2 seconds)
    - alert: HighLatency
      expr: |
        histogram_quantile(0.95,
          rate(http_request_duration_seconds_bucket[5m])
        ) > 2
      for: 3m
      labels:
        severity: warning
      annotations:
        summary: "High latency on {{ $labels.route }}"
        message: "P95 latency on {{ $labels.route }} is {{ $value }}s"
```

### Step 5: Deploy Everything

```bash
# Deploy ServiceMonitor + AlertManager config + Alert Rules
kubectl apply -k ./alert-manager-service-monitor/

# Verify all resources created
kubectl get alertmanagerconfig -n monitoring
kubectl get prometheusrule -n monitoring
kubectl get secret alertmanager-email-secret -n monitoring
```

### Step 6: Trigger a Test Alert (Pod Crash)

```bash
# Method 1: Hit the /crash endpoint of your app
curl http://<EXTERNAL-IP>:3000/crash

# Method 2: Watch pod status
kubectl get pods -n dev -w
# service-a-7d9f8b-xk2p1   0/1   Error          1   30s
# service-a-7d9f8b-xk2p1   0/1   CrashLoopBackOff  2   60s

# Method 3: Create a pod that always crashes
kubectl run crash-test \
  --image=busybox \
  --namespace=dev \
  --restart=Always \
  -- /bin/sh -c "exit 1"
```

**Expected Result:**
```
Within ~2 minutes:
📱 Mobile notification arrives via Gmail
📧 Email received: "🚨 Kubernetes Alert: PodCrashLooping"
    Pod: service-a-7d9f8b-xk2p1
    Namespace: dev
    Restarts: 3 in last 5 minutes
```

### 🔍 Verify Alerts in AlertManager UI

```bash
# Port forward AlertManager UI
kubectl port-forward svc/prometheus-alertmanager 9093:9093 -n monitoring

# Open in browser: http://localhost:9093
# You'll see all firing alerts here
```

---

## 9. End-to-End Flow Summary

### 🗺️ Complete Observability Pipeline (Day 4)

```
┌─────────────────────────────────────────────────────────────────────┐
│                   COMPLETE FLOW                                      │
│                                                                      │
│  STEP 1: Developer instruments metrics in application code           │
│    app.js → prom-client → Counter, Gauge, Histogram defined         │
│                │                                                     │
│                ▼                                                     │
│  STEP 2: App exposes /metrics endpoint                               │
│    GET /metrics → returns Prometheus text format                    │
│                │                                                     │
│                ▼                                                     │
│  STEP 3: App deployed on Kubernetes                                  │
│    kubectl apply -k ./kubernetes-manifests/                         │
│                │                                                     │
│                ▼                                                     │
│  STEP 4: ServiceMonitor created                                      │
│    Tells Prometheus: "Watch service-a in dev namespace"             │
│                │                                                     │
│                ▼                                                     │
│  STEP 5: Prometheus scrapes /metrics every 30s                       │
│    Stores data in Time Series DB (TSDB)                             │
│                │                                                     │
│                ▼                                                     │
│  STEP 6: PrometheusRule evaluates alert conditions every 1m          │
│    "Pod restarted > 2 times in 5 minutes?" → YES → FIRE             │
│                │                                                     │
│                ▼                                                     │
│  STEP 7: Prometheus sends alert to AlertManager                      │
│                │                                                     │
│                ▼                                                     │
│  STEP 8: AlertManager routes alert to Email/Slack/PagerDuty         │
│    📧 Email arrives: "Pod service-a is crash looping!"              │
└─────────────────────────────────────────────────────────────────────┘
```

### 🔑 Three Steps to Production-Ready Custom Metrics

```
Step 1: INSTRUMENT
  → Developers add prom-client to app
  → Define Counter, Gauge, Histogram metrics
  → Expose /metrics endpoint

Step 2: SETUP PROMETHEUS STACK
  → helm install kube-prometheus-stack
  → Gets you: Prometheus + Grafana + AlertManager
               + Node Exporter + Kube State Metrics

Step 3: SERVICE DISCOVERY
  → Create ServiceMonitor YAML
  → Tells Prometheus which services to watch
  → Custom metrics start flowing automatically
```

---

## 10. Common Mistakes & Best Practices

### ❌ Common Mistakes

| Mistake | Problem | Fix |
|---------|---------|-----|
| Using Counter for CPU/Memory | CPU can go down — counter won't | Use Gauge for values that fluctuate |
| Using Gauge for total requests | Total requests should never decrease | Use Counter for cumulative counts |
| No label names on metrics | Can't filter or aggregate in PromQL | Always add `labelNames: ['method', 'route', 'status_code']` |
| Exposing /metrics publicly | Security risk — leaks internal info | Put /metrics behind network policy or internal-only service |
| Missing `release: prometheus` label on ServiceMonitor | Prometheus Operator ignores it | Always add the correct label selector |
| ServiceMonitor in wrong namespace | Prometheus can't find it | Put ServiceMonitor in `monitoring` namespace |
| Wrong `namespaceSelector` | Prometheus looks in wrong namespace | Match it to where your app is deployed |
| Not setting `for` duration in alerts | Too many false positive alerts | Use `for: 2m` to ensure condition persists |
| Using Gmail main password in Secret | App access revoked when you change password | Always use Gmail App Password |
| Not base64 encoding the Secret value | Secret creation fails | Always `echo -n "value" | base64` |

### ✅ Best Practices

```javascript
// 1. Always use descriptive metric names with units
// Bad:
new Counter({ name: 'requests' })

// Good:
new Counter({ name: 'http_requests_total' })
new Histogram({ name: 'http_request_duration_seconds' })
//                                          ^^^^^^^^ unit in the name!

// 2. Keep cardinality low — don't use high-cardinality labels
// Bad (user_id can be millions of values):
labelNames: ['user_id', 'route']

// Good:
labelNames: ['route', 'status_code', 'method']

// 3. Always collect default metrics (free Node.js insights)
promClient.collectDefaultMetrics({ register });
```

```yaml
# 4. Set scrape timeout less than interval
endpoints:
- port: metrics
  interval: 30s
  scrapeTimeout: 10s    # Must be less than interval

# 5. Use severity labels on alerts for better routing
labels:
  severity: critical    # critical → PagerDuty (wake someone up)
  severity: warning     # warning  → Slack (notify team)
  severity: info        # info     → Email (daily digest)

# 6. Always add 'for' duration to avoid flapping alerts
- alert: HighCPU
  expr: cpu_usage > 80
  for: 5m               # Don't alert on a 1-second CPU spike
```

### 🔧 Debugging Tips

```bash
# 1. Verify your app is exposing metrics correctly
curl http://<app-ip>:3000/metrics
# Should return Prometheus text format

# 2. Check if ServiceMonitor was picked up by Prometheus
# Go to Prometheus UI → Status → Targets
# Your service should appear with "State: UP"

# 3. ServiceMonitor not appearing in targets?
kubectl get servicemonitor -n monitoring
kubectl describe servicemonitor service-a-monitor -n monitoring
# Check: Does label 'release: prometheus' match your Prometheus install?

# 4. Alerts not firing?
# Check PrometheusRule was loaded:
kubectl get prometheusrule -n monitoring
# Go to Prometheus UI → Status → Rules
# Your alert rules should appear here

# 5. AlertManager not sending emails?
kubectl logs -n monitoring -l app=alertmanager
# Look for SMTP connection errors

# 6. Check AlertManager config is valid
kubectl get secret alertmanager-prometheus-alertmanager -n monitoring -o yaml
# Decode and verify the config

# 7. Test alert routing manually
# Go to AlertManager UI (port 9093) → Create test alert

# 8. Metric exists in Prometheus but not in Grafana?
# Check data source is set to "Prometheus" (not default)
# Check time range — set to last 15 minutes
```

---

## 11. Interview Prep — Key Points

### 🎯 Most Asked Questions & Answers

**Q: What is instrumentation in the context of observability?**
> Instrumentation is the process of **embedding observability code inside your application** so it emits metrics, logs, and traces. Without instrumentation, tools like Prometheus can monitor infrastructure but cannot see what's happening inside your application — things like HTTP latency, business transaction rates, or custom error rates.

**Q: What are the four Prometheus metric types and when do you use each?**
> - **Counter** → Use for values that only increase (total requests, total errors, total signups). Always use `rate()` or `increase()` with counters in PromQL.
> - **Gauge** → Use for values that go up and down (CPU%, memory%, active connections, pod count).
> - **Histogram** → Use for measuring distributions like latency. Samples are placed in pre-configured buckets. Allows P50/P95/P99 calculation server-side. **Preferred in Kubernetes** because it's aggregatable.
> - **Summary** → Similar to Histogram but calculates quantiles client-side. Cannot be accurately aggregated across multiple instances — less useful in multi-pod Kubernetes deployments.

**Q: Why can't exporters like Node Exporter collect application-specific metrics?**
> Exporters are **pre-built, general-purpose** collectors. Node Exporter knows how to read Linux kernel files (`/proc`, `/sys`). MySQL Exporter knows how to query MySQL internals. But they have **no knowledge of your application's business logic** — they can't know what "number of failed payments in the last hour" means for your specific app. Only your developers can define and emit that metric via instrumentation.

**Q: What is a ServiceMonitor and why is it needed?**
> ServiceMonitor is a Prometheus Operator CRD that tells Prometheus **which Kubernetes services to scrape for metrics**. Without it, even if your app has a working `/metrics` endpoint, Prometheus won't scrape it because Prometheus doesn't automatically discover all services. ServiceMonitor bridges your application services and Prometheus configuration without requiring manual `prometheus.yml` edits.

**Q: What is AlertManager and how does it differ from Prometheus alerts?**
> Prometheus **evaluates alert rules** and fires alerts when conditions are met. AlertManager **receives those alerts and handles routing** — deduplication, grouping, silencing, and delivery to receivers (email, Slack, PagerDuty). Prometheus creates the signal; AlertManager decides who gets notified and how.

**Q: How would you set up end-to-end custom metric monitoring for a new microservice?**
> 1. **Instrument**: Add `prom-client` to the app, define Counter/Gauge/Histogram metrics, expose `/metrics` endpoint.
> 2. **Deploy**: Deploy the service on Kubernetes with a Service that has a named `metrics` port.
> 3. **ServiceMonitor**: Create a `ServiceMonitor` CRD pointing to the service's namespace and label selector.
> 4. **Alert Rules**: Create `PrometheusRule` with alert conditions for the custom metrics.
> 5. **AlertManager**: Configure alert routing to email/Slack with `AlertmanagerConfig`.
> 6. **Grafana**: Create dashboard panels using the custom metric names in PromQL queries.

---

## 📝 Quick Revision Summary

```
Day 4 Key Takeaways:

1. Instrumentation
   → Adding metrics/logs/traces code INSIDE your application
   → Required for application-specific observability
   → Exporters cover infrastructure; instrumentation covers apps

2. Observability = Team Responsibility
   → Developers: instrument metrics, write logs, add traces
   → DevOps/SRE: set up stack, create dashboards, configure alerts

3. Prometheus Metric Types
   → Counter:   Always increases (HTTP requests total, errors total)
   → Gauge:     Goes up and down (CPU%, memory, active connections)
   → Histogram: Distribution in buckets (latency, duration) ← most common
   → Summary:   Client-side percentiles (avoid in multi-pod K8s)

4. Instrumentation in Code (prom-client)
   → Install prom-client library
   → Define metric types with names and labels
   → Increment/observe metrics in your application logic
   → Expose /metrics endpoint (this is what Prometheus scrapes)

5. Service Discovery (ServiceMonitor)
   → Without it: Prometheus doesn't scrape your custom app
   → ServiceMonitor = CRD that tells Prometheus which services to watch
   → Applied in monitoring namespace
   → Uses label selectors to find target services

6. AlertManager
   → Receives alerts from Prometheus
   → Routes to email/Slack/PagerDuty
   → Configured via AlertmanagerConfig CRD
   → Needs Gmail App Password (not main password) for email
   → PrometheusRule defines WHEN to fire alerts

7. Three-Step Formula for Custom Metrics:
   Step 1: INSTRUMENT your code
   Step 2: SETUP Prometheus stack
   Step 3: SERVICE DISCOVERY via ServiceMonitor
```

---

> 📌 **Hands-On Challenge:** Take a simple Python Flask or Node.js app, add `prom-client`, instrument at least one Counter and one Histogram, expose `/metrics`, deploy it to Kubernetes, create a ServiceMonitor for it, and verify the metrics appear in Prometheus UI. Then create a Grafana dashboard panel for that metric. This one exercise covers **everything from Day 1 to Day 4**.
