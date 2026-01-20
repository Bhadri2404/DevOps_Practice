# Kubernetes ReplicaSets - Revision Guide

## 📝 Table of Contents
1. [Pod Creation Basics](#pod-creation-basics)
2. [Scaling ReplicaSets](#scaling-replicasets)
3. [Essential Commands Reference](#essential-commands-reference)
4. [Practical Workflow Examples](#practical-workflow-examples)
5. [Key Concepts & Notes](#key-concepts--notes)

---

## Pod Creation Basics

### Generate Pod YAML Without Creating It

```bash
kubectl run redis --image=redis123 --dry-run=client -o yaml >> pod.yaml
```

**📌 Notes:**
- `--dry-run=client` - Simulates the creation without actually creating the object
- `-o yaml` - Outputs the configuration in YAML format
- `>>` - Appends output to file (use `>` to overwrite)
- **Use Case:** Generate YAML templates quickly without manual writing
- **Pro Tip:** Always verify the generated YAML before applying it

---

## Scaling ReplicaSets

### Method 1: Scale Using Definition File

```bash
kubectl scale --replicas=6 -f replicaset-definition.yaml
```

**📌 Notes:**
- Scales the ReplicaSet defined in the YAML file
- Does **NOT** update the file itself (file remains unchanged)
- Temporary scaling - if you re-apply the original file, it reverts

### Method 2: Scale Using ReplicaSet Name

```bash
kubectl scale --replicas=6 replicaset/myapp-replicaset
```

**📌 Notes:**
- Direct scaling by ReplicaSet name
- Format: `replicaset/<name>` or shorthand `rs/<name>`
- Faster when you know the exact name
- **Pro Tip:** Use `kubectl get rs` to find the exact name first

### Method 3: Scale by Editing the ReplicaSet

```bash
kubectl edit rs new-replica-set
```

**📌 Notes:**
- Opens the ReplicaSet definition in your default editor (usually `vi`)
- Change the `replicas` field and save
- Changes are applied immediately
- **Permanent change** in the cluster (but not in your local YAML files)

---

## Essential Commands Reference

| Command | Description | Example |
|---------|-------------|---------|
| `kubectl create -f <file>` | Create an object from a YAML/JSON file | `kubectl create -f pod.yaml` |
| `kubectl get replicationcontroller` | List all replication controllers (old) | `kubectl get rc` |
| `kubectl get replicaset` | List all ReplicaSets | `kubectl get rs` |
| `kubectl get pods` | List all Pods in current namespace | `kubectl get pods` |
| `kubectl delete replicaset <name>` | Delete a ReplicaSet by name | `kubectl delete rs myapp-rs` |
| `kubectl replace -f <file>` | Update existing object using definition | `kubectl replace -f rs. yaml` |
| `kubectl scale --replicas=<n>` | Scale object to specified number | `kubectl scale rs myapp --replicas=3` |
| `kubectl describe rs <name>` | Show detailed info about ReplicaSet | `kubectl describe rs myapp-rs` |
| `kubectl edit rs <name>` | Edit ReplicaSet in default editor | `kubectl edit rs myapp-rs` |

**📌 Command Shortcuts:**
- `rs` = `replicaset`
- `rc` = `replicationcontroller`
- `po` = `pods`
- `svc` = `service`
- `deploy` = `deployment`

---

## Practical Workflow Examples

### 🔍 Scenario 1: Initial State Inspection

```bash
# Check current pods
kubectl get pods

# Check current ReplicaSets
kubectl get replicaset
```

**📌 What to look for:**
- Number of pods running
- ReplicaSet names and their desired/current/ready counts
- Pod status (Running, Pending, CrashLoopBackOff, etc.)

---

### 🔍 Scenario 2: Verify ReplicaSet Changes

```bash
# List all ReplicaSets
kubectl get replicaset

# Get detailed information about a specific ReplicaSet
kubectl describe replicaset new-replica-set
```

**📌 Notes:**
- `describe` shows events, conditions, and full configuration
- Check **Replicas** section:  Desired vs Current vs Ready
- Review **Events** section for errors or warnings

---

### 🔍 Scenario 3: Troubleshooting Pod Errors

```bash
# Describe a specific pod to check errors
kubectl describe pod new-replica-set-7r2qw
```

**📌 What to check:**
- **Image:** Is the image name correct?
- **Events:** Look for "ImagePullBackOff", "CrashLoopBackOff", etc.
- **Containers:** Check container status and restart count
- **Logs:** Use `kubectl logs <pod-name>` for application logs

**Common Image Errors:**
- `ImagePullBackOff` - Image doesn't exist or wrong tag
- `ErrImagePull` - Network issue or registry authentication problem

---

### 🔄 Scenario 4: ReplicaSet Self-Healing Demo

```bash
# Delete a pod manually
kubectl delete pod new-replica-set-wkzjh

# Immediately check pods
kubectl get pods
```

**📌 Notes:**
- ReplicaSet **automatically creates** a replacement pod
- This demonstrates Kubernetes' self-healing capability
- The new pod will have a different random suffix
- **Key Concept:** ReplicaSet maintains the desired state (replica count)

---

### 📝 Scenario 5: Creating ReplicaSets from YAML

```bash
# Attempt to create ReplicaSets (may have errors)
kubectl create -f /root/replicaset-definition-1.yaml
kubectl create -f /root/replicaset-definition-2.yaml
```

**📌 Common YAML Errors:**
- **apiVersion mismatch** - Should be `apps/v1` for ReplicaSet
- **Missing selector** - `selector. matchLabels` must match `template.metadata.labels`
- **Indentation errors** - YAML is whitespace-sensitive (use 2 spaces)
- **Wrong kind** - Should be `ReplicaSet`, not `ReplicationController`

**Example of correct ReplicaSet YAML:**

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name:  myapp-replicaset
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
      - name:  nginx
        image: nginx:1.14. 2
```

---

### 🗑️ Scenario 6: Cleanup ReplicaSets

```bash
# Delete ReplicaSets by name
kubectl delete rs replicaset-1
kubectl delete rs replicaset-2
```

**📌 Notes:**
- Deleting a ReplicaSet **also deletes all its pods**
- To delete ReplicaSet but keep pods:  `kubectl delete rs <name> --cascade=orphan`
- Alternative: `kubectl delete -f <file>` deletes objects defined in file

---

### 🔧 Scenario 7: Update Image in Running ReplicaSet

```bash
# Edit the ReplicaSet configuration
kubectl edit rs new-replica-set
```

**📌 Steps:**
1. Command opens the ReplicaSet in an editor
2. Find the `image: ` field under `spec.template.spec. containers`
3. Change the image (e.g., from `redis123` to `redis`)
4. Save and exit (`:wq` in vi)

**⚠️ Important:**
- Changing the image **does NOT** automatically update existing pods
- Only **new pods** will use the new image
- Existing pods keep running with the old image

---

### 🔄 Scenario 8: Force Pod Recreation with New Image

```bash
# Delete all old pods to force recreation
kubectl delete pod new-replica-set-vpkh8 new-replica-set-tn2mp new-replica-set-7r2qw
```

**📌 Notes:**
- After editing the ReplicaSet, you must delete old pods
- ReplicaSet creates new pods with the updated image
- **Alternative:** Use Deployments for rolling updates (better practice)
- Can delete all pods at once or one at a time (causes brief downtime)

**Better Alternative (using label selector):**
```bash
kubectl delete pods -l app=myapp
```

---

### 📈 Scenario 9: Scale ReplicaSet Up

```bash
# Scale to 5 replicas
kubectl scale rs new-replica-set --replicas=5

# Verify the scaling
kubectl get pods
```

**📌 Notes:**
- New pods are created immediately
- Pods are spread across available nodes
- All pods use the same template from the ReplicaSet

---

### 📉 Scenario 10: Scale ReplicaSet Down

```bash
# Edit and change replicas field
kubectl edit rs new-replica-set
```

**📌 Notes:**
- Kubernetes terminates excess pods gracefully
- Newest pods are typically terminated first
- Scaling down to 0 keeps the ReplicaSet but removes all pods

---

## Key Concepts & Notes

### 🎯 What is a ReplicaSet? 

A ReplicaSet ensures that a specified number of pod replicas are running at any given time. 

**Key Features:**
- **Self-healing:** Replaces failed pods automatically
- **Scaling:** Easy horizontal scaling up/down
- **Label selectors:** Uses labels to identify pods it manages
- **Pod template:** Defines how new pods should be created

---

### 🔑 ReplicaSet vs ReplicationController

| Feature | ReplicationController | ReplicaSet |
|---------|----------------------|------------|
| API Version | `v1` | `apps/v1` |
| Selector Type | Equality-based only | Set-based (more flexible) |
| Status | Legacy (old) | Current standard |
| Used By | - | Deployments |
| Recommendation | ❌ Avoid | ✅ Use this |

**📌 Note:** Always use ReplicaSets or Deployments (which use ReplicaSets internally)

---

### 🎨 Label Selectors - Critical Concept

**The Rule:** `selector.matchLabels` **MUST** match `template.metadata.labels`

```yaml
spec:
  selector:
    matchLabels: 
      app: myapp        # ← These must match
  template:
    metadata:
      labels:
        app: myapp      # ← These must match
```

**📌 Why?**
- ReplicaSet uses selectors to find which pods it manages
- If labels don't match, ReplicaSet won't manage the pods
- Can lead to orphaned pods or duplicate pods

---

### 🔄 ReplicaSet vs Deployment

| When to Use | ReplicaSet | Deployment |
|-------------|-----------|------------|
| Simple pod replication | ✅ | ✅ |
| Rolling updates | ❌ | ✅ |
| Rollback capability | ❌ | ✅ |
| Update strategy control | ❌ | ✅ |
| **Recommended for production** | ❌ | ✅ |

**📌 Best Practice:**
- Use **Deployments** in production (they create ReplicaSets automatically)
- Use **ReplicaSets** directly only for learning or special cases

---

### ⚡ Quick Troubleshooting Checklist

**Pod not starting? **
1. ✅ Check image name:  `kubectl describe pod <name>`
2. ✅ Check events: `kubectl get events`
3. ✅ Check logs: `kubectl logs <pod-name>`
4. ✅ Verify resources: Does the cluster have capacity?

**ReplicaSet not creating pods?**
1. ✅ Check selector matches labels
2. ✅ Verify YAML syntax:  `kubectl apply --dry-run=client -f file.yaml`
3. ✅ Check ReplicaSet events:  `kubectl describe rs <name>`

**Scaling not working?**
1. ✅ Check current replica count:  `kubectl get rs`
2. ✅ Verify command syntax
3. ✅ Check cluster resources (nodes might be full)

---

### 💡 Pro Tips & Best Practices

1. **Always use `--dry-run=client`** when testing commands
   ```bash
   kubectl create -f file.yaml --dry-run=client
   ```

2. **Use labels consistently** for easy management
   ```bash
   kubectl get pods -l app=myapp
   kubectl delete pods -l app=myapp
   ```

3. **Check resource usage** before scaling
   ```bash
   kubectl top nodes
   kubectl top pods
   ```

4. **Use `kubectl explain`** to understand fields
   ```bash
   kubectl explain replicaset. spec
   kubectl explain replicaset.spec. selector
   ```

5. **Save your YAML files** in version control (Git)

6. **Use Deployments** instead of ReplicaSets directly for production

7. **Watch resources in real-time**
   ```bash
   kubectl get pods -w
   kubectl get rs -w
   ```

8. **Use descriptive names** for easy identification
   - ✅ `frontend-replicaset`
   - ❌ `rs-1`

---

## 📚 Additional Useful Commands

```bash
# Get all resources in namespace
kubectl get all

# Get ReplicaSet in YAML format
kubectl get rs <name> -o yaml

# Get ReplicaSet in JSON format
kubectl get rs <name> -o json

# Get ReplicaSet with more details
kubectl get rs -o wide

# Watch pods being created/deleted in real-time
kubectl get pods --watch

# Get pods with their labels
kubectl get pods --show-labels

# Filter pods by label
kubectl get pods -l app=myapp

# Get events sorted by timestamp
kubectl get events --sort-by='. lastTimestamp'

# Export current ReplicaSet to file
kubectl get rs <name> -o yaml > backup-rs.yaml
```

---

## 🎓 Exam/Interview Quick Reference

**Remember these key points:**

1. **ReplicaSet Purpose:** Maintain desired number of pod replicas
2. **Self-healing:** Automatically replaces failed pods
3. **Scaling Methods:** 
   - `kubectl scale`
   - `kubectl edit`
   - `kubectl replace -f`
4. **Label matching is mandatory:** selector = template labels
5. **Image updates require pod deletion** (or use Deployments)
6. **API Version:** `apps/v1`
7. **Kind:** `ReplicaSet`
8. **Preferred:** Use Deployments in production

---

## ✅ Revision Checklist

- [ ] Can create a ReplicaSet from YAML
- [ ] Understand label selectors and matching
- [ ] Know 3 ways to scale a ReplicaSet
- [ ] Can troubleshoot pod creation failures
- [ ] Understand self-healing behavior
- [ ] Know how to update images in ReplicaSet
- [ ] Can use `describe` and `get` commands effectively
- [ ] Understand difference between ReplicaSet and Deployment
- [ ] Know when to use `--dry-run=client`
- [ ] Can delete and clean up resources properly

---

**📅 Last Updated:** 2026-01-20  
**👤 Created by:** Vinay-R_PWSCLLC

---

**Good luck with your Kubernetes learning!  🚀**
