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

## 4️⃣ Fix / Resolution

**Fix 1: Reduce memory requests**
```yaml
resources:
  requests:
    memory: "256Mi"   # ✅ Reduced from 1Gi — fits on nodes
    cpu: "100m"
  limits:
    memory: "512Mi"
    cpu: "500m"
```

**Fix 2: Update ResourceQuota if namespace limit is too low**
```yaml
# resourcequota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: ns-quota
  namespace: production
spec:
  hard:
    requests.memory: "8Gi"    # ✅ Increased from 2Gi
    requests.cpu: "4"
    pods: "20"                # ✅ Increased pod count limit
```

```bash
# Apply quota update
kubectl apply -f resourcequota.yaml

# Watch pending pods get scheduled
kubectl get pods -w
```

---

## 5️⃣ Interview Answer Version

> *"When scaled pods stay Pending, I first describe the deployment's ReplicaSet to check events — common errors are 'Insufficient memory' or 'exceeded quota'. I then describe a Pending pod to confirm. If it's resource pressure, I either reduce the memory request in the deployment spec or request the infrastructure team to add nodes. If it's a ResourceQuota issue, I check `kubectl describe resourcequota` and request a quota increase for the namespace."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Black Friday scaling event — team scales app from 2 to 6 replicas. Only 4 come up. 2 pods stuck Pending for 20 minutes.
>
> **Alert:** Deployment health check shows 4/6 ready.
>
> **Investigation:** `kubectl describe pod` shows:
> ```
> 0/5 nodes are available: 5 Insufficient memory
> ```
>
> **Resolution:** Reduced memory request from 1Gi to 512Mi. All 6 pods scheduled immediately. Long-term: implemented Cluster Autoscaler to add nodes automatically during scaling events.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get deployment` | Check READY vs DESIRED count |
| `kubectl describe rs <name>` | ReplicaSet events — why pod creation failed |
| `kubectl describe pod <pending-pod>` | Why specific pod is Pending |
| `kubectl top nodes` | Live memory/CPU usage per node |
| `kubectl describe resourcequota -n <ns>` | Check namespace quota limits and usage |
| `kubectl get limitrange -n <ns>` | Check per-container resource limits |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Two separate issues can look identical — **node resource pressure** vs **namespace ResourceQuota**. Always check both.
- 🔍 `kubectl describe resourcequota` shows `used` vs `hard` — if used ≈ hard, quota is the blocker
- 🛡️ Use **Cluster Autoscaler** in cloud environments — automatically adds nodes when pods are Pending due to resource pressure
- 🛡️ Set up **LimitRange** in every namespace to enforce default requests/limits so developers can't accidentally request too much
- 🛡️ Use **VPA (Vertical Pod Autoscaler)** in recommendation mode to get right-sized resource values

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between ResourceQuota and LimitRange?**
> `ResourceQuota` sets total limits for an entire namespace (total CPU, memory, pod count). `LimitRange` sets default and max/min limits per individual container or pod within a namespace.

**Q: What is Cluster Autoscaler and when does it trigger?**
> Cluster Autoscaler automatically adds nodes when pods are stuck in Pending due to insufficient resources, and removes underutilized nodes to save cost. It triggers when the scheduler can't place pods due to resource constraints.

**Q: How would you proactively prevent this issue?**
> Monitor node resource utilization with Prometheus alerts at 75-80% threshold. Implement Cluster Autoscaler. Set proper resource requests based on VPA recommendations. Run regular capacity planning reviews.

---

## 🔟 Related Concepts to Revise
- ResourceQuota and LimitRange
- Kubernetes Cluster Autoscaler
- VPA (Vertical Pod Autoscaler)
- Node resource capacity planning
- kube-scheduler resource-based filtering

---
---

# 🟡 Q22 — Downtime During Rolling Update

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Users experience downtime during a rolling deployment update |
| **Where** | Deployment rolling update strategy |
| **Symptom** | HTTP 503 errors or connection timeouts during deployment rollout |

> 🟢 **Beginner Explanation:** During renovation (deployment update), too many rooms (pods) were closed at once, leaving no rooms available for guests (users). The fix is to close only one room at a time while keeping others open.

---

## 2️⃣ Root Cause Explanation
- `maxUnavailable: 2` allowed 2 pods to go down simultaneously — too many for the load
- No `readinessProbe` or `initialDelaySeconds` too low — new pods marked ready before they're truly ready to serve
- Traffic is routed to new pods before they finish warming up
- **Components involved:** Deployment controller, readinessProbe, kube-proxy, Endpoints controller

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check rollout status during downtime
kubectl rollout status deployment/<name>
# "Waiting for deployment rollout to finish: 1 out of 3 updated replicas are available"

# Step 2: Check deployment strategy settings
kubectl get deployment <name> -o yaml | grep -A10 strategy
# maxUnavailable: 2  ← Too high! Allows 2 pods down at once
# maxSurge: 1

# Step 3: Check readiness probe configuration
kubectl get deployment <name> -o yaml | grep -A15 readinessProbe
# initialDelaySeconds: 0  ← Too low! Pod marked ready immediately

# Step 4: Check pod events during rollout
kubectl describe pod <new-pod-name>
# Pod marked Ready before application fully initialized

# Step 5: Fix strategy and readiness probe (see below)

# Step 6: Redeploy and verify zero downtime
kubectl apply -f deployment.yaml
kubectl rollout status deployment/<name>
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — Causes downtime ❌
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 2    # ❌ Too many pods down at once
      maxSurge: 1
  template:
    spec:
      containers:
      - name: app
        image: myapp:v2
        # No readinessProbe configured! ❌
```

```yaml
# AFTER — Zero downtime configuration ✅
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 0    # ✅ Never take down pods until new ones are ready
      maxSurge: 1          # ✅ Allow 1 extra pod above desired count during rollout
  template:
    spec:
      containers:
      - name: app
        image: myapp:v2
        readinessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 10   # ✅ Wait 10s before first check
          periodSeconds: 5          # ✅ Check every 5 seconds
          failureThreshold: 3       # ✅ Must pass 3 checks before marked Ready
```

```bash
kubectl apply -f deployment.yaml
kubectl rollout status deployment/<name>
# "successfully rolled out" — with zero downtime
```

---

## 5️⃣ Interview Answer Version

> *"Downtime during rolling updates usually comes from two issues: `maxUnavailable` set too high (removing too many pods at once) and missing or poorly configured readinessProbe (new pods receiving traffic before they're ready). My fix is: set `maxUnavailable: 0` so existing pods stay up until new ones are ready, set `maxSurge: 1` for smooth transition, and configure a proper readinessProbe with `initialDelaySeconds` to ensure new pods are truly ready before traffic is sent to them."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Tuesday deployment. Users report 503 errors for ~90 seconds. Rollout completes but incident is filed.
>
> **Root cause:** `maxUnavailable: 2` with a 3-replica deployment. 2 pods terminated before 1 new pod was ready. Cluster briefly had only 1 pod for full load.
>
> **Resolution:**
> - Changed `maxUnavailable: 0`, `maxSurge: 1`
> - Added readinessProbe with `initialDelaySeconds: 15`
> - Added PodDisruptionBudget as additional safety

```yaml
# PodDisruptionBudget — extra safety net
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: app-pdb
spec:
  minAvailable: 2    # Always keep at least 2 pods running
  selector:
    matchLabels:
      app: myapp
```

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl rollout status deployment/<name>` | Monitor rollout live |
| `kubectl get deployment <name> -o yaml` | Check strategy and probe config |
| `kubectl rollout pause deployment/<name>` | Pause mid-rollout if issues detected |
| `kubectl rollout undo deployment/<name>` | Rollback if downtime continues |
| `kubectl get pdb` | Check PodDisruptionBudget status |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `maxUnavailable: 0` + `maxSurge: 1` = safest zero-downtime config but needs slightly more resources temporarily
- 🔍 `readinessProbe` failure removes pod from Service endpoints — traffic stops going to it. `livenessProbe` failure restarts the container.
- 🛡️ Always configure both `readinessProbe` and `livenessProbe` for production workloads
- 🛡️ Add `PodDisruptionBudget` (PDB) to enforce minimum available pods during both rollouts and node maintenance
- 🛡️ Use `preStop` hook with a sleep to allow in-flight requests to complete before pod termination

```yaml
# preStop hook — graceful shutdown
lifecycle:
  preStop:
    exec:
      command: ["/bin/sh", "-c", "sleep 10"]
```

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between maxUnavailable and maxSurge?**
> `maxUnavailable` = max pods that can be unavailable during rollout (can be 0 for zero-downtime). `maxSurge` = max extra pods above desired count created during rollout to replace the old ones.

**Q: What is a PodDisruptionBudget?**
> PDB defines the minimum number of pods that must remain available during voluntary disruptions (deployments, node drains). It prevents Kubernetes from taking down too many pods at once.

**Q: How does readinessProbe prevent downtime?**
> Kubernetes only adds a pod to the Service's endpoint list (making it receive traffic) when its readinessProbe passes. So traffic only flows to pods that have confirmed they're ready.

---

## 🔟 Related Concepts to Revise
- Rolling update strategy (maxUnavailable, maxSurge)
- readinessProbe, livenessProbe, startupProbe
- PodDisruptionBudget
- Graceful shutdown (preStop hook, terminationGracePeriodSeconds)
- Service Endpoints and traffic routing

---
---

# 🔴 Q23 — ClusterIP Unreachable Inside Cluster

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | ClusterIP service exists but pods inside cluster can't reach it |
| **Where** | Service — label selector / endpoints |
| **Symptom** | `curl <cluster-ip>` times out or connection refused from inside a pod |

> 🟢 **Beginner Explanation:** The service is like a receptionist (ClusterIP) who should forward calls to employees (pods). If the receptionist's directory (selector) has the wrong employee names (wrong labels), no calls get forwarded — the line just rings with no answer.

---

## 2️⃣ Root Cause Explanation
- ClusterIP service routes traffic to pods **matching its label selector**
- If the selector labels don't match the actual pod labels — even by one character — no endpoints are created
- No endpoints = service has no backend = connection hangs or refused
- **Components involved:** Service, Endpoints controller, kube-proxy, label selectors

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm service exists
kubectl get svc <service-name>
# Service shown but IP unreachable

# Step 2: CHECK ENDPOINTS — most important step ← 
kubectl get endpoints <service-name>
# NAME           ENDPOINTS   AGE
# my-service     <none>      5m   ← No endpoints! Root cause found.

# Step 3: Compare service selector vs pod labels
kubectl get svc <service-name> -o yaml | grep -A5 selector
# selector:
#   app: my-app
#   tier: backend

kubectl get pods --show-labels
# Labels: app=my-app, tier=be  ← "be" vs "backend" — MISMATCH!

# Step 4: Fix the selector in service YAML
# Change tier: backend → tier: be (or fix pod labels to match)

# Step 5: Apply fix
kubectl apply -f service.yaml

# Step 6: Verify endpoints now populated
kubectl get endpoints <service-name>
# NAME         ENDPOINTS              AGE
# my-service   10.244.1.5:8080,...   5m  ✅ Now shows pod IPs

# Step 7: Test connectivity
kubectl exec -it <any-pod> -- curl http://<service-name>:<port>
# Should return response now ✅
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — Selector mismatch ❌
# Service YAML
spec:
  selector:
    app: my-app
    tier: backend     # ❌ Service looks for "backend"

---
# Pod YAML
metadata:
  labels:
    app: my-app
    tier: be          # ❌ Pod has "be" — mismatch!
```

```yaml
# AFTER — Selector matches pod labels ✅
# Service YAML
spec:
  selector:
    app: my-app
    tier: backend     # ✅ Now matches pod label

---
# Pod YAML
metadata:
  labels:
    app: my-app
    tier: backend     # ✅ Fixed to match service selector
```

```bash
kubectl apply -f service.yaml
kubectl get endpoints <service-name>
# Endpoints should now show pod IPs ✅
```

---

## 5️⃣ Interview Answer Version

> *"When a ClusterIP service is unreachable inside the cluster, the first thing I check is `kubectl get endpoints <service-name>`. If it shows `<none>`, the selector isn't matching any pods. I then compare the service selector with actual pod labels using `kubectl get pods --show-labels`. Even a single character mismatch (like 'backend' vs 'be') means no traffic is forwarded. Fix the selector, verify endpoints are populated, and connectivity restores."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** App can't reach its Redis service. App pods running. Redis pods running. Service exists.
>
> **Investigation:** `kubectl get endpoints redis-service` shows `<none>`.
>
> **Root cause:** Redis pods had label `app: redis-cache` but service selector had `app: redis`. One word difference.
>
> **Resolution:** Updated service selector to `app: redis-cache`. Endpoints immediately populated. Connectivity restored.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get endpoints <name>` | **KEY** — shows if service has any backends |
| `kubectl get svc <name> -o yaml` | See full service spec with selector |
| `kubectl get pods --show-labels` | See all pod labels |
| `kubectl get pods -l <key>=<value>` | Test if selector matches any pods |
| `kubectl exec -it <pod> -- curl http://<svc>:<port>` | Test connectivity from inside cluster |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 **`kubectl get endpoints` is your fastest diagnostic tool** for service issues — always check this first
- 🔍 Quick selector test: `kubectl get pods -l app=my-app,tier=backend` — if this returns pods, the service selector will work
- 🛡️ Use consistent label naming conventions across your team (enforce via OPA policies)
- 🛡️ In Helm charts, template labels so service selectors and pod labels always stay in sync automatically

```bash
# Quick way to test if selector matches pods
kubectl get pods -l $(kubectl get svc <name> -o jsonpath='{.spec.selector}' | \
  tr -d '{}"' | tr ',' ' ' | sed 's/:/=/g')
```

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between ClusterIP, NodePort, and LoadBalancer service types?**
> `ClusterIP` — internal only, accessible within cluster. `NodePort` — exposes service on a static port on each node's IP. `LoadBalancer` — provisions a cloud load balancer, accessible externally.

**Q: How does a Service find its backend pods?**
> Through label selectors. The Endpoints controller watches for pods matching the service's selector and populates the Endpoints object with their IPs. kube-proxy then sets up iptables/IPVS rules to route traffic.

---

## 🔟 Related Concepts to Revise
- Kubernetes Services (ClusterIP, NodePort, LoadBalancer)
- Label selectors
- Endpoints and EndpointSlices
- kube-proxy and iptables
- Service discovery in Kubernetes

---
---

# 🟡 Q24 — ClusterIP Resolves but Connection Refused

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | DNS resolves the service name, endpoints exist, but requests fail with "connection refused" |
| **Where** | Service port → container target port mapping |
| **Symptom** | `curl http://my-service` returns `Connection refused` |

> 🟢 **Beginner Explanation:** You dialed the right phone number (DNS resolves), the call connected (endpoint exists), but when transferred to the employee's extension (target port), the phone rings on the wrong desk — no one picks up.

---

## 2️⃣ Root Cause Explanation
- Service `port` (what external callers use) and `targetPort` (what the container listens on) are mismatched
- Service forwards to port 80, but app listens on 8080 → port 80 is unbound on the pod → connection refused
- **Components involved:** Service targetPort, container's listening port, kube-proxy iptables rules

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check service — it exists and DNS resolves
kubectl get svc <service-name>

# Step 2: Check endpoints — they exist (selector is correct)
kubectl get endpoints <service-name>
# Shows pod IPs ✅ — so selector is fine

# Step 3: Inspect service port vs targetPort
kubectl get svc <service-name> -o yaml | grep -A10 ports
# ports:
# - port: 80          ← Service listens on 80
#   targetPort: 80    ← Forwards to pod port 80 ← WRONG!

# Step 4: Check what port the container actually listens on
kubectl describe pod <pod-name> | grep -A5 Ports
# Container Port: 8080  ← App listens on 8080!

# Alternatively exec and check
kubectl exec -it <pod-name> -- ss -tlnp
# Shows: *:8080  ← Confirmed, app listens on 8080

# Step 5: Fix targetPort in service YAML
# Change targetPort: 80 → targetPort: 8080

# Step 6: Apply and test
kubectl apply -f service.yaml
kubectl exec -it <test-pod> -- curl http://<service-name>
# ✅ Response received
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — targetPort mismatch ❌
spec:
  ports:
  - protocol: TCP
    port: 80          # Service exposed on port 80
    targetPort: 80    # ❌ Forwards to pod port 80, but app listens on 8080!
```

```yaml
# AFTER — targetPort matches container's listening port ✅
spec:
  ports:
  - protocol: TCP
    port: 80           # Service still exposed on port 80 (no change for callers)
    targetPort: 8080   # ✅ Now correctly forwards to pod port 8080
```

```bash
kubectl apply -f service.yaml

# Verify
kubectl get svc <name> -o yaml | grep targetPort
# targetPort: 8080 ✅

# Test
kubectl exec -it <any-pod> -- curl http://my-service:80
# Returns response ✅
```

---

## 5️⃣ Interview Answer Version

> *"Connection refused with valid DNS and existing endpoints points to a port mismatch. I check the service YAML for `targetPort` and compare it against the actual port the container listens on — using `kubectl exec -- ss -tlnp` or `kubectl describe pod` to see container ports. In this case, service forwarded to port 80 but the app listened on 8080. Fixing targetPort to 8080 resolved it immediately."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** New Node.js service deployed. DNS works. Endpoints exist. Still 503.
>
> **Root cause:** Developer changed app port from 80 to 8080 in code but didn't update the Kubernetes service YAML's `targetPort`.
>
> **Resolution:** Updated `targetPort: 8080`. Added container port validation in the CI pipeline — service targetPort must match the Dockerfile `EXPOSE` value.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get svc <name> -o yaml` | See port and targetPort |
| `kubectl describe pod <name>` | See container's declared ports |
| `kubectl exec -it <pod> -- ss -tlnp` | Check what ports app actually listens on |
| `kubectl exec -it <pod> -- netstat -tlnp` | Alternative port check |
| `kubectl exec -it <pod> -- curl localhost:8080` | Test container port directly |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 **Debugging flow for service issues:** DNS → Endpoints → Port → App
- 🔍 `targetPort` can be a **named port** — define `name: http` on container port and reference it by name in targetPort for clarity
- 🛡️ Use named ports in service YAML to avoid magic numbers:

```yaml
# Pod spec
containers:
- name: app
  ports:
  - name: http
    containerPort: 8080

# Service spec
ports:
- port: 80
  targetPort: http    # ✅ References named port — self-documenting
```

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between `port`, `targetPort`, and `nodePort` in a service?**
> `port` = port the service exposes inside the cluster. `targetPort` = port on the pod/container the service forwards traffic to. `nodePort` = port exposed on each node's IP for external access (NodePort services only).

**Q: Can targetPort be a string?**
> Yes — it can reference a named port defined on the container (`containerPort` with a `name` field). This is a best practice as it decouples the service from the specific port number.

---

## 🔟 Related Concepts to Revise
- Service port, targetPort, nodePort
- Named ports in pod spec
- kube-proxy iptables rules
- Container networking (ss, netstat commands)
- Service discovery flow

---
---

# 🟡 Q25 — NodePort Works on One Node Only

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | NodePort service accessible on some nodes but not others |
| **Where** | Node-level — firewall rules / kube-proxy |
| **Symptom** | `curl nodeIP:30080` works on node2 and node3, fails on node1 |

> 🟢 **Beginner Explanation:** NodePort opens the same door (port) on every node's house. If one house (node1) has a security lock (firewall rule) blocking that door while others don't — visitors can't enter that specific house.

---

## 2️⃣ Root Cause Explanation
- NodePort is supposed to open the same port on **all nodes** automatically
- kube-proxy sets up iptables rules on each node to forward NodePort traffic to pods
- If a firewall rule on one node **explicitly blocks** that port, traffic never reaches kube-proxy
- **Components involved:** kube-proxy, node-level firewall (iptables/cloud security groups), NodePort range

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm service is correct
kubectl get svc <service-name>
# TYPE: NodePort   PORT: 80:30080/TCP ✅

# Step 2: Check endpoints — pods are healthy
kubectl get endpoints <service-name>
# Shows pod IPs ✅

# Step 3: Test from each node
curl http://<node1-ip>:30080    # Connection refused ❌
curl http://<node2-ip>:30080    # 200 OK ✅
curl http://<node3-ip>:30080    # 200 OK ✅

# Node1 is the problem node

# Step 4: Check kube-proxy on node1
kubectl get pods -n kube-system | grep kube-proxy
kubectl logs kube-proxy-<node1-pod> -n kube-system

# Step 5: SSH to node1 and check firewall rules
ssh node1
sudo iptables -L INPUT -n | grep 30080
# If you see: DROP or REJECT for port 30080 → root cause found!

# Step 6: Remove the blocking rule
sudo iptables -D INPUT -p tcp --dport 30080 -j DROP

# OR for cloud environments — check Security Group rules in AWS/GCP console

# Step 7: Test again
curl http://<node1-ip>:30080    # 200 OK ✅
```

---

## 4️⃣ Fix / Resolution

```bash
# Fix 1: Remove iptables deny rule on node1
sudo iptables -D INPUT -p tcp --dport 30080 -j DROP
# Verify
sudo iptables -L INPUT -n | grep 30080
# No DENY rule ✅

# Fix 2: For cloud (AWS) — update Security Group
# Allow inbound TCP port 30080 from required sources
# Via AWS Console or CLI:
aws ec2 authorize-security-group-ingress \
  --group-id sg-xxxxxxxx \
  --protocol tcp \
  --port 30080 \
  --cidr 0.0.0.0/0

# Fix 3: Make iptables changes persistent
sudo apt-get install iptables-persistent
sudo netfilter-persistent save
```

---

## 5️⃣ Interview Answer Version

> *"When a NodePort works on some nodes but not others, the Kubernetes configuration is correct — the issue is node-specific. I test each node individually with curl. On the failing node, I check iptables rules with `sudo iptables -L INPUT -n` and look for a DENY rule on that NodePort. In this case, port 30080 was explicitly blocked by a firewall rule on node1. Removing the deny rule restored access. In cloud environments, I'd check security group rules."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Load balancer health checks fail for node1 only. Nodes 2 and 3 pass.
>
> **Root cause:** Security hardening script run on node1 blocked all non-standard ports including NodePort range (30000-32767).
>
> **Resolution:** Updated the hardening script to allowlist the NodePort range. Applied fix to node1. Added automated port connectivity test in the node validation pipeline.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get svc <name>` | Confirm NodePort and port number |
| `kubectl get pods -n kube-system -o wide` | Check kube-proxy pod per node |
| `kubectl logs kube-proxy-<pod> -n kube-system` | kube-proxy logs on specific node |
| `curl http://<nodeIP>:<nodePort>` | Test each node directly |
| `kubectl get nodes -o wide` | Get node IPs |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 kube-proxy runs as a DaemonSet — one pod per node. Its logs show iptables rule configuration
- �� NodePort range defaults: 30000-32767. Ensure firewall rules allow this entire range or specific ports
- 🛡️ In cloud environments (EKS, GKE, AKS), check both node-level security groups AND cluster-level network policies
- 🛡️ Use Calico/Cilium NetworkPolicies for fine-grained control rather than raw iptables rules

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the default NodePort range in Kubernetes?**
> 30000-32767. This can be customized via `--service-node-port-range` flag on kube-apiserver.

**Q: How does kube-proxy handle NodePort traffic?**
> kube-proxy watches Service objects and creates iptables (or IPVS) rules on every node that forward traffic arriving on the NodePort to the appropriate pod IPs, regardless of which node the pod runs on.

---

## 🔟 Related Concepts to Revise
- kube-proxy modes (iptables vs IPVS)
- NodePort service type
- Linux iptables basics
- Cloud security groups / firewall rules
- DaemonSets (kube-proxy deployment model)

---
---

# 🟡 Q26 — NodePort Not Accessible Externally

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | NodePort service works inside the cluster but external clients can't reach it |
| **Where** | External network → node — cloud/network firewall |
| **Symptom** | `curl http://<node-public-ip>:30080` fails from outside, works from inside |

> 🟢 **Beginner Explanation:** The internal office phone system works fine (intra-cluster). But external callers can't get through because the building's main entrance (cloud firewall) blocks them from reaching the office floor (NodePort).

---

## 2️⃣ Root Cause Explanation
- NodePort is set up correctly in Kubernetes — internal access works
- Problem is **outside Kubernetes** — cloud firewall (AWS Security Groups, GCP Firewall Rules) or on-premise firewall blocks the NodePort
- Since internal works and external doesn't, the Kubernetes layer is fine — the network boundary is the issue
- **Components involved:** Cloud provider firewall/security groups, external network routing, node's public IP

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm service is correct type and port
kubectl get svc <service-name>
# TYPE: NodePort   PORT: 80:30080/TCP ✅

# Step 2: Check endpoints — pods are healthy
kubectl get endpoints <service-name>
# Pod IPs present ✅

# Step 3: Test from INSIDE cluster (works = Kubernetes is fine)
kubectl exec -it <any-pod> -- curl http://<node-ip>:30080
# 200 OK ✅ — Kubernetes side is fine

# Step 4: Test from OUTSIDE network (fails)
# From your laptop or another external machine:
curl http://<node-public-ip>:30080
# Connection timed out ❌ — Problem is at network/firewall level

# Step 5: Check cloud firewall (for AWS)
# Go to EC2 → Security Groups → find node's SG
# Check inbound rules for port 30080

# OR via CLI:
aws ec2 describe-security-groups --group-ids <sg-id> \
  --query 'SecurityGroups[].IpPermissions'
# Port 30080 NOT in allowed rules → Root cause

# Step 6: Add firewall rule / escalate to network team
# Step 7: Retest from outside after rule is added
```

---

## 4️⃣ Fix / Resolution

```bash
# AWS — Add inbound rule to security group
aws ec2 authorize-security-group-ingress \
  --group-id sg-xxxxxxxx \
  --protocol tcp \
  --port 30080 \
  --cidr 0.0.0.0/0    # Or restrict to specific IP range

# GCP — Add firewall rule
gcloud compute firewall-rules create allow-nodeport-30080 \
  --allow tcp:30080 \
  --source-ranges 0.0.0.0/0 \
  --target-tags kubernetes-node

# Azure — Add NSG inbound rule
az network nsg rule create \
  --resource-group myRG \
  --nsg-name myNSG \
  --name allow-nodeport \
  --protocol Tcp \
  --destination-port-range 30080 \
  --access Allow \
  --priority 100
```

---

## 5️⃣ Interview Answer Version

> *"When NodePort works inside the cluster but fails externally, the Kubernetes configuration is correct — the problem is at the network boundary. I confirm this by testing from inside the cluster (works) vs outside (fails). Then I check cloud security groups or on-premise firewall rules for the NodePort. This is not a Kubernetes issue — I escalate to the network/cloud team to open the port in their firewall rules, or do it myself if I have cloud access."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** New customer-facing API deployed. Internal QA passes. External UAT fails.
>
> **Root cause:** Kubernetes engineers set up NodePort correctly but didn't update the cloud security group. Org process required a separate change request to the cloud team.
>
> **Resolution:** Submitted firewall change request. Approved and applied. Added a post-deployment checklist item: "Verify external firewall rules for new NodePorts."

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get nodes -o wide` | Get node external/internal IPs |
| `kubectl get svc <name>` | Confirm NodePort number |
| `kubectl exec -it <pod> -- curl <nodeIP>:<nodePort>` | Test from inside cluster |
| `curl http://<external-ip>:<nodePort>` | Test from outside (your laptop) |
| `kubectl describe svc <name>` | Full service details |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 **Isolation technique:** Test inside cluster → test from node itself → test from outside. Narrows down exactly where the block is
- 🔍 `telnet <node-ip> <nodePort>` or `nc -zv <node-ip> <nodePort>` — quick port reachability test
- 🛡️ For production, prefer LoadBalancer service type or Ingress over NodePort for external access — more control, TLS, routing
- 🛡️ If using NodePort long-term, use a specific NodePort number in YAML so firewall rules don't break on service recreation

```yaml
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 8080
    nodePort: 30080    # ✅ Fixed nodePort — consistent firewall rules
```

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: When would you use NodePort vs LoadBalancer?**
> NodePort — development/testing, on-premise environments without cloud LB, or when you manage your own external LB. LoadBalancer — production cloud environments where automatic external IP provisioning is needed.

**Q: What are the security risks of NodePort?**
> NodePort exposes a port on ALL cluster nodes. Anyone who can reach any node IP and port can access the service. Use with restrictive security groups. Better to use Ingress with TLS for production external traffic.

---

## 🔟 Related Concepts to Revise
- NodePort vs LoadBalancer vs Ingress
- Cloud security groups / firewall rules
- External traffic flow in Kubernetes
- externalTrafficPolicy (Local vs Cluster)
- Ingress controllers (nginx, traefik)

---
---

# 🔴 Q27 — Traffic Going to Pods on One Node Only

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Service has multiple endpoints across nodes but traffic only reaches pods on one node |
| **Where** | kube-proxy — node level traffic routing |
| **Symptom** | Uneven load, pods on node2 get no traffic despite being healthy endpoints |

> 🟢 **Beginner Explanation:** The call center routing system (kube-proxy) on floor 2 (node2) is broken. All calls get transferred to floor 1 (node1) even though floor 2 agents are available and ready.

---

## 2️⃣ Root Cause Explanation
- kube-proxy runs on every node and programs iptables/IPVS rules to distribute traffic across all pod endpoints
- If kube-proxy fails/crashes on a node, that node's iptables rules are stale or missing
- Traffic arriving at the broken node can't be properly routed, so it falls back to only routing to local pods or the first available path
- **Components involved:** kube-proxy DaemonSet, iptables/IPVS rules, Service endpoints

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check service endpoints — all pods are listed
kubectl get endpoints <service-name>
# Shows IPs from both node1 and node2 ✅ (Kubernetes knows about all pods)

# Step 2: Check pod distribution across nodes
kubectl get pods -o wide
# pod-A: node1, pod-B: node2, pod-C: node2
# Pods spread across nodes ✅

# Step 3: Check kube-proxy status on all nodes
kubectl get pods -n kube-system -o wide | grep kube-proxy
# kube-proxy-node1: Running ✅
# kube-proxy-node2: CrashLoopBackOff ❌ ← Root cause!

# Step 4: Check kube-proxy logs on node2
kubectl logs kube-proxy-<node2-pod> -n kube-system
# Error: "Failed to sync iptables rules: iptables command failed"
# OR: "Failed to update iptable rules: permission denied"

# Step 5: Fix — restart kube-proxy pod on node2
kubectl delete pod kube-proxy-<node2-pod> -n kube-system
# DaemonSet automatically recreates it

# Step 6: Verify kube-proxy is healthy on all nodes
kubectl get pods -n kube-system | grep kube-proxy
# All Running ✅

# Step 7: Verify traffic now distributes across both nodes
# Test from multiple clients or use load testing tool
```

---

## 4️⃣ Fix / Resolution

```bash
# Restart the failing kube-proxy pod
# (Safe because kube-proxy is a DaemonSet — auto-recreates)
kubectl delete pod kube-proxy-<node2-pod-name> -n kube-system

# Watch it restart
kubectl get pods -n kube-system -w | grep kube-proxy
# kube-proxy-node2: Terminating → Pending → Running ✅

# Verify iptables rules are now set on node2 (SSH to node2)
ssh node2
sudo iptables -t nat -L KUBE-SERVICES | grep <service-cluster-ip>
# Rules present ✅

# Verify traffic balancing by running repeated requests
for i in {1..10}; do kubectl exec -it <test-pod> -- curl -s http://my-service/hostname; done
# Should show different pod hostnames from both nodes
```

---

## 5️⃣ Interview Answer Version

> *"When service endpoints show pods on multiple nodes but traffic only reaches one node, kube-proxy on the other node is likely failing. kube-proxy programs iptables rules on each node — if it crashes, rules become stale. I check `kubectl get pods -n kube-system | grep kube-proxy` to find the failing pod, read its logs to confirm iptables rule sync failure, then delete it. Since kube-proxy is a DaemonSet, Kubernetes recreates it automatically, restoring proper traffic distribution."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Monitoring shows CPU imbalance — node1 pods at 90% CPU, node2 pods at 5%.
>
> **Root cause:** kube-proxy on node2 crashed due to an iptables conflict from a manually applied firewall rule. All traffic routed to node1.
>
> **Resolution:** Deleted kube-proxy pod on node2. Restarted fresh. Documented that manual iptables changes are prohibited on cluster nodes.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get pods -n kube-system -o wide` | See kube-proxy status per node |
| `kubectl logs kube-proxy-<pod> -n kube-system` | kube-proxy error logs |
| `kubectl delete pod <kube-proxy-pod> -n kube-system` | Restart kube-proxy (DaemonSet recreates) |
| `kubectl get endpoints <svc>` | Verify endpoints exist |
| `kubectl get pods -o wide` | Confirm pod-to-node distribution |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 kube-proxy in IPVS mode is more performant than iptables for large clusters. Check mode with `kubectl get configmap kube-proxy -n kube-system -o yaml | grep mode`
- 🔍 `externalTrafficPolicy: Local` can cause this symptom intentionally — it only routes traffic to pods on the receiving node. Switch to `Cluster` for balanced routing.
- 🛡️ Never manually modify iptables on Kubernetes nodes — conflicts with kube-proxy rules
- 🛡️ Monitor kube-proxy pod health as a critical infrastructure alert

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is `externalTrafficPolicy: Local` and when is it used?**
> `Local` routes traffic only to pods on the receiving node (preserves source IP, avoids extra hop). `Cluster` (default) routes to any pod across all nodes (load balanced, source IP is NAT'd). Use `Local` when you need source IP preservation (e.g., for rate limiting by client IP).

**Q: What is the difference between kube-proxy iptables mode and IPVS mode?**
> iptables mode creates one rule per service/endpoint — doesn't scale well past ~10k rules. IPVS (IP Virtual Server) uses hash tables for O(1) lookups — scales to thousands of services. IPVS is recommended for large clusters.

---

## 🔟 Related Concepts to Revise
- kube-proxy (iptables vs IPVS modes)
- DaemonSets
- externalTrafficPolicy (Local vs Cluster)
- iptables KUBE-SERVICES chain
- Service load balancing internals

---
---

# 🔴 Q28 — Service Works via Pod IP, Not Service Name

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Directly using pod IP works, but using service DNS name fails |
| **Where** | Cluster DNS — CoreDNS |
| **Symptom** | `curl http://10.244.1.5:8080` works, `curl http://my-service:8080` fails |

> 🟢 **Beginner Explanation:** You can call someone by their personal phone number (pod IP) but the office directory (DNS/CoreDNS) is broken — looking up their name (service name) returns nothing.

---

## 2️⃣ Root Cause Explanation
- Pod IP works = pods are running, networking is fine, kube-proxy is fine
- Service name fails = DNS resolution is broken
- CoreDNS is the cluster DNS server — if it's down/crashing, service name resolution fails for everyone
- **Components involved:** CoreDNS pods, kube-dns service, DNS resolution chain

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm service exists and has endpoints
kubectl get svc my-service
kubectl get endpoints my-service
# Both exist ✅ — so issue is not selector/endpoint related

# Step 2: Test direct pod IP (works)
kubectl exec -it <test-pod> -- curl http://10.244.1.5:8080
# 200 OK ✅ — networking is fine

# Step 3: Test service name DNS resolution (fails)
kubectl exec -it <test-pod> -- nslookup my-service
# Server: 10.96.0.10
# ** server can't find my-service: SERVFAIL  ← DNS failure!

# Step 4: Check CoreDNS pods
kubectl get pods -n kube-system | grep coredns
# coredns-xxxxx: CrashLoopBackOff ❌ ← Root cause!

# Step 5: Check CoreDNS logs
kubectl logs <coredns-pod> -n kube-system
# Error: plugin/errors: 2 SERVFAIL...
# OR: segmentation fault

# Step 6: Restart CoreDNS
kubectl rollout restart deployment/coredns -n kube-system

# Step 7: Wait for CoreDNS to be Running
kubectl get pods -n kube-system -w | grep coredns
# Running ✅

# Step 8: Test DNS resolution again
kubectl exec -it <test-pod> -- nslookup my-service
# my-service.default.svc.cluster.local: 10.96.x.x ✅
```

---

## 4️⃣ Fix / Resolution

```bash
# Restart CoreDNS deployment
kubectl rollout restart deployment/coredns -n kube-system

# Verify CoreDNS is healthy
kubectl get pods -n kube-system | grep coredns
# All Running ✅

# Test DNS from a pod
kubectl run dns-test --rm -it --image=busybox -- nslookup kubernetes.default
# Shows: kubernetes.default.svc.cluster.local ✅

# Test application service DNS
kubectl exec -it <app-pod> -- nslookup my-service
# my-service.default.svc.cluster.local: 10.96.x.x ✅
```

```yaml
# If CoreDNS has config issues, check ConfigMap
kubectl get configmap coredns -n kube-system -o yaml
# Verify Corefile syntax is correct
```

---

## 5️⃣ Interview Answer Version

> *"If pod IP works but service name doesn't, DNS resolution is broken — the networking layer is fine but CoreDNS is failing. I verify with `nslookup my-service` from inside a pod. If it fails, I check `kubectl get pods -n kube-system | grep coredns` for CrashLoopBackOff. Reading CoreDNS logs confirms the issue. Restarting CoreDNS with `kubectl rollout restart deployment/coredns -n kube-system` restores DNS resolution."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** All services in the cluster suddenly unreachable by name. Pod IPs still work.
>
> **Alert:** Multiple application alerts fire simultaneously — all showing DNS resolution failures.
>
> **Root cause:** CoreDNS ConfigMap was accidentally modified (malformed Corefile syntax) during a config change, causing both CoreDNS pods to crash.
>
> **Resolution:** Reverted ConfigMap to previous version, restarted CoreDNS. Implemented RBAC to restrict CoreDNS ConfigMap modifications.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get pods -n kube-system \| grep coredns` | Check CoreDNS health |
| `kubectl logs <coredns-pod> -n kube-system` | CoreDNS error logs |
| `kubectl rollout restart deployment/coredns -n kube-system` | Restart CoreDNS |
| `kubectl exec -it <pod> -- nslookup <service>` | Test DNS from inside cluster |
| `kubectl get configmap coredns -n kube-system -o yaml` | Inspect CoreDNS config |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Full DNS name format: `<service>.<namespace>.svc.cluster.local` — always test with full FQDN to isolate namespace issues
- 🔍 Check `/etc/resolv.conf` inside a pod: `kubectl exec -it <pod> -- cat /etc/resolv.conf` — shows DNS server IP (should be CoreDNS ClusterIP)
- 🛡️ Run CoreDNS with minimum 2 replicas in production for HA
- 🛡️ Set resource limits on CoreDNS to prevent OOMKill under high DNS load
- 🛡️ Use NodeLocal DNSCache to reduce CoreDNS load and improve resilience

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: How does Kubernetes DNS work internally?**
> Each pod's `/etc/resolv.conf` points to the CoreDNS ClusterIP. When a pod queries `my-service`, it's sent to CoreDNS. CoreDNS looks up the service in its cluster.local zone and returns the ClusterIP. kube-proxy then routes the traffic to a pod.

**Q: What is the full DNS name for a service?**
> `<service-name>.<namespace>.svc.cluster.local`. Within the same namespace, you can use just `<service-name>`. Cross-namespace requires `<service-name>.<namespace>`.

---

## 🔟 Related Concepts to Revise
- CoreDNS (Kubernetes DNS)
- DNS resolution chain in Kubernetes
- /etc/resolv.conf in pods
- NodeLocal DNSCache
- FQDN in Kubernetes (cluster.local domain)

---
---

# 🟡 Q29 — Headless Service Returns No DNS Records

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Headless service DNS query returns empty — no pod IPs resolved |
| **Where** | Service selector → DNS → Endpoints |
| **Symptom** | `nslookup my-headless-service` returns no records despite pods running |

> 🟢 **Beginner Explanation:** A headless service is like a class register that lists all students directly (pod IPs). If the register uses the wrong student name format (label mismatch), no names get listed — the register is blank.

---

## 2️⃣ Root Cause Explanation
- Headless service (`clusterIP: None`) returns individual pod IPs directly via DNS (instead of a single VIP)
- DNS records are only created when **Endpoints exist** — endpoints are created when selector matches pods
- If selector label in service doesn't match pod labels, no endpoints → no DNS records
- **Components involved:** CoreDNS, Endpoints controller, headless service, pod labels

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm headless service configuration
kubectl get svc my-headless-service -o yaml | grep clusterIP
# clusterIP: None ✅ — Confirmed headless

# Step 2: Test DNS resolution (returns nothing)
kubectl exec -it <test-pod> -- nslookup my-headless-service
# ** server can't find my-headless-service: NXDOMAIN
# OR: returns empty answer section

# Step 3: Check endpoints
kubectl get endpoints my-headless-service
# NAME                    ENDPOINTS   AGE
# my-headless-service     <none>      5m  ← No endpoints!

# Step 4: Pods ARE running — so why no endpoints?
kubectl get pods --show-labels
# Labels: app=back-end  ← Note the hyphen!

# Step 5: Check service selector
kubectl get svc my-headless-service -o yaml | grep -A5 selector
# selector:
#   app: backend   ← No hyphen! MISMATCH!

# Step 6: Fix selector — change "backend" to "back-end"
# OR change pod label "back-end" to "backend"

# Step 7: Apply fix
kubectl apply -f service.yaml

# Step 8: Verify endpoints and DNS
kubectl get endpoints my-headless-service
# ENDPOINTS: 10.244.1.5,10.244.2.6 ✅

kubectl exec -it <test-pod> -- nslookup my-headless-service
# Returns: 10.244.1.5, 10.244.2.6 ✅
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — Selector mismatch ❌
# Service
spec:
  clusterIP: None
  selector:
    app: backend      # ❌ "backend"

---
# Pod
metadata:
  labels:
    app: back-end     # ❌ "back-end" — label mismatch!
```

```yaml
# AFTER — Selector matches pod labels ✅
# Service
spec:
  clusterIP: None
  selector:
    app: back-end     # ✅ Matches pod label exactly

---
# Pod
metadata:
  labels:
    app: back-end     # ✅ Consistent label
```

```bash
kubectl apply -f service.yaml
kubectl get endpoints my-headless-service
# Shows pod IPs ✅

# DNS now returns pod IPs directly
kubectl exec -it <pod> -- nslookup my-headless-service
# Address: 10.244.x.x (pod IP 1)
# Address: 10.244.x.x (pod IP 2) ✅
```

---

## 5️⃣ Interview Answer Version

> *"Headless service returns no DNS records when there are no endpoints — and endpoints are empty when the selector doesn't match pod labels. I verify with `kubectl get endpoints` — if `<none>`, it's a label mismatch. I compare the service selector with actual pod labels using `kubectl get pods --show-labels`. In this case 'backend' vs 'back-end' was the mismatch. Fixing the selector immediately creates endpoints and restores DNS records."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** StatefulSet with headless service for a database cluster. Pods can't discover each other — cluster formation fails.
>
> **Root cause:** Headless service selector used `app: postgres` but StatefulSet pods had label `app: postgresql` (different spelling).
>
> **Resolution:** Updated service selector to match. Endpoints created. Database cluster nodes discovered each other and formed quorum.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get endpoints <name>` | Check if endpoints exist |
| `kubectl get svc <name> -o yaml` | See clusterIP: None and selector |
| `kubectl get pods --show-labels` | See actual pod labels |
| `kubectl exec -it <pod> -- nslookup <headless-svc>` | Test DNS returns pod IPs |
| `kubectl exec -it <pod> -- dig <headless-svc>` | Detailed DNS response |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Headless service DNS format for individual pods: `<pod-name>.<headless-svc>.<namespace>.svc.cluster.local` — used heavily with StatefulSets
- 🔍 For headless service to return pod IPs, pods must also have `hostname` and `subdomain` matching the service name (for StatefulSets this is automatic)
- 🛡️ Headless services are essential for StatefulSets (databases like Cassandra, Kafka, etcd) where each pod needs a stable, individually addressable DNS name
- 🛡️ Use `dig` instead of `nslookup` for more detailed DNS debugging: `kubectl exec -it <pod> -- dig my-headless-service A`

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is a headless service and when do you use it?**
> Headless service (`clusterIP: None`) bypasses the Kubernetes proxy layer — DNS returns individual pod IPs directly. Used with StatefulSets for databases and clustered applications where each pod needs a unique, stable identity and direct addressability.

**Q: What is the difference between headless service and regular ClusterIP service?**
> ClusterIP returns a single virtual IP — load balanced across pods. Headless returns all pod IPs — client decides which to connect to. Headless enables client-side load balancing and direct pod addressing.

---

## 🔟 Related Concepts to Revise
- Headless services
- StatefulSets and pod DNS
- CoreDNS DNS records for services
- Endpoints controller
- Client-side load balancing (headless + client library)

---
---

# 🟡 Q30 — Pods Stuck in ContainerCreating

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Pods are stuck in `ContainerCreating` state for a long time |
| **Where** | Pod startup — volume mount phase |
| **Symptom** | `kubectl get pods` shows `ContainerCreating` for minutes, never progresses to `Running` |

> 🟢 **Beginner Explanation:** The pod is ready to start but it's waiting to set up its workspace (volume). If the workspace directory doesn't exist on the server (node), the pod can't set up and stays stuck.

---

## 2️⃣ Root Cause Explanation
- `ContainerCreating` = pod is scheduled on a node but container hasn't started yet
- During this phase: images are pulled, volumes are mounted, secrets/configmaps are attached
- If a `hostPath` volume references a directory that **doesn't exist on the node** — volume mount fails → pod stuck
- **Components involved:** `kubelet`, container runtime, volume manager, hostPath

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check pod status
kubectl get pods
# STATUS: ContainerCreating (for > 2-3 minutes = problem)

# Step 2: Describe pod — find the exact failure
kubectl describe pod <pod-name>
# Events:
# "MountVolume.SetUp failed for volume: hostPath ... no such file or directory"
# OR: "Unable to attach or mount volumes"

# Step 3: Check the pod YAML for volume configuration
kubectl get pod <pod-name> -o yaml | grep -A20 volumes
# hostPath:
#   path: /data/app    ← This directory doesn't exist on the node!

# Step 4: Identify which node the pod is on
kubectl get pod <pod-name> -o wide
# NODE: node-worker-1

# Step 5: SSH to the node and check/create directory
ssh node-worker-1
ls /data/app    # Directory doesn't exist!
sudo mkdir -p /data/app
sudo chmod 755 /data/app

# Step 6: Pod should auto-recover
kubectl get pods -w
# ContainerCreating → Running ✅

# OR if pod doesn't recover, delete and let it recreate
kubectl delete pod <pod-name>
kubectl get pods   # New pod should start Running
```

---

## 4️⃣ Fix / Resolution

**Fix 1: Create missing hostPath directory on the node**
```bash
# SSH to the target node
ssh <node-name>
sudo mkdir -p /data/app
sudo chmod 755 /data/app
# Pod will auto-recover or recreate into Running state
```

**Fix 2: Update pod YAML to use correct existing path**
```yaml
# BEFORE — Non-existent path ❌
volumes:
- name: app-data
  hostPath:
    path: /data/app      # ❌ This directory doesn't exist on node!
    type: Directory

# AFTER — Use DirectoryOrCreate to auto-create ✅
volumes:
- name: app-data
  hostPath:
    path: /data/app
    type: DirectoryOrCreate   # ✅ Creates directory if it doesn't exist
```

**Fix 3: Better alternative — use emptyDir or PVC instead of hostPath**
```yaml
# Recommended for most use cases
volumes:
- name: app-data
  emptyDir: {}              # ✅ Kubernetes manages this — no manual node prep needed
```

---

## 5️⃣ Interview Answer Version

> *"ContainerCreating stuck for more than a few minutes usually indicates a volume mount failure. I describe the pod and look at the Events section — a message like 'MountVolume.SetUp failed: no such file or directory' points to a hostPath volume issue. The fix is either creating the directory on the node manually, using `type: DirectoryOrCreate` in the hostPath spec, or better yet — replacing hostPath with a PVC or emptyDir which Kubernetes manages automatically."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** After cluster node replacement, some pods stuck in ContainerCreating. Other pods fine.
>
> **Root cause:** New node didn't have `/data/app` directory. Old node had it from a previous manual setup. hostPath volumes don't migrate with nodes.
>
> **Resolution:** Added node provisioning script to create required directories. Long-term: migrated from hostPath to PVC (EBS volumes on AWS) — portable, no manual node prep.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl describe pod <name>` | See volume mount failure events |
| `kubectl get pod <name> -o wide` | Find which node pod is on |
| `kubectl get pod <name> -o yaml \| grep -A20 volumes` | Inspect volume config |
| `kubectl get pvc` | Check if PVC is bound (if using PVC) |
| `kubectl get pv` | Check PersistentVolume status |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `ContainerCreating` covers multiple failure types — always describe the pod for specifics: image pull, volume mount, secret/configmap not found
- 🔍 If a Secret or ConfigMap referenced in the pod doesn't exist → also causes ContainerCreating to hang
- 🛡️ **hostPath type options:** `Directory` (must exist), `DirectoryOrCreate` (creates if missing), `File`, `FileOrCreate`, `Socket`, `CharDevice`, `BlockDevice`
- 🛡️ Avoid `hostPath` in production — it creates node affinity and operational burden. Use PVCs instead
- 🛡️ Check PVC status if using persistent storage — `kubectl get pvc` should show `Bound` not `Pending`

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What other things can cause ContainerCreating to hang?**
> Missing Secret or ConfigMap referenced in the pod spec, PVC stuck in Pending state (no available PV), image pull in progress (slow registry), CNI plugin failure (no IP assignment).

**Q: What is the difference between hostPath and PVC?**
> `hostPath` binds to a specific directory on a specific node — data is lost if pod moves to another node, requires manual node preparation. PVC (PersistentVolumeClaim) abstracts storage — Kubernetes provisions and manages it, pod can move between nodes.

---

## 🔟 Related Concepts to Revise
- Kubernetes volume types (hostPath, emptyDir, PVC, configMap, secret)
- PersistentVolume and PersistentVolumeClaim lifecycle
- Storage classes and dynamic provisioning
- hostPath types (Directory, DirectoryOrCreate, etc.)
- kubelet volume manager

---
---

# 🔴 Q31 — Ingress Routing Failure — 404 Error

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Ingress exists, service and pods are running, but all requests return 404 |
| **Where** | Ingress — path routing rules |
| **Symptom** | `curl https://example.com/users` returns `404 Not Found` |

> 🟢 **Beginner Explanation:** The building directory (Ingress) only lists Room 101 (path: /api). You're looking for Room 201 (path: /users). The directory correctly says "no such room" — the directory itself is the problem, not the building.

---

## 2️⃣ Root Cause Explanation
- Ingress rules define **which path to route to which service**
- If the configured path (`/api`) doesn't match the client's request path (`/users`), Ingress correctly returns 404
- The application and service are fine — the routing rule is wrong
- **Components involved:** Ingress controller (nginx, traefik), Ingress path rules, HTTP routing

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm 404 is from Ingress (not the application)
curl -v https://example.com/users
# Response shows nginx/ingress headers → 404 is from Ingress layer

# Step 2: Inspect Ingress rules
kubectl get ingress <name> -o yaml
# OR
kubectl describe ingress <name>
# Rules:
#   Path: /api → service:my-service:80   ← Only /api is configured!
#   /users is NOT listed → Ingress returns 404

# Step 3: Check what path the client is using
# Client calls: /users
# Ingress rule: /api
# MISMATCH → root cause

# Step 4: Fix Ingress — update path to match client request
# Change path: /api → path: /users
# OR add a new rule for /users

# Step 5: Apply fix
kubectl apply -f ingress.yaml

# Step 6: Verify
curl https://example.com/users
# 200 OK ✅
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — Wrong path configured ❌
spec:
  rules:
  - host: example.com
    http:
      paths:
      - path: /api          # ❌ Client requests /users — mismatch!
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```

```yaml
# AFTER — Correct path ✅
spec:
  rules:
  - host: example.com
    http:
      paths:
      - path: /users        # ✅ Matches client request
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```

```bash
kubectl apply -f ingress.yaml
kubectl describe ingress <name>   # Verify new path is listed
curl https://example.com/users    # 200 OK ✅
```

---

## 5️⃣ Interview Answer Version

> *"A 404 from Ingress means the request path doesn't match any configured Ingress rule. The application itself is fine. I describe the Ingress to see all configured paths and compare them with the actual client request path. The fix is updating the Ingress path rule to match what clients are requesting, or adding a new path rule if multiple routes are needed."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** API gateway migration. After moving to Ingress-based routing, all `/v2/` API calls return 404. `/v1/` calls work.
>
> **Root cause:** Ingress was configured only for `/v1/` paths. `/v2/` endpoints were added to the service but Ingress rules weren't updated.
>
> **Resolution:** Added `/v2/` path rules to Ingress. Created a process to always update Ingress rules when new API routes are added.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get ingress` | List all Ingress resources |
| `kubectl describe ingress <name>` | See rules, paths, backends |
| `kubectl get ingress <name> -o yaml` | Full Ingress spec |
| `kubectl logs <ingress-controller-pod> -n ingress-nginx` | Ingress controller logs |
| `curl -v https://<host>/<path>` | Test with verbose output to see headers |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 **Ingress controller logs** show every request — check them for "no matching rule found" messages
- 🔍 `pathType` matters: `Exact` matches only that exact path. `Prefix` matches that path and all sub-paths. `ImplementationSpecific` — depends on controller.
- 🛡️ Add a catch-all path `path: /` at the END of rules to return a proper 404 page instead of raw nginx 404
- 🛡️ Use `kubectl describe ingress` to see the complete routing table at a glance

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between pathType Exact and Prefix?**
> `Exact`: Only matches the exact path (e.g., `/api` matches only `/api`, not `/api/users`). `Prefix`: Matches the path and all sub-paths (e.g., `/api` matches `/api`, `/api/users`, `/api/v2/anything`).

**Q: What is an Ingress controller and how does it differ from an Ingress resource?**
> Ingress resource = Kubernetes object defining routing rules (YAML). Ingress controller = the actual software that reads Ingress rules and implements them (nginx-ingress, traefik, HAProxy). You need both — the resource defines rules, the controller enforces them.

---

## 🔟 Related Concepts to Revise
- Ingress resource spec (rules, paths, hosts, TLS)
- pathType (Exact, Prefix, ImplementationSpecific)
- Ingress controllers (nginx, traefik, AWS ALB)
- Host-based vs path-based routing
- Ingress class (`ingressClassName`)

---
---

# 🟡 Q32 — TLS Not Enforcing HTTPS

## 1️�� Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Ingress has TLS configured but HTTP still works — not redirected to HTTPS |
| **Where** | Ingress — TLS configuration and redirect annotation |
| **Symptom** | `curl http://example.com` returns 200 (should redirect to HTTPS) |

> 🟢 **Beginner Explanation:** You installed a secure door (TLS) at the front of the building but left the side entrance (HTTP port) open with no sign pointing to the front door. People can still walk in through the unsecured side.

---

## 2️⃣ Root Cause Explanation
- Configuring TLS in Ingress only **enables HTTPS** — it does NOT automatically redirect HTTP to HTTPS
- HTTP→HTTPS redirect must be explicitly configured via an annotation on the Ingress resource
- Without the redirect annotation, both HTTP and HTTPS work simultaneously
- **Components involved:** Ingress controller, TLS secret, HTTP redirect annotation

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm HTTP is accessible (it shouldn't be)
curl -v http://example.com
# 200 OK ← Should be 301/302 redirect to HTTPS

# Step 2: Confirm HTTPS works
curl -v https://example.com
# 200 OK ✅ — HTTPS is working

# Step 3: Check Ingress TLS and annotations
kubectl get ingress <name> -o yaml
# tls:
# - hosts: [example.com]
#   secretName: my-tls-secret    ← TLS configured ✅
# annotations:   ← Check this section
#   (no redirect annotation present!) ← Root cause

# Step 4: Add HTTP to HTTPS redirect annotation
# For nginx ingress controller:
# nginx.ingress.kubernetes.io/ssl-redirect: "true"

# Step 5: Apply fix
kubectl apply -f ingress.yaml

# Step 6: Verify redirect
curl -v http://example.com
# 308 Permanent Redirect → https://example.com ✅
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — TLS enabled but no HTTP redirect ❌
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
    # ❌ Missing redirect annotation!
spec:
  tls:
  - hosts:
    - example.com
    secretName: my-tls-secret
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```

```yaml
# AFTER — TLS + HTTP to HTTPS redirect ✅
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"          # ✅ Force HTTPS
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"    # ✅ Even behind proxies
spec:
  tls:
  - hosts:
    - example.com
    secretName: my-tls-secret
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```

---

## 5️⃣ Interview Answer Version

> *"TLS configuration in Ingress only enables HTTPS — it doesn't automatically redirect HTTP traffic. To enforce HTTPS, I add the annotation `nginx.ingress.kubernetes.io/ssl-redirect: 'true'` to the Ingress resource. This tells the nginx Ingress controller to respond to all HTTP requests with a 308 redirect to HTTPS. Without this annotation, both HTTP and HTTPS are accessible simultaneously."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Security audit finds all services accessible over plain HTTP despite TLS being configured. Compliance violation.
>
> **Root cause:** Team added TLS secrets and `spec.tls` but didn't know about the redirect annotation.
>
> **Resolution:** Added redirect annotation to all Ingress resources. Added to organization's Ingress template/Helm chart as a default. Added security scan to CI/CD to detect HTTP-accessible Ingress.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl describe ingress <name>` | See TLS config and annotations |
| `curl -v http://<host>` | Test for redirect response |
| `curl -v https://<host>` | Test HTTPS directly |
| `kubectl get secret <tls-secret> -o yaml` | Inspect TLS secret |
| `openssl s_client -connect <host>:443` | Test TLS certificate |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `ssl-redirect` vs `force-ssl-redirect`: `ssl-redirect` respects X-Forwarded-Proto header. `force-ssl-redirect` always redirects regardless of the header — use this when behind multiple proxies
- 🔍 TLS secrets must contain `tls.crt` and `tls.key` — check with `kubectl get secret <name> -o yaml`
- 🛡️ Use **cert-manager** to automate TLS certificate provisioning and renewal (Let's Encrypt)
- 🛡️ Add HSTS header annotation: `nginx.ingress.kubernetes.io/configuration-snippet: add_header Strict-Transport-Security "max-age=31536000"` for additional HTTP security

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is cert-manager and how does it help with TLS in Kubernetes?**
> cert-manager automates TLS certificate management — it requests, renews, and stores certificates (from Let's Encrypt, Vault, etc.) as Kubernetes Secrets. Annotations on Ingress trigger automatic certificate issuance.

**Q: What type of Kubernetes Secret stores TLS certificates?**
> `kubernetes.io/tls` type. Contains two keys: `tls.crt` (certificate) and `tls.key` (private key). Created manually or automatically by cert-manager.

---

## 🔟 Related Concepts to Revise
- Ingress TLS configuration
- nginx-ingress annotations
- cert-manager (Let's Encrypt integration)
- TLS/HTTPS fundamentals
- HSTS (HTTP Strict Transport Security)

---
---

# 🟡 Q33 — Path Rewrite Not Working

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Ingress path rewrite annotation is configured but the backend still receives the original path |
| **Where** | Ingress — path rewrite annotation with regex capture groups |
| **Symptom** | Backend receives `/api/users` instead of expected `/v1/users` |

> 🟢 **Beginner Explanation:** You set up call forwarding to translate "Extension 100" to "Extension 200". But the translation rule has a typo — it tries to forward Extension 1 (no capture of the rest). The translation never works.

---

## 2️⃣ Root Cause Explanation
- nginx Ingress path rewrite uses **regex capture groups** in the path definition
- If the path is defined without a capture group (e.g., `/api` instead of `/api(/|$)(.*)`), the rewrite target `/$1` has nothing to substitute
- Rewrite silently fails → original path is passed to the backend
- **Components involved:** nginx Ingress controller, `nginx.ingress.kubernetes.io/rewrite-target` annotation, regex capture groups

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Check backend logs — confirm it receives wrong path
kubectl logs <backend-pod>
# Request: GET /api/users  ← Should be /v1/users

# Step 2: Confirm client is sending correct path
curl -v https://example.com/api/users
# Client sends: /api/users ✅ — client is correct

# Step 3: Inspect Ingress configuration
kubectl get ingress <name> -o yaml
# annotations:
#   nginx.ingress.kubernetes.io/rewrite-target: /v1/$1
# spec:
#   rules:
#   - http:
#       paths:
#       - path: /api          ← ❌ No capture group!
#         pathType: Prefix

# Path "/api" has no capture group → $1 is empty
# Rewrite target: /v1/ (empty) = doesn't work as intended

# Step 4: Fix path to include capture group
# path: /api(/|$)(.*)  — captures everything after /api

# Step 5: Update rewrite-target to use captured group
# rewrite-target: /v1/$2  — $2 = captured path after /api

# Step 6: Apply and verify
kubectl apply -f ingress.yaml
curl https://example.com/api/users
# Backend receives: /v1/users ✅
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — No capture group, rewrite doesn't work ❌
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /v1/$1   # ❌ $1 is never captured!
spec:
  rules:
  - http:
      paths:
      - path: /api            # ❌ No capture group in path
        pathType: Prefix
```

```yaml
# AFTER — With capture group, rewrite works ✅
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /v1/$2   # ✅ $2 = captured path after /api
    nginx.ingress.kubernetes.io/use-regex: "true"         # ✅ Enable regex matching
spec:
  rules:
  - http:
      paths:
      - path: /api(/|$)(.*)   # ✅ Captures: $1=slash, $2=rest of path
        pathType: ImplementationSpecific
        backend:
          service:
            name: my-service
            port:
              number: 80
```

```
# How the rewrite works:
# Client: /api/users
# Regex captures: $1 = /, $2 = users
# Rewrite target: /v1/$2 = /v1/users ✅
# Backend receives: /v1/users
```

---

## 5️⃣ Interview Answer Version

> *"nginx Ingress path rewrite requires regex capture groups in the path definition. If the path is `/api` without a capture group, the rewrite target `$1` is empty and the rewrite silently fails. The fix is to use a proper regex path like `/api(/|$)(.*)` which captures the path after `/api` in `$2`, then set `rewrite-target: /v1/$2`. This correctly transforms `/api/users` to `/v1/users` at the Ingress layer."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** API versioning migration — `/api/*` should route to `/v2/*` internally. Users see broken responses.
>
> **Root cause:** Path defined as `/api` with `rewrite-target: /v2/$1`. No capture group means `$1` is empty. Backend receives `/v2/` for every request regardless of path.
>
> **Resolution:** Updated path to `/api(/|$)(.*)`, rewrite-target to `/v2/$2`. Added integration tests for path rewriting to CI pipeline.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl describe ingress <name>` | See annotations and rules |
| `kubectl logs <ingress-controller-pod> -n ingress-nginx` | nginx logs for path rewrite |
| `kubectl get ingress <name> -o yaml` | Full Ingress spec with annotations |
| `curl -v https://<host>/<path>` | Test rewritten path |
| `kubectl logs <backend-pod>` | Confirm what path backend receives |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Enable `use-regex: "true"` annotation when using regex in paths
- 🔍 Test regex patterns at [regex101.com](https://regex101.com) before applying to Ingress
- 🔍 `$1`, `$2` etc. correspond to capture groups in order — `()` in regex path = capture group
- 🛡️ Prefer named capture groups for clarity: `(?P<version>[^/]+)` but nginx Ingress uses numbered groups
- 🛡️ For complex routing, consider using Ingress annotations sparingly and moving to a service mesh (Istio VirtualService) for more powerful routing

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: How does nginx path rewriting work in Kubernetes Ingress?**
> The `rewrite-target` annotation defines the replacement path. The `path` field uses regex with capture groups `()`. When a request matches, the captured groups replace `$1`, `$2` etc. in the rewrite-target.

**Q: What is the difference between path rewrite and path redirect?**
> Rewrite: server-side — backend receives the rewritten path, client never knows (no URL change in browser). Redirect: client-side — server sends 301/302 response, client makes a new request to the new URL (URL changes in browser).

---

## 🔟 Related Concepts to Revise
- nginx Ingress annotations
- Regex capture groups
- Path rewrite vs redirect
- Ingress pathType (Prefix, Exact, ImplementationSpecific)
- Istio VirtualService for advanced routing

---
---

# 🟡 Q34 — Ingress 404 for /app Path

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Client requests `/app` but gets 404 from Ingress despite service being healthy |
| **Where** | Ingress — pathType configuration |
| **Symptom** | `curl https://example.com/app` returns 404 even though Ingress exists |

> 🟢 **Beginner Explanation:** You're looking for "Room App" but the building directory (Ingress) only accepts exact matches and lists "Room Application" — even though they're in the same wing. Since `app ≠ application`, the directory says "not found."

---

## 2️⃣ Root Cause Explanation
- Ingress path configured as `/application` with `pathType: Exact`
- Client requests `/app` — doesn't match `/application` exactly
- `Exact` pathType only matches that specific path string — not prefixes, not substrings
- **Components involved:** Ingress controller, pathType validation, HTTP request path matching

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Observe the 404
curl -v https://example.com/app
# 404 Not Found ← From Ingress

# Step 2: Inspect Ingress rules
kubectl get ingress <name> -o yaml
# paths:
# - path: /application        ← Configured path
#   pathType: Exact           ← Exact match only!
# Client requests: /app ← Doesn't match /application with Exact type

# Step 3: Identify root cause
# /app != /application → Exact match fails → 404

# Step 4: Fix: change path to /app AND change pathType to Prefix
# This allows /app, /app/dashboard, /app/settings etc.

# Step 5: Apply fix
kubectl apply -f ingress.yaml

# Step 6: Verify
curl https://example.com/app          # 200 OK ✅
curl https://example.com/app/login    # 200 OK ✅ (if pathType: Prefix)
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — Wrong path and too restrictive pathType ❌
spec:
  rules:
  - host: example.com
    http:
      paths:
      - path: /application    # ❌ Wrong path (client requests /app)
        pathType: Exact        # ❌ Exact — won't match /app/anything
        backend:
          service:
            name: app-service
            port:
              number: 80
```

```yaml
# AFTER — Correct path with Prefix type ✅
spec:
  rules:
  - host: example.com
    http:
      paths:
      - path: /app            # ✅ Matches client request
        pathType: Prefix       # ✅ Matches /app, /app/login, /app/dashboard
        backend:
          service:
            name: app-service
            port:
              number: 80
```

---

## 5️⃣ Interview Answer Version

> *"A 404 from Ingress for a specific path usually means the path rule doesn't match. I inspect the Ingress with `kubectl describe ingress` to compare configured paths against the client request. In this case, the path was `/application` with `pathType: Exact`, but clients requested `/app` — different strings. The fix is updating the path to `/app` and using `pathType: Prefix` to handle all sub-paths like `/app/login` and `/app/settings`."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Frontend app at `example.com/app`. Works fine at root (`/app`). All deep links (`/app/dashboard`) return 404.
>
> **Root cause:** `pathType: Exact` on `/app` — only the exact path `/app` matched. `/app/dashboard` didn't match.
>
> **Resolution:** Changed to `pathType: Prefix`. All sub-paths now route correctly.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl describe ingress <name>` | View path rules and pathType |
| `kubectl get ingress <name> -o yaml` | Full Ingress spec |
| `curl -v https://<host>/<path>` | Test specific path |
| `kubectl edit ingress <name>` | Quickly edit Ingress in-place |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 **pathType quick reference:**
  - `Exact` → `/app` matches ONLY `/app`
  - `Prefix` → `/app` matches `/app`, `/app/`, `/app/anything`
  - `ImplementationSpecific` → behavior depends on Ingress controller
- 🔍 Order of rules matters in Ingress — more specific paths should come before broader ones
- 🛡️ For SPAs (React, Angular, Vue): use `pathType: Prefix` on the root path and configure the backend to serve `index.html` for all routes

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: When should you use Exact vs Prefix pathType?**
> `Exact` for precise API endpoints where you don't want sub-paths to match (e.g., `/api/v1/health` exactly). `Prefix` for web applications where the frontend handles its own sub-routing (e.g., React SPA at `/app`).

**Q: How does Ingress handle multiple path rules for the same host?**
> Rules are evaluated in order. First matching rule wins. More specific paths should be listed before more general ones. A `/api/v2` rule should come before `/api` to prevent the shorter prefix from matching first.

---

## 🔟 Related Concepts to Revise
- Ingress pathType options
- Path matching order in Ingress
- SPA routing with Ingress
- Ingress host-based vs path-based routing

---
---

# 🟡 Q35 — Host-Based Routing to Wrong Service

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Requests to `admin.example.com` are served by the main app, not the admin app |
| **Where** | Ingress — host rule ordering |
| **Symptom** | Wrong content returned, no errors — silent misrouting |

> 🟢 **Beginner Explanation:** The building directory lists "Example Corp" before "Example Corp Admin" and uses a "starts with" match. When you ask for "Example Corp Admin," it matches "Example Corp" first and sends you to the wrong floor.

---

## 2️⃣ Root Cause Explanation
- When both `example.com` and `admin.example.com` rules use a catch-all path (`/`), the order matters
- If `example.com` rule appears first AND the Ingress controller uses prefix/partial host matching, `admin.example.com` can match the `example.com` rule
- **More specific (subdomain) rules must come BEFORE broader domain rules**
- **Components involved:** Ingress controller host matching logic, rule evaluation order

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Observe incorrect routing
curl https://admin.example.com
# Response from main app — "Welcome to Main App" ← Wrong!

# Step 2: Inspect Ingress rules
kubectl get ingress <name> -o yaml
# rules:
# - host: example.com         ← Listed FIRST
#   http:
#     paths:
#     - path: /
#       backend: main-service
# - host: admin.example.com   ← Listed SECOND
#   http:
#     paths:
#     - path: /
#       backend: admin-service
# First rule matches broader pattern first → admin traffic goes to main-service

# Step 3: Reorder rules — more specific FIRST
# admin.example.com must be BEFORE example.com

# Step 4: Apply fix
kubectl apply -f ingress.yaml

# Step 5: Verify
curl https://admin.example.com
# Response from admin app ✅
curl https://example.com
# Response from main app ✅
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — Broader rule first ❌
spec:
  rules:
  - host: example.com           # ❌ Broad rule first
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: main-service
            port:
              number: 80
  - host: admin.example.com     # ❌ Specific rule second — may never match
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: admin-service
            port:
              number: 80
```

```yaml
# AFTER — Specific rule first ✅
spec:
  rules:
  - host: admin.example.com     # ✅ More specific (subdomain) rule FIRST
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: admin-service
            port:
              number: 80
  - host: example.com           # ✅ Broader rule second
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: main-service
            port:
              number: 80
```

---

## 5️⃣ Interview Answer Version

> *"In a single Ingress with multiple host rules, more specific rules must come before broader ones. If `example.com` is listed before `admin.example.com` and both use the same catch-all path, requests to `admin.example.com` may match `example.com` first. The fix is reordering the Ingress rules — `admin.example.com` must appear before `example.com` in the rules list."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Multi-tenant platform. `tenant1.app.com` routes to wrong tenant's service. Tenant2 data visible to tenant1 users — potential data leak.
>
> **Root cause:** Wildcard or broad host rules before specific tenant rules.
>
> **Resolution:** Reordered Ingress rules — all specific tenant subdomain rules listed before any wildcard or catch-all rules. Added a CI check to validate Ingress rule ordering.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl describe ingress <name>` | See all host rules and their order |
| `curl -H "Host: admin.example.com" http://<ingress-ip>` | Test with explicit Host header |
| `kubectl get ingress <name> -o yaml` | Full Ingress spec |
| `kubectl edit ingress <name>` | Edit rules order in-place |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Test with `curl -H "Host: admin.example.com" http://<ingress-ip>` to bypass DNS and test routing directly
- 🔍 Use separate Ingress resources for separate domains/subdomains — avoids ordering issues and is easier to manage
- 🛡️ For large multi-tenant systems, use **IngressClass** or separate Ingress controllers per tenant
- 🛡️ Never share a single Ingress for security-sensitive services (admin vs user) in production — separate them

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: Can you have multiple Ingress resources for the same host?**
> Yes — Ingress resources are merged by the Ingress controller. Rules from multiple Ingress resources for the same host are combined. This can cause conflicts — use `IngressClass` and proper naming conventions to manage this.

**Q: How do you test Ingress routing without DNS?**
> Use `curl -H "Host: admin.example.com" http://<ingress-controller-ip>` — this sets the Host header manually, simulating a DNS-resolved request without actual DNS changes.

---

## 🔟 Related Concepts to Revise
- Ingress host-based routing
- IngressClass
- Wildcard hostnames in Ingress
- Multi-tenant Kubernetes patterns
- Separate Ingress resources vs combined rules

---
---

# 🟡 Q36 — ConfigMap Created but App Can't Read Values

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | ConfigMap exists with correct data but application crashes saying config is missing |
| **Where** | Deployment spec — missing ConfigMap reference |
| **Symptom** | App crashes on startup: "required configuration value is missing" |

> 🟢 **Beginner Explanation:** You wrote the office manual (ConfigMap) and stored it in the filing cabinet. But the new employee (pod) wasn't told where the cabinet is (no reference in deployment). They start work without any instructions and fail.

---

## 2️⃣ Root Cause Explanation
- Creating a ConfigMap does NOT automatically make it available to pods
- The deployment/pod spec must **explicitly reference** the ConfigMap via `envFrom`, `env.valueFrom`, or `volumeMount`
- Without the reference, the pod starts with no environment variables from that ConfigMap
- **Components involved:** ConfigMap object, Deployment spec, `envFrom`/`env.valueFrom`

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Observe app failure
kubectl get pods
# STATUS: CrashLoopBackOff

kubectl logs <pod-name>
# "Error: required config value DATABASE_URL is missing"

# Step 2: Verify ConfigMap exists and has the key
kubectl get configmap app-config
# EXISTS ✅
kubectl get configmap app-config -o yaml
# data:
#   DATABASE_URL: "postgres://..."   ← Key exists ✅

# Step 3: Check deployment — is ConfigMap referenced?
kubectl get deployment <name> -o yaml | grep -A10 envFrom
# (Nothing returned!) ← ConfigMap not referenced at all!

kubectl get deployment <name> -o yaml | grep configMap
# (Nothing) ← Root cause confirmed

# Step 4: Update deployment to reference ConfigMap
# Add envFrom section pointing to the ConfigMap

# Step 5: Apply fix
kubectl apply -f deployment.yaml

# Step 6: Verify
kubectl exec -it <new-pod> -- env | grep DATABASE_URL
# DATABASE_URL=postgres://...  ✅
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — ConfigMap not referenced ❌
spec:
  containers:
  - name: app
    image: myapp:v1
    # ❌ No envFrom or env.valueFrom referencing the ConfigMap!
```

```yaml
# AFTER — ConfigMap properly referenced ✅
spec:
  containers:
  - name: app
    image: myapp:v1
    envFrom:
    - configMapRef:
        name: app-config    # ✅ Inject ALL keys from ConfigMap as env vars
```

```yaml
# Alternative — Reference specific keys
spec:
  containers:
  - name: app
    image: myapp:v1
    env:
    - name: DATABASE_URL           # ✅ Specific env var name
      valueFrom:
        configMapKeyRef:
          name: app-config         # ConfigMap name
          key: DATABASE_URL        # Specific key from ConfigMap
```

```bash
kubectl apply -f deployment.yaml
kubectl rollout status deployment/<name>
kubectl exec -it <pod> -- env | grep DATABASE_URL
# DATABASE_URL=postgres://... ✅
```

---

## 5️⃣ Interview Answer Version

> *"Creating a ConfigMap is only half the work — the deployment must also reference it. When an app crashes saying config is missing, I verify the ConfigMap exists and has the correct keys, then check the deployment YAML for `envFrom` or `env.valueFrom` referencing the ConfigMap. If it's missing, I add the `envFrom: configMapRef:` section and redeploy. Kubernetes then injects all ConfigMap keys as environment variables into the container."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Config management was separated — one team owns ConfigMaps, another owns deployments. New ConfigMap created but deployment never updated to reference it.
>
> **Root cause:** Process gap — no coordination between teams.
>
> **Resolution:** Updated deployment to reference ConfigMap. Implemented GitOps — all related resources (ConfigMap + Deployment) must be in the same PR/commit.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get configmap <name> -o yaml` | Inspect ConfigMap keys and values |
| `kubectl get deployment <name> -o yaml` | Check for envFrom references |
| `kubectl exec -it <pod> -- env` | List all env vars inside container |
| `kubectl exec -it <pod> -- env \| grep <KEY>` | Check specific env var |
| `kubectl describe pod <name>` | See environment section for each container |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 `kubectl describe pod <name>` shows the Environment section — you can see which env vars are set and from where
- 🔍 `envFrom` injects ALL keys from a ConfigMap. `env.valueFrom.configMapKeyRef` injects specific keys — use specific keys for clarity in large ConfigMaps
- 🛡️ Use Helm or Kustomize to bundle ConfigMap + Deployment together — reduces risk of forgetting to reference ConfigMap
- 🛡️ Consider using External Secrets Operator or Vault Agent for production secrets management

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between envFrom and env.valueFrom?**
> `envFrom` injects ALL keys from a ConfigMap or Secret as environment variables. `env.valueFrom.configMapKeyRef` injects a specific single key, allowing you to rename it as a different environment variable name in the container.

**Q: How would you inject ConfigMap data as a file instead of env vars?**
> Mount the ConfigMap as a volume. Each key becomes a file, the value becomes the file content. Useful for config files like `nginx.conf`, `application.properties`.

---

## 🔟 Related Concepts to Revise
- ConfigMap creation and usage patterns
- envFrom vs env.valueFrom
- Volume mounts for ConfigMaps
- Deployment spec: env, envFrom sections
- kubectl describe pod environment section

---
---

# 🟡 Q37 — Env Vars from ConfigMap Not Appearing

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Pod starts successfully but expected env vars from ConfigMap are empty/missing |
| **Where** | Namespace mismatch between ConfigMap and Deployment |
| **Symptom** | `kubectl exec -it <pod> -- env` shows missing variables. No pod errors. |

> 🟢 **Beginner Explanation:** The filing cabinet (ConfigMap) is on Floor 1 (default namespace). The employee (pod) works on Floor 2 (prod namespace). Floor 2 employees can't access Floor 1 cabinets — different floors, different access.

---

## 2️⃣ Root Cause Explanation
- ConfigMaps are **namespace-scoped** resources — a ConfigMap in namespace A cannot be referenced by a pod in namespace B
- Pod starts without error (Kubernetes doesn't fail loudly for cross-namespace references — it just doesn't find the ConfigMap)
- env vars are simply absent
- **Components involved:** Kubernetes namespace scoping, ConfigMap, Deployment/Pod spec

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm pod is running but env vars are missing
kubectl exec -it <pod-name> -n prod -- env | grep MY_CONFIG_KEY
# (Nothing returned) ← env var missing

# Step 2: Verify ConfigMap exists (but which namespace?)
kubectl get configmap app-config
# (Not found in current namespace context)

kubectl get configmap app-config -n default
# Found! ← ConfigMap is in 'default' namespace

# Step 3: Check which namespace the pod/deployment is in
kubectl get pod <name> -n prod
# Pod is in 'prod' namespace

# Step 4: Root cause confirmed
# ConfigMap in 'default', Deployment in 'prod' — cross-namespace reference → fails silently

# Step 5: Create ConfigMap in the SAME namespace as deployment
kubectl get configmap app-config -n default -o yaml > app-config.yaml
# Edit the namespace field to 'prod'
kubectl apply -f app-config.yaml -n prod

# Step 6: Restart pods to pick up new ConfigMap
kubectl rollout restart deployment/<name> -n prod

# Step 7: Verify
kubectl exec -it <new-pod> -n prod -- env | grep MY_CONFIG_KEY
# MY_CONFIG_KEY=my-value ✅
```

---

## 4️⃣ Fix / Resolution

```bash
# Export ConfigMap from default namespace
kubectl get configmap app-config -n default -o yaml | \
  sed 's/namespace: default/namespace: prod/' | \
  kubectl apply -f -

# Verify ConfigMap now in prod namespace
kubectl get configmap app-config -n prod
# EXISTS ✅

# Restart deployment to reload env vars
kubectl rollout restart deployment/<name> -n prod
```

```yaml
# Create ConfigMap directly in correct namespace
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: prod    # ✅ Must match the deployment's namespace
data:
  DATABASE_URL: "postgres://prod-db:5432/mydb"
  APP_ENV: "production"
```

---

## 5️⃣ Interview Answer Version

> *"When env vars from a ConfigMap are missing with no errors, my first suspect is namespace mismatch — ConfigMaps are namespace-scoped. I check which namespace the ConfigMap is in vs where the pod runs. If they're different, I create a copy of the ConfigMap in the pod's namespace and restart the deployment. ConfigMaps in namespace A are invisible to pods in namespace B — Kubernetes doesn't throw an error, the env vars just don't appear."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** App promoted from staging to production namespace. All other services migrated but ConfigMap wasn't copied to prod namespace.
>
> **Symptoms:** Pod started (no crash), but app behaved incorrectly — using default fallback values instead of real config.
>
> **Resolution:** Created ConfigMap in prod namespace. Updated CI/CD pipeline to create ConfigMaps in all target namespaces during namespace setup.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get configmap -n <namespace>` | List ConfigMaps in specific namespace |
| `kubectl get configmap <name> -n <ns> -o yaml` | Export ConfigMap |
| `kubectl exec -it <pod> -- env` | Check env vars inside container |
| `kubectl describe pod <name>` | Check environment section and any warnings |
| `kubectl config set-context --current --namespace=<ns>` | Change default namespace |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Kubernetes does NOT error if a referenced ConfigMap doesn't exist in the pod's namespace — env vars are just silently absent. This is a common hidden bug.
- 🔍 Check `kubectl describe pod` — under "Environment" section, if it shows `<set to the key 'key' of configmap 'name'>  Optional: false` and the pod is running but var is empty — it's a namespace issue
- 🛡️ Use **Kustomize** with namespace overlays to ensure all resources (ConfigMaps, Secrets, Deployments) are created in the correct namespace consistently
- 🛡️ Use **External Secrets Operator** for centralized secret/config management across namespaces

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: Which Kubernetes resources are namespace-scoped vs cluster-scoped?**
> Namespace-scoped: Pods, Deployments, ConfigMaps, Secrets, Services, PVCs, ServiceAccounts. Cluster-scoped: Nodes, PersistentVolumes, ClusterRoles, ClusterRoleBindings, Namespaces, StorageClasses.

**Q: How can you share a ConfigMap across namespaces?**
> You can't — directly. Options: (1) Create copies in each namespace (2) Use External Secrets Operator or Vault to sync (3) Mount a shared NFS/PVC volume with config files (4) Use a dedicated config service API.

---

## 🔟 Related Concepts to Revise
- Kubernetes namespace scoping
- ConfigMap and Secret namespace awareness
- Kustomize namespace overlays
- External Secrets Operator
- Multi-namespace application patterns

---
---

# 🟡 Q38 — ConfigMap Volume Mount — File Missing

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | ConfigMap mounted as volume but application can't find the config file |
| **Where** | Volume mount — subPath configuration |
| **Symptom** | App error: "config file /etc/config/app.yaml not found" |

> 🟢 **Beginner Explanation:** You asked for the document "report.pdf" to be placed on your desk. Instead, a folder named "report.pdf" was placed there, with the actual file inside it. You reach for the file but grab the folder instead.

---

## 2️⃣ Root Cause Explanation
- When mounting a ConfigMap as a volume **without `subPath`**, Kubernetes creates a **directory** at the mountPath
- Each ConfigMap key becomes a file inside that directory
- So if you mount to `/etc/config/app.yaml`, Kubernetes creates a directory named `app.yaml` — not a file
- The actual file is at `/etc/config/app.yaml/app.yaml` — one level deeper than expected
- **Components involved:** ConfigMap volume mount, `subPath`, kubelet volume manager

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm app failure
kubectl logs <pod-name>
# "config file /etc/config/app.yaml not found"

# Step 2: Verify ConfigMap has the key
kubectl get configmap app-config -o yaml
# data:
#   app.yaml: |
#     database:
#       host: postgres    ← Key exists ✅

# Step 3: Check what was actually mounted inside the container
kubectl exec -it <pod-name> -- ls -la /etc/config/
# drwxr-xr-x  app.yaml/   ← It's a DIRECTORY, not a file!

kubectl exec -it <pod-name> -- ls -la /etc/config/app.yaml/
# -rw-r--r--  app.yaml    ← Actual file is one level deeper!

# Step 4: Root cause — no subPath used, Kubernetes created directory

# Step 5: Fix — add subPath to mount a specific key as a file
kubectl apply -f deployment.yaml  (with subPath added)

# Step 6: Verify
kubectl exec -it <pod-name> -- ls -la /etc/config/
# -rw-r--r--  app.yaml    ← Now it's a FILE ✅
```

---

## 4️⃣ Fix / Resolution

```yaml
# BEFORE — Without subPath (creates directory, not file) ❌
spec:
  volumes:
  - name: config-volume
    configMap:
      name: app-config

  containers:
  - name: app
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config/app.yaml    # ❌ Creates DIRECTORY named app.yaml
```

```yaml
# AFTER — With subPath (mounts specific key as a single file) ✅
spec:
  volumes:
  - name: config-volume
    configMap:
      name: app-config

  containers:
  - name: app
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config/app.yaml    # ✅ This path will be a FILE
      subPath: app.yaml                  # ✅ Key name from ConfigMap to mount as file
```

```bash
kubectl apply -f deployment.yaml
kubectl exec -it <pod> -- file /etc/config/app.yaml
# /etc/config/app.yaml: ASCII text ✅ — it's a file now!
```

---

## 5️⃣ Interview Answer Version

> *"Without `subPath`, mounting a ConfigMap creates a directory at the mountPath — not a file. Each ConfigMap key becomes a file inside that directory. So `/etc/config/app.yaml` becomes a directory containing `app.yaml`. The fix is adding `subPath: app.yaml` to the volumeMount — this tells Kubernetes to mount just that specific key directly as the file at the specified path."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** nginx container configured with custom nginx.conf from ConfigMap. nginx fails to start — "nginx.conf is a directory, not a file."
>
> **Root cause:** `mountPath: /etc/nginx/nginx.conf` without `subPath` created a directory named `nginx.conf`.
>
> **Resolution:** Added `subPath: nginx.conf` to the volumeMount. nginx now reads the file correctly.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl exec -it <pod> -- ls -la <mountPath>` | Check if mounted path is file or directory |
| `kubectl exec -it <pod> -- cat <mountPath>` | Read mounted file content |
| `kubectl get configmap <name> -o yaml` | Inspect ConfigMap keys |
| `kubectl describe pod <name>` | See volume mount configuration |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 **Key rule:** Mounting ConfigMap to a directory path (no `subPath`) → creates directory with key-named files. Using `subPath` → mounts single key as a file at exact path.
- 🔍 **`subPath` limitation:** When using `subPath`, ConfigMap updates do NOT automatically reflect in the mounted file — you must restart the pod.
- 🔍 Without `subPath` (directory mount) — ConfigMap updates DO reflect automatically after a short delay (~60s)
- 🛡️ For config files that change frequently, use directory mount (no subPath) + configure app to watch/reload the file

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: What is the difference between mounting a ConfigMap as envFrom vs as a volume?**
> `envFrom` injects keys as env variables — only available at pod start, doesn't update dynamically. Volume mount makes keys available as files — directory mounts update automatically when ConfigMap changes (but subPath mounts don't).

**Q: When does a ConfigMap change reflect in a running pod?**
> For volume-mounted ConfigMaps (without subPath): changes reflect within ~60 seconds (kubelet sync period). For env vars (envFrom): changes NEVER reflect — pod must be restarted. For subPath mounts: changes NEVER reflect — pod must be restarted.

---

## 🔟 Related Concepts to Revise
- ConfigMap volume mounts
- subPath in volume mounts
- Dynamic config updates in Kubernetes
- kubelet configmap sync period
- nginx/app config file patterns in Kubernetes

---
---

# 🔴 Q39 — Secret Injected but DB Auth Fails

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | Pod starts, env vars are set, but database authentication fails |
| **Where** | Kubernetes Secret — stale/outdated credential value |
| **Symptom** | App error: "authentication failed for user: wrong password" |

> 🟢 **Beginner Explanation:** The employee's access badge (Secret) is in the system, but the building's lock (database) was re-keyed last week. The badge has the old code — it doesn't work anymore.

---

## 2️⃣ Root Cause Explanation
- Kubernetes Secret stores the value it was given when created — it does NOT automatically sync with external systems
- If the database password was changed (by DBA, rotation policy, cloud provider), the Kubernetes Secret still holds the **old password**
- Pod uses the old password → DB rejects authentication
- **Components involved:** Kubernetes Secrets, database, external secret management

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Confirm app is running but DB auth fails
kubectl get pods   # Running ✅
kubectl logs <pod-name>
# "authentication failed for user: myapp_user"

# Step 2: Check env var value inside container
kubectl exec -it <pod-name> -- env | grep DB_PASSWORD
# DB_PASSWORD=OldPassword123   ← Container has a value

# Step 3: Decode and inspect the Kubernetes Secret
kubectl get secret db-credentials -o yaml
# data:
#   password: T2xkUGFzc3dvcmQxMjM=   ← base64 encoded

echo "T2xkUGFzc3dvcmQxMjM=" | base64 -d
# OldPassword123   ← Secret stores OLD password!

# Step 4: Confirm DB password was changed externally
# Ask DBA / Check cloud console / Check password rotation logs

# Step 5: Update Secret with new password
kubectl create secret generic db-credentials \
  --from-literal=password=NewSecurePassword456 \
  --dry-run=client -o yaml | kubectl apply -f -

# Step 6: Restart pod to pick up new Secret value
kubectl rollout restart deployment/<name>

# Step 7: Verify
kubectl exec -it <new-pod> -- env | grep DB_PASSWORD
# DB_PASSWORD=NewSecurePassword456 ✅
kubectl logs <new-pod>
# "Database connected successfully" ✅
```

---

## 4️⃣ Fix / Resolution

```bash
# Update Kubernetes Secret with new DB password
kubectl create secret generic db-credentials \
  --from-literal=username=myapp_user \
  --from-literal=password=NewSecurePassword456 \
  --dry-run=client -o yaml | kubectl apply -f -

# Restart deployment to inject new secret values
kubectl rollout restart deployment/my-app

# Verify new password is in container
kubectl exec -it $(kubectl get pod -l app=my-app -o jsonpath='{.items[0].metadata.name}') \
  -- env | grep DB_PASSWORD
# DB_PASSWORD=NewSecurePassword456 ✅
```

```yaml
# Long-term: Use External Secrets Operator to sync from Vault/AWS Secrets Manager
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: db-credentials
spec:
  refreshInterval: 1h              # ✅ Auto-sync every hour
  secretStoreRef:
    name: vault-backend
    kind: SecretStore
  target:
    name: db-credentials
  data:
  - secretKey: password
    remoteRef:
      key: secret/myapp/db
      property: password
```

---

## 5️⃣ Interview Answer Version

> *"DB auth failure with valid env vars means the value injected is wrong — not missing. I decode the Kubernetes Secret with `kubectl get secret -o yaml` and base64 decode the password. If it's the old password, the DB was rotated externally without updating the Secret. Fix: update the Secret with the new credentials and restart the pods. Long-term: implement External Secrets Operator to auto-sync from Vault or AWS Secrets Manager so Kubernetes Secrets stay current."*

---

## 6️⃣ Real-World Scenario Example

> **Scenario:** Production outage at 2 AM. DB password was rotated by security team as part of 90-day rotation policy. App team wasn't notified.
>
> **Alert:** DB connection errors spike. Pod logs: "FATAL: password authentication failed."
>
> **Resolution:** Updated Kubernetes Secret immediately. Implemented External Secrets Operator with AWS Secrets Manager. Added notification workflow when secrets are rotated.

---

## 7️⃣ kubectl Commands Cheat Sheet

| Command | Purpose |
|---------|---------|
| `kubectl get secret <name> -o yaml` | View base64-encoded secret data |
| `echo <base64> \| base64 -d` | Decode secret value |
| `kubectl exec -it <pod> -- env \| grep <VAR>` | Check env var value in container |
| `kubectl create secret generic ... --dry-run=client -o yaml \| kubectl apply -f -` | Update secret safely |
| `kubectl rollout restart deployment/<name>` | Force pods to pick up new secret |

---

## 8️⃣ Advanced Debugging Tips

- 🔍 Secrets injected as env vars are only loaded at pod start — updating the Secret requires pod restart
- 🔍 Secrets mounted as volumes DO auto-update (after ~60s kubelet sync) — but env var-based injection doesn't
- 🛡️ **Production best practice:** Use External Secrets Operator (ESO) with Vault or AWS Secrets Manager — automatic rotation sync
- 🛡️ Never store actual passwords in Git — use Sealed Secrets or SOPS for GitOps-compatible secret management
- 🛡️ Implement secret rotation testing as part of your disaster recovery drills

---

## 9️⃣ Common Follow-Up Interview Questions

**Q: How are Kubernetes Secrets stored and are they secure?**
> Secrets are stored in etcd as base64-encoded values (NOT encrypted by default — base64 is encoding, not encryption). For production, enable etcd encryption at rest and use RBAC to restrict Secret access.

**Q: What is External Secrets Operator?**
> A Kubernetes operator that syncs secrets from external secret management systems (AWS Secrets Manager, HashiCorp Vault, GCP Secret Manager) into Kubernetes Secrets. Supports automatic refresh intervals for rotation.

**Q: How would you handle automatic secret rotation in Kubernetes?**
> Use ESO with a short refresh interval. Configure the application to detect connection failures and reconnect (connection pooling with retry). Alternatively, mount secrets as volumes (auto-update) and configure app to reload credentials periodically.

---

## 🔟 Related Concepts to Revise
- Kubernetes Secrets (types, encoding)
- External Secrets Operator
- HashiCorp Vault integration
- AWS Secrets Manager / GCP Secret Manager
- Secret rotation patterns
- Sealed Secrets for GitOps

---
---

# 🟡 Q40 — ConfigMap Update Not Reflected in All Pods

## 1️⃣ Issue Summary
| Field | Detail |
|-------|--------|
| **What** | ConfigMap updated, some pods use new values, others still use old values |
| **Where** | Pod lifecycle — env vars are loaded at startup only |
| **Symptom** | Inconsistent application behavior — different pods show different feature states |

> 🟢 **Beginner Explanation:** You updated the company policy manual (ConfigMap). New employees hired today got the new manual. Existing employees still follow the old manual they received when they joined — nobody re-distributed the updated version to them.

---

## 2️⃣ Root Cause Explanation
- Environment variables from ConfigMaps are loaded **once at pod startup**
- Running pods **never see ConfigMap updates** — their env vars are frozen at the time they started
- New pods (recently created/restarted) get the updated ConfigMap values
- This creates a **split-brain** situation in a deployment with mixed-age pods
- **Components involved:** kubelet, ConfigMap, container environment variable lifecycle

---

## 3️⃣ Step-by-Step Troubleshooting Approach

```bash
# Step 1: Observe inconsistent behavior
# Some pods show new feature ON, others show OFF

# Step 2: Check pod ages
kubectl get pods
# NAME              READY   AGE
# app-pod-aaaa     1/1     2d      ← Old pod (2 days)
# app-pod-bbbb     1/1     2d      ← Old pod
# app-pod-cccc     1/1     5m      ← New pod (5 minutes)

# Step 3: Compare env var values between pods
kubectl exec -it app-pod-aaaa -- env | grep FEATURE_FLAG
# FEATURE_FLAG=false   ← Old value!

kubectl exec -it app-pod-cccc -- env | grep FEATURE_FLAG
# FEATURE_FLAG=true    ← New value ✅

# Step 4: Confirm ConfigMap has the new value
kubectl get configmap app-config -o yaml | grep FEATURE_FLAG
# FEATURE_FLAG: "true"   ← ConfigMap is updated ✅

# Step 5: Root cause

