# Kubernetes ReplicaSets - Revision Notes

---

## Basic Commands

### Generate Pod YAML (Dry Run)
```bash
kubectl run redis --image=redis123 --dry-run=client -o yaml >> pod.yaml
```
**📝 Notes:**
- Creates a pod YAML file without actually creating the pod
- `--dry-run=client` = don't create, just test
- `-o yaml` = output in YAML format
- `>>` = append to file

---

## Scaling ReplicaSets

### Scale using file
```bash
kubectl scale --replicas=6 -f replicaset-definition.yaml
```
**📝 Notes:**
- Scales the ReplicaSet from the YAML file
- Does NOT update the file itself

### Scale using ReplicaSet name
```bash
kubectl scale --replicas=6 replicaset/myapp-replicaset
```
**📝 Notes:**
- Direct scaling by name
- Faster method

---

## Essential Commands Reference

| Command | Description |
|---------|-------------|
| `kubectl create -f <definition-file>` | Create an object from a file |
| `kubectl get replicationcontroller` | List all replication controllers |
| `kubectl get replicaset` | List all ReplicaSets |
| `kubectl get pods` | List all Pods |
| `kubectl delete replicaset <name>` | Delete a ReplicaSet by name |
| `kubectl replace -f <definition-file>` | Update an existing object using a definition |
| `kubectl scale --replicas=<number>` | Scale an object to the specified number |

---

## Practical Workflow

### 1. Check Initial State
```bash
kubectl get pods
kubectl get replicaset
```
**📝 Notes:**
- Always check current state before making changes
- See how many pods and ReplicaSets are running

---

### 2. Verify ReplicaSet Details
```bash
kubectl get replicaset
kubectl describe replicaset new-replica-set
```
**📝 Notes:**
- `describe` shows detailed information
- Check events, replicas count, and pod status

---

### 3. Check Pod Errors
```bash
kubectl describe pod new-replica-set-7r2qw
```
**📝 Notes:**
- Use this to troubleshoot pod issues
- Look for image errors, restart counts, events

---

### 4. Demonstrate Self-Healing
```bash
kubectl delete pod new-replica-set-wkzjh
kubectl get pods
```
**📝 Notes:**
- ReplicaSet automatically creates a new pod
- Maintains the desired replica count
- New pod will have a different name

---

### 5. Create ReplicaSets from YAML
```bash
kubectl create -f /root/replicaset-definition-1.yaml
kubectl create -f /root/replicaset-definition-2.yaml
```
**📝 Notes:**
- Creates ReplicaSets from definition files
- May show errors if YAML has issues (apiVersion, selector mismatch, etc.)

---

### 6. Delete ReplicaSets
```bash
kubectl delete rs replicaset-1
kubectl delete rs replicaset-2
```
**📝 Notes:**
- `rs` is short for `replicaset`
- Deleting ReplicaSet also deletes all its pods

---

### 7. Update Image in ReplicaSet
```bash
kubectl edit rs new-replica-set
```
**📝 Notes:**
- Opens ReplicaSet in editor
- Change the image name
- Save and exit (`:wq` in vi)
- ⚠️ **Important:** Existing pods won't update automatically

---

### 8. Delete Old Pods to Apply New Image
```bash
kubectl delete pod new-replica-set-vpkh8 new-replica-set-tn2mp new-replica-set-7r2qw
```
**📝 Notes:**
- After editing image, delete old pods
- ReplicaSet creates new pods with updated image
- This is the manual way to update pods

---

### 9. Scale Up ReplicaSet
```bash
kubectl scale rs new-replica-set --replicas=5
kubectl get pods
```
**📝 Notes:**
- Increases replica count to 5
- New pods are created immediately
- Verify with `get pods`

---

### 10. Scale Down Using Edit
```bash
kubectl edit rs new-replica-set
```
**📝 Notes:**
- Edit the `replicas: ` field
- Change to lower number to scale down
- Save and Kubernetes terminates extra pods

---

## Key Concepts

### ReplicaSet Self-Healing
- Automatically replaces deleted/failed pods
- Maintains desired state always

### Scaling Methods
1. `kubectl scale --replicas=N -f file.yaml`
2. `kubectl scale --replicas=N rs/name`
3. `kubectl edit rs name`

### Image Update Process
1. Edit ReplicaSet → Change image
2. Delete old pods manually
3. ReplicaSet creates new pods with new image

### Important
- **Selector must match labels** in pod template
- **Deleting ReplicaSet deletes all pods**
- **Use Deployments for production** (better than ReplicaSets)

---

## Quick Reference

**List resources:**
- `kubectl get pods`
- `kubectl get replicaset` or `kubectl get rs`

**Details:**
- `kubectl describe rs <name>`
- `kubectl describe pod <name>`

**Create/Delete:**
- `kubectl create -f <file>`
- `kubectl delete rs <name>`
- `kubectl delete pod <name>`

**Edit/Scale:**
- `kubectl edit rs <name>`
- `kubectl scale rs <name> --replicas=<number>`

---

**Created by:** Vinay-R_PWSCLLC  
**Date:** 2026-01-20
