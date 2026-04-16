# Observability Zero to Hero — Day 4 (Episode 4): Custom Metrics Instrumentation + ServiceMonitor + Alertmanager — End-to-End Notes (Deep)

## 1) Episode focus (what Day 4 adds)
By now you have covered:
- Day 1: observability fundamentals
- Day 2: metrics + monitoring + Prometheus stack installation
- Day 3: Prometheus scraping in practice + PromQL + Grafana usage

**Day 4 focuses on:**
1. **Instrumentation of custom metrics**
   - what instrumentation means
   - why it is critical
2. Practical demo:
   - instrument metrics in a **Node.js application**
   - expose metrics for Prometheus to scrape
3. **Alertmanager configuration**
   - configure alert rules and receivers
   - fire real-time alerts (demo uses email/Gmail)

Notes and source code are available in the GitHub repo:
- Day 4 folder contains:
  - app source code used in the video
  - README with steps
  - architecture diagrams

---

## 2) Instrumentation (definition + why it’s important)

### 2.1 Observability is collective responsibility (key message repeated)
Even if DevOps/SRE set up a complete stack:
- Prometheus (monitoring)
- Grafana (dashboards)
- EFK (log aggregation)
- Jaeger (distributed tracing)

…the stack is useless if the **applications do not emit**:
- metrics
- logs
- traces

### 2.2 What is instrumentation?
**Instrumentation** = the process of adding code/config to your application so it:
- exposes **metrics**
- writes **logs**
- emits **traces**

If developers do not instrument the app:
- Prometheus / Nagios / etc. cannot magically get app-specific metrics
- logging/tracing platforms cannot show meaningful app insights

### 2.3 Why exporters are not enough
Exporters (plugins) are good for generic targets:
- node-exporter → CPU/memory/disk for nodes
- MySQL exporter → DB metrics

But exporters cannot fully capture **application-specific** questions like:
- how many users logged in over last 30 days
- how many users created accounts over last 30 days
- latency/HTTP duration for a specific endpoint/service
- debug-mode metrics or internal business events

So, for custom metrics:
- **app must expose the metrics** (instrumentation is required)

### 2.4 Who does instrumentation in real orgs?
Depends on organization:
- developers
- platform engineers
- SRE
- DevOps
But the main point:
- someone must instrument the app
- DevOps/SRE then operationalize it (Prometheus, dashboards, alerts)

---

## 3) Metric “data types” in Prometheus (4 core metric types)

Just like programming languages have data types (string/list/dict):
Prometheus metrics have **types**, because not all metrics behave the same.

### 3.1 Counter
Use when the value:
- **only increases** (never decreases)

Examples:
- number of logins
- number of accounts created
- total HTTP requests received

Reason:
- once an event happens, the total count increases
- it does not go down (for that metric’s purpose)

### 3.2 Gauge
Use when the value:
- can **increase and decrease**

Examples:
- CPU utilization
- memory utilization
- disk usage
- number of configmaps (as described)

Reason:
- value goes up and down over time

### 3.3 Histogram
Use when you need:
- **buckets** (distribution)

Best example used:
- **HTTP request duration / latency**

Why buckets are needed:
- questions like:
  - “how many requests took < 5ms?”
  - “how many requests took > 100ms?”
- cannot be answered well by counter/gauge alone

Histogram approach:
- define buckets (example shown):
  - 0.5 seconds
  - 1 second
  - 5 seconds
  - 10 seconds
- each request duration falls into a bucket
- you can report bucket counts to answer distribution questions

### 3.4 Summary
- Similar intent to histogram (distribution/latency style)
- Not explained deeply in this episode (to avoid confusing beginners)
- Mentioned: will be covered later and in documentation

### 3.5 Practical note
Beginners confusion is normal:
- choosing between counter/gauge/histogram/summary takes practice
- just like choosing list vs dictionary when new to programming

---

## 4) Practical demo application (Node.js) — what was shown

### 4.1 Where the app is
- GitHub repo → Day 4 folder → application section
- Two microservices:
  - **service A** talks to **service B**
- Focus is not on business logic; focus is on **metrics instrumentation**

### 4.2 How metrics are instrumented in the Node.js app
In `index.js` (service A):
- uses **Prometheus client** library (prom-client)
  - (Alternative mentioned: OpenTelemetry for vendor-neutral instrumentation; covered later)

Developers define:
- **metric type**
- **metric name**
- **help/description**
- **labels** (so Prometheus queries can filter by label values)

#### Example 1: Counter for HTTP requests
- Metric type: **Counter**
- Metric name example mentioned:
  - `http_requests_total`
Why counter:
- requests only increment; cannot decrease

#### Example 2: Histogram for HTTP request duration
- Metric type: **Histogram**
- Metric name example mentioned:
  - `http_request_duration_seconds`
Why histogram:
- duration/latency needs bucket distribution

Buckets example shown in transcript:
- 0.5s, 1s, 5s, 10s (and similar)
This enables queries like:
- “count of requests <= bucket X”

---

## 5) Prometheus stack setup (repeat from Day 2, used here again)
Before scraping custom metrics:
- Prometheus stack must be installed:
  - Prometheus
  - Grafana
  - Alertmanager

Video flow:
- cluster exists already
- installs Prometheus stack via Helm
- if chart already exists, uninstall then reinstall

Where to get commands:
- Day 2 folder includes:
  - Helm install steps
  - port-forward commands to access Prometheus UI

---

## 6) Deploy the Node.js application to Kubernetes

### 6.1 Manifests + Kustomize
- Day 4 folder includes Kubernetes manifests:
  - deployments
  - services
- Apply using **Kustomize** (`kubectl apply -k .`)

### 6.2 Namespace
- Create namespace: `dev`
- Deploy app into `dev` namespace

### 6.3 Services and access
- service A exposed as **LoadBalancer**
  - to access from outside (browser)
- service B remains internal (service-to-service)
- LoadBalancer needs time to come up

### 6.4 App endpoints shown (example)
- health endpoint shows app running
- supports multiple APIs such as:
  - `/healthy`
  - `/server-error`
  - `/not-found`
  - `/logs` (generates a simple log)
- Important endpoint for metrics:
  - `/metrics` (this is where app exposes metrics)

---

## 7) Critical concept: Instrumentation alone is not enough (Prometheus must discover it)

### 7.1 The problem demonstrated
Even after:
- instrumenting metrics in the app
- deploying app
- installing Prometheus

Querying `http_requests_total` in Prometheus returned nothing.

### 7.2 Why it returned nothing
Because Prometheus does not automatically know which of many applications to scrape.

In a cluster with many apps:
- Prometheus needs to know:
  - which services expose `/metrics`
  - which ones should be scraped

This is **service discovery** for custom app metrics.

### 7.3 Proof that app is exposing metrics
If you visit:
- `http://<service-a>/metrics`
You can see:
- metrics emitted in Prometheus format

But Prometheus still won’t scrape unless configured.

---

## 8) ServiceMonitor (key Kubernetes concept for Prometheus Operator setups)

### 8.1 What ServiceMonitor does
A **ServiceMonitor** (custom resource / YAML) tells Prometheus:
- which service(s) to target
- which endpoint to scrape (e.g., `/metrics`)
- in which namespace

### 8.2 What was configured in the demo
ServiceMonitor configuration (conceptually):
- namespace: `dev`
- match service: `service-a`
- scrape path: `/metrics`

After applying ServiceMonitor:
- Prometheus starts scraping app metrics automatically.

### 8.3 Result after ServiceMonitor
Re-run PromQL query:
- `http_requests_total`
Now metrics appear and graph shows data.

### 8.4 End-to-end steps for custom metrics in an org (interview-ready)
1. **Instrument** the application (code emits metrics at `/metrics`)
2. **Deploy monitoring stack** (Prometheus/Grafana/Alertmanager)
3. **Configure service discovery** (ServiceMonitor/targets) so Prometheus scrapes the app

Only after all 3 are done:
- custom metrics are fully visible and usable.

---

## 9) Alertmanager configuration (send alerts in real time)

### 9.1 What you need for alerting
To fire alerts:
- create Alertmanager configuration
- define:
  - alert rules (what to alert on)
  - receivers (where to send alerts)

The demo config includes alerts for:
- high CPU usage
- pod restarts / container crashes

Demo plan:
- intentionally crash the app
- verify alert is fired
- send alert to email

### 9.2 Email alert receiver setup (Gmail example)
To send email alerts:
- receiver type: email (“send mail”)
- requires:
  - email address
  - SMTP credentials

Gmail-specific steps shown:
1. Open Google account → Manage Google account
2. Search **App passwords**
3. If app passwords not visible:
   - enable **2-factor authentication**
4. Create an app password (named “alert manager”)
5. Use the generated password in Alertmanager configuration

### 9.3 Kubernetes secret for email password
- Alertmanager needs password stored securely.
- Steps shown:
  - take Gmail app password
  - convert to **base64**
  - update `email-secrets.yaml` with base64 value
- Apply the updated manifests using Kustomize:
  - `kubectl apply -k .`

### 9.4 Update Alertmanager config with email address
- In Alertmanager config YAML:
  - put your email ID in the required fields
- Apply changes with Kustomize (same as above)

---

## 10) Triggering an alert (real-time demo)

### 10.1 Crash endpoint
The app includes an endpoint:
- `/crash`
Calling it causes the application/pod to crash.

### 10.2 Verify pod restarts
- `kubectl get pods -n dev`
- Observe pod restart count increasing.

### 10.3 Alert firing outcome
- Alertmanager sends a notification email immediately.
- In the demo:
  - email notification seen on mobile (Gmail configured on phone)
- Alert content:
  - indicates pod restart / crash alert

### 10.4 Key takeaway
Alertmanager can notify you (email/Slack/etc.) when:
- pod crashes
- CPU high
- and any other alert rule you configure

---

## 11) End-to-end chain you should memorize (Day 4 summary)

### Custom metrics end-to-end flow
1. Developer instruments metrics in code (counter/gauge/histogram/summary)
2. App exposes metrics at `/metrics` in Prometheus format
3. App is deployed to Kubernetes
4. Prometheus stack installed (Prometheus + Alertmanager + Grafana)
5. ServiceMonitor tells Prometheus which service endpoints to scrape
6. Prometheus scrapes metrics → stores in TSDB
7. PromQL queries retrieve those metrics
8. Grafana dashboards visualize them
9. Alert rules evaluate metrics
10. Alertmanager sends notifications to configured receivers (email shown)

---

## 12) What to revise from Day 4 (quick checklist)
- Meaning of **instrumentation** and why it’s necessary
- Why exporters can’t cover application-specific metrics
- 4 metric types:
  - Counter (only up)
  - Gauge (up/down)
  - Histogram (buckets/distribution)
  - Summary (similar idea; deeper later)
- `/metrics` endpoint concept
- Why Prometheus didn’t show app metrics until ServiceMonitor was applied
- ServiceMonitor purpose and fields (namespace, service match, endpoint path)
- Alertmanager configuration flow:
  - define rules + receiver
  - email receiver via Gmail app password
  - base64 secret + apply manifests
  - trigger crash endpoint and verify alert

---
