# Complete ArgoCD & Argo Rollouts — Production-Ready DevOps Notes

---

## 📑 Table of Contents

- [Section 1: Introduction & Prerequisites](#section-1-introduction--prerequisites)
- [Section 2: Introduction to GitOps](#section-2-introduction-to-gitops)
  - [Traditional Push Model & Its Drawbacks](#traditional-push-model--its-drawbacks)
  - [The GitOps Workflow](#the-gitops-workflow)
  - [Four Foundational Principles of GitOps](#four-foundational-principles-of-gitops)
- [Section 3: Installing & Accessing Argo CD](#section-3-installing--accessing-argo-cd)
  - [Installing Argo CD via Helm](#installing-argo-cd-via-helm)
  - [Accessing Argo CD Web UI](#accessing-argo-cd-web-ui)
  - [Installing & Using the Argo CD CLI](#installing--using-the-argo-cd-cli)
- [Section 4: Core Argo CD Concepts](#section-4-core-argo-cd-concepts)
  - [Argo CD Architecture & Components](#argo-cd-architecture--components)
  - [The Application CRD](#the-application-crd)
  - [Application vs Kubernetes Manifests](#application-vs-kubernetes-manifests)
  - [Deploying Your First Application](#deploying-your-first-application)
  - [Sync Status vs Health Status](#sync-status-vs-health-status)
  - [The Full GitOps Loop](#the-full-gitops-loop)
- [Section 5: Working with Helm Charts in Argo CD](#section-5-working-with-helm-charts-in-argo-cd)
  - [How Argo CD Treats Helm](#how-argo-cd-treats-helm)
  - [Deploying Your Own Helm Chart](#deploying-your-own-helm-chart)
  - [Deploying Public Helm Charts](#deploying-public-helm-charts)
  - [Customizing Helm Values & Precedence](#customizing-helm-values--precedence)
- [Section 6: Advanced Sync & Automation](#section-6-advanced-sync--automation)
  - [Automated Syncing](#automated-syncing)
  - [Pruning](#pruning)
  - [Self-Healing & Drift Correction](#self-healing--drift-correction)
- [Section 7: Private Repositories](#section-7-private-repositories)
  - [HTTPS Authentication (PAT)](#https-authentication-pat)
  - [SSH Authentication (Deploy Keys)](#ssh-authentication-deploy-keys)
- [Section 8: Orchestrating Applications](#section-8-orchestrating-applications)
  - [Argo CD Projects & Multi-Tenancy](#argo-cd-projects--multi-tenancy)
  - [Propagation Policies](#propagation-policies)
  - [Sync Phases & Hooks](#sync-phases--hooks)
  - [Hook Delete Policies](#hook-delete-policies)
  - [Sync Waves](#sync-waves)
  - [Combining Waves & Phases](#combining-waves--phases)
- [Section 9: Introduction to Argo Rollouts](#section-9-introduction-to-argo-rollouts)
  - [Why Deployments Are Not Enough](#why-deployments-are-not-enough)
  - [Installing Argo Rollouts](#installing-argo-rollouts)
  - [Argo Rollouts Dashboard](#argo-rollouts-dashboard)
- [Section 10: Core Rollout Strategies](#section-10-core-rollout-strategies)
  - [The Rollout CRD](#the-rollout-crd)
  - [Your First Canary Rollout](#your-first-canary-rollout)
  - [Blue-Green Deployments](#blue-green-deployments)
  - [Canary Deployments In-Depth](#canary-deployments-in-depth)
- [Section 11: Advanced Traffic Management](#section-11-advanced-traffic-management)
  - [Limitations of Replica-Weighted Strategies](#limitations-of-replica-weighted-strategies)
  - [Gateway API & Traefik Setup](#gateway-api--traefik-setup)
  - [Traffic-Weighted Canary Deployments](#traffic-weighted-canary-deployments)
  - [Header-Based Routing](#header-based-routing)
- [Section 12: Automated Analysis & Promotion](#section-12-automated-analysis--promotion)
  - [Prometheus & Metrics Architecture](#prometheus--metrics-architecture)
  - [Installing Prometheus](#installing-prometheus)
  - [Analysis Templates & Runs](#analysis-templates--runs)
  - [Self-Healing Rollouts with Analysis](#self-healing-rollouts-with-analysis)
  - [Analysis in Blue-Green Deployments](#analysis-in-blue-green-deployments)
- [Common Interview Questions](#common-interview-questions)
- [Production Best Practices Checklist](#production-best-practices-checklist)

---

## Section 1: Introduction & Prerequisites

### What You Need Installed

| Tool | Purpose |
|------|---------|
| **Docker** | Container runtime |
| **kubectl** | Kubernetes CLI |
| **Helm** | Kubernetes package manager |
| **Minikube / Kind / Rancher** | Local Kubernetes cluster |
| **VS Code** | IDE (any IDE works) |

> ⚠️ **Important:** Use a **disposable cluster**. Never experiment on production. You will install, delete, and recreate resources frequently.

### Windows Users — WSL Setup

If on Windows, install **Windows Subsystem for Linux (WSL)** for Unix-compatible commands:

1. Search "Turn Windows features on or off" → tick **Windows Subsystem for Linux** → restart
2. Open Microsoft Store → install **Ubuntu**
3. Set username and password
4. Open terminal → run `wsl` to enter Linux VM
5. Install VS Code extension: **WSL** for seamless integration

```bash
# Verify you're in Linux
uname -a

# Navigate to home directory
cd ~

# Open current folder in Windows Explorer
explorer.exe .
```

**Key benefit:** Files created inside WSL are accessible from Windows and vice versa. VS Code can connect directly to WSL via Remote Explorer.

> 💡 **Tip:** When installing dependencies inside WSL, always follow **Linux instructions**, not Windows.

---

## Section 2: Introduction to GitOps

### Traditional Push Model & Its Drawbacks

**What is the Push Model?**

The traditional CI/CD workflow where changes flow in one direction:

```
Developer → Git Push → CI/CD Pipeline → Build → Test → Docker Push → kubectl apply / helm upgrade → Cluster
```

The pipeline **pushes** changes directly to the cluster.

**Why is this problematic in production?**

| Problem | Explanation | Real-World Example |
|---------|-------------|-------------------|
| **Configuration Drift** | Someone runs `kubectl scale deployment/app --replicas=1` manually. Now the cluster state differs from Git. Nobody knows the "real" desired state. | A developer scales down pods for debugging but forgets to scale back up. Git says 3 replicas, cluster has 1. |
| **Poor Auditability** | No record of who changed what and why. The only source of truth is the live cluster. | During an incident, nobody knows who scaled the deployment or changed an env var yesterday. |
| **Stressful Rollbacks** | Rolling back requires finding the last good artifact, re-running pipelines, and hoping everything comes back up. | A bad deploy happens at 2 AM. You need to dig through multiple services to find the correct versions. |
| **Inconsistent Environments** | Dev, staging, and prod configurations diverge over time due to manual changes. | Staging has 2 replicas with debug logging; prod has 5 replicas. Nobody documented the differences. |

> 🎯 **Interview Tip:** "The push model works, but it creates drift between what Git says and what the cluster actually runs. GitOps eliminates this gap."

---

### The GitOps Workflow

**How GitOps is different — the Pull Model:**

```
Developer → Git Push → CI/CD Pipeline → Build/Test → Push Docker Image
                                                          ↓
                                            Update Config Repository
                                                          ↓
                                          Argo CD monitors Config Repo
                                                          ↓
                                   Argo CD compares Desired State vs Live State
                                                          ↓
                                        Sync (auto or manual) → Cluster Updated
```

**Key differences:**

1. **Two repositories:** Application code repo (source) + Configuration repo (Kubernetes manifests)
2. **No direct cluster access from CI/CD:** Pipelines never run `kubectl apply`. They only update the config repo.
3. **Argo CD runs INSIDE the cluster:** It continuously monitors the config repo and compares it with the live cluster state.
4. **Pull-based:** Argo CD pulls desired state from Git, rather than CI/CD pushing to the cluster.

**Why separate repos?**

```
app-repo/                          config-repo/
├── src/                           ├── base/
├── tests/                         │   ├── deployment.yaml
├── Dockerfile                     │   └── service.yaml
└── .github/workflows/             ├── overlays/
    └── ci.yaml                    │   ├── dev/
                                   │   ├── staging/
                                   │   └── prod/
```

- **Strong separation of concerns**: App developers work on code; platform engineers manage infra config
- **Security**: CI/CD doesn't need cluster credentials
- **Auditability**: Every config change is a Git commit with author, message, and timestamp

> 💡 **Best Practice:** Use a dedicated config repository. If using the same repo, treat the config as a subfolder but maintain clear separation.

**Configuration Drift Detection:**

Argo CD continuously:
1. Reads the desired state from the config repo
2. Queries the Kubernetes API for the live state
3. Compares them
4. If different → marks resources as **Out of Sync**
5. If configured → automatically **self-heals** to the desired state

---

### Four Foundational Principles of GitOps

| # | Principle | What It Means | Example |
|---|-----------|---------------|---------|
| 1 | **Declarative** | Express *what* you want, not *how* to get it | "I want 3 replicas of nginx" — Argo CD figures out the `kubectl apply` |
| 2 | **Versioned & Immutable** | Desired state stored in Git with full history. A specific tag = specific config, always. | Git tag `v1.2.0` always maps to the same deployment config. Don't move tags. |
| 3 | **Pulled Automatically** | A software agent (Argo CD) automatically pulls desired state from Git. No manual "please pull now". | Argo CD checks the repo every ~3 minutes by default |
| 4 | **Continuously Reconciled** | The agent continuously observes the live state and *attempts* to apply the desired state | If someone manually deletes a pod, Argo CD detects drift and recreates it |

> 🎯 **Interview Answer:** "GitOps is a set of practices where Git is the single source of truth for declarative infrastructure. An agent like Argo CD continuously reconciles the live cluster state with the desired state stored in Git."

---

## Section 3: Installing & Accessing Argo CD

### Installing Argo CD via Helm

**Step 1: Add the Argo Helm repository**
```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
```

**Step 2: Search for the chart**
```bash
helm search repo argo/argo-cd --versions
```

**Step 3: Create the namespace (recommended approach with YAML)**
```yaml name=argocd-ns.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: argocd
```
```bash
kubectl apply -f argocd-ns.yaml
```

**Step 4: Install via Helm**
```bash
helm upgrade argocd argo/argo-cd \
  --version 8.6.0 \
  --install \
  --create-namespace \
  --namespace argocd
```

| Flag | Purpose |
|------|---------|
| `--install` | Install if release doesn't exist (otherwise only upgrade) |
| `--create-namespace` | Create namespace if it doesn't exist |
| `--namespace argocd` | Deploy into argocd namespace |
| `--version 8.6.0` | Pin a specific chart version for reproducibility |

**Step 5: Verify**
```bash
kubectl get pods -n argocd
```
All pods should reach `Running` state.

> 💡 **Best Practice:** Always install Argo CD in its own namespace (`argocd`) to isolate it from application workloads and apply RBAC easily.

> ⚠️ **Common Mistake:** Not pinning the chart version. Minor version bumps can introduce breaking value changes.

---

### Accessing Argo CD Web UI

**Port-forward the server:**
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

**Get the initial admin password:**
```bash
kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath='{.data.password}' | base64 -d
```

Open `https://localhost:8080` → Accept the self-signed cert warning → Login with:
- Username: `admin`
- Password: (decoded secret value)

> ⚠️ **Common Mistake:** Forgetting to pipe through `base64 -d`. The secret is base64-encoded.

---

### Installing & Using the Argo CD CLI

**Install (Mac example):**
```bash
brew install argocd
```

**Login to your Argo CD instance:**
```bash
argocd login localhost:8080 --name local
# Proceed insecurely (no TLS cert locally)
# Enter username: admin
# Enter password: <your-password>
```

**Useful commands:**
```bash
# Check context
argocd context

# Get user info
argocd account get-user-info

# Update password
argocd account update-password

# List applications
argocd app list

# Get app details
argocd app get <app-name>

# Sync an app
argocd app sync <app-name>

# List projects
argocd proj list
```

> 💡 **Tip:** The CLI talks to the same API server as the UI. If port-forward stops, the CLI also loses connectivity.

---

## Section 4: Core Argo CD Concepts

### Argo CD Architecture & Components

```
                    ┌──────────────────────────────────────┐
                    │          Kubernetes Cluster           │
                    │                                      │
  Users ──────────▶│  ┌─────────────┐   ┌──────────────┐  │
  (UI/CLI/API)     │  │  API Server │◀─▶│  Repo Server  │──│──▶ Git Repos
                    │  └──────┬──────┘   └──────────────┘  │
                    │         │                             │
                    │  ┌──────▼──────────────┐             │
                    │  │ Application          │             │
                    │  │ Controller           │─────────────│──▶ K8s API
                    │  └─────────────────────┘             │    (live state)
                    │                                      │
                    │  ┌────────┐  ┌─────────┐ ┌────────┐ │
                    │  │ Redis  │  │Dex(IDP) │ │AppSet  │ │
                    │  │(cache) │  │         │ │Ctrl    │ │
                    │  └────────┘  └─────────┘ └────────┘ │
                    └──────────────────────────────────────┘
```

| Component | Role |
|-----------|------|
| **API Server** | Externally facing. Handles requests from UI, CLI, gRPC/REST. Communicates with internal components. |
| **Repository Server** | Clones/caches Git repos. Runs `helm template` or `kustomize build` to generate final manifests. |
| **Application Controller** | Continuously monitors applications. Compares desired vs live state. Performs corrective actions. Runs lifecycle hooks. |
| **Redis** | In-memory cache for manifest generation results |
| **Dex Server** | Identity provider supporting OIDC and SAML for SSO |
| **ApplicationSet Controller** | Manages ApplicationSet CRDs for managing Argo CD apps at scale |

> 🎯 **Interview:** "The Repo Server generates manifests, the Application Controller does the diffing and reconciliation, and the API Server is the frontend for all external interactions."

---

### The Application CRD

**What is it?**

The `Application` is a Custom Resource Definition (CRD) that is the **core building block** of Argo CD. It tells Argo CD:
- **WHERE** is the code (source)
- **WHERE** to deploy it (destination)
- **HOW** to sync it (sync policy)

```yaml name=guestbook-app.yaml
apiVersion: argoproj.io/v1alpha1    # Argo CD API group
kind: Application                   # CRD kind
metadata:
  name: guestbook                   # Name of the Application in Argo CD
  namespace: argocd                 # MUST be in argocd namespace
spec:
  project: default                  # Argo CD project (optional, defaults to 'default')

  source:                           # WHERE is the code?
    repoURL: https://github.com/org/repo.git  # Git repository URL
    targetRevision: HEAD            # Branch, tag, or commit SHA
    path: guestbook                 # Folder within the repo containing manifests

  destination:                      # WHERE to deploy?
    server: https://kubernetes.default.svc  # Cluster URL (this = local cluster)
    namespace: default              # Target namespace for the K8s resources

  syncPolicy:                       # HOW to sync?
    automated:                      # Enable auto-sync
      prune: true                   # Delete resources removed from Git
      selfHeal: true                # Revert manual cluster changes
```

**Line-by-line:**

| Field | Purpose |
|-------|---------|
| `apiVersion: argoproj.io/v1alpha1` | Argo CD's custom API group |
| `kind: Application` | This is an Argo CD Application resource |
| `metadata.namespace: argocd` | The Application resource itself lives in the argocd namespace |
| `spec.project` | Logical grouping for RBAC. `default` is unrestricted. |
| `spec.source.repoURL` | The Git repo containing your Kubernetes manifests |
| `spec.source.targetRevision` | `HEAD` = latest commit on default branch. Use tags/SHAs for pinned versions in prod. |
| `spec.source.path` | Subfolder in the repo to deploy from |
| `spec.destination.server` | `https://kubernetes.default.svc` = deploy to the same cluster Argo CD runs in |
| `spec.destination.namespace` | The namespace where your actual app pods/services will be created |

> ⚠️ **Common Mistake:** Confusing `metadata.namespace` (where the Application resource lives — always `argocd`) with `spec.destination.namespace` (where your app's pods/services are deployed).

> ⚠️ **`targetRevision: HEAD`** always points to the latest commit. In production, use **Git tags** or **commit SHAs** for immutability.

---

### Application vs Kubernetes Manifests

| Aspect | Application CRD | Kubernetes Manifests |
|--------|-----------------|---------------------|
| **Kind** | `Application` (Argo CD custom) | `Deployment`, `Service`, `ConfigMap`, etc. |
| **Purpose** | Declarative contract telling Argo CD *what to manage* | Actual definition of running workloads |
| **Where it lives** | `argocd` namespace | Target application namespace (e.g., `default`, `finance`) |
| **Managed by** | Argo CD controllers | Kubernetes controllers |
| **Contains** | Source repo URL, destination, sync policy | Container specs, ports, replicas, volumes |

**How Argo CD tracks ownership:**

Argo CD adds an annotation to every resource it manages:
```yaml
annotations:
  argocd.argoproj.io/tracking-id: "guestbook:/Deployment:default/guestbook-ui"
```
This is how it knows which resources belong to which Application — even if other deployments exist in the same namespace.

---

### Deploying Your First Application

```bash
# Apply the Application manifest
kubectl apply -f guestbook-app.yaml

# Check status
kubectl get applications -n argocd

# Describe for details
kubectl describe application guestbook -n argocd
```

Initially, the Application will be **Out of Sync** because the resources defined in the Git repo don't exist in the cluster yet.

**Sync via CLI:**
```bash
argocd app sync guestbook
```

**Sync via UI:** Click the app → Sync → Synchronize

After syncing, verify:
```bash
kubectl get deploy
kubectl get pods
kubectl get svc
```

---

### Sync Status vs Health Status

These are **two independent indicators**:

| Indicator | What It Measures | Possible Values |
|-----------|-----------------|-----------------|
| **Sync Status** | Does live state match desired state (Git)? | `Synced`, `OutOfSync`, `Progressing` |
| **Health Status** | Are the deployed resources actually working? | `Healthy`, `Degraded`, `Progressing`, `Missing` |

**Critical insight:** An app can be **Synced but Degraded** — meaning it matches Git perfectly, but Git contains a bad config (e.g., wrong image tag pointing to a buggy version).

```
                    ┌──────────────────────┐
                    │   Sync Status        │
                    │   Looks at: Git ↔    │
                    │   Cluster match      │
                    └──────────────────────┘
                    
                    ┌──────────────────────┐
                    │   Health Status      │
                    │   Looks at: Are pods │
                    │   running? Ready?    │
                    └──────────────────────┘
```

**What gets health/sync indicators in the UI?**
- Resources **defined in Git** (Deployment, Service) get BOTH sync + health indicators
- Resources **created by controllers** (ReplicaSet, Pod) get ONLY health indicators — because they're not directly defined in your Git manifests

> 🎯 **Interview:** "Sync status tells you if the cluster matches Git. Health status tells you if the app is actually working. They're independent — you can be synced but unhealthy if your Git config is broken."

---

### The Full GitOps Loop

1. **Fork/clone** the config repository
2. **Make changes** (e.g., update replica count in `deployment.yaml`)
3. **Commit and push** to your fork
4. **Argo CD detects** the difference (within ~3 minutes, or click Refresh)
5. App shows **OutOfSync** with a diff showing exactly what changed
6. **Sync** (manually or automatically) to apply changes
7. **Verify** pods/deployments reflect the change

```bash
# Example: After pushing replica count change from 1 to 3
kubectl get pods
# Should show 3 pods running
```

> 💡 **Key Point:** You never ran `kubectl apply` or `helm upgrade`. Argo CD did it for you by detecting the Git change.

---

## Section 5: Working with Helm Charts in Argo CD

### How Argo CD Treats Helm

**This is the single most important thing to understand:**

> ⚡ Argo CD does NOT run `helm install` or `helm upgrade`. It uses Helm purely as a **template engine**. It runs `helm template` to generate plain YAML, then applies it with `kubectl apply`.

**Consequences:**

| What You Get | What You Don't Get |
|-------------|-------------------|
| Templated manifests applied to cluster | No `helm list` output |
| Argo CD manages the lifecycle | No Helm release secrets |
| Argo CD diffing & sync | No `helm history` |
| Values override via Application spec | No `helm rollback` |

```
Repo Server → helm template (chart + values) → Plain YAML manifests
                                                        ↓
Application Controller → Compare with live state → kubectl apply
```

> 🎯 **Interview:** "Argo CD intentionally decouples from Helm's release management. It uses Helm only for templating, then manages the resulting manifests itself. This means there are no Helm secrets, no `helm ls`, no `helm history` in the cluster."

---

### Deploying Your Own Helm Chart

Update your Application to point to a Helm chart folder:

```yaml name=guestbook-helm-app.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/your-org/argo-cd-example-apps.git
    targetRevision: HEAD
    path: helm-guestbook          # Path to the Helm chart directory
    helm:                          # Helm-specific configuration
      valueFiles:
        - values.yaml              # Reference to values file within the chart
  destination:
    server: https://kubernetes.default.svc
    namespace: default
```

> ⚠️ **Common Mistake:** Putting `valueFiles` directly under `source` instead of under `source.helm`. It must be nested under `helm:`.

**Transitioning from plain manifests to Helm:**

When you change `path` from a plain manifests folder to a Helm chart folder, Argo CD may detect different resource names (due to Helm naming conventions like `release-name-chart-name`). This changes the tracking IDs, and Argo CD may want to delete old resources and create new ones. Use the **Prune** option during sync to clean up old resources.

If a resource has **immutable fields** (like `spec.selector` in Deployments), you may need to use **Replace + Force** during sync as a last resort.

---

### Deploying Public Helm Charts

For charts from public repositories (like Kubernetes Dashboard):

```yaml name=dashboard-app.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: k8-dashboard
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://kubernetes.github.io/dashboard/  # Helm repo URL
    chart: kubernetes-dashboard                         # Chart name (not path!)
    targetRevision: 7.3.0                               # Chart VERSION (not Git revision)
  destination:
    server: https://kubernetes.default.svc
    namespace: k-dashboard
```

**Key difference from Git-based sources:**
- Use `chart:` instead of `path:`
- `targetRevision` is the **chart version** (not a Git branch/tag)
- `repoURL` is the Helm repository URL

---

### Customizing Helm Values & Precedence

Three ways to override values, **from lowest to highest precedence:**

```
Chart's values.yaml  <  valueFiles  <  values (object)  <  parameters
    (lowest)                                                (highest)
```

```yaml name=app-with-all-overrides.yaml
spec:
  source:
    helm:
      # 1. valueFiles - list of YAML files within the chart
      valueFiles:
        - values.yaml              # Applied first (lowest in list)
        - values-production.yaml   # Applied second (overrides values.yaml)

      # 2. values object - inline YAML overrides
      values: |
        replicaCount: 3
        service:
          type: LoadBalancer

      # 3. parameters - highest precedence, key-value pairs
      parameters:
        - name: replicaCount
          value: "5"               # This WINS over everything above
        - name: service.type
          value: "ClusterIP"       # Dot notation for nested values
```

**Precedence rules within arrays:**
- In `valueFiles`: later entries override earlier entries
- In `parameters`: later entries override earlier entries with the same name

> 💡 **Best Practice:**
> - Use `valueFiles` for environment-specific configs (dev, staging, prod)
> - Use `values` for one-off overrides during development
> - Use `parameters` for CI/CD pipeline-driven values (highest precedence)

---

## Section 6: Advanced Sync & Automation

### Automated Syncing

**What:** Argo CD automatically applies changes when it detects drift between Git and the cluster, without manual approval.

**Why:** Enables fully automated GitOps pipelines. Once a PR is merged, changes deploy automatically.

**How to enable:**
```yaml
spec:
  syncPolicy:
    automated: {}    # Empty object = auto-sync ON, prune OFF, selfHeal OFF
```

**Default behavior (without automated):** Argo CD only *reports* OutOfSync — you must manually click Sync.

> ⚠️ **Production Warning:** Only enable auto-sync when you have solid CI/CD with automated tests, security scans, and PR review processes. Otherwise, a merged typo deploys instantly to production.

---

### Pruning

**What:** When a resource is **deleted from Git** but still exists in the cluster, pruning automatically removes it during sync.

**Why:** Without pruning, orphaned resources accumulate in the cluster.

**Default behavior:** Even with auto-sync, Argo CD will NOT delete resources missing from Git. It leaves them as orphans.

```yaml
spec:
  syncPolicy:
    automated:
      prune: true    # Delete resources removed from Git
```

**Important detail:** Pruning only happens during a **sync operation**. If you have auto-sync enabled, prune will trigger when Argo CD detects a Git change. If auto-sync is off, you must manually sync with the prune checkbox.

> 💡 **Tip:** Pruning only affects resources **directly managed by Argo CD** (those with tracking annotations). Pods managed by a Deployment are not directly pruned — they're deleted when the Deployment controller processes the Deployment change.

---

### Self-Healing & Drift Correction

**What:** Automatically reverts any manual changes made to the live cluster that cause drift from the desired Git state.

**Why:** Prevents configuration drift caused by `kubectl edit`, `kubectl scale`, or any imperative changes.

```yaml
spec:
  syncPolicy:
    automated:
      prune: true
      selfHeal: true    # Revert manual cluster changes
```

**How it works:**
```
Someone runs: kubectl scale deploy/app --replicas=10
                          ↓
Argo CD detects: Live state (10 replicas) ≠ Desired state (3 replicas)
                          ↓
Self-heal kicks in: Reverts to 3 replicas within seconds
```

**Production scenario — temporarily disabling self-heal for debugging:**
```yaml
# Temporarily set to false
selfHeal: false
```
```bash
kubectl apply -f app.yaml
# Now you can make manual changes for debugging
# When done, set back to true
```

> ⚠️ **Warning:** Self-healing is aggressive. If you run `kubectl scale` for debugging, it reverts almost instantly. Disable it temporarily if you need to make manual changes.

**Complete automated sync policy:**
```yaml
spec:
  syncPolicy:
    automated:
      prune: true        # Clean up deleted resources
      selfHeal: true     # Revert manual changes
```

> 🎯 **Interview:** "Automated sync responds to Git changes. Self-heal responds to cluster changes. Together, they ensure the cluster always matches Git, regardless of where the change originates."

---

## Section 7: Private Repositories

### How Argo CD Authenticates to Private Repos

Argo CD uses **Kubernetes Secrets** in the `argocd` namespace with a specific label:

```yaml
metadata:
  labels:
    argocd.argoproj.io/secret-type: repository    # REQUIRED label
```

Argo CD scans for secrets with this label and matches them to repository URLs in Application specs.

---

### HTTPS Authentication (PAT)

**Secret schema for HTTPS:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: private-repo-https
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  type: git
  url: https://github.com/org/private-repo.git
  username: your-github-username
  password: ghp_xxxxxxxxxxxxxxxxxxxx    # Personal Access Token
```

**Create imperatively (avoids committing secrets to Git):**
```bash
kubectl create secret generic private-repo-https \
  --namespace argocd \
  --from-literal=type=git \
  --from-literal=url=https://github.com/org/private-repo.git \
  --from-literal=username=your-username \
  --from-literal=password=ghp_xxxxxxxxxxxxxxxxxxxx

# Add the required label
kubectl label secret private-repo-https \
  -n argocd \
  argocd.argoproj.io/secret-type=repository
```

> ⚠️ **NEVER commit secrets to Git.** Use imperative creation, external secret managers (AWS Secrets Manager, Vault), or the External Secrets Operator.

**Creating a fine-grained PAT in GitHub:**
1. Settings → Developer Settings → Personal Access Tokens → Fine-grained tokens
2. Select specific repository access
3. Grant only **Contents: Read-only** permission
4. Copy the token immediately (shown only once)

---

### SSH Authentication (Deploy Keys)

**Advantages over PATs:**

| Advantage | Explanation |
|-----------|-------------|
| Repository-specific | Each key grants access to only one repo |
| No user dependency | If a developer leaves, keys still work |
| Read-only by default | More secure out of the box |
| Long-lived | Less rotation needed than PATs |

**Step 1: Generate SSH key pair**
```bash
ssh-keygen -t ed25519 -f ./argocd-deploy-key -N ""
# Creates: argocd-deploy-key (private) and argocd-deploy-key.pub (public)
```

**Step 2: Add public key as Deploy Key in GitHub**
- Repo Settings → Deploy Keys → Add Deploy Key
- Paste contents of `argocd-deploy-key.pub`
- Leave "Allow write access" unchecked

**Step 3: Create Kubernetes Secret with private key**
```bash
PRIVATE_KEY=$(cat ./argocd-deploy-key)

kubectl create secret generic private-repo-ssh \
  --namespace argocd \
  --from-literal=type=git \
  --from-literal=url=git@github.com:org/private-repo.git \
  --from-literal=sshPrivateKey="$PRIVATE_KEY"

kubectl label secret private-repo-ssh \
  -n argocd \
  argocd.argoproj.io/secret-type=repository
```

**Step 4: Update Application to use SSH URL**
```yaml
spec:
  source:
    repoURL: git@github.com:org/private-repo.git    # SSH URL format
```

> 💡 **Production:** Use an external secrets manager (HashiCorp Vault, AWS Secrets Manager) with the External Secrets Operator to dynamically provision these secrets.

> 🧹 **Security:** Always delete SSH keys from local disk after adding them. Delete PATs when no longer needed. Rotate regularly.

---

## Section 8: Orchestrating Applications

### Argo CD Projects & Multi-Tenancy

**What:** A logical grouping within Argo CD that defines security boundaries for applications.

**Why:** In organizations with multiple teams sharing a cluster, you need to restrict which repos, namespaces, and resource types each team can deploy.

**Default project:** Installed with Argo CD, allows everything everywhere. Fine for learning, dangerous for production.

```yaml name=team-finance-project.yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: team-finance
  namespace: argocd
spec:
  description: "Project for team finance with security guardrails"

  # Which Git repos can be used
  sourceRepos:
    - https://github.com/org/finance-app.git
    # - '!https://github.com/org/forbidden-repo.git'  # Explicit deny
    # - '*'  # Allow all (use with deny list)

  # Where apps can be deployed
  destinations:
    - server: https://kubernetes.default.svc
      namespace: finance

  # Which cluster-scoped resources are allowed
  clusterResourceWhitelist:
    - group: '*'
      kind: '*'

  # Which namespace-scoped resources are allowed
  namespaceResourceWhitelist:
    - group: '*'
      kind: '*'
```

**Link an Application to a Project:**
```yaml
spec:
  project: team-finance    # Must match the AppProject name
  destination:
    namespace: finance     # Must be in the project's allowed destinations
```

**What happens if you violate project rules:**
```
Error: application destination {server, namespace} is not permitted in project team-finance
```

> 🎯 **Interview:** "Projects provide multi-tenancy in Argo CD. They control source repos, destination namespaces, and allowed resource types. Each Application belongs to exactly one project."

---

### Propagation Policies

These are **Kubernetes concepts** (not Argo CD-specific) that determine how dependent resources are deleted:

| Policy | Behavior | Example |
|--------|----------|---------|
| **Foreground** | Delete dependents first, then the owner | Pods deleted → ReplicaSet deleted → Deployment deleted |
| **Background** (default) | Delete owner first, garbage collector cleans up dependents | Deployment deleted → GC deletes ReplicaSet → GC deletes Pods |
| **Orphan** | Delete only the owner, leave dependents running | Deployment deleted, but ReplicaSet and Pods remain |

You'll see these options when deleting Applications in the Argo CD UI.

---

### Sync Phases & Hooks

**What:** Hooks allow you to run custom Jobs at specific points during a sync operation.

**Why:** Run database migrations before deploying, send notifications after deploying, or clean up after a failed sync.

**Sync operation phases:**

```
┌─────────────┐     ┌───────────┐     ┌──────────────┐
│  PreSync     │────▶│   Sync    │────▶│  PostSync    │
│  (hooks)     │     │(manifests │     │  (hooks)     │
│              │     │ + hooks)  │     │              │
└──────┬───────┘     └─────┬─────┘     └──────────────┘
       │                   │
       │    ┌──────────────▼──────────┐
       └───▶│      SyncFail          │
            │      (hooks)           │
            └────────────────────────┘
```

| Phase | When It Runs | Use Case |
|-------|-------------|----------|
| **PreSync** | Before any manifests are applied | Database migrations, backup creation |
| **Sync** | During manifest application | Custom sync logic |
| **PostSync** | After successful sync | Notifications, smoke tests |
| **SyncFail** | After a failed sync | Cleanup, rollback scripts |
| **Skip** | Resource is skipped during sync | Temporarily exclude a resource |
| **PostDelete** | After all app resources are deleted | Final cleanup when deleting an app |

**Example PreSync hook (database migration):**
```yaml name=db-migration-job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migration-job
  annotations:
    argocd.argoproj.io/hook: PreSync                    # Run BEFORE sync
    argocd.argoproj.io/hook-delete-policy: BeforeHookCreation,HookSucceeded
spec:
  backoffLimit: 2
  template:
    spec:
      restartPolicy: Never
      containers:
        - name: migration
          image: busybox
          command: ["sh", "-c", "echo 'Running DB migration' && sleep 10 && echo 'Done'"]
```

**Key points:**
- Hooks must be **Jobs** (they have clear success/failure semantics)
- PreSync Jobs must succeed before Sync phase begins
- Hooks are **application-scoped** — only hooks defined in an Application's source code run during that Application's sync

---

### Hook Delete Policies

| Policy | When the hook resource is deleted |
|--------|----------------------------------|
| `BeforeHookCreation` | Before a new hook with the same name is created (next sync) |
| `HookSucceeded` | Immediately after the hook succeeds |
| `HookFailed` | Immediately after the hook fails |

```yaml
annotations:
  argocd.argoproj.io/hook-delete-policy: BeforeHookCreation,HookSucceeded
```

> 💡 **Tip:** If you omit `HookSucceeded`, the completed Job stays in the cluster for debugging. Useful when you need to inspect logs.

---

### Sync Waves

**What:** Control the **order** of resource creation within a sync phase.

**Why:** Ensure ConfigMaps exist before Deployments that reference them, or namespaces exist before resources in them.

```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "10"    # Integer (negative allowed)
```

**Execution order:** Smallest number first → largest number last.

```
Wave -1 → Wave 0 (default) → Wave 1 → Wave 2 → Wave 3 ...
```

Resources without the annotation default to wave **0**.

**Example — ordered deployment:**
```yaml
# Wave 10: ConfigMap (created first)
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "10"

# Wave 20: Job to verify DB connectivity
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "20"

# Wave 30: Deployment (created last, after ConfigMap and Job succeed)
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "30"
```

> 💡 **Best Practice:** Use multiples of 10 (10, 20, 30) instead of consecutive integers (1, 2, 3). This leaves room to insert new resources between existing waves without refactoring everything.

### Combining Waves & Phases

You can use both annotations together:

```yaml
annotations:
  argocd.argoproj.io/hook: PreSync
  argocd.argoproj.io/sync-wave: "10"
```

Argo CD applies waves **within** each phase:
```
PreSync Phase:  Wave -5 → Wave -2 → Wave 2 → Wave 10
Sync Phase:     Wave 0 → Wave 10 → Wave 20
PostSync Phase: Wave 0 → Wave 5
```

---

## Section 9: Introduction to Argo Rollouts

### Why Deployments Are Not Enough

| Limitation | Problem |
|-----------|---------|
| **Too fast / all-or-nothing** | Rolling update proceeds to completion ASAP. No concept of "let's pause and observe." |
| **Success poorly defined** | Readiness probes only check if the pod accepts traffic, not if the app logic is correct |
| **No traffic control** | New pods immediately receive live user traffic once ready. Can't do 5% canary split. |
| **Rollback = another rolling update** | No instant switch-back. It's just another rolling update in reverse. |

> 🎯 **Interview:** "Kubernetes Deployments handle pod lifecycle well, but they lack sophisticated release strategies. Argo Rollouts adds canary and blue-green strategies with traffic management, analysis, and automated rollbacks on top of the existing Deployment model."

---

### Installing Argo Rollouts

```bash
# Add Helm repo (if not already added)
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Install Argo Rollouts
helm upgrade argo-rollouts argo/argo-rollouts \
  --version 2.4.5 \
  --install \
  --create-namespace \
  --namespace argo-rollouts

# Install kubectl plugin (Mac)
curl -LO https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-darwin-amd64
chmod +x kubectl-argo-rollouts-darwin-amd64
sudo mv kubectl-argo-rollouts-darwin-amd64 /usr/local/bin/kubectl-argo-rollouts

# Verify
kubectl argo rollouts version
```

> ⚡ **Argo Rollouts and Argo CD are independent projects.** You can use Rollouts without CD, and vice versa.

---

### Argo Rollouts Dashboard

**Enable via Helm values:**
```yaml name=values.yaml
dashboard:
  enabled: true
```

```bash
helm upgrade argo-rollouts argo/argo-rollouts \
  --version 2.4.5 \
  --install \
  --namespace argo-rollouts \
  --values values.yaml
```

**Access the dashboard:**
```bash
# Option 1: Port forward
kubectl port-forward svc/argo-rollouts-dashboard -n argo-rollouts 31000:3100

# Option 2: kubectl plugin
kubectl argo rollouts dashboard
# Opens on localhost:3100
```

---

## Section 10: Core Rollout Strategies

### The Rollout CRD

A Rollout is nearly identical to a Deployment, with two key differences:

```yaml name=rollout.yaml
apiVersion: argoproj.io/v1alpha1     # Changed from apps/v1
kind: Rollout                         # Changed from Deployment
metadata:
  name: simple-color-app
spec:
  replicas: 5
  selector:
    matchLabels:
      app: simple-color-app
  template:                           # Identical to Deployment template
    metadata:
      labels:
        app: simple-color-app
    spec:
      containers:
        - name: app
          image: lmacademy/simple-color-app:1.0.0
          env:
            - name: APP_COLOR
              value: red
  strategy:                           # NEW: Required field
    canary:                           # or blueGreen
      steps:
        - setWeight: 20
        - pause: {}                   # Indefinite pause (manual promotion)
```

**Migration from Deployment:**
1. Change `apiVersion` from `apps/v1` to `argoproj.io/v1alpha1`
2. Change `kind` from `Deployment` to `Rollout`
3. Add `strategy` field (required — without it, rollout is `Degraded`)

> ⚠️ **Common Mistake:** Creating a Rollout without a `strategy` field. kubectl will accept it, but the Rollout will be in `Degraded` state with "InvalidSpec: missing strategy field".

---

### Your First Canary Rollout

**Canary strategy** gradually shifts traffic from old to new version:

```yaml
strategy:
  canary:
    steps:
      - setWeight: 20          # 20% of pods = new version
      - pause: {}              # Wait for manual promotion
      - setWeight: 50
      - pause: {duration: 30s} # Auto-continue after 30s
      - setWeight: 80
      - pause: {duration: 30s}
      # After all steps: 100% new version
```

**Triggering an update:** Change anything in the pod template (env var, image tag, etc.) and apply:
```bash
kubectl apply -f rollout.yaml
```

**Monitor with CLI:**
```bash
kubectl argo rollouts get rollout simple-color-app --watch
```

**Promote (skip the pause):**
```bash
kubectl argo rollouts promote simple-color-app
```

**In the first release** (no previous version), all steps execute immediately — there's nothing to canary against.

---

### Blue-Green Deployments

**How it works:**

```
Stage 1: Only Blue (stable) environment, receiving 100% traffic
         
Stage 2: Green (preview) environment spun up alongside Blue
         Both fully scaled. Blue still serves traffic.
         Green accessible via preview service for testing.

Stage 3: Switch — Green becomes the new Blue (active)
         Old Blue scaled down after configurable delay
```

**Key characteristic:** Green is **fully scaled** (same resources as Blue). This means **double infrastructure cost** during the transition.

```yaml name=bluegreen-rollout.yaml
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: rollout-bluegreen
  namespace: bluegreen-lab
spec:
  replicas: 5
  selector:
    matchLabels:
      app: rollout-bluegreen
  template:
    metadata:
      labels:
        app: rollout-bluegreen
    spec:
      containers:
        - name: app
          image: lmacademy/simple-color-app:1.0.0
          env:
            - name: APP_COLOR
              value: blue
  strategy:
    blueGreen:
      activeService: rollout-bluegreen-active      # Points to stable (Blue)
      previewService: rollout-bluegreen-preview     # Points to new (Green)
      autoPromotionEnabled: false                   # Require manual promotion
      # scaleDownDelaySeconds: 30                   # Wait before scaling down old version
```

**You must create TWO services yourself:**
```yaml name=bluegreen-services.yaml
apiVersion: v1
kind: Service
metadata:
  name: rollout-bluegreen-active
spec:
  ports:
    - port: 3000
  selector:
    app: rollout-bluegreen
---
apiVersion: v1
kind: Service
metadata:
  name: rollout-bluegreen-preview
spec:
  ports:
    - port: 3000
  selector:
    app: rollout-bluegreen
```

**How Argo Rollouts manages traffic:** It dynamically modifies the service selectors by adding a `rollouts-pod-template-hash` label that matches the specific ReplicaSet (Blue or Green).

**Promote:**
```bash
kubectl argo rollouts promote rollout-bluegreen -n bluegreen-lab
```

After promotion, old version stays for `scaleDownDelaySeconds` (default 30s) then scales down.

---

### Canary Deployments In-Depth

**Key difference from Blue-Green:** Canary is a **gradual** traffic shift. You don't need double infrastructure.

```
Stage 1: 100% → Stable
Stage 2: 80% Stable, 20% Canary (small footprint)
Stage 3: 50/50
Stage 4: 10% Stable, 90% Canary
Stage 5: 100% → Canary becomes new Stable
```

**Three-service pattern for Canary:**
```yaml
# 1. Public service: Users hit this, traffic split by pod count
# 2. Stable service: Always points to stable pods
# 3. Preview/Canary service: Always points to canary pods
```

This allows testers to reliably hit the canary version via the canary service, while users get the weighted split via the public service.

---

## Section 11: Advanced Traffic Management

### Limitations of Replica-Weighted Strategies

| Problem | Example |
|---------|---------|
| **Imprecise splits** | Can't do 10% with 2 replicas. Need 10 pods minimum for 10% granularity. |
| **Forced overprovisioning** | Need 10 pods just to get a 10/90 split, even if 3 pods handle the load |
| **No header-based routing** | Can't predictably route QA traffic to canary version |

**Solution:** Use the **Gateway API** with an ingress controller (like Traefik) so traffic splitting happens at the HTTP layer, not the pod-count layer.

---

### Gateway API & Traefik Setup

**Install Gateway API CRDs:**
```bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.4.0/standard-install.yaml
```

**Install Traefik with Gateway API support:**
```bash
helm repo add traefik https://traefik.github.io/charts
helm repo update

helm upgrade traefik traefik/traefik \
  --version 37.4.0 \
  --install \
  --create-namespace \
  --namespace traefik \
  --values traefik-values.yaml
```

**Install Argo Rollouts Gateway API Plugin** (via init container in the Argo Rollouts Helm values):
```yaml name=values-rollouts.yaml
dashboard:
  enabled: true

controller:
  trafficRouterPlugins:
    trafficRouterPlugins: |
      - name: "argoproj-labs/gatewayAPI"
        location: "file:///plugins/gateway-api-plugin"
  initContainers:
    - name: copy-gateway-api-plugin
      image: quay.io/argoprojlabs/rollouts-plugin-trafficrouter-gatewayapi:v0.8.0
      command: ["/bin/sh", "-c"]
      args: ["cp /bin/gateway-api-plugin /plugins/"]
      volumeMounts:
        - name: gateway-api-plugin
          mountPath: /plugins
  volumes:
    - name: gateway-api-plugin
      emptyDir: {}
  volumeMounts:
    - name: gateway-api-plugin
      mountPath: /plugins
```

> ⚡ The plugin name `argoproj-labs/gatewayAPI` must match exactly in your rollout strategy configuration.

---

### Traffic-Weighted Canary Deployments

With Gateway API, traffic splitting happens at the **HTTPRoute** level, not pod count:

```yaml name=rollout-gateway.yaml
spec:
  strategy:
    canary:
      canaryService: rollout-gateway-canary
      stableService: rollout-gateway-stable
      trafficRouting:
        plugins:
          argoproj-labs/gatewayAPI:
            httpRoute: rollout-gateway-route
            namespace: gateway-lab
      steps:
        - setWeight: 30
        - pause: {}
        - setWeight: 50
        - pause: {duration: 60s}
        - setWeight: 80
        - pause: {duration: 60s}
```

**How it works:** Argo Rollouts dynamically modifies the `backendRefs` weights in the HTTPRoute resource:
```yaml
# HTTPRoute - managed by Argo Rollouts:
rules:
  - backendRefs:
      - name: rollout-gateway-stable
        weight: 70        # Dynamically set by Argo Rollouts
      - name: rollout-gateway-canary
        weight: 30        # Dynamically set by Argo Rollouts
```

**Dynamic stable scaling** to avoid double infrastructure:
```yaml
strategy:
  canary:
    dynamicStableScale: true    # Scale down stable as canary scales up
```

---

### Header-Based Routing

**What:** Route traffic to canary based on a specific HTTP header value, regardless of weight settings.

**Why:** QA testers can reliably hit the canary version 100% of the time, while public users get the weighted split.

```yaml
strategy:
  canary:
    canaryService: rollout-gateway-canary
    stableService: rollout-gateway-stable
    trafficRouting:
      plugins:
        argoproj-labs/gatewayAPI:
          httpRoute: rollout-gateway-route
          namespace: gateway-lab
      managedRoutes:
        - name: gateway-override          # Must match setHeaderRoute name
    steps:
      - setWeight: 1                       # Tiny public traffic to canary
      - pause: {duration: 20s}
      - setCanaryScale:
          weight: 40                       # Scale up canary pods (not traffic!)
      - setHeaderRoute:                    # Enable header-based routing
          name: gateway-override
          match:
            - headerName: x-canary
              headerValue:
                exact: "true"
      - pause: {}                          # Wait for testing
      - setWeight: 30                      # Begin public promotion
      - pause: {duration: 60s}
```

**Testing:**
```bash
# Public user — gets weighted split
curl http://color-app.localhost

# QA tester — ALWAYS hits canary
curl -H "x-canary: true" http://color-app.localhost
```

---

## Section 12: Automated Analysis & Promotion

### Prometheus & Metrics Architecture

```
┌──────────────────────────────────────────────────┐
│                 Kubernetes Cluster                │
│                                                  │
│  ┌──────────────┐    scrapes     ┌────────────┐  │
│  │  Prometheus   │◀─────────────│  Your App   │  │
│  │  Server       │   /metrics    │  (pods)     │  │
│  └──────┬───────┘                └────────────┘  │
│         │                                        │
│  ┌──────▼───────┐  ┌──────────────┐             │
│  │ Alert Manager │  │ Kube State   │             │
│  │              │  │ Metrics      │             │
│  └──────────────┘  └──────────────┘             │
│                                                  │
│  ┌──────────────┐  ┌──────────────┐             │
│  │ Node Exporter │  │ Push Gateway │             │
│  │ (per node)   │  │ (short jobs) │             │
│  └──────────────┘  └──────────────┘             │
└──────────────────────────────────────────────────┘
```

**Service Discovery:** Prometheus finds targets via pod/service annotations:
```yaml
annotations:
  prometheus.io/scrape: "true"
  prometheus.io/port: "3000"
  prometheus.io/path: "/metrics"
```

---

### Installing Prometheus

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm upgrade --install prometheus prometheus-community/prometheus \
  --version 27.49.0 \
  --namespace monitoring \
  --create-namespace \
  --values prometheus-values.yaml
```

```yaml name=prometheus-values.yaml
server:
  global:
    scrape_interval: 15s    # Default is 1 minute; 15s for faster feedback
```

---

### Analysis Templates & Runs

**AnalysisTemplate** — the blueprint defining what to measure and what success looks like:

```yaml name=analysis.yaml
apiVersion: argoproj.io/v1alpha1
kind: AnalysisTemplate
metadata:
  name: success-rate
  namespace: analysis-lab
spec:
  args:
    - name: service-name           # Parameterized for reuse
    - name: initial-delay
      value: "5s"                  # Default value (optional arg)
    - name: success-threshold
      value: "0.95"
  metrics:
    - name: success-rate
      interval: 5s                 # Measure every 5 seconds
      count: 60                    # Total measurements (5s × 60 = 5 minutes)
      failureLimit: 3              # Fail after 4 failures
      initialDelay: "{{ args.initial-delay }}"
      successCondition: "result[0] >= {{ args.success-threshold }}"
      provider:
        prometheus:
          address: http://prometheus-server.monitoring.svc.cluster.local:80
          query: |
            sum(rate(http_request_duration_seconds_count{
              code!~"[45].*",
              service="{{args.service-name}}"
            }[1m]))
            /
            sum(rate(http_request_duration_seconds_count{
              service="{{args.service-name}}"
            }[1m]))
```

**Query breakdown:**

```
Numerator:   sum(rate(requests{code NOT 4xx/5xx}[1m]))  = successful requests/sec
Denominator: sum(rate(requests{all codes}[1m]))          = total requests/sec
Result:      Success rate (0.0 to 1.0)
```

| PromQL Function | What It Does |
|----------------|--------------|
| `http_request_duration_seconds_count` | Counter: total number of HTTP requests |
| `[1m]` | Look at the last 1-minute window of samples |
| `rate(...)` | Calculate per-second average rate of increase |
| `sum(...)` | Aggregate across all pods/instances |
| `code!~"[45].*"` | Regex: exclude 4xx and 5xx status codes |

---

### Self-Healing Rollouts with Analysis

**As a step in canary (runs once at a specific point):**
```yaml
strategy:
  canary:
    steps:
      - setWeight: 20
      - pause: {duration: 3m}        # Let metrics populate
      - analysis:                     # Run analysis HERE
          templates:
            - templateName: success-rate
          args:
            - name: service-name
              value: analysis-canary
```

**As a background analysis (runs throughout the entire rollout):**
```yaml
strategy:
  canary:
    analysis:                          # At the canary level, not under steps
      templates:
        - templateName: success-rate
      args:
        - name: service-name
          value: analysis-canary
      startingStep: 2                  # Start after step 2
    steps:
      - setWeight: 20
      - pause: {duration: 2m}
      - setWeight: 40
      - pause: {duration: 2m}
      - setWeight: 80
      - pause: {duration: 2m}
```

**Background analysis is better** because step-based analysis only checks at one weight level. At 20% weight with 10% app error rate, the overall error rate is only 2% (passes 95% threshold). But at 80% weight, it becomes 8% (fails). Background analysis catches this as traffic increases.

**What happens when analysis fails:**
```
Analysis fails → Argo Rollouts automatically rolls back → Stable version restored
```

---

### Analysis in Blue-Green Deployments

**Pre-promotion analysis:** Blocks promotion until analysis passes.

```yaml
strategy:
  blueGreen:
    activeService: bluegreen-active
    previewService: bluegreen-preview
    autoPromotionEnabled: false
    prePromotionAnalysis:
      templates:
        - templateName: success-rate
      args:
        - name: service-name
          value: bluegreen-preview     # Analyze the PREVIEW service
        - name: initial-delay
          value: "2m"                  # Wait for metrics to populate
```

> ⚠️ **Important:** Generate traffic to the **preview service** during pre-promotion analysis. The active service still points to the old version — analyzing it would show 100% success (old working version).

**Post-promotion analysis** runs after the switch, but by then you've already promoted a potentially buggy version. Pre-promotion is safer.

---

## Common Interview Questions

**Q: What is GitOps?**
> GitOps uses Git as the single source of truth for declarative infrastructure. An operator (like Argo CD) continuously reconciles the live cluster state with the desired state in Git.

**Q: How is Argo CD different from traditional CI/CD?**
> Traditional CI/CD pushes changes to the cluster. Argo CD pulls the desired state from Git and applies it. This eliminates the need for CI/CD to have cluster credentials and provides automatic drift detection.

**Q: What happens if someone manually changes the cluster?**
> With self-heal enabled, Argo CD detects the drift within seconds and reverts the change to match Git. Without self-heal, it marks the app as OutOfSync.

**Q: Does Argo CD run `helm install`?**
> No. It uses Helm only as a template engine (`helm template`), then applies the generated YAML with `kubectl apply`. There are no Helm releases, no Helm history.

**Q: What's the difference between Canary and Blue-Green?**
> Blue-Green deploys a full copy of the new version alongside the old (double resources), then switches all traffic at once. Canary gradually shifts traffic percentage, requiring less infrastructure and exposing fewer users to potential bugs.

**Q: How does Argo Rollouts decide to roll back?**
> Using Analysis Templates that query metrics providers (like Prometheus). If the success condition fails beyond the failure limit, Argo Rollouts automatically rolls back to the stable version.

**Q: What are sync waves?**
> Annotations that define the order resources are applied within a sync phase. Lower numbers go first. Use multiples of 10 to leave room for future additions.

---

## Production Best Practices Checklist

| Area | Best Practice |
|------|--------------|
| **Repository** | Separate config repo from app repo |
| **Versions** | Use Git tags/SHAs for `targetRevision`, never `HEAD` in production |
| **Projects** | Create per-team projects with restricted sourceRepos and destinations |
| **Sync Policy** | Enable auto-sync + prune + selfHeal only with mature CI/CD |
| **Secrets** | Never commit secrets. Use External Secrets Operator + Vault/AWS SM |
| **Helm Values** | Use `valueFiles` for env-specific config, `parameters` for CI-driven values |
| **Sync Waves** | Use multiples of 10 for wave numbers |
| **Rollouts** | Use Gateway API for precise traffic splitting, not replica-weighted |
| **Analysis** | Run background analysis (not step-based) for comprehensive coverage |
| **Namespaces** | Isolate Argo CD, Argo Rollouts, and monitoring in dedicated namespaces |
| **RBAC** | Use Projects + Kubernetes RBAC. Give view-only dashboard access. |
| **Monitoring** | Set Prometheus scrape interval to 15s for faster analysis feedback |
| **Hooks** | Use PreSync for migrations, PostSync for notifications |
| **Debugging** | Temporarily disable selfHeal. Check `argocd app get <name>` for sync errors. |
