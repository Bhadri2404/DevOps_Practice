# ArgoCD Complete Study Notes
### From Udemy Course Transcripts — Sections 1 & 2

> **Audience:** DevOps Engineers and SREs who want a deep, practical, interview-ready reference to ArgoCD.
> **Tools Assumed:** Docker, kubectl, Helm, minikube/Kind/EKS, VS Code.

---

## Table of Contents

1. [Course Prerequisites & Environment Setup](#1-course-prerequisites--environment-setup)
2. [Introduction to GitOps](#2-introduction-to-gitops)
3. [ArgoCD Architecture & Components](#3-argocd-architecture--components)
4. [Installing ArgoCD via Helm](#4-installing-argocd-via-helm)
5. [Accessing ArgoCD — UI & CLI](#5-accessing-argocd--ui--cli)
6. [ArgoCD Application CRD](#6-argocd-application-crd)
7. [Deploying Your First Application](#7-deploying-your-first-application)
8. [Sync Process & Application States](#8-sync-process--application-states)
9. [Helm Integration with ArgoCD](#9-helm-integration-with-argocd)
10. [Automated Sync, Pruning & Self-Healing](#10-automated-sync-pruning--self-healing)
11. [Private Repository Authentication](#11-private-repository-authentication)
12. [ArgoCD Projects & Multi-Tenancy](#12-argocd-projects--multi-tenancy)
13. [Sync Phases & Hooks](#13-sync-phases--hooks)
14. [Sync Waves](#14-sync-waves)
15. [Argo Rollouts — Canary & Blue-Green](#15-argo-rollouts--canary--blue-green)
16. [Quick-Reference Command Cheatsheet](#16-quick-reference-command-cheatsheet)
17. [Common Mistakes & Interview Tips](#17-common-mistakes--interview-tips)

---

## 1. Course Prerequisites & Environment Setup

### What You Need Installed

| Tool | Purpose |
|------|---------|
| Docker | Container runtime |
| kubectl | Communicate with Kubernetes API |
| Helm | Package manager for Kubernetes charts |
| minikube / Kind / EKS | Local or remote Kubernetes cluster |
| ArgoCD CLI (`argocd`) | Command-line interaction with ArgoCD server |
| VS Code + Kubernetes extension | IDE for writing manifests |

### Windows Users — WSL Setup

Windows users should enable Windows Subsystem for Linux (WSL) for full compatibility with course commands:

1. Go to **Start → Turn Windows features on or off**
2. Enable **Windows Subsystem for Linux**
3. Restart your machine
4. Install Ubuntu from the Microsoft Store
5. Set username and password when prompted
6. Access WSL from terminal: `wsl`

**VS Code Integration with WSL:**
- Install the **Remote - WSL** extension in VS Code
- Connect VS Code directly to your Ubuntu WSL: click the Remote Explorer icon → select Ubuntu → Connect in Current Window
- Any terminal opened inside VS Code will be a Linux shell

> **Production Note:** Always use Linux/WSL for compatibility. Windows-native kubectl/Helm commands can behave differently from Unix-based systems.

---

## 2. Introduction to GitOps

### What Is GitOps?

GitOps is a methodology where **Git is the single source of truth** for your system's desired state. Instead of running `kubectl apply` or `helm upgrade` directly from a pipeline, you commit changes to Git and a reconciliation agent (ArgoCD) continuously pulls those changes and applies them to the cluster.

### The Traditional Push Model (and Its Problems)

**How push works:**

```
Developer git push
  → CI/CD pipeline triggered
  → Build → Test → Security Audit → Docker build + push
  → kubectl apply / helm upgrade → cluster state changes
```

**Problems with Push:**

| Problem | Description |
|---------|-------------|
| **Configuration Drift** | A developer runs `kubectl scale deploy/app --replicas=0`. Git still says 3. Nobody knows the real desired state. |
| **Poor Auditability** | No audit trail. Who changed what and why? |
| **Stressful Rollbacks** | Manual hunt for last good artifact, re-run pipeline, pray it works. |
| **Inconsistent Environments** | Dev, staging, prod configs diverge over time and become hard to reason about. |

---

### The GitOps Pull Model (ArgoCD Way)

**How GitOps works:**

```
Developer git push
  → CI/CD pipeline triggered
  → Build → Test → Security Audit → Docker build + push
  → Update IMAGE TAG in Config Repo (separate from app repo)
  → ArgoCD detects diff between Config Repo (desired) and Cluster (live)
  → ArgoCD syncs cluster to match desired state
```

**Key difference:** The CI/CD pipeline **no longer touches the cluster directly**. It only updates the config repository. ArgoCD handles the rest.

**Best Practice — Separate Repositories:**

```
app-repo/         ← Application source code
  src/
  Dockerfile
  ...

config-repo/      ← Kubernetes manifests / Helm values
  base/
  overlays/
    dev/
    staging/
    prod/
```

Keeping them separate means:
- Clear boundary between "what the app does" and "how it is deployed"
- Config repo can have its own PR review process
- Different teams can own each repo

---

### The Four GitOps Principles

| # | Principle | What it Means |
|---|-----------|---------------|
| 1 | **Declarative** | Express *what* you want, not *how* to achieve it. (Deployment with 3 replicas, not `kubectl scale`) |
| 2 | **Versioned & Immutable** | State stored in Git. Every commit has a hash. Tags should never be moved. |
| 3 | **Pulled Automatically** | ArgoCD continuously polls the config repo for changes — no manual triggering needed. |
| 4 | **Continuously Reconciled** | ArgoCD constantly compares live cluster state with desired state and attempts to converge them. |

> **Interview Point:** "What are the 4 GitOps principles?" — Declarative, Versioned/Immutable, Pulled Automatically, Continuously Reconciled.

---

### Drift Detection & Self-Healing

- **Configuration Drift** = live cluster state ≠ desired state in Git
- ArgoCD detects this automatically
- If `selfHeal: true` is set, ArgoCD will **automatically revert** any manual changes made to the cluster

```
Example: A developer runs:
  kubectl scale deployment/guestbook --replicas=0

ArgoCD sees: Desired = 3, Live = 0 → OUT OF SYNC
If selfHeal: true → ArgoCD immediately scales back to 3
```

---

## 3. ArgoCD Architecture & Components

When you install ArgoCD via Helm, the following pods are created inside the `argocd` namespace:

```
kubectl get pods -n argocd
```

### Component Overview

```
                ┌────────────────────────────────────────────┐
                │              ARGOCD NAMESPACE               │
                │                                            │
  ┌─────────┐   │  ┌─────────────────┐   ┌───────────────┐  │
  │   UI /  │──▶│  │   API Server    │──▶│  Repo Server  │  │
  │  CLI    │   │  │  (argocd-server)│   │               │  │
  └─────────┘   │  └────────┬────────┘   └───────┬───────┘  │
                │           │                    │           │
  ┌─────────┐   │           ▼                    ▼           │
  │  gRPC / │──▶│  ┌─────────────────┐   ┌───────────────┐  │
  │  REST   │   │  │  App Controller │   │     Redis     │  │
  └─────────┘   │  │  (reconcile)    │   │   (cache)     │  │
                │  └────────┬────────┘   └───────────────┘  │
                │           │                                │
                │           ▼                                │
                │  ┌─────────────────┐   ┌───────────────┐  │
                │  │  Dex Server     │   │  AppSet Ctrl  │  │
                │  │  (SSO/OIDC)     │   │               │  │
                │  └─────────────────┘   └───────────────┘  │
                └────────────────────────────────────────────┘
                           │
                           ▼
              ┌─────────────────────────┐
              │   Kubernetes Cluster    │
              │  (target namespaces)    │
              └─────────────────────────┘
```

### Component Roles

| Component | Role |
|-----------|------|
| **API Server** (`argocd-server`) | External-facing. Serves the Web UI, CLI, and REST/gRPC API. All human/tool interactions go through here. |
| **Repository Server** (`argocd-repo-server`) | Connects to Git repos. Clones, caches, and generates final Kubernetes manifests (for plain YAML, Helm, Kustomize). |
| **Application Controller** (`argocd-application-controller`) | Compares desired state (from repo server) with live state (from Kubernetes API). Triggers sync. Runs lifecycle hooks. |
| **Redis** | Caching layer for manifest generation results. Reduces repeated Git calls. |
| **Dex Server** (`argocd-dex-server`) | Identity Provider (IdP) supporting OIDC and SAML. Used for SSO integration (GitHub, Okta, etc.). |
| **ApplicationSet Controller** | Manages `ApplicationSet` CRDs to generate and manage multiple ArgoCD `Application` resources at scale. |

> **Interview Point:** "What component handles Git communication?" — The **Repository Server**. "What does the Application Controller do?" — It continuously reconciles desired state vs live state.

---

## 4. Installing ArgoCD via Helm

### Step-by-Step Installation

```bash
# Step 1: Add ArgoCD Helm repo
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Step 2: Search available versions
helm search repo argo/argo-cd --versions

# Step 3: Create the argocd namespace
kubectl create namespace argocd
# OR via manifest:
# kubectl apply -f argocd-namespace.yaml

# Step 4: Install ArgoCD (version 8.6.0 recommended)
helm upgrade argocd argo/argo-cd \
  --version 8.6.0 \
  --install \
  --create-namespace \
  --namespace argocd

# Step 5: Verify all pods are running
kubectl get pods -n argocd
```

**Expected pods after installation:**
```
argocd-application-controller-0          Running
argocd-applicationset-controller-...     Running
argocd-dex-server-...                    Running
argocd-notifications-controller-...      Running
argocd-redis-...                         Running
argocd-repo-server-...                   Running
argocd-server-...                        Running
```

> **Best Practice:** Always install ArgoCD in its own dedicated `argocd` namespace. This provides namespace-level RBAC isolation and makes it easier to manage.

> **Common Mistake:** Installing ArgoCD in the `default` namespace. This creates security and management issues.

---

## 5. Accessing ArgoCD — UI & CLI

### Access the Web UI (Local Cluster)

```bash
# Port-forward the argocd-server service to localhost:8080
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Open in browser: https://localhost:8080
# Username: admin
```

### Get Initial Admin Password

```bash
# Get the initial admin password (base64 encoded in a Secret)
kubectl get secret argocd-initial-admin-secret \
  -n argocd \
  -o jsonpath="{.data.password}" | base64 -d

# Copy the output (without the trailing %)
```

> **Security Note:** The `argocd-initial-admin-secret` should be deleted after changing the password. ArgoCD recommends this to prevent accidental credential exposure.

---

### Install & Use the ArgoCD CLI

```bash
# macOS (Homebrew)
brew install argocd

# Linux / WSL
curl -sSL -o argocd-linux-amd64 \
  https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
chmod +x argocd-linux-amd64
sudo mv argocd-linux-amd64 /usr/local/bin/argocd

# Verify
argocd version
```

### Login via CLI

```bash
# Login to your local ArgoCD instance
argocd login localhost:8080 \
  --username admin \
  --password <your-password> \
  --insecure \
  --name local   # saves context as "local"

# List saved contexts
argocd context

# Get current user info
argocd account get-user-info

# Change password
argocd account update-password

# List applications
argocd app list
```

> **Interview Point:** The `--insecure` flag bypasses TLS certificate verification — only for local dev. In production, always use valid TLS certificates.

---

## 6. ArgoCD Application CRD

### What Is the Application CRD?

The **Application** is the core Custom Resource Definition (CRD) in ArgoCD. It is a Kubernetes resource (kind: `Application`) that acts as a **declarative contract** telling ArgoCD:

1. **Where to find** the desired Kubernetes manifests (source)
2. **Where to deploy** them (destination cluster + namespace)
3. **How to sync** (automated, manual, with/without pruning)

### Application CRD vs Regular Kubernetes Resources

| Aspect | ArgoCD Application | Standard K8s Resources (Deployment, Service, etc.) |
|--------|--------------------|------------------------------------------------------|
| Kind | `Application` | `Deployment`, `Service`, `ConfigMap`, etc. |
| API Group | `argoproj.io/v1alpha1` | `apps/v1`, `v1`, etc. |
| Managed by | ArgoCD controllers | Kubernetes core controllers |
| Purpose | Instructs ArgoCD to manage a set of manifests | The actual workload/config |
| Namespace | Lives in `argocd` namespace | Lives in target namespace |

---

### Full Application Manifest Explained

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd       # Application resource lives in argocd namespace
spec:
  # ── PROJECT ──────────────────────────────────────────────────────────────
  project: default        # Which ArgoCD project this belongs to
                          # Use named projects for RBAC & multi-tenancy

  # ── SOURCE ──────────────────────────────────────────────────────────────
  source:
    repoURL: https://github.com/argoproj/argocd-example-apps.git
    targetRevision: HEAD  # Branch, tag, or commit SHA
    path: guestbook       # Path inside the repo where manifests live

  # ── DESTINATION ─────────────────────────────────────────────────────────
  destination:
    server: https://kubernetes.default.svc   # Target cluster (in-cluster)
    namespace: guestbook                      # Namespace to deploy into

  # ── SYNC POLICY ─────────────────────────────────────────────────────────
  syncPolicy:
    automated:
      prune: true         # Delete resources removed from Git
      selfHeal: true      # Revert manual changes to cluster
    syncOptions:
      - CreateNamespace=true  # Auto-create destination namespace if missing
```

> **Production Tip:** For multi-cluster setups, change `server: https://kubernetes.default.svc` to the URL of your target cluster registered in ArgoCD.

---

### Source Types

ArgoCD supports multiple source types:

```yaml
# Plain YAML / Kustomize
source:
  repoURL: https://github.com/myorg/config-repo.git
  path: manifests/production
  targetRevision: v1.2.0

# Helm Chart from Repo
source:
  repoURL: https://charts.bitnami.com/bitnami
  chart: nginx
  targetRevision: "13.2.0"
  helm:
    values: |
      replicaCount: 3

# Helm with values file from repo
source:
  repoURL: https://github.com/myorg/config-repo.git
  path: helm-guestbook
  targetRevision: HEAD
  helm:
    valueFiles:
      - values-prod.yaml
```

---

## 7. Deploying Your First Application

### Lab: Deploy Guestbook App

```bash
# Create the application manifest
cat <<EOF > guestbook-app.yaml
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
    namespace: guestbook
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
EOF

# Apply to cluster
kubectl apply -f guestbook-app.yaml

# Verify application was created
argocd app list
argocd app get guestbook
```

After creation, the app will be **OutOfSync** — it exists in ArgoCD but hasn't been deployed yet. Trigger a sync:

```bash
# Manual sync via CLI
argocd app sync guestbook

# Or via kubectl
kubectl patch application guestbook -n argocd \
  --type merge \
  -p '{"operation": {"sync": {}}}'
```

---

## 8. Sync Process & Application States

### Sync Status vs Health Status

These are **two different things** in ArgoCD:

| Status Type | Values | Meaning |
|-------------|--------|---------|
| **Sync Status** | `Synced`, `OutOfSync` | Does live cluster match desired state in Git? |
| **Health Status** | `Healthy`, `Degraded`, `Progressing`, `Suspended`, `Missing`, `Unknown` | Are the Kubernetes resources actually working? |

**Example Scenario:**
- You deploy a Deployment with a bad image → Sync Status = `Synced` (Git matches cluster)
- But pods are crash-looping → Health Status = `Degraded`

> **Interview Point:** An app can be `Synced` but `Degraded`. Sync only checks config match — not runtime health.

---

### The Full GitOps Reconciliation Loop

```
1. Developer commits to config repo
        ↓
2. ArgoCD Repo Server polls repo (every 3 min by default, or webhook)
        ↓
3. Repo Server generates final Kubernetes manifests
        ↓
4. Application Controller compares desired (from repo) vs live (from K8s API)
        ↓
5. If diff found → mark application OutOfSync
        ↓
6a. Manual sync: User clicks "Sync" in UI or runs `argocd app sync`
6b. Automated sync (if configured): ArgoCD auto-applies changes
        ↓
7. Resources created/updated in target cluster
        ↓
8. Application Controller verifies health → marks Healthy or Degraded
```

---

### Sync Options Reference

```yaml
syncPolicy:
  automated:
    prune: true      # Remove resources deleted from Git
    selfHeal: true   # Revert manual kubectl changes
  syncOptions:
    - CreateNamespace=true        # Create namespace if it doesn't exist
    - PrunePropagationPolicy=foreground  # Wait for child resources to delete
    - PruneLast=true              # Prune after all resources are synced
    - RespectIgnoreDifferences=true
    - Replace=true                # Use kubectl replace instead of apply
```

---

## 9. Helm Integration with ArgoCD

### Why Helm with ArgoCD?

Helm provides templating and parameterization for Kubernetes manifests. ArgoCD has **native Helm support** — it renders Helm charts and manages the resulting Kubernetes resources through GitOps.

> **Important:** ArgoCD does **not** use `helm install`/`helm upgrade` under the hood. It renders the Helm templates itself using the `helm template` command and then applies the output via `kubectl`. This means Helm `--atomic` rollback behavior is **not used** — ArgoCD manages rollback through Git.

---

### Application Manifest for a Helm Chart

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
    targetRevision: HEAD
    path: helm-guestbook
    helm:
      # Option 1: Inline values
      values: |
        replicaCount: 2
        image:
          tag: "latest"

      # Option 2: Reference external values files in the same repo
      valueFiles:
        - values.yaml
        - values-prod.yaml

      # Option 3: Override specific parameters (takes highest precedence)
      parameters:
        - name: replicaCount
          value: "4"

      # Option 4: Release name override
      releaseName: my-guestbook

  destination:
    server: https://kubernetes.default.svc
    namespace: guestbook
  syncPolicy:
    automated:
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```

### Helm Value Override Precedence (Lowest → Highest)

```
1. Default values in chart (values.yaml)
       ↓
2. Custom values file referenced in valueFiles
       ↓
3. Inline values block in Application manifest
       ↓
4. Parameters block in Application manifest  ← Highest precedence
```

> **Common Mistake:** Defining the same key in both `values` and `parameters`. The `parameters` entry will always win.

---

### Deploying a Helm Chart from a Helm Repository (not Git)

```yaml
source:
  repoURL: https://charts.bitnami.com/bitnami  # Helm chart repo URL
  chart: nginx                                   # Chart name
  targetRevision: "13.2.0"                       # Chart version
  helm:
    values: |
      replicaCount: 3
      service:
        type: ClusterIP
```

---

## 10. Automated Sync, Pruning & Self-Healing

### The Three Automation Knobs

#### 1. Automated Sync

By default, ArgoCD **only reports** out-of-sync applications. You must manually click "Sync" or run `argocd app sync`. Enabling `automated` sync removes this manual step.

```yaml
syncPolicy:
  automated: {}   # Enable automated sync with defaults
```

**When to use:** When you have confidence in your CI/CD process (PR reviews, automated tests) and want full GitOps automation.

**Real-world scenario (AWS/EKS):** Your GitHub Actions pipeline updates the image tag in your config repo. With `automated` sync, ArgoCD immediately picks this up and deploys to EKS without any manual approval.

---

#### 2. Pruning

By default, ArgoCD will **NOT delete** resources from the cluster if their manifests are removed from Git. Pruning enables this cleanup.

```yaml
syncPolicy:
  automated:
    prune: true   # Delete orphaned resources
```

**Example:** You remove a `ConfigMap` from your Helm chart and push to Git. Without `prune: true`, the ConfigMap stays in the cluster forever. With `prune: true`, it gets deleted on the next sync.

> **Warning:** Enable pruning carefully. If you accidentally delete a manifest from Git, it will delete the live resource too.

---

#### 3. Self-Healing

Automated sync only triggers when the **desired state (Git) changes**. Self-healing also triggers when the **live state (cluster) changes** due to manual intervention.

```yaml
syncPolicy:
  automated:
    selfHeal: true   # Revert any manual cluster changes
```

**Example:** An operator runs `kubectl scale deploy/guestbook --replicas=0` for debugging. With `selfHeal: true`, ArgoCD immediately scales it back to whatever Git says.

**Temporary Disable for Debugging:**
```bash
# Temporarily disable self-heal for debugging
argocd app set guestbook --self-heal=false

# Do your debugging...

# Re-enable
argocd app set guestbook --self-heal=true
```

---

### Full Automation YAML Example

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: production-app
  namespace: argocd
spec:
  project: production
  source:
    repoURL: https://github.com/myorg/config-repo.git
    path: k8s/production
    targetRevision: main
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  syncPolicy:
    automated:
      prune: true      # Clean up deleted resources
      selfHeal: true   # Revert manual changes
    syncOptions:
      - CreateNamespace=true
      - PrunePropagationPolicy=foreground
```

---

## 11. Private Repository Authentication

### Why Private Repos Need Special Handling

When ArgoCD tries to clone a private repository without credentials, it will error:
```
ComparisonError: Failed to load target state: authentication required
```

ArgoCD stores repo credentials as **Kubernetes Secrets** in the `argocd` namespace with a specific label that ArgoCD uses to discover them.

---

### Method 1: HTTPS with Personal Access Token (PAT)

**Step 1: Create a fine-grained GitHub PAT**
- GitHub → Settings → Developer Settings → Personal Access Tokens → Fine-grained tokens
- Select only the target repository
- Give **Contents: Read** permission only (principle of least privilege)

**Step 2: Create via ArgoCD UI**
- Settings → Repositories → Connect Repo
- Connection Method: HTTPS
- Fill in Repository URL, Username, Password (PAT)

**Step 3: What ArgoCD creates behind the scenes**

```bash
kubectl get secrets -n argocd
# You'll see a secret named "repo-<hash>"

kubectl describe secret repo-<hash> -n argocd
# Data keys: url, username, password, type, project
```

**Step 4: Create manually with kubectl (declarative alternative)**

```bash
# IMPORTANT: Never commit this command to Git — it contains credentials!
kubectl create secret generic private-repo-https \
  --namespace argocd \
  --from-literal=type=git \
  --from-literal=url=https://github.com/myorg/private-repo.git \
  --from-literal=username=my-github-username \
  --from-literal=password=ghp_xxxxxxxxxxxxxxxxxxxx

# CRITICAL: Add the ArgoCD label so ArgoCD discovers this secret
kubectl label secret private-repo-https \
  -n argocd \
  argocd.argoproj.io/secret-type=repository
```

> **Common Mistake:** Creating the secret but forgetting to add the label `argocd.argoproj.io/secret-type=repository`. Without this label, ArgoCD will never discover the credentials.

---

### Method 2: SSH with Deploy Keys (Recommended for Production)

**Why SSH Deploy Keys are preferred over PATs:**

| Aspect | PAT | Deploy Key (SSH) |
|--------|-----|-----------------|
| User dependency | Yes — if user leaves org, PAT breaks | No — key is tied to the repository |
| Repository scope | Can be scoped, but user-level | One key per repository by default |
| Auditability | Moderate | Better |
| Rotation | Manual | Manual, but no user impact |
| Longevity | Short-lived by default | Long-lived |

**Step 1: Generate SSH key pair**

```bash
# Generate Ed25519 key pair (no passphrase for ArgoCD)
ssh-keygen -t ed25519 \
  -C "argocd-deploy-key" \
  -f ~/.ssh/argocd-deploy-key \
  -N ""  # Empty passphrase

# View the public key
cat ~/.ssh/argocd-deploy-key.pub

# View the private key (keep this secret!)
cat ~/.ssh/argocd-deploy-key
```

**Step 2: Add public key to GitHub repository**
- Repository → Settings → Deploy Keys → Add Deploy Key
- Paste the `.pub` key content
- **Do NOT** check "Allow write access" — read-only is enough

**Step 3: Create SSH secret in ArgoCD**

```bash
# Store private key in a variable
PRIVATE_KEY=$(cat ~/.ssh/argocd-deploy-key)

kubectl create secret generic private-repo-ssh \
  --namespace argocd \
  --from-literal=type=git \
  --from-literal=url=git@github.com:myorg/private-repo.git \
  --from-literal="sshPrivateKey=${PRIVATE_KEY}"

# Add the required label
kubectl label secret private-repo-ssh \
  -n argocd \
  argocd.argoproj.io/secret-type=repository
```

**Step 4: Update Application manifest to use SSH URL**

```yaml
source:
  repoURL: git@github.com:myorg/private-repo.git  # SSH URL, not HTTPS
  path: helm-charts/my-app
  targetRevision: HEAD
```

---

### Secret Schema Reference

**HTTPS Secret Schema:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: private-repo-https
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository   # REQUIRED
type: Opaque
stringData:
  type: git
  url: https://github.com/myorg/private-repo.git
  username: my-username
  password: ghp_xxxxxxxxx   # Personal Access Token
  project: default           # Optional: restrict to specific ArgoCD project
```

**SSH Secret Schema:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: private-repo-ssh
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository   # REQUIRED
type: Opaque
stringData:
  type: git
  url: git@github.com:myorg/private-repo.git
  sshPrivateKey: |
    -----BEGIN OPENSSH PRIVATE KEY-----
    ...your private key content...
    -----END OPENSSH PRIVATE KEY-----
```

> **Production Best Practice:** Don't manage these secrets via raw `kubectl create`. Use **AWS Secrets Manager + External Secrets Operator** or **HashiCorp Vault** to inject secrets dynamically into Kubernetes without storing credentials in Git or running long imperative commands.

---

### Cleanup: Deleting Credentials Securely

```bash
# Via ArgoCD UI: Settings → Repositories → Disconnect

# Via kubectl
kubectl delete secret private-repo-https -n argocd
kubectl delete secret private-repo-ssh -n argocd

# Delete GitHub deploy key: Repository Settings → Deploy Keys → Delete
# Delete GitHub PAT: Settings → Developer Settings → Personal Access Tokens → Delete
```

---

## 12. ArgoCD Projects & Multi-Tenancy

### What Is an ArgoCD Project?

A **Project** (`AppProject`) is an ArgoCD-level construct (NOT a Kubernetes namespace) that provides:
- Logical grouping of ArgoCD Applications
- Source repository restrictions (which repos can be used)
- Destination restrictions (which clusters/namespaces can be deployed to)
- Cluster-level resource restrictions (which resource types are allowed)
- RBAC policies for teams

**Use case:** Finance team should only deploy from their own repos, to their own namespaces — never to the `payments` namespace managed by a different team.

---

### Default Project

When you install ArgoCD, a `default` project is created automatically. All applications without an explicit project use `default`. The `default` project has no restrictions.

---

### AppProject Manifest

```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: finance-project
  namespace: argocd
spec:
  description: "Project for the Finance engineering team"

  # ── SOURCE REPOS ───────────────────────────────────────────────────
  sourceRepos:
    - https://github.com/myorg/finance-config.git    # Allowed
    - https://github.com/myorg/shared-charts.git     # Allowed
    - '!https://github.com/payments/config.git'      # Explicitly denied

  # ── DESTINATIONS ───────────────────────────────────────────────────
  destinations:
    - server: https://kubernetes.default.svc
      namespace: finance                # Only deploy to finance namespace
    - server: https://eks-prod.mycompany.com
      namespace: finance-prod

  # ── CLUSTER RESOURCE RESTRICTIONS ──────────────────────────────────
  clusterResourceWhitelist:
    - group: ""
      kind: Namespace       # Finance team can create namespaces
    - group: "rbac.authorization.k8s.io"
      kind: ClusterRole     # Can create ClusterRoles

  # ── NAMESPACE RESOURCE RESTRICTIONS ────────────────────────────────
  namespaceResourceBlacklist:
    - group: ""
      kind: ResourceQuota   # Finance team cannot create ResourceQuotas

  # ── ROLES (RBAC) ────────────────────────────────────────────────────
  roles:
    - name: finance-developer
      description: Finance team developer role
      policies:
        - p, proj:finance-project:finance-developer, applications, get, finance-project/*, allow
        - p, proj:finance-project:finance-developer, applications, sync, finance-project/*, allow
      groups:
        - finance-team   # Maps to SSO group
```

---

### Referencing a Project in an Application

```yaml
spec:
  project: finance-project   # Reference the AppProject name
  source:
    repoURL: https://github.com/myorg/finance-config.git
    ...
```

> **Interview Point:** Projects are ArgoCD-specific, not Kubernetes-level. They only restrict what ArgoCD can deploy — not what the cluster itself allows directly.

---

### Wildcard and Negation Syntax

| Pattern | Meaning |
|---------|---------|
| `*` | Any value |
| `!https://github.com/...` | Deny this specific URL |
| `https://github.com/myorg/*` | Any repo under myorg |

---

## 13. Sync Phases & Hooks

### What Are Sync Phases?

A single sync operation in ArgoCD is divided into **three main phases**, plus a failure phase:

```
┌────────────────────────────────────────────────────────────────┐
│                    SYNC OPERATION                              │
│                                                                │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐                 │
│  │ PreSync  │───▶│  Sync    │───▶│ PostSync │                 │
│  │  Phase   │    │  Phase   │    │  Phase   │                 │
│  └──────────┘    └──────────┘    └──────────┘                 │
│       │               │               │                        │
│       ▼               ▼               ▼                        │
│  Jobs with       App manifests +  Jobs with                    │
│  PreSync hook    Sync hook jobs   PostSync hook                │
│                                                                │
│  If any phase fails → SyncFail phase (cleanup/rollback)        │
└────────────────────────────────────────────────────────────────┘
```

---

### Hook Types

| Hook | When it Runs | Use Case |
|------|-------------|----------|
| `PreSync` | Before any manifests are applied | Database migration scripts, validation checks |
| `Sync` | During the main sync phase | Run alongside regular manifests |
| `PostSync` | After all manifests are applied and healthy | Integration tests, notifications, cache warming |
| `SyncFail` | If sync fails at any phase | Cleanup, rollback scripts, alert notifications |
| `PostDelete` | After all application resources are deleted | Final cleanup (available from ArgoCD v2.1+) |
| `Skip` | Applied to a resource to skip it during sync | Temporarily exclude a resource from sync |

---

### Defining a Hook (PreSync Example)

Hooks are defined as **Kubernetes Jobs** with a special annotation:

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migration
  annotations:
    argocd.argoproj.io/hook: PreSync          # This is a PreSync hook
    argocd.argoproj.io/hook-delete-policy: HookSucceeded  # Cleanup after success
spec:
  template:
    spec:
      containers:
        - name: migration
          image: flyway/flyway:9.0
          command: ["flyway", "migrate"]
          env:
            - name: FLYWAY_URL
              value: jdbc:postgresql://postgres-svc:5432/mydb
            - name: FLYWAY_USER
              valueFrom:
                secretKeyRef:
                  name: db-credentials
                  key: username
            - name: FLYWAY_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: db-credentials
                  key: password
      restartPolicy: Never
  backoffLimit: 2
```

---

### Hook Delete Policies

What happens to the Job pod after the hook completes?

| Policy | Behavior |
|--------|---------|
| `HookSucceeded` | Delete the hook resource when it succeeds |
| `HookFailed` | Delete the hook resource when it fails |
| `BeforeHookCreation` | Delete any existing resource of the same name before creating this one |

```yaml
annotations:
  argocd.argoproj.io/hook: PreSync
  argocd.argoproj.io/hook-delete-policy: HookSucceeded
```

> **Best Practice:** Always set a `hook-delete-policy`. Without it, Job pods accumulate in the namespace and waste resources.

---

### PostSync Hook Example (Smoke Test)

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: post-deploy-smoke-test
  annotations:
    argocd.argoproj.io/hook: PostSync
    argocd.argoproj.io/hook-delete-policy: HookSucceeded
spec:
  template:
    spec:
      containers:
        - name: test
          image: curlimages/curl:7.85.0
          command:
            - /bin/sh
            - -c
            - |
              curl -f http://guestbook-svc/health || exit 1
              echo "Smoke test passed!"
      restartPolicy: Never
  backoffLimit: 0
```

---

### SyncFail Hook Example (Rollback Notification)

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: notify-on-failure
  annotations:
    argocd.argoproj.io/hook: SyncFail
    argocd.argoproj.io/hook-delete-policy: HookSucceeded
spec:
  template:
    spec:
      containers:
        - name: notify
          image: curlimages/curl:7.85.0
          command:
            - /bin/sh
            - -c
            - |
              curl -X POST https://hooks.slack.com/T123/B456/xxx \
                -H 'Content-type: application/json' \
                -d '{"text":"🚨 ArgoCD sync failed for guestbook in production!"}'
      restartPolicy: Never
```

---

## 14. Sync Waves

### What Are Sync Waves?

Sync waves allow you to define **precise ordering** of resource deployment within a single sync operation. Resources with lower wave numbers are applied and verified **before** resources with higher wave numbers.

**Analogy:** Think of sync waves as "deployment priorities". Wave 0 runs first, wave 1 runs next only after wave 0 is healthy, and so on.

---

### Sync Wave Annotation

```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "2"   # Wave number (string, not integer)
```

**Default wave number:** If no annotation is present, the resource defaults to wave `"0"`.

---

### Full Sync Wave Example

**Real scenario:** Deploy a database ConfigMap first, then run a DB connectivity check job, then deploy the main application.

**db-config.yaml (Wave 1)**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: db-config
  annotations:
    argocd.argoproj.io/sync-wave: "1"   # Deploy first
data:
  db_host: "postgres-db.default.svc.cluster.local"
  db_port: "5432"
  db_name: "appdb"
```

**db-check-job.yaml (Wave 2)**
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: db-check
  annotations:
    argocd.argoproj.io/sync-wave: "2"   # Deploy after wave 1 is healthy
spec:
  template:
    spec:
      containers:
        - name: check
          image: postgres:14
          command:
            - /bin/sh
            - -c
            - |
              echo "Checking DB connectivity at $DB_HOST..."
              sleep 5
              echo "Connected!"
          env:
            - name: DB_HOST
              valueFrom:
                configMapKeyRef:
                  name: db-config
                  key: db_host
      restartPolicy: Never
```

**deployment.yaml (Wave 3)**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: guestbook
  annotations:
    argocd.argoproj.io/sync-wave: "3"   # Only starts after DB check passes
spec:
  replicas: 2
  selector:
    matchLabels:
      app: guestbook
  template:
    metadata:
      labels:
        app: guestbook
    spec:
      containers:
        - name: guestbook
          image: gcr.io/heptio-images/ks-guestbook-demo:0.2
          ports:
            - containerPort: 80
```

---

### Combining Sync Waves and Sync Phases

You can use **both** in the same application:

```
Execution Order:
┌──────────────────────────────────────────────────────────────┐
│ Phase: PreSync                                               │
│   Wave -1: db-migration job (hook: PreSync, wave: -1)       │
│   Wave  0: validation job  (hook: PreSync, wave:  0)        │
│                                                              │
│ Phase: Sync                                                  │
│   Wave 0: Service (no annotation = default wave 0)          │
│   Wave 1: ConfigMap                                         │
│   Wave 2: DB check Job                                      │
│   Wave 3: Deployment                                        │
│                                                              │
│ Phase: PostSync                                              │
│   Smoke test job (hook: PostSync)                           │
└──────────────────────────────────────────────────────────────┘
```

> **Best Practice:** Use **multiples of 10** for wave numbers (10, 20, 30) instead of consecutive integers (1, 2, 3). This makes it easy to insert new waves between existing ones without renumbering everything.

```yaml
# Better numbering:
argocd.argoproj.io/sync-wave: "10"   # ConfigMap
argocd.argoproj.io/sync-wave: "20"   # DB check job
argocd.argoproj.io/sync-wave: "30"   # Deployment
# Later you can add wave "15" between ConfigMap and DB check without renaming others
```

---

## 15. Argo Rollouts — Canary & Blue-Green

### What Is Argo Rollouts?

Argo Rollouts is a separate Kubernetes controller that extends the standard `Deployment` resource with advanced deployment strategies:
- **Canary** — gradually shift traffic to new version
- **Blue-Green** — switch traffic instantly after new version is healthy

> **Note:** Argo Rollouts is a separate project from ArgoCD but works seamlessly with it.

---

### Canary Deployment with Traffic Splitting

ArgoCD + Argo Rollouts + a traffic controller (e.g., **Traefik**, **Istio**, **AWS ALB**) enables **precise canary traffic splitting**.

**How it works:**
1. Two Services: `stable` and `canary`
2. An HTTPRoute (Gateway API) splits traffic between them
3. Argo Rollouts dynamically adjusts the weight in the HTTPRoute

---

### Rollout Manifest — Canary with Gateway API

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: guestbook-rollout
  namespace: gateway-lab
spec:
  replicas: 4
  selector:
    matchLabels:
      app: guestbook
  template:
    metadata:
      labels:
        app: guestbook
    spec:
      containers:
        - name: guestbook
          image: gcr.io/heptio-images/ks-guestbook-demo:0.2
          ports:
            - containerPort: 80
  strategy:
    canary:
      stableService: rollout-gw-stable     # Stable service name
      canaryService: rollout-gw-canary     # Canary service name
      trafficRouting:
        plugins:
          argoproj-labs/gatewayAPI:
            httpRoute: rollout-http-route  # Name of the HTTPRoute
            namespace: gateway-lab
      steps:
        - setWeight: 30      # Send 30% traffic to canary
        - pause: {}          # Pause indefinitely (manual promotion)
        - setWeight: 60
        - pause: {}
        - setWeight: 100     # Full rollout
```

---

### Services for Canary Rollout

```yaml
# Stable Service
apiVersion: v1
kind: Service
metadata:
  name: rollout-gw-stable
  namespace: gateway-lab
spec:
  selector:
    app: guestbook
  ports:
    - port: 80
      targetPort: 80
---
# Canary Service
apiVersion: v1
kind: Service
metadata:
  name: rollout-gw-canary
  namespace: gateway-lab
spec:
  selector:
    app: guestbook
  ports:
    - port: 80
      targetPort: 80
```

---

### HTTPRoute (Gateway API)

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: rollout-http-route
  namespace: gateway-lab
spec:
  parentRefs:
    - name: rollout-gateway    # Reference to the Gateway resource
  hostnames:
    - "guestbook.myapp.com"
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /
      backendRefs:
        - name: rollout-gw-stable
          port: 80
          # weight: intentionally omitted — let Argo Rollouts manage it
        - name: rollout-gw-canary
          port: 80
```

> **Important:** Do NOT set static weights in the HTTPRoute manifest when using Argo Rollouts. If you do, ArgoCD will detect a diff between what's in Git (static weight) and what Argo Rollouts sets dynamically, causing the app to always show `OutOfSync`.

---

## 16. Quick-Reference Command Cheatsheet

### ArgoCD CLI Commands

```bash
# ── Authentication ──────────────────────────────────────────────────
argocd login <server>:<port> --username admin --password <pw> --insecure
argocd context                            # List contexts
argocd account get-user-info              # Current user info
argocd account update-password            # Change password

# ── Applications ────────────────────────────────────────────────────
argocd app list                           # List all apps
argocd app get <app-name>                 # Get app details
argocd app create <app-name> \            # Create app via CLI
  --repo <url> --path <path> \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace <ns>
argocd app sync <app-name>                # Trigger sync
argocd app diff <app-name>                # Show diff vs live
argocd app history <app-name>             # Sync history
argocd app rollback <app-name> <id>       # Rollback to previous sync
argocd app delete <app-name>              # Delete application
argocd app set <app-name> \               # Update app config
  --auto-prune --self-heal

# ── Projects ─────────────────────────────────────────────────────────
argocd proj list
argocd proj get <project-name>
argocd proj create <name> --description "My project"

# ── Repositories ────────────────────────────────────────────────────
argocd repo list
argocd repo add <url> --username <user> --password <pass>
argocd repo add git@github.com:org/repo.git --ssh-private-key-path ~/.ssh/key
argocd repo rm <url>
```

### kubectl Commands for ArgoCD

```bash
# ── Get Admin Password ──────────────────────────────────────────────
kubectl get secret argocd-initial-admin-secret \
  -n argocd -o jsonpath="{.data.password}" | base64 -d

# ── Port Forward (local access) ─────────────────────────────────────
kubectl port-forward svc/argocd-server -n argocd 8080:443

# ── Get All Resources in ArgoCD Namespace ───────────────────────────
kubectl get all -n argocd
kubectl get applications -n argocd
kubectl get appprojects -n argocd

# ── Create Repo Secret (HTTPS) ──────────────────────────────────────
kubectl create secret generic my-repo-https \
  -n argocd \
  --from-literal=type=git \
  --from-literal=url=https://github.com/org/repo.git \
  --from-literal=username=myuser \
  --from-literal=password=ghp_token

kubectl label secret my-repo-https \
  -n argocd \
  argocd.argoproj.io/secret-type=repository

# ── Create Repo Secret (SSH) ────────────────────────────────────────
PRIVATE_KEY=$(cat ~/.ssh/argocd-deploy-key)
kubectl create secret generic my-repo-ssh \
  -n argocd \
  --from-literal=type=git \
  --from-literal=url=git@github.com:org/repo.git \
  --from-literal="sshPrivateKey=${PRIVATE_KEY}"

kubectl label secret my-repo-ssh \
  -n argocd \
  argocd.argoproj.io/secret-type=repository

# ── Sync Manually via kubectl ────────────────────────────────────────
kubectl patch application guestbook -n argocd \
  --type merge -p '{"operation":{"sync":{}}}'
```

---

## 17. Common Mistakes & Interview Tips

### ❌ Common Mistakes

| Mistake | Correct Approach |
|---------|-----------------|
| Installing ArgoCD in `default` namespace | Always use dedicated `argocd` namespace |
| Committing Kubernetes secrets to Git | Use External Secrets Operator, AWS Secrets Manager, or Vault |
| Forgetting `argocd.argoproj.io/secret-type=repository` label on repo secrets | Always add this label — ArgoCD won't discover the secret without it |
| Setting static weights in HTTPRoute when using Argo Rollouts | Leave weights unset; let Argo Rollouts manage them dynamically |
| Using consecutive wave numbers (1, 2, 3) | Use multiples of 10 (10, 20, 30) for flexibility |
| Enabling automated sync without good CI/CD guardrails | Only enable when you have PR reviews + automated tests |
| Using `helm install` directly on a cluster managed by ArgoCD | Let ArgoCD manage all Helm deployments |
| Mixing app code and Kubernetes configs in one repo | Separate app-repo from config-repo |
| Using PATs tied to a specific user account | Use SSH deploy keys — no user account dependency |

---

### 🎯 Interview-Focused Points

**Q: What is the difference between Synced and Healthy in ArgoCD?**
> `Synced` means the live cluster state matches the desired state in Git. `Healthy` means the Kubernetes resources are actually running correctly. An app can be `Synced` but `Degraded` — e.g., pods crash-looping after a bad image was correctly deployed.

**Q: What are the 4 GitOps principles?**
> Declarative, Versioned & Immutable, Pulled Automatically, Continuously Reconciled.

**Q: How does ArgoCD detect drift?**
> The Application Controller continuously queries the Kubernetes API for the live state of resources and compares it to the desired state rendered by the Repository Server from Git. Any difference is marked as `OutOfSync`.

**Q: What is the difference between pruning and self-healing?**
> Pruning deletes resources from the cluster when their manifests are **removed from Git**. Self-healing reverts **manual changes made directly to the cluster** that weren't in Git.

**Q: What is the purpose of an AppProject?**
> AppProjects provide multi-tenancy in ArgoCD by restricting which source repos, destination clusters/namespaces, and Kubernetes resource types applications belonging to that project can use. They also support role-based access control.

**Q: What is the critical label required on a Kubernetes secret for ArgoCD to use it as a repository credential?**
> `argocd.argoproj.io/secret-type=repository`

**Q: How does ArgoCD handle Helm — does it use `helm upgrade`?**
> No. ArgoCD runs `helm template` internally to render manifests and then applies them with `kubectl apply`. It does **not** use `helm upgrade` or Helm's release history mechanism.

**Q: What are sync phases and how many are there?**
> There are 5 phases: PreSync, Sync, PostSync, SyncFail, and PostDelete. Hooks are Kubernetes Jobs annotated with `argocd.argoproj.io/hook: <phase>`. This allows running custom logic (migrations, tests, notifications) at specific points in the deployment lifecycle.

**Q: What is the default sync wave number?**
> `0` — any resource without a `argocd.argoproj.io/sync-wave` annotation defaults to wave 0 and is applied first.

**Q: Why should SSH deploy keys be preferred over PATs in production?**
> Deploy keys have no user account dependency. If the user who created the PAT leaves the organization, their PAT is revoked and all applications using it break. Deploy keys are tied to the repository, not to a user.

---

### 🔧 Debugging Tips

```bash
# Check ArgoCD application events and errors
kubectl describe application guestbook -n argocd

# Check ArgoCD server logs
kubectl logs -n argocd deployment/argocd-server --tail=100

# Check application controller logs (for sync issues)
kubectl logs -n argocd statefulset/argocd-application-controller --tail=100

# Check repo server logs (for Git authentication issues)
kubectl logs -n argocd deployment/argocd-repo-server --tail=100

# Get detailed app status via CLI
argocd app get guestbook --show-operation
argocd app diff guestbook

# Force a hard refresh (bypass cache)
argocd app get guestbook --hard-refresh

# Check ArgoCD events in namespace
kubectl get events -n argocd --sort-by='.lastTimestamp'
```

---

### 📋 Production Best Practices Summary

- **Always use a dedicated namespace** (`argocd`) for ArgoCD installation
- **Separate app-repo from config-repo** — clean GitOps boundary
- **Use SSH deploy keys** over PATs for repository authentication
- **Never commit secrets to Git** — use External Secrets Operator or AWS Secrets Manager
- **Use AppProjects** for team isolation and RBAC in multi-tenant setups
- **Enable automated sync only after thorough CI/CD validation** is in place
- **Use `PruneLast=true`** in syncOptions to avoid ordering issues on deletion
- **Use multiples of 10 for sync wave numbers** for maintainability
- **Always set `hook-delete-policy`** on hook jobs to prevent pod accumulation
- **Delete `argocd-initial-admin-secret`** after changing the admin password
- **Monitor ArgoCD itself** with Prometheus + Grafana — it exposes metrics on port 8083
- **Use Webhooks** (GitHub/GitLab webhook to ArgoCD) to reduce polling latency from 3 minutes to near real-time

---

*Notes compiled from Udemy ArgoCD course — Sections 1 & 2. Covers environment setup, GitOps philosophy, ArgoCD installation, core CRDs, Helm integration, automated sync, private repos, projects, sync phases, hooks, sync waves, and Argo Rollouts canary deployments.*
