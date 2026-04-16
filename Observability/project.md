# 📘 Observability Zero to Hero — Episode 7: End-to-End Observability Project with OpenTelemetry Demo App

> **Series Recap:** Day 1 = Fundamentals | Day 2 = Metrics & Prometheus | Day 3 = PromQL + Grafana | Day 4 = Custom Metrics + AlertManager | Day 5 = Logging + EFK | Day 6 = Distributed Tracing + Jaeger | **Day 7 = End-to-End Observability Project**

---

## 📌 Table of Contents
1. [The OpenTelemetry Demo Application — What & Why](#1-the-opentelemetry-demo-application--what--why)
2. [Observability = Instrumentation + Implementation](#2-observability--instrumentation--implementation)
3. [Why OpenTelemetry? The Vendor-Neutral Standard](#3-why-opentelemetry-the-vendor-neutral-standard)
4. [OpenTelemetry Architecture — Receiver, Processor, Exporter](#4-opentelemetry-architecture--receiver-processor-exporter)
5. [How OpenTelemetry Connects to Jaeger & Prometheus](#5-how-opentelemetry-connects-to-jaeger--prometheus)
6. [Deploying the Demo App on AWS EKS](#6-deploying-the-demo-app-on-aws-eks)
7. [Exploring Traces in Jaeger UI](#7-exploring-traces-in-jaeger-ui)
8. [Exploring Metrics in Grafana](#8-exploring-metrics-in-grafana)
9. [Understanding the Code — How Telemetry is Instrumented](#9-understanding-the-code--how-telemetry-is-instrumented)
10. [Resume & Interview Usage of This Project](#10-resume--interview-usage-of-this-project)
11. [Common Mistakes & Best Practices](#11-common-mistakes--best-practices)
12. [Interview Prep — Key Points](#12-interview-prep--key-points)

---

## 1. The OpenTelemetry Demo Application — What & Why

### 🧠 What is the OpenTelemetry Demo App?

The **OpenTelemetry Demo Application** is an **open-source, production-like microservices e-commerce application** specifically designed to demonstrate and learn observability concepts — metrics, logs, and traces — using OpenTelemetry.

```
GitHub: github.com/open-telemetry/opentelemetry-demo

Maintained by top observability companies:
  ✅ Datadog
  ✅ Dynatrace
  ✅ Microsoft
  ✅ Alibaba
  ✅ Grafana Labs
  ✅ And many more CNCF contributors
```

### 🛒 Application Architecture — E-Commerce Platform

```
┌──────────────────────────────────────────────────────────────────┐
│                 OPENTELEMETRY DEMO APP                            │
│              (Multi-Microservice E-Commerce)                      │
│                                                                   │
│  Frontend Layer:                                                  │
│  ┌──────────────┐   ┌──────────────────┐                        │
│  │  Frontend    │   │  Frontend Proxy   │                        │
│  │  (Web UI)    │──▶│  (Envoy/nginx)    │                        │
│  └──────────────┘   └──────────────────┘                        │
│                              │                                    │
│  Business Services:          ▼                                    │
│  ┌───────────┐  ┌──────────────┐  ┌─────────────┐              │
│  │   Cart    │  │   Checkout   │  │   Payment   │              │
│  │  Service  │  │   Service    │  │   Service   │              │
│  └───────────┘  └──────────────┘  └─────────────┘              │
│                                                                   │
│  ┌───────────┐  ┌──────────────┐  ┌─────────────┐              │
│  │ Product   │  │ Recommendation│  │  Shipping   │              │
│  │ Catalog   │  │   Service    │  │   Service   │              │
│  └───────────┘  └──────────────┘  └─────────────┘              │
│                                                                   │
│  Supporting Services:                                             │
│  ┌───────────┐  ┌──────────────┐  ┌─────────────┐              │
│  │ Currency  │  │    Email     │  │   Ad        │              │
│  │  Service  │  │   Service    │  │   Service   │              │
│  └───────────┘  └──────────────┘  └─────────────┘              │
│                                                                   │
│  Observability Stack (bundled):                                   │
│  ┌───────────┐  ┌──────────────┐  ┌─────────────┐              │
│  │  Jaeger   │  │  Prometheus  │  │   Grafana   │              │
│  │  (traces) │  │  (metrics)   │  │ (dashboards)│              │
│  └───────────┘  └──────────────┘  └─────────────┘              │
│                                                                   │
│  ┌────────────────────┐                                          │
│  │  Load Generator    │  ← Simulates user traffic automatically  │
│  │  (fake traffic)    │                                          │
│  └────────────────────┘                                          │
└──────────────────────────────────────────────────────────────────┘
```

### 🌍 Services and Their Programming Languages

| Service | Language | What it Does |
|---------|----------|-------------|
| **Frontend** | TypeScript | Web UI served to users |
| **Frontend Proxy** | Envoy | API gateway / reverse proxy |
| **Cart Service** | .NET / C# | Manages shopping cart |
| **Checkout Service** | Go | Handles order checkout |
| **Product Catalog** | Go | Lists and searches products |
| **Payment Service** | Node.js | Processes payments |
| **Shipping Service** | Rust | Calculates shipping costs |
| **Email Service** | Ruby | Sends order confirmation emails |
| **Recommendation** | Python | Suggests products |
| **Currency Service** | Node.js | Converts currencies |
| **Ad Service** | Java | Displays advertisements |
| **Load Generator** | Python/Locust | Generates fake user traffic |

> 💡 **Why This Matters:** Real production systems have services in multiple languages. This demo reflects reality — you can't always choose one language. OpenTelemetry works across ALL languages with a consistent API.

### 🎯 Why Use This Application for Learning?

```
Benefits for DevOps/SRE Learning:

1. Production-like complexity
   → 15+ microservices like real enterprise systems
   → gRPC + HTTP communication between services
   → Multiple programming languages

2. Already instrumented with OpenTelemetry
   → You don't write instrumentation from scratch
   → See professional-grade instrumentation examples
   → Learn by reading production-quality code

3. Bundled observability stack
   → Jaeger, Prometheus, Grafana all pre-configured
   → Deploy one Helm chart → Full observability ready
   → Perfect for learning without setup headaches

4. Official documentation
   → Deploy on Docker, Kubernetes (kind, EKS, GKE, AKS)
   → Helm chart available
   → Architecture diagrams and code walkthrough

5. Great for resume
   → "Implemented end-to-end observability on multi-language
      microservices using OpenTelemetry, Jaeger, and Prometheus"
   → Real project backed by industry leaders
```

---

## 2. Observability = Instrumentation + Implementation

### 🧠 The Two Pillars (Revisited — Now With Context)

This is a **critical concept** reinforced in this episode. Even with the best observability tools, nothing works without both halves:

```
┌──────────────────────────────────────────────────────────────────┐
│             OBSERVABILITY = TWO EQUAL HALVES                      │
│                                                                   │
│   HALF 1: INSTRUMENTATION          HALF 2: IMPLEMENTATION        │
│   (Developer Responsibility)        (DevOps/SRE Responsibility)  │
│   ──────────────────────────        ──────────────────────────── │
│                                                                   │
│   ✅ Emit metrics from code          ✅ Deploy Prometheus         │
│   ✅ Emit logs from code             ✅ Deploy Grafana            │
│   ✅ Emit traces from code           ✅ Deploy Jaeger             │
│   ✅ Use OpenTelemetry SDK           ✅ Deploy EFK Stack          │
│   ✅ Define meaningful spans         ✅ Configure storage (EBS)   │
│   ✅ Expose /metrics endpoint        ✅ Create dashboards         │
│   ✅ Use correct metric types        ✅ Set up alerting rules     │
│                                      ✅ Create ServiceMonitors    │
│                                                                   │
│   ❌ Missing either half = Observability doesn't work            │
└──────────────────────────────────────────────────────────────────┘
```

### 🔍 How to Check if an Application is Instrumented

As a DevOps engineer, when you receive a new microservice, **ask these questions first**:

```
Checklist: Is this microservice observable?

□ Does it emit metrics?
  → Look for: prom-client, otel-metrics, StatsD in imports
  → Check: Is there a /metrics endpoint?

□ Does it emit logs?
  → Look for: structured logging (JSON format)
  → Check: Are log levels being used (INFO/WARN/ERROR)?

□ Does it emit traces?
  → Look for: opentelemetry, jaeger-client, zipkin in imports
  → Check: Are spans being created in key functions?

□ Is it using OpenTelemetry (vendor-neutral)?
  → Look for: @opentelemetry/* packages
  → Look for: go.opentelemetry.io/otel in go.mod
  → Look for: opentelemetry-sdk in requirements.txt
```

### 🔎 Checking Instrumentation in Different Languages

**Go (Checkout/Product Catalog Service):**
```go
// main.go — Look for these otel imports
import (
    "go.opentelemetry.io/otel"              // Core OTel
    "go.opentelemetry.io/otel/trace"        // Tracing
    "go.opentelemetry.io/otel/metric"       // Metrics
    "go.opentelemetry.io/otel/exporters/otlp/otlptrace"  // OTLP exporter
)

// Look for tracer initialization
tracer := otel.Tracer("checkout-service")

// Look for span creation in key functions
func (cs *checkoutService) PlaceOrder(ctx context.Context, req *pb.PlaceOrderRequest) {
    ctx, span := tracer.Start(ctx, "PlaceOrder")  // ← Span created
    defer span.End()
    // ... business logic
}

// Look for metrics definition
var orderCounter metric.Int64Counter
orderCounter, _ = meter.Int64Counter(
    "orders.placed",
    metric.WithDescription("Total orders placed"),
)
```

**Python (Recommendation Service):**
```python
# recommendation_server.py — Look for these otel imports
from opentelemetry import trace, metrics
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter

# Tracer usage
tracer = trace.get_tracer("recommendation-service")

# Metrics usage
meter = metrics.get_meter("recommendation-service")
recommendations_counter = meter.create_counter(
    "app.recommendations.counter",
    description="Number of recommendations made"
)

# Span in key function
def ListRecommendations(self, request, context):
    with tracer.start_as_current_span("ListRecommendations") as span:
        span.set_attribute("app.products_recommended", len(product_ids))
        recommendations_counter.add(len(product_ids))
        return demo_pb2.ListRecommendationsResponse(product_ids=product_ids)
```

**Java (Ad Service):**
```java
// AdService.java — Look for these otel imports
import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.trace.Tracer;
import io.opentelemetry.api.metrics.LongCounter;

// Tracer and metrics initialization
private static final Tracer tracer =
    GlobalOpenTelemetry.getTracer("ad-service");

private static final LongCounter adRequestsCounter =
    GlobalOpenTelemetry.getMeter("ad-service")
        .counterBuilder("app.ads.requests")
        .setDescription("Counts ad requests")
        .build();

// Span in key function
public ListAdsResponse ListAds(ListAdsRequest request) {
    Span span = tracer.spanBuilder("ListAds").startSpan();
    try (Scope scope = span.makeCurrent()) {
        adRequestsCounter.add(1);
        // ... business logic
        return response;
    } finally {
        span.end();
    }
}
```

---

## 3. Why OpenTelemetry? The Vendor-Neutral Standard

### 🧠 The Problem OpenTelemetry Solves

```
The Pre-OpenTelemetry World (The Problem):

Company uses Prometheus → Developers use prom-client SDK:
  service-a/metrics.js    → const client = require('prom-client')
  service-b/metrics.py    → from prometheus_client import Counter
  service-c/metrics.go    → import "github.com/prometheus/client_golang"
  ... × 50 microservices

Now company decides to migrate to Datadog:

Cost of migration:
  → 50 developers
  × 3 files each (metrics + logs + traces)
  × 2-3 days per file
  = MONTHS of work just changing SDK imports!

Plus:
  → Risk of bugs during migration
  → Services temporarily with NO observability
  → Testing all 50 services again
  → This is the real cost of vendor lock-in
```

### ✅ The OpenTelemetry Solution

```
The OpenTelemetry World (The Solution):

All services use OpenTelemetry SDK:
  service-a/tracing.js → const { NodeSDK } = require('@opentelemetry/sdk-node')
  service-b/tracing.py → from opentelemetry import trace, metrics
  service-c/main.go    → import "go.opentelemetry.io/otel"
  ... × 50 microservices

Company decides to migrate from Jaeger to Datadog:

Cost of migration:
  → Change ONE config file (otel-collector-config.yaml)
  → Update exporter: jaeger → datadog
  → Deploy updated config
  = 1 engineer, 1 day!

No changes to application code ✅
No risk to instrumentation ✅
All 50 services automatically use new backend ✅
```

### 🌍 Real-World Industry Impact

```
Why CNCF and top companies back OpenTelemetry:

Before OTel (problem for vendors too):
  Every company (Datadog, Dynatrace, etc.) had to:
  → Build and maintain SDKs for 10+ languages
  → Compete on SDK quality, not on analysis quality
  → Customers locked in forever = good for vendors short-term
  → But stunted innovation and adoption

With OTel (better for everyone):
  → One standard SDK maintained by CNCF community
  → Vendors compete on: query language, dashboards, alerts
  → Customers can switch easily → vendors must innovate
  → More companies adopt observability → bigger market for all

Reality today (2024):
  → OpenTelemetry is the #2 most active CNCF project (after Kubernetes)
  → All major observability vendors support OTLP natively
  → New projects default to OpenTelemetry
```

---

## 4. OpenTelemetry Architecture — Receiver, Processor, Exporter

### 🏗️ The OTel Pipeline

```
┌─────────────────────────────────────────────────────────────────────┐
│                OPENTELEMETRY COLLECTOR PIPELINE                      │
│                                                                      │
│  YOUR MICROSERVICE                                                   │
│  (instrumented with OTel SDK)                                       │
│  Emits: metrics + logs + traces                                     │
│         │                                                            │
│         │ OTLP (OpenTelemetry Protocol)                              │
│         │ gRPC (port 4317) or HTTP (port 4318)                      │
│         ▼                                                            │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │                OTel COLLECTOR                               │    │
│  │                                                             │    │
│  │  ┌─────────────┐   ┌──────────────┐   ┌───────────────┐  │    │
│  │  │  RECEIVER   │──▶│  PROCESSOR   │──▶│   EXPORTER    │  │    │
│  │  │             │   │              │   │               │  │    │
│  │  │ Accepts     │   │ Transforms:  │   │ Sends to:     │  │    │
│  │  │ telemetry   │   │ - Filter     │   │ - Jaeger      │  │    │
│  │  │ from apps   │   │ - Batch      │   │ - Prometheus  │  │    │
│  │  │             │   │ - Sample     │   │ - Elasticsearch│  │    │
│  │  │ Protocols:  │   │ - Enrich     │   │ - Datadog     │  │    │
│  │  │ OTLP/gRPC   │   │ - Redact PII │   │ - Loki        │  │    │
│  │  │ OTLP/HTTP   │   │              │   │ - ANY backend │  │    │
│  │  │ Jaeger      │   │              │   │               │  │    │
│  │  │ Zipkin      │   │              │   │               │  │    │
│  │  └─────────────┘   └──────────────┘   └───────────────┘  │    │
│  └────────────────────────────────────────────────────────────┘    │
│         │                    │                    │                 │
│         ▼                    ▼                    ▼                 │
│      Jaeger              Prometheus           Elasticsearch         │
│   (traces UI)          (metrics DB)          (logs/traces DB)      │
└─────────────────────────────────────────────────────────────────────┘
```

### 📦 Three Core OTel Collector Components Explained

#### 🔵 Receiver — "The Intake"
```yaml
# Receives telemetry data from your applications
# Supports multiple protocols simultaneously

receivers:
  otlp:                    # OpenTelemetry Protocol (most common)
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317    # gRPC port
      http:
        endpoint: 0.0.0.0:4318    # HTTP port

  jaeger:                  # Accept Jaeger-format traces
    protocols:
      thrift_http:
        endpoint: 0.0.0.0:14268

  prometheus:              # Scrape Prometheus-format metrics
    config:
      scrape_configs:
        - job_name: 'my-service'
          static_configs:
            - targets: ['my-service:8080']

  zipkin:                  # Accept Zipkin-format traces
    endpoint: 0.0.0.0:9411
```

#### 🟡 Processor — "The Transformer"
```yaml
# Processes, transforms, filters telemetry before exporting

processors:
  # Batch processor: collect spans and send in batches (efficiency)
  batch:
    timeout: 1s               # Send batch every 1 second
    send_batch_size: 1024     # Or when 1024 items collected

  # Memory limiter: prevent OOM
  memory_limiter:
    check_interval: 1s
    limit_mib: 512

  # Resource processor: add metadata to all telemetry
  resource:
    attributes:
      - key: deployment.environment
        value: production
        action: upsert
      - key: service.namespace
        value: ecommerce
        action: insert

  # Attributes processor: filter/transform span attributes
  attributes:
    actions:
      - key: user.email        # Remove PII before storing
        action: delete
      - key: http.url
        action: hash           # Hash sensitive URLs

  # Filter processor: drop unwanted telemetry
  filter:
    spans:
      exclude:
        match_type: regexp
        services:
          - "health-check.*"   # Don't trace health check endpoints
```

#### 🟢 Exporter — "The Forwarder"
```yaml
# Sends processed telemetry to backend systems
# THIS is where you define your observability backend

exporters:
  # Send traces to Jaeger
  jaeger:
    endpoint: jaeger-collector:14250
    tls:
      insecure: true

  # Send metrics to Prometheus (via remote write)
  prometheusremotewrite:
    endpoint: http://prometheus:9090/api/v1/write

  # Or expose a Prometheus scrape endpoint
  prometheus:
    endpoint: "0.0.0.0:8889"  # Prometheus scrapes this

  # Send to Elasticsearch (logs and traces)
  elasticsearch:
    endpoints: ["https://elasticsearch:9200"]
    index: otel-telemetry

  # Send traces to Datadog (vendor backend)
  datadog:
    api:
      key: ${DATADOG_API_KEY}

  # Debug: print to stdout
  logging:
    loglevel: debug

  # Send EVERYTHING to OTLP-compatible backends
  otlp:
    endpoint: otelcol:4317
    tls:
      insecure: true
```

### 📝 Complete OTel Collector Config Example

```yaml
# otel-collector-config.yaml
# ═══════════════════════════════════════════════════════════
# Full OpenTelemetry Collector configuration
# ═══════════════════════════════════════════════════════════

receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317
      http:
        endpoint: 0.0.0.0:4318

processors:
  batch:
    timeout: 1s
    send_batch_size: 1024
  memory_limiter:
    check_interval: 1s
    limit_mib: 512
  resource:
    attributes:
      - key: deployment.environment
        value: production
        action: upsert

exporters:
  # Traces → Jaeger
  jaeger:
    endpoint: jaeger-collector.tracing:14250
    tls:
      insecure: true

  # Metrics → Prometheus (expose scrape endpoint)
  prometheus:
    endpoint: "0.0.0.0:8889"

  # Logs → Elasticsearch
  elasticsearch:
    endpoints: ["https://elasticsearch-master.logging:9200"]
    user: elastic
    password: ${ELASTICSEARCH_PASSWORD}

  # Debug output
  logging:
    loglevel: warn

# ═══════════════════════════════════════════════════════════
# PIPELINES: wire receivers → processors → exporters
# ═══════════════════════════════════════════════════════════
service:
  pipelines:
    # Traces pipeline
    traces:
      receivers: [otlp]
      processors: [memory_limiter, batch, resource]
      exporters: [jaeger, logging]

    # Metrics pipeline
    metrics:
      receivers: [otlp]
      processors: [memory_limiter, batch]
      exporters: [prometheus, logging]

    # Logs pipeline
    logs:
      receivers: [otlp]
      processors: [memory_limiter, batch]
      exporters: [elasticsearch, logging]
```

> 💡 **The Power of Pipelines:** You can have traces go to Jaeger AND Datadog simultaneously. Metrics go to Prometheus AND CloudWatch. Logs go to Elasticsearch AND Splunk. Just add multiple exporters to a pipeline.

---

## 5. How OpenTelemetry Connects to Jaeger & Prometheus

### 🔄 Complete Data Flow

```
┌──────────────────────────────────────────────────────────────────────┐
│                     COMPLETE DATA FLOW                                │
│                                                                       │
│  ┌─────────────────────────────────────────────────────────────┐    │
│  │  MICROSERVICE (e.g., checkout-service in Go)                 │    │
│  │                                                              │    │
│  │  Uses OTel SDK:                                              │    │
│  │  tracer.Start("PlaceOrder")  → creates span                 │    │
│  │  meter.Add("orders", 1)      → increments counter           │    │
│  │  logger.Info("Order placed") → emits log                    │    │
│  └────────────────────┬─────────────────────────────────────────┘    │
│                       │ OTLP gRPC (port 4317)                        │
│                       ▼                                               │
│  ┌─────────────────────────────────────────────────────────────┐    │
│  │  OTel COLLECTOR                                              │    │
│  │  Receiver → Processor → Exporter                            │    │
│  └──────────┬──────────────────────┬────────────────────────────┘    │
│             │ traces               │ metrics                          │
│             ▼                      ▼                                  │
│  ┌──────────────────┐   ┌──────────────────────┐                    │
│  │   JAEGER         │   │   PROMETHEUS          │                    │
│  │                  │   │                       │                    │
│  │  Agent           │   │  Scrapes OTel         │                    │
│  │  ↓               │   │  Collector's          │                    │
│  │  Collector       │   │  :8889/metrics        │                    │
│  │  ↓               │   │  endpoint             │                    │
│  │  Elasticsearch   │   │  ↓                    │                    │
│  │  (stores spans)  │   │  TSDB                 │                    │
│  │  ↓               │   │  (stores metrics)     │                    │
│  │  Query UI        │   │  ↓                    │                    │
│  │  port: 16686     │   │  Grafana              │                    │
│  └──────────────────┘   │  port: 3000           │                    │
│                         └──────────────────────┘                    │
└──────────────────────────────────────────────────────────────────────┘
```

### 🔑 Key Difference: Push vs Pull

```
TRACES (Push Model):
  App → OTel Collector → Jaeger
  App PUSHES spans to collector
  No scraping needed
  Protocol: OTLP over gRPC/HTTP

METRICS (Pull Model):
  Prometheus SCRAPES OTel Collector's /metrics endpoint
  OTel Collector exposes metrics at port 8889
  Prometheus pulls on schedule (every 15s)
  Protocol: Prometheus text format

LOGS (Push Model):
  App → OTel Collector → Elasticsearch
  App PUSHES logs to collector
  Or Fluent Bit reads from filesystem and pushes
```

---

## 6. Deploying the Demo App on AWS EKS

### Prerequisites

```bash
# 1. EKS cluster running
eksctl get clusters
# NAME                   REGION
# observability-cluster  us-east-1

# 2. kubectl configured
kubectl get nodes
# NAME                          STATUS   ROLES    AGE
# ip-10-0-1-45.ec2.internal     Ready    <none>   2d

# 3. Helm installed
helm version
# version.BuildInfo{Version:"v3.12.0"...}
```

### Step 1: Add OpenTelemetry Demo Helm Chart

```bash
# Add the OTel Demo Helm repository
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update

# Verify the chart is available
helm search repo open-telemetry/opentelemetry-demo
# NAME                              CHART VERSION   APP VERSION
# open-telemetry/opentelemetry-demo  0.26.0          1.7.0
```

### Step 2: Install the Demo Application

```bash
# Simple installation (all defaults)
helm install my-otel-demo open-telemetry/opentelemetry-demo

# Or with custom namespace
helm install my-otel-demo open-telemetry/opentelemetry-demo \
  --namespace otel-demo \
  --create-namespace

# Watch all pods come up (may take 3-5 minutes)
kubectl get pods -w
```

### Step 3: Verify All Services are Running

```bash
kubectl get pods
# Expected output: ~20 pods, all Running

# NAME                                          READY   STATUS
# my-otel-demo-adservice-xxx                    1/1     Running
# my-otel-demo-cartservice-xxx                  1/1     Running
# my-otel-demo-checkoutservice-xxx              1/1     Running
# my-otel-demo-currencyservice-xxx              1/1     Running
# my-otel-demo-emailservice-xxx                 1/1     Running
# my-otel-demo-frontendservice-xxx              1/1     Running
# my-otel-demo-frontendproxy-xxx                1/1     Running
# my-otel-demo-loadgenerator-xxx                1/1     Running    ← Fake traffic
# my-otel-demo-paymentservice-xxx               1/1     Running
# my-otel-demo-productcatalogservice-xxx        1/1     Running
# my-otel-demo-recommendationservice-xxx        1/1     Running
# my-otel-demo-shippingservice-xxx              1/1     Running
# my-otel-demo-jaeger-xxx                       1/1     Running    ← Bundled!
# my-otel-demo-prometheus-xxx                   1/1     Running    ← Bundled!
# my-otel-demo-grafana-xxx                      1/1     Running    ← Bundled!
# my-otel-demo-otelcol-xxx                      1/1     Running    ← OTel Collector
```

### Step 4: Access the Application Frontend

```bash
# Port forward the frontend proxy
kubectl port-forward svc/my-otel-demo-frontendproxy 8080:8080

# Access at: http://localhost:8080

# If using EC2 instance — add address flag:
kubectl port-forward svc/my-otel-demo-frontendproxy 8080:8080 \
  --address 0.0.0.0

# Then access via: http://<ec2-public-ip>:8080
```

### Step 5: Access Observability Tools

```bash
# Access Jaeger UI
kubectl port-forward svc/my-otel-demo-jaeger-query 16686:16686
# URL: http://localhost:16686/ui

# Access Grafana
kubectl port-forward svc/my-otel-demo-grafana 3000:80
# URL: http://localhost:3000
# No login required (auth disabled in demo)

# Access Prometheus
kubectl port-forward svc/my-otel-demo-prometheus 9090:9090
# URL: http://localhost:9090
```

> 💡 **Note:** The Prometheus instance bundled with this demo does NOT have Node Exporter or Kube State Metrics installed. It only collects application-level metrics. For infrastructure metrics, install the full kube-prometheus-stack separately.

### Complete Port Forwarding Script

```bash
#!/bin/bash
# port-forward-all.sh — Open all observability tools at once

echo "Starting port forwards for OTel Demo..."

# Frontend Application
kubectl port-forward svc/my-otel-demo-frontendproxy 8080:8080 \
  --address 0.0.0.0 &
echo "✅ Frontend: http://localhost:8080"

# Jaeger UI
kubectl port-forward svc/my-otel-demo-jaeger-query 16686:16686 \
  --address 0.0.0.0 &
echo "✅ Jaeger:   http://localhost:16686/ui"

# Grafana
kubectl port-forward svc/my-otel-demo-grafana 3000:80 \
  --address 0.0.0.0 &
echo "✅ Grafana:  http://localhost:3000"

# Prometheus
kubectl port-forward svc/my-otel-demo-prometheus 9090:9090 \
  --address 0.0.0.0 &
echo "✅ Prometheus: http://localhost:9090"

echo "All services forwarded! Press Ctrl+C to stop."
wait
```

---

## 7. Exploring Traces in Jaeger UI

### 🖥️ Accessing Jaeger UI

```
URL: http://localhost:16686/ui

Note: The demo uses /ui path
      (standard Jaeger uses just http://localhost:16686)
```

### 📊 What You See — Services Panel

```
Jaeger UI → Service Dropdown:
  → adservice
  → cartservice
  → checkoutservice
  → currencyservice
  → emailservice
  → flagd                    ← Feature flag service
  → frontend
  → frontendproxy
  → loadgenerator
  → paymentservice
  → productcatalogservice
  → recommendationservice
  → shippingservice

17 services with live traces! (Load generator creates constant traffic)
```

### 🔍 Exploring the Cart Service Trace

```
1. Select Service: cartservice
2. Select Operation: all (or "GetCart")
3. Click "Find Traces"

Result: Multiple traces showing requests to cart service
```

**What a Trace Shows:**

```
Trace: frontend → frontendproxy → cartservice
Total Duration: ~2ms
Spans: 6

  frontend                    ██████████████████████████ 2ms
  ├── GET /cart                [0ms ──────────────────]  2ms
  │
  frontendproxy               ████████████████████  1.8ms
  ├── /hipstershop.CartService/GetCart  [0.1ms ──]  1.8ms
  │
  cartservice                 ████████████████  1.6ms
  ├── GetCart                  [0.2ms ──────────]  1.6ms
  │   ├── Tags:
  │   │   container_id: abc123
  │   │   cloud.region: us-east-1
  │   │   k8s.pod.name: my-otel-demo-cartservice-xxx
  │   │   k8s.namespace.name: default
  │   │   rpc.method: GetCart
  │   │   rpc.service: hipstershop.CartService
  │   │   rpc.system: grpc
```

### 🔍 Exploring the Checkout Service Trace (Multi-Service)

```
1. Select Service: checkoutservice
2. Click "Find Traces"

Result: Traces with 47+ spans (complex multi-service call chain)
```

**Checkout Service Call Chain:**

```
Complete Checkout Trace:
  frontend
  └── frontendproxy
      └── checkoutservice.PlaceOrder
          ├── cartservice.GetCart          ← Validate cart
          ├── productcatalogservice.GetProduct  ← Get product details
          ├── currencyservice.Convert      ← Convert prices
          ├── paymentservice.Charge        ← Process payment
          ├── emailservice.SendOrderConfirmation  ← Send email
          └── shippingservice.ShipOrder    ← Arrange shipping

Each service and each function call is a span!
Click any span → see exact duration, attributes, errors
```

### 📋 Span Detail View

```
Click on a span to expand:

Span: cartservice.GetCart
  Duration: 1.6ms
  Start Time: 2024-01-15T14:32:11.123Z

  Tags (Attributes):
  ─────────────────────────────────────────────────────
  container.id          │ abc123def456
  cloud.region          │ us-east-1
  k8s.pod.name          │ my-otel-demo-cartservice-abc
  k8s.namespace.name    │ default
  k8s.node.name         │ ip-10-0-1-45.ec2.internal
  rpc.method            │ GetCart
  rpc.service           │ hipstershop.CartService
  rpc.system            │ grpc
  otel.library.name     │ @opentelemetry/instrumentation-grpc

  Process:
  ─────────────────────────────────────────────────────
  service.name          │ cartservice
  service.version       │ 1.7.0
  deployment.environment│ production
  telemetry.sdk.name    │ opentelemetry
  telemetry.sdk.language│ dotnet
```

### 🗺️ System Architecture View

```
Jaeger UI → System Architecture tab

Shows a dependency graph (DAG):
  frontend ──→ frontendproxy
                    │
                    ├──→ cartservice
                    ├──→ checkoutservice ──→ cartservice
                    │                   ──→ productcatalogservice
                    │                   ──→ currencyservice
                    │                   ──→ paymentservice
                    │                   ──→ emailservice
                    │                   ──→ shippingservice
                    ├──→ productcatalogservice
                    ├──→ recommendationservice
                    └──→ adservice

This graph is AUTOMATICALLY generated from traces!
No manual documentation needed.
```

---

## 8. Exploring Metrics in Grafana

### 🖥️ Accessing Grafana

```
URL: http://localhost:3000
No username/password (auth disabled for demo)

Navigate to: Dashboards → Browse → Demo Dashboard
```

### 📊 Pre-Built Demo Dashboard

The demo comes with a Grafana dashboard showing:

```
Dashboard: OpenTelemetry Demo Dashboard

Panels:
  ┌────────────────────────┬───────────────────────────────┐
  │ Frontend Latency       │ Error Rate (5xx/total)         │
  │ (P50, P95, P99)        │ (percentage over time)         │
  ├────────────────────────┼───────────────────────────────┤
  │ Request Rate           │ Service Health Status          │
  │ (requests/sec)         │ (all services green/red)       │
  └────────────────────────┴───────────────────────────────┘
```

### 📝 Writing Custom PromQL Queries

**For application-specific metrics:**

```promql
# HTTP Server Duration Histogram (from OTel instrumented services)
http_server_duration_milliseconds_bucket

# Filter for specific service
http_server_duration_milliseconds_bucket{job="flagd"}

# P95 latency for flagd service (last 5 minutes)
histogram_quantile(0.95,
  rate(http_server_duration_milliseconds_bucket{job="flagd"}[5m])
)

# Recommendation counter (custom metric from Python service)
app_recommendations_counter_total

# Filter by time window (last 5 minutes)
rate(app_recommendations_counter_total[5m])

# Request rate per service
rate(http_server_duration_milliseconds_count[5m])

# Error rate (5xx status codes)
rate(http_server_duration_milliseconds_count{
  http_status_code=~"5.."
}[5m])
  /
rate(http_server_duration_milliseconds_count[5m])
```

### ⚠️ Why Infrastructure Metrics Are Missing

```bash
# If you run this in Prometheus, you get NO results:
kube_pod_info
node_cpu_seconds_total
kube_deployment_status_replicas

# Why? Because the bundled Prometheus has NO:
kubectl get pods | grep -E "node-exporter|kube-state"
# → No results!
```

**Solution to get infrastructure metrics:**

```bash
# Option 1: Install full kube-prometheus-stack separately
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace

# Option 2: Add exporters to existing Prometheus
# Add to Prometheus values.yaml:
kubeStateMetrics:
  enabled: true    # Installs kube-state-metrics
nodeExporter:
  enabled: true    # Installs node-exporter
```

### 🎨 Creating a Custom Dashboard

```
Grafana → + (New) → Dashboard → Add visualization

1. Select datasource: Prometheus
2. Enter PromQL:
   histogram_quantile(0.95,
     rate(http_server_duration_milliseconds_bucket[5m])
   )
3. Set visualization: Time series
4. Set title: "P95 HTTP Latency"
5. Save Dashboard → Name: "My Custom Observability Dashboard"
```

---

## 9. Understanding the Code — How Telemetry is Instrumented

### 🐍 Python — Recommendation Service Deep Dive

```python
# src/recommendationservice/recommendation_server.py

# ─────────────────────────────────────────────────────────────
# Step 1: Import OpenTelemetry modules
# ─────────────────────────────────────────────────────────────
from opentelemetry import trace, metrics
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.exporter.otlp.proto.grpc.metric_exporter import OTLPMetricExporter

# ─────────────────────────────────────────────────────────────
# Step 2: Initialize Tracer
# ─────────────────────────────────────────────────────────────
tracer_provider = TracerProvider(
    resource=Resource.create({
        SERVICE_NAME: "recommendationservice",
        SERVICE_VERSION: "1.7.0",
    })
)
otlp_exporter = OTLPSpanExporter(
    endpoint=os.environ.get("OTEL_EXPORTER_OTLP_ENDPOINT", "http://otelcol:4317")
)
tracer_provider.add_span_processor(BatchSpanProcessor(otlp_exporter))
trace.set_tracer_provider(tracer_provider)
tracer = trace.get_tracer("recommendationservice")

# ─────────────────────────────────────────────────────────────
# Step 3: Initialize Meter (for custom metrics)
# ─────────────────────────────────────────────────────────────
meter = metrics.get_meter("recommendationservice")

# Define a Counter metric (recommendations given over time)
recommendations_counter = meter.create_counter(
    name="app.recommendations.counter",
    description="Number of product recommendations made",
    unit="1"
)

# ─────────────────────────────────────────────────────────────
# Step 4: Instrument business logic with spans
# ─────────────────────────────────────────���───────────────────
def ListRecommendations(self, request, context):
    # Create a span for this function
    with tracer.start_as_current_span("ListRecommendations") as span:

        # Add business context as span attributes
        span.set_attribute("app.user.id", request.user_id)
        span.set_attribute("app.products_requested", len(request.product_ids))

        # Business logic here
        product_ids = self._get_product_recommendations(request.product_ids)

        # Record the metric
        recommendations_counter.add(
            len(product_ids),
            attributes={"user.id": request.user_id}
        )

        # Add result context to span
        span.set_attribute("app.products_recommended", len(product_ids))

        return demo_pb2.ListRecommendationsResponse(product_ids=product_ids)
```

### 🔵 Go — Checkout Service Deep Dive

```go
// src/checkoutservice/main.go

package main

import (
    "context"
    "go.opentelemetry.io/otel"
    "go.opentelemetry.io/otel/attribute"
    "go.opentelemetry.io/otel/metric"
    "go.opentelemetry.io/otel/trace"
    "go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc"
)

// ─────────────────────────────────────────────────────────────
// Initialize OTel (tracer + meter setup)
// ─────────────────────────────────────────────────────────────
var (
    tracer         = otel.Tracer("checkoutservice")
    meter          = otel.Meter("checkoutservice")
    orderCounter   metric.Int64Counter
)

func init() {
    var err error
    orderCounter, err = meter.Int64Counter(
        "app.orders.placed",
        metric.WithDescription("Total orders successfully placed"),
        metric.WithUnit("{order}"),
    )
    if err != nil {
        log.Fatalf("Failed to create counter: %v", err)
    }
}

// ─────────────────────────────────────────────────────────────
// Business logic with tracing
// ─────────────────────────────────────────────────────────────
func (cs *checkoutService) PlaceOrder(
    ctx context.Context,
    req *pb.PlaceOrderRequest) (*pb.PlaceOrderResponse, error) {

    // Start a span for the entire PlaceOrder operation
    ctx, span := tracer.Start(ctx, "PlaceOrder",
        trace.WithAttributes(
            attribute.String("app.user.id", req.UserId),
            attribute.String("app.user.currency", req.UserCurrency),
        ),
    )
    defer span.End()  // Always end the span!

    // Each sub-operation also gets its own span (child spans)
    cart, err := cs.getCart(ctx, req.UserId)  // calls cart service
    if err != nil {
        span.RecordError(err)  // Record error in span
        return nil, err
    }

    total, err := cs.prepareOrderItems(ctx, cart.GetItems(), req.UserCurrency)
    if err != nil {
        span.RecordError(err)
        return nil, err
    }

    // Process payment
    txID, err := cs.chargeCard(ctx, total, req.CreditCard)
    if err != nil {
        span.RecordError(err)
        return nil, err
    }

    // Record successful order metric
    orderCounter.Add(ctx, 1,
        metric.WithAttributes(
            attribute.String("app.payment.currency", req.UserCurrency),
        ),
    )

    span.SetAttributes(
        attribute.String("app.order.id", orderID.String()),
        attribute.Float64("app.order.amount", total.GetUnits()),
    )

    return resp, nil
}
```

### 🔑 Environment Variable Configuration (Vendor-Neutral!)

```yaml
# kubernetes deployment env vars for any microservice
# This is the KEY to vendor neutrality

env:
  # Where to send telemetry (change this to switch backends!)
  - name: OTEL_EXPORTER_OTLP_ENDPOINT
    value: "http://my-otel-demo-otelcol:4317"   # OTel Collector

  # Service identity (appears in Jaeger/Grafana)
  - name: OTEL_SERVICE_NAME
    value: "checkoutservice"

  # Sampling configuration
  - name: OTEL_TRACES_SAMPLER
    value: "parentbased_traceidratio"
  - name: OTEL_TRACES_SAMPLER_ARG
    value: "1"                                    # 100% sampling (demo only)

  # Resource attributes added to ALL telemetry
  - name: OTEL_RESOURCE_ATTRIBUTES
    value: "deployment.environment=production,service.version=1.7.0"
```

> 💡 **The Vendor-Neutral Magic:** To switch from Jaeger to Datadog, you only change `OTEL_EXPORTER_OTLP_ENDPOINT` to point to your Datadog agent. All 15+ services automatically start sending to Datadog. Zero code changes!

---

## 10. Resume & Interview Usage of This Project

### 📝 How to Add This to Your Resume

```
Project: End-to-End Observability Implementation
─────────────────────────────────────────────────────────────────
• Deployed OpenTelemetry Demo Application (15+ microservices in
  Go, Python, Java, Node.js, .NET, Rust) on AWS EKS cluster

• Implemented distributed tracing using Jaeger, visualizing
  request flows across 15 microservices with span-level
  latency analysis

• Configured Prometheus for application metrics scraping and
  created custom Grafana dashboards for real-time monitoring

• Analyzed OpenTelemetry instrumentation code across Python,
  Go, and Java services to understand trace/metric emission
  patterns using OTel SDK

• Identified performance bottlenecks by analyzing Jaeger traces
  showing P95 latency spikes in payment service gateway calls

Technologies: AWS EKS, Kubernetes, Helm, OpenTelemetry,
              Jaeger, Prometheus, Grafana, Docker
```

### 🎯 Interview Talking Points

```
"Tell me about an observability project you've worked on"

Good Answer:
"I implemented end-to-end observability on a multi-language
microservices application — similar to a production e-commerce
system with 15+ services in Go, Python, Java, and Node.js.

The application was instrumented using OpenTelemetry, which
gave us vendor-neutral telemetry. For tracing, I deployed
Jaeger on Kubernetes using Helm, backed by Elasticsearch on
EBS volumes. For metrics, I deployed Prometheus and created
Grafana dashboards.

One specific example: using Jaeger traces, I identified that
when a user checked out, the request was going through 47 spans
across 8 services. I was able to show the development team that
the currency conversion service was adding 200ms of unexpected
latency due to a missing cache. After the fix, checkout time
dropped from 850ms to 620ms."
```

---

## 11. Common Mistakes & Best Practices

### ❌ Common Mistakes

| Mistake | Problem | Fix |
|---------|---------|-----|
| Hardcoding OTel exporter endpoint | Can't change backend without rebuild | Use `OTEL_EXPORTER_OTLP_ENDPOINT` env var |
| Sampling at 100% in production | OTel collector overwhelmed, high storage cost | Use `OTEL_TRACES_SAMPLER_ARG: "0.1"` (10%) |
| Not ending spans (`span.End()`) | Memory leaks, incomplete traces | Always use `defer span.End()` in Go, `finally` in Java |
| Using vendor SDK instead of OTel | Vendor lock-in | Always use OpenTelemetry SDK |
| Not adding business attributes to spans | Traces useless for debugging business issues | Add `span.SetAttribute("order.id", orderId)` |
| Forgetting OTel Collector resource limits | Collector OOM kills entire telemetry pipeline | Set `memory_limiter` processor |
| Single OTel Collector instance | SPOF — one crash = no observability | Run 2+ replicas with HPA |
| No tail-based sampling | Dropping 99% of traces including errors | Use tail sampling to always keep error traces |
| Mixing vendor SDKs and OTel | Inconsistent telemetry, double instrumentation | Pick one: either vendor SDK OR OTel (prefer OTel) |
| Not verifying instrumentation before deploying observability stack | Can't tell if traces are missing because of code or infrastructure | Always verify `/metrics` endpoint exists and test OTel endpoint connectivity |

### ✅ Best Practices

```yaml
# 1. Use tail-based sampling in production
# Always keep traces with errors, sample healthy ones at 10%
processors:
  tail_sampling:
    decision_wait: 10s
    policies:
      - name: errors-policy
        type: status_code
        status_code: {status_codes: [ERROR]}
      - name: slow-traces-policy
        type: latency
        latency: {threshold_ms: 1000}
      - name: probabilistic-policy
        type: probabilistic
        probabilistic: {sampling_percentage: 10}
```

```python
# 2. Add correlation IDs to link traces with logs
import logging
from opentelemetry import trace

def process_order(order_id):
    span = trace.get_current_span()
    trace_id = format(span.get_span_context().trace_id, '032x')

    # Include trace_id in log so you can correlate log ↔ trace
    logging.info({
        "event": "order.processing",
        "order_id": order_id,
        "trace_id": trace_id,    # ← Link to Jaeger trace!
        "span_id": format(span.get_span_context().span_id, '016x')
    })
```

```bash
# 3. Validate OTel Collector is receiving spans
kubectl logs -l app=otelcol | grep -i "span\|trace\|error"

# 4. Check Jaeger has indices in Elasticsearch
kubectl exec -it elasticsearch-master-0 -n logging -- \
  curl -u elastic:$ES_PASSWORD \
  "http://localhost:9200/_cat/indices?v" | grep jaeger

# 5. Monitor OTel Collector health
kubectl port-forward svc/otelcol 8888:8888
# Prometheus metrics at http://localhost:8888/metrics
# otelcol_receiver_accepted_spans → spans received
# otelcol_exporter_sent_spans → spans exported
# otelcol_processor_dropped_spans → spans dropped (!)
```

### 🔧 Debugging Tips

```bash
# 1. No services in Jaeger UI?
# → Check if OTel Collector is receiving spans:
kubectl logs -l app.kubernetes.io/component=opentelemetry-collector | grep span

# 2. Specific service missing from Jaeger?
# → Check environment variables on that service pod:
kubectl describe pod <service-pod> | grep OTEL

# 3. Grafana shows no data for custom metrics?
# → Check if Prometheus can reach OTel Collector:
kubectl exec -it <prometheus-pod> -- \
  curl http://otelcol:8889/metrics | head -20

# 4. "Connection refused" from services to OTel Collector?
# → Verify OTel Collector service exists:
kubectl get svc | grep otelcol
# → Test from within a pod:
kubectl exec -it <any-pod> -- \
  curl http://my-otel-demo-otelcol:4318/v1/traces

# 5. Traces exist but missing spans from one service?
# → Service might be crashing before sending spans:
kubectl logs -l app=paymentservice | grep -i error

# 6. Helm install fails?
helm install my-otel-demo open-telemetry/opentelemetry-demo --debug
# Use --debug to see detailed error messages
```

---

## 12. Interview Prep — Key Points

### 🎯 Most Asked Questions & Answers

**Q: What is OpenTelemetry and why has it become the standard?**
> OpenTelemetry is a CNCF project that provides a **vendor-neutral, open-source SDK** for instrumenting metrics, logs, and traces in applications. It became the standard because previously, using Prometheus-specific or Jaeger-specific SDKs caused **vendor lock-in** — migrating to a new observability tool required modifying instrumentation code in every microservice. With OTel, developers instrument code once using standard APIs. To switch backends (e.g., Jaeger → Datadog), only the **exporter configuration** changes. Zero application code changes needed.

**Q: What are the three components of the OpenTelemetry Collector?**
> 1. **Receiver** — Accepts telemetry data from applications in various protocols (OTLP, Jaeger, Zipkin, Prometheus). 2. **Processor** — Transforms, filters, batches, and enriches telemetry (e.g., adding environment labels, redacting PII, sampling). 3. **Exporter** — Forwards processed telemetry to backend systems (Jaeger, Prometheus, Elasticsearch, Datadog). Multiple exporters can run simultaneously — send traces to Jaeger AND Datadog at the same time.

**Q: How does observability work when services are written in different languages?**
> OpenTelemetry provides SDKs for all major languages (Go, Python, Java, Node.js, .NET, Rust, etc.) with a **consistent API**. Each SDK has language-specific instrumentation libraries but follows the same OpenTelemetry specification. The OTel Collector acts as the language-agnostic middle layer — Go, Python, and Java services all send OTLP-format telemetry to the same collector, which forwards to the same Jaeger/Prometheus backends.

**Q: What is context propagation and how does it work?**
> Context propagation is the mechanism that **links spans across service boundaries**. When Service A makes an HTTP/gRPC call to Service B, the OTel SDK automatically injects a `traceparent` HTTP header containing the Trace ID and Span ID into the outgoing request. Service B reads this header and creates a **child span** with the same Trace ID. This links all spans from one user request together, creating the complete distributed trace visible in Jaeger.

**Q: Why would you use OpenTelemetry Collector instead of sending directly to Jaeger?**
> Using OTel Collector as an intermediary provides: (1) **Vendor flexibility** — change backends without touching application code; (2) **Processing capabilities** — batch, filter, sample, enrich before storing; (3) **Multiple destinations** — send same trace to Jaeger AND Datadog simultaneously; (4) **Security** — applications don't need direct network access to backends; (5) **Buffering** — collector handles backend unavailability gracefully.

**Q: What is the OpenTelemetry Demo Application and why is it useful for learning?**
> It's an official CNCF open-source e-commerce application with 15+ microservices in multiple languages, maintained by Datadog, Dynatrace, Microsoft, Grafana Labs, and others. It comes pre-instrumented with OpenTelemetry and bundles Jaeger, Prometheus, and Grafana. It's the best project for learning observability because it reflects real production complexity, provides professional-grade instrumentation examples in multiple languages, and can be deployed on any Kubernetes cluster with one Helm command.

---

## 📝 Quick Revision Summary

```
Day 7 Key Takeaways:

1. OpenTelemetry Demo App
   → Official CNCF project for learning observability
   → 15+ microservices in Go, Python, Java, Node.js, .NET, Rust
   → Maintained by Datadog, Dynatrace, Microsoft, Grafana Labs
   → Bundles Jaeger + Prometheus + Grafana + OTel Collector
   → Deploy with: helm install my-otel-demo open-telemetry/opentelemetry-demo

2. Observability = Instrumentation + Implementation
   → Instrumentation (Dev): Emit metrics/logs/traces using OTel SDK
   → Implementation (DevOps): Deploy Jaeger/Prometheus/Grafana on K8s
   → Both required — neither works without the other

3. Why OpenTelemetry?
   → Vendor lock-in problem: Prometheus SDK = hardcoded to Prometheus
   → OTel solution: Write once → export anywhere
   → Change backend by updating EXPORTER config only
   → CNCF standard — all major vendors support OTLP

4. OTel Collector Pipeline:
   → Receiver → Processor → Exporter
   → Receiver: accepts OTLP, Jaeger, Zipkin, Prometheus formats
   → Processor: batch, filter, sample, enrich, redact PII
   → Exporter: send to Jaeger, Prometheus, Datadog, Elasticsearch

5. Context Propagation:
   → traceparent header passed between services via HTTP/gRPC
   → Links all spans from one request under one Trace ID
   → Automatic with OTel SDK — no manual code needed

6. Viewing Traces in Jaeger:
   → Select service → Select operation → Find Traces
   → Trace = complete request journey (17 services!)
   → Span = one function/service hop with duration + attributes
   → System Architecture tab = auto-generated service dependency map

7. Viewing Metrics in Grafana:
   → Pre-built demo dashboard available
   → Custom dashboards with PromQL
   → Note: bundled Prometheus has NO node-exporter/kube-state-metrics
   → Install kube-prometheus-stack for infra metrics

8. Sampling Strategy for Production:
   → 100% in demo, 1-10% in production
   → Always keep error traces (tail-based sampling)
   → otelcol_processor_dropped_spans → monitor this!
```

---

> 📌 **Final Challenge — Series Capstone:** Deploy the OpenTelemetry Demo App on your EKS cluster. Then: (1) Open Jaeger and trace a complete checkout request — document every service it touches; (2) Create a custom Grafana dashboard showing P95 latency and error rate; (3) Find the recommendation service in GitHub, read the Python code, and explain in your own words how the `app.recommendations.counter` metric is created and exported. This exercise demonstrates ALL THREE pillars of observability and covers everything from Day 1 to Day 7 of this series.
