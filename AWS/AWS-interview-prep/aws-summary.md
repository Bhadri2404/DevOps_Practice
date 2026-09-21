# ⚡ AWS Interview Summary — DevOps Engineer — Quick Revision

> **Companion to the full AWS notes.** Feature-complete but condensed — scanning this should trigger the full memory.
> **Each topic:** What → flow diagram → key features → UI path → rapid Q&A → 💡 Azure anchor.
> **Tiers:** 🔴 Full · 🟠 Medium · 🟡 Know-this-much

---

# 📋 TABLE OF CONTENTS

### 🌱 Foundations
1. [Global Infrastructure & Accounts](#1--global-infrastructure--accounts-)
2. [Organizations, OUs & Control Tower](#2--organizations-ous--control-tower-)

### 🔐 Identity & Access
3. [IAM — Users, Groups, Roles, Policies](#3--iam--users-groups-roles-policies-)
4. [IAM Policy Evaluation Logic](#4--iam-policy-evaluation-logic-)
5. [IAM Roles for Services & Instance Profiles](#5--iam-roles-for-services--instance-profiles-)
6. [STS, AssumeRole & Cross-Account](#6--sts-assumerole--cross-account-)
7. [IAM Identity Center (SSO)](#7--iam-identity-center-sso-)
8. [OIDC Federation](#8--oidc-federation-)

### 🌐 Networking
9. [Networking Fundamentals](#9--networking-fundamentals-)
10. [VPC](#10--vpc-)
11. [Subnets (Public/Private)](#11--subnets-publicprivate-)
12. [Security Groups](#12--security-groups-)
13. [Network ACLs (NACLs)](#13--network-acls-nacls-)
14. [Route Tables & Internet Gateway](#14--route-tables--internet-gateway-)
15. [NAT Gateway](#15--nat-gateway-)
16. [VPC Endpoints (Gateway & PrivateLink)](#16--vpc-endpoints-gateway--privatelink-)
17. [VPC Peering](#17--vpc-peering-)
18. [Transit Gateway](#18--transit-gateway-)
19. [Route 53](#19--route-53-)
20. [Elastic Load Balancing (ALB/NLB/GWLB)](#20--elastic-load-balancing-albnlbgwlb-)
21. [WAF & Shield](#21--waf--shield-)
22. [Network Firewall](#22--network-firewall-)
23. [Flow Logs & Reachability Analyzer](#23--flow-logs--reachability-analyzer-)
24. [Site-to-Site VPN & Direct Connect](#24--site-to-site-vpn--direct-connect-)

### 🔑 Secrets & Config
25. [KMS](#25--kms-)
26. [Secrets Manager vs Parameter Store](#26--secrets-manager-vs-parameter-store-)
27. [Secrets Integration (Services)](#27--secrets-integration-services-)

### 🛠️ CI/CD — Tools, Integrations & Secrets
28. [AWS-Native CI/CD](#28--aws-native-cicd-)
29. [CI/CD Tool → AWS Authentication](#29--cicd-tool--aws-authentication-)
30. [CI/CD Secrets & Security Integration](#30--cicd-secrets--security-integration-)
31. [CodeArtifact & ECR](#31--codeartifact--ecr-)
32. [Git Branching Strategies](#32--git-branching-strategies-)
33. [Multi-Account CI/CD](#33--multi-account-cicd-)

### 🏗️ Infrastructure as Code
34. [CloudFormation](#34--cloudformation-)
35. [AWS CDK](#35--aws-cdk-)
36. [Terraform + AWS](#36--terraform--aws-)
37. [Terraform State (S3 + DynamoDB)](#37--terraform-state-s3--dynamodb-)
38. [IaC in CI/CD with Plan Gates](#38--iac-in-cicd-with-plan-gates-)

### 🖥️ Compute
39. [EC2](#39--ec2-)
40. [Auto Scaling Groups & Launch Templates](#40--auto-scaling-groups--launch-templates-)
41. [Elastic Beanstalk](#41--elastic-beanstalk-)
42. [AWS Batch](#42--aws-batch-)

### 📦 Containers
43. [Dockerfile Best Practices](#43--dockerfile-best-practices-)
44. [Amazon ECR](#44--amazon-ecr-)
45. [Amazon ECS (Fargate vs EC2)](#45--amazon-ecs-fargate-vs-ec2-)
46. [Amazon EKS](#46--amazon-eks-)
47. [ECS/EKS Ingress & Service Discovery](#47--ecseks-ingress--service-discovery-)
48. [Helm & GitOps (Argo/Flux)](#48--helm--gitops-argoflux-)
49. [Container Autoscaling (HPA/CA/Karpenter)](#49--container-autoscaling-hpacakarpenter-)

### ⚡ Serverless
50. [AWS Lambda](#50--aws-lambda-)
51. [API Gateway](#51--api-gateway-)
52. [Amazon S3](#52--amazon-s3-)
53. [Amazon SQS](#53--amazon-sqs-)
54. [Amazon SNS](#54--amazon-sns-)
55. [Amazon EventBridge](#55--amazon-eventbridge-)
56. [AWS Step Functions](#56--aws-step-functions-)
57. [Amazon Kinesis](#57--amazon-kinesis-)
58. [Amazon DynamoDB](#58--amazon-dynamodb-)
59. [SAM & Serverless Framework](#59--sam--serverless-framework-)

### 💾 Storage & Databases
60. [EBS & EFS](#60--ebs--efs-)
61. [RDS & Aurora](#61--rds--aurora-)
62. [ElastiCache](#62--elasticache-)

### 🚀 Deployment & Observability
63. [Blue/Green (CodeDeploy)](#63--bluegreen-codedeploy-)
64. [Canary, Rolling & Rollback](#64--canary-rolling--rollback-)
65. [Feature Flags (AppConfig)](#65--feature-flags-appconfig-)
66. [CloudWatch](#66--cloudwatch-)
67. [CloudWatch Logs Insights](#67--cloudwatch-logs-insights-)
68. [X-Ray (Distributed Tracing)](#68--x-ray-distributed-tracing-)
69. [Alerting & Incident Response](#69--alerting--incident-response-)
70. [SLI / SLO / SLA & Error Budgets](#70--sli--slo--sla--error-budgets-)
71. [DevSecOps on AWS](#71--devsecops-on-aws-)
72. [AI-Assisted DevOps (Amazon Q/Bedrock)](#72--ai-assisted-devops-amazon-qbedrock-)

### 🔥 Governance & Cross-Cutting
73. [Config & SCPs](#73--config--scps-)
74. [CloudTrail](#74--cloudtrail-)
75. [Tagging & Naming](#75--tagging--naming-)
76. [Landing Zone / Control Tower](#76--landing-zone--control-tower-)
77. [Cost Management & FinOps](#77--cost-management--finops-)
78. [Backup & DR (RTO/RPO)](#78--backup--dr-rtorpo-)

### 🎓 Interview Prep
79. [All Integration Flows](#79--all-integration-flows-)
80. [Rapid-Fire Q&A](#80--rapid-fire-qa-)
81. [Final Quick Reference](#81--final-quick-reference-)

---

# 1. 🌍 Global Infrastructure & Accounts `🟠`

**What:** Where AWS resources live geographically.
```
Region (geographic area, e.g. ap-south-1) → Availability Zone (isolated
data centers; 3+ per region) → Edge Locations (CDN/DNS worldwide)
Deploy across AZs = HA · across Regions = DR + global low latency
```
**Key facts:** most services regional (EC2/VPC/S3); some global (IAM/Route 53/CloudFront); some ops pinned to us-east-1 (ACM for CloudFront). Deploy across 2-3 AZs for HA.
**🎯 Q&A:** *Region vs AZ?* → geographic area vs isolated data centers within it; multi-AZ = HA, multi-region = DR. *All services regional?* → no, IAM/Route 53/CloudFront are global.
**💡 Azure:** Region≈Region · AZ≈Availability Zone · Edge≈Edge/PoP.

---

# 2. 🏢 Organizations, OUs & Control Tower `🟠`

**What:** How AWS organizes many accounts centrally.
```
Organization (payer acct) → OU (groups accounts) → Account (isolation +
billing boundary) → resources (tags, no strong RG equivalent)
SCPs at OU level = org-wide guardrails cascading down
```
**Key facts:** **Account = primary isolation/blast-radius boundary** (harder than Azure subscriptions); multi-account best practice (prod/dev/staging + security/log-archive/audit accounts); SCPs = preventive guardrails; consolidated billing; Control Tower automates a governed Landing Zone.
**🎯 Q&A:** *Multi-account structure & why?* → Organizations + OUs + per-env accounts; accounts are hard isolation boundaries (a dev mistake can't touch prod). *SCPs?* → org-level max-permission guardrails, unoverridable. *Account model vs Azure?* → Account≈Subscription (but stronger), OU≈Management Group, no real RG equivalent.
**💡 Azure:** Account≈Subscription · OU≈Management Group · Organization≈Tenant · SCPs+Config≈Azure Policy.

---

# 3. 🔐 IAM — Users, Groups, Roles, Policies `🔴`

**What:** Controls ALL AWS auth + authz (the #1 interview topic).
```
Users (people, long-term creds) · Groups (assign perms at scale) ·
Roles (assumed temporarily → short-lived creds; PREFERRED for automation) ·
Policies (JSON Allow/Deny on Actions/Resources; identity- or resource-based)
```
**Key facts:** **use Roles not long-lived keys** for anything programmatic (short-lived, nothing stored); Groups for people; MFA everywhere; never use root for daily work; least privilege. Policy = JSON (Effect/Action/Resource/Condition).
**UI:** `IAM → Roles → Create role → trusted entity (service/account/web identity) → attach policies`.
**🎯 Q&A:** *4 entities?* → Users, Groups, Roles, Policies. *Role vs User?* → Role = short-lived creds, no stored keys (use for all automation); User = long-term keys (leak/rotate risk). *Identity vs resource-based policy?* → attached to an identity (what it can do) vs to a resource (who can access it).
**💡 Azure:** IAM = Entra ID + RBAC combined (JSON policies vs scoped roles); IAM Role ≈ Managed Identity/Service Principal.

---

# 4. ⚖️ IAM Policy Evaluation Logic `🔴`

**What:** How AWS decides allow/deny across multiple policies (heavily tested; no real Azure equivalent).
```
GOLDEN RULES: default DENY → explicit ALLOW grants → explicit DENY always wins
All policy types evaluated together: identity + resource + permission
boundary + SCP + session. Effective perms = INTERSECTION of allows +
ceilings, minus any explicit deny.
```
**Key facts:** **Permission Boundary** (per-identity ceiling) vs **SCP** (per-account/org ceiling) — both LIMIT, neither GRANTS; you still need an identity policy to allow. Test with the IAM Policy Simulator.
**🎯 Q&A:** *Eval logic?* → default deny; explicit allow grants; explicit deny always overrides; effective = intersection of allows + boundaries + SCPs minus denies. *Boundary vs SCP?* → per-identity ceiling vs per-account/org ceiling; both cap, neither grants. *Allow + SCP deny?* → denied (deny wins; also outside the ceiling).
**💡 Azure:** Azure RBAC is allow-only (deny assignments rare); AWS's multi-policy deny-wins logic has no direct Azure parallel.

---

# 5. 🖥️ IAM Roles for Services & Instance Profiles `🔴`

**What:** Compute (EC2/Lambda/ECS/EKS) accesses AWS with short-lived creds, no stored keys.
```
EC2 (role via INSTANCE PROFILE) → gets short-lived creds from IMDS
(169.254.169.254) → accesses S3/DynamoDB (SDK auto-uses them). Auto-rotate.
Lambda = execution role · ECS = task role · EKS = IRSA/Pod Identity
```
**Key facts:** two parts = **trust policy** (who can assume it, e.g. the EC2/Lambda service) + **permission policy** (what it can do); the direct AWS equivalent of an Azure Managed Identity.
**UI:** `IAM → Roles → Create (AWS service: EC2) → attach policies` → EC2 → `Actions → Security → Modify IAM role`.
**🎯 Q&A:** *EC2 access S3 without keys?* → attach an IAM role via instance profile; short-lived creds from IMDS, SDK auto-uses. = Azure Managed Identity. *Instance profile?* → container attaching a role to EC2 (Lambda/ECS assign directly). *EKS pods?* → IRSA / Pod Identity (≈ AKS Workload Identity).
**💡 Azure:** = Managed Identity (system-assigned on a VM); IRSA ≈ AKS Workload Identity.

---

# 6. 🔄 STS, AssumeRole & Cross-Account `🔴`

**What:** How roles get temp creds + how one account accesses another (heavily tested).
```
STS issues SHORT-LIVED creds via: AssumeRole · AssumeRoleWithWebIdentity
(OIDC) · GetSessionToken
Cross-account: source assumes a role in the target account — needs
TWO-SIDED TRUST (target's trust policy allows source + source permitted
to AssumeRole)
```
**Key facts:** temp creds (key+secret+session token), 15min-12hr; almost all secure AWS access = AssumeRole under the hood; the two-sided trust is the #1 cross-account interview point.
**CLI:** `aws sts assume-role --role-arn ... --role-session-name ...` · `aws sts get-caller-identity`.
**🎯 Q&A:** *STS/AssumeRole?* → STS issues temp short-lived creds; AssumeRole is how an identity assumes a role to get them. *Cross-account?* → two-sided trust: target role trusts source + source permitted to assume; source gets temp creds scoped to the target role. *AssumeRole vs WithWebIdentity?* → base identity vs OIDC federated (CI/CD) path.
**💡 Azure:** No clean equivalent (Azure cross-sub = RBAC, same tenant); AssumeRoleWithWebIdentity ≈ Workload Identity Federation.

---

# 7. 🔑 IAM Identity Center (SSO) `🟠`

**What:** SSO across all AWS accounts using a central/federated corporate identity.
```
Identity source (built-in or federated IdP: Entra ID/Okta) → IAM Identity
Center → Permission Sets assigned to users/groups per account → user logs
in once → short-lived creds per account/role
```
**Key facts:** eliminates per-account IAM users + long-lived keys; **Permission Set** = reusable role template per account; federation via SAML; easy onboarding/offboarding via the IdP.
**UI:** `IAM Identity Center → enable → identity source → Permission sets → assign group+set to accounts`.
**🎯 Q&A:** *What & why over IAM users?* → SSO across accounts with short-lived creds via permission sets; eliminates long-lived credential sprawl, centralizes access, ties to corporate identity. *Permission Set?* → reusable permission template assigned per account.
**💡 Azure:** ≈ using Entra ID for SSO across subscriptions.

---

# 8. 🔗 OIDC Federation `🔴`

**What:** External CI/CD (GitHub/Bitbucket/etc.) auth to AWS with NO stored keys (gold standard).
```
Setup: IAM OIDC provider trusting the tool's issuer + IAM role trust-scoped
to repo/branch. Run: tool's OIDC token → sts:AssumeRoleWithWebIdentity →
short-lived creds → deploy. Nothing stored.
```
**Key facts:** trust scoped via a condition (e.g. `repo:org/repo:ref:refs/heads/main`) so only that repo/branch can assume; short-lived tokens; modern best practice.
**UI:** `IAM → Identity providers → Add (OIDC) → create role (Web identity) scoped to repo/branch → attach least-priv policies`.
**🎯 Q&A:** *What & why?* → external workload auth via short-lived OIDC tokens + AssumeRoleWithWebIdentity; no stored keys to leak/rotate. *How scoped?* → trust policy condition matches the token subject (repo/branch). *Which STS call?* → AssumeRoleWithWebIdentity.
**💡 Azure:** = Workload Identity Federation (identical pattern).

---

# 9. 🌐 Networking Fundamentals `🟠`

**What:** IP, CIDR, ports — the building blocks.
```
Public vs private IP · CIDR: smaller /number = bigger range (/24=256, /16=65,536)
· AWS reserves 5 IPs/subnet (/24 = 251 usable) · ports: 22 SSH/80 HTTP/443
HTTPS/3389 RDP/3306 MySQL/5432 Postgres/1433 SQL
```
**🎯 Q&A:** */24 vs /16?* → 256 vs 65,536; smaller slash = bigger; AWS reserves 5/subnet. *Public vs private IP?* → internet-reachable vs internal-only.
**💡 Azure:** identical to VNet CIDR/ports.

---

# 10. 🔷 VPC `🔴`

**What:** Your private isolated network in AWS.
```
VPC (10.0.0.0/16) → subnets PER AZ → resources talk privately by default
Internet needs: Internet Gateway attached + route + public IP (all 3!)
```
**Key facts:** ⚠️ AWS **requires an Internet Gateway** (Azure doesn't); subnets **AZ-scoped** (one per AZ for HA); CIDRs must not overlap for peering; default VPC pre-created per region.
**UI:** `VPC → Create VPC ("VPC and more" wizard) → CIDR + AZs + subnets + IGW + NAT`.
**🎯 Q&A:** *VPC?* → private isolated network (≈ VNet). *Need an IGW?* → yes (unlike Azure — top gotcha): IGW + route + public IP all required. *Subnets AZ-tied?* → yes (unlike Azure) → one per AZ.
**💡 Azure:** ≈ VNet (but needs IGW; subnets AZ-scoped).

---

# 11. 🧩 Subnets (Public/Private) `🔴`

**What:** VPC segments; public vs private defined by ROUTING (not a flag).
```
PUBLIC subnet  = route table has 0.0.0.0/0 → Internet Gateway (holds ALB/NAT/bastion)
PRIVATE subnet = no IGW route; internet outbound only via a NAT Gateway (holds app/db)
```
**Key facts:** AZ-scoped (one per AZ per tier); 5 IPs reserved (/24=251 usable); isolate tiers = defense in depth.
**UI:** `VPC → Subnets → Create` → make public by attaching a route to the IGW + auto-assign public IP.
**🎯 Q&A:** *Public vs private?* → route table: public routes 0.0.0.0/0 to IGW, private doesn't (NAT for outbound). No flag — it's routing. *Usable IPs in /24?* → 251.
**💡 Azure:** ≈ subnets, but AZ-scoped + public/private defined by routing.

---

# 12. 🛡️ Security Groups `🔴`

**What:** Instance-level, stateful, ALLOW-ONLY firewall.
```
Attached to instance/ENI · allow rules only (no deny) · STATEFUL (return
traffic auto-allowed) · source can be a CIDR or ANOTHER SG (autoscale-safe)
```
**Key facts:** no deny (use NACLs); reference another SG as source = the AWS equivalent of Azure ASGs (rules survive autoscaling); multiple SGs = cumulative allows; never 22/3389 from 0.0.0.0/0.
**UI:** `EC2 → Security Groups → Create → inbound rules → attach to instance`.
**🎯 Q&A:** *SG vs NACL?* → SG = instance, stateful, allow-only; NACL = subnet, stateless, allow+deny. *Stateful?* → return traffic auto-allowed. *Autoscale-safe rule?* → reference another SG as source (≈ Azure ASG).
**💡 Azure:** ≈ half of an NSG (allow-only, instance-level, stateful); SG-as-source ≈ ASG.

---

# 13. 🚧 Network ACLs (NACLs) `🟠`

**What:** Subnet-level, stateless firewall with allow AND deny.
```
Subnet-level · allow+deny · STATELESS (must allow return traffic explicitly,
incl. ephemeral ports 1024-65535) · numbered rules, first match wins
```
**Key facts:** the complement to SGs — use for explicit DENY (e.g. block a bad IP range) as a coarse subnet layer; traffic passes NACL (subnet) then SG (instance).
**UI:** `VPC → Network ACLs → Create → numbered rules → associate with subnet`.
**🎯 Q&A:** *SG vs NACL?* → instance/stateful/allow-only vs subnet/stateless/allow+deny. *Stateless meaning?* → must allow return traffic explicitly (ephemeral ports) — classic bug. *When NACL?* → explicit deny (block bad IPs) / coarse subnet rule.
**💡 Azure:** ≈ the other half of an NSG (subnet-level + deny).

---

# 14. 🧭 Route Tables & Internet Gateway `🔴`

**What:** Where subnet traffic goes; IGW enables internet (AWS requires it explicitly).
```
Public RT:  10.0.0.0/16 local · 0.0.0.0/0 → IGW
Private RT: 10.0.0.0/16 local · 0.0.0.0/0 → NAT Gateway
Internet needs ALL 3: IGW attached + route to it + public IP (top Azure gotcha)
```
**Key facts:** most specific route wins; a subnet is public *because* it routes 0.0.0.0/0 to the IGW; other targets = NAT/peering/TGW/endpoints.
**UI:** `VPC → Internet Gateways → Create + Attach` → `Route Tables → add 0.0.0.0/0 → IGW` → enable subnet auto-public-IP.
**🎯 Q&A:** *Internet access in AWS?* → IGW attached + 0.0.0.0/0 route to it + public IP (all 3; differs from Azure). *Public vs private subnet?* → route table has an IGW route or not.
**💡 Azure:** Route Tables ≈ UDRs; IGW has no Azure equivalent (public IP alone works there).

---

# 15. 🚪 NAT Gateway `🟠`

**What:** Outbound-only internet for private subnets.
```
Private VMs → 0.0.0.0/0 route → NAT Gateway (in a PUBLIC subnet, has an
Elastic IP) → internet. Inbound blocked. One NAT per AZ for HA.
```
**Key facts:** outbound only; static Elastic IP (good for allow-listing); lives in a public subnet, private subnets route to it (Azure attaches directly, no route); hourly + data cost (optimization target).
**UI:** `VPC → NAT Gateways → Create (public subnet + Elastic IP)` → private RT: 0.0.0.0/0 → NAT.
**🎯 Q&A:** *NAT Gateway use?* → outbound-only internet for private resources + static IP for allow-listing. *vs Azure?* → route private subnets to it (Azure associates directly).
**💡 Azure:** ≈ NAT Gateway (but routed via route table).

---

# 16. 🔒 VPC Endpoints (Gateway & PrivateLink) `🔴`

**What:** Private access to AWS services without internet.
```
GATEWAY ENDPOINT (S3 & DynamoDB only, FREE): route-table entry, traffic
stays on AWS network, service keeps public IP ≈ Azure Service Endpoint
INTERFACE ENDPOINT (PrivateLink, most services): private IP/ENI in your
subnet, fully private ≈ Azure Private Endpoint
```
**Key facts:** Gateway = free + saves NAT data cost (S3/DynamoDB); Interface = private IP, works from on-prem, can expose your own services; Interface has hourly cost.
**UI:** `VPC → Endpoints → Create → Gateway (S3) or Interface (e.g. secretsmanager) → enable Private DNS`.
**🎯 Q&A:** *Two types?* → Gateway (S3/DynamoDB, free, route-based, public IP) vs Interface/PrivateLink (private IP in subnet). Gateway≈Service Endpoint, Interface≈Private Endpoint. *Why Gateway for S3?* → private + free + avoids NAT data charges.
**💡 Azure:** Gateway≈Service Endpoint · Interface/PrivateLink≈Private Endpoint.

---

# 17. 🔗 VPC Peering `🟠`

**What:** Connect two VPCs privately over the AWS backbone.
```
VPC-A ↔ VPC-B (private IPs). ⚠️ NOT transitive (A↔B+B↔C ≠ A→C). CIDRs must
not overlap. Must add ROUTES on both sides. Cross-region/account OK.
```
**Key facts:** non-transitive (like Azure); many VPCs = mesh nightmare → use Transit Gateway.
**UI:** `VPC → Peering connections → Create → accept → add routes both sides`.
**🎯 Q&A:** *What?* → private VPC-to-VPC over the backbone. *Transitive?* → no (need direct peering or TGW). *Requirement?* → non-overlapping CIDRs + routes both sides.
**💡 Azure:** = VNet Peering (same non-transitive limit).

---

# 18. 🎯 Transit Gateway `🔴`

**What:** Central hub connecting many VPCs/on-prem — AWS hub-and-spoke at scale.
```
TGW (hub) ← attach VPC-A, VPC-B, VPC-C, VPN/Direct Connect
TRANSITIVE (spokes reach each other via hub, unlike peering) · scales to
1000s of VPCs · TGW route tables segment traffic (isolate prod/dev)
```
**Key facts:** replaces the N² peering mesh; centralizes on-prem connectivity (one VPN/DX serves all VPCs); cross-region (TGW peering) + cross-account (RAM).
**UI:** `VPC → Transit Gateways → Create → attach VPCs/VPN → TGW route tables → update VPC routes`.
**🎯 Q&A:** *TGW vs peering?* → hub-and-spoke + transitive + scales to 1000s vs point-to-point non-transitive mesh. Use TGW for many VPCs / central on-prem. *Isolate prod/dev on one TGW?* → TGW route tables segment which attachments reach which.
**💡 Azure:** ≈ Hub-and-Spoke + Virtual WAN combined (and transitive).

---

# 19. 🌍 Route 53 `🟠`

**What:** AWS DNS + intelligent routing (+ can register domains).
```
Hosts records + 7 ROUTING POLICIES: Simple · Weighted (%, A/B/rollout) ·
Latency (fastest region) · Failover (active-passive + health checks) ·
Geolocation · Geoproximity · Multivalue
```
**Key facts:** registers domains (Azure DNS can't); Public/Private hosted zones; Alias records for AWS resources at the apex; Failover + health checks = auto DNS DR.
**UI:** `Route 53 → Hosted zones → Create record → routing policy → Alias/A`.
**🎯 Q&A:** *Route 53 vs Azure?* → combines Azure DNS (hosting) + Traffic Manager (routing) + can register domains. *Key policies?* → Weighted, Latency, Failover, Geolocation, Multivalue. *Alias vs CNAME?* → Alias for AWS resources at the apex.
**💡 Azure:** ≈ Azure DNS + Traffic Manager (+ domain registration).

---

# 20. ⚖️ Elastic Load Balancing (ALB/NLB/GWLB) `🟠`

**What:** Distribute traffic across healthy targets.
```
ALB (L7, HTTP/S) → path/host routing, SSL termination, WAF ≈ App Gateway
NLB (L4, TCP/UDP) → ultra-perf, static IP, preserves source IP ≈ Azure LB
GWLB (L3) → for 3rd-party network appliances
```
**Key facts:** target groups (EC2/ECS/Lambda/IP) + health checks (remove unhealthy); listeners; auto-registers with Auto Scaling/ECS; internet-facing vs internal.
**UI:** `EC2 → Load Balancers → Create → listener + target group + health check + (ALB) path rules`.
**🎯 Q&A:** *ELB types?* → ALB (L7, routing/SSL/WAF), NLB (L4, perf/static IP), GWLB (appliances). ALB≈App Gateway, NLB≈Azure LB. *Target group?* → pool of targets with health checks (unhealthy removed). *SSL termination?* → ALB decrypts, offloads backends.
**💡 Azure:** ALB≈Application Gateway · NLB≈Azure Load Balancer.

---

# 21. 🛡️ WAF & Shield `🟡`

**What:** WAF blocks web attacks; Shield mitigates DDoS.
```
WAF → inspects HTTP vs managed rules (SQLi/XSS/bots) + custom (rate-limit);
      on CloudFront/ALB/API Gateway
Shield → DDoS: Standard (free/auto) · Advanced (paid, enhanced + cost protection)
```
**🎯 Q&A:** *WAF vs Shield?* → WAF blocks web attacks (SQLi/XSS/bots, managed+custom rules) on CloudFront/ALB/API GW; Shield mitigates DDoS (Standard free, Advanced paid + cost protection). *Rate-limit bots?* → WAF rate-based rule. ≈ Azure WAF + DDoS Protection.
**💡 Azure:** WAF≈Azure WAF · Shield≈Azure DDoS Protection.

---

# 22. 🔥 Network Firewall `🟡`

**What:** Managed, central, stateful VPC firewall (beyond SG/NACL).
```
Deployed in a firewall subnet; route tables steer traffic through it →
domain (FQDN) filtering + intrusion prevention (Suricata rules) + central
egress inspection (often in an inspection VPC + TGW)
```
**🎯 Q&A:** *When over SG/NACL?* → centralized stateful filtering with FQDN filtering, IPS, and central egress inspection across VPCs. ≈ Azure Firewall.
**💡 Azure:** ≈ Azure Firewall.

---

# 23. 🔍 Flow Logs & Reachability Analyzer `🟡`

**What:** Network troubleshooting + traffic recording.
```
VPC Flow Logs → record accepted/rejected traffic (to CloudWatch/S3) — analysis/audit
Reachability Analyzer → "can X reach Y on port Z?" → analyzes SG/NACL/routes
                        → REACHABLE/NOT + which component blocks it (instant root cause)
```
**🎯 Q&A:** *"App can't reach DB" — how?* → Reachability Analyzer (source/dest/port → tells you allowed/blocked + which SG/NACL/route). Flow Logs record traffic for patterns/audit. ≈ Azure Network Watcher + NSG Flow Logs.
**💡 Azure:** Reachability Analyzer≈Network Watcher (IP Flow Verify) · Flow Logs≈NSG Flow Logs.

---

# 24. 🔐 Site-to-Site VPN & Direct Connect `🟡`

**What:** Connect on-prem to AWS.
```
VPN → encrypted tunnel over PUBLIC INTERNET (cheap/quick, variable) — often a backup
Direct Connect → dedicated PRIVATE fiber (consistent low latency, high BW,
                 compliance) — pricier, via a partner
Both can terminate at a Transit Gateway to serve many VPCs.
```
**🎯 Q&A:** *VPN vs Direct Connect?* → encrypted-over-internet (cheap, variable) vs dedicated private (consistent, compliance, pricier); use DX for high-perf/regulated, VPN as backup. ≈ Azure VPN Gateway vs ExpressRoute.
**💡 Azure:** VPN≈VPN Gateway · Direct Connect≈ExpressRoute.

---

# 25. 🔐 KMS `🔴`

**What:** Managed encryption keys for data-at-rest across AWS.
```
KMS keys (never leave KMS) encrypt S3/EBS/RDS/DynamoDB/Secrets Manager/etc.
Access = key policy + IAM · every use logged in CloudTrail · envelope
encryption (KMS encrypts a data key that encrypts your data)
```
**Key facts:** AWS-managed vs customer-managed keys (custom policy, annual rotation, cross-account); the "keys" part of Azure Key Vault (secrets/certs are separate: Secrets Manager/ACM).
**UI:** `KMS → Create key → key admins/users → enable rotation` → select it when enabling encryption on services.
**🎯 Q&A:** *KMS?* → managed encryption keys for data-at-rest; key material never leaves KMS; access via key policy + IAM; CloudTrail-audited. *AWS-managed vs customer-managed?* → auto-managed by a service vs you control (custom policy/rotation/cross-account). *Envelope encryption?* → KMS encrypts a data key that encrypts the data (efficient for large data).
**💡 Azure:** = the keys part of Key Vault (Azure KV also does secrets/certs → AWS uses Secrets Manager/ACM).

---

# 26. 🔑 Secrets Manager vs Parameter Store `🔴`

**What:** Two services for secrets/config.
```
SECRETS MANAGER → purpose-built secrets, BUILT-IN ROTATION (native RDS),
                  per-secret cost → use when rotation/sensitive
PARAMETER STORE → config + SecureString secrets, FREE standard tier, no
                  rotation → use for config/simple/cheap secrets
Both: fetched at runtime via an IAM role (never hardcoded); KMS-encrypted.
```
**UI:** SM: `Secrets Manager → Store secret → set rotation`. PS: `Systems Manager → Parameter Store → SecureString`.
**🎯 Q&A:** *SM vs Parameter Store?* → SM = secrets + built-in rotation (per-secret cost); PS = config + simple secrets, free tier, no rotation. Rule: rotation needed → SM; config/cheap → PS. *Retrieve without hardcoding?* → app's IAM role fetches at runtime via GetSecretValue/GetParameter.
**💡 Azure:** together ≈ Key Vault (secrets+rotation) + App Configuration (config).

---

# 27. 🔗 Secrets Integration (Services) `🔴`

**What:** How services consume secrets at runtime.
```
EC2/Lambda → IAM role → GetSecretValue at runtime
ECS → task definition "secrets" (by ARN) → injected as env vars (execution role)
EKS → IRSA + Secrets Store CSI Driver → mounted as a file in the pod
RDS → Secrets Manager native rotation → app always reads current password
```
**Unifying pattern:** IAM role → permission → fetch at runtime → nothing stored.
**🎯 Q&A:** *Container gets secrets at runtime?* → ECS: task-def secret refs injected as env vars (execution role); EKS: IRSA + CSI driver mounts as a file. Never in image/YAML. *Common pattern?* → IAM role → permission → runtime fetch → nothing stored (AWS mirror of Azure KV integrations).
**💡 Azure:** = Key Vault integrations (Managed Identity + apps; CSI driver on AKS).

---

# 28. 🛠️ AWS-Native CI/CD `🟡`

**What:** AWS's own CI/CD suite.
```
CodeCommit (Git) → CodeBuild (build, buildspec.yml) → CodeDeploy (deploy
EC2/ECS/Lambda, appspec.yml, blue/green+canary) — orchestrated by CodePipeline
```
**Key facts:** buildspec.yml = build phases; appspec.yml = deploy config; many teams mix with GitHub Actions/Jenkins for CI + CodeDeploy for the AWS deploy step.
**🎯 Q&A:** *AWS-native CI/CD services?* → CodeCommit (repos), CodeBuild (build via buildspec.yml), CodeDeploy (deploy via appspec.yml, blue/green+canary), CodePipeline (orchestration). ≈ Azure DevOps split into services. *buildspec vs appspec?* → build phases vs deploy config.
**💡 Azure:** ≈ Azure DevOps Pipelines (split into separate services).

---

# 29. 🔗 CI/CD Tool → AWS Authentication `🔴`

**What:** How each CI/CD tool authenticates to AWS (your real experience).
```
❌ long-lived IAM keys → ✅ AssumeRole → ✅✅ OIDC (AssumeRoleWithWebIdentity, no keys)
All get short-lived creds via STS. Scope the IAM role least-privilege.
```
**Per tool:**
- **GitHub Actions:** OIDC → `configure-aws-credentials` (gold standard)
- **Azure DevOps:** AWS Toolkit "AWS Service Connection" (assume-role/OIDC, or IAM keys — least preferred)
- **Jenkins:** IAM **instance role** if on EC2 (no keys, ≈ Managed Identity) / OIDC plugin / AssumeRole / Credentials plugin
- **Bitbucket:** built-in **OIDC** (`oidc: true`) → scoped role / secured variables
**🎯 Q&A:** *Secure CI/CD auth to AWS?* → OIDC (IAM OIDC provider + AssumeRoleWithWebIdentity, short-lived, no keys) or an instance role; scope least-privilege. *ADO/Jenkins/Bitbucket each?* → ADO AWS Service Connection (assume-role); Jenkins IAM instance role on EC2 (no keys); Bitbucket built-in OIDC. *STS call?* → AssumeRole / AssumeRoleWithWebIdentity.
**💡 Azure:** = Service Connection + Workload Identity Federation (assume IAM role instead of Entra ID + RBAC).

---

# 30. 🔐 CI/CD Secrets & Security Integration `🔴`

**What:** How each tool handles secrets deploying to AWS (your real experience).
```
GOLDEN RULES: never hardcode · prefer OIDC (no stored AWS keys) · fetch app
secrets from Secrets Manager/Parameter Store at RUNTIME via the assumed role
· use the tool's encrypted/masked store only for values that must live there
· least-priv deploy role · secret scanning · rotation · KMS · env-scoped + approvals
```
**Per tool:**
- **Azure DevOps:** AWS Service Connection (assume-role) → role reads Secrets Manager at runtime; Variable Groups + Key Vault for Azure-side; secure files; masked vars.
- **Jenkins:** IAM instance role → read Secrets Manager at runtime; Credentials Store (by ID, never in Jenkinsfile); HashiCorp Vault plugin; mask output.
- **Bitbucket:** OIDC → role reads Secrets Manager; **Secured** repo/workspace/deployment variables (masked, env-scoped).
- **GitHub Actions:** OIDC → role reads Secrets Manager; Encrypted Secrets (repo/env/org) + Environments with required reviewers.
**🎯 Q&A:** *Handle secrets deploying to AWS?* → OIDC auth (no stored keys) + fetch app secrets from Secrets Manager at runtime via the assumed role; tool's masked store only for values that must live there; least-priv role + scanning + approvals. *Jenkins/Bitbucket specifically?* → Jenkins on EC2 with instance role reads Secrets Manager, Credentials Store by ID; Bitbucket OIDC + Secured Variables scoped per env. *Best pattern?* → OIDC + runtime Secrets Manager → no stored keys AND no stored secrets.
**💡 Azure:** ≈ Variable Groups + Key Vault, masked variables — but pull from Secrets Manager via OIDC role.

---

# 31. 📦 CodeArtifact & ECR `🟠`

**What:** Private registries — packages (CodeArtifact) + images (ECR).
```
CodeArtifact → npm/Maven/PyPI/NuGet packages (proxies public registries) ≈ Azure Artifacts
ECR → container images; ECS/EKS pull via IAM roles (no creds); scanning +
      lifecycle policies + cross-account/region replication ≈ ACR
```
**🎯 Q&A:** *CodeArtifact/ECR?* → package registry (≈ Azure Artifacts) + private image registry with IAM pulls, scanning, lifecycle (≈ ACR). *EKS/ECS pull from ECR securely?* → via IAM roles (task role/IRSA/node role), no stored creds.
**💡 Azure:** CodeArtifact≈Azure Artifacts · ECR≈ACR.

---

# 32. 🌿 Git Branching Strategies `🔴`

**What:** How teams organize branches (cloud-agnostic).
```
Trunk-based (small commits to main + short branches + feature flags via
AppConfig — modern favorite) · GitHub Flow (simple) · GitFlow (versioned, heavier)
Branch protection (reviews + passing CI) keeps main healthy. Squash merge = clean.
```
**🎯 Q&A:** *Trunk-based dev?* → small frequent commits to main + short branches + feature flags; min conflicts, main releasable. *Feature flags?* → decouple deploy from release (AWS AppConfig); rollback = flag flip. *GitFlow vs trunk-based?* → versioned releases vs fast CD.
**💡 Azure:** identical (same on any repo host).

---

# 33. 🚀 Multi-Account CI/CD `🔴`

**What:** Deploy across separate AWS accounts per env, promoting one artifact.
```
CI/CD account builds ONCE (shared ECR) → assumes scoped cross-account
"deploy-role" in dev → staging → prod (each two-sided trust) → deploys the
SAME artifact. Manual approval before prod. Pipeline has NO standing prod access.
```
**Key facts:** accounts = hard isolation; build once/deploy many; cross-account role assumption (Section 6); shared ECR with cross-account pull.
**🎯 Q&A:** *Multi-account CI/CD design?* → central CI/CD account builds once, assumes least-priv cross-account deploy-roles per env (short-lived creds, no standing access), promotes the same artifact, approval before prod. *Why separate accounts?* → hard blast-radius isolation (dev can't touch prod). *Deploy without standing prod access?* → assume a scoped cross-account role only when deploying.
**💡 Azure:** ≈ multi-stage pipeline (Dev→QA→Prod) but across accounts via cross-account AssumeRole (stronger isolation).

---

# 34. 📄 CloudFormation `🟠`

**What:** AWS-native declarative IaC (YAML/JSON).
```
Template → deploy → STACK (managed resource collection); auto dependency
ordering + rollback on failure. Change Set = preview. StackSets = multi-
account/region. Drift Detection = spot manual changes.
```
**🎯 Q&A:** *CloudFormation?* → native declarative IaC; templates → Stacks with dependency ordering, rollback, Change Sets (preview), StackSets (multi-account), drift detection. ≈ ARM/Bicep. *Change Set?* → preview of an update's diff (≈ terraform plan / what-if).
**💡 Azure:** ≈ ARM Templates / Bicep.

---

# 35. 🏗️ AWS CDK `🟡`

**What:** IaC in real languages (TypeScript/Python) → synthesizes to CloudFormation.
```
Write code with CONSTRUCTS (L1 raw → L2 opinionated → L3 patterns) →
cdk synth → CloudFormation → cdk deploy. Loops/conditionals/reuse.
```
**🎯 Q&A:** *CDK?* → define infra in real languages, synthesizes to CloudFormation; enables loops/conditionals/reusable constructs. ≈ Bicep's nicer-authoring goal but with actual code.
**💡 Azure:** ≈ Bicep's goal (nicer authoring), using real code.

---

# 36. 🏗️ Terraform + AWS `🔴`

**What:** How Terraform authenticates to AWS + runs in pipelines.
```
aws provider auth: CLI profile / IAM instance-pod role / AssumeRole / OIDC (best)
→ IAM role policies scope what it creates. Pipeline: init → plan (reviewed)
→ approval → apply. Same workflow/HCL as Azure; differs by provider + auth.
```
**🎯 Q&A:** *TF auth to AWS?* → aws provider via CLI/instance role/AssumeRole/OIDC (best, secretless); IAM role scopes it. *Run in a pipeline?* → OIDC auth → init→plan(reviewed)→approval→apply; state in S3+DynamoDB. *vs Azure?* → same workflow/HCL, different provider (aws vs azurerm) + auth (IAM/OIDC vs Entra ID).
**💡 Azure:** same tool, aws provider + IAM/OIDC instead of azurerm + Entra ID.

---

# 37. 🔐 Terraform State (S3 + DynamoDB) `🔴`

**What:** Remote state + locking for teams.
```
S3 bucket → stores state (versioned + KMS-encrypted)
DynamoDB table → state LOCKING (blocks concurrent applies)
Golden rule: never manually edit TF-managed resources (drift).
```
**UI/config:** `backend "s3" { bucket, key, region, dynamodb_table, encrypt=true }` → terraform init.
**🎯 Q&A:** *TF state on AWS for a team?* → S3 (versioned, encrypted) for the state file + DynamoDB for locking (prevents concurrent-apply corruption). *Why DynamoDB?* → provides the lock S3 alone doesn't. *Golden rule?* → only change TF-managed resources via TF.
**💡 Azure:** = Storage Account backend + blob-lease locking (S3=store, DynamoDB=lock).

---

# 38. 🚦 IaC in CI/CD with Plan Gates `🟠`

**What:** plan → review → approve → apply.
```
.tf change → PR → terraform plan (diff in PR) → APPROVAL GATE → apply the
EXACT saved plan. OIDC auth, S3+DynamoDB state, least-priv role, audit trail.
```
**🎯 Q&A:** *Run IaC safely in a pipeline?* → plan (diff reviewed) → approval → apply the exact saved plan; OIDC auth, S3+DynamoDB state. *Why the exact plan?* → what's applied matches what was reviewed (no drift).
**💡 Azure:** identical concept (plan/what-if → approval → apply).

---

# 39. 🖥️ EC2 `🟠`

**What:** Virtual servers (≈ Azure VMs).
```
Choose: AMI (image) + instance type (t/m/c/r/p families) + key pair + SG +
user data (boot script) + EBS + IAM role
Pricing: On-Demand · Reserved/Savings Plans (steady) · Spot (~90% off,
interruptible) · Dedicated Hosts
```
**🎯 Q&A:** *EC2 config?* → AMI, instance type, key pair, SG, user data, EBS, IAM role (≈ Azure VMs). *Pricing models?* → On-Demand, Reserved/Savings Plans (steady), Spot (interruptible, cheap), Dedicated Hosts. *Access S3 without keys?* → IAM role via instance profile.
**💡 Azure:** ≈ Virtual Machines (AMI≈image, user data≈custom data).

---

# 40. 📈 Auto Scaling Groups & Launch Templates `🔴`

**What:** Elastic, self-healing EC2 (≈ Azure VMSS).
```
Launch Template (blueprint) + ASG (Min/Desired/Max) → multi-AZ, auto-
registers with LB, self-heals (replaces unhealthy). Policies: Target
Tracking (keep CPU at X) / Step / Scheduled. Mix On-Demand + Spot.
```
**🎯 Q&A:** *ASG?* → managed group of identical EC2 (Min/Desired/Max), scales on demand, multi-AZ, auto-registers with LB, self-heals. ≈ Azure VMSS. *Scaling policies?* → Target Tracking (simplest), Step, Scheduled. *Launch Template?* → the instance blueprint.
**💡 Azure:** = VM Scale Set; Launch Template ≈ VMSS config.

---

# 41. 🌱 Elastic Beanstalk `🟡`

**What:** PaaS — deploy code, AWS manages EC2/ASG/ELB (≈ Azure App Service).
```
Upload code/container → Beanstalk provisions + manages EC2 + ASG + ELB +
monitoring. Deployment policies: all-at-once/rolling/immutable/blue-green.
Free (pay for underlying resources).
```
**🎯 Q&A:** *Elastic Beanstalk?* → PaaS; provide code, AWS manages infra (EC2/ASG/ELB/monitoring), multiple deploy policies. ≈ Azure App Service. Good for standard web apps without managing infra.
**💡 Azure:** ≈ App Service.

---

# 42. 🗂️ AWS Batch `🟡`

**What:** Managed batch/compute jobs at scale.
```
Submit jobs → job queue → Batch provisions optimal compute (EC2/Fargate,
Spot) → runs (dependencies/arrays) → scales down. Pay per use.
```
**🎯 Q&A:** *AWS Batch?* → managed batch computing; provisions optimal compute (often Spot), runs containerized jobs with dependencies/parallelism, scales down. For data processing/rendering/ML training/ETL. ≈ Azure Batch.
**💡 Azure:** ≈ Azure Batch.

---

# 43. 🐳 Dockerfile Best Practices `🟠`

**What:** Small, secure images; multi-stage builds are key.
```
Multi-stage: build stage (tools) → runtime stage (minimal base + only
artifacts). Minimal base, pinned tags, layer order (deps before code =
cache), non-root, .dockerignore, NO baked secrets.
```
**🎯 Q&A:** *Multi-stage build?* → build stage with tools + minimal runtime stage with only artifacts → small/secure image. *Layer order?* → deps before code so code changes don't re-install deps (cache). *Security?* → minimal base, non-root, pinned tags, no baked secrets.
**💡 Azure:** identical (push to ECR vs ACR).

---

# 44. 📦 Amazon ECR `🔴`

**What:** Private container image registry (≈ ACR).
```
build → push → ECR; ECS/EKS pull via IAM roles (task role/IRSA/node role,
no creds). Scan-on-push (+ Inspector) · lifecycle policies · cross-account
repo policies (multi-account CI/CD) · cross-region replication.
```
**🎯 Q&A:** *ECR & why over public?* → private image registry with IAM pulls, scanning, lifecycle, replication. ≈ ACR. *EKS/ECS pull securely?* → IAM roles (task/IRSA/node), no stored creds (like AKS→ACR). *Cross-account images?* → ECR repo policy grants other accounts pull.
**💡 Azure:** = ACR.

---

# 45. 🐳 Amazon ECS (Fargate vs EC2) `🔴`

**What:** AWS-native container orchestrator (simpler than Kubernetes).
```
Task Definition (blueprint) → Task (running) → Service (keeps N + LB +
scaling) → Cluster.
FARGATE = serverless (no nodes, pay per task — default) · EC2 = you manage
the node cluster (control, GPUs, cost tuning).
```
**Key facts:** task role (app perms) + execution role (pull images/secrets/logs); no Kubernetes knowledge needed; deep AWS integration.
**🎯 Q&A:** *ECS vs EKS?* → ECS = AWS-native simpler orchestrator (no K8s needed); EKS = managed Kubernetes (portable, complex). *Fargate vs EC2?* → serverless (no nodes, default) vs you manage the node cluster (control/GPUs). *Tasks get perms/secrets?* → task role + execution role, no stored creds.
**💡 Azure:** ≈ Container Apps (simpler AWS-native) vs full AKS.

---

# 46. ☸️ Amazon EKS `🔴`

**What:** Managed Kubernetes (≈ AKS).
```
Control plane (AWS-managed, HOURLY FEE — unlike AKS free) + worker nodes
(Managed Node Groups / Fargate / Karpenter). Standard K8s + AWS integrations:
IRSA (pods→IAM roles ≈ Workload Identity), ECR, AWS LB Controller, VPC CNI.
```
**🎯 Q&A:** *EKS vs AKS?* → both managed Kubernetes; EKS control plane has an hourly fee, AKS's is free. *Pods get AWS perms?* → IRSA / Pod Identity (≈ AKS Workload Identity). *ECS vs EKS?* → AWS-native simplicity vs full Kubernetes/portability.
**💡 Azure:** = AKS (but EKS charges for the control plane).

---

# 47. 🚪 ECS/EKS Ingress & Service Discovery `🟠`

**What:** External routing + internal service-to-service.
```
Ingress: EKS Ingress + AWS Load Balancer Controller → one ALB routes many
services by path/host; ECS → Service + ALB target groups.
Discovery: EKS Kubernetes DNS · ECS AWS Cloud Map (reach by name, not IP).
```
**🎯 Q&A:** *Expose many microservices with one entry point?* → EKS Ingress + AWS LB Controller → one ALB routes by path/host; backends stay internal (ClusterIP). *Service discovery?* → Kubernetes DNS (EKS) / Cloud Map (ECS). *Ingress vs Ingress Controller?* → rules vs the software that executes them (AWS LB Controller / NGINX).
**💡 Azure:** ≈ AKS Ingress + Kubernetes DNS.

---

# 48. ⎈ Helm & GitOps (Argo/Flux) `🟠`

**What:** Package K8s apps (Helm) + declarative Git-synced delivery (GitOps).
```
Helm → Charts (templated YAML + values), versioned releases, upgrade/rollback
GitOps (Argo CD/Flux) → Git = source of truth; tool IN the cluster
continuously syncs cluster to Git (pull-based); rollback = git revert;
auto-corrects drift; no cluster creds in the pipeline.
```
**🎯 Q&A:** *Helm?* → K8s package manager; versioned Charts, per-env values, easy upgrade/rollback. *GitOps / Argo CD?* → Git is source of truth; the in-cluster tool continuously reconciles the cluster to Git (pull-based, auditable, rollback = revert). *Helm vs GitOps?* → complementary: Helm packages, GitOps delivers.
**💡 Azure:** identical (Helm/GitOps same on AKS).

---

# 49. 📈 Container Autoscaling (HPA/CA/Karpenter) `🟠`

**What:** Two-level scaling — pods + nodes.
```
HPA → scales POD replicas on metrics (CPU/mem/custom)
Cluster Autoscaler → scales EC2 node groups when pods pending
KARPENTER → AWS-native, provisions RIGHT-SIZED nodes fast (Spot-friendly,
            no rigid node groups) — increasingly preferred on EKS
ECS → Service Auto Scaling (tasks) + capacity providers/Fargate
```
**🎯 Q&A:** *EKS autoscaling?* → HPA (pods) + node autoscaler (Cluster Autoscaler or Karpenter) working together — HPA adds pods, node autoscaler adds nodes to fit them. *Cluster Autoscaler vs Karpenter?* → CA scales predefined node groups; Karpenter provisions right-sized nodes directly, fast, Spot-friendly (preferred).
**💡 Azure:** HPA identical; Karpenter is AWS-native (no direct AKS equivalent).

---

# 50. ⚡ AWS Lambda `🔴`

**What:** Serverless compute — run code on events, no servers (≈ Azure Functions).
```
Trigger (API Gateway/S3/SQS/SNS/EventBridge/DynamoDB streams) → function
runs → stops. Auto-scales from 0; pay per invocation + ms runtime.
Invocation: sync (API GW) / async (S3, SNS) / stream-poll (SQS, streams).
```
**Key facts:** **15-min max timeout** (longer → Step Functions/Batch); **Provisioned Concurrency** eliminates cold starts; execution role = permissions (no keys); secrets from Secrets Manager at runtime; VPC-connect for private resources; Lambda@Edge.
**UI:** `Lambda → Create function → runtime + execution role → add trigger → memory/timeout`.
**🎯 Q&A:** *Lambda?* → serverless compute on triggers, auto-scales from 0, pay per use (≈ Azure Functions). *Timeout & longer jobs?* → 15-min max; use Step Functions/Batch/ECS. *Cold starts?* → Provisioned Concurrency (≈ Functions Premium). *Perms/secrets?* → execution role + Secrets Manager at runtime.
**💡 Azure:** = Azure Functions.

---

# 51. 🚪 API Gateway `🔴`

**What:** Managed API front door (esp. for Lambda).
```
Clients → API Gateway → Lambda/HTTP backend. Handles routing, AUTH (IAM/
Cognito/Lambda authorizers/API keys), THROTTLING, transformation, caching, TLS.
Types: REST (full-featured) · HTTP (simple/cheap/fast) · WebSocket (real-time)
```
**🎯 Q&A:** *API Gateway?* → managed API front door (routing/auth/throttling/caching/TLS), standard way to expose Lambda. ≈ Azure API Management. *REST vs HTTP vs WebSocket?* → full-featured vs simple/cheap/fast vs real-time. *Protect the backend?* → throttling + usage plans + auth + caching.
**💡 Azure:** ≈ API Management (+ standard Lambda HTTP layer).

---

# 52. 🪣 Amazon S3 `🔴`

**What:** Durable (11 nines), unlimited object storage (≈ Blob Storage).
```
Objects in globally-named BUCKETS. Storage classes: Standard → Standard-IA →
Intelligent-Tiering → Glacier (archival). Lifecycle policies auto-tier/expire.
Access: IAM/bucket policies + Block Public Access (default ON) + PRE-SIGNED
URLs (≈ SAS). Versioning · SSE-KMS · S3 Events (→ Lambda/SQS/SNS/EventBridge).
```
**Key facts:** also backs Terraform state, artifacts, data lakes, static sites; cross-region replication; Object Lock (WORM).
**UI:** `S3 → Create bucket (Block Public Access ON, encryption, versioning) → lifecycle rule`; `aws s3 presign`.
**🎯 Q&A:** *Storage classes/lifecycle?* → cost vs access (Standard→IA→Intelligent-Tiering→Glacier); lifecycle auto-transitions. ≈ Azure tiers. *Temp access without public bucket?* → pre-signed URL (≈ SAS). *Secure a bucket?* → Block Public Access on, IAM/bucket policies, SSE-KMS, versioning, pre-signed URLs. *Durability?* → 11 nines across AZs.
**💡 Azure:** = Blob Storage (pre-signed URL≈SAS, classes≈tiers, S3 events≈Event Grid).

---

# 53. 📬 Amazon SQS `🔴`

**What:** Managed message queue — decouple producers/consumers.
```
Producer → SQS QUEUE → consumer polls & deletes. If consumer down, messages
WAIT (no cascade). Standard (high throughput, at-least-once) vs FIFO (ordered,
exactly-once). Visibility Timeout · Dead-Letter Queue (DLQ) · triggers Lambda.
```
**🎯 Q&A:** *SQS & why?* → managed queue decoupling producers/consumers; messages wait if consumer's down (no cascade). ≈ Azure Queue Storage/Service Bus. *Standard vs FIFO?* → high-throughput at-least-once vs ordered exactly-once. *Visibility Timeout/DLQ?* → hide in-flight messages / capture repeated failures.
**💡 Azure:** ≈ Queue Storage (Standard) / Service Bus (FIFO).

---

# 54. 📢 Amazon SNS `🟠`

**What:** Managed pub/sub — publish once, deliver to many (fan-out).
```
Publisher → SNS TOPIC → all subscribers (SQS, Lambda, HTTP, email, SMS, push)
PUSH model (vs SQS pull). Fan-out pattern: SNS → multiple SQS queues →
parallel durable processing. Message filtering per subscriber.
```
**🎯 Q&A:** *SNS vs SQS?* → SNS = push pub/sub one-to-many (fan-out/notifications); SQS = pull queue one-to-one (work). *Fan-out pattern?* → SNS topic → multiple SQS queues → parallel durable processing (very common).
**💡 Azure:** ≈ Event Grid (fan-out) + Notification Hubs (push).

---

# 55. 🔔 Amazon EventBridge `🔴`

**What:** Serverless event bus — content-based routing (richer than SNS).
```
Sources (200+ AWS service events, custom apps, SaaS) → EventBridge → RULES
(match event content) → targets (Lambda/SQS/SNS/Step Functions/ECS/Kinesis).
EventBridge Scheduler = cron. Schema Registry.
```
**🎯 Q&A:** *EventBridge vs SNS?* → EventBridge = smart bus with content-based rules, many AWS/SaaS sources, scheduling; SNS = simple pub/sub fan-out. Use EventBridge for complex routing / reacting to AWS service events / SaaS / cron. ≈ Azure Event Grid. *Scheduler?* → managed cron to trigger targets.
**💡 Azure:** ≈ Event Grid.

---

# 56. 🔀 AWS Step Functions `🟠`

**What:** Orchestrate multi-step workflows as visual state machines.
```
States: Task (do work) · Choice (branch) · Parallel · Map (loop) · Wait —
with built-in RETRIES + error handling per state. Integrates 200+ services.
Standard (long/auditable) vs Express (high-volume/short). Full execution history.
```
**🎯 Q&A:** *Step Functions & when?* → managed orchestration of multi-step workflows (state machines) with branching/retries/error handling; use for complex workflows (order fulfillment, ETL, ML) vs brittle Lambda-calls-Lambda. ≈ Azure Durable Functions. *Standard vs Express?* → long/auditable vs high-volume/short.
**💡 Azure:** ≈ Durable Functions / Logic Apps.

---

# 57. 🌊 Amazon Kinesis `🟡`

**What:** Real-time streaming ingestion/processing.
```
Data Streams → real-time, ordered, sharded stream you process (e.g. Lambda)
              ≈ Event Hubs
Firehose → managed delivery of streaming data to S3/Redshift/OpenSearch
           (optional Lambda transform), no consumer management
```
**🎯 Q&A:** *Kinesis & when?* → real-time streaming (clickstream/IoT/logs); Data Streams = ordered sharded streams you process (≈ Event Hubs), Firehose = managed delivery to storage/analytics. *Data Streams vs Firehose?* → process yourself (low latency, replay) vs managed auto-delivery.
**💡 Azure:** ≈ Event Hubs / Stream Analytics.

---

# 58. ⚡ Amazon DynamoDB `🔴`

**What:** Serverless NoSQL, single-digit-ms at any scale (≈ Cosmos DB).
```
Tables of items keyed by PARTITION KEY (high-cardinality!) + optional SORT KEY.
Design around ACCESS PATTERNS (denormalize). GSI (query any attr) / LSI.
On-Demand vs Provisioned. Streams (→ Lambda, change capture) · DAX (µs cache) ·
Global Tables (multi-region) · TTL (auto-expire) · transactions · 2 consistency levels.
```
**UI:** `DynamoDB → Create table → partition key (+ sort) → capacity mode → GSIs → Streams/TTL`.
**🎯 Q&A:** *DynamoDB & when?* → serverless NoSQL, single-digit-ms at scale; for high-scale low-latency flexible-schema (serverless apps, sessions, IoT). ≈ Cosmos DB. *Table design?* → around access patterns; high-cardinality partition key (avoid hot partitions) + sort key + GSIs. *Streams/DAX?* → change capture → Lambda / µs read cache. *vs Cosmos?* → both serverless NoSQL; Cosmos = 5 consistency levels, DynamoDB = 2.
**💡 Azure:** = Cosmos DB (Streams≈Change Feed, DAX≈cache).

---

# 59. 🧩 SAM & Serverless Framework `🟡`

**What:** IaC specialized for serverless.
```
SAM → AWS-native CloudFormation extension, concise serverless syntax + LOCAL
      testing (sam local). Serverless Framework → 3rd-party, multi-cloud,
      plugin-rich (serverless.yml). Both: define Lambda+API GW+DynamoDB+events
      concisely, deploy in one command.
```
**🎯 Q&A:** *SAM & Serverless Framework?* → serverless-specialized IaC; SAM = AWS-native (concise, local testing via sam local), Serverless Framework = 3rd-party multi-cloud. Both define the whole serverless stack concisely + one-command deploy.
**💡 Azure:** ≈ Bicep/ARM + Functions tooling for serverless.

---

# 60. 💾 EBS & EFS `🟠`

**What:** Block storage (one instance) vs shared file storage (many).
```
EBS → block storage, ONE instance (per AZ), gp3/io2/st1/sc1; snapshots to S3 ≈ Managed Disks
EFS → shared NFS, MANY instances multi-AZ, auto-scales ≈ Azure Files
```
**🎯 Q&A:** *EBS vs EFS?* → EBS = block storage for one instance (OS/DB/single-instance data) ≈ Managed Disks; EFS = shared NFS many instances mount ≈ Azure Files. *Back up EBS?* → snapshots (incremental, to S3) via DLM/AWS Backup.
**💡 Azure:** EBS≈Managed Disks · EFS≈Azure Files.

---

# 61. 🗃️ RDS & Aurora `🟠`

**What:** Managed relational DB + AWS's high-perf engine.
```
RDS → managed relational (MySQL/PG/MariaDB/Oracle/SQL Server/Aurora)
   Multi-AZ = automatic-failover HA (standby NOT readable)
   Read Replicas = read scaling (async, readable, cross-region)
Aurora → cloud-native MySQL/PG-compatible (~5x/3x perf, 6 copies/3 AZs,
         Serverless v2). RDS Proxy = connection pooling (great for Lambda).
```
**🎯 Q&A:** *RDS & Aurora?* → managed relational DB (AWS handles patching/backups/HA); Aurora = high-perf cloud-native MySQL/PG engine (auto-scaling storage, Serverless v2). ≈ Azure SQL/MySQL/PG; Aurora ~ Hyperscale. *Multi-AZ vs Read Replicas?* → HA/auto-failover (non-readable standby) vs read scaling (readable async copies). Don't confuse. *Creds/Lambda?* → Secrets Manager (rotation) + RDS Proxy (pooling).
**💡 Azure:** RDS≈Azure SQL/MySQL/PostgreSQL · Aurora ~ SQL Hyperscale.

---

# 62. 🚀 ElastiCache `🟡`

**What:** Managed in-memory cache (Redis/Memcached).
```
App → cache first: HIT (sub-ms) / MISS → DB → cache result. Offloads read-
heavy DB traffic. Redis (rich, persistent, HA) vs Memcached (simple k-v).
Uses: query cache, session store, leaderboards, rate limiting. Use TTLs.
```
**🎯 Q&A:** *ElastiCache & why?* → managed in-memory cache (Redis/Memcached), sub-ms reads offloading DB load; for query cache/sessions/leaderboards/rate limiting. Redis≈Azure Cache for Redis. *Redis vs Memcached?* → rich/persistent/HA vs simple k-v no-persistence.
**💡 Azure:** Redis ≈ Azure Cache for Redis.

---

# 63. 🔵🟢 Blue/Green (CodeDeploy) `🔴`

**What:** Two envs, instant switch + rollback.
```
Blue (live) · Green (idle) → deploy+test Green → switch traffic → Blue =
rollback. AWS: CodeDeploy (ECS/Lambda/EC2, auto-rollback on CloudWatch alarm),
ALB target-group swap, or Route 53 weighting.
```
**🎯 Q&A:** *Blue/Green on AWS?* → two envs, deploy+test idle, switch instantly, switch back to roll back; via CodeDeploy (auto-rollback on alarms)/ALB/Route 53. ≈ App Service slot swap. *Trade-off?* → two envs + all-or-nothing switch (Canary refines).
**💡 Azure:** ≈ App Service slot swap.

---

# 64. 🐤 Canary, Rolling & Rollback `🔴`

**What:** Gradual shift, batch updates, recovery.
```
Canary → shift small % → monitor → increase (abort = weight 0%); AWS via
CodeDeploy canary/linear, ALB/Route 53 weights, EKS mesh/Flagger
Rolling → batch-by-batch (ECS/EKS/ASG default)
Rollback → switch-back / canary-0% / CodeDeploy auto-rollback on alarm /
           helm rollback / feature-flag-off (instant)
```
**🎯 Q&A:** *Canary vs Blue/Green?* → gradual % shift (limits blast radius, instant abort) vs 100% switch; AWS via CodeDeploy traffic-shifting. *Rolling?* → batch updates, ECS/EKS/ASG default. *Roll back?* → switch-back/canary-0%/auto-rollback/helm/flag-off.
**💡 Azure:** identical strategies.

---

# 65. 🚩 Feature Flags (AppConfig) `🟠`

**What:** Decouple deploy from release; toggle at runtime.
```
Deploy dark (flag OFF) → enable gradually → problem? flag OFF = instant
rollback (no redeploy). AWS AppConfig (Systems Manager): flags + dynamic
config deployed separately, gradual rollout + validation + auto-rollback on alarm.
```
**🎯 Q&A:** *Feature flags & AppConfig?* → decouple deploy from release (deploy dark → enable gradually → flag-off = instant rollback); AWS AppConfig stores flags/config deployed separately with gradual rollout + auto-rollback. Underpins trunk-based dev. ≈ Azure App Configuration.
**💡 Azure:** ≈ App Configuration (Feature Manager).

---

# 66. 📊 CloudWatch `🔴`

**What:** Central observability (≈ Azure Monitor).
```
Metrics (numerical time-series) · Logs (Log Groups) · Alarms (fire on
threshold → SNS/Auto Scaling/Lambda remediation) · Dashboards.
⚠️ EC2 CPU/network auto; MEMORY/DISK need the CloudWatch Agent.
```
**🎯 Q&A:** *CloudWatch?* → central observability (metrics/logs/alarms/dashboards) ≈ Azure Monitor. *EC2 gotcha?* → memory/disk need the CloudWatch Agent (like Azure Monitor Agent). *Alarm actions?* → SNS notify, Auto Scaling, EC2 recover, Lambda remediation.
**💡 Azure:** = Azure Monitor.

---

# 67. 🔎 CloudWatch Logs Insights `🔴`

**What:** Query logs to find WHY (metrics say WHAT).
```
Logs → Log Groups → query (pipe language: fields | filter | stats | sort | parse)
e.g.: fields @timestamp,@message | filter @message like /ERROR/ | stats count() by bin(5m)
Metric filters turn log patterns into alarmable metrics.
```
**🎯 Q&A:** *Logs Insights?* → query centralized logs (fields/filter/stats/sort/parse) to find root cause behind metric alarms. ≈ Azure Log Analytics + KQL. *Metrics vs logs?* → "that" (numerical) vs "why" (detailed). *Metric filter?* → extract a metric from log patterns to alarm on.
**💡 Azure:** ≈ Log Analytics + KQL.

---

# 68. 🔬 X-Ray (Distributed Tracing) `🟠`

**What:** Trace a request across services to find the bottleneck.
```
Instrument (SDK / enable on Lambda/API GW/ECS) → traces + a SERVICE MAP
(services + latencies/errors) → pinpoints WHICH service is slow/failing.
```
**🎯 Q&A:** *X-Ray?* → distributed tracing following a request across services + a Service Map, pinpointing which service caused slowness/failure. ≈ Azure Application Insights distributed tracing.
**💡 Azure:** ≈ Application Insights (distributed tracing / Application Map).

---

# 69. 🚨 Alerting & Incident Response `🟡`

**What:** Tiered actionable alerts + structured response.
```
Alerts tiered by severity (Critical=page/SNS→PagerDuty · High=SMS · Warning=
email); alert on user-felt SYMPTOMS; avoid fatigue.
Incident: Detect→Ack→Triage→MITIGATE FIRST (rollback/flag-off/failover)→
Investigate (CloudWatch/Logs Insights/X-Ray)→Resolve→blameless post-mortem.
```
**🎯 Q&A:** *Good alerting?* → tiered, actionable, on user-felt symptoms, avoid fatigue (CloudWatch→SNS→PagerDuty). *Incident response?* → detect→ack→triage→mitigate first→investigate→resolve→blameless post-mortem (mitigate-then-investigate).
**💡 Azure:** identical SRE practice.

---

# 70. 🎯 SLI / SLO / SLA & Error Budgets `🟡`

**What:** Measure + commit to reliability.
```
SLI = measurement · SLO = internal target · SLA = customer contract w/ penalties (loosest)
Error Budget = inverse of SLO → budget left = ship fast; exhausted = focus on stability
```
**🎯 Q&A:** *SLI/SLO/SLA?* → measurement / internal target / customer contract with penalties. *Error budget?* → allowed unreliability (inverse of SLO); data-drives velocity vs stability. (Measured via CloudWatch.)
**💡 Azure:** identical SRE concepts.

---

# 71. 🔐 DevSecOps on AWS `🔴`

**What:** Security in every pipeline stage + AWS security services.
```
Shift-left scans (fail on critical): secret · SAST · SCA · container (ECR/
Inspector) · IaC (Checkov). Guardrails: SCPs (preventive) + Config (detective).
Runtime: GuardDuty (threats) · Inspector (vulns) · Security Hub (posture) · Macie (PII).
3 pillars: secrets (Secrets Manager+IAM), policy (SCPs+Config), least-priv IAM.
```
**🎯 Q&A:** *DevSecOps/shift-left?* → security scans at every stage (secret/SAST/SCA/container/IaC) + SCPs/Config guardrails + GuardDuty/Inspector/Security Hub. *AWS security services?* → GuardDuty (threat detection ≈ Defender), Inspector (vuln scan), Security Hub (posture), Macie (PII), Config (compliance), SCPs (guardrails). *Secrets?* → Secrets Manager + IAM at runtime + scanning.
**💡 Azure:** GuardDuty≈Defender for Cloud · SCPs/Config≈Azure Policy.

---

# 72. 🤖 AI-Assisted DevOps (Amazon Q/Bedrock) `🟠`

**What:** Apply AI to reduce DevOps toil.
```
Pipeline failure → Bedrock/Amazon Q summarizes + suggests fix
PR review → Amazon Q flags IaC/pipeline issues · Log query → plain English → Logs Insights
Anomaly → CloudWatch Anomaly Detection (ML thresholds) · DevOps Guru (auto-detect issues)
⚠️ Always HUMAN-VERIFY AI suggestions.
```
**🎯 Q&A:** *AI in DevOps on AWS?* → failure analysis (Amazon Q/Bedrock), AI reviews (Amazon Q), plain-English→Logs Insights, ML anomaly detection (CloudWatch Anomaly Detection/DevOps Guru) — apply existing tools, not build models. *Caveat?* → human-verify; AI is a co-pilot.
**💡 Azure:** Bedrock≈Azure OpenAI · DevOps Guru≈App Insights Smart Detection.

---

# 73. 🛂 Config & SCPs `🟠`

**What:** Detective compliance (Config) + preventive guardrails (SCPs).
```
SCP → PREVENTIVE org/OU ceiling; BLOCKS actions before they happen (deny
      leaving region, deny disabling CloudTrail); unoverridable; grants nothing
Config → DETECTIVE; records config + evaluates rules → flags non-compliant
         (public S3, unencrypted EBS) → optional auto-remediation
```
**🎯 Q&A:** *SCPs vs Config?* → SCPs = preventive org-wide guardrails (block before it happens, cap max perms); Config = detective (flag + auto-remediate non-compliance). Use SCPs to prevent the worst, Config to detect/fix drift. Together ≈ Azure Policy. *SCP + IAM?* → SCP is a ceiling, doesn't grant; still need an IAM policy to allow.
**💡 Azure:** SCPs + Config ≈ Azure Policy (deny + audit/remediation).

---

# 74. 📜 CloudTrail `🟠`

**What:** Logs every API call — who did what, when, from where (audit).
```
Every API call → CloudTrail event → S3 (long-term, tamper-evident) +
CloudWatch Logs (alarm). Management (default) / data / Insights events.
Organization Trail = central audit across all accounts (log-archive account).
```
**🎯 Q&A:** *CloudTrail?* → logs every API call (who/what/when/where) to S3 + CloudWatch; essential for security/audit/troubleshooting ("who deleted this?"). ≈ Azure Activity Log. *Central audit?* → Organization Trail → locked-down log-archive account + log-file validation.
**💡 Azure:** ≈ Activity Log.

---

# 75. 🏷️ Tagging & Naming `🟡`

**What:** Metadata for cost/ownership/automation/governance.
```
Tags: Environment/Project/Owner/CostCenter/ManagedBy → cost allocation,
ownership, automation, governance. Enforce via Tag Policies + SCPs (deny
untagged) + Config (audit).
```
**🎯 Q&A:** *Why tags/naming & enforce?* → cost attribution/ownership/automation/governance; enforce via Tag Policies + SCPs (deny untagged) + Config (audit). ≈ Azure tags + Azure Policy.
**💡 Azure:** = Azure tags (enforced via SCPs/Config vs Azure Policy).

---

# 76. 🏗️ Landing Zone / Control Tower `🟡`

**What:** Automated governed multi-account foundation.
```
Control Tower → multi-account structure + management/log-archive/audit
accounts + guardrails (SCPs+Config) + IAM Identity Center SSO + Account
Factory (vend pre-governed accounts). Workloads land secure from day one.
```
**🎯 Q&A:** *Control Tower / Landing Zone?* → automates a governed multi-account foundation (OUs, log-archive/audit accounts, SCP+Config guardrails, SSO, Account Factory) so workloads land secure/compliant from day one. ≈ Azure Landing Zone.
**💡 Azure:** = Azure Landing Zone / Control Tower.

---

# 77. 💰 Cost Management & FinOps `🟡`

**What:** Cost visibility/control + the discipline.
```
Cost Explorer (breakdown by service/tag/account) · Budgets (alerts 50/75/90/
100%) · Cost Anomaly Detection (ML). Levers: Savings Plans/RIs (steady), Spot
(fault-tolerant), right-size (Compute Optimizer), delete orphaned resources,
S3 tiering, stop non-prod off-hours. FinOps = cost as a shared responsibility.
```
**🎯 Q&A:** *Control AWS costs?* → Cost Explorer + Budgets + Anomaly Detection; levers = Savings Plans/RIs, Spot, right-sizing, delete orphaned (unattached EBS/idle NAT/unused EIPs), S3 tiering, stop non-prod off-hours; tags underpin attribution. *FinOps?* → cost as a shared, continuous, first-class responsibility.
**💡 Azure:** ≈ Cost Management + Reservations; FinOps identical.

---

# 78. 🔄 Backup & DR (RTO/RPO) `🟡`

**What:** Protect data + restore apps; measured by RTO/RPO.
```
RPO = data loss tolerance · RTO = downtime tolerance (set by criticality)
DR patterns (cost↑resilience↑): Backup&Restore → Pilot Light → Warm Standby
→ Active-Active. Tools: AWS Backup, cross-region replication (S3/RDS/DynamoDB
Global Tables), Elastic DR, Route 53 failover. ALWAYS TEST failovers.
```
**🎯 Q&A:** *RTO vs RPO?* → downtime vs data-loss tolerance; set by criticality. *DR strategies?* → Backup&Restore → Pilot Light → Warm Standby → Active-Active (cost/resilience). *Tools/practice?* → AWS Backup, cross-region replication, Elastic DR, Route 53 failover; always test.
**💡 Azure:** AWS Backup≈Azure Backup · Elastic DR≈Site Recovery; RTO/RPO universal.

---

# 79. 🔥 All Integration Flows `🔴`

**⭐ Interviewers probe how services connect. One pattern behind almost all.**
```
1. CI/CD → AWS:      tool → OIDC/AssumeRole (STS) → scoped IAM role → deploy
2. Pipeline → Secrets: assumed role → Secrets Manager at runtime
3. Pipeline → ECR:   build → push (via assumed role)
4. ECR → ECS/EKS:    task role/IRSA/node role → pull image (no creds)
5. Terraform → AWS:  aws provider → OIDC/AssumeRole → resources (S3+DynamoDB state)
6. EKS Pod → Secrets: IRSA → Secrets Manager (CSI mounts as file)
7. App → Monitoring: app+X-Ray → CloudWatch + X-Ray → SNS → PagerDuty
8. Cross-Account:    assume target-account role (two-sided trust)
9. Serverless:       API GW → Lambda → DynamoDB; S3 event → Lambda; EventBridge → target
10. Event-Driven:    SNS → multiple SQS (fan-out); EventBridge rules → targets
```
**⭐ THE unifying pattern:** `IAM identity → STS short-lived creds (AssumeRole) → scoped permissions → target, NO long-lived stored keys.`
**🎯 Scenario Q:** *Pipeline builds → pushes → deploys to ECS/EKS → app reads a secret — walk the auth.* → OIDC (AssumeRole, no keys) → push to ECR → ECS/EKS pull via task role/IRSA → app reads Secrets Manager via its role. Every step: IAM identity → STS → scoped perms → target, no stored creds.
**💡 Azure:** = the identity → Entra ID → RBAC → resource pattern.

---

# 80. 🎓 Rapid-Fire Q&A `🔴`

**Identity:** IAM = auth+authz (JSON) · Users (long-term) vs Roles (short-lived, preferred) · eval = **default deny → allow → deny wins** · Permission Boundary (per-identity ceiling) vs SCP (org ceiling) · STS AssumeRole; cross-account = two-sided trust · instance role ≈ Managed Identity · IRSA ≈ Workload Identity · CI/CD auth = OIDC.

**Networking:** VPC ≈ VNet (needs IGW; AZ-scoped subnets) · public=IGW route, private=NAT · SG (instance/stateful/allow-only) vs NACL (subnet/stateless/allow+deny) · SG-as-source = autoscale-safe · peering non-transitive → Transit Gateway (transitive) · Gateway Endpoint (S3/DDB, free) vs Interface/PrivateLink · ALB(L7)/NLB(L4) · Reachability Analyzer for "why can't X reach Y?".

**Secrets/Security:** Secrets Manager (rotation) vs Parameter Store (config/cheap) · fetch at runtime via IAM role · KMS = keys (envelope encryption) · DevSecOps = shift-left scans + SCPs/Config + GuardDuty/Inspector/Security Hub.

**CI/CD:** OIDC (no stored keys) — ADO (Service Connection), Jenkins (instance role), Bitbucket (OIDC), GitHub (OIDC) · trunk-based + AppConfig flags · build once/deploy many · multi-account = cross-account AssumeRole · buildspec/appspec.

**Containers:** multi-stage builds · ECR via IAM roles · ECS (Fargate/EC2) vs EKS (K8s) · AKS free CP, **EKS charges for CP** · HPA (pods) + Cluster Autoscaler/**Karpenter** (nodes) · Helm + GitOps (Argo/Flux, pull-based).

**Serverless:** Lambda (15-min max, Provisioned Concurrency, execution role) · API GW → Lambda → DynamoDB · S3 (classes/lifecycle/pre-signed≈SAS/events) · SQS (queue) vs SNS (fan-out) · SNS→SQS fan-out · EventBridge (content bus ≈ Event Grid) · Step Functions (≈ Durable Functions) · DynamoDB (partition key, GSI, Streams, DAX) · Kinesis (≈ Event Hubs).

**Deploy/Observe:** Blue/Green (CodeDeploy) vs Canary (gradual %) · rollback = switch-back/canary-0%/auto-rollback/helm/flag-off · CloudWatch (agent for memory/disk) · Logs Insights (why) vs metrics (that) · X-Ray (which service) · RTO/RPO · SLI/SLO/SLA.

**Governance:** SCPs (preventive) + Config (detective) ≈ Azure Policy · CloudTrail ≈ Activity Log · Control Tower = Landing Zone · Cost Explorer+Budgets+Savings Plans/Spot · AWS Backup + DR patterns.

**Scenarios:** *Secure CI/CD to EKS?* → OIDC (no keys) → build+test+scan → ECR → EKS (IRSA/node role) → pod reads Secrets Manager via IRSA → approval → canary → CloudWatch/X-Ray. *Prod deploy errored?* → mitigate first (CodeDeploy auto-rollback/flag-off), investigate (CloudWatch/Logs Insights/X-Ray), resolve, post-mortem.

**Themes:** least privilege · no long-lived stored keys (IAM roles/OIDC/STS) · build once/deploy many · mitigate-then-investigate · defense-in-depth · IAM identity → STS → scoped perms → target.

---

# 81. 📌 Final Quick Reference `🔴`

## Azure ↔ AWS Map
```
Entra ID+RBAC→IAM · Managed Identity/SP→IAM Role · WIF→OIDC+AssumeRoleWithWebIdentity · (token)→STS
Mgmt Group/Sub/RG→OU/Account/(tags) · Azure Policy→SCPs+Config
VM→EC2 · VMSS→ASG · Blob→S3 · SAS→pre-signed URL · Managed Disks→EBS · Files→EFS
VNet→VPC · NSG→Security Group+NACL · Azure Firewall→Network Firewall · Private/Service Endpoint→Interface/Gateway Endpoint
App Gateway/LB→ALB/NLB · Hub-Spoke/vWAN→Transit Gateway · Azure DNS+Traffic Mgr→Route 53 · ExpressRoute→Direct Connect · VPN GW→S2S VPN
Key Vault→Secrets Manager+Parameter Store+KMS · Azure SQL→RDS/Aurora · Cosmos DB→DynamoDB · Cache for Redis→ElastiCache
AKS(free CP)→EKS(paid CP) · Container Apps(~)→ECS · ACR→ECR · Functions→Lambda · API Mgmt→API Gateway
Queue Storage/Service Bus→SQS · Event Grid→SNS/EventBridge · Durable Functions→Step Functions · Event Hubs→Kinesis
Azure DevOps→CodePipeline(+GitHub Actions) · ARM/Bicep→CloudFormation/CDK · Terraform→Terraform · Storage+blob-lease→S3+DynamoDB
Monitor→CloudWatch · Log Analytics/KQL→Logs Insights · App Insights→X-Ray · App Configuration→AppConfig
Defender→GuardDuty · Defender(vuln)→Inspector · Sentinel/Defender→Security Hub · Activity Log→CloudTrail · Landing Zone→Control Tower
Cost Management→Cost Explorer+Budgets · Backup/Site Recovery→AWS Backup/Elastic DR · Copilot/Azure OpenAI→Amazon Q/Bedrock
```

## Key Numbers
```
/24=256 (subnet) · /16=65,536 (VPC) · 5 IPs reserved/subnet (/24=251 usable)
Lambda: 15-min max, 10 GB max mem · SQS: 14-day retention, 256 KB msg
S3: 11 nines durability · STS: 15min–12hr creds · EKS: control plane has hourly fee
IAM eval: default deny → explicit allow → explicit deny wins
Ports: 22 SSH·80 HTTP·443 HTTPS·3389 RDP·3306 MySQL·5432 Postgres·1433 SQL
```

## "Say This" One-Liners
```
Auth: "IAM identity → STS short-lived creds → scoped permissions → target; no long-lived keys via IAM roles + OIDC."
CI/CD auth: "OIDC — IAM OIDC provider + AssumeRoleWithWebIdentity, short-lived, least-privilege, no stored keys."
Secrets: "Never hardcode — Secrets Manager/Parameter Store fetched at runtime via an IAM role."
IAM eval: "Default deny; explicit allow grants; explicit deny always wins."
Deployment: "Build once, deploy many; approval before prod; Blue/Green or Canary with auto-rollback on CloudWatch alarms."
Networking: "Defense in depth — private subnets, Security Groups, PrivateLink, NACLs, Network Firewall for central egress."
Multi-account: "Separate accounts per env; pipeline assumes scoped cross-account roles — no standing prod access."
Incident: "Mitigate first (rollback/flag-off), then investigate with CloudWatch, Logs Insights, X-Ray."
Containers: "ECS for AWS-native simplicity, EKS for Kubernetes; pods via IRSA; Karpenter for fast node autoscaling."
```

## Night-Before Checklist
```
✅ IAM eval logic (default deny→allow→deny wins) · Users vs Roles · Boundary vs SCP · STS AssumeRole + cross-account trust
✅ OIDC for CI/CD (ADO/Jenkins/Bitbucket/GitHub → AWS)
✅ VPC+IGW+public/private subnets+NAT+SG vs NACL+endpoints · TGW vs peering · Gateway vs Interface endpoint
✅ Secrets Manager vs Parameter Store · KMS envelope encryption
✅ ECS (Fargate/EC2) vs EKS · ECR via IAM · IRSA · Karpenter
✅ Lambda+API GW+DynamoDB flow · SQS vs SNS · EventBridge · Step Functions
✅ Blue/Green (CodeDeploy) vs Canary · rollback options
✅ CloudWatch/Logs Insights/X-Ray · SCPs vs Config · CloudTrail · Control Tower · RTO/RPO + DR patterns
✅ The IAM identity → STS → scoped perms → target pattern (#79)
✅ Azure↔AWS mapping (you know Azure)
```

**#1 to internalize:** the **IAM identity → STS short-lived credentials → scoped permissions → target (no long-lived stored keys)** pattern — it unlocks most AWS integration/auth questions, just as identity→Entra ID→RBAC did for Azure. Focus review on IAM (3-8), integration flows (#79), and CI/CD auth/secrets (29-30). Good luck! 🚀

---
