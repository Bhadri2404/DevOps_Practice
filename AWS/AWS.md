# 🏗️ AWS Solutions Architect — Master Architecture Notes
### *From Foundations to Enterprise Production Design*

---

# 📋 TABLE OF CONTENTS

1. [Cloud Computing Foundations](#1-cloud-computing-foundations)
2. [AWS Global Infrastructure](#2-aws-global-infrastructure)
3. [IAM — Identity & Access Management](#3-iam--identity--access-management)
4. [S3 — Simple Storage Service](#4-s3--simple-storage-service)
5. [EC2 — Elastic Compute Cloud](#5-ec2--elastic-compute-cloud)
6. [EBS — Elastic Block Store & Snapshots](#6-ebs--elastic-block-store--snapshots)
7. [ELB — Elastic Load Balancing](#7-elb--elastic-load-balancing)
8. [Auto Scaling Groups](#8-auto-scaling-groups)
9. [CloudWatch — Monitoring & Observability](#9-cloudwatch--monitoring--observability)
10. [EFS — Elastic File System](#10-efs--elastic-file-system)
11. [Route 53 — DNS Service](#11-route-53--dns-service)
12. [VPC — Virtual Private Cloud](#12-vpc--virtual-private-cloud)
13. [Databases on AWS](#13-databases-on-aws)
14. [Application Services (SQS, SNS, CloudFront)](#14-application-services)
15. [Security Architecture](#15-security-architecture)
16. [Well-Architected Framework](#16-well-architected-framework)
17. [Real Production Architecture Scenarios](#17-real-production-architecture-scenarios)
18. [Architecture Decision Trade-Off Tables](#18-architecture-decision-trade-off-tables)
19. [Disaster Recovery & Reliability Design](#19-disaster-recovery--reliability-design)
20. [Cost Optimization Strategy](#20-cost-optimization-strategy)
21. [Troubleshooting & Debugging Guide](#21-troubleshooting--debugging-guide)
22. [Interview-Focused Architecture Questions](#22-interview-focused-architecture-questions)

---

# 1. CLOUD COMPUTING FOUNDATIONS

## 1.1 What Is Cloud Computing?

**Simple Explanation:**
Cloud computing means using someone else's computers (servers, storage, databases) over the internet and paying only for what you use — like electricity or water.

**AWS Definition:**
> On-demand delivery of compute power, database storage, applications, and other IT resources via the internet with pay-as-you-go pricing.

---

## 1.2 The Six Advantages of Cloud Computing (Amazon's Framework)

| # | Advantage | Architect-Level Insight |
|---|-----------|------------------------|
| 1 | **Trade CapEx for OpEx** | No upfront hardware investment. Scale experiments cheaply. Reduces budget risk. |
| 2 | **Economies of Scale** | AWS serves millions → passes cost savings to you via lower per-unit pricing |
| 3 | **Stop Guessing Capacity** | Auto Scaling eliminates over/under-provisioning. Pay exactly for demand. |
| 4 | **Increase Speed & Agility** | Provision resources in minutes vs. weeks for on-premises procurement |
| 5 | **Stop Running Data Centers** | Focus on business differentiation, not physical infrastructure management |
| 6 | **Go Global in Minutes** | Deploy to any AWS Region with a few clicks. CloudFront delivers global low-latency |

---

## 1.3 NIST Cloud Computing Essential Characteristics

| Characteristic | Architect Relevance |
|---------------|---------------------|
| **On-demand self-service** | Enables IaC automation (CloudFormation, Terraform) — no human provisioning |
| **Broad network access** | Services accessible over standard protocols from any device |
| **Resource pooling** | Multi-tenant shared infrastructure — underpins cost efficiency |
| **Rapid elasticity** | Foundation for Auto Scaling Groups, Lambda, Aurora Serverless |
| **Measured service** | Pay-per-use model — enables cost tracking via Cost Explorer, Budgets |

---

## 1.4 Cloud Service Models — Deep Architecture View

```
┌─────────────────────────────────────────────────────────────┐
│                    SERVICE MODEL STACK                       │
├──────────────┬──────────────────────────────────────────────┤
│   SaaS       │ Gmail, Salesforce, Netflix                   │
│              │ You manage: Nothing                          │
│              │ AWS manages: Everything                      │
├──────────────┼──────────────────────────────────────────────┤
│   PaaS       │ AWS Elastic Beanstalk, AWS Lambda            │
│              │ You manage: Code, Data                       │
│              │ AWS manages: OS, Runtime, Scaling            │
├──────────────┼──────────────────────────────────────────────┤
│   IaaS       │ EC2, VPC, EBS                                │
│              │ You manage: OS, Apps, Data, Security Groups  │
│              │ AWS manages: Physical hardware, Hypervisor   │
└──────────────┴──────────────────────────────────────────────┘
```

**Architect Decision Logic:**

- **Choose SaaS** → When you need business software with zero infrastructure management (e.g., Salesforce CRM)
- **Choose PaaS (Beanstalk/Lambda)** → When dev team wants to focus only on code; acceptable to lose OS-level control
- **Choose IaaS (EC2)** → When you need OS-level control, custom software, legacy app migration, specific compliance requirements

---

## 1.5 Cloud Deployment Models

| Model | Description | Use Case | AWS Example |
|-------|-------------|----------|-------------|
| **Public Cloud** | Shared infrastructure, internet-accessible | Startups, web apps, general workloads | AWS, Azure, GCP |
| **Private Cloud** | Dedicated to one org, on-prem or hosted | Regulated industries — banking, healthcare | AWS Outposts, VMware on AWS |
| **Community Cloud** | Shared among orgs with common concerns | Government agencies, research institutions | GovCloud |
| **Hybrid Cloud** | Mix of public + private with orchestration | Gradual cloud migration, data residency | AWS Direct Connect + VPC |

**Production Insight:**
Most enterprises operate **Hybrid Cloud** during migration phases:
- Keep sensitive data in on-premises private cloud
- Burst compute workloads to AWS public cloud
- Connect via **AWS Direct Connect** or **Site-to-Site VPN**

---

# 2. AWS GLOBAL INFRASTRUCTURE

## 2.1 Three-Tier Infrastructure Architecture

```
┌─────────────────────────────────────────────────┐
│              AWS GLOBAL INFRASTRUCTURE           │
│                                                  │
│  ┌──────────────────────────────────────────┐   │
│  │              REGIONS                     │   │
│  │  Geographic area (e.g., us-east-1)       │   │
│  │  ┌────────────────────────────────────┐  │   │
│  │  │       AVAILABILITY ZONES           │  │   │
│  │  │  Physical data centers (AZ-1a)     │  │   │
│  │  │  Connected via low-latency fiber   │  │   │
│  │  └────────────────────────────────────┘  │   │
│  └──────────────────────────────────────────┘   │
│                                                  │
│  ┌──────────────────────────────────────────┐   │
│  │         EDGE LOCATIONS (200+)            │   │
│  │  CloudFront CDN cache points             │   │
│  │  Located in major cities worldwide       │   │
│  └──────────────────────────────────────────┘   │
└─────────────────────────────────────────────────┘
```

---

## 2.2 Regions Deep Dive

**What is a Region?**
A Region is an independent geographic cluster of Availability Zones. Each Region is physically isolated from other Regions.

**Architect-Level Region Selection Criteria:**

| Factor | Consideration |
|--------|---------------|
| **Latency** | Deploy closest to your end-users |
| **Compliance** | Data residency laws (GDPR → EU regions) |
| **Service Availability** | Not all services available in all regions |
| **Cost** | Pricing varies by region (us-east-1 typically cheapest) |
| **Disaster Recovery** | Use secondary region for DR strategy |

**Key Regions Reference:**

| Region Name | Code | Notes |
|------------|------|-------|
| US East (N. Virginia) | `us-east-1` | Primary region, most services launch here first |
| US West (Oregon) | `us-west-2` | Common DR pair with us-east-1 |
| Asia Pacific (Mumbai) | `ap-south-1` | India compliance |
| Europe (Frankfurt) | `eu-central-1` | GDPR preferred |
| Asia Pacific (Singapore) | `ap-southeast-1` | SEA hub |

---

## 2.3 Availability Zones (AZs) — Production Design

**What is an AZ?**
A physically separate data center within a Region with independent power, cooling, and networking.

**Why Multiple AZs Matter:**
```
Production Architecture Principle:
"Deploy across minimum 2 AZs for High Availability (HA)"

           REGION: us-east-1
    ┌─────────────────────────────┐
    │  AZ-1a          AZ-1b       │
    │  ┌─────────┐  ┌─────────┐  │
    │  │ App Svr │  │ App Svr │  │
    │  │ (Active)│  │(Standby)│  │
    │  └─────────┘  └─────────┘  │
    │  ┌─────────┐  ┌─────────┐  │
    │  │ Primary │  │Replica  │  │
    │  │   DB    │  │   DB    │  │
    │  └─────────┘  └─────────┘  │
    └─────────────────────────────┘
    If AZ-1a fails → traffic automatically shifts to AZ-1b
```

**Rule:** Each subnet maps to exactly ONE AZ. For HA, create one subnet per AZ.

---

## 2.4 Edge Locations

**Purpose:** Content Delivery Network (CDN) cache endpoints used by **Amazon CloudFront**.

**How it works:**
```
User Request Flow with CloudFront:

User (Mumbai) ──→ Edge Location (Mumbai)
                        │
                   Cache Hit? ──YES──→ Serve immediately (~1ms)
                        │
                        NO
                        │
                  Origin Server (S3 / EC2 in us-east-1)
                  Fetch → Cache → Serve (~100ms first time)
                  Next request → Serve from edge (~1ms)
```

**Edge Location Count:** 400+ worldwide (far more than Regions/AZs)

---

# 3. IAM — IDENTITY & ACCESS MANAGEMENT

## 3.1 Core Concept

**Simple Explanation:**
IAM is AWS's security front door. It controls WHO can do WHAT with WHICH AWS resources.

**Components:**
- **Users** → Individual human identities
- **Groups** → Collection of users sharing permissions
- **Roles** → Temporary identities assumed by services or users
- **Policies** → JSON documents defining permissions

---

## 3.2 IAM Architecture Flow

```
┌──────────────────────────────────────────────────────┐
│                  IAM PERMISSION FLOW                  │
│                                                       │
│  Principal (User/Role/Service)                       │
│          │                                            │
│          ▼                                            │
│  Authentication (Who are you?)                        │
│  → Username/Password (Console)                       │
│  → Access Key/Secret (API/CLI)                       │
│  → Temporary STS Token (Roles)                       │
│          │                                            │
│          ▼                                            │
│  Authorization (What can you do?)                    │
│  → AWS checks all attached policies                  │
│  → Default: DENY everything                          │
│  → Explicit ALLOW overrides default deny             │
│  → Explicit DENY always wins                         │
│          │                                            │
│          ▼                                            │
│  Action Permitted or Denied                          │
└──────────────────────────────────────────────────────┘
```

---

## 3.3 Root Account vs IAM User

| Feature | Root Account | IAM User |
|---------|-------------|----------|
| Created when | AWS account signup | Manually by admin |
| Permissions | Unlimited (God mode) | Controlled via policies |
| Use in daily ops | **NEVER** ❌ | ✅ Yes |
| MFA required | ✅ Always enable | ✅ Recommended |
| Access Keys | Avoid creating | Create for programmatic access |
| Tasks only root can do | Close account, change billing plan, restore IAM permissions | Everything else with proper permissions |

---

## 3.4 IAM Policy Structure — Deep Dive

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowEC2ReadOnly",
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeInstanceStatus"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "aws:RequestedRegion": "us-east-1"
        }
      }
    }
  ]
}
```

**Policy Elements Explained:**

| Element | Description | Architect Notes |
|---------|-------------|-----------------|
| `Effect` | Allow / Deny | Explicit Deny always wins |
| `Action` | API operation (e.g., `s3:GetObject`) | Use least privilege — never `*:*` |
| `Resource` | ARN of target resource | Scope tightly; avoid `*` |
| `Condition` | Optional constraints | Add IP, MFA, time-based conditions |
| `Principal` | Who this applies to (resource policies) | Used in S3/KMS/trust policies |

---

## 3.5 Policy Types — Architect Reference

| Policy Type | Applied To | Notes |
|-------------|-----------|-------|
| **AWS Managed** | Users/Groups/Roles | Pre-built by AWS; updated automatically |
| **Customer Managed** | Users/Groups/Roles | You create and control; reusable |
| **Inline** | Single User/Role | Embedded; deleted when entity deleted |
| **Resource-Based** | S3 buckets, KMS, SQS | Cross-account access control |
| **Permission Boundary** | Users/Roles | Max permissions ceiling; delegates safely |
| **SCP (Service Control Policy)** | AWS Organizations OUs | Enterprise-level guardrails |

---

## 3.6 IAM Roles — Most Important Production Pattern

**Why Roles > Access Keys for Production:**

```
❌ BAD: Storing credentials on EC2
EC2 Instance → ~/.aws/credentials → Access Key ID + Secret
Problem: Keys can be stolen, logged, committed to Git

✅ GOOD: IAM Role attached to EC2
EC2 Instance → IAM Role → STS temporary credentials auto-rotated
No credentials stored anywhere on the server
```

**Role Assumption Flow:**
```
EC2 Instance needs to access S3
        │
        ▼
EC2 has IAM Role "EC2-S3-ReadRole" attached
        │
        ▼
EC2 calls AWS STS (Security Token Service)
        │
        ▼
STS returns temporary credentials (15min–12hr)
        │
        ▼
EC2 uses temp credentials to call S3 API
        │
        ▼
S3 validates role permissions → grants/denies
```

---

## 3.7 IAM Key Policies — Know These Three

| Policy | What It Allows | Production Use |
|--------|---------------|----------------|
| **AdministratorAccess** | Full access EXCEPT billing | Admin users — not for apps |
| **PowerUserAccess** | Full access EXCEPT IAM management | Developers needing broad access |
| **ReadOnlyAccess** | View everything, change nothing | Auditors, monitoring tools |

---

## 3.8 IAM Best Practices (Architect Checklist) ✅

```
□ Enable MFA on root account immediately after creation
□ Never use root account for daily operations
□ Create individual IAM users (no shared accounts)
□ Assign permissions via Groups, not directly to users
□ Use IAM Roles for EC2, Lambda, ECS (never Access Keys on services)
□ Apply least privilege — start with minimum permissions
□ Rotate Access Keys every 90 days
□ Set password complexity policy (minimum 12 chars, complexity requirements)
□ Enable CloudTrail to audit all IAM actions
□ Use Permission Boundaries when delegating admin to teams
□ Implement AWS Organizations SCPs for multi-account governance
□ Use IAM Access Analyzer to identify overly permissive policies
```

---

## 3.9 Common IAM Mistakes ⚠️

```
❌ Mistake 1: Wildcard Actions
   { "Action": "*", "Resource": "*" }
   → Grants everything to everyone
   ✅ Fix: Scope to specific actions and resources

❌ Mistake 2: Hardcoding credentials in application code
   DB_PASS = "mypassword123"
   ✅ Fix: Use AWS Secrets Manager or Parameter Store

❌ Mistake 3: Creating one shared IAM user for all team members
   ✅ Fix: Individual users per person for auditability

❌ Mistake 4: Not enabling MFA
   ✅ Fix: Enforce MFA via policy condition

❌ Mistake 5: Using root account Access Keys
   ✅ Fix: Delete root access keys; use IAM users
```

---

# 4. S3 — SIMPLE STORAGE SERVICE

## 4.1 Core Concept

**Simple Explanation:**
S3 is AWS's unlimited file storage. Think of it as an infinitely scalable Google Drive where files are stored as objects in named containers called "buckets."

**Key Characteristics:**
- Object storage (not file system, not block storage)
- Universal namespace — bucket names must be globally unique
- Objects can be 0 bytes to 5TB
- Unlimited number of objects per bucket
- Default 100 buckets per account (soft limit, increasable)
- 99.999999999% (11 nines) durability for Standard storage class

---

## 4.2 S3 URL Patterns

```
Path-Style URL:
https://s3.amazonaws.com/my-bucket/folder/file.jpg

Virtual-Hosted URL:
https://my-bucket.s3.amazonaws.com/folder/file.jpg

Website Endpoint:
http://my-bucket.s3-website-us-east-1.amazonaws.com/index.html
```

---

## 4.3 S3 Storage Classes — Complete Architect Reference

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      S3 STORAGE CLASS DECISION TREE                      │
│                                                                           │
│  How often do you access data?                                           │
│                                                                           │
│  Frequently (daily)                                                       │
│  └──→ S3 Standard (99.99% availability, multi-AZ, high cost)            │
│                                                                           │
│  Unknown/Variable access pattern                                          │
│  └──→ S3 Intelligent-Tiering (auto-moves between tiers, small fee)      │
│                                                                           │
│  Infrequent (monthly) + need multi-AZ resilience                        │
│  └──→ S3 Standard-IA (30-day minimum, retrieval fee, lower storage cost)│
│                                                                           │
│  Infrequent + single AZ is OK (re-creatable data)                       │
│  └──→ S3 One Zone-IA (20% cheaper than Standard-IA, one AZ only)        │
│                                                                           │
│  Archive (minutes to hours retrieval acceptable)                         │
│  └──→ S3 Glacier Instant / Flexible Retrieval                           │
│                                                                           │
│  Long-term archive (12+ hours retrieval OK)                             │
│  └──→ S3 Glacier Deep Archive (cheapest, 12-hour retrieval)             │
└─────────────────────────────────────────────────────────────────────────┘
```

**Detailed Comparison Table:**

| Storage Class | Availability | Durability | Min Duration | Retrieval Fee | Use Case |
|---------------|-------------|-----------|--------------|---------------|----------|
| S3 Standard | 99.99% | 11 nines | None | None | Active data |
| S3 Intelligent-Tiering | 99.9% | 11 nines | None | None (monitoring fee) | Unknown patterns |
| S3 Standard-IA | 99.9% | 11 nines | 30 days | Yes | Monthly access |
| S3 One Zone-IA | 99.5% | 11 nines* | 30 days | Yes | Re-creatable data |
| S3 Glacier Instant | 99.9% | 11 nines | 90 days | Yes | Quarterly access |
| S3 Glacier Flexible | 99.99% | 11 nines | 90 days | Yes | Annual archives |
| S3 Glacier Deep Archive | 99.99% | 11 nines | 180 days | Yes | 7-10yr retention |

*One Zone-IA loses durability if AZ is destroyed

---

## 4.4 S3 Versioning — Architect View

```
Versioning Enabled on Bucket:

Upload "report.pdf" (Version: abc123) → S3 stores it
Upload "report.pdf" again (Version: def456) → S3 stores BOTH

Bucket Contents:
report.pdf (Current) → def456
report.pdf (Previous) → abc123

Delete "report.pdf":
→ AWS adds a "Delete Marker" (does NOT permanently delete)
→ Restore by deleting the Delete Marker

Permanently Delete:
→ Delete specific version ID
```

**Production Use Cases:**
- Audit trail for compliance (financial, healthcare)
- Protection against accidental overwrites
- Ransomware protection (versioning + MFA Delete)
- Software artifact versioning (CodeArtifact alternative for static files)

**Important Rules:**
- Once enabled, versioning can only be **suspended**, never disabled
- Versioning is required for:
  - Cross-Region Replication
  - S3 Object Lock
  - MFA Delete

---

## 4.5 S3 Lifecycle Policies — Cost Optimization Engine

```
Lifecycle Transition Flow:

Object Created
      │
      ▼
Day 0 → S3 Standard (active, frequently accessed)
      │
      ▼
Day 30 → S3 Standard-IA (cost drops ~60%)
      │
      ▼
Day 60 → S3 Glacier Flexible Retrieval (cost drops ~80%)
      │
      ▼
Day 365 → S3 Glacier Deep Archive (cheapest tier)
      │
      ▼
Day 730 → Expire/Delete (object removed permanently)
```

**Architect Note:** Lifecycle policies can be applied to:
- Entire bucket
- Specific prefix (e.g., `logs/`)
- Objects with specific tags (e.g., `environment=dev`)
- Current version vs. noncurrent versions separately

---

## 4.6 S3 Cross-Region Replication (CRR) vs Same-Region Replication (SRR)

| Feature | CRR | SRR |
|---------|-----|-----|
| Source & destination | Different regions | Same region |
| Versioning required | ✅ Both buckets | ✅ Both buckets |
| Use case | DR, compliance, latency reduction | Log aggregation, dev/test copy |
| Replication scope | New objects only (existing need S3 Batch) | New objects only |
| Delete marker replication | Optional (not default) | Optional |
| IAM role | Required | Required |

```
CRR Architecture for DR:
    Primary Region (us-east-1)          DR Region (us-west-2)
    ┌─────────────────────┐             ┌─────────────────────┐
    │   Source Bucket      │──CRR──────→│  Destination Bucket  │
    │   (Production data)  │  async     │  (DR copy)           │
    └─────────────────────┘             └─────────────────────┘
    
    RTO/RPO: Near-zero data loss, fast recovery
```

---

## 4.7 S3 Security Architecture

**Layered Security Model:**
```
Layer 1: Block Public Access (Account + Bucket level)
         → Default: ALL public access blocked ✅

Layer 2: Bucket Policy (Resource-based policy)
         → JSON policy attached to bucket
         → Controls cross-account access

Layer 3: ACLs (Legacy — prefer policies)
         → Object-level permissions

Layer 4: IAM Policies (Identity-based)
         → User/Role permissions to S3

Layer 5: Encryption
         → SSE-S3 (AWS manages keys)
         → SSE-KMS (you manage keys via KMS)
         → SSE-C (you provide keys)
         → Client-side encryption

Layer 6: VPC Endpoints (S3 Gateway Endpoint)
         → Access S3 without traversing internet
         → Free, no data transfer charges
```

**Bucket Policy Example — Deny non-HTTPS:**
```json
{
  "Statement": [{
    "Effect": "Deny",
    "Principal": "*",
    "Action": "s3:*",
    "Resource": "arn:aws:s3:::my-bucket/*",
    "Condition": {
      "Bool": { "aws:SecureTransport": "false" }
    }
  }]
}
```

---

## 4.8 S3 Static Website Hosting Architecture

```
Static Website Architecture:

User → Route 53 (DNS) → CloudFront (CDN)
                              │
                              ▼
                        S3 Bucket
                    (Static files: index.html,
                     CSS, JS, images)
                         │
                    OAI restricts
                    direct S3 access
                    (only CloudFront can read)

Benefits:
✅ Serverless — no EC2 instances to manage
✅ Automatically scalable
✅ ~99.99% availability
✅ Global low-latency via CloudFront
✅ Extremely low cost ($1-2/month for most sites)
```

---

## 4.9 S3 Transfer Acceleration

**When to Use:**
- Uploading large files from geographically distant locations
- Users uploading to a central S3 bucket from multiple continents

**How it Works:**
```
User (Australia) → CloudFront Edge (Sydney) → AWS backbone → S3 (us-east-1)
                   ~1ms to edge                ~fast AWS      
VS
User (Australia) ──────────────────────────────────────────→ S3 (us-east-1)
                   ~200ms+ public internet
```

**Cost:** Additional data transfer charges apply (~$0.04-$0.08/GB extra)

---

## 4.10 S3 Object Lock (WORM)

**Use Case:** Regulatory compliance (SEC Rule 17a-4, HIPAA, FINRA)

```
WORM = Write Once, Read Many

Governance Mode:
  → Can be overridden by privileged IAM users
  → For internal compliance testing

Compliance Mode:
  → CANNOT be overridden by ANYONE (even root)
  → For strict regulatory requirements
  → True immutability

Legal Hold:
  → No expiration date
  → Protects object until explicitly removed
  → Used during litigation
```

---

## 4.11 S3 Performance Optimization

**Request Rate Limits:**
- 3,500 PUT/COPY/POST/DELETE requests/second/prefix
- 5,500 GET/HEAD requests/second/prefix

**Strategy for High-Throughput Applications:**
```
Instead of:
my-bucket/file-001.jpg   ← All requests hit same prefix
my-bucket/file-002.jpg

Use:
my-bucket/ab/file-001.jpg  ← Different prefixes = parallelism
my-bucket/cd/file-002.jpg
my-bucket/ef/file-003.jpg

With 10 prefixes: 55,000 GET/s capability
```

---

## 4.12 AWS Snowball Family — Large-Scale Data Transfer

| Service | Capacity | Use Case |
|---------|----------|----------|
| **Snowball Edge Storage** | 80TB | Single rack migration |
| **Snowball Edge Compute** | 80TB + EC2-equiv compute | Edge processing + transfer |
| **Snowmobile** | 100PB | Entire data center migration |

**When to Use Snowball vs. Direct Upload:**
```
1Gbps internet connection:
10TB → ~24 hours online → Use Direct Upload
100TB → ~10 days online → Consider Snowball
1PB → 100 days online → Use Snowball
100PB → 10,000 days online → Use Snowmobile
```

**Security:**
- All data encrypted with KMS automatically
- Tamper-resistant devices
- Device tracking via SNS/Console

---

# 5. EC2 — ELASTIC COMPUTE CLOUD

## 5.1 Core Concept

**Simple Explanation:**
EC2 is AWS's virtual computer service. You launch "instances" (virtual machines) with your chosen OS, CPU, RAM, and storage, just like renting a server but paying by the second.

---

## 5.2 EC2 Instance Type Families — Architect Selection Guide

```
Instance Type Naming Convention:
    m5.xlarge
    ││ └──── Size (nano, micro, small, medium, large, xlarge, 2xlarge...)
    │└────── Generation (5 = 5th gen, higher = newer/faster)
    └─────── Family (m = general purpose)
```

| Family | Type | CPU/Memory | Best For | Examples |
|--------|------|-----------|----------|---------|
| **M** | General Purpose | Balanced | Web servers, microservices, dev environments | m5.large, m6i.xlarge |
| **C** | Compute Optimized | High CPU | Batch processing, gaming, HPC, video encoding | c5.2xlarge, c6g.4xlarge |
| **R** | Memory Optimized | High RAM | In-memory databases, Redis, SAP HANA | r5.4xlarge, r6g.8xlarge |
| **I** | Storage Optimized | High I/O | NoSQL databases, data warehousing, Elasticsearch | i3.xlarge, i4i.2xlarge |
| **P/G** | GPU Compute | GPU | ML training, deep learning, graphics rendering | p3.2xlarge, g4dn.xlarge |
| **T** | Burstable | Credit-based CPU | Dev/test, low-traffic web apps, microservices | t3.micro, t3.medium |

**Architect Decision for Compute:**
```
Is workload steady or bursty?
  Bursty (dev/test, small web) → T-series (burstable, cost-effective)
  
Is memory the bottleneck?
  YES → R-series or X-series
  
Is CPU the bottleneck?
  YES → C-series
  
Need GPU?
  ML Training → P-series
  ML Inference → G-series
  
General web app → M-series (safe default)
```

---

## 5.3 EC2 Pricing Models — Cost Architecture

### On-Demand
```
✅ No commitment
✅ Pay per second (Linux) or per hour (Windows)
✅ Maximum flexibility
❌ Most expensive per-hour

Use: Unpredictable workloads, testing, short-term needs
```

### Reserved Instances (RI)
```
✅ Up to 75% discount vs On-Demand
✅ 1-year or 3-year commitment
✅ Three types:
   - Standard RI → deepest discount, no attribute changes
   - Convertible RI → can change instance family/OS (54% discount)
   - Scheduled RI → recurring time windows (fraction of day/week/month)

Payment options:
   All Upfront → Maximum discount
   Partial Upfront → Moderate discount
   No Upfront → Minimum discount but no capital

Use: Steady-state workloads (databases, always-on applications)
```

### Spot Instances
```
✅ Up to 90% discount vs On-Demand
❌ Can be terminated with 2-minute warning when AWS needs capacity

Best for:
- Batch data processing (Hadoop, Spark EMR)
- Stateless web workers
- CI/CD build agents
- ML model training (with checkpointing)
- Video transcoding

Architect Pattern - Spot Fleet:
  Mix On-Demand (baseline) + Spot (burst capacity)
  If Spot terminated → On-Demand absorbs traffic
```

### Savings Plans (Modern Alternative to RIs)
```
✅ Flexible — applies across EC2, Lambda, Fargate
✅ Commit to spend amount ($/hour) not specific instance type
✅ Two types:
   - Compute Savings Plan → most flexible (66% savings)
   - EC2 Instance Savings Plan → 72% savings, specific family/region

Architect Recommendation: Use Savings Plans over RIs for new workloads
```

---

## 5.4 Tenancy Models

| Model | Description | Cost | Use Case |
|-------|-------------|------|----------|
| **Shared** | Multi-tenant host (default) | Lowest | General workloads |
| **Dedicated Instance** | Single-tenant hardware, auto-placed | Higher | Software licensing, compliance |
| **Dedicated Host** | Specific physical server, you control placement | Highest | BYOL (Bring Your Own License), compliance audits |

---

## 5.5 EC2 Instance Launch — Architecture Configuration Deep Dive

**Step 3 Key Configurations — Architect Focus:**

```
Placement Groups:
┌─────────────────────────────────────────────────────────┐
│ Cluster Placement Group                                  │
│ → All instances in SAME rack/AZ                         │
│ → Ultra-low latency, high bandwidth (10Gbps+)           │
│ → Risk: rack failure = all instances down               │
│ → Use: HPC, Hadoop master-worker, tightly coupled apps  │
│                                                          │
│ Spread Placement Group                                   │
│ → Each instance on DIFFERENT hardware                   │
│ → Max 7 instances per AZ per group                      │
│ → Max fault isolation                                    │
│ → Use: Critical instances that must survive hardware failure│
│                                                          │
│ Partition Placement Group                               │
│ → Groups of instances on different partitions (racks)   │
│ → Max 7 partitions per AZ                               │
│ → Hundreds of instances total                           │
│ → Use: HDFS, HBase, Cassandra (distributed storage)     │
└─────────────────────────────────────────────────────────┘
```

---

## 5.6 AMI (Amazon Machine Images)

**What is an AMI?**
A template for creating EC2 instances. Contains OS, pre-installed software, and initial configuration.

```
AMI Components:
┌─────────────────────────────┐
│         AMI                  │
│ ┌───────────────────────┐   │
│ │ Root Volume Snapshot  │   │
│ │ (OS + Software)       │   │
│ └───────────────────────┘   │
│ ┌───────────────────────┐   │
│ │  Launch Permissions   │   │
│ │  (public/private/     │   │
│ │   specific accounts)  │   │
│ └───────────────────────┘   │
│ ┌───────────────────────┐   │
│ │  Block Device Mapping │   │
│ │  (EBS volumes to      │   │
│ │   attach at launch)   │   │
│ └───────────────────────┘   │
└─────────────────────────────┘
```

**AMI Types:**

| Source | Description | Use Case |
|--------|-------------|----------|
| AWS Published | Official OS images (Amazon Linux, Ubuntu, Windows) | General purpose |
| AWS Marketplace | Pre-configured 3rd party (WordPress, SAP, Palo Alto) | Commercial software |
| Community | User-contributed | Testing only (security risk) |
| Custom (Golden AMI) | Your organization's hardened, pre-configured image | Production standard |

**Golden AMI Strategy (Production Best Practice):**
```
Base AMI (Amazon Linux 2)
        │
        ▼
Install OS patches + security hardening
Install CloudWatch agent
Install SSM agent
Install common libraries
Configure logging
        │
        ▼
Create Custom AMI ("Golden AMI")
        │
        ▼
Launch template references Golden AMI
        │
        ▼
Auto Scaling Group uses Launch Template
        │
        ▼
All production instances are identical and compliant
```

---

## 5.7 EC2 User Data — Bootstrap Automation

**Simple Explanation:**
Scripts that run automatically when an instance launches for the first time.

**Linux Example (Web Server Bootstrap):**
```bash
#!/bin/bash
# Update OS
yum update -y

# Install Apache web server
yum install httpd -y

# Create index page
echo "<html><body>
<h1>Production Web Server</h1>
<p>Launched: $(date)</p>
<p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
</body></html>" > /var/www/html/index.html

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Install CloudWatch agent
yum install amazon-cloudwatch-agent -y

# Install SSM agent (for Systems Manager)
yum install amazon-ssm-agent -y
systemctl start amazon-ssm-agent
```

**Windows Example:**
```powershell
<powershell>
# Set timezone
tzutil /s "India Standard Time"

# Install IIS
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Create default page
"<html><body><h1>Windows IIS Server</h1></body></html>" | Out-File C:\inetpub\wwwroot\index.html
</powershell>
```

---

## 5.8 EC2 Instance Metadata Service (IMDS)

**Access from within EC2 instance:**
```bash
# Get all available metadata
curl http://169.254.169.254/latest/meta-data/

# Get specific values
curl http://169.254.169.254/latest/meta-data/instance-id
curl http://169.254.169.254/latest/meta-data/public-ipv4
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
curl http://169.254.169.254/latest/user-data/
```

**IMDSv2 (Recommended for Security):**
```bash
# Step 1: Get session token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Step 2: Use token for requests
curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/
```

**Why IMDSv2?** Prevents SSRF (Server-Side Request Forgery) attacks that could steal instance credentials.

---

## 5.9 Security Groups — Deep Architecture

**Security Group Properties:**

```
┌───────────────────────────────────────────────────────┐
│             SECURITY GROUP RULES                       │
│                                                        │
│  INBOUND (Ingress):                                   │
│  ┌──────┬──────────┬────────┬─────────────────────┐  │
│  │ Rule │ Protocol │  Port  │      Source          │  │
│  ├──────┼──────────┼────────┼─────────────────────┤  │
│  │  1   │   TCP    │   22   │ 203.0.113.0/24 (SSH)│  │
│  │  2   │   TCP    │   80   │ 0.0.0.0/0 (HTTP)    │  │
│  │  3   │   TCP    │  443   │ 0.0.0.0/0 (HTTPS)   │  │
│  │  4   │   TCP    │  3306  │ sg-0abc123 (DB-SG)  │  │
│  └──────┴──────────┴────────┴─────────────────────┘  │
│                                                        │
│  OUTBOUND (Egress):                                   │
│  ┌──────┬──────────┬────────┬─────────────────────┐  │
│  │  1   │  All     │  All   │ 0.0.0.0/0 (default) │  │
│  └──────┴──────────┴────────┴─────────────────────┘  │
└───────────────────────────────────────────────────────┘
```

**Critical Security Group Rules:**

| Rule | Purpose | Security Note |
|------|---------|---------------|
| Allow `22` from `0.0.0.0/0` | SSH from anywhere | ❌ DANGEROUS — restrict to your IP |
| Allow `22` from `10.0.0.0/8` | SSH from VPC only | ✅ Better |
| Allow `22` from Bastion SG | SSH via jump host | ✅ Best practice |
| Allow `3306` from App-SG | DB from App tier only | ✅ Security Group chaining |
| Allow `443` from `0.0.0.0/0` | Public HTTPS | ✅ Normal for public web |

**Security Group Key Behaviors:**
- **Stateful** — if you allow inbound port 80, response is automatically allowed outbound
- **Allow-only** — you cannot create explicit DENY rules (use NACL for denies)
- Changes take effect immediately (no instance restart needed)
- Can reference other Security Groups as sources (preferred over IP ranges)

---

# 6. EBS — ELASTIC BLOCK STORE & SNAPSHOTS

## 6.1 Core Concept

**Simple Explanation:**
EBS is a virtual hard drive that attaches to EC2 instances. Unlike EC2's temporary local storage (instance store), EBS data persists even after instance stop/termination.

---

## 6.2 EBS Volume Types — Architect Decision Guide

```
┌───────────────────────────────────────────────────────────────────┐
│                    EBS VOLUME SELECTION GUIDE                      │
│                                                                     │
│  SSD-Based (IOPS-optimized):                                       │
│  ┌────────────────────────────────────────────────────────────┐   │
│  │ gp3 (General Purpose SSD v3)                               │   │
│  │ → 1 GiB–16 TiB                                            │   │
│  │ → 3,000 IOPS baseline (free), burst to 16,000             │   │
│  │ → 125 MB/s throughput (free), up to 1,000 MB/s           │   │
│  │ → 20% cheaper than gp2                                    │   │
│  │ → ✅ DEFAULT CHOICE for most workloads                    │   │
│  └───────────────────────────��────────────────────────────────┘   │
│  ┌────────────────────────────────────────────────────────────┐   │
│  │ io2 Block Express (Provisioned IOPS SSD)                   │   │
│  │ → Up to 256,000 IOPS                                       │   │
│  │ → 99.999% durability (vs 99.9% for gp2/gp3)              │   │
│  │ → For critical databases: Oracle, SAP HANA, SQL Server    │   │
│  │ → Most expensive SSD type                                  │   │
│  └────────────────────────────────────────────────────────────┘   │
│                                                                     │
│  HDD-Based (Throughput-optimized):                                 │
│  ┌────────────────────────────────────────────────────────────┐   │
│  │ st1 (Throughput Optimized HDD)                             │   │
│  │ → 125 GiB–16 TiB                                          │   │
│  │ → 40 MB/s/TiB baseline, burst to 250 MB/s/TiB            │   │
│  │ → NOT bootable                                             │   │
│  │ → For: Big data, data warehouses, log processing          │   │
│  └────────────────────────────────────────────────────────────┘   │
│  ┌────────────────────────────────────────────────────────────┐   │
│  │ sc1 (Cold HDD)                                             │   │
│  │ → 12 MB/s/TiB baseline                                    │   │
│  │ → Cheapest EBS type                                        │   │
│  │ → For infrequently accessed sequential data               │   │
│  └────────────────────────────────────────────────────────────┘   │
└───────────────────────────────────────────────────────────────────┘
```

---

## 6.3 EBS Snapshots Architecture

```
EBS Snapshot Flow:

EBS Volume (AZ: us-east-1a)
        │
        ▼ (incremental backup)
S3 (AWS-managed, not in your account's buckets)
        │
        ├── Copy Snapshot → Different Region (DR)
        │
        ├── Create Volume → Same or Different AZ
        │                    (volume type/size can change)
        │
        └── Create AMI → Launch new instances

Incremental Snapshot:
Snapshot 1: Full backup (100 GB)
Snapshot 2: Only changed blocks (5 GB changed → 5 GB stored)
Snapshot 3: Only changed since Snap 2 (2 GB changed → 2 GB stored)
→ Cost-efficient, much faster than full backups
```

**Snapshot Encryption Rules:**
```
Encrypted Volume → Snapshot is Encrypted
Unencrypted Volume → Snapshot is Unencrypted

Encrypted Snapshot → Volume created from it is Encrypted
Unencrypted Snapshot → Can enable encryption during volume creation

Sharing: You can share UNENCRYPTED snapshots only
         Encrypted snapshots can be shared if you share the KMS key
```

---

## 6.4 Amazon Data Lifecycle Manager (DLM)

**Purpose:** Automate EBS snapshot creation, retention, and deletion.

```
DLM Policy Example:

Target: All volumes with Tag "Backup=Daily"
Schedule: Every 24 hours at 09:00 UTC
Retain: Last 7 snapshots
Cross-region copy: us-east-1 → us-west-2 (DR)
Cross-account share: Send to backup account 123456789012

Result: Fully automated backup lifecycle with no manual intervention
```

---

## 6.5 Instance Store vs EBS Comparison

| Feature | Instance Store | EBS |
|---------|---------------|-----|
| Persistence | ❌ Lost on stop/terminate | ✅ Persists independently |
| Latency | Ultra-low (physically attached) | Low (network-attached) |
| Snapshots | ❌ Not possible | ✅ Incremental snapshots |
| Encryption | Instance-level only | ✅ KMS encryption |
| Cost | Included in instance price | Additional cost |
| Use Case | Caches, buffers, temp files | Databases, OS drives, persistent data |

---

# 7. ELB — ELASTIC LOAD BALANCING

## 7.1 Core Concept

**Simple Explanation:**
A Load Balancer distributes incoming application traffic across multiple EC2 instances, containers, or IP addresses to ensure no single server is overwhelmed.

---

## 7.2 Four Load Balancer Types — Complete Architect Guide

```
┌─────────────────────────────────────────────────────────────────────┐
│                    LOAD BALANCER DECISION MATRIX                     │
│                                                                       │
│  What protocol are you load balancing?                               │
│                                                                       │
│  HTTP/HTTPS (Layer 7 routing based on content)                       │
│  └──→ Application Load Balancer (ALB)                               │
│       Best for: Web apps, microservices, REST APIs                   │
│       Features: URL-based routing, host-based routing,               │
│                 gRPC, WebSocket, Lambda targets, authentication      │
│                                                                       │
��  TCP/UDP/TLS (Layer 4 — extreme performance)                        │
│  └──→ Network Load Balancer (NLB)                                   │
│       Best for: Gaming, IoT, real-time streaming, private link       │
│       Features: Millions of req/sec, static IP, PrivateLink support  │
│                                                                       │
│  Third-party appliances (Firewalls, IDS/IPS, deep packet inspection) │
│  └──→ Gateway Load Balancer (GWLB)                                  │
│       Best for: Security appliances (Palo Alto, CheckPoint, Fortinet)│
│       Features: GENEVE protocol, transparent bump-in-the-wire        │
│                                                                       │
│  Legacy HTTP/TCP (not recommended for new deployments)               │
│  └──→ Classic Load Balancer (CLB)                                   │
│       Old-generation; migrate to ALB/NLB                             │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 7.3 ALB Deep Dive — Most Common Production Choice

**ALB Request Routing Flow:**
```
Client Request: GET /api/users/profile
                Host: api.myapp.com
                        │
                        ▼
                   ALB Listener (Port 443)
                        │
                  Rule Evaluation (in priority order):
                        │
                  Rule 1: IF path = /api/* → Forward to API Target Group
                  Rule 2: IF path = /static/* → Forward to CDN Target Group
                  Rule 3: IF host = admin.myapp.com → Forward to Admin TG
                  Rule 4: Default → Forward to Web Target Group
                        │
                        ▼
              API Target Group (Round-Robin)
              ┌──────────────────────────────┐
              │  EC2-1  EC2-2  EC2-3  EC2-4  │
              │  (Auto Scaling Group members) │
              └──────────────────────────────┘
```

**ALB Target Types:**
- **Instance** → EC2 instances
- **IP** → Private IPs (containers, on-premises)
- **Lambda** → Serverless functions
- **ALB** → Another ALB (for weighted routing)

**ALB Health Checks:**
```
Health Check Config:
Protocol: HTTP
Path: /health
Port: 80
Healthy threshold: 2 consecutive successes
Unhealthy threshold: 3 consecutive failures
Timeout: 5 seconds
Interval: 30 seconds
Success codes: 200-299

Your /health endpoint should:
✅ Return 200 when app is ready
✅ Check DB connectivity
✅ Check downstream dependencies
✅ Return 503 when app is not ready (graceful degradation)
```

---

## 7.4 ALB vs NLB Decision Table

| Feature | ALB | NLB |
|---------|-----|-----|
| OSI Layer | 7 (Application) | 4 (Transport) |
| Protocols | HTTP, HTTPS, WebSocket, gRPC | TCP, UDP, TLS |
| Performance | High | Extreme (millions/sec) |
| Static IP | ❌ | ✅ (per AZ) |
| SSL Termination | ✅ | ✅ |
| Path-based routing | ✅ | ❌ |
| Host-based routing | ✅ | ❌ |
| Lambda targets | ✅ | ❌ |
| PrivateLink | ❌ | ✅ |
| Price | Higher | Similar |

---

## 7.5 High-Availability Load Balancer Architecture

```
Production Multi-AZ ALB Architecture:

         Internet
            │
            ▼
    Route 53 (DNS)
            │
            ▼
    ALB (Internet-facing)
    ┌────────────────────────────────┐
    │ AZ-1a subnet  │ AZ-1b subnet  │
    │ ALB Node      │ ALB Node       │
    └───────┬───────┴───────┬────────┘
            │               │
    ┌───────▼───────┐ ┌─────▼───────────┐
    │  Web Tier     │ │  Web Tier        │
    │  EC2 in AZ-1a │ │  EC2 in AZ-1b   │
    └───────┬───────┘ └─────┬───────────┘
            │               │
    ┌───────▼───────────────▼────────────┐
    │     Internal ALB (App Tier)         │
    └───────┬───────────────┬────────────┘
            │               │
    ┌───────▼──────┐ ┌──────▼───────────┐
    │  App Tier    │ │  App Tier         │
    │  EC2 in 1a   │ │  EC2 in 1b       │
    └───────┬──────┘ └──────┬───────────┘
            │               │
    ┌───────▼───────────────▼────────────┐
    │    RDS Multi-AZ (Primary + Replica) │
    └────────────────────────────────────┘
```

---

# 8. AUTO SCALING GROUPS

## 8.1 Core Concept

**Simple Explanation:**
Auto Scaling automatically adds or removes EC2 instances based on demand. Think of it as a smart manager who hires more staff when the shop gets busy and lets them go when it's quiet.

---

## 8.2 ASG Architecture Components

```
Auto Scaling Group Anatomy:

┌─────────────────────────────────────────────────────────┐
│              AUTO SCALING GROUP                          │
│                                                          │
│  Launch Template / Launch Configuration                  │
│  (The "blueprint" for new instances)                    │
│  → AMI ID                                               │
│  → Instance type                                        │
│  → Key pair                                             │
│  → Security groups                                       │
│  → User data script                                     │
│  → IAM role                                             │
│  → EBS volume configuration                             │
│                                                          │
│  Scaling Configuration:                                  │
│  → Minimum: 2 (always running, HA)                      │
│  → Desired: 4 (current target)                          │
│  → Maximum: 20 (cost ceiling)                           │
│                                                          │
│  Network:                                                │
│  → VPC + Subnets (span multiple AZs for HA)            │
│  → ALB Target Group attachment                          │
│                                                          │
│  Health Checks:                                          │
│  → EC2 health check (default)                          │
│  → ELB health check (recommended for web apps)         │
│  → Custom health check via API                          │
└─────────────────────────────────────────────────────────┘
```

---

## 8.3 Scaling Policy Types

### Target Tracking (Recommended)
```
Goal: "Keep CPU at 50%"
ASG automatically calculates how many instances to add/remove

Example:
Current CPU: 80% with 4 instances
Target: 50%
ASG math: Need ~6-7 instances to bring avg CPU to 50%
Action: Launches 2-3 new instances

Current CPU: 20% with 4 instances
ASG math: 2 instances could handle this load at ~40% CPU
Action: Terminates 2 instances after cooldown
```

### Step Scaling
```
"Add instances in steps based on alarm threshold breach size"

CPU > 70% → Add 1 instance
CPU > 85% → Add 3 instances
CPU > 95% → Add 5 instances

CPU < 40% → Remove 1 instance
CPU < 20% → Remove 3 instances
```

### Scheduled Scaling
```
"Scale on a predictable schedule"

cron(0 8 * * MON-FRI) → Scale to 10 instances (business hours start)
cron(0 18 * * MON-FRI) → Scale to 2 instances (business hours end)
cron(0 0 1 * *) → Scale to 20 instances (month-end batch processing)
```

---

## 8.4 ASG Termination Policy (Default Logic)

```
When ASG needs to terminate an instance:

Step 1: Find AZ with most instances → Select that AZ
Step 2: Find instance using oldest Launch Configuration/Template
Step 3: If multiple oldest → find closest to next billing hour
Step 4: If still tied → random selection

Why this matters:
→ Ensures AZ balance (HA maintained)
→ Removes outdated configurations first (rolling updates)
→ Minimizes billing waste
```

---

## 8.5 ASG Cooldown Period

```
Cooldown: Default 300 seconds (5 minutes)
Purpose: Prevents rapid scaling oscillation

Without cooldown:
CPU spikes → Add 3 instances → CPU drops → Remove 3 instances → CPU spikes → loop

With cooldown:
CPU spikes → Add 3 instances → Wait 300 seconds → Evaluate again → stable
```

**Production Tip:** For faster-starting instances (containers, Lambda-backed), reduce cooldown to 60-90 seconds for more responsive scaling.

---

## 8.6 Instance Lifecycle Hooks

```
Launch Lifecycle Hook:
  EC2 Launch Triggered
       │
       ▼
  Wait State (max 2 hours)
  → Run custom script
  → Install software
  → Fetch configuration
  → Run integration tests
  → Register with service discovery
       │
       ▼
  CONTINUE → Instance enters InService
  ABANDON → Instance terminated (bad instance)

Termination Lifecycle Hook:
  EC2 Termination Triggered
       │
       ▼
  Wait State
  → Deregister from service discovery
  → Drain active connections
  → Copy logs to S3
  → Send "goodbye" notification to other services
       │
       ▼
  CONTINUE → Instance terminates
```

---

# 9. CLOUDWATCH — MONITORING & OBSERVABILITY

## 9.1 Core Concept

**Simple Explanation:**
CloudWatch is AWS's operations monitoring platform. It collects metrics, logs, and events from your AWS services and applications, allowing you to visualize performance and set automated alarms.

---

## 9.2 CloudWatch Architecture Layers

```
┌──────────────────────────────────────────────────────────────────┐
│                    CLOUDWATCH OBSERVABILITY STACK                 │
│                                                                    │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │ METRICS (Numbers over time)                              │    │
│  │ → EC2: CPU, Network, Disk                               │    │
│  │ → RDS: Connections, Read/Write IOPS                     │    │
│  │ → ALB: Request count, 5xx errors, latency              │    │
│  │ → Custom: Application metrics via PutMetricData API     │    │
│  └─────────────────────────────────────────────────────────┘    │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │ LOGS (Text records)                                      │    │
│  │ → EC2 application logs (via CloudWatch agent)           │    │
│  │ → Lambda function logs (automatic)                      │    │
│  │ → VPC Flow Logs                                         │    │
│  │ → CloudTrail audit logs                                 │    │
│  │ → Route 53 query logs                                   │    │
│  └─────────────────────────────────────────────────────────┘    │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │ ALARMS (Automated responses)                             │    │
│  │ → SNS notification (email/SMS/PagerDuty)                │    │
│  │ → Auto Scaling action (scale in/out)                    │    │
│  │ → EC2 action (stop/terminate/recover instance)          │    │
│  │ → Systems Manager OpsItem creation                      │    │
│  └─────────────────────────────────────────────────────────┘    │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │ DASHBOARDS (Visual monitoring)                           │    │
│  │ → Custom dashboards per application/team                │    │
│  │ → Cross-account, cross-region visibility                │    │
│  └─────────────────────────────────────────────────────────┘    │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │ EVENTS / EVENTBRIDGE (React to AWS changes)             │    │
│  │ → EC2 state change → trigger Lambda                     │    │
│  │ → CodePipeline failure → send Slack notification        │    │
│  │ → Scheduled cron → trigger Lambda                       │    │
│  └─────────────────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────────────────┘
```

---

## 9.3 Monitoring Levels

| Level | Frequency | Cost | Use Case |
|-------|-----------|------|----------|
| **Basic** | 5 minutes | Free | Default for EC2 |
| **Detailed** | 1 minute | Paid | Production monitoring, faster alarm response |
| **High-Resolution** | 1 second | Higher | Real-time trading, gaming |

---

## 9.4 CloudWatch Agent — Critical for Production

**Why needed:** Default EC2 metrics don't include OS-level metrics like:
- Memory utilization
- Disk space usage
- Process-level CPU
- Network connections

**Install and configure:**
```bash
# Install
sudo yum install amazon-cloudwatch-agent -y

# Configure (wizard)
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard

# Start
sudo systemctl start amazon-cloudwatch-agent
sudo systemctl enable amazon-cloudwatch-agent
```

---

## 9.5 Alarm States and Actions

```
Alarm States:
┌─────────┐
│   OK    │ → Metric within threshold
└─────────┘
┌─────────┐
│  ALARM  │ → Metric breached threshold
└─────────┘
┌──────────────────────┐
│  INSUFFICIENT_DATA   │ → Not enough data to evaluate
└──────────────────────┘

Alarm Actions:
State = ALARM → SNS notification → email/SMS to on-call engineer
State = ALARM → ASG Scale Out → add capacity
State = OK    → SNS notification → "issue resolved" alert
```

---

## 9.6 Centralized Logging Architecture

```
Production Centralized Logging:

EC2 Applications ──→ CloudWatch Agent ──→ CloudWatch Log Groups
Lambda Functions ──────────────────────→ CloudWatch Log Groups
ECS Tasks ─────────────────────────────→ CloudWatch Log Groups
                                               │
                              ┌────────────────┼──────────────────┐
                              ▼                ▼                  ▼
                         CloudWatch     Log Insights          Kinesis
                         Metrics        (query logs)          Data Firehose
                              │                                    │
                              ▼                                    ▼
                          Alarms                         S3 (long-term storage)
                                                         OpenSearch (analytics)
                                                         Splunk/Datadog
```

---

# 10. EFS — ELASTIC FILE SYSTEM

## 10.1 Core Concept

**Simple Explanation:**
EFS is a shared network file system (like a shared drive) that multiple EC2 instances can mount simultaneously. Unlike EBS (attached to one instance), EFS can be shared across hundreds of instances.

---

## 10.2 EFS Architecture

```
EFS Shared File System Architecture:

    ┌──────────────────────────────────────────┐
    │              EFS File System              │
    │  (Automatically scales: 0 bytes to PBs)  │
    └────────┬───────────────────┬───────────��─┘
             │ NFS v4.1          │ NFS v4.1
             │                   │
    ┌────────▼──────┐   ┌────────▼──────┐
    │  EC2 (AZ-1a)  │   │  EC2 (AZ-1b)  │
    │  /mnt/efs     │   │  /mnt/efs     │
    │  (reads same  │   │  (reads same  │
    │   files)      │   │   files)      │
    └───────────────┘   └───────────────┘

Use Cases:
→ CMS (WordPress media shared across web servers)
→ Machine learning training data
→ Container persistent shared storage
→ Code deployment across fleet
```

**EFS vs EBS vs S3:**

| Feature | EFS | EBS | S3 |
|---------|-----|-----|-----|
| Access | Multiple instances simultaneously | One instance at a time (except Multi-Attach io1/io2) | Any client via HTTP |
| Protocol | NFS | Block device | REST API / SDK |
| OS integration | ✅ Native mount | ✅ Native mount | ❌ Application-level only |
| Scaling | Automatic (petabyte-scale) | Manual (up to 16TB) | Unlimited automatic |
| Windows | ❌ (Linux only) | ✅ | ✅ |
| Cost | Per GB/month (higher than EBS) | Per GB provisioned | Per GB stored (cheapest) |

---

## 10.3 EFS Storage Classes

| Class | Availability | Cost | Use |
|-------|-------------|------|-----|
| **EFS Standard** | Multi-AZ | Higher | Frequently accessed |
| **EFS Standard-IA** | Multi-AZ | 85% lower | Infrequent access |
| **EFS One Zone** | Single AZ | 47% lower than Standard | Dev/test |
| **EFS One Zone-IA** | Single AZ | 91% lower than Standard | Dev/test infrequent |

**Lifecycle Management:** Automatically moves files to IA tier after 7/14/30/60/90 days of no access.

---

# 11. ROUTE 53 — DNS SERVICE

## 11.1 Core Concept

**Simple Explanation:**
Route 53 is AWS's DNS (Domain Name System) service. It translates human-readable domain names (www.myapp.com) into IP addresses that computers use to connect.

---

## 11.2 DNS Resolution Flow

```
User types: www.myapp.com
        │
        ▼
Browser checks local DNS cache → Not found
        │
        ▼
ISP Resolver queries Root DNS Servers
→ Root servers say: ".com TLD server knows about .com domains"
        │
        ▼
ISP Resolver queries .com TLD Servers
→ TLD says: "Route 53 name servers handle myapp.com"
        │
        ▼
ISP Resolver queries Route 53 Name Servers
→ Route 53 returns: A record → 54.204.x.x (ALB or EC2 IP)
        │
        ▼
Browser connects to 54.204.x.x
→ Website loads!

TTL (Time to Live): How long DNS result is cached
→ Short TTL (60s): Fast failover, but more DNS queries (higher cost)
→ Long TTL (300s+): Fewer queries, slower propagation during changes
```

---

## 11.3 Route 53 Record Types Reference

| Record Type | Purpose | Example |
|-------------|---------|---------|
| **A** | Domain → IPv4 address | `www` → `54.204.1.1` |
| **AAAA** | Domain → IPv6 address | `www` → `2001:db8::1` |
| **CNAME** | Domain → Another domain | `www` → `myapp.elb.amazonaws.com` (cannot be root domain) |
| **Alias** | AWS-specific → AWS resource | `myapp.com` → `myapp.elb.amazonaws.com` ✅ (can be root) |
| **MX** | Mail server records | `myapp.com` → `mail.myapp.com` priority 10 |
| **TXT** | Text records | Domain verification, SPF, DKIM |
| **NS** | Name server records | Points to Route 53 name servers |
| **SOA** | Start of Authority | Zone metadata |
| **PTR** | Reverse DNS (IP → domain) | `54.204.1.1` → `www.myapp.com` |
| **SRV** | Service location | `_sip._tcp.myapp.com` → SIP server |

**CNAME vs Alias — Critical Difference:**
```
CNAME: Cannot be used for root domain (myapp.com)
       Only for subdomains (www.myapp.com)
       Points to ANY domain name
       NOT free (charged per query)

Alias: Works for root domain (myapp.com) AND subdomains
       Only points to AWS resources (ALB, CloudFront, S3, etc.)
       FREE (no per-query charge for AWS resources)
       ✅ Always prefer Alias for AWS resources
```

---

## 11.4 Routing Policies — Complete Architect Guide

### Simple Routing
```
Use: Single resource serving a domain
Traffic → Route 53 → returns single IP
Limitation: No health checks, no failover
When: Small websites with one server
```

### Weighted Routing
```
Use: A/B testing, gradual deployments, multi-region distribution

Record: myapp.com Weight=80 → us-east-1 ALB
Record: myapp.com Weight=20 → us-west-2 ALB

Result: 80% traffic to east, 20% to west
Real-world: 
→ Launch new version with Weight=5 (5% canary)
→ Monitor errors
→ If good, gradually increase weight to 100%
```

### Latency-Based Routing
```
Use: Route users to lowest-latency AWS region

User in Mumbai → Measured latency:
  ap-south-1: 10ms
  us-east-1: 250ms
  eu-west-1: 180ms
→ Route to ap-south-1

User in London → Measured latency:
  ap-south-1: 180ms
  us-east-1: 90ms
  eu-west-1: 15ms
→ Route to eu-west-1
```

### Failover Routing
```
Use: Active-Passive disaster recovery

Primary: us-east-1 ALB (Active)
  → Health check every 30 seconds
  → If 3 consecutive failures → mark UNHEALTHY
  
Secondary: us-west-2 ALB (Passive/DR)
  → Only receives traffic when primary is UNHEALTHY

Failover happens automatically:
Primary health check fails → Route 53 updates DNS → traffic to Secondary
→ RTO: ~30-60 seconds (TTL dependent)
```

### Geolocation Routing
```
Use: Legal compliance, localization, content targeting

Rule: Users from "United Kingdom" → UK servers
Rule: Users from "Europe" → EU servers
Rule: Users from "India" → Mumbai servers
Rule: Default → us-east-1 (catch-all)

Use cases:
→ GDPR: European users must hit EU servers
→ Language: Japanese users → Japanese content server
→ Pricing: Different regional pricing
```

### Geoproximity Routing (Traffic Flow)
```
Like Geolocation but with "bias" — expand or shrink region boundaries

Normal: India served by ap-south-1
With +50 bias on ap-south-1: Also captures some Middle East traffic

Use for: Gradually shifting traffic between regions
```

### Multivalue Answer
```
Use: Simple load balancing with health checks (not full ELB)

Returns: Up to 8 healthy IP addresses
Client: Picks one randomly
With health checks: Unhealthy IPs removed from response

Not a replacement for ELB — no sticky sessions, no SSL termination
Use for: Simple microservices, UDP services
```

---

## 11.5 Route 53 Health Checks

```
Health Check Types:
1. Endpoint monitoring
   → HTTP/HTTPS/TCP check to IP or domain
   → Configurable path, port, interval, failure threshold

2. Calculated health checks
   → Combine multiple health checks with AND/OR logic
   → "Healthy if at least 2 of 3 checks pass"

3. CloudWatch alarm-based
   → Health = OK only if CloudWatch alarm is OK
   → Most flexible — can check any metric

Health Checker Locations:
→ 15+ global health checker locations
→ 18% of checkers must report healthy = considered healthy
→ Low TTL + health checks = fast automated failover
```

---

# 12. VPC — VIRTUAL PRIVATE CLOUD

## 12.1 Core Concept

**Simple Explanation:**
A VPC is your private, isolated section of the AWS cloud. Think of it as your own private data center inside AWS where you control the network topology, IP addressing, routing, and security.

---

## 12.2 VPC Architecture Components — Complete Map

```
┌────────────────────────────────────────────────────────────────────┐
│                     VPC (10.0.0.0/16)                              │
│                     Region: us-east-1                               │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐  │
│  │                    AZ: us-east-1a                            │  │
│  │                                                               │  │
│  │  ┌────────────────────────┐  ┌────────────────────────────┐ │  │
│  │  │   Public Subnet         │  │   Private Subnet           │ │  │
│  │  │   10.0.1.0/24          │  │   10.0.3.0/24              │ │  │
│  │  │                         │  │                             │ │  │
│  │  │  ┌──────────────────┐  │  │  ┌──────────────────────┐  │ │  │
│  │  │  │  Bastion Host    │  │  │  │  App Server           │  │ │  │
│  │  │  │  (SSH gateway)   │  │  │  │  (Private IP only)   │  │ │  │
│  │  │  └──────────────────┘  │  │  └──────────────────────┘  │ │  │
│  │  │  ┌──────────────────┐  │  │  ┌──────────────────────┐  │ │  │
│  │  │  │  NAT Gateway     │  │  │  │  RDS Database         │  │ │  │
│  │  │  │  (Elastic IP)    │  │  │  │  (Private IP only)   │  │ │  │
│  │  │  └──────────────────┘  │  │  └──────────────────────┘  │ │  │
│  │  └────────────────────────┘  └────────────────────────────┘ │  │
│  └─────────────────────────────────────────────────────────────┘  │
│                                                                      │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  Route Tables                                                  │  │
│  │  Public RT: 0.0.0.0/0 → Internet Gateway                     │  │
│  │  Private RT: 0.0.0.0/0 → NAT Gateway                         │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                      │
│  ┌────────────────────┐    ┌──────────────────────────────────┐    │
│  │  Internet Gateway  │    │  NACL (Subnet-level firewall)     │    │
│  │  (IGW) attached    │    │  Security Groups (Instance-level) │    │
│  └────────────────────┘    └──────────────────────────────────┘    │
└────────────────────────────────────────────────────────────────────┘
```

---

## 12.3 CIDR Planning — Production IP Strategy

```
VPC CIDR Planning Best Practices:

Single Region, Single VPC:
VPC: 10.0.0.0/16 (65,534 IPs)

Subnet Design (per AZ):
Public:   10.0.1.0/24 (254 IPs) - AZ-1a
Public:   10.0.2.0/24 (254 IPs) - AZ-1b
Private:  10.0.11.0/24 (254 IPs) - AZ-1a (App tier)
Private:  10.0.12.0/24 (254 IPs) - AZ-1b (App tier)
Database: 10.0.21.0/24 (254 IPs) - AZ-1a (DB tier)
Database: 10.0.22.0/24 (254 IPs) - AZ-1b (DB tier)

Multi-Account Design (AWS Organizations):
Production: 10.0.0.0/16
Staging:    10.1.0.0/16
Dev:        10.2.0.0/16
Shared:     10.3.0.0/16

No overlapping CIDRs = VPC Peering / Transit Gateway works
```

**Reserved IPs per Subnet:**
AWS reserves 5 IPs per subnet:
```
10.0.1.0   → Network address
10.0.1.1   → AWS VPC Router
10.0.1.2   → AWS DNS server
10.0.1.3   → AWS reserved (future use)
10.0.1.255 → Broadcast address
```
A /24 subnet gives 251 usable IPs (256 - 5 = 251)

---

## 12.4 Internet Gateway vs NAT Gateway

```
INTERNET GATEWAY (IGW):
→ Attached to VPC (1 IGW per VPC)
→ Makes subnets PUBLIC
→ Allows BIDIRECTIONAL internet traffic
→ Highly available, no bandwidth limits
→ Free (pay for data transfer only)

Direction: Internet → EC2 ✅ (inbound allowed)
           EC2 → Internet ✅ (outbound allowed)

NAT GATEWAY:
→ Deployed in PUBLIC subnet
→ Enables PRIVATE subnet outbound internet
→ PREVENTS inbound internet connections to private instances
→ Highly available (deploy one per AZ for HA)
→ Charged per hour + per GB processed

Direction: Internet → Private EC2 ❌ (blocked)
           Private EC2 → Internet ✅ (via NAT)

Example: Private EC2 running "yum update" → goes through NAT Gateway
→ Request: Private EC2 → NAT Gateway → IGW → Internet
→ Response: Internet → IGW → NAT Gateway → Private EC2
```

**NAT Gateway HA Pattern:**
```
❌ Cost-saving but RISKY:
One NAT Gateway in AZ-1a
Private subnets in AZ-1a AND AZ-1b both route through AZ-1a NAT
→ If AZ-1a fails → private instances in AZ-1b lose internet

✅ High Availability (Recommended Production):
NAT Gateway in AZ-1a → used by private subnet in AZ-1a
NAT Gateway in AZ-1b → used by private subnet in AZ-1b
→ If AZ-1a fails → AZ-1b NAT unaffected
```

---

## 12.5 Security Groups vs NACLs — Critical Comparison

```
┌────────────────────────────────────────────────────────────────────┐
│                  SECURITY GROUPS vs NACLs                          │
│                                                                      │
│  SECURITY GROUPS (Instance Level)                                   │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  • Applied to: EC2 instance ENI                              │  │
│  │  • Rules: Allow only (no deny)                               │  │
│  │  • Stateful: Return traffic auto-allowed                     │  │
│  │  • Evaluation: ALL rules evaluated before decision           │  │
│  │  • Reference: Can reference other SGs                        │  │
│  │  • Best for: Instance-level micro-segmentation               │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                      │
│  NETWORK ACLs (Subnet Level)                                        │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │  • Applied to: Entire subnet                                  │  │
│  │  • Rules: Allow AND Deny                                     │  │
│  │  • Stateless: MUST explicitly allow return traffic           │  │
│  │  • Evaluation: Rules processed in NUMBER ORDER (lowest first)│  │
│  │  • Best for: Subnet-level blocking (DDoS IP blocking)        │  │
│  │  • Default: Allows all in/out (default NACL)                │  │
│  └──────────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────────┘
```

**NACL Rule Order Example:**
```
Inbound NACL Rules:
Rule 100: Allow TCP port 443 from 0.0.0.0/0 → ALLOW
Rule 200: Allow TCP port 80 from 0.0.0.0/0  → ALLOW
Rule 110: DENY all from 192.168.1.100/32    → DENY specific attacker IP
Rule *  : DENY all (default)

Important: Rule 100 is evaluated BEFORE Rule 110
If you want to block 192.168.1.100, put DENY rule BEFORE the ALLOW rule:
Rule 50:  DENY from 192.168.1.100/32  ← must be lower number
Rule 100: ALLOW port 443 from 0.0.0.0/0
```

---

## 12.6 VPC Peering

```
VPC Peering Architecture:

VPC-A (10.0.0.0/16) ←──Peering──→ VPC-B (10.1.0.0/16)
                                          │
                                    Peering (separate)
                                          │
                                   VPC-C (10.2.0.0/16)

⚠️  NO TRANSITIVE PEERING!
A can talk to B ✅
B can talk to C ✅
A CANNOT talk to C via B ❌ (must create direct A↔C peering)

Limitations:
→ No overlapping CIDRs
→ Same region (inter-region peering now supported but higher cost)
→ No edge-to-edge routing (no internet, VPN, Direct Connect transiting)

For many VPCs: Use Transit Gateway instead of n*(n-1)/2 peerings
10 VPCs = 45 peering connections needed
10 VPCs + TGW = 10 attachments (simpler, hub-and-spoke)
```

---

## 12.7 VPC Endpoints — Keep Traffic Off Internet

```
Gateway Endpoint (S3 and DynamoDB — Free):
  Private EC2 → VPC Endpoint → S3 bucket
  Traffic NEVER leaves AWS network
  No NAT Gateway needed
  Free!

Interface Endpoint (PrivateLink — 100+ services):
  Private EC2 → ENI in subnet → AWS service (SQS, SNS, Secrets Manager...)
  Uses private IP addresses
  Works with Direct Connect, VPN
  Cost: $0.01/hour + $0.01/GB

Why VPC Endpoints?
→ Security: Traffic never traverses internet
→ Cost: Avoid NAT Gateway data transfer costs ($0.045/GB vs free via endpoint)
→ Compliance: Keep data on AWS backbone
```

---

## 12.8 Bastion Host Architecture

```
Secure SSH Access Pattern:

Developer Laptop
      │
      │ SSH (port 22)
      ▼
Bastion Host (Public Subnet)
  • Small instance (t3.micro)
  • Security Group: Allow SSH from corporate IP only
  • Only purpose: SSH jump server
      │
      │ SSH (port 22) — internal VPC traffic only
      ▼
Private EC2 Instance (Private Subnet)
  • Security Group: Allow SSH from Bastion SG ONLY

SSH Command:
ssh -A -i key.pem ec2-user@bastion-public-ip  # Connect to bastion
ssh ec2-user@private-instance-ip              # From bastion to private instance

Modern Alternative: AWS Systems Manager Session Manager
→ No Bastion Host needed
→ No SSH port open
→ Full audit trail in CloudTrail
→ Works through SSM agent
→ ✅ Preferred for production
```

---

## 12.9 VPC Flow Logs

```
What's captured:
Version, AccountID, InterfaceID, SourceIP, DestIP, SourcePort, DestPort,
Protocol, Packets, Bytes, Start, End, Action (ACCEPT/REJECT), LogStatus

Use cases:
→ Security forensics: Who accessed what?
→ Network troubleshooting: Why is traffic being rejected?
→ Compliance: Prove no unauthorized access
→ Monitoring: Detect unexpected traffic patterns

Destination options:
→ CloudWatch Logs (real-time alerting)
→ S3 (cost-effective long-term storage + Athena queries)

Cost consideration:
→ Flow logs charge for data ingestion to CloudWatch (~$0.50/GB)
→ S3 delivery is cheaper for high-volume environments
```

---

# 13. DATABASES ON AWS

## 13.1 Database Selection Framework

```
┌───────────────────────────────────────────────────────────────────┐
│              AWS DATABASE SELECTION DECISION TREE                  │
│                                                                     │
│  Is your data structured (rows/columns)?                          │
│  YES → Relational Database                                         │
│      Is workload OLTP (transactions)?                              │
│        YES → RDS (MySQL/PostgreSQL/MariaDB/Oracle/SQL Server)     │
│               or Aurora (higher performance, managed)             │
│        Is it OLAP (analytics/reporting)?                          │
│               YES → Amazon Redshift                               │
│                                                                     │
│  Is your data semi-structured or unstructured?                    │
│  YES → NoSQL Database                                              │
│      Do you need single-digit millisecond latency at any scale?  │
│        YES → DynamoDB                                              │
│      Do you need in-memory performance?                           │
│        YES → ElastiCache (Redis for complex, Memcached for simple)│
│                                                                     │
│  Is it document data (JSON)?                                       │
│        YES → DocumentDB (MongoDB-compatible)                      │
│                                                                     │
│  Is it graph data (relationships between entities)?               │
│        YES → Amazon Neptune                                        │
│                                                                     │
│  Is it time-series data (IoT, metrics)?                          │
│        YES → Amazon Timestream                                     │
└───────────────────────────────────────────────────────────────────┘
```

---

## 13.2 Amazon RDS — Deep Architecture

**What RDS Manages For You:**
```
On-Premises/EC2:        | RDS Managed:
• OS installation       | ✅ AWS manages OS
• DB installation       | ✅ AWS manages DB software
• OS patching           | ✅ AWS manages patches
• DB patching           | ✅ AWS manages minor versions
• Storage provisioning  | ✅ Storage managed
• Backups               | ✅ Automated daily backups
• HA/Failover           | ✅ Multi-AZ automatic failover
• Read scaling          | ✅ Read Replicas available
• Hardware              | ✅ AWS manages all hardware
You manage:             | You still manage:
• Schema                | • Schema/data model
• Queries               | • Query optimization
• App-level optimization| • App-level tuning
```

**Multi-AZ Architecture:**
```
Multi-AZ RDS Deployment:

Primary DB (AZ-1a) ──── Synchronous Replication ────→ Standby DB (AZ-1b)
      │                  (every write to primary         (exact copy, not
      │                   is instantly mirrored)          readable by apps)
      │
Application connects to DNS endpoint:
mydb.abc123.us-east-1.rds.amazonaws.com
→ Resolves to Primary instance IP

Failover Event (Primary AZ fails):
1. AWS detects failure (~1-2 minutes)
2. AWS flips DNS endpoint to point to Standby
3. Standby becomes new Primary
4. Application reconnects (using same DNS endpoint)
5. RTO: ~1-2 minutes
6. RPO: 0 (synchronous replication = no data loss)

Important: Multi-AZ is for HA/DR only — Standby CANNOT serve reads
```

**Read Replicas:**
```
Read Replica Architecture:

Primary DB → Asynchronous Replication → Read Replica 1 (same AZ)
          → Asynchronous Replication → Read Replica 2 (different AZ)
          → Asynchronous Replication → Read Replica 3 (different Region)

Read replica has its own DNS endpoint:
mydb-replica.abc123.us-east-1.rds.amazonaws.com

Application reads → Read Replica (read endpoint)
Application writes → Primary DB (write endpoint)

Benefits:
→ Offload read traffic from primary (up to 5 replicas for MySQL/PostgreSQL)
→ Up to 15 replicas for Aurora
→ Cross-region reads for global applications
→ Promote to standalone DB (breaks replication)

Requirements:
→ Must enable automated backups on primary
→ Replication lag possible (eventual consistency for reads)
```

---

## 13.3 Amazon Aurora — Production Premium Choice

**What Makes Aurora Special:**
```
Aurora Architecture vs Standard RDS:

Standard RDS:
Primary ──→ 1 EBS volume in AZ-1a (2 copies)
           Replica ──→ 1 EBS volume in AZ-1b (2 copies)
Total: 4 copies across 2 AZs

Aurora:
Shared distributed storage cluster:
→ 6 copies across 3 AZs (2 copies per AZ)
→ Survives: 3+ node failures for writes, 4+ node failures for reads
→ Auto-repair: Continuously scans and repairs bad data blocks

Performance:
→ 5x faster than standard MySQL
→ 3x faster than standard PostgreSQL
→ Uses purpose-built storage engine

Aurora Replicas:
→ Up to 15 Aurora replicas (vs 5 for MySQL RDS)
→ All replicas share the SAME storage layer
→ Failover to replica in ~30 seconds (vs ~60-120 seconds for RDS Multi-AZ)
→ Replicas are READABLE (unlike RDS Multi-AZ standby)
```

**Aurora Serverless:**
```
Use Case: Variable or unpredictable workloads

Configuration:
Min capacity: 0.5 ACUs (Aurora Capacity Units)
Max capacity: 128 ACUs

Behavior:
Low traffic → scales DOWN automatically → scales to 0 when idle
Traffic spike → scales UP in seconds → handles burst
Billed: Per ACU-second used

Perfect for:
→ Development/test databases (zero cost when idle)
→ Infrequently used applications
→ Unpredictable traffic patterns
```

---

## 13.4 DynamoDB — NoSQL Deep Architecture

**Core Concepts:**
```
DynamoDB Terms:
Table = Collection of items
Item = A record (like a row in RDS) — up to 400KB
Attribute = A field (like a column, but flexible schema)
Primary Key = Identifies each item uniquely

Primary Key Types:
1. Simple (Partition Key only)
   → Single attribute uniquely identifies items
   → Example: UserID = "user-12345"

2. Composite (Partition Key + Sort Key)
   → Two attributes together identify items
   → Enables range queries on sort key
   → Example: UserID (partition) + Timestamp (sort)
   → Query: "All orders for UserID ordered by Timestamp"
```

**DynamoDB Capacity Modes:**
```
Provisioned Mode:
→ You specify Read Capacity Units (RCUs) and Write Capacity Units (WCUs)
→ 1 RCU = 1 strongly consistent read/sec for 4KB item
→ 1 WCU = 1 write/sec for 1KB item
→ Use with Auto Scaling for variable workloads
→ Can reserve capacity for 1-3 years (54% savings)

On-Demand Mode:
→ No capacity planning needed
→ Scales instantly to any traffic level
→ Pay per request ($1.25/million writes, $0.25/million reads)
→ More expensive than provisioned at predictable high volume
→ Use for: New apps with unknown traffic, highly variable workloads
```

**DynamoDB Global Tables:**
```
Multi-Region, Active-Active Replication:

us-east-1 DynamoDB Table ←──→ eu-west-1 DynamoDB Table
         ↕                              ↕
         ↕ (multi-master replication)   ↕
ap-southeast-1 DynamoDB Table ←────────┘

Benefits:
→ Users in each region read/write to local table
→ Eventual consistency between regions (~1 second)
→ Automatic conflict resolution (last-writer-wins)
→ 99.999% availability

Use for:
→ Global gaming leaderboards
→ User profile stores for global apps
→ Multi-region disaster recovery (RPO: <1 second)
```

---

## 13.5 ElastiCache — Caching Layer Architecture

**Why Caching:**
```
Without Cache:
App → Database query → 100ms response → User waits

With Cache:
First request: App → Cache MISS → Database → Store in Cache → 100ms
Subsequent:    App → Cache HIT → 1ms response → User happy

Result: 100x performance improvement for repeated queries
```

**Redis vs Memcached Decision:**

| Feature | Redis | Memcached |
|---------|-------|-----------|
| Data types | Strings, Lists, Sets, Hashes, Sorted Sets | Strings only |
| Persistence | ✅ Optional | ❌ None |
| Multi-AZ | ✅ Automatic failover | ❌ |
| Replication | ✅ Read replicas | ❌ |
| Pub/Sub | ✅ | ❌ |
| Lua scripting | ✅ | ❌ |
| Backup | ✅ | ❌ |
| Multithreaded | ❌ (single threaded) | ✅ |
| Use case | Sessions, rankings, real-time analytics | Simple caching, horizontal scaling |

**Architect Recommendation:** **Default to Redis** unless you specifically need multi-threading for extreme cache-only workloads.

---

## 13.6 Amazon Redshift — Data Warehouse

```
Redshift Architecture:

Client Application
      │
      ▼
Leader Node (manages connections, parses queries, creates execution plan)
      │
      ▼
Compute Nodes (store data, execute query slices in parallel)
  Node 1 ─── Data slices (part of total data)
  Node 2 ─── Data slices
  Node 3 ─── Data slices
  ...
  Up to 128 compute nodes

Results sent to Leader Node → aggregate → return to client

Why Redshift is Fast for Analytics:
→ Columnar storage (reads only columns needed, not entire rows)
→ Massively Parallel Processing (MPP)
→ Data compression (columnar = better compression)
→ Result caching (identical queries served from cache)

vs RDS for Analytics:
RDS: Row-based, OLTP optimized → 30 seconds for complex report query
Redshift: Column-based, OLAP optimized → 1-2 seconds for same query
```

---

# 14. APPLICATION SERVICES

## 14.1 Amazon SQS — Message Queue

**Simple Explanation:**
SQS is a managed message queue that decouples components. Producer puts messages in queue; consumer picks them up when ready. If consumer is down, messages wait safely.

```
SQS Decoupling Architecture:

Without SQS (Tight Coupling):
Order Service ─────────────────→ Fulfillment Service
If Fulfillment is slow → Order Service blocks or drops orders

With SQS (Loose Coupling):
Order Service ──→ SQS Queue ──→ Fulfillment Service
Order Service: "Put message and forget" → never blocks
Fulfillment: Processes at its own pace
Messages: Survive Fulfillment downtime safely
```

**SQS Types:**

| Feature | Standard Queue | FIFO Queue |
|---------|---------------|------------|
| Ordering | Best-effort (not guaranteed) | Exactly ordered |
| Delivery | At-least-once (possible duplicates) | Exactly-once processing |
| Throughput | Nearly unlimited | 300 msg/s (3,000 with batching) |
| Deduplication | Must handle in application | Built-in (5-minute window) |
| Use case | High-throughput, order doesn't matter | Financial transactions, order processing |

**Key SQS Concepts:**
```
Visibility Timeout (default: 30 seconds):
→ When consumer picks up message, it becomes "invisible"
→ Consumer has 30s to process and delete it
→ If consumer crashes → message reappears after 30s
→ Another consumer picks it up (at-least-once delivery)

Dead Letter Queue (DLQ):
→ Messages that fail processing repeatedly go here
→ maxReceiveCount: if message received 5 times without delete → DLQ
→ Allows analyzing failed messages without losing them

Message Retention: 1 minute to 14 days (default: 4 days)
Max Message Size: 256KB (use Extended Client for larger via S3)
Long Polling: Wait up to 20s for messages → reduces empty receives → saves cost
```

---

## 14.2 Amazon SNS — Pub/Sub Notifications

**Simple Explanation:**
SNS is a publish-subscribe service. You publish ONE message to a topic, and SNS fans it out to ALL subscribers simultaneously.

```
SNS Fan-Out Architecture:

Publisher (e.g., S3 event, Lambda, application)
      │
      ▼
   SNS Topic
      │
      ├──→ Email subscribers (engineers)
      ├──→ SMS subscribers (operations team)
      ├──→ SQS Queue 1 (order processing)
      ├──→ SQS Queue 2 (analytics pipeline)
      ├──→ Lambda function (real-time processing)
      ├──→ HTTP/HTTPS endpoint (webhook to external system)
      └──→ Mobile push (iOS/Android app notifications)

ONE publish → reaches ALL subscribers simultaneously
```

**SNS + SQS Fan-Out Pattern (Production):**
```
Event Source (e.g., image uploaded to S3)
      │
      ▼
SNS Topic: "NewImageUploaded"
      │
      ├──→ SQS Queue: ImageResizeQueue
      │       └──→ Lambda: Resize to thumbnail
      │
      ├──→ SQS Queue: ImageAnalysisQueue
      │       └──→ Lambda: Rekognition image analysis
      ��
      └──→ SQS Queue: ImageMetadataQueue
              └──→ Lambda: Update database metadata

Benefits:
→ Parallel processing without coupling
→ Each SQS provides buffering + retry
→ Can add more subscribers without changing producer
```

---

## 14.3 Amazon CloudFront — CDN Architecture

**Simple Explanation:**
CloudFront caches your content at 400+ edge locations worldwide. Users get content from the nearest edge location instead of your origin server, dramatically reducing latency.

```
CloudFront Request Flow:

User (Sydney, Australia) requests image.jpg
        │
        ▼
Route 53 routes to nearest CloudFront POP (Sydney Edge)
        │
   Cache HIT? ──YES──→ Serve from Sydney cache (< 1ms)
        │
        NO
        │
        ▼
CloudFront fetches from Origin (S3 in us-east-1)
→ 200ms latency one time
→ Store in Sydney cache for TTL duration
        │
        ▼
Next 1000 users in Sydney → Served from cache (<1ms)
```

**CloudFront Distribution Configuration:**
```
Origin:
→ S3 bucket (static content)
→ ALB (dynamic content)
→ EC2 instance
→ Custom HTTP server (on-premises)

Cache Behavior:
→ TTL: Default 86400s (1 day) for static; 0 for dynamic
→ Compress objects automatically (gzip, brotli) → 50-80% size reduction
→ Cache based on: URL path, headers, cookies, query strings

Security:
→ OAI (Origin Access Identity): S3 accessible ONLY via CloudFront
→ WAF (Web Application Firewall): Block SQL injection, XSS, bots
→ AWS Shield: DDoS protection (Standard free, Advanced paid)
→ Signed URLs / Signed Cookies: Time-limited access to private content
→ HTTPS enforcement (redirect HTTP to HTTPS)
→ Field-level encryption: Protect sensitive data in transit

Geographic Restrictions:
→ Whitelist: Only allow specific countries
→ Blacklist: Block specific countries (compliance)
```

**CloudFront vs ALB Direct:**
```
Use CloudFront WHEN:
→ Global users (multi-continent)
→ Mostly static content (images, CSS, JS, videos)
→ Want DDoS protection at edge
→ Need to absorb traffic spikes (edge caching handles it)
→ HTTPS termination at edge for performance

Use ALB Direct WHEN:
→ All users in same region
→ Highly dynamic content that cannot be cached
→ Need WebSockets (CloudFront supports but more complex)
→ Simple internal application
```

---

## 14.4 AWS CloudTrail — Governance & Audit

**Simple Explanation:**
CloudTrail is your AWS account's flight recorder. It logs every API call made in your account — who did what, when, and from where.

```
CloudTrail Captures:
→ "Who called DeleteS3Bucket at 2PM?"
→ "Which role launched these 50 EC2 instances?"
→ "Who changed this security group rule?"
→ "What IP address made these IAM changes?"

Every event contains:
• Identity (IAM user, role, service)
• Timestamp
• Source IP address
• API action performed
• Resources affected
• Request/response parameters
• Success or error

Storage:
→ Default: 90-day event history (free, in console)
→ Trail: Store beyond 90 days → S3 bucket (ongoing cost)

Trail Types:
1. Management Events (Control plane): IAM changes, EC2 launches, S3 bucket creation
2. Data Events (Data plane): S3 object reads/writes, Lambda invocations (high volume, costly)
3. Insight Events: Unusual API activity detection
```

**CloudTrail Architecture for Compliance:**
```
All AWS Accounts
      │
      ▼
CloudTrail (Enabled in each region + global services)
      │
      ▼
Central S3 Bucket (Security/Logging Account)
      │
      ├──→ S3 Object Lock (WORM) — prevents log tampering
      ├──→ KMS Encryption — log file encryption
      ├──→ Log file integrity validation — detect modification
      └──→ Athena queries — analyze logs with SQL
```

---

# 15. SECURITY ARCHITECTURE

## 15.1 AWS Shared Responsibility Model

```
┌───────────────────────────────────────────────────────┐
│          SHARED RESPONSIBILITY MODEL                   │
│                                                        │
│  CUSTOMER RESPONSIBILITY ("Security IN the Cloud")    │
│  ┌────────────────────────────────────────────────┐   │
│  │ • IAM users, roles, policies                   │   │
│  │ • Security Groups & NACL configuration         │   │
│  │ • OS patching (EC2)                            │   │
│  │ • Application security                         │   │
│  │ • Data encryption (at-rest, in-transit)        │   │
│  │ • Network traffic protection                   │   │
│  │ • Client-side data encryption                  │   │
│  └────────────────────────────────────────────────┘   │
│                                                        │
│  AWS RESPONSIBILITY ("Security OF the Cloud")         │
│  ┌────────────────────────────────────────────────┐   │
│  │ • Physical data center security                │   │
│  │ • Hardware & networking infrastructure         │   │
│  │ • Hypervisor security                         │   │
│  │ • Managed service software patching           │   │
│  │ • Global infrastructure                        │   │
│  └────────────────────────────────────────────────┘   │
└───────────────────────────────────────────────────────┘
```

---

## 15.2 Encryption Strategy

```
Encryption at Rest (Data stored):
→ S3: SSE-S3 (free), SSE-KMS (audit trail, key control)
→ EBS: KMS encryption (can enable at creation or snapshot)
→ RDS: KMS encryption for DB storage and snapshots
→ DynamoDB: AWS-owned key (free) or KMS (paid, audit)
→ Redshift: KMS encryption

Encryption in Transit (Data moving):
→ HTTPS/TLS for all API calls (enforce via IAM policy)
→ SSL/TLS for RDS connections
→ VPN for on-premises to AWS traffic
→ AWS PrivateLink for service-to-service within AWS

KMS Key Types:
→ AWS-Managed Keys (free): aws/s3, aws/ebs, etc.
→ Customer-Managed Keys (KMS): $1/month per key + API calls
→ Imported Keys: You import your own key material
→ CloudHSM: Dedicated hardware security module (highest compliance)

When to use Customer-Managed KMS:
→ Need key rotation control
→ Need audit trail of every encryption/decryption
→ Need cross-account encryption
→ HIPAA, PCI-DSS, FedRAMP compliance
```

---

## 15.3 Secrets Manager vs Parameter Store

| Feature | Secrets Manager | Parameter Store |
|---------|----------------|----------------|
| Purpose | Credentials, API keys | Configuration + secrets |
| Automatic rotation | ✅ Built-in (RDS, Redshift, DocumentDB) | ❌ Manual via Lambda |
| Cost | $0.40/secret/month + API calls | Free (Standard) |
| Encryption | KMS (required) | KMS (optional) |
| Cross-account access | ✅ | ✅ |
| Size | Up to 65KB | String: 4KB, SecureString: 8KB |

**Architecture Recommendation:**
```
Use Secrets Manager for:
→ Database passwords (auto-rotation is the key feature)
→ API keys for third-party services
→ OAuth tokens

Use Parameter Store for:
→ Application configuration (non-sensitive)
→ Feature flags
→ Environment-specific settings
→ Cost-sensitive scenarios (free tier available)
```

---

## 15.4 Defense in Depth Architecture

```
Security Layers — Onion Model:

Layer 1: Edge (Before traffic reaches AWS)
  → Route 53: DNS firewall, invalid domain blocking
  → CloudFront: Geo-restriction, WAF at edge
  → AWS Shield: DDoS protection (Standard = free always-on)

Layer 2: Network Perimeter
  → VPC: Isolated network
  → NACL: Subnet-level stateless firewall
  → Security Groups: Instance-level stateful firewall
  → VPC Flow Logs: Traffic monitoring

Layer 3: Compute
  → IAM Roles: Least privilege
  → OS hardening (no unnecessary services, patched)
  → SSM Session Manager: No SSH/RDP ports open
  → Inspector: Vulnerability scanning

Layer 4: Application
  → WAF: Block OWASP Top 10 (SQLi, XSS, etc.)
  → API Gateway: Throttling, API keys, authorizers
  → Cognito: Authentication & authorization
  → Input validation in application code

Layer 5: Data
  → Encryption at rest (KMS)
  → Encryption in transit (TLS)
  → S3 Object Lock (immutable compliance)
  → RDS/DynamoDB encryption
  → Secrets Manager for credentials

Layer 6: Audit & Detection
  → CloudTrail: All API calls logged
  → CloudWatch: Metrics and alarms
  → GuardDuty: Threat detection (ML-based)
  → Security Hub: Centralized security findings
  → Config: Compliance rule enforcement
```

---

## 15.5 Multi-Account Security Strategy (AWS Organizations)

```
AWS Organizations Structure:

Root Account (Management Account)
    │
    ├── Security OU
    │   ├── Log Archive Account (central CloudTrail, Config)
    │   └── Security Tooling Account (GuardDuty master, Security Hub)
    │
    ├── Production OU
    │   ├── Prod-App Account
    │   └── Prod-Data Account
    │
    ├── Non-Production OU
    │   ├── Dev Account
    │   └── Staging Account
    │
    └── Sandbox OU
        └── Individual Developer Accounts

SCP (Service Control Policy) Examples:
→ Root OU SCP: "Deny CloudTrail disable in all accounts"
→ Production OU SCP: "Deny creating resources in non-approved regions"
→ Sandbox OU SCP: "Max EC2 instance type = t3.medium"

Benefits:
→ Blast radius isolation (breach in one account = limited impact)
→ Consolidated billing (Reserved Instance sharing across accounts)
→ Centralized governance via SCPs
→ Independent security boundaries
```

---

# 16. WELL-ARCHITECTED FRAMEWORK

## 16.1 Five Pillars Overview

```
┌────────────────────────────────────────────────────────────────┐
│           AWS WELL-ARCHITECTED FRAMEWORK — 5 PILLARS           │
│                                                                  │
│  1. OPERATIONAL EXCELLENCE                                      │
│     "Run and monitor systems to deliver business value"        │
│     Key: IaC, CI/CD, observability, runbooks, post-mortems    │
│                                                                  │
│  2. SECURITY                                                    │
│     "Protect information and systems"                          │
│     Key: IAM, encryption, detective controls, incident response│
│                                                                  │
│  3. RELIABILITY                                                 │
│     "Recover from failures, meet demand dynamically"           │
│     Key: Multi-AZ, Auto Scaling, backups, chaos engineering   │
│                                                                  │
│  4. PERFORMANCE EFFICIENCY                                      │
│     "Use resources efficiently"                                │
│     Key: Right-sizing, caching, serverless, global deployment  │
│                                                                  │
│  5. COST OPTIMIZATION                                           │
│     "Avoid unnecessary costs"                                  │
│     Key: Reserved/Spot instances, lifecycle policies, cleanup  │
│                                                                  │
│  (6. SUSTAINABILITY — newer addition)                          │
│     "Minimize environmental impact"                            │
│     Key: Maximize utilization, managed services, right-sizing  │
└─────────────────────────────���──────────────────────────────────┘
```

---

## 16.2 Pillar 1: Operational Excellence

**Design Principles:**
```
Infrastructure as Code (IaC):
→ CloudFormation or Terraform for all resources
→ Version control in Git
→ Peer review for infrastructure changes
→ No manual console changes in production

Deployment Best Practices:
→ Small, frequent, reversible changes
→ Canary deployments (5% → 10% → 50% → 100%)
→ Feature flags for instant rollback

Observability:
→ Structured logging (JSON format for Athena queries)
→ Distributed tracing (AWS X-Ray for microservices)
→ Custom metrics for business KPIs
→ SLI/SLO/SLA definitions

Runbooks:
→ Document every operational procedure
→ Automate runbooks with Systems Manager Documents
→ Game days (practice failure scenarios)
→ Post-mortems after every incident (blameless culture)
```

---

## 16.3 Pillar 2: Security

```
IAM Principle of Least Privilege:
→ Grant minimum permissions needed
→ Use conditions (MFA, IP, time) to restrict further
→ Review with IAM Access Analyzer regularly
→ Use Permission Boundaries for delegated administration

Detective Controls:
→ GuardDuty: AI-powered threat detection
→ Security Hub: Centralized security findings
→ Config: Compliance drift detection
→ Macie: Sensitive data discovery in S3

Incident Response:
→ Prepare playbooks before incidents occur
→ Isolate compromised resources (security group changes)
→ Forensics: Enable detailed monitoring before isolating
→ Preserve evidence: Take snapshots before termination
```

---

## 16.4 Pillar 3: Reliability

```
Design for Failure Philosophy:
"Everything fails. Design so failure doesn't matter."

Multi-AZ = Survives single AZ failure
Multi-Region = Survives entire region failure
Multi-Cloud = Survives cloud provider outage (rare)

Recovery Metrics:
RTO (Recovery Time Objective): How long can you be down?
RPO (Recovery Point Objective): How much data can you lose?

RTO/RPO by Strategy:
Backup & Restore:    RTO: hours, RPO: hours
Pilot Light:         RTO: 10min, RPO: minutes
Warm Standby:        RTO: minutes, RPO: seconds
Active-Active:       RTO: seconds, RPO: ~0

Testing Reliability:
→ Chaos Engineering (randomly terminate instances)
→ Netflix Chaos Monkey approach
→ AWS Fault Injection Simulator (FIS)
→ Regular DR drills
```

---

## 16.5 Pillar 4: Performance Efficiency

```
Compute Selection:
→ EC2 for custom workloads needing OS control
→ Lambda for event-driven, short-duration tasks
→ ECS/EKS for containerized applications
→ Batch for large-scale batch processing

Database Selection:
→ Choose engine based on access patterns, not familiarity
→ Right-size instances (monitor and adjust)
→ Use ElastiCache for read-heavy workloads

Caching Layers:
Application Layer → ElastiCache (Redis)
Database Layer → RDS Read Replicas
Content Layer → CloudFront CDN
DNS Layer → Route 53 TTL tuning

Global Architecture:
→ Deploy to multiple regions
→ CloudFront for content delivery
→ Global Accelerator for dynamic routing
→ Aurora Global Database for multi-region writes
```

---

## 16.6 Pillar 5: Cost Optimization

```
Pricing Model Optimization:
On-Demand: Pay full price, maximum flexibility
Reserved (1yr/3yr): 30-75% savings for steady-state
Savings Plans: Like Reserved but more flexible
Spot: 70-90% savings for fault-tolerant workloads
Free Tier: Dev/test experimentation

Cost Visibility:
→ Cost Explorer: Visualize spending patterns
→ AWS Budgets: Alerts when approaching budget limits
→ Cost Allocation Tags: Charge-back to teams/projects
→ Trusted Advisor: Identifies underutilized resources

Right-Sizing:
→ CloudWatch CPU/memory metrics
→ AWS Compute Optimizer recommendations
→ Schedule dev/test instances off-hours
→ Use Lambda instead of always-on EC2 for infrequent tasks

Storage Optimization:
→ S3 Lifecycle Policies: Auto-tier to cheaper storage
→ EBS: Delete unattached volumes
→ Snapshots: Delete old snapshots via DLM
→ EFS Lifecycle: Move infrequent files to IA tier
```

---

# 17. REAL PRODUCTION ARCHITECTURE SCENARIOS

## 17.1 Scenario: High-Availability Three-Tier Web Application

```
Traffic Flow:

User → Route 53 (DNS + health check failover)
     → CloudFront (CDN + WAF + DDoS protection)
     → ALB (Internet-facing, Multi-AZ)
     → Web Tier (EC2 Auto Scaling in private subnet)
     → Internal ALB
     → App Tier (EC2 Auto Scaling in private subnet)
     → ElastiCache (Redis — session store + query cache)
     → RDS Aurora (Multi-AZ primary + 2 read replicas)
     → S3 (static assets, media files)

Full Architecture:

┌────────────────────────────────────────────────────────────────┐
│                      VPC (10.0.0.0/16)                         │
│                                                                  │
│  Public Subnets (/24 each):                                    │
│  ┌─────────────────┐ ┌─────────────────┐                      │
│  │  AZ-1a          │ │  AZ-1b          │                      │
│  │  ALB Node       │ │  ALB Node       │                      │
│  │  NAT Gateway    │ │  NAT Gateway    │                      │
│  └─────────────────┘ └─────────────────┘                      │
│                                                                  │
│  Private App Subnets (/24 each):                               │
│  ┌─────────────────┐ ┌─────────────────┐                      │
│  │  Web EC2 (x2)   │ │  Web EC2 (x2)   │                      │
│  │  App EC2 (x2)   │ │  App EC2 (x2)   │                      │
│  └─────────────────┘ └─────────────────┘                      │
│                                                                  │
│  Private Data Subnets (/24 each):                              │
│  ┌────────��────────┐ ┌─────────────────┐                      │
│  │  Aurora Primary │ │  Aurora Replica  │                      │
│  │  Redis Primary  │ │  Redis Replica   │                      │
│  └─────────────────┘ └─────────────────┘                      │
└────────────────────────────────────────────────────────────────┘

Key Design Decisions:
→ 2 AZs minimum (3 for banking/healthcare critical systems)
→ No database or app server in public subnet
→ ALB handles SSL termination (offloads from EC2)
→ Redis for session state (stateless EC2 instances)
→ Aurora Multi-AZ for automatic DB failover
→ CloudFront caches static content globally
→ WAF protects against OWASP Top 10
```

---

## 17.2 Scenario: Serverless Event-Driven Architecture

```
Use Case: Image Processing Pipeline

User uploads photo → processed → stored → notification sent

Architecture:

User → API Gateway → Lambda (upload handler) → S3 (raw bucket)
                                                      │
                                    S3 Event Notification
                                                      │
                                                      ▼
                                              SNS Topic: "NewImage"
                                                      │
                               ┌──────────────────────┼───────────────┐
                               │                      │               │
                               ▼                      ▼               ▼
                        SQS Queue             SQS Queue          Lambda
                     (Thumbnail)          (Rekognition)         (Metadata)
                           │                      │                   │
                           ▼                      ▼                   ▼
                    Lambda: Resize          Lambda: Detect        DynamoDB
                    Store in S3            Labels/Faces          (image metadata)
                    (processed bucket)     Store results               │
                                                │                      │
                                                └──────────────────────┘
                                                         │
                                                  Lambda: Send
                                                  email via SES
                                                  "Your photo was processed"

Benefits:
→ Zero servers to manage
→ Scale: handles 1 upload/day or 1M uploads/day automatically
→ Cost: Pay only when processing (not for idle time)
→ Decoupled: Each stage processes independently
→ Resilient: SQS queues buffer if Lambda is throttled
```

---

## 17.3 Scenario: Microservices Container Architecture

```
ECS Fargate Microservices Architecture:

                    Route 53
                        │
                        ▼
                   CloudFront
                        │
                        ▼
              Application Load Balancer
              /api/users → User Service
              /api/orders → Order Service
              /api/products → Product Service
                        │
    ┌───────────────────┼───────────────────┐
    │                   │                   │
    ▼                   ▼                   ▼
User Service       Order Service      Product Service
(ECS Fargate)      (ECS Fargate)      (ECS Fargate)
    │                   │                   │
    ▼                   ▼                   ▼
Users DB           Orders DB          Products DB
(RDS Aurora)       (RDS Aurora)       (DynamoDB)

Service Discovery:
→ AWS Cloud Map: Services register themselves
→ User Service discovers Order Service via DNS
→ No hardcoded IP addresses

Container Registry:
→ ECR (Elastic Container Registry)
→ Image scanning for vulnerabilities
→ Lifecycle policies to clean old images

CI/CD for Containers:
CodeCommit → CodeBuild → ECR → CodeDeploy (Blue/Green ECS) → ECS
```

---

## 17.4 Scenario: Multi-Region Disaster Recovery

```
Active-Passive Multi-Region DR:

Primary Region: us-east-1          DR Region: us-west-2
┌──────────────────────────┐       ┌──────────────────────────┐
│  Production Systems      │       │  DR Systems (scaled down) │
│  ALB + ASG + Aurora      │       │  ALB + ASG (min=0) +     │
│  ElastiCache + S3        │──────→│  Aurora Replica + S3     │
│  Route 53 primary        │ CRR   │  Route 53 secondary      │
└──────────────────────────┘       └──────────────────────────┘

Route 53 Failover:
Primary: api.myapp.com → us-east-1 ALB (health check)
Secondary: api.myapp.com → us
