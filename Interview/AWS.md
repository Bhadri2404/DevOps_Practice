# AWS – 50 Advanced Questions and Answers

> Focus areas: VPC architecture, public/private subnets, NAT/IGW, route tables, Security Groups and NACLs, EC2, S3, ALB/NLB, Auto Scaling, EKS, CloudWatch, Lambda, Route53, multi-account, landing zone, HA/DR, and cost optimization.[web:93][web:96][web:102]

---

## 1. VPC Architecture, Subnets, and Routing

### Q1. What is an AWS VPC and how would you design it for a regulated bank workload?

**Answer:**  
A Virtual Private Cloud (VPC) is a logically isolated virtual network in AWS where you can define IP ranges, subnets, route tables, and gateways to build secure, segmented network topologies for your applications.[web:96][web:99] For a bank workload, design typically includes multiple VPCs (per environment or domain), segregated public and private subnets across at least two or three Availability Zones, strict routing controls, and connectivity to on-prem via VPN or Direct Connect.

**Production Design Points:**

- CIDR planned to avoid overlap with on‑prem and other VPCs.
- Separate subnets for web, app, data tiers (network segmentation).
- Centralized shared-services VPC (logging, monitoring, bastion, endpoints) with VPC peering/Transit Gateway.

**Common Mistakes:**

- Poor CIDR planning leading to conflicts and rework.
- Putting databases or internal services in public subnets.

**Follow-up Questions:**

- How would you connect VPCs across accounts/regions securely?
- How do you handle IP exhaustion in a busy environment?

---

### Q2. Differentiate between public and private subnets in AWS VPC.

**Answer:**  

- **Public subnet:** Subnet whose route table has a route to an Internet Gateway (IGW). Instances with public IPs here can reach and be reached from the internet (subject to Security Groups/NACLs).[web:96][web:102]
- **Private subnet:** No direct route to IGW. Outbound internet (if needed) is via NAT gateway or NAT instance in a public subnet. Instances are not directly reachable from internet.

**Typical Use:**

- Public: ALBs, bastions, NAT gateways.
- Private: application servers, databases, internal services.

**Common Mistakes:**

- Placing application servers that must not be internet‑reachable in public subnets.
- Using public IPs unnecessarily, increasing attack surface.

**Follow-up Questions:**

- How do you enable private subnets to access S3 without internet access?
- How do you design subnets across AZs for high availability?

---

### Q3. What is an Internet Gateway vs a NAT Gateway? When do you use each?

**Answer:**  

- **Internet Gateway (IGW):** Horizontally scaled, redundant gateway that allows communication between VPC and the public internet. Only subnets with route to IGW and instances with public IPs/Elastic IPs are directly reachable.[web:96]
- **NAT Gateway:** Managed service allowing instances in private subnets to initiate outbound connections to the internet (for patching, repos, third-party APIs) while preventing unsolicited inbound connections.[web:102]

**Usage:**

- IGW: For public-facing endpoints (ALB, bastion).
- NAT: For outbound-only internet access from private subnets.

**Common Mistakes:**

- Using NAT in single AZ; when that AZ fails, outbound from all private subnets breaks.
- Misconfigured route tables sending inbound traffic intended for IGW to NAT.

**Follow-up Questions:**

- How would you design NAT for multi-AZ high availability?
- What are cost considerations for NAT Gateway?

---

### Q4. Explain route tables in VPC and how you debug routing issues.

**Answer:**  
Route tables define how traffic is directed from subnets to destinations (local VPC CIDR, IGW, NAT, VPN, TGW, peering).[web:96] Each subnet must be associated with one route table; main route table can be default.

**Debugging Routing:**

1. Identify source and destination IPs.
2. Check subnet association to route table.
3. Inspect routes (0.0.0.0/0 targets, peering/TGW, local).
4. Ensure both sides of a connection (e.g., VPC peering) have proper routes.

**Common Mistakes:**

- Forgetting to associate custom route tables with specific subnets.
- Only adding routes in one direction for peering or TGW.

**Follow-up Questions:**

- How do Security Groups and NACLs interact with routing?
- How would you test reachability between two EC2 instances across subnets?

---

### Q5. Compare Security Groups and Network ACLs and give production design guidelines.

**Answer:**  

- **Security Groups (SG):** Stateful, instance-level virtual firewalls. Rules specify allowed inbound/outbound; return traffic automatically allowed. Attached to ENIs/instances/ALBs.[web:96]
- **Network ACLs (NACLs):** Stateless, subnet-level ACLs. Rules evaluated in order; must explicitly allow both inbound and outbound for a flow.

**Production Guidelines:**

- Use SGs as primary security boundary for instances and services.
- Use NACLs as coarse “guardrail” (e.g., default-deny for unused ports across subnet).
- Minimize complexity of NACLs; keep most logic in SGs.

**Common Mistakes:**

- Overly complex NACL ruleset making troubleshooting difficult.
- Using 0.0.0.0/0 inbound on important SGs (overexposure).

**Follow-up Questions:**

- How do you debug a case where ping/SSH fails between two instances?
- How would you design SGs for a 3-tier web-app architecture?

---

## 2. EC2, Load Balancing, and Auto Scaling

### Q6. Explain EC2 instance lifecycle and key design decisions for production workloads.

**Answer:**  
EC2 provides resizable compute capacity; design decisions include instance type, family (general, compute-optimized, memory-optimized), purchasing model (on-demand, reserved, spot), storage (EBS gp3/io1/io2, instance store), and networking (ENIs, SGs).[web:93][web:102]

**Lifecycle:**

- Launch → running → stopped → terminated.
- Scaling via Auto Scaling Groups (ASG) rather than managing individual instances.

**Production Considerations:**

- Use Auto Scaling for stateless workloads.
- Use IAM roles for EC2 instead of static credentials.
- Use user data or config management (Ansible) to bootstrap.

**Common Mistakes:**

- Pets vs cattle: manually managed snowflake instances.
- Storing critical data on ephemeral instance store without backup.

**Follow-up Questions:**

- How would you design EC2 for a Python microservice fleet?
- What monitoring and alarms would you set on EC2 instances?

---

### Q7. Compare ALB and NLB; when would you choose each?

**Answer:**  

- **Application Load Balancer (ALB):** Layer 7 (HTTP/HTTPS) load balancer; supports host/path routing, WebSockets, WAF integration, native support for modern microservice architectures.[web:102]
- **Network Load Balancer (NLB):** Layer 4 (TCP/UDP) load balancer; extremely high performance, static IPs, low latency; good for non-HTTP protocols or needing client IP preservation.

**Use cases:**

- ALB: web APIs, microservices, routing requests to multiple services by path/host; integrate with Cognito/WAF.
- NLB: gRPC, TCP-based services, VPN, or where static IP is required.

**Common Mistakes:**

- Using ALB for non-HTTP traffic.
- Terminating TLS only at NLB target when you actually need TLS offload.

**Follow-up Questions:**

- How would you front Kubernetes services on EKS with ALB?
- When is Gateway Load Balancer useful?

---

### Q8. How do you design Auto Scaling Groups (ASG) for high availability and cost efficiency?

**Answer:**  

Design:

- Use multiple AZs for each ASG (min 2, ideally 3 in multi-AZ region).
- Configure min/desired/max capacity appropriately.
- Use scaling policies:
  - Target tracking (CPU, request count per target).
  - Step scaling for known patterns.

Cost:

- Mix on-demand and spot instances with instance diversification.
- Scale down during off-peak, maintain minimum for resilience.

**Common Mistakes:**

- Single-AZ ASG; AZ failure causes outage.
- No health checks from ALB/EC2, leaving unhealthy instances serving traffic.

**Follow-up Questions:**

- How would you debug an ASG that doesn’t scale out as expected?
- How do you do rolling updates with an ASG?

---

### Q9. Explain connection draining / deregistration delay in ALB/target groups and why it matters.

**Answer:**  
Connection draining (deregistration delay) defines how long ALB waits before fully removing a target after it’s marked unhealthy or during scale in/rolling deployments.[web:102]

**Importance:**

- Allows in-flight requests to complete gracefully.
- Prevents user-facing 5xx during rolling deployments.

**Best Practices:**

- Set reasonable deregistration delay (e.g., 30–300 seconds depending on request length).
- Use health checks aligned with application readiness and liveness.

**Common Mistakes:**

- Very short timeout causing abrupt termination of long requests.
- Forgetting that draining affects how fast you can scale down.

**Follow-up Questions:**

- How do you coordinate Ansible/Terraform actions with ALB draining?
- How would you handle WebSocket or streaming workloads?

---

## 3. S3, IAM, and Data Protection

### Q10. What is Amazon S3 and how do you design buckets for logs, data, and backups?

**Answer:**  
Amazon S3 is an object storage service for storing and retrieving any amount of data at scale, with features for durability, versioning, lifecycle policies, encryption, and access control.[web:93][web:102]

**Design Patterns:**

- Separate buckets for:
  - Application data.
  - Logs (ALB, CloudFront, app logs).
  - Backups and snapshots.
- Use prefix-based organization for environments, services, and time (e.g., `logs/app/prod/yyyy/mm/dd`).

**Security:**

- Block public access by default; explicit policies if public content needed.
- Use server-side encryption (SSE-S3, SSE-KMS).
- Use IAM policies and bucket policies with least privilege.

**Common Mistakes:**

- Public buckets with sensitive data.
- No lifecycle rules; unbounded storage cost.

**Follow-up Questions:**

- How do you enable access to S3 from private subnets without internet?
- How would you implement retention and archival for logs?

---

### Q11. How do you control access to AWS resources using IAM in a multi-team environment?

**Answer:**  
AWS Identity and Access Management (IAM) controls who can access which AWS resources and how.[web:99] In multi-team environments:

- Use IAM users/roles/groups tied to corporate identity (SSO/AD).
- Prefer IAM roles for workloads (EC2, Lambda, EKS service accounts) over access keys.
- Use role-based access for human users (admin, read-only, dev).

**Best Practices:**

- Least privilege: fine-grained policies for services.
- Use IAM Access Analyzer to detect overly broad access.
- Use permission boundaries and SCPs (via AWS Organizations) to constrain accounts.

**Common Mistakes:**

- Sharing IAM users or access keys.
- Attaching AWS managed policies (like `AdministratorAccess`) everywhere.

**Follow-up Questions:**

- How would you give a microservice read-only access to one S3 bucket?
- How does IRSA (IAM Roles for Service Accounts) work with EKS?

---

### Q12. Explain IAM roles vs IAM users vs federated identities in the context of this role.

**Answer:**  

- **IAM users:** Long-lived identities with credentials; mainly for humans (console/API) when SSO not used.
- **IAM roles:** Identities with permissions that can be assumed by trusted entities (users, services, other roles); used heavily for EC2, Lambda, EKS, CI/CD.[web:93]
- **Federated identities:** External identity providers (AD, SAML, OIDC) integrated with AWS; users authenticate externally and assume roles via federation.

**In this role:**

- Use roles for CI/CD (Jenkins, GitHub Actions) and workloads.
- Use SSO/federation for engineers, who assume roles with limited-time credentials.

**Common Mistakes:**

- Using IAM users + access keys for apps instead of roles.
- Not rotating access keys or using them in code repositories.

**Follow-up Questions:**

- How would you configure Jenkins on-prem to assume an AWS role?
- How do you audit who assumed which roles?

---

## 4. Route53, DNS, and Hybrid Connectivity

### Q13. How do you use Route53 for internal and external DNS in a multi-environment setup?

**Answer:**  
Amazon Route53 is a scalable DNS and domain registration service supporting public and private hosted zones.[web:102]

**Patterns:**

- Public hosted zones for internet-facing domains (e.g., `api.bank.com`).
- Private hosted zones associated with VPCs for internal domains (e.g., `service.internal`).
- Weighted, latency-based, or failover routing policies for HA across regions.

**Multi-environment:**

- Separate zones or subdomains per environment (`dev.api.bank.com`, `prod.api.bank.com`).
- Use Route53 health checks and failover records for DR.

**Common Mistakes:**

- Mixing dev and prod records in same zone without convention.
- Forgetting VPC associations for private hosted zones (no resolution).

**Follow-up Questions:**

- How would you perform regional failover using Route53?
- How do you manage DNS for on-prem + AWS (split-horizon)?

---

### Q14. How do you securely connect on-prem data centers with AWS VPCs?

**Answer:**  

Options:

- **Site-to-Site VPN:** IPsec VPN tunnels over the internet; good for initial/mid-scale connectivity.
- **AWS Direct Connect:** Dedicated network link; more consistent bandwidth and latency.
- Often combined (VPN over DX) for redundancy.

**Architecture:**

- Use VGWs on AWS side or Transit Gateway for multi-VPC connectivity.
- On-prem routers connect to VGW/TGW with BGP.

**Common Mistakes:**

- Relying on a single VPN tunnel (no redundancy).
- No clear IP addressing plan; overlapping CIDRs break routing.

**Follow-up Questions:**

- When would you choose Transit Gateway instead of multiple peerings?
- How do you enforce security between on-prem and VPC subnets?

---

### Q15. How do you design a multi-account AWS environment (landing zone) for a bank?

**Answer:**  

Landing zone patterns (aligned with AWS best practices):[web:93][web:99]

- Use AWS Organizations with dedicated accounts:
  - Management (root).
  - Security/log archive.
  - Shared services.
  - Multiple app accounts (by domain or environment).
- Centralized logging account (CloudTrail, Config, security logs).
- Guardrails via Service Control Policies (SCPs) at OU level.

**Benefits:**

- Strong isolation between workloads.
- Separate billing and cost tracking.
- Easier compliance and blast-radius reduction.

**Common Mistakes:**

- Cramming everything into one big account.
- No central logging or consistent guardrails.

**Follow-up Questions:**

- How do you share network connectivity (Transit Gateway, shared services) across accounts?
- How do you enforce tagging and IAM baselines across accounts?

## 5. EKS, Containers, and Platform Integration

### Q16. How would you design an EKS cluster for this kind of DevOps/Data platform role?

**Answer:**  
Amazon EKS provides managed Kubernetes control planes; you manage worker nodes or Fargate profiles and integrate with AWS networking and IAM.[web:102] For a bank/Data/ML platform:

- Private EKS API endpoint or restricted public access (CIDR allowlist, IAM auth).
- Worker nodes in private subnets, ALBs/NLBs in public subnets.
- IAM Roles for Service Accounts (IRSA) to give Pods fine‑grained AWS permissions (S3, DynamoDB, Secrets Manager, etc.).
- Separate namespaces and node groups for different workloads (app, data, ML, system).

**Common Mistakes:**

- Using node IAM roles for everything instead of IRSA (over-privileged).
- Exposing EKS API endpoint to the internet without tight controls.

**Follow-up Questions:**

- How would you integrate EKS with existing VPC/Transit Gateway and on‑prem?
- How do you manage cluster add-ons (CNI, CoreDNS, metrics-server) and upgrades?

---

### Q17. How do you manage access control in EKS (Kubernetes RBAC + AWS IAM)?

**Answer:**  

Layers:

- **IAM → Kubernetes:** `aws-auth` ConfigMap maps IAM roles/users to Kubernetes groups (e.g., `system:masters`).
- **Kubernetes RBAC:** Roles/ClusterRoles + RoleBindings/ClusterRoleBindings to control API access inside cluster.

**Patterns:**

- Developers assume IAM role that grants limited K8s rights (namespaced).
- CI/CD roles (e.g., Jenkins) get service accounts + IRSA mapped to specific K8s permissions.

**Common Mistakes:**

- Mapping broad IAM roles to `system:masters`, giving full cluster admin.
- Not separating human vs service access.

**Follow-up Questions:**

- How would you implement least-privilege for a data scientist team on EKS?
- How do you audit who did what in EKS?

---

### Q18. How do you integrate EKS with ALB for exposing services?

**Answer:**  

Patterns:

- Use AWS Load Balancer Controller in the cluster.
- Define Kubernetes Ingress with proper annotations (ALB scheme, target type, SSL, WAF integration).
- ALB gets created in public or internal subnets; targets are Pods behind NodePort or IP mode.

**Benefits:**

- Native AWS ALB features (WAF, SSL, path-based routing) for K8s services.
- Centralized ingress for many microservices.

**Common Mistakes:**

- Misconfigured security groups between ALB and nodes.
- Not specifying correct subnets/ingress class, leading to ALB in wrong place.

**Follow-up Questions:**

- How would you set up blue–green or canary at ALB + EKS level?
- How do you debug 502/503 errors for EKS services exposed via ALB?

---

## 6. Lambda, Serverless, and Event-Driven Designs

### Q19. What is AWS Lambda and when would you prefer it over EC2/EKS?

**Answer:**  
AWS Lambda is a serverless compute service that runs code in response to events, automatically managing compute, scaling, and availability; you pay only for execution time.[web:93][web:102]

**Use cases:**

- Lightweight API backends (with API Gateway/ALB).
- Event processing (S3 uploads, SQS/Kinesis streams, CloudWatch events).
- Automation tasks (cron-like functions, housekeeping jobs).

**Prefer Lambda over EC2/EKS when:**

- Workloads are bursty or low-throughput but must be highly available.
- Operational overhead must be minimized.

**Common Mistakes:**

- Implementing heavy, long-running jobs in Lambda where EC2/EKS is better.
- Not managing cold-start impact for latency-sensitive APIs.

**Follow-up Questions:**

- How would you monitor and troubleshoot Lambda in production?
- How do you choose memory/time limits and concurrency settings?

---

### Q20. How do you integrate Lambda with other AWS services for automation?

**Answer:**  

Examples:

- Trigger Lambda on S3 events (object created) to process files.
- Use EventBridge/CloudWatch Events to run Lambda on schedules (cron).
- Process messages from SQS/SNS to decouple producers and consumers.
- Use Lambda for automation runbooks (e.g., restart RDS instance under certain conditions).

**Best Practices:**

- Use DLQs (dead-letter queues) for failed events.
- Idempotent handlers to safely handle retries.

**Common Mistakes:**

- No DLQ, so failures are lost.
- No proper error handling/logging; issues hidden.

**Follow-up Questions:**

- How would you implement an S3-to-RDS ETL using Lambda?
- How do you handle Lambda retries and partial failures?

---

## 7. CloudWatch, CloudTrail, and Observability

### Q21. How do you design logging and metrics in AWS using CloudWatch?

**Answer:**  

Patterns:

- **CloudWatch Logs:** collect logs from EC2, Lambda, ECS/EKS, ALB, API Gateway; centralize and filter. Integrate with Elastic/Grafana if needed.
- **CloudWatch Metrics:** default (CPU, network, disk) plus custom metrics from apps and Lambda.[web:93]
- **CloudWatch Alarms:** thresholds on metrics → notifications via SNS or incident systems.

**Design for this role:**

- Unified logging strategy (log group naming, retention, metric filters).
- Dashboards per environment/service (latency, errors, saturation).

**Common Mistakes:**

- Default retention (infinite) → cost blow-up.
- No structured logging, making search/analysis hard.

**Follow-up Questions:**

- How do you set SLO-based alarms (e.g., 99th percentile latency) with CloudWatch?
- How would you link CloudWatch with Elastic/Grafana stack in this org?

---

### Q22. What is CloudTrail and how is it used for security and audit?

**Answer:**  
AWS CloudTrail records API calls and console actions, providing history of “who did what, when, from where”, stored typically in S3 and viewable in CloudTrail console or CloudWatch.[web:93]

**Use in a bank:**

- Centralized, encrypted CloudTrail logs in a separate security account.
- Mandatory trails across all accounts and regions.
- Integrations with SIEM/GuardDuty for threat detection.

**Common Mistakes:**

- Not enabling CloudTrail in all regions or all accounts.
- Storing logs in same account as workloads (less secure).

**Follow-up Questions:**

- How do you investigate an unauthorized IAM change using CloudTrail?
- How do you protect CloudTrail buckets from tampering?

---

### Q23. How do you monitor EKS workloads using CloudWatch and other tools?

**Answer:**  

Approach:

- EKS control plane logs to CloudWatch (API, audit, scheduler logs).
- Container logs via CloudWatch agent/Fluent Bit or directly to Elastic/Kibana.
- Metrics:
  - Node and cluster-level metrics via CloudWatch or Prometheus.
  - Custom app metrics exported and scraped (Prometheus, Grafana).

**Combination:**

- Use CloudWatch for basic infra metrics and alarms.
- Use Prometheus/Grafana/Elastic for deep app-level observability.

**Common Mistakes:**

- Only monitoring node CPU/memory; ignoring app latency/error metrics.
- Not enabling control plane logging; limited visibility into K8s issues.

**Follow-up Questions:**

- How would you set up alerts for pod restarts, CrashLoopBackOff, or failed deployments?
- How do you correlate AWS-level metrics with Kubernetes-level metrics?

---

## 8. High Availability and Disaster Recovery

### Q24. How do you design a highly available web application on AWS?

**Answer:**  

Typical architecture:

- Multi-AZ VPC with public subnets (ALBs) and private subnets (app + DB).
- ALB across multiple AZs, pointing to ASG of EC2 instances or EKS services.
- Managed database (RDS) with Multi-AZ deployment.
- Stateless app layer; use S3, DynamoDB, ElastiCache for state where needed.
- CloudFront for global caching and DDoS mitigation with WAF.

**Key HA Points:**

- No single-AZ dependency.
- Health checks and auto-healing at each layer.

**Common Mistakes:**

- Single-AZ RDS or ASG.
- Hard-coding AZ-specific endpoints or dependencies.

**Follow-up Questions:**

- How would you handle session state across instances?
- How do you test AZ failure scenarios?

---

### Q25. How would you design DR (Disaster Recovery) for a critical banking API on AWS?

**Answer:**  

DR patterns:

- **Pilot light:** Minimal copy of environment in secondary region; full scale-up during DR.
- **Warm standby:** Reduced-capacity active environment in second region.
- **Active/active:** Both regions serve traffic; Route53 failover or latency routing.[web:93]

Key elements:

- Replicate data across regions (RDS cross-region read replicas, S3 CRR).
- Infrastructure-as-code (Terraform) to recreate infra quickly.
- Regular DR drills and RPO/RTO definitions.

**Common Mistakes:**

- Having DR design on paper only; no tested drills.
- Inconsistent data protection between primary and DR.

**Follow-up Questions:**

- How would you configure Route53 for regional failover?
- What RPO/RTO targets are realistic for your use cases?

---

### Q26. How do you use AWS Backup and snapshots for data protection?

**Answer:**  

AWS Backup orchestrates backups across services (EBS, RDS, DynamoDB, EFS, etc.).[web:102]

Patterns:

- Backup plans and vaults per environment and compliance class.
- Tag-based backup policies for auto-inclusion.
- Automate retention, lifecycle, and cross-region or cross-account backups.

**Common Mistakes:**

- Manual snapshots only; no centralized backup policy.
- No regular restore tests.

**Follow-up Questions:**

- How would you protect RDS and EBS volumes for critical databases?
- How do you handle encryption keys for backups (KMS)?

---

## 9. Cost Optimization and Governance

### Q27. What AWS cost optimization levers would you use for containerized workloads (EKS) and EC2?

**Answer:**  

Levers:

- Correct instance sizing (rightsizing).
- Mix of on-demand, reserved instances, and spot instances in node groups.
- Use Fargate for small workloads where management overhead is high.
- Schedule non-prod resources to shut down outside business hours.
- Use S3 lifecycle policies, Glacier for cold data.

Tools:

- AWS Cost Explorer, Compute Optimizer, Trusted Advisor.[web:99]

**Common Mistakes:**

- All on-demand, no reservations or spot.
- No tagging for cost allocation; hard to optimize.

**Follow-up Questions:**

- How would you decide between reserved instances vs savings plans?
- How do you monitor and control cost at team/project level?

---

### Q28. How do you implement guardrails and governance in AWS (especially for DevOps teams)?

**Answer:**  

Mechanisms:

- AWS Organizations + Service Control Policies (SCPs) to restrict actions at OU level.
- Config rules and conformance packs to enforce resource configurations (e.g., no public S3 buckets, EBS encryption required).
- CloudTrail and CloudWatch for auditing and anomaly detection.
- CI/CD checks (policy-as-code) before applying infra changes.[web:93]

**Common Mistakes:**

- Relying only on human review for governance.
- Overly restrictive SCPs causing teams to bypass governance.

**Follow-up Questions:**

- Which baseline Config rules would you enforce in a bank?
- How would you integrate Terraform/Ansible with these guardrails?

---

## 10. Incident Scenarios and RCAs

### Q29. Incident: High 5xx error rates from a microservice behind ALB in AWS. How do you triage and resolve?

**Answer (example flow):**  

1. **Detection:** CloudWatch alarms for 5xx and latency; dashboards show spike on ALB target group.
2. **Scope:** Identify specific microservice/target group and AZs impacted.
3. **Checks:**
   - ALB metrics: `HTTPCode_ELB_5XX` vs `HTTPCode_Target_5XX`.
   - Target health: check if many instances marked unhealthy.
   - EC2/EKS metrics: CPU, memory, pod restarts.
   - Recent deploys (Jenkins logs, EKS rollouts, Terraform changes).
4. **Mitigation:**
   - Roll back last deployment or reduce traffic to bad version (canary).
   - Scale up ASG/EKS to handle load if resource exhaustion.
5. **RCA possibilities:**
   - Bad application release (bug, memory leak).
   - Downstream DB or cache latency.
   - Misconfigured health checks or timeouts.
6. **Prevention:**
   - Better canary and health checks.
   - SLO-based rollback policies.

**Follow-up Questions:**

- Which AWS metrics would you chart first in this incident?
- How would you involve Kubernetes layer debugging if EKS is used?

---

### Q30. Incident: Sudden spike in AWS costs. How do you investigate and address it?

**Answer:**  

Steps:

1. Use Cost Explorer to identify services, regions, and accounts responsible.[web:99]
2. Drill down by tag (env, app, team) to localize spike.
3. Identify specific changes:
   - New ASGs, EKS node groups, or EC2 fleets.
   - Large S3 data transfer or Glacier retrieval.
   - Misconfigured NAT, data transfer across regions.

4. Mitigation:
   - Stop or scale down non-critical over-provisioned resources.
   - Fix misconfigurations (looping jobs, high-frequency polling, large logs).

5. Prevention:
   - Budget alerts and anomaly detection for cost.
   - Tagging and regular cost reviews.

**Follow-up Questions:**

- How would you design cost dashboards for engineering leads?
- What policies would you implement to reduce future cost incidents?

