# 🚀 Kubernetes Core Production Handbook
### CKA-Level Deep Notes | Production-Oriented | Interview-Ready

---

## 📋 Table of Contents

### Part I — Core Concepts
- [1. Cluster Architecture](#1-cluster-architecture)
- [2. Docker vs ContainerD](#2-docker-vs-containerd)
- [3. ETCD for Beginners](#3-etcd-for-beginners)
- [4. ETCD in Kubernetes](#4-etcd-in-kubernetes)
- [5. Kube API Server](#5-kube-api-server)
- [6. Kube Controller Manager](#6-kube-controller-manager)
- [7. Kube Scheduler](#7-kube-scheduler)
- [8. Kubelet](#8-kubelet)
- [9. Kube Proxy](#9-kube-proxy)
- [10. Pods](#10-pods)
- [11. Pods with YAML](#11-pods-with-yaml)
- [12. ReplicaSets](#12-replicasets)
- [13. Deployments](#13-deployments)
- [14. Services — NodePort](#14-services--nodeport)
- [15. Services — ClusterIP](#15-services--clusterip)
- [16. Services — LoadBalancer](#16-services--loadbalancer)
- [17. Namespaces](#17-namespaces)
- [18. Imperative vs Declarative](#18-imperative-vs-declarative)
- [19. Kubectl Apply Command](#19-kubectl-apply-command)

### Part II — Scheduling
- [20. Manual Scheduling](#20-manual-scheduling)
- [21. Labels and Selectors](#21-labels-and-selectors)
- [22. Taints and Tolerations](#22-taints-and-tolerations)
- [23. Node Selectors](#23-node-selectors)
- [24. Node Affinity](#24-node-affinity)
- [25. Taints/Tolerations vs Node Affinity](#25-taintstolerations-vs-node-affinity)
- [26. DaemonSets](#26-daemonsets)
- [27. Static Pods](#27-static-pods)
- [28. Priority Classes](#28-priority-classes)
- [29. Multiple Schedulers](#29-multiple-schedulers)
- [30. Configuring Scheduler Profiles](#30-configuring-scheduler-profiles)
- [31. Admission Controllers](#31-admission-controllers)
- [32. Validating and Mutating Admission Controllers](#32-validating-and-mutating-admission-controllers)

### Part III — Logging, Monitoring & Lifecycle Management
- [33. Managing Application Logs](#33-managing-application-logs)
- [34. Rolling Updates and Rollbacks](#34-rolling-updates-and-rollbacks)
- [35. Commands and Arguments in Docker](#35-commands-and-arguments-in-docker)
- [36. Commands and Arguments in Kubernetes](#36-commands-and-arguments-in-kubernetes)
- [37. Secrets](#37-secrets)
- [38. Encrypting Secret Data at Rest](#38-encrypting-secret-data-at-rest)
- [39. Multi-Container Pods](#39-multi-container-pods)
- [40. Introduction to Autoscaling](#40-introduction-to-autoscaling)
- [41. Horizontal Pod Autoscaler (HPA)](#41-horizontal-pod-autoscaler-hpa)
- [42. In-Place Resize of Pods](#42-in-place-resize-of-pods)

### Part IV — Cluster Maintenance
- [43. OS Upgrades](#43-os-upgrades)
- [44. Cluster Upgrade Process](#44-cluster-upgrade-process)
- [45. Backup and Restore Methods](#45-backup-and-restore-methods)

---

---

# Part I — Core Concepts

---

## 1. Cluster Architecture

### What Is It?
Kubernetes Cluster Architecture is the foundational blueprint describing how Kubernetes organizes, manages, and orchestrates containerized workloads. It divides responsibilities between **Master (Control Plane) Nodes** and **Worker Nodes**, much like a harbor where control ships manage cargo ships.

### Why Do We Need It?
Without a structured architecture, deploying containers at scale would require manual intervention for every placement, restart, networking, and scaling decision. Kubernetes architecture automates all of this, providing:
- Automated scheduling and placement
- Self-healing through controllers
- Centralized state management via etcd
- Declarative configuration management

### Key Components

| Component | Node Type | Role |
|---|---|---|
| etcd | Master | Distributed key-value store; cluster brain/memory |
| kube-apiserver | Master | Central hub; all communication passes through here |
| kube-scheduler | Master | Decides which node a pod runs on |
| kube-controller-manager | Master | Watches state and drives toward desired state |
| kubelet | Worker | Pod lifecycle manager on each node |
| kube-proxy | Worker | Network rules and inter-pod communication |
| Container Runtime | Both | Runs actual containers (containerd, CRI-O) |

### Internal Working — Step-by-Step Flow

```
User Request (kubectl apply)
        ↓
[1] kube-apiserver authenticates & validates
        ↓
[2] Object written to etcd (desired state stored)
        ↓
[3] kube-scheduler detects unscheduled Pod
        ↓
[4] Scheduler scores nodes → selects best fit → updates etcd via API
        ↓
[5] kubelet on selected worker node polls API Server
        ↓
[6] kubelet instructs container runtime (containerd) to pull image & start container
        ↓
[7] kubelet reports status back to API Server → etcd updated (actual state)
        ↓
[8] Controllers continuously reconcile desired vs actual state
```

### Architecture Flow Diagram (Text)

```
┌─────────────────── MASTER NODE ──────────────────────┐
│                                                        │
│   ┌──────────┐    ┌──────────┐    ┌───────────────┐  │
│   │   etcd   │◄──►│  kube-   │◄──►│  kube-        │  │
│   │ (state)  │    │apiserver │    │  scheduler    │  │
│   └──────────┘    └────┬─────┘    └───────────────┘  │
│                        │                               │
│                   ┌────▼──────────────────────┐       │
│                   │  kube-controller-manager  │       │
│                   └───────────────────────────┘       │
└───────────────────────────┬───────────────────────────┘
                            │ HTTPS API calls
          ┌─────────────────┼──────────────────┐
          ▼                 ▼                  ▼
┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│  WORKER NODE │   │  WORKER NODE │   │  WORKER NODE │
│  ┌────────┐  │   │  ┌────────┐  │   │  ┌────────┐  │
│  │kubelet │  │   │  │kubelet │  │   │  │kubelet │  │
│  └────────┘  │   │  └────────┘  │   │  └────────┘  │
│  ┌──────────┐│   │  ┌──────────┐│   │  ┌──────────┐│
│  │kube-proxy││   │  │kube-proxy││   │  │kube-proxy││
│  └──────────┘│   │  └──────────┘│   │  └──────────┘│
│  ┌──────────┐│   │  ┌──────────┐│   │  ┌──────────┐│
│  │  Pods    ││   │  │  Pods    ││   │  │  Pods    ││
│  └──────────┘│   │  └──────────┘│   │  └──────────┘│
└──────────────┘   └──────────────┘   └──────────────┘
```

### Real-World Production Scenario

**Application:** E-commerce platform (microservices)  
**Architecture:**  
- 3 Master nodes (HA control plane with etcd cluster)
- 10+ Worker nodes across 3 availability zones
- Each service (cart, checkout, inventory) deployed as Deployments

**Deployment Approach:**  
All services deployed declaratively via Helm charts. Controllers ensure desired replica counts are always maintained. Scheduler places pods based on node affinity rules (zone-aware placement).

**Failure Handling:**  
- If a worker node fails → Node Controller detects via missed heartbeats (40s grace + 5min eviction timer) → Pods rescheduled to healthy nodes
- If master node fails → etcd quorum maintained with 3-node HA cluster; other control plane nodes take over

**Monitoring:**  
Prometheus + kube-state-metrics tracks pod counts, node health, API server latency.

### Common Mistakes
- Running only one master node in production (no HA)
- Not separating etcd from master (high I/O contention)
- Ignoring node resource capacity leading to over-scheduling
- Missing pod disruption budgets during node failures

### Debugging & Troubleshooting

```bash
# Check all control plane pods
kubectl get pods -n kube-system

# Check component status (older versions)
kubectl get componentstatus

# Check API server logs (kubeadm setup)
kubectl logs kube-apiserver-master -n kube-system

# Check node health
kubectl describe node <node-name>
kubectl get events --sort-by=.metadata.creationTimestamp
```

### CKA Exam Tips
- Know which components run on master vs worker
- Understand that kube-apiserver is the ONLY component that talks to etcd directly
- kubelet is NOT deployed by kubeadm automatically on workers — must be installed manually
- Remember: Controller Manager and Scheduler can be ONE version LOWER than API Server; kubelet/proxy up to TWO versions lower

### Production Best Practices
- Run odd number of etcd nodes (3 or 5) for quorum
- Dedicate master nodes — no user workloads
- Enable audit logging on kube-apiserver
- Use network policies between control plane and worker communication
- Regularly test disaster recovery by simulating node failures

---

### 🔎 Summary — Cluster Architecture

- **Master Node** = Brain: runs etcd, API server, scheduler, controller manager
- **Worker Node** = Muscle: runs kubelet (node agent), kube-proxy, and actual pods
- **etcd** = Single source of truth — ALL cluster state lives here
- **kube-apiserver** = ONLY gateway; every component communicates through it
- **Scheduler** = Decides WHERE pods run (does NOT start them)
- **kubelet** = ACTUALLY starts containers by talking to container runtime
- **kube-proxy** = Maintains network rules for service-to-pod routing
- **Interview Answer:** "Kubernetes architecture separates decision-making (control plane) from execution (worker nodes). The API server is the central hub, etcd stores all state, the scheduler places workloads, controllers maintain desired state, and kubelets execute on each node."
- **Production Takeaway:** HA control plane (3+ masters, 3+ etcd) is non-negotiable for production. Workers can scale horizontally. Network between master and workers must be secured and monitored.

---

## 2. Docker vs ContainerD

### What Is It?
A comparison of Docker and ContainerD as container runtimes, explaining the evolution from Docker's monolithic architecture to the leaner, CRI-compatible ContainerD, along with the CLI tools (CTR, NerdCTL, crictl) used to interact with them.

### Why Do We Need It?
Kubernetes v1.24 removed direct Docker support. Understanding ContainerD and its tooling is critical for:
- Debugging containers in production Kubernetes clusters
- Understanding the CRI (Container Runtime Interface) standard
- Knowing which tool to use for which task (debugging vs. management)

### Key Components

| Component | Purpose | Maintained By |
|---|---|---|
| Docker | Full container platform (build, run, push) | Docker Inc. |
| ContainerD | CRI-compatible runtime (run containers only) | CNCF |
| CTR | Low-level debug CLI for ContainerD | ContainerD community |
| NerdCTL | Docker-like CLI for ContainerD | ContainerD community |
| crictl | Kubernetes-focused debug CLI for any CRI runtime | Kubernetes community |

### Internal Working — The Evolution

```
Historical Flow (Pre-Kubernetes 1.24):
kubectl → kube-apiserver → kubelet → dockershim → Docker Engine → containerd → runc → container

Modern Flow (Post-1.24):
kubectl → kube-apiserver → kubelet → CRI interface → containerd → runc → container
```

The key change: **dockershim was removed**. Kubernetes now speaks directly to any CRI-compliant runtime (containerd, CRI-O, etc.) via a standardized interface.

### Why Docker Was Removed from Kubernetes

Docker was built BEFORE the CRI standard. It contains many features (build tools, volumes, auth, networking, CLI) that Kubernetes does NOT need. Kubernetes only needs the ability to:
1. Pull images
2. Start containers
3. Stop containers
4. Inspect container state

ContainerD does exactly this, without the overhead of the full Docker stack.

### Tool Comparison

```
CTR:
  - Bundled with ContainerD
  - Limited features, primarily for debugging
  - ctr images pull docker.io/library/redis:alpine
  - NOT recommended for production use

NerdCTL:
  - Docker-compatible CLI for ContainerD
  - Supports: encrypted images, lazy pulling, P2P distribution
  - nerdctl run --name redis redis:alpine
  - RECOMMENDED for container management with ContainerD

crictl:
  - Works with ANY CRI-compatible runtime
  - Kubernetes-maintained, for debugging
  - crictl ps, crictl logs, crictl pull
  - Used by Kubernetes admins for node-level debugging
  - Containers created with crictl may be deleted by kubelet
```

### CRI Runtime Endpoints (Kubernetes 1.24+)

```bash
# Manually set runtime endpoint
crictl --runtime-endpoint unix:///run/containerd/containerd.sock ps

# Or export for session
export CONTAINER_RUNTIME_ENDPOINT=unix:///run/containerd/containerd.sock
```

### Real-World Production Scenario

**Problem:** A pod is stuck in `CrashLoopBackOff`. Kubernetes-level logs aren't sufficient.

**Solution with crictl:**
```bash
# List all containers including stopped ones
crictl ps -a

# Get logs from a specific container by container ID
crictl logs <container-id>

# Inspect container details
crictl inspect <container-id>

# Execute into a running container
crictl exec -it <container-id> /bin/sh
```

### Common Mistakes
- Using `docker` commands on a node running ContainerD (they won't work)
- Trying to manage Kubernetes pods with `ctr` directly
- Manually creating containers with `crictl` without knowing kubelet will remove them
- Forgetting to set `CONTAINER_RUNTIME_ENDPOINT` when using crictl

### Debugging & Troubleshooting

```bash
# Find runtime endpoint in use
cat /var/lib/kubelet/config.yaml | grep containerRuntime

# Check containerd service
systemctl status containerd

# Check crictl config
cat /etc/crictl.yaml

# Verify container runtime via kubelet process
ps -aux | grep kubelet | grep container-runtime
```

### CKA Exam Tips
- Know that `crictl` is used for CRI-level debugging on Kubernetes nodes
- Know that Docker was removed in Kubernetes 1.24
- `nerdctl` = Docker replacement for ContainerD management
- `ctr` = low-level debugging only
- Docker images are OCI-compliant and work fine with ContainerD

### Production Best Practices
- Use ContainerD as the runtime for production Kubernetes clusters
- Configure crictl with proper endpoint in `/etc/crictl.yaml`
- Never create standalone containers with crictl in production (kubelet will delete them)
- Use nerdctl for any node-level container management tasks outside Kubernetes

---

### 🔎 Summary — Docker vs ContainerD

- **Docker** is a full platform; Kubernetes only needed the runtime part
- **ContainerD** = Docker's runtime, extracted and made CRI-compatible
- **CRI** = Standard interface Kubernetes uses to talk to any container runtime
- **CTR** = Debug only; limited use
- **NerdCTL** = Daily use with ContainerD (like docker CLI)
- **crictl** = Kubernetes admin's debugging tool for node-level container inspection
- **Production Takeaway:** In modern clusters, ContainerD is the default runtime. Use `crictl` to debug pods at the node level when `kubectl logs` is insufficient.

---

## 3. ETCD for Beginners

### What Is It?
etcd is a **distributed, reliable, key-value store** that is fast, simple, and consistent. It stores data as key-value pairs (not tabular rows/columns like SQL). It is the foundational data store for Kubernetes — the cluster's "long-term memory."

### Why Do We Need It?
Kubernetes needs a place to store the ENTIRE cluster state:
- What nodes exist
- What pods are running
- What the desired state is
- Secrets, ConfigMaps, ServiceAccounts, RBAC rules

etcd provides this with:
- **Consistency** via the Raft consensus algorithm
- **Reliability** through data replication across nodes
- **Speed** optimized for read-heavy workloads

### Key Concepts

**Key-Value vs Relational:**
```
Relational DB (SQL):
| Name      | Age | Location  | Salary |
|-----------|-----|-----------|--------|
| John Doe  | 45  | New York  | 5000   |
| Dave Smith| 34  | New York  | 4000   |
| Aryan (10)| 10  | New York  | NULL   |  ← NULL for non-applicable fields

Key-Value Store (etcd):
"John Doe" → { "age": 45, "location": "New York", "salary": 5000 }
"Aryan"    → { "age": 10, "location": "New York", "grade": "A" }
            ← Each entry is independent; no NULL/schema issues
```

The key-value model allows each document to have its own structure — perfect for Kubernetes objects which vary widely in their properties.

### Internal Working — Raft Consensus

```
etcd Cluster (3 nodes):
  Node A (Leader) ←─── receives write request
        ↓
  Sends log entry to Node B and Node C
        ↓
  Waits for quorum (majority = 2 of 3)
        ↓
  Once quorum acknowledges → commits entry → responds to client
        ↓
  Node B and C apply the committed entry
```

**Quorum formula:** `(n/2) + 1` nodes must agree for a write to succeed.
- 3 nodes → quorum = 2 → can tolerate 1 failure
- 5 nodes → quorum = 3 → can tolerate 2 failures

### etcd Version History

| Version | Release Date | Key Feature |
|---|---|---|
| 0.1 | August 2013 | Initial release |
| 2.0 | February 2015 | Raft consensus algorithm added |
| 3.0 | January 2017 | Performance optimizations, gRPC |
| CNCF | November 2018 | Graduated as CNCF project |

### API v2 vs v3 Commands

```bash
# Check API version
./etcdctl --version
# etcdctl version: 3.3.11
# API version: 2  ← default may be v2

# Switch to API v3 (recommended)
export ETCDCTL_API=3
./etcdctl version
# API version: 3

# v2 commands (legacy)
./etcdctl set key1 value1
./etcdctl get key1

# v3 commands (current)
./etcdctl put key1 value1   # "set" → "put" in v3
./etcdctl get key1
```

### Installation Quick Reference

```bash
# Download etcd
curl -L https://github.com/etcd-io/etcd/releases/download/v3.3.11/etcd-v3.3.11-linux-amd64.tar.gz \
  -o etcd-v3.3.11-linux-amd64.tar.gz

# Extract
tar xzvf etcd-v3.3.11-linux-amd64.tar.gz

# Run etcd (default port: 2379)
./etcd
```

### CKA Exam Tips
- Always use `ETCDCTL_API=3` before any etcdctl commands in the exam
- Default port is **2379** (client), **2380** (peer)
- Know the v2 vs v3 command differences (`set` → `put`)
- Remember: `version` is a subcommand in v3, not a flag

### Production Best Practices
- Always deploy etcd with **TLS** encryption
- Use **odd numbers** (3 or 5) for cluster size
- Separate etcd nodes from Kubernetes control plane in large clusters
- Monitor etcd disk I/O — high I/O = etcd bottleneck
- Set up regular snapshots for backup

---

### 🔎 Summary — ETCD for Beginners

- **etcd** = Distributed key-value store; Kubernetes' source of truth
- Stores data as flexible JSON/YAML documents, not rigid tables
- Uses **Raft consensus** for distributed agreement
- Default port: **2379** for clients, **2380** for peer communication
- API v3 uses `put`/`get`; API v2 uses `set`/`get`
- Always set `ETCDCTL_API=3` in Kubernetes environments
- **Production Takeaway:** etcd is the most critical component in Kubernetes. Its loss = cluster loss. Protect it with TLS, HA, and regular snapshots.

---

## 4. ETCD in Kubernetes

### What Is It?
etcd in the Kubernetes context is the **single source of truth** for ALL cluster state. Every object (node, pod, deployment, secret, role, configmap) is stored here. Changes are only "complete" once written to etcd.

### How Kubernetes Uses etcd

```
kubectl create deployment nginx → API Server → writes to etcd
                                                    ↓
kubectl get deployment nginx ← API Server ← reads from etcd
```

**Every cluster operation = a read or write to etcd.**

### Deployment Methods

#### Method 1: Manual (from scratch)
```bash
# Download binary
wget -q --https-only \
  "https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz"

# Service configuration (excerpt)
ExecStart=/usr/local/bin/etcd \
  --name ${ETCD_NAME} \
  --cert-file=/etc/etcd/kubernetes.pem \
  --key-file=/etc/etcd/kubernetes-key.pem \
  --initial-advertise-peer-urls https://${INTERNAL_IP}:2380 \
  --listen-client-urls https://${INTERNAL_IP}:2379,https://127.0.0.1:2379 \
  --advertise-client-urls https://${INTERNAL_IP}:2379 \
  --initial-cluster controller-0=https://${CONTROLLER0_IP}:2380,controller-1=https://${CONTROLLER1_IP}:2380 \
  --data-dir=/var/lib/etcd
```

#### Method 2: kubeadm (automated)
```bash
# kubeadm deploys etcd as a pod in kube-system
kubectl get pods -n kube-system | grep etcd
# etcd-master    1/1    Running    0    1h

# View all keys in etcd registry
kubectl exec etcd-master -n kube-system -- \
  etcdctl get / --prefix --keys-only
# Output:
# /registry/apiregistration.k8s.io/apiservices/v1
# /registry/pods/default/nginx
# /registry/deployments/default/my-app
# ...
```

### Registry Structure in etcd

```
/registry/
├── nodes/
├── pods/
│   ├── default/
│   └── kube-system/
├── deployments/
├── services/
├── secrets/
├── configmaps/
├── namespaces/
├── replicasets/
└── apiregistration.k8s.io/
```

### High Availability etcd Configuration

For HA, the `--initial-cluster` parameter lists ALL etcd members:
```bash
--initial-cluster \
  controller-0=https://10.240.0.10:2380,\
  controller-1=https://10.240.0.11:2380,\
  controller-2=https://10.240.0.12:2380
```

### Real-World Production Scenario

**Problem:** Production cluster becomes unresponsive after etcd leader election issue.

**Diagnosis:**
```bash
# Check etcd health
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/etcd-server.crt \
  --key=/etc/etcd/etcd-server.key \
  endpoint health

# Check etcd member list
ETCDCTL_API=3 etcdctl member list \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/etcd-server.crt \
  --key=/etc/etcd/etcd-server.key
```

**Resolution:** Identified one etcd member with disk I/O saturation causing election timeouts. Replaced the node, rejoined cluster. Took < 15 minutes with proper runbooks.

### Debugging & Troubleshooting

```bash
# Check etcd pod logs (kubeadm)
kubectl logs etcd-master -n kube-system

# Check etcd cluster health directly
ETCDCTL_API=3 etcdctl endpoint health \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key

# List all cluster members
ETCDCTL_API=3 etcdctl member list \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key
```

### CKA Exam Tips
- Know the difference between kubeadm etcd (pod in kube-system) vs. manually deployed etcd
- For etcdctl commands, ALWAYS include `--cacert`, `--cert`, `--key` flags
- The `--advertise-client-urls` value is what the API Server connects to (port 2379)
- Know where etcd data directory is: typically `/var/lib/etcd`

### Production Best Practices
- etcd disk should be **SSD** — high IOPS required
- Monitor `etcd_server_leader_changes_seen_total` metric — frequent changes = unstable cluster
- Set `--heartbeat-interval=100` and `--election-timeout=1000` for stable clusters
- Never run etcd on the same disk as the OS
- Take regular snapshots (see Backup section)

---

### 🔎 Summary — ETCD in Kubernetes

- **All Kubernetes state** lives in etcd — nodes, pods, configs, secrets, RBAC
- Kubernetes API Server is the **only** component that directly reads/writes etcd
- Changes are "complete" only after being written to etcd
- Deploy with kubeadm (pod) or manually (service)
- HA requires configuring `--initial-cluster` with all member addresses
- **Production Takeaway:** etcd is the most critical single point of failure. Protect it with HA (3+ nodes), TLS, dedicated SSDs, and automated backups. Losing etcd means losing the entire cluster state.

---

## 5. Kube API Server

### What Is It?
The **kube-apiserver** is the central management component of Kubernetes — the "front door" to the entire cluster. Every kubectl command, every controller action, every scheduler decision goes through the API server. It is the ONLY component that directly interacts with etcd.

### Why Do We Need It?
Without the API server, no component in the cluster can communicate. It provides:
- **Authentication** of all requests
- **Authorization** (RBAC, ABAC, Webhook)
- **Admission Control** (validation and mutation)
- **RESTful API** for all cluster operations
- **Watch mechanism** for components to detect changes

### Request Lifecycle — Step by Step

```
[1] Client sends request (kubectl, curl, controller)
        ↓
[2] Authentication (certificates, tokens, basic auth)
        ↓
[3] Authorization (RBAC: can this user do this action?)
        ↓
[4] Admission Controllers (validate/mutate the object)
        ↓
[5] Validation (schema validation of the object)
        ↓
[6] Persist to etcd
        ↓
[7] Return response to client

For Pod creation specifically:
[6a] API Server stores Pod object in etcd (nodeName = empty)
[6b] Scheduler detects unscheduled pod → assigns node → updates etcd
[6c] kubelet on target node detects pod → starts container
[6d] kubelet reports status back → API Server updates etcd
```

### Architecture Flow

```
┌──────────────┐    ┌─────────────────────────────────────────┐
│  kubectl CLI │───►│           kube-apiserver                │
└──────────────┘    │  ┌──────────────────────────────────┐   │
                    │  │ 1. Auth  2. AuthZ  3. Admission  │   │
┌──────────────┐    │  │ 4. Validate  5. Persist          │   │
│  Scheduler   │◄──►│  └──────────────────────────────────┘   │
└──────────────┘    │              ↕                           │
                    │         ┌────────┐                       │
┌──────────────┐    │         │  etcd  │                       │
│  Controllers │◄──►│         └────────┘                       │
└──────────────┘    └─────────────────────────────────────────┘
                                 ↕
┌──────────────┐         ┌──────────────┐
│   kubelet    │◄────────│ Watch Events │
└──────────────┘         └──────────────┘
```

### Key Configuration Options

```bash
# Typical kube-apiserver startup flags
kube-apiserver \
  --advertise-address=${INTERNAL_IP} \          # IP used by other components to reach API server
  --etcd-servers=https://127.0.0.1:2379 \        # etcd connection
  --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt \ # TLS for etcd
  --authorization-mode=Node,RBAC \               # Auth modes
  --enable-admission-plugins=NodeRestriction \   # Admission plugins
  --service-cluster-ip-range=10.96.0.0/12 \      # Service IP range
  --service-node-port-range=30000-32767 \        # NodePort range
  --apiserver-count=3 \                          # For HA setups
  --audit-log-path=/var/log/audit.log            # Audit logging
```

### Viewing API Server Configuration

```bash
# kubeadm: API server runs as a pod
kubectl get pod kube-apiserver-master -n kube-system -o yaml

# Manual installation: check systemd service
cat /etc/systemd/system/kube-apiserver.service

# Check running process
ps -aux | grep kube-apiserver
```

### Real-World Production Scenario

**Issue:** API Server returning 429 (Too Many Requests) under load.

**Root Cause:** Excessive controller reconciliation loops + monitoring scraping hitting API server.

**Solution:**
```bash
# Check API server metrics
curl -sk https://localhost:6443/metrics | grep apiserver_request

# Enable API Priority and Fairness (APF)
--enable-priority-and-fairness=true

# Tune rate limiting
--max-requests-inflight=800
--max-mutating-requests-inflight=200
```

**Monitoring Implementation:**  
Alert on `apiserver_request_duration_seconds_p99 > 1s` and `apiserver_request_total{code="429"} > 0`.

### Debugging & Troubleshooting

```bash
# View API server logs (kubeadm)
kubectl logs kube-apiserver-master -n kube-system --tail=100

# Check API server health
curl -k https://localhost:6443/healthz

# Check readiness
curl -k https://localhost:6443/readyz

# Check available API versions
kubectl api-versions

# Check API resources
kubectl api-resources
```

### CKA Exam Tips
- Know where API server manifest lives: `/etc/kubernetes/manifests/kube-apiserver.yaml`
- Remember API server is stateless — etcd holds state
- Authorization modes are ordered: `Node,RBAC` means Node auth checked first
- Default service cluster IP range is `10.96.0.0/12`
- API server is the ONLY component talking to etcd

### Production Best Practices
- Enable audit logging (`--audit-log-path`)
- Run 3 API server instances in HA (behind a load balancer)
- Use RBAC (`--authorization-mode=Node,RBAC`)
- Enable admission plugins for security (NodeRestriction, PodSecurity)
- Monitor API server latency and error rates

---

### 🔎 Summary — Kube API Server

- **API Server** = Single entry point for ALL cluster operations
- Handles: Authentication → Authorization → Admission → Validation → etcd persistence
- **Only component** that reads/writes etcd directly
- Scheduler, Controllers, kubelet all communicate ONLY via API Server
- Exposes RESTful HTTP endpoints; kubectl is just an HTTP client
- **Interview Answer:** "The kube-apiserver is the control plane's front door. Every operation — from kubectl commands to controller reconciliations — goes through it. It authenticates requests, checks authorization via RBAC, runs admission controllers, and persists objects to etcd."
- **Production Takeaway:** The API server is stateless (state in etcd), so it scales horizontally. In HA setups, run 3 replicas behind a load balancer. Always enable audit logging.

---

## 6. Kube Controller Manager

### What Is It?
The **kube-controller-manager** is a single binary that bundles multiple controllers. Each controller is a control loop that watches the current state of the cluster and takes action to move it toward the desired state. Think of it as the "autopilot" of Kubernetes.

### The Controller Pattern

```
Desired State (in etcd): 3 replicas of nginx
Current State (actual): 2 replicas running
                           ↓
Controller detects drift: 3 desired ≠ 2 actual
                           ��
Controller action: Create 1 new Pod
                           ↓
State reconciled: 3 replicas running
```

This **observe → diff → act** loop runs continuously.

### Key Controllers and Their Roles

| Controller | Function |
|---|---|
| Node Controller | Monitors node health; evicts pods from failed nodes |
| Replication Controller | Ensures desired pod count is maintained |
| Deployment Controller | Manages rolling updates via ReplicaSets |
| StatefulSet Controller | Manages stateful application pods |
| DaemonSet Controller | Ensures one pod per node |
| Job Controller | Manages batch/one-shot jobs |
| Service Account Controller | Creates default service accounts in namespaces |
| Namespace Controller | Manages namespace lifecycle |
| Endpoint Controller | Populates Endpoints objects for Services |
| PersistentVolume Controller | Binds PVCs to PVs |

### Node Controller Timing Details

```
Node heartbeat monitoring:
├── Check interval: every 5 seconds
├── Grace period before "unreachable": 40 seconds
└── Eviction timeout: 5 minutes after unreachable
    └── After 5 min: pods moved to other nodes (if in ReplicaSet)
```

```bash
# Node controller options (in controller-manager service)
--node-monitor-period=5s
--node-monitor-grace-period=40s
--pod-eviction-timeout=5m0s
```

### Installation and Configuration

```bash
# Download
wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/\
  bin/linux/amd64/kube-controller-manager

# Service configuration
ExecStart=/usr/local/bin/kube-controller-manager \
  --cluster-cidr=10.200.0.0/16 \
  --leader-elect=true \           # Enable HA leader election
  --kubeconfig=/var/lib/kubernetes/kube-controller-manager.kubeconfig \
  --controllers=* \               # Enable ALL controllers
  --use-service-account-credentials=true
```

### Enabling/Disabling Specific Controllers

```bash
# Enable all except tokencleaner
--controllers=*,-tokencleaner

# Enable only specific controllers
--controllers=deployment,replicaset,node,namespace
```

### Viewing in a kubeadm Cluster

```bash
# Controller manager runs as a pod
kubectl get pod kube-controller-manager-master -n kube-system

# Inspect its manifest
cat /etc/kubernetes/manifests/kube-controller-manager.yaml

# Check running process
ps -aux | grep kube-controller-manager
```

### Real-World Production Scenario

**Scenario:** Deployment stuck at 80% rollout — pods not updating.

**Investigation:**
```bash
# Check controller manager logs
kubectl logs kube-controller-manager-master -n kube-system | grep -i "error\|warn"

# Check deployment rollout status
kubectl rollout status deployment/my-app

# Check ReplicaSets
kubectl get rs | grep my-app
# Shows: old RS with 2 pods + new RS with 8 pods → stuck

# Describe deployment for conditions
kubectl describe deployment my-app | grep -A 5 "Conditions:"
# Condition: Available=False, ProgressDeadlineExceeded=True
```

**Root Cause:** New pods crashing (ImagePullBackOff) — controller stops rollout at minAvailable threshold.

### Debugging & Troubleshooting

```bash
# Check controller manager logs
kubectl logs kube-controller-manager-master -n kube-system

# Check events for controller actions
kubectl get events --sort-by=.metadata.creationTimestamp -n default

# Verify leader election (HA clusters)
kubectl get endpoints kube-controller-manager -n kube-system -o yaml
# Look for: control-plane.alpha.kubernetes.io/leader annotation
```

### CKA Exam Tips
- Know that ALL controllers are in ONE binary (kube-controller-manager)
- Node monitor grace period = 40s; eviction timeout = 5 min
- `--leader-elect=true` is required in HA (multi-master) clusters
- Can enable/disable individual controllers with `--controllers` flag
- Controller manager talks to API server, NOT etcd directly

### Production Best Practices
- Enable `--leader-elect=true` for HA deployments
- Monitor controller queue depth and reconciliation errors
- Set `--node-monitor-grace-period` and `--pod-eviction-timeout` based on network reliability
- Watch for `kube_controller_manager_work_queue_depth` metric — spikes indicate issues

---

### 🔎 Summary — Kube Controller Manager

- **Single binary** containing many controllers
- Each controller follows: **observe → diff → act** (reconciliation loop)
- Node Controller: health check every 5s, mark unreachable after 40s, evict after 5min
- **Replication Controller**: ensures desired pod count
- Talks to API Server, NOT etcd directly
- Uses **leader election** for HA; only ONE instance actively reconciles at a time
- **Production Takeaway:** Controllers are the self-healing mechanism of Kubernetes. If a pod dies, a node fails, or a deployment is updated, controllers automatically bring the cluster to the desired state.

---

## 7. Kube Scheduler

### What Is It?
The **kube-scheduler** is responsible for deciding **which node** a pod should run on. It does NOT actually start the pod — that's kubelet's job. The scheduler only updates the `nodeName` field in the pod spec.

### Why Do We Need It?
Without intelligent scheduling:
- Nodes would be overloaded while others sit idle
- Pods with special hardware requirements might land on wrong nodes
- Multi-zone deployments wouldn't be balanced

### Two-Phase Scheduling Process

#### Phase 1: Filtering
Eliminate nodes that **cannot** host the pod:
```
Filters applied:
├── NodeResourcesFit: Does node have enough CPU/memory?
├── NodeName: Does pod specify a specific nodeName?
├── NodeUnschedulable: Is node cordoned/drained?
├── TaintToleration: Does pod tolerate node taints?
├── NodeAffinity: Does node match affinity rules?
└── PodTopologySpread: Spread constraints satisfied?
```

#### Phase 2: Scoring
Score remaining nodes (0–10) to find the **best fit**:
```
Scoring plugins:
├── LeastAllocated: Prefers nodes with more free resources
├── MostAllocated: Prefers nodes with less free resources (bin packing)
├── ImageLocality: Prefers nodes that already have the image
├── NodeAffinity: Higher score for preferred affinity rules
└── TaintToleration: Score based on toleration matches
```

The pod is scheduled on the node with the **highest score**.

### Example — CPU Scoring

```
Pod needs: 10 CPU

Node A: 16 CPU total, 4 allocated → 12 free
Node B: 12 CPU total, 6 allocated → 6 free
Node C: 8 CPU total → FILTERED OUT (not enough)

Scoring (LeastAllocated):
Node A: (12 free / 16 total) = 75% score = 7.5
Node B: (6 free / 12 total) = 50% score = 5.0

Winner: Node A (more free resources after scheduling)
```

### Installation

```bash
# Download
wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/\
  bin/linux/amd64/kube-scheduler

# Service file
ExecStart=/usr/local/bin/kube-scheduler \
  --config=/etc/kubernetes/config/kube-scheduler.yaml \
  --v=2
```

### Verify Scheduler

```bash
# kubeadm: scheduler is a pod
kubectl get pod kube-scheduler-master -n kube-system

# Check running process
ps -aux | grep kube-scheduler

# Check scheduler manifest
cat /etc/kubernetes/manifests/kube-scheduler.yaml
```

### Real-World Production Scenario

**Problem:** All pods being scheduled on 2 of 10 nodes; 8 nodes idle.

**Root Cause:** LeastAllocated scoring was working correctly, but 8 nodes had taints applied for maintenance and forgotten.

**Fix:**
```bash
# List tainted nodes
kubectl get nodes -o custom-columns=NAME:.metadata.name,\
TAINTS:.spec.taints

# Remove forgotten maintenance taints
kubectl taint nodes node3 maintenance:NoSchedule-

# Verify scheduling spreads
kubectl get pods -o wide | awk '{print $7}' | sort | uniq -c
```

### Debugging & Troubleshooting

```bash
# Pod stuck in Pending? Check why scheduler didn't assign it
kubectl describe pod <pod-name>
# Look for: "Events: Warning FailedScheduling"
# Example: "0/3 nodes are available: 3 Insufficient cpu"

# Check scheduler logs
kubectl logs kube-scheduler-master -n kube-system

# Get events for scheduling failures
kubectl get events | grep FailedScheduling
```

### CKA Exam Tips
- Scheduler ONLY sets `nodeName` — does NOT start containers
- Default scheduling: Filter → Score → Bind
- If no suitable node found → Pod stays `Pending`
- Know the most common `FailedScheduling` reasons: Insufficient CPU/memory, taint mismatch, affinity mismatch
- Can have multiple schedulers — pods specify `schedulerName` field

### Production Best Practices
- Monitor `scheduler_scheduling_algorithm_duration_seconds` for performance
- Use pod topology spread constraints for zone-aware placement
- Combine node affinity + taints/tolerations for guaranteed isolation
- Use `--leader-elect=true` for HA
- Set resource requests on ALL pods for accurate scheduling

---

### 🔎 Summary — Kube Scheduler

- **Scheduler decides WHERE pods run** — it does NOT start them
- Two-phase process: **Filter** (eliminate) → **Score** (rank) → **Bind** (assign nodeName)
- Common filter: CPU/memory fit, taints, affinity rules, node unschedulable
- Scoring plugins optimize for resource utilization or locality
- Pods without `nodeName` sit in **Pending** until scheduler assigns one
- **Production Takeaway:** Proper resource requests are critical. Without them, the scheduler can't make informed decisions, leading to node overloads and poor workload distribution.

---

## 8. Kubelet

### What Is It?
The **kubelet** is the primary node agent that runs on every worker node. It is the "captain" of the node — receiving instructions from the kube-apiserver and ensuring containers are running as expected.

### Key Responsibilities
1. Registers the node with the Kubernetes cluster
2. Watches the kube-apiserver for pods assigned to its node
3. Instructs the container runtime to start/stop containers
4. Monitors container and pod health
5. Reports node and pod status back to the API server
6. Manages container lifecycle: restarts, liveness probes, readiness probes

### Internal Working Flow

```
[1] kubelet registers node with API Server
        ↓
[2] kubelet polls API Server for pods assigned to this node
        ↓
[3] For each new pod:
    a. Pull container images via container runtime (containerd)
    b. Create pod sandbox (network namespace)
    c. Start containers
    d. Run liveness/readiness probes
        ↓
[4] kubelet continuously monitors containers
        ↓
[5] kubelet reports status to API Server every:
    - nodeStatusUpdateFrequency: 10s (heartbeat)
    - node lease: every 10s to kube-node-lease namespace
```

### IMPORTANT: kubelet is NOT deployed by kubeadm

Unlike other control plane components, **kubelet must be installed manually** on worker nodes:

```bash
# Download kubelet binary
wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/\
  bin/linux/amd64/kubelet

# Configure and run as a service
ExecStart=/usr/local/bin/kubelet \
  --config=/var/lib/kubelet/kubelet-config.yaml \
  --container-runtime=remote \
  --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock \
  --kubeconfig=/var/lib/kubelet/kubeconfig \
  --network-plugin=cni \
  --register-node=true
```

### kubelet-config.yaml (Key Settings)

```yaml
# /var/lib/kubelet/kubelet-config.yaml
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    enabled: true
authorization:
  mode: Webhook
clusterDomain: "cluster.local"
clusterDNS:
  - "10.96.0.10"
staticPodPath: /etc/kubernetes/manifests  # Where static pod definitions live
evictionHard:
  memory.available: "100Mi"              # Evict pods if < 100Mi memory free
  nodefs.available: "10%"                # Evict if disk < 10% free
containerRuntime: remote
containerRuntimeEndpoint: unix:///var/run/containerd/containerd.sock
```

### Verify Kubelet

```bash
# Check kubelet process
ps -aux | grep kubelet

# Check kubelet service status
systemctl status kubelet

# View kubelet logs
journalctl -u kubelet -f

# Check node registration
kubectl get nodes
```

### Real-World Production Scenario

**Problem:** Node shows `NotReady` in `kubectl get nodes`.

**Diagnosis:**
```bash
# Check kubelet service
systemctl status kubelet
# Output: Active: failed (Result: exit-code)

# Check kubelet logs
journalctl -u kubelet --since "5 minutes ago"
# Output: "failed to run Kubelet: unable to determine runtime API version"

# Root cause: Container runtime (containerd) crashed
systemctl status containerd
# Output: inactive

# Fix
systemctl restart containerd
systemctl restart kubelet

# Verify
kubectl get nodes
# Node: Ready
```

### Debugging & Troubleshooting

```bash
# Most common kubelet issues

# 1. Check kubelet logs
journalctl -u kubelet -n 100 --no-pager

# 2. Check node conditions
kubectl describe node <node-name> | grep -A 20 "Conditions:"

# 3. Check kubelet config
cat /var/lib/kubelet/kubelet-config.yaml
cat /var/lib/kubelet/kubeconfig

# 4. Check container runtime socket
ls /run/containerd/containerd.sock

# 5. Certificate issues
cat /var/lib/kubelet/pki/kubelet-client-current.pem | openssl x509 -noout -dates
```

### CKA Exam Tips
- kubelet is the ONLY component that runs directly as a **systemd service** on worker nodes (not a pod)
- kubelet must be manually installed — kubeadm doesn't deploy it automatically
- kubelet talks to container runtime via CRI socket
- Static pods are created by kubelet directly from manifest files
- Node `NotReady` → almost always a kubelet or container runtime issue

### Production Best Practices
- Set proper `evictionHard` thresholds to prevent OOM on nodes
- Enable TLS bootstrapping for secure kubelet certificate rotation
- Monitor `kubelet_node_name`, `kubelet_running_pods`, `kubelet_volume_stats_*`
- Configure `--protect-kernel-defaults=true` for security hardening
- Use systemd cgroup driver consistently with container runtime

---

### 🔎 Summary — Kubelet

- **kubelet** = Node agent; runs on every worker node as a systemd service
- Receives pod specs from API Server, instructs container runtime to create containers
- Reports node and pod health back to API Server (heartbeat every 10s)
- **NOT deployed by kubeadm** — must be installed manually on workers
- Node `NotReady` = suspect kubelet first
- Manages static pods from `/etc/kubernetes/manifests` directory
- **Production Takeaway:** kubelet is the critical bridge between the cluster control plane and the actual container workloads. If kubelet fails, the node stops reporting and pods won't start or restart.

---

## 9. Kube Proxy

### What Is It?
**kube-proxy** is a network agent that runs on every node. It maintains network rules (iptables/IPVS) that allow pods across nodes to communicate with each other via Kubernetes Services. When you create a Service, kube-proxy makes it reachable across the entire cluster.

### The Problem It Solves

```
Without kube-proxy:
Pod A (10.244.1.5, Node 1) wants to reach Pod B (10.244.2.3, Node 2)
→ No direct route between pod network CIDRs on different nodes
→ Pod A would need to know Pod B's exact IP (which changes on restart!)

With Services + kube-proxy:
Pod A → Service "backend" (ClusterIP: 10.96.100.50) → Pod B
→ Service IP is stable
→ kube-proxy has iptables rules on every node to route 10.96.100.50 → 10.244.2.3
```

### How kube-proxy Works

```
[1] Service created: ClusterIP 10.96.100.50, targetPort 8080
        ↓
[2] kube-proxy watches API Server for Service/Endpoint changes
        ↓
[3] kube-proxy creates iptables (or IPVS) rules on THIS node:
    "If destination is 10.96.100.50:80, DNAT to 10.244.2.3:8080"
        ↓
[4] Same rules created on ALL other nodes
        ↓
[5] Any pod on any node can reach the service via ClusterIP
```

### Proxy Modes

| Mode | Technology | Performance | Description |
|---|---|---|---|
| iptables | iptables rules | Medium | Default; random selection |
| IPVS | kernel IPVS | High | Better LB algorithms; preferred for large clusters |
| userspace | userspace proxy | Low | Legacy; avoid in production |

### Installation

```bash
# kubeadm deploys kube-proxy as a DaemonSet
kubectl get daemonset kube-proxy -n kube-system
# NAME         DESIRED   CURRENT   READY   ...
# kube-proxy   3         3         3       ...

# One kube-proxy pod per node
kubectl get pods -n kube-system | grep kube-proxy
```

### Verifying iptables Rules

```bash
# See NAT rules created by kube-proxy for a service
sudo iptables -t nat -L KUBE-SERVICES | grep <service-cluster-ip>

# See full chain
sudo iptables -t nat -L -n | grep 10.96.100.50

# IPVS rules (if using IPVS mode)
ipvsadm -Ln | grep 10.96.100.50
```

### Real-World Production Scenario

**Problem:** Pods can reach each other by IP but cannot reach services by ClusterIP.

**Diagnosis:**
```bash
# 1. Check kube-proxy pod health
kubectl get pods -n kube-system | grep kube-proxy
kubectl logs kube-proxy-xxxx -n kube-system

# 2. Verify iptables rules exist
iptables -t nat -L KUBE-SERVICES | grep <service-ip>

# 3. Check if kube-proxy config is correct
kubectl get configmap kube-proxy -n kube-system -o yaml

# 4. Check kube-proxy DaemonSet
kubectl describe daemonset kube-proxy -n kube-system
```

**Root Cause:** kube-proxy pods were crashing due to a misconfigured `clusterCIDR` in the ConfigMap after a cluster upgrade.

### CKA Exam Tips
- kube-proxy is deployed as a **DaemonSet** (one pod per node)
- Services are virtual — they don't have a corresponding network interface
- kube-proxy creates the NAT rules that make Services work
- In IPVS mode: `ipvsadm -Ln` to view virtual servers
- kube-proxy needs access to API Server to watch Endpoint changes

### Production Best Practices
- Use **IPVS mode** for clusters with 1000+ services (better performance)
- Monitor `kube_proxy_sync_proxy_rules_duration_seconds` metric
- Ensure kube-proxy DaemonSet has `tolerations` for master node taints (for debugging)
- Use `--metrics-bind-address=0.0.0.0:10249` to expose kube-proxy metrics

---

### 🔎 Summary — Kube Proxy

- **kube-proxy** = Network rules agent; one pod per node (DaemonSet)
- Watches API Server for Service/Endpoint changes
- Creates **iptables or IPVS rules** to route service traffic to backing pods
- Services without kube-proxy = unreachable ClusterIPs
- Deployed automatically by kubeadm as a DaemonSet
- **Production Takeaway:** If services are unreachable but pods have working IPs, kube-proxy is the first thing to check. Verify its pod health and the iptables/IPVS rules it has created.

---

## 10. Pods

### What Is It?
A **Pod** is the smallest deployable unit in Kubernetes. It wraps one or more containers into a single logical unit that shares:
- **Network namespace** (same IP address; containers communicate via localhost)
- **Storage volumes** (shared filesystem access)
- **Lifecycle** (created and terminated together)

### Why Not Deploy Containers Directly?
Kubernetes doesn't manage containers directly — it manages Pods. This abstraction allows:
- Multiple related containers to be co-located
- Sidecar patterns (logging agent, proxy)
- Shared storage without complex volume configurations
- Helper containers for initialization (init containers)

### Single Container vs Multi-Container Pods

```
Single-Container Pod (most common):
┌─────────────────────────────┐
│  Pod                        │
│  ┌─────────────────────┐    │
│  │  nginx container    │    │
│  └─────────────────────┘    │
│  IP: 10.244.1.5             │
└─────────────────────────────┘

Multi-Container Pod (sidecar pattern):
┌──────────────────────────────────┐
│  Pod: 10.244.1.5                 │
│  ┌──────────────┐ ┌───────────┐  │
│  │  App (8080)  │ │ log-agent │  │
│  └──────────────┘ └───────────┘  │
│  Shared volume, same IP          │
└──────────────────────────────────┘
```

### Pod Lifecycle States

```
Pending → ContainerCreating → Running → Succeeded/Failed → (Terminating)
```

| State | Meaning |
|---|---|
| Pending | Scheduled but image not pulled or containers not started yet |
| ContainerCreating | Image being pulled, container being created |
| Running | All containers started and running |
| CrashLoopBackOff | Container keeps crashing and restarting |
| OOMKilled | Container killed due to out-of-memory |
| ImagePullBackOff | Cannot pull the container image |
| Completed | All containers exited with status 0 (Jobs) |

### Creating Pods

```bash
# Imperative (quick testing)
kubectl run nginx --image=nginx

# From YAML (recommended for production)
kubectl apply -f pod.yaml

# Check status
kubectl get pods
kubectl get pods -o wide    # Shows IP and Node
kubectl describe pod nginx  # Detailed info including events
```

### Pod YAML with Complete Annotations

```yaml
# pod-production.yaml
apiVersion: v1
kind: Pod
metadata:
  name: webapp-pod
  namespace: production
  labels:
    app: webapp
    tier: frontend
    version: "2.1"
  annotations:
    description: "Frontend web application"
    buildVersion: "2.1.0-abc123"
spec:
  # nodeName: node01  ← Uncomment for manual scheduling
  containers:
  - name: webapp
    image: myregistry/webapp:2.1
    # ImagePullBackOff occurs if:
    # - Image name is wrong
    # - Registry is unreachable
    # - Authentication credentials missing
    # Fix: kubectl describe pod webapp-pod → check Events
    
    ports:
    - containerPort: 8080
    
    resources:
      requests:
        cpu: "250m"          # Guaranteed minimum CPU
        memory: "256Mi"      # Guaranteed minimum memory
      limits:
        cpu: "500m"          # Max CPU — hitting this causes throttling
        memory: "512Mi"      # Max memory — exceeding this causes OOMKilled
        # OOMKilled occurs when: traffic spike causes memory usage > 512Mi
        # Fix: Increase memory limit or profile for memory leaks
        # Debug: kubectl describe pod <name> | grep -i "OOM\|killed"
    
    livenessProbe:           # If this fails → container restarted
      httpGet:
        path: /health
        port: 8080
      initialDelaySeconds: 30
      periodSeconds: 10
      # CrashLoopBackOff occurs when:
      # - App fails to start, liveness probe fails repeatedly
      # - Fix: kubectl logs <pod> --previous
    
    readinessProbe:          # If this fails → pod removed from Service endpoints
      httpGet:
        path: /ready
        port: 8080
      initialDelaySeconds: 10
      periodSeconds: 5
    
    env:
    - name: APP_ENV
      value: "production"
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: app-secrets
          key: db-password
    
    volumeMounts:
    - name: app-config
      mountPath: /etc/app
      readOnly: true
  
  volumes:
  - name: app-config
    configMap:
      name: webapp-config
  
  restartPolicy: Always      # Always | OnFailure | Never
  
  # Graceful shutdown
  terminationGracePeriodSeconds: 30
```

### Real-World Production Scenario

**Application:** Stateless Node.js microservice  
**Problem:** Pod intermittently enters `CrashLoopBackOff`

```bash
# Step 1: Check pod status
kubectl get pods
# webapp-pod   0/1   CrashLoopBackOff   5   3m

# Step 2: Get logs from current container
kubectl logs webapp-pod

# Step 3: Get logs from PREVIOUS (crashed) container
kubectl logs webapp-pod --previous
# Output: "Error: Cannot connect to database: timeout"

# Step 4: Check events
kubectl describe pod webapp-pod | tail -20
# Event: "Back-off restarting failed container"

# Step 5: Check if DB service is reachable from pod
kubectl exec -it webapp-pod -- curl http://db-service:5432

# Root cause: Database connection string in env variable is wrong
# Fix: Update ConfigMap/Secret with correct DB endpoint
```

### Debugging & Troubleshooting

```bash
# Comprehensive pod debugging workflow

# 1. Initial state check
kubectl get pods -n <namespace>

# 2. Describe for events and conditions
kubectl describe pod <pod-name> -n <namespace>

# 3. Live logs
kubectl logs <pod-name> -n <namespace> -f

# 4. Previous container logs (after crash)
kubectl logs <pod-name> -n <namespace> --previous

# 5. Exec into running container
kubectl exec -it <pod-name> -n <namespace> -- /bin/sh

# 6. Resource usage
kubectl top pod <pod-name> -n <namespace>

# 7. Copy files from/to pod
kubectl cp <pod-name>:/var/log/app.log ./app.log
```

### CKA Exam Tips
- `kubectl run` creates a Pod, NOT a Deployment (since K8s 1.18)
- `kubectl run nginx --image=nginx --dry-run=client -o yaml` generates YAML without creating
- Pod `Pending` = scheduling issue (node resources, taints, affinity)
- Pod `CrashLoopBackOff` = check `kubectl logs <pod> --previous`
- `kubectl explain pod.spec.containers` for quick field reference in exam

### Production Best Practices
- Always set resource requests AND limits
- Always define liveness AND readiness probes
- Use namespaces to isolate environments
- Never run containers as root (use `securityContext.runAsNonRoot: true`)
- Use labels consistently for all pods (for selection, monitoring, network policies)

---

### 🔎 Summary — Pods

- **Pod** = Smallest K8s unit; wraps 1+ containers sharing network and storage
- Single IP per pod; containers in same pod communicate via `localhost`
- Key states: `Pending`, `Running`, `CrashLoopBackOff`, `OOMKilled`, `ImagePullBackOff`
- Always define **resource requests** (for scheduling) and **limits** (for safety)
- **Probes**: liveness (restart on failure), readiness (remove from LB on failure)
- **Interview Answer:** "A Pod is the atomic unit of deployment in Kubernetes. It provides a shared execution environment for one or more containers — same network namespace, same volumes, same lifecycle."
- **Production Takeaway:** Pods are ephemeral. Never connect directly to pod IPs in production. Always use Services. Resource limits prevent one pod from starving others.

---

## 11. Pods with YAML

### Understanding YAML Structure

Every Kubernetes resource file has exactly 4 mandatory top-level fields:

```yaml
apiVersion: <version>   # Which API version to use
kind: <type>            # What kind of resource
metadata:               # Identifying information
  name:
  namespace:
  labels:
spec:                   # Resource-specific configuration
```

### API Version Reference

| Kind | apiVersion |
|---|---|
| Pod | v1 |
| Service | v1 |
| ReplicationController | v1 |
| Namespace | v1 |
| ConfigMap | v1 |
| Secret | v1 |
| ReplicaSet | apps/v1 |
| Deployment | apps/v1 |
| DaemonSet | apps/v1 |
| StatefulSet | apps/v1 |
| HorizontalPodAutoscaler | autoscaling/v2 |
| Ingress | networking.k8s.io/v1 |

### Complete Pod YAML Workflow

```bash
# Method 1: Write YAML manually and apply
vim pod.yaml
kubectl apply -f pod.yaml

# Method 2: Generate YAML with dry-run (exam trick)
kubectl run nginx --image=nginx --dry-run=client -o yaml > nginx-pod.yaml
vim nginx-pod.yaml   # Customize as needed
kubectl apply -f nginx-pod.yaml

# Method 3: Export existing resource to YAML
kubectl get pod nginx -o yaml > existing-pod.yaml
```

### Quick Commands Reference

```bash
# Create
kubectl create -f pod-definition.yaml
kubectl apply -f pod-definition.yaml  # create or update

# Read
kubectl get pods
kubectl get pods -o wide           # with IP and node
kubectl get pods -o yaml           # full YAML output
kubectl describe pod myapp-pod     # human-readable detail

# Delete
kubectl delete pod myapp-pod
kubectl delete -f pod-definition.yaml

# Generate template
kubectl run <name> --image=<image> --dry-run=client -o yaml
```

### CKA Exam Tips
- Use `--dry-run=client -o yaml` to generate templates — don't write from scratch
- `kubectl explain <resource>.<field>` for documentation in the exam
- `kubectl explain pod.spec.containers.resources` is very useful
- Practice tabbing through YAML (2-space indentation is standard)
- Know the 4 mandatory fields by heart: `apiVersion`, `kind`, `metadata`, `spec`

---

### 🔎 Summary — Pods with YAML

- YAML is the **declarative language** of Kubernetes
- 4 mandatory fields: `apiVersion`, `kind`, `metadata`, `spec`
- Use `--dry-run=client -o yaml` to generate valid YAML quickly
- `kubectl apply` is idempotent; use it for both create and update
- Store all YAML files in version control for team collaboration
- **Production Takeaway:** Never manage production resources imperatively. Always maintain YAML files in git. Use `kubectl diff -f file.yaml` before applying changes to see what will change.

---

## 12. ReplicaSets

### What Is It?
A **ReplicaSet** ensures that a specified number of pod replicas are running at all times. If a pod dies, the ReplicaSet creates a replacement. It is the successor to the older ReplicationController.

### ReplicaSet vs ReplicationController

| Feature | ReplicationController | ReplicaSet |
|---|---|---|
| API Version | v1 | apps/v1 |
| Label Selector | Equality only | Equality + Set-based |
| Used Directly? | Legacy (avoid) | Yes, but prefer Deployments |
| Supports matchExpressions? | No | Yes |

### How ReplicaSet Works

```
Desired state: replicas=3
Current state: 2 pods running (1 died)

ReplicaSet Controller loop:
[1] Watch API Server for pod changes
[2] Count pods matching selector: label app=myapp
[3] 2 running < 3 desired → CREATE 1 new pod
[4] New pod created → 3 running = 3 desired ✓
```

### The Role of Labels and Selectors

The ReplicaSet uses a **label selector** to identify which pods it manages. This is critical:
- Pods created BEFORE the ReplicaSet exist → if they match the selector, ReplicaSet adopts them
- If ReplicaSet creates pods, those pods carry matching labels

```
scenario: 3 pods already running with label "app=frontend"
          ReplicaSet created with selector "app=frontend" and replicas=3
Result:   ReplicaSet ADOPTS all 3 existing pods; creates 0 new pods
```

### Complete ReplicaSet YAML

```yaml
# replicaset-production.yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: webapp-rs
  namespace: production
  labels:
    app: webapp                # Label FOR the RS itself (not for pod selection)
    tier: frontend
spec:
  replicas: 3                  # Desired number of pods
  
  selector:                    # Which pods this RS manages
    matchLabels:
      app: webapp              # Must match template.metadata.labels
    # matchExpressions:        # Advanced: Set-based selector
    # - key: app
    #   operator: In
    #   values: ["webapp", "webapp-v2"]
  
  template:                    # Blueprint for new pods
    metadata:
      labels:
        app: webapp            # MUST match selector.matchLabels
        tier: frontend
        version: "1.0"
    spec:
      containers:
      - name: webapp
        image: myregistry/webapp:1.0
        resources:
          requests:
            cpu: "100m"
            memory: "128Mi"
          limits:
            cpu: "200m"
            memory: "256Mi"
        ports:
        - containerPort: 8080
```

### Scaling a ReplicaSet

```bash
# Method 1: Edit the YAML file and apply
# Change replicas: 3 → replicas: 6
kubectl apply -f replicaset-production.yaml

# Method 2: kubectl scale (doesn't update file)
kubectl scale replicaset webapp-rs --replicas=6

# Method 3: kubectl edit (live edit)
kubectl edit replicaset webapp-rs

# Verify
kubectl get replicaset webapp-rs
# NAME        DESIRED   CURRENT   READY
# webapp-rs   6         6         6
```

### ReplicaSet Commands Summary

```bash
kubectl create -f replicaset.yaml
kubectl get replicaset                         # or: kubectl get rs
kubectl describe replicaset webapp-rs
kubectl delete replicaset webapp-rs            # deletes RS and all its pods
kubectl replace -f replicaset.yaml             # update RS from file
kubectl scale --replicas=6 -f replicaset.yaml  # scale from file
kubectl scale --replicas=6 rs webapp-rs        # scale by name
```

### CKA Exam Tips
- ReplicaSet does NOT support rolling updates — use Deployments for that
- The `template` section's labels MUST match the `selector`
- ReplicaSet is what Deployments create and manage internally
- `kubectl get rs` is the shorthand
- If pods exist with matching labels before RS creation, RS adopts them (no new pods created if count matches)

### Production Best Practices
- **Don't use ReplicaSets directly** — use Deployments (they manage RS for you)
- ReplicaSets are useful to understand for debugging Deployments
- Monitor replica count vs. desired count with `kube_replicaset_status_replicas`

---

### 🔎 Summary — ReplicaSets

- **ReplicaSet** = Ensures N pods with matching labels are always running
- Uses label selectors to identify managed pods
- Can adopt existing pods if labels match
- Supports set-based selectors (unlike old ReplicationController)
- **Don't use directly in production** — use Deployments which manage ReplicaSets
- **Production Takeaway:** ReplicaSets are the self-healing mechanism for pods. But in practice, you'll interact with them through Deployments. Understanding RS is key to debugging failed rollouts.

---

## 13. Deployments

### What Is It?
A **Deployment** is a higher-level abstraction over ReplicaSets. It provides:
- **Rolling updates** (update pods gradually without downtime)
- **Rollbacks** (revert to previous version)
- **Pause/Resume** (batch multiple changes together)
- **Version history** (track what changed and when)

### Deployment → ReplicaSet → Pod Hierarchy

```
Deployment (myapp-deployment)
    └── ReplicaSet (myapp-deployment-abc123)      ← current version
            ├── Pod (myapp-deployment-abc123-xyz1)
            ├── Pod (myapp-deployment-abc123-xyz2)
            └── Pod (myapp-deployment-abc123-xyz3)
    └── ReplicaSet (myapp-deployment-def456)      ← old version (scaled to 0)
```

When you update an image, a NEW ReplicaSet is created and the old one is scaled down.

### Complete Deployment YAML

```yaml
# deployment-production.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp-deployment
  namespace: production
  labels:
    app: webapp
    version: "2.0"
  annotations:
    kubernetes.io/change-cause: "Update to webapp v2.0"  # Shown in rollout history
spec:
  replicas: 3
  
  selector:
    matchLabels:
      app: webapp
  
  strategy:
    type: RollingUpdate          # RollingUpdate (default) or Recreate
    rollingUpdate:
      maxUnavailable: 1          # Max pods unavailable during update (or %)
      maxSurge: 1                # Max pods over desired count during update
      # maxUnavailable: 25%      # Percentage-based (common in production)
      # maxSurge: 25%
  
  minReadySeconds: 10            # Wait 10s after pod is ready before moving on
  progressDeadlineSeconds: 600   # Fail rollout if not done within 600s
  revisionHistoryLimit: 10       # Keep 10 RS revisions for rollback
  
  template:
    metadata:
      labels:
        app: webapp
        version: "2.0"
    spec:
      containers:
      - name: webapp
        image: myregistry/webapp:2.0
        
        resources:
          requests:
            cpu: "250m"
            memory: "256Mi"
          limits:
            cpu: "500m"          # CPU throttling if burst exceeds 500m
            memory: "512Mi"      # OOMKilled if exceeds 512Mi
        
        readinessProbe:          # Critical for safe rolling updates
          httpGet:
            path: /ready
            port: 8080
          initialDelaySeconds: 15
          periodSeconds: 5
          failureThreshold: 3
        
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
```

### Rolling Update Deep Dive

```
Initial state: 3 pods running v1.0 (RS1)

Update to v2.0 triggered:

Step 1: Create RS2 with v2.0 template, scale RS2 to 1
        RS1: [pod1-v1, pod2-v1, pod3-v1]
        RS2: [pod4-v2] ← starting

Step 2: pod4-v2 passes readiness → RS1 scaled down by 1
        RS1: [pod1-v1, pod2-v1]
        RS2: [pod4-v2]

Step 3: RS2 scales to 2, RS1 scales to 1
        RS1: [pod1-v1]
        RS2: [pod4-v2, pod5-v2]

Step 4: RS2 scales to 3, RS1 scales to 0
        RS1: []
        RS2: [pod4-v2, pod5-v2, pod6-v2] ← COMPLETE

Throughout: Application always has 2-3 pods serving traffic
```

### Deployment Commands

```bash
# Create
kubectl apply -f deployment.yaml

# Update image
kubectl set image deployment/webapp-deployment webapp=myregistry/webapp:2.1

# Check rollout status
kubectl rollout status deployment/webapp-deployment

# View history
kubectl rollout history deployment/webapp-deployment
# REVISION  CHANGE-CAUSE
# 1         Initial deployment v1.0
# 2         Update to webapp v2.0
# 3         Update to webapp v2.1

# Rollback to previous
kubectl rollout undo deployment/webapp-deployment

# Rollback to specific revision
kubectl rollout undo deployment/webapp-deployment --to-revision=1

# Pause rollout (for batching multiple changes)
kubectl rollout pause deployment/webapp-deployment
kubectl set image deployment/webapp-deployment webapp=myregistry/webapp:2.2
kubectl set resources deployment/webapp-deployment -c webapp --limits=cpu=1
kubectl rollout resume deployment/webapp-deployment

# Scale
kubectl scale deployment webapp-deployment --replicas=10
```

### Recreate vs RollingUpdate

```
Recreate Strategy:
- Scale down ALL old pods to 0
- Scale up ALL new pods to desired
- Results in DOWNTIME
- Use case: Major breaking changes, DB migrations requiring downtime

RollingUpdate Strategy (default):
- Gradually replace old pods with new
- Configurable maxUnavailable and maxSurge
- Zero downtime (if readiness probes properly configured)
- Use case: Most production updates
```

### Real-World Production Scenario

**Application:** Microservices e-commerce platform, 50 replicas of checkout service

**Rolling Update Strategy:**
- `maxUnavailable: 10%` (5 pods max unavailable)
- `maxSurge: 10%` (5 extra pods during update)
- `minReadySeconds: 30` (30s after ready before advancing)

**Failure Handling:**  
Deployment stuck at 60% — new pods failing readiness probe:
```bash
# Check rollout status
kubectl rollout status deployment/checkout
# Waiting for deployment "checkout" rollout to finish: 25 out of 50 new replicas have been updated...

# Get logs from failing new pod
kubectl logs checkout-deployment-newrs-xyz --previous

# Immediate rollback
kubectl rollout undo deployment/checkout
# deployment.apps/checkout rolled back

# Verify
kubectl rollout status deployment/checkout
# deployment "checkout" successfully rolled out
```

### CKA Exam Tips
- Deployment uses `RollingUpdate` strategy by default
- `kubectl rollout undo` reverts to previous ReplicaSet
- `kubectl rollout history` shows revisions (set `--record` or annotation for CHANGE-CAUSE)
- Deployment creates ReplicaSets; ReplicaSets create Pods
- `kubectl get all` shows Deployment + RS + Pods together

### Production Best Practices
- Always define readiness probes — they control rolling update progression
- Use `minReadySeconds` to ensure traffic is actually flowing before proceeding
- Set `revisionHistoryLimit` to control RS retention
- Use `progressDeadlineSeconds` to auto-fail stuck rollouts
- Tag images with versions, never use `latest` in production

---

### 🔎 Summary — Deployments

- **Deployment** = Production-grade Pod manager with rollout/rollback
- Creates and manages **ReplicaSets** which create/manage **Pods**
- `RollingUpdate` = default; replaces pods gradually, zero downtime
- `Recreate` = all pods down at once; causes downtime
- Rollback via `kubectl rollout undo` — restores previous ReplicaSet
- **Always define readiness probes** — they gate rolling update progression
- **Interview Answer:** "A Deployment manages ReplicaSets which manage Pods. It provides declarative rollout/rollback capabilities and ensures application availability during updates by controlling maxUnavailable and maxSurge parameters."
- **Production Takeaway:** Deployments are the primary workload resource for stateless applications. Version control your Deployment YAML. Use annotations for change-cause tracking.

---

## 14. Services — NodePort

### What Is It?
A **Service** is a stable networking abstraction that provides a consistent endpoint to access a group of pods. Services solve the problem of pod IP instability — pod IPs change when pods restart, but Service IPs remain constant.

**NodePort** specifically maps a high-numbered port on every cluster node (30000–32767) to a service, making it accessible from outside the cluster.

### NodePort Port Mapping

```
External User Browser
        ↓
Node IP: 192.168.1.2 : 30008  (NodePort — external access point)
        ↓
Service ClusterIP: 10.96.100.50 : 80  (internal service port)
        ↓
Pod IP: 10.244.0.2 : 8080  (targetPort — actual container port)
```

Three ports in a NodePort service:
- **nodePort** (30000–32767): Port on the node; external entry point
- **port** (80): Port on the Service object itself
- **targetPort** (8080): Port the container is listening on

### NodePort Service YAML

```yaml
# service-nodeport.yaml
apiVersion: v1
kind: Service
metadata:
  name: webapp-service
  namespace: production
  labels:
    app: webapp
spec:
  type: NodePort
  
  selector:
    app: webapp        # Routes to pods with this label
    tier: frontend     # Multiple selectors = AND condition
  
  ports:
  - name: http
    protocol: TCP
    port: 80           # Service port (ClusterIP:80)
    targetPort: 8080   # Pod/container port
    nodePort: 30080    # External port on node (30000-32767)
                       # If omitted, Kubernetes auto-assigns
  
  # sessionAffinity: ClientIP  # Sticky sessions (optional)
  # sessionAffinityConfig:
  #   clientIP:
  #     timeoutSeconds: 10800
```

### How NodePort Works Across Multiple Pods

```
Service selector: app=webapp

Pods:
- webapp-pod-1: 10.244.1.2 (Node 1)
- webapp-pod-2: 10.244.1.3 (Node 1)
- webapp-pod-3: 10.244.2.2 (Node 2)

NodePort 30080 mapped on ALL nodes
kube-proxy load balances traffic round-robin across all 3 pods

curl http://192.168.1.1:30080 → routes to any of 3 pods
curl http://192.168.1.2:30080 → routes to any of 3 pods
```

### Debugging & Troubleshooting

```bash
# Create service
kubectl apply -f service-nodeport.yaml

# Verify service
kubectl get services
# NAME            TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)
# webapp-service  NodePort   10.96.100.50   <none>        80:30080/TCP

# Check endpoints (pods selected by service)
kubectl get endpoints webapp-service
# If endpoints empty: selector doesn't match any pod labels

# Describe service
kubectl describe service webapp-service

# Test connectivity
curl http://<node-ip>:30080
```

### CKA Exam Tips
- NodePort range: **30000–32767**
- If `nodePort` omitted → auto-assigned in range
- If `targetPort` omitted → defaults to same as `port`
- Service type: `NodePort` (capital N and P)
- NodePort maps the port on ALL nodes, not just one

---

### 🔎 Summary — Services (NodePort)

- **Service** = Stable network endpoint for pods
- **NodePort** = Exposes service on a static port on every node
- Three ports: nodePort (external) → port (service) → targetPort (container)
- kube-proxy creates iptables rules to enable routing
- Best for: dev/test, on-premise without cloud LB, direct node access
- **Production Takeaway:** NodePort is rarely used directly in production (prefer LoadBalancer or Ingress). However, understanding it is foundational to understanding how Kubernetes networking works.

---

## 15. Services — ClusterIP

### What Is It?
**ClusterIP** is the default Service type. It creates a **virtual IP** accessible only within the cluster. It's used for internal pod-to-pod communication in microservices architectures.

### When to Use ClusterIP

```
Microservices Communication:
frontend → [ClusterIP Service] → backend
backend  → [ClusterIP Service] → database
database → [ClusterIP Service] → redis-cache

Each service provides stable, load-balanced access to a group of pods
No external access needed — purely internal communication
```

### ClusterIP Service YAML

```yaml
# service-clusterip.yaml
apiVersion: v1
kind: Service
metadata:
  name: backend-service
  namespace: production
spec:
  type: ClusterIP        # Default; can omit "type" field entirely
  
  selector:
    app: backend
    tier: api
  
  ports:
  - name: http
    port: 80             # Port other pods connect to
    targetPort: 3000     # Port the backend container listens on
  - name: metrics
    port: 9090           # Metrics endpoint for Prometheus scraping
    targetPort: 9090
```

### DNS Resolution for Services

Kubernetes CoreDNS automatically creates DNS entries for services:

```
Full DNS format: <service-name>.<namespace>.svc.cluster.local
Example:         backend-service.production.svc.cluster.local

Short forms (within same namespace): 
                 backend-service
                 backend-service.production
```

```bash
# Test DNS resolution from within a pod
kubectl exec -it frontend-pod -n production -- \
  nslookup backend-service.production.svc.cluster.local

# Connect to backend service from frontend
kubectl exec -it frontend-pod -- curl http://backend-service/api/health
```

### Real-World Production Scenario

**Microservices Setup:**
```
  [Browser]
      ↓
[Ingress Controller]
      ↓
[ClusterIP: frontend-service:80]  → [Frontend pods]
      ↓ (via env var)
[ClusterIP: backend-service:8080] → [Backend pods]
      ↓ (via env var)
[ClusterIP: db-service:5432]      → [PostgreSQL pods]
      ↓
[ClusterIP: redis-service:6379]   → [Redis pods]
```

Each tier communicates with the next via ClusterIP service names — pod IPs are irrelevant.

### Production Best Practices
- Use ClusterIP for all internal microservice communication
- Set `app.kubernetes.io/name` labels for service mesh (Istio/Linkerd) compatibility
- Configure `sessionAffinity: ClientIP` when stateful HTTP sessions are needed

---

### 🔎 Summary — Services (ClusterIP)

- **ClusterIP** = Internal-only virtual IP for pod-to-pod communication
- Default Service type — omitting `type` creates a ClusterIP service
- DNS name auto-created: `<service>.<namespace>.svc.cluster.local`
- kube-proxy load balances traffic across all healthy pods in selector
- **Production Takeaway:** ClusterIP is the backbone of microservices in Kubernetes. Every microservice should have a ClusterIP service. Never hardcode pod IPs — always use service DNS names.

---

## 16. Services — LoadBalancer

### What Is It?
**LoadBalancer** extends NodePort by additionally provisioning an **external cloud load balancer** (AWS ELB, GCP Load Balancer, Azure LB). It provides a single external IP/DNS name that routes to the cluster.

### LoadBalancer vs NodePort

```
NodePort: External User → Node1:30080 OR Node2:30080 OR Node3:30080
          User must know which node IP to use

LoadBalancer: External User → 34.100.50.10:80 (single stable external IP)
              Cloud LB distributes to all nodes → kube-proxy routes to pods
```

### Service Type Hierarchy

```
ClusterIP (internal only)
    └── NodePort (adds external node port)
            └── LoadBalancer (adds cloud LB in front of NodePort)
```

### LoadBalancer Service YAML

```yaml
# service-loadbalancer.yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend-lb-service
  namespace: production
  annotations:
    # AWS-specific annotations
    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
    service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: "true"
spec:
  type: LoadBalancer
  
  selector:
    app: frontend
  
  ports:
  - name: http
    port: 80
    targetPort: 8080
  - name: https
    port: 443
    targetPort: 8443
  
  loadBalancerSourceRanges:   # Restrict access by IP range
  - "10.0.0.0/8"
  - "203.0.113.0/24"
```

### When LoadBalancer Is Not Available

On bare metal or VirtualBox environments, LoadBalancer type falls back to NodePort behavior — no external IP is provisioned:

```bash
kubectl get service frontend-lb-service
# NAME                  TYPE           CLUSTER-IP    EXTERNAL-IP
# frontend-lb-service   LoadBalancer   10.96.100.50  <pending>
#                                                     ↑ stuck pending on bare metal
```

**Solutions for bare metal:**
- **MetalLB**: Software load balancer for bare metal clusters
- **Ingress Controller**: More powerful alternative (single LB for multiple services)

### Production Best Practices
- **Prefer Ingress over LoadBalancer** for HTTP/HTTPS traffic — one LB can serve many services
- Use LoadBalancer for non-HTTP protocols (TCP/UDP)
- Configure `loadBalancerSourceRanges` for security
- Use cloud-specific annotations for advanced LB configuration (health check paths, timeouts)

---

### 🔎 Summary — Services (LoadBalancer)

- **LoadBalancer** = NodePort + external cloud load balancer
- Provisions real cloud LB (AWS ELB, GCP LB, Azure LB) automatically
- On bare metal: falls back to NodePort behavior (`<pending>` external IP)
- Best for: production cloud deployments with external traffic
- **Production Takeaway:** For HTTP/HTTPS traffic, use Ingress (more efficient, one LB for many services). Use LoadBalancer type for TCP/UDP protocols or when Ingress is insufficient.

---

## 17. Namespaces

### What Is It?
**Namespaces** are virtual clusters within a Kubernetes cluster. They partition resources into separate groups for isolation, organization, and multi-tenancy.

### Default Namespaces

| Namespace | Purpose |
|---|---|
| `default` | Where resources go if no namespace specified |
| `kube-system` | Kubernetes control plane components (apiserver, scheduler, coredns) |
| `kube-public` | Publicly readable, used for cluster-info |
| `kube-node-lease` | Node heartbeat lease objects |

### Namespace Use Cases

```
Development team setup:
├── namespace: dev       ← Development environment
├── namespace: staging   ← Staging/QA environment
├── namespace: prod      ← Production environment
└── namespace: monitoring ← Prometheus, Grafana, etc.

Benefits:
- Resource isolation (quotas per namespace)
- Access control (RBAC per namespace)
- Network policies per namespace
- Independent lifecycle management
```

### Cross-Namespace Communication

Pods in different namespaces can communicate, but must use the **fully qualified DNS name**:

```bash
# Same namespace: short name works
mysql.connect("db-service")

# Different namespace: must use full DNS name
mysql.connect("db-service.dev.svc.cluster.local")

# Format: <service>.<namespace>.svc.cluster.local
```

### Namespace Management Commands

```bash
# List all namespaces
kubectl get namespaces    # or: kubectl get ns

# Create namespace
kubectl create namespace development    # imperative
kubectl apply -f namespace.yaml         # declarative

# Work in a specific namespace
kubectl get pods -n kube-system
kubectl get pods --namespace=monitoring

# Set default namespace for context
kubectl config set-context --current --namespace=production

# List resources across ALL namespaces
kubectl get pods --all-namespaces
kubectl get pods -A                    # shorthand
```

### Namespace YAML

```yaml
# namespace-production.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    environment: production
    team: platform
```

### Resource Quotas

```yaml
# resource-quota.yaml — Limit resources per namespace
apiVersion: v1
kind: ResourceQuota
metadata:
  name: production-quota
  namespace: production
spec:
  hard:
    pods: "50"                    # Max pods in namespace
    requests.cpu: "20"            # Total CPU requests
    requests.memory: "40Gi"       # Total memory requests
    limits.cpu: "40"              # Total CPU limits
    limits.memory: "80Gi"         # Total memory limits
    persistentvolumeclaims: "10"  # Max PVCs
    services.loadbalancers: "2"   # Max LoadBalancer services
```

### LimitRange (Default Resource Limits)

```yaml
# limitrange.yaml — Set default limits for pods in namespace
apiVersion: v1
kind: LimitRange
metadata:
  name: default-limits
  namespace: development
spec:
  limits:
  - type: Container
    default:
      cpu: "500m"
      memory: "256Mi"
    defaultRequest:
      cpu: "100m"
      memory: "128Mi"
    max:
      cpu: "2"
      memory: "2Gi"
    min:
      cpu: "50m"
      memory: "64Mi"
```

### Real-World Production Scenario

**Setup:** Single cluster for dev, staging, prod environments

**Namespace Strategy:**
```
production namespace:
├── ResourceQuota: max 100 pods, 50 CPU, 100Gi memory
├── RBAC: only SRE team can deploy
├── NetworkPolicy: only ingress from ingress-controller namespace
└── LimitRange: default 250m CPU, 256Mi memory per container

development namespace:
├── ResourceQuota: max 20 pods, 10 CPU, 20Gi memory
├── RBAC: all developers can deploy
└── LimitRange: default 100m CPU, 128Mi memory per container
```

### CKA Exam Tips
- `kubectl config set-context --current --namespace=<ns>` changes working namespace
- Without specifying namespace, commands default to `default` namespace
- Namespace-scoped vs cluster-scoped resources: Pods/Deployments/Services are namespaced; Nodes/PVs/ClusterRoles are NOT
- Full DNS: `<service>.<namespace>.svc.cluster.local`
- `-n` flag sets namespace for a single command; context sets it persistently

---

### 🔎 Summary — Namespaces

- **Namespaces** = Virtual clusters for isolation and organization
- Default namespaces: `default`, `kube-system`, `kube-public`, `kube-node-lease`
- Same namespace: use short service name; different namespace: use full DNS
- ResourceQuota limits resource consumption per namespace
- LimitRange sets default resource requests/limits for pods in namespace
- **Production Takeaway:** Always use namespaces to separate environments (dev/staging/prod). Apply ResourceQuotas and RBAC per namespace for proper multi-tenancy.

---

## 18. Imperative vs Declarative

### What Is It?
Two fundamentally different approaches to managing Kubernetes resources:

- **Imperative**: You specify the exact steps to achieve the desired state
- **Declarative**: You specify the desired state and Kubernetes figures out how to get there

### The Analogy

```
Imperative (taxi with directions):
"Turn right on Street B, left on Street C, stop at house 45"
— You manage EVERY step

Declarative (Uber):
"Take me to Tom's house at 123 Main St"
— You state WHAT you want; system handles HOW
```

### Imperative Commands

```bash
# Create resources
kubectl run nginx --image=nginx
kubectl create deployment nginx --image=nginx --replicas=3
kubectl expose deployment nginx --port=80 --type=NodePort
kubectl create configmap app-config --from-literal=DB_HOST=mysql

# Modify resources
kubectl edit deployment nginx
kubectl scale deployment nginx --replicas=5
kubectl set image deployment nginx nginx=nginx:1.18
kubectl label pod nginx env=prod

# Delete resources
kubectl delete pod nginx
kubectl delete deployment nginx
kubectl delete -f nginx.yaml

# When to use: Quick tests, one-off operations, CKA exam speed tasks
```

### Declarative Approach

```bash
# Apply configuration (create OR update)
kubectl apply -f nginx.yaml
kubectl apply -f ./directory/          # Apply all YAML files in directory
kubectl apply -f https://url/file.yaml # Apply from URL

# The key difference: kubectl apply handles both create AND update
# If object doesn't exist → creates it
# If object exists → updates only changed fields
```

### The kubectl apply Three-Way Merge

```
kubectl apply compares THREE sources:
1. Local YAML file (your intent)
2. Live object in cluster (current state)
3. Last-applied annotation (what you last applied)

If field in last-applied but NOT in local file → DELETE it from cluster
If field in local file differs from cluster → UPDATE it
If field only in cluster (added by other means) → KEEP it
```

### When to Use Which

| Scenario | Approach | Example |
|---|---|---|
| Quick debug/test | Imperative | `kubectl run test-pod --image=busybox` |
| Creating one-off objects | Imperative | `kubectl create configmap` |
| Production deployments | Declarative | `kubectl apply -f prod/` |
| Team environments | Declarative | Git-managed YAML files |
| CKA exam (speed) | Mixed | Imperative for creation, declarative for complex objects |

### CKA Exam Strategy

```bash
# FAST object creation (imperative)
kubectl run pod1 --image=nginx                                    # Create pod
kubectl run pod1 --image=nginx --dry-run=client -o yaml > p.yaml # Generate YAML
kubectl create deployment dep1 --image=nginx --replicas=3
kubectl expose pod nginx --port=80 --name=nginx-svc --type=ClusterIP
kubectl create serviceaccount my-sa
kubectl create secret generic my-secret --from-literal=key=val
kubectl create configmap my-cm --from-literal=key=val

# Generate + customize (hybrid approach — most efficient for exam)
kubectl create deployment nginx --image=nginx --dry-run=client -o yaml > dep.yaml
# Edit dep.yaml for any special fields
kubectl apply -f dep.yaml
```

---

### 🔎 Summary — Imperative vs Declarative

- **Imperative** = Step-by-step commands; great for speed, bad for tracking
- **Declarative** = State-based YAML; great for tracking, team collaboration, GitOps
- `kubectl apply` is the declarative command; handles create + update intelligently
- In production: **ALWAYS use declarative** with YAML files in version control
- In CKA exam: use **imperative for speed**, then customize YAML for complex requirements
- **Production Takeaway:** Treat your Kubernetes YAML like application code. Store it in git, review changes, use CI/CD pipelines to apply. Never apply production changes imperatively without documentation.

---

## 19. Kubectl Apply Command

### How kubectl apply Works Internally

`kubectl apply` performs a **three-way merge** to calculate what changes need to be made:

```
Source 1: Your LOCAL yaml file (what you want)
Source 2: LIVE cluster state (what currently exists)  
Source 3: Last-applied annotation (what you last applied)

Merge logic:
- Field in local + different from live → UPDATE live
- Field in last-applied but NOT in local → DELETE from live
- Field only in live (not in local or last-applied) → KEEP (added by other tools)
```

### The last-applied-configuration Annotation

```bash
# After first kubectl apply, annotation is set on object:
kubectl get pod nginx -o yaml | grep last-applied-configuration

# Shows stored JSON of what was last applied
# Stored as: kubectl.kubernetes.io/last-applied-configuration
```

```yaml
# Example live object with annotation
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Pod","metadata":{"labels":
      {"app":"nginx"},"name":"nginx"},"spec":{"containers":
      [{"image":"nginx:1.18","name":"nginx"}]}}
```

### Practical kubectl apply Behavior

```bash
# First apply: Object doesn't exist → CREATED
kubectl apply -f nginx.yaml
# Output: pod/nginx created

# Second apply, no changes: Object unchanged → unchanged
kubectl apply -f nginx.yaml  
# Output: pod/nginx unchanged

# Third apply, image changed: Object changed → CONFIGURED
# Changed nginx:1.18 to nginx:1.19 in yaml
kubectl apply -f nginx.yaml
# Output: pod/nginx configured

# Preview changes before applying
kubectl diff -f nginx.yaml
# Shows what WILL change without applying
```

### Warning: Mixing Imperative and Declarative

```bash
# DANGER: Creating with kubectl create then applying
kubectl create -f nginx.yaml
# → Object created WITHOUT last-applied annotation

kubectl apply -f nginx.yaml
# → Creates annotation, but warns about missing annotation on initial create

# BEST PRACTICE: Always use apply consistently
kubectl apply -f nginx.yaml  # Use this for EVERYTHING
```

---

### 🔎 Summary — Kubectl Apply

- `kubectl apply` = declarative create OR update based on YAML
- Uses three-way merge: local file + live state + last-applied annotation
- `last-applied-configuration` annotation tracks what was previously applied
- Fields removed from local YAML are deleted from live object on next apply
- `kubectl diff -f` = preview changes before applying
- **Production Takeaway:** Use `kubectl apply` as your standard deployment command. Combine with `kubectl diff` in CI/CD pipelines to review changes before applying to production.

---

# Part II — Scheduling

---

## 20. Manual Scheduling

### What Is It?
By default, the Kubernetes scheduler automatically assigns pods to nodes. **Manual scheduling** allows you to bypass the scheduler by directly specifying the target node in the pod definition using the `nodeName` field.

### When to Use Manual Scheduling
- Emergency situations where scheduler is unavailable
- Specific hardware requirements (GPU nodes, dedicated hardware)
- Debugging scheduling issues
- Learning Kubernetes internals

### How It Works

```
Normal flow:
Pod created → nodeName="" → Scheduler detects → assigns nodeName → kubelet starts pod

Manual scheduling:
Pod created with nodeName="node02" → kubelet on node02 directly starts pod
(Scheduler is bypassed entirely)
```

### Manual Scheduling YAML

```yaml
# manual-schedule-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    name: nginx
spec:
  nodeName: node02         # Manual assignment — bypasses scheduler
                           # MUST be set at creation time
                           # Cannot be changed after pod is created
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 8080
```

```bash
# Create and verify
kubectl apply -f manual-schedule-pod.yaml
kubectl get pods -o wide
# NAME    READY   STATUS    NODE
# nginx   1/1     Running   node02  ← on specified node
```

### Reassigning Running Pods via Binding Object

You cannot change `nodeName` on a running pod. To reassign, use a binding object (mimics what the scheduler does):

```json
// binding.json
{
  "apiVersion": "v1",
  "kind": "Binding",
  "metadata": {
    "name": "nginx"
  },
  "target": {
    "apiVersion": "v1",
    "kind": "Node",
    "name": "node02"
  }
}
```

```bash
# Send binding request via API
curl --header "Content-Type: application/json" \
  --request POST \
  --data @binding.json \
  http://$SERVER/api/v1/namespaces/default/pods/nginx/binding
```

### Debugging: Pod Stuck in Pending (No Scheduler)

```bash
# If scheduler is down, pods remain Pending indefinitely
kubectl get pods
# NAME    READY   STATUS    RESTARTS   AGE
# nginx   0/1     Pending   0          2m   ← scheduler not running

# Check scheduler
kubectl get pods -n kube-system | grep scheduler
# (nothing) ← scheduler pod missing

# Quick fix: manually schedule by patching nodeName
kubectl patch pod nginx \
  -p '{"spec":{"nodeName":"node01"}}'
# This works ONLY on pods that haven't been scheduled yet
```

### CKA Exam Tips
- `nodeName` can ONLY be set at pod creation time
- Pod stuck in `Pending` → check if scheduler is running
- Binding object is how the scheduler internally assigns pods
- Manual scheduling bypasses ALL scheduling policies (taints, affinity, resources)

---

### 🔎 Summary — Manual Scheduling

- **Manual scheduling** = bypass scheduler by setting `nodeName` in pod spec
- `nodeName` must be set at creation — cannot be changed on running pod
- Binding object is the API mechanism for scheduler to assign pods
- Pod `Pending` without scheduler running → manually assign with binding
- **Production Takeaway:** Manual scheduling is an emergency tool. In production, rely on the scheduler with proper node affinity and taints/tolerations for node assignment control.

---

## 21. Labels and Selectors

### What Is It?
**Labels** are key-value pairs attached to Kubernetes objects for identification. **Selectors** are queries that filter objects based on their labels. Together, they form the primary mechanism for object grouping and targeting in Kubernetes.

### Labels Architecture

```
Labels are used by:
├── Services → to select which pods receive traffic
├── ReplicaSets/Deployments → to select which pods they manage
├── Network Policies → to select which pods the policy applies to
├── HPA → to select which pods to scale
├── kubectl → to filter resource listings
└── Monitoring tools → Prometheus service discovery
```

### Label Specification

```yaml
# Good label conventions
metadata:
  labels:
    # Kubernetes recommended labels
    app.kubernetes.io/name: webapp
    app.kubernetes.io/version: "2.1"
    app.kubernetes.io/component: frontend
    app.kubernetes.io/part-of: ecommerce
    app.kubernetes.io/managed-by: helm
    # Custom labels
    tier: frontend
    environment: production
    team: platform-eng
    cost-center: "1001"
```

### Selector Types

```yaml
# 1. Equality-based (simple matching)
selector:
  matchLabels:
    app: webapp          # app EQUALS webapp
    tier: frontend       # AND tier EQUALS frontend

# 2. Set-based (advanced matching)
selector:
  matchExpressions:
  - key: tier
    operator: In          # tier IN [frontend, gateway]
    values: [frontend, gateway]
  - key: env
    operator: NotIn       # env NOT IN [dev, test]
    values: [dev, test]
  - key: critical
    operator: Exists      # label "critical" must exist (any value)
  - key: deprecated
    operator: DoesNotExist # label "deprecated" must NOT exist
```

### Complete Example with Labels and Selectors

```yaml
# ReplicaSet using label selector
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: webapp-rs
  labels:
    app: webapp               # Labels on the RS itself
    managed-by: ops-team
spec:
  replicas: 3
  selector:
    matchLabels:              # Selects pods with these labels
      app: webapp
      tier: frontend
  template:
    metadata:
      labels:
        app: webapp           # Pod labels MUST match selector
        tier: frontend
        version: "2.1"
```

### Annotations vs Labels

```
Labels:
- Used for selection (Services, Deployments, etc.)
- Kept short and searchable
- Examples: app=nginx, env=prod, version=2.1

Annotations:
- Metadata NOT used for selection
- Can be longer, contain complex data
- Examples: buildVersion=abc123, changelog="Updated auth module", git-commit=abc123
```

```bash
# Filter pods by label
kubectl get pods -l app=webapp
kubectl get pods -l 'tier in (frontend,api)'
kubectl get pods -l 'env!=dev'
kubectl get pods -l 'critical'            # Exists
kubectl get pods -l '!deprecated'         # DoesNotExist

# Show labels in output
kubectl get pods --show-labels

# Add/update label
kubectl label pod nginx version=2.1
kubectl label pod nginx version=2.2 --overwrite

# Remove label
kubectl label pod nginx version-
```

### CKA Exam Tips
- `kubectl get pods -l app=nginx` — filter by label
- ReplicaSet/Deployment selector.matchLabels MUST match template.metadata.labels
- Services use `spec.selector` (not `spec.selector.matchLabels`)
- Labels ≠ Annotations (labels for selection, annotations for metadata)
- `kubectl get all -l app=webapp` shows all resources with that label

---

### 🔎 Summary — Labels and Selectors

- **Labels** = key-value tags on Kubernetes objects for identification and grouping
- **Selectors** = queries to find objects with specific labels
- Used by Services, Deployments, RS to target pods; by kubectl to filter
- Two selector types: `matchLabels` (equality) and `matchExpressions` (set-based)
- **Annotations** = similar to labels but not used for selection
- **Production Takeaway:** Consistent labeling strategy is critical. Adopt Kubernetes recommended label conventions (`app.kubernetes.io/name` etc.) from day one. They affect monitoring, cost allocation, RBAC scoping, and network policies.

---

## 22. Taints and Tolerations

### What Is It?
**Taints** are properties applied to nodes that **repel** pods. **Tolerations** are properties on pods that allow them to be scheduled on tainted nodes. Think of it as a node saying "only accept pods that can handle this condition."

### The Bug Repellent Analogy

```
Person with repellent = Tainted Node (repels bugs)
Bug without immunity = Regular Pod (can't land on this node)
Bug with immunity = Pod with Toleration (can land despite repellent)
```

### Taint Effects

| Effect | Behavior |
|---|---|
| `NoSchedule` | New pods without toleration will NOT be scheduled here |
| `PreferNoSchedule` | Scheduler tries to avoid this node but may schedule here as last resort |
| `NoExecute` | New pods won't be scheduled AND existing pods without toleration are evicted |

### Applying Taints to Nodes

```bash
# Add taint
kubectl taint nodes node1 app=blue:NoSchedule
kubectl taint nodes node2 maintenance=true:NoExecute
kubectl taint nodes gpu-node gpu=nvidia:NoSchedule

# Remove taint (note the trailing -)
kubectl taint nodes node1 app=blue:NoSchedule-

# View taints on a node
kubectl describe node node1 | grep Taint
```

### Pod with Toleration YAML

```yaml
# pod-with-toleration.yaml
apiVersion: v1
kind: Pod
metadata:
  name: blue-app
spec:
  tolerations:
  - key: "app"
    operator: "Equal"      # Equal | Exists
    value: "blue"
    effect: "NoSchedule"   # Must match the taint effect exactly
  
  # Another toleration example (using Exists)
  # - key: "gpu"
  #   operator: "Exists"   # Any value is tolerated
  #   effect: "NoSchedule"
  
  containers:
  - name: blue-app
    image: blue-app:1.0
```

### NoExecute Effect — Eviction Flow

```
Cluster state: node1 has no taints; pods A, B, C running on it

Admin applies: kubectl taint nodes node1 env=prod:NoExecute

Result:
- Pod A (no toleration): EVICTED immediately
- Pod B (no toleration): EVICTED immediately
- Pod C (has toleration for env=prod): REMAINS running

New scheduling:
- New pods without toleration: won't schedule on node1
- New pods with toleration: can schedule on node1
```

### Toleration with tolerationSeconds

```yaml
# Pod can tolerate the taint for 600 seconds before eviction
tolerations:
- key: "maintenance"
  operator: "Equal"
  value: "true"
  effect: "NoExecute"
  tolerationSeconds: 600    # After 600s, pod is evicted even with toleration
```

### Master Node Default Taint

```bash
kubectl describe node master | grep Taint
# Taints: node-role.kubernetes.io/master:NoSchedule
# OR (newer Kubernetes):
# Taints: node-role.kubernetes.io/control-plane:NoSchedule
```

This prevents user workloads from running on master nodes. Control plane pods have a corresponding toleration.

### Taints vs Node Affinity — Key Difference

```
Taints + Tolerations:
- Node REPELS pods (opt-in mechanism for the pod)
- Does NOT guarantee pod lands on specific node
- pod with toleration CAN still land on untainted nodes

Node Affinity:
- Pod ATTRACTS to specific nodes
- Does NOT prevent other pods from landing on those nodes

Combined: Use BOTH for guaranteed exclusive placement
```

### CKA Exam Tips
- Taints are on NODES; tolerations are on PODS
- Effect must EXACTLY match between taint and toleration
- `kubectl taint nodes <node> <key>=<value>:<effect>`
- To remove taint: append `-` to the taint key
- Master node taint: `node-role.kubernetes.io/control-plane:NoSchedule`
- `NoExecute` is the only effect that evicts EXISTING pods

### Production Best Practices
- Taint GPU nodes to prevent non-GPU workloads from consuming GPU resources
- Taint nodes during maintenance to gracefully evict workloads
- Use `NoSchedule` for dedicated node pools (databases, monitoring)
- Use `PreferNoSchedule` for soft preferences
- Combine with node affinity for guaranteed exclusive node usage

---

### 🔎 Summary — Taints and Tolerations

- **Taints** on nodes = repel pods that don't have matching tolerations
- **Tolerations** on pods = permission slip to be scheduled on tainted nodes
- Three effects: `NoSchedule`, `PreferNoSchedule`, `NoExecute`
- `NoExecute` = evicts EXISTING pods without toleration
- Master nodes have `control-plane:NoSchedule` taint by default
- Taints don't guarantee pod placement — use with node affinity for exclusivity
- **Production Takeaway:** Use taints to dedicate nodes for specific workloads (GPU, databases, spot instances). Add tolerations only to pods that should run there. Combine with node affinity for air-tight placement control.

---

## 23. Node Selectors

### What Is It?
**nodeSelector** is the simplest form of node selection. It constrains pods to run only on nodes with specific labels. It's a basic but limited approach — suitable for simple scenarios.

### How It Works

```
Node labeled: size=Large (8 CPU, 32Gi RAM)
Pod requests: nodeSelector: size=Large

Scheduler filter: Only consider nodes with label size=Large
Result: Pod scheduled only on large nodes
```

### Node Selector Example

```yaml
# Step 1: Label the node
# kubectl label nodes <node-name> <label-key>=<label-value>

# Step 2: Pod with nodeSelector
apiVersion: v1
kind: Pod
metadata:
  name: data-processor
spec:
  nodeSelector:
    size: Large               # Node must have this label
    # diskType: ssd           # Can specify multiple labels (AND condition)
  containers:
  - name: data-processor
    image: data-processor:v1
```

```bash
# Label nodes
kubectl label nodes node-1 size=Large
kubectl label nodes node-2 size=Medium
kubectl label nodes node-3 size=Small

# Verify labels
kubectl get nodes --show-labels
kubectl get nodes -l size=Large
```

### Limitation of nodeSelector

nodeSelector only supports exact equality matching. It cannot express:
- "Schedule on Large OR Medium nodes"
- "Schedule on any node that is NOT Small"
- "Prefer Large, but accept Medium if Large not available"

For these cases, use **Node Affinity**.

### CKA Exam Tips
- `kubectl label nodes <node> <key>=<value>` to label before using nodeSelector
- nodeSelector is under `spec.nodeSelector` (not under `spec.affinity`)
- Simple equality only — for complex rules, use nodeAffinity

---

### 🔎 Summary — Node Selectors

- **nodeSelector** = simple node label matching; exact equality only
- Label node first: `kubectl label nodes <node> <key>=<value>`
- Limited: cannot express OR, NOT, or preference-based conditions
- For complex requirements → use Node Affinity
- **Production Takeaway:** nodeSelector is simple but inflexible. Use it for basic dedicated node requirements. For production systems with complex placement needs, upgrade to nodeAffinity.

---

## 24. Node Affinity

### What Is It?
**Node Affinity** is the advanced version of nodeSelector. It uses expressive rules with operators (`In`, `NotIn`, `Exists`, `DoesNotExist`, `Gt`, `Lt`) to create flexible pod-to-node relationships. It supports both required (hard) and preferred (soft) constraints.

### Node Affinity Types

| Type | During Scheduling | During Execution |
|---|---|---|
| `requiredDuringSchedulingIgnoredDuringExecution` | Pod MUST match | Existing pods continue running even if node labels change |
| `preferredDuringSchedulingIgnoredDuringExecution` | Scheduler TRIES to match | Same — ignored during execution |
| `requiredDuringSchedulingRequiredDuringExecution` | Pod MUST match | Pod EVICTED if node no longer matches (future/planned) |

### Node Affinity YAML Examples

```yaml
# pod-node-affinity.yaml
apiVersion: v1
kind: Pod
metadata:
  name: data-processor
spec:
  affinity:
    nodeAffinity:
      
      # HARD requirement: Pod MUST land on a Large node
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: size
            operator: In           # Must be one of these values
            values:
            - Large
            - Medium              # Can be Large OR Medium
      
      # SOFT preference: Prefer SSD nodes, but not required
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100               # Weight 1-100; higher = stronger preference
        preference:
          matchExpressions:
          - key: diskType
            operator: In
            values:
            - ssd
      - weight: 50
        preference:
          matchExpressions:
          - key: zone
            operator: In
            values:
            - us-east-1a
```

### Operator Examples

```yaml
# In: node label value is in the list
- key: size
  operator: In
  values: [Large, Medium]

# NotIn: node label value is NOT in the list
- key: size
  operator: NotIn
  values: [Small]           # Schedule on anything that's not Small

# Exists: node has this label (any value)
- key: gpu
  operator: Exists          # Just requires the "gpu" label to exist

# DoesNotExist: node does NOT have this label
- key: deprecated
  operator: DoesNotExist

# Gt: node label value greater than (numeric)
- key: cpuCount
  operator: Gt
  values: ["8"]             # Nodes with cpuCount > 8

# Lt: node label value less than (numeric)
- key: maxLatency
  operator: Lt
  values: ["100"]           # Nodes with maxLatency < 100
```

### Combining Required and Preferred

```yaml
affinity:
  nodeAffinity:
    # Must be in specific availability zones
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: topology.kubernetes.io/zone
          operator: In
          values: [us-east-1a, us-east-1b, us-east-1c]
    
    # Prefer us-east-1a (primary AZ)
    preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 90
      preference:
        matchExpressions:
        - key: topology.kubernetes.io/zone
          operator: In
          values: [us-east-1a]
    - weight: 10
      preference:
        matchExpressions:
        - key: topology.kubernetes.io/zone
          operator: In
          values: [us-east-1b]
```

### CKA Exam Tips
- `requiredDuringScheduling` = Hard constraint; pod stays `Pending` if not met
- `preferredDuringScheduling` = Soft constraint; scheduled even if not met
- `IgnoredDuringExecution` = Running pods NOT affected by label changes
- The `nodeSelectorTerms` is an OR; `matchExpressions` within a term is AND
- Multiple `nodeSelectorTerms` entries: pod placed if ANY term matches (OR)

### Production Best Practices
- Use `required` for critical placement requirements (data residency, hardware requirements)
- Use `preferred` with weights for topology-aware placement
- Combine with pod topology spread constraints for advanced distribution
- Label nodes with standard Kubernetes labels: `kubernetes.io/hostname`, `topology.kubernetes.io/zone`, `node.kubernetes.io/instance-type`

---

### 🔎 Summary — Node Affinity

- **Node Affinity** = advanced nodeSelector with operators and soft/hard constraints
- Two types: `required` (must match) and `preferred` (try to match)
- Operators: `In`, `NotIn`, `Exists`, `DoesNotExist`, `Gt`, `Lt`
- Multiple `nodeSelectorTerms` = OR condition; multiple `matchExpressions` = AND condition
- Changes to node labels don't affect already-running pods (`IgnoredDuringExecution`)
- **Production Takeaway:** Use nodeAffinity to implement zone-aware deployment patterns, hardware-specific placement, and compliance requirements (data residency). Use `preferred` for best-effort distribution, `required` for hard requirements.

---

## 25. Taints/Tolerations vs Node Affinity

### The Comparison

```
Taints + Tolerations:
✓ Nodes REPEL pods (node-centric control)
✓ Prevent unwanted pods from landing on a node
✗ Don't ATTRACT pods to specific nodes
✗ Pod with toleration may still land on an untainted node

Node Affinity:
✓ Pods ATTRACT to specific nodes (pod-centric control)
✓ Ensures pod lands on correct labeled node
✗ Doesn't PREVENT other pods from landing on that node
✗ Another pod could consume node resources

Combined (Best of Both):
✓ Node REPELS non-matching pods (via taints)
✓ Pod ATTRACTED to specific node (via affinity)
✓ Result: Exclusive, guaranteed pod-to-node placement
```

### Visual Walkthrough — The Color Coding Problem

**Problem:** 3 nodes (Blue, Red, Green) + 3 pods (Blue, Red, Green) + other random pods exist. Goal: Blue pod on Blue node only, Red on Red only, Green on Green only. No other pods on these dedicated nodes.

```
Step 1 — Apply Taints (prevents non-matching pods):
kubectl taint nodes blue-node  color=blue:NoSchedule
kubectl taint nodes red-node   color=red:NoSchedule
kubectl taint nodes green-node color=green:NoSchedule

Problem: Blue pod CAN tolerate blue-node, but might still land on
         an untainted "other" node → taints alone don't guarantee placement

Step 2 — Add Tolerations to pods:
blue-pod tolerates color=blue:NoSchedule  → can land on blue-node
red-pod  tolerates color=red:NoSchedule   → can land on red-node

Problem: Even with toleration, scheduler might place blue-pod on a
         different node if it scores higher → need affinity to ATTRACT

Step 3 — Add Node Affinity:
blue-pod: requiredDuringScheduling matchLabels color=blue
red-pod:  requiredDuringScheduling matchLabels color=red

RESULT: 
- Blue node: ONLY accepts blue-pod (taint blocks others, affinity attracts blue)
- Red node:  ONLY accepts red-pod
- Green node: ONLY accepts green-pod
- "Other" random pods: land on untainted "other" nodes only
```

### Production YAML — Combining Both Approaches

```yaml
# dedicated-node-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: gpu-workload
spec:
  # Node Affinity: ATTRACT to GPU node
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: hardware
            operator: In
            values: ["gpu-v100"]

  # Toleration: PERMISSION to land on tainted GPU node
  tolerations:
  - key: "gpu"
    operator: "Equal"
    value: "nvidia-v100"
    effect: "NoSchedule"

  containers:
  - name: ml-training
    image: tensorflow/tensorflow:2.9-gpu
    resources:
      limits:
        nvidia.com/gpu: "1"     # Request 1 GPU
```

```bash
# Corresponding node setup
kubectl label nodes gpu-node-1 hardware=gpu-v100
kubectl taint nodes gpu-node-1 gpu=nvidia-v100:NoSchedule
```

### Decision Matrix

| Requirement | Use |
|---|---|
| Prevent general workloads from a node | Taint (NoSchedule) |
| Evict pods from node immediately | Taint (NoExecute) |
| Ensure pod lands on specific node type | Node Affinity (required) |
| Prefer a node type but not mandatory | Node Affinity (preferred) |
| Exclusive dedicated nodes for specific apps | Taints + Tolerations + Node Affinity |
| Force pod to one exact node | nodeName (manual) |

### CKA Exam Tips
- Taints alone do NOT guarantee placement — just permission
- Affinity alone does NOT prevent other pods — just attraction
- For EXCLUSIVE assignment: always use BOTH
- Master node uses taint `control-plane:NoSchedule` — system pods have matching toleration

---

### 🔎 Summary — Taints/Tolerations vs Node Affinity

- **Taints** = Node pushes pods away (repulsion mechanism)
- **Tolerations** = Pod's immunity to a node's taint
- **Node Affinity** = Pod pulls itself toward matching nodes (attraction mechanism)
- Neither alone guarantees exclusive placement
- **Combined** = bulletproof dedicated node strategy
- **Interview Answer:** "Taints/tolerations control which pods CAN be on a node; node affinity controls where pods WANT to be. For exclusive node dedication, use both: taints repel unwanted pods, affinity ensures desired pods land on the right node."
- **Production Takeaway:** GPU nodes, database nodes, and compliance-isolated nodes should use both mechanisms together. This ensures workload isolation without leaving nodes underutilized.

---

## 26. DaemonSets

### What Is It?
A **DaemonSet** ensures that exactly **one copy** of a pod runs on every node in the cluster (or a subset of nodes). When a new node is added, the DaemonSet automatically deploys the pod to it. When a node is removed, the pod is cleaned up.

### DaemonSet vs Deployment

```
Deployment:
- N replicas distributed across cluster
- Scheduler decides which nodes
- Adding nodes doesn't automatically add pods
- Good for: stateless apps, web servers

DaemonSet:
- 1 pod PER node (guaranteed)
- Scheduler bypass (uses node affinity internally)
- New node → pod automatically deployed
- Good for: monitoring agents, log collectors, network plugins
```

### DaemonSet Use Cases

```
Essential per-node services:
├── Monitoring agent (Prometheus node-exporter, Datadog agent)
├── Log collector (Fluent Bit, Fluentd)
├── Network plugin (kube-proxy, Weave-Net, Calico)
├── Storage driver (Ceph, Longhorn)
├── Security agent (Falco, Twistlock)
└── GPU driver installer

Every node must run these — DaemonSet is the only appropriate resource
```

### Complete DaemonSet YAML

```yaml
# daemonset-log-collector.yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluent-bit-ds
  namespace: logging
  labels:
    app: fluent-bit
    component: log-collector
spec:
  selector:
    matchLabels:
      app: fluent-bit

  updateStrategy:
    type: RollingUpdate      # RollingUpdate (default) or OnDelete
    rollingUpdate:
      maxUnavailable: 1      # Update 1 node at a time

  template:
    metadata:
      labels:
        app: fluent-bit
    spec:
      # Required to run on ALL nodes including master
      tolerations:
      - key: node-role.kubernetes.io/control-plane
        operator: Exists
        effect: NoSchedule
      - key: node-role.kubernetes.io/master
        operator: Exists
        effect: NoSchedule

      # Required for host-level log access
      hostNetwork: false
      
      serviceAccountName: fluent-bit

      containers:
      - name: fluent-bit
        image: fluent/fluent-bit:2.0
        
        resources:
          requests:
            cpu: "100m"
            memory: "128Mi"
          limits:
            cpu: "200m"
            memory: "256Mi"
        
        # Mount host paths to collect node-level logs
        volumeMounts:
        - name: varlog
          mountPath: /var/log
          readOnly: true
        - name: varlibdockercontainers
          mountPath: /var/lib/docker/containers
          readOnly: true
        - name: config
          mountPath: /fluent-bit/etc

      volumes:
      - name: varlog
        hostPath:
          path: /var/log          # Access node's /var/log
      - name: varlibdockercontainers
        hostPath:
          path: /var/lib/docker/containers
      - name: config
        configMap:
          name: fluent-bit-config

      # Ensure only one pod per node (not needed; DaemonSet guarantees this)
      # Priority to avoid eviction
      priorityClassName: system-node-critical
```

### DaemonSet Commands

```bash
# Create
kubectl apply -f daemonset-log-collector.yaml

# View DaemonSet
kubectl get daemonset -n logging
# NAME           DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR
# fluent-bit-ds  3         3         3       3            3           <none>

# Describe
kubectl describe daemonset fluent-bit-ds -n logging

# View pods created by DaemonSet
kubectl get pods -n logging -l app=fluent-bit -o wide
# One pod per node

# Check events
kubectl get events -n logging

# Delete (removes DaemonSet and all its pods)
kubectl delete daemonset fluent-bit-ds -n logging
```

### Scheduling Mechanics (Kubernetes 1.12+)

Before v1.12: DaemonSet used `nodeName` directly on pods (bypassing scheduler).  
After v1.12: DaemonSet uses **node affinity + scheduler** for proper scheduling:

```yaml
# Auto-injected by DaemonSet controller into pod spec
nodeAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    nodeSelectorTerms:
    - matchFields:
      - key: metadata.name
        operator: In
        values: ["node01"]    # One per node, rotated through all nodes
```

This allows the scheduler to respect resource constraints while still ensuring one-per-node placement.

### DaemonSet on Subset of Nodes

```yaml
spec:
  template:
    spec:
      nodeSelector:              # Only on GPU nodes
        hardware: gpu
      # OR use nodeAffinity for complex rules
```

### Real-World Production Scenario

**Application:** Large e-commerce platform — needs centralized logging from all 50 nodes

**Architecture:**
```
50 Worker Nodes
    └── Each running: fluent-bit DaemonSet pod
            └── Collects: /var/log/containers/*.log
                Parses: JSON application logs
                Forwards to: Elasticsearch (via ClusterIP service)

Elasticsearch (StatefulSet, 3 replicas)
    └── Kibana (Deployment, 2 replicas) ← for visualization
```

**Scaling behavior:** When a new node joins the cluster, DaemonSet controller automatically schedules Fluent Bit pod on it within seconds. Zero manual intervention.

**Failure handling:** If a DaemonSet pod crashes on a node → kubelet restarts it (restartPolicy: Always). If node goes down → pod is cleaned up automatically when node is removed from cluster.

### Debugging & Troubleshooting

```bash
# DaemonSet pod missing on a node?
# 1. Check if node is schedulable
kubectl describe node <node> | grep -i "taint\|unschedule"

# 2. Check DaemonSet tolerations (must tolerate node taints)
kubectl describe daemonset fluent-bit-ds | grep -A 10 Tolerations

# 3. Check DaemonSet events
kubectl describe daemonset fluent-bit-ds | tail -20

# 4. Check pod events on specific node
kubectl get pods -n logging -o wide | grep <node-name>
kubectl describe pod <pod-name> -n logging
```

### CKA Exam Tips
- DaemonSet API version: `apps/v1`, kind: `DaemonSet`
- No `replicas` field — one pod per node by definition
- Add `tolerations` for control-plane taint if DaemonSet must run on master
- DaemonSet uses `nodeSelector` or `nodeAffinity` to target subset of nodes
- kube-proxy is itself a DaemonSet (`kubectl get ds -n kube-system`)

### Production Best Practices
- Always add tolerations for control-plane/master taints for infrastructure DaemonSets
- Use `priorityClassName: system-node-critical` for essential DaemonSets
- Set resource limits — DaemonSet pods run on every node; uncontrolled resource use multiplies across all nodes
- Use `updateStrategy: RollingUpdate` with `maxUnavailable: 1` for safe updates
- Monitor with `kube_daemonset_status_number_ready` metric

---

### 🔎 Summary — DaemonSets

- **DaemonSet** = exactly one pod per node (automatically scales with node count)
- New node joins cluster → DaemonSet pod auto-deployed on it
- Node removed → DaemonSet pod cleaned up automatically
- Uses: monitoring agents, log collectors, kube-proxy, network plugins
- Add tolerations for master/control-plane to run on all nodes
- No `replicas` field — count is determined by node count
- **Production Takeaway:** DaemonSets are how you deploy infrastructure agents in Kubernetes. Every operational concern that needs per-node presence (logging, monitoring, security scanning, network plugins) should use a DaemonSet.

---

## 27. Static Pods

### What Is It?
**Static Pods** are pods created directly by the **kubelet** on a node, without going through the API Server. The kubelet reads pod definition files from a designated directory on the host filesystem and manages them independently.

### Why Static Pods Exist

```
Normal pod lifecycle:
API Server → etcd → Scheduler → kubelet → Container Runtime

Static pod lifecycle:
kubelet reads file from /etc/kubernetes/manifests → Container Runtime
(No API Server, no etcd, no scheduler involved)

Key use case: Bootstrap the Kubernetes control plane itself!
Control plane components (etcd, apiserver, scheduler) are deployed
as static pods by kubelet before the cluster is fully functional
```

### Static Pod Configuration

```bash
# Method 1: Direct flag in kubelet service
ExecStart=/usr/local/bin/kubelet \
  --pod-manifest-path=/etc/kubernetes/manifests \   # ← Static pod directory
  ...

# Method 2: Via kubelet config file (more common with kubeadm)
ExecStart=/usr/local/bin/kubelet \
  --config=/var/lib/kubelet/config.yaml \
  ...
```

```yaml
# /var/lib/kubelet/config.yaml
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
staticPodPath: /etc/kubernetes/manifests    # ← kubelet watches this directory
```

### Finding the Static Pod Directory

```bash
# Method 1: Check kubelet process flags
ps -aux | grep kubelet | grep pod-manifest-path

# Method 2: Check kubelet config file
cat /var/lib/kubelet/config.yaml | grep staticPodPath

# Method 3: Check kubelet service file
cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```

### Static Pod Behavior

```
kubelet monitors /etc/kubernetes/manifests/:
├── New file added    → Pod created immediately
├── File modified     → Pod recreated with new spec
├── File deleted      → Pod terminated
└── Pod crashes       → kubelet restarts it (like any managed pod)

These pods:
- Cannot be managed via kubectl create/delete
- Appear as READ-ONLY mirror objects in kubectl (appended with node name)
- Cannot be deleted via kubectl delete pod
- Only way to remove: delete the file from manifests directory
```

### Static Pod vs Regular Pod Naming

```bash
# Static pods get node name appended to their name
kubectl get pods -n kube-system
# etcd-controlplane                 ← etcd STATIC pod on node "controlplane"
# kube-apiserver-controlplane       ← api server STATIC pod
# kube-scheduler-controlplane       ← scheduler STATIC pod
# kube-controller-manager-controlplane ← controller manager STATIC pod

# Regular pods (not static):
# coredns-58cc8c89f4-abc12          ← Deployment-managed pod (no node suffix)
# kube-proxy-xyz99                  ← DaemonSet pod (no node suffix)
```

### Creating and Managing Static Pods

```bash
# To CREATE a static pod:
# 1. Write pod YAML
# 2. Copy to static pod directory
cp my-pod.yaml /etc/kubernetes/manifests/
# kubelet will create it automatically within seconds

# To DELETE a static pod:
rm /etc/kubernetes/manifests/my-pod.yaml
# kubelet will terminate and remove it automatically

# To UPDATE a static pod:
vim /etc/kubernetes/manifests/kube-apiserver.yaml
# kubelet detects change and recreates the pod

# Verify static pod is running
kubectl get pods -n kube-system | grep <pod-name>
# OR on the node directly (no API server needed):
crictl ps | grep <pod-name>
```

### Example Static Pod YAML

```yaml
# /etc/kubernetes/manifests/custom-monitoring.yaml
apiVersion: v1
kind: Pod
metadata:
  name: custom-monitor          # Will appear as custom-monitor-<nodename>
  namespace: kube-system
spec:
  containers:
  - name: monitor
    image: prom/node-exporter:v1.5.0
    ports:
    - containerPort: 9100
    resources:
      requests:
        cpu: "100m"
        memory: "64Mi"
      limits:
        cpu: "200m"
        memory: "128Mi"
    volumeMounts:
    - name: proc
      mountPath: /host/proc
      readOnly: true
    - name: sys
      mountPath: /host/sys
      readOnly: true
  volumes:
  - name: proc
    hostPath:
      path: /proc
  - name: sys
    hostPath:
      path: /sys
  hostNetwork: true             # Access host network for metrics
  hostPID: true                 # Access host PID namespace
```

### Static Pods vs DaemonSets

| Feature | Static Pod | DaemonSet |
|---|---|---|
| Created by | kubelet (node agent) | DaemonSet controller (via API Server) |
| Requires API Server? | No | Yes |
| Cluster-wide? | Only on THAT node's manifests dir | All nodes automatically |
| kubectl management | Read-only mirror only | Full kubectl CRUD |
| Use case | Control plane components | Infrastructure agents |
| Ignores scheduler? | Yes (completely) | No (uses node affinity via scheduler) |

### How kubeadm Uses Static Pods

```
kubeadm init process:
[1] Install kubelet on master node
[2] Write static pod manifests to /etc/kubernetes/manifests/:
    ├── etcd.yaml
    ├── kube-apiserver.yaml
    ├── kube-controller-manager.yaml
    └── kube-scheduler.yaml
[3] kubelet reads these manifests
[4] kubelet starts etcd, API server, scheduler, controller-manager as static pods
[5] Once API server is running, kubeadm proceeds with cluster initialization
[6] kube-proxy, CoreDNS deployed as normal Deployments/DaemonSets via API server
```

### Real-World Production Scenario

**Problem:** Cluster unresponsive — kubectl commands fail. Need to diagnose.

```bash
# Since API Server is down, kubectl won't work
# Go directly to node where control plane runs

# Check static pods via container runtime
crictl ps

# Check kubelet logs
journalctl -u kubelet -n 50

# Check static pod manifests
ls /etc/kubernetes/manifests/
cat /etc/kubernetes/manifests/kube-apiserver.yaml

# Common issue: etcd manifest has wrong certificate path
# Fix: edit the manifest file
vim /etc/kubernetes/manifests/etcd.yaml
# kubelet automatically restarts etcd with corrected config
```

### Debugging & Troubleshooting

```bash
# Static pod not starting?
# 1. Verify manifest syntax
kubectl apply --dry-run=client -f /etc/kubernetes/manifests/my-pod.yaml

# 2. Check kubelet logs for parsing errors
journalctl -u kubelet | grep "Error\|manifest\|static"

# 3. Check kubelet config for correct staticPodPath
cat /var/lib/kubelet/config.yaml | grep staticPodPath

# 4. Verify via crictl (no API server needed)
crictl pods | grep my-pod

# 5. Check container logs via crictl
crictl logs <container-id>
```

### CKA Exam Tips
- Static pods are identified by `<pod-name>-<node-name>` naming convention
- Cannot delete static pods with `kubectl delete pod` — must delete the manifest file
- Default static pod path (kubeadm): `/etc/kubernetes/manifests/`
- `kubectl get pod` shows read-only MIRROR objects for static pods
- To modify: edit file in manifests directory on the HOST, not via kubectl
- Control plane components in kubeadm = static pods

### Production Best Practices
- Use static pods for control plane bootstrapping only (kubeadm pattern)
- Avoid using static pods for application workloads — use DaemonSets instead
- Back up `/etc/kubernetes/manifests/` regularly (included in cluster backup)
- Monitor static pod health via `kubectl get pods -n kube-system`

---

### 🔎 Summary — Static Pods

- **Static Pods** are managed directly by kubelet from files in a local directory
- No API Server, scheduler, or etcd needed — pure kubelet management
- Used to bootstrap control plane components (etcd, apiserver, scheduler)
- `kubectl` shows them as read-only mirror objects (with node name suffix)
- To manage: add/edit/remove YAML files from `/etc/kubernetes/manifests/`
- Cannot be deleted via kubectl — only by removing the manifest file
- **Production Takeaway:** kubeadm uses static pods to bootstrap the control plane — that's the most important use case. In production, use DaemonSets for per-node application agents. Static pods are a kubelet feature for when the API server isn't available.

---

## 28. Priority Classes

### What Is It?
**PriorityClasses** assign numerical priority values to pods. Higher-value pods are scheduled before lower-value pods. When resources are scarce, the scheduler can **preempt** (evict) lower-priority pods to make room for higher-priority ones.

### Why We Need Priority Classes

```
Without Priority:
All pods treated equally → critical pods may wait behind batch jobs
Traffic surge hits → Kubernetes can't distinguish between critical and non-critical pods

With Priority:
control-plane pods: priority 2,000,000,000 (system-critical)
production-db:      priority 1,000,000     (business-critical)
production-app:     priority 100,000       (important)
batch-jobs:         priority 1,000         (low priority)
dev-workloads:      priority 100           (lowest)

→ Scheduler and preemption favor higher-value pods
```

### Priority Value Ranges

```
System reserved:     2,000,000,000 – 2,147,483,647
                     (system-critical, system-node-critical)

User-defined range:  -2,000,000,000 – 1,000,000,000
```

### Default System Priority Classes

```bash
kubectl get priorityclass
# NAME                      VALUE          GLOBAL-DEFAULT   AGE
# system-cluster-critical   2000000000     false            15d
# system-node-critical      2000010000     false            15d
```

These are used by:
- `system-cluster-critical`: CoreDNS, kube-proxy, metrics-server
- `system-node-critical`: etcd, kube-apiserver, kubelet, kube-scheduler

### Creating Priority Classes

```yaml
# priority-class-production.yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority-production
value: 1000000         # High priority for production workloads
globalDefault: false   # Set true for ONE class to be the default
description: "Priority class for mission-critical production pods"
preemptionPolicy: PreemptLowerPriority   # Default: preempt lower priority pods
                                          # Alternative: Never (wait, don't evict)
---
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: low-priority-batch
value: 100
globalDefault: false
description: "Priority class for batch/background jobs"
preemptionPolicy: Never    # Don't evict others; just wait in queue
```

### Using Priority Classes in Pods

```yaml
# production-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: critical-payment-service
  namespace: production
spec:
  priorityClassName: high-priority-production   # References the PriorityClass
  containers:
  - name: payment-service
    image: payment-service:v3.2
    resources:
      requests:
        cpu: "500m"
        memory: "512Mi"
      limits:
        cpu: "1"
        memory: "1Gi"
```

### Preemption Flow

```
Scenario: Cluster near full capacity
- Node: 8 CPU total, 7.5 CPU allocated to batch jobs
- New pod: payment-service (priority 1,000,000) needs 1 CPU

Without preemption:
  payment-service stays Pending indefinitely

With preemption (PreemptLowerPriority):
[1] Scheduler can't find node with 1 free CPU
[2] Scheduler identifies batch-job pods with priority < 1,000,000
[3] Scheduler evicts batch-job pods to free up 1 CPU
[4] batch-job pods gracefully terminated (tolerationSeconds honored)
[5] payment-service scheduled on now-available node
[6] Evicted batch-job pods rescheduled when capacity available
```

### PriorityClass with preemptionPolicy: Never

```yaml
# Non-preempting high priority — just gets to front of queue
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority-no-preempt
value: 500000
preemptionPolicy: Never    # High priority BUT won't evict existing pods
                            # Just gets scheduled BEFORE other pending pods
description: "Important but not critical enough to evict running pods"
```

### CKA Exam Tips
- PriorityClass is a **cluster-scoped** resource (not namespaced)
- `globalDefault: true` applies priority to pods without `priorityClassName`
- Only ONE PriorityClass can have `globalDefault: true`
- Without any priorityClassName → pod gets priority 0
- Higher value = higher priority
- `preemptionPolicy: Never` = high priority in queue but won't evict others

### Production Best Practices
- Define at least 3 tiers: critical, standard, batch
- Use `preemptionPolicy: Never` for important but non-critical workloads
- Set system-level pods to `system-cluster-critical` for protection
- Monitor `scheduler_preemption_attempts_total` metric
- Test preemption in non-production before relying on it

---

### 🔎 Summary — Priority Classes

- **PriorityClass** = assigns numerical priority to pods for scheduling order
- Higher priority pods scheduled first; can preempt lower priority pods
- System classes: `system-cluster-critical` (2B) and `system-node-critical` (2B+)
- User range: -2B to +1B
- `preemptionPolicy: PreemptLowerPriority` (default) = evicts lower priority pods
- `preemptionPolicy: Never` = jumps queue but doesn't evict
- `globalDefault: true` = default priority for pods without explicit class
- **Production Takeaway:** Define PriorityClasses from day one. Critical services (payment, auth) should have high priority with preemption enabled. Batch jobs should have low priority and never preempt. This ensures important workloads always get scheduled during resource contention.

---

## 29. Multiple Schedulers

### What Is It?
Kubernetes allows you to run **multiple schedulers** simultaneously alongside the default scheduler. Each scheduler can implement custom placement logic. Pods specify which scheduler should handle their placement using the `schedulerName` field.

### Why Use Multiple Schedulers

```
Default scheduler: General-purpose workload placement
                   (CPU, memory, affinity, taints)

Custom scheduler 1 (gpu-scheduler):
  - Advanced GPU topology awareness
  - NVLink bandwidth optimization
  - GPU memory fragmentation prevention

Custom scheduler 2 (batch-scheduler):
  - Gang scheduling (all pods of a job start together)
  - Bin-packing optimization
  - Preemption-based fairness for ML workloads

Custom scheduler 3 (compliance-scheduler):
  - Data residency enforcement
  - Regulatory compliance checks
  - Pre-scheduling security validation
```

### Deploying a Custom Scheduler as a Deployment

```yaml
# custom-scheduler-configmap.yaml
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
      plugins:
        score:
          disabled:
          - name: TaintToleration    # Disable default plugin
          enabled:
          - name: MyCustomScorer     # Add custom plugin
      leaderElection:
        leaderElect: false           # Single instance; no HA needed
---
# custom-scheduler-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-custom-scheduler
  namespace: kube-system
spec:
  replicas: 1
  selector:
    matchLabels:
      component: my-custom-scheduler
  template:
    metadata:
      labels:
        component: my-custom-scheduler
    spec:
      serviceAccountName: my-scheduler
      containers:
      - name: kube-scheduler
        image: k8s.gcr.io/kube-scheduler:v1.27.0  # Use same image as default
        command:
        - kube-scheduler
        - --config=/etc/kubernetes/my-scheduler/my-scheduler-config.yaml
        - --v=2
        resources:
          requests:
            cpu: "100m"
        volumeMounts:
        - name: config-volume
          mountPath: /etc/kubernetes/my-scheduler
      volumes:
      - name: config-volume
        configMap:
          name: my-scheduler-config
```

### Required RBAC for Custom Scheduler

```yaml
# scheduler-rbac.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-scheduler
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: my-scheduler-as-kube-scheduler
subjects:
- kind: ServiceAccount
  name: my-scheduler
  namespace: kube-system
roleRef:
  kind: ClusterRole
  name: system:kube-scheduler    # Same permissions as default scheduler
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: my-scheduler-as-volume-scheduler
subjects:
- kind: ServiceAccount
  name: my-scheduler
  namespace: kube-system
roleRef:
  kind: ClusterRole
  name: system:volume-scheduler
  apiGroup: rbac.authorization.k8s.io
```

### Using Custom Scheduler in a Pod

```yaml
# pod-with-custom-scheduler.yaml
apiVersion: v1
kind: Pod
metadata:
  name: ml-training-job
spec:
  schedulerName: my-custom-scheduler   # Tell K8s which scheduler to use
  # If schedulerName doesn't match any running scheduler → pod stays Pending
  containers:
  - name: ml-trainer
    image: tensorflow/tensorflow:2.9-gpu
    resources:
      limits:
        nvidia.com/gpu: "4"
```

### Verifying Scheduler Assignment

```bash
# Check which scheduler assigned a pod
kubectl get events -o wide | grep Scheduled
# LAST SEEN   TYPE     REASON      OBJECT    MESSAGE
# 10s         Normal   Scheduled   Pod/ml-training-job   Successfully assigned 
#                                            default/ml-training-job to gpu-node-1
# SOURCE: my-custom-scheduler     ← Confirms custom scheduler was used

# Check scheduler logs
kubectl logs -n kube-system deployment/my-custom-scheduler
```

### CKA Exam Tips
- Custom scheduler deployed as Deployment in `kube-system` namespace
- Pod references scheduler via `spec.schedulerName`
- If custom scheduler not running → pod stays `Pending` (no fallback)
- Default scheduler name is `default-scheduler`
- Leader election: set `leaderElect: false` for single-instance custom schedulers
- Use same `kube-scheduler` binary with different config file for simple customization

### Production Best Practices
- Custom schedulers need same RBAC as `system:kube-scheduler`
- Enable leader election for HA custom schedulers
- Name schedulers clearly — `gpu-scheduler`, `batch-scheduler`, etc.
- Log scheduling decisions for auditability
- Monitor custom scheduler latency alongside default scheduler

---

### 🔎 Summary — Multiple Schedulers

- **Multiple Schedulers** = run custom scheduling logic alongside default
- Pods specify `spec.schedulerName` to select their scheduler
- Custom scheduler = same kube-scheduler binary + different config file
- Requires RBAC: ServiceAccount + ClusterRoleBinding to `system:kube-scheduler`
- Pod with invalid `schedulerName` → stays `Pending` indefinitely
- **Production Takeaway:** Use custom schedulers for specialized workloads: GPU topology scheduling, ML gang scheduling, compliance-enforced placement. For most workloads, the default scheduler with affinity rules is sufficient.

---

## 30. Configuring Scheduler Profiles

### What Is It?
Instead of running multiple separate scheduler binaries, **Scheduler Profiles** allow a single kube-scheduler binary to run multiple scheduling configurations. Each profile behaves as an independent scheduler with different plugins enabled/disabled.

### Scheduling Extension Points

The Kubernetes scheduler has multiple **extension points** where custom plugins can hook in:

```
Scheduling Pipeline:
┌─────────────────────────────────────────────────────────────┐
│ SCHEDULING QUEUE                                            │
│   └── queueSort     (orders pods in queue by priority)      │
├─────────────────────────────────────────────────────────────┤
│ FILTERING PHASE                                             │
│   └── preFilter → filter → postFilter                       │
│       (eliminates nodes that don't fit)                     │
├─────────────────────────────────────────────────────────────┤
│ SCORING PHASE                                               │
│   └── preScore → score → normalizeScore → reserve           │
│       (ranks remaining nodes)                               │
├─────────────────────────────────────────────────────────────┤
│ BINDING PHASE                                               │
│   └── preBind → bind → postBind                             │
│       (assigns pod to node)                                 │
└─────────────────────────────────────────────────────────────┘
```

### Key Default Plugins

| Plugin | Phase | Function |
|---|---|---|
| PrioritySort | queueSort | Sorts queue by pod priority value |
| NodeResourcesFit | filter | Eliminates nodes with insufficient CPU/memory |
| NodeName | filter | Checks if `spec.nodeName` matches |
| NodeUnschedulable | filter | Skips cordoned/drained nodes |
| TaintToleration | filter + score | Evaluates taint/toleration rules |
| NodeAffinity | filter + score | Applies node affinity rules |
| ImageLocality | score | Prefers nodes that already have the image |
| DefaultBinder | bind | Writes `nodeName` to etcd via API Server |

### Multiple Profiles Configuration

```yaml
# kube-scheduler-config.yaml
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration

profiles:
# Profile 1: Default scheduler (standard workloads)
- schedulerName: default-scheduler
  plugins:
    score:
      enabled:
      - name: NodeResourcesFit
        weight: 1
      - name: ImageLocality
        weight: 1

# Profile 2: GPU-optimized scheduler (ML workloads)
- schedulerName: gpu-scheduler
  plugins:
    filter:
      disabled:
      - name: TaintToleration     # Disable default; custom plugin handles it
    score:
      disabled:
      - name: "*"                  # Disable ALL default scoring plugins
      enabled:
      - name: GPUTopologyScorer    # Custom GPU-aware scorer
        weight: 100

# Profile 3: Batch scheduler (batch/low-priority workloads)  
- schedulerName: batch-scheduler
  plugins:
    preScore:
      disabled:
      - name: "*"                  # Disable all preScore
    score:
      disabled:
      - name: NodeAffinity         # Don't weight affinity for batch
      enabled:
      - name: NodeResourcesFit     # Pack as tightly as possible
        weight: 100
  pluginConfig:
  - name: NodeResourcesFit
    args:
      scoringStrategy:
        type: MostAllocated        # Bin-pack for batch workloads
```

### Why Profiles Beat Multiple Binaries

```
Problem with separate scheduler binaries:
- Each binary maintains its own cache of cluster state
- Multiple caches can diverge → race conditions
- Pod A assigned to node by scheduler1 at same time scheduler2
  assigns Pod B to same node → both think they can fit → overcommit

Solution with profiles:
- Single binary, single cache, single source of truth
- Multiple "virtual schedulers" share same cluster state view
- No race conditions between profiles
- Simpler deployment and maintenance
```

### CKA Exam Tips
- Profiles allow ONE scheduler binary to act as MULTIPLE schedulers
- Each profile has a unique `schedulerName`
- Pods reference the profile via `spec.schedulerName`
- `disabled: name: "*"` disables ALL plugins in that extension point
- Key advantage: shared cache prevents race conditions

---

### 🔎 Summary — Configuring Scheduler Profiles

- **Scheduler Profiles** = multiple virtual schedulers in one binary
- Avoids race conditions that occur with separate scheduler binaries
- Each profile can enable/disable specific plugins per extension point
- Extension points: queueSort, filter, preScore, score, bind
- Pods use `spec.schedulerName` to select which profile handles them
- **Production Takeaway:** Prefer profiles over separate scheduler binaries. They're simpler, more reliable, and eliminate cache consistency issues. Define profiles for different workload types (general, ML/GPU, batch) within one scheduler deployment.

---

## 31. Admission Controllers

### What Is It?
**Admission Controllers** are plugins that intercept API Server requests **after** authentication and authorization but **before** the object is persisted to etcd. They can validate, modify, or reject requests based on custom rules.

### Where Admission Controllers Fit

```
Request Flow:
[1] kubectl apply → API Server
[2] Authentication (who are you?)
[3] Authorization (are you allowed to do this?)
[4] Admission Controllers ← HERE
    ├── Mutating: can MODIFY the request
    └── Validating: can ALLOW or DENY the request
[5] Schema Validation
[6] Persist to etcd
```

### Why RBAC Alone Is Insufficient

```
RBAC can control:
✓ Can user X create pods? (resource-level)
✓ Can user X access namespace Y? (namespace-level)

RBAC CANNOT control:
✗ Are pods using images from approved registries?
✗ Are pods running as root?
✗ Do pods have resource limits defined?
✗ Do pods use the "latest" tag?

Admission controllers fill this gap:
✓ Reject pods with unapproved registries
✓ Reject pods running as root
✓ Auto-inject resource limits
✓ Reject "latest" tag usage
```

### Built-in Admission Controllers

| Controller | Type | Function |
|---|---|---|
| `AlwaysPullImages` | Mutating | Forces image pull policy to Always |
| `DefaultStorageClass` | Mutating | Adds default storage class to PVCs |
| `LimitRanger` | Mutating+Validating | Applies default limits; validates against LimitRange |
| `NamespaceLifecycle` | Validating | Prevents creating objects in terminating/non-existent namespaces |
| `NodeRestriction` | Validating | Limits what kubelet can modify |
| `ResourceQuota` | Validating | Enforces namespace resource quotas |
| `ServiceAccount` | Mutating | Auto-injects default service account into pods |
| `PodSecurity` | Validating | Enforces Pod Security Standards |

### Viewing Enabled Admission Controllers

```bash
# Check running kube-apiserver flags
ps -aux | grep kube-apiserver | grep admission

# OR for kubeadm setups:
kubectl exec kube-apiserver-controlplane -n kube-system -- \
  kube-apiserver -h | grep enable-admission-plugins

# Check what's currently enabled
kubectl get pod kube-apiserver-controlplane -n kube-system -o yaml | \
  grep enable-admission-plugins
```

### Enabling/Disabling Admission Controllers

```yaml
# /etc/kubernetes/manifests/kube-apiserver.yaml (kubeadm setup)
spec:
  containers:
  - command:
    - kube-apiserver
    # ... other flags ...
    - --enable-admission-plugins=NodeRestriction,NamespaceAutoProvision
    - --disable-admission-plugins=DefaultStorageClass
```

```bash
# After modifying manifest, kubelet auto-restarts API server
# Verify changes took effect:
kubectl get pod kube-apiserver-controlplane -n kube-system -o yaml | \
  grep -A 5 admission
```

### NamespaceLifecycle vs NamespaceAutoProvision

```bash
# NamespaceLifecycle (enabled by default):
kubectl run nginx --image=nginx --namespace=nonexistent
# Error: namespaces "nonexistent" not found

# NamespaceAutoProvision (disabled by default):
# Enable it → namespace automatically created if it doesn't exist
kubectl run nginx --image=nginx --namespace=auto-created
# namespace/auto-created created (auto)
# pod/nginx created

# Note: NamespaceAutoProvision is DEPRECATED
# NamespaceLifecycle replaces both controllers
```

### CKA Exam Tips
- Admission controllers run AFTER auth/authz, BEFORE etcd persistence
- `--enable-admission-plugins` and `--disable-admission-plugins` flags on kube-apiserver
- In kubeadm: modify `/etc/kubernetes/manifests/kube-apiserver.yaml`
- Default enabled controllers include: NamespaceLifecycle, LimitRanger, ServiceAccount, NodeRestriction, ResourceQuota
- Mutating controllers run BEFORE validating controllers

---

### 🔎 Summary — Admission Controllers

- **Admission Controllers** = plugins that intercept API requests to validate/mutate objects
- Run AFTER auth/authz, BEFORE etcd persistence
- Two types: **Mutating** (can modify) and **Validating** (can approve/deny)
- Fill the gap that RBAC can't address: content-level policy enforcement
- Common ones: NamespaceLifecycle, LimitRanger, ServiceAccount, NodeRestriction
- Enable/disable via `--enable-admission-plugins` on kube-apiserver
- **Production Takeaway:** Admission controllers are your policy enforcement layer. Use them to enforce security standards (no root containers, approved registries), auto-inject defaults (service accounts, storage classes), and prevent misconfigurations.

---

## 32. Validating and Mutating Admission Controllers

### What Is It?
**Mutating Admission Webhooks** modify incoming requests (add labels, inject sidecars, set defaults). **Validating Admission Webhooks** approve or reject requests based on custom rules. Both use external webhook servers, allowing any business logic to be implemented.

### Order of Execution

```
Request arrives at API Server
        ↓
[1] Authentication
        ↓
[2] Authorization (RBAC)
        ↓
[3] MUTATING admission webhooks run first
    (modify the object — add defaults, inject sidecars)
        ↓
[4] Schema validation
        ↓
[5] VALIDATING admission webhooks run
    (approve or reject the (now-modified) object)
        ↓
[6] Persist to etcd
```

**Critical:** Mutating runs BEFORE validating. This ensures validators see the final, mutated object.

### AdmissionReview Request/Response

The API server sends AdmissionReview objects to webhook servers and expects AdmissionReview responses:

```json
// Request from API Server → Webhook
{
  "apiVersion": "admission.k8s.io/v1",
  "kind": "AdmissionReview",
  "request": {
    "uid": "705ab415-abc123",
    "kind": {"group": "", "version": "v1", "kind": "Pod"},
    "resource": {"group": "", "version": "v1", "resource": "pods"},
    "operation": "CREATE",
    "object": {
      "metadata": {"name": "nginx", "namespace": "default"},
      "spec": {"containers": [{"name": "nginx", "image": "nginx:latest"}]}
    },
    "userInfo": {"username": "john-dev", "groups": ["developers"]}
  }
}
```

```json
// Response from Webhook → API Server
// Allow:
{"response": {"uid": "705ab415-abc123", "allowed": true}}

// Deny with message:
{"response": {
  "uid": "705ab415-abc123",
  "allowed": false,
  "status": {"message": "Image 'nginx:latest' tag 'latest' is not permitted"}
}}

// Allow with mutation (base64-encoded JSON patch):
{"response": {
  "uid": "705ab415-abc123",
  "allowed": true,
  "patchType": "JSONPatch",
  "patch": "W3sib3AiOiJhZGQiLCJwYXRoIjoiL21ldGFkYXRhL2xhYmVscy9yZXZpZXdlZCIsInZhbHVlIjoidHJ1ZSJ9XQ=="
}}
```

### Webhook Configuration

```yaml
# validating-webhook-config.yaml
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: pod-policy-validator
webhooks:
- name: "pod-policy.company.com"
  
  # What triggers this webhook
  rules:
  - apiGroups: [""]
    apiVersions: ["v1"]
    operations: ["CREATE", "UPDATE"]   # Which operations trigger this
    resources: ["pods"]
    scope: "Namespaced"
  
  # How to reach the webhook server
  clientConfig:
    # Option 1: Service inside the cluster
    service:
      namespace: "webhook-system"
      name: "policy-webhook-service"
      path: "/validate"
      port: 443
    # Option 2: External URL
    # url: "https://my-webhook.company.com/validate"
    caBundle: "LS0tLS1CRUdJTi..."   # CA cert to trust the webhook server
  
  # Behavior when webhook is unavailable
  failurePolicy: Fail              # Fail | Ignore
  # Fail: reject request if webhook unreachable (safer)
  # Ignore: allow request if webhook unreachable (less safe but more available)
  
  admissionReviewVersions: ["v1"]
  sideEffects: None
  
  # Only apply to specific namespaces (optional)
  namespaceSelector:
    matchLabels:
      policy-check: "enabled"
  
  timeoutSeconds: 10               # Webhook must respond within 10s
```

```yaml
# mutating-webhook-config.yaml
apiVersion: admissionregistration.k8s.io/v1
kind: MutatingWebhookConfiguration
metadata:
  name: sidecar-injector
webhooks:
- name: "sidecar-injector.company.com"
  rules:
  - apiGroups: [""]
    apiVersions: ["v1"]
    operations: ["CREATE"]
    resources: ["pods"]
  clientConfig:
    service:
      namespace: "istio-system"
      name: "istiod"
      path: "/inject"
  failurePolicy: Ignore            # Don't block pod creation if Istio unavailable
  admissionReviewVersions: ["v1"]
  sideEffects: None
```

### Simple Python Webhook Server Example

```python
# webhook_server.py
from flask import Flask, request, jsonify
import base64
import json

app = Flask(__name__)

@app.route("/validate", methods=["POST"])
def validate():
    """Reject pods using 'latest' image tag"""
    review = request.json
    pod = review["request"]["object"]
    containers = pod["spec"]["containers"]
    
    for container in containers:
        image = container["image"]
        if image.endswith(":latest") or ":" not in image:
            return jsonify({
                "response": {
                    "uid": review["request"]["uid"],
                    "allowed": False,
                    "status": {
                        "message": f"Image '{image}' must have explicit version tag. 'latest' not permitted."
                    }
                }
            })
    
    return jsonify({
        "response": {
            "uid": review["request"]["uid"],
            "allowed": True
        }
    })

@app.route("/mutate", methods=["POST"])
def mutate():
    """Auto-inject team label based on namespace"""
    review = request.json
    namespace = review["request"]["namespace"]
    
    # Add label to pod
    patch = [
        {"op": "add", "path": "/metadata/labels/injected-by", "value": "webhook"},
        {"op": "add", "path": "/metadata/labels/namespace", "value": namespace}
    ]
    
    patch_json = json.dumps(patch)
    patch_b64 = base64.b64encode(patch_json.encode()).decode()
    
    return jsonify({
        "response": {
            "uid": review["request"]["uid"],
            "allowed": True,
            "patchType": "JSONPatch",
            "patch": patch_b64
        }
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=443, ssl_context=("cert.pem", "key.pem"))
```

### Real-World Production Scenario

**Use Case:** Enterprise security policy enforcement

```
Policies enforced via admission webhooks:

1. ValidatingWebhookConfiguration "security-policy":
   - DENY: pods using images from non-approved registries
   - DENY: pods running as root (securityContext.runAsUser: 0)
   - DENY: pods with privileged: true
   - DENY: pods without resource limits

2. MutatingWebhookConfiguration "defaults-injector":
   - INJECT: Istio sidecar proxy into every pod
   - ADD: team/owner labels from namespace annotations
   - SET: default securityContext (runAsNonRoot: true)
   - ADD: custom DNS config for service discovery
```

### Debugging & Troubleshooting

```bash
# Webhook rejecting all requests?
# 1. Check if webhook server is running
kubectl get pods -n webhook-system

# 2. Check webhook server logs
kubectl logs -n webhook-system deployment/policy-webhook

# 3. Test webhook connectivity
kubectl exec -it test-pod -- \
  curl -k https://policy-webhook-service.webhook-system/healthz

# 4. Temporarily disable webhook for debugging
kubectl delete validatingwebhookconfiguration pod-policy-validator
# (remember to re-enable!)

# 5. Check webhook config
kubectl describe validatingwebhookconfiguration pod-policy-validator

# 6. Check API server logs for webhook calls
kubectl logs kube-apiserver-controlplane -n kube-system | grep webhook
```

### CKA Exam Tips
- Mutating runs BEFORE validating (important ordering to remember)
- `failurePolicy: Fail` = reject request if webhook unreachable (safer, but risky)
- `failurePolicy: Ignore` = allow request if webhook unreachable (more available)
- Webhook servers need TLS certificates (self-signed CA registered in `caBundle`)
- `sideEffects: None` = webhook doesn't have side effects during dry runs
- Built-in admission controllers = compiled in; Webhooks = external HTTP calls

### Production Best Practices
- Always run webhook servers with HA (multiple replicas)
- Set short `timeoutSeconds` (5–10s) — slow webhooks block all matching requests
- Use `namespaceSelector` to scope webhooks (avoid applying to `kube-system`)
- Never use `failurePolicy: Fail` for webhooks that are non-critical
- Test webhooks with `--dry-run` before enabling on production
- Log all rejections with reasons for auditing

---

### 🔎 Summary — Validating and Mutating Admission Controllers

- **Mutating Webhooks** = modify objects (inject sidecars, add labels, set defaults)
- **Validating Webhooks** = approve or deny requests based on custom logic
- Mutating runs FIRST, then Validating (validators see the final mutated object)
- Both use external HTTP servers returning AdmissionReview JSON
- `failurePolicy` controls behavior when webhook server is unreachable
- TLS required between API Server and webhook server
- **Production Takeaway:** Custom webhooks are the extensibility point for Kubernetes policy enforcement. Use them to implement organizational security standards, auto-inject infrastructure components (Istio sidecars, logging agents), and enforce compliance rules that RBAC cannot cover.

---

# Part III — Logging, Monitoring & Lifecycle Management

---

## 33. Managing Application Logs

### What Is It?
Kubernetes provides mechanisms to access logs from containers running in pods. Understanding how to retrieve, stream, and manage logs is essential for debugging and monitoring applications in production.

### Docker Logging Foundation

Container applications write output to **stdout** and **stderr**. The container runtime captures this output as logs.

```bash
# Docker logging
docker run kodekloud/event-simulator          # Attached (logs to terminal)
docker run -d kodekloud/event-simulator        # Detached (no terminal output)
docker logs <container-id>                    # View logs after detach
docker logs -f <container-id>                 # Stream logs (-f = follow)
```

### Kubernetes Pod Logging Commands

```bash
# Basic log retrieval
kubectl logs <pod-name>
kubectl logs <pod-name> -n <namespace>

# Stream logs in real-time (-f = follow)
kubectl logs -f <pod-name>

# View last N lines
kubectl logs <pod-name> --tail=100

# View logs from last time duration
kubectl logs <pod-name> --since=1h
kubectl logs <pod-name> --since=30m
kubectl logs <pod-name> --since-time=2024-01-01T10:00:00Z

# Logs from PREVIOUS container (after crash)
kubectl logs <pod-name> --previous
kubectl logs <pod-name> -p              # shorthand

# Multi-container pods: MUST specify container name
kubectl logs <pod-name> -c <container-name>
kubectl logs event-simulator-pod -c event-simulator

# All containers in a pod
kubectl logs <pod-name> --all-containers=true

# Logs from all pods matching a label
kubectl logs -l app=webapp --all-containers
```

### Kubernetes Log Storage

```
Container writes to stdout/stderr
        ↓
Container Runtime (containerd) captures output
        ↓
Stored at: /var/log/containers/<pod-name>_<namespace>_<container-name>-<id>.log
           (symlink) /var/log/pods/<namespace>_<pod-name>_<uid>/<container-name>/0.log
        ↓
kubelet manages log rotation (--container-log-max-size, --container-log-max-files)
        ↓
kubectl logs reads from these files via API Server
```

### Pod Definition for Logging Demo

```yaml
# event-simulator-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: event-simulator-pod
spec:
  containers:
  - name: event-simulator
    image: kodekloud/event-simulator
    # This container writes to stdout:
    # 2024-01-01 10:00:01 - USER1 logged in
    # 2024-01-01 10:00:02 - USER2 viewing page1
    # ...

  - name: image-processor
    image: some-image-processor
    # Second container — must specify -c image-processor to get its logs
```

```bash
# Without container name (works only for single-container pods)
kubectl logs event-simulator-pod

# Error for multi-container:
# Error from server (BadRequest): a container name must be specified for pod
# event-simulator-pod, choose one of: [event-simulator image-processor]

# With container name:
kubectl logs event-simulator-pod -c event-simulator
kubectl logs event-simulator-pod -c image-processor
```

### Real-World Log Analysis Pattern

```bash
# Production debugging workflow

# Step 1: Check pod status
kubectl get pods -n production
# webapp-xyz  0/1  CrashLoopBackOff  5  10m

# Step 2: Current container logs (may be empty if already crashed)
kubectl logs webapp-xyz -n production

# Step 3: Previous container logs (THE MOST USEFUL for CrashLoopBackOff)
kubectl logs webapp-xyz -n production --previous
# Output: 
# ERROR: Cannot connect to database: connection refused to db:5432
# FATAL: Application startup failed

# Step 4: Check pod events
kubectl describe pod webapp-xyz -n production | grep -A 20 Events

# Step 5: Check if DB service exists
kubectl get service db -n production
# Error: service "db" not found ← Root cause found!

# Fix: Deploy missing DB service
kubectl apply -f db-service.yaml
```

### Centralized Log Management (Production Pattern)

```
Production logging architecture:

Node 1                          Node 2
├── Pod A logs → stdout         ├── Pod C logs → stdout
├── Pod B logs → stdout         └── Pod D logs → stdout
        ↓                               ↓
    Fluent Bit (DaemonSet)          Fluent Bit (DaemonSet)
        ↓                               ↓
        └──────────────────────────────→ Elasticsearch Cluster
                                              ↓
                                         Kibana (visualization)
                                         Grafana Loki (alternative)
```

### Debugging & Troubleshooting Logs

```bash
# Common log debugging scenarios

# 1. Pod in CrashLoopBackOff
kubectl logs <pod> --previous        # Get logs BEFORE the crash

# 2. Application error rate spike
kubectl logs -l app=webapp --tail=200 --since=15m | grep ERROR

# 3. Check control plane logs (kubeadm setup)
kubectl logs kube-apiserver-controlplane -n kube-system --tail=50
kubectl logs kube-controller-manager-controlplane -n kube-system --tail=50

# 4. Node-level logs (not accessible via kubectl)
# SSH to node:
journalctl -u kubelet -n 100              # kubelet logs
journalctl -u containerd -n 100          # container runtime logs
cat /var/log/pods/default_nginx_*/nginx/*.log  # Direct pod log file
```

### CKA Exam Tips
- `kubectl logs <pod> -c <container>` required for multi-container pods
- `kubectl logs <pod> --previous` or `-p` for crashed container logs
- `--since`, `--tail`, `-f` are frequently needed flags
- Logs are stored on nodes at `/var/log/pods/` and `/var/log/containers/`
- Control plane component logs: `kubectl logs -n kube-system <component-pod>`

### Production Best Practices
- Configure log rotation on kubelet (`--container-log-max-size=10Mi --container-log-max-files=5`)
- Deploy centralized logging (Fluent Bit + Elasticsearch/Loki) for log aggregation
- Use structured logging (JSON format) in applications for better parseability
- Include correlation IDs in all log entries for request tracing
- Set appropriate log levels (INFO in production, DEBUG only when needed)
- Implement log retention policies in your log backend

---

### 🔎 Summary — Managing Application Logs

- **kubectl logs** retrieves container stdout/stderr from API Server
- `--previous` / `-p` = logs from PREVIOUS (crashed) container instance
- Multi-container pods: always specify `-c <container-name>`
- Logs stored on nodes at `/var/log/pods/` — managed by kubelet
- `CrashLoopBackOff` → always check `kubectl logs <pod> --previous` first
- Production: use centralized log aggregation (Fluent Bit → Elasticsearch/Loki)
- **Production Takeaway:** `kubectl logs` is for interactive debugging. For production, you need a centralized log system. Implement Fluent Bit as a DaemonSet to ship logs to Elasticsearch or Grafana Loki for searchable, retained logs across all pods.

---

## 34. Rolling Updates and Rollbacks

### What Is It?
**Rolling Updates** allow Kubernetes Deployments to update pods gradually without downtime. **Rollbacks** allow reverting to a previous version if something goes wrong. Together, they form the foundation of zero-downtime deployments.

### Rollout and Revision Tracking

```
Deployment history (revisions):
Revision 1: nginx:1.7.0  ← initial deployment
Revision 2: nginx:1.7.1  ← image update
Revision 3: nginx:1.9.1  ← image update + resource change
                             ↑ current

Each revision = one ReplicaSet
kubectl rollout undo → goes back to Revision 2 (restores that ReplicaSet)
```

### Deployment Strategies Deep Dive

```
Recreate Strategy:
──── [v1, v1, v1] ─── Scale down all ─── [] ─── Scale up ─── [v2, v2, v2]
     (serving)           (DOWNTIME)                             (serving)
     ↑ Application unavailable during transition
     Use when: breaking changes that can't run alongside old version

RollingUpdate Strategy (default):
──── [v1, v1, v1] ─────────────────────────────────────────── [v2, v2, v2]
     (serving)  [v2, v1, v1] → [v2, v2, v1] → [v2, v2, v2]  (serving)
                ↑ Application always has pods serving (zero downtime)
     Use when: backward-compatible changes (most cases)
```

### Complete Deployment with Update Settings

```yaml
# deployment-with-update-strategy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
  namespace: production
  annotations:
    kubernetes.io/change-cause: "Update webapp to v2.0 - Added payment gateway"
spec:
  replicas: 5
  
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1      # At most 1 pod unavailable during update
      maxSurge: 1            # At most 1 extra pod during update
      # Effect: update goes 5→6 pods, then 5→4 old, 5→2 new, etc.
      
      # With percentages (production preferred):
      # maxUnavailable: "20%"   # 20% of 5 = 1 pod max unavailable
      # maxSurge: "20%"         # 20% of 5 = 1 extra pod max
  
  minReadySeconds: 30        # New pod must be Ready for 30s before proceeding
                             # Critical: prevents fast-failing pods from causing premature rollout
  
  progressDeadlineSeconds: 300  # Fail rollout if not complete within 5 min
  revisionHistoryLimit: 5       # Keep 5 old ReplicaSets for rollback
  
  selector:
    matchLabels:
      app: webapp
  
  template:
    metadata:
      labels:
        app: webapp
        version: "2.0"
    spec:
      containers:
      - name: webapp
        image: myregistry/webapp:2.0
        # OOMKilled → increase memory limits
        # CPU throttling → increase CPU limits or optimize app
        resources:
          requests:
            cpu: "250m"
            memory: "256Mi"
          limits:
            cpu: "500m"
            memory: "512Mi"
        
        # CRITICAL for rolling updates: readiness probe gates rollout progression
        readinessProbe:
          httpGet:
            path: /api/health
            port: 8080
          initialDelaySeconds: 15
          periodSeconds: 5
          successThreshold: 2      # Must succeed 2 times before pod is "Ready"
          failureThreshold: 3      # Fail 3 times → pod NOT ready → rollout paused
        
        livenessProbe:
          httpGet:
            path: /api/health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
          failureThreshold: 3     # CrashLoopBackOff after 3 failures
```

### All Rolling Update Commands

```bash
# ─── Creating and Monitoring ───
kubectl apply -f deployment.yaml
kubectl rollout status deployment/webapp
# Waiting for deployment "webapp" rollout to finish: 2 of 5 updated replicas...
# deployment "webapp" successfully rolled out

# Watch rollout in real time
watch kubectl get pods -l app=webapp

# ─── Triggering Updates ───
# Method 1: Update YAML file then apply
vim deployment.yaml  # Change image tag
kubectl apply -f deployment.yaml

# Method 2: Direct image update
kubectl set image deployment/webapp webapp=myregistry/webapp:2.1

# Method 3: Edit live object (avoid in production)
kubectl edit deployment webapp

# ─── Viewing History ───
kubectl rollout history deployment/webapp
# REVISION  CHANGE-CAUSE
# 1         Initial deployment v1.0
# 2         Update webapp to v2.0 - Added payment gateway

kubectl rollout history deployment/webapp --revision=2
# Detailed info about revision 2

# ─── Rollback ───
kubectl rollout undo deployment/webapp                    # → previous revision
kubectl rollout undo deployment/webapp --to-revision=1   # → specific revision

# ─── Pause/Resume (batch multiple changes) ───
kubectl rollout pause deployment/webapp
kubectl set image deployment/webapp webapp=myregistry/webapp:2.2
kubectl set resources deployment/webapp -c webapp --limits=cpu=1,memory=1Gi
kubectl rollout resume deployment/webapp   # Applies all paused changes at once

# ─── Force Rollout (restart pods without config change) ───
kubectl rollout restart deployment/webapp
```

### Real-World Production Scenario

**Application:** Banking microservices — 50 replicas of payment service

**Scenario:** Failed deployment rollout

```bash
# Deployment started — monitoring
kubectl rollout status deployment/payment-service
# Waiting for deployment "payment-service" rollout to finish: 
# 20 out of 50 updated...
# (stuck for 5+ minutes)

# Check what's happening
kubectl get pods -l app=payment-service
# payment-service-new-abc123   0/1   CrashLoopBackOff   3   2m
# payment-service-old-xyz789   1/1   Running            0   3h
# (multiple new pods crashing)

# Get crash logs
kubectl logs payment-service-new-abc123 --previous
# ERROR: Database schema version mismatch. Expected v5, found v4.
# Migration required before upgrade.

# Immediate rollback!
kubectl rollout undo deployment/payment-service
# deployment.apps/payment-service rolled back

# Verify rollback complete
kubectl rollout status deployment/payment-service
# deployment "payment-service" successfully rolled out

# All pods back to old version
kubectl get pods -l app=payment-service
# All: 1/1 Running (old version)

# Fix: Run DB migration, then redeploy
```

### Debugging & Troubleshooting

```bash
# Rollout stuck?
kubectl rollout status deployment/webapp
# error: deployment "webapp" exceeded its progress deadline

kubectl describe deployment webapp
# Conditions:
#   Type           Status   Reason
#   Progressing    False    ProgressDeadlineExceeded
# Check: are new pods starting? Any image pull errors?

kubectl get pods -l app=webapp
kubectl logs webapp-new-pod-xyz --previous

# Check ReplicaSets
kubectl get rs | grep webapp
# webapp-abc (0 desired, 0 ready) ← old RS, scaled down
# webapp-def (3 desired, 0 ready) ← new RS, pods failing

# Force rollback if stuck
kubectl rollout undo deployment/webapp
```

### CKA Exam Tips
- `kubectl rollout status` — check if rollout is complete
- `kubectl rollout history` — see revision list
- `kubectl rollout undo` — instant rollback to previous revision
- `kubectl rollout undo --to-revision=N` — specific revision rollback
- Readiness probe failure prevents rollout from proceeding (intentional safety mechanism)
- `progressDeadlineSeconds` auto-fails stuck rollouts

### Production Best Practices
- Always define readiness probes — they are the safety gate for rolling updates
- Set `minReadySeconds` to ensure pods are stable before proceeding
- Use `progressDeadlineSeconds` to auto-detect stuck rollouts
- Tag images with semantic versions, never `latest`
- Use `kubernetes.io/change-cause` annotation for meaningful history
- Keep `revisionHistoryLimit: 5-10` for reasonable rollback depth

---

### 🔎 Summary — Rolling Updates and Rollbacks

- **Rolling Update** = gradual pod replacement; zero downtime
- **Rollback** = instantly restore previous ReplicaSet via `kubectl rollout undo`
- Two strategies: `RollingUpdate` (default, zero downtime) and `Recreate` (downtime)
- `maxUnavailable` + `maxSurge` control rollout speed/safety trade-off
- Readiness probes GATE rollout progression — failed probe = rollout stops
- Revision history enables rollback to any previous state
- **Production Takeaway:** Rolling updates are how you deploy safely in Kubernetes. The readiness probe is your most critical safety mechanism — a pod that fails its readiness probe won't receive traffic and won't advance the rollout. Always define it.

---

## 35. Commands and Arguments in Docker

### What Is It?
Docker containers run a specific process defined by either the `CMD` or `ENTRYPOINT` instructions in the Dockerfile. Understanding how these work is prerequisite to configuring pod commands and arguments in Kubernetes.

### CMD vs ENTRYPOINT

```dockerfile
# Using CMD only
FROM ubuntu
CMD ["sleep", "5"]
# docker run ubuntu-sleeper         → runs: sleep 5
# docker run ubuntu-sleeper 10      → runs: 10 (CMD replaced entirely!)
# Problem: the command "sleep" is replaced by "10"

# Using ENTRYPOINT + CMD
FROM ubuntu
ENTRYPOINT ["sleep"]     # Fixed command — cannot be replaced by args
CMD ["5"]                # Default argument — CAN be overridden
# docker run ubuntu-sleeper         → runs: sleep 5  (uses CMD default)
# docker run ubuntu-sleeper 10      → runs: sleep 10 (overrides CMD, keeps ENTRYPOINT)
# docker run --entrypoint echo ubuntu-sleeper hello → runs: echo hello (overrides ENTRYPOINT)
```

### The Critical Distinction

```
CMD: Provides the DEFAULT full command. ANY argument at runtime REPLACES it entirely.
     Use when: you want the argument to fully replace the command

ENTRYPOINT: Defines the FIXED executable. Runtime arguments are APPENDED.
     Use when: you want to always run a specific program, just with different args

ENTRYPOINT + CMD combined (best practice):
ENTRYPOINT = the program to run (fixed)
CMD        = default arguments to the program (overridable)
```

### Docker Command Reference

```bash
# Build image from Dockerfile
docker build -t ubuntu-sleeper .

# Run with default CMD
docker run ubuntu-sleeper
# → runs: sleep 5

# Override CMD argument (keeps ENTRYPOINT)
docker run ubuntu-sleeper 10
# → runs: sleep 10

# Override ENTRYPOINT
docker run --entrypoint echo ubuntu-sleeper "hello world"
# → runs: echo "hello world"
```

### CKA Exam Tips
- Docker `CMD` → Kubernetes `args` (both are default/overridable commands)
- Docker `ENTRYPOINT` → Kubernetes `command` (both define the executable)
- Knowing this mapping is critical for Kubernetes pod configuration

---

### 🔎 Summary — Commands and Arguments in Docker

- `CMD` = default command; completely replaced by runtime arguments
- `ENTRYPOINT` = fixed executable; runtime arguments are appended
- `ENTRYPOINT + CMD` = best practice; ENTRYPOINT is program, CMD is default args
- **Docker → Kubernetes mapping:** `ENTRYPOINT` → `command`, `CMD` → `args`
- **Production Takeaway:** Always use ENTRYPOINT for the executable and CMD for defaults in production Docker images. This ensures consistent, predictable behavior when containers are parameterized.

---

## 36. Commands and Arguments in Kubernetes

### What Is It?
Kubernetes pod spec has two fields that map to Docker's `ENTRYPOINT` and `CMD`:
- `command` → overrides Docker `ENTRYPOINT`
- `args` → overrides Docker `CMD`

### The Mapping

```
Dockerfile        Kubernetes Pod Spec
──────────────    ──────────────────────────────
ENTRYPOINT   →    spec.containers[].command
CMD          →    spec.containers[].args
```

### Comparison Table

| Dockerfile | Docker CLI | Kubernetes spec |
|---|---|---|
| `ENTRYPOINT ["sleep"]` | `--entrypoint sleep` | `command: ["sleep"]` |
| `CMD ["5"]` | `docker run image 10` | `args: ["10"]` |

### Pod Command and Args YAML

```yaml
# pod-commands-args.yaml
apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-sleeper
spec:
  containers:
  - name: ubuntu-sleeper
    image: ubuntu-sleeper    # Has: ENTRYPOINT ["sleep"], CMD ["5"]
    
    command: ["sleep2.0"]    # Overrides ENTRYPOINT — now runs sleep2.0 instead
    args: ["10"]             # Overrides CMD — passes 10 as argument
    
    # Result: container runs: sleep2.0 10
    
    # Without command field:
    # args: ["10"]
    # Result: container runs: sleep 10 (uses ENTRYPOINT from Dockerfile)
```

### Practical Examples

```yaml
# Example 1: Override only the argument (common case)
spec:
  containers:
  - name: sleeper
    image: ubuntu-sleeper    # ENTRYPOINT: sleep
    args: ["30"]             # Override CMD: sleep 30 (not 5)

# Example 2: Override both command and args
spec:
  containers:
  - name: greeter
    image: ubuntu
    command: ["echo"]        # Overrides ENTRYPOINT
    args: ["Hello from Kubernetes!"]  # Overrides CMD

# Example 3: Environment variable in args
spec:
  containers:
  - name: app
    image: myapp
    command: ["/bin/sh", "-c"]
    args: ["echo $APP_ENV; /app/start.sh"]  # Shell script execution
    env:
    - name: APP_ENV
      value: "production"

# Example 4: Multi-line command
spec:
  containers:
  - name: init
    image: busybox
    command:
    - sh
    - -c
    - |
      echo "Starting initialization"
      mkdir -p /data/config
      cp /source/config.yaml /data/config/
      echo "Initialization complete"
```

### Common Use Cases

```yaml
# Database migration init container
initContainers:
- name: db-migrate
  image: myapp:latest
  command: ["/app/migrate"]
  args: ["--direction=up", "--steps=latest"]

# Health check script
containers:
- name: webapp
  image: webapp:1.0
  command: ["/bin/sh", "-c"]
  args: ["trap 'exit 0' SIGTERM; /app/server & wait"]

# Custom entrypoint for debugging
containers:
- name: debug
  image: production-image:1.0
  command: ["/bin/sh"]    # Override production ENTRYPOINT for debugging
  args: ["-c", "sleep 3600"]  # Keep container alive for inspection
  # kubectl exec -it pod -- /bin/sh
```

### CKA Exam Tips
- `command` REPLACES Dockerfile `ENTRYPOINT` completely
- `args` REPLACES Dockerfile `CMD` completely
- Both `command` and `args` are optional — if omitted, Dockerfile values are used
- Array format: `command: ["sleep", "5"]` OR multi-line format

```yaml
command:
- sleep
- "5"
```
- `command` alone (without `args`): the command string is used as-is

---

### 🔎 Summary — Commands and Arguments in Kubernetes

- `spec.containers[].command` → overrides Docker `ENTRYPOINT` (the program to run)
- `spec.containers[].args` → overrides Docker `CMD` (arguments to the program)
- Both are optional — Dockerfile values used if not specified
- Common use: parameterize container behavior without rebuilding images
- **Production Takeaway:** Use `args` to customize container behavior per environment without changing the Docker image. Use `command` when you need to completely override the startup behavior (e.g., for debugging or init containers).

---

## 37. Secrets

### What Is It?
**Secrets** are Kubernetes objects designed to store sensitive data (passwords, tokens, certificates, SSH keys). They keep sensitive information out of application code and pod specs while making it available to containers at runtime.

### Secrets vs ConfigMaps

```
ConfigMap: Non-sensitive configuration
           DB_HOST=mysql, APP_ENV=production, LOG_LEVEL=info

Secret: Sensitive data
        DB_PASSWORD=s3cr3t, API_KEY=abc123, TLS_CERT=...

Both stored in etcd. Difference:
- Secrets: base64-encoded (obfuscated, NOT encrypted by default)
- ConfigMaps: plain text
- Secrets: can be encrypted at rest (requires configuration)
```

### Creating Secrets

```bash
# Method 1: Imperative (from literal values)
kubectl create secret generic app-secret \
  --from-literal=DB_HOST=mysql \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASSWORD=supersecret123

# Method 2: From a file
echo -n "supersecret123" > db-password.txt
kubectl create secret generic app-secret --from-file=db-password.txt

# Method 3: Declarative (base64-encode values first)
echo -n "mysql" | base64          # → bXlzcWw=
echo -n "admin" | base64          # → YWRtaW4=
echo -n "supersecret123" | base64 # → c3VwZXJzZWNyZXQxMjM=
```

### Secret YAML

```yaml
# app-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
  namespace: production
type: Opaque           # Generic secret (other types: kubernetes.io/tls, 
                       # kubernetes.io/dockerconfigjson, etc.)
data:
  DB_HOST: bXlzcWw=           # base64("mysql")
  DB_USER: YWRtaW4=           # base64("admin")
  DB_PASSWORD: c3VwZXJzZWNyZXQxMjM=  # base64("supersecret123")

# Note: "data" uses base64 values
# Alternative: "stringData" uses plain text (auto-encoded)
stringData:
  API_KEY: "plain-text-api-key"    # No need to base64-encode in stringData
```

### Using Secrets in Pods

```yaml
# pod-with-secrets.yaml
apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  containers:
  - name: webapp
    image: webapp:2.0
    
    # Method 1: Inject ALL keys as environment variables
    envFrom:
    - secretRef:
        name: app-secret
    # Result: DB_HOST, DB_USER, DB_PASSWORD available as env vars
    
    # Method 2: Inject SPECIFIC keys as environment variables
    env:
    - name: DATABASE_PASSWORD        # Env var name in container
      valueFrom:
        secretKeyRef:
          name: app-secret           # Secret name
          key: DB_PASSWORD           # Key in the secret
    
    # Method 3: Mount as files (each key becomes a file)
    volumeMounts:
    - name: secret-volume
      mountPath: /etc/secrets
      readOnly: true
      # /etc/secrets/DB_HOST     ← contains "mysql"
      # /etc/secrets/DB_PASSWORD ← contains "supersecret123"
  
  volumes:
  - name: secret-volume
    secret:
      secretName: app-secret
      # defaultMode: 0400        # File permissions (owner read-only)
```

### Decoding Secrets

```bash
# View secret (values are base64-encoded in output)
kubectl get secret app-secret -o yaml
# data:
#   DB_PASSWORD: c3VwZXJzZWNyZXQxMjM=

# Decode a specific value
kubectl get secret app-secret -o jsonpath='{.data.DB_PASSWORD}' | base64 --decode
# Output: supersecret123

# Describe (shows keys but not values)
kubectl describe secret app-secret
# Name:    app-secret
# Data
# ====
# DB_HOST:      5 bytes
# DB_PASSWORD:  15 bytes
# DB_USER:      5 bytes
```

### Secret Types

| Type | Usage |
|---|---|
| `Opaque` | Generic user-defined secrets |
| `kubernetes.io/tls` | TLS certificate and key |
| `kubernetes.io/dockerconfigjson` | Docker registry auth |
| `kubernetes.io/service-account-token` | Service account token |
| `kubernetes.io/ssh-auth` | SSH credentials |
| `kubernetes.io/basic-auth` | Basic authentication |

### Security Considerations

```
Default security (base64 only):
- Anyone with kubectl get secret permission can decode values
- Stored unencrypted in etcd by default
- Visible in etcd dump

Improved security measures:
1. Encrypt at rest (configure EncryptionConfiguration)
2. Use RBAC to restrict secret access
3. Enable audit logging for secret access
4. Use external secret management (AWS Secrets Manager, HashiCorp Vault)
5. Use sealed-secrets (encrypt in git)

Production recommendation: Use external secrets operator
External Secrets Operator:
  - Syncs secrets from AWS/GCP/Azure/Vault into Kubernetes Secrets
  - Source of truth is external, not etcd
  - Fine-grained IAM-based access control
  - Automatic rotation support
```

### Debugging & Troubleshooting

```bash
# Pod can't start due to missing secret
kubectl describe pod webapp | grep -A 5 Events
# Error: secret "app-secret" not found

# Check secret exists
kubectl get secret app-secret

# Verify secret has correct key
kubectl get secret app-secret -o jsonpath='{.data}' | python3 -m json.tool

# Test environment variable injection
kubectl exec -it webapp -- env | grep DB_

# Check file mount
kubectl exec -it webapp -- ls /etc/secrets/
kubectl exec -it webapp -- cat /etc/secrets/DB_PASSWORD
```

### CKA Exam Tips
- `kubectl create secret generic` for opaque secrets
- `echo -n "value" | base64` to encode; `echo -n "encoded" | base64 --decode` to decode
- Secret `data` field = base64-encoded values; `stringData` = plain text
- `kubectl get secret <name> -o yaml` to see encoded values
- Secrets are namespace-scoped — must be in same namespace as the pod
- `envFrom.secretRef` injects all keys; `env.valueFrom.secretKeyRef` injects one key

### Production Best Practices
- Enable **encryption at rest** for secrets (see next section)
- Use **External Secrets Operator** to sync from Vault/AWS SM/GCP SM
- Restrict secret access with RBAC (list/get on secrets is sensitive)
- Never commit plain-text secrets to git — use sealed-secrets or external operator
- Use `stringData` in YAML for readability but never commit to git
- Rotate secrets regularly; Kubernetes secrets do not auto-rotate

---

### 🔎 Summary — Secrets

- **Secrets** = Kubernetes objects for sensitive data (passwords, tokens, certs)
- Values are **base64-encoded** — obfuscated but NOT encrypted by default
- Three injection methods: `envFrom` (all keys), `env.valueFrom` (single key), `volume` (files)
- Namespace-scoped: secrets only accessible to pods in same namespace
- Security best practice: encrypt at rest + RBAC + external secret management
- **Interview Answer:** "Kubernetes Secrets store sensitive data separately from application code. They're base64-encoded (not encrypted by default), so for real security you should enable encryption at rest and/or use external secret management like HashiCorp Vault or AWS Secrets Manager."
- **Production Takeaway:** Never store sensitive data in ConfigMaps or environment variables hardcoded in specs. Use Secrets with encryption at rest enabled. For enterprise production, use the External Secrets Operator to sync from your organization's secret management system.

---

## 38. Encrypting Secret Data at Rest

### What Is It?
By default, Kubernetes Secrets are stored in etcd as **base64-encoded plain text** — essentially unencrypted. Enabling **encryption at rest** ensures that secret values are cryptographically encrypted before being written to etcd.

### The Problem Without Encryption

```bash
# Without encryption at rest:
kubectl create secret generic my-secret --from-literal=key1=supersecret

# Query etcd directly — value is READABLE:
ETCDCTL_API=3 etcdctl get /registry/secrets/default/my-secret | hexdump -C
# 00000070  6b 65 79 31 3a 20 73 75 70 65 72 73 65 63 72 65  |key1: supersecre|
# 00000080  74 0a                                             |t.|
# ↑ Plain text visible! Anyone with etcd access can read all secrets
```

### Enabling Encryption at Rest

#### Step 1: Generate Encryption Key

```bash
# Generate a 32-byte random key (AES-256)
head -c 32 /dev/urandom | base64
# Output: y0xTt+U6xgRdNxe4nDYYsijOGgRDoUYC+wAwOKeNfPs=
```

#### Step 2: Create EncryptionConfiguration

```yaml
# /etc/kubernetes/enc/enc.yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
- resources:
  - secrets              # Encrypt secrets
  # - configmaps         # Can also encrypt configmaps
  providers:
  # Providers are tried IN ORDER for decryption
  # FIRST provider is used for new encryption (writes)
  
  - aescbc:              # AES-CBC encryption (recommended)
      keys:
      - name: key1
        secret: y0xTt+U6xgRdNxe4nDYYsijOGgRDoUYC+wAwOKeNfPs=
  
  - identity: {}         # No encryption (needed for reading unencrypted data)
                         # MUST be last; if first, nothing gets encrypted!
  
  # Key rotation: add new key at top, keep old key below
  # - aescbc:
  #     keys:
  #     - name: key2       ← new key (used for new writes)
  #       secret: <new-key>
  #     - name: key1       ← old key (used to decrypt old data)
  #       secret: <old-key>
```

#### Step 3: Configure kube-apiserver

```bash
# Move config to secure location
mkdir -p /etc/kubernetes/enc
mv enc.yaml /etc/kubernetes/enc/
```

```yaml
# /etc/kubernetes/manifests/kube-apiserver.yaml (kubeadm)
spec:
  containers:
  - command:
    - kube-apiserver
    - --encryption-provider-config=/etc/kubernetes/enc/enc.yaml  # ← Add this
    # ... other flags ...
    
    volumeMounts:
    # ... existing mounts ...
    - name: enc
      mountPath: /etc/kubernetes/enc
      readOnly: true                    # ← Add this mount
  
  volumes:
  # ... existing volumes ...
  - name: enc
    hostPath:
      path: /etc/kubernetes/enc
      type: DirectoryOrCreate           # ← Add this volume
```

```bash
# Kubelet detects the manifest change and restarts kube-apiserver automatically
# Verify API server restarted with new config
kubectl get pods -n kube-system | grep kube-apiserver
```

#### Step 4: Verify Encryption is Working

```bash
# Create a new secret AFTER enabling encryption
kubectl create secret generic my-secret-2 --from-literal=key2=topsecret

# Query etcd — should NOT see plain text
ETCDCTL_API=3 etcdctl \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  get /registry/secrets/default/my-secret-2 | hexdump -C

# You should see encrypted binary data, NOT the word "topsecret"
# Look for: "k8s:enc:aescbc:v1:key1:" prefix = encrypted!
```

#### Step 5: Re-encrypt Existing Secrets

```bash
# Secrets created BEFORE encryption was enabled are still unencrypted
# Re-encrypt ALL existing secrets:
kubectl get secrets --all-namespaces -o json | kubectl replace -f -

# This reads each secret and writes it back → triggers re-encryption
# Verify by checking etcd again for old secrets
```

### Encryption Provider Options

| Provider | Algorithm | Recommendation |
|---|---|---|
| `identity` | None | Not for production; only for backward compat |
| `aescbc` | AES-CBC | Good; widely used; default recommendation |
| `aesgcm` | AES-GCM | Good; more secure; may need key rotation sooner |
| `secretbox` | XSalsa20+Poly1305 | Good alternative |
| `kms` | KMS plugin | BEST for production; uses external key management |

### KMS Provider (Production Best Practice)

```yaml
# KMS provider configuration (uses AWS KMS, GCP KMS, Azure Key Vault)
providers:
- kms:
    name: myKmsPlugin
    endpoint: unix:///tmp/socketfile.sock  # KMS plugin socket
    cachesize: 100                          # Cache decrypted keys
    timeout: 3s                             # KMS call timeout
- identity: {}
```

Benefits of KMS provider:
- Keys stored in external HSM/KMS (not in the manifest file!)
- Key rotation without restarting API server
- Hardware-backed security
- Audit trail for key usage

### CKA Exam Tips
- Verify encryption: `ETCDCTL_API=3 etcdctl get /registry/secrets/...` and check for binary output
- `identity: {}` as FIRST provider = no encryption (use last only for migration)
- New secrets encrypted; existing secrets need `kubectl replace` to re-encrypt
- Check if encryption enabled: `ps -aux | grep kube-apiserver | grep encryption`
- Config file must be mounted into kube-apiserver pod (volume + volumeMount)

---

### 🔎 Summary — Encrypting Secret Data at Rest

- **Default:** Secrets stored as base64 in etcd = effectively plain text
- **Encryption at rest:** Secrets encrypted before writing to etcd using `EncryptionConfiguration`
- Steps: generate key → create config → mount in kube-apiserver → verify
- `identity: {}` must be LAST in providers list (otherwise nothing gets encrypted)
- Existing secrets need re-encryption after enabling: `kubectl get secrets --all-namespaces -o json | kubectl replace -f -`
- **Production best practice:** Use KMS provider (AWS KMS/GCP KMS) for hardware-backed key management
- **Production Takeaway:** Encryption at rest is non-negotiable for production Kubernetes clusters in regulated environments. Combine with external KMS for maximum security. Without it, anyone with etcd access (or an etcd backup) can read all your secrets.

---

## 39. Multi-Container Pods

### What Is It?
**Multi-container pods** co-locate two or more containers in the same pod, sharing network namespace, storage, and lifecycle. This enables common patterns like sidecar, ambassador, and adapter architectures.

### Why Use Multi-Container Pods

```
Problem: Monolithic apps are hard to scale and manage
Solution: Break into microservices
New problem: Some services are tightly coupled and need to share:
  - The same network (communicate on localhost)
  - The same storage volume
  - The same lifecycle (start/stop together)

Multi-container pods solve this by co-locating tightly coupled containers
```

### Common Multi-Container Patterns

```
1. SIDECAR Pattern:
   Main container (app) + Helper container (log agent, proxy)
   ┌────────────────────────────────────────┐
   │  Pod                                   │
   │  ┌─────────────────┐  ┌─────────────┐  │
   │  │  App Container  │  │  Log Agent  │  │
   │  │  (writes logs)  │  │  (ships logs│  │
   │  └────────┬────────┘  └──────┬──────┘  │
   │           └─── shared volume ┘         │
   └────────────────────────────────────────┘
   Example: Nginx + Fluentd log shipper

2. AMBASSADOR Pattern:
   Main container + Proxy container
   ┌─────────────────────────────────────────┐
   │  Pod                                    │
   │  ┌─────────────────┐  ┌──────────────┐  │
   │  │  App Container  │→ │  Ambassador  │→ External DB
   │  │  localhost:5432 │  │  Proxy       │  │
   │  └─────────────────┘  └──────────────┘  │
   └─────────────────────────────────────────┘
   Example: App → local proxy → database cluster routing

3. ADAPTER Pattern:
   Main container + Transformer container
   ┌──────────────────────────────────────────────────────┐
   │  Pod                                                  │
   │  ┌─────────────────┐  ┌──────────────────────────┐   │
   │  │  Legacy App     │  │  Adapter Container       │   │
   │  │  (old log format│  │  (converts to Prometheus │   │
   │  └────────┬────────┘  └────────────┬─────────────┘   │
   │           └───── shared volume ────┘                  │
   └──────────────────────────────────────────────────────┘
   Example: Old app with custom metrics → Prometheus adapter
```

### Multi-Container Pod YAML

```yaml
# multi-container-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: webapp-with-logging
  labels:
    app: webapp
spec:
  # Both containers share:
  # - Network (same IP, communicate on localhost)
  # - Volumes (defined at pod level)
  # - Lifecycle (start/stop together)
  
  containers:
  # Container 1: Main web application
  - name: webapp
    image: webapp:2.0
    ports:
    - containerPort: 8080
    resources:
      requests:
        cpu: "250m"
        memory: "256Mi"
      limits:
        cpu: "500m"
        memory: "512Mi"
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/app      # App writes logs here
  
  # Container 2: Log shipping sidecar
  - name: log-agent
    image: fluent/fluent-bit:2.0
    resources:
      requests:
        cpu: "50m"
        memory: "64Mi"
      limits:
        cpu: "100m"
        memory: "128Mi"
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/app      # Log agent reads from same directory
      readOnly: true
    - name: fluent-bit-config
      mountPath: /fluent-bit/etc
  
  # Shared volume accessible to both containers
  volumes:
  - name: shared-logs
    emptyDir: {}                   # Shared within pod; deleted when pod dies
  - name: fluent-bit-config
    configMap:
      name: fluent-bit-config
  
  # All containers must be ready for pod to be Ready
  # Pod is terminated when ANY container exits (with restartPolicy: Always, they restart)
  restartPolicy: Always
```

### Init Containers — A Special Case

**Init containers** run BEFORE the main containers, in sequence. They must complete successfully before the main application starts.

```yaml
# pod-with-init-containers.yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp
spec:
  # Init containers run sequentially BEFORE main containers
  initContainers:
  - name: wait-for-db
    image: busybox:1.35
    command:
    - sh
    - -c
    - |
      until nc -z db-service 5432; do
        echo "Waiting for database..."
        sleep 2
      done
      echo "Database is ready!"
    # This init container blocks until DB is reachable
  
  - name: run-migrations
    image: myapp:latest
    command: ["/app/migrate"]
    args: ["--direction=up"]
    env:
    - name: DB_URL
      valueFrom:
        secretKeyRef:
          name: db-secret
          key: url
  
  # Main containers start ONLY after all init containers succeed
  containers:
  - name: webapp
    image: myapp:latest
    ports:
    - containerPort: 8080
```

### Container Communication in Multi-Container Pods

```yaml
# Containers in same pod communicate via localhost
containers:
- name: nginx
  image: nginx
  # nginx listens on :80

- name: app
  image: myapp
  env:
  - name: NGINX_URL
    value: "http://localhost:80"  # Same pod = localhost communication
```

### CKA Exam Tips
- `containers` field is an array — multi-container = multiple items in array
- ALL containers must be `Running` for pod to be `Running`
- `kubectl logs <pod> -c <container>` to get logs from specific container
- Init containers run before main containers; pod waits until all init containers complete
- Shared volumes: defined at pod level, referenced by name in containers
- `kubectl describe pod <name>` shows state of each container separately

### Production Best Practices
- Keep sidecar containers lightweight — they run on every pod instance
- Set tight resource limits on sidecars (they multiply by replica count)
- Use init containers for dependency checks (DB ready, config available)
- Use sidecar pattern for logging agents, service mesh proxies (Istio/Envoy)
- Don't use multi-container pods just because it's possible — use separate pods when containers don't NEED to share lifecycle/network/storage

---

### 🔎 Summary — Multi-Container Pods

- **Multi-container pods** = co-located containers sharing network, storage, lifecycle
- Containers in the same pod communicate on **localhost**
- Common patterns: Sidecar (helper), Ambassador (proxy), Adapter (transform)
- **Init containers** run sequentially BEFORE main containers
- Shared volumes: defined at pod level, mounted by multiple containers
- ALL main containers must run for pod to be `Running`
- **Production Takeaway:** Use multi-container pods for tightly coupled helper containers (log agents, service mesh proxies, init scripts). For loosely coupled services, use separate pods with Services. The primary use case in modern Kubernetes is the sidecar pattern for Istio/Envoy proxy injection.

---

## 40. Introduction to Autoscaling

### What Is It?
**Autoscaling** in Kubernetes automatically adjusts the number of pods or the resources allocated to them based on observed metrics, eliminating the need for manual intervention during traffic changes.

### Scaling Dimensions

```
Two axes of scaling:

HORIZONTAL SCALING (add more):
├── Pods: add more pod replicas (HPA)
└── Nodes: add more cluster nodes (Cluster Autoscaler)

VERTICAL SCALING (make bigger):
├── Pods: increase CPU/memory limits/requests (VPA)
└── Nodes: increase node machine size (less common in K8s)
```

### Manual Scaling Commands

```bash
# Manually scale workloads
kubectl scale deployment my-app --replicas=10

# Manually edit resource limits
kubectl edit deployment my-app

# Add node to cluster
kubeadm join <master-ip>:6443 --token <token>
```

### Automated Scaling Tools

| Tool | Scales | Trigger |
|---|---|---|
| HPA (Horizontal Pod Autoscaler) | Pod replicas | CPU, memory, custom metrics |
| VPA (Vertical Pod Autoscaler) | Pod resource limits | Historical resource usage |
| Cluster Autoscaler | Node count | Pending pods (can't schedule due to resources) |
| KEDA | Pod replicas | External events (queues, databases, HTTP requests) |

### The Need for Autoscaling

```
Without autoscaling:
09:00 - Normal traffic: 3 pods handle load fine
12:00 - Lunch rush: 10x traffic spike → 3 pods overloaded → timeouts → lost revenue
Manual response: admin scales up to 10 pods (too late, damage done)

With HPA:
09:00 - Normal traffic: 3 pods running
12:00 - CPU hits 60% → HPA detects in 30s → scales to 6 pods
12:01 - CPU still high → HPA scales to 10 pods
14:00 - Traffic subsides → HPA scales back to 3 pods
No manual intervention. No downtime. No over-provisioning.
```

---

### 🔎 Summary — Introduction to Autoscaling

- Kubernetes supports **horizontal** (more pods/nodes) and **vertical** (bigger pods) scaling
- **Manual scaling**: `kubectl scale` (pods) or `kubeadm join` (nodes)
- **Automated scaling**: HPA (pods), Cluster Autoscaler (nodes), VPA (pod resources)
- Autoscaling requires metrics — metrics-server or custom metrics adapters
- **Production Takeaway:** Manual scaling is inadequate for production workloads with variable traffic. Implement HPA for all stateless services. Use Cluster Autoscaler for automatic node provisioning in cloud environments.

---

## 41. Horizontal Pod Autoscaler (HPA)

### What Is It?
The **Horizontal Pod Autoscaler (HPA)** automatically scales the number of pod replicas in a Deployment, ReplicaSet, or StatefulSet based on observed CPU utilization, memory utilization, or custom metrics.

### How HPA Works

```
[1] metrics-server scrapes CPU/memory from kubelet on each node
[2] HPA controller queries metrics-server every 15 seconds (default)
[3] HPA calculates desired replicas using formula:
    desiredReplicas = ceil(currentReplicas × (currentMetric / desiredMetric))
[4] If desired ≠ current → HPA updates Deployment replica count
[5] Deployment controller creates/deletes pods as needed
```

### HPA Scaling Formula

```
Example:
- Current replicas: 3
- Current CPU utilization: 90%
- Target CPU utilization: 50%

desiredReplicas = ceil(3 × (90/50)) = ceil(5.4) = 6

HPA scales from 3 → 6 replicas
```

### Prerequisites — Metrics Server

```bash
# HPA requires metrics-server to be installed
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/\
  latest/download/components.yaml

# Verify metrics server is working
kubectl top pods
kubectl top nodes
```

### Creating HPA — Imperative

```bash
# Create HPA for a deployment
kubectl autoscale deployment my-app \
  --cpu-percent=50 \         # Target: 50% CPU utilization
  --min=1 \                  # Minimum replicas
  --max=10                   # Maximum replicas

# View HPA status
kubectl get hpa
# NAME     REFERENCE              TARGETS   MINPODS  MAXPODS  REPLICAS  AGE
# my-app   Deployment/my-app      45%/50%   1        10       3         5m

# Delete HPA
kubectl delete hpa my-app
```

### HPA YAML — Declarative (autoscaling/v2)

```yaml
# hpa-production.yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: webapp-hpa
  namespace: production
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: webapp-deployment     # Target this deployment

  minReplicas: 2                # Never scale below 2 (for HA)
  maxReplicas: 20               # Never scale above 20

  metrics:
  # CPU utilization target
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 60    # Scale when average CPU > 60%

  # Memory utilization target (less reliable; memory doesn't decrease fast)
  - type: Resource
    resource:
      name: memory
      target:
        type: AverageValue
        averageValue: "400Mi"     # Scale when average memory > 400Mi

  # Custom metrics (requires custom metrics adapter)
  - type: Pods
    pods:
      metric:
        name: http_requests_per_second
      target:
        type: AverageValue
        averageValue: "1000"       # Scale when avg req/sec per pod > 1000

  # External metrics (queue depth, etc.)
  - type: External
    external:
      metric:
        name: queue_messages_ready
        selector:
          matchLabels:
            queue: payment-queue
      target:
        type: AverageValue
        averageValue: "30"         # Scale when avg queue depth per pod > 30

  # Scale-down behavior (prevent flapping)
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300    # Wait 5 min before scaling down
      policies:
      - type: Percent
        value: 25                         # Scale down max 25% per minute
        periodSeconds: 60
    scaleUp:
      stabilizationWindowSeconds: 0      # Scale up immediately
      policies:
      - type: Percent
        value: 100                        # Can double replicas per 15s
        periodSeconds: 15
      - type: Pods
        value: 4                          # OR add max 4 pods per 15s
        periodSeconds: 15
      selectPolicy: Max                   # Use whichever is larger
```

### Real-World Production Scenario

**Application:** E-commerce checkout service — handles Black Friday traffic spikes

**Setup:**
```yaml
# Deployment
resources:
  requests:
    cpu: "250m"     # HPA uses request as baseline for percentage calculation
    memory: "256Mi"
  limits:
    cpu: "500m"
    memory: "512Mi"

# HPA configuration
minReplicas: 3        # Always have 3 for HA
maxReplicas: 50       # Can scale up to 50 during Black Friday
averageUtilization: 70  # Target 70% CPU
```

**Behavior during Black Friday:**
```
08:00 - Normal traffic:    3 pods  (35% CPU)
10:00 - Traffic increases: 6 pods  (65% CPU → 8 pods)
12:00 - Peak (Black Friday): 50 pods (HPA capped at max)
         Cluster Autoscaler adds new nodes to accommodate
18:00 - Traffic subsides:  15 pods
22:00 - Normal traffic:    3 pods  (5-min stabilization window prevents flapping)
```

**Monitoring:**
```bash
# Watch HPA in real time
watch kubectl get hpa -n production

# HPA events
kubectl describe hpa webapp-hpa -n production | grep -A 10 Events
# Normal  SuccessfulRescale  2m    horizontal-pod-autoscaler  
# New size: 8; reason: cpu resource utilization (percentage of request) 
# above target
```

### Common HPA Issues

```bash
# HPA showing <unknown>/50% for targets?
# Cause: metrics-server not installed or pod not getting metrics
kubectl top pod <pod-name>
# Error: "Metrics not available for pod"

# Fix: Install metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/\
  latest/download/components.yaml

# HPA not scaling despite high CPU?
# Cause: CPU limits not set (HPA can't calculate percentage without limits)
kubectl describe pod <pod> | grep -A 3 Limits
# Limits: none  ← This is the problem
# Fix: Add CPU limits to deployment

# HPA not scaling down?
# Cause: stabilizationWindowSeconds is too high
kubectl describe hpa webapp-hpa | grep stabilization
```

### CKA Exam Tips
- HPA requires `metrics-server` to be running
- Pod MUST have CPU `requests` defined for percentage-based HPA
- `autoscaling/v2` supports multiple metrics; `autoscaling/v1` supports only CPU
- HPA adjusts `spec.replicas` in the target Deployment
- `kubectl autoscale deployment <name> --cpu-percent=X --min=Y --max=Z` creates HPA imperatively
- `kubectl get hpa` — `TARGETS` shows current/desired metric values

### Production Best Practices
- Set both `minReplicas >= 2` for HA in production
- Define CPU requests on ALL pods (required for HPA to calculate percentage)
- Use `stabilizationWindowSeconds` on scale-down to prevent flapping
- Set `maxReplicas` conservatively — unexpected scaling can exhaust cluster resources
- Monitor HPA events with `kubectl describe hpa` to understand scaling decisions
- Test autoscaling behavior with load testing tools (k6, Locust) before production

---

### 🔎 Summary — Horizontal Pod Autoscaler (HPA)

- **HPA** = automatically scales pod replicas based on metrics (CPU, memory, custom)
- Requires `metrics-server` installed in the cluster
- Pods MUST have CPU requests defined for percentage-based scaling
- Formula: `desiredReplicas = ceil(current × currentMetric/targetMetric)`
- Scale-down has stabilization window (prevent flapping); scale-up is immediate
- `autoscaling/v2` supports multiple metrics simultaneously
- **Production Takeaway:** HPA is the primary tool for handling variable traffic. Configure it for all stateless production services. Always set minReplicas ≥ 2 for high availability, and tune the stabilization window to prevent excessive pod churn during traffic fluctuations.

---

## 42. In-Place Resize of Pods

### What Is It?
**In-Place Pod Vertical Scaling** (alpha since Kubernetes 1.27) allows updating CPU and memory resource requests/limits on a running pod **without restarting it**. This is particularly important for stateful workloads where restart is costly.

### The Traditional Problem

```
Default Kubernetes behavior (without in-place resize):
Deployment: 250m CPU, 256Mi memory
Admin updates to: 500m CPU, 512Mi memory (more load incoming)

Kubernetes default:
[1] Old pod TERMINATED
[2] NEW pod created with updated resources
[3] Application experiences brief downtime (even for stateful apps)

For databases, caches, stateful services:
→ Downtime = data loss risk, connection drop, cache flush
→ Very expensive restart
```

### In-Place Resize Solution

```
With InPlacePodVerticalScaling feature gate enabled:
Admin updates CPU/memory on running pod:

For CPU (no restart needed):
[1] Admin updates spec.resources.requests.cpu
[2] CRI (containerd) updates cgroup settings
[3] Container gets more CPU immediately
[4] NO restart, NO downtime

For Memory (MAY require restart):
[1] Admin updates spec.resources.requests.memory
[2] If increasing: usually no restart needed
[3] If decreasing: restart may be required if current usage > new limit
```

### Feature Gate Enablement

```bash
# Check if feature is enabled (1.27+ alpha, 1.33 beta/stable)
kubectl get nodes -o json | jq '.items[].status.conditions'

# Enable for testing (set on API server and kubelet):
# Add to kube-apiserver flags:
--feature-gates=InPlacePodVerticalScaling=true

# Add to kubelet config:
featureGates:
  InPlacePodVerticalScaling: true
```

### Resize Policy Configuration

```yaml
# deployment-with-resize-policy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
spec:
  replicas: 3
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
        image: webapp:2.0
        
        # Resize policy: controls whether resize requires restart
        resizePolicy:
        - resourceName: cpu
          restartPolicy: NotRequired    # CPU resize = no restart
        - resourceName: memory
          restartPolicy: RestartContainer  # Memory resize = restart this container
        
        resources:
          requests:
            cpu: "250m"
            memory: "256Mi"
          limits:
            cpu: "500m"
            memory: "512Mi"
```

### Performing In-Place Resize

```bash
# Method 1: kubectl patch (in-place update to existing pod)
kubectl patch pod webapp-xyz \
  --patch '{"spec":{"containers":[{"name":"webapp","resources":{"requests":{"cpu":"500m"},"limits":{"cpu":"1"}}}]}}'

# Method 2: Update deployment (triggers in-place update for each pod)
kubectl patch deployment webapp \
  --patch '{"spec":{"template":{"spec":{"containers":[{"name":"webapp","resources":{"requests":{"cpu":"500m"}}}]}}}}'

# Method 3: kubectl edit
kubectl edit pod webapp-xyz
# Modify resources.requests.cpu and resources.limits.cpu

# Monitor resize status
kubectl get pod webapp-xyz -o json | jq '.status.containerStatuses[].allocatedResources'
kubectl describe pod webapp-xyz | grep -A 5 "Resources\|Resize"
```

### Pod Resize Status

```bash
# Check resize status in pod conditions
kubectl get pod webapp-xyz -o yaml | grep -A 5 conditions
# conditions:
# - type: PodResizePending    # Resize accepted but not yet applied
# - type: PodResizeInProgress # Being applied
# - type: PodResizeDeferred   # Can't resize now (insufficient node resources)
# - type: PodResizeInfeasible # Resize impossible (e.g., reducing below current memory usage)
```

### Limitations

```
Current limitations of InPlacePodVerticalScaling:
├── Only CPU and memory supported (not GPU, storage)
├── Pod QoS class changes NOT supported
│   (e.g., Guaranteed → Burstable via limit reduction)
├── Init containers NOT supported
├── Ephemeral containers NOT supported
├── Memory limit CANNOT be reduced below current usage
├── Windows pods NOT supported
└── Resource cannot be moved between containers
```

### CKA Exam Tips
- Feature gate: `InPlacePodVerticalScaling=true` (alpha in 1.27, evolving)
- `resizePolicy.restartPolicy`: `NotRequired` or `RestartContainer`
- Memory limit reduction below current usage = stays `PodResizePending`
- Only CPU and memory — not other resources

---

### 🔎 Summary — In-Place Resize of Pods

- **In-place resize** = update CPU/memory on running pods WITHOUT restart
- Alpha since Kubernetes 1.27; enabled via feature gate
- Critical for stateful workloads (databases, caches) where restart is expensive
- CPU resize: usually no restart; memory resize: may require container restart
- `resizePolicy` field controls per-resource restart behavior
- Current limitation: only CPU and memory; no GPU, init containers, or Windows
- **Production Takeaway:** In-place resize is transformational for stateful workload management. Once stable, it will be the foundation for VPA (Vertical Pod Autoscaler) to work without pod restarts. Watch for this feature graduating to beta/GA in upcoming Kubernetes releases.

---

# Part IV — Cluster Maintenance

---

## 43. OS Upgrades

### What Is It?
OS upgrades in Kubernetes require safely removing pods from a node before performing maintenance (OS patches, kernel updates, hardware replacement) and then returning it to service.

### What Happens When a Node Goes Down

```
Node goes offline:

< 5 minutes offline:
→ pods show as Terminating/Unknown
→ kubelet reconnects → pods restart automatically
→ No pod rescheduling (pods stay on that node)

> 5 minutes offline (pod-eviction-timeout exceeded):
→ Node marked NotReady
→ Pods on that node are evicted
→ ReplicaSet pods rescheduled on other nodes
→ Pods NOT in ReplicaSet: permanently lost (no rescheduling)
```

### Drain vs Cordon vs Uncordon

```
Cordon (kubectl cordon <node>):
  - Marks node as Unschedulable
  - No new pods scheduled here
  - Existing pods CONTINUE running
  - Use case: prevent new workloads during maintenance prep

Drain (kubectl drain <node>):
  - Marks node as Unschedulable (implied cordon)
  - GRACEFULLY terminates existing pods
  - ReplicaSet pods rescheduled on other nodes
  - Node is safe for maintenance
  - Use case: node going offline for maintenance

Uncordon (kubectl uncordon <node>):
  - Marks node as Schedulable again
  - New pods can be scheduled here
  - Does NOT automatically move pods back
  - Use case: return node to service after maintenance
```

### Complete OS Upgrade Workflow

```bash
# ─── Before Maintenance ───

# 1. Check current node status
kubectl get nodes
# controlplane  Ready  control-plane  1d  v1.28.0
# node01        Ready  <none>         1d  v1.28.0
# node02        Ready  <none>         1d  v1.28.0

# 2. Check what's running on the target node
kubectl get pods -o wide | grep node01

# 3. Drain the node (safely evict all pods)
kubectl drain node01 --ignore-daemonsets

# --ignore-daemonsets: DaemonSet pods can't be rescheduled; drain ignores them
# --force: required if non-ReplicaSet pods exist (they will be DELETED permanently)
# --delete-emptydir-data: required if pods use emptyDir volumes

# 4. Verify node is now unschedulable
kubectl get nodes
# node01   Ready,SchedulingDisabled  <none>  1d  v1.28.0
#                ↑ SchedulingDisabled = drained/cordoned

# ─── Perform Maintenance ───
# SSH to node01
# apt-get update && apt-get upgrade -y
# reboot (if needed)

# ─── After Maintenance ───

# 5. After node comes back online, verify it's joined
kubectl get nodes
# node01  Ready  <none>  1d  v1.28.0 (still SchedulingDisabled)

# 6. Uncordon the node (mark as schedulable again)
kubectl uncordon node01

# 7. Verify node is schedulable
kubectl get nodes
# node01  Ready  <none>  1d  v1.28.0 (no SchedulingDisabled)

# Note: pods don't automatically move back to node01
# Existing pods on other nodes stay there
# New pods CAN be scheduled on node01
```

### Handling Drain Failures

```bash
# Error: cannot drain node with pods not managed by ReplicaSet
kubectl drain node01 --ignore-daemonsets
# error: cannot delete DaemonSet-managed Pods (use --ignore-daemonsets): 
#   kube-system/fluent-bit-xyz
# error: cannot delete Pods with local storage: webapp-pod-xyz

# Solution 1: Add --delete-emptydir-data for local storage
kubectl drain node01 --ignore-daemonsets --delete-emptydir-data

# Solution 2: Add --force to forcefully delete non-managed pods
# WARNING: This DELETES unmanaged pods permanently!
kubectl drain node01 --ignore-daemonsets --force

# Check what would happen (dry run)
kubectl drain node01 --ignore-daemonsets --dry-run
```

### CKA Exam Tips
- `drain` = cordon + evict pods; `cordon` = only mark unschedulable (no eviction)
- `--ignore-daemonsets` is almost always needed (DaemonSets run on every node)
- `--delete-emptydir-data` needed for pods with emptyDir volumes
- After `uncordon`, existing pods do NOT automatically return to the node
- Node `NotReady,SchedulingDisabled` = drained

---

### 🔎 Summary — OS Upgrades

- **Drain** = safest way to take a node offline: evicts all pods gracefully
- **Cordon** = mark unschedulable without evicting existing pods
- **Uncordon** = return node to schedulable state
- Pod eviction timeout: 5 minutes before Kubernetes reschedules pods from failed node
- `--ignore-daemonsets` always needed; `--delete-emptydir-data` for local storage
- After uncordon, existing pods don't automatically return; only new pods can schedule there
- **Production Takeaway:** Always drain before any node maintenance. Have enough cluster capacity to absorb evicted pods. Use PodDisruptionBudgets to ensure critical services maintain minimum replicas during drains.

---

## 44. Cluster Upgrade Process

### What Is It?
**Cluster upgrades** update all Kubernetes components to a newer version. The process involves upgrading the control plane first, then worker nodes, using the `kubeadm upgrade` toolset.

### Version Skew Policy

```
Component version constraints:
├── kube-apiserver:        vX.Y.Z
├── kube-controller-manager: vX.Y.Z or vX.(Y-1).Z  (1 minor version behind max)
├── kube-scheduler:        vX.Y.Z or vX.(Y-1).Z
├── kubelet:               vX.Y.Z to vX.(Y-2).Z     (2 minor versions behind max)
├── kube-proxy:            same as kubelet
└── kubectl:               vX.(Y+1).Z to vX.(Y-1).Z (1 ahead or behind)

Rule: NEVER upgrade components beyond API Server version
      API Server is the anchor version

Upgrade path: ONE MINOR VERSION AT A TIME
1.26 → 1.27 → 1.28 (not 1.26 → 1.28 directly)
```

### When to Upgrade

```
Kubernetes support policy: Latest 3 minor versions supported
Currently: 1.28 is latest
Supported: 1.26, 1.27, 1.28
NOT supported: 1.25 and older

If running 1.26: Upgrade before 1.29 releases (when 1.26 drops out of support)
```

### Complete Upgrade Walkthrough (1.28 → 1.29)

#### Step 1: Update Package Repository

```bash
# Update Kubernetes apt repository to 1.29
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
  https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | \
  sudo tee /etc/apt/sources.list.d/kubernetes.list

# Download signing key
curl -fsSL https://pkgs.k8s.io/core/stable/v1.29/deb/Release.key | \
  sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

sudo apt-get update
```

#### Step 2: Upgrade Control Plane (Master Node)

```bash
# Check available versions
apt-cache madison kubeadm
# kubeadm | 1.29.3-1.1 | ...
# kubeadm | 1.29.2-1.1 | ...

# Upgrade kubeadm FIRST
sudo apt-mark unhold kubeadm
sudo apt-get install -y


