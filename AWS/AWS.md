# ☁️ AWS Complete Notes — From Beginner to Production
### By Senior DevOps Engineer | Interview + Production Ready

---

## 📌 Table of Contents
1. [Introduction to Cloud Computing](#1-introduction-to-cloud-computing)
2. [AWS Overview & Global Infrastructure](#2-aws-overview--global-infrastructure)
3. [AWS Account Creation & Free Tier](#3-aws-account-creation--free-tier)
4. [IAM — Identity and Access Management](#4-iam--identity-and-access-management)
5. [S3 — Simple Storage Service](#5-s3--simple-storage-service)
6. [AWS Snowball & Direct Connect](#6-aws-snowball--direct-connect)
7. [EC2 — Elastic Compute Cloud](#7-ec2--elastic-compute-cloud)
8. [EBS — Volumes & Snapshots](#8-ebs--volumes--snapshots)
9. [ELB — Elastic Load Balancing](#9-elb--elastic-load-balancing)
10. [Auto Scaling Group (ASG)](#10-auto-scaling-group-asg)
11. [CloudWatch](#11-cloudwatch)
12. [EFS — Elastic File System](#12-efs--elastic-file-system)
13. [Amazon Lightsail & Elastic Beanstalk](#13-amazon-lightsail--elastic-beanstalk)
14. [Route 53 — DNS Service](#14-route-53--dns-service)
15. [VPC — Virtual Private Cloud](#15-vpc--virtual-private-cloud)
16. [Databases on AWS](#16-databases-on-aws)
17. [Application Services — SQS & SNS](#17-application-services--sqs--sns)
18. [CloudFront & Global Accelerator](#18-cloudfront--global-accelerator)
19. [Storage Gateway](#19-storage-gateway)
20. [CloudTrail, AWS Config & CloudFormation](#20-cloudtrail-aws-config--cloudformation)
21. [Trusted Advisor & Well-Architected Framework](#21-trusted-advisor--well-architected-framework)
22. [Security — Shared Responsibility Model](#22-security--shared-responsibility-model)

---

## 1. Introduction to Cloud Computing

### 📖 What is Cloud Computing?
Cloud computing is the **on-demand delivery** of compute power, storage, databases, applications, and other IT resources via the internet with **pay-as-you-go pricing**.

Think of it like electricity — you don't build your own power plant. You plug in and pay only for what you use.

---

### ✅ Six Advantages of Cloud Computing (Amazon's Official List)

| Advantage | What It Means | Real Example |
|---|---|---|
| **Trade CAPEX for OPEX** | No upfront hardware investment | Pay $0.01/hr for EC2 instead of buying a $10,000 server |
| **Economies of Scale** | AWS bulk pricing passed to you | AWS buys millions of servers — you benefit from lower prices |
| **Stop Guessing Capacity** | Scale up/down on demand | Scale from 2 to 200 servers in minutes during Black Friday |
| **Increase Speed & Agility** | Resources available in minutes | Spin up a new dev environment in 5 minutes, not 5 weeks |
| **Stop Running Data Centers** | Focus on business, not hardware | No more racking servers, replacing hard drives |
| **Go Global in Minutes** | Deploy anywhere instantly | Launch your app in Tokyo for users in Asia with a few clicks |

> **🎯 Interview Tip:** These 6 advantages are frequently asked in AWS interviews and certification exams. Memorize them with real examples.

---

### 📘 NIST Definition of Cloud Computing

NIST (National Institute of Standards and Technology) defines cloud computing with:

#### 5 Essential Characteristics:
| Characteristic | Simple Meaning |
|---|---|
| **On-demand self-service** | Provision resources automatically without human help from provider |
| **Broad network access** | Access via internet from any device — phone, laptop, tablet |
| **Resource pooling** | Multiple customers share same physical infrastructure (multi-tenant) |
| **Rapid elasticity** | Scale up/down automatically — appears unlimited to user |
| **Measured service** | Pay only for what you use — like a utility bill |

---

### 🏗️ Cloud Service Models

#### 1. SaaS — Software as a Service
- Provider manages everything
- You just use the application
- **Examples:** Gmail, Dropbox, Salesforce, Netflix, Office 365
- **You manage:** Nothing
- **Provider manages:** Infrastructure + Platform + Application

#### 2. PaaS — Platform as a Service
- Provider manages infrastructure
- You manage your application code
- **Examples:** AWS Elastic Beanstalk, Heroku, Google App Engine
- **You manage:** Code and data
- **Provider manages:** Infrastructure + OS + Runtime

#### 3. IaaS — Infrastructure as a Service
- Provider manages physical hardware
- You manage OS, applications, data
- **Examples:** AWS EC2, Azure VMs, Google Compute Engine
- **You manage:** OS + Applications + Data
- **Provider manages:** Physical servers, storage, networking

```
IaaS: Most Control, Most Responsibility
PaaS: Medium Control
SaaS: Least Control, Least Responsibility
```

> **🎯 Interview Tip:** "What's the difference between IaaS, PaaS, SaaS?" — Always use the pizza analogy: IaaS is like having a kitchen (you cook everything), PaaS is like ordering takeout dough (you add toppings), SaaS is like ordering a full pizza delivered.

---

### 🏛️ Cloud Deployment Models

| Model | Description | Use Case |
|---|---|---|
| **Private Cloud** | Dedicated to one organization, behind firewall | Banks, government — strict compliance requirements |
| **Community Cloud** | Shared between organizations with similar requirements | Healthcare organizations sharing HIPAA-compliant infrastructure |
| **Public Cloud** | Open to general public over internet | Most startups and enterprises — AWS, Azure, GCP |
| **Hybrid Cloud** | Mix of public + private cloud, bound together | Sensitive data on-premise, bursting to public cloud during peak |

---

## 2. AWS Overview & Global Infrastructure

### 🌍 What is Amazon Web Services?
AWS is Amazon's cloud division offering **70+ services** including compute, storage, databases, AI/ML, networking, security, and more. AWS is the **market leader** in cloud computing.

- Founded: **March 14, 2006**
- Initial services: **S3, SQS, EC2**
- Subsidiary of Amazon.com

---

### 🗺️ AWS Global Infrastructure (As of July 2021)
- **25 Geographic Regions**
- **80 Availability Zones**
- **Edge Locations** in most major cities worldwide

#### Region
- A **geographic area** containing multiple Availability Zones
- Example: `ap-south-1` = Mumbai, India
- Each region is **completely independent**
- When choosing a region, consider:
  - **Latency** — Choose closest to your users
  - **Data residency laws** — Some countries require data to stay local
  - **Service availability** — Not all services available in all regions
  - **Cost** — Prices vary by region

#### Availability Zone (AZ)
- **Physical data center(s)** within a region
- Each region has **minimum 2 AZs** (most have 3+)
- AZs are physically separated — different buildings, different power, different networking
- **Connected by low-latency, high-bandwidth private fiber**
- Deploying across multiple AZs = **High Availability**

```
Region: ap-south-1 (Mumbai)
  ├── AZ: ap-south-1a  ← Data Center 1
  ├── AZ: ap-south-1b  ← Data Center 2
  └── AZ: ap-south-1c  ← Data Center 3
```

#### Edge Locations
- **CDN endpoints** used by CloudFront
- Located in major cities worldwide (many more than regions)
- **Purpose:** Cache content close to end users to reduce latency
- A user in Chennai can get content cached at the Chennai Edge Location instead of Mumbai

> **🎯 Interview Tip:** "What is the difference between Region, AZ, and Edge Location?" — This is asked in every AWS interview. Region = geographic area. AZ = data center. Edge Location = CDN cache point.

---

### 📋 Key AWS Region Codes

| Region Name | Code |
|---|---|
| US East (N. Virginia) | `us-east-1` |
| US West (Oregon) | `us-west-2` |
| Asia Pacific (Mumbai) | `ap-south-1` |
| Asia Pacific (Singapore) | `ap-southeast-1` |
| Asia Pacific (Tokyo) | `ap-northeast-1` |
| Europe (Ireland) | `eu-west-1` |
| Europe (Frankfurt) | `eu-central-1` |
| South America (São Paulo) | `sa-east-1` |

> **⚠️ Note:** AWS GovCloud (`us-gov-*`) is only for US government workloads. China regions (`cn-*`) require separate AWS China accounts.

---

## 3. AWS Account Creation & Free Tier

### 💳 Account Creation Steps (Summary)
1. Go to [https://aws.amazon.com/free](https://aws.amazon.com/free)
2. Enter email → this becomes your **Root user**
3. Select Account Type: Personal or Business
4. Enter payment info (₹2 INR verification charge — refunded)
5. Identity verification via phone call or OTP
6. Select Support Plan
7. Launch Management Console

### 🔑 The Root User — IMPORTANT
The Root user is created when you first sign up. It has **complete unrestricted access** to everything in your AWS account.

**⚠️ NEVER use Root user for day-to-day work!**
- Create IAM users instead
- Lock away Root credentials
- Enable MFA on Root immediately

---

### 💰 AWS Support Plans

| Plan | Cost | Response Time | Best For |
|---|---|---|---|
| **Basic** | Free | No technical support | Learning, exploring |
| **Developer** | $29/month | 12-24 hours business hours | Development environments |
| **Business** | $100/month | 1 hour for urgent cases | Production workloads |
| **Enterprise** | $15,000/month | 15 min for critical + TAM | Mission-critical enterprise |

> **💡 Production Best Practice:** Use at minimum **Business Support** for production environments. The 1-hour response SLA for critical issues justifies the cost.

---

### 🆓 AWS Free Tier Key Services (12 months from signup)

| Service | Free Limit |
|---|---|
| Amazon EC2 | 750 hours/month (t2.micro Linux or Windows) |
| Amazon S3 | 5 GB standard storage, 20K GET, 2K PUT |
| Amazon RDS | 750 hours/month (db.t2.micro), 20 GB storage |
| Amazon ELB | 750 hours/month, 15 GB data processing |

> **⚠️ Common Mistake:** Running t2.micro across multiple regions simultaneously can exhaust your 750 hours quickly. Monitor usage with AWS Cost Explorer and set billing alerts.

---

## 4. IAM — Identity and Access Management

### 📖 What is IAM?
IAM is the **security backbone of AWS**. It controls **who can do what** on which AWS resources.

- **IAM is Universal** — not region-specific, applies globally
- **Free service** — no additional cost

### 🏗️ IAM Core Components

```
AWS Account
└── Root User (Full access — lock away!)
    ├── IAM Users (Individuals)
    ├── IAM Groups (Collections of users)
    │   └── Policies attached at group level
    └── IAM Roles (For services & cross-account access)
        └── Policies attached to roles
```

---

### 👤 IAM Users

- Represents a **person or application** accessing AWS
- Created with **no permissions by default** (Principle of Least Privilege)
- Can have two access types:

| Access Type | What You Get | Used For |
|---|---|---|
| **Programmatic Access** | Access Key ID + Secret Access Key | CLI, SDK, API, Terraform |
| **Console Access** | Username + Password | AWS Web Console |

> **🔐 Security Best Practice:** Never share Access Key IDs. Rotate them every 90 days. Never commit them to GitHub.

---

### 👥 IAM Groups

- A **collection of IAM users** with the same permissions
- Makes administration easy — update group policy → all members updated
- A user can belong to **multiple groups**

```
Administrators Group → AdministratorAccess Policy
  ├── User: alice
  └── User: bob

Developers Group → PowerUserAccess Policy
  ├── User: charlie
  └── User: dave
```

---

### 📜 Key IAM Policies (Must Know)

| Policy | What it Does |
|---|---|
| **AdministratorAccess** | Full access to all AWS services EXCEPT billing & account management. Can create/delete IAM users |
| **PowerUserAccess** | Full access to all AWS services but CANNOT manage IAM users/groups |
| **ReadOnlyAccess** | Can only read/view all AWS resources — cannot create, modify, delete |

---

### 🎭 IAM Roles

Roles are used to give **AWS services permissions to act on your behalf**.

- **More secure** than storing Access Keys on EC2 instances
- **Universal** — work across all regions
- Can be **attached/detached** from running instances
- Common use cases:
  - EC2 instance accessing S3 without storing credentials
  - Lambda function accessing DynamoDB
  - Cross-account access

```
Without Role (BAD ❌):
EC2 Instance → stores Access Key + Secret Key in ~/.aws/credentials
→ Anyone with instance access can steal credentials

With Role (GOOD ✅):
EC2 Instance → IAM Role attached → Temporary credentials auto-rotated
→ No credentials stored anywhere
```

> **🎯 Interview Tip:** "Why use IAM Roles instead of Access Keys on EC2?" — Roles use temporary credentials that auto-rotate, can't be accidentally committed to code, and are much more secure.

---

### 🔒 IAM Best Practices

```
✅ Enable MFA on Root account immediately
✅ Never use Root for day-to-day tasks
✅ Create individual IAM users — never share credentials
✅ Use Groups to assign permissions, not individual users
✅ Apply Principle of Least Privilege
✅ Rotate access keys regularly (every 90 days)
✅ Use IAM Roles for EC2 instances, not Access Keys
✅ Set a strong password policy
✅ Use IAM Access Analyzer to review permissions
```

---

### 🛡️ Multi-Factor Authentication (MFA)

MFA adds a second layer of security beyond username/password.

**Setup steps:**
1. Download AWS Virtual MFA app on phone
2. Select IAM user → Manage MFA Device
3. Activate Virtual MFA Device
4. Scan QR code with app
5. Enter two consecutive codes to verify

> **⚠️ Common Mistake:** Not enabling MFA on Root and Administrator accounts. If someone gets your password without MFA, they have full access to your AWS account.

---

### 📝 Custom IAM Policies

IAM policies are **JSON documents** that define permissions.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeInstanceStatus"
      ],
      "Resource": "*"
    }
  ]
}
```

**Policy Elements:**
| Element | Description |
|---|---|
| `Effect` | `Allow` or `Deny` |
| `Action` | What API calls are permitted |
| `Resource` | Which AWS resources (ARN or `*`) |
| `Principal` | Who the policy applies to (for bucket/role policies) |

---

### 🔐 IAM Password Policy

You can enforce password rules:
- Minimum length
- Require uppercase, numbers, symbols
- Password expiry
- Prevent password reuse
- Allow/prevent users to change their own passwords

---

### 🔑 Custom Sign-In Link

By default: `https://123456789012.signin.aws.amazon.com/console`

With alias: `https://my-company.signin.aws.amazon.com/console`

- Alias must be **globally unique**
- Easier to share with team members

---

### 📋 IAM Exercises (From Study Guide)

| Exercise | What to Practice |
|---|---|
| Create IAM Group `Administrators` → Attach `IAMFullAccess` | Group management |
| Customize sign-in link + set password policy | Account security |
| Create IAM User `Administrator` → Add to Admins Group | User management |
| Enable MFA on Administrator account | Security hardening |
| Create custom EC2 describe-only policy | Custom permissions |

---

## 5. S3 — Simple Storage Service

### 📖 What is S3?
Amazon S3 is AWS's **object storage service** — one of AWS's first and most widely used services. Store unlimited files of any type, accessible from anywhere over the internet.

**Key Characteristics:**
- **Object-based storage** (not block storage)
- Files stored in **Buckets** (like folders on the internet)
- **Universal namespace** — bucket names must be globally unique
- File size: **0 bytes to 5 TB** per object
- Single bucket stores **unlimited** number of files
- Data is **automatically replicated** across multiple devices within a region
- Max **100 buckets per account** (soft limit — can request increase)

---

### 🌐 S3 URL Formats

```
# Path-style URL
https://s3-region.amazonaws.com/bucket-name/object-name

# Virtual-hosted-style URL (doesn't work if bucket name has dots)
https://bucket-name.s3.amazonaws.com/object-name

# Example
https://s3-ap-south-1.amazonaws.com/my-company-assets/logo.png
```

---

### 📦 S3 Bucket Naming Rules

| Rule | Detail |
|---|---|
| Length | 3 to 63 characters |
| Characters | Lowercase letters, numbers, hyphens only |
| Cannot start with | Period `.` or hyphen `-` |
| Cannot end with | Period `.` |
| Cannot be | Formatted as IP address (e.g., `192.168.1.1`) |
| Cannot contain | Two consecutive periods `..` |

---

### 💾 S3 Storage Classes

Understanding storage classes is critical for **cost optimization** in production.

#### 1. S3 Standard
- **Default** storage class
- High durability: **99.999999999% (11 nines)**
- High availability: **99.99%**
- Stored across **minimum 3 Availability Zones**
- Designed to survive loss of **2 concurrent facilities**
- **Use Case:** Frequently accessed data, production apps

#### 2. S3 Intelligent-Tiering
- **Automatically moves** data between frequent and infrequent access tiers
- No performance impact during tier transitions
- Small monthly monitoring fee
- Durability: **99.999999999%**
- Availability: **99.9%**
- **Use Case:** Data with unknown or changing access patterns

#### 3. S3 Standard-IA (Infrequently Accessed)
- Lower storage cost than Standard
- **Retrieval fee applies** when accessing data
- Minimum object size: **128 KB**
- Minimum storage duration: **30 days**
- Durability: **99.999999999%**
- Availability: **99.9%**
- **Use Case:** Backups, disaster recovery data accessed occasionally

#### 4. S3 One Zone-IA
- **Single Availability Zone only** — data lost if AZ is destroyed
- **20% cheaper** than Standard-IA
- Durability: **99.999999999%** (within one AZ)
- Availability: **99.5%**
- **Use Case:** Re-creatable data, secondary backup copies

#### 5. S3 Glacier
- **Extremely low cost** archiving
- Data retrieval time: **3 to 5 hours**
- **Archive** = up to 40 TB per archive
- **Vault** = container for archives (max 1,000 vaults per account)
- Free monthly retrieval: **5% of stored data**
- **Use Case:** Long-term archiving, compliance data, rarely accessed backups

#### 6. S3 Glacier Deep Archive
- **Cheapest** storage option in S3
- Retrieval time: **12 hours or less**
- Data stored across **3+ Availability Zones**
- Competitive with offline tape storage
- **Use Case:** Regulatory data retained for 7-10 years, truly rarely accessed

#### 7. Reduced Redundancy Storage (RRS) — Legacy
- **99.99% durability** (lower than Standard)
- For re-creatable data like image thumbnails
- **Not recommended** — Intelligent-Tiering is better

---

### 📊 Storage Class Comparison

| Class | Durability | Availability | Min Storage Duration | Retrieval Fee |
|---|---|---|---|---|
| Standard | 99.999999999% | 99.99% | None | None |
| Intelligent-Tiering | 99.999999999% | 99.9% | None | None |
| Standard-IA | 99.999999999% | 99.9% | 30 days | Yes |
| One Zone-IA | 99.999999999% | 99.5% | 30 days | Yes |
| Glacier | 99.999999999% | — | 90 days | Yes (hours) |
| Glacier Deep Archive | 99.999999999% | — | 180 days | Yes (12 hrs) |

> **💰 Cost Optimization Tip:** Use Lifecycle Policies to automatically move objects to cheaper storage classes as they age. Example: Standard → Standard-IA after 30 days → Glacier after 90 days.

---

### 🔄 S3 Versioning

Versioning preserves every version of every object in a bucket.

**Key Facts:**
- Enabled at the **bucket level**
- Once enabled, **cannot be disabled** — only suspended
- When you delete an object, S3 adds a **Delete Marker** (soft delete)
- To restore: delete the Delete Marker
- Previous versions are **preserved and retrievable**
- Protects against accidental deletions and overwrites

```
my-file.txt (Version 1) → uploaded Monday
my-file.txt (Version 2) → uploaded Tuesday (overwrites V1)
my-file.txt (Deleted)   → Delete Marker added
                        → Delete the marker → V2 restored
```

> **🎯 Interview Tip:** "What happens when you delete a versioned object?" — A Delete Marker is added. The object isn't really deleted. To permanently delete, you must delete all versions including the Delete Marker.

---

### ⏱️ S3 Lifecycle Management

Automate moving objects between storage classes based on age.

**Possible Transitions:**
```
S3 Standard
    ↓ (Day 30)
S3 Standard-IA / One Zone-IA / Intelligent-Tiering
    ↓ (Day 60)
S3 Glacier / Glacier Deep Archive
    ↓ (Day 90+)
Delete
```

**Configuration Example:**
- Current version → Standard-IA on Day 30
- Current version → Glacier on Day 60
- Current version → Delete (Expire) on Day 65
- Previous versions → Glacier on Day 2
- Previous versions → Delete on Day 7

> **💰 Cost Optimization:** Most companies keep recent logs in Standard, 30-day-old logs in IA, 90-day-old logs in Glacier, and delete anything older than a year.

---

### 📊 S3 Logging

Track requests on your S3 bucket. Disabled by default.

Each log entry contains:
- Requestor account and IP address
- Bucket name
- Request time
- Action (GET, PUT, LIST, DELETE)
- Response status or error code

> **🔐 Security Best Practice:** Enable S3 access logging on all production buckets. Store logs in a separate dedicated bucket. Use for security audits and compliance.

---

### 🔁 Cross-Region Replication (CRR) / Same-Region Replication (SRR)

**CRR:** Automatically replicate objects to a bucket in **another region**
**SRR:** Automatically replicate objects to a bucket in the **same region**

**Requirements:**
- Versioning must be enabled on **both source and destination** buckets
- Need IAM role for S3 to perform replication
- **Existing objects are NOT replicated** — only new objects after enabling
- You can have **multiple destination buckets**
- Delete markers are **NOT replicated** by default

**Use Cases for CRR:**
- Reduce latency for users in different regions
- Disaster recovery — maintain copy in another geography
- Compliance requirements for geographic data separation

---

### 🌐 Static Website Hosting

Host a complete static website entirely on S3.

**Steps:**
1. Create bucket with same name as domain (e.g., `www.mywebsite.com`)
2. Upload `index.html` and `error.html`
3. Make all files **public**
4. Enable static website hosting under bucket Properties
5. Configure `index.html` and `error.html`
6. Website URL: `<bucket-name>.s3-website-<region>.amazonaws.com`
7. Create Route 53 DNS record pointing domain to S3 bucket

> **💰 Cost Tip:** Hosting a static website on S3 costs pennies per month compared to running an EC2 instance for a web server. Perfect for static portfolios, documentation sites.

---

### 🔒 S3 Object Lock

Prevent objects from being deleted or overwritten. Implements **WORM** (Write Once, Read Many).

**Retention Modes:**
| Mode | Who Can Remove |
|---|---|
| **Governance Mode** | IAM users with specific permissions can override |
| **Compliance Mode** | NOBODY can remove — not even Root account |

**Object Lock Requirements:**
- Must enable at **bucket creation** — cannot enable on existing bucket
- Versioning must be enabled
- Can set **Retention Period** (time-based) or **Legal Hold** (indefinite)

> **🔐 Security + Compliance:** Use Compliance mode for regulatory requirements where data must be immutable for a fixed period (healthcare records, financial records).

---

### 🏷️ S3 Tags

Tags are key-value pairs added to objects or buckets.

**Uses:**
- Cost allocation (track storage costs by project/team)
- Automation with Lifecycle Policies
- Access control using tag-based conditions in IAM policies

---

### ⚡ S3 Transfer Acceleration

Uses **CloudFront's edge locations** to speed up uploads to S3 from distant clients.

```
Without Transfer Acceleration:
User in London → Direct upload → S3 bucket in Mumbai (slow, far)

With Transfer Acceleration:
User in London → Upload to London Edge Location → AWS backbone → S3 Mumbai (much faster)
```

- Additional data transfer charges apply
- Compare speeds: [S3 Transfer Acceleration Speed Comparison Tool](https://s3-accelerate-speedtest.s3-accelerate.amazonaws.com/en/accelerate-speed-comparsion.html)

---

### 📧 S3 Event Notifications

Get notified when specific actions happen in your bucket.

**Supported Events:**
- Object created, deleted, restored
- Replication events

**Notification Destinations:**
- **SNS** — Email/SMS notifications
- **SQS** — Queue for processing
- **Lambda** — Trigger serverless functions

**Example Use Case:** When a developer uploads a new Docker image tarball to S3, trigger a Lambda function that automatically deploys it.

---

### 🔐 S3 Encryption

**1. Server-Side Encryption (SSE):**
| Type | Who Manages Keys |
|---|---|
| SSE-S3 | AWS manages keys automatically |
| SSE-KMS | AWS KMS manages keys (more control + audit trail) |
| SSE-C | You provide and manage your own keys |

**2. Client-Side Encryption:**
- You encrypt data BEFORE uploading to S3
- You manage all encryption/decryption

**3. In-Transit Encryption:**
- Use HTTPS/SSL endpoints
- All data encrypted while traveling over internet

> **🔐 Security Best Practice:** Enable default SSE-S3 or SSE-KMS on all production buckets. Enforce HTTPS-only access using bucket policy.

---

### 📜 S3 Bucket Policies

JSON-based access policies controlling who can access your bucket.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": {
        "AWS": "arn:aws:iam::123456789:user/avinash"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::my-bucket/*"
    }
  ]
}
```

**Policy Generator:** Use AWS Policy Generator to create bucket policies visually.

---

### 📈 S3 Performance Optimization

- S3 supports at least **3,500 PUT/COPY/POST/DELETE** and **5,500 GET/HEAD** requests per second **per prefix**
- Use multiple prefixes to scale performance:
  - 10 prefixes = 55,000 GET requests/second
- Use **multipart upload** for objects > 100 MB (required for > 5 GB)

---

### 🔄 S3 Consistency Models

| Operation | Consistency Type |
|---|---|
| PUT of new objects | **Read-after-Write** consistency (immediately visible) |
| Overwrite PUTS | **Eventual Consistency** (may see old version briefly) |
| DELETE operations | **Eventual Consistency** |

---

## 6. AWS Snowball & Direct Connect

### 🚚 AWS Snowball

Physical device for **petabyte-scale data transfer** — when uploading over the internet would take too long.

**Why Snowball?**
- Transferring 100 TB over 1 Gbps connection = **8+ days** (plus network costs)
- Snowball ships the device, you load data physically, ship it back
- AWS uploads to S3

**Process:**
1. Create a job in AWS Console
2. AWS ships Snowball device to you
3. Connect to local network, run Snowball client
4. Client encrypts and transfers data to device
5. Ship device back to AWS
6. AWS uploads to S3 (tracked via SNS)

**Pricing:**
| Device | Service Fee |
|---|---|
| 50 TB Snowball | $200 |
| 80 TB Snowball | $250 |
| First 10 days onsite | Free |
| Each additional day | $15 |

---

#### Snowball Edge
- **100 TB** data transfer device
- Has **built-in compute** (~EC2 m4.4xlarge: 16 vCPU, 64 GB RAM)
- Can run Lambda functions on the device
- **Use Case:** Remote/disconnected locations that need both storage and compute

---

#### AWS Snowmobile
- **Exabyte-scale** data transfer
- A literal **45-foot shipping container** truck
- **Capacity: 100 PB per Snowmobile**
- Moving 100 PB over 1 Gbps would take **20+ years** — Snowmobile does it in weeks
- Contact: [https://aws.amazon.com/contact-us/aws-sales/](https://aws.amazon.com/contact-us/aws-sales/)

```
Data Size     | Best Option
< 10 TB       | Internet upload
10 TB - 10 PB | Snowball (multiple devices)
> 10 PB       | Snowmobile
```

---

### 🔗 AWS Direct Connect

A **dedicated, private network connection** from your on-premise data center directly to AWS.

**Why Direct Connect?**
- Regular internet = variable bandwidth, inconsistent latency
- Direct Connect = dedicated line, consistent performance

**Advantages:**
1. **Lower bandwidth costs** for high-volume data transfer
2. **Consistent network performance** — no internet congestion
3. **Compatible with all AWS services**
4. **Private connectivity** to your VPC
5. **Elastic** — scale bandwidth as needed

**Use Case:** A bank needs to connect their on-premise Oracle database to AWS RDS for hybrid operations. Using internet would be too slow and unreliable. Direct Connect provides a 1-10 Gbps private dedicated connection.

---

## 7. EC2 — Elastic Compute Cloud

### 📖 What is EC2?
Amazon EC2 provides **resizable virtual servers** in the cloud. These are called **instances**.

> "Instance = Virtual Server"

---

### 🖥️ EC2 Instance Types

| Family | Optimized For | Use Cases |
|---|---|---|
| **General Purpose** (t3, m5) | Balanced CPU/RAM/Network | Web servers, small databases, dev environments |
| **Compute Optimized** (c5, c6) | High CPU | Batch processing, gaming servers, video encoding |
| **Memory Optimized** (r5, x1) | High RAM | In-memory databases, real-time big data analytics |
| **Storage Optimized** (i3, d2) | High IOPS, low latency | NoSQL databases (Cassandra, MongoDB), data warehouses |
| **GPU Compute** (p3, g4) | GPU processing | Machine learning, deep learning, video rendering |
| **FPGA Instances** (f1) | Programmable hardware | Financial analytics, genomics |

**Instance Naming Convention:**
```
m5.xlarge
│ │ └── Size: nano < micro < small < medium < large < xlarge < 2xlarge...
│ └── Generation: 5 (newer = better performance/price)
└── Family: m = general purpose
```

**Free Tier Instance:** `t2.micro` (1 vCPU, 1 GB RAM)

---

### 💰 EC2 Pricing Models

#### 1. On-Demand Instances
- Pay per hour or per second (minimum 60 seconds)
- **No upfront commitment**
- Most flexible — start/stop anytime
- Most expensive per hour
- **Use Case:** Unpredictable workloads, testing, development, short-term needs

#### 2. Reserved Instances (RI)
- Commit to 1 or 3 years for significant discount
- Up to **75% discount** vs On-Demand

| Type | Discount | Flexibility |
|---|---|---|
| **Standard RI** | Up to 75% off | Cannot change instance type |
| **Convertible RI** | Up to 54% off | Can change instance type (must be equal/greater value) |
| **Scheduled RI** | Varies | Reserve for specific time windows (e.g., business hours) |

**Payment Options:**
- **All Upfront** — Pay everything upfront, no monthly charges
- **Partial Upfront** — Pay some upfront, rest monthly
- **No Upfront** — Pay entirely monthly (smallest discount)

> **💰 Cost Tip:** If you know you'll run an instance 24/7 for a year+, Reserved Instances save 40-75%. Most production servers should be Reserved.

#### 3. Spot Instances
- Use AWS's unused EC2 capacity at up to **90% discount**
- AWS can **terminate with 2 minutes notice** if capacity needed
- You specify maximum bid price
- If Spot price rises above bid → instance terminated

**Key Rules:**
- If YOU terminate → pay for partial hour
- If AWS terminates → no charge for partial hour

**Use Case:** Batch processing, data analysis, CI/CD build agents, fault-tolerant workloads that can handle interruption

```
Production web servers → On-Demand or Reserved (cannot tolerate interruption)
Batch data processing → Spot (saves 70-90%, can retry if interrupted)
```

---

### 🏠 EC2 Tenancy Options

| Tenancy | Description | Cost |
|---|---|---|
| **Shared** | Your instances share physical hardware with other customers (default) | Cheapest |
| **Dedicated Instance** | Your instances on hardware dedicated to your account | More expensive |
| **Dedicated Host** | Complete physical server dedicated to you — you control placement | Most expensive |

> **🔐 Security/Compliance:** Use Dedicated Host when compliance requirements prohibit shared hardware (e.g., some government and financial regulations).

---

### 📀 Amazon Machine Images (AMIs)

An AMI defines what **software is pre-installed** when an instance launches:
- Operating System (Linux, Windows)
- Pre-installed applications
- Security patches state
- Configuration

**AMI Sources:**
1. **Published by AWS** — Official Amazon Linux, Ubuntu, Windows Server
2. **AWS Marketplace** — Pre-configured with software (LAMP stack, WordPress, etc.)
3. **Custom AMIs** — Create from your configured instance (Golden AMI)
4. **Uploaded Virtual Servers** — Import from VMware, Hyper-V

**All AMIs are based on x86 OS** — either Linux or Windows.

**AMI Key Facts:**
- AMIs are **regional** — must copy to use in another region
- Can **share** AMIs with other AWS accounts
- Can make AMIs **public**
- Every AMI has an associated **snapshot**
- To deregister: Actions → Deregister (then delete underlying snapshots)

---

### 🔗 Accessing EC2 Instances

#### Public DNS
- Auto-generated when instance launches
- Cannot specify or transfer to another instance
- Available only when instance is in **Running** state
- Format: `ec2-xx-xx-xx-xx.compute.amazonaws.com`

#### Public IP
- Auto-assigned by AWS
- **Changes** when instance is stopped and restarted
- Unique on the internet

#### Elastic IP (EIP)
- **Static public IPv4** address that doesn't change
- Allocated to your AWS account
- Associate/disassociate freely between instances
- Maximum **5 EIPs per region** (soft limit)
- **Charged when NOT associated** with a running instance

**When to use EIP:**
- Production servers that need a fixed IP
- Whitelisting scenarios (firewall rules at partner/vendor)
- DNS A records pointing to specific IPs

---

### 🚀 EC2 Launch Process (Step by Step)

**Step 1: Choose AMI**
- Select OS: Amazon Linux 2, Ubuntu, Windows Server, etc.
- Marketplace for pre-configured software
- Community AMIs for custom setups

**Step 2: Choose Instance Type**
- `t2.micro` for free tier and testing
- Choose based on CPU/RAM/Network requirements

**Step 3: Configure Instance Details**
- **Number of instances** — How many to launch
- **Network** — Choose VPC
- **Subnet** — Choose which subnet
- **Auto-assign Public IP** — Enable for public-facing instances
- **IAM Role** — Attach role for accessing other AWS services
- **Shutdown behavior** — Stop or Terminate
- **Enable termination protection** — Prevents accidental termination
- **Monitoring** — Enable CloudWatch detailed monitoring (1-min intervals, extra cost)
- **Tenancy** — Shared/Dedicated
- **User Data** — Bootstrap script to run at launch

**Step 4: Add Storage**
- Default: 8 GB root volume (EBS)
- Add additional EBS volumes as needed
- Keep under 30 GB for free tier

**Step 5: Add Tags**
- Key-value pairs for resource management
- Max 50 tags per instance
- Common tags: `Name`, `Environment`, `Project`, `Owner`, `CostCenter`

**Step 6: Configure Security Group**
- Firewall rules for the instance
- Open ports as needed: SSH (22), HTTP (80), HTTPS (443), RDP (3389)

**Step 7: Review and Launch**
- Create or select Key Pair
- Download `.pem` file — **save it safely, cannot download again!**

---

### 🔑 Connecting to EC2 Instances

#### Linux Instances (SSH via PuTTY on Windows)

**Step 1:** Convert .PEM to .PPK using PuTTYgen
```
PuTTYgen → Load .pem file → Save private key → .ppk file
```

**Step 2:** Connect via PuTTY
```
Hostname: <Public IP>
Port: 22
SSH → Auth → Browse to .ppk file
Username: ec2-user (Amazon Linux)
```

**Default Usernames by OS:**
| AMI | Username |
|---|---|
| Amazon Linux | `ec2-user` |
| Ubuntu | `ubuntu` |
| RHEL/CentOS | `ec2-user` or `root` |
| Fedora | `ec2-user` |
| SUSE | `ec2-user` or `root` |
| Windows | Retrieved from EC2 console |

#### Linux from Linux/Mac (Direct SSH)
```bash
chmod 400 my-key.pem
ssh -i my-key.pem ec2-user@<Public-IP>
```

#### Windows Instances (RDP)
1. Open Run → `mstsc` → Enter public IP
2. Get password: EC2 Console → Select Instance → Connect → RDP Client → Get Password → Browse .pem → Decrypt Password
3. Login with retrieved username/password

---

### 🔥 EC2 Security Groups

Security groups are **virtual firewalls** for EC2 instances.

**Key Characteristics:**
- Applied at the **instance level**
- **Stateful** — if you allow inbound port, response is automatically allowed outbound
- Rules are **always permissive** — you can only ALLOW, never DENY
- **Default:** All inbound BLOCKED, all outbound ALLOWED
- Changes take effect **immediately**
- One instance can have **up to 5 security groups**
- Up to **50 inbound + 50 outbound rules** per group
- **Cannot block specific IP** — use NACLs for that

**Source Options:**
| Source | When to Use |
|---|---|
| `0.0.0.0/0` | Open to entire internet (public web servers) |
| My IP | Access from current network only |
| Custom IP/CIDR | Specific IP range or corporate network |
| Another Security Group | Allow traffic from instances in specific group |

> **🎯 Interview Tip:** "What's the difference between Security Groups and NACLs?" — Security Groups are stateful, instance-level, allow-only rules. NACLs are stateless, subnet-level, support both allow and deny rules.

---

### 🔰 Placement Groups

Logical grouping of instances for specific network performance needs.

| Type | Description | Use Case |
|---|---|---|
| **Cluster** | Instances in same AZ, low latency | HPC, big data, ML training |
| **Partition** | Groups of instances on separate hardware partitions | Hadoop, Kafka, Cassandra |
| **Spread** | Instances on different hardware, max 7 per AZ | Small critical instances that must not fail together |

**Rules:**
- Cannot merge placement groups
- Cannot move existing instance into a placement group
- Recommend **homogeneous** instances in Cluster groups

---

### 🏃 Instance Lifecycle

```
Pending → Running → Stopping → Stopped → Terminated
                 ↘ Rebooting (stays Running)
                 ↘ Shutting Down → Terminated
```

**Stop vs Terminate:**
| Action | What Happens |
|---|---|
| **Stop** | Instance halted, data preserved on EBS, can restart |
| **Terminate** | Instance permanently deleted, root EBS deleted by default |
| **Reboot** | OS restart, instance stays running |

> **⚠️ Common Mistake:** Forgetting to enable "Delete on Termination = No" for important EBS root volumes. By default, the root volume is deleted when instance terminates.

---

### 📝 User Data (Bootstrap Scripts)

User Data runs **automatically at first launch** — automate instance configuration.

**Linux Example:**
```bash
#!/bin/bash
yum update -y
yum install httpd -y
echo "<h1>My Auto-Configured Web Server</h1>" > /var/www/html/index.html
service httpd start
chkconfig httpd on
```

**Windows Example:**
```xml
<powershell>
tzutil /s "India Standard Time"
Install-WindowsFeature -name Web-Server -IncludeManagementTools
</powershell>
```

**View User Data from inside instance:**
```bash
curl http://169.254.169.254/latest/user-data/
```

> **💡 Production Use Case:** Bootstrap scripts are foundational to immutable infrastructure. Launch an instance → User Data installs and configures everything → No manual SSH needed.

---

### 🔍 Instance Metadata

Get information about the running instance from within the instance itself.

```bash
# Get all available metadata options
curl http://169.254.169.254/latest/meta-data/

# Get specific information
curl http://169.254.169.254/latest/meta-data/public-ipv4
curl http://169.254.169.254/latest/meta-data/instance-id
curl http://169.254.169.254/latest/meta-data/hostname
curl http://169.254.169.254/latest/meta-data/security-groups
```

> **💼 DevOps Use Case:** Use metadata in bootstrap scripts to configure instances based on their own IP, AZ, or instance ID without hardcoding values.

---

### 💻 AWS CLI (Command Line Interface)

Control all AWS services from the command line.

**Installation:** [https://aws.amazon.com/cli/](https://aws.amazon.com/cli/)

**Configuration:**
```bash
# Configure with IAM user credentials
aws configure
# Enter: Access Key ID, Secret Access Key, Region, Output format

# Credentials stored in:
# Windows: C:\Users\<username>\.aws\credentials
# Linux:   ~/.aws/credentials
```

**Common CLI Commands:**
```bash
# List S3 buckets
aws s3 ls

# List EC2 instances
aws ec2 describe-instances

# Start an instance
aws ec2 start-instances --instance-ids i-1234567890

# Stop an instance
aws ec2 stop-instances --instance-ids i-1234567890

# Copy file to S3
aws s3 cp file.txt s3://my-bucket/

# Check CLI version
aws --version
```

> **⚠️ Common Mistake:** Storing Access Keys on EC2 instances in `.aws/credentials`. This is insecure. Use **IAM Roles** attached to the EC2 instance instead — no credentials stored anywhere.

> **🔐 Security Best Practice:** CLI credentials stored in `.aws/credentials` are plaintext. Use IAM Roles for EC2, use AWS Secrets Manager or environment variables for applications. Never commit `.aws` directory to Git.

---

## 8. EBS — Volumes & Snapshots

### 📖 What is EBS?
Amazon Elastic Block Store provides **persistent block storage** volumes for EC2 instances. Think of EBS like a virtual hard drive that can be attached to your EC2 instance.

**Key Characteristics:**
- Automatically **replicated within its AZ** (hardware redundancy)
- Can attach **multiple EBS volumes** to one EC2 instance
- EBS volumes must be in the **same AZ** as the instance
- Supports SSD and HDD types

---

### 📀 EBS Volume Types

#### SSD-Based (Better for high IOPS, random access)

**General Purpose SSD (gp2)**
- Size: 1 GiB to 16 TiB
- Baseline: 3 IOPS per GiB
- Burst: up to 3,000 IOPS
- Max: 10,000 IOPS
- **Use Case:** Boot volumes, dev/test environments, general workloads

**General Purpose SSD (gp3)** — Newer generation
- Size: 1 GiB to 16 TiB
- Provision IOPS independent of storage size
- **20% cheaper** than gp2 per GB
- **Use Case:** Same as gp2 but better price/performance

**Provisioned IOPS SSD (io1)**
- Size: 4 GiB to 16 TiB
- Up to **32,000 IOPS** per volume
- For I/O-intensive database workloads
- **Use Case:** Large relational/NoSQL databases, latency-sensitive applications

**Provisioned IOPS SSD (io2)**
- **100x durability** (99.999%) vs io1
- 500 IOPS per provisioned GB (10x higher ratio than io1)
- Same price as io1
- To achieve 64,000 IOPS → must attach to **Nitro-based EC2 instance**
- **Use Case:** Business-critical databases: SAP HANA, Oracle, MS SQL Server

---

#### HDD-Based (Better for throughput, sequential access)

**Throughput Optimized HDD (st1)**
- Size: 125 GiB to 16 TiB
- Baseline throughput: 40 MB/s per TiB
- **Cannot be root/boot volume**
- **Use Case:** Big data, data warehouses, log processing, Hadoop/EMR

**Cold HDD (sc1)**
- Size: 125 GiB to 16 TiB
- Baseline throughput: 12 MB/s per TiB
- **Lowest cost** HDD option
- **Cannot be root/boot volume**
- **Use Case:** Infrequently accessed data, lowest cost storage

**Magnetic (Standard)** — Legacy
- Size: 1 GiB to 1 TiB
- ~100 IOPS average
- Suited for infrequently accessed workloads

---

### 🔗 EBS Multi-Attach

Attach a **single io1 or io2 volume** to **up to 16 Linux instances** in the same AZ simultaneously.

**Limitations:**
- Only io1 and io2 volumes
- Only Nitro-based instances
- Maximum 16 instances per volume
- Cannot be boot volumes
- Must be in same AZ

---

### 💾 Instance Store Volumes

Temporary storage physically attached to the host computer.

**Characteristics:**
- Also called **Ephemeral Storage**
- Data is **LOST** when:
  - Instance stops
  - Instance terminates
  - Underlying host fails
- **Cannot be stopped** (unlike EBS-backed instances)
- Very fast — directly attached disk
- No additional cost

**Use Case:** Buffers, caches, temporary data, scratch space — anything that can be re-created

---

### 📸 EBS Snapshots

Point-in-time backups of EBS volumes stored in S3.

**Key Facts:**
- **Incremental backups** — only changed blocks since last snapshot are saved
- Stored in **AWS-controlled S3** (not visible in your S3 buckets)
- **Constrained to the region** where created
- To use in another region → **copy the snapshot**
- Can use snapshots to **increase volume size**
- Encrypted snapshot → volume created from it is also encrypted
- Can **share snapshots** (must be unencrypted)

**Snapshot Actions:**
| Action | Description |
|---|---|
| Create Volume | Create new EBS volume from snapshot (can change type/size) |
| Create Image | Create AMI from snapshot |
| Copy | Copy snapshot to another region |
| Modify Permissions | Share with specific account or make public |
| Delete | Remove snapshot |

---

### 🔄 Amazon Data Lifecycle Manager (DLM)

Automate snapshot creation, retention, and deletion.

**Setup:**
1. Create EBS Snapshot Policy
2. Select target resources by **Tags** (e.g., Tag: Key=Backup, Value=Schedule1)
3. Set schedule (e.g., every 12 hours starting at 09:00 UTC)
4. Set retention (e.g., keep last 7 snapshots)
5. Optional: Cross-region copy, fast snapshot restore

> **💡 Production Best Practice:** Use DLM for all production EBS volumes. Set daily snapshots with 7-day retention for non-critical and 30-day retention for databases.

---

### 🖼️ Creating a Custom AMI (Golden AMI)

A **Golden AMI** is a pre-configured, hardened AMI used as the standard base for all your instances.

**Process:**
1. Launch base instance
2. Install and configure all required software
3. Harden OS (remove unnecessary services, apply patches)
4. Select instance → Actions → Images and Templates → Create Image
5. Configure: Name, Description, No-reboot option
6. AMI is created (takes a few minutes)

**Golden AMI Use Cases:**
- Launch identical instances consistently
- Faster than bootstrapping from scratch
- Used with Auto Scaling Launch Templates

> **⚠️ Common Mistake:** Not setting "No Reboot" option when creating AMI from a running instance. Without "No Reboot", AWS will stop/start the instance to ensure filesystem consistency.

---

### 💾 EBS Volume Operations

**Create Volume:**
- Select type (gp2, io1, st1, etc.)
- Select size and AZ
- Optional: Encrypt, restore from snapshot

**Attach Volume:**
- Volume must be in **same AZ** as instance
- Must be in **available** state
- Can attach multiple volumes to one instance

**Mount Volume on Linux:**
```bash
# Elevate to root
sudo su

# Check current disks
df -h

# Verify new disk added
fdisk -l

# Format the volume (ext4 file system)
mkfs -t ext4 /dev/xvdf

# Create mount point
mkdir /newvolume

# Mount the volume
mount /dev/xvdf /newvolume

# Permanent mount (survives reboots) - add to /etc/fstab
echo "/dev/xvdf /newvolume ext4 defaults,nofail 0 2" >> /etc/fstab
```

> **⚠️ Common Mistake:** Forgetting to add the mount to `/etc/fstab`. After instance reboot, the volume won't be mounted and applications will fail.

---

## 9. ELB — Elastic Load Balancing

### 📖 What is ELB?
Elastic Load Balancing **distributes incoming traffic** across multiple EC2 instances, containers, or IP addresses.

**Key Characteristics:**
- Managed service — scales automatically
- No public IP address — only **DNS name**
- Supports health checks
- Integrates with Auto Scaling
- Supports SSL/TLS termination

---

### 🏗️ Types of Load Balancers

#### 1. Classic Load Balancer (CLB) — Legacy
- Works at Layer 4 (TCP) and Layer 7 (HTTP/HTTPS)
- One listener → one rule → forward to registered instances
- **Being phased out** — use ALB or NLB for new deployments

#### 2. Application Load Balancer (ALB)
- Operates at **Layer 7** (OSI Application Layer)
- Content-based routing — route based on URL, headers, HTTP methods
- **Round-robin** routing algorithm by default
- Supports **Target Groups** — group of targets (instances, IPs, Lambda)
- Can route to **different target groups** based on path:
  - `/api/*` → API Target Group
  - `/static/*` → S3 or CDN
  - Default → Web Servers Target Group
- **Use Case:** Web applications, microservices, containerized apps

#### 3. Network Load Balancer (NLB)
- Operates at **Layer 4** (TCP/UDP)
- Handles **millions of requests per second**
- Ultra-low latency
- Assigns **static IP** per AZ (unlike ALB which only gives DNS)
- **Use Case:** Gaming, IoT, real-time streaming, financial trading platforms

#### 4. Gateway Load Balancer (GWLB)
- Deploy, scale, and manage **third-party virtual appliances**
- Firewalls, intrusion detection/prevention, deep packet inspection
- Single gateway for all traffic inspection
- **Use Case:** Network security appliances

---

### 🏥 ELB Health Checks

ELB constantly monitors backend instance health.

| Status | Description |
|---|---|
| **InService** | Instance is healthy, receiving traffic |
| **OutOfService** | Instance failed health check, no traffic sent |

**Health Check Configuration:**
| Setting | Description | Default |
|---|---|---|
| **Protocol** | TCP, HTTP, HTTPS | HTTP |
| **Ping Path** | URL to check | `/index.html` |
| **Healthy Threshold** | Consecutive successes to mark healthy | 2 (max 10) |
| **Unhealthy Threshold** | Consecutive failures to mark unhealthy | 2 (max 10) |
| **Timeout** | Time to wait for response | 5 seconds |
| **Interval** | Time between checks | 30 seconds |
| **Success Codes** | HTTP codes considered healthy | 200-299 |

---

### 🔄 Creating an ALB (Step by Step)

**Step 1:** EC2 Console → Load Balancers → Create Load Balancer → ALB

**Step 2:** Define Load Balancer
- Name, Scheme (Internet-facing or Internal)
- Select VPC and at least **2 subnets** across 2 AZs
- Configure listeners (HTTP:80, HTTPS:443)

**Step 3:** Configure Security Group
- Open port 80 (HTTP) and/or 443 (HTTPS) from `0.0.0.0/0`

**Step 4:** Configure Routing (Target Group)
- Create Target Group name
- Target type: Instance or IP
- Protocol and port
- Health check settings
- Success codes: 200-299

**Step 5:** Register Targets
- Select EC2 instances to add
- Click "Add to Registered"

**Step 6:** Review and Create

> **✅ Production Best Practice:** Always create ELB across **minimum 2 AZs** for high availability. If one AZ goes down, the other continues serving traffic.

---

### 🌐 Internet-Facing vs Internal Load Balancers

| Type | Description | Use Case |
|---|---|---|
| **Internet-Facing** | Routes requests from internet to EC2 instances | Public-facing web apps |
| **Internal** | Routes traffic between private subnets | Microservices, backend APIs |

---

## 10. Auto Scaling Group (ASG)

### 📖 What is Auto Scaling?
ASG automatically **adds or removes EC2 instances** based on demand.

```
Low traffic  → Scale In  → 2 instances running (save cost)
High traffic → Scale Out → 20 instances running (handle load)
```

**Benefits:**
- **High Availability** — Replace unhealthy instances automatically
- **Cost Savings** — Only run what you need
- **Handles traffic spikes** — Black Friday, viral content

---

### 🔧 ASG Components

#### Launch Configuration (Legacy)
- Template for new instances
- Specifies: AMI, instance type, security group, key pair, user data
- **One per ASG at a time**
- Cannot be edited — must create new one

#### Launch Template (Modern — Recommended)
- Similar to Launch Configuration but more features
- Supports **versioning** — can have multiple versions
- Can be updated and rolled back
- Supports both On-Demand and Spot instances in same template
- **AWS recommends using Launch Templates over Launch Configurations**

---

### ⚖️ Scaling Options

#### 1. Maintain Current Instance Levels
- ASG performs periodic health checks
- If instance is unhealthy → terminate and replace automatically
- Always maintains your **desired capacity**

#### 2. Scheduled Scaling
- Scale at specific **dates and times**
- Predictable load patterns
- Example: Scale up at 9 AM Monday-Friday, scale down at 6 PM

#### 3. Dynamic Scaling (Demand-Based)
Three types:

| Type | How It Works | Example |
|---|---|---|
| **Target Tracking** | Maintain a target metric value (like a thermostat) | Keep CPU at 50% — ASG adds/removes instances |
| **Step Scaling** | Scale by different amounts based on alarm severity | CPU 60-70% → add 1, CPU 70-80% → add 2, CPU >80% → add 4 |
| **Simple Scaling** | Single adjustment based on one alarm | CPU > 80% → add 2 instances (then wait cooldown period) |

---

### 🏃 ASG Configuration Settings

| Setting | Description |
|---|---|
| **Minimum Capacity** | Minimum instances always running |
| **Maximum Capacity** | Never exceed this count |
| **Desired Capacity** | Target number of instances |
| **Health Check Grace Period** | Seconds to wait before checking health of new instances (default: 300s) |
| **Cooldown Period** | Wait time after scaling activity before starting another |

**Example:**
```
Min: 2  →  Always have 2 instances (high availability)
Desired: 2  →  Start with 2
Max: 10  →  Can scale up to 10 during traffic spikes
```

---

### 🗑️ Default Termination Policy

When ASG needs to terminate an instance, it follows this order:
1. Select AZ with **most instances** (balance AZs)
2. Within that AZ, find instance with **oldest launch configuration**
3. If multiple — find instance **closest to next billing hour**
4. If still tied — **random selection**

---

### ⚙️ Creating an ASG (Step by Step)

**Step 1:** Create Golden AMI with all software pre-installed

**Step 2:** Create Launch Template
- EC2 Console → Select instance → Actions → Create Template from Instance
- Remove subnet selection (ASG handles subnet selection)
- Save template

**Step 3:** Create Auto Scaling Group
- EC2 → Auto Scaling Groups → Create
- Attach Launch Template
- Select VPC and **multiple subnets** (at least 2 AZs)
- Attach to existing ELB or create new one
- Set Health Check Type (EC2 or ELB)
- Set desired, minimum, maximum capacity
- Configure scaling policies

> **✅ Production Architecture:**
> ```
> Internet → ALB (2 AZs)
>              ↓
>         ASG with Launch Template
>              ↓
>    EC2 (AZ-1a)  EC2 (AZ-1b)  EC2 (AZ-1c)
>              ↓
>         RDS Multi-AZ
> ```

---

## 11. CloudWatch

### 📖 What is CloudWatch?
Amazon CloudWatch is AWS's **monitoring and observability service**. Monitor resources, set alarms, and take automated actions.

**Key Capabilities:**
- Collect and track **metrics**
- Create **alarms** that send notifications
- Make **automated actions** based on rules
- Store and access **log files**

---

### 📊 Monitoring Types

| Type | Interval | Cost |
|---|---|---|
| **Basic Monitoring** (default) | Every 5 minutes | Free |
| **Detailed Monitoring** | Every 1 minute | Additional charge |

---

### 📈 CloudWatch Metrics

Metrics are values monitored over time. Examples:
- EC2: CPUUtilization, NetworkIn, NetworkOut, DiskReadOps
- ELB: RequestCount, LatencyCount, HTTPCode_4XX
- RDS: FreeStorageSpace, DatabaseConnections, ReadLatency
- S3: NumberOfObjects, BucketSizeBytes

**Custom Metrics:**
- You can create custom metrics for application-specific monitoring
- Example: Track number of active user sessions, queue depth

**Metric Retention:** Data retained for **2 weeks** by default

---

### 🔔 CloudWatch Alarms

Alarms watch a metric over time and trigger actions.

**Alarm States:**
| State | Meaning |
|---|---|
| **ALARM** | Metric has breached the threshold |
| **OK** | Metric is within acceptable range |
| **INSUFFICIENT_DATA** | Not enough data to determine state |

**Alarm Actions:**
- Send **SNS notification** (email, SMS)
- **Stop, terminate, reboot** EC2 instance
- Trigger **Auto Scaling** action

---

### 💸 Billing Alert Setup

Monitor your AWS costs and get alerted before bills get too high.

**Steps:**
1. Login with Root account
2. My Account → Preferences → Enable "Receive Billing Alerts"
3. CloudWatch (us-east-1 only) → Billing → Create Alarm
4. Select metric: Billing → Total Estimated Charges
5. Set threshold (e.g., $5 USD)
6. Configure SNS notification with your email
7. Receive email when monthly costs approach $5

> **✅ Production Best Practice:** Set billing alerts at 50%, 80%, and 100% of your expected monthly budget. Use AWS Budgets for more granular cost controls.

---

### 🖥️ CPU Utilization Alarm Example

```
Metric: EC2 CPUUtilization
Threshold: > 75% for 2 consecutive 5-minute periods
Action: Send SNS email notification + Stop instance
```

---

### 📊 CloudWatch Dashboard

Centralized view of all your metrics in one place.

**Free Tier:**
- 3 dashboards with up to 50 metrics each per month free
- $3/dashboard/month after that
- 10 alarms and 1 million API requests free per month

---

### 📝 CloudWatch Logs

Centralized log management for all your AWS services.

**Sources:**
- EC2 instances (requires CloudWatch agent)
- AWS Lambda
- Amazon RDS
- API Gateway
- Route 53 DNS queries
- AWS CloudTrail

**Capabilities:**
- Monitor logs in real-time
- Create metric filters to extract data from logs
- Archive logs to S3 or Glacier
- Set retention periods

---

### ⚡ CloudWatch Events (EventBridge)

Near real-time stream of system events from AWS resources.

**Event Sources:** Any AWS service (EC2 state change, S3 object upload, CodePipeline stage change)

**Event Targets:**
- Lambda functions
- EC2 instances
- Kinesis streams
- SNS/SQS
- CodePipeline, CodeBuild
- ECS tasks

**Example:** When an EC2 instance goes to `stopped` state → trigger Lambda → send Slack notification → restart instance

---

## 12. EFS — Elastic File System

### 📖 What is EFS?
Amazon EFS provides **shared, scalable file storage** for Linux EC2 instances. Multiple instances can mount and access the same file system simultaneously.

**Key Characteristics:**
- **Network File System** (NFSv4.1 protocol)
- **Multiple EC2 instances** can access simultaneously
- Instances across **multiple AZs** can share the same EFS
- **Elastic** — grows and shrinks automatically
- **Pay-per-use** — only pay for storage used
- **NOT supported for Windows instances**

---

### 📊 EFS vs EBS vs S3

| Feature | EBS | EFS | S3 |
|---|---|---|---|
| **Type** | Block storage | File storage | Object storage |
| **Access** | Single instance | Multiple instances | Via HTTP/API |
| **Protocol** | OS disk | NFS | REST API |
| **Scaling** | Manual resize | Automatic | Unlimited |
| **Use Case** | Single EC2 disk | Shared content | General storage |

---

### 🏗️ EFS Storage Classes

| Class | Description | Cost |
|---|---|---|
| **Regional (Standard)** | Redundant across all AZs in region | Higher |
| **One Zone** | Single AZ — less expensive | 47% cheaper |

**EFS Lifecycle Management:**
- Automatically move infrequently accessed files to cheaper storage
- Default policy: 30 days after last access

---

### ⚡ EFS Throughput Modes

| Mode | Description | Use Case |
|---|---|---|
| **Bursting Throughput** | Throughput scales with file system size | General purpose |
| **Provisioned Throughput** | Set throughput independently of size | Known high-throughput needs |

**Performance Modes:**
| Mode | Description |
|---|---|
| **General Purpose** | Low latency for web serving, CMS, home directories |
| **Max I/O** | Higher throughput for big data, media processing |

---

### 🔧 Creating and Mounting EFS

**Step 1:** Create EFS
- Storage Console → EFS → Create File System → Customize
- Select VPC, Subnets, Lifecycle policy

**Step 2:** Configure network
- Ensure Security Group allows **NFS (port 2049)** from EC2 instances

**Step 3:** Mount on EC2 (Linux)
```bash
# Install NFS utilities (pre-installed on Amazon Linux)
sudo yum install -y nfs-utils

# Create mount directory
sudo mkdir /efs

# Mount EFS (get mount command from EFS console)
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport \
  fs-xxxxxxxx.efs.ap-south-1.amazonaws.com:/ /efs

# Permanent mount - add to /etc/fstab
fs-xxxxxxxx.efs.ap-south-1.amazonaws.com:/ /efs nfs4 defaults,_netdev 0 0
```

> **⚠️ Common Mistake:** Launching EC2 instances in a different Security Group than EFS expects. The instance Security Group must allow outbound NFS (port 2049), and EFS Security Group must allow inbound NFS from EC2 Security Group.

---

### 🗄️ Amazon FSx

Third-party file system integration:

| Service | For |
|---|---|
| **FSx for Windows** | Windows-based storage, NTFS, SMB protocol, Active Directory |
| **FSx for Lustre** | High-performance computing, ML, EDA |

> **Note:** FSx for Windows requires Microsoft Active Directory. Regular EFS doesn't support Windows instances.

---

## 13. Amazon Lightsail & Elastic Beanstalk

### 💡 Amazon Lightsail

A simplified alternative to EC2 — **virtual machines with a few clicks**, flat-rate pricing.

**What's included:**
- SSD-based storage
- DNS management
- Static IP address
- Pre-configured OS or application stacks

**Available Blueprints:**
- OS: Amazon Linux, Ubuntu
- Apps: WordPress, Drupal, Joomla, Magento, Redmine, GitLab
- Stacks: LAMP, LEMP, MEAN, Node.js

**Pricing:** Starting at **$5/month** (includes compute + storage + data transfer)

**Use Case:** Personal websites, blogs, small business websites — when simplicity matters more than flexibility.

**Connecting to Lightsail WordPress:**
```bash
# Get WordPress admin password
cat bitnami_application_password
```

---

### 🌱 AWS Elastic Beanstalk

Deploy applications **without managing infrastructure**. Upload code → Beanstalk provisions everything.

**What Beanstalk Manages:**
- EC2 instances
- Security groups
- ELB
- Auto Scaling
- CloudWatch
- S3 (for code)
- SNS notifications

**Supported Languages/Platforms:**
| Platform | Runtime |
|---|---|
| Java | Apache Tomcat |
| PHP | Apache HTTP Server |
| Python | Apache HTTP Server |
| Node.js | Nginx or Apache |
| Ruby | Passenger or Puma |
| .NET | Microsoft IIS 7.5/8.0/8.5 |
| Docker | Containers |
| Go | Go |

**Beanstalk Concepts:**
| Term | Definition |
|---|---|
| **Application** | Logical container for the project |
| **Version** | Specific deployable build |
| **Configuration Template** | Infrastructure and application settings |
| **Environment** | Version + Configuration deployed together |

**Configuration Presets:**
1. **Low Cost** — Free Tier eligible, single instance
2. **High Availability** — ELB + Auto Scaling
3. **Custom Configuration** — Full control

**Workflow:**
```
Developer → Zip code → Upload to Beanstalk → 
Beanstalk creates EC2 + ELB + ASG + S3 + CloudWatch → 
Application running
```

> **💼 DevOps Use Case:** Great for development teams who want to focus on code, not infrastructure. Production teams usually graduate to managing infrastructure directly with CloudFormation or Terraform for more control.

---

## 14. Route 53 — DNS Service

### 📖 What is DNS?
DNS (Domain Name System) translates human-readable domain names into IP addresses.

```
You type: www.amazon.com
DNS resolves: 52.94.225.248
Browser connects to: 52.94.225.248
```

**Amazon Route 53** is AWS's **authoritative DNS service**.

---

### 🏗️ DNS Concepts

#### Top-Level Domains (TLDs)
- `.com`, `.net`, `.org`, `.gov`, `.edu`, `.io`
- Controlled by IANA ([http://www.iana.org/domains/root/db](http://www.iana.org/domains/root/db))
- Each domain registered in WHOIS database

#### Domain Registrars
- Organizations that sell domain names
- Popular: GoDaddy, BigRock, Amazon Route 53
- Registered with ICANN for global uniqueness

---

### 📋 DNS Record Types

| Record Type | Purpose | Example |
|---|---|---|
| **A** | Maps domain to IPv4 address | `www.example.com → 1.2.3.4` |
| **AAAA** | Maps domain to IPv6 address | `www.example.com → 2001:db8::1` |
| **CNAME** | Alias for another domain name | `www → example.com` |
| **MX** | Mail exchange records | `@example.com → mail.example.com` |
| **NS** | Name server records | Delegates domain to name servers |
| **PTR** | Reverse lookup (IP → domain) | `1.2.3.4 → www.example.com` |
| **TXT** | Text records | SPF, DKIM, verification records |
| **SOA** | Start of Authority — zone metadata | Required in every zone |
| **SRV** | Service location | Used by SIP, XMPP |

---

### 🌐 Route 53 Hosted Zones

| Type | Purpose |
|---|---|
| **Public Hosted Zone** | Route traffic on the public internet |
| **Private Hosted Zone** | Route traffic within one or more VPCs |

> **⚠️ Note:** Use **Alias records** (not CNAME) for Route 53 hosted zones. CNAMEs are not allowed for zone apex (root domain).

---

### 🗺️ Route 53 Routing Policies

#### 1. Simple Routing Policy (Default)
- One record → one or more IP addresses
- No health checks
- **Use Case:** Single resource (one web server)

#### 2. Weighted Routing Policy
- Split traffic based on assigned weights
- Example: 60% to Mumbai, 40% to Virginia
- **Use Case:** Blue/green deployments, A/B testing, gradual migration

```
www.example.com (Weight 60) → Mumbai ELB
www.example.com (Weight 40) → Virginia ELB
→ 60% traffic goes Mumbai, 40% goes Virginia
```

#### 3. Latency-Based Routing Policy
- Route to the AWS region with **lowest latency** for user
- Route 53 measures latency from user to each region
- **Use Case:** Global applications where performance matters

#### 4. Failover Routing Policy
- **Active-Passive** setup
- Primary site handles all traffic when healthy
- Traffic automatically shifts to secondary when primary fails
- Uses **health checks** to monitor primary endpoint
- **Use Case:** Disaster recovery, high availability

```
Primary: US-East-1 (active - receives all traffic)
Secondary: AP-South-1 (passive - standby DR)
Health Check: Route 53 monitors primary
If primary fails → all traffic automatically goes to secondary
```

#### 5. Geolocation Routing Policy
- Route based on **geographic location of user**
- Route queries from Europe → European servers
- Route queries from Asia → Asian servers
- Can specify by continent, country, or US state
- **Use Case:** Compliance (data sovereignty), localization, content customization

#### 6. Multivalue Answer Routing
- Returns up to **8 healthy records randomly**
- Like Simple Routing but with health checks
- **Use Case:** Simple load balancing with health checking

---

### 🏥 Route 53 Health Checks

Route 53 monitors endpoint health and can trigger failover.

**Health Check Types:**
- Checks HTTP/HTTPS/TCP endpoints
- Can monitor CloudWatch alarms
- Can monitor other health checks (calculated)

---

### 📋 Hosted Zone Setup (Step by Step)

1. Route 53 → Hosted Zones → Create Hosted Zone
2. Enter domain name, select Public
3. Get 4 NS records
4. Update NS records at your domain registrar (GoDaddy, etc.)
5. Create record sets (A, CNAME, etc.)

---

## 15. VPC — Virtual Private Cloud

### 📖 What is VPC?
Amazon VPC is your **private, isolated section of AWS Cloud** — like having your own data center in the cloud with complete network control.

**What you control:**
- IP address range (CIDR block)
- Subnets (public and private)
- Route tables
- Network gateways
- Security rules

---

### 📐 VPC Limits

| Resource | Default Limit |
|---|---|
| VPCs per region | 5 (soft limit — can request increase) |
| Internet Gateways per VPC | 1 |
| Virtual Private Gateways per VPC | 1 |
| Subnets per VPC | 200 |

---

### 🏗️ VPC Core Components

#### CIDR Blocks
- Define IP address range for your VPC
- Example: `10.0.0.0/16` = 65,536 IP addresses
- Can be as large as `/16` or as small as `/28` (16 addresses)
- **Cannot overlap** with connected networks (on-premise)
- **Cannot change** after VPC creation

#### Subnets
- Segment of VPC's IP address range
- **One subnet = One Availability Zone** (cannot span AZs)
- Can have **multiple subnets in one AZ**
- AWS reserves **5 IP addresses** per subnet (first 4 + last 1)

| Subnet Type | Route Table Configuration |
|---|---|
| **Public** | Route table has route to Internet Gateway |
| **Private** | No direct route to Internet Gateway |
| **VPN-Only** | Route to Virtual Private Gateway only |

#### Route Tables
- Set of rules determining where traffic goes
- Each subnet must be associated with a route table
- Default route: `local` → communication within VPC (cannot remove)
- Add routes: `0.0.0.0/0 → IGW` (for public internet access)

#### Internet Gateway (IGW)
- Allows communication between VPC instances and internet
- Translates private IP → public IP (NAT)
- **Horizontally scaled, redundant, highly available**
- **One IGW per VPC only**
- For public internet access: attach IGW + add route `0.0.0.0/0 → IGW`

#### Elastic IP (EIP)
- Static public IP from the AWS regional pool
- Region-specific (cannot move between regions)
- One-to-one with network interface
- **Charged when NOT associated** with running instance
- Limited to **5 per region** by default

---

### 🔒 Security Components

#### Security Groups
- Virtual firewall at **instance level**
- **Stateful** — return traffic automatically allowed
- **Allow rules only** — cannot create deny rules
- Default: all inbound blocked, all outbound allowed
- Changes take effect **immediately**

#### Network Access Control Lists (NACLs)
- Firewall at **subnet level**
- **Stateless** — return traffic must be explicitly allowed
- Supports **both Allow AND Deny** rules
- Rules evaluated in **number order** (lowest first)
- Each subnet must have a NACL
- Default NACL: allows all inbound and outbound

**Security Group vs NACL Comparison:**

| Feature | Security Group | NACL |
|---|---|---|
| Level | Instance | Subnet |
| Stateful | ✅ Yes | ❌ No (stateless) |
| Deny rules | ❌ No (allow only) | ✅ Yes |
| Rule evaluation | All rules evaluated | Rules in number order |
| Default | All outbound allowed | All traffic allowed |

> **🎯 Interview Tip:** This comparison is one of the most asked VPC questions in AWS interviews. Know it cold.

---

### 🌐 NAT Instances vs NAT Gateways

Private subnet instances need internet access (for updates, patches) but cannot be directly internet-accessible.

#### NAT Instance (Legacy)
- Amazon Linux AMI configured as NAT
- Must **disable Source/Destination Check**
- Throughput limited by instance size
- Need to manage patching, scaling, HA yourself
- Create security group allowing HTTP/HTTPS outbound

#### NAT Gateway (Recommended)
- AWS-managed service
- Scales automatically up to **10 Gbps**
- No security groups needed
- Gets automatic public IP (EIP)
- **No OS to patch**
- Must create in **public subnet**
- Must have **EIP** assigned
- Update route table: `0.0.0.0/0 → NAT Gateway`

**NAT Gateway Advantages:**
```
✅ Preferred for production/enterprise
✅ Scales automatically to 10 Gbps
✅ Not associated with security groups
✅ Automatic EIP assignment
✅ No patching required
✅ No Source/Destination Check needed
✅ High availability within an AZ
```

> **⚠️ Common Mistake:** Creating only one NAT Gateway for multiple AZs. For true HA, create a NAT Gateway in each AZ. If one AZ goes down, private instances in other AZs still have internet access.

---

### 🏗️ Custom VPC — Step by Step Creation

**Architecture Goal:**
```
Custom VPC: 192.168.0.0/16
├── Public Subnet: 192.168.1.0/24 (ap-south-1a) → Web Servers
│   └── Internet Gateway
└── Private Subnet: 192.168.2.0/24 (ap-south-1b) → Database Servers
    └── NAT Gateway (internet only outbound)
```

**STEP 1: Create VPC**
- VPC → Your VPCs → Create VPC
- Name: `PROD-VPC`
- CIDR: `192.168.0.0/16`
- Tenancy: Default

**STEP 2: Create Subnets**
- Create Public Subnet:
  - Name: `Public-Subnet`
  - VPC: `PROD-VPC`
  - AZ: `ap-south-1a`
  - CIDR: `192.168.1.0/24`

- Create Private Subnet:
  - Name: `Private-Subnet`
  - VPC: `PROD-VPC`
  - AZ: `ap-south-1b`
  - CIDR: `192.168.2.0/24`

**STEP 3: Create and Attach Internet Gateway**
```
VPC → Internet Gateways → Create IGW → Name it
Actions → Attach to VPC → Select PROD-VPC
```

**STEP 4: Create Public Route Table**
```
VPC → Route Tables → Create Route Table
Name: Public-RT, VPC: PROD-VPC

Edit Routes → Add Route:
Destination: 0.0.0.0/0
Target: [Select your Internet Gateway]

Subnet Associations → Edit → Select Public Subnet
```

**STEP 5: Enable Auto-Assign Public IP for Public Subnet**
```
Subnets → Select Public Subnet → Actions → 
Modify auto-assign IP settings → Enable → Save
```

**STEP 6: Launch Instances**
- Public instance → Public Subnet → Gets public IP
- Private instance → Private Subnet → No public IP

**STEP 7: Create NAT Gateway for Private Subnet Internet Access**
```
VPC → NAT Gateways → Create NAT Gateway
Subnet: Public Subnet (NAT must be in public subnet!)
Elastic IP: Allocate new EIP
```

**STEP 8: Update Main Route Table**
```
Main Route Table (Private Subnet) → Edit Routes:
0.0.0.0/0 → NAT Gateway
```

---

### 🔗 VPC Peering

Connect two VPCs to communicate using private IP addresses.

**Key Facts:**
- Instances communicate as if on same private network
- Can peer with other AWS accounts
- Can peer VPCs in different regions (inter-region peering)
- **Star topology only** — no transitive peering
- Cannot peer VPCs with **overlapping CIDR blocks**
- **One peering connection** between two specific VPCs at a time

```
VPC-A ← peering → VPC-B
VPC-B ← peering → VPC-C
VPC-A CANNOT reach VPC-C through VPC-B (no transitive peering!)
VPC-A must directly peer with VPC-C
```

---

### 📊 VPC Flow Logs

Capture information about IP traffic in your VPC.

**Log Information Includes:**
- Source/destination IP
- Source/destination port
- Protocol
- Packets and bytes transferred
- Action: ACCEPT or REJECT
- Timestamps

**Storage:** CloudWatch Logs or S3

**Use Case:** Security auditing, troubleshooting network issues, compliance

---

### 🏰 Bastion Host

A **jump server** in your public subnet that provides SSH/RDP access to private subnet instances.

```
Internet
  ↓
Bastion Host (Public Subnet) ← SSH allowed from specific IPs only
  ↓
Private EC2 Instances (Private Subnet) ← SSH only from Bastion
```

**Security:**
- Only allow SSH from specific, known IP addresses
- Use Private Key forwarding (ssh-agent) — never copy private keys to Bastion
- Consider using AWS Systems Manager Session Manager instead (no open SSH ports)

---

### 🔌 VPN Options

**Virtual Private Gateway (VPG):** VPN concentrator on AWS side
**Customer Gateway (CGW):** Physical device or software on your on-premise side

Together they create an **encrypted VPN tunnel** between on-premise and AWS VPC.

---

### 🏛️ VPC Deployment Models

| Model | Description | Use Case |
|---|---|---|
| **Single Public Subnet** | VPC + IGW + public subnet | Simple websites, single-tier apps |
| **Public + Private (NAT)** | Most common — web in public, DB in private | Standard 3-tier web apps |
| **Public + Private + VPN** | Adds VPN connection to on-premise | Hybrid cloud architectures |
| **Private + VPN Only** | No internet — connected to on-premise only | Sensitive enterprise workloads |

---

## 16. Databases on AWS

### 🗄️ AWS Database Services Overview

| Service | Type | Use Case |
|---|---|---|
| **Amazon RDS** | Relational (OLTP) | Web apps, CRM, ERP |
| **Amazon Aurora** | Relational (MySQL/PostgreSQL) | High performance relational |
| **Amazon DynamoDB** | NoSQL (Key-Value/Document) | Serverless apps, gaming, IoT |
| **Amazon Redshift** | Data Warehouse (OLAP) | Business intelligence, analytics |
| **Amazon ElastiCache** | In-Memory Cache | Session storage, leaderboards |
| **AWS DMS** | Migration Service | Migrate databases to AWS |

---

### 🗃️ Amazon RDS

Amazon RDS makes it easy to set up, operate, and scale **relational databases** in the cloud.

**Supported Database Engines:**
1. **Amazon Aurora** — MySQL/PostgreSQL compatible, up to 5x faster
2. **MySQL** — Most popular open-source
3. **PostgreSQL** — Feature-rich open-source
4. **MariaDB** — MySQL fork with enterprise features
5. **Oracle** — Enterprise commercial database
6. **Microsoft SQL Server** — Enterprise commercial (Express, Web, Standard, Enterprise editions)

---

#### Licensing Models (Oracle and SQL Server)
| Model | Description |
|---|---|
| **License Included** | License cost included in hourly rate |
| **BYOL** | Bring Your Own License (use existing licenses) |

---

#### RDS Storage Options (Powered by EBS)
| Type | IOPS | Use Case |
|---|---|---|
| **Magnetic** | ~100 IOPS | Development, test |
| **General Purpose SSD** | Up to 16,000 IOPS | General production |
| **Provisioned IOPS SSD** | Up to 30,000 IOPS | I/O intensive databases |

Storage range: **4 GB to 16 TB** (varies by engine)

---

#### ✅ RDS Advantages Over Self-Managed (EC2)

AWS manages for you:
- OS installation and patching
- Database software installation and upgrades
- Database backups
- High availability setup
- Read replica setup
- Monitoring and metrics
- Storage scaling

You manage:
- Schema design
- Query optimization
- Application integration
- Data (obviously)

---

### 💾 RDS Backup and Recovery

#### 1. Automated Backups
- Default retention: **7 days** (max 35 days)
- Occurs daily in a configurable **30-minute maintenance window**
- Deleted when DB instance is deleted
- Enables **Point-in-Time Recovery** (within retention period)
- Combines daily backups + transaction logs = restore to any minute

#### 2. Manual DB Snapshots
- Manually initiated
- Create as frequently as needed
- **Kept until explicitly deleted**
- Not deleted when DB instance is deleted
- Can **copy to other regions**
- Can **share with other AWS accounts**

**Recovery:**
- Creates a **new DB instance** with new endpoint
- Cannot restore to existing DB instance
- Point-in-time: typically accurate to last **5 minutes**

---

#### 🔄 Multi-AZ Deployment

Multi-AZ creates a **synchronous standby replica** in another AZ for disaster recovery.

```
AZ-1: Primary RDS (Read/Write)
  ↓ Synchronous replication
AZ-2: Standby RDS (No read/write access — DR only)

If Primary fails → AWS automatically fails over to Standby
DNS endpoint stays the same → Application reconnects
```

**Key Facts:**
- Available for **all** RDS engines
- Standby is **NOT accessible** for reads (DR only)
- Automatic failover — no admin intervention needed
- Failover typically completes within **1-2 minutes**
- **NOT for performance scaling** — use Read Replicas for that

> **🎯 Interview Tip:** "What's the difference between Multi-AZ and Read Replicas?" — Multi-AZ is for **availability** (disaster recovery), Read Replicas are for **performance** (read scaling).

---

#### 📖 Read Replicas

**Asynchronous** replication of primary DB for read-heavy workloads.

**Key Facts:**
- Available for: MySQL, PostgreSQL, MariaDB, Amazon Aurora
- Up to **5 read replica copies** of any database
- Can have **read replicas of read replicas** (additional latency)
- Each read replica has its **own DNS endpoint**
- Can be in **same region or cross-region**
- Can be **promoted** to standalone DB (breaks replication)
- **Must have automated backups enabled**

```
Primary RDS (Read+Write)
├── Read Replica 1 (Read only) — Singapore
├── Read Replica 2 (Read only) — Mumbai
└── Read Replica 3 (Read only) — Virginia
```

> **💼 Production Use Case:** Instagram-like app with 90% read traffic. All SELECT queries go to Read Replicas. Only INSERT/UPDATE/DELETE go to Primary. Dramatically reduces primary DB load.

---

### ⚡ Amazon Aurora

AWS's own high-performance relational database engine.

**Key Features:**
- **MySQL and PostgreSQL** compatible
- Up to **5x faster** than standard MySQL
- Up to **3x faster** than standard PostgreSQL
- Fully managed by AWS
- Automatically scales storage from 10 GB to **64 TB**

**Replication:**
- **2 copies** of data per AZ across **minimum 3 AZs** = **6 copies total**
- Can lose up to **2 copies** without affecting write availability
- Can lose up to **3 copies** without affecting read availability
- Storage is **self-healing** — disks continuously scanned and repaired

**Aurora Replica Types:**
| Type | Max Count | Use |
|---|---|---|
| Aurora Replicas | 15 | Read scaling within cluster |
| MySQL Read Replicas | 5 | Cross-region read replicas |

---

### 🗃️ Launching an RDS Instance (Step by Step)

1. AWS Console → Database → RDS → Create Database
2. Select engine (e.g., MySQL Community Edition)
3. Select Free Tier template
4. Configure:
   - **DB Instance Identifier:** Unique name per region
   - **Master Username:** Admin username
   - **Master Password:** Strong password
   - **DB Instance Class:** db.t2.micro for free tier
   - **Storage:** 20 GB gp2 (free tier)
   - **Multi-AZ:** No (free tier)
5. Configure Connectivity:
   - **VPC:** Select your VPC
   - **Subnet Group:** Default
   - **Public Accessible:** Yes (for testing), No (for production)
   - **Security Group:** Open port 3306 (MySQL)
6. Additional Config:
   - Database name (creates initial database)
   - Port: 3306 (MySQL)
   - Backup retention: 7 days
   - Maintenance window
7. Create Database

**RDS Instance Lifecycle States:**
| State | Description |
|---|---|
| **Creating** | DB being created — inaccessible |
| **Modifying** | Configuration changes being applied |
| **Backing-up** | Automated backup in progress |
| **Available** | Ready for use |

---

### 💻 Connecting to RDS

**Via MySQL Workbench:**
- Hostname: RDS Endpoint URL
- Port: 3306
- Username: Master username
- Password: Master password

**Via Linux CLI:**
```bash
# Install MySQL client
yum install mysql -y

# Connect to RDS
mysql -u <master_username> -h <rds-endpoint> -p
```

---

### 🗃️ Amazon DynamoDB

AWS's managed **NoSQL** database — fast, flexible, serverless.

**Key Features:**
- Fully managed — no servers to manage
- Single-digit millisecond performance at any scale
- All data stored on **SSD drives**
- Automatically replicates across **3 AZs**
- Supports key-value and document data models

**DynamoDB Concepts:**
| Concept | RDS Equivalent |
|---|---|
| Table | Table |
| Item | Row |
| Attribute | Column |
| Primary Key | Primary Key |

**Provisioned Capacity:**
- Set Read Capacity Units (RCU) and Write Capacity Units (WCU)
- Or use **On-Demand** mode for variable workloads

**Creating DynamoDB Table:**
1. DynamoDB → Create Table
2. Table name and Primary Key
3. Default settings or customize
4. Navigate to Items → Create Item → Add attributes

> **🎯 Interview Tip:** "When would you use DynamoDB over RDS?" — DynamoDB for: serverless apps, need massive scale, key-value or document data, flexible schema. RDS for: complex SQL queries, transactions (ACID), reporting, fixed schema.

---

### 📊 Amazon Redshift

AWS's **data warehouse** service for analytics on large datasets.

**Key Features:**
- Petabyte-scale data warehouse
- Based on **PostgreSQL** (most SQL tools work)
- Optimized for **OLAP** (analytics, reporting)
- Integrates with BI tools via JDBC/ODBC
- **Not** for OLTP (use RDS for that)

**Architecture:**
```
Leader Node → Receives queries from clients
     ↓
Compute Nodes → Store data, run queries (up to 128 nodes)
```

**Node Types:**
- **Single Node:** 160 GB
- **Multi-Node:** Leader Node + up to 128 Compute Nodes

---

### ⚡ Amazon ElastiCache

**In-memory caching** layer to reduce database load and improve application speed.

**Two Engine Options:**

| Engine | Description | Use Case |
|---|---|---|
| **Memcached** | Simple, multi-threaded caching | Simple object caching, web scaling |
| **Redis** | Rich data structures, persistence, replication | Session storage, leaderboards, pub/sub |

**Redis Extra Features:**
- Sorted sets and lists
- **Multi-AZ with failover**
- Master/Slave replication
- Snapshots

**When to Use ElastiCache:**
- Read-heavy workloads (social media feeds)
- Session management (user sessions)
- Real-time analytics (leaderboards)
- Any data that can be cached (doesn't change frequently)

> **💰 Cost Tip:** Caching frequently-read data in ElastiCache reduces RDS read load, allowing smaller (cheaper) RDS instances. Often more cost-effective than upgrading RDS.

---

## 17. Application Services — SQS & SNS

### 📨 Amazon SQS (Simple Queue Service)

SQS is a **message queue** service for decoupling components of a distributed application.

**Core Concept:**
```
Producer → Message → SQS Queue → Consumer polls → Processes message
```

**Key Characteristics:**
- Messages can contain up to **256 KB** of text (any format)
- **Message Retention:** up to **14 days**
- Supports **multiple readers and writers**
- Does NOT guarantee **FIFO delivery** (standard queue)
- Designed for **"at least once"** delivery (messages may be delivered more than once — design for idempotency!)
- Maximum **12-hour visibility timeout**
- First **1 million requests/month FREE**

**Billing:**
- $0.50 per 1 million requests after free tier
- Billed in **64 KB chunks** (256 KB message = 4 requests billed)

**Queue Types:**
| Type | Order | Deduplication | Use Case |
|---|---|---|---|
| **Standard** | Best-effort ordering | No dedup | High throughput, order not critical |
| **FIFO** | Strict ordering | Yes dedup | Financial transactions, order processing |

---

### 📢 Amazon SNS (Simple Notification Service)

SNS is a **pub/sub messaging service** for sending notifications to multiple subscribers simultaneously.

**Core Concept:**
```
Publisher → Message → SNS Topic → Subscribers (Email, SMS, SQS, Lambda, HTTP)
```

**Supported Protocols:**
- Email / Email-JSON
- SMS (text messages)
- HTTP/HTTPS endpoints
- SQS queues
- Lambda functions
- Mobile push (Apple APNs, Google GCM, Amazon ADM)

**SNS Benefits:**
- Instantaneous **push-based delivery** (no polling)
- Simple APIs
- Flexible delivery across protocols
- Pay-as-you-go
- Messages stored redundantly across **multiple AZs**

---

### 🔄 SNS vs SQS

| Feature | SNS | SQS |
|---|---|---|
| **Model** | Push (Pub/Sub) | Pull (Queue) |
| **Consumers** | Multiple simultaneously | One consumer per message |
| **Persistence** | Not persisted | Messages stored until consumed |
| **Use Case** | Fan-out notifications | Decoupling, buffering |

**Combined Pattern (Fan-Out):**
```
S3 Event → SNS Topic → SQS Queue 1 (processing service 1)
                    → SQS Queue 2 (processing service 2)  
                    → Lambda (immediate processing)
                    → Email (alert DevOps team)
```

---

### 📧 Creating SNS Topic and Publishing (Step by Step)

1. SNS → Create Topic → Standard
2. Name + Display Name → Create
3. Create Subscription:
   - Protocol: Email
   - Endpoint: your-email@company.com
4. Confirm subscription via email link
5. Publish to Topic:
   - Subject + Message body
   - TTL: 300 seconds
   - Click Publish → All subscribers receive email

---

## 18. CloudFront & Global Accelerator

### 🌍 Amazon CloudFront

CloudFront is AWS's **Content Delivery Network (CDN)** — cache content at edge locations worldwide.

**How It Works:**
```
User in Japan requests image
    ↓
Route 53 routes to nearest edge location (Tokyo)
    ↓
If image in cache → Serve immediately (fast!)
If not in cache → Fetch from origin (S3/EC2)
                → Cache at edge for future requests
```

**Supported Content:**
- Static files: HTML, CSS, JavaScript, images
- Dynamic web pages
- Media streaming (HTTP and RTMP)
- Software downloads

---

### 🏗️ CloudFront Concepts

| Concept | Description |
|---|---|
| **Distribution** | CloudFront deployment identified by a DNS name (`d111111.cloudfront.net`) |
| **Origin** | Source server (S3, EC2, ALB, custom HTTP server) |
| **Cache Control** | How long objects stay in edge cache (default: 24 hours) |
| **TTL** | Time-to-Live for cached objects |
| **Signed URLs** | Time-limited, IP-restricted access URLs |
| **Signed Cookies** | Authentication via public/private key pairs |

---

### 🔑 Origin Access Identity (OAI)

Restrict S3 bucket access so only CloudFront can access it (not direct S3 URL).

```
Internet → CloudFront Distribution → OAI → Private S3 Bucket
Internet → Direct S3 URL → BLOCKED (403 Forbidden)
```

**Setup:** Create new OAI → Attach to CloudFront → Update S3 bucket policy to allow OAI

---

### 📊 CloudFront Cache Settings

| Setting | Default | Description |
|---|---|---|
| **Default TTL** | 86,400 seconds (1 day) | How long objects stay cached |
| **Max TTL** | 31,536,000 seconds (365 days) | Maximum cache time |

---

### 🚀 AWS Global Accelerator

Improves **availability and performance** for global applications using AWS's backbone network.

```
Without Global Accelerator:
User → Public Internet (variable, slow) → Application

With Global Accelerator:
User → Nearest AWS Edge Location → AWS Global Network (fast, reliable) → Application
```

**Benefits:**
- 2 static **anycast IP addresses** for your application (no DNS TTL issues)
- Routes traffic via AWS global network instead of public internet
- Automatic health checking and failover
- Works with ELB, EC2, and EIPs

**Test Performance:** [https://speedtest.globalaccelerator.aws/](https://speedtest.globalaccelerator.aws/)

---

## 19. Storage Gateway

### 🔌 What is AWS Storage Gateway?

Connects **on-premise IT environment** to AWS cloud storage with seamless integration.

**Use Case:** Organizations with on-premise servers that want to gradually move to cloud or need hybrid storage.

---

### 🏗️ Storage Gateway Types

#### 1. S3 File Gateway
- Presents as **NFS or SMB** file share to on-premise servers
- Files stored as **objects in S3**
- Access via NFS/SMB from data center or EC2
- **Use Case:** User file shares, content management, file-based workflows

#### 2. FSx File Gateway
- On-premise access to **Amazon FSx for Windows File Server**
- Windows-native compatibility (NTFS, ACLs, shadow copies)
- SMB protocol
- **Use Case:** Windows-based business applications, user/group file shares

#### 3. Tape Gateway
- Virtual **tape library (VTL)** using iSCSI protocol
- Continue using existing **backup applications** (Veeam, NetBackup, etc.)
- Virtual tapes stored in **Amazon S3**
- Up to 1 PB of virtual tapes per gateway
- **Use Case:** Replace physical tape libraries with virtual tapes in cloud

#### 4. Volume Gateway
- Block storage volumes via **iSCSI** protocol
- Two modes:
  - **Cached volumes:** Primary data in S3, frequently accessed data cached on-premise
  - **Stored volumes:** Primary data on-premise, asynchronously backed up to S3 as EBS snapshots
- **Use Case:** Hybrid storage, backup on-premise data to cloud

---

## 20. CloudTrail, AWS Config & CloudFormation

### 🔍 AWS CloudTrail

CloudTrail records **all API calls** made in your AWS account — who did what, when, from where.

**What CloudTrail Captures:**
1. **Metadata** around API calls
2. **Identity** of the API caller (IAM user, role, account)
3. **Time** of the API call
4. **Source IP address** of the caller
5. **Request parameters**
6. **Response elements** returned by service

---

### 📋 CloudTrail Event Types

| Type | Description | Examples |
|---|---|---|
| **Management Events** | Control plane operations | Creating EC2, IAM, VPC changes |
| **Data Events** | Data plane operations | S3 object reads/writes, DynamoDB operations, Lambda invocations |
| **Insight Events** | Unusual activity detection | Sudden spike in API calls |

---

### ⏰ CloudTrail Retention

- **Default:** Last **90 days** visible in CloudTrail console (no configuration needed)
- **For longer retention:** Create a Trail → Store logs in S3 bucket

**Trail Setup:**
1. CloudTrail → Create Trail
2. Trail name
3. Select event types (Management events: All/Read/Write/None)
4. Enable for all accounts in organization (if AWS Organizations)
5. Configure S3 bucket for log storage
6. Optional: Enable log file integrity validation

**Log File Integrity Validation:** Detect if a log file was modified, deleted, or unchanged after CloudTrail delivered it.

> **🔐 Security Best Practice:** Enable CloudTrail in ALL regions. Enable log file integrity validation. Send CloudTrail logs to a centralized, separate S3 bucket with access logging enabled. Set up CloudWatch alarms for suspicious activity (root login, IAM policy changes, security group changes).

---

### 🔧 AWS Config

AWS Config continuously **monitors and records AWS resource configurations** and evaluates them against desired rules.

**What Config Does:**
- Discovers existing and deleted AWS resources
- Provides complete configuration history
- Determines compliance against rules
- Enables security analysis, change tracking, troubleshooting

**Config Provides:**
| Feature | Description |
|---|---|
| Resource Type | What kind of resource |
| Resource ID | Unique identifier |
| Compliance | Is it following your rules |
| Timeline | Configuration changes over time |
| Relationships | How resources relate to each other |
| CloudTrail Events | API calls related to this resource |

---

### ⚙️ AWS Config Setup

1. AWS Config → Get Started (first time)
2. Select resource types to record (all or specific)
3. Optionally include IAM and global resources
4. Configure S3 bucket for logs
5. Optional: Select managed rules to evaluate
6. Review → Confirm

**Config Rules Examples:**
- EC2 instances must have detailed monitoring enabled
- S3 buckets must not allow public read access
- All EBS volumes must be encrypted
- IAM passwords must meet complexity requirements
- MFA must be enabled for root account

> **💼 Production Use Case:** Config is essential for compliance frameworks (PCI-DSS, HIPAA, SOC2). It provides evidence that your infrastructure meets required standards by showing configuration history and compliance status.

---

### 🏗️ AWS CloudFormation

Infrastructure as Code (IaC) — define your entire AWS infrastructure in JSON or YAML templates.

**Key Concepts:**
| Concept | Description |
|---|---|
| **Template** | JSON or YAML file describing AWS resources |
| **Stack** | A collection of AWS resources created from a template |
| **Change Set** | Preview of changes before applying |

**Benefits:**
- **Repeatability** — Deploy same infrastructure multiple times identically
- **Version Control** — Store templates in Git
- **Automated** — No human error in resource creation
- **Cost** — Easy to create and delete entire environments

**Use Cases:**
1. **Quickly launch new test environments** — No disruption to existing environments
2. **Reliably replicate configuration** — Eliminate human error
3. **Multi-region deployments** — Single template, deploy anywhere

**Simple CloudFormation Template (YAML):**
```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: 'Simple EC2 Web Server'
Resources:
  MyEC2Instance:
    Type: 'AWS::EC2::Instance'
    Properties:
      InstanceType: t2.micro
      ImageId: ami-0abcdef1234567890
      Tags:
        - Key: Name
          Value: WebServer
      UserData:
        Fn::Base64: |
          #!/bin/bash
          yum install httpd -y
          service httpd start
          chkconfig httpd on
```

> **💼 DevOps Best Practice:** Never create production infrastructure manually. Use CloudFormation (or Terraform) for everything. This enables disaster recovery — if entire environment is lost, redeploy from template in minutes.

---

## 21. Trusted Advisor & Well-Architected Framework

### 🔍 AWS Trusted Advisor

Online tool that analyzes your AWS environment and provides **recommendations** to improve it.

**Five Recommendation Categories:**

| Category | What It Checks | Example |
|---|---|---|
| **Cost Optimization** 💰 | Unused/underutilized resources | Idle EC2 instances, unattached EBS volumes |
| **Performance** ⚡ | Resource utilization efficiency | EC2 instances with high utilization, EBS throughput |
| **Security** 🔐 | Security vulnerabilities | Open S3 buckets, weak IAM passwords, root MFA |
| **Fault Tolerance** 🛡️ | Redundancy and availability | Instances not in multiple AZs, no RDS backups |
| **Service Limits** 📊 | Service limit utilization | Approaching EC2 or VPC limits |

**Color Coding:**
| Color | Meaning |
|---|---|
| 🟢 Green | No problem detected |
| 🟡 Yellow | Investigation recommended |
| 🔴 Red | Action recommended immediately |

**Access by Support Plan:**
- **Basic/Developer:** 6 core security checks only
- **Business/Enterprise:** All 50+ checks with full recommendations

> **💰 Cost Optimization Tip:** Run Trusted Advisor monthly. It regularly finds idle resources, unused Reserved Instances, and over-provisioned resources that are costing money unnecessarily.

---

### 🏛️ AWS Well-Architected Framework

AWS's set of best practices for building **stable, efficient, and secure** cloud architectures.

**Five Pillars:**

#### 1. Operational Excellence ⚙️
- Operate and monitor systems to deliver business value
- Continually improve processes
- Key topics: automation of changes, responding to events, operations standards
- Practices: Use CloudFormation, CloudTrail, CI/CD pipelines

#### 2. Security 🔐
- Protect information and systems
- Confidentiality, integrity, availability
- Key topics: IAM, data encryption, network controls, incident detection
- Practices: MFA everywhere, encrypt all data, least privilege access, enable CloudTrail

#### 3. Reliability 🛡️
- Ability to recover from failures quickly
- Meet business demand
- Key topics: Multi-AZ, Auto Scaling, backups, chaos engineering
- Practices: Multiple AZs, auto-healing with ASG, regular backup testing

#### 4. Performance Efficiency ⚡
- Use computing resources efficiently
- Right-sizing, monitoring, adapting
- Key topics: selecting right resource types, monitoring performance
- Practices: Use appropriate instance types, CloudWatch monitoring, cache with ElastiCache

#### 5. Cost Optimization 💰
- Avoid unnecessary costs
- Right-size, measure ROI
- Key topics: understanding costs, right-sizing, reserved capacity
- Practices: Reserved Instances for predictable workloads, Spot for batch, S3 lifecycle policies, terminate unused resources

> **🎯 Interview Tip:** The 5 pillars of Well-Architected Framework (OSRPC) is extremely common in AWS Solutions Architect interviews. Know each pillar with at least one example.

---

## 22. Security — Shared Responsibility Model

### 🔒 AWS Shared Responsibility Model

Security is a **shared responsibility** between AWS and the customer.

```
┌─────────────────────────────────────────────────────┐
│                   CUSTOMER                           │
│    "Security IN the Cloud"                          │
│                                                     │
│  • Customer Data                                    │
│  • Platform, Applications, Identity & Access Mgmt  │
│  • Operating System, Network & Firewall Config      │
│  • Client-side Data Encryption                      │
│  • Server-side Encryption (File system / Data)      │
│  • Network Traffic Protection (Encryption / Auth)  │
├─────────────────────────────────────────────────────┤
│                    AWS                               │
│    "Security OF the Cloud"                          │
│                                                     │
│  • Hardware / AWS Global Infrastructure             │
│  • Regions, AZs, Edge Locations                    │
│  • Compute, Storage, Database, Networking services  │
└─────────────────────────────────────────────────────┘
```

---

### 🔐 What AWS Manages:
- Physical security of data centers
- Hardware infrastructure (servers, storage, networking)
- Virtualization layer
- Global infrastructure (Regions, AZs, Edge Locations)
- Managed service security (RDS patching, Lambda runtime)

### 🛡️ What Customer Manages:
- **IaaS (EC2):** OS patching, application security, network config, IAM, data encryption, Security Groups
- **PaaS (RDS):** OS managed by AWS, but DB config, IAM, encryption, network are customer responsibility
- **SaaS (S3):** Bucket policies, encryption, data classification, IAM

---

### 🎯 Complete Security Best Practices Summary

```
IAM:
✅ Enable MFA everywhere
✅ Rotate access keys every 90 days
✅ Use IAM Roles for EC2, never Access Keys
✅ Principle of Least Privilege
✅ Remove unused IAM users and access keys

EC2:
✅ Keep OS patched and up-to-date
✅ Use Security Groups as restrictive as possible
✅ Use key pairs — never share private keys
✅ Use Bastion hosts for SSH access
✅ Enable detailed monitoring

S3:
✅ Block all public access by default
✅ Enable server-side encryption
✅ Enable versioning for important buckets
✅ Enable access logging
✅ Use bucket policies to restrict access

Network:
✅ Keep databases in private subnets
✅ Use NACLs as additional layer
✅ Enable VPC Flow Logs
✅ Use NAT Gateway (not NAT Instance)
✅ Enable AWS Shield for DDoS protection

Monitoring:
✅ Enable CloudTrail in all regions
✅ Enable AWS Config
✅ Set up billing alerts
✅ Enable GuardDuty for threat detection
✅ Regular Trusted Advisor reviews
```

---

## 🎯 Complete Interview Question Bank

### Cloud Computing & AWS Basics
| Question | Key Answer Points |
|---|---|
| What are the 6 advantages of cloud? | Trade CAPEX/OPEX, economies of scale, stop guessing capacity, increase agility, stop running DCs, go global |
| What's the difference between Region, AZ, Edge Location? | Region = geographic area, AZ = physical DC, Edge Location = CDN cache |
| What is the difference between IaaS, PaaS, SaaS? | Level of management responsibility |

### IAM
| Question | Key Answer Points |
|---|---|
| Why not use Root user? | Full unrestricted access — too dangerous for daily use |
| Difference between IAM User, Group, Role? | User=person, Group=collection of users, Role=permissions for services |
| Why use IAM Roles over Access Keys on EC2? | Temporary credentials, auto-rotated, no keys stored |

### S3
| Question | Key Answer Points |
|---|---|
| What is S3 storage class best for archiving? | Glacier or Glacier Deep Archive |
| What happens when you delete a versioned object? | Delete Marker added — object not really deleted |
| CRR vs SRR? | CRR = different regions, SRR = same region |
| WORM in S3? | Object Lock with Compliance mode |

### EC2
| Question | Key Answer Points |
|---|---|
| On-Demand vs Reserved vs Spot? | Flexibility vs cost savings vs interruption tolerance |
| EBS vs Instance Store? | Persistent vs ephemeral/temporary |
| What is AMI? | Template defining OS + software for new instances |
| What are Placement Groups? | Cluster (low latency), Partition, Spread |

### VPC
| Question | Key Answer Points |
|---|---|
| Security Group vs NACL? | SG=stateful, instance-level, allow-only. NACL=stateless, subnet-level, allow+deny |
| NAT Instance vs NAT Gateway? | NAT GW = managed, scalable, HA, no OS. NAT Instance = manual, limited |
| What is VPC Peering? | Direct connection between VPCs, no transitive peering |
| Public vs Private Subnet? | Public has IGW route, private doesn't |

### High Availability & Scaling
| Question | Key Answer Points |
|---|---|
| Multi-AZ vs Read Replica? | Multi-AZ = HA/DR (synchronous), Read Replica = performance/scaling (asynchronous) |
| How does Auto Scaling work? | Launch Template + ASG + Scaling Policies |
| What is ELB health check? | ELB periodically checks instances, routes only to healthy ones |

### Databases
| Question | Key Answer Points |
|---|---|
| When to use DynamoDB vs RDS? | DynamoDB=NoSQL, scale, flexible. RDS=SQL, ACID, complex queries |
| What is ElastiCache? | In-memory cache (Memcached/Redis) to reduce DB load |
| Aurora vs MySQL RDS? | Aurora = up to 5x faster, 6 copies across 3 AZs, self-healing |

### Security
| Question | Key Answer Points |
|---|---|
| Shared Responsibility Model? | AWS = infrastructure security, Customer = data + app security |
| 5 pillars of Well-Architected Framework? | Operational Excellence, Security, Reliability, Performance, Cost |
| What is CloudTrail? | Records all API calls for audit/governance |

---

## 💰 Complete Cost Optimization Tips

```
EC2 Cost Savings:
💰 Use Reserved Instances for predictable 24/7 workloads (save 40-75%)
💰 Use Spot Instances for batch/fault-tolerant workloads (save 70-90%)
💰 Right-size instances using CloudWatch metrics
💰 Use Auto Scaling to avoid over-provisioning
💰 Stop non-production instances after hours

S3 Cost Savings:
💰 Implement Lifecycle Policies to move to cheaper storage classes
💰 Delete incomplete multipart uploads
💰 Use S3 Intelligent-Tiering for unpredictable access patterns
💰 Enable compression for stored files

Database Cost Savings:
💰 Use RDS Reserved Instances for production databases
💰 Use ElastiCache to reduce RDS read load
💰 Delete unused RDS snapshots
💰 Use Aurora Serverless for variable/unpredictable workloads

Network Cost Savings:
💰 Use CloudFront to reduce data transfer costs
💰 Keep data in same region/AZ to avoid cross-AZ charges
💰 Use VPC Endpoints to avoid NAT Gateway charges for S3/DynamoDB access

Monitoring:
💰 Set up AWS Budgets with email alerts
💰 Use AWS Cost Explorer to analyze spending trends
💰 Run AWS Trusted Advisor regularly
💰 Tag ALL resources for cost allocation tracking
```

---

> 📘 **Final Note:** AWS is a vast platform that keeps evolving. These notes cover all topics from the provided material. The best way to master AWS is through **hands-on practice** in the AWS Console, combining reading with actual deployment. Start with the free tier, build the architectures described here, break things intentionally, and fix them. That's how real DevOps engineers learn AWS.
