# Kubernetes – 50 Advanced Questions and Answers

> Focus areas: Pods, Deployments, ReplicaSets, StatefulSets, DaemonSets, Jobs/CronJobs, Services, Ingress, ConfigMaps, Secrets, RBAC, Network Policies, HPA, storage, scheduling, taints/tolerations, affinity, security, and troubleshooting.[web:52][web:54]

---

## 1. Core Concepts & Objects (Beginner → Intermediate)

### Q1. What is Kubernetes and why is it used in enterprise DevOps?

**Answer:**  
Kubernetes is an open-source container orchestration platform that automates deployment, scaling, and management of containerized applications.[web:52][web:57] It abstracts underlying infrastructure and provides primitives like Pods, Deployments, Services, and Ingress to run workloads reliably across clusters of nodes. In enterprise DevOps, Kubernetes standardizes how services are deployed and scaled, enables self-healing, rolling updates, and decouples application delivery from specific machines.[web:52][web:54]

**Real-time Production Scenario:**  
SocGen runs containerized FastAPI, ML, and data services on EKS/AKS clusters. Kubernetes ensures these services scale based on load, recover from node failures, and can be rolled out / rolled back via CI/CD pipelines.

**Common Mistakes:**

- Treating Kubernetes like a VM orchestrator and putting all logic into containers, no abstractions.
- Overcomplicating small workloads that could be managed with simpler platforms.

**Debugging Tips:**

- Always begin with `kubectl get pods -A` to see overall health.
- For a failing app, inspect `kubectl describe pod` and `kubectl logs` for events and errors.

**Follow-up Questions:**

- How does Kubernetes differ from Docker Swarm or just using Docker on VMs?
- In what cases would you *not* choose Kubernetes?

---

### Q2. Explain the relationship between Pods, ReplicaSets, and Deployments.

**Answer:**  

- **Pod:** Smallest deployable unit; wraps one or more tightly coupled containers.[web:54]
- **ReplicaSet:** Ensures a specified number of Pods are running; maintains replicas.
- **Deployment:** Higher-level controller that manages ReplicaSets for rolling updates, rollbacks, and versioning.[web:54]

A Deployment internally creates and manages a ReplicaSet; the ReplicaSet manages Pods.

**Scenario:**  
To run 5 replicas of a stateless FastAPI service with rolling updates, you use a Deployment; it creates a ReplicaSet; that RS ensures 5 Pods.

**Common Mistakes:**

- Creating Pods directly for long-lived services instead of via Deployments/ReplicaSets.
- Editing Pods manually instead of updating the Deployment spec.

**Debugging Tips:**

- `kubectl get deploy,rs,pod -n <ns>` to see how they relate.
- `kubectl rollout history deployment/<name>` to inspect previous versions.

**Follow-up Questions:**

- When would you use a ReplicaSet directly without a Deployment?
- How do rollbacks work at Deployment level?

---

### Q3. When do you use StatefulSet instead of Deployment?

**Answer:**  

Use **StatefulSet** when:

- Each Pod needs a stable network identity (e.g., `app-0`, `app-1`).
- Each Pod needs stable, dedicated persistent storage.
- Deployment order and graceful rolling updates matter (e.g., Kafka, ZooKeeper, some databases).[web:57]

Use **Deployment** for stateless services where Pods are interchangeable.

**Real-time Scenario:**  
You deploy a Kafka cluster on Kubernetes; each broker has consistent identity and storage, so you use a StatefulSet.

**Common Mistakes:**

- Using Deployments for complex stateful systems without understanding implications (data corruption on rescheduling).
- Assuming StatefulSet provides backups; it only provides stable identity and ordering.

**Debugging Tips:**

- `kubectl get statefulsets` and `kubectl describe` to see status.
- Inspect PVCs to confirm correct binding to Pods (`app-0` → `pvc-…-app-0`).

**Follow-up Questions:**

- How do Pod management policies (`OrderedReady`, `Parallel`) affect rollouts?
- How would you backup data for a StatefulSet workload?

---

### Q4. What is a DaemonSet and when would you use it?

**Answer:**  
A DaemonSet ensures a copy of a Pod runs on **every (or selected) node**. Common use cases:

- Log shippers (Filebeat/Fluentd/Vector).
- Monitoring agents (node exporter, Prometheus agents).
- Security agents.

**Scenario:**  
In SG, Elastic logging agents run as DaemonSets so every node sends logs to ElasticSearch/Kibana.[web:59]

**Common Mistakes:**

- Running cluster-wide agents as single Deployments instead of DaemonSets, leading to blind spots.

**Debugging Tips:**

- `kubectl get ds -A` to see DaemonSets.
- If Pods missing on some nodes, check node selectors, taints/tolerations.

**Follow-up Questions:**

- How do you restrict a DaemonSet to only some nodes (e.g., Linux vs Windows)?
- How do you update DaemonSets safely?

---

### Q5. Compare Jobs and CronJobs and give examples.

**Answer:**  

- **Job:** Runs one-off tasks to completion (e.g., DB migration, batch data processing).
- **CronJob:** Schedules Jobs periodically based on a cron expression (e.g., nightly ETL, cleanup tasks).[web:52]

**Examples:**

- Job: run one-time backfill of data from S3 to a database.
- CronJob: run daily index optimization on Elastic, or daily report generation.

**Common Mistakes:**

- Not setting `successfulJobsHistoryLimit` / `failedJobsHistoryLimit`, causing history blowup.
- Jobs that are not idempotent, causing issues on retries.

**Debugging Tips:**

- `kubectl get jobs,cronjobs` to see status.
- For a stuck Job, inspect Pod logs and events; check backoff limits and restart policy.

**Follow-up Questions:**

- How do you ensure data pipeline Jobs are idempotent?
- How do you control concurrency for CronJobs to avoid overlapping runs?

---

## 2. Services, Ingress, and Networking

### Q6. Explain the different types of Services in Kubernetes.

**Answer:**  

- **ClusterIP (default):** Exposes service only inside cluster (internal virtual IP).
- **NodePort:** Exposes service on each node on a high port; mainly for dev/testing.
- **LoadBalancer:** Provisions external load balancer from cloud provider (EKS/AKS ELB/ALB) and routes to ClusterIP.
- **ExternalName:** Provides CNAME-like DNS alias to an external service.[web:54]

**Real-time Scenario:**  
Internal microservices communicate via ClusterIP. External clients access API via LoadBalancer + Ingress.

**Common Mistakes:**

- Using NodePort in production directly instead of load balancer/Ingress.
- Misconfigured selectors, resulting in no endpoints.

**Debugging Tips:**

- `kubectl get svc,endpoints -n <ns>` – if endpoints list is empty, selectors don’t match Pods.
- For LoadBalancer, check cloud provider’s console for provisioned LB health.

**Follow-up Questions:**

- How do Services interact with Pods’ IP addresses?
- How do you implement service-to-service encryption?

---

### Q7. What is Ingress and how does it relate to Services and load balancers?

**Answer:**  
Ingress is a Kubernetes API object that defines HTTP/HTTPS routing rules from outside the cluster to Services inside the cluster.[web:54][web:57] An **Ingress controller** (e.g., NGINX, ALB Ingress Controller) implements these rules, often backed by cloud load balancers.

**Flow:**

External client → Load Balancer → Ingress Controller → Service → Pod.

**Scenario:**  
Expose multiple microservices (`/api/v1`, `/api/v2`) via single domain `api.bank.com` with TLS termination.

**Common Mistakes:**

- Assuming Ingress works without deploying an Ingress controller.
- Not configuring TLS properly, leading to HTTP-only access or errors.

**Debugging Tips:**

- `kubectl describe ingress` – check events for errors (e.g., missing ingress class).
- Inspect Ingress controller logs when routes misbehave.

**Follow-up Questions:**

- How do you configure canary routes with Ingress?
- How do you manage TLS certificates (Let’s Encrypt, ACM, Key Vault) with Ingress?

---

### Q8. How do you troubleshoot when Pods are healthy but the Service is unreachable?

**Answer:**  

Checklist:

1. **Check Service and endpoints:**

```bash
kubectl get svc,ep -n <ns>
```

- If `ENDPOINTS` is empty, selectors don’t match Pods’ labels.

2. **Check Pod labels vs Service selectors:**

```bash
kubectl get pods -n <ns> --show-labels
kubectl describe svc <name> -n <ns>
```

3. **NetworkPolicies:**  
   See if network policies block traffic.

4. **DNS:**  
   Validate DNS from another Pod (`nslookup mysvc`).

**Common RCAs:**

- Wrong selector labels.
- Service defined on wrong port (containerPort mismatch).
- NetworkPolicy misconfiguration.

**Follow-up Questions:**

- How do you test service connectivity from within the cluster?
- How do you debug intermittent connectivity issues?

---

### Q9. How do you debug 503/502 errors behind an Ingress controller?

**Answer:**  

Steps:

1. **Check Ingress object:**  
   Host, path, service name/port.

2. **Check Service endpoints:**  
   Ensure endpoints exist and pods are ready.

3. **Inspect Ingress controller logs:**  
   Look for backend timeout, connection errors.

4. **Check probes:**  
   If pods fail readiness probe, they won’t be in endpoints.

5. **NetworkPolicy / Security Group:**  
   Ensure traffic is permitted from Ingress controller to Pods.

**Common RCAs:**

- Service name/port mismatch.
- Readiness probes failing.
- Backend response timeouts.

**Follow-up Questions:**

- How would you add custom error pages or retry logic?
- How do you tune timeouts for specific routes?

---

## 3. ConfigMaps, Secrets, and RBAC

### Q10. Difference between ConfigMaps and Secrets; when to use which?

**Answer:**  

- **ConfigMap:** Holds non-secret configuration (e.g., feature flags, URLs, environment-specific parameters).
- **Secret:** Holds sensitive data (passwords, tokens, certs), base64-encoded and ideally encrypted at rest.[web:57]

**Use:**

- ConfigMap: log levels, feature toggles.
- Secret: DB credentials, API keys, TLS keys.

**Common Mistakes:**

- Storing secrets in ConfigMaps.
- Committing Secrets as plain YAML in Git without encryption.

**Debugging Tips:**

- If Pods don’t see ConfigMap/Secret values:
  - Check `env` and `volumeMounts` in Pod spec.
  - Check that key names are correct.
  - Check events for mount failures.

**Follow-up Questions:**

- How do you sync Kubernetes Secrets from an external secret manager?
- How do you rotate secrets without restarting all pods manually?

---

### Q11. What is RBAC in Kubernetes and why is it critical?

**Answer:**  
RBAC (Role-Based Access Control) defines permissions for users and service accounts via **Roles/ClusterRoles** and **RoleBindings/ClusterRoleBindings**.[web:57] It controls which API operations are allowed.

**Importance:**

- Prevents accidental or malicious destructive actions (e.g., deleting namespaces).
- Enables least-privilege access for apps and people.

**Real-time Scenario:**  
A CI/CD service account used by Jenkins has a RoleBinding allowing only necessary actions (create/update Deployments in a specific namespace, not cluster-wide admin).

**Common Mistakes:**

- Using `cluster-admin` role for everything.
- Not differentiating human vs service account permissions.

**Debugging Tips:**

- If an operation is forbidden, run `kubectl auth can-i` to quickly test permissions.
- Check Role/ClusterRole and Binding definitions.

**Follow-up Questions:**

- How do you design RBAC for multi-tenant namespaces?
- How do you handle break-glass permissions in incidents?

---

## 4. Network Policies and Security

### Q12. What are NetworkPolicies and how do they work?

**Answer:**  
NetworkPolicies control traffic at the IP/port level between Pods and to/from external endpoints. They act as **firewall rules** at the Pod level, usually enforced by the CNI plugin.[web:59]

Simple model:

- By default, if no NetworkPolicy selects a Pod, traffic is allowed.
- Once a Pod is selected by any NetworkPolicy that has ingress/egress rules, **default becomes deny** for directions not explicitly allowed (depends on policy).

**Use:**  
Restrict which Pods/services can talk to which, implement zero-trust, and reduce blast radius.

**Common Mistakes:**

- Applying default-deny policies without careful exception rules, causing outages.
- Forgetting DNS or metrics endpoints in egress rules.

**Debugging Tips:**

- Start with simple allow-all baseline, then tighten gradually.
- Use network policy observability tools or logs from CNI.
- Temporarily disable NetworkPolicies (in non-prod) to confirm if they are root cause.

**Follow-up Questions:**

- How do you implement default-deny for a namespace safely?
- How do NetworkPolicies interact with cloud security groups?

---

### Q13. How do you secure Kubernetes workloads beyond RBAC and NetworkPolicies?

**Answer:**  

Layers:

- **Image security:** scanning, signed images, base images hardened.
- **Pod security:** Pod Security Standards/Admission (or PSP in older clusters) for controlling privileged containers, host mounts, capabilities.
- **Runtime security:** tools to detect suspicious behavior (e.g., Falco).
- **Secrets & config:** external secret management, encryption at rest.
- **Cluster lifecycle:** regular upgrades, patching, backup etcd.

**Common Mistakes:**

- Running all containers as root.
- Mounting host paths unnecessarily.
- No admission control; pods can do anything.

**Follow-up Questions:**

- How would you implement security policies for multi-tenant clusters?
- How do you mitigate noisy neighbor or resource abuse?

---

## 5. Scheduling, Taints/Tolerations, Affinity

### Q14. Explain taints and tolerations, and give a practical example.

**Answer:**  

- **Taints** are applied to nodes; they repel Pods that do not specifically tolerate them.
- **Tolerations** are applied to Pods; they allow Pods to be scheduled on tainted nodes.[web:52]

**Example:**

- Taint certain nodes as `workload=high-memory:NoSchedule`.
- Only Pods that need high-memory workloads add corresponding toleration:

```yaml
spec:
  tolerations:
  - key: "workload"
    operator: "Equal"
    value: "high-memory"
    effect: "NoSchedule"
```

**Use Cases:**

- Dedicated nodes for critical services.
- Dedicated nodes for GPU or special hardware.

**Common Mistakes:**

- Adding taints but not tolerations → workloads never schedule.
- Assuming toleration forces scheduling; it just allows it, real scheduling still influenced by other factors.

**Debugging Tips:**

- `kubectl describe node` – see taints.
- For pending Pods, check events (`kubectl describe pod`) to see “pod didn’t tolerate node’s taint” messages.

**Follow-up Questions:**

- How do taints/tolerations work with node affinity?
- How do you use taints for spot vs on‑demand node separation?

---

### Q15. What is node affinity/pod affinity, and when would you use them?

**Answer:**  

- **Node affinity:** constrains scheduling of Pods to nodes based on labels (e.g., only on nodes in certain AZs or with certain hardware).
- **Pod affinity/anti-affinity:** constrains Pods to be co-located or not co-located with other Pods.

**Use Cases:**

- Run certain workloads only in specific AZs or node types.
- Spread replicas across nodes/segments (`podAntiAffinity`) for HA.
- Co-locate sidecar-like workloads or caches (`podAffinity`).

**Example (anti-affinity to avoid all replicas on same node):**

```yaml
spec:
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
          - key: app
            operator: In
            values: ["my-service"]
        topologyKey: "kubernetes.io/hostname"
```

**Common Mistakes:**

- Using overly strict `requiredDuringScheduling` with impossible constraints → Pods never schedule.
- Forgetting topology key, leading to unintuitive distribution.

**Debugging Tips:**

- For pending Pods, inspect scheduling events; they often show which affinity/anti-affinity rule was not satisfied.
- Start with `preferredDuringScheduling` before moving to `requiredDuringScheduling` while tuning.

**Follow-up Questions:**

- How do you mix affinity with HPA and Cluster Autoscaler?
- Give an example where bad affinity rules caused an incident.

## 6. Pod Lifecycle, Probes, Resources, and Autoscaling

### Q16. Explain the Pod lifecycle phases and how they relate to readiness for traffic.

**Answer:**  
Pod phases include **Pending**, **Running**, **Succeeded**, **Failed**, and **Unknown**.[web:52] A Pod goes from Pending (scheduled, images pulling) to Running (at least one container running), and eventually to Succeeded/Failed when containers exit. However, **“Running” does not mean “Ready for traffic”**; readiness is determined by **readiness probes** and endpoint registration.

**Key Point:**  
A Pod can be Running but **not Ready**, so Services/Ingress should not route traffic to it until readiness is true.

**Common Mistakes:**

- Assuming Running = healthy; ignoring readiness/liveness status.
- No probes defined; traffic hits pods during slow startup.

**Debugging Tips:**

- `kubectl get pods -n <ns>` (check READY column, not just STATUS).
- `kubectl describe pod` → look at events and conditions, especially `Ready`.

**Follow-up Questions:**

- What happens if a readiness probe fails but liveness probe passes?
- How do preStop hooks interact with Pod termination?

---

### Q17. What are liveness, readiness, and startup probes? When do you use each?

**Answer:**  

- **Liveness probe:** Checks if the container should be restarted (e.g., deadlocked, stuck). If it fails, kubelet restarts container.
- **Readiness probe:** Checks if Pod is ready to serve traffic. If it fails, Pod is removed from Service endpoints but not restarted.
- **Startup probe:** For slow-starting apps; used to check if the app has started successfully. While startup probe is running, liveness/readiness are disabled.[web:52][web:57]

**Use Cases:**

- Readiness for DB-connected services, to avoid traffic before DB connection established.
- Liveness for apps that might hang.
- Startup for large Java apps or heavy ML models that load on startup.

**Common Mistakes:**

- Using liveness probe where readiness is appropriate (causing unnecessary restarts).
- Too aggressive probe timeouts/intervals, causing flapping.

**Debugging Tips:**

- Check `kubectl describe pod` events for probe failures.
- Temporarily disable or relax probes (in non-prod) to confirm they are cause of restarts.

**Follow-up Questions:**

- How would you design probes for a FastAPI service with a `/health` endpoint?
- What are best practices for probe intervals and thresholds?

---

### Q18. How do resource requests and limits affect Pod scheduling and stability?

**Answer:**  

- **Requests:** Minimum CPU/memory guaranteed for a Pod; scheduler uses them to place Pods on nodes.[web:54]
- **Limits:** Maximum CPU/memory allowed for a Pod; exceeding memory limit leads to OOMKill; CPU over limit can cause throttling.

**Implications:**

- Under-requesting can cause Pods to be packed densely and suffer from contention.
- Over-requesting can cause low cluster utilization and scheduling failures.

**Common Mistakes:**

- No limits at all; single noisy Pod can starve others.
- Same values for request and limit without understanding workload.

**Debugging Tips:**

- `kubectl top pods`/`kubectl top nodes` to see actual usage.
- Check Pod events for OOM or throttling messages.

**Follow-up Questions:**

- How do you choose initial request/limit values?
- How do resource requests interact with Cluster Autoscaler?

---

### Q19. What is the Horizontal Pod Autoscaler (HPA) and how does it work?

**Answer:**  
HPA automatically adjusts the number of Pod replicas based on observed metrics, such as CPU utilization, memory, or custom metrics.[web:52]

Typical configuration:

- Target Deployment/ReplicaSet.
- Min/max replicas.
- Metric target (e.g., average CPU utilization 70%).

**Example (CPU-based HPA):**

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: api-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: api
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```

**Common Mistakes:**

- No HPA on services with variable traffic → manual scaling pain.
- HPA based only on CPU where latency or queue length is a better metric.

**Debugging Tips:**

- `kubectl describe hpa` to see scaling events.
- Check metrics pipeline (e.g., metrics-server, Prometheus adapter) if HPA not scaling.

**Follow-up Questions:**

- How would you use custom metrics for HPA?
- How does HPA interact with Cluster Autoscaler?

---

### Q20. What is the Cluster Autoscaler, and how does it differ from HPA?

**Answer:**  

- **HPA:** Scales **Pods** up/down based on workload metrics.
- **Cluster Autoscaler (CA):** Scales **nodes** (VMs) up/down based on scheduling needs and underutilization.[web:54]

**How they interact:**

- HPA increases replicas → scheduler may not find enough room → CA adds nodes.
- When load drops and some nodes become underutilized, CA drains and removes them.

**Common Mistakes:**

- Using HPA without CA – hitting scheduling failures during bursts.
- Misconfigured CA that cannot scale (e.g., wrong IAM, ASG config).

**Debugging Tips:**

- Inspect Cloud provider logs (EKS/AWS & AKS/Azure).
- Check CA logs (if deployed as Deployment/Pod in kube-system).

**Follow-up Questions:**

- How do you set safe scale-up/down thresholds?
- How do you prevent “flapping” (frequent scale up/down cycles)?

---

### Q21. What causes CrashLoopBackOff and how do you troubleshoot it?

**Answer:**  
CrashLoopBackOff occurs when a container in a Pod repeatedly crashes soon after starting.[web:52]

**Troubleshooting Steps:**

1. `kubectl get pods -n <ns>` to confirm status.
2. `kubectl describe pod <pod>` to see restart count and events.
3. `kubectl logs <pod> -n <ns>` for current logs; if container restarts quickly, use `--previous`.
4. Check:
   - Command/entrypoint configuration.
   - Env vars and config mounts.
   - Resource limits causing OOM.

**Common RCAs:**

- Application bug causing immediate crash.
- Missing environment variable or secret.
- DB or dependency not reachable; app exits.
- Misconfigured command/args.

**Follow-up Questions:**

- When would you use `kubectl logs --previous`?
- How can readiness/liveness probes influence CrashLoopBackOff behavior?

---

### Q22. What is ImagePullBackOff and how do you handle it?

**Answer:**  
ImagePullBackOff indicates Kubernetes failed to pull the container image.

**Possible Reasons:**

- Wrong image name/tag.
- No credentials for private registry.
- Network connectivity issues to registry.

**Troubleshooting:**

1. `kubectl describe pod` → look for event messages (“Failed to pull”).
2. Verify image name and tag exist in registry.
3. Check imagePullSecrets and registry auth.
4. Check node network connectivity.

**Common Mistakes:**

- Using `latest` and not realizing which tag is actually being pulled.
- Missing `imagePullSecrets` for private registries.

**Follow-up Questions:**

- How do you organize image repositories/tags for multiple environments?
- How do you avoid dependency on Docker Hub rate limits in production?

---

### Q23. How do you debug a Pod stuck in “ContainerCreating”?

**Answer:**  

Check:

1. `kubectl describe pod` events:
   - Image pull issues.
   - Volume mount / PVC issues.
   - CNI plugin issues.

2. For volume-related:
   - `kubectl get pvc,pv -n <ns>` – PVC may be `Pending`.

3. For node-related:
   - Node disk pressure / out of capacity.
   - CNI or kubelet logs.

**Common RCAs:**

- Image pull errors (same as ImagePullBackOff).
- Persistent volume not provisioning due to missing StorageClass or quota.
- CNI misconfiguration while setting up pod network.

**Follow-up Questions:**

- How would you quickly differentiate between image vs volume vs node issues?
- How do you monitor cluster events centrally?

---

### Q24. How do you debug a node marked as NotReady?

**Answer:**  

Steps:

1. `kubectl get nodes` – see which node is `NotReady`.
2. `kubectl describe node <name>` – check conditions (NetworkUnavailable, OutOfDisk, MemoryPressure, DiskPressure).
3. Check node-level logs:
   - kubelet logs.
   - System logs, disk usage, CPU/memory.
4. Cloud layer:
   - EKS/AKS node group status.
   - Underlying VM instance status.

**Common RCAs:**

- Node lost network to control plane.
- Resource pressure (disk full, out of memory).
- Kubelet crashed or not running.

**Follow-up Questions:**

- How would you safely drain a node?
- How do you ensure critical workloads are rescheduled correctly?

---

### Q25. What commands and tools do you use most frequently for Kubernetes troubleshooting?

**Answer:**  

Common commands:

```bash
# Cluster and namespace overview
kubectl get nodes
kubectl get pods -A
kubectl get pods -n <ns> -o wide

# Deep dive into resources
kubectl describe pod <pod> -n <ns>
kubectl logs <pod> -n <ns>
kubectl logs <pod> -n <ns> --previous

# Rollout and resources
kubectl rollout status deployment/<name> -n <ns>
kubectl get deploy,rs,svc,ing -n <ns>

# Resource usage
kubectl top pods -n <ns>
kubectl top nodes
```

Additional tools:

- `k9s` or similar TUI for fast cluster navigation.
- `stern` or `kubetail` for multi-pod log tailing.

**Follow-up Questions:**

- How do you script recurring checks for L2 support?
- How do you integrate these checks with CI/CD (e.g., post-deploy validation)?

---

## 7. Storage: PV, PVC, StorageClasses, and Stateful Workloads

### Q26. Explain PersistentVolume (PV), PersistentVolumeClaim (PVC), and StorageClass.

**Answer:**  

- **PV:** Cluster resource representing storage (e.g., EBS volume, Azure Disk, NFS).
- **PVC:** User’s request for storage with size and access mode; binds to a PV that matches.
- **StorageClass:** Template/definition for dynamic provisioning of PVs, including parameters for cloud-specific storage (type, IOPS, encryption).[web:57]

**Flow:**

1. App defines PVC with requested size and StorageClass.
2. Dynamic provisioner creates PV according to StorageClass.
3. PVC binds to PV; Pod mounts PVC.

**Common Mistakes:**

- No default StorageClass; PVC stays Pending.
- Deleting PVC without understanding reclaim policy (e.g., `Delete` vs `Retain`).

**Debugging Tips:**

- `kubectl get pvc,pv` to see binding and status.
- Check StorageClass and provisioner logs.

**Follow-up Questions:**

- What are `ReadWriteOnce`, `ReadOnlyMany`, `ReadWriteMany`?
- How do you manage storage encryption and backup in EKS/AKS?

---

### Q27. How do you migrate stateful workloads to Kubernetes safely?

**Answer:**  

Steps:

1. Assess workload suitability (e.g., DB, message broker).
2. Plan storage:
   - Use StatefulSet + PVCs + proper StorageClass.
   - Understand IOPS and latency requirements.
3. Migration path:
   - Snapshot/backup existing data.
   - Restore into Kubernetes-managed storage.
   - Run in parallel (shadow) for testing if possible.
4. Cutover carefully, with well-rehearsed rollback.

**Common Mistakes:**

- Lifting DBs into Kubernetes without proper storage or operational expertise.
- No backup/restore plan tested before migration.

**Follow-up Questions:**

- When would you choose managed DB services (RDS/Azure SQL) instead of DB in K8s?
- How to handle network latency between app in K8s and data outside K8s?

---

## 8. EKS/AKS, Multi-Cluster, and Advanced Topics

### Q28. What are some EKS/AKS-specific considerations for running Kubernetes in AWS/Azure?

**Answer:**  

For **EKS (AWS):**[web:54]

- IAM roles for service accounts (IRSA) for fine-grained access to AWS resources.
- Native integration with ALB/NLB, VPC, security groups.
- Node groups (managed/unmanaged) and Fargate profiles.

For **AKS (Azure):**

- Managed identities for Pods or nodes.
- Integration with Azure Load Balancer, Application Gateway.
- Azure CNI vs kubenet networking choices.

**Common Mistakes:**

- Using node IAM roles or access keys instead of fine-grained IRSA/managed identities.
- Misconfigured networking causing IP exhaustion or unexpected peering issues.

**Follow-up Questions:**

- How do you grant a single microservice read-only access to one S3 bucket from EKS?
- How do you secure AKS with Azure AD and RBAC?

---

### Q29. How do you manage multiple clusters (e.g., dev, stage, prod, multi-region) in a bank?

**Answer:**  

Patterns:

- Separate clusters per environment (dev, QA, staging, prod).
- Possibly separate clusters per region or domain (e.g., EU vs APAC).
- Use cluster registry/config management (e.g., kubeconfig per cluster, or context switching tools).

Management strategies:

- Infra-as-Code (Terraform) for cluster provisioning.
- GitOps or standardized Jenkins pipelines for workloads.
- Central governance for policies (e.g., OPA, Kyverno).

**Common Mistakes:**

- Manually configuring clusters; drift across clusters.
- Sharing clusters for prod and non‑prod without clear boundaries.

**Follow-up Questions:**

- How do you promote an app from one cluster to another safely?
- How do you apply consistent security policies across clusters?

---

### Q30. Describe a Kubernetes production outage you might encounter and how you’d run the incident.

**Answer (example scenario):**  

**Incident:**  
After a change to NetworkPolicy and Ingress, external users cannot reach multiple APIs; dashboards show 5xx errors.

**Detection:**

- Alerts from Grafana/Prometheus on HTTP 5xx and latency.
- Synthetic checks failing for `/health` endpoints.

**Incident handling steps:**

1. Declare incident (Sev1/Sev2 depending on impact).
2. Triage:
   - Check Ingress and Services for one affected API.
   - Confirm Pods are running and Ready.
   - `kubectl get ep` shows no endpoints due to label mismatch after deployment.
3. Scope:
   - Realize multiple services share a common label or Ingress rule changed.
4. Immediate mitigation:
   - Roll back Deployment/Ingress/NetworkPolicy to previous revision (Helm rollback, `kubectl rollback`).
   - Confirm recovery via health checks and error rate drop.
5. RCA:
   - Root cause: new Service selector and NetworkPolicy blocked traffic.
   - Contributing factors: no pre-deploy validation for selectors; no automated tests for Ingress and NetworkPolicies.
6. Prevention:
   - Add pipeline step that validates selectors and endpoints in staging.
   - Add “canary” Ingress rules with smaller blast radius.
   - Improve change review on shared network policies.

**Follow-up Questions:**

- How would you structure the postmortem document?
- What metrics and logs would you collect during the incident?

## 9. Security, Admission, and Multi-Tenancy

### Q31. What are Pod Security Standards (PSS) / Pod Security Admission, and why do they matter?

**Answer:**  
Pod Security Standards (Baseline, Restricted, Privileged) and Pod Security Admission (or equivalent mechanisms) define and enforce security-related constraints on Pods, such as disallowing privileged containers, hostPath mounts, or running as root.[web:57] They help ensure workloads follow minimum security baselines.

**Use in regulated environments:**

- Enforce baseline or restricted policies in shared or prod namespaces.
- Prevent developers from accidentally running overly privileged containers.

**Common Mistakes:**

- Enabling strict policies without testing; many workloads suddenly fail to schedule.
- No exception/allowlist process for legitimate privileged workloads (e.g., CNI, storage).

**Debugging Tips:**

- When Pods are denied, inspect events; admission errors will show why.
- Test changes in lower environments first.

**Follow-up Questions:**

- How would you roll out stricter Pod security gradually?
- What tools (OPA/Gatekeeper, Kyverno) can help implement richer policies?

---

### Q32. How would you implement multi-tenancy in a Kubernetes cluster?

**Answer:**  

Options:

- **Soft multi-tenancy:** Namespaces with RBAC for teams, ResourceQuotas, NetworkPolicies, and Pod Security controls.
- **Harder multi-tenancy:** Separate clusters per tenant or business unit, plus the above.

**Critical controls:**

- Namespaces per team/app.
- RoleBindings per namespace.
- ResourceQuotas and LimitRanges to avoid noisy neighbor issues.
- NetworkPolicies to isolate traffic.

**Common Mistakes:**

- Single namespace for many teams; RBAC ineffective.
- No quotas; one team’s misconfigured workload exhausts cluster resources.

**Follow-up Questions:**

- When would you move from multi-tenant cluster to per-team clusters?
- How do you manage shared platform components (logging, monitoring) across tenants?

---

### Q33. What are Admission Controllers, and how do you use them?

**Answer:**  
Admission Controllers are plugins that intercept requests to the Kubernetes API after authentication/authorization but before objects are persisted. They can mutate or validate resources (e.g., add defaults, enforce policies).[web:52]

Use cases:

- Enforce labels/annotations.
- Enforce image registries, security controls (no privileged containers).
- Inject sidecars (e.g., service mesh proxies).

**Tools:**

- Built-in controllers.
- Webhook-based (e.g., OPA Gatekeeper, Kyverno).

**Common Mistakes:**

- Writing validating webhooks that are slow or fragile, making the API server unreliable.
- Not implementing fail‑open/fail‑closed logic carefully.

**Follow-up Questions:**

- How would you enforce “only images from internal registry”?
- How to avoid admission controllers becoming single point of failure?

---

## 10. Advanced Storage, Backup, and DR

### Q34. How do you back up Kubernetes cluster resources and application data?

**Answer:**  

Two layers:

1. **Cluster state (resources):**
   - Backup etcd directly (for self-managed clusters).
   - Or periodically export manifests via tools (Velero, custom scripts).

2. **Application data:**
   - Snapshot/backup PVs via storage provider (EBS snapshots, Azure Disk snapshots, CSI snapshots).
   - Application-level backups (database dumps, etc.).

In managed services (EKS/AKS), you typically focus on manifest exports plus storage snapshots.

**Common Mistakes:**

- Only backing up manifests, not data; or only data, not manifests.
- Not testing restores.

**Follow-up Questions:**

- How would you test backup and restore procedures?
- How do you handle encryption and retention for backups?

---

### Q35. What is the reclaim policy for PersistentVolumes and why is it important?

**Answer:**  
Reclaim policy determines what happens to PV’s underlying storage when the PVC is deleted:

- `Retain`: keep storage; data remains; manual cleanup needed.
- `Delete`: automatically delete underlying storage (e.g., EBS volume).
- `Recycle` (legacy): basic scrub/cleanup.[web:57]

**Importance:**

- For critical data, often use `Retain` to avoid accidental data loss.
- For ephemeral workloads, `Delete` to avoid orphaned volumes and cost.

**Common Mistakes:**

- Defaulting to `Delete` for all, causing data loss when PVC deleted.
- Leaving many retained PVs never cleaned up, incurring cost and confusion.

**Follow-up Questions:**

- How would you automate cleanup for retained volumes that are no longer needed?
- How do you choose reclaim policy per workload?

---

### Q36. How do you handle database schema changes with rolling deployments on Kubernetes?

**Answer:**  

Pattern:

- Use **migrations** separate from app rollout:
  - Run migrations as Jobs or as pre-deploy step.
- Ensure migrations are **backward-compatible**:
  - Step 1: deploy schema that supports old + new code.
  - Step 2: deploy new app version using new schema.
  - Step 3: remove old fields later.

**Common Mistakes:**

- Deploy app that expects new columns before they are added.
- Running destructive migrations (DROP columns) before old app retired.

**Follow-up Questions:**

- How do you implement migrations pipeline in Jenkins/CI/CD?
- How would you roll back if migration breaks?

---

## 11. Observability and Debugging in Kubernetes

### Q37. How do you design logs, metrics, and traces for Kubernetes workloads?

**Answer:**  

- **Logs:**
  - Write to stdout/stderr; collect via DaemonSet agents to Elastic (or similar).
  - Include correlation IDs and build/deploy metadata.

- **Metrics:**
  - Export app metrics (Prometheus format) with labels (service, version, env).
  - Use Kubernetes metrics (CPU/mem, HPA, node health).

- **Traces:**
  - Use OpenTelemetry/Jaeger/Zipkin to trace requests across microservices.

All correlated with Kubernetes metadata: namespace, pod name, node, container, version.

**Common Mistakes:**

- Writing logs to local files instead of stdout.
- No version labels, making it hard to correlate behavior with deployments.

**Follow-up Questions:**

- How would you debug a performance regression after a deployment?
- What golden signals would you monitor for each service?

---

### Q38. How do you debug intermittent latency issues inside a Kubernetes cluster?

**Answer:**  

Steps:

1. Verify app-level metrics (latency histograms, error rate).
2. Check **resource usage** (CPU, memory, I/O) per Pod and node.
3. Check **network**:
   - P95/P99 latency across services.
   - NetworkPolicies, CNI health.
4. Check **GC and runtime stats** for languages like Java/Python (e.g., GC pauses, GIL contention).
5. Check **HPA scaling** behavior:
   - Are pods under-provisioned during bursts?
   - Are there cold starts due to frequent scaling?

**Common RCAs:**

- Under-sized Pods hitting CPU limit and throttling.
- No connection pooling; too many connections to DB.
- DNS or CNI glitches.

**Follow-up Questions:**

- How would you test whether latency is network vs application?
- How do you protect dependencies (DB, cache) from overload?

---

### Q39. How do you troubleshoot DNS issues in Kubernetes?

**Answer:**  

Checklist:

1. From a Pod, run:

```bash
kubectl exec -it <pod> -n <ns> -- nslookup other-service
kubectl exec -it <pod> -n <ns> -- dig other-service.ns.svc.cluster.local
```

2. Check CoreDNS deployment and pods (`kube-system`).
3. Check CoreDNS configmap for misconfigurations.
4. Ensure NetworkPolicies allow traffic to DNS.

**Common RCAs:**

- CoreDNS pods down or misconfigured.
- NetworkPolicies blocking DNS.
- Wrong FQDN or service name.

**Follow-up Questions:**

- How does service DNS name resolution work (`svc.ns.svc.cluster.local`)?
- How do you handle DNS for external dependencies (databases, APIs)?

---

## 12. Complex Scenarios, DR, and Real Incidents

### Q40. Describe how you would handle a full cluster outage in production.

**Answer:**  

Steps:

1. **Detection:** Multi-service failures, cluster API unreachable, node failures.

2. **Immediate actions:**
   - Declare Sev1 incident.
   - Communicate impact and initial scope.
   - Identify if cloud region outage or cluster-specific.

3. **Mitigation:**
   - Failover to DR cluster/region if available.
   - Or temporarily route traffic to backup systems.

4. **Technical investigation:**
   - Check control plane health (managed by cloud in EKS/AKS).
   - Check node groups, network, IAM, API server response.

5. **Post-recovery RCA:**
   - Root cause (e.g., misconfiguration, cloud incident, capacity exhaustion).
   - Detection and mitigation improvements.
   - Hardening measures (multi-region deployment, better autoscaling, runbooks).

**Follow-up Questions:**

- How do you design for region-level failure in EKS/AKS?
- What data do you capture during the incident for RCA?

---

### Q41. How do you handle application-specific incidents caused by misconfigured Kubernetes manifests?

**Answer:**  

Example misconfigs: wrong environment variables, resource limits, probes, labels, or secrets.

**Response:**

1. Identify the misconfigured Deployment or manifest (compare current spec vs previous).
2. Roll back to last known good version (`kubectl rollout undo` or Helm rollback).
3. Validate that new config solves the issue.

**Prevention:**

- Manifest linting (kubeval, kube-linter).
- Policy-as-code (OPA, Kyverno) to prevent dangerous configs.
- Pre-deployment checks in CI (e.g., `kubectl apply --dry-run=server` on staging cluster).

**Follow-up Questions:**

- What validations would you add to pipelines to catch misconfigs early?
- How do you maintain a catalog of standard manifest patterns?

---

### Q42. How would you design a Kubernetes platform to support both HTTP APIs and batch workloads?

**Answer:**  

Design:

- **Namespaces**: separate for APIs vs batch; or per business domain.
- **Node pools**: separate node groups for latency-sensitive HTTP vs CPU-heavy batch.
- **Scheduling**:
  - Taints/tolerations & affinity to keep API pods off batch nodes and vice versa.
- **Autoscaling**:
  - HPA for APIs based on CPU/latency.
  - Job concurrency controls and scale-out nodes for batch.

**Common Mistakes:**

- Placing heavy batch jobs on same nodes as latency-sensitive APIs.
- No isolation; a huge batch job saturates network or disk.

**Follow-up Questions:**

- How do you use PriorityClasses to protect critical workloads?
- How would you manage cost vs performance for batch vs real-time?

---

### Q43. How do you safely inject sidecars (e.g., for service mesh or logging) into Pods?

**Answer:**  

Methods:

- **Manual sidecars** in Pod specs.
- **Mutating Admission Webhooks** (e.g., Istio, Linkerd injectors) that modify Pod spec as it’s created.

Key considerations:

- Ensure that sidecar injection does not break Pod startup (probes, ports).
- Handle upgrade of sidecars carefully.
- Workload owners must understand impact on traffic, TLS, and resource usage.

**Common Mistakes:**

- Sidecar injection not excluded for system Pods, causing issues.
- Not resizing resources when adding sidecars.

**Follow-up Questions:**

- How do you control which namespaces get auto-injected sidecars?
- How does sidecar injection impact debugging and logs?

---

### Q44. How do you manage configuration drift in Kubernetes clusters (cluster-level resources)?

**Answer:**  

Approaches:

- Treat manifests as code (GitOps).
- Use ArgoCD/Flux to continuously reconcile cluster state from Git.
- Avoid `kubectl edit` and manual changes in prod.

For cluster-level objects (CRDs, RBAC, NetworkPolicies), maintain separate “platform config” repos.

**Common Mistakes:**

- Manual hotfixes that never go back into Git.
- Ad-hoc kubectl commands in prod; no traceability.

**Follow-up Questions:**

- How do you bootstrap a new cluster from Git?
- How to handle emergency changes under GitOps?

---

### Q45. What is a Custom Resource Definition (CRD) and how is it used?

**Answer:**  
CRDs extend Kubernetes API with new resource types (e.g., `KafkaCluster`, `MySQLBackup`). They allow operators and controllers to manage domain-specific resources using Kubernetes semantics.[web:52]

**Use Cases:**

- Operators for DBs, message queues, ML models, certificates, etc.
- Abstract complex operations into Kubernetes-native APIs.

**Common Mistakes:**

- Ignoring CRD behavior and treating them as simple config; not understanding operator reconciliation.

**Follow-up Questions:**

- Example of a CRD you’ve used (e.g., CertManager, Prometheus, ArgoCD).
- How do you handle CRD versioning and migration?

---

### Q46. How do you handle secrets that need to be available across multiple namespaces?

**Answer:**  

Options:

- Duplicate secrets per namespace (managed by automation).
- Use external secret managers and operators that sync secrets into namespaces (e.g., External Secrets Operator).
- For some clusters, use a shared namespace with controlled access and projected volumes (less common and must be secure).

**Best Practice:**  
Use external secret store as source of truth; Kubernetes Secrets as ephemeral copies.

**Follow-up Questions:**

- How do you rotate cross-namespace secrets with minimal downtime?
- How do you avoid “secret sprawl” and mismanagement?

---

### Q47. How do you ensure safe, incremental rollouts in Kubernetes for critical banking APIs?

**Answer:**  

Patterns:

- Small batches of changes; canary deployment or progressive traffic shifting.
- Tight health checks and SLO-based decisions.
- Use of feature flags for high-risk functionality.
- Staged rollouts: one region/cluster first, then global.

Technical tools:

- Ingress with weighted routing.
- Service mesh (Istio/Linkerd) for traffic splitting and observability.

**Follow-up Questions:**

- What KPIs would you watch during a critical rollout?
- How do you design rollback decision criteria?

---

### Q48. How do you use Kubernetes for scheduled operational tasks (e.g., maintenance, cleanup)?

**Answer:**  

Use **CronJobs**:

- Scheduled tasks for:
  - Log cleanup.
  - Temp data cleanup.
  - Periodic health validations (e.g., run query against DB, validate responses).
- Ensure CronJobs are idempotent and well monitored.

**Operational Considerations:**

- Configure concurrency policy (`Forbid`, `Replace`) to avoid overlapping runs.
- Set history limits for Jobs.

**Follow-up Questions:**

- How do you handle failures in a CronJob (alerting, retry)?
- How do you coordinate CronJobs that operate on shared resources (locking)?

---

### Q49. What’s your approach to designing Kubernetes runbooks for L2/L3 support?

**Answer:**  

Runbooks should be:

- **Step-by-step**: “If you see X, run Y command and capture Z”.
- **Automatable**: Many runbook steps become Jenkins or GitOps jobs.
- **Context-rich**: include diagrams and service dependencies.

Examples:

- “Service down” runbook:
  - Check Pods, Services, Ingress.
  - Check logs in Elastic.
  - Check last deployment status.
- “High error rate” runbook:
  - Validate backend dependencies.
  - Check resource utilization.
  - Rollback process.

**Follow-up Questions:**

- Example of a runbook you’ve created and later automated.
- How do you keep runbooks up to date?

---

### Q50. What are the biggest pitfalls you’ve seen with Kubernetes adoption, and how would you avoid them?

**Answer (structured):**  

1. **Over-complexity for simple needs**  
   - Avoid: Use managed services or simpler platforms when appropriate.

2. **Lack of platform team / standards**  
   - Avoid: Platform engineering team providing curated base images, Helm charts, and best practices.

3. **Poor security posture**  
   - Avoid: Enforce Pod security, RBAC, NetworkPolicies, image scanning early.

4. **Insufficient observability**  
   - Avoid: Set up logging, metrics, tracing as first-class citizens.

5. **No clear ownership and SLOs**  
   - Avoid: Assign service ownership; define SLOs and error budgets.

6. **Manual operations**  
   - Avoid: Use GitOps, CI/CD, and automation for routine changes.

**Follow-up Questions:**

- Which of these have you personally helped to fix?
- How would you apply these lessons to this Specialist DevOps role?


