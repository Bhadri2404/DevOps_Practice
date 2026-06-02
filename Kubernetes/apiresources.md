## Kubernetes Resources Quick Cheat Sheet

| Resource Kind           | Short Name | API Version (Common)         | Component / Purpose                            |
| ----------------------- | ---------- | ---------------------------- | ---------------------------------------------- |
| Namespace               | ns         | v1                           | Logical isolation of resources                 |
| Pod                     | po         | v1                           | Smallest deployable unit containing containers |
| ReplicaSet              | rs         | apps/v1                      | Maintains desired number of pod replicas       |
| Deployment              | deploy     | apps/v1                      | Manages ReplicaSets and rolling updates        |
| StatefulSet             | sts        | apps/v1                      | Manages stateful applications                  |
| DaemonSet               | ds         | apps/v1                      | Runs one pod on every node                     |
| Job                     | job        | batch/v1                     | Runs a task until completion                   |
| CronJob                 | cj         | batch/v1                     | Scheduled jobs                                 |
| Service                 | svc        | v1                           | Exposes applications internally or externally  |
| Endpoints               | ep         | v1                           | Stores service backend pod IPs                 |
| Ingress                 | ing        | networking.k8s.io/v1         | HTTP/HTTPS routing                             |
| NetworkPolicy           | netpol     | networking.k8s.io/v1         | Controls pod network traffic                   |
| ConfigMap               | cm         | v1                           | Stores non-sensitive configuration             |
| Secret                  | secret     | v1                           | Stores sensitive data                          |
| ServiceAccount          | sa         | v1                           | Identity for pods                              |
| Role                    | -          | rbac.authorization.k8s.io/v1 | Namespace-level permissions                    |
| RoleBinding             | -          | rbac.authorization.k8s.io/v1 | Assigns Role to users/groups                   |
| ClusterRole             | -          | rbac.authorization.k8s.io/v1 | Cluster-wide permissions                       |
| ClusterRoleBinding      | -          | rbac.authorization.k8s.io/v1 | Assigns ClusterRole                            |
| PersistentVolume        | pv         | v1                           | Cluster storage resource                       |
| PersistentVolumeClaim   | pvc        | v1                           | Storage request by applications                |
| StorageClass            | sc         | storage.k8s.io/v1            | Dynamic storage provisioning                   |
| VolumeSnapshot          | vs         | snapshot.storage.k8s.io/v1   | Volume backup/snapshot                         |
| ResourceQuota           | quota      | v1                           | Limits resource consumption                    |
| LimitRange              | limits     | v1                           | Sets default resource limits                   |
| HorizontalPodAutoscaler | hpa        | autoscaling/v2               | Pod auto-scaling                               |
| PodDisruptionBudget     | pdb        | policy/v1                    | Maintains pod availability during disruptions  |
| PriorityClass           | pc         | scheduling.k8s.io/v1         | Pod scheduling priority                        |
| RuntimeClass            | rc         | node.k8s.io/v1               | Selects container runtime                      |
| Node                    | no         | v1                           | Worker node                                    |
| Event                   | ev         | v1                           | Cluster events and troubleshooting             |
| Lease                   | -          | coordination.k8s.io/v1       | Leader election mechanism                      |

---

## Cluster Components Cheat Sheet

| Component                            | Purpose                                               |
| ------------------------------------ | ----------------------------------------------------- |
| kube-apiserver                       | Entry point for all Kubernetes API requests           |
| etcd                                 | Stores cluster state and configuration                |
| kube-scheduler                       | Assigns pods to nodes                                 |
| kube-controller-manager              | Runs controllers (Deployment, Node, ReplicaSet, etc.) |
| cloud-controller-manager             | Integrates with cloud providers                       |
| kubelet                              | Agent running on each worker node                     |
| kube-proxy                           | Handles service networking and load balancing         |
| Container Runtime (containerd/CRI-O) | Runs containers                                       |
| CoreDNS                              | Cluster DNS service                                   |
| Ingress Controller                   | Handles ingress traffic routing                       |
| CNI Plugin                           | Provides pod networking                               |
| CSI Driver                           | Provides storage integration                          |

---

## Most Common Resources Used Daily by DevOps Engineers

| Resource     | Command                                                       |
| ------------ | ------------------------------------------------------------- |
| Pods         | `kubectl get pods -A`                                         |
| Deployments  | `kubectl get deploy -A`                                       |
| Services     | `kubectl get svc -A`                                          |
| Ingress      | `kubectl get ingress -A`                                      |
| ReplicaSets  | `kubectl get rs -A`                                           |
| Nodes        | `kubectl get nodes`                                           |
| Namespaces   | `kubectl get ns`                                              |
| ConfigMaps   | `kubectl get cm -A`                                           |
| Secrets      | `kubectl get secrets -A`                                      |
| PVCs         | `kubectl get pvc -A`                                          |
| PVs          | `kubectl get pv`                                              |
| StatefulSets | `kubectl get sts -A`                                          |
| DaemonSets   | `kubectl get ds -A`                                           |
| Jobs         | `kubectl get jobs -A`                                         |
| CronJobs     | `kubectl get cronjobs -A`                                     |
| HPA          | `kubectl get hpa -A`                                          |
| Events       | `kubectl get events -A --sort-by=.metadata.creationTimestamp` |

### Command to See All Resources in a Namespace

```bash
kubectl api-resources

kubectl get all -n <namespace>
```

### Command to See Every Resource Type in Cluster

```bash
kubectl api-resources --verbs=list -o name
```

This is a handy interview and production support cheat sheet covering ~95% of the Kubernetes resources you commonly encounter.
