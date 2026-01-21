# Kubernetes Imperative Commands - Complete Guide

## 📚 Table of Contents
1. [All Commands with Explanations](#all-commands-with-explanations)
2. [YAML Generation with Dry-Run](#yaml-generation-with-dry-run)
3. [Verification Commands](#verification-commands)
4. [Key Concepts](#key-concepts)
5. [Summary Tables](#summary-tables)
6. [Practice Exercises](#practice-exercises)
7. [Command Cheat Sheet](#command-cheat-sheet)
8. [Pro Tips](#pro-tips)

---

## 📋 All Commands with Explanations

### 1. Deploying an Nginx Pod

**Command:**
```bash
kubectl run nginx-pod --image=nginx: alpine
```

**What it does:**
- Creates a pod named `nginx-pod`
- Uses the `nginx:alpine` image (Alpine Linux-based, lightweight version)
- Pod runs in the `default` namespace

**Expected Output:**
```
pod/nginx-pod created
```

**Generate YAML:**
```bash
kubectl run nginx-pod --image=nginx:alpine --dry-run=client -o yaml > nginx-pod.yaml
```

---

### 2. Deploying a Redis Pod with Labels

**Command:**
```bash
kubectl run redis --image=redis:alpine --labels=tier=db
```

**What it does:**
- Creates a pod named `redis`
- Uses the `redis:alpine` image
- Assigns a label `tier=db` to the pod
- Labels help in selecting and organizing pods (useful for services, queries, etc.)

**Expected Output:**
```
pod/redis created
```

**Generate YAML:**
```bash
kubectl run redis --image=redis:alpine --labels=tier=db --dry-run=client -o yaml > redis-pod. yaml
```

**Why labels matter:**
- Services use labels to select which pods to route traffic to
- You can filter resources using labels:  `kubectl get pods -l tier=db`

---

### 3. Creating a Redis Service

**Command:**
```bash
kubectl expose pod redis --port=6379 --name=redis-service
```

**What it does:**
- Creates a ClusterIP service named `redis-service`
- Exposes the `redis` pod on port `6379` (default Redis port)
- Automatically detects pod labels (`tier=db`) and uses them as service selectors
- Service acts as a stable endpoint for the pod (even if pod IP changes)

**Expected Output:**
```
service/redis-service exposed
```

**Verify:**
```bash
kubectl get svc
```

**Sample Output:**
```
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
redis-service   ClusterIP   10.43.56.187    <none>        6379/TCP   6m35s
```

**Generate YAML:**
```bash
kubectl expose pod redis --port=6379 --name=redis-service --dry-run=client -o yaml > redis-service.yaml
```

---

### 4. Creating a Deployment for a Web Application

**Command:**
```bash
kubectl create deployment webapp --image=kodekloud/webapp-color --replicas=3
```

**What it does:**
- Creates a deployment named `webapp`
- Uses the `kodekloud/webapp-color` image
- Scales to **3 replicas** (3 identical pods)
- Deployment ensures the desired number of pods are always running
- Provides rolling updates and rollback capabilities

**Expected Output:**
```
deployment.apps/webapp created
```

**Verify:**
```bash
kubectl get deployment
kubectl get pods
```

**Sample Output:**
```
NAME                       READY   STATUS    RESTARTS   AGE
webapp-7b59bf687d-n7xxp    1/1     Running   0          5m4s
webapp-7b59bf687d-rds95    1/1     Running   0          5m4s
webapp-7b59bf687d-4gqmt    1/1     Running   0          5m4s
```

**Generate YAML:**
```bash
kubectl create deployment webapp --image=kodekloud/webapp-color --replicas=3 --dry-run=client -o yaml > webapp-deployment.yaml
```

**Important Note:**
- Use double dashes:  `--replicas` (not `-replicas`)
- `kubectl run` does NOT support `--replicas` (use `kubectl create deployment` instead)

---

### 5. Creating a Custom Nginx Pod with a Specific Port

**Command:**
```bash
kubectl run custom-nginx --image=nginx --port=8080
```

**What it does:**
- Creates a pod named `custom-nginx`
- Uses the `nginx` image (latest version)
- Specifies container port `8080` in the pod specification
- **Note:** This sets the `containerPort` in metadata, but doesn't change nginx's actual listening port (nginx still listens on 80 by default)

**Expected Output:**
```
pod/custom-nginx created
```

**Check Configuration:**
```bash
kubectl describe pod custom-nginx
```

**Look for:**
```
Containers:
  custom-nginx:
    Port: 8080/TCP
```

**Generate YAML:**
```bash
kubectl run custom-nginx --image=nginx --port=8080 --dry-run=client -o yaml > custom-nginx.yaml
```

---

### 6. Creating a New Namespace

**Command:**
```bash
kubectl create namespace dev-ns
```

**What it does:**
- Creates a new namespace called `dev-ns`
- Namespaces provide isolation and organization for resources
- Useful for separating environments (dev, staging, prod)
- Resources in one namespace are isolated from another

**Expected Output:**
```
namespace/dev-ns created
```

**Verify:**
```bash
kubectl get namespaces
kubectl get ns
```

**Generate YAML:**
```bash
kubectl create namespace dev-ns --dry-run=client -o yaml > dev-ns.yaml
```

---

### 7. Creating a Redis Deployment in the "dev-ns" Namespace

**Command:**
```bash
kubectl create deployment redis-deploy --image=redis --replicas=2 -n dev-ns
```

**What it does:**
- Creates a deployment named `redis-deploy`
- Uses the `redis` image (latest version)
- Scales to **2 replicas**
- Deploys in the `dev-ns` namespace (not default)

**Expected Output:**
```
deployment.apps/redis-deploy created
```

**Verify:**
```bash
kubectl get deployment -n dev-ns
```

**Expected Output:**
```
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
redis-deploy   2/2     2            2           12s
```

**Check Pods:**
```bash
kubectl get pods -n dev-ns
```

**Generate YAML:**
```bash
kubectl create deployment redis-deploy --image=redis --replicas=2 -n dev-ns --dry-run=client -o yaml > redis-deploy.yaml
```

---

### 8. Creating a Pod and Exposing It as a Service in a Single Command

**Command:**
```bash
kubectl run httpd --image=httpd:alpine --port=80 --expose
```

**What it does:**
- Creates a pod named `httpd`
- Uses the `httpd:alpine` image (Apache web server)
- Sets container port to `80`
- **Automatically creates** a ClusterIP service also named `httpd`
- Service exposes the pod on port 80
- **All in one command! **

**Expected Output:**
```
service/httpd created
pod/httpd created
```

**Verify Pod:**
```bash
kubectl get pod
```

**Sample Output:**
```
NAME    READY   STATUS    RESTARTS   AGE
httpd   1/1     Running   0          8s
```

**Verify Service:**
```bash
kubectl get svc
```

**Sample Output:**
```
NAME    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
httpd   ClusterIP   10.43.112.233   <none>        80/TCP    15s
```

**Describe Service:**
```bash
kubectl describe svc httpd
```

**Detailed Output:**
```
Name:              httpd
Namespace:         default
Labels:            <none>
Annotations:       <none>
Selector:          run=httpd
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.43.112.233
IPs:               10.43.112.233
Port:              <unset> 80/TCP
TargetPort:        80/TCP
Endpoints:         10.0.2.17:80
Session Affinity:   None
Events:            <none>
```

**Generate YAML (Pod only):**
```bash
kubectl run httpd --image=httpd:alpine --port=80 --dry-run=client -o yaml > httpd-pod.yaml
```

**Note:** The `--expose` flag doesn't work with `--dry-run`. To get service YAML: 
```bash
# First create the resources
kubectl run httpd --image=httpd:alpine --port=80 --expose

# Extract service YAML
kubectl get svc httpd -o yaml > httpd-service.yaml

# Clean up if needed
kubectl delete pod httpd
kubectl delete svc httpd
```

---

## 🎯 YAML Generation with Dry-Run

### What is --dry-run=client? 
- **Simulates** the command without actually creating resources
- **Validates** the command syntax
- **Generates** YAML output when combined with `-o yaml`
- **Safe** to use - doesn't modify cluster state

### Complete List of YAML Generation Commands

| # | Resource | Command |
|---|----------|---------|
| 1 | Nginx Pod | `kubectl run nginx-pod --image=nginx:alpine --dry-run=client -o yaml > nginx-pod.yaml` |
| 2 | Redis Pod | `kubectl run redis --image=redis:alpine --labels=tier=db --dry-run=client -o yaml > redis-pod.yaml` |
| 3 | Redis Service | `kubectl expose pod redis --port=6379 --name=redis-service --dry-run=client -o yaml > redis-service.yaml` |
| 4 | Webapp Deployment | `kubectl create deployment webapp --image=kodekloud/webapp-color --replicas=3 --dry-run=client -o yaml > webapp-deployment.yaml` |
| 5 | Custom Nginx Pod | `kubectl run custom-nginx --image=nginx --port=8080 --dry-run=client -o yaml > custom-nginx.yaml` |
| 6 | Dev Namespace | `kubectl create namespace dev-ns --dry-run=client -o yaml > dev-ns.yaml` |
| 7 | Redis Deployment | `kubectl create deployment redis-deploy --image=redis --replicas=2 -n dev-ns --dry-run=client -o yaml > redis-deploy.yaml` |
| 8 | Httpd Pod | `kubectl run httpd --image=httpd:alpine --port=80 --dry-run=client -o yaml > httpd-pod.yaml` |

### Using Generated YAML Files
```bash
# 1. Generate YAML
kubectl run test-pod --image=nginx --dry-run=client -o yaml > test-pod.yaml

# 2. (Optional) Edit the file
vim test-pod.yaml

# 3. Apply the YAML to create the resource
kubectl apply -f test-pod.yaml

# 4. Verify
kubectl get pods
```

---

## 📝 Verification Commands

### List All Pods
```bash
kubectl get pod
kubectl get pods
kubectl get po
```

**Example Output:**
```
NAME                       READY   STATUS    RESTARTS   AGE
nginx-pod                  1/1     Running   0          12m
redis                      1/1     Running   0          10m
webapp-7b59bf687d-n7xxp    1/1     Running   0          5m4s
webapp-7b59bf687d-rds95    1/1     Running   0          5m4s
webapp-7b59bf687d-4gqmt    1/1     Running   0          5m4s
custom-nginx               1/1     Running   0          3m41s
httpd                      1/1     Running   0          8s
```

### List All Services
```bash
kubectl get svc
kubectl get services
```

**Example Output:**
```
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
kubernetes      ClusterIP   10.43.0.1       <none>        443/TCP    20m
redis-service   ClusterIP   10.43.56.187    <none>        6379/TCP   6m35s
httpd           ClusterIP   10.43.112.233   <none>        80/TCP     15s
```

### Other Useful Verification Commands
```bash
# Describe resources
kubectl describe svc httpd
kubectl describe pod nginx-pod

# List deployments
kubectl get deployments
kubectl get deploy

# List namespaces
kubectl get namespaces
kubectl get ns

# List all resources
kubectl get all
kubectl get all -n dev-ns

# Show labels
kubectl get pods --show-labels
kubectl get pods -l tier=db

# Get YAML of existing resource
kubectl get pod nginx-pod -o yaml
kubectl get svc redis-service -o yaml
```

---

## 🎯 Key Concepts

### Understanding Kubernetes Objects

| Object Type | Purpose | Created By |
|-------------|---------|------------|
| **Pod** | Smallest deployable unit, runs containers | `kubectl run` |
| **Deployment** | Manages replica sets and pods, provides scaling and updates | `kubectl create deployment` |
| **Service** | Stable network endpoint for pods | `kubectl expose` |
| **Namespace** | Virtual cluster for resource isolation | `kubectl create namespace` |

### Pod vs Deployment

| Aspect | Pod | Deployment |
|--------|-----|------------|
| Instance | Single | Multiple replicas |
| Recovery | If deleted, gone forever | Auto-recovers failed pods |
| Updates | Manual | Rolling updates supported |
| Use Case | Testing, one-off tasks | Production applications |

### Service Types

| Type | Description | Access |
|------|-------------|--------|
| **ClusterIP** | Internal cluster access only | Default type |
| **NodePort** | Exposes on each node's IP at a static port | External access via node IP |
| **LoadBalancer** | Creates external load balancer | Cloud provider integration |

### Important Flags Reference

| Flag | Purpose | Example |
|------|---------|---------|
| `--image` | Container image to use | `--image=nginx:alpine` |
| `--port` | Container port | `--port=8080` |
| `--replicas` | Number of pod replicas | `--replicas=3` |
| `--labels` | Key-value labels | `--labels=tier=db,env=prod` |
| `-n` | Namespace | `-n dev-ns` |
| `--expose` | Auto-create service | `--expose` |
| `--dry-run=client` | Simulate command | `--dry-run=client` |
| `-o yaml` | Output format | `-o yaml` |

---

## 📚 Summary Tables

### All Commands Quick Reference

| # | Task | Command |
|---|------|---------|
| 1 | Nginx Pod | `kubectl run nginx-pod --image=nginx:alpine` |
| 2 | Redis Pod with Label | `kubectl run redis --image=redis:alpine --labels=tier=db` |
| 3 | Redis Service | `kubectl expose pod redis --port=6379 --name=redis-service` |
| 4 | Webapp Deployment | `kubectl create deployment webapp --image=kodekloud/webapp-color --replicas=3` |
| 5 | Custom Nginx Pod | `kubectl run custom-nginx --image=nginx --port=8080` |
| 6 | Dev Namespace | `kubectl create namespace dev-ns` |
| 7 | Redis Deployment in NS | `kubectl create deployment redis-deploy --image=redis --replicas=2 -n dev-ns` |
| 8 | Httpd Pod + Service | `kubectl run httpd --image=httpd:alpine --port=80 --expose` |

### Complete Resource Summary

| Resource | Name | Type | Image | Namespace | Replicas | Port | Labels |
|----------|------|------|-------|-----------|----------|------|--------|
| Pod | nginx-pod | Pod | nginx:alpine | default | 1 | - | - |
| Pod | redis | Pod | redis:alpine | default | 1 | - | tier=db |
| Service | redis-service | ClusterIP | - | default | - | 6379 | - |
| Deployment | webapp | Deployment | kodekloud/webapp-color | default | 3 | - | - |
| Pod | custom-nginx | Pod | nginx | default | 1 | 8080 | - |
| Namespace | dev-ns | Namespace | - | - | - | - | - |
| Deployment | redis-deploy | Deployment | redis | dev-ns | 2 | - | - |
| Pod | httpd | Pod | httpd:alpine | default | 1 | 80 | - |
| Service | httpd | ClusterIP | - | default | - | 80 | - |

---

## 🎓 Practice Exercises

### Exercise 1: Deploy a MySQL Database
```bash
# Create pod with labels
kubectl run mysql-db --image=mysql: 5.7 --labels=app=mysql,tier=database

# Expose as service
kubectl expose pod mysql-db --port=3306 --name=mysql-service

# Verify
kubectl get pods -l app=mysql
kubectl get svc mysql-service
```

### Exercise 2: Multi-Tier Application
```bash
# Create production namespace
kubectl create namespace production

# Deploy backend (Redis)
kubectl create deployment backend --image=redis --replicas=2 -n production

# Deploy frontend (Nginx)
kubectl create deployment frontend --image=nginx --replicas=3 -n production

# Expose backend service
kubectl expose deployment backend --port=6379 --name=backend-svc -n production

# Expose frontend service
kubectl expose deployment frontend --port=80 --name=frontend-svc -n production

# Verify everything
kubectl get all -n production
```

### Exercise 3: Complete Workflow with YAML
```bash
# Step 1: Generate all YAML files
kubectl create namespace myapp --dry-run=client -o yaml > myapp-ns.yaml
kubectl create deployment web --image=nginx --replicas=3 -n myapp --dry-run=client -o yaml > web-deploy.yaml

# Step 2: Apply
