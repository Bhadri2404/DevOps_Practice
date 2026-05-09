# Complete Argo CD & Argo Rollouts — Production-Ready DevOps Notes

---

## 📑 Table of Contents

- [Section 1: Introduction & Prerequisites](#section-1-introduction--prerequisites)
- [Section 2: Introduction to GitOps](#section-2-introduction-to-gitops)
  - [2.1 Traditional Push Model & Its Drawbacks](#21-traditional-push-model--its-drawbacks)
  - [2.2 GitOps Workflow](#22-gitops-workflow)
  - [2.3 Four Foundational Principles of GitOps](#23-four-foundational-principles-of-gitops)
- [Section 3: Installing & Accessing Argo CD](#section-3-installing--accessing-argo-cd)
  - [3.1 Installing Argo CD via Helm](#31-installing-argo-cd-via-helm)
  - [3.2 Accessing the Web UI & CLI](#32-accessing-the-web-ui--cli)
- [Section 4: Core Argo CD Concepts](#section-4-core-argo-cd-concepts)
  - [4.1 Argo CD Architecture & Components](#41-argo-cd-architecture--components)
  - [4.2 The Application CRD](#42-the-application-crd)
  - [4.3 Deploying Your First Application](#43-deploying-your-first-application)
  - [4.4 Sync Status vs Health Status](#44-sync-status-vs-health-status)
  - [4.5 The Full GitOps Loop](#45-the-full-gitops-loop)
- [Section 5: Working with Helm Charts in Argo CD](#section-5-working-with-helm-charts-in-argo-cd)
  - [5.1 How Argo CD Treats Helm](#51-how-argo-cd-treats-helm)
  - [5.2 Deploying Your Own Helm Chart](#52-deploying-your-own-helm-chart)
  - [5.3 Deploying Public Helm Charts](#53-deploying-public-helm-charts)
  - [5.4 Customizing Helm Values & Precedence](#54-customizing-helm-values--precedence)
- [Section 6: Advanced Sync & Automation](#section-6-advanced-sync--automation)
  - [6.1 Automated Syncing](#61-automated-syncing)
  - [6.2 Pruning](#62-pruning)
  - [6.3 Self-Healing & Drift Correction](#63-self-healing--drift-correction)
- [Section 7: Private Repository Authentication](#section-7-private-repository-authentication)
  - [7.1 HTTPS Authentication (PAT)](#71-https-authentication-pat)
  - [7.2 SSH Authentication (Deploy Keys)](#72-ssh-authentication-deploy-keys)
- [Section 8: Orchestrating Applications](#section-8-orchestrating-applications)
  - [8.1 Argo CD Projects & Multi-Tenancy](#81-argo-cd-projects--multi-tenancy)
  - [8.2 Propagation Policies](#82-propagation-policies)
  - [8.3 Sync Phases & Hooks](#83-sync-phases--hooks)
  - [8.4 Hook Delete Policies](#84-hook-delete-policies)
  - [8.5 Sync Waves](#85-sync-waves)
  - [8.6 Combining Waves & Phases](#86-combining-waves--phases)
- [Section 9: Introduction to Argo Rollouts](#section-9-introduction-to-argo-rollouts)
  - [9.1 Limitations of Standard Deployments](#91-limitations-of-standard-deployments)
  - [9.2 Installing Argo Rollouts](#92-installing-argo-rollouts)
  - [9.3 The Rollout CRD](#93-the-rollout-crd)
  - [9.4 Your First Canary Rollout](#94-your-first-canary-rollout)
- [Section 10: Core Rollout Strategies](#section-10-core-rollout-strategies)
  - [10.1 Blue-Green Deployments](#101-blue-green-deployments)
  - [10.2 Canary Deployments (Deep Dive)](#102-canary-deployments-deep-dive)
- [Section 11: Advanced Traffic Management](#section-11-advanced-traffic-management)
  - [11.1 Limitations of Replica-Weighted Traffic](#111-limitations-of-replica-weighted-traffic)
  - [11.2 Gateway API & Traefik Setup](#112-gateway-api--traefik-setup)
  - [11.3 Traffic-Weighted Canary with Gateway API](#113-traffic-weighted-canary-with-gateway-api)
  - [11.4 Header-Based Routing](#114-header-based-routing)
- [Section 12: Automated Analysis & Promotion](#section-12-automated-analysis--promotion)
  - [12.1 Prometheus & Metrics Architecture](#121-prometheus--metrics-architecture)
  - [12.2 Installing Prometheus](#122-installing-prometheus)
  - [12.3 Analysis Templates & Analysis Runs](#123-analysis-templates--analysis-runs)
  - [12.4 Self-Healing Rollouts with Metrics](#124-self-healing-rollouts-with-metrics)
  - [12.5 Analysis in Blue-Green Deployments](#125-analysis-in-blue-green-deployments)
- [Interview Quick-Reference Cheat Sheet](#interview-quick-reference-cheat-sheet)

---

## Section 1: Introduction & Prerequisites

### What You Need Installed

| Tool | Purpose |
|------|---------|
| **Docker** | Container runtime |
| **kubectl** | Kubernetes CLI for managing clusters |
| **Helm** | Kubernetes package manager for installing charts |
| **Minikube / Kind / Rancher Desktop** | Local Kubernetes cluster |
| **VS Code** | IDE (with Kubernetes & Docker extensions) |

> **⚠️ Critical Rule:** Use a **disposable cluster** — never experiment on production. You will install, delete, and recreate resources frequently.

### For Windows Users

Install **Windows Subsystem for Linux (WSL)** to get an Ubuntu VM:

1. Enable WSL: Start Menu → "Turn Windows features on or off" → tick "Windows Subsystem for Linux" → restart
2. Install Ubuntu from Microsoft Store
3. Open Terminal → run `wsl` to enter Linux
4. Install VS Code extension "WSL" for seamless integration
5. Run `code .` inside WSL to open VS Code connected to your Linux environment

> **Why WSL?** All course commands are Unix-based. WSL gives you a fully compatible Linux environment inside Windows.

---

## Section 2: Introduction to GitOps

### 2.1 Traditional Push Model & Its Drawbacks

**What is the Push Model?**

The traditional CI/CD deployment flow where changes flow in one direction: Developer → Git → CI/CD Pipeline → Cluster.

```
Developer → git push → CI/CD Pipeline → Build/Test → helm upgrade / kubectl apply → Cluster
```

**How it works:**
1. Developer makes code changes locally
2. Pushes to remote Git repository
3. CI/CD pipeline triggers — builds project, runs tests, security audits
4. Builds Docker images and pushes to registry
5. Executes `helm upgrade` or `kubectl apply` to modify cluster state

**Four Major Drawbacks:**

| Problem | Explanation |
|---------|-------------|
| **Configuration Drift** | Someone runs `kubectl scale deployment myapp --replicas=0` manually. Now the live cluster state differs from what Git says. Nobody knows which is the "real" desired state. |
| **Poor Auditability** | No audit trail. Who scaled the deployment? Why? Was it for debugging or a load test? There's no source of truth beyond "whatever is currently in the cluster." |
| **Stressful Rollbacks** | Rolling back requires manually finding the last good artifact, re-running pipelines, and hoping everything comes back up. With multiple services involved, this becomes extremely complex. |
| **Inconsistent Environments** | Over time, dev/staging/prod configurations diverge. How many replicas does prod have? Which secrets come from where? Promoting releases between environments becomes guesswork. |

> **Production Scenario:** A developer runs `kubectl scale deploy payment-service --replicas=1` at 2 AM to debug an issue. They forget to scale it back. Three weeks later, during a traffic spike, the payment service crashes because it only has 1 replica instead of the 5 defined in Git. Nobody knows why it was scaled down.

---

### 2.2 GitOps Workflow

**What is GitOps?**

GitOps is a paradigm where **Git is the single source of truth** for your infrastructure and application configuration. Instead of pushing changes to the cluster, a software agent (Argo CD) continuously **pulls** the desired state from Git and reconciles it with the live cluster.

**How the GitOps Flow Works:**

```
┌─────────────────────────────────────┐      ┌──────────────────────────────┐
│  APPLICATION REPOSITORY             │      │  CONFIGURATION REPOSITORY    │
│  (source code, Dockerfiles)         │      │  (K8s manifests, Helm values)│
│                                     │      │                              │
│  Developer pushes code              │      │  CI updates image tag here   │
│  CI/CD builds, tests, pushes image  │─────►│                              │
└─────────────────────────────────────┘      └──────────┬───────────────────┘
                                                        │
                                                        │  Argo CD monitors
                                                        ▼
                                             ┌──────────────────────┐
                                             │     ARGO CD          │
                                             │  Compares desired    │
                                             │  state (Git) with    │
                                             │  live state (K8s API)│
                                             │                      │
                                             │  If different →      │
                                             │  marks "Out of Sync" │
                                             │  → auto/manual sync  │
                                             └──────────────────────┘
```

**Key Difference from Push Model:**

| Aspect | Push Model | GitOps (Pull Model) |
|--------|-----------|---------------------|
| Who changes the cluster? | CI/CD pipeline directly | Argo CD agent inside the cluster |
| Source of truth | "Whatever is in the cluster" | Git repository |
| Drift detection | None | Automatic & continuous |
| Rollback | Manual, stressful | `git revert` a commit |

**Best Practice — Separate Repositories:**
- **Application Repository:** Source code, Dockerfiles, application tests
- **Configuration Repository:** Kubernetes manifests, Helm charts, values files

> **Why separate?** Different lifecycles, different permissions, different review processes. The app team changes code frequently; infrastructure changes are less frequent and need stricter review.

**Configuration Drift Detection:** Argo CD continuously compares the **live state** (from Kubernetes API) with the **desired state** (from Git). If they differ → resources are marked **Out of Sync**. If configured, Argo CD auto-heals back to the desired state.

---

### 2.3 Four Foundational Principles of GitOps

| # | Principle | What It Means | Example |
|---|-----------|---------------|---------|
| 1 | **Declarative** | Express *what* you want, not *how* to get it | "I want 3 replicas of nginx" — not "run `kubectl scale`" |
| 2 | **Versioned & Immutable** | Desired state stored with full version history; a tag always maps to the same config | Git commit `abc123` = always the same deployment spec |
| 3 | **Pulled Automatically** | Software agents automatically pull desired state from source | Argo CD polls Git every ~3 minutes |
| 4 | **Continuously Reconciled** | Agents continuously observe live state and *attempt* to apply desired state | If someone manually deletes a pod, Argo CD detects drift and restores it |

> **Interview Tip:** "GitOps means Git is the single source of truth. We declare what we want in Git, and an agent like Argo CD continuously ensures the cluster matches that declaration. Any drift — whether from manual changes or failed deployments — is automatically detected and can be self-healed."

---

## Section 3: Installing & Accessing Argo CD

### 3.1 Installing Argo CD via Helm

**Step 1: Add the Helm repository**

```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
```

**Step 2: Search for available versions**

```bash
helm search repo argo/argo-cd --versions
```

**Step 3: Create the namespace (recommended via manifest)**

```yaml name=argocd-ns.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: argocd
```

```bash
kubectl apply -f argocd-ns.yaml
```

**Step 4: Install Argo CD**

```bash
helm upgrade argocd argo/argo-cd \
  --version 8.6.0 \
  --install \
  --create-namespace \
  --namespace argocd
```

| Flag | Purpose |
|------|---------|
| `--install` | Install if not already present (otherwise only upgrade) |
| `--create-namespace` | Create namespace if it doesn't exist |
| `--namespace argocd` | Deploy into dedicated namespace |
| `--version 8.6.0` | Pin specific chart version for reproducibility |

**Step 5: Verify installation**

```bash
kubectl get pods -n argocd
```

You should see pods for: API Server, Application Controller, Repo Server, Redis, Dex Server, ApplicationSet Controller.

> **Best Practice:** Always install Argo CD in its own namespace (`argocd`) to isolate it from application workloads and manage access control separately.

---

### 3.2 Accessing the Web UI & CLI

**Expose the API Server:**

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Access at `https://localhost:8080` (accept the self-signed certificate warning).

**Retrieve the initial admin password:**

```bash
kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath='{.data.password}' | base64 -d
```

- Username: `admin`
- Password: output of the above command

**Install the Argo CD CLI:**

```bash
# macOS
brew install argocd

# Linux — download from GitHub releases
# Windows — use WSL and follow Linux instructions
```

**Login via CLI:**

```bash
argocd login localhost:8080 --name local
# Proceed insecurely: y
# Username: admin
# Password: <paste password>
```

**Useful CLI commands:**

```bash
argocd context                    # Show saved contexts
argocd account get-user-info      # Current user info
argocd account update-password    # Change password
argocd app list                   # List all applications
```

> **Beginner Mistake:** Forgetting to login before running `argocd app list`. You'll get a "permission denied" or confusing error. Always `argocd login` first.

---

## Section 4: Core Argo CD Concepts

### 4.1 Argo CD Architecture & Components

```
                    ┌─────────────────┐
  Users ───────────►│   API Server    │◄──── UI / CLI / gRPC / REST
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              ▼              ▼              ▼
    ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
    │  Repo Server │ │  App         │ │  Redis       │
    │              │ │  Controller  │ │  (Cache)     │
    │ Clones Git   │ │              │ │              │
    │ Runs helm    │ │ Monitors     │ │ Stores       │
    │ template     │ │ live state   │ │ manifest     │
    │ Generates    │ │ vs desired   │ │ generation   │
    │ manifests    │ │ state        │ │ results      │
    └──────────────┘ └──────────────┘ └──────────────┘
```

| Component | Role |
|-----------|------|
| **API Server** | External-facing interface. Handles UI, CLI, and programmatic (gRPC/REST) requests. |
| **Repository Server** | Clones Git repos, maintains local cache, runs `helm template` to generate final manifests. |
| **Application Controller** | Continuously monitors running applications. Compares live state (K8s API) with desired state. Optionally performs corrective actions (self-heal). Runs lifecycle hooks. |
| **Redis** | In-memory cache for manifest generation results. |
| **Dex Server** | Identity provider supporting OIDC and SAML for SSO. |
| **ApplicationSet Controller** | Manages ApplicationSet CRDs for managing Argo CD applications at scale (e.g., deploying same app across 100 clusters). |

> **Interview Explanation:** "When I push a change to Git, the Repo Server detects it, clones the repo, runs `helm template` to produce raw Kubernetes manifests, and hands them to the Application Controller. The Controller compares those manifests against what's actually running via the Kubernetes API. If there's a diff, it marks the app 'Out of Sync.' Depending on policy, it either waits for manual approval or auto-syncs."

---

### 4.2 The Application CRD

**What is it?**

The `Application` is a Custom Resource Definition (CRD) — the **core building block** of Argo CD. It's a declarative contract that tells Argo CD: *"Here's where my code lives, here's where it should be deployed, and here's how to sync it."*

**Full annotated manifest:**

```yaml name=guestbook-app.yaml
apiVersion: argoproj.io/v1alpha1    # Argo CD API group
kind: Application                   # CRD kind
metadata:
  name: guestbook                   # Name of this Argo CD application
  namespace: argocd                 # MUST be in the Argo CD namespace
spec:
  project: default                  # Which Argo CD project (default = unrestricted)

  source:                           # WHERE the desired state lives
    repoURL: https://github.com/myorg/argocd-example-apps.git
    targetRevision: HEAD            # Branch, tag, or commit SHA
    path: guestbook                 # Subfolder within the repo

  destination:                      # WHERE to deploy
    server: https://kubernetes.default.svc  # Local cluster
    namespace: default              # Target namespace for K8s resources

  syncPolicy:                       # HOW to sync
    automated:                      # Enable auto-sync
      prune: true                   # Delete resources removed from Git
      selfHeal: true                # Revert manual cluster changes
```

**Key fields explained:**

| Field | Purpose |
|-------|---------|
| `spec.project` | Logical grouping for RBAC. `default` = no restrictions. |
| `spec.source.repoURL` | Git repository containing manifests/charts |
| `spec.source.targetRevision` | `HEAD` = latest commit (rolling). Use tags/SHAs in production for pinning. |
| `spec.source.path` | Directory within the repo to deploy |
| `spec.destination.server` | `https://kubernetes.default.svc` = deploy to the same cluster Argo CD runs in |
| `spec.destination.namespace` | Where the actual K8s resources (Deployments, Services) land |

**Critical Distinction — Application Resource vs Managed Resources:**

| Aspect | Application CRD | Managed K8s Manifests |
|--------|----------------|----------------------|
| Kind | `Application` | `Deployment`, `Service`, `ConfigMap`, etc. |
| Managed by | Argo CD controllers | Kubernetes controllers |
| Lives in | `argocd` namespace | Target application namespace |
| Contains | Source location, destination, sync policy | Container specs, ports, replicas, etc. |
| Purpose | Declarative contract for Argo CD | Actual running workload definition |

> **Beginner Mistake:** Confusing the Application resource (Argo CD construct) with the actual Kubernetes resources it manages. The Application lives in the `argocd` namespace; the Deployments/Services it creates live in whatever `destination.namespace` you specify.

---

### 4.3 Deploying Your First Application

**Apply the Application manifest:**

```bash
kubectl apply -f guestbook-app.yaml
```

**Check status:**

```bash
kubectl get applications -n argocd
# Output: guestbook   OutOfSync   ...
```

**Why Out of Sync?** The Application was just created. Argo CD sees the desired state in Git but the corresponding Deployments/Services don't exist in the cluster yet. By default, Argo CD **does not auto-sync** — this is a safety feature.

**Trigger sync manually (UI or CLI):**

```bash
argocd app sync guestbook
```

Or in the UI: Click the application → Click "Sync" → Click "Synchronize"

**How Argo CD Tracks Resources:**

Argo CD adds an annotation to every resource it manages:

```
argocd.argoproj.io/tracking-id: guestbook:apps/Deployment:default/guestbook-ui
```

This is how it knows which Deployment belongs to which Application. An unrelated Deployment in the same namespace without this annotation won't be touched by Argo CD.

---

### 4.4 Sync Status vs Health Status

These are **two independent indicators** — a resource can be synced but unhealthy, or out of sync but healthy.

**Sync Status — "Does the live state match Git?"**

| Value | Meaning |
|-------|---------|
| **Synced** | Live state = desired state in Git |
| **OutOfSync** | Live state ≠ desired state (configuration drift) |
| **Progressing** | Sync operation in progress (temporary) |

**Health Status — "Are the deployed resources actually working?"**

| Value | Meaning |
|-------|---------|
| **Healthy** | All resources in good state |
| **Degraded** | At least one resource failed or unhealthy |
| **Progressing** | Resources still rolling out |
| **Missing** | Resource defined in Git but doesn't exist in cluster |

> **Important Scenario:** You deploy a Deployment with image tag `v2.0.0-buggy`. Argo CD syncs it successfully → **Sync Status = Synced**. But the pods crash because the image has a bug → **Health Status = Degraded**. The deployment is perfectly synced with Git, but the application itself is broken.

**What gets health indicators vs sync indicators?**

- Resources **defined in Git** (Deployment, Service) → get both sync status and health status
- Resources **created automatically** by Kubernetes (ReplicaSet, Pod from a Deployment) → get only health status, not sync status, because they aren't directly defined in the desired state

---

### 4.5 The Full GitOps Loop

1. **Fork** the example repository to your own GitHub account (you need push access)
2. **Update** the Application manifest's `repoURL` to point to your fork
3. **Make a change** in Git (e.g., change `replicas: 1` to `replicas: 3` in the deployment)
4. **Wait ~3 minutes** or click "Refresh" in the UI
5. Argo CD detects the diff → marks app **Out of Sync**
6. View the diff in the UI (compact diff shows exactly what changed)
7. Click **Sync** → Argo CD applies the changes
8. Verify with `kubectl get pods` — now 3 pods running

> **Production Best Practice:** Use `targetRevision` with a specific **tag** or **commit SHA** instead of `HEAD`. Using `HEAD` means every push to the default branch immediately becomes the desired state — dangerous in production.

---

## Section 5: Working with Helm Charts in Argo CD

### 5.1 How Argo CD Treats Helm

**This is the single most important thing to understand about Helm + Argo CD:**

> **Argo CD does NOT run `helm install` or `helm upgrade`. It uses Helm purely as a template engine.**

**What actually happens:**

```
Repo Server → runs `helm template` → generates raw K8s manifests → kubectl apply
```

**Consequences:**

| Feature | Available? |
|---------|-----------|
| `helm list` shows the release | ❌ No |
| `helm history` shows revisions | ❌ No |
| `helm rollback` works | ❌ No |
| Helm secrets stored in cluster | ❌ No |
| Helm hooks | ⚠️ Partially (Argo CD has its own hook system) |

> **Why this design?** Argo CD intentionally avoids coupling to Helm's release management. It treats Helm charts as just another way to generate Kubernetes manifests — same as Kustomize or plain YAML.

**Interview Answer:** "Argo CD uses `helm template` to render the chart into plain YAML, then applies those manifests with its own diffing engine. There's no `helm install` — no Helm releases, no Helm secrets, no Helm history. Argo CD manages the state itself."

---

### 5.2 Deploying Your Own Helm Chart

To deploy a Helm chart from your Git repository, change the `path` in your Application to point to the chart directory:

```yaml name=guestbook-helm-app.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/myorg/argocd-example-apps.git
    targetRevision: HEAD
    path: helm-guestbook        # Points to chart directory
    helm:                        # Helm-specific configuration
      valueFiles:
        - values.yaml            # Reference values files within the chart
  destination:
    server: https://kubernetes.default.svc
    namespace: default
```

**Migrating from plain manifests to Helm:** When you change the `path` from a directory of plain YAML to a Helm chart directory, Argo CD treats it as a different set of resources (different tracking IDs based on naming conventions). You may need to:
- Use `prune: true` during sync to clean old resources
- Or use `fullnameOverride` in Helm values to match old resource names

---

### 5.3 Deploying Public Helm Charts

For charts from public Helm repositories (not Git repos):

```yaml name=dashboard-app.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: k8s-dashboard
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://kubernetes.github.io/dashboard/  # Helm repo URL
    chart: kubernetes-dashboard                         # Chart name (not path!)
    targetRevision: 7.3.0                               # Chart version
  destination:
    server: https://kubernetes.default.svc
    namespace: k-dashboard
```

**Key differences from Git-based source:**

| Field | Git Repo | Helm Repo |
|-------|----------|-----------|
| `repoURL` | Git clone URL | Helm repository URL |
| `path` | Directory in repo | ❌ Not used |
| `chart` | ❌ Not used | Chart name |
| `targetRevision` | Branch/tag/SHA | Chart version |

---

### 5.4 Customizing Helm Values & Precedence

There are **three ways** to override chart values, listed from **lowest to highest precedence**:

```yaml name=app-with-all-value-methods.yaml
spec:
  source:
    repoURL: https://kubernetes.github.io/dashboard/
    chart: kubernetes-dashboard
    targetRevision: 7.3.0
    helm:
      # Method 1: Value Files (lowest precedence)
      # Later files override earlier files
      valueFiles:
        - values.yaml
        - values-production.yaml

      # Method 2: Values Object (medium precedence)
      # Inline YAML, overrides valueFiles
      values: |
        replicaCount: 2
        service:
          type: NodePort

      # Method 3: Parameters (highest precedence)
      # Later entries override earlier entries
      parameters:
        - name: replicaCount
          value: "4"
        - name: kong.enabled
          value: "true"
```

**Precedence order (lowest → highest):**

```
Chart's own values.yaml → valueFiles → values (object) → parameters
```

| Method | When to Use |
|--------|------------|
| `valueFiles` | Environment-specific configs (dev vs prod values files committed to Git) |
| `values` | Quick inline overrides during development |
| `parameters` | Final overrides, CI/CD-injected values, highest priority |

> **Beginner Mistake:** Using `values` (singular) when you mean `valueFiles` (plural) or vice versa. The API will reject unknown fields, but the error messages can be confusing.

---

## Section 6: Advanced Sync & Automation

### 6.1 Automated Syncing

**What:** Allows Argo CD to automatically apply changes when a new commit is detected in Git, without manual approval.

**Default Behavior (no automation):**
1. Git changes detected → App marked "Out of Sync"
2. Human reviews the diff
3. Human clicks "Sync"

**With automated sync:**
1. Git changes detected → App marked "Out of Sync"
2. Argo CD **automatically** applies the changes

```yaml
syncPolicy:
  automated: {}    # Empty object = auto-sync enabled, prune/selfHeal disabled
```

> **⚠️ Safety Warning:** Only enable automated sync when you have solid CI/CD processes (tests, security scans, code reviews) that catch misconfigurations before they reach the main branch. Otherwise, a broken commit auto-deploys to production.

> **Production Scenario:** Your team has a mature CI pipeline with unit tests, integration tests, security scanning, and mandatory PR reviews. Automated sync is appropriate here because bad changes are caught before merging. But a startup with no tests? Manual sync is safer.

---

### 6.2 Pruning

**What:** Automatically deletes Kubernetes resources from the cluster when their manifests are removed from Git.

**Default behavior (prune disabled):** If you delete a ConfigMap from Git and sync, the ConfigMap **remains in the cluster** as an orphan. This can lead to resource sprawl.

**With prune enabled:**

```yaml
syncPolicy:
  automated:
    prune: true     # Delete resources removed from Git
```

**Important nuance:** Pruning only affects resources **directly managed by Argo CD** (resources with the tracking annotation). It does NOT affect:
- Pods managed by a Deployment (those are managed by the Deployment controller)
- ReplicaSets managed by a Deployment
- Any resource without the Argo CD tracking annotation

> **Example:** You delete a ConfigMap manifest from Git. With `prune: true`, the next sync deletes it from the cluster. Without prune, you'd need to manually `kubectl delete configmap <name>`.

**Manual sync with prune:** Even without `prune: true` in the policy, you can check the "Prune" checkbox when manually triggering a sync in the UI.

---

### 6.3 Self-Healing & Drift Correction

**What:** Automatically reverts any manual changes made to the cluster that cause drift from the desired state in Git.

**How it differs from automated sync:**
- **Automated sync** triggers when the **Git repo changes** (desired state changes)
- **Self-heal** triggers when the **live cluster changes** (live state changes)

```yaml
syncPolicy:
  automated:
    prune: true
    selfHeal: true    # Revert manual cluster changes
```

**Example in action:**

```bash
# Self-heal is ON, desired replicas = 2
kubectl scale deploy guestbook --replicas=5
# Within seconds, Argo CD detects the drift and scales back to 2
```

**When to temporarily disable self-heal:**

```yaml
syncPolicy:
  automated:
    prune: true
    selfHeal: false   # Disabled for debugging
```

Use case: You need to add a debug sidecar container temporarily, or scale up for a load test. Disable self-heal, do your work, then re-enable.

> **Production Best Practice:** Keep self-heal ON in production. Temporarily disable via a PR that changes the Application manifest (which itself goes through review), do your debugging, then merge another PR to re-enable.

> **Interview Answer:** "Automated sync reacts to Git changes. Self-heal reacts to cluster changes. Together, they close the full GitOps loop — no matter who changes what, the cluster always converges back to the desired state in Git."

---

## Section 7: Private Repository Authentication

### Why Private Repos?

Most production code lives in private repositories. Argo CD needs credentials to clone these repos.

### Authentication Mechanism

Argo CD looks for **Kubernetes Secrets** in the `argocd` namespace with a specific label:

```
argocd.argoproj.io/secret-type: repository
```

When an Application references a repo URL, Argo CD searches for a Secret whose `url` field matches, and uses the credentials in that Secret.

---

### 7.1 HTTPS Authentication (PAT)

**Secret schema for HTTPS:**

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: private-repo-https
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository   # REQUIRED label
type: Opaque
data:
  type: Z2l0          # base64 of "git"
  url: <base64-encoded repo URL>
  username: <base64-encoded username>
  password: <base64-encoded PAT>
```

**Creating via CLI (avoids committing secrets to Git):**

```bash
kubectl create secret generic private-repo-https \
  --namespace argocd \
  --from-literal=type=git \
  --from-literal=url=https://github.com/myorg/private-repo.git \
  --from-literal=username=myuser \
  --from-literal=password=ghp_xxxxxxxxxxxxxxxxxxxx

# Add the required label
kubectl label secret private-repo-https \
  -n argocd \
  argocd.argoproj.io/secret-type=repository
```

> **⚠️ Never commit secrets in a YAML file to Git.** Use imperative commands, or better yet, use an external secrets manager (AWS Secrets Manager, HashiCorp Vault) with the External Secrets Operator.

**Via the Argo CD UI:** Settings → Repositories → Connect Repo → Choose HTTPS → Enter URL, username, PAT → Click Connect.

---

### 7.2 SSH Authentication (Deploy Keys)

**Advantages over PATs:**

| Advantage | Explanation |
|-----------|-------------|
| Repository-specific | Each key grants access to ONE repo only |
| No user dependency | If a developer leaves the org, deploy keys still work |
| Read-only by default | Safer — can't accidentally push via the key |
| More auditable | GitHub shows when keys were last used |

**Setup steps:**

**1. Generate SSH key pair:**

```bash
ssh-keygen -t ed25519 -f ./argocd-deploy-key -N ""
# Creates: argocd-deploy-key (private) and argocd-deploy-key.pub (public)
```

**2. Add public key as deploy key in GitHub:** Repository → Settings → Deploy Keys → Add → Paste contents of `argocd-deploy-key.pub`

**3. Create Kubernetes Secret with private key:**

```bash
PRIVATE_KEY=$(cat ./argocd-deploy-key)

kubectl create secret generic private-repo-ssh \
  --namespace argocd \
  --from-literal=type=git \
  --from-literal=url=git@github.com:myorg/private-repo.git \
  --from-literal=sshPrivateKey="$PRIVATE_KEY"

kubectl label secret private-repo-ssh \
  -n argocd \
  argocd.argoproj.io/secret-type=repository
```

**4. Update Application to use SSH URL:**

```yaml
source:
  repoURL: git@github.com:myorg/private-repo.git   # SSH URL format
```

> **Security Cleanup:** After setting up, delete the local private key file. Rotate keys periodically. Delete deploy keys when no longer needed.

---

## Section 8: Orchestrating Applications

### 8.1 Argo CD Projects & Multi-Tenancy

**What is a Project?**

A logical grouping that exists **only inside Argo CD** (not a cluster-wide resource like namespaces). Projects define **guardrails** for which repositories, clusters, namespaces, and resource types applications within the project can use.

**Why use Projects?**
- **Multi-tenancy:** Finance team can't touch Marketing's apps
- **Security:** Restrict which namespaces teams can deploy to
- **Compliance:** Prevent teams from deploying ClusterRoleBindings or other privileged resources

```yaml name=team-finance-project.yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: team-finance
  namespace: argocd
spec:
  description: "Project for team finance with security guardrails"

  # ONLY these repos can be used as sources
  sourceRepos:
    - https://github.com/myorg/finance-configs.git

  # ONLY these destinations are allowed
  destinations:
    - server: https://kubernetes.default.svc
      namespace: finance

  # Which cluster-scoped resources can be deployed
  clusterResourceWhitelist:
    - group: '*'
      kind: '*'

  # Which namespaced resources can be deployed
  namespaceResourceWhitelist:
    - group: '*'
      kind: '*'
```

**What happens when rules are violated:**

If an Application in project `team-finance` tries to deploy to namespace `default`:

```
ComparisonError: application destination {server, namespace: default}
is not permitted in project 'team-finance'
```

**CLI commands:**

```bash
argocd proj list                        # List all projects
argocd proj get team-finance            # Get project details
```

> **The `default` project** is created automatically and has NO restrictions — any source, any destination, any resource type. In production, **never use the default project**. Create specific projects with appropriate restrictions.

---

### 8.2 Propagation Policies

Kubernetes-native concept (not Argo CD specific) that determines how dependent resources are deleted when an owner is deleted.

| Policy | Behavior |
|--------|----------|
| **Foreground** | Delete dependents first, then owner. Owner enters "deletion in progress" state. |
| **Background** (default) | Delete owner immediately, garbage collector cleans up dependents later. |
| **Orphan** | Delete owner only; dependents remain in cluster as orphans. |

Visible in the Argo CD UI when deleting applications — you choose which propagation policy to use.

---

### 8.3 Sync Phases & Hooks

**What are Sync Phases?**

A sync operation isn't atomic — it has distinct phases where you can run custom logic (Jobs) before, during, or after the main manifest application.

**Phases in order:**

```
PreSync → Sync → PostSync
              ↘ SyncFail (if sync fails)
```

| Phase | Hook Annotation | When It Runs |
|-------|----------------|--------------|
| **PreSync** | `argocd.argoproj.io/hook: PreSync` | Before any manifests are applied |
| **Sync** | `argocd.argoproj.io/hook: Sync` | During manifest application |
| **PostSync** | `argocd.argoproj.io/hook: PostSync` | After successful sync |
| **SyncFail** | `argocd.argoproj.io/hook: SyncFail` | If PreSync or Sync fails |
| **PostDelete** | `argocd.argoproj.io/hook: PostDelete` | After application resources are deleted |
| **Skip** | `argocd.argoproj.io/hook: Skip` | Skip this resource during sync |

**Example PreSync Job (database migration):**

```yaml name=db-migration-job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migration
  annotations:
    argocd.argoproj.io/hook: PreSync
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
- Jobs are used because they have clear success/failure semantics
- If a PreSync job fails, the Sync phase **never starts**
- Hooks only run for the Application they're defined in (not cluster-wide)

---

### 8.4 Hook Delete Policies

Control when hook resources (Jobs/Pods) are cleaned up:

| Policy | When Deleted |
|--------|-------------|
| `BeforeHookCreation` | Before a new hook with the same name runs |
| `HookSucceeded` | Immediately after successful completion |
| `HookFailed` | Immediately after failure |

```yaml
annotations:
  argocd.argoproj.io/hook-delete-policy: BeforeHookCreation,HookSucceeded
```

> **Tip:** If you want to inspect logs of completed hooks, omit `HookSucceeded`. The Job/Pod will remain for debugging until the next sync creates a new one (`BeforeHookCreation`).

---

### 8.5 Sync Waves

**What:** Define the execution ORDER of resources within a sync phase. Without waves, all resources in a phase are applied simultaneously.

**Annotation:**

```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "10"    # Integer (can be negative)
```

**Execution order:** Smallest → Largest. Default is `0`.

**Example ordering:**

| Resource | Wave | Applied |
|----------|------|---------|
| Namespace | -1 | First |
| ConfigMap | 0 (default) | Second |
| Service | 0 (default) | Second (same wave) |
| Deployment | 10 | Third |

**Within each wave:** Argo CD applies all resources, waits for them to be healthy, then moves to the next wave.

> **Best Practice:** Use multiples of 10 (10, 20, 30) instead of consecutive integers (1, 2, 3). This leaves room to insert new resources between existing waves without refactoring all annotations.

---

### 8.6 Combining Waves & Phases

Waves work **within** each phase:

```
PreSync Phase:
  Wave -10 → Wave 0 → Wave 10

Sync Phase:
  Wave 0 → Wave 10 → Wave 20 → Wave 30

PostSync Phase:
  Wave 0 → Wave 10
```

A resource with both annotations:
```yaml
annotations:
  argocd.argoproj.io/hook: PreSync       # Phase
  argocd.argoproj.io/sync-wave: "10"     # Order within phase
```

---

## Section 9: Introduction to Argo Rollouts

### 9.1 Limitations of Standard Deployments

| Limitation | Explanation |
|-----------|-------------|
| **Too fast / all-or-nothing** | Rolling update proceeds to completion as fast as possible. No concept of pausing to observe. |
| **Weak success definition** | Readiness probes only check if a pod accepts traffic, not if the application logic is correct. |
| **No traffic control** | New pods are added to the Service's load-balancing pool immediately. Can't send exactly 5% of traffic to new version. |
| **Rollback = another rolling update** | No special rollback mechanism — just deploys the previous version again, which takes time. |

> **Real-World Problem:** You deploy `v2.0.0` which has a bug in the payment endpoint. The health check returns 200 (it checks `/healthz`, not `/api/pay`). The rolling update happily replaces all pods. 100% of users now hit the buggy payment endpoint.

---

### 9.2 Installing Argo Rollouts

**Argo Rollouts is a separate project from Argo CD.** They can be used independently.

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

# Install kubectl plugin
# macOS/Linux — download from GitHub releases
curl -LO https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-darwin-amd64
chmod +x kubectl-argo-rollouts-darwin-amd64
sudo mv kubectl-argo-rollouts-darwin-amd64 /usr/local/bin/kubectl-argo-rollouts

# Verify
kubectl argo rollouts version
```

**Enable the Dashboard:**

```yaml name=rollouts-values.yaml
dashboard:
  enabled: true
```

```bash
helm upgrade argo-rollouts argo/argo-rollouts \
  --version 2.4.5 \
  --namespace argo-rollouts \
  --install \
  -f rollouts-values.yaml
```

Access: `kubectl argo rollouts dashboard` → opens at `localhost:3100`

---

### 9.3 The Rollout CRD

**A Rollout is almost identical to a Deployment**, but adds a `strategy` field for advanced deployment patterns.

**Migration from Deployment to Rollout:**

```yaml
# BEFORE (Deployment)                    # AFTER (Rollout)
apiVersion: apps/v1                      apiVersion: argoproj.io/v1alpha1
kind: Deployment                         kind: Rollout
metadata:                                metadata:
  name: my-app                             name: my-app
spec:                                    spec:
  replicas: 5                              replicas: 5
  selector: ...                            selector: ...
  template: ...                            template: ...
                                           strategy:          # NEW - required!
                                             canary:
                                               steps:
                                                 - setWeight: 20
                                                 - pause: {}
```

> **⚠️ A Rollout without a `strategy` field is invalid.** kubectl will accept it, but the Rollout controller will mark it as `Degraded`.

---

### 9.4 Your First Canary Rollout

```yaml name=rollout.yaml
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: simple-color-app
spec:
  replicas: 5
  selector:
    matchLabels:
      app: simple-color-app
  template:
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
  strategy:
    canary:
      steps:
        - setWeight: 20       # Send 20% traffic to new version
        - pause: {}           # Pause indefinitely (manual promotion)
```

**When you change `APP_COLOR` from `red` to `blue` and apply:**

1. Argo Rollouts creates a new ReplicaSet with 1 pod (20% of 5)
2. Old ReplicaSet keeps 4 pods (80%)
3. Rollout enters **Paused** state
4. You observe traffic: ~80% red, ~20% blue
5. Promote manually: `kubectl argo rollouts promote simple-color-app`
6. Rollout continues until 100% blue

**Monitoring the rollout:**

```bash
kubectl argo rollouts get rollout simple-color-app --watch
```

---

## Section 10: Core Rollout Strategies

### 10.1 Blue-Green Deployments

**Concept:**

```
Stage 1: Only Blue (stable) environment running
         Blue Service → Blue Pods (100% traffic)

Stage 2: Green (new) environment deployed alongside
         Blue Service → Blue Pods (production traffic)
         Green Service → Green Pods (preview/testing traffic)

Stage 3: Switch — Green becomes new Blue
         Blue Service → Green Pods (now stable, 100% traffic)
         Old Blue Pods → scaled down
```

**Characteristics:**
- Full parallel environments (doubles infrastructure temporarily)
- Instant traffic switch (100% at once)
- Fast rollback (switch back to old environment)

**Rollout manifest:**

```yaml name=blue-green-rollout.yaml
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: rollout-bluegreen
  namespace: blue-green-lab
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
      activeService: rollout-bluegreen-active      # Points to stable
      previewService: rollout-bluegreen-preview    # Points to new version
      autoPromotionEnabled: false                   # Require manual promotion
```

**Two services are required** (you create them, Argo Rollouts manages their selectors):

```yaml name=blue-green-services.yaml
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

**How Argo Rollouts manages services:** It adds a `rollouts-pod-template-hash` to each service's selector, ensuring the active service only routes to stable pods and the preview service only routes to new pods.

**Scale-down delay:** After promotion, old pods remain for 30 seconds (configurable via `scaleDownDelaySeconds`) before being terminated — a safety buffer.

---

### 10.2 Canary Deployments (Deep Dive)

**Concept:** Gradually shift traffic from stable to new version in controlled steps.

```
Stage 1: Stable gets 100%
Stage 2: Stable 80% / Canary 20%
Stage 3: Stable 50% / Canary 50%
Stage 4: Stable 20% / Canary 80%
Stage 5: Canary becomes new stable (100%)
```

**Advanced Canary with dedicated services:**

```yaml name=canary-rollout.yaml
spec:
  strategy:
    canary:
      canaryService: rollout-canary-preview   # Always points to canary pods
      stableService: rollout-canary-stable    # Always points to stable pods
      steps:
        - setWeight: 20
        - pause: {}              # Wait for manual approval
        - setWeight: 50
        - pause: { duration: 60s }
        - setWeight: 80
        - pause: { duration: 60s }
```

**Three services pattern:**
- **Public service:** Distributes traffic based on weights (for end users)
- **Stable service:** Always 100% to stable pods (for stable endpoint)
- **Canary/Preview service:** Always 100% to canary pods (for testers)

**Dynamic stable scaling:**

```yaml
strategy:
  canary:
    dynamicStableScale: true    # Scale down stable as canary scales up
```

Without this, the stable environment keeps all 5 pods even when canary has 4 — resulting in 9 pods total (over-provisioning). With `dynamicStableScale: true`, Argo Rollouts dynamically adjusts both ReplicaSets to roughly match the traffic split.

---

## Section 11: Advanced Traffic Management

### 11.1 Limitations of Replica-Weighted Traffic

| Limitation | Explanation |
|-----------|-------------|
| **Imprecise splits** | Can't do 5% with only 2 replicas total |
| **Forced over-provisioning** | Need 20 pods to achieve a 95/5 split |
| **No header-based routing** | Can't predictably route QA traffic to canary |

---

### 11.2 Gateway API & Traefik Setup

**Gateway API** is the successor to Kubernetes Ingress — provides precise traffic splitting at the networking layer, decoupled from pod counts.

**Setup steps:**

1. **Install Gateway API CRDs:**
```bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.4.0/standard-install.yaml
```

2. **Install Traefik** (Gateway API controller):
```bash
helm repo add traefik https://traefik.github.io/charts
helm upgrade traefik traefik/traefik \
  --version 37.4.0 \
  --install --create-namespace \
  --namespace traefik \
  -f traefik-values.yaml
```

3. **Install Argo Rollouts Gateway API Plugin** (via init containers in the Helm values):

```yaml name=rollouts-gateway-values.yaml
dashboard:
  enabled: true
controller:
  trafficRouterPlugins:
    trafficRouterPlugins: |
      - name: "argoproj-labs/gatewayAPI"
        location: "file:///plugins/gateway-api-plugin/gateway-api-plugin"
  initContainers:
    - name: gateway-api-plugin
      image: ghcr.io/argoproj-labs/rollouts-plugin-trafficrouter-gatewayapi:v0.8.0
      command: ["/bin/sh", "-c"]
      args: ["cp /bin/gateway-api-plugin /plugins/gateway-api-plugin/gateway-api-plugin"]
      volumeMounts:
        - name: gateway-api-plugin
          mountPath: /plugins/gateway-api-plugin
  volumes:
    - name: gateway-api-plugin
      emptyDir: {}
```

> **The plugin name `argoproj-labs/gatewayAPI` must exactly match** what you reference in your Rollout's traffic routing config.

---

### 11.3 Traffic-Weighted Canary with Gateway API

With Gateway API, traffic splitting is done at the **HTTPRoute level**, not by pod count:

```yaml name=gateway-rollout.yaml
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
        - setWeight: 60
        - pause: { duration: 60s }
        - setWeight: 80
        - pause: { duration: 60s }
```

**How it works:** Argo Rollouts dynamically modifies the `backendRefs` weights in the HTTPRoute resource:

```yaml
# Argo Rollouts sets this automatically:
rules:
  - backendRefs:
      - name: rollout-gateway-stable
        weight: 70                    # Managed by Argo Rollouts
      - name: rollout-gateway-canary
        weight: 30                    # Managed by Argo Rollouts
```

**Benefit:** You can achieve 99/1 splits with just 2 pods total. Traffic precision is at the networking layer, completely decoupled from pod counts.

---

### 11.4 Header-Based Routing

**Problem:** QA testers hitting the public endpoint only reach canary 5% of the time.

**Solution:** Route traffic predictably based on an HTTP header.

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
        - name: gateway-override        # Must match setHeaderRoute name
    steps:
      - setWeight: 1                    # Minimal public traffic to canary
      - pause: { duration: 20s }
      - setCanaryScale:
          weight: 40                     # Scale canary pods for capacity
      - setHeaderRoute:                  # Define header-based routing
          name: gateway-override
          match:
            - headerName: x-canary
              headerValue:
                exact: "true"
      - pause: {}                        # Pause for testing
      - setWeight: 30                    # Continue gradual promotion
```

**Result:**
- Public users (no header): 99% stable, 1% canary
- QA testers (`curl -H "x-canary: true"`): 100% canary, every time

```bash
# Public traffic — mostly stable
curl http://color-app.localhost

# QA traffic — always canary
curl -H "x-canary: true" http://color-app.localhost
```

---

## Section 12: Automated Analysis & Promotion

### 12.1 Prometheus & Metrics Architecture

```
┌─────────────────────────────────────────────┐
│                  CLUSTER                     │
│                                              │
│  ┌──────────────┐     ┌──────────────────┐  │
│  │ Prometheus    │────►│ Your App Pods    │  │
│  │ Server        │scrape│ /metrics endpoint│  │
│  │               │     └──────────────────┘  │
│  │ Stores metrics│                           │
│  │ in time-series│     ┌──────────────────┐  │
│  │ database      │────►│ Kube State       │  │
│  └──────┬────────┘     │ Metrics          │  │
│         │              └──────────────────┘  │
│  ┌──────▼────────┐     ┌──────────────────┐  │
│  │ Alert Manager │     │ Node Exporter    │  │
│  │ (sends alerts)│     │ (CPU, memory)    │  │
│  └───────────────┘     └──────────────────┘  │
│                        ┌──────────────────┐  │
│                        │ Push Gateway     │  │
│                        │ (for short-lived │  │
│                        │  batch jobs)     │  │
│                        └──────────────────┘  │
└─────────────────────────────────────────────┘
```

**Service Discovery:** Prometheus finds scrape targets via **pod/service annotations:**

```yaml
annotations:
  prometheus.io/scrape: "true"
  prometheus.io/port: "3000"
  prometheus.io/path: "/metrics"
```

**Pull vs Push:** Prometheus primarily **pulls** metrics every scraping interval (default 1 minute, configurable). For short-lived Jobs that may complete between scrapes, use the **Push Gateway** to proactively send metrics.

---

### 12.2 Installing Prometheus

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm upgrade prometheus prometheus-community/prometheus \
  --version 27.49.0 \
  --install --create-namespace \
  --namespace monitoring \
  -f prometheus-values.yaml
```

```yaml name=prometheus-values.yaml
server:
  global:
    scrape_interval: 15s   # Default 1m, reduced for faster metrics in dev
```

Access UI: `kubectl port-forward svc/prometheus-server -n monitoring 9090:80` → `http://localhost:9090`

---

### 12.3 Analysis Templates & Analysis Runs

**What is an AnalysisTemplate?**

A **blueprint** that defines what metric to query, how often, how many times, and what constitutes success. When Argo Rollouts needs to run an analysis, it creates an **AnalysisRun** — an instance of the template.

```yaml name=analysis-template.yaml
apiVersion: argoproj.io/v1alpha1
kind: AnalysisTemplate
metadata:
  name: success-rate
  namespace: analysis-lab
spec:
  args:
    - name: service-name              # Parameterized for reuse
    - name: initial-delay
      value: "5s"                     # Default value (optional arg)
  metrics:
    - name: success-rate
      interval: 5s                    # Measure every 5 seconds
      count: 60                       # Total 60 measurements (5 minutes)
      failureLimit: 3                 # Max 3 failures before analysis fails
      initialDelay: "{{ args.initial-delay }}"
      successCondition: "result[0] >= 0.95"   # 95% success rate required
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

| Part | Meaning |
|------|---------|
| `http_request_duration_seconds_count` | Counter metric: total requests received |
| `code!~"[45].*"` | Exclude 4xx and 5xx status codes (only count successful) |
| `rate(...[1m])` | Calculate per-second rate over 1-minute window |
| `sum(...)` | Sum across all pods/instances |
| Numerator / Denominator | Successful requests / Total requests = Success rate |

---

### 12.4 Self-Healing Rollouts with Metrics

**As a step in canary:**

```yaml
strategy:
  canary:
    steps:
      - setWeight: 20
      - pause: { duration: 3m }       # Wait for metrics to populate
      - analysis:                      # Run analysis as a step
          templates:
            - templateName: success-rate
          args:
            - name: service-name
              value: analysis-canary
```

**As a background analysis (runs throughout the rollout):**

```yaml
strategy:
  canary:
    analysis:                          # Under canary, not under steps
      templates:
        - templateName: success-rate
      args:
        - name: service-name
          value: analysis-canary
      startingStep: 2                  # Start after step 2
    steps:
      - setWeight: 20
      - pause: { duration: 2m }
      - setWeight: 40
      - pause: { duration: 2m }
      - setWeight: 80
      - pause: { duration: 2m }
```

**Why background analysis is better:**

When analysis runs only as a step (e.g., at 20% weight), a 10% error rate in canary means only 2% total error rate → analysis passes. But at 80% weight, the same 10% error rate means 8% total error rate → would fail, but the step-based analysis already passed at 20%. Background analysis catches this because it runs continuously as weights increase.

**What happens on failure:**
1. Analysis run exceeds `failureLimit`
2. Argo Rollouts automatically **aborts** the rollout
3. All canary pods are terminated
4. Stable (old) version continues serving 100% of traffic
5. Rollout status shows **Degraded**

---

### 12.5 Analysis in Blue-Green Deployments

**Pre-Promotion Analysis:** Block the blue→green switch until metrics confirm the preview environment is healthy.

```yaml
strategy:
  blueGreen:
    activeService: blue-green-active
    previewService: blue-green-preview
    autoPromotionEnabled: false
    prePromotionAnalysis:                   # Runs BEFORE switching traffic
      templates:
        - templateName: success-rate
      args:
        - name: service-name
          value: blue-green-preview
        - name: initial-delay
          value: "2m"                       # Wait for metrics to populate
```

**Flow:**
1. New version deployed → preview service updated
2. Pre-promotion analysis starts (after initial delay)
3. Traffic generated to preview service for testing
4. If analysis passes → active service switches to new version
5. If analysis fails → rollout aborted, old version stays active

> **Important:** You must generate traffic to the **preview service** (not the active service) for metrics to flow. In blue-green, the preview environment receives no traffic by default.

**Post-Promotion Analysis** (`postPromotionAnalysis`) is also available — runs after the switch. But if it fails, you've already promoted a potentially buggy version.

---

## Interview Quick-Reference Cheat Sheet

| Topic | One-Line Answer |
|-------|----------------|
| **What is GitOps?** | Git is the single source of truth; agents continuously reconcile cluster state to match Git |
| **Argo CD vs Helm?** | Argo CD uses `helm template` — no `helm install`, no releases, no Helm state management |
| **Sync vs Health?** | Sync = does live match Git? Health = are resources actually working? |
| **Self-Heal vs Auto-Sync?** | Auto-sync reacts to Git changes; self-heal reacts to cluster changes |
| **Pruning?** | Deletes cluster resources whose manifests were removed from Git |
| **Projects?** | Argo CD's RBAC mechanism — restricts sources, destinations, and resource types per team |
| **Sync Waves?** | Control deployment ORDER within a sync phase using integer annotations |
| **Sync Hooks?** | Run Jobs at specific phases (PreSync/PostSync) for migrations, notifications, etc. |
| **Blue-Green?** | Full parallel environments, instant 100% traffic switch, doubles resources temporarily |
| **Canary?** | Gradual traffic shift (e.g., 5%→20%→50%→100%), less resource intensive than blue-green |
| **Why Gateway API over replica-weighted?** | Precise traffic splits (99/1) without over-provisioning pods |
| **Analysis Template?** | Blueprint for automated metric-based promotion/rollback decisions |
| **AnalysisRun?** | Instance of an AnalysisTemplate; queries Prometheus and evaluates success conditions |
| **Header-based routing?** | Deterministic routing for QA — set `x-canary: true` header to always reach canary |

**Common Debugging Commands:**

```bash
# Argo CD
kubectl get applications -n argocd
argocd app get <app-name>
argocd app diff <app-name>
argocd app sync <app-name> --prune

# Argo Rollouts
kubectl argo rollouts get rollout <name> -n <ns> --watch
kubectl argo rollouts promote <name> -n <ns>
kubectl argo rollouts abort <name> -n <ns>
kubectl argo rollouts retry <name> -n <ns>

# Debugging
kubectl describe application <name> -n argocd
kubectl get analysisrun -n <ns>
kubectl describe analysisrun <name> -n <ns>
```

**Common Mistakes:**

| Mistake | Fix |
|---------|-----|
| Application created but nothing deploys | You need to sync — auto-sync is off by default |
| "Repository not found" error | Missing credentials Secret with correct label |
| Rollout stuck in Degraded | Missing `strategy` field in Rollout spec |
| Analysis always fails immediately | Add `initialDelay` to wait for metrics to populate |
| Self-heal keeps reverting my debug changes | Temporarily set `selfHeal: false`, re-enable after |
| Helm values not taking effect | Check precedence: parameters > values > valueFiles > chart defaults |
