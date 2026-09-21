# 🎯 AWS Interview Prep — DevOps Engineer (Full Deep Version)

> **Companion to the Azure notes.** Same interview-focused format, AWS-native services.
> **Assumes:** you know DevOps fundamentals (and Azure) — every topic has a 💡 "If you know Azure" anchor.
> **Every section:** flow diagram · UI/CLI steps · real-world example · interview Q&A · 💡 Azure relate-note.
> **Tiers:** 🔴 Full · 🟠 Medium · 🟡 Know-this-much (UI steps + diagrams appear in ALL).

---

# 📋 TABLE OF CONTENTS

### 🌱 Foundations
1. [AWS Global Infrastructure & Account Structure](#1--aws-global-infrastructure--account-structure)
2. [AWS Organizations, Accounts, OUs & Control Tower](#2--aws-organizations-accounts-ous--control-tower)

### 🔐 Identity & Access
3. [IAM — Users, Groups, Roles, Policies](#3--iam--users-groups-roles-policies)
4. [IAM Policy Evaluation Logic](#4--iam-policy-evaluation-logic)
5. [IAM Roles for Services & Instance Profiles](#5--iam-roles-for-services--instance-profiles)
6. [STS, AssumeRole & Cross-Account Access](#6--sts-assumerole--cross-account-access)
7. [IAM Identity Center (SSO) & Federation](#7--iam-identity-center-sso--federation)
8. [OIDC Federation Basics](#8--oidc-federation-basics)

### 🌐 Networking
9. [Networking Fundamentals (IP, CIDR, ports)](#9--networking-fundamentals-ip-cidr-ports)
10. [VPC](#10--vpc-virtual-private-cloud)
11. [Subnets (public/private)](#11--subnets-public--private)
12. [Security Groups](#12--security-groups)
13. [Network ACLs (NACLs)](#13--network-acls-nacls)
14. [Route Tables & Internet Gateway](#14--route-tables--internet-gateway)
15. [NAT Gateway](#15--nat-gateway)
16. [VPC Endpoints (Gateway & Interface / PrivateLink)](#16--vpc-endpoints-gateway--interface--privatelink)
17. [VPC Peering](#17--vpc-peering)
18. [Transit Gateway](#18--transit-gateway)
19. [Route 53](#19--route-53)
20. [Elastic Load Balancing (ALB / NLB / GWLB)](#20--elastic-load-balancing-alb--nlb--gwlb)
21. [AWS WAF & Shield](#21--aws-waf--shield)
22. [AWS Network Firewall](#22--aws-network-firewall)
23. [VPC Flow Logs & Reachability Analyzer](#23--vpc-flow-logs--reachability-analyzer)
24. [Site-to-Site VPN & Direct Connect](#24--site-to-site-vpn--direct-connect)

### 🔑 Secrets & Config
25. [AWS KMS](#25--aws-kms-key-management-service)
26. [Secrets Manager vs Parameter Store](#26--secrets-manager-vs-parameter-store)
27. [Secrets Integration (services)](#27--secrets-integration-with-services)

### 🛠️ CI/CD — Tools, Integrations & Secrets
28. [AWS-Native CI/CD (CodeCommit/Build/Deploy/Pipeline)](#28--aws-native-cicd-codecommit--codebuild--codedeploy--codepipeline)
29. [CI/CD Tool → AWS Authentication (ADO/Jenkins/Bitbucket/GitHub)](#29--cicd-tool--aws-authentication-azure-devops--jenkins--bitbucket--github)
30. [CI/CD Secrets & Security Integration (ADO/Jenkins/Bitbucket/GitHub)](#30--cicd-secrets--security-integration-azure-devops--jenkins--bitbucket--github)
31. [CodeArtifact & ECR](#31--codeartifact--ecr)
32. [Git Branching Strategies](#32--git-branching-strategies)
33. [Multi-Account CI/CD & Deployment Promotion](#33--multi-account-cicd--deployment-promotion)

### 🏗️ Infrastructure as Code
34. [CloudFormation](#34--cloudformation)
35. [AWS CDK](#35--aws-cdk-cloud-development-kit)
36. [Terraform + AWS](#36--terraform--aws)
37. [Terraform State (S3 + DynamoDB Locking)](#37--terraform-state-s3--dynamodb-locking)
38. [IaC in CI/CD with Plan Gates](#38--iac-in-cicd-with-plan-gates)

### 🖥️ Compute
39. [EC2](#39--ec2)
40. [Auto Scaling Groups & Launch Templates](#40--auto-scaling-groups--launch-templates)
41. [Elastic Beanstalk](#41--elastic-beanstalk)
42. [AWS Batch](#42--aws-batch)

### 📦 Containers
43. [Dockerfile Best Practices & Multi-Stage Builds](#43--dockerfile-best-practices--multi-stage-builds)
44. [Amazon ECR](#44--amazon-ecr-elastic-container-registry)
45. [Amazon ECS (Fargate vs EC2)](#45--amazon-ecs-fargate-vs-ec2)
46. [Amazon EKS](#46--amazon-eks-elastic-kubernetes-service)
47. [ECS/EKS Ingress & Service Discovery](#47--ecseks-ingress--service-discovery)
48. [Helm & GitOps (Argo CD / Flux)](#48--helm--gitops-argo-cd--flux)
49. [Container Autoscaling (HPA / Cluster Autoscaler / Karpenter)](#49--container-autoscaling-hpa--cluster-autoscaler--karpenter)

### ⚡ Serverless
50. [AWS Lambda](#50--aws-lambda)
51. [API Gateway](#51--api-gateway)
52. [Amazon S3](#52--amazon-s3)
53. [Amazon SQS](#53--amazon-sqs)
54. [Amazon SNS](#54--amazon-sns)
55. [Amazon EventBridge](#55--amazon-eventbridge)
56. [AWS Step Functions](#56--aws-step-functions)
57. [Amazon Kinesis](#57--amazon-kinesis)
58. [Amazon DynamoDB](#58--amazon-dynamodb)
59. [AWS SAM & Serverless Framework](#59--aws-sam--serverless-framework)

### 💾 Storage & Databases
60. [EBS & EFS](#60--ebs--efs)
61. [Amazon RDS & Aurora](#61--amazon-rds--aurora)
62. [ElastiCache](#62--elasticache-redis--memcached)

### 🚀 Deployment & Observability
63. [Deployment — Blue/Green (CodeDeploy)](#63--deployment--bluegreen-codedeploy)
64. [Deployment — Canary, Rolling & Rollback](#64--deployment--canary-rolling--rollback)
65. [Feature Flags (AWS AppConfig)](#65--feature-flags-aws-appconfig)
66. [CloudWatch (Metrics, Logs, Alarms)](#66--cloudwatch-metrics-logs-alarms)
67. [CloudWatch Logs Insights](#67--cloudwatch-logs-insights)
68. [AWS X-Ray (Distributed Tracing)](#68--aws-x-ray-distributed-tracing)
69. [Alerting & Incident Response](#69--alerting--incident-response)
70. [SLI / SLO / SLA & Error Budgets](#70--sli--slo--sla--error-budgets)
71. [DevSecOps on AWS](#71--devsecops-on-aws)
72. [AI-Assisted DevOps (Amazon Q / Bedrock)](#72--ai-assisted-devops-amazon-q--bedrock)

### 🔥 Governance & Cross-Cutting
73. [AWS Config & Service Control Policies (SCPs)](#73--aws-config--service-control-policies-scps)
74. [CloudTrail](#74--cloudtrail)
75. [Tagging & Naming Conventions](#75--tagging--naming-conventions)
76. [AWS Landing Zone / Control Tower](#76--aws-landing-zone--control-tower)
77. [Cost Management & FinOps](#77--cost-management--finops)
78. [Backup & Disaster Recovery (RTO/RPO)](#78--backup--disaster-recovery-rtorpo)

### 🎓 Interview Prep
79. [All Integration Flows Consolidated](#79--all-integration-flows-consolidated)
80. [Rapid-Fire Interview Q&A](#80--rapid-fire-interview-qa)
81. [Final Quick Reference (Azure↔AWS table, numbers, one-liners)](#81--final-quick-reference-azureaws-table-numbers-one-liners)

---
---

# 1. 🌍 AWS Global Infrastructure & Account Structure
> 🟠 MEDIUM

---

## 1.1 What Problem Does This Solve?

Before deploying anything, you need to understand *where* AWS resources physically live and how AWS is organized geographically — this drives decisions about latency, resilience, compliance, and cost.

> 💡 **If you know Azure:** AWS Regions ≈ Azure Regions, Availability Zones ≈ Azure Availability Zones, Edge Locations ≈ Azure Edge/PoP locations. The concepts map almost 1:1. The main structural difference is at the account level (next section): AWS separates workloads using multiple **Accounts**, where Azure uses multiple **Subscriptions** under one tenant.

---

## 1.2 The Hierarchy (Flow Diagram)

```
AWS Global Infrastructure:

REGION (geographic area, e.g., ap-south-1 Mumbai, us-east-1 N. Virginia)
   └── AVAILABILITY ZONE (AZ) — 1+ physically separate data centers
       │   each with independent power/cooling/networking
       │   (a Region has 3+ AZs; deploy across AZs for resilience)
       └── (data centers)

EDGE LOCATIONS — hundreds worldwide, for CloudFront CDN, Route 53,
                 Global Accelerator (content cached close to users)

Deploy across multiple AZs → survive a data-center failure.
Deploy across multiple Regions → survive a whole-region failure + low latency globally.
```

| Level | What It Is | Choose Based On |
|---|---|---|
| **Region** | Geographic area of data centers (e.g., `ap-south-1`) | Latency to users, compliance/data residency, cost, service availability |
| **Availability Zone (AZ)** | One+ isolated data centers within a Region | Deploy across ≥2-3 AZs for high availability |
| **Edge Location** | CDN/DNS points of presence (100s worldwide) | Automatic via CloudFront/Route 53/Global Accelerator |

---

## 1.3 Key Facts to Remember

```
✅ A Region is isolated & independent (data doesn't leave a region unless YOU move it)
✅ Region names: ap-south-1 (Mumbai), us-east-1 (N. Virginia — the "default"/oldest),
   eu-west-1 (Ireland), etc.
✅ Each Region has 3+ AZs; AZ names look like ap-south-1a, ap-south-1b, ap-south-1c
✅ Some services are GLOBAL (IAM, Route 53, CloudFront, WAF for CloudFront) —
   not tied to one region
✅ Most services are REGIONAL (EC2, VPC, S3 buckets belong to a region)
✅ us-east-1 is special — some global service operations must happen there
   (e.g., ACM certs for CloudFront, some billing/global console operations)
✅ Deploy across AZs for HA; across Regions for DR + global low latency
```

---

## 1.4 UI Steps — Exploring Regions & AZs

```
📍 Console: top-right Region selector → switch regions (each region has
   its own set of resources)
📍 EC2 Console → when launching, you pick a subnet which maps to an AZ
📍 CLI:
   aws ec2 describe-regions --output table          # list all regions
   aws ec2 describe-availability-zones --region ap-south-1 --output table
```

---

## 1.5 Real-World Example

```
A global e-commerce platform:

• Primary Region: ap-south-1 (Mumbai) — closest to most customers (India)
• Deploy across AZs ap-south-1a/1b/1c → survive a data-center outage
• DR Region: ap-southeast-1 (Singapore) — replicate data for regional DR
• CloudFront Edge Locations → cache static content close to users worldwide
• Route 53 latency-based routing → send each user to the nearest region

Result: low latency, AZ-level resilience, region-level DR, and global
content delivery.
```

---

## 1.6 Interview Q&A

**Q: What's the difference between a Region and an Availability Zone?**
> A Region is a geographic area containing multiple isolated data centers; an Availability Zone is one or more physically separate data centers within a Region (with independent power/cooling/networking). You deploy across multiple AZs to survive a data-center failure, and across multiple Regions for disaster recovery and global low latency.

**Q: Are all AWS services regional?**
> No — most are regional (EC2, VPC, S3 buckets belong to a region), but some are global (IAM, Route 53, CloudFront). A few global operations must be done in us-east-1 specifically, like ACM certificates for CloudFront.

**Q: How do you achieve high availability vs disaster recovery?**
> High availability = deploy across multiple AZs within a region (survive a data-center failure). Disaster recovery = replicate to another region (survive a whole-region failure). They're different scopes.

---

## 1.7 Summary

AWS organizes infrastructure into Regions (geographic areas), Availability Zones (isolated data centers within a region — deploy across 2-3 for HA), and Edge Locations (CDN/DNS points of presence worldwide). Most services are regional; a few (IAM, Route 53, CloudFront) are global, with some operations pinned to us-east-1. Deploy across AZs for high availability and across regions for disaster recovery and global low latency — directly equivalent to Azure's Regions/AZs/Edge model.

---
---

# 2. 🏢 AWS Organizations, Accounts, OUs & Control Tower
> 🟠 MEDIUM

---

## 2.1 What Problem Does This Solve?

A real organization needs to separate workloads (prod vs dev, per-team, per-project) for security, billing, and blast-radius isolation. In AWS, the primary isolation boundary is the **Account** — and **AWS Organizations** lets you manage many accounts centrally with shared governance.

> 💡 **If you know Azure:** This is the AWS equivalent of the Azure hierarchy (Management Groups → Subscriptions → Resource Groups). Key mapping: AWS **Account** ≈ Azure **Subscription** (the main isolation/billing boundary — but AWS accounts are a *harder* boundary than Azure subscriptions), AWS **Organizational Unit (OU)** ≈ Azure **Management Group**, AWS **Organization** ≈ the overall Azure tenant/root management group. **AWS has no direct "Resource Group" equivalent** — it uses tags + optional Resource Groups (a lighter tagging construct) instead.

---

## 2.2 The Hierarchy (Flow Diagram)

```
AWS ORGANIZATION (the whole company, with a Management/Payer account)
   │
   ├── Organizational Unit (OU): "Production"
   │     ├── Account: "prod-app-1"      ← the main isolation boundary
   │     └── Account: "prod-app-2"
   │
   ├── OU: "Non-Production"
   │     ├── Account: "dev"
   │     └── Account: "staging"
   │
   └── OU: "Security"
         └── Account: "log-archive" / "audit"

Governance applied at the OU level (Service Control Policies) cascades
DOWN to all accounts underneath — like Azure Policy at a Management Group.
```

| Level | What It Is | Azure Equivalent |
|---|---|---|
| **Organization** | The top-level container (with a management/payer account) | Tenant / Root Management Group |
| **Organizational Unit (OU)** | Groups accounts for shared governance | Management Group |
| **Account** | The primary isolation + billing boundary | Subscription |
| **(Tags / Resource Groups)** | Organize resources *within* an account | Resource Group (looser in AWS) |

---

## 2.3 Key Concepts

**Multi-account strategy (best practice):** Real orgs use *many* accounts — separate accounts for prod/dev/staging, per-team, plus dedicated **security/log-archive/audit** accounts. Why? Accounts are a hard security & blast-radius boundary — a compromise or runaway cost in one account is contained.

**Service Control Policies (SCPs):** Guardrails applied at the Organization/OU level that set the *maximum* permissions any account underneath can have — e.g., "deny creating resources outside ap-south-1," "deny disabling CloudTrail." (Covered in Section 73.) *(≈ Azure Policy deny effect at a Management Group.)*

**Consolidated Billing:** All accounts roll up to one management/payer account — one bill, plus volume discounts across accounts.

**AWS Control Tower:** An automated service that sets up a well-architected, multi-account **Landing Zone** with best-practice OUs, SCPs, logging, and guardrails pre-configured. (Covered in Section 76.) *(≈ Azure Landing Zone / the Landing Zone accelerator.)*

---

## 2.4 UI Steps — Exploring Organizations

```
📍 Console → "AWS Organizations" → see the OU/account tree
📍 Create an OU: Organizations → Root → "Actions → Create new" (OU)
📍 Create/invite an account: Organizations → "Add an AWS account"
📍 Apply an SCP: Organizations → "Policies" → Service control policies →
   create → attach to an OU/account
📍 CLI: aws organizations list-accounts --output table
```

---

## 2.5 Real-World Example

```
A company structures AWS for a new product with strict governance:

Organization
├── OU "Security"
│     ├── log-archive account (centralized CloudTrail/Config logs)
│     └── audit account (read-only security tooling)
├── OU "Production"
│     └── prod account (the live workload)
└── OU "Non-Production"
      ├── dev account
      └── staging account

SCPs at the OU level: "deny leaving ap-south-1 region," "deny disabling
CloudTrail/GuardDuty" — guardrails no account can violate.

Consolidated billing: one bill for finance, volume discounts shared.
Control Tower set the whole thing up with best-practice guardrails.

Result: hard isolation between environments (a dev mistake can't touch
prod), centralized security/logging, and org-wide governance.
```

---

## 2.6 Interview Q&A

**Q: How do you structure a multi-account AWS environment and why?**
> Using AWS Organizations with OUs grouping accounts (Production, Non-Production, Security), where each Account is the primary isolation and billing boundary. Multi-account is best practice because accounts are a hard security and blast-radius boundary — a compromise, misconfiguration, or runaway cost in one account is contained. Dedicated security/log-archive/audit accounts centralize governance.

**Q: What are Service Control Policies?**
> Organization-level guardrails attached to OUs/accounts that define the *maximum* permissions any account underneath can have — e.g., denying resource creation outside approved regions or preventing CloudTrail from being disabled. They set boundaries even an account admin can't exceed. (Similar to Azure Policy deny effects at a Management Group.)

**Q: What is AWS Control Tower?**
> An automated service that provisions a well-architected multi-account landing zone with best-practice OUs, SCPs, centralized logging, and guardrails pre-configured — so you don't set up the governance foundation manually. It's the equivalent of an Azure Landing Zone.

**Q: How does the AWS account model compare to Azure?**
> AWS Account ≈ Azure Subscription (main isolation/billing boundary), AWS OU ≈ Azure Management Group, AWS Organization ≈ the Azure tenant. A key difference: AWS accounts are a *harder* boundary than Azure subscriptions, and AWS has no strong "Resource Group" equivalent — it relies on tags instead.

---

## 2.7 Summary

AWS Organizations manages many Accounts (the primary isolation + billing boundary) grouped into OUs for shared governance, with Service Control Policies as org-wide guardrails and consolidated billing rolling everything to one payer. Best practice is a multi-account strategy (separate prod/dev/staging + dedicated security/log-archive accounts) because accounts are a hard blast-radius boundary. AWS Control Tower automates setting this up as a governed landing zone. Maps to Azure as: Account≈Subscription, OU≈Management Group, Organization≈Tenant — but AWS accounts isolate more strongly and there's no true Resource Group equivalent.

---
---

# 3. 🔐 IAM — Users, Groups, Roles, Policies
> 🔴 FULL

---

## 3.1 What Problem Does This Solve?

Everything in AWS requires answering "who can do what to which resource?" **IAM (Identity and Access Management)** is the service that controls all authentication and authorization in AWS. It's the single most important — and most heavily interviewed — AWS topic, so this and the next few sections go deep.

> 💡 **If you know Azure:** IAM combines what Azure splits between **Entra ID** (identities) and **Azure RBAC** (permissions) into one service. Key difference: Azure uses pre-defined *roles* assigned at a *scope*; AWS uses **JSON policy documents** attached to identities/resources, and its permission model (evaluation logic, next section) is more explicit and more heavily tested. AWS **IAM Roles** ≈ Azure **Managed Identities / Service Principals** conceptually.

---

## 3.2 The Four Core IAM Entities (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  USERS    → identities for PEOPLE (or legacy app keys)     │
│             — has long-term credentials (password/access keys)│
│                                                            │
│  GROUPS   → collections of Users; attach policies once,    │
│             all members inherit (manage access at scale)   │
│                                                            │
│  ROLES    → identities with NO long-term credentials;      │
│             ASSUMED temporarily by users/services/apps →   │
│             get short-lived credentials. THE preferred way. │
│                                                            │
│  POLICIES → JSON documents defining permissions (Allow/    │
│             Deny on Actions/Resources), attached to the     │
│             above (or to resources directly)                │
└──────────────────────────────────────────────────────────┘
```

---

## 3.3 IAM Policies — The JSON Document

Permissions in AWS are defined in **JSON policy documents**:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",                          // Allow or Deny
      "Action": ["s3:GetObject", "s3:PutObject"], // what actions
      "Resource": "arn:aws:s3:::my-bucket/*",     // on which resources
      "Condition": {                              // optional conditions
        "IpAddress": { "aws:SourceIp": "203.0.113.0/24" }
      }
    }
  ]
}
```

| Policy Type | What It Is |
|---|---|
| **Managed policies (AWS)** | Pre-built by AWS (e.g., `AmazonS3ReadOnlyAccess`) |
| **Managed policies (Customer)** | Reusable policies you create |
| **Inline policies** | Embedded directly in one user/group/role (not reusable) |
| **Resource-based policies** | Attached to a *resource* (e.g., an S3 bucket policy) specifying who can access it |

---

## 3.4 Users vs Roles — The Critical Distinction

```
USER (avoid for apps/automation):
   • Has long-term credentials (access keys) that don't expire
   • Risk: keys can leak, must be rotated manually
   • Use for: human console/CLI access (ideally via SSO instead)

ROLE (prefer everywhere):
   • NO long-term credentials — assumed temporarily
   • Provides SHORT-LIVED credentials that auto-expire
   • Use for: EC2/Lambda/ECS accessing AWS, cross-account access,
     federated/CI-CD access, humans via SSO

⭐ Best practice: use ROLES, not long-lived user access keys, for
   anything programmatic. (This mirrors "prefer Managed Identity over
   a Service Principal secret" in Azure.)
```

---

## 3.5 Key IAM Best Practices

```
✅ Least privilege — grant only the specific actions/resources needed
✅ Use Roles (short-lived creds), not long-lived access keys, for apps/automation
✅ Use Groups to assign permissions to people (not per-user policies)
✅ Enable MFA on all human users, especially privileged ones
✅ NEVER use the root account for daily work — lock it down, MFA it, use it
   only for the few root-only tasks
✅ Rotate any access keys that must exist; prefer IAM Identity Center (SSO)
✅ Use permission boundaries + SCPs (Sections 4, 73) as guardrails
```

---

## 3.6 UI Steps — Creating a Group, User, and Role

```
📍 Console → "IAM"

── Group ──
Groups → Create group → attach policies (e.g., AmazonEC2ReadOnlyAccess) → name it

── User ──
Users → Create user → add to a group → (avoid access keys unless truly needed)

── Role (the important one) ──
Roles → Create role → choose trusted entity:
   • AWS service (e.g., EC2/Lambda) → for that service to assume
   • Another AWS account → cross-account
   • Web identity (OIDC) → for federated CI/CD
→ attach permission policies → name it

📍 CLI: aws iam create-role / attach-role-policy / create-group / add-user-to-group
```

---

## 3.7 Real-World Example

```
Setting up access for teams + an app, least-privilege:

Groups (for people):
   "Developers"  → dev-environment policies only
   "DevOps"      → broader infra policies
   "ReadOnly"    → view-only for auditors

Roles (for services/automation — no stored keys):
   "ec2-app-role"     → EC2 instances assume it → access S3 + DynamoDB
   "lambda-exec-role" → Lambda assumes it → write to DynamoDB + CloudWatch
   "ci-deploy-role"   → CI/CD assumes it (via OIDC) → deploy to ECS

Root account: MFA'd, credentials vaulted, used only for root-only tasks.
Humans ideally sign in via IAM Identity Center (SSO), not IAM users.

Result: people get scoped access via groups, services use roles (no
stored credentials), and the blast radius of any compromise is limited.
```

---

## 3.8 Interview Q&A

**Q: What are the four core IAM entities?**
> Users (identities for people, with long-term credentials), Groups (collections of users that inherit attached policies), Roles (identities with no long-term credentials, assumed temporarily for short-lived credentials), and Policies (JSON documents defining permissions via Allow/Deny on Actions/Resources, attached to identities or resources).

**Q: When should you use an IAM Role instead of an IAM User?**
> Use a Role for anything programmatic — EC2/Lambda/ECS accessing AWS, cross-account access, and CI/CD — because roles provide short-lived, auto-expiring credentials with nothing stored. Users have long-term access keys that can leak and require manual rotation. This mirrors preferring a Managed Identity over a stored Service Principal secret in Azure.

**Q: What's the difference between an identity-based and a resource-based policy?**
> Identity-based policies attach to a user/group/role and say what *that identity* can do. Resource-based policies attach to a *resource* (like an S3 bucket policy) and say *who* can access that resource — useful for cross-account access without the other account assuming a role.

**Q: How does IAM compare to Azure's model?**
> IAM combines Azure's Entra ID (identities) and RBAC (permissions) in one service, but uses JSON policy documents attached to identities/resources rather than pre-defined roles assigned at a scope. IAM Roles are conceptually like Azure Managed Identities/Service Principals.

---

## 3.9 Summary

IAM controls all AWS authentication and authorization via four entities: Users (people, long-term creds), Groups (assign permissions at scale), Roles (assumed temporarily for short-lived creds — the preferred choice for all automation/services), and Policies (JSON Allow/Deny documents, identity-based or resource-based). Follow least privilege, use Roles not long-lived keys, use Groups for people, MFA everywhere, and never use the root account for daily work. IAM merges what Azure splits into Entra ID + RBAC, using JSON policies instead of scoped role assignments.

---
---

# 4. ⚖️ IAM Policy Evaluation Logic
> 🔴 FULL

---

## 4.1 What Problem Does This Solve?

When multiple policies apply to a request (identity policies, resource policies, SCPs, permission boundaries), how does AWS decide whether to *allow* or *deny* it? This **evaluation logic** is one of the most heavily tested AWS interview topics because it's subtle — and getting it wrong causes real "why can't I access this?" (or worse, "why *can* they access this?") incidents.

> 💡 **If you know Azure:** Azure RBAC is simpler — it's allow-only, and a deny requires an explicit "Deny assignment" (rare). AWS is more nuanced: it evaluates *multiple* policy types together with an **explicit-deny-always-wins** rule. There's no direct Azure equivalent to this depth of evaluation logic — it's a distinctly AWS interview area.

---

## 4.2 The Golden Rules (Flow Diagram)

```
A request is made. AWS evaluates ALL applicable policies:

   1. Is there an EXPLICIT DENY anywhere?  → ❌ DENIED (deny always wins,
                                              overrides any allow)
   2. Otherwise, is there an EXPLICIT ALLOW? → ✅ ALLOWED
   3. Otherwise (no allow at all)           → ❌ DENIED (implicit deny —
                                              default is deny)

Simple summary:
   • Default = DENY (you must be explicitly allowed)
   • Explicit ALLOW grants access
   • Explicit DENY overrides everything (always wins)
```

**Memorize this:** *"Default deny; an explicit allow grants; an explicit deny always overrides."*

---

## 4.3 The Policy Types That All Get Evaluated Together

```
For a request to be allowed, it must pass ALL of these (any explicit
deny in any of them blocks it):

┌──────────────────────────────────────────────────────────┐
│ 1. Identity-based policies (on the user/group/role)         │
│ 2. Resource-based policies (e.g., S3 bucket policy)         │
│ 3. Permission Boundaries (max permissions an identity CAN   │
│    have — a ceiling, doesn't grant, only limits)            │
│ 4. Service Control Policies / SCPs (org-level guardrails —  │
│    a ceiling across the whole account)                      │
│ 5. Session policies (passed when assuming a role)           │
└──────────────────────────────────────────────────────────┘

Effective permissions = the INTERSECTION of what's allowed by identity
policies AND permitted by boundaries AND permitted by SCPs — minus any
explicit deny anywhere.
```

---

## 4.4 Permission Boundaries vs SCPs (Commonly Confused)

```
PERMISSION BOUNDARY:
   • Attached to an IAM user/role
   • Sets the MAXIMUM permissions that identity can have
   • Does NOT grant anything by itself — it's a ceiling
   • Use: let teams create their own roles, but bounded (they can't
     exceed the boundary)

SERVICE CONTROL POLICY (SCP):
   • Attached at the Organization/OU/account level
   • Sets the MAXIMUM permissions for the WHOLE account
   • Does NOT grant anything — a ceiling across everything in the account
   • Use: org-wide guardrails ("no account can leave ap-south-1")

Both are CEILINGS (limit), not GRANTS. You still need an identity policy
to actually allow the action.
```

---

## 4.5 Worked Example (Flow Diagram)

```
Request: user tries to delete an S3 object.

Check SCP:            does the org allow s3:DeleteObject? → yes (ceiling ok)
Check permission boundary: does the boundary allow it?  → yes (ceiling ok)
Check identity policy: is there an explicit Allow for s3:DeleteObject? → yes
Check for explicit Deny anywhere:                        → NONE
   → ✅ ALLOWED

Now change one thing: add an explicit Deny on s3:DeleteObject in ANY
policy (identity, resource, SCP, or boundary):
   → ❌ DENIED (explicit deny always wins, regardless of the allows)
```

---

## 4.6 CLI/Tool Steps — Testing Policy Evaluation

```
📍 IAM Policy Simulator (test before deploying):
   Console → IAM → "Policy simulator" → pick a user/role → choose actions/
   resources → simulate → see Allowed/Denied and WHICH policy decided

📍 CLI dry-run / access analyzer:
   aws iam simulate-principal-policy --policy-source-arn <arn> \
     --action-names s3:DeleteObject --resource-arns arn:aws:s3:::bucket/*

📍 IAM Access Analyzer → flags overly-permissive or unintended access
```

---

## 4.7 Real-World Example

```
A platform team lets developers create their own IAM roles for their
apps — but must ensure they can't grant themselves admin or leave the region:

Step 1: Attach a PERMISSION BOUNDARY to the developer role that caps what
        any role they create can do (e.g., no IAM admin, no billing).
Step 2: An SCP at the OU level denies actions outside ap-south-1 and
        denies disabling CloudTrail — an org-wide ceiling.
Step 3: Developers create roles with identity policies granting app
        permissions — but those roles can never exceed the boundary or SCP.

Scenario check: a developer's role has an identity policy allowing
"iam:*", but the permission boundary doesn't include IAM admin →
effective permission = DENIED for IAM admin (intersection of allows +
ceilings). And if any explicit deny existed, it would win outright.

Result: self-service role creation with hard guardrails — impossible to
escalate beyond the boundary/SCP.
```

---

## 4.8 Interview Q&A

**Q: Walk me through IAM policy evaluation logic.**
> AWS defaults to deny. It evaluates all applicable policies together — identity-based, resource-based, permission boundaries, SCPs, and session policies. If there's an explicit Deny anywhere, the request is denied (deny always wins). Otherwise, if there's an explicit Allow, it's allowed. Otherwise (no allow), it's implicitly denied. Effective permissions are the intersection of what identity policies allow AND what boundaries/SCPs permit, minus any explicit deny.

**Q: What's the difference between a Permission Boundary and an SCP?**
> Both are ceilings that limit maximum permissions and grant nothing by themselves. A Permission Boundary attaches to an individual IAM user/role (capping that identity — useful for bounded self-service role creation). An SCP attaches at the Organization/OU/account level (capping the whole account — org-wide guardrails). You still need an identity policy to actually grant an action.

**Q: If an identity policy allows an action but an SCP denies it, what happens?**
> Denied. An explicit deny anywhere (including an SCP) always wins over any allow. And even without an explicit deny, if the SCP doesn't permit the action, it's outside the account's ceiling and effectively denied.

**Q: How do you test whether a policy grants the intended access?**
> Use the IAM Policy Simulator (or `simulate-principal-policy`) to test actions/resources against an identity before deploying, and IAM Access Analyzer to flag overly-permissive or unintended access.

---

## 4.9 Summary

IAM evaluation is: **default deny → explicit allow grants → explicit deny always overrides.** All policy types are evaluated together (identity, resource, permission boundaries, SCPs, session), and effective permissions are the intersection of allows and ceilings, minus any explicit deny. Permission Boundaries (per-identity ceiling) and SCPs (per-account/org ceiling) both *limit* rather than grant. This nuanced multi-policy logic is a distinctly AWS interview area with no direct Azure equivalent — memorize the golden rules and the boundary-vs-SCP distinction.

---
---

# 5. 🖥️ IAM Roles for Services & Instance Profiles
> 🔴 FULL

---

## 5.1 What Problem Does This Solve?

Your EC2 instance, Lambda function, or ECS task needs to access other AWS services (S3, DynamoDB, Secrets Manager) — but you must NOT hardcode access keys on them (leak risk). **IAM Roles for services** solve this: the compute resource *assumes a role* and gets short-lived, auto-rotating credentials with zero stored secrets.

> 💡 **If you know Azure:** This is the direct equivalent of **Managed Identities** in Azure — a compute resource gets an identity automatically with no stored credentials. AWS's "IAM role attached to EC2 via an instance profile" ≈ Azure's "System-assigned Managed Identity on a VM." Same best practice, same purpose.

---

## 5.2 How It Works (Flow Diagram)

```
❌ WITHOUT a role (bad): access keys hardcoded on the EC2 instance →
   can leak, must rotate manually

✅ WITH a service role:
   EC2 instance has an IAM Role attached (via an "Instance Profile")
        ↓
   The instance queries the Instance Metadata Service (IMDS) at
   169.254.169.254 → gets SHORT-LIVED credentials for the role
        ↓
   Uses them to access S3/DynamoDB/etc. (limited by the role's policies)
        ↓
   Credentials AUTO-ROTATE and expire — nothing stored on the instance

The AWS SDK/CLI automatically finds and uses these credentials — your
app code needs no keys at all.
```

---

## 5.3 Instance Profile — The EC2-Specific Detail

```
For EC2, a role is attached via an "INSTANCE PROFILE" (a container for
the role). Usually the console creates the instance profile automatically
when you attach a role to an instance — but it's why you sometimes see
"instance profile" in CLI/CloudFormation.

For Lambda/ECS, there's no instance profile concept — you just assign
the role directly (Lambda "execution role", ECS "task role").
```

| Service | How the role is assigned |
|---|---|
| **EC2** | IAM Role via an **Instance Profile** |
| **Lambda** | **Execution Role** (assigned directly) |
| **ECS** | **Task Role** (for the app) + **Task Execution Role** (for pulling images/logs) |
| **EKS pods** | **IRSA** (IAM Roles for Service Accounts) or **EKS Pod Identity** |

---

## 5.4 The Trust Policy vs Permission Policy (Key Concept)

```
Every service role has TWO parts:

1. TRUST POLICY (who can assume it):
   e.g., "the EC2 service (ec2.amazonaws.com) can assume this role"
   or "the Lambda service can assume this role"

2. PERMISSION POLICY (what it can do once assumed):
   e.g., "s3:GetObject on my-bucket, dynamodb:PutItem on my-table"

The trust policy is what makes it a "service role" — it trusts an AWS
service to assume it.
```

---

## 5.5 UI Steps — Attaching a Role to EC2

```
📍 Console → IAM → Roles → Create role
   → Trusted entity: "AWS service" → EC2
   → attach permission policies (e.g., AmazonS3ReadOnlyAccess)
   → name it "ec2-app-role"
    ↓
📍 Attach to an instance:
   EC2 Console → select instance → Actions → Security →
   "Modify IAM role" → choose "ec2-app-role" → Update
   (AWS creates the instance profile automatically)
    ↓
📍 Verify from inside the instance:
   curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
   → shows the role name + you can fetch its temporary credentials
   (only accessible from inside the instance)
```

---

## 5.6 Real-World Example

```
A web app on EC2 needs to read from S3, write to DynamoDB, and fetch a
DB password from Secrets Manager — with NO hardcoded keys:

Step 1: Create "ec2-app-role" with:
   • Trust policy: EC2 service can assume it
   • Permission policy: s3:GetObject (app bucket), dynamodb:PutItem
     (app table), secretsmanager:GetSecretValue (the DB secret)
Step 2: Attach the role to the EC2 instances (via instance profile).
Step 3: The app's AWS SDK automatically picks up short-lived credentials
   from IMDS — no keys in code, config, or environment variables.
Step 4: Credentials auto-rotate; if the instance is compromised, the
   attacker only gets whatever this narrowly-scoped role allows (and only
   short-lived creds).

For the same app on Lambda instead: assign a Lambda execution role with
the same permissions. On ECS: a task role. On EKS: IRSA.

Result: zero stored credentials, auto-rotating short-lived creds,
least-privilege — the AWS equivalent of using a Managed Identity in Azure.
```

---

## 5.7 Interview Q&A

**Q: How does an EC2 instance access S3 without hardcoded credentials?**
> By attaching an IAM Role to the instance (via an instance profile). The instance retrieves short-lived, auto-rotating credentials for that role from the Instance Metadata Service (169.254.169.254), and the AWS SDK/CLI uses them automatically — so no access keys are stored anywhere. This is the direct equivalent of using a Managed Identity in Azure.

**Q: What's an instance profile?**
> A container for an IAM role that's used to attach the role to an EC2 instance. It's usually created automatically when you attach a role to an instance in the console, but appears explicitly in CLI/IaC. Lambda and ECS don't use instance profiles — they assign roles directly (execution role / task role).

**Q: What are the two parts of a service role?**
> The trust policy (which service/principal is allowed to assume the role, e.g., the EC2 or Lambda service) and the permission policy (what the role can do once assumed). The trust policy is what makes it a service role.

**Q: How do EKS pods get AWS permissions?**
> Via IRSA (IAM Roles for Service Accounts) or the newer EKS Pod Identity — associating an IAM role with a Kubernetes service account so pods get short-lived credentials, without node-wide or hardcoded keys. (Conceptually like AKS Workload Identity in Azure.)

---

## 5.8 Summary

IAM Roles for services let EC2, Lambda, ECS, and EKS access AWS with short-lived, auto-rotating credentials and zero stored keys — the AWS equivalent of Azure Managed Identities. EC2 attaches a role via an instance profile and retrieves creds from IMDS (169.254.169.254); Lambda uses an execution role, ECS a task role, and EKS uses IRSA/Pod Identity. Every service role has a trust policy (who can assume it) and a permission policy (what it can do). This is the foundational best practice: never hardcode keys on compute — always use a role.

---
---

# 6. 🔄 STS, AssumeRole & Cross-Account Access
> 🔴 FULL

---

## 6.1 What Problem Does This Solve?

How does a role actually get temporary credentials? How does an identity in one AWS account access resources in *another* account? The answer to both is **STS (Security Token Service)** and the **AssumeRole** operation — the mechanism behind nearly all secure, temporary, cross-boundary access in AWS. This is heavily tested.

> 💡 **If you know Azure:** There's no single clean Azure equivalent — cross-subscription access in Azure is done via RBAC role assignments across subscriptions (they share one Entra ID tenant), whereas AWS accounts are separate trust boundaries requiring explicit role assumption. AWS's AssumeRole model is more explicit. `sts:AssumeRoleWithWebIdentity` (the OIDC path) ≈ Azure's Workload Identity Federation mechanism.

---

## 6.2 What STS Does (Flow Diagram)

```
STS (Security Token Service) = the service that issues TEMPORARY,
short-lived credentials.

   Identity (user/service/federated) calls an STS operation:
      • sts:AssumeRole              → assume a role (same or cross-account)
      • sts:AssumeRoleWithWebIdentity → assume via an OIDC token (CI/CD)
      • sts:GetSessionToken          → temporary creds (e.g., for MFA)
        ↓
   STS returns TEMPORARY credentials:
      Access Key + Secret Key + Session Token  (valid ~15 min to 12 hours)
        ↓
   Use them to act as the assumed role (limited by its policies), then
   they EXPIRE automatically.

Almost everything secure in AWS ends up calling AssumeRole under the hood.
```

---

## 6.3 Cross-Account Access via AssumeRole (Flow Diagram)

The classic pattern — an identity in Account A accessing resources in Account B:

```
ACCOUNT A (source)                          ACCOUNT B (target)
   User/Role "dev-role"                        Role "cross-account-role"
        │                                          │
        │  1. Account B's role TRUST POLICY says:  │
        │     "Account A is allowed to assume me"  │
        │                                          │
        │  2. Account A's identity has permission  │
        │     to call sts:AssumeRole on B's role   │
        │                                          │
        └──── sts:AssumeRole (B's role ARN) ──────►│
              ◄──── temporary credentials ─────────┘
        │
        └── uses those temp creds to act in Account B
            (limited by B's role permission policy)

Two-sided trust: B must TRUST A (trust policy) AND A must be PERMITTED
to assume (identity policy). Both required.
```

---

## 6.4 The Two-Sided Trust (Critical Concept)

```
Cross-account (and role assumption generally) needs BOTH sides:

1. TARGET role's TRUST POLICY: "I trust <this principal/account> to
   assume me" (in Account B)

2. SOURCE identity's PERMISSION POLICY: "I'm allowed to call
   sts:AssumeRole on <that role ARN>" (in Account A)

If either is missing → assumption fails. This two-sided trust is the
#1 thing interviewers probe about cross-account access.
```

---

## 6.5 Common AssumeRole Use Cases

| Use Case | How |
|---|---|
| **Service accessing AWS** | EC2/Lambda assumes its service role (Section 5) — STS under the hood |
| **Cross-account access** | Identity in Account A assumes a role in Account B |
| **CI/CD → AWS** | Pipeline assumes a deploy role (via OIDC — `AssumeRoleWithWebIdentity`) |
| **Federated/SSO access** | Users from an IdP assume roles (temporary console/CLI access) |
| **Privilege escalation (controlled)** | A user assumes a higher-privilege role temporarily (like Azure PIM) |

---

## 6.6 CLI Steps — Assuming a Role

```
📍 Assume a role and get temp credentials:
   aws sts assume-role \
     --role-arn arn:aws:iam::222222222222:role/cross-account-role \
     --role-session-name my-session
   → returns AccessKeyId, SecretAccessKey, SessionToken (temporary)

📍 Or configure a named profile in ~/.aws/config that auto-assumes:
   [profile cross-account]
   role_arn = arn:aws:iam::222222222222:role/cross-account-role
   source_profile = default
   → then: aws s3 ls --profile cross-account (auto-assumes the role)

📍 Check who you currently are:
   aws sts get-caller-identity
```

---

## 6.7 Real-World Example

```
A central CI/CD account deploys to separate prod and dev accounts
(a common multi-account setup):

Setup:
• "cicd" account has a pipeline identity.
• "prod" account has a "deploy-role" whose TRUST POLICY allows the cicd
  account to assume it; its PERMISSION POLICY scopes it to deploying the
  app (least privilege).
• "dev" account has a similar "deploy-role."

Deployment flow:
1. The pipeline (in cicd account) calls sts:AssumeRole on prod's
   deploy-role → gets short-lived credentials for prod.
2. It deploys to prod using those temp creds (scoped to only what's needed).
3. The creds expire automatically after the session.
4. Same pattern for the dev account with its own deploy-role.

Security wins: the cicd account holds no standing permissions in prod/dev
— it must explicitly assume a scoped, trusted role each time, with
short-lived creds. A compromise of cicd doesn't automatically grant prod
access (the trust + scoping limit it).
```

---

## 6.8 Interview Q&A

**Q: What is STS and what does AssumeRole do?**
> STS (Security Token Service) issues temporary, short-lived credentials. AssumeRole is the operation an identity calls to assume an IAM role — receiving temporary credentials (access key + secret + session token) scoped to that role's permissions, which expire automatically. Nearly all secure temporary and cross-boundary access in AWS goes through STS.

**Q: How does cross-account access work?**
> Via role assumption with a two-sided trust: the target account's role must have a trust policy allowing the source account/principal to assume it, AND the source identity must have permission to call sts:AssumeRole on that role's ARN. The source then gets short-lived credentials to act in the target account, scoped by the target role's permission policy. Both sides of the trust are required.

**Q: What's the difference between AssumeRole and AssumeRoleWithWebIdentity?**
> AssumeRole is used when a base AWS identity assumes a role. AssumeRoleWithWebIdentity is used when a federated identity (from an OIDC provider like GitHub Actions or Bitbucket) assumes a role by presenting a web identity token — the secretless CI/CD path. Both return temporary STS credentials.

**Q: How does this compare to cross-subscription access in Azure?**
> Azure subscriptions share one Entra ID tenant, so cross-subscription access is just RBAC role assignments — no explicit "assume" step. AWS accounts are separate trust boundaries, so cross-account access requires explicit role assumption with a two-sided trust. AWS's model is more explicit.

---

## 6.9 Summary

STS issues temporary, short-lived credentials, and AssumeRole is how identities assume IAM roles to get them — the mechanism behind service roles, cross-account access, CI/CD federation, and SSO. Cross-account access requires a two-sided trust: the target role trusts the source (trust policy) AND the source is permitted to assume it (identity policy). The OIDC variant, AssumeRoleWithWebIdentity, powers secretless CI/CD (mirroring Azure Workload Identity Federation). This explicit assume-role model — with short-lived, scoped credentials — is central to secure AWS architecture and a top interview topic.

---
---

# 7. 🔑 IAM Identity Center (SSO) & Federation
> 🟠 MEDIUM

---

## 7.1 What Problem Does This Solve?

Creating IAM users in every account for every employee is unmanageable and insecure (long-lived credentials everywhere). **IAM Identity Center** (formerly AWS SSO) gives people single sign-on across all your AWS accounts using their existing corporate identity — with short-lived credentials and no per-account IAM users.

> 💡 **If you know Azure:** IAM Identity Center is the AWS equivalent of using **Entra ID for SSO across subscriptions** — one corporate identity, centrally managed, granting access across many accounts. Federation with an external IdP ≈ Azure's federation/SSO capabilities.

---

## 7.2 How It Works (Flow Diagram)

```
Corporate identity source (built-in directory, or federated with an
external IdP like Entra ID/Okta/Active Directory)
        ↓
IAM IDENTITY CENTER (central SSO)
        ↓ assigns "Permission Sets" (reusable role templates) to
          users/groups for specific accounts
        ↓
User logs in ONCE → sees a portal of accounts/roles they can access →
picks one → gets SHORT-LIVED credentials for that account/role
        ↓
No per-account IAM users; no long-lived keys; central management.
```

---

## 7.3 Key Concepts

| Concept | What It Is |
|---|---|
| **Identity source** | Where users come from — built-in directory, or federated (Entra ID, Okta, on-prem AD) |
| **Permission Set** | A reusable template of permissions (like an IAM role) assigned to users/groups per account |
| **Account assignment** | Mapping a user/group + permission set → a specific account |
| **Federation** | Trusting an external IdP so users sign in with existing corporate credentials |

**The big win:** people get short-lived credentials across many accounts via SSO, centrally managed — no sprawl of IAM users with long-lived keys.

---

## 7.4 UI Steps — Setting Up SSO Access

```
📍 Console → "IAM Identity Center" → enable it
📍 Choose identity source: built-in, or "Change" → connect an external
   IdP (Entra ID / Okta) via SAML for federation
📍 "Permission sets" → create (e.g., "DevOpsAccess" with certain policies)
📍 "AWS accounts" → assign a group + permission set to specific accounts
📍 Users log in at the SSO portal URL → pick account/role → temporary creds
   (also: aws sso login for CLI access)
```

---

## 7.5 Real-World Example

```
A company with 10 AWS accounts wants employees to access them securely
without per-account IAM users:

Step 1: Enable IAM Identity Center; federate it with the company's Entra
        ID (employees use their existing corporate login + MFA).
Step 2: Create permission sets: "ReadOnly", "DevOps", "Admin".
Step 3: Assign the "DevOps" group + "DevOps" permission set to the dev
        and staging accounts; "ReadOnly" to prod for most; "Admin" only
        to a few, only where needed.
Step 4: An engineer logs in once via SSO → sees their portal → picks the
        dev account with DevOps access → gets short-lived credentials.

Result: no IAM users or long-lived keys per account, central management
tied to corporate identity, short-lived credentials everywhere, and
easy onboarding/offboarding (manage in the IdP/Identity Center).
```

---

## 7.6 Interview Q&A

**Q: What is IAM Identity Center and why use it over IAM users?**
> It's AWS's SSO service, giving people single sign-on across all your AWS accounts using a central (often federated) corporate identity, with short-lived credentials assigned via reusable permission sets. It's far better than per-account IAM users because it eliminates long-lived credential sprawl, centralizes access management, ties access to corporate identity (easy onboarding/offboarding), and issues only short-lived credentials.

**Q: What's a Permission Set?**
> A reusable template of permissions (like an IAM role) that you assign to users/groups for specific accounts in IAM Identity Center — so the same "DevOps" or "ReadOnly" access can be granted consistently across many accounts.

**Q: How does federation work here?**
> IAM Identity Center can use an external IdP (like Entra ID or Okta) as its identity source via SAML — so users sign in with their existing corporate credentials and MFA, and AWS trusts the IdP's authentication.

---

## 7.7 Summary

IAM Identity Center (formerly AWS SSO) provides single sign-on across all your AWS accounts using a central, often federated corporate identity — assigning short-lived credentials via reusable permission sets, eliminating per-account IAM users and long-lived keys. It's the modern, recommended way to give humans AWS access at scale, tied to corporate identity for easy lifecycle management. Conceptually it's AWS's equivalent of using Entra ID for SSO across Azure subscriptions.

---
---

# 8. 🔗 OIDC Federation Basics
> 🔴 FULL

---

## 8.1 What Problem Does This Solve?

External systems — especially CI/CD tools like GitHub Actions, Bitbucket, or Azure DevOps — need to authenticate to AWS without storing long-lived IAM access keys (which leak and require rotation). **OIDC federation** lets them authenticate using short-lived tokens via a trust relationship, with no stored AWS credentials. This is the modern gold standard and directly relevant to your CI/CD work.

> 💡 **If you know Azure:** OIDC federation to AWS is the exact equivalent of **Workload Identity Federation** in Azure — a trust relationship + short-lived tokens, no stored secret. If you've set up GitHub Actions → Azure via WIF, GitHub Actions → AWS via OIDC is the identical pattern, just pointing at AWS's IAM OIDC provider and assuming an IAM role.

---

## 8.2 How OIDC Federation Works (Flow Diagram)

```
ONE-TIME SETUP:
   1. Create an IAM OIDC Identity Provider in AWS, trusting the external
      issuer (e.g., token.actions.githubusercontent.com for GitHub)
   2. Create an IAM Role with a TRUST POLICY scoped to a specific
      workload (e.g., repo "myorg/myrepo", branch "main")
   3. Attach least-privilege permission policies to that role

EVERY RUN:
   External system (e.g., GitHub Actions)
        ↓ its OIDC provider issues a short-lived token proving identity
          ("this is myorg/myrepo, branch main")
        ↓ calls sts:AssumeRoleWithWebIdentity with that token
        ↓ AWS IAM checks: does the OIDC provider + trust policy match?
        ↓ YES → STS returns short-lived credentials for the scoped role
        ↓
   Deploy to AWS — NO stored AWS access keys, ever.
```

---

## 8.3 Why OIDC Beats Long-Lived Access Keys

| Long-Lived IAM Access Keys | OIDC Federation |
|---|---|
| Stored in the CI tool | Nothing stored |
| Can leak (repo, logs) | Nothing to leak |
| Must be rotated manually | Nothing to rotate |
| Valid until rotated | Short-lived (minutes) |
| Broad if over-scoped | Trust scoped to specific repo/branch |

**Interview gold:** "How should CI/CD authenticate to AWS?" → **"OIDC federation — an IAM OIDC provider trusting the CI tool, and the pipeline assumes a scoped IAM role via AssumeRoleWithWebIdentity, getting short-lived credentials with no stored keys."**

---

## 8.4 The Trust Policy Scoping (Key Detail)

```
The IAM role's trust policy scopes WHICH external workload can assume it:

{
  "Effect": "Allow",
  "Principal": { "Federated": "arn:aws:iam::<acct>:oidc-provider/token.actions.githubusercontent.com" },
  "Action": "sts:AssumeRoleWithWebIdentity",
  "Condition": {
    "StringEquals": {
      "token.actions.githubusercontent.com:sub": "repo:myorg/myrepo:ref:refs/heads/main"
    }
  }
}

The condition scopes the trust to ONLY that repo + branch → even a valid
token from a different repo/branch is rejected. Least privilege on the
trust itself.
```

---

## 8.5 UI/CLI Steps — Setting Up OIDC (GitHub Example)

```
📍 Console → IAM → Identity providers → Add provider → OpenID Connect
   → Provider URL: https://token.actions.githubusercontent.com
   → Audience: sts.amazonaws.com
    ↓
📍 IAM → Roles → Create role → Web identity → select the OIDC provider
   → scope the trust condition to your repo/branch → attach least-privilege
   permission policies → name it (e.g., "github-deploy-role")
    ↓
📍 In GitHub Actions, use the role (no keys — the role ARN isn't a secret):
```
```yaml
permissions:
  id-token: write
  contents: read
steps:
  - uses: aws-actions/configure-aws-credentials@v4
    with:
      role-to-assume: arn:aws:iam::123456789012:role/github-deploy-role
      aws-region: ap-south-1
```

---

## 8.6 Real-World Example

```
A team bans long-lived AWS keys in CI/CD after a near-miss where a key
was almost committed. They move all pipelines to OIDC:

• GitHub Actions: IAM OIDC provider for GitHub + a "github-deploy-role"
  scoped to their repo/branch → workflows assume it via
  configure-aws-credentials. No keys in GitHub.
• Bitbucket: IAM OIDC provider for Bitbucket + scoped role → pipelines
  assume it via AssumeRoleWithWebIdentity. No keys in Bitbucket.
• Azure DevOps: AWS Service Connection configured to assume a role
  (federated where supported). Minimal/no stored keys.

All roles are least-privilege (only the deploy actions needed) and
scoped per repo/environment.

Result: no long-lived AWS credentials anywhere in CI/CD — short-lived,
scoped, secretless access. Even repo read-access grants an attacker
nothing usable.
```

---

## 8.7 Interview Q&A

**Q: What is OIDC federation and why use it for CI/CD?**
> It lets an external system (like GitHub Actions) authenticate to AWS using short-lived tokens via a trust relationship — you create an IAM OIDC identity provider trusting the CI tool and an IAM role scoped (via trust policy) to a specific repo/branch, and the pipeline assumes it via AssumeRoleWithWebIdentity. You use it to eliminate long-lived IAM access keys from CI/CD — nothing stored, nothing to leak or rotate. It's the direct AWS equivalent of Azure Workload Identity Federation.

**Q: How is the trust scoped to prevent misuse?**
> The IAM role's trust policy includes a condition matching the OIDC token's subject (e.g., `repo:myorg/myrepo:ref:refs/heads/main`), so only that specific repo/branch can assume the role — even a valid token from a different repo or branch is rejected. It's least privilege on the trust itself.

**Q: Which STS operation does OIDC use?**
> `sts:AssumeRoleWithWebIdentity` — it exchanges the external OIDC token for short-lived AWS credentials for the scoped role.

---

## 8.8 Summary

OIDC federation lets external CI/CD tools authenticate to AWS with no stored access keys — via an IAM OIDC identity provider trusting the tool's issuer and an IAM role whose trust policy is scoped to a specific repo/branch/workload, assumed through `AssumeRoleWithWebIdentity` for short-lived credentials. It eliminates the leak/rotation risk of long-lived keys and is the modern gold standard, directly mirroring Azure's Workload Identity Federation. This underpins the secure CI/CD authentication covered in depth in Section 29.

---

---
---

# 9. 🌐 Networking Fundamentals (IP, CIDR, Ports)
> 🟠 MEDIUM

---

## 9.1 What Problem Does This Solve?

Before designing any AWS network, you need the building blocks: IP addresses, CIDR ranges, and ports. Getting these wrong is the #1 cause of "why can't my app reach the database?" incidents.

> 💡 **If you know Azure:** These fundamentals are cloud-agnostic — identical to Azure VNet CIDR/ports. If you're solid on Azure networking basics, skim this.

---

## 9.2 The Essentials

```
IP address = a machine's address (public = internet-reachable, private = internal only)
CIDR = a range of IPs. SMALLER /number = BIGGER range:
   /24 = 256 addresses (a subnet)      /16 = 65,536 (a VPC)
Ports = which service on a machine: 22 SSH · 80 HTTP · 443 HTTPS · 3389 RDP · 3306 MySQL · 5432 Postgres · 1433 SQL Server
```

**Key facts:** only give public IPs to resources that truly need internet exposure; never expose 22/3389 to the whole internet; IP = which machine, Port = which service on it.

**AWS specifics:** AWS reserves **5 IPs per subnet** (first 4 + last 1) — so a /24 gives 251 usable. AWS recommends VPC CIDRs from the private ranges (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16).

---

## 9.3 UI Steps — Seeing CIDR When Creating a VPC

```
📍 Console → VPC → Create VPC → IPv4 CIDR block: 10.0.0.0/16 (the whole VPC)
   → subnets carved as /24 slices (10.0.1.0/24, 10.0.2.0/24...)
📍 CLI: aws ec2 create-vpc --cidr-block 10.0.0.0/16
```

---

## 9.4 Real-World Example

```
Plan the IP layout for a 3-tier app on paper first (a real habit):
   VPC:        10.0.0.0/16   (65,536 addresses)
   web-subnet: 10.0.1.0/24   (public — ALB)
   app-subnet: 10.0.2.0/24   (private — app servers)
   db-subnet:  10.0.3.0/24   (private — database)
Ports: web accepts 80/443 from internet; app accepts 8080 from web only;
db accepts 5432 from app only.
Planning ranges up front avoids overlap problems later (e.g., can't peer
VPCs with overlapping CIDRs).
```

---

## 9.5 Interview Q&A

**Q: /24 vs /16?** → 256 vs 65,536 addresses; smaller slash = bigger range. In AWS, 5 IPs are reserved per subnet (/24 = 251 usable).
**Q: Public vs private IP?** → internet-reachable vs internal-only; give public only when needed.
**Q: What port is PostgreSQL / SQL Server?** → 5432 / 1433; NSG/security-group rules must allow the app tier to reach the DB on that port, and only from the app tier.

## 9.6 Summary

IP identifies a machine (public vs private), CIDR describes ranges (smaller slash = bigger; /24=256, /16=65,536, AWS reserves 5 per subnet), and ports identify the service (443 HTTPS, 5432 Postgres, etc.). Plan your VPC /16 and /24 subnets up front, and never expose SSH/RDP to the internet. Identical concepts to Azure networking.

---
---

# 10. 🔷 VPC (Virtual Private Cloud)
> 🔴 FULL

---

## 10.1 What Problem Does This Solve?

Your AWS resources need a private, isolated network to live in and communicate through, separate from other AWS customers. A **VPC** is that private network — you control the IP ranges, subnets, routing, and security.

> 💡 **If you know Azure:** A VPC is the direct equivalent of an Azure **VNet**. Two key differences: (1) AWS **requires an Internet Gateway** resource to be created and attached for internet access (Azure has none — a public IP is enough); (2) AWS **subnets ARE tied to a single AZ** (Azure subnets aren't). So in AWS you create one subnet per AZ.

---

## 10.2 What a VPC Gives You (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  VPC "production-vpc"  (10.0.0.0/16)                      │
│  Isolated from every other AWS customer                    │
│                                                            │
│   web-subnet (AZ-a)   app-subnet (AZ-a)   db-subnet (AZ-a) │
│   web-subnet (AZ-b)   app-subnet (AZ-b)   db-subnet (AZ-b) │
│      ← one subnet PER AZ (AWS subnets are AZ-scoped) →      │
│                                                            │
│   Resources in the VPC talk privately by default           │
│   (subject to Security Groups + NACLs)                     │
└──────────────────────────────────────────────────────────┘
      │
      ↓ (requires an Internet Gateway attached + route + public IP)
   Internet
```

**What you control:** IP address space (CIDR), subnets (per AZ), route tables, Internet/NAT gateways, Security Groups + NACLs, connectivity (peering, TGW, VPN, Direct Connect).

---

## 10.3 Key Facts (AWS-Specific)

```
✅ A VPC lives in ONE region, spanning all its AZs
✅ Subnets are AZ-scoped → create one per AZ for multi-AZ HA (differs from Azure)
✅ Internet access REQUIRES: an Internet Gateway attached + a route + a public IP
   (Azure needs none of this — differs)
✅ CIDRs must NOT overlap with networks you'll connect to (peering/VPN)
✅ Every account gets a "default VPC" per region (AWS pre-creates one; Azure doesn't)
✅ Resources in the same VPC communicate privately by default (subject to SGs/NACLs)
```

---

## 10.4 UI Steps — Creating a VPC

```
📍 Console → VPC → "Create VPC" → "VPC and more" (creates VPC + subnets +
   IGW + route tables in one wizard)
   ┌──────────────────────────────────────────┐
   │ CIDR:      10.0.0.0/16                     │
   │ AZs:       2 (or 3)                         │
   │ Public subnets:  2 · Private subnets: 2/4   │
   │ NAT gateways: 1 per AZ (for private egress) │
   └──────────────────────────────────────────┘
   → Create
📍 CLI: aws ec2 create-vpc --cidr-block 10.0.0.0/16
```

---

## 10.5 Real-World Example

```
Network foundation for a secure 3-tier app across 2 AZs:
   VPC 10.0.0.0/16
   ├── public subnets (AZ-a, AZ-b) → ALB + NAT gateways
   ├── private app subnets (AZ-a, AZ-b) → app servers (no public IP)
   └── private db subnets (AZ-a, AZ-b) → database (most locked down)
Only the ALB (in public subnets) is internet-facing; everything else
is private. Spread across 2 AZs so a data-center failure doesn't take
the app down. Later sections add SGs, NACLs, endpoints, and gateways.
```

---

## 10.6 Interview Q&A

**Q: What is a VPC?** → Your private, isolated network in AWS where you control IP space, subnets, routing, and security; the equivalent of an Azure VNet.
**Q: Does AWS need an Internet Gateway?** → Yes — unlike Azure, AWS requires you to create and attach an Internet Gateway (plus a route and a public IP) for internet access. This is a common Azure→AWS gotcha.
**Q: Are AWS subnets tied to an AZ?** → Yes — each subnet lives in exactly one AZ, so you create one subnet per AZ for multi-AZ HA. (Azure subnets aren't AZ-bound.)

## 10.7 Summary

A VPC is your private, isolated AWS network (≈ Azure VNet) where you control CIDR, subnets, routing, and security. Key AWS differences from Azure: internet access requires an explicitly-attached Internet Gateway, and subnets are AZ-scoped (one per AZ for HA). Resources communicate privately within a VPC by default. Plan the CIDR carefully and spread subnets across AZs for resilience — it's the foundation everything builds on.

---
---

# 11. 🧩 Subnets (Public & Private)
> 🔴 FULL

---

## 11.1 What Problem Does This Solve?

A flat network is insecure — a breached web server could reach the database directly. **Subnets** divide the VPC into segments (per tier, per AZ) so you can isolate tiers and control what's internet-reachable.

> 💡 **If you know Azure:** Same concept as Azure subnets — but AWS subnets are **AZ-scoped** (one per AZ) and the public-vs-private distinction is defined by **routing** (does the subnet's route table point to an Internet Gateway?), not by a subnet type flag.

---

## 11.2 Public vs Private Subnets (Flow Diagram)

```
What makes a subnet "public" vs "private" = its ROUTE TABLE:

PUBLIC SUBNET:  route table has 0.0.0.0/0 → Internet Gateway
                → resources with a public IP can reach the internet directly
                → holds: ALBs, NAT gateways, bastion hosts

PRIVATE SUBNET: route table has NO route to the Internet Gateway
                → not directly internet-reachable
                → outbound internet only via a NAT Gateway (in a public subnet)
                → holds: app servers, databases
```

**Key AWS detail:** there's no "public/private" checkbox — a subnet is public *because* its route table sends `0.0.0.0/0` to an Internet Gateway.

---

## 11.3 Key Facts

```
✅ Subnets are AZ-scoped → one subnet per AZ per tier (e.g., app-subnet-a, app-subnet-b)
✅ 5 IPs reserved per subnet (a /24 = 251 usable)
✅ Public subnet = route to IGW; Private subnet = no route to IGW
✅ Private subnets reach the internet OUTBOUND via a NAT Gateway (Section 15)
✅ Spread each tier across AZs for high availability
```

---

## 11.4 UI Steps — Creating Subnets

```
📍 Console → VPC → Subnets → Create subnet → pick VPC + AZ + CIDR
   (repeat per AZ per tier)
📍 Make it public: attach a route table with 0.0.0.0/0 → Internet Gateway
   (Sections 14) + enable "auto-assign public IP" on the subnet
📍 CLI: aws ec2 create-subnet --vpc-id <id> --cidr-block 10.0.1.0/24 --availability-zone ap-south-1a
```

---

## 11.5 Real-World Example

```
3-tier app across 2 AZs, isolated by subnet + security:
   PUBLIC subnets (AZ-a, AZ-b): ALB + NAT gateways (route to IGW)
   PRIVATE app subnets (AZ-a, AZ-b): app servers (outbound via NAT only)
   PRIVATE db subnets (AZ-a, AZ-b): database (no internet at all)
Security groups then restrict: web→app→db so each tier only accepts
traffic from the tier in front of it. Even a breached web server can't
reach the database directly — defense in depth.
```

---

## 11.6 Interview Q&A

**Q: What makes a subnet public vs private in AWS?** → Its route table. A public subnet routes 0.0.0.0/0 to an Internet Gateway; a private subnet has no such route (and reaches the internet outbound only via a NAT Gateway). There's no public/private flag — it's defined by routing.
**Q: How many usable IPs in a /24?** → 251 (AWS reserves 5 per subnet).
**Q: Are subnets AZ-specific?** → Yes — each subnet is in one AZ, so you create one per AZ for multi-AZ HA (unlike Azure).

## 11.7 Summary

Subnets divide a VPC into isolatable segments; a subnet is *public* if its route table sends 0.0.0.0/0 to an Internet Gateway and *private* otherwise (reaching the internet outbound only via a NAT Gateway). AWS subnets are AZ-scoped (one per AZ for HA) and reserve 5 IPs each (/24 = 251 usable). Put internet-facing resources (ALB, NAT, bastion) in public subnets and app/database tiers in private subnets, with security groups enforcing tier-to-tier isolation.

---
---

# 12. 🛡️ Security Groups
> 🔴 FULL

---

## 12.1 What Problem Does This Solve?

You need to control exactly what traffic can reach and leave your EC2 instances (and other resources) — which ports, from which sources. A **Security Group** is AWS's instance-level virtual firewall.

> 💡 **If you know Azure:** A Security Group is like *half* of an Azure NSG. Key differences: AWS Security Groups are **allow-only** (no deny rules — you use NACLs for deny), attach at the **instance/ENI level** (not subnet), and are **stateful**. Azure's NSG does both allow+deny at both subnet and NIC level in one construct; AWS splits this across Security Groups (instance, allow-only) + NACLs (subnet, allow+deny).

---

## 12.2 How Security Groups Work (Flow Diagram)

```
Security Group = a stateful, allow-only firewall attached to an instance/ENI

   Inbound rules: what's ALLOWED IN (there is NO deny — absence = blocked)
   Outbound rules: what's ALLOWED OUT (default: all outbound allowed)

   STATEFUL: if you allow inbound on 443, the response is auto-allowed
   out (no matching outbound rule needed).

   Example inbound rules:
   Type    Port   Source
   HTTPS   443    0.0.0.0/0 (anywhere)
   HTTP    80     0.0.0.0/0
   SSH     22     203.0.113.0/24 (office only — NOT 0.0.0.0/0!)
```

---

## 12.3 Key Features

```
✅ ALLOW-ONLY — no deny rules (whatever isn't allowed is implicitly blocked);
   use NACLs (Section 13) if you need explicit deny
✅ STATEFUL — return traffic auto-allowed (no separate response rule)
✅ Attach at INSTANCE/ENI level (multiple instances can share one SG)
✅ Source can be a CIDR, or ANOTHER SECURITY GROUP (e.g., "allow from the
   web-tier SG") — this is how you do tier-to-tier rules that survive
   autoscaling (≈ Azure ASGs)
✅ An instance can have multiple SGs; rules are cumulative (union of allows)
✅ ⚠️ Never allow 22/3389 from 0.0.0.0/0
```

**⭐ Referencing another SG as a source** is the AWS equivalent of Azure ASGs — "allow the app-tier SG to reach the db-tier SG on 5432" stays correct as autoscaling adds/removes instances.

---

## 12.4 UI Steps — Creating a Security Group

```
📍 Console → EC2 → Security Groups → Create security group
   → name + VPC → Inbound rules → Add rule:
     HTTPS · 443 · Source: Anywhere (0.0.0.0/0)
     SSH · 22 · Source: My IP (or a specific CIDR — never Anywhere)
   → Outbound: leave default (all allowed) → Create
📍 Attach: EC2 → instance → Actions → Security → Change security groups
📍 CLI: aws ec2 create-security-group / authorize-security-group-ingress
```

---

## 12.5 Real-World Example

```
3-tier app secured with Security Groups referencing each other (autoscale-safe):
   ALB-SG:  allow 443 from 0.0.0.0/0
   web-SG:  allow 80 from ALB-SG only
   app-SG:  allow 8080 from web-SG only
   db-SG:   allow 5432 from app-SG only
Because rules reference SGs (not IPs), new autoscaled instances that join
a SG are automatically covered — no rule edits. Even a breached web
server can't reach the DB directly (db-SG only allows app-SG). Defense
in depth. SSH access goes through a bastion (bastion-SG allows 22 from
the office IP only).
```

---

## 12.6 Interview Q&A

**Q: What's a Security Group and how does it differ from a NACL?** → An instance-level, stateful, allow-only virtual firewall. It differs from a NACL, which is subnet-level, stateless, and supports both allow and deny. (In Azure, one NSG does both jobs; AWS splits them.)
**Q: What does "stateful" mean?** → If you allow inbound traffic, the response is automatically allowed out — no separate outbound rule needed.
**Q: How do you write a rule that survives autoscaling?** → Reference another Security Group as the source (e.g., "allow from web-SG") instead of hardcoding IPs — new instances joining that SG are automatically covered. This is the AWS equivalent of Azure Application Security Groups.

## 12.7 Summary

A Security Group is AWS's instance/ENI-level, stateful, allow-only firewall (return traffic auto-allowed; no deny rules — use NACLs for that). Reference other Security Groups as sources for tier-to-tier rules that survive autoscaling (the AWS equivalent of Azure ASGs), never expose SSH/RDP to 0.0.0.0/0, and combine SGs across tiers for defense in depth. Together with NACLs (next), Security Groups replace what Azure does with a single NSG.

---
---

# 13. 🚧 Network ACLs (NACLs)
> 🟠 MEDIUM

---

## 13.1 What Problem Does This Solve?

Security Groups are allow-only and instance-level. Sometimes you need **subnet-level** rules and the ability to explicitly **deny** specific traffic (e.g., block a known-bad IP range). That's what a **Network ACL (NACL)** provides.

> 💡 **If you know Azure:** A NACL is the *other half* of an Azure NSG — subnet-level, and supporting explicit **deny** rules. Azure combines SG-like and NACL-like behavior in one NSG; AWS keeps them as two tools: Security Groups (instance, stateful, allow-only) + NACLs (subnet, stateless, allow+deny).

---

## 13.2 NACL vs Security Group (Flow Diagram)

```
                Security Group          Network ACL (NACL)
Level:          Instance/ENI            Subnet
Rules:          Allow only              Allow AND Deny
State:          STATEFUL (return auto)  STATELESS (must allow return traffic explicitly)
Evaluation:     all rules (union)       numbered order, first match wins
Default:        deny inbound/allow out  default NACL allows all; custom denies all

Traffic path: NACL (subnet, checked first) → Security Group (instance) → resource
Both must allow it.
```

**⭐ Stateless is the key gotcha:** because NACLs are stateless, you must explicitly allow BOTH the inbound request AND the outbound response (including ephemeral ports 1024-65535 for return traffic) — unlike stateful Security Groups.

---

## 13.3 Key Facts

```
✅ Subnet-level (applies to all resources in the subnet)
✅ Supports explicit DENY (Security Groups can't) — e.g., block a bad IP
✅ STATELESS — must allow return traffic explicitly (remember ephemeral
   ports 1024-65535 for responses)
✅ Rules evaluated in NUMBERED order, lowest first, first match wins
✅ Default NACL allows all traffic; a custom NACL denies all until you add rules
✅ Use as a coarse, secondary layer; Security Groups are the primary control
```

---

## 13.4 UI Steps — Creating a NACL

```
📍 Console → VPC → Network ACLs → Create → associate with a subnet
   → Inbound rules: numbered rules (e.g., 100 Allow 443, 200 Deny a bad CIDR)
   → Outbound rules: MUST allow return traffic (e.g., ephemeral ports 1024-65535)
📍 CLI: aws ec2 create-network-acl / create-network-acl-entry
```

---

## 13.5 Real-World Example

```
A team needs to block a specific malicious IP range across an entire
subnet — Security Groups can't deny, so they use a NACL:
   Inbound rule 90:  DENY  from 198.51.100.0/24 (the bad range) — checked first
   Inbound rule 100: ALLOW 443 from 0.0.0.0/0
   Outbound rule 100: ALLOW ephemeral ports 1024-65535 (return traffic —
                      required because NACLs are stateless)
Security Groups still do the fine-grained instance-level allow rules;
the NACL adds a coarse subnet-level deny for the bad IPs.
```

---

## 13.6 Interview Q&A

**Q: Security Group vs NACL?** → SG = instance-level, stateful, allow-only. NACL = subnet-level, stateless, allow+deny, numbered evaluation. Traffic passes the NACL (subnet) then the SG (instance). In Azure both are one NSG; AWS splits them.
**Q: What does "stateless" mean for a NACL and why does it matter?** → Return traffic is NOT automatically allowed — you must explicitly allow both directions, including ephemeral ports (1024-65535) for responses. Forgetting the return rule is a classic bug.
**Q: When would you use a NACL over a Security Group?** → When you need an explicit deny (Security Groups can't) or a coarse subnet-wide rule — e.g., blocking a known-bad IP range across a whole subnet.

## 13.7 Summary

A Network ACL is a subnet-level, stateless firewall supporting both allow and deny rules, evaluated in numbered order (first match wins). It's the complement to Security Groups (instance-level, stateful, allow-only) — traffic passes the NACL then the SG. Use NACLs for explicit denies (like blocking bad IP ranges) as a coarse secondary layer, remembering that statelessness means you must explicitly allow return traffic (ephemeral ports). Together, SGs + NACLs provide what Azure does with a single NSG.

---
---

# 14. 🧭 Route Tables & Internet Gateway
> 🔴 FULL

---

## 14.1 What Problem Does This Solve?

How does traffic in your VPC know where to go — to another subnet, to the internet, or through a firewall? **Route Tables** define that, and the **Internet Gateway** is what actually enables internet connectivity (which, unlike Azure, AWS requires you to create explicitly).

> 💡 **If you know Azure:** Route Tables ≈ Azure Route Tables/UDRs. But the **Internet Gateway (IGW) has no Azure equivalent** — in Azure a public IP is enough; in AWS you must create an IGW, attach it to the VPC, AND add a route to it. This explicit-IGW requirement is the top Azure→AWS networking gotcha.

---

## 14.2 How Routing Works (Flow Diagram)

```
Every subnet is associated with a ROUTE TABLE that decides where traffic goes:

PUBLIC subnet route table:
   Destination     Target
   10.0.0.0/16     local          ← VPC-internal traffic stays inside
   0.0.0.0/0       igw-xxxx        ← everything else → Internet Gateway

PRIVATE subnet route table:
   10.0.0.0/16     local
   0.0.0.0/0       nat-xxxx        ← internet via NAT Gateway (outbound only)

Most specific route wins (longest prefix match). A subnet's route table
is what makes it "public" (route to IGW) or "private" (no IGW route).
```

---

## 14.3 The Internet Gateway (IGW) — AWS-Specific

```
To give a subnet internet access, you need ALL THREE:
   1. Create an Internet Gateway + ATTACH it to the VPC
   2. Add a route: 0.0.0.0/0 → the IGW (in the subnet's route table)
   3. The resource must have a PUBLIC IP (or Elastic IP)

Miss any one → no internet. (In Azure, none of this is needed — a public
IP alone works. This 3-step requirement is a frequent AWS gotcha.)
```

An **IGW is horizontally scaled, redundant, and highly available** — one per VPC, managed by AWS.

---

## 14.4 Other Route Targets

| Target | Purpose |
|---|---|
| `local` | VPC-internal traffic (always present) |
| Internet Gateway (igw-) | Internet (public subnets) |
| NAT Gateway (nat-) | Outbound internet for private subnets (Section 15) |
| VPC Peering (pcx-) | To a peered VPC (Section 17) |
| Transit Gateway (tgw-) | To many VPCs/on-prem via TGW (Section 18) |
| VPC Endpoint | Private access to AWS services (Section 16) |

---

## 14.5 UI Steps — Making a Subnet Public

```
📍 Console → VPC → Internet Gateways → Create → then "Attach to VPC"
📍 VPC → Route Tables → create/select the public subnet's table →
   Routes → Edit → Add: Destination 0.0.0.0/0, Target = the IGW
📍 Subnets → select subnet → Edit subnet settings → enable "auto-assign
   public IPv4" → the subnet is now public
📍 CLI: aws ec2 create-internet-gateway / attach-internet-gateway / create-route
```

---

## 14.6 Real-World Example

```
Making the web tier internet-facing and the app tier private-with-egress:
   1. Create + attach an Internet Gateway to the VPC.
   2. PUBLIC route table (for web/ALB subnets): 0.0.0.0/0 → IGW; ALB gets
      a public IP → reachable from the internet.
   3. PRIVATE route table (for app subnets): 0.0.0.0/0 → NAT Gateway →
      app servers can pull updates/call external APIs outbound, but the
      internet can't reach them inbound.
   4. To force outbound through a firewall instead, point 0.0.0.0/0 at a
      Network Firewall endpoint (Section 22).
Result: web tier public, app/db tiers private, routing precisely controlled.
```

---

## 14.7 Interview Q&A

**Q: How does a subnet get internet access in AWS?** → Three things: an Internet Gateway created and attached to the VPC, a route of 0.0.0.0/0 → IGW in the subnet's route table, and a public IP on the resource. All three are required — this is a key difference from Azure, where a public IP alone suffices.
**Q: What makes a subnet public vs private?** → Its route table: public = has a 0.0.0.0/0 route to the Internet Gateway; private = doesn't (and uses a NAT Gateway for outbound).
**Q: How does route selection work?** → Most specific route wins (longest prefix match); every route table has a `local` route for VPC-internal traffic.

## 14.8 Summary

Route Tables control where subnet traffic goes; a subnet is public if its table routes 0.0.0.0/0 to an Internet Gateway, private otherwise. Unlike Azure, AWS requires you to explicitly create and attach an Internet Gateway AND add a route to it AND give the resource a public IP for internet access — the top Azure→AWS gotcha. Other route targets (NAT Gateway, VPC Peering, Transit Gateway, VPC Endpoints) direct traffic to the respective destinations, with most-specific-route-wins.

---
---

# 15. 🚪 NAT Gateway
> 🟠 MEDIUM

---

## 15.1 What Problem Does This Solve?

Private-subnet resources (no public IP) still need *outbound* internet — to download updates, patches, or call external APIs — while staying unreachable *from* the internet. A **NAT Gateway** provides this controlled, outbound-only internet access.

> 💡 **If you know Azure:** Directly equivalent to Azure NAT Gateway. Difference: in AWS you place the NAT Gateway *in a public subnet* and point private subnets' route tables at it; in Azure you associate it directly with a subnet (no route entry needed).

---

## 15.2 How It Works (Flow Diagram)

```
Private subnet resources (private IPs only)
   ↓ 0.0.0.0/0 route → NAT Gateway (lives in a PUBLIC subnet, has an Elastic IP)
   ↓ NAT translates → out via the Internet Gateway
Internet
   ↑ internet CANNOT initiate connections back in (outbound only)

Requirements:
   • NAT Gateway sits in a PUBLIC subnet (needs internet via the IGW)
   • Private subnets' route table: 0.0.0.0/0 → the NAT Gateway
   • For HA: one NAT Gateway PER AZ (so an AZ failure doesn't kill egress)
```

---

## 15.3 Key Facts

```
✅ OUTBOUND only — internet can't initiate connections back in
✅ Fully managed, highly available within its AZ; scales automatically
✅ Lives in a PUBLIC subnet; private subnets route to it
✅ Provides a static outbound IP (Elastic IP) — good for third-party allow-listing
✅ For HA, deploy one NAT Gateway per AZ (a single NATGW is a per-AZ SPOF)
✅ Costs: hourly + per-GB data processing (a common cost-optimization target)
✅ (Legacy "NAT Instances" exist but NAT Gateway is the managed standard)
```

---

## 15.4 UI Steps — Creating a NAT Gateway

```
📍 Console → VPC → NAT Gateways → Create → choose a PUBLIC subnet →
   allocate an Elastic IP → Create
📍 Then update the PRIVATE subnet's route table:
   0.0.0.0/0 → the NAT Gateway
📍 CLI: aws ec2 create-nat-gateway --subnet-id <public-subnet> --allocation-id <eip>
```

---

## 15.5 Real-World Example

```
Private app servers must call an external payment API that requires
source-IP allow-listing:
   1. Deploy a NAT Gateway (with an Elastic IP) in each AZ's public subnet.
   2. Private app subnets route 0.0.0.0/0 → their AZ's NAT Gateway.
   3. Give the payment provider the NAT Gateways' Elastic IPs to allow-list.
   4. Now all outbound calls from app servers (even new autoscaled ones)
      appear from those static IPs → pass the allow-list — while the app
      servers stay completely private inbound.
One NAT Gateway per AZ ensures an AZ failure doesn't cut off egress.
```

---

## 15.6 Interview Q&A

**Q: What's a NAT Gateway for?** → Outbound-only internet for private-subnet resources (updates, external APIs) while keeping them unreachable inbound; provides a static Elastic IP useful for third-party allow-listing.
**Q: Where does it live and how do private subnets use it?** → In a public subnet (with an Elastic IP); private subnets route 0.0.0.0/0 to it. For HA, one per AZ.
**Q: How is it different from Azure NAT Gateway?** → Same purpose, but in AWS you route private subnets to it via a route table entry (in Azure you associate it directly with the subnet, no route needed).

## 15.7 Summary

A NAT Gateway gives private-subnet resources outbound-only internet access (updates, external APIs) while keeping them unreachable inbound, with a static Elastic IP useful for allow-listing. It lives in a public subnet, and private subnets route 0.0.0.0/0 to it — deploy one per AZ for high availability, and watch its hourly + data-processing cost. Equivalent to Azure NAT Gateway, but AWS requires the explicit route table entry.

---
---

# 16. 🔒 VPC Endpoints (Gateway & Interface / PrivateLink)
> 🔴 FULL

---

## 16.1 What Problem Does This Solve?

By default, an EC2 instance reaching an AWS service like S3 or DynamoDB sends traffic out to the service's public endpoint — even though both are in AWS. That's a security concern and can incur NAT/egress costs. **VPC Endpoints** let your VPC reach AWS services *privately*, without traversing the internet.

> 💡 **If you know Azure:** VPC Endpoints map to Azure's private-access options. **Gateway Endpoints** (S3/DynamoDB, free, route-table-based) are roughly like Azure **Service Endpoints**. **Interface Endpoints (PrivateLink)** — which put a private IP for the service in your subnet — are the direct equivalent of Azure **Private Endpoints**.

---

## 16.2 The Two Types (Flow Diagram)

```
GATEWAY ENDPOINT (S3 & DynamoDB ONLY — free):
   Adds a ROUTE in your route table → traffic to S3/DynamoDB stays on the
   AWS network (not via IGW/NAT). No private IP; uses the service's public
   endpoint but keeps traffic internal. Free.
   ≈ Azure Service Endpoint

INTERFACE ENDPOINT (PrivateLink — most other services):
   Puts an ELASTIC NETWORK INTERFACE with a PRIVATE IP for the service
   INSIDE your subnet → resources reach the service via that private IP,
   fully private, no internet at all. Has an hourly + data cost.
   ≈ Azure Private Endpoint

   VM (10.0.2.5) → private IP (10.0.2.20 = interface endpoint) → the AWS service
```

---

## 16.3 Gateway vs Interface Endpoint (Comparison)

| | Gateway Endpoint | Interface Endpoint (PrivateLink) |
|---|---|---|
| Services | S3 & DynamoDB only | Most AWS services + your own/partner services |
| Mechanism | Route table entry | Private IP (ENI) in your subnet |
| Private IP in VPC? | No | Yes |
| Cost | Free | Hourly + data |
| Azure analog | Service Endpoint | Private Endpoint |
| Works from on-prem (via VPN/DX)? | No | Yes |

---

## 16.4 Why Use Them

```
✅ Security: reach AWS services without exposing traffic to the internet
✅ Cost: Gateway Endpoints (S3/DynamoDB) avoid NAT Gateway data-processing
   charges for that traffic — a common, easy cost win
✅ PrivateLink (Interface): fully private access, works from on-premises,
   and can expose YOUR OWN service privately to other VPCs/accounts
✅ Compliance: keep traffic off the public internet entirely
```

---

## 16.5 UI Steps — Creating VPC Endpoints

```
── Gateway Endpoint (S3) ──
📍 Console → VPC → Endpoints → Create endpoint → service "S3" (Gateway
   type) → select your VPC + route tables → Create (a route is auto-added)

── Interface Endpoint (e.g., Secrets Manager) ──
📍 VPC → Endpoints → Create endpoint → service "secretsmanager" (Interface
   type) → select VPC + subnets → an ENI with a private IP is created in
   each subnet → enable Private DNS so the service's normal hostname
   resolves to the private IP
📍 CLI: aws ec2 create-vpc-endpoint --vpc-endpoint-type Gateway|Interface ...
```

---

## 16.6 Real-World Example

```
A security-sensitive app in private subnets must reach S3, DynamoDB, and
Secrets Manager WITHOUT any internet path:
   • S3 + DynamoDB → GATEWAY ENDPOINTS (free; adds routes so traffic stays
     on the AWS network — also saves NAT data-processing cost).
   • Secrets Manager → INTERFACE ENDPOINT (PrivateLink; private IP in the
     subnet + Private DNS so the normal endpoint resolves privately).
Now the app reaches all three privately, the private subnets don't even
need a NAT Gateway for these services, and nothing touches the internet.
(This mirrors using Azure Service Endpoints for some services + Private
Endpoints for others.)
```

---

## 16.7 Interview Q&A

**Q: What are the two types of VPC Endpoints?** → Gateway Endpoints (S3 & DynamoDB only, free, route-table-based, no private IP) and Interface Endpoints / PrivateLink (most services, a private IP/ENI in your subnet, hourly cost, fully private). Gateway ≈ Azure Service Endpoint; Interface ≈ Azure Private Endpoint.
**Q: Why use a Gateway Endpoint for S3?** → To reach S3 privately over the AWS network without an internet path, and to avoid NAT Gateway data-processing charges for that traffic — it's free and a common cost win.
**Q: What does PrivateLink enable beyond reaching AWS services?** → Exposing your own (or a partner's) service privately to other VPCs/accounts via an Interface Endpoint, without internet exposure.

## 16.8 Summary

VPC Endpoints give private access to AWS services without traversing the internet. Gateway Endpoints (S3 & DynamoDB only, free) add route-table entries keeping traffic on the AWS network (≈ Azure Service Endpoints). Interface Endpoints / PrivateLink place a private IP for the service inside your subnet for fully private access, work from on-premises, and can expose your own services privately (≈ Azure Private Endpoints). Use Gateway Endpoints for S3/DynamoDB (security + NAT cost savings) and Interface Endpoints for other services needing strong isolation.

---

---
---

# 17. 🔗 VPC Peering
> 🟠 MEDIUM

---

## 17.1 What Problem Does This Solve?

Organizations run multiple VPCs (per team, per app, shared services) that need to communicate privately. **VPC Peering** connects two VPCs so resources talk using private IPs over the AWS backbone.

> 💡 **If you know Azure:** Directly equivalent to Azure **VNet Peering** — including the same critical limitation: **not transitive** (A↔B + B↔C ≠ A→C).

---

## 17.2 How It Works (Flow Diagram)

```
VPC-A (10.0.0.0/16) ←──peering──→ VPC-B (10.1.0.0/16)
   Resources talk via PRIVATE IPs over the AWS backbone.

⚠️ NOT transitive: A↔B + B↔C does NOT let A reach C — need a direct A↔C peering.
⚠️ CIDRs must NOT overlap.
✅ Works cross-region and cross-account.
✅ After creating the peering, you must ADD ROUTES on both sides
   (route table: B's CIDR → the peering connection, and vice versa).
```

---

## 17.3 Key Facts

```
✅ Non-transitive (no hopping through a middle VPC) — same as Azure
✅ CIDRs must not overlap
✅ Works same-region, cross-region, cross-account
✅ Must add ROUTES on both VPCs' route tables (peering alone isn't enough)
✅ For MANY VPCs, peering becomes a mesh nightmare → use Transit Gateway (Section 18)
```

---

## 17.4 UI Steps

```
📍 Console → VPC → Peering connections → Create → requester VPC + accepter VPC
   → the other side "Accepts" → then ADD ROUTES in both route tables
   (peer CIDR → the peering connection)
📍 CLI: aws ec2 create-vpc-peering-connection / accept-vpc-peering-connection / create-route
```

---

## 17.5 Real-World Example

```
A shared-services VPC (central DNS, monitoring) peered with an app VPC:
   shared-svc-vpc (10.0.0.0/16) ↔ app-vpc (10.1.0.0/16)
Add routes both ways → the app VPC uses the shared tools over private IPs.
But if a THIRD VPC also needs the shared services, peering each pair
gets messy fast (N VPCs = N² peerings) → they migrate to a Transit
Gateway hub instead (next section).
```

---

## 17.6 Interview Q&A

**Q: What is VPC Peering?** → Connects two VPCs for private-IP communication over the AWS backbone; works cross-region/cross-account, but requires non-overlapping CIDRs and route table entries on both sides.
**Q: Is it transitive?** → No — A↔B + B↔C doesn't give A→C. Need a direct peering, or use a Transit Gateway for many VPCs. (Same as Azure.)
**Q: When would peering not scale?** → With many VPCs — full-mesh peering (N² connections) becomes unmanageable; that's when you use Transit Gateway.

## 17.7 Summary

VPC Peering connects two VPCs for private-IP communication over the AWS backbone (cross-region/cross-account), requiring non-overlapping CIDRs and route entries on both sides. It's non-transitive (like Azure VNet Peering) — fine for a few VPCs, but a full mesh doesn't scale, so many-VPC topologies use Transit Gateway instead.

---
---

# 18. 🎯 Transit Gateway
> 🔴 FULL

---

## 18.1 What Problem Does This Solve?

VPC Peering is non-transitive and becomes an unmanageable mesh (N² connections) as VPCs multiply. **Transit Gateway (TGW)** is a central hub that connects many VPCs, on-premises networks, and accounts through one place — the AWS way to build hub-and-spoke at scale. A top networking-design interview topic.

> 💡 **If you know Azure:** Transit Gateway is the AWS equivalent of Azure's **Hub-and-Spoke topology** (implemented with a hub VNet + peering) and **Azure Virtual WAN** combined — a central hub interconnecting many networks. TGW *is* transitive (unlike VPC Peering), so spokes can reach each other through the hub.

---

## 18.2 How It Works (Flow Diagram)

```
                  ┌─────────────────────────────┐
                  │   TRANSIT GATEWAY (the hub)  │
                  │   central router for all      │
                  └──┬────┬────┬────────┬─────────┘
          attach     │    │    │        │  attach
        ┌────────────┘    │    │        └────────────┐
        ↓                 ↓    ↓                       ↓
     VPC-A            VPC-B  VPC-C              On-Prem (via VPN/Direct Connect)

• Each VPC/VPN/DX "attaches" to the TGW (a hub-and-spoke star, not a mesh)
• TGW is TRANSITIVE — VPC-A can reach VPC-C THROUGH the TGW
• Route tables on the TGW control which attachments can reach which
• Scales to thousands of VPCs; works cross-region (TGW peering) & cross-account
```

---

## 18.3 TGW vs VPC Peering (Key Distinction)

| | VPC Peering | Transit Gateway |
|---|---|---|
| Topology | Point-to-point (mesh) | Hub-and-spoke (star) |
| Transitive? | ❌ No | ✅ Yes |
| Scale | A few VPCs (N² problem) | Thousands of VPCs |
| On-prem connectivity | Per-VPC | Centralized (one VPN/DX to the TGW) |
| Cost | Free (data transfer only) | Hourly per attachment + data |

**Interview point:** use VPC Peering for a couple of VPCs; use Transit Gateway when you have many VPCs and/or centralized on-premises connectivity — because it's transitive and hub-and-spoke, avoiding the peering mesh.

---

## 18.4 Key Facts

```
✅ Central hub — attach VPCs, VPN connections, Direct Connect gateways
✅ TRANSITIVE routing (spokes reach each other via the hub — unlike peering)
✅ TGW route tables control segmentation (which attachments talk to which —
   e.g., keep prod and dev VPCs isolated even though both attach to the TGW)
✅ Centralizes on-premises connectivity (one VPN/DX to the TGW serves all VPCs)
✅ Cross-region via inter-region TGW peering; cross-account via RAM sharing
```

---

## 18.5 UI Steps

```
📍 Console → VPC → Transit Gateways → Create transit gateway
📍 Transit Gateway Attachments → Create → attach each VPC (and VPN/DX)
📍 Transit Gateway Route Tables → control which attachments can route to which
📍 Update each VPC's route table: route other VPCs'/on-prem CIDRs → the TGW attachment
📍 CLI: aws ec2 create-transit-gateway / create-transit-gateway-vpc-attachment
```

---

## 18.6 Real-World Example

```
A company with 20 VPCs across teams + an on-premises data center:
   • A Transit Gateway is the central hub; all 20 VPCs attach to it.
   • One Site-to-Site VPN (and/or Direct Connect) connects on-prem to the
     TGW → all 20 VPCs reach on-prem through the single connection.
   • TGW route tables SEGMENT traffic: prod VPCs can reach shared-services
     but NOT dev VPCs (isolation via TGW route tables).
   • Adding a 21st VPC = one attachment (vs peering it to 20 others).
This is the AWS realization of hub-and-spoke — the same design goal as an
Azure hub VNet or Virtual WAN.
```

---

## 18.7 Interview Q&A

**Q: What is Transit Gateway and when do you use it over VPC Peering?**
> A central hub that connects many VPCs, VPN connections, and Direct Connect through one place, with transitive routing. Use it over VPC Peering when you have many VPCs and/or centralized on-premises connectivity — peering is point-to-point, non-transitive, and becomes an unmanageable mesh (N² connections), while TGW is hub-and-spoke, transitive, and scales to thousands of VPCs.

**Q: How do you keep prod and dev isolated if both attach to the same TGW?**
> Using TGW route tables — you control which attachments can route to which, so prod VPCs can reach shared services but not dev VPCs, even though all attach to the same Transit Gateway. This is network segmentation at the hub.

**Q: How does this relate to Azure?**
> Transit Gateway is the AWS equivalent of an Azure Hub-and-Spoke topology and Virtual WAN combined — a central hub interconnecting many networks and centralizing on-premises connectivity, with the advantage of transitive routing.

## 18.8 Summary

Transit Gateway is a central hub connecting many VPCs, VPN, and Direct Connect with transitive routing — the AWS way to do hub-and-spoke at scale, replacing the unmanageable N² mesh of VPC Peering. Its route tables segment traffic (isolating prod from dev even when both attach), and it centralizes on-premises connectivity (one VPN/DX serves all VPCs). Use peering for a couple of VPCs, TGW for many — it's the equivalent of Azure Hub-and-Spoke / Virtual WAN.

---
---

# 19. 🌍 Route 53
> 🟠 MEDIUM

---

## 19.1 What Problem Does This Solve?

Users reach apps by name (`www.myapp.com`), computers need IPs — DNS translates between them. **Route 53** is AWS's highly available DNS service, and unlike basic DNS it offers intelligent **routing policies** for global traffic management. It can also register domains.

> 💡 **If you know Azure:** Route 53 combines what Azure splits into **Azure DNS** (hosting records) + **Traffic Manager** (routing policies) — plus it can register domains (Azure DNS can't). Its routing policies ≈ Traffic Manager's routing methods.

---

## 19.2 Record Types & Routing Policies (Flow Diagram)

```
Route 53 does BOTH:
   1. HOSTS DNS records (A, AAAA, CNAME, MX, TXT, Alias)
   2. Applies ROUTING POLICIES to decide WHICH answer to return:

   Simple        → one record, one answer
   Weighted      → split traffic by % (A/B testing, gradual rollout)
   Latency-based → route each user to the lowest-latency region
   Failover      → primary → secondary on health-check failure (active-passive)
   Geolocation   → route by the user's geographic location
   Geoproximity  → route by geography with bias
   Multivalue    → return multiple healthy records (basic client-side LB)
```

**Alias records** (AWS-specific) point at AWS resources (ALB, CloudFront, S3) at the zone apex, free of DNS query charges — like Azure's Alias records.

---

## 19.3 Key Facts

```
✅ Route 53 can REGISTER domains AND host DNS (Azure DNS can't register)
✅ Hosted Zones: Public (internet) or Private (within VPCs — internal resolution)
✅ Health checks + Failover routing = automatic DNS failover to a DR site
✅ Use ALIAS records (not CNAME) for AWS resources at the apex domain
✅ 7 routing policies (vs Azure Traffic Manager's ~6 methods)
```

---

## 19.4 UI Steps

```
📍 Console → Route 53 → Hosted zones → Create hosted zone (public or private)
📍 → Create record → choose routing policy (Simple/Weighted/Latency/Failover/etc.)
   → Alias to an ALB/CloudFront, or A record to an IP
📍 Register a domain: Route 53 → Registered domains → Register domain
📍 Health checks: Route 53 → Health checks → Create (for failover routing)
```

---

## 19.5 Real-World Example

```
A global SaaS platform:
   • Register myapp.com in Route 53; create a public hosted zone.
   • api.myapp.com → LATENCY-based routing across ALBs in ap-south-1,
     us-east-1, eu-west-1 → each user hits the fastest region.
   • admin.myapp.com → FAILOVER routing: primary us-east-1, secondary
     ap-south-1, with a health check → auto-failover on outage.
   • New release → WEIGHTED routing: 10% to the new version, 90% to
     stable → gradual rollout.
   • db.internal.myapp.com → PRIVATE hosted zone → resolves the DB's
     private IP inside the VPC only.
Result: global low latency, automatic DR failover, gradual rollouts, and
clean internal naming.
```

---

## 19.6 Interview Q&A

**Q: What is Route 53 and how does it differ from Azure's DNS?** → AWS's DNS service that both hosts records and can register domains, with 7 intelligent routing policies. It combines what Azure splits into Azure DNS (hosting) + Traffic Manager (routing), and unlike Azure DNS it can register domains.
**Q: Name key routing policies.** → Simple, Weighted (%, for A/B/gradual rollout), Latency-based (fastest region per user), Failover (active-passive with health checks), Geolocation, Geoproximity, Multivalue.
**Q: Alias vs CNAME?** → Use Alias records for AWS resources (ALB/CloudFront/S3) at the apex domain — they work at the root and don't incur DNS query charges (like Azure Alias records).

## 19.7 Summary

Route 53 is AWS's DNS service — it hosts records, registers domains (unlike Azure DNS), and offers 7 routing policies (Weighted, Latency, Failover, Geolocation, etc.) for global traffic management, combining what Azure splits into Azure DNS + Traffic Manager. Use Failover routing + health checks for automatic DR, Weighted for gradual rollouts, Latency for global performance, Private Hosted Zones for internal naming, and Alias records for AWS resources at the apex.

---
---

# 20. ⚖️ Elastic Load Balancing (ALB / NLB / GWLB)
> 🟠 MEDIUM

---

## 20.1 What Problem Does This Solve?

You need to distribute traffic across multiple healthy targets (EC2, containers, Lambda) for availability and scale, and route intelligently. AWS **Elastic Load Balancing** offers three types for different needs.

> 💡 **If you know Azure:** ALB ≈ Azure **Application Gateway** (Layer 7); NLB ≈ Azure **Load Balancer** (Layer 4); GWLB ≈ Azure Gateway Load Balancer (for network appliances). AWS's load balancer types map cleanly to Azure's.

---

## 20.2 The Three Types (Flow Diagram)

```
                    Traffic
                       ↓
   ┌──────────────────────────────────────────────────────┐
   │  ALB (Application Load Balancer) — Layer 7 (HTTP/HTTPS)│
   │   • path-based (/api/*) & host-based routing           │
   │   • SSL termination, WAF integration, WebSocket         │
   │   • targets: EC2, ECS, Lambda, IPs                      │
   │   → web apps, microservices, container routing           │
   ├──────────────────────────────────────────────────────┤
   │  NLB (Network Load Balancer) — Layer 4 (TCP/UDP)       │
   │   • ultra-high performance, millions of req/sec         │
   │   • static IP per AZ, preserves source IP               │
   │   → extreme performance, non-HTTP, static IP needs       │
   ├──────────────────────────────────────────────────────┤
   │  GWLB (Gateway Load Balancer) — Layer 3                │
   │   • deploy/scale 3rd-party network appliances           │
   │     (firewalls, IDS/IPS, deep packet inspection)         │
   └──────────────────────────────────────────────────────┘
```

| Type | Layer | Use For | Azure Equivalent |
|---|---|---|---|
| **ALB** | 7 (HTTP/S) | Web apps, path/host routing, containers | Application Gateway |
| **NLB** | 4 (TCP/UDP) | Extreme perf, static IP, non-HTTP | Azure Load Balancer |
| **GWLB** | 3 | 3rd-party network appliances | Gateway Load Balancer |

---

## 20.3 Key Concepts

```
✅ TARGET GROUPS: the pool of targets (EC2/ECS/Lambda/IPs) the LB routes to;
   each has its own health check
✅ HEALTH CHECKS: unhealthy targets are removed from rotation automatically
✅ LISTENERS: define the port/protocol the LB listens on + routing rules
✅ ALB SSL termination: offload HTTPS decryption from backends
✅ ALB path/host routing: /api/* → one target group, /images/* → another
✅ Internet-facing vs Internal (like a public vs internal LB)
```

---

## 20.4 UI Steps

```
📍 Console → EC2 → Load Balancers → Create → choose ALB/NLB/GWLB
   → listeners (e.g., HTTPS:443) → target group (EC2/ECS/Lambda) +
   health check → (ALB) add path/host routing rules → Create
📍 CLI: aws elbv2 create-load-balancer / create-target-group / create-listener
```

---

## 20.5 Real-World Example

```
E-commerce platform:
   • ALB (internet-facing) routes by path:
       /api/* → API target group (ECS)
       /images/* → static target group (S3 via CloudFront, or EC2)
       /* → web target group
     with SSL termination (ACM cert) + WAF attached.
   • Internal NLB in front of a payment service that needs a STATIC IP
     for the payment provider's allow-list + preserved source IP.
   • Health checks remove unhealthy targets automatically; the ALB works
     with ECS/Auto Scaling so new tasks/instances auto-register.
Result: smart L7 routing for web, extreme-performance L4 with static IP
for payments.
```

---

## 20.6 Interview Q&A

**Q: What are the ELB types and when do you use each?** → ALB (Layer 7, HTTP/HTTPS, path/host routing, SSL, WAF — for web apps/microservices), NLB (Layer 4, TCP/UDP, ultra-high performance, static IP, preserves source IP — for extreme perf/non-HTTP), GWLB (Layer 3, for third-party network appliances like firewalls). ALB≈Azure App Gateway, NLB≈Azure Load Balancer.
**Q: What's a target group?** → The pool of targets (EC2/ECS/Lambda/IPs) an LB routes to, each with its own health check; unhealthy targets are removed automatically.
**Q: What does SSL termination on an ALB do?** → The ALB decrypts HTTPS and forwards to backends (often over HTTP internally), offloading encryption work from backend servers.

## 20.7 Summary

AWS Elastic Load Balancing has three types: ALB (Layer 7 — path/host routing, SSL termination, WAF, for web apps/containers ≈ Azure App Gateway), NLB (Layer 4 — ultra-high performance, static IP, source-IP preservation ≈ Azure Load Balancer), and GWLB (Layer 3 — for third-party network appliances). All use target groups with health checks that remove unhealthy targets automatically and integrate with Auto Scaling/ECS for auto-registration. Choose ALB for smart HTTP routing, NLB for extreme performance/static IP.

---
---

# 21. 🛡️ AWS WAF & Shield
> 🟡 KNOW-THIS-MUCH

---

## 21.1 What Problem Does This Solve?

Public-facing apps face web attacks (SQLi, XSS) and DDoS floods. **AWS WAF** blocks common web attacks; **AWS Shield** mitigates DDoS.

> 💡 **If you know Azure:** WAF ≈ Azure WAF (on App Gateway/Front Door); Shield ≈ Azure DDoS Protection (Standard/Advanced ≈ Shield Standard/Advanced).

---

## 21.2 How They Work (Flow Diagram)

```
Internet traffic
   ↓
AWS SHIELD (DDoS mitigation — always-on at the network/transport layer)
   Standard: free, automatic on all AWS · Advanced: paid, enhanced + 24/7 team + cost protection
   ↓
AWS WAF (inspects HTTP requests against rules)
   • Managed Rule Groups (OWASP-style: SQLi, XSS, bad bots)
   • Custom rules (rate-limiting, IP allow/deny, geo-match)
   • BLOCKS malicious requests before they reach your app
   ↓ (attached to CloudFront, ALB, or API Gateway)
Your application
```

---

## 21.3 Key Facts

```
✅ WAF attaches to CloudFront, ALB, or API Gateway (Layer 7)
✅ WAF uses AWS Managed Rule Groups (common threats) + custom rules
   (rate-based rules to block bots/brute-force, IP/geo match)
✅ Shield Standard = free, automatic DDoS protection for all AWS customers
✅ Shield Advanced = paid; enhanced mitigation, attack visibility, cost
   protection (credits for scaling during attacks), and DDoS response team
```

---

## 21.4 UI Steps

```
📍 WAF: Console → WAF & Shield → Create web ACL → add managed rule groups
   + custom rules (e.g., rate-limit) → associate with CloudFront/ALB/API GW
📍 Shield: Console → WAF & Shield → Shield → (Advanced) subscribe + protect resources
```

---

## 21.5 Real-World Example

```
An e-commerce site under bot/SQLi probing:
   • WAF web ACL on the ALB: AWS Managed Rules (SQLi/XSS) in block mode +
     a rate-based custom rule blocking IPs over 1000 req/min → stops
     scrapers and brute-force before they reach the app.
   • Shield Standard is already protecting them for free; for the big
     sale they enable Shield Advanced for enhanced DDoS mitigation + cost
     protection.
```

---

## 21.6 Interview Q&A

**Q: WAF vs Shield?** → WAF inspects HTTP requests and blocks web attacks (SQLi/XSS, bots) via managed + custom rules, attached to CloudFront/ALB/API Gateway. Shield mitigates DDoS — Standard is free/automatic, Advanced is paid with enhanced mitigation, cost protection, and a response team. (≈ Azure WAF + DDoS Protection.)
**Q: How do you rate-limit or block bots?** → A WAF rate-based rule (block IPs exceeding a request threshold) plus managed bot-control rule groups.

## 21.7 Summary

AWS WAF blocks common web attacks (SQLi, XSS, bots) using managed + custom rules (including rate-limiting), attached to CloudFront/ALB/API Gateway. AWS Shield mitigates DDoS — Standard free/automatic, Advanced paid with enhanced mitigation, cost protection, and a response team. Together they protect public-facing apps at the network and application layers, equivalent to Azure WAF + DDoS Protection.

---
---

# 22. 🔥 AWS Network Firewall
> 🟡 KNOW-THIS-MUCH

---

## 22.1 What Problem Does This Solve?

Security Groups and NACLs are basic (IP/port). For centralized, managed, stateful network filtering across a VPC — including domain-based rules and intrusion prevention — you use **AWS Network Firewall**.

> 💡 **If you know Azure:** AWS Network Firewall ≈ Azure **Firewall** — a managed, centralized, stateful network firewall with capabilities beyond basic SG/NACL rules (domain filtering, IPS).

---

## 22.2 How It Works (Flow Diagram)

```
Traffic → (routed via a firewall subnet using route tables) →
   AWS NETWORK FIREWALL:
     • Stateful inspection (beyond SG/NACL)
     • Domain-name filtering (allow only *.approved.com)
     • Intrusion prevention (IPS/IDS signatures — Suricata-compatible rules)
     • Centralized, managed, HA
   → allowed traffic proceeds; denied/logged

Deployed in a dedicated firewall subnet; route tables force VPC traffic
through it (like forcing traffic through Azure Firewall via UDRs).
```

---

## 22.3 Key Facts

```
✅ Managed, stateful, highly available firewall for a VPC
✅ Domain-name (FQDN) filtering — SG/NACL can't do this
✅ Intrusion prevention (Suricata-compatible rule groups)
✅ Centralized egress/ingress inspection (often in a shared inspection VPC
   with Transit Gateway routing traffic through it)
✅ Deployed via firewall subnets + route table steering
```

---

## 22.4 UI Steps

```
📍 Console → VPC → Network Firewall → Create firewall → firewall subnet(s)
   → firewall policy (stateful/stateless rule groups, domain lists, Suricata rules)
📍 Update route tables to steer traffic through the firewall endpoints
```

---

## 22.5 Real-World Example

```
A regulated company must inspect + restrict ALL egress from app VPCs:
   • A central inspection VPC has AWS Network Firewall.
   • Transit Gateway routes all app-VPC egress through the inspection VPC.
   • Firewall policy: allow only *.windowsupdate.com and the payment
     gateway domain; deny everything else; IPS rules block known threats.
   • All traffic logged for the compliance audit trail.
This mirrors using Azure Firewall in a hub for centralized egress control.
```

---

## 22.6 Interview Q&A

**Q: When would you use AWS Network Firewall over Security Groups/NACLs?** → When you need centralized, managed, stateful filtering with capabilities SG/NACL lack — domain-name (FQDN) filtering, intrusion prevention, and centralized egress inspection across VPCs (often via a Transit Gateway inspection VPC). SG/NACL remain for basic instance/subnet rules. (≈ Azure Firewall vs NSGs.)

## 22.7 Summary

AWS Network Firewall is a managed, centralized, stateful VPC firewall offering domain-name filtering and intrusion prevention beyond basic Security Groups/NACLs — typically deployed in an inspection VPC with Transit Gateway steering traffic through it for centralized, auditable egress/ingress control. It's the AWS equivalent of Azure Firewall; use SG/NACL for basic rules and Network Firewall for centralized advanced filtering.

---
---

# 23. 🔍 VPC Flow Logs & Reachability Analyzer
> 🟡 KNOW-THIS-MUCH

---

## 23.1 What Problem Does This Solve?

When connectivity fails ("my app can't reach the database"), or for security/audit, you need visibility into network traffic and a way to diagnose *where* traffic is blocked. **VPC Flow Logs** record traffic; **Reachability Analyzer** diagnoses paths. Relevant to the JD's "troubleshoot end-to-end."

> 💡 **If you know Azure:** Flow Logs ≈ Azure **NSG Flow Logs**; Reachability Analyzer ≈ Azure **Network Watcher** (IP Flow Verify / Connection Troubleshoot). Same troubleshooting purpose.

---

## 23.2 The Two Tools (Flow Diagram)

```
VPC FLOW LOGS — record traffic (for analysis/security/audit):
   captures accepted/rejected traffic at VPC/subnet/ENI level →
   sent to CloudWatch Logs or S3 → query to spot unexpected flows,
   troubleshoot, or audit.

REACHABILITY ANALYZER — diagnose a specific path:
   "can source X reach destination Y on port Z?" → analyzes the
   configuration (SGs, NACLs, route tables) → tells you REACHABLE or
   NOT, and WHICH component blocks it (e.g., "blocked by NACL / missing
   route / SG"). Instant root cause without sending real traffic.
```

---

## 23.3 Key Facts

```
✅ Flow Logs: accepted/rejected traffic records → CloudWatch Logs or S3
   (query with CloudWatch Logs Insights or Athena)
✅ Reachability Analyzer: config-based path analysis → pinpoints the exact
   blocking component (SG, NACL, route table) — the go-to for "why can't
   X reach Y?"
✅ Both are core to network troubleshooting and security investigation
```

---

## 23.4 UI Steps

```
📍 Flow Logs: VPC → select VPC/subnet/ENI → Flow logs → Create → destination
   (CloudWatch Logs / S3)
📍 Reachability Analyzer: VPC → Reachability Analyzer → Create path
   → source + destination + port → Analyze → REACHABLE / NOT + blocking component
```

---

## 23.5 Real-World Example

```
"The new app server can't connect to the RDS database" — diagnose fast:
   1. Reachability Analyzer: source = app EC2, destination = RDS ENI,
      port 5432 → result: "Not reachable — blocked by the DB security
      group (no inbound rule from the app SG)."
   2. Fix: add an inbound rule on db-SG allowing 5432 from app-SG.
   3. Re-run → "Reachable." Confirmed in minutes, no guessing.
   Flow Logs separately show a pattern of rejected traffic if something
   is being blocked repeatedly (security/audit).
```

---

## 23.6 Interview Q&A

**Q: How do you troubleshoot "app can't reach the database" in AWS?** → Use Reachability Analyzer — specify source, destination, and port; it analyzes the SGs, NACLs, and route tables and tells you whether it's reachable and exactly which component blocks it. VPC Flow Logs additionally record accepted/rejected traffic for pattern analysis and audit. (≈ Azure Network Watcher IP Flow Verify + NSG Flow Logs.)
**Q: Where do Flow Logs go?** → CloudWatch Logs or S3, queried with Logs Insights or Athena.

## 23.7 Summary

VPC Flow Logs record accepted/rejected network traffic (to CloudWatch Logs or S3) for analysis, security, and audit; Reachability Analyzer diagnoses a specific source→destination path by analyzing SGs/NACLs/route tables and pinpointing the exact blocking component — the fast way to answer "why can't X reach Y?" Together they're the core AWS network troubleshooting toolkit, equivalent to Azure NSG Flow Logs + Network Watcher.

---
---

# 24. 🔐 Site-to-Site VPN & Direct Connect
> 🟡 KNOW-THIS-MUCH

---

## 24.1 What Problem Does This Solve?

Organizations need to connect on-premises data centers to AWS. **Site-to-Site VPN** does it over the encrypted internet; **Direct Connect** provides a dedicated private connection bypassing the internet.

> 💡 **If you know Azure:** Site-to-Site VPN ≈ Azure **VPN Gateway**; Direct Connect ≈ Azure **ExpressRoute**. Same trade-offs: VPN is cheaper/quicker over the internet; the dedicated option is faster/more consistent/compliance-friendly.

---

## 24.2 The Two Options (Flow Diagram)

```
SITE-TO-SITE VPN:
   On-prem ⇄ (encrypted IPsec tunnel over the PUBLIC INTERNET) ⇄ AWS
             (via a Virtual Private Gateway or Transit Gateway)
   • Cheaper, quick to set up · variable internet performance · often a backup

DIRECT CONNECT (DX):
   On-prem ⇄ (dedicated PRIVATE fiber via a DX partner, NOT the internet) ⇄ AWS
   • Consistent low latency, high bandwidth · pricier, longer to provision ·
     needed for compliance (traffic off the public internet)
```

---

## 24.3 Key Facts

```
✅ Site-to-Site VPN: IPsec over the internet; terminates at a Virtual
   Private Gateway (per-VPC) or a Transit Gateway (many VPCs)
✅ Direct Connect: dedicated private connection via a partner; consistent
   performance; often paired WITH a VPN as an encrypted backup
✅ Both can connect to a Transit Gateway to serve many VPCs at once
✅ DX Gateway lets one Direct Connect reach VPCs in multiple regions
```

---

## 24.4 UI Steps

```
📍 VPN: VPC → Virtual Private Gateways (or attach to a TGW) → Site-to-Site
   VPN Connections → Create (customer gateway = your on-prem device)
📍 Direct Connect: Console → Direct Connect → Create connection (via a
   partner/location) → create a virtual interface → associate with a
   VGW / DX Gateway / Transit Gateway
```

---

## 24.5 Real-World Example

```
A bank with hybrid workloads (core on-prem, analytics on AWS), strict
compliance (data off the public internet) + low-latency needs:
   • Direct Connect (dedicated private fiber) from the data center to AWS
     → consistent sub-ms-ish latency, traffic never on the public internet.
   • A Site-to-Site VPN configured as an encrypted BACKUP → if DX fails,
     traffic fails over to the VPN.
   • Both terminate at a Transit Gateway → all VPCs reach on-prem.
Mirrors Azure ExpressRoute + VPN Gateway backup.
```

---

## 24.6 Interview Q&A

**Q: Site-to-Site VPN vs Direct Connect?** → VPN is an encrypted IPsec tunnel over the public internet (cheaper, quick, variable performance); Direct Connect is a dedicated private fiber connection via a partner (consistent low latency, high bandwidth, compliance-friendly, but pricier/slower to provision). Use DX for high-performance/regulated hybrid workloads, often with a VPN as backup. (≈ Azure ExpressRoute vs VPN Gateway.)
**Q: How do you serve many VPCs from one on-prem connection?** → Terminate the VPN/Direct Connect at a Transit Gateway, which routes to all attached VPCs.

## 24.7 Summary

Site-to-Site VPN connects on-premises to AWS via an encrypted tunnel over the internet (cheaper/quicker, variable performance), while Direct Connect provides a dedicated private connection bypassing the internet (consistent, high-bandwidth, compliance-friendly). Both can terminate at a Transit Gateway to serve many VPCs, and DX is often paired with a VPN backup. Equivalent to Azure VPN Gateway and ExpressRoute respectively.

---

---
---

# 25. 🔐 AWS KMS (Key Management Service)
> 🔴 FULL

---

## 25.1 What Problem Does This Solve?

Data must be encrypted at rest — but you need to manage the encryption *keys* securely (create, rotate, control access, audit). **AWS KMS** is the managed service for creating and controlling the cryptographic keys that encrypt your data across nearly every AWS service.

> 💡 **If you know Azure:** KMS is the AWS equivalent of the **keys** part of Azure **Key Vault** (Azure Key Vault also stores secrets/certs; in AWS those are separate services — Secrets Manager/Parameter Store for secrets, ACM for certs). So Azure Key Vault ≈ KMS + Secrets Manager + ACM combined.

---

## 25.2 How KMS Works (Flow Diagram)

```
KMS creates & manages KMS Keys (formerly CMKs). Almost every AWS service
integrates with KMS for encryption at rest:

   S3 / EBS / RDS / DynamoDB / Secrets Manager / etc.
        ↓ "encrypt this data with KMS key X"
   KMS uses the key (which NEVER leaves KMS) to encrypt/decrypt
        ↓
   Access to USE the key is controlled by a KMS KEY POLICY + IAM
   Every use is logged in CloudTrail (audit)

Envelope encryption: KMS encrypts a data key, which encrypts your data —
efficient for large data (you don't send big data to KMS).
```

---

## 25.3 Key Concepts

| Concept | What It Is |
|---|---|
| **KMS Key** | The managed encryption key (symmetric or asymmetric); never leaves KMS |
| **AWS-managed keys** | Auto-created/managed by a service (e.g., `aws/s3`) — simplest |
| **Customer-managed keys (CMK)** | You create/control — custom policies, rotation, cross-account |
| **Key Policy** | Resource policy on the key defining who can use/manage it (in addition to IAM) |
| **Envelope encryption** | KMS encrypts a data key → the data key encrypts the actual data (efficient) |
| **Automatic rotation** | KMS can auto-rotate customer-managed keys annually |

---

## 25.4 Key Facts

```
✅ Integrated with almost all AWS services for encryption at rest (S3, EBS,
   RDS, DynamoDB, Secrets Manager, etc.) — often just "enable encryption + pick a key"
✅ The key material NEVER leaves KMS (or CloudHSM for the highest assurance)
✅ Access controlled by KMS KEY POLICY + IAM (both evaluated)
✅ Every key use is logged in CloudTrail → full audit trail
✅ Customer-managed keys allow custom access, rotation, and cross-account sharing
✅ Envelope encryption makes encrypting large data efficient
```

---

## 25.5 UI Steps

```
📍 Console → KMS → Create key → symmetric → set key admins + key users
   (who can manage vs use it) → enable automatic rotation
📍 Use it: when enabling encryption on S3/EBS/RDS/etc., select this KMS key
📍 CLI: aws kms create-key / encrypt / decrypt / enable-key-rotation
```

---

## 25.6 Real-World Example

```
A regulated app must encrypt everything with keys the security team
controls and audits:
   • Create a customer-managed KMS key with a key policy: only the app's
     IAM role can USE it, only security admins can MANAGE it.
   • Enable it on: S3 buckets (SSE-KMS), EBS volumes, the RDS database,
     and Secrets Manager secrets.
   • Enable automatic annual rotation.
   • Every encrypt/decrypt is logged in CloudTrail → auditors see exactly
     who used the key and when.
Result: centralized, audited, access-controlled encryption across all
data at rest — the AWS parallel to using Azure Key Vault customer-managed
keys.
```

---

## 25.7 Interview Q&A

**Q: What is KMS and what does it do?**
> AWS's managed service for creating and controlling encryption keys used to encrypt data at rest across nearly all AWS services. The key material never leaves KMS, access is controlled by a key policy plus IAM, and every use is logged in CloudTrail. It's the "keys" part of what Azure Key Vault does.

**Q: AWS-managed vs customer-managed keys?**
> AWS-managed keys are auto-created and managed by a service (simplest, e.g., `aws/s3`). Customer-managed keys (CMKs) are ones you create and control — with custom key policies, automatic annual rotation, and cross-account sharing — used when you need control/auditability for compliance.

**Q: What is envelope encryption?**
> KMS encrypts a small "data key," and that data key encrypts your actual data. This is efficient for large data because you never send the bulk data to KMS — only the data key is protected by the KMS key.

## 25.8 Summary

AWS KMS creates and controls the encryption keys that protect data at rest across nearly every AWS service, with key material that never leaves KMS, access governed by key policies + IAM, and full CloudTrail auditing. Use customer-managed keys with automatic rotation for compliance-controlled encryption, and understand envelope encryption (KMS encrypts a data key that encrypts the data) for efficiency. KMS is the "keys" component of what Azure bundles into Key Vault (which also does secrets/certs — handled by Secrets Manager/ACM in AWS).

---
---

# 26. 🔑 Secrets Manager vs Parameter Store
> 🔴 FULL

---

## 26.1 What Problem Does This Solve?

Apps need secrets (DB passwords, API keys) and config values — never hardcoded. AWS offers **two** services: **Secrets Manager** (purpose-built for secrets, with rotation) and **Systems Manager Parameter Store** (config + secrets, cheaper/simpler). Knowing when to use each is a common interview question.

> 💡 **If you know Azure:** Both together cover what Azure **Key Vault** does for secrets. Secrets Manager ≈ Key Vault secrets *with automatic rotation*; Parameter Store ≈ Key Vault secrets + App Configuration (config values), lighter and cheaper. Retrieved via IAM roles at runtime, like Key Vault via Managed Identity.

---

## 26.2 The Two Services (Flow Diagram)

```
App (with an IAM role — no stored creds) → retrieves at runtime:

SECRETS MANAGER:
   • Purpose-built for SECRETS (DB creds, API keys)
   • BUILT-IN AUTOMATIC ROTATION (e.g., rotate an RDS password on a schedule)
   • Encrypted with KMS · costs per secret + per API call
   → use when you need rotation / it's a true secret

PARAMETER STORE (AWS Systems Manager):
   • Stores CONFIG values AND secrets (SecureString type, KMS-encrypted)
   • Standard tier is FREE · no built-in rotation (DIY)
   • Hierarchical paths (/myapp/prod/db-password)
   → use for config + simple secrets where rotation isn't needed (cheaper)
```

---

## 26.3 Secrets Manager vs Parameter Store (Comparison)

| | Secrets Manager | Parameter Store (SSM) |
|---|---|---|
| Purpose | Secrets | Config + secrets |
| Automatic rotation | ✅ Built-in | ❌ (DIY via Lambda) |
| Cost | Per secret + per API call | Standard tier free |
| Encryption | KMS | KMS (SecureString) |
| RDS integration | Native rotation | No |
| Best for | Rotating secrets, DB creds | Config values, simple/cheap secrets |

**Interview rule of thumb:** need rotation or it's a sensitive credential → **Secrets Manager**. Config values or simple secrets on a budget → **Parameter Store**.

---

## 26.4 The Secure Retrieval Pattern (No Hardcoding)

```
App runs with an IAM ROLE (Section 5) → the role has permission to read
the specific secret/parameter → app fetches it at runtime via the SDK
→ NEVER hardcoded in code, config, or environment files.

   secretsmanager:GetSecretValue    (Secrets Manager)
   ssm:GetParameter (WithDecryption) (Parameter Store SecureString)

Same principle as Azure: identity (IAM role ≈ Managed Identity) →
permission → fetch at runtime → nothing stored.
```

---

## 26.5 UI Steps

```
── Secrets Manager ──
📍 Console → Secrets Manager → Store a new secret → type (e.g., RDS creds)
   → set automatic rotation (schedule + rotation Lambda) → name (/myapp/prod/db)
   → grant the app's IAM role secretsmanager:GetSecretValue

── Parameter Store ──
📍 Console → Systems Manager → Parameter Store → Create parameter
   → name (/myapp/prod/db-password) → type SecureString (KMS-encrypted)
   → grant the app's IAM role ssm:GetParameter
```

---

## 26.6 Real-World Example

```
A web app needs an RDS password (must rotate for compliance) and several
non-sensitive config values (feature toggles, endpoints):
   • RDS password → SECRETS MANAGER with automatic rotation every 30 days
     (native RDS rotation) — the app fetches it at runtime via its IAM role.
   • Config values (endpoints, non-sensitive toggles) → PARAMETER STORE
     Standard tier (free) under /myapp/prod/* — fetched via the same role.
Nothing is hardcoded; the IAM role scopes access to only these specific
secrets/parameters. This mirrors using Azure Key Vault (rotating secrets)
+ App Configuration (config values).
```

---

## 26.7 Interview Q&A

**Q: Secrets Manager vs Parameter Store — when do you use each?**
> Secrets Manager is purpose-built for secrets with built-in automatic rotation (e.g., native RDS password rotation) — use it when you need rotation or for sensitive credentials, at a per-secret cost. Parameter Store stores config values and secrets (SecureString, KMS-encrypted) with a free standard tier but no built-in rotation — use it for configuration and simple/cheap secrets. Rule of thumb: rotation needed → Secrets Manager; config/simple/budget → Parameter Store.

**Q: How does an app retrieve a secret without hardcoding it?**
> The app runs with an IAM role that has permission to read the specific secret/parameter, and fetches it at runtime via the SDK (`GetSecretValue` / `GetParameter WithDecryption`). Nothing is stored in code or config — the same identity→permission→runtime-fetch pattern as Azure Key Vault + Managed Identity.

**Q: How do these relate to Azure?**
> Together they cover what Azure Key Vault does for secrets: Secrets Manager ≈ Key Vault secrets with rotation; Parameter Store ≈ Key Vault secrets + App Configuration (config), lighter and cheaper.

## 26.8 Summary

AWS offers two secrets/config services: Secrets Manager (purpose-built for secrets, with built-in automatic rotation — including native RDS rotation — at a per-secret cost) and Systems Manager Parameter Store (config values + KMS-encrypted SecureString secrets, free standard tier, no built-in rotation). Choose Secrets Manager when you need rotation or for sensitive credentials, Parameter Store for config and simple/cheap secrets. Both are retrieved at runtime via an IAM role (never hardcoded), together covering what Azure Key Vault + App Configuration do.

---
---

# 27. 🔗 Secrets Integration (with Services)
> 🔴 FULL

---

## 27.1 What Problem Does This Solve?

Storing a secret is only half the job — the real value is how services *consume* secrets securely at runtime: how EC2, Lambda, ECS, and EKS retrieve them from Secrets Manager/Parameter Store without hardcoding. This section covers those integration flows (the CI/CD-tool integrations are Sections 29–30).

> 💡 **If you know Azure:** This mirrors the Azure "Key Vault Integrations" section (Managed Identity + apps, AKS CSI driver, etc.). Same unifying pattern: identity (IAM role) → permission → fetch secret at runtime → nothing stored.

---

## 27.2 The Integration Flows (Flow Diagram)

```
EC2 / Lambda / ECS  → assume their IAM ROLE → GetSecretValue/GetParameter
                      → secret at runtime (no hardcoding)

ECS task → "secrets" in the task definition pull from Secrets Manager/
           Parameter Store → injected as env vars into the container
           (the ECS task EXECUTION role fetches them)

EKS pod → IRSA (IAM Role for Service Account) + the AWS Secrets & Config
          Provider (ASCP) for the Secrets Store CSI Driver → mounts the
          secret into the pod as a file (like Azure's Key Vault CSI driver)

RDS → Secrets Manager NATIVE rotation → app always reads the current
      password from Secrets Manager (rotation is transparent)

Lambda → its execution role → GetSecretValue (or use the Parameters and
         Secrets Lambda Extension for caching)
```

---

## 27.3 The Unifying Pattern (Say This in the Interview)

```
Every secrets integration follows the SAME pattern:

   IDENTITY (IAM role — EC2 role / Lambda exec role / ECS task role /
             EKS IRSA)
      → PERMISSION (secretsmanager:GetSecretValue / ssm:GetParameter)
      → FETCH the secret at RUNTIME
      → NOTHING stored in code, image, or config

This is the AWS mirror of Azure's "identity → Entra ID → RBAC → Key Vault,
no stored credentials." Here it's "IAM role → permission → Secrets Manager/
Parameter Store, no stored credentials."
```

---

## 27.4 ECS & EKS Specifics

```
ECS: in the task definition, reference secrets by ARN under "secrets" →
     ECS injects them as environment variables into the container at
     launch (the task execution role needs GetSecretValue). No secret in
     the image.

EKS: use IRSA to give a pod's service account an IAM role, then the
     Secrets Store CSI Driver (with the AWS provider) mounts secrets from
     Secrets Manager/Parameter Store into the pod as files. Directly
     analogous to Azure's Workload Identity + Key Vault CSI driver.
```

---

## 27.5 UI/Config Steps

```
📍 ECS: task definition → "Secrets" → key + valueFrom = secret ARN;
   ensure the task execution role has secretsmanager:GetSecretValue
📍 EKS: enable the Secrets Store CSI Driver + AWS provider add-on →
   set up IRSA for the pod's service account → define a SecretProviderClass
   → pods mount the secret as a file
📍 EC2/Lambda: attach an IAM role with GetSecretValue/GetParameter →
   fetch via the SDK at runtime
```

---

## 27.6 Real-World Example

```
A containerized app: pipeline builds it (secrets for the build come via
CI — Section 30), and at RUNTIME:
   • On ECS Fargate: the task definition references the DB password by
     ARN → ECS injects it as an env var via the task execution role.
   • On EKS: IRSA + the Secrets Store CSI Driver mounts the DB password
     from Secrets Manager as a file in the pod.
   • The RDS password itself rotates automatically via Secrets Manager,
     transparently to the app.
No secret ever lives in the container image, the Kubernetes YAML, or Git
— only in Secrets Manager, fetched at runtime via an IAM identity. This
is the AWS equivalent of the Azure Key Vault + AKS CSI driver flow.
```

---

## 27.7 Interview Q&A

**Q: How does a containerized app get secrets securely at runtime on AWS?**
> On ECS, the task definition references the secret by ARN and ECS injects it as an environment variable (via the task execution role). On EKS, IRSA gives the pod's service account an IAM role and the Secrets Store CSI Driver mounts the secret from Secrets Manager/Parameter Store as a file. In both cases the secret never lives in the image or YAML — it's fetched at runtime via an IAM identity, mirroring Azure's Key Vault CSI driver + Workload Identity.

**Q: What's the unifying pattern for AWS secrets integration?**
> IAM role (EC2/Lambda/ECS task/EKS IRSA) → permission to read the specific secret → fetch at runtime via the SDK/CSI → nothing stored in code, image, or config. It's the AWS mirror of Azure's identity→RBAC→Key Vault with no stored credentials.

**Q: How does RDS password rotation stay transparent to the app?**
> Secrets Manager's native RDS rotation updates the password in Secrets Manager on a schedule; the app always reads the current value from Secrets Manager at runtime, so it never needs a redeploy or manual update when the password rotates.

## 27.8 Summary

Secrets integration is about how services consume secrets securely at runtime: EC2/Lambda via their IAM role, ECS via task-definition secret references (injected as env vars), EKS via IRSA + the Secrets Store CSI Driver (mounted as files), and RDS via transparent Secrets Manager rotation. Every flow follows the same pattern — IAM role → permission → runtime fetch → nothing stored — the AWS mirror of Azure's Key Vault integrations. This ensures no secret ever lives in code, container images, or Git.

---
---

# 28. 🛠️ AWS-Native CI/CD (CodeCommit / CodeBuild / CodeDeploy / CodePipeline)
> 🟡 KNOW-THIS-MUCH

---

## 28.1 What Problem Does This Solve?

AWS has its own native CI/CD suite. You'll likely use external tools (which you know — Azure DevOps/Jenkins/Bitbucket), but you should recognize the AWS-native services and how they fit together.

> 💡 **If you know Azure:** This suite ≈ Azure DevOps's Pipelines/Repos, split into separate services. CodeCommit ≈ Azure Repos, CodeBuild ≈ the build agent, CodeDeploy ≈ the deployment mechanism, CodePipeline ≈ the pipeline orchestrator tying them together.

---

## 28.2 The Four Services (Flow Diagram)

```
CodeCommit (Git repo) → CodeBuild (build & test) → CodeDeploy (deploy) 
                    all orchestrated by → CodePipeline (the workflow)

CodeCommit  = managed Git repositories (≈ Azure Repos) [being de-emphasized;
              many use GitHub/Bitbucket instead]
CodeBuild   = managed build service; config in a buildspec.yml
CodeDeploy  = automates deployments to EC2/ECS/Lambda; config in appspec.yml;
              supports in-place, blue/green, canary/linear
CodePipeline= orchestrates stages (source → build → deploy) with approvals
```

---

## 28.3 Key Config Files

| File | Service | Purpose |
|---|---|---|
| **buildspec.yml** | CodeBuild | Defines build phases (install/build/test) + artifacts (≈ Azure YAML build steps) |
| **appspec.yml** | CodeDeploy | Defines how to deploy (hooks, target, traffic shifting) |

---

## 28.4 Steps (High-Level)

```
📍 CodePipeline console → Create pipeline → Source (CodeCommit/GitHub/S3)
   → Build (CodeBuild + buildspec.yml) → Deploy (CodeDeploy + appspec.yml
   to EC2/ECS/Lambda) → add manual approval actions as needed
```

---

## 28.5 Real-World Example

```
A team using AWS-native CI/CD:
   Source: GitHub → CodePipeline triggers on push
   Build:  CodeBuild runs buildspec.yml (npm test, docker build, push to ECR)
   Deploy: CodeDeploy (appspec.yml) does a blue/green deploy to ECS,
           with a manual approval action before prod.
(Many orgs instead use GitHub Actions or Jenkins for CI and just use
CodeDeploy/CodePipeline for the AWS deploy portion — mix-and-match.)
```

---

## 28.6 Interview Q&A

**Q: What are the AWS-native CI/CD services?**
> CodeCommit (managed Git repos ≈ Azure Repos), CodeBuild (managed build, configured via buildspec.yml), CodeDeploy (automated deployments to EC2/ECS/Lambda with blue/green and canary support, via appspec.yml), and CodePipeline (orchestrates source→build→deploy stages with approvals). Together they're roughly AWS's equivalent of Azure DevOps Pipelines, split into separate services.

**Q: What are buildspec.yml and appspec.yml?**
> buildspec.yml defines CodeBuild's build phases and output artifacts; appspec.yml defines how CodeDeploy performs a deployment (lifecycle hooks, target, traffic shifting).

## 28.7 Summary

AWS-native CI/CD is CodeCommit (Git repos), CodeBuild (build via buildspec.yml), CodeDeploy (deploy to EC2/ECS/Lambda via appspec.yml, with blue/green + canary), and CodePipeline (orchestration) — collectively AWS's answer to Azure DevOps Pipelines. Many teams mix these with external tools (GitHub Actions/Jenkins for CI, CodeDeploy for the AWS deploy step). Know the pieces and the two config files; the deep CI/CD value for your background is the external-tool integration in the next two sections.

---
---

# 29. 🔗 CI/CD Tool → AWS Authentication (Azure DevOps / Jenkins / Bitbucket / GitHub)
> 🔴 FULL

---

## 29.1 What Problem Does This Solve?

Your CI/CD tool (Azure DevOps, Jenkins, Bitbucket, GitHub Actions) runs outside AWS but must deploy into AWS. Each authenticates differently — and the modern answer for all is **OIDC / AssumeRole instead of long-lived IAM access keys.** This is your real-world experience and a strong interview differentiator.

> 💡 **If you know Azure:** This is the AWS equivalent of Service Connections + Workload Identity Federation. In Azure the pipeline authenticates to Entra ID and gets RBAC; in AWS it authenticates to IAM and assumes an IAM Role (ideally via OIDC — the direct parallel to Azure WIF).

---

## 29.2 The Core Choice: Keys vs AssumeRole vs OIDC (Flow Diagram)

```
❌ WORST — long-lived IAM access keys stored in the CI tool (leak/rotate risk)
🟠 BETTER — AssumeRole: base identity → sts:AssumeRole → short-lived creds
✅ BEST — OIDC: CI tool's OIDC token → sts:AssumeRoleWithWebIdentity →
          short-lived creds, NOTHING stored, nothing to leak or rotate

All ultimately get TEMPORARY credentials from AWS STS. The IAM role's
policies (least privilege) determine what the pipeline can do.
```

**Interview gold:** "How should CI/CD authenticate to AWS?" → **"OIDC federation — an IAM OIDC provider trusting the CI tool, and the pipeline assumes a scoped IAM role via AssumeRoleWithWebIdentity, getting short-lived creds with no stored keys."**

---

## 29.3 Tool 1 — GitHub Actions → AWS (OIDC, Gold Standard)

```
Setup: IAM OIDC provider for token.actions.githubusercontent.com + an IAM
role trust-scoped to repo/branch. Runtime: workflow assumes it via OIDC.
```
```yaml
permissions:
  id-token: write        # required for OIDC
  contents: read
steps:
  - uses: aws-actions/configure-aws-credentials@v4
    with:
      role-to-assume: arn:aws:iam::123456789012:role/github-deploy-role
      aws-region: ap-south-1        # role ARN is NOT a secret; no keys
```

---

## 29.4 Tool 2 — Azure DevOps → AWS (Your Experience)

```
Options (best → acceptable):
  1. OIDC / federated (newer AWS Toolkit for Azure DevOps) — no stored keys
  2. AssumeRole via an AWS Service Connection (base identity assumes a scoped role)
  3. IAM user access keys in an AWS Service Connection (long-lived; least preferred)

Install the "AWS Toolkit for Azure DevOps" → create an "AWS" Service
Connection → tasks (AWS CLI, AWS Shell Script, ECR Push) reference it by name.
```
```yaml
- task: AWSShellScript@1
  inputs:
    awsCredentials: 'aws-prod-connection'   # the AWS Service Connection
    regionName: 'ap-south-1'
    scriptType: 'inline'
    inlineScript: aws s3 ls
```
> 💡 **If you know Azure:** The AWS Service Connection in Azure DevOps is the mirror of the Azure Service Connection you'd use to deploy *to Azure* — same "named, secured cloud connection" concept, pointing at AWS.

---

## 29.5 Tool 3 — Jenkins → AWS (Your Experience)

```
Options (best → acceptable):
  1. IAM INSTANCE ROLE — if Jenkins runs on EC2, attach a role → Jenkins
     gets creds automatically from IMDS (NO stored keys; = Azure Managed Identity)
  2. OIDC plugin → AssumeRoleWithWebIdentity
  3. AssumeRole — base identity assumes scoped roles per job/account
  4. AWS Credentials plugin — IAM keys in Jenkins Credentials Store (least preferred)

Best: if Jenkins is on EC2/EKS, use the instance/pod role → no stored AWS keys.
```
```groovy
withCredentials([aws(credentialsId: 'aws-prod')]) {
  sh 'aws ecr get-login-password | docker login --username AWS --password-stdin <acct>.dkr.ecr...'
}
// BETTER: rely on the EC2 instance role → no credentials block at all
```
> 💡 **If you know Azure:** Jenkins-on-EC2 with an IAM instance role = Jenkins-on-an-Azure-VM with a Managed Identity — the host's identity provides creds automatically.

---

## 29.6 Tool 4 — Bitbucket Pipelines → AWS (Your Experience)

```
Options (best → acceptable):
  1. OIDC — Bitbucket has a built-in OIDC provider; IAM OIDC provider +
     scoped role → secretless AssumeRoleWithWebIdentity
  2. Repository/Workspace Variables — IAM keys as SECURED (masked) vars (least preferred)
```
```yaml
- step:
    oidc: true                      # enables the Bitbucket OIDC token
    script:
      - export AWS_ROLE_ARN=arn:aws:iam::123456789012:role/bitbucket-deploy
      - export AWS_WEB_IDENTITY_TOKEN_FILE=$(pwd)/web-identity-token
      - echo $BITBUCKET_STEP_OIDC_TOKEN > $AWS_WEB_IDENTITY_TOKEN_FILE
      - aws sts get-caller-identity   # authenticated via OIDC, no keys
```
> 💡 **If you know Azure:** Bitbucket → AWS via OIDC = any external CI → Azure via Workload Identity Federation — trust + short-lived tokens, no stored secret.

---

## 29.7 The Unifying Best Practice (Say This)

```
Regardless of tool (ADO / Jenkins / Bitbucket / GitHub):
   PREFER OIDC federation (or an instance/pod IAM role) → no stored keys,
          short-lived STS credentials
   SCOPE  the assumed IAM Role with least privilege (only needed actions,
          ideally per-account)
   AVOID  long-lived IAM access keys in the CI tool (leak + rotation risk)

Pattern: CI tool → (OIDC token / instance role / base identity) →
         STS AssumeRole → short-lived creds → scoped IAM Role → AWS
```

---

## 29.8 Real-World Example

```
An org runs pipelines across Azure DevOps (legacy), Jenkins, and
Bitbucket, all deploying to AWS — standardized on secretless auth:
   • Azure DevOps: AWS Service Connection → AssumeRole into a scoped
     "ado-deploy" role per target account.
   • Jenkins: on EC2 with an IAM instance role → jobs AssumeRole into
     per-account deploy roles → zero stored keys.
   • Bitbucket: built-in OIDC → IAM OIDC provider → scoped "bitbucket-
     deploy" role → zero stored keys.
   • GitHub Actions (new projects): OIDC → scoped role.
All assume least-privilege roles scoped per account. Result: no
long-lived AWS keys anywhere, short-lived STS creds throughout, limited
blast radius per pipeline.
```

---

## 29.9 Interview Q&A

**Q: How should a CI/CD pipeline authenticate to AWS securely?**
> Via OIDC federation (or an IAM instance/pod role if it runs on AWS) — an IAM OIDC provider trusts the CI tool, and the pipeline assumes a least-privilege IAM role via AssumeRoleWithWebIdentity for short-lived STS credentials. This avoids storing long-lived IAM access keys, which can leak and need manual rotation.

**Q: You've used Azure DevOps, Jenkins, and Bitbucket with AWS — how did each authenticate?**
> Azure DevOps via the AWS Toolkit's AWS Service Connection (ideally assuming a scoped role, or OIDC on newer versions); Jenkins via an IAM instance role when on EC2 (no stored keys) or the AWS Credentials plugin otherwise; Bitbucket via its built-in OIDC provider assuming a scoped IAM role. In all cases the goal was short-lived credentials and least-privilege roles rather than stored keys.

**Q: Why OIDC over stored access keys?**
> OIDC produces short-lived credentials via a trust scoped to a specific repo/branch/pipeline — nothing to leak or rotate. Stored keys are long-lived, can be accidentally committed or logged, and grant access until manually rotated.

**Q: What AWS API issues the temporary credentials?**
> AWS STS — `sts:AssumeRole` (from a base identity) or `sts:AssumeRoleWithWebIdentity` (the OIDC/federated path). Both return temporary, scoped credentials.

## 29.10 Summary

Every external CI/CD tool authenticates to AWS by obtaining short-lived credentials from STS AssumeRole — the best path being OIDC federation (no stored keys) or an IAM instance/pod role when running on AWS. Azure DevOps uses an AWS Service Connection, Jenkins an IAM instance role or credentials plugin, Bitbucket built-in OIDC, and GitHub Actions OIDC via configure-aws-credentials. The universal best practice: **prefer OIDC/AssumeRole over long-lived keys, scope the role least-privilege.** This mirrors Azure's Service Connection + Workload Identity Federation model.

---
---

# 30. 🔐 CI/CD Secrets & Security Integration (Azure DevOps / Jenkins / Bitbucket / GitHub)
> 🔴 FULL

---

## 30.1 What Problem Does This Solve?

Beyond authenticating to AWS (Section 29), pipelines need to handle **secrets** (DB passwords, API keys) and follow security practices while deploying — without hardcoding or leaking anything. This section covers how each CI/CD tool you've used securely handles secrets when deploying to AWS.

> 💡 **If you know Azure:** This mirrors the Azure "pipeline secrets" story (Variable Groups + Key Vault, masked variables). The AWS twist: pull from **Secrets Manager/Parameter Store** at runtime via the tool's AWS auth (ideally OIDC role), and prefer OIDC over stored keys entirely.

---

## 30.2 The Golden Rules (Flow Diagram)

```
For ANY CI/CD tool deploying to AWS:

1. NEVER hardcode secrets in the pipeline definition or repo
2. Prefer OIDC/AssumeRole (Section 29) so there are no stored AWS keys
3. Pull app secrets at runtime from Secrets Manager / Parameter Store
   (via the pipeline's assumed IAM role) — don't store them in the CI tool
4. Where the CI tool must hold a value, use its ENCRYPTED/MASKED secret
   store (never plaintext), and mask it in logs
5. Least-privilege deploy role · secret scanning · rotation · KMS encryption

Best-of-all: the pipeline assumes an IAM role via OIDC, and that role can
read the needed secrets from Secrets Manager → no secrets stored in the
CI tool at all.
```

---

## 30.3 Tool 1 — Azure DevOps: Secrets when Deploying to AWS

```
✅ Best: pipeline uses an AWS Service Connection (assume-role/OIDC) →
   the assumed IAM role reads app secrets from Secrets Manager/Parameter
   Store at runtime → nothing stored in Azure DevOps.
✅ For Azure-side secrets: Variable Groups LINKED to Azure Key Vault
   (masked in logs) — e.g., if the pipeline also touches Azure resources.
✅ Secure Files for certs/keyfiles; secret pipeline variables (masked).
⚠️ Avoid storing long-lived AWS keys in the Service Connection.
```
```yaml
- task: AWSShellScript@1
  inputs:
    awsCredentials: 'aws-prod-connection'   # OIDC/assume-role, no stored keys
    inlineScript: |
      DB_PASS=$(aws secretsmanager get-secret-value --secret-id /myapp/prod/db --query SecretString --output text)
      # DB_PASS fetched at runtime from Secrets Manager — never hardcoded
```

---

## 30.4 Tool 2 — Jenkins: Secrets when Deploying to AWS

```
✅ Best: Jenkins on EC2 with an IAM instance role → jobs read secrets from
   Secrets Manager/Parameter Store at runtime → no secrets in Jenkins.
✅ Jenkins Credentials Store for anything Jenkins must hold (encrypted,
   referenced by ID, never in the Jenkinsfile).
✅ HashiCorp Vault plugin — many orgs use Vault as a central secret store,
   Jenkins pulls from it dynamically.
✅ Mask secrets in console output (Mask Passwords plugin / withCredentials).
⚠️ Avoid plaintext secrets in the Jenkinsfile or job config.
```
```groovy
// Pull an app secret from AWS Secrets Manager at runtime (using the instance role)
sh '''
  DB_PASS=$(aws secretsmanager get-secret-value --secret-id /myapp/prod/db \
    --query SecretString --output text)
  ./deploy.sh   # DB_PASS available in-process, never printed or stored
'''
```

---

## 30.5 Tool 3 — Bitbucket Pipelines: Secrets when Deploying to AWS

```
✅ Best: OIDC (Section 29) → the assumed IAM role reads secrets from
   Secrets Manager/Parameter Store at runtime → no secrets in Bitbucket.
✅ Secured Repository/Workspace/Deployment VARIABLES for anything Bitbucket
   must hold — mark them "Secured" (masked in logs, not shown in the UI).
✅ Deployment environments (dev/staging/prod) can scope different secured
   variables per environment.
⚠️ Secured variables are still stored in Bitbucket — prefer OIDC + Secrets
   Manager for actual secrets where possible.
```
```yaml
- step:
    oidc: true
    deployment: production          # environment-scoped secured variables
    script:
      - # assume the AWS role via OIDC (Section 29), then:
      - DB_PASS=$(aws secretsmanager get-secret-value --secret-id /myapp/prod/db --query SecretString --output text)
```

---

## 30.6 Tool 4 — GitHub Actions: Secrets when Deploying to AWS

```
✅ Best: OIDC → assumed IAM role reads secrets from Secrets Manager at
   runtime → no AWS secrets in GitHub.
✅ GitHub Encrypted Secrets (repo/environment/org level) for values GitHub
   must hold — encrypted, masked in logs; environment secrets scope per env.
✅ GitHub Environments with required reviewers gate production secrets.
⚠️ Prefer OIDC + Secrets Manager over storing AWS keys as GitHub secrets.
```
```yaml
jobs:
  deploy:
    environment: production          # environment-scoped secrets + approvals
    permissions: { id-token: write, contents: read }
    steps:
      - uses: aws-actions/configure-aws-credentials@v4
        with: { role-to-assume: arn:aws:iam::...:role/gh-deploy, aws-region: ap-south-1 }
      - run: |
          DB_PASS=$(aws secretsmanager get-secret-value --secret-id /myapp/prod/db --query SecretString --output text)
```

---

## 30.7 Cross-Cutting Security Practices (All Tools)

```
✅ Least-privilege deploy ROLE — scope the assumed IAM role to only the
   actions/resources needed (per account/environment)
✅ Fetch app secrets from Secrets Manager/Parameter Store at RUNTIME,
   not stored in the CI tool
✅ Secret SCANNING in the pipeline (gitleaks, GitHub secret scanning,
   Bitbucket's, or a scan step) to catch accidental commits
✅ ROTATION — Secrets Manager rotates DB creds; pipelines always read the
   current value (no redeploy needed)
✅ KMS ENCRYPTION for secrets at rest; mask all secret values in logs
✅ ENVIRONMENT-SCOPED secrets + APPROVAL GATES before production
   (GitHub Environments / Bitbucket deployments / ADO environments)
```

---

## 30.8 Real-World Example

```
A company standardizes secret handling across ADO, Jenkins, Bitbucket,
and GitHub deploying to AWS:
   • All authenticate via OIDC/instance-role (Section 29) — no stored AWS keys.
   • App secrets (DB passwords, API keys) live ONLY in AWS Secrets Manager,
     fetched at runtime by the pipeline's assumed IAM role — never stored
     in any CI tool.
   • Each tool's native secret store (ADO Variable Groups, Jenkins
     Credentials, Bitbucket Secured Variables, GitHub Encrypted Secrets)
     holds only non-AWS values that must live there, always masked.
   • Secret scanning runs on every PR; production deploys require approval
     (environment gates); Secrets Manager rotates DB creds automatically.
Result: no hardcoded secrets, no stored AWS keys, least-privilege deploy
roles, and secrets centralized in Secrets Manager with rotation — a clean
DevSecOps posture across all four tools.
```

---

## 30.9 Interview Q&A

**Q: How do you handle secrets in a CI/CD pipeline deploying to AWS?**
> Never hardcode them. Authenticate the pipeline via OIDC/instance-role (no stored AWS keys), and have the pipeline's assumed IAM role fetch app secrets from Secrets Manager/Parameter Store at runtime — so secrets aren't stored in the CI tool at all. For values the tool must hold, use its encrypted/masked secret store (ADO Variable Groups + Key Vault, Jenkins Credentials Store, Bitbucket Secured Variables, GitHub Encrypted Secrets), scope the deploy role least-privilege, run secret scanning, and gate production with approvals.

**Q: You've used Jenkins and Bitbucket — how did you keep AWS secrets safe?**
> Jenkins: ran on EC2 with an IAM instance role (no stored AWS keys) and pulled app secrets from Secrets Manager at runtime, using the Credentials Store (referenced by ID, never in the Jenkinsfile) only for values Jenkins had to hold, with HashiCorp Vault where a central store was used. Bitbucket: used built-in OIDC to assume a scoped IAM role and fetched secrets from Secrets Manager at runtime, keeping only masked Secured Variables in Bitbucket and scoping them per deployment environment.

**Q: What's the single best pattern?**
> The pipeline assumes an IAM role via OIDC, and that least-privilege role reads the needed secrets from Secrets Manager/Parameter Store at runtime — so there are no stored AWS keys AND no stored app secrets in the CI tool, with rotation handled by Secrets Manager.

## 30.10 Summary

Secure CI/CD secret handling for AWS: authenticate via OIDC/instance-role (no stored AWS keys), fetch app secrets from Secrets Manager/Parameter Store at runtime via the assumed IAM role (not stored in the CI tool), and use each tool's encrypted/masked store (ADO Variable Groups + Key Vault, Jenkins Credentials Store/Vault, Bitbucket Secured Variables, GitHub Encrypted Secrets) only for values that must live there. Add secret scanning, least-privilege deploy roles, KMS encryption, rotation, and environment-scoped secrets with approval gates. The best pattern combines OIDC auth + runtime Secrets Manager retrieval — no stored keys and no stored secrets anywhere in the pipeline.

---
---

# 31. 📦 CodeArtifact & ECR
> 🟠 MEDIUM

---

## 31.1 What Problem Does This Solve?

Teams need private, secure registries for their **software packages** (npm, Maven, PyPI, NuGet) and **container images**. **CodeArtifact** hosts packages; **ECR (Elastic Container Registry)** hosts container images.

> 💡 **If you know Azure:** CodeArtifact ≈ Azure **Artifacts**; ECR ≈ Azure **Container Registry (ACR)**. Same purposes — private package feeds and private image registry.

---

## 31.2 The Two Registries (Flow Diagram)

```
CODEARTIFACT (package registry):
   Dev/CI publishes packages (npm/Maven/PyPI/NuGet) → CodeArtifact
   → other projects pull them as dependencies (proxies public registries too)
   ≈ Azure Artifacts

ECR (container image registry):
   build → docker push → ECR → ECS/EKS pulls the image via its IAM role
   • private, IAM-controlled access · image vulnerability SCANNING · lifecycle
     policies (auto-expire old images) · cross-region replication
   ≈ Azure Container Registry (ACR)
```

---

## 31.3 Key Facts

```
✅ ECR: ECS/EKS pull images via IAM roles (task role / node role) — no stored
   registry creds (like AKS pulling from ACR via Managed Identity)
✅ ECR image scanning (basic + enhanced via Inspector) flags CVEs
✅ ECR lifecycle policies auto-delete old/untagged images
✅ CodeArtifact proxies public registries (npmjs, Maven Central) → caches +
   lets you apply policies before packages reach developers
```

---

## 31.4 UI Steps

```
📍 ECR: Console → ECR → Create repository → enable "scan on push" →
   `aws ecr get-login-password | docker login ...` → docker push
📍 CodeArtifact: Console → CodeArtifact → Create domain + repository →
   configure npm/pip/maven to use it as the registry
```

---

## 31.5 Real-World Example

```
A microservices team:
   • ECR: each service's image pushed by CI (tagged with the build ID),
     scan-on-push enabled → EKS pulls images via IRSA/node role. Lifecycle
     policy keeps only the last 20 images per repo.
   • CodeArtifact: hosts their shared internal npm libraries; also proxies
     npmjs so all dependencies flow through one policy-controlled feed.
Mirrors using ACR (images) + Azure Artifacts (packages) on Azure.
```

---

## 31.6 Interview Q&A

**Q: What are CodeArtifact and ECR?** → CodeArtifact is a managed package registry (npm/Maven/PyPI/NuGet, proxies public registries) ≈ Azure Artifacts; ECR is a private container image registry with IAM-controlled access, vulnerability scanning, and lifecycle policies ≈ Azure ACR.
**Q: How does EKS/ECS pull from ECR securely?** → Via IAM roles (the ECS task/execution role or EKS IRSA/node role) — no stored registry credentials, just like AKS pulling from ACR via Managed Identity.

## 31.7 Summary

CodeArtifact is AWS's managed package registry (npm/Maven/PyPI/NuGet, with public-registry proxying) ≈ Azure Artifacts; ECR is the private container image registry with IAM-controlled access, image vulnerability scanning, and lifecycle policies ≈ Azure ACR. ECS/EKS pull ECR images via IAM roles (no stored creds). Together they secure the software supply chain — packages via CodeArtifact, images via ECR.

---
---

# 32. 🌿 Git Branching Strategies
> 🔴 FULL

---

## 32.1 What Problem Does This Solve?

How teams organize Git branches affects how smoothly code integrates and releases. This is cloud-agnostic and a common interview topic — trunk-based development is the modern favorite.

> 💡 **If you know Azure:** Identical to the Azure notes' branching section — Git branching is the same regardless of cloud or repo host (CodeCommit, GitHub, Bitbucket).

---

## 32.2 The Main Strategies (Flow Diagram)

```
TRUNK-BASED: everyone commits small/frequent to main; short-lived branches;
   feature flags hide incomplete work → min conflicts, main always releasable
   (modern CI/CD favorite)

GITHUB FLOW: main + short feature branches via PR (simple, continuous delivery)

GITFLOW: main / develop / release / feature / hotfix branches
   (structured, versioned releases, more merge overhead — falling out of favor)
```

**Feature flags** decouple deploy from release (deploy dark → enable later → rollback = flag flip), making trunk-based safe. On AWS, use **AWS AppConfig** for feature flags (Section 65).

---

## 32.3 Key Facts

```
✅ Trunk-based = small frequent commits to main + short branches + feature flags
✅ Branch PROTECTION (required reviews + passing CI) keeps main healthy —
   configured in the repo host (CodeCommit approval rules / GitHub / Bitbucket)
✅ Squash merge = clean single-commit history (popular for trunk-based)
✅ Match strategy to release cadence: trunk-based/GitHub Flow for fast CD,
   GitFlow for versioned/scheduled releases
```

---

## 32.4 Steps (Git + Repo Host)

```
📍 Trunk-based flow: short-lived branch → PR to main → branch protection
   runs CI + requires reviews → squash merge → deploy from main.
📍 Branch protection: GitHub/Bitbucket settings, or CodeCommit "Approval
   rule templates" (require approvals + a passing build before merge).
```

---

## 32.5 Real-World Example

```
A team moves from GitFlow to trunk-based:
   Before: weeks-long feature branches → painful merge conflicts.
   After: small commits to main daily; incomplete features behind AWS
   AppConfig feature flags; branch protection requires a passing CI build
   + 2 reviews before merge; every merge to main can auto-deploy.
Result: fewer conflicts, faster/safer releases, rollback = flag flip.
```

---

## 32.6 Interview Q&A

**Q: What is trunk-based development?** → Small, frequent commits to a single main branch with short-lived branches and feature flags to hide incomplete work — minimizing merge conflicts and keeping main always releasable, enabling continuous deployment. The modern CI/CD favorite.
**Q: How do feature flags help?** → They decouple deploying code from releasing a feature (deploy dark, enable gradually, disable instantly) — making trunk-based safe and turning rollback into a flag flip. On AWS, use AWS AppConfig.
**Q: GitFlow vs trunk-based?** → GitFlow's multiple long-lived branches suit versioned/scheduled releases but add merge overhead; trunk-based suits fast continuous delivery with minimal conflicts.

## 32.7 Summary

Git branching strategy shapes integration and release flow: trunk-based development (small frequent commits to main + short branches + feature flags via AWS AppConfig) is the modern CI/CD favorite because it minimizes conflicts and keeps main releasable; GitHub Flow is a simple middle ground; GitFlow suits versioned releases but adds overhead. Branch protection (required reviews + passing CI) enforces quality before merge. Identical concept across clouds and repo hosts.

---
---

# 33. 🚀 Multi-Account CI/CD & Deployment Promotion
> 🔴 FULL

---

## 33.1 What Problem Does This Solve?

Real orgs separate environments into different AWS accounts (dev/staging/prod) for isolation. CI/CD must deploy *across* these accounts securely, promoting the same artifact through each — a common senior-level interview and design topic.

> 💡 **If you know Azure:** This is the AWS multi-account version of the Azure multi-stage pipeline (Dev→QA→Staging→Prod). The AWS twist: environments are separate *accounts* (harder boundary than Azure subscriptions), so promotion requires *cross-account role assumption* (Section 6) — the pipeline assumes a deploy role in each target account.

---

## 33.2 The Promotion Flow (Flow Diagram)

```
Build ONCE (in a shared CI/CD or "tools" account) → promote the SAME
artifact across accounts:

   CI/CD account (pipeline)
        │ build artifact once (e.g., a container image in a shared ECR)
        ↓ assume cross-account deploy role (Section 6) in each target:
   dev account    → deploy + smoke tests (auto)
        ↓ assume role
   staging account → deploy + full tests (auto)
        ↓ assume role
   prod account   → deploy AFTER manual approval

⭐ Build once, deploy many: the SAME artifact flows through every account
   (never rebuilt) → prod = exactly what was tested.
⭐ The pipeline holds NO standing permissions in dev/staging/prod — it
   ASSUMES a scoped deploy role in each, with short-lived credentials.
```

---

## 33.3 How Cross-Account Deployment Works

```
Each target account (dev/staging/prod) has a "deploy-role" whose:
   • TRUST POLICY allows the CI/CD account to assume it
   • PERMISSION POLICY is scoped least-privilege (just deploy the app)

The pipeline (in the CI/CD account) calls sts:AssumeRole on each target's
deploy-role → gets short-lived creds → deploys → creds expire.

A shared ECR (in the tools account) holds the built image; target accounts
are granted pull access to it → the SAME image is deployed everywhere.

This is the multi-account realization of "build once, deploy many" +
cross-account role assumption (the two-sided trust from Section 6).
```

---

## 33.4 Key Facts

```
✅ Separate AWS accounts per environment = hard isolation (a dev mistake
   can't touch prod) — best practice
✅ A central CI/CD/"tools" account runs the pipeline, assuming scoped
   cross-account roles in each target (no standing prod access)
✅ Build the artifact ONCE (shared ECR/S3), promote the SAME artifact
✅ Manual approval gate before the prod account deploy (separation of duties)
✅ Cross-account trust = two-sided (target trusts CI account + CI identity
   permitted to assume) — Section 6
```

---

## 33.5 Steps (High-Level)

```
📍 In each target account: create a "deploy-role" trusting the CI/CD
   account, scoped least-privilege to deploy the app.
📍 In the CI/CD account: the pipeline identity is permitted to AssumeRole
   into those deploy-roles.
📍 Pipeline stages: build once → assume dev role + deploy → assume staging
   role + deploy + test → (manual approval) → assume prod role + deploy.
📍 Shared ECR/S3 for the artifact, with cross-account pull access.
```

---

## 33.6 Real-World Example

```
A company with dev/staging/prod as separate accounts + a tools account:
   1. Pipeline (tools account) builds the image once, pushes to a shared ECR.
   2. Assumes "deploy-role" in the DEV account → deploys → smoke tests.
   3. Assumes "deploy-role" in STAGING → deploys the SAME image → full tests.
   4. PAUSES for a release manager's approval.
   5. Assumes "deploy-role" in PROD → deploys the SAME image.
   Each deploy-role is scoped to just deploying the app; the pipeline has
   no standing permissions in any target account. Even if the tools
   account pipeline were compromised, it can only assume the scoped,
   trusted roles — limited blast radius.
This is the AWS multi-account equivalent of an Azure multi-stage pipeline
promoting one artifact through Dev→QA→Prod with approval gates.
```

---

## 33.7 Interview Q&A

**Q: How do you design CI/CD across multiple AWS accounts?**
> Run the pipeline in a central CI/CD/tools account, build the artifact once (in a shared ECR/S3), and promote that same artifact through dev→staging→prod accounts. For each deploy, the pipeline assumes a least-privilege cross-account "deploy-role" in the target account (two-sided trust), getting short-lived credentials — so the pipeline holds no standing permissions in the target accounts. A manual approval gates the prod deploy. This gives hard environment isolation (separate accounts) plus build-once-deploy-many.

**Q: Why separate environments into different accounts?**
> Accounts are a hard isolation and blast-radius boundary in AWS — a mistake, compromise, or runaway cost in dev can't affect prod. It's stronger isolation than Azure subscriptions and a best practice for production environments.

**Q: How does the pipeline deploy without standing prod access?**
> It assumes a scoped cross-account deploy-role in the prod account only when deploying (via sts:AssumeRole with a two-sided trust), getting short-lived credentials that expire — so it never holds permanent prod permissions.

## 33.8 Summary

Multi-account CI/CD deploys across separate AWS accounts per environment (dev/staging/prod — hard isolation) from a central CI/CD/tools account, which builds the artifact once and promotes that same artifact through each account by assuming least-privilege cross-account deploy-roles (short-lived creds, no standing permissions), with a manual approval before prod. It combines "build once, deploy many" with cross-account role assumption — the AWS multi-account realization of an Azure multi-stage promotion pipeline, with stronger account-level isolation.

---

---
---

# 34. 📄 CloudFormation
> 🟠 MEDIUM

---

## 34.1 What Problem Does This Solve?

Clicking through the console isn't repeatable, version-controlled, or reviewable. **CloudFormation** is AWS's native Infrastructure-as-Code service — declare your infrastructure in a template (YAML/JSON), and AWS provisions it consistently.

> 💡 **If you know Azure:** CloudFormation is the AWS equivalent of **ARM Templates / Bicep** — the native, declarative IaC service. (Your primary IaC is likely Terraform, so this is medium depth.)

---

## 34.2 How It Works (Flow Diagram)

```
Write a CloudFormation TEMPLATE (YAML/JSON describing resources)
   ↓ deploy it → creates a STACK (a managed collection of those resources)
   ↓ CloudFormation figures out dependencies + order, provisions everything
   ↓ update the template → CloudFormation computes + applies the diff
   ↓ delete the stack → cleanly removes all its resources

Key concepts:
   Template = the IaC definition (Parameters, Resources, Outputs, Mappings)
   Stack    = a deployed instance of a template (manage/update/delete as a unit)
   Change Set = preview of what an update WILL change (before applying)
   StackSets = deploy a stack across many accounts/regions at once
   Drift Detection = detect manual changes that deviate from the template
```

---

## 34.3 Key Facts

```
✅ Declarative (describe desired state; CFN handles order/dependencies)
✅ Stacks group resources → update/delete as a unit; rollback on failure
✅ Change Sets preview changes before applying (≈ Bicep what-if / TF plan)
✅ StackSets deploy across multiple accounts/regions (great with Organizations)
✅ Drift Detection flags manual out-of-band changes
✅ Nested stacks + modules for reuse; YAML is common (cleaner than JSON)
```

---

## 34.4 Steps

```
📍 Console → CloudFormation → Create stack → upload template → parameters →
   (review the Change Set) → Create
📍 CLI: aws cloudformation deploy --template-file template.yaml --stack-name my-stack
📍 Preview: aws cloudformation create-change-set ... → describe-change-set
```

---

## 34.5 Real-World Example

```
A team standardizes environment creation with CloudFormation:
   • One template defines VPC + subnets + security groups + ECS + RDS + ALB.
   • Deploy it as a stack per environment (dev/staging/prod) with different
     parameters → identical, repeatable environments.
   • Change Sets reviewed before every update; failed updates auto-rollback.
   • StackSets roll out a security baseline stack across all org accounts.
(Many teams instead use Terraform for multi-cloud — but CloudFormation is
the native AWS option, like ARM/Bicep on Azure.)
```

---

## 34.6 Interview Q&A

**Q: What is CloudFormation?** → AWS's native declarative IaC service — templates (YAML/JSON) define resources, deployed as Stacks (managed collections) with automatic dependency ordering, rollback on failure, Change Sets to preview updates, StackSets for multi-account/region, and drift detection. It's the AWS equivalent of ARM Templates/Bicep.
**Q: What's a Change Set?** → A preview of exactly what a stack update will create/modify/delete before you apply it — the equivalent of `terraform plan` / Bicep `what-if`.
**Q: CloudFormation vs Terraform?** → CloudFormation is AWS-native (deep AWS integration, StackSets); Terraform is multi-cloud with its own state file. Use Terraform when spanning clouds; CloudFormation for AWS-only native IaC.

## 34.7 Summary

CloudFormation is AWS's native declarative IaC — templates define resources, deployed as Stacks with automatic dependency ordering, rollback on failure, Change Sets for previewing updates, StackSets for multi-account/region deployment, and drift detection. It's the AWS equivalent of ARM Templates/Bicep. For AWS-only native IaC it's excellent; teams spanning multiple clouds typically use Terraform instead (next sections).

---
---

# 35. 🏗️ AWS CDK (Cloud Development Kit)
> 🟡 KNOW-THIS-MUCH

---

## 35.1 What Problem Does This Solve?

CloudFormation YAML/JSON is verbose. **AWS CDK** lets you define infrastructure using real programming languages (TypeScript, Python, Java, etc.), which synthesizes down to CloudFormation.

> 💡 **If you know Azure:** CDK is roughly the AWS equivalent of **Bicep's goal** (nicer authoring) — but CDK goes further by using *actual programming languages* with loops/conditionals/abstractions, whereas Bicep is a declarative DSL. CDK synthesizes to CloudFormation, like Bicep compiles to ARM.

---

## 35.2 How It Works (Flow Diagram)

```
Write infra in TypeScript/Python/etc. using CDK CONSTRUCTS (reusable
building blocks)
   ↓ cdk synth → generates a CloudFormation template
   ↓ cdk deploy → CloudFormation provisions it

Constructs (L1 = raw CFN, L2 = sensible-defaults, L3 = patterns) let you
create infra with real code — loops, conditions, functions, reuse.
```

---

## 35.3 Key Facts

```
✅ Use real languages (TypeScript most common, Python, Java, C#, Go)
✅ Synthesizes to CloudFormation (so you get CFN's stacks/rollback under the hood)
✅ Constructs = reusable components (L1 raw → L2 opinionated → L3 patterns)
✅ Great when you want programmatic logic/abstractions in your IaC
✅ cdk diff previews changes (≈ what-if / plan)
```

---

## 35.4 Steps

```
📍 cdk init app --language typescript → write stack code →
   cdk synth (see the CFN) → cdk diff (preview) → cdk deploy
```

---

## 35.5 Real-World Example

```
A team creates 20 similar microservice stacks. With CDK they write a
reusable construct (a "microservice" class taking a name + config) and
instantiate it 20 times in a loop — far less repetition than 20 CFN
templates. cdk deploy synthesizes and provisions them all.
```

---

## 35.6 Interview Q&A

**Q: What is CDK?** → AWS's IaC toolkit that lets you define infrastructure in real programming languages (TypeScript/Python/etc.), synthesizing to CloudFormation. It enables loops, conditionals, and reusable constructs — going beyond declarative templates. Roughly analogous to Bicep's goal of nicer authoring, but using actual code.
**Q: CDK vs CloudFormation vs Terraform?** → CDK = code that synthesizes to CloudFormation (AWS-only, programmatic); CloudFormation = declarative native templates; Terraform = multi-cloud declarative with its own state. CDK for programmatic AWS-only IaC; Terraform for multi-cloud.

## 35.7 Summary

AWS CDK defines infrastructure using real programming languages (TypeScript, Python, etc.) that synthesize to CloudFormation, enabling loops, conditionals, and reusable constructs beyond declarative templates. It's AWS-only and roughly parallels Bicep's nicer-authoring goal but with actual code. Use it for programmatic AWS-native IaC; use Terraform (next) when you need multi-cloud.

---
---

# 36. 🏗️ Terraform + AWS
> 🔴 FULL

---

## 36.1 What Problem Does This Solve?

Terraform is likely your primary IaC skill. The interview value here is how it authenticates to AWS and runs in pipelines (not Terraform basics, which you know).

> 💡 **If you know Azure:** Same Terraform workflow (init/plan/apply) and HCL as Azure — differs only by provider (`aws` vs `azurerm`) and auth (IAM roles/OIDC vs Entra ID/Service Principal). If you've used Terraform with Azure, this is the AWS provider equivalent.

---

## 36.2 How Terraform Authenticates to AWS (Flow Diagram)

```
Terraform (aws provider) authenticates via ONE of:
   • AWS CLI credentials / profile (local dev)
   • IAM instance/pod role (if running on EC2/EKS — no stored keys)
   • AssumeRole (a base identity assumes a scoped role)
   • OIDC / AssumeRoleWithWebIdentity (CI/CD — best, secretless)
        ↓
   Gets credentials (ideally short-lived via STS) → the IAM role's policies
   determine what Terraform can create → provisions AWS resources

Same identity → IAM → permissions pattern as everything else in AWS.
```

---

## 36.3 A Basic Terraform Config for AWS

```hcl
terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}
provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "app" {
  vpc_id     = aws_vpc.main.id       # references → auto dependency ordering
  cidr_block = "10.0.2.0/24"
}
```

**Workflow:** `terraform init` → `terraform plan` (preview) → `terraform apply` → `terraform destroy`.

---

## 36.4 Running Terraform in a Pipeline (Flow Diagram)

```
Git (.tf files) → Pipeline (any tool):
   1. Auth to AWS via OIDC/AssumeRole (Section 29) — no stored keys
   2. terraform init  (connects to remote state — Section 37)
   3. terraform plan  (diff shown in the PR for review)
   4. ── APPROVAL GATE ── (human reviews the plan)
   5. terraform apply (applies the reviewed plan)
        ↓
   AWS resources created/updated
```

---

## 36.5 Steps

```
📍 Local: aws configure (or a profile) → terraform init/plan/apply
📍 Pipeline: authenticate via OIDC (assume an IAM role), then run terraform
   init/plan/apply — using GitHub Actions, Jenkins, Bitbucket, or Azure
   DevOps (Sections 29-30) for the AWS auth.
```

---

## 36.6 Real-World Example

```
A team manages AWS infra with Terraform via GitHub Actions:
   • GitHub Actions authenticates via OIDC → assumes a scoped IAM role
     (no stored AWS keys).
   • On a PR: terraform plan runs, the diff is posted so reviewers see
     exactly what will change.
   • After merge + a manual approval: terraform apply runs on the reviewed
     plan.
   • State is in an S3 backend with DynamoDB locking (Section 37).
Result: AWS infra changes are as safe/reviewed/auditable as app code —
identical workflow to Terraform on Azure, just the aws provider + IAM/OIDC.
```

---

## 36.7 Interview Q&A

**Q: How does Terraform authenticate to AWS?** → Via the aws provider using AWS credentials — a CLI profile locally, or in CI/CD an IAM instance/pod role, AssumeRole, or (best) OIDC/AssumeRoleWithWebIdentity for short-lived, secretless access. The IAM role's policies scope what Terraform can create — the same identity→IAM→permissions pattern as everything in AWS.
**Q: How do you run Terraform safely in a pipeline?** → Authenticate via OIDC (assume a scoped IAM role, no stored keys), run init → plan (reviewed in the PR) → apply after a manual approval, with state in a remote backend (S3 + DynamoDB locking).
**Q: What differs from Terraform on Azure?** → Same workflow and HCL; only the provider (`aws` vs `azurerm`) and auth mechanism (IAM roles/OIDC vs Entra ID/Service Principal) differ.

## 36.8 Summary

Terraform + AWS uses the `aws` provider, authenticating via AWS credentials — ideally OIDC/AssumeRole in CI/CD (short-lived, secretless) or an IAM instance/pod role — with the IAM role's policies scoping what it can create. In a pipeline it runs init → plan (reviewed) → apply (after approval), with remote state in S3 + DynamoDB locking. The workflow and HCL are identical to Terraform on Azure; only the provider and auth differ.

---
---

# 37. 🔐 Terraform State (S3 + DynamoDB Locking)
> 🔴 FULL

---

## 37.1 What Problem Does This Solve?

Terraform's state file is its record of what it manages. For teams, it must be stored remotely with locking so people can collaborate without corrupting it. On AWS, the standard is an **S3 backend + DynamoDB for locking** — a very common interview question.

> 💡 **If you know Azure:** This is the AWS equivalent of the Azure Storage Account backend + blob-lease locking. S3 = the state store (≈ the Storage Account), DynamoDB = the lock table (Azure did locking via blob leases; AWS uses a separate DynamoDB table).

---

## 37.2 How It Works (Flow Diagram)

```
LOCAL state = solo only (can't share, no locking, can be lost).

REMOTE BACKEND on AWS:
   S3 bucket        → stores terraform.tfstate (shared, durable, versioned)
   DynamoDB table   → provides STATE LOCKING (prevents concurrent applies)

   Engineer A runs apply → acquires a LOCK (a DynamoDB item) → Engineer B's
   apply is BLOCKED until A finishes → no state corruption.

Enable S3 versioning + encryption on the state bucket for safety/recovery.
```

---

## 37.3 Backend Configuration

```hcl
terraform {
  backend "s3" {
    bucket         = "mycompany-tfstate"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"   # the lock table
    encrypt        = true                # encrypt state at rest (KMS)
  }
}
```

---

## 37.4 Key Facts

```
✅ S3 = remote state store (enable VERSIONING + encryption + block public access)
✅ DynamoDB = state LOCKING (a table with a LockID key)
✅ Remote backend enables team collaboration + prevents concurrent-apply corruption
✅ GOLDEN RULE: never manually change Terraform-managed resources in the
   console → causes state drift → confusing errors
✅ (Terraform Cloud / S3 native locking are alternatives, but S3+DynamoDB
   is the classic AWS pattern to know)
```

---

## 37.5 Steps

```
📍 One-time: create the S3 bucket (versioning + encryption on) and a
   DynamoDB table (partition key "LockID").
📍 Add the backend "s3" block → terraform init (migrates local state to S3).
📍 Now the team shares state via S3, with DynamoDB preventing simultaneous applies.
```

---

## 37.6 Real-World Example

```
A team of 5 engineers manages shared AWS infra:
   Before: state on one laptop → nobody else could run Terraform; sharing
   via Git corrupted it.
   After: S3 bucket "mycompany-tfstate" (versioned, KMS-encrypted) +
   DynamoDB "terraform-locks" table. All 5 share the state; if two run
   apply at once, DynamoDB locking blocks the second until the first
   finishes. The pipeline (GitHub Actions via OIDC) uses the same backend.
   Golden rule enforced: no manual console changes to TF-managed resources.
Result: safe team collaboration — the AWS equivalent of the Azure Storage
Account backend + blob-lease locking.
```

---

## 37.7 Interview Q&A

**Q: How do you manage Terraform state on AWS for a team?**
> Store it in a remote backend: an S3 bucket (versioned + encrypted) holds the state file, and a DynamoDB table provides state locking so two applies can't run simultaneously and corrupt the state. This enables team collaboration. It's the AWS equivalent of the Azure Storage Account backend with blob-lease locking.

**Q: Why do you need DynamoDB with the S3 backend?**
> S3 stores the state but doesn't provide locking on its own (classically); DynamoDB provides the lock — when someone runs apply, Terraform writes a lock item, blocking other applies until it's released, preventing concurrent modifications from corrupting the state.

**Q: What's the golden rule with Terraform-managed resources?**
> Never manually modify them in the console — all changes go through Terraform, or the state file drifts out of sync with reality, causing errors on the next plan/apply.

## 37.8 Summary

For team Terraform on AWS, store state in a remote backend: an S3 bucket (versioned, encrypted) for the state file plus a DynamoDB table for state locking (preventing concurrent-apply corruption) — the AWS equivalent of Azure's Storage Account backend + blob-lease locking. Enable S3 versioning/encryption for safety, and never manually modify Terraform-managed resources (drift). This is a classic, frequently-asked AWS interview pattern.

---
---

# 38. 🚦 IaC in CI/CD with Plan Gates
> 🟠 MEDIUM

---

## 38.1 What Problem Does This Solve?

Running Terraform/CloudFormation manually from a laptop is risky and unauditable. The professional practice runs IaC through a pipeline with **plan → review → approve → apply**, so every infra change is reviewed and approved before touching real resources.

> 💡 **If you know Azure:** Identical to the Azure "IaC in CI/CD with plan approval gates" section — the concept is cloud-agnostic (plan/what-if → approval → apply), just with AWS auth (OIDC) and S3/DynamoDB state.

---

## 38.2 The Flow (Flow Diagram)

```
.tf change → PR → pipeline:
   Stage 1: terraform plan (or CFN Change Set) → DIFF shown in the PR
   ── APPROVAL GATE ── human reviews the plan
   Stage 2: terraform apply (on the EXACT reviewed plan)
        ↓
   AWS updated — reviewed, approved, auditable

Save the plan as an artifact and apply THAT exact plan → no drift between
what was reviewed and what's applied.
```

---

## 38.3 Key Facts

```
✅ Never apply un-reviewed IaC — plan/Change Set is reviewed first
✅ Approval gate between plan and apply (GitHub Environments / ADO
   Environments / Bitbucket deployments / manual approval)
✅ Save & apply the EXACT plan → what's applied matches what was reviewed
✅ Pipeline auth via OIDC (Section 29); state in S3+DynamoDB (Section 37)
✅ Least-privilege deploy role; full audit trail in the pipeline
```

---

## 38.4 Real-World Example

```
An engineer proposes adding a subnet + security group:
   1. Opens a PR; the pipeline runs terraform plan → output ("+1 subnet,
      +1 SG") posted in the PR. Reviewers confirm nothing unexpected
      (e.g., no accidental "-1 database").
   2. PR approved + merged.
   3. Apply stage (gated by a manual approval on the prod environment)
      runs terraform apply on the exact saved plan.
   If the plan had shown something dangerous, reviewers catch it BEFORE
   apply. This safety net is what manual laptop-based IaC lacks.
```

---

## 38.5 Interview Q&A

**Q: How do you run IaC safely in a pipeline?** → plan → approve → apply: the pipeline runs terraform plan (or a CFN Change Set) showing the exact diff, reviewed in the PR; a manual approval gate requires sign-off; then apply runs on the exact reviewed plan. Pipeline auth via OIDC, state in S3+DynamoDB, least-privilege role, full audit trail.
**Q: Why apply the exact saved plan?** → So what's applied precisely matches what was reviewed (no drift between review and apply).

## 38.6 Summary

Running IaC through CI/CD with a plan gate is the safe, professional practice: the pipeline runs terraform plan / CFN Change Set to show the exact diff (reviewed in the PR), a manual approval gate requires human sign-off, then apply runs on the exact reviewed plan — with OIDC auth, S3+DynamoDB state, and a least-privilege role. This gives code review + plan review + approval + audit trail for every infra change, identical in concept to the Azure equivalent.

---
---

# 39. 🖥️ EC2
> 🟠 MEDIUM

---

## 39.1 What Problem Does This Solve?

You need virtual servers in the cloud — full OS control, your choice of size and OS. **EC2 (Elastic Compute Cloud)** is AWS's core compute service.

> 💡 **If you know Azure:** EC2 is the direct equivalent of Azure **Virtual Machines**. Instance types ≈ VM series/sizes; AMIs ≈ VM images; user data ≈ custom data/cloud-init; key pairs ≈ SSH keys.

---

## 39.2 Key Concepts (Flow Diagram)

```
EC2 Instance = a virtual server. You choose:
   • AMI (Amazon Machine Image) — the OS + software template (≈ Azure VM image)
   • Instance Type — CPU/RAM/network (families: t=burstable, m=general,
     c=compute, r=memory, p/g=GPU) (≈ Azure VM series)
   • Key Pair — SSH access (public key on instance, you keep the private key)
   • Security Group — instance firewall (Section 12)
   • User Data — bootstrap script that runs at first boot (≈ Azure custom data)
   • Storage — EBS volumes (Section 60)
   • IAM Role (instance profile) — for AWS access without keys (Section 5)
```

---

## 39.3 Pricing Models (Interview-Relevant)

| Model | Description | Best For |
|---|---|---|
| **On-Demand** | Pay per second/hour, no commitment | Unpredictable/short-term workloads |
| **Reserved Instances / Savings Plans** | 1-3 year commitment, big discount | Steady, predictable workloads |
| **Spot Instances** | Spare capacity, up to ~90% off, can be interrupted (2-min notice) | Fault-tolerant/batch workloads |
| **Dedicated Hosts** | Physical server for you | Licensing/compliance |

*(Mirrors Azure's Pay-As-You-Go / Reserved / Savings Plan / Spot models.)*

---

## 39.4 UI Steps

```
📍 Console → EC2 → Launch instance → choose AMI + instance type + key pair
   + VPC/subnet + security group + IAM role + user data → Launch
📍 Connect: ssh -i key.pem ec2-user@<public-ip>  (Linux)
📍 CLI: aws ec2 run-instances ...
```

---

## 39.5 Real-World Example

```
A high-traffic news site's EC2 strategy:
   • Base load: Reserved Instances (m5.large) — steady, discounted.
   • Peak spikes: On-Demand instances added by an Auto Scaling Group.
   • Batch jobs (image processing): Spot Instances — ~80% cheaper, and
     the work tolerates interruption.
   • Golden AMI: a custom image with the app + agents baked in → new
     instances launch ready in minutes.
   • Instances use an IAM role (no stored keys) + user data to pull the
     latest config at boot.
Mirrors the Azure VM + VMSS strategy with Reserved/Spot mixing.
```

---

## 39.6 Interview Q&A

**Q: What is EC2 and what do you configure?** → AWS's virtual servers; you choose an AMI (OS image), instance type (CPU/RAM), key pair (SSH), security group (firewall), user data (boot script), storage (EBS), and an IAM role. It's the equivalent of Azure VMs.
**Q: EC2 pricing models?** → On-Demand (flexible), Reserved Instances/Savings Plans (commit for discount, steady workloads), Spot (up to ~90% off, interruptible, for fault-tolerant/batch), Dedicated Hosts (licensing/compliance). Mirrors Azure's pricing models.
**Q: How does an EC2 instance access S3 without keys?** → Attach an IAM role via an instance profile; it gets short-lived credentials from IMDS automatically (Section 5) — like an Azure Managed Identity.

## 39.7 Summary

EC2 provides virtual servers (≈ Azure VMs) where you choose the AMI, instance type, key pair, security group, user data (boot script), storage, and IAM role. Pricing models — On-Demand, Reserved/Savings Plans, Spot (up to ~90% off, interruptible), Dedicated Hosts — mirror Azure's. Use a Golden AMI for consistent fast launches, an IAM role instead of stored keys, and mix Reserved (base) + Spot (batch) for cost efficiency. Auto Scaling Groups (next) add elasticity.

---
---

# 40. 📈 Auto Scaling Groups & Launch Templates
> 🔴 FULL

---

## 40.1 What Problem Does This Solve?

One EC2 instance can't handle variable traffic and isn't self-healing. **Auto Scaling Groups (ASG)** automatically add/remove instances based on demand and replace unhealthy ones — the foundation of elastic, resilient EC2-based compute.

> 💡 **If you know Azure:** An ASG is the direct equivalent of an Azure **Virtual Machine Scale Set (VMSS)**. A Launch Template ≈ the VMSS VM configuration profile. Same scaling concepts (target/step/scheduled).

---

## 40.2 How It Works (Flow Diagram)

```
LAUNCH TEMPLATE = the blueprint for new instances (AMI, type, security
   group, IAM role, user data) — ≈ VMSS config profile

AUTO SCALING GROUP:
   • Min / Desired / Max instance counts
   • Spreads instances across multiple AZs (HA)
   • Registers new instances with a load balancer target group automatically
   • HEALTH CHECKS → replaces unhealthy instances (self-healing)
   • SCALING POLICIES:
       Target Tracking  → keep a metric at a target (e.g., CPU at 50%) [simplest]
       Step Scaling     → different actions at different thresholds
       Scheduled        → scale at known times (e.g., 8am scale out)

Traffic ↑ → ASG launches instances (up to Max) → registers with the LB
Traffic ↓ → ASG terminates instances (down to Min) → cost drops
Unhealthy instance → ASG replaces it automatically
```

---

## 40.3 Key Facts

```
✅ Min/Desired/Max define the scaling bounds
✅ Multi-AZ by default → survives an AZ failure
✅ Auto-registers/deregisters instances with the load balancer target group
✅ Self-healing: health-check failures trigger automatic replacement
✅ Target Tracking is the simplest/most common scaling policy (like a thermostat)
✅ Combine Scheduled (predictable peaks) + Target Tracking (real-time demand)
✅ Launch Templates (modern) over Launch Configurations (legacy)
✅ Can mix On-Demand + Spot instances in one ASG for cost savings
```

---

## 40.4 UI Steps

```
📍 EC2 → Launch Templates → Create (AMI, type, SG, IAM role, user data)
📍 EC2 → Auto Scaling Groups → Create → select the launch template →
   choose VPC + multiple subnets (AZs) → attach a load balancer target group
   → set Min/Desired/Max → add scaling policies (Target Tracking on CPU) → Create
```

---

## 40.5 Real-World Example

```
A ride-sharing backend with morning/evening rush spikes:
   • Launch Template: Golden AMI + user data pulling latest config.
   • ASG: Min 4, Max 40, across 3 AZs, behind an ALB.
   • Target Tracking: keep requests-per-instance at 500 → auto scale.
   • Scheduled: bump min to 15 right before known rush hours (a head start).
   • Mix: base On-Demand + burst Spot for cost savings.
   • Self-healing: if an instance's app crashes, the ELB health check
     fails → ASG replaces it in ~3 min, no human involvement.
Directly equivalent to an Azure VMSS with scheduled + metric autoscaling.
```

---

## 40.6 Interview Q&A

**Q: What is an Auto Scaling Group?** → A managed group of identical EC2 instances defined by Min/Desired/Max that automatically scales based on demand, spreads across AZs for HA, auto-registers with a load balancer, and self-heals by replacing unhealthy instances. It's the equivalent of an Azure VMSS.
**Q: What scaling policies exist?** → Target Tracking (keep a metric at a target — simplest), Step Scaling (different actions at different breach sizes), and Scheduled (scale at known times). Often combine Scheduled + Target Tracking.
**Q: What's a Launch Template?** → The blueprint for instances the ASG launches (AMI, type, security group, IAM role, user data) — modern replacement for Launch Configurations, analogous to a VMSS config profile.

## 40.7 Summary

Auto Scaling Groups (≈ Azure VMSS) manage a group of identical EC2 instances via a Launch Template, scaling between Min/Desired/Max based on demand (Target Tracking / Step / Scheduled policies), spreading across AZs for HA, auto-registering with load balancers, and self-healing by replacing unhealthy instances. Combine Scheduled (predictable peaks) + Target Tracking (real-time), mix On-Demand + Spot for cost, and use Launch Templates over legacy Launch Configurations. It's the foundation of elastic, resilient EC2 compute.

---
---

# 41. 🌱 Elastic Beanstalk
> 🟡 KNOW-THIS-MUCH

---

## 41.1 What Problem Does This Solve?

Sometimes you want to deploy an app without managing the underlying infrastructure (EC2, ASG, ELB) yourself. **Elastic Beanstalk** is AWS's PaaS — you provide code, it provisions and manages the infrastructure.

> 💡 **If you know Azure:** Elastic Beanstalk ≈ Azure **App Service** — a PaaS where you deploy code and AWS handles the servers, scaling, and load balancing.

---

## 41.2 How It Works (Flow Diagram)

```
You upload code (or a container) → Elastic Beanstalk automatically provisions:
   EC2 instances + Auto Scaling Group + Elastic Load Balancer +
   health monitoring + (optionally) an RDS database
   ↓
Your app runs; you focus on code, not infrastructure. Beanstalk handles
capacity, scaling, load balancing, and deployment.

Supports: Node.js, Python, Java, .NET, PHP, Ruby, Go, Docker.
Deployment options: all-at-once, rolling, rolling with additional batch,
immutable, blue/green (via environment swap).
```

---

## 41.3 Key Facts

```
✅ PaaS — provide code, AWS manages EC2/ASG/ELB/monitoring underneath
✅ Free service — you pay only for the underlying resources it creates
✅ Multiple deployment policies (rolling, immutable, blue/green via URL swap)
✅ You CAN still access the underlying resources if needed (unlike fully
   opaque PaaS)
✅ Good for standard web apps/APIs without dedicated infra management
```

---

## 41.4 Steps

```
📍 Console → Elastic Beanstalk → Create application → platform (Node/Python/
   Docker) → upload code → Beanstalk provisions the environment
📍 CLI: eb init → eb create → eb deploy
```

---

## 41.5 Real-World Example

```
A startup's Python API: they use Elastic Beanstalk to go from code to a
running, load-balanced, auto-scaling environment in minutes — no manual
EC2/ASG/ELB setup. They use rolling deployments for zero-downtime updates
and let Beanstalk provision an RDS database alongside. As they grow and
need more control, they can move to ECS/EKS. (Mirrors starting on Azure
App Service.)
```

---

## 41.6 Interview Q&A

**Q: What is Elastic Beanstalk?** → AWS's PaaS — you provide code (or a container) and it automatically provisions and manages EC2, Auto Scaling, load balancing, and monitoring, with multiple deployment policies (rolling, immutable, blue/green). You pay only for the underlying resources. It's the equivalent of Azure App Service. Good for standard web apps without managing infrastructure yourself.

## 41.7 Summary

Elastic Beanstalk is AWS's PaaS (≈ Azure App Service) — provide code or a container and it provisions/manages EC2, Auto Scaling, load balancing, and monitoring automatically, with deployment policies including rolling, immutable, and blue/green. It's free (pay only for underlying resources), lets you access the underlying infra if needed, and suits standard web apps/APIs where you don't want to manage infrastructure directly.

---
---

# 42. 🗂️ AWS Batch
> 🟡 KNOW-THIS-MUCH

---

## 42.1 What Problem Does This Solve?

Some workloads are large batch/compute jobs (data processing, rendering, scientific simulation, ML training) that need to run across many machines, then stop. **AWS Batch** manages running these batch jobs at scale without you provisioning/managing the compute.

> 💡 **If you know Azure:** AWS Batch is roughly the equivalent of **Azure Batch** — managed batch computing that provisions compute for jobs on demand. (Azure's notes touched this only lightly; it's here for completeness.)

---

## 42.2 How It Works (Flow Diagram)

```
You submit JOBS (containerized tasks) to JOB QUEUES →
   AWS Batch automatically PROVISIONS the optimal compute (EC2 or Fargate,
   On-Demand or Spot) to run them →
   runs the jobs (with dependencies/arrays for parallelism) →
   SCALES DOWN when done → you pay only for what ran.

Concepts: Job (a unit of work, a container) · Job Queue (where jobs wait) ·
Compute Environment (the pool Batch provisions — EC2/Fargate, can use Spot).
```

---

## 42.3 Key Facts

```
✅ Fully managed batch job scheduling + compute provisioning
✅ Runs containerized jobs on EC2 or Fargate; can use Spot for big savings
✅ Auto-scales the compute environment based on the job queue → pay per use
✅ Supports job dependencies + array jobs (parallelism)
✅ Great for data processing, rendering, genomics, ML training, ETL
```

---

## 42.4 Real-World Example

```
A media company transcodes thousands of videos nightly:
   • Submit each transcode as a containerized job to an AWS Batch queue.
   • Batch provisions a Spot-based compute environment (huge cost saving),
     runs thousands of jobs in parallel, then scales to zero when done.
   • Job dependencies ensure post-processing runs after transcoding.
No servers to manage; pay only for the compute that actually ran.
```

---

## 42.5 Interview Q&A

**Q: What is AWS Batch and when would you use it?** → A managed service for running large-scale batch/compute jobs (containerized) — it automatically provisions the optimal compute (EC2/Fargate, often Spot), runs the jobs (with dependencies/parallelism), and scales down when done, so you pay only for what ran. Use it for data processing, rendering, genomics, ML training, or ETL that runs as batch jobs. Roughly equivalent to Azure Batch.

## 42.6 Summary

AWS Batch is a managed batch-computing service that runs large-scale containerized jobs by automatically provisioning optimal compute (EC2/Fargate, often Spot for savings), handling scheduling, dependencies, and parallelism, then scaling down when done — pay only for what ran. It's ideal for data processing, rendering, ML training, and ETL batch workloads, and is roughly the AWS equivalent of Azure Batch.

---

---
---

# 43. 🐳 Dockerfile Best Practices & Multi-Stage Builds
> 🟠 MEDIUM

---

## 43.1 What Problem Does This Solve?

Build small, secure, efficient container images. **Multi-stage builds** are the key concept (common interview topic). Cloud-agnostic Docker knowledge; images get pushed to ECR (next section).

> 💡 **If you know Azure:** Identical to the Azure Dockerfile section — Docker is the same everywhere; you push to ECR instead of ACR.

---

## 43.2 Multi-Stage Builds (Flow Diagram)

```
STAGE 1 "build": full image + build tools → compile the app
STAGE 2 "runtime": tiny base (alpine/distroless) + copy ONLY the artifacts
   → small, secure final image (no build tools = smaller + fewer CVEs)
```
```dockerfile
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install          # includes dev deps for building
COPY . .
RUN npm run build        # produces dist/

FROM node:18-alpine      # tiny runtime base
WORKDIR /app
COPY --from=build /app/dist ./dist       # copy ONLY built output
COPY package*.json ./
RUN npm install --production             # prod deps only, no build tools
EXPOSE 3000
CMD ["node", "dist/server.js"]
```

---

## 43.3 Key Best Practices

```
✅ Multi-stage builds → small, secure final images
✅ Minimal base images (alpine/distroless) → fewer vulnerabilities
✅ Pin specific tags (node:18-alpine), NOT :latest → reproducible builds
✅ Order layers by change frequency: copy package.json + install deps
   BEFORE copying code → Docker caches the deps layer (faster builds)
✅ Run as a non-root USER → security
✅ .dockerignore → keep secrets/.git/node_modules out of the image
✅ NEVER bake secrets into the image → inject at runtime (Secrets Manager)
```

---

## 43.4 Steps

```
📍 docker build -t myapp:v1 .  →  tag for ECR  →  aws ecr get-login-password
   | docker login ...  →  docker push  (Section 44)
```

---

## 43.5 Real-World Example

```
A Node image was 1.2 GB with build-tool CVEs. Fix:
   1. Multi-stage build (node:18 to build → node:18-alpine runtime with
      only artifacts) → image drops to ~150 MB.
   2. Reorder layers (deps before code) → faster cached builds.
   3. .dockerignore excludes .git/node_modules/secrets; runs as non-root.
Result: ~8x smaller, faster to pull/deploy, far fewer CVEs on ECR scanning.
```

---

## 43.6 Interview Q&A

**Q: What is a multi-stage build and why use it?** → A Dockerfile with a build stage (full tools) and a minimal runtime stage that copies only the compiled artifacts — producing a small, secure final image without build tools. Smaller to store/pull and reduced attack surface.
**Q: Why does layer order matter?** → Docker caches layers; copying dependency manifests and installing deps before copying code means code changes don't trigger a slow full dependency reinstall.
**Q: Dockerfile security practices?** → minimal base, multi-stage, non-root user, pinned tags, .dockerignore, and never bake secrets in (inject at runtime via Secrets Manager).

## 43.7 Summary

Efficient, secure images come from multi-stage builds (build stage + minimal runtime stage with only artifacts), minimal pinned base images, smart layer ordering (deps before code for caching), running as non-root, .dockerignore, and never baking in secrets. Images push to ECR (next). Multi-stage builds and layer caching are the two most-asked Docker interview topics — identical to the Azure notes.

---
---

# 44. 📦 Amazon ECR (Elastic Container Registry)
> 🔴 FULL

---

## 44.1 What Problem Does This Solve?

Container images need a private, secure registry that ECS/EKS can pull from with IAM-controlled access and vulnerability scanning. **ECR** is AWS's managed container registry.

> 💡 **If you know Azure:** ECR is the direct equivalent of Azure **Container Registry (ACR)** — private image storage with identity-based pulls and scanning.

---

## 44.2 How It Works (Flow Diagram)

```
build → docker push → ECR (<acct>.dkr.ecr.<region>.amazonaws.com/repo:tag)
   ↓ ECS/EKS pull the image via their IAM ROLE (task role / node role / IRSA)
     — NO stored registry credentials

Features:
   • Private, IAM-controlled access
   • Image vulnerability SCANNING (basic + enhanced via Inspector)
   • Lifecycle POLICIES (auto-delete old/untagged images)
   • Cross-region + cross-account REPLICATION
   • Immutable tags option (prevent overwriting a tag)
```

---

## 44.3 Key Facts

```
✅ ECS/EKS authenticate to ECR via IAM roles (no stored creds) — like AKS→ACR
✅ Scan-on-push flags CVEs; enhanced scanning via Amazon Inspector
✅ Lifecycle policies keep the registry tidy (e.g., keep last 20 images)
✅ docker login uses a temporary token: aws ecr get-login-password
✅ Cross-account: repository policies grant other accounts pull access
   (key for multi-account CI/CD — Section 33)
```

---

## 44.4 UI/CLI Steps

```
📍 Console → ECR → Create repository → enable "Scan on push" + a lifecycle policy
📍 Push:
   aws ecr get-login-password --region ap-south-1 | docker login --username AWS \
     --password-stdin <acct>.dkr.ecr.ap-south-1.amazonaws.com
   docker tag myapp:v1 <acct>.dkr.ecr.ap-south-1.amazonaws.com/myapp:v1
   docker push <acct>.dkr.ecr.ap-south-1.amazonaws.com/myapp:v1
```

---

## 44.5 Real-World Example

```
A microservices team's multi-account setup:
   • CI (in the tools account) builds each service's image (tagged with the
     build ID), scan-on-push enabled, pushes to a central ECR.
   • ECR repository policy grants the dev/staging/prod accounts PULL access.
   • EKS in each account pulls via IRSA/node role — no stored creds.
   • Lifecycle policy keeps only the last 20 images per repo.
This is the shared-registry piece of "build once, deploy many" (Section 33)
— mirrors ACR with cross-subscription access on Azure.
```

---

## 44.6 Interview Q&A

**Q: What is ECR and why use it over a public registry?** → A private managed container registry with IAM-controlled access, vulnerability scanning, lifecycle policies, and cross-account/region replication. Over a public registry it gives privacy, tight IAM integration (ECS/EKS pull via roles, no stored creds), and scanning. Equivalent to Azure ACR.
**Q: How do ECS/EKS pull from ECR securely?** → Via IAM roles — the ECS task/execution role or EKS IRSA/node role — with no stored registry credentials, exactly like AKS pulling from ACR via Managed Identity.
**Q: How does cross-account image sharing work?** → An ECR repository policy grants other accounts pull access — essential for multi-account CI/CD where a central registry serves dev/staging/prod accounts.

## 44.7 Summary

Amazon ECR is AWS's private, managed container image registry (≈ Azure ACR) with IAM-controlled access, vulnerability scanning, lifecycle policies, and cross-account/region replication. ECS/EKS pull images via IAM roles (no stored creds, like AKS→ACR). Cross-account repository policies enable a central registry to serve multiple accounts — the shared-registry backbone of multi-account "build once, deploy many."

---
---

# 45. 🐳 Amazon ECS (Fargate vs EC2)
> 🔴 FULL

---

## 45.1 What Problem Does This Solve?

You need to run containers at scale with orchestration (scheduling, health, scaling, load balancing) but may not want Kubernetes' complexity. **ECS (Elastic Container Service)** is AWS's own, simpler container orchestrator — with **Fargate** (serverless) or **EC2** launch types.

> 💡 **If you know Azure:** ECS has no exact single Azure equivalent — it's roughly like **Azure Container Apps / Container Instances** for the simpler AWS-native orchestration (vs EKS = AKS = Kubernetes). Fargate ≈ the serverless-container model (no nodes to manage), similar in spirit to Container Apps.

---

## 45.2 ECS Concepts & Launch Types (Flow Diagram)

```
ECS CONCEPTS:
   Task Definition = blueprint for a container (image, CPU/mem, ports, env,
                     IAM roles) — like a "pod spec"
   Task            = a running instance of a task definition
   Service         = keeps N tasks running + integrates with a load balancer + scales
   Cluster         = logical grouping of tasks/services

TWO LAUNCH TYPES (where the containers actually run):

   FARGATE (serverless):
      AWS runs the containers — NO servers/nodes to manage or patch.
      Pay per task's CPU/memory. Simplest.
      → default choice for most workloads

   EC2:
      YOU manage a cluster of EC2 instances that run the containers.
      More control (custom AMIs, GPU, cost tuning at scale), more ops work.
      → when you need instance-level control or specific hardware
```

---

## 45.3 Fargate vs EC2 (Comparison)

| | Fargate (serverless) | EC2 launch type |
|---|---|---|
| Servers to manage | None | You manage the EC2 cluster |
| Pricing | Per task CPU/mem | Per EC2 instance |
| Control | Less (no host access) | More (AMIs, GPU, tuning) |
| Ops overhead | Minimal | Higher (patching, scaling nodes) |
| Best for | Most workloads, simplicity | Instance-level control, specialized hardware, high-scale cost tuning |

**Interview point:** default to **Fargate** for simplicity (no nodes to manage); use **EC2 launch type** when you need host-level control, GPUs, or fine cost tuning at large scale.

---

## 45.4 Key Facts

```
✅ ECS = AWS-native orchestrator (simpler than Kubernetes/EKS)
✅ Task Definition (blueprint) → Task (running) → Service (keeps N running +
   LB + scaling) → Cluster (grouping)
✅ Fargate = serverless (no nodes); EC2 = you manage the node cluster
✅ Task role (app's AWS permissions) + task execution role (pull images/
   fetch secrets/write logs) — no stored creds (Sections 5, 27)
✅ Integrates with ALB/NLB target groups; Service Auto Scaling scales tasks
✅ Deep AWS integration; no Kubernetes knowledge needed
```

---

## 45.5 UI Steps

```
📍 Console → ECS → Create cluster (Fargate or EC2) → Create Task Definition
   (image from ECR, CPU/mem, task role, secrets, log config) → Create Service
   (desired count, attach an ALB target group, enable Service Auto Scaling)
📍 CLI: aws ecs create-cluster / register-task-definition / create-service
```

---

## 45.6 Real-World Example

```
A team wants containers without Kubernetes complexity:
   • ECS on FARGATE — no nodes to manage/patch.
   • Task definition pulls the image from ECR (via the task execution
     role), injects DB creds from Secrets Manager (Section 27), logs to
     CloudWatch.
   • A Service keeps 4 tasks running behind an ALB; Service Auto Scaling
     scales tasks on CPU. Rolling/blue-green deploys via CodeDeploy.
For a GPU ML-inference service, they use the EC2 launch type with
GPU instances (Fargate doesn't offer GPUs).
Simpler than EKS while still fully orchestrated — closer to Azure
Container Apps than to full AKS.
```

---

## 45.7 Interview Q&A

**Q: What is ECS and how does it differ from EKS?** → ECS is AWS's own, simpler container orchestrator (Task Definition → Task → Service → Cluster) with deep AWS integration and no Kubernetes knowledge needed. EKS is managed Kubernetes (more powerful, portable, but more complex). Use ECS for AWS-native simplicity, EKS when you need Kubernetes/portability.
**Q: Fargate vs EC2 launch type?** → Fargate is serverless — AWS runs the containers, no nodes to manage, pay per task (default for simplicity). EC2 launch type means you manage a cluster of EC2 instances — more control (custom AMIs, GPUs, cost tuning) but more ops. Default to Fargate; use EC2 for host-level control/specialized hardware.
**Q: How do ECS tasks get AWS permissions and secrets?** → Via a task role (app permissions) and a task execution role (pull images, fetch secrets, write logs) — no stored credentials; secrets are referenced in the task definition and injected at runtime.

## 45.8 Summary

ECS is AWS's native, simpler container orchestrator (Task Definition → Task → Service → Cluster) with two launch types: Fargate (serverless — no nodes, pay per task, default for simplicity) and EC2 (you manage the node cluster — more control for GPUs/cost tuning). It integrates deeply with AWS (IAM task roles, ECR, ALB, CloudWatch, Secrets Manager) and needs no Kubernetes knowledge. Choose ECS for AWS-native simplicity; EKS (next) for Kubernetes. Roughly analogous to Azure Container Apps vs full AKS.

---
---

# 46. ☸️ Amazon EKS (Elastic Kubernetes Service)
> 🔴 FULL

---

## 46.1 What Problem Does This Solve?

When you need full **Kubernetes** (portability, the K8s ecosystem, standard tooling) rather than AWS-native ECS, **EKS** is AWS's managed Kubernetes service — AWS runs the control plane, you run the worker nodes.

> 💡 **If you know Azure:** EKS is the direct equivalent of Azure **AKS**. One notable difference (reversed from Azure's favor): **EKS charges an hourly fee for the control plane**, whereas AKS's control plane is free — a common comparison point. Worker nodes, IRSA≈Workload Identity, and the Kubernetes concepts are otherwise parallel.

---

## 46.2 How It Works (Flow Diagram)

```
EKS CLUSTER:
   Control Plane (MANAGED BY AWS — but has an hourly cost, unlike AKS's free CP)
        + Worker Nodes (you manage/pay): EC2 node groups OR Fargate profiles
   Standard Kubernetes: Pods · Deployments · Services · Ingress · Namespaces

Node options:
   • Managed Node Groups — EC2 instances (auto-provisioned/updated by EKS)
   • Fargate profiles — serverless pods (no nodes to manage)
   • Karpenter — smart, fast node autoscaling (Section 49)

AWS integrations:
   • IRSA (IAM Roles for Service Accounts) → pods get AWS permissions
     (≈ AKS Workload Identity)
   • ECR for images (via node role/IRSA)
   • AWS Load Balancer Controller → provisions ALB/NLB for Ingress/Services
   • CloudWatch Container Insights → monitoring
```

---

## 46.3 Key Facts

```
✅ Managed Kubernetes; AWS runs the control plane (hourly fee — differs from
   AKS free control plane)
✅ Worker nodes: Managed Node Groups (EC2), Fargate profiles (serverless),
   or Karpenter for autoscaling
✅ IRSA / EKS Pod Identity → pods assume IAM roles for AWS access (no node-
   wide/hardcoded creds) — the AWS equivalent of AKS Workload Identity
✅ AWS Load Balancer Controller → ALB (Ingress) / NLB (Service) integration
✅ VPC CNI → pods get VPC IPs (like AKS Azure CNI)
✅ Standard Kubernetes/kubectl/Helm — portable skills
```

---

## 46.4 UI/CLI Steps

```
📍 Console → EKS → Create cluster (control plane) → add a node group
   (Managed Node Group / Fargate profile)
📍 Connect: aws eks update-kubeconfig --name my-cluster → kubectl get nodes
📍 Deploy: kubectl apply -f deployment.yaml (+ service/ingress)
📍 CLI/eksctl: eksctl create cluster ... (a popular shortcut)
```

---

## 46.5 Real-World Example

```
A team standardizing on Kubernetes across clouds chooses EKS:
   • Managed Node Groups (EC2) + Karpenter for fast, cost-efficient node
     autoscaling (Spot-friendly).
   • IRSA gives each app's pods a scoped IAM role → pods read secrets from
     Secrets Manager (Section 27) and pull from ECR — no stored creds.
   • AWS Load Balancer Controller provisions an ALB for Ingress.
   • Container Insights for monitoring; Helm + Argo CD (Section 48) for
     deployments (GitOps).
Because it's standard Kubernetes, the same manifests/Helm charts also run
on AKS — portable. (Main trade-off vs AKS: EKS control plane has a fee.)
```

---

## 46.6 Interview Q&A

**Q: What is EKS and how does it differ from AKS?** → AWS's managed Kubernetes — AWS runs the control plane, you run worker nodes (EC2 node groups, Fargate, or Karpenter). It's the equivalent of AKS, with standard Kubernetes tooling. Key difference: EKS charges an hourly control-plane fee, whereas AKS's control plane is free.
**Q: How do EKS pods get AWS permissions?** → Via IRSA (IAM Roles for Service Accounts) or EKS Pod Identity — associating an IAM role with a Kubernetes service account so pods get short-lived credentials, with no node-wide or hardcoded keys. It's the AWS equivalent of AKS Workload Identity.
**Q: ECS vs EKS — when each?** → ECS for AWS-native simplicity (no Kubernetes knowledge); EKS when you need full Kubernetes, its ecosystem, or portability across clouds.

## 46.7 Summary

EKS is AWS's managed Kubernetes (≈ Azure AKS) — AWS runs the control plane (with an hourly fee, unlike AKS's free control plane), you run worker nodes (Managed Node Groups, Fargate profiles, or Karpenter). It integrates via IRSA (pods → IAM roles, like AKS Workload Identity), ECR, the AWS Load Balancer Controller (ALB/NLB), VPC CNI, and Container Insights, while using standard portable Kubernetes tooling. Choose EKS for full Kubernetes/portability, ECS for AWS-native simplicity.

---
---

# 47. 🚪 ECS/EKS Ingress & Service Discovery
> 🟠 MEDIUM

---

## 47.1 What Problem Does This Solve?

Containers need (a) a way to receive external traffic routed intelligently, and (b) a way to find and reach each other internally. This section covers **ingress/load balancing** and **service discovery** for ECS and EKS.

> 💡 **If you know Azure:** EKS Ingress ≈ AKS Ingress (NGINX / Application Gateway Ingress Controller). AWS's AWS Load Balancer Controller provisions ALBs for Ingress. Service discovery via Kubernetes DNS / AWS Cloud Map ≈ Kubernetes DNS on AKS.

---

## 47.2 Ingress & Service Discovery (Flow Diagram)

```
EXTERNAL TRAFFIC (Ingress / load balancing):
   EKS: an INGRESS resource + the AWS LOAD BALANCER CONTROLLER →
        provisions an ALB → routes /api/* → service-A, /web → service-B
        (or a Service of type LoadBalancer → an NLB)
   ECS: a SERVICE registered with an ALB/NLB target group → path/host
        routing via the ALB listener rules

INTERNAL SERVICE DISCOVERY (services finding each other):
   EKS: Kubernetes DNS — call "http://service-name" → resolves to the
        service's pods automatically
   ECS: AWS Cloud Map (ECS Service Discovery) — services register DNS
        names → other services resolve them (e.g., "catalog.local")
```

---

## 47.3 Key Facts

```
✅ EKS Ingress needs an INGRESS CONTROLLER (AWS Load Balancer Controller for
   native ALB, or NGINX) — the controller executes the Ingress rules
✅ One ALB via Ingress can route to MANY services by path/host (vs one LB
   per service) — cost-efficient
✅ ECS integrates services directly with ALB/NLB target groups
✅ Service discovery: Kubernetes DNS (EKS) or AWS Cloud Map (ECS) → services
   reach each other by name, not hardcoded IPs
✅ Backend services stay internal (ClusterIP / private) — only the ingress
   is public
```

---

## 47.4 Steps

```
📍 EKS: install the AWS Load Balancer Controller → apply an Ingress
   resource (path/host rules) → it provisions an ALB.
📍 ECS: create a Service → attach an ALB target group → add ALB listener
   rules for path/host routing; enable Service Discovery (Cloud Map) for
   internal names.
```

---

## 47.5 Real-World Example

```
An 8-microservice app on EKS:
   • ONE ALB via an Ingress (AWS Load Balancer Controller) routes:
       /api/catalog → catalog-svc, /api/orders → orders-svc, / → web-svc
     — one public entry point, one domain, one cert (WAF attachable).
   • Backend services are ClusterIP (internal only).
   • Services find each other via Kubernetes DNS ("http://catalog-svc").
On ECS, the same idea uses ALB target groups + Cloud Map for internal names.
Mirrors AKS Ingress + Kubernetes DNS.
```

---

## 47.6 Interview Q&A

**Q: How do you expose many microservices on EKS with one entry point?** → Use an Ingress resource with the AWS Load Balancer Controller, which provisions a single ALB that routes to many internal services by path/host — instead of one load balancer per service. Backend services stay internal (ClusterIP).
**Q: How do services find each other internally?** → On EKS via Kubernetes DNS (call a service by name); on ECS via AWS Cloud Map service discovery (services register DNS names). No hardcoded IPs — resolution is automatic.
**Q: What's the difference between an Ingress and an Ingress Controller?** → The Ingress is the routing rules (a K8s resource); the Ingress Controller (AWS Load Balancer Controller or NGINX) is the software that reads those rules and provisions/configures the actual load balancer. You need both.

## 47.7 Summary

For external traffic, EKS uses an Ingress + the AWS Load Balancer Controller (provisioning one ALB to route many services by path/host) or a LoadBalancer Service (NLB); ECS registers Services with ALB/NLB target groups. For internal service discovery, EKS uses Kubernetes DNS and ECS uses AWS Cloud Map — services reach each other by name, not IP, with backends kept internal. This mirrors AKS Ingress + Kubernetes DNS.

---
---

# 48. ⎈ Helm & GitOps (Argo CD / Flux)
> 🟠 MEDIUM

---

## 48.1 What Problem Does This Solve?

Managing many Kubernetes YAMLs is painful (Helm packages them), and pushing changes imperatively from a pipeline is less auditable than declaratively syncing from Git (GitOps). Both are standard on EKS.

> 💡 **If you know Azure:** Helm is identical on EKS and AKS (Kubernetes-native). GitOps (Argo CD/Flux) also works the same on both — the Azure notes covered Helm; GitOps applies equally here.

---

## 48.2 Helm + GitOps (Flow Diagram)

```
HELM (package manager for Kubernetes):
   Chart (templated YAML + values.yaml) → helm install/upgrade/rollback →
   deploy a whole multi-resource app as one versioned unit;
   per-env values files (dev/prod); instant rollback (helm rollback)

GITOPS (Argo CD / Flux):
   Desired state lives in GIT (manifests/Helm charts) →
   Argo CD / Flux runs IN the cluster and CONTINUOUSLY SYNCS the cluster
   to match Git (pull-based) →
   change Git → the tool reconciles the cluster automatically →
   drift from Git is auto-corrected; Git is the single source of truth
```

---

## 48.3 Helm vs GitOps (Complementary)

```
Helm = HOW you package/template/version a K8s app (deploy/upgrade/rollback).
GitOps = HOW deployments happen: the cluster PULLS desired state from Git
         (via Argo CD/Flux) and self-heals to match it, rather than a
         pipeline PUSHING kubectl/helm commands.

They combine: store Helm charts in Git; Argo CD/Flux syncs them to the cluster.
```

---

## 48.4 Key Facts

```
✅ Helm: Charts (templates + values), versioned Releases, helm upgrade/
   rollback, per-env values files, huge public chart ecosystem
✅ GitOps: Git = source of truth; Argo CD/Flux continuously reconcile the
   cluster to Git; auto-corrects drift; pull-based (more secure — no cluster
   creds in the pipeline)
✅ Argo CD has a UI showing sync status; Flux is lightweight/CLI-first
✅ GitOps improves auditability (every change is a Git commit) + rollback
   (revert the Git commit)
```

---

## 48.5 Steps

```
📍 Helm: helm install app ./chart -f values-prod.yaml · helm upgrade · helm rollback
📍 GitOps: install Argo CD/Flux in the cluster → point it at a Git repo of
   manifests/Helm charts → it auto-syncs; you deploy by committing to Git.
```

---

## 48.6 Real-World Example

```
An 8-service app on EKS uses Helm + Argo CD:
   • Each service is a Helm chart; values-dev/values-prod configure per env.
   • Charts live in a Git repo; Argo CD (running in the cluster) watches it.
   • A developer merges a chart change → Argo CD detects it → syncs the
     cluster to match → the app updates. No pipeline pushes kubectl commands.
   • Rollback = revert the Git commit → Argo CD reconciles back.
   • Argo CD's UI shows real-time sync/health status.
Pull-based GitOps means no cluster credentials in the CI pipeline (more
secure). Same approach works identically on AKS.
```

---

## 48.7 Interview Q&A

**Q: What is Helm?** → The Kubernetes package manager — bundles an app's YAML into a versioned, parameterized Chart, deployed with one command, configured per-env via values files, with easy upgrade/rollback. Identical on EKS and AKS.
**Q: What is GitOps and how do Argo CD/Flux work?** → GitOps makes Git the single source of truth for cluster state; a tool running in the cluster (Argo CD or Flux) continuously pulls from Git and reconciles the cluster to match, auto-correcting drift. Deployments happen by committing to Git; rollback is reverting a commit. It's pull-based (no cluster creds in the pipeline) and highly auditable.
**Q: Helm vs GitOps?** → Complementary: Helm packages/templates/versions the app; GitOps is the delivery model (cluster pulls desired state from Git and self-heals). Store Helm charts in Git and let Argo CD/Flux sync them.

## 48.8 Summary

Helm is the Kubernetes package manager (versioned, parameterized Charts; per-env values; easy upgrade/rollback), and GitOps (Argo CD/Flux) is a delivery model where the cluster continuously pulls its desired state from Git and self-heals to match — auditable (every change is a commit), with rollback = git revert, and pull-based so no cluster creds live in the pipeline. They combine: Helm charts in Git, synced by Argo CD/Flux. Both work identically on EKS and AKS.

---
---

# 49. 📈 Container Autoscaling (HPA / Cluster Autoscaler / Karpenter)
> 🟠 MEDIUM

---

## 49.1 What Problem Does This Solve?

Container workloads must scale on two levels: enough **pods/tasks** for the load, and enough **nodes** to run them. EKS uses HPA (pods) + Cluster Autoscaler or **Karpenter** (nodes); ECS uses Service Auto Scaling (tasks) + capacity providers.

> 💡 **If you know Azure:** HPA is identical on EKS and AKS. Cluster Autoscaler ≈ the AKS Cluster Autoscaler. **Karpenter** is an AWS-native, smarter/faster node autoscaler with no direct AKS equivalent — worth calling out.

---

## 49.2 Two-Level Scaling on EKS (Flow Diagram)

```
Load ↑
   LEVEL 1 — HPA (Horizontal Pod Autoscaler): scales POD replicas on metrics
             (CPU/memory/custom) → more pods
        ↓ pods can't be scheduled (no room)?
   LEVEL 2 — CLUSTER AUTOSCALER or KARPENTER: adds NODES to fit the pods
        ↓
   pods schedule onto new nodes → load handled
Load ↓ → HPA removes pods → node autoscaler removes empty nodes → cost drops

ECS equivalent: Service Auto Scaling scales TASKS; capacity providers /
Fargate handle the underlying capacity.
```

---

## 49.3 Cluster Autoscaler vs Karpenter (AWS-Specific)

```
CLUSTER AUTOSCALER: scales EC2 node GROUPS (Auto Scaling Groups) up/down
   based on pending pods — works, but tied to predefined node group sizes.

KARPENTER (AWS-native, modern): watches pending pods and provisions
   RIGHT-SIZED nodes DIRECTLY and FAST (picks optimal instance types,
   Spot-friendly, no rigid node groups) → faster, more efficient, cheaper.
   → increasingly the preferred node autoscaler on EKS.
```

| | HPA | Cluster Autoscaler | Karpenter |
|---|---|---|---|
| Scales | Pods | Nodes (via node groups) | Nodes (directly, right-sized) |
| Speed/efficiency | — | Standard | Faster, picks optimal/Spot instances |
| AKS equivalent | HPA (same) | AKS Cluster Autoscaler | (no direct equivalent) |

---

## 49.4 Key Facts

```
✅ HPA scales pods on metrics (identical on EKS/AKS)
✅ Cluster Autoscaler scales EC2 node groups based on pending pods
✅ KARPENTER: AWS-native, provisions right-sized nodes fast (Spot-friendly),
   often preferred over Cluster Autoscaler on EKS — a good interview mention
✅ ECS: Service Auto Scaling (tasks) + capacity providers / Fargate
✅ HPA + node autoscaler work together (pods, then nodes to fit them)
```

---

## 49.5 Real-World Example

```
A web app on EKS handling daily spikes:
   • HPA keeps the "web" deployment between 3-20 pods targeting 70% CPU.
   • KARPENTER provisions right-sized nodes (mixing Spot) as pods go
     pending, and removes them when idle — faster and cheaper than
     Cluster Autoscaler's fixed node groups.
Spike: CPU rises → HPA adds pods → some pending → Karpenter launches
optimal nodes in seconds → pods schedule. After: HPA removes pods →
Karpenter removes empty nodes → cost returns to baseline.
(HPA is identical to AKS; Karpenter is the AWS-native edge.)
```

---

## 49.6 Interview Q&A

**Q: How does autoscaling work on EKS?** → Two levels: the HPA scales pod replicas based on metrics (CPU/memory/custom); when pods can't be scheduled, a node autoscaler (Cluster Autoscaler or Karpenter) adds nodes to fit them. They work together — HPA adds pods, the node autoscaler adds nodes. Scaling down reverses it, so cost tracks demand.
**Q: Cluster Autoscaler vs Karpenter?** → Cluster Autoscaler scales predefined EC2 node groups based on pending pods. Karpenter is an AWS-native, modern autoscaler that provisions right-sized nodes directly and fast (choosing optimal instance types, Spot-friendly, no rigid node groups) — increasingly preferred on EKS for speed and cost efficiency.
**Q: How does ECS autoscale?** → Service Auto Scaling scales the number of tasks (on metrics), with capacity providers or Fargate handling the underlying capacity.

## 49.7 Summary

Container autoscaling works at two levels: HPA scales pods on metrics (identical on EKS/AKS), and a node autoscaler adds nodes to fit them — either the Cluster Autoscaler (scales EC2 node groups) or **Karpenter** (AWS-native, provisions right-sized nodes fast, Spot-friendly — increasingly preferred on EKS). ECS uses Service Auto Scaling for tasks + capacity providers/Fargate. HPA + node autoscaler cooperate so capacity (and cost) tracks demand. Karpenter is the notable AWS-native differentiator with no direct AKS equivalent.

---

---
---

# 50. ⚡ AWS Lambda
> 🔴 FULL

---

## 50.1 What Problem Does This Solve?

You want to run code in response to events without provisioning or managing servers — scaling automatically and paying only when it runs. **AWS Lambda** is AWS's serverless compute service and the heart of serverless architectures.

> 💡 **If you know Azure:** Lambda is the direct equivalent of **Azure Functions**. Triggers/event sources ≈ Functions triggers; execution role ≈ the Functions Managed Identity/role; cold starts and concurrency concepts are parallel.

---

## 50.2 How It Works (Flow Diagram)

```
An EVENT occurs (trigger) → Lambda runs your FUNCTION → does its job → stops.
You pay ONLY for execution time (ms) + requests. Auto-scales from 0 to
thousands of concurrent executions.

TRIGGERS / EVENT SOURCES:
   • API Gateway (HTTP request) — Section 51
   • S3 (object created/deleted) — Section 52
   • SQS / SNS / EventBridge — Sections 53-55
   • DynamoDB Streams / Kinesis (stream processing) — Sections 57-58
   • EventBridge Scheduler (cron)

INVOCATION TYPES:
   Synchronous  — caller waits (API Gateway → Lambda → response)
   Asynchronous — event queued, fire-and-forget (S3, SNS)
   Stream/poll  — Lambda polls & batches (SQS, DynamoDB Streams, Kinesis)
```

---

## 50.3 Key Concepts

| Concept | What It Is |
|---|---|
| **Execution Role** | IAM role Lambda assumes → its AWS permissions (≈ Functions role) |
| **Cold start** | First invocation after idle is slower (spinning up) |
| **Provisioned Concurrency** | Pre-warmed instances → no cold starts (like Functions Premium plan) |
| **Memory/Timeout** | Configurable (up to 10 GB memory; max **15-min** timeout) |
| **Layers** | Shared code/dependencies across functions |
| **Env variables** | Config; secrets referenced from Secrets Manager/Parameter Store |
| **VPC-connected** | Lambda can run in a VPC to reach private resources (RDS, etc.) |
| **Lambda@Edge** | Run Lambda at CloudFront edge locations |

---

## 50.4 Key Facts

```
✅ Serverless: no servers to manage; auto-scales; pay per invocation + ms of runtime
✅ Max timeout = 15 minutes (long jobs → use Step Functions/ECS/Batch instead)
✅ Cold starts on idle → Provisioned Concurrency eliminates them (for latency-
   sensitive/user-facing functions)
✅ Execution role = its AWS permissions (least privilege; no stored keys)
✅ Runtimes: Node.js, Python, Java, Go, .NET, Ruby, + custom
✅ Secrets via Secrets Manager/Parameter Store at runtime (or the Parameters
   & Secrets Lambda Extension for caching) — never hardcoded
✅ VPC-connect it to reach private resources; Lambda@Edge for CDN logic
```

---

## 50.5 UI Steps

```
📍 Console → Lambda → Create function → runtime + execution role → add a
   trigger (API Gateway/S3/SQS/EventBridge) → write/upload code → set
   memory/timeout → (optionally) Provisioned Concurrency + VPC config
📍 CLI: aws lambda create-function / add trigger via event source mapping
```

---

## 50.6 Real-World Example

```
An image-processing pipeline (classic serverless):
   User uploads to S3 → S3 event triggers Lambda (async) → Lambda resizes
   the image (execution role allows S3 read/write), writes thumbnails back
   to S3, updates DynamoDB. Fetches any secret from Secrets Manager at
   runtime. Auto-scales to handle spikes; costs nothing when idle.
   For a user-facing API function, Provisioned Concurrency avoids cold-start
   latency. For a >15-min job, they'd use Step Functions or Batch instead.
Directly equivalent to an Azure Functions Blob-trigger image pipeline.
```

---

## 50.7 Interview Q&A

**Q: What is Lambda and when do you use it?** → AWS's serverless compute — runs code in response to triggers (API Gateway, S3, SQS, EventBridge, streams), auto-scales from zero, and charges per invocation + runtime. Use it for event-driven, unpredictable, or short-lived workloads. It's the equivalent of Azure Functions.
**Q: What's the Lambda timeout limit and what if a job needs longer?** → 15 minutes max. For longer jobs, use Step Functions (orchestrate multiple steps), ECS/Fargate, or AWS Batch.
**Q: How do you handle cold starts?** → Use Provisioned Concurrency to keep instances pre-warmed for latency-sensitive/user-facing functions (like the Azure Functions Premium plan). For background tasks, occasional cold starts are usually acceptable.
**Q: How does Lambda get AWS permissions and secrets?** → Via its execution role (IAM, least-privilege, no stored keys), and it fetches secrets from Secrets Manager/Parameter Store at runtime — never hardcoded.

## 50.8 Summary

AWS Lambda is serverless compute (≈ Azure Functions) — runs code on triggers (API Gateway, S3, SQS, EventBridge, DynamoDB/Kinesis streams), auto-scales from zero, and charges per invocation + runtime. Key limits/features: 15-min max timeout (use Step Functions/Batch for longer), Provisioned Concurrency to eliminate cold starts, an execution role for permissions (no stored keys), secrets from Secrets Manager at runtime, VPC connectivity for private resources, and Lambda@Edge for CDN logic. It's the heart of event-driven serverless architectures.

---
---

# 51. 🚪 API Gateway
> 🔴 FULL

---

## 51.1 What Problem Does This Solve?

You need a managed "front door" for APIs — handling routing, authentication, throttling, and scaling — especially in front of Lambda (serverless APIs) or backend services. **API Gateway** provides this.

> 💡 **If you know Azure:** API Gateway is roughly the equivalent of **Azure API Management** (managed API front door) — though API Gateway is also the standard way to expose Lambda as an HTTP API (a very common serverless pattern). It supports REST, HTTP, and WebSocket APIs.

---

## 51.2 How It Works (Flow Diagram)

```
Clients → API GATEWAY (managed front door) → backend:
   • Lambda (serverless API — most common)
   • HTTP endpoints / ALB / EC2 / other services

API Gateway handles:
   • Routing (paths/methods → backends)
   • AUTH (IAM, Cognito user pools, Lambda authorizers, API keys)
   • THROTTLING / rate limiting + usage plans
   • Request/response transformation, validation
   • Caching · CORS · custom domains + TLS
   • Stages (dev/prod) + versioning

API TYPES:
   REST API      — full-featured (transformations, caching, API keys)
   HTTP API      — simpler, cheaper, faster (most Lambda/proxy use cases)
   WebSocket API — real-time two-way (chat, live updates, notifications)
```

---

## 51.3 Key Facts

```
✅ The standard way to expose Lambda as an HTTP API (serverless backend)
✅ Auth options: IAM, Cognito (user pools), Lambda authorizers (custom),
   API keys + usage plans (throttling per client)
✅ Throttling/rate-limiting protects backends from overload/abuse
✅ Three types: REST (full-featured), HTTP (simple/cheap/fast), WebSocket
   (real-time)
✅ Stages (dev/prod) with stage variables; canary deployments on a stage
✅ Caching + request validation reduce backend load
```

---

## 51.4 UI Steps

```
📍 Console → API Gateway → Create API (HTTP/REST/WebSocket) → define
   routes/methods → integrate with Lambda (or HTTP backend) → configure
   auth (Cognito/IAM/authorizer) + throttling + a stage → Deploy
📍 CLI/SAM: often defined in SAM/CloudFormation alongside the Lambda
```

---

## 51.5 Real-World Example

```
A serverless REST API:
   Clients → API Gateway (HTTP API) → Lambda functions → DynamoDB
   • Cognito user pool authorizer for authentication.
   • Throttling + usage plans limit each client (protect the backend).
   • Stages: /dev and /prod; canary on the prod stage for safe rollouts.
   • Custom domain (api.myapp.com) + TLS via ACM.
This "API Gateway → Lambda → DynamoDB" is the canonical serverless
architecture — the AWS parallel to API Management → Functions → Cosmos DB
on Azure.
```

---

## 51.6 Interview Q&A

**Q: What is API Gateway and what does it do?** → A managed API front door that handles routing, authentication (IAM/Cognito/Lambda authorizers/API keys), throttling/rate-limiting, transformation, caching, and TLS — most commonly exposing Lambda functions as HTTP APIs. Roughly the equivalent of Azure API Management, and the standard serverless API layer.
**Q: REST vs HTTP vs WebSocket API?** → REST is full-featured (transformations, caching, API keys); HTTP is simpler, cheaper, and faster (best for most Lambda/proxy use cases); WebSocket enables real-time two-way communication (chat, live updates).
**Q: How do you protect an API Gateway backend?** → Throttling and usage plans (rate-limit per client), authentication (Cognito/IAM/Lambda authorizers), request validation, and caching to reduce backend load.

## 51.7 Summary

API Gateway is AWS's managed API front door — routing, authentication (IAM/Cognito/Lambda authorizers/API keys), throttling, transformation, caching, and TLS — and the standard way to expose Lambda as an HTTP API. It offers REST (full-featured), HTTP (simple/cheap/fast), and WebSocket (real-time) API types, with stages and canary deployments. The canonical serverless pattern is API Gateway → Lambda → DynamoDB, roughly paralleling Azure API Management → Functions → Cosmos DB.

---
---

# 52. 🪣 Amazon S3
> 🔴 FULL

---

## 52.1 What Problem Does This Solve?

You need durable, virtually unlimited object storage for any file — images, videos, backups, logs, data lakes, static sites. **S3 (Simple Storage Service)** is AWS's object storage, and one of its most fundamental services (also central to Terraform state, artifacts, data lakes).

> 💡 **If you know Azure:** S3 is the direct equivalent of Azure **Blob Storage**. Buckets ≈ containers (but S3 bucket names are globally unique); storage classes ≈ access tiers; pre-signed URLs ≈ SAS tokens; S3 events ≈ Blob events via Event Grid.

---

## 52.2 Core Concepts & Storage Classes (Flow Diagram)

```
S3 = objects (files) stored in BUCKETS (globally-unique names).
   URL: https://my-bucket.s3.amazonaws.com/path/to/object

STORAGE CLASSES (cost vs access):
   S3 Standard              → frequent access (default)
   S3 Standard-IA           → infrequent access, min 30 days
   S3 One Zone-IA           → infrequent, single AZ (cheaper, less durable)
   S3 Intelligent-Tiering   → auto-moves objects between tiers (no thinking)
   S3 Glacier Instant/Flexible/Deep Archive → archival (cheapest; retrieval
                              from instant → hours → up to 12h for Deep Archive)

LIFECYCLE POLICIES auto-transition objects between classes as they age
(e.g., Standard → IA at 30d → Glacier at 90d → delete at 365d).
```

---

## 52.3 Key Features

| Feature | What It Does |
|---|---|
| **Durability** | 11 nines (99.999999999%) — data spread across multiple AZs |
| **Versioning** | Keep every version of an object (recover from overwrite/delete) |
| **Lifecycle policies** | Auto-tier/expire objects to control cost |
| **Encryption** | SSE-S3, SSE-KMS (customer-managed keys), or client-side |
| **Access control** | Bucket policies, IAM, ACLs, **Block Public Access** (default on) |
| **Pre-signed URLs** | Time-limited scoped access to an object (≈ SAS token) |
| **S3 Events** | Trigger Lambda/SQS/SNS/EventBridge on object create/delete |
| **Static website hosting** | Host a static site directly from a bucket |
| **Cross-Region Replication** | Async replicate objects to another region |
| **Object Lock** | WORM (write-once-read-many) for compliance |

---

## 52.4 Security Best Practices

```
✅ Block Public Access is ON by default — keep it on unless truly needed
✅ Prefer IAM roles / bucket policies over ACLs
✅ Grant temporary access via PRE-SIGNED URLs (like SAS tokens), not public buckets
✅ Encrypt at rest (SSE-KMS for customer-controlled keys)
✅ Enable versioning + (optionally) Object Lock for critical data
✅ Least-privilege bucket policies; use VPC Gateway Endpoints (Section 16) for
   private access + NAT cost savings
```

---

## 52.5 UI/CLI Steps

```
📍 Console → S3 → Create bucket (unique name, region, Block Public Access ON,
   encryption, versioning) → upload objects → set a lifecycle rule
📍 Pre-signed URL: aws s3 presign s3://bucket/key --expires-in 3600
📍 CLI: aws s3 cp / sync ; aws s3api put-bucket-policy / put-lifecycle-configuration
```

---

## 52.6 Real-World Example

```
A media platform on S3:
   • Videos uploaded to S3 Standard; a LIFECYCLE policy moves them to
     Standard-IA (30d) → Glacier (180d) → controls cost as content ages.
   • Versioning + Object Lock on a compliance bucket (WORM).
   • Block Public Access ON; users download their own files via time-
     limited PRE-SIGNED URLs (not public).
   • S3 EVENT on upload → triggers a Lambda to generate thumbnails.
   • Served globally via CloudFront (S3 as origin).
   • Terraform state lives in a separate versioned, encrypted S3 bucket
     (Section 37).
Directly mirrors an Azure Blob Storage media pipeline with tiers + SAS +
Event Grid → Functions.
```

---

## 52.7 Interview Q&A

**Q: What are S3 storage classes and lifecycle policies?** → Storage classes trade cost vs access speed: Standard (frequent), Standard-IA/One Zone-IA (infrequent), Intelligent-Tiering (auto-moves), and Glacier tiers (archival, cheapest, retrieval from instant to ~12h). Lifecycle policies automatically transition/expire objects as they age to control cost. (≈ Azure Blob access tiers.)
**Q: How do you give someone temporary access to an S3 object without making the bucket public?** → A pre-signed URL — a time-limited, scoped URL granting access to a specific object without exposing the bucket or sharing credentials (equivalent to an Azure SAS token).
**Q: How do you secure an S3 bucket?** → Keep Block Public Access on (default), use IAM/bucket policies (not ACLs), encrypt at rest (SSE-KMS), enable versioning (+ Object Lock for compliance), grant temporary access via pre-signed URLs, and use VPC Gateway Endpoints for private access.
**Q: How does S3 achieve durability?** → 11 nines durability by automatically storing data redundantly across multiple Availability Zones.

## 52.8 Summary

Amazon S3 is AWS's durable (11 nines), virtually unlimited object storage (≈ Azure Blob Storage) — objects in globally-named buckets, with storage classes (Standard → IA → Intelligent-Tiering → Glacier) and lifecycle policies to control cost. Key features: versioning, encryption (SSE-KMS), Block Public Access (default on), pre-signed URLs for temporary access (≈ SAS tokens), S3 Events (trigger Lambda/SQS/SNS/EventBridge), static hosting, cross-region replication, and Object Lock (WORM). It's foundational — also backing Terraform state, artifacts, and data lakes.

---
---

# 53. 📬 Amazon SQS
> 🔴 FULL

---

## 53.1 What Problem Does This Solve?

To build decoupled, resilient systems, components shouldn't call each other directly (a failure cascades). **SQS (Simple Queue Service)** is a managed message queue that decouples producers from consumers — messages wait safely until processed.

> 💡 **If you know Azure:** SQS is the equivalent of Azure **Queue Storage** (Standard) / **Service Bus Queues** (FIFO/advanced) — a managed queue for decoupling. SQS Standard ≈ Storage Queues; SQS FIFO ≈ Service Bus queues with ordering/exactly-once.

---

## 53.2 How It Works (Flow Diagram)

```
Producer → sends message → SQS QUEUE → Consumer polls & processes → deletes it

Decoupling: if the consumer is down/slow, messages WAIT in the queue —
no data lost, producer unblocked.

QUEUE TYPES:
   Standard FIFO Queue → at-least-once delivery, best-effort ordering,
                         nearly unlimited throughput (most use cases)
   FIFO Queue          → exactly-once processing, strict ordering,
                         limited throughput (order/dedup matters)

Key concepts:
   Visibility Timeout — message hidden while a consumer processes it;
                        reappears if not deleted (consumer crashed)
   Dead-Letter Queue (DLQ) — messages that fail repeatedly go here for
                             investigation (instead of retrying forever)
   Long polling — efficient waiting for messages (reduces empty polls/cost)
```

---

## 53.3 Standard vs FIFO (Comparison)

| | Standard Queue | FIFO Queue |
|---|---|---|
| Ordering | Best-effort | Strict (per message group) |
| Delivery | At-least-once (possible dups) | Exactly-once (dedup) |
| Throughput | Nearly unlimited | Limited (higher with batching) |
| Use for | Most decoupling/work queues | Order/exactly-once critical (payments, sequences) |

---

## 53.4 Key Facts

```
✅ Decouples producers from consumers → resilience (failures don't cascade)
✅ Standard (high throughput, at-least-once) vs FIFO (ordered, exactly-once)
✅ Visibility Timeout hides a message during processing; DLQ captures repeated failures
✅ Triggers Lambda (event source mapping) → auto-scale processing
✅ Worker fleets (EC2/ECS ASG) can scale on queue depth (CloudWatch metric)
✅ Messages retained up to 14 days; max message size 256 KB (larger via S3 pointer)
```

---

## 53.5 UI/CLI Steps

```
📍 Console → SQS → Create queue (Standard/FIFO) → set visibility timeout +
   a DLQ (redrive policy) → hook a Lambda trigger or have workers poll it
📍 CLI: aws sqs create-queue / send-message / receive-message / delete-message
```

---

## 53.6 Real-World Example

```
An order system decoupled with SQS:
   Order service → sends "process payment" message to SQS → responds to the
   customer immediately ("Order received!").
   Payment workers (ECS, scaled by queue depth) poll SQS → process payments.
   If a payment fails repeatedly → the message goes to a DLQ → a CloudWatch
   alarm on DLQ size alerts the team to investigate.
   If the payment service is down, orders wait safely in the queue — no
   data lost, the order service unaffected.
   For strict payment ordering, they'd use a FIFO queue.
This is the classic decoupling pattern — Azure equivalent: Storage Queue /
Service Bus.
```

---

## 53.7 Interview Q&A

**Q: What is SQS and why use it?** → A managed message queue that decouples producers from consumers so components don't call each other directly — messages wait safely in the queue if the consumer is down/slow, preventing cascading failures. It's the equivalent of Azure Queue Storage / Service Bus Queues.
**Q: Standard vs FIFO queue?** → Standard = best-effort ordering, at-least-once delivery (possible duplicates), nearly unlimited throughput — for most work queues. FIFO = strict ordering + exactly-once processing at limited throughput — when order/deduplication matters (e.g., payments).
**Q: What are Visibility Timeout and DLQ?** → Visibility Timeout hides a message while a consumer processes it (it reappears if not deleted, e.g., the consumer crashed). A Dead-Letter Queue captures messages that fail processing repeatedly, so they can be investigated instead of retried forever.

## 53.8 Summary

Amazon SQS is a managed message queue that decouples producers from consumers for resilient, scalable systems (≈ Azure Queue Storage / Service Bus). Standard queues offer high throughput with at-least-once delivery and best-effort ordering; FIFO queues offer strict ordering and exactly-once processing at limited throughput. Visibility Timeout hides in-flight messages, DLQs capture repeated failures, it triggers Lambda or scales worker fleets by queue depth, and messages are retained up to 14 days — the foundation of decoupled architectures.

---
---

# 54. 📢 Amazon SNS
> 🟠 MEDIUM

---

## 54.1 What Problem Does This Solve?

Sometimes one event needs to notify *many* subscribers at once (fan-out), or send notifications (email/SMS/push). **SNS (Simple Notification Service)** is a managed pub/sub messaging service — publish once, deliver to many.

> 💡 **If you know Azure:** SNS combines aspects of Azure **Event Grid** (pub/sub fan-out) and **Notification Hubs** (mobile push) plus basic email/SMS. Publish→multiple subscribers is the core parallel.

---

## 54.2 How It Works — Pub/Sub Fan-Out (Flow Diagram)

```
Publisher → SNS TOPIC → delivers to ALL subscribers simultaneously:
   ├── SQS queue(s)      (fan-out for parallel processing)
   ├── Lambda function(s)
   ├── HTTP/HTTPS endpoints
   ├── Email / SMS
   └── Mobile push (APNs/FCM)

PUSH model (SNS pushes to subscribers) vs SQS's PULL model (consumers poll).

CLASSIC FAN-OUT: SNS topic → multiple SQS queues → each processed
independently (e.g., one event triggers order-processing + analytics +
notifications in parallel).
```

---

## 54.3 SNS vs SQS (Commonly Compared)

```
SNS = PUSH pub/sub → one message to MANY subscribers (fan-out, notifications)
SQS = PULL queue   → one message to ONE consumer (decoupled work queue)

Combined (fan-out pattern): SNS topic → several SQS queues → durable,
parallel processing by multiple independent consumers. Very common.
```

---

## 54.4 Key Facts

```
✅ Pub/sub push model: publish once → all subscribers get it
✅ Subscriber types: SQS, Lambda, HTTP(S), email, SMS, mobile push
✅ Fan-out pattern (SNS → multiple SQS queues) = parallel, durable processing
✅ Message filtering: subscribers receive only messages matching a filter policy
✅ FIFO topics available (ordered, with FIFO SQS subscribers)
✅ Often the entry point that S3/CloudWatch/etc. publish events to
```

---

## 54.5 Steps

```
📍 Console → SNS → Create topic → Create subscriptions (SQS/Lambda/email/SMS)
   → publish a message → all subscribers receive it
📍 CLI: aws sns create-topic / subscribe / publish
```

---

## 54.6 Real-World Example

```
Order-placed event fan-out:
   Order service → publishes to an SNS "order-events" topic →
     ├── SQS → payment-processing worker
     ├── SQS → inventory-update worker
     ├── SQS → analytics pipeline
     └── Lambda → send the customer a confirmation email
   All four happen in parallel from one publish, each independent and
   durable (SQS). This SNS→SQS fan-out is one of the most common AWS
   messaging patterns — mirrors Azure Event Grid fan-out to queues.
```

---

## 54.7 Interview Q&A

**Q: What is SNS and how does it differ from SQS?** → SNS is a managed pub/sub service that pushes one message to many subscribers (SQS, Lambda, HTTP, email, SMS, mobile push) — fan-out and notifications. SQS is a pull-based queue delivering one message to one consumer — decoupled work processing. They're often combined in the fan-out pattern (SNS → multiple SQS queues) for parallel, durable processing.
**Q: What is the SNS→SQS fan-out pattern?** → An SNS topic delivers each published event to multiple subscribed SQS queues, so several independent consumers process the same event in parallel and durably (each queue buffers for its consumer). A very common AWS event-driven pattern.

## 54.8 Summary

Amazon SNS is managed pub/sub — publish once to a topic, and it pushes the message to many subscribers (SQS, Lambda, HTTP, email, SMS, mobile push). It differs from SQS (push/one-to-many vs pull/one-to-one) and they combine in the classic fan-out pattern (SNS → multiple SQS queues) for parallel, durable processing. It covers aspects of Azure Event Grid (fan-out) + Notification Hubs (push) — a core building block of event-driven architectures.

---
---

# 55. 🔔 Amazon EventBridge
> 🔴 FULL

---

## 55.1 What Problem Does This Solve?

Modern event-driven architectures need a smart **event bus** that routes events from many sources (AWS services, SaaS apps, your own apps) to many targets based on rules — with filtering, scheduling, and schema handling. **EventBridge** is AWS's serverless event bus (an evolution beyond basic pub/sub). *(This is a richer eventing service than the Azure notes covered — worth knowing well.)*

> 💡 **If you know Azure:** EventBridge is the closest AWS equivalent to Azure **Event Grid** — a serverless event router with rules/filtering. It's more powerful than SNS for routing (content-based rules, many sources including AWS service events and SaaS partners, scheduling).

---

## 55.2 How It Works (Flow Diagram)

```
EVENT SOURCES → EVENTBRIDGE BUS → (RULES match event patterns) → TARGETS

Sources:  AWS service events (EC2 state change, S3, CodePipeline, etc.),
          your custom app events, SaaS partners (Datadog, Zendesk, etc.)
Rules:    match on event CONTENT/pattern (e.g., {"source":"aws.ec2",
          "detail-type":"EC2 Instance State-change","state":"stopped"})
Targets:  Lambda, SQS, SNS, Step Functions, ECS tasks, Kinesis, other buses...

EventBridge SCHEDULER: cron/rate schedules → trigger targets (replaces
CloudWatch Events scheduled rules).

Schema Registry: discover/validate event schemas.
```

---

## 55.3 EventBridge vs SNS (Key Distinction)

```
SNS         = simple pub/sub fan-out (topic → subscribers); great for
              straightforward one-to-many delivery + notifications.
EVENTBRIDGE = a smart event BUS with content-based RULES/filtering, many
              built-in AWS + SaaS sources, scheduling, and schema handling.
              Better when you need to ROUTE events by content to different
              targets, or react to AWS service events / SaaS events.

Rule of thumb: notifications/simple fan-out → SNS; complex event routing,
AWS-service-event reactions, SaaS integration, scheduling → EventBridge.
```

---

## 55.4 Key Facts

```
✅ Serverless event bus routing events by CONTENT-based rules
✅ Sources: 200+ AWS service events, custom app events, SaaS partners
✅ Targets: Lambda, SQS, SNS, Step Functions, ECS, Kinesis, cross-account buses
✅ EventBridge Scheduler = managed cron/rate scheduling (great for Lambda cron)
✅ Content-based filtering → only matching events reach a target
✅ Schema Registry for event structure discovery/validation
✅ Common for: react to AWS resource state changes, decouple microservices
   via events, scheduled jobs, SaaS event ingestion
```

---

## 55.5 Steps

```
📍 Console → EventBridge → Buses (default or custom) → Rules → Create rule
   → define an EVENT PATTERN (or a schedule) → add TARGET(s) (Lambda/SQS/
   Step Functions/etc.)
📍 CLI: aws events put-rule / put-targets
```

---

## 55.6 Real-World Example

```
Event-driven microservices + ops automation with EventBridge:
   • A custom "OrderPlaced" event → EventBridge rule routes it to the
     payment Lambda, the inventory Step Functions workflow, and an
     analytics Kinesis stream — different targets by content.
   • An AWS EC2 "instance stopped unexpectedly" event → rule triggers a
     Lambda that alerts the team + auto-recovers (ops automation).
   • EventBridge Scheduler runs a nightly cleanup Lambda (cron).
   • A SaaS partner (e.g., a monitoring tool) publishes events → EventBridge
     routes them into the system.
This content-based routing across AWS/custom/SaaS events is what makes
EventBridge more powerful than plain SNS — the AWS analog of Event Grid.
```

---

## 55.7 Interview Q&A

**Q: What is EventBridge and how does it differ from SNS?** → A serverless event bus that routes events from many sources (AWS service events, custom apps, SaaS partners) to many targets based on content-based rules, with filtering, scheduling, and schema handling. SNS is simpler pub/sub fan-out; EventBridge is better when you need to route events by content, react to AWS service events, integrate SaaS events, or schedule jobs. It's the closest AWS equivalent to Azure Event Grid.
**Q: When would you use EventBridge over SNS?** → For complex/content-based event routing, reacting to AWS resource state changes, ingesting SaaS events, or scheduled jobs (EventBridge Scheduler). Use SNS for simple one-to-many notifications/fan-out.
**Q: What's EventBridge Scheduler used for?** → Managed cron/rate scheduling to trigger targets (like a Lambda) on a schedule — the modern replacement for CloudWatch Events scheduled rules.

## 55.8 Summary

Amazon EventBridge is AWS's serverless event bus (≈ Azure Event Grid) — routing events from 200+ AWS services, custom apps, and SaaS partners to targets (Lambda, SQS, SNS, Step Functions, ECS, Kinesis) using content-based rules, with filtering, EventBridge Scheduler (cron), and a Schema Registry. It's more powerful than SNS for event routing and reacting to AWS service events — use EventBridge for complex event-driven architectures and ops automation, SNS for simple notifications/fan-out.

---
---

# 56. 🔀 AWS Step Functions
> 🟠 MEDIUM

---

## 56.1 What Problem Does This Solve?

Complex workflows chaining multiple Lambdas/services — with sequencing, branching, retries, error handling, and waits — become messy and unreliable if hand-coded. **Step Functions** orchestrates them as a visual, managed state machine.

> 💡 **If you know Azure:** Step Functions is the equivalent of Azure **Durable Functions** (stateful serverless orchestration) / **Logic Apps** (workflow orchestration) — coordinating multiple steps with state, retries, and branching, without you managing the orchestration state.

---

## 56.2 How It Works (Flow Diagram)

```
Define a STATE MACHINE (workflow) as a series of STATES:
   Task (do work — a Lambda/ECS/service call)
   Choice (branch on a condition)
   Parallel (run branches concurrently)
   Map (iterate over items)
   Wait (pause)
   with built-in RETRIES + ERROR HANDLING (catch/fallback) per state

Example: Order workflow
   Validate → Choice(valid?) → [yes] Charge Payment → (retry on failure) →
   Reserve Inventory → Send Confirmation
                    → [no] → Notify Failure

Step Functions manages the state, sequencing, retries, and history —
you don't hand-code orchestration logic.

Types: Standard (long-running, auditable, up to 1 year) · Express
(high-volume, short, cheaper).
```

---

## 56.3 Key Facts

```
✅ Visual, managed orchestration of multi-step workflows (state machines)
✅ Built-in RETRIES + error handling (catch/fallback) per state — reliability
✅ States: Task, Choice (branch), Parallel, Map (loop), Wait
✅ Integrates directly with 200+ AWS services (Lambda, ECS, SNS, SQS, etc.)
✅ Standard (long-running/auditable) vs Express (high-volume/short/cheap)
✅ Full execution history → easy debugging/auditing of each run
✅ Replaces brittle hand-coded "Lambda calls Lambda" orchestration
```

---

## 56.4 Steps

```
📍 Console → Step Functions → Create state machine → design visually or in
   ASL (Amazon States Language JSON) → wire states to Lambdas/services →
   set retries/catches → Start execution → watch the visual execution history
```

---

## 56.5 Real-World Example

```
An order-fulfillment workflow orchestrated by Step Functions:
   Validate Order (Lambda) → Choice(valid?) →
     yes → Charge Payment (Lambda, retry 3x on transient errors, catch →
           refund + notify on failure) → Reserve Inventory (Lambda) →
           Send Confirmation (SNS)
     no  → Notify Invalid (SNS)
   Step Functions handles sequencing, retries, branching, and error
   fallback; the visual execution history shows exactly where any run
   succeeded/failed. Far more reliable than chaining Lambdas manually.
Equivalent to an Azure Durable Functions orchestration.
```

---

## 56.6 Interview Q&A

**Q: What are Step Functions and when do you use them?** → A managed service for orchestrating multi-step workflows as visual state machines — sequencing tasks with branching (Choice), parallelism, loops (Map), waits, and built-in retries/error handling. Use them for complex workflows (order fulfillment, ETL, ML pipelines) instead of brittle hand-coded Lambda-calls-Lambda orchestration. They're the equivalent of Azure Durable Functions.
**Q: Standard vs Express workflows?** → Standard for long-running, auditable workflows (up to a year, full history); Express for high-volume, short-duration workflows (cheaper, higher throughput).
**Q: Why use Step Functions over chaining Lambdas directly?** → Built-in retries, error handling, state management, and a visual execution history make workflows reliable and debuggable — hand-coded orchestration is brittle and hard to trace.

## 56.7 Summary

AWS Step Functions orchestrates multi-step workflows as managed, visual state machines — with Task/Choice/Parallel/Map/Wait states, built-in retries and error handling, and integration with 200+ AWS services — so you don't hand-code brittle orchestration. Standard (long-running/auditable) vs Express (high-volume/short) types, with full execution history for debugging. It's the AWS equivalent of Azure Durable Functions, ideal for reliable complex workflows (order processing, ETL, ML pipelines).

---
---

# 57. 🌊 Amazon Kinesis
> 🟡 KNOW-THIS-MUCH

---

## 57.1 What Problem Does This Solve?

You need to ingest and process large volumes of **real-time streaming data** (clickstreams, IoT telemetry, logs, metrics) as it arrives. **Kinesis** is AWS's real-time streaming platform. *(Not deeply covered in the Azure notes — included for serverless/eventing completeness.)*

> 💡 **If you know Azure:** Kinesis is the equivalent of Azure **Event Hubs** (streaming ingestion) / **Stream Analytics**. Kinesis Data Streams ≈ Event Hubs; Kinesis Data Firehose ≈ the managed delivery pipeline to storage/analytics.

---

## 57.2 The Kinesis Family (Flow Diagram)

```
Producers (apps/IoT/logs) → KINESIS → Consumers/destinations

KINESIS DATA STREAMS:
   Real-time, ordered stream (sharded); consumers (Lambda/apps) process
   records in near-real-time; you manage capacity (shards / on-demand).
   ≈ Azure Event Hubs

KINESIS DATA FIREHOSE:
   Fully managed delivery — automatically loads streaming data into S3,
   Redshift, OpenSearch, etc. (with optional transform via Lambda). No
   consumers to manage. ≈ a managed streaming-to-storage pipeline.

(Kinesis Data Analytics: run SQL/Flink on streams for real-time analytics.)
```

---

## 57.3 Key Facts

```
✅ Data Streams = real-time, ordered, sharded streaming (you process records,
   e.g., via Lambda) ≈ Event Hubs
✅ Firehose = managed delivery of streaming data to S3/Redshift/OpenSearch
   (auto-scaling, optional Lambda transform) — no consumer management
✅ Use for: clickstream analytics, IoT telemetry, log/metric ingestion,
   real-time dashboards, ETL into a data lake
✅ Lambda can be a stream consumer (event source mapping) for processing
✅ Streams retain data (hours to days) so consumers can replay
```

---

## 57.4 Real-World Example

```
A platform ingesting clickstream + IoT data:
   Producers (web app, IoT devices) → KINESIS DATA STREAMS →
     • a Lambda consumer computes real-time metrics for a dashboard
     • KINESIS FIREHOSE delivers the raw stream to S3 (data lake) for
       later batch analytics, transforming records via Lambda en route
   Handles millions of records/sec, ordered, with replay if a consumer
   falls behind. Mirrors Azure Event Hubs → Functions + delivery to storage.
```

---

## 57.5 Interview Q&A

**Q: What is Kinesis and when do you use it?** → AWS's real-time streaming platform for ingesting/processing high-volume streaming data (clickstreams, IoT, logs). Data Streams provide real-time ordered sharded streams you process (e.g., via Lambda) ≈ Azure Event Hubs; Firehose is a managed pipeline that auto-delivers streaming data to S3/Redshift/OpenSearch (with optional transform). Use it for real-time analytics, telemetry ingestion, and streaming ETL.
**Q: Data Streams vs Firehose?** → Data Streams = real-time streaming you consume/process yourself (low latency, replay); Firehose = fully managed delivery to storage/analytics destinations with no consumer management.

## 57.6 Summary

Amazon Kinesis is AWS's real-time streaming platform (≈ Azure Event Hubs / Stream Analytics): Data Streams provide ordered, sharded, low-latency streams you process (often via Lambda), while Firehose is a managed pipeline auto-delivering streaming data to S3/Redshift/OpenSearch with optional Lambda transforms. Use it for clickstream analytics, IoT telemetry, log ingestion, and streaming ETL — with retention for replay.

---
---

# 58. ⚡ Amazon DynamoDB
> 🔴 FULL

---

## 58.1 What Problem Does This Solve?

You need a fully managed, serverless NoSQL database with single-digit-millisecond performance at any scale — no servers, automatic scaling, flexible schema. **DynamoDB** is AWS's key-value/document NoSQL database, central to serverless architectures.

> 💡 **If you know Azure:** DynamoDB is the direct equivalent of Azure **Cosmos DB** (specifically its key-value/document usage). Partition key concepts, GSIs, streams, and DAX map to Cosmos DB's partitioning, indexing, change feed, and caching — though Cosmos DB is multi-model with more tunable consistency.

---

## 58.2 Core Concepts (Flow Diagram)

```
DynamoDB = tables of ITEMS (flexible-schema, JSON-like), keyed by:
   PARTITION KEY (hash key) — distributes data (high cardinality = good)
   + optional SORT KEY (range key) — orders items within a partition
   (partition key alone OR partition+sort = the PRIMARY KEY)

Query patterns drive the design (design AROUND access patterns, not
normalization).

INDEXES for querying on non-key attributes:
   GSI (Global Secondary Index) — different partition/sort key; query any attr
   LSI (Local Secondary Index)  — same partition key, different sort key
                                   (created at table creation)
```

---

## 58.3 Key Features

| Feature | What It Does |
|---|---|
| **Capacity modes** | On-Demand (pay per request, auto-scale) or Provisioned (set RCU/WCU + auto-scaling) |
| **DynamoDB Streams** | Change data capture → triggers Lambda on item changes (≈ Cosmos Change Feed) |
| **DAX** | In-memory cache → microsecond reads (≈ using a cache in front of Cosmos) |
| **Global Tables** | Multi-region, active-active replication |
| **TTL** | Auto-expire/delete items after a timestamp (free) |
| **Transactions** | ACID transactions across items |
| **Point-in-time recovery** | Continuous backups |
| **Consistency** | Eventually consistent (default) or strongly consistent reads |

---

## 58.4 Key Facts

```
✅ Serverless NoSQL; single-digit-ms latency at any scale; no servers
✅ Choose a HIGH-CARDINALITY partition key (avoid hot partitions)
✅ Design around ACCESS PATTERNS (denormalize; GSIs for other query patterns)
✅ On-Demand (unpredictable/spiky) vs Provisioned + auto-scaling (steady)
✅ Streams → Lambda for event-driven processing (change data capture)
✅ DAX for read-heavy microsecond caching; Global Tables for multi-region
✅ TTL for auto-cleanup (sessions, temp data); Transactions for ACID needs
✅ Only 2 consistency options (eventual/strong) — Cosmos DB has 5 tunable levels
```

---

## 58.5 UI/CLI Steps

```
📍 Console → DynamoDB → Create table → partition key (+ sort key) →
   capacity mode (On-Demand/Provisioned) → add GSIs → enable Streams/TTL/PITR
📍 CLI: aws dynamodb create-table / put-item / query / get-item
```

---

## 58.6 Real-World Example

```
A food-delivery order-tracking table (millions of live orders):
   Partition key: customerId, Sort key: orderId
   • On-Demand capacity (dinner-rush spikes handled automatically).
   • GSI on (restaurantId, orderTimestamp) → restaurant dashboards.
   • DynamoDB STREAMS → Lambda pushes real-time status updates + notifications.
   • DAX in front for microsecond reads on hot orders.
   • TTL auto-deletes orders after 90 days.
   • Global Tables replicate to another region for global low latency.
The canonical serverless data store: API Gateway → Lambda → DynamoDB.
Mirrors a Cosmos DB order-tracking design (partition key + change feed + TTL).
```

---

## 58.7 Interview Q&A

**Q: What is DynamoDB and when do you use it?** → AWS's fully managed, serverless NoSQL key-value/document database with single-digit-ms latency at any scale. Use it for high-scale, low-latency, flexible-schema workloads (serverless apps, session stores, IoT, real-time tracking). It's the equivalent of Azure Cosmos DB.
**Q: How do you design a DynamoDB table?** → Around your access patterns (not normalization): choose a high-cardinality partition key to distribute data evenly (avoid hot partitions), use a sort key for ordering within a partition, and add GSIs to query on non-key attributes. Denormalize as needed for your query patterns.
**Q: What are DynamoDB Streams and DAX?** → Streams are change data capture — item changes trigger a Lambda for event-driven processing (like Cosmos DB's change feed). DAX is an in-memory cache in front of DynamoDB giving microsecond reads for read-heavy workloads.
**Q: How does DynamoDB compare to Cosmos DB?** → Both are managed serverless NoSQL with partition keys, indexes, change capture (Streams/Change Feed), and TTL. Cosmos DB is multi-model with 5 tunable consistency levels; DynamoDB offers 2 (eventual/strong) and is key-value/document-focused.

## 58.8 Summary

DynamoDB is AWS's fully managed, serverless NoSQL database (≈ Azure Cosmos DB) with single-digit-ms latency at any scale. Design around access patterns with a high-cardinality partition key (+ optional sort key) and GSIs for non-key queries. Key features: On-Demand vs Provisioned capacity, Streams (change capture → Lambda), DAX (microsecond caching), Global Tables (multi-region), TTL (auto-cleanup), transactions, and eventual/strong consistency. It's the canonical serverless data store (API Gateway → Lambda → DynamoDB).

---
---

# 59. 🧩 AWS SAM & Serverless Framework
> 🟡 KNOW-THIS-MUCH

---

## 59.1 What Problem Does This Solve?

Defining serverless apps (Lambda + API Gateway + DynamoDB + events) with raw CloudFormation is verbose. **AWS SAM** and the **Serverless Framework** are IaC tools specialized for serverless — concise templates that deploy the whole serverless stack. *(Rounds out the serverless block.)*

> 💡 **If you know Azure:** These are roughly the serverless equivalent of using **Bicep/ARM (or the Azure Functions Core Tools)** to define and deploy Functions + related resources — but purpose-built for serverless, with local testing.

---

## 59.2 The Two Tools (Flow Diagram)

```
AWS SAM (Serverless Application Model):
   A CloudFormation extension with concise serverless syntax
   (AWS::Serverless::Function/Api/etc.) → transforms to CloudFormation.
   `sam local` runs/tests Lambda + API Gateway LOCALLY. AWS-native.

SERVERLESS FRAMEWORK:
   A popular third-party, multi-cloud framework (serverless.yml) for
   defining/deploying serverless apps (also supports Azure/GCP). Rich
   plugin ecosystem.

Both: define functions + triggers + resources concisely → one deploy
command provisions the whole serverless stack.
```

---

## 59.3 Key Facts

```
✅ SAM = AWS-native, CloudFormation-based, concise serverless syntax +
   local testing (sam local invoke / sam local start-api)
✅ Serverless Framework = third-party, multi-cloud, big plugin ecosystem
✅ Both define Lambda + API Gateway + DynamoDB + event sources in one
   short template and deploy with one command
✅ Great developer experience for serverless (local run/test, easy deploy)
```

---

## 59.4 Steps

```
📍 SAM: sam init → edit template.yaml → sam local invoke (test) → sam deploy
📍 Serverless Framework: serverless create → edit serverless.yml → serverless deploy
```

---

## 59.5 Real-World Example

```
A serverless API (API Gateway → Lambda → DynamoDB) defined in a SAM
template.yaml: a few lines declare the function, its API Gateway trigger,
the DynamoDB table, and IAM permissions. Developers run `sam local
start-api` to test the whole API locally, then `sam deploy` to provision
everything via CloudFormation. (The Serverless Framework does the same
with serverless.yml, portable across clouds.)
```

---

## 59.6 Interview Q&A

**Q: What are AWS SAM and the Serverless Framework?** → IaC tools specialized for serverless. SAM is AWS-native (a CloudFormation extension with concise serverless syntax and local testing via `sam local`); the Serverless Framework is a popular third-party, multi-cloud tool (serverless.yml) with a rich plugin ecosystem. Both let you define Lambda + API Gateway + DynamoDB + events concisely and deploy the whole stack with one command.
**Q: Why use SAM over raw CloudFormation for serverless?** → Much more concise serverless syntax and local testing (`sam local invoke`/`start-api`) — a far better developer experience than verbose raw CloudFormation for serverless apps.

## 59.7 Summary

AWS SAM (AWS-native CloudFormation extension with concise serverless syntax + local testing) and the Serverless Framework (third-party, multi-cloud, plugin-rich) are IaC tools specialized for serverless — defining Lambda + API Gateway + DynamoDB + event sources concisely and deploying the whole stack in one command, with great local dev/test experience. They're roughly the serverless-focused equivalent of using Bicep/ARM + Functions tooling on Azure.

---

---
---

# 60. 💾 EBS & EFS
> 🟠 MEDIUM

---

## 60.1 What Problem Does This Solve?

EC2 instances need storage: persistent block storage attached to one instance (**EBS**), or a shared file system many instances can mount simultaneously (**EFS**).

> 💡 **If you know Azure:** EBS ≈ Azure **Managed Disks** (block storage for one instance); EFS ≈ Azure **Files** (shared file storage many can mount). Same distinction as Azure.

---

## 60.2 EBS vs EFS (Flow Diagram)

```
EBS (Elastic Block Store) — block storage, ONE instance at a time (per AZ):
   attaches to an EC2 instance like a hard drive; persists independently of
   the instance; types: gp3 (general SSD), io2 (high IOPS), st1/sc1 (HDD)
   → OS disks, databases, single-instance app data
   ≈ Azure Managed Disks

EFS (Elastic File System) — shared NFS file storage, MANY instances:
   multiple EC2 instances (across AZs) mount the SAME file system
   simultaneously; auto-scales; Linux/NFS
   → shared files across a fleet (e.g., web servers sharing uploads)
   ≈ Azure Files
```

| | EBS | EFS |
|---|---|---|
| Type | Block (disk) | Shared file (NFS) |
| Attach | One instance (per AZ) | Many instances, multi-AZ |
| Scaling | Fixed size (resizable) | Auto-scales |
| Use | OS/DB/single-instance data | Shared files across a fleet |

---

## 60.3 Key Facts

```
✅ EBS: persistent block storage, AZ-scoped, one instance at a time (except
   io1/io2 Multi-Attach); SNAPSHOTS → S3 for backup; encryption via KMS;
   types gp3 (default) / io2 (high perf) / st1/sc1 (HDD)
✅ EFS: shared NFS, multi-AZ, auto-scaling, mounted by many instances
   (solves the "each instance has its own copy" problem for a fleet)
✅ Instance store = ephemeral local disk (lost on stop) — for temp data only
✅ EBS snapshots are incremental + stored in S3; automate via DLM/AWS Backup
```

---

## 60.4 Steps

```
📍 EBS: EC2 → Volumes → Create → attach to an instance → mount; snapshot for backup
📍 EFS: EFS → Create file system → mount on instances:
   sudo mount -t efs fs-xxxx:/ /mnt/efs
```

---

## 60.5 Real-World Example

```
A WordPress fleet behind a load balancer:
   • Each EC2 instance uses an EBS gp3 volume for its OS.
   • All instances mount a shared EFS file system at wp-content/uploads →
     an image uploaded via any instance is visible from all (solves the
     "broken images" multi-server problem).
   • A production database on EC2 uses an io2 EBS volume (high consistent
     IOPS), with automated snapshots for backup.
Directly mirrors Azure Managed Disks (per-instance) + Azure Files (shared).
```

---

## 60.6 Interview Q&A

**Q: EBS vs EFS?** → EBS is block storage attached to one EC2 instance (per AZ) — for OS disks, databases, single-instance data (≈ Azure Managed Disks). EFS is a shared NFS file system many instances mount simultaneously across AZs, auto-scaling — for shared files across a fleet (≈ Azure Files). Use EBS for a single instance's disk, EFS when many instances need the same files.
**Q: How do you back up EBS?** → Snapshots (incremental, stored in S3), automated via Data Lifecycle Manager or AWS Backup.

## 60.7 Summary

EBS provides persistent block storage attached to one EC2 instance (per AZ — for OS disks, databases, single-instance data; types gp3/io2/st1/sc1; snapshots to S3) ≈ Azure Managed Disks. EFS provides shared NFS file storage that many instances mount simultaneously across AZs, auto-scaling ≈ Azure Files — solving the "each instance has its own copy" problem for fleets. Use EBS for single-instance disks, EFS for shared files.

---
---

# 61. 🗃️ Amazon RDS & Aurora
> 🟠 MEDIUM

---

## 61.1 What Problem Does This Solve?

Running your own database (patching, backups, HA, replication) is a lot of work. **RDS (Relational Database Service)** is AWS's managed relational database; **Aurora** is AWS's high-performance cloud-native database engine.

> 💡 **If you know Azure:** RDS ≈ Azure **SQL Database / Database for MySQL & PostgreSQL** (managed relational DB). Aurora is AWS's cloud-optimized engine (MySQL/PostgreSQL-compatible), roughly paralleling Azure SQL Hyperscale in spirit (storage/compute separation, high performance).

---

## 61.2 RDS & Aurora (Flow Diagram)

```
RDS = managed relational DB (AWS handles patching, backups, HA):
   Engines: MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, + Aurora
   • Multi-AZ deployment → synchronous standby, AUTOMATIC FAILOVER (HA/DR)
   • Read Replicas → asynchronous read scaling (offload reads)
   • Automated backups + point-in-time recovery
   • Encryption via KMS; runs in your VPC (private subnets)

AURORA = AWS's cloud-native engine (MySQL/PostgreSQL-compatible):
   • Up to ~5x MySQL / ~3x PostgreSQL performance
   • Storage auto-scales; 6 copies across 3 AZs; fast failover
   • Aurora Serverless v2 → auto-scales capacity (pay per use)
   • Global Database → cross-region replication for global apps
```

---

## 61.3 Multi-AZ vs Read Replicas (Key Distinction)

```
MULTI-AZ:      synchronous standby in another AZ → HIGH AVAILABILITY /
               DR with automatic failover (standby is NOT readable). Same endpoint.
READ REPLICAS: asynchronous copies → READ SCALING (offload read traffic);
               readable; can be cross-region; manual promotion.

Multi-AZ = availability; Read Replicas = performance/scaling. Don't confuse them.
```

---

## 61.4 Key Facts

```
✅ RDS = managed relational DB (6 engines incl. Aurora); AWS handles patching/
   backups/HA
✅ Multi-AZ = automatic failover HA (synchronous standby, not readable)
✅ Read Replicas = read scaling (asynchronous, readable, cross-region possible)
✅ Aurora = high-performance cloud-native engine (MySQL/PG-compatible),
   auto-scaling storage, 6 copies/3 AZs, fast failover; Serverless v2 auto-scales
✅ Deploy in private subnets; encrypt with KMS; creds in Secrets Manager (with
   native rotation)
✅ RDS Proxy = connection pooling (great for Lambda/serverless connection spikes)
```

---

## 61.5 Steps

```
📍 Console → RDS → Create database → engine (or Aurora) → enable Multi-AZ →
   private subnets → KMS encryption → manage the password in Secrets Manager
📍 Add a Read Replica: RDS → Actions → Create read replica
```

---

## 61.6 Real-World Example

```
A read-heavy e-commerce database:
   • Aurora (PostgreSQL-compatible), MULTI-AZ for automatic failover (HA).
   • 3 READ REPLICAS to offload product-catalog/order-history reads
     (writes go to the primary endpoint, reads to the replica endpoint).
   • ElastiCache (Section 62) in front for hot data.
   • Aurora Serverless v2 for a spiky reporting workload (pay per use).
   • Password in Secrets Manager with automatic rotation; DB in private
     subnets; RDS Proxy for Lambda connection pooling.
Mirrors Azure SQL with Zone Redundancy (HA) + Read Replicas + Hyperscale.
```

---

## 61.7 Interview Q&A

**Q: What is RDS and what does Aurora add?** → RDS is AWS's managed relational database (MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, Aurora) handling patching, backups, and HA. Aurora is AWS's cloud-native MySQL/PostgreSQL-compatible engine with ~5x/3x performance, auto-scaling storage (6 copies across 3 AZs), fast failover, and a Serverless v2 auto-scaling option. RDS ≈ Azure SQL/MySQL/PostgreSQL; Aurora parallels Azure SQL Hyperscale in spirit.
**Q: Multi-AZ vs Read Replicas?** → Multi-AZ provides high availability with a synchronous standby and automatic failover (standby not readable, same endpoint). Read Replicas provide read scaling — asynchronous, readable copies (can be cross-region). Multi-AZ = availability; Read Replicas = performance. A classic don't-confuse-them question.
**Q: How do you handle DB credentials and Lambda connections?** → Store credentials in Secrets Manager with native rotation (fetched at runtime); use RDS Proxy to pool connections for Lambda/serverless to avoid exhausting DB connections during spikes.

## 61.8 Summary

RDS is AWS's managed relational database (six engines incl. Aurora) handling patching, backups, and HA. Multi-AZ gives automatic-failover high availability (synchronous, non-readable standby); Read Replicas give read scaling (async, readable, cross-region). Aurora is AWS's high-performance cloud-native MySQL/PostgreSQL engine (auto-scaling storage, 6 copies/3 AZs, Serverless v2). Deploy in private subnets, encrypt with KMS, keep credentials in Secrets Manager (with rotation), and use RDS Proxy for serverless connection pooling. RDS ≈ Azure SQL/MySQL/PostgreSQL.

---
---

# 62. 🚀 ElastiCache (Redis / Memcached)
> 🟡 KNOW-THIS-MUCH

---

## 62.1 What Problem Does This Solve?

Hitting the database for the same data repeatedly is slow and expensive. **ElastiCache** is AWS's managed in-memory cache (Redis or Memcached) — sub-millisecond reads that dramatically reduce database load.

> 💡 **If you know Azure:** ElastiCache for Redis ≈ Azure **Cache for Redis**. (AWS also offers Memcached, whereas Azure is Redis-only.)

---

## 62.2 How It Works (Flow Diagram)

```
App → check ElastiCache first:
   HIT → return in sub-ms (fast, no DB hit)
   MISS → query the database → store result in cache → return

Dramatically reduces DB load for read-heavy/hot data.

ENGINES:
   Redis     — rich data structures, persistence, replication, Multi-AZ
               failover, pub/sub, sorted sets (leaderboards) — most common
   Memcached — simple, multi-threaded key-value caching, no persistence
```

---

## 62.3 Key Facts

```
✅ Sub-millisecond reads; offloads read-heavy DB traffic (often 90%+)
✅ Redis (rich, persistent, HA, replication) vs Memcached (simple, fast, no persistence)
✅ Common uses: cache DB query results, session store, leaderboards (Redis
   sorted sets), rate limiting
✅ Caching strategies: lazy-loading (cache-aside) or write-through; use TTL
   to avoid stale data
✅ Deploy in private subnets; Redis supports Multi-AZ with automatic failover
```

---

## 62.4 Real-World Example

```
A ticket-booking site: a popular event release sends 100k users hitting
"available seats" simultaneously.
   Without cache → 100k DB queries/sec → the DB collapses.
   With ElastiCache Redis → the first request caches the seat data (TTL 10s);
   the next ~100k requests hit the cache (sub-ms) → the DB sees ~6 queries/
   sec instead. Also used as a Redis session store shared across all app
   servers.
Directly mirrors using Azure Cache for Redis in front of the database.
```

---

## 62.5 Interview Q&A

**Q: What is ElastiCache and why use it?** → AWS's managed in-memory cache (Redis or Memcached) providing sub-millisecond reads that dramatically reduce database load for read-heavy/hot data — used for caching query results, session stores, leaderboards, and rate limiting. Redis (rich, persistent, HA) is most common; Memcached is simple key-value. ElastiCache for Redis ≈ Azure Cache for Redis.
**Q: Redis vs Memcached?** → Redis has rich data structures, persistence, replication, Multi-AZ failover, and pub/sub (preferred for most production use); Memcached is a simpler, multi-threaded key-value cache with no persistence.

## 62.6 Summary

ElastiCache is AWS's managed in-memory cache (Redis or Memcached) delivering sub-millisecond reads that offload read-heavy database traffic — for query-result caching, session stores, leaderboards, and rate limiting. Redis (rich, persistent, HA) is the common choice; Memcached is simpler. Use lazy-loading/write-through strategies with TTLs, deploy in private subnets, and enable Redis Multi-AZ for failover. ElastiCache for Redis ≈ Azure Cache for Redis (AWS additionally offers Memcached).

---
---

# 63. 🔵🟢 Deployment — Blue/Green (CodeDeploy)
> 🔴 FULL

---

## 63.1 What Problem Does This Solve?

Deploying by stopping the old version and starting the new causes downtime and no easy rollback. **Blue/Green** runs two environments and switches traffic instantly, with instant rollback. Your JD-style deployment strategies apply on AWS too.

> 💡 **If you know Azure:** Same strategy as the Azure notes. On Azure you used App Service Deployment Slots; on AWS, Blue/Green is implemented via **CodeDeploy** (for ECS/Lambda/EC2), or ALB target-group / Route 53 weighting.

---

## 63.2 How It Works (Flow Diagram)

```
Blue (live v1) · Green (idle) →
   deploy v2 to Green → test Green → SWITCH all traffic Blue→Green →
   Green live, Blue kept as instant rollback → problem? switch back instantly

AWS implementations:
   • CodeDeploy Blue/Green (ECS): spins up a new task set (Green) →
     shifts the ALB to it → keeps the old set briefly for rollback
   • CodeDeploy (Lambda): shifts alias traffic to the new version
   • ALB target groups: register Green targets, switch the listener
   • Route 53 weighted: shift DNS weight from Blue to Green
```

---

## 63.3 Key Facts

```
✅ Zero downtime + instant rollback (switch back to Blue)
✅ CodeDeploy automates Blue/Green for ECS, Lambda, and EC2
✅ Test the Green environment before shifting production traffic
✅ Trade-off: two environments running during the transition + all-or-
   nothing switch (Canary refines the latter — Section 64)
✅ Combine with health checks + CloudWatch alarms to auto-rollback on failure
```

---

## 63.4 Steps

```
📍 CodeDeploy (ECS): create a deployment group with Blue/Green config →
   CodeDeploy provisions a new task set, shifts the ALB, and can auto-
   rollback on CloudWatch alarm.
📍 ALB manual: register Green in a new target group → switch the listener rule.
```

---

## 63.5 Real-World Example

```
An ECS service deployed Blue/Green via CodeDeploy:
   1. CodeDeploy spins up a new task set (Green) with v2, behind a test
      listener → smoke tests run against Green.
   2. Shifts the ALB production listener to Green (instant).
   3. Monitors CloudWatch alarms during a "bake" period; if error rate
      spikes → automatic rollback to Blue (the old task set is kept).
   4. If healthy, the old Blue task set is terminated.
Zero downtime, instant rollback — the AWS parallel to an App Service slot swap.
```

---

## 63.6 Interview Q&A

**Q: How do you do Blue/Green deployment on AWS?** → Run two environments (Blue live, Green idle), deploy and test the new version on Green, then switch all traffic to Green with instant rollback by switching back. AWS implements this via CodeDeploy (ECS/Lambda/EC2 — provisions the new version, shifts traffic, auto-rollback on CloudWatch alarms), ALB target-group swaps, or Route 53 weighting. It's the equivalent of an Azure App Service slot swap.
**Q: What's the trade-off of Blue/Green?** → Running two environments during the transition (extra cost) and an all-or-nothing traffic switch — Canary (next) addresses the all-or-nothing aspect with gradual shifting.

## 63.7 Summary

Blue/Green deployment runs two environments — Blue (live) and Green (idle) — deploying and testing the new version on Green, then switching all traffic instantly with instant rollback (switch back). On AWS it's implemented via CodeDeploy (ECS/Lambda/EC2, with auto-rollback on CloudWatch alarms), ALB target-group swaps, or Route 53 weighting — the equivalent of an Azure App Service slot swap. It delivers zero downtime and instant rollback, at the cost of two environments and an all-or-nothing switch.

---
---

# 64. 🐤 Deployment — Canary, Rolling & Rollback
> 🔴 FULL

---

## 64.1 What Problem Does This Solve?

Blue/Green switches 100% at once. **Canary** shifts a small % of traffic first (limiting blast radius); **Rolling** updates instances in batches; **Rollback** recovers from failures.

> 💡 **If you know Azure:** Same strategies as the Azure notes. On AWS, Canary is done via CodeDeploy (Lambda/ECS traffic shifting), ALB/Route 53 weighting, or a service mesh on EKS; Rolling is native to ECS/EKS/ASG.

---

## 64.2 The Strategies (Flow Diagram)

```
CANARY: shift a small %, watch, then increase:
   v2: 10% → monitor error rate/latency → 25% → 50% → 100%
   abort anytime → shift back to 0% (only a small % ever affected)
   AWS: CodeDeploy canary/linear (Lambda/ECS), ALB/Route 53 weights,
        EKS service mesh (App Mesh/Istio) or Flagger

ROLLING: update instances/tasks in BATCHES (always enough healthy serving):
   ECS/EKS/ASG native rolling updates — no second environment needed

ROLLBACK (recover from a bad deploy):
   Blue/Green → switch back · Canary → weight to 0% · CodeDeploy → auto-
   rollback on CloudWatch alarm · ECS/EKS → redeploy previous · Helm →
   helm rollback · feature flag → flip off (instant, no redeploy)
```

---

## 64.3 Comparing Strategies

| Strategy | How | Rollback | Best For |
|---|---|---|---|
| Blue/Green | 2 envs, instant switch | Instant (switch back) | Zero-downtime, simple rollback |
| Canary | Gradual % shift | Instant (weight→0%) | Limiting blast radius, high-traffic |
| Rolling | Batch-by-batch | Redeploy previous / roll batches back | Default ECS/EKS/ASG, no extra infra |

---

## 64.4 Key Facts

```
✅ Canary limits blast radius (only a small % hit the new version first);
   auto-promote/rollback based on CloudWatch metrics (CodeDeploy) or
   Flagger (EKS)
✅ Rolling = ECS/EKS/ASG default (update in batches, maintain availability)
✅ CodeDeploy supports Canary + Linear traffic-shifting configs with auto-
   rollback on alarms
✅ Best rollback = fastest with least impact: slot/target-group switch-back,
   canary→0%, helm rollback, or feature-flag-off (all near-instant)
```

---

## 64.5 Real-World Example

```
A payment service deployed with maximum safety (Canary via CodeDeploy):
   1. Deploy v2; CodeDeploy shifts 10% of traffic to it.
   2. Monitor CloudWatch (error rate, latency) for a bake period.
   3. Healthy → shift to 50% → 100%. If a CloudWatch alarm fires at any
      point → CodeDeploy AUTO-ROLLS-BACK to v1 → only ~10% of traffic was
      ever affected.
   Rolling would instead update ECS tasks batch-by-batch (no second env);
   feature flags (AppConfig, Section 65) enable instant flag-off rollback.
Mirrors Azure App Service traffic routing / AKS canary strategies.
```

---

## 64.6 Interview Q&A

**Q: Canary vs Blue/Green?** → Canary shifts a small, increasing percentage of traffic to the new version (10%→100%), limiting blast radius and allowing instant abort (weight→0%); Blue/Green switches 100% at once. On AWS, Canary uses CodeDeploy traffic-shifting (with auto-rollback on CloudWatch alarms), ALB/Route 53 weights, or EKS service mesh/Flagger.
**Q: What is a Rolling deployment?** → Updating instances/tasks in small batches with health checks between them, maintaining availability without a second environment — the default for ECS, EKS, and Auto Scaling Groups.
**Q: How do you roll back?** → Blue/Green: switch back; Canary: weight to 0%; CodeDeploy: auto-rollback on a CloudWatch alarm; ECS/EKS: redeploy previous; Helm: helm rollback; feature flag: flip off (instant, no redeploy). The best rollback is the fastest with least user impact.

## 64.7 Summary

Canary shifts a small, increasing percentage of traffic to the new version (limiting blast radius, instant abort to 0%) — on AWS via CodeDeploy traffic-shifting (auto-rollback on CloudWatch alarms), ALB/Route 53 weights, or EKS service mesh/Flagger. Rolling updates instances/tasks in batches (ECS/EKS/ASG default). Rollback recovers via switch-back, canary→0%, CodeDeploy auto-rollback, redeploy, helm rollback, or feature-flag-off (instant). Together with Blue/Green, these are the modern deployment strategies, mirroring the Azure notes.

---
---

# 65. 🚩 Feature Flags (AWS AppConfig)
> 🟠 MEDIUM

---

## 65.1 What Problem Does This Solve?

Deploy code without releasing a feature, enable it gradually, and turn it off instantly without redeploying. **AWS AppConfig** (part of Systems Manager) manages feature flags and dynamic configuration — enabling trunk-based development and instant rollback.

> 💡 **If you know Azure:** AppConfig feature flags ≈ Azure **App Configuration** (Feature Manager). Same purpose: decouple deploy from release, gradual rollout, instant flag-off.

---

## 65.2 How It Works (Flow Diagram)

```
Deploy code with a feature flag OFF ("dark") → enable gradually → problem?
flip OFF instantly (no redeploy = instant rollback)

AWS AppConfig:
   • Store feature flags + dynamic config, deployed SEPARATELY from code
   • Gradual DEPLOYMENT STRATEGIES for config changes (e.g., roll out a flag
     to 10% → 50% → 100% over time)
   • VALIDATION + automatic ROLLBACK if a CloudWatch alarm fires during a
     config rollout
   • App fetches flags/config at RUNTIME (SDK / Lambda extension)
```
```python
if appconfig.get_flag("new_checkout"):
    new_checkout()      # on only when the flag is enabled
else:
    old_checkout()
```

---

## 65.3 Key Facts

```
✅ Decouples deploy from release (deploy dark → enable later → flag-off = rollback)
✅ AppConfig: feature flags + dynamic config, deployed independently of code
✅ Gradual rollout strategies for config + validation + auto-rollback on alarm
✅ Underpins trunk-based development (Section 32)
✅ Config/flags fetched at runtime — change without redeploying
```

---

## 65.4 Steps

```
📍 Console → Systems Manager → AppConfig → create application → environment →
   configuration profile (feature flags) → deployment strategy (gradual) →
   deploy; app reads flags via the SDK/Lambda extension
```

---

## 65.5 Real-World Example

```
A team practicing trunk-based development:
   • A new checkout flow ships to prod behind an AppConfig flag (OFF) —
     invisible to users ("deploy dark").
   • Enable for internal testers → 10% of users → monitor CloudWatch →
     ramp to 100%. AppConfig's gradual strategy + validation auto-rolls-
     back the config if an alarm fires.
   • Problem found → flip the flag OFF instantly (no redeploy) → old
     checkout restored.
Mirrors Azure App Configuration Feature Manager exactly.
```

---

## 65.6 Interview Q&A

**Q: What are feature flags and how does AWS AppConfig provide them?** → Feature flags decouple deploying code from releasing a feature — deploy dark (flag off), enable gradually, and disable instantly without redeploying (instant rollback). AWS AppConfig (part of Systems Manager) stores feature flags and dynamic config deployed separately from code, with gradual rollout strategies, validation, and automatic rollback on CloudWatch alarms; apps fetch flags at runtime. It's the equivalent of Azure App Configuration Feature Manager and underpins trunk-based development.

## 65.7 Summary

AWS AppConfig (Systems Manager) manages feature flags and dynamic configuration — deployed separately from code, with gradual rollout strategies, validation, and automatic rollback on CloudWatch alarms, fetched at runtime. It decouples deploying from releasing (deploy dark → enable gradually → flag-off for instant rollback), underpinning trunk-based development. It's the AWS equivalent of Azure App Configuration Feature Manager.

---
---

# 66. 📊 CloudWatch (Metrics, Logs, Alarms)
> 🔴 FULL

---

## 66.1 What Problem Does This Solve?

You can't operate what you can't see. **CloudWatch** is AWS's central observability service — metrics, logs, alarms, dashboards, and events — for monitoring your infrastructure and applications.

> 💡 **If you know Azure:** CloudWatch is the direct equivalent of Azure **Monitor**. Metrics ≈ Azure Monitor Metrics, CloudWatch Logs ≈ Log Analytics, Alarms ≈ Azure Monitor Alerts, CloudWatch Events/EventBridge ≈ Event Grid/alerts.

---

## 66.2 What CloudWatch Provides (Flow Diagram)

```
Every AWS resource + your apps → CloudWatch:

   METRICS  → numerical time-series (CPU, request count, latency, errors)
   LOGS     → log streams (from EC2 via agent, Lambda, ECS, VPC Flow Logs)
   ALARMS   → fire on a metric/log condition → action (SNS notify, Auto
              Scaling, auto-remediate, EC2 recover)
   DASHBOARDS → visualize metrics/logs
   (EventBridge — Section 55 — handles the events piece)

⚠️ EC2 basic metrics (CPU/network) are collected automatically, but
MEMORY and DISK usage require the CLOUDWATCH AGENT (like Azure needing
the Monitor Agent for guest-OS metrics).
```

---

## 66.3 Key Concepts

| Concept | What It Is |
|---|---|
| **Metrics** | Numerical time-series; custom metrics via API/agent |
| **Alarms** | Fire when a metric crosses a threshold → trigger SNS/Auto Scaling/actions |
| **Logs / Log Groups** | Centralized log storage (query with Logs Insights — Section 67) |
| **CloudWatch Agent** | Needed for EC2 memory/disk + custom log collection |
| **Dashboards** | Visual metric/log displays |
| **Composite Alarms** | Combine multiple alarms to reduce noise |

---

## 66.4 Key Facts

```
✅ Central observability: metrics, logs, alarms, dashboards
✅ EC2 CPU/network auto-collected; memory/disk need the CloudWatch Agent
✅ Alarms → SNS (notify), Auto Scaling (scale), EC2 recover, or Lambda
   (auto-remediate)
✅ Custom metrics for app/business KPIs; log metric filters extract metrics from logs
✅ Lambda/ECS/RDS/ALB emit rich metrics automatically
✅ Billing alarms + AWS Budgets for cost monitoring
```

---

## 66.5 Steps

```
📍 Console → CloudWatch → Alarms → Create alarm → pick a metric + threshold
   → action (SNS topic / Auto Scaling policy) → Create
📍 Install the CloudWatch Agent on EC2 for memory/disk/custom logs
📍 CLI: aws cloudwatch put-metric-alarm / put-dashboard
```

---

## 66.6 Real-World Example

```
A production payment API monitored with CloudWatch:
   • Alarms: EC2/ECS CPU > 80% → SNS + Auto Scaling; ALB 5xx rate > 2% →
     page on-call; ALB TargetResponseTime > 1s → alert (SLA risk).
   • CloudWatch Agent on hosts for memory/disk metrics.
   • Custom metric "PaymentFailureRate" (published from the app) → alarm.
   • A metric filter on the logs counts "ERROR" occurrences → alarm.
   • Dashboard shows request rate, error rate, latency, and infra health.
   • Alarms → SNS → PagerDuty for on-call.
Directly mirrors Azure Monitor metrics/alerts + agent for guest-OS metrics.
```

---

## 66.7 Interview Q&A

**Q: What is CloudWatch?** → AWS's central observability service — metrics (numerical time-series), logs (Log Groups, queried with Logs Insights), alarms (fire on thresholds → SNS/Auto Scaling/remediation), and dashboards. It's the equivalent of Azure Monitor.
**Q: What's a common gotcha with EC2 metrics?** → CloudWatch collects EC2 CPU/network automatically but NOT memory or disk usage — those require installing the CloudWatch Agent (like Azure needing the Monitor Agent for guest-OS metrics).
**Q: What can a CloudWatch alarm trigger?** → An SNS notification, an Auto Scaling action (scale out/in), an EC2 action (stop/reboot/recover), or a Lambda for auto-remediation.

## 66.8 Summary

CloudWatch is AWS's central observability service (≈ Azure Monitor) — metrics (numerical time-series), logs (Log Groups), alarms (fire on thresholds to trigger SNS/Auto Scaling/remediation), and dashboards. EC2 CPU/network is auto-collected but memory/disk need the CloudWatch Agent (like Azure's Monitor Agent). Use alarms with SNS→PagerDuty for alerting, custom metrics for app KPIs, metric filters to extract metrics from logs, and billing alarms/Budgets for cost — enabling proactive detection before users are affected.

---
---

# 67. 🔎 CloudWatch Logs Insights
> 🔴 FULL

---

## 67.1 What Problem Does This Solve?

Metrics tell you *that* something's wrong; logs tell you *why*. **CloudWatch Logs Insights** lets you query and analyze log data with a purpose-built query language — essential for the JD's "log-based issue investigation."

> 💡 **If you know Azure:** Logs Insights is the equivalent of Azure **Log Analytics + KQL** — querying centralized logs to investigate issues. The query language differs (Logs Insights syntax vs KQL) but the purpose is identical.

---

## 67.2 How It Works (Flow Diagram)

```
Logs from EC2 (agent) / Lambda / ECS / VPC Flow Logs / etc. → CloudWatch
LOG GROUPS → query with LOGS INSIGHTS (a pipe-based query language):

   fields @timestamp, @message
   | filter @message like /ERROR/
   | stats count() by bin(5m)
   | sort @timestamp desc

Operators: fields · filter · stats (aggregate) · sort · limit · parse
(extract fields from log text). Metrics say WHAT; Logs Insights says WHY.
```

---

## 67.3 Example Queries

```
# Count errors over the last hour, in 5-min buckets
fields @timestamp, @message
| filter @message like /ERROR/
| stats count() as errors by bin(5m)

# Find slowest Lambda invocations
filter @type = "REPORT"
| fields @requestId, @duration
| sort @duration desc
| limit 20

# Parse and group custom log fields
fields @message
| parse @message "user=* action=*" as user, action
| stats count() by action
```

---

## 67.4 Key Facts

```
✅ Query centralized CloudWatch Logs with a pipe-based language (fields/
   filter/stats/sort/parse) — the "why" behind metric alarms
✅ Log Groups organize logs by source (e.g., /aws/lambda/my-func)
✅ Metric filters can turn recurring log patterns into CloudWatch metrics + alarms
✅ Retention configurable per Log Group; export to S3 for long-term/Athena
✅ Directly relevant to the JD's "log and metric-based issue investigation"
```

---

## 67.5 Steps

```
📍 Console → CloudWatch → Logs Insights → select Log Group(s) → write a
   query → Run → view results/visualization
📍 Create a metric filter on a Log Group to alarm on a log pattern (e.g., ERROR count)
```

---

## 67.6 Real-World Example

```
A metric alarm fires: "error rate spiked at 3:15 PM." Investigate with
Logs Insights:
   fields @timestamp, @message
   | filter @timestamp >= "3:10" and @timestamp <= "3:20" and @message like /Exception/
   | stats count() by @message
   | sort count() desc
   → reveals a flood of "SQLTimeoutException" → the DB was timing out.
   Drill in → a specific slow query. Fix it, and add a METRIC FILTER so
   "SQLTimeoutException" count → a CloudWatch alarm next time.
Metrics said SOMETHING was wrong; Logs Insights pinpointed WHY — the AWS
parallel to Azure Log Analytics + KQL.
```

---

## 67.7 Interview Q&A

**Q: What is CloudWatch Logs Insights?** → A query tool for analyzing centralized CloudWatch Logs using a pipe-based language (fields/filter/stats/sort/parse) — used to investigate the root cause behind metric alarms (metrics say *that* something's wrong; logs say *why*). It's the equivalent of Azure Log Analytics + KQL.
**Q: How would you investigate a spike in errors?** → Query the relevant Log Group in Logs Insights, filtering to the time window and error patterns, then `stats count() by @message` to find the dominant error, and drill in. Optionally create a metric filter so that error pattern triggers a CloudWatch alarm going forward.
**Q: What's a metric filter?** → A rule on a Log Group that extracts a metric from matching log patterns (e.g., count of "ERROR"), which you can then alarm on — bridging logs and metrics.

## 67.8 Summary

CloudWatch Logs Insights queries centralized CloudWatch Logs with a pipe-based language (fields/filter/stats/sort/parse) to investigate the root cause behind metric alarms — the "why" to metrics' "what." Log Groups organize logs by source; metric filters turn recurring log patterns into alarmable metrics; retention is configurable with S3 export for long-term/Athena. It's directly relevant to the JD's log-based investigation and is the AWS equivalent of Azure Log Analytics + KQL.

---
---

# 68. 🔬 AWS X-Ray (Distributed Tracing)
> 🟠 MEDIUM

---

## 68.1 What Problem Does This Solve?

In a microservices/serverless app, a single request touches many services. When it's slow or fails, *which* service caused it? **X-Ray** provides distributed tracing to follow a request end-to-end and pinpoint the bottleneck.

> 💡 **If you know Azure:** X-Ray is the equivalent of Azure **Application Insights' distributed tracing** (Application Map). Same purpose — trace a request across services to find where time is spent or where it failed.

---

## 68.2 How It Works (Flow Diagram)

```
Instrument your app/services with the X-Ray SDK (or enable it on Lambda/
API Gateway/ECS) →
   X-Ray collects TRACES (a request's journey across services) →
   builds a SERVICE MAP (visual graph of services + their latencies/errors) →
   you see the END-TO-END path and WHERE time was spent / what failed.

Example trace of "place order":
   API Gateway (5ms) → Lambda (10ms) → DynamoDB (8ms) → Payment API (SLOW: 3200ms!)
   → X-Ray immediately shows the Payment API is the bottleneck.
```

---

## 68.3 Key Facts

```
✅ Distributed tracing: follows a request across services (Lambda, API
   Gateway, ECS, EC2, DynamoDB, external calls)
✅ Service Map: visual graph of services + latency/error rates (≈ App
   Insights Application Map)
✅ Pinpoints the bottleneck/failing service in microservices/serverless apps
✅ Integrates natively with Lambda, API Gateway, ECS (enable + instrument)
✅ Traces include segments/subsegments (per service + per downstream call)
```

---

## 68.4 Steps

```
📍 Enable X-Ray on Lambda/API Gateway (a toggle) + instrument code with the
   X-Ray SDK for custom subsegments → Console → X-Ray → view the Service
   Map + traces
```

---

## 68.5 Real-World Example

```
A serverless app has intermittent slow checkouts; the team can't tell which
service is at fault:
   • X-Ray is enabled across API Gateway + Lambdas + DynamoDB.
   • A slow trace shows the request spent 3.2s in the Payment Lambda's
     downstream call to an external payment API (vs ms elsewhere).
   • The Service Map confirms elevated latency on that node.
   • Fix: add a timeout/retry + cache; add a CloudWatch alarm on that
     dependency's latency.
X-Ray pinpointed the exact bottleneck — impossible from infra metrics
alone. The AWS parallel to App Insights distributed tracing.
```

---

## 68.6 Interview Q&A

**Q: What is X-Ray and why is it valuable?** → AWS's distributed tracing service — it follows a single request across all the services it touches (API Gateway, Lambda, ECS, DynamoDB, external calls) and builds a Service Map showing latencies and errors, so in a microservices/serverless app you can pinpoint exactly which service caused slowness or failure. It's the equivalent of Azure Application Insights' distributed tracing.
**Q: How do you enable it?** → Toggle X-Ray on for Lambda/API Gateway and instrument code with the X-Ray SDK for custom subsegments, then view traces and the Service Map in the console.

## 68.7 Summary

AWS X-Ray provides distributed tracing — following a request across all services it touches and building a Service Map with latencies and error rates — to pinpoint exactly which service causes slowness or failure in microservices/serverless apps. It integrates natively with Lambda, API Gateway, and ECS. It's the AWS equivalent of Azure Application Insights' distributed tracing (Application Map), essential for diagnosing complex distributed systems.

---

---
---

# 69. 🚨 Alerting & Incident Response
> 🟡 KNOW-THIS-MUCH

---

## 69.1 What Problem Does This Solve?

Monitoring is useless if the right people aren't notified and don't know what to do. A good **alerting strategy** + **incident response** process ensures fast detection and calm resolution — the JD's "faster issue detection and resolution."

> 💡 **If you know Azure:** Identical practice to the Azure notes — cloud-agnostic SRE/DevOps discipline. Alerts flow from CloudWatch (vs Azure Monitor) via SNS → PagerDuty/Opsgenie.

---

## 69.2 Alerting & Incident Flow (Flow Diagram)

```
ALERTING (tiered + actionable, avoid alert fatigue):
   Severity 0 (Critical): service down → page on-call (SNS → PagerDuty)
   Severity 1 (High):     major degradation → SMS + Slack
   Severity 2 (Warning):  early warning (CPU rising) → email
   Severity 3 (Info):     dashboard/log only
   → alert on user-felt SYMPTOMS (error rate, latency), not just causes (CPU)

INCIDENT RESPONSE:
   Detect → Acknowledge → Triage → MITIGATE FIRST (rollback/flag-off/
   failover — restore service) → Investigate (CloudWatch metrics, Logs
   Insights, X-Ray) → Resolve → Blameless post-mortem
```

---

## 69.3 Key Facts

```
✅ Tiered, actionable alerts routed by severity → avoid alert fatigue
✅ Alert on symptoms users feel; CloudWatch alarm → SNS → PagerDuty/Opsgenie
✅ MITIGATE FIRST (restore service), investigate root cause SECOND
✅ On-call rotation + runbooks (documented steps for known issues)
✅ Blameless post-mortems → capture root cause + prevention actions
✅ AWS: CloudWatch Alarms + Composite Alarms (reduce noise); Systems Manager
   Incident Manager for structured response
```

---

## 69.4 Real-World Example

```
A payment API incident:
   1. Payment failures spike → CloudWatch alarm → SNS → PagerDuty pages
      the on-call engineer.
   2. Acknowledge; triage (payments failing = high impact).
   3. MITIGATE FIRST: roll back the recent deploy (CodeDeploy) or flip a
      feature flag off → service restored in minutes.
   4. INVESTIGATE: X-Ray + Logs Insights find the root cause (bad config
      in the release).
   5. Resolve (fix + canary redeploy).
   6. Blameless post-mortem: timeline, root cause, action items (add a
      test that would've caught it).
Same discipline as the Azure notes — fast detection, mitigate-then-
investigate.
```

---

## 69.5 Interview Q&A

**Q: How do you design a good alerting strategy?** → Tiered by severity and always actionable — critical pages on-call, warnings email; alert on user-felt symptoms (error rate/latency) not just causes (CPU); avoid alert fatigue from noisy alerts. On AWS, CloudWatch alarms → SNS → PagerDuty/Opsgenie.
**Q: Walk through incident response.** → Detect → acknowledge → triage → mitigate first (rollback/flag-off/failover to restore service) → investigate root cause (CloudWatch metrics, Logs Insights, X-Ray) → resolve → blameless post-mortem. Key principle: mitigate-then-investigate.

## 69.6 Summary

A good alerting strategy is tiered by severity and actionable, focused on user-felt symptoms to avoid alert fatigue (CloudWatch alarms → SNS → PagerDuty). Incident response follows detect → acknowledge → triage → **mitigate first** (rollback/flag-off/failover) → investigate (metrics, Logs Insights, X-Ray) → resolve → blameless post-mortem, supported by on-call rotations and runbooks. It's the same cloud-agnostic SRE discipline as the Azure notes, delivering faster issue detection and resolution.

---
---

# 70. 🎯 SLI / SLO / SLA & Error Budgets
> 🟡 KNOW-THIS-MUCH

---

## 70.1 What Problem Does This Solve?

"Is our service reliable enough?" needs precise, measurable definitions. SLIs, SLOs, SLAs, and error budgets provide them — core SRE concepts increasingly asked in senior DevOps interviews.

> 💡 **If you know Azure:** Identical, cloud-agnostic SRE concepts — same as the Azure notes. Measured via CloudWatch (vs Azure Monitor).

---

## 70.2 The Terms + Error Budget (Flow Diagram)

```
SLI (Indicator)  = a MEASUREMENT of service health (e.g., 99.95% success)
SLO (Objective)  = the internal TARGET for an SLI (e.g., 99.9%)
SLA (Agreement)  = the customer CONTRACT with penalties (e.g., 99.5%) — loosest
                   Usually: SLA < SLO < actual performance

ERROR BUDGET = inverse of the SLO (99.9% SLO → 0.1% allowed failure):
   budget REMAINING → ship features fast / take more risk
   budget EXHAUSTED → freeze risky changes, focus on stability
   → turns "velocity vs reliability" into a data-driven decision

Memory hook: Indicator / Objective / Agreement.
```

---

## 70.3 Key Facts

```
✅ SLI = measured; SLO = internal goal; SLA = customer promise w/ penalties
✅ Common SLIs: availability, latency (% under a threshold), error rate, throughput
✅ Error budget balances feature velocity vs stability (data-driven)
✅ Measured on AWS via CloudWatch metrics/alarms + dashboards
```

---

## 70.4 Real-World Example

```
A payment platform:
   SLI: % of payment requests succeeding (from CloudWatch metrics)
   SLO: 99.95% over 30 days (internal target)
   SLA: 99.9% to enterprise customers (with service credits if breached)
   Error Budget: 0.05%/month.
   Early in the month, budget remains → ship features fast. A bad release
   burns the budget → freeze risky changes, focus on stability until it
   recovers → protects the customer SLA.
Same as the Azure notes' SRE approach.
```

---

## 70.5 Interview Q&A

**Q: SLI vs SLO vs SLA?** → SLI is a measurement of service health (e.g., measured success rate); SLO is your internal target for it (e.g., 99.9%); SLA is a contractual customer promise with consequences (e.g., 99.5% or credits), usually looser than the SLO for safety margin.
**Q: What's an error budget?** → The allowed unreliability — the inverse of the SLO (99.9% SLO = 0.1% budget). If budget remains, ship features and take risk; if exhausted, freeze risky changes and focus on stability. It makes the reliability-vs-velocity trade-off data-driven.

## 70.6 Summary

SLI (measured health), SLO (internal target), and SLA (customer contract with penalties, usually looser) precisely define reliability; the error budget (inverse of the SLO) data-drives the balance between shipping fast (budget remaining) and stabilizing (budget exhausted). Measured via CloudWatch on AWS. These are cloud-agnostic SRE concepts identical to the Azure notes.

---
---

# 71. 🔐 DevSecOps on AWS
> 🔴 FULL

---

## 71.1 What Problem Does This Solve?

Security bolted on at the end is slow and risky. **DevSecOps** builds security into every pipeline stage ("shift left") — with AWS-native security services as guardrails and detection.

> 💡 **If you know Azure:** Same practice as the Azure notes (shift-left scanning + policy backstop). AWS-native tools: GuardDuty ≈ Defender for Cloud (threat detection), Inspector ≈ vulnerability scanning, Security Hub ≈ Defender/Sentinel posture aggregation, SCPs/Config ≈ Azure Policy.

---

## 71.2 Shift-Left + AWS Security Services (Flow Diagram)

```
Security at EVERY stage (fail the build on critical findings):
   commit    → secret scanning (git-secrets, gitleaks, GitHub/Bitbucket scanning)
   build/PR  → SAST (SonarQube/CodeGuru) + SCA (dependency CVEs, Dependabot)
   container → ECR image scanning + Inspector
   IaC       → scan Terraform/CloudFormation (Checkov, cfn-nag, tfsec)
   deploy    → SCPs / Config rules (deny non-compliant resources — backstop)
   runtime   → GuardDuty (threat detection) + Security Hub (posture)

AWS-NATIVE SECURITY SERVICES:
   GuardDuty    → intelligent threat detection (analyzes logs for malicious activity)
   Inspector    → automated vulnerability scanning (EC2, ECR images, Lambda)
   Security Hub → aggregates findings + compliance posture (CIS/PCI standards)
   Macie        → sensitive-data (PII) discovery in S3
   Config       → resource compliance rules (+ auto-remediation)
   SCPs         → org-wide preventive guardrails (Section 73)
```

---

## 71.3 The Three Pillars (JD-Relevant)

```
1. SECRETS MANAGEMENT: Secrets Manager/Parameter Store + IAM roles (no
   hardcoding) + secret scanning to catch commits (Sections 26-27, 30)
2. POLICY CONTROLS: SCPs (org-wide preventive — deny non-compliant) +
   AWS Config rules (detective + auto-remediation) — the guardrail backstop
3. LEAST-PRIVILEGE: scoped IAM roles for pipelines/services (limited blast radius)
```

---

## 71.4 Scanning Types (Same Set as Azure)

| Scan | Checks | AWS/Common Tools |
|---|---|---|
| Secret scanning | Committed credentials | git-secrets, gitleaks, GitHub/Bitbucket scanning |
| SAST | Source code vulns | SonarQube, Amazon CodeGuru, Checkmarx |
| SCA | Dependency CVEs | Dependabot, Snyk, OWASP Dependency-Check |
| Container scan | Image CVEs | ECR scanning, Amazon Inspector, Trivy |
| IaC scan | Misconfigured IaC | Checkov, cfn-nag, tfsec |
| DAST | Running-app vulns | OWASP ZAP |

---

## 71.5 Steps

```
📍 Pipeline: add scan stages (gitleaks/sonar/trivy/checkov) that FAIL the
   build on critical findings (Sections 29-30 for auth/secrets).
📍 Enable GuardDuty (threat detection), Inspector (vuln scanning), and
   Security Hub (posture aggregation) across accounts.
📍 SCPs (Organizations) + Config rules as preventive/detective guardrails.
```

---

## 71.6 Real-World Example

```
A fintech DevSecOps pipeline + AWS security services:
   Pipeline gates (fail on critical): secret scan → SAST → SCA → ECR
   image scan → IaC scan (Checkov). Secrets only in Secrets Manager
   (fetched at runtime, Section 30); pipeline auth via OIDC (Section 29).
   Guardrails: SCPs deny creating unencrypted S3/RDS and deny leaving the
   region; Config rules detect + auto-remediate drift.
   Runtime: GuardDuty flags anomalous API activity; Inspector scans EC2/
   ECR/Lambda for CVEs; Security Hub aggregates everything against CIS/PCI.
Continuous, automated security — defense in depth, not a single check.
Mirrors the Azure DevSecOps section (Defender/Policy → GuardDuty/SCPs).
```

---

## 71.7 Interview Q&A

**Q: What is DevSecOps / shift-left on AWS?** → Building security into every pipeline stage — secret scanning, SAST, SCA, container image scanning (ECR/Inspector), and IaC scanning — failing the build on critical findings so issues are caught early. Plus AWS-native guardrails: SCPs/Config as preventive/detective policy controls, and GuardDuty/Inspector/Security Hub for runtime threat detection, vulnerability scanning, and posture.
**Q: Name key AWS security services and their roles.** → GuardDuty (intelligent threat detection), Inspector (vulnerability scanning for EC2/ECR/Lambda), Security Hub (findings aggregation + compliance posture), Macie (PII discovery in S3), Config (resource compliance + remediation), SCPs (org-wide preventive guardrails). GuardDuty≈Defender for Cloud, SCPs/Config≈Azure Policy.
**Q: How do you handle secrets in the pipeline?** → Never hardcode — Secrets Manager/Parameter Store fetched at runtime via IAM roles, OIDC auth (no stored keys), and secret scanning to catch accidental commits.

## 71.8 Summary

DevSecOps on AWS shifts security left — secret/SAST/SCA/container/IaC scanning in the pipeline (fail on critical findings) — backed by AWS-native services: GuardDuty (threat detection), Inspector (vulnerability scanning), Security Hub (posture aggregation), Macie (PII discovery), Config (compliance + remediation), and SCPs (org-wide preventive guardrails). The three JD pillars: secrets management (Secrets Manager + IAM + scanning), policy controls (SCPs + Config), and least-privilege IAM roles. It's defense in depth, mirroring the Azure DevSecOps approach with AWS-native tooling.

---
---

# 72. 🤖 AI-Assisted DevOps (Amazon Q / Bedrock)
> 🟠 MEDIUM

---

## 72.1 What Problem Does This Solve?

Apply AI to reduce DevOps toil — pipeline failure analysis, code/IaC review, log investigation, anomaly detection — using existing AI tools rather than building models.

> 💡 **If you know Azure:** Same practice as the Azure AIOps section. AWS-native tools: Amazon Q (AI assistant, ≈ Copilot/Azure OpenAI use), Amazon Bedrock (managed foundation models, ≈ Azure OpenAI Service), CloudWatch anomaly detection (≈ Azure Monitor dynamic thresholds), DevOps Guru (≈ App Insights Smart Detection).

---

## 72.2 Where AI Helps (Flow Diagram)

```
Traditional (manual)          →  AI-assisted (AWS)
Scroll failed pipeline logs   →  Amazon Q / Bedrock summarizes + suggests fix
Manually review IaC/pipeline  →  Amazon Q flags issues in code/CloudFormation/TF
Hand-write log queries        →  describe in English → generate Logs Insights query
Hand-tune alert thresholds    →  CloudWatch Anomaly Detection (ML dynamic bands)
Manually spot degradations    →  DevOps Guru auto-detects operational issues
```

---

## 72.3 The Four JD Areas + AWS Tools

```
1. PIPELINE FAILURE ANALYSIS: a pipeline step (on failure) sends logs to
   Amazon Bedrock / Amazon Q → posts a root-cause summary + suggested fix
   to Slack. (≈ Azure OpenAI failure analysis.)
2. AI-ASSISTED REVIEWS: Amazon Q (or Copilot) reviews pipeline YAML / IaC /
   K8s manifests, flagging anti-patterns + security gaps before human review.
3. LOG/METRIC INVESTIGATION: describe a query in plain English → AI
   generates the CloudWatch Logs Insights query. Amazon Q answers questions
   about your AWS environment/logs.
4. ANOMALY DETECTION: CloudWatch Anomaly Detection (ML learns normal
   patterns → dynamic thresholds, fewer false alarms); DevOps Guru
   auto-surfaces operational issues + remediation suggestions.
```

| Tool | Role |
|---|---|
| **Amazon Q** | AI assistant for AWS (code, ops questions, reviews) ≈ Copilot |
| **Amazon Bedrock** | Managed foundation models (call from pipelines/apps) ≈ Azure OpenAI Service |
| **CloudWatch Anomaly Detection** | ML-based dynamic alert thresholds ≈ Azure Monitor dynamic thresholds |
| **DevOps Guru** | ML-based operational issue detection ≈ App Insights Smart Detection |

---

## 72.4 The Important Caveat

```
AI is a PRODUCTIVITY MULTIPLIER, not a replacement for judgment. Every AI
suggestion (root cause, review comment, generated query) must be
HUMAN-VERIFIED before acting, especially for production. AI is a fast,
well-read co-pilot pointing you in a promising direction — not an
infallible authority.
```

---

## 72.5 Real-World Example

```
A team reduces MTTR with AWS AIOps:
   • A pipeline failure step calls Amazon Bedrock → posts a root-cause
     summary + fix to Slack in seconds → juniors resolve most failures fast.
   • Amazon Q flags IaC/pipeline anti-patterns in PRs before human review.
   • CloudWatch Anomaly Detection replaces dozens of hand-tuned thresholds
     → far fewer false alarms.
   • DevOps Guru auto-surfaced a memory-leak trend nobody had alerted on.
   Humans always verify AI suggestions before acting.
Mirrors the Azure AIOps section (Azure OpenAI/Copilot/dynamic thresholds).
```

---

## 72.6 Interview Q&A

**Q: How can AI assist DevOps on AWS?** → Summarize pipeline failure logs + suggest fixes (Amazon Q/Bedrock), AI-assisted PR/IaC reviews (Amazon Q), plain-English → Logs Insights queries, and ML anomaly detection (CloudWatch Anomaly Detection, DevOps Guru) — applying existing AI tools to reduce toil, not building models. Amazon Bedrock ≈ Azure OpenAI Service; DevOps Guru ≈ App Insights Smart Detection.
**Q: Key caveat?** → AI suggestions are productivity aids that must be human-verified before acting, especially for production — AI is a co-pilot, not an autonomous authority.

## 72.7 Summary

AIOps on AWS applies existing AI tools to reduce DevOps toil across the JD's four areas: pipeline failure analysis (Amazon Q/Bedrock), AI-assisted reviews (Amazon Q), plain-English log/metric investigation (Logs Insights generation), and ML anomaly detection (CloudWatch Anomaly Detection, DevOps Guru). Amazon Bedrock ≈ Azure OpenAI Service, DevOps Guru ≈ App Insights Smart Detection. AI is a human-verified co-pilot, not a replacement for judgment — mirroring the Azure AIOps approach with AWS-native tools.

---
---

# 73. 🛂 AWS Config & Service Control Policies (SCPs)
> 🟠 MEDIUM

---

## 73.1 What Problem Does This Solve?

Organizations need governance: enforce what resources can exist/be configured (preventive) and detect non-compliant resources (detective). **SCPs** are preventive org-wide guardrails; **AWS Config** is detective compliance monitoring.

> 💡 **If you know Azure:** SCPs + Config together ≈ Azure **Policy**. SCPs (preventive deny at the org/OU level) ≈ Azure Policy deny effects at a Management Group; Config (detect + remediate compliance) ≈ Azure Policy audit/remediation.

---

## 73.2 SCPs vs Config (Flow Diagram)

```
SCP (Service Control Policy) — PREVENTIVE (org-wide guardrail):
   Attached at Organization/OU/account → sets the MAXIMUM permissions any
   account can have → BLOCKS actions before they happen.
   e.g., "deny creating resources outside ap-south-1", "deny disabling
   CloudTrail/GuardDuty" — even an account admin can't override.
   (Doesn't grant — only limits. Section 4.)

AWS CONFIG — DETECTIVE (compliance monitoring):
   Continuously records resource configurations + evaluates them against
   RULES → flags NON-COMPLIANT resources (e.g., "S3 bucket is public",
   "EBS not encrypted") → optional AUTO-REMEDIATION.
```

---

## 73.3 Key Facts

```
✅ SCP = preventive, org-wide ceiling (deny before it happens); attaches to
   OU/account; can't be overridden by account admins
✅ Config = detective; records config history + evaluates compliance rules;
   auto-remediation via SSM/Lambda
✅ Use together: SCPs prevent the worst outright; Config detects/remediates
   drift for the rest
✅ Config also gives a config timeline (what changed, when) for audit
✅ Conformance packs = bundles of Config rules for standards (CIS/PCI/HIPAA)
```

---

## 73.4 Steps

```
📍 SCP: Organizations → Policies → Service control policies → create (deny
   statements) → attach to an OU/account
📍 Config: AWS Config → enable → add rules (managed or custom) → set
   remediation actions → view compliance dashboard
```

---

## 73.5 Real-World Example

```
Governance for a regulated company:
   SCPs (preventive): deny resource creation outside ap-south-1; deny
   disabling CloudTrail/GuardDuty; deny root-user actions — applied at the
   OU level, unoverridable.
   Config (detective): rules flagging public S3 buckets, unencrypted EBS/
   RDS, and overly-permissive security groups → auto-remediate (e.g., a
   Lambda re-blocks public access) → compliance dashboard for auditors.
SCPs stop the worst outright; Config catches and fixes the rest. Mirrors
Azure Policy (deny at Management Group + audit/remediation).
```

---

## 73.6 Interview Q&A

**Q: SCPs vs AWS Config?** → SCPs are preventive org-wide guardrails (attached to OUs/accounts) that set maximum permissions and block actions before they happen (e.g., deny leaving a region, deny disabling CloudTrail) — unoverridable by account admins. AWS Config is detective — it records resource configurations and evaluates them against rules to flag (and optionally auto-remediate) non-compliant resources. Use SCPs to prevent the worst and Config to detect/fix drift. Together ≈ Azure Policy.
**Q: How do SCPs relate to IAM?** → SCPs are a permissions ceiling in the org — they don't grant anything; you still need IAM policies to allow actions, but SCPs cap what's possible (Section 4's evaluation logic).

## 73.7 Summary

SCPs (Service Control Policies) are preventive, org-wide guardrails attached to OUs/accounts that cap maximum permissions and block actions before they happen (unoverridable by account admins) — while AWS Config is detective, recording resource configurations and evaluating compliance rules with optional auto-remediation. Use SCPs to prevent the worst outright and Config to detect/fix drift, with Config conformance packs for standards like CIS/PCI. Together they're the AWS equivalent of Azure Policy (deny + audit/remediation).

---
---

# 74. 📜 CloudTrail
> 🟠 MEDIUM

---

## 74.1 What Problem Does This Solve?

For security, audit, and troubleshooting, you need a record of *who did what* in your AWS account — every API call. **CloudTrail** logs all API activity.

> 💡 **If you know Azure:** CloudTrail is the equivalent of the Azure **Activity Log** (control-plane audit) — a record of every management action (who, what, when, from where).

---

## 74.2 How It Works (Flow Diagram)

```
Every API call (console/CLI/SDK/service) → CloudTrail records an EVENT:
   who (identity) · what (action) · when · from where (IP) · on what resource
   ↓
   Events → CloudTrail console (recent) + delivered to S3 (long-term) +
   optionally CloudWatch Logs (for alarms/queries)

Event types:
   Management events — control-plane actions (create/delete/modify) [default]
   Data events       — data-plane (e.g., S3 object-level, Lambda invokes) [opt-in]
   Insights events   — detects unusual API activity patterns
```

---

## 74.3 Key Facts

```
✅ Records WHO did WHAT, WHEN, from WHERE — for every API call (audit trail)
✅ Deliver to S3 (long-term, tamper-evident with log-file validation) +
   CloudWatch Logs (alarm on suspicious activity)
✅ Organization Trail → one trail across all accounts (central audit in a
   dedicated log-archive account)
✅ Essential for security investigation, compliance, and troubleshooting
   ("who deleted this resource?")
✅ CloudTrail Insights flags anomalous API activity
```

---

## 74.4 Steps

```
📍 Console → CloudTrail → Create trail → deliver to an S3 bucket (+ CloudWatch
   Logs) → enable across the Organization for central audit → enable log-file
   validation
📍 Query recent events in the console; use Athena on the S3 logs for deep analysis
```

---

## 74.5 Real-World Example

```
"Who deleted the production database?" — CloudTrail answers instantly:
   Search CloudTrail events for the RDS DeleteDBInstance action → shows the
   IAM identity, timestamp, and source IP. For security, an Organization
   Trail delivers all accounts' logs to a locked-down log-archive account
   (S3 with log-file validation), and CloudWatch alarms fire on sensitive
   actions (e.g., disabling GuardDuty, root usage). CloudTrail Insights
   flags unusual API spikes.
Mirrors using the Azure Activity Log for audit + alerting.
```

---

## 74.6 Interview Q&A

**Q: What is CloudTrail?** → A service that logs every API call in your AWS account — who did what, when, and from where — delivered to S3 (long-term audit) and optionally CloudWatch Logs (for alarms). It's essential for security investigation, compliance, and troubleshooting, and is the equivalent of the Azure Activity Log.
**Q: How do you set up central, tamper-evident auditing?** → An Organization Trail delivering all accounts' logs to a dedicated, locked-down log-archive account's S3 bucket with log-file validation enabled; alarm on sensitive actions via CloudWatch, and use CloudTrail Insights for anomaly detection.

## 74.7 Summary

CloudTrail logs every API call in your AWS account (who, what, when, from where) — management events by default, plus optional data events and Insights for anomaly detection — delivered to S3 (long-term, tamper-evident) and optionally CloudWatch Logs (for alarms). An Organization Trail centralizes auditing across all accounts in a locked-down log-archive account. It's essential for security, compliance, and "who did this?" troubleshooting — the equivalent of the Azure Activity Log.

---
---

# 75. 🏷️ Tagging & Naming Conventions
> 🟡 KNOW-THIS-MUCH

---

## 75.1 What Problem Does This Solve?

At scale, resources become untraceable without consistent metadata. **Tags** (key-value labels) + naming conventions enable cost attribution, ownership, automation, and governance.

> 💡 **If you know Azure:** Identical to the Azure tagging section — AWS tags work like Azure tags. Enforced via SCPs/Config (≈ Azure Policy).

---

## 75.2 Tags & Enforcement (Flow Diagram)

```
Every resource gets TAGS: Environment / Project / Owner / CostCenter / ManagedBy
   → enable: Cost Allocation (filter the bill by CostCenter), ownership,
     automation ("stop all Environment=Dev at night"), governance

Naming: <service>-<app>-<env>  (e.g., ec2-portal-prod, sg-portal-prod)

ENFORCEMENT:
   • Tag Policies (Organizations) → standardize tag keys/values
   • SCPs → deny creating resources without required tags
   • AWS Config rule → flag untagged/non-compliant resources
```

---

## 75.3 Key Facts

```
✅ Tags enable Cost Allocation reports (activate cost allocation tags in Billing)
✅ Common tags: Environment, Project/Application, Owner, CostCenter, ManagedBy
✅ Enforce via Tag Policies + SCPs (deny untagged) + Config (audit)
✅ Automation targets by tag (e.g., Systems Manager stops Env=Dev off-hours)
```

---

## 75.4 Real-World Example

```
An org brings order to a sprawling AWS estate:
   • Naming: sg-portal-prod, ec2-portal-prod, etc. — instantly identifiable.
   • Required tags enforced by SCP + Tag Policies: Environment, Project,
     Owner, CostCenter — no resource created without them.
   • Finance uses Cost Allocation reports filtered by CostCenter for chargeback.
   • A Systems Manager automation stops all Environment=Dev instances nightly.
   • "ManagedBy=Terraform" warns engineers not to hand-edit IaC resources.
Mirrors the Azure tagging + Azure Policy enforcement approach.
```

---

## 75.5 Interview Q&A

**Q: Why are tags and naming important, and how do you enforce them?** → Tags (Environment, Project, Owner, CostCenter) enable cost attribution/chargeback, ownership tracking, automation targeting, and governance; consistent naming makes resources identifiable. Enforce with Tag Policies + SCPs (deny untagged resources) + AWS Config (audit non-compliance) — the AWS equivalent of enforcing tags via Azure Policy.

## 75.6 Summary

Tags (key-value labels like Environment, Project, Owner, CostCenter) and consistent naming bring order to large AWS estates — enabling cost allocation/chargeback, ownership, automation targeting, and governance — enforced via Tag Policies, SCPs (deny untagged), and AWS Config (audit). Same concept and best practices as Azure tags, enforced with SCPs/Config instead of Azure Policy.

---
---

# 76. 🏗️ AWS Landing Zone / Control Tower
> 🟡 KNOW-THIS-MUCH

---

## 76.1 What Problem Does This Solve?

Enterprises adopting AWS need a secure, governed, multi-account foundation *before* workloads land — otherwise setup is inconsistent and ungovernable. **AWS Control Tower** automates a best-practice multi-account **Landing Zone**.

> 💡 **If you know Azure:** Control Tower / Landing Zone is the direct equivalent of an **Azure Landing Zone** (and the Landing Zone accelerator) — a pre-built, governed multi-account/subscription foundation.

---

## 76.2 What It Provides (Flow Diagram)

```
AWS CONTROL TOWER automates a LANDING ZONE:
   • Multi-account structure (Organizations + OUs) set up with best practices
   • Dedicated accounts: management, log-archive (central CloudTrail/Config),
     audit (security tooling)
   • GUARDRAILS (preventive SCPs + detective Config rules) applied org-wide
   • Centralized IAM Identity Center (SSO) for access
   • Account Factory → vend new, pre-governed accounts on demand
   • Centralized logging + monitoring baseline

Teams get new accounts (via Account Factory) that already have security,
guardrails, logging, and networking baselines — no manual foundation setup.
```

---

## 76.3 Key Facts

```
✅ Control Tower = automated setup of a governed multi-account Landing Zone
✅ Dedicated log-archive + audit accounts (central security/logging)
✅ Guardrails = preventive (SCPs) + detective (Config) applied across accounts
✅ Account Factory vends new pre-governed accounts on demand
✅ Best practice for enterprise AWS adoption (vs ad-hoc account sprawl)
```

---

## 76.4 Real-World Example

```
An enterprise onboarding many teams to AWS uses Control Tower:
   • It sets up the OU structure + management/log-archive/audit accounts.
   • Guardrails (SCPs + Config) enforce encryption, region restrictions,
     and CloudTrail-always-on across every account.
   • IAM Identity Center provides SSO across accounts.
   • When a new team needs an account, Account Factory vends one already
     wired with security, logging, guardrails, and networking baselines.
So a new workload lands in a secure, compliant, governed account from day
one — the AWS equivalent of an Azure Landing Zone.
```

---

## 76.5 Interview Q&A

**Q: What is AWS Control Tower / a Landing Zone?** → Control Tower automates the setup of a governed, best-practice multi-account Landing Zone — the OU structure, dedicated management/log-archive/audit accounts, org-wide guardrails (SCPs + Config), centralized SSO, and an Account Factory that vends new pre-governed accounts on demand. It gives enterprises a secure, compliant foundation so workloads land in governed accounts from day one. It's the equivalent of an Azure Landing Zone.

## 76.6 Summary

AWS Control Tower automates a governed multi-account Landing Zone — best-practice OU structure, dedicated log-archive/audit accounts, org-wide guardrails (SCPs + Config), centralized IAM Identity Center SSO, and an Account Factory that vends pre-governed accounts on demand. It's the best-practice foundation for enterprise AWS adoption (vs ad-hoc sprawl), so every workload lands secure and compliant from day one — the direct equivalent of an Azure Landing Zone.

---
---

# 77. 💰 Cost Management & FinOps
> 🟡 KNOW-THIS-MUCH

---

## 77.1 What Problem Does This Solve?

Cloud costs spiral without visibility and discipline. AWS provides cost tools (**Cost Explorer**, **Budgets**), and **FinOps** is the practice of managing cloud spend as a team responsibility.

> 💡 **If you know Azure:** Cost Explorer + Budgets ≈ Azure **Cost Management**; Savings Plans/Reserved Instances ≈ Azure Reservations/Savings Plans; FinOps is the same cross-cloud discipline.

---

## 77.2 Cost Tools & Levers (Flow Diagram)

```
COST VISIBILITY & CONTROL:
   Cost Explorer → visualize/break down spend (by service, tag, account)
   Budgets       → set thresholds + alerts (50/75/90/100%) → catch overspend early
   Cost Anomaly Detection → ML flags unusual spend spikes
   Cost Allocation Tags → attribute cost by team/project (Section 75)

OPTIMIZATION LEVERS:
   • Savings Plans / Reserved Instances → commit for steady workloads (big discount)
   • Spot Instances → up to ~90% off for fault-tolerant/batch
   • Right-size (Compute Optimizer recommends) · delete orphaned resources
     (unattached EBS, idle NAT, unused EIPs)
   • S3 lifecycle tiering · Auto Scaling · stop non-prod off-hours
```

---

## 77.3 Key Facts

```
✅ Cost Explorer (analysis by service/tag/account) + Budgets (alerts) +
   Cost Anomaly Detection (ML spike alerts)
✅ Savings Plans/RIs for steady workloads; Spot for fault-tolerant; right-size
   via Compute Optimizer
✅ Delete orphaned resources (unattached EBS, idle NAT Gateways, unused EIPs)
✅ Tagging (Section 75) underpins cost attribution/chargeback
✅ FinOps = cost as a shared, continuous, first-class team responsibility
```

---

## 77.4 Real-World Example

```
A team applies FinOps discipline as the bill creeps up:
   • Cost Explorer (filtered by CostCenter tag) reveals dev EC2 running
     24/7 and idle NAT Gateways as big costs.
   • Fixes: Systems Manager stops dev instances off-hours (~60% saving on
     that compute); Savings Plans for steady prod; Spot for batch;
     delete orphaned EBS volumes + unused Elastic IPs; S3 lifecycle tiering.
   • Budgets with alerts at 50/75/90/100% + Cost Anomaly Detection prevent
     bill surprises.
Same FinOps approach as the Azure notes (Cost Management + Reservations).
```

---

## 77.5 Interview Q&A

**Q: How do you manage and control AWS costs?** → Cost Explorer for visibility (break down by service/tag/account), Budgets with tiered alerts to catch overspend early, and Cost Anomaly Detection for ML spike alerts. Optimization levers: Savings Plans/Reserved Instances (steady workloads), Spot (fault-tolerant/batch), right-sizing (Compute Optimizer), deleting orphaned resources (unattached EBS, idle NAT, unused EIPs), S3 lifecycle tiering, autoscaling, and stopping non-prod off-hours. Tagging underpins cost attribution.
**Q: What is FinOps?** → The discipline of managing cloud cost as a shared, continuous, first-class team responsibility — visibility (via tags), accountability (chargeback), and ongoing optimization — treating cost alongside performance and reliability.

## 77.6 Summary

AWS cost management uses Cost Explorer (analysis by service/tag/account), Budgets (tiered alerts), and Cost Anomaly Detection (ML spike alerts), with tagging underpinning attribution. Optimization levers: Savings Plans/RIs (steady), Spot (fault-tolerant), right-sizing (Compute Optimizer), deleting orphaned resources, S3 lifecycle tiering, autoscaling, and stopping non-prod off-hours. FinOps is the discipline of treating cost as a shared, continuous responsibility — the same approach as the Azure notes with AWS tooling.

---
---

# 78. 🔄 Backup & Disaster Recovery (RTO/RPO)
> 🟡 KNOW-THIS-MUCH

---

## 78.1 What Problem Does This Solve?

Things fail — data loss, region outages. **Backup** protects data; **Disaster Recovery (DR)** restores whole applications. **RTO/RPO** turn "how resilient?" into measurable targets — core to the JD's reliability focus.

> 💡 **If you know Azure:** AWS Backup ≈ Azure Backup; the DR patterns + RTO/RPO are cloud-agnostic (identical to the Azure notes). AWS Elastic Disaster Recovery ≈ Azure Site Recovery.

---

## 78.2 RTO/RPO & DR Strategies (Flow Diagram)

```
RPO = how much DATA you can lose (backup frequency)
RTO = how long you can be DOWN (recovery time)
Lower = more resilient but more expensive → set by criticality.

DR STRATEGIES (cost vs resilience):
   Backup & Restore   → restore from backups (hours RTO, cheapest)
   Pilot Light        → minimal core running in DR region, scale up on failover
   Warm Standby       → scaled-down running copy, scale up on failover (minutes)
   Multi-Site Active-Active → full running copies serving traffic (near-zero, priciest)

AWS TOOLS:
   AWS Backup → centralized scheduled backups (EBS, RDS, DynamoDB, EFS, S3...)
   Cross-Region Replication (S3, RDS, DynamoDB Global Tables)
   Elastic Disaster Recovery (DRS) → replicate servers to a DR region
   Route 53 failover routing → DNS failover to the DR site
```

---

## 78.3 Key Facts

```
✅ RPO = data loss tolerance; RTO = downtime tolerance; set by criticality
✅ AWS Backup = centralized backup across services (scheduled, cross-region,
   retention, vault lock for immutability)
✅ DR patterns: Backup&Restore → Pilot Light → Warm Standby → Active-Active
   (increasing cost/resilience)
✅ Cross-region replication (S3 CRR, RDS read replicas, DynamoDB Global Tables)
✅ Route 53 failover routing (health checks) for automatic DNS failover
✅ ALWAYS TEST restores/failovers — untested = unreliable
```

---

## 78.4 Real-World Example

```
A payment platform: RPO 5 min, RTO 15 min (strict, payments critical):
   • AWS Backup: frequent RDS/EBS/DynamoDB backups, cross-region, vault
     lock (immutable) — protects against data loss/ransomware.
   • Warm Standby in a second region (RDS cross-region replica, scaled-down
     app) → scale up + Route 53 failover on a regional outage → within RTO.
   • Quarterly DR drills verify the plan meets RTO.
   A less-critical internal tool uses simple Backup & Restore (hours RTO
   acceptable) — strategy matched to criticality.
Mirrors the Azure Backup + Site Recovery + RTO/RPO approach.
```

---

## 78.5 Interview Q&A

**Q: RTO vs RPO?** → RPO is how much data you can afford to lose (drives backup frequency); RTO is how long you can be down (recovery time). Lower values mean more resilience but higher cost — set by how critical the system is.
**Q: What are the DR strategies?** → Backup & Restore (cheapest, hours), Pilot Light (minimal core in DR region), Warm Standby (scaled-down running copy, minutes), and Multi-Site Active-Active (full copies, near-zero, priciest) — increasing cost and resilience. Choose based on RTO/RPO.
**Q: Key AWS DR tools and practice?** → AWS Backup (centralized backups), cross-region replication (S3/RDS/DynamoDB Global Tables), Elastic Disaster Recovery (server replication), and Route 53 failover routing. Always test restores/failovers — an untested plan isn't reliable.

## 78.6 Summary

Backup (AWS Backup — centralized, scheduled, cross-region, immutable vault lock) protects data, and DR restores whole applications after outages, measured by RPO (data loss tolerance) and RTO (downtime tolerance) which drive the strategy choice: Backup & Restore → Pilot Light → Warm Standby → Active-Active (increasing cost/resilience). Use cross-region replication (S3/RDS/DynamoDB Global Tables), Elastic Disaster Recovery, and Route 53 failover routing — and always test restores/failovers. Cloud-agnostic RTO/RPO concepts, mirroring the Azure Backup + Site Recovery approach.

---
---

# 79. 🔥 All Integration Flows Consolidated
> 🔴 FULL

---

## 79.1 Why This Section Matters Most

Interviewers probe how services connect and authenticate end-to-end. Nearly all AWS flows share one pattern: **IAM identity (role) → STS/AssumeRole → scoped permissions → target, with no long-lived stored credentials wherever possible.**

---

## 79.2 The Key Integration Flows

```
1. CI/CD → AWS:          CI tool → OIDC/AssumeRole (STS) → scoped IAM role → deploy
                         (ADO/Jenkins/Bitbucket/GitHub — Sections 29-30)
2. Pipeline → Secrets:   pipeline's assumed role → Secrets Manager/Parameter
                         Store at runtime (no stored secrets)
3. Pipeline → ECR:       build → push image → ECR (auth via assumed role)
4. ECR → ECS/EKS:        task role / node role / IRSA → pull image (no creds)
5. Terraform → AWS:      aws provider → OIDC/AssumeRole → IAM role → resources
                         (state in S3 + DynamoDB locking)
6. EKS Pod → Secrets:    IRSA → Secrets Manager (Secrets Store CSI mounts as file)
7. App → Monitoring:     app + X-Ray SDK → CloudWatch (metrics/logs/alarms) +
                         X-Ray (traces) → SNS → PagerDuty
8. Cross-Account:        source assumes a target-account role (two-sided trust) →
                         deploy across accounts (multi-account CI/CD, Section 33)
9. Serverless:           API Gateway → Lambda (execution role) → DynamoDB;
                         S3 event → Lambda; EventBridge → Lambda/Step Functions
10. Event-Driven:        SNS → multiple SQS (fan-out) → consumers; EventBridge
                         rules → targets (content-based routing)
```

---

## 79.3 The One Pattern Behind Almost All of Them

```
┌────────────────────────────────────────────────────────────┐
│  IAM IDENTITY (IAM role — service role / instance role /     │
│                IRSA / assumed via OIDC or cross-account)     │
│       ↓ STS issues SHORT-LIVED credentials (AssumeRole /     │
│         AssumeRoleWithWebIdentity)                           │
│  SCOPED PERMISSIONS (IAM policies — least privilege)         │
│       ↓                                                      │
│  THE TARGET (S3 / DynamoDB / ECR / Secrets Manager / any)    │
│  ...with NO long-lived stored credentials wherever possible. │
└────────────────────────────────────────────────────────────┘

If you internalize THIS, you can reason through ANY AWS integration/auth
question — they're all variations of it. (The AWS mirror of Azure's
identity → Entra ID → RBAC → resource pattern.)
```

---

## 79.4 Interview Q&A

**Q: A pipeline builds a container, pushes it, deploys to ECS/EKS, and the app reads a secret — walk through the auth end-to-end.**
> The pipeline authenticates via OIDC (AssumeRoleWithWebIdentity → a scoped IAM deploy role, no stored keys). It builds and pushes the image to ECR (authorized by that role). ECS/EKS pull the image via their task role / IRSA / node role (no stored creds). At runtime, the app (ECS task role or EKS IRSA) reads the secret from Secrets Manager. Every step uses an IAM role with short-lived STS credentials and least-privilege scope — no long-lived stored credentials anywhere.
**Q: What's the common thread across all AWS integrations?**
> IAM identity → STS short-lived credentials (AssumeRole) → scoped permissions → target, with no long-lived stored credentials wherever possible. It's the AWS mirror of Azure's identity → Entra ID → RBAC → resource pattern.

## 79.5 Summary

The key AWS integration flows — CI/CD→AWS, Pipeline→Secrets, Pipeline→ECR, ECR→ECS/EKS, Terraform→AWS, EKS Pod→Secrets, App→Monitoring, Cross-Account, Serverless (API GW→Lambda→DynamoDB), and Event-Driven (SNS/EventBridge) — nearly all follow one unifying pattern: **IAM identity → STS short-lived credentials → scoped permissions → target, no long-lived stored credentials.** Master this pattern (the AWS mirror of Azure's identity→Entra ID→RBAC→resource) and you can reason through any integration/auth question.

---
---

# 80. 🎓 Rapid-Fire Interview Q&A
> 🔴 FULL

---

## 80.1 Identity & Access

IAM = auth + authz (JSON policies) · Users (long-term creds) vs Roles (short-lived, preferred for all automation) · policy eval = **default deny → explicit allow → explicit deny always wins** · Permission Boundary (per-identity ceiling) vs SCP (org ceiling) — both limit, neither grants · STS AssumeRole = temporary creds; cross-account needs two-sided trust · service role via instance profile ≈ Azure Managed Identity · IRSA = pods → IAM roles ≈ AKS Workload Identity · secure CI/CD auth = OIDC/AssumeRoleWithWebIdentity (no stored keys).

## 80.2 Networking

VPC ≈ VNet (but needs an Internet Gateway; subnets are AZ-scoped) · public subnet = route to IGW; private = via NAT Gateway · Security Group (instance, stateful, allow-only) vs NACL (subnet, stateless, allow+deny) · reference an SG as a source = autoscale-safe rules · VPC Peering non-transitive → Transit Gateway (transitive hub) for many VPCs · Gateway Endpoint (S3/DynamoDB, free) vs Interface Endpoint/PrivateLink (private IP) ≈ Azure Service vs Private Endpoint · ALB (L7) / NLB (L4) / GWLB · Reachability Analyzer for "why can't X reach Y?".

## 80.3 Secrets & Security

Secrets Manager (rotation) vs Parameter Store (config/cheap) · fetch at runtime via IAM role (no hardcoding) · KMS = managed encryption keys (envelope encryption) · DevSecOps = shift-left scanning + SCPs/Config guardrails + GuardDuty/Inspector/Security Hub.

## 80.4 CI/CD

CI/CD → AWS: OIDC/AssumeRole (no stored keys) — ADO (AWS Service Connection), Jenkins (instance role/credentials), Bitbucket (OIDC), GitHub (OIDC) · trunk-based dev + feature flags (AppConfig) · build once/deploy many · multi-account = assume cross-account deploy roles · buildspec.yml (CodeBuild) / appspec.yml (CodeDeploy).

## 80.5 Containers

Multi-stage builds = small/secure images · ECR pulled via IAM roles (no creds) · ECS (AWS-native, Fargate serverless vs EC2) vs EKS (Kubernetes) · AKS free control plane, **EKS charges for control plane** · HPA (pods) + Cluster Autoscaler/**Karpenter** (nodes) · Helm (package manager) + GitOps (Argo CD/Flux, pull-based).

## 80.6 Serverless

Lambda (15-min max, Provisioned Concurrency for cold starts, execution role) · API Gateway (REST/HTTP/WebSocket) → Lambda → DynamoDB · S3 (storage classes, lifecycle, pre-signed URLs ≈ SAS, events) · SQS (queue, decouple) vs SNS (pub/sub fan-out) · SNS→SQS fan-out pattern · EventBridge (content-based event bus ≈ Event Grid) · Step Functions (orchestration ≈ Durable Functions) · DynamoDB (partition key design, GSI, Streams, DAX) · Kinesis (streaming ≈ Event Hubs).

## 80.7 Deploy & Observe

Blue/Green (CodeDeploy, instant switch/rollback) vs Canary (gradual %, limits blast radius) · rollback = switch-back/canary-0%/auto-rollback-on-alarm/helm-rollback/flag-off · CloudWatch (metrics/logs/alarms; agent for memory/disk) · Logs Insights (why) vs metrics (that) · X-Ray = distributed tracing (which service is slow) · RTO (downtime) vs RPO (data loss) · SLI/SLO/SLA + error budgets.

## 80.8 Governance

SCPs (preventive org guardrails) + Config (detective compliance) ≈ Azure Policy · CloudTrail = API audit log ≈ Activity Log · Control Tower = governed multi-account Landing Zone · Cost Explorer + Budgets + Savings Plans/Spot · AWS Backup + DR patterns (Backup&Restore→Pilot Light→Warm Standby→Active-Active).

## 80.9 Scenario Questions

**Secure CI/CD to EKS?** → OIDC (AssumeRole, no keys) → build+test+scan → push to ECR → deploy to EKS (pulls via IRSA/node role) → pod reads secrets from Secrets Manager via IRSA → approval gate → canary (CodeDeploy/Flagger) → CloudWatch/X-Ray. No stored creds. **Prod deploy caused errors?** → mitigate first (CodeDeploy auto-rollback / flag-off / canary-0%), then investigate (CloudWatch metrics, Logs Insights, X-Ray), resolve, blameless post-mortem.

**Recurring themes to emphasize:** least privilege · no long-lived stored credentials (IAM roles/OIDC/STS) · build once, deploy many · mitigate-then-investigate · defense-in-depth · IAM identity → STS → scoped permissions → target.

## 80.10 Summary

This rapid-fire set covers the highest-probability AWS interview questions across every domain. Practice each aloud concisely — for scenarios, narrate the end-to-end flow (Section 79) and emphasize the recurring themes: least privilege, no long-lived stored credentials (IAM roles + STS + OIDC), build-once-deploy-many, mitigate-then-investigate, and defense-in-depth.

---
---

# 81. 📌 Final Quick Reference (Azure↔AWS Table, Numbers, One-Liners)
> 🔴 FULL

---

## 81.1 Azure ↔ AWS Service Map (Your Fast Anchor)

| Category | Azure | AWS |
|---|---|---|
| Identity | Entra ID + RBAC | IAM |
| Non-human identity | Managed Identity / Service Principal | IAM Role (+ instance profile) |
| CI/CD → cloud auth | Workload Identity Federation | OIDC + AssumeRoleWithWebIdentity |
| Temp creds service | (Entra ID token) | STS |
| Org hierarchy | Mgmt Group / Subscription / RG | OU / Account / (tags) |
| Governance/policy | Azure Policy | SCPs + Config |
| Virtual server | Virtual Machine | EC2 |
| Autoscaling group | VM Scale Set | Auto Scaling Group |
| Object storage | Blob Storage | S3 |
| Pre-signed access | SAS token | Pre-signed URL |
| Block storage | Managed Disks | EBS |
| Shared file storage | Azure Files | EFS |
| Private network | VNet | VPC |
| Firewall (basic) | NSG (one construct) | Security Group + NACL |
| Firewall (central) | Azure Firewall | AWS Network Firewall |
| Private service access | Private Endpoint / Service Endpoint | Interface (PrivateLink) / Gateway Endpoint |
| L7 / L4 load balancer | App Gateway / Load Balancer | ALB / NLB |
| Hub networking | Hub-Spoke / Virtual WAN | Transit Gateway |
| DNS | Azure DNS + Traffic Manager | Route 53 |
| Dedicated connection | ExpressRoute | Direct Connect |
| Secrets | Key Vault | Secrets Manager + Parameter Store |
| Encryption keys | Key Vault (keys) | KMS |
| SQL database | Azure SQL | RDS / Aurora |
| NoSQL | Cosmos DB | DynamoDB |
| Cache | Cache for Redis | ElastiCache |
| Kubernetes | AKS (free CP) | EKS (paid CP) |
| AWS-native containers | Container Apps (~) | ECS (Fargate/EC2) |
| Container registry | ACR | ECR |
| Serverless functions | Azure Functions | Lambda |
| API gateway | API Management | API Gateway |
| Queue | Queue Storage / Service Bus | SQS |
| Pub/sub / events | Event Grid | SNS / EventBridge |
| Workflow orchestration | Durable Functions / Logic Apps | Step Functions |
| Streaming | Event Hubs | Kinesis |
| CI/CD suite | Azure DevOps | CodePipeline/Build/Deploy (+ GitHub Actions) |
| IaC (native) | ARM / Bicep | CloudFormation / CDK |
| IaC (multi-cloud) | Terraform | Terraform |
| TF state backend | Storage Account + blob lease | S3 + DynamoDB |
| Monitoring | Azure Monitor | CloudWatch |
| Log querying | Log Analytics / KQL | CloudWatch Logs Insights |
| Distributed tracing | Application Insights | X-Ray |
| Feature flags | App Configuration | AppConfig |
| Threat detection | Defender for Cloud | GuardDuty |
| Vuln scanning | Defender | Inspector |
| Security posture | Defender / Sentinel | Security Hub |
| Audit log | Activity Log | CloudTrail |
| Landing zone | Azure Landing Zone | Control Tower |
| Cost tools | Cost Management | Cost Explorer + Budgets |
| Backup/DR | Azure Backup / Site Recovery | AWS Backup / Elastic DR |
| AI assistant | Copilot / Azure OpenAI | Amazon Q / Bedrock |

---

## 81.2 Key Numbers

```
CIDR: /24 = 256 (a subnet) · /16 = 65,536 (a VPC) · AWS reserves 5 IPs/subnet (/24 = 251 usable)
Lambda: max 15-min timeout · up to 10 GB memory
SQS: message retention up to 14 days · max 256 KB message
S3: 11 nines durability · 5 GB max single PUT (multipart for larger)
STS: temp creds 15 min – 12 hours
EBS: gp3 (default SSD), io2 (high IOPS)
Ports: 22 SSH · 80 HTTP · 443 HTTPS · 3389 RDP · 3306 MySQL · 5432 Postgres · 1433 SQL Server
EKS: control plane has an hourly fee (vs AKS free)
IAM eval: default deny → explicit allow → explicit deny wins
```

---

## 81.3 "Say This in the Interview" One-Liners

```
Auth (any integration): "IAM identity → STS short-lived creds → scoped
   permissions → target; no long-lived stored keys via IAM roles + OIDC."
CI/CD auth: "OIDC federation — IAM OIDC provider + AssumeRoleWithWebIdentity,
   short-lived creds, least-privilege role, no stored keys."
Secrets: "Never hardcode — Secrets Manager/Parameter Store fetched at
   runtime via an IAM role."
IAM eval: "Default deny; explicit allow grants; explicit deny always wins."
Deployment: "Build once, deploy many; promote the same artifact; approval
   before prod; Blue/Green or Canary with auto-rollback on CloudWatch alarms."
Networking security: "Defense in depth — private subnets, Security Groups,
   PrivateLink, NACLs, Network Firewall for central egress."
Multi-account: "Separate accounts per env (hard isolation); pipeline assumes
   scoped cross-account roles — no standing prod access."
Incident: "Mitigate first (rollback/flag-off), then investigate with
   CloudWatch metrics, Logs Insights, and X-Ray."
Reliability: "Define RTO/RPO and SLOs; error budgets balance velocity vs stability."
Containers: "ECS for AWS-native simplicity, EKS for Kubernetes/portability;
   pods get AWS access via IRSA; Karpenter for fast node autoscaling."
```

---

## 81.4 Night-Before Checklist

```
✅ IAM policy evaluation logic (default deny → allow → explicit deny wins)
✅ Users vs Roles; Permission Boundary vs SCP; STS AssumeRole + cross-account trust
✅ OIDC federation for CI/CD (ADO/Jenkins/Bitbucket/GitHub → AWS)
✅ VPC + IGW + public/private subnets + NAT + SG vs NACL + endpoints
✅ Transit Gateway vs VPC Peering; Gateway vs Interface endpoint
✅ Secrets Manager vs Parameter Store; KMS envelope encryption
✅ ECS (Fargate/EC2) vs EKS; ECR pulls via IAM; IRSA; Karpenter
✅ Lambda + API Gateway + DynamoDB serverless flow; SQS vs SNS; EventBridge; Step Functions
✅ Blue/Green (CodeDeploy) vs Canary; rollback options
✅ CloudWatch metrics/logs/alarms; Logs Insights; X-Ray tracing
✅ SCPs vs Config; CloudTrail; Control Tower; RTO/RPO + DR patterns
✅ The IAM identity → STS → scoped permissions → target pattern (Section 79)
✅ Azure↔AWS mapping for every service (you know Azure)
```

---

## 81.5 Final Note

You now have a complete, interview-focused AWS reference covering everything a DevOps role expects — foundations, deep IAM (the AWS interview heartland), full networking, secrets, the multi-tool CI/CD auth + secrets integration (Azure DevOps/Jenkins/Bitbucket/GitHub — your real experience), IaC, compute, containers (ECS + EKS + Karpenter), the expanded serverless/eventing block (Lambda, API Gateway, S3, SQS, SNS, EventBridge, Step Functions, Kinesis, DynamoDB, SAM), deployment strategies, observability, DevSecOps, AIOps, governance, and the integration flows. Since you know Azure, lean on the 💡 relate-notes and the Azure↔AWS table as anchors, but be able to explain each on its own terms. The single most valuable thing to internalize is the recurring **IAM identity → STS short-lived credentials → scoped permissions → target (no long-lived stored keys)** pattern — it unlocks most AWS integration/auth questions, just as the identity→Entra ID→RBAC pattern did for Azure. Focus your final review on the 🔴 FULL sections (especially IAM 3-8), the integration flows (Section 79), and the CI/CD auth/secrets sections (29-30). Good luck! 🚀

---
