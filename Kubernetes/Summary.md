# 🚀 Kubernetes CKA — Complete Quick Reference Cheat Sheet

---

## 📋 Table of Contents

### [Part 1 — Core Concepts & Scheduling](#part-1--core-concepts--scheduling)
1. [Cluster Architecture](#1-cluster-architecture)
2. [Docker vs ContainerD](#2-docker-vs-containerd)
3. [ETCD for Beginners](#3-etcd-for-beginners)
4. [ETCD in Kubernetes](#4-etcd-in-kubernetes)
5. [Kube API Server](#5-kube-api-server)
6. [Kube Controller Manager](#6-kube-controller-manager)
7. [Kube Scheduler](#7-kube-scheduler)
8. [Kubelet](#8-kubelet)
9. [Kube Proxy](#9-kube-proxy)
10. [Pods](#10-pods)
11. [Pods with YAML](#11-pods-with-yaml)
12. [ReplicaSets](#12-replicasets)
13. [Deployments](#13-deployments)
14. [Services — NodePort](#14-services--nodeport)
15. [Services — ClusterIP](#15-services--clusterip)
16. [Services — LoadBalancer](#16-services--loadbalancer)
17. [Namespaces](#17-namespaces)
18. [Imperative vs Declarative](#18-imperative-vs-declarative)
19. [Kubectl Apply Command](#19-kubectl-apply-command)
20. [Manual Scheduling](#20-manual-scheduling)
21. [Labels and Selectors](#21-labels-and-selectors)
22. [Taints and Tolerations](#22-taints-and-tolerations)
23. [Node Selectors](#23-node-selectors)
24. [Node Affinity](#24-node-affinity)
25. [Taints/Tolerations vs Node Affinity](#25-taintstolerationsvsnode-affinity)
26. [DaemonSets](#26-daemonsets)
27. [Static Pods](#27-static-pods)
28. [Priority Classes](#28-priority-classes)
29. [Multiple Schedulers](#29-multiple-schedulers)
30. [Configuring Scheduler Profiles](#30-configuring-scheduler-profiles)
31. [Admission Controllers](#31-admission-controllers)
32. [Validating and Mutating Admission Controllers](#32-validating-and-mutating-admission-controllers)

### [Part 2 — Logging, Monitoring, Lifecycle & Cluster Maintenance](#part-2--logging-monitoring-lifecycle--cluster-maintenance)
33. [Managing Application Logs](#33-managing-application-logs)
34. [Rolling Updates and Rollbacks](#34-rolling-updates-and-rollbacks)
35. [Commands and Arguments in Docker](#35-commands-and-arguments-in-docker)
36. [Commands and Arguments in Kubernetes](#36-commands-and-arguments-in-kubernetes)
37. [Secrets](#37-secrets)
38. [Encrypting Secret Data at Rest](#38-encrypting-secret-data-at-rest)
39. [Multi-Container Pods](#39-multi-container-pods)
40. [Introduction to Autoscaling](#40-introduction-to-autoscaling)
41. [Horizontal Pod Autoscaler (HPA)](#41-horizontal-pod-autoscaler-hpa)
42. [In-Place Resize of Pods](#42-in-place-resize-of-pods)
43. [OS Upgrades](#43-os-upgrades)
44. [Cluster Upgrade Process](#44-cluster-upgrade-process)
45. [Backup and Restore Methods](#45-backup-and-restore-methods)

### [Part 3 — Security & Storage](#part-3--security--storage)
46. [Kubernetes Security Primitives](#46-kubernetes-security-primitives)
47. [Authentication](#47-authentication)
48. [TLS Basics](#48-tls-basics)
49. [TLS in Kubernetes](#49-tls-in-kubernetes)
50. [TLS Certificate Creation](#50-tls-certificate-creation)
51. [View Certificate Details](#51-view-certificate-details)
52. [Certificates API](#52-certificates-api)
53. [KubeConfig](#53-kubeconfig)
54. [API Groups](#54-api-groups)
55. [Authorization](#55-authorization)
56. [RBAC](#56-role-based-access-control-rbac)
57. [Cluster Roles & ClusterRoleBindings](#57-cluster-roles--clusterrolebindings)
58. [Service Accounts](#58-service-accounts)
59. [Image Security](#59-image-security)
60. [Security Contexts](#60-security-contexts)
61. [Network Policies](#61-network-policies)
62. [Custom Resource Definitions (CRDs)](#62-custom-resource-definitions-crds)
63. [Custom Controllers](#63-custom-controllers)
64. [Operator Framework](#64-operator-framework)
65. [Storage in Docker](#65-storage-in-docker)
66. [Volume Driver Plugins](#66-volume-driver-plugins)
67. [Container Storage Interface (CSI)](#67-container-storage-interface-csi)
68. [Volumes in Kubernetes](#68-volumes-in-kubernetes)
69. [Persistent Volumes (PV)](#69-persistent-volumes-pv)
70. [Persistent Volume Claims (PVC)](#70-persistent-volume-claims-pvc)
71. [Storage Classes](#71-storage-classes)

### [Part 4 — Networking, Troubleshooting & Cluster Installation](#part-4--networking-troubleshooting--cluster-installation)
72. [Linux Networking Basics](#72-linux-networking-basics)
73. [DNS Prerequisites](#73-dns-prerequisites)
74. [Network Namespaces](#74-network-namespaces)
75. [Docker Networking](#75-docker-networking)
76. [Cluster Networking](#76-cluster-networking)
77. [Pod Networking](#77-pod-networking)
78. [CNI in Kubernetes](#78-cni-in-kubernetes)
79. [Service Networking](#79-service-networking)
80. [DNS in Kubernetes](#80-dns-in-kubernetes)
81. [CoreDNS in Kubernetes](#81-coredns-in-kubernetes)
82. [Ingress](#82-ingress)
83. [Gateway API](#83-gateway-api)
84. [Application Failure Troubleshooting](#84-application-failure-troubleshooting)
85. [Control Plane Failure Troubleshooting](#85-control-plane-failure-troubleshooting)
86. [Worker Node Failure Troubleshooting](#86-worker-node-failure-troubleshooting)
87. [Choosing Kubernetes Infrastructure](#87-choosing-kubernetes-infrastructure)
88. [ETCD in HA](#88-etcd-in-ha)
89. [Demo: Cluster Deployment with kubeadm](#89-demo-cluster-deployment-with-kubeadm)

### [Part 5 — Helm, Kustomize & kubeadm](#part-5--helm-kustomize--kubeadm)
90. [Installing Helm](#90-installing-helm)
91. [Helm 2 vs Helm 3](#91-helm-2-vs-helm-3)
92. [Helm Components](#92-helm-components)
93. [Helm Charts](#93-helm-charts)
94. [Working with Helm Basics](#94-working-with-helm-basics)
95. [Customizing Chart Parameters](#95-customizing-chart-parameters)
96. [Helm Lifecycle Management](#96-helm-lifecycle-management)
97. [Kustomize vs Helm](#97-kustomize-vs-helm)
98. [Installing Kustomize](#98-installing-kustomize)
99. [Kustomize Output & Deployment](#99-kustomize-output--deployment)
100. [Managing Directories with Kustomize](#100-managing-directories-with-kustomize)
101. [Common Transformers](#101-common-transformers)
102. [Image Transformers](#102-image-transformers)
103. [Patches: Introduction & Types](#103-patches-introduction--types)
104. [Patching Dictionaries](#104-patching-dictionaries)
105. [Patching Lists](#105-patching-lists)
106. [Overlays](#106-overlays)
107. [Kustomize Components](#107-kustomize-components)

### [Interview Questions & Answers](#-interview-questions--answers)

---

---

# Part 1 — Core Concepts & Scheduling

---

## 1. Cluster Architecture

### 🔑 Key Concept
Kubernetes clusters consist of **Master Nodes** (control plane) and **Worker Nodes**. Think of master as the "brain" and workers as the "hands."

### 🏗️ Architecture Diagram
```
┌──────────────────────────────────────────────────────┐
│                   MASTER NODE                        │
│  ┌──────────┐  ┌──────────┐  ┌───────────────────┐  │
│  │  ETCD    │  │  Kube    │  │  Controller       │  │
│  │ Cluster  │  │  API     │  │  Manager          │  │
│  │(key-val) │  │  Server  │  │  (node,replica..) │  │
│  └──────────┘  └────┬─────┘  └───────────────────┘  │
│                     │         ┌───────────────────┐  │
│                     │         │  Kube Scheduler   │  │
│                     │         └───────────────────┘  │
└─────────────────────┼────────────────────────────────┘
                      │  (API Calls)
        ┌─────────────┴──────────────┐
        ▼                            ▼
┌───────────────┐          ┌───────────────┐
│  WORKER NODE  │          │  WORKER NODE  │
│  ┌─────────┐  │          │  ┌─────────┐  │
│  │ Kubelet │  │          │  │ Kubelet │  │
│  └─────────┘  │          │  └─────────┘  │
│  ┌──────────┐ │          │  ┌──────────┐ │
│  │KubeProxy │ │          │  │KubeProxy │ │
│  └──────────┘ │          │  └──────────┘ │
│  [Pods/Cont.] │          │  [Pods/Cont.] │
└───────────────┘          ��───────────────┘
```

### 📌 Component Summary Table

| Component | Location | Role |
|---|---|---|
| ETCD | Master | Stores all cluster state (key-value) |
| Kube API Server | Master | Central hub; all communication goes through it |
| Kube Scheduler | Master | Decides WHICH node a pod runs on |
| Controller Manager | Master | Ensures desired state (node health, replicas) |
| Kubelet | Worker | Node agent; starts/stops containers |
| Kube Proxy | Worker | Network rules for pod-to-pod communication |

> 💡 **Remember:** The Scheduler **decides** where to place a pod, but the **Kubelet actually creates it** on the node.

---

## 2. Docker vs ContainerD

### 🔑 Key Concept
- **Docker** was the original runtime but isn't CRI-compatible natively
- **ContainerD** is CRI-compatible and works directly with Kubernetes (since K8s v1.24, Docker support removed)
- Docker images still work because they follow **OCI standards**

### CLI Tools Comparison

| Tool | Made By | Purpose |
|---|---|---|
| `docker` | Docker Inc | Full Docker operations |
| `ctr` | ContainerD | Debug only, limited features |
| `nerdctl` | ContainerD community | Docker-like CLI for ContainerD |
| `crictl` | Kubernetes community | Inspect/debug any CRI runtime |

```bash
# Docker equivalent commands with crictl
docker ps        →  crictl ps
docker images    →  crictl images
docker logs      →  crictl logs <container-id>
docker exec      →  crictl exec -it <container-id> bash
```

> ⚠️ **Containers created manually via `crictl` may be removed by Kubelet** since they aren't registered as Kubernetes pods.

---

## 3. ETCD for Beginners

### 🔑 Key Concept
ETCD = **Distributed, reliable key-value store** — stores data as documents (JSON/YAML), not tables.

```bash
# Set a value
etcdctl put name "John"

# Get a value
etcdctl get name

# Use API v3 (recommended)
export ETCDCTL_API=3
etcdctl version
```

### Key vs Relational DB

| Relational DB | Key-Value Store (ETCD) |
|---|---|
| Tables with rows/columns | Documents per entity |
| Schema must match all rows | Each doc can have different fields |
| Harder to scale horizontally | Designed for distributed systems |

---

## 4. ETCD in Kubernetes

### 🔑 Key Concept
ETCD stores **everything** — nodes, pods, configs, secrets, roles. Only after ETCD is updated is a change "complete."

```bash
# View ETCD pod (kubeadm setup)
kubectl get pods -n kube-system | grep etcd

# List all keys stored in ETCD
kubectl exec etcd-master -n kube-system -- \
  etcdctl get / --prefix --keys-only \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key
```

> 💡 **ETCD listens on port 2379** for client requests.

---

## 5. Kube API Server

### 🔑 Key Concept
The **central gateway** — all kubectl commands, scheduler decisions, and kubelet updates go through it. It's the only component that talks directly to ETCD.

### Request Flow
```
kubectl command
     ↓
  API Server (authenticate → validate → process)
     ↓
  ETCD (read/write)
     ↑
  Scheduler watches API Server → assigns nodes
     ↓
  Kubelet creates the pod
```

```bash
# View API Server pod (kubeadm)
kubectl get pods -n kube-system | grep apiserver

# View API Server options
cat /etc/kubernetes/manifests/kube-apiserver.yaml
```

---

## 6. Kube Controller Manager

### 🔑 Key Concept
A **single process** containing all controllers. Each controller is responsible for one thing.

| Controller | What It Does |
|---|---|
| Node Controller | Checks node health every 5s; marks unreachable after 40s grace; evicts pods after 5min |
| Replication Controller | Ensures desired pod count is running |
| Deployment Controller | Manages rolling updates |
| Endpoint Controller | Populates service endpoints |

```bash
# View controller manager
ps -aux | grep kube-controller-manager

# Check flags (kubeadm)
cat /etc/kubernetes/manifests/kube-controller-manager.yaml
```

---

## 7. Kube Scheduler

### 🔑 Key Concept
Decides **which node** gets the pod using 2 phases:
1. **Filtering** — Remove nodes that don't meet resource requirements
2. **Ranking** — Score remaining nodes 0-10; pick highest

> 💡 Scheduler only **decides** — Kubelet **creates** the pod.

```bash
# View scheduler
cat /etc/kubernetes/manifests/kube-scheduler.yaml
ps -aux | grep kube-scheduler
```

---

## 8. Kubelet

### 🔑 Key Concept
The **node agent** — registers node with cluster, starts/stops containers, reports status.

> ⚠️ **kubeadm does NOT auto-deploy kubelet** — must be installed manually on each worker node.

```bash
# Install kubelet manually
wget https://storage.googleapis.com/.../kubelet

# Check kubelet process
ps -aux | grep kubelet

# Restart kubelet
sudo systemctl restart kubelet
```

---

## 9. Kube Proxy

### 🔑 Key Concept
Runs on **every node**, maintains **iptables rules** to forward traffic from Service IPs to actual Pod IPs.

```
Service IP (10.96.0.12) → iptables rule → Pod IP (10.32.0.15)
```

```bash
# View kube-proxy DaemonSet (kubeadm deploys as DaemonSet)
kubectl get daemonset -n kube-system

# View kube-proxy pods
kubectl get pods -n kube-system | grep kube-proxy
```

---

## 10. Pods

### 🔑 Key Concept
- **Smallest deployable unit** in Kubernetes
- Wraps one or more containers
- Containers in a pod **share network + storage**
- To scale → add more **pods**, NOT more containers per pod

```bash
# Create pod (imperative)
kubectl run nginx --image=nginx

# List pods
kubectl get pods
kubectl get pods -o wide   # shows IP + node

# Describe pod (detailed)
kubectl describe pod nginx

# Delete pod
kubectl delete pod nginx
```

---

## 11. Pods with YAML

### 🔑 Key Concept
Every Kubernetes YAML has **4 required top-level fields**: `apiVersion`, `kind`, `metadata`, `spec`

```yaml
# pod-definition.yaml
apiVersion: v1          # API version for Pods
kind: Pod               # Type of object
metadata:
  name: myapp-pod       # Pod name
  labels:
    app: myapp          # Labels for grouping/selecting
spec:
  containers:
    - name: nginx-container   # Container name
      image: nginx            # Docker image
```

```bash
# Create from YAML
kubectl create -f pod-definition.yaml
# OR
kubectl apply -f pod-definition.yaml

# Get YAML of existing pod
kubectl get pod nginx -o yaml
```

---

## 12. ReplicaSets

### 🔑 Key Concept
Ensures a **specified number of pod replicas** are always running. ReplicaSet is the newer version of ReplicationController.

**Key difference**: ReplicaSet requires a **`selector`** field to identify which pods to manage.

```yaml
# replicaset.yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-rs
spec:
  replicas: 3           # Desired number of pods
  selector:
    matchLabels:
      type: front-end   # Must match pod labels below
  template:             # Pod blueprint
    metadata:
      labels:
        type: front-end # Must match selector above
    spec:
      containers:
        - name: nginx
          image: nginx
```

```bash
# Create
kubectl create -f replicaset.yaml

# View
kubectl get replicaset
kubectl get rs

# Scale
kubectl scale rs myapp-rs --replicas=6

# Delete
kubectl delete rs myapp-rs
```

> 💡 **Why selector?** ReplicaSet can adopt pre-existing pods that match the label selector.

---

## 13. Deployments

### 🔑 Key Concept
**Wraps ReplicaSet** and adds: Rolling updates, Rollbacks, Pause/Resume

```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
        - name: nginx
          image: nginx:1.19   # Image to deploy
```

```bash
# Create deployment
kubectl create deployment myapp --image=nginx --replicas=3

# View all objects at once
kubectl get all

# Update image
kubectl set image deployment/myapp nginx=nginx:1.20

# Check rollout status
kubectl rollout status deployment/myapp

# View history
kubectl rollout history deployment/myapp

# Rollback
kubectl rollout undo deployment/myapp
```

### Deployment Hierarchy
```
Deployment
    └── ReplicaSet
            └── Pod → Container
```

---

## 14. Services — NodePort

### 🔑 Key Concept
Exposes a pod on a **port on the Node** (30000–32767) — for **external access**.

```
External User → NodeIP:30008 → Service → Pod:80
```

```yaml
# service-nodeport.yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  type: NodePort
  ports:
    - targetPort: 80    # Port on the Pod
      port: 80          # Port on the Service
      nodePort: 30008   # Port exposed on Node (30000-32767)
  selector:
    app: myapp          # Matches pod labels
```

```bash
kubectl create -f service-nodeport.yaml
kubectl get services
curl http://192.168.1.2:30008   # Access app externally
```

---

## 15. Services — ClusterIP

### 🔑 Key Concept
**Internal-only** service. Provides a stable IP for pod-to-pod communication. **Default** service type.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: back-end
spec:
  type: ClusterIP       # Default type
  ports:
    - port: 80          # Service port
      targetPort: 80    # Pod port
  selector:
    app: myapp
    type: back-end
```

```bash
# Create imperatively
kubectl expose pod myapp --port=80 --target-port=8080 --type=ClusterIP
```

---

## 16. Services — LoadBalancer

### 🔑 Key Concept
Provisions a **cloud load balancer** (GCP/AWS/Azure). Only works on supported cloud platforms; behaves like NodePort otherwise.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-lb
spec:
  type: LoadBalancer    # Cloud provider provisions external LB
  ports:
    - port: 80
      targetPort: 80
  selector:
    app: myapp
```

### Services Comparison Table

| Type | Accessible From | Use Case |
|---|---|---|
| ClusterIP | Inside cluster only | Internal pod communication |
| NodePort | Outside via NodeIP:Port | Dev/test external access |
| LoadBalancer | External via cloud LB | Production external access |

---

## 17. Namespaces

### 🔑 Key Concept
Logical isolation for resources. Like "rooms in a house" — same name can exist in different namespaces.

```
Default Namespaces:
- default          → where you work by default
- kube-system      → Kubernetes internal components
- kube-public      → Publicly accessible resources
```

```bash
# List namespaces
kubectl get namespaces

# Create namespace
kubectl create namespace dev

# Work in specific namespace
kubectl get pods -n kube-system
kubectl run nginx --image=nginx -n dev

# Set default namespace permanently
kubectl config set-context --current --namespace=dev
```

### DNS across namespaces
```
# Same namespace:  just use service name
curl http://db-service

# Different namespace:
curl http://db-service.dev.svc.cluster.local
#           servicename.namespace.svc.cluster.local
```

```yaml
# namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev
```

---

## 18. Imperative vs Declarative

### 🔑 Key Concept

| Imperative | Declarative |
|---|---|
| Tell Kubernetes HOW to do it | Tell Kubernetes WHAT you want |
| `kubectl run`, `kubectl create` | `kubectl apply -f file.yaml` |
| Hard to track changes | Version controlled, repeatable |
| Good for quick tasks/exams | Good for production |

```bash
# Imperative examples
kubectl run nginx --image=nginx
kubectl create deployment myapp --image=nginx --replicas=3
kubectl expose deployment myapp --port=80 --type=NodePort
kubectl edit deployment myapp   # Edit live object

# Declarative
kubectl apply -f deployment.yaml   # Create or Update
kubectl delete -f deployment.yaml  # Delete
```

> 💡 **Exam tip:** Use `--dry-run=client -o yaml` to generate YAML quickly:
```bash
kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml
kubectl create deployment myapp --image=nginx --dry-run=client -o yaml > deploy.yaml
```

---

## 19. Kubectl Apply Command

### 🔑 Key Concept
`kubectl apply` is **idempotent** — safe to run multiple times. It compares:
- **Local file** (what you want)
- **Live object** (what's running)
- **Last applied configuration** (stored as annotation)

```bash
kubectl apply -f pod.yaml           # Create or update
kubectl apply -f /path/to/configs/  # Apply all YAMLs in directory
kubectl apply -R -f configs/        # Recursive apply
```

---

## 20. Manual Scheduling

### 🔑 Key Concept
If no scheduler is running, you can manually assign pods to nodes using `nodeName` field.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  nodeName: node01    # Directly assign to node
  containers:
    - name: nginx
      image: nginx
```

> ⚠️ You can only set `nodeName` at **pod creation** time, not after. To move an existing pod, delete and recreate it, or use a **Binding object**.

---

## 21. Labels and Selectors

### 🔑 Key Concept
**Labels** = metadata key-value pairs on objects  
**Selectors** = filter/query objects by labels

```bash
# Filter pods by label
kubectl get pods -l app=myapp
kubectl get pods --selector env=prod

# Multiple labels
kubectl get pods -l app=myapp,tier=frontend
```

```yaml
# Labels on a pod
metadata:
  labels:
    app: myapp        # Application name
    env: production   # Environment
    tier: frontend    # Application tier

# Selector in a Service
spec:
  selector:
    app: myapp        # Must match pod labels
```

---

## 22. Taints and Tolerations

### 🔑 Key Concept
- **Taint** = Mark a NODE to repel certain pods (like "no entry" sign)
- **Toleration** = Allow a POD to be scheduled on tainted nodes (like a "pass")

> ⚠️ Taints/Tolerations don't **guarantee** a pod goes to specific node — they only prevent pods WITHOUT tolerations from going there.

```bash
# Add taint to node
kubectl taint nodes node01 app=blue:NoSchedule

# Taint Effects:
# NoSchedule      → Don't schedule new pods
# PreferNoSchedule → Try not to schedule (best effort)
# NoExecute       → Evict existing pods + don't schedule new

# Remove taint (add minus at end)
kubectl taint nodes node01 app=blue:NoSchedule-
```

```yaml
# Toleration on a pod
spec:
  tolerations:
    - key: "app"
      operator: "Equal"
      value: "blue"
      effect: "NoSchedule"
```

> 💡 **Master node** has a taint `node-role.kubernetes.io/control-plane:NoSchedule` — that's why pods don't schedule there by default.

---

## 23. Node Selectors

### 🔑 Key Concept
Simple way to assign pods to specific nodes using **labels**.

```bash
# Label a node first
kubectl label nodes node01 size=Large
```

```yaml
# Pod using nodeSelector
spec:
  nodeSelector:
    size: Large     # Pod goes only to nodes labeled size=Large
  containers:
    - name: nginx
      image: nginx
```

> ⚠️ Limitation: Can't express complex logic like "Large OR Medium" — use **Node Affinity** for that.

---

## 24. Node Affinity

### 🔑 Key Concept
Advanced node selection with complex expressions. More flexible than nodeSelector.

```yaml
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:   # Hard requirement
        nodeSelectorTerms:
          - matchExpressions:
              - key: size
                operator: In                 # In, NotIn, Exists, DoesNotExist
                values:
                  - Large
                  - Medium
  containers:
    - name: nginx
      image: nginx
```

### Affinity Types

| Type | Scheduling | Running |
|---|---|---|
| `requiredDuringSchedulingIgnoredDuringExecution` | Required | Ignored (pod stays) |
| `preferredDuringSchedulingIgnoredDuringExecution` | Preferred | Ignored (pod stays) |

---

## 25. Taints/Tolerations vs Node Affinity

| Feature | Taints/Tolerations | Node Affinity |
|---|---|---|
| Direction | Node repels pods | Pod attracted to nodes |
| Guarantee pod on specific node? | No | Yes (required type) |
| Prevent other pods from landing? | Yes (taint effect) | No |
| **Best combo** | Use both together for full control | Use both together |

---

## 26. DaemonSets

### 🔑 Key Concept
Ensures **one pod runs on every node** automatically. When new nodes join, DaemonSet pods are auto-deployed.

**Use cases:** Monitoring agents, log collectors, kube-proxy, network plugins

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: monitoring-agent
spec:
  selector:
    matchLabels:
      app: monitoring
  template:
    metadata:
      labels:
        app: monitoring
    spec:
      containers:
        - name: monitoring
          image: monitoring-agent
```

```bash
kubectl get daemonsets
kubectl get ds -n kube-system   # See kube-proxy, weave-net etc.
```

---

## 27. Static Pods

### 🔑 Key Concept
Pods managed **directly by Kubelet** (not by API Server). Kubelet reads pod definitions from a directory on the node.

**Default directory:** `/etc/kubernetes/manifests/`

**Use case:** Control plane components (API Server, ETCD, Scheduler, Controller Manager) run as static pods.

```bash
# Find static pod directory
cat /var/lib/kubelet/config.yaml | grep staticPodPath

# Static pods appear in kubectl but can't be deleted via kubectl
kubectl get pods -n kube-system   # Notice: apiserver-master, etcd-master etc.

# To delete: remove the file from staticPodPath
rm /etc/kubernetes/manifests/my-pod.yaml
```

> 💡 Static pod names have the **node name appended** (e.g., `etcd-controlplane`)

---

## 28. Priority Classes

### 🔑 Key Concept
Assign priority to pods — higher priority pods are scheduled first; can preempt lower priority pods.

```yaml
# Create PriorityClass
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000000          # Higher number = higher priority
globalDefault: false
description: "Critical workloads"
---
# Use in pod
spec:
  priorityClassName: high-priority
  containers:
    - name: nginx
      image: nginx
```

---

## 29. Multiple Schedulers

### 🔑 Key Concept
You can run **custom schedulers** alongside the default one. Pods can specify which scheduler to use.

```yaml
# Pod using custom scheduler
spec:
  schedulerName: my-custom-scheduler   # Use custom scheduler
  containers:
    - name: nginx
      image: nginx
```

---

## 30. Configuring Scheduler Profiles

### 🔑 Key Concept
Scheduler profiles allow multiple scheduling behaviors in **one scheduler binary** via plugins.

```yaml
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
  - schedulerName: default-scheduler
    plugins:
      score:
        disabled:
          - name: TaintToleration
```

---

## 31. Admission Controllers

### 🔑 Key Concept
**Interceptors** that run after authentication/authorization but before object creation. Can **validate** or **mutate** requests.

```bash
# View enabled admission controllers
kube-apiserver -h | grep enable-admission-plugins

# Enable an admission controller
--enable-admission-plugins=NamespaceLifecycle,NodeRestriction

# Disable
--disable-admission-plugins=DefaultStorageClass
```

**Common Built-in Controllers:**
- `NamespaceLifecycle` — Prevents creating resources in non-existent namespaces
- `LimitRanger` — Enforces resource limits
- `ServiceAccount` — Auto-mounts service account tokens
- `NodeRestriction` — Limits what kubelets can modify

---

## 32. Validating and Mutating Admission Controllers

| Type | What It Does | When |
|---|---|---|
| **Mutating** | Modifies the request (e.g., add defaults, inject sidecars) | First |
| **Validating** | Approves or rejects the request | Second |

```
Request → Authentication → Authorization → Mutating Webhooks → Validating Webhooks → Object Created
```

> 💡 **Mutating runs first** so the validating controller sees the final modified object.

---

# Part 2 — Logging, Monitoring, Lifecycle & Cluster Maintenance

---

## 33. Managing Application Logs

```bash
# View logs of a pod
kubectl logs nginx-pod

# Stream live logs (-f = follow)
kubectl logs -f nginx-pod

# Logs from specific container in multi-container pod
kubectl logs -f nginx-pod -c nginx-container

# Previous container logs (after crash)
kubectl logs nginx-pod --previous
```

---

## 34. Rolling Updates and Rollbacks

### 🔑 Key Concept
- **Recreate strategy** — Kill all old pods, create new (has downtime)
- **RollingUpdate** — Replace pods gradually (default, zero downtime)

```bash
# Update image
kubectl set image deployment/myapp nginx=nginx:1.21

# Check rollout status
kubectl rollout status deployment/myapp

# View history (revision number changes with each update)
kubectl rollout history deployment/myapp

# Rollback to previous version
kubectl rollout undo deployment/myapp

# Rollback to specific revision
kubectl rollout undo deployment/myapp --to-revision=2

# Pause/resume rollout
kubectl rollout pause deployment/myapp
kubectl rollout resume deployment/myapp
```

```yaml
# Deployment with update strategy
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 25%       # Max extra pods during update
      maxUnavailable: 25% # Max unavailable pods during update
```

---

## 35. Commands and Arguments in Docker

### 🔑 Key Concept
- `CMD` — Default command (can be fully overridden at runtime)
- `ENTRYPOINT` — Entry executable (runtime args are **appended** to it)

```dockerfile
# CMD only - runtime args REPLACE CMD
FROM ubuntu
CMD ["sleep", "5"]
# docker run ubuntu-sleeper 10  → runs: 10 (replaces CMD, INVALID!)

# ENTRYPOINT + CMD - runtime args APPEND to ENTRYPOINT, CMD is default
FROM ubuntu
ENTRYPOINT ["sleep"]
CMD ["5"]
# docker run ubuntu-sleeper       → sleep 5
# docker run ubuntu-sleeper 10    → sleep 10

# Override ENTRYPOINT
# docker run --entrypoint sleep2.0 ubuntu-sleeper 10
```

---

## 36. Commands and Arguments in Kubernetes

### 🔑 Key Concept
- `command` in pod spec → **overrides** Dockerfile `ENTRYPOINT`
- `args` in pod spec → **overrides** Dockerfile `CMD`

```yaml
spec:
  containers:
    - name: ubuntu-sleeper
      image: ubuntu-sleeper
      command: ["sleep2.0"]   # Overrides ENTRYPOINT
      args: ["10"]            # Overrides CMD
```

| Pod Spec Field | Overrides |
|---|---|
| `command` | Dockerfile `ENTRYPOINT` |
| `args` | Dockerfile `CMD` |

---

## 37. Secrets

### 🔑 Key Concept
Store sensitive data (passwords, tokens) encoded in **Base64**. Not encrypted by default — just obfuscated.

```bash
# Create secret imperatively
kubectl create secret generic app-secret \
  --from-literal=DB_HOST=mysql \
  --from-literal=DB_PASS=p@ssword

# Encode value to base64
echo -n 'p@ssword' | base64

# Decode
echo -n 'cEBzc3dvcmQ=' | base64 --decode

# View secret (encoded)
kubectl get secret app-secret -o yaml
```

```yaml
# Secret YAML (values must be base64 encoded)
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
data:
  DB_HOST: bXlzcWw=     # mysql in base64
  DB_PASS: cEBzc3dvcmQ= # p@ssword in base64
```

```yaml
# Inject secret into pod as env vars
spec:
  containers:
    - name: myapp
      image: myapp
      envFrom:
        - secretRef:
            name: app-secret    # All keys become env vars

# Or as volume (each key = file in /opt/secret-vol/)
      volumeMounts:
        - mountPath: /opt/secret-vol
          name: secret-vol
  volumes:
    - name: secret-vol
      secret:
        secretName: app-secret
```

> ⚠️ **Security Warning:** Secrets are base64 encoded, NOT encrypted. Enable encryption at rest for production.

---

## 38. Encrypting Secret Data at Rest

```bash
# 1. Generate encryption key
head -c 32 /dev/urandom | base64

# 2. Create EncryptionConfiguration
cat /etc/kubernetes/enc/enc.yaml
```

```yaml
# enc.yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: <base64-encoded-32-byte-key>
      - identity: {}    # Fallback: no encryption
```

```bash
# 3. Add to kube-apiserver manifest
--encryption-provider-config=/etc/kubernetes/enc/enc.yaml

# 4. Re-encrypt existing secrets
kubectl get secrets --all-namespaces -o json | kubectl replace -f -

# 5. Verify encryption (should show 'k8s:enc:aescbc' prefix)
ETCDCTL_API=3 etcdctl get /registry/secrets/default/my-secret \
  --cacert=... --cert=... --key=... | hexdump -C
```

---

## 39. Multi-Container Pods

### 🔑 Key Concept
Multiple containers in one pod **share**: network (localhost), storage volumes, lifecycle.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
spec:
  containers:
    - name: web-app          # Main app
      image: webapp
      ports:
        - containerPort: 8080
    - name: log-agent        # Sidecar container
      image: log-agent
      # Shares same network/storage as web-app
```

**Common Multi-Container Patterns:**
- **Sidecar** — Helper alongside main container (e.g., logging)
- **Ambassador** — Proxy for external services
- **Adapter** — Transforms output of main container

---

## 40. Introduction to Autoscaling

| Scale Type | Manual Command | Automated |
|---|---|---|
| Cluster horizontal | `kubeadm join` | Cluster Autoscaler |
| Workload horizontal | `kubectl scale` | HPA |
| Workload vertical | `kubectl edit` | VPA |

---

## 41. Horizontal Pod Autoscaler (HPA)

### 🔑 Key Concept
Automatically scales pod **count** based on CPU/memory metrics. Requires **metrics-server**.

```bash
# Create HPA imperatively
kubectl autoscale deployment myapp \
  --cpu-percent=50 \
  --min=1 \
  --max=10

# View HPA
kubectl get hpa

# Delete HPA
kubectl delete hpa myapp
```

```yaml
# HPA YAML (declarative)
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: myapp-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: myapp
  minReplicas: 1
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50    # Scale when CPU > 50%
```

---

## 42. In-Place Resize of Pods

### 🔑 Key Concept
Alpha feature (since K8s 1.27) — resize CPU/memory **without recreating** the pod.

```yaml
spec:
  containers:
    - name: myapp
      image: nginx
      resizePolicy:
        - resourceName: cpu
          restartPolicy: NotRequired    # Don't restart for CPU changes
      resources:
        requests:
          cpu: "1"        # Changed from 250m to 1 CPU (in-place)
```

```bash
# Enable feature gate
FEATURE_GATES=InPlacePodVerticalScaling=true
```

> ⚠️ **Limitations:** Only CPU/memory, no Windows pods, no init/ephemeral containers.

---

## 43. OS Upgrades

### 🔑 Key Concept
When maintenance requires taking a node offline, **drain** it first to safely move workloads.

```bash
# Drain node (evict pods + mark unschedulable)
kubectl drain node01 --ignore-daemonsets

# Optional: force delete standalone pods (not in ReplicaSet)
kubectl drain node01 --ignore-daemonsets --force

# After maintenance, uncordon (allow scheduling again)
kubectl uncordon node01

# Just mark unschedulable (don't evict running pods)
kubectl cordon node01
```

> ⚠️ Pods NOT in a ReplicaSet/Deployment will be **permanently lost** when drained!

---

## 44. Cluster Upgrade Process

### 🔑 Key Concept
- Upgrade **one minor version at a time** (1.28 → 1.29, not 1.28 → 1.31)
- Upgrade **master first**, then workers
- During master upgrade: workers still run, but no new scheduling

```bash
# Step 1: Check upgrade plan
kubeadm upgrade plan

# Step 2: Upgrade kubeadm on master
apt-mark unhold kubeadm
apt-get install -y kubeadm=1.29.3-1.1
apt-mark hold kubeadm

# Step 3: Apply upgrade
kubeadm upgrade apply v1.29.3

# Step 4: Drain master
kubectl drain controlplane --ignore-daemonsets

# Step 5: Upgrade kubelet + kubectl on master
apt-get install -y kubelet=1.29.3-1.1 kubectl=1.29.3-1.1
systemctl restart kubelet

# Step 6: Uncordon master
kubectl uncordon controlplane

# Step 7: Repeat for each worker node
kubectl drain node01 --ignore-daemonsets
# (On worker node)
kubeadm upgrade node
apt-get install -y kubelet=1.29.3-1.1 kubectl=1.29.3-1.1
systemctl restart kubelet
# (On master)
kubectl uncordon node01
```

---

## 45. Backup and Restore Methods

### Method 1: Backup Resource Configs
```bash
# Export all resources to YAML
kubectl get all --all-namespaces -o yaml > all-resources.yaml
```

### Method 2: ETCD Backup (recommended)
```bash
# Create ETCD snapshot
ETCDCTL_API=3 etcdctl snapshot save /backup/etcd-snapshot.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key

# Verify snapshot
ETCDCTL_API=3 etcdctl snapshot status /backup/etcd-snapshot.db

# Restore from snapshot
ETCDCTL_API=3 etcdctl snapshot restore /backup/etcd-snapshot.db \
  --data-dir=/var/lib/etcd-restored

# Update etcd to use new data-dir, restart services
```

---

# Part 3 — Security & Storage

---

## 46. Kubernetes Security Primitives

### 🔑 Key Concept
**Secure the kube-apiserver first** — it's the entry point to everything.

```
Who can access? → Authentication (who are you?)
What can they do? → Authorization (what are you allowed?)
```

**Authentication methods:**
- Static password/token files (not recommended)
- Certificates (TLS)
- LDAP/external identity providers
- Service Accounts (for pods)

---

## 47. Authentication

### 🔑 Key Concept
Humans use **certificates** or **tokens**. Pods use **Service Accounts**.

```bash
# Create a user certificate (simplified)
# 1. Generate key
openssl genrsa -out user.key 2048

# 2. Create CSR
openssl req -new -key user.key -subj "/CN=john/O=dev" -out user.csr

# 3. Sign with Kubernetes CA
openssl x509 -req -in user.csr \
  -CA /etc/kubernetes/pki/ca.crt \
  -CAkey /etc/kubernetes/pki/ca.key \
  -out user.crt -days 365
```

---

## 48. TLS Basics

### 🔑 Key Concept
TLS ensures **encrypted + authenticated** communication.

```
Public Key  = Lock (share freely)
Private Key = Key  (keep secret)

Symmetric  = Same key for encrypt/decrypt (fast, but key sharing problem)
Asymmetric = Public/private key pair (solves key sharing)
```

```
Certificate file extensions:
.crt / .pem  → Certificate (public key)
.key         → Private key
```

---

## 49. TLS in Kubernetes

### 🔑 Key Concept
Every component communicates securely with TLS certificates. There are **server certs** and **client certs**.

```
Certificate Pairs:
┌─────────────────────────────────────────────────┐
│ kube-apiserver    → apiserver.crt / apiserver.key│
│ etcd              → etcd.crt / etcd.key          │
│ kubelet           → kubelet.crt / kubelet.key    │
│ CA                → ca.crt / ca.key              │
└─────────────────────────────────────────────────┘
```

---

## 50. TLS Certificate Creation

```bash
# Generate CA
openssl genrsa -out ca.key 2048
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt

# Generate API Server cert
openssl genrsa -out apiserver.key 2048
openssl req -new -key apiserver.key -subj "/CN=kube-apiserver" -out apiserver.csr
openssl x509 -req -in apiserver.csr -CA ca.crt -CAkey ca.key -out apiserver.crt
```

---

## 51. View Certificate Details

```bash
# View certificate details
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout

# Check: Issuer, Subject, Validity dates, Subject Alternative Names (SANs)
```

---

## 52. Certificates API

### 🔑 Key Concept
Kubernetes has a built-in Certificate API to approve/deny CSRs.

```bash
# User generates CSR and creates CertificateSigningRequest object
kubectl get csr
kubectl certificate approve jane   # Approve
kubectl certificate deny jane      # Deny
```

```yaml
# CertificateSigningRequest
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: jane
spec:
  request: <base64-encoded-CSR>
  signerName: kubernetes.io/kube-apiserver-client
  usages:
    - client auth
```

---

## 53. KubeConfig

### 🔑 Key Concept
File (`~/.kube/config`) that stores: **clusters**, **users**, **contexts** (cluster+user combo).

```bash
# View config
kubectl config view

# List contexts
kubectl config get-contexts

# Switch context
kubectl config use-context prod-user@production

# Use specific kubeconfig file
kubectl get pods --kubeconfig /path/to/custom-config
```

```yaml
# kubeconfig structure
apiVersion: v1
kind: Config
current-context: dev-user@dev-cluster    # Active context

clusters:
  - name: dev-cluster
    cluster:
      server: https://192.168.1.2:6443
      certificate-authority: /path/to/ca.crt

users:
  - name: dev-user
    user:
      client-certificate: /path/to/user.crt
      client-key: /path/to/user.key

contexts:
  - name: dev-user@dev-cluster
    context:
      cluster: dev-cluster      # Which cluster
      user: dev-user            # Which user
      namespace: development    # Optional default namespace
```

---

## 54. API Groups

### 🔑 Key Concept
Kubernetes APIs are organized into groups:

```
/api           → Core group (pods, nodes, services, namespaces)
/apis          → Named groups (apps, networking, storage, rbac...)

/apis/apps/v1/deployments
/apis/networking.k8s.io/v1/ingresses
/apis/rbac.authorization.k8s.io/v1/roles
```

```bash
# Browse API groups
kubectl proxy 8001 &
curl http://localhost:8001/apis
```

---

## 55. Authorization

### Authorization Modes

| Mode | Description |
|---|---|
| **Node** | Kubelets read/write node-related resources |
| **RBAC** | Role-based — most common for users |
| **ABAC** | Attribute-based — complex, not recommended |
| **Webhook** | External authorization (e.g., OPA) |
| **AlwaysAllow** | Allow everything — insecure |
| **AlwaysDeny** | Deny everything |

```bash
# Set in kube-apiserver
--authorization-mode=Node,RBAC,Webhook
# Multiple modes evaluated in ORDER — first allow/deny wins
```

---

## 56. Role-Based Access Control (RBAC)

### 🔑 Key Concept
- **Role** = what actions are allowed on which resources (namespace-scoped)
- **RoleBinding** = binds Role to a user/group/service-account

```yaml
# Role - what can be done
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer
  namespace: default
rules:
  - apiGroups: [""]           # "" = core API group
    resources: ["pods"]       # Which resources
    verbs: ["get", "list", "create", "delete"]  # What actions
  - apiGroups: ["apps"]
    resources: ["deployments"]
    verbs: ["get", "list"]
```

```yaml
# RoleBinding - who gets the role
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: dev-user-binding
  namespace: default
subjects:
  - kind: User            # User, Group, or ServiceAccount
    name: john
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: developer
  apiGroup: rbac.authorization.k8s.io
```

```bash
# Check permissions
kubectl auth can-i create pods
kubectl auth can-i create pods --as john
kubectl auth can-i create pods --as john --namespace test
```

---

## 57. Cluster Roles & ClusterRoleBindings

### 🔑 Key Concept
**ClusterRole** = cluster-wide scope (nodes, PVs, namespaces, etc.)

```yaml
# ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-admin
rules:
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get", "list", "create", "delete"]
---
# ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-admin-binding
subjects:
  - kind: User
    name: michelle
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
```

| Type | Scope |
|---|---|
| Role + RoleBinding | Namespace only |
| ClusterRole + ClusterRoleBinding | Cluster-wide |
| ClusterRole + RoleBinding | Namespace only (using ClusterRole) |

---

## 58. Service Accounts

### 🔑 Key Concept
**Service Accounts** are for **pods/applications** (not humans) to authenticate with the API server.

```bash
# Create service account
kubectl create serviceaccount myapp-sa

# View service accounts
kubectl get serviceaccounts

# View token
kubectl describe secret myapp-sa-token
```

```yaml
# Use service account in pod
spec:
  serviceAccountName: myapp-sa    # Assign SA to pod
  containers:
    - name: myapp
      image: myapp
```

> 💡 Since K8s 1.24, tokens are no longer auto-created as secrets. Use `kubectl create token myapp-sa` for temporary tokens.

---

## 59. Image Security

```yaml
# Private registry pull
spec:
  containers:
    - name: myapp
      image: private-registry.io/apps/myapp  # Full image path
  imagePullSecrets:
    - name: regcred    # Secret containing registry credentials
```

```bash
# Create docker registry secret
kubectl create secret docker-registry regcred \
  --docker-server=private-registry.io \
  --docker-username=myuser \
  --docker-password=mypassword \
  --docker-email=user@email.com
```

---

## 60. Security Contexts

### 🔑 Key Concept
Define security settings at **pod** or **container** level (container overrides pod).

```yaml
spec:
  securityContext:           # Pod-level security
    runAsUser: 1000          # Run as user ID 1000
    runAsGroup: 3000
    fsGroup: 2000
  containers:
    - name: myapp
      image: ubuntu
      securityContext:       # Container-level (overrides pod-level)
        runAsUser: 2000
        allowPrivilegeEscalation: false
        capabilities:        # Linux capabilities (container level only)
          add: ["NET_ADMIN", "SYS_TIME"]
```

---

## 61. Network Policies

### 🔑 Key Concept
By default, all pods can communicate freely. Network Policies **restrict** traffic.

```yaml
# Allow only pods with label role=frontend to connect to DB on port 3306
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-policy
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: db              # Apply to pods labeled role=db
  policyTypes:
    - Ingress               # Restrict incoming traffic
  ingress:
    - from:
        - podSelector:
            matchLabels:
              role: frontend  # Allow only from frontend pods
      ports:
        - protocol: TCP
          port: 3306
```

> ⚠️ **Network Policies require a supported CNI plugin** (Calico, Weave, Cilium). Flannel doesn't support it.

---

## 62. Custom Resource Definitions (CRDs)

### 🔑 Key Concept
Extend Kubernetes API with **your own resource types**.

```yaml
# Create custom resource type
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: flighttickets.flights.com
spec:
  group: flights.com
  names:
    kind: FlightTicket
    singular: flightticket
    plural: flighttickets
    shortNames:
      - ft
  scope: Namespaced
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
```

```bash
# After creating CRD, use it like any resource
kubectl get flighttickets
kubectl apply -f my-ticket.yaml
```

---

## 63. Custom Controllers

### 🔑 Key Concept
A controller watches for changes to custom resources and acts on them. Built as Go programs or using the controller-runtime framework.

---

## 64. Operator Framework

### 🔑 Key Concept
**Operator = CRD + Custom Controller** packaged together. Automates complex stateful application management.

Examples: etcd Operator, Prometheus Operator, PostgreSQL Operator.

---

## 65. Storage in Docker

### 🔑 Key Concept
Docker stores data in `/var/lib/docker` using **layered architecture**.

```
Image Layers (Read-Only):
  Layer 3: UPDATE entrypoint
  Layer 2: Source code
  Layer 1: apt packages
  Layer 0: Base Ubuntu

Container Layer (Read-Write):
  Your changes (lost when container deleted)
```

```bash
# Mount volume to persist data
docker run -v /data/mysql:/var/lib/mysql mysql

# Types:
# Volume mount:  docker run -v data_vol:/var/lib/mysql mysql
# Bind mount:    docker run -v /host/path:/container/path mysql
# --mount flag:  docker run --mount type=bind,source=/host,target=/container mysql
```

---

## 66. Volume Driver Plugins

Docker uses volume driver plugins for different storage backends:
- **local** (default)
- **Azure File Storage**
- **Convoy, Flocker, Portworx**, etc.

---

## 67. Container Storage Interface (CSI)

### 🔑 Key Concept
Standard interface for storage providers to write plugins. Replaces the old in-tree volume plugins.

```
CSI = Standard that says:
  "Implement these RPC calls: CreateVolume, DeleteVolume, etc."
```

Supported by: AWS EBS, GCP PD, Azure Disk, Portworx, etc.

---

## 68. Volumes in Kubernetes

```yaml
# Pod with volume
apiVersion: v1
kind: Pod
metadata:
  name: myapp
spec:
  containers:
    - name: myapp
      image: alpine
      volumeMounts:
        - mountPath: /opt        # Where to mount inside container
          name: data-volume
  volumes:
    - name: data-volume
      hostPath:                  # Use node's local directory
        path: /data
        type: Directory
```

---

## 69. Persistent Volumes (PV)

### 🔑 Key Concept
**Cluster-wide storage resource** defined by admins. Decouples storage from pods.

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-vol1
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce          # RWO: one node, RWM: many nodes, ROX: read-only many
  persistentVolumeReclaimPolicy: Retain  # Retain/Delete/Recycle
  hostPath:                  # Storage backend
    path: /data
```

---

## 70. Persistent Volume Claims (PVC)

### 🔑 Key Concept
**User request for storage**. Kubernetes binds PVC to matching PV.

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi    # Request 500MB
```

```yaml
# Use PVC in Pod
spec:
  containers:
    - name: myapp
      image: nginx
      volumeMounts:
        - mountPath: /var/www/html
          name: web-storage
  volumes:
    - name: web-storage
      persistentVolumeClaim:
        claimName: my-pvc    # Reference the PVC
```

```bash
kubectl get pv    # View PersistentVolumes
kubectl get pvc   # View PersistentVolumeClaims
```

---

## 71. Storage Classes

### 🔑 Key Concept
Enables **dynamic provisioning** — automatically creates PV when PVC is requested.

```yaml
# StorageClass definition
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard
provisioner: kubernetes.io/gce-pd   # Cloud provider provisioner
parameters:
  type: pd-standard
---
# PVC using StorageClass (no manual PV needed!)
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  storageClassName: standard   # Reference StorageClass
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

> 💡 StorageClass = **dynamic** PV provisioning. Without it, you need to manually create PVs.

---

# Part 4 — Networking, Troubleshooting & Cluster Installation

---

## 72. Linux Networking Basics

```bash
# View interfaces
ip link

# View IP addresses
ip addr

# Add IP to interface
ip addr add 192.168.1.10/24 dev eth0

# View routing table
route
ip route show

# Add route
ip route add 192.168.2.0/24 via 192.168.1.1

# Set default gateway
ip route add default via 192.168.1.1

# Enable IP forwarding (temporary)
echo 1 > /proc/sys/net/ipv4/ip_forward

# Enable permanently (in /etc/sysctl.conf)
net.ipv4.ip_forward = 1
```

---

## 73. DNS Prerequisites

```bash
# /etc/hosts — local name resolution
192.168.1.11    db
192.168.1.11    webserver

# /etc/resolv.conf — DNS server config
nameserver 8.8.8.8
search mycompany.com     # Appended to short names

# Resolution order in /etc/nsswitch.conf
hosts: files dns         # Check /etc/hosts first, then DNS

# Test DNS
nslookup www.google.com  # Query DNS (ignores /etc/hosts)
dig www.google.com       # Detailed DNS query
```

### DNS Record Types

| Type | Purpose |
|---|---|
| A | Hostname → IPv4 |
| AAAA | Hostname → IPv6 |
| CNAME | Alias → another hostname |

---

## 74. Network Namespaces

### 🔑 Key Concept
Containers use Linux **network namespaces** for isolation — each container gets its own network stack.

```bash
# Create namespace
ip netns add red
ip netns add blue

# List namespaces
ip netns

# Run command in namespace
ip netns exec red ip link
ip -n red link    # Shorthand

# Connect namespaces with virtual cable (veth pair)
ip link add veth-red type veth peer name veth-blue
ip link set veth-red netns red
ip link set veth-blue netns blue

# Assign IPs
ip -n red addr add 192.168.15.1/24 dev veth-red
ip -n blue addr add 192.168.15.2/24 dev veth-blue

# Bring up interfaces
ip -n red link set veth-red up
ip -n blue link set veth-blue up
```

---

## 75. Docker Networking

| Mode | Description |
|---|---|
| `none` | No network — isolated container |
| `host` | Shares host network — no isolation |
| `bridge` | Default — internal private network (docker0) |

```bash
# Port mapping
docker run -p 8080:80 nginx   # host:8080 → container:80

# Docker creates iptables NAT rules for port mapping
iptables -t nat -A PREROUTING -j DNAT --dport 8080 --to-destination 172.17.0.2:80
```

---

## 76. Cluster Networking

### Required Ports

| Port | Component | Direction |
|---|---|---|
| 6443 | API Server | Inbound |
| 10250 | Kubelet | Inbound |
| 10259 | Scheduler | Inbound |
| 10257 | Controller Manager | Inbound |
| 2379-2380 | ETCD | Inbound |
| 30000-32767 | NodePort Services | Inbound |

---

## 77. Pod Networking

### 🔑 Key Concept
Every pod needs a unique IP, and all pods must communicate without NAT.

```
Requirements:
✓ Each pod gets unique IP
✓ All pods on same node can communicate
✓ All pods across nodes can communicate (no NAT)
```

**How it works:**
1. Each node gets a bridge network
2. Pods connect to bridge via veth pairs
3. Routes added for cross-node communication

---

## 78. CNI in Kubernetes

### 🔑 Key Concept
**CNI (Container Network Interface)** = standard for how container runtimes configure networking.

```bash
# CNI plugin binaries location
ls /opt/cni/bin
# bridge, flannel, weave-net, calico, etc.

# CNI configuration files
ls /etc/cni/net.d
# 10-bridge.conf  (alphabetically first = selected)
```

```json
// Example CNI config (/etc/cni/net.d/10-bridge.conf)
{
  "cniVersion": "0.2.0",
  "name": "mynet",
  "type": "bridge",
  "bridge": "cni0",
  "isGateway": true,
  "ipMasq": true,
  "ipam": {
    "type": "host-local",
    "subnet": "10.22.0.0/16"
  }
}
```

---

## 79. Service Networking

### 🔑 Key Concept
Services get a virtual **ClusterIP** from `--service-cluster-ip-range`. kube-proxy creates iptables rules on every node.

```bash
# View service cluster IP range
ps -aux | grep kube-apiserver | grep service-cluster-ip-range

# View iptables rules created by kube-proxy
iptables -L -t nat | grep myapp-service

# kube-proxy mode
cat /var/log/kube-proxy.log
```

---

## 80. DNS in Kubernetes

### DNS Format
```
servicename.namespace.svc.cluster.local

# Examples:
web-service                           # Same namespace
web-service.apps                      # Cross-namespace
web-service.apps.svc.cluster.local    # FQDN

# Pod DNS (replace dots with dashes in IP):
10-244-2-5.default.pod.cluster.local
```

---

## 81. CoreDNS in Kubernetes

### 🔑 Key Concept
CoreDNS runs as a **Deployment** (2 replicas) in kube-system. All pods use it via kube-dns Service (10.96.0.10).

```bash
# View CoreDNS pods
kubectl get pods -n kube-system | grep coredns

# View CoreDNS ConfigMap
kubectl get configmap coredns -n kube-system -o yaml

# Pod's DNS config set by kubelet
cat /var/lib/kubelet/config.yaml | grep clusterDNS
```

---

## 82. Ingress

### 🔑 Key Concept
Single entry point for cluster. Handles URL routing, SSL, load balancing. Needs an **Ingress Controller** deployed.

```yaml
# Simple Ingress with path-based routing
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myapp-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - host: myapp.com
      http:
        paths:
          - path: /wear
            pathType: Prefix
            backend:
              service:
                name: wear-service
                port:
                  number: 80
          - path: /watch
            pathType: Prefix
            backend:
              service:
                name: watch-service
                port:
                  number: 80
```

```bash
kubectl get ingress
kubectl describe ingress myapp-ingress
```

> ⚠️ Ingress controller must be deployed separately (nginx-ingress, traefik, etc.)

---

## 83. Gateway API

### 🔑 Key Concept
Next-gen replacement for Ingress. Supports TCP/UDP/gRPC, better multi-tenancy, no annotations needed.

```yaml
# 3 objects: GatewayClass → Gateway → HTTPRoute
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: myapp-route
spec:
  parentRefs:
    - name: my-gateway     # Which gateway to attach to
  hostnames:
    - "myapp.com"
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /api
      backendRefs:
        - name: api-service
          port: 80
          weight: 100
```

| Feature | Ingress | Gateway API |
|---|---|---|
| Protocols | HTTP/HTTPS only | HTTP, TCP, UDP, gRPC |
| Multi-tenancy | One resource, coordinated | Separate roles |
| Configuration | Annotations (controller-specific) | Native YAML (portable) |
| Traffic splitting | Via annotations | Native `weight` field |

---

## 84. Application Failure Troubleshooting

```bash
# Step 1: Test the application endpoint
curl http://web-service-ip:nodePort

# Step 2: Check service
kubectl describe service web-service
# Look at: Endpoints (should not be empty)

# Step 3: Check pod status
kubectl get pods
kubectl describe pod web-pod
# Look at: Status, Events section

# Step 4: Check logs
kubectl logs web-pod
kubectl logs web-pod -f          # Stream
kubectl logs web-pod --previous  # Previous container logs

# Step 5: Check dependent services (DB, etc.)
kubectl get svc
kubectl describe svc db-service
```

---

## 85. Control Plane Failure Troubleshooting

```bash
# Check nodes
kubectl get nodes

# Check control plane pods (kubeadm)
kubectl get pods -n kube-system

# Check system services (non-kubeadm)
service kube-apiserver status
service kube-controller-manager status
service kube-scheduler status

# View logs
kubectl logs kube-apiserver-master -n kube-system
sudo journalctl -u kube-apiserver    # For service-based setup
```

---

## 86. Worker Node Failure Troubleshooting

```bash
# Check node status
kubectl get nodes
kubectl describe node worker-1
# Look at: Conditions (OutOfDisk, MemoryPressure, DiskPressure, Ready)

# SSH to worker node and check
service kubelet status
sudo journalctl -u kubelet          # Kubelet logs

# Check kubelet certificate
openssl x509 -in /var/lib/kubelet/worker-1.crt -text
# Verify: Issuer (should be Kubernetes CA), Validity dates

# Restart kubelet
sudo systemctl restart kubelet
```

**Node Condition Flags:**

| Condition | True = Problem |
|---|---|
| OutOfDisk | Disk full |
| MemoryPressure | Low memory |
| DiskPressure | Low disk space |
| PIDPressure | Too many processes |
| Ready | False = Node not healthy |

---

## 87. Choosing Kubernetes Infrastructure

| Environment | Options |
|---|---|
| **Local/Dev** | Minikube (1 node), kubeadm (multi-node) |
| **On-Premises** | kubeadm, OpenShift, Rancher |
| **Cloud Managed** | GKE, EKS, AKS |
| **Cloud Turnkey** | KOPS on AWS |

---

## 88. ETCD in HA

### 🔑 Key Concept
Use **odd number** of nodes (3, 5, 7). Needs quorum to accept writes.

```
Quorum formula: (N/2) + 1

3 nodes → quorum = 2 (tolerates 1 failure)
5 nodes → quorum = 3 (tolerates 2 failures)
```

**Raft consensus:** Nodes elect a leader. Leader handles writes and replicates to followers. New election if leader fails.

```bash
# Configure ETCD cluster (initial-cluster parameter)
--initial-cluster peer-1=https://10.0.0.1:2380,peer-2=https://10.0.0.2:2380
```

---

## 89. Demo: Cluster Deployment with kubeadm

```bash
# All nodes: Install ContainerD
apt-get install -y containerd
mkdir -p /etc/containerd
containerd config default | sed 's/SystemdCgroup = false/SystemdCgroup = true/' \
  | tee /etc/containerd/config.toml
systemctl restart containerd

# All nodes: Install kubernetes components
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# Master only: Initialize cluster
kubeadm init \
  --apiserver-advertise-address=192.168.56.11 \
  --pod-network-cidr=10.244.0.0/16

# Master: Setup kubectl
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

# Master: Install network plugin
kubectl apply -f https://github.com/flannel-io/flannel/releases/.../kube-flannel.yml

# Worker nodes: Join cluster (use token from kubeadm init output)
kubeadm join 192.168.56.11:6443 \
  --token <token> \
  --discovery-token-ca-cert-hash sha256:<hash>

# Verify
kubectl get nodes
```

---

# Part 5 — Helm, Kustomize & kubeadm

---

## 90. Installing Helm

```bash
# Via Snap
sudo snap install helm --classic

# Via APT (Ubuntu/Debian)
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | \
  sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update && sudo apt-get install helm

# Verify
helm version
```

---

## 91. Helm 2 vs Helm 3

| Feature | Helm 2 | Helm 3 |
|---|---|---|
| **Tiller** | Required (server-side) | Removed ✅ |
| **Security** | Tiller ran with "God mode" | Uses Kubernetes RBAC |
| **Rollback** | Basic revision comparison | 3-way strategic merge patch |
| **Architecture** | CLI → Tiller → K8s | CLI → K8s directly |

> 💡 **3-way merge** in Helm 3: Compares previous revision + current revision + live state → properly handles manual `kubectl` changes.

---

## 92. Helm Components

```
┌─────────────────────────────────────────────┐
│  Chart (collection of templates)             │
│  + values.yaml                               │
│          ↓                                   │
│  helm install → Release (deployed instance)  │
│                                              │
│  Metadata stored as Secrets in K8s cluster   │
└─────────────────────────────────────────────┘
```

| Component | Description |
|---|---|
| **Chart** | Package of K8s resource templates |
| **Release** | Deployed instance of a chart |
| **Revision** | Version of a release (increments on upgrade) |
| **Repository** | Collection of charts |
| **values.yaml** | Default configuration values |
| **Chart.yaml** | Chart metadata (name, version, description) |

---

## 93. Helm Charts

### Chart Directory Structure
```
mychart/
├── Chart.yaml        # Chart metadata
├── values.yaml       # Default values
├── charts/           # Dependency charts
└── templates/        # Kubernetes manifest templates
    ├── deployment.yaml
    ├── service.yaml
    └── _helpers.tpl
```

```yaml
# Chart.yaml
apiVersion: v2
name: wordpress
description: Blog platform
type: application       # application or library
version: 12.1.27        # Chart version
appVersion: "5.8.1"     # App version inside chart
dependencies:
  - name: mariadb
    version: 9.x.x
    repository: https://charts.bitnami.com/bitnami
```

```yaml
# Template with values substitution
spec:
  replicas: {{ .Values.replicaCount }}   # From values.yaml
  containers:
    - name: wordpress
      image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
```

---

## 94. Working with Helm Basics

```bash
# Add repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# Search for charts
helm search hub wordpress          # Search Artifact Hub
helm search repo wordpress         # Search local repos

# Update repo cache
helm repo update

# Install chart
helm install my-release bitnami/wordpress

# List releases
helm list

# Uninstall
helm uninstall my-release

# List repos
helm repo list
```

---

## 95. Customizing Chart Parameters

```bash
# Method 1: --set flag
helm install my-release bitnami/wordpress \
  --set wordpressBlogName="My Blog" \
  --set wordpressEmail="user@example.com"

# Method 2: Custom values file
helm install my-release bitnami/wordpress \
  --values custom-values.yaml

# Method 3: Pull and modify chart
helm pull --untar bitnami/wordpress   # Downloads + extracts
# Edit wordpress/values.yaml
helm install my-release ./wordpress   # Install from local dir
```

---

## 96. Helm Lifecycle Management

```bash
# Install specific version
helm install nginx-release bitnami/nginx --version 7.1.0

# Upgrade release
helm upgrade nginx-release bitnami/nginx

# View history
helm history nginx-release

# Rollback to revision 1
helm rollback nginx-release 1

# Check release status
helm status nginx-release
```

> ⚠️ **Rollback restores K8s manifest config only** — not database data or persistent volumes!

---

## 97. Kustomize vs Helm

| Feature | Helm | Kustomize |
|---|---|---|
| **Templating** | Go templates ({{ }}) | Plain YAML overlays |
| **Package management** | ✅ Full package manager | ❌ Config management only |
| **Learning curve** | Steeper | Simpler |
| **Readability** | Templates are hard to read | Plain YAML — easy to read |
| **Built into kubectl** | No (separate install) | ✅ Yes (`kubectl apply -k`) |
| **Loops/conditions** | ✅ Yes | ❌ No |

---

## 98. Installing Kustomize

```bash
# Via install script
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash

# Verify
kustomize version --short
```

---

## 99. Kustomize Output & Deployment

```bash
# Build (preview output — does NOT deploy)
kustomize build k8s/

# Deploy using kustomize pipe
kustomize build k8s/ | kubectl apply -f -

# Deploy using kubectl native Kustomize support (-k flag)
kubectl apply -k k8s/

# Delete resources
kustomize build k8s/ | kubectl delete -f -
kubectl delete -k k8s/
```

### Minimal kustomization.yaml
```yaml
# k8s/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - deployment.yaml    # List all resources to manage
  - service.yaml
```

---

## 100. Managing Directories with Kustomize

```bash
k8s/
├── kustomization.yaml    # Root - references subdirs
├── api/
│   ├── kustomization.yaml
│   ├── deployment.yaml
│   └── service.yaml
└── db/
    ├── kustomization.yaml
    ├── deployment.yaml
    └── service.yaml
```

```yaml
# k8s/kustomization.yaml (root)
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - api/    # References api/kustomization.yaml
  - db/     # References db/kustomization.yaml
```

```yaml
# k8s/api/kustomization.yaml (subdirectory)
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - deployment.yaml
  - service.yaml
```

---

## 101. Common Transformers

```yaml
# kustomization.yaml with transformers
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - deployment.yaml

# Add labels to ALL resources
commonLabels:
  org: KodeKloud
  env: production

# Add namespace to ALL resources
namespace: production

# Add prefix/suffix to ALL resource names
namePrefix: prod-
nameSuffix: -v2

# Add annotations to ALL resources
commonAnnotations:
  branch: main
  team: devops
```

---

## 102. Image Transformers

```yaml
# kustomization.yaml
images:
  - name: nginx              # Image to replace
    newName: haproxy         # New image name
    newTag: "2.4"            # New tag (use quotes for numbers!)

# Result: nginx → haproxy:2.4 in all resources
```

---

## 103. Patches: Introduction & Types

### 🔑 Key Concept
Patches allow **targeted modifications** to specific resources (vs transformers which apply globally).

**Two patch methods:**
1. **JSON 6902 Patch** — list of operations (add, remove, replace)
2. **Strategic Merge Patch** — partial K8s YAML that gets merged

**Two patch locations:**
1. **Inline** — patch inside kustomization.yaml
2. **Separate file** — patch in external YAML file

---

## 104. Patching Dictionaries

```yaml
# kustomization.yaml
patches:
  # JSON 6902 - Replace a label value
  - target:
      kind: Deployment
      name: api-deployment
    patch: |-
      - op: replace
        path: /spec/template/metadata/labels/component
        value: web

  # JSON 6902 - Add new label
  - target:
      kind: Deployment
      name: api-deployment
    patch: |-
      - op: add
        path: /spec/template/metadata/labels/org
        value: KodeKloud

  # JSON 6902 - Remove a label
  - target:
      kind: Deployment
      name: api-deployment
    patch: |-
      - op: remove
        path: /spec/template/metadata/labels/org
```

```yaml
# Strategic Merge Patch (in separate file label-patch.yaml)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-deployment
spec:
  template:
    metadata:
      labels:
        org: null     # null = remove this key
        component: web  # update this key
```

---

## 105. Patching Lists

```yaml
# JSON 6902 - Replace container at index 0
patches:
  - target:
      kind: Deployment
      name: api-deployment
    patch: |-
      - op: replace
        path: /spec/template/spec/containers/0   # Index 0 = first container
        value:
          name: haproxy
          image: haproxy

  # Add new container at end (- means append)
  - target:
      kind: Deployment
      name: api-deployment
    patch: |-
      - op: add
        path: /spec/template/spec/containers/-   # - means append
        value:
          name: sidecar
          image: busybox

  # Remove container at index 1
  - target:
      kind: Deployment
      name: api-deployment
    patch: |-
      - op: remove
        path: /spec/template/spec/containers/1
```

```yaml
# Strategic Merge Patch - delete container by name
# label-patch.yaml
spec:
  template:
    spec:
      containers:
        - $patch: delete    # Special directive to delete
          name: database    # Identifies container to delete
```

---

## 106. Overlays

### 🔑 Key Concept
Overlays customize base configuration for different environments (dev, staging, prod).

```
k8s/
├── base/                        # Shared configs
│   ├── kustomization.yaml
│   ├── nginx-deployment.yaml
│   └── service.yaml
└── overlays/
    ├── dev/
    │   └── kustomization.yaml   # References base + dev patches
    ├── staging/
    │   └── kustomization.yaml
    └── prod/
        ├── kustomization.yaml
        └── grafana-deployment.yaml  # Prod-only resource
```

```yaml
# overlays/dev/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - ../../base               # Reference base directory
patches:
  - target:
      kind: Deployment
      name: nginx-deployment
    patch: |-
      - op: replace
        path: /spec/replicas
        value: 1             # Dev: 1 replica
```

```yaml
# overlays/prod/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - ../../base
resources:
  - grafana-deployment.yaml  # Add prod-only resource
patches:
  - target:
      kind: Deployment
      name: nginx-deployment
    patch: |-
      - op: replace
        path: /spec/replicas
        value: 5             # Prod: 5 replicas
```

```bash
# Deploy specific environment
kubectl apply -k overlays/prod/
kubectl apply -k overlays/dev/
```

---

## 107. Kustomize Components

### 🔑 Key Concept
**Components** = reusable configuration blocks for **optional features** shared across some (not all) overlays.

```
Problem: Caching needed in Premium + Self-Hosted but NOT in Dev
Solution: Create caching component, import only where needed
```

```
k8s/
├── base/
├── components/
│   ├── caching/             # Optional caching feature
│   │   ├── kustomization.yaml
│   │   ├── redis-deployment.yaml
│   │   └── deployment-patch.yaml
│   └── db/                  # Optional external DB feature
│       ├── kustomization.yaml
│       ├── postgres-deployment.yaml
│       └── deployment-patch.yaml
└── overlays/
    ├── dev/                 # Dev: no caching, uses DB
    ├── premium/             # Premium: caching + DB
    └── self-hosted/         # Self-hosted: caching only
```

```yaml
# components/caching/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1alpha1
kind: Component                # NOTE: Kind is Component, not Kustomization
resources:
  - redis-deployment.yaml
patches:
  - deployment-patch.yaml
```

```yaml
# overlays/premium/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - ../../base
components:
  - ../../components/caching  # Import caching component
  - ../../components/db       # Import db component
```

---

# 💬 Interview Questions & Answers

## Part 1 — Core Concepts & Scheduling

**Q1: What is the difference between a Pod and a Container?**
> A Container is the actual running process (Docker/OCI container). A Pod is the smallest Kubernetes unit that wraps one or more containers and provides shared network/storage. Pods are ephemeral; containers run inside them.

**Q2: What does the Kube Scheduler do? Does it create pods?**
> The Scheduler **decides which node** a pod should run on based on resource requirements, taints, affinity rules. It does NOT create pods — the **Kubelet** creates them after the Scheduler assigns a node.

**Q3: What is ETCD and what does it store?**
> ETCD is a distributed key-value store that stores the entire cluster state: nodes, pods, services, configs, secrets, roles, etc. All `kubectl get` commands read from ETCD.

**Q4: What happens if the kube-apiserver goes down?**
> Running workloads continue (kubelet still manages pods). But no new operations possible — can't create/update/delete resources. It's the single point of control plane access.

**Q5: Difference between ReplicaSet and Deployment?**
> A ReplicaSet ensures N pod replicas are running. A Deployment wraps ReplicaSet and adds rolling updates, rollbacks, pause/resume. Use Deployments — they manage ReplicaSets automatically.

**Q6: What are the three service types and when to use each?**
> - **ClusterIP**: Internal only (default). Pod-to-pod communication.
> - **NodePort**: Exposes on node port 30000-32767. Good for dev/test external access.
> - **LoadBalancer**: Cloud LB for production external access.

**Q7: What is the difference between Taints/Tolerations and Node Affinity?**
> Taints on nodes repel pods (unless they have tolerations). Node Affinity on pods attracts them to specific nodes. Combined, they give you precise control: Affinity ensures pod goes to right node, Taints prevent other pods from landing there.

**Q8: What is a DaemonSet?**
> Ensures exactly one pod runs on every node. Auto-deploys to new nodes. Used for monitoring, logging, network plugins, kube-proxy.

**Q9: What is a Static Pod? How is it different from a regular pod?**
> Static Pods are managed directly by Kubelet (not API Server). Kubelet reads definition files from `/etc/kubernetes/manifests/`. Control plane components (API Server, ETCD) are static pods. You can't `kubectl delete` them — remove the file instead.

**Q10: What are Admission Controllers?**
> Plugins that intercept API Server requests after auth but before object creation. Can validate (approve/deny) or mutate (modify) requests. Examples: NamespaceLifecycle, LimitRanger, MutatingAdmissionWebhook.

---

## Part 2 — Logging, Monitoring & Lifecycle

**Q11: How do you troubleshoot a pod that keeps crashing?**
> 1. `kubectl describe pod <pod>` — check Events section
> 2. `kubectl logs <pod> --previous` — see last crash logs
> 3. Check resource limits, image name, env vars
> 4. Check if dependencies (DB, secret) are available

**Q12: What is the difference between `RollingUpdate` and `Recreate` deployment strategies?**
> **Recreate**: Kills all old pods first, then creates new ones (causes downtime). **RollingUpdate** (default): Replaces pods incrementally — no downtime. Configurable with `maxSurge` and `maxUnavailable`.

**Q13: How are Secrets different from ConfigMaps?**
> ConfigMaps store non-sensitive config data as plain text. Secrets store sensitive data (passwords, tokens) as base64-encoded strings. By default, both are stored unencrypted in ETCD — enable encryption at rest for Secrets in production.

**Q14: What happens during `kubectl rollout undo`?**
> Helm 3 uses a 3-way merge: compares previous chart revision, desired state, and live state. Kubernetes creates a new revision (not overwrites). The previous ReplicaSet is scaled back up while the current one scales down.

**Q15: How do you perform a cluster upgrade with zero downtime?**
> 1. Upgrade master first (workers still serve traffic)
> 2. Drain workers one by one (`kubectl drain`)
> 3. Upgrade kubelet/kubeadm on drained node
> 4. Uncordon (`kubectl uncordon`)
> 5. Repeat for each worker

---

## Part 3 — Security & Storage

**Q16: What is RBAC and how does it work?**
> Role-Based Access Control. Admin creates Roles (define what actions on what resources) and RoleBindings (bind roles to users/groups/service accounts). For cluster-wide resources, use ClusterRole + ClusterRoleBinding.

**Q17: What is a Service Account? How is it different from a user?**
> Service Accounts are for pods/applications, not humans. They're Kubernetes objects with auto-mounted tokens. Users are external identities authenticated via certificates or OIDC. `kubectl get sa` works; `kubectl get user` doesn't — users aren't K8s objects.

**Q18: What is the difference between PV and PVC?**
> PV (PersistentVolume) = Cluster-wide storage resource created by admins. PVC (PersistentVolumeClaim) = User request for storage. Kubernetes binds PVCs to matching PVs. StorageClass enables dynamic PV creation.

**Q19: What is a NetworkPolicy? Are they enabled by default?**
> By default, all pods can talk to all pods (no restrictions). NetworkPolicy objects restrict ingress/egress. **They require a CNI plugin that supports them** (Calico, Cilium, Weave). Flannel does NOT support NetworkPolicies.

**Q20: Why shouldn't you store Secrets in Git?**
> Secrets are only base64-encoded (not encrypted). Anyone can decode them with `echo <value> | base64 --decode`. Use external secret managers (AWS Secrets Manager, Vault) or enable encryption at rest + strict RBAC.

---

## Part 4 — Networking & Troubleshooting

**Q21: How does DNS work in Kubernetes?**
> CoreDNS runs as a deployment in kube-system. All pods have `/etc/resolv.conf` pointing to CoreDNS. Services get DNS records: `svc-name.namespace.svc.cluster.local`. Pods get records using dashed IP: `10-244-2-5.ns.pod.cluster.local`.

**Q22: What is CNI? Why is it needed?**
> Container Network Interface = standard spec for how container runtimes configure networking. Without CNI, pods would have no network connectivity. K8s delegates all pod networking to the installed CNI plugin (Flannel, Calico, Weave, etc.).

**Q23: How do you debug a node in NotReady state?**
> 1. `kubectl describe node <node>` — check Conditions
> 2. SSH to node: `service kubelet status`
> 3. `journalctl -u kubelet` — check kubelet logs
> 4. Check certificate validity
> 5. Check disk/memory/network on node

**Q24: What is the difference between Ingress and a LoadBalancer Service?**
> LoadBalancer Service: cloud provisions an external LB per service (expensive at scale). Ingress: single external entry point, routes to multiple services based on hostname/path rules, handles SSL termination. More efficient for multiple services.

**Q25: What is the ETCD quorum requirement? Why use odd numbers of nodes?**
> Quorum = (N/2) + 1. A 3-node cluster needs 2 for quorum (tolerates 1 failure). Odd numbers are preferred because even-numbered clusters can split evenly during network partitions — neither side reaches quorum and the cluster freezes.

---

## Part 5 — Helm & Kustomize

**Q26: What is Helm and why use it?**
> Helm is a Kubernetes package manager. Charts package related K8s resources with templating. Releases track deployments. Benefits: install complex apps with one command, reuse community charts, version-controlled upgrades/rollbacks.

**Q27: What is the main difference between Helm 2 and Helm 3?**
> Helm 3 removed Tiller (a server-side component with excessive privileges). Helm 3 communicates directly with K8s using standard RBAC. Also added 3-way strategic merge for better rollbacks.

**Q28: When would you choose Kustomize over Helm?**
> Kustomize when: you want pure YAML (no templating), need built-in `kubectl` support, managing environment-specific overlays for in-house apps. Helm when: packaging for distribution, complex logic needed (loops/conditionals), using community charts.

**Q29: What is the difference between a Kustomize Overlay and a Component?**
> **Overlay** = environment-specific customization that references a base (dev, staging, prod). **Component** = reusable optional feature that can be included by multiple overlays (e.g., caching feature added to only Premium + Self-hosted environments).

**Q30: How does `kubectl apply -k` work?**
> It reads `kustomization.yaml` in the specified directory, processes all resources through transformers/patches, and applies the final output to the cluster. Equivalent to `kustomize build . | kubectl apply -f -`.

---

## ⚡ Quick Command Reference Card

```bash
# Pods
kubectl run nginx --image=nginx
kubectl get pods -o wide
kubectl describe pod nginx
kubectl logs -f nginx
kubectl exec -it nginx -- /bin/bash
kubectl delete pod nginx

# Deployments
kubectl create deploy myapp --image=nginx --replicas=3
kubectl scale deploy myapp --replicas=5
kubectl set image deploy/myapp nginx=nginx:1.21
kubectl rollout status deploy/myapp
kubectl rollout undo deploy/myapp

# Services
kubectl expose deploy myapp --port=80 --type=NodePort
kubectl get svc
kubectl describe svc myapp

# Namespaces
kubectl create ns dev
kubectl get pods -n kube-system
kubectl config set-context --current --namespace=dev

# RBAC
kubectl auth can-i create pods
kubectl auth can-i create pods --as john

# Nodes
kubectl get nodes
kubectl describe node node01
kubectl drain node01 --ignore-daemonsets
kubectl uncordon node01
kubectl cordon node01
kubectl taint nodes node01 key=val:NoSchedule

# Generate YAML (dry-run trick)
kubectl run nginx --image=nginx --dry-run=client -o yaml
kubectl create deploy myapp --image=nginx --dry-run=client -o yaml

# ETCD backup
ETCDCTL_API=3 etcdctl snapshot save /backup/snap.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key

# Helm
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-release bitnami/nginx
helm list
helm upgrade my-release bitnami/nginx
helm rollback my-release 1
helm uninstall my-release

# Kustomize
kustomize build k8s/
kubectl apply -k k8s/
kubectl delete -k k8s/
```

---

> ✅ **Study Tip:** The CKA exam is **hands-on** — practice creating and debugging resources in a real cluster. Focus on speed with `kubectl`, knowing common flags, and reading documentation at `kubernetes.io/docs`.
