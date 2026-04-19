# 🚀 Kubernetes CKA Study Notes — Complete Reference Guide

> **Prepared by:** Senior DevOps Engineer | CKA-Level Reference  
> **Coverage:** Core Concepts · Scheduling · Logging & Monitoring · Application Lifecycle Management · Cluster Maintenance

---

## 📑 Table of Contents

1. [Cluster Architecture](#1-cluster-architecture)
2. [Container Runtimes — Docker vs ContainerD](#2-container-runtimes--docker-vs-containerd)
3. [ETCD](#3-etcd)
4. [Kube API Server](#4-kube-api-server)
5. [Kube Controller Manager](#5-kube-controller-manager)
6. [Kube Scheduler](#6-kube-scheduler)
7. [Kubelet](#7-kubelet)
8. [Kube Proxy](#8-kube-proxy)
9. [Pods](#9-pods)
10. [ReplicaSets](#10-replicasets)
11. [Deployments](#11-deployments)
12. [Services](#12-services)
13. [Namespaces](#13-namespaces)
14. [Imperative vs Declarative](#14-imperative-vs-declarative)
15. [kubectl apply — Internal Working](#15-kubectl-apply--internal-working)
16. [Scheduling — Manual Scheduling](#16-scheduling--manual-scheduling)
17. [Labels and Selectors](#17-labels-and-selectors)
18. [Taints and Tolerations](#18-taints-and-tolerations)
19. [Node Selectors](#19-node-selectors)
20. [Node Affinity](#20-node-affinity)
21. [Taints vs Node Affinity](#21-taints-vs-node-affinity)
22. [DaemonSets](#22-daemonsets)
23. [Static Pods](#23-static-pods)
24. [Priority Classes](#24-priority-classes)
25. [Multiple Schedulers & Scheduler Profiles](#25-multiple-schedulers--scheduler-profiles)
26. [Admission Controllers](#26-admission-controllers)
27. [Logging in Kubernetes](#27-logging-in-kubernetes)
28. [Application Lifecycle Management](#28-application-lifecycle-management)
29. [Commands and Arguments — Docker & Kubernetes](#29-commands-and-arguments--docker--kubernetes)
30. [Secrets](#30-secrets)
31. [Encrypting Secrets at Rest](#31-encrypting-secrets-at-rest)
32. [Multi-Container Pods](#32-multi-container-pods)
33. [Autoscaling — HPA & VPA](#33-autoscaling--hpa--vpa)
34. [In-Place Pod Resize](#34-in-place-pod-resize)
35. [Cluster Maintenance](#35-cluster-maintenance)
36. [OS Upgrades](#36-os-upgrades)
37. [Cluster Upgrade with kubeadm](#37-cluster-upgrade-with-kubeadm)
38. [Backup and Restore](#38-backup-and-restore)

---

## 1. Cluster Architecture

### 🧠 What is Kubernetes?

Kubernetes (K8s) is an **open-source container orchestration platform** that automates deployment, scaling, and management of containerized applications.

### 🏗️ High-Level Architecture

Think of a Kubernetes cluster as a **fleet of ships**:
- **Master Node (Control Ship)** — Manages and monitors everything
- **Worker Nodes (Cargo Ships)** — Run the actual application containers

```
┌───────────────────────────────────────────────────────┐
│                    MASTER NODE                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────┐ │
│  │  etcd    │  │ kube-    │  │Controller│  │ API  │ │
│  │ cluster  │  │scheduler │  │ Manager  │  │Server│ │
│  └──────────┘  └──────────┘  └──────────┘  └──────┘ │
└───────────────────────────────────────────────────────┘
         │               │              │
┌────────▼───────┐ ┌─────▼──────┐ ┌───▼────────────┐
│  WORKER NODE 1 │ │WORKER NODE2│ │ WORKER NODE 3  │
│  ┌──────────┐  │ │            │ │                │
│  │ kubelet  │  │ │  kubelet   │ │    kubelet     │
│  │kube-proxy│  │ │ kube-proxy │ │   kube-proxy   │
│  │  Pods    │  │ │   Pods     │ │     Pods       │
│  └──────────┘  │ │            │ │                │
└────────────────┘ └────────────┘ └────────────────┘
```

### 🔑 Master Node Components

| Component | Role | Analogy |
|-----------|------|---------|
| **etcd** | Key-value store for all cluster data | Filing cabinet |
| **kube-scheduler** | Decides which node a Pod goes to | Port crane operator |
| **Controller Manager** | Keeps desired state (node controller, replication controller) | Dock office manager |
| **Kube API Server** | Central hub — all communication goes through it | Reception/Gateway |

### 🔑 Worker Node Components

| Component | Role |
|-----------|------|
| **kubelet** | Node agent — manages pod lifecycle |
| **kube-proxy** | Networking rules — enables service communication |
| **Container Runtime** | Docker / ContainerD / CRI-O |

### 💡 CKA Exam Tip
> Know which components run on master vs worker nodes. The scheduler and controller manager **only run on master nodes**.

---

## 2. Container Runtimes — Docker vs ContainerD

### 📖 Background

Originally, Kubernetes was tightly coupled with Docker. As the ecosystem grew, Kubernetes introduced the **Container Runtime Interface (CRI)** to support other runtimes.

### 🔄 Evolution Timeline

```
Docker Era  →  CRI Introduced  →  ContainerD extracted  →  Docker deprecated in K8s 1.24
```

- **Docker** = CLI + API + Build Tools + Security + ContainerD (runtime) + runc
- **ContainerD** = Just the runtime (CRI-compatible, standalone)
- **Kubernetes 1.24** removed Docker Shim (the bridge between Docker and K8s)

> ✅ Docker **images** still work — they follow OCI standards. Only Docker as a runtime was removed.

### 🛠️ CLI Tools Comparison

| Tool | Created By | Purpose | Use When |
|------|-----------|---------|----------|
| `ctr` | ContainerD community | Low-level debugging | Rarely |
| `nerdctl` | ContainerD community | Docker-like CLI | Local development with ContainerD |
| `crictl` | Kubernetes community | Inspect/debug CRI runtimes | Debugging pods on nodes |
| `docker` | Docker Inc. | Full container management | Development, CI/CD builds |

### 📋 Key Commands

```bash
# Using crictl (Kubernetes debugging)
crictl images
crictl ps -a
crictl logs <container-id>
crictl pull nginx

# Using nerdctl (Docker equivalent)
nerdctl run nginx
nerdctl images
```

### ⚠️ Common Mistake
> Don't confuse `crictl` (for K8s debugging) with `ctr` (low-level ContainerD). Use `crictl` for node-level troubleshooting in a cluster.

---

## 3. ETCD

### 📖 What is etcd?

**etcd** is a distributed, reliable **key-value store** — the single source of truth for all Kubernetes cluster state.

Everything stored in Kubernetes lives in etcd:
- Nodes, Pods, ConfigMaps, Secrets
- Service Accounts, Roles, Bindings
- Deployments, ReplicaSets, etc.

### 🔑 Key-Value Store vs Relational DB

| Relational DB | Key-Value Store |
|---------------|-----------------|
| Fixed schema (tables/rows/columns) | Flexible — each entry is a self-contained document |
| Hard to add new fields | Easy — add any field per entry |
| SQL queries | Simple get/put by key |

### ⚙️ etcdctl — The CLI Tool

```bash
# API v2 commands
./etcdctl set key1 value1
./etcdctl get key1

# API v3 commands (set ETCDCTL_API=3)
export ETCDCTL_API=3
./etcdctl put key1 value1
./etcdctl get key1
./etcdctl version
```

> ⚠️ **CKA Exam Tip:** Always set `ETCDCTL_API=3` before running etcdctl commands in the exam.

### 🏛️ etcd in Kubernetes

**Deployed via kubeadm:**
```bash
kubectl get pods -n kube-system | grep etcd
# etcd runs as a pod: etcd-master
```

**Inspect keys in etcd:**
```bash
kubectl exec etcd-master -n kube-system -- \
  etcdctl get / --prefix --keys-only
# Shows: /registry/pods/default/...
#        /registry/deployments/default/...
```

**Manual installation:** etcd listens on port `2379` for client requests.

### 🔒 High Availability

In HA clusters, run **multiple etcd instances** and configure `--initial-cluster`:
```bash
--initial-cluster controller-0=https://10.0.1.10:2380,controller-1=https://10.0.1.11:2380
```

### 💡 Production Tip
> In production EKS clusters, AWS manages etcd for you. In self-managed (kubeadm) clusters on-prem or EC2, you must back up etcd regularly.

---

## 4. Kube API Server

### 📖 What does it do?

The **Kube API Server** is the **brain of the cluster** — all components communicate through it.

```
kubectl → API Server → authenticate → authorize → etcd/kubelet/scheduler
```

### 🔄 Pod Creation Flow

1. User runs `kubectl create pod`
2. API Server **authenticates** the request
3. API Server **validates** the request
4. API Server creates the Pod object in **etcd** (without node assignment)
5. **Scheduler** detects unassigned pod → selects a node → informs API Server
6. API Server updates etcd with node assignment
7. **Kubelet** on the worker node gets notified → creates the container
8. Kubelet sends status back to API Server → etcd updated

### 🛠️ Viewing the API Server

```bash
# If using kubeadm
kubectl get pods -n kube-system | grep kube-apiserver
kubectl describe pod kube-apiserver-master -n kube-system

# If running as a service
cat /etc/systemd/system/kube-apiserver.service
ps -aux | grep kube-apiserver
```

### 📋 Key Flags

```bash
kube-apiserver \
  --etcd-servers=https://127.0.0.1:2379 \
  --authorization-mode=Node,RBAC \
  --client-ca-file=/etc/kubernetes/pki/ca.crt \
  --tls-cert-file=/etc/kubernetes/pki/apiserver.crt \
  --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
```

---

## 5. Kube Controller Manager

### 📖 What is it?

A **single binary** that packages **all controllers** together. Controllers watch the cluster state and take corrective actions.

### 🎯 Key Controllers

| Controller | What it does |
|------------|--------------|
| **Node Controller** | Monitors nodes every 5s; marks unreachable after 40s; evicts pods after 5min |
| **Replication Controller** | Ensures desired number of pod replicas are running |
| **Deployment Controller** | Manages rolling updates/rollbacks |
| **Service Account Controller** | Creates default SAs for namespaces |
| **Job Controller** | Manages batch jobs |

### 🛠️ Viewing the Controller Manager

```bash
kubectl get pods -n kube-system | grep controller-manager
ps -aux | grep kube-controller-manager
cat /etc/kubernetes/manifests/kube-controller-manager.yaml
```

### ⚙️ Key Configuration

```bash
kube-controller-manager \
  --node-monitor-period=5s \
  --node-monitor-grace-period=40s \
  --pod-eviction-timeout=5m \
  --controllers=*,-tokencleaner  # enable all, disable tokencleaner
```

---

## 6. Kube Scheduler

### 📖 What is it?

The scheduler **decides which node** a pod goes to. It does **not** create the pod — that's the kubelet's job.

### 🔄 Scheduling Phases

```
Pod Created (Pending) → Scheduling Queue → Filter Phase → Scoring Phase → Binding
```

**1. Filter Phase** — Remove nodes that can't run the pod (not enough CPU/memory, taints, etc.)

**2. Scoring Phase** — Score remaining nodes (0–10). Higher score = more free resources after placing pod.

**3. Binding** — Assign the pod to the highest-scoring node.

### 🛠️ Viewing the Scheduler

```bash
kubectl get pods -n kube-system | grep scheduler
cat /etc/kubernetes/manifests/kube-scheduler.yaml
ps -aux | grep kube-scheduler
```

---

## 7. Kubelet

### 📖 What is it?

The **kubelet** is the node agent — the "captain of the ship" on each worker node.

**Responsibilities:**
- Registers the node with the cluster
- Receives pod specs from API Server
- Communicates with container runtime to start/stop containers
- Monitors pod health and reports status back

### ⚠️ Important Note

> **kubeadm does NOT deploy kubelet automatically.** You must install it manually on each worker node.

### 🛠️ Installation

```bash
# Download
wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kubelet

# Run as a service
ExecStart=/usr/local/bin/kubelet \
  --config=/var/lib/kubelet/kubelet-config.yaml \
  --container-runtime=remote \
  --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock \
  --kubeconfig=/var/lib/kubelet/kubeconfig \
  --register-node=true

# Verify
ps -aux | grep kubelet
```

---

## 8. Kube Proxy

### 📖 What is it?

**kube-proxy** runs on every node and manages **iptables rules** to route service traffic to the correct pods.

### ��� How it works

```
Client Pod → Service IP (virtual) → kube-proxy iptables rules → Pod IP
```

- Service has a stable virtual IP (ClusterIP)
- kube-proxy creates iptables rules mapping Service IP → actual Pod IP
- This works across all nodes transparently

### 🛠️ Deployment

When using **kubeadm**, kube-proxy is deployed as a **DaemonSet** (one pod per node):

```bash
kubectl get daemonset -n kube-system | grep kube-proxy
kubectl get pods -n kube-system | grep kube-proxy
```

---

## 9. Pods

### 📖 What is a Pod?

A **Pod** is the **smallest deployable unit** in Kubernetes. It wraps one or more containers that share:
- The same network namespace (communicate via `localhost`)
- Same storage volumes
- Same lifecycle

### 🏭 Single vs Multi-Container Pods

```
Single Container Pod (most common):
┌──────────────┐
│   Pod        │
│  ┌────────┐  │
│  │ nginx  │  │
│  └─────���──┘  │
└──────────────┘

Multi-Container Pod (sidecar pattern):
┌───────────────────────┐
│   Pod                 │
│  ┌────────┐ ┌──────┐  │
│  │  app   │ │ log  │  │
│  │server  │ │agent │  │
│  └────────┘ └──────┘  │
│  (share localhost &   │
│   shared volumes)     │
└───────────────────────┘
```

### 📋 Pod YAML

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
    env: production
spec:
  containers:
    - name: nginx
      image: nginx:1.21
      ports:
        - containerPort: 80
      resources:
        requests:
          cpu: "100m"
          memory: "128Mi"
        limits:
          cpu: "200m"
          memory: "256Mi"
```

### 🛠️ Essential Pod Commands

```bash
# Create
kubectl run nginx --image=nginx
kubectl apply -f pod.yaml

# List / Describe
kubectl get pods
kubectl get pods -o wide             # Shows node, IP
kubectl describe pod nginx-pod

# Logs & Exec
kubectl logs nginx-pod
kubectl logs -f nginx-pod            # Follow/stream logs
kubectl exec -it nginx-pod -- bash   # Shell into pod

# Delete
kubectl delete pod nginx-pod
```

### 💡 CKA Exam Tips
- Use `kubectl run` for quick pod creation
- `kubectl get pods -o wide` shows which node a pod is on
- Always check `kubectl describe pod <name>` for Events section when debugging

### ⚠️ Common Mistakes
- Forgetting `containers` is an **array** in spec (must use `-`)
- Using wrong `apiVersion` — Pods use `v1`, not `apps/v1`

---

## 10. ReplicaSets

### 📖 What is a ReplicaSet?

A **ReplicaSet** ensures a **specified number of Pod replicas** are always running. If a pod crashes, it creates a new one.

> **ReplicationController** = older version | **ReplicaSet** = current standard

### 🎯 Why Use It?

```
Without ReplicaSet: Pod crashes → app down → manual intervention needed
With ReplicaSet:    Pod crashes → ReplicaSet auto-creates replacement → zero downtime
```

### 📋 ReplicaSet YAML

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-rs
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx               # Must match template labels
  template:
    metadata:
      labels:
        app: nginx             # Pod labels
    spec:
      containers:
        - name: nginx
          image: nginx:1.21
          ports:
            - containerPort: 80
```

### 🔑 Key Concept: Selector

The `selector.matchLabels` tells the ReplicaSet **which pods to manage**. This is critical — if pods with matching labels already exist, the ReplicaSet adopts them.

### 🛠️ Commands

```bash
kubectl get replicaset
kubectl describe rs nginx-rs
kubectl delete rs nginx-rs

# Scale
kubectl scale replicaset nginx-rs --replicas=5
kubectl scale -f replicaset.yaml --replicas=5
```

### 💡 CKA Exam Tip
> Know the difference between `ReplicationController` (apiVersion: `v1`) and `ReplicaSet` (apiVersion: `apps/v1`). ReplicaSet requires a `selector` field.

---

## 11. Deployments

### 📖 What is a Deployment?

A **Deployment** manages **ReplicaSets** and provides higher-level features:
- Rolling updates (zero-downtime deploys)
- Rollbacks (revert to previous version)
- Pause/Resume updates

```
Deployment → manages → ReplicaSet → manages → Pods
```

### 📋 Deployment YAML

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.21
          ports:
            - containerPort: 80
```

### 🛠️ Essential Commands

```bash
# Create & verify
kubectl apply -f deployment.yaml
kubectl get deployments
kubectl get all   # Shows deployment + replicaset + pods together

# Update image
kubectl set image deployment/nginx-deployment nginx=nginx:1.22

# Rollout management
kubectl rollout status deployment/nginx-deployment
kubectl rollout history deployment/nginx-deployment
kubectl rollout undo deployment/nginx-deployment        # Rollback
kubectl rollout undo deployment/nginx-deployment --to-revision=2

# Scale
kubectl scale deployment nginx-deployment --replicas=5

# Pause/Resume (for multiple changes)
kubectl rollout pause deployment/nginx-deployment
kubectl rollout resume deployment/nginx-deployment
```

### 🔄 Deployment Strategies

| Strategy | Behavior | Downtime? |
|----------|----------|-----------|
| **RollingUpdate** (default) | Replace pods one-by-one | ❌ No |
| **Recreate** | Kill all old pods, then create new | ✅ Yes |

### 💡 Production Scenario (EKS)
```bash
# Deploying a new version in production
kubectl set image deployment/api-server api=my-registry/api:v2.1.0

# Monitor the rollout
kubectl rollout status deployment/api-server

# If something breaks, instant rollback
kubectl rollout undo deployment/api-server
```

---

## 12. Services

### 📖 What is a Service?

A **Service** provides a **stable network endpoint** to access pods. Pod IPs change when pods restart — Services provide a constant IP/DNS name.

### 🔌 Types of Services

#### 1. ClusterIP (default)
Internal communication within the cluster.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: backend-svc
spec:
  type: ClusterIP
  selector:
    app: backend
  ports:
    - port: 80
      targetPort: 8080
```

#### 2. NodePort
Exposes service on each node's IP at a static port (30000–32767).

```yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend-svc
spec:
  type: NodePort
  selector:
    app: frontend
  ports:
    - port: 80          # Service port (cluster-internal)
      targetPort: 80    # Pod port
      nodePort: 30080   # External port on each node
```

```bash
# Access the app
curl http://<NodeIP>:30080
```

#### 3. LoadBalancer
Provisions a cloud load balancer (AWS ELB, GCP LB). Only works on cloud providers.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: public-svc
spec:
  type: LoadBalancer
  selector:
    app: frontend
  ports:
    - port: 80
      targetPort: 80
```

### 🌐 DNS for Services

Within the same namespace:
```
http://backend-svc:80
```

Cross-namespace:
```
http://backend-svc.dev.svc.cluster.local:80
```

Format: `<service>.<namespace>.svc.cluster.local`

### 🛠️ Commands

```bash
kubectl get svc
kubectl describe svc backend-svc
kubectl expose pod nginx --port=80 --type=NodePort
kubectl expose deployment nginx --port=80 --type=LoadBalancer
```

### 💡 CKA Exam Tip
> **NodePort range is 30000–32767**. If not specified, Kubernetes auto-assigns one. Remember: `targetPort` = container port, `port` = service port, `nodePort` = external port.

---

## 13. Namespaces

### 📖 What are Namespaces?

Namespaces provide **logical isolation** of resources within a cluster. Think of them as separate "rooms" in the same building.

### 🏢 Default Namespaces

| Namespace | Purpose |
|-----------|---------|
| `default` | User workloads if no namespace specified |
| `kube-system` | Kubernetes system components (DNS, proxy, etc.) |
| `kube-public` | Publicly readable resources |
| `kube-node-lease` | Node heartbeat leases |

### 🛠️ Commands

```bash
# List namespaces
kubectl get namespaces
kubectl get ns

# Work in a specific namespace
kubectl get pods -n kube-system
kubectl run redis --image=redis -n finance

# Set default namespace for your session
kubectl config set-context --current --namespace=dev

# See everything everywhere
kubectl get pods --all-namespaces
kubectl get pods -A   # shorthand
```

### 📋 Creating a Namespace

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: development
```

```bash
kubectl create namespace development
# or
kubectl apply -f namespace.yaml
```

### 📋 Resource Quota per Namespace

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: dev-quota
  namespace: development
spec:
  hard:
    pods: "10"
    requests.cpu: "4"
    requests.memory: 8Gi
    limits.cpu: "8"
    limits.memory: 16Gi
```

### 💡 Production Scenario
In a multi-team EKS cluster:
- `team-a` namespace for Team A's apps
- `team-b` namespace for Team B's apps
- ResourceQuota per namespace prevents one team from consuming all cluster resources

---

## 14. Imperative vs Declarative

### 📖 Concept

| Approach | How | Analogy |
|----------|-----|---------|
| **Imperative** | Step-by-step commands | Giving a taxi driver turn-by-turn directions |
| **Declarative** | Define desired state in a file | Entering destination in Google Maps |

### ⚙️ Imperative Commands

```bash
kubectl run nginx --image=nginx
kubectl create deployment --image=nginx nginx
kubectl expose deployment nginx --port=80
kubectl scale deployment nginx --replicas=5
kubectl set image deployment nginx nginx=nginx:1.22
kubectl create -f pod.yaml
kubectl replace -f pod.yaml
kubectl delete -f pod.yaml
```

**Pros:** Fast, good for one-off tasks, exam speed  
**Cons:** No history, hard to repeat, no source of truth

### ⚙️ Declarative Commands

```bash
kubectl apply -f deployment.yaml
kubectl apply -f ./manifests/    # Apply entire directory
```

**Pros:** Idempotent, version-controlled, team-friendly  
**Cons:** Requires maintaining YAML files

### 💡 CKA Exam Strategy

```
Simple task (create 1 pod)   → Use imperative: kubectl run
Complex config (multi-field) → Use declarative: write YAML, apply
Updates                      → Modify YAML file, kubectl apply again
```

### ⚠️ Common Mistake
> Using `kubectl edit` makes changes to the live object but **does not update your YAML file**. Always keep your YAML files updated to avoid drift.

---

## 15. kubectl apply — Internal Working

### 📖 How kubectl apply Works

`kubectl apply` performs a **three-way merge**:

1. **Local file** — What you want
2. **Live object** — What's currently running
3. **Last applied configuration** (stored as annotation) — What was last applied

```
Last Applied Config  ←compare→  Local File   →  Changes to make
       ↑                                              ↓
  Live Object   ←────────────────────────────── Apply Changes
```

### 📋 The Annotation

When you `kubectl apply`, Kubernetes stores the applied config as a JSON annotation:

```yaml
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Pod","metadata":{"name":"nginx"}...}
```

### 🔑 Why This Matters

- If you **remove a field** from your YAML, `kubectl apply` detects it (via the annotation) and removes it from the live object too.
- `kubectl create` / `kubectl replace` do **not** store this annotation → mixing imperative and declarative causes issues.

### 💡 Best Practice
> Always use **`kubectl apply`** for declarative management. Never mix `kubectl create`/`kubectl replace` with `kubectl apply` for the same resources.

---

## 16. Scheduling — Manual Scheduling

### 📖 What is Manual Scheduling?

By default, the scheduler assigns pods to nodes. But you can **force a pod to a specific node** by setting the `nodeName` field.

### 📋 Assign at Creation Time

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  nodeName: worker-node-2    # Force scheduling to this node
  containers:
    - name: nginx
      image: nginx
```

### 📋 Assign to Running Pod (Binding Object)

If the pod is already running (or pending without scheduler), use a Binding object:

```yaml
apiVersion: v1
kind: Binding
metadata:
  name: nginx
target:
  apiVersion: v1
  kind: Node
  name: worker-node-2
```

```bash
# Send as POST request
curl -X POST \
  --header "Content-Type: application/json" \
  --data @binding.json \
  http://$SERVER/api/v1/namespaces/default/pods/nginx/binding
```

### 💡 When Would You Use This?
In real production, you'd rarely do this manually. Use it when:
- The scheduler is down
- You're troubleshooting specific node placement
- Running without a scheduler

---

## 17. Labels and Selectors

### 📖 What are Labels?

**Labels** are key-value pairs attached to Kubernetes objects. **Selectors** filter objects based on labels.

Think of labels like product tags in an e-commerce store — you can filter by category, size, color, etc.

### 📋 Adding Labels to a Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-app
  labels:
    app: frontend        # Application name
    env: production      # Environment
    tier: web            # Tier
    version: "v2.1"      # Version
spec:
  containers:
    - name: nginx
      image: nginx
```

### 🔍 Selecting with Labels

```bash
# Get pods by label
kubectl get pods --selector app=frontend
kubectl get pods -l app=frontend,env=production   # Multiple labels (AND)
kubectl get pods -l 'env in (production,staging)' # OR condition

# Label a node (for node selectors)
kubectl label nodes worker-node-1 disk=ssd
kubectl label nodes worker-node-1 size=large
```

### 📋 Labels in ReplicaSet (CRITICAL)

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend-rs
  labels:
    app: frontend    # Labels on the ReplicaSet itself
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend  # Must match template labels below!
  template:
    metadata:
      labels:
        app: frontend  # Labels on the Pods
    spec:
      containers:
        - name: nginx
          image: nginx
```

### 📝 Annotations (for metadata, not selection)

```yaml
metadata:
  annotations:
    buildVersion: "1.5.2"
    maintainer: "devops@company.com"
    gitCommit: "abc123"
```

### ⚠️ Common Mistake
> The `selector.matchLabels` in a ReplicaSet/Deployment **must match** the `template.metadata.labels`. If they don't match, you'll get an error.

### 💡 CKA Exam Tip
> Use `kubectl get pods --show-labels` to see all labels on pods.

---

## 18. Taints and Tolerations

### 📖 Concept

- **Taint** = "Repellent" applied to a **Node** — repels pods that don't tolerate it
- **Toleration** = "Immunity" applied to a **Pod** — allows it to run on tainted nodes

```
Normal Pod → Tainted Node = REJECTED ❌
Pod with Toleration → Tainted Node = ALLOWED ✅
```

### 🛠️ Taint a Node

```bash
# Syntax: kubectl taint nodes <node-name> <key>=<value>:<effect>
kubectl taint nodes worker-node-1 app=blue:NoSchedule
kubectl taint nodes worker-node-1 app=blue:PreferNoSchedule
kubectl taint nodes worker-node-1 app=blue:NoExecute

# Remove a taint (add minus at end)
kubectl taint nodes worker-node-1 app=blue:NoSchedule-
```

### 🎯 Taint Effects

| Effect | Behavior |
|--------|----------|
| **NoSchedule** | New pods without toleration won't be scheduled |
| **PreferNoSchedule** | Kubernetes tries to avoid scheduling, but not enforced |
| **NoExecute** | Running pods without toleration are evicted; new ones not scheduled |

### 📋 Pod Toleration

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: blue-app
spec:
  tolerations:
    - key: "app"
      operator: "Equal"
      value: "blue"
      effect: "NoSchedule"
  containers:
    - name: nginx
      image: nginx
```

### 🔑 Master Node Taint

```bash
kubectl describe node master-node | grep Taint
# Taints: node-role.kubernetes.io/master:NoSchedule
```

This prevents user workloads from being scheduled on the master node.

### ⚠️ Important Limitation

> Taints and tolerations **only repel/allow** — they do **NOT guarantee** that a pod with toleration goes to the tainted node. The pod could still land on any untainted node.

### 💡 Production Scenario
```bash
# Taint GPU nodes — only GPU workloads should go there
kubectl taint nodes gpu-node-1 gpu=true:NoSchedule

# In the GPU pod spec
tolerations:
  - key: "gpu"
    operator: "Equal"
    value: "true"
    effect: "NoSchedule"
```

---

## 19. Node Selectors

### 📖 What is it?

**Node Selector** restricts a pod to run only on nodes with specific labels. Simple but limited.

### 📋 Step 1: Label the Node

```bash
kubectl label nodes worker-node-1 size=large
kubectl label nodes worker-node-1 disk=ssd
```

### 📋 Step 2: Add Node Selector to Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: data-processor
spec:
  nodeSelector:
    size: large     # Pod only schedules on nodes labeled size=large
  containers:
    - name: processor
      image: data-processor:latest
```

### ⚠️ Limitations

Node selectors only support simple **equality** matching. You **cannot** do:
- "Schedule on large OR medium nodes"
- "Schedule on anything that is NOT small"

For complex requirements, use **Node Affinity**.

---

## 20. Node Affinity

### 📖 What is it?

**Node Affinity** provides **advanced scheduling rules** using operators like `In`, `NotIn`, `Exists`, `DoesNotExist`, `Gt`, `Lt`.

### 📋 Basic Example — Schedule on Large Nodes

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: data-pod
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: size
                operator: In
                values:
                  - large
                  - xlarge       # Large OR xlarge
  containers:
    - name: app
      image: myapp
```

### 📋 Avoid Small Nodes

```yaml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
        - matchExpressions:
            - key: size
              operator: NotIn
              values:
                - small
```

### 📋 Just Check if Label Exists

```yaml
matchExpressions:
  - key: gpu
    operator: Exists    # No values needed
```

### 🔑 Affinity Types

| Type | Scheduling Behavior | After Pod is Running |
|------|--------------------|-----------------------|
| `requiredDuringSchedulingIgnoredDuringExecution` | Pod **must** go to matching node | Label changes ignored |
| `preferredDuringSchedulingIgnoredDuringExecution` | **Prefer** matching node, but not mandatory | Label changes ignored |

### 💡 CKA Exam Tip
> The long names are hard to remember. Focus on: **required** = hard rule, **preferred** = soft preference. Both say "IgnoredDuringExecution" — meaning once running, the pod won't be evicted if labels change.

---

## 21. Taints vs Node Affinity

### 🎯 When to Use What?

| Mechanism | Use Case |
|-----------|---------|
| **Taints & Tolerations** | Keep unwanted pods OFF a node |
| **Node Affinity** | Pull a specific pod TO a specific node |
| **Both Together** | Exclusive node ownership |

### 💡 Production Scenario — Dedicated Nodes

**Problem:** You have blue, red, and green nodes. You want blue pods on blue nodes ONLY, and nothing else on those nodes.

**Solution:**
1. **Taint the nodes** (repel other pods)
2. **Add toleration to matching pods** (allow them on tainted nodes)
3. **Add node affinity to pods** (ensure they GO to the right node)

```bash
# Step 1: Taint nodes
kubectl taint nodes blue-node color=blue:NoSchedule
kubectl taint nodes red-node color=red:NoSchedule

# Step 2: Label nodes
kubectl label nodes blue-node color=blue
kubectl label nodes red-node color=red
```

```yaml
# Step 3: Blue pod — both toleration + affinity
spec:
  tolerations:
    - key: "color"
      operator: "Equal"
      value: "blue"
      effect: "NoSchedule"
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: color
                operator: In
                values:
                  - blue
```

---

## 22. DaemonSets

### 📖 What is a DaemonSet?

A **DaemonSet** ensures **exactly one copy of a pod runs on every node** in the cluster. When you add a node, DaemonSet automatically deploys the pod to it.

### 🎯 Use Cases

| Use Case | Example |
|----------|---------|
| **Log collection** | Fluentd, Filebeat on every node |
| **Monitoring agents** | Prometheus Node Exporter, Datadog agent |
| **Networking** | Weave Net, Calico — CNI agents |
| **Kubernetes internals** | `kube-proxy` runs as a DaemonSet |

### 📋 DaemonSet YAML

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitoring
  labels:
    app: node-exporter
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      labels:
        app: node-exporter
    spec:
      tolerations:
        - key: node-role.kubernetes.io/master    # Allow on master too
          effect: NoSchedule
      containers:
        - name: node-exporter
          image: prom/node-exporter:latest
          ports:
            - containerPort: 9100
```

### 🛠️ Commands

```bash
kubectl get daemonset
kubectl get daemonset -n kube-system
kubectl describe daemonset node-exporter
```

### 🔑 How DaemonSets Schedule Pods

Since Kubernetes 1.12, DaemonSets use the **NodeAffinity** mechanism internally to schedule pods on every node. They bypass the default scheduler's node selection logic.

### 💡 Production Scenario (EKS)
Every EKS worker node automatically gets `kube-proxy` and your CNI plugin (e.g., VPC CNI) via DaemonSets. If you add a new node group, your monitoring agents (Datadog, Prometheus Node Exporter) automatically deploy there too.

---

## 23. Static Pods

### 📖 What are Static Pods?

**Static Pods** are managed **directly by the kubelet** without the API Server, Scheduler, or etcd.

The kubelet watches a directory (e.g., `/etc/kubernetes/manifests`) and creates pods from YAML files found there.

### 🔑 Key Characteristics

- Managed by the kubelet, not the API Server
- No Deployments, ReplicaSets, or Services — only Pods
- Auto-restarted by kubelet if they crash
- In a cluster, a **mirror pod** (read-only) appears in `kubectl get pods`

### ⚙️ Configuring Static Pod Directory

**Option 1:** Direct flag
```bash
ExecStart=/usr/local/bin/kubelet \
  --pod-manifest-path=/etc/kubernetes/manifests \
  ...
```

**Option 2:** Config file (kubeadm approach)
```bash
ExecStart=/usr/local/bin/kubelet \
  --config=/var/lib/kubelet/config.yaml
```
```yaml
# config.yaml
staticPodPath: /etc/kubernetes/manifests
```

### 📋 Example Static Pod

```yaml
# /etc/kubernetes/manifests/my-static-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-static-pod
spec:
  containers:
    - name: nginx
      image: nginx
```

### 🏛️ Why Static Pods Matter

**kubeadm uses static pods** to bootstrap Kubernetes control plane components:
```
/etc/kubernetes/manifests/
  ├── etcd.yaml
  ├── kube-apiserver.yaml
  ├── kube-controller-manager.yaml
  └── kube-scheduler.yaml
```

### 🆚 Static Pods vs DaemonSets

| Feature | Static Pods | DaemonSets |
|---------|------------|------------|
| Created by | kubelet directly | DaemonSet controller via API Server |
| Needs API Server? | ❌ No | ✅ Yes |
| Runs on every node? | Only where file exists | ✅ Yes |
| Use case | Control plane bootstrap | Cluster-wide agents |
| Modified via | File on node | `kubectl apply` |

### 💡 CKA Exam Tip
> To find static pods: `ls /etc/kubernetes/manifests/`. To modify: edit the file directly. Changes take effect immediately (kubelet watches the directory).

---

## 24. Priority Classes

### 📖 What are Priority Classes?

**Priority Classes** assign **numerical priority values** to pods. Higher priority pods are scheduled before lower priority ones.

### 🔑 Value Ranges

| Type | Value Range |
|------|-------------|
| User workloads | -2,147,483,648 to 1,000,000,000 |
| System-critical (reserved) | > 1,000,000,000 |

```bash
kubectl get priorityclass
# system-cluster-critical    2000000000
# system-node-critical       2000010000
```

### 📋 Creating a Priority Class

```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000000
globalDefault: false
preemptionPolicy: PreemptLowerPriority  # or Never
description: "For mission-critical production workloads"
```

### 📋 Using Priority in a Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: critical-app
spec:
  priorityClassName: high-priority
  containers:
    - name: app
      image: my-critical-app
```

### 🔄 Preemption

When cluster resources are full:
- A high-priority pod enters the queue
- Kubernetes evaluates preemption policy
- `PreemptLowerPriority` → evict lower-priority pods to make room
- `Never` → wait in queue without evicting anyone

### 💡 Production Use Case
```
Priority:
1. System components (kube-system)    → system-cluster-critical
2. Production databases               → db-critical (value: 900000)
3. Production apps                    → prod-high (value: 500000)
4. Staging apps                       → staging-medium (value: 100000)
5. Batch jobs / background work       → default (value: 0)
```

---

## 25. Multiple Schedulers & Scheduler Profiles

### 📖 Multiple Schedulers

You can run **multiple schedulers** in a cluster — each with a different name and configuration.

### 📋 Custom Scheduler as a Deployment

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-scheduler-config
  namespace: kube-system
data:
  my-scheduler-config.yaml: |
    apiVersion: kubescheduler.config.k8s.io/v1
    kind: KubeSchedulerConfiguration
    profiles:
      - schedulerName: my-custom-scheduler
```

### 📋 Assign Pod to Custom Scheduler

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: custom-scheduled-pod
spec:
  schedulerName: my-custom-scheduler    # Use this scheduler
  containers:
    - name: nginx
      image: nginx
```

### 📋 Scheduler Profiles (Kubernetes 1.18+)

Instead of multiple scheduler processes, define **multiple profiles in one scheduler**:

```yaml
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
  - schedulerName: default-scheduler
  - schedulerName: my-scheduler-2
    plugins:
      score:
        disabled:
          - name: TaintToleration
        enabled:
          - name: MyCustomPlugin
  - schedulerName: no-scoring-scheduler
    plugins:
      preScore:
        disabled:
          - name: '*'    # Disable ALL preScore plugins
      score:
        disabled:
          - name: '*'    # Disable ALL score plugins
```

### 🔄 Scheduling Pipeline Phases

```
Queue → PreFilter → Filter → PostFilter → PreScore → Score → Reserve → Permit → PreBind → Bind
```

### 🛠️ Verify Which Scheduler Scheduled a Pod

```bash
kubectl get events -o wide | grep Scheduled
# Shows: Successfully assigned nginx to node01    Source: my-custom-scheduler
```

---

## 26. Admission Controllers

### 📖 What are Admission Controllers?

Admission controllers **intercept API requests** after authentication/authorization but **before** the object is persisted in etcd. They can:
- **Validate** requests (approve/reject)
- **Mutate** requests (modify the object)

```
kubectl → API Server → Authentication → Authorization → Admission Controllers → etcd
```

### 🔑 Types

| Type | What it does |
|------|-------------|
| **Validating** | Approves or rejects requests |
| **Mutating** | Modifies the request (e.g., adds defaults) |

### 📋 Built-in Examples

```
AlwaysPullImages      → Force pull images even if cached
DefaultStorageClass   → Auto-add default storage class to PVCs
NamespaceLifecycle    → Reject requests to non-existent namespaces
LimitRanger           → Enforce default resource limits
ResourceQuota         → Enforce namespace resource quotas
NodeRestriction       → Limit what kubelets can modify
```

### ⚙️ Enabling/Disabling

```yaml
# In kube-apiserver.yaml
spec:
  containers:
  - command:
    - kube-apiserver
    - --enable-admission-plugins=NodeRestriction,NamespaceLifecycle
    - --disable-admission-plugins=DefaultStorageClass
```

```bash
# Check currently enabled plugins
kube-apiserver -h | grep enable-admission-plugins

# In kubeadm-based cluster
kubectl exec -it kube-apiserver-master -n kube-system -- \
  kube-apiserver -h | grep admission
```

### 📋 Custom Webhook (Validating)

```yaml
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: pod-validator
webhooks:
  - name: "validate-pods.example.com"
    clientConfig:
      service:
        namespace: default
        name: webhook-service
      caBundle: "<base64-ca-cert>"
    rules:
      - apiGroups: [""]
        apiVersions: ["v1"]
        operations: ["CREATE"]
        resources: ["pods"]
```

### 💡 Real-World Use Case
```
Custom admission webhook that:
- Rejects pods using the "latest" image tag
- Forces all pods to have resource limits defined
- Injects sidecar containers automatically (e.g., Istio envoy)
```

---

## 27. Logging in Kubernetes

### 📖 Docker Logging (Foundation)

```bash
# Run container — logs appear on stdout
docker run kodekloud/event-simulator

# Run detached — stream logs later
docker run -d kodekloud/event-simulator
docker logs -f <container-id>
```

### 📋 Kubernetes Pod Logs

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: event-simulator
spec:
  containers:
    - name: event-simulator
      image: kodekloud/event-simulator
```

```bash
# Stream logs
kubectl logs -f event-simulator

# Previous container (if restarted)
kubectl logs event-simulator --previous

# Tail last 100 lines
kubectl logs event-simulator --tail=100
```

### 📋 Multi-Container Pod Logs

```yaml
spec:
  containers:
    - name: app-container
      image: my-app
    - name: log-agent
      image: fluent/fluentd
```

```bash
# Must specify container name
kubectl logs -f event-simulator-pod app-container
kubectl logs -f event-simulator-pod log-agent
```

### 🛠️ Debugging Workflow

```bash
# 1. Check pod status
kubectl get pods

# 2. Describe the pod (Events section is gold!)
kubectl describe pod <pod-name>

# 3. Check logs
kubectl logs <pod-name>

# 4. If pod restarted, check previous logs
kubectl logs <pod-name> --previous

# 5. Exec into container for deeper investigation
kubectl exec -it <pod-name> -- bash
```

### 💡 CKA Exam Tip
> When a pod is in CrashLoopBackOff, always check `kubectl logs <pod> --previous` to see what happened in the crashed container.

---

## 28. Application Lifecycle Management

### 📖 Rolling Updates

Kubernetes updates pods gradually to maintain availability.

```
Old ReplicaSet: 3 pods → 2 → 1 → 0
New ReplicaSet: 0 pods → 1 → 2 → 3
```

### 🛠️ Complete Rollout Workflow

```bash
# Check rollout status
kubectl rollout status deployment/myapp

# View history
kubectl rollout history deployment/myapp

# Record reason for change (add to history)
kubectl annotate deployment myapp \
  kubernetes.io/change-cause="Updated to nginx:1.22 for security patch"

# Update
kubectl set image deployment/myapp nginx=nginx:1.22

# Rollback
kubectl rollout undo deployment/myapp

# Rollback to specific revision
kubectl rollout undo deployment/myapp --to-revision=2

# View specific revision
kubectl rollout history deployment/myapp --revision=2
```

### 📋 Deployment with Explicit Strategy

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1    # Max pods that can be unavailable during update
      maxSurge: 1          # Max extra pods above desired count during update
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: web
          image: nginx:1.21
```

### 💡 CKA Exam Tip Reference Table

| Command | Description |
|---------|-------------|
| `kubectl create -f deployment.yml` | Create deployment |
| `kubectl get deployments` | List deployments |
| `kubectl apply -f deployment.yml` | Update deployment |
| `kubectl set image deployment/app nginx=nginx:1.22` | Update image |
| `kubectl rollout status deployment/app` | Check rollout |
| `kubectl rollout undo deployment/app` | Rollback |

---

## 29. Commands and Arguments — Docker & Kubernetes

### 📖 Docker: CMD vs ENTRYPOINT

```dockerfile
# CMD — can be fully overridden at runtime
FROM ubuntu
CMD ["sleep", "5"]        # Default: sleep for 5 seconds

# ENTRYPOINT — runtime args are APPENDED
FROM ubuntu
ENTRYPOINT ["sleep"]
CMD ["5"]                 # Default arg: sleep 5
```

```bash
docker run ubuntu-sleeper        # Runs: sleep 5
docker run ubuntu-sleeper 10     # Runs: sleep 10
docker run --entrypoint sleep2.0 ubuntu-sleeper 10  # Override entrypoint
```

### 🔑 Mapping to Kubernetes

| Dockerfile | Kubernetes Pod spec |
|------------|---------------------|
| `ENTRYPOINT` | `spec.containers[].command` |
| `CMD` | `spec.containers[].args` |

### 📋 Kubernetes Pod with Custom Command & Args

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sleeper-pod
spec:
  containers:
    - name: ubuntu-sleeper
      image: ubuntu-sleeper
      command: ["sleep2.0"]   # Overrides ENTRYPOINT
      args: ["10"]            # Overrides CMD
```

```yaml
# Just override the CMD (args only)
spec:
  containers:
    - name: sleeper
      image: ubuntu-sleeper
      args: ["10"]             # sleep 10 instead of sleep 5
```

### ⚠️ Common Mistake
> `command` in Kubernetes **replaces** the Docker ENTRYPOINT entirely. `args` **replaces** the Docker CMD. Many people confuse `command` with the shell command.

---

## 30. Secrets

### 📖 What are Secrets?

**Secrets** store sensitive data (passwords, tokens, keys) in Kubernetes. They are base64-encoded (NOT encrypted by default).

### 🔑 Creating Secrets

**Imperative:**
```bash
kubectl create secret generic db-secret \
  --from-literal=DB_HOST=mysql \
  --from-literal=DB_USER=root \
  --from-literal=DB_PASS=s3cr3t

kubectl create secret generic db-secret \
  --from-file=./credentials.env
```

**Declarative (base64 encode values first):**
```bash
echo -n 'mysql' | base64    # bXlzcWw=
echo -n 'root' | base64     # cm9vdA==
echo -n 's3cr3t' | base64   # czNjcjN0
```

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
type: Opaque
data:
  DB_HOST: bXlzcWw=      # base64 encoded
  DB_USER: cm9vdA==
  DB_PASS: czNjcjN0
```

### 📋 Using Secrets in Pods

**Method 1: All keys as environment variables**
```yaml
spec:
  containers:
    - name: app
      image: myapp
      envFrom:
        - secretRef:
            name: db-secret
```

**Method 2: Specific key**
```yaml
spec:
  containers:
    - name: app
      env:
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: DB_PASS
```

**Method 3: Mount as files (volume)**
```yaml
spec:
  volumes:
    - name: secret-volume
      secret:
        secretName: db-secret
  containers:
    - name: app
      volumeMounts:
        - mountPath: /etc/secrets
          name: secret-volume
          readOnly: true
```

```bash
# Files appear as:
ls /etc/secrets/
# DB_HOST  DB_USER  DB_PASS

cat /etc/secrets/DB_PASS
# s3cr3t
```

### 🛠️ Commands

```bash
kubectl get secrets
kubectl describe secret db-secret      # Values hidden
kubectl get secret db-secret -o yaml   # Base64 encoded values visible

# Decode a value
echo "czNjcjN0" | base64 --decode
```

### ⚠️ Security Warnings

1. **Secrets are only base64-encoded, NOT encrypted** in etcd by default
2. Anyone with `get secret` RBAC permission can decode them
3. Don't commit Secret YAML files to Git

### ✅ Security Best Practices

| Practice | How |
|----------|-----|
| Enable encryption at rest | Use EncryptionConfiguration |
| Restrict access | RBAC — limit who can `get/list` secrets |
| Use external secrets | AWS Secrets Manager, HashiCorp Vault |
| Avoid secret YAML in Git | Use sealed secrets or external operators |

---

## 31. Encrypting Secrets at Rest

### 📖 Why?

By default, secrets in etcd are only base64-encoded. Anyone with etcd access can read them. Encryption at rest prevents this.

### 🔍 Check if Encryption is Enabled

```bash
ps -aux | grep kube-apiserver | grep encryption-provider-config
# If empty → encryption NOT enabled
```

### ⚙️ Enable Encryption

**Step 1: Generate a random key**
```bash
head -c 32 /dev/urandom | base64
# Example: y0xTt+U6xgRdNxe4nDYYsijOGgRDoUYC+wAwOKeNfPs=
```

**Step 2: Create EncryptionConfiguration**
```yaml
# /etc/kubernetes/enc/enc.yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: y0xTt+U6xgRdNxe4nDYYsijOGgRDoUYC+wAwOKeNfPs=
      - identity: {}    # Fallback — allows reading old unencrypted secrets
```

**Step 3: Mount and configure API Server**
```yaml
# In /etc/kubernetes/manifests/kube-apiserver.yaml
spec:
  containers:
  - command:
    - kube-apiserver
    - --encryption-provider-config=/etc/kubernetes/enc/enc.yaml
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

**Step 4: Verify encryption**
```bash
# Create a new secret
kubectl create secret generic test-secret --from-literal=key=value

# Check in etcd — should show encrypted data
ETCDCTL_API=3 etcdctl \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  get /registry/secrets/default/test-secret | hexdump -C
```

**Step 5: Re-encrypt existing secrets**
```bash
kubectl get secrets --all-namespaces -o json | kubectl replace -f -
```

### 💡 CKA Exam Tip
> The exam may ask you to verify if encryption is enabled or to enable it. Always check the `--encryption-provider-config` flag on the API server first.

---

## 32. Multi-Container Pods

### 📖 Why Multi-Container Pods?

Sometimes two containers are tightly coupled and need to:
- Share the same network (communicate via `localhost`)
- Share storage volumes
- Have the same lifecycle (start/stop together)

### 🎯 Common Patterns

| Pattern | Description | Example |
|---------|-------------|---------|
| **Sidecar** | Augments the main container | Log agent alongside web server |
| **Ambassador** | Proxy for main container | Local proxy to remote database |
| **Adapter** | Transforms output of main container | Format logs before sending |

### 📋 Sidecar Example (App + Log Agent)

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-with-logging
spec:
  volumes:
    - name: shared-logs
      emptyDir: {}              # Shared between containers
  containers:
    - name: web-app
      image: nginx
      volumeMounts:
        - name: shared-logs
          mountPath: /var/log/nginx

    - name: log-agent
      image: fluent/fluentd
      volumeMounts:
        - name: shared-logs
          mountPath: /var/log/app   # Reads nginx logs
```

### 🛠️ Working with Multi-Container Pods

```bash
# Logs from specific container
kubectl logs pod-name -c web-app
kubectl logs pod-name -c log-agent

# Exec into specific container
kubectl exec -it pod-name -c web-app -- bash

# Describe shows all containers
kubectl describe pod web-with-logging
```

### 💡 CKA Exam Tip
> In multi-container pods, if `kubectl logs` gives an error, it's because you need to specify the container name with `-c <container-name>`.

---

## 33. Autoscaling — HPA & VPA

### 📖 Scaling Concepts

| Type | Direction | Kubernetes Object |
|------|-----------|------------------|
| **Horizontal Pod Scaling** | More/fewer pods | HPA |
| **Vertical Pod Scaling** | More/fewer resources per pod | VPA |
| **Cluster Node Scaling** | More/fewer nodes | Cluster Autoscaler |

### ⚙️ Horizontal Pod Autoscaler (HPA)

HPA automatically adjusts pod count based on CPU/memory/custom metrics.

**Prerequisites:** metrics-server must be installed.

**Imperative:**
```bash
kubectl autoscale deployment my-app \
  --cpu-percent=50 \
  --min=1 \
  --max=10

kubectl get hpa
kubectl delete hpa my-app
```

**Declarative:**
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: my-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: my-app
  minReplicas: 1
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
```

### ⚙️ Vertical Pod Autoscaler (VPA)

VPA adjusts CPU/memory requests and limits automatically (not enabled by default).

### 📋 Manual Scaling Commands

```bash
# Scale deployment
kubectl scale deployment my-app --replicas=5

# Edit resources directly
kubectl edit deployment my-app
```

### 💡 Production Scenario (EKS)
```
HPA + Cluster Autoscaler working together:
1. Traffic spike → CPU usage goes up
2. HPA: scale pods from 3 → 8
3. Not enough nodes → Cluster Autoscaler: scale node group from 2 → 4
4. Traffic drops → HPA scales pods down → Cluster Autoscaler scales nodes down
```

---

## 34. In-Place Pod Resize

### 📖 What is it?

Kubernetes 1.27+ (alpha) allows **changing CPU/memory resources without recreating the pod**.

### 📋 Enable Feature Gate

```bash
FEATURE_GATES=InPlacePodVerticalScaling=true
```

### 📋 Resize Policy

```yaml
spec:
  containers:
    - name: app
      image: nginx
      resizePolicy:
        - resourceName: cpu
          restartPolicy: NotRequired    # CPU change = no restart
        - resourceName: memory
          restartPolicy: RestartContainer  # Memory change = restart
      resources:
        requests:
          cpu: "250m"
          memory: "256Mi"
        limits:
          cpu: "500m"
          memory: "512Mi"
```

### ⚠️ Current Limitations (as of 2025)

- Only **CPU and memory** can be resized in-place
- **Memory limit cannot be reduced** below current usage
- Does not support Windows pods
- Does not work for init containers or ephemeral containers

---

## 35. Cluster Maintenance

### 📖 Overview

Cluster maintenance covers:
1. OS/kernel upgrades on nodes
2. Kubernetes version upgrades
3. Backup and disaster recovery

---

## 36. OS Upgrades

### 🔄 The Problem

When you take a node offline (reboot for patches), pods on that node become unavailable. Kubernetes waits **5 minutes** before declaring pods dead and rescheduling them.

### ✅ Safe Process: Drain → Upgrade → Uncordon

```bash
# Step 1: Drain — safely move all pods to other nodes
kubectl drain worker-node-1 --ignore-daemonsets --delete-emptydir-data

# Step 2: Perform OS upgrade / patching on the node
# (SSH into the node and do your work)

# Step 3: Uncordon — allow new pods to be scheduled again
kubectl uncordon worker-node-1
```

### 🔑 Cordon vs Drain

| Command | What it does | Existing pods moved? |
|---------|-------------|---------------------|
| `kubectl cordon <node>` | Mark as unschedulable (no new pods) | ❌ No |
| `kubectl drain <node>` | Mark as unschedulable + evict all pods | ✅ Yes |
| `kubectl uncordon <node>` | Re-enable scheduling | N/A |

### 💡 Production Tip
```bash
# If drain fails due to pods not part of a ReplicaSet/Deployment:
kubectl drain worker-node-1 \
  --ignore-daemonsets \
  --delete-emptydir-data \
  --force    # Force eviction of standalone pods (WARNING: they are lost!)
```

---

## 37. Cluster Upgrade with kubeadm

### 📖 Version Skew Policy

| Component | Allowed version skew from API Server |
|-----------|-------------------------------------|
| Controller Manager, Scheduler | Same or 1 minor version older |
| Kubelet, kube-proxy | Same or up to 2 minor versions older |

**Rule:** API Server must always be the highest version.

### 🔄 Upgrade Strategy: One Minor Version at a Time

```
v1.28 → v1.29 → v1.30   (correct)
v1.28 → v1.30            (NOT supported)
```

### 🛠️ Complete Upgrade Process (1.28 → 1.29)

#### Phase 1: Upgrade Control Plane

```bash
# --- On the Control Plane Node ---

# Step 1: Update package repo
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
  https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | \
  sudo tee /etc/apt/sources.list.d/kubernetes.list

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | \
  sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

sudo apt-get update

# Step 2: Upgrade kubeadm
sudo apt-mark unhold kubeadm
sudo apt-get install -y kubeadm=1.29.3-1.1
sudo apt-mark hold kubeadm

# Verify
kubeadm version

# Step 3: Check upgrade plan
sudo kubeadm upgrade plan

# Step 4: Apply upgrade
sudo kubeadm upgrade apply v1.29.3

# Step 5: Drain control plane
kubectl drain controlplane --ignore-daemonsets

# Step 6: Upgrade kubelet and kubectl
sudo apt-mark unhold kubelet kubectl
sudo apt-get install -y kubelet=1.29.3-1.1 kubectl=1.29.3-1.1
sudo apt-mark hold kubelet kubectl

sudo systemctl daemon-reload
sudo systemctl restart kubelet

# Step 7: Uncordon
kubectl uncordon controlplane

kubectl get nodes   # Verify control plane is v1.29.3
```

#### Phase 2: Upgrade Worker Nodes (Repeat per node)

```bash
# --- On each Worker Node ---

# Step 1: Upgrade kubeadm (same as above)
sudo apt-mark unhold kubeadm && \
sudo apt-get install -y kubeadm=1.29.3-1.1 && \
sudo apt-mark hold kubeadm

# Step 2: Update node config
sudo kubeadm upgrade node

# Step 3: Drain (run from control plane)
kubectl drain worker-node-1 --ignore-daemonsets

# Step 4: Upgrade kubelet + kubectl on worker node
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get install -y kubelet=1.29.3-1.1 kubectl=1.29.3-1.1 && \
sudo apt-mark hold kubelet kubectl

sudo systemctl daemon-reload
sudo systemctl restart kubelet

# Step 5: Uncordon (from control plane)
kubectl uncordon worker-node-1
```

### ✅ Verify

```bash
kubectl get nodes
# All nodes should show v1.29.3
```

### 💡 CKA Exam Tip
> The exam usually asks you to upgrade the control plane first, then worker nodes. Always drain before upgrading kubelet. Remember `apt-mark unhold` before installing and `apt-mark hold` after.

---

## 38. Backup and Restore

### 📖 What to Back Up?

| What | Why | How |
|------|-----|-----|
| Resource definitions | Entire cluster state | `kubectl get all -A -o yaml` |
| etcd data | Everything Kubernetes knows | `etcdctl snapshot save` |
| Persistent Volumes | Application data | Cloud snapshots / Velero |

### 🔄 Method 1: kubectl Backup

```bash
kubectl get all --all-namespaces -o yaml > cluster-backup.yaml
# Captures: pods, deployments, services, configmaps, etc.
# Does NOT capture: PV data, secrets (if base64 only)
```

### 🔄 Method 2: etcd Snapshot (Recommended)

```bash
# Create snapshot
ETCDCTL_API=3 etcdctl snapshot save /backup/etcd-snapshot.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key

# Verify snapshot
ETCDCTL_API=3 etcdctl snapshot status /backup/etcd-snapshot.db
```

### 🔄 Restore from etcd Snapshot

```bash
# Step 1: Stop the API server (if running as service)
systemctl stop kube-apiserver

# Step 2: Restore snapshot to new directory
ETCDCTL_API=3 etcdctl snapshot restore /backup/etcd-snapshot.db \
  --data-dir=/var/lib/etcd-restored

# Step 3: Update etcd configuration
# In /etc/kubernetes/manifests/etcd.yaml:
# Change: --data-dir=/var/lib/etcd
# To:     --data-dir=/var/lib/etcd-restored

# Step 4: Restart services
systemctl restart etcd
systemctl restart kube-apiserver
# (or kubelet will auto-restart static pod)
```

### 📋 Backup Strategy Comparison

| Method | Pros | Cons |
|--------|------|------|
| `kubectl get all -o yaml` | Simple, no access to etcd needed | Misses some resources |
| etcd snapshot | Complete cluster state | Requires etcd access & certs |
| Velero | Backup PVs too, cloud integration | Needs extra tooling |

### 💡 CKA Exam Tip
> The exam frequently asks you to restore etcd from a snapshot. Know these flags by heart:
> - `--cacert`, `--cert`, `--key` for authentication
> - `--endpoints` for etcd address
> - `--data-dir` for the restore destination

### ⚠️ Critical Reminder

```bash
# Always export ETCDCTL_API=3 before using etcdctl
export ETCDCTL_API=3
```

---

## 🎯 Quick Reference — Essential kubectl Commands

```bash
# ===== PODS =====
kubectl run nginx --image=nginx
kubectl get pods -o wide
kubectl describe pod nginx
kubectl logs -f nginx
kubectl exec -it nginx -- bash
kubectl delete pod nginx

# ===== DEPLOYMENTS =====
kubectl create deployment web --image=nginx --replicas=3
kubectl get deployments
kubectl set image deployment/web nginx=nginx:1.22
kubectl rollout status deployment/web
kubectl rollout undo deployment/web
kubectl scale deployment web --replicas=5

# ===== SERVICES =====
kubectl expose deployment web --port=80 --type=NodePort
kubectl get svc
kubectl describe svc web

# ===== NAMESPACES =====
kubectl create ns staging
kubectl get pods -n staging
kubectl get pods --all-namespaces

# ===== NODES =====
kubectl get nodes
kubectl describe node worker-1
kubectl drain worker-1 --ignore-daemonsets
kubectl cordon worker-1
kubectl uncordon worker-1
kubectl taint nodes worker-1 key=val:NoSchedule

# ===== DEBUG =====
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl top pods
kubectl top nodes
kubectl api-resources
```

---

## 🏆 CKA Exam Tips Summary

| Tip | Detail |
|-----|--------|
| **Time management** | Use imperative commands for speed; declarative for complex configs |
| **Dry run** | `kubectl apply -f file.yaml --dry-run=client` to validate |
| **Generate YAML** | `kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml` |
| **Context switching** | `kubectl config use-context <context>` — don't forget! |
| **etcdctl** | Always set `ETCDCTL_API=3` |
| **Static pods** | Find at `/etc/kubernetes/manifests/` |
| **Taints** | Remove with trailing `-`: `kubectl taint nodes node1 key=val:NoSchedule-` |
| **Namespaces** | Use `-n` flag or set default context namespace |
| **Shortcuts** | `po`=pods, `svc`=services, `ns`=namespaces, `rs`=replicasets, `deploy`=deployments |
| **Documentation** | `kubernetes.io/docs` is allowed — bookmark key pages |

---

## 🚨 Common Mistakes to Avoid

| Mistake | Fix |
|---------|-----|
| Wrong `apiVersion` | Pods=`v1`, Deployments/RS=`apps/v1`, RBAC=`rbac.authorization.k8s.io/v1` |
| `selector` doesn't match `template.labels` | They must be identical in Deployments/ReplicaSets |
| Modifying `nodeName` after pod creation | Can't be changed; delete and recreate |
| Mixing `kubectl create` and `kubectl apply` | Stick to one approach per resource |
| Forgetting `-n` namespace flag | Always specify namespace or set context |
| Not setting `ETCDCTL_API=3` | etcdctl v2 syntax is different |
| Draining without `--ignore-daemonsets` | Will fail; add the flag |
| Secret values not base64-encoded in YAML | Must base64 encode all values |

---

*📌 These notes cover all topics from the provided course materials. Review regularly and practice with hands-on labs for best retention.*
