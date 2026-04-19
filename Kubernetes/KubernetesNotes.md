# 🚀 Comprehensive CKA Mastery Notes — Senior DevOps Engineer Edition

> **A complete, production-grade, deeply explained reference for the Certified Kubernetes Administrator (CKA) Exam and Senior DevOps Interviews**

---

## 📋 Table of Contents

### Part 1: Core Concepts & Scheduling
- [1.1 Kubernetes Architecture — The Big Picture](#11-kubernetes-architecture--the-big-picture)
- [1.2 Docker vs ContainerD — The Runtime Evolution](#12-docker-vs-containerd--the-runtime-evolution)
- [1.3 ETCD — The Brain of the Cluster](#13-etcd--the-brain-of-the-cluster)
- [1.4 Kube API Server — The Central Nervous System](#14-kube-api-server--the-central-nervous-system)
- [1.5 Kube Controller Manager — The Autopilot](#15-kube-controller-manager--the-autopilot)
- [1.6 Kube Scheduler — The Placement Engine](#16-kube-scheduler--the-placement-engine)
- [1.7 Kubelet — The Node Agent](#17-kubelet--the-node-agent)
- [1.8 Kube Proxy — The Network Plumber](#18-kube-proxy--the-network-plumber)
- [1.9 Pods — The Atomic Unit](#19-pods--the-atomic-unit)
- [1.10 ReplicaSets — High Availability Guarantee](#110-replicasets--high-availability-guarantee)
- [1.11 Deployments — Production-Grade Workload Management](#111-deployments--production-grade-workload-management)
- [1.12 Services — Stable Network Endpoints](#112-services--stable-network-endpoints)
- [1.13 Namespaces — Logical Cluster Partitioning](#113-namespaces--logical-cluster-partitioning)
- [1.14 Imperative vs Declarative — GitOps Foundation](#114-imperative-vs-declarative--gitops-foundation)
- [1.15 kubectl apply — How It Works Internally](#115-kubectl-apply--how-it-works-internally)
- [1.16 Manual Scheduling](#116-manual-scheduling)
- [1.17 Labels and Selectors](#117-labels-and-selectors)
- [1.18 Taints and Tolerations](#118-taints-and-tolerations)
- [1.19 Node Selectors](#119-node-selectors)
- [1.20 Node Affinity](#120-node-affinity)
- [1.21 Taints & Tolerations vs Node Affinity](#121-taints--tolerations-vs-node-affinity)
- [1.22 DaemonSets — One Pod Per Node](#122-daemonsets--one-pod-per-node)
- [1.23 Static Pods — Bootstrap Without a Master](#123-static-pods--bootstrap-without-a-master)
- [1.24 Priority Classes — Workload Prioritization](#124-priority-classes--workload-prioritization)
- [1.25 Multiple Schedulers & Scheduler Profiles](#125-multiple-schedulers--scheduler-profiles)
- [1.26 Admission Controllers](#126-admission-controllers)

### Part 2: Logging, Monitoring, Lifecycle & Cluster Maintenance
- [2.1 Managing Application Logs](#21-managing-application-logs)
- [2.2 Rolling Updates and Rollbacks](#22-rolling-updates-and-rollbacks)
- [2.3 Commands and Arguments in Docker & Kubernetes](#23-commands-and-arguments-in-docker--kubernetes)
- [2.4 Secrets — Secure Configuration Management](#24-secrets--secure-configuration-management)
- [2.5 Encrypting Secrets at Rest](#25-encrypting-secrets-at-rest)
- [2.6 Multi-Container Pods](#26-multi-container-pods)
- [2.7 Autoscaling — HPA and VPA](#27-autoscaling--hpa-and-vpa)
- [2.8 In-Place Pod Resize](#28-in-place-pod-resize)
- [2.9 OS Upgrades — Node Drain & Cordon](#29-os-upgrades--node-drain--cordon)
- [2.10 Cluster Upgrade with kubeadm](#210-cluster-upgrade-with-kubeadm)
- [2.11 Backup and Restore Methods](#211-backup-and-restore-methods)

### Part 3: Security & Storage
- [3.1 Kubernetes Security Primitives](#31-kubernetes-security-primitives)
- [3.2 Authentication — Who Are You?](#32-authentication--who-are-you)
- [3.3 TLS Basics — Cryptography Fundamentals](#33-tls-basics--cryptography-fundamentals)
- [3.4 TLS in Kubernetes — Certificate Ecosystem](#34-tls-in-kubernetes--certificate-ecosystem)
- [3.5 TLS Certificate Creation with OpenSSL](#35-tls-certificate-creation-with-openssl)

### Part 4: Helm, Kustomize & kubeadm Installation
- [4.1 Helm — The Kubernetes Package Manager](#41-helm--the-kubernetes-package-manager)
- [4.2 Helm 2 vs Helm 3](#42-helm-2-vs-helm-3)
- [4.3 Helm Components Deep Dive](#43-helm-components-deep-dive)
- [4.4 Helm Charts — Structure & Lifecycle](#44-helm-charts--structure--lifecycle)
- [4.5 Working with Helm CLI](#45-working-with-helm-cli)
- [4.6 Customizing Chart Parameters](#46-customizing-chart-parameters)
- [4.7 Lifecycle Management with Helm](#47-lifecycle-management-with-helm)
- [4.8 Kustomize — Pure YAML Configuration Management](#48-kustomize--pure-yaml-configuration-management)
- [4.9 Kustomize vs Helm — Decision Guide](#49-kustomize-vs-helm--decision-guide)
- [4.10 Kustomize Transformers](#410-kustomize-transformers)
- [4.11 Kustomize Patches](#411-kustomize-patches)
- [4.12 Kustomize Overlays — Multi-Environment Strategy](#412-kustomize-overlays--multi-environment-strategy)
- [4.13 Kustomize Components — Reusable Config Blocks](#413-kustomize-components--reusable-config-blocks)
- [4.14 Bootstrapping a Kubernetes Cluster with kubeadm](#414-bootstrapping-a-kubernetes-cluster-with-kubeadm)

---

# Part 1: Core Concepts & Scheduling

---

## 1.1 Kubernetes Architecture — The Big Picture

### 📌 What Is Kubernetes and Why Does It Exist?

Kubernetes (K8s) is an open-source **container orchestration platform** originally built by Google, based on their internal system called Borg. It automates the deployment, scaling, and management of containerized applications across clusters of machines.

**Why does it exist?** Without Kubernetes:
- You'd manually track which containers are running on which servers
- If a container crashes, no one restarts it automatically
- Scaling during traffic spikes requires human intervention
- Rolling out new versions would require manual coordination and cause downtime

Kubernetes solves these problems with a declarative, self-healing, extensible architecture.

---

### 🏗️ High-Level Architecture

```
┌──────────────────────────────────────────────────────────────────┐
│                        KUBERNETES CLUSTER                        │
│                                                                  │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │                    CONTROL PLANE (Master)                   │ │
│  ��                                                             │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐  │ │
│  │  │  kube-       │  │  kube-       │  │  kube-controller │  │ │
│  │  │  apiserver   │  │  scheduler   │  │  manager         │  │ │
│  │  └──────────────┘  └──────────────┘  └──────────────────┘  │ │
│  │           │                                                 │ │
│  │  ┌──────────────────────────┐                              │ │
│  │  │         etcd             │  (distributed key-value DB)  │ │
│  │  └──────────────────────────┘                              │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                          │   │   │                               │
│         ┌────────────────┘   │   └────────────────┐             │
│         ▼                    ▼                    ▼             │
│  ┌────────────┐      ┌────────────┐      ┌────────────┐         │
│  │  WORKER 1  │      │  WORKER 2  │      │  WORKER 3  │         │
│  │            │      │            │      │            │         │
│  │  kubelet   │      │  kubelet   │      │  kubelet   │         │
│  │  kube-proxy│      │  kube-proxy│      │  kube-proxy│         │
│  │            │      │            │      │            │         │
│  │  [Pod] [Pod│      │  [Pod] [Pod│      │  [Pod] [Pod│         │
│  └────────────┘      └────────────┘      └────────────┘         │
└──────────────────────────────────────────────────────────────────┘
```

---

### 🧠 Master Node (Control Plane) — The Brain

The master node is the **decision-making center** of the cluster. Think of it as the air traffic control tower — it doesn't carry passengers itself, but orchestrates everything that does.

**Key principle:** In production, you always run **at least 3 master nodes** for High Availability (HA). If one master dies, the others continue managing the cluster through **leader election**.

#### Control Plane Components:

| Component | Role | Analogy |
|-----------|------|---------|
| **kube-apiserver** | The only entry point for all cluster operations | Front desk / receptionist |
| **etcd** | Distributed key-value store holding ALL cluster state | The filing cabinet / database |
| **kube-scheduler** | Decides which node a new Pod should run on | HR assigning employees to departments |
| **kube-controller-manager** | Runs control loops that maintain desired state | The operations team watching dashboards |

---

### ⚙️ Worker Node — The Engine Room

Worker nodes are where your actual application workloads run. Each worker node has:

| Component | Role |
|-----------|------|
| **kubelet** | The agent that talks to the API server and manages containers on the node |
| **kube-proxy** | Manages iptables/ipvs rules for Service networking |
| **Container Runtime** | Actually runs containers (ContainerD, CRI-O, etc.) |

---

### 🔄 How a Pod Gets Created — End-to-End Flow

Understanding this flow is **critical for CKA exams and debugging** in production:

```
kubectl run nginx --image=nginx
         │
         ▼
  kube-apiserver (authenticates, validates, writes to etcd)
         │
         ▼
       etcd (Pod object stored with nodeName: "")
         │
         ▼
  kube-scheduler (watches for Pods without nodeName, selects node)
         │
         ▼
  kube-apiserver (updates Pod object in etcd with nodeName: "worker-2")
         │
         ▼
  kubelet on worker-2 (watches for Pods assigned to its node)
         │
         ▼
  Container Runtime (pulls image, creates container)
         │
         ▼
  kubelet updates Pod status → kube-apiserver → etcd
```

**Production insight:** When debugging a Pod stuck in `Pending`, check the scheduler logs. When stuck in `ContainerCreating`, check kubelet and container runtime on the assigned node.

---

### 📝 Section Summary

> Kubernetes is a self-healing, declarative container orchestration system. The master node hosts the brain components (API server, etcd, scheduler, controller manager) while worker nodes host application workloads via kubelet and kube-proxy. Understanding the flow of a request through the system is the foundation for effective debugging and CKA exam success.

---

## 1.2 Docker vs ContainerD — The Runtime Evolution

### 📌 Why This Matters

This topic confuses many engineers, especially when they encounter `crictl`, `ctr`, or `nerdctl` commands in production and don't know which to use. Understanding this evolution explains why these tools exist.

---

### 🕰️ Historical Context

**The problem Kubernetes originally had:**

When Kubernetes was first created (2014), Docker was the only game in town. Kubernetes was tightly coupled to Docker. When other runtimes (like Rocket/rkt) wanted to work with Kubernetes, there was no standard interface.

**The solution: CRI (Container Runtime Interface)**

Kubernetes introduced the **Container Runtime Interface (CRI)** — a standardized plugin interface that allows any container runtime to work with Kubernetes, as long as it implements the CRI specification.

```
BEFORE CRI:
Kubernetes → Docker (hardcoded, tight coupling)

AFTER CRI:
Kubernetes → CRI → ContainerD  ✅
Kubernetes → CRI → CRI-O       ✅
Kubernetes → CRI → Docker*     (needed Docker Shim as adapter)

* Docker Shim was removed in Kubernetes v1.24
```

---

### 🐳 Docker vs ContainerD

**Docker** is NOT just a container runtime. Docker is a **complete platform** that includes:
- CLI (docker command)
- Image build tool (Dockerfile → image)
- API
- Volume management
- Networking management
- Registry integration
- The actual runtime: **ContainerD** (under the hood)

**ContainerD** is:
- A standalone, lightweight CRI-compatible container runtime
- Originally extracted from Docker's codebase
- Now a CNCF graduated project
- What Kubernetes actually needs — just the runtime

**Key insight:** When Kubernetes v1.24 removed Docker support, it removed the Docker Shim adapter. Your Docker-built images still work perfectly because they're OCI-compliant. Only the runtime changed.

---

### 🛠️ CLI Tools Comparison — Critical for CKA

This is a common source of confusion. Here's a clear breakdown:

| Tool | Made By | Purpose | Use In Production? |
|------|---------|---------|-------------------|
| `docker` | Docker Inc | Full container management | Yes, for dev/build |
| `ctr` | ContainerD community | Low-level ContainerD debugging | Rarely, debugging only |
| `nerdctl` | ContainerD community | Docker-like UX for ContainerD | Yes, if replacing Docker |
| `crictl` | Kubernetes community | CRI-compatible runtime inspection | **Yes, for K8s node debugging** |

**`crictl` is what you use on Kubernetes worker nodes** to inspect containers, not `docker`.

```bash
# On a Kubernetes worker node (ContainerD runtime):
crictl ps                          # list running containers
crictl images                      # list images
crictl logs <container-id>         # view container logs
crictl pods                        # list pods (unique to crictl, docker doesn't have this)
crictl exec -it <container-id> sh  # exec into container

# Low-level ContainerD debugging (rarely needed):
ctr images pull docker.io/library/redis:alpine
ctr run docker.io/library/redis:alpine redis
```

**CKA Exam Tip:** If you SSH into a node and need to inspect containers, use `crictl`, not `docker`. In newer clusters, `docker` may not even be installed.

---

### 🔧 Setting the Runtime Endpoint

In newer Kubernetes versions, you may need to explicitly tell `crictl` which runtime endpoint to use:

```bash
# For ContainerD:
crictl --runtime-endpoint unix:///run/containerd/containerd.sock ps

# Or set it permanently:
export CONTAINER_RUNTIME_ENDPOINT=unix:///run/containerd/containerd.sock
```

---

### 📝 Section Summary

> Docker was the original Kubernetes runtime but required a shim adapter. Kubernetes v1.24 removed Docker Shim and now uses CRI-compatible runtimes directly (ContainerD is most common). For node-level debugging in Kubernetes, use `crictl`. Docker images remain fully compatible as they are OCI-compliant.

---

## 1.3 ETCD — The Brain of the Cluster

### 📌 What Is etcd and Why Is It Critical?

etcd is a **distributed, reliable, strongly consistent key-value store**. It is the **single source of truth** for everything in your Kubernetes cluster. If etcd dies and you have no backup, your cluster configuration is gone.

Everything Kubernetes knows is stored in etcd:
- All Pod definitions
- Node registrations
- ConfigMaps and Secrets
- Role-Based Access Control policies
- Service accounts
- Everything you've ever `kubectl apply`'d

---

### 🗄️ Key-Value Store vs Relational Database

Understanding the difference helps you understand etcd's design choices:

**Relational Database (SQL):**
- Data in rigid rows and columns
- Adding new fields requires schema migration
- Strong relational joins across tables

**Key-Value Store (etcd):**
- Data stored as independent documents (key → value)
- Each document can have its own structure (JSON/YAML)
- Extremely fast for reads and writes
- Perfect for configuration data

```
etcd stores something like:
/registry/pods/default/nginx-pod  →  {apiVersion: v1, kind: Pod, ...full JSON...}
/registry/nodes/worker-1          →  {name: worker-1, status: Ready, ...}
/registry/secrets/default/my-secret  →  {data: {password: base64encoded...}}
```

---

### ⚙️ etcd Architecture — The Raft Consensus Algorithm

In a production HA cluster, you run **3 or 5 etcd instances** (always odd numbers). They use the **Raft consensus algorithm** to elect a leader and ensure all writes are replicated to a quorum before being acknowledged.

```
etcd Cluster (3 nodes):
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  etcd-1     │◄──►│  etcd-2     │◄──►│  etcd-3     │
│  (LEADER)   │    │  (FOLLOWER) │    │  (FOLLOWER) │
└─────────────┘    └─────────────┘    └─────────────┘
      │
      │ Write must be acknowledged by majority (quorum = 2/3)
      │ before being committed
```

**Why odd numbers?** With 3 nodes, you can tolerate 1 failure (quorum = 2). With 5 nodes, you can tolerate 2 failures (quorum = 3). Even numbers create split-brain scenarios.

---

### 🔌 etcd in Kubernetes — Two Deployment Modes

#### Mode 1: Stacked etcd (kubeadm default)
etcd runs as a Pod on the master node itself. Simple but risk: if master fails, both control plane AND data store go down.

```bash
# View etcd pod in kubeadm cluster:
kubectl get pods -n kube-system | grep etcd
# etcd-controlplane   1/1   Running   0   2h
```

#### Mode 2: External etcd
etcd runs on dedicated separate servers. This is the **production HA recommendation** — control plane failures don't affect the data store.

---

### 🔑 Working with etcdctl

```bash
# Set API version to v3 (always do this):
export ETCDCTL_API=3

# Get all keys in Kubernetes registry:
kubectl exec etcd-master -n kube-system -- \
  etcdctl get / --prefix --keys-only \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key

# Output shows:
# /registry/pods/default/nginx
# /registry/nodes/worker-1
# /registry/deployments/default/my-app
# ... etc
```

**API v2 vs v3 Command Differences:**
| Action | v2 | v3 |
|--------|----|----|
| Store value | `etcdctl set key value` | `etcdctl put key value` |
| Get value | `etcdctl get key` | `etcdctl get key` |
| Check version | `etcdctl --version` | `etcdctl version` |

---

### 🚨 Production Best Practices

1. **Always backup etcd** before cluster upgrades or major changes
2. **Use 3 or 5 etcd nodes** in production for HA
3. **Store etcd data on SSDs** — it's I/O intensive
4. **Monitor etcd latency** — high latency causes API server slowness
5. **Separate etcd from other workloads** — resource contention kills it

---

### 📝 Section Summary

> etcd is Kubernetes' distributed key-value store and single source of truth. All cluster state lives in etcd. It uses the Raft consensus algorithm for distributed agreement. Always run 3+ etcd nodes in production, keep backups, and use etcdctl v3 API for operations.

---

## 1.4 Kube API Server — The Central Nervous System

### 📌 What Is the API Server?

The kube-apiserver is the **only component that directly interacts with etcd**. It is the front-end for the Kubernetes control plane. Every operation — whether from `kubectl`, the scheduler, controller manager, or kubelets — goes through the API server.

Think of it as the **post office** of Kubernetes: all messages must flow through it, and it ensures they are valid, authenticated, and authorized before being processed.

---

### 🔄 Request Lifecycle Through the API Server

```
Client Request (kubectl apply -f pod.yaml)
         │
         ▼
┌─────────────────────────────────────────┐
│           kube-apiserver                │
│                                         │
│  1. Authentication  ──── Who are you?   │
│         │                               │
│  2. Authorization   ──── What can you do│
│         │                               │
│  3. Admission Control ── Should this    │
│         │              ── be allowed?   │
│  4. Validation      ──── Is the request │
│         │              ── valid YAML?   │
│  5. etcd Write      ──── Store the data │
│         │                               │
│  6. Return Response ──── Confirm to     │
│                        ── client        │
└─────────────────────────────────────────┘
         │
         ▼
  Scheduler/Controllers watch for new objects
  and take action
```

---

### 🔧 Key Configuration Parameters

The API server is configured with dozens of flags. The most important ones:

```bash
# Typical kube-apiserver startup flags:
kube-apiserver
  --etcd-servers=https://127.0.0.1:2379        # Where is etcd?
  --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
  --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
  --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key
  --advertise-address=172.17.0.32              # API server's IP
  --authorization-mode=Node,RBAC               # Authorization mechanisms
  --client-ca-file=/etc/kubernetes/pki/ca.crt
  --kubelet-client-certificate=...
  --service-cluster-ip-range=10.32.0.0/24      # ClusterIP range
  --service-node-port-range=30000-32767         # NodePort range
```

**Finding API server config in kubeadm clusters:**
```bash
# View as static pod manifest:
cat /etc/kubernetes/manifests/kube-apiserver.yaml

# Or find the running process:
ps -aux | grep kube-apiserver | grep -v grep
```

---

### 🚨 Production Debugging Scenarios

**Scenario 1: API server is not responding**
```bash
# Check if the static pod is running:
crictl ps | grep kube-apiserver

# Check etcd connectivity (most common cause):
curl -k https://127.0.0.1:2379/health \
  --cacert /etc/kubernetes/pki/etcd/ca.crt \
  --cert /etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key /etc/kubernetes/pki/etcd/healthcheck-client.key

# Check API server logs:
crictl logs <kube-apiserver-container-id>
# OR (kubeadm):
kubectl logs kube-apiserver-controlplane -n kube-system
```

**Scenario 2: Unauthorized errors in production**
```bash
# Check RBAC:
kubectl auth can-i create pods --as=dev-user
kubectl auth can-i create pods --as=dev-user -n production
```

---

### 📝 Section Summary

> The kube-apiserver is the exclusive gateway to etcd and the center of all cluster operations. Every request goes through authentication, authorization, admission control, and validation. Understanding its request lifecycle is essential for debugging access issues and understanding how Kubernetes works internally.

---

## 1.5 Kube Controller Manager — The Autopilot

### 📌 What Are Controllers?

A **controller** in Kubernetes follows a simple pattern called the **control loop** or **reconciliation loop**:

```
while true:
    desired_state = read from etcd (what should exist)
    current_state = observe the cluster (what actually exists)
    if desired_state != current_state:
        take action to close the gap
    sleep(interval)
```

This is the core principle that makes Kubernetes **self-healing**. Controllers continuously monitor and act.

---

### 🎛️ Key Controllers and What They Do

All controllers run inside the **kube-controller-manager** as a single binary. Each manages a specific resource type:

| Controller | Responsibility | Production Example |
|-----------|---------------|-------------------|
| **Node Controller** | Monitors node health, evicts pods from dead nodes | If worker-3 crashes, its pods are rescheduled after 5 min |
| **Replication Controller** | Ensures correct number of pod replicas | If a pod crashes, creates a replacement |
| **Deployment Controller** | Manages rolling updates | Orchestrates new ReplicaSet during `kubectl rollout` |
| **Endpoints Controller** | Populates Service endpoints | When a Pod matching a Service selector starts, adds its IP |
| **ServiceAccount Controller** | Creates default service accounts in new namespaces | Auto-creates `default` SA in every namespace |
| **Job Controller** | Manages one-time Jobs | Runs batch jobs to completion |
| **CronJob Controller** | Manages scheduled Jobs | Runs `kubectl apply` every midnight for config updates |
| **StatefulSet Controller** | Ordered Pod management | Manages database clusters with stable identities |
| **DaemonSet Controller** | Ensures one pod per node | Deploys log collectors to all nodes |

---

### ⏱️ Node Controller Timing — Important for CKA

The Node Controller has specific timing parameters you need to know:

```
Node stops sending heartbeats
         │
         ▼
  40 seconds grace period (node-monitor-grace-period)
         │
         ▼
  Node marked as "NotReady" / "Unknown"
         │
         ▼
  5 minutes eviction timeout (pod-eviction-timeout)
         │
         ▼
  Pods on the node are marked for deletion
  and rescheduled (if managed by ReplicaSet/Deployment)
```

**CKA Exam Tip:** If asked "when does Kubernetes evict pods from a failed node?", the answer is after the `pod-eviction-timeout` which defaults to 5 minutes.

---

### 🔧 Configuration

```bash
# View controller manager config:
cat /etc/kubernetes/manifests/kube-controller-manager.yaml

# Key flags:
--node-monitor-period=5s              # How often to check node health
--node-monitor-grace-period=40s       # Grace period before marking unhealthy
--pod-eviction-timeout=5m             # Time before evicting pods from failed node
--controllers=*,bootstrapsigner,tokencleaner  # Which controllers to enable
```

---

### 📝 Section Summary

> The kube-controller-manager runs all Kubernetes controllers in a single process. Each controller implements a reconciliation loop that continuously ensures the actual cluster state matches the desired state. This is the mechanism behind Kubernetes' self-healing capabilities. Understanding controller timing is critical for both production operations and CKA exams.

---

## 1.6 Kube Scheduler — The Placement Engine

### 📌 What Does the Scheduler Do?

The scheduler's **sole job** is to decide which node a new Pod should run on. It does NOT actually create the pod — it only updates the Pod's `nodeName` field in etcd. The kubelet on the selected node then picks it up and creates the container.

**Important distinction:** Scheduler = placement decision only. Kubelet = actual container creation.

---

### 🎯 Scheduling Algorithm — Two Phases

```
New Pod needs a node
         │
         ▼
Phase 1: FILTERING
─────────────────────────────────
Filter out nodes that CANNOT run the pod:
  • Not enough CPU or memory
  • Node has a taint that pod doesn't tolerate
  • Node selector doesn't match
  • Node affinity rules eliminate it
  • Node is marked unschedulable (cordoned)
         │
         ▼
Phase 2: SCORING
─────────────────────────────────
Score remaining nodes 0-10:
  • Prefer nodes with MORE free resources after placement
  • Prefer nodes that already have the container image
  • Spread pods across nodes/zones for HA
         │
         ▼
BINDING: Pod assigned to highest-scored node
```

---

### 🔌 Scheduler Plugins — Extension Points

Kubernetes 1.15+ introduced a plugin-based scheduler framework. Each phase has **extension points** where plugins can be injected:

```
Extension Points in order:
1. QueueSort       → Sort pods in scheduling queue (PrioritySort plugin)
2. PreFilter       → Pre-process pod info
3. Filter          → Filter out unsuitable nodes (NodeResourcesFit, NodeSelector, etc.)
4. PostFilter      → Handle filter failures (Preemption)
5. PreScore        → Pre-process scoring
6. Score           → Score remaining nodes
7. NormalizeScore  → Normalize scores
8. Reserve         → Reserve resources on selected node
9. Permit          → Approve/deny/wait
10. PreBind        → Pre-binding operations
11. Bind           → Actually bind pod to node (DefaultBinder plugin)
12. PostBind       → Post-binding cleanup
```

**Why this matters:** You can write custom scheduler plugins in Go and inject them at any extension point, or you can run entirely custom schedulers for specialized workloads (ML training jobs, batch processing, etc.)

---

### 🔧 Verifying Scheduler

```bash
# Check scheduler health in kubeadm:
kubectl get pods -n kube-system | grep scheduler

# Check process:
ps -aux | grep kube-scheduler

# Check which scheduler assigned a pod:
kubectl get events | grep Scheduled
# OR:
kubectl describe pod <pod-name> | grep -A 5 Events
```

---

### 📝 Section Summary

> The kube-scheduler selects the best node for each Pod through a two-phase filter+score algorithm. It only updates the Pod's `nodeName` field — actual container creation is done by the kubelet. The plugin-based framework allows custom scheduling logic at multiple extension points.

---

## 1.7 Kubelet — The Node Agent

### 📌 What Is the Kubelet?

The kubelet is the **primary node agent** that runs on every node (including master nodes in some setups). It's the only component that directly interacts with the container runtime to create, start, stop, and delete containers.

**The kubelet's contract:** "Tell me what pods should run on this node, and I'll make it happen and keep it running."

---

### 🔄 Kubelet's Responsibilities

```
Kubelet watches kube-apiserver for:
"Hey kubelet, please run Pod X on your node"
         │
         ▼
1. Pulls container images via container runtime
2. Creates containers
3. Mounts volumes
4. Sets up networking
5. Reports Pod status back to API server
6. Runs liveness/readiness probes
7. Restarts containers on failure
8. Reports node resource usage (CPU, memory)
```

---

### ⚠️ Critical Difference from Other Components

**kubeadm does NOT automatically install or manage kubelet.** This is one of the most important things to know for the CKA exam.

```bash
# You must manually install kubelet on each node:
apt-get install -y kubelet

# Start and enable:
systemctl enable --now kubelet

# Check kubelet status:
systemctl status kubelet
journalctl -u kubelet -f  # Stream kubelet logs
```

**CKA Exam Tip:** If a node is "NotReady" and you ssh into it, first check the kubelet status with `systemctl status kubelet`. Most node-level failures trace back to a stopped or misconfigured kubelet.

---

### 🔧 Kubelet Configuration

```bash
# Find kubelet config:
cat /var/lib/kubelet/config.yaml

# Key parameters:
# staticPodPath: /etc/kubernetes/manifests   ← where static pods live
# clusterDNS: [10.96.0.10]                  ← CoreDNS IP
# containerRuntimeEndpoint: unix:///run/containerd/containerd.sock

# Check running kubelet process:
ps -aux | grep kubelet
```

---

### 📝 Section Summary

> The kubelet is the node-level agent that communicates with the container runtime to manage pod lifecycles. Unlike other control plane components, the kubelet must be manually installed on nodes when using kubeadm. It's the first place to check when debugging node-level issues.

---

## 1.8 Kube Proxy — The Network Plumber

### 📌 What Is kube-proxy?

kube-proxy runs on every node and is responsible for implementing the **Service abstraction** at the network level. When you create a Service in Kubernetes, kube-proxy ensures that traffic to that Service's ClusterIP gets forwarded to the actual Pod IPs.

**The problem it solves:** Pod IPs are ephemeral (they change when pods restart). kube-proxy creates stable routing rules that forward traffic from a stable Service IP to whatever pods are currently healthy.

---

### 🔧 How kube-proxy Works

kube-proxy watches the API server for Service and Endpoint changes, then configures the node's network rules accordingly:

```
Service Created: my-service (ClusterIP: 10.96.100.50, port: 80)
         │
         ▼
kube-proxy creates iptables rule on EVERY node:
"Any traffic going to 10.96.100.50:80 → forward to one of these pods:
  10.244.1.5:8080, 10.244.2.3:8080, 10.244.3.7:8080 (round-robin)"
         │
         ▼
Pod on Worker-1 can now curl http://my-service and reach pods on Worker-2 or Worker-3
```

---

### 🔩 kube-proxy Modes

| Mode | Mechanism | Performance | Notes |
|------|-----------|-------------|-------|
| **iptables** (default) | Linux iptables rules | Medium | Most widely used |
| **IPVS** | IP Virtual Server | High | Better for large clusters (1000+ services) |
| **userspace** (legacy) | Userspace proxy | Low | Deprecated, don't use |

**Production recommendation:** Use IPVS mode for clusters with 500+ services, as iptables rules become slow to update at scale.

---

### 🚀 kube-proxy Deployment

In kubeadm clusters, kube-proxy is deployed as a **DaemonSet** (one pod per node):

```bash
kubectl get daemonset -n kube-system kube-proxy
# Ensures every node gets a kube-proxy pod automatically
```

---

### 📝 Section Summary

> kube-proxy implements the Service abstraction by creating network forwarding rules (iptables/IPVS) on every node. It ensures traffic to a Service's stable ClusterIP is distributed to healthy pods. It runs as a DaemonSet, guaranteeing presence on every node.

---

## 1.9 Pods — The Atomic Unit

### 📌 What Is a Pod and Why Does It Exist?

A **Pod** is the smallest deployable unit in Kubernetes. It is **not** a container — it's a wrapper around one or more containers that share:
- The same **network namespace** (same IP address, same localhost)
- The same **storage volumes**
- The same **lifecycle** (created and destroyed together)

**Why doesn't Kubernetes just schedule containers directly?**

The Pod abstraction solves real-world deployment patterns. Some applications require multiple processes that must:
- Share a filesystem (sidecar writes logs, main app reads them)
- Communicate via localhost (agent container + app container)
- Share network configuration (service mesh sidecar proxies)

---

### 🏗️ Pod Architecture

```
┌─────────────────────────────────────────────────────┐
│                         POD                          │
│                                                      │
│  Pod IP: 10.244.1.25                                 │
│                                                      │
│  ┌──────────────────┐  ┌────────────────────────┐   │
│  │  Main Container  │  │  Sidecar Container     │   │
│  │  (web app)       │  │  (log collector/proxy) │   │
│  │                  │  │                        │   │
│  │  port: 8080      │  │  reads /var/logs       │   │
│  └──────────────────┘  └────────────────────────┘   │
│          │                        │                  │
│          └────────────────────────┘                  │
│                  Shared Volume                       │
│                  (emptyDir: /var/logs)                │
└─────────────────────────────────────────────────────┘
         │
         │ All containers share same IP
         │ Communicate via localhost
         │
```

---

### 📄 Pod YAML — Complete Structure Explained

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-app-pod
  namespace: production          # Namespaced resource
  labels:
    app: web-app                 # Used by Services and ReplicaSets to find this pod
    tier: frontend
    version: "2.1"
  annotations:
    prometheus.io/scrape: "true" # Metadata, not for selection
    deployment-date: "2024-01-15"
spec:
  containers:
  - name: web-app                # Container name (must be unique in pod)
    image: nginx:1.25            # Always pin to specific version in production!
    ports:
    - containerPort: 80
      protocol: TCP
    resources:                   # Always set in production!
      requests:
        memory: "128Mi"          # Minimum memory scheduler considers
        cpu: "250m"              # 250 millicores = 0.25 CPU cores
      limits:
        memory: "256Mi"          # If exceeded: OOMKilled
        cpu: "500m"              # If exceeded: throttled (not killed)
    env:
    - name: ENV_NAME
      value: "production"
    livenessProbe:               # Is the app alive?
      httpGet:
        path: /healthz
        port: 80
      initialDelaySeconds: 30    # Wait before first probe
      periodSeconds: 10
    readinessProbe:              # Is the app ready to receive traffic?
      httpGet:
        path: /ready
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 5
  restartPolicy: Always          # Always (default), OnFailure, Never
  serviceAccountName: web-app-sa # Service account for RBAC
```

---

### 🔍 Pod Lifecycle States

```
Pending → ContainerCreating → Running → (Succeeded/Failed/Unknown)

Pending:           Scheduler assigned a node, image being pulled
ContainerCreating: Container runtime creating the container
Running:           All containers started
Succeeded:         All containers exited with code 0 (for Jobs)
Failed:            At least one container exited with non-zero code
Unknown:           Node lost communication with API server
```

**Common stuck states and causes:**

| State | Common Causes |
|-------|--------------|
| `Pending` | No nodes available, insufficient resources, PVC not bound |
| `ContainerCreating` | Image pull failure, volume mount error |
| `CrashLoopBackOff` | Application crashing, command/args wrong |
| `OOMKilled` | Memory limit exceeded |
| `ImagePullBackOff` | Wrong image name, registry auth failure |

---

### 🛠️ Essential Pod Commands

```bash
# Create a pod quickly (imperative):
kubectl run nginx --image=nginx --port=80

# Create with labels:
kubectl run web-app --image=nginx --labels="app=web,tier=frontend"

# View pod details:
kubectl describe pod <pod-name>   # Full details including events

# Debug a crashing pod:
kubectl logs <pod-name>                     # Current container logs
kubectl logs <pod-name> --previous          # Previous container's logs (after crash)
kubectl logs <pod-name> -c <container-name> # Specific container in multi-container pod

# Execute command in running pod:
kubectl exec -it <pod-name> -- /bin/bash
kubectl exec -it <pod-name> -c <container-name> -- /bin/sh

# CKA Quick Tip - Generate YAML without creating:
kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml
```

---

### 🏭 Production Scenarios

**Scenario: Pod stuck in CrashLoopBackOff in EKS production cluster**
```bash
# Step 1: Check logs of the crashed container
kubectl logs order-service-7d4f8b-xkz92 --previous

# Common output: "Error: cannot connect to database at db:5432"
# Root cause: Database service not ready, missing environment variable

# Step 2: Check environment variables
kubectl exec -it order-service-7d4f8b-xkz92 -- env | grep DB

# Step 3: Check if service exists
kubectl get svc db -n production
```

---

### 📝 Section Summary

> A Pod is the smallest deployable unit in Kubernetes — a wrapper for one or more containers sharing network and storage. Always set resource requests/limits in production to prevent OOM and CPU throttling. Multi-container pods enable sidecar patterns like log collection and service mesh proxying.

---

## 1.10 ReplicaSets — High Availability Guarantee

### 📌 What Is a ReplicaSet?

A ReplicaSet ensures that a **specified number of Pod replicas** are running at all times. If a pod crashes or is deleted, the ReplicaSet controller creates a replacement. If there are too many pods (somehow), it deletes the excess.

**Why not just use Pods directly?** A bare Pod that crashes does NOT restart automatically. You need a controller (ReplicaSet) to watch and maintain the desired count.

---

### 🔄 How ReplicaSets Work Internally

```
ReplicaSet Spec: replicas: 3, selector: app=web

ReplicaSet Controller checks every few seconds:
  How many pods with label "app=web" exist?
  ├── 3 pods: ✅ Do nothing
  ├── 2 pods: ❌ Create 1 more pod
  ├── 4 pods: ❌ Delete 1 pod (excess)
  └── 0 pods: ❌ Create 3 pods
```

**Critical concept:** The ReplicaSet uses **labels and selectors** to find and manage its pods. It doesn't own pods by reference — it manages ALL pods matching the selector, even ones created before the ReplicaSet existed.

---

### 📄 ReplicaSet YAML — Complete Explanation

```yaml
apiVersion: apps/v1       # Note: v1 for ReplicationController, apps/v1 for ReplicaSet
kind: ReplicaSet
metadata:
  name: web-app-rs
  labels:
    app: web-app          # Labels on the ReplicaSet itself (for selecting it with Services)
spec:
  replicas: 3             # How many pods we want at all times
  selector:
    matchLabels:
      app: web-app        # Which pods does this ReplicaSet manage?
    # Advanced selector options:
    # matchExpressions:
    #   - key: app
    #     operator: In
    #     values: [web-app, web-frontend]
  template:               # Blueprint for creating new pods
    metadata:
      labels:
        app: web-app      # MUST match selector above!
    spec:
      containers:
      - name: web-app
        image: nginx:1.25
        ports:
        - containerPort: 80
```

**⚠️ Common Mistake:** The labels in `spec.template.metadata.labels` MUST match `spec.selector.matchLabels`. If they don't match, Kubernetes will reject the ReplicaSet.

---

### 🔄 ReplicaSet vs ReplicationController

| Feature | ReplicationController | ReplicaSet |
|---------|----------------------|------------|
| API Version | `v1` | `apps/v1` |
| Selector | Only equality (`=`) | Equality AND set-based (`In`, `NotIn`, `Exists`) |
| Status | Legacy (being phased out) | Current standard |
| Use in practice | Don't use for new workloads | Use via Deployments |

**Important:** In practice, you rarely create ReplicaSets directly. You create **Deployments** which manage ReplicaSets for you.

---

### 📊 Scaling a ReplicaSet

```bash
# Scale imperatively:
kubectl scale replicaset web-app-rs --replicas=5

# Scale by editing:
kubectl edit replicaset web-app-rs
# Change replicas field and save

# Scale by updating YAML file:
# Edit replicas in the YAML, then:
kubectl apply -f replicaset.yaml
```

---

### 📝 Section Summary

> ReplicaSets ensure a specified number of pod replicas are always running. They use label selectors to identify managed pods and continuously reconcile actual vs desired state. In practice, use Deployments instead of ReplicaSets directly, as Deployments provide rolling update and rollback capabilities on top of ReplicaSets.

---

## 1.11 Deployments — Production-Grade Workload Management

### 📌 What Is a Deployment?

A Deployment is a higher-level abstraction that manages ReplicaSets. It adds:
- **Rolling updates** — gradually replace old pods with new ones
- **Rollbacks** — revert to a previous version if something breaks
- **Pause/Resume** — make multiple changes atomically
- **Revision history** — track all changes

**Hierarchy:** `Deployment → ReplicaSet → Pods`

---

### 🏗️ Deployment Architecture

```
Deployment: web-app (image: nginx:1.24 → nginx:1.25 upgrade)

BEFORE UPGRADE:
Deployment
└── ReplicaSet v1 (nginx:1.24) [3/3 pods running]

DURING ROLLING UPDATE:
Deployment
├── ReplicaSet v1 (nginx:1.24) [2 pods] → scaling down
└── ReplicaSet v2 (nginx:1.25) [2 pods] → scaling up

AFTER UPGRADE:
Deployment
├── ReplicaSet v1 (nginx:1.24) [0 pods] → kept for rollback!
└── ReplicaSet v2 (nginx:1.25) [3 pods] → active
```

**Key insight:** Old ReplicaSets are **kept** after an upgrade (with 0 replicas) so you can roll back instantly. The revision history length is controlled by `spec.revisionHistoryLimit` (default: 10).

---

### 📄 Deployment YAML — Production-Grade Example

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  namespace: production
  labels:
    app: web-app
  annotations:
    kubernetes.io/change-cause: "Updated to nginx 1.25 for security patches"
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  strategy:
    type: RollingUpdate   # or Recreate
    rollingUpdate:
      maxUnavailable: 1   # Max pods that can be unavailable during update
      maxSurge: 1         # Max pods above desired count during update
  revisionHistoryLimit: 5 # Keep last 5 versions for rollback
  progressDeadlineSeconds: 600  # Fail if not progressed in 10 min
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: web-app
        image: nginx:1.25
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "500m"
```

---

### 🔄 Deployment Strategies Compared

#### Strategy 1: RollingUpdate (Default)
```
Old:  [v1] [v1] [v1]
Step1: [v1] [v1] [v2]   (1 old removed, 1 new added)
Step2: [v1] [v2] [v2]   (1 old removed, 1 new added)
Step3: [v2] [v2] [v2]   (last old removed, 1 new added)
```
✅ Zero downtime ✅ Gradual rollout ❌ Briefly runs 2 versions simultaneously

#### Strategy 2: Recreate
```
Old:  [v1] [v1] [v1]
Step1: [] [] []          (all old pods terminated first)
Step2: [v2] [v2] [v2]   (new pods created)
```
❌ Downtime during transition ✅ Never runs 2 versions simultaneously
Use when: migrations where two versions of app can't coexist

---

### 🔧 Essential Deployment Commands

```bash
# Create deployment:
kubectl create deployment web-app --image=nginx:1.24 --replicas=3

# Generate YAML (CKA exam technique):
kubectl create deployment web-app --image=nginx:1.24 --replicas=3 \
  --dry-run=client -o yaml > deployment.yaml

# Update image (triggers rolling update):
kubectl set image deployment/web-app web-app=nginx:1.25

# Watch the rollout in real-time:
kubectl rollout status deployment/web-app

# Check rollout history:
kubectl rollout history deployment/web-app

# Rollback to previous version:
kubectl rollout undo deployment/web-app

# Rollback to specific version:
kubectl rollout undo deployment/web-app --to-revision=2

# Pause (to make multiple changes without triggering multiple rollouts):
kubectl rollout pause deployment/web-app
kubectl set image deployment/web-app web-app=nginx:1.25
kubectl set resources deployment/web-app -c web-app --limits=cpu=500m
kubectl rollout resume deployment/web-app
```

---

### 🏭 Production Scenario: Deployment Stuck

```bash
# Symptom: Rolling update is stuck
kubectl rollout status deployment/web-app
# "Waiting for deployment to complete... 2/3 new replicas updated"

# Debug: Check why new pods are failing
kubectl get pods | grep web-app
# web-app-7f4d9-abc12   0/1   CrashLoopBackOff   5   3m
# web-app-7f4d9-def34   0/1   CrashLoopBackOff   5   3m

kubectl logs web-app-7f4d9-abc12
# Error: cannot connect to database at postgres:5432

# Quick rollback to restore service:
kubectl rollout undo deployment/web-app
kubectl rollout status deployment/web-app
# "successfully rolled out"
```

---

### 📝 Section Summary

> Deployments are the standard way to deploy stateless applications in Kubernetes. They manage ReplicaSets and provide rolling update and rollback capabilities. Always use rolling update strategy for zero-downtime deployments. The `kubectl rollout` commands are essential for CKA and production operations.

---

## 1.12 Services — Stable Network Endpoints

### 📌 Why Do We Need Services?

Pods have IP addresses, but those IPs are **ephemeral** — they change every time a pod restarts, gets rescheduled, or a deployment rolls out. Applications cannot depend on pod IPs.

**Services provide:** A stable, permanent network endpoint that routes traffic to matching pods, regardless of their current IP addresses.

---

### 🏗️ Service Architecture

```
Client → Service (stable IP/DNS) → Pod Selection via Labels
                                          │
                  ┌───────────────────────┼───────────────────┐
                  ▼                       ▼                   ▼
              Pod (10.244.1.5)    Pod (10.244.2.3)    Pod (10.244.3.7)
              [app=web]           [app=web]           [app=web]
```

The Service maintains an **Endpoints** object that kube-proxy uses to create forwarding rules. When pods come and go, the Endpoints object is automatically updated.

---

### 🔌 Service Types

#### Type 1: ClusterIP (Default)

```
┌─────────────────────────────────────────┐
│              Kubernetes Cluster          │
│                                          │
│   Frontend Pods ──► ClusterIP Service ──►│ Backend Pods
│   (10.244.x.x)       10.96.100.50:80     │ (10.244.x.x)
│                                          │
│   (NOT accessible from outside cluster)  │
└─────────────────────────────────────────┘
```

**Use case:** Internal microservice communication. Example: web app connecting to database, frontend connecting to backend API.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: backend-api
spec:
  type: ClusterIP    # Default, can be omitted
  selector:
    app: backend-api  # Routes to pods with this label
  ports:
  - port: 80         # Service port (what clients use)
    targetPort: 8080  # Pod port (where your app listens)
    protocol: TCP
```

#### Type 2: NodePort

```
External Client
      │
      ▼ 
Node IP:30080 (any node in cluster)
      │
      ▼
Service (ClusterIP: 10.96.100.50:80)
      │
      ▼
Pod (8080)
```

**NodePort range:** 30000-32767 (configurable)

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-nodeport
spec:
  type: NodePort
  selector:
    app: web-app
  ports:
  - port: 80           # ClusterIP port
    targetPort: 8080   # Pod port
    nodePort: 30080    # External port on node (optional, auto-assigned if omitted)
```

**Use case:** Expose service for external access without a cloud load balancer. Common in on-premises or development environments. **Not recommended for production** without an additional layer (Ingress or LB).

#### Type 3: LoadBalancer

```
External Users
      │
      ▼
Cloud Load Balancer (AWS ALB/NLB, GCP LB, Azure LB)
  Public IP: 34.102.50.100
      │
      ▼
NodePort on all nodes (30080)
      │
      ▼
Pods (app=web-app)
```

**Use case:** Expose a service directly to the internet using cloud-native load balancers. Works on AWS EKS, GKE, AKS. **Does NOT work on bare-metal clusters** without something like MetalLB.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-lb
spec:
  type: LoadBalancer
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 8080
```

---

### 🔍 Service DNS — How Applications Find Each Other

Kubernetes CoreDNS automatically creates DNS entries for every Service:

```
Service name: backend-api
Namespace: production

DNS names available:
  backend-api                            # within same namespace
  backend-api.production                 # from any namespace
  backend-api.production.svc            # standard form
  backend-api.production.svc.cluster.local  # fully qualified
```

```python
# Python app connecting to database service:
# Same namespace:
db.connect("postgres://postgres-db:5432/mydb")

# Different namespace:
db.connect("postgres://postgres-db.database.svc.cluster.local:5432/mydb")
```

---

### 🔧 Debugging Services

```bash
# Most common issue: Service not routing to pods
# Step 1: Check if endpoints are populated
kubectl get endpoints backend-api
# ENDPOINTS           AGE
# 10.244.1.5:8080    5m  ← Good, pods are matched
# <none>              5m  ← Bad, no pods matched!

# If endpoints are empty, check:
# 1. Pod labels match service selector?
kubectl get pods --show-labels | grep app=backend-api

# 2. Are pods running?
kubectl get pods -l app=backend-api

# 3. Is the service selector correct?
kubectl describe service backend-api | grep Selector
```

---

### 📝 Section Summary

> Services provide stable DNS names and IP addresses for accessing sets of Pods. ClusterIP is for internal communication, NodePort for external access without cloud features, and LoadBalancer for production internet-facing services with cloud load balancers. Services use label selectors to route traffic and automatically update endpoints as pods change.

---

## 1.13 Namespaces — Logical Cluster Partitioning

### 📌 What Are Namespaces?

Namespaces are Kubernetes' mechanism for **logical isolation** within a single cluster. They let you divide cluster resources between multiple teams, environments, or applications with:
- Separate resource quotas (prevent one team from consuming all cluster resources)
- Separate RBAC policies (dev team can't touch production namespace)
- Separate DNS entries (services are namespaced)
- Logical organization and grouping

---

### 🏗️ Default Namespaces

```
default          → Your workloads go here if you don't specify a namespace
kube-system      → Kubernetes control plane components (API server, etcd, CoreDNS, etc.)
kube-public      → Publicly readable, rarely used
kube-node-lease  → Node heartbeat lease objects (since K8s 1.14)
```

**⚠️ Never deploy your applications to `kube-system`**. Modifying system components can break the entire cluster.

---

### 🌐 Cross-Namespace Communication

```
Namespace: frontend               Namespace: backend
┌─────────────────────┐          ┌─────────────────────┐
│  web-app pods       │          │  api pods           │
│  ClusterIP: 10.x.x  │──────►  │  ClusterIP: 10.x.x  │
│  DNS: api-svc.backend│         │  Service: api-svc   │
└─────────────────────┘          └─────────────────────┘
```

```bash
# Within same namespace - short DNS name works:
curl http://api-svc:8080

# Cross-namespace - must use full DNS:
curl http://api-svc.backend.svc.cluster.local:8080
# Format: <service-name>.<namespace>.svc.cluster.local
```

---

### 🔧 Namespace Operations

```bash
# Create namespace:
kubectl create namespace staging
# OR declarative:
# kubectl apply -f namespace.yaml

# List namespaces:
kubectl get namespaces   # or: kubectl get ns

# Set default namespace for session:
kubectl config set-context --current --namespace=staging
# Now kubectl get pods shows pods from staging namespace

# View resources in specific namespace:
kubectl get pods -n production
kubectl get all -n kube-system

# View resources across ALL namespaces:
kubectl get pods --all-namespaces
kubectl get pods -A   # shorthand

# Delete namespace (WARNING: deletes EVERYTHING inside!):
kubectl delete namespace staging
```

---

### 📊 Resource Quotas — Limiting Namespace Consumption

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: production-quota
  namespace: production
spec:
  hard:
    pods: "50"                # Max 50 pods
    requests.cpu: "20"        # Sum of all CPU requests <= 20 cores
    requests.memory: "40Gi"   # Sum of all memory requests <= 40GB
    limits.cpu: "40"          # Sum of all CPU limits <= 40 cores
    limits.memory: "80Gi"
    services: "20"
    persistentvolumeclaims: "10"
```

```bash
# Apply the quota:
kubectl apply -f resource-quota.yaml

# Check current usage:
kubectl describe quota production-quota -n production
```

---

### 🏭 Production Namespace Strategy

In production EKS/on-prem clusters, a common namespace organization:

```
prod-frontend     → Frontend microservices
prod-backend      → Backend APIs
prod-data         → Databases, queues
prod-monitoring   → Prometheus, Grafana, alerting
staging           → Pre-production environment
dev               → Development workloads
infra             → Cluster-level infrastructure (cert-manager, ingress, etc.)
```

---

### 📝 Section Summary

> Namespaces provide logical isolation within a Kubernetes cluster, enabling resource quotas, RBAC boundaries, and organized multi-team/multi-environment cluster sharing. Cross-namespace service access requires the full DNS format: `service.namespace.svc.cluster.local`. Always plan your namespace strategy before deploying production workloads.

---

## 1.14 Imperative vs Declarative — GitOps Foundation

### 📌 The Core Difference

This concept is foundational to DevOps philosophy and GitOps practices.

**Imperative:** You tell Kubernetes **HOW** to achieve a state, step by step.
**Declarative:** You tell Kubernetes **WHAT** state you want, and it figures out how.

---

### 🔄 Imperative Approach

```bash
# Step-by-step commands — tells Kubernetes exactly what to do:
kubectl run nginx --image=nginx --replicas=3
kubectl expose deployment nginx --port=80 --type=NodePort
kubectl scale deployment nginx --replicas=5
kubectl set image deployment nginx nginx=nginx:1.25
```

**Pros:**
- Fast for one-off tasks
- Good for CKA exam speed
- Good for learning and experimentation

**Cons:**
- Not reproducible — no record of what was done
- Hard to collaborate — team doesn't know the current state
- Dangerous in production — mistakes are hard to reverse
- Can't be stored in Git (GitOps incompatible)

---

### 📄 Declarative Approach

```bash
# Define desired state in YAML file, then apply:
kubectl apply -f deployment.yaml

# Update by modifying the file and re-applying:
# (edit deployment.yaml to change image/replicas)
kubectl apply -f deployment.yaml

# Kubernetes figures out what changed and makes it happen
```

**Pros:**
- Reproducible — same file = same result
- Version controllable — store in Git
- Self-documenting — YAML describes the entire config
- Team-friendly — everyone can see what's deployed

**Cons:**
- More upfront work
- YAML can be verbose

---

### 🔑 kubectl apply — The Declarative Magic

```bash
# Apply a single file:
kubectl apply -f deployment.yaml

# Apply everything in a directory:
kubectl apply -f ./kubernetes-configs/

# Apply from URL:
kubectl apply -f https://raw.githubusercontent.com/example/manifests/main/deployment.yaml

# Dry run - see what would change without applying:
kubectl apply -f deployment.yaml --dry-run=client
kubectl apply -f deployment.yaml --dry-run=server   # More accurate, uses API validation
```

---

### 🏭 CKA Exam Strategy

For the CKA exam, a **hybrid approach** works best:

```bash
# Use imperative commands to GENERATE YAML quickly:
kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml
kubectl create deployment web --image=nginx --replicas=3 --dry-run=client -o yaml > deploy.yaml
kubectl expose deployment web --port=80 --type=NodePort --dry-run=client -o yaml > svc.yaml

# Edit the YAML if needed, then:
kubectl apply -f pod.yaml

# This is 3x faster than writing YAML from scratch!
```

---

### 📝 Section Summary

> Imperative commands are fast for ad-hoc tasks and CKA exam speed; declarative YAML files are the standard for production (enabling GitOps, reproducibility, and team collaboration). In practice, use `--dry-run=client -o yaml` to generate YAML templates quickly and then customize them.

---

## 1.15 kubectl apply — How It Works Internally

### 📌 The Three-Way Merge

When you run `kubectl apply`, Kubernetes performs a **three-way merge** using:
1. **Local file** — what you're applying now
2. **Live object** — what's currently in the cluster
3. **Last applied configuration** — what was last applied (stored as annotation)

```yaml
# The annotation Kubernetes adds to track last applied config:
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"name":"web-app"}...}
```

**Why three-way?** If someone manually changed a field with `kubectl edit` (not tracked in your local file), and you apply your file again, Kubernetes needs to decide: "Did the user remove this field intentionally, or was it added manually?"

By comparing the last-applied annotation with the live object, Kubernetes can detect manual changes and preserve them (unless you explicitly removed the field from your YAML).

---

### ⚠️ Mixing Imperative and Declarative — Avoid!

```bash
# DON'T DO THIS:
kubectl create -f deploy.yaml        # First time: works
kubectl create -f deploy.yaml        # Second time: ERROR - already exists!

# Instead use apply:
kubectl apply -f deploy.yaml         # First time: creates
kubectl apply -f deploy.yaml         # Second time: updates (if changed)
kubectl apply -f deploy.yaml         # Unchanged: no-op
```

**Production rule:** Once you start using `kubectl apply` on a resource, ALWAYS use `kubectl apply`. Don't mix with `kubectl replace`, `kubectl create`, or `kubectl edit` (which can clear the last-applied annotation).

---

## 1.16 Manual Scheduling

### 📌 What Is Manual Scheduling?

Normally, the kube-scheduler selects which node a pod runs on. But Kubernetes allows you to **bypass the scheduler** and specify exactly which node a pod should run on using the `nodeName` field.

**When to use this:**
- Testing node-specific behavior
- Running a pod on a specific node without labels (before labels are applied)
- Debugging node-specific issues
- When the scheduler is down (emergency recovery)

---

### 📄 Method 1: Set nodeName During Pod Creation

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: manual-nginx
spec:
  nodeName: worker-node-2    # Bypass scheduler, go directly to this node
  containers:
  - name: nginx
    image: nginx
```

**Limitation:** `nodeName` can ONLY be set at pod creation time. You cannot update it after the pod is created.

---

### 📄 Method 2: Binding Object (For Already-Created Pods)

If a pod exists without a nodeName (stuck in Pending), you can bind it using a Binding API call:

```yaml
apiVersion: v1
kind: Binding
metadata:
  name: manual-nginx
target:
  apiVersion: v1
  kind: Node
  name: worker-node-2
```

```bash
# Convert to JSON and POST to the binding endpoint:
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"apiVersion":"v1","kind":"Binding","metadata":{"name":"manual-nginx"},"target":{"apiVersion":"v1","kind":"Node","name":"worker-node-2"}}' \
  http://localhost:8001/api/v1/namespaces/default/pods/manual-nginx/binding
```

---

### 📝 Section Summary

> Manual scheduling bypasses the kube-scheduler by setting `nodeName` directly. Useful for debugging and emergencies but avoid in normal production use — let the scheduler do its job with proper affinity/taint rules.

---

## 1.17 Labels and Selectors

### 📌 Why Labels Are Foundational

Labels are **key-value pairs** attached to Kubernetes objects. They are the mechanism that connects everything in Kubernetes:
- Services find their Pods via labels
- ReplicaSets find their Pods via labels
- Deployments track their ReplicaSets via labels
- Network Policies target Pods via labels
- HPA targets Deployments via labels

**Without labels, Kubernetes has no way to group, select, or relate objects.**

---

### 🏷️ Label Best Practices

Kubernetes recommends a set of common labels:

```yaml
metadata:
  labels:
    # Standard recommended labels:
    app.kubernetes.io/name: web-app         # Application name
    app.kubernetes.io/instance: web-app-prod # Unique instance name
    app.kubernetes.io/version: "2.1.0"      # App version
    app.kubernetes.io/component: frontend   # Component type
    app.kubernetes.io/part-of: ecommerce    # Higher-level application
    app.kubernetes.io/managed-by: helm      # Tooling used
    
    # Custom operational labels:
    environment: production
    tier: frontend
    team: platform-engineering
    cost-center: "12345"
```

---

### 🔍 Selectors — Finding Objects by Labels

```bash
# Equality-based selectors:
kubectl get pods -l app=nginx               # app equals nginx
kubectl get pods -l app=nginx,tier=frontend # AND condition
kubectl get pods -l app!=nginx              # NOT equals

# Set-based selectors (more powerful):
kubectl get pods -l 'app in (nginx, apache)'
kubectl get pods -l 'app notin (nginx, apache)'
kubectl get pods -l 'app'                   # Has label 'app' (any value)
kubectl get pods -l '!app'                  # Does NOT have label 'app'

# Show labels:
kubectl get pods --show-labels
kubectl get pods -L app,tier  # Show specific labels as columns
```

---

### 📌 Annotations vs Labels

| Feature | Labels | Annotations |
|---------|--------|-------------|
| Purpose | Selection, grouping | Metadata, documentation |
| Used for filtering | ✅ Yes | ❌ No |
| API visibility | ✅ Yes | ✅ Yes |
| Size limit | 63 chars max | Much larger allowed |
| Examples | `app=web`, `env=prod` | Build number, contact info, Prometheus scrape config |

```yaml
metadata:
  labels:
    app: web-app           # Used to select this pod
  annotations:
    deployment-date: "2024-01-15"      # Not for selection
    team-contact: "platform@company.com"
    prometheus.io/scrape: "true"        # Tool-specific metadata
    prometheus.io/port: "8080"
```

---

### 📝 Section Summary

> Labels are the core grouping and selection mechanism in Kubernetes. Every selector in Services, ReplicaSets, Deployments, and Policies works through labels. Annotations store metadata but cannot be used for selection. Master label selectors for both CKA exams and production troubleshooting.

---

## 1.18 Taints and Tolerations

### 📌 What Problem Do They Solve?

Imagine you have a cluster with:
- 3 general-purpose worker nodes
- 1 high-memory node (for ML workloads)
- 1 GPU node (for inference workloads)

Without any restrictions, the scheduler might place ML jobs on general-purpose nodes (insufficient memory) and place regular web apps on the expensive GPU node (wasted resources).

**Taints** prevent pods from being scheduled on nodes unless they explicitly tolerate the taint. **Tolerations** allow pods to be scheduled on tainted nodes.

---

### 🔒 Taint Effects

| Effect | What Happens |
|--------|-------------|
| `NoSchedule` | New pods without matching toleration will NOT be scheduled |
| `PreferNoSchedule` | Scheduler tries to avoid placing pods here, but not guaranteed |
| `NoExecute` | New pods not scheduled AND existing pods without toleration are EVICTED |

---

### 🛠️ Working with Taints

```bash
# Taint a node (key=value:effect format):
kubectl taint nodes worker-gpu-1 workload=gpu:NoSchedule
kubectl taint nodes worker-gpu-1 workload=gpu:NoExecute

# View taints on a node:
kubectl describe node worker-gpu-1 | grep Taint

# Remove a taint (add - at the end):
kubectl taint nodes worker-gpu-1 workload=gpu:NoSchedule-

# View all node taints:
kubectl get nodes -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints
```

---

### 📄 Adding Tolerations to Pods

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: gpu-inference-job
spec:
  tolerations:
  - key: "workload"
    operator: "Equal"        # Equal (requires value) or Exists (ignores value)
    value: "gpu"
    effect: "NoSchedule"
  containers:
  - name: inference
    image: tensorflow/tensorflow:latest-gpu
    resources:
      limits:
        nvidia.com/gpu: 1
```

---

### ⚠️ Critical Concept: Taints Don't GUARANTEE Placement

**This is a very common exam question:**

Taints prevent unwanted pods FROM running on a node. But they don't guarantee your tolerated pod WILL run on that specific node.

```
Scenario:
- Node-1 has taint: gpu=true:NoSchedule
- Pod-A has toleration for gpu=true:NoSchedule

Possible outcomes:
  Pod-A might go to Node-1 (has toleration) ✅
  Pod-A might also go to Node-2 (no taint, no restriction) ✅
  
To GUARANTEE Pod-A goes to Node-1, use Node Affinity in addition to Taints.
```

---

### 🏗️ The Master Node Taint

By default in kubeadm clusters, master nodes have a taint to prevent workload pods:

```bash
kubectl describe node controlplane | grep Taint
# Taints: node-role.kubernetes.io/control-plane:NoSchedule
```

This ensures no application pods accidentally land on the master node, protecting control plane stability.

---

### 🏭 Production Use Case: GPU Node Isolation

```bash
# Taint the GPU node:
kubectl taint nodes gpu-node-1 nvidia.com/gpu=present:NoSchedule

# Add toleration to ML training job:
# (in pod spec):
# tolerations:
# - key: "nvidia.com/gpu"
#   operator: "Equal"
#   value: "present"
#   effect: "NoSchedule"
```

---

### 📝 Section Summary

> Taints on nodes repel pods that don't have matching tolerations. They ensure only intended workloads run on specialized nodes (GPU, high-memory, etc.). The three effects are `NoSchedule`, `PreferNoSchedule`, and `NoExecute`. Remember: tolerations allow scheduling ON tainted nodes but don't guarantee it — combine with node affinity for guaranteed placement.

---

## 1.19 Node Selectors

### 📌 Simple Node Selection

Node Selectors provide the simplest way to constrain pods to specific nodes based on **node labels**. They're simpler than Node Affinity but less expressive.

```bash
# First, label the node:
kubectl label nodes large-worker-1 size=large
kubectl label nodes medium-worker-2 size=medium

# Verify:
kubectl get nodes --show-labels | grep size
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: data-processor
spec:
  nodeSelector:
    size: large       # Pod will only be scheduled on nodes labeled size=large
  containers:
  - name: processor
    image: data-processor:latest
```

**Limitations of nodeSelector:**
- Can only use exact matching (`=`)
- Cannot express "large OR medium" nodes
- Cannot express "NOT small" nodes
- For complex requirements, use Node Affinity

---

## 1.20 Node Affinity

### 📌 Advanced Node Selection

Node Affinity is the advanced version of nodeSelector with support for complex expressions.

---

### 📊 Node Affinity Types

| Type | During Scheduling | During Execution |
|------|------------------|-----------------|
| `requiredDuringSchedulingIgnoredDuringExecution` | Must satisfy rules | Rules ignored once pod is running |
| `preferredDuringSchedulingIgnoredDuringExecution` | Prefers nodes satisfying rules | Rules ignored once pod is running |
| `requiredDuringSchedulingRequiredDuringExecution` | Must satisfy rules | Pod is evicted if rules no longer satisfied (**future**) |

---

### 📄 Node Affinity YAML Examples

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ml-training-job
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: node-type
            operator: In             # In, NotIn, Exists, DoesNotExist, Gt, Lt
            values:
            - large
            - xlarge
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 80    # Weight 1-100, higher = more preferred
        preference:
          matchExpressions:
          - key: zone
            operator: In
            values:
            - us-east-1a    # Prefer this zone but not required
  containers:
  - name: ml-trainer
    image: ml-framework:latest
```

**Operators explained:**
```
In:           key's value is in the provided list
NotIn:        key's value is NOT in the provided list
Exists:       node has this label key (any value)
DoesNotExist: node does NOT have this label key
Gt:           node's label value > provided value (numeric)
Lt:           node's label value < provided value (numeric)
```

---

### 🔄 Multiple nodeSelectorTerms (OR Logic)

```yaml
nodeSelectorTerms:
- matchExpressions:      # First term
  - key: size
    operator: In
    values: [large]
- matchExpressions:      # Second term (OR with first)
  - key: memory
    operator: Gt
    values: ["64000"]    # Gt requires single value as string
```

Multiple `nodeSelectorTerms` are **OR**'d together.
Multiple `matchExpressions` within one term are **AND**'d together.

---

### 📝 Section Summary

> Node Affinity provides powerful, expressive node selection beyond simple label matching. Use `required` for hard constraints (pod must run here) and `preferred` for soft preferences (pod should preferably run here). Node Affinity is the recommended approach over `nodeSelector` for any complex scheduling requirements.

---

## 1.21 Taints & Tolerations vs Node Affinity

### 📌 The Complete Strategy

| Tool | Controls What | Direction |
|------|--------------|-----------|
| **Taints** | Which pods can run on a node | Node pushes pods away |
| **Tolerations** | Which nodes a pod can be scheduled on (by having taints) | Pod pulls towards node |
| **Node Affinity** | Which nodes a pod prefers or requires | Pod pulls towards node |

**The combination for exclusive node usage:**

```
Goal: Only GPU pods on GPU nodes, and GPU pods ONLY on GPU nodes

Step 1: Taint GPU nodes → prevents non-GPU pods from landing here
Step 2: Add GPU toleration to GPU pods → allows them to land on GPU nodes
Step 3: Add Node Affinity to GPU pods → ensures they WILL land on GPU nodes

Result: GPU nodes exclusively run GPU workloads ✅
```

---

### 🏭 Real Production Implementation

```yaml
# GPU Node Configuration:
# kubectl taint nodes gpu-1 dedicated=gpu:NoSchedule

# GPU Training Job:
apiVersion: v1
kind: Pod
metadata:
  name: gpu-training
spec:
  tolerations:
  - key: "dedicated"
    operator: "Equal"
    value: "gpu"
    effect: "NoSchedule"
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: dedicated
            operator: In
            values: [gpu]
  containers:
  - name: trainer
    image: gpu-trainer:latest
    resources:
      limits:
        nvidia.com/gpu: 1
```

---

## 1.22 DaemonSets — One Pod Per Node

### 📌 What Is a DaemonSet?

A DaemonSet ensures that **exactly one copy** of a pod runs on **every node** in the cluster (or on nodes matching a selector). As nodes are added, pods are automatically added. As nodes are removed, pods are automatically deleted.

---

### 🔧 Key Use Cases

```
Cluster-wide infrastructure services that need to run on EVERY node:

1. Log Collection:    Fluentd, Filebeat, Promtail
2. Monitoring:        node-exporter (Prometheus), Datadog agent
3. Networking:        Weave-net, Calico, Flannel pods
4. Security:          Falco, Sysdig
5. Storage drivers:   Longhorn, OpenEBS
6. Kubernetes itself: kube-proxy (is a DaemonSet!)
```

---

### 📄 DaemonSet YAML

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
  updateStrategy:
    type: RollingUpdate      # Or OnDelete for manual control
    rollingUpdate:
      maxUnavailable: 1
  template:
    metadata:
      labels:
        name: node-exporter
    spec:
      # DaemonSets typically need host access:
      hostPID: true
      hostNetwork: true
      tolerations:
      - key: node-role.kubernetes.io/control-plane  # Also run on master
        effect: NoSchedule
        operator: Exists
      containers:
      - name: node-exporter
        image: prom/node-exporter:latest
        ports:
        - containerPort: 9100
          hostPort: 9100
        securityContext:
          runAsNonRoot: true
          runAsUser: 65534
        volumeMounts:
        - name: proc
          mountPath: /host/proc
          readOnly: true
      volumes:
      - name: proc
        hostPath:
          path: /proc
```

---

### 🔄 How DaemonSets Schedule Pods (Internal Detail)

Before Kubernetes 1.12, DaemonSets set `nodeName` directly (bypassing scheduler). Since 1.12, DaemonSets use the default scheduler with **node affinity rules** that target specific nodes. This gives better integration with scheduler features like priority, preemption, etc.

---

### 🛠️ DaemonSet Commands

```bash
# View DaemonSets:
kubectl get daemonsets -n kube-system
kubectl get ds  # shorthand

# Roll out an update:
kubectl set image daemonset/node-exporter node-exporter=prom/node-exporter:v1.7

# Watch rollout:
kubectl rollout status daemonset/node-exporter
```

---

### 📝 Section Summary

> DaemonSets ensure one pod per node, making them perfect for cluster-wide infrastructure services like monitoring agents, log collectors, and networking components. kube-proxy itself is a DaemonSet. They support rolling updates and can be confined to specific nodes using tolerations and node selectors.

---

## 1.23 Static Pods — Bootstrap Without a Master

### 📌 What Are Static Pods?

Static pods are pods managed **directly by the kubelet** on a specific node, **without the API server's involvement**. They are defined as YAML files in a specific directory on the node's filesystem that the kubelet monitors.

**Key insight:** This is how Kubernetes control plane components themselves are bootstrapped! When you run `kubeadm init`, it places YAML files for the API server, controller manager, scheduler, and etcd into `/etc/kubernetes/manifests/`. The kubelet running on the master node reads these files and starts those critical pods — even before the API server is available.

---

### 🔄 Static Pod vs Regular Pod

```
Regular Pod lifecycle:
User → API Server → etcd → Scheduler → kubelet → Container Runtime

Static Pod lifecycle:
YAML file on node → kubelet watches directory → Container Runtime
(kubelet creates a "mirror" read-only object in API server for visibility)
```

---

### 📁 Configuration

The static pod directory is configured in the kubelet's config:

```yaml
# /var/lib/kubelet/config.yaml
staticPodPath: /etc/kubernetes/manifests
```

Or passed as a command-line flag:
```bash
kubelet --pod-manifest-path=/etc/kubernetes/manifests
```

---

### 🔍 Identifying Static Pods

Static pods have the **node name** appended to their name:

```bash
kubectl get pods -n kube-system
# NAME                              READY   STATUS
# etcd-controlplane                 1/1     Running    ← Static pod (controlplane = node name)
# kube-apiserver-controlplane       1/1     Running    ← Static pod
# kube-scheduler-controlplane       1/1     Running    ← Static pod
# coredns-xxx                       1/1     Running    ← Regular pod (managed by Deployment)
```

---

### 🛠️ Creating and Deleting Static Pods

```bash
# Create a static pod by placing YAML in the manifests directory:
cat > /etc/kubernetes/manifests/my-static-pod.yaml << EOF
apiVersion: v1
kind: Pod
metadata:
  name: my-static-pod
spec:
  containers:
  - name: nginx
    image: nginx
EOF
# Kubelet automatically picks this up!

# Delete a static pod:
rm /etc/kubernetes/manifests/my-static-pod.yaml
# Kubelet automatically removes the pod!

# You CANNOT delete a static pod with kubectl delete:
kubectl delete pod etcd-controlplane -n kube-system
# It will immediately be recreated because the YAML file still exists!
```

---

### ⚖️ DaemonSets vs Static Pods Comparison

| Feature | Static Pods | DaemonSets |
|---------|-------------|------------|
| Who manages it | Kubelet directly | kube-controller-manager via API server |
| Requires API server | No | Yes |
| Works if API server is down | Yes | No |
| Visible in kubectl | Yes (mirror) | Yes |
| Can be deleted via kubectl | No (recreated) | Yes |
| Primary use case | Control plane bootstrapping | Node-level infrastructure |

---

### 📝 Section Summary

> Static pods are managed directly by the kubelet without API server involvement, making them ideal for bootstrapping control plane components. kubeadm uses static pods to deploy etcd, kube-apiserver, kube-scheduler, and kube-controller-manager. They cannot be deleted via kubectl — you must remove the YAML file from the manifests directory.

---

## 1.24 Priority Classes — Workload Prioritization

### 📌 Why Priority Classes Exist

In a shared cluster, when resources are scarce, Kubernetes needs to make decisions:
- Which pending pods should be scheduled first?
- If resources are full, which running pods can be evicted to make room for critical ones?

Priority Classes answer these questions.

---

### 📊 Priority Value Ranges

```
System-critical range (Kubernetes reserved):
  system-node-critical:    2000010000  ← kube-proxy, kubelet critical
  system-cluster-critical: 2000000000  ← CoreDNS, metrics-server

User workload range:
  -2,000,000,000 to 1,000,000,000

Typical production priorities:
  critical:   1000000000  ← Payment service, auth service
  high:       100000      ← User-facing APIs
  normal:     10000       ← Internal services (default)
  low:        100         ← Batch jobs, analytics
  background: 0           ← Cleanup jobs, reports
```

---

### 📄 Creating and Using Priority Classes

```yaml
# Create the priority class:
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: critical-production
value: 1000000000
globalDefault: false    # Only ONE can be true (the default for pods without priorityClassName)
preemptionPolicy: PreemptLowerPriority  # Or Never (don't evict others)
description: "For critical production services"

---
# Use in a pod/deployment:
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payment-service
spec:
  template:
    spec:
      priorityClassName: critical-production   # Reference the PriorityClass
      containers:
      - name: payment-service
        image: payment-service:latest
```

---

### 🔄 Preemption — Evicting Lower Priority Pods

With `PreemptLowerPriority`:
```
Scenario:
- Cluster is full
- New high-priority pod needs 2 CPUs
- Low-priority batch job is using 2 CPUs
- Kubernetes evicts the batch job to make room
```

With `Never`:
```
Scenario:
- Cluster is full
- New high-priority pod needs 2 CPUs
- Pod waits in queue (does NOT evict others)
- Gets scheduled when resources free up naturally
```

---

### 📝 Section Summary

> Priority Classes control the order of pod scheduling and enable preemption (eviction of lower-priority pods). System-critical classes protect control plane components. Define priorities for your workloads to ensure critical services always get scheduled first in resource-constrained situations.

---

## 1.25 Multiple Schedulers & Scheduler Profiles

### 📌 When Do You Need Custom Schedulers?

The default Kubernetes scheduler handles most use cases, but specialized workloads may need custom logic:
- ML training jobs that need gang scheduling (all pods start at the same time or none do)
- Financial workloads with specific placement compliance requirements
- Game servers needing custom affinity logic

---

### 🔌 Running Multiple Schedulers

You can run multiple schedulers simultaneously. Each pod specifies which scheduler should handle it:

```yaml
# In pod spec:
spec:
  schedulerName: my-custom-scheduler  # Default is "default-scheduler"
  containers:
  - name: app
    image: myapp:latest
```

---

### 📄 Multiple Profiles (Preferred Approach — Since K8s 1.18)

Instead of running separate scheduler processes, Kubernetes 1.18+ allows multiple **profiles** within a single scheduler binary. Each profile behaves independently:

```yaml
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
- schedulerName: default-scheduler     # Profile 1
  plugins:
    score:
      enabled:
      - name: NodeResourcesFit
      - name: ImageLocality
      
- schedulerName: high-priority-scheduler  # Profile 2
  plugins:
    preScore:
      disabled:
      - name: '*'                     # Disable all preScore plugins
    score:
      disabled:
      - name: TaintToleration         # Disable taint scoring
      enabled:
      - name: MyCustomPriorityPlugin  # Enable custom plugin
      
- schedulerName: batch-scheduler      # Profile 3
  plugins:
    filter:
      enabled:
      - name: BatchGangScheduler      # Custom batch filter
```

---

### 🔧 Verifying Custom Scheduler Assignment

```bash
# Check which scheduler assigned a pod:
kubectl get events --field-selector involvedObject.name=my-pod
# Look for: source = my-custom-scheduler

# Or:
kubectl describe pod my-pod | grep -A 5 Events
# Successfully assigned ... by my-custom-scheduler
```

---

### 📝 Section Summary

> Multiple schedulers or scheduler profiles allow specialized scheduling logic for different workload types. The preferred approach since K8s 1.18 is multiple profiles in a single scheduler binary, reducing operational overhead. Each pod can specify which scheduler profile should handle it via `spec.schedulerName`.

---

## 1.26 Admission Controllers

### 📌 What Are Admission Controllers?

After authentication and authorization, API server requests pass through **admission controllers** — plugins that can validate or modify requests before objects are persisted in etcd.

```
Request Flow:
kubectl apply → Authentication → Authorization → Admission Controllers → etcd

Types:
  Mutating Admission Controllers:   Can MODIFY the request
  Validating Admission Controllers: Can APPROVE or REJECT the request
  (Some do both)
```

---

### 🔌 Built-in Admission Controllers

| Controller | Type | What It Does |
|-----------|------|-------------|
| `NamespaceLifecycle` | Validating | Rejects requests to non-existent namespaces |
| `LimitRanger` | Mutating | Applies default CPU/memory limits to pods |
| `DefaultStorageClass` | Mutating | Adds default StorageClass to PVCs without one |
| `AlwaysPullImages` | Mutating | Forces image pull policy to Always |
| `NodeRestriction` | Validating | Limits what kubelets can modify |
| `PodSecurity` | Validating | Enforces Pod Security Standards |
| `ResourceQuota` | Validating | Enforces resource quotas |

---

### 🔧 Configuring Admission Controllers

```bash
# View enabled admission controllers:
kube-apiserver -h | grep enable-admission-plugins

# In kubeadm cluster, check the manifest:
grep admission /etc/kubernetes/manifests/kube-apiserver.yaml

# Enable a controller:
# Edit /etc/kubernetes/manifests/kube-apiserver.yaml
# Add to command:
# - --enable-admission-plugins=NodeRestriction,LimitRanger,NamespaceLifecycle

# Disable a controller:
# - --disable-admission-plugins=DefaultStorageClass
```

---

### 🌐 Webhook Admission Controllers — Custom Logic

For custom validation/mutation logic:

```
                    ┌───────────────────────────────────────┐
kubectl apply ────► │        kube-apiserver                 │
                    │                                       │
                    │  AuthN → AuthZ → Built-in Admission   │
                    │                    │                  │
                    │          ┌─────────┘                  │
                    │          ▼                            │
                    │  MutatingWebhook ──► Your Webhook Server
                    │      │                               │
                    │  ValidatingWebhook ─► Your Webhook Server
                    │                                       │
                    └───────────────────────────────────────┘
```

**Register a webhook:**

```yaml
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: pod-policy-validator
webhooks:
- name: validate.pods.example.com
  clientConfig:
    service:
      namespace: webhook-system
      name: policy-webhook-svc
    caBundle: <base64-CA-cert>
  rules:
  - apiGroups: [""]
    apiVersions: ["v1"]
    operations: ["CREATE", "UPDATE"]
    resources: ["pods"]
  admissionReviewVersions: ["v1"]
  sideEffects: None
  failurePolicy: Fail    # Fail or Ignore (if webhook unavailable)
```

---

### 📝 Section Summary

> Admission controllers are plugins that intercept API requests after authentication/authorization and can validate or modify them. They're critical for enforcing cluster policies (resource limits, security requirements, naming conventions). Custom logic can be implemented via mutating and validating webhooks that integrate with external services.

---

# Part 2: Logging, Monitoring, Lifecycle & Cluster Maintenance

---

## 2.1 Managing Application Logs

### 📌 Kubernetes Logging Architecture

In Kubernetes, container logs are stored on the node where the container runs. The kubelet manages log rotation. By default, you access logs through the API server, which retrieves them from the kubelet on the node.

---

### 🔧 Essential Log Commands

```bash
# Basic pod logs:
kubectl logs <pod-name>

# Stream logs in real-time (like tail -f):
kubectl logs -f <pod-name>

# Last N lines only:
kubectl logs --tail=100 <pod-name>

# Logs from last hour:
kubectl logs --since=1h <pod-name>

# Logs since specific time:
kubectl logs --since-time="2024-01-15T10:00:00Z" <pod-name>

# CRITICAL: Multi-container pod - must specify container:
kubectl logs <pod-name> -c <container-name>

# If pod has crashed - get logs from previous instance:
kubectl logs <pod-name> --previous   # Critical for debugging CrashLoopBackOff!

# Get logs from all pods matching a label:
kubectl logs -l app=web-app --all-containers=true
```

---

### 🏭 Production Logging Architecture (EKS/On-Prem)

```
Pod (writes to stdout/stderr)
         │
         ▼
Node's filesystem (/var/log/containers/*.log)
         │
         ▼
DaemonSet Log Collector (Fluentd/Filebeat/Promtail)
         │
         ▼
Central Log Store (Elasticsearch/Loki/CloudWatch/Datadog)
         │
         ▼
Log Analysis UI (Kibana/Grafana/Datadog Dashboard)
```

**Production insight:** `kubectl logs` is great for quick debugging but never rely on it as your sole logging strategy in production. Use a centralized log aggregation solution (EFK stack, Grafana Loki, etc.) because:
- Pods can be evicted, losing their logs
- kubectl logs only shows current/previous instance, not all historical logs
- Searching across all pods is impossible with raw kubectl

---

### 📝 Section Summary

> Kubernetes logs are accessed via `kubectl logs` with options for streaming, filtering by time, and accessing previous container instances. Always implement centralized log aggregation in production using DaemonSet-based collectors feeding into Elasticsearch/Loki/CloudWatch.

---

## 2.2 Rolling Updates and Rollbacks

### 📌 Rollout Concepts

Every time you modify a Deployment (image update, env var change, resource limit change), Kubernetes creates a new **rollout** — a controlled transition from the current state to the desired state. Each rollout creates a new **revision**.

---

### 🔄 Rolling Update Deep Dive

```
Deployment: replicas=4, maxUnavailable=1, maxSurge=1

Initial state:  [v1] [v1] [v1] [v1]    (4 pods running)
                       ↑ Update triggered
Max allowed:    min 3 running (maxUnavailable=1), max 5 total (maxSurge=1)

Step 1:         [v1] [v1] [v1] [v2]    (1 v2 added, still 4)
Step 2:         [v1] [v1] [v2] [v2]    (1 v1 removed, 1 v2 added)
Step 3:         [v1] [v2] [v2] [v2]    (1 v1 removed, 1 v2 added)
Step 4:         [v2] [v2] [v2] [v2]    (last v1 removed, done)

✅ Never fewer than 3 pods running (zero downtime)
✅ Never more than 5 pods total
```

---

### 🛠️ Critical Rollout Commands

```bash
# Check rollout status (blocks until complete or fails):
kubectl rollout status deployment/web-app

# View rollout history:
kubectl rollout history deployment/web-app
# REVISION  CHANGE-CAUSE
# 1         Initial deployment
# 2         Updated to nginx:1.25
# 3         Updated memory limits

# Add a change cause annotation (for better history):
kubectl annotate deployment/web-app kubernetes.io/change-cause="Updated nginx to 1.25 for CVE-2024-1234"

# View specific revision details:
kubectl rollout history deployment/web-app --revision=2

# Rollback to previous version:
kubectl rollout undo deployment/web-app

# Rollback to specific version:
kubectl rollout undo deployment/web-app --to-revision=1

# Pause rolling update (make multiple changes safely):
kubectl rollout pause deployment/web-app
kubectl set image deployment/web-app web-app=nginx:1.25
kubectl set env deployment/web-app APP_ENV=production
kubectl set resources deployment/web-app -c web-app --limits=memory=512Mi
kubectl rollout resume deployment/web-app    # All changes applied at once
```

---

### ⚠️ Common Production Mistakes

**Mistake 1: Not checking rollout status**
```bash
# BAD: Assume deployment is done after set image
kubectl set image deployment/web-app web-app=nginx:1.25

# GOOD: Wait and verify
kubectl set image deployment/web-app web-app=nginx:1.25 && \
  kubectl rollout status deployment/web-app --timeout=300s
echo "Deployment successful"
```

**Mistake 2: No rollout annotations**
```bash
# Without annotations, history is meaningless:
# REVISION  CHANGE-CAUSE
# 1         <none>
# 2         <none>
# 3         <none>

# Always record the change:
kubectl set image deployment/web-app web-app=nginx:1.25 --record  # deprecated
# OR use annotations:
kubectl annotate deployment web-app kubernetes.io/change-cause="nginx 1.25 - security update"
```

---

### 📝 Section Summary

> Rolling updates replace pods gradually to ensure zero downtime. `maxUnavailable` and `maxSurge` control the pace. Always verify rollout status after updates and use annotations to make history meaningful. Roll back instantly with `kubectl rollout undo` if issues arise.

---

## 2.3 Commands and Arguments in Docker & Kubernetes

### 📌 Understanding ENTRYPOINT and CMD

This is a frequently misunderstood topic and appears in CKA exams.

**Docker's `CMD` and `ENTRYPOINT`:**

```dockerfile
# Dockerfile 1: Only CMD
FROM ubuntu
CMD ["sleep", "5"]
# docker run ubuntu-sleeper           → runs: sleep 5
# docker run ubuntu-sleeper 10        → runs: 10 (replaces CMD entirely)
# docker run ubuntu-sleeper sleep 10  → runs: sleep 10

# Dockerfile 2: Only ENTRYPOINT
FROM ubuntu
ENTRYPOINT ["sleep"]
# docker run ubuntu-sleeper           → runs: sleep (no arg - ERROR)
# docker run ubuntu-sleeper 10        → runs: sleep 10
# docker run --entrypoint date ubuntu-sleeper  → runs: date (overrides ENTRYPOINT)

# Dockerfile 3: Both (Best Practice)
FROM ubuntu
ENTRYPOINT ["sleep"]
CMD ["5"]           # Default arg for ENTRYPOINT
# docker run ubuntu-sleeper           → runs: sleep 5  (CMD provides default)
# docker run ubuntu-sleeper 10        → runs: sleep 10  (CMD overridden)
# docker run --entrypoint sleep2.0 ubuntu-sleeper 10 → runs: sleep2.0 10
```

---

### 🔄 Kubernetes Mapping

```
Docker:       ENTRYPOINT  →  Kubernetes: command
Docker:       CMD         →  Kubernetes: args
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: command-demo
spec:
  containers:
  - name: demo
    image: ubuntu-sleeper      # ENTRYPOINT=sleep, CMD=5
    command: ["sleep2.0"]      # Overrides ENTRYPOINT
    args: ["10"]               # Overrides CMD
    # Resulting command: sleep2.0 10
```

**Another example:**

```yaml
  containers:
  - name: demo
    image: ubuntu-sleeper      # ENTRYPOINT=sleep, CMD=5
    args: ["10"]               # Only override CMD, keep ENTRYPOINT
    # Resulting command: sleep 10
```

---

### 🔑 Key Rules Summary

| Scenario | command | args | Result |
|----------|---------|------|--------|
| Nothing overridden | _(empty)_ | _(empty)_ | Dockerfile ENTRYPOINT + CMD |
| Only args | _(empty)_ | `["10"]` | Dockerfile ENTRYPOINT + "10" |
| Only command | `["sleep2.0"]` | _(empty)_ | "sleep2.0" + Dockerfile CMD |
| Both | `["sleep2.0"]` | `["10"]` | "sleep2.0 10" |

---

### 📝 Section Summary

> `command` in Kubernetes overrides Docker's `ENTRYPOINT`, and `args` overrides Docker's `CMD`. This is a very common source of confusion. Remember the mapping and you'll never struggle with this topic.

---

## 2.4 Secrets — Secure Configuration Management

### 📌 Why Secrets Exist

ConfigMaps store configuration data in plain text. For sensitive data (passwords, API keys, TLS certificates), you need Secrets, which:
- Store data Base64-encoded (not plain text in YAML)
- Can be encrypted at rest in etcd (when configured)
- Have stricter RBAC controls
- Are not printed in pod logs by default

**⚠️ Important:** Base64 is NOT encryption — it's encoding. Anyone with access to the Secret YAML can decode it. Secrets are only truly secure when combined with encryption at rest and proper RBAC.

---

### 🔧 Creating Secrets

```bash
# Imperative - from literal values:
kubectl create secret generic db-credentials \
  --from-literal=DB_HOST=postgres \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASSWORD=SuperSecure123!

# Imperative - from file:
kubectl create secret generic tls-secret \
  --from-file=tls.crt=/path/to/cert.crt \
  --from-file=tls.key=/path/to/cert.key

# Imperative - TLS secret type:
kubectl create secret tls web-tls \
  --cert=tls.crt \
  --key=tls.key

# Verify (values are base64 encoded):
kubectl get secret db-credentials -o yaml
```

**Declarative approach (CAREFUL - don't commit plain values to Git!):**

```bash
# Base64 encode your values first:
echo -n 'SuperSecure123!' | base64
# U3VwZXJTZWN1cmUxMjMh
```

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
type: Opaque   # Generic secret (other types: kubernetes.io/tls, kubernetes.io/dockerconfigjson)
data:
  DB_HOST: cG9zdGdyZXM=       # base64("postgres")
  DB_USER: YWRtaW4=            # base64("admin")
  DB_PASSWORD: U3VwZXJTZWN1cmUxMjMh  # base64("SuperSecure123!")
```

---

### 🔌 Injecting Secrets into Pods

**Method 1: Environment Variables (Most Common)**

```yaml
spec:
  containers:
  - name: app
    image: myapp:latest
    env:
    - name: DB_PASSWORD           # Env var name in container
      valueFrom:
        secretKeyRef:
          name: db-credentials    # Secret name
          key: DB_PASSWORD        # Key within the secret
    envFrom:                      # Inject ALL keys as env vars at once
    - secretRef:
        name: db-credentials
```

**Method 2: Volume Mount (Best for Files like TLS Certs)**

```yaml
spec:
  volumes:
  - name: secret-volume
    secret:
      secretName: db-credentials
      defaultMode: 0400           # Permissions on mounted files
  containers:
  - name: app
    image: myapp:latest
    volumeMounts:
    - name: secret-volume
      mountPath: /etc/secrets
      readOnly: true
```

```bash
# In the container, each key becomes a file:
ls /etc/secrets/
# DB_HOST   DB_USER   DB_PASSWORD

cat /etc/secrets/DB_PASSWORD
# SuperSecure123!
```

---

### 🏭 Production Security for Secrets

```
┌─────────────────────────────────────────────────────────────┐
│  PRODUCTION SECRET MANAGEMENT BEST PRACTICES                 │
│                                                              │
│  1. ✅ Encryption at Rest (etcd encryption enabled)         │
│  2. ✅ Strict RBAC (only authorized SAs can read secrets)    │
│  3. ✅ External Secret Management (AWS Secrets Manager,      │
│        HashiCorp Vault, Azure Key Vault)                    │
│  4. ✅ No secrets in Git repositories                        │
│  5. ✅ Regular rotation of secrets                          │
│  6. ✅ Audit logging for secret access                      │
│  7. ❌ Never use plain text ConfigMaps for sensitive data    │
└─────────────────────────────────────────────────────────────┘
```

**Using AWS Secrets Manager with Kubernetes (production pattern):**
- Install External Secrets Operator (ESO)
- Create ExternalSecret resources that sync from AWS Secrets Manager → K8s Secrets
- The actual secret value never lives in Git

---

### 📝 Section Summary

> Secrets store sensitive data Base64-encoded and can be injected into pods as environment variables or files. They are more secure than ConfigMaps but require encryption at rest and proper RBAC to be truly safe. For production, use external secret management solutions (Vault, AWS Secrets Manager) via the External Secrets Operator.

---

## 2.5 Encrypting Secrets at Rest

### 📌 Why Encryption at Rest Matters

By default, Kubernetes stores Secrets in etcd as Base64-encoded values — anyone who can access etcd directly can read all your secrets. Encryption at rest ensures that even if someone gains access to etcd data files, the secrets are encrypted.

---

### 🔧 Step-by-Step Setup

**Step 1: Verify current state (no encryption)**

```bash
# Query etcd directly and see the secret in plaintext:
ETCDCTL_API=3 etcdctl \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  get /registry/secrets/default/my-secret | hexdump -C

# You'll see the Base64-decoded value in plain text!
```

**Step 2: Generate encryption key**

```bash
# Generate a 32-byte random key:
head -c 32 /dev/urandom | base64
# y0xTt+U6xgRdNxe4nDYYsijOGgRDoUYC+wAwOKeNfPs=
```

**Step 3: Create EncryptionConfiguration**

```yaml
# /etc/kubernetes/enc/enc.yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
- resources:
  - secrets            # Can also include configmaps, etc.
  providers:
  - aescbc:            # AES-CBC encryption
      keys:
      - name: key1
        secret: y0xTt+U6xgRdNxe4nDYYsijOGgRDoUYC+wAwOKeNfPs=  # Your generated key
  - identity: {}       # IMPORTANT: Keep this! Allows reading existing unencrypted secrets
```

**Step 4: Configure kube-apiserver**

```yaml
# Edit /etc/kubernetes/manifests/kube-apiserver.yaml
spec:
  containers:
  - command:
    - kube-apiserver
    - --encryption-provider-config=/etc/kubernetes/enc/enc.yaml  # Add this
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

**Step 5: Re-encrypt all existing secrets**

```bash
# New secrets will be encrypted, but existing ones aren't yet
# Re-encrypt all existing secrets:
kubectl get secrets --all-namespaces -o json | kubectl replace -f -

# Verify encryption (new secrets should show encrypted data in etcd):
kubectl create secret generic test-secret --from-literal=test=value
ETCDCTL_API=3 etcdctl get /registry/secrets/default/test-secret | hexdump -C
# Data should be encrypted now
```

---

### 📝 Section Summary

> Encryption at rest protects secrets stored in etcd from direct access. Configure it via EncryptionConfiguration in the kube-apiserver manifest. After enabling, re-encrypt existing secrets. Use AES-CBC or AES-GCM encryption providers. Keep the `identity: {}` provider to read previously unencrypted data during transition.

---

## 2.6 Multi-Container Pods

### 📌 The Sidecar Pattern

Multi-container pods enable several important architectural patterns. The most common is the **sidecar pattern** — a helper container that augments the main container's functionality.

```
┌──────────────────────────────────────────────────────┐
│                       POD                             │
│                                                       │
│  ┌─────────────────┐     ┌────────────────────────┐  │
│  │  Main Container │     │  Sidecar Container     │  │
│  │  (web-app)      │     │  (envoy proxy /        │  │
│  │                 │     │   log collector /       │  │
│  │  Writes logs to │────►│   config reloader)     │  │
│  │  /var/log/app   │     │  Reads from /var/log   │  │
│  └─────────────────┘     └────────────────────────┘  │
│          │                         │                  │
│          └──────────┬──────────────┘                  │
│               Shared Volume                           │
│               (emptyDir: /var/log)                    │
│                                                       │
│  Shared: Network (localhost), IP, Volumes             │
└──────────────────────────────────────────────────────┘
```

---

### 🔌 Common Multi-Container Patterns

| Pattern | Description | Example |
|---------|-------------|---------|
| **Sidecar** | Extends/enhances main container | Envoy proxy, log collector |
| **Ambassador** | Proxy for external services | Local proxy for external DB |
| **Adapter** | Transforms output format | Format conversion for monitoring |
| **Init Container** | Runs before main containers | Database migration, config download |

---

### 📄 Multi-Container Pod YAML

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-with-logging
spec:
  # Init containers run first, in order:
  initContainers:
  - name: init-db-migration
    image: migrate:latest
    command: ['sh', '-c', 'migrate -database "$DB_URL" up']
    env:
    - name: DB_URL
      valueFrom:
        secretKeyRef:
          name: db-secret
          key: url
          
  # Main containers run together:
  containers:
  - name: web-app
    image: myapp:latest
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/app
      
  - name: log-collector       # Sidecar
    image: fluent/fluentd:latest
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/app  # Same mount as main container!
    - name: config
      mountPath: /etc/fluent
      
  volumes:
  - name: shared-logs
    emptyDir: {}              # Temporary, pod-lifetime volume
  - name: config
    configMap:
      name: fluentd-config
```

---

### 🔑 Important Multi-Container Behaviors

```bash
# In a multi-container pod, MUST specify container for logs:
kubectl logs my-pod -c web-app
kubectl logs my-pod -c log-collector

# Exec into specific container:
kubectl exec -it my-pod -c web-app -- /bin/bash

# All containers see each other via localhost:
# Inside web-app: curl localhost:24224  ← reaches log-collector
# Inside log-collector: curl localhost:8080 ← reaches web-app
```

---

### 📝 Section Summary

> Multi-container pods allow related containers to share network, storage, and lifecycle. The sidecar pattern is the most common, enabling log collection, service mesh proxying, and config management alongside the main application. Init containers handle pre-start tasks like database migrations.

---

## 2.7 Autoscaling — HPA and VPA

### 📌 Types of Kubernetes Autoscaling

```
┌─────────────────────────────────────────────────────────────────┐
│                    KUBERNETES AUTOSCALING                        │
│                                                                  │
│  Workload Level:                                                 │
│  ��──────────────────┐  ┌──────────────────┐                     │
│  │  HPA             │  │  VPA             │                     │
│  │  (Horizontal Pod │  │  (Vertical Pod   │                     │
│  │   Autoscaler)    │  │   Autoscaler)    │                     │
│  │  Adds more pods  │  │  Adds more CPU/  │                     │
│  └──────────────────┘  │  RAM to pods     │                     │
│                         └──────────────────┘                     │
│  Cluster Level:                                                  │
│  ┌──────────────────────────────────────┐                        │
│  │  Cluster Autoscaler                  │                        │
│  │  Adds/removes nodes from the cluster  │                        │
│  └──────────────────────────────────────┘                        │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔄 Horizontal Pod Autoscaler (HPA)

HPA scales the **number of pods** based on observed metrics (CPU, memory, or custom metrics).

**Prerequisite:** metrics-server must be installed in the cluster.

```bash
# Install metrics-server (if not present):
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Verify it works:
kubectl top pods
kubectl top nodes
```

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: web-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web-app
  minReplicas: 2    # Never scale below this
  maxReplicas: 20   # Never scale above this
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70   # Scale when avg CPU > 70%
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80   # Scale when avg memory > 80%
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300   # Wait 5 min before scale down
      policies:
      - type: Percent
        value: 50
        periodSeconds: 60    # Scale down max 50% per minute
    scaleUp:
      stabilizationWindowSeconds: 60    # Wait 1 min before scale up
      policies:
      - type: Percent
        value: 100
        periodSeconds: 30    # Scale up max 100% per 30 seconds
```

```bash
# Create HPA imperatively:
kubectl autoscale deployment web-app
