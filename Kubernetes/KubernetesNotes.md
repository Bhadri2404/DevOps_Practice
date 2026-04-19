# 🚀 Comprehensive CKA Master Notes — Senior DevOps & Kubernetes Administrator

> **Crafted for CKA Mastery, Production-Grade Understanding & Senior DevOps Interviews**
> *Explanation-first approach: 70% concepts, 30% YAML/commands*

---

## 📋 Table of Contents

### Part 1: Core Concepts & Scheduling
- [1.1 Kubernetes Architecture Deep Dive](#11-kubernetes-architecture-deep-dive)
- [1.2 Pods — The Atomic Unit](#12-pods--the-atomic-unit)
- [1.3 ReplicaSets — Self-Healing Guarantees](#13-replicasets--self-healing-guarantees)
- [1.4 Deployments — Rolling Updates & Rollbacks](#14-deployments--rolling-updates--rollbacks)
- [1.5 Services — Stable Networking for Pods](#15-services--stable-networking-for-pods)
- [1.6 Namespaces — Logical Cluster Isolation](#16-namespaces--logical-cluster-isolation)
- [1.7 ConfigMaps & Secrets — Externalizing Configuration](#17-configmaps--secrets--externalizing-configuration)
- [1.8 Resource Requirements, Limits & LimitRanges](#18-resource-requirements-limits--limitranges)
- [1.9 Taints, Tolerations & Node Affinity — Advanced Scheduling](#19-taints-tolerations--node-affinity--advanced-scheduling)
- [1.10 DaemonSets, Static Pods & Multiple Schedulers](#110-daemonsets-static-pods--multiple-schedulers)
- [1.11 Monitoring & Metrics Server](#111-monitoring--metrics-server)

### Part 2: Logging, Lifecycle Management & Cluster Maintenance
- [2.1 Managing Application Logs](#21-managing-application-logs)
- [2.2 Rolling Updates, Rollbacks & Deployment Strategies](#22-rolling-updates-rollbacks--deployment-strategies)
- [2.3 Commands & Arguments — Docker vs Kubernetes](#23-commands--arguments--docker-vs-kubernetes)
- [2.4 Secrets Management & Encryption at Rest](#24-secrets-management--encryption-at-rest)
- [2.5 Multi-Container Pods — Sidecar Patterns](#25-multi-container-pods--sidecar-patterns)
- [2.6 Horizontal & Vertical Pod Autoscaling](#26-horizontal--vertical-pod-autoscaling)
- [2.7 OS Upgrades — Drain, Cordon & Uncordon](#27-os-upgrades--drain-cordon--uncordon)
- [2.8 Cluster Upgrade with kubeadm](#28-cluster-upgrade-with-kubeadm)
- [2.9 Backup & Restore — etcd & Cluster State](#29-backup--restore--etcd--cluster-state)

### Part 3: Security & Storage
- [3.1 Kubernetes Security Architecture](#31-kubernetes-security-architecture)
- [3.2 Authentication — Who Are You?](#32-authentication--who-are-you)
- [3.3 TLS Certificates — Deep Dive](#33-tls-certificates--deep-dive)
- [3.4 KubeConfig — Credential Management](#34-kubeconfig--credential-management)
- [3.5 RBAC — Role-Based Access Control](#35-rbac--role-based-access-control)
- [3.6 Service Accounts — Machine Identity](#36-service-accounts--machine-identity)
- [3.7 Network Policies — Zero-Trust Networking](#37-network-policies--zero-trust-networking)
- [3.8 Image Security & Security Contexts](#38-image-security--security-contexts)
- [3.9 Custom Resource Definitions & Operators](#39-custom-resource-definitions--operators)
- [3.10 Storage — PV, PVC & Storage Classes](#310-storage--pv-pvc--storage-classes)

### Part 4: Networking, Troubleshooting & Cluster Installation
- [4.1 Linux Networking Fundamentals](#41-linux-networking-fundamentals)
- [4.2 CNI — Container Network Interface](#42-cni--container-network-interface)
- [4.3 Service Networking & kube-proxy](#43-service-networking--kube-proxy)
- [4.4 DNS in Kubernetes — CoreDNS](#44-dns-in-kubernetes--coredns)
- [4.5 Ingress — Layer 7 Load Balancing](#45-ingress--layer-7-load-balancing)
- [4.6 Troubleshooting — Application & Cluster Failures](#46-troubleshooting--application--cluster-failures)
- [4.7 Installing Kubernetes with kubeadm](#47-installing-kubernetes-with-kubeadm)

### Part 5: Helm, Kustomize & Package Management
- [5.1 Helm — The Kubernetes Package Manager](#51-helm--the-kubernetes-package-manager)
- [5.2 Helm vs Kustomize](#52-helm-vs-kustomize)
- [5.3 Kustomize — Plain YAML Customization](#53-kustomize--plain-yaml-customization)

---

---

# PART 1: CORE CONCEPTS & SCHEDULING

---

## 1.1 Kubernetes Architecture Deep Dive

### What is Kubernetes?

Kubernetes (K8s) is an open-source **container orchestration platform** originally developed by Google and donated to the CNCF in 2014. It automates the deployment, scaling, and management of containerized workloads across a cluster of machines.

Before Kubernetes, teams ran containers manually on individual servers. If a container crashed, someone had to restart it. If traffic spiked, someone had to manually spin up more containers. Kubernetes solved these problems by providing a declarative, self-healing, auto-scaling system.

### The Architecture: Two-Plane Model

```
┌─────────────────────────────────────────────────────────────────┐
│                    CONTROL PLANE (Master Node)                  │
│                                                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌─────────────────────┐  │
│  │  kube-api    │  │  Controller  │  │   kube-scheduler    │  │
│  │  server      │◄─┤  Manager     │  │                     │  │
│  │  (Port 6443) │  │              │  │ (Decides WHERE pods │  │
│  └──────┬───────┘  └──────────────┘  │  are placed)        │  │
│         │                            └─────────────────────┘  │
│         │          ┌──────────────┐                            │
│         └─────────►│    etcd      │ (Key-value state store)   │
│                    │  (Port 2379) │                            │
│                    └──────────────┘                            │
└─────────────────────────────────────────────────────────────────┘
                              │
              ┌───────────────┼───────────────┐
              ▼               ▼               ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│   Worker Node 1 │ │   Worker Node 2 │ │   Worker Node 3 │
│                 │ │                 │ │                 │
│  ┌───────────┐  │ │  ┌───────────┐  │ │  ┌───────────┐  │
│  │  kubelet  │  │ │  │  kubelet  │  │ │  │  kubelet  │  │
│  └───────────┘  │ │  └───────────┘  │ │  └───────────┘  │
│  ┌───────────┐  │ │  ┌───────────┐  │ │  ┌───────────┐  │
│  │ kube-proxy│  │ │  │ kube-proxy│  │ │  │ kube-proxy│  │
│  └───────────┘  │ │  └───────────┘  │ │  └───────────┘  │
│  ┌───────────┐  │ │  ┌───────────┐  │ │  ┌───────────┐  │
│  │ Container │  │ │  │ Container │  │ │  │ Container │  │
│  │ Runtime   │  │ │  │ Runtime   │  │ │  │ Runtime   │  │
│  │(containerd│  │ │  │(containerd│  │ │  │(containerd│  │
│  └───────────┘  │ │  └───────────┘  │ │  └───────────┘  │
└─────────────────┘ └─────────────────┘ └─────────────────┘
```

### Control Plane Components — Deep Explanation

#### 1. kube-apiserver — The Central Hub

The API Server is **the single source of truth and the only component that talks directly to etcd**. Every interaction with the cluster — whether from `kubectl`, other control plane components, or external tools — goes through the API Server.

**How it works internally:**
1. A user runs `kubectl apply -f deployment.yaml`
2. `kubectl` serializes the request and sends it as an HTTP/HTTPS REST call to the API Server
3. The API Server **authenticates** the request (who are you?)
4. The API Server **authorizes** the request (are you allowed to do this?)
5. The API Server runs **admission controllers** (additional validation/mutation)
6. The API Server **validates** the resource definition
7. The API Server **writes the desired state to etcd**
8. The API Server **notifies watching components** (like controllers and the scheduler)

**Why it matters in production:** If the API Server is down, you can't `kubectl` anything, no new pods get scheduled, but *existing running pods continue to run*. This is a critical distinction — the data plane is somewhat independent of the control plane.

#### 2. etcd — The Brain's Memory

etcd is a **distributed, consistent key-value store** that holds the entire state of your Kubernetes cluster. Everything — all Pods, Services, ConfigMaps, Secrets, Deployments, RBAC rules — is stored in etcd.

**Why etcd is critical:**
- It uses the **Raft consensus algorithm** ensuring consistency across etcd cluster members
- It's **append-only** — changes are journaled, making recovery possible
- In production, you run **3 or 5 etcd members** for HA (never 2 or 4 — must be odd for quorum)
- **Losing etcd = losing your cluster state** — this is why etcd backup is a CKA exam requirement

**Production consideration:** In large EKS or on-prem clusters, etcd is often placed on dedicated nodes with SSD storage because it's extremely I/O sensitive.

#### 3. kube-scheduler — The Smart Placer

The Scheduler watches for **newly created Pods that have no node assignment** and decides which node each Pod should run on. It doesn't actually *run* the pod — it just assigns it to a node, then the kubelet on that node takes over.

**Scheduling decision process:**
1. **Filtering phase:** Eliminate nodes that *cannot* run the pod (insufficient CPU/memory, taints, node selectors)
2. **Scoring phase:** Rank remaining nodes using priority functions (least loaded, image already present, etc.)
3. **Assignment:** Bind the pod to the highest-scoring node by updating etcd via the API Server

#### 4. kube-controller-manager — The Reconciliation Engine

This component runs multiple **controllers** — each controller is a loop that watches the current state of specific resources and takes action to bring actual state in line with desired state.

**Key controllers:**
- **ReplicaSet Controller**: Ensures the right number of pods are running
- **Node Controller**: Monitors node health, marks unreachable nodes as `NotReady`
- **Deployment Controller**: Manages rolling updates by creating/deleting ReplicaSets
- **Service Account Controller**: Creates default service accounts in new namespaces
- **Job Controller**: Manages batch jobs and their completion

**The Reconciliation Loop (critical concept):**
```
Watch etcd → Compare actual vs desired → Take corrective action → Repeat
```

This is why Kubernetes is called a **declarative system** — you declare *what* you want, controllers figure out *how* to achieve it.

### Worker Node Components

#### kubelet — The Node Agent

The kubelet runs on **every worker node** and is responsible for:
- Registering the node with the cluster
- Watching the API Server for Pods assigned to its node
- Calling the container runtime (containerd/CRI-O) to start/stop containers
- Reporting Pod and node status back to the API Server
- Mounting volumes and secrets into containers
- Running liveness/readiness probes

**Critical production fact:** The kubelet is the *only* Kubernetes component that is **not** deployed as a container or pod — it runs as a system service (systemd) on the node. If it goes down, no new pods start on that node and existing pod health isn't reported.

#### kube-proxy — The Network Rules Manager

kube-proxy runs on every node and maintains **iptables (or IPVS) rules** that implement Kubernetes Service networking. When you create a Service, kube-proxy creates the appropriate NAT rules so that traffic to the Service's ClusterIP gets forwarded to the right backend Pods.

#### Container Runtime

The actual software that runs containers. Kubernetes uses the **CRI (Container Runtime Interface)** to talk to the runtime. Common runtimes:
- **containerd** (most common today, used in EKS, GKE, AKS)
- **CRI-O** (Red Hat/OpenShift focused)
- Docker (deprecated as a direct runtime since K8s 1.24)

### Request Flow — Complete End-to-End

```
kubectl apply -f app.yaml
    │
    ▼
kube-apiserver (authenticate → authorize → admission → validate → write etcd)
    │
    ▼
etcd stores desired state
    │
    ▼ (watch notification)
kube-scheduler sees unscheduled pod → assigns node → updates etcd
    │
    ▼ (watch notification)
kubelet on assigned node sees new pod assignment
    │
    ▼
kubelet calls containerd → container starts
    │
    ▼
kubelet reports status → etcd updated (via apiserver)
    │
    ▼
kube-proxy updates iptables if service exists
```

> **CKA Exam Insight:** You must know which port each component uses (6443 for apiserver, 2379/2380 for etcd, 10250 for kubelet, 10259 for scheduler, 10257 for controller-manager). Memorize these for network policy and firewall questions.

---

## 1.2 Pods — The Atomic Unit

### What is a Pod and Why Does It Exist?

A Pod is the **smallest deployable unit in Kubernetes**. It's a logical wrapper around one or more containers. The key question is: why does Kubernetes introduce this abstraction instead of working directly with containers?

**The reason:** Kubernetes needed a way to represent "a unit of work" that could include tightly coupled helper containers (sidecars). A Pod allows multiple containers to:
- Share the **same network namespace** (they communicate via `localhost`)
- Share **storage volumes** (same volume can be mounted in multiple containers)
- Have the **same lifecycle** (they start and stop together)

**Real-world example:** In production EKS environments, you commonly see:
- Main application container + Envoy proxy sidecar (for service mesh like Istio)
- Application container + Filebeat sidecar (for log shipping to Elasticsearch)
- Application container + Vault agent (for secrets injection)

### Pod Lifecycle

```
Pending → Running → Succeeded/Failed/Unknown
   │
   ▼
ContainerCreating → ContainerStarting → Running → (Terminating)
```

**Pod phases explained:**
- **Pending**: Pod accepted by API Server, but containers not yet started. Could be waiting for node assignment, image pull, or resource availability
- **Running**: At least one container is running (but not necessarily healthy)
- **Succeeded**: All containers exited with status 0 (common for Jobs)
- **Failed**: All containers exited, at least one with non-zero status
- **Unknown**: Can't communicate with the node where pod runs

### Pod YAML with Production Comments

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: webapp-pod
  namespace: production
  labels:
    app: webapp
    tier: frontend
    version: "1.0.0"
  annotations:
    # Annotations are non-identifying metadata — great for tools, monitoring, CI/CD
    prometheus.io/scrape: "true"
    prometheus.io/port: "8080"
    git-commit: "abc123def"
spec:
  # ─── SCHEDULING HINTS ───────────────────────────────────────────
  # Prefer to run on nodes labeled with "type=web"
  # nodeSelector is a simple key-value match — use affinity for complex rules
  nodeSelector:
    type: web

  # ─── CONTAINERS ──────────────────────────────────────────────────
  containers:
  - name: webapp
    image: nginx:1.21.6
    # PRODUCTION ISSUE: Never use 'latest' tag in production!
    # 'latest' causes ImagePullBackOff surprises during rollouts and breaks reproducibility
    # Always use specific, immutable tags like sha256 digests in GitOps pipelines

    ports:
    - containerPort: 80
      protocol: TCP

    # ─── RESOURCE MANAGEMENT (CRITICAL!) ─────────────────────────
    resources:
      requests:
        # requests = what the scheduler uses for placement decisions
        # If no request is set, pod can be placed on any node (including overloaded ones)
        cpu: "250m"      # 250 millicores = 0.25 CPU core
        memory: "128Mi"
      limits:
        # limits = hard ceiling the kernel enforces
        # PRODUCTION ISSUE - OOMKilled: If your app uses MORE than memory limit,
        # the Linux kernel OOM killer will terminate the container.
        # Symptom: pod restarts with reason OOMKilled
        # Fix: Increase memory limit OR fix memory leak in application
        # Check: kubectl describe pod <name> → look for "OOMKilled" in Last State
        memory: "256Mi"
        # PRODUCTION ISSUE - CPU Throttling: When container hits CPU limit,
        # the kernel throttles (slows down) the container — it doesn't kill it.
        # Symptom: high latency, slow responses, high CPU throttle % in metrics
        # Fix: Increase CPU limit or optimize application CPU usage
        # Monitoring: container_cpu_cfs_throttled_seconds_total metric in Prometheus
        cpu: "500m"

    # ─── HEALTH PROBES ──────────────────────────────────────────
    livenessProbe:
      # liveness: "Is the container still alive and working?"
      # If this fails, Kubernetes RESTARTS the container
      # PRODUCTION ISSUE - CrashLoopBackOff: If liveness probe keeps failing,
      # container keeps restarting. Each restart has increasing backoff delay.
      # Common cause: app deadlock, startup too slow, probe path wrong
      httpGet:
        path: /health
        port: 80
      initialDelaySeconds: 15  # Wait 15s before first probe (allow app startup)
      periodSeconds: 10
      failureThreshold: 3

    readinessProbe:
      # readiness: "Is the container ready to serve traffic?"
      # If this fails, pod is REMOVED from Service endpoints (no traffic sent)
      # Container is NOT restarted — just temporarily taken out of rotation
      # PRODUCTION USE: Use this during rolling updates to prevent serving traffic
      # before the app is fully initialized (DB connections, cache warming, etc.)
      httpGet:
        path: /ready
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 5

    # ─── ENVIRONMENT VARIABLES ──────────────────────────────────
    env:
    - name: ENV
      value: "production"
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: db-secret
          key: password
          # PRODUCTION ISSUE: If the secret doesn't exist, pod will fail with
          # status "CreateContainerConfigError" — it won't even try to start
          # Always ensure secrets/configmaps exist before deploying pods

    # ─── VOLUME MOUNTS ──────────────────────────────────────────
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config
      readOnly: true   # Best practice: mount config as read-only

  # ─── VOLUMES ────────────────────────────────────────────────────
  volumes:
  - name: config-volume
    configMap:
      name: webapp-config

  # ─── RESTART POLICY ─────────────────────────────────────────────
  restartPolicy: Always
  # Options: Always (default), OnFailure (for Jobs), Never

  # ─── TERMINATION GRACE PERIOD ───────────────────────────────────
  terminationGracePeriodSeconds: 30
  # When pod is terminated, SIGTERM is sent. App has 30s to clean up.
  # After 30s, SIGKILL is sent. If your app needs longer shutdown (draining
  # connections), increase this. Common production setting: 60-120s
```

### Common Pod Failure Scenarios

| Error | What It Means | How to Debug |
|-------|--------------|--------------|
| `CrashLoopBackOff` | Container starts and immediately crashes, repeatedly | `kubectl logs <pod> --previous` to see last crash logs |
| `OOMKilled` | Container exceeded memory limit, kernel killed it | `kubectl describe pod <name>` → check Last State |
| `ImagePullBackOff` | Cannot pull container image (wrong name, tag, or no credentials) | `kubectl describe pod` → look at Events section |
| `CreateContainerConfigError` | Referenced ConfigMap/Secret doesn't exist | Check if the referenced resources exist |
| `Pending` (stuck) | No node can satisfy pod's requirements | `kubectl describe pod` → check Events for scheduling failures |

---

## 1.3 ReplicaSets — Self-Healing Guarantees

### What is a ReplicaSet?

A ReplicaSet is a Kubernetes controller that ensures a **specified number of identical pod replicas are always running**. It's the mechanism behind Kubernetes' self-healing capability.

**Why does it exist?** Individual Pods are ephemeral. If a Pod crashes or a node goes down, the Pod is gone. A ReplicaSet continuously watches the cluster and automatically creates replacement Pods when existing ones disappear.

**How it works internally:**
1. The ReplicaSet controller runs a reconciliation loop
2. It counts pods matching its `selector`
3. If actual count < desired count: creates new pods
4. If actual count > desired count: deletes excess pods
5. This loop runs continuously

### ReplicaSet vs ReplicationController

`ReplicationController` is the older API (still works but deprecated). `ReplicaSet` is the modern replacement. The key difference: **ReplicaSet supports set-based label selectors** (`In`, `NotIn`, `Exists`) while ReplicationController only supports equality-based selectors (`=`).

**In practice:** You almost never create ReplicaSets directly. Deployments create and manage them. Use Deployments instead.

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: webapp-rs
  namespace: production
spec:
  replicas: 3  # Always maintain exactly 3 pods

  # CRITICAL: The selector MUST match the template labels
  # Mismatch causes the ReplicaSet to ignore existing pods and over-provision
  selector:
    matchLabels:
      app: webapp
      tier: frontend

  template:
    metadata:
      labels:
        app: webapp      # Must match selector
        tier: frontend   # Must match selector
    spec:
      containers:
      - name: webapp
        image: nginx:1.21.6
        resources:
          requests:
            cpu: "100m"
            memory: "64Mi"
          limits:
            # PRODUCTION ISSUE: OOMKilled example
            # If nginx serves large files and memory exceeds 128Mi,
            # kernel kills container. Monitor with:
            # kubectl top pods -n production
            memory: "128Mi"
            cpu: "200m"
```

### Key ReplicaSet Behaviors

**Label ownership:** ReplicaSets own any pods that match their selector, regardless of who created them. This means if you manually create a pod with matching labels, the ReplicaSet may delete it to maintain the count. This is a **common production gotcha**.

**Scaling:**
```bash
# Scale imperatively
kubectl scale replicaset webapp-rs --replicas=5

# Scale declaratively (preferred in production)
# Edit the YAML and kubectl apply
```

**Pod template updates:** Changing the pod template in a ReplicaSet does **NOT** update existing pods. Only newly created pods use the new template. This is why you use **Deployments** — they handle the rollout of template changes.

---

## 1.4 Deployments — Rolling Updates & Rollbacks

### What is a Deployment?

A Deployment is the **recommended way to run stateless applications in Kubernetes**. It wraps ReplicaSets and adds:
- **Rolling updates**: gradually replace old pods with new ones
- **Rollback capability**: revert to previous versions
- **Revision history**: track all changes
- **Pause/resume**: control update progression

### The Deployment → ReplicaSet → Pod Hierarchy

```
Deployment (webapp-deployment)
    │
    ├── ReplicaSet v1 (webapp-deployment-7d8f9b4c6)   ← Old RS (scaled to 0)
    │       └── [pods deleted]
    │
    └── ReplicaSet v2 (webapp-deployment-9c7b2a1d3)   ← Current RS (3 replicas)
            ├── Pod 1 (webapp-deployment-9c7b2a1d3-xk2p9)
            ├── Pod 2 (webapp-deployment-9c7b2a1d3-m7n4l)
            └── Pod 3 (webapp-deployment-9c7b2a1d3-p5q8r)
```

**Each Deployment update creates a new ReplicaSet.** The old ReplicaSet is kept (scaled to 0) to enable rollbacks. This is why you see multiple ReplicaSets in production (`kubectl get rs`).

### Deployment Strategies

#### 1. RollingUpdate (Default)
Gradually replaces old pods with new ones. Zero downtime (assuming proper readiness probes).

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp-deployment
  namespace: production
  annotations:
    # Record change cause for rollout history
    kubernetes.io/change-cause: "Updated nginx from 1.21 to 1.23 - security patches"
spec:
  replicas: 6
  revisionHistoryLimit: 5  # Keep last 5 RS for rollback (default is 10)

  selector:
    matchLabels:
      app: webapp

  strategy:
    type: RollingUpdate
    rollingUpdate:
      # maxUnavailable: How many pods can be unavailable during update
      # Can be absolute number or percentage
      # PRODUCTION CONSIDERATION: Set based on your redundancy needs
      # If you have 3 replicas and set maxUnavailable: 1, you always have 2 running
      maxUnavailable: 1

      # maxSurge: How many extra pods can be created above desired count
      # Creates new pods before deleting old ones when maxUnavailable: 0
      # Temporarily uses more resources but ensures zero downtime
      maxSurge: 1

  template:
    metadata:
      labels:
        app: webapp
        version: "1.23.0"
    spec:
      containers:
      - name: webapp
        image: nginx:1.23.0  # Update this to trigger a rollout

        resources:
          requests:
            cpu: "250m"
            memory: "256Mi"
          limits:
            memory: "512Mi"
            cpu: "500m"

        readinessProbe:
          # CRITICAL for zero-downtime rolling updates!
          # Without this, new pod receives traffic before it's ready
          # causing HTTP 502/503 errors during deployments
          httpGet:
            path: /ready
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 5
          # Pod stays in "old RS's traffic" until new pods pass readiness
          # This is how Kubernetes ensures zero-downtime updates

        livenessProbe:
          httpGet:
            path: /health
            port: 80
          initialDelaySeconds: 15
          periodSeconds: 10
          # PRODUCTION ISSUE - CrashLoopBackOff during deployment:
          # If new version has a bug and liveness probe fails,
          # pods keep restarting. The deployment will PAUSE
          # (won't continue replacing old pods) if maxUnavailable is reached
          # This is actually GOOD — protects production
          # Command: kubectl rollout undo deployment/webapp-deployment
```

#### 2. Recreate Strategy

Kills ALL old pods first, then creates new ones. **Always causes downtime.** Use only when:
- Application cannot run two versions simultaneously (e.g., incompatible database migrations)
- Development/non-critical environments

```yaml
strategy:
  type: Recreate
  # NO rollingUpdate configuration needed
  # All pods will be terminated before new ones start
```

### Rolling Update Flow

```
Initial State: [v1] [v1] [v1] [v1] [v1] [v1]  (6 pods, maxUnavailable:1, maxSurge:1)

Step 1: Create 1 new v2 pod
[v1] [v1] [v1] [v1] [v1] [v1] [v2]  (7 pods total - surge)

Step 2: Wait for v2 pod to pass readiness probe

Step 3: Terminate 1 v1 pod
[v1] [v1] [v1] [v1] [v1] [v2]  (back to 6 pods)

Step 4: Repeat...

Final State: [v2] [v2] [v2] [v2] [v2] [v2]  (6 pods, all v2)
```

### Rollback Operations

```bash
# View rollout history
kubectl rollout history deployment/webapp-deployment

# View specific revision details
kubectl rollout history deployment/webapp-deployment --revision=3

# Rollback to previous version
kubectl rollout undo deployment/webapp-deployment

# Rollback to specific revision
kubectl rollout undo deployment/webapp-deployment --to-revision=2

# Check rollout status (great for CI/CD pipelines)
kubectl rollout status deployment/webapp-deployment
# Returns exit code 0 on success, non-zero on failure — perfect for pipeline gates

# Pause a rolling update (to manually inspect)
kubectl rollout pause deployment/webapp-deployment

# Resume after pausing
kubectl rollout resume deployment/webapp-deployment
```

> **CKA Exam Insight:** The exam frequently tests `kubectl rollout` commands. Know how to check status, view history, and perform rollbacks. The `--record` flag is deprecated but might appear — use annotations instead.

---

## 1.5 Services — Stable Networking for Pods

### Why Services Exist

Pods are **ephemeral**. When a Pod dies and is replaced, it gets a **new IP address**. Your application clients cannot rely on Pod IP addresses.

A Service provides a **stable, virtual IP address** (ClusterIP) and DNS name that forwards traffic to the currently running Pods matching its selector. This is fundamentally a **level of indirection** that decouples consumers from the volatile nature of Pods.

### How Services Work Internally

When a Service is created:
1. API Server assigns a ClusterIP from the service CIDR range
2. CoreDNS creates a DNS record: `service-name.namespace.svc.cluster.local → ClusterIP`
3. kube-proxy on every node creates **iptables rules** (or IPVS rules) that redirect traffic from ClusterIP to one of the matching Pod IPs

**kube-proxy in action:**
```
Client Pod → Service ClusterIP (10.96.0.50:80)
    │
    ▼ iptables/IPVS DNAT rule
    │
    ├── Pod 1 IP (10.244.1.5:8080)   ← randomly selected (default round-robin)
    ├── Pod 2 IP (10.244.2.3:8080)
    └── Pod 3 IP (10.244.3.7:8080)
```

### Service Types

#### 1. ClusterIP (Default)

Only accessible **within the cluster**. Perfect for:
- Database services (MySQL, PostgreSQL, Redis)
- Internal microservices that only talk to each other
- Anything that should never be exposed externally

```yaml
apiVersion: v1
kind: Service
metadata:
  name: db-service
  namespace: production
spec:
  type: ClusterIP  # This is the default; you can omit this line
  selector:
    app: mysql
    tier: database
  ports:
  - protocol: TCP
    port: 3306       # Port clients use (Service port)
    targetPort: 3306  # Port the container listens on (Pod port)
    # These can be different! Example: port: 80, targetPort: 8080
    # This lets you change the container port without changing client configuration
```

#### 2. NodePort

Exposes the Service on a **specific port on every node** (range: 30000-32767). Traffic reaches the cluster through `NodeIP:NodePort`.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: webapp-nodeport
spec:
  type: NodePort
  selector:
    app: webapp
  ports:
  - protocol: TCP
    port: 80          # ClusterIP port (within cluster)
    targetPort: 8080  # Container port
    nodePort: 30080   # Port on each node (30000-32767)
                      # If omitted, Kubernetes auto-assigns one
```

**Production use of NodePort:** Typically used in:
- Bare-metal clusters where cloud LoadBalancers aren't available
- Development/testing environments
- When using a separate external load balancer (like HAProxy or F5) in front of cluster nodes

**NOT recommended** for production as the primary exposure mechanism because:
- Exposes all nodes' IPs
- Uses high port numbers (user-facing URLs look ugly)
- No built-in health checking at the load balancer level

#### 3. LoadBalancer

Creates a **cloud provider load balancer** (AWS ALB/NLB, GCP Load Balancer, Azure Load Balancer) that routes external traffic to the Service.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: webapp-lb
  namespace: production
  annotations:
    # AWS-specific annotations for NLB (Network Load Balancer)
    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
    service.beta.kubernetes.io/aws-load-balancer-internal: "false"
spec:
  type: LoadBalancer
  selector:
    app: webapp
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  # The cloud provider assigns an external IP (may take 1-2 minutes)
  # Check with: kubectl get service webapp-lb
  # Look for EXTERNAL-IP column
```

> **Production Tip:** In production EKS, use AWS Load Balancer Controller with Ingress instead of LoadBalancer services. Each LoadBalancer service creates a separate cloud LB which is expensive. Ingress shares one LB across multiple services.

#### 4. ExternalName

Maps a Service to an external DNS name. No proxying — just DNS CNAME record.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: external-db
  namespace: production
spec:
  type: ExternalName
  externalName: mydb.company.aws.rds.amazonaws.com
  # Now pods can use "external-db.production.svc.cluster.local"
  # and it resolves to the RDS endpoint
  # PRODUCTION USE: Great for migrating from external to internal DB
  # without changing application code
```

### Endpoints — Under the Hood

When you create a Service with a selector, Kubernetes automatically creates an **Endpoints** object that tracks the IPs of matching Pods:

```bash
kubectl get endpoints webapp-service
# Shows the actual pod IPs being load-balanced
NAME             ENDPOINTS                                    AGE
webapp-service   10.244.1.5:8080,10.244.2.3:8080,...        5m

# If endpoints is empty, either no pods match the selector or pods aren't ready
# This is a common debugging step when a service isn't routing traffic
```

---

## 1.6 Namespaces — Logical Cluster Isolation

### What Are Namespaces?

Namespaces provide **logical separation** within a Kubernetes cluster. They allow multiple teams, projects, or environments to share the same physical cluster infrastructure while maintaining isolation.

**Key characteristics:**
- Resources within a namespace are isolated from other namespaces
- Resource names must be unique within a namespace but can be duplicated across namespaces
- Some resources are **cluster-scoped** (nodes, PersistentVolumes, StorageClasses, ClusterRoles) and don't belong to any namespace

### Default Namespaces

Kubernetes creates four namespaces by default:

| Namespace | Purpose |
|-----------|---------|
| `default` | Where resources go when no namespace is specified |
| `kube-system` | Kubernetes system components (CoreDNS, kube-proxy, metrics-server) |
| `kube-public` | Publicly readable, for cluster info (rarely used) |
| `kube-node-lease` | Node heartbeat leases for efficient node health detection |

### Namespace DNS Resolution

```
Service: webapp-service in namespace: production
    │
    ├── Within same namespace:  webapp-service
    ├── From other namespace:   webapp-service.production
    ├── Short form (with DNS):  webapp-service.production.svc
    └── Fully Qualified:        webapp-service.production.svc.cluster.local
```

This DNS hierarchy allows services to reference each other across namespaces without hardcoding IPs.

### Production Namespace Strategy

In real production environments, namespaces are used for:
```
cluster
├── production          # Live workloads
├── staging             # Pre-production testing
├── development         # Developer sandbox
├── monitoring          # Prometheus, Grafana, Alertmanager
├── logging             # Elasticsearch, Fluentd, Kibana
└── kube-system         # Kubernetes system components
```

```yaml
# Namespace with resource quotas (production best practice)
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    environment: production
    team: platform
---
# ResourceQuota prevents one team from consuming all cluster resources
apiVersion: v1
kind: ResourceQuota
metadata:
  name: production-quota
  namespace: production
spec:
  hard:
    # Compute limits
    requests.cpu: "20"      # Total requested CPU across all pods
    requests.memory: 40Gi
    limits.cpu: "40"
    limits.memory: 80Gi
    # Object count limits
    pods: "100"
    services: "20"
    persistentvolumeclaims: "20"
    secrets: "50"
    configmaps: "50"
```

```bash
# Set default namespace for your kubectl context
kubectl config set-context --current --namespace=production

# Now kubectl get pods shows production namespace by default
kubectl get pods

# Cross-namespace operations
kubectl get pods -n kube-system
kubectl get pods --all-namespaces  # or -A
```

---

## 1.7 ConfigMaps & Secrets — Externalizing Configuration

### ConfigMaps — Non-Sensitive Configuration

ConfigMaps store **non-sensitive configuration data** as key-value pairs. The goal is to separate application code from environment-specific configuration — the **12-Factor App** principle.

**Why not hardcode config in container images?**
- Different environments (dev/staging/prod) need different values
- Rebuilding an image for every config change is slow and wasteful
- Changes should be deployable without touching the container image

```yaml
# ─── ConfigMap Definition ──────────────────────────────────────────
apiVersion: v1
kind: ConfigMap
metadata:
  name: webapp-config
  namespace: production
data:
  # Simple key-value pairs
  LOG_LEVEL: "INFO"
  APP_PORT: "8080"
  CACHE_TTL: "300"

  # Multi-line configuration file (great for nginx.conf, app.properties, etc.)
  nginx.conf: |
    server {
        listen 8080;
        location / {
            proxy_pass http://localhost:3000;
        }
    }
---
# ─── Pod using ConfigMap ──────────────────────────────────────────
apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  containers:
  - name: webapp
    image: myapp:1.0

    # Method 1: Load ALL ConfigMap keys as environment variables
    envFrom:
    - configMapRef:
        name: webapp-config

    # Method 2: Load specific key as environment variable
    env:
    - name: LOG_LEVEL       # Name in container (can differ from ConfigMap key)
      valueFrom:
        configMapKeyRef:
          name: webapp-config
          key: LOG_LEVEL

    # Method 3: Mount as file (best for config files)
    volumeMounts:
    - name: nginx-config
      mountPath: /etc/nginx/nginx.conf
      subPath: nginx.conf   # Mount only one key as a file (not the whole ConfigMap)
      # Without subPath, the whole mountPath directory is replaced by ConfigMap keys

  volumes:
  - name: nginx-config
    configMap:
      name: webapp-config
```

> **Production Consideration:** ConfigMaps mounted as volumes **automatically update** when the ConfigMap changes (within ~1 minute). Environment variables from ConfigMaps do **NOT** update automatically — the Pod must be restarted. This is important when doing live config updates.

### Secrets — Sensitive Configuration

Secrets store **sensitive data** (passwords, tokens, certificates) with base64 encoding. 

**Critical understanding:** Base64 is **NOT encryption**. It's just encoding. Anyone with access to the Secret can decode it. For true security:
- Enable **encryption at rest** in etcd (covered in Security section)
- Use **RBAC** to restrict who can read Secrets
- Consider external solutions (AWS Secrets Manager, HashiCorp Vault, Sealed Secrets)

```yaml
# Create a Secret declaratively
# ALWAYS use base64 encoded values
# echo -n 'mypassword' | base64
# → bXlwYXNzd29yZA==
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
  namespace: production
type: Opaque  # Generic secret type (most common)
             # Other types: kubernetes.io/tls, kubernetes.io/dockerconfigjson
data:
  DB_HOST: bXlzcWw=        # mysql
  DB_USER: cm9vdA==        # root
  DB_PASSWORD: bXlwYXNzd29yZA==  # mypassword
---
# Using Secrets in a Pod
apiVersion: v1
kind: Pod
metadata:
  name: app-with-secrets
spec:
  containers:
  - name: app
    image: myapp:1.0

    # Method 1: Inject as environment variables (simple but not most secure)
    envFrom:
    - secretRef:
        name: db-credentials

    # Method 2: Mount as files (more secure — processes can't see env vars of other processes)
    volumeMounts:
    - name: db-creds
      mountPath: /etc/secrets
      readOnly: true  # ALWAYS mount secrets read-only

  volumes:
  - name: db-creds
    secret:
      secretName: db-credentials
      # Each key becomes a file: /etc/secrets/DB_HOST, /etc/secrets/DB_PASSWORD, etc.
      # Application reads password from file instead of env var
      # More secure because env vars can be leaked in core dumps and /proc
```

```bash
# Create secrets imperatively (never logs the value — safer for CI/CD)
kubectl create secret generic db-credentials \
  --from-literal=DB_HOST=mysql \
  --from-literal=DB_PASSWORD=supersecret \
  --from-literal=DB_USER=root \
  -n production

# Create TLS secret
kubectl create secret tls tls-secret \
  --cert=server.crt \
  --key=server.key

# Create Docker registry secret
kubectl create secret docker-registry regcred \
  --docker-server=private.registry.io \
  --docker-username=admin \
  --docker-password=secret123 \
  --docker-email=admin@company.com
```

---

## 1.8 Resource Requirements, Limits & LimitRanges

### Understanding CPU and Memory Units

**CPU:**
- `1` = 1 CPU core = 1000m (millicores)
- `500m` = 0.5 CPU core
- `250m` = 0.25 CPU core (1/4 of a core)
- CPU is a **compressible resource** — if you exceed the limit, you're throttled (slowed down), NOT killed

**Memory:**
- `Mi` = Mebibytes (1 Mi = 1,048,576 bytes)
- `Gi` = Gibibytes
- `M` = Megabytes (1 M = 1,000,000 bytes)
- Memory is a **non-compressible resource** — if you exceed the limit, you're OOMKilled (container dies)

### Requests vs Limits

| | Requests | Limits |
|--|---------|--------|
| **Purpose** | Scheduling hint | Hard ceiling |
| **Who uses it** | kube-scheduler | Linux kernel (cgroups) |
| **What happens if exceeded** | N/A (not enforced at runtime) | CPU: throttled, Memory: OOMKilled |
| **Production best practice** | Always set | Set carefully |

### QoS Classes

Kubernetes uses requests/limits to assign **Quality of Service (QoS)** classes, which determine **which pods get killed first** when a node runs out of resources:

```
Guaranteed (last to be killed)
    → requests == limits for ALL containers
    
Burstable (middle priority)
    → at least one container has requests or limits set
    → requests != limits
    
BestEffort (first to be killed)
    → NO requests or limits set at all
    → Don't do this in production!
```

```yaml
# LimitRange — sets default limits for pods that don't specify them
# Prevents "BestEffort" pods from being created accidentally
apiVersion: v1
kind: LimitRange
metadata:
  name: default-limits
  namespace: production
spec:
  limits:
  - type: Container
    default:        # Default LIMIT if not specified
      cpu: "500m"
      memory: "256Mi"
    defaultRequest: # Default REQUEST if not specified
      cpu: "100m"
      memory: "64Mi"
    max:            # Maximum limit allowed
      cpu: "2"
      memory: "2Gi"
    min:            # Minimum request allowed
      cpu: "50m"
      memory: "32Mi"
```

> **CKA Exam Insight:** Know the QoS classes and which pods get evicted first. This comes up in scheduling and resource management questions.

---

## 1.9 Taints, Tolerations & Node Affinity — Advanced Scheduling

### Taints & Tolerations

**Taints** are applied to nodes to **repel** pods. **Tolerations** are applied to pods to **override** taints, allowing the pod to be scheduled on the tainted node.

**Mental model:** A taint is like a "no entry" sign on a node. A toleration is like a special pass that lets a pod ignore that sign.

**Effects:**
- `NoSchedule`: New pods won't be scheduled (existing pods unaffected)
- `PreferNoSchedule`: Try to avoid scheduling here, but it's not mandatory
- `NoExecute`: New pods won't be scheduled AND existing pods without toleration are evicted

```bash
# Add taint to a node (dedicated GPU node)
kubectl taint nodes gpu-node-1 hardware=gpu:NoSchedule

# Remove taint (append dash -)
kubectl taint nodes gpu-node-1 hardware=gpu:NoSchedule-

# View node taints
kubectl describe node gpu-node-1 | grep Taints
```

```yaml
# Pod with toleration to run on GPU node
apiVersion: v1
kind: Pod
metadata:
  name: ml-training-job
spec:
  # Toleration allows this pod to LAND on the tainted node
  tolerations:
  - key: "hardware"
    operator: "Equal"
    value: "gpu"
    effect: "NoSchedule"

  # But toleration alone doesn't GUARANTEE placement on the GPU node!
  # Use nodeSelector or nodeAffinity to FORCE placement
  nodeSelector:
    hardware: gpu

  containers:
  - name: training
    image: tensorflow:latest
    resources:
      limits:
        nvidia.com/gpu: 1  # Request a GPU resource
```

**Important distinction:** Taints/tolerations control WHICH nodes a pod CAN run on. They don't guarantee a pod WILL run on a specific node. Combine with node affinity for full control.

### Node Affinity

Node affinity is a **more expressive** way to constrain pod scheduling based on node labels. It replaces `nodeSelector` with support for logical operators.

```yaml
spec:
  affinity:
    nodeAffinity:
      # required: MUST match — pod won't schedule if no node matches
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: kubernetes.io/e2e-az-name
            operator: In
            values:
            - us-east-1a
            - us-east-1b
          - key: instance-type
            operator: In
            values:
            - m5.large
            - m5.xlarge

      # preferred: prefer these nodes, but it's not mandatory
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 80  # Higher weight = stronger preference (1-100)
        preference:
          matchExpressions:
          - key: disk-type
            operator: In
            values:
            - ssd
      - weight: 20
        preference:
          matchExpressions:
          - key: network-speed
            operator: In
            values:
            - 10gbps
```

### Pod Affinity & Anti-Affinity

Control pod placement **relative to other pods** (not just nodes).

```yaml
spec:
  affinity:
    # Pod Anti-Affinity: Spread pods across nodes/zones for HA
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
          - key: app
            operator: In
            values:
            - webapp
        topologyKey: kubernetes.io/hostname
        # This means: Don't put two pods with app=webapp on the same NODE
        # Use "topology.kubernetes.io/zone" to spread across availability zones

    # Pod Affinity: Co-locate pods for performance (e.g., app + cache)
    podAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              app: redis-cache
          topologyKey: kubernetes.io/hostname
          # Prefer to be on the same node as redis-cache for low latency
```

---

## 1.10 DaemonSets, Static Pods & Multiple Schedulers

### DaemonSets

A DaemonSet ensures that **one copy of a pod runs on every node** (or every node matching a selector). When new nodes are added, the DaemonSet automatically adds a pod. When nodes are removed, those pods are garbage-collected.

**Production use cases:**
- Log collectors (Fluentd, Filebeat)
- Node monitoring agents (Prometheus node-exporter, Datadog agent)
- Network plugins (Calico, Weave Net)
- Storage daemons (Ceph, GlusterFS)

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitoring
spec:
  selector:
    matchLabels:
      name: node-exporter

  template:
    metadata:
      labels:
        name: node-exporter
    spec:
      # Run on all nodes including master/control-plane nodes
      tolerations:
      - key: node-role.kubernetes.io/control-plane
        operator: Exists
        effect: NoSchedule

      hostNetwork: true  # Use host network for node-level metrics
      hostPID: true      # Access host processes

      containers:
      - name: node-exporter
        image: prom/node-exporter:v1.5.0
        ports:
        - containerPort: 9100
          hostPort: 9100  # Binds to the node's network interface

        resources:
          requests:
            cpu: "50m"
            memory: "30Mi"
          limits:
            memory: "100Mi"
            cpu: "200m"
```

### Static Pods

Static Pods are pods managed **directly by the kubelet** on a specific node, without the API Server's involvement. They are defined as YAML files in a specific directory on the node (default: `/etc/kubernetes/manifests/`).

**Why they exist:** The Kubernetes control plane components themselves (kube-apiserver, etcd, kube-controller-manager, kube-scheduler) run as Static Pods! This is elegant — the cluster manages itself using its own primitives.

**Key characteristics:**
- Kubelet reads files from the manifest directory and creates the pods
- If you delete a static pod via kubectl, the kubelet immediately recreates it (because the file still exists)
- To truly delete a static pod, remove the YAML file from the manifest directory
- Static pod files are readable via API Server (mirror pods), but changes via kubectl are ignored

```bash
# Location of static pod manifests on control-plane node
ls /etc/kubernetes/manifests/
# etcd.yaml
# kube-apiserver.yaml
# kube-controller-manager.yaml
# kube-scheduler.yaml

# Modify a control plane component (e.g., add a flag to kube-apiserver)
# 1. Edit the file
sudo vim /etc/kubernetes/manifests/kube-apiserver.yaml

# 2. kubelet detects the change and recreates the pod automatically
# Wait ~30-60 seconds for the pod to restart

# Create your own static pod
# Place a pod YAML in /etc/kubernetes/manifests/
# The kubelet will create it automatically
```

> **CKA Exam Insight:** Static pods and their manifest directory location frequently appear in exam troubleshooting scenarios. Know how to find the manifest directory from kubelet config.

```bash
# Find static pod manifest directory
systemctl status kubelet
# OR
cat /var/lib/kubelet/config.yaml | grep staticPodPath
```

---

## 1.11 Monitoring & Metrics Server

### Kubernetes Monitoring Stack

```
Node (kubelet with cAdvisor)
    │ exposes container metrics
    ▼
Metrics Server (aggregates in-memory)
    │ serves /metrics endpoint
    ▼
kubectl top commands / HPA / VPA
```

The **Metrics Server** is a lightweight, in-memory aggregator of resource metrics from kubelets. It's required for `kubectl top` commands and Horizontal Pod Autoscaling.

```bash
# Install Metrics Server (kubeadm clusters)
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Check node resource usage
kubectl top nodes
# NAME          CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
# node-1        245m         12%    3456Mi          44%

# Check pod resource usage
kubectl top pods -n production
# NAME                     CPU(cores)   MEMORY(bytes)
# webapp-7d8f9b4c6-xk2p9   45m          128Mi

# Sort by CPU
kubectl top pods --sort-by=cpu

# Sort by memory
kubectl top pods --sort-by=memory
```

> **CKA Exam Insight:** Metrics Server is frequently tested. You need to know how to install it and use `kubectl top` to identify resource-hungry pods.

---

# PART 2: LOGGING, LIFECYCLE MANAGEMENT & CLUSTER MAINTENANCE

---

## 2.1 Managing Application Logs

### Docker vs Kubernetes Logging

**In Docker:** Logs go to stdout/stderr. Access with `docker logs container-id`.

**In Kubernetes:** The kubelet collects container logs (from stdout/stderr) and stores them on the node at `/var/log/pods/` and `/var/log/containers/`. `kubectl logs` reads these files.

### kubectl logs Command

```bash
# Get logs from a single-container pod
kubectl logs webapp-pod

# Follow (tail -f) logs in real-time
kubectl logs -f webapp-pod

# Get last 100 lines
kubectl logs --tail=100 webapp-pod

# Get logs from specific time period
kubectl logs --since=1h webapp-pod

# Get logs from previous container instance (if it crashed)
# CRITICAL for debugging CrashLoopBackOff!
kubectl logs webapp-pod --previous

# Multi-container pod: specify container name
kubectl logs webapp-pod -c nginx

# Get logs from all pods matching a label selector
kubectl logs -l app=webapp --all-containers=true

# Get logs from a specific namespace
kubectl logs -n production webapp-pod
```

### Production Logging Architecture

In production, you don't rely on `kubectl logs` for long-term log retention. The typical stack:

```
Container (stdout/stderr)
    │
    ▼
Node (kubelet captures → /var/log/pods/)
    │
    ▼ DaemonSet (Fluentd/Filebeat/Fluent Bit)
    │
    ▼
Log Aggregation (Elasticsearch/Loki/CloudWatch)
    │
    ▼
Visualization (Kibana/Grafana)
```

---

## 2.2 Rolling Updates, Rollbacks & Deployment Strategies

*(Covered in detail in Section 1.4)*

### Additional Production Commands

```bash
# Trigger a rollout without changing image (useful to pick up new ConfigMap)
kubectl rollout restart deployment/webapp-deployment

# Check if a deployment is complete (useful in CI/CD pipelines)
kubectl rollout status deployment/webapp-deployment --timeout=5m
# Exits 0 if successful, non-zero if timeout or error

# Check deployment events (great for debugging stuck rollouts)
kubectl describe deployment webapp-deployment | tail -20
```

---

## 2.3 Commands & Arguments — Docker vs Kubernetes

### Understanding ENTRYPOINT and CMD in Docker

This is a **frequently misunderstood** concept that directly affects pod configuration.

**In a Dockerfile:**
- `ENTRYPOINT` — the executable to run (like the program name)
- `CMD` — default arguments to the ENTRYPOINT (can be overridden)

```dockerfile
FROM ubuntu
ENTRYPOINT ["sleep"]  # The program
CMD ["5"]             # Default argument (sleep for 5 seconds)
```

Running `docker run ubuntu-sleeper` → runs `sleep 5`
Running `docker run ubuntu-sleeper 10` → runs `sleep 10` (CMD overridden)
Running `docker run --entrypoint sleep2.0 ubuntu-sleeper 10` → runs `sleep2.0 10`

### In Kubernetes Pod Spec

The mapping is:

| Dockerfile | Kubernetes pod spec |
|-----------|-------------------|
| `ENTRYPOINT` | `command` |
| `CMD` | `args` |

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-sleeper
spec:
  containers:
  - name: ubuntu
    image: ubuntu-sleeper  # Has ENTRYPOINT: ["sleep"], CMD: ["5"]

    # Override CMD (args) only — run "sleep 10" instead of "sleep 5"
    args: ["10"]

    # Override both ENTRYPOINT and CMD
    command: ["sleep2.0"]  # New ENTRYPOINT
    args: ["10"]           # New CMD

    # Note: 'command' COMPLETELY REPLACES the Docker ENTRYPOINT
    # 'args' COMPLETELY REPLACES the Docker CMD
```

> **CKA Exam Insight:** This Docker-to-Kubernetes mapping is a very common exam question. The trick is that Kubernetes uses `command` for ENTRYPOINT and `args` for CMD — which is the opposite of what you might intuitively expect.

---

## 2.4 Secrets Management & Encryption at Rest

### Why Base64 is NOT Security

```bash
echo "c3VwZXJzZWNyZXQ=" | base64 --decode
# Output: supersecret
```

Anyone with RBAC access to get Secrets can decode the values instantly. This is why **encryption at rest** is critical.

### Enabling Encryption at Rest

```bash
# Step 1: Generate a 32-byte encryption key
head -c 32 /dev/urandom | base64
# Example output: y0xTt+U6xgRdNxe4nDYYsijOGgRDoUYC+wAwOKeNfPs=
```

```yaml
# /etc/kubernetes/enc/enc.yaml — Encryption Configuration
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
    - secrets
    providers:
    # First provider is used for NEW secrets (encryption)
    - aescbc:
        keys:
        - name: key1
          secret: y0xTt+U6xgRdNxe4nDYYsijOGgRDoUYC+wAwOKeNfPs=
    # Identity provider = plaintext (for reading OLD unencrypted secrets)
    - identity: {}
    # IMPORTANT: Order matters!
    # Put identity first if you want to decrypt old secrets
    # Put aescbc first to encrypt new secrets
```

```yaml
# Add to kube-apiserver static pod manifest
# /etc/kubernetes/manifests/kube-apiserver.yaml
spec:
  containers:
  - command:
    - kube-apiserver
    - --encryption-provider-config=/etc/kubernetes/enc/enc.yaml  # ADD THIS
    volumeMounts:
    - name: enc
      mountPath: /etc/kubernetes/enc
      readOnly: true
  volumes:
  - name: enc
    hostPath:
      path: /etc/kubernetes/enc
      type: DirectoryOrCreate
```

```bash
# After enabling encryption, re-encrypt all existing secrets
kubectl get secret --all-namespaces -o json | kubectl replace -f -

# Verify encryption by checking etcd directly
ETCDCTL_API=3 etcdctl \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  get /registry/secrets/default/my-secret | hexdump -C
# If encrypted: data should look like gibberish, not readable text
```

---

## 2.5 Multi-Container Pods — Sidecar Patterns

### When to Use Multiple Containers in a Pod

Multi-container pods make sense when containers are **tightly coupled** and must:
- Share the same lifecycle
- Communicate via localhost (same network namespace)
- Share volumes for data exchange

### Common Patterns

**1. Sidecar Pattern** — Enhances/extends the main container
```
Main App Container  ←→  Sidecar (Envoy proxy, log forwarder, vault agent)
```

**2. Init Container** — Runs before the main container starts
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: webapp-with-init
spec:
  # Init containers run SEQUENTIALLY before app containers start
  # If an init container fails, the pod restarts until it succeeds
  initContainers:
  - name: wait-for-db
    image: busybox:1.35
    command:
    - sh
    - -c
    - |
      until nc -z mysql-service 3306; do
        echo "Waiting for database..."
        sleep 2
      done
      echo "Database is ready!"
    # This prevents the main app from starting before the DB is available
    # Fixes "connection refused" errors on startup in microservices

  - name: db-migration
    image: myapp-migrate:1.0
    command: ["python", "manage.py", "migrate"]
    # Run database migrations before starting the app
    # Ensures schema is up-to-date before app starts serving

  containers:
  - name: webapp
    image: myapp:1.0
    # Only starts after ALL init containers complete successfully
```

**3. Ambassador Pattern** — Proxy for external services
```yaml
spec:
  containers:
  - name: app
    image: myapp:1.0
    # App talks to localhost:6379 (Redis proxy)

  - name: redis-ambassador
    image: haproxy:2.6
    # Proxy that handles Redis cluster routing
    # App doesn't need to know about Redis cluster details
```

**4. Adapter Pattern** — Transforms output format
```yaml
spec:
  containers:
  - name: app
    image: legacy-app:1.0
    # Outputs logs in non-standard format

  - name: log-adapter
    image: log-formatter:1.0
    # Reads app's log volume, transforms to JSON, ships to ELK
    volumeMounts:
    - name: log-volume
      mountPath: /var/log/app
```

---

## 2.6 Horizontal & Vertical Pod Autoscaling

### Horizontal Pod Autoscaler (HPA)

The HPA automatically scales the number of pod replicas based on observed metrics (CPU, memory, or custom metrics).

**How it works:**
1. HPA controller queries Metrics Server every 15 seconds (configurable)
2. Calculates `desiredReplicas = ceil[currentReplicas × (currentMetricValue / desiredMetricValue)]`
3. If desired != current, updates the Deployment's replica count

```yaml
# Deployment with explicit resource limits (required for HPA!)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
spec:
  replicas: 2  # Starting point — HPA will override this
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
      - name: webapp
        image: myapp:1.0
        resources:
          requests:
            cpu: "250m"   # REQUIRED: HPA uses this to calculate utilization %
          limits:
            cpu: "500m"
---
# HPA Definition
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: webapp-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: webapp

  minReplicas: 2   # Never scale below 2 (HA guarantee)
  maxReplicas: 20  # Never scale above 20 (cost control)

  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70  # Scale up when avg CPU > 70% of REQUEST
        # At 70% utilization: HPA will add replicas
        # At <70% for extended period: HPA will remove replicas

  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80

  behavior:
    scaleDown:
      # Prevent scale-down flapping
      stabilizationWindowSeconds: 300  # Wait 5 min before scaling down
      policies:
      - type: Percent
        value: 50
        periodSeconds: 60  # Can remove at most 50% of pods per minute
    scaleUp:
      stabilizationWindowSeconds: 60   # Scale up faster (60s window)
```

```bash
# Create HPA imperatively
kubectl autoscale deployment webapp --cpu-percent=70 --min=2 --max=20

# Check HPA status
kubectl get hpa
kubectl describe hpa webapp-hpa

# HPA requires metrics-server to be installed!
# Without it: HPA shows "unknown" for current metrics
```

---

## 2.7 OS Upgrades — Drain, Cordon & Uncordon

### Node Maintenance Workflow

When you need to take a node offline for OS patching, kernel upgrades, or hardware maintenance:

```
1. Drain node (evict pods, cordon node)
    ↓
2. Perform maintenance
    ↓
3. Uncordon node (allow scheduling)
    ↓
4. Verify node is healthy
```

### Drain vs Cordon

| Command | What It Does |
|---------|-------------|
| `kubectl cordon node-1` | Mark node as unschedulable. NO new pods. Existing pods keep running. |
| `kubectl drain node-1` | Mark as unschedulable + gracefully evict all pods from node |
| `kubectl uncordon node-1` | Remove unschedulable mark. New pods can now be scheduled. |

```bash
# Step 1: Drain the node
# --ignore-daemonsets: DaemonSets can't be drained (they're tied to the node)
# --delete-emptydir-data: Delete pods using emptyDir volumes (data is lost!)
kubectl drain node-1 \
  --ignore-daemonsets \
  --delete-emptydir-data \
  --grace-period=30

# If drain is stuck (pods with PodDisruptionBudget, local storage, etc.)
kubectl drain node-1 --ignore-daemonsets --force

# Step 2: Do your maintenance on node-1...

# Step 3: Bring node back and allow scheduling
kubectl uncordon node-1

# Step 4: Verify node is Ready
kubectl get nodes

# Pods do NOT automatically move back! They'll be scheduled on the uncordoned
# node only when new pods are created or existing pods are rescheduled
```

### Pod Disruption Budgets (PDB)

PDBs ensure that drain operations don't take down too many pods at once:

```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: webapp-pdb
spec:
  minAvailable: 2    # Always keep at least 2 pods running during disruptions
  # OR: maxUnavailable: 1  (at most 1 pod can be unavailable)
  selector:
    matchLabels:
      app: webapp
# With this PDB, drain will block until it can remove a pod while
# keeping 2 running. Great for HA production workloads.
```

---

## 2.8 Cluster Upgrade with kubeadm

### Upgrade Strategy

Kubernetes follows a **N-2 support policy** — only the three most recent minor versions are supported. Always upgrade one minor version at a time (1.27 → 1.28 → 1.29, not 1.27 → 1.29).

### Control Plane Upgrade Process

```bash
# ─── ON CONTROL PLANE NODE ───────────────────────────────────────

# Step 1: Update package repository to new version
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | \
sudo tee /etc/apt/sources.list.d/kubernetes.list

# Fetch new GPG key
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | \
sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

sudo apt-get update

# Step 2: See available versions
sudo apt-cache madison kubeadm

# Step 3: Upgrade kubeadm first (always upgrade kubeadm before applying)
sudo apt-mark unhold kubeadm
sudo apt-get install -y kubeadm=1.29.3-1.1
sudo apt-mark hold kubeadm

# Verify kubeadm version
kubeadm version

# Step 4: Check upgrade plan
sudo kubeadm upgrade plan
# Shows what will be upgraded and what needs manual action (kubelet)

# Step 5: Apply the upgrade
sudo kubeadm upgrade apply v1.29.3
# This upgrades: kube-apiserver, kube-controller-manager, kube-scheduler,
# kube-proxy, CoreDNS, etcd

# Step 6: Drain control plane node
kubectl drain controlplane --ignore-daemonsets

# Step 7: Upgrade kubelet and kubectl
sudo apt-mark unhold kubelet kubectl
sudo apt-get install -y kubelet=1.29.3-1.1 kubectl=1.29.3-1.1
sudo apt-mark hold kubelet kubectl

# Restart kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# Step 8: Uncordon control plane
kubectl uncordon controlplane
```

### Worker Node Upgrade Process

Repeat for each worker node:

```bash
# ─── ON CONTROL PLANE: drain the worker ─────────────────────────
kubectl drain node-1 --ignore-daemonsets

# ─── SSH INTO THE WORKER NODE ────────────────────────────────────

# Update repos and upgrade kubeadm
sudo apt-get update
sudo apt-mark unhold kubeadm
sudo apt-get install -y kubeadm=1.29.3-1.1
sudo apt-mark hold kubeadm

# Update node configuration
sudo kubeadm upgrade node

# Upgrade kubelet and kubectl
sudo apt-mark unhold kubelet kubectl
sudo apt-get install -y kubelet=1.29.3-1.1 kubectl=1.29.3-1.1
sudo apt-mark hold kubelet kubectl

sudo systemctl daemon-reload
sudo systemctl restart kubelet

# ─── ON CONTROL PLANE: uncordon the worker ───────────────────────
kubectl uncordon node-1

# Verify
kubectl get nodes
```

---

## 2.9 Backup & Restore — etcd & Cluster State

### What to Backup

| Backup Type | Method | Coverage |
|------------|--------|----------|
| Declarative manifests | Git repository | Best — covers all resources |
| API Server state | `kubectl get all -o yaml` | All runtime objects |
| etcd snapshot | `etcdctl snapshot save` | Complete cluster state |

### etcd Backup

```bash
# Create etcd snapshot
ETCDCTL_API=3 etcdctl snapshot save /opt/etcd-backup.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key

# Verify snapshot
ETCDCTL_API=3 etcdctl snapshot status /opt/etcd-backup.db \
  --write-out=table
# +----------+----------+------------+------------+
# |   HASH   | REVISION | TOTAL KEYS | TOTAL SIZE |
# +----------+----------+------------+------------+
# | c87a02a5 |     9124 |        817 |     4.2 MB |
# +----------+----------+------------+------------+
```

### etcd Restore

```bash
# Step 1: Stop the kube-apiserver (or remove its static pod manifest temporarily)
# If kubeadm: move kube-apiserver.yaml out of /etc/kubernetes/manifests/

# Step 2: Restore snapshot to new data directory
ETCDCTL_API=3 etcdctl snapshot restore /opt/etcd-backup.db \
  --data-dir=/var/lib/etcd-restored \
  --initial-cluster=master=https://127.0.0.1:2380 \
  --initial-cluster-token=etcd-cluster-new \
  --initial-advertise-peer-urls=https://127.0.0.1:2380

# Step 3: Update etcd config to use new data directory
# Edit /etc/kubernetes/manifests/etcd.yaml
# Change --data-dir=/var/lib/etcd to --data-dir=/var/lib/etcd-restored
# Also update the hostPath volume to point to the new directory

# Step 4: Start etcd with new data directory
# (if static pod, move etcd.yaml back to /etc/kubernetes/manifests/)

# Step 5: Restore kube-apiserver
# (move kube-apiserver.yaml back)

# Step 6: Verify cluster state
kubectl get nodes
kubectl get pods --all-namespaces
```

> **CKA Exam Insight:** The etcd backup and restore is a common hands-on exam task. Know the exact `etcdctl` flags, especially `--cacert`, `--cert`, `--key`, and `--endpoints`. The endpoint is almost always `https://127.0.0.1:2379`.

---

# PART 3: SECURITY & STORAGE

---

## 3.1 Kubernetes Security Architecture

### Security Layers

```
Request Flow → Authentication → Authorization → Admission Control
                 "Who are you?"   "Can you do this?"  "Is this request valid?"
```

**1. Authentication:** Proves identity. Who is making this request?
**2. Authorization:** Proves permission. Is this identity allowed to perform this action?
**3. Admission Control:** Validates/mutates the request. Is the request well-formed and policy-compliant?

### Security Best Practices Architecture

```
External
    │
    ▼
┌─────────────────────────────────────────────────────────┐
│  Network Boundary (firewall, security groups)            │
│  ┌─────────────────────────────────────────────────┐    │
│  │  Kubernetes API Server                           │    │
│  │  ├── Authentication (certs, tokens, OIDC)       │    │
│  │  ├── Authorization (RBAC)                       │    │
│  │  └── Admission Controllers                      │    │
│  └─────────────────���───────────────────────────────┘    │
│  ┌─────────────────────────────────────────────────┐    │
│  │  Worker Nodes                                   │    │
│  │  ├── Pod Security (Security Contexts, PSA)     │    │
│  │  ├── Network Policies                          │    │
│  │  └── Container Runtime Security (seccomp)      │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
```

---

## 3.2 Authentication — Who Are You?

### Authentication Methods

Kubernetes **does not have a user database**. Users are authenticated via:

1. **Client Certificates (X.509)** — Most common for admin access
2. **Bearer Tokens** — Used by service accounts and OIDC
3. **OpenID Connect (OIDC)** — Enterprise SSO (Google, Azure AD, Okta)
4. **Webhook Token Authentication** — Custom auth via external service

### Certificate-Based Authentication Flow

```
1. Admin creates private key:
   openssl genrsa -out jane.key 2048

2. Create Certificate Signing Request (CSR):
   openssl req -new -key jane.key -subj "/CN=jane/O=developers" -out jane.csr

3. Submit CSR to Kubernetes:
   # Base64 encode the CSR
   cat jane.csr | base64 -w 0

4. Create Kubernetes CertificateSigningRequest object

5. Admin approves:
   kubectl certificate approve jane

6. Extract signed certificate:
   kubectl get csr jane -o jsonpath='{.status.certificate}' | base64 --decode > jane.crt

7. User uses cert to authenticate:
   kubectl get pods --client-certificate=jane.crt --client-key=jane.key
```

```yaml
# CertificateSigningRequest object
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: jane
spec:
  expirationSeconds: 86400  # 24 hours
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS4uLg==  # base64 encoded CSR
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
```

```bash
# Certificate lifecycle management
kubectl get csr
kubectl certificate approve jane
kubectl certificate deny mallory
```

---

## 3.3 TLS Certificates — Deep Dive

### Certificate Hierarchy in Kubernetes

```
Cluster CA (ca.crt / ca.key)
    │
    ├── kube-apiserver (apiserver.crt / apiserver.key)
    │       ├── Can also be used to authenticate etcd client
    │       └── Can be used to authenticate kubelet client
    │
    ├── etcd CA / etcd Server (etcd/server.crt / etcd/server.key)
    │
    ├── kubelet (kubelet.crt / kubelet.key)  [per node]
    │
    ├── kube-scheduler (scheduler.crt / scheduler.key)
    │
    ├── kube-controller-manager (controller-manager.crt)
    │
    └── Admin User (admin.crt / admin.key)
```

### Certificate Locations (kubeadm cluster)

```bash
# All PKI files are in:
ls /etc/kubernetes/pki/

# Key files:
# ca.crt / ca.key                              - Cluster CA
# apiserver.crt / apiserver.key                - API Server cert
# apiserver-etcd-client.crt/key                - API Server → etcd auth
# apiserver-kubelet-client.crt/key             - API Server → kubelet auth
# front-proxy-ca.crt / front-proxy-client.crt  - API aggregation layer
# etcd/ca.crt                                  - etcd CA
# etcd/server.crt / etcd/server.key            - etcd server cert

# Inspect a certificate
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout | grep -E "(Subject|Issuer|Not After|DNS:)"
```

### Troubleshooting Certificate Issues

```bash
# Check certificate expiry
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -noout -enddate

# kubeadm can show cert expiry
kubeadm certs check-expiration

# Renew certificates (kubeadm)
kubeadm certs renew all

# If API server is broken (can't kubectl), check logs via:
crictl logs $(crictl ps | grep kube-apiserver | awk '{print $1}')
# OR
journalctl -u kubelet | grep -i error
```

---

## 3.4 KubeConfig — Credential Management

### KubeConfig Structure

```yaml
# ~/.kube/config (default location)
apiVersion: v1
kind: Config
current-context: production-admin@production-cluster  # Active context

# CLUSTERS section: Where are the clusters?
clusters:
- name: production-cluster
  cluster:
    server: https://prod-k8s.company.com:6443
    certificate-authority-data: LS0tLS1CRUdJTi...  # CA cert (base64)

- name: staging-cluster
  cluster:
    server: https://staging-k8s.company.com:6443
    certificate-authority-data: LS0tLS1CRUdJTi...

# USERS section: Who am I?
users:
- name: production-admin
  user:
    client-certificate-data: LS0tLS1CRUdJTi...  # User cert (base64)
    client-key-data: LS0tLS1CRUdJTi...          # User key (base64)

- name: developer-jane
  user:
    client-certificate-data: LS0tLS1CRUdJTi...
    client-key-data: LS0tLS1CRUdJTi...

# CONTEXTS section: Cluster + User + (optional) Namespace combination
contexts:
- name: production-admin@production-cluster
  context:
    cluster: production-cluster
    user: production-admin
    namespace: production  # Optional default namespace

- name: jane@staging
  context:
    cluster: staging-cluster
    user: developer-jane
    namespace: default
```

### KubeConfig Operations

```bash
# View current config
kubectl config view

# View specific file
kubectl config view --kubeconfig=/path/to/custom/config

# List all contexts
kubectl config get-contexts

# Switch context
kubectl config use-context jane@staging

# Set default namespace for current context
kubectl config set-context --current --namespace=production

# Add a new context
kubectl config set-context dev-context \
  --cluster=dev-cluster \
  --user=developer \
  --namespace=dev

# Using a specific kubeconfig file (overrides default)
kubectl get pods --kubeconfig=/path/to/admin.conf
# OR
export KUBECONFIG=/path/to/admin.conf
kubectl get pods
```

---

## 3.5 RBAC — Role-Based Access Control

### RBAC Concepts

RBAC controls **who can do what to which resources**:
- **Role**: A set of permissions within a namespace
- **ClusterRole**: A set of permissions cluster-wide (or namespace-scoped for cluster-wide resources)
- **RoleBinding**: Assigns a Role to a user/group/serviceaccount in a namespace
- **ClusterRoleBinding**: Assigns a ClusterRole to a user/group/serviceaccount cluster-wide

### Permission Model

```
Subject (who)        Verb (what)      Resource (on what)
user: jane       →   get, list    →   pods
group: devs      →   create       →   deployments
serviceaccount   →   watch        →   services
```

```yaml
# ─── Role (namespace-scoped) ─────────────────────────────────────
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer-role
  namespace: production   # Only valid in this namespace
rules:
# Rule 1: Full pod management
- apiGroups: [""]         # "" = core API group (pods, services, configmaps, etc.)
  resources: ["pods", "pods/log", "pods/exec"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]

# Rule 2: Read-only on ConfigMaps
- apiGroups: [""]
  resources: ["configmaps"]
  verbs: ["get", "list"]

# Rule 3: Manage Deployments (in apps API group)
- apiGroups: ["apps"]
  resources: ["deployments", "replicasets"]
  verbs: ["get", "list", "watch", "create", "update", "patch"]

# Rule 4: Access to specific pods only (by name)
- apiGroups: [""]
  resources: ["pods"]
  resourceNames: ["blue-pod", "green-pod"]  # Only these specific pods
  verbs: ["get", "exec"]
---
# ─── RoleBinding ─────────────────────────────────────────────────
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developer-binding
  namespace: production
subjects:
- kind: User
  name: jane               # User (from certificate CN)
  apiGroup: rbac.authorization.k8s.io
- kind: Group
  name: developers         # Group (from certificate O field)
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role               # Bind to Role (not ClusterRole)
  name: developer-role
  apiGroup: rbac.authorization.k8s.io
---
# ─── ClusterRole ─────────────────────────────────────────────────
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-admin-readonly
rules:
- apiGroups: [""]
  resources: ["nodes", "persistentvolumes", "namespaces"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["apps"]
  resources: ["deployments", "replicasets", "daemonsets"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["storage.k8s.io"]
  resources: ["storageclasses"]
  verbs: ["get", "list"]
---
# ─── ClusterRoleBinding ──────────────────────────────────────────
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: readonly-binding
subjects:
- kind: User
  name: monitoring-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-admin-readonly
  apiGroup: rbac.authorization.k8s.io
```

### RBAC Debugging Commands

```bash
# Can I do X? (check your own permissions)
kubectl auth can-i create pods
kubectl auth can-i delete nodes
kubectl auth can-i get secrets -n production

# Can a specific user do X? (admin checking another user)
kubectl auth can-i create pods --as jane
kubectl auth can-i create pods --as jane --namespace production
kubectl auth can-i list secrets --as system:serviceaccount:default:myapp-sa

# List all permissions for current user
kubectl auth whoami

# List all role bindings in a namespace
kubectl get rolebindings -n production
kubectl describe rolebinding developer-binding -n production

# Check what a role allows
kubectl describe role developer-role -n production
```

> **CKA Exam Insight:** RBAC is heavily tested. Know how to: 1) Create Roles/ClusterRoles, 2) Bind them, 3) Verify with `auth can-i`, 4) The difference between Role (namespaced) and ClusterRole (cluster-wide). The API group for `pods` is `""` (empty string), for `deployments` it's `"apps"`.

---

## 3.6 Service Accounts — Machine Identity

### Service Accounts for Pods

While regular users are for humans, Service Accounts are **identities for pods** to authenticate with the Kubernetes API.

**Real production scenarios:**
- Jenkins pod needs to create/delete pods in specific namespaces
- Prometheus needs to list pods/services to scrape metrics
- External DNS needs to update DNS records when services change
- CI/CD pipelines running inside the cluster

```yaml
# Step 1: Create the Service Account
apiVersion: v1
kind: ServiceAccount
metadata:
  name: jenkins-sa
  namespace: cicd

---
# Step 2: Create Role with needed permissions
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: jenkins-role
  namespace: production
rules:
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["get", "list", "update", "patch"]

---
# Step 3: Bind Role to Service Account
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: jenkins-rolebinding
  namespace: production
subjects:
- kind: ServiceAccount
  name: jenkins-sa
  namespace: cicd  # Note: SA is in cicd namespace
roleRef:
  kind: Role
  name: jenkins-role
  apiGroup: rbac.authorization.k8s.io

---
# Step 4: Use Service Account in Pod
apiVersion: v1
kind: Pod
metadata:
  name: jenkins
  namespace: cicd
spec:
  serviceAccountName: jenkins-sa  # Mounts token automatically
  containers:
  - name: jenkins
    image: jenkins/jenkins:lts
```

### Default Service Account

Every namespace gets a `default` service account. Every pod that doesn't specify `serviceAccountName` uses this default SA.

**Security concern:** The default SA has minimal permissions, but it still has a token mounted. For stricter security:

```yaml
spec:
  automountServiceAccountToken: false  # Don't mount any token
  # Only needed if pod doesn't call Kubernetes API
```

### Kubernetes v1.22+ Token Changes

Before 1.22: SAs had non-expiring tokens stored as Secrets.
After 1.22: Tokens are generated via TokenRequest API — **time-limited, audience-bound, auto-rotated**.

```bash
# Generate a short-lived token for a SA (new way)
kubectl create token jenkins-sa -n cicd --duration=1h

# View SA token (projected volume in pod)
kubectl exec jenkins-pod -- cat /var/run/secrets/kubernetes.io/serviceaccount/token
```

---

## 3.7 Network Policies — Zero-Trust Networking

### The Default: Allow Everything

By default, Kubernetes allows **all pods to communicate with all other pods** across all namespaces. This is the "all allow" default. For production security, this is unacceptable.

**Zero-trust networking principle:** Deny everything by default. Explicitly allow only necessary communication.

### Network Policy Architecture

```
Without Network Policy:
[Frontend] ←→ [API] ←→ [DB]    ← All can talk to all

With Network Policy:
[Frontend] → [API] → [DB]       ← Only these paths allowed
[Frontend] ✗ [DB]               ← Frontend cannot directly reach DB
```

```yaml
# ─── Step 1: Block ALL ingress to DB pods ─────────────────────────
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-deny-all
  namespace: production
spec:
  podSelector:
    matchLabels:
      tier: database
  policyTypes:
  - Ingress
  # NO ingress rules = deny all ingress traffic to DB pods

---
# ─── Step 2: Allow only API pods to reach DB ─────────────────────
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-allow-api
  namespace: production
spec:
  podSelector:
    matchLabels:
      tier: database
  policyTypes:
  - Ingress
  ingress:
  - from:
    # AND condition: both selectors must match
    - podSelector:
        matchLabels:
          tier: api
      namespaceSelector:
        matchLabels:
          name: production
    # This means: pod labeled tier=api IN namespace labeled name=production
    ports:
    - protocol: TCP
      port: 5432

---
# ─── Multiple Rules = OR condition ───────────────────────────────
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-allow-multiple
spec:
  podSelector:
    matchLabels:
      tier: database
  policyTypes:
  - Ingress
  ingress:
  - from:
    # Rule 1: API pods in production namespace
    - podSelector:
        matchLabels:
          tier: api
      namespaceSelector:
        matchLabels:
          name: production
    # Rule 2: Monitoring pods (for DB metrics scraping)
    - podSelector:
        matchLabels:
          app: prometheus
      namespaceSelector:
        matchLabels:
          name: monitoring
    # Rule 3: Specific external backup IP
    - ipBlock:
        cidr: 192.168.5.10/32
    ports:
    - protocol: TCP
      port: 5432

---
# ─── Egress Policy — DB sending backup to external server ────────
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-egress-backup
spec:
  podSelector:
    matchLabels:
      tier: database
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: 10.0.0.5/32  # Backup server IP
    ports:
    - protocol: TCP
      port: 443

  # Also allow DNS (CRITICAL! Without this, no hostname resolution)
  - to:
    - namespaceSelector:
        matchLabels:
          kubernetes.io/metadata.name: kube-system
    ports:
    - protocol: UDP
      port: 53
    - protocol: TCP
      port: 53
```

> **Critical Production Note:** Network Policies are only effective if your CNI plugin supports them. **Flannel does NOT support Network Policies**. Use Calico, Cilium, or Weave Net for policy enforcement. Always test with `kubectl exec` and curl/nc.

---

## 3.8 Image Security & Security Contexts

### Pulling from Private Registries

```bash
# Create registry credentials secret
kubectl create secret docker-registry regcred \
  --docker-server=registry.company.com \
  --docker-username=ci-user \
  --docker-password='P@ssw0rd!' \
  --docker-email=ci@company.com \
  -n production
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: private-app
spec:
  imagePullSecrets:
  - name: regcred   # Reference the registry secret
  containers:
  - name: app
    image: registry.company.com/myapp:1.0
    # PRODUCTION ISSUE - ImagePullBackOff:
    # Causes:
    #   1. Wrong image name or tag
    #   2. Wrong registry URL
    #   3. Missing or expired imagePullSecrets
    #   4. Registry unreachable from node
    # Debug: kubectl describe pod <name> → check Events section
    # Look for: "Failed to pull image"
```

### Security Contexts — Container Hardening

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
spec:
  # ─── Pod-level security ────────��──────────────────────────────
  securityContext:
    runAsNonRoot: true      # Don't run as root user
    runAsUser: 1000         # Run as UID 1000
    runAsGroup: 3000        # Run with GID 3000
    fsGroup: 2000           # Files created in volumes belong to GID 2000
    seccompProfile:
      type: RuntimeDefault  # Use default seccomp profile (blocks dangerous syscalls)

  containers:
  - name: app
    image: nginx:1.21
    # ─── Container-level security (overrides pod level) ──────────
    securityContext:
      allowPrivilegeEscalation: false  # Can't gain more privileges than parent
      readOnlyRootFilesystem: true     # Filesystem is read-only (great for security)
      capabilities:
        drop:
        - ALL              # Drop all Linux capabilities
        add:
        - NET_BIND_SERVICE  # Only add back what's needed (bind to port <1024)
        # NEVER add: NET_ADMIN, SYS_ADMIN, SYS_PTRACE in production

    # If root FS is read-only, apps that need to write should use volumes
    volumeMounts:
    - name: tmp-dir
      mountPath: /tmp
    - name: cache-dir
      mountPath: /var/cache/nginx

  volumes:
  - name: tmp-dir
    emptyDir: {}
  - name: cache-dir
    emptyDir: {}
```

---

## 3.9 Custom Resource Definitions & Operators

### What Are CRDs?

CRDs extend the Kubernetes API with **custom resource types**. They allow you to define domain-specific resources that Kubernetes can manage just like native resources.

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: flighttickets.flights.com  # Must follow: plural.group format
spec:
  group: flights.com
  scope: Namespaced
  names:
    plural: flighttickets
    singular: flightticket
    kind: FlightTicket
    shortNames:
    - ft
  versions:
  - name: v1
    served: true
    storage: true
    schema:
      openAPIV3Schema:
        type: object
        properties:
          spec:
            type: object
            properties:
              from:
                type: string
              to:
                type: string
              number:
                type: integer
                minimum: 1
                maximum: 10
```

```bash
# After creating CRD, you can use it like any native resource
kubectl apply -f flightticket.yaml
kubectl get flighttickets
kubectl get ft   # Using shortname
```

### Operators Pattern

An **Operator** = CRD + Custom Controller. The controller watches CRD objects and performs domain-specific operations.

**Famous operators in production:**
- **Prometheus Operator**: Manages Prometheus, Alertmanager, and ServiceMonitors
- **etcd Operator**: Manages etcd cluster lifecycle
- **cert-manager**: Automatically provisions TLS certificates
- **External DNS**: Manages DNS records based on Ingress/Service resources

---

## 3.10 Storage — PV, PVC & Storage Classes

### Storage Hierarchy

```
Storage Class (defines HOW to provision storage)
    │
    ▼
Persistent Volume (represents actual storage)
    │  (bound)
    ▼
Persistent Volume Claim (request for storage)
    │  (mounted)
    ▼
Pod (uses storage via volume mount)
```

### Static vs Dynamic Provisioning

**Static provisioning:** Admin creates PVs manually → user creates PVCs → Kubernetes binds matching PVC to PV.

**Dynamic provisioning:** User creates PVC with a StorageClass → StorageClass automatically creates a PV using a cloud/storage provisioner.

```yaml
# ─── StorageClass (defines storage "tier") ───────────────────────
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-ssd
provisioner: kubernetes.io/aws-ebs  # AWS EBS provisioner
parameters:
  type: gp3          # EBS volume type
  iopsPerGB: "50"
  encrypted: "true"
reclaimPolicy: Retain  # Delete or Retain PV when PVC is deleted
allowVolumeExpansion: true   # Allow PVC resize
volumeBindingMode: WaitForFirstConsumer  # Don't provision until Pod is scheduled
# WaitForFirstConsumer is critical for multi-AZ clusters!
# It ensures the volume is created in the same AZ as the pod

---
# ─── PersistentVolume (static) ────────────────────────────────────
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-postgres-data
spec:
  capacity:
    storage: 50Gi
  accessModes:
  - ReadWriteOnce    # Only one node can mount read-write (typical for block storage)
  # ReadOnlyMany     # Multiple nodes can mount read-only
  # ReadWriteMany    # Multiple nodes can mount read-write (requires NFS/EFS)

  persistentVolumeReclaimPolicy: Retain
  # Retain: Keep data after PVC deletion (admin must manually reclaim)
  # Delete: Delete underlying storage when PVC is deleted
  # Recycle: Deprecated (scrub and reuse)

  storageClassName: fast-ssd
  awsElasticBlockStore:
    volumeID: vol-0a1234567890abcdef
    fsType: ext4

---
# ─── PersistentVolumeClaim ────────────────────────────────────────
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-pvc
  namespace: production
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi   # Must be <= PV capacity for manual binding
  storageClassName: fast-ssd  # Triggers dynamic provisioning if no PV matches

---
# ─── Pod using PVC ────────────────────────────────────────────────
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres
spec:
  selector:
    matchLabels:
      app: postgres
  serviceName: postgres-headless
  replicas: 1
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
      - name: postgres
        image: postgres:14
        env:
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: pg-secret
              key: password
        volumeMounts:
        - name: postgres-data
          mountPath: /var/lib/postgresql/data
          # PRODUCTION NOTE: This directory persists even if pod is deleted
          # StatefulSet uses volumeClaimTemplates (below) for per-pod PVCs

  # StatefulSets use volumeClaimTemplates to auto-create PVCs per pod
  volumeClaimTemplates:
  - metadata:
      name: postgres-data
    spec:
      accessModes: ["ReadWriteOnce"]
      storageClassName: fast-ssd
      resources:
        requests:
          storage: 50Gi
```

### Storage Troubleshooting

```bash
# Check PV status
kubectl get pv
# STATUS column:
# Available — PV created but not yet bound to any PVC
# Bound — PV is bound to a PVC
# Released — PVC deleted, but PV not yet reclaimed (if Retain policy)
# Failed — Auto-reclamation failed

# Check PVC status
kubectl get pvc -n production
# STATUS column:
# Pending — No matching PV found (or waiting for provisioner)
# Bound — Successfully bound to a PV
# Lost — Bound PV was deleted (data loss risk!)

# Debug PVC stuck in Pending
kubectl describe pvc postgres-pvc -n production
# Look for events like:
# "no persistent volumes available for this claim" → need matching PV
# "waiting for volume to be created" → StorageClass provisioner issue

# Debug pod with volume issue
kubectl describe pod postgres-0
# Look for: "Unable to attach or mount volumes"
```

---

# PART 4: NETWORKING, TROUBLESHOOTING & CLUSTER INSTALLATION

---

## 4.1 Linux Networking Fundamentals

### Essential Networking Commands

```bash
# View network interfaces
ip link
ip addr

# View routing table
route
ip route

# Add a route (persists until reboot)
ip route add 192.168.2.0/24 via 192.168.1.1

# Enable IP forwarding (for routing between interfaces)
echo 1 > /proc/sys/net/ipv4/ip_forward
# For permanent setting:
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

# View listening ports and their PIDs
netstat -tulpn
ss -tulpn

# Test connectivity
ping 8.8.8.8
curl -v http://service-name:80

# DNS debugging
nslookup webapp-service
dig webapp-service.production.svc.cluster.local
host webapp-service
```

### Network Namespaces (Foundation for Pod Networking)

Each pod gets its own network namespace. When a pod is created:
1. New network namespace created
2. Virtual ethernet (veth) pair created
3. One end placed in pod namespace (becomes `eth0` in pod)
4. Other end placed on host bridge (`cbr0` or `cni0`)
5. IP assigned from pod CIDR subnet
6. Routes configured for pod-to-pod communication

---

## 4.2 CNI — Container Network Interface

### CNI Plugin Architecture

```
kubelet → CRI (containerd) → CNI plugin → Network setup

Configuration: /etc/cni/net.d/
Binaries:      /opt/cni/bin/
```

### Popular CNI Plugins and When to Use Them

| Plugin | Features | Production Use Case |
|--------|----------|---------------------|
| **Calico** | Network policies, BGP routing, eBPF | Most popular for production, EKS/bare-metal |
| **Cilium** | eBPF-based, excellent observability | Modern clusters, service mesh alternative |
| **Flannel** | Simple overlay, no network policies | Simple clusters, NOT for production security |
| **Weave Net** | Multi-cloud, encryption | Multi-cloud deployments |

```bash
# Check CNI configuration
ls /etc/cni/net.d/
cat /etc/cni/net.d/10-calico.conflist

# Check CNI binaries
ls /opt/cni/bin/

# Check which CNI plugin is active
kubectl get pods -n kube-system | grep calico
kubectl get pods -n kube-system | grep flannel
kubectl get pods -n kube-system | grep cilium

# Diagnose CNI issues
kubectl describe pod <failing-pod>
# Look for: "networkPlugin cni failed to set up pod"
# This means CNI plugin is not working

# Check kubelet CNI configuration
cat /var/lib/kubelet/config.yaml | grep cni
# OR check kubelet arguments
systemctl status kubelet
```

---

## 4.3 Service Networking & kube-proxy

### How kube-proxy Creates Service Rules

When a Service is created with ClusterIP `10.96.100.50`:

```bash
# kube-proxy creates iptables rules like:
iptables -t nat -L | grep webapp-service

# Output shows DNAT rules:
# -A KUBE-SVC-XXXX -m statistic --mode random --probability 0.33 -j KUBE-SEP-POD1
# -A KUBE-SVC-XXXX -m statistic --mode random --probability 0.50 -j KUBE-SEP-POD2
# -A KUBE-SVC-XXXX -j KUBE-SEP-POD3
# Each SEP (Service EndPoint) has a DNAT rule pointing to the actual Pod IP
```

### Checking Service Networking

```bash
# Verify service has endpoints (pods are healthy and selected)
kubectl get endpoints webapp-service -n production

# If endpoints are empty:
# 1. No pods match the service selector
# 2. Pods aren't ready (failing readiness probe)
# Debug: kubectl get pods -l app=webapp

# Check service CIDR
kubectl cluster-info dump | grep -m 1 service-cluster-ip-range

# Check pod CIDR
kubectl cluster-info dump | grep -m 1 cluster-cidr

# These MUST NOT overlap!
```

---

## 4.4 DNS in Kubernetes — CoreDNS

### CoreDNS Architecture

```
Pod requests DNS resolution
    │
    ▼
/etc/resolv.conf in pod:
    nameserver 10.96.0.10  (kube-dns ClusterIP)
    search default.svc.cluster.local svc.cluster.local cluster.local
    │
    ▼
CoreDNS pods in kube-system namespace
    │
    ▼
Resolution:
    webapp-service          → webapp-service.default.svc.cluster.local
    webapp-service.staging  → webapp-service.staging.svc.cluster.local
    External (google.com)   → Forwarded to upstream DNS
```

### CoreDNS Configuration

```bash
# View CoreDNS ConfigMap
kubectl get configmap coredns -n kube-system -o yaml

# CoreDNS Corefile format:
.:53 {
    errors
    health {
        lameduck 5s
    }
    ready
    kubernetes cluster.local in-addr.arpa ip6.arpa {
        pods insecure
        fallthrough in-addr.arpa ip6.arpa
        ttl 30
    }
    prometheus :9153
    forward . /etc/resolv.conf {  # Forward non-cluster queries to host's DNS
        max_concurrent 1000
    }
    cache 30
    loop
    reload
    loadbalance
}
```

### DNS Troubleshooting

```bash
# Debug DNS from inside a pod
kubectl exec -it webapp-pod -- nslookup kubernetes.default

# Test service DNS resolution
kubectl exec -it webapp-pod -- nslookup webapp-service.production

# Check CoreDNS pods are running
kubectl get pods -n kube-system | grep coredns

# View CoreDNS logs
kubectl logs -n kube-system -l k8s-app=kube-dns

# If DNS is broken: check CoreDNS deployment
kubectl describe deployment coredns -n kube-system

# Check kube-dns service exists
kubectl get service kube-dns -n kube-system
# Should have ClusterIP: 10.96.0.10 (matches /etc/resolv.conf in pods)
```

---

## 4.5 Ingress — Layer 7 Load Balancing

### Ingress vs Service LoadBalancer

| Feature | Service LoadBalancer | Ingress |
|---------|---------------------|---------|
| Layer | L4 (TCP/UDP) | L7 (HTTP/HTTPS) |
| Cost | 1 LB per service | 1 LB for all services |
| SSL termination | No (with NLB) | Yes |
| Path-based routing | No | Yes |
| Host-based routing | No | Yes |

### Ingress Anatomy

```
External Traffic → Ingress Controller → Routes → Backend Services
                   (nginx/traefik/     (rules)   (ClusterIP services)
                    haproxy/aws ALB)
```

### Deploying NGINX Ingress Controller

```bash
# Install NGINX Ingress Controller (Helm recommended for production)
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --set controller.replicaCount=2

# Verify
kubectl get service -n ingress-nginx
# Look for: ingress-nginx-controller  LoadBalancer  <EXTERNAL-IP>
```

### Ingress Rules

```yaml
# ─── Host-based routing ───────────────────────────────────────────
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: webapp-ingress
  namespace: production
  annotations:
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/proxy-connect-timeout: "30"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "60"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "60"
    # Rate limiting
    nginx.ingress.kubernetes.io/limit-rps: "100"

spec:
  tls:
  - hosts:
    - myapp.company.com
    - api.company.com
    secretName: tls-secret  # kubectl create secret tls tls-secret --cert=... --key=...

  rules:
  # Rule 1: Host-based routing
  - host: myapp.company.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend-service
            port:
              number: 80

  # Rule 2: Path-based routing on same host
  - host: api.company.com
    http:
      paths:
      - path: /users
        pathType: Prefix
        backend:
          service:
            name: user-service
            port:
              number: 8080

      - path: /products
        pathType: Prefix
        backend:
          service:
            name: product-service
            port:
              number: 8080

      - path: /       # Default route (must be last)
        pathType: Prefix
        backend:
          service:
            name: api-gateway
            port:
              number: 80
```

---

## 4.6 Troubleshooting — Application & Cluster Failures

### Systematic Troubleshooting Approach

```
Problem Reported
    │
    ▼
1. Check Pod status: kubectl get pods -A
    │
    ├─ Pending: kubectl describe pod → look for "Events" → scheduling failure
    ├─ CrashLoopBackOff: kubectl logs --previous → app crash logs
    ├─ ImagePullBackOff: kubectl describe pod → registry/image error
    ├─ OOMKilled: kubectl describe pod → increase memory limit
    ├─ Running but unhealthy: kubectl logs (live) → app error logs
    │
    ▼
2. Check Service: kubectl get svc → kubectl get endpoints
    │
    ├─ No endpoints: pod labels don't match service selector
    ├─ Endpoints exist but not reachable: kube-proxy, iptables issue
    │
    ▼
3. Check Node: kubectl get nodes → kubectl describe node
    │
    ├─ NotReady: kubelet issue, node OOM, disk pressure
    ├─ DiskPressure: node disk full → clean up logs/images
    ├─ MemoryPressure: node OOM → eviction happening
    │
    ▼
4. Check Control Plane: kubectl get pods -n kube-system
    │
    ├─ CoreDNS down: DNS failures
    ├─ kube-proxy down: Service networking broken
    └─ API server down: nothing works
```

### Application Troubleshooting Cheatsheet

```bash
# ─── Pod Issues ───────────────────────────────────────────────────
# Get all pod info with status
kubectl get pods -o wide -n production

# Detailed pod description (ALWAYS check Events section!)
kubectl describe pod webapp-7d8f9b-xkj2p -n production

# Get current logs
kubectl logs webapp-7d8f9b-xkj2p -n production

# Get logs from crashed/previous container
kubectl logs webapp-7d8f9b-xkj2p -n production --previous

# Execute command inside container (great for debugging)
kubectl exec -it webapp-7d8f9b-xkj2p -n production -- /bin/bash
kubectl exec -it webapp-7d8f9b-xkj2p -n production -- curl localhost:8080/health

# ─── Service Issues ───────────────────────────────────────────────
# Check service and endpoints
kubectl get service webapp-service -n production
kubectl get endpoints webapp-service -n production

# Test service from another pod
kubectl exec -it debug-pod -- curl http://webapp-service.production.svc.cluster.local

# ─── Node Issues ──────────────────────────────────────────────────
# Check node conditions
kubectl describe node node-1 | grep -A 10 Conditions

# Check node resource usage
kubectl top nodes

# Check kubelet logs on node
ssh node-1
journalctl -u kubelet -n 100 --no-pager

# ─── Control Plane Issues ─────────────────────────────────────────
# Check all system pods
kubectl get pods -n kube-system

# If API server is down, check static pod logs
crictl logs $(crictl ps -a | grep kube-apiserver | awk '{print $1}')

# Check etcd
crictl logs $(crictl ps -a | grep etcd | awk '{print $1}')
```

### Common Production Failures and Solutions

| Failure | Symptoms | Solution |
|---------|----------|---------|
| OOMKilled | Pod restarts, `OOMKilled` in describe | Increase memory limit, fix memory leak |
| CrashLoopBackOff | Pod keeps restarting | `logs --previous`, fix app crash, check liveness probe |
| ImagePullBackOff | Pod never starts | Check image name/tag, verify registry credentials |
| PVC Pending | Pod won't start, PVC stuck | Check StorageClass, PV availability, provisioner logs |
| DNS resolution fails | Services unreachable by name | Check CoreDNS pods, verify /etc/resolv.conf in pod |
| Node NotReady | Pods on node are Unknown | Check kubelet, node resources, network connectivity |

---

## 4.7 Installing Kubernetes with kubeadm

### Pre-Installation Requirements

```bash
# On ALL nodes (master + workers):

# 1. Disable swap (Kubernetes doesn't work with swap)
swapoff -a
# Permanently:
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# 2. Load required kernel modules
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

# 3. Set kernel parameters
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system

# 4. Install containerd
sudo apt-get update
sudo apt-get install -y containerd

# 5. Configure containerd with systemd cgroup driver
sudo mkdir -p /etc/containerd
containerd config default | \
  sed 's/SystemdCgroup = false/SystemdCgroup = true/' | \
  sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd

# 6. Install kubeadm, kubelet, kubectl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | \
  sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | \
sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

### Initialize the Cluster (Master Only)

```bash
# Get master node's IP (the one other nodes can reach)
ip addr | grep '192.168'  # Find the cluster network IP

# Initialize cluster
sudo kubeadm init \
  --apiserver-advertise-address=192.168.56.11 \  # Master's cluster IP
  --pod-network-cidr=10.244.0.0/16 \             # For Flannel
  # OR 192.168.0.0/16 for Calico
  --kubernetes-version=v1.29.3 \
  --upload-certs

# Sample output includes:
# Your Kubernetes control-plane has initialized successfully!
# To start using your cluster, you need to run the following as a regular user:
#   mkdir -p $HOME/.kube
#   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#   sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Configure kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install CNI (Calico example)
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml

# Verify control plane is running
kubectl get pods -n kube-system
kubectl get nodes  # Should show master as Ready
```

### Join Worker Nodes

```bash
# The kubeadm init output provides the join command
# It looks like:
sudo kubeadm join 192.168.56.11:6443 \
  --token abc123.0123456789abcdef \
  --discovery-token-ca-cert-hash sha256:abc...

# If token expired (tokens expire after 24h by default), regenerate:
kubeadm token create --print-join-command

# Verify workers joined
kubectl get nodes  # Should show all nodes Ready within ~2 minutes
```

---

# PART 5: HELM, KUSTOMIZE & PACKAGE MANAGEMENT

---

## 5.1 Helm — The Kubernetes Package Manager

### What is Helm?

Helm is the **package manager for Kubernetes**, analogous to apt/yum for Linux or npm for Node.js. It packages Kubernetes manifests into **Charts** that can be:
- Installed with a single command
- Configured with custom values
- Version-controlled
- Easily rolled back

### Core Concepts

| Concept | Explanation |
|---------|-------------|
| **Chart** | A package of pre-configured Kubernetes resources (
