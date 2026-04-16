# 📘 Observability Zero to Hero — Episode 6: Distributed Tracing & Jaeger

> **Series Recap:** Day 1 = Observability Fundamentals | Day 2 = Metrics & Monitoring | Day 3 = Prometheus + PromQL + Grafana | Day 4 = Custom Metrics + AlertManager | Day 5 = Logging + EFK Stack | **Day 6 = Distributed Tracing + Jaeger**

---

## 📌 Table of Contents
1. [What is Distributed Tracing & Why It Matters](#1-what-is-distributed-tracing--why-it-matters)
2. [Tracing as the Third Pillar of Observability](#2-tracing-as-the-third-pillar-of-observability)
3. [Key Tracing Concepts — Traces, Spans & Context Propagation](#3-key-tracing-concepts--traces-spans--context-propagation)
4. [How Tracing is Implemented — Two Responsibilities](#4-how-tracing-is-implemented--two-responsibilities)
5. [OpenTelemetry — The Standard for Instrumentation](#5-opentelemetry--the-standard-for-instrumentation)
6. [Jaeger Architecture — Deep Dive](#6-jaeger-architecture--deep-dive)
7. [Complete Observability Architecture — All Three Pillars Together](#7-complete-observability-architecture--all-three-pillars-together)
8. [Setting Up Jaeger on AWS EKS — Step by Step](#8-setting-up-jaeger-on-aws-eks--step-by-step)
9. [Instrumenting Traces in Node.js with OpenTelemetry](#9-instrumenting-traces-in-nodejs-with-opentelemetry)
10. [Deploying the Demo Application & Viewing Traces](#10-deploying-the-demo-application--viewing-traces)
11. [Analyzing Traces in the Jaeger UI](#11-analyzing-traces-in-the-jaeger-ui)
12. [Troubleshooting — Jaeger CrashLoopBackOff Debug Story](#12-troubleshooting--jaeger-crashloopbackoff-debug-story)
13. [Common Mistakes & Best Practices](#13-common-mistakes--best-practices)
14. [Interview Prep — Key Points](#14-interview-prep--key-points)

---

## 1. What is Distributed Tracing & Why It Matters

### 🧠 Real-World Analogy — The Hyderabad to Boston Journey

Before jumping into technical details, understand tracing through this story:

```
You are traveling from Hyderabad, India to Boston, USA for the first time.
You carefully note down your travel itinerary with time taken at each step:

  ┌──────────────────────────────────────────────────────────────┐
  │              TRAVEL ITINERARY (Trace)                         │
  │                                                              │
  │  Segment                          Time Taken    Cumulative   │
  │  ─────────────────────────────────────────────────────────   │
  │  Home → Hyderabad Airport (cab)    45 min        45 min      │
  │  Hyderabad → Dubai (flight)       3.5 hrs       4h 15m      │
  │  Dubai → Boston (flight)          12 hrs        16h 15m     │
  │  Boston Airport → Friend's House  2.5 hrs       18h 45m     │
  │  ─────────────────────────────────────────────────────────   │
  │  Total Journey Time               ~25 hours                  │
  └──────────────────────────────────────────────────────────────┘

Your friend says: "Usually this journey takes 23 hours. Why 25?"

Root Cause Found via Tracing:
  → Boston Airport → Friend's House should take 30 MINUTES
  → But it took 2.5 HOURS for you!
  → Reason: You took the wrong cab!

Without the travel itinerary (trace):
  → You'd only know "the journey took 2 hours longer than expected"
  → You'd have NO idea which segment caused the delay
```

### 🖥️ The Same Concept in Microservices

```
User wants to complete a payment on your e-commerce platform.
The request travels through multiple services:

  User Request
      │
      ▼
  Login Service      → 50ms  (authenticate user)
      │
      ▼
  Cart Service       → 30ms  (validate cart items)
      │
      ▼
  Inventory Service  → 20ms  (check stock availability)
      │
      ▼
  Payment Service    → 800ms ← ⚠️ THIS IS THE PROBLEM!
      │
      ▼
  Order Confirmation → 50ms
      │
      ▼
  Response to User   Total: 950ms (SLA requires < 500ms!)

Without Tracing:
  → You know response time is 950ms (too slow) — from metrics
  → You don't know WHICH service is causing the delay

With Tracing:
  → Instantly see: Payment Service took 800ms (should be ~100ms)
  → Developer investigates: Found unindexed DB query in payment service
  → Fix applied → Total response time drops to 250ms ✅
```

### 🌍 Real-World AWS Production Scenario

```
Company: Online Banking Platform on AWS EKS
Services: 15 microservices (Auth, Account, Transfer, Notification, etc.)

Problem:
  Customers complain that fund transfers occasionally take 8-10 seconds
  (Normal: < 2 seconds)

Without Tracing:
  → Metrics show: P99 latency = 8.5 seconds
  → Logs show: No errors (transfers succeed, just slow)
  → Team spends 3 days checking each service manually

With Jaeger Tracing:
  → Open Jaeger UI → Search: service="transfer-service" duration > 5s
  → Trace shows: External bank API call (NEFT gateway) spans 7.2 seconds
  → Root cause: NEFT gateway rate-limiting during peak hours (9-11 AM)
  → Fix: Add request queuing + caching for NEFT gateway calls
  → Resolution time: 4 hours instead of 3 days
```

---

## 2. Tracing as the Third Pillar of Observability

### 🏛️ The Complete Picture

```
┌─────────────────────────────────────────────────────────────────────┐
│                THREE PILLARS OF OBSERVABILITY                        │
│                                                                      │
│  METRICS              LOGS                  TRACES                  │
│  ────────             ────────              ────────                 │
│                                                                      │
│  WHAT?                WHY?                  HOW?                    │
│  ──────               ─────                 ──────                  │
│  Current state        Reason for failure    Full request journey    │
│  of the system        and error details     across all services     │
│                                                                      │
│  "Payment service     "DB connection        "Request: User →        │
│   500 errors: 50/min  timed out in          Auth(50ms) →            │
│   CPU: 85%"           payment_db at         Cart(30ms) →            │
│                       14:32:11"             Payment(800ms←SLOW!)    │
│                                             → Order(50ms)"          │
│                                                                      │
│  Tool: Prometheus     Tool: EFK Stack       Tool: Jaeger            │
│  Dashboard: Grafana   Dashboard: Kibana     Dashboard: Jaeger UI    │
└─────────────────────────────────────────────────────────────────────┘
```

### 🎯 When Each Pillar Helps You

| Scenario | Use Metrics | Use Logs | Use Traces |
|----------|------------|---------|-----------|
| "Is my service healthy?" | ✅ | | |
| "Alert me when CPU > 80%" | ✅ | | |
| "Why did the pod crash?" | | ✅ | |
| "Find all DB errors in last 1h" | | ✅ | |
| "Why is checkout slow?" | | | ✅ |
| "Which service caused latency?" | | | ✅ |
| "Map the request flow" | | | ✅ |

---

## 3. Key Tracing Concepts — Traces, Spans & Context Propagation

### 🧠 Core Terminology

#### Trace
A **trace** represents the **complete journey of a single request** through your entire system — from the moment a user makes a request until they receive a response.

```
One Trace = One request's complete lifecycle across ALL services

Example Trace ID: abc-123-xyz-789
  └── This ID follows the request through EVERY service it touches
```

#### Span
A **span** represents a **single unit of work** within a trace — one operation, one function call, one service hop.

```
Trace abc-123-xyz-789
  ├── Span 1: login-service.authenticate()        [0ms - 50ms]
  ├── Span 2: cart-service.validate()             [50ms - 80ms]
  ├── Span 3: inventory-service.checkStock()      [80ms - 100ms]
  ├── Span 4: payment-service.processPayment()    [100ms - 900ms] ← SLOW
  │     ├── Span 4a: payment-service.validateCard()   [100ms - 120ms]
  │     ├── Span 4b: payment-service.callGateway()    [120ms - 880ms] ← ROOT CAUSE
  │     └── Span 4c: payment-service.updateDB()       [880ms - 900ms]
  └── Span 5: order-service.createOrder()         [900ms - 950ms]
```

#### Span Attributes (Tags)
Each span carries metadata:
```json
{
  "span_id": "def-456",
  "trace_id": "abc-123-xyz-789",
  "operation_name": "payment-gateway-call",
  "service_name": "payment-service",
  "start_time": "2024-01-15T14:32:11.100Z",
  "duration_ms": 760,
  "tags": {
    "http.method": "POST",
    "http.url": "https://gateway.bank.com/process",
    "http.status_code": 200,
    "error": false
  },
  "logs": [
    {"timestamp": "14:32:11.200", "message": "Sending request to gateway"},
    {"timestamp": "14:32:11.860", "message": "Received response from gateway"}
  ]
}
```

#### Context Propagation
The mechanism that **passes the trace ID from service to service** so all spans from one request are linked together.

```
HTTP Headers for Trace Context (W3C Standard):
  traceparent: 00-abc123xyz789-def456-01
  tracestate:  jaeger=def456

Service A → HTTP request with traceparent header → Service B
Service B → creates a child span → HTTP request with same traceparent → Service C

All spans share the same trace_id → All linked in Jaeger UI ✅
```

---

## 4. How Tracing is Implemented — Two Responsibilities

### 🤝 Developer + DevOps Collaboration

Just like custom metrics require both instrumentation (Dev) and Prometheus setup (DevOps), distributed tracing requires work from **both sides**:

```
┌─────────────────────────────────────────────────────────────────┐
│            DISTRIBUTED TRACING RESPONSIBILITY MAP                │
│                                                                  │
│  DEVELOPERS                      DEVOPS / SRE                   │
│  ─────────────────────           ──────────────────────────     │
│                                                                  │
│  ✅ Instrument tracing in app     ✅ Deploy Jaeger on K8s        │
│  ✅ Use OpenTelemetry SDK          ✅ Configure Elasticsearch     │
│  ✅ Define span names              ✅ Set up namespace/RBAC       │
│  ✅ Add span attributes/tags       ✅ Configure storage backend  │
│  ✅ Ensure context propagation     ✅ Expose Jaeger UI            │
│  ✅ Instrument at function level   ✅ Share Jaeger URL with team  │
│  ✅ Set trace sampling rate        ✅ Monitor Jaeger health       │
└─────────────────────────────────────────────────────────────────┘
```

> ⚠️ **Critical Point:** If EITHER side doesn't do their part, tracing doesn't work:
> - **DevOps deploys Jaeger but Devs don't instrument** → Jaeger UI shows no services, no traces
> - **Devs instrument but no Jaeger deployed** → Traces are generated but have nowhere to go (connection errors)

### 🔬 What Happens Without Developer Instrumentation?

```
Modern tools like eBPF can capture some basic traces automatically
(network-level: which service called which service)
But this gives you:
  ✅ Which services communicated
  ❌ Which FUNCTION inside the service was slow
  ❌ What parameters were passed
  ❌ Internal processing time within a service
  ❌ Business context (order ID, user ID, etc.)

Developer instrumentation gives you ALL of the above ✅
```

---

## 5. OpenTelemetry — The Standard for Instrumentation

### 🧠 What is OpenTelemetry?

**OpenTelemetry (OTel)** is a **vendor-neutral, open-source observability framework** for generating, collecting, and exporting telemetry data (metrics, logs, and traces).

```
Why OpenTelemetry?

Without OTel (vendor-specific libraries):
  → Using Jaeger SDK to instrument → Tied to Jaeger forever
  → Want to switch to Datadog? Rewrite ALL instrumentation code!

With OpenTelemetry:
  → Instrument ONCE using OTel SDK
  → Tomorrow switch from Jaeger to Datadog/Zipkin/Tempo
  → Just change the EXPORTER configuration
  → Zero changes to application instrumentation code ✅

"Write once, export anywhere"
```

### 🏗️ OpenTelemetry Architecture

```
Your Application
      │
      │ (uses OTel SDK)
      ▼
OpenTelemetry SDK
      │
      │ (exports via OTLP protocol)
      ▼
OpenTelemetry Collector (optional middleware)
      │
      ├──→ Jaeger     (traces)
      ├──→ Prometheus (metrics)
      └──→ Loki       (logs)
```

### 📦 OpenTelemetry Components

| Component | Description |
|-----------|-------------|
| **SDK** | Library you add to your app (prom-client equivalent for tracing) |
| **API** | Interface for creating spans and traces in code |
| **Collector** | Optional middleware to receive, process, and export telemetry |
| **Exporter** | Sends data to specific backend (Jaeger exporter, Prometheus exporter) |
| **Propagator** | Handles context propagation between services (W3C TraceContext) |
| **Instrumentation Libraries** | Auto-instrumentation for frameworks (Express, HTTP, gRPC) |

---

## 6. Jaeger Architecture — Deep Dive

### 🧠 The Four Components of Jaeger

```
┌─────────────────────────────────────────────────────────────────────┐
│                      JAEGER ARCHITECTURE                             │
│                                                                      │
│  YOUR APPLICATION                                                    │
│  (Instrumented with OpenTelemetry)                                  │
│       │                                                              │
│       │ sends spans via OTLP/Thrift/gRPC                            │
│       ▼                                                              │
│  ┌─────────────┐                                                     │
│  │  JAEGER      │  ← Component 1: AGENT                             │
│  │  AGENT       │    Receives spans from app                        │
│  │  (sidecar or │    Batches them                                   │
│  │   DaemonSet) │    Forwards to Collector                          │
│  └──────┬──────┘                                                     │
│         │ forwards spans                                             │
│         ▼                                                            │
│  ┌─────────────┐                                                     │
│  │  JAEGER      │  ← Component 2: COLLECTOR                         │
│  │  COLLECTOR   │    Receives spans from Agent                      │
│  │              │    Validates and processes spans                  │
│  │              │    Writes to storage backend                      │
│  └──────┬──────┘                                                     │
│         │ writes traces                                              │
│         ▼                                                            │
│  ┌─────────────┐                                                     │
│  │ ELASTICSEARCH│  ← Component 3: STORAGE                           │
│  │  (or Cassandra│   Stores all trace data                          │
│  │   ScyllaDB)  │    Indexed for fast retrieval                    │
│  └──────┬──────┘                                                     │
│         │ reads traces                                               │
│         ▼                                                            │
│  ┌─────────────┐                                                     │
│  │  JAEGER      │  ← Component 4: QUERY (UI)                        │
│  │  QUERY /     │    Web UI for viewing traces                      │
│  │  UI          │    Queries Elasticsearch                          │
│  │  (port 16686)│    Visualizes spans, timelines                   │
│  └─────────────┘                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 🔄 Parallel Comparison — All Three Stacks

This is the key insight from the video — **all three observability stacks follow the same architectural pattern**:

```
┌──────────────────────────────────────────────────────────────────────┐
│           ARCHITECTURAL PATTERN ACROSS ALL THREE STACKS              │
│                                                                      │
│  LAYER          METRICS (Prometheus)  LOGS (EFK)   TRACES (Jaeger)  │
│  ─────────────  ────────────────────  ──────────   ───────────────  │
│                                                                      │
│  Collector      Node Exporter         Fluent Bit   Jaeger Agent     │
│  (reads data)   (DaemonSet)           (DaemonSet)  (sidecar/DS)     │
│                                                                      │
│  Transport      Pull (Prometheus      Push (FB      Push (Agent      │
│  Mechanism      scrapes /metrics)     → ES)         → Collector)    │
│                                                                      │
│  Storage        Prometheus TSDB       Elasticsearch Elasticsearch   │
│                 (time-series)         (full-text)   (indexed)       │
│                                                                      │
│  Query UI       Prometheus UI +       Kibana        Jaeger UI       │
│                 Grafana               (port 5601)   (port 16686)    │
│                                                                      │
│  Query Language PromQL                KQL           Jaeger Search   │
└──────────────────────────────────────────────────────────────────────┘
```

> �� **Key Insight:** If you understand one stack, you understand all three. The components change but the pattern is the same: Collector → Storage → UI.

### 🗄️ Jaeger Storage Options

```
Supported Storage Backends:
  ┌─────────────────┬──────────────────────────────────────────┐
  │ Elasticsearch   │ ← PREFERRED for production               │
  │                 │   Fast, scalable, supports EFK stack too │
  │                 │   Rich query capabilities                │
  ├─────────────────┼──────────────────────────────────────────┤
  │ Cassandra       │ ← Good for very large scale deployments  │
  │                 │   Wide-column store, excellent for TSDB  │
  ├─────────────────┼──────────────────────────────────────────┤
  │ ScyllaDB        │ ← Cassandra-compatible, higher perf      │
  ├─────────────────┼────────────────────────────────────────���─┤
  │ Badger          │ ← Embedded, development only             │
  │ (memory)        │   Not for production                     │
  └─────────────────┴──────────────────────────────────────────┘

Pro Tip: If you already have Elasticsearch for EFK (logs),
         use the SAME Elasticsearch for Jaeger traces!
         → Saves resources
         → One less database to manage
```

---

## 7. Complete Observability Architecture — All Three Pillars Together

### 🗺️ The Full Picture

```
┌──────────────────────────────────────────────────────────────────────┐
│                COMPLETE OBSERVABILITY ARCHITECTURE                    │
│                      (Running on AWS EKS)                            │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐    │
│  │                   APPLICATION PODS                           │    │
│  │   service-a  service-b  payment-service  order-service       │    │
│  │       │           │           │               │              │    │
│  │   metrics      metrics    metrics         metrics            │    │
│  │   logs         logs       logs            logs               │    │
│  │   traces       traces     traces          traces             │    │
│  └──────┬──────────────┬──────────────────────────────────────┘    │
│         │              │                                            │
│  ┌──────▼──────┐  ┌────▼──────────┐   ┌──────────────────────┐    │
│  │Node Exporter│  │  Fluent Bit   │   │   Jaeger Agent       │    │
│  │(DaemonSet)  │  │  (DaemonSet)  │   │   (sidecar/DS)       │    │
│  │Collects:    │  │  Collects:    │   │   Collects:          │    │
│  │CPU/Mem/Disk │  │  All pod logs │   │   All traces         │    │
│  └──────┬──────┘  └────┬──────────┘   └──────────┬───────────┘    │
│         ��              │                          │                 │
│         │(pull)        │(push)                   │(push)           │
│         ▼              ▼                          ▼                 │
│  ┌──────────────┐  ┌──────────────────────────────────────────┐    │
│  │  PROMETHEUS  │  │           ELASTICSEARCH                   │    │
│  │  (TSDB)      │  │  Stores: Logs + Traces                    │    │
│  │              │  │  Backed by: AWS EBS Volumes               │    │
│  └──────┬───────┘  └────────────────┬─────────────────────────┘    │
│         │                           │                               │
│         ▼                           ▼                               │
│  ┌─────────────┐   ┌──────────┐   ┌────────────────────────────┐  │
│  │   GRAFANA   │   │  KIBANA  │   │     JAEGER QUERY UI         │  │
│  │(Metrics UI) │   │(Logs UI) │   │     (Traces UI)             │  │
│  │port 3000    │   │port 5601 │   │     port 16686              │  │
│  └─────────────┘   └──────────┘   └────────────────────────────┘  │
│         │                │                      │                  │
│         └────────────────┴──────────────────────┘                  │
│                  SHARED WITH YOUR TEAM                              │
│         DevOps | Dev | QA | Management | SRE                       │
└──────────────────────────────────────────────────────────────────┘
```

### 🔑 Three URLs You Share with Your Team

```
After full observability setup, share these three URLs:

1. Grafana   → http://grafana.internal:3000
   For: Infrastructure metrics, dashboards, resource monitoring

2. Kibana    → http://kibana.internal:5601
   For: Log search, error investigation, audit trails

3. Jaeger UI → http://jaeger.internal:16686
   For: Request tracing, latency analysis, service dependency maps

RBAC per URL:
  → Management: Grafana viewer (dashboards only)
  → Dev team: All three (debug their own services)
  → DevOps/SRE: Admin on all three
  → Security: Kibana (audit logs) + Grafana (security dashboards)
```

---

## 8. Setting Up Jaeger on AWS EKS — Step by Step

### Prerequisites

```bash
# You need:
# 1. EKS cluster running
# 2. Elasticsearch installed (from Day 5)
# 3. IAM Role + EBS CSI Driver configured (from Day 5)
# 4. Helm installed

# Verify cluster is running
kubectl get nodes
# NAME                           STATUS   ROLES    AGE
# ip-10-0-1-45.ec2.internal      Ready    <none>   2d
# ip-10-0-2-67.ec2.internal      Ready    <none>   2d
```

### Step 1: Ensure Elasticsearch is Running

```bash
# Elasticsearch should already be running from Day 5
kubectl get pods -n logging | grep elasticsearch
# elasticsearch-master-0   1/1   Running   0   2d

# Get Elasticsearch password (save it!)
ES_PASSWORD=$(kubectl get secret elasticsearch-master-credentials \
  -n logging \
  -o jsonpath='{.data.password}' | base64 -d)
echo "Elasticsearch Password: $ES_PASSWORD"
```

### Step 2: Create Tracing Namespace

```bash
kubectl create namespace tracing
kubectl get namespace tracing
# NAME      STATUS   AGE
# tracing   Active   5s
```

> 💡 **Best Practice:** Use separate namespaces for each observability component:
> - `monitoring` → Prometheus, Grafana, AlertManager
> - `logging` → Elasticsearch, Kibana, Fluent Bit
> - `tracing` → Jaeger components

### Step 3: Extract Elasticsearch CA Certificate

```bash
# Jaeger needs to securely communicate with Elasticsearch over HTTPS
# For this it needs the CA certificate

# Extract the CA certificate from Elasticsearch secret
kubectl get secret elasticsearch-master-certs \
  -n logging \
  -o jsonpath='{.data.ca\.crt}' | base64 -d > /tmp/es-ca.crt

# Verify the certificate
cat /tmp/es-ca.crt
# Should show: -----BEGIN CERTIFICATE-----
```

### Step 4: Create ConfigMap for CA Certificate

```bash
# Store the CA cert as a ConfigMap in tracing namespace
kubectl create configmap elasticsearch-ca-cert \
  --from-file=ca.crt=/tmp/es-ca.crt \
  -n tracing

# Verify
kubectl get configmap elasticsearch-ca-cert -n tracing
```

### Step 5: Create Secret for Elasticsearch Credentials

```bash
# Store Elasticsearch credentials as a K8s Secret
kubectl create secret generic elasticsearch-credentials \
  --from-literal=username=elastic \
  --from-literal=password=$ES_PASSWORD \
  -n tracing

# Verify
kubectl get secret elasticsearch-credentials -n tracing
```

### Step 6: Configure Jaeger Helm Values

```yaml
# jaeger-values.yaml
# ═══════════════════════════════════════════════════════════════
# STORAGE CONFIGURATION — where Jaeger stores trace data
# ═══════════════════════════════════════════════════════════════
storage:
  type: elasticsearch              # Use Elasticsearch as backend

  elasticsearch:
    host: elasticsearch-master.logging.svc.cluster.local
    port: 9200
    scheme: https                  # Secure connection
    user: elastic
    password: "<YOUR-ES-PASSWORD>" # ← Update this!
    tls:
      enabled: true
      ca: /es-certs/ca.crt        # Mount path of CA cert

# ═══════════════════════════════════════════════════════════════
# COLLECTOR — receives spans from agents/applications
# ═══════════════════════════════════════════════════════════════
collector:
  replicaCount: 1
  service:
    type: ClusterIP
  resources:
    limits:
      cpu: 500m
      memory: 512Mi
    requests:
      cpu: 200m
      memory: 256Mi
  # Mount the CA certificate
  extraVolumeMounts:
    - name: es-certs
      mountPath: /es-certs
      readOnly: true
  extraVolumes:
    - name: es-certs
      configMap:
        name: elasticsearch-ca-cert

# ═══════════════════════════════════════════════════════════════
# QUERY (UI) — the Jaeger web interface
# ═══════════════════════════════════════════════════════════════
query:
  replicaCount: 1
  service:
    type: ClusterIP           # Use LoadBalancer for external access
    port: 16686
  resources:
    limits:
      cpu: 500m
      memory: 512Mi
    requests:
      cpu: 200m
      memory: 256Mi
  # Mount the CA certificate
  extraVolumeMounts:
    - name: es-certs
      mountPath: /es-certs
      readOnly: true
  extraVolumes:
    - name: es-certs
      configMap:
        name: elasticsearch-ca-cert

# ═══════════════════════════════════════════════════════════════
# AGENT — deployed as sidecar or DaemonSet
# ═══════════════════════════════════════════════════════════════
agent:
  enabled: true
  daemonset:
    useHostPort: true
```

### Step 7: Install Jaeger via Helm

```bash
# Add Jaeger Helm repository
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo update

# Install Jaeger
helm install jaeger jaegertracing/jaeger \
  --namespace tracing \
  --values jaeger-values.yaml

# Watch pods come up
kubectl get pods -n tracing -w
# NAME                              READY   STATUS    RESTARTS   AGE
# jaeger-agent-ds-node1             1/1     Running   0          2m
# jaeger-agent-ds-node2             1/1     Running   0          2m
# jaeger-collector-7d9f8-xk2p1      1/1     Running   0          2m
# jaeger-query-6c8f7a-ym3q2         1/1     Running   0          2m
```

### Step 8: Access Jaeger UI

```bash
# Method 1: Port Forward (works on any K8s cluster)
kubectl port-forward svc/jaeger-query 16686:16686 -n tracing

# If using EC2 instance (add listen address):
kubectl port-forward svc/jaeger-query 16686:16686 \
  -n tracing \
  --address 0.0.0.0

# Access at: http://localhost:16686
# (or http://<ec2-ip>:16686 if using EC2)

# Method 2: Change service type to LoadBalancer
kubectl patch svc jaeger-query -n tracing \
  -p '{"spec":{"type":"LoadBalancer"}}'

# Get the LoadBalancer URL
kubectl get svc jaeger-query -n tracing
```

---

## 9. Instrumenting Traces in Node.js with OpenTelemetry

### 📁 Application Structure

```
day4/application/service-a/
  ├── index.js         ← Main application (routes, business logic)
  ├── tracing.js       ← OpenTelemetry trace instrumentation ← KEY FILE
  └── package.json
```

### Step 1: Install OpenTelemetry Dependencies

```bash
# Install required OpenTelemetry packages
npm install \
  @opentelemetry/sdk-node \
  @opentelemetry/auto-instrumentations-node \
  @opentelemetry/exporter-jaeger \
  @opentelemetry/resources \
  @opentelemetry/semantic-conventions
```

### Step 2: Create tracing.js (Core Instrumentation File)

```javascript
// tracing.js — must be loaded BEFORE your application code
'use strict';

const { NodeSDK } = require('@opentelemetry/sdk-node');
const { JaegerExporter } = require('@opentelemetry/exporter-jaeger');
const { getNodeAutoInstrumentations } = require('@opentelemetry/auto-instrumentations-node');
const { Resource } = require('@opentelemetry/resources');
const { SemanticResourceAttributes } = require('@opentelemetry/semantic-conventions');

// ─────────────────────────────────────────────────────────────
// Step 1: Configure Jaeger Exporter
// This tells OpenTelemetry WHERE to send the traces
// ─────────────────────────────────────────────────────────────
const jaegerExporter = new JaegerExporter({
  // Jaeger collector endpoint (running in 'tracing' namespace)
  endpoint: process.env.JAEGER_ENDPOINT ||
            'http://jaeger-collector.tracing.svc.cluster.local:14268/api/traces',
});

// ─────────────────────────────────────────────────────────────
// Step 2: Define Resource — who is sending these traces?
// This appears as the "service name" in Jaeger UI
// ─────────────────────────────────────────────────────────────
const resource = new Resource({
  [SemanticResourceAttributes.SERVICE_NAME]: 'service-a',     // Shows in Jaeger
  [SemanticResourceAttributes.SERVICE_VERSION]: '1.0.0',
  [SemanticResourceAttributes.DEPLOYMENT_ENVIRONMENT]: process.env.NODE_ENV || 'production',
});

// ─────────────────────────────────────────────────────────────
// Step 3: Initialize OpenTelemetry SDK
// ─────────────────────────────────────────────────────────────
const sdk = new NodeSDK({
  resource: resource,
  traceExporter: jaegerExporter,

  // Auto-instrumentation: automatically creates spans for:
  //   - HTTP requests (incoming and outgoing)
  //   - Express routes
  //   - Database calls (MySQL, MongoDB, Redis)
  //   - gRPC calls
  //   - DNS lookups
  instrumentations: [getNodeAutoInstrumentations({
    '@opentelemetry/instrumentation-http': {
      enabled: true,
    },
    '@opentelemetry/instrumentation-express': {
      enabled: true,
    },
    '@opentelemetry/instrumentation-fs': {
      enabled: false, // Disable filesystem tracing (too noisy)
    },
  })],
});

// ─────────────────────────────────────────────────────────────
// Step 4: Start the SDK before your app does anything
// ─────────────────────────────────────────────────────────────
sdk.start();
console.log('[Tracing] OpenTelemetry initialized for service-a');

// Graceful shutdown — flush remaining spans before exit
process.on('SIGTERM', () => {
  sdk.shutdown()
    .then(() => console.log('[Tracing] SDK shut down gracefully'))
    .catch((error) => console.error('[Tracing] Error shutting down SDK', error))
    .finally(() => process.exit(0));
});
```

### Step 3: Load tracing.js BEFORE Your App Starts

```javascript
// index.js — Entry point of your application
// CRITICAL: tracing.js must be first line!
require('./tracing');  // ← Must be BEFORE any other require()

const express = require('express');
const axios = require('axios');
const app = express();

// Your application routes
app.get('/health', (req, res) => {
  res.json({ status: 'healthy', service: 'service-a' });
});

app.get('/call-service-b', async (req, res) => {
  try {
    // This HTTP call to service-b is AUTOMATICALLY traced!
    // OpenTelemetry adds traceparent header to the request
    // Service-b will see this header and continue the trace
    const response = await axios.get(
      `http://service-b.dev.svc.cluster.local:3001/hello`
    );
    res.json({
      message: 'Service B called',
      data: response.data
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(3000, () => {
  console.log('Service A running on port 3000');
});
```

### Step 4: Service B — tracing.js (Same Pattern, Different Service Name)

```javascript
// service-b/tracing.js
'use strict';

const { NodeSDK } = require('@opentelemetry/sdk-node');
const { JaegerExporter } = require('@opentelemetry/exporter-jaeger');
const { getNodeAutoInstrumentations } = require('@opentelemetry/auto-instrumentations-node');
const { Resource } = require('@opentelemetry/resources');
const { SemanticResourceAttributes } = require('@opentelemetry/semantic-conventions');

const jaegerExporter = new JaegerExporter({
  endpoint: process.env.JAEGER_ENDPOINT ||
            'http://jaeger-collector.tracing.svc.cluster.local:14268/api/traces',
});

const resource = new Resource({
  [SemanticResourceAttributes.SERVICE_NAME]: 'service-b', // ← Different name!
  [SemanticResourceAttributes.SERVICE_VERSION]: '1.0.0',
});

const sdk = new NodeSDK({
  resource,
  traceExporter: jaegerExporter,
  instrumentations: [getNodeAutoInstrumentations()],
});

sdk.start();
```

### Step 5: Manual Span Creation (Advanced — Function-Level Tracing)

```javascript
// For even more detailed tracing, create manual spans
const { trace, context } = require('@opentelemetry/api');

// Get the tracer for this service
const tracer = trace.getTracer('service-a', '1.0.0');

app.post('/process-order', async (req, res) => {
  // Create a parent span for the entire order processing
  const parentSpan = tracer.startSpan('process-order');

  try {
    // Create child span for validation step
    const validateSpan = tracer.startSpan('validate-order', {
      parent: parentSpan,
      attributes: {
        'order.id': req.body.orderId,
        'order.amount': req.body.amount,
        'order.items': req.body.items.length,
      }
    });

    await validateOrder(req.body);
    validateSpan.setStatus({ code: 1 }); // OK
    validateSpan.end();

    // Create child span for payment step
    const paymentSpan = tracer.startSpan('process-payment', {
      attributes: {
        'payment.method': req.body.paymentMethod,
        'payment.currency': 'USD',
      }
    });

    await processPayment(req.body);
    paymentSpan.end();

    parentSpan.setStatus({ code: 1 }); // OK
    res.json({ success: true });

  } catch (error) {
    // Mark span as errored — visible in Jaeger UI
    parentSpan.setStatus({
      code: 2,  // ERROR
      message: error.message
    });
    parentSpan.recordException(error);
    res.status(500).json({ error: error.message });

  } finally {
    parentSpan.end(); // Always end spans!
  }
});
```

### 📦 package.json — Required Dependencies

```json
{
  "name": "service-a",
  "version": "1.0.0",
  "dependencies": {
    "express": "^4.18.0",
    "axios": "^1.4.0",
    "@opentelemetry/sdk-node": "^0.41.0",
    "@opentelemetry/auto-instrumentations-node": "^0.38.0",
    "@opentelemetry/exporter-jaeger": "^1.15.0",
    "@opentelemetry/resources": "^1.15.0",
    "@opentelemetry/semantic-conventions": "^1.15.0",
    "@opentelemetry/api": "^1.4.0"
  }
}
```

---

## 10. Deploying the Demo Application & Viewing Traces

### Step 1: Deploy the Application

```bash
# Create dev namespace (if not already created)
kubectl create namespace dev

# Deploy service-a and service-b
# (Applications already have tracing.js instrumented)
kubectl apply -k ./day4/kubernetes-manifests/

# Verify pods are running
kubectl get pods -n dev
# NAME                         READY   STATUS    RESTARTS   AGE
# service-a-7d9f8b-xk2p1      1/1     Running   0          1m
# service-b-6c8f7a-ym3q2      1/1     Running   0          1m

# Get service-a external URL
kubectl get svc service-a -n dev
# NAME        TYPE           CLUSTER-IP    EXTERNAL-IP           PORT(S)
# service-a   LoadBalancer   10.100.5.67   abc.elb.amazonaws.com 3000:32000/TCP
```

### Step 2: Generate Traces by Hitting Application Endpoints

```bash
APP_URL="http://abc.elb.amazonaws.com:3000"

# Hit the /healthy endpoint (creates a trace in service-a)
curl $APP_URL/healthy
# Response: {"message":"Observability series by Abhishek","status":"healthy"}

# Hit the /call-service-b endpoint (creates a distributed trace)
# This shows: service-a → service-b communication
curl $APP_URL/call-service-b
# Response: {"message":"Service B called","data":{"message":"Hello from Service B"}}

# Generate multiple requests to see trace patterns
for i in {1..5}; do
  curl $APP_URL/healthy
  curl $APP_URL/call-service-b
  sleep 1
done
```

### Step 3: Verify Jaeger Agent Received Traces

```bash
# Check if Jaeger is discovering services
kubectl logs -l app.kubernetes.io/name=jaeger-agent -n tracing | tail -20

# Look for: "Sending spans to collector"
# Look for: service-a, service-b mentioned
```

---

## 11. Analyzing Traces in the Jaeger UI

### 🖥️ Jaeger UI Walkthrough

```
Access: http://localhost:16686 (or LoadBalancer URL)
```

#### Search for Traces

```
Jaeger UI → Search Panel:

  Service:   [service-a ▼]      ← Select your service
  Operation: [all ▼]            ← Or specific endpoint like GET /healthy
  Lookback:  [Last Hour ▼]
  Min Duration: (leave empty)   ← Or set to 100ms to find slow traces
  Max Duration: (leave empty)
  Limit Results: 20

→ Click "Find Traces"
```

#### Understanding Trace Results

```
Search Results show:
  ┌─────────────────────────────────────────────────────────┐
  │ service-a: GET /healthy    6 spans    13µs    2min ago  │
  ├─────────────────────────────────────────────────────────┤
  │ service-a: GET /call-service-b  12 spans  168µs  1m ago │
  └─────────────────────────────────────────────────────────┘

Each row = one request trace
Click on a trace to expand it
```

#### Single Service Trace (/healthy endpoint)

```
Trace: service-a GET /healthy
Total Duration: 13µs
Spans: 6

  service-a                                    ████████████████ 13µs
  ├── middleware          [0µs ────────]  2µs
  ├── express.init        [2µs ────────]  1µs
  ├── logger              [3µs ────────]  1µs
  ├── anonymous           [4µs ────────]  2µs
  └── GET /healthy        [6µs ────────]  7µs   ← Actual handler

Click on "GET /healthy" span to see:
  Tags:
    http.method: GET
    http.url: /healthy
    http.status_code: 200
  Duration: 7µs
```

#### Distributed Trace (/call-service-b endpoint)

```
Trace: service-a → service-b
Total Duration: 168µs
Services: 2 (service-a, service-b)
Spans: 12

  service-a                              ████████████████████████ 168µs
  ├── middleware                [0µs──]  2µs
  ├── express.init              [2µs──]  1µs
  ├── logger                   [3µs──]  1µs
  ├── anonymous                [4µs──]  2µs
  ├── GET /call-service-b      [6µs──]  ████████████████  162µs
  │       │
  │       │ HTTP call to service-b (context propagated!)
  │       ▼
  │   service-b                          ████���█████  100µs
  │   ├── middleware            [66µs──]  2µs
  │   ├── express.init          [68µs──]  1µs
  │   ├── logger                [69µs──]  1µs
  │   └── GET /hello            [70µs──]  ████  96µs
  │
  └── Response received        [166µs──] 2µs

Key Information visible:
  → service-a called service-b ✅
  → service-b responded in ~100µs ✅
  → Total round trip: 168µs ✅
  → No errors (all spans green) ✅
```

### 🗺️ System Architecture View in Jaeger UI

```
Jaeger UI → System Architecture (DAG view)

Shows which services call which services:
  service-a ──→ service-b

In a large microservices system this shows:
  user-service ──→ auth-service
      └──────────→ payment-service ──→ bank-gateway
                        └──────────→ notification-service

This helps teams understand service dependencies
and identify critical paths in the system
```

### 📊 Monitoring View (Prometheus Integration)

```
Jaeger UI → Monitor tab

When integrated with Prometheus, shows:
  → P99 latency per service per operation
  → Error rates per operation
  → Request rates per operation

Note: Requires Prometheus integration — covered in advanced setup.
For now, the Traces view gives you per-request analysis.
```

---

## 12. Troubleshooting — Jaeger CrashLoopBackOff Debug Story

> 📌 **This is a real debugging scenario from the video — very valuable for interviews!**

### 🔍 The Problem

```bash
kubectl get pods -n tracing
# NAME                           READY   STATUS             RESTARTS   AGE
# jaeger-query-6c8f7a-ym3q2     0/1     CrashLoopBackOff   5          5m
# jaeger-collector-7d9f8b-xk2p1  1/1     Running            0          5m
# jaeger-agent-ds-node1          1/1     Running            0          5m
```

**Symptom:** Jaeger Query pod (the UI) is in CrashLoopBackOff. Port forward to Jaeger UI fails.

### 🕵️ Debug Steps

```bash
# Step 1: Check what's in the pod events
kubectl describe pod jaeger-query-6c8f7a-ym3q2 -n tracing
# Events section shows:
# Warning: Liveness probe failed: Get http://localhost:16687/: connection refused
# Warning: Readiness probe failed: Get http://localhost:16687/: connection refused

# Step 2: Check pod logs for the actual error
kubectl logs jaeger-query-6c8f7a-ym3q2 -n tracing --previous
# Error: Failed to connect to Elasticsearch: x509: certificate signed by unknown authority
# OR
# Error: panic: certificate pool is empty
```

### 🔍 Root Cause Analysis

```
The liveness/readiness probe was failing because:

1. Jaeger Query couldn't start → HTTP server never came up
2. Jaeger Query couldn't start because → couldn't connect to Elasticsearch
3. Elasticsearch connection failed because → TLS certificate issue

WHY the certificate issue?
→ Developer deleted old Elasticsearch instance
→ Created new Elasticsearch (new CA certificate generated)
→ OLD CA certificate was still stored in the ConfigMap
→ Jaeger tried to use OLD certificate to verify NEW Elasticsearch
→ Certificate mismatch → Connection rejected → Pod crashes
```

### ✅ The Fix

```bash
# Step 1: Delete the stale certificate ConfigMap
kubectl delete configmap elasticsearch-ca-cert -n tracing

# Step 2: Delete the stale credentials Secret
kubectl delete secret elasticsearch-credentials -n tracing

# Step 3: Extract NEW CA certificate from NEW Elasticsearch
kubectl get secret elasticsearch-master-certs \
  -n logging \
  -o jsonpath='{.data.ca\.crt}' | base64 -d > /tmp/es-ca-new.crt

# Step 4: Recreate ConfigMap with NEW certificate
kubectl create configmap elasticsearch-ca-cert \
  --from-file=ca.crt=/tmp/es-ca-new.crt \
  -n tracing

# Step 5: Recreate Secret with NEW password
NEW_ES_PASSWORD=$(kubectl get secret elasticsearch-master-credentials \
  -n logging \
  -o jsonpath='{.data.password}' | base64 -d)

kubectl create secret generic elasticsearch-credentials \
  --from-literal=username=elastic \
  --from-literal=password=$NEW_ES_PASSWORD \
  -n tracing

# Step 6: Restart Jaeger to pick up new config
kubectl rollout restart deployment/jaeger-query -n tracing
kubectl rollout restart deployment/jaeger-collector -n tracing

# Step 7: Verify pods recover
kubectl get pods -n tracing -w
# All pods → Running ✅
```

### 💡 Lesson Learned

```
When you see CrashLoopBackOff on Jaeger:

1. FIRST check: kubectl describe pod → look at Events section
   → Liveness/Readiness probe failing = app not starting

2. THEN check: kubectl logs <pod> --previous
   → Previous container logs (before it crashed)
   → Look for: "certificate", "connection refused", "authentication failed"

3. Common causes:
   → Stale certificates after Elasticsearch reinstall
   → Wrong password in Helm values or Secret
   → Elasticsearch not yet ready when Jaeger starts
   → Wrong Elasticsearch hostname/port

Rule of thumb:
  "Liveness probe failed" = App didn't start = Config/connection issue
  Always check logs with --previous flag to see crash reason
```

---

## 13. Common Mistakes & Best Practices

### ❌ Common Mistakes

| Mistake | Problem | Fix |
|---------|---------|-----|
| Not calling `require('./tracing')` as first line | Some requests not traced — SDK not initialized when requests come in | Always put `require('./tracing')` as the absolute first line |
| Not ending spans (`span.end()`) | Memory leaks, incomplete traces in Jaeger | Always call `span.end()` in try/finally block |
| Using high-cardinality span attributes | Elasticsearch fills up, Jaeger slows down | Use low-cardinality values: status codes, not user IDs |
| Sampling rate = 100% in production | Jaeger overwhelmed with millions of spans | Set sampling to 1-10% in production |
| Forgetting to update ES cert after reinstall | Jaeger CrashLoopBackOff | Always delete and recreate ConfigMap/Secret after Elasticsearch reinstall |
| Hardcoding Jaeger endpoint in code | Can't change without rebuilding image | Use environment variable: `process.env.JAEGER_ENDPOINT` |
| All services named the same | Can't distinguish services in Jaeger | Each service must have unique `SERVICE_NAME` |
| No namespace separation | Hard to manage, poor security | Use `monitoring`, `logging`, `tracing` namespaces |
| Not installing Jaeger Agent | Applications can't send spans | Ensure Jaeger agent is running as DaemonSet |
| Using memory storage in production | Traces lost on pod restart | Always use Elasticsearch or Cassandra for production |

### ✅ Best Practices

```javascript
// 1. Always use environment variables for Jaeger endpoint
const jaegerExporter = new JaegerExporter({
  endpoint: process.env.JAEGER_ENDPOINT ||
            'http://jaeger-collector.tracing.svc.cluster.local:14268/api/traces'
});

// 2. Set appropriate sampling in production (don't trace everything!)
const { TraceIdRatioBased } = require('@opentelemetry/sdk-trace-base');

const sdk = new NodeSDK({
  sampler: new TraceIdRatioBased(0.1), // Sample only 10% of requests
  // For high-priority operations (payments), use 100%:
  // sampler: new TraceIdRatioBased(1.0)
});

// 3. Add business context to spans (makes debugging actionable)
const span = tracer.startSpan('process-payment');
span.setAttributes({
  'order.id': orderId,          // ✅ Good - fixed cardinality
  'payment.method': 'credit',   // ✅ Good - fixed set of values
  // 'user.email': email,       // ❌ Bad - high cardinality
  // 'request.body': JSON.stringify(body) // ❌ Bad - sensitive data
});

// 4. Always use try/finally to ensure span.end() is called
const span = tracer.startSpan('my-operation');
try {
  await doSomething();
  span.setStatus({ code: SpanStatusCode.OK });
} catch (error) {
  span.setStatus({ code: SpanStatusCode.ERROR, message: error.message });
  span.recordException(error);
} finally {
  span.end(); // ← ALWAYS runs, even if error thrown
}
```

```yaml
# 5. Set resource limits to protect cluster from Jaeger overhead
# jaeger-values.yaml
collector:
  resources:
    limits:
      cpu: "500m"
      memory: "512Mi"
    requests:
      cpu: "200m"
      memory: "256Mi"

query:
  resources:
    limits:
      cpu: "500m"
      memory: "512Mi"

# 6. Set Elasticsearch index retention for traces
# (Traces don't need to be kept as long as logs)
# In Kibana → Index Lifecycle Management:
#   jaeger-* indices → Delete after 7 days
#   (Logs: 30 days, Traces: 7 days is typical)
```

### 🔧 Debugging Tips

```bash
# 1. Traces not appearing in Jaeger UI?
# Check if application is sending spans:
kubectl logs -l app=service-a -n dev | grep -i "trace\|span\|jaeger\|otlp"

# 2. Connection refused between app and Jaeger?
# Verify Jaeger collector service exists and is accessible:
kubectl get svc -n tracing | grep collector
# Test connectivity from app pod:
kubectl exec -it <service-a-pod> -n dev -- \
  curl http://jaeger-collector.tracing.svc.cluster.local:14268/

# 3. Jaeger shows services but no traces?
# Wait: traces take 30-60 seconds to appear after first request
# Check: Is your JAEGER_ENDPOINT environment variable correct?
kubectl describe pod <service-a-pod> -n dev | grep JAEGER

# 4. Jaeger Query pod crashing?
kubectl logs <jaeger-query-pod> -n tracing --previous
# Look for: certificate errors, authentication errors, connection errors

# 5. Spans from service-a visible but not service-b?
# Check service-b has tracing.js loaded AND correct SERVICE_NAME
# Verify context propagation: service-a must pass traceparent header
kubectl logs -l app=service-b -n dev | grep -i "trace"

# 6. Check all Jaeger pods are healthy:
kubectl get pods -n tracing
# All 4 components must be Running:
# jaeger-agent (DaemonSet)
# jaeger-collector (Deployment)
# jaeger-query (Deployment)
# elasticsearch-master (StatefulSet - in logging namespace)

# 7. Verify Elasticsearch has Jaeger indices:
kubectl exec -it elasticsearch-master-0 -n logging -- \
  curl -u elastic:$ES_PASSWORD \
  "http://localhost:9200/_cat/indices?v" | grep jaeger
# Should show: jaeger-service-YYYY-MM-DD   ← Service index
#              jaeger-span-YYYY-MM-DD       ← Span index
```

---

## 14. Interview Prep — Key Points

### 🎯 Most Asked Questions & Answers

**Q: What is distributed tracing and why is it needed in microservices?**
> Distributed tracing tracks a single request's complete journey across multiple microservices. In a monolith, debugging is easy — one codebase, one log file. In microservices, a single user request can touch 10+ services. When latency increases or errors occur, distributed tracing shows you **exactly which service, which function, and how long each hop took**. Without it, identifying a latency bottleneck in 15 services would take days.

**Q: What is the difference between a Trace and a Span?**
> A **Trace** is the entire end-to-end journey of one request through the system — it has a unique Trace ID that follows the request everywhere. A **Span** is one individual unit of work within that trace — one function call, one database query, one service hop. A trace is made up of multiple spans organized in a parent-child hierarchy.

**Q: What is OpenTelemetry and why is it preferred for instrumentation?**
> OpenTelemetry is a vendor-neutral, open-source observability framework. The key advantage is **write once, export anywhere** — you instrument your code with OTel SDK once, and you can send traces to Jaeger, Zipkin, Datadog, Tempo, or any other backend just by changing the exporter configuration. Without OTel, switching tracing tools requires rewriting all instrumentation code.

**Q: What are the four components of Jaeger?**
> 1. **Agent** — Receives spans from your application (deployed as DaemonSet or sidecar). 2. **Collector** — Receives spans from Agent, processes and validates them, writes to storage. 3. **Storage** — Database backend (Elasticsearch preferred, also Cassandra/ScyllaDB). 4. **Query/UI** — Web interface (port 16686) for searching and visualizing traces.

**Q: How does Jaeger architecture compare to Prometheus/EFK?**
> All three follow the same pattern: **Collector → Storage → UI**. In Prometheus: Node Exporter → TSDB → Grafana. In EFK: Fluent Bit → Elasticsearch → Kibana. In Jaeger: Jaeger Agent → Elasticsearch → Jaeger UI. Understanding one makes the others easy to grasp.

**Q: How is context propagation handled in distributed tracing?**
> When Service A calls Service B, OpenTelemetry automatically injects a `traceparent` HTTP header into the outgoing request. This header contains the Trace ID and Span ID. Service B's OpenTelemetry SDK reads this header and creates a child span with the same Trace ID. This links all spans from one user request together under one trace in Jaeger.

**Q: What would you do if Jaeger Query is in CrashLoopBackOff?**
> First, run `kubectl describe pod <jaeger-query-pod>` and look at the Events section — if liveness/readiness probes are failing, the app isn't starting. Then run `kubectl logs <pod> --previous` to see the crash logs. Common causes: (1) stale TLS certificate in ConfigMap after Elasticsearch reinstall, (2) wrong password in Helm values/Secret, (3) Elasticsearch not reachable. Fix by deleting and recreating the certificate ConfigMap and credentials Secret with fresh values.

---

## 📝 Quick Revision Summary

```
Day 6 Key Takeaways:

1. What is Distributed Tracing?
   → Tracks complete journey of a request through all microservices
   → Shows which service caused latency or errors
   → Travel itinerary analogy: each hop = a span, full journey = a trace

2. Three Pillars Completed:
   → Metrics (Prometheus/Grafana) = WHAT is happening
   → Logs (EFK Stack)             = WHY is it failing
   → Traces (Jaeger)              = HOW to find the root cause

3. Key Concepts:
   → Trace = complete request lifecycle (has unique Trace ID)
   → Span  = single unit of work within a trace
   → Context Propagation = passing Trace ID between services via HTTP headers

4. Implementation = Two Responsibilities:
   → Developer: Instrument code with OpenTelemetry SDK (tracing.js)
   → DevOps/SRE: Deploy and configure Jaeger on Kubernetes

5. OpenTelemetry:
   → Vendor-neutral instrumentation standard
   → Write once, export to any backend (Jaeger/Datadog/Zipkin)
   → Auto-instruments HTTP, Express, DB calls automatically

6. Jaeger Architecture (4 components):
   → Agent     → Receives spans from your app
   → Collector → Processes and writes to storage
   → Storage   → Elasticsearch (same as EFK!) or Cassandra
   → Query/UI  → Port 16686 — search and visualize traces

7. AWS EKS Setup:
   → IAM Role + EBS CSI Driver (same as Elasticsearch for logs)
   → Create namespace: tracing
   → Extract ES CA cert → ConfigMap
   → ES credentials → Secret
   → Helm install jaeger with ES backend

8. Debugging CrashLoopBackOff:
   → kubectl describe pod → Events (probe failures = app not starting)
   → kubectl logs --previous (see actual crash reason)
   → Most common: stale certificates after ES reinstall

9. Three URLs to Share with Team:
   → Grafana  (port 3000) → Metrics & Dashboards
   → Kibana   (port 5601) → Logs & Search
   → Jaeger   (port 16686) → Distributed Traces
```

---

> 📌 **Hands-On Challenge:** Take the service-a and service-b applications from the Day 4 folder. Add `tracing.js` to both services (using OpenTelemetry). Deploy them on Kubernetes with Jaeger running. Hit the `/call-service-b` endpoint multiple times. Open Jaeger UI and find the trace that shows the full service-a → service-b communication path. Click through each span and note the duration. This exercise covers the complete distributed tracing workflow end-to-end.
