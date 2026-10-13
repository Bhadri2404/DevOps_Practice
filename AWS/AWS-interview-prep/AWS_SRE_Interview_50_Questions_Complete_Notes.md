# AWS SRE / DevOps Engineer Interview Preparation — 50 Advanced Questions with Detailed Answers

**Experience:** 5+ years  |  **Audience:** Senior DevOps / Site Reliability Engineer  |  **Level:** Advanced production scenarios

**Format for every answer:** 1. Concept · 2. Implementation (step by step) · 3. Production Example · 4. Troubleshooting · Interview Conclusion.

**How to use these notes:** Read the concept first, practise the implementation without looking, then explain the production example and troubleshooting checks in your own words. Commands show representative patterns; replace placeholders (`<...>`) and validate permissions, Region, service versions and approval before production use.

**Scope:** AWS-focused equivalents of your Azure preparation, with financial-services reliability, cross-account design, EKS, logging, messaging, CI/CD, DR, costs and AI. These are high-value preparation questions, not a verified list of State Street panel questions.

## Table of Contents

### Section A: AWS Networking, Cross-Account Connectivity and Security

1. [Question 1: How would you design a secure three-tier application architecture in AWS using VPC, subnets, security groups, ALB, Network Firewall, and private databases?](#q01)
2. [Question 2: How would you securely connect applications in two different AWS accounts?](#q02)
3. [Question 3: Two AWS VPCs have overlapping CIDR ranges. How can they communicate securely?](#q03)
4. [Question 4: What is the difference between S3 gateway endpoints, interface endpoints, and internet/NAT access? How do you configure them?](#q04)
5. [Question 5: How do you configure cross-account VPC peering step by step, and what are its routing limitations?](#q05)
6. [Question 6: How would you harden and secure an EC2 instance for a production banking application?](#q06)
7. [Question 7: How do AWS Organizations SCPs, AWS Config rules, Control Tower guardrails, and IAM policies compare with Azure Policy?](#q07)
8. [Question 8: Explain IAM roles, resource-based policies, permission boundaries, SCPs, and cross-account AssumeRole troubleshooting.](#q08)
9. [Question 9: How would you connect an on-premises data center to AWS using Site-to-Site VPN, Direct Connect and hybrid DNS?](#q09)
10. [Question 10: An EC2 or EKS application cannot connect to private Amazon RDS. How would you troubleshoot the issue?](#q10)

### Section B: Load Balancing, Routing and Network Troubleshooting

11. [Question 11: Compare ALB, NLB, Gateway Load Balancer, Classic Load Balancer, Route 53, CloudFront, and Global Accelerator.](#q11)
12. [Question 12: How do you deploy an HTTPS ALB with WAF, target groups, listener rules, ACM certificates, and health checks?](#q12)
13. [Question 13: An Application Load Balancer returns 502, 503, or 504 after deployment. How would you find the root cause?](#q13)
14. [Question 14: How would you build a hub-and-spoke AWS network using Transit Gateway, AWS Network Firewall, and route tables?](#q14)
15. [Question 15: Compare Security Groups, Network ACLs, AWS Network Firewall, and AWS WAF. How would you use them together?](#q15)
16. [Question 16: How would you troubleshoot VPC routing, DNS, connection timeouts, and unexpected network drops using AWS tools?](#q16)

### Section C: Amazon EKS, Security, Scaling and Migration

17. [Question 17: How would you deploy and secure a production Amazon EKS cluster from scratch?](#q17)
18. [Question 18: An EKS pod is in CrashLoopBackOff. How do you troubleshoot it step by step?](#q18)
19. [Question 19: How would you upgrade an EKS cluster and node groups with minimal downtime?](#q19)
20. [Question 20: An EKS pod is OOMKilled or CPU-throttled and API latency is increasing. What would you do?](#q20)
21. [Question 21: Compare HPA, VPA, Cluster Autoscaler, Karpenter, and EKS Auto Mode. How do you scale during unpredictable spikes?](#q21)
22. [Question 22: An EKS pod is Pending, ImagePullBackOff, or ErrImagePull. How do you troubleshoot?](#q22)
23. [Question 23: How would you secure EKS ingress, ECR image pulls, S3/Secrets Manager access, and outbound traffic?](#q23)
24. [Question 24: How would you migrate an on-premises Kubernetes application to Amazon EKS without downtime?](#q24)

### Section D: CloudWatch, Centralized Logging and SRE Observability

25. [Question 25: How would you design centralized logging and monitoring across AWS accounts, Regions, EC2, EKS, Lambda and RDS?](#q25)
26. [Question 26: Explain step by step how to configure CloudWatch Agent, Logs, metrics, alarms, SNS notifications and runbooks.](#q26)
27. [Question 27: Compare CloudWatch, CloudTrail, AWS X-Ray, Container Insights, Managed Prometheus and Managed Grafana.](#q27)
28. [Question 28: How would you monitor EC2 CPU, memory, disk and application response times with meaningful alarms?](#q28)
29. [Question 29: How do you set CloudWatch alarms for ALB 5xx, slow APIs, failed deployments and unhealthy infrastructure?](#q29)
30. [Question 30: A production AWS application is slow while EC2/EKS CPU and memory appear normal. What would you investigate?](#q30)
31. [Question 31: How would you use CloudWatch Logs Insights to identify HTTP 500 errors, slow endpoints and recent deployment failures?](#q31)
32. [Question 32: CloudWatch Logs suddenly stops receiving application logs. How would you diagnose the collection pipeline?](#q32)
33. [Question 33: How would you define SLI, SLO, SLA and error budgets for an AWS payment API?](#q33)

### Section E: S3, SQS, SNS, EventBridge, Kinesis and PaaS

34. [Question 34: How would you securely connect an application in a private VPC subnet to Amazon S3?](#q34)
35. [Question 35: Compare Amazon SQS, SNS, EventBridge, Kinesis Data Streams and Amazon MSK. When would you use each?](#q35)
36. [Question 36: How would you configure Kinesis Data Streams for high-throughput events and troubleshoot consumer lag?](#q36)
37. [Question 37: How would you create an S3 event → EventBridge → Lambda pipeline with retries and a DLQ?](#q37)
38. [Question 38: How would you design reliable SQS processing with visibility timeout, retries, DLQ, FIFO and worker autoscaling?](#q38)
39. [Question 39: An application cannot publish to Kinesis, EventBridge, SNS or SQS. How would you troubleshoot authorization and connectivity?](#q39)
40. [Question 40: How would you choose and secure Lambda, ECS Fargate, App Runner, and API Gateway for a private application?](#q40)
41. [Question 41: Amazon S3 returns AccessDenied (403) from EC2, EKS or Lambda. How do you troubleshoot it?](#q41)

### Section F: Disaster Recovery, Migration, CI/CD, Cost and AI

42. [Question 42: How would you design disaster recovery in AWS for very low RTO and RPO?](#q42)
43. [Question 43: How do AWS Backup, EBS/RDS snapshots, AWS Elastic Disaster Recovery, and cross-Region copies differ?](#q43)
44. [Question 44: How would you migrate on-premises applications and databases to AWS with minimal downtime?](#q44)
45. [Question 45: A production deployment fails in AWS CodePipeline/CodeBuild/CodeDeploy. How do you investigate and recover?](#q45)
46. [Question 46: How would you architect and autoscale a highly available application with ALB, EC2 Auto Scaling, and Multi-AZ RDS?](#q46)
47. [Question 47: The AWS Console says EC2, EKS and RDS are healthy, but the customer application is down. How do you run a major incident?](#q47)
48. [Question 48: How would you reduce AWS costs without compromising SRE reliability and security?](#q48)
49. [Question 49: How would you deploy a secure generative AI application using Amazon Bedrock and AWS private networking?](#q49)
50. [Question 50: How would you design an AWS MLOps/agentic AI workflow with SageMaker, model registry, endpoints, and SRE safeguards?](#q50)

---

# Section A — AWS Networking, Cross-Account Connectivity and Security

<a id="q01"></a>
## Question 1: How would you design a secure three-tier application architecture in AWS using VPC, subnets, security groups, ALB, Network Firewall, and private databases?

### 1. Concept

A three-tier system separates the **web layer**, **application/API layer**, and **database layer**. It makes access control simpler and allows us to scale each layer independently. In AWS, a **VPC** is the private network; public subnets are for carefully controlled entry components, and private subnets are for servers and databases. A subnet becomes public when its route table sends internet traffic to an Internet Gateway; having a public IP alone is not enough. A security group is a **stateful** firewall on an ENI, while a network ACL is a **stateless** subnet control. An ALB handles Layer 7 HTTPS routing, and AWS Network Firewall can inspect selected routed network traffic. A database should not be directly reachable from the internet.

### 2. Implementation — Step by Step

1. Choose an AWS Region and **two or three Availability Zones (AZs)**. Plan a non-overlapping VPC CIDR, for example `10.20.0.0/16`.
2. Create public subnets for internet-facing ALB and private application subnets in at least two AZs. Put RDS in private DB subnets using a DB subnet group.
3. Attach an Internet Gateway only for required public access. If private workloads need outbound internet, use NAT Gateways with appropriate AZ resilience, or eliminate this need with VPC endpoints.
4. Create ALB listeners on HTTPS 443 with ACM certificates; map listener rules to healthy application target groups. Attach AWS WAF when the endpoint is public.
5. Create security groups: ALB accepts 443 from approved sources; app accepts its port only from ALB SG; DB accepts 3306/5432 only from app SG.
6. Provision RDS Multi-AZ, Secrets Manager, KMS encryption, backups, CloudWatch logs/alarms, CloudTrail, and AWS Config. Add controlled routing via Transit Gateway/Network Firewall if required.

**Practical commands / query:**

```bash
aws elbv2 describe-target-health --target-group-arn <target-group-arn>
aws ec2 describe-route-tables --filters Name=vpc-id,Values=<vpc-id>
```

### 3. Production Example

For a payment API, I would run two or more frontend/API instances in private subnets in separate AZs, put an internet-facing ALB in public subnets, and store transactions in Multi-AZ RDS. Developers would not SSH directly into production: they would use Systems Manager Session Manager. I would use Terraform for predictable subnet, SG, ALB, RDS, IAM and alarm configuration, followed by a failover test.

### 4. Troubleshooting

- If customers get **502**, inspect ALB target health, application listeners, TLS and app logs.
- If app cannot reach RDS, test hostname resolution and port, then inspect source/destination SGs, NACLs and DB status.
- If private instances cannot reach external dependencies, inspect NAT route, gateway health and VPC endpoints.
- Use VPC Flow Logs, CloudWatch, Reachability Analyzer and RDS Performance Insights/Database Insights where applicable; follow the request from edge to database.

**Interview conclusion:**

> Build separate private tiers, allow only required traffic, keep the database private, use Multi-AZ and observe every layer.

---

<a id="q02"></a>
## Question 2: How would you securely connect applications in two different AWS accounts?

### 1. Concept

AWS accounts are isolation boundaries. Two services in different accounts can communicate through **cross-account VPC peering**, **Transit Gateway (TGW)**, or **AWS PrivateLink** depending on required scope. VPC peering makes private IP routes between non-overlapping VPCs; TGW suits many VPCs and central routing; PrivateLink exposes a particular service without giving the consumer general network access. Cross-account application authorization must still be configured using IAM/resource policies or application-level authentication.

### 2. Implementation — Step by Step

1. Identify the provider and consumer AWS accounts, Regions, VPC CIDRs and required destination ports. Choose a connection pattern that gives the minimum necessary reachability.
2. For VPC peering: create the request in Account A, accept it in Account B, then update the appropriate route tables **on both sides**.
3. For TGW: share the TGW through AWS RAM, attach the VPCs, configure TGW association/propagation or static routes, and update VPC subnet routes.
4. For PrivateLink: put the provider behind a supported NLB, create a VPC endpoint service, allow the consumer principal and approve its connection; the consumer creates an interface endpoint.
5. Configure SGs, DNS, certificates, IAM and service authorization. Validate private DNS resolution and TCP connectivity from actual workloads.

**Practical commands / query:**

```bash
aws ec2 describe-vpc-peering-connections --vpc-peering-connection-ids <pcx-id>
aws ec2 describe-transit-gateway-attachments --filters Name=state,Values=available
```

### 3. Production Example

A trading API in Account A needs to query a customer-verification service owned by Account B. Rather than connect the entire networks, I would expose the verification API over PrivateLink and use a dedicated DNS name and mTLS or strong service authentication. If many application VPCs must communicate, I would evaluate a centrally administered TGW and inspection VPC instead.

### 4. Troubleshooting

- Confirm peering is `active`, TGW attachments are `available`, or PrivateLink endpoint is `available` and accepted.
- Check both sides of routing, especially TGW route table association/propagation and asymmetric return paths.
- Check SGs, NACLs and DNS/private hosted zone sharing.
- If network works but HTTP shows 401/403, check application identity, AWS policy, TLS and resource-based access rather than changing network rules.

**Interview conclusion:**

> I choose VPC peering for a small number of compatible VPCs, TGW for scaled connectivity, and PrivateLink for service-level isolation.

---

<a id="q03"></a>
## Question 3: Two AWS VPCs have overlapping CIDR ranges. How can they communicate securely?

### 1. Concept

AWS does **not** support VPC peering for overlapping CIDRs. Transit Gateway also does not solve overlapping routing automatically; overlapping VPC CIDR propagation/route design has important limitations. The safest service-specific approach is usually **PrivateLink**, whose consumer connects to a local interface endpoint with a non-conflicting IP. For general bidirectional IP connectivity, evaluate controlled NAT/proxy appliances or a planned VPC readdressing migration. Do not claim that adding TGW alone resolves overlap.

### 2. Implementation — Step by Step

1. Check both VPC CIDR blocks and identify which exact service and protocols must communicate. Avoid assuming full network connectivity is necessary.
2. For a specific provider API, deploy an internal NLB in the provider VPC and register the backend targets.
3. Create a VPC endpoint service for the NLB, allow the consumer account and configure acceptance settings.
4. In the consumer VPC, create an interface endpoint for that service in appropriate subnets and enable DNS integration or create an application hostname.
5. Permit only application HTTPS traffic and validate authentication. For many protocols, run a proof of concept with NAT/proxy or develop an IP-renumbering plan with rollback.

**Practical commands / query:**

```bash
aws ec2 describe-vpcs --vpc-ids <vpc-id> --query 'Vpcs[].CidrBlockAssociationSet[].CidrBlock'
aws ec2 describe-vpc-endpoints --vpc-endpoint-ids <vpce-id>
```

### 3. Production Example

Two acquired business units both use `10.0.0.0/16`. Their applications require only a private pricing API. I would expose it over PrivateLink and let consumers resolve `pricing.internal.example` to endpoint IPs within their own VPC. The backend still uses the original subnet and address space, so no risky infrastructure-wide readdressing is required.

### 4. Troubleshooting

- If the interface endpoint is pending, verify service-principal authorization and acceptance.
- If DNS returns the provider’s overlapping IP, correct the consumer DNS to use its local endpoint.
- Check the NLB target health and endpoint SG rules.
- Test HTTPS/TLS and service authentication separately from TCP reachability.

**Interview conclusion:**

> Overlapping CIDRs block ordinary peering; use PrivateLink for one service, or NAT/readdressing for wider connectivity.

---

<a id="q04"></a>
## Question 4: What is the difference between S3 gateway endpoints, interface endpoints, and internet/NAT access? How do you configure them?

### 1. Concept

A **gateway VPC endpoint** for S3 or DynamoDB is a route-table target that lets eligible VPC resources reach the service privately without a NAT gateway. It has no private ENI to receive your requests. An **interface endpoint** (AWS PrivateLink) creates ENIs with private IPs and private DNS support for compatible services, and carries endpoint-hour/data-processing charges. Gateway endpoints are often the simplest S3 option for a VPC; interface endpoints can be useful for specific architectures, including hybrid DNS/network requirements. IAM and S3 bucket policies still decide whether access is authorized.

### 2. Implementation — Step by Step

1. Open **VPC → Endpoints → Create endpoint**. Select the AWS service `com.amazonaws.<region>.s3` and gateway endpoint type.
2. Choose the VPC and private route tables that need S3 access. Attach a restrictive endpoint policy if appropriate.
3. On the S3 bucket, enforce least-privilege principals and optionally add a condition such as `aws:SourceVpce`, taking care not to lock out administration or replication.
4. For interface endpoint access, choose the interface endpoint type, select subnets in suitable AZs, set endpoint SG rules for port 443 and configure supported private DNS.
5. Run an authenticated S3 `ls` or `cp` from the instance role. Use VPC Flow Logs/route checks to demonstrate which path is in use.

**Practical commands / query:**

```bash
aws ec2 describe-vpc-endpoints --filters Name=vpc-id,Values=<vpc-id>
aws sts get-caller-identity
aws s3 ls s3://<bucket-name>/
```

### 3. Production Example

For a private EKS worker node downloading confidential files from S3, I would use an S3 gateway endpoint and IRSA/EKS Pod Identity with an S3 role limited to one bucket prefix. This reduces dependency on NAT for S3, can lower networking cost, and supports a bucket policy restricting approved endpoint paths.

### 4. Troubleshooting

- For `AccessDenied`, inspect IAM role, endpoint policy, bucket policy, object ownership, KMS permissions and any SCP deny.
- For connection timeouts, confirm the instance’s route table is associated with the gateway endpoint; for interface endpoints, check DNS and endpoint SGs.
- Test with `aws sts get-caller-identity` to confirm which role the workload actually uses.
- Remember a gateway endpoint does not provide transitive access through VPC peering or typical on-premises paths.

**Interview conclusion:**

> Gateway endpoints are route-table based for S3/DynamoDB; interface endpoints create private ENIs. Neither replaces IAM authorization.

---

<a id="q05"></a>
## Question 5: How do you configure cross-account VPC peering step by step, and what are its routing limitations?

### 1. Concept

A VPC peering connection provides private routing between two VPCs, including cross-account and inter-Region options. The VPC address ranges cannot overlap, and **peering is not transitive**: A↔B and B↔C does not create A↔C connectivity. Routes must exist in both VPCs, and SG/NACL/DNS controls remain in force. AWS does not automatically create route table entries when the peering is accepted.

### 2. Implementation — Step by Step

1. Check VPC CIDRs, ownership, Region and requester/accepter roles. Obtain approval and decide which private subnets need reachability.
2. In Account A: **VPC → Peering connections → Create peering connection**, specify the accepter account/VPC and Region.
3. In Account B: find the pending request and **Accept**. Confirm the status changes to `active`.
4. Update the applicable Account A route tables to send Account B CIDR to `pcx-...`; do the reverse in Account B.
5. Allow the application traffic in SGs and NACLs. Enable peering DNS resolution options if required and supported for the hostname pattern.
6. Validate actual workload traffic over port 443/5432, observe Flow Logs, and define Terraform ownership of both sides.

**Practical commands / query:**

```bash
aws ec2 describe-vpc-peering-connections --vpc-peering-connection-ids <pcx-id>
aws ec2 describe-route-tables --filters Name=vpc-id,Values=<vpc-id>
```

### 3. Production Example

A frontend service in Account A uses `10.1.0.0/16`; a private API in Account B uses `10.2.0.0/16`. I would peer the VPCs and add only needed subnet routes and SG rules, then validate API access and set CloudWatch alarms for service-level errors. For 30+ spoke VPCs, a TGW may be operationally simpler.

### 4. Troubleshooting

- Peering must show active in both accounts; pending acceptance will not pass traffic.
- Missing route on either side causes one-way or complete failure.
- SGs are stateful; NACL return ephemeral ports may still block connections.
- Default VPC DNS settings do not guarantee every custom hostname resolves across VPCs.

**Interview conclusion:**

> Cross-account peering needs acceptance, routes on both sides, SG/NACL/DNS validation, and non-overlapping CIDRs.

---

<a id="q06"></a>
## Question 6: How would you harden and secure an EC2 instance for a production banking application?

### 1. Concept

Production EC2 security uses **defense in depth**. Keep instances in private subnets where possible, remove unnecessary inbound ports, attach instance IAM roles rather than static keys, encrypt EBS volumes, enforce IMDSv2, patch the OS, and collect audit/operational logs. AWS Systems Manager Session Manager can provide administrative shell access without opening SSH/RDP. GuardDuty/Inspector/Security Hub provide additional detection and posture-management features, but do not replace operating-system hardening.

### 2. Implementation — Step by Step

1. Use a hardened AMI (approved baseline), require EBS encryption and KMS key permissions, and disable unneeded packages and services.
2. Launch into private subnets with no public IP. Allow application ports only from approved ALB/service SGs.
3. Attach a least-privilege IAM instance profile; require IMDSv2 (`HttpTokens=required`) and rotate application secrets through Secrets Manager.
4. Configure Systems Manager Agent/SSM permissions and private VPC endpoints for SSM-related services where internet access is absent.
5. Use Systems Manager Patch Manager, Inspector, GuardDuty findings, CloudWatch Agent, CloudTrail and AWS Config rules.
6. Set backups/snapshots, vulnerability-remediation SLAs, key rotation, and incident isolation steps; test recovery of the AMI and attached data.

**Practical commands / query:**

```bash
aws ec2 describe-instances --instance-ids <instance-id> --query 'Reservations[].Instances[].MetadataOptions'
aws ssm describe-instance-information --filters Key=InstanceIds,Values=<instance-id>
```

### 3. Production Example

For a customer-risk scoring app, I would create a golden EC2 AMI, run an ASG in private subnets, connect over Session Manager, and block direct administrative ingress. GuardDuty findings would route to an incident queue, with automation restricted to approved actions such as quarantining a compromised instance.

### 4. Troubleshooting

- SSH failure: check whether access is intentionally blocked; use SSM session status instead.
- SSM disconnected: inspect role policies, agent health, SSM endpoints/DNS, network and time synchronization.
- Application receives KMS denial: check key policy plus IAM and grants.
- Suspicious outbound traffic: review Flow Logs, GuardDuty, process/socket logs; isolate carefully and preserve evidence before terminating.

**Interview conclusion:**

> Private subnets, least-privilege instance roles, encrypted disks, IMDSv2, SSM, patching and telemetry form my EC2 security baseline.

---

<a id="q07"></a>
## Question 7: How do AWS Organizations SCPs, AWS Config rules, Control Tower guardrails, and IAM policies compare with Azure Policy?

### 1. Concept

AWS governance uses several complementary controls. An **IAM policy** grants/denies principal permissions; an **SCP** sets the maximum allowed permissions for principals in member accounts but does not itself grant permission; **AWS Config rules** evaluate resource configurations and can trigger remediation; **Control Tower controls** help establish governed multi-account landing zones. Unlike a single Azure Policy assignment, AWS often combines preventive SCPs with detective Config rules and identity-level IAM permissions.

### 2. Implementation — Step by Step

1. Organize accounts into AWS Organizations organizational units (OUs), for example Security, Sandbox and Production.
2. Attach reviewed SCPs at the intended OU/account scope. Start with tested guardrails such as restrictions on unapproved Regions, with exceptions for necessary global services and break-glass roles as appropriate.
3. Enable AWS Config recording and apply managed/custom Config rules for public S3, encrypted storage, approved instance types or tagging checks.
4. Set up supported AWS Config remediation using Systems Manager Automation with careful IAM and exception management.
5. Use AWS Control Tower for landing-zone enrollment/control deployment when suitable. Send findings to Security Hub/EventBridge and track remediation evidence.
6. Roll changes out first in a sandbox OU and review policy simulator/CloudTrail events before expanding to production.

**Practical commands / query:**

```bash
aws organizations list-policies-for-target --target-id <ou-or-account-id> --filter SERVICE_CONTROL_POLICY
aws configservice describe-compliance-by-config-rule
```

### 3. Production Example

In a financial-services organization I would prevent ordinary production roles from disabling CloudTrail through an SCP, detect unencrypted volumes through AWS Config, and trigger a reviewed remediation workflow. The security account would receive compliance alerts and auditors could inspect configuration history.

### 4. Troubleshooting

- If deployment is denied, inspect `AccessDenied` context, CloudTrail, SCPs, IAM and permission boundaries.
- An SCP `Allow` alone never provides an IAM user or role permission.
- If a Config rule does not evaluate, check recording status, scope, trigger mode and service-linked permissions.
- Automatic remediation can cause outages if resources have legitimate exceptions; use approval and scoped exceptions.

**Interview conclusion:**

> Use SCPs for preventive account guardrails, Config for detecting configuration noncompliance, and IAM for identity permissions.

---

<a id="q08"></a>
## Question 8: Explain IAM roles, resource-based policies, permission boundaries, SCPs, and cross-account AssumeRole troubleshooting.

### 1. Concept

AWS authorization is not only the IAM role policy. Policies may include identity-based allows, resource policies, permission boundaries, session policies, Organizations SCPs and service-specific KMS policies. **An explicit deny wins**. For cross-account `sts:AssumeRole`, the caller generally needs permission to assume the target role and the target role must trust that principal; organizational restrictions can still block access. For workloads use short-lived role credentials rather than permanent access keys.

### 2. Implementation — Step by Step

1. Create a role in the destination account with a restrictive **trust policy** allowing only the intended source principal.
2. Attach a least-privilege permissions policy to the destination role for exact resource ARNs/actions.
3. On the caller side, permit `sts:AssumeRole` for the destination role as required. Use conditions/external ID when working with third parties.
4. Avoid overly broad wildcard resources; use permission boundaries and SCP guardrails where enterprise security requires them.
5. Test from the caller role with STS and inspect CloudTrail `AssumeRole` events; validate the actual action against the destination resource.

**Practical commands / query:**

```bash
aws sts get-caller-identity
aws sts assume-role --role-arn arn:aws:iam::<account-id>:role/<role-name> --role-session-name sre-check
```

### 3. Production Example

An operations tool in Account A needs to read CloudWatch metrics from Account B. I would create a read-only role in Account B, trust the approved automation role in Account A, and use short-lived STS credentials. I would log every role assumption and limit it to monitoring APIs rather than give an administrator role.

### 4. Troubleshooting

- `AccessDenied` on AssumeRole: check trust policy, caller policy, exact ARN, MFA/external ID conditions and SCPs.
- AssumeRole succeeds but S3/KMS fails: check target role policy and destination resource/key policies.
- Session policies and permission boundaries may reduce effective permissions despite broad identity-policy allows.
- Verify identity with STS instead of assuming the local CLI profile is correct.

**Interview conclusion:**

> Troubleshoot caller permission, target trust, effective permission boundaries/SCPs, and final resource policies separately.

---

<a id="q09"></a>
## Question 9: How would you connect an on-premises data center to AWS using Site-to-Site VPN, Direct Connect and hybrid DNS?

### 1. Concept

**Site-to-Site VPN** builds encrypted IPsec tunnels over internet paths and is useful for fast setup or backup connectivity. **AWS Direct Connect** provides private dedicated network connectivity from a customer site to AWS, but you still consider encryption separately. For many VPCs, a Direct Connect gateway and/or Transit Gateway can centralize the architecture. Hybrid systems need non-overlapping CIDRs, BGP routes, DNS forwarding, firewall rules, resilient links and capacity planning.

### 2. Implementation — Step by Step

1. Inventory data center CIDRs, AWS VPC CIDRs, DNS zones, security requirements and bandwidth/latency targets.
2. Create a customer gateway representing the on-prem device and a virtual private gateway or TGW target. Configure redundant Site-to-Site VPN tunnels and BGP when supported.
3. For Direct Connect, provision connection/hosted connection and VIF through the correct gateway path. Design site redundancy and a VPN fallback.
4. Add on-prem routes and AWS route propagation/static entries as needed. Verify both forward and return paths.
5. Configure Route 53 Resolver inbound/outbound endpoints and forwarding rules for hybrid private DNS.
6. Validate application TCP traffic, monitor VPN tunnel state, BGP routes, packet drops and Direct Connect metrics; run failover drills.

**Practical commands / query:**

```bash
aws ec2 describe-vpn-connections --vpn-connection-ids <vpn-id>
aws directconnect describe-connections
```

### 3. Production Example

A legacy settlement engine remains on-prem while its new API runs privately in AWS. I would establish Direct Connect for steady private connectivity, separate VPN backup, Route 53 Resolver forwarding for internal names, and tightly controlled SG/network firewall rules. A staged test verifies data exchange before production cutover.

### 4. Troubleshooting

- If tunnels are up but traffic fails, inspect BGP-advertised networks, route priorities and asymmetric routes.
- For DNS failures, check Resolver endpoints, security group UDP/TCP 53 and conditional forwarding rules.
- If latency increases, examine circuit capacity, retransmissions and path failover; do not immediately resize EC2.
- Confirm encryption requirements on Direct Connect paths and avoid accidentally publishing private routes to broad networks.

**Interview conclusion:**

> Hybrid AWS connectivity needs resilient VPN/Direct Connect paths, routes on both sides, DNS and security testing.

---

<a id="q10"></a>
## Question 10: An EC2 or EKS application cannot connect to private Amazon RDS. How would you troubleshoot the issue?

### 1. Concept

A database connection depends on five layers: **DNS resolution → route/reachability → SG/NACL enforcement → database listener/health → credentials/TLS/application pooling**. A private RDS instance is reachable only through permitted network paths. A successful `ping` is not a reliable RDS test; many RDS endpoints do not respond to ICMP. Troubleshoot TCP to port 5432 or 3306 and then the database login separately.

### 2. Implementation — Step by Step

1. Confirm DB instance/cluster is `available`, the correct endpoint/port is configured and the app is in a VPC with an intended route.
2. Resolve the RDS hostname from the application instance/pod and inspect the returned address.
3. Verify RDS SG inbound allows the application SG on the database port and app SG permits outbound.
4. Check VPC route tables, peering/TGW, NACL ephemeral response ports, firewall inspection and hybrid DNS if cross-VPC or on-prem.
5. Use `nc` to test TCP; if connection opens, examine IAM DB auth/Secrets Manager credentials, TLS requirement, max connections and DB metrics.
6. Correlate application timeouts with RDS connections, CPU, storage, locks and query performance to isolate a non-network cause.

**Practical commands / query:**

```bash
aws rds describe-db-instances --db-instance-identifier <db-id>
nslookup <db-hostname>
nc -zv <db-hostname> 5432
```

### 3. Production Example

During peak processing, a payment app reports database timeouts. I would first determine whether all API replicas fail or only one subnet/AZ, verify DNS and TCP, then use RDS telemetry and connection counts. If connection pool exhaustion is the root cause, I would tune pool limits or introduce RDS Proxy rather than open additional SG ports.

### 4. Troubleshooting

- `timeout`: DNS, routes, SG, NACL, database port and firewall are top suspects.
- `connection refused`: endpoint/listener/service status or wrong port.
- `authentication failed`: Secret rotation, IAM token expiry, DB user permissions or certificate validation.
- Intermittent failures during failover: review endpoint DNS caching, reconnect/backoff and application retry behavior.

**Interview conclusion:**

> Work from DNS to TCP to database authentication, then performance; capture evidence before changing firewall rules.

---

# Section B — Load Balancing, Routing and Network Troubleshooting

<a id="q11"></a>
## Question 11: Compare ALB, NLB, Gateway Load Balancer, Classic Load Balancer, Route 53, CloudFront, and Global Accelerator.

### 1. Concept

AWS has several services that solve different traffic problems. **Application Load Balancer (ALB)** is Layer 7 HTTP/HTTPS and supports host/path routing and WAF. **Network Load Balancer (NLB)** works at Layer 4 (TCP/UDP/TLS) for high-performance traffic, static addresses and preserving appropriate network properties. **Gateway Load Balancer (GWLB)** distributes traffic to virtual security appliances. Classic Load Balancer is legacy and should not be the default for new designs. **Route 53** is DNS routing, **CloudFront** is a global CDN/reverse proxy, and **Global Accelerator** gives global anycast static IPs for supported TCP/UDP applications. These services can complement rather than replace one another.

### 2. Implementation — Step by Step

1. Write down whether traffic is HTTP, HTTPS, TCP, UDP, or custom protocol; determine regional/global routing and whether WAF, WebSocket, static IP or source-IP preservation is required.
2. Use **ALB + WAF + ACM** for a regional web/API application, and configure target groups plus health checks.
3. Use **NLB** for network protocols, low-level TCP/UDP handling or PrivateLink endpoint services. Use GWLB where security appliances need transparent traffic steering.
4. Use CloudFront for caching and edge delivery, and Route 53 latency/failover records or Global Accelerator for multi-region entry where their properties fit.
5. Configure health checks, TLS policies, logs, target registration and alarms. Simulate one unhealthy target and verify expected failover.

**Practical commands / query:**

```bash
aws elbv2 describe-load-balancers
aws route53 list-health-checks
```

### 3. Production Example

For a banking portal, CloudFront can provide edge caching/security in front of a regional ALB with WAF; the ALB routes `/api` to backend containers. For a private TCP pricing feed accessed cross-account, I would evaluate NLB with PrivateLink. For a globally deployed low-latency application with static IP ingress, Global Accelerator is worth comparing with DNS-only failover.

### 4. Troubleshooting

- Wrong load balancer type can hide required L7 features or cause TLS misconfiguration.
- If targets are unhealthy, inspect protocol, path, expected response, target SG and listener ports.
- For global failover, test actual DNS caching, health checks and client behavior; a DNS record alone does not provide immediate application recovery.
- Differentiate edge 403s (WAF/CloudFront) from backend 5xx using access logs and trace IDs.

**Interview conclusion:**

> ALB is application HTTP routing, NLB is L4, GWLB handles appliances, Route 53 is DNS, CloudFront is CDN, and Global Accelerator gives global network entry.

---

<a id="q12"></a>
## Question 12: How do you deploy an HTTPS ALB with WAF, target groups, listener rules, ACM certificates, and health checks?

### 1. Concept

An ALB receives HTTP/HTTPS requests and forwards them to healthy targets according to listener rules. It can route by hostname/path and terminate TLS with an **ACM certificate**. AWS WAF can inspect incoming web requests for common attack patterns. For end-to-end encryption, configure HTTPS from ALB to the backend too; termination at the ALB does not automatically encrypt ALB-to-target traffic.

### 2. Implementation — Step by Step

1. Deploy the ALB into at least two appropriately routed subnets/AZs. Select internet-facing or internal scheme based on business requirements.
2. Create an ALB security group allowing 443 from authorized client sources; backend security groups should allow only the ALB SG on the target port.
3. Request/import an ACM certificate in the correct Region and validate domain ownership.
4. Create an HTTPS listener on port 443 with an approved TLS security policy. Attach target groups, health check path and success codes.
5. Add host/path rules (e.g., `/api/*` to API target group). Associate a WAF web ACL and adjust managed rules in staging before enforcing blocking in production.
6. Enable ALB access logs to a protected S3 bucket, monitor `HTTPCode_ELB_5XX_Count`, `HTTPCode_Target_5XX_Count`, `TargetResponseTime` and unhealthy hosts.

**Practical commands / query:**

```bash
aws elbv2 describe-listeners --load-balancer-arn <alb-arn>
aws elbv2 describe-target-health --target-group-arn <tg-arn>
```

### 3. Production Example

I would place a financial onboarding API behind a regional ALB with ACM TLS and WAF. Frontend and API paths could route to separate target groups. I would start WAF rules in count mode for false-positive validation, then switch to block mode with controlled exceptions. Health check endpoint `/health/ready` would confirm real application readiness.

### 4. Troubleshooting

- TLS/SSL failure: verify ACM certificate domain, SNI, chain and listener policy.
- Unhealthy targets: confirm backend port/path, app startup, security groups and health threshold.
- WAF 403: inspect WAF sampled requests/logs before excluding a specific rule.
- New deployment gets 5xx: compare target health and new release; drain/rollback targets as required.

**Interview conclusion:**

> Configure an HTTPS ALB with correct certificates, restricted target SGs, active health checks, WAF and access/metric alarms.

---

<a id="q13"></a>
## Question 13: An Application Load Balancer returns 502, 503, or 504 after deployment. How would you find the root cause?

### 1. Concept

An ALB **502** commonly means it cannot get a valid response from a target (connection reset, TLS/backend response issues). **503** often indicates no available targets to serve the request. **504** generally means an upstream target did not respond before the applicable timeout. The exact source matters: distinguish `HTTPCode_ELB_5XX_Count` from `HTTPCode_Target_5XX_Count`, since a target-generated 500 is not the same as an ALB-generated 502.

### 2. Implementation — Step by Step

1. Compare recent deployment time with error-rate graphs and evaluate whether the ALB or backend target generated the 5xx.
2. Open EC2 → Target Groups → Targets and inspect target health reasons and health-check configuration.
3. Verify listener-to-target protocol/port, security group rules, NACLs, backend TLS certificate expectations and application readiness endpoint.
4. Use ALB access logs to correlate request paths, response times and target response codes. Check application logs and container or instance restart events.
5. If failures follow a deployment, shift traffic back to healthy targets or roll back. Fix application readiness, connection draining, timeout or TLS before re-releasing.

**Practical commands / query:**

```bash
aws elbv2 describe-target-health --target-group-arn <tg-arn>
aws cloudwatch get-metric-statistics --namespace AWS/ApplicationELB --metric-name HTTPCode_ELB_5XX_Count --statistics Sum --period 60 --start-time <UTC-start> --end-time <UTC-end> --dimensions Name=LoadBalancer,Value=<alb-dimension>
```

### 3. Production Example

After releasing a new container, `/api/pay` returns 502 while homepage works. The API target group shows unhealthy targets. I would compare application bind port with target group port and investigate `kubectl logs`/ECS task logs. Once corrected, I would run smoke tests and monitor 5xx for a full deployment window.

### 4. Troubleshooting

- 502: backend reset, malformed response, SSL handshake or premature close; inspect target logs and target reset metrics.
- 503: check registered target count, AZ assignment, target health and target-group status.
- 504: inspect app slowness, target response time, connection pool waits and ALB idle timeout.
- If requests are 403, inspect WAF and auth rather than chasing backend timeout settings.

**Interview conclusion:**

> I classify the error at ALB vs target, then inspect health, routing, TLS and app logs; rollback quickly if the release caused it.

---

<a id="q14"></a>
## Question 14: How would you build a hub-and-spoke AWS network using Transit Gateway, AWS Network Firewall, and route tables?

### 1. Concept

A hub-and-spoke network centralizes connectivity and inspection while keeping applications in separate VPCs/accounts. **AWS Transit Gateway** attaches multiple VPCs, VPNs and other supported networks, and uses its own route tables to decide where traffic goes. An inspection VPC can run AWS Network Firewall or appliances. Both TGW route tables **and VPC subnet route tables** must be planned; forgetting either is a common outage cause. Use symmetric routing and appliance mode where required for stateful inspection.

### 2. Implementation — Step by Step

1. Create separate application accounts/VPCs and a networking account. Allocate unique CIDRs and security ownership boundaries.
2. Create a Transit Gateway, share through AWS Resource Access Manager, and add spoke VPC attachments using appropriate attachment subnets.
3. Create TGW route tables for production/nonproduction isolation, associate attachments, and configure appropriate propagation or explicit routes.
4. Create an inspection VPC with multi-AZ Network Firewall endpoints, routes toward TGW, and routes back to spokes. Design symmetric traffic paths.
5. Update spoke subnet routes to send approved spoke/on-prem destinations toward TGW and route inspected destinations through firewall attachments.
6. Validate flows per AZ and test failure scenarios; centrally collect firewall flow/alert logs and TGW metrics.

**Practical commands / query:**

```bash
aws ec2 describe-transit-gateway-route-tables
aws ec2 describe-transit-gateway-attachments
```

### 3. Production Example

For 15 application accounts, I would share one centrally managed TGW from a network account. Production VPCs would have controlled connectivity to shared services, while internet egress would be inspected and logged. Changes to routes would be made through Terraform and tested in a staging attachment first.

### 4. Troubleshooting

- Peering/TGW cross-account attachment available but no connectivity: inspect TGW association, propagation and VPC subnet routes.
- Stateful firewall drops only one direction: look for asymmetric routing across AZs and appliance-mode needs.
- Routes with broad `0.0.0.0/0` may leak inappropriate traffic; review segmentation policies.
- Use VPC Flow Logs and TGW/Network Firewall logs to identify the drop location instead of opening every SG.

**Interview conclusion:**

> TGW gives centralized transit, but success depends on both TGW and VPC routes, inspection symmetry and security segmentation.

---

<a id="q15"></a>
## Question 15: Compare Security Groups, Network ACLs, AWS Network Firewall, and AWS WAF. How would you use them together?

### 1. Concept

**Security groups** are stateful ENI-level allow rules; **NACLs** are stateless subnet-level allow/deny rules, so return traffic requires explicit handling. **AWS Network Firewall** is a managed network security layer for routed VPC traffic, and **AWS WAF** is a Layer 7 web-request filter attached to supported endpoints such as ALB/CloudFront. None is a universal replacement for the others. IAM is also separate: it controls API/resource authorization rather than packet filtering.

### 2. Implementation — Step by Step

1. Start by documenting traffic flows with sources, destinations, protocols, ports and data sensitivity.
2. Use tightly scoped SG references so only ALB reaches app tasks and only app tasks reach RDS.
3. Use NACLs for subnet guardrails where needed; document ephemeral response ranges because they are stateless.
4. If traffic inspection is mandated, deploy Network Firewall in an inspection architecture and route the required flows through it.
5. Attach WAF to the public ALB/CloudFront distribution, log matched rules and tune false positives.
6. Validate with VPC Reachability Analyzer, VPC Flow Logs, WAF logs and controlled test traffic.

**Practical commands / query:**

```bash
aws ec2 describe-security-groups --group-ids <sg-id>
aws ec2 describe-network-acls --filters Name=vpc-id,Values=<vpc-id>
```

### 3. Production Example

For a banking API, WAF would block known malicious HTTP patterns at the public entry point, app SGs would restrict backend communication, and Network Firewall would inspect egress to third-party services. NACLs would be reserved for clear network segmentation needs rather than mirroring every SG rule.

### 4. Troubleshooting

- A network timeout may arise from NACL response-port rules even when SGs are correct.
- WAF false positives typically generate HTTP 403 and need rule-level investigation.
- Network Firewall needs correct route symmetry; otherwise flows can fail intermittently.
- An application `AccessDenied` against S3 usually needs IAM/bucket-policy checks, not SG changes.

**Interview conclusion:**

> Use WAF for HTTP, SGs for workload ports, NACLs for subnet guardrails, and Network Firewall for routed network inspection.

---

<a id="q16"></a>
## Question 16: How would you troubleshoot VPC routing, DNS, connection timeouts, and unexpected network drops using AWS tools?

### 1. Concept

AWS networking problems must be isolated along the real path: **DNS → source ENI/SG → subnet NACL → route table/TGW/firewall → destination SG/NACL → listener**. VPC Flow Logs record accepted/rejected flow metadata, not packet payloads. **Reachability Analyzer** assesses configured network paths. **Route 53 Resolver query logs**, Transit Gateway flow logs and Network Firewall logs add evidence for more complex issues. A `timeout` differs from a TCP `connection refused` or an HTTP 403.

### 2. Implementation — Step by Step

1. Document source ENI/subnet and destination hostname/IP:port, exact UTC time, Region/account and recent changes.
2. Run DNS and TCP tests from the affected EC2 instance or EKS pod, not from your laptop.
3. Check source and destination SG rules, NACL return traffic, subnet route tables and required NAT/TGW/VPC endpoint path.
4. Run VPC Reachability Analyzer for an intended source/destination path where supported; inspect blocked component details.
5. Query VPC Flow Logs and Resolver query logs to locate rejected or misrouted traffic.
6. Inspect application listeners, TLS certificate and authorization after TCP reachability is confirmed.

**Practical commands / query:**

```bash
nslookup api.internal.example.com
nc -zv api.internal.example.com 443
aws ec2 describe-route-tables --filters Name=association.subnet-id,Values=<subnet-id>
```

### 3. Production Example

If only pods in one AZ cannot reach a third-party API, I would compare their subnet routes and NAT gateway health against healthy pods in other AZs. One subnet might route to an unavailable NAT gateway. I would correct routing and add per-AZ alarms rather than changing application code.

### 4. Troubleshooting

- DNS resolves wrong address: check private hosted zone associations and resolver forwarding rules.
- `REJECT` flow-log records: examine SG and NACL enforcement around that ENI.
- `ACCEPT` does not guarantee the remote application replied successfully; continue to listener, TLS and app logs.
- Do not rely on ICMP alone; test required TCP/UDP protocol and port.

**Interview conclusion:**

> I collect time-correlated DNS, route, Flow Logs and application evidence, then fix the first layer where traffic breaks.

---

# Section C — Amazon EKS, Security, Scaling and Migration

<a id="q17"></a>
## Question 17: How would you deploy and secure a production Amazon EKS cluster from scratch?

### 1. Concept

Amazon EKS operates the Kubernetes control plane, while compute can use EC2 node groups, Fargate (where compatible), or EKS Auto Mode. A production design needs **private subnets, multiple AZs, network design, least-privilege Kubernetes/AWS access, workload IAM, image supply-chain security, monitoring and upgrades**. A private API endpoint reduces exposure but also requires an administration path (VPN, private workstation or similar). The worker node role and application IAM permissions should not be mixed.

### 2. Implementation — Step by Step

1. Design VPC/subnets across 2–3 AZs, sufficiently sized pod IP address space, NAT/endpoints, DNS and route tables. Choose VPC CNI mode/features based on design.
2. Provision EKS with Terraform/approved modules; configure public/private API endpoint access appropriately and restrict public endpoint CIDRs if enabled.
3. Create system and application node pools or Auto Mode configurations with suitable instance families, AZ spread, taints and autoscaling policies.
4. Configure EKS access entries and Kubernetes RBAC; use EKS Pod Identity or IRSA for per-workload AWS access, and Secrets Manager/CSI where needed.
5. Configure ECR image scanning, signed/approved images, pod admission standards, network policies supported by the chosen network solution, and encrypted storage.
6. Install ingress/load balancer controller as required, CloudWatch Container Insights/OpenTelemetry/Prometheus, alerts and backup/DR procedures. Test node failure, deployment rollback and private endpoint access.

**Practical commands / query:**

```bash
aws eks describe-cluster --name <cluster> --query 'cluster.{status:status,endpoint:endpoint,version:version}'
kubectl get nodes -o wide
kubectl get pods -A
```

### 3. Production Example

For a payments microservice, I would provision EKS with Terraform in three AZs, keep nodes private, expose only HTTPS via an ALB, and give each namespace/application a separate scoped IAM role. CI/CD would deploy signed images, and SLO alerts would monitor API error rate and p95 latency rather than CPU alone.

### 4. Troubleshooting

- Nodes `NotReady`: inspect VPC CNI, kubelet, IAM, subnet IP space and control-plane connectivity.
- Image pull failures: check ECR permissions, registry DNS, NAT/VPC endpoints and exact image tag.
- Private cluster inaccessible: check API endpoint settings, approved access path, DNS and IAM/authn.
- Production availability: test draining nodes and PDBs, and avoid putting every replica on one AZ.

**Interview conclusion:**

> EKS production readiness covers networking, per-workload identity, multi-AZ placement, secure images, observability and tested upgrades.

---

<a id="q18"></a>
## Question 18: An EKS pod is in CrashLoopBackOff. How do you troubleshoot it step by step?

### 1. Concept

`CrashLoopBackOff` means a container starts, exits repeatedly and Kubernetes increases the delay between restart attempts. It is **a symptom, not the root cause**. Frequent causes are invalid configuration, missing secrets, failed dependencies, application crashes, wrong startup commands, insufficient memory and incorrectly configured liveness probes. Logs from the **previous** crashed container are often more informative than logs of the latest restart.

### 2. Implementation — Step by Step

1. Identify pod namespace/name, restart count, image and recent rollout: `kubectl get pods -n <ns> -o wide`.
2. Run `kubectl describe pod` and read Events for `Back-off restarting failed container`, probe failure, OOM or mount errors.
3. Run `kubectl logs <pod> -n <ns> --previous` (with `-c` for multi-container pods) and read the exact traceback or error.
4. Inspect pod environment, Secret/ConfigMap references, resource requests/limits, command/args, readiness/liveness/startup probes and service-account IAM role.
5. Check connectivity to dependencies from a debug pod, including DNS/TLS, RDS port, Secrets Manager or upstream API.
6. Fix configuration or code; deploy a new revision or roll back. Watch the pod stabilize and verify readiness, request error rate and logs.

**Practical commands / query:**

```bash
kubectl get pods -n <ns>
kubectl describe pod <pod> -n <ns>
kubectl logs <pod> -n <ns> --previous
kubectl rollout status deployment/<app> -n <ns>
```

### 3. Production Example

A Python container deployed to EKS repeatedly restarts because a database credential key was renamed in a Kubernetes Secret. `kubectl logs --previous` reports a missing environment variable. I would restore the correct key or update the Deployment, redeploy, and add configuration validation to CI/CD so the issue cannot recur.

### 4. Troubleshooting

- Exit code `137` suggests termination often associated with memory pressure; check `OOMKilled` reason rather than guessing.
- Exit code `1` often indicates application error; inspect stack trace and configuration.
- Probe failures may kill a healthy-but-slow-starting application; tune a startup probe or fix the underlying slow startup.
- If only one node is affected, inspect node disk pressure, CNI, runtime and events rather than changing all deployments.

**Interview conclusion:**

> Start with `describe`, previous logs and events, identify the actual termination reason, then fix and verify readiness.

---

<a id="q19"></a>
## Question 19: How would you upgrade an EKS cluster and node groups with minimal downtime?

### 1. Concept

Upgrading EKS is a coordinated sequence across **control plane, data-plane nodes, EKS add-ons, controllers and application APIs**. EKS control-plane minor versions move one supported minor release at a time. Use **EKS upgrade insights** to find deprecated Kubernetes APIs and known blockers. A managed EKS control-plane upgrade should not be treated as something you can always roll back easily; prepare recovery/blue-green alternatives for high-risk environments.

### 2. Implementation — Step by Step

1. Check current Kubernetes version and compatibility of `aws-load-balancer-controller`, VPC CNI, CoreDNS, kube-proxy, CSI drivers, Cluster Autoscaler/Karpenter and your application APIs.
2. Review **EKS → Cluster → Upgrade insights** and fix deprecated APIs, Pod Disruption Budgets, insufficient capacity and add-on issues.
3. Take backups of Kubernetes application objects and persistent data; record current Helm/GitOps revisions and test in staging first.
4. Ensure spare node/compute capacity; upgrade the control plane to the next supported minor version during an approved change window.
5. Update managed node groups in a controlled rolling fashion (or use parallel new node groups), then update EKS add-ons/controllers in compatible order.
6. Run smoke tests, API transactions, `kubectl get nodes`, error/latency dashboards and workload health; monitor beyond deployment completion.

**Practical commands / query:**

```bash
aws eks describe-cluster --name <cluster> --query 'cluster.version'
aws eks list-insights --cluster-name <cluster>
kubectl get pdb -A
kubectl get nodes -o wide
```

### 3. Production Example

For a core financial API, I would upgrade a preproduction EKS cluster first and measure PDB behavior, node-drain times and request errors. In production I would upgrade the control plane, roll nodes in small batches with spare capacity, and pause if p95 latency or error budget consumption rises.

### 4. Troubleshooting

- Upgrade blocked: review deprecated APIs, health insights and node-version prerequisites.
- Pods cannot evict: investigate restrictive PDBs, replicas and available nodes; do not forcibly remove critical pods without approval.
- Pods Pending after node replacement: investigate AZ volume placement, taints, instance quotas and IP exhaustion.
- A control-plane downgrade is not a standard rollback plan; prefer tested app rollback, alternate node groups and disaster recovery designs.

**Interview conclusion:**

> Precheck compatibility, add spare capacity, upgrade control plane then nodes/add-ons, and validate SLOs after each phase.

---

<a id="q20"></a>
## Question 20: An EKS pod is OOMKilled or CPU-throttled and API latency is increasing. What would you do?

### 1. Concept

`OOMKilled` means the container exceeded its memory limit or was killed under relevant memory pressure; Kubernetes records this termination reason. High **CPU throttling** can occur when CPU limits restrict bursts, even if node CPU appears moderate. Requests influence scheduler placement; limits enforce container boundaries. The right fix depends on measured memory usage, garbage collection, leaks, concurrency and downstream dependency behavior—not only blindly increasing requests and limits.

### 2. Implementation — Step by Step

1. Inspect `kubectl describe pod`, termination state, `kubectl top pod/node`, Container Insights or Prometheus memory working set, CPU throttling and restart graphs.
2. Compare observed p95/p99 resource usage with the configured CPU/memory requests and limits. Inspect HPA metrics and pod density.
3. Review application heap metrics, connection pools, cache growth, Python/Java process behavior, background jobs and traffic change timestamps.
4. If an emergency, scale replicas or temporarily adjust resources within budget/quota, but record the change and test impact on node capacity.
5. Fix leaks or unbounded caching, set justified requests/limits, tune HPA targets and verify sufficient node scaling.
6. Confirm API latency, 5xx, OOM and CPU throttling return to baseline before closing the incident.

**Practical commands / query:**

```bash
kubectl describe pod <pod> -n <ns>
kubectl top pod -n <ns>
kubectl top nodes
kubectl get hpa -A
```

### 3. Production Example

A Java payments service initially has a 512 MiB limit but now needs more memory during batch reconciliation. I would prove whether heap peaks exceed the limit or leak over time. I might increase the limit safely as an immediate mitigation, then tune heap sizes and scale policy based on load-test data.

### 4. Troubleshooting

- `OOMKilled`: inspect container termination `Reason`, memory limit and peak metrics; node pressure is another possibility.
- High CPU despite available cluster capacity: inspect CPU quota throttling and application concurrency.
- Pod cannot schedule after limit/request increase: check node allocatable resources, quotas and autoscaler constraints.
- If latency persists with healthy resource graphs, trace database/network dependencies rather than overprovisioning.

**Interview conclusion:**

> I diagnose whether memory, CPU throttling, scheduling or a dependency is the bottleneck before choosing scaling versus code fixes.

---

<a id="q21"></a>
## Question 21: Compare HPA, VPA, Cluster Autoscaler, Karpenter, and EKS Auto Mode. How do you scale during unpredictable spikes?

### 1. Concept

Scaling has different layers: **HPA** changes replica counts based on CPU, memory or custom/external metrics; **VPA** recommends or adjusts pod resource requests, depending on configuration; **Cluster Autoscaler** adds/removes nodes from configured Auto Scaling Groups; **Karpenter** provisions suitable nodes to satisfy pending pods; and **EKS Auto Mode** automates supported compute and infrastructure operations for eligible clusters. More pods do not help if no node capacity exists. Avoid running competing node autoscalers for the same capacity without a deliberate design.

### 2. Implementation — Step by Step

1. Measure current load, p95 latency, request rate, cold-start duration, pod resources and minimum always-on replicas.
2. Set accurate CPU/memory requests based on observed usage; configure HPA for API replicas and external metrics for queue workers where appropriate.
3. Choose one coherent node-provisioning mechanism (managed ASG + Cluster Autoscaler, Karpenter, or supported EKS Auto Mode design).
4. Maintain baseline multi-AZ headroom, subnet IP capacity, instance quotas and suitable node pool limits for spikes.
5. Configure readiness probes, topology spread, PDBs and scale-down stabilization to prevent oscillation.
6. Load-test from normal to peak traffic and observe time to first healthy pod, node provisioning delays, latency and cost.

**Practical commands / query:**

```bash
kubectl get hpa -A
kubectl get pods -A --field-selector=status.phase=Pending
kubectl describe pod <pending-pod> -n <ns>
```

### 3. Production Example

A risk-check API usually sees 300 requests/s but spikes to 1,000. I would keep enough healthy replicas for normal latency, have HPA scale with CPU plus request/latency-related metrics where available, and let Karpenter add diversified EC2 capacity. I would keep critical steady workloads on reliable baseline nodes and avoid assuming Spot capacity always exists.

### 4. Troubleshooting

- HPA increases replicas but pods remain Pending: check scheduler events, quotas, autoscaler events and subnet free IP addresses.
- New node takes too long: inspect EC2 quota, allowed instance types, AMI bootstrap and capacity availability.
- Costs rise after a spike: check scale-down settings, daemonset overhead, PDBs and insufficient rightsizing.
- Scaling does not fix slow database queries; correlate latency with dependency saturation.

**Interview conclusion:**

> HPA scales pods; node scaling supplies compute. Right requests, multi-AZ capacity and load tests prevent underprovisioning.

---

<a id="q22"></a>
## Question 22: An EKS pod is Pending, ImagePullBackOff, or ErrImagePull. How do you troubleshoot?

### 1. Concept

`Pending` means Kubernetes has not started the pod successfully, frequently because scheduling or volumes are blocked. `ImagePullBackOff`/`ErrImagePull` means kubelet cannot retrieve the container image. Causes include wrong image tags, private ECR permissions, missing registry networking, CPU/memory capacity, taints/affinity, AZ constraints or PersistentVolume problems. The pod **Events** field usually points toward the correct branch of investigation.

### 2. Implementation — Step by Step

1. Run `kubectl describe pod` and read Events, then distinguish **FailedScheduling**, **FailedMount**, **FailedPull**, registry timeout and auth failures.
2. For scheduling: inspect node allocatable capacity, requests, topology rules, taints/tolerations, priority classes, PVC/PV status and resource quotas.
3. For image issues: verify ECR repository, Region, image tag/digest, node or pod pull credential permissions, and VPC network path to ECR API/DKR and S3 as applicable.
4. Confirm CoreDNS and VPC DNS, NAT and required VPC endpoints for private nodes. Inspect EKS node role and container runtime logs when needed.
5. Fix only the failed layer, redeploy and observe image download, pod readiness and service routing.

**Practical commands / query:**

```bash
kubectl describe pod <pod> -n <ns>
aws ecr describe-images --repository-name <repo> --image-ids imageTag=<tag>
kubectl get nodes -o wide
```

### 3. Production Example

A production image deployment is stuck in `ImagePullBackOff` after moving worker nodes into private subnets. I would check ECR endpoint connectivity and the required S3 layer-download path, as well as node IAM access. If the new subnets lack NAT and VPC endpoints, I would add the necessary endpoints and verify the image is pulled successfully.

### 4. Troubleshooting

- `no matching image`: wrong tag/architecture; compare image digest and node architecture.
- `403 AccessDenied`: check repository/resource policy, node identity and cross-account ECR permissions.
- `i/o timeout`: check DNS, SG for endpoint, endpoint availability and route/NAT path.
- `0/X nodes available`: inspect node constraints, requests, autoscaler and pending PVCs.

**Interview conclusion:**

> Use `describe pod` first, then split troubleshooting into scheduler capacity, storage, registry permission and network reachability.

---

<a id="q23"></a>
## Question 23: How would you secure EKS ingress, ECR image pulls, S3/Secrets Manager access, and outbound traffic?

### 1. Concept

An EKS pod needs two independent identities: Kubernetes identity for cluster actions and AWS IAM identity for AWS APIs. **EKS Pod Identity** or **IRSA** provides role credentials to workloads without putting shared AWS keys in Secrets. Use ECR repositories with scanning and scoped pull permissions; use ALB ingress or Gateway API controllers appropriate to your platform; keep workloads private and restrict east-west and outbound traffic using supported network policies/firewall design. AWS Secrets Manager plus a CSI driver or API access can deliver secrets securely.

### 2. Implementation — Step by Step

1. Create private nodes and an approved ingress entry point such as an internet-facing or internal ALB, with ACM TLS and optional WAF.
2. Configure AWS Load Balancer Controller/access permissions or supported EKS Auto Mode load balancing according to the cluster design.
3. Authorize the node/EKS mechanisms to pull from ECR; restrict image repositories, scan images and pin by digest for critical releases.
4. Associate an IAM role with each workload via EKS Pod Identity/IRSA, granting only specific S3 object prefixes or secret ARNs.
5. Configure VPC gateway/interface endpoints to reduce NAT dependence; apply network policies supported by your EKS networking mode.
6. Turn on CloudTrail/CloudWatch/Container Insights and alert on denied API calls, unusual egress and application errors.

**Practical commands / query:**

```bash
aws eks list-pod-identity-associations --cluster-name <cluster>
kubectl describe serviceaccount <name> -n <ns>
kubectl get ingress -A
```

### 3. Production Example

A document-processing pod needs read-only access to a confidential S3 bucket and one database secret. I would use a dedicated service account with Pod Identity, two narrowly scoped IAM actions, an S3 gateway endpoint, a Secrets Manager endpoint when appropriate, and policies that block use of other buckets. It would not inherit broad node role privileges.

### 4. Troubleshooting

- `AccessDenied` in a pod: check pod IAM credential source, association/OIDC, role policy, bucket/secret policy and KMS key.
- ALB ingress 503: confirm registered pod targets, readiness, SG rules and controller events.
- Secret mount fails: inspect CSI driver, IAM role, endpoint DNS and KMS permissions.
- Outbound blocked: check route, proxy, firewall rules and intended endpoints, not just Kubernetes NetworkPolicy.

**Interview conclusion:**

> Use TLS ingress, per-pod IAM, approved images, private endpoints and logs to secure each EKS application.

---

<a id="q24"></a>
## Question 24: How would you migrate an on-premises Kubernetes application to Amazon EKS without downtime?

### 1. Concept

Kubernetes migration includes **application compatibility, container image movement, infrastructure, secrets, network connectivity and stateful data migration**. Moving only deployment YAML is not enough. Choose rehost/replatform/refactor for each service, and keep the old platform healthy until cutover criteria are met. For stateful applications, define replication, consistency, cutover ownership and a rollback point.

### 2. Implementation — Step by Step

1. Inventory app manifests/Helm releases, Kubernetes versions, CRDs/controllers, storage classes, ingress, DNS, secrets and external dependencies.
2. Build EKS and VPC infrastructure with Terraform; establish VPN/Direct Connect and private DNS for on-prem dependencies.
3. Move signed container images to ECR. Replace cluster-specific storage/ingress/identity integrations with EKS-compatible equivalents.
4. Migrate data using appropriate replication, AWS DMS/Storage Gateway or storage copy according to stateful workload needs.
5. Run parallel smoke/load tests and production-like reconciliation. Use canary routing or weighted DNS to shift limited traffic.
6. Monitor error rate and data consistency, then complete controlled cutover. Preserve rollback by delaying decommissioning until agreed exit criteria.

**Practical commands / query:**

```bash
kubectl api-resources
kubectl get pvc -A
kubectl rollout status deployment/<app> -n <ns>
```

### 3. Production Example

For an internal pricing service, I would deploy its stateless API on EKS while database replication runs in parallel to an AWS database. I would route small percentage traffic to EKS, validate business response equality, then increase gradually. If error rate spikes, return traffic to on-prem while preserving transaction consistency.

### 4. Troubleshooting

- CRDs/API versions incompatible: convert manifests and upgrade controllers before cutover.
- PVC fails to bind: inspect storage class, AZ binding and CSI permissions.
- Private DNS/route to on-prem fails: validate VPN/BGP/Resolver path.
- Rollback after writes begin needs a data strategy; DNS reversal alone may cause split-brain or data loss.

**Interview conclusion:**

> Inventory dependencies, provision EKS, migrate images/data, validate in parallel, shift traffic gradually and keep a tested rollback.

---

# Section D — CloudWatch, Centralized Logging and SRE Observability

<a id="q25"></a>
## Question 25: How would you design centralized logging and monitoring across AWS accounts, Regions, EC2, EKS, Lambda and RDS?

### 1. Concept

Central observability combines **logs, metrics, traces and audit events** into a shared investigative view, but these are different data types. **CloudWatch Logs** stores/queries application and service logs; CloudWatch metrics/alarms support health monitoring; **CloudTrail** records AWS API activity; X-Ray/OpenTelemetry tracing follows application requests. AWS has CloudWatch cross-account observability and AWS Organizations-based cross-account/Region log centralization; a security lake or S3 archive may serve separate retention/compliance needs. Copying all logs to S3 alone does not create operational search or alerting.

### 2. Implementation — Step by Step

1. Create a dedicated observability/security account and an AWS Organizations strategy for source accounts. Decide Regions, retention and data-classification policy.
2. Set EC2 CloudWatch Agent, EKS Fluent Bit/Container Insights or OpenTelemetry, Lambda log groups and supported RDS log exports.
3. Use **CloudWatch cross-account observability (OAM)** for linked telemetry views; consider CloudWatch Logs centralization rules for actual log replication where suitable.
4. Collect CloudTrail organization trails, AWS Config and VPC Flow Logs into protected destinations with encryption and least-privilege access.
5. Build common dashboards for golden signals, alerts with SNS/on-call integrations, and Logs Insights queries. Mask sensitive customer data.
6. Test missing-log alerts, cross-account visibility, ingestion latency, cost and recovery of archived evidence.

**Practical commands / query:**

```bash
aws logs describe-log-groups --log-group-name-prefix /aws/
aws cloudtrail describe-trails
```

### 3. Production Example

For 20 finance application accounts, I would standardize JSON logs with correlation IDs, centralize operational viewing and selected log retention, and preserve a separately controlled security archive. On-call SREs could search API and EKS logs together while auditors retain immutable change history according to policy.

### 4. Troubleshooting

- No cross-account view: check OAM source-link/sink permissions, Region and account membership.
- No replicated log: check centralization rule selectors, Organizations trusted access and note that rules generally process newly arriving data.
- Unexpected ingestion cost: check verbose application logs, retention, duplicate replication and noisy dimensions.
- Sensitive data in logs: stop new exposure, restrict access and follow approved incident/privacy process.

**Interview conclusion:**

> Central logging needs collectors, cross-account access, searchable stores, metrics/alerts and retention controls—not just one S3 bucket.

---

<a id="q26"></a>
## Question 26: Explain step by step how to configure CloudWatch Agent, Logs, metrics, alarms, SNS notifications and runbooks.

### 1. Concept

CloudWatch gathers AWS service metrics automatically, but EC2 **guest memory/disk metrics** usually require the CloudWatch Agent or another monitoring agent. An alarm evaluates a chosen metric and threshold over configured periods and enters OK/ALARM/INSUFFICIENT_DATA. **SNS** can notify on-call tools and Lambda/Systems Manager can automate approved responses. Logs go into a CloudWatch log group with retention and encryption settings; metric filters can convert matching log patterns into metrics.

### 2. Implementation — Step by Step

1. Give EC2 an instance role with the minimum CloudWatch Agent/SSM permissions; install CloudWatch Agent and Systems Manager Agent as required.
2. Configure the agent to collect memory, disk, CPU, system/application log paths and appropriate dimensions. Deploy configuration with SSM State Manager or IaC.
3. Create log groups with retention/KMS and useful names such as `/prod/payments/api`.
4. In **CloudWatch → Alarms → Create alarm**, select metric, statistic, period, evaluation periods, threshold and missing-data behavior.
5. Create an SNS topic with verified subscriptions or on-call integration and attach it as the alarm action.
6. Test alert firing and recovery, record runbook steps and use CloudWatch Logs Insights to investigate supporting evidence.

**Practical commands / query:**

```bash
sudo systemctl status amazon-cloudwatch-agent
aws cloudwatch describe-alarms --alarm-names <alarm-name>
aws logs tail /prod/payments/api --since 30m
```

### 3. Production Example

For EC2 payment workers I would set memory/disk alarms at thresholds based on baselines, create high 5xx alarms from application logs/ALB metrics, and route alerts to the primary on-call escalation path. Automatic restarts would be limited to well-understood, safe failure modes.

### 4. Troubleshooting

- No memory metric: verify agent running, configuration file, IAM role and network access to CloudWatch endpoints.
- Alarm stays INSUFFICIENT_DATA: inspect exact metric dimensions, evaluation periods and collection frequency.
- SNS has no notification: check topic policy, subscription confirmation, downstream integration and alarm action.
- Logs missing: verify file path/permissions, agent status, group name and retention.

**Interview conclusion:**

> Install/configure CloudWatch Agent, collect structured logs and guest metrics, define tested alarms and attach on-call actions.

---

<a id="q27"></a>
## Question 27: Compare CloudWatch, CloudTrail, AWS X-Ray, Container Insights, Managed Prometheus and Managed Grafana.

### 1. Concept

**CloudWatch** is AWS operational telemetry (metrics, logs, alarms, dashboards). **CloudTrail** is an API activity/audit record. **X-Ray** is distributed request tracing, including compatible OpenTelemetry integrations. **Container Insights** collects EKS/ECS cluster/workload telemetry. **Amazon Managed Service for Prometheus (AMP)** stores Prometheus-compatible metrics; **Amazon Managed Grafana (AMG)** visualizes multiple sources. They solve complementary tasks: knowing that a request failed, why it failed, and who changed infrastructure are separate questions.

### 2. Implementation — Step by Step

1. Classify the question first: availability metric, application exception log, request dependency trace or AWS API change.
2. Enable CloudWatch logs/metrics and alarm thresholds for infrastructure. Instrument apps with OpenTelemetry where suitable for traces and request-level context.
3. For EKS, install supported Container Insights/Prometheus collectors and forward data to chosen CloudWatch/AMP systems.
4. Use Grafana/CloudWatch dashboards for latency, traffic, errors and saturation; set alerts in the approved on-call platform.
5. Create CloudTrail organization trail/CloudTrail Lake configuration as applicable and protect audit records in encrypted, restricted destinations.
6. Use a common trace ID or transaction ID to correlate ALB access record, API log, downstream trace and dependency error.

**Practical commands / query:**

```bash
aws cloudtrail lookup-events --max-results 10
aws cloudwatch list-metrics --namespace AWS/EC2
aws logs describe-log-groups
```

### 3. Production Example

A payment request times out. CloudWatch indicates p99 latency is high; an X-Ray/OpenTelemetry trace shows most time is spent waiting for RDS; CloudTrail shows a connection-limit change earlier in the day. Combined evidence gives a stronger RCA than a single CPU graph.

### 4. Troubleshooting

- Missing traces: inspect SDK instrumentation, exporter endpoint, sampling and IAM.
- Prometheus metric gaps: check scraper targets, remote write/authentication and retention.
- CloudTrail doesn’t show application SQL operations; use database audit/transaction telemetry separately.
- Dashboards can show different sampling periods; align time windows before comparing them.

**Interview conclusion:**

> Use CloudWatch for health, X-Ray/OTel for request tracing, CloudTrail for API audits and Prometheus/Grafana for detailed metrics.

---

<a id="q28"></a>
## Question 28: How would you monitor EC2 CPU, memory, disk and application response times with meaningful alarms?

### 1. Concept

EC2 provides basic infrastructure metrics such as CPU utilization in CloudWatch, while memory and disk utilization generally require a guest agent. Disk space is different from EBS service metrics such as read/write operations and latency. For reliability, combine resource signals with **user-facing latency, error rate and request throughput**. Alert thresholds should reflect baseline usage, business impact, seasonality and time windows, not arbitrary hard-coded values alone.

### 2. Implementation — Step by Step

1. Collect default EC2 metrics and enable detailed monitoring where the monitoring frequency is justified.
2. Install CloudWatch Agent to gather guest memory/disk and selected log files, tagged with InstanceId/environment.
3. Instrument application requests with metrics/ALB target response time and include p95/p99 latency if available.
4. Create alarms on sustained CPU, low disk free space, memory, 5xx and availability; choose missing-data settings deliberately.
5. Configure composite alarms or alert grouping to reduce duplicate incidents, plus on-call SNS routing.
6. Run a controlled load test, compare expected and observed alarms, then update runbooks and scaling thresholds.

**Practical commands / query:**

```bash
aws cloudwatch describe-alarms
aws ec2 describe-instances --instance-ids <instance-id>
```

### 3. Production Example

For a reconciliation service with nightly spikes I would use separate baselines for day and batch-processing periods. A high CPU alarm would be paired with queue age and API latency; if CPU is high but jobs complete within SLO, it may not justify paging an engineer.

### 4. Troubleshooting

- No guest memory: CloudWatch Agent or its IAM permissions/configuration may be missing.
- Disk alarm wrong: distinguish mount points and container overlay storage from underlying EBS IOPS.
- Alarm storms: group symptom and root-cause alerts, use composite alarms and time-window tuning.
- Healthy CPU with slow app: inspect RDS calls, lock contention, DNS, network and dependency traces.

**Interview conclusion:**

> I monitor both infrastructure saturation and customer impact; agent setup, dimensions and tested alarm thresholds matter.

---

<a id="q29"></a>
## Question 29: How do you set CloudWatch alarms for ALB 5xx, slow APIs, failed deployments and unhealthy infrastructure?

### 1. Concept

A production alert should indicate **actionable impact**, not simply a changing metric. For ALB, distinguish ALB-generated 5xx and target-generated 5xx, and calculate error rate in relation to total requests where useful. For application latency, p95/p99 and dependency traces provide context. EventBridge can route deployment state changes to SNS/on-call systems. CloudWatch alarms should define evaluation periods, missing-data treatment and ownership.

### 2. Implementation — Step by Step

1. Create CloudWatch metric alarms for `HTTPCode_ELB_5XX_Count`, `HTTPCode_Target_5XX_Count`, `UnHealthyHostCount` and `TargetResponseTime` for the relevant ALB dimensions.
2. Build a metric-math error rate if needed, considering low-volume divide-by-zero behavior.
3. Instrument app p95 latency and business-transaction failures through CloudWatch/custom metrics or Prometheus.
4. Create an EventBridge rule for relevant deployment failure events (CodeDeploy, pipeline service events) and route to SNS/incident tooling.
5. Use composite alarms, thresholds based on SLO/error budget and alarm descriptions containing runbook links.
6. Test an unhealthy target and a failed staged deployment; confirm the right on-call engineer is notified, not every team.

**Practical commands / query:**

```bash
aws cloudwatch describe-alarms --state-value ALARM
aws elbv2 describe-target-health --target-group-arn <tg-arn>
```

### 3. Production Example

For an account-transfer API I might page when the five-minute error rate exceeds the SLO burn-rate policy and a minimum traffic threshold, while an isolated single 500 triggers a ticket instead. Deployment failure alerts would include pipeline ID and change commit for fast rollback.

### 4. Troubleshooting

- Alarms never trigger: verify dimensions, numerator/denominator and metric reporting interval.
- Alarm triggers on no traffic: set appropriate missing-data behavior and minimum request count.
- SNS delivery missing: inspect confirmed subscription and target permissions.
- A 502 spike from targets may be due to app readiness, not infrastructure CPU; inspect logs.

**Interview conclusion:**

> Alert on customer-impacting 5xx, latency, deployment failure and unhealthy targets, with tuned windows and clear runbooks.

---

<a id="q30"></a>
## Question 30: A production AWS application is slow while EC2/EKS CPU and memory appear normal. What would you investigate?

### 1. Concept

Normal CPU/memory do not prove an application is healthy. Latency may come from **database waits, connection-pool exhaustion, DNS, network retries, external APIs, thread contention, disk I/O, queueing, or downstream throttling**. Investigate the full request journey and compare p50/p95/p99 latency, error rates and dependency timing. The first action should protect users—rollback a recent change or shed noncritical load if necessary—while preserving evidence.

### 2. Implementation — Step by Step

1. Identify when degradation began, which endpoints/Regions/AZs are affected and whether it correlates with a deployment or dependency change.
2. Review ALB TargetResponseTime and access logs, application request traces and CloudWatch Logs Insights for slow transactions.
3. Use OpenTelemetry/X-Ray distributed traces to locate the slow span (RDS, Redis, SNS/HTTP dependency, DNS).
4. Inspect RDS/Aurora connection count, locks, query latency, storage I/O and CPU credit balances where relevant.
5. Test DNS resolution and TCP connectivity from an affected pod/instance and inspect retransmission/timeout patterns.
6. Mitigate with traffic rollback, safe scaling, circuit breakers or concurrency limits, then validate p95 and transaction completion.

**Practical commands / query:**

```bash
aws logs start-query --log-group-name /prod/api --start-time <epoch-start> --end-time <epoch-end> --query-string 'fields @timestamp, @message | filter @message like /timeout/ | sort @timestamp desc | limit 20' 
```

### 3. Production Example

A market-data API slows from 200 ms to 2 s despite normal pod CPU. Trace data shows calls to a partner endpoint timing out and retrying three times. I would apply bounded retries/timeouts, a circuit breaker and graceful degradation while coordinating with the dependency team.

### 4. Troubleshooting

- Slow p99 only: inspect cold starts, garbage collection, lock contention or long-tail dependencies.
- Database latency: check active sessions, slow queries and transaction locks.
- DNS/network issue: compare same request from healthy and unhealthy AZs.
- High retry traffic can create cascading failure; cap retries and avoid synchronized retries.

**Interview conclusion:**

> Start from a slow request trace, follow its dependencies and fix the true bottleneck instead of resizing healthy instances.

---

<a id="q31"></a>
## Question 31: How would you use CloudWatch Logs Insights to identify HTTP 500 errors, slow endpoints and recent deployment failures?

### 1. Concept

CloudWatch Logs Insights queries log groups for operational evidence. For JSON structured logs, fields such as `status`, `path`, `duration_ms`, `trace_id` and `deployment_version` make incident queries much easier than searching unstructured lines. Use `fields`, `filter`, `stats`, `sort`, `limit` and time-window selection. Queries return data only from selected groups and retention periods. Restrict access because logs may contain sensitive data.

### 2. Implementation — Step by Step

1. Standardize application logs with timestamp, environment, service, severity, HTTP status, route, duration and trace/correlation ID.
2. Open **CloudWatch → Logs Insights**, choose the relevant log groups and a narrow incident time range.
3. Filter `status >= 500` and aggregate failures by endpoint and deployment version.
4. For latency, calculate statistics such as `pct(duration_ms, 95)` grouped into `bin(5m)` windows.
5. Correlate spikes with CodeDeploy/CI/CD event history or CloudTrail changes.
6. Save common queries into runbooks or dashboards and automate incident evidence collection when appropriate.

**Practical commands / query:**

```text
# CloudWatch Logs Insights query for JSON application records:
fields @timestamp, path, status, duration_ms, deployment_version
| filter status >= 500
| stats count() as errors by path, deployment_version
| sort errors desc
| limit 20

# p95 latency over time:
fields @timestamp, duration_ms
| stats pct(duration_ms, 95) as p95_ms by bin(5m)
```

### 3. Production Example

During an API outage I would run a five-minute query for 5xx grouped by route and revision. If almost all failures start on `release-2026.10.13`, that strongly points to the deployment rather than a VPC routing issue. I would rollback and attach the query results to the incident record.

### 4. Troubleshooting

- Empty results: verify Region/account, log group, time range, ingestion delay and field names.
- Incorrect parsing: change emitter to valid JSON logs or use `parse`.
- High query cost: narrow time range and groups; avoid scanning verbose logs unnecessarily.
- Do not log account numbers, access tokens or full sensitive transaction payloads.

**Interview conclusion:**

> Use structured JSON logs and Logs Insights aggregation to isolate affected routes, time windows and deployments.

---

<a id="q32"></a>
## Question 32: CloudWatch Logs suddenly stops receiving application logs. How would you diagnose the collection pipeline?

### 1. Concept

A log ingestion problem might be in **emission, agent/collector, credentials, DNS/network, destination configuration, service limits or retention**. Treat logging failure as a reliability/security incident because operational evidence may disappear. Determine whether only one host, one AZ, one account, or every workload is affected. Use an independent signal, such as application request counts or metrics, to confirm that the application is still active.

### 2. Implementation — Step by Step

1. Check that the app is writing to the expected file/stdout and that the source process has not crashed.
2. For EC2, inspect CloudWatch Agent service and configuration; for EKS, inspect Fluent Bit/OTel DaemonSet logs and resource pressure; for Lambda, check log-group IAM and execution.
3. Verify agent IAM permission to create log streams and put events; check log group and stream names/Region.
4. Check NAT or VPC endpoint connectivity, DNS, security-group egress, TLS trust and local buffering/backpressure.
5. Review CloudWatch service metrics/errors and log retention/KMS policies; ensure clocks and timestamp formats are sane.
6. Restore ingestion and measure the missing interval; decide whether local buffers can replay lost log events and add an ingestion heartbeat alarm.

**Practical commands / query:**

```bash
sudo systemctl status amazon-cloudwatch-agent
kubectl get daemonsets -A
aws logs describe-log-streams --log-group-name <group> --order-by LastEventTime --descending
```

### 3. Production Example

Suppose EKS workloads run normally but their logs disappear after a cluster node upgrade. I would check Fluent Bit DaemonSet pods and node scheduling. If the collector was excluded from new nodes by selectors or taints, I would fix its deployment, verify log arrival and adjust the upgrade checklist.

### 4. Troubleshooting

- Agent PermissionDenied: check role policy and KMS permissions if encryption is involved.
- Collector OOM: inspect memory limits, batching/buffering and log volume.
- Wrong Region/log group: query the correct context rather than assuming logs are absent.
- Retention expiry cannot normally be solved by agent restart; use archived copies if available.

**Interview conclusion:**

> Follow the chain app → collector → IAM/network → CloudWatch, then prove ingestion has resumed with a test message.

---

<a id="q33"></a>
## Question 33: How would you define SLI, SLO, SLA and error budgets for an AWS payment API?

### 1. Concept

An **SLI** measures observed service behavior, such as successful requests divided by valid requests or p95 latency. An **SLO** is the internal target (for example, 99.95% successful valid requests per rolling month). An **SLA** is a contractual promise with business consequences. The **error budget** is the amount of unreliability permitted by the SLO. Monitoring should use customer-visible, properly scoped transactions, not only whether an EC2 instance says `running`.

### 2. Implementation — Step by Step

1. Select customer journeys: login, transfer initiation and transfer confirmation. Define which HTTP codes/business outcomes count as success.
2. Instrument requests and calculate availability, latency and correct transaction outcomes using CloudWatch/custom metrics or Prometheus.
3. Choose realistic SLOs and rolling windows with business owners; define separate p95 latency targets and availability targets.
4. For 99.95% availability over a 30-day month, allowable unavailable time is `30 × 24 × 60 × 0.0005 = 21.6 minutes`.
5. Set multi-window burn-rate alerts rather than waiting for an entire month of error budget to disappear.
6. Link release policies to error budget: pause risky launches during excessive burn, invest in fixes, and review SLOs after incidents.

**Practical commands / query:**

```bash
# Example calculation (illustrative):
# 99.95% in 30 days -> 21.6 minutes of error budget
# Availability = successful_valid_requests / total_valid_requests * 100
```

### 3. Production Example

For a financial transaction API I would measure requests that produce a correct acknowledged business outcome, not just HTTP 200. A duplicate transfer or incorrect balance is a reliability failure even if the network request returned quickly. I would alert on error budget burn and track mitigation time in incident reviews.

### 4. Troubleshooting

- If latency is high but success rate is good, a separate latency SLO may still be violated.
- Synthetic checks can be green while real transactions fail; use real-user/business telemetry too.
- Define how retries, invalid client requests and planned maintenance affect the denominator.
- Avoid using SLA and SLO as interchangeable terms in interview answers.

**Interview conclusion:**

> SLI is measurement, SLO is the reliability target, SLA is the agreement, and error budget guides release risk.

---

# Section E — S3, SQS, SNS, EventBridge, Kinesis and PaaS

<a id="q34"></a>
## Question 34: How would you securely connect an application in a private VPC subnet to Amazon S3?

### 1. Concept

S3 is a managed service with public service endpoints, but a private subnet application can access it through a **gateway VPC endpoint** or suitable S3 interface endpoint configuration. A gateway endpoint adds a route-table destination for S3 and avoids needing NAT for eligible access paths. Strong security combines **network path + IAM role + bucket policy + KMS access**. An endpoint does not mean the bucket automatically permits the caller. Avoid placing S3 static access keys in application code; use EC2 instance profiles or EKS Pod Identity/IRSA.

### 2. Implementation — Step by Step

1. Create a bucket with Block Public Access enabled, encryption, versioning and access logging/auditing policies as required.
2. Create a VPC gateway endpoint for S3 and associate it with the application private subnet route tables.
3. Attach a narrowly scoped IAM role to the EC2 instance/EKS workload with only necessary `s3:GetObject`, `s3:PutObject` or `s3:ListBucket` permissions.
4. If using a restrictive S3 bucket policy, allow only expected principals and network endpoints (`aws:SourceVpce`) and review special access required by backup/replication/services.
5. Configure KMS key policies/grants when SSE-KMS is enabled and verify the role can encrypt/decrypt as needed.
6. Validate a real read/write with AWS CLI or SDK from the workload and monitor CloudTrail data events when enabled.

**Practical commands / query:**

```bash
aws sts get-caller-identity
aws ec2 describe-vpc-endpoints --filters Name=service-name,Values=com.amazonaws.<region>.s3
aws s3 ls s3://<bucket-name>/
```

### 3. Production Example

A private fraud-detection pod needs to fetch risk-model data from `s3://risk-models/production/`. I would attach a scoped workload role, create an S3 gateway endpoint, and restrict access to that prefix. The bucket would not allow public access, and I would test that an unapproved workload cannot read it.

### 4. Troubleshooting

- S3 returns 403: evaluate IAM role, bucket policy, endpoint policy, KMS key, object ownership and Organizations restrictions.
- Connection timeout: check subnet route-table endpoint association, DNS and VPC path.
- Wrong credential source: run STS from the workload to verify the principal.
- An overly strict `aws:SourceVpce` condition can break allowed cross-account or AWS service access; test access paths before enforcing.

**Interview conclusion:**

> Use private S3 endpoint routing, short-lived workload IAM credentials, encryption and restrictive bucket policies.

---

<a id="q35"></a>
## Question 35: Compare Amazon SQS, SNS, EventBridge, Kinesis Data Streams and Amazon MSK. When would you use each?

### 1. Concept

These services handle different event or messaging patterns. **SQS** is a durable queue for decoupled workers (standard queues generally at-least-once delivery; FIFO adds ordered/message-group semantics and deduplication behavior). **SNS** publishes notifications to multiple subscribers. **EventBridge** routes events using rules, buses, filters, schedules and targets. **Kinesis Data Streams** captures/retains high-throughput ordered-by-shard stream records with replay by consumers. **Amazon MSK** runs managed Apache Kafka, useful when applications need Kafka APIs and ecosystem. Event notifications can have duplicates, so consumers should be idempotent.

### 2. Implementation — Step by Step

1. Map the need: queue one job for workers, broadcast one event, route filtered business events, or process high-volume replayable streams.
2. For background jobs create SQS queue, configure visibility timeout, long polling, encryption, DLQ/redrive policy and worker scaling.
3. For fanout, publish to SNS and subscribe independent SQS queues, with filtering and access policies.
4. For service event routing, create EventBridge rule patterns/targets and enable DLQs/retries when supported.
5. For ordered/high-throughput analytics, choose Kinesis or MSK and plan shards/partitions, throughput and checkpointing.
6. Implement idempotency, correlation IDs, alarm on queue age/DLQ depth and protect sensitive message contents.

**Practical commands / query:**

```bash
aws sqs get-queue-attributes --queue-url <queue-url> --attribute-names All
aws events list-rules
aws kinesis list-streams
```

### 3. Production Example

When a payment settles, I might publish an EventBridge business event. One rule sends a task to an audit SQS queue and another invokes a fraud analysis service; a separate Kinesis stream ingests clickstream/telemetry. Each consumer uses a transaction ID to prevent duplicate processing.

### 4. Troubleshooting

- Unprocessed queue: check consumer health, IAM, visibility timeout and DLQ redrive.
- Lost-looking SNS message: verify subscription confirmation, topic policy, filtering and target metrics.
- EventBridge rule not firing: check event bus, event pattern and input schema.
- Stream consumer lag: check shard capacity, throttles, checkpointing and hot partition keys.

**Interview conclusion:**

> SQS queues work, SNS fans out, EventBridge routes events, and Kinesis/MSK handle high-volume ordered streams.

---

<a id="q36"></a>
## Question 36: How would you configure Kinesis Data Streams for high-throughput events and troubleshoot consumer lag?

### 1. Concept

Kinesis Data Streams accepts records grouped by **partition key** into shards (or on-demand stream capacity). Ordering is guaranteed within a shard for its records, not globally across all partition keys. Consumers use KCL or enhanced fan-out/other APIs, with **checkpointing** to resume safely. High `IteratorAgeMilliseconds`, throttling, hot shards and processing errors can explain slow downstream results. Choose retention, encryption, capacity mode and partition keys based on workload.

### 2. Implementation — Step by Step

1. Create a Kinesis stream in on-demand or provisioned mode according to predictable or bursty throughput needs.
2. Define stable partition keys that distribute traffic without losing per-entity ordering requirements.
3. Grant producer role minimal `kinesis:PutRecord(s)` permissions and consumer role minimal read/describe permissions.
4. Create a KCL consumer or managed processor, checkpoint only after successful processing and make operations idempotent.
5. Enable CloudWatch metrics such as WriteProvisionedThroughputExceeded, ReadProvisionedThroughputExceeded and IteratorAgeMilliseconds.
6. Load-test uneven keys, consumer restarts and throttling; scale stream capacity or consumer concurrency based on measured lag.

**Practical commands / query:**

```bash
aws kinesis describe-stream-summary --stream-name <stream>
aws kinesis list-shards --stream-name <stream>
```

### 3. Production Example

A fraud-detection system ingests card authorization events and needs ordering per card. I would choose card ID as a partition key while testing for hot keys, use a consumer that checkpoints processed batches, and alarm when iterator age exceeds the decision latency target.

### 4. Troubleshooting

- High iterator age: inspect slow downstream DB, underprovisioned consumers or retry loops.
- Throttled producer: examine per-shard write limits and skewed partition keys.
- Duplicate processing after restart: checkpoints and idempotency must be correct.
- Missing older events: check stream retention and whether the consumer has fallen beyond the retention window.

**Interview conclusion:**

> Correct partitioning, consumer checkpointing, idempotency and iterator-age alarms are the heart of reliable Kinesis operations.

---

<a id="q37"></a>
## Question 37: How would you create an S3 event → EventBridge → Lambda pipeline with retries and a DLQ?

### 1. Concept

Event-driven processing can start when an object reaches S3. S3 can publish supported events to EventBridge after EventBridge delivery is enabled for the bucket; EventBridge rules match event patterns and send them to Lambda, queues or other targets. Delivery and processing may be retried, so the Lambda should be **idempotent**. Distinguish an EventBridge target **DLQ** from a Lambda asynchronous invocation failure destination/DLQ: they cover different failure stages. Event order should not be assumed across independent uploads.

### 2. Implementation — Step by Step

1. Create a secure S3 bucket and enable **EventBridge notifications** in the bucket event notification settings.
2. Create a Lambda execution role with permission to read only the needed bucket prefix and publish logs.
3. Create an EventBridge rule matching the correct S3 event source/detail type, bucket and object conditions.
4. Add Lambda as a target; allow EventBridge to invoke it. Configure a target DLQ where supported and alarms for failed invocations.
5. Write Lambda handler to validate the event, retrieve the object, use its bucket/key/version identifier as an idempotency key and record processing status.
6. Upload a test object and inspect EventBridge matched events, Lambda logs and failure destinations.

**Practical commands / query:**

```bash
aws events list-rules
aws lambda get-function --function-name <function>
aws logs tail /aws/lambda/<function> --since 15m
```

### 3. Production Example

In a document verification workflow, a PDF upload to `incoming/` triggers a Lambda that validates metadata and posts a processing job to SQS. If EventBridge cannot deliver, the target DLQ captures the failed event; if Lambda starts but fails while processing, Lambda retries/asynchronous failure configuration handles that stage. Duplicate object events do not duplicate business work.

### 4. Troubleshooting

- Rule mismatch: inspect the actual event JSON and detail keys, not assumptions about shape.
- No Lambda invoke: check resource-based invoke permission and target ARN.
- Function errors: use CloudWatch logs, timeout/memory graphs and downstream IAM.
- Repeated work: verify idempotency key and successful-state storage; EventBridge/S3 delivery is not guaranteed exactly once.

**Interview conclusion:**

> Enable S3-to-EventBridge, configure precise rule and Lambda permission, and design retries/DLQs/idempotency.

---

<a id="q38"></a>
## Question 38: How would you design reliable SQS processing with visibility timeout, retries, DLQ, FIFO and worker autoscaling?

### 1. Concept

In **SQS Standard**, messages can be delivered more than once and out of order. When a worker receives a message, the **visibility timeout** hides it temporarily; the worker must delete the message after successful processing. If not deleted before visibility expiry, it can appear again. A **dead-letter queue (DLQ)** collects messages that exceed the allowed receive count. FIFO queues offer ordering per message group and deduplication semantics within documented constraints, but application idempotency remains valuable.

### 2. Implementation — Step by Step

1. Create the source queue and DLQ with correct access policies and KMS encryption if required.
2. Set visibility timeout longer than realistic processing time, or extend it programmatically during long jobs; configure a redrive policy with sensible maxReceiveCount.
3. Use long polling and batch receive where helpful, but acknowledge/delete only successfully processed messages.
4. Add deduplication/idempotency by business message ID in the downstream database to prevent duplicate charges or actions.
5. Scale workers using queue backlog per task and queue age; include maximum safe concurrency for downstream RDS/API limits.
6. Alarm on ApproximateAgeOfOldestMessage, DLQ depth, processing failures and worker health; practise controlled DLQ redrive.

**Practical commands / query:**

```bash
aws sqs get-queue-attributes --queue-url <url> --attribute-names ApproximateNumberOfMessages ApproximateNumberOfMessagesNotVisible
```

### 3. Production Example

A transfer statement generation service reads jobs from SQS. Each job carries a unique statement ID. A worker first checks if the statement has already been generated, processes it, commits the status, then deletes the SQS message. A poisoned job moves to DLQ for inspection instead of being retried forever.

### 4. Troubleshooting

- Message returns repeatedly: worker does not delete it or visibility timeout is too short.
- Queue age rises: worker scaling, DB throughput or concurrency limits are insufficient.
- DLQ grows: inspect first-failure reason, not just replay all messages.
- FIFO queue throughput constrained: choose message groups carefully; a single hot group serializes work.

**Interview conclusion:**

> Use idempotency, correct visibility timeout, DLQ and measured worker scaling to make SQS safe for important workloads.

---

<a id="q39"></a>
## Question 39: An application cannot publish to Kinesis, EventBridge, SNS or SQS. How would you troubleshoot authorization and connectivity?

### 1. Concept

Publishing failures can result from the **wrong principal, missing identity/resource permissions, KMS policy, wrong Region/account, endpoint DNS/routing, throttling or malformed payload**. An error response is valuable evidence: `AccessDenied` means something different from timeout or throttling. Cross-account event/messaging services often require a resource-based policy on the destination in addition to the caller's identity policy.

### 2. Implementation — Step by Step

1. Capture exact SDK exception code, request ID, timestamp, operation name, target ARN/URL and region; avoid exposing payload secrets in logs.
2. Run STS caller-identity within the failing workload or inspect its EKS Pod Identity/instance role.
3. Check caller IAM policy, destination SQS/SNS/EventBridge resource policy, KMS key policy and Organizations SCP restrictions.
4. Verify destination name/Region/account and supported service endpoint DNS. Test network path through NAT or interface endpoints as applicable.
5. Inspect CloudWatch service throttling, payload size and per-service limits; implement bounded retries with jitter for retryable errors.
6. Use a controlled publish test, observe subscriber/consumer result, then amend least-privilege permissions or capacity.

**Practical commands / query:**

```bash
aws sts get-caller-identity
aws sns get-topic-attributes --topic-arn <topic-arn>
aws events describe-event-bus --name <bus-name>
```

### 3. Production Example

A Python worker in EKS fails to send notifications to an SNS topic in another account. STS confirms the pod role is correct, but the destination topic policy does not authorize it. I would update the topic resource policy for that role and validate delivery, not give the pod `AdministratorAccess`.

### 4. Troubleshooting

- 403 AccessDenied: principal, identity/resource/KMS/SCP policies.
- Timeout: endpoint, DNS, NAT/VPC interface endpoint and SG/route.
- Throttling: implement exponential backoff with jitter and assess capacity quotas.
- Successful publish but no consumer delivery: inspect subscription filter, DLQ and downstream processor.

**Interview conclusion:**

> Classify the failure first; IAM/resource policy, network endpoint and service quotas each require a different fix.

---

<a id="q40"></a>
## Question 40: How would you choose and secure Lambda, ECS Fargate, App Runner, and API Gateway for a private application?

### 1. Concept

These AWS services differ in operational responsibility. **Lambda** is event-driven function execution with timeout/concurrency limits; **ECS on Fargate** runs containers without managing EC2 worker hosts; **App Runner** simplifies supported web-container deployments; **API Gateway** manages API entry, authorization, throttling and integrations. Private network requirements depend on service integration: Lambda VPC attachment puts ENIs into selected VPC subnets for outbound access to private resources but does not automatically make a Lambda invocation endpoint private. API Gateway has private API and private integration options.

### 2. Implementation — Step by Step

1. Identify execution model, duration, concurrency, protocol, latency and private data dependency needs.
2. For Lambda choose runtime, execution role, memory/timeout, concurrency, environment/secrets and VPC access only when necessary.
3. For ECS Fargate create task definition, per-task IAM role, service, private subnets, ALB target group and deployment/auto-scaling policies.
4. For App Runner evaluate private outbound access via VPC connector and supported ingress options based on service requirements.
5. Put API Gateway in front when authentication, quotas, API keys/authorizers, validation or private API patterns justify it.
6. Enable logs, traces, KMS/secrets, controlled deployment/rollback and load tests for start-up/concurrency behavior.

**Practical commands / query:**

```bash
aws lambda get-function-configuration --function-name <fn>
aws ecs describe-services --cluster <cluster> --services <service>
aws apigateway get-rest-apis
```

### 3. Production Example

A low-volume document validation task is a good Lambda candidate triggered from SQS/EventBridge. A continuously running payments API with stable connections and predictable traffic may fit ECS Fargate behind ALB. I would choose based on runtime and reliability, not because one service is universally cheaper.

### 4. Troubleshooting

- Lambda timeout: check function timeout, downstream latency, VPC DNS and concurrency throttles.
- Fargate task stops: inspect ECS stopped reason, task logs, image pulls, health checks and limits.
- API Gateway 403/429: inspect authorization, API resource policies and throttling quotas.
- Secrets access fails: check task/function role plus Secrets Manager/KMS permissions.

**Interview conclusion:**

> Choose compute by execution pattern, secure identities/networking separately, and test failure behavior with telemetry.

---

<a id="q41"></a>
## Question 41: Amazon S3 returns AccessDenied (403) from EC2, EKS or Lambda. How do you troubleshoot it?

### 1. Concept

An S3 `403 AccessDenied` is primarily an **authorization or policy condition** problem, although request-signing or endpoint configuration may contribute. The request must pass applicable caller IAM permissions, bucket/access-point policy, endpoint policy, Organizations guardrails and KMS permissions if SSE-KMS is used. Object ownership, requester-pays settings and block-public-access rules can also matter. Opening SGs indiscriminately will not solve a genuine S3 policy deny.

### 2. Implementation — Step by Step

1. Log the exact S3 operation (`ListBucket`, `GetObject`, `PutObject`) and target ARN/path; use STS to confirm the actual role.
2. Review the role policy. Note that listing a bucket uses the bucket ARN, while object actions use object ARNs (`bucket/*`).
3. Review bucket/access-point policy, explicit deny conditions (`aws:SourceVpce`, TLS, principal tags), endpoint policy, SCP/RCP and permission boundary.
4. For SSE-KMS, validate KMS key policy and required decrypt/generate data-key permissions.
5. Check network and DNS only if the error is a timeout or wrong endpoint; capture SDK exception request ID.
6. Temporarily test with a narrowly scoped known-good principal, fix the specific deny and retest from original workload.

**Practical commands / query:**

```bash
aws sts get-caller-identity
aws s3api head-object --bucket <bucket> --key <key>
aws s3 ls s3://<bucket>/
```

### 3. Production Example

A private EKS pod can list the production bucket but cannot download one encrypted object. I would check whether the key policy permits its workload role to `kms:Decrypt`. The different results for ListBucket and GetObject point toward object-level/KMS access rather than basic network failure.

### 4. Troubleshooting

- 403 only on ListBucket: inspect bucket-level ARN and permissions.
- 403 only on some objects: inspect prefixes, object owner/encryption and per-object authorization.
- 403 after adding endpoint: endpoint policy or `SourceVpce` condition may have changed path eligibility.
- Cross-account 403: check both sides and key grants; do not rely on one account policy alone.

**Interview conclusion:**

> I verify caller identity and exact S3 operation, then evaluate every policy layer including KMS and endpoint policy.

---

# Section F — Disaster Recovery, Migration, CI/CD, Cost and AI

<a id="q42"></a>
## Question 42: How would you design disaster recovery in AWS for very low RTO and RPO?

### 1. Concept

**RTO (Recovery Time Objective)** is the maximum acceptable time to restore service. **RPO (Recovery Point Objective)** is the maximum acceptable period of data loss. AWS strategies range from **backup/restore**, **pilot light**, **warm standby**, to **active-active across Regions**; lower RTO/RPO generally means higher cost and greater application/data complexity. Multi-AZ protects from a local availability-zone failure but does not equal a full multi-Region DR plan. **Asynchronous replication is not automatically zero-RPO**. The architecture must protect data consistency and have proven cutover procedures.

### 2. Implementation — Step by Step

1. Ask business owners for workload-specific RTO/RPO, transaction correctness requirements, legal residency and acceptable DR cost.
2. Map all dependencies: app compute, DNS, KMS/secrets, IAM, database, queues, storage, third-party APIs and monitoring.
3. Use Multi-AZ by default within a Region, then choose a second-Region pattern. Terraform/CloudFormation should reproduce networking, EKS/EC2/ECS and observability there.
4. Replicate data using an appropriate mechanism: Aurora Global Database, DynamoDB global tables, S3 cross-Region replication, AWS Backup cross-Region copies or application-specific replication.
5. Configure failover entry (Route 53 health check, Global Accelerator or another managed approach), secrets/key availability and traffic protection.
6. Define freeze, failover, verification and failback runbooks. Run drills measuring *actual* time to business transaction recovery and any data loss.

**Practical commands / query:**

```bash
aws rds describe-db-clusters --db-cluster-identifier <cluster-id>
aws backup list-backup-plans
aws route53 list-health-checks
```

### 3. Production Example

A transaction authorization API has a 15-minute RTO and near-zero data loss target. I would assess a warm secondary Region with a tested database replication design and clearly document that asynchronous replication may still lose recent writes. If true zero data loss is mandatory, I would discuss application-level synchronous/consensus tradeoffs and whether cross-Region latency makes the requirement feasible.

### 4. Troubleshooting

- App starts in DR but cannot decrypt data: KMS keys/policies and Secrets Manager replication may be incomplete.
- Traffic fails over but DB is read-only or stale: verify promotion process, write endpoint and replication lag.
- Queue/event duplication after failover: ensure message idempotency and reconciliation.
- Backups alone do not prove RTO: run timed restore tests and record results.

**Interview conclusion:**

> I select DR from explicit RTO/RPO targets, test real data cutover and treat replication consistency as a business requirement.

---

<a id="q43"></a>
## Question 43: How do AWS Backup, EBS/RDS snapshots, AWS Elastic Disaster Recovery, and cross-Region copies differ?

### 1. Concept

**AWS Backup** centrally defines backup plans and retention for supported resources, supporting features such as backup vault protection and cross-account/Region copies where supported. **EBS snapshots** protect block-level disk state, while **RDS/Aurora automated backups and snapshots** protect database data according to engine capabilities. **AWS Elastic Disaster Recovery (DRS)** replicates supported servers for faster server-level recovery and cutover. Backups are for recovery points; DRS is for workload failover. Neither automatically provides application consistency or a complete DR orchestration without testing.

### 2. Implementation — Step by Step

1. Classify workloads by criticality, acceptable backup age, retention policy, legal requirements and restore procedures.
2. Create AWS Backup plans selecting approved EC2/EBS, RDS and other supported resources using tags or resource assignments.
3. Set backup windows, lifecycle/retention, backup vault KMS controls, copies to a separate account/Region and Vault Lock where appropriate.
4. For supported server-based DR, configure AWS Elastic Disaster Recovery replication settings, staging area networking and recovery launch settings.
5. Run periodic restore tests into an isolated VPC; validate OS boot, database data, application secrets and transactional correctness.
6. Track backup success, age, replication lag, recovery testing and access to delete/alter recovery points.

**Practical commands / query:**

```bash
aws backup list-backup-jobs --by-state FAILED
aws backup list-recovery-points-by-backup-vault --backup-vault-name <vault>
aws drs describe-source-servers
```

### 3. Production Example

For a legacy reconciliation VM, I would evaluate DRS for failover plus AWS Backup for long-term recovery points and ransomware resilience. For RDS, I would use built-in automated backups/PITR and test restore of a representative database transaction before declaring recovery ready.

### 4. Troubleshooting

- Backup job failed: check role/resource access, KMS key policy, service quotas and vault permissions.
- Restore succeeds but app fails: network/security/DNS/Secrets Manager/IAM might be missing in DR.
- Cross-account restore fails: verify backup vault/resource sharing and destination KMS configuration.
- Replication delay may violate RPO even if the replication agent says connected; track measured lag.

**Interview conclusion:**

> Backup provides restore points; DRS provides replicated server recovery. Test both at application and transaction level.

---

<a id="q44"></a>
## Question 44: How would you migrate on-premises applications and databases to AWS with minimal downtime?

### 1. Concept

Migration patterns include **rehost (lift-and-shift)**, **replatform**, **refactor**, **repurchase**, **retain** and **retire**. The correct choice depends on dependencies, technical debt, business deadlines, latency and security. AWS Application Migration Service (MGN) supports many server migrations; **AWS DMS** can help move data/change streams for supported databases; AWS SCT or other conversion methods may be needed for heterogeneous schemas. A low-downtime cutover needs replication, validation, DNS/network plan and a **data-consistent rollback strategy**.

### 2. Implementation — Step by Step

1. Build an inventory and dependency map with application owners, data volumes, database engines, licensing, latency and RTO/RPO.
2. Create AWS landing zone: accounts, VPC/TGW/VPN or Direct Connect, IAM, KMS, Config/CloudTrail and monitoring.
3. Select migration wave and tool: MGN for suitable servers, DMS for supported data replication, or containerize/replatform as justified.
4. Test replication and target environment in staging, including DNS, authentication, certificates and downstream APIs.
5. Perform mock cutover, freeze or control writes as necessary, validate data consistency, then shift traffic in small steps.
6. Keep source systems available until operational acceptance and reconciliation are complete; document failback conditions and cost cleanup.

**Practical commands / query:**

```bash
aws dms describe-replication-tasks
aws ec2 describe-vpn-connections
```

### 3. Production Example

For an on-prem API and PostgreSQL database, I would provision AWS networking/RDS infrastructure with Terraform, replicate database changes with a validated CDC approach, deploy the API on EKS or ECS, perform shadow-read tests, then cut over DNS after a controlled final consistency check. If the target writes diverge, a DNS flip is not sufficient for rollback.

### 4. Troubleshooting

- Replication lag high: check source transaction rate, network bandwidth, DMS capacity and large transactions.
- App works but reports 403: IAM/resource policies, clock/time sync, and endpoint authentication.
- Hybrid connection unstable: monitor VPN/DX BGP, MTU, DNS and routing.
- Rollback after writes: determine reverse replication/reconciliation requirements first.

**Interview conclusion:**

> Migration is dependency and data engineering plus cutover testing—not just copying servers.

---

<a id="q45"></a>
## Question 45: A production deployment fails in AWS CodePipeline/CodeBuild/CodeDeploy. How do you investigate and recover?

### 1. Concept

AWS delivery workflows commonly combine **CodePipeline** orchestration, **CodeBuild** build/test, **CodeDeploy** application deployment, ECR artifact storage and CloudFormation/Terraform provisioning. A pipeline failure can be source checkout, build/test, permissions, KMS/S3 artifact access, infrastructure plan or application health. **Do not blindly rerun an infrastructure apply** before checking what successfully changed. For blue/green releases, health alarms and traffic shifting can trigger rollback when correctly configured.

### 2. Implementation — Step by Step

1. Identify the failing pipeline stage/action, commit/artifact version, error code and exact execution timestamp.
2. Inspect CodeBuild logs for dependency/test/registry failures; check pipeline execution history and CodeDeploy deployment events for health/timeouts.
3. Verify IAM service role, artifact-bucket policy, KMS permissions, deployment target roles and Region/account matches.
4. For ECS/EKS/EC2, check task/pod/instance health, ALB target health, readiness, network/security changes and application logs.
5. If user impact is high, stop traffic shifting and restore last healthy task definition/AMI/Helm release or use configured blue/green rollback.
6. If Terraform/CloudFormation partially updated infrastructure, inspect actual resources and state/stack events before safely retrying.

**Practical commands / query:**

```bash
aws codepipeline get-pipeline-state --name <pipeline>
aws codebuild batch-get-builds --ids <build-id>
aws deploy get-deployment --deployment-id <deployment-id>
```

### 3. Production Example

A new ECS task definition deploys but the ALB health check fails. I would inspect the failed deployment events and container logs, verify the app binds the expected port and path, and roll back traffic to the old task set. After adding a smoke-test gate in CodePipeline, I would retry through an approved change.

### 4. Troubleshooting

- `AccessDenied` in build: check service role, KMS decrypt and S3 artifact permissions.
- Image pull failure: ECR repository policy, digest/tag and task execution role.
- CodeDeploy timeout: look at ALB health, lifecycle hook duration and task startup.
- Infra partially created: reconcile plan/state before another apply rather than deleting all resources.

**Interview conclusion:**

> I triage the failed stage, protect customer traffic with rollback, and check permissions/artifacts/target health before redeploying.

---

<a id="q46"></a>
## Question 46: How would you architect and autoscale a highly available application with ALB, EC2 Auto Scaling, and Multi-AZ RDS?

### 1. Concept

High availability requires removing single points of failure across **request routing, compute, database and dependencies**. An EC2 Auto Scaling Group (ASG) spans multiple AZs and adjusts desired capacity; an ALB sends traffic to healthy targets. RDS Multi-AZ improves database availability but does not automatically provide unlimited read scale. Scaling should follow application load, connection limits and user-facing SLOs rather than only a basic CPU number.

### 2. Implementation — Step by Step

1. Build public ALB subnets and private application subnets in at least two AZs; choose a launch template with hardened AMI, user data and instance profile.
2. Create a target group and ALB HTTPS listener, attach WAF, configure application readiness path.
3. Create an ASG with minimum, desired and maximum capacity, balanced AZs, instance refresh and health check grace period.
4. Enable target-tracking/step scaling for appropriate metrics and load test scaling time and instance warmup.
5. Deploy Multi-AZ RDS with private access and backup; plan DB pool limits, RDS Proxy if suitable and failover DNS behavior.
6. Test AZ failure, unhealthy instance replacement, database failover and application retry behavior; set alarms and Terraform rollback plan.

**Practical commands / query:**

```bash
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names <asg>
aws elbv2 describe-target-health --target-group-arn <tg>
aws rds describe-db-instances --db-instance-identifier <id>
```

### 3. Production Example

For a transaction-search application, I would start with at least one healthy app instance per AZ, set ASG desired capacity above one, use ALB to drain unhealthy targets, and configure RDS Multi-AZ. Load tests would determine instance size and the maximum connection pool to protect the database when ASG scales out.

### 4. Troubleshooting

- ASG launches instances but ALB target stays unhealthy: inspect health path, SG, app startup and health grace period.
- Scale-out does not improve latency: database saturation or external dependency may be the bottleneck.
- Multi-AZ database failover causes brief errors: check connection re-establishment, DNS caching and retry policy.
- Capacity cannot launch: EC2 quotas, unavailable instance type or incorrect launch template.

**Interview conclusion:**

> Use multi-AZ ALB/ASG and database HA, then validate end-to-end recovery and application-level scaling limits.

---

<a id="q47"></a>
## Question 47: The AWS Console says EC2, EKS and RDS are healthy, but the customer application is down. How do you run a major incident?

### 1. Concept

A green infrastructure status means only that some resources are operational. A user transaction may fail due to TLS expiry, bad config, IAM denial, database lock, DNS, WAF block, routing or a downstream API. As an SRE, manage **incident severity, immediate mitigation, evidence capture, communication and root cause analysis** in parallel. Protecting customer transactions and avoiding duplicate financial operations matter more than identifying the root cause instantly.

### 2. Implementation — Step by Step

1. Confirm incident scope from external synthetic probes or actual application transactions, not only instance health. Declare severity and appoint incident commander/communications roles.
2. Inspect edge path (Route 53/CloudFront/WAF/ALB), target groups, API errors, request traces and key transaction metrics.
3. Compare incident start with deployments, Config history, CloudTrail changes, certificates, secrets and DNS changes.
4. Investigate downstream RDS/SQS/third-party APIs and application-level auth; inspect each hop for response latency/errors.
5. Mitigate using approved rollback, failover, degraded-mode operation, traffic shaping or disabling noncritical features.
6. Preserve timestamps/evidence, notify stakeholders and run a blameless RCA with permanent monitoring and test improvements.

**Practical commands / query:**

```bash
aws cloudtrail lookup-events --max-results 20
aws elbv2 describe-target-health --target-group-arn <tg>
aws cloudwatch describe-alarms --state-value ALARM
```

### 3. Production Example

During market opening, customers cannot see balances although EKS pods and RDS status are green. A distributed trace shows 30-second waits on a third-party account service. I would activate a cached-read graceful-degradation mode if compliant, alert stakeholders, and prevent uncontrolled retries from overwhelming the dependency.

### 4. Troubleshooting

- WAF rule update: check newly blocked requests and reversible rule version.
- Bad secret rotation: check authentication errors, Secret version and application cache refresh.
- DB query lock: analyze slow queries/waits and protect active business writes.
- Monitoring failure: fall back to synthetic probes and alternate telemetry, and include observability restoration in the incident.

**Interview conclusion:**

> I work from real customer symptoms, follow request traces, mitigate first, then RCA with coordinated evidence.

---

<a id="q48"></a>
## Question 48: How would you reduce AWS costs without compromising SRE reliability and security?

### 1. Concept

Cost optimization should measure **cost per useful transaction** while maintaining availability, security and recovery targets. AWS choices include Compute Savings Plans/Reserved Instances for baseline usage, Spot for interruptible tasks, ASG/EKS rightsizing, S3 lifecycle policies, RDS sizing, NAT/VPC endpoint design and log retention. Spot is not a substitute for reliable baseline capacity on critical services. Savings Plans and reservations are commitments, so forecast steady usage first.

### 2. Implementation — Step by Step

1. Tag resources by application, environment, owner and cost center; enable cost allocation tags, AWS Budgets and Cost Explorer reports.
2. Measure utilization, request cost, instance idle time, EKS requests/limits, ALB/CloudWatch/NAT data charges and storage growth.
3. Right-size EC2/RDS after load tests; use Graviton where supported, auto-scaling with safe minimums and Savings Plans for stable capacity.
4. Use Spot only for workloads with retry/checkpointing and sufficient fallback; test interruption behavior.
5. Optimize S3 lifecycle, storage class and log retention while respecting compliance and audit requirements.
6. Set budgets/anomaly alerts and verify savings do not worsen p95 latency, SLO burn, recovery time or security posture.

**Practical commands / query:**

```bash
aws ce get-cost-and-usage --time-period Start=<YYYY-MM-DD>,End=<YYYY-MM-DD> --granularity MONTHLY --metrics UnblendedCost
aws budgets describe-budgets --account-id <account-id>
```

### 3. Production Example

For an EKS environment with high off-hours spend, I would analyze node utilization and right-size requests, reduce nonproduction minimum nodes, add safe scheduling and appropriate scaling. I would leave production minimum replicas sufficient for peak-start response and multi-AZ survival.

### 4. Troubleshooting

- Cost rise from NAT: measure cross-AZ and S3/ECR traffic; VPC endpoint choices can help when justified.
- Savings commitment underused: reassess actual steady-state coverage, not just discount percentage.
- EKS savings cause latency: revert aggressive scale-down and preserve headroom.
- Log-cost spikes: reduce noisy logging and adjust retention without discarding required incident/audit evidence.

**Interview conclusion:**

> I optimize measured waste, not resilience: right-size, automate safely and monitor cost together with SLOs.

---

<a id="q49"></a>
## Question 49: How would you deploy a secure generative AI application using Amazon Bedrock and AWS private networking?

### 1. Concept

**Amazon Bedrock** offers managed access to supported foundation models and AI capabilities such as knowledge bases, guardrails and agent workflows. A secure enterprise integration needs **IAM authorization, Region/model access considerations, input/output data classification, encryption, network paths, rate/quotas, logging and human review** for sensitive actions. A private VPC-hosted app can use supported interface VPC endpoints for Bedrock APIs where available. Model access/availability and names vary by Region and time, so verify current AWS documentation during implementation.

### 2. Implementation — Step by Step

1. Identify an approved model/Region, data handling requirements, latency/cost budget and permission to process organizational data.
2. Create a narrow IAM role for the application permitting the needed Bedrock runtime actions and resources; do not store static AWS keys in code.
3. Run the caller in Lambda/ECS/EKS as appropriate and configure supported private Bedrock VPC endpoint(s), DNS and SGs if public egress is prohibited.
4. Apply Bedrock Guardrails or application validation appropriate to the use case; implement timeouts, retries, throttling controls and PII masking before logging.
5. Use CloudWatch metrics/logs and application-level token/use-case measurements; secure knowledge-base stores and retrieval access if using RAG.
6. Test prompt injection against tool-calling, verify that model suggestions cannot automatically deploy/delete AWS infrastructure, and require an authorized human approval step.

**Practical commands / query:**

```bash
aws bedrock list-foundation-models --region <region>
aws sts get-caller-identity
```

### 3. Production Example

I could build a read-only SRE incident assistant: it retrieves CloudWatch logs and runbooks for a production service, asks Bedrock to summarize likely causes, and proposes commands. The tool role would have read-only permissions by default; any restart or scaling change would require the on-call engineer's explicit approval.

### 4. Troubleshooting

- Model invocation AccessDenied: check role actions, Region/model access and policy conditions.
- Private request timeout: check VPC endpoint service name, subnet, SG/DNS and Region support.
- Throttling: implement bounded retry with jitter and manage concurrency/quotas.
- Risky answers: treat model output as untrusted suggestions, redact secrets and never grant autonomous broad IAM write access.

**Interview conclusion:**

> Bedrock setup is not just selecting a model; secure identity, networking, data boundaries, cost and human-controlled actions are essential.

---

<a id="q50"></a>
## Question 50: How would you design an AWS MLOps/agentic AI workflow with SageMaker, model registry, endpoints, and SRE safeguards?

### 1. Concept

**Amazon SageMaker AI** provides capabilities for building/training/registering and serving ML models, while Bedrock targets foundation-model application use cases. **MLOps** controls training-data/model versions, testing, approvals, deployment and performance drift. **LLMOps/agentic AI** adds retrieval quality, prompt/tool behavior, safety and cost monitoring. Agents that use tools (for example, an SRE bot invoking AWS APIs) should have explicit least-privilege permissions, allowlisted actions and a human approval boundary before any disruptive change.

### 2. Implementation — Step by Step

1. Define whether the problem needs custom ML training (SageMaker) or a foundation-model application (Bedrock). Create separate dev/stage/prod accounts or environments.
2. For SageMaker, configure project/workspace components, approved S3 datasets, roles, encryption, training pipelines and model registry/model packages where applicable.
3. Build CI/CD gates for unit tests, data validation, model evaluation and manual approvals before deploying a managed inference endpoint or other supported serving target.
4. For LLM/RAG, version prompts, retrieval indexes and model settings; evaluate hallucination, groundedness, latency, data leakage and cost per response.
5. Implement application and model monitoring, alarms, rollback versioning, endpoint canaries and dataset/model access auditing.
6. For agent tool calling, use a read-only default role, scoped tools, approval for writes, dry-run/plan previews and full audit trails.

**Practical commands / query:**

```bash
aws sagemaker list-model-packages --model-package-group-name <group>
aws sagemaker list-endpoints
aws cloudwatch describe-alarms --state-value ALARM
```

### 3. Production Example

An internal operations assistant may explain why EKS pods are CrashLoopBackOff by reading CloudWatch logs and deployment history. I would allow it to query metadata and suggest a rollback, but not perform a production `kubectl delete` or Terraform apply autonomously. Operations would require an authenticated change workflow.

### 4. Troubleshooting

- Model endpoint 5xx/timeout: review invocation logs, autoscaling, container startup, model memory and concurrency.
- Unexpected inference cost: inspect request volume, output length, provisioned capacity and retries.
- Degraded answer quality: compare model/prompt/retrieval revisions with evaluation dataset and rollback bad changes.
- Security violation: inspect tool calls, IAM roles, secret redaction and the human approval boundary.

**Interview conclusion:**

> MLOps manages versions and deployment safety; LLMOps also measures prompts/retrieval and safeguards agent actions.

---

# Final Revision — AWS SRE Interview

| Priority | Questions | Main focus |
|---|---|---|
| **First** | 1–10 | Cross-account networking, private connectivity, SG/IAM, EC2, RDS |
| **Second** | 17–23 | EKS cluster, CrashLoopBackOff, upgrades, OOM, autoscaling and ECR |
| **Third** | 25–35 | CloudWatch centralized logging, 5xx, SLO, S3 and messaging |
| **Fourth** | 42–47 | DR, backups, migration, deployment failure and major incident |
| **Finally** | 48–50 | Cost, Bedrock and MLOps/agentic AI awareness |

## Reference Documentation

- [Amazon VPC peering limitations](https://docs.aws.amazon.com/vpc/latest/peering/vpc-peering-basics.html)
- [Cross-account VPC peering setup](https://docs.aws.amazon.com/vpc/latest/peering/create-vpc-peering-connection.html)
- [AWS PrivateLink endpoint services](https://docs.aws.amazon.com/vpc/latest/privatelink/create-endpoint-service.html)
- [IAM policy evaluation logic](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html)
- [EKS Kubernetes upgrade procedure](https://docs.aws.amazon.com/eks/latest/userguide/update-cluster.html)
- [CloudWatch cross-account and cross-Region Logs centralization](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs_Centralization.html)
- [CloudWatch cross-account observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Cross-Account-Methods.html)
- [Amazon Aurora Global Database DR](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-global-database-disaster-recovery.html)
- [AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/framework/welcome.html)
- [Amazon Bedrock documentation](https://docs.aws.amazon.com/bedrock/)
- [Amazon SageMaker AI documentation](https://docs.aws.amazon.com/sagemaker/)
