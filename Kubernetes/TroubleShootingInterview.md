# 🚀 Kubernetes Troubleshooting — Complete Interview-Ready Notes
### Senior DevOps Engineer Edition | Beginner-Friendly | Q1–Q40

---

## 📋 TABLE OF CONTENTS

| # | Topic | Category |
|---|-------|----------|
| Q1 | [CrashLoopBackOff](#q1--crashloopbackoff) | Pod Lifecycle |
| Q2 | [ImagePullBackOff](#q2--imagepullbackoff) | Pod Lifecycle |
| Q3 | [No Pod Created After Apply](#q3--no-pod-created-after-apply) | YAML / Config |
| Q4 | [kubectl apply Fails — Parsing Error](#q4--kubectl-apply-fails--parsing-error) | YAML / Config |
| Q5 | [Pod Stuck in Pending State](#q5--pod-stuck-in-pending-state) | Scheduling |
| Q6 | [OOMKilled](#q6--oomkilled) | Resource Management |
| Q7 | [Pod Restarts Frequently — No Logs](#q7--pod-restarts-frequently--no-logs) | Pod Lifecycle |
| Q8 | [Exit Code 1](#q8--exit-code-1) | Pod Lifecycle |
| Q9 | [Deployment Created but No Pod Started](#q9--deployment-created-but-no-pod-started) | Secrets / Registry |
| Q10 | [Init Container Skipped](#q10--init-container-skipped) | Pod Spec |
| Q11 | [Init Container Failing — CrashLoopBackOff](#q11--init-container-failing--crashloopbackoff) | Init Containers |
| Q12 | [Sidecar Pattern Logging Issue](#q12--sidecar-pattern-logging-issue) | Multi-Container |
| Q13 | [Pod Affinity Causing Latency](#q13--pod-affinity-causing-latency) | Scheduling |
| Q14 | [Pod Not Receiving IP — CNI Issue](#q14--pod-not-receiving-ip--cni-issue) | Networking |
| Q15 | [ReplicaSet Not Creating Pods](#q15--replicaset-not-creating-pods) | ReplicaSet / RBAC |
| Q16 | [Deployment Rollback Not Working](#q16--deployment-rollback-not-working) | Deployment |
| Q17 | [Paused Deployment Stuck](#q17--paused-deployment-stuck) | Deployment |
| Q18 | [Blue-Green Traffic Routed to Old Pods](#q18--blue-green-traffic-routed-to-old-pods) | Traffic Routing |
| Q19 | [Canary Pods Receiving All Traffic](#q19--canary-pods-receiving-all-traffic) | Traffic Routing |
| Q20 | [Image Update Ignored — No Rollout Triggered](#q20--image-update-ignored--no-rollout-triggered) | Deployment |
| Q21 | [Deployment Scaled but Missing Replicas](#q21--deployment-scaled-but-missing-replicas) | Scheduling / Quota |
| Q22 | [Downtime During Rolling Update](#q22--downtime-during-rolling-update) | Deployment Strategy |
| Q23 | [ClusterIP Unreachable Inside Cluster](#q23--clusterip-unreachable-inside-cluster) | Services |
| Q24 | [ClusterIP Resolves but Connection Refused](#q24--clusterip-resolves-but-connection-refused) | Services |
| Q25 | [NodePort Works on One Node Only](#q25--nodeport-works-on-one-node-only) | Services / Firewall |
| Q26 | [NodePort Not Accessible Externally](#q26--nodeport-not-accessible-externally) | Services / Firewall |
| Q27 | [Traffic Going to Pods on One Node Only](#q27--traffic-going-to-pods-on-one-node-only) | kube-proxy |
| Q28 | [Service Works via Pod IP Not Service Name](#q28--service-works-via-pod-ip-not-service-name) | DNS / CoreDNS |
| Q29 | [Headless Service Returns No DNS Records](#q29--headless-service-returns-no-dns-records) | DNS / Services |
| Q30 | [Pods Stuck in ContainerCreating](#q30--pods-stuck-in-containercreating) | Volume Mounts |
| Q31 | [Ingress Routing Failure — 404 Error](#q31--ingress-routing-failure--404-error) | Ingress |
| Q32 | [TLS Not Enforcing HTTPS](#q32--tls-not-enforcing-https) | Ingress / TLS |
| Q33 | [Path Rewrite Not Working](#q33--path-rewrite-not-working) | Ingress |
| Q34 | [Ingress 404 for /app Path](#q34--ingress-404-for-app-path) | Ingress |
| Q35 | [Host-Based Routing to Wrong Service](#q35--host-based-routing-to-wrong-service) | Ingress |
| Q36 | [ConfigMap Created but App Can't Read Values](#q36--configmap-created-but-app-cant-read-values) | ConfigMap |
| Q37 | [Env Vars from ConfigMap Not Appearing](#q37--env-vars-from-configmap-not-appearing) | ConfigMap / Namespace |
| Q38 | [ConfigMap Volume Mount — File Missing](#q38--configmap-volume-mount--file-missing) | ConfigMap / Volumes |
| Q39 | [Secret Injected but DB Auth Fails](#q39--secret-injected-but-db-auth-fails) | Secrets |
| Q40 | [ConfigMap Update Not Reflected in All Pods](#q40--configmap-update-not-reflected-in-all-pods) | ConfigMap / Lifecycle |

---

> 💡 **Beginner Tip:** Every section follows the same 10-point structure. Read Q1 fully first — it sets the mental model for all other issues.

---

---

# 🔴 Q1 — CrashLoopBackOff

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Pod keeps restarting repeatedly and never stays running |
| **Where** | Pod level — application container |
| **Symptom** | Status shows `CrashLoopBackOff`, restart count keeps increasing |

> 🟢 **Beginner Explanation:** Imagine you start a car but the engine immediately dies. You try again, it dies again. Kubernetes keeps trying to restart your container but it keeps failing — that's CrashLoopBackOff.

---

## 2️⃣ Root Cause Explanation
- The application **inside the container crashes** immediately after starting
- Kubernetes tries to restart it, waits (backoff time increases: 10s → 20s → 40s → 5min), and tries again
- Common causes:
  - ❌ Missing environment variables
  - ❌ Wrong configuration
  - ❌ Application code bug
  - ❌ Missing dependency (e.g., DB not reachable)
- **Components involved:** `kubelet` (restarts the container), container runtime (Docker/containerd)

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check pod status — find which pod is crashing
kubectl get pods

# Step 2: Describe the pod — see what happened and at which step
kubectl describe pod <pod-name>
# Look at: Events section at the bottom → "Back-off restarting failed container"

# Step 3: Read the logs — find the EXACT error
kubectl logs <pod-name>

# Step 4: If current logs are empty (pod already restarted), get previous run logs
kubectl logs <pod-name> --previous

# Step 5: Fix the YAML (e.g., add missing env variable)
# Step 6: Reapply the YAML
kubectl apply -f <yaml-file>
```

> 🧠 **Senior Mindset:** Always read logs BEFORE describe. Logs give you the "what went wrong". Describe gives you the "when and where it failed".

---

## 4️⃣ Fix / Resolution

**Example: Missing Environment Variable Fix**

```yaml
# pod.yaml — BEFORE (broken)
spec:
  containers:
  - name: nodejs-app
    image: nodejs:latest
    # Missing env variable DB_HOST!
```

```yaml
# pod.yaml — AFTER (fixed)
spec:
  containers:
  - name: nodejs-app
    image: nodejs:latest
    env:
    - name: DB_HOST
      value: "mysql-service"   # Add the missing environment variable
    - name: DB_PORT
      value: "3306"
```

```bash
# Apply the fix
kubectl apply -f pod.yaml
```

---

## 5️⃣ Interview Answer Version

> *"When a pod is in CrashLoopBackOff, my first step is `kubectl get pods` to confirm it, then `kubectl logs <pod-name> --previous` to catch the error from the last failed run. I then `kubectl describe pod` to check events. In one case, the root cause was a missing `DB_HOST` environment variable — the app crashed immediately because it couldn't connect to the database. I fixed the YAML, added the env variable, and redeployed."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Monday morning. Alert fires: `Pod nodejs-prod is in CrashLoopBackOff`. Restart count = 14.
>
> **Detection:** PagerDuty alert + Grafana pod restart count metric spike
>
> **Investigation:** `kubectl logs nodejs-prod --previous` shows:
> ```
> Error: DB_HOST environment variable is not set
> Process exited with code 1
> ```
>
> **Resolution:** Team checks the deployment YAML — the env variable was accidentally deleted in the last PR. Fix is merged, redeployed in 5 minutes.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get pods` | See all pods and their status |
| `kubectl get pods -w` | Watch pods in real-time |
| `kubectl describe pod <name>` | Full details + events |
| `kubectl logs <name>` | Current container logs |
| `kubectl logs <name> --previous` | Logs from last failed run |
| `kubectl logs <name> -f` | Stream/follow logs live |
| `kubectl get events --sort-by='.lastTimestamp'` | See all cluster events sorted by time |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Use `kubectl logs <pod> --previous` — this is the **most important command** for CrashLoopBackOff because current logs may be empty
- 🔍 Check `exit code` in describe output:
  - `Exit Code 0` = Success (shouldn't crash)
  - `Exit Code 1` = General application error
  - `Exit Code 137` = OOMKilled (out of memory)
  - `Exit Code 139` = Segmentation fault
- 🛡️ **Preventive:** Always use `livenessProbe` and `readinessProbe` — helps Kubernetes detect failures faster
- 🛡️ Use `envFrom` with ConfigMaps/Secrets so environment variables are managed centrally

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between CrashLoopBackOff and Error?**
> `Error` means the container exited with a non-zero code once. `CrashLoopBackOff` means it's repeatedly failing and Kubernetes is applying exponential backoff before retrying.

**Q: How does the backoff timer work?**
> Kubernetes waits: 10s → 20s → 40s → 80s → 160s → max 5 minutes between retries. This prevents overloading resources.

**Q: Can a CrashLoopBackOff pod be fixed without redeployment?**
> Yes — if using `envFrom` pointing to a ConfigMap, you can update the ConfigMap. But the pod must be restarted to pick up new env vars. For volume-mounted configs, changes reflect automatically.

---

## 🔟 Related Concepts to Revise
- Pod lifecycle states (Pending → Running → Succeeded/Failed)
- Environment variables in Kubernetes (env, envFrom)
- ConfigMaps and Secrets
- Liveness and Readiness Probes
- Container exit codes

---
---

# 🔴 Q2 — ImagePullBackOff

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Kubernetes cannot pull the container image from registry |
| **Where** | Pod level — during image pull phase |
| **Symptom** | Status shows `ImagePullBackOff` or `ErrImagePull` |

> 🟢 **Beginner Explanation:** Like trying to download an app that doesn't exist in the app store — Kubernetes can't find or access the image, so the container never starts.

---

## 2️⃣ Root Cause Explanation
- Kubernetes tries to pull the image from the registry before starting the container
- Causes:
  - ❌ **Wrong image tag** (e.g., `myapp:v99` doesn't exist)
  - ❌ **Typo in image name**
  - ❌ **Private registry** — no credentials provided
  - ❌ **Registry is down** or unreachable
  - ❌ **Rate limiting** (Docker Hub free tier limit)
- **Components involved:** `kubelet` initiates pull, container runtime (containerd/Docker) performs the actual pull

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check pod status
kubectl get pods
# You'll see: STATUS = ImagePullBackOff or ErrImagePull

# Step 2: Describe pod — find the exact pull error
kubectl describe pod <pod-name>
# Look for Events section:
# "Failed to pull image: rpc error: ... manifest unknown"
# OR "unauthorized: authentication required"

# Step 3: Verify the image exists in registry
# For Docker Hub: check hub.docker.com
# For ECR/GCR: check via cloud console

# Step 4: Check if imagePullSecret is needed
kubectl get secret

# Step 5: Fix the image tag or add imagePullSecret, then reapply
kubectl apply -f deployment.yaml
```

---

## 4️⃣ Fix / Resolution

**Fix 1: Correct the image tag**
```yaml
spec:
  containers:
  - name: myapp
    image: myapp:v2.1.0   # Use a valid, existing tag
    # NOT: myapp:v99 (non-existent tag)
```

**Fix 2: Add imagePullSecret for private registry**
```bash
# Create the secret first
kubectl create secret docker-registry my-registry-secret \
  --docker-server=registry.example.com \
  --docker-username=myuser \
  --docker-password=mypassword \
  --docker-email=myemail@example.com
```

```yaml
# Reference it in deployment
spec:
  imagePullSecrets:
  - name: my-registry-secret   # Reference the secret here
  containers:
  - name: myapp
    image: registry.example.com/myapp:v2.1.0
```

---

## 5️⃣ Interview Answer Version

> *"ImagePullBackOff means Kubernetes can't pull the container image. I start with `kubectl describe pod` to see the exact error in the Events section. The most common causes are: wrong/non-existent image tag, or missing imagePullSecret for a private registry. I verify the image exists in the registry, fix the tag or add the pull secret, and redeploy. I also check if CI pipeline published the image successfully before the deployment ran."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** New deployment pushed. All pods show `ImagePullBackOff`.
>
> **Alert:** Deployment health check fails in CI/CD pipeline
>
> **Investigation:** `kubectl describe pod` shows:
> ```
> Failed to pull image "registry.company.com/api:build-123":
> unauthorized: authentication required
> ```
>
> **Root cause:** The imagePullSecret was not added to the new namespace after namespace migration.
>
> **Resolution:** Created the docker-registry secret in new namespace, added `imagePullSecrets` to deployment YAML.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get pods` | See ImagePullBackOff status |
| `kubectl describe pod <name>` | See exact pull error in Events |
| `kubectl get secret` | List available secrets |
| `kubectl get secret <name> -o yaml` | Inspect secret details |
| `kubectl create secret docker-registry` | Create registry credentials |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `ErrImagePull` = first failure attempt. `ImagePullBackOff` = Kubernetes giving up and backing off
- 🔍 For ECR (AWS): ensure the node's IAM role has `ecr:GetAuthorizationToken` permission
- 🔍 Docker Hub rate limits: 100 pulls/6 hours for unauthenticated. Use authenticated pulls or mirror the image
- 🛡️ **Best practice:** Always pin image tags. Never use `latest` in production — it leads to unpredictable behavior
- 🛡️ Use image digest (`@sha256:...`) for absolute version control

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between ImagePullBackOff and ErrImagePull?**
> `ErrImagePull` is the immediate error on first failure. `ImagePullBackOff` is the state after multiple failures with increasing wait times between retries.

**Q: How would you handle private registry credentials securely?**
> Use Kubernetes Secrets of type `docker-registry`. In production, use a secret management tool like HashiCorp Vault or AWS Secrets Manager synced via External Secrets Operator.

**Q: What imagePullPolicy values exist and when do you use each?**
> `Always` — always pull (use for `latest` or frequently updated images), `IfNotPresent` — pull only if not cached (use for pinned tags), `Never` — never pull (use in air-gapped environments).

---

## 🔟 Related Concepts to Revise
- Container registries (Docker Hub, ECR, GCR, ACR)
- Kubernetes Secrets (docker-registry type)
- imagePullPolicy
- ServiceAccount image pull secrets
- Node IAM roles for cloud registries

---
---

# 🟡 Q3 — No Pod Created After Apply

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | `kubectl apply` runs successfully but no pod appears |
| **Where** | YAML manifest / Kubernetes API |
| **Symptom** | Command shows "configured" or "created" but `kubectl get pods` shows nothing |

> 🟢 **Beginner Explanation:** Like filling out a form incorrectly — the form was submitted successfully but because the `kind` field was wrong, Kubernetes created a different resource type (not a Pod).

---

## 2️⃣ Root Cause Explanation
- `kubectl apply` only validates YAML syntax — not logical correctness
- If `kind: Deployment` is written when you meant `kind: Pod`, Kubernetes creates a Deployment (no error) but you may not see a pod if it has issues
- Spelling mistakes in `kind`, wrong `apiVersion`, or incorrect `spec` structure silently create wrong/broken resources
- **Components involved:** Kubernetes API Server (accepts the request), specific controller based on `kind`

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check your YAML — verify 'kind' field
cat pod.yaml
# kind: Pod   ← must be exactly this, case sensitive

# Step 2: Check apiVersion is correct for the kind
# Pod → apiVersion: v1
# Deployment → apiVersion: apps/v1

# Step 3: See ALL resources created
kubectl get all
# This shows deployments, pods, services, replicasets — everything

# Step 4: Run dry-run to catch errors before applying
kubectl apply -f pod.yaml --dry-run=client
# This simulates the apply without actually creating anything

# Step 5: Validate the YAML
kubectl apply -f pod.yaml --dry-run=server
# This validates against the actual Kubernetes API
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE (wrong kind — typo)
apiVersion: v1
kind: pod          # ❌ Lowercase — Kubernetes may reject or misinterpret
metadata:
  name: my-app
spec:
  containers:
  - name: app
    image: nginx
```

```yaml
# AFTER (correct)
apiVersion: v1
kind: Pod          # ✅ Capital P
metadata:
  name: my-app
spec:
  containers:
  - name: app
    image: nginx
```

```bash
# Dry run first, then apply
kubectl apply -f pod.yaml --dry-run=client
kubectl apply -f pod.yaml
kubectl get pods   # Verify pod exists now
```

---

## 5️⃣ Interview Answer Version

> *"When a kubectl apply shows 'created' but no pod appears, I first open the YAML and verify the `kind` field — a typo like `pod` instead of `Pod` can cause Kubernetes to misinterpret the resource. Then I check `apiVersion` and `spec` structure. I use `kubectl get all` to see what actually got created, and `kubectl apply --dry-run=client` to catch formatting issues before reapplying."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Junior engineer applies a YAML. No pod appears. No errors.
>
> **Investigation:** `kubectl get all` reveals a Deployment was created — not a Pod. The YAML had `kind: Deployment` but the spec was written for a Pod (no `template` section).
>
> **Resolution:** YAML is corrected to proper Deployment structure with `spec.template.spec.containers`.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get all` | See every resource in current namespace |
| `kubectl get all -A` | See every resource in all namespaces |
| `kubectl apply -f file.yaml --dry-run=client` | Simulate apply locally |
| `kubectl apply -f file.yaml --dry-run=server` | Validate against API server |
| `kubectl explain pod.spec` | Get documentation for any field |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Use `kubectl explain` to understand correct YAML structure: `kubectl explain pod.spec.containers`
- 🔍 Install `kubeval` or `kube-score` in your CI pipeline to validate YAML before it reaches the cluster
- 🛡️ Use `--dry-run=server` (not just client) — server dry-run actually validates against admission controllers
- 🛡️ Use a linter like `yamllint` in pre-commit hooks

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between `--dry-run=client` and `--dry-run=server`?**
> `client` only validates YAML structure locally. `server` sends the request to the API server, which validates it against admission controllers, CRDs, and actual API versions — much more thorough.

**Q: How would you prevent YAML mistakes in a team environment?**
> Use OPA/Gatekeeper policies, CI pipeline YAML validation with `kubeval`, GitOps workflows (ArgoCD/Flux) with pre-merge validation hooks.

---

## 🔟 Related Concepts to Revise
- Kubernetes resource types and their `kind` values
- API versions (`v1`, `apps/v1`, `batch/v1`)
- kubectl apply vs create
- Admission controllers
- YAML structure for Pods, Deployments, Services

---
---

# 🟡 Q4 — kubectl apply Fails — Parsing Error

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | `kubectl apply` fails immediately with a parsing error |
| **Where** | Client-side YAML parsing — never even reaches the cluster |
| **Symptom** | Error like `error parsing YAML` or `mapping values are not allowed` |

> 🟢 **Beginner Explanation:** Like sending a letter written in a language the post office can't read — the problem is with your letter (YAML file), not the destination (Kubernetes cluster).

---

## 2️⃣ Root Cause Explanation
- YAML is **whitespace-sensitive** — indentation errors break the entire file
- Common causes:
  - ❌ Wrong indentation (tabs instead of spaces, or wrong number of spaces)
  - ❌ Invalid YAML syntax (missing colon, extra colon)
  - ❌ Wrong data type (e.g., number where string expected, or vice versa)
  - ❌ Duplicate keys
- **Key insight:** Kubernetes never even received this YAML. The problem is 100% in your file.
- **Components involved:** `kubectl` client-side YAML parser

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Read the exact error message — it usually includes the line number
kubectl apply -f deployment.yaml
# Error: error converting YAML to JSON: yaml: line 12: ...

# Step 2: Open file and check the reported line
vim deployment.yaml
# Look at line 12 and surrounding context

# Step 3: Check for tabs (tabs are NOT valid in YAML — use spaces only)
cat -A deployment.yaml | grep -P "^\t"

# Step 4: Run YAML lint to find all issues at once
yamllint deployment.yaml

# Step 5: Use online YAML validator (yamllint.com) for quick check

# Step 6: Dry run after fixing
kubectl apply -f deployment.yaml --dry-run=client
```

---

## 4️⃣ Fix / Resolution

```yaml
# BROKEN — Wrong indentation (tab used or wrong spaces)
spec:
  containers:
  - name: app
      image: nginx    # ❌ Extra spaces — wrong indentation level
      ports:
    - containerPort: 80   # ❌ Inconsistent indentation
```

```yaml
# FIXED — Correct indentation (2 spaces consistently)
spec:
  containers:
  - name: app
    image: nginx        # ✅ 4 spaces (2 for list item offset + 2 for indent)
    ports:
    - containerPort: 80 # ✅ Consistent indentation
```

```yaml
# BROKEN — Wrong data type
spec:
  replicas: "3"   # ❌ String instead of integer
```

```yaml
# FIXED
spec:
  replicas: 3     # ✅ Integer
```

---

## 5️⃣ Interview Answer Version

> *"If kubectl apply fails with a parsing error before even hitting the cluster, the issue is entirely in the YAML file — Kubernetes never saw it. I check the error message for the line number, open the file, and look for: indentation errors (tabs vs spaces), invalid syntax, or wrong data types. I run `yamllint` to catch all issues at once, fix them, then validate with `--dry-run=client` before reapplying."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** CI/CD pipeline fails at deployment step with `YAML parse error on line 23`.
>
> **Root cause:** Developer used tab characters in YAML (IDE defaulted to tabs instead of spaces).
>
> **Resolution:** Added `.editorconfig` file to enforce spaces in YAML files. Added `yamllint` step to CI pipeline.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl apply -f file.yaml --dry-run=client` | Validate YAML before applying |
| `kubectl apply -f file.yaml --dry-run=server` | Full server-side validation |
| `yamllint file.yaml` | Lint YAML for issues (requires install) |
| `python3 -c "import yaml; yaml.safe_load(open('file.yaml'))"` | Quick Python YAML check |
| `kubectl explain deployment.spec` | Get correct YAML structure reference |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 **YAML indentation rule:** Use 2 spaces consistently. NEVER use tabs.
- 🔍 In `vim`, run `:set list` to see tabs (shown as `^I`) vs spaces
- 🛡️ Add `yamllint` to your CI/CD pipeline as a pre-check step
- 🛡️ Use VS Code with YAML extension — it highlights errors in real-time
- 🛡️ Consider using Helm or Kustomize to generate YAML programmatically, reducing manual YAML errors

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: How do you prevent YAML errors in production deployments?**
> Use a GitOps approach with YAML validation in the CI pipeline using `kubeval`, `kube-score`, or `conftest`. Also use linting pre-commit hooks.

**Q: What are the most common YAML mistakes in Kubernetes?**
> Wrong indentation, using tabs, incorrect data types (string vs int), duplicate keys, missing required fields, wrong API version for a resource kind.

---

## 🔟 Related Concepts to Revise
- YAML syntax rules
- kubectl client vs server validation
- Helm templating (alternative to raw YAML)
- CI/CD YAML validation tools (kubeval, kube-score)
- VS Code YAML extension

---
---

# 🟡 Q5 — Pod Stuck in Pending State

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Pod is created but never starts running |
| **Where** | Scheduler level — node assignment phase |
| **Symptom** | Status shows `Pending` — no containers running, no logs, no errors visible |

> 🟢 **Beginner Explanation:** The pod is like a job applicant who applied but hasn't been assigned a desk yet. The Kubernetes scheduler can't find a suitable node (desk) to place the pod.

---

## 2️⃣ Root Cause Explanation
- Kubernetes **Scheduler** is responsible for assigning pods to nodes
- If no node satisfies the pod's requirements, it stays `Pending`
- Common causes:
  - ❌ **Insufficient CPU or Memory** — no node has enough resources
  - ❌ **Taints** — node has a taint the pod doesn't tolerate
  - ❌ **Node Selector** — pod requires a specific label that no node has
  - ❌ **Affinity rules** — pod has affinity rules that can't be satisfied
  - ❌ **PVC not bound** — pod needs a volume that doesn't exist
- **Components involved:** `kube-scheduler`, node resource manager, taints/tolerations system

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm pending status
kubectl get pods
# STATUS = Pending

# Step 2: Describe pod — MOST IMPORTANT STEP
kubectl describe pod <pod-name>
# Look at: Events section at bottom
# Common messages:
# "0/3 nodes are available: 3 Insufficient memory"
# "0/3 nodes are available: node(s) had taint {key:value}"
# "0/3 nodes are available: node(s) didn't match node selector"

# Step 3: Check node resources
kubectl describe nodes
# OR
kubectl top nodes   # Requires metrics-server

# Step 4: Check taints on nodes
kubectl describe node <node-name> | grep Taint

# Step 5: Check node labels (for nodeSelector issues)
kubectl get nodes --show-labels
```

---

## 4️⃣ Fix / Resolution

**Fix 1: Reduce resource requests**
```yaml
# BEFORE (requesting too much)
resources:
  requests:
    memory: "8Gi"    # ❌ No node has 8Gi free
    cpu: "4"

# AFTER (realistic request)
resources:
  requests:
    memory: "512Mi"  # ✅ Fits on available nodes
    cpu: "250m"
```

**Fix 2: Add toleration for node taint**
```yaml
spec:
  tolerations:
  - key: "dedicated"
    operator: "Equal"
    value: "gpu"
    effect: "NoSchedule"   # ✅ Now pod can run on tainted GPU node
```

**Fix 3: Fix node selector**
```yaml
spec:
  nodeSelector:
    disktype: ssd    # ✅ Make sure at least one node has this label
```

```bash
# Add label to node if needed
kubectl label node <node-name> disktype=ssd
```

---

## 5️⃣ Interview Answer Version

> *"When a pod is stuck in Pending, the scheduler can't place it on any node. My first command is `kubectl describe pod <name>` — the Events section tells me exactly why. Common reasons are insufficient CPU/memory, a node taint the pod doesn't tolerate, or a nodeSelector with no matching node. I then check node resources with `kubectl top nodes` and adjust either the pod's resource requests or fix the scheduling rules."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** New microservice deployment — 3 pods stuck in Pending.
>
> **Detection:** Team notices pods never reach Running state after 10 minutes.
>
> **Investigation:** `kubectl describe pod` shows:
> ```
> 0/5 nodes are available: 5 Insufficient memory.
> ```
>
> **Root cause:** Recent platform upgrade increased memory requests from 256Mi to 2Gi in the new Helm chart values.
>
> **Resolution:** Reverted memory request to 512Mi. Long-term: added node autoscaling.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl describe pod <name>` | See scheduling failure reason in Events |
| `kubectl top nodes` | Check actual resource usage per node |
| `kubectl describe node <name>` | See node capacity, taints, conditions |
| `kubectl get nodes --show-labels` | Check node labels for nodeSelector |
| `kubectl describe node <name> \| grep Taint` | Check node taints |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 The key information is always in `kubectl describe pod` → Events section. Never skip this.
- 🔍 `kubectl get events --field-selector involvedObject.name=<pod-name>` — filter events for specific pod
- 🔍 Check `ResourceQuota` in the namespace — namespace-level quotas can also block scheduling
- 🛡️ **Best practice:** Set both `requests` (what the scheduler uses) and `limits` (max allowed) for all containers
- 🛡️ Use Cluster Autoscaler in cloud environments to automatically add nodes when resources are insufficient
- ⚠️ `requests` ≠ `limits` — requests are for scheduling, limits are for enforcement

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between requests and limits?**
> `requests` = minimum resources guaranteed, used by scheduler for node selection. `limits` = maximum resources the container can use; exceeded limits cause OOMKill (memory) or throttling (CPU).

**Q: What is a taint and toleration?**
> Taints are applied to nodes to repel pods. Tolerations are applied to pods to allow them to be scheduled on tainted nodes. Example: GPU nodes are tainted so only GPU workloads (with tolerations) run there.

**Q: How does node affinity differ from nodeSelector?**
> `nodeSelector` is simple key-value matching. `nodeAffinity` supports more complex rules like `In`, `NotIn`, `Exists`, and can be `required` (hard) or `preferred` (soft).

---

## 🔟 Related Concepts to Revise
- Kubernetes Scheduler
- Resource requests and limits
- Taints and Tolerations
- Node Affinity / Pod Affinity
- Resource Quotas and LimitRanges
- Cluster Autoscaler

---
---

# 🔴 Q6 — OOMKilled

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Container is killed because it exceeded its memory limit |
| **Where** | Pod/Container level — runtime enforcement |
| **Symptom** | Pod shows `OOMKilled` status, Exit Code `137` |

> 🟢 **Beginner Explanation:** You gave your application a 512MB memory box. It tried to use 540MB. Kubernetes enforced the limit and forcefully killed it — that's OOMKilled (Out Of Memory Killed).

---

## 2️⃣ Root Cause Explanation
- Container's memory usage **exceeded the configured memory limit**
- Linux kernel's OOM (Out of Memory) killer terminates the process
- Exit code `137` = `128 + 9` (signal 9 = SIGKILL)
- Common causes:
  - ❌ Memory limit set too low
  - ❌ Memory leak in application
  - ❌ Unexpected traffic spike causing higher memory usage
- **Components involved:** Linux kernel OOM killer, `kubelet`, container runtime

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm OOMKill and exit code
kubectl describe pod <pod-name>
# Look for: "Last State: Terminated | Reason: OOMKilled | Exit Code: 137"

# Step 2: Check current memory usage
kubectl top pod <pod-name>
# Shows: current CPU and Memory usage
# e.g., CPU: 75m   Memory: 540Mi

# Step 3: Check memory limit in deployment YAML
kubectl describe deployment <deployment-name> | grep -A5 "Limits"
# Or open the YAML directly
# e.g., Memory limit: 512Mi  ← less than 540Mi actual usage!

# Step 4: Update memory limit in YAML
# Change from 512Mi to 768Mi (give ~30-50% headroom)

# Step 5: Redeploy
kubectl apply -f deployment.yaml

# Step 6: Verify — check if OOMKill stopped
kubectl get pods    # Should show Running, restart count should stop increasing
kubectl top pod <pod-name>   # Confirm memory usage is within new limit
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE (limit too low)
resources:
  requests:
    memory: "256Mi"
    cpu: "100m"
  limits:
    memory: "512Mi"   # ❌ App uses 540Mi → gets killed
    cpu: "500m"
```

```yaml
# AFTER (limit increased with headroom)
resources:
  requests:
    memory: "256Mi"
    cpu: "100m"
  limits:
    memory: "768Mi"   # ✅ ~30% above actual usage as headroom
    cpu: "500m"
```

```bash
kubectl apply -f deployment.yaml
kubectl rollout status deployment/<name>
```

---

## 5️⃣ Interview Answer Version

> *"OOMKilled means the container exceeded its memory limit and the Linux kernel killed it. Exit code 137 is the telltale sign. I first use `kubectl describe pod` to confirm the reason, then `kubectl top pod` to see actual memory usage. If usage exceeds the configured limit, I increase the limit in the YAML with 30-50% headroom and redeploy. If it's a memory leak, I flag it to the dev team to investigate the application code."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Python ML job pod keeps restarting every 3-4 minutes in production.
>
> **Alert:** Restart count alert fires. `kubectl describe` shows Exit Code 137.
>
> **Investigation:** `kubectl top pod` shows memory at 540Mi. YAML limit is 512Mi.
>
> **Resolution:** Increased limit to 768Mi. Also added a memory monitoring alert at 80% of limit as early warning.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl describe pod <name>` | See OOMKilled reason + exit code |
| `kubectl top pod <name>` | Current CPU + memory usage |
| `kubectl top node` | Node-level resource usage |
| `kubectl get pod <name> -o yaml \| grep -A10 resources` | Check configured limits |
| `kubectl logs <name> --previous` | Get logs before OOM kill |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Exit code `137` always means OOMKill — memorize this
- 🔍 If memory usage grows over time (not just high from start), it's likely a **memory leak** — alert the dev team
- 🔍 Use `kubectl top pod --containers` to see memory per container in a multi-container pod
- 🛡️ Use **VPA (Vertical Pod Autoscaler)** in recommendation mode to get right-sizing suggestions
- 🛡️ Set up alerts in Prometheus/Grafana at 80% memory utilization as early warning
- 🛡️ Never set memory limit too tight — always leave ~20-30% headroom above observed peak usage

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between exit code 137 and 139?**
> `137` = OOMKilled (SIGKILL from kernel). `139` = Segmentation fault (SIGSEGV — application memory access error, typically a bug in C/C++ code).

**Q: What is VPA and how does it help?**
> Vertical Pod Autoscaler automatically adjusts CPU/memory requests and limits based on actual usage history. In recommendation mode, it suggests right values. In auto mode, it can apply them automatically.

**Q: Can you increase memory without redeployment?**
> Not directly for running pods. You must update the deployment spec and trigger a rollout. With VPA in auto mode, it handles this automatically by evicting and restarting pods.

---

## 🔟 Related Concepts to Revise
- Linux OOM killer
- Kubernetes resource requests vs limits
- Exit codes (137, 139, 1, 0)
- Vertical Pod Autoscaler (VPA)
- Horizontal Pod Autoscaler (HPA)
- Prometheus memory alerting

---
---

# 🟡 Q7 — Pod Restarts Frequently — No Logs

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Pod keeps restarting but current logs are empty |
| **Where** | Pod level — application startup |
| **Symptom** | High restart count in `kubectl get pods`, empty `kubectl logs` output |

> 🟢 **Beginner Explanation:** The app crashes so fast that it doesn't have time to write anything to the log. Like a person who faints before they can say what's wrong.

---

## 2️⃣ Root Cause Explanation
- Application crashes **immediately on startup** — before logging infrastructure initializes
- Current run logs are empty because the new container just started
- You need logs from the **previous (failed) run**
- Common causes:
  - ❌ Database not reachable on startup
  - ❌ Missing required config/env variable
  - ❌ Application initialization failure
- **Components involved:** `kubelet` (manages restarts), container runtime, application itself

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check restart count
kubectl get pods
# Look for high RESTARTS count (e.g., 6, 12, 20+)

# Step 2: Describe pod — check events
kubectl describe pod <pod-name>
# Look for: "Back-off restarting failed container"
# Check: Last State (Terminated, exit code, reason)

# Step 3: Get logs from PREVIOUS (last failed) run ← KEY COMMAND
kubectl logs <pod-name> --previous
# This gives you logs from the container before current restart

# Step 4: Analyze the error
# Example: "database not reachable at mysql-service:3306"

# Step 5: Check if database service exists
kubectl get svc
kubectl get pods -l app=mysql   # Check if DB pod is running

# Step 6: If DB is up, check connectivity from inside the pod
kubectl exec -it <pod-name> -- curl mysql-service:3306

# Step 7: Fix issue and redeploy
kubectl apply -f deployment.yaml
kubectl get pods -w   # Watch until stable
```

---

## 4️⃣ Fix / Resolution

```bash
# If DB service doesn't exist — create it
# Check what services exist
kubectl get svc -n <namespace>

# If DB pod isn't running
kubectl get pods -n <namespace> | grep mysql

# Common fix: ensure DB is deployed and healthy BEFORE app pods
# Use init containers to wait for DB readiness
```

```yaml
# Use init container to wait for DB before starting app
spec:
  initContainers:
  - name: wait-for-db
    image: busybox
    command: ['sh', '-c', 'until nc -z mysql-service 3306; do echo waiting; sleep 2; done']
  containers:
  - name: app
    image: myapp:v1
```

---

## 5️⃣ Interview Answer Version

> *"When a pod restarts frequently with empty logs, the app is crashing before it can log anything. The key command here is `kubectl logs <pod-name> --previous` — this fetches logs from the last failed container run. In one case, this revealed 'database not reachable'. I then checked if the DB service existed with `kubectl get svc`. The DB was up but the app had a wrong service name. Long-term fix: added an init container to wait for DB readiness."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** After cluster migration, app pods show 8 restarts, logs are empty.
>
> **Investigation:** `kubectl logs app-pod --previous` shows:
> ```
> Connection refused: mysql-prod:3306
> ```
>
> **Root cause:** DB service name changed from `mysql-prod` to `mysql-service` after migration. App still referenced old name.
>
> **Resolution:** Updated env variable `DB_HOST` in ConfigMap.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl logs <name> --previous` | **KEY** — logs from last failed run |
| `kubectl get pods` | See restart count |
| `kubectl describe pod <name>` | Events + last state details |
| `kubectl exec -it <name> -- sh` | Shell into container for debugging |
| `kubectl get svc` | Check if dependent services exist |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `--previous` flag is the **most important flag** to know for this scenario
- 🔍 If even `--previous` shows nothing, the app crashes before writing a single byte — check resource limits (OOMKill?) or startup command
- 🛡️ Always use **init containers** to ensure dependencies (DB, cache, config service) are ready before main app starts
- 🛡️ Use **startupProbe** for apps with slow startup — prevents premature restart by kubelet
- 🛡️ Set a `terminationMessagePath` in pod spec to capture last error message even without logs

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between livenessProbe and readinessProbe?**
> `livenessProbe`: Is the container still alive? If it fails, container is restarted. `readinessProbe`: Is the container ready to receive traffic? If it fails, pod is removed from service endpoints (no restart). `startupProbe`: Is the app done initializing? Protects slow-starting apps from premature liveness checks.

**Q: How do you prevent an app from restarting when its dependency (DB) is down?**
> Use init containers to wait for the dependency to be ready. Also implement retry logic and circuit breakers in the application code.

---

## 🔟 Related Concepts to Revise
- `kubectl logs --previous`
- Init containers
- Liveness, Readiness, and Startup probes
- Pod restart policy (Always, OnFailure, Never)
- Kubernetes dependencies and startup ordering

---
---

# 🟡 Q8 — Exit Code 1

## 1️��� Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Container exits immediately with exit code 1 |
| **Where** | Container/Application level |
| **Symptom** | Pod in `Error` or `CrashLoopBackOff` state, exit code = 1 in describe |

> 🟢 **Beginner Explanation:** Exit code 1 is like a general "something went wrong" signal from the application. It's the most common non-specific error code.

---

## 2️⃣ Root Cause Explanation
- Exit code `1` = **general application error** — the app itself detected an error and exited
- Not a Kubernetes problem — the container ran but the app inside it failed
- Common causes:
  - ❌ Config file not found
  - ❌ Invalid environment variable value
  - ❌ Missing required argument
  - ❌ Permission denied on a file
  - ❌ Uncaught application exception
- **Components involved:** Application code, ConfigMaps, Secrets, volume mounts

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm exit code
kubectl get pod <pod-name>
# STATUS: Error or CrashLoopBackOff

# Step 2: Check exit code in describe
kubectl describe pod <pod-name>
# Last State: Terminated | Exit Code: 1

# Step 3: Get previous logs — find the actual error
kubectl logs <pod-name> --previous
# Common errors:
# "config file /etc/app/config.yaml not found"
# "invalid value for DATABASE_URL: must start with postgres://"

# Step 4: Based on error, fix the root cause:
# - Missing config file → check volume mount or ConfigMap
# - Wrong env var → update ConfigMap or Secret
# - Permission issue → check securityContext

# Step 5: Update ConfigMap/Secret
kubectl edit configmap <name>
# OR
kubectl apply -f configmap.yaml

# Step 6: Restart pods to pick up new config
kubectl rollout restart deployment/<name>

# Step 7: Verify
kubectl get pod <pod-name>
kubectl logs <pod-name>   # Should show healthy startup
```

---

## 4️⃣ Fix / Resolution

**Example: Missing environment variable fixed via ConfigMap**

```yaml
# configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DATABASE_URL: "postgres://user:pass@postgres-service:5432/mydb"
  APP_ENV: "production"
  LOG_LEVEL: "info"
```

```yaml
# deployment.yaml — reference ConfigMap
spec:
  containers:
  - name: app
    image: myapp:v1
    envFrom:
    - configMapRef:
        name: app-config    # ✅ Inject all keys as env vars
```

```bash
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl get pods   # Verify running
```

---

## 5️⃣ Interview Answer Version

> *"Exit code 1 means the application exited with a general error — the problem is in the app, not Kubernetes. I run `kubectl logs --previous` to find the specific error message. Common causes are missing config files, invalid environment variable values, or permission issues. Once I identify the error — say 'config file not found' — I fix the ConfigMap or volume mount, apply the fix, and restart the deployment."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** New app version deployed. All pods fail with exit code 1.
>
> **Investigation:** `kubectl logs app-pod --previous` shows:
> ```
> FATAL: Invalid value for LOG_LEVEL: 'debug-verbose' is not a valid log level
> ```
>
> **Root cause:** ConfigMap was updated with wrong value (`debug-verbose` instead of `debug`).
>
> **Resolution:** Fixed ConfigMap value, rolled out restart.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl logs <name> --previous` | Get error from last failed run |
| `kubectl describe pod <name>` | Confirm exit code |
| `kubectl exec -it <name> -- env` | Check environment variables in container |
| `kubectl get configmap <name> -o yaml` | Inspect ConfigMap values |
| `kubectl rollout restart deployment/<name>` | Restart all pods in deployment |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Exit code reference: `1` = app error, `126` = permission denied, `127` = command not found, `137` = OOMKill, `139` = segfault
- 🔍 `kubectl exec -it <pod> -- env` — verify what environment variables are actually visible inside the container (vs what you expect)
- 🛡️ Use `envFrom` with validation — some apps support `--validate-config` flags at startup
- 🛡️ Consider using `initContainers` to validate config before main container starts

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: How do you update a ConfigMap and make running pods use the new values?**
> Update the ConfigMap with `kubectl apply`. Then trigger a rolling restart with `kubectl rollout restart deployment/<name>`. Environment variables from ConfigMap are only loaded at container startup, so pods must restart.

**Q: When would you use a Secret vs a ConfigMap?**
> ConfigMap = non-sensitive configuration (URLs, feature flags, log levels). Secret = sensitive data (passwords, API keys, TLS certificates). Secrets are base64 encoded and can be encrypted at rest with etcd encryption.

---

## 🔟 Related Concepts to Revise
- Exit codes
- ConfigMaps and Secrets
- envFrom vs env in pod spec
- Volume mounts for config files
- kubectl rollout restart

---
---

# 🔴 Q9 — Deployment Created but No Pod Started

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Deployment exists but pods are either Pending or not appearing |
| **Where** | Pod startup — image pull phase |
| **Symptom** | `kubectl get deployment` shows ready, but `kubectl get pods` shows Pending or ImagePullBackOff |

> 🟢 **Beginner Explanation:** The deployment blueprint exists, but Kubernetes can't start the actual containers because it can't download the image from a private registry — like having a recipe but no access to the ingredient store.

---

## 2️⃣ Root Cause Explanation
- Deployment is created successfully (controller plane accepts it)
- When kubelet tries to pull the image from a **private registry**, it needs credentials
- Without an `imagePullSecret`, the pull fails silently at the pod level
- **Components involved:** `kubelet`, container runtime, private container registry, Kubernetes Secrets

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm deployment exists
kubectl get deployment <name>

# Step 2: Check pod status
kubectl get pods
# Pods may show: Pending, ImagePullBackOff, or ErrImagePull

# Step 3: Describe deployment — check events
kubectl describe deployment <deployment-name>
# Look for: "Failed to pull image" or "imagePullSecrets not found"

# Step 4: Describe individual pod for more details
kubectl describe pod <pod-name>
# Events: "Failed to pull image ... unauthorized: authentication required"

# Step 5: Create the imagePullSecret
kubectl create secret docker-registry <secret-name> \
  --docker-server=<registry-url> \
  --docker-username=<username> \
  --docker-password=<password> \
  --docker-email=<email>

# Step 6: Update deployment YAML to reference secret
# Add imagePullSecrets section

# Step 7: Reapply and verify
kubectl apply -f deployment.yaml
kubectl get pods -w
```

---

## 4️⃣ Fix / Resolution

```bash
# Step 1: Create secret
kubectl create secret docker-registry my-registry-creds \
  --docker-server=registry.company.com \
  --docker-username=deploy-user \
  --docker-password=SecurePassword123 \
  --docker-email=devops@company.com
```

```yaml
# Step 2: Reference in deployment.yaml
spec:
  imagePullSecrets:
  - name: my-registry-creds    # ✅ Must match secret name above
  containers:
  - name: app
    image: registry.company.com/myapp:v2.0
```

```bash
# Step 3: Apply and verify
kubectl apply -f deployment.yaml
kubectl get pods
# Should now show Running
```

---

## 5️⃣ Interview Answer Version

> *"When a deployment is created but pods don't start, I check `kubectl describe deployment` and `kubectl describe pod`. If I see 'image pull secret not found' or 'unauthorized', the deployment YAML is missing the imagePullSecret for a private registry. I create the secret using `kubectl create secret docker-registry`, add `imagePullSecrets` to the deployment spec, and redeploy."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** New microservice deployed to production. Deployment created. No pods running after 5 minutes.
>
> **Root cause:** Service was migrated to a new namespace. The docker-registry secret existed in the old namespace but not the new one.
>
> **Resolution:** Copied secret to new namespace:
> ```bash
> kubectl get secret my-registry-creds -n old-ns -o yaml | \
>   sed 's/namespace: old-ns/namespace: new-ns/' | \
>   kubectl apply -f -
> ```

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get deployment` | Check deployment exists |
| `kubectl describe deployment <name>` | See deployment events |
| `kubectl create secret docker-registry` | Create registry credentials |
| `kubectl get secret` | List available secrets |
| `kubectl patch deployment <name> -p '...'` | Patch deployment without full reapply |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Secrets are **namespace-scoped** — if you create a secret in `default`, it won't work in `production` namespace
- 🔍 You can attach imagePullSecrets to a **ServiceAccount** so all pods using that SA automatically get the credentials
- 🛡️ **Best practice:** Attach imagePullSecrets to the `default` ServiceAccount in each namespace so all pods can pull images without explicit spec changes
- 🛡️ For AWS ECR: use `amazon-ecr-credential-helper` or `ECR token refresher` (ECR tokens expire every 12 hours)

```bash
# Attach secret to ServiceAccount (applies to all pods in namespace)
kubectl patch serviceaccount default \
  -p '{"imagePullSecrets": [{"name": "my-registry-creds"}]}'
```

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: How often do ECR (AWS) pull tokens expire?**
> ECR authorization tokens expire every 12 hours. You need a token refresher mechanism (like `ecr-credential-helper` or a CronJob) to keep the imagePullSecret updated.

**Q: Can you use a single secret for multiple registries?**
> Yes — use a docker config secret with `.dockerconfigjson` that contains credentials for multiple registries.

---

## 🔟 Related Concepts to Revise
- Kubernetes Secrets (docker-registry type)
- imagePullSecrets in pod spec and ServiceAccount
- Private container registries (ECR, GCR, ACR, Harbor)
- ServiceAccounts and their secrets
- Namespace scoping of resources

---
---

# 🟡 Q10 — Init Container Skipped

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Pod created but init containers never run |
| **Where** | YAML structure — pod spec |
| **Symptom** | Init containers not listed in pod description, main container starts without init running |

> 🟢 **Beginner Explanation:** Init containers are like setup crew before a concert. If you accidentally put the setup crew backstage (inside the main container section in YAML) instead of the pre-show area (initContainers section), they never run.

---

## 2️⃣ Root Cause Explanation
- In Kubernetes YAML, `initContainers` and `containers` are **separate fields at the same level** under `spec`
- If `initContainers` is nested inside `containers` by mistake, Kubernetes ignores it silently (treats it as an unknown field or additional container config)
- **Components involved:** Kubernetes API validation, kubelet pod lifecycle management

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Describe pod — check init container status
kubectl describe pod <pod-name>
# If init containers ran: you see "Init Containers:" section with statuses
# If init containers skipped: Init Containers section is empty or absent

# Step 2: Check Events section
# If no init container events appear, they were never registered

# Step 3: Open YAML — check structure under spec
cat pod.yaml
# Look at where initContainers is defined
# WRONG: inside containers block
# CORRECT: at same level as containers, directly under spec

# Step 4: Fix the YAML structure (see below)

# Step 5: Reapply
kubectl delete pod <pod-name>
kubectl apply -f pod.yaml

# Step 6: Verify init containers run first
kubectl describe pod <pod-name>
# Should see Init Containers section with "Completed" status
```

---

## 4️⃣ Fix / Resolution

```yaml
# WRONG — initContainers nested inside containers ❌
spec:
  containers:
  - name: main-app
    image: myapp:v1
    initContainers:          # ❌ WRONG POSITION — inside containers!
    - name: init-db
      image: busybox
      command: ['sh', '-c', 'echo init done']
```

```yaml
# CORRECT — initContainers at same level as containers ✅
spec:
  initContainers:            # ✅ CORRECT — directly under spec
  - name: init-db
    image: busybox
    command: ['sh', '-c', 'until nc -z db-service 5432; do sleep 1; done']
  containers:                # ✅ Same level as initContainers
  - name: main-app
    image: myapp:v1
```

---

## 5️⃣ Interview Answer Version

> *"If init containers are skipped, the most common mistake is a YAML indentation error — `initContainers` placed inside the `containers` block instead of at the same level under `spec`. I use `kubectl describe pod` to check if init containers appear at all. If they don't appear, I open the YAML and verify the structure — `initContainers` must be a sibling of `containers` under `spec`, not nested inside it."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** DB migration init container was added to deployment. After deploy, migration never ran, app started against old schema, errors appeared.
>
> **Root cause:** YAML indentation error — `initContainers` was 2 extra spaces inside `containers`.
>
> **Resolution:** Fixed YAML, redeployed. Added YAML linting to CI pipeline to catch this.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl describe pod <name>` | See init containers section and status |
| `kubectl logs <pod> -c <init-container-name>` | Get init container logs |
| `kubectl get pod <name> -o yaml` | See full pod spec as Kubernetes parsed it |
| `kubectl explain pod.spec.initContainers` | Official field documentation |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Use `kubectl get pod -o yaml` to see how Kubernetes **actually parsed** your YAML — if initContainers section is missing there, your structure is wrong
- 🔍 Init containers run to completion in order — if any fails, subsequent ones and main container don't start
- 🛡️ Use `kubectl explain pod.spec` to see all valid fields and their correct nesting
- 🛡️ Common init container use cases: wait for DB, pre-populate volumes, run migrations, check configs

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What happens if one init container fails?**
> Kubernetes restarts the failed init container (based on restartPolicy). Subsequent init containers and the main container don't start until all init containers complete successfully.

**Q: Can init containers share volumes with main containers?**
> Yes — this is a primary use case. Init container writes data to a shared volume, main container reads it. Both must mount the same volume.

---

## 🔟 Related Concepts to Revise
- Init container lifecycle
- Pod spec structure (spec.initContainers vs spec.containers)
- Shared volumes between init and main containers
- YAML indentation rules
- kubectl explain command

---
---

# 🔴 Q11 — Init Container Failing — CrashLoopBackOff

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Init container keeps failing, preventing main container from starting |
| **Where** | Init container phase — pod startup |
| **Symptom** | Pod stuck in `Init:CrashLoopBackOff` or `Init:Error` state |

> 🟢 **Beginner Explanation:** The setup crew (init container) keeps failing at their job. Until they finish successfully, the main show (main container) cannot start.

---

## 2️⃣ Root Cause Explanation
- Init container runs a task (e.g., DB migration) that **fails repeatedly**
- Kubernetes retries it with backoff — but main container is completely blocked
- Common causes:
  - ❌ Database not ready when init container runs
  - ❌ Wrong DB credentials in init container script
  - ❌ Migration script has a bug
  - ❌ DB service name incorrect
- **Components involved:** `kubelet`, init container runtime, external service (DB)

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check pod status
kubectl get pods
# STATUS: Init:CrashLoopBackOff or Init:0/1

# Step 2: Describe pod — check init container events
kubectl describe pod <pod-name>
# Events show: "migrate-db failed with exit code 1"

# Step 3: Check INIT CONTAINER logs specifically
kubectl logs <pod-name> -c <init-container-name>
# e.g., kubectl logs myapp-pod -c init-db
# Look for: "could not connect to database: connection refused"

# Step 4: Verify DB service exists and is reachable
kubectl get svc
kubectl get pods -l app=postgres   # Check DB pods are running

# Step 5: Test DB connectivity from within cluster
kubectl run test-pod --rm -it --image=busybox -- sh
# Inside: nc -z postgres-service 5432 && echo "DB reachable"

# Step 6: Fix the issue (wrong credentials, DB not ready, script bug)

# Step 7: Delete old pod and redeploy
kubectl delete pod <pod-name>
kubectl apply -f deployment.yaml

# Step 8: Verify
kubectl get pods   # Should show Running
```

---

## 4️⃣ Fix / Resolution

**Fix 1: Add retry logic in init container script**
```yaml
spec:
  initContainers:
  - name: wait-for-db
    image: postgres:14
    command: ['sh', '-c',
      'until pg_isready -h postgres-service -p 5432; do
        echo "Waiting for database..."; sleep 3;
      done; echo "DB is ready"']
  - name: run-migrations
    image: myapp-migrations:v1
    env:
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: db-secret
          key: password    # ✅ Use secret for credentials
```

**Fix 2: Verify correct service name**
```bash
kubectl get svc -n <namespace>   # Find exact service name
# Make sure init container uses: postgres-service (not postgres or db)
```

---

## 5️⃣ Interview Answer Version

> *"Init container in CrashLoopBackOff means the init task keeps failing. I get the init container logs specifically with `kubectl logs <pod> -c <init-container-name>`. In one case, the DB migration script couldn't connect to the database. I checked `kubectl get svc` — service existed. The issue was the DB pod itself wasn't ready yet. Fix: split init containers into two — first one waits for DB readiness using `pg_isready`, second one runs migrations only after DB is confirmed ready."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** After cluster restart (maintenance window), apps don't come back up. Init containers all in CrashLoopBackOff.
>
> **Root cause:** Database pods take 2 minutes to initialize after cluster restart. Init containers (running migrations) start immediately and fail.
>
> **Resolution:** Added a dedicated "wait-for-db" init container using `pg_isready` before migration init container.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl logs <pod> -c <container>` | **KEY** — logs for specific container |
| `kubectl describe pod <name>` | Init container events and state |
| `kubectl get pod <name> -o yaml` | See full init container spec |
| `kubectl run test --rm -it --image=busybox -- sh` | Quick debug pod |
| `kubectl delete pod <name>` | Force pod recreation (for init re-run) |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `-c <container-name>` flag is essential when pod has multiple containers — without it, logs default to main container
- 🔍 After fixing init container, you must **delete the pod** for init containers to re-run (just updating deployment may not recreate pod)
- 🛡️ Pattern: Always have a separate "wait" init container before "action" init containers
- 🛡️ Use `pg_isready`, `redis-cli ping`, or `nc -z` for dependency checks

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: If I fix the init container script, do I need to delete the pod?**
> Yes — init containers only run on pod creation. Update the deployment YAML and roll it out, which creates new pods. Or delete the existing pod manually and let the deployment controller recreate it.

**Q: Can init containers share environment variables with main containers?**
> No — each container has its own environment. But they can share data via volumes. You can also reference the same ConfigMap/Secret in both.

---

## 🔟 Related Concepts to Revise
- Init container ordering and lifecycle
- `kubectl logs -c` for multi-container pods
- Service readiness patterns
- DB migration strategies in Kubernetes
- kubectl run for debugging

---
---

# 🟡 Q12 — Sidecar Pattern Logging Issue

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Sidecar container can't read logs from main container |
| **Where** | Shared volume between containers in same pod |
| **Symptom** | Pod in CrashLoopBackOff, sidecar reports "file not found" |

> 🟢 **Beginner Explanation:** Two roommates share a filing cabinet. One puts files in Drawer A, the other looks in Drawer B — the same cabinet but different drawers. The sidecar is looking at a different path than where logs are written.

---

## 2️⃣ Root Cause Explanation
- Sidecar pattern: main container writes logs → sidecar reads/ships them
- Both containers must mount the **same volume at the same path** for log sharing
- If `mountPath` differs between containers, they're accessing different directories on the same `emptyDir` volume
- **Components involved:** Pod volumes (`emptyDir`), container volume mounts, kubelet

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check pod status
kubectl get pods
# Two containers: main-app + log-sidecar
# STATUS: CrashLoopBackOff

# Step 2: Describe pod — see volume mounts
kubectl describe pod <pod-name>
# Look for: Mounts section for each container
# main-app: /var/log/app
# sidecar: /logs  ← DIFFERENT PATH — root cause!

# Step 3: Check sidecar logs for error
kubectl logs <pod-name> -c log-sidecar
# Error: "file /logs/app.log not found"
# (File is at /var/log/app/app.log but sidecar looks at /logs/app.log)

# Step 4: Fix YAML — make both mountPaths identical

# Step 5: Delete and reapply (volume mount changes need pod recreation)
kubectl delete pod <pod-name>
kubectl apply -f pod.yaml

# Step 6: Verify
kubectl logs <pod-name> -c log-sidecar
# Should now show logs from main container
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — Different mount paths ❌
spec:
  volumes:
  - name: shared-logs
    emptyDir: {}

  containers:
  - name: main-app
    image: myapp:v1
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/app    # ❌ Main app writes here

  - name: log-sidecar
    image: fluentd:v1
    volumeMounts:
    - name: shared-logs
      mountPath: /logs           # ❌ Sidecar reads here — DIFFERENT!
```

```yaml
# AFTER — Same mount path for both ✅
spec:
  volumes:
  - name: shared-logs
    emptyDir: {}

  containers:
  - name: main-app
    image: myapp:v1
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/app    # ✅ Both use same path

  - name: log-sidecar
    image: fluentd:v1
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/app    # ✅ Same path as main container
```

---

## 5️⃣ Interview Answer Version

> *"In a sidecar logging pattern, both containers must mount the shared volume at the same path. If the main container writes to `/var/log/app` but the sidecar reads from `/logs`, they're accessing different directories even though they share the same volume. I use `kubectl describe pod` to compare mountPaths for each container. The fix is to make both mountPaths identical, then redeploy."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Fluentd sidecar deployed alongside app for log shipping to Elasticsearch. Logs stop appearing in Kibana.
>
> **Root cause:** App was migrated and log path changed from `/app/logs` to `/var/log/app`, but Fluentd config still read from `/app/logs`.
>
> **Resolution:** Updated sidecar mountPath to match new app log path. Also updated Fluentd config.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl describe pod <name>` | See volume mount paths per container |
| `kubectl logs <pod> -c <container>` | Logs for specific container |
| `kubectl exec -it <pod> -c <container> -- ls /path` | Check if files exist in container |
| `kubectl get pod <name> -o yaml` | Full spec including volume mounts |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `emptyDir` volumes are tied to pod lifecycle — data is lost when pod is deleted
- 🔍 Use `kubectl exec -it <pod> -c main-app -- ls /var/log/app` to verify log files exist
- 🛡️ **Named volume best practice:** Give volumes descriptive names like `app-logs-volume` to make YAML intent clear
- 🛡️ Production alternative: Use a DaemonSet log collector (like Fluentd/Filebeat) rather than sidecar pattern for lower overhead

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the sidecar pattern?**
> A secondary container (sidecar) runs alongside the main container in the same pod, sharing the same network and volumes. Common use cases: log collection, metrics scraping, proxy (Istio Envoy), config refresh.

**Q: What types of volumes allow sharing between containers?**
> `emptyDir` — temporary, cleared when pod dies. `hostPath` — maps to node filesystem. `PVC` — persistent. `configMap`/`secret` — read-only config injection.

---

## 🔟 Related Concepts to Revise
- Multi-container pod patterns (sidecar, ambassador, adapter)
- Kubernetes volumes (emptyDir, hostPath, PVC)
- Volume mounts and paths
- Fluentd/Filebeat for log collection
- DaemonSet vs sidecar for logging

---
---

# 🟡 Q13 — Pod Affinity Causing Latency

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Two related pods are scheduled on different nodes, causing network latency |
| **Where** | Scheduling — node placement |
| **Symptom** | Slow response time, cross-node network calls between tightly coupled pods |

> 🟢 **Beginner Explanation:** You want your office and your conference room on the same floor but the building manager put them on different floors. Every meeting requires an elevator trip — that's the latency.

---

## 2️⃣ Root Cause Explanation
- Pod affinity `preferredDuringSchedulingIgnoredDuringExecution` is a **soft rule** — Kubernetes tries but doesn't guarantee same node
- If the preferred node is full, Kubernetes schedules on any available node
- This results in cross-node traffic for pods that need low latency communication
- **Components involved:** `kube-scheduler`, node affinity rules, node resource availability

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check pod placement — which pods are on which nodes
kubectl get pods -n ml-training -o wide
# pre-processing: node-A
# training: node-B  ← Different nodes!

# Step 2: Check affinity configuration
kubectl get pod <training-pod> -o yaml | grep -A20 affinity
# You see: preferredDuringSchedulingIgnoredDuringExecution
# This is a SOFT rule — explains why it went to node-B

# Step 3: Check why it didn't go to node-A
kubectl describe node node-A
# Check: Allocated resources vs Capacity
# node-A may be fully utilized (no room for training pod)

# Step 4: Decide: change to required (hard) or scale up node-A

# Step 5: Update affinity rule to required
kubectl apply -f updated-deployment.yaml

# Step 6: Verify pods are now co-located
kubectl get pods -o wide   # Both should show same node
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — Soft affinity (preferred) — may not co-locate ❌
spec:
  affinity:
    podAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:   # Soft rule
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              app: pre-processing
          topologyKey: kubernetes.io/hostname
```

```yaml
# AFTER — Hard affinity (required) — forces co-location ✅
spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:    # Hard rule
      - labelSelector:
          matchLabels:
            app: pre-processing
        topologyKey: kubernetes.io/hostname
```

> ⚠️ **Warning:** Using `required` means if the target node is full, the pod won't schedule at all (goes Pending). Ensure the node has capacity before switching to required.

---

## 5️⃣ Interview Answer Version

> *"Pod affinity with `preferred` is a soft rule — Kubernetes tries to co-locate but falls back to other nodes when resources are tight. For latency-sensitive workloads, I change it to `required` (hard affinity) so both pods must be on the same node. Before doing that, I verify node-A has enough capacity using `kubectl describe node`. If not, I scale up the node first, then apply the required affinity rule."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** ML training job latency increased from 50ms to 200ms after cluster scale-up added more nodes.
>
> **Root cause:** New node-B had more free capacity, scheduler placed training pods there. Pre-processing stayed on node-A. Soft affinity allowed this.
>
> **Resolution:** Changed to required affinity. Also added node resource buffer policy.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get pods -o wide` | See pod-to-node assignment |
| `kubectl get pods -n <ns> -o wide` | Namespace-specific pod placement |
| `kubectl describe node <name>` | Node capacity and current allocation |
| `kubectl top node` | Real-time node resource usage |
| `kubectl get pod <name> -o yaml \| grep -A20 affinity` | Check affinity config |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `preferred` = best effort, `required` = hard constraint. Know when to use each.
- 🔍 `topologyKey: kubernetes.io/hostname` = same node. `topologyKey: topology.kubernetes.io/zone` = same AZ
- 🛡️ For latency-sensitive apps, use `required` + `podAntiAffinity` on the DB to avoid DB and app on same node
- 🛡️ Consider using **topology spread constraints** for more balanced scheduling

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between Pod Affinity and Node Affinity?**
> `nodeAffinity` — schedule pod based on node labels/properties. `podAffinity` — schedule pod near/away from other pods based on pod labels.

**Q: What is podAntiAffinity?**
> Opposite of podAffinity — ensures pods are scheduled on different nodes. Used for HA: ensures replicas of the same app don't all end up on one node.

---

## 🔟 Related Concepts to Revise
- Pod Affinity and Anti-Affinity
- Node Affinity
- Topology Spread Constraints
- Taints and Tolerations
- kube-scheduler scoring algorithm

---
---

# 🔴 Q14 — Pod Not Receiving IP — CNI Issue

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Pod created but has no IP address assigned |
| **Where** | Network layer — CNI plugin |
| **Symptom** | `kubectl get pods -o wide` shows `<none>` for IP column |

> 🟢 **Beginner Explanation:** Every pod needs a phone number (IP address) to receive calls. The phone company (CNI plugin like Calico/Flannel) that assigns numbers is broken — so the pod gets no number and can't communicate.

---

## 2️⃣ Root Cause Explanation
- CNI (Container Network Interface) plugin is responsible for assigning IPs to pods
- If the CNI pod (Calico, Flannel, Weave) on that node crashes or is misconfigured, new pods on that node get no IP
- The pod's network namespace can't be configured without a working CNI
- **Components involved:** CNI plugin (DaemonSet pods), `kubelet`, Linux network namespaces

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check pod — notice no IP
kubectl get pods -o wide
# IP column shows: <none> for the affected pod

# Step 2: Describe pod — check network events
kubectl describe pod <pod-name>
# Events: "network setup failed" or "failed to setup network for pod"

# Step 3: Check CNI pods (Calico example)
kubectl get pods -n kube-system | grep calico
# OR for Flannel:
kubectl get pods -n kube-system | grep flannel
# Look for any pods in CrashLoopBackOff or Error state

# Step 4: Check CNI pod logs for errors
kubectl logs <calico-pod-name> -n kube-system

# Step 5: Restart the failing CNI pod
kubectl delete pod <failing-cni-pod> -n kube-system
# DaemonSet automatically recreates it

# Step 6: Wait for CNI pod to be Running, then restart affected app pod
kubectl delete pod <app-pod-name>
# Deployment recreates it — this time with CNI working → IP assigned

# Step 7: Verify
kubectl get pods -o wide
# IP should now show a valid IP address
```

---

## 4️⃣ Fix / Resolution

```bash
# Restart failing CNI pod (safe — DaemonSet recreates it)
kubectl delete pod calico-node-xxxxx -n kube-system

# Verify CNI is healthy
kubectl get pods -n kube-system | grep calico
# All should show Running

# Recreate app pod to trigger IP assignment
kubectl rollout restart deployment/<app-name>

# Verify IP assigned
kubectl get pods -o wide
# IP: 10.244.x.x  ← Valid IP now assigned
```

---

## 5️⃣ Interview Answer Version

> *"If a pod shows `<none>` for IP, the CNI plugin on that node failed to assign an IP. I check `kubectl describe pod` for network setup errors, then check CNI pods in kube-system namespace for any CrashLoopBackOff. Restarting the failing CNI pod (safe since CNI runs as a DaemonSet, it auto-recreates) fixes the IP assignment. I then delete the app pod to force it to get an IP with the now-healthy CNI."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** New pods scheduled after node maintenance have no IPs. Existing pods work fine.
>
> **Root cause:** Node reboot caused Calico pod to fail — it crashed due to an old config file conflict.
>
> **Resolution:** Deleted the failing Calico pod. It restarted cleanly. New app pods then received IPs.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get pods -o wide` | See IP assignments |
| `kubectl describe pod <name>` | Network setup error events |
| `kubectl get pods -n kube-system` | Check CNI pods health |
| `kubectl logs <cni-pod> -n kube-system` | CNI plugin logs |
| `kubectl delete pod <cni-pod> -n kube-system` | Restart CNI pod (DaemonSet recreates) |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 CNI plugins run as DaemonSets — one pod per node. If CNI fails on one node, only pods on that node lose IP assignment
- 🔍 Check `/etc/cni/net.d/` on the node itself for CNI config files
- 🛡️ Monitor CNI pod health in Prometheus/Grafana as a critical system alert
- 🛡️ Common CNI plugins: Calico, Flannel, Weave, Cilium — each has its own troubleshooting commands

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is a CNI plugin?**
> CNI (Container Network Interface) is a standard for configuring container networking. Kubernetes uses CNI plugins (Calico, Flannel, Cilium) to assign IP addresses to pods and manage pod-to-pod networking.

**Q: What is a DaemonSet?**
> A DaemonSet ensures one pod runs on every node in the cluster. Used for infrastructure components like log collectors (Fluentd), monitoring agents (node-exporter), and CNI plugins (Calico).

---

## 🔟 Related Concepts to Revise
- CNI plugins (Calico, Flannel, Cilium, Weave)
- Kubernetes networking model
- DaemonSets
- kube-system namespace
- Pod networking and IP assignment

---
---

# 🟡 Q15 — ReplicaSet Not Creating Pods

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | ReplicaSet created but shows 0 current pods despite desired > 0 |
| **Where** | ReplicaSet controller — pod creation phase |
| **Symptom** | `kubectl get rs` shows DESIRED=3, CURRENT=0, READY=0 |

> 🟢 **Beginner Explanation:** The ReplicaSet (factory manager) wants to hire 3 workers (pods) but requires an ID badge (ServiceAccount) that doesn't exist yet — so no one gets hired.

---

## 2️⃣ Root Cause Explanation
- ReplicaSet tries to create pods based on its pod template
- If the pod template references a **ServiceAccount that doesn't exist**, pod creation fails
- No error is obvious at the ReplicaSet level — you must look at events
- **Components involved:** ReplicaSet controller, `kube-apiserver`, ServiceAccount admission controller

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check ReplicaSet status
kubectl get rs
# DESIRED: 3   CURRENT: 0   READY: 0 ← Problem

# Step 2: Describe ReplicaSet — look at events
kubectl describe rs <replicaset-name>
# Events: "failed to create pod: serviceaccount frontend-sa not found"

# Step 3: Check pod template in ReplicaSet YAML
kubectl get rs <name> -o yaml | grep serviceAccountName
# serviceAccountName: frontend-sa

# Step 4: Verify ServiceAccount exists
kubectl get serviceaccount -n <namespace>
# frontend-sa NOT listed → That's the root cause!

# Step 5: Create the missing ServiceAccount
kubectl create serviceaccount frontend-sa -n <namespace>

# Step 6: ReplicaSet controller automatically retries pod creation
# Watch pods get created
kubectl get pods -w
```

---

## 4️⃣ Fix / Resolution

```bash
# Create missing ServiceAccount
kubectl create serviceaccount frontend-sa -n web-app

# Verify ServiceAccount created
kubectl get sa -n web-app
# NAME          SECRETS   AGE
# frontend-sa   1         5s  ← Created

# ReplicaSet now creates pods automatically
kubectl get pods
# NAME                    READY   STATUS    RESTARTS
# frontend-xxxxx-aaaa    1/1     Running   0   ← Pods created!
```

```yaml
# Or create ServiceAccount via YAML for GitOps
apiVersion: v1
kind: ServiceAccount
metadata:
  name: frontend-sa
  namespace: web-app
```

---

## 5️⃣ Interview Answer Version

> *"When a ReplicaSet shows 0 current pods despite a desired count, I describe it to find the root cause in events. A common cause is a missing ServiceAccount referenced in the pod template. The ReplicaSet controller can't create pods without it. I verify with `kubectl get serviceaccount`, create the missing one with `kubectl create serviceaccount`, and the ReplicaSet automatically starts creating pods."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** New feature team creates a namespace and copies a deployment. ReplicaSet shows 0 pods.
>
> **Root cause:** ServiceAccount `frontend-sa` existed in the original namespace but was not created in the new namespace (resources are namespace-scoped).
>
> **Resolution:** Added ServiceAccount creation to their namespace setup Terraform/Helm templates.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get rs` | Check ReplicaSet desired vs current |
| `kubectl describe rs <name>` | Events showing why pod creation failed |
| `kubectl get sa -n <namespace>` | List ServiceAccounts in namespace |
| `kubectl create serviceaccount <name> -n <ns>` | Create missing ServiceAccount |
| `kubectl get pods -w` | Watch pods get created after fix |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Always check `kubectl describe rs` events — not just pod events
- 🔍 ServiceAccounts are namespace-scoped — copying YAMLs across namespaces often misses this
- 🛡️ Use Helm charts or Kustomize to bundle all required resources (ServiceAccount, RBAC, Deployment) together
- 🛡️ Use `kubectl auth can-i` to verify RBAC permissions for a ServiceAccount

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is a ServiceAccount in Kubernetes?**
> A ServiceAccount provides an identity for processes running in a pod. It's used for API server authentication, RBAC authorization, and accessing cluster resources. Every pod uses a ServiceAccount (default if not specified).

**Q: What is the difference between a ServiceAccount and a user account?**
> ServiceAccounts are for pods/processes (machine identities). User accounts are for human operators. ServiceAccounts are namespace-scoped; user accounts are cluster-scoped.

---

## 🔟 Related Concepts to Revise
- ServiceAccounts
- RBAC (Role, ClusterRole, RoleBinding)
- ReplicaSet vs Deployment
- Namespace resource scoping
- Pod identity and API access

---
---

# 🟡 Q16 — Deployment Rollback Not Working

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | `kubectl rollout undo` fails — no previous revision to roll back to |
| **Where** | Deployment — revision history |
| **Symptom** | Error: "no rollout history found" or rollback fails silently |

> 🟢 **Beginner Explanation:** Rollback is like an undo button. If someone set the undo history to 0 (no history saved), pressing undo does nothing — there's nothing to go back to.

---

## 2️⃣ Root Cause Explanation
- Kubernetes Deployments keep history of old ReplicaSets for rollback purposes
- `revisionHistoryLimit` controls how many old ReplicaSets to keep
- If set to `0`, **all old ReplicaSets are deleted** → no rollback possible
- Default value is 10 (keep last 10 revisions)
- **Components involved:** Deployment controller, ReplicaSets

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Attempt rollback — see the error
kubectl rollout undo deployment/<name>
# Error: no rollout history found

# Step 2: Check rollout history
kubectl rollout history deployment/<name>
# Only shows current revision — no previous ones

# Step 3: Check revisionHistoryLimit
kubectl get deployment <name> -o yaml | grep revisionHistoryLimit
# revisionHistoryLimit: 0  ← Root cause!

# Step 4: Check available ReplicaSets (there should be old ones for rollback)
kubectl get rs
# Only one RS exists — old ones were deleted due to limit=0

# Step 5: Manual rollback — since no history exists, update image directly
kubectl set image deployment/<name> <container>=<old-image>:<old-tag>
# e.g., kubectl set image deployment/api api=myapp:v1.0

# Step 6: Verify rollout
kubectl rollout status deployment/<name>

# Step 7: Fix revisionHistoryLimit for future rollbacks
kubectl patch deployment <name> -p '{"spec":{"revisionHistoryLimit": 10}}'
```

---

## 4️⃣ Fix / Resolution

```yaml
# Fix revisionHistoryLimit in deployment YAML
spec:
  revisionHistoryLimit: 10    # ✅ Keep last 10 versions for rollback
  # Was: revisionHistoryLimit: 0  ← This was the problem
  replicas: 3
  selector: ...
```

```bash
# Manual rollback when no history exists
kubectl set image deployment/my-app my-container=myapp:v1.0.0

# Normal rollback (when history exists)
kubectl rollout undo deployment/my-app                  # Roll back one version
kubectl rollout undo deployment/my-app --to-revision=3  # Roll back to specific version

# View history
kubectl rollout history deployment/my-app
kubectl rollout history deployment/my-app --revision=2  # Details of revision 2
```

---

## 5️⃣ Interview Answer Version

> *"Rollback fails when `revisionHistoryLimit` is set to 0 — Kubernetes deletes old ReplicaSets immediately, leaving nothing to roll back to. I check this with `kubectl get deployment -o yaml | grep revisionHistoryLimit`. As an immediate fix, I manually revert the image tag with `kubectl set image`. Long-term, I update `revisionHistoryLimit` to 10 in the deployment spec so future rollbacks work correctly."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Production hotfix deployment goes wrong. Team tries `kubectl rollout undo` — it fails.
>
> **Root cause:** DevOps lead had set `revisionHistoryLimit: 0` to "save etcd space" without realizing it disabled rollbacks.
>
> **Resolution:** Manual rollback using `kubectl set image`. Updated company-wide Helm chart defaults to `revisionHistoryLimit: 10`. Added runbook for manual rollback procedure.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl rollout history deployment/<name>` | View all revisions |
| `kubectl rollout undo deployment/<name>` | Rollback to previous version |
| `kubectl rollout undo deployment/<name> --to-revision=N` | Rollback to specific revision |
| `kubectl set image deployment/<name> <c>=<image>:<tag>` | Manually update image |
| `kubectl rollout status deployment/<name>` | Watch rollout progress |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `kubectl rollout history deployment/<name> --revision=N` shows the exact YAML and change-cause for that revision
- 🔍 Add `--record` flag when applying changes to track change causes in history (deprecated in newer versions — use annotations instead)
- 🛡️ Standard recommendation: `revisionHistoryLimit: 10` for production
- 🛡️ Annotate deployments with change reason: `kubectl annotate deployment/<name> kubernetes.io/change-cause="upgraded to v2.1"`

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What does revisionHistoryLimit do exactly?**
> It controls how many old ReplicaSets Kubernetes retains after updates. Each deployment update creates a new RS and keeps the old one (up to the limit). These old RSes are what makes rollback possible.

**Q: How do you roll back to a specific version (not just the previous one)?**
> `kubectl rollout undo deployment/<name> --to-revision=<N>` where N comes from `kubectl rollout history`.

---

## 🔟 Related Concepts to Revise
- Deployment rollout strategy
- ReplicaSet revision history
- `revisionHistoryLimit`
- kubectl rollout commands
- GitOps rollback strategies (ArgoCD sync)

---
---

# 🟡 Q17 — Paused Deployment Stuck

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Deployment rollout is stuck and doesn't complete even after resuming |
| **Where** | Deployment controller — rollout phase |
| **Symptom** | `kubectl rollout status` shows "Waiting for deployment to rollout" indefinitely |

> 🟢 **Beginner Explanation:** Like a train that was stopped at a station for maintenance. Even after the "all clear" signal, the train won't move because there's a broken switch further down the track (old ReplicaSet not scaling down).

---

## 2️⃣ Root Cause Explanation
- Deployment was paused (`kubectl rollout pause`), then resumed, but rollout still stuck
- Actual cause: `progressDeadlineExceeded` — rollout timed out during the pause period
- Old ReplicaSet is not fully scaled down, new one not fully scaled up
- **Components involved:** Deployment controller, old and new ReplicaSets, `progressDeadlineSeconds`

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check deployment status
kubectl rollout status deployment/<name>
# Output: "Waiting for deployment rollout to finish: 1 out of 3 new replicas have been updated"

# Step 2: Describe deployment for details
kubectl describe deployment <name>
# Look for: "ProgressDeadlineExceeded"
# Condition: "ReplicaSet not fully scaled down" or "progress deadline exceeded"

# Step 3: Check ReplicaSets — look for imbalance
kubectl get rs
# Old RS: DESIRED=2  CURRENT=2  READY=2 (not scaled down)
# New RS: DESIRED=3  CURRENT=1  READY=1 (not complete)

# Step 4: Force a fresh rollout — restart the deployment
kubectl rollout restart deployment/<name>
# This creates a brand new rollout, forcing Kubernetes to reconcile state

# Step 5: Watch rollout complete
kubectl rollout status deployment/<name>
# Eventually: "deployment successfully rolled out"
```

---

## 4️⃣ Fix / Resolution

```bash
# Force restart to unstick the rollout
kubectl rollout restart deployment/<name>

# Verify completion
kubectl rollout status deployment/<name>
# "successfully rolled out"

# Check all pods are running new version
kubectl get pods
kubectl describe pod <new-pod> | grep Image
```

```yaml
# Prevent future deadline exceeded — increase progressDeadlineSeconds
spec:
  progressDeadlineSeconds: 600   # 10 minutes (default is 600s)
  # If deployment is paused for long periods, increase this
```

---

## 5️⃣ Interview Answer Version

> *"A deployment stuck after resume usually indicates `progressDeadlineExceeded` — the rollout timed out during the pause. I verify with `kubectl describe deployment` — I look for the 'ProgressDeadlineExceeded' condition and confirm old ReplicaSet isn't scaling down. The fix is `kubectl rollout restart deployment/<name>` which forces a fresh rollout and resolves the stuck state."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Team paused deployment for a Friday freeze. Resumed on Monday. Deployment stuck.
>
> **Root cause:** `progressDeadlineSeconds: 600` (10 min default). Deployment was paused for 3 days. Timer had long exceeded.
>
> **Resolution:** Increased `progressDeadlineSeconds` in the Helm chart. Added a note to never pause production deployments — use GitOps branch freeze instead.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl rollout pause deployment/<name>` | Pause rollout |
| `kubectl rollout resume deployment/<name>` | Resume rollout |
| `kubectl rollout restart deployment/<name>` | Force fresh rollout |
| `kubectl rollout status deployment/<name>` | Watch rollout progress |
| `kubectl describe deployment <name>` | See conditions and deadline exceeded |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `kubectl describe deployment` Conditions section is key — look for `Progressing` and `Available` conditions
- 🔍 `progressDeadlineSeconds` default is 600 seconds — if your deployment takes longer (e.g., slow image pull), increase this
- 🛡️ Avoid pausing production deployments for extended periods — use feature flags or GitOps instead
- 🛡️ Set up monitoring for deployments stuck in "Progressing" state for > N minutes

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: When would you use `kubectl rollout pause`?**
> When you want to gradually update a deployment and check health between steps — like a manual canary. Pause, verify a few pods, then resume. But use proper canary deployment strategies for production.

**Q: What is `progressDeadlineSeconds`?**
> The time Kubernetes waits for a deployment to make progress before marking it as failed with `ProgressDeadlineExceeded`. Default is 600 seconds (10 minutes).

---

## 🔟 Related Concepts to Revise
- Deployment rollout strategy
- `progressDeadlineSeconds`
- ReplicaSet scaling during rollout
- maxUnavailable and maxSurge
- kubectl rollout commands

---
---

# 🟡 Q18 — Blue-Green Traffic Routed to Old Pods

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Blue-green deployment done, but traffic still hits old (blue) pods |
| **Where** | Service selector — traffic routing |
| **Symptom** | New (green) pods are Running but receive no traffic |

> 🟢 **Beginner Explanation:** You opened a new restaurant (green) but the road signs (service selector) still point customers to the old restaurant (blue). Updating the sign is the fix.

---

## 2️⃣ Root Cause Explanation
- In Kubernetes blue-green deployments, a **Service selector** determines which pods receive traffic
- After deploying the green version, the service selector must be **manually updated** to point to green pods
- Forgetting this step means the service still routes to blue pods
- **Components involved:** Kubernetes Service, label selectors, Endpoints controller

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check service selector
kubectl get svc <service-name> -o yaml | grep -A5 selector
# selector:
#   environment: blue   ← Still pointing to blue!

# Step 2: Check green pods exist and are Running
kubectl get pods -l environment=green
# Green pods: Running ✅

# Step 3: Check service endpoints — are green pods listed?
kubectl get endpoints <service-name>
# Shows blue pod IPs — not green

# Step 4: Update service selector to green
kubectl patch service <service-name> -p '{"spec":{"selector":{"environment":"green"}}}'

# Step 5: Verify endpoints updated
kubectl get endpoints <service-name>
# Now shows green pod IPs ✅

# Step 6: Test the application — confirm green version is serving
curl http://<service-ip>/version
# Should return v2 (green version)
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — Service pointing to blue
spec:
  selector:
    app: web
    environment: blue     # ❌ Still blue

# AFTER — Service pointing to green
spec:
  selector:
    app: web
    environment: green    # ✅ Updated to green
```

```bash
# Apply the update
kubectl apply -f service.yaml
# OR patch directly
kubectl patch svc my-service -p '{"spec":{"selector":{"environment":"green"}}}'

# Verify
kubectl describe svc my-service | grep Selector
# Selector: app=web, environment=green ✅
```

---

## 5️⃣ Interview Answer Version

> *"In blue-green deployments, traffic routing is controlled by the Service selector. After deploying green pods, if the selector still points to `environment: blue`, traffic stays on old pods. I check with `kubectl get svc -o yaml` to see the selector, verify green pods exist and are healthy, then update the selector to `environment: green`. I confirm the change worked by checking `kubectl get endpoints` — it should now show green pod IPs."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Team deploys v2 (green) successfully. Users still report old behavior.
>
> **Root cause:** Automation script deployed the green deployment but forgot to run the service selector update step.
>
> **Resolution:** Updated the deployment script to always patch the service selector after green pods become healthy. Added a post-deploy smoke test that checks which version is serving.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get svc -o yaml` | Full service spec including selector |
| `kubectl get endpoints <name>` | See which pod IPs are currently targeted |
| `kubectl patch svc <name> -p '{...}'` | Update selector without full YAML edit |
| `kubectl get pods -l <label>=<value>` | List pods by label |
| `kubectl describe svc <name>` | Service details including selector and endpoints |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `kubectl get endpoints` is the quickest way to verify which pods are actually receiving traffic
- 🔍 Labels on pods must **exactly match** the service selector — even one mismatch = no traffic
- 🛡️ Automate the selector switch in your CI/CD pipeline post-deployment health check
- 🛡️ Use Argo Rollouts or Flagger for automated blue-green with built-in traffic switching

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between blue-green and canary deployment?**
> Blue-green: Run two full environments, switch 100% traffic instantly. Zero downtime, easy rollback. Canary: Gradually shift traffic (e.g., 5% → 20% → 50% → 100%) to the new version while monitoring.

**Q: How do you verify traffic is going to the correct pods?**
> Check `kubectl get endpoints <service>` — it shows pod IPs. Cross-reference with `kubectl get pods -o wide` to confirm those IPs match the intended pods.

---

## 🔟 Related Concepts to Revise
- Kubernetes Services and label selectors
- Endpoints and EndpointSlices
- Blue-Green deployment pattern
- Canary deployment pattern
- Argo Rollouts, Flagger for advanced deployments

---
---

# 🟡 Q19 — Canary Pods Receiving All Traffic

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Canary pods receive 100% traffic instead of the intended small percentage |
| **Where** | ReplicaSet replica count configuration |
| **Symptom** | Canary pods overwhelmed; stable deployment receives no traffic |

> 🟢 **Beginner Explanation:** You wanted 1 canary waiter (20% of 5 staff) and 4 regular waiters (80%). But someone wrote the schedule with 5 canary waiters and 0 regular — now 100% of customers are served by canaries.

---

## 2️⃣ Root Cause Explanation
- Kubernetes native canary works by **replica ratio** — if you have 1 canary pod and 4 stable pods, ~20% traffic goes to canary
- If canary deployment has 5 replicas and stable has 0, ALL traffic goes to canary (5/5 = 100%)
- This is a YAML misconfiguration — replica counts in canary/stable deployments are wrong
- **Components involved:** Deployment controller, ReplicaSets, Service load balancing (kube-proxy)

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check replica counts
kubectl get deployment
# canary-deployment:  READY 5/5   ← Should be 1!
# stable-deployment:  READY 0/0   ← Should be 4!

# Step 2: Identify YAML misconfiguration
kubectl get deployment canary-deployment -o yaml | grep replicas
# replicas: 5  ← Wrong, should be 1

kubectl get deployment stable-deployment -o yaml | grep replicas
# replicas: 0  ← Wrong, should be 4

# Step 3: Fix canary deployment YAML — set replicas to 1
kubectl scale deployment canary-deployment --replicas=1

# Step 4: Fix stable deployment YAML — set replicas to 4
kubectl scale deployment stable-deployment --replicas=4

# Step 5: Verify distribution
kubectl get pods
# 1 canary pod + 4 stable pods = 20% canary, 80% stable ✅

# Step 6: Confirm via endpoints
kubectl get endpoints <service-name>
# Should show 5 IPs: 1 canary + 4 stable
```

---

## 4️⃣ Fix / Resolution

```yaml
# canary-deployment.yaml — CORRECTED
spec:
  replicas: 1    # ✅ 1 out of 5 total = 20% canary traffic
```

```yaml
# stable-deployment.yaml — CORRECTED
spec:
  replicas: 4    # ✅ 4 out of 5 total = 80% stable traffic
```

```bash
kubectl apply -f canary-deployment.yaml
kubectl apply -f stable-deployment.yaml

# Verify
kubectl get pods -l app=myapp
# 1 pod with version: canary
# 4 pods with version: stable
```

---

## 5️⃣ Interview Answer Version

> *"In a Kubernetes native canary deployment, traffic split is based on replica counts. If canary has 5 replicas and stable has 0, canary gets 100% of traffic. I check `kubectl get deployment` to see replica counts, identify the misconfiguration, correct the replicas to 1 (canary) and 4 (stable), and reapply. This gives a 20/80 split. For more precise traffic control, I'd recommend Istio or Argo Rollouts."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Canary deployment of new checkout flow. All users hit new code. Some report broken checkout.
>
> **Root cause:** Copy-paste error — canary replicas set to 5, stable set to 0.
>
> **Resolution:** Immediately scaled stable to 4, canary to 1. Only 20% users on canary. Monitored error rates. Fixed bug, then gradually increased canary replicas.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get deployment` | Check all deployment replica counts |
| `kubectl scale deployment <name> --replicas=N` | Quickly adjust replica count |
| `kubectl get pods -l <label>` | List pods by deployment label |
| `kubectl get endpoints <svc>` | See all pod IPs in service |
| `kubectl apply -f deployment.yaml` | Apply corrected YAML |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Kubernetes native canary = replica ratio trick. For 10% canary: 1 canary + 9 stable pods
- 🔍 This approach only works if both deployments share the same service selector label
- 🛡️ For precise traffic percentage control (e.g., exactly 5%), use **Istio VirtualService** or **Argo Rollouts** — they control traffic at the load balancer level, not replica count
- 🛡️ Always have a documented rollback plan before any canary: scale canary to 0, stable back to N

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: How do you achieve exact traffic percentage in canary without Istio?**
> You can't achieve exact percentages with vanilla Kubernetes — it's approximate based on replica ratios. For exact control, use a service mesh (Istio) or Argo Rollouts which control traffic at the proxy/LB level.

**Q: What metrics do you monitor during a canary deployment?**
> Error rate (5xx responses), latency (p99), CPU/memory usage, business metrics (conversion rate, transaction success). Use Prometheus + Grafana dashboards.

---

## 🔟 Related Concepts to Revise
- Canary deployment pattern
- Kubernetes Service load balancing (random/round-robin)
- Argo Rollouts for advanced canary
- Istio traffic splitting with VirtualService
- Progressive delivery concepts

---
---

# 🟡 Q20 — Image Update Ignored — No Rollout Triggered

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Updated image tag in deployment YAML but Kubernetes didn't rollout new pods |
| **Where** | Deployment — image pull policy |
| **Symptom** | Old pods continue running, no rollout triggered, no new pods created |

> 🟢 **Beginner Explanation:** You changed the recipe (image tag in YAML) but the kitchen (Kubernetes) is using a cached version and doesn't bother fetching the new one because the label on the box didn't change.

---

## 2️⃣ Root Cause Explanation
- `imagePullPolicy: IfNotPresent` means Kubernetes only pulls the image if **not already cached on the node**
- If you update an image but reuse the **same tag** (especially `latest`), Kubernetes sees the tag is already present locally and skips the pull
- No new image → no change detected → no rollout
- **Components involved:** `kubelet`, container runtime image cache, `imagePullPolicy`

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check deployment status
kubectl rollout status deployment/<name>
# "deployment has successfully rolled out" ← but using OLD image!

# Step 2: Verify current image in running pods
kubectl describe pod <pod-name> | grep Image
# Image: myapp:v2  ← Tag says v2 but might be cached old v2!

# Step 3: Check imagePullPolicy
kubectl get deployment <name> -o yaml | grep imagePullPolicy
# imagePullPolicy: IfNotPresent  ← Root cause!

# Step 4: Fix — change imagePullPolicy to Always
# Edit deployment.yaml and change to Always

# Step 5: OR force rollout to pull fresh image
kubectl rollout restart deployment/<name>

# Step 6: Apply and verify
kubectl apply -f deployment.yaml
kubectl rollout status deployment/<name>
# New pods created, pulling fresh image
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — IfNotPresent (caches image, ignores updates for same tag)
spec:
  containers:
  - name: app
    image: myapp:v2
    imagePullPolicy: IfNotPresent   # ❌ Won't pull if tag already cached
```

```yaml
# AFTER — Always (always pulls from registry)
spec:
  containers:
  - name: app
    image: myapp:v2
    imagePullPolicy: Always          # ✅ Always pulls fresh image
```

```bash
# Apply and trigger rollout
kubectl apply -f deployment.yaml
kubectl rollout restart deployment/<name>   # Force pod recreation
kubectl rollout status deployment/<name>
```

---

## 5️⃣ Interview Answer Version

> *"If an image update doesn't trigger a rollout, it's usually because `imagePullPolicy` is set to `IfNotPresent` — Kubernetes uses the cached image on the node. I verify this with `kubectl get deployment -o yaml | grep imagePullPolicy`. The fix is changing it to `Always`, which forces a fresh pull on every pod start. Best practice: always use unique, immutable image tags (like Git commit SHA) and `IfNotPresent` — never reuse tags."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** CI/CD pushes new code. Deployment YAML updated with `latest` tag. Kubernetes doesn't rollout new version.
>
> **Root cause:** `imagePullPolicy: IfNotPresent` + reusing `latest` tag. Node already had `latest` cached.
>
> **Resolution:** Switched to using Git commit SHA as image tag (`myapp:abc1234`). Each deploy always has a new tag, guaranteeing rollout. `imagePullPolicy` can stay `IfNotPresent` since tags are always unique.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get deployment <name> -o yaml` | Check imagePullPolicy |
| `kubectl describe pod <name>` | See actual image being used |
| `kubectl rollout restart deployment/<name>` | Force pod recreation/image pull |
| `kubectl set image deployment/<name> <c>=<image>:<tag>` | Update image and trigger rollout |
| `kubectl rollout status deployment/<name>` | Monitor rollout progress |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 **Golden rule:** Never use `latest` tag in production. Use immutable tags (Git SHA, build number, semantic version)
- 🔍 `imagePullPolicy` defaults: `latest` tag → `Always`. All other tags → `IfNotPresent`
- 🛡️ CI/CD best practice: Tag images with `<name>:<git-sha>` — every build has a unique, traceable tag
- 🛡️ `imagePullPolicy: Always` adds latency to pod startup — balance with unique tagging strategy

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What are the three imagePullPolicy options?**
> `Always` — always pull from registry. `IfNotPresent` — pull only if not in local cache. `Never` — never pull, use only cached image (used in air-gapped environments).

**Q: Why is using `latest` tag in production a bad practice?**
> `latest` is mutable — different pushes overwrite it. You lose traceability (can't know exactly which code is deployed). It's unpredictable when combined with `IfNotPresent` policy. Use semantic versions or Git SHAs for immutable, traceable deployments.

---

## 🔟 Related Concepts to Revise
- imagePullPolicy options
- Container image tagging strategies
- Immutable tags vs mutable tags
- CI/CD image tagging with Git SHA
- kubectl rollout restart

---
---

# 🟡 Q21 — Deployment Scaled but Missing Replicas

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Scaled deployment to 6 replicas, only 4 running |
| **Where** | Scheduler — resource availability / namespace quota |
| **Symptom** | Some pods in Pending state, ReplicaSet shows failed creates |

> 🟢 **Beginner Explanation:** You hired 6 employees but the office only has 4 desks. 2 employees are waiting in the lobby (Pending) because there's no room.

---

## 2️⃣ Root Cause Explanation
- Pods are Pending because nodes don't have enough **free memory** for the new pods
- Or namespace `ResourceQuota` limits the total pods/resources allowed
- Scheduler can't place pods → they stay Pending
- **Components involved:** kube-scheduler, node resource manager, ResourceQuota admission controller

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check deployment and see only 4 available
kubectl get deployment <name>
# READY 4/6 ← 2 missing

# Step 2: Check ReplicaSet events
kubectl describe rs <rs-name>
# Events: "failed to create pod: exceeded quota" OR "Insufficient memory"

# Step 3: List pods — see Pending ones
kubectl get pods -l app=<name>
# 4 Running, 2 Pending

# Step 4: Describe a Pending pod
kubectl describe pod <pending-pod>
# Events: "0/3 nodes are available: 3 Insufficient memory"
# OR: "exceeded resource quota"

# Step 5: Check node resources
kubectl top nodes
# All nodes near 100% memory

# Step 6: Check ResourceQuota
kubectl get resourcequota -n <namespace>
kubectl describe resourcequota -n <namespace>

# Step 7: Fix — either reduce memory request or add nodes
```

---

