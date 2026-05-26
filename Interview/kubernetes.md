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
