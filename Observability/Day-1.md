# Observability Zero to Hero — Day 1 (Fundamentals) — Updated / Modified Notes (From Your Transcript)

## What this file is
- This is an **updated + cleaned + study-friendly** Markdown version of the transcript you gave.
- I kept the **complete end-to-end coverage**, but **removed filler**, **fixed typos lightly**, and **restructured** into revision notes.
- If you want a *100% verbatim* version (line-by-line, same wording, same typos), tell me and I’ll output that format instead.

---

## 1) Series intro (Day 1 context)
- This is the **first episode** of the **Observability Zero to Hero** series.
- Day 1 focuses on **fundamentals** and is **very important** to watch till the end.

---

## 2) Course syllabus (7-day plan)
The series is a **7-day observability tutorial** (primarily on **Kubernetes**). Each day covers one concept:

### Day 1 — Fundamentals (this video)
Covers:
- What is observability?
- Why do you need observability?
- What are the **three pillars** of observability?
- How is observability different from monitoring?
- What tools will be covered in the series?

### Day 2 — Monitoring with Prometheus (theory + practical)
Covers:
- What is Prometheus?
- Prometheus architecture
- Install / setup / configure Prometheus on an **EKS cluster**
- Use Prometheus as a **data source in Grafana**
- Explore Grafana dashboards
> From Day 2 onwards: **Theory + Practical** in every episode.

### Day 3 — Prometheus advanced: PromQL
Covers:
- PromQL (Prometheus Query Language)
- Writing basic PromQL queries
- Writing advanced PromQL queries
- Scraping metrics
- What information you can get via PromQL

### Day 4 — Prometheus more advanced: custom metrics + alerting
Covers:
- Instrumenting **custom metrics**
- Using **Prometheus client library** (prom client library)
- Defining + scraping custom metrics
- Alertmanager
- Sending alerts to:
  - Slack
  - Email
  - Other targets

### Day 5 — Logging with EFK stack
Covers:
- Logging as a pillar of observability
- EFK stack (also mentions ELK vs EFK)
- Using **EFK**:
  - Elasticsearch
  - Fluent Bit
  - Kibana
- Log aggregation + log visualization

### Day 6 — Tracing + OpenTelemetry + Jaeger
Covers:
- What is tracing?
- What is distributed tracing?
- OpenTelemetry concepts:
  - a set of APIs + SDKs
  - helps instrument **traces, metrics, and logs**
- Playing with **Jaeger** (spelled “Jagger” in transcript)

### Day 7 — eBPF (beyond the three pillars)
Covers:
- What is eBPF?
- How eBPF is revolutionizing observability (last couple of years)
- Advantages of using eBPF in your observability stack

---

## 3) Where to get notes for each episode
- Notes are shared in the **GitHub repository** (“observability 0 to hero” repo).
- No need to download from elsewhere / Telegram.
- Notes are organized **day-wise** (Day 1 to Day 7 folders).
- Each day’s folder includes:
  - Theory explained in the episode
  - Architecture diagrams + images
  - Scripts used in the video
  - YAML manifests
- Purpose: after watching an episode, use the notes as **revision material**.

---

## 4) What is Observability? (definition + scope)

### Textbook definition (as explained)
If you have observability set up, you can get information about the **internal state of the system**.

### What “system” includes
- Your **application**
- The **infrastructure** required by your application
- The **networking**

### What observability enables you to understand
- State of the application:
  - Is it working as expected?
  - Are there failures?
- State of infrastructure
- State of networking:
  - latency
  - HTTP traffic
  - etc.

---

## 5) Examples of what observability can tell you
Observability can show metrics like:

### Infrastructure resource examples
- Disk utilization of a node in a Kubernetes cluster over last 24 hours
  - Helps detect: disk hitting 100%, consistently 90%, or underutilized (e.g., 20%).
- CPU utilization of a node
  - 100% CPU → system performance issues
  - 10% CPU always → overprovisioning → wasted resources/money
- Memory utilization
  - helps detect memory pressure and leaks

### Application request examples
- Out of 100 HTTP requests / API calls:
  - How many succeeded?
  - How many failed?

---

## 6) Observability answers: What, Why, and How
Observability is not only about telling you **what** is happening, but also:
- **What** is the state of the system?
- **Why** is the system in that state?
- **How** to fix it?

### HTTP failure example (What → Why → How)
- What:
  - e.g., last 30 minutes: 10 failed requests
  - last 24 hours: 100 failed requests
- Why:
  - find why those HTTP requests failed
  - identify which part of the app fails
- How:
  - get complete request traces:
    - client → load balancer → frontend → backend → database
  - pinpoint where exactly the request fails
  - then fix the issue

### Memory leak example
- Understand why extra memory is used
- Use traces to identify which part of the app uses memory extensively
- Fix based on findings

---

## 7) The three pillars of observability
Observability is built on three pillars:

1. **Metrics**
2. **Logs**
3. **Traces**

If you have metrics + logs + traces for your application, and the tooling to collect/analyze them, you have observability.

### Mapping pillars to What/Why/How (as stated)
- **Metrics** → helps understand **what** is the state of the system
- **Logs** → helps understand **why** the system is in that state
- **Traces** → helps understand **how** to fix it

---

## 8) Metrics (more detail)
### What metrics provide
- Metrics provide **historical data of events**.

### What is an “event” here?
Examples:
- CPU utilization
- Memory utilization
- Disk utilization
- HTTP requests / API calls

### Why historical data matters
- You can detect patterns like:
  - CPU is normal most of the day, but spikes at a particular time
- Without historical data:
  - you only know the current state
  - you cannot understand why the app went down at:
    - 10 a.m. today
    - or 10 a.m. 10 days ago

---

## 9) Logs (more detail)
### What logs help with
- Logs help you understand application behavior more deeply.

### Types of logs mentioned
- info logs
- debug logs
- error logs
- trace logging

### How logs are used with metrics
- Metrics show *when* something went wrong (timestamp correlation)
- Logs show *what* happened in the app at that time:
  - which request was sent
  - which package/module was hit
  - what caused CPU/memory to spike
  - e.g., the code path hit is leaking memory

---

## 10) Traces (more detail)
- Traces give extensive information to:
  - debug
  - troubleshoot
  - fix issues

### Request path example (distributed tracing)
- client → load balancer → frontend → backend → database
- For each hop, traces can show:
  - did it reach the component?
  - which backend instance did it go to?
  - how much time did each hop take (e.g., 5 ms)
  - is latency expected or abnormal?

---

## 11) Monitoring vs Observability
### Key distinction from transcript
- Observability has 3 pillars:
  - metrics, logs, traces
- Monitoring focuses mainly on **one pillar: metrics**
  - plus **alerts**
  - plus **dashboards**

So:
- **Monitoring** = metrics + alerts + dashboards (e.g., Grafana)
- **Observability** = monitoring + logs + traces (full system feedback)
- Monitoring is a **subset** of observability.

### Example monitoring behaviors
- Track metrics historical data
- Trigger alerts:
  - e.g., CPU reaches 80% → alert via Slack/email/other
- Visualize dashboards in Grafana

---

## 12) Practical real-world example (why companies spend on observability)

### Scenario described
- You work in a startup (product company).
- The product is a **Resume Builder** application.
- Deployed on:
  - Kubernetes cluster
  - AWS infrastructure
  - proper networking in a VPC

### Business need: customers + trust
Customers ask: “Why should we use your product vs others?”

### SLA / SLO commitments (as described)
The company signs agreements and promises objectives like:
- **99.9% availability**
  - only 0.1% chance of downtime (throughout the year)
- Out of **10,000 requests**:
  - at least **9,995** respond in **30 milliseconds**
  - with **HTTP 200**

### Why observability is required here
- After signing SLAs with multiple customers, you must ensure:
  - objectives are met continuously
- You need a **continuous feedback system**:
  - if even 1–3 requests are failing, you must act early
  - because your error budget might be only 5 requests
- Observability provides internal state + feedback:
  - What’s happening?
  - Why is it happening?
  - How to fix before breach occurs?

### Broader point
- Strong SRE-focused companies first implement observability.
- Modern applications need observability:
  - Instagram / Facebook
  - banking applications (even small failure counts matter)
- Example:
  - if request latency crosses 5 seconds and is trending to 10/20 seconds
  - system should alert developers immediately to prevent escalation

---

## 13) Developers vs DevOps vs SRE: who owns observability?
### Core point
Observability is a **collective effort**.

### Why it must be collective
There are two primary parts:

#### A) Developers instrument inside the application
Developers must implement:
- metrics (application exposes/throws metrics)
- logs (info/debug/error/etc.)
- traces (instrument request flows)

If developers do not instrument these, platforms/tools can’t magically produce them.

#### B) DevOps/SRE deploy and operate the observability platform
Even if developers instrument everything, it’s useless if the stack isn’t deployed/configured.

DevOps/SRE responsibilities include:
- setting up monitoring stack (metrics + alerts + dashboards)
- setting up logging stack (e.g., ELK/EFK)
- setting up distributed tracing stack (e.g., Jaeger)
- making the platform usable for:
  - management
  - QA
  - developers
  - other teams

### Tools/platforms mentioned in this context
- Prometheus (metrics)
- ELK/EFK (logs)
- Jaeger (tracing)
- OpenTelemetry:
  - CNCF project
  - a collection of APIs and SDKs
  - helps instrument metrics/traces/logs
- Prometheus client library (for scraping/instrumenting metrics for Prometheus)

### Series perspective
- Focus is from DevOps and SRE point of view:
  - install, setup, configure stacks on Kubernetes
- Also covers some developer angle:
  - using OpenTelemetry for instrumentation
  - using Prometheus client for metrics instrumentation

---

## 14) Closing message (from transcript)
- The speaker hopes the video was informative.
- Asks viewers to comment if useful and if excited for the series.
- Next episodes will be **theory + practical**.
- “see you all in the next one take care bye-bye”

---

## Quick Revision Summary (1-page)
- **Observability**: understand internal state of app + infra + networking.
- Answers: **What, Why, How**.
- **3 pillars**: Metrics, Logs, Traces.
- **Monitoring**: subset of observability → metrics + alerts + dashboards.
- **Why it matters**: meet SLAs/SLOs, fast incident response, prevent breaches.
- **Ownership**: collective:
  - developers instrument (metrics/logs/traces)
  - DevOps
