# X Company – SRE Interview Preparation

## Section 1: Kubernetes

### Subtopic 1.1: Argo CD – Real-Time Production Interview Questions

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: HR questions + additional production scenarios + troubleshooting + deployment strategies + rollback + commands.

### Example Production Environment

```
Cloud        : AWS
Cluster      : Amazon EKS
CI Tool      : Jenkins
CD Tool      : Argo CD
Registry     : Amazon ECR
Git          : GitHub
Namespace    : production
Application  : payment-service
Argo CD App  : payment-prod
```

All examples assume approved production access. Use your actual project details when answering questions about work you personally performed.

### Q1. If Argo CD is deployed in Kubernetes, where will it run?

Interview Answer:

Argo CD runs as multiple pods inside the Kubernetes cluster, normally in the `argocd` namespace. Kubernetes schedules these pods on available worker nodes based on resources and scheduling rules.

Production Commands:

```
# Check Argo CD pods
kubectl get pods -n argocd

# Check which nodes run the pods
kubectl get pods -n argocd -o wide

# Check Argo CD components
kubectl get deploy,sts -n argocd
```

Real-Time Scenario: If a worker node fails, Kubernetes can reschedule replacement Argo CD pods on healthy nodes if capacity is available.

### Q2. What are the main components of Argo CD?

Interview Answer:

Argo CD mainly has three components:

1. API Server: Handles UI and API access.
2. Repo Server: Fetches Git configurations and generates manifests.
3. Application Controller: Compares Git with Kubernetes and synchronizes changes.

Production Commands:

```
# API Server logs
kubectl logs -n argocd \
  deployment/argocd-server

# Repository Server logs
kubectl logs -n argocd \
  deployment/argocd-repo-server

# Application Controller logs
kubectl logs -n argocd \
  statefulset/argocd-application-controller
```

Real-Time Scenario: If Git manifest generation fails, I check Repo Server logs. If resource synchronization fails, I check Application Controller logs.

### Q3. How do you install and configure Argo CD in production?

Interview Answer:

First, we connect to the EKS cluster and create the Argo CD namespace. Then we install an approved, pinned Argo CD version using Helm or Kubernetes manifests.

After installation, we configure SSO, RBAC, Git repositories, projects, and applications.

Production Commands:

```
# Connect to EKS
aws eks update-kubeconfig \
  --region ap-south-1 \
  --name prod-eks

# Create namespace
kubectl create namespace argocd

# Verify installation
kubectl get pods -n argocd

# Check services
kubectl get svc -n argocd

# Verify configured applications
argocd app list
```

Real-Time Scenario: We install Argo CD with high availability for production and restrict access using corporate SSO and RBAC.

Important: The actual Helm installation or manifest deployment uses an approved version and reviewed configuration, not an unreviewed latest release.

### Q4. Explain your end-to-end application deployment process using Jenkins and Argo CD.

Interview Answer:

In our example project, Jenkins builds the application, runs tests, creates the Docker image, and pushes it to ECR.

After approval, the image version is updated in Git. Argo CD detects the changes and deploys the application into EKS.

Deployment Flow:

```
Developer → GitHub → Jenkins
                     |
                     v
                Build & Test
                     |
                     v
                Docker Image
                     |
                     v
                   AWS ECR
                     |
                     v
              GitOps Repository
                     |
                     v
                   Argo CD
                     |
                     v
                EKS Cluster
```

Production Commands:

```
# Check current application
argocd app get payment-prod

# Compare changes
argocd app diff payment-prod

# Deploy after approval
argocd app sync payment-prod

# Verify rollout
kubectl rollout status \
  deployment/payment-service -n production
```

Real-Time Scenario: When developers release a new version, Jenkins builds and pushes the image. After the GitOps change is approved, Argo CD deploys it to EKS.

### Q5. How do you manage Dev, QA, and Production environments using Argo CD?

Interview Answer:

We maintain separate configurations for Dev, QA, and Production in Git.

Each environment has its own Argo CD Application, namespace, and configuration. Production changes go through approval.

Example Repository Structure:

```
gitops-repo/
  apps/
    payment-service/
      dev/
      qa/
      prod/
```

Production Commands:

```
# List applications
argocd app list

# Check Dev application
argocd app get payment-dev

# Check Production application
argocd app get payment-prod

# Promote approved version
argocd app sync payment-prod
```

Real-Time Scenario: Version `v1.2` is tested in Dev and QA. Once approved, we update the Production GitOps configuration and deploy the same tested image.

### Q6. An Argo CD application is not syncing. How do you troubleshoot it?

Interview Answer:

First, I check the synchronization status and error message. Then I verify Git connectivity, repository credentials, YAML files, RBAC permissions, and Argo CD logs.

Once the issue is fixed, I retry synchronization.

Production Commands:

```
# Check application
argocd app get payment-prod

# Compare Git and cluster
argocd app diff payment-prod

# Verify Git connection
argocd repo list

# Check repository logs
kubectl logs -n argocd \
  deployment/argocd-repo-server --tail=100

# Retry after resolving the issue
argocd app sync payment-prod
```

Real-Time Scenario: Deployment failed because of an incorrect Helm values file path. We fixed the path in Git and synchronized the application successfully.

### Q7. An Argo CD pod is in CrashLoopBackOff. How do you troubleshoot?

Interview Answer:

I check pod events, current and previous logs, memory usage, and configuration. Common reasons are OOMKilled, missing secrets, or configuration problems.

I fix the root cause and verify the pod becomes healthy.

Production Commands:

```
# Check pods
kubectl get pods -n argocd

# Check failure reason
kubectl describe pod <pod-name> -n argocd

# Check previous crash logs
kubectl logs <pod-name> \
  -n argocd --previous

# Check resources
kubectl top pods -n argocd
```

Real-Time Scenario: If the Repo Server is OOMKilled, I check memory trends, manifest generation load, and resource limits. After identifying the cause, we update the approved configuration.

### Q8. How do you roll back an application using Argo CD?

Interview Answer:

In production, we normally follow Git-based rollback.

If a new version fails, I identify the last stable version, revert the failed Git change, and merge it after approval.

Argo CD detects the reverted configuration and restores the previous application version.

Production Commands:

```
# Check deployed version
argocd app get payment-prod

# Check deployment history
argocd app history payment-prod

# Check Git history
git log --oneline -5

# Revert failed commit in a review branch
git revert <commit-id>

# After approval and merge, sync
argocd app sync payment-prod

# Verify deployment
kubectl rollout status \
  deployment/payment-service -n production
```

Real-Time Scenario: Version `v2` caused HTTP 500 errors. We reverted the GitOps configuration to stable version `v1`, synchronized Argo CD, and verified that errors stopped.

### Q9. Apart from Git rollback, what other rollback methods do you know?

Interview Answer:

We can use Argo CD deployment history, Kubernetes Deployment rollback, Helm rollback, or Git rollback.

For Argo CD-managed applications, Git rollback is generally preferred because Git remains the source of truth.

Production Commands:

```
# Argo CD history
argocd app history payment-prod

# Argo CD rollback to history ID
argocd app rollback payment-prod <history-id>

# Kubernetes rollback
kubectl rollout undo \
  deployment/payment-service -n production

# Helm release history
helm history payment-service -n production

# Helm rollback
helm rollback payment-service <revision> \
  -n production
```

Important: Argo CD history rollback requires automated sync to be disabled. Direct Kubernetes or Helm changes may later be overwritten by Argo CD unless Git is updated.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://argo-cd.readthedocs.io\&sz=32)

Declarative GitOps CD for Kubernetes

+1



Follow-Up: Which rollback is best in your project?

Answer: Git rollback, because it maintains consistency between Git and the Kubernetes cluster.

### Q10. A new deployment is failing. How do you identify and recover the last stable version?

Interview Answer:

First, I check application health, pod status, logs, and rollout history.

If the new version is affecting production, I follow the incident process and restore the last stable image through the approved rollback procedure.

Production Commands:

```
# Check pod status
kubectl get pods -n production

# Check rollout history
kubectl rollout history \
  deployment/payment-service -n production

# Check logs
kubectl logs \
  deployment/payment-service \
  -n production --tail=100

# Check Argo CD history
argocd app history payment-prod
```

Real-Time Scenario: A new release causes `CrashLoopBackOff`. I verify the application error, identify the stable version, restore it through GitOps, and check application health.

### Q11. How do you achieve zero-downtime deployment using Argo CD?

Interview Answer:

We use Kubernetes RollingUpdate with multiple replicas, proper readiness probes, and enough available cluster capacity.

Argo CD applies the Deployment changes, and Kubernetes gradually replaces old pods with new ones.

Example Deployment Strategy:

```
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxSurge: 1
    maxUnavailable: 0
```

Production Commands:

```
# Check Deployment
kubectl get deployment payment-service \
  -n production

# Monitor rollout
kubectl rollout status \
  deployment/payment-service -n production

# Monitor running pods
kubectl get pods -n production -w
```

Real-Time Scenario: If the application has three healthy replicas, Kubernetes can start replacement pods before removing old ones. This helps maintain availability, provided readiness checks and capacity are correctly configured.

### Q12. What is the difference between Rolling, Blue-Green, and Canary deployment?

Interview Answer:

- Rolling: Gradually replaces old pods with new pods.
- Blue-Green: Maintains two application environments and switches traffic to the new environment.
- Canary: Sends a small amount of traffic to the new version before increasing traffic.

Argo CD manages the desired configuration. We can use Argo Rollouts for advanced Blue-Green and Canary deployments.

Production Commands:

```
# Standard Kubernetes rollout
kubectl rollout status \
  deployment/payment-service -n production

# Check Argo Rollouts resources
kubectl get rollouts -n production

# Inspect rollout
kubectl argo rollouts get rollout \
  payment-service -n production
```

The final command requires the Argo Rollouts kubectl plugin.

Real-Time Scenario: For a critical payment application, we can release to 10% of traffic, monitor errors, and gradually increase traffic if the new version is healthy.

### Q13. What is the difference between Synced, OutOfSync, Healthy, and Degraded?

Interview Answer:

- Synced: Kubernetes configuration matches Git.
- OutOfSync: Kubernetes configuration differs from Git.
- Healthy: Application resources are healthy.
- Degraded: One or more application resources have a health problem.

Production Commands:

```
# Check sync and health status
argocd app get payment-prod

# Compare configurations
argocd app diff payment-prod

# Check resources
argocd app resources payment-prod
```

Real-Time Scenario: The application can be Synced but Degraded if the correct deployment configuration was applied but its pods are crashing.

### Q14. What are Auto-Sync, Self-Heal, and Prune in Argo CD?

Interview Answer:

Auto-Sync automatically deploys changes from Git.

Self-Heal corrects supported manual changes made in Kubernetes.

Prune removes managed resources that were deleted from Git.

Production Commands:

```
# Enable Auto-Sync
argocd app set payment-prod \
  --sync-policy automated

# Enable Self-Heal
argocd app set payment-prod \
  --self-heal

# Enable Auto-Prune (after review)
argocd app set payment-prod \
  --auto-prune
```

Real-Time Scenario: If someone manually changes a Deployment, Argo CD can detect configuration drift and restore the Git configuration when self-healing is enabled.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://argo-cd.readthedocs.io\&sz=32)

Declarative GitOps CD for Kubernetes



Important: Auto-prune can delete resources. Production teams should review its impact before enabling it.

### Q15. What happens if Argo CD goes down? Will production applications stop?

Interview Answer:

No. Existing application pods normally continue running because Kubernetes manages them independently.

However, Argo CD synchronization and GitOps deployments may stop until Argo CD recovers.

Production Commands:

```
# Check Argo CD
kubectl get pods -n argocd

# Check cluster nodes
kubectl get nodes

# Check server logs
kubectl logs -n argocd \
  deployment/argocd-server --tail=100

# Verify production pods
kubectl get pods -n production
```

Real-Time Scenario: If the Argo CD server crashes, I check the pods and logs and restore the service while verifying that customer applications remain available.

### Q16. How do you secure Argo CD in a production environment?

Interview Answer:

We secure Argo CD using SSO, RBAC, TLS, restricted repository access, and secret management.

We also provide separate permissions for Dev and Production environments and follow least-privilege access.

Production Commands:

```
# Check RBAC configuration
kubectl get cm argocd-rbac-cm \
  -n argocd -o yaml

# Check Argo CD projects
argocd proj list

# Check service exposure
kubectl get svc,ingress -n argocd

# Check cluster access
argocd cluster list
```

Real-Time Scenario: Developers can view production applications, but only authorized deployment teams can approve or perform production synchronization.

### Q17. How do you monitor Argo CD using Prometheus and Grafana?

Interview Answer:

Prometheus collects Argo CD metrics, and Grafana displays application health, sync failures, reconciliation performance, and resource usage.

We configure alerts when production applications become unhealthy or synchronization repeatedly fails.

Production Commands:

```
# Check metrics services
kubectl get svc -n argocd | grep metrics

# Check resource usage
kubectl top pods -n argocd

# Check application status
argocd app get payment-prod
```

Example Prometheus Query:

```
argocd_app_info{
  health_status="Degraded"
}
```

This identifies applications reported as Degraded when the metric is available.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://argo-cd.readthedocs.io\&sz=32)

Declarative GitOps CD for Kubernetes



Real-Time Scenario: If a production application becomes Degraded, Grafana or Alertmanager can notify the SRE team to investigate and restore application health.

### Q18. How do you upgrade Argo CD in production?

Interview Answer:

First, I check the current version and review the target release notes for breaking changes.

Then we back up the configuration, test the upgrade in a non-production environment, and upgrade using the approved Helm chart or manifests.

Finally, we verify Argo CD pods and application synchronization.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://argo-cd.readthedocs.io\&sz=32)

Declarative GitOps CD for Kubernetes



Production Commands:

```
# Check Argo CD version
argocd version

# For Helm-managed Argo CD
helm list -n argocd

# Check Helm release history
helm history argocd -n argocd

# Upgrade with approved chart version
helm upgrade argocd argo/argo-cd \
  -n argocd \
  --version <approved-chart-version> \
  -f values-prod.yaml

# Verify pods
kubectl get pods -n argocd

# Verify applications
argocd app list
```

Real-Time Scenario: Before upgrading Argo CD, we test the target version in staging, verify Git and cluster connectivity, and perform the production upgrade during an approved maintenance window.

### Q19. What happens to Argo CD during an EKS or AKS cluster upgrade?

Interview Answer:

During EKS or AKS upgrades, worker nodes may be replaced or restarted.

Argo CD pods may be rescheduled onto healthy nodes. We verify replica availability, PodDisruptionBudgets, and node capacity before starting the upgrade.

Production Commands:

```
# Check Kubernetes version
kubectl version

# Check nodes
kubectl get nodes

# Check Argo CD pod placement
kubectl get pods -n argocd -o wide

# Check PodDisruptionBudgets
kubectl get pdb -n argocd

# Verify applications after upgrade
argocd app list
```

Real-Time Scenario: During a managed node pool upgrade, Kubernetes moves eligible workloads to healthy nodes. We monitor Argo CD availability and confirm that applications synchronize normally afterward.

Follow-Up: How do you upgrade EKS or AKS itself?

Answer: We check version compatibility and deprecated APIs, take appropriate backups, test in staging, upgrade the control plane and node pools, update add-ons, and verify applications. The exact steps differ for AWS and Azure.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS

+1



A full production EKS and AKS upgrade procedure will be covered in the separate Kubernetes Cluster Upgrade subtopic.

## Bonus: Rapid-Fire SRE Follow-Up Questions

These are additional questions you should prepare because interviewers often ask follow-ups based on your initial answers.

| Interview Question                             | Short Answer                                                                             |
| ---------------------------------------------- | ---------------------------------------------------------------------------------------- |
| Can Argo CD deploy to multiple clusters?       | Yes, using registered cluster destinations and appropriate permissions.                  |
| Can Argo CD deploy Helm charts?                | Yes, it can render Helm charts and apply the generated Kubernetes manifests.             |
| Does Argo CD need Jenkins?                     | No. Jenkins is optional; Argo CD can work with other CI tools.                           |
| What happens if GitHub goes down?              | Existing apps keep running, but Git-based refresh and deployment may fail.               |
| How do you handle secrets in GitOps?           | Use External Secrets, Vault, or cloud secret managers rather than plain-text passwords.  |
| What is ApplicationSet?                        | It automatically generates multiple Argo CD Applications from templates.                 |
| What is a Sync Wave?                           | It controls the order in which Argo CD applies Kubernetes resources.                     |
| What is a Sync Hook?                           | It runs jobs or resources at stages such as PreSync or PostSync.                         |
| Can Argo CD replace Terraform?                 | No. Terraform provisions infrastructure; Argo CD mainly manages Kubernetes applications. |
| How do you prevent direct production changes?  | Use RBAC, Git approvals, audit logs, and Argo CD drift detection.                        |
| What if a new image cannot be pulled?          | Check ECR permissions, image tags, registry access, and pod events.                      |
| What if manual scaling conflicts with Argo CD? | Use Git-based configuration and configure HPA-related fields correctly.                  |

## Argo CD – Last-Minute Command Revision

```
# Check applications
argocd app list

# Get application details
argocd app get payment-prod

# Compare Git and Kubernetes
argocd app diff payment-prod

# Synchronize application
argocd app sync payment-prod

# Check deployment history
argocd app history payment-prod

# Inspect application resources
argocd app resources payment-prod

# Check Argo CD pods
kubectl get pods -n argocd

# Check pod failure
kubectl describe pod <pod-name> -n argocd

# Check previous logs
kubectl logs <pod-name> -n argocd --previous

# Check Kubernetes rollout
kubectl rollout status \
  deployment/payment-service -n production

# Check Kubernetes rollback history
kubectl rollout history \
  deployment/payment-service -n production
```

End of Subtopic 1.1 – Argo CD

19 detailed interview questions + 12 bonus follow-ups, including HR topics and additional real-world SRE scenarios.

Please review this format. If you confirm, I'll continue from scratch using this same question-and-answer depth, practical commands, and production examples for the next Kubernetes subtopic, without unnecessarily increasing the content length.

# X Company – SRE Interview Preparation

## Section 1: Kubernetes

### Subtopic 1.2: Deployments, StatefulSets, Nginx and Production Troubleshooting

Interview Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: HR questions + extra technical questions + production commands + real-time scenarios + troubleshooting.

### Example Production Environment

```
Cloud        : AWS
Cluster      : Amazon EKS
Namespace    : production
Application  : nginx-web
Registry     : Amazon ECR
CI/CD        : Jenkins + Argo CD
Storage      : AWS EBS / EFS
```

The examples below use sample resources. In production, configuration changes should go through GitOps, review, and approval rather than unmanaged manual changes.

### Q1. Can we deploy Nginx using a StatefulSet?

Interview Answer:

Yes, we can deploy Nginx using a StatefulSet. However, Nginx is normally a stateless application, so we prefer a Deployment.

StatefulSet is useful when applications need stable pod names, persistent storage, and ordered deployment, such as databases.

Production Commands:

```
# Check Deployments
kubectl get deployments -n production

# Check StatefulSets
kubectl get statefulsets -n production

# Check StatefulSet pods
kubectl get pods -n production -o wide
```

Real-Time Scenario: We normally use Deployment for Nginx web servers. For databases like MongoDB or PostgreSQL, a StatefulSet may be useful because each instance can maintain its own identity and storage.

Follow-Up: Can we create a Kubernetes Service for Nginx running as a StatefulSet?

Answer: Yes. The StatefulSet manages pods, while the Service provides network access. A headless Service is commonly used for stable pod DNS identities.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q2. What is the difference between Deployment and StatefulSet?

Interview Answer:

Deployment is used for stateless applications. Pods are interchangeable and can be replaced easily.

StatefulSet is used for stateful applications. It provides stable pod identity, persistent storage, and ordered pod management.

| Deployment               | StatefulSet              |
| ------------------------ | ------------------------ |
| Stateless applications   | Stateful applications    |
| Pod names can change     | Stable pod names         |
| Pods are interchangeable | Each pod has an identity |
| Common for APIs/Nginx    | Common for databases     |
| Supports rolling updates | Supports ordered updates |

Production Commands:

```
kubectl get deployments -A

kubectl get statefulsets -A

kubectl describe statefulset <name> \
  -n production
```

Real-Time Scenario: For a payment API, I prefer Deployment. For a database that requires stable identity and storage, I consider StatefulSet.

### Q3. What is the difference between Deployment, StatefulSet, and DaemonSet?

Interview Answer:

- Deployment: Runs stateless applications with the required replicas.
- StatefulSet: Runs applications needing stable identity or persistent storage.
- DaemonSet: Runs a pod on every eligible worker node.

Production Commands:

```
# Check all workload types
kubectl get deploy,sts,ds -A

# Check DaemonSets
kubectl get daemonsets -n kube-system
```

Real-Time Scenario: We use Deployments for APIs, StatefulSets for certain database workloads, and DaemonSets for node monitoring agents or log collectors.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q4. How do you deploy Nginx using a Deployment in production?

Interview Answer:

We create a Deployment YAML with replicas, Docker image, resource limits, readiness probes, and rolling-update strategy.

We store the YAML in Git and deploy it through Argo CD.

Example `nginx-deployment.yaml`:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-web
  namespace: production
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx-web
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: nginx-web
    spec:
      containers:
        - name: nginx
          image: nginx:1.27.5
          ports:
            - containerPort: 80
          readinessProbe:
            httpGet:
              path: /
              port: 80
          resources:
            requests:
              cpu: 100m
              memory: 128Mi
            limits:
              cpu: 500m
              memory: 256Mi
```

Example image tag only. Use an organization-approved, scanned, supported image in production.

Production Commands:

```
# Validate YAML
kubectl apply --dry-run=client \
  -f nginx-deployment.yaml

# Deploy after approval
kubectl apply -f nginx-deployment.yaml

# Verify Deployment
kubectl get deployments -n production

# Check rollout
kubectl rollout status \
  deployment/nginx-web -n production

# Check pods
kubectl get pods -n production
```

Real-Time Scenario: If the organization needs three Nginx replicas for high availability, we configure `replicas: 3` and distribute them across nodes using appropriate scheduling rules.

### Q5. How do you deploy Nginx using a StatefulSet?

Interview Answer:

We create a headless Service and a StatefulSet with persistent volume claims.

Each pod gets a stable name such as `nginx-0` and `nginx-1`, along with its own storage.

Example `nginx-statefulset.yaml`:

```
apiVersion: v1
kind: Service
metadata:
  name: nginx-headless
  namespace: production
spec:
  clusterIP: None
  selector:
    app: nginx-stateful
  ports:
    - port: 80
      name: web
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: nginx-stateful
  namespace: production
spec:
  serviceName: nginx-headless
  replicas: 2
  selector:
    matchLabels:
      app: nginx-stateful
  template:
    metadata:
      labels:
        app: nginx-stateful
    spec:
      containers:
        - name: nginx
          image: nginx:1.27.5
          ports:
            - containerPort: 80
          volumeMounts:
            - name: nginx-data
              mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
    - metadata:
        name: nginx-data
      spec:
        accessModes: ["ReadWriteOnce"]
        storageClassName: gp3
        resources:
          requests:
            storage: 5Gi
```

Production Commands:

```
# Verify StorageClass exists
kubectl get storageclass

# Validate manifests
kubectl apply --dry-run=client \
  -f nginx-statefulset.yaml

# Apply after approval
kubectl apply -f nginx-statefulset.yaml

# Check StatefulSet
kubectl get sts -n production

# Check pods and volumes
kubectl get pods,pvc -n production
```

Expected Pods:

```
nginx-stateful-0   Running
nginx-stateful-1   Running
```

Real-Time Scenario: If a StatefulSet pod restarts, its replacement keeps the same pod identity and normally reconnects to its existing persistent volume.

Important: The `gp3` StorageClass must exist and AWS EBS CSI provisioning must be configured. For real stateful production workloads, configure appropriate security, health probes, resources, and backups.

### Q6. What is a Headless Service, and why do StatefulSets use it?

Interview Answer:

A Headless Service is a Kubernetes Service without a ClusterIP.

It helps StatefulSet pods get stable DNS identities so applications can communicate directly with specific pods.

Example YAML:

```
apiVersion: v1
kind: Service
metadata:
  name: nginx-headless
  namespace: production
spec:
  clusterIP: None
  selector:
    app: nginx-stateful
  ports:
    - port: 80
```

Production Commands:

```
# Check Service
kubectl get svc -n production

# Verify Service configuration
kubectl describe svc nginx-headless \
  -n production

# Verify DNS from a debug pod
kubectl run dns-test \
  -n production \
  --rm -it \
  --restart=Never \
  --image=busybox:1.36 \
  -- nslookup nginx-stateful-0.nginx-headless
```

Real-Time Scenario: In a stateful database cluster, applications may need to communicate with a specific database instance. Headless Services help provide predictable DNS names.

Follow-Up: Does a Headless Service perform load balancing?

Answer: No. Unlike a normal ClusterIP Service, it does not provide a virtual Service IP or Kubernetes Service load balancing. DNS returns individual endpoint addresses.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q7. What happens if a StatefulSet pod fails?

Interview Answer:

Kubernetes attempts to recreate the failed pod with the same identity.

For example, if `nginx-stateful-0` fails, the StatefulSet controller recreates `nginx-stateful-0` and reuses its existing storage when available.

Production Commands:

```
# Check StatefulSet pods
kubectl get pods -n production

# Check pod failure
kubectl describe pod nginx-stateful-0 \
  -n production

# Check pod logs
kubectl logs nginx-stateful-0 \
  -n production

# Check PVC
kubectl get pvc -n production
```

Real-Time Scenario: If a node hosting `nginx-stateful-0` fails, Kubernetes can recreate the pod on a suitable healthy node.

For AWS EBS, storage attachment and Availability Zone restrictions must be satisfied.

### Q8. What are PV, PVC, and StorageClass in Kubernetes?

Interview Answer:

- PV (PersistentVolume): Actual storage available to Kubernetes.
- PVC (PersistentVolumeClaim): A request for storage by an application.
- StorageClass: Defines how storage is dynamically provisioned.

Production Commands:

```
# Check PersistentVolumes
kubectl get pv

# Check PersistentVolumeClaims
kubectl get pvc -A

# Check StorageClasses
kubectl get storageclass

# Troubleshoot PVC
kubectl describe pvc <pvc-name> \
  -n production
```

Real-Time Scenario: In EKS, we can use the EBS CSI driver and a suitable StorageClass to provision persistent storage.

When an application creates a PVC, Kubernetes can dynamically provision a volume if the required configuration is available.

### Q9. A StatefulSet pod is Pending because PVC is not bound. How do you troubleshoot?

Interview Answer:

First, I check the PVC status and Kubernetes events.

Then I verify the StorageClass, EBS CSI driver, IAM permissions, storage capacity, and Availability Zone compatibility.

Production Commands:

```
# Check PVC status
kubectl get pvc -n production

# Describe PVC
kubectl describe pvc <pvc-name> \
  -n production

# Check StorageClass
kubectl get sc

# Check EBS CSI pods
kubectl get pods -n kube-system \
  | grep ebs-csi

# Check pod events
kubectl describe pod <pod-name> \
  -n production
```

Real-Time Scenario: A PVC cannot be provisioned because the storage driver lacks required AWS permissions.

I verify the EBS CSI controller logs and IAM configuration, then coordinate the required permission fix.

### Q10. How do you scale a Deployment and StatefulSet?

Interview Answer:

We can scale both Deployment and StatefulSet using the `kubectl scale` command.

Deployment creates additional interchangeable pods, while StatefulSet creates pods with stable identities.

Production Commands:

```
# Scale Deployment to 5 replicas
kubectl scale deployment/nginx-web \
  --replicas=5 -n production

# Scale StatefulSet to 3 replicas
kubectl scale statefulset/nginx-stateful \
  --replicas=3 -n production

# Verify scaling
kubectl get deployments,sts \
  -n production
```

Real-Time Scenario: If a stateless application receives more traffic, we can increase Deployment replicas or use Horizontal Pod Autoscaler.

For StatefulSets, we also consider storage, application clustering, and data replication before scaling.

Important: In GitOps-managed environments, scaling configuration should also be updated in Git, otherwise Argo CD may restore the previous replica count.

### Q11. How do you perform a rolling update for a Kubernetes Deployment?

Interview Answer:

RollingUpdate gradually replaces old pods with new pods without stopping all replicas at once.

We configure `maxSurge` and `maxUnavailable` to control the deployment.

Example YAML:

```
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxSurge: 1
    maxUnavailable: 0
```

Production Commands:

```
# Check current image
kubectl describe deployment nginx-web \
  -n production

# Update image after approval
kubectl set image deployment/nginx-web \
  nginx=nginx:1.27.5 -n production

# Monitor rollout
kubectl rollout status \
  deployment/nginx-web -n production

# Check pods
kubectl get pods -n production -w
```

Real-Time Scenario: When we deploy a new Nginx image, Kubernetes starts new healthy pods before terminating old ones, provided enough capacity is available.

### Q12. How do you update or upgrade a StatefulSet in production?

Interview Answer:

StatefulSet supports RollingUpdate. By default, it updates pods in reverse order, one at a time, and waits for readiness before continuing.

We first verify backups and application compatibility, then update the container image through GitOps.

Production Commands:

```
# Check StatefulSet
kubectl get sts nginx-stateful -n production

# Check current image
kubectl describe sts nginx-stateful \
  -n production

# Update image after approval
kubectl set image sts/nginx-stateful \
  nginx=nginx:1.27.5 -n production

# Check rollout
kubectl rollout status sts/nginx-stateful \
  -n production
```

Real-Time Scenario: If there are three StatefulSet pods, Kubernetes normally updates `pod-2`, then `pod-1`, then `pod-0`.

Follow-Up: What if one updated pod never becomes Ready?

Answer: The rollout can stop. I check logs, readiness probes, and events. In some failed StatefulSet rollouts, restoring the old configuration also requires carefully deleting the failed pod so it can be recreated.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://v1-35.docs.kubernetes.io\&sz=32)

Kubernetes



### Q13. How do you roll back a failed Kubernetes Deployment?

Interview Answer:

First, I check the rollout history and identify the stable revision.

If the new deployment fails, I roll back to the previous stable version, then verify pod health and application availability.

Production Commands:

```
# Check rollout history
kubectl rollout history \
  deployment/nginx-web -n production

# Roll back to previous revision
kubectl rollout undo \
  deployment/nginx-web -n production

# Or roll back to specific revision
kubectl rollout undo \
  deployment/nginx-web \
  --to-revision=2 -n production

# Verify
kubectl rollout status \
  deployment/nginx-web -n production
```

Real-Time Scenario: A new image causes HTTP 500 errors. We roll back to the stable version and monitor application health.

Important: For Argo CD-managed Deployments, we normally revert the image version in Git, so Argo CD does not restore the faulty version.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q14. How do you troubleshoot a Deployment when pods are not starting?

Interview Answer:

I check pod status, events, logs, image pull errors, resource limits, and node availability.

Common problems include `ImagePullBackOff`, `CrashLoopBackOff`, `Pending`, and failed health probes.

Production Commands:

```
# Check pods
kubectl get pods -n production

# Describe failed pod
kubectl describe pod <pod-name> \
  -n production

# Check logs
kubectl logs <pod-name> -n production

# Check previous logs
kubectl logs <pod-name> \
  -n production --previous

# Check events
kubectl get events -n production \
  --sort-by=.lastTimestamp
```

Real-Time Scenario: A pod shows ImagePullBackOff because the image tag does not exist in ECR. I verify the image tag, registry access, and image pull permissions, then correct the deployment.

### Q15. Your Nginx pods are Running, but users cannot access the application. How do you troubleshoot?

Interview Answer:

I check pod readiness, Service configuration, endpoints, Ingress, load balancer, and network policies.

A Running pod does not always mean the application is accessible.

Production Commands:

```
# Check pods
kubectl get pods -n production

# Check Services
kubectl get svc -n production

# Check endpoints
kubectl get endpointslices -n production

# Check Ingress
kubectl get ingress -n production

# Check Nginx logs
kubectl logs deployment/nginx-web \
  -n production
```

Real-Time Scenario: The Service selector does not match the pod labels, so the Service has no endpoints.

I correct the selector through GitOps and verify traffic reaches the application.

### Q16. What are readiness, liveness, and startup probes?

Interview Answer:

- Readiness Probe: Checks whether the pod is ready to receive traffic.
- Liveness Probe: Checks whether the container needs restarting.
- Startup Probe: Gives slow-starting applications time to initialize.

Example YAML:

```
readinessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 10

livenessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 15
  periodSeconds: 10
```

Production Commands:

```
kubectl describe pod <pod-name> \
  -n production

kubectl get pods -n production

kubectl get events -n production
```

Real-Time Scenario: If the application is not ready, the readiness probe fails and Kubernetes removes that pod from normal Service traffic until it becomes ready.

### Q17. What happens when a Kubernetes worker node fails?

Interview Answer:

Kubernetes detects the unhealthy node. For Deployments, replacement pods can be scheduled on healthy nodes.

For StatefulSets, Kubernetes also tries to recover the pods while maintaining their identities and storage.

Production Commands:

```
# Check nodes
kubectl get nodes

# Inspect failed node
kubectl describe node <node-name>

# Check pod locations
kubectl get pods -n production -o wide

# Check events
kubectl get events -n production \
  --sort-by=.lastTimestamp
```

Real-Time Scenario: During an EKS worker node failure, replacement pods may move to available nodes.

For StatefulSets using EBS, I also verify volume attachment and Availability Zone compatibility.

### Q18. How do you ensure high availability for applications in Kubernetes?

Interview Answer:

We use multiple replicas, RollingUpdate, readiness probes, PodDisruptionBudgets, and distribute pods across nodes or Availability Zones.

We also monitor application health and configure autoscaling where required.

Example PodDisruptionBudget:

```
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: nginx-pdb
  namespace: production
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: nginx-web
```

Production Commands:

```
# Check replicas
kubectl get deployments -n production

# Check pod placement
kubectl get pods -n production -o wide

# Check PDBs
kubectl get pdb -n production

# Check HPA
kubectl get hpa -n production
```

Real-Time Scenario: During planned node maintenance, the PDB helps prevent too many Nginx pods from being voluntarily disrupted at the same time.

### Q19. How do you migrate an application from Deployment to StatefulSet?

Interview Answer:

First, I check whether the application really needs stable identities or persistent storage.

Then I plan storage, backups, service discovery, data migration, and downtime requirements.

I test the StatefulSet in staging before switching production traffic.

Practical Migration Steps:

```
1. Identify current Deployment configuration
2. Check application storage requirements
3. Create Headless Service
4. Configure StatefulSet and PVCs
5. Test application and data migration
6. Validate readiness and connectivity
7. Switch traffic after approval
8. Monitor and remove old resources safely
```

Production Commands:

```
# Export current Deployment
kubectl get deployment nginx-web \
  -n production -o yaml

# Check existing storage
kubectl get pvc -n production

# Validate StatefulSet
kubectl apply --dry-run=client \
  -f nginx-statefulset.yaml

# Verify migrated StatefulSet
kubectl get sts,pods,pvc -n production
```

Real-Time Scenario: When migrating a stateful application, we create the target StatefulSet and restore or migrate data to its persistent storage before switching traffic.

We avoid running two independent instances against the same data without an application-supported migration plan.

## Bonus: Additional Second-Round SRE Questions

| Question                                                   | Short Interview Answer                                                                                                        |
| ---------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| What is a ReplicaSet?                                      | It maintains the required number of pod replicas.                                                                             |
| Can StatefulSet work without PVC?                          | Yes, if persistent storage is not required, but it still provides stable pod identity.                                        |
| Does StatefulSet automatically back up data?               | No. We must configure separate backups and recovery.                                                                          |
| What happens if a StatefulSet pod is deleted?              | Kubernetes recreates it with the same identity.                                                                               |
| What happens when a StatefulSet is scaled down?            | Higher-numbered pods are removed first; PVCs are normally retained by default.                                                |
| What is OrderedReady?                                      | StatefulSet pods are created and updated in a controlled order.                                                               |
| What is Parallel pod management?                           | It allows StatefulSet pods to be created or removed without waiting for each other.                                           |
| Can we use HPA with StatefulSet?                           | Yes, if appropriate scaling metrics and application behavior support it.                                                      |
| What is RWO storage?                                       | ReadWriteOnce allows read-write mounting by one node at a time; multiple pods on that node may still access it.               |
| What is RWX storage?                                       | ReadWriteMany supports read-write mounting from multiple nodes when the storage system supports it.                           |
| What is the difference between EBS and EFS?                | EBS is block storage; EFS is a shared file system.                                                                            |
| Can Kubernetes automatically roll back failed Deployments? | Kubernetes reports failed rollouts, but automatic rollback generally requires external automation or a deployment controller. |

## Last-Minute Kubernetes Command Revision

```
# Check all major workloads
kubectl get deploy,sts,ds -A

# Check pods
kubectl get pods -n production -o wide

# Check pod error
kubectl describe pod <pod-name> -n production

# Check previous container logs
kubectl logs <pod-name> -n production --previous

# Check persistent storage
kubectl get pv,pvc -A

# Check rollout
kubectl rollout status deployment/nginx-web \
  -n production

# Check rollout history
kubectl rollout history deployment/nginx-web \
  -n production

# Rollback Deployment after approval
kubectl rollout undo deployment/nginx-web \
  -n production

# Check Service and Ingress
kubectl get svc,ingress -n production

# Check Kubernetes events
kubectl get events -n production \
  --sort-by=.lastTimestamp
```

End of Subtopic 1.2 – Kubernetes Deployments, StatefulSets and Nginx

19 detailed questions + 12 additional interview questions, covering your HR question, practical Kubernetes commands, rollback, storage, migration, deployment failures, and SRE production scenarios.

Next in the preparation sequence: Subtopic 1.3 – Kubernetes Services, Networking, Ingress, Load Balancers, and Real-Time Networking Troubleshooting.

# X Company – SRE Interview Preparation

## Section 1: Kubernetes

### Subtopic 1.3: Kubernetes Services, Networking, Ingress and Load Balancers

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: HR questions + additional interview questions + practical production commands + real-time troubleshooting scenarios.

### Example Production Environment

```
Cloud         : AWS
Cluster       : Amazon EKS
Namespace     : production
Application   : payment-service
App Port      : 8080
CI/CD         : Jenkins + Argo CD
Load Balancer : AWS ALB / NLB
Monitoring    : Prometheus + Grafana
```

### Q1. What are the different types of Services in Kubernetes?

Interview Answer:

Kubernetes provides four main Service types:

1. ClusterIP: Exposes applications inside the Kubernetes cluster.
2. NodePort: Exposes applications using a port on Kubernetes nodes.
3. LoadBalancer: Exposes applications through a cloud load balancer.
4. ExternalName: Maps a Kubernetes Service name to an external DNS name.

Production Commands:

```
# List all Services
kubectl get svc -A

# Check a specific Service
kubectl describe svc payment-service \
  -n production

# Check Service YAML
kubectl get svc payment-service \
  -n production -o yaml
```

Real-Time Scenario: In our example project, we use ClusterIP for internal microservices and an AWS ALB with Kubernetes Ingress for external application traffic.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q2. What is the difference between ClusterIP, NodePort, and LoadBalancer?

Interview Answer:

| Type         | Purpose                         | Example                         |
| ------------ | ------------------------------- | ------------------------------- |
| ClusterIP    | Internal communication          | Backend API                     |
| NodePort     | Access through node IP and port | Testing or special integrations |
| LoadBalancer | Access through cloud LB         | Public or private applications  |

Production Commands:

```
# Check Service types
kubectl get svc -n production

# Check NodePort configuration
kubectl get svc payment-service \
  -n production -o yaml
```

Real-Time Scenario: If a frontend needs to communicate with a backend inside EKS, we use ClusterIP. If an application must be exposed externally, we normally use an Ingress with ALB or an appropriate LoadBalancer Service.

### Q3. How do you create a ClusterIP Service in Kubernetes?

Interview Answer:

We create a Service YAML with type ClusterIP, a selector that matches the application pods, and the correct application port.

The Service provides a stable endpoint even if pod IP addresses change.

Example `payment-service.yaml`:

```
apiVersion: v1
kind: Service
metadata:
  name: payment-service
  namespace: production
spec:
  type: ClusterIP
  selector:
    app: payment-service
  ports:
    - port: 80
      targetPort: 8080
      protocol: TCP
```

Production Commands:

```
# Validate YAML
kubectl apply --dry-run=client \
  -f payment-service.yaml

# Apply after approval
kubectl apply -f payment-service.yaml

# Verify Service
kubectl get svc payment-service \
  -n production

# Check backend endpoints
kubectl get endpointslices \
  -n production \
  -l kubernetes.io/service-name=payment-service
```

Real-Time Scenario: Our frontend communicates with the backend using:

```
http://payment-service.production.svc.cluster.local
```

The Service forwards traffic to ready backend pods selected by its labels.

### Q4. What is the difference between port, targetPort, and nodePort?

Interview Answer:

- port: Port exposed by the Kubernetes Service.
- targetPort: Port on which the container application is listening.
- nodePort: Port exposed on Kubernetes nodes when NodePort is used.

Example YAML:

```
spec:
  type: NodePort
  ports:
    - port: 80
      targetPort: 8080
      nodePort: 30080
```

Traffic Flow:

```
Node IP:30080
     |
     v
Service Port:80
     |
     v
Pod Port:8080
```

Production Commands:

```
kubectl get svc payment-service \
  -n production

kubectl describe svc payment-service \
  -n production
```

Real-Time Scenario: If the application listens on port 8080, the Service can expose port 80 and forward traffic to 8080.

### Q5. What is Kubernetes Ingress, and how does it work?

Interview Answer:

Ingress manages HTTP and HTTPS traffic entering the Kubernetes cluster.

It supports host-based and path-based routing to different Kubernetes Services.

An Ingress Controller is required to implement these rules.

Production Commands:

```
# Check Ingress resources
kubectl get ingress -A

# Check Ingress Controller classes
kubectl get ingressclass

# Describe application Ingress
kubectl describe ingress payment-ingress \
  -n production
```

Real-Time Scenario:

```
User
 |
 v
AWS ALB
 |
 +-- /payment --> Payment Service
 |
 +-- /orders  --> Order Service
 |
 v
Kubernetes Pods
```

Follow-Up: What happens if there is no Ingress Controller?

Answer: Ingress rules will not route traffic by themselves. We need a compatible controller, such as AWS Load Balancer Controller or another supported Ingress controller.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q6. How do you configure AWS ALB with EKS in production?

Interview Answer:

We install and configure AWS Load Balancer Controller with the required IAM permissions.

Then we create an Ingress resource with routing rules. The controller provisions and manages an AWS Application Load Balancer.

Example `payment-ingress.yaml`:

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: payment-ingress
  namespace: production
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
spec:
  ingressClassName: alb
  rules:
    - host: payments.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: payment-service
                port:
                  number: 80
```

Production Commands:

```
# Check AWS Load Balancer Controller
kubectl get deployment \
  aws-load-balancer-controller \
  -n kube-system

# Validate Ingress
kubectl apply --dry-run=client \
  -f payment-ingress.yaml

# Apply after approval
kubectl apply -f payment-ingress.yaml

# Verify ALB address
kubectl get ingress payment-ingress \
  -n production

# Check controller logs
kubectl logs -n kube-system \
  deployment/aws-load-balancer-controller \
  --tail=100
```

Real-Time Scenario: When an application must be accessible through `payments.example.com`, the AWS Load Balancer Controller creates an ALB and routes traffic to the payment-service pods.

Important: This is a basic HTTP example. Actual production deployment additionally requires approved subnets, IAM permissions, security groups, DNS, and TLS configuration.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q7. What is the difference between AWS ALB and NLB?

Interview Answer:

ALB works at Layer 7 and supports HTTP/HTTPS routing based on hostnames and URL paths.

NLB works at Layer 4 and is mainly used for TCP, UDP, and TLS traffic.

| AWS ALB                     | AWS NLB                  |
| --------------------------- | ------------------------ |
| Layer 7                     | Layer 4                  |
| HTTP/HTTPS                  | TCP/UDP/TLS              |
| Path-based routing          | Connection-level routing |
| Common for web applications | Common for TCP services  |

Production Commands:

```
# Check Kubernetes Services
kubectl get svc -A

# Check Ingress resources
kubectl get ingress -A

# Check AWS load balancers
aws elbv2 describe-load-balancers \
  --region ap-south-1
```

Real-Time Scenario: For a payment REST API, we use ALB for HTTPS and routing rules. For a service requiring TCP connectivity, NLB may be a better choice.

### Q8. How do you create an AWS NLB using Kubernetes?

Interview Answer:

We create a Kubernetes Service of type LoadBalancer and use AWS Load Balancer Controller annotations to provision an NLB.

Example `payment-nlb.yaml`:

```
apiVersion: v1
kind: Service
metadata:
  name: payment-nlb
  namespace: production
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "external"
    service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: "ip"
    service.beta.kubernetes.io/aws-load-balancer-scheme: "internal"
spec:
  type: LoadBalancer
  selector:
    app: payment-service
  ports:
    - port: 80
      targetPort: 8080
      protocol: TCP
```

Production Commands:

```
# Apply after approval
kubectl apply -f payment-nlb.yaml

# Check LoadBalancer
kubectl get svc payment-nlb \
  -n production

# Check Service events
kubectl describe svc payment-nlb \
  -n production

# Check provisioned AWS LB
aws elbv2 describe-load-balancers \
  --region ap-south-1
```

Real-Time Scenario: We use an internal NLB when a backend service needs a private load-balanced endpoint inside the organization's network.

AWS Load Balancer Controller must be installed and correctly configured for this example.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q9. For HTTPS in an AWS Load Balancer, do we need HTTP port 80 also?

Interview Answer:

No, HTTP port 80 is not mandatory.

We can configure only HTTPS port 443. Port 80 is optional and is commonly used to redirect HTTP requests to HTTPS.

Example ALB Ingress Annotations:

```
annotations:
  alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS":443}]'
  alb.ingress.kubernetes.io/certificate-arn: <acm-certificate-arn>
  alb.ingress.kubernetes.io/target-type: ip
```

Production Commands:

```
# Check Ingress TLS configuration
kubectl describe ingress payment-ingress \
  -n production

# Verify HTTPS
curl -Iv https://payments.example.com

# Check ALB listeners
aws elbv2 describe-listeners \
  --load-balancer-arn <alb-arn>
```

Real-Time Scenario: In production, we terminate HTTPS at ALB using an AWS ACM certificate. We can also configure HTTP-to-HTTPS redirection if required.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q10. Kubernetes pods are Running, but the application is not accessible. How do you troubleshoot?

Interview Answer:

First, I check pod readiness and application logs. Then I verify the Service selector, endpoints, target port, Ingress configuration, and load balancer health.

Production Commands:

```
# Check pods
kubectl get pods -n production

# Check Service
kubectl get svc -n production

# Check backend endpoints
kubectl get endpointslices -n production

# Check Ingress
kubectl get ingress -n production

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=100
```

Real-Time Scenario: Pods were Running, but the Service had no ready endpoints because its selector did not match pod labels. We corrected the labels through GitOps and restored connectivity.

### Q11. A Kubernetes Service has no endpoints. What could be the problem?

Interview Answer:

The main reasons are incorrect Service selectors, mismatched pod labels, or pods not being Ready.

I compare the Service selector with pod labels and check readiness failures.

Production Commands:

```
# Check Service selector
kubectl describe svc payment-service \
  -n production

# Check pod labels
kubectl get pods -n production \
  --show-labels

# Check endpoints
kubectl get endpointslices \
  -n production \
  -l kubernetes.io/service-name=payment-service

# Check pod readiness
kubectl describe pod <pod-name> \
  -n production
```

Real-Time Scenario: The Service used selector `app=payment-api`, but pods had label `app=payment-service`.

After correcting the selector, Kubernetes automatically updated the Service endpoints.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q12. Two microservices cannot communicate inside Kubernetes. How do you troubleshoot?

Interview Answer:

I check Service DNS, pod readiness, application ports, NetworkPolicies, and connectivity between the microservices.

Production Commands:

```
# Check Services
kubectl get svc -n production

# Check NetworkPolicies
kubectl get networkpolicy -n production

# Check endpoints
kubectl get endpointslices -n production

# Test connectivity from an approved debug pod
nslookup payment-service.production.svc.cluster.local

curl -v http://payment-service.production.svc.cluster.local
```

The final two commands run inside a pod with DNS and curl utilities.

Real-Time Scenario: Order Service could not connect to Payment Service because a NetworkPolicy blocked port 8080. We corrected the approved policy and restored communication.

### Q13. How do you troubleshoot DNS resolution issues in Kubernetes?

Interview Answer:

I check CoreDNS pods, the kube-dns Service, DNS resolution, and network connectivity.

I also verify whether NetworkPolicies are blocking DNS traffic on port 53.

Production Commands:

```
# Check CoreDNS pods
kubectl get pods -n kube-system \
  -l k8s-app=kube-dns

# Check DNS Service
kubectl get svc kube-dns -n kube-system

# Check CoreDNS logs
kubectl logs -n kube-system \
  -l k8s-app=kube-dns --tail=100

# Test DNS from a debug pod
nslookup payment-service.production.svc.cluster.local
```

Real-Time Scenario: Multiple microservices started failing because DNS resolution was not working. I checked CoreDNS availability, logs, and DNS connectivity before applying the necessary fix.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q14. AWS ALB is returning 502, 503, or 504 errors. How do you troubleshoot?

Interview Answer:

I identify the error code and check ALB target health, application logs, connectivity, and request latency.

| Error                   | Common Reason                                           |
| ----------------------- | ------------------------------------------------------- |
| 502 Bad Gateway         | Invalid response or connection failure to backend       |
| 503 Service Unavailable | No available healthy targets or backend                 |
| 504 Gateway Timeout     | Backend is not responding within the configured timeout |

Production Commands:

```
# Check pods
kubectl get pods -n production

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=200

# Check Ingress
kubectl describe ingress payment-ingress \
  -n production

# Check AWS target health
aws elbv2 describe-target-health \
  --target-group-arn <target-group-arn>
```

Real-Time Scenario: ALB returned 503 because there were no healthy backend targets. We investigated the readiness endpoint and target-group health checks, corrected the configuration, and verified that targets became healthy.

### Q15. A Kubernetes LoadBalancer Service is stuck in Pending. What will you do?

Interview Answer:

I check Service events, AWS Load Balancer Controller logs, IAM permissions, subnet configuration, and load balancer provisioning errors.

Production Commands:

```
# Check Service
kubectl get svc payment-nlb \
  -n production

# Check events
kubectl describe svc payment-nlb \
  -n production

# Check AWS controller
kubectl logs -n kube-system \
  deployment/aws-load-balancer-controller \
  --tail=100
```

Real-Time Scenario: An NLB was not created because AWS Load Balancer Controller could not discover suitable subnets. We corrected the subnet configuration and verified provisioning.

### Q16. What is Kubernetes NetworkPolicy, and how do you implement it?

Interview Answer:

NetworkPolicy controls which pods can communicate with other pods or external networks.

We use it to restrict unnecessary traffic between applications and improve Kubernetes network security.

Example: Allow only pods labeled `app: order-service` to access Payment Service on port 8080 within the same namespace.

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: payment-network-policy
  namespace: production
spec:
  podSelector:
    matchLabels:
      app: payment-service
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: order-service
      ports:
        - protocol: TCP
          port: 8080
```

Production Commands:

```
# Check policies
kubectl get networkpolicy -n production

# Check policy rules
kubectl describe networkpolicy \
  payment-network-policy -n production

# Validate a new policy
kubectl apply --dry-run=client \
  -f networkpolicy.yaml
```

Real-Time Scenario: We restrict direct access to Payment Service so only approved applications can communicate with it.

Important: NetworkPolicy requires a compatible CNI implementation. Test changes in staging and account for load balancer health checks and other required traffic before applying restrictions.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q17. What is the role of CNI and kube-proxy in Kubernetes networking?

Interview Answer:

CNI provides pod networking and IP address management.

kube-proxy implements Kubernetes Service networking and routes traffic to backend pods in clusters that use it.

In EKS, the Amazon VPC CNI plugin commonly provides pod networking.

Production Commands:

```
# Check AWS VPC CNI
kubectl get daemonset aws-node \
  -n kube-system

# Check kube-proxy
kubectl get daemonset kube-proxy \
  -n kube-system

# Check CNI logs
kubectl logs -n kube-system \
  daemonset/aws-node --tail=100
```

Real-Time Scenario: If pods cannot obtain IP addresses, I check VPC CNI logs, IAM permissions, available subnet IPs, and node networking.

Some clusters use alternative service-routing implementations instead of kube-proxy.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q18. How do you troubleshoot pods that cannot access the internet?

Interview Answer:

I check DNS resolution, NetworkPolicies, VPC route tables, NAT Gateway, security groups, and outbound connectivity.

For private EKS nodes, internet access normally requires suitable routing through NAT or another approved network path.

Production Commands:

```
# Check pod and node placement
kubectl get pods -n production -o wide

# Check NetworkPolicies
kubectl get networkpolicy -n production

# Test DNS from an approved debug pod
nslookup example.com

# Test HTTPS
curl -I --connect-timeout 5 \
  https://example.com

# Check AWS VPC route tables
aws ec2 describe-route-tables \
  --region ap-south-1
```

Real-Time Scenario: Application pods cannot download required data because their private subnet has no working outbound route. We verify routing and NAT configuration with the networking team.

### Q19. How do you perform an application traffic migration without downtime?

Interview Answer:

We deploy and test the new application version, verify readiness and health checks, and gradually switch traffic.

For critical applications, we can use Blue-Green or Canary deployment strategies.

Production Steps:

```
1. Deploy new application version
2. Verify pod readiness
3. Test new application endpoint
4. Check monitoring dashboards
5. Gradually switch traffic
6. Monitor errors and latency
7. Roll back traffic if required
```

Production Commands:

```
# Check old and new Deployments
kubectl get deployments -n production

# Check readiness
kubectl get pods -n production

# Check Ingress routes
kubectl get ingress -n production

# Monitor application rollout
kubectl rollout status \
  deployment/payment-service \
  -n production
```

Real-Time Scenario: We deploy version `v2`, test its health, shift a small percentage of traffic to it using supported traffic-routing tooling, and increase traffic after successful validation.

## Bonus: Additional Second-Round SRE Questions

| Question                                              | Short Interview Answer                                                                   |
| ----------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| What is the default Kubernetes Service type?          | ClusterIP.                                                                               |
| What is the default NodePort range?                   | Usually 30000–32767, unless configured differently.                                      |
| Can ClusterIP be accessed from the internet directly? | Not normally. It is intended for cluster-internal access.                                |
| Does Ingress work without a controller?               | No, a compatible Ingress Controller is required.                                         |
| Can multiple applications share an AWS ALB?           | Yes, using appropriate Ingress rules and controller configuration.                       |
| What is path-based routing?                           | Routing requests based on URL paths such as `/orders` and `/payments`.                   |
| What is host-based routing?                           | Routing traffic based on domains such as `api.example.com`.                              |
| What is TLS termination?                              | Decrypting HTTPS traffic at an approved endpoint such as an ALB.                         |
| What is an EndpointSlice?                             | A Kubernetes object containing backend network endpoints for a Service.                  |
| What is CoreDNS?                                      | It provides DNS-based service discovery inside Kubernetes.                               |
| What is a headless Service?                           | A Service without a virtual ClusterIP, useful for direct endpoint discovery.             |
| What is AWS VPC CNI?                                  | A Kubernetes networking plugin used to provide pod networking in EKS.                    |
| What is the difference between Ingress and Service?   | A Service exposes application endpoints; Ingress defines HTTP/HTTPS routing to Services. |
| Can Kubernetes NetworkPolicy block all traffic?       | Yes, for supported traffic types when enforced by a compatible network plugin.           |
| What is Gateway API?                                  | A newer, more flexible Kubernetes API for traffic routing and gateway management.        |

## Last-Minute Kubernetes Networking Commands

```
# Check Services
kubectl get svc -A

# Check Ingress
kubectl get ingress -A

# Check network policies
kubectl get networkpolicy -A

# Check pod IPs
kubectl get pods -n production -o wide

# Check Service endpoints
kubectl get endpointslices -n production

# Check CoreDNS
kubectl get pods -n kube-system \
  -l k8s-app=kube-dns

# Check VPC CNI
kubectl get ds aws-node -n kube-system

# Check ALB controller
kubectl get deployment \
  aws-load-balancer-controller \
  -n kube-system

# Check AWS load balancers
aws elbv2 describe-load-balancers \
  --region ap-south-1
```

End of Subtopic 1.3 – Kubernetes Services, Networking, Ingress and Load Balancers

19 detailed interview questions + 15 bonus questions. Covers your HR questions, AWS ALB/NLB configuration, practical commands, DNS, NetworkPolicies, and production networking issues.

Next: Subtopic 1.4 – Kubernetes Pod Troubleshooting: CrashLoopBackOff, ImagePullBackOff, Pending Pods, OOMKilled, CPU/Memory Issues, and Real-Time Production Incidents.

# X Company – SRE Interview Preparation

## Section 1: Kubernetes

### Subtopic 1.4: Kubernetes Pod Troubleshooting and Real-Time Production Incidents

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: HR questions + additional SRE interview questions + practical commands + real-world troubleshooting.

### Example Production Environment

```
Cloud       : AWS
Cluster     : Amazon EKS
Namespace   : production
Application : payment-service
Monitoring  : Prometheus + Grafana
CI/CD       : Jenkins + Argo CD
```

Production Note: During incidents, first identify the issue and its customer impact. Any configuration changes or rollback should follow the organization's incident and change-management process.

### Q1. How do you troubleshoot a Kubernetes pod in production?

Interview Answer:

First, I check the pod status using `kubectl get pods`. Then I use `kubectl describe pod` to check events and `kubectl logs` to identify application errors.

I also check CPU, memory, node health, and networking based on the issue.

Production Commands:

```
# Check pod status
kubectl get pods -n production

# Check complete pod details
kubectl describe pod <pod-name> -n production

# Check application logs
kubectl logs <pod-name> -n production

# Check previous crash logs
kubectl logs <pod-name> -n production --previous

# Check resource usage
kubectl top pod <pod-name> -n production

# Check recent events
kubectl get events -n production \
  --sort-by=.lastTimestamp
```

Real-Time Scenario: A payment application stops responding. I check pod status, logs, events, and resource usage, identify the root cause, and restore service.

### Q2. What is CrashLoopBackOff, and how do you resolve it?

Interview Answer:

CrashLoopBackOff means a container is repeatedly crashing, and Kubernetes is delaying its next restart attempt.

Common reasons include application errors, incorrect configuration, memory issues, and failing health checks.

Production Commands:

```
# Check failing pods
kubectl get pods -n production

# Check failure reason
kubectl describe pod <pod-name> -n production

# Check previous logs
kubectl logs <pod-name> \
  -n production --previous

# Check restart count
kubectl get pods -n production
```

Real-Time Scenario: A new application version crashes because a required environment variable is missing. I identify the missing configuration, correct it in Git, and redeploy the application.

Follow-Up: Will deleting the pod fix CrashLoopBackOff?

Answer: Not necessarily. Kubernetes may recreate the pod, but it can crash again unless we fix the root cause.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://v1-34.docs.kubernetes.io\&sz=32)

Kubernetes



### Q3. What is OOMKilled, and how do you troubleshoot it?

Interview Answer:

OOMKilled means the container was terminated because it exceeded its memory limit or encountered an out-of-memory condition.

I check memory usage, configured limits, application logs, and memory trends in Grafana.

Production Commands:

```
# Check pod termination reason
kubectl describe pod <pod-name> -n production

# Check memory usage
kubectl top pods -n production

# Check resource limits
kubectl get deployment payment-service \
  -n production -o yaml

# Check previous logs
kubectl logs <pod-name> \
  -n production --previous
```

Example Error:

```
Reason: OOMKilled
Exit Code: 137
```

Real-Time Scenario: The application consumes more memory after a new release. I check whether it is caused by a memory leak or an insufficient memory limit, then apply the appropriate fix.

Follow-Up: How do you increase memory limits?

Example YAML:

```
resources:
  requests:
    memory: 256Mi
  limits:
    memory: 1Gi
```

We update this in the approved Helm values or Deployment configuration and redeploy.

### Q4. A pod is stuck in Pending. How do you troubleshoot?

Interview Answer:

Pending means the pod has not completed scheduling or startup preparation.

Common reasons include insufficient CPU or memory, node selectors, taints, unavailable PVCs, or storage problems.

I check pod events and node availability.

Production Commands:

```
# Check Pending pods
kubectl get pods -n production

# Check scheduling events
kubectl describe pod <pod-name> -n production

# Check available nodes
kubectl get nodes

# Check node resource usage
kubectl top nodes

# Check storage claims
kubectl get pvc -n production
```

Example Error:

```
0/3 nodes are available:
3 Insufficient cpu
```

Real-Time Scenario: New pods cannot start because worker nodes lack CPU capacity. I verify resource requests, node utilization, and available autoscaling options.

Follow-Up: What if Cluster Autoscaler is configured?

Answer: Cluster Autoscaler may add nodes when eligible unschedulable pods require more capacity, provided scaling limits and node-group constraints allow it.

### Q5. What is ImagePullBackOff, and how do you resolve it?

Interview Answer:

ImagePullBackOff means Kubernetes cannot pull the container image and is retrying with a delay.

Common reasons include incorrect image tags, missing images, registry authentication issues, and network failures.

Production Commands:

```
# Check pod errors
kubectl get pods -n production

# Check image pull events
kubectl describe pod <pod-name> -n production

# Check configured image
kubectl get deployment payment-service \
  -n production \
  -o=jsonpath='{.spec.template.spec.containers[*].image}'

# Verify ECR images
aws ecr describe-images \
  --repository-name payment-service \
  --region ap-south-1
```

Real-Time Scenario: Jenkins deployed image tag `v2`, but the image was not available in ECR. I verify the CI pipeline and ECR image, correct the GitOps image reference, and redeploy.

Follow-Up: Difference between ErrImagePull and ImagePullBackOff?

Answer: ErrImagePull indicates an image pull failure. ImagePullBackOff means Kubernetes is delaying retries after failures.

### Q6. What is CreateContainerConfigError?

Interview Answer:

CreateContainerConfigError means Kubernetes cannot create the container because its configuration is invalid or required configuration is missing.

Common reasons include missing Secrets, ConfigMaps, or incorrect environment variable references.

Production Commands:

```
# Check error details
kubectl describe pod <pod-name> -n production

# Check ConfigMaps
kubectl get configmaps -n production

# Check Secret names
kubectl get secrets -n production

# Check Deployment configuration
kubectl get deployment payment-service \
  -n production -o yaml
```

Real-Time Scenario: A Deployment references a Secret that does not exist in the namespace. I verify the Secret name and restore the approved configuration using our secrets management process.

### Q7. The pod is Running but shows 0/1 Ready. What will you do?

Interview Answer:

Running means the pod has started, but `0/1 Ready` means its container is not ready to serve traffic.

I check readiness probes, application logs, port configuration, and dependencies such as databases.

Production Commands:

```
# Check readiness
kubectl get pods -n production

# Check probe failures
kubectl describe pod <pod-name> -n production

# Check application logs
kubectl logs <pod-name> -n production

# Check Service endpoints
kubectl get endpointslices -n production
```

Real-Time Scenario: The application is running, but its database connection fails, causing the readiness probe to fail.

I investigate database connectivity and restore the dependency.

### Q8. What is the difference between liveness, readiness, and startup probes?

Interview Answer:

- Liveness Probe: Checks whether the container needs restarting.
- Readiness Probe: Checks whether the pod can receive traffic.
- Startup Probe: Checks whether an application has finished starting.

Example YAML:

```
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  periodSeconds: 10

livenessProbe:
  httpGet:
    path: /health
    port: 8080
  periodSeconds: 10

startupProbe:
  httpGet:
    path: /health
    port: 8080
  failureThreshold: 30
  periodSeconds: 10
```

Production Commands:

```
kubectl describe pod <pod-name> -n production

kubectl get deployment payment-service \
  -n production -o yaml
```

Real-Time Scenario: A Java application takes two minutes to start. We configure a startup probe to avoid restarting the container before initialization completes.

Follow-Up: Does readiness probe failure restart the container?

Answer: No. Readiness failure marks the pod NotReady and removes it from normal Service traffic. Liveness failure can trigger a restart.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q9. A Kubernetes pod is consuming high CPU. How do you troubleshoot?

Interview Answer:

First, I check CPU usage using `kubectl top`. Then I review CPU requests, limits, application logs, and Prometheus metrics.

I check whether high CPU is caused by increased traffic, inefficient code, or CPU throttling.

Production Commands:

```
# Check pod CPU
kubectl top pods -n production

# Check node CPU
kubectl top nodes

# Check resource configuration
kubectl describe deployment payment-service \
  -n production

# Check HPA
kubectl get hpa -n production
```

Real-Time Scenario: During peak traffic, CPU usage reaches 90%. I verify latency and CPU throttling, check whether HPA is scaling, and coordinate capacity or application changes.

Follow-Up: How do you configure HPA?

```
# Example for a non-GitOps test environment
kubectl autoscale deployment payment-service \
  --cpu-percent=70 \
  --min=3 \
  --max=10 \
  -n production
```

In production, I configure HPA through GitOps. CPU-based utilization scaling also requires suitable resource requests and working metrics.

### Q10. A pod is consuming high memory, but it is not OOMKilled. What will you do?

Interview Answer:

I check current memory usage, memory requests and limits, and Grafana memory trends.

I also check whether memory usage is continuously increasing, which may indicate a memory leak.

Production Commands:

```
# Check memory usage
kubectl top pod <pod-name> -n production

# Check resource configuration
kubectl describe pod <pod-name> -n production

# Check application logs
kubectl logs <pod-name> \
  -n production --tail=100
```

Real-Time Scenario: Application memory keeps increasing after a deployment. I investigate memory usage trends, application changes, and possible memory leaks before adjusting limits.

### Q11. What does Evicted mean in Kubernetes?

Interview Answer:

Evicted means Kubernetes removed a pod, usually because the node experienced resource pressure, such as insufficient memory or disk space.

I check node conditions, resource usage, and eviction events.

Production Commands:

```
# Check evicted pods
kubectl get pods -n production \
  --field-selector=status.phase=Failed

# Check eviction reason
kubectl describe pod <pod-name> -n production

# Check node conditions
kubectl describe node <node-name>

# Check node resource usage
kubectl top nodes
```

Real-Time Scenario: A node runs out of disk space and Kubernetes evicts application pods. I identify what consumed disk space and restore healthy node capacity.

Follow-Up: Can PodDisruptionBudget prevent resource-pressure eviction?

Answer: No. Node-pressure eviction can happen even when a PodDisruptionBudget is configured.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q12. A pod is stuck in Terminating. How do you troubleshoot?

Interview Answer:

I check whether the application is waiting for graceful shutdown, whether the node is reachable, and whether storage cleanup or finalizers are blocking termination.

I avoid force deletion unless the root cause is understood.

Production Commands:

```
# Check pod
kubectl get pod <pod-name> -n production

# Check events and termination status
kubectl describe pod <pod-name> -n production

# Check pod configuration
kubectl get pod <pod-name> \
  -n production -o yaml

# Check node
kubectl get nodes
```

Real-Time Scenario: A pod cannot terminate because its shutdown process is stuck. I check termination hooks and application logs before taking corrective action.

### Q13. A Kubernetes worker node becomes NotReady. How do you troubleshoot?

Interview Answer:

First, I check the node status and conditions.

Then I verify CPU, memory, disk pressure, node networking, and kubelet health.

For EKS, I also check EC2 instance health and Auto Scaling Group status.

Production Commands:

```
# Check nodes
kubectl get nodes

# Inspect unhealthy node
kubectl describe node <node-name>

# Check affected pods
kubectl get pods -A -o wide

# Check EKS node groups
aws eks list-nodegroups \
  --cluster-name prod-eks \
  --region ap-south-1
```

Real-Time Scenario: An EC2 worker node becomes NotReady due to a system issue. I verify the node condition and coordinate recovery or replacement while monitoring application availability.

### Q14. A pod cannot mount its PVC. How do you troubleshoot?

Interview Answer:

I check PVC status, PersistentVolume availability, StorageClass, and Kubernetes events.

In EKS, I also verify the EBS CSI driver, IAM permissions, and Availability Zone compatibility.

Production Commands:

```
# Check PVC
kubectl get pvc -n production

# Describe PVC
kubectl describe pvc <pvc-name> \
  -n production

# Check PV
kubectl get pv

# Check StorageClass
kubectl get sc

# Check EBS CSI driver
kubectl get pods -n kube-system \
  | grep ebs-csi
```

Real-Time Scenario: A pod cannot mount its EBS volume after moving to a node in another Availability Zone. I check volume topology and schedule the workload on a compatible node.

### Q15. A pod cannot connect to another microservice. How do you troubleshoot?

Interview Answer:

I check DNS resolution, Kubernetes Service, endpoints, application ports, and NetworkPolicies.

Then I test connectivity from an approved debugging pod.

Production Commands:

```
# Check Services
kubectl get svc -n production

# Check endpoints
kubectl get endpointslices -n production

# Check NetworkPolicies
kubectl get networkpolicy -n production

# Check CoreDNS
kubectl get pods -n kube-system \
  -l k8s-app=kube-dns
```

Inside an approved debug container:

```
# Test DNS
nslookup payment-service.production.svc.cluster.local

# Test application connectivity
curl -v http://payment-service:8080/health
```

Real-Time Scenario: Order Service cannot connect to Payment Service due to an incorrect Service port. I verify the Service configuration and correct the mapping.

### Q16. A new application deployment causes CrashLoopBackOff. How do you restore production?

Interview Answer:

First, I check the failed pods and compare the new deployment with the previous stable version.

If the new release is causing customer impact, I follow the incident process and restore the previous stable image using GitOps rollback.

Production Commands:

```
# Check application pods
kubectl get pods -n production

# Check previous container logs
kubectl logs <pod-name> \
  -n production --previous

# Check rollout history
kubectl rollout history \
  deployment/payment-service -n production

# Check Argo CD history
argocd app history payment-prod

# Check Git commits
git log --oneline -5
```

Rollback Process:

```
1. Identify failed application version
2. Confirm previous stable version
3. Revert the failed change in Git
4. Merge after approval
5. Sync Argo CD
6. Verify pods, errors and latency
```

Real-Time Scenario: Payment Service version `v2` crashes after deployment. We restore the previous stable version `v1` and verify that the application is serving requests.

### Q17. A pod has multiple containers. How do you check logs for a specific container?

Interview Answer:

In multi-container pods, I use the `-c` option to specify the container name.

This is commonly needed when the application runs with a sidecar container.

Production Commands:

```
# Check pod containers
kubectl describe pod <pod-name> -n production

# Check application container logs
kubectl logs <pod-name> \
  -c payment-service -n production

# Check sidecar logs
kubectl logs <pod-name> \
  -c log-agent -n production

# Check all container logs
kubectl logs <pod-name> \
  --all-containers=true -n production
```

Real-Time Scenario: Application logs look normal, but the logging sidecar is crashing. I separately investigate sidecar logs and configuration.

### Q18. How do you troubleshoot a container that does not have Bash or debugging utilities?

Interview Answer:

Some production images are minimal or distroless and do not include Bash, curl, or other debugging tools.

In such cases, I use `kubectl debug` with an approved debugging image, if permitted by the organization's security policy.

Production Commands:

```
# Try normal container access
kubectl exec -it <pod-name> \
  -n production -- sh

# Use an ephemeral debug container if approved
kubectl debug -it <pod-name> \
  -n production \
  --image=busybox:1.36 \
  --target=payment-service \
  -- sh
```

Real-Time Scenario: A production container does not have `curl` installed. I use an approved ephemeral debugging container to investigate connectivity without rebuilding the production image.

Follow-Up: What are ephemeral containers?

Answer: They are temporary debugging containers added to an existing pod for troubleshooting.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q19. EKS pods are not starting because IP addresses cannot be assigned. How do you troubleshoot?

Interview Answer:

In EKS, the AWS VPC CNI usually assigns VPC IP addresses to pods.

If IP allocation fails, I check subnet availability, node IP limits, VPC CNI logs, and IAM permissions.

Production Commands:

```
# Check pods
kubectl get pods -n production

# Check failed pod events
kubectl describe pod <pod-name> \
  -n production

# Check AWS VPC CNI
kubectl get pods -n kube-system \
  -l k8s-app=aws-node

# Check VPC CNI logs
kubectl logs -n kube-system \
  daemonset/aws-node \
  --tail=100

# Check subnet IP availability
aws ec2 describe-subnets \
  --query 'Subnets[*].[SubnetId,AvailableIpAddressCount]' \
  --output table
```

Real-Time Scenario: The cluster has available CPU and memory, but new pods fail because the nodes cannot allocate more IP addresses.

I investigate subnet capacity, instance networking limits, and supported VPC CNI IP allocation options.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS

+1



### Q20. A production application is completely down. As an SRE, what steps will you take?

Interview Answer:

First, I acknowledge the incident and check its severity and customer impact.

Then I review application health, pod status, recent deployments, logs, infrastructure, and monitoring dashboards.

If the issue started after a deployment, I consider rolling back to the last stable version.

After service recovery, I participate in root cause analysis and document preventive actions.

Production Commands:

```
# Check cluster nodes
kubectl get nodes

# Check application pods
kubectl get pods -n production

# Check Deployments
kubectl get deployments -n production

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=100

# Check events
kubectl get events -n production \
  --sort-by=.lastTimestamp

# Check Argo CD
argocd app get payment-prod
```

Real-Time Scenario:

```
Production Alert
      |
      v
Acknowledge Incident
      |
      v
Check Customer Impact
      |
      v
Check Grafana + Kubernetes
      |
      v
Identify Root Cause
      |
      v
Mitigate / Rollback
      |
      v
Verify Recovery
      |
      v
RCA + Preventive Actions
```

Follow-Up: What is the difference between mitigation and permanent resolution?

Answer:

Mitigation restores service quickly, such as rolling back a faulty deployment.

Permanent resolution fixes the actual root cause, such as correcting the application code or configuration.

## Bonus: Additional SRE Interview Questions

| Question                                                  | Short Interview Answer                                                                   |
| --------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| What does `kubectl describe` show?                        | Pod configuration, container state, conditions, and events.                              |
| Difference between `kubectl logs` and `kubectl describe`? | Logs show container output; describe shows resource details and events.                  |
| What does `--previous` do?                                | Shows logs from the previous terminated container instance.                              |
| What is exit code 137?                                    | The process received SIGKILL; often caused by OOM, but not always.                       |
| What is exit code 143?                                    | The process terminated after SIGTERM, often during graceful shutdown.                    |
| What is Exit Code 1?                                      | The process exited with a general application error.                                     |
| What is CPU throttling?                                   | Kubernetes limits CPU execution when the configured CPU limit is reached.                |
| What is a Sidecar container?                              | A supporting container running alongside the main application.                           |
| What is InitContainer?                                    | A container that runs before the main application containers start.                      |
| What is DiskPressure?                                     | A node condition indicating storage-related resource pressure.                           |
| What is MemoryPressure?                                   | A node condition indicating low available memory.                                        |
| What is ContainerCreating?                                | A container waiting for setup, such as networking, storage, or image preparation.        |
| What is `kubectl top`?                                    | A command to check CPU and memory usage through the metrics API.                         |
| What is a liveness probe failure?                         | A failed health check that can cause the container to restart.                           |
| What is the safest way to fix production issues?          | Identify impact and root cause, take an approved corrective action, and verify recovery. |

## Last-Minute Kubernetes Pod Troubleshooting Commands

```
# Check pods
kubectl get pods -n production

# Check all pods across namespaces
kubectl get pods -A

# Check pod details
kubectl describe pod <pod-name> -n production

# Check application logs
kubectl logs <pod-name> -n production

# Check previous logs
kubectl logs <pod-name> -n production --previous

# Check specific container logs
kubectl logs <pod-name> \
  -c <container-name> -n production

# Enter container
kubectl exec -it <pod-name> \
  -n production -- sh

# Check CPU and memory
kubectl top pods -n production

# Check node health
kubectl get nodes

# Check node resource usage
kubectl top nodes

# Check Kubernetes events
kubectl get events -n production \
  --sort-by=.lastTimestamp

# Check rollout history
kubectl rollout history \
  deployment/payment-service -n production

# Check HPA
kubectl get hpa -n production

# Check persistent storage
kubectl get pvc -n production
```

End of Subtopic 1.4 – Kubernetes Pod Troubleshooting

Covered: 20 detailed interview questions + 15 bonus questions, including your HR questions and additional production SRE scenarios.

Next Subtopic 1.5: Kubernetes Security – RBAC, ServiceAccounts, NetworkPolicies, Secrets, Pod Security, IAM Roles for Service Accounts (IRSA), EKS Security, and Production Security Troubleshooting.

# X Company – SRE Interview Preparation

## Section 1: Kubernetes

### Subtopic 1.5: Kubernetes Security, RBAC, IAM, Secrets and EKS Security

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: HR questions + additional interview questions + production commands + security troubleshooting.

### Example Production Environment

```
Cloud       : AWS
Cluster     : prod-eks
Namespace   : production
Application : payment-service
IAM         : AWS IAM / EKS Pod Identity
Secrets     : AWS Secrets Manager
CI/CD       : Jenkins + Argo CD
```

### Q1. How do you secure a Kubernetes cluster in production?

Interview Answer:

We secure Kubernetes using RBAC, NetworkPolicies, Pod Security Standards, Secrets management, and image scanning.

In EKS, we also use IAM, private API endpoint access, encryption, audit logging, and regular security updates.

Production Commands:

```
# Check RBAC
kubectl get roles,rolebindings -A

# Check NetworkPolicies
kubectl get networkpolicy -A

# Check ServiceAccounts
kubectl get sa -A

# Check cluster API endpoint settings
aws eks describe-cluster \
  --name prod-eks \
  --query 'cluster.resourcesVpcConfig'
```

Real-Time Scenario: Developers have limited namespace access, workloads use dedicated IAM roles, and sensitive production services are protected by network policies.

### Q2. What is Kubernetes RBAC, and how does it work?

Interview Answer:

RBAC stands for Role-Based Access Control. It controls which users or ServiceAccounts can access Kubernetes resources and what actions they can perform.

We use Roles, ClusterRoles, RoleBindings, and ClusterRoleBindings.

Practical Example: Give read-only pod access.

`rbac.yaml`:

```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
  namespace: production
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: pod-reader-binding
  namespace: production
subjects:
  - kind: ServiceAccount
    name: payment-reader
    namespace: production
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

Production Commands:

```
# Check ServiceAccount exists
kubectl get sa payment-reader -n production

# Validate RBAC configuration
kubectl apply --dry-run=server -f rbac.yaml

# Apply through approved GitOps process
kubectl apply -f rbac.yaml

# Verify permissions
kubectl auth can-i list pods \
  -n production \
  --as=system:serviceaccount:production:payment-reader
```

Real-Time Scenario: A monitoring application needs to read pod information but should not delete or modify pods. We assign only read permissions.

### Q3. What is the difference between Role and ClusterRole?

Interview Answer:

Role: Defines permissions within a particular namespace.

ClusterRole: Defines permissions that can apply across the cluster, including cluster-scoped resources.

RoleBinding grants permissions within a namespace. ClusterRoleBinding grants permissions cluster-wide.

Production Commands:

```
kubectl get roles -n production

kubectl get clusterroles

kubectl get rolebindings -n production

kubectl get clusterrolebindings
```

Real-Time Scenario: Developers may have read access to one namespace, while the platform team has broader access to manage cluster infrastructure.

### Q4. What is a Kubernetes ServiceAccount?

Interview Answer:

A ServiceAccount provides an identity for applications running inside Kubernetes.

Pods use it to authenticate with the Kubernetes API when required.

In EKS, a ServiceAccount can also be associated with AWS IAM permissions using IRSA or EKS Pod Identity.

Production Commands:

```
# Check ServiceAccounts
kubectl get sa -n production

# Check a pod's ServiceAccount
kubectl get pod <pod-name> \
  -n production \
  -o jsonpath='{.spec.serviceAccountName}'
```

Example Pod Configuration:

```
spec:
  serviceAccountName: payment-sa
```

Real-Time Scenario: Payment Service uses a dedicated ServiceAccount rather than sharing broad permissions with unrelated applications.

### Q5. How do you provide AWS S3 access to an EKS pod without storing AWS credentials?

Interview Answer:

We use EKS Pod Identity or IRSA to associate an IAM role with the application's ServiceAccount.

The pod receives temporary AWS credentials and accesses only the AWS resources allowed by its IAM policy.

Production Commands – EKS Pod Identity:

```
# Check ServiceAccount
kubectl get sa payment-sa -n production

# Check existing associations
aws eks list-pod-identity-associations \
  --cluster-name prod-eks
```

After the platform team creates an appropriate IAM role and configures Pod Identity Agent, an authorized administrator can associate it:

```
aws eks create-pod-identity-association \
  --cluster-name prod-eks \
  --namespace production \
  --service-account payment-sa \
  --role-arn <approved-iam-role-arn>
```

Real-Time Scenario: Payment Service uploads reports to S3 using temporary credentials instead of storing AWS access keys inside Kubernetes Secrets.

Follow-Up: What if the pod gets AccessDenied?

Answer: I check the IAM policy, role association, ServiceAccount, S3 bucket policy, and AWS CloudTrail logs.

AWS recommends EKS Pod Identity where supported.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q6. What is the difference between IRSA and EKS Pod Identity?

Interview Answer:

Both provide IAM permissions to Kubernetes workloads.

IRSA uses an IAM OIDC provider and an IAM role associated with a Kubernetes ServiceAccount.

EKS Pod Identity uses EKS Pod Identity associations and an agent, making IAM integration simpler for supported EKS workloads.

Production Commands:

```
# Check IRSA role annotation
kubectl get sa payment-sa \
  -n production -o yaml

# Check EKS Pod Identity associations
aws eks list-pod-identity-associations \
  --cluster-name prod-eks

# Check identity inside a permitted pod
aws sts get-caller-identity
```

The last command runs inside a pod with the AWS CLI or suitable debugging tools.

Real-Time Scenario: For a new EKS application requiring S3 access, we choose Pod Identity when supported. Existing workloads may continue using IRSA.

### Q7. How do you manage Kubernetes Secrets securely in production?

Interview Answer:

We never store passwords or API keys directly in source code.

We use AWS Secrets Manager, External Secrets Operator, or another approved secret management solution.

We also use RBAC, encryption, and credential rotation.

Production Commands:

```
# List Secret names, not values
kubectl get secrets -n production

# Check External Secrets
kubectl get externalsecrets -n production

# Check External Secrets status
kubectl describe externalsecret payment-db \
  -n production

# Check AWS Secrets Manager metadata
aws secretsmanager describe-secret \
  --secret-id production/payment-db
```

Real-Time Scenario: Database credentials are stored in AWS Secrets Manager and synchronized to Kubernetes through an approved integration.

Follow-Up: Is Kubernetes Secret base64 encoding secure?

Answer: No. Base64 is encoding, not encryption. We need encryption, restricted permissions, and proper secrets management.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q8. What is the difference between ConfigMap and Secret?

Interview Answer:

ConfigMap stores non-sensitive application configuration.

Secret stores sensitive data such as passwords, tokens, and certificates. Secret access must be properly protected.

Production Commands:

```
# List ConfigMaps
kubectl get configmaps -n production

# List Secrets
kubectl get secrets -n production

# Check ConfigMap configuration
kubectl describe configmap payment-config \
  -n production
```

Real-Time Scenario: We store application environment settings in ConfigMaps and database credentials in Secrets.

### Q9. What is NetworkPolicy, and how do you secure pod-to-pod communication?

Interview Answer:

NetworkPolicy controls incoming and outgoing network traffic for Kubernetes pods.

We use it to allow communication only between approved applications and block unnecessary traffic.

Example: Allow Order Service to access Payment Service.

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: payment-policy
  namespace: production
spec:
  podSelector:
    matchLabels:
      app: payment-service
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: order-service
      ports:
        - protocol: TCP
          port: 8080
```

Production Commands:

```
# Check NetworkPolicies
kubectl get networkpolicy -n production

# Check policy details
kubectl describe networkpolicy payment-policy \
  -n production

# Check pod labels
kubectl get pods -n production --show-labels
```

Real-Time Scenario: Only Order Service should connect to Payment Service on port 8080. Other unapproved pods are blocked by this ingress policy when network policy enforcement is correctly enabled.

Important: In EKS, NetworkPolicy requires a supported and correctly configured CNI.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q10. What is Pod Security Admission in Kubernetes?

Interview Answer:

Pod Security Admission controls which security settings are allowed for pods.

It supports three security levels:

- Privileged: Very few restrictions.
- Baseline: Blocks common security risks.
- Restricted: Enforces stricter security requirements.

Production Commands:

```
# Check namespace security labels
kubectl get namespace production \
  --show-labels

# Inspect namespace configuration
kubectl describe namespace production
```

Example – Test restricted policy in staging:

```
kubectl label namespace staging \
  pod-security.kubernetes.io/warn=restricted \
  --overwrite
```

This enables warnings, not enforcement. After reviewing workload compatibility, administrators can plan enforcement separately.

Real-Time Scenario: A developer tries to deploy a privileged container into a namespace enforcing Restricted Pod Security. Kubernetes rejects the deployment if it violates the policy.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q11. How do you secure containers running inside Kubernetes?

Interview Answer:

We run containers as non-root users, disable unnecessary privileges, use read-only filesystems where possible, and avoid privileged containers.

We also configure resource limits and use trusted container images.

Example Security Configuration:

```
securityContext:
  runAsNonRoot: true
  runAsUser: 10001
  allowPrivilegeEscalation: false
  capabilities:
    drop:
      - ALL
  seccompProfile:
    type: RuntimeDefault
```

Production Commands:

```
# Check pod security settings
kubectl get pod <pod-name> \
  -n production -o yaml

# Check Deployment security configuration
kubectl get deployment payment-service \
  -n production -o yaml
```

Real-Time Scenario: We configure application containers to run without root privileges to reduce security risks if an application is compromised.

### Q12. How do you scan Docker images for security vulnerabilities before deploying to EKS?

Interview Answer:

We integrate image scanning into Jenkins CI/CD pipelines.

We use tools such as Trivy, Amazon ECR scanning, or approved security scanners to identify vulnerabilities before production deployment.

Production Commands:

```
# Scan local Docker image
trivy image payment-service:v1

# Scan critical and high vulnerabilities
trivy image \
  --severity HIGH,CRITICAL \
  payment-service:v1

# Check ECR scan findings
aws ecr describe-image-scan-findings \
  --repository-name payment-service \
  --image-id imageTag=v1
```

The ECR command applies to supported image-scanning configurations.

Real-Time Scenario: Jenkins detects a critical vulnerability in a Docker image. We block or require security approval for the release, update the affected package or base image, rebuild, and rescan.

### Q13. An EKS pod cannot access S3 and receives AccessDenied. How do you troubleshoot?

Interview Answer:

First, I check which IAM role the pod is using.

Then I verify the IAM policy, ServiceAccount, Pod Identity or IRSA configuration, S3 bucket permissions, and network connectivity.

Production Commands:

```
# Check pod ServiceAccount
kubectl get pod <pod-name> \
  -n production \
  -o jsonpath='{.spec.serviceAccountName}'

# Check Pod Identity association
aws eks list-pod-identity-associations \
  --cluster-name prod-eks

# Check IRSA configuration, if used
kubectl get sa payment-sa -n production \
  -o yaml
```

Inside the application pod, if permitted:

```
# Verify IAM identity
aws sts get-caller-identity

# Test authorized S3 access
aws s3 ls s3://approved-payment-bucket/
```

Real-Time Scenario: The pod receives AccessDenied because its IAM role does not allow the required S3 operation.

We correct the IAM permission after approval and verify access without storing permanent credentials.

### Q14. A developer gets Forbidden when executing kubectl. How do you troubleshoot?

Interview Answer:

A Forbidden error normally means the user is authenticated but does not have the required Kubernetes authorization.

I check RBAC roles, bindings, and EKS access permissions.

Production Commands:

```
# Check current user's permissions
kubectl auth can-i get pods -n production

# Check current authorization
kubectl auth can-i --list -n production

# Check RBAC bindings
kubectl get rolebindings -n production

# Check EKS access entries
aws eks list-access-entries \
  --cluster-name prod-eks
```

Real-Time Scenario: A developer can view pods but cannot delete them. This is expected if their role only includes read permissions.

If additional access is genuinely required, we grant only the necessary permission after approval.

### Q15. How do you provide EKS access to developers using IAM?

Interview Answer:

We use IAM roles and EKS access entries to grant developers access to the cluster.

We assign permissions based on the required namespace and responsibilities.

Production Commands:

```
# Check EKS authentication mode
aws eks describe-cluster \
  --name prod-eks \
  --query 'cluster.accessConfig'

# Check configured access entries
aws eks list-access-entries \
  --cluster-name prod-eks

# Check available EKS access policies
aws eks list-access-policies
```

Example authorized configuration:

```
# Create an access entry
aws eks create-access-entry \
  --cluster-name prod-eks \
  --principal-arn <developer-role-arn> \
  --type STANDARD
```

The administrator then associates an appropriate namespace-scoped EKS access policy or configures Kubernetes RBAC.

Real-Time Scenario: Developers receive read-only access to the Development namespace, while Production write access is restricted to authorized engineers.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q16. How do you enable audit logging for an EKS cluster?

Interview Answer:

We enable EKS control-plane logs and send them to Amazon CloudWatch.

Audit logs help identify Kubernetes API activities and investigate unauthorized or unexpected changes.

Production Commands:

```
# Check logging configuration
aws eks describe-cluster \
  --name prod-eks \
  --query 'cluster.logging'

# Check CloudWatch log groups
aws logs describe-log-groups \
  --log-group-name-prefix \
  /aws/eks/prod-eks/cluster
```

Enable audit logs after approval:

```
aws eks update-cluster-config \
  --name prod-eks \
  --logging \
  '{"clusterLogging":[{"types":["audit","api","authenticator"],"enabled":true}]}'
```

Real-Time Scenario: A production Deployment is unexpectedly modified. We investigate Kubernetes audit logs, correlate the responsible identity and action, and review the approved change records.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q17. How do you secure the EKS Kubernetes API endpoint?

Interview Answer:

We restrict access to the Kubernetes API server using private endpoint access or limited public CIDR ranges.

We also use IAM authentication, RBAC, and secure network connectivity.

Production Commands:

```
# Check API endpoint configuration
aws eks describe-cluster \
  --name prod-eks \
  --query \
  'cluster.resourcesVpcConfig'

# Check current AWS identity
aws sts get-caller-identity

# Test Kubernetes API connectivity
kubectl cluster-info
```

Real-Time Scenario: Our organization allows administrators to access the private EKS API endpoint through an approved VPN or private network rather than exposing it broadly to the internet.

### Q18. After applying a NetworkPolicy, applications cannot communicate. How do you troubleshoot?

Interview Answer:

First, I check the NetworkPolicy rules and pod labels.

Then I verify source and destination namespaces, ports, DNS connectivity, and whether the CNI is enforcing the policies.

Production Commands:

```
# Check NetworkPolicies
kubectl get networkpolicy -n production

# Describe policy
kubectl describe networkpolicy payment-policy \
  -n production

# Check pod labels
kubectl get pods -n production \
  --show-labels

# Check Services
kubectl get svc -n production
```

Real-Time Scenario: Payment Service becomes unreachable after a NetworkPolicy update because the allowed source label is incorrect.

We identify the rule mismatch, correct it through GitOps, and verify service connectivity.

### Q19. How do you encrypt Kubernetes Secrets in EKS?

Interview Answer:

We use encryption at rest, AWS KMS where applicable, and strict RBAC permissions.

We also prefer external secret managers for sensitive production credentials.

In supported EKS versions, AWS provides default envelope encryption for Kubernetes API data.

Production Commands:

```
# Check Kubernetes version
aws eks describe-cluster \
  --name prod-eks \
  --query 'cluster.version'

# Check EKS encryption configuration
aws eks describe-cluster \
  --name prod-eks \
  --query 'cluster.encryptionConfig'

# Check AWS KMS key metadata
aws kms describe-key \
  --key-id <kms-key-id>
```

Real-Time Scenario: Sensitive configuration is protected using encryption at rest, restricted permissions, and secure credential management.

Important: EKS clusters running Kubernetes 1.28 or higher receive default envelope encryption for Kubernetes API data. The `encryptionConfig` field concerns explicitly configured customer-managed encryption settings, not necessarily the default encryption status.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q20. A production Kubernetes Secret is accidentally exposed. What will you do?

Interview Answer:

First, I report the security incident and identify which credentials were exposed.

Then I work with the security team to revoke or rotate the affected credentials, check access logs, and update dependent applications.

Finally, we identify the cause and prevent the issue from happening again.

Production Commands:

```
# Check affected workloads
kubectl get deployments -n production

# Check Secret names and references
kubectl get secrets -n production

# Check relevant application status
kubectl get pods -n production

# Verify application recovery
kubectl rollout status \
  deployment/payment-service \
  -n production
```

Real-Time Scenario: A database password was accidentally committed to a Git repository.

We immediately follow the security incident process, rotate the password, update the approved secret store, verify application connectivity, and investigate possible unauthorized access.

Removing the password from Git alone is not enough because it may remain in Git history.

## Bonus: Additional Second-Round SRE Interview Questions

| Question                                                         | Short Interview Answer                                                                          |
| ---------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| What is least privilege?                                         | Give users and applications only the permissions they need.                                     |
| What is the difference between IAM and Kubernetes RBAC?          | IAM controls AWS permissions; Kubernetes RBAC controls Kubernetes API permissions.              |
| What is a ClusterRoleBinding?                                    | It grants a Role or ClusterRole's permissions across the cluster using a ClusterRole reference. |
| What is IRSA?                                                    | IAM Roles for Service Accounts, used to grant AWS permissions to Kubernetes workloads.          |
| Does Pod Identity replace Kubernetes RBAC?                       | No. Pod Identity provides AWS IAM credentials; RBAC controls Kubernetes API access.             |
| What is OIDC in EKS?                                             | It helps federate Kubernetes ServiceAccount identities with AWS IAM for IRSA.                   |
| What is a privileged container?                                  | A container given elevated host-level permissions.                                              |
| What is `runAsNonRoot`?                                          | A security setting requiring a container to run as a non-root user.                             |
| What is admission control?                                       | It validates or changes Kubernetes API requests before resources are stored.                    |
| What is a default-deny NetworkPolicy?                            | A policy that blocks selected pod traffic unless another policy allows it.                      |
| Does NetworkPolicy control HTTP paths?                           | No. Standard NetworkPolicy mainly controls network traffic at IP and port levels.               |
| What is image signing?                                           | Cryptographically verifying the origin and integrity of container images.                       |
| What is Secret rotation?                                         | Replacing credentials periodically or when compromised.                                         |
| How do you prevent developers from deleting production pods?     | Apply RBAC permissions and separate Production access.                                          |
| What is AWS CloudTrail?                                          | A service that records AWS account API activity for auditing and investigation.                 |
| What is the difference between authentication and authorization? | Authentication verifies identity; authorization determines allowed actions.                     |

## Last-Minute Kubernetes Security Command Revision

```
# Check RBAC
kubectl get roles,rolebindings -A

# Check ClusterRoles
kubectl get clusterroles

# Check permissions
kubectl auth can-i delete pods -n production

# Check ServiceAccounts
kubectl get sa -n production

# Check NetworkPolicies
kubectl get networkpolicy -A

# Check Secrets
kubectl get secrets -n production

# Check namespace security policy
kubectl get namespace production --show-labels

# Check EKS access entries
aws eks list-access-entries \
  --cluster-name prod-eks

# Check EKS Pod Identity
aws eks list-pod-identity-associations \
  --cluster-name prod-eks

# Check current AWS identity
aws sts get-caller-identity

# Check EKS API endpoint
aws eks describe-cluster \
  --name prod-eks \
  --query 'cluster.resourcesVpcConfig'

# Check audit logging
aws eks describe-cluster \
  --name prod-eks \
  --query 'cluster.logging'
```

End of Subtopic 1.5 – Kubernetes Security

Covered: 20 detailed questions + 16 additional interview questions, including your HR security question, RBAC, IAM, ServiceAccounts, IRSA, EKS Pod Identity, NetworkPolicies, Pod Security, Secrets, and practical SRE incidents.

Next Subtopic 1.6: Kubernetes Cluster Upgrade Process – AWS EKS and Azure AKS, control-plane and worker-node upgrades, Kubernetes version compatibility, zero-downtime planning, node draining, rollback limitations, and real-time migration strategies.

# X Company – SRE Interview Preparation

## Section 1: Kubernetes

### Subtopic 1.6: Kubernetes Cluster Upgrade – AWS EKS, Azure AKS and Production Migration

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: HR questions + additional SRE interview questions + practical commands + zero-downtime upgrades + rollback + real-time troubleshooting.

### Example Production Environment

```
AWS Cluster   : prod-eks
AWS Region    : ap-south-1
Azure Cluster : prod-aks
Resource Group: prod-rg
Namespace     : production
Application   : payment-service
CI/CD         : Jenkins + Argo CD
Monitoring    : Prometheus + Grafana
```

Note: Kubernetes version numbers below are examples. Always confirm the target version is available for your cluster. Upgrade commands modify production infrastructure and require approved maintenance procedures.

### Q1. How do you upgrade an EKS cluster in a production environment?

Interview Answer:

First, I check the current Kubernetes version, deprecated APIs, cluster health, and compatibility.

Then I take backups and test the upgrade in staging.

After approval, I upgrade the EKS control plane, followed by worker nodes, add-ons, and other components. Finally, I validate all applications.

Production Commands:

```
# Check EKS version
aws eks describe-cluster \
  --name prod-eks \
  --region ap-south-1 \
  --query 'cluster.version'

# Check nodes and versions
kubectl get nodes -o wide

# Check upgrade readiness
aws eks list-insights \
  --cluster-name prod-eks \
  --region ap-south-1

# Upgrade control plane (example)
aws eks update-cluster-version \
  --name prod-eks \
  --kubernetes-version 1.36 \
  --region ap-south-1

# Check node groups
aws eks list-nodegroups \
  --cluster-name prod-eks \
  --region ap-south-1

# Upgrade managed node group
aws eks update-nodegroup-version \
  --cluster-name prod-eks \
  --nodegroup-name prod-workers \
  --kubernetes-version 1.36 \
  --region ap-south-1
```

These example upgrade commands assume the current version is 1.35 and the node group is compatible with the target version.

Real-Time Scenario: We need to upgrade production EKS from 1.35 to 1.36. We first test staging, check compatibility and backups, upgrade the control plane, then gradually update worker nodes and validate the applications.

Important: Amazon EKS upgrades normally proceed one Kubernetes minor version at a time.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q2. How do you upgrade an AKS cluster in a production environment?

Interview Answer:

First, I check the current AKS version and available upgrades.

Then I review application compatibility, backups, node pools, and PodDisruptionBudgets.

After testing in staging, I upgrade the control plane and then upgrade node pools in a controlled manner.

Production Commands:

```
# Check current AKS version
az aks show \
  --resource-group prod-rg \
  --name prod-aks \
  --query kubernetesVersion \
  -o tsv

# Check available upgrades
az aks get-upgrades \
  --resource-group prod-rg \
  --name prod-aks \
  -o table

# Upgrade control plane only
az aks upgrade \
  --resource-group prod-rg \
  --name prod-aks \
  --kubernetes-version <target-version> \
  --control-plane-only

# List node pools
az aks nodepool list \
  --resource-group prod-rg \
  --cluster-name prod-aks \
  -o table

# Upgrade specific node pool
az aks nodepool upgrade \
  --resource-group prod-rg \
  --cluster-name prod-aks \
  --name userpool \
  --kubernetes-version <target-version>
```

Real-Time Scenario: We upgrade AKS in staging first. After validation, we upgrade the production control plane and node pools, monitoring application availability during the process.

Important: By default, `az aks upgrade` can upgrade both the control plane and node pools. We use `--control-plane-only` when we want to manage node pool upgrades separately.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q3. What is the difference between control plane and worker node upgrades?

Interview Answer:

The control plane manages Kubernetes API requests, scheduling, and cluster operations.

Worker nodes run our application pods.

During an upgrade, we normally upgrade the control plane first and then the worker nodes.

Production Commands:

```
# Check cluster API version
kubectl version

# Check worker node versions
kubectl get nodes

# Check workloads
kubectl get pods -A

# Check node health
kubectl describe node <node-name>
```

Real-Time Scenario: The control plane is upgraded to 1.36, but worker nodes are still on 1.35. We then upgrade the node groups to align their Kubernetes versions.

Follow-Up: Can worker nodes run a newer version than the control plane?

Answer: No. The kubelet version must not be newer than the API server version. Supported older-node version differences depend on Kubernetes and provider compatibility rules.

### Q4. What checks do you perform before upgrading an EKS or AKS cluster?

Interview Answer:

Before upgrading, I verify cluster health, node capacity, deprecated APIs, PodDisruptionBudgets, storage, CNI compatibility, monitoring, and backups.

I also verify the rollback or recovery procedure.

Production Commands:

```
# Check cluster nodes
kubectl get nodes

# Check application health
kubectl get pods -A

# Check PodDisruptionBudgets
kubectl get pdb -A

# Check available resources
kubectl top nodes

# Check persistent storage
kubectl get pvc -A

# Check API resources
kubectl api-resources

# Check application rollout status
kubectl rollout status \
  deployment/payment-service \
  -n production
```

Real-Time Scenario: Before upgrading, I notice that a critical application has only one replica and no PodDisruptionBudget. I flag the availability risk and correct the workload configuration before proceeding.

### Q5. How do you upgrade EKS worker nodes without downtime?

Interview Answer:

We use a rolling node group update with sufficient capacity, multiple application replicas, readiness probes, and PodDisruptionBudgets.

EKS replaces worker nodes gradually and attempts to drain workloads safely.

Production Commands:

```
# Check managed node group
aws eks describe-nodegroup \
  --cluster-name prod-eks \
  --nodegroup-name prod-workers

# Configure maximum unavailable nodes
aws eks update-nodegroup-config \
  --cluster-name prod-eks \
  --nodegroup-name prod-workers \
  --update-config maxUnavailable=1

# Start an approved node upgrade
aws eks update-nodegroup-version \
  --cluster-name prod-eks \
  --nodegroup-name prod-workers \
  --kubernetes-version <target-version>

# Monitor nodes and pods
kubectl get nodes -w

kubectl get pods -n production -o wide
```

Real-Time Scenario: We have six worker nodes. EKS replaces them gradually while Kubernetes schedules eligible pods on available capacity.

Follow-Up: Does a rolling node upgrade guarantee zero downtime?

Answer: No. Applications must have sufficient replicas, working readiness probes, proper disruption budgets, and enough available capacity. These reduce downtime risk, but do not guarantee zero disruption.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q6. How do you take backups before upgrading an EKS or AKS cluster?

Interview Answer:

Before upgrading, I make sure Kubernetes resources, application configurations, and persistent data are backed up.

For EKS, we can use AWS Backup. For AKS, we can use Azure Backup or Velero, depending on the organization's setup.

We also verify that backups can be restored.

Production Commands – AWS:

```
# Check available backup vaults
aws backup list-backup-vaults

# Start EKS backup with approved configuration
aws backup start-backup-job \
  --backup-vault-name prod-backup \
  --resource-arn <eks-cluster-arn> \
  --iam-role-arn <backup-role-arn>

# Check backup job status
aws backup describe-backup-job \
  --backup-job-id <backup-job-id>
```

Production Commands – Kubernetes:

```
# Check persistent storage
kubectl get pv,pvc -A

# Check Velero backups, if installed
velero backup get

# Check backup details
velero backup describe <backup-name>
```

Real-Time Scenario: Before upgrading a cluster, we verify that the latest backup is successful and that critical data can be restored if recovery is required.

Important: AWS Backup supports EKS cluster state and supported persistent volumes, but it does not back up all external infrastructure or container images.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

AWS Backup



### Q7. What are cordon, drain, and uncordon in Kubernetes?

Interview Answer:

- Cordon: Marks a node unschedulable so new pods are not placed there.
- Drain: Safely evicts eligible workloads from a node for maintenance.
- Uncordon: Makes the node available for scheduling again.

Production Commands:

```
# Stop new pod scheduling
kubectl cordon <node-name>

# Drain node for maintenance
kubectl drain <node-name> \
  --ignore-daemonsets

# Verify node and workloads
kubectl get nodes

kubectl get pods -A -o wide

# Enable scheduling after maintenance
kubectl uncordon <node-name>
```

Real-Time Scenario: During manual worker node maintenance, I cordon the node, drain its workloads, perform the maintenance, and uncordon it after verifying node health.

Important: `drain` can be blocked by unmanaged pods, PodDisruptionBudgets, or pods using local temporary storage. Managed EKS/AKS upgrades already perform node draining, so we do not manually drain the same nodes unnecessarily.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q8. What is a PodDisruptionBudget (PDB), and why is it important during upgrades?

Interview Answer:

PodDisruptionBudget controls how many application pods can be voluntarily disrupted during maintenance.

It helps prevent too many replicas from being unavailable during node upgrades.

Example YAML:

```
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: payment-pdb
  namespace: production
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: payment-service
```

Production Commands:

```
# Check PDBs
kubectl get pdb -A

# Check allowed disruptions
kubectl describe pdb payment-pdb \
  -n production

# Check replicas
kubectl get deployment payment-service \
  -n production
```

Real-Time Scenario: Payment Service has three healthy replicas, and PDB requires two to stay available. Kubernetes can normally evict one pod at a time during maintenance.

Follow-Up: What happens if allowed disruptions are zero?

Answer: Node draining may be blocked. I check application readiness, replica counts, and the PDB configuration before continuing the upgrade.

### Q9. What happens if an EKS node group upgrade fails due to PodEvictionFailure?

Interview Answer:

PodEvictionFailure usually means EKS could not safely evict workloads from a node.

I check PodDisruptionBudgets, application health, available replicas, and scheduling capacity.

After fixing the issue, I retry the upgrade.

Production Commands:

```
# Check node group status
aws eks describe-nodegroup \
  --cluster-name prod-eks \
  --nodegroup-name prod-workers

# Check recent updates
aws eks list-updates \
  --name prod-eks \
  --nodegroup-name prod-workers

# Check disruption budgets
kubectl get pdb -A

# Check application health
kubectl get pods -A -o wide
```

Real-Time Scenario: The upgrade failed because the PDB required all application replicas to remain available.

We ensured enough healthy replicas and capacity, corrected the disruption configuration, and retried the node group upgrade.

Follow-Up: Can we force an EKS node upgrade?

Answer: Yes, but force updates can bypass PDB protections and interrupt applications. I would use this only as an approved last resort.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q10. How do you check deprecated Kubernetes APIs before an upgrade?

Interview Answer:

Some Kubernetes APIs are removed in newer versions.

Before upgrading, I review the release notes and scan our YAML files, Helm charts, and running resources for deprecated APIs.

We correct incompatible configurations before upgrading production.

Production Commands:

```
# Check current Kubernetes API resources
kubectl api-resources

# Check EKS upgrade insights
aws eks list-insights \
  --cluster-name prod-eks \
  --filter '{"categories":["UPGRADE_READINESS"]}'

# Scan local manifests using Pluto, if installed
pluto detect-files -d ./k8s-manifests

# Check Helm-rendered configuration
helm template payment-service \
  ./charts/payment-service \
  -f values-prod.yaml
```

Real-Time Scenario: A Helm chart uses an API removed in the target Kubernetes version. We update the chart, test it in staging, and then continue with the production upgrade.

### Q11. How do you upgrade CoreDNS, kube-proxy, and VPC CNI in EKS?

Interview Answer:

After upgrading the EKS control plane and nodes, I verify the compatibility of CoreDNS, kube-proxy, and VPC CNI.

Then I update the add-ons to compatible versions and check that networking and DNS are working.

Production Commands:

```
# List EKS add-ons
aws eks list-addons \
  --cluster-name prod-eks

# Check available versions
aws eks describe-addon-versions \
  --kubernetes-version <target-version> \
  --addon-name coredns

# Upgrade with approved compatible version
aws eks update-addon \
  --cluster-name prod-eks \
  --addon-name coredns \
  --addon-version <approved-addon-version>

# Verify CoreDNS
kubectl get deployment coredns \
  -n kube-system

# Check VPC CNI
kubectl get daemonset aws-node \
  -n kube-system
```

Real-Time Scenario: After the Kubernetes upgrade, we validate CoreDNS, VPC CNI, and kube-proxy so that application DNS resolution, pod networking, and Service routing remain functional.

Important: Managed EKS add-ons are not automatically upgraded just because the Kubernetes version changes.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q12. Can you roll back an EKS cluster after upgrading Kubernetes?

Interview Answer:

Yes. Amazon EKS now supports rolling back an eligible in-place control-plane upgrade to the previous minor Kubernetes version within seven days.

Before rollback, I verify compatibility, rollback readiness checks, worker nodes, and add-ons.

If managed worker nodes were upgraded, we roll them back first.

Production Commands:

```
# Check current EKS version
aws eks describe-cluster \
  --name prod-eks \
  --query 'cluster.version'

# Check rollback readiness
aws eks list-insights \
  --cluster-name prod-eks \
  --filter '{"categories":["ROLLBACK_READINESS"]}'

# Roll back an upgraded node group first
aws eks update-nodegroup-version \
  --cluster-name prod-eks \
  --nodegroup-name prod-workers \
  --kubernetes-version <previous-version>

# Roll back eligible control plane
aws eks update-cluster-version \
  --name prod-eks \
  --kubernetes-version <previous-version>
```

Real-Time Scenario: After upgrading from 1.35 to 1.36, we discover a serious compatibility issue.

If the cluster meets the rollback requirements, we prepare the worker nodes and add-ons and initiate rollback to 1.35.

Important: The EKS seven-day rollback feature has conditions and limitations. It is not a general-purpose downgrade. It does not automatically revert application data or EKS add-ons.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q13. Can you roll back an AKS cluster after a Kubernetes upgrade?

Interview Answer:

AKS does not support directly downgrading the Kubernetes control plane or node pools.

If an upgrade causes serious problems, we troubleshoot the affected components or migrate workloads to another compatible cluster.

For critical production environments, we prepare a backup and recovery or Blue-Green cluster strategy.

Production Commands:

```
# Check AKS version and status
az aks show \
  -g prod-rg -n prod-aks \
  --query '{version:kubernetesVersion,status:provisioningState}'

# Check node pool versions
az aks nodepool list \
  -g prod-rg \
  --cluster-name prod-aks \
  -o table

# Check workload health
kubectl get pods -A
```

Real-Time Scenario: If an AKS upgrade causes application compatibility issues, we restore the last stable application configuration where possible or migrate affected workloads to a previously prepared compatible cluster.

Important: Unlike the new EKS rollback capability, AKS Kubernetes version downgrade is not supported.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q14. What is Max Surge in AKS, and how does it help during upgrades?

Interview Answer:

Max Surge defines how many additional worker nodes AKS can temporarily create during an upgrade.

These extra nodes help Kubernetes move workloads before replacing the old nodes.

Production Commands:

```
# Configure Max Surge
az aks nodepool update \
  --resource-group prod-rg \
  --cluster-name prod-aks \
  --name userpool \
  --max-surge 33%

# Check node pool configuration
az aks nodepool show \
  --resource-group prod-rg \
  --cluster-name prod-aks \
  --name userpool

# Monitor nodes
kubectl get nodes -w
```

Real-Time Scenario: We have six AKS worker nodes. With Max Surge set to 33%, AKS can temporarily create up to two extra nodes during the upgrade.

Follow-Up: What happens if Azure does not have enough capacity?

Answer: The upgrade may fail or be delayed. I check Azure VM quota, available subnet IP addresses, and node pool settings.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q15. After an EKS or AKS upgrade, new pods are stuck in Pending. What will you do?

Interview Answer:

First, I check pod events, node readiness, resource availability, taints, node selectors, and persistent storage.

I also check whether the new nodes have successfully joined the cluster.

Production Commands:

```
# Check pods
kubectl get pods -n production

# Check failure reason
kubectl describe pod <pod-name> \
  -n production

# Check worker nodes
kubectl get nodes -o wide

# Check node resources
kubectl top nodes

# Check storage
kubectl get pvc -n production
```

Real-Time Scenario: After upgrading a node group, some pods remain Pending because the new nodes have insufficient CPU capacity.

I check resource requests and available nodes, then correct the capacity issue.

### Q16. After upgrading EKS, applications cannot resolve DNS. How do you troubleshoot?

Interview Answer:

I check CoreDNS pod health, CoreDNS Service, DNS configuration, and VPC CNI networking.

I also verify the compatibility of CoreDNS with the new Kubernetes version.

Production Commands:

```
# Check CoreDNS
kubectl get pods -n kube-system \
  -l k8s-app=kube-dns

# Check CoreDNS logs
kubectl logs deployment/coredns \
  -n kube-system --tail=100

# Check DNS Service
kubectl get svc kube-dns -n kube-system

# Check VPC CNI
kubectl get daemonset aws-node \
  -n kube-system
```

Real-Time Scenario: After an upgrade, applications fail to communicate because DNS lookups are timing out.

I check CoreDNS availability and logs, identify the networking or DNS issue, and restore service.

### Q17. How do you upgrade a Kubernetes cluster that runs stateful applications?

Interview Answer:

For stateful applications, I verify backups, persistent volumes, storage compatibility, and application replication.

I also check PodDisruptionBudgets and make sure the applications support graceful shutdown.

Production Commands:

```
# Check StatefulSets
kubectl get statefulsets -A

# Check persistent storage
kubectl get pv,pvc -A

# Check PDBs
kubectl get pdb -A

# Check StatefulSet health
kubectl rollout status \
  statefulset/payment-db \
  -n production
```

Real-Time Scenario: During a node upgrade, a database pod needs to move to another node.

Before maintenance, we verify database replication, storage attachment requirements, and backups to avoid data loss.

Follow-Up: Can EBS volumes move between Availability Zones?

Answer: An EBS volume is tied to an Availability Zone. We cannot directly attach it to a node in another AZ. Recovery across AZs requires a suitable storage or data migration strategy.

### Q18. What is Blue-Green cluster upgrade or migration?

Interview Answer:

Blue-Green migration means running two separate Kubernetes environments.

Blue is the existing production cluster. Green is the new cluster with the required Kubernetes version.

We deploy and test applications on Green, then gradually shift traffic from Blue to Green.

Migration Flow:

```
Existing EKS / AKS Cluster (Blue)
             |
             | Deploy same application
             v
New EKS / AKS Cluster (Green)
             |
             | Test & Validate
             v
        Shift Traffic
             |
             v
      New Production
```

Production Commands:

```
# Check configured cluster contexts
kubectl config get-contexts

# Check Blue cluster
kubectl --context blue-cluster \
  get deployments -n production

# Check Green cluster
kubectl --context green-cluster \
  get deployments -n production

# Verify Green application
kubectl --context green-cluster \
  get pods,svc,ingress -n production
```

Real-Time Scenario: Instead of upgrading an existing EKS cluster in place, we create a new EKS cluster with Terraform, deploy applications through Argo CD, test them, and shift production traffic after approval.

Follow-Up: Which is safer: in-place or Blue-Green cluster upgrade?

Answer: Blue-Green offers better isolation and an easier traffic rollback path, but costs more and requires careful data migration. In-place upgrades are simpler and normally less expensive.

### Q19. How do you migrate production traffic from an old Kubernetes cluster to a new one?

Interview Answer:

First, I deploy applications to the new cluster and verify health, connectivity, and data consistency.

Then I shift traffic using the approved DNS, load balancer, or traffic-management solution.

I monitor errors and latency. If problems occur, I redirect traffic to the healthy environment.

Production Commands:

```
# Verify new cluster pods
kubectl --context green-cluster \
  get pods -n production

# Verify Service and Ingress
kubectl --context green-cluster \
  get svc,ingress -n production

# Test application endpoint
curl -Iv https://green-payments.example.com

# Check AWS Route 53 records
aws route53 list-resource-record-sets \
  --hosted-zone-id <hosted-zone-id>
```

Real-Time Scenario: We use Route 53 weighted routing or an approved traffic controller to gradually move requests to the new production cluster.

Important: DNS weighting requires appropriate records and health checks. For databases or stateful services, we also need a separate data consistency and cutover plan.

### Q20. After upgrading an EKS or AKS cluster, how do you validate that everything is working?

Interview Answer:

After upgrading, I verify the control-plane version, node health, system pods, applications, networking, storage, and monitoring.

I also check Argo CD synchronization and perform application smoke tests.

Production Commands:

```
# Check cluster version
kubectl version

# Check node versions
kubectl get nodes -o wide

# Check system components
kubectl get pods -n kube-system

# Check application pods
kubectl get pods -n production

# Check Deployments
kubectl get deployments -n production

# Check Services and Ingress
kubectl get svc,ingress -n production

# Check Argo CD
argocd app list

# Verify application endpoint
curl -Iv https://payments.example.com
```

Real-Time Scenario: After the upgrade, all nodes are Ready and application pods are healthy. We verify API responses, error rates, latency, and dashboards before closing the change request.

## Bonus: Additional Second-Round SRE Questions

| Question                                               | Short Interview Answer                                                                                              |
| ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------- |
| Can we upgrade worker nodes before the control plane?  | Not to a newer Kubernetes version than the control plane.                                                           |
| Can we skip Kubernetes minor versions in EKS?          | No. EKS in-place upgrades proceed one minor version at a time.                                                      |
| What are EKS Upgrade Insights?                         | AWS checks that identify possible upgrade compatibility problems.                                                   |
| What happens to application pods during node upgrades? | Eligible pods are drained and recreated or rescheduled onto available nodes.                                        |
| What is `maxUnavailable`?                              | It limits how many nodes or workload replicas may be unavailable, depending on the resource.                        |
| What is the difference between cordon and drain?       | Cordon blocks new scheduling; drain evicts eligible pods.                                                           |
| Does draining a node delete DaemonSet pods?            | Normally no. DaemonSet-managed pods are ignored during drain.                                                       |
| Does PDB protect against node crashes?                 | No. It mainly controls voluntary disruptions.                                                                       |
| What is Kubernetes version skew?                       | The supported version difference between Kubernetes components.                                                     |
| What is an in-place upgrade?                           | Upgrading the existing cluster rather than creating a replacement cluster.                                          |
| What is a Blue-Green cluster migration?                | Deploying to a new cluster and shifting traffic from the old one.                                                   |
| Can we cancel an EKS control-plane upgrade midway?     | No. An initiated EKS control-plane version upgrade cannot be paused or canceled.                                    |
| What is the safest upgrade approach?                   | Test in staging, check compatibility and backups, upgrade in controlled stages, and verify applications.            |
| How do you monitor an upgrade?                         | Check provider update status, nodes, pods, application metrics, and Kubernetes events.                              |
| What if an upgrade fails halfway?                      | Inspect the provider update error and affected components, fix the cause, and use the supported recovery procedure. |
| Can we use Terraform to manage cluster upgrades?       | Yes, through reviewed version and node-group changes in Terraform configuration.                                    |
| What is a maintenance window?                          | An approved period for infrastructure changes with reduced business impact.                                         |

## Last-Minute EKS Upgrade Commands

```
# Check cluster version
aws eks describe-cluster \
  --name prod-eks \
  --query 'cluster.version'

# Check EKS upgrade insights
aws eks list-insights \
  --cluster-name prod-eks

# List node groups
aws eks list-nodegroups \
  --cluster-name prod-eks

# Check add-ons
aws eks list-addons \
  --cluster-name prod-eks

# Check cluster upgrade status
aws eks list-updates \
  --name prod-eks

# Check specific update
aws eks describe-update \
  --name prod-eks \
  --update-id <update-id>
```

## Last-Minute AKS Upgrade Commands

```
# Check AKS cluster
az aks show -g prod-rg -n prod-aks -o table

# Available upgrades
az aks get-upgrades \
  -g prod-rg -n prod-aks -o table

# Check node pools
az aks nodepool list \
  -g prod-rg \
  --cluster-name prod-aks -o table

# Check specific node pool
az aks nodepool show \
  -g prod-rg \
  --cluster-name prod-aks \
  --name userpool

# Get kubeconfig
az aks get-credentials \
  -g prod-rg -n prod-aks
```

## How to Explain the Complete Upgrade Process in an Interview

> In our example environment, we perform Kubernetes upgrades through a planned change process.
>
> First, we check the existing cluster version, deprecated APIs, node health, and application compatibility. We also verify backups and test the upgrade in staging.
>
> For EKS or AKS, we upgrade the control plane first, then worker nodes in a controlled manner. During node upgrades, Kubernetes drains workloads and reschedules them onto healthy nodes.
>
> We use multiple application replicas, readiness probes, and PodDisruptionBudgets to reduce downtime.
>
> After upgrading, we check system components, applications, Argo CD synchronization, and monitoring dashboards. If issues occur, we follow the approved rollback or recovery process.

Use this as your interview explanation only for steps that match your actual responsibilities.

End of Subtopic 1.6 – Kubernetes Cluster Upgrade

Covered: 20 detailed interview questions + 17 bonus questions, including EKS and AKS upgrades, backups, draining, PDBs, rollback, zero-downtime planning, and Blue-Green cluster migration.

Next Subtopic 1.7: Kubernetes Migration Strategies – In-Place vs Blue-Green Migration, EKS-to-EKS, AKS-to-AKS, Helm Migration, Application Migration, Storage/Data Migration, and Production Cutover Scenarios.

# X Company – SRE Interview Preparation

## Section 1: Kubernetes

### Subtopic 1.7: Kubernetes Migration Strategies – EKS, AKS, Blue-Green and Production Cutover

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: Migration strategies, EKS-to-EKS, AKS-to-AKS, cross-cloud migration, persistent storage, database migration, Helm, Argo CD, traffic switching and rollback.

### Example Production Environment

```
Source EKS    : eks-blue
Target EKS    : eks-green
Source AKS    : aks-blue
Target AKS    : aks-green
AWS Region    : ap-south-1
Namespace     : production
Application   : payment-service
Tools         : Terraform, Helm, Argo CD, Velero
Traffic       : AWS Route 53 / Azure Traffic Manager
```

Note: These are production-style examples. Use approved credentials, backups, and change procedures before performing migration actions.

### Q1. What are the different Kubernetes migration strategies?

Interview Answer:

The main migration strategies are:

1. In-Place Migration: Update the existing cluster or workload.
2. Blue-Green Migration: Create a new environment and switch traffic.
3. Canary Migration: Gradually move traffic to a new version or cluster.
4. Rolling Migration: Move workloads in stages while maintaining service availability.
5. Backup and Restore: Restore backed-up resources and data into a new cluster.

Production Commands:

```
# Check current cluster
kubectl config current-context

# List configured clusters
kubectl config get-contexts

# Check application resources
kubectl get deploy,sts,svc,ingress -n production
```

Real-Time Scenario: For a critical production application, we prefer Blue-Green migration when we need to validate the new cluster before switching customer traffic.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q2. How do you migrate applications from one EKS cluster to another?

Interview Answer:

First, we create the new EKS cluster using Terraform.

Then we configure networking, IAM, storage, monitoring, and Kubernetes add-ons.

We deploy applications using Helm or Argo CD, migrate application data if required, validate everything, and gradually switch traffic.

Production Commands:

```
# Connect to old EKS cluster
aws eks update-kubeconfig \
  --name eks-blue \
  --region ap-south-1 \
  --alias eks-blue

# Connect to new EKS cluster
aws eks update-kubeconfig \
  --name eks-green \
  --region ap-south-1 \
  --alias eks-green

# Check old cluster
kubectl --context eks-blue get pods -n production

# Check new cluster
kubectl --context eks-green get pods -n production

# Verify new applications
kubectl --context eks-green \
  get deploy,svc,ingress -n production
```

Real-Time Scenario: We migrate from an older EKS cluster to a new supported Kubernetes version. Both clusters run in parallel until the new environment passes validation.

### Q3. How do you perform Blue-Green cluster migration in production?

Interview Answer:

Blue is our existing production cluster, and Green is the new cluster.

We deploy the same applications in Green, validate functionality and data, and gradually redirect customer traffic.

If Green has problems, we redirect traffic to Blue, provided data compatibility is maintained.

Migration Flow:

```
Existing Cluster (Blue)
         |
         | Deploy same application
         v
New Cluster (Green)
         |
         | Testing + Validation
         v
Switch Traffic Gradually
         |
         v
Green Becomes Production
```

Production Commands:

```
# Compare application status
kubectl --context eks-blue \
  get deployments -n production

kubectl --context eks-green \
  get deployments -n production

# Verify Green pods
kubectl --context eks-green \
  get pods -n production

# Test new application endpoint
curl -I https://green-payments.example.com
```

Real-Time Scenario: We deploy Payment Service on Green, verify health checks, gradually switch traffic, and keep Blue available during the agreed rollback period.

### Q4. What is the difference between Blue-Green and Canary migration?

Interview Answer:

Blue-Green: We maintain two environments and switch traffic from the old environment to the new one.

Canary: We gradually send a percentage of requests to the new version or environment before fully migrating.

Production Commands:

```
# Check old and new Deployments
kubectl get deployments -n production

# Check Argo Rollouts, if installed
kubectl get rollouts -n production

# Check AWS Route 53 DNS configuration
aws route53 list-resource-record-sets \
  --hosted-zone-id <hosted-zone-id>
```

Real-Time Scenario: We start with a small percentage of customer traffic on the new cluster, monitor error rates and latency, and increase traffic after validation.

Follow-Up: Which approach is safer?

Answer: Canary reduces initial customer exposure, while Blue-Green provides environment isolation. We choose based on business requirements and the available routing tools.

### Q5. How do you migrate workloads from AKS to a new AKS cluster?

Interview Answer:

We create the target AKS cluster and configure networking, managed identity, storage, monitoring, and container registry access.

Then we deploy applications through Helm or GitOps, migrate data, verify connectivity, and shift production traffic.

Production Commands:

```
# Connect to source AKS
az aks get-credentials \
  -g prod-rg \
  -n aks-blue \
  --context aks-blue

# Connect to target AKS
az aks get-credentials \
  -g prod-rg \
  -n aks-green \
  --context aks-green

# Check source applications
kubectl --context aks-blue \
  get pods -n production

# Check target applications
kubectl --context aks-green \
  get pods -n production

# Verify target
kubectl --context aks-green \
  get deploy,svc,ingress -n production
```

Real-Time Scenario: We migrate AKS applications to a new cluster with updated networking and node pools while maintaining the old cluster during validation.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q6. How do you migrate applications from EKS to AKS?

Interview Answer:

First, we analyze cloud-specific dependencies.

Then we create the AKS cluster, configure networking, Azure identity, ACR, and storage.

We update Kubernetes manifests and Helm values, migrate application data, deploy through CI/CD, and validate before switching traffic.

Production Commands:

```
# Check AWS workloads
kubectl --context eks-blue \
  get deploy,sts,svc,ingress -n production

# Check AKS workloads
kubectl --context aks-green \
  get deploy,sts,svc,ingress -n production

# Check Helm releases
helm --kube-context eks-blue \
  list -n production

# Check Azure Container Registry
az acr repository list \
  --name <acr-name>
```

Real-Time Scenario: During EKS-to-AKS migration, we replace EKS-specific storage, IAM, ingress, and load-balancer settings with compatible Azure configurations.

Follow-Up: Can we directly reuse EKS YAML files in AKS?

Answer: Some Kubernetes manifests are portable, but AWS-specific annotations, IAM integration, storage classes, and networking configurations must be reviewed and changed.

### Q7. How do you migrate Kubernetes resources using Helm?

Interview Answer:

We use the same approved Helm chart with separate values files for the old and new environments.

Before deployment, we update cloud-specific configuration, validate templates, and test the new cluster.

Production Commands:

```
# Check existing Helm releases
helm --kube-context eks-blue \
  list -n production

# Render target manifests
helm template payment-service \
  ./charts/payment-service \
  -f values-green.yaml

# Deploy on Green after approval
helm --kube-context eks-green \
  upgrade --install payment-service \
  ./charts/payment-service \
  -n production \
  -f values-green.yaml

# Verify
kubectl --context eks-green \
  rollout status deployment/payment-service \
  -n production
```

Real-Time Scenario: We reuse the Payment Service Helm chart but update the image registry, storage configuration, ingress, and environment variables for the target cluster.

### Q8. How do you migrate Argo CD applications to another Kubernetes cluster?

Interview Answer:

First, we register the new cluster in Argo CD with approved permissions.

Then we update the GitOps Application destination and environment configuration.

After testing and approval, we synchronize the application to the new cluster.

Production Commands:

```
# List available cluster contexts
kubectl config get-contexts

# Check registered Argo CD clusters
argocd cluster list

# Register target cluster (admin action)
argocd cluster add eks-green

# Check application
argocd app get payment-prod

# Check synchronization
argocd app diff payment-prod
```

Real-Time Scenario: Instead of manually applying YAML files, we use Argo CD to deploy applications consistently into the new EKS cluster.

Important: `argocd cluster add` can create broad permissions. In production, configure the least-privileged target credentials and update the Application destination through GitOps.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://argo-cd.readthedocs.io\&sz=32)

Declarative GitOps CD for Kubernetes



### Q9. How do you migrate Kubernetes persistent volumes between clusters?

Interview Answer:

First, I identify the existing PVCs, PersistentVolumes, and StorageClasses.

Then we take storage backups or snapshots and restore the data to compatible storage in the new cluster.

Finally, we verify that applications can access the restored data.

Production Commands:

```
# Check old PVCs
kubectl --context eks-blue \
  get pvc -n production

# Check old PVs
kubectl --context eks-blue get pv

# Check target StorageClasses
kubectl --context eks-green get sc

# Check target PVCs
kubectl --context eks-green \
  get pvc -n production
```

Real-Time Scenario: For EKS-to-EKS migration, we can use supported EBS snapshots or backup tools to restore application data.

Important: EBS volumes cannot simply be attached across clusters in different regions or clouds. We must use a compatible backup, snapshot, replication, or data-copy process.

### Q10. How do you use Velero to migrate Kubernetes applications?

Interview Answer:

Velero is used to back up and restore Kubernetes resources and supported persistent data.

We create a backup in the source cluster and restore it into the target cluster after configuring compatible backup storage and plugins.

Production Commands:

```
# Check Velero backup storage
velero backup-location get

# Back up production namespace
velero backup create payment-backup \
  --include-namespaces production

# Check backup
velero backup describe payment-backup

# Check backup status
velero backup get
```

On the target cluster, after configuring Velero to access the backup:

```
# Verify backup is available
velero backup get

# Restore backup
velero restore create payment-restore \
  --from-backup payment-backup

# Check restore status
velero restore describe payment-restore

# Verify applications
kubectl get pods,pvc -n production
```

Real-Time Scenario: We use Velero to restore backed-up Kubernetes resources into a new cluster and verify data, workloads, and configuration.

Important: Velero requires compatible backup storage and volume restore support. Cross-cloud volume data migration may need a separate process.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://velero.io\&sz=32)

Resource filtering



### Q11. How do you migrate a database running inside Kubernetes?

Interview Answer:

For database migration, we first take a consistent backup and prepare the target database.

Depending on the database, we use backup and restore or replication.

Before switching traffic, we validate data consistency and application connectivity.

Production Commands:

```
# Check StatefulSets
kubectl --context eks-blue \
  get sts -n production

# Check database pods
kubectl --context eks-blue \
  get pods -n production

# Check PVCs
kubectl --context eks-blue \
  get pvc -n production

# Check target database status
kubectl --context eks-green \
  get sts,pods,pvc -n production
```

Real-Time Scenario: We migrate PostgreSQL using a consistent database backup or replication, validate the restored database, and switch application connections during a controlled cutover.

Follow-Up: Can we just copy the database PVC?

Answer: Not always. We need application-consistent data, storage compatibility, and a validated restore process. Simply copying files while the database is writing can cause data inconsistency.

### Q12. How do you migrate Kubernetes Secrets and ConfigMaps?

Interview Answer:

We store non-sensitive configurations in Git and sensitive credentials in AWS Secrets Manager, Azure Key Vault, or another approved secret manager.

During migration, we configure the new cluster to access the required credentials securely.

Production Commands:

```
# Check source ConfigMaps
kubectl --context eks-blue \
  get configmaps -n production

# Check source Secret names
kubectl --context eks-blue \
  get secrets -n production

# Check target Secret synchronization
kubectl --context eks-green \
  get externalsecrets -n production

# Check target ConfigMaps
kubectl --context eks-green \
  get configmaps -n production
```

Real-Time Scenario: During EKS-to-AKS migration, we configure Azure Key Vault integration for target applications rather than copying AWS credentials into AKS.

### Q13. How do you shift production traffic from the old cluster to the new cluster?

Interview Answer:

We use DNS-based routing, load balancers, or traffic management tools.

For AWS, we can use Route 53 weighted routing to gradually move DNS responses from the old ALB to the new ALB.

We monitor application health and increase the new cluster's weight after validation.

Production Commands:

```
# Check Route 53 DNS records
aws route53 list-resource-record-sets \
  --hosted-zone-id <hosted-zone-id>

# Test application
curl -Iv https://payments.example.com

# Check AWS load balancer health
aws elbv2 describe-target-health \
  --target-group-arn <target-group-arn>
```

Example Traffic Migration:

| Phase   | Blue Weight | Green Weight |
| ------- | ----------- | ------------ |
| Initial | 100         | 0            |
| Phase 1 | 90          | 10           |
| Phase 2 | 50          | 50           |
| Final   | 0           | 100          |

Real-Time Scenario: We start with Green weight 10 and monitor errors. If healthy, we gradually increase it to 100.

Important: DNS weights influence response distribution and do not guarantee exact percentages of individual requests because of caching and connection reuse.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon Route 53



### Q14. How do you roll back a failed Kubernetes cluster migration?

Interview Answer:

We keep the old cluster available during the migration.

If the new cluster has problems, we redirect traffic to the old cluster and investigate the failure.

Before rollback, we must check whether database writes or schema changes make returning to the old environment unsafe.

Production Commands:

```
# Verify old cluster
kubectl --context eks-blue \
  get pods -n production

# Verify old application
curl -Iv https://blue-payments.example.com

# Check DNS records
aws route53 list-resource-record-sets \
  --hosted-zone-id <hosted-zone-id>

# Check new cluster issues
kubectl --context eks-green \
  get events -n production \
  --sort-by=.lastTimestamp
```

Real-Time Scenario: After shifting traffic to Green, application errors increase. We stop the migration and restore approved traffic routing to Blue after verifying data consistency.

### Q15. How do you achieve zero or minimal downtime during Kubernetes migration?

Interview Answer:

We run old and new clusters in parallel, maintain multiple healthy replicas, and use readiness probes.

We migrate data carefully and shift traffic gradually while monitoring application health.

Production Commands:

```
# Check application replicas
kubectl --context eks-green \
  get deployment -n production

# Check pod readiness
kubectl --context eks-green \
  get pods -n production

# Check PDBs
kubectl --context eks-green \
  get pdb -n production

# Check application endpoint
curl -I https://green-payments.example.com
```

Real-Time Scenario: We use Blue-Green migration and validate the new environment before customer traffic is redirected.

Follow-Up: Is zero downtime always possible?

Answer: No. Stateful applications, database schema changes, session handling, and external dependencies can require a controlled cutover or brief maintenance window.

### Q16. How do you migrate applications using Terraform and Argo CD together?

Interview Answer:

Terraform provisions the new cluster and supporting cloud infrastructure.

Argo CD deploys applications using the GitOps repository.

We use both tools to maintain consistent infrastructure and application configurations.

Production Commands:

```
# Check Terraform changes
terraform init
terraform plan -out=migration.tfplan

# Apply reviewed plan after approval
terraform apply migration.tfplan

# Verify cluster
kubectl --context eks-green get nodes

# Verify Argo CD clusters
argocd cluster list

# Check deployed applications
argocd app list
```

Real-Time Scenario: Terraform provisions the new EKS cluster, IAM roles, and networking. Argo CD deploys application configurations from Git.

### Q17. How do you migrate applications between Kubernetes node pools?

Interview Answer:

First, we create a new node pool with the required configuration.

Then we verify capacity and scheduling rules, move workloads gradually, and validate application health.

After successful migration, we remove the old node pool.

Production Commands:

```
# Check nodes
kubectl get nodes -o wide

# Prevent new scheduling on old node
kubectl cordon <old-node-name>

# Drain eligible workloads
kubectl drain <old-node-name> \
  --ignore-daemonsets

# Verify pod placement
kubectl get pods -A -o wide

# Check application rollout
kubectl rollout status \
  deployment/payment-service \
  -n production
```

Real-Time Scenario: We migrate applications to a new node group using updated EC2 instance types without recreating the complete EKS cluster.

### Q18. How do you validate a new Kubernetes cluster before production cutover?

Interview Answer:

I check node health, application pods, Services, Ingress, storage, IAM permissions, and monitoring.

I also perform application smoke tests and verify that critical transactions work.

Production Commands:

```
# Check nodes
kubectl --context eks-green get nodes

# Check applications
kubectl --context eks-green \
  get deploy,sts,pods -n production

# Check networking
kubectl --context eks-green \
  get svc,ingress -n production

# Check storage
kubectl --context eks-green \
  get pvc -n production

# Test application
curl -I https://green-payments.example.com
```

Real-Time Scenario: Before switching traffic, we verify login, database connectivity, API requests, monitoring, and dependent microservices.

### Q19. After migration, the application is running but not accessible. How do you troubleshoot?

Interview Answer:

First, I check the application pods and readiness.

Then I verify the Service, Ingress, load balancer, DNS, security groups, and NetworkPolicies.

Production Commands:

```
# Check pods
kubectl --context eks-green \
  get pods -n production

# Check Service endpoints
kubectl --context eks-green \
  get endpointslices -n production

# Check Ingress
kubectl --context eks-green \
  describe ingress payment-ingress \
  -n production

# Test target application
curl -v https://green-payments.example.com
```

Real-Time Scenario: After EKS migration, the new ALB is created, but target health checks fail because of an incorrect application port.

We fix the Service or health-check configuration and verify target health before switching traffic.

### Q20. Explain an end-to-end Kubernetes migration project you handled.

Interview Answer:

In a production-style project, we migrate workloads from an existing Kubernetes cluster to a new cluster using Blue-Green migration.

First, we prepare the new cluster using Terraform. Then we configure networking, IAM, storage, and monitoring.

We deploy applications using Helm and Argo CD, migrate data, validate application health, and gradually switch traffic.

After successful validation, we monitor the new cluster and decommission the old one only after the rollback window.

End-to-End Flow:

```
Existing Production Cluster
           |
           v
  Infrastructure Analysis
           |
           v
  New Cluster - Terraform
           |
           v
  Networking + IAM + Storage
           |
           v
  Helm / Argo CD Deployment
           |
           v
  Backup / Data Migration
           |
           v
  Application Testing
           |
           v
  Gradual Traffic Cutover
           |
           v
  Monitoring + Validation
           |
           v
  New Production Cluster
```

Real-Time Scenario: We migrate Payment Service to a new cluster, verify healthy pods and database connectivity, shift traffic in stages, and monitor error rates before retiring the old environment.

For your interview, explain which parts you personally implemented and which parts were handled by other teams.

## Bonus: Additional Second-Round SRE Questions

| Question                                              | Short Interview Answer                                                                      |
| ----------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| What is cluster migration?                            | Moving applications and required resources from one Kubernetes cluster to another.          |
| What is the difference between upgrade and migration? | Upgrade updates an existing environment; migration moves workloads to another environment.  |
| What is Blue-Green cluster migration?                 | Running old and new clusters in parallel and switching traffic.                             |
| What is Canary migration?                             | Gradually shifting traffic to the new environment while monitoring results.                 |
| Can Terraform migrate application data?               | Terraform mainly manages infrastructure; data migration needs separate tools or procedures. |
| Can Velero migrate PVC data?                          | Yes, with supported storage backup and restore mechanisms.                                  |
| Can we directly move EBS volumes to Azure?            | No. We need a compatible cross-cloud data migration process.                                |
| What is data consistency?                             | Ensuring migrated data is correct and synchronized.                                         |
| What is migration cutover?                            | The point when production traffic switches to the target environment.                       |
| What is migration rollback?                           | Returning traffic and operations to the previous stable environment when safe.              |
| What is RTO?                                          | Recovery Time Objective: maximum acceptable recovery time.                                  |
| What is RPO?                                          | Recovery Point Objective: maximum acceptable data loss measured in time.                    |
| What is DNS TTL?                                      | The duration DNS responses may be cached.                                                   |
| What is a smoke test?                                 | A basic test confirming that important application functions work.                          |
| When should we decommission the old cluster?          | After successful validation, data reconciliation, approval, and the rollback period.        |

## Last-Minute Kubernetes Migration Commands

```
# Check cluster contexts
kubectl config get-contexts

# Check source applications
kubectl --context eks-blue get pods -A

# Check target applications
kubectl --context eks-green get pods -A

# Check persistent storage
kubectl --context eks-green get pv,pvc -A

# Check Helm releases
helm --kube-context eks-green list -A

# Check Argo CD clusters
argocd cluster list

# Check Argo CD applications
argocd app list

# Check Velero backups
velero backup get

# Check Velero restores
velero restore get

# Check Route 53 records
aws route53 list-resource-record-sets \
  --hosted-zone-id <hosted-zone-id>

# Check application endpoint
curl -Iv https://payments.example.com
```

End of Subtopic 1.7 – Kubernetes Migration Strategies

Covered: 20 detailed questions + 15 bonus questions, including EKS-to-EKS, AKS-to-AKS, EKS-to-AKS, Blue-Green, Velero, data migration, traffic switching, rollback, Terraform and Argo CD.

Next Subtopic 1.8: Kubernetes Autoscaling – HPA, VPA, Cluster Autoscaler, Karpenter, Node Scaling, Resource Optimization, and Real-Time Production Scenarios.

# X Company – SRE Interview Preparation

## Section 1: Kubernetes

### Subtopic 1.8: Kubernetes Autoscaling – HPA, VPA, Cluster Autoscaler, Karpenter and Production Troubleshooting

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: HR-related concepts + additional SRE interview questions + production commands + practical autoscaling scenarios.

### Example Production Environment

```
Cloud       : AWS / Azure
EKS Cluster : prod-eks
AKS Cluster : prod-aks
Namespace   : production
Application : payment-service
Monitoring  : Prometheus + Grafana
CI/CD       : Jenkins + Argo CD
```

Production Note: Use GitOps for permanent configuration changes and follow your organization's approval process.

### Q1. What is autoscaling in Kubernetes, and what are its different types?

Interview Answer:

Autoscaling automatically increases or decreases application resources based on workload demand.

There are three main types:

1. HPA: Increases or decreases the number of application pods.
2. VPA: Adjusts CPU and memory requests for containers.
3. Cluster Autoscaler: Increases or decreases Kubernetes worker nodes.

Production Commands:

```
# Check Horizontal Pod Autoscalers
kubectl get hpa -A

# Check VPA, if installed
kubectl get vpa -A

# Check cluster nodes
kubectl get nodes

# Check resource usage
kubectl top pods -n production
```

Real-Time Scenario: When customer traffic increases, HPA creates more application pods. If there is insufficient node capacity, Cluster Autoscaler or Karpenter can provision additional worker nodes.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q2. What is HPA, and how does it work in Kubernetes?

Interview Answer:

HPA stands for Horizontal Pod Autoscaler.

It automatically increases or decreases pod replicas based on metrics such as CPU, memory, or custom application metrics.

For example, if average CPU utilization exceeds the configured target, HPA can increase the number of replicas.

Production Commands:

```
# Check HPA
kubectl get hpa -n production

# Get detailed HPA information
kubectl describe hpa payment-hpa \
  -n production

# Check current replicas
kubectl get deployment payment-service \
  -n production

# Check CPU and memory
kubectl top pods -n production
```

Real-Time Scenario: Payment Service normally runs three replicas. During high traffic, CPU utilization increases, so HPA increases replicas to handle the workload.

### Q3. How do you configure HPA in a production environment?

Interview Answer:

We configure HPA using Kubernetes YAML or Helm.

We define minimum replicas, maximum replicas, scaling metrics, and target utilization.

In production, we store the configuration in Git and deploy through Argo CD.

Example `payment-hpa.yaml`:

```
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: payment-hpa
  namespace: production
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: payment-service
  minReplicas: 3
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
```

Production Commands:

```
# Verify Metrics Server works
kubectl top nodes

# Validate HPA manifest
kubectl apply --dry-run=server \
  -f payment-hpa.yaml

# Apply through approved deployment process
kubectl apply -f payment-hpa.yaml

# Check HPA
kubectl get hpa -n production

# Check scaling events
kubectl describe hpa payment-hpa \
  -n production
```

Real-Time Scenario: CPU utilization increases above the configured target. HPA calculates the required replicas and scales the Deployment within the range of 3–10.

Important: CPU-based HPA needs CPU resource requests and a working resource metrics pipeline.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q4. What is the difference between HPA and VPA?

Interview Answer:

HPA scales the number of pods horizontally.

VPA adjusts the CPU and memory resources allocated to containers.

| HPA                          | VPA                              |
| ---------------------------- | -------------------------------- |
| Changes pod replica count    | Adjusts CPU/memory requests      |
| Useful for increased traffic | Useful for resource optimization |
| Scales horizontally          | Scales vertically                |
| Common for stateless APIs    | Useful for rightsizing workloads |

Production Commands:

```
# Check HPA
kubectl get hpa -n production

# Check VPA if installed
kubectl get vpa -n production

# Check configured resources
kubectl describe deployment payment-service \
  -n production
```

Real-Time Scenario: We use HPA to handle increasing API traffic and VPA recommendations to optimize application resource requests.

Follow-Up: Can HPA and VPA work together?

Answer: Yes, but we should avoid having both independently modify CPU or memory settings that affect the same HPA target, as it can cause scaling conflicts.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q5. How do you configure VPA in Kubernetes?

Interview Answer:

VPA analyzes application resource usage and recommends suitable CPU and memory values.

In production, we can first run VPA in recommendation-only mode to avoid unexpected changes.

Example `payment-vpa.yaml`:

```
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: payment-vpa
  namespace: production
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: payment-service
  updatePolicy:
    updateMode: "Off"
```

Production Commands:

```
# Verify VPA is installed
kubectl get vpa -A

# Check VPA recommendations
kubectl describe vpa payment-vpa \
  -n production

# Check recommendations as YAML
kubectl get vpa payment-vpa \
  -n production -o yaml
```

Real-Time Scenario: The application requests 2 GiB memory but normally uses much less. We review VPA recommendations and adjust the resource requests after testing.

Important: VPA is an additional component and is not installed by default in most Kubernetes clusters.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q6. What is Cluster Autoscaler, and how does it work?

Interview Answer:

Cluster Autoscaler automatically adds worker nodes when pending pods cannot fit on available nodes.

It also removes eligible underutilized nodes to reduce infrastructure costs.

In EKS, it commonly works with EC2 Auto Scaling Groups.

Production Commands:

```
# Check nodes
kubectl get nodes

# Check pending pods
kubectl get pods -A \
  --field-selector=status.phase=Pending

# Check Cluster Autoscaler
kubectl get deployment cluster-autoscaler \
  -n kube-system

# Check autoscaler logs
kubectl logs -n kube-system \
  deployment/cluster-autoscaler \
  --tail=100
```

Real-Time Scenario: HPA increases the application from three pods to eight, but only five can be scheduled.

Cluster Autoscaler detects insufficient capacity and scales an eligible node group if its limits allow it.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q7. What is the difference between HPA and Cluster Autoscaler?

Interview Answer:

HPA increases or decreases application pod replicas.

Cluster Autoscaler increases or decreases the number of worker nodes.

They work together to handle workload demand.

Production Commands:

```
# Check HPA scaling
kubectl get hpa -n production

# Check application replicas
kubectl get deployment payment-service \
  -n production

# Check worker nodes
kubectl get nodes

# Check pending pods
kubectl get pods -n production
```

Real-Time Scenario:

```
Application Traffic Increases
           |
           v
      CPU Increases
           |
           v
      HPA Adds Pods
           |
           v
Insufficient Node Capacity
           |
           v
  Cluster Autoscaler
           |
           v
     New Worker Node
           |
           v
    Pending Pods Run
```

### Q8. How do you enable Cluster Autoscaler in AKS?

Interview Answer:

In AKS, we can enable Cluster Autoscaler on a node pool using Azure CLI.

We configure minimum and maximum node counts based on workload requirements and available resources.

Production Commands:

```
# Check AKS node pools
az aks nodepool list \
  -g prod-rg \
  --cluster-name prod-aks \
  -o table

# Enable Cluster Autoscaler
az aks nodepool update \
  -g prod-rg \
  --cluster-name prod-aks \
  --name userpool \
  --enable-cluster-autoscaler \
  --min-count 2 \
  --max-count 8

# Check updated node pool
az aks nodepool show \
  -g prod-rg \
  --cluster-name prod-aks \
  --name userpool

# Verify nodes
kubectl get nodes
```

Real-Time Scenario: During peak traffic, more pods are required than the current AKS nodes can host. The Cluster Autoscaler increases eligible node pool capacity within its configured limits.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q9. What is Karpenter, and how does it work in EKS?

Interview Answer:

Karpenter is a Kubernetes node autoscaler that automatically provisions suitable EC2 instances based on pending pod requirements.

It considers CPU, memory, instance types, Availability Zones, and scheduling constraints.

It can also remove or consolidate unnecessary nodes to optimize costs.

Production Commands:

```
# Check Karpenter controller
kubectl get pods -n kube-system \
  -l app.kubernetes.io/name=karpenter

# Check NodePools
kubectl get nodepools

# Check created NodeClaims
kubectl get nodeclaims

# Check Karpenter logs
kubectl logs -n kube-system \
  -l app.kubernetes.io/name=karpenter \
  --tail=100
```

Real-Time Scenario: Payment Service requires more compute resources. Karpenter detects unschedulable pods and launches suitable EC2 instances automatically.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q10. What is the difference between Karpenter and Cluster Autoscaler?

Interview Answer:

Cluster Autoscaler generally scales existing Auto Scaling Groups.

Karpenter provisions nodes based directly on workload requirements and can choose from different EC2 instance types.

| Cluster Autoscaler                        | Karpenter                         |
| ----------------------------------------- | --------------------------------- |
| Uses existing node groups                 | Uses NodePools and NodeClasses    |
| Adjusts ASG capacity                      | Provisions suitable EC2 instances |
| Works with predefined node configurations | More flexible instance selection  |
| Supports node scale-down                  | Supports node consolidation       |

Production Commands:

```
# Check Cluster Autoscaler
kubectl get deploy cluster-autoscaler \
  -n kube-system

# Check Karpenter NodePools
kubectl get nodepools

# Check Karpenter NodeClaims
kubectl get nodeclaims
```

Real-Time Scenario: We may choose Karpenter when applications have changing compute requirements and we need flexible instance selection.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q11. HPA is configured, but pods are not scaling. How do you troubleshoot?

Interview Answer:

First, I check HPA status and events.

Then I verify Metrics Server, CPU requests, current utilization, maximum replicas, and application metrics.

Production Commands:

```
# Check HPA
kubectl get hpa -n production

# Check scaling conditions
kubectl describe hpa payment-hpa \
  -n production

# Check metrics
kubectl top pods -n production

# Check Metrics Server
kubectl get deployment metrics-server \
  -n kube-system

# Check resource requests
kubectl describe deployment payment-service \
  -n production
```

Real-Time Scenario: HPA displays:

```
cpu: <unknown>/70%
```

I check whether Metrics Server is working and whether the containers have CPU requests configured.

Follow-Up: What if HPA has reached maxReplicas?

Answer: HPA will not scale beyond the configured maximum. We review application requirements and capacity before increasing the limit.

### Q12. What is Metrics Server, and why is it required for HPA?

Interview Answer:

Metrics Server collects CPU and memory usage from Kubernetes nodes.

It provides resource metrics to HPA and commands such as `kubectl top`.

Without an available metrics source, CPU- and memory-based HPA cannot work properly.

Production Commands:

```
# Check Metrics Server
kubectl get deployment metrics-server \
  -n kube-system

# Check metrics API
kubectl get apiservice v1beta1.metrics.k8s.io

# Check CPU and memory
kubectl top nodes

kubectl top pods -n production
```

Real-Time Scenario: HPA stops scaling because Metrics Server cannot collect node metrics. I check APIService availability, Metrics Server logs, and kubelet connectivity.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q13. HPA creates new pods, but they remain Pending. What will you do?

Interview Answer:

I check the pod scheduling events and available node resources.

Then I verify Cluster Autoscaler or Karpenter, node capacity, taints, node selectors, and cloud resource limits.

Production Commands:

```
# Check Pending pods
kubectl get pods -n production

# Check scheduling failure
kubectl describe pod <pod-name> \
  -n production

# Check node resources
kubectl top nodes

# Check Karpenter resources
kubectl get nodepools,nodeclaims

# Check cluster nodes
kubectl get nodes
```

Real-Time Scenario: HPA creates five additional pods, but they remain Pending because no nodes have enough memory.

I check why node autoscaling has not provided capacity and resolve the provisioning issue.

### Q14. How do you configure HPA based on both CPU and memory?

Interview Answer:

We can configure multiple metrics in HPA.

Kubernetes calculates the required replicas for each metric and generally uses the highest calculated replica count.

Example YAML:

```
metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

Production Commands:

```
# Check HPA metrics
kubectl describe hpa payment-hpa \
  -n production

# Check pod usage
kubectl top pods -n production

# Check resources
kubectl get deployment payment-service \
  -n production -o yaml
```

Real-Time Scenario: CPU usage is normal, but memory utilization crosses the target. HPA may increase replicas based on memory.

Important: Memory-based scaling should be tested carefully because adding replicas does not always solve memory leaks or high per-pod memory consumption.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://v1-32.docs.kubernetes.io\&sz=32)

Kubernetes



### Q15. How do you scale Kubernetes applications based on custom metrics?

Interview Answer:

Apart from CPU and memory, Kubernetes can scale applications using custom or external metrics.

For example, we can scale based on HTTP request rates, queue length, or application-specific metrics.

We can use Prometheus Adapter or KEDA, depending on the requirement.

Production Commands:

```
# Check HPA
kubectl get hpa -n production

# Check custom metrics API availability
kubectl get apiservices

# Check KEDA resources, if installed
kubectl get scaledobjects -A
```

Real-Time Scenario: Instead of CPU utilization, we scale background worker pods based on the number of messages waiting in an SQS queue.

### Q16. What is KEDA, and how is it different from HPA?

Interview Answer:

KEDA stands for Kubernetes Event-Driven Autoscaling.

It scales applications based on external events such as SQS messages, Kafka lag, or Azure Service Bus queue length.

KEDA commonly works together with Kubernetes HPA and can support scaling eligible workloads down to zero.

Production Commands:

```
# Check KEDA installation
kubectl get pods -n keda

# Check ScaledObjects
kubectl get scaledobjects -A

# Check scaling configuration
kubectl describe scaledobject \
  payment-worker -n production

# Check worker replicas
kubectl get deployment payment-worker \
  -n production
```

Real-Time Scenario: Our message-processing service has no messages in the queue, so its worker replicas can scale down. When messages arrive, KEDA scales the workers based on the configured queue trigger.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://keda.sh\&sz=32)

KEDA



### Q17. How do you configure scale-down behavior to prevent frequent pod scaling?

Interview Answer:

We use HPA scaling behavior and a stabilization window to avoid frequent scale-up and scale-down.

This helps prevent unnecessary pod creation and termination when traffic changes frequently.

Example YAML:

```
behavior:
  scaleDown:
    stabilizationWindowSeconds: 300
  scaleUp:
    stabilizationWindowSeconds: 0
```

Production Commands:

```
# Check HPA behavior
kubectl get hpa payment-hpa \
  -n production -o yaml

# Check scaling events
kubectl describe hpa payment-hpa \
  -n production
```

Real-Time Scenario: CPU usage changes frequently between 40% and 80%. A five-minute scale-down stabilization window helps avoid removing replicas too quickly.

### Q18. How do you reduce EKS costs using autoscaling?

Interview Answer:

We optimize resource requests, use HPA to adjust application replicas, and use Cluster Autoscaler or Karpenter to remove unnecessary nodes.

We can also use Spot Instances for suitable fault-tolerant workloads.

Production Commands:

```
# Check resource usage
kubectl top nodes

kubectl top pods -A

# Check node capacity
kubectl describe nodes

# Check HPA
kubectl get hpa -A

# Check Karpenter NodePools
kubectl get nodepools
```

Real-Time Scenario: During off-peak hours, application traffic decreases. HPA reduces replicas, and the node autoscaler may remove unnecessary nodes after its safety checks.

Important: We consider PodDisruptionBudgets, availability requirements, and workload criticality before consolidating nodes or using Spot capacity.

### Q19. HPA is working, but application response time is still high. What will you investigate?

Interview Answer:

I check application latency, CPU, memory, database performance, dependency response times, and request rates.

HPA may increase replicas, but it cannot fix every performance problem.

Production Commands:

```
# Check HPA
kubectl get hpa -n production

# Check application replicas
kubectl get deployment payment-service \
  -n production

# Check resources
kubectl top pods -n production

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=100
```

Real-Time Scenario: Payment Service scales from three to eight replicas, but response time remains high because database connections are saturated.

I investigate the database bottleneck instead of continuously increasing application replicas.

### Q20. Explain how you handled a production traffic spike using Kubernetes autoscaling.

Interview Answer:

In a production-style scenario, we configured HPA for our application and Cluster Autoscaler or Karpenter for node capacity.

During a traffic spike, CPU usage increased, and HPA added application replicas.

When additional pods could not fit on existing nodes, node autoscaling provided more capacity.

We monitored CPU, memory, latency, and error rates using Prometheus and Grafana.

Practical Troubleshooting Commands:

```
# Check application scaling
kubectl get hpa -n production

# Check replicas
kubectl get deploy -n production

# Check pending pods
kubectl get pods -n production

# Check node capacity
kubectl get nodes

# Check current usage
kubectl top pods -n production
```

Real-Time Scenario:

```
Customer Traffic Spike
         |
         v
   CPU Utilization ↑
         |
         v
    HPA Adds Pods
         |
         v
   Node Capacity Full
         |
         v
 Cluster Autoscaler
      / Karpenter
         |
         v
   New Nodes Added
         |
         v
 Pending Pods Scheduled
         |
         v
Application Stabilizes
```

This is an example explanation. In your interview, describe the actual autoscaling components and responsibilities you handled.

## Bonus: Additional Second-Round SRE Questions

| Question                                       | Short Interview Answer                                                                                    |
| ---------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| What is the default HPA minimum replica count? | Normally 1, unless scale-to-zero support is configured.                                                   |
| Can HPA scale StatefulSets?                    | Yes, StatefulSets support the scale subresource.                                                          |
| Can HPA work without Metrics Server?           | Yes, with a suitable custom or external metrics pipeline; CPU/memory HPA normally needs resource metrics. |
| What is `minReplicas`?                         | The minimum number of replicas maintained by HPA.                                                         |
| What is `maxReplicas`?                         | The maximum number of replicas HPA can create.                                                            |
| What is a CPU request?                         | The amount of CPU Kubernetes uses when scheduling a container.                                            |
| What is a CPU limit?                           | The maximum CPU capacity a container may consume, enforced through throttling.                            |
| What is scale-out?                             | Increasing the number of application replicas or nodes.                                                   |
| What is scale-in?                              | Decreasing application replicas or nodes.                                                                 |
| What is node consolidation?                    | Moving workloads where possible and removing unnecessary nodes to reduce cost.                            |
| What is a Karpenter NodePool?                  | A configuration that controls which nodes Karpenter can create.                                           |
| What is a Karpenter NodeClaim?                 | A Kubernetes resource representing a node capacity request and its lifecycle.                             |
| Can HPA solve memory leaks?                    | No. The application memory issue must be fixed.                                                           |
| What happens if Metrics Server is down?        | Resource-metric-based autoscaling may stop making scaling decisions.                                      |
| What is the difference between HPA and KEDA?   | HPA scales workloads using configured metrics; KEDA specializes in event-driven scaling.                  |

## Last-Minute Autoscaling Commands

```
# Check HPA
kubectl get hpa -A

# Check HPA details
kubectl describe hpa payment-hpa -n production

# Check VPA
kubectl get vpa -A

# Check application replicas
kubectl get deploy -n production

# Check pending pods
kubectl get pods -A \
  --field-selector=status.phase=Pending

# Check CPU and memory
kubectl top pods -A
kubectl top nodes

# Check Metrics Server
kubectl get deployment metrics-server -n kube-system

# Check Cluster Autoscaler
kubectl logs -n kube-system \
  deployment/cluster-autoscaler --tail=100

# Check Karpenter
kubectl get nodepools
kubectl get nodeclaims

# Check AKS autoscaling
az aks nodepool show \
  -g prod-rg \
  --cluster-name prod-aks \
  --name userpool
```

End of Subtopic 1.8 – Kubernetes Autoscaling

Covered: 20 detailed interview questions + 15 additional questions, including HPA, VPA, Cluster Autoscaler, Karpenter, KEDA, troubleshooting, performance, and cost optimization.

Next Subtopic 1.9: Kubernetes Helm, ConfigMaps, Secrets, Scheduling, Taints and Tolerations, Node Affinity, and Production Deployment Scenarios.

# X Company – SRE Interview Preparation

## Section 2: Terraform

### Subtopic 2.2: Advanced Terraform – State Locking, Force Unlock, State Migration, CI/CD Failures and Production Scenarios

Level: Second Round – SRE / DevOps (5 Years Experience)

Focus: Real-time production problems, troubleshooting commands, Terraform state recovery, Terraform Enterprise and advanced interview follow-up questions.

### Example Production Environment

```
Cloud        : AWS / Azure
Terraform    : Terraform CLI
State        : AWS S3 / Azure Blob Storage
Locking      : S3 Lockfile / Azure Blob Lease
CI/CD        : Jenkins / Azure DevOps
Environments : Dev, QA, Production
Repository   : GitHub
```

### Q1. Two engineers are running Terraform apply at the same time. What happens?

Interview Answer:

Terraform uses state locking to prevent multiple engineers from modifying the same state simultaneously.

If Engineer A is running `terraform apply`, Engineer B cannot acquire the same state lock.

Terraform waits for the lock or returns an error.

Production Commands:

```
# Engineer A starts infrastructure changes
terraform apply

# Engineer B tries to apply
terraform apply

# Wait up to 5 minutes for the lock
terraform plan -lock-timeout=5m
```

Example Error:

```
Error: Error acquiring the state lock

Lock Info:
  ID:        <lock-id>
  Path:      production/terraform.tfstate
  Operation: OperationTypeApply
  Who:       engineer-a@build-server
  Created:   <timestamp>
```

Real-Time Scenario: Two Jenkins pipelines try to modify the same production infrastructure. The first pipeline acquires the lock, and the second must wait until the first finishes.

Follow-Up: Can both engineers apply different resources using the same state?

Answer: Not simultaneously. The lock protects the entire selected Terraform state. Separate states can support independent operations.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://developer.hashicorp.com\&sz=32)

HashiCorp Developer



### Q2. One engineer is applying Terraform, but their system crashes and the state remains locked. How do you force-unlock it?

Interview Answer:

First, I check whether the Terraform process or pipeline is still running.

If it has crashed and the lock is stale, I identify the lock ID from the error message.

After confirming no active operation is using the state and getting approval, I use `terraform force-unlock` to release the lock.

Finally, I run Terraform plan to check the infrastructure state.

### Practical Production Steps

Step 1: Go to the correct environment.

```
cd terraform/environments/prod

terraform init
```

Step 2: Try acquiring the lock.

```
terraform plan -lock-timeout=2m
```

Example error:

```
Error acquiring the state lock

Lock Info:
  ID:        abc12345-xxxx-xxxx
  Who:       engineer-a@jenkins
  Operation: OperationTypeApply
  Created:   <timestamp>
```

Step 3: Verify the previous operation has stopped.

Check Jenkins/Azure DevOps run status and confirm with the engineer or pipeline owner. Do not unlock an active Terraform operation.

Step 4: Force-unlock the verified stale lock.

```
terraform force-unlock <lock-id>
```

For example:

```
terraform force-unlock abc12345-xxxx-xxxx
```

Terraform requests confirmation.

To skip the confirmation prompt in an approved recovery procedure:

```
terraform force-unlock \
  -force abc12345-xxxx-xxxx
```

Step 5: Verify Terraform state and infrastructure.

```
terraform state list

terraform plan
```

If the previous apply stopped halfway, compare the Terraform state with actual cloud resources and reconcile any partially created infrastructure before applying again.

Real-Time Production Scenario:

Engineer A runs Terraform apply to create an EC2 instance and an S3 bucket. Their Jenkins agent crashes during execution.

Engineer B tries to deploy but receives a state lock error.

We confirm that Engineer A's Terraform process has stopped, obtain the lock ID, and perform an approved force-unlock.

We then check the state and actual AWS resources before continuing.

Important: `terraform force-unlock` removes a lock; it does not stop an active Terraform process or fix a damaged state file. Never use it to bypass someone else's active apply.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://developer.hashicorp.com\&sz=32)

HashiCorp Developer



### Q3. What is the difference between `terraform force-unlock` and `terraform apply -lock=false`?

Interview Answer:

`terraform force-unlock` releases an existing state lock.

`-lock=false` disables locking for that specific operation.

In production, we should not disable locking because concurrent changes can corrupt Terraform state.

Commands:

```
# Release a verified stale lock
terraform force-unlock <lock-id>

# Wait for the lock safely
terraform plan -lock-timeout=5m

# Unsafe for shared production state
terraform apply -lock=false
```

Real-Time Scenario: If an engineer is already applying infrastructure changes, I wait for the lock rather than running Terraform with `-lock=false`.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://developer.hashicorp.com\&sz=32)

HashiCorp Developer



### Q4. How is Terraform state locking implemented in AWS S3?

Interview Answer:

Terraform supports S3-based state locking using a lock file.

When one Terraform operation acquires the lock, another operation cannot modify the same state until the lock is released.

Example `backend.tf`:

```
terraform {
  backend "s3" {
    bucket       = "company-terraform-state"
    key          = "production/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
```

Production Commands:

```
# Initialize backend
terraform init

# Check state
terraform state list

# Check the S3 lock object, if present
aws s3api head-object \
  --bucket company-terraform-state \
  --key production/terraform.tfstate.tflock
```

Real-Time Scenario: Engineer A applies production changes, and Terraform creates an S3 lock object. Engineer B must wait for the lock to be released.

Follow-Up: What about DynamoDB state locking?

Answer: Older Terraform configurations use DynamoDB for S3 backend locking. DynamoDB locking is deprecated, and supported modern configurations can use S3 lockfiles.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://developer.hashicorp.com\&sz=32)

HashiCorp Developer



### Q5. How does Terraform state locking work in Azure?

Interview Answer:

In Azure, Terraform stores remote state in Azure Blob Storage.

Azure Blob Storage supports locking through blob leases, preventing multiple Terraform operations from changing the same state.

Production Commands:

```
# Initialize Azure backend
terraform init

# Check Azure Storage account
az storage account show \
  -g prod-rg \
  -n companytfstate

# Check state blob metadata and lease status
az storage blob show \
  --account-name companytfstate \
  --container-name tfstate \
  --name prod.tfstate \
  --auth-mode login
```

Real-Time Scenario: An Azure DevOps pipeline crashes while applying Terraform. I verify the pipeline is stopped and check the lock before using the approved unlock procedure.

Important: `terraform force-unlock <lock-id>` is the standard Terraform recovery command when supported by the backend.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://developer.hashicorp.com\&sz=32)

HashiCorp Developer



### Q6. What happens if Terraform apply crashes after creating some resources?

Interview Answer:

Terraform may have created some resources before the failure.

It does not automatically roll back everything. I check the state file, actual AWS resources, and error logs.

Then I fix the issue, run Terraform plan, and reconcile the remaining changes.

Production Commands:

```
# Check existing state
terraform state list

# Inspect particular resource
terraform state show aws_instance.app

# Compare with AWS
aws ec2 describe-instances \
  --instance-ids <instance-id>

# Identify remaining changes
terraform plan
```

Real-Time Scenario: Terraform creates an S3 bucket successfully but fails to create an EC2 instance because of insufficient IAM permissions.

After correcting permissions, I rerun the plan and apply only the required changes.

### Q7. A Terraform resource exists in AWS but is missing from the state file. What will you do?

Interview Answer:

I first check whether the resource was created during a failed Terraform apply or manually.

If it should be managed by Terraform, I import it into the correct state and verify the configuration.

Production Commands:

```
# Verify managed resources
terraform state list

# Import existing EC2 resource
terraform import \
  aws_instance.app \
  <instance-id>

# Verify import
terraform state show aws_instance.app

# Review further changes
terraform plan
```

Real-Time Scenario: An EC2 instance was created before Jenkins crashed, but Terraform did not record it in state.

After confirming ownership and the actual configuration, we import the existing instance rather than creating a duplicate.

### Q8. How do you recover a deleted or corrupted Terraform state file?

Interview Answer:

First, I stop infrastructure changes to prevent further problems.

Then I check S3 versioning or other state backups and identify the latest valid state.

After approved recovery, I verify the state against actual infrastructure.

Production Commands:

```
# List previous state versions
aws s3api list-object-versions \
  --bucket company-terraform-state \
  --prefix production/terraform.tfstate

# Back up currently accessible state
terraform state pull > state-backup.tfstate

# Verify recovered state
terraform state list

# Compare infrastructure
terraform plan
```

Real-Time Scenario: Someone accidentally overwrites the production state file. We recover a valid previous version from S3 after comparing state history with actual cloud resources.

Important: State backups contain sensitive data. Keep them in restricted storage and never upload them to Git.

### Q9. How do you migrate Terraform state from local storage to AWS S3?

Interview Answer:

First, I create a secure S3 backend with versioning and locking.

Then I update Terraform backend configuration and use `terraform init -migrate-state`.

Finally, I verify that the state migrated successfully.

Example Backend:

```
terraform {
  backend "s3" {
    bucket       = "company-terraform-state"
    key          = "production/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}
```

Production Commands:

```
# Initialize and migrate existing state
terraform init -migrate-state

# Verify resources
terraform state list

# Verify infrastructure
terraform plan
```

Real-Time Scenario: An organization initially stores Terraform state locally. As the team grows, we migrate it to a secured S3 backend for collaboration and state locking.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://developer.hashicorp.com\&sz=32)

HashiCorp Developer



### Q10. What is the difference between `terraform init -migrate-state` and `terraform init -reconfigure`?

Interview Answer:

`-migrate-state` attempts to migrate the existing Terraform state into the new backend.

`-reconfigure` initializes the new backend configuration without automatically migrating the previous state.

Production Commands:

```
# Migrate existing state
terraform init -migrate-state

# Reinitialize without state migration
terraform init -reconfigure
```

Real-Time Scenario: When moving from local Terraform state to S3, I normally use `-migrate-state` to preserve resource tracking.

If I only need to reconnect to an already prepared backend, I may use `-reconfigure`.

### Q11. How do you rename a Terraform resource without recreating it?

Interview Answer:

We use a `moved` block when changing the Terraform resource address.

This tells Terraform that the resource has moved to a new address instead of needing deletion and recreation.

Example:

```
moved {
  from = aws_instance.old_app
  to   = aws_instance.new_app
}
```

Production Commands:

```
terraform fmt

terraform validate

terraform plan
```

Real-Time Scenario: During Terraform module refactoring, we rename a resource. By using a moved block, we can avoid unnecessary infrastructure replacement.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://developer.hashicorp.com\&sz=32)

HashiCorp Developer



### Q12. What is the difference between `terraform state mv` and `terraform state rm`?

Interview Answer:

`terraform state mv` changes a resource's address in Terraform state.

`terraform state rm` removes a resource from Terraform management without deleting the actual cloud resource.

Production Commands:

```
# Move resource address in state
terraform state mv \
  aws_instance.old_app \
  aws_instance.new_app

# Stop Terraform managing a resource
terraform state rm aws_instance.app

# Verify
terraform state list
```

Real-Time Scenario: We use state movement during carefully planned refactoring. We may remove a resource from state when ownership is moving to another approved management process.

Important: These are state-changing operations. Modern `moved` and `removed` blocks are often preferred because changes can be reviewed in Git.

### Q13. Terraform plan detects drift in production. What will you do?

Interview Answer:

Terraform drift means the actual infrastructure differs from Terraform configuration.

I check the plan and investigate whether someone manually modified resources or another automation changed them.

Then we decide whether to update the Terraform code or restore the configured infrastructure.

Production Commands:

```
# Detect changes
terraform plan

# Check external changes only
terraform plan -refresh-only

# Inspect managed resource
terraform state show aws_security_group.app
```

Real-Time Scenario: A security group rule is changed manually in AWS Console.

Terraform detects the difference. We review the change and restore the approved configuration through Terraform if required.

### Q14. Terraform wants to destroy a production resource unexpectedly. How do you prevent it?

Interview Answer:

I do not apply the change immediately.

I review the plan, Terraform state, and recent code changes.

I also use lifecycle protection for critical resources and require production approvals.

Example:

```
lifecycle {
  prevent_destroy = true
}
```

Production Commands:

```
# Review destructive changes
terraform plan

# Save plan
terraform plan -out=prod.tfplan

# Inspect saved plan
terraform show prod.tfplan

# Verify state
terraform state list
```

Real-Time Scenario: Terraform proposes replacing an important database because an immutable attribute changed.

I investigate the configuration and determine a safe migration or replacement plan rather than applying it directly.

### Q15. How do you upgrade Terraform providers in a production project?

Interview Answer:

First, I check the current provider version and target version compatibility.

Then I update the provider version constraints, test in Dev, and generate a Terraform plan.

After approval, we upgrade Production.

Production Commands:

```
# Check Terraform and providers
terraform version
terraform providers

# Upgrade providers within allowed constraints
terraform init -upgrade

# Verify configuration
terraform validate

# Check infrastructure changes
terraform plan
```

Real-Time Scenario: We upgrade the AWS provider to support new EKS functionality. We test the provider in staging and review the `.terraform.lock.hcl` changes before production rollout.

### Q16. What is Terraform Enterprise, and how does it help in production?

Interview Answer:

Terraform Enterprise is a platform for managing infrastructure deployments with centralized workspaces, remote execution, team permissions, state management, policy enforcement, and audit history.

It helps organizations control infrastructure changes.

Practical Production Process:

```
Developer Creates Pull Request
          |
          v
Terraform Enterprise Workspace
          |
          v
Terraform Plan
          |
          v
Policy Checks
          |
          v
Approval
          |
          v
Terraform Apply
          |
          v
Updated Infrastructure
```

Real-Time Scenario: A developer proposes creating a production EC2 instance.

Terraform Enterprise generates a plan, performs policy checks, and requires approval before applying changes.

### Q17. A Terraform Enterprise workspace is locked. How do you unlock it?

Interview Answer:

First, I check whether there is an active Terraform run.

If a run is active, I do not unlock the workspace. If the workspace is stuck after a failed run, an authorized administrator can follow the platform's cancellation and unlock procedure.

Production Steps:

1. Open the Terraform Enterprise workspace.
2. Check the current run status.
3. Cancel the run safely if required.
4. Confirm the run has stopped.
5. Use Actions → Unlock Workspace, or an administrator-approved force-unlock operation if necessary.
6. Verify state and start a new plan.

Real-Time Scenario: A Terraform Enterprise run gets stuck after an agent failure. The administrator verifies the run status and recovers the workspace before allowing additional infrastructure changes.

Important: Terraform Enterprise workspace locking and CLI state locking are related but different mechanisms. Admin force-unlocking or force-canceling a run can cause state inconsistencies if work is still active.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://developer.hashicorp.com\&sz=32)

HashiCorp Developer

+1



### Q18. How do you handle Terraform failures in Jenkins or Azure DevOps?

Interview Answer:

First, I check the pipeline logs to identify the failed stage.

Then I verify Terraform configuration, state locks, provider errors, IAM permissions, and cloud resources.

Once the issue is fixed, I rerun the pipeline after reviewing the new plan.

Production Commands:

```
# Initialize
terraform init

# Validate
terraform validate

# Review pending changes
terraform plan

# Check current state
terraform state list

# Check AWS credentials
aws sts get-caller-identity
```

Real-Time Scenario: Jenkins fails during Terraform apply because AWS credentials expire.

I check the pipeline credentials, configure valid short-lived authentication, verify the state, and retry after approval.

### Q19. How do you protect Terraform secrets and sensitive values?

Interview Answer:

We avoid hardcoding passwords or API keys in Terraform files.

We use secrets managers, secure CI/CD variables, restricted state access, and IAM roles.

We also avoid printing sensitive information in pipeline logs.

Example:

```
variable "db_password" {
  type      = string
  sensitive = true
}
```

Production Commands:

```
# Check configuration
terraform validate

# Review changes
terraform plan

# Check AWS identity
aws sts get-caller-identity
```

Real-Time Scenario: Jenkins retrieves database credentials from a secure credential store rather than storing them in Git.

Important: Marking a Terraform variable `sensitive` hides it from normal CLI output, but its value may still be stored in Terraform state.

### Q20. How do you prevent multiple Jenkins pipelines from applying Terraform to the same production environment?

Interview Answer:

We use remote state locking and also control parallel execution in Jenkins.

Only one production infrastructure deployment should run against the same Terraform state at a time.

We also configure approvals and separate state files for independent environments.

Jenkins Pipeline Example:

```
pipeline {
    agent any

    options {
        disableConcurrentBuilds()
    }

    stages {
        stage('Terraform Plan') {
            steps {
                sh 'terraform init'
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                input 'Approve production changes?'
                sh 'terraform apply tfplan'
            }
        }
    }
}
```

Real-Time Scenario: Two developers merge Terraform changes close together. Jenkins serializes production deployments, while Terraform state locking prevents concurrent state modifications.

Important: `disableConcurrentBuilds()` applies to runs of that Jenkins job. For multiple jobs sharing one state, use a shared pipeline lock or a single deployment workflow as well.

## Bonus: Additional Terraform Interview Questions

| Question                                                   | Short Answer                                                                                            |
| ---------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Can we force-unlock someone else's active Terraform state? | Technically possible in supported backends, but unsafe. Never do it while the apply is active.          |
| How do you find the Terraform lock ID?                     | The state lock error normally displays the lock ID and owner.                                           |
| Does force-unlock delete AWS resources?                    | No. It removes the state lock only.                                                                     |
| Does force-unlock repair corrupted state?                  | No. State recovery is a separate process.                                                               |
| What if Terraform apply stops halfway?                     | Check existing resources, state, and remaining planned changes.                                         |
| What is `-lock-timeout`?                                   | The maximum duration Terraform waits to acquire a lock.                                                 |
| What is `-lock=false`?                                     | Disables state locking for that operation; dangerous for shared state.                                  |
| Can different Terraform states be modified simultaneously? | Yes, if they are independent and do not conflict over shared resources.                                 |
| What is Terraform state lineage?                           | An identifier used to track the identity of a Terraform state.                                          |
| What is state serial?                                      | A version counter that increases as state changes.                                                      |
| What is a stale state lock?                                | A lock left behind after an operation stops without releasing it.                                       |
| What is a moved block?                                     | It records a Terraform resource address change without requiring replacement.                           |
| What is provider version locking?                          | Recording selected provider versions in `.terraform.lock.hcl`.                                          |
| What is `terraform plan -refresh-only`?                    | Previews state updates needed to reflect actual remote objects without proposing configuration changes. |
| Can we use Terraform to manage AWS and Azure together?     | Yes, by configuring the required providers.                                                             |
| What is policy as code?                                    | Rules used to validate infrastructure changes before deployment.                                        |
| How do you control Production Terraform access?            | IAM, workspace permissions, approvals, and protected pipelines.                                         |

## Important Terraform State Locking Commands – Quick Revision

```
# 1. Check selected workspace
terraform workspace show

# 2. Initialize state backend
terraform init

# 3. Wait for state lock
terraform plan -lock-timeout=5m

# 4. Force-unlock verified stale lock
terraform force-unlock <lock-id>

# 5. Skip unlock confirmation
terraform force-unlock -force <lock-id>

# 6. Check managed resources
terraform state list

# 7. Inspect specific resource
terraform state show aws_instance.app

# 8. Back up accessible state securely
terraform state pull > state-backup.tfstate

# 9. Check infrastructure after recovery
terraform plan

# 10. Check state migration
terraform init -migrate-state
```

## Most Important Scenario to Remember for Your Interview

Interviewer: Two people are working on Terraform. One person starts `terraform apply`, but their laptop or Jenkins server crashes. The Terraform state remains locked. What will you do?

Best Interview Answer:

> First, I check whether the previous Terraform operation is still running.
>
> If it has crashed, I verify with the engineer or pipeline owner that no operation is active.
>
> Then I get the lock ID from the Terraform error message.
>
> After approval, I use `terraform force-unlock <lock-id>` to release the stale lock.
>
> Once the lock is released, I run `terraform state list` and `terraform plan` to check whether any infrastructure was partially created.
>
> After verifying the actual resources and Terraform state, I continue the deployment.
>
> I never force-unlock a state while another engineer's apply is still running, because it can cause state corruption.

End of Subtopic 2.2 – Advanced Terraform

Covered: 20 detailed interview questions + 17 bonus questions, including your requested two-engineer Terraform state locking and force-unlock scenario.

Next Subtopic 2.3: Terraform Real-Time Production Scenarios – EKS Creation, VPC Infrastructure, Multi-Region Deployment, AWS Disaster Recovery Infrastructure, Terraform Modules, and Complex CI/CD Troubleshooting.

# X Company – SRE Interview Preparation

## Section 2: Terraform

### Subtopic 2.3: Real-Time Production Scenarios – AWS Infrastructure, EKS, Disaster Recovery and CI/CD

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: Real-world Terraform projects, VPC, EC2, EKS, multi-region infrastructure, Disaster Recovery, Jenkins pipelines, security, and production failures.

### Example Production Environment

```
Cloud          : AWS
Primary Region : ap-south-1 (Mumbai)
DR Region      : ap-south-2 (Hyderabad)
Infrastructure : VPC, EC2, EKS, ALB, S3, RDS
IaC            : Terraform
CI/CD          : Jenkins
State Backend  : AWS S3
Monitoring     : Prometheus + Grafana
```

All examples assume an approved production change process. Replace resource names, IDs, and regions with your actual environment.

### Q1. Explain how you build AWS infrastructure from scratch using Terraform.

Interview Answer:

First, I create Terraform modules for networking, compute, security, and storage.

I provision VPC, subnets, route tables, NAT Gateway, security groups, and then EC2 or EKS resources.

We use remote state in S3 and deploy through a Jenkins pipeline after approval.

Production Steps:

```
Terraform Code
     |
     v
VPC + Subnets + Routing
     |
     v
Security Groups + IAM
     |
     v
EC2 / EKS / RDS / ALB
     |
     v
Monitoring + Backups
     |
     v
Production Validation
```

Production Commands:

```
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Generate execution plan
terraform plan -out=prod.tfplan

# Apply approved plan
terraform apply prod.tfplan

# Verify infrastructure
aws ec2 describe-vpcs
aws eks list-clusters
```

Real-Time Scenario: When a new production environment is required, we deploy the reviewed infrastructure configuration through Terraform instead of manually creating resources in AWS Console.

### Q2. How do you create a VPC and subnets using Terraform?

Interview Answer:

We create a VPC and separate public and private subnets across Availability Zones.

Public subnets are normally used for internet-facing load balancers, while private subnets are commonly used for application workloads and databases.

Example Terraform Code:

```
resource "aws_vpc" "prod" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "production-vpc"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.prod.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "production-private-subnet"
  }
}
```

Production Commands:

```
terraform init
terraform validate
terraform plan

# Verify VPC
aws ec2 describe-vpcs

# Verify subnets
aws ec2 describe-subnets
```

Real-Time Scenario: For EKS, we create private subnets across multiple Availability Zones and configure routing and NAT or VPC endpoints for required external services.

### Q3. How do you create an EKS cluster using Terraform?

Interview Answer:

We use Terraform modules to provision the VPC, EKS control plane, managed node groups, and IAM roles.

After provisioning, we configure cluster access, CNI, CoreDNS, kube-proxy, storage drivers, and monitoring.

Example Terraform Module:

```
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  # Pin an approved compatible module version
  version = "<approved-version>"

  name               = "prod-eks"
  kubernetes_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  eks_managed_node_groups = {
    application = {
      instance_types = ["t3.large"]
      min_size       = 2
      max_size       = 5
      desired_size   = 3
    }
  }
}
```

Module arguments depend on the selected release, so we validate the configuration against the pinned module documentation.

Production Commands:

```
# Initialize modules
terraform init

# Verify infrastructure changes
terraform plan

# Connect after provisioning
aws eks update-kubeconfig \
  --name prod-eks \
  --region ap-south-1

# Verify nodes
kubectl get nodes

# Verify system pods
kubectl get pods -n kube-system
```

Real-Time Scenario: We provision EKS using Terraform and then deploy applications through Helm and Argo CD.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

AWS Prescriptive Guidance



### Q4. How do you provision EC2 instances, Auto Scaling Groups and ALB using Terraform?

Interview Answer:

We create a Launch Template, Auto Scaling Group, Target Group, and Application Load Balancer using Terraform.

The ASG maintains the required number of EC2 instances, while ALB distributes application traffic.

Example Launch Template:

```
resource "aws_launch_template" "app" {
  name_prefix   = "payment-app-"
  image_id      = var.ami_id
  instance_type = "t3.medium"

  vpc_security_group_ids = [
    var.app_security_group_id
  ]
}
```

Production Commands:

```
# Review configuration
terraform plan

# Verify Auto Scaling Groups
aws autoscaling describe-auto-scaling-groups

# Verify Load Balancers
aws elbv2 describe-load-balancers

# Verify EC2 instances
aws ec2 describe-instances
```

Real-Time Scenario: If an EC2 instance becomes unhealthy, Auto Scaling can replace it based on configured health checks and capacity settings.

### Q5. How do you integrate Terraform with Jenkins for production deployment?

Interview Answer:

We store Terraform code in GitHub. Jenkins automatically runs formatting, validation, and Terraform plan.

For production, an authorized person reviews and approves the changes before Jenkins applies the saved plan.

Example Jenkins Pipeline:

```
pipeline {
    agent any

    stages {
        stage('Validate') {
            steps {
                sh 'terraform init'
                sh 'terraform fmt -check'
                sh 'terraform validate'
            }
        }

        stage('Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Approval') {
            steps {
                input 'Approve infrastructure deployment?'
            }
        }

        stage('Apply') {
            steps {
                sh 'terraform apply tfplan'
            }
        }
    }
}
```

Real-Time Scenario: A developer changes EKS node capacity in Git. Jenkins generates a plan, and after approval it applies the reviewed infrastructure changes.

Production Note: Jenkins must use an approved IAM role, secure plan artifacts, and shared state locking. The sample pipeline also needs workspace concurrency controls and protected production permissions.

### Q6. How do you create AWS infrastructure in multiple regions using Terraform?

Interview Answer:

We use multiple AWS provider configurations with aliases, or separate regional Terraform configurations.

For example, we create production resources in Mumbai and Disaster Recovery resources in Hyderabad.

Example Terraform Code:

```
provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias  = "dr"
  region = "ap-south-2"
}

resource "aws_s3_bucket" "primary" {
  bucket = "example-payment-primary-12345"
}

resource "aws_s3_bucket" "dr" {
  provider = aws.dr
  bucket   = "example-payment-dr-12345"
}
```

Production Commands:

```
terraform init
terraform plan

# Check primary Region buckets
aws s3api list-buckets \
  --query 'Buckets[*].Name'

# Verify specific DR bucket region
aws s3api get-bucket-location \
  --bucket example-payment-dr-12345
```

Real-Time Scenario: We provision infrastructure in both regions so that an approved DR recovery process can restore production workloads in the secondary region.

Provider aliases remain a supported approach for multi-region deployments.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.hashicorp.com\&sz=32)

HashiCorp Developer



### Q7. How do you create Disaster Recovery infrastructure using Terraform?

Interview Answer:

We maintain Terraform configuration for both the primary and DR regions.

The DR configuration includes required networking, compute, IAM, security, storage, and load-balancer resources.

Depending on the DR strategy, we keep the secondary environment running or provision it when disaster recovery is activated.

Example Infrastructure Layout:

```
terraform/
  modules/
    vpc/
    eks/
    iam/
    alb/

  environments/
    prod-primary/
    prod-dr/
```

Production Commands:

```
# Check primary infrastructure
cd environments/prod-primary
terraform init
terraform plan

# Check DR infrastructure
cd ../prod-dr
terraform init
terraform plan

# Verify DR resources
aws eks list-clusters \
  --region ap-south-2

aws ec2 describe-vpcs \
  --region ap-south-2
```

Real-Time Scenario: If the primary AWS region becomes unavailable, Terraform can help provision or reconcile required DR infrastructure in the secondary region.

Important: Terraform provisions infrastructure, but application data recovery, DNS switching, and service validation require additional procedures.

### Q8. How do you configure cross-region backups for Disaster Recovery?

Interview Answer:

We use AWS Backup, S3 replication, database replication, or service-specific snapshots based on the resource.

Terraform provisions the backup infrastructure, IAM roles, vaults, and policies.

We also perform recovery testing to verify that backups are usable.

Example Terraform Configuration:

```
resource "aws_backup_vault" "primary" {
  name = "primary-backup-vault"
}

resource "aws_backup_vault" "dr" {
  provider = aws.dr
  name     = "dr-backup-vault"
}
```

Production Commands:

```
# Check primary backup vaults
aws backup list-backup-vaults \
  --region ap-south-1

# Check DR backup vaults
aws backup list-backup-vaults \
  --region ap-south-2

# Check completed recovery points
aws backup list-recovery-points-by-backup-vault \
  --backup-vault-name dr-backup-vault \
  --region ap-south-2
```

Real-Time Scenario: Our primary database is in Mumbai. Backups are copied to a supported recovery vault in Hyderabad using an approved backup plan.

Important: Creating backup vaults alone does not configure cross-region backup. We must also configure backup selection, schedules, copy rules, IAM permissions, encryption, and retention policies. Cross-region support varies by resource type.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

AWS Backup



### Q9. A complete AWS region goes down. How do you restore infrastructure using Terraform?

Interview Answer:

First, I confirm the regional outage and activate the approved Disaster Recovery process.

Then I verify the secondary region, provision or reconcile infrastructure using Terraform, restore application data, deploy workloads, and validate health.

After recovery, we redirect traffic through the approved DNS or load-balancer process.

Production Commands:

```
# Connect to DR infrastructure configuration
cd environments/prod-dr

# Initialize Terraform
terraform init

# Check required infrastructure
terraform plan -out=dr.tfplan

# Apply approved DR plan
terraform apply dr.tfplan

# Verify DR EKS cluster
aws eks describe-cluster \
  --name prod-dr-eks \
  --region ap-south-2

# Check DR backups
aws backup list-backup-vaults \
  --region ap-south-2
```

Real-Time Scenario: The Mumbai region becomes unavailable. We activate our Hyderabad DR environment, restore the required application data, validate services, and redirect production traffic.

Follow-Up: Can Terraform automatically restore the database?

Answer: Terraform can provision infrastructure and manage some recovery resources, but database restoration usually requires a separate restore or replication process and validation.

### Q10. How do you manage multiple AWS accounts using Terraform?

Interview Answer:

We use separate AWS accounts for Dev, QA, and Production.

Terraform assumes approved IAM roles to manage resources in the required accounts without storing permanent AWS credentials.

Example Terraform Code:

```
provider "aws" {
  region = "ap-south-1"

  assume_role {
    role_arn = var.production_role_arn
  }
}
```

Production Commands:

```
# Verify AWS identity
aws sts get-caller-identity

# Initialize configuration
terraform init

# Preview changes
terraform plan
```

Real-Time Scenario: Jenkins assumes a production deployment role with limited permissions before applying Terraform changes to the Production AWS account.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://developer.hashicorp.com\&sz=32)

HashiCorp Developer



### Q11. Terraform fails with AccessDenied. How do you troubleshoot?

Interview Answer:

I check which IAM role Terraform is using and identify the denied AWS API operation.

Then I verify IAM policies, resource policies, permissions boundaries, and organization-level restrictions.

Production Commands:

```
# Verify current AWS identity
aws sts get-caller-identity

# Validate Terraform
terraform validate

# Retry plan after checking permissions
terraform plan
```

Real-Time Scenario: Terraform cannot create an EKS node group because the deployment role lacks required IAM permissions.

We correct the approved permissions and rerun the Terraform plan.

### Q12. Terraform successfully creates EKS, but worker nodes are not joining. What will you do?

Interview Answer:

I check node group health, IAM roles, subnet routing, security groups, and network connectivity.

I also verify the EKS cluster version and node group configuration.

Production Commands:

```
# Check node group health
aws eks describe-nodegroup \
  --cluster-name prod-eks \
  --nodegroup-name prod-workers

# Check Kubernetes nodes
kubectl get nodes

# Check cluster status
aws eks describe-cluster \
  --name prod-eks

# Check Terraform state
terraform state list
```

Real-Time Scenario: EKS control plane is active, but worker nodes cannot join because of an incorrect networking or IAM configuration. I identify the node group health issue and correct it through Terraform.

### Q13. How do you troubleshoot Terraform resource dependency failures?

Interview Answer:

Terraform automatically detects dependencies when resources reference one another.

If an additional dependency is required, I use `depends_on`.

I also check whether the dependent resource is actually available and ready.

Example:

```
resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = "t3.micro"

  depends_on = [
    aws_iam_role_policy_attachment.app
  ]
}
```

Production Commands:

```
terraform validate

terraform plan

# Inspect dependency graph
terraform graph
```

Real-Time Scenario: An application requires IAM permissions before starting. We make Terraform wait for the relevant policy attachment operation before creating the instance.

### Q14. Terraform apply fails because AWS credentials have expired. What will you do?

Interview Answer:

I check the AWS identity and the authentication mechanism used by the pipeline.

If temporary credentials have expired, I renew the approved session or role credentials.

Then I verify the Terraform state and rerun the plan.

Production Commands:

```
# Check AWS credentials
aws sts get-caller-identity

# Verify AWS configuration
aws configure list

# Check Terraform state
terraform state list

# Review remaining changes
terraform plan
```

Real-Time Scenario: A Jenkins job fails during Terraform apply because temporary AWS credentials expire. We correct the credential renewal process and retry safely.

### Q15. Terraform fails because the AWS resource already exists. What will you do?

Interview Answer:

First, I verify whether the resource was created manually or during a previous failed execution.

If it belongs to our Terraform configuration, I import it into state instead of creating a duplicate.

Production Commands:

```
# Check managed resources
terraform state list

# Import existing S3 bucket
terraform import \
  aws_s3_bucket.app \
  existing-payment-bucket

# Review configuration
terraform plan
```

Real-Time Scenario: Terraform fails to create an S3 bucket because the bucket already exists. We confirm ownership, import it into the correct state, and review the plan.

### Q16. Someone manually changes a security group in AWS. How do you handle it?

Interview Answer:

I run Terraform plan to detect infrastructure drift.

Then I check whether the manual change was approved.

If it was unauthorized, we restore the configuration defined in Terraform.

Production Commands:

```
# Detect drift
terraform plan

# Inspect managed security group
terraform state show aws_security_group.app

# Verify AWS rules
aws ec2 describe-security-groups \
  --group-ids <security-group-id>
```

Real-Time Scenario: Someone opens SSH port 22 to the internet in a production security group.

Terraform detects the change. We investigate and restore the approved security configuration.

### Q17. Terraform plan shows resource replacement. How do you handle it without downtime?

Interview Answer:

First, I identify why Terraform wants to replace the resource.

Then I check whether we can create the replacement before destroying the existing resource.

If replacement could affect production, we use a suitable migration strategy and validate it before removing the old resource.

Example:

```
lifecycle {
  create_before_destroy = true
}
```

Production Commands:

```
# Review replacement
terraform plan

# Save execution plan
terraform plan -out=prod.tfplan

# Inspect changes
terraform show prod.tfplan
```

Real-Time Scenario: A resource requires replacement due to an immutable setting. We review capacity, dependencies, and traffic cutover to minimize downtime.

Important: `create_before_destroy` does not work safely for every resource, especially where unique names or other constraints prevent two instances existing together.

### Q18. How do you use Terraform plan exit codes in a CI/CD pipeline?

Interview Answer:

We use `terraform plan -detailed-exitcode` to identify whether infrastructure changes are required.

The exit code helps Jenkins determine whether to continue, report an error, or skip deployment.

Production Command:

```
terraform plan -detailed-exitcode
```

| Exit Code | Meaning                        |
| --------- | ------------------------------ |
| `0`       | No infrastructure changes      |
| `1`       | Terraform encountered an error |
| `2`       | Terraform changes are present  |

Real-Time Scenario: Jenkins generates a Terraform plan. If there are no changes, the deployment stage can be skipped. If changes exist, the pipeline requests approval before applying them.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://developer.hashicorp.com\&sz=32)

HashiCorp Developer



### Q19. How do you optimize infrastructure costs using Terraform?

Interview Answer:

We use reusable modules, proper resource sizing, autoscaling, and environment-specific configurations.

We also apply resource tags and remove unnecessary infrastructure after approval.

Example Terraform Code:

```
provider "aws" {
  region = "ap-south-1"

  default_tags {
    tags = {
      Environment = "production"
      ManagedBy   = "Terraform"
      Project     = "payments"
    }
  }
}
```

Production Commands:

```
# Check proposed infrastructure
terraform plan

# Identify managed resources
terraform state list

# Check EC2 inventory
aws ec2 describe-instances \
  --query 'Reservations[*].Instances[*].[InstanceId,InstanceType]'
```

Real-Time Scenario: We identify oversized EC2 instances using monitoring and cost data, then update Terraform configurations to use appropriate instance sizes.

### Q20. Explain a real-time Terraform infrastructure project from end to end.

Interview Answer:

In a production-style project, Terraform was used to manage AWS infrastructure including VPC, EC2, EKS, IAM, S3, and load balancers.

We maintained reusable modules and separate state files for Dev, QA, and Production.

Jenkins automated Terraform validation and planning. Production changes required approval before applying.

We also used Terraform to maintain the infrastructure required for Disaster Recovery.

Project Flow:

```
Business Requirement
        |
        v
Terraform Modules
        |
        v
GitHub Pull Request
        |
        v
Jenkins Validation
        |
        v
Terraform Plan
        |
        v
Production Approval
        |
        v
Terraform Apply
        |
        v
AWS Infrastructure
        |
        v
Verification + Monitoring
```

Production Commands:

```
terraform init
terraform fmt -check
terraform validate
terraform plan -out=prod.tfplan
terraform apply prod.tfplan

# Verify infrastructure
aws eks list-clusters
aws ec2 describe-vpcs
aws elbv2 describe-load-balancers
```

Real-Time Scenario: A new application requires an EKS environment. We provision its infrastructure with Terraform, deploy the application through Argo CD, and validate it through monitoring.

Use this answer only for the responsibilities you personally performed.

## Bonus: Additional Second-Round Terraform Questions

| Interview Question                                    | Short Answer                                                                  |
| ----------------------------------------------------- | ----------------------------------------------------------------------------- |
| How do you create infrastructure in two regions?      | Use provider aliases or separate regional configurations.                     |
| Does Terraform automatically fail over applications?  | No. Failover requires separate orchestration and traffic management.          |
| How do you protect critical resources from deletion?  | Use approval processes and suitable lifecycle protections.                    |
| How do you verify AWS permissions?                    | Use `aws sts get-caller-identity` and review IAM policies.                    |
| How do you identify Terraform-managed infrastructure? | Use `terraform state list` and `terraform state show`.                        |
| What happens if an apply fails halfway?               | Some resources may exist. Check state and cloud resources before retrying.    |
| Can Terraform create EKS and RDS together?            | Yes, using appropriate configurations and dependencies.                       |
| How do you handle a failed DR deployment?             | Check logs, Terraform state, IAM permissions, backups, and remaining changes. |
| Does Terraform support multi-cloud deployments?       | Yes, using providers such as AWS and AzureRM.                                 |
| How do you prevent concurrent production applies?     | State locking, CI/CD concurrency controls, and approvals.                     |

## Last-Minute Production Troubleshooting Commands

```
# Initialize and validate
terraform init
terraform validate

# Check AWS identity
aws sts get-caller-identity

# Preview changes
terraform plan

# Check resource state
terraform state list
terraform state show <resource-address>

# Detect drift
terraform plan -refresh-only

# Import an existing resource
terraform import <resource-address> <resource-id>

# Check state locking
terraform plan -lock-timeout=5m

# Force-unlock a confirmed stale lock
terraform force-unlock <lock-id>

# Check Terraform provider versions
terraform providers

# Check EKS clusters
aws eks list-clusters

# Check EC2 instances
aws ec2 describe-instances

# Check AWS Backup
aws backup list-backup-vaults
```

## Most Important Follow-Up for the   SRE Interview

Interviewer: You told me you worked on Terraform Disaster Recovery infrastructure. What exactly did you do?

Suggested Answer (adapt to your actual experience):

> I was involved in managing the infrastructure required for Disaster Recovery using Terraform.
>
> We maintained separate Terraform configurations for the primary and DR environments.
>
> We used Terraform to manage networking, compute, IAM, storage, and other infrastructure components.
>
> We maintained remote state with locking and deployed infrastructure changes through our approved pipeline.
>
> During DR testing, we verified that the secondary region had the required infrastructure and that application backups and recovery procedures worked correctly.
>
> For troubleshooting, I checked Terraform plan, state, AWS permissions, and resource status before making changes.

End of Subtopic 2.3 – Terraform Real-Time Production Scenarios

Covered: 20 detailed questions + 10 additional SRE interview questions.

Next Section 3: Docker – Dockerfile, CMD vs ENTRYPOINT, Docker Compose, Multistage Builds, Image Optimization, Container Troubleshooting, Networking, Security, and Real-Time Production Scenarios.

# X Company – SRE Interview Preparation

## Section 3: Docker

### Subtopic 3.1: Dockerfile, CMD, ENTRYPOINT, Docker Compose, Container Troubleshooting and Production Scenarios

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: HR questions + additional interview questions + practical commands + CPU/memory troubleshooting + container crashes + real-time production scenarios.

### Example Production Environment

```
Cloud          : AWS
CI/CD          : Jenkins + Argo CD
Container      : Docker
Registry       : AWS ECR
Orchestration  : Kubernetes (EKS)
Application    : payment-service
Monitoring     : Prometheus + Grafana
```

### Q1. What is the difference between Docker and Kubernetes?

Interview Answer:

Docker is used to build, package, and run containerized applications.

Kubernetes is used to orchestrate containers across multiple nodes. It manages scaling, deployment, networking, and self-healing.

Practical Commands:

```
# Docker: Run a container
docker run -d --name nginx -p 8080:80 nginx

# Docker: Check containers
docker ps

# Kubernetes: Check application pods
kubectl get pods -n production

# Kubernetes: Scale application
kubectl scale deployment/payment-service \
  --replicas=3 -n production
```

Real-Time Scenario: Jenkins builds Docker images and pushes them to ECR. Argo CD deploys those images into EKS, where Kubernetes manages the running application pods.

### Q2. What is a Docker image, and what is a Docker container?

Interview Answer:

A Docker image is a read-only package containing the application, dependencies, and required runtime.

A container is a running instance of that image.

We can create multiple containers using the same Docker image.

Production Commands:

```
# List images
docker images

# Create and run container
docker run -d --name payment-api payment-service:v1

# Check running containers
docker ps

# Check all containers
docker ps -a
```

Real-Time Scenario: We build one Payment Service image and use it to run multiple application instances.

### Q3. How do you create a Dockerfile and build an application image?

Interview Answer:

We create a Dockerfile containing the base image, application files, dependencies, working directory, and startup command.

Then we build the image and test it before pushing it to ECR.

Example Dockerfile – Python Application:

```
FROM python:3.13-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 8080

CMD ["python", "app.py"]
```

Production Commands:

```
# Build image
docker build -t payment-service:v1 .

# Run container
docker run -d \
  --name payment-api \
  -p 8080:8080 \
  payment-service:v1

# Check running container
docker ps

# Check logs
docker logs payment-api

# Test application
curl http://localhost:8080
```

Real-Time Scenario: Jenkins checks out Python source code, builds the Docker image, runs tests, and pushes the image to AWS ECR.

### Q4. What is the difference between Dockerfile and Docker Compose?

Interview Answer:

Dockerfile is used to build a Docker image.

Docker Compose is used to define and run multiple containers together using a YAML file.

Example `compose.yaml`:

```
services:
  app:
    image: payment-service:v1
    ports:
      - "8080:8080"
    depends_on:
      - redis

  redis:
    image: redis:7-alpine
```

Production Commands:

```
# Start containers
docker compose up -d

# Check services
docker compose ps

# Check logs
docker compose logs -f

# Stop and remove containers
docker compose down
```

Real-Time Scenario: Developers use Docker Compose to run Payment Service and Redis together for integration testing.

Follow-Up: Does `depends_on` mean Redis is ready?

Answer: Not by default. It controls startup order. For readiness, we configure a health check and use `condition: service_healthy`.

### Q5. What happens if multiple CMD instructions are used in a Dockerfile?

Interview Answer:

If we define multiple `CMD` instructions in the same Dockerfile stage, only the last `CMD` takes effect.

The previous CMD instructions are ignored.

Example Dockerfile:

```
FROM alpine:3.20

CMD ["echo", "First Command"]

CMD ["echo", "Second Command"]

CMD ["echo", "Third Command"]
```

Expected Output:

```
Third Command
```

Practical Commands:

```
# Build image
docker build -t cmd-test .

# Run container
docker run --rm cmd-test

# Inspect final CMD
docker image inspect cmd-test \
  --format '{{json .Config.Cmd}}'
```

Real-Time Scenario: If a developer defines two CMD instructions expecting both applications to start, only the last one runs. We correct the Dockerfile startup configuration.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.docker.com\&sz=32)

Docker Docs



### Q6. What happens if multiple ENTRYPOINT instructions are used in a Dockerfile?

Interview Answer:

Only the last `ENTRYPOINT` instruction takes effect in a Dockerfile stage.

Earlier ENTRYPOINT instructions are ignored.

Example Dockerfile:

```
FROM alpine:3.20

ENTRYPOINT ["echo", "First ENTRYPOINT"]

ENTRYPOINT ["echo", "Second ENTRYPOINT"]
```

Expected Output:

```
Second ENTRYPOINT
```

Practical Commands:

```
docker build -t entrypoint-test .

docker run --rm entrypoint-test

# Inspect actual ENTRYPOINT
docker image inspect entrypoint-test \
  --format '{{json .Config.Entrypoint}}'
```

Real-Time Scenario: If multiple ENTRYPOINT instructions are present, the last one determines the startup executable. Docker may also report a build-check warning for duplicate instructions.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.docker.com\&sz=32)

Docker Docs



### Q7. What happens if CMD and ENTRYPOINT are both used in a Dockerfile?

Interview Answer:

`ENTRYPOINT` defines the main executable.

`CMD` provides default arguments to that executable when the exec form is used.

Both can work together.

Example Dockerfile:

```
FROM alpine:3.20

ENTRYPOINT ["echo"]

CMD ["Hello from Docker"]
```

Practical Commands:

```
# Build image
docker build -t command-test .

# Run with default CMD
docker run --rm command-test

# Override CMD arguments
docker run --rm command-test "Hello from Production"
```

Output:

```
Hello from Docker

Hello from Production
```

Real-Time Scenario: We use ENTRYPOINT to execute the main application and CMD to provide default arguments that can be overridden during container startup.

Follow-Up: How do you override ENTRYPOINT?

```
docker run --rm \
  --entrypoint /bin/sh \
  command-test \
  -c 'echo Debugging'
```

Important: Prefer exec-form `ENTRYPOINT` and `CMD` for predictable argument handling and signal delivery. Shell-form ENTRYPOINT behaves differently and does not automatically append CMD arguments.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.docker.com\&sz=32)

Docker Docs



### Q8. What is the difference between RUN, CMD, and ENTRYPOINT?

Interview Answer:

- RUN: Executes commands while building the Docker image.
- CMD: Defines the default startup command or arguments.
- ENTRYPOINT: Defines the main executable when the container starts.

Example Dockerfile:

```
FROM python:3.13-slim

WORKDIR /app

RUN pip install flask

COPY app.py .

ENTRYPOINT ["python"]

CMD ["app.py"]
```

Execution Flow:

```
Docker Build
     |
     v
RUN pip install flask
     |
     v
Docker Image Created
     |
     v
Docker Container Starts
     |
     v
python app.py
```

Practical Commands:

```
docker build -t python-app .

docker run -d --name python-api python-app

docker inspect python-api \
  --format '{{json .Config.Entrypoint}} {{json .Config.Cmd}}'
```

Real-Time Scenario: Dependencies are installed during image building, while the Python application executes when the container starts.

### Q9. What if we need to execute multiple commands when a Docker container starts?

Interview Answer:

We should not use multiple CMD or ENTRYPOINT instructions.

Instead, we can use a startup script that executes the required commands.

The final application process should use `exec` so it receives shutdown signals correctly.

Example `entrypoint.sh`:

```
#!/bin/sh
set -e

echo "Checking startup configuration"

# Perform required initialization
python init.py

# Start main application
exec python app.py
```

Dockerfile:

```
FROM python:3.13-slim

WORKDIR /app

COPY . .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
```

Production Commands:

```
docker build -t payment-service:v1 .

docker run -d \
  --name payment-api \
  payment-service:v1

docker logs payment-api
```

Real-Time Scenario: A container needs to validate startup configuration before launching the application. We use a startup script rather than multiple CMD instructions.

Important: This pattern is for sequential initialization followed by one main process. For independent services, use separate containers.

### Q10. How do you reduce Docker image size?

Interview Answer:

We use multi-stage Docker builds, smaller base images, `.dockerignore`, and remove unnecessary build dependencies.

We also avoid copying unnecessary files and use `--no-cache-dir` for Python package installation.

Example Multi-Stage Dockerfile:

```
# Build stage
FROM golang:1.25-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o payment-api .

# Runtime stage
FROM alpine:3.22

WORKDIR /app

COPY --from=builder /app/payment-api .

CMD ["./payment-api"]
```

Production Commands:

```
# Build image
docker build -t payment-service:v2 .

# Check image sizes
docker images

# Check image layers
docker history payment-service:v2

# Inspect image
docker image inspect payment-service:v2
```

Real-Time Scenario: A Go application image contains build tools and source files. Using multi-stage builds, we keep only the compiled application and required runtime files in the final image.

Follow-Up: Why is a smaller image useful?

Answer: Smaller images normally take less time to transfer, use less registry storage, and can reduce the number of unnecessary packages that need security maintenance.

### Q11. A Docker container suddenly crashes in production. How do you troubleshoot it?

Interview Answer:

First, I check the container status and exit code. Then I check container logs, memory usage, Docker events, and restart history.

I identify whether the issue happened because of an application error, OOMKilled, configuration problem, or host resource issue.

Production Commands:

```
# Check all containers, including stopped
docker ps -a

# Check container logs
docker logs --tail 200 payment-api

# Check exit code
docker inspect payment-api \
  --format '{{.State.ExitCode}}'

# Check OOMKilled status
docker inspect payment-api \
  --format '{{.State.OOMKilled}}'

# Check container state
docker inspect payment-api \
  --format '{{json .State}}'

# Check Docker events
docker events --since 1h \
  --filter container=payment-api
```

Real-Time Scenario: Payment Service crashes after a new deployment. I find exit code 1 and an application configuration error in the logs. We fix the configuration and redeploy the application.

Follow-Up: Can you use `docker exec` on a stopped container?

Answer: No. `docker exec` requires a running container. For a stopped container, I check logs, inspect data, and the image configuration.

### Q12. A Docker container crashed. How do you check how much CPU and memory it was using before the crash?

Interview Answer:

For running containers, I use `docker stats` to check CPU and memory usage.

If the container already crashed, Docker stats cannot show its previous CPU usage.

To find historical resource usage, I check Prometheus, Grafana, cAdvisor, or another monitoring system that collected container metrics before the crash.

Production Commands:

```
# Check live CPU and memory usage
docker stats payment-api

# Get one-time resource usage
docker stats --no-stream payment-api

# Check exit code and OOM status
docker inspect payment-api \
  --format 'ExitCode={{.State.ExitCode}} OOM={{.State.OOMKilled}}'

# Check crash time
docker inspect payment-api \
  --format '{{.State.FinishedAt}}'

# Check logs before crash
docker logs --timestamps \
  --tail 200 payment-api
```

Example Live Output:

```
CONTAINER     CPU %    MEM USAGE / LIMIT
payment-api   95.2%    850MiB / 1GiB
```

Check historical CPU in Prometheus:

```
rate(container_cpu_usage_seconds_total[5m])
```

Filter this metric by the appropriate container labels in your monitoring environment. Multiply by 100 to express CPU cores used as a percentage of one CPU core.

Check historical memory:

```
container_memory_working_set_bytes
```

Real-Time Scenario: A container crashes at 3 PM. I open Grafana and check its CPU and memory graphs before 3 PM. If memory increased continuously before the crash, I investigate a possible memory leak or memory-limit issue.

Important Interview Point: `docker stats` only returns resource measurements for running containers. Docker does not automatically retain historical CPU measurements after a container exits.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.docker.com\&sz=32)

Docker Docs

+1



### Q13. A Docker container shows exit code 137. What does it mean?

Interview Answer:

Exit code 137 means the process was killed using SIGKILL.

A common reason is an out-of-memory condition, but it can also happen if someone forcefully kills the container.

I check the OOMKilled status, Docker events, memory limits, and monitoring dashboards.

Production Commands:

```
# Check exit code
docker inspect payment-api \
  --format '{{.State.ExitCode}}'

# Check OOMKilled
docker inspect payment-api \
  --format '{{.State.OOMKilled}}'

# Check configured memory limit
docker inspect payment-api \
  --format '{{.HostConfig.Memory}}'

# Check previous logs
docker logs --tail 100 payment-api
```

Real-Time Scenario: The container has a 1 GiB memory limit and is killed during peak traffic. Monitoring confirms high memory usage before the failure.

I investigate memory leaks and workload demand before changing memory limits.

Follow-Up: Difference between exit codes 137 and 143?

Answer:

- 137: SIGKILL, often associated with OOM or forced termination.
- 143: SIGTERM, normally associated with a graceful shutdown request.

An exit code alone is not enough to confirm the root cause.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.docker.com\&sz=32)

Docker Docs



### Q14. A Docker container is consuming 100% CPU. How do you troubleshoot?

Interview Answer:

First, I check CPU usage using `docker stats`.

Then I inspect running processes, application logs, request traffic, and resource limits.

I identify whether high CPU is caused by heavy traffic, inefficient code, background processing, or CPU throttling.

Production Commands:

```
# Check CPU usage
docker stats payment-api

# Check processes
docker top payment-api

# Check application logs
docker logs --tail 100 payment-api

# Check CPU limits
docker inspect payment-api \
  --format '{{.HostConfig.NanoCpus}}'

# Check host CPU usage
top
```

Real-Time Scenario: CPU usage increases because Payment Service receives more requests.

I check Grafana metrics, CPU limits, and application latency. If required, we scale application replicas or optimize the application.

Follow-Up: How do you limit Docker CPU usage?

```
# Example: Limit a test container to 1 CPU
docker run -d \
  --cpus="1.0" \
  --name test-api \
  payment-service:v1
```

For production, CPU settings should be managed through the approved deployment configuration.

### Q15. How do you automatically restart a Docker container after it crashes?

Interview Answer:

Docker supports restart policies to restart containers after failures.

Common policies are `no`, `on-failure`, `always`, and `unless-stopped`.

Production Commands:

```
# Restart only after failure
docker run -d \
  --restart on-failure:3 \
  --name payment-api \
  payment-service:v1

# Restart unless manually stopped
docker run -d \
  --restart unless-stopped \
  --name payment-api \
  payment-service:v1

# Check restart policy
docker inspect payment-api \
  --format '{{json .HostConfig.RestartPolicy}}'

# Check restart count
docker inspect payment-api \
  --format '{{.RestartCount}}'
```

Real-Time Scenario: A standalone container crashes because of a temporary application error. Docker restarts it according to the configured policy.

Important: A restart policy helps with recovery but does not fix the actual reason for repeated crashes.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.docker.com\&sz=32)

Docker Docs



### Q16. A Docker container is running, but the application is not accessible. What will you check?

Interview Answer:

I check container status, application logs, port mapping, network configuration, and whether the application is listening on the correct interface.

Production Commands:

```
# Check container
docker ps

# Check port mapping
docker port payment-api

# Inspect network settings
docker inspect payment-api \
  --format '{{json .NetworkSettings.Ports}}'

# Test application
curl -v http://localhost:8080

# Check logs
docker logs payment-api
```

Real-Time Scenario: The Docker container is running, but port 8080 is not accessible because the application listens only on `127.0.0.1` inside the container.

We configure it to listen on the correct interface and verify the published port.

### Q17. What is the difference between Docker volumes and bind mounts?

Interview Answer:

A Docker volume is managed by Docker and is commonly used for persistent container data.

A bind mount maps a specific host directory or file into a container.

Production Commands:

```
# Create volume
docker volume create payment-data

# Run container with volume
docker run -d \
  -v payment-data:/app/data \
  --name payment-api \
  payment-service:v1

# List volumes
docker volume ls

# Inspect volume
docker volume inspect payment-data

# Inspect mounts
docker inspect payment-api \
  --format '{{json .Mounts}}'
```

Real-Time Scenario: A container is recreated, but the application data remains available because it is stored in a persistent Docker volume.

Follow-Up: Will deleting a container delete its named volume?

Answer: Normally no. Named volumes remain until explicitly removed.

### Q18. Docker builds successfully, but the container immediately exits. What will you do?

Interview Answer:

I check the container exit code, logs, Dockerfile CMD and ENTRYPOINT, and required environment variables.

A container stops when its main process exits, so I verify that the expected long-running application actually starts.

Production Commands:

```
# Check stopped containers
docker ps -a

# Check logs
docker logs payment-api

# Check exit code
docker inspect payment-api \
  --format '{{.State.ExitCode}}'

# Check startup configuration
docker image inspect payment-service:v1 \
  --format '{{json .Config.Entrypoint}} {{json .Config.Cmd}}'
```

Real-Time Scenario: The Dockerfile uses:

```
CMD ["echo", "Application Started"]
```

The container prints the message and exits successfully because there is no long-running process.

We replace CMD with the correct application startup command.

### Q19. How do you troubleshoot Docker disk-space issues in production?

Interview Answer:

I check Docker disk usage, unused images, stopped containers, volumes, and container logs.

Before deleting anything, I identify which resources are safe to remove.

Production Commands:

```
# Check host disk space
df -h

# Check Docker disk usage
docker system df

# Check detailed usage
docker system df -v

# List all containers
docker ps -a

# Check images
docker images

# Check volumes
docker volume ls
```

Real-Time Scenario: The Jenkins build agent runs out of disk space because old Docker images accumulate.

We clean up unused build resources according to the organization's retention policy.

Important: Avoid running `docker system prune -a --volumes` blindly in production because it can remove important unused images, containers, or data volumes.

### Q20. How do you secure Docker containers in production?

Interview Answer:

We use trusted and updated base images, run containers as non-root users, scan images for vulnerabilities, and avoid privileged mode.

We also restrict container resources and use secure secret management.

Example Dockerfile:

```
FROM python:3.13-slim

WORKDIR /app

RUN useradd -r -u 10001 appuser

COPY --chown=appuser:appuser . .

USER appuser

CMD ["python", "app.py"]
```

Production Commands:

```
# Scan image
trivy image payment-service:v1

# Check image layers
docker history payment-service:v1

# Check runtime user
docker inspect payment-api \
  --format '{{.Config.User}}'

# Check container privileges
docker inspect payment-api \
  --format '{{.HostConfig.Privileged}}'
```

Real-Time Scenario: Jenkins discovers a critical vulnerability in the application image. We update the affected dependency or base image, rebuild, scan, and deploy the corrected image after validation.

## Bonus: Additional Second-Round Docker Interview Questions

| Interview Question                                        | Short Answer                                                                                           |
| --------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| What happens if multiple CMD instructions exist?          | Only the last CMD takes effect.                                                                        |
| What happens if multiple ENTRYPOINT instructions exist?   | Only the last ENTRYPOINT takes effect.                                                                 |
| Can CMD override ENTRYPOINT?                              | CMD normally provides arguments to an exec-form ENTRYPOINT; it does not replace it.                    |
| How do you override CMD?                                  | `docker run image <new-command>`                                                                       |
| How do you override ENTRYPOINT?                           | `docker run --entrypoint <command> image`                                                              |
| What is PID 1 in Docker?                                  | The first process in the container, responsible for important signal-handling behavior.                |
| Why use exec-form ENTRYPOINT?                             | Better argument handling and direct signal delivery.                                                   |
| What happens when the main process exits?                 | The container stops unless restarted by a policy or orchestrator.                                      |
| What does `docker stats` show?                            | Live CPU, memory, network, and I/O metrics.                                                            |
| Can `docker stats` show CPU usage before a crash?         | No. Use previously collected monitoring metrics.                                                       |
| What does OOMKilled mean?                                 | The container was killed because of an out-of-memory condition.                                        |
| Can exit code 137 happen without OOM?                     | Yes, such as when a process receives SIGKILL.                                                          |
| What is Docker healthcheck?                               | A command used to assess container health.                                                             |
| Does an unhealthy Docker container automatically restart? | Not in standalone Docker simply because of HEALTHCHECK failure.                                        |
| What is `.dockerignore`?                                  | Excludes unnecessary files from the Docker build context.                                              |
| What is Docker image caching?                             | Reusing unchanged build layers to speed up builds.                                                     |
| Difference between `COPY` and `ADD`?                      | COPY copies files; ADD has extra capabilities, including supported archive extraction and URL sources. |
| What is Docker networking?                                | Communication between containers, hosts, and external networks.                                        |
| What is the difference between `EXPOSE` and `-p`?         | EXPOSE documents the container port; `-p` publishes it on the host.                                    |
| What is Docker Compose?                                   | A tool for defining and running multi-container applications.                                          |

## Last-Minute Docker Commands

```
# List containers
docker ps
docker ps -a

# Check container logs
docker logs --tail 100 payment-api

# Check previous exit code
docker inspect payment-api \
  --format '{{.State.ExitCode}}'

# Check OOMKilled
docker inspect payment-api \
  --format '{{.State.OOMKilled}}'

# Check live CPU and memory
docker stats payment-api

# Check running processes
docker top payment-api

# Check container restart count
docker inspect payment-api \
  --format '{{.RestartCount}}'

# Check container startup command
docker inspect payment-api \
  --format '{{json .Config.Cmd}}'

# Check ENTRYPOINT
docker inspect payment-api \
  --format '{{json .Config.Entrypoint}}'

# Check port mapping
docker port payment-api

# Check disk usage
docker system df

# Build image
docker build -t payment-service:v1 .

# Run container
docker run -d \
  --name payment-api \
  -p 8080:8080 \
  payment-service:v1
```

## Most Important Docker Production Scenario for Your Interview

Interviewer: Your Docker container crashed suddenly. How will you identify the cause and check how much CPU or memory it consumed before crashing?

Suggested Interview Answer:

> First, I check the container status using `docker ps -a`.
>
> Then I check the container logs using `docker logs` and inspect its exit code and OOMKilled status using `docker inspect`.
>
> If the container is running, I use `docker stats` to check CPU and memory usage.
>
> If it has already crashed, I check historical CPU and memory metrics in Prometheus and Grafana.
>
> Based on the logs and metrics, I identify whether the issue is caused by a memory leak, high CPU usage, application error, or configuration issue.
>
> After fixing the root cause, I restart or redeploy the container and monitor its health.

End of Section 3 – Docker

Covered: 20 detailed questions + 20 additional interview questions, including all three questions shared by   HR and your requested multiple CMD/ENTRYPOINT and container crash scenarios.

Next Section 4: Jenkins and CI/CD – Multibranch Pipelines, Jenkinsfile, Webhooks, Microservices Deployment, Pipeline Failures, Agent Issues, Parallel Builds, Rollback, Blue-Green/Canary Deployment, Performance and Monitoring.

# X Company – SRE Interview Preparation

## Section 4: Azure DevOps

### Subtopic 4.1: Azure DevOps CI/CD, Self-Hosted Agents, EKS/AKS Integration and Production Troubleshooting

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: CI/CD pipelines, YAML, self-hosted agents, Azure service connections, AWS EKS, Azure AKS, Docker, deployments, rollback, security, and real-time SRE incidents.

### Example Production Environment

```
CI/CD          : Azure DevOps Pipelines
Source Code    : Azure Repos / GitHub
Cloud          : AWS + Azure
Kubernetes     : EKS / AKS
Agent          : Self-Hosted Linux
Container      : Docker
Registry       : AWS ECR / Azure ACR
Infrastructure : Terraform
Monitoring     : Prometheus + Grafana
```

### Q1. What is Azure DevOps, and how do you use it for CI/CD?

Interview Answer:

Azure DevOps provides services like Azure Repos, Pipelines, Boards, Artifacts, and Test Plans.

We use Azure Pipelines to automate application builds, testing, Docker image creation, security scanning, and deployments to EKS or AKS.

Production Pipeline Flow:

```
Developer Pushes Code
         |
         v
Azure Repos / GitHub
         |
         v
Azure DevOps Pipeline
         |
         |-- Code Checkout
         |-- Build
         |-- Unit Testing
         |-- SonarQube Scan
         |-- Docker Build
         |-- Image Security Scan
         |-- Push to ECR / ACR
         |
         v
Approval / GitOps Update
         |
         v
EKS / AKS Deployment
         |
         v
Production Verification
```

Example `azure-pipelines.yml`:

```
trigger:
  - main

pool:
  name: SelfHosted-Linux

steps:
  - checkout: self

  - script: |
      echo "Building application"
      docker build -t payment-service:$(Build.BuildId) .
    displayName: Build Docker Image

  - script: |
      echo "Running application tests"
      pytest tests/
    displayName: Run Tests
```

Real-Time Scenario: When developers push code to the main branch, Azure DevOps triggers the CI pipeline, builds the application, runs tests, and prepares the Docker image.

### Q2. What is the difference between Microsoft-hosted and self-hosted agents?

Interview Answer:

Microsoft-hosted agents are managed by Microsoft. They provide temporary build environments.

Self-hosted agents are installed and maintained by our organization on VMs or servers.

We prefer self-hosted agents when we need private network access, custom tools, or more control over the build environment.

| Microsoft-hosted                     | Self-hosted                               |
| ------------------------------------ | ----------------------------------------- |
| Managed by Microsoft                 | Managed by organization                   |
| Fresh environment for jobs           | Tools and caches can persist              |
| Limited machine customization        | Full control over installed tools         |
| No automatic private VPC/VNet access | Can access private networks if configured |
| Less maintenance                     | Requires patching and monitoring          |

Real-Time Scenario: Our EKS cluster has a private API endpoint. We run a self-hosted agent on an EC2 instance inside an authorized VPC network so it can access the cluster.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q3. How do you configure a self-hosted agent in Azure DevOps from scratch?

Interview Answer:

First, we prepare a Linux VM or EC2 instance.

Then we install the required build tools and Azure Pipelines agent.

We register it with the Azure DevOps organization and agent pool, configure it as a service, and verify that it is Online.

### Practical Production Steps

Step 1: Create a Linux VM.

For example:

```
OS          : Ubuntu Linux
Compute     : Azure VM / AWS EC2
Agent Pool  : SelfHosted-Linux
Agent Name  : prod-agent-01
Connectivity: Azure DevOps over HTTPS
Tools       : Git, Docker, kubectl, Helm, Terraform
```

Step 2: Install basic dependencies.

```
sudo apt-get update

sudo apt-get install -y \
  curl git jq unzip ca-certificates
```

Install Docker, kubectl, Helm, Terraform, and the required cloud CLIs using approved packages.

Step 3: Create the agent pool in Azure DevOps.

Navigate to:

```
Azure DevOps Organization
   |
   v
Organization Settings
   |
   v
Agent Pools
   |
   v
Add Pool
   |
   v
SelfHosted-Linux
```

Step 4: Download the agent.

Open:

```
Agent Pools
   |
   v
SelfHosted-Linux
   |
   v
New Agent
   |
   v
Linux
```

Download the current supported Linux agent package using the link provided by Azure DevOps.

On the VM, as a dedicated non-root agent user:

```
mkdir -p ~/myagent
cd ~/myagent

# Download the approved agent archive here

tar zxvf <agent-package>.tar.gz
```

Step 5: Register the agent.

```
./config.sh
```

Enter the requested details:

```
Server URL:
https://dev.azure.com/<organization>

Authentication:
PAT / Supported Registration Method

Agent Pool:
SelfHosted-Linux

Agent Name:
prod-agent-01

Work Folder:
_work
```

The account registering the agent must have agent-pool administration permission. If PAT authentication is used, use a short-lived token with the required Agent Pools permissions.

Step 6: Configure the agent as a Linux service.

```
# Install the systemd service
sudo ./svc.sh install

# Start the agent
sudo ./svc.sh start

# Check status
sudo ./svc.sh status
```

Step 7: Verify in Azure DevOps.

```
Organization Settings
   |
   v
Agent Pools
   |
   v
SelfHosted-Linux
   |
   v
Agents
   |
   v
prod-agent-01 : Online
```

Step 8: Configure the YAML pipeline to use the agent.

```
pool:
  name: SelfHosted-Linux

steps:
  - script: |
      hostname
      whoami
      docker --version
      kubectl version --client
    displayName: Verify Self-Hosted Agent
```

Real-Time Scenario: We configure a self-hosted EC2 agent to execute Azure DevOps deployments to a private EKS cluster. We install Docker, AWS CLI, kubectl, Helm, and Terraform, register the agent, and verify the connection.

Important: The agent generally initiates outbound HTTPS connections to Azure DevOps. Azure DevOps does not normally need inbound SSH access to execute its jobs.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q4. How do you troubleshoot an Azure DevOps self-hosted agent that is Offline?

Interview Answer:

First, I check whether the agent service is running.

Then I verify Azure DevOps connectivity, DNS, firewall rules, disk space, and agent logs.

I restart the service if necessary and verify that the agent becomes Online.

Production Commands:

```
# Go to agent installation directory
cd ~/myagent

# Check agent status
sudo ./svc.sh status

# Restart the agent
sudo ./svc.sh stop
sudo ./svc.sh start

# Check diagnostic logs
ls -ltr _diag/

# Check disk space
df -h

# Check memory
free -h

# Check Azure DevOps connectivity
curl -I https://dev.azure.com
```

Real-Time Scenario: The self-hosted agent goes Offline because the VM disk is full and the service cannot run properly.

We identify unnecessary build artifacts, clean them up safely, restart the agent, and verify its Online status.

Follow-Up: Where are Azure DevOps agent logs stored?

Answer: The agent diagnostic logs are normally available in the `_diag` directory under the agent installation folder.

### Q5. How does an Azure DevOps self-hosted agent connect to AWS EKS?

Interview Answer:

We can install a self-hosted Azure DevOps agent on AWS EC2 and attach an IAM role with required permissions.

We install AWS CLI and kubectl on the agent.

During the pipeline, we use AWS CLI to configure EKS access and use kubectl or Helm to deploy applications.

The IAM role must also have the required EKS Kubernetes access permissions.

### Production Architecture

```
Azure DevOps Pipeline
         |
         v
Self-Hosted Agent on EC2
         |
         | IAM Role Credentials
         v
AWS EKS Authentication
         |
         | AWS CLI + kubectl
         v
EKS Kubernetes API
         |
         v
Payment Service Deployment
```

### Practical Configuration

Step 1: Install tools on the agent.

```
aws --version

kubectl version --client

helm version

docker --version
```

Step 2: Verify AWS IAM role.

On the EC2 agent:

```
aws sts get-caller-identity
```

Step 3: Configure EKS access.

```
aws eks update-kubeconfig \
  --region ap-south-1 \
  --name prod-eks
```

Step 4: Verify Kubernetes access.

```
kubectl get nodes

kubectl get pods -n production

kubectl auth can-i get deployments \
  -n production
```

Step 5: Deploy an application after approval.

```
kubectl apply \
  -f k8s/deployment.yaml \
  -n production

kubectl rollout status \
  deployment/payment-service \
  -n production
```

In production, use dedicated per-job kubeconfig files rather than sharing a mutable kubeconfig across concurrent pipeline jobs.

Real-Time Scenario: Azure DevOps runs a deployment job on an EC2 self-hosted agent. The agent uses its assigned AWS IAM role to authenticate with EKS and deploys Payment Service using kubectl or Helm.

Important: IAM permissions to call `eks:DescribeCluster` are not sufficient by themselves. The role also needs Kubernetes authorization through EKS access entries or the cluster's configured authentication/RBAC mechanism.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS

+1



### Q6. How do you configure AWS IAM permissions for Azure DevOps to access EKS?

Interview Answer:

First, we attach a least-privileged IAM role to the EC2 self-hosted agent or use another approved AWS authentication method.

Then we configure an EKS access entry for that IAM role and grant the required Kubernetes permissions.

Production Commands:

```
# Check pipeline agent identity
aws sts get-caller-identity

# Check EKS authentication mode
aws eks describe-cluster \
  --name prod-eks \
  --query 'cluster.accessConfig'

# List cluster access entries
aws eks list-access-entries \
  --cluster-name prod-eks
```

Example authorized administrator commands:

```
# Create EKS access entry
aws eks create-access-entry \
  --cluster-name prod-eks \
  --principal-arn <pipeline-iam-role-arn>

# Give namespace-scoped edit permissions
aws eks associate-access-policy \
  --cluster-name prod-eks \
  --principal-arn <pipeline-iam-role-arn> \
  --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSEditPolicy \
  --access-scope type=namespace,namespaces=production
```

The role also needs the relevant AWS IAM permissions. Prefer more restrictive custom Kubernetes RBAC when the built-in edit policy is broader than required.

Real-Time Scenario: The pipeline agent can call AWS APIs, but `kubectl` returns Forbidden. We check EKS access entries and Kubernetes permissions to identify the missing authorization.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



### Q7. How do you deploy an application to EKS using Azure DevOps YAML?

Interview Answer:

We use a self-hosted agent with AWS CLI, Docker, and kubectl installed.

The pipeline authenticates using an approved IAM role, connects to EKS, applies the Kubernetes configuration, and verifies the rollout.

Example `azure-pipelines.yml`:

```
trigger:
  - main

pool:
  name: SelfHosted-Linux

stages:
  - stage: Deploy_EKS
    displayName: Deploy to AWS EKS
    jobs:
      - job: Deploy
        steps:
          - checkout: self

          - bash: |
              set -euo pipefail

              export KUBECONFIG="$(Agent.TempDirectory)/eks-kubeconfig"

              aws sts get-caller-identity

              aws eks update-kubeconfig \
                --region ap-south-1 \
                --name prod-eks \
                --kubeconfig "$KUBECONFIG"

              kubectl get nodes

              kubectl apply \
                -f k8s/deployment.yaml \
                -n production

              kubectl rollout status \
                deployment/payment-service \
                -n production \
                --timeout=300s
            displayName: Deploy Application to EKS
```

Production Steps:

```
Azure DevOps
    |
    v
Self-Hosted EC2 Agent
    |
    v
AWS IAM Authentication
    |
    v
EKS Cluster Connection
    |
    v
kubectl apply
    |
    v
Deployment Verification
```

Real-Time Scenario: Developers merge approved code changes. Azure DevOps deploys the validated Kubernetes configuration to EKS using the self-hosted agent.

Important: This is a deployment-stage example. In production, build and scan the image first, pin an immutable image version, protect the production environment with approvals, and avoid deploying unreviewed manifests directly.

### Q8. How does Azure DevOps connect to an Azure AKS cluster?

Interview Answer:

We normally create an Azure Resource Manager service connection in Azure DevOps.

It authenticates Azure DevOps with Azure using a service principal or workload identity federation.

Then the pipeline uses Azure CLI or Kubernetes tasks to access AKS and deploy applications.

Recommended: Workload Identity Federation, which avoids storing a long-lived Azure client secret.

### Practical Configuration

Step 1: Create an Azure Resource Manager service connection.

Navigate to:

```
Azure DevOps Project
        |
        v
Project Settings
        |
        v
Service Connections
        |
        v
New Service Connection
        |
        v
Azure Resource Manager
        |
        v
Workload Identity Federation
        |
        v
Select Subscription / Scope
        |
        v
Name: azure-prod-connection
```

Step 2: Grant appropriate access.

The service connection's identity requires the necessary Azure permissions for AKS authentication and Kubernetes deployment.

Step 3: Configure AKS deployment YAML.

```
trigger:
  - main

pool:
  name: SelfHosted-Linux

steps:
  - task: KubernetesManifest@1
    displayName: Deploy to AKS
    inputs:
      action: deploy
      connectionType: azureResourceManager
      azureSubscriptionConnection: azure-prod-connection
      azureResourceGroup: prod-rg
      kubernetesCluster: prod-aks
      namespace: production
      manifests: |
        k8s/deployment.yaml
        k8s/service.yaml
```

Step 4: Verify deployment from an authorized terminal.

```
az aks get-credentials \
  --resource-group prod-rg \
  --name prod-aks

kubectl get pods -n production

kubectl rollout status \
  deployment/payment-service \
  -n production
```

Real-Time Scenario: Azure DevOps uses the Azure Resource Manager service connection and a self-hosted agent to deploy Payment Service to AKS. The deployment identity is granted appropriate access to the Production namespace.

Important: For private AKS, the self-hosted agent must have network connectivity to the cluster's private API endpoint. A service connection alone does not provide network access.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

+1



### Q9. What is the difference between Azure DevOps connecting to EKS and AKS?

Interview Answer:

For EKS, Azure DevOps normally uses an AWS IAM identity to authenticate with AWS and access the Kubernetes cluster.

For AKS, Azure DevOps commonly uses an Azure Resource Manager service connection with Microsoft Entra authentication.

Both require appropriate Kubernetes permissions and network access.

| Feature                  | AWS EKS                              | Azure AKS                           |
| ------------------------ | ------------------------------------ | ----------------------------------- |
| Cloud Identity           | AWS IAM                              | Microsoft Entra / Azure identity    |
| Cluster CLI              | AWS CLI + kubectl                    | Azure CLI + kubectl                 |
| Preferred agent location | AWS VPC for private EKS              | Azure VNet for private AKS          |
| Container Registry       | ECR                                  | ACR                                 |
| Pipeline authentication  | IAM role or approved AWS credentials | ARM service connection              |
| Deployment               | kubectl / Helm / Argo CD             | KubernetesManifest / kubectl / Helm |

Real-Time Scenario: For EKS, our EC2 self-hosted agent accesses the cluster through AWS IAM. For AKS, an Azure VM self-hosted agent accesses the cluster through the approved Azure service connection.

### Q10. How do you build a Docker image and push it to AWS ECR using Azure DevOps?

Interview Answer:

Azure DevOps builds the Docker image using a pipeline.

The agent authenticates with AWS using its IAM role, logs in to ECR, tags the image, and pushes it.

Afterward, the image version is deployed to EKS or updated in the GitOps repository.

Production YAML Example:

```
pool:
  name: SelfHosted-Linux

steps:
  - checkout: self

  - bash: |
      set -euo pipefail

      REGION="ap-south-1"
      ACCOUNT_ID=$(aws sts get-caller-identity \
        --query Account --output text)

      ECR="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com"
      IMAGE="$ECR/payment-service:$(Build.BuildId)"

      aws ecr get-login-password --region "$REGION" \
        | docker login --username AWS \
          --password-stdin "$ECR"

      docker build -t "$IMAGE" .

      docker push "$IMAGE"
    displayName: Build and Push Docker Image to ECR
```

Production Commands:

```
# Check repository
aws ecr describe-repositories \
  --repository-names payment-service

# Check pushed images
aws ecr describe-images \
  --repository-name payment-service
```

Real-Time Scenario: Azure DevOps builds image version `105`, scans it, pushes it to ECR, and deploys the approved image to EKS.

Important: The ECR repository must already exist. The agent IAM role must have appropriate ECR push permissions.

### Q11. How do you build and push a Docker image to Azure ACR using Azure DevOps?

Interview Answer:

We create a Docker Registry service connection for ACR.

Azure DevOps uses the Docker task to build the image and push it to the registry.

AKS then pulls the approved image from ACR.

Production YAML:

```
pool:
  name: SelfHosted-Linux

steps:
  - task: Docker@2
    displayName: Build and Push to ACR
    inputs:
      command: buildAndPush
      containerRegistry: acr-prod-connection
      repository: payment-service
      Dockerfile: '**/Dockerfile'
      tags: |
        $(Build.BuildId)
```

Production Commands:

```
# Check ACR repositories
az acr repository list \
  --name companyacr \
  -o table

# Check image tags
az acr repository show-tags \
  --name companyacr \
  --repository payment-service \
  -o table
```

Real-Time Scenario: Azure DevOps builds Payment Service and pushes a versioned Docker image into ACR. The approved image is later deployed to AKS.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q12. What is a Service Connection in Azure DevOps?

Interview Answer:

A Service Connection securely connects Azure DevOps pipelines to external services such as Azure, AWS, Docker registries, and Kubernetes.

It allows pipelines to authenticate without hardcoding passwords in YAML files.

Production Configuration:

```
Azure DevOps
    |
    v
Project Settings
    |
    v
Service Connections
    |
    +-- Azure Resource Manager
    +-- Docker Registry
    +-- Kubernetes
    +-- AWS (with AWS Toolkit)
```

Real-Time Scenario: We use an Azure Resource Manager service connection for AKS and an AWS IAM role on an EC2 self-hosted agent for EKS.

Follow-Up: Does AWS Toolkit support AWS service connections?

Answer: Yes. The AWS Toolkit for Azure DevOps provides AWS service connections and tasks. Its documented service connection uses AWS credentials and can support AssumeRole. For EC2 agents, IAM instance roles help avoid storing long-lived access keys.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

AWS Toolkit for Microsoft Azure DevOps



### Q13. How do you deploy to a private EKS or AKS cluster from Azure DevOps?

Interview Answer:

We configure a self-hosted agent with private network connectivity to the Kubernetes cluster.

For EKS, we can deploy the agent inside an AWS VPC. For AKS, we can use an agent inside an Azure VNet.

We also configure cloud authentication and Kubernetes permissions.

Production Commands:

```
# Check Kubernetes API connectivity
kubectl cluster-info

# Check cluster authorization
kubectl auth can-i get pods -n production

# Check DNS
nslookup <private-cluster-endpoint>

# Test network connectivity
curl -vk --connect-timeout 5 \
  https://<private-cluster-endpoint>/readyz
```

The curl command is a network diagnostic only; a successful Kubernetes health response may require authentication. Do not disable TLS validation for normal deployment operations.

Real-Time Scenario: Azure DevOps pipelines fail to reach a private AKS cluster from Microsoft-hosted agents. We use a self-hosted agent in an authorized VNet with private DNS and routing configured.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q14. Azure DevOps pipeline receives Unauthorized or Forbidden when accessing EKS/AKS. How do you troubleshoot?

Interview Answer:

First, I check whether the pipeline has valid authentication.

Then I verify its cloud identity, Kubernetes RBAC permissions, service connection, and cluster access.

EKS Commands:

```
aws sts get-caller-identity

aws eks list-access-entries \
  --cluster-name prod-eks

kubectl auth can-i create deployments \
  -n production
```

AKS Commands:

```
az account show

az aks show \
  -g prod-rg \
  -n prod-aks

kubectl auth can-i create deployments \
  -n production
```

Real-Time Scenario: Azure DevOps successfully authenticates to Azure but cannot deploy to AKS because its identity lacks Kubernetes deployment permissions. We correct the required authorization.

### Q15. Azure DevOps pipeline is stuck in Queued status. What will you do?

Interview Answer:

I check whether the self-hosted agent is Online, whether it is busy running another job, and whether the pipeline is using the correct agent pool.

I also verify agent capabilities, demands, and available parallel-job capacity.

Production Commands:

```
# Agent service status
cd ~/myagent
sudo ./svc.sh status

# Check CPU and memory
top
free -h

# Check agent logs
ls -ltr _diag/

# Check disk
df -h
```

Real-Time Scenario: The deployment is Queued because our only self-hosted agent is already running another build. We wait for capacity or use another approved agent in the pool.

### Q16. Self-hosted Azure DevOps agent is slow or consuming high CPU. How do you troubleshoot?

Interview Answer:

First, I check CPU, memory, disk usage, and running processes.

Then I check agent logs and identify which pipeline step is consuming resources.

If the agent lacks capacity, we optimize the job or scale the agent pool.

Production Commands:

```
# CPU and processes
top
ps aux --sort=-%cpu | head

# Memory
free -h

# Disk
df -h

# Docker build resource usage
docker stats --no-stream

# Agent logs
ls -ltr ~/myagent/_diag/
```

Real-Time Scenario: Multiple Docker builds cause high CPU usage on the agent VM. We investigate build concurrency, image caching, and whether separate build agents are required.

### Q17. How do you roll back a failed application deployment using Azure DevOps?

Interview Answer:

If a new application deployment fails, I identify the previous successful version using pipeline and deployment history.

Then I restore that approved image version through the pipeline or GitOps configuration.

Finally, I verify application health.

Production Commands:

```
# Check Kubernetes deployment history
kubectl rollout history \
  deployment/payment-service \
  -n production

# Kubernetes emergency rollback
kubectl rollout undo \
  deployment/payment-service \
  -n production

# Verify
kubectl rollout status \
  deployment/payment-service \
  -n production
```

Real-Time Scenario: Pipeline version 105 deploys a faulty image. We restore version 104 through the approved rollback process and verify that application errors return to normal.

Important: If Argo CD manages the Deployment, we should revert the image version in Git. Otherwise, Argo CD may restore the faulty version.

### Q18. How do you configure approval before Production deployment in Azure DevOps?

Interview Answer:

We configure approvals and checks on an Azure DevOps Environment.

The production deployment stage waits until an authorized person approves the deployment.

Configuration Steps:

```
Azure DevOps
    |
    v
Pipelines
    |
    v
Environments
    |
    v
production
    |
    v
Approvals and Checks
    |
    v
Add Approval
    |
    v
Select Approvers
```

Example YAML:

```
stages:
  - stage: Production
    jobs:
      - deployment: DeployProduction
        environment: production
        pool:
          name: SelfHosted-Linux
        strategy:
          runOnce:
            deploy:
              steps:
                - script: echo "Production deployment"
```

The actual approval is configured on the `production` environment in Azure DevOps, not merely by writing `environment: production` in YAML.

Real-Time Scenario: After successful QA testing, the Production stage waits for approval from the release manager before deployment.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q19. How do you manage Dev, QA, and Production pipelines in Azure DevOps?

Interview Answer:

We use multi-stage YAML pipelines with separate environments, variable groups, and service connections.

Dev deployments can be automated, while QA and Production may require approvals.

Example YAML:

```
stages:
  - stage: Dev
    jobs:
      - job: DeployDev
        pool:
          name: SelfHosted-Linux
        steps:
          - script: echo "Deploy to Dev"

  - stage: QA
    dependsOn: Dev
    jobs:
      - job: DeployQA
        pool:
          name: SelfHosted-Linux
        steps:
          - script: echo "Deploy to QA"

  - stage: Production
    dependsOn: QA
    jobs:
      - deployment: DeployProd
        pool:
          name: SelfHosted-Linux
        environment: production
        strategy:
          runOnce:
            deploy:
              steps:
                - script: echo "Deploy approved version"
```

Real-Time Scenario: Developers test their changes in Dev, then QA validates the same image. After approval, we promote that immutable image version to Production.

### Q20. How do you integrate Azure DevOps with Argo CD?

Interview Answer:

We use Azure DevOps for CI and Argo CD for GitOps-based CD.

Azure DevOps builds and pushes Docker images to ECR or ACR.

After approval, the pipeline updates the image tag in the GitOps repository. Argo CD detects the changes and deploys them to EKS or AKS.

Production Flow:

```
Azure Repos / GitHub
         |
         v
Azure DevOps Pipeline
         |
         v
Build + Test + Scan
         |
         v
Docker Image → ECR / ACR
         |
         v
GitOps Repository Update
         |
         v
Argo CD
         |
         v
EKS / AKS Deployment
```

Production Commands:

```
# Check Argo CD status
argocd app get payment-prod

# Compare changes
argocd app diff payment-prod

# Synchronize after approval if manual
argocd app sync payment-prod

# Verify Kubernetes rollout
kubectl rollout status \
  deployment/payment-service \
  -n production
```

Real-Time Scenario: Azure DevOps builds a new image and updates the GitOps repository through an approved pull request. Argo CD automatically deploys the new version after the change is merged.

## Bonus: Additional Azure DevOps SRE Interview Questions

| Interview Question                                              | Short Answer                                                                          |
| --------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| What is an agent pool?                                          | A group of agents available to execute pipeline jobs.                                 |
| What is a self-hosted agent?                                    | An agent installed and managed on our own VM or server.                               |
| Can Azure DevOps deploy to AWS EKS?                             | Yes, using AWS authentication, network connectivity, and kubectl/Helm.                |
| Can Azure DevOps deploy to AKS?                                 | Yes, using Azure service connections and Kubernetes deployment tasks.                 |
| Does Azure DevOps require a public Kubernetes cluster?          | No. Private clusters can be accessed through suitable self-hosted agents.             |
| What is Workload Identity Federation?                           | Authentication using short-lived federated tokens instead of long-lived credentials.  |
| What is a variable group?                                       | A reusable set of pipeline variables, including protected secrets.                    |
| What is a secure file?                                          | A protected file that authorized pipelines can download at runtime.                   |
| How do you protect secrets?                                     | Use secret variables, Key Vault, restricted service connections, and least privilege. |
| What is a deployment job?                                       | A pipeline job designed to deploy to an environment and track deployment history.     |
| How do you trigger a pipeline?                                  | Branch triggers, PR triggers, schedules, resources, or manual execution.              |
| What is `dependsOn`?                                            | Defines dependencies between pipeline stages or jobs.                                 |
| What is a pipeline artifact?                                    | An output from a pipeline that can be published and consumed by later jobs.           |
| How do you prevent two Production deployments running together? | Use environment exclusive-lock checks or another approved concurrency mechanism.      |
| How do you monitor pipeline failures?                           | Review pipeline logs, agent diagnostics, stage results, and configured alerts.        |

## Last-Minute Azure DevOps Commands

```
# Self-hosted agent
cd ~/myagent
sudo ./svc.sh status
sudo ./svc.sh stop
sudo ./svc.sh start

# Agent troubleshooting
ls -ltr _diag/
top
free -h
df -h

# AWS EKS authentication
aws sts get-caller-identity

aws eks update-kubeconfig \
  --region ap-south-1 \
  --name prod-eks

# AKS authentication
az account show

az aks get-credentials \
  --resource-group prod-rg \
  --name prod-aks

# Kubernetes permission check
kubectl auth can-i get pods \
  -n production

# Application verification
kubectl get pods -n production

kubectl rollout status \
  deployment/payment-service \
  -n production

# Application logs
kubectl logs \
  deployment/payment-service \
  -n production --tail=100
```

## Two Most Important Interview Answers

### Interviewer: How did you configure a self-hosted agent in Azure DevOps?

> First, we provisioned a Linux VM and installed the required tools, such as Docker, kubectl, Helm, and cloud CLIs.
>
> Then we created a self-hosted agent pool in Azure DevOps, downloaded the agent package, and registered the agent using `./config.sh`.
>
> After registration, we installed and started the agent as a Linux service using `./svc.sh`.
>
> Finally, we selected the agent pool in our YAML pipeline and verified the build and deployment jobs.

### Interviewer: How does Azure DevOps connect to AWS EKS and Azure AKS?

> For EKS, we can use a self-hosted agent running on AWS EC2 with an IAM role. We install AWS CLI and kubectl and configure EKS access using `aws eks update-kubeconfig`.
>
> For AKS, we normally create an Azure Resource Manager service connection using Workload Identity Federation.
>
> In both cases, the agent must have network access to the cluster and the required Kubernetes permissions.
>
> Once connectivity and permissions are verified, we deploy applications using kubectl, Helm, or Kubernetes deployment tasks.

End of Section 4 – Azure DevOps CI/CD

Covered: 20 detailed questions + 15 bonus interview questions, including self-hosted agent installation, agent failures, high CPU, EKS/AKS connections, IAM, Service Connections, Docker builds, approvals, rollbacks, and Argo CD integration.

Next Section 5: AWS Disaster Recovery – End-to-End Python/Bash DR Scripts, Cross-Region Backups, RTO/RPO, Automatic vs Manual Failover, Route 53, RDS Recovery, CI/CD Integration and Real Production Incident Scenarios.

This section deserves particular attention because your   HR notes emphasized detailed questions about personal DR implementation and recovery scripts.

# X Company – SRE Interview Preparation

## Section 5: AWS Disaster Recovery (DR)

### Subtopic 5.1: End-to-End Disaster Recovery, Python/Bash Scripts, Cross-Region Backups, Failover and Production Scenarios

Level: Second Round – SRE / DevOps (5 Years Experience)

Focus: Questions shared by   HR + additional practical SRE questions + real-world commands + disaster recovery automation.

### Example Production Environment

```
Cloud          : AWS
Primary Region : ap-south-1 (Mumbai)
DR Region      : ap-south-2 (Hyderabad)
Compute        : EC2 / EKS
Database       : Amazon RDS PostgreSQL
Storage        : S3 / EBS
Infrastructure : Terraform
CI/CD          : Azure DevOps
Automation     : Python Boto3 / Bash
Monitoring     : CloudWatch + Prometheus + Grafana
Traffic        : Route 53 / ALB
```

Production Note: The following is an example architecture, not a claim about your previous company. In a real disaster, use the approved recovery runbook and do not modify DNS or promote databases without confirming the recovery decision.

### Q1. What is Disaster Recovery in AWS, and how do you implement it?

Interview Answer:

Disaster Recovery is the process of restoring applications and data when the primary infrastructure becomes unavailable.

In AWS, we use backups, cross-region replication, secondary infrastructure, recovery scripts, and Route 53 failover.

Our goal is to restore business services within the defined RTO and RPO.

Production Architecture:

```
Primary Region – Mumbai
        |
        | Application + Database
        | Backups / Data Replication
        v
DR Region – Hyderabad
        |
        | Restore / Promote Database
        | Start / Scale Applications
        | Verify Health
        v
Route 53 Traffic Failover
        |
        v
Application Restored
```

Production Commands:

```
# Check primary EC2 instances
aws ec2 describe-instances \
  --region ap-south-1

# Check primary RDS databases
aws rds describe-db-instances \
  --region ap-south-1

# Check DR RDS databases
aws rds describe-db-instances \
  --region ap-south-2

# Check DR backups
aws backup list-backup-vaults \
  --region ap-south-2
```

Real-Time Scenario: The Mumbai region becomes unavailable. We activate the approved DR plan, recover application services in Hyderabad, verify data and application health, and switch traffic.

### Q2. What are RTO and RPO in Disaster Recovery?

Interview Answer:

RTO (Recovery Time Objective): Maximum acceptable time to restore the service.

RPO (Recovery Point Objective): Maximum acceptable amount of data loss, measured in time.

Example:

```
RTO = 30 minutes
RPO = 5 minutes
```

This means the business requires recovery within 30 minutes and accepts losing at most five minutes of data.

Production Commands:

```
# Check backup jobs
aws backup list-backup-jobs \
  --region ap-south-1

# Check DR backup copies
aws backup list-copy-jobs \
  --region ap-south-1

# Check CloudWatch DR alarms
aws cloudwatch describe-alarms \
  --region ap-south-2
```

Real-Time Scenario: During a DR drill, we measure how long the application takes to recover and how current the recovered data is. We compare the actual results with RTO and RPO targets.

### Q3. What are the different Disaster Recovery strategies in AWS?

Interview Answer:

AWS has four common DR strategies:

1. Backup and Restore: Restore infrastructure and data from backups.
2. Pilot Light: Keep core services and data ready in the DR region.
3. Warm Standby: Keep a smaller working environment running in DR.
4. Active-Active: Run applications in multiple regions simultaneously.

| Strategy           | Recovery Approach                | Cost       |
| ------------------ | -------------------------------- | ---------- |
| Backup and Restore | Rebuild and restore              | Lower      |
| Pilot Light        | Start remaining infrastructure   | Low–Medium |
| Warm Standby       | Scale the running DR environment | Higher     |
| Active-Active      | Both regions serve traffic       | Highest    |

Production Commands:

```
# Check DR compute availability
aws ec2 describe-instances \
  --region ap-south-2

# Check DR database availability
aws rds describe-db-instances \
  --region ap-south-2

# Check DR EKS clusters
aws eks list-clusters \
  --region ap-south-2
```

Real-Time Scenario: For a payment application requiring quick recovery, we might use Warm Standby. For less critical applications, Backup and Restore may be sufficient.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

AWS Documentation

+1



### Q4. How did you design an end-to-end Disaster Recovery solution in your project?

Interview Answer:

In a production-style DR setup, we prepare secondary-region infrastructure using Terraform.

We configure cross-region backups or replication for databases and storage.

We create Python or Bash scripts to validate recovery resources, restore data, start applications, and verify health.

Finally, we switch traffic using an approved Route 53 recovery process.

End-to-End Process:

```
1. Primary application running
             |
2. Cross-region backup / replication
             |
3. CloudWatch detects failure
             |
4. DR incident declared
             |
5. Run approved recovery automation
             |
6. Restore / promote database
             |
7. Start or scale DR applications
             |
8. Verify application health
             |
9. Switch production traffic
             |
10. Monitor and confirm recovery
```

Production Commands:

```
# Check Terraform DR infrastructure
terraform -chdir=environments/dr plan

# Check DR recovery points
aws backup list-recovery-points-by-backup-vault \
  --backup-vault-name dr-backup-vault \
  --region ap-south-2

# Check secondary Auto Scaling Groups
aws autoscaling describe-auto-scaling-groups \
  --region ap-south-2

# Check DR application endpoint
curl -I https://dr-payments.example.com/health
```

Real-Time Scenario: We conduct a DR drill by recovering a test workload in Hyderabad, validating the restored database and application, and measuring recovery time before closing the drill.

### Q5. How do you configure cross-region backups in AWS?

Interview Answer:

We use AWS Backup to schedule backups and copy supported recovery points to another region.

We configure backup plans, recovery vaults, copy rules, retention policies, KMS encryption, and IAM permissions.

Production Commands:

```
# Check source backup plans
aws backup list-backup-plans \
  --region ap-south-1

# Check primary backup jobs
aws backup list-backup-jobs \
  --region ap-south-1

# Check cross-region copy jobs
aws backup list-copy-jobs \
  --region ap-south-1

# Check recovery points in Hyderabad
aws backup list-recovery-points-by-backup-vault \
  --backup-vault-name dr-backup-vault \
  --region ap-south-2
```

Real-Time Scenario: We configure daily database backups in Mumbai and automatically copy the supported recovery points to Hyderabad.

Follow-Up: Does creating a DR backup vault automatically replicate backups?

Answer: No. We must configure the backup plan and cross-region copy rules. We also verify that copy jobs complete successfully.

### Q6. How do you restore a backup stored in another AWS region?

Interview Answer:

First, I locate a completed recovery point in the DR region.

Then I check its restore metadata and start the restore job using an approved IAM role.

I monitor the restore job and verify the new resource and application data before switching traffic.

Production Commands:

```
# 1. List DR recovery points
aws backup list-recovery-points-by-backup-vault \
  --backup-vault-name dr-backup-vault \
  --region ap-south-2

# 2. Get restore metadata
aws backup get-recovery-point-restore-metadata \
  --backup-vault-name dr-backup-vault \
  --recovery-point-arn <recovery-point-arn> \
  --region ap-south-2

# 3. Start approved restore
aws backup start-restore-job \
  --recovery-point-arn <recovery-point-arn> \
  --metadata file://restore-metadata.json \
  --iam-role-arn <backup-restore-role-arn> \
  --region ap-south-2

# 4. Check restore status
aws backup describe-restore-job \
  --restore-job-id <restore-job-id> \
  --region ap-south-2
```

Important: The metadata file must contain valid settings for the resource being restored, including any required new name, network, or storage configuration. A completed restore job must still be followed by data and application validation.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

AWS CLI 2.37.10 Command Reference

+1



Real-Time Scenario: The primary database is unavailable. We select a completed RDS recovery point already copied to Hyderabad, restore it, verify data integrity, and connect the DR application.

### Q7. How do you restore Amazon RDS from a cross-region snapshot using a script?

Interview Answer:

We use AWS CLI or Python Boto3 to identify the latest approved DR snapshot.

Then we restore a new RDS instance, wait until it becomes available, check its endpoint, and validate database connectivity.

Example Bash Commands (standard RDS, not Aurora):

```
# 1. List DR snapshots
aws rds describe-db-snapshots \
  --region ap-south-2 \
  --snapshot-type manual \
  --query 'DBSnapshots[*].[DBSnapshotIdentifier,Status]'

# 2. Restore from an approved snapshot
aws rds restore-db-instance-from-db-snapshot \
  --region ap-south-2 \
  --db-instance-identifier payment-db-restored \
  --db-snapshot-identifier <dr-snapshot-id-or-arn> \
  --db-instance-class db.t3.medium \
  --db-subnet-group-name dr-private-db-subnets \
  --vpc-security-group-ids <dr-db-security-group-id> \
  --no-publicly-accessible

# 3. Wait for RDS availability
aws rds wait db-instance-available \
  --db-instance-identifier payment-db-restored \
  --region ap-south-2

# 4. Retrieve restored database endpoint
aws rds describe-db-instances \
  --db-instance-identifier payment-db-restored \
  --region ap-south-2 \
  --query 'DBInstances[0].Endpoint.Address' \
  --output text
```

The DR database subnet group, permissions, encryption setup, and chosen instance class must be compatible with the snapshot.

Real-Time Scenario: We restore the latest suitable database snapshot in the secondary region. After RDS becomes available, we verify the database and update the application connection configuration through the approved deployment process.

Follow-Up: Can we immediately connect users once RDS shows Available?

Answer: Not automatically. We must verify data consistency, network connectivity, database credentials, application compatibility, and successful transactions.

### Q8. How did you set up an end-to-end Python script for Disaster Recovery?

Interview Answer:

We can use Python Boto3 to automate the recovery process.

The script checks the DR backup, restores the required resource, waits for recovery, checks the resource status, and provides the new endpoint.

Application validation and production traffic switching happen only after the required approval.

Practical Python Script – Restore an RDS Snapshot

`dr_restore.py`

```
import osimport boto3REGION = "ap-south-2"SNAPSHOT_ID = os.environ["DR_SNAPSHOT_ID"]DB_NAME = "payment-db-restored"SUBNET_GROUP = "dr-private-db-subnets"SECURITY_GROUP = os.environ["DR_DB_SG"]rds = boto3.client("rds", region_name=REGION)# Step 1: Require explicit approvalif os.getenv("DR_APPROVED") != "YES":    raise SystemExit("DR approval is required")# Step 2: Check the backupresponse = rds.describe_db_snapshots(    DBSnapshotIdentifier=SNAPSHOT_ID)snapshot = response["DBSnapshots"][0]if snapshot["Status"] != "available":    raise SystemExit("Snapshot is not available")print("DR snapshot verified")# Step 3: Restore databaserds.restore_db_instance_from_db_snapshot(    DBInstanceIdentifier=DB_NAME,    DBSnapshotIdentifier=SNAPSHOT_ID,    DBInstanceClass="db.t3.medium",    DBSubnetGroupName=SUBNET_GROUP,    VpcSecurityGroupIds=[SECURITY_GROUP],    PubliclyAccessible=False)print("Database restore started")# Step 4: Wait until RDS becomes availablewaiter = rds.get_waiter("db_instance_available")waiter.wait(    DBInstanceIdentifier=DB_NAME,    WaiterConfig={        "Delay": 30,        "MaxAttempts": 120    })# Step 5: Retrieve restored endpointresponse = rds.describe_db_instances(    DBInstanceIdentifier=DB_NAME)endpoint = response["DBInstances"][0]["Endpoint"]["Address"]print("Restored database endpoint:", endpoint)print("Validate database and application before traffic cutover")
```

How to Execute:

```
# Install Boto3 in an approved virtual environment
pip install boto3

# Verify AWS IAM identity
aws sts get-caller-identity

# Set approved DR values
export DR_SNAPSHOT_ID="<approved-dr-snapshot-id>"
export DR_DB_SG="<security-group-id>"
export DR_APPROVED="YES"

# Execute recovery
python dr_restore.py
```

How the Script Works:

```
Execute Python Script
        |
        v
Verify Approval
        |
        v
Check DR Snapshot
        |
        v
Start RDS Restore
        |
        v
Wait Until Available
        |
        v
Get Database Endpoint
        |
        v
Application and Data Validation
        |
        v
Approved Traffic Cutover
```

Real-Time Scenario: During a DR drill, we execute this script to restore a verified RDS snapshot in Hyderabad, validate the restored database, and test the application.

Production Important: This is a learning example for standard RDS instances, not Aurora. Real production automation should additionally check for existing target instances, enforce resource tags and naming, verify encryption and restore settings, handle errors and retries, record recovery jobs, and prevent duplicate execution. Do not run it against production without those controls.

### Q9. Explain exactly how the DR script works when a real disaster happens.

Interview Answer:

When the primary region becomes unavailable, monitoring alerts the SRE team.

After confirming the disaster and activating the DR plan, the recovery automation checks the secondary region, validates available backups, and restores the required resources.

Once the database and applications are healthy, we switch traffic and monitor recovery.

Practical Execution:

```
# Step 1: Check current AWS identity
aws sts get-caller-identity

# Step 2: Check DR backups
aws backup list-recovery-points-by-backup-vault \
  --backup-vault-name dr-backup-vault \
  --region ap-south-2

# Step 3: Execute approved DR recovery
python dr_restore.py

# Step 4: Check recovered database
aws rds describe-db-instances \
  --db-instance-identifier payment-db-restored \
  --region ap-south-2

# Step 5: Check DR application
curl -f https://dr-payments.example.com/health
```

Real-Time Scenario:

```
Mumbai Region Outage
         |
         v
CloudWatch Alarm
         |
         v
Incident Team Confirms DR
         |
         v
Run Recovery Script
         |
         v
Restore Database in Hyderabad
         |
         v
Validate Data and Application
         |
         v
Switch Traffic
         |
         v
Monitor Customer Transactions
```

Follow-Up: What if the script fails halfway?

Answer: I check the error and current restore job status, identify which resources were created, and rerun only the required recovery steps after verifying that duplicate resources will not be created.

### Q10. What is the difference between manual and automated Disaster Recovery?

Interview Answer:

In manual DR, the SRE team executes recovery steps based on the approved runbook.

In automated DR, scripts or workflows perform predefined tasks such as backup verification, database restoration, health checks, and resource scaling.

For critical production recovery, we often automate technical steps but require approval before destructive actions or traffic switching.

| Manual DR                      | Automated DR                          |
| ------------------------------ | ------------------------------------- |
| Engineer starts recovery steps | Pipeline or automation executes steps |
| More manual intervention       | Faster and more consistent execution  |
| Useful for controlled recovery | Useful for repeatable operations      |
| Depends more on engineers      | Depends on automation readiness       |

Production Commands:

```
# Manual recovery trigger
python dr_restore.py

# Check monitoring alarm state
aws cloudwatch describe-alarms \
  --alarm-name-prefix payment-prod

# Check restoration status
aws rds describe-db-instances \
  --region ap-south-2
```

Real-Time Scenario: CloudWatch automatically sends an alert. The incident manager confirms the disaster, then an approved Azure DevOps pipeline executes the DR script.

Follow-Up: Should DR always be fully automatic?

Answer: No. Automatic failover is suitable when health checks, data replication, and recovery safeguards are reliable. Some recovery steps need human approval to avoid incorrect failover or data corruption.

### Q11. How do you configure automated Disaster Recovery using Lambda and CloudWatch?

Interview Answer:

We use CloudWatch alarms and EventBridge to detect and respond to failures.

An approved automation can invoke Lambda or Step Functions to check DR readiness and execute recovery actions.

For complex recovery, Step Functions helps manage multiple steps, retries, and failures.

Production Commands:

```
# Check CloudWatch alarms
aws cloudwatch describe-alarms \
  --region ap-south-1

# Check EventBridge rules
aws events list-rules \
  --region ap-south-1

# Check Step Functions workflows
aws stepfunctions list-state-machines \
  --region ap-south-2

# Check Lambda functions
aws lambda list-functions \
  --region ap-south-2
```

Automation Flow:

```
CloudWatch Alarm
       |
       v
EventBridge
       |
       v
Step Functions / Lambda
       |
       v
Check DR Readiness
       |
       v
Approval / Recovery Decision
       |
       v
Run DR Automation
       |
       v
Health Validation
       |
       v
Traffic Failover
```

Real-Time Scenario: The primary application becomes unhealthy, and CloudWatch sends an alert. The recovery workflow verifies whether the incident meets failover criteria before proceeding.

Important: For regional disasters, keep critical monitoring and recovery controls independent of the failed region wherever possible.

### Q12. How do you promote a cross-region RDS Read Replica during Disaster Recovery?

Interview Answer:

If we already have a cross-region RDS Read Replica, we can promote it to a standalone database when the primary database is unavailable.

First, we check replication lag and replica health. Then we promote the replica after approval and configure the DR application to use its endpoint.

Production Commands:

```
# Check DR replica status
aws rds describe-db-instances \
  --db-instance-identifier payment-dr-replica \
  --region ap-south-2

# Promote standard RDS read replica
aws rds promote-read-replica \
  --db-instance-identifier payment-dr-replica \
  --region ap-south-2

# Wait for availability
aws rds wait db-instance-available \
  --db-instance-identifier payment-dr-replica \
  --region ap-south-2

# Retrieve database endpoint
aws rds describe-db-instances \
  --db-instance-identifier payment-dr-replica \
  --region ap-south-2 \
  --query 'DBInstances[0].Endpoint.Address' \
  --output text
```

Real-Time Scenario: The primary PostgreSQL database in Mumbai becomes unavailable. We promote the existing Hyderabad replica after assessing replication lag and recovery risk.

Important: This command applies to supported standard RDS read replicas, not Aurora clusters. Aurora Global Database has a different failover and recovery procedure.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

AWS CLI 2.37.10 Command Reference



### Q13. What is the difference between cross-region backup and replication?

Interview Answer:

Backup: Stores recoverable copies of data, usually at particular points in time.

Replication: Continuously or periodically copies data changes to another location.

Replication can provide faster recovery, but backups are still needed to recover from accidental deletion or corrupted data.

Production Commands:

```
# Check backup recovery points
aws backup list-recovery-points-by-backup-vault \
  --backup-vault-name dr-backup-vault \
  --region ap-south-2

# Check database replication configuration
aws rds describe-db-instances \
  --region ap-south-2

# Check S3 replication configuration
aws s3api get-bucket-replication \
  --bucket <primary-bucket>
```

Real-Time Scenario: Our DR region contains replicated database data for quicker recovery and separate backups for point-in-time restoration.

### Q14. How do you switch production traffic to the DR region using Route 53?

Interview Answer:

We use Route 53 failover routing or an approved DNS cutover process.

With failover routing, Route 53 can return the healthy secondary endpoint when the primary endpoint becomes unhealthy.

Before enabling customer traffic, we verify that the DR environment is ready.

Production Commands:

```
# Check Route 53 records
aws route53 list-resource-record-sets \
  --hosted-zone-id <hosted-zone-id>

# Check primary health check
aws route53 get-health-check-status \
  --health-check-id <health-check-id>

# Apply an approved manual DNS change
aws route53 change-resource-record-sets \
  --hosted-zone-id <hosted-zone-id> \
  --change-batch file://approved-dr-dns-change.json

# Validate application
curl -Iv https://payments.example.com
```

Real-Time Scenario: The DR application is healthy and ready for traffic. We activate the configured failover routing or apply an approved DNS change to direct users to Hyderabad.

Important: DNS failover does not guarantee immediate migration of every existing connection. Clients and resolvers may cache DNS results. For warm standby, health checks and readiness controls must prevent traffic from reaching an unprepared DR environment.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon Route 53

+2



### Q15. How do you integrate Disaster Recovery scripts with Azure DevOps pipelines?

Interview Answer:

We store DR scripts in Git and create a separate Azure DevOps pipeline for recovery.

The pipeline verifies the environment, obtains approval, runs the DR script on a self-hosted agent, and validates the recovered resources.

Example `azure-pipelines-dr.yml`:

```
trigger: none
pr: none

pool:
  name: DR-SelfHosted-Linux

stages:
  - stage: DisasterRecovery
    jobs:
      - deployment: RestoreDatabase
        environment: production-dr
        strategy:
          runOnce:
            deploy:
              steps:
                - checkout: self

                - bash: |
                    set -euo pipefail

                    aws sts get-caller-identity

                    python dr_restore.py
                  displayName: Run Approved DR Script
                  env:
                    DR_APPROVED: "YES"
                    DR_SNAPSHOT_ID: $(DRSnapshotId)
                    DR_DB_SG: $(DRSecurityGroup)
```

Production Steps:

```
DR Incident Declared
        |
        v
Azure DevOps DR Pipeline
        |
        v
Production DR Approval
        |
        v
Self-Hosted AWS Agent
        |
        v
Execute Python Script
        |
        v
Restore RDS / Infrastructure
        |
        v
Application Verification
        |
        v
Traffic Cutover Approval
```

Real-Time Scenario: During a declared DR event, an authorized engineer starts the Azure DevOps recovery pipeline. The approved pipeline runs on an EC2 self-hosted agent and restores the database.

Important: Configure mandatory approval on the `production-dr` environment, restrict who can run the pipeline and change its variables, and use a dedicated least-privileged IAM role. The example script must also be hardened before real production use.

### Q16. How do you recover an EKS application in another AWS region?

Interview Answer:

We prepare the DR EKS cluster using Terraform and configure IAM, networking, storage, monitoring, and container registry access.

Then we restore any required persistent data, deploy the applications through Argo CD, and validate their health.

Production Commands:

```
# Check DR EKS cluster
aws eks describe-cluster \
  --name dr-eks \
  --region ap-south-2

# Connect to DR EKS
aws eks update-kubeconfig \
  --name dr-eks \
  --region ap-south-2 \
  --alias dr-eks

# Check nodes
kubectl --context dr-eks get nodes

# Check deployed applications
kubectl --context dr-eks \
  get pods -n production

# Verify application rollout
kubectl --context dr-eks \
  rollout status deployment/payment-service \
  -n production
```

Real-Time Scenario: When Mumbai EKS becomes unavailable, we activate the secondary EKS environment in Hyderabad, verify restored data, synchronize applications, and switch traffic after health validation.

Follow-Up: Can AWS Backup back up EKS?

Answer: Yes. AWS Backup supports EKS cluster state and supported persistent application data, including cross-region backup capabilities. Recovery still requires validating external dependencies and application readiness.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://aws.amazon.com\&sz=32)

AWS



### Q17. How do you troubleshoot when the DR script fails to restore a backup?

Interview Answer:

First, I check the script logs and restore job status.

Then I verify backup availability, IAM permissions, KMS access, networking, service quotas, and restore metadata.

Once the root cause is fixed, I retry safely.

Production Commands:

```
# Check DR recovery points
aws backup list-recovery-points-by-backup-vault \
  --backup-vault-name dr-backup-vault \
  --region ap-south-2

# Check restore job
aws backup describe-restore-job \
  --restore-job-id <restore-job-id> \
  --region ap-south-2

# Check AWS identity
aws sts get-caller-identity

# Check RDS status
aws rds describe-db-instances \
  --region ap-south-2
```

Real-Time Scenario: RDS restore fails because the configured DR subnet group or required KMS permissions are incorrect.

I identify the failure, correct the DR configuration, and retry the restore after verifying existing resources.

### Q18. What happens if the latest backup is missing or corrupted during DR?

Interview Answer:

I check the available recovery points in the secondary region and identify the most recent valid backup.

Then I verify the recovery timestamp and its impact on RPO.

If recovery exceeds the defined RPO, I escalate the risk to the incident manager before proceeding.

Production Commands:

```
# List recovery points and their status
aws backup list-recovery-points-by-backup-vault \
  --backup-vault-name dr-backup-vault \
  --region ap-south-2 \
  --query 'RecoveryPoints[*].[RecoveryPointArn,Status,CreationDate]' \
  --output table

# Check copy-job failures
aws backup list-copy-jobs \
  --region ap-south-1
```

Real-Time Scenario: The latest recovery point is unusable, but an older completed backup is available. We assess the possible data loss before selecting that backup.

### Q19. How do you perform Disaster Recovery testing without affecting production?

Interview Answer:

We perform scheduled DR drills in an isolated environment.

We restore backups into separate resources, test application functionality, measure RTO/RPO, and document the results.

We avoid switching real customer traffic during a normal isolated DR drill.

Production Commands:

```
# Check DR test resources
aws ec2 describe-instances \
  --region ap-south-2

# Check test database
aws rds describe-db-instances \
  --region ap-south-2

# Check test EKS workloads
kubectl --context dr-eks \
  get pods -n dr-testing

# Test DR endpoint
curl -f https://dr-test.example.com/health
```

Real-Time Scenario: We restore a database backup to an isolated test database, deploy the application against it, perform smoke tests, and record recovery timing.

### Q20. How do you switch traffic back to the primary region after Disaster Recovery?

Interview Answer:

This process is called failback.

First, we restore the primary environment and synchronize the data from the active DR region.

After verifying data consistency and application health, we gradually redirect traffic to the primary region.

Production Commands:

```
# Check primary infrastructure
aws rds describe-db-instances \
  --region ap-south-1

aws eks list-clusters \
  --region ap-south-1

# Check primary application
curl -f https://primary-payments.example.com/health

# Check current DNS configuration
aws route53 list-resource-record-sets \
  --hosted-zone-id <hosted-zone-id>
```

Real-Time Scenario: After Mumbai recovers, we synchronize the latest writes from Hyderabad back to Mumbai, validate the application, and switch traffic through an approved failback procedure.

Important: Failback is not just changing DNS. Data written in the DR region must be reconciled, and both regions must not accept conflicting writes unless the application supports it.

## Bonus: Additional AWS DR Interview Questions

| Interview Question                                    | Short Answer                                                                              |
| ----------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| Difference between HA and DR?                         | HA handles local failures; DR handles larger disruptions requiring recovery.              |
| What is Multi-AZ?                                     | Deploying resources across multiple Availability Zones for higher availability.           |
| Is Multi-AZ the same as Multi-Region DR?              | No. Multi-AZ protects within a region; Multi-Region DR handles regional outages.          |
| What is Pilot Light?                                  | Core data and services remain ready while other resources are activated during recovery.  |
| What is Warm Standby?                                 | A smaller working environment runs continuously in the DR region.                         |
| What is active-active DR?                             | Both regions serve production traffic.                                                    |
| What is active-passive DR?                            | One region serves traffic while another is kept for recovery.                             |
| What is failover?                                     | Moving production services to a secondary environment.                                    |
| What is failback?                                     | Returning services to the recovered primary environment.                                  |
| What is replication lag?                              | Delay between changes in the primary database and their arrival at the replica.           |
| What is split-brain?                                  | Two environments accept conflicting writes because they both consider themselves primary. |
| Can Route 53 automatically fail over?                 | Yes, with correctly configured routing records and health checks.                         |
| Can Terraform automatically restore application data? | Not by itself. Data recovery requires backup, replication, or restoration procedures.     |
| Can a snapshot provide zero RPO?                      | Normally no. Data written after the snapshot may be lost.                                 |
| What is a DR drill?                                   | A controlled test of the recovery process.                                                |
| What is a runbook?                                    | Documented procedures and commands for executing operational tasks.                       |
| How do you monitor DR readiness?                      | Check backups, replication lag, health checks, capacity, and alerts.                      |
| How do you prevent accidental DR activation?          | Use approvals, restricted access, validation, and safety checks.                          |

## Last-Minute AWS Disaster Recovery Commands

```
# Check backups
aws backup list-backup-jobs \
  --region ap-south-1

# Check cross-region copy jobs
aws backup list-copy-jobs \
  --region ap-south-1

# Check DR recovery points
aws backup list-recovery-points-by-backup-vault \
  --backup-vault-name dr-backup-vault \
  --region ap-south-2

# Restore standard RDS snapshot
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier <restored-db> \
  --db-snapshot-identifier <snapshot-id> \
  --region ap-south-2

# Promote standard RDS replica
aws rds promote-read-replica \
  --db-instance-identifier <replica-name> \
  --region ap-south-2

# Check DR EKS
aws eks list-clusters \
  --region ap-south-2

# Check DR Auto Scaling Groups
aws autoscaling describe-auto-scaling-groups \
  --region ap-south-2

# Check Route 53 health checks
aws route53 list-health-checks

# Check CloudWatch alarms
aws cloudwatch describe-alarms \
  --region ap-south-2

# Execute approved DR script
python dr_restore.py
```

## Most Important   Interview Questions – Final Revision

These are the answers you should especially practise speaking.

### Interviewer: Were you involved in the end-to-end DR setup? Explain your contribution.

Sample Answer:

> In our example DR setup, we used Terraform to prepare the secondary-region infrastructure and AWS Backup to maintain cross-region recovery points.
>
> We used Python Boto3 and AWS CLI scripts to automate recovery activities like checking backups, restoring RDS databases, and validating resources.
>
> We also integrated recovery scripts with our deployment process so that approved recovery actions could be executed consistently.
>
> During DR testing, we verified database restoration, application health, and recovery timings.

Explain only the parts you personally performed.

### Interviewer: Explain how your DR automation script works, line by line.

Sample Answer:

> First, the script authenticates using the assigned IAM role.
>
> Second, it connects to the DR region using Boto3.
>
> Third, it checks the selected recovery point and confirms it is available.
>
> Fourth, it starts the restore process using the AWS API.
>
> Fifth, it waits until the restored database becomes available.
>
> Finally, it retrieves the endpoint and provides the details needed for application validation and the approved traffic cutover.

### Interviewer: A disaster happens at 2 AM. How will you handle it?

Sample Answer:

> First, I acknowledge the monitoring alert and check the customer impact.
>
> I confirm the issue with the incident team and activate the approved DR process.
>
> Then I verify secondary-region availability, backups, and data replication status.
>
> After approval, I execute the recovery automation, verify database and application health, and coordinate traffic failover.
>
> Once the service is restored, I monitor the application, record RTO and RPO, and participate in the incident root cause analysis.

End of Section 5 – AWS Disaster Recovery

Covered: 20 detailed interview questions + 18 bonus questions, including your   HR questions about end-to-end scripts, real disaster execution, cross-region restores, manual and automated recovery, CI/CD integration, rollback, and failback.

Next Section 6: Prometheus and Grafana – Production Monitoring, PromQL, Alertmanager, SRE SLIs/SLOs, CPU/Memory Troubleshooting, Kubernetes Monitoring, AWS Managed Grafana, and Real-Time Incident Scenarios.

# X Company – SRE Interview Preparation

## Section 6: Prometheus, Grafana and SRE Monitoring

### Subtopic 6.1: Production Monitoring, PromQL, Alertmanager, AWS Managed Grafana and Incident Troubleshooting

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: All HR questions + additional production questions + PromQL + practical commands + alert configuration + troubleshooting.

### Example Production Environment

```
Cloud       : AWS / Azure
Kubernetes  : EKS / AKS
Namespace   : production
Application : payment-service
Metrics     : Prometheus
Dashboards  : Grafana
Alerting    : Alertmanager / Grafana Alerting
Logs        : CloudWatch / Loki
CI/CD       : Azure DevOps
```

### Q1. Why do we use Prometheus and Grafana together?

Interview Answer:

Prometheus collects and stores application and infrastructure metrics.

Grafana connects to Prometheus and displays these metrics using dashboards and graphs.

We use both to monitor CPU, memory, pod health, response time, and application errors.

Production Commands:

```
# Check monitoring components
kubectl get pods -n monitoring

# Check monitoring Services
kubectl get svc -n monitoring

# Check Prometheus resources
kubectl get prometheus -n monitoring

# Check Grafana Deployment
kubectl get deployments -n monitoring
```

Real-Time Scenario: Payment Service starts consuming high CPU. Prometheus collects the metrics, and Grafana displays the CPU spike. The SRE team investigates the issue.

### Q2. How do you install Prometheus and Grafana in an EKS or AKS cluster?

Interview Answer:

We normally use the `kube-prometheus-stack` Helm chart.

It installs and configures Prometheus, Grafana, Alertmanager, Prometheus Operator, and other monitoring components.

In production, we use approved Helm versions, persistent storage, secure access, and monitoring configurations.

Production Commands:

```
# Add Helm repository
helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts

helm repo update

# Create monitoring namespace
kubectl create namespace monitoring

# Install approved chart version
helm upgrade --install monitoring \
  prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --version <approved-chart-version> \
  -f values-prod.yaml

# Verify installation
kubectl get pods -n monitoring

# Check Services
kubectl get svc -n monitoring

# Check Helm release
helm list -n monitoring
```

Real-Time Scenario: We deploy the monitoring stack into EKS and collect Kubernetes node, pod, and application metrics.

Important: The chart version and production values must be tested before deployment. Avoid exposing Prometheus or Grafana directly to the internet without proper authentication.

### Q3. How does Prometheus collect metrics from Kubernetes applications?

Interview Answer:

Prometheus follows a pull-based model. It regularly sends HTTP requests to configured metrics endpoints, commonly `/metrics`.

It discovers targets using Kubernetes discovery or ServiceMonitor resources and stores the returned measurements.

Example Application Metrics Endpoint:

```
http://payment-service:8080/metrics
```

Production Commands:

```
# Check monitoring pods
kubectl get pods -n monitoring

# Check configured ServiceMonitors
kubectl get servicemonitors -A

# Check application Service
kubectl get svc -n production

# Test metrics endpoint from an approved pod
curl http://payment-service:8080/metrics
```

Real-Time Scenario: Payment Service exposes HTTP request count and response-time metrics. Prometheus scrapes them periodically and makes them available for Grafana dashboards.

Follow-Up: Does Prometheus always use pull-based monitoring?

Answer: Pull is the standard model, but Prometheus also supports remote write for sending metrics to remote storage. Short-lived batch jobs may use Pushgateway when appropriate.

### Q4. What are metrics in Prometheus, and what types are available?

Interview Answer:

Metrics are numerical measurements of system or application behavior.

Prometheus has four main metric types.

| Metric Type | Meaning                                       | Example                  |
| ----------- | --------------------------------------------- | ------------------------ |
| Counter     | Increases, except resets                      | Total HTTP requests      |
| Gauge       | Increases or decreases                        | Memory usage             |
| Histogram   | Records value distributions in buckets        | Request duration         |
| Summary     | Records observations and configured quantiles | Request duration summary |

Example PromQL:

```
# Counter
http_requests_total

# Gauge
container_memory_working_set_bytes

# Histogram bucket
http_request_duration_seconds_bucket
```

Real-Time Scenario: We use counters for HTTP request totals, gauges for memory usage, and histograms to monitor response latency. Actual metric names depend on the application's instrumentation.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://prometheus.io\&sz=32)

Prometheus



### Q5. What are labels in Prometheus?

Interview Answer:

Labels are key-value pairs used to identify and filter metrics.

For example, we can filter CPU usage by namespace, pod, or container.

Example Metric:

```
container_memory_working_set_bytes{
  namespace="production",
  pod="payment-service-abc123",
  container="payment-service"
}
```

Practical Query:

```
sum by (pod) (
  container_memory_working_set_bytes{
    namespace="production",
    container!="",
    container!="POD"
  }
)
```

Real-Time Scenario: Instead of checking memory usage for every pod, I filter the production namespace and identify which application pod uses the most memory.

Follow-Up: What is high cardinality?

Answer: It means too many unique label combinations. Labels such as user IDs or request IDs can create excessive time series and increase monitoring cost and resource usage.

### Q6. What are visualizations in Grafana?

Interview Answer:

Visualizations are graphs, charts, gauges, and tables that display monitoring data.

We use them to understand system performance, identify failures, and compare metrics over time.

Practical Configuration:

```
Grafana
   |
   v
Dashboards
   |
   v
New Dashboard
   |
   v
Add Visualization
   |
   v
Select Prometheus
   |
   v
Enter PromQL Query
   |
   v
Choose Time Series / Gauge
   |
   v
Save Dashboard
```

Example PromQL – Running Pods:

```
sum(
  kube_pod_status_phase{
    namespace="production",
    phase="Running"
  }
)
```

Real-Time Scenario: We create a production dashboard showing running pods, CPU usage, memory, error rates, and application latency.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://grafana.com\&sz=32)

Grafana documentation



### Q7. How do you connect Prometheus to Grafana?

Interview Answer:

We configure Prometheus as a data source in Grafana.

We provide the Prometheus URL, configure authentication if required, and test the connection.

Then we create dashboards using PromQL.

Practical Configuration:

```
Grafana
   |
   v
Connections → Data Sources
   |
   v
Add Data Source
   |
   v
Prometheus
   |
   v
Enter Prometheus URL
   |
   v
Save & Test
```

Example Internal URL:

```
http://prometheus-service.monitoring.svc.cluster.local:9090
```

The actual Service name depends on the installation.

Production Commands:

```
# Find actual Prometheus Service
kubectl get svc -n monitoring

# Check Prometheus pods
kubectl get pods -n monitoring

# Check Service endpoints
kubectl get endpointslices -n monitoring
```

Real-Time Scenario: Grafana initially shows no data because its Prometheus URL is incorrect. We identify the correct internal Service endpoint and restore the data source connection.

### Q8. How does AWS Managed Grafana work in production?

Interview Answer:

Amazon Managed Grafana is a managed visualization service provided by AWS.

We create a Grafana workspace, configure user authentication and IAM permissions, and connect data sources such as Amazon Managed Service for Prometheus or CloudWatch.

Then we create dashboards and alerts to monitor AWS infrastructure and Kubernetes applications.

Production Commands:

```
# List Grafana workspaces
aws grafana list-workspaces \
  --region ap-south-1

# Check a Grafana workspace
aws grafana describe-workspace \
  --workspace-id <grafana-workspace-id> \
  --region ap-south-1

# List Managed Prometheus workspaces
aws amp list-workspaces \
  --region ap-south-1
```

Production Process:

```
EKS Application Metrics
          |
          v
Prometheus Collector
          |
          v
Amazon Managed Service
for Prometheus
          |
          v
Amazon Managed Grafana
          |
          v
Dashboards + Alerts
```

Real-Time Scenario: We collect EKS cluster metrics into Amazon Managed Service for Prometheus and visualize CPU, memory, pod health, and request latency through Amazon Managed Grafana.

Important: In Amazon Managed Grafana version 12 and later, Amazon Managed Service for Prometheus uses its dedicated data source integration rather than the old core Prometheus SigV4 integration.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon Managed Grafana

+2



### Q9. How do you monitor Kubernetes CPU usage using Prometheus?

Interview Answer:

We use Prometheus container CPU metrics and the `rate()` function to calculate CPU usage over time.

In Grafana, we identify high-CPU pods and correlate their usage with request traffic, CPU limits, and application latency.

PromQL – CPU Usage by Pod (CPU Cores):

```
sum by (pod) (
  rate(container_cpu_usage_seconds_total{
    namespace="production",
    container!="",
    container!="POD"
  }[5m])
)
```

Production Commands:

```
# Check live CPU usage
kubectl top pods -n production

# Check node CPU
kubectl top nodes

# Check CPU requests and limits
kubectl describe deployment payment-service \
  -n production
```

Real-Time Scenario: A payment pod is using almost one full CPU core. I review Grafana CPU trends, check application logs and request load, and investigate throttling or inefficient code.

Follow-Up: Why do we use `rate()`?

Answer: CPU usage is exposed as a cumulative counter. `rate()` calculates how quickly it increases per second, giving usage in CPU cores.

### Q10. How do you monitor Kubernetes memory usage and identify OOMKilled containers?

Interview Answer:

We use Prometheus memory metrics to monitor application memory trends.

If memory reaches the configured limit, the container may be OOMKilled.

I compare current memory usage with configured limits and check container restart history.

PromQL – Memory Usage by Pod:

```
sum by (pod) (
  container_memory_working_set_bytes{
    namespace="production",
    container!="",
    container!="POD"
  }
) / 1024 / 1024
```

This displays memory in MiB.

PromQL – Last Recorded OOMKilled Status:

```
kube_pod_container_status_last_terminated_reason{
  namespace="production",
  reason="OOMKilled"
} == 1
```

Production Commands:

```
# Check memory
kubectl top pods -n production

# Check pod termination reason
kubectl describe pod <pod-name> \
  -n production

# Check previous crash logs
kubectl logs <pod-name> \
  -n production --previous
```

Real-Time Scenario: Grafana shows memory continuously increasing before a container restart. Kubernetes reports OOMKilled. We investigate a memory leak or insufficient memory limit.

Follow-Up: Can Grafana show memory usage before a pod crashes?

Answer: Yes, if Prometheus successfully collected the metrics before the crash and they are still retained. We review the historical time range in Grafana.

### Q11. How do you configure alerts using Prometheus and Alertmanager?

Interview Answer:

We create alerting rules in Prometheus with conditions such as high CPU, pod failures, or application downtime.

Prometheus evaluates the rules, and Alertmanager groups and routes alerts to email, PagerDuty, or other notification systems.

Example `alert-rules.yaml`:

```
groups:
  - name: production-alerts
    rules:
      - alert: PaymentServiceDown
        expr: up{job="payment-service"} == 0
        for: 2m
        labels:
          severity: critical
        annotations:
          summary: "Payment Service target is down"
```

Production Commands:

```
# Check Prometheus rule resources
kubectl get prometheusrules -A

# Check Alertmanager
kubectl get alertmanager -n monitoring

# Check monitoring pods
kubectl get pods -n monitoring

# Validate a standalone Prometheus rules file
promtool check rules alert-rules.yaml
```

Real-Time Scenario: Prometheus cannot scrape Payment Service for two minutes. An alert fires, and Alertmanager sends a notification to the SRE team.

Important: If the target disappears entirely from service discovery, an `up == 0` rule alone may not fire. We also monitor missing expected targets or use external availability probes.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://prometheus.io\&sz=32)

Prometheus



### Q12. Grafana dashboard is showing "No Data." How do you troubleshoot?

Interview Answer:

First, I check the Grafana data source connection.

Then I verify Prometheus availability, scrape targets, query labels, selected time range, and application metrics.

Production Commands:

```
# Check monitoring pods
kubectl get pods -n monitoring

# Check Prometheus Services
kubectl get svc -n monitoring

# Check Prometheus logs
kubectl logs -n monitoring \
  <prometheus-pod-name> --tail=100

# Check app metrics endpoint
curl http://payment-service:8080/metrics
```

PromQL:

```
up
```

Real-Time Scenario: Grafana stopped displaying payment application metrics after a deployment. We found that the ServiceMonitor selector no longer matched the Service labels. After fixing the configuration, data collection resumed.

### Q13. A Prometheus target shows DOWN. What will you do?

Interview Answer:

I check whether the target application is running and whether its `/metrics` endpoint is accessible.

Then I verify the Service, endpoints, ServiceMonitor, port configuration, and NetworkPolicies.

Production Commands:

```
# Check application pods
kubectl get pods -n production

# Check application Service
kubectl get svc -n production

# Check ServiceMonitor
kubectl get servicemonitors -n production

# Check Service endpoints
kubectl get endpointslices -n production

# Check NetworkPolicies
kubectl get networkpolicy -n production
```

PromQL:

```
up{job="payment-service"}
```

`1` means the target was scraped successfully; `0` means the scrape failed.

Real-Time Scenario: Prometheus cannot collect metrics because the application's metrics port changed. We correct the Service or ServiceMonitor configuration and verify the target becomes UP.

### Q14. What are SLA, SLO, SLI, and Error Budget in SRE?

Interview Answer:

- SLI: Actual measured service performance, such as availability or latency.
- SLO: Internal reliability target, such as 99.9% successful requests.
- SLA: Service agreement with customers, potentially including consequences for violations.
- Error Budget: The permitted amount of unreliability under the SLO.

PromQL – HTTP Error Rate:

```
100 *
sum(rate(http_requests_total{
  status=~"5.."
}[5m]))
/
clamp_min(
  sum(rate(http_requests_total[5m])),
  1e-9
)
```

This assumes the application exposes an `http_requests_total` counter with a `status` label.

Real-Time Scenario: Our service has a 99.9% availability SLO. We monitor successful requests and error budget consumption to decide whether risky releases should continue.

Follow-Up: What is an Error Budget Burn Rate?

Answer: It shows how quickly we are consuming the permitted error budget. A high burn rate indicates that reliability is getting worse faster than expected.

### Q15. How do you monitor application response time and latency using Prometheus?

Interview Answer:

We instrument the application to expose request-duration metrics.

We use histogram metrics and PromQL to calculate latency percentiles such as P95 or P99.

PromQL – P95 Latency:

```
histogram_quantile(
  0.95,
  sum by (le) (
    rate(http_request_duration_seconds_bucket[5m])
  )
)
```

PromQL – Request Rate:

```
sum(rate(http_requests_total[5m]))
```

Real-Time Scenario: Payment Service P95 latency increases from 200 ms to 2 seconds. I investigate database response times, downstream APIs, CPU usage, and recent deployments.

Follow-Up: What does P95 mean?

Answer: P95 means approximately 95% of measured requests completed within that response time during the selected period.

The histogram query assumes classic histogram metrics are available.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://prometheus.io\&sz=32)

Prometheus



### Q16. How do you monitor node CPU, memory, and disk using Prometheus?

Interview Answer:

We use Node Exporter to collect node-level metrics.

Prometheus scrapes these metrics, and Grafana displays CPU, memory, disk usage, and network activity.

PromQL – Node Memory Usage Percentage:

```
100 * (
  1 -
  node_memory_MemAvailable_bytes
  /
  node_memory_MemTotal_bytes
)
```

PromQL – Root Filesystem Usage Percentage:

```
100 * (
  1 -
  node_filesystem_avail_bytes{
    mountpoint="/"
  }
  /
  node_filesystem_size_bytes{
    mountpoint="/"
  }
)
```

Production Commands:

```
# Check node health
kubectl get nodes

# Check node usage
kubectl top nodes

# Check Node Exporter
kubectl get daemonsets -n monitoring

# Investigate node
kubectl describe node <node-name>
```

Real-Time Scenario: Grafana shows a worker node reaching 95% disk usage. I investigate container logs, unused images, filesystem usage, and node disk pressure.

### Q17. How do you configure Grafana alerts and notifications?

Interview Answer:

We create alert rules using PromQL and configure conditions, evaluation periods, and notification policies.

Grafana can send alerts to supported destinations such as email, PagerDuty, or webhook integrations.

Practical Configuration:

```
Grafana
   |
   v
Alerting
   |
   v
Alert Rules
   |
   v
Create New Alert
   |
   v
Select Prometheus
   |
   v
Enter PromQL Query
   |
   v
Set Threshold
   |
   v
Configure Contact Point
   |
   v
Save Rule
```

Example Alert Expression:

```
100 * (
  1 -
  node_memory_MemAvailable_bytes
  /
  node_memory_MemTotal_bytes
) > 90
```

Real-Time Scenario: A node exceeds 90% memory usage for a sustained period. Grafana sends an alert to the configured SRE notification channel.

Follow-Up: Difference between Prometheus Alertmanager and Grafana Alerting?

Answer: Prometheus rules and Alertmanager evaluate and route Prometheus alerts. Grafana Alerting can create and evaluate alerts across multiple supported data sources.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://grafana.com\&sz=32)

Grafana documentation



### Q18. How do you monitor AWS EKS using Amazon Managed Prometheus and Grafana?

Interview Answer:

We create an Amazon Managed Service for Prometheus workspace and configure an EKS metrics collector.

Metrics are stored in the managed Prometheus workspace.

We connect Amazon Managed Grafana using approved IAM permissions and build monitoring dashboards.

Production Commands:

```
# List Managed Prometheus workspaces
aws amp list-workspaces \
  --region ap-south-1

# Describe a workspace
aws amp describe-workspace \
  --workspace-id <workspace-id> \
  --region ap-south-1

# List Grafana workspaces
aws grafana list-workspaces \
  --region ap-south-1

# Check EKS workloads
kubectl get pods -A
```

Real-Time Scenario: We monitor multiple EKS applications using Amazon Managed Service for Prometheus as the metrics backend and Amazon Managed Grafana for visualization.

Follow-Up: How are metrics sent to Amazon Managed Prometheus?

Answer: We can use an AWS-managed EKS collector or a customer-managed collector configured to send metrics through remote write with appropriate IAM permissions.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon Managed Service for Prometheus

+1



### Q19. Your monitoring stopped collecting metrics after an application deployment. How do you fix it?

Interview Answer:

I verify application health, metrics endpoint accessibility, ServiceMonitor configuration, and Prometheus scrape targets.

I also compare the previous working deployment configuration with the new release.

Production Commands:

```
# Check application
kubectl get pods -n production

# Check Service
kubectl get svc -n production

# Check ServiceMonitor
kubectl get servicemonitors -n production

# Check metrics endpoint locally
kubectl port-forward \
  -n production svc/payment-service \
  8080:8080
```

From a second terminal:

```
curl http://localhost:8080/metrics
```

Real-Time Scenario: Developers changed the metrics path from `/metrics` to `/actuator/prometheus`, but the ServiceMonitor still used the old path.

We corrected the configuration through GitOps and verified that Prometheus resumed collecting metrics.

### Q20. A production application goes down at 2 AM. How do you use Prometheus and Grafana to troubleshoot?

Interview Answer:

First, I acknowledge the alert and check application availability.

Then I review Grafana dashboards for CPU, memory, errors, latency, and restarts.

I check Kubernetes pod status, logs, and recent deployments.

If a faulty deployment caused the problem, I follow the approved rollback procedure and verify recovery.

Production Commands:

```
# Check nodes
kubectl get nodes

# Check application pods
kubectl get pods -n production

# Check deployment
kubectl get deployment payment-service \
  -n production

# Check logs
kubectl logs deployment/payment-service \
  -n production --tail=200

# Check recent events
kubectl get events -n production \
  --sort-by=.lastTimestamp

# Check Argo CD
argocd app get payment-prod
```

PromQL – Container Restart Count:

```
kube_pod_container_status_restarts_total{
  namespace="production"
}
```

Real-Time Incident Flow:

```
Prometheus Alert
       |
       v
SRE Acknowledges Incident
       |
       v
Check Grafana Dashboard
       |
       v
Analyze Metrics + Logs
       |
       v
Identify Root Cause
       |
       v
Mitigate / Roll Back
       |
       v
Verify Application Health
       |
       v
RCA + Prevention
```

Real-Time Scenario: After a new deployment, Payment Service pods start restarting because of OOMKilled.

Grafana shows memory increasing before the crash. We identify the faulty release, restore the previous stable version, and verify application performance.

## Bonus: Additional Prometheus, Grafana and SRE Interview Questions

| Interview Question                                        | Short Answer                                                                                      |
| --------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| What is PromQL?                                           | Query language used to analyze Prometheus metrics.                                                |
| What is Prometheus's default port?                        | 9090.                                                                                             |
| What is Grafana's default port?                           | 3000.                                                                                             |
| What is Alertmanager's default port?                      | 9093.                                                                                             |
| What is a scrape interval?                                | How frequently Prometheus collects metrics from a target.                                         |
| What is an exporter?                                      | A component that exposes application or infrastructure metrics in Prometheus format.              |
| What is Node Exporter?                                    | Collects node operating-system and hardware metrics.                                              |
| What is kube-state-metrics?                               | Exposes Kubernetes object-state metrics such as replicas, pod status, and resource configuration. |
| What is cAdvisor?                                         | Collects container resource usage metrics.                                                        |
| What is ServiceMonitor?                                   | A Prometheus Operator resource defining Service-based scrape targets.                             |
| What is PodMonitor?                                       | A Prometheus Operator resource defining pod-based scrape targets.                                 |
| What is a recording rule?                                 | A rule that stores the result of a frequently used PromQL expression.                             |
| What is alert fatigue?                                    | Too many unnecessary alerts overwhelming engineers.                                               |
| What is alert silencing?                                  | Temporarily suppressing notifications for matching alerts.                                        |
| What is remote write?                                     | A Prometheus-compatible mechanism for sending metrics to remote storage.                          |
| Can Prometheus store logs?                                | Prometheus is primarily for metrics; tools such as Loki handle logs.                              |
| What is Blackbox Exporter?                                | An exporter used to probe endpoints for availability and connectivity.                            |
| What is a histogram?                                      | A metric type used to measure distributions such as request durations.                            |
| What is the difference between `rate()` and `increase()`? | `rate()` estimates per-second increase; `increase()` estimates total increase over a time window. |
| How do you monitor a Jenkins or Azure DevOps agent?       | Collect host metrics and agent/job metrics where available, and configure alerts.                 |

## Last-Minute PromQL Revision

```
# Check scrape targets
up

# Pod CPU usage in cores
sum by (pod) (
  rate(container_cpu_usage_seconds_total{
    namespace="production",
    container!="",
    container!="POD"
  }[5m])
)

# Pod memory usage in MiB
sum by (pod) (
  container_memory_working_set_bytes{
    namespace="production",
    container!="",
    container!="POD"
  }
) / 1024 / 1024

# Pod restarts
kube_pod_container_status_restarts_total{
  namespace="production"
}

# OOMKilled status
kube_pod_container_status_last_terminated_reason{
  namespace="production",
  reason="OOMKilled"
} == 1

# HTTP request rate
sum(rate(http_requests_total[5m]))

# HTTP 5xx request rate
sum(rate(http_requests_total{
  status=~"5.."
}[5m]))

# P95 response latency
histogram_quantile(
  0.95,
  sum by (le) (
    rate(http_request_duration_seconds_bucket[5m])
  )
)
```

Queries assume these metrics and labels are available. Adjust metric names to your application and exporters.

## Most Important   Interview Answers

### Interviewer: How did you configure monitoring for your Kubernetes application?

> In our example project, we used Prometheus and Grafana to monitor Kubernetes applications.
>
> We configured Prometheus to collect metrics from nodes, pods, and application endpoints.
>
> We created Grafana dashboards for CPU, memory, application latency, error rates, and pod restarts.
>
> We also configured alerts for application downtime, high resource usage, and deployment failures.
>
> During incidents, we checked Grafana dashboards, Prometheus metrics, Kubernetes events, and application logs to identify the root cause.

### Interviewer: Your application is down, but Grafana shows no data. What will you do?

> First, I check whether Prometheus and Grafana are healthy.
>
> Then I check the Prometheus targets and verify the application's metrics endpoint.
>
> I also review the ServiceMonitor configuration, DNS, network connectivity, and Prometheus logs.
>
> If monitoring itself is unavailable, I continue troubleshooting using Kubernetes logs, events, and cloud monitoring instead of depending only on Grafana.

End of Section 6 – Prometheus and Grafana

Covered: 20 detailed interview questions + 20 bonus questions, including all five HR questions and extra production SRE scenarios.

Next Section 7: Advanced SRE Production Scenarios – SLA, SLO, Error Budgets, Incident Management, On-Call, RCA, Linux Troubleshooting, AWS Networking, Performance Issues, and Behavioral Questions.

# X Company – SRE Interview Preparation

## Section 7: Advanced SRE Production Scenarios

### Subtopic 7.1: Incident Management, Linux, AWS Networking, SLA/SLO and Real-Time Troubleshooting

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: SRE fundamentals, incident handling, high CPU/memory, disk issues, production outages, AWS Direct Connect, networking, application performance, RCA, and on-call responsibilities.

### Example Production Environment

```
Cloud        : AWS / Azure
Compute      : EC2 / EKS / AKS
Operating OS : Linux
CI/CD        : Azure DevOps
Monitoring   : Prometheus + Grafana
Logging      : CloudWatch / Loki
Incident Tool: ServiceNow / PagerDuty
Applications : Payment Microservices
```

### Q1. What is SRE, and how is it different from DevOps?

Interview Answer:

SRE stands for Site Reliability Engineering. It focuses on application reliability, availability, performance, incident management, and automation.

DevOps focuses on collaboration, CI/CD, and faster software delivery.

SRE applies software engineering practices to maintain reliable production systems.

Production Commands:

```
# Check application health
kubectl get pods -n production

# Check deployment status
kubectl get deployments -n production

# Check resource usage
kubectl top pods -n production

# Check service response
curl -I https://payments.example.com/health
```

Real-Time Scenario: As an SRE, I monitor application health, respond to production alerts, troubleshoot incidents, and automate repetitive operational tasks.

### Q2. What are SLA, SLO, SLI, and Error Budget?

Interview Answer:

- SLA: Service agreement with customers.
- SLO: Reliability target, such as 99.9% availability.
- SLI: Actual measured performance.
- Error Budget: Acceptable unreliability within the SLO.

Example:

```
SLO               : 99.9%
Measured SLI      : 99.95%
Allowed Error Rate: 0.1%
```

PromQL – Error Percentage:

```
100 *
sum(rate(http_requests_total{status=~"5.."}[5m]))
/
clamp_min(sum(rate(http_requests_total[5m])), 1e-9)
```

Real-Time Scenario: If the application consumes too much error budget, we may temporarily reduce risky releases and focus on improving reliability.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://sre.google\&sz=32)

Error Budget Policy for Service Reliability



### Q3. How do you handle a critical production incident?

Interview Answer:

First, I acknowledge the incident and check its severity and customer impact.

Then I check monitoring dashboards, infrastructure, application logs, and recent deployments.

I work with the incident team to restore service, provide updates, and participate in RCA after recovery.

Production Commands:

```
# Check Kubernetes nodes
kubectl get nodes

# Check application pods
kubectl get pods -n production

# Check logs
kubectl logs deployment/payment-service \
  -n production --tail=100

# Check recent events
kubectl get events -n production \
  --sort-by=.lastTimestamp
```

Real-Time Scenario: Payment Service stops responding during peak traffic. I acknowledge the alert, investigate the issue, coordinate mitigation, and verify customer transactions after recovery.

Follow-Up: What is an Incident Commander?

Answer: The Incident Commander coordinates response activities, assigns responsibilities, and makes sure communication and recovery efforts stay organized.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://sre.google\&sz=32)

Root Cause Analysis for Probing Incident



### Q4. Your production application suddenly goes down. What is your troubleshooting approach?

Interview Answer:

First, I check the application endpoint and monitoring dashboards.

Then I verify Kubernetes pods, Services, Ingress, load balancer health, and application logs.

I also check recent deployments. If a faulty release caused the incident, I follow the approved rollback procedure.

Production Commands:

```
# Check endpoint
curl -Iv https://payments.example.com

# Check pods
kubectl get pods -n production

# Check Service and Ingress
kubectl get svc,ingress -n production

# Check logs
kubectl logs deployment/payment-service \
  -n production --tail=200

# Check Argo CD
argocd app get payment-prod
```

Real-Time Scenario: An application becomes unavailable immediately after deployment. I identify the failed version, restore the previous stable configuration using GitOps, and verify application health.

### Q5. An EC2 Linux server is consuming 100% CPU. How do you troubleshoot?

Interview Answer:

First, I use `top` or `htop` to identify which process is consuming CPU.

Then I check application logs, system load, CPU utilization trends, and recent changes.

Based on the cause, I optimize the application, scale capacity, or perform approved recovery actions.

Production Commands:

```
# Check CPU usage and processes
top

# Find highest CPU consumers
ps aux --sort=-%cpu | head -10

# Check system load
uptime

# Check CPU usage over time
sar -u 1 5

# Check individual CPU statistics
mpstat -P ALL 1 5
```

The `sar` and `mpstat` commands require the `sysstat` package.

Real-Time Scenario: CPU reaches 100% because a Java process is consuming excessive resources. I check thread activity, application logs, traffic, and recent code changes before taking corrective action.

Follow-Up: What is load average?

Answer: Load average indicates the average number of tasks running or waiting for CPU, including tasks blocked on uninterruptible I/O. I compare it with available CPU cores and system performance.

### Q6. A Linux server is running out of memory. How do you troubleshoot?

Interview Answer:

I check total memory, available memory, swap usage, and processes consuming memory.

I also review application logs and historical memory trends to identify leaks or resource exhaustion.

Production Commands:

```
# Check memory
free -h

# Check memory-heavy processes
ps aux --sort=-%mem | head -10

# Check memory and swap activity
vmstat 1 5

# Check kernel OOM messages
sudo journalctl -k --since "1 hour ago" \
  | grep -iE 'out of memory|oom|killed process'

# Check application logs
sudo journalctl -u payment-service \
  --since "1 hour ago"
```

Real-Time Scenario: A Java application gradually consumes all available memory. I check whether the application has a memory leak or incorrect heap configuration and coordinate the required fix.

Follow-Up: What is the difference between CPU and memory issues?

Answer: CPU issues affect processing capacity and execution speed. Memory issues affect the availability of RAM and can cause swapping or process termination.

### Q7. A production Linux server's disk is 100% full. How do you troubleshoot?

Interview Answer:

First, I check filesystem usage using `df -h`.

Then I use `du` to identify large directories and files.

I investigate application logs, temporary files, Docker images, and disk growth. I clean only approved unnecessary data or expand storage.

Production Commands:

```
# Check filesystem usage
df -h

# Check inode usage
df -i

# Identify large directories
sudo du -xhd1 /var | sort -h

# Check system journal size
journalctl --disk-usage

# Check Docker disk usage
docker system df

# Check large files under /var
sudo find /var -xdev -type f -size +500M \
  -printf '%s %p\n'
```

Real-Time Scenario: The `/var` partition becomes full because application logs are growing continuously.

I identify the log source, coordinate safe cleanup or retention changes, and configure log rotation to prevent recurrence.

Follow-Up: What if `df -h` shows 100% but `du` does not show large files?

Answer: I check deleted files that are still open by running processes.

```
sudo lsof +L1
```

A process may still hold disk space until it closes the deleted file.

### Q8. Your application response time increased from 200 ms to 3 seconds. How do you investigate?

Interview Answer:

First, I check Grafana dashboards for application latency, request traffic, CPU, memory, and error rates.

Then I investigate database performance, network latency, downstream services, and recent deployments.

I identify the bottleneck before increasing infrastructure capacity.

Production Commands:

```
# Check endpoint response time
curl -o /dev/null -s \
  -w 'Total: %{time_total}s\n' \
  https://payments.example.com/health

# Check Kubernetes usage
kubectl top pods -n production

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=100

# Check HPA
kubectl get hpa -n production
```

PromQL – P95 Latency:

```
histogram_quantile(
  0.95,
  sum by (le) (
    rate(http_request_duration_seconds_bucket[5m])
  )
)
```

Real-Time Scenario: Application latency increases even after HPA adds more replicas. I find that database queries are slow and coordinate with the database team rather than adding unnecessary pods.

### Q9. AWS ALB is returning 502, 503, or 504. How do you troubleshoot?

Interview Answer:

First, I identify the exact HTTP status code and whether it is generated by ALB or the backend application.

Then I check target group health, application logs, networking, and backend response time.

| Error | Common Cause                                 |
| ----- | -------------------------------------------- |
| 502   | Invalid backend response or connection reset |
| 503   | No suitable available targets                |
| 504   | Backend connection or response timeout       |

Production Commands:

```
# Check application endpoint
curl -Iv https://payments.example.com

# Check ALB target health
aws elbv2 describe-target-health \
  --target-group-arn <target-group-arn>

# Check backend pods
kubectl get pods -n production

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=100

# Check Ingress
kubectl describe ingress payment-ingress \
  -n production
```

Real-Time Scenario: ALB returns 504 because the backend application is taking too long to respond.

I check application performance, connection errors, target health, and configured timeouts before applying a fix.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Elastic Load Balancing



### Q10. Kubernetes worker node becomes NotReady during production. What will you do?

Interview Answer:

First, I check the node condition and affected application pods.

Then I investigate CPU, memory, disk pressure, networking, kubelet, and underlying EC2 health.

If required, I coordinate node replacement after verifying workload capacity and availability.

Production Commands:

```
# Check nodes
kubectl get nodes

# Check node details
kubectl describe node <node-name>

# Check affected pods
kubectl get pods -A -o wide

# Check cluster events
kubectl get events -A \
  --sort-by=.lastTimestamp

# Check EKS managed node groups
aws eks list-nodegroups \
  --cluster-name prod-eks
```

On an accessible Linux worker node:

```
sudo systemctl status kubelet
sudo journalctl -u kubelet --since "30 min ago"
df -h
free -h
```

Real-Time Scenario: An EC2 worker node becomes NotReady because of disk pressure or kubelet issues.

I identify the cause, verify application replicas are healthy elsewhere, and take appropriate recovery action.

Follow-Up: Can we use `kubectl debug node`?

Answer: Yes, if permissions and node connectivity allow it. We can use an approved debugging container to inspect node issues without SSH.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://kubernetes.io\&sz=32)

Kubernetes



### Q11. An EC2 instance is running, but you cannot connect using SSH. How do you troubleshoot?

Interview Answer:

I check EC2 instance status, security groups, NACLs, route tables, and the network path.

I also verify SSH access permissions and whether the SSH service is running.

For private EC2 instances, I prefer AWS Systems Manager Session Manager when configured.

Production Commands:

```
# Check EC2 status
aws ec2 describe-instance-status \
  --instance-ids <instance-id> \
  --include-all-instances

# Check security groups
aws ec2 describe-security-groups \
  --group-ids <security-group-id>

# Check route tables
aws ec2 describe-route-tables

# Check SSM managed instances
aws ssm describe-instance-information
```

On an accessible Linux host:

```
sudo systemctl status ssh
ss -tlnp | grep ':22'
```

Some distributions use the service name `sshd` rather than `ssh`.

Real-Time Scenario: I cannot SSH to a private EC2 instance because the allowed network path is unavailable. I verify VPN or Session Manager connectivity rather than exposing SSH publicly.

### Q12. What is AWS Direct Connect, and how does it work?

Interview Answer:

AWS Direct Connect provides a dedicated network connection between an organization's on-premises network and AWS.

It uses virtual interfaces and BGP routing to provide connectivity to supported AWS private or public resources.

It provides more predictable connectivity than relying only on public internet paths.

Production Commands:

```
# Check Direct Connect connections
aws directconnect describe-connections

# Check virtual interfaces
aws directconnect describe-virtual-interfaces

# Check Direct Connect gateways
aws directconnect describe-direct-connect-gateways

# Check VPN connections
aws ec2 describe-vpn-connections
```

Real-Time Scenario: A company's on-premises data center needs private connectivity to applications in AWS VPC. We use Direct Connect with suitable gateways and network routing.

Follow-Up: Difference between Direct Connect and Site-to-Site VPN?

Answer:

- Direct Connect: Dedicated connectivity between on-premises and AWS.
- Site-to-Site VPN: Encrypted IPsec tunnels, commonly established over the internet.

Direct Connect traffic is not automatically encrypted end to end.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

AWS Documentation

+1



### Q13. AWS Direct Connect connection goes down. How do you handle it?

Interview Answer:

First, I check Direct Connect connection status, virtual interface status, and BGP connectivity.

Then I verify whether traffic is using an available redundant Direct Connect connection or configured VPN backup.

I coordinate with the network team to restore the failed connection.

Production Commands:

```
# Check connection status
aws directconnect describe-connections

# Check virtual interfaces
aws directconnect describe-virtual-interfaces

# Check VPN status
aws ec2 describe-vpn-connections

# Check VPC routing
aws ec2 describe-route-tables
```

Real-Time Scenario: The primary Direct Connect circuit fails, and our network routing moves traffic to a configured backup connection.

We verify application connectivity, latency, and packet loss while the network team investigates the failed circuit.

Follow-Up: How do you ensure high availability for Direct Connect?

Answer: Use redundant connections, preferably across different Direct Connect locations, and regularly test failover. AWS also provides a Direct Connect resiliency testing feature.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

AWS Direct Connect

+1



### Q14. Application DNS resolution is failing. How do you troubleshoot?

Interview Answer:

First, I check whether the domain resolves to the expected IP address.

Then I verify DNS records, DNS servers, network connectivity, and recent DNS changes.

For Kubernetes, I also check CoreDNS and Kubernetes Service configuration.

Production Commands:

```
# Check DNS resolution
nslookup payments.example.com

# Check DNS records
dig payments.example.com

# Query a specific DNS resolver
dig @1.1.1.1 payments.example.com

# Check local resolver
cat /etc/resolv.conf

# Check HTTPS connectivity
curl -Iv https://payments.example.com
```

For Kubernetes:

```
kubectl get pods -n kube-system \
  -l k8s-app=kube-dns

kubectl logs deployment/coredns \
  -n kube-system --tail=100
```

Real-Time Scenario: An application becomes unreachable after a DNS record change. I compare the DNS response with the expected load balancer endpoint and correct the configuration if necessary.

### Q15. Your production website's SSL/TLS certificate has expired. What will you do?

Interview Answer:

First, I verify the certificate expiry and identify where TLS is terminated.

Then I check the certificate renewal process and coordinate replacement through AWS ACM or the approved certificate manager.

After replacement, I verify HTTPS connectivity.

Production Commands:

```
# Check HTTPS handshake and certificate
openssl s_client \
  -connect payments.example.com:443 \
  -servername payments.example.com \
  </dev/null

# Check certificate validity dates
echo | openssl s_client \
  -connect payments.example.com:443 \
  -servername payments.example.com 2>/dev/null \
  | openssl x509 -noout -dates

# Check ACM certificates
aws acm list-certificates \
  --region ap-south-1

# Check ALB listeners
aws elbv2 describe-listeners \
  --load-balancer-arn <alb-arn>
```

Real-Time Scenario: Customers receive TLS certificate errors. I verify the ALB listener certificate, replace or renew it through the approved process, and test the application endpoint.

Follow-Up: How do you prevent certificate expiry incidents?

Answer: Configure certificate-expiry monitoring, automated renewal where supported, and alerts well before certificates expire.

### Q16. How do you monitor production availability and configure alerts?

Interview Answer:

We use Prometheus, Grafana, and CloudWatch to monitor availability, latency, errors, CPU, memory, and service health.

We configure alerts based on customer impact and SLO requirements.

Production Commands:

```
# Check Kubernetes health
kubectl get pods -n production

# Check monitoring components
kubectl get pods -n monitoring

# Check CloudWatch alarms
aws cloudwatch describe-alarms \
  --region ap-south-1
```

PromQL – Application Error Rate:

```
sum(rate(http_requests_total{status=~"5.."}[5m]))
/
clamp_min(sum(rate(http_requests_total[5m])), 1e-9)
```

Real-Time Scenario: The production API error rate suddenly increases. An alert notifies the SRE team, and we check the affected service and recent deployments.

Follow-Up: What is Error Budget Burn Rate?

Answer: It measures how quickly the application is consuming its allowed error budget.

If the burn rate is too high, we investigate immediately and may pause risky deployments.

SRE teams can use multiple time windows to reduce alert noise while detecting serious reliability problems.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://sre.google\&sz=32)

Prometheus Alerting: Turn SLOs into Alerts



### Q17. Application pods are healthy, but database connections are failing. How do you troubleshoot?

Interview Answer:

First, I verify database availability and connectivity from the application.

Then I check security groups, DNS, credentials, connection limits, database logs, and connection pool settings.

Production Commands:

```
# Check RDS database status
aws rds describe-db-instances \
  --db-instance-identifier payment-db \
  --region ap-south-1

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=100

# Check application ConfigMaps
kubectl get configmaps -n production
```

From an approved diagnostic container with the necessary tools:

```
# Check DNS
nslookup <rds-endpoint>

# Test database TCP port
nc -vz <rds-endpoint> 5432
```

Real-Time Scenario: Payment Service starts returning HTTP 500 errors because the RDS database reached its maximum connection limit.

I check connection metrics, application connection pools, and recent traffic changes before coordinating the fix.

Follow-Up: Will scaling application pods solve database connection issues?

Answer: Not necessarily. Adding pods can create even more database connections and make the issue worse.

### Q18. You receive a critical production alert at 2 AM. What steps will you follow?

Interview Answer:

First, I acknowledge the alert and check customer impact.

Then I investigate Grafana metrics, logs, Kubernetes resources, and infrastructure health.

I follow the incident runbook, escalate when required, and restore service as quickly as possible.

After recovery, I document the incident and participate in RCA.

Production Commands:

```
# Check application endpoint
curl -Iv https://payments.example.com

# Check nodes and pods
kubectl get nodes
kubectl get pods -n production

# Check logs
kubectl logs deployment/payment-service \
  -n production --tail=200

# Check recent cluster events
kubectl get events -n production \
  --sort-by=.lastTimestamp

# Check deployment
argocd app get payment-prod
```

Real-Time Scenario: An alert reports that the payment API is down at 2 AM. I identify a failed deployment, coordinate rollback, verify service recovery, and update the incident ticket.

### Q19. What is Root Cause Analysis (RCA), and how do you prepare an incident report?

Interview Answer:

RCA is the process of identifying why an incident happened and how to prevent it from happening again.

After resolving the incident, we document the timeline, customer impact, root cause, recovery steps, and preventive actions.

Example RCA Format:

```
Incident       : Payment API Outage
Severity       : SEV1
Impact         : Payment requests failing
Start Time     : 02:00 AM
Recovery Time  : 02:20 AM

Root Cause:
New application release caused
excessive memory usage.

Immediate Fix:
Restored previous stable version.

Preventive Actions:
1. Improve memory monitoring
2. Add performance testing
3. Review memory limits
4. Improve deployment validation
```

Production Commands:

```
# Check deployment history
kubectl rollout history \
  deployment/payment-service \
  -n production

# Check previous logs
kubectl logs <pod-name> \
  -n production --previous

# Check related Kubernetes events
kubectl get events -n production \
  --sort-by=.lastTimestamp
```

Real-Time Scenario: A production deployment caused application containers to crash.

After restoring service, we identify the code change that increased memory usage and add preventive checks to CI/CD.

Follow-Up: What is the difference between RCA and mitigation?

Answer: Mitigation restores the service quickly. RCA identifies the underlying cause and helps prevent future incidents.

### Q20. How do you reduce manual operational work as an SRE?

Interview Answer:

We automate repetitive tasks using Python, Bash, Terraform, Azure DevOps, and cloud automation services.

Examples include infrastructure provisioning, deployment validation, backup checks, log collection, certificate monitoring, and DR testing.

Example Bash Health-Check Script:

```
#!/bin/bash

set -euo pipefail

URL="https://payments.example.com/health"

STATUS=$(curl -s -o /dev/null \
  --connect-timeout 5 \
  --max-time 15 \
  -w "%{http_code}" \
  "$URL")

if [ "$STATUS" = "200" ]; then
    echo "Application is healthy"
else
    echo "Application health check failed: $STATUS"
    exit 1
fi
```

Execute Script:

```
chmod +x health-check.sh

./health-check.sh
```

Real-Time Scenario: Instead of manually opening application URLs after every deployment, Azure DevOps executes automated smoke tests and fails the validation stage if an expected health check fails.

Follow-Up: What is toil in SRE?

Answer: Toil is repetitive, manual operational work that can often be automated and does not provide lasting improvement.

## Bonus: Additional Second-Round SRE Interview Questions

| Interview Question                                      | Short Answer                                                                              |
| ------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| What is MTTR?                                           | Mean Time to Repair or Restore, depending on the team's definition.                       |
| What is MTTD?                                           | Mean Time to Detect an incident.                                                          |
| What is MTBF?                                           | Mean Time Between Failures.                                                               |
| What is a SEV1 incident?                                | A critical incident causing major business impact, based on company severity definitions. |
| What is an on-call rotation?                            | A schedule defining who responds to incidents outside normal working hours.               |
| What is an escalation policy?                           | A process for contacting additional engineers or teams when needed.                       |
| What is a runbook?                                      | Documented steps for troubleshooting and recovery.                                        |
| What is a postmortem?                                   | A review of an incident, its impact, causes, and improvements.                            |
| What is CPU throttling?                                 | CPU execution being limited by configured resource quotas.                                |
| What is swap memory?                                    | Disk-backed memory used by the OS when appropriate.                                       |
| What is an OOM Killer?                                  | A Linux kernel mechanism that terminates processes during memory exhaustion.              |
| What is a zombie process?                               | A terminated process whose parent has not collected its exit status.                      |
| What is a memory leak?                                  | Memory is continuously retained unnecessarily by an application.                          |
| What is connection timeout?                             | A connection could not be established within the allowed time.                            |
| What is a read timeout?                                 | A connection was established, but the expected response took too long.                    |
| What is packet loss?                                    | Network packets fail to reach their destination.                                          |
| What is VPC Flow Logs?                                  | Logs containing metadata about network traffic through supported VPC network interfaces.  |
| What is AWS Transit Gateway?                            | A central routing service connecting VPCs and supported networks.                         |
| What is the difference between NACL and Security Group? | NACL is stateless and subnet-level; Security Group is stateful and resource-level.        |
| What are the Golden Signals?                            | Latency, traffic, errors, and saturation.                                                 |
| What is a canary release?                               | Gradually exposing a new release to part of the traffic.                                  |
| What is a rollback strategy?                            | A defined process to restore a previous stable version after a failed change.             |
| What is capacity planning?                              | Estimating future resources needed to meet performance and availability requirements.     |
| What is chaos engineering?                              | Controlled testing of system behavior during failures.                                    |
| What is a blameless postmortem?                         | Reviewing technical and process failures without focusing on individual blame.            |

## Last-Minute Linux and SRE Command Revision

| Requirement              | Command                           |
| ------------------------ | --------------------------------- |
| Check CPU and processes  | `top`                             |
| Highest CPU processes    | `ps aux --sort=-%cpu \\| head`    |
| Highest memory processes | `ps aux --sort=-%mem \\| head`    |
| Check memory             | `free -h`                         |
| Check filesystem         | `df -h`                           |
| Check inode usage        | `df -i`                           |
| Check directory sizes    | `du -sh /var/log/*`               |
| Check deleted open files | `sudo lsof +L1`                   |
| Check open ports         | `ss -tulnp`                       |
| Check DNS                | `nslookup example.com`            |
| Detailed DNS lookup      | `dig example.com`                 |
| Check HTTP response      | `curl -Iv https://example.com`    |
| Check network route      | `ip route`                        |
| Check server processes   | `ps aux`                          |
| Check systemd service    | `systemctl status <service>`      |
| Check system logs        | `journalctl -xe`                  |
| Check kernel messages    | `dmesg`                           |
| Check CPU statistics     | `mpstat -P ALL 1 5`               |
| Check disk I/O           | `iostat -xz 1 5`                  |
| Check network traffic    | `sudo tcpdump -i <interface> -nn` |

## Most Important   SRE Interview Scenarios

### Scenario 1: Application is down. What will you do?

> First, I acknowledge the alert and check application availability.
>
> Then I review Grafana dashboards, application logs, pod status, and recent deployments.
>
> I identify the root cause and perform an approved mitigation or rollback.
>
> After recovery, I verify application health and participate in RCA.

### Scenario 2: EC2 CPU usage is 100%. What will you do?

> I use `top` and `ps` to identify the process consuming CPU.
>
> Then I check application logs, traffic, resource limits, and recent changes.
>
> Based on the root cause, I optimize the application or increase capacity through the approved process.

### Scenario 3: Application is slow, but CPU and memory are normal. What will you check?

> I check database queries, downstream API calls, network latency, connection pools, and application logs.
>
> I also review distributed tracing if available.
>
> I identify which dependency or operation is causing the delay before making changes.

### Scenario 4: Production fails immediately after a deployment. What is your rollback strategy?

> I check deployment history, application logs, and health status.
>
> If the deployment caused the issue, I restore the last stable application version through GitOps.
>
> Then I verify that application errors and latency return to normal.

End of Section 7 – Advanced SRE Production Scenarios

Covered: 20 detailed interview questions + 25 bonus questions on reliability, Linux troubleshooting, AWS Direct Connect, networking, incidents, monitoring, and RCA.

Next Section 8: SRE Managerial and Project Experience Questions – Explaining Your Previous Company Work, End-to-End Production Ownership, Handling Failures, Why You Changed Jobs, Team Collaboration, and HR Follow-Up Questions.

# X Company – SRE Interview Preparation

## Section 8: Azure and AWS Private Networking

### Subtopic 8.1: Private Endpoints, Private Link, VNet Integration, VPC Endpoints and Internal Resource Communication

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: How Azure and AWS resources communicate internally without using the public internet, private networking configuration, DNS, connectivity, security, and real-time troubleshooting.

### Example Production Environment

```
Azure:
  VNet         : prod-vnet
  AKS          : prod-aks
  Database     : Azure SQL
  Storage      : Azure Blob Storage
  Registry     : Azure Container Registry
  Application  : Azure App Service

AWS:
  VPC          : prod-vpc
  EKS          : prod-eks
  Database     : Amazon RDS
  Storage      : Amazon S3
  Registry     : Amazon ECR
  Compute      : EC2
```

## First, understand the main concept

Interviewer: How do Azure or AWS services communicate internally without using the public internet?

Interview Answer:

> We use private networking features such as VNet or VPC, private IP addresses, private endpoints, internal load balancers, and private DNS.
>
> In Azure, we use Private Link, Private Endpoints, and VNet Integration.
>
> In AWS, we use VPC Endpoints, AWS PrivateLink, and private subnets.
>
> This allows applications to communicate with supported cloud services through private network paths without exposing those services to the public internet.

### How private communication works

Conceptual architecture. Exact connectivity mechanisms differ between Azure and AWS services.

Important: Private resource communication and zero internet access for the entire environment are different requirements. Some tools, such as a self-hosted Azure DevOps agent, may still need controlled outbound HTTPS access to Azure DevOps even when all application and database traffic stays private.

## Part A: Microsoft Azure Private Networking

### Q1. What is Azure Private Endpoint, and how does it work?

Interview Answer:

Azure Private Endpoint provides a private IP address inside our VNet to access supported Azure services such as Storage, Azure SQL, and ACR.

The application connects to the service using that private IP through Azure Private Link, without using the public internet.

Production Architecture:

```
Azure VM / AKS Pod
        |
        v
Azure VNet (10.0.0.0/16)
        |
        v
Private Endpoint (10.0.2.5)
        |
        v
Azure SQL / Storage / ACR
```

Production Commands:

```
# List private endpoints
az network private-endpoint list \
  -g prod-rg -o table

# Check one endpoint
az network private-endpoint show \
  -g prod-rg \
  -n storage-private-endpoint

# Check private DNS resolution
nslookup prodstorage.blob.core.windows.net
```

Real-Time Scenario: Our AKS application needs to access Azure Blob Storage. We configure a Private Endpoint and Private DNS so the application can reach Storage privately.

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

### Q2. How do you configure a Private Endpoint for Azure Blob Storage?

Interview Answer:

First, we create a Private Endpoint for the Storage account in the required VNet and subnet.

Then we configure Private DNS and link it to the VNet.

Finally, we verify that the Storage hostname resolves to a private IP.

Production Commands:

```
# Get existing Storage account resource ID
STORAGE_ID=$(az storage account show \
  -g prod-rg \
  -n prodstorage \
  --query id -o tsv)

# Create Blob private endpoint
az network private-endpoint create \
  -g prod-rg \
  -n storage-private-endpoint \
  --vnet-name prod-vnet \
  --subnet private-endpoints-subnet \
  --private-connection-resource-id "$STORAGE_ID" \
  --group-id blob \
  --connection-name storage-private-connection

# Create private DNS zone
az network private-dns zone create \
  -g prod-rg \
  -n privatelink.blob.core.windows.net

# Link DNS zone to VNet
az network private-dns link vnet create \
  -g prod-rg \
  -n storage-dns-link \
  -z privatelink.blob.core.windows.net \
  -v prod-vnet \
  -e false

# Associate the endpoint with the DNS zone
az network private-endpoint dns-zone-group create \
  -g prod-rg \
  --endpoint-name storage-private-endpoint \
  -n storage-dns-group \
  --private-dns-zone privatelink.blob.core.windows.net \
  --zone-name blob
```

Run these on an approved configuration. Then verify DNS from a VM or pod inside the connected VNet.

Real-Time Scenario: The Storage account is restricted to private connectivity. AKS pods use its normal Storage hostname, which resolves to the private endpoint address.

Important: Creating a Private Endpoint alone does not necessarily disable public access to the Storage account. Configure the Storage networking restrictions separately.

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

### Q3. What is the difference between Private Endpoint and Service Endpoint?

Interview Answer:

Private Endpoint: Provides a private IP in our VNet for a specific Azure resource.

Service Endpoint: Allows a subnet to access supported Azure services securely over the Microsoft backbone, but the service still uses a public IP endpoint.

| Private Endpoint                                            | Service Endpoint                            |
| ----------------------------------------------------------- | ------------------------------------------- |
| Private IP address                                          | Service's public IP address                 |
| Uses Azure Private Link                                     | Uses Microsoft backbone routing             |
| Resource-specific private connectivity                      | Subnet-based service access                 |
| Supports private access from connected on-premises networks | Primarily subnet-based access               |
| Preferred for strict isolation                              | Useful for simpler supported configurations |

Production Commands:

```
# Check Private Endpoints
az network private-endpoint list \
  -g prod-rg -o table

# Check subnet service endpoints
az network vnet subnet show \
  -g prod-rg \
  --vnet-name prod-vnet \
  -n app-subnet \
  --query serviceEndpoints
```

Real-Time Scenario: For a sensitive production Azure SQL database, we use Private Endpoint because we want database access through a private IP address.

Important Interview Point: A Service Endpoint does not turn the Azure service's public endpoint into a private IP.

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

+1

### Q4. How does AKS communicate with Azure SQL without internet access?

Interview Answer:

We create a Private Endpoint for Azure SQL.

Then we configure the Private DNS zone `privatelink.database.windows.net`.

AKS pods resolve the database hostname to its private IP and connect using the required database port.

Production Architecture:

```
AKS Pod (10.0.1.10)
        |
        v
Private DNS Resolution
        |
        v
SQL Private Endpoint (10.0.2.5)
        |
        v
Azure SQL Database
```

Production Commands:

```
# Check SQL private endpoint
az network private-endpoint list \
  -g prod-rg -o table

# Check SQL DNS
nslookup prodsql.database.windows.net

# Test SQL connectivity on port 1433
nc -vz prodsql.database.windows.net 1433

# Check AKS application
kubectl get pods -n production

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=100
```

Real-Time Scenario: Our payment application running in AKS connects to Azure SQL through Private Link instead of the database's public endpoint.

Follow-Up: Is Private Endpoint enough to secure the database?

Answer: No. We also configure database authentication, managed identity where supported, appropriate network access rules, and disable public network access if required.

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

### Q5. How does Azure App Service connect privately to Azure SQL or Storage?

Interview Answer:

We configure VNet Integration for outbound traffic from App Service.

Then we use Private Endpoints for Azure SQL or Storage.

App Service can reach those private resources through the connected VNet.

Production Commands:

```
# Configure App Service VNet Integration
az webapp vnet-integration add \
  -g prod-rg \
  -n payment-webapp \
  --vnet prod-vnet \
  --subnet appservice-integration-subnet

# Check VNet integration
az webapp vnet-integration list \
  -g prod-rg \
  -n payment-webapp
```

Production Architecture:

```
Azure App Service
       |
       v
VNet Integration
       |
       v
Azure VNet
       |
       v
Private Endpoint
       |
       v
Azure SQL / Storage
```

Real-Time Scenario: A web application running in App Service needs to read data from a private Azure SQL database.

We enable VNet Integration and configure the SQL Private Endpoint.

Important: VNet Integration supports outbound private access. It does not make inbound App Service traffic private. For private inbound access to a supported App Service, use a Private Endpoint.

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

### Q6. How does AKS pull images from Azure Container Registry without using the internet?

Interview Answer:

We create a Private Endpoint for Azure Container Registry and configure the correct Private DNS records.

AKS nodes connect to the private registry endpoint to pull images.

We also assign the required image-pull permissions to the AKS identity.

Production Architecture:

```
AKS Worker Node
       |
       v
Private VNet
       |
       v
ACR Private Endpoint
       |
       v
Azure Container Registry
       |
       v
Docker Image Download
```

Production Commands:

```
# Check ACR configuration
az acr show \
  -g prod-rg \
  -n prodacr \
  --query '{loginServer:loginServer,publicAccess:publicNetworkAccess}'

# Check Private Endpoints
az network private-endpoint list \
  -g prod-rg -o table

# Verify registry hostname from a connected VM
nslookup prodacr.azurecr.io

# Check application image-pull errors
kubectl describe pod <pod-name> \
  -n production
```

Real-Time Scenario: We disable public registry access. AKS continues pulling approved container images through the ACR Private Endpoint.

Important: ACR Private Endpoint support requires a compatible registry tier (commonly Premium), configured DNS, and correct registry permissions.

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

### Q7. What is Azure Private DNS, and why is it important?

Interview Answer:

Private DNS resolves service names to private IP addresses.

For example, when an AKS pod requests an Azure Storage endpoint, Private DNS helps it connect to the private endpoint instead of the public endpoint.

Production Commands:

```
# List private DNS zones
az network private-dns zone list \
  -g prod-rg -o table

# Check a zone
az network private-dns zone show \
  -g prod-rg \
  -n privatelink.blob.core.windows.net

# Check linked VNets
az network private-dns link vnet list \
  -g prod-rg \
  -z privatelink.blob.core.windows.net \
  -o table

# Verify from an internal host
nslookup prodstorage.blob.core.windows.net
```

Real-Time Scenario: Our application's connection to Storage fails because DNS resolves to the public endpoint while public access is disabled.

We correct the private DNS zone association and verify private resolution.

### Q8. How do two Azure VNets communicate privately?

Interview Answer:

We use VNet Peering to connect two VNets privately through Microsoft's network.

For example, an application VNet can communicate with a database or shared-services VNet.

We configure peering, routing, NSG rules, and private DNS as needed.

Production Architecture:

```
VNet A – Application
10.0.0.0/16
       |
       v
   VNet Peering
       |
       v
VNet B – Shared Services
10.1.0.0/16
```

Production Commands:

```
# Check VNet peerings
az network vnet peering list \
  -g prod-rg \
  --vnet-name prod-vnet \
  -o table

# Check VNet
az network vnet show \
  -g prod-rg \
  -n prod-vnet

# Check effective routing on a VM NIC
az network nic show-effective-route-table \
  -g prod-rg \
  -n <vm-nic-name>
```

Real-Time Scenario: An AKS cluster in the application VNet needs to reach a private database or service in the shared-services VNet. We configure VNet peering and allow the required connectivity.

Follow-Up: Is VNet peering transitive?

Answer: No, peering is not automatically transitive. For complex hub-and-spoke networks, we use suitable routing and hub connectivity services.

### Q9. What is a private AKS cluster?

Interview Answer:

A private AKS cluster has a private Kubernetes API server endpoint.

This prevents direct public internet access to the cluster API.

We access the cluster from a connected VNet, self-hosted agent, VPN, or ExpressRoute network with appropriate authentication.

Production Commands:

```
# Check AKS API access configuration
az aks show \
  -g prod-rg \
  -n prod-aks \
  --query 'apiServerAccessProfile'

# Connect from an authorized private agent
az aks get-credentials \
  -g prod-rg \
  -n prod-aks

# Verify Kubernetes connection
kubectl get nodes
kubectl get pods -A
```

Real-Time Scenario: Our organization uses private AKS. Azure DevOps deployments run from a self-hosted Linux agent with connectivity to the cluster's private API endpoint.

Important: A private AKS API does not automatically mean AKS nodes have zero outbound internet access. Node egress and other service dependencies require separate configuration.

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

### Q10. Azure DevOps needs to deploy to private AKS. How does it connect?

Interview Answer:

We configure a self-hosted Azure DevOps agent in a VNet that can reach the private AKS API.

The pipeline authenticates using an approved Azure identity and uses kubectl or Helm.

Private DNS and network routing must be configured correctly.

Production Architecture:

```
Azure DevOps Service
       |
       | Outbound HTTPS agent communication
       v
Self-Hosted Agent – Azure VM
       |
       | Private VNet Connectivity
       v
Private AKS API Server
       |
       v
Deploy Application
```

Production Commands:

```
# Check agent service
sudo ./svc.sh status

# Check Azure authentication
az account show

# Connect to AKS
az aks get-credentials \
  -g prod-rg \
  -n prod-aks

# Verify permissions
kubectl auth can-i create deployments \
  -n production

# Verify deployment
kubectl get pods -n production
```

Real-Time Scenario: A Microsoft-hosted agent cannot reach our private AKS API. We use an Azure VM self-hosted agent with the required private networking and DNS configuration.

Important Interview Point: The Azure DevOps agent generally still needs outbound HTTPS to Azure DevOps Services for job coordination. However, communication between the agent and AKS can remain entirely private.

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

## Part B: AWS Private Networking

### Q11. How do AWS services communicate internally without the public internet?

Interview Answer:

In AWS, we use private subnets, VPC networking, private IPs, security groups, and VPC Endpoints.

Resources inside a VPC can communicate using their private IP addresses if routing and security rules allow it.

For supported AWS managed services like S3 and ECR, we configure VPC Endpoints.

Production Architecture:

```
EC2 / EKS in Private Subnet
          |
          v
        AWS VPC
          |
          +---- Private IP → RDS
          |
          +---- VPC Endpoint → S3
          |
          +---- VPC Endpoint → ECR
          |
          +---- VPC Endpoint → Secrets Manager
```

Production Commands:

```
# List VPCs
aws ec2 describe-vpcs

# Check private subnets
aws ec2 describe-subnets

# Check VPC Endpoints
aws ec2 describe-vpc-endpoints

# Check route tables
aws ec2 describe-route-tables
```

Real-Time Scenario: Our EKS application accesses S3 and Secrets Manager privately using VPC Endpoints without requiring a NAT Gateway or internet gateway for those API calls.

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon Virtual Private Cloud

### Q12. What is a VPC Endpoint in AWS?

Interview Answer:

A VPC Endpoint allows resources inside a VPC to access supported AWS services privately.

There are two main types commonly used in production:

1. Gateway Endpoint: Used for S3 and DynamoDB.
2. Interface Endpoint: Uses AWS PrivateLink and private network interfaces for supported services such as ECR, CloudWatch, STS, and Secrets Manager.

Production Commands:

```
# Check all endpoints
aws ec2 describe-vpc-endpoints \
  --region ap-south-1

# Check S3 endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.s3

# Check endpoint types
aws ec2 describe-vpc-endpoints \
  --query 'VpcEndpoints[*].[VpcEndpointId,ServiceName,VpcEndpointType,State]' \
  --output table
```

Real-Time Scenario: Our EC2 instance in a private subnet needs to upload files to S3. We create an S3 Gateway Endpoint and configure the correct route tables.

### Q13. What is the difference between Gateway Endpoint and Interface Endpoint?

Interview Answer:

Gateway Endpoints provide private routing to S3 and DynamoDB.

Interface Endpoints create private network interfaces in the VPC to connect to supported AWS services using PrivateLink.

| Gateway Endpoint                 | Interface Endpoint                               |
| -------------------------------- | ------------------------------------------------ |
| S3, DynamoDB                     | ECR, STS, Secrets Manager, CloudWatch and others |
| Uses route-table entries         | Uses private endpoint network interfaces         |
| No hourly endpoint charge        | Generally hourly and data-processing charges     |
| Route-table-based connectivity   | Security groups and DNS are important            |
| No endpoint private IP in subnet | Private IP addresses in selected subnets         |

Production Commands:

```
aws ec2 describe-vpc-endpoints \
  --query 'VpcEndpoints[*].[ServiceName,VpcEndpointType,State]' \
  --output table
```

Real-Time Scenario: We create an S3 Gateway Endpoint for object storage and an Interface Endpoint for Secrets Manager access.

### Q14. How do you configure an S3 Gateway Endpoint in AWS?

Interview Answer:

First, we identify the VPC and private subnet route tables.

Then we create an S3 Gateway Endpoint and associate it with those route tables.

EC2 instances or EKS nodes can then access S3 through the AWS network without internet access.

Production Commands:

```
# Create S3 Gateway Endpoint
aws ec2 create-vpc-endpoint \
  --vpc-id <vpc-id> \
  --service-name com.amazonaws.ap-south-1.s3 \
  --vpc-endpoint-type Gateway \
  --route-table-ids <private-route-table-id> \
  --region ap-south-1

# Verify endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.s3

# Check S3 connectivity from EC2
aws s3 ls s3://<approved-bucket-name>
```

Real-Time Scenario: Our private EC2 instance uploads backups to S3 through the Gateway Endpoint.

Follow-Up: Do we need a NAT Gateway for this S3 connection?

Answer: No, not when the supported S3 Gateway Endpoint is configured correctly and the client uses the appropriate route and endpoint.

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

AWS CLI 2.37.10 Command Reference

### Q15. How does EKS pull Docker images from ECR without internet access?

Interview Answer:

For a fully private EKS cluster, we configure Interface Endpoints for ECR API and ECR Docker Registry.

We also configure an S3 Gateway Endpoint because ECR image layers are stored in S3.

Worker nodes then pull images without requiring internet access to those AWS services.

Production Architecture:

```
Private EKS Worker Node
          |
          v
     VPC Networking
          |
          +---- ECR API Endpoint
          |
          +---- ECR DKR Endpoint
          |
          +---- S3 Gateway Endpoint
          |
          v
     Container Image Pulled
```

Production Commands:

```
# Check ECR API endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.ecr.api

# Check ECR Docker endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.ecr.dkr

# Check S3 Gateway Endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.s3

# Check image-pull errors
kubectl describe pod <pod-name> \
  -n production
```

Real-Time Scenario: We remove internet egress from the EKS private worker subnets. Pods continue pulling images from ECR because the required VPC Endpoints and permissions are configured.

Important: Interface Endpoint security groups must permit required HTTPS traffic, private DNS must work, and EKS nodes need appropriate ECR permissions. Certain image pull-through cache scenarios can have additional requirements.

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Eksctl User Guide

+1

### Q16. How does an application running on EKS connect to RDS privately?

Interview Answer:

We deploy RDS in private subnets and restrict its network access.

EKS pods communicate with the RDS endpoint through private VPC routing.

We allow the required database port in the RDS security group and use secure database authentication.

Production Architecture:

```
EKS Application Pod
         |
         v
Private VPC Networking
         |
         v
RDS Security Group
         |
         v
Amazon RDS PostgreSQL
Private IP / Private Endpoint
```

Production Commands:

```
# Check RDS endpoint and public access
aws rds describe-db-instances \
  --db-instance-identifier payment-db \
  --query 'DBInstances[0].[Endpoint.Address,PubliclyAccessible]'

# Check Security Groups
aws ec2 describe-security-groups \
  --group-ids <rds-security-group-id>

# Check database DNS from the application network
nslookup <rds-endpoint>

# Check port connectivity
nc -vz <rds-endpoint> 5432
```

Real-Time Scenario: Payment Service runs in EKS and connects to RDS PostgreSQL using its private database endpoint.

Follow-Up: Do we need a VPC Endpoint to connect EKS to RDS?

Answer: Not normally for application database connections inside the same VPC. Those use regular private VPC connectivity. RDS API calls are different from database connections.

### Q17. How do you create an Interface VPC Endpoint for AWS Secrets Manager?

Interview Answer:

We create an Interface Endpoint for Secrets Manager in the VPC and select appropriate private subnets.

We enable private DNS and attach a security group allowing HTTPS access from approved workloads.

Applications can then retrieve secrets privately.

Production Commands:

```
# Create endpoint after network/security approval
aws ec2 create-vpc-endpoint \
  --vpc-id <vpc-id> \
  --vpc-endpoint-type Interface \
  --service-name com.amazonaws.ap-south-1.secretsmanager \
  --subnet-ids <subnet-id-1> <subnet-id-2> \
  --security-group-ids <endpoint-security-group-id> \
  --private-dns-enabled \
  --region ap-south-1

# Verify endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.secretsmanager

# Test permitted secret metadata access
aws secretsmanager describe-secret \
  --secret-id <approved-secret-name> \
  --region ap-south-1
```

Real-Time Scenario: Payment Service retrieves database credentials from Secrets Manager through a private VPC Endpoint instead of using public internet connectivity.

Important: VPC Endpoint connectivity and IAM authentication are separate. The application still needs the correct IAM and secret resource-policy permissions.

### Q18. What is a private EKS cluster, and how does Azure DevOps connect to it?

Interview Answer:

A private EKS cluster has a Kubernetes API endpoint that is accessible only through the VPC or connected private networks.

We can place an Azure DevOps self-hosted agent on an EC2 instance inside the VPC.

The agent uses AWS IAM authentication and accesses the Kubernetes API through the private network.

Production Architecture:

```
Azure DevOps
      |
      | Job coordination over HTTPS
      v
Self-Hosted Agent on EC2
      |
      | AWS IAM Authentication
      v
Private EKS API Endpoint
      |
      v
Kubernetes Deployment
```

Production Commands:

```
# Check EKS endpoint access
aws eks describe-cluster \
  --name prod-eks \
  --query 'cluster.resourcesVpcConfig.[endpointPrivateAccess,endpointPublicAccess]'

# Verify agent IAM identity
aws sts get-caller-identity

# Configure Kubernetes access
aws eks update-kubeconfig \
  --name prod-eks \
  --region ap-south-1

# Check Kubernetes permissions
kubectl auth can-i get deployments \
  -n production

# Verify cluster
kubectl get nodes
```

Real-Time Scenario: Our EKS API is not publicly accessible. The Azure DevOps self-hosted agent runs in the AWS VPC and deploys applications over the private Kubernetes API connection.

Important: The VPC Endpoint for the Amazon EKS management API is different from the private Kubernetes API endpoint of the cluster.

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS

+1

### Q19. How do two AWS VPCs communicate privately?

Interview Answer:

We use VPC Peering or AWS Transit Gateway.

VPC Peering connects two VPCs directly.

Transit Gateway is useful when we need to connect many VPCs through a centralized routing architecture.

Production Architecture:

```
VPC A – Application
10.0.0.0/16
       |
       v
VPC Peering / Transit Gateway
       |
       v
VPC B – Database
10.1.0.0/16
```

Production Commands:

```
# Check VPC Peering
aws ec2 describe-vpc-peering-connections

# Check Transit Gateways
aws ec2 describe-transit-gateways

# Check Transit Gateway attachments
aws ec2 describe-transit-gateway-vpc-attachments

# Check VPC route tables
aws ec2 describe-route-tables
```

Real-Time Scenario: An EKS application runs in one VPC while a shared database runs in another VPC.

We configure VPC Peering or Transit Gateway and allow the necessary routes and security group rules.

Follow-Up: Is VPC Peering transitive?

Answer: No. If VPC A peers with B and B peers with C, A does not automatically communicate with C through B.

### Q20. Private AWS or Azure connectivity is failing. How do you troubleshoot?

Interview Answer:

First, I check DNS resolution to confirm whether the destination resolves to the expected private IP.

Then I verify the private endpoint status, network routing, NSGs or security groups, firewall rules, and access permissions.

I also test the target port from the source VM or application pod.

Azure Commands:

```
# Check private endpoints
az network private-endpoint list \
  -g prod-rg -o table

# Check private DNS links
az network private-dns link vnet list \
  -g prod-rg \
  -z privatelink.database.windows.net \
  -o table

# Check NSG rules
az network nsg list \
  -g prod-rg -o table

# Check DNS and SQL port
nslookup prodsql.database.windows.net
nc -vz prodsql.database.windows.net 1433
```

AWS Commands:

```
# Check VPC Endpoints
aws ec2 describe-vpc-endpoints

# Check route tables
aws ec2 describe-route-tables

# Check Security Groups
aws ec2 describe-security-groups \
  --group-ids <security-group-id>

# Check DNS
nslookup <private-service-hostname>

# Test database connectivity
nc -vz <rds-endpoint> 5432
```

Real-Time Scenario: AKS cannot connect to Azure SQL after public access is disabled. We find that DNS still resolves to the public IP. We fix the Private DNS configuration and verify access.

Follow-Up: What if DNS resolves correctly but the connection times out?

Answer: I check routing, NSG or security group rules, firewalls, target listening ports, and service health.

Follow-Up: What if networking works but the application gets 403 or AccessDenied?

Answer: I check authentication, IAM or Azure RBAC, resource-level permissions, and application credentials. Network connectivity does not automatically grant authorization.

## Bonus: Additional Second-Round Private Networking Questions

| Interview Question                                               | Short Answer                                                                                                                                               |
| ---------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Can two Azure VMs in the same VNet communicate without internet? | Yes, using private IP routing, subject to NSGs and other network rules.                                                                                    |
| Can two EC2 instances communicate without an internet gateway?   | Yes, using private VPC connectivity.                                                                                                                       |
| What is Azure Private Link?                                      | A service that enables private access to supported resources.                                                                                              |
| What is Azure Private Link Service?                              | A feature for privately exposing your own service to consumers through Private Endpoints.                                                                  |
| What is VNet Integration?                                        | Enables supported services, such as App Service, to access resources through a VNet.                                                                       |
| Does VNet Integration provide private inbound access?            | No. Inbound private access requires an appropriate separate mechanism.                                                                                     |
| What is Azure Private DNS?                                       | Resolves internal resource names and Private Endpoint hostnames.                                                                                           |
| What is AWS Route 53 Private Hosted Zone?                        | A DNS zone whose records are resolved through associated VPCs and compatible private resolver paths.                                                       |
| Is VNet Peering transitive?                                      | No, not automatically.                                                                                                                                     |
| Is VPC Peering transitive?                                       | No.                                                                                                                                                        |
| Can an AKS pod access Azure Key Vault privately?                 | Yes, with a Key Vault Private Endpoint, working DNS, and appropriate identity permissions.                                                                 |
| Can AKS access Event Hubs privately?                             | Yes, through supported Event Hubs private networking with the required DNS and access permissions.                                                         |
| Can an EKS pod call AWS Secrets Manager without NAT?             | Yes, using the appropriate Interface VPC Endpoint.                                                                                                         |
| Can private EKS pull ECR images without NAT?                     | Yes, with required ECR and S3 endpoints, DNS, and permissions.                                                                                             |
| What is the difference between NAT Gateway and VPC Endpoint?     | NAT provides outbound connectivity to destinations reached through the internet path; VPC Endpoints enable private connectivity to supported AWS services. |
| Can Azure and AWS communicate privately?                         | Yes, through suitable dedicated connectivity providers linking ExpressRoute and Direct Connect, with compatible routing.                                   |
| Does a site-to-site VPN avoid using the public internet?         | It encrypts traffic, but a typical internet-based VPN still traverses the public internet.                                                                 |
| Can a service be private but still require authentication?       | Yes. Network access and identity authorization are separate requirements.                                                                                  |

## Azure vs AWS – Important Interview Comparison

| Requirement                        | Azure                                           | AWS                                             |
| ---------------------------------- | ----------------------------------------------- | ----------------------------------------------- |
| Private network                    | VNet                                            | VPC                                             |
| Private subnets                    | VNet subnets with controlled routing            | VPC private subnets                             |
| Private managed-service access     | Private Endpoint / Private Link                 | Interface VPC Endpoint / PrivateLink            |
| Private object storage access      | Blob Storage Private Endpoint                   | S3 Gateway Endpoint                             |
| Private database access            | Azure SQL Private Endpoint                      | Private RDS endpoint in VPC                     |
| Private Kubernetes API             | Private AKS                                     | Private EKS endpoint                            |
| Private DNS                        | Azure Private DNS                               | Route 53 Private Hosted Zone / Resolver         |
| Connect two virtual networks       | VNet Peering                                    | VPC Peering                                     |
| Connect many networks              | Azure Virtual WAN / hub routing                 | Transit Gateway                                 |
| Dedicated on-premises connectivity | ExpressRoute                                    | Direct Connect                                  |
| Network access filtering           | NSG / Azure Firewall                            | Security Groups / NACLs                         |
| Outbound internet connectivity     | NAT Gateway / Azure Firewall                    | NAT Gateway                                     |
| CI/CD to private Kubernetes        | Self-hosted agent with private AKS connectivity | Self-hosted agent with private EKS connectivity |

## Last-Minute Commands – Azure

```
# Check VNets
az network vnet list -o table

# Check private endpoints
az network private-endpoint list \
  -g prod-rg -o table

# Check Private DNS
az network private-dns zone list \
  -g prod-rg -o table

# Check VNet Peering
az network vnet peering list \
  -g prod-rg \
  --vnet-name prod-vnet -o table

# Check AKS API configuration
az aks show \
  -g prod-rg -n prod-aks \
  --query apiServerAccessProfile

# Check Storage networking
az storage account show \
  -g prod-rg -n prodstorage \
  --query networkRuleSet

# Check Service connectivity
nslookup prodsql.database.windows.net
nc -vz prodsql.database.windows.net 1433
```

## Last-Minute Commands – AWS

```
# Check VPC
aws ec2 describe-vpcs

# Check VPC Endpoints
aws ec2 describe-vpc-endpoints

# Check Route Tables
aws ec2 describe-route-tables

# Check Security Groups
aws ec2 describe-security-groups

# Check VPC Peering
aws ec2 describe-vpc-peering-connections

# Check Transit Gateway
aws ec2 describe-transit-gateways

# Check EKS API endpoint
aws eks describe-cluster \
  --name prod-eks \
  --query cluster.resourcesVpcConfig

# Check RDS public access setting
aws rds describe-db-instances \
  --db-instance-identifier payment-db \
  --query 'DBInstances[0].PubliclyAccessible'

# Check Secrets Manager VPC Endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.secretsmanager
```

## Most Important Interview Question 1

Interviewer: In Azure, your AKS application needs to connect to Azure SQL, Storage and ACR, but public internet connectivity is restricted. How will you configure it?

Suggested Answer:

> First, I configure the required Private Endpoints for Azure SQL, Blob Storage, and ACR.
>
> Then I configure Private DNS zones and link them to the AKS VNet.
>
> I verify that the service hostnames resolve to private IP addresses.
>
> After that, I check NSG rules, routing, and the required Azure identity permissions.
>
> Finally, I test database connections, Storage access, and container image pulling from AKS.
>
> Once everything is working, we can restrict public access to those services according to our security requirements.

## Most Important Interview Question 2

Interviewer: In AWS, your EKS cluster is in private subnets without internet access. How will applications access ECR, S3, RDS and Secrets Manager?

Suggested Answer:

> For ECR, I configure Interface VPC Endpoints for ECR API and ECR Docker Registry, along with an S3 Gateway Endpoint for downloading image layers.
>
> For S3, I use a Gateway VPC Endpoint.
>
> For RDS, the application connects through private VPC networking using the database's private endpoint and security group rules.
>
> For Secrets Manager, I configure an Interface VPC Endpoint.
>
> I also verify private DNS, IAM permissions, security groups, and routing.
>
> This allows the application to communicate with those AWS services without requiring public internet access.

## Most Important Interview Question 3

Interviewer: If the private endpoint is already configured but communication is still failing, how will you debug it?

Suggested Answer:

> First, I check DNS resolution to confirm that the resource hostname resolves to the expected private IP.
>
> Then I check the Private Endpoint or VPC Endpoint status.
>
> Next, I verify routing, security groups or NSGs, network policies, and destination ports.
>
> I use `nslookup`, `nc`, and service-specific commands to test connectivity.
>
> If network connectivity works but I receive AccessDenied, I check IAM or Azure RBAC permissions.
>
> After correcting the root cause, I test the application connection again.

End of Section 8 – Azure and AWS Private Networking

Covered: 20 detailed questions + 18 bonus questions, including private Azure SQL, Storage, ACR, AKS, App Service, AWS VPC Endpoints, EKS, ECR, RDS, and private DNS.

Next recommended topic: Advanced Azure Networking and Integration – Azure Event Hubs, Event Grid, Storage Queues, Service Bus, Key Vault, Managed Identity, Application Gateway, Internal Load Balancer and private AKS application integration.

# X Company – SRE Interview Preparation

## Section 8: Azure and AWS Private Networking

### Subtopic 8.2: Advanced Azure Integration – Event Hubs, Event Grid, Service Bus, Storage Queues, Key Vault and Internal Networking

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: Azure integration services, private communication, Managed Identity, internal load balancers, Application Gateway, Azure DevOps, and production troubleshooting.

### Example Production Environment

```
Cloud          : Microsoft Azure
Resource Group : prod-rg
VNet           : prod-vnet
Kubernetes     : prod-aks
Application    : payment-service
Database       : Azure SQL
Storage        : Azure Blob + Storage Queue
Messaging      : Event Hubs / Event Grid / Service Bus
Secrets        : Azure Key Vault
CI/CD          : Azure DevOps
Monitoring     : Azure Monitor + Grafana
```

## First, understand Azure integration services

| Azure Service          | Main Purpose                         | Example                              |
| ---------------------- | ------------------------------------ | ------------------------------------ |
| Event Hubs             | High-volume event streaming          | Application logs, telemetry          |
| Event Grid             | Event notifications and routing      | Trigger processing after file upload |
| Storage Queue          | Simple asynchronous processing       | Background file-processing jobs      |
| Service Bus            | Reliable enterprise messaging        | Payment/order processing             |
| Key Vault              | Secure secrets, keys, certificates   | Database credentials                 |
| Private Endpoint       | Private access to supported services | AKS to Azure SQL                     |
| Managed Identity       | Passwordless Azure authentication    | AKS to Key Vault                     |
| Application Gateway    | Layer 7 HTTP/HTTPS routing           | Internal application gateway         |
| Internal Load Balancer | Private network load balancing       | Internal AKS microservices           |

The key distinction is Event Hubs handles streams, Event Grid routes events, and Service Bus handles reliable business messages.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



## Part A: Azure Event Hubs

### Q1. What is Azure Event Hubs, and how does it work?

Interview Answer:

Azure Event Hubs is a managed event-streaming service.

It receives large volumes of events from applications and allows consumers to process them.

We use it for application telemetry, streaming data, audit events, and real-time analytics.

Architecture:

```
AKS Application
      |
      v
Event Hubs Namespace
      |
      v
Event Hub (Partitions)
      |
      v
Consumer Application
      |
      v
Monitoring / Data Processing
```

Production Commands:

```
# List Event Hubs namespaces
az eventhubs namespace list \
  -g prod-rg -o table

# List Event Hubs
az eventhubs eventhub list \
  -g prod-rg \
  --namespace-name prod-eventhub-ns \
  -o table

# Check Event Hub configuration
az eventhubs eventhub show \
  -g prod-rg \
  --namespace-name prod-eventhub-ns \
  --name payment-events
```

Real-Time Scenario: Payment Service produces transaction events. Event Hubs receives the events, and a consumer application processes them for analytics.

### Q2. How does AKS connect to Azure Event Hubs without public internet access?

Interview Answer:

We configure a Private Endpoint for the Event Hubs namespace.

Then we create the Private DNS zone and link it to the AKS VNet.

AKS applications connect to Event Hubs using the normal namespace hostname, which resolves to a private IP.

Architecture:

```
AKS Pod
   |
   v
Azure VNet
   |
   v
Private DNS
   |
   v
Event Hubs Private Endpoint
   |
   v
Event Hubs Namespace
```

Production Commands:

```
# Check Event Hubs private endpoint connections
az eventhubs namespace private-endpoint-connection list \
  -g prod-rg \
  --namespace-name prod-eventhub-ns

# Check private endpoints
az network private-endpoint list \
  -g prod-rg -o table

# Check private DNS zones
az network private-dns zone list \
  -g prod-rg -o table

# Test DNS from connected network
nslookup prod-eventhub-ns.servicebus.windows.net

# Test Event Hubs AMQP/TLS connectivity
nc -vz prod-eventhub-ns.servicebus.windows.net 5671
```

Real-Time Scenario: Public network access is disabled for Event Hubs. An AKS application still publishes events through the namespace's Private Endpoint.

Important: Event Hubs private links are supported in Standard, Premium, and Dedicated tiers, not Basic. The usual private DNS zone is `privatelink.servicebus.windows.net`.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q3. What are partitions and consumer groups in Event Hubs?

Interview Answer:

Partitions divide incoming event streams so multiple consumers can process data in parallel.

Consumer groups allow different applications to read the same event stream independently.

Within each partition, events maintain their relative order.

Production Commands:

```
# Check partitions
az eventhubs eventhub show \
  -g prod-rg \
  --namespace-name prod-eventhub-ns \
  --name payment-events \
  --query partitionCount

# Check consumer groups
az eventhubs eventhub consumer-group list \
  -g prod-rg \
  --namespace-name prod-eventhub-ns \
  --eventhub-name payment-events \
  -o table
```

Real-Time Scenario: One consumer group processes events for billing analytics, while another independently processes events for operational reporting.

Follow-Up: What happens when consumers exceed partition count?

Answer: Within the same coordinated consumer group, additional consumers may remain idle because only one active owner processes a particular partition at a time.

### Q4. Event Hubs messages are delayed. How do you troubleshoot?

Interview Answer:

First, I check incoming and outgoing messages, throttling, consumer lag, and processing errors.

Then I check partitions, throughput capacity, application logs, and network connectivity.

Production Commands:

```
# Check Event Hub details
az eventhubs eventhub show \
  -g prod-rg \
  --namespace-name prod-eventhub-ns \
  --name payment-events

# Check Azure Monitor metrics available
az monitor metrics list-definitions \
  --resource <eventhubs-namespace-resource-id>

# Check AKS consumer logs
kubectl logs deployment/event-consumer \
  -n production --tail=100
```

Real-Time Scenario: Incoming events increase, but consumers cannot keep up. We check consumer lag and processing capacity before increasing consumer resources or changing partition/throughput configuration.

## Part B: Azure Event Grid

### Q5. What is Azure Event Grid, and how is it different from Event Hubs?

Interview Answer:

Event Grid routes notifications when something happens in an Azure service.

For example, when a file is uploaded to Blob Storage, Event Grid can notify a subscriber.

Event Hubs is mainly used to stream and process large volumes of event data.

Architecture:

```
Blob Storage
     |
     | Blob Created Event
     v
Azure Event Grid
     |
     v
Event Subscriber
     |
     v
File Processing Application
```

Production Commands:

```
# List custom Event Grid topics
az eventgrid topic list \
  -g prod-rg -o table

# List Event Grid domains
az eventgrid domain list \
  -g prod-rg -o table

# List event subscriptions for a resource
az eventgrid event-subscription list \
  --source-resource-id <source-resource-id> \
  -o table
```

Real-Time Scenario: Whenever a document is uploaded to Azure Blob Storage, Event Grid generates a notification that triggers the document-processing workflow.

Follow-Up: Can we use Event Grid for large continuous data streaming?

Answer: Event Hubs is generally more suitable for high-volume event streaming. Event Grid is mainly for reacting to discrete events.

### Q6. Can Event Grid communicate with private AKS applications without using the public internet?

Interview Answer:

Yes, but it depends on the delivery method.

Event Grid namespaces support private endpoints for publishing events and pulling events.

However, Event Grid push delivery does not directly deliver events into a private-only webhook over Private Link.

Private Pull Architecture:

```
AKS Application
      |
      | Private Endpoint
      v
Event Grid Namespace
      |
      | Pull Events
      v
AKS Consumer Processes Events
```

Production Commands:

```
# List Event Grid namespaces
az eventgrid namespace list \
  -g prod-rg -o table

# Check private endpoints
az network private-endpoint list \
  -g prod-rg -o table

# Check network resolution from an AKS diagnostic pod
nslookup <eventgrid-namespace-hostname>

# Check consumer application
kubectl logs deployment/event-consumer \
  -n production --tail=100
```

Real-Time Scenario: Our AKS application needs to receive events while remaining private. We use Event Grid namespace pull delivery through a Private Endpoint, rather than expecting Event Grid to push directly to a private-only webhook.

Important Interview Point: Private publishing/pull support does not mean private push delivery is supported.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

+1



### Q7. An Event Grid event subscription is not delivering events. How do you troubleshoot?

Interview Answer:

First, I check the event subscription, delivery destination, filters, and endpoint authentication.

Then I check delivery failures, retry settings, dead-letter configuration, and monitoring metrics.

Production Commands:

```
# Check event subscriptions
az eventgrid event-subscription list \
  --source-resource-id <source-resource-id> \
  -o table

# Check specific subscription
az eventgrid event-subscription show \
  --name payment-event-subscription \
  --source-resource-id <source-resource-id>

# Check available Event Grid metrics
az monitor metrics list-definitions \
  --resource <source-resource-id>
```

Real-Time Scenario: Blob upload events stop reaching the processing application because an event subscription destination was changed.

I review the event subscription configuration and delivery failures, correct the destination, and test with a new event.

Follow-Up: Does Event Grid guarantee that every event is delivered exactly once?

Answer: No. Consumers should handle duplicates, and delivery behavior depends on the configured Event Grid feature and destination.

## Part C: Azure Storage Queues and Service Bus

### Q8. What is Azure Storage Queue, and when do we use it?

Interview Answer:

Azure Storage Queue stores messages for asynchronous processing.

An application adds messages to the queue, and background workers read and process them.

This helps separate the main application from time-consuming operations.

Architecture:

```
Payment API
     |
     v
Azure Storage Queue
     |
     v
AKS Worker Pod
     |
     v
Background Processing
```

Production Commands:

```
# List Storage queues using authorized identity
az storage queue list \
  --account-name prodstorage \
  --auth-mode login \
  -o table

# Create a queue
az storage queue create \
  --account-name prodstorage \
  --name payment-processing \
  --auth-mode login

# Check queue properties
az storage queue metadata show \
  --account-name prodstorage \
  --name payment-processing \
  --auth-mode login
```

Real-Time Scenario: An API receives a payment-related processing request. Instead of completing every background operation immediately, it adds a message to Storage Queue. An AKS worker processes the message asynchronously.

Important: The caller needs a suitable Storage Queue data role, such as Storage Queue Data Contributor for operations that require it.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q9. How does AKS access Azure Storage Queue privately?

Interview Answer:

We configure a Private Endpoint for the queue subresource of the Storage account.

Then we configure the Private DNS zone `privatelink.queue.core.windows.net` and link it to the AKS VNet.

AKS applications access the queue through private networking and authenticate using an approved identity.

Production Commands:

```
# Check Storage Private Endpoints
az network private-endpoint list \
  -g prod-rg -o table

# Check Queue private DNS zone
az network private-dns zone show \
  -g prod-rg \
  -n privatelink.queue.core.windows.net

# Check DNS from AKS network
nslookup prodstorage.queue.core.windows.net

# Check HTTPS connectivity
nc -vz prodstorage.queue.core.windows.net 443
```

Real-Time Scenario: Our AKS background worker needs to consume queue messages, but Storage public access is disabled. The worker connects through the Queue Private Endpoint.

Important: Blob and Queue use separate private endpoint subresources. A Blob Private Endpoint alone is not enough for Queue access.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q10. What is the difference between Azure Storage Queue and Azure Service Bus?

Interview Answer:

Azure Storage Queue is useful for simple asynchronous background processing.

Azure Service Bus supports more advanced enterprise messaging, including queues, topics, subscriptions, duplicate detection, dead-lettering, and sessions where supported.

| Storage Queue                   | Service Bus                                 |
| ------------------------------- | ------------------------------------------- |
| Simple queueing                 | Advanced enterprise messaging               |
| Part of Azure Storage           | Dedicated messaging service                 |
| Background jobs                 | Business workflows                          |
| Basic queue processing          | Dead-lettering and richer delivery controls |
| Simple point-to-point workloads | Queues and publish-subscribe topics         |

Production Commands:

```
# Storage queues
az storage queue list \
  --account-name prodstorage \
  --auth-mode login -o table

# Service Bus queues
az servicebus queue list \
  -g prod-rg \
  --namespace-name prod-servicebus \
  -o table
```

Real-Time Scenario: For processing uploaded images, we can use Storage Queue. For complex order workflows requiring dead-letter queues and duplicate detection, we may use Service Bus.

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

### Q11. How does Azure Service Bus communicate with private AKS applications?

Interview Answer:

We use a Service Bus Premium namespace with a Private Endpoint.

We configure Private DNS, the required messaging ports, and Managed Identity permissions.

AKS applications can then send and receive messages privately.

Architecture:

```
AKS Payment API
       |
       v
Service Bus Private Endpoint
       |
       v
Service Bus Queue
       |
       v
AKS Worker Application
```

Production Commands:

```
# Check Service Bus namespace
az servicebus namespace show \
  -g prod-rg \
  -n prod-servicebus

# Check private endpoint connections
az servicebus namespace private-endpoint-connection list \
  -g prod-rg \
  --namespace-name prod-servicebus

# Check messaging DNS
nslookup prod-servicebus.servicebus.windows.net

# Test AMQP over TLS
nc -vz prod-servicebus.servicebus.windows.net 5671

# Test HTTPS connectivity
nc -vz prod-servicebus.servicebus.windows.net 443
```

Real-Time Scenario: Payment Service sends messages to Service Bus, and AKS worker pods consume them without using public internet connectivity.

Important: Azure Service Bus Private Link requires the Premium tier. Ports depend on the client transport, such as AMQP over TLS or AMQP over WebSockets.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q12. Service Bus queue messages are not being processed. What will you check?

Interview Answer:

First, I check active message count, dead-letter messages, consumer pod status, and application logs.

Then I verify authentication, network connectivity, message locks, and processing failures.

Production Commands:

```
# Check queue runtime properties
az servicebus queue show \
  -g prod-rg \
  --namespace-name prod-servicebus \
  -n payment-queue

# Check consumers
kubectl get pods -n production

# Check worker logs
kubectl logs deployment/payment-worker \
  -n production --tail=200

# Check private connectivity
nc -vz prod-servicebus.servicebus.windows.net 5671
```

Real-Time Scenario: Service Bus messages continue increasing because the worker pods cannot authenticate.

I identify the missing Service Bus Data Receiver permission, correct the approved role assignment, and verify that message processing resumes.

Follow-Up: What is a Dead-Letter Queue (DLQ)?

Answer: It stores messages that cannot be processed normally, such as messages exceeding the maximum delivery count, so engineers can investigate and reprocess them safely.

## Part D: Azure Key Vault and Managed Identity

### Q13. How does AKS access Azure Key Vault without using the public internet?

Interview Answer:

We create a Private Endpoint for Key Vault and configure Private DNS.

For authentication, we use Microsoft Entra Workload Identity or another supported managed identity approach.

The application can securely access secrets without hardcoding credentials.

Architecture:

```
AKS Application Pod
        |
        | Workload Identity
        v
Microsoft Entra Authentication
        |
        v
Key Vault Private Endpoint
        |
        v
Azure Key Vault
```

Production Commands:

```
# Check Key Vault networking
az keyvault show \
  -g prod-rg \
  -n prod-payment-kv \
  --query properties.networkAcls

# Check Private Endpoint
az network private-endpoint list \
  -g prod-rg -o table

# Check private DNS
nslookup prod-payment-kv.vault.azure.net

# Verify secrets metadata if authorized
az keyvault secret list \
  --vault-name prod-payment-kv \
  --query '[].name' -o table
```

Real-Time Scenario: Payment Service needs database credentials stored in Azure Key Vault. We configure private connectivity and workload identity so the pod accesses those secrets securely.

Important: Key Vault private access and Entra authentication are separate. Entra token acquisition also requires a supported identity and network setup.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q14. What is Azure Managed Identity, and how do you configure Workload Identity in AKS?

Interview Answer:

Managed Identity allows Azure applications to authenticate to Azure services without storing passwords or client secrets.

In AKS, Microsoft Entra Workload Identity allows a Kubernetes ServiceAccount to use a federated Azure identity.

Production Commands:

```
# Check whether AKS has Workload Identity enabled
az aks show \
  -g prod-rg \
  -n prod-aks \
  --query '{oidc:oidcIssuerProfile,workload:securityProfile.workloadIdentity}'

# Enable on existing cluster after approval
az aks update \
  -g prod-rg \
  -n prod-aks \
  --enable-oidc-issuer \
  --enable-workload-identity

# Check user-assigned identities
az identity list \
  -g prod-rg -o table
```

Example Kubernetes ServiceAccount:

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: payment-workload-sa
  namespace: production
  annotations:
    azure.workload.identity/client-id: "<managed-identity-client-id>"
```

Example Pod Configuration:

```
spec:
  serviceAccountName: payment-workload-sa
  template:
    metadata:
      labels:
        azure.workload.identity/use: "true"
```

The `template` structure above is for a Deployment's pod template, not a standalone Pod. A complete Deployment places `serviceAccountName` inside `spec.template.spec`.

We also create a federated identity credential linking the AKS OIDC issuer, namespace, and ServiceAccount to the managed identity.

Real-Time Scenario: Payment Service uses Workload Identity to request tokens for Key Vault without storing an Azure client secret in the container.

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

### Q15. AKS can reach Key Vault, but the application receives 403 Forbidden. What will you do?

Interview Answer:

A 403 error can mean authentication succeeded, but the identity does not have permission to perform the requested Key Vault operation.

I check the workload identity configuration, Key Vault access model, role assignments, and application logs.

Production Commands:

```
# Check Key Vault authorization model
az keyvault show \
  -g prod-rg \
  -n prod-payment-kv \
  --query properties.enableRbacAuthorization

# Get Key Vault resource ID
KV_ID=$(az keyvault show \
  -g prod-rg \
  -n prod-payment-kv \
  --query id -o tsv)

# Check Azure role assignments
az role assignment list \
  --scope "$KV_ID" \
  -o table

# Check Kubernetes ServiceAccount
kubectl describe serviceaccount payment-workload-sa \
  -n production

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=100
```

Real-Time Scenario: The pod can resolve Key Vault's private IP, but retrieving a secret fails.

We find that the application identity lacks the Key Vault Secrets User role. After an authorized role assignment, we verify secret access.

Follow-Up: What is the difference between a network issue and an RBAC issue?

Answer: A network issue normally causes DNS, connection, or timeout failures. A permission issue commonly returns an authorization error such as 403, though some Azure services also use 403 for network access restrictions.

## Part E: Application Gateway and Internal Load Balancers

### Q16. What is Azure Application Gateway, and how does it integrate with AKS?

Interview Answer:

Azure Application Gateway is a Layer 7 HTTP/HTTPS load balancer.

It supports routing based on URLs and hostnames, TLS termination, health checks, and Web Application Firewall when using the appropriate SKU.

It can provide an entry point to applications running in AKS.

Architecture:

```
Internal Company Users
         |
         v
Private Application Gateway
         |
         v
Internal AKS Ingress
         |
         v
AKS Services
         |
         v
Application Pods
```

Production Commands:

```
# List Application Gateways
az network application-gateway list \
  -g prod-rg -o table

# Check backend health
az network application-gateway show-backend-health \
  -g prod-rg \
  -n prod-app-gateway

# Check AKS Ingress
kubectl get ingress -n production

# Check application Services
kubectl get svc -n production
```

Real-Time Scenario: Our company runs an internal payment administration application. We expose it only through a private Application Gateway and route requests to AKS.

Important: Application Gateway v2 supports private-only frontend configurations. This is different from Application Gateway for Containers, which has separate capabilities.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q17. How do you create an internal LoadBalancer Service in AKS?

Interview Answer:

We use a Kubernetes Service with type `LoadBalancer` and the Azure internal load balancer annotation.

Azure provisions a load balancer with a private frontend IP address.

That service can be accessed from networks with appropriate private connectivity.

Example YAML:

```
apiVersion: v1
kind: Service
metadata:
  name: payment-internal
  namespace: production
  annotations:
    service.beta.kubernetes.io/azure-load-balancer-internal: "true"
spec:
  type: LoadBalancer
  selector:
    app: payment-service
  ports:
    - port: 80
      targetPort: 8080
      protocol: TCP
```

Production Commands:

```
# Apply reviewed Service configuration
kubectl apply -f payment-internal-lb.yaml

# Check Service
kubectl get svc payment-internal \
  -n production

# Check detailed Service events
kubectl describe svc payment-internal \
  -n production

# Test from a VM with private network connectivity
curl http://<internal-load-balancer-ip>/health
```

Real-Time Scenario: Another application inside the company network needs to communicate with Payment Service. We expose Payment Service through an internal Azure Load Balancer instead of a public IP.

Important: Kubernetes may display the private IP under `EXTERNAL-IP`, but that does not mean the endpoint is internet-accessible.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q18. An internal AKS application is not accessible through Application Gateway. How do you troubleshoot?

Interview Answer:

First, I check Application Gateway backend health.

Then I verify the internal load balancer, Kubernetes Ingress, Service endpoints, health probes, NSGs, and DNS.

I also check whether the backend is listening on the expected port.

Production Commands:

```
# Check Application Gateway backend health
az network application-gateway show-backend-health \
  -g prod-rg \
  -n prod-app-gateway

# Check AKS internal LoadBalancer
kubectl get svc -n production

# Check Ingress
kubectl describe ingress payment-ingress \
  -n production

# Check Service endpoints
kubectl get endpointslices -n production

# Check pods
kubectl get pods -n production

# Test private endpoint
curl -v http://<internal-load-balancer-ip>/health
```

Real-Time Scenario: Application Gateway reports an Unhealthy backend because the health probe uses `/`, but the application returns a successful response only on `/health`.

I correct the health probe configuration and verify that the backend becomes healthy.

Follow-Up: What is the difference between Application Gateway and Azure Load Balancer?

Answer: Application Gateway operates at Layer 7 and supports HTTP/HTTPS routing. Azure Load Balancer works at Layer 4 using TCP/UDP flows.

## Part F: End-to-End Azure Integration and Production Troubleshooting

### Q19. How does Azure DevOps deploy applications that use private Azure services?

Interview Answer:

We configure a self-hosted Azure DevOps agent with network connectivity to the private AKS API.

The pipeline uses a service connection for Azure authentication and deploys applications through kubectl, Helm, or GitOps.

The deployed applications use private endpoints and managed identities to access Azure services.

Architecture:

```
Azure DevOps Pipeline
         |
         v
Self-Hosted Agent
         |
         v
Private AKS Cluster
         |
         +---- Private Endpoint → Azure SQL
         |
         +---- Private Endpoint → Event Hubs
         |
         +---- Private Endpoint → Key Vault
         |
         +---- Private Endpoint → Storage Queue
```

Production Commands:

```
# Check Azure authentication
az account show

# Connect to AKS from authorized agent
az aks get-credentials \
  -g prod-rg \
  -n prod-aks

# Check Kubernetes access
kubectl auth can-i create deployments \
  -n production

# Check deployments
kubectl get deployments -n production

# Check connectivity to Event Hubs
nslookup prod-eventhub-ns.servicebus.windows.net
```

Real-Time Scenario: Azure DevOps deploys Payment Service to private AKS. The application then accesses Event Hubs, Storage Queues, and Key Vault through private networking.

Important: The agent usually still needs controlled outbound HTTPS connectivity to Azure DevOps Services for receiving pipeline jobs. Private AKS communication does not eliminate this requirement.

### Q20. Explain an end-to-end Azure architecture where all application services communicate privately.

Interview Answer:

We deploy applications in a private AKS cluster inside a VNet.

We configure Private Endpoints for Azure SQL, Event Hubs, Storage, Service Bus, and Key Vault where required.

We use Private DNS for name resolution and Managed Identity for secure authentication.

We expose internal applications using private load balancing or an internal Application Gateway.

Complete Architecture:

```
       Company Network / VPN / ExpressRoute
                      |
                      v
           Private Application Gateway
                      |
                      v
             AKS Internal Ingress
                      |
                      v
              Payment Service
                      |
        +-------------+-------------+
        |             |             |
        v             v             v
   Azure SQL     Service Bus      Key Vault
 Private Link   Private Link    Private Link
        |
        |       Background Worker
        |             |
        |             v
        |        Storage Queue
        |        Private Link
        |
        +------ Event Hubs
                Private Link

Azure DevOps
    |
    v
Self-Hosted Agent
    |
    v
Private AKS Deployment
```

All application-to-managed-service paths shown use private networking. The CI/CD control-plane connection and Entra identity endpoints must be handled separately.

Production Verification Commands:

```
# Check AKS nodes
kubectl get nodes

# Check application
kubectl get pods -n production

# Verify Private Endpoints
az network private-endpoint list \
  -g prod-rg -o table

# Verify private DNS zones
az network private-dns zone list \
  -g prod-rg -o table

# Check network resolution
nslookup prodsql.database.windows.net
nslookup prodstorage.queue.core.windows.net
nslookup prod-eventhub-ns.servicebus.windows.net
nslookup prod-payment-kv.vault.azure.net

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=100
```

Real-Time Scenario: Payment Service processes requests in AKS, stores transactions in Azure SQL, sends background tasks to Service Bus, retrieves credentials from Key Vault, and publishes telemetry to Event Hubs. All these connections use their approved private network paths.

Follow-Up: What if one service is not communicating?

Answer: I check DNS resolution, the private endpoint connection state, subnet routing, NSGs, destination port, managed identity permissions, and application logs.

## Bonus: Additional Second-Round Azure Interview Questions

| Question                                                                  | Short Interview Answer                                                                                    |
| ------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| What is Event Hubs?                                                       | A high-volume event streaming service.                                                                    |
| What is Event Grid?                                                       | An event routing and notification service.                                                                |
| What is Service Bus?                                                      | A reliable enterprise messaging service.                                                                  |
| What is Storage Queue?                                                    | A simple asynchronous message queue.                                                                      |
| What is an Event Hub partition?                                           | A section of the event stream that supports parallel processing and ordered events within that partition. |
| What is an Event Hubs consumer group?                                     | An independent view of an event stream for a consuming application.                                       |
| Can Event Hubs use Private Endpoint?                                      | Yes, with supported tiers.                                                                                |
| Can Event Grid push directly to a private-only webhook over Private Link? | No; consider Event Grid namespace pull delivery for private consumption.                                  |
| What is Service Bus DLQ?                                                  | A queue for messages that cannot be processed normally.                                                   |
| What is Peek-Lock in Service Bus?                                         | A message is locked while a consumer processes it and later completed or abandoned.                       |
| What is Managed Identity?                                                 | Azure-managed identity used to access resources without storing passwords.                                |
| What is Workload Identity in AKS?                                         | Federating a Kubernetes ServiceAccount with a Microsoft Entra identity.                                   |
| What is a Private Endpoint?                                               | A private IP interface for accessing a supported Azure resource.                                          |
| What is Private DNS?                                                      | Name resolution used to reach private addresses.                                                          |
| What is Application Gateway?                                              | An HTTP/HTTPS Layer 7 load balancer.                                                                      |
| What is an Internal Load Balancer?                                        | A load balancer that uses a private frontend IP address.                                                  |
| What is the difference between 403 and timeout?                           | 403 usually indicates denied access; timeout often points to connectivity or service response problems.   |
| Does private connectivity replace RBAC?                                   | No. Network access and identity permissions are separate.                                                 |
| What is Azure NAT Gateway?                                                | A managed service providing outbound internet connectivity from associated subnets.                       |
| Can Azure App Service access private services?                            | Yes, through VNet Integration and the required private routing/DNS configuration.                         |

## Last-Minute Azure Integration Commands

```
# Event Hubs
az eventhubs namespace list -g prod-rg -o table

az eventhubs eventhub list \
  -g prod-rg \
  --namespace-name prod-eventhub-ns

# Event Grid
az eventgrid topic list -g prod-rg -o table

az eventgrid event-subscription list \
  --source-resource-id <source-resource-id>

# Service Bus
az servicebus queue list \
  -g prod-rg \
  --namespace-name prod-servicebus

# Azure Storage Queue
az storage queue list \
  --account-name prodstorage \
  --auth-mode login

# Key Vault
az keyvault show \
  -g prod-rg -n prod-payment-kv

# Managed Identity
az identity list -g prod-rg -o table

# Private Endpoints
az network private-endpoint list \
  -g prod-rg -o table

# Private DNS
az network private-dns zone list \
  -g prod-rg -o table

# Application Gateway
az network application-gateway show-backend-health \
  -g prod-rg \
  -n prod-app-gateway

# AKS Internal Load Balancer
kubectl get svc -n production

# Application Logs
kubectl logs deployment/payment-service \
  -n production --tail=100
```

## Three Most Important Interview Answers

### Interviewer: How does AKS communicate with Event Hubs, Key Vault, and Storage Queue without internet?

> We configure Private Endpoints for these services and link the required Private DNS zones with the AKS VNet.
>
> AKS applications resolve the service hostnames to private IP addresses and communicate through Azure's private network.
>
> We use Workload Identity or another approved managed identity approach for authentication.
>
> Finally, we verify private DNS, network rules, service permissions, and application connectivity.

### Interviewer: An AKS application cannot consume messages from Service Bus. What will you check?

> First, I check the application logs and Service Bus queue status.
>
> Then I verify the private endpoint, DNS resolution, and AMQP network connectivity.
>
> I also check the Managed Identity and Service Bus Data Receiver permission.
>
> Finally, I verify message locks, dead-letter messages, and consumer processing errors.

### Interviewer: How would you design a completely private Azure application architecture?

> I use a private AKS cluster, Private Endpoints for Azure managed services, and Private DNS for name resolution.
>
> I configure Managed Identity for authentication and restrict access using NSGs, RBAC, and service-level network rules.
>
> For internal user traffic, I use an internal load balancer or private Application Gateway.
>
> I deploy using a self-hosted Azure DevOps agent that can reach the private cluster, while separately managing the outbound connectivity required by the agent and identity services.

End of Subtopic 8.2 – Advanced Azure Integration

Covered: 20 detailed interview questions + 20 bonus questions covering Event Hubs, Event Grid, Storage Queues, Service Bus, Key Vault, Managed Identity, Workload Identity, Application Gateway, private AKS, and production troubleshooting.

Next Section 9: Azure DevOps and Azure Infrastructure Real-Time Failures – Private AKS Deployment Failures, Terraform State Issues, Azure RBAC, Managed Identity Errors, Event Hub Connectivity, VNet Routing, NSG, Azure Firewall, and End-to-End Production Incidents.

# X Company – SRE Interview Preparation

## Section 8: AWS and EKS Private Networking

### Subtopic 8.3: Advanced AWS Integration – SQS, SNS, EventBridge, Kinesis, S3, Secrets Manager, Pod Identity and Internal Load Balancers

Level: Second Round – SRE / DevOps (5 Years Experience)

Coverage: 20 production interview questions, practical AWS commands, EKS integrations, private connectivity, IAM security, and real-time troubleshooting.

### Example Production Environment

```
Cloud          : AWS
Region         : ap-south-1 (Mumbai)
Cluster        : prod-eks
VPC            : prod-vpc
Namespace      : production
Application    : payment-service
Streaming      : Amazon Kinesis
Messaging      : Amazon SQS / SNS / EventBridge
Database       : Amazon RDS PostgreSQL
Storage        : Amazon S3 / DynamoDB
Secrets        : AWS Secrets Manager
CI/CD          : Azure DevOps + Argo CD
Monitoring     : CloudWatch + Prometheus + Grafana
```

## First, understand AWS integration services

| AWS Service             | Main Purpose                       | Example                             |
| ----------------------- | ---------------------------------- | ----------------------------------- |
| Amazon SQS              | Message queue                      | Background order processing         |
| Amazon SNS              | Publish-subscribe notifications    | Notify multiple applications        |
| Amazon EventBridge      | Event routing                      | Trigger workflows when events occur |
| Amazon Kinesis          | Real-time data streaming           | Transaction analytics, telemetry    |
| Amazon S3               | Object storage                     | Reports, files, backups             |
| Amazon DynamoDB         | NoSQL database                     | Fast key-value lookups              |
| AWS Secrets Manager     | Secure secret storage              | Database credentials                |
| EKS Pod Identity / IRSA | Pod-level AWS authentication       | EKS pod accessing S3                |
| AWS PrivateLink         | Private service connectivity       | EKS to SQS without NAT              |
| Internal ALB / NLB      | Private application load balancing | Internal microservice APIs          |

## How AWS resources communicate without public internet

```
               AWS VPC – Private Network
                          |
                EKS Application Pod
                          |
          +---------------+----------------+
          |               |                |
          v               v                v
   VPC Endpoints    Private VPC        Internal ALB
          |          Routing              |
    +-----+-----+       |             Internal APIs
    |     |     |       v
    v     v     v      RDS
   SQS   SNS  Secrets
              Manager
    |
    +--- EventBridge / Kinesis (Interface Endpoints)
    |
    +--- S3 / DynamoDB (Gateway Endpoints)
```

Interview Answer:

> We deploy EKS worker nodes in private subnets and configure VPC Endpoints for supported AWS services.
>
> For services such as SQS, SNS, Secrets Manager, EventBridge, and Kinesis, we use Interface VPC Endpoints.
>
> For S3 and DynamoDB, we commonly use Gateway VPC Endpoints.
>
> For RDS and internal applications, we use private VPC networking with the required security group rules.
>
> We also use EKS Pod Identity or IRSA to provide IAM permissions without storing access keys in pods.

AWS documents these configurations for clusters operating with restricted internet connectivity.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



## Part A: AWS Messaging and Integration

### Q1. What is Amazon SQS, and how does it integrate with EKS?

Interview Answer:

Amazon SQS is a managed message queue service.

Our EKS application sends messages to a queue, and worker pods consume them asynchronously.

This helps prevent long-running background tasks from slowing down the main application.

Architecture:

```
Payment API Pod
       |
       v
   Amazon SQS
       |
       v
Worker Application Pod
       |
       v
Process Payment Task
```

Production Commands:

```
# List SQS queues
aws sqs list-queues \
  --region ap-south-1

# Check queue attributes
aws sqs get-queue-attributes \
  --queue-url <queue-url> \
  --attribute-names All \
  --region ap-south-1

# Check worker pods
kubectl get pods -n production

# Check worker logs
kubectl logs deployment/payment-worker \
  -n production --tail=100
```

Real-Time Scenario: Payment Service receives a request and sends a message to SQS. The payment worker processes the request asynchronously.

Follow-Up: What is the difference between Standard and FIFO queues?

Answer: Standard queues support high throughput with at-least-once delivery and best-effort ordering. FIFO queues support ordering within message groups and deduplication.

### Q2. How does an EKS pod connect to Amazon SQS without internet access?

Interview Answer:

We create an Interface VPC Endpoint for SQS in the EKS VPC.

We select private subnets, configure the endpoint security group, and enable Private DNS.

The application accesses SQS using the AWS SDK and its assigned IAM role.

Production Architecture:

```
EKS Pod
   |
   v
Private VPC
   |
   v
SQS Interface Endpoint
   |
   v
Amazon SQS Queue
```

Production Commands:

```
# Create an SQS Interface Endpoint
aws ec2 create-vpc-endpoint \
  --vpc-id <vpc-id> \
  --vpc-endpoint-type Interface \
  --service-name com.amazonaws.ap-south-1.sqs \
  --subnet-ids <subnet-1> <subnet-2> \
  --security-group-ids <endpoint-sg-id> \
  --private-dns-enabled \
  --region ap-south-1

# Verify endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.sqs \
  --region ap-south-1

# Verify SQS access from an authorized pod
aws sqs get-queue-attributes \
  --queue-url <queue-url> \
  --attribute-names ApproximateNumberOfMessages
```

Run the last command inside a suitably equipped, authorized pod to test the actual workload network and identity.

Real-Time Scenario: Our EKS nodes have no NAT Gateway. Payment Service can still publish and receive SQS messages because an SQS Interface Endpoint is configured.

Important: Endpoint security groups must allow HTTPS (TCP 443), and the pod must have appropriate IAM and queue-policy permissions.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon Simple Queue Service



### Q3. SQS messages are accumulating, but the EKS worker is not processing them. What will you do?

Interview Answer:

First, I check the queue message count and worker pod health.

Then I check worker logs, IAM permissions, network connectivity, visibility timeout, and dead-letter queue configuration.

I also check whether worker capacity is sufficient.

Production Commands:

```
# Check pending messages
aws sqs get-queue-attributes \
  --queue-url <queue-url> \
  --attribute-names \
    ApproximateNumberOfMessages \
    ApproximateNumberOfMessagesNotVisible

# Check worker pods
kubectl get pods -n production \
  -l app=payment-worker

# Check worker logs
kubectl logs deployment/payment-worker \
  -n production --tail=200

# Check worker replicas
kubectl get deployment payment-worker \
  -n production

# Check SQS endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.sqs
```

Real-Time Scenario: SQS backlog increases because the worker deployment has insufficient replicas. After checking processing performance, we scale the worker capacity and verify that the backlog decreases.

Follow-Up: What is SQS visibility timeout?

Answer: When a consumer receives a message, SQS temporarily hides it from other consumers. The consumer must delete the message after successful processing; otherwise, it can become visible again.

### Q4. What is Amazon SNS, and how is it different from SQS?

Interview Answer:

SNS is a publish-subscribe messaging service.

SQS is a queue where consumers retrieve messages.

SNS can send a message to multiple subscribers, including separate SQS queues.

Architecture:

```
Payment Application
        |
        v
     SNS Topic
        |
   +----+----+
   |         |
   v         v
Billing SQS  Audit SQS
   |         |
   v         v
Worker A   Worker B
```

Production Commands:

```
# List SNS topics
aws sns list-topics \
  --region ap-south-1

# List subscriptions for a topic
aws sns list-subscriptions-by-topic \
  --topic-arn <topic-arn> \
  --region ap-south-1

# List queues
aws sqs list-queues \
  --region ap-south-1
```

Real-Time Scenario: A payment-completed event must be processed by billing and audit applications. SNS publishes the event to separate SQS queues so each application can process it independently.

Follow-Up: Can SNS publish privately from EKS?

Answer: Yes. We configure an SNS Interface VPC Endpoint, enable Private DNS, and assign the appropriate IAM permissions.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon Simple Notification Service



### Q5. How do you configure private SNS connectivity and troubleshoot publishing failures?

Interview Answer:

We create an SNS Interface Endpoint in our VPC.

Then we configure the endpoint security group, Private DNS, IAM permissions, and topic access policy.

If publishing fails, I check connectivity and authorization separately.

Production Commands:

```
# Create SNS endpoint
aws ec2 create-vpc-endpoint \
  --vpc-id <vpc-id> \
  --vpc-endpoint-type Interface \
  --service-name com.amazonaws.ap-south-1.sns \
  --subnet-ids <subnet-1> <subnet-2> \
  --security-group-ids <endpoint-sg-id> \
  --private-dns-enabled

# Check endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.sns

# Publish a test message to an approved test topic
aws sns publish \
  --topic-arn <test-topic-arn> \
  --message "Private SNS connectivity test"
```

Real-Time Scenario: An EKS pod receives an AccessDenied error when publishing to SNS. I check the pod IAM role and SNS topic resource policy.

Important: An SNS VPC Endpoint makes publishing to SNS private. It does not let SNS directly subscribe to an arbitrary private IP address.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon Simple Notification Service



### Q6. What is Amazon EventBridge, and how does it integrate with EKS?

Interview Answer:

Amazon EventBridge receives events and routes them to configured targets based on rules.

We use it to connect AWS services and applications without tightly coupling them.

For example, an EKS application publishes an event, and EventBridge routes it to SQS or another supported target.

Architecture:

```
EKS Payment Service
       |
       v
   EventBridge
       |
   Event Rule
       |
       v
   Amazon SQS
       |
       v
EKS Worker Service
```

Production Commands:

```
# List event buses
aws events list-event-buses \
  --region ap-south-1

# List event rules
aws events list-rules \
  --region ap-south-1

# Check targets
aws events list-targets-by-rule \
  --rule payment-events-rule \
  --region ap-south-1

# Check EventBridge endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.events
```

Real-Time Scenario: Payment Service publishes a transaction event to EventBridge. A configured rule routes matching events to an SQS queue for downstream processing.

Important: EventBridge supports Interface VPC Endpoints for private publishing. Different EventBridge API families may use different endpoint service names.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EventBridge



### Q7. EventBridge is receiving events, but the target SQS queue has no messages. What will you check?

Interview Answer:

I check whether the EventBridge rule is enabled and whether the event matches the rule pattern.

Then I verify the rule target, SQS resource policy, delivery errors, and monitoring metrics.

Production Commands:

```
# Check EventBridge rule
aws events describe-rule \
  --name payment-events-rule

# Check rule targets
aws events list-targets-by-rule \
  --rule payment-events-rule

# Check queue policy
aws sqs get-queue-attributes \
  --queue-url <queue-url> \
  --attribute-names Policy

# Check queue message count
aws sqs get-queue-attributes \
  --queue-url <queue-url> \
  --attribute-names ApproximateNumberOfMessages
```

Real-Time Scenario: The event rule exists, but its event pattern does not match the application's published event.

We correct the pattern through the approved infrastructure configuration and verify delivery.

Follow-Up: Does creating an SQS VPC Endpoint make EventBridge-to-SQS delivery private?

Answer: The endpoint is for SQS API access from resources inside the VPC. EventBridge-to-SQS delivery is a service-to-service integration controlled by EventBridge rules and SQS permissions.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EventBridge



### Q8. What is Amazon Kinesis, and how does it work with EKS?

Interview Answer:

Amazon Kinesis Data Streams is used for real-time streaming data.

Applications send records to a stream, and consumer applications process those records.

It is useful for logs, real-time analytics, telemetry, and event processing.

Architecture:

```
EKS Producer Pods
        |
        v
Kinesis Data Stream
        |
   Stream Shards
        |
        v
EKS Consumer Pods
        |
        v
Data Processing
```

Production Commands:

```
# List Kinesis streams
aws kinesis list-streams \
  --region ap-south-1

# Check stream details
aws kinesis describe-stream-summary \
  --stream-name payment-events \
  --region ap-south-1

# List stream shards
aws kinesis list-shards \
  --stream-name payment-events \
  --region ap-south-1

# Check consumer application
kubectl logs deployment/kinesis-consumer \
  -n production --tail=100
```

Real-Time Scenario: Our payment application publishes transaction events to Kinesis. Consumer pods process those records for real-time reporting.

### Q9. How do you connect EKS to Kinesis privately, and what if consumers fall behind?

Interview Answer:

We use a Kinesis Interface VPC Endpoint for private connectivity.

If consumers are falling behind, I check consumer lag, incoming records, stream capacity, throttling, and application performance.

Production Commands:

```
# Check Kinesis VPC Endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.kinesis-streams

# Check stream capacity
aws kinesis describe-stream-summary \
  --stream-name payment-events

# List available Kinesis metrics
aws cloudwatch list-metrics \
  --namespace AWS/Kinesis

# Check consumer pods
kubectl get pods -n production \
  -l app=kinesis-consumer

# Check logs
kubectl logs deployment/kinesis-consumer \
  -n production --tail=200
```

Real-Time Scenario: Stream traffic increases, but consumers cannot process records quickly enough. We check lag and processing capacity, and scale or optimize consumers based on the stream's shard configuration.

Follow-Up: What is a Kinesis shard?

Answer: A shard is a unit of stream capacity and ordered record processing. It determines how stream records are partitioned and consumed.

Kinesis Data Streams supports Interface VPC Endpoints for private access.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon Kinesis Data Streams



## Part B: AWS Storage, Database and Secrets

### Q10. How does EKS access S3 or DynamoDB without a NAT Gateway?

Interview Answer:

We create Gateway VPC Endpoints for S3 and DynamoDB.

We associate these endpoints with the route tables used by the EKS worker node subnets.

Our applications then access the services using AWS SDKs and the required IAM permissions.

Architecture:

```
EKS Pod
   |
   v
VPC Private Routing
   |
   +---- S3 Gateway Endpoint → S3
   |
   +---- DynamoDB Gateway Endpoint → DynamoDB
```

Production Commands:

```
# Check S3 and DynamoDB Gateway Endpoints
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=vpc-id,Values=<vpc-id> \
  --query 'VpcEndpoints[*].[ServiceName,VpcEndpointType,State]' \
  --output table

# Create S3 Gateway Endpoint
aws ec2 create-vpc-endpoint \
  --vpc-id <vpc-id> \
  --vpc-endpoint-type Gateway \
  --service-name com.amazonaws.ap-south-1.s3 \
  --route-table-ids <private-route-table-id>

# Create DynamoDB Gateway Endpoint
aws ec2 create-vpc-endpoint \
  --vpc-id <vpc-id> \
  --vpc-endpoint-type Gateway \
  --service-name com.amazonaws.ap-south-1.dynamodb \
  --route-table-ids <private-route-table-id>
```

Real-Time Scenario: Payment Service stores generated reports in S3 and reads configuration from DynamoDB, using Gateway Endpoints instead of an internet path.

Important: Gateway Endpoints are Region-specific and require correct route-table associations. Applications still need IAM access. AWS also supports Interface Endpoints for some of these services, but Gateway Endpoints are common for same-region S3 and DynamoDB access.

### Q11. How do you restrict an S3 bucket so it can be accessed only through a VPC Endpoint?

Interview Answer:

We can use an S3 bucket policy that restricts requests based on the VPC Endpoint ID.

This helps prevent access through unapproved network paths, even when the identity has S3 permissions.

Example Bucket Policy Condition:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyOutsideApprovedEndpoint",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::example-payment-private",
        "arn:aws:s3:::example-payment-private/*"
      ],
      "Condition": {
        "StringNotEquals": {
          "aws:SourceVpce": "vpce-0123456789abcdef0"
        }
      }
    }
  ]
}
```

Production Commands:

```
# Read existing bucket policy
aws s3api get-bucket-policy \
  --bucket example-payment-private

# Check configured S3 endpoint
aws ec2 describe-vpc-endpoints \
  --vpc-endpoint-ids vpce-0123456789abcdef0

# Test from approved EKS or EC2 environment
aws s3 ls s3://example-payment-private
```

Real-Time Scenario: Our security requirement is that the application's S3 bucket can only be accessed through an approved VPC Endpoint.

We implement and test the bucket policy before enforcing it.

Important: A blanket deny based on `aws:SourceVpce` can block console access, backup services, and other AWS service integrations. Production policies need carefully reviewed exceptions where appropriate, and a verified recovery path.

### Q12. How does an EKS application connect to Amazon RDS privately?

Interview Answer:

We place RDS in private subnets and disable public access.

The EKS application connects using the RDS endpoint, which resolves to a private address.

We configure security group rules to allow the database port from authorized application workloads.

Architecture:

```
Payment Service Pod
       |
       v
Private VPC Routing
       |
       v
RDS Security Group
       |
       v
RDS PostgreSQL
```

Production Commands:

```
# Check RDS endpoint and public accessibility
aws rds describe-db-instances \
  --db-instance-identifier payment-db \
  --query 'DBInstances[0].[Endpoint.Address,PubliclyAccessible]'

# Check database security group
aws ec2 describe-security-groups \
  --group-ids <rds-security-group-id>

# Check RDS endpoint DNS
nslookup <rds-endpoint>

# Test PostgreSQL port
nc -vz <rds-endpoint> 5432
```

Real-Time Scenario: Payment Service connects to PostgreSQL on RDS using private VPC networking. The database security group allows only the required application traffic.

Follow-Up: Do we need a VPC Endpoint for the actual RDS database connection?

Answer: No, not for ordinary private connectivity to an RDS instance in the same VPC. Database traffic uses private routing; RDS management APIs are separate.

### Q13. How do you connect EKS to AWS Secrets Manager privately?

Interview Answer:

We create a Secrets Manager Interface VPC Endpoint.

Then we configure Private DNS, endpoint security groups, and an IAM role for the application.

The application retrieves secrets using the AWS SDK or the Secrets Store CSI Driver.

Architecture:

```
EKS Payment Pod
      |
      v
Pod Identity / IRSA
      |
      v
Secrets Manager VPC Endpoint
      |
      v
AWS Secrets Manager
```

Production Commands:

```
# Check Secrets Manager endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.secretsmanager

# Check secret metadata without exposing its value
aws secretsmanager describe-secret \
  --secret-id prod/payment/database

# Check EKS Secrets Store CSI resources
kubectl get secretproviderclasses -A

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=100
```

Real-Time Scenario: Payment Service needs database credentials. It retrieves the secret using its assigned IAM identity and the private Secrets Manager endpoint.

Follow-Up: Can we mount AWS Secrets Manager secrets as files inside EKS pods?

Answer: Yes. We can use the Secrets Store CSI Driver with the AWS Secrets and Configuration Provider (ASCP), when supported by the cluster configuration.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

AWS Secrets Manager



## Part C: EKS IAM and Security

### Q14. How do you give AWS permissions to EKS pods without storing access keys?

Interview Answer:

We use EKS Pod Identity or IAM Roles for Service Accounts (IRSA).

These mechanisms allow applications to receive temporary AWS credentials through an assigned IAM role.

We avoid storing static AWS access keys in Kubernetes Secrets or application code.

### Example – EKS Pod Identity

Step 1: Create the Kubernetes ServiceAccount.

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: payment-service-sa
  namespace: production
```

Step 2: Create an IAM role with an appropriate trust policy.

Example trust policy:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "pods.eks.amazonaws.com"
      },
      "Action": [
        "sts:AssumeRole",
        "sts:TagSession"
      ]
    }
  ]
}
```

Attach the minimum required IAM permissions, for example access to a specific SQS queue.

Step 3: Associate the role with the ServiceAccount.

```
aws eks create-pod-identity-association \
  --cluster-name prod-eks \
  --namespace production \
  --service-account payment-service-sa \
  --role-arn <pod-iam-role-arn>
```

Step 4: Reference the ServiceAccount in the Deployment.

```
spec:
  template:
    spec:
      serviceAccountName: payment-service-sa
      containers:
        - name: payment-service
          image: <approved-image-uri>
```

Step 5: Verify the configuration.

```
# List Pod Identity associations
aws eks list-pod-identity-associations \
  --cluster-name prod-eks \
  --namespace production

# Check ServiceAccount
kubectl get serviceaccount payment-service-sa \
  -n production

# Check Pod Identity Agent
kubectl get daemonset eks-pod-identity-agent \
  -n kube-system
```

Real-Time Scenario: Payment Service needs to send messages to a particular SQS queue.

We associate a dedicated IAM role with its ServiceAccount and grant only the required SQS permissions.

Important: The Pod Identity Agent must be installed, the IAM trust policy must be correct, and supported AWS SDK versions must be used. EKS Pod Identity does not require an IAM role annotation on the ServiceAccount.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS

+1



### Q15. What is the difference between EKS Pod Identity and IRSA?

Interview Answer:

Both allow EKS pods to access AWS services using IAM roles.

IRSA uses a Kubernetes ServiceAccount annotation and IAM OIDC federation through AWS STS.

EKS Pod Identity uses an EKS Pod Identity association and the Pod Identity Agent.

| EKS Pod Identity                      | IRSA                                        |
| ------------------------------------- | ------------------------------------------- |
| Uses Pod Identity Agent               | Uses OIDC federation                        |
| Role mapped using EKS association     | Role mapped using ServiceAccount annotation |
| Uses EKS Auth API                     | Uses STS AssumeRoleWithWebIdentity          |
| Simplifies IAM association management | Common in existing EKS environments         |

Production Commands:

```
# Check Pod Identity associations
aws eks list-pod-identity-associations \
  --cluster-name prod-eks

# Check IRSA ServiceAccount configuration
kubectl get serviceaccount \
  -n production -o yaml

# Check Pod Identity Agent
kubectl get pods -n kube-system \
  -l app.kubernetes.io/name=eks-pod-identity-agent

# Check STS VPC Endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.sts
```

Real-Time Scenario: Our existing EKS applications use IRSA. For a new compatible workload, we may choose EKS Pod Identity to simplify pod-level IAM association management.

Follow-Up: What extra configuration is required in a fully private cluster?

Answer: IRSA normally needs a private STS endpoint and regional STS configuration. EKS Pod Identity requires access to the EKS Auth API through the `eks-auth` VPC Endpoint.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS

+1



### Q16. How does a fully private EKS cluster pull Docker images from ECR?

Interview Answer:

We configure Interface VPC Endpoints for the ECR API and Docker Registry.

We also configure an S3 Gateway Endpoint because ECR image layers are stored in S3.

We verify endpoint security groups, Private DNS, and worker-node image-pull permissions.

Production Commands:

```
# Check ECR API endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.ecr.api

# Check ECR Docker endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.ecr.dkr

# Check S3 Gateway Endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.s3

# Check image-pull failure
kubectl describe pod <pod-name> \
  -n production

# Check node image-pull errors
kubectl get events -n production \
  --sort-by=.lastTimestamp
```

Real-Time Scenario: EKS application pods show ImagePullBackOff after internet egress is disabled.

We discover that the ECR Docker endpoint or S3 Gateway Endpoint is missing. After fixing connectivity, the image pull succeeds.

Important: Image pull-through cache setups and external registries can require additional networking.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS



## Part D: Internal Load Balancers and Private APIs

### Q17. How do you expose EKS applications internally using ALB or NLB?

Interview Answer:

We use an internal Application Load Balancer for HTTP/HTTPS routing.

For TCP/UDP or Layer 4 routing, we can use an internal Network Load Balancer.

Both can expose applications privately to authorized networks without providing an internet-facing endpoint.

Example Internal ALB Ingress:

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: payment-internal-ingress
  namespace: production
  annotations:
    alb.ingress.kubernetes.io/scheme: internal
    alb.ingress.kubernetes.io/target-type: ip
spec:
  ingressClassName: alb
  rules:
    - http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: payment-service
                port:
                  number: 80
```

This assumes AWS Load Balancer Controller is installed and configured.

Example Internal NLB Service using AWS Load Balancer Controller:

```
apiVersion: v1
kind: Service
metadata:
  name: payment-internal-nlb
  namespace: production
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "external"
    service.beta.kubernetes.io/aws-load-balancer-scheme: "internal"
    service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: "ip"
spec:
  type: LoadBalancer
  selector:
    app: payment-service
  ports:
    - port: 80
      targetPort: 8080
```

Production Commands:

```
# Check Ingress
kubectl get ingress -n production

# Check Kubernetes Services
kubectl get svc -n production

# Check load balancers
aws elbv2 describe-load-balancers

# Check targets
aws elbv2 describe-target-health \
  --target-group-arn <target-group-arn>
```

Real-Time Scenario: Payment Service must be accessible only to other internal applications.

We create an internal ALB in private subnets and allow access from authorized application networks.

Important: EKS Auto Mode and AWS Load Balancer Controller support different Service configuration options. The NLB YAML above is intended for AWS Load Balancer Controller.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon EKS

+1



### Q18. What is AWS Private API Gateway, and how does EKS access it?

Interview Answer:

A Private API Gateway REST API is accessible through an API Gateway Interface VPC Endpoint.

An EKS application inside the connected VPC can call the private API without going through the public internet.

We restrict access using API resource policies, endpoint policies, and authentication.

Architecture:

```
EKS Application Pod
        |
        v
API Gateway Interface Endpoint
        |
        v
Private API Gateway REST API
        |
        v
Backend Integration
```

Production Commands:

```
# Check API Gateway endpoints
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.execute-api

# List API Gateway REST APIs
aws apigateway get-rest-apis \
  --region ap-south-1

# Check API configuration
aws apigateway get-rest-api \
  --rest-api-id <api-id> \
  --region ap-south-1

# Test approved private API from inside the VPC
curl -v https://<private-api-hostname>/<stage>/health
```

Real-Time Scenario: Our internal EKS application needs to call a private API used by another service.

We configure the API Gateway VPC Endpoint, appropriate access policies, and private DNS.

Important: Private API Gateway endpoint types apply to REST APIs. An API Gateway private integration to an internal ALB is a different feature and may use VPC Link.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Amazon API Gateway

+1



### Q19. How does Azure DevOps deploy applications to a private EKS cluster?

Interview Answer:

We configure a self-hosted Azure DevOps agent on an AWS EC2 instance inside the VPC.

The agent uses an approved IAM role, AWS CLI, and kubectl to connect to the private EKS API.

After authentication and authorization, the pipeline deploys Kubernetes manifests or Helm charts.

Architecture:

```
Azure DevOps Pipeline
       |
       v
Self-Hosted EC2 Agent
       |
       | AWS IAM Role
       v
Private EKS API Endpoint
       |
       v
Kubernetes Deployment
       |
       v
Payment Service Pods
```

Production Commands:

```
# Verify agent AWS role
aws sts get-caller-identity

# Check EKS endpoint access configuration
aws eks describe-cluster \
  --name prod-eks \
  --query cluster.resourcesVpcConfig

# Configure kubeconfig
aws eks update-kubeconfig \
  --name prod-eks \
  --region ap-south-1

# Check Kubernetes authorization
kubectl auth can-i create deployments \
  -n production

# Check application rollout
kubectl rollout status \
  deployment/payment-service \
  -n production
```

Real-Time Scenario: Azure DevOps builds the Docker image, pushes it to ECR, and then deploys an approved image version to a private EKS cluster.

Follow-Up: Does the self-hosted agent require internet?

Answer: The agent normally needs outbound HTTPS connectivity to Azure DevOps Services for job coordination. However, its EKS API communication can remain private.

### Q20. How do two AWS VPCs communicate privately, and what if the database is in another VPC?

Interview Answer:

We use VPC Peering or AWS Transit Gateway to connect VPCs.

We configure the required route tables, security groups, DNS resolution, and network rules.

This allows an application in one VPC to connect to an RDS database in another VPC without using the public internet.

Architecture:

```
VPC A – EKS
10.0.0.0/16
       |
       v
VPC Peering / Transit Gateway
       |
       v
VPC B – RDS
10.1.0.0/16
```

Production Commands:

```
# Check VPC Peering
aws ec2 describe-vpc-peering-connections

# Check Transit Gateways
aws ec2 describe-transit-gateways

# Check route tables
aws ec2 describe-route-tables

# Check database security group
aws ec2 describe-security-groups \
  --group-ids <rds-sg-id>

# Test database connectivity
nc -vz <private-rds-endpoint> 5432
```

Real-Time Scenario: An application running in EKS needs to connect to an RDS database hosted in a shared-services VPC.

We configure VPC Peering or Transit Gateway and permit the appropriate database traffic.

Follow-Up: Is VPC Peering transitive?

Answer: No. VPC Peering is not transitive. For complex connectivity between many VPCs, Transit Gateway is commonly used.

### Q21. EKS cannot connect to SQS, Secrets Manager, or another private AWS service. How do you troubleshoot?

Interview Answer:

First, I check whether the VPC Endpoint exists and is Available.

Then I verify DNS resolution, endpoint security groups, routing, and IAM permissions.

I test connectivity from the application pod, not only from my laptop or Jenkins agent.

Production Commands:

```
# Check available VPC Endpoints
aws ec2 describe-vpc-endpoints \
  --query 'VpcEndpoints[*].[ServiceName,State,PrivateDnsEnabled]' \
  --output table

# Check endpoint security groups
aws ec2 describe-security-groups \
  --group-ids <endpoint-sg-id>

# Check private DNS
nslookup sqs.ap-south-1.amazonaws.com

# Test HTTPS connectivity
nc -vz sqs.ap-south-1.amazonaws.com 443

# Check application logs
kubectl logs deployment/payment-service \
  -n production --tail=200

# Check ServiceAccount
kubectl describe serviceaccount payment-service-sa \
  -n production
```

Real-Time Scenario: Our EKS pod receives connection timeouts when calling Secrets Manager.

We find that the endpoint security group does not permit HTTPS from the application network.

After updating the approved security group rule, the connection works.

Follow-Up: What if the application receives AccessDenied instead of timeout?

Answer: I check IAM role permissions, service resource policies, VPC Endpoint policies, and KMS permissions if encryption is involved.

## Bonus: Additional Second-Round AWS and EKS Integration Questions

| Interview Question                                                            | Short Answer                                                                                     |
| ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| What is Amazon SQS?                                                           | A managed message queue service.                                                                 |
| What is Amazon SNS?                                                           | A publish-subscribe notification service.                                                        |
| What is Amazon EventBridge?                                                   | An event-routing service using event buses, rules, and targets.                                  |
| What is Amazon Kinesis?                                                       | A service for real-time data streaming.                                                          |
| What is an SQS Dead-Letter Queue?                                             | A queue for messages that cannot be processed successfully after configured attempts.            |
| Can EKS access SQS without NAT?                                               | Yes, using an SQS Interface VPC Endpoint.                                                        |
| Can EKS publish to SNS without NAT?                                           | Yes, using an SNS Interface VPC Endpoint.                                                        |
| Can EKS publish to EventBridge privately?                                     | Yes, using the appropriate EventBridge Interface Endpoint.                                       |
| Can EKS access Kinesis privately?                                             | Yes, using its supported Interface VPC Endpoint.                                                 |
| Can EKS access S3 without NAT?                                                | Yes, commonly through an S3 Gateway Endpoint.                                                    |
| What is the DynamoDB private connectivity option?                             | Commonly a DynamoDB Gateway Endpoint.                                                            |
| How do EKS pods access RDS privately?                                         | Through private VPC routing and database security group rules.                                   |
| What is IRSA?                                                                 | IAM Roles for Service Accounts, using Kubernetes OIDC federation.                                |
| What is EKS Pod Identity?                                                     | Assigning temporary IAM credentials to pods through EKS associations and the Pod Identity Agent. |
| Which VPC Endpoint does Pod Identity need in a fully private EKS environment? | EKS Auth, `eks-auth`.                                                                            |
| Which endpoint does IRSA typically need when there is no internet egress?     | Regional AWS STS.                                                                                |
| Can EKS pull ECR images without internet?                                     | Yes, with ECR API, ECR DKR, and S3 endpoints, plus required permissions.                         |
| What is an internal ALB?                                                      | A private HTTP/HTTPS load balancer.                                                              |
| What is an internal NLB?                                                      | A private Layer 4 load balancer for supported transport protocols.                               |
| Does PrivateLink automatically provide IAM permissions?                       | No. Private connectivity and authorization are separate.                                         |

## Last-Minute AWS and EKS Commands

```
# All VPC Endpoints
aws ec2 describe-vpc-endpoints

# SQS Endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.sqs

# SNS Endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.sns

# EventBridge Endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.events

# Kinesis Endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.kinesis-streams

# Secrets Manager Endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.secretsmanager

# S3 Endpoint
aws ec2 describe-vpc-endpoints \
  --filters \
  Name=service-name,Values=com.amazonaws.ap-south-1.s3

# EKS Pod Identity
aws eks list-pod-identity-associations \
  --cluster-name prod-eks

# EKS ServiceAccount
kubectl get serviceaccounts -n production

# Internal Load Balancers
aws elbv2 describe-load-balancers

# Application Ingress
kubectl get ingress -n production

# Application Service
kubectl get svc -n production

# Application Logs
kubectl logs deployment/payment-service \
  -n production --tail=100
```

## Most Important Interview Question 1

Interviewer: Explain how your EKS application communicates with other AWS resources without using the public internet.

Suggested Answer:

> In our example architecture, we deploy EKS worker nodes inside private subnets.
>
> For SQS, SNS, EventBridge, Kinesis, and Secrets Manager, we use Interface VPC Endpoints.
>
> For S3 and DynamoDB, we use Gateway VPC Endpoints.
>
> For RDS, applications communicate using private VPC routing.
>
> We use EKS Pod Identity or IRSA to provide IAM permissions securely.
>
> Finally, we verify DNS resolution, endpoint security groups, network connectivity, and application permissions.

## Most Important Interview Question 2

Interviewer: How did you integrate EKS with AWS SQS, SNS, and EventBridge?

Suggested Answer:

> Payment Service running in EKS sends background tasks to SQS.
>
> When an event needs to reach multiple applications, we use SNS with separate SQS subscriptions.
>
> We use EventBridge for event-based routing between services.
>
> For private connectivity, we configure the required Interface VPC Endpoints.
>
> We assign IAM roles to application ServiceAccounts using EKS Pod Identity or IRSA.
>
> During failures, I check queue metrics, application logs, IAM permissions, and VPC Endpoint connectivity.

## Most Important Interview Question 3

Interviewer: What happens when your EKS cluster is completely private and has no NAT Gateway?

Suggested Answer:

> First, I identify all AWS services required by the worker nodes and applications.
>
> Then I configure the necessary VPC Endpoints, including ECR API, ECR Docker Registry, S3, and the required identity endpoints.
>
> Depending on our applications, we also configure SQS, Secrets Manager, CloudWatch Logs, and other service endpoints.
>
> I verify Private DNS, security group rules, IAM roles, image pulling, and application connectivity.
>
> I also check whether any third-party dependencies still require an approved outbound network path.

End of Subtopic 8.3 – Advanced AWS and EKS Integration

Covered: 21 detailed production questions + 20 bonus questions, including AWS messaging, Kinesis, private endpoints, EKS Pod Identity, IRSA, S3, RDS, internal ALB/NLB, Azure DevOps, and private-network troubleshooting.

Next Recommended Topic: Advanced AWS EKS Production Troubleshooting – CNI IP Exhaustion, CoreDNS, Internal ALB 502/503/504, IAM AccessDenied, SQS Backlogs, Pod Identity Failures, ECR ImagePullBackOff, Node Failures and Real-Time Incident Recovery.
