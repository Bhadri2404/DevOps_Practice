# ArgoCD & GitOps Complete Guide

## Table of Contents

- [1. What is GitOps?](#1-what-is-gitops)
- [2. Why GitOps?](#2-why-gitops)
- [3. Principles of GitOps](#3-principles-of-gitops)
- [4. Is GitOps Only for Kubernetes?](#4-is-gitops-only-for-kubernetes)
- [5. Advantages of GitOps](#5-advantages-of-gitops)
- [6. Popular GitOps Tools](#6-popular-gitops-tools)
- [7. ArgoCD Overview](#7-argocd-overview)
- [8. ArgoCD Architecture](#8-argocd-architecture)
- [9. ArgoCD Installation](#9-argocd-installation)
- [10. Accessing ArgoCD UI](#10-accessing-argocd-ui)
- [11. ArgoCD CLI](#11-argocd-cli)
- [12. ArgoCD Applications](#12-argocd-applications)
- [13. Sync Policies](#13-sync-policies)
- [14. Self-Healing & Auto-Sync](#14-self-healing--auto-sync)
- [15. Helm & Kustomize Integration](#15-helm--kustomize-integration)
- [16. Multi-Cluster Deployment](#16-multi-cluster-deployment)
- [17. Hub-Spoke vs Standalone Model](#17-hub-spoke-vs-standalone-model)
- [18. ApplicationSets](#18-applicationsets)
- [19. Drift Detection & Continuous Reconciliation](#19-drift-detection--continuous-reconciliation)
- [20. SSO & Authentication (Dex)](#20-sso--authentication-dex)
- [21. RBAC & AppProjects](#21-rbac--appprojects)
- [22. Notifications Controller](#22-notifications-controller)
- [23. Redis & Caching](#23-redis--caching)
- [24. Health Status & Sync Status](#24-health-status--sync-status)
- [25. Production Best Practices](#25-production-best-practices)
- [26. Common Mistakes & Troubleshooting](#26-common-mistakes--troubleshooting)
- [27. Interview Questions & Answers](#27-interview-questions--answers)
- [28. Important CLI Commands Reference](#28-important-cli-commands-reference)

---

## 1. What is GitOps?

**Definition:** GitOps uses Git as a single source of truth to deliver applications and infrastructure.

**Simple Explanation:** Just like your application source code lives in Git with proper versioning, tracking, and pull request reviews — GitOps applies the same principle to your **deployments and infrastructure**. Every change to your Kubernetes cluster must first go through Git.

**Real-World Scenario:**
- A DevOps engineer wants to add a taint to a Kubernetes node
- Instead of running `kubectl taint` directly, they update a YAML manifest in Git
- They submit a Pull Request → another engineer reviews → PR is merged
- A GitOps controller (ArgoCD) detects the change and applies it to the cluster

---

## 2. Why GitOps?

### The Problem Without GitOps

| Problem | Explanation |
|---------|-------------|
| No versioning | You can't track what changed on the cluster over time |
| No auditing | You don't know WHO made the change |
| No tracking | After 10 days, you can't tell what modification was made |
| No rollback | No easy way to revert to a previous known-good state |
| Manual drift | Developers/engineers modify resources directly, causing invisible issues |

### The CI vs CD Gap

- **CI (Continuous Integration):** Already uses Git properly — source code → PR → review → merge → build
- **CD (Continuous Delivery) without GitOps:** Uses shell scripts, Python scripts, Ansible, kubectl commands — NO tracking, NO versioning

**GitOps bridges this gap:** If your CI has a proper Git-integrated approach, your CD should also have a proper Git-integrated approach.

### Real-World Production Scenario

```
Without GitOps:
Developer → kubectl edit deployment → Changes replicas from 3 to 1 → Nobody notices → Production outage after 2 weeks

With GitOps:
Developer → Tries kubectl edit → ArgoCD reverts change in 3 minutes → Alert sent → No outage
```

---

## 3. Principles of GitOps

These are the **four foundational principles** defined by the [OpenGitOps](https://github.com/open-gitops) project:

### 3.1 Declarative

- The system must have its desired state expressed **declaratively**
- Kubernetes YAML manifests are declarative by nature
- "What you see in Git is what you have on the cluster"

### 3.2 Versioned and Immutable

- All changes are tracked with version history
- Changes are immutable once committed
- Not restricted to Git only — S3 buckets (with versioning) can also work

### 3.3 Pulled Automatically

- Changes are pulled automatically by the GitOps controller
- Can use **pull mechanism** (controller polls Git) or **push mechanism** (webhooks trigger controller)
- The key point: changes must be **automatically** applied

### 3.4 Continuously Reconciled

- The GitOps controller continuously watches for differences between Git state and cluster state
- If someone modifies a resource directly on the cluster, the controller **overrides** that change
- Git is always the source of truth

---

## 4. Is GitOps Only for Kubernetes?

**By principle:** No. GitOps can apply to any infrastructure.

**In practice:** Yes, currently. All popular GitOps tools (ArgoCD, FluxCD) target Kubernetes clusters only.

> In the future, GitOps tools may solve problems for Docker Swarm, AWS infrastructure, etc. But today, the popular controllers are restricted to Kubernetes.

---

## 5. Advantages of GitOps

| Advantage | Description |
|-----------|-------------|
| **Security** | Unwanted/hacker changes are automatically reverted |
| **Versioning** | Full history of every deployment change |
| **Auto Upgrades** | Pull or push mechanism for automatic deployments |
| **Auto Healing** | Automatically fixes unauthorized manual changes |
| **Continuous Reconciliation** | Constantly ensures cluster state matches Git state |

**Security Deep Dive:** Nobody except the GitOps controller should have write access to the cluster resources it manages. Even if a hacker makes changes, GitOps will override them.

---

## 6. Popular GitOps Tools

| Tool | Notes |
|------|-------|
| **ArgoCD** | Most popular, CNCF graduated, 13k+ stars |
| **FluxCD** | CNCF graduated, lightweight |
| **Jenkins X** | CI/CD focused with GitOps capabilities |
| **Spinnaker** | Deployment-oriented, not purely GitOps-focused |

---

## 7. ArgoCD Overview

### History
- Created by engineers at **Intuit** (originally Argo project at Intuit)
- Open-sourced, CNCF graduated project
- Active contributors: Intuit, Red Hat, BlackRock, Codefresh, Akuity

### Argo Ecosystem
- **Argo CD** — GitOps continuous delivery
- **Argo Workflows** — Kubernetes-native workflow engine
- **Argo Rollouts** — Progressive delivery (canary, blue-green)
- **Argo Events** — Event-driven automation
- **Argo Notifications** — Notification engine

---

## 8. ArgoCD Architecture

### High-Level View

```
Git Repository ←→ ArgoCD ←→ Kubernetes Cluster
                   (keeps state in sync)
```

### Component Breakdown

```
┌─────────────────────────────────────────────────────┐
│                    ArgoCD System                      │
│                                                       │
│  ┌──────────┐   ┌─────────────────────┐             │
│  │   Dex    │   │     API Server      │ ← UI/CLI    │
│  │  (SSO)   │──→│  (Authentication)   │             │
│  └──────────┘   └─────────────────────┘             │
│                                                       │
│  ┌──────────────┐    ┌────────────────────────┐     │
│  │ Repo Server  │    │ Application Controller │     │
│  │ (Git State)  │───→│  (Reconciliation)      │     │
│  └──────────────┘    └────────────────────────┘     │
│         ↑                       ↑        ↓           │
│         │              ┌────────┐                    │
│         │              │ Redis  │ (Cache)            │
│         │              └────────┘                    │
└─────────┼───────────────────────┼────────────────────┘
          │                       │
     Git Repository        Kubernetes Cluster
```

### Components Explained

| Component | Role | Type |
|-----------|------|------|
| **API Server** | Handles UI/CLI requests, authentication, RBAC | Deployment |
| **Repo Server** | Connects to Git, fetches manifests, generates K8s manifests from Helm/Kustomize | Deployment |
| **Application Controller** | Core reconciliation logic — compares Git state vs cluster state | StatefulSet |
| **Dex** | Lightweight OIDC proxy for SSO (Google, GitHub, LDAP, etc.) | Deployment |
| **Redis** | In-memory cache for application controller state | Deployment |
| **Notifications Controller** | Sends notifications on sync/health status changes (added in v2.5+) | Deployment |
| **ApplicationSet Controller** | Generates multiple Applications from templates | Deployment |

### How Reconciliation Works

1. **Repo Server** fetches desired state from Git
2. **Application Controller** fetches actual state from Kubernetes
3. Controller **compares** both states
4. If different → Controller syncs Kubernetes to match Git
5. This process repeats continuously (default: every 3 minutes)

---

## 9. ArgoCD Installation

### Method 1: Plain YAML Manifests (Simplest)

```bash
# Create namespace
kubectl create namespace argocd

# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Method 2: Helm Chart

```bash
# Add Helm repo
helm repo add argo https://argoproj.github.io/argo-helm

# Install
helm install argocd argo/argo-cd -n argocd --create-namespace
```

### Method 3: Operator

- Use the ArgoCD Operator from OperatorHub
- Best for managed/enterprise environments

### Verify Installation

```bash
kubectl get pods -n argocd -w
```

Expected pods:
- `argocd-server-*`
- `argocd-repo-server-*`
- `argocd-application-controller-*`
- `argocd-redis-*`
- `argocd-dex-server-*`
- `argocd-notifications-controller-*`
- `argocd-applicationset-controller-*`

---

## 10. Accessing ArgoCD UI

### Option 1: NodePort

```bash
# Change service type to NodePort
kubectl edit svc argocd-server -n argocd
# Change type: ClusterIP → type: NodePort
```

### Option 2: LoadBalancer (Cloud)

```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

### Option 3: Port Forward (Local/Minikube)

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### Option 4: Minikube Tunnel

```bash
minikube service argocd-server -n argocd
```

### Running in Insecure (HTTP) Mode

Edit the ConfigMap to disable TLS:

```bash
kubectl edit configmap argocd-cmd-params-cm -n argocd
```

Add:
```yaml
data:
  server.insecure: "true"
```

> **Production:** Always use HTTPS with proper TLS certificates.

### Get Admin Password

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode
```

- **Username:** `admin`
- **Password:** output from the above command

---

## 11. ArgoCD CLI

### Installation

```bash
# macOS
brew install argocd

# Linux
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
```

### Login

```bash
argocd login <ARGOCD_SERVER_IP>:<PORT> --insecure
# Enter username: admin
# Enter password: <from secret>
```

### Create Application via CLI

```bash
argocd app create guestbook \
  --repo https://github.com/argoproj/argocd-example-apps.git \
  --path guestbook \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace default \
  --sync-policy automated
```

### Sync Application

```bash
argocd app sync guestbook
```

### Get Application Status

```bash
argocd app get guestbook
```

### Command Reference

Full documentation: [ArgoCD Command Reference](https://argo-cd.readthedocs.io/en/stable/user-guide/commands/argocd/)

---

## 12. ArgoCD Applications

### What is an Application?

An **Application** is a Custom Resource Definition (CRD) in ArgoCD that defines:
- **Source:** Where to get manifests (Git repo + path)
- **Destination:** Where to deploy (cluster + namespace)
- **Sync Policy:** How to handle synchronization

### Application YAML Example

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/argoproj/argocd-example-apps.git
    targetRevision: HEAD
    path: guestbook
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### Key Fields

| Field | Purpose |
|-------|---------|
| `source.repoURL` | Git repository URL |
| `source.path` | Folder path within the repo |
| `source.targetRevision` | Branch, tag, or commit SHA |
| `destination.server` | Target cluster API server URL |
| `destination.namespace` | Target namespace |
| `syncPolicy.automated` | Enable auto-sync |
| `syncPolicy.automated.prune` | Delete resources removed from Git |
| `syncPolicy.automated.selfHeal` | Revert manual changes on cluster |

---

## 13. Sync Policies

### Manual Sync
- User must click "Sync" button or run `argocd app sync`
- Useful for production environments where you want human approval

### Automatic Sync
- ArgoCD automatically applies changes when Git changes
- Default poll interval: **3 minutes**
- Can be triggered faster via webhooks

### Prune Resources
- When enabled: if a resource is **removed from Git**, ArgoCD **deletes** it from the cluster
- When disabled: orphaned resources remain on the cluster

### Self-Heal
- When enabled: if someone **manually modifies** a resource on the cluster, ArgoCD **reverts** the change
- This is the core auto-healing feature of GitOps

```yaml
syncPolicy:
  automated:
    prune: true      # Delete resources not in Git
    selfHeal: true   # Revert manual cluster changes
```

---

## 14. Self-Healing & Auto-Sync

### How Self-Healing Works (Production Scenario)

```
1. DevOps deploys ConfigMap via ArgoCD (processors: 5)
2. Developer manually edits ConfigMap on cluster (processors: 10)
3. ArgoCD detects state drift (Out of Sync)
4. ArgoCD automatically reverts to processors: 5
5. Application continues working correctly
```

### Configuration

```yaml
syncPolicy:
  automated:
    selfHeal: true
```

### Important Notes
- Auto-sync polls every **3 minutes** by default
- For faster detection, configure **Git webhooks**
- Do NOT set polling to very low values (10s) with many applications — it overloads ArgoCD

---

## 15. Helm & Kustomize Integration

### ArgoCD is NOT Opinionated

ArgoCD supports multiple manifest formats:

| Format | Description |
|--------|-------------|
| Plain YAML | Standard Kubernetes manifests |
| Helm Charts | Templated Kubernetes manifests |
| Kustomize | Overlay-based customization |
| Jsonnet | Data templating language |
| Custom Plugins | Any custom tool |

### Helm Example

Repository structure:
```
helm-guestbook/
├── Chart.yaml
├── values.yaml
└── templates/
    ├── deployment.yaml
    └── service.yaml
```

Application for Helm:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: helm-guestbook
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/argoproj/argocd-example-apps.git
    path: helm-guestbook
    targetRevision: HEAD
    helm:
      valueFiles:
        - values.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: default
```

### Kustomize Example

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kustomize-app
  namespace: argocd
spec:
  source:
    repoURL: https://github.com/argoproj/argocd-example-apps.git
    path: kustomize-guestbook
    targetRevision: HEAD
  destination:
    server: https://kubernetes.default.svc
    namespace: default
```

### Practice Repository

Use the official example apps: [github.com/argoproj/argocd-example-apps](https://github.com/argoproj/argocd-example-apps)

---

## 16. Multi-Cluster Deployment

### Why Multi-Cluster?

Organizations typically have multiple clusters:
- Dev, QA, Staging, Production
- Feature-specific clusters
- Regional clusters

### The Problem

When a new application version (e.g., guestbook v2) needs to be deployed across multiple clusters simultaneously.

### Steps for Multi-Cluster Setup with ArgoCD

#### Step 1: Create Clusters

```bash
# Using eksctl
eksctl create cluster --name hub-cluster --region us-west-1
eksctl create cluster --name spoke-cluster-1 --region us-west-1
eksctl create cluster --name spoke-cluster-2 --region us-west-1
```

#### Step 2: Install ArgoCD on Hub Cluster

```bash
kubectl config use-context <hub-cluster-context>
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

#### Step 3: Login to ArgoCD CLI

```bash
argocd login <ARGOCD_SERVER>:<PORT> --insecure
```

#### Step 4: Add Spoke Clusters

```bash
# Get available contexts
kubectl config get-contexts

# Add spoke cluster 1
argocd cluster add <spoke-1-context> --server <argocd-server-address>

# Add spoke cluster 2
argocd cluster add <spoke-2-context> --server <argocd-server-address>
```

#### Step 5: Create Applications for Each Cluster

```bash
# For spoke cluster 1
argocd app create guestbook-spoke1 \
  --repo https://github.com/your-repo/manifests.git \
  --path manifest/guestbook \
  --dest-server https://<spoke-1-api-server> \
  --dest-namespace default \
  --sync-policy automated

# For spoke cluster 2
argocd app create guestbook-spoke2 \
  --repo https://github.com/your-repo/manifests.git \
  --path manifest/guestbook \
  --dest-server https://<spoke-2-api-server> \
  --dest-namespace default \
  --sync-policy automated
```

### Verify Deployment

```bash
# Switch context to spoke cluster
kubectl config use-context <spoke-1-context>
kubectl get all -n default
kubectl get configmap
```

---

## 17. Hub-Spoke vs Standalone Model

### Hub-Spoke Model

```
                    ┌─────────────┐
                    │  Hub Cluster │
                    │   (ArgoCD)   │
                    └──────┬──────┘
                           │
              ┌────────────┼────────────┐
              ▼            ▼            ▼
        ┌──────────┐ ┌──────────┐ ┌──────────┐
        │  Spoke 1 │ │  Spoke 2 │ │  Spoke 3 │
        │  (Dev)   │ │  (QA)    │ │  (Prod)  │
        └──────────┘ └──────────┘ └──────────┘
```

- One centralized ArgoCD instance manages all clusters
- Best for centralized DevOps teams

**Advantages:**
- Single point of management
- Easy upgrades, backup, disaster recovery
- Consistent configuration

**Disadvantages:**
- Single point of failure (needs HA)
- Can become overloaded (50k+ objects)
- Requires sharding, high resources

### Standalone Model

```
  ┌─────────┐    ┌─────────┐    ┌─────────┐
  │  Dev    │    │   QA    │    │  Prod   │
  │ ArgoCD  │    │ ArgoCD  │    │ ArgoCD  │
  └─────────┘    └─────────┘    └─────────┘
```

- Each cluster has its own ArgoCD instance
- Each instance manages only its own cluster

**Advantages:**
- No single point of failure
- Less resource per instance
- Isolation between environments

**Disadvantages:**
- Multiple instances to upgrade/maintain
- Configuration drift between instances
- More operational overhead

### When to Use Which?

| Scenario | Recommended Model |
|----------|-------------------|
| Small centralized DevOps team | Hub-Spoke |
| < 50 clusters | Hub-Spoke |
| Strict isolation requirements | Standalone |
| Very large scale (100+ clusters) | Hub-Spoke with sharding |
| Per-team autonomy needed | Standalone |

---

## 18. ApplicationSets

### What is an ApplicationSet?

A **wrapper** over Applications that **generates** multiple Applications automatically using generators.

### Why ApplicationSets?

Instead of creating 100 Applications manually for 100 clusters, write **one ApplicationSet** that generates all of them.

### Example: List Generator

```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: guestbook-multi-cluster
  namespace: argocd
spec:
  generators:
    - list:
        elements:
          - cluster: spoke-1
            url: https://spoke-1-api-server
          - cluster: spoke-2
            url: https://spoke-2-api-server
          - cluster: spoke-3
            url: https://spoke-3-api-server
  template:
    metadata:
      name: 'guestbook-{{cluster}}'
    spec:
      project: default
      source:
        repoURL: https://github.com/your-org/manifests.git
        path: manifest/guestbook
        targetRevision: HEAD
      destination:
        server: '{{url}}'
        namespace: default
      syncPolicy:
        automated:
          selfHeal: true
          prune: true
```

### Generator Types

| Generator | Use Case |
|-----------|----------|
| **List** | Explicit list of clusters/values |
| **Cluster** | Auto-discover registered clusters |
| **Git Directory** | Generate apps from Git directory structure |
| **Git File** | Generate from config files in Git |
| **Matrix** | Combine two generators |
| **Merge** | Merge results from multiple generators |

---

## 19. Drift Detection & Continuous Reconciliation

### How It Works

1. ArgoCD stores a **cache** of all resources on the Kubernetes cluster
2. ArgoCD fetches the **desired state** from the Git repository
3. It continuously **compares** both states
4. Any **difference** = "Out of Sync" status
5. With self-heal enabled, ArgoCD **automatically corrects** the drift

### Important Concept: Admission Controllers & Drift

**Interview Question:** What if an admission controller adds labels/annotations/resource limits to pods that aren't in Git?

**Answer:** ArgoCD allows you to configure **ignoreDifferences** to ignore specific fields:

```yaml
spec:
  ignoreDifferences:
    - group: apps
      kind: Deployment
      jsonPointers:
        - /spec/template/metadata/annotations
```

### Existing Resources Before GitOps

**Question:** If you already have resources on a cluster before adopting GitOps, will ArgoCD delete them?

**Answer:** No. ArgoCD only manages resources that are defined in its Applications. Existing resources not tracked by ArgoCD are untouched.

---

## 20. SSO & Authentication (Dex)

### What is Dex?

A lightweight OIDC (OpenID Connect) proxy that comes bundled with ArgoCD. It allows integration with:
- Google/Gmail
- GitHub
- GitLab
- LDAP
- SAML
- Any OIDC provider

### Default Authentication

Without SSO configured, ArgoCD uses the built-in admin account with the initial admin secret.

### Production Recommendation

Always configure SSO in production:
```yaml
# argocd-cm ConfigMap
data:
  dex.config: |
    connectors:
      - type: github
        id: github
        name: GitHub
        config:
          clientID: $dex.github.clientID
          clientSecret: $dex.github.clientSecret
          orgs:
            - name: your-org
```

---

## 21. RBAC & AppProjects

### AppProjects

- Group applications logically
- Restrict which repos, clusters, and namespaces an Application can use
- Implement RBAC per team/project

```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: team-a
  namespace: argocd
spec:
  description: Team A project
  sourceRepos:
    - 'https://github.com/team-a/*'
  destinations:
    - namespace: team-a-*
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: ''
      kind: Namespace
```

---

## 22. Notifications Controller

- Merged into ArgoCD core from version **2.5+**
- Sends notifications on application events (sync success/failure, health degradation)
- Supports: Slack, Email, Teams, Webhooks, Grafana, etc.

---

## 23. Redis & Caching

- **Purpose:** Cache cluster state for the Application Controller
- Application Controller is a **StatefulSet** — needs persistent state
- If controller restarts, Redis provides cached state to quickly resume reconciliation
- No external Redis needed — ArgoCD bundles its own Redis instance

---

## 24. Health Status & Sync Status

### Sync Status

| Status | Meaning |
|--------|---------|
| **Synced** | Cluster state matches Git state |
| **OutOfSync** | Cluster state differs from Git state |
| **Unknown** | Cannot determine status |

### Health Status

| Status | Meaning |
|--------|---------|
| **Healthy** | All resources are running correctly |
| **Progressing** | Resources are being updated |
| **Degraded** | Resources have errors |
| **Suspended** | Resources are paused |
| **Missing** | Resources don't exist on cluster |

---

## 25. Production Best Practices

| Practice | Why |
|----------|-----|
| Always use HTTPS/TLS | Security |
| Configure SSO (Dex/OIDC) | No shared admin passwords |
| Use AppProjects for RBAC | Team isolation |
| Enable self-heal + prune | True GitOps compliance |
| Set up HA mode for Hub-Spoke | Avoid single point of failure |
| Use webhooks instead of polling | Faster sync, less load |
| Store ArgoCD Application manifests in Git | GitOps for GitOps |
| Use ApplicationSets for multi-cluster | Scalability |
| Configure resource limits on ArgoCD pods | Stability |
| Monitor ArgoCD with Prometheus metrics | Observability |
| Keep Git repo access minimal (read-only tokens) | Security |
| Use separate repos for app code and manifests | Clean separation |

---

## 26. Common Mistakes & Troubleshooting

### Common Mistakes

| Mistake | Solution |
|---------|----------|
| Deploying ArgoCD in default namespace | Always use dedicated `argocd` namespace |
| Not enabling self-heal | Manual drift goes unnoticed |
| Setting poll interval too low | Overloads ArgoCD; use webhooks instead |
| Using admin account in production | Configure SSO and disable admin |
| Private repo without credentials | Add repo credentials in ArgoCD settings |
| Forgetting to open security groups (AWS) | Ensure NodePort/LB ports are accessible |

### Debugging Steps

```bash
# Check ArgoCD pod status
kubectl get pods -n argocd

# Check ArgoCD server logs
kubectl logs -n argocd deployment/argocd-server

# Check application controller logs
kubectl logs -n argocd statefulset/argocd-application-controller

# Check repo server logs (Git connectivity issues)
kubectl logs -n argocd deployment/argocd-repo-server

# Check app sync status
argocd app get <app-name>

# Force refresh
argocd app get <app-name> --refresh
```

---

## 27. Interview Questions & Answers

**Q: What is GitOps?**
> GitOps uses Git as a single source of truth to deliver applications and infrastructure declaratively, with continuous reconciliation.

**Q: How does ArgoCD handle manual changes to the cluster?**
> With self-heal enabled, ArgoCD detects drift between Git and cluster state and automatically reverts unauthorized changes.

**Q: What happens if an admission controller adds fields not in Git?**
> You configure `ignoreDifferences` in the Application spec to tell ArgoCD which fields to ignore during diff comparison.

**Q: Hub-Spoke vs Standalone — which is better?**
> Depends on organization. Hub-Spoke for centralized teams with fewer resources. Standalone for strict isolation and team autonomy.

**Q: Can ArgoCD deploy Helm charts?**
> Yes. ArgoCD is not opinionated — it supports plain YAML, Helm, Kustomize, Jsonnet, and custom plugins.

**Q: What is the default sync interval?**
> 3 minutes. Can be made faster with Git webhooks.

**Q: What's the difference between Application and ApplicationSet?**
> Application deploys to one destination. ApplicationSet generates multiple Applications using generators (list, cluster, git directory, etc.).

**Q: Is Git the only VCS supported?**
> ArgoCD only supports Git-based VCS (GitHub, GitLab, Bitbucket). The GitOps principle itself isn't limited to Git (S3 buckets with versioning could work theoretically).

---

## 28. Important CLI Commands Reference

```bash
# Installation
brew install argocd                              # macOS

# Login
argocd login <SERVER>:<PORT> --insecure

# Application Management
argocd app create <name> --repo <url> --path <path> --dest-server <server> --dest-namespace <ns>
argocd app list
argocd app get <name>
argocd app sync <name>
argocd app delete <name>
argocd app set <name> --sync-policy automated

# Cluster Management
argocd cluster add <context> --server <argocd-server>
argocd cluster list
argocd cluster rm <server>

# Repo Management
argocd repo add <url> --username <user> --password <pass>
argocd repo list

# Account Management
argocd account list
argocd account update-password

# Kubectl helpers
kubectl get applications -n argocd
kubectl get appprojects -n argocd
kubectl edit configmap argocd-cm -n argocd
kubectl edit configmap argocd-cmd-params-cm -n argocd
```

---

## CI/CD Pipeline Integration

### Jenkins + ArgoCD (End-to-End)

```
┌──────────────────────────────────────────┐
│              CI (Jenkins)                  │
│                                            │
│  Build → Test → SAST → Docker Build →    │
│  Image Scan → Push to Registry →          │
│  Update K8s manifest in Git repo          │
└─────────────────────┬────────────────────┘
                      │ (Git commit triggers)
                      ▼
┌──────────────────────────────────────────┐
│              CD (ArgoCD)                  │
│                                            │
│  Detect Git change → Compare states →    │
│  Deploy to Kubernetes → Reconcile        │
└──────────────────────────────────────────┘
```

**Key Principle:** Jenkins handles CI (build, test, scan). ArgoCD handles CD (deploy, reconcile, heal). They connect through Git — Jenkins updates the manifest repo, ArgoCD picks up the change.

---

## Resources

- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [ArgoCD Example Apps](https://github.com/argoproj/argocd-example-apps)
- [ArgoCD Helm Charts](https://github.com/argoproj/argo-helm)
- [OpenGitOps Principles](https://github.com/open-gitops)
- [ArgoCD Command Reference](https://argo-cd.readthedocs.io/en/stable/user-guide/commands/argocd/)
