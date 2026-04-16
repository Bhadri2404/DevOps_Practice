# 📘 Observability Zero to Hero — Episode 5: Logging & EFK Stack

> **Series Recap:** Day 1 = Observability Fundamentals | Day 2 = Metrics & Monitoring | Day 3 = Prometheus + PromQL + Grafana | Day 4 = Custom Metrics + AlertManager | **Day 5 = Logging + EFK Stack**

---

## 📌 Table of Contents
1. [What is Logging & Why It Matters](#1-what-is-logging--why-it-matters)
2. [Logs as the Second Pillar of Observability](#2-logs-as-the-second-pillar-of-observability)
3. [The Problem — Why Centralized Logging?](#3-the-problem--why-centralized-logging)
4. [EFK Stack — Architecture & Components](#4-efk-stack--architecture--components)
5. [EFK vs ELK — Fluent Bit vs Logstash](#5-efk-vs-elk--fluent-bit-vs-logstash)
6. [AWS EKS Setup — IAM Role, CSI Driver & EBS](#6-aws-eks-setup--iam-role-csi-driver--ebs)
7. [Installing Elasticsearch on Kubernetes](#7-installing-elasticsearch-on-kubernetes)
8. [Installing Kibana on Kubernetes](#8-installing-kibana-on-kubernetes)
9. [Fluent Bit — Configuration Deep Dive](#9-fluent-bit--configuration-deep-dive)
10. [Installing Fluent Bit & Connecting to Elasticsearch](#10-installing-fluent-bit--connecting-to-elasticsearch)
11. [Deploying a Test Application & Verifying Log Flow](#11-deploying-a-test-application--verifying-log-flow)
12. [Kibana — Creating Data Views & Querying Logs](#12-kibana--creating-data-views--querying-logs)
13. [Common Mistakes & Best Practices](#13-common-mistakes--best-practices)
14. [Interview Prep — Key Points](#14-interview-prep--key-points)

---

## 1. What is Logging & Why It Matters

### 🧠 Simple Definition

**Logs are messages written by developers inside an application** to communicate:
- **What the application is doing** at each step
- **Why something failed** when it doesn't behave as expected
- **Contextual information** to help debug issues faster

> Think of logs as the application **talking to you** — narrating its own story as it runs.

### 📖 Simple Example — Addition Program Without vs With Logs

**Without Logging (Bad):**
```python
# No logs — user has no idea what's happening
a = input()       # What is this? A string? A number?
b = input()       # Why is it asking again?
c = int(a) + int(b)
print(c)          # What does this output mean?
```

**With Logging (Good):**
```python
import logging
logging.basicConfig(level=logging.INFO)

logging.info("Starting addition program")
logging.info("Please enter the first number:")
a = input()

logging.info("Please enter the second number:")
b = input()

logging.info("Reading inputs and performing addition...")
c = int(a) + int(b)

logging.info(f"Addition complete. Result: {c}")
print(c)
```

**Output with Logging:**
```
INFO: Starting addition program
INFO: Please enter the first number:
→ 5
INFO: Please enter the second number:
→ 3
INFO: Reading inputs and performing addition...
INFO: Addition complete. Result: 8
```

> ✅ Now the user knows exactly what to do, what's happening, and can debug if something fails.

### 🐚 Shell Script — Without vs With Logging

**Without Logs:**
```bash
#!/bin/bash
a=$1
b=$2
echo $((a + b))
```

**With Logs:**
```bash
#!/bin/bash
echo "[INFO] Starting addition process..."
echo "[INFO] First number received: $1"
echo "[INFO] Second number received: $2"

a=$1
b=$2
result=$((a + b))

echo "[INFO] Addition process complete."
echo "[INFO] Result: $result"
```

**Output:**
```
[INFO] Starting addition process...
[INFO] First number received: 5
[INFO] Second number received: 3
[INFO] Addition process complete.
[INFO] Result: 8
```

### 🏭 Real-World Importance — 10,000 Line Application

```
Scenario: Your payment service (10,000 lines of code) goes down at 2 AM.

Without logs:
  → You have NO idea where it failed
  → Did it fail at line 3,000? Line 7,500?
  → Was it a null pointer? A timeout? A connection error?
  → MTTR (Mean Time To Recover) = hours

With logs:
  → Logs show: "ERROR [line 6,243] Database connection timed out"
  → Logs show: "ERROR Payment processor unreachable at 02:14:33"
  → MTTR = minutes
```

### 📊 Log Levels — What They Mean

```
Log Levels (ordered by severity):

DEBUG   → Very detailed info for developers during development
          "Entering function calculateTax() with params: {amount: 100}"

INFO    → Normal application events, key milestones
          "User login successful: user_id=12345"

WARN    → Something unexpected but recoverable happened
          "Database response slow: 2.3s (threshold: 1s)"

ERROR   → Something failed but application continues
          "Failed to send email to user@example.com, retrying..."

FATAL   → Critical failure, application cannot continue
          "Cannot connect to database. Shutting down."
```

```python
# Python logging example with different levels
import logging

logger = logging.getLogger(__name__)

logger.debug("DB query params: %s", query_params)       # Dev only
logger.info("Order %s placed successfully", order_id)   # Normal flow
logger.warning("Retry attempt %d for payment", retry)  # Recoverable
logger.error("Payment failed: %s", error_message)      # Failure
logger.critical("DB unreachable. Service shutting down") # Fatal
```

---

## 2. Logs as the Second Pillar of Observability

### 🏛️ The Three Pillars — Revisited

```
┌─────────────────────────────────────────────────────────────────┐
│              THREE PILLARS OF OBSERVABILITY                      │
│                                                                   │
│  METRICS              LOGS                TRACES                 │
│  ────────             ────────            ────────               │
│  WHAT is happening?   WHY is it failing?  HOW to fix it?         │
│                                                                   │
│  "CPU at 90%"         "DB connection      "Request went:         │
│  "500 errors/min"      timed out in        API → Auth →          │
│  "Pod restarted 5x"    payment service"    DB → Timeout"         │
│                                                                   │
│  Prometheus/          EFK Stack /          Jaeger / Zipkin /     │
│  CloudWatch           Loki / ELK           AWS X-Ray             │
└─────────────────────────────────────────────────────────────────┘
```

> 💡 **The Detective Analogy:**
> - **Metrics** = The alarm going off (tells you SOMETHING is wrong)
> - **Logs** = The crime scene evidence (tells you WHY it went wrong)
> - **Traces** = The investigation map (tells you HOW to find and fix the root cause)

### 🌍 Real-World AWS Example

```
Production Scenario (E-commerce on EKS):

Step 1 — Metrics alert fires:
  → Grafana shows: HTTP 500 error rate jumped to 15% at 3:47 PM
  → Alert: "High error rate on /checkout endpoint"

Step 2 — You check Logs (EFK Stack):
  → Search Kibana for: namespace="production" AND service="checkout"
  → Find: "ERROR: Payment gateway connection refused: timeout after 30s"
  → 47 occurrences between 3:47 PM and 3:52 PM

Step 3 — Root cause found:
  → Payment gateway API key expired at 3:47 PM
  → Fix: Rotate API key → Deploy → Error rate drops to 0%

Without Logs: You would know there's a problem (metrics) but not WHY.
With Logs: Identified and fixed in 8 minutes.
```

---

## 3. The Problem — Why Centralized Logging?

### 🔍 The Challenge in Kubernetes

In a modern Kubernetes environment, you might have:

```
Your EKS Cluster:
  ├── namespace: production
  │   ├── payment-service     (3 pods)
  │   ├── order-service       (5 pods)
  │   └── user-service        (2 pods)
  │
  ├── namespace: staging
  │   ├── payment-service     (1 pod)
  │   └── order-service       (1 pod)
  │
  └── namespace: monitoring
      ├── prometheus          (1 pod)
      └── grafana             (1 pod)

Total: 100+ pods across multiple namespaces
```

### ❌ Without Centralized Logging — The Manual Nightmare

```bash
# To find DB connection issues, you'd have to:
kubectl logs payment-service-pod-1 -n production | grep "connection"
kubectl logs payment-service-pod-2 -n production | grep "connection"
kubectl logs payment-service-pod-3 -n production | grep "connection"
kubectl logs order-service-pod-1 -n production | grep "connection"
# ... repeat for ALL 100+ pods
# ... manually! Takes HOURS.
```

**Problems with this approach:**
- ⏱️ Time-consuming — searching through 100 pods manually
- 💾 Logs lost when pod restarts — Kubernetes doesn't persist pod logs by default
- 🔍 No search across services — can't find patterns spanning multiple microservices
- 📊 No visualization — raw `kubectl logs` output is hard to analyze
- 🔒 Compliance risk — no log retention for auditing

### ✅ With Centralized Logging (EFK Stack)

```
One query in Kibana:
  Search: "connection timed out" AND namespace="production"

Result in seconds:
  Found in: payment-service (47 occurrences)
  Found in: order-service   (12 occurrences)
  Found in: user-service    (3 occurrences)

→ Team immediately knows which 3 services have the DB issue
→ Response time: 30 seconds instead of 3 hours
```

### 🛡️ Additional Benefits of Centralized Logging

| Benefit | Description |
|---------|-------------|
| **Log Retention** | Store logs for 30/60/90 days for compliance |
| **Security Auditing** | Track who accessed what and when |
| **Incident Response** | Quickly find root cause across services |
| **Vulnerability Detection** | Search for Log4J patterns across all services instantly |
| **Business Intelligence** | Analyze user behavior from access logs |
| **Alerting on Logs** | Alert when specific error patterns appear |

---

## 4. EFK Stack — Architecture & Components

### 🧠 What is EFK Stack?

```
E = Elasticsearch   → Database (stores logs)
F = Fluent Bit      → Log collector/forwarder (reads & ships logs)
K = Kibana          → Visualization dashboard (query & display logs)
```

### 🏗️ EFK Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                    KUBERNETES CLUSTER (EKS)                          │
│                                                                      │
│  ┌──────────────────────────────────────────────────────────┐       │
│  │                    APPLICATION PODS                       │       │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐         │       │
│  │  │  service-a  │  │  service-b  │  │  service-c  │         │       │
│  │  │   logs ↓    │  │   logs ↓    │  │   logs ↓    │         │       │
│  │  └────────────┘  └────────────┘  └────────────┘         │       │
│  └─────────────────────┬────────────────────────────────────┘       │
│                        │ logs written to /var/log/containers/        │
│                        ▼                                             │
│  ┌──────────────────────────────────────────────────────────┐       │
│  │              FLUENT BIT (DaemonSet)                       │       │
│  │  Node 1: fluent-bit-pod-1  →  Reads logs from Node 1     │       │
│  │  Node 2: fluent-bit-pod-2  →  Reads logs from Node 2     │       │
│  │  Node 3: fluent-bit-pod-3  →  Reads logs from Node 3     │       │
│  └─────────────────────┬────────────────────────────────────┘       │
│                        │ forwards logs (port 9200)                   │
│                        ▼                                             │
│  ┌──────────────────────────────────────────────────────────┐       │
│  │           ELASTICSEARCH (StatefulSet)                     │       │
│  │                                                           │       │
│  │   Stores & indexes all logs                               │       │
│  │   Mounted on EBS Volume (persistent storage)             │       │
│  │   Supports full-text search & complex queries            │       │
│  └─────────────────────┬────────────────────────────────────┘       │
│           ↑             │                                            │
│    EBS Volume           │ queries (KQL)                              │
│    (Persistent)         ▼                                            │
│                ┌────────────────────┐                               │
│                │      KIBANA         │ ◀── DevOps/SRE/Developers    │
│                │  (Visualization)    │     search & analyze logs     │
│                └────────────────────┘                               │
└─────────────────────────────────────────────────────────────────────┘
```

### 📦 Component Responsibilities

#### 🔵 Fluent Bit (Log Collector)

```
Role:     Collect logs from every Kubernetes node and forward to Elasticsearch
Type:     DaemonSet (runs one pod per node)
Why DaemonSet: Each node has its own container logs at /var/log/containers/
              Must run ON the node to read local filesystem logs

Analogy:  Like a postal worker who goes door-to-door (node-to-node),
          picks up all mail (logs), and delivers them to the post office (Elasticsearch)
```

#### 🟡 Elasticsearch (Log Database)

```
Role:     Store, index, and search all log data
Type:     StatefulSet (needs stable storage)
Storage:  Mounted on AWS EBS volumes for persistence
Port:     9200 (HTTP API)

Analogy:  Like a massive, searchable filing cabinet where every log
          is stored with its timestamp, namespace, pod name, and content.
          You can search ANY field instantly.
```

#### 🟢 Kibana (Log Visualization Dashboard)

```
Role:     Web UI for querying and visualizing logs from Elasticsearch
Type:     Deployment
Port:     5601
Auth:     Uses Elasticsearch credentials

Analogy:  Like Google Search — but for your logs.
          Instead of raw curl commands to Elasticsearch,
          you get a beautiful UI with filters, charts, and saved queries.
```

### 🔄 Log Flow — Step by Step

```
1. Your application (service-a) writes a log:
   → "ERROR: Payment failed for order_id=789"

2. Kubernetes writes this to node filesystem:
   → /var/log/containers/service-a-xxx_dev_service-a-xxx.log

3. Fluent Bit (running on that node) reads the file:
   → Picks up the new log entry
   → Enriches it with: namespace, pod_name, node_name, timestamp

4. Fluent Bit applies filters:
   → Skip logs from 'logging' namespace (Elasticsearch/Kibana own logs)
   → Keep logs from 'dev', 'production', 'staging'

5. Fluent Bit forwards to Elasticsearch:
   → POST http://elasticsearch:9200/fluent-bit/_doc
   → Authentication: username/password

6. Elasticsearch indexes the log:
   → Stores in time-based index (e.g., fluent-bit-2024.01.15)
   → Makes it searchable by all fields

7. DevOps engineer opens Kibana:
   → Searches: "Payment failed" AND namespace="dev"
   → Finds the log entry with full context instantly
```

---

## 5. EFK vs ELK — Fluent Bit vs Logstash

### 🆚 Side-by-Side Comparison

```
EFK Stack:                          ELK Stack:
  E = Elasticsearch                   E = Elasticsearch
  F = Fluent Bit          VS          L = Logstash
  K = Kibana                          K = Kibana
```

| Feature | Fluent Bit | Logstash |
|---------|-----------|---------|
| **Resource Usage** | Very lightweight (~450KB binary) | Heavy (~512MB+ heap) |
| **Role** | Log forwarder | Log aggregator + processor |
| **Filtering** | Basic to moderate (via Lua scripts) | Advanced (many filter plugins) |
| **Transformation** | Limited | Rich data transformation |
| **Performance** | High throughput, low CPU | Higher CPU/Memory usage |
| **Vendor Neutral** | ✅ Yes (works with many backends) | Limited |
| **Complexity** | Simple configuration | Complex configuration |
| **Best For** | Kubernetes-native log forwarding | Complex log processing pipelines |
| **Chance of Issues** | Low | Higher (more moving parts) |

### 🌍 When to Use Which

```
Use Fluent Bit when:
  ✅ You just need to collect and forward logs to Elasticsearch
  ✅ Running on Kubernetes (resource-constrained nodes)
  ✅ Your log format is standard (JSON, plain text)
  ✅ You want simple, reliable log shipping
  ✅ Startup or mid-size organization

Use Logstash when:
  ✅ You need complex log transformations before storing
  ✅ Parsing unstructured log formats into structured data
  ✅ Multi-source log aggregation with different formats
  ✅ Running complex conditional logic on logs
  ✅ Enterprise with dedicated observability team

Real-World Decision:
  90% of Kubernetes teams → Fluent Bit is sufficient
  Complex financial/banking pipelines → Logstash adds value
```

> 💡 **Vendor Neutrality Advantage of Fluent Bit:** If you decide to move from Elasticsearch to Splunk or Grafana Loki tomorrow, you only change the **output section** of Fluent Bit config. Your entire log collection setup stays the same. With Logstash, migration is more complex.

---

## 6. AWS EKS Setup — IAM Role, CSI Driver & EBS

### 🧠 Why is This Needed?

Elasticsearch running inside EKS needs **persistent storage** (EBS volumes) so logs aren't lost when pods restart. But there's a **permission boundary** problem:

```
┌─────────────────────────────────────────────────┐
│                  AWS Environment                  │
│                                                   │
│  ┌──────────────────┐     ┌──────────────────┐   │
│  │   EKS Cluster    │     │   EBS Volume      │   │
│  │                  │     │                   │   │
│  │  Elasticsearch   │ ←?→ │  (Persistent      │   │
│  │  (needs storage) │     │   Log Storage)    │   │
│  └──────────────────┘     └──────────────────┘   │
│                                                   │
│  Problem: EKS pods can't talk to EBS by default   │
│  Solution: IAM Role + CSI Driver                  │
└────────���────────────────────────────────────────┘
```

### 🔑 Solution Architecture

```
Step 1: Create IAM Role for EKS Service Account (IRSA)
  → Kubernetes ServiceAccount of Elasticsearch gets an IAM Role
  → This IAM Role has permission to create/attach/detach EBS volumes

Step 2: Install EBS CSI Driver (Container Storage Interface)
  → Acts as the "translator" between Kubernetes PVC requests
    and actual AWS EBS volume operations
  → When Elasticsearch requests 10Gi storage, CSI driver
    creates a real EBS volume and attaches it

Step 3: StorageClass + PVC automatically provisions EBS
  → Helm chart creates StorageClass (gp2)
  → Elasticsearch StatefulSet requests storage via PVC
  → CSI driver provisions actual EBS volume automatically
```

### Step 1: Create IAM Service Account

```bash
# Set variables
CLUSTER_NAME="observability-one"
REGION="us-east-1"
NAMESPACE="logging"
SERVICE_ACCOUNT_NAME="elasticsearch-sa"

# Create IAM service account with EBS permissions
eksctl create iamserviceaccount \
  --name $SERVICE_ACCOUNT_NAME \
  --namespace $NAMESPACE \
  --cluster $CLUSTER_NAME \
  --region $REGION \
  --role-name "AmazonEKS_EBS_CSI_DriverRole" \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve \
  --override-existing-serviceaccounts

# Retrieve the IAM Role ARN (save for later)
ARN=$(aws iam get-role \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --query 'Role.Arn' \
  --output text)

echo "IAM Role ARN: $ARN"
```

### Step 2: Install EBS CSI Driver

```bash
# Install EBS CSI driver as EKS managed add-on
aws eks create-addon \
  --cluster-name $CLUSTER_NAME \
  --addon-name aws-ebs-csi-driver \
  --service-account-role-arn $ARN \
  --region $REGION

# Verify the add-on is active
aws eks describe-addon \
  --cluster-name $CLUSTER_NAME \
  --addon-name aws-ebs-csi-driver \
  --region $REGION \
  --query 'addon.status'
# Expected: "ACTIVE"
```

### Step 3: Create Logging Namespace

```bash
kubectl create namespace logging
kubectl get namespace logging
# NAME      STATUS   AGE
# logging   Active   5s
```

---

## 7. Installing Elasticsearch on Kubernetes

### 🧠 What is Elasticsearch?

Elasticsearch is a **distributed, full-text search and analytics engine** built on Apache Lucene. In the EFK context, it serves as the **log database** — storing, indexing, and making logs searchable.

```
Key Elasticsearch Concepts:
  Index    → Like a database table (e.g., fluent-bit-2024.01.15)
  Document → One log entry (JSON object with all fields)
  Shard    → Partition of an index (for distributed storage)
  Replica  → Copy of a shard (for high availability)
```

### Step 1: Add Elasticsearch Helm Repo

```bash
helm repo add elastic https://helm.elastic.co
helm repo update
```

### Step 2: Install Elasticsearch with EBS Storage

```bash
helm install elasticsearch elastic/elasticsearch \
  --namespace logging \
  --set persistence.enabled=true \
  --set volumeClaimTemplate.storageClassName=gp2 \
  --set volumeClaimTemplate.resources.requests.storage=10Gi \
  --set replicas=1 \
  --set resources.requests.cpu=500m \
  --set resources.requests.memory=1Gi \
  --set resources.limits.cpu=1000m \
  --set resources.limits.memory=2Gi
```

### Step 3: Retrieve Elasticsearch Credentials

```bash
# Get the username (default: elastic)
kubectl get secret elasticsearch-master-credentials \
  -n logging \
  -o jsonpath='{.data.username}' | base64 -d
# Output: elastic

# Get the password
kubectl get secret elasticsearch-master-credentials \
  -n logging \
  -o jsonpath='{.data.password}' | base64 -d
# Output: <generated-password>  ← SAVE THIS!

# Store password in a variable for later use
ES_PASSWORD=$(kubectl get secret elasticsearch-master-credentials \
  -n logging \
  -o jsonpath='{.data.password}' | base64 -d)
echo "ES Password: $ES_PASSWORD"
```

> ⚠️ **Critical:** Save the Elasticsearch password immediately after installation. You'll need it for Fluent Bit and Kibana configuration.

### Elasticsearch as StatefulSet — Why?

```yaml
# Elasticsearch is deployed as a StatefulSet (not Deployment)
# Reason: StatefulSets provide:
#   1. Stable network identity (elasticsearch-master-0, elasticsearch-master-1)
#   2. Ordered deployment and scaling
#   3. Persistent storage that survives pod restarts

# Each Elasticsearch pod gets its own PVC:
# elasticsearch-master-elasticsearch-master-0  → EBS volume 1
# elasticsearch-master-elasticsearch-master-1  → EBS volume 2
```

---

## 8. Installing Kibana on Kubernetes

### Step 1: Install Kibana with LoadBalancer

```bash
helm install kibana elastic/kibana \
  --namespace logging \
  --set service.type=LoadBalancer \
  --set service.port=5601 \
  --set elasticsearchHosts="http://elasticsearch-master:9200"
```

### Step 2: Get Kibana URL

```bash
# Wait for LoadBalancer IP to be assigned
kubectl get svc kibana-kibana -n logging -w

# Once EXTERNAL-IP appears:
kubectl get svc kibana-kibana -n logging
# NAME            TYPE           CLUSTER-IP     EXTERNAL-IP          PORT(S)
# kibana-kibana   LoadBalancer   10.100.12.34   abc.elb.amazonaws.com  5601:32601/TCP
```

### Step 3: Access Kibana

```
URL: http://<EXTERNAL-IP>:5601

Credentials:
  Username: elastic
  Password: <the password you saved from Elasticsearch>
```

### Step 4: Verify Kibana → Elasticsearch Connection

```
Kibana UI → Stack Management → Elasticsearch → Nodes
Should show: elasticsearch-master-0 is connected ✅
```

---

## 9. Fluent Bit — Configuration Deep Dive

### 🧠 Fluent Bit's Four Core Sections

Fluent Bit configuration is organized into **four primary sections**, each handling a specific stage in the log pipeline:

```
┌────────────┐    ┌────────────┐    ┌────────────┐    ┌────────────┐
│  SERVICE   │    │   INPUT    │    │   FILTER   │    │   OUTPUT   │
│            │    │            │    │            │    │            │
│ Global     │ →  │ Where logs │ →  │ Transform/ │ →  │  Where to  │
│ settings   │    │ come from  │    │ filter logs│    │  send logs │
│            │    │            │    │            │    │            │
│ Flush rate │    │ /var/log/  │    │ Exclude    │    │Elasticsearch│
│ Log level  │    │ containers │    │ namespaces │    │ Splunk     │
│ Daemon mode│    │ Tail files │    │ Add labels │    │ Loki etc.  │
└────────────┘    └────────────┘    └────────────┘    └────────────┘
```

### 📝 Complete Fluent Bit values.yaml

```yaml
# fluent-bit-values.yaml
# ═══════════════════════════════════════════════════════════════
# SECTION 1: SERVICE — Global Fluent Bit Settings
# ═══════════════════════════════════════════════════════════════
config:
  service: |
    [SERVICE]
        Flush         1            # Send logs to output every 1 second
        Log_Level     info         # Log level: debug/info/warn/error
        Daemon        off          # Don't run as daemon (K8s manages this)
        Parsers_File  parsers.conf # Parsing rules for different log formats
        HTTP_Server   On           # Enable HTTP server for health checks
        HTTP_Listen   0.0.0.0
        HTTP_Port     2020

# ═══════════════════════════════════════════════════════════════
# SECTION 2: INPUT — Where to Read Logs From
# ═══════════════════════════════════════════════════════════════
  inputs: |
    [INPUT]
        Name              tail
        # Read ALL container logs from the node
        Path              /var/log/containers/*.log
        # Use Kubernetes metadata parser
        multiline.parser  docker, cri
        Tag               kube.*
        # Track file position to avoid re-reading logs
        Mem_Buf_Limit     5MB
        Skip_Long_Lines   On
        # Refresh every 10 seconds to pick up new log files
        Refresh_Interval  10

# ═══════════════════════════════════════════════════════════════
# SECTION 3: FILTERS — Transform, Enrich, and Filter Logs
# ═══════════════════════════════════════════════════════════════
  filters: |
    # Filter 1: Enrich logs with Kubernetes metadata
    [FILTER]
        Name                kubernetes
        Match               kube.*
        # Get pod name, namespace, labels from K8s API
        Kube_URL            https://kubernetes.default.svc:443
        Kube_CA_File        /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        Kube_Token_File     /var/run/secrets/kubernetes.io/serviceaccount/token
        Kube_Tag_Prefix     kube.var.log.containers.
        Merge_Log           On          # Merge JSON logs from app
        Keep_Log            Off
        K8S-Logging.Parser  On
        K8S-Logging.Exclude On

    # Filter 2: Use Lua script to exclude certain namespaces
    [FILTER]
        Name    lua
        Match   kube.*
        script  /fluent-bit/scripts/filter.lua
        call    exclude_namespaces

# ═══════════════════════════════════════════════════════════════
# SECTION 4: OUTPUT — Where to Forward Logs
# ═══════════════════════════════════════════════════════════════
  outputs: |
    [OUTPUT]
        Name            es
        Match           kube.*
        # Elasticsearch service name (internal K8s DNS)
        Host            elasticsearch-master
        Port            9200
        # Credentials
        HTTP_User       elastic
        HTTP_Passwd     <YOUR-ELASTICSEARCH-PASSWORD>
        # Index pattern (creates daily indices)
        Logstash_Format On
        Logstash_Prefix fluent-bit
        # TLS (required for AWS EKS)
        tls             On
        tls.verify      Off
        # Retry on failure
        Retry_Limit     False
        # Replace dots in field names (Elasticsearch requirement)
        Replace_Dots    On
        Suppress_Type_Name On

# Second OUTPUT (for backup or multi-destination)
# Uncomment to also send to stdout for debugging:
#   [OUTPUT]
#       Name   stdout
#       Match  kube.*

# ═══════════════════════════════════════════════════════════════
# Lua Script for Namespace Filtering
# ═══════════════════════════════════════════════════════════════
luaScripts:
  filter.lua: |
    -- Exclude logs from these namespaces
    local excluded_namespaces = {
      ["logging"] = true,        -- Don't log Elasticsearch/Kibana/Fluent Bit own logs
      ["kube-system"] = true,    -- Skip K8s system component logs
      ["monitoring"] = true,     -- Skip Prometheus/Grafana logs
    }

    function exclude_namespaces(tag, timestamp, record)
      local namespace = record["kubernetes"] and
                        record["kubernetes"]["namespace_name"]

      if namespace and excluded_namespaces[namespace] then
        return -1, timestamp, record  -- -1 = DROP this log entry
      end

      return 1, timestamp, record    -- 1 = KEEP this log entry
    end

# ═══════════════════════════════════════════════════════════════
# DaemonSet Configuration
# ═══════════════════════════════════════════════════════════════
daemonSetVolumes:
  - name: varlog
    hostPath:
      path: /var/log              # Mount node's log directory
  - name: varlibdockercontainers
    hostPath:
      path: /var/lib/docker/containers  # Container logs

daemonSetVolumeMounts:
  - name: varlog
    mountPath: /var/log
    readOnly: true
  - name: varlibdockercontainers
    mountPath: /var/lib/docker/containers
    readOnly: true

# Resource limits for Fluent Bit
resources:
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 100m
    memory: 128Mi
```

### 🧠 Understanding the Lua Filter Script

```lua
-- filter.lua explained:

-- Table of namespaces to EXCLUDE from log forwarding
local excluded_namespaces = {
  ["logging"] = true,    -- Why? Elasticsearch/Kibana/Fluent Bit
                         -- own logs would create a feedback loop!
  ["kube-system"] = true -- Skip noisy K8s system logs
}

function exclude_namespaces(tag, timestamp, record)
  -- Get the namespace from the enriched Kubernetes metadata
  local namespace = record["kubernetes"] and
                    record["kubernetes"]["namespace_name"]

  -- If namespace is in exclusion list → DROP the log
  if namespace and excluded_namespaces[namespace] then
    return -1, timestamp, record  -- Return code -1 = DISCARD
  end

  -- Otherwise → KEEP the log and forward to Elasticsearch
  return 1, timestamp, record     -- Return code 1 = PASS THROUGH
end
```

> 💡 **Why exclude the `logging` namespace?** Fluent Bit would read its own logs and Elasticsearch's logs, forward them to Elasticsearch, which creates more logs, which Fluent Bit reads again — an **infinite feedback loop** that would fill up your storage!

---

## 10. Installing Fluent Bit & Connecting to Elasticsearch

### Step 1: Update Password in values.yaml

```bash
# Get the Elasticsearch password
ES_PASSWORD=$(kubectl get secret elasticsearch-master-credentials \
  -n logging \
  -o jsonpath='{.data.password}' | base64 -d)

echo "ES Password: $ES_PASSWORD"

# Edit the fluent-bit values.yaml
# Find HTTP_Passwd and replace with your password
vim fluent-bit-values.yaml
# Search for: HTTP_Passwd
# Update both OUTPUT sections with the actual password
```

### Step 2: Add Fluent Bit Helm Repo

```bash
helm repo add fluent https://fluent.github.io/helm-charts
helm repo update
```

### Step 3: Install Fluent Bit

```bash
helm install fluent-bit fluent/fluent-bit \
  --namespace logging \
  --values fluent-bit-values.yaml
```

### Step 4: Verify All Components Running

```bash
kubectl get pods -n logging
# NAME                              READY   STATUS    RESTARTS   AGE
# elasticsearch-master-0            1/1     Running   0          5m
# elasticsearch-master-1            1/1     Running   0          4m
# kibana-kibana-7d9f8-xk2p1         1/1     Running   0          3m
# fluent-bit-ds-node1               1/1     Running   0          1m   ← DaemonSet pod
# fluent-bit-ds-node2               1/1     Running   0          1m   ← DaemonSet pod
```

> 🔍 **Notice:** Two Fluent Bit pods = Two nodes in the cluster. This confirms DaemonSet behavior — one pod per node.

### Step 5: Verify Fluent Bit is Collecting Logs

```bash
# Check Fluent Bit logs for successful forwarding
kubectl logs fluent-bit-ds-node1 -n logging | tail -50

# Look for these messages (GOOD):
# [info] [output:es:es.0] worker #0 connected to elasticsearch-master:9200

# Watch for these (WARNING but OK):
# [warn] [engine] failed to flush chunk  ← Usually transient, not critical

# Watch for these (ERRORS to fix):
# [error] could not connect to elasticsearch-master:9200
# [error] Authentication failed
```

---

## 11. Deploying a Test Application & Verifying Log Flow

### Step 1: Deploy Test Application

```bash
# Create namespace
kubectl create namespace dev

# Deploy from Day 4 application (or any app that generates logs)
kubectl apply -k ./day4/kubernetes-manifests/ -n dev

# Verify pods are running
kubectl get pods -n dev
# NAME                        READY   STATUS    RESTARTS   AGE
# service-a-7d9f8b-xk2p1     1/1     Running   0          30s
# service-b-6c8f7a-ym3q2     1/1     Running   0          30s
```

### Step 2: Generate Some Logs

```bash
# Get the LoadBalancer URL of service-a
SVC_URL=$(kubectl get svc service-a -n dev \
  -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

# Hit different endpoints to generate logs
curl http://$SVC_URL:3000/health
curl http://$SVC_URL:3000/logs
curl http://$SVC_URL:3000/health
curl http://$SVC_URL:3000/logs

# Check raw pod logs
kubectl logs -l app=service-a -n dev
# [INFO] Service A is running on Port 3000
# [INFO] GET /health 200 2ms
# [INFO] GET /logs 200 1ms
```

### Step 3: Verify Fluent Bit Found the Application

```bash
# Check Fluent Bit logs for service-a discovery
kubectl logs fluent-bit-ds-node1 -n logging | grep "service-a"
# [info] [input:tail] found container: service-a
# [info] [output:es] flushed 15 chunks with 45 records
```

---

## 12. Kibana — Creating Data Views & Querying Logs

### Step 1: Access Kibana & Create Data View

```
1. Open: http://<kibana-loadbalancer>:5601
2. Login: elastic / <your-elasticsearch-password>
3. Navigate to: Discover (left sidebar)
4. Click: "Create data view"
5. Fill in:
   Name:          log-management
   Index pattern: fluent-bit-*        ← matches fluent-bit-2024.01.15 etc.
   Timestamp:     @timestamp
6. Click: "Save data view to Kibana"
```

### Step 2: Query Logs in Kibana (KQL — Kibana Query Language)

```
# KQL (Kibana Query Language) Examples:

# Show all logs from dev namespace
kubernetes.namespace_name : "dev"

# Show logs from specific service
kubernetes.labels.app : "service-a"

# Show only ERROR level logs
log.level : "ERROR"

# Combine filters
kubernetes.namespace_name : "production" AND log.level : "ERROR"

# Search for specific text in log message
message : "connection timed out"

# Exclude a namespace
NOT kubernetes.namespace_name : "kube-system"

# Find logs in a time range (use time picker in UI)
# Last 15 minutes, Last 1 hour, Custom range

# Search for database errors across ALL services
message : "database" AND message : "error"

# Find pod restart related logs
kubernetes.namespace_name : "production" AND message : "OOMKilled"
```

### Step 3: What a Log Entry Looks Like in Kibana

```json
{
  "@timestamp": "2024-01-15T14:32:11.234Z",
  "log": {
    "level": "ERROR",
    "message": "Payment failed for order_id=789: connection timed out"
  },
  "kubernetes": {
    "namespace_name": "production",
    "pod_name": "payment-service-7d9f-xk2p",
    "container_name": "payment-service",
    "node_name": "ip-10-0-1-45.ec2.internal",
    "labels": {
      "app": "payment-service",
      "version": "v2.1.0"
    }
  },
  "host": {
    "name": "ip-10-0-1-45.ec2.internal"
  }
}
```

> 💡 Notice how Fluent Bit **automatically enriches** each log with Kubernetes metadata (namespace, pod name, container name, node name, labels). This is done by the Kubernetes filter in Fluent Bit config — you don't write any of this in your application!

### Step 4: Save Useful Searches

```
In Kibana Discover:
1. Set your filters (e.g., namespace="production", level="ERROR")
2. Click "Save" at the top
3. Give it a name: "Production Errors - Last 1 Hour"
4. Share with your team

This allows any team member to open Kibana and
click on "Production Errors" to instantly see current errors.
```

---

## 13. Common Mistakes & Best Practices

### ❌ Common Mistakes

| Mistake | Problem | Fix |
|---------|---------|-----|
| Not excluding the `logging` namespace in Fluent Bit | Infinite log loop fills up Elasticsearch | Add Lua filter to exclude `logging` namespace |
| Hardcoding passwords in values.yaml in Git | Security breach — credentials exposed | Use Kubernetes Secrets or external secret manager (AWS Secrets Manager) |
| No EBS persistence for Elasticsearch | Logs lost on pod restart/node failure | Always use PVC with EBS for StatefulSet |
| TLS disabled on AWS EKS | Connection failures between Fluent Bit and Elasticsearch | Set `tls: On` in Fluent Bit output config |
| Single Elasticsearch replica in production | No high availability — one pod failure = all logs lost | Use at least 3 replicas in production |
| No log retention policy | Elasticsearch fills up disk — cluster crashes | Set index lifecycle management (ILM) to delete old indices |
| Not setting resource limits on Fluent Bit | Fluent Bit can consume all node memory | Always set `resources.limits.memory: 128Mi` |
| Using `kubectl logs` in production for debugging | Doesn't scale, logs disappear on pod restart | Always use centralized logging (EFK) |
| Not setting `Skip_Long_Lines: On` | Very long log lines crash Fluent Bit | Always enable this in INPUT config |
| Wrong StorageClass name | PVC stays in Pending state | Verify StorageClass exists: `kubectl get sc` |

### ✅ Best Practices

```yaml
# 1. Use Index Lifecycle Management to auto-delete old logs
# In Kibana: Stack Management → Index Lifecycle Policies
# Create policy: Delete indices older than 30 days

# 2. Structure your logs as JSON for better Kibana filtering
# Bad log:
logger.info("User 12345 logged in from 192.168.1.1 at 2024-01-15")

# Good log (JSON):
logger.info(json.dumps({
  "event": "user_login",
  "user_id": "12345",
  "ip_address": "192.168.1.1",
  "timestamp": "2024-01-15T14:32:11Z"
}))
# → Each field is separately searchable in Kibana

# 3. Use consistent log levels across all services
# Define a standard: What constitutes ERROR vs WARN in your org

# 4. Add correlation IDs for distributed tracing integration
logger.info(json.dumps({
  "correlation_id": "req-abc-123",  # Same ID across all services
  "event": "payment_processed",
  "service": "payment-service"
}))

# 5. Elasticsearch resource sizing (production)
resources:
  requests:
    cpu: "1000m"
    memory: "2Gi"
  limits:
    cpu: "2000m"
    memory: "4Gi"
# Rule of thumb: Heap size = 50% of available memory
```

```bash
# 6. Monitor Elasticsearch disk usage (set alert at 75% full)
kubectl exec -it elasticsearch-master-0 -n logging -- \
  curl -u elastic:$ES_PASSWORD \
  "http://localhost:9200/_cat/allocation?v"

# 7. Take EBS snapshots regularly
aws ec2 create-snapshot \
  --volume-id vol-xxxxxxxxx \
  --description "Elasticsearch backup $(date +%Y-%m-%d)"

# 8. Test Fluent Bit → Elasticsearch connection manually
kubectl exec -it fluent-bit-ds-node1 -n logging -- \
  curl -u elastic:$ES_PASSWORD \
  http://elasticsearch-master:9200/_cluster/health
# Expected: {"status":"green"...}
```

### 🔧 Debugging Tips

```bash
# 1. Elasticsearch not starting?
kubectl describe pod elasticsearch-master-0 -n logging
# Look for: PVC not bound → StorageClass issue
# Look for: OOMKilled → Increase memory limits

# 2. PVC stuck in Pending?
kubectl get pvc -n logging
kubectl describe pvc elasticsearch-master-elasticsearch-master-0 -n logging
# Common cause: EBS CSI driver not installed or IAM role missing

# 3. Fluent Bit not sending logs?
kubectl logs fluent-bit-ds-node1 -n logging | grep -i error
# Check: Is Elasticsearch password correct?
# Check: Is TLS setting correct for your environment?

# 4. Kibana shows "No data"?
# → Check if Fluent Bit is running: kubectl get pods -n logging
# → Check if index exists in Elasticsearch:
kubectl exec -it elasticsearch-master-0 -n logging -- \
  curl -u elastic:$ES_PASSWORD \
  "http://localhost:9200/_cat/indices?v"
# Look for: fluent-bit-YYYY.MM.DD indices

# 5. Can't login to Kibana?
# Retrieve fresh password:
kubectl get secret elasticsearch-master-credentials \
  -n logging -o jsonpath='{.data.password}' | base64 -d

# 6. Fluent Bit indentation errors in values.yaml?
# Validate YAML syntax before applying:
python3 -c "import yaml; yaml.safe_load(open('fluent-bit-values.yaml'))"
# No output = valid YAML
```

---

## 14. Interview Prep — Key Points

### 🎯 Most Asked Questions & Answers

**Q: What is the EFK stack and what does each component do?**
> **E**lasticsearch is the **database** that stores and indexes all logs, making them searchable. **F**luent Bit is the **log collector** deployed as a DaemonSet on every node — it reads container logs and forwards them to Elasticsearch. **K**ibana is the **visualization dashboard** where you query and analyze logs. Together they form a centralized logging system for Kubernetes.

**Q: Why does Fluent Bit run as a DaemonSet?**
> Container logs are stored on the **local filesystem of each node** at `/var/log/containers/`. Fluent Bit must run **on the node itself** to read these local files. A DaemonSet ensures exactly one Fluent Bit pod runs on every node — so no node's logs are missed.

**Q: What is the difference between EFK and ELK stacks?**
> Both use Elasticsearch and Kibana. The difference is the middle component: **ELK uses Logstash**, which is a heavy log **aggregator** with advanced filtering and transformation capabilities. **EFK uses Fluent Bit**, which is a lightweight log **forwarder**. Fluent Bit uses ~450KB of memory vs Logstash's 500MB+. For most Kubernetes use cases, Fluent Bit is sufficient. Logstash is chosen when complex log processing pipelines are needed.

**Q: Why is centralized logging important?**
> In a Kubernetes cluster with 100+ microservices across multiple namespaces, debugging an issue by running `kubectl logs` on each pod individually is impractical. Centralized logging aggregates all logs in one searchable database, enabling you to find error patterns across all services with a single query, maintain log retention for compliance, and dramatically reduce MTTR (Mean Time To Recover).

**Q: Why do you need an IAM role and EBS CSI driver for Elasticsearch on EKS?**
> Elasticsearch requires persistent storage so logs survive pod restarts. On AWS EKS, this means using EBS volumes. However, pods inside EKS cannot access AWS EBS volumes by default — there's an IAM permission boundary. The **IAM Role for Service Account (IRSA)** gives the Elasticsearch pod permission to interact with EBS. The **EBS CSI Driver** acts as the bridge that translates Kubernetes PersistentVolumeClaim requests into actual EBS volume creation and attachment operations.

**Q: What are the four sections of Fluent Bit configuration?**
> 1. **SERVICE** — Global settings (flush interval, log level, daemon mode)
> 2. **INPUT** — Where logs come from (tail `/var/log/containers/*.log`)
> 3. **FILTER** — Transform/enrich/exclude logs (add K8s metadata via kubernetes filter, exclude namespaces via Lua script)
> 4. **OUTPUT** — Where to send logs (Elasticsearch, Splunk, Loki, stdout)

**Q: Why should you exclude the `logging` namespace in Fluent Bit?**
> Without exclusion, Fluent Bit would read Elasticsearch's own logs, forward them to Elasticsearch, which generates more logs, which Fluent Bit reads again — creating an **infinite feedback loop** that rapidly fills storage and degrades performance.

---

## 📝 Quick Revision Summary

```
Day 5 Key Takeaways:

1. What is Logging?
   → Messages written in code to explain what app is doing
   → Helps debug WHY something is failing
   → Second pillar of observability (Metrics=WHAT, Logs=WHY, Traces=HOW)

2. Why Centralized Logging (EFK)?
   → 100+ pods across namespaces = kubectl logs doesn't scale
   → Single searchable database for ALL service logs
   → Log retention for compliance
   → Fast incident response across microservices

3. EFK Components:
   → Fluent Bit  = DaemonSet log collector (one per node)
   → Elasticsearch = Distributed log database (StatefulSet + EBS)
   → Kibana       = Web dashboard for querying logs (port 5601)

4. EFK vs ELK:
   → Fluent Bit (EFK) = Lightweight forwarder, vendor neutral
   → Logstash (ELK)   = Heavy aggregator, advanced processing
   → Start with Fluent Bit for most K8s use cases

5. AWS EKS Setup:
   → IAM Role (IRSA) → Allows Elasticsearch to use EBS
   → EBS CSI Driver  → Provisions EBS volumes from K8s PVC
   → StorageClass gp2 → Specifies EBS volume type

6. Fluent Bit Config Sections:
   → SERVICE → Global settings
   → INPUT   → Read from /var/log/containers/*.log
   → FILTER  → Enrich with K8s metadata, exclude namespaces (Lua)
   → OUTPUT  → Forward to Elasticsearch with credentials

7. Key Best Practices:
   → Always use JSON structured logging in apps
   → Exclude logging/kube-system namespaces in Fluent Bit
   → Set ILM (Index Lifecycle Management) for log retention
   → Always persist Elasticsearch on EBS volumes
   → Use TLS for Fluent Bit → Elasticsearch on AWS
```

---

> 📌 **Hands-On Challenge:** Set up the EFK stack on your EKS cluster following these notes. Deploy any application, generate logs by hitting its endpoints, then go to Kibana and filter logs for just your application's namespace. Try KQL queries to find specific log messages. This exercise will solidify the entire log flow from application → Fluent Bit → Elasticsearch → Kibana.
