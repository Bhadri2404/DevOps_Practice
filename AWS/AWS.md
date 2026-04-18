# 🌩️ AWS Complete Notes — Senior Solutions Architect & DevOps Edition

> **Based on:** Avinash Thipparthi's AWS Study Material
> **Style:** Beginner-friendly, Interview-ready, Real-world DevOps Production Scenarios

---

# 📋 TABLE OF CONTENTS

1. [Introduction to Cloud Computing](#1-️-introduction-to-cloud-computing)
2. [IAM — Identity and Access Management](#2--iam--identity-and-access-management)
3. [S3 — Simple Storage Service](#3-️-s3--simple-storage-service)
4. [AWS Snowball / Snowball Edge / Snowmobile](#4--aws-snowball--snowball-edge--snowmobile)
5. [AWS Direct Connect](#5--aws-direct-connect)
6. [EC2 — Elastic Compute Cloud](#6--ec2--elastic-compute-cloud)
7. [EBS — Elastic Block Store](#7--ebs--elastic-block-store-volumes--snapshots)
8. [EFS — Elastic File System](#8--efs--elastic-file-system)
9. [Amazon FSx](#9--amazon-fsx)
10. [Amazon Lightsail](#10--amazon-lightsail)
11. [Elastic Beanstalk](#11--elastic-beanstalk)
12. [ELB — Elastic Load Balancing](#12--elb--elastic-load-balancing)
13. [ASG — Auto Scaling Group](#13--asg--auto-scaling-group)
14. [Amazon CloudWatch](#14--amazon-cloudwatch)
15. [Amazon Route 53](#15--amazon-route-53)
16. [VPC — Virtual Private Cloud](#16--vpc--virtual-private-cloud)
17. [Amazon RDS — Relational Database Service](#17--amazon-rds--relational-database-service)
18. [Amazon DynamoDB](#18--amazon-dynamodb)
19. [Amazon Redshift](#19--amazon-redshift)
20. [Amazon ElastiCache](#20--amazon-elasticache)
21. [Amazon SQS — Simple Queue Service](#21--amazon-sqs--simple-queue-service)
22. [Amazon SNS — Simple Notification Service](#22--amazon-sns--simple-notification-service)
23. [Amazon CloudFront](#23--amazon-cloudfront)
24. [AWS Global Accelerator](#24--aws-global-accelerator)
25. [AWS Storage Gateway](#25--aws-storage-gateway)
26. [AWS CloudTrail](#26--aws-cloudtrail)
27. [AWS Config](#27--aws-config)
28. [AWS CloudFormation](#28--aws-cloudformation)
29. [AWS Trusted Advisor](#29--aws-trusted-advisor)
30. [Amazon EMR](#30--amazon-emr)
31. [AWS Data Pipeline](#31--aws-data-pipeline)
32. [AWS Lambda](#32--aws-lambda)
33. [AWS Security & Shared Responsibility Model](#33--aws-security--shared-responsibility-model)
34. [AWS Well-Architected Framework](#34--aws-well-architected-framework)

---

---

# 1. ☁️ Introduction to Cloud Computing

---

## 1.1 What is Cloud Computing?

Cloud Computing is the **on-demand delivery of IT resources** — compute power, storage, databases, networking, and applications — **over the internet with pay-as-you-go pricing**.

Think of it like electricity. You don't build your own power plant to use electricity at home. You simply plug in and pay for what you use. Cloud computing works the same way for IT infrastructure.

---

## 1.2 Key Concepts

### Traditional IT vs Cloud Computing

| Traditional IT | Cloud Computing |
|---|---|
| Buy hardware upfront | Pay only for what you use |
| Weeks to provision servers | Provision in minutes |
| You manage data centers | Cloud provider manages infrastructure |
| Fixed capacity | Scales up/down on demand |
| High capital expense | Variable operating expense |

---

## 1.3 Six Advantages of Cloud Computing (Amazon's Model)

### 1. Trade Capital Expense for Variable Expense
Instead of spending millions on data centers before knowing your needs, you **pay only when you consume** and only for what you use.

**Real-world example:** A startup doesn't need to buy 100 servers hoping their app goes viral. They start with 2 servers and add more only when users grow.

### 2. Benefit from Massive Economies of Scale
AWS serves millions of customers. This massive scale allows AWS to offer **lower prices** than any single company could achieve on their own.

### 3. Stop Guessing Capacity
In traditional IT, you'd either over-provision (waste money on idle servers) or under-provision (your app crashes during peak traffic). Cloud eliminates this guessing — you **scale up or down in minutes**.

### 4. Increase Speed and Agility
New resources are available in **minutes, not weeks**. Developers can experiment and innovate faster because the cost and time of failure is dramatically reduced.

### 5. Stop Spending Money on Data Centers
Stop racking, stacking, and powering physical servers. **Focus on your customers and applications**, not infrastructure.

### 6. Go Global in Minutes
Deploy your application to multiple AWS Regions worldwide with just a few clicks. Give your global customers **low-latency access** to your application at minimal cost.

---

## 1.4 NIST Definition of Cloud Computing

The **National Institute of Standards and Technology (NIST)** defines cloud computing with **5 Essential Characteristics**:

| Characteristic | Simple Explanation |
|---|---|
| **On-demand self-service** | Provision resources without human interaction with the provider |
| **Broad network access** | Access from laptops, phones, tablets via internet |
| **Resource pooling** | Provider serves multiple customers from shared infrastructure (multi-tenant) |
| **Rapid elasticity** | Scale up or down automatically and instantly |
| **Measured service** | Pay only for what you use — usage is monitored and reported |

---

## 1.5 Cloud Service Models

### 🔵 IaaS — Infrastructure as a Service
**You get:** Virtual machines, storage, networking
**You manage:** OS, applications, security patches
**AWS Example:** EC2, EBS, VPC

Think of IaaS like **renting a plot of land.** You own the building you build on it.

### 🟡 PaaS — Platform as a Service
**You get:** A platform to deploy your code
**You manage:** Only your application and data
**AWS Example:** Elastic Beanstalk, RDS

Think of PaaS like **renting a furnished office.** You just bring your laptop and work.

### 🟢 SaaS — Software as a Service
**You get:** A ready-to-use application
**You manage:** Nothing technical
**AWS Example:** Gmail, Salesforce, Dropbox

Think of SaaS like **renting a hotel room.** Everything is already set up.

---

## 1.6 Cloud Deployment Models

| Model | Description | Who Uses It |
|---|---|---|
| **Public Cloud** | Resources shared among all customers over internet | Startups, general businesses |
| **Private Cloud** | Dedicated infrastructure for one organization | Banks, government |
| **Community Cloud** | Shared among organizations with similar concerns | Healthcare consortiums |
| **Hybrid Cloud** | Mix of public + private, interconnected | Enterprises with compliance needs |

---

## 1.7 AWS Global Infrastructure

AWS organizes its global infrastructure into **Regions**, **Availability Zones**, and **Edge Locations**.

### Region
A **Region** is a **geographic area** containing multiple, isolated data centers.
- Example: `us-east-1` (US East - N. Virginia), `ap-south-1` (Asia Pacific - Mumbai)
- Each Region is completely independent from others
- You choose a Region based on: latency to users, compliance requirements, cost

### Availability Zone (AZ)
An **Availability Zone** is one or more **physical data centers** within a Region.
- Each AZ has its own independent power, cooling, and networking
- AZs are connected to each other with **low-latency, high-bandwidth links**
- Think of AZs as **floors of a building** — if one floor has a fire, others continue functioning
- Each Region has a **minimum of 2 AZs**

### Edge Locations
**Edge Locations** are **CDN (Content Delivery Network) endpoints** for Amazon CloudFront.
- Spread across **most major cities** worldwide
- Cache copies of your content close to end users
- Reduce latency for users far from your main data center
- There are **more Edge Locations than Regions**

---

## 1.8 Real-Time Production Scenario — Global Application Deployment

**Application:** E-commerce website (like Flipkart)

**Architecture Flow:**
```
Users (India, USA, Europe)
        ↓
CloudFront Edge Locations (nearest city) — serves cached static content
        ↓
Route 53 (DNS routing based on latency) — directs to nearest region
        ↓
Mumbai Region (ap-south-1) — Primary
        ↓
Load Balancer → EC2 Instances (AZ-1a, AZ-1b, AZ-1c)
        ↓
RDS Multi-AZ Database (Active in AZ-1a, Standby in AZ-1b)
```

**Why Multiple AZs?** If the data center in Mumbai (AZ-a) goes down, the application automatically continues from Mumbai (AZ-b). Users experience zero downtime.

---

## 1.9 Summary

Cloud computing gives you on-demand IT resources over the internet. AWS is the world's largest cloud provider, with data centers organized into Regions (geographic areas), Availability Zones (individual data centers), and Edge Locations (CDN points). The three service models — IaaS, PaaS, SaaS — define how much control you have versus how much AWS manages for you.

---
---

# 2. 🔐 IAM — Identity and Access Management

---

## 2.1 What is IAM?

**IAM (Identity and Access Management)** is the AWS service that controls **who can access your AWS account** and **what they can do** with AWS resources.

Think of IAM like a **security badge system** in a large office building. Different employees have different access levels — the CEO can enter all rooms, a junior developer can only access the development floor, and a contractor can only access the meeting room.

---

## 2.2 Key Concepts

### Root User
When you first create an AWS account, you get a **Root User** — it has **complete, unrestricted access** to everything in your account including billing.

⚠️ **Critical Rule:** **Never use the Root User for daily tasks.** Create IAM users instead. Use Root only for account-level tasks like changing billing info or closing the account.

### IAM Users
An IAM User represents a **person or application** that interacts with AWS.
- Each user has a unique username within the AWS account
- By default, users have **NO permissions** — you must explicitly grant them
- Users get access via:
  - **Programmatic Access** — Access Key ID + Secret Access Key (for CLI, SDK, APIs)
  - **AWS Management Console Access** — Username + Password (for browser)

### IAM Groups
A Group is a **collection of IAM users**.
- Assign policies to the group, and all users in the group inherit those permissions
- Example: Create a "Developers" group with EC2 and S3 access. Add all developers to this group — they all get the same permissions automatically
- Permissions are managed at **group level**, not user level — much easier to administer

### IAM Policies
A Policy is a **JSON document** that defines what actions are allowed or denied on which AWS resources.

```
Example Policy Structure:
- Effect:    Allow or Deny
- Action:    What to do (e.g., s3:GetObject, ec2:StartInstances)
- Resource:  Which resource (e.g., specific S3 bucket ARN)
- Principal: Who this applies to (used in resource-based policies)
```

### Key Managed Policies to Know

| Policy | What it Does |
|---|---|
| **AdministratorAccess** | Full access to all AWS services except billing/account management. Can create/delete IAM users and groups |
| **PowerUserAccess** | Full access to AWS services but CANNOT manage IAM users, groups, or roles |
| **ReadOnlyAccess** | View everything but cannot create, modify, or delete anything |

### IAM Roles
A Role is like a **temporary identity** that AWS services (or users) can assume to get permissions.

**Key difference from users:** Roles don't have permanent long-term credentials. They issue **temporary security credentials** that automatically rotate.

**Most common use cases:**
- Give an EC2 instance permission to access S3 without storing Access Keys on the server
- Allow Lambda functions to write to DynamoDB
- Cross-account access between two AWS accounts

### MFA — Multi-Factor Authentication
MFA adds a **second layer of security** — even if someone steals your password, they still can't log in without your physical MFA device.

---

## 2.3 How IAM Works — Step by Step

```
Step 1: Create IAM Group (e.g., "Administrators")
         ↓
Step 2: Attach Policy to Group (e.g., AdministratorAccess)
         ↓
Step 3: Create IAM User (e.g., "john.doe")
         ↓
Step 4: Add User to Group → User inherits Group permissions
         ↓
Step 5: User logs in via IAM Sign-In URL with username + password
         ↓
Step 6: User can only perform actions allowed by the attached policy
```

---

## 2.4 IAM Sign-In URL

Every AWS account gets a unique IAM sign-in URL:
```
Default:  https://123456789012.signin.aws.amazon.com/console
Alias:    https://mycompanyname.signin.aws.amazon.com/console
```
The alias name must be **globally unique** and makes it easier for your team to remember.

---

## 2.5 Password Policy

You can enforce password complexity rules for all IAM users:
- Minimum password length
- Require uppercase/lowercase letters, numbers, and special characters
- Password expiry period (force users to change regularly)
- Prevent password reuse
- Allow/prevent users from changing their own password

---

## 2.6 Custom IAM Policies

If built-in managed policies don't meet your needs, create a **custom policy** using the Visual Editor or JSON.

**Example Custom Policy Use Case:**
You want a support engineer to only **view EC2 instance information** but not be able to start, stop, or terminate instances.

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
This user can **see** EC2 instances but cannot perform any operations on them.

---

## 2.7 IAM Roles for EC2 — The Secure Way

**Problem:** Your EC2 application needs to upload files to S3.

**Wrong Way:** Store Access Keys directly in the application or on the server.
- If someone hacks the server, they steal your AWS credentials
- Credentials don't auto-rotate — a security risk

**Right Way:** Create an IAM Role with S3 permissions and attach it to the EC2 instance.

```
EC2 Instance
    → Assumes IAM Role (e.g., "EC2-S3-UploadRole")
    → Gets Temporary Credentials (auto-rotate every few hours)
    → Securely uploads files to S3
    → No Access Keys stored anywhere
```

**Key benefits of Roles:**
- More secure than static credentials
- Credentials automatically rotate
- Easy to attach or detach from running instances
- Roles are universal — work across all regions

---

## 2.8 Instance Metadata — Accessing Role Credentials

When an EC2 instance has a Role attached, you can query the temporary credentials via the **metadata endpoint**:
```
curl http://169.254.169.254/latest/meta-data/
curl http://169.254.169.254/latest/user-data/
```
This endpoint is only accessible from within the EC2 instance itself — not from the internet.

---

## 2.9 Integration with Other AWS Services

| AWS Service | IAM Integration |
|---|---|
| **EC2** | Attach roles to instances for service access |
| **S3** | Bucket policies work alongside IAM to control access |
| **Lambda** | Execution roles allow Lambda to access DynamoDB, S3, SNS |
| **CloudTrail** | Logs every IAM API call for auditing and compliance |
| **CloudWatch** | Monitor and alert on IAM-related events |
| **RDS** | IAM DB Authentication allows IAM users to log into databases |

---

## 2.10 Real-Time DevOps Production Scenario

**Application:** A multi-team microservices application running on AWS

**Team Structure and IAM Setup:**

```
Root Account
├── IAM Group: "Administrators"
│     Policy: AdministratorAccess
│     Users: CTO, Lead Architect
│
├── IAM Group: "DevOps-Engineers"
│     Policy: EC2FullAccess + S3FullAccess + CloudWatchFullAccess
│     Users: devops1, devops2, devops3
│
├── IAM Group: "Developers"
│     Policy: EC2ReadOnly + S3ReadOnly + CodeCommitFullAccess
│     Users: dev1, dev2, dev3, dev4
│
├── IAM Group: "DBA-Team"
│     Policy: RDSFullAccess + ReadOnly on EC2
│     Users: dba1, dba2
│
└── IAM User: "jenkins-cicd" (Programmatic Access Only)
      Policy: Custom policy — ECR push, ECS deploy, S3 artifact upload
```

**EC2 Instance Roles:**
```
Web Server EC2  → Role: "WebAppRole"   → S3 read + SES send email
Worker EC2      → Role: "WorkerRole"   → SQS consume + DynamoDB write + S3 read
Bastion Host    → Role: "BastionRole"  → EC2 describe only (minimal permissions)
```

**Security Practices Applied:**
1. Root account MFA enabled — credentials stored in company safe
2. All human users have MFA enabled
3. Password policy: 12 chars minimum, expiry every 90 days
4. EC2 instances use Roles — zero stored credentials on servers
5. CloudTrail enabled — every API call logged to S3 for 1 year
6. IAM Access Analyzer runs weekly — alerts on overly permissive policies

**Monitoring Approach:**
- CloudTrail + CloudWatch Events: Alert when Root user logs in
- Alert when any IAM policy is modified
- Alert when MFA is disabled on any account

---

## 2.11 Benefits

- **Centralized access control** — Manage all permissions from one place
- **Fine-grained permissions** — Control access at individual resource level
- **No additional charge** — IAM is completely free
- **MFA support** — Extra security layer for sensitive accounts
- **Role-based security** — No credential management for AWS services
- **Universal service** — IAM is global, not region-specific
- **Audit trail** — All IAM actions logged via CloudTrail

---

## 2.12 Common Use Cases

- Creating individual user accounts for development, operations, and admin teams
- Giving EC2 instances access to S3, DynamoDB, SQS without storing keys
- Cross-account access (allow one AWS account to access resources in another)
- Federated access — allow corporate Active Directory / Google Workspace users to log into AWS via SSO
- CI/CD pipeline permissions — give Jenkins/GitLab just enough access to deploy

---

## 2.13 Summary

IAM is the security gatekeeper of your AWS account. Use it to create users, groups, roles, and policies to precisely control who can do what with your AWS resources. Always follow the **principle of least privilege** — give users and services only the minimum permissions they absolutely need. Use Roles for EC2 and other services instead of storing static Access Keys. Enable MFA on root and all admin accounts. Think of IAM as the foundation of all AWS security.

---
---

# 3. 🗄️ S3 — Simple Storage Service

---

## 3.1 What is S3?

**Amazon S3 (Simple Storage Service)** is AWS's **object storage service** — it's like a giant, infinitely scalable hard drive in the cloud where you can store any type of file.

Think of S3 like **Google Drive or Dropbox**, but designed for developers and enterprises — highly durable, globally accessible, and deeply integrated with every AWS service.

Unlike a traditional file system (which organizes files in folders on a disk), S3 is **object-based storage** where each file is stored as an independent object with its own unique URL, accessible from anywhere on the internet.

---

## 3.2 Key Concepts

### Buckets
A **Bucket** is the top-level container for your files in S3 — similar to a root folder.
- Bucket names must be **globally unique** across all AWS accounts worldwide
- You can have up to **100 buckets per account** (soft limit, can be increased via support ticket)
- Buckets exist in a **specific AWS Region** — data physically lives there
- **Naming rules:**
  - 3–63 characters long
  - Lowercase letters, numbers, and hyphens only
  - Cannot start or end with a period
  - Cannot be formatted as an IP address (e.g., 192.168.1.1)
  - Cannot start or end with a period or contain consecutive periods

### Objects
An **Object** is a file stored in S3 — it can be images, videos, documents, backups, logs, anything.
- Size ranges from **0 bytes to 5 TB** per object
- A single bucket can store an **unlimited number of objects**
- Each object has a unique **key** (the file path/name within the bucket)

### Object URL Format
```
Path Style:
https://s3-ap-south-1.amazonaws.com/mycompanybucket/uploads/profile.jpg

Virtual Hosted Style:
https://mycompanybucket.s3.amazonaws.com/uploads/profile.jpg
```

---

## 3.3 S3 Storage Classes

S3 offers multiple storage classes. Choose based on **how often you access data** and **how fast you need it retrieved**:

### 🔵 S3 Standard
| Property | Value |
|---|---|
| Availability | 99.99% |
| Durability | 99.999999999% (11 nines) |
| Stored across | Minimum 3 AZs |
| Retrieval | Milliseconds |
| Best for | Active website files, app content, analytics |

### 🟡 S3 Intelligent-Tiering
- AWS **automatically moves** objects between Frequent Access and Infrequent Access tiers
- No retrieval charges, small monitoring fee per object
- **Best for:** Data with unpredictable access patterns (e.g., archive files that might be needed occasionally)

### 🟠 S3 Standard-IA (Infrequently Accessed)
- **Lower storage cost** than Standard but a **retrieval fee** applies
- Minimum object size: **128 KB** | Minimum storage duration: **30 days**
- **Best for:** Backups, older log files, disaster recovery data

### 🟠 S3 One Zone-IA
- Same as Standard-IA but stored in **only 1 AZ**
- **20% cheaper** than Standard-IA
- ⚠️ **Risk:** If that AZ is destroyed, data is lost permanently
- **Best for:** Re-creatable secondary backups or data already replicated elsewhere

### 🔴 S3 Glacier
- **Very low cost**, designed for **archival data**
- **Retrieval time:** 3–5 hours
- Key terms: **Archives** (individual files, up to 40 TB) stored in **Vaults** (containers)
- AWS allows **free retrieval of up to 5%** of your stored Glacier data per month
- **Best for:** Financial records, compliance archives, old log data

### 🔴 S3 Glacier Deep Archive
- **Cheapest storage class in all of AWS**
- **Retrieval time:** Up to 12 hours
- Data stored across **3+ AZs**
- **Best for:** Long-term regulatory compliance data (7–10+ years), data accessed maybe once a year

### Storage Class Comparison

| Storage Class | Availability | Durability | Min Duration | Retrieval Time | Best For |
|---|---|---|---|---|---|
| Standard | 99.99% | 11 nines | None | Milliseconds | Active data |
| Intelligent-Tiering | 99.9% | 11 nines | None | Milliseconds | Unknown patterns |
| Standard-IA | 99.9% | 11 nines | 30 days | Milliseconds | Infrequent access |
| One Zone-IA | 99.5% | 11 nines* | 30 days | Milliseconds | Re-creatable data |
| Glacier | 99.99% | 11 nines | 90 days | 3–5 hours | Archives |
| Glacier Deep Archive | 99.99% | 11 nines | 180 days | Up to 12 hours | Long-term compliance |

*Durability within a single AZ only

---

## 3.4 S3 Durability Explained Simply

**11 nines (99.999999999%) durability** means:
If you store **10 million objects** in S3, you might lose **1 object every 10,000 years**.

AWS achieves this by automatically storing **multiple copies** of every object across **multiple physical devices in multiple facilities** within a Region — completely transparent to you.

---

## 3.5 S3 Key Features In Depth

### 📌 Versioning
Versioning keeps **every version** of every object ever stored in a bucket.

**How it works:**
- Enabled at the bucket level
- Once enabled, **cannot be fully disabled** — only suspended
- Every upload of the same filename creates a **new version** with a unique Version ID
- When you delete a file, S3 adds a **Delete Marker** — the file isn't actually gone
- To **truly restore** a deleted file: delete the Delete Marker
- To **permanently delete** a specific version: explicitly delete that Version ID

**Real-world use:** A developer accidentally overwrites `config.json` with broken code. With versioning, you can restore the previous working version in seconds.

---

### 📌 Lifecycle Management
Automatically **transitions objects between storage classes** based on age, reducing storage costs without any manual work.

**Example Lifecycle Policy for Log Files:**
```
Day 0:   Files uploaded → S3 Standard (active processing)
Day 30:  Automatically move → S3 Standard-IA (still accessible but cheaper)
Day 60:  Automatically move → S3 Glacier (archive)
Day 365: Automatically delete (compliance cleanup)
```

**You can configure:**
- Transitions for **current versions** and **previous versions** separately
- Object expiration (delete after X days)
- Apply to entire bucket or only objects with specific prefixes/tags

---

### 📌 Cross-Region Replication (CRR) & Same-Region Replication (SRR)

**Cross-Region Replication (CRR):**
- Automatically copies **new objects** from source bucket (Region A) to destination bucket (Region B)
- Replication happens **asynchronously** in near real-time
- Requirements: Versioning must be **enabled on both buckets**
- **Use cases:**
  - Disaster recovery (keep a copy in a different geography)
  - Compliance (data must reside in specific countries)
  - Reducing read latency for global users

**Same-Region Replication (SRR):**
- Both source and destination buckets are in the **same region**
- **Use cases:** Aggregating logs from multiple buckets, keeping copies for different teams within the same region

**Important notes:**
- Existing objects in the bucket are **NOT replicated automatically** — only new objects after replication is enabled
- Delete markers are **NOT replicated** by default
- You need an **IAM role** that grants S3 permission to replicate on your behalf

---

### 📌 Static Website Hosting
Host a complete static website (HTML, CSS, JavaScript, images) directly from S3 — no web server needed.

**Steps:**
1. Create a bucket with the same name as your domain (e.g., `www.mywebsite.com`)
2. Upload `index.html` and `error.html`
3. Make all files public
4. Enable Static Website Hosting in bucket Properties
5. Website URL format: `<bucket-name>.s3-website-<region>.amazonaws.com`
6. Create a DNS record in Route 53 pointing your domain to this URL

**Best for:** Landing pages, documentation sites, single-page applications (React/Angular builds)

---

### 📌 S3 Object Lock
Prevents objects from being **deleted or overwritten** for a fixed period or indefinitely. Designed for **WORM (Write Once Read Many)** compliance requirements.

**Two retention modes:**
- **Governance Mode:** Can be overridden by users with specific IAM permissions
- **Compliance Mode:** **Cannot be overridden by anyone** — including the root account. Once set, it's locked.

**Two protection methods:**
- **Retention Period:** Lock object for a specified number of days
- **Legal Hold:** Lock indefinitely until you explicitly remove the hold

**Requirements:**
- Object Lock must be enabled **at bucket creation** — cannot be added later
- Versioning must be enabled

**Real-world use:** Financial institutions, healthcare, and government agencies that must retain records for 7+ years and prove they haven't been tampered with.

---

### 📌 S3 Encryption

**Three types of Server-Side Encryption:**

| Type | Key Management | Who Controls Keys |
|---|---|---|
| **SSE-S3** (AWS-Managed Keys) | AWS manages everything | AWS |
| **SSE-KMS** (AWS KMS Keys) | AWS Key Management Service | You control via KMS |
| **SSE-C** (Customer-Provided Keys) | You provide the key with each request | Fully you |

**Client-Side Encryption:** You encrypt data before sending it to S3. You manage the entire encryption/decryption process.

**In-Transit Encryption:** Use HTTPS (SSL/TLS) endpoints to encrypt data while it travels over the network.

---

### 📌 Bucket Policies
JSON-based access policies attached directly to a bucket to control who can access it.

**Key elements:**
- **Effect:** Allow or Deny
- **Principal:** Who the policy applies to (IAM user, role, or `*` for everyone)
- **Action:** What S3 operations (e.g., `s3:GetObject`, `s3:PutObject`)
- **Resource:** Which bucket and objects (identified by ARN)

**Use case:** Make all objects in a bucket publicly readable for a static website, or block all public access to a sensitive data bucket.

---

### 📌 S3 Transfer Acceleration
Uses **Amazon CloudFront's globally distributed Edge Locations** to speed up file uploads from distant locations.

**How it works:**
```
User in Germany → Uploads file to Frankfurt Edge Location (fast local network)
                → AWS backbone network transfers file to S3 bucket in Mumbai (optimized AWS network)
```
Instead of fighting slow international internet connections, you use the fast AWS global network backbone.

**Additional cost:** Extra data transfer charges apply. Use the AWS **Speed Comparison Tool** to verify it's worth it for your use case.

---

### 📌 S3 Event Notifications
Trigger automatic actions when specific events happen in your S3 bucket.

**Supported events:** Object created, deleted, restored from Glacier, replication failed

**Destinations:**
- **Amazon SNS** — Send email/SMS notifications
- **Amazon SQS** — Queue the event for processing
- **AWS Lambda** — Run code automatically in response

**Real-world use:** When a user uploads a profile photo to S3, automatically trigger a Lambda function to resize the image and create thumbnails, then store them back in S3.

---

### 📌 S3 Requester Pays
By default, the **bucket owner pays** for all storage and data transfer costs.

With Requester Pays enabled, the **person downloading the data pays** for the transfer cost. The bucket owner still pays for storage.

**Use case:** Public datasets — a government agency stores public data but doesn't want to pay for millions of downloads.

---

### 📌 S3 Performance Optimization
S3 can handle very high request rates:
- **3,500 PUT/COPY/POST/DELETE** requests per second per prefix
- **5,500 GET/HEAD** requests per second per prefix

**To scale read performance:** Create **10 prefixes** in a bucket → achieve **55,000 read requests/second**.

A prefix is essentially the folder structure in your object key:
```
/images/2024/profile.jpg   → prefix: /images/2024/
/logs/2024/app.log         → prefix: /logs/2024/
```

---

### 📌 S3 Consistency Model
- **Read-after-Write consistency** for new object uploads — immediately readable after PUT
- **Eventual consistency** for overwrite PUTs and DELETEs — may take a brief moment to propagate

---

### 📌 S3 Intelligent-Tiering Archive Configurations
For objects in Intelligent-Tiering, you can enable additional archive tiers:
- **Archive Access Tier:** Objects not accessed for **90+ days** are moved to Glacier-equivalent storage
- **Deep Archive Access Tier:** Objects not accessed for **180+ days** are moved to Glacier Deep Archive-equivalent storage

---

## 3.6 Integration with Other AWS Services

| Service | Integration |
|---|---|
| **CloudFront** | Serve S3 objects via CDN for low-latency global delivery |
| **Lambda** | Trigger functions on S3 events (upload, delete) |
| **EC2** | Store application data, logs, backups |
| **RDS** | Store automated DB backups and snapshots |
| **CloudTrail** | Log all S3 API calls to S3 for auditing |
| **Athena** | Query S3 data directly using SQL |
| **Glacier** | Lifecycle policies auto-archive S3 data to Glacier |
| **SNS/SQS** | Event-driven notifications on S3 actions |
| **IAM** | Control access to buckets and objects via policies |
| **KMS** | Manage encryption keys for S3 SSE-KMS |

---

## 3.7 Real-Time DevOps Production Scenario

**Application:** A media company's video-on-demand platform (like a streaming service)

**Architecture Flow:**
```
Content Team → Uploads raw video files → S3 Standard bucket (us-east-1)
                    ↓
            S3 Event Notification triggers Lambda
                    ↓
            Lambda starts AWS MediaConvert job
            (transcodes video to multiple resolutions: 1080p, 720p, 480p, 360p)
                    ↓
            Transcoded files stored → S3 Standard (processed-videos bucket)
                    ↓
            CloudFront Distribution created over S3 bucket
                    ↓
            Users worldwide stream video via CloudFront Edge Locations
                    ↓ (as video ages)
            Lifecycle Policy: 
              Day 0–30:    S3 Standard (hot content, trending)
              Day 31–180:  S3 Intelligent-Tiering (less popular content)
              Day 181–365: S3 Standard-IA (older content)
              Day 365+:    S3 Glacier (archived content on request)
```

**Storage Layout:**
```
S3 Buckets:
├── raw-uploads-bucket        (S3 Standard, versioning ON)
├── processed-videos-bucket   (S3 Standard, CloudFront origin, versioning ON)
├── thumbnail-images-bucket   (S3 Standard, public read for website)
├── access-logs-bucket        (S3 Standard-IA, lifecycle to Glacier)
└── compliance-archive-bucket (S3 Glacier Deep Archive, Object Lock ON)
```

**Cross-Region Replication:** Processed videos replicated from `us-east-1` to `ap-south-1` (Mumbai) to reduce playback latency for Indian users.

**Security Setup:**
- All buckets: Block Public Access enabled (except thumbnail bucket)
- All buckets: SSE-S3 encryption at rest
- CloudFront: OAI (Origin Access Identity) so users can ONLY access videos via CloudFront, not directly from S3
- IAM Roles for all services — no static credentials

**Monitoring Approach:**
- S3 Storage Lens: Visualize storage usage, access patterns across all buckets
- CloudWatch: Alert if bucket size exceeds expected threshold (cost control)
- CloudTrail: Log all S3 API calls — who accessed what and when
- S3 Server Access Logging: Detailed request-level logs stored in a separate logging bucket

**Scaling Behavior:**
- S3 scales automatically — no capacity planning needed
- CloudFront handles millions of simultaneous video streams
- Lambda auto-scales for transcoding triggers
- Lifecycle policies automatically reduce costs as content ages

---

## 3.8 Benefits

- **Unlimited scalability** — Store any amount of data, from bytes to petabytes
- **Extremely high durability** — 11 nines = virtually zero data loss
- **Cost flexible** — Multiple storage classes for different access patterns
- **Secure** — Multiple encryption options, IAM integration, bucket policies
- **Versioning** — Protects against accidental deletion or overwrite
- **Event-driven** — Integrates with Lambda, SNS, SQS for automation
- **Global accessibility** — Objects accessible via URL from anywhere
- **No infrastructure to manage** — Fully managed service

---

## 3.9 Common Use Cases

- Static website hosting (single-page apps, documentation)
- Application file storage (user uploads, profile pictures, documents)
- Backup and disaster recovery storage
- Data lakes and big data analytics (store raw data, query with Athena)
- Log archiving and compliance storage
- Software distribution (host installers, patches, packages)
- Media processing pipeline (video/image storage and processing)
- CloudFront origin for content delivery

---

## 3.10 Summary

S3 is AWS's infinitely scalable object storage service. You store files (called objects) in containers (called buckets). S3 is incredibly durable (11 nines), available, and integrates with virtually every AWS service. Use the right storage class to balance cost vs. access speed — Standard for hot data, IA for cold data, and Glacier for archival. Use features like versioning, lifecycle policies, replication, and encryption to build secure, cost-efficient, and resilient storage architectures.

---
---

# 4. 🚛 AWS Snowball / Snowball Edge / Snowmobile

---

## 4.1 What is AWS Snowball?

**AWS Snowball** is a **physical data transfer device** — AWS ships you a ruggedized, secure hardware appliance, you load your data onto it, and ship it back to AWS who then uploads your data to S3.

Think of Snowball like a **super-secure external hard drive** that AWS sends to you. Instead of trying to upload petabytes of data over the internet (which could take weeks or years), you copy data to the physical device and ship it back — much faster.

**The problem it solves:** If you have 100 TB of on-premises data to move to AWS, uploading over a 1 Gbps internet connection would take over **9 days** — and that's with perfect conditions. Snowball lets you do it in days physically.

---

## 4.2 Snowball Family

### 🔵 AWS Snowball (Standard)

**Two device sizes:**
| Device | Capacity | Service Fee |
|---|---|---|
| Snowball 50 TB | 50 TB usable | $200 per job |
| Snowball 80 TB | 80 TB usable | $250 per job |

**Pricing details:**
- First **10 days** of on-site usage: **Free**
- Each additional day: **$15/day**
- Data transfer INTO AWS (S3): **Free**

**How Snowball works:**

```
Step 1: Create a Job in AWS Console
          (specify: Import to S3 or Export from S3, S3 bucket, shipping address)
          ↓
Step 2: AWS ships the Snowball device to your address
          ↓
Step 3: You receive the device, connect it to your network
          ↓
Step 4: Download and run the Snowball Client software on your machine
          ↓
Step 5: Select files/directories to transfer — client encrypts and transfers data to device
          ↓
Step 6: Ship the device back to AWS (shipping label auto-updates)
          ↓
Step 7: AWS uploads your data to the specified S3 bucket
          ↓
Step 8: AWS notifies you via SNS when complete, then securely erases the device
```

**Security:** All data is automatically **encrypted by AWS KMS** — data on the device is protected at rest. An IAM role is required for the copy operation.

**Tracking:** Track the device location and job status via SNS notifications, SMS messages, or directly in the console.

---

### 🟡 AWS Snowball Edge

**What it adds over standard Snowball:**
- **100 TB capacity**
- Has **on-board compute capabilities** (approximately equivalent to an **EC2 m4.4xlarge** instance)
  - **16 vCPUs** and **64 GB RAM**
- Can run **Lambda functions** and **EC2 instances** directly on the device
- Has **S3 and NFS interfaces**

**Use cases:**
- Locations with limited or no internet connectivity (remote sites, ships, oil rigs)
- **Edge computing** — process data locally before sending to AWS
- Run machine learning models in remote locations
- Data collection and local processing in remote environments

---

### 🔴 AWS Snowmobile

**What it is:** An **Exabyte-scale** data transfer service — literally a **45-foot shipping container on a semi-truck**.

| Property | Value |
|---|---|
| Capacity | **100 PB** (100 Petabytes) per Snowmobile |
| Timeline | Move 100 PB in **a few weeks** + transport time |
| Comparison | Moving 100 PB over 1 Gbps connection = **20+ years** |

**How to get one:** Contact AWS Sales directly — this is not a self-service option.
```
https://aws.amazon.com/contact-us/aws-sales/
```

**Real-world use:** A large bank or media company closing an entire data center with 50–100 PB of data.

---

## 4.3 When to Use Each Service

| Amount of Data | Recommended Solution |
|---|---|
| < 1 TB | Internet upload via AWS CLI or S3 Console |
| 1 TB – 10 TB | Snowball (check internet speed first) |
| 10 TB – 80 TB | Snowball |
| 80 TB – 100 TB | Snowball Edge |
| > 100 TB – Petabytes | Multiple Snowball devices |
| 100 PB+ (Exabyte scale) | Snowmobile |

---

## 4.4 Integration with Other AWS Services

- **S3** — Primary destination/source for Snowball data
- **KMS** — Encrypts all data on Snowball devices
- **IAM** — Roles required for copy operations and job creation
- **SNS** — Job status notifications
- **Lambda** (Snowball Edge) — Run functions on the device at edge locations

---

## 4.5 Real-Time DevOps Production Scenario

**Application:** A hospital chain with 20 years of patient imaging data (X-rays, MRIs, CT scans) — approximately 200 TB total — needs to migrate to AWS for AI-based diagnostics analysis.

**The Challenge:**
- Hospital internet connection: 100 Mbps
- Time to upload 200 TB at 100 Mbps: **185+ days** (unacceptable)
- Data is sensitive — must be encrypted at all times

**Solution with Snowball:**
```
Step 1: Create 3x Snowball Jobs (3 × 80 TB devices)
Step 2: AWS ships 3 Snowball devices to hospital
Step 3: Hospital IT team connects devices, uses Snowball Client
Step 4: Data is encrypted client-side using AES-256 encryption
Step 5: Copy 200 TB data across 3 devices (few days of copying)
Step 6: Ship devices back to AWS (FedEx with tracking)
Step 7: AWS loads data into S3 bucket in chosen region
Step 8: Hospital team receives SNS email notification: "Import Complete"
Step 9: AWS securely wipes all devices (NIST 800-88 standards)
```

**Post-migration architecture:**
```
S3 (Raw imaging data)
    ↓ Lifecycle Policy
S3 Glacier (Images older than 5 years — compliance retention)
    ↓
Amazon SageMaker (AI model analyzes new uploads for diagnostics)
```

**Total time:** ~2 weeks vs. 185+ days via internet

---

## 4.6 Benefits

- **Fast large-scale data migration** — Much faster than internet for large datasets
- **Secure** — 256-bit encryption, tamper-evident enclosure, trusted platform module
- **Simple** — No code to write, no hardware to buy
- **Cost-effective** — Flat fee per job, no per-GB transfer cost into S3
- **Snowball Edge** — Enables edge computing in remote locations with no cloud connectivity
- **Snowmobile** — Handles exabyte-scale migrations no other solution can match

---

## 4.7 Common Use Cases

- One-time data center migration to AWS (on-premises to cloud)
- Disaster recovery data seeding (get initial backup into AWS quickly)
- Remote or edge data collection (mines, ships, military, scientific expeditions)
- Media and entertainment (moving large video archives to cloud)
- Healthcare imaging data migration
- Initial data population for big data analytics projects

---

## 4.8 Summary

AWS Snowball is a physical device that solves the problem of moving massive amounts of data to AWS faster than the internet allows. Standard Snowball handles tens of terabytes, Snowball Edge adds compute capability for edge processing, and Snowmobile handles exabyte-scale migrations with a literal truck. Always consider Snowball when internet-based uploads would take more than a week for your data volume.

---
---

# 5. 🔌 AWS Direct Connect

---

## 5.1 What is AWS Direct Connect?

**AWS Direct Connect** is a **dedicated, private network connection** between your on-premises data center (or office) and AWS — bypassing the public internet entirely.

Think of it like having a **private highway** directly from your office to AWS, while everyone else uses the regular public road (internet). Your traffic never touches the public internet — it's faster, more consistent, and more secure.

---

## 5.2 Key Concepts

### The Problem Direct Connect Solves
When you connect to AWS over the internet:
- Network speed **fluctuates** based on internet congestion
- **Latency varies** and is unpredictable
- **Security concerns** — data travels over public infrastructure
- **Bandwidth costs** can be high for large data transfers

Direct Connect addresses all of these problems.

### How It Works
```
Your Data Center / Office
        ↓
Direct Connect Location (colocation facility near you)
        ↓
Dedicated private fiber connection (industry-standard 802.1q VLANs)
        ↓
AWS Network
        ↓
Your AWS Resources (EC2, S3, RDS, etc.)
```

### Virtual Interfaces (VIFs)
A single Direct Connect connection can be **partitioned into multiple Virtual Interfaces**:

| VIF Type | Purpose | Connects To |
|---|---|---|
| **Public VIF** | Access public AWS services | S3, DynamoDB, CloudFront (via public IPs) |
| **Private VIF** | Access resources in your VPC | EC2, RDS, internal services (via private IPs) |

This means **one physical connection** can give you both private VPC access AND public S3 access simultaneously — with network separation between them.

---

## 5.3 Connection Speeds Available

| Speed | Use Case |
|---|---|
| 1 Gbps | Small-medium enterprise |
| 10 Gbps | Large enterprise, high-throughput workloads |
| 100 Mbps – 500 Mbps | Via Direct Connect partners (hosted connections) |

---

## 5.4 Integration with Other AWS Services

- **VPC** — Private VIF connects your on-premises network to your VPC
- **S3** — Public VIF allows access to S3 via private connection
- **EC2** — Access instances in private subnets directly
- **RDS** — Securely connect to databases without internet exposure
- **Route 53** — DNS resolution works over Direct Connect
- **VPN** — Can be used alongside VPN as a redundant backup connection

---

## 5.5 Real-Time DevOps Production Scenario

**Application:** A financial services company running a hybrid cloud architecture — core banking system on-premises, new microservices on AWS.

**Architecture Flow:**
```
Bank Data Center (Mumbai)
    ↓ (dedicated 10 Gbps fiber)
Direct Connect Location (Equinix Mumbai)
    ↓ (private AWS backbone)
AWS Mumbai Region (ap-south-1)
    ├── Private VIF → VPC → EC2 (microservices) + RDS (analytics DB)
    └── Public VIF → S3 (bulk report storage) + DynamoDB (transaction cache)
```

**Why Direct Connect over VPN?**
- VPN encrypts traffic but still goes over public internet — latency spikes during market hours
- Direct Connect gives consistent **sub-2ms latency** for real-time trading data
- Regulatory compliance: Financial data must not traverse public internet

**Monitoring Approach:**
- CloudWatch monitors Direct Connect connection metrics (bandwidth, packet loss)
- Alerts if connection health drops
- BGP routing monitored for failover

**Redundancy Setup:**
- Primary: 10 Gbps Direct Connect
- Backup: Site-to-Site VPN over internet (automatic failover if Direct Connect goes down)

---

## 5.6 Benefits

| Benefit | Description |
|---|---|
| **Reduced bandwidth costs** | Lower per-GB data transfer rates than internet |
| **Consistent performance** | Predictable latency, no internet congestion |
| **Private connectivity** | Traffic never touches the public internet |
| **Compatible with all AWS services** | Works with EC2, S3, RDS, and everything else |
| **Elastic** | Can request additional connections or virtual interfaces as needed |
| **Secure** | Private network — no exposure to internet threats |

---

## 5.7 Common Use Cases

- Hybrid cloud architecture (on-premises + AWS working together)
- Financial trading systems requiring consistent low latency
- Healthcare data transfer with strict compliance requirements
- Enterprise ERP/SAP systems running in hybrid mode
- Large-scale data migration (ongoing, not one-time like Snowball)
- Disaster recovery — keep on-premises and AWS in sync over dedicated link

---

## 5.8 Summary

AWS Direct Connect gives you a dedicated private network connection from your data center to AWS, bypassing the public internet. It delivers consistent, low-latency, high-bandwidth connectivity — perfect for enterprises with strict performance requirements, compliance needs, or large ongoing data transfer volumes. It's not for everyone (it requires physical infrastructure setup), but for serious hybrid cloud workloads it's the gold standard.

---
---

# 6. 🖥️ EC2 — Elastic Compute Cloud

---

## 6.1 What is EC2?

**Amazon EC2 (Elastic Compute Cloud)** is AWS's core compute service — it lets you launch **virtual servers (called instances)** in the cloud within minutes.

Think of EC2 like **renting a computer in AWS's data center**. You choose the operating system, CPU, RAM, storage, and network configuration. You start it when you need it, stop it when you don't, and pay only for what you use.

An **EC2 Instance** is simply a **virtual machine (VM)** running on AWS infrastructure.

---

## 6.2 Instance Types

AWS offers many instance types grouped into families based on their specialized hardware:

| Family | Optimized For | Real-World Use Case |
|---|---|---|
| **General Purpose** (t2, t3, m5) | Balanced CPU, memory, network | Web servers, development, small databases |
| **Compute Optimized** (c5, c6g) | High CPU performance | Batch processing, HPC, gaming servers |
| **Memory Optimized** (r5, x1) | Large amounts of RAM | In-memory databases, Redis, SAP HANA |
| **Storage Optimized** (i3, d2) | High-speed local storage, high IOPS | NoSQL databases (Cassandra, MongoDB), data warehousing |
| **GPU Compute** (p3, p4) | Graphics processing units | Machine learning, deep learning, AI training |
| **GPU Graphics** (g4) | Graphics rendering | 3D visualization, video encoding, remote workstations |
| **FPGA Instances** (f1) | Field Programmable Gate Arrays | Custom hardware acceleration, genomics |

**Free Tier eligible:** `t2.micro` (1 vCPU, 1 GB RAM) — 750 hours/month free for 12 months

---

## 6.3 EC2 Pricing Options

### 🔵 On-Demand Instances
- Pay by the **hour or second** (minimum 60 seconds)
- **No upfront commitment** — start and stop anytime
- Most flexible, highest price per hour
- **Best for:** Unpredictable workloads, testing, development, short-term spiky traffic

### 🟡 Reserved Instances (RI)
- **Commit to 1 or 3 years** — get significant discount (up to 75% off On-Demand)
- Choose a specific instance type and Availability Zone

**Three RI types:**

| RI Type | Discount | Flexibility |
|---|---|---|
| **Standard RI** | Up to 75% off | Fixed — can't change instance type |
| **Convertible RI** | Up to 54% off | Can change instance type, OS, tenancy |
| **Scheduled RI** | Partial discount | Reserve for specific time windows (e.g., weekday daytime only) |

**Three payment options:**
- **All Upfront** — Pay full amount now, maximum discount, no monthly charges
- **Partial Upfront** — Pay some now, rest monthly
- **No Upfront** — Pay monthly over the term (smallest discount)

**Best for:** Steady-state production workloads that run continuously (like your main web server that's always on)

### 🔴 Spot Instances
- **Bid for unused EC2 capacity** — get up to **90% off** On-Demand price
- **Catch:** AWS can terminate your instance with only **2 minutes warning** if someone bids higher or capacity is needed
- If **AWS terminates** the instance: you're **not charged** for the partial hour
- If **you terminate** the instance: you **are charged** for the partial hour
- **Best for:** Batch processing, big data analysis, CI/CD pipelines, fault-tolerant workloads that can handle interruption

### Pricing Summary

| Option | Discount | Flexibility | Risk |
|---|---|---|---|
| On-Demand | 0% (baseline price) | Highest | None |
| Reserved (1 yr) | Up to 40% | Medium | Committed cost |
| Reserved (3 yr) | Up to 75% | Low | Committed cost |
| Spot | Up to 90% | N/A | Instance can be terminated |

---

## 6.4 Tenancy Options

| Tenancy | Description | Use Case |
|---|---|---|
| **Shared** (Default) | Your instances share physical hardware with other AWS customers | Most workloads |
| **Dedicated Instance** | Your instances run on hardware dedicated to your account only | Compliance, licensing |
| **Dedicated Host** | You get a **specific physical server** assigned entirely to you. You control instance placement | Windows Server / SQL Server licensing (BYOL), compliance |

---

## 6.5 Amazon Machine Images (AMIs)

An **AMI (Amazon Machine Image)** is a **pre-configured template** that defines the software on your instance when it launches.

An AMI includes:
- Operating system (Linux, Windows)
- Initial patches and configurations
- Pre-installed applications or software

**Four sources of AMIs:**
1. **Published by AWS** — Amazon Linux, Amazon Linux 2, Windows Server, Ubuntu
2. **AWS Marketplace** — Third-party vendors (pre-configured WordPress, Nginx, databases)
3. **Community AMIs** — User-generated, free, use with caution
4. **Custom AMIs (Golden AMIs)** — You create your own by customizing an instance and saving it as an AMI

**Golden AMI best practice in DevOps:** Create a base AMI with all security patches, company agents (CloudWatch, SSM), and standard configuration baked in. All new instances launch from this Golden AMI — consistent, secure, fast launch.

**AMI are regional** — if you need it in another region, use the **Copy AMI** feature.

---

## 6.6 Accessing EC2 Instances

### Public DNS
- Auto-generated when instance launches (e.g., `ec2-54-xxx-xxx-xxx.compute-1.amazonaws.com`)
- Changes every time you stop/start the instance
- Cannot be transferred to another instance

### Public IP
- Automatically assigned at launch
- **Changes every time you stop and start** the instance
- Free while instance is running

### Elastic IP (EIP)
- **Static public IP address** — doesn't change
- Assigned to your AWS account (not the instance)
- You can move it from one instance to another
- **Free while associated with a running instance**
- **Charged** when allocated but not associated with a running instance
- **Limit:** 5 EIPs per Region (can be increased)

**Best practice:** Use EIPs sparingly — instead, use DNS names (Route 53) or Load Balancers that handle IP changes automatically.

---

## 6.7 Instance Lifecycle

```
Launch → Pending → Running → Stopping → Stopped → Terminated
                      ↓
               Rebooting (stays Running state)
```

Key notes:
- **Stop/Start:** Instance moves to different physical host (gets new public IP unless EIP used)
- **Reboot:** Stays on same physical host
- **Terminate:** Instance and root volume permanently deleted (unless "Delete on Termination" is unchecked)
- **Instance store-backed instances** — **Cannot be stopped**, only terminated or rebooted

---

## 6.8 Placement Groups

A **Placement Group** is a logical grouping of instances for specific networking needs.

| Type | How Instances Are Placed | Use Case |
|---|---|---|
| **Cluster** | All instances on hardware that's close together in one AZ | Low latency, high throughput between instances — HPC, big data |
| **Partition** | Instances spread across isolated partitions (each partition is separate hardware rack) | Large distributed systems — HDFS, HBase, Cassandra |
| **Spread** | Each instance on completely separate underlying hardware | High availability — maximum isolation, up to 7 instances per AZ per group |

**Key rules:**
- Placement group names must be unique within your AWS account
- AWS recommends homogeneous (same type) instances in cluster placement groups
- You cannot move an existing instance into a placement group after launch
- You cannot merge placement groups

---

## 6.9 Security Groups

A **Security Group** is a **virtual firewall** that controls inbound and outbound traffic to your EC2 instance.

**Key characteristics:**
- **Stateful** — If you allow inbound port 80, the outbound response is automatically allowed (no need for separate outbound rule)
- **Allow rules only** — You cannot create deny rules (use Network ACLs for deny)
- **Default behavior:** All inbound traffic blocked, all outbound traffic allowed
- Changes take effect **immediately** without instance restart
- An instance can have **up to 5 security groups**
- You can have up to **50 inbound + 50 outbound rules** per security group
- **Applied at instance level** (not subnet level)
- **You cannot block a specific IP address** using security groups (use Network ACL for that)

**Source options when creating rules:**
- **Anywhere (0.0.0.0/0):** Open to the entire internet — use carefully
- **My IP:** Only your current IP address can access
- **Custom IP/CIDR:** Specify an IP range (e.g., your office network `202.153.31.0/24`)
- **Another security group:** Allow traffic from instances in a specific security group

---

## 6.10 Key Pair Authentication

When launching an EC2 instance, you associate a **Key Pair** — a public/private key pair for secure authentication.

- AWS stores the **public key** on the instance
- You download and keep the **private key** (`.pem` file) — **never lose this, you can't download it again**
- Use the private key to SSH into Linux instances or decrypt Windows passwords

**Connecting to Linux:**
```
PuTTY approach (Windows):
1. Convert .pem to .ppk using PuTTYgen
2. Open PuTTY → Enter public IP → Port 22
3. Under SSH → Auth → Browse for .ppk file
4. Login as: ec2-user (Amazon Linux), ubuntu (Ubuntu), centos (CentOS)
```

**Connecting to Windows:**
```
1. In EC2 Console → Select instance → Connect → RDP Client
2. Click "Get Password" → Browse .pem file → Decrypt Password
3. Open Remote Desktop → Enter Public IP → Login with decrypted password
```

**Default usernames by OS:**
| OS | Default Username |
|---|---|
| Amazon Linux | ec2-user |
| RHEL/Red Hat | ec2-user or root |
| Ubuntu | ubuntu or root |
| CentOS | centos |
| Fedora | ec2-user |
| SUSE | ec2-user or root |

---

## 6.11 User Data — Bootstrapping

**User Data** is a script you provide at launch time that runs **automatically when the instance first starts**.

This is called **bootstrapping** — configuring the instance automatically without logging in manually.

**Linux User Data example — Auto-setup a web server:**
```bash
#!/bin/bash
yum update -y
yum install httpd -y
echo "<h1>Welcome to Production Server</h1>" > /var/www/html/index.html
service httpd start
chkconfig httpd on
```

**Windows User Data example — Set timezone:**
```powershell
<powershell>
tzutil /s "India Standard Time"
</powershell>
```

**To view what User Data was given to an instance:**
```
curl http://169.254.169.254/latest/user-data/
```

**Real-world DevOps use:** User Data scripts install CloudWatch agent, join the instance to a domain, configure application environment variables, and install required software — all automatically at launch.

---

## 6.12 Instance Metadata

**Instance Metadata** is data about the running instance accessible from within the instance itself.

```
curl http://169.254.169.254/latest/meta-data/
```

This returns available metadata fields. Query specific data:
```
curl http://169.254.169.254/latest/meta-data/public-ipv4       → Get public IP
curl http://169.254.169.254/latest/meta-data/hostname          → Get hostname
curl http://169.254.169.254/latest/meta-data/instance-id       → Get instance ID
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/RoleName → Get temp credentials
```

This endpoint is **only accessible from within the EC2 instance** — not from the internet.

---

## 6.13 Enhanced Networking

**Enhanced Networking** uses **Single Root I/O Virtualization (SR-IOV)** to reduce the impact of virtualization on network performance.

Results in:
- Higher **Packets Per Second (PPS)**
- Lower **latency**
- Less **jitter** (network variability)

Recommended for high-performance workloads — HPC, big data, real-time applications.

---

## 6.14 Integration with Other AWS Services

| Service | EC2 Integration |
|---|---|
| **IAM** | Attach roles for secure service access |
| **S3** | Store and retrieve application files |
| **EBS** | Persistent block storage attached to instances |
| **ELB** | Distribute incoming traffic across multiple instances |
| **Auto Scaling** | Automatically add/remove instances based on load |
| **CloudWatch** | Monitor CPU, memory, disk, network metrics |
| **VPC** | Network isolation and subnet placement |
| **Route 53** | DNS routing to instances or load balancers |
| **CloudTrail** | Log all EC2 API calls |
| **Systems Manager (SSM)** | Manage instances without SSH (patch, run commands) |

---

## 6.15 Real-Time DevOps Production Scenario

**Application:** A high-traffic news website (like a national newspaper) — needs to handle normal daily traffic plus massive traffic spikes during breaking news events.

**Instance Strategy:**
```
Base Load (always running):
  → 4x m5.xlarge Reserved Instances (1-year, All Upfront)
  → Covers normal daily traffic
  → Cost-optimized for predictable steady-state load

Peak Load (breaking news spikes):
  → Auto Scaling Group adds On-Demand t3.large instances
  → Scales out within minutes when CPU > 70%
  → Scales back in when traffic drops

Batch Processing (image resizing, article indexing):
  → Spot Instance fleet (c5.xlarge)
  → Non-critical, fault-tolerant — perfect for Spot
  → 70-80% cost saving on batch jobs
```

**Architecture Flow:**
```
Users (millions)
    ↓
CloudFront (serves static assets from cache — HTML, CSS, JS, images)
    ↓
Application Load Balancer (us-east-1 — across 3 AZs)
    ↓
Auto Scaling Group
├── AZ-1a: 2x m5.xlarge (Reserved) + n× t3.large (On-Demand, when scaling)
├── AZ-1b: 2x m5.xlarge (Reserved) + n× t3.large (On-Demand, when scaling)
└── AZ-1c: (used only during extreme peaks)
    ↓
Amazon RDS MySQL (Multi-AZ) — article storage
Amazon ElastiCache Redis — session caching, trending articles
Amazon S3 — image and media storage
```

**AMI Strategy:**
- Golden AMI: Base Amazon Linux 2 + CloudWatch agent + SSM agent + Node.js runtime + company SSL certificates
- New instances launch from this Golden AMI in ~2 minutes
- AMI refreshed monthly with latest security patches

**Bootstrap Script (User Data) in Golden AMI launch:**
```bash
#!/bin/bash
# Pull latest application code from S3
aws s3 cp s3://deploy-bucket/app/latest.tar.gz /app/
tar -xzf /app/latest.tar.gz -C /app/
pm2 start /app/server.js
```

**Security Groups:**
```
Web-SG:
  Inbound: Port 80 (HTTP) from ALB-SG only
  Inbound: Port 443 (HTTPS) from ALB-SG only
  Inbound: Port 22 (SSH) from Bastion-SG only
  Outbound: All traffic allowed

ALB-SG:
  Inbound: Port 80, 443 from 0.0.0.0/0 (public internet)
  Outbound: Port 80, 443 to Web-SG
```

**Monitoring Approach:**
- CloudWatch detailed monitoring (1-minute intervals) — CPU, Network, Status Checks
- CloudWatch Alarms: CPU > 70% → trigger scale-out, CPU < 30% for 15 min → scale-in
- CloudWatch Logs: Application logs shipped to CloudWatch from all instances
- AWS Systems Manager: Patch management, run commands without SSH

---

## 6.16 Benefits

- **Resizable** — Change instance type with a simple stop-modify-start
- **Multiple pricing options** — On-Demand, Reserved, Spot for any use case
- **Wide instance variety** — From nano to metal instances for any workload
- **Secure** — VPC, security groups, IAM roles, key pairs
- **Fast provisioning** — Launch a server in minutes, not weeks
- **Elastic** — Integrate with Auto Scaling for automatic capacity management
- **Rich monitoring** — CloudWatch integration out of the box
- **Global reach** — Launch in any AWS Region worldwide

---

## 6.17 Common Use Cases

- Web application servers (Node.js, Java, Python, PHP)
- Database servers (self-managed MySQL, PostgreSQL, MongoDB)
- Batch processing and data transformation
- Development and testing environments
- High-Performance Computing (HPC) and scientific simulations
- Game servers and real-time applications
- Machine learning training (GPU instances)
- Windows Server workloads and .NET applications

---

## 6.18 Summary

EC2 is the backbone of AWS computing. It lets you launch virtual servers with your choice of OS, CPU, RAM, and storage in minutes. Use the right instance type for your workload, the right pricing model for your budget (On-Demand for flexibility, Reserved for steady workloads, Spot for cost savings on tolerant workloads), and always use IAM Roles instead of storing credentials on instances. Security Groups act as your instance's firewall, and User Data automates instance configuration at launch time.

---
---

# 7. 💾 EBS — Elastic Block Store (Volumes & Snapshots)

---

## 7.1 What is EBS?

**Amazon EBS (Elastic Block Store)** provides **persistent, durable block-level storage volumes** for EC2 instances — similar to a hard drive you attach to a computer.

Think of EBS like a **USB external hard drive** for your EC2 instance — except it's network-attached, highly reliable, and persists data even after the instance is stopped or terminated.

**Key distinction:** Unlike an instance's local storage (which disappears when the instance stops), **EBS data persists** even when the instance is stopped. It's the primary storage option for critical production data.

---

## 7.2 Key Concepts

- EBS volumes are automatically **replicated within their Availability Zone** — protect against component failure
- Multiple EBS volumes can be attached to a **single EC2 instance**
- An EBS volume can only be in **one AZ** — and must be in the **same AZ** as the instance it attaches to
- You can **detach** a volume from one instance and **reattach** it to another (in the same AZ)

---

## 7.3 EBS Volume Types

### 🔵 General Purpose SSD (gp2)
| Property | Value |
|---|---|
| Size | 1 GiB – 16 TiB |
| Baseline IOPS | 3 IOPS per GiB (min 100, max 10,000 IOPS) |
| Burst IOPS | Up to 3,000 IOPS for extended periods |
| Latency | Single-digit milliseconds |
| Best for | Boot volumes, development environments, low-latency apps |

### 🔵 General Purpose SSD (gp3)
- **Latest generation** — replaces gp2 as the recommended general-purpose volume
- **20% lower cost** per GB than gp2
- **Provision performance independently** from storage size (unlike gp2 where IOPS scale with size)
- Base: 3,000 IOPS and 125 MB/s throughput regardless of size
- **Best for:** Most workloads — recommended default choice

### 🟡 Provisioned IOPS SSD (io1)
| Property | Value |
|---|---|
| Size | 4 GiB – 16 TiB |
| Max IOPS | 32,000 IOPS per volume |
| Best for | I/O-intensive databases, consistent high performance |

### 🟡 Provisioned IOPS SSD (io2)
- **Latest generation** — designed for business-critical databases
- **100x durability** of io1 — 99.999% durability
- **10x higher IOPS:storage ratio** — 500 IOPS per provisioned GB
- Max **64,000 IOPS** and **1,000 MB/s** throughput (requires Nitro-based EC2 instance)
- **Best for:** SAP HANA, Oracle, Microsoft SQL Server, IBM DB2

### 🟠 Throughput Optimized HDD (st1)
| Property | Value |
|---|---|
| Size | 125 GiB – 16 TiB |
| Throughput | 40 MB/s per TiB baseline, burst to 250 MB/s |
| Cannot be | Boot/root volume |
| Best for | Big data, data warehouses, log processing, streaming |

**Key:** Optimized for **throughput (MB/s)**, not IOPS — good for large sequential reads/writes.

### 🔴 Cold HDD (sc1)
| Property | Value |
|---|---|
| Size | 125 GiB – 16 TiB |
| Throughput | 12 MB/s per TiB baseline |
| Cannot be | Boot/root volume |
| Best for | Infrequently accessed large data — lowest cost HDD option |

### ⚪ Magnetic (Standard)
- Legacy volume type
- 1 GiB – 1 TiB
- ~100 IOPS average with burst capability
- **Best for:** Infrequent access, small volume size, lowest cost per GB

---

## 7.4 EBS Multi-Attach

**Amazon EBS Multi-Attach** allows a single **io1 or io2** volume to be attached to **up to 16 EC2 instances simultaneously** (all in the same AZ).

| Feature | io2 volumes | io1 volumes |
|---|---|---|
| Modify volume type | ✗ | ✗ |
| Modify volume size | ✓ | ✗ |
| Modify provisioned IOPS | ✓ | ✗ |
| Enable/Disable Multi-Attach | ✓ (when detached) | ✗ |

**Limitations:**
- Only Provisioned IOPS SSD (io1 or io2) — no other volume types
- Only Linux instances built on **AWS Nitro System**
- Cannot be boot volumes
- io1 Multi-Attach available only in: us-east-1, us-west-2, eu-west-1, ap-northeast-2

**Use case:** Clustered database applications that need concurrent write access from multiple nodes (e.g., Oracle RAC).

---

## 7.5 Instance Store (Ephemeral Storage)

**Instance Store** provides **temporary** block-level storage physically attached to the host machine.

| Property | EBS Volume | Instance Store |
|---|---|---|
| Persistence | Persists after stop/terminate | **Lost when instance stops/terminates** |
| Type | Network-attached | Physically attached to host |
| Speed | Fast (network) | Extremely fast (direct disk) |
| Backup | Snapshots available | No backup option |
| Use case | Persistent data, databases | Temporary buffers, caches, scratch data |

**Important:** Instance Store volumes are also called **Ephemeral Storage**. If the underlying host hardware fails, the data is lost — there's no recovery.

**When data is lost from Instance Store:**
- The underlying disk drive fails
- The instance is stopped
- The instance is terminated

---

## 7.6 EBS Snapshots

A **Snapshot** is a **point-in-time backup** of an EBS volume, stored in Amazon S3 (AWS-managed storage, not your S3 bucket).

### How Snapshots Work
- First snapshot: **Full backup** of all data on the volume
- Subsequent snapshots: **Incremental** — only blocks that changed since the last snapshot are saved
- Despite being incremental, you can restore any individual snapshot independently (AWS handles the reconstruction)

### Key Snapshot Facts
- Snapshots are **region-specific** — you can copy to another region if needed
- You can create a new volume from any snapshot (same or larger size, same or different type)
- Snapshots can be used to **increase volume size** — take snapshot → create larger volume from it
- Encrypted volume snapshots are **encrypted**; volumes created from encrypted snapshots are also **encrypted**
- You **cannot share encrypted snapshots** (only unencrypted snapshots can be shared)

### Snapshot Actions Available
| Action | Description |
|---|---|
| **Delete** | Remove the snapshot |
| **Create Volume** | Launch a new EBS volume (can change type or increase size) |
| **Create Image** | Create an AMI from this snapshot |
| **Copy** | Copy to another region for DR purposes |
| **Modify Permissions** | Share with specific AWS accounts or make public |

---

## 7.7 Amazon Data Lifecycle Manager (DLM)

**DLM** automates the **creation, retention, and deletion of EBS snapshots** — like a backup job scheduler for EBS.

**How it works:**
1. You create a DLM **Lifecycle Policy**
2. DLM uses **Tags** to identify which volumes to back up
3. Set the **schedule** (e.g., every 12 hours starting at 09:00 UTC)
4. Set the **retention** (e.g., keep last 7 snapshots)
5. DLM handles creation and deletion automatically

**Advanced DLM features:**
- **Fast Snapshot Restore:** Instantly initialize restored volumes (no performance penalty on new volumes)
- **Cross-Region Copy:** Automatically copy snapshots to another region
- **Cross-Account Sharing:** Share snapshots with up to 50 other AWS accounts

---

## 7.8 Mounting EBS Volumes on Linux

After attaching an EBS volume to a Linux EC2 instance:

```bash
# Step 1: Check existing disks
df -h

# Step 2: Find new disk
fdisk -l

# Step 3: Format with ext4 filesystem
mkfs -t ext4 /dev/xvdf

# Step 4: Create mount directory and mount
mkdir /newvolume
mount /dev/xvdf /newvolume

# Step 5: For permanent mount (survives reboots), add to /etc/fstab
echo "/dev/xvdf /newvolume ext4 defaults 0 0" >> /etc/fstab
```

---

## 7.9 Mounting EBS Volumes on Windows

```
1. Open Run → diskmgmt.msc (Disk Management)
2. New volume appears as Offline → right-click → Online
3. Right-click → Initialize Disk → OK
4. Right-click unallocated space → New Simple Volume
5. Follow wizard: Set size, assign drive letter, format as NTFS
6. Drive now available in File Explorer
```

---

## 7.10 Integration with Other AWS Services

| Service | EBS Integration |
|---|---|
| **EC2** | Primary storage attached to instances |
| **AMI** | AMIs are backed by EBS snapshots |
| **KMS** | Encrypt EBS volumes using KMS keys |
| **CloudWatch** | Monitor volume IOPS, throughput, queue depth |
| **DLM** | Automated snapshot lifecycle management |
| **S3** | Snapshots stored in S3 (AWS-managed) |
| **Auto Scaling** | New instances get fresh EBS volumes from AMI |

---

## 7.11 Real-Time DevOps Production Scenario

**Application:** A production PostgreSQL database server running on EC2 for a SaaS application

**Volume Strategy:**
```
EC2 Instance: r5.2xlarge (Memory Optimized — 8 vCPU, 64 GB RAM)
├── Root Volume: gp3 (50 GB) — OS and application binaries
├── Data Volume: io2 (500 GB, 15,000 IOPS) — PostgreSQL data files
└── Log Volume: gp3 (200 GB) — Database transaction logs
```

**Why io2 for database?**
- Consistent 15,000 IOPS — no burst/credit model
- 99.999% durability — critical for financial transaction data
- 500 IOPS/GB ratio handles peak query loads

**Backup Strategy (automated with DLM):**
```
DLM Policy:
  Target: Volumes with Tag: backup=database-prod
  Schedule: Every day at 02:00 UTC
  Retention: Keep last 14 daily snapshots
  Cross-Region Copy: Copy to ap-southeast-1 (Singapore) as DR
```

**Monitoring Approach:**
- CloudWatch: Alert if disk queue depth > 10 (I/O bottleneck signal)
- CloudWatch: Alert if available storage < 20% (disk full warning)
- Monthly: Test snapshot restore to verify backups are valid

**Scaling:** When database outgrows 500 GB:
1. Take snapshot of existing data volume
2. Create new io2 volume (1 TB) from snapshot
3. Detach old volume, attach new volume
4. Resize filesystem: `resize2fs /dev/xvdf`
5. No data migration needed — all done from snapshot

---

## 7.12 Benefits

- **Persistent** — Data survives instance stops and restarts
- **High availability** — Automatically replicated within its AZ
- **Flexible** — Multiple volume types for different performance needs
- **Resizable** — Increase size and change type without downtime
- **Secure** — Encryption at rest using KMS
- **Backup** — Incremental snapshots to S3
- **Automated** — DLM handles backup schedules
- **Attachable/Detachable** — Move volumes between instances

---

## 7.13 Common Use Cases

- Operating system boot volumes for EC2 instances
- Database storage (PostgreSQL, MySQL, Oracle, SQL Server)
- Application data and file storage
- Log storage requiring fast write throughput
- Development and test environments requiring persistent storage
- Enterprise applications requiring consistent I/O performance

---

## 7.14 Summary

EBS provides persistent, high-performance block storage for EC2 instances. Choose gp3 for most general workloads, io2 for demanding databases requiring consistent IOPS, st1 for large sequential workloads, and sc1 for infrequently accessed data. Always use snapshots for backups, automate them with DLM, and consider cross-region snapshot copies for disaster recovery. Remember: EBS volumes are AZ-specific, and Instance Store data is temporary — always use EBS for anything you can't afford to lose.

---
---

# 8. 📁 EFS — Elastic File System

---

## 8.1 What is EFS?

**Amazon EFS (Elastic File System)** is a **fully managed, scalable, shared file storage service** for EC2 instances.

Think of EFS like a **shared network drive (NFS)** in the cloud. Multiple EC2 instances — even in different Availability Zones — can **simultaneously read and write** to the same EFS file system, just like multiple computers sharing a network folder in an office.

**The key difference from EBS:** EBS can only be attached to **one instance at a time** (except io1/io2 Multi-Attach). EFS can be mounted by **hundreds of instances simultaneously**.

---

## 8.2 Key Concepts

- Uses **NFSv4.1 protocol** — industry-standard Network File System
- Storage capacity is **elastic** — automatically grows and shrinks as you add/remove files
- **Pay per use** — you only pay for the storage you actually consume (no pre-provisioning)
- **Linux EC2 instances only** — Windows is NOT supported
- Multiple instances in **multiple AZs within the same Region** can access the same EFS
- Can be mounted on **on-premises servers** when connected via AWS Direct Connect
- **No capacity planning needed** — scales from gigabytes to petabytes automatically

---

## 8.3 EFS Storage Classes

| Storage Class | Description | Use Case |
|---|---|---|
| **Regional (Standard)** | Data stored redundantly across all AZs in a Region | High availability workloads |
| **One Zone** | Data stored in a single AZ — lower cost | Less critical data, dev/test |

**Lifecycle Management:**
- EFS can automatically move files to a cheaper storage class based on access patterns
- Default policy: Move to EFS Standard-IA (Infrequent Access) **30 days after last access**
- Saves cost on files that haven't been accessed recently

---

## 8.4 Performance Modes

| Mode | Description | Use Case |
|---|---|---|
| **General Purpose** (Default) | Lowest latency | Web serving, CMS, home directories, general file serving |
| **Max I/O** | Higher aggregate throughput, slightly higher latency | Big data analytics, media processing, large-scale parallel workloads |

---

## 8.5 Throughput Modes

| Mode | Description | Use Case |
|---|---|---|
| **Bursting** | Throughput scales with file system size (baseline + burst credits) | General workloads |
| **Provisioned** | You set a specific throughput value regardless of storage size | Applications that need consistent throughput independent of storage |

---

## 8.6 How to Create and Mount EFS

### Step 1: Create EFS File System
```
AWS Console → Storage → EFS → Create File System → Customize
  ↓
Choose: Regional or One Zone
Set: Lifecycle policy (e.g., 30 days to IA)
Set: Performance mode (General Purpose)
Set: Throughput mode (Bursting)
Set: Network → Select VPC → Choose subnets and AZs
Set: Security Group (must allow NFS — port 2049)
  ↓
Create
```

### Step 2: Mount on Linux EC2 Instance
```bash
# Install NFS utilities (already present in Amazon Linux)
sudo yum install -y nfs-utils

# Create mount directory
sudo mkdir /efs

# Mount the EFS file system (replace fs-xxxxxx with your EFS ID)
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport \
  fs-xxxxxxxx.efs.ap-south-1.amazonaws.com:/ /efs

# Verify
df -h
```

### Permanent Mount (survives reboots)
```bash
# Add to /etc/fstab
echo "fs-xxxxxxxx.efs.ap-south-1.amazonaws.com:/ /efs nfs4 defaults,_netdev 0 0" >> /etc/fstab
```

**Important:** The EC2 instance's security group must **allow NFS traffic** (port 2049) from the EFS security group — and vice versa.

---

## 8.7 Integration with Other AWS Services

| Service | Integration |
|---|---|
| **EC2** | Multiple instances mount EFS simultaneously |
| **Auto Scaling** | All new instances in ASG automatically share same EFS |
| **ECS/EKS** | Containers share persistent storage via EFS |
| **Lambda** | Lambda functions can use EFS for shared persistent state |
| **Direct Connect** | Mount EFS on on-premises servers |
| **IAM** | Control access to EFS via IAM policies |
| **KMS** | Encrypt EFS data at rest |
| **CloudWatch** | Monitor EFS throughput, IOPS, connection count |
| **AWS Backup** | Automated EFS backup |

---

## 8.8 Real-Time DevOps Production Scenario

**Application:** A WordPress-based media company website running on an Auto Scaling Group of EC2 instances behind a Load Balancer.

**The Problem Without EFS:**
- When a WordPress user uploads an image, it saves to one EC2 instance's local disk
- When the Load Balancer routes the next request to a different EC2 instance, the image is not found
- Users see broken images — a common problem in multi-instance web deployments

**Solution With EFS:**
```
Architecture:
├── Application Load Balancer (distributes traffic)
│
├── Auto Scaling Group
│   ├── EC2 Instance 1 (AZ-1a) → /var/www/html/wp-content/uploads → EFS
│   ├── EC2 Instance 2 (AZ-1b) → /var/www/html/wp-content/uploads → EFS
│   └── EC2 Instance 3 (AZ-1a) → /var/www/html/wp-content/uploads → EFS (new instance added by ASG)
│
└── EFS File System (shared, Regional — across AZ-1a and AZ-1b)
    └── All uploads/media files stored here — accessible by ALL instances simultaneously
```

**Deployment Process:**
1. Create EFS file system with Regional storage class
2. Create Security Group allowing NFS (port 2049) between EC2 instances and EFS
3. In EC2 User Data script (Bootstrap):
   ```bash
   #!/bin/bash
   yum install -y nfs-utils
   mkdir -p /var/www/html/wp-content/uploads
   mount -t nfs4 fs-xxxxxxxx.efs.ap-south-1.amazonaws.com:/ /var/www/html/wp-content/uploads
   ```
4. Every new instance launched by Auto Scaling automatically mounts the same EFS
5. All instances share the same media files instantly

**Lifecycle Policy:** Files not accessed for 30 days move to EFS Standard-IA — saves ~70% on storage cost for old media assets.

**Monitoring:**
- CloudWatch: Monitor EFS DataReadIOBytes, DataWriteIOBytes metrics
- Alert if EFS throughput approaches provisioned limits
- Alert if EFS becomes unreachable (mount target health)

---

## 8.9 EFS vs EBS vs Instance Store Comparison

| Feature | EFS | EBS | Instance Store |
|---|---|---|---|
| Storage type | File (NFS) | Block (disk) | Block (local disk) |
| Attached to | Multiple instances | One instance | One instance (fixed) |
| Persistence | Yes | Yes | No (ephemeral) |
| Scalability | Auto-scales | Fixed (manual resize) | Fixed |
| Multi-AZ | Yes (Regional) | No (one AZ) | No |
| Windows support | No | Yes | Yes |
| Performance | Good | Excellent (io2) | Best (local) |
| Use case | Shared files | Databases, boot | Temp caches |

---

## 8.10 Benefits

- **Shared access** — Hundreds of EC2 instances can read/write simultaneously
- **Fully elastic** — No capacity planning, scales automatically
- **Highly available** — Regional storage across multiple AZs
- **Pay per use** — No upfront provisioning cost
- **Lifecycle management** — Automatic cost savings for infrequently accessed files
- **Simple** — Standard NFS protocol, works with existing Linux applications
- **Secure** — Encryption at rest (KMS) and in transit (TLS)

---

## 8.11 Common Use Cases

- Shared WordPress or CMS media file storage across multiple web servers
- Home directories for Linux users across multiple EC2 instances
- Content management systems needing shared file access
- Development environments with shared code repositories
- Big data analytics — multiple EC2 nodes processing the same dataset
- Container workloads (ECS/EKS) requiring shared persistent storage
- On-premises file share migration to cloud

---

## 8.12 Summary

EFS is a shared, elastic, fully managed network file system for Linux EC2 instances. Its biggest advantage over EBS is the ability to mount one file system to hundreds of instances simultaneously — making it perfect for web application media storage, shared content, and any use case where multiple servers need access to the same files. It scales automatically and you pay only for what you use.

---
---

# 9. 🪟 Amazon FSx

---

## 9.1 What is Amazon FSx?

**Amazon FSx** provides **fully managed third-party file systems** for workloads that require native compatibility with specific file system features — particularly **Windows-based workloads** that EFS cannot support.

Think of FSx as **EFS for Windows** — or more precisely, managed file storage with the native capabilities of enterprise-grade file systems.

---

## 9.2 FSx File System Options

### 🔵 Amazon FSx for Windows File Server
- Provides fully managed **Windows native file system** with SMB (Server Message Block) protocol support
- Full **NTFS** support — file permissions, shadow copies, Access Control Lists (ACLs)
- **Active Directory integration** — requires Microsoft Active Directory (AD) or AWS Managed AD
- **Use cases:** Windows application files, home directories, user profiles, SharePoint data

### 🟡 Amazon FSx File Gateway
- Provides **fast, low-latency on-premises access** to FSx file shares in the cloud
- Uses **SMB protocol** — seamlessly integrates with Windows workloads
- On-premises clients can access cloud-hosted file shares as if they were local network drives

### 🟠 Amazon FSx for Lustre
- High-performance parallel file system for **HPC (High Performance Computing)** workloads
- Extremely fast — designed for machine learning, financial modeling, genomics, media rendering
- Can integrate with S3 — directly process S3 objects as a file system

### 🔴 Amazon FSx for NetApp ONTAP
- Fully managed NetApp ONTAP storage for organizations already using NetApp on-premises
- Rich data management features — snapshots, cloning, tiering

---

## 9.3 Key Requirements for FSx for Windows

⚠️ **Important:** Amazon FSx for Windows requires a **Microsoft Active Directory** — either:
- **AWS Directory Service** (AWS Managed Microsoft AD)
- **AWS Simple AD**
- **On-premises Active Directory** (via Direct Connect or VPN)

---

## 9.4 Real-Time DevOps Production Scenario

**Application:** A financial company migrating Windows-based file servers to cloud. Thousands of Windows desktops access shared drives (like `\\fileserver\finance\` and `\\fileserver\hr\`).

**Architecture Flow:**
```
On-Premises Windows Desktops
    ↓ (via Direct Connect or VPN)
AWS Managed Microsoft AD (Directory Service)
    ↓
Amazon FSx for Windows File Server
    ├── Finance Share: \\fsx-dns\finance\
    ├── HR Share: \\fsx-dns\hr\
    └── IT Share: \\fsx-dns\it\
    ↓
Daily automated snapshots (shadow copies)
    ↓
FSx File Gateway (for on-premises users accessing via low-latency cache)
```

**Monitoring:**
- CloudWatch monitors storage capacity, throughput, IOPS
- SNS alerts when storage exceeds 80% capacity
- Windows Event Logs forwarded to CloudWatch Logs

---

## 9.5 Benefits

- **Native compatibility** — Windows apps work without modification
- **Fully managed** — AWS handles hardware, patching, backups
- **High performance** — SSD storage with high IOPS
- **Active Directory integration** — existing user permissions work seamlessly
- **Automatic backups** — Daily backups with configurable retention
- **Encryption** — At rest (KMS) and in transit

---

## 9.6 Summary

Amazon FSx provides managed enterprise-grade file systems for workloads that need native Windows compatibility (FSx for Windows), high-performance computing (FSx for Lustre), or NetApp ONTAP features. For Windows environments migrating to AWS, FSx for Windows with Active Directory integration is the natural choice. Remember: EFS is for Linux, FSx is for Windows.

---
---

# 10. 💡 Amazon Lightsail

---

## 10.1 What is Amazon Lightsail?

**Amazon Lightsail** is a **simplified, beginner-friendly cloud platform** that bundles compute, storage, DNS, and networking into easy, **flat-rate monthly pricing plans**.

Think of Lightsail as **EC2 with training wheels** — it hides the complexity of VPCs, security groups, and IAM behind a simple interface. Perfect for individuals, developers, and small businesses who want a simple VPS (Virtual Private Server) without learning all of AWS.

---

## 10.2 Key Features

- **Pre-configured blueprints** — Launch WordPress, Drupal, Joomla, MEAN, LAMP, Node.js with one click
- **Flat-rate pricing** — Starting at **$5/month** (includes compute + SSD storage + data transfer)
- **SSD-based storage** — Fast local storage included
- **Static IP** — Included with every instance
- **DNS management** — Built-in DNS console
- **One-click snapshots** — Backup your instance easily
- **Metrics and monitoring** — Built-in basic metrics dashboard

---

## 10.3 Lightsail Plans

| Plan | CPU | RAM | SSD | Transfer | Price/Month |
|---|---|---|---|---|---|
| Nano | 1 | 512 MB | 20 GB | 1 TB | $3.50 |
| Micro | 1 | 1 GB | 40 GB | 2 TB | $5 |
| Small | 1 | 2 GB | 60 GB | 3 TB | $10 |
| Medium | 2 | 4 GB | 80 GB | 4 TB | $20 |
| Large | 2 | 8 GB | 160 GB | 5 TB | $40 |

---

## 10.4 Available Blueprints

**Operating Systems:** Amazon Linux, Ubuntu, Debian, FreeBSD, OpenSUSE, Windows Server

**Application Stacks:** WordPress, Drupal, Joomla, Magento, Redmine, GitLab, LAMP, MEAN, Node.js

---

## 10.5 Launching a WordPress Site on Lightsail

```
Step 1: Go to Lightsail → Create Instance
Step 2: Choose Region and Availability Zone
Step 3: Platform: Linux/Unix
Step 4: Blueprint: WordPress
Step 5: Choose plan ($5/month)
Step 6: Name instance → Create

After launch:
- Get Public IP → Open in browser → See WordPress site
- Connect via browser-based SSH console
- Get admin password: ls; cat bitnami_application_password
- Login: username = user, password from above command
- Admin panel: http://public-ip/wp-admin
```

---

## 10.6 Real-Time DevOps Production Scenario

**Application:** A freelancer builds client websites for small businesses.

**Architecture:**
```
Lightsail Instance ($10/month plan)
├── WordPress + Bitnami (pre-configured)
├── SSD storage (60 GB) — all website files
├── Static IP (free with Lightsail)
├── DNS Zone (client's domain) → Points to Static IP
└── Monthly Snapshot (automated backup)
```

**Deploy and manage:**
- Zero infrastructure knowledge needed by client
- Developer manages via Lightsail console
- Scale up plan if site grows (click to upgrade)
- Snapshot before any plugin updates (restore in minutes if something breaks)

---

## 10.7 Lightsail vs EC2

| Feature | Lightsail | EC2 |
|---|---|---|
| Target audience | Beginners, simple apps | All levels, complex apps |
| Pricing | Simple flat-rate | Complex per-component |
| VPC, IAM, SG setup | Hidden/automatic | Manual, full control |
| Scalability | Limited | Unlimited (Auto Scaling) |
| Integration | Limited AWS integration | Deep AWS integration |
| Use case | Simple websites, dev/test | Production enterprise apps |

---

## 10.8 Summary

Amazon Lightsail is the beginner-friendly version of AWS — flat-rate VPS pricing with pre-configured application stacks. It's perfect for simple websites, WordPress, personal projects, and developers who want cloud hosting without learning the full complexity of AWS. When your application outgrows Lightsail, you can migrate to EC2, RDS, and other full AWS services.

---
---

# 11. 🌱 Elastic Beanstalk

---

## 11.1 What is Elastic Beanstalk?

**AWS Elastic Beanstalk** is a **Platform as a Service (PaaS)** offering that lets you **deploy and manage applications** without worrying about the underlying infrastructure. You provide your code — Elastic Beanstalk handles everything else.

Think of Elastic Beanstalk like a **smart deployment manager**. You upload your Node.js, Python, Java, or PHP application code, and Beanstalk automatically provisions EC2 instances, sets up load balancers, configures Auto Scaling, connects monitoring, and deploys your application — all with a few clicks.

**The magic:** Elastic Beanstalk **orchestrates other AWS services** — EC2, S3, ELB, Auto Scaling, CloudWatch, SNS — automatically.

---

## 11.2 Supported Languages and Platforms

| Platform | Language/Stack |
|---|---|
| Apache Tomcat | Java applications |
| Apache HTTP Server | PHP, Python applications |
| Nginx / Apache | Node.js applications |
| Passenger / Puma | Ruby applications |
| Microsoft IIS | .NET applications (7.5, 8.0, 8.5) |
| Java SE | Standalone Java |
| Docker | Any containerized application |
| Go | Go applications |

---

## 11.3 Key Concepts

### Application
A **logical container** that holds all versions of your code and configurations. Like a project folder.

### Version
A **specific deployable build** of your application — a zip file of your code uploaded to S3.

### Environment
The actual **running infrastructure** — the combination of EC2 instances, Load Balancer, Auto Scaling Group, and all resources running a specific version of your application.

### Configuration Template
Defines the **environment settings** — instance type, scaling rules, VPC settings, environment variables.

### Workflow:
```
You write code
    ↓
Create Application in Elastic Beanstalk
    ↓
Upload Version (zip of code → stored in S3)
    ↓
Create Environment (Beanstalk provisions all AWS resources)
    ↓
Application is running — accessible via Environment URL
    ↓
When you update: Upload new Version → Deploy to Environment
    ↓
Beanstalk handles zero-downtime deployment
```

---

## 11.4 Configuration Presets

| Preset | What It Creates |
|---|---|
| **Low Cost (Free Tier)** | Single EC2 instance, no Load Balancer, minimal cost |
| **High Availability** | Auto Scaling Group + Load Balancer + Multi-AZ |
| **Custom Configuration** | You define everything |

---

## 11.5 What Beanstalk Automatically Provisions

When you deploy with High Availability preset:
```
Elastic Beanstalk creates:
├── EC2 Instances (your chosen instance type)
├── Security Groups (configured for your app)
├── Elastic Load Balancer (distributes traffic)
├── Auto Scaling Group (scales up/down automatically)
├── CloudWatch Alarms (monitors application health)
├── S3 Bucket (stores your application versions)
├── SNS Topic (sends notifications on environment events)
└── Elastic IP or DNS (endpoint for your app)
```

---

## 11.6 Deployment Policies

| Policy | How It Works | Downtime? |
|---|---|---|
| **All at once** | Deploy to all instances simultaneously | Yes (briefly) |
| **Rolling** | Deploy to batches of instances, one at a time | No |
| **Rolling with additional batch** | Add new instances for deployment, then remove old | No |
| **Immutable** | Launch entirely new instances, switch traffic when healthy | No |
| **Blue/Green** | Create entirely new environment, then swap CNAMEs | No |

---

## 11.7 Integration with Other AWS Services

| Service | Integration |
|---|---|
| **EC2** | Runs your application on EC2 instances |
| **ELB** | Load balancer for traffic distribution |
| **Auto Scaling** | Scales instances based on load |
| **S3** | Stores application versions and logs |
| **CloudWatch** | Monitors environment health and metrics |
| **SNS** | Sends deployment and alarm notifications |
| **RDS** | Can provision a managed database alongside your app |
| **IAM** | Roles for Beanstalk environment to access AWS services |
| **VPC** | Deploy your environment inside a custom VPC |

---

## 11.8 Real-Time DevOps Production Scenario

**Application:** A startup's Python/Django REST API backend for a mobile app

**Development Workflow:**
```
Developer pushes code to GitHub
    ↓
CI/CD (GitHub Actions) runs tests
    ↓
On success: Package application as zip → Upload to Elastic Beanstalk
    ↓
Beanstalk deploys using "Rolling" deployment policy
  (half of instances updated first → health checked → other half updated)
    ↓
Zero downtime deployment — mobile app users never notice
    ↓
If deployment fails health check → Beanstalk automatically rolls back
```

**Environment Architecture:**
```
Production Environment:
├── Application Load Balancer (HTTPS on port 443)
├── Auto Scaling Group
│   ├── Minimum: 2 instances (t3.medium)
│   ├── Maximum: 10 instances
│   └── Scale out: CPU > 65% for 5 minutes
├── RDS MySQL (provisioned by Beanstalk)
├── ElastiCache Redis (session management)
└── CloudWatch Monitoring (all metrics)

Staging Environment:
├── Single t3.micro instance (Low Cost preset)
└── RDS MySQL (smaller instance class)
```

**Environment Variables (set in Beanstalk console):**
```
DATABASE_URL = rds-endpoint:3306/mydb
REDIS_URL = elasticache-endpoint:6379
DJANGO_SECRET_KEY = *****
AWS_STORAGE_BUCKET = myapp-media-prod
```

**Monitoring Approach:**
- Beanstalk provides health dashboard (Green/Yellow/Red/Grey)
- CloudWatch Alarms on CPU, request count, latency
- Enhanced Health Monitoring: detailed per-instance health checking
- CloudWatch Logs: Application logs streamed in real-time

---

## 11.9 Benefits

- **Fast deployment** — Go from code to running application in minutes
- **No infrastructure management** — Focus on code, not servers
- **Built-in scaling** — Auto Scaling included automatically
- **Multiple deployment policies** — Zero-downtime deployments
- **Full control when needed** — Can SSH into instances, modify configurations
- **Free to use** — You only pay for the underlying AWS resources (EC2, ELB, etc.)
- **Supports rollback** — Deploy previous version with one click

---

## 11.10 Common Use Cases

- Rapid prototyping and startup MVPs
- Web API backends (REST, GraphQL)
- Microservices deployment
- Developer/staging/production environment management
- Small-to-medium web applications
- Teams without dedicated DevOps/infrastructure expertise

---

## 11.11 Summary

Elastic Beanstalk removes infrastructure complexity from application deployment. You provide code, it handles provisioning, load balancing, scaling, and monitoring automatically. It's ideal for development teams that want to move fast without deep AWS infrastructure knowledge. Unlike Lightsail (fixed VPS), Beanstalk scales dynamically with Auto Scaling and integrates with the full AWS ecosystem. Think of it as the express lane for application deployment on AWS.

---
---

# 12. ⚖️ ELB — Elastic Load Balancing

---

## 12.1 What is Elastic Load Balancing?

**Elastic Load Balancing (ELB)** is a managed service that **automatically distributes incoming application traffic** across multiple EC2 instances, containers, or IP addresses.

Think of ELB like a **smart traffic cop** standing at the entrance to your application. When thousands of users arrive simultaneously, the traffic cop directs each user to a different available server — preventing any single server from getting overwhelmed while others sit idle.

**Key fact:** You never get a public IP for an ELB — you get a **DNS name** instead. AWS manages the IPs behind the scenes.

---

## 12.2 Types of Load Balancers

AWS offers **four types** of load balancers, each operating at a different layer of the OSI model:

### 🔵 Application Load Balancer (ALB) — Layer 7
**Operates at:** Application layer (HTTP/HTTPS)

**Key capabilities:**
- Routes traffic based on **request content** (URL path, hostname, HTTP headers, query strings)
- Supports **Host-based routing** — route `api.myapp.com` to one target group and `www.myapp.com` to another
- Supports **Path-based routing** — route `/api/*` to backend servers, `/static/*` to S3
- Supports **WebSocket** and **HTTP/2**
- Integrates with **AWS WAF** (Web Application Firewall)
- Built-in **authentication** via Cognito or OIDC
- Uses **round-robin** algorithm by default

**Best for:** Microservices architectures, modern web applications, REST APIs, container-based apps

### 🟡 Network Load Balancer (NLB) — Layer 4
**Operates at:** Transport layer (TCP/UDP)

**Key capabilities:**
- Handles **millions of requests per second** with ultra-low latency
- Preserves **source IP addresses** of clients
- Supports **static IP address** per AZ (can use Elastic IPs)
- Best performance of all load balancer types
- No content-based routing — just pure TCP/UDP forwarding

**Best for:** Real-time gaming, IoT, financial trading systems, UDP-based applications, extreme performance requirements

### 🟠 Classic Load Balancer (CLB) — Layer 4 & 7
**Operates at:** Both application and transport layers

- **Legacy** load balancer — AWS recommends migrating to ALB or NLB
- Supports HTTP, HTTPS, TCP, SSL
- Limited content-based routing
- Simple listener-based forwarding

**Best for:** Existing applications using CLB — migrate to ALB/NLB for new projects

### 🔴 Gateway Load Balancer (GWLB) — Layer 3
**Operates at:** Network layer

- Makes it easy to **deploy, scale, and manage third-party virtual appliances** (firewalls, IDS/IPS, deep packet inspection)
- Single gateway for distributing traffic across multiple virtual network appliances
- Scales appliances up/down based on demand

**Best for:** Network security appliances, third-party firewall clusters

---

## 12.3 Internet-Facing vs Internal Load Balancers

| Type | Description | Use Case |
|---|---|---|
| **Internet-Facing** | Has public DNS, accessible from internet | Front-end web servers, public APIs |
| **Internal** | Only accessible within VPC via private IPs | Communication between internal tiers (web → app → database) |

---

## 12.4 Health Checks

ELB continuously monitors the health of registered targets:

- **Healthy instance:** Status = `InService` → receives traffic
- **Unhealthy instance:** Status = `OutOfService` → removed from rotation, no traffic sent

**Health check configuration:**
| Setting | Description | Default |
|---|---|---|
| **Protocol** | HTTP, HTTPS, or TCP | HTTP |
| **Ping Path** | URL to check (e.g., `/health`) | `/` |
| **Interval** | How often to check (seconds) | 30 seconds |
| **Timeout** | How long to wait for response | 5 seconds |
| **Healthy Threshold** | Consecutive successes to mark healthy | 2 |
| **Unhealthy Threshold** | Consecutive failures to mark unhealthy | 2 |
| **Success Codes** | HTTP response codes considered healthy | 200–299 |

---

## 12.5 Target Groups

A **Target Group** is a logical collection of targets (EC2 instances, Lambda functions, IP addresses) that receives traffic from the load balancer.

- ALB uses target groups with routing rules
- Each target group has its own health check settings
- An instance can be in **multiple target groups** simultaneously

---

## 12.6 Load Balancer Comparison

| Feature | ALB | NLB | CLB | GWLB |
|---|---|---|---|---|
| OSI Layer | 7 | 4 | 4 & 7 | 3 |
| Protocol | HTTP, HTTPS, gRPC | TCP, UDP, TLS | HTTP, HTTPS, TCP | IP |
| Content-based routing | ✅ | ❌ | Limited | ❌ |
| Static IP | ❌ (via NLB) | ✅ | ❌ | ❌ |
| WebSocket | ✅ | ✅ | ❌ | N/A |
| Performance | High | Extreme | Moderate | High |
| Use case | Web apps, APIs | Real-time, gaming | Legacy | Security appliances |

---

## 12.7 Integration with Other AWS Services

| Service | ELB Integration |
|---|---|
| **EC2** | Distribute traffic across instances |
| **Auto Scaling** | ASG registers/deregisters instances with ELB automatically |
| **ACM** | SSL/TLS certificates for HTTPS termination |
| **WAF** | Web Application Firewall protection (ALB only) |
| **Route 53** | DNS alias record pointing to ELB DNS name |
| **CloudWatch** | Monitor request count, latency, healthy host count |
| **VPC** | Deployed within your VPC subnets |
| **Cognito** | User authentication before routing to backend (ALB) |

---

## 12.8 Real-Time DevOps Production Scenario

**Application:** A multi-tier e-commerce platform (product catalog, shopping cart, payment processing)

**Architecture:**
```
Internet Users
    ↓
Route 53 (DNS) → ALB DNS Name (Internet-Facing ALB)
    ↓
Application Load Balancer (HTTPS:443, HTTP:80 redirected to HTTPS)
    ↓ (Path-based routing rules)
    ├── /api/* → Target Group: API Servers (8x m5.large — handles product catalog, cart)
    ├── /payment/* → Target Group: Payment Servers (4x m5.xlarge — dedicated payment processing)
    ├── /admin/* → Target Group: Admin Servers (2x t3.medium — internal CMS)
    └── /* → Target Group: Web Servers (6x m5.large — serves HTML/CSS/JS)

Internal Communication:
API Servers → Internal ALB → Microservices (Internal Load Balancer)
Payment Servers → Internal NLB → Payment Gateway (requires static IP for whitelist)
```

**SSL/TLS Configuration:**
- **SSL Termination at ALB:** ALB handles HTTPS, forwards HTTP to EC2 (reduces CPU load on instances)
- **ACM certificate** attached to ALB — auto-renews, no manual certificate management

**Health Check for API Servers:**
```
Protocol: HTTP
Path: /health
Interval: 10 seconds
Timeout: 5 seconds
Healthy Threshold: 2
Unhealthy Threshold: 3
Success Codes: 200
```

**Monitoring Approach:**
- CloudWatch Alarms: Alert if `HealthyHostCount < 2` for any target group
- CloudWatch Alarms: Alert if `TargetResponseTime > 2 seconds` (latency degradation)
- Access Logs: ALB access logs stored in S3 → analyzed with Athena for request patterns
- WAF: Block SQL injection, XSS attempts, rate limiting (block IPs making >1000 req/min)

**Scaling Behavior:**
- Auto Scaling Group monitors ALB metrics — when `RequestCountPerTarget > 1000`, scale out
- New instances register with ALB automatically — zero manual intervention
- During Black Friday sales: ALB handles 10x normal traffic transparently

---

## 12.9 Benefits

- **Highly available** — ELB itself is managed, scales automatically, deployed across AZs
- **Health-aware routing** — Never sends traffic to unhealthy instances
- **SSL termination** — Offloads HTTPS processing from your application servers
- **Seamless scaling** — Works with Auto Scaling to add/remove instances automatically
- **Secure** — Works with VPC for internal traffic, WAF for security
- **Flexible** — Four types for any use case (web apps, gaming, network security)
- **No IP management** — DNS name abstracts underlying IPs

---

## 12.10 Common Use Cases

- HTTP/HTTPS web application traffic distribution (ALB)
- Microservices traffic routing by URL path or hostname (ALB)
- Real-time gaming, IoT, low-latency TCP workloads (NLB)
- Internal communication between application tiers
- Blue-green and canary deployments using weighted target groups
- Network security appliance clustering (GWLB)

---

## 12.11 Summary

Elastic Load Balancing distributes traffic across multiple healthy targets, ensuring high availability and fault tolerance. Use ALB for web applications with smart routing needs, NLB for extreme performance TCP/UDP workloads, and GWLB for network security appliances. ELB integrates deeply with Auto Scaling to automatically handle traffic growth. Remember: ELBs give you DNS names, not IPs — always use the DNS name in Route 53.

---
---

# 13. 📈 ASG — Auto Scaling Group

---

## 13.1 What is Auto Scaling?

**AWS Auto Scaling** is a service that **automatically adjusts the number of EC2 instances** in response to changing demand — scaling out (adding instances) when traffic increases and scaling in (removing instances) when traffic drops.

Think of Auto Scaling like a **restaurant that automatically hires more waiters when it gets busy and sends them home when it quiets down** — but for servers.

Without Auto Scaling, you'd either pay for servers you don't need (waste) or run out of capacity during peak traffic (failure). Auto Scaling eliminates both problems.

---

## 13.2 Key Components

### Launch Configuration (Legacy)
A **blueprint** that Auto Scaling uses to create new instances. Defines:
- AMI to use
- Instance type
- Security groups
- Key pair
- User Data (bootstrap script)
- Storage configuration

**Note:** Launch Configurations are now considered legacy — AWS recommends **Launch Templates** instead.

### Launch Template (Modern — Recommended)
Similar to Launch Configuration but with additional capabilities:
- **Versioning** — maintain multiple versions of the template
- Can specify both On-Demand and Spot instances in the same template
- Supports newer instance features
- Created from an existing EC2 instance (inherits all settings)

**Best Practice:** Always use Launch Templates for new Auto Scaling Groups.

### Auto Scaling Group (ASG)
The **core component** — a logical collection of EC2 instances that share the same scaling settings.

**Required configuration:**
- **Minimum size** — ASG will never go below this (e.g., 2 instances always running)
- **Maximum size** — ASG will never exceed this (e.g., 20 instances max)
- **Desired capacity** — Target number of instances under normal conditions (e.g., 4 instances)
- **VPC and Subnets** — Where to launch instances (always choose multiple AZs for HA)
- **Load Balancer** — Optional — register new instances automatically with ELB

---

## 13.3 Scaling Options

### 1. Maintain Current Instance Levels
- ASG keeps a fixed number of instances running at all times
- Performs periodic health checks
- If an instance fails health check → ASG **automatically terminates and replaces it**
- **Use case:** Simple applications needing fixed, steady capacity

### 2. Scheduled Scaling
Scale based on a **known time pattern** — you define when to scale.

**Examples:**
```
Every weekday at 8:00 AM → Scale out to 10 instances (workday starts)
Every weekday at 6:00 PM → Scale in to 2 instances (workday ends)
Every Saturday midnight → Scale out for weekend batch jobs
Every Black Friday → Scale to maximum at 12:01 AM
```

**Use case:** Applications with predictable usage patterns.

### 3. Dynamic Scaling (Demand-based)
Automatically scales based on real-time metrics. Three policy types:

#### 🔵 Target Tracking Scaling (Simplest and Recommended)
- You define a **target metric value** — ASG automatically adjusts to maintain it
- Like a thermostat — set the temperature, it handles the rest

**Example:** Keep average CPU utilization at 40%
```
CPU at 70% → ASG adds instances → CPU drops toward 40%
CPU at 15% → ASG removes instances → CPU rises toward 40%
```

**Common target metrics:**
- `ASGAverageCPUUtilization` — CPU percentage
- `ALBRequestCountPerTarget` — Requests per instance
- `ASGAverageNetworkIn/Out` — Network throughput

#### 🟡 Step Scaling
- Define **different scaling actions** based on the **size** of the metric breach
- More granular than Target Tracking

**Example:**
```
CPU 50-70% → Add 1 instance
CPU 70-90% → Add 3 instances
CPU > 90% → Add 5 instances (emergency scale-out)
```

#### 🟠 Simple Scaling
- One CloudWatch alarm → one scaling action
- Less sophisticated — generally replaced by Target Tracking

---

## 13.4 Default Termination Policy

When ASG needs to scale in (remove instances), it follows this order:
1. Choose AZ with the **most instances** (for balance)
2. Within that AZ, find the instance using the **oldest launch configuration**
3. If multiple instances use the same old config, terminate the one **closest to the next billing hour**
4. If still tied, **select randomly**

This ensures balanced AZ distribution and terminates older (potentially outdated) instances first.

---

## 13.5 Health Checks

ASG can use two types of health checks:
- **EC2 Health Check** (default) — checks if the instance is running
- **ELB Health Check** — checks if the application on the instance is responding correctly

**Recommendation:** Always use ELB Health Checks in production — an instance might be running but your application might be crashed. ELB checks verify the application actually works.

**Health Check Grace Period:** Time (in seconds) to wait after launching an instance before starting health checks. Default: 300 seconds. Give your application time to start up before being checked.

---

## 13.6 Integration with Other AWS Services

| Service | ASG Integration |
|---|---|
| **ELB** | Auto-registers new instances, deregisters terminated ones |
| **CloudWatch** | Scaling policies trigger based on CloudWatch alarms |
| **SNS** | Notifications on scaling events (launch, terminate, failed launch) |
| **EC2** | Manages the actual instances |
| **IAM** | Roles attached to all instances launched by ASG |
| **VPC** | Distributes instances across multiple subnets/AZs |
| **SQS** | Scale based on queue depth (number of unprocessed messages) |

---

## 13.7 Real-Time DevOps Production Scenario

**Application:** A ride-sharing app backend — dramatic traffic spikes when people go to work in the morning and come home in the evening.

**ASG Configuration:**
```
Launch Template:
  ├── AMI: Golden AMI (Node.js app + CloudWatch agent)
  ├── Instance Type: m5.large
  ├── Security Group: App-SG
  ├── IAM Role: AppRole
  └── User Data: Pull latest config from S3, start app

Auto Scaling Group:
  ├── Min: 4 instances (always on)
  ├── Max: 40 instances (peak capacity)
  ├── Desired: 4 instances (baseline)
  ├── VPC: Production VPC
  ├── Subnets: ap-south-1a, ap-south-1b, ap-south-1c (3 AZs)
  └── Load Balancer: ALB (app-alb)
```

**Scaling Policies:**

*Target Tracking Policy (primary):*
```
Target: ALBRequestCountPerTarget = 500 requests/instance
Scale-out: When requests/instance > 500 → Add instances
Scale-in: When requests/instance < 500 for 15 min → Remove instances
```

*Scheduled Scaling (predictable peaks):*
```
Monday–Friday 7:00 AM IST: Set desired capacity to 15 (morning rush)
Monday–Friday 9:00 AM IST: Set desired capacity to 8 (stable workday)
Monday–Friday 5:00 PM IST: Set desired capacity to 20 (evening rush)
Monday–Friday 8:00 PM IST: Set desired capacity to 4 (night)
Weekends: Different schedule with lower minimums
```

**Architecture Flow:**
```
Morning Rush (7 AM):
Users open app simultaneously
    ↓
ALB request count per instance rises → CloudWatch Alarm triggers
    ↓
ASG receives scale-out signal → Launches 10 new instances
    ↓
New instances register with ALB → Start receiving traffic in ~3 minutes
    ↓
Load distributed across 15 instances → No performance degradation

Evening (9 PM, traffic drops):
Request count drops → Scale-in policy activates
    ↓
ASG terminates 8 instances (keeping 4 minimum)
    ↓
Cost drops automatically — paying only for what's needed
```

**Failure Handling:**
```
EC2 Instance becomes unhealthy (application crash):
    ↓
ELB health check fails 3 consecutive times
    ↓
ASG receives termination signal for unhealthy instance
    ↓
ASG launches replacement instance from Golden AMI
    ↓
New instance bootstraps, passes health check, joins ELB
    ↓
Total recovery time: ~3-4 minutes, automatic, no human intervention
```

**Monitoring:**
- CloudWatch Dashboard: Current instance count, CPU average across all instances
- SNS Alert: When scaling events occur (for cost awareness)
- SNS Alert: When instances fail health checks repeatedly
- Monthly review: Analyze scaling patterns to optimize Reserved Instance purchases

---

## 13.8 Benefits

- **Cost optimization** — Pay only for instances you actually need
- **High availability** — Automatically replaces failed instances
- **Performance** — Always have the right capacity for current demand
- **Multi-AZ** — Distributes instances across AZs automatically
- **Seamless ELB integration** — New instances registered automatically
- **Multiple scaling options** — Target, Step, Scheduled, Manual
- **Free service** — You pay only for EC2 instances created, not Auto Scaling itself

---

## 13.9 Common Use Cases

- Web application backend servers with variable traffic
- API servers handling fluctuating request volumes
- Worker fleets processing job queues (scale based on SQS queue depth)
- Batch processing jobs (scale out to process faster, scale in when done)
- Game servers scaling for peak playing hours
- Event-driven applications with unpredictable spikes

---

## 13.10 Summary

Auto Scaling ensures your application always has the right number of EC2 instances — automatically growing during high demand and shrinking during quiet periods. Always

use Launch Templates over Launch Configurations for new ASGs, configure multiple AZs for high availability, and combine Scheduled Scaling (for predictable patterns) with Target Tracking (for dynamic demand) for optimal cost and performance.

---
---

# 14. 📊 Amazon CloudWatch

---

## 14.1 What is Amazon CloudWatch?

**Amazon CloudWatch** is AWS's **monitoring and observability service** — it collects metrics, logs, and events from your AWS resources and applications in real time, and lets you set alarms and automated actions based on those observations.

Think of CloudWatch like the **dashboard and nervous system** of your AWS environment. Just like a car's dashboard shows you speed, fuel, engine temperature, and alerts you when something is wrong, CloudWatch shows you CPU utilization, memory, request rates, error counts — and alerts your team before problems become outages.

---

## 14.2 Key Components

### 📌 Metrics
**Metrics** are the core data points CloudWatch collects — numerical values that change over time.

- Each AWS service automatically sends **default metrics** to CloudWatch
- **Basic Monitoring** (free): Data points sent every **5 minutes**
- **Detailed Monitoring** (paid): Data points sent every **1 minute** — enabled per instance
- You can create **Custom Metrics** for your own application data (e.g., number of orders per minute, active user sessions)

**Key EC2 default metrics:**
| Metric | What It Measures |
|---|---|
| `CPUUtilization` | Percentage of CPU in use |
| `NetworkIn` / `NetworkOut` | Bytes transferred in/out |
| `DiskReadOps` / `DiskWriteOps` | Disk operations per second |
| `StatusCheckFailed` | Instance or system health failure |

⚠️ **Important:** CloudWatch does **NOT** collect memory utilization or disk space from EC2 by default. You need to install the **CloudWatch Agent** on your instance to get these metrics.

### 📌 Alarms
An **Alarm** watches a single metric and performs an action when the metric breaches a threshold for a defined period.

**Three alarm states:**
| State | Meaning |
|---|---|
| **OK** | Metric is within threshold — everything normal |
| **ALARM** | Metric has breached the threshold — action triggered |
| **INSUFFICIENT_DATA** | Not enough data to determine state (usually at startup) |

**Alarm actions available:**
- Send notification via **SNS** (email, SMS, PagerDuty, Slack webhook)
- **Auto Scaling** action (scale out or scale in)
- **EC2 action** (stop, terminate, reboot, or recover instance)

### 📌 Dashboards
CloudWatch Dashboards provide a **centralized visual display** of your metrics across all AWS services and regions.

**Free tier:** 3 dashboards with up to 50 metrics each — free per month
**Paid:** $3.00 per additional dashboard per month

### 📌 CloudWatch Logs
Collect, monitor, store, and access **log files** from:
- EC2 instances (application logs, system logs)
- AWS Lambda (function execution logs)
- AWS CloudTrail (API call logs)
- Amazon Route 53 (DNS query logs)
- VPC Flow Logs

**Log concepts:**
- **Log Group:** Container for log streams from the same source (e.g., `/aws/lambda/my-function`)
- **Log Stream:** Sequence of log events from a single instance or function
- **Log Events:** Individual log entries with timestamp and message
- **Retention Period:** How long to keep logs (1 day to 10 years, or never expire)
- **Metric Filters:** Extract metric data from log text (e.g., count ERROR occurrences in logs)

### 📌 CloudWatch Events (EventBridge)
Delivers a **near real-time stream of system events** describing changes in AWS resources.

Think of it as an **event bus** — AWS services publish events, and you define rules to route those events to targets (Lambda, SQS, SNS, EC2 actions, etc.).

**Example events:**
- EC2 instance changes state (running → stopped)
- S3 object uploaded to a bucket
- CodePipeline deployment completes or fails
- Scheduled events (cron-like rules — "run every day at 2 AM")

**Supported targets for CloudWatch Events:**
- Lambda functions
- EC2 instances
- SNS topics
- SQS queues
- ECS tasks
- Step Functions state machines
- CodePipeline pipelines
- Kinesis Data Streams
- Built-in targets (EC2 stop, reboot, terminate)

---

## 14.3 CloudWatch Agent

The **CloudWatch Agent** is software you install on EC2 instances to send additional metrics and logs that AWS doesn't collect by default:

- **Memory utilization** (`mem_used_percent`)
- **Disk space used** (`disk_used_percent`)
- **Swap usage**
- **Custom application log files** (e.g., `/var/log/myapp/application.log`)
- **Windows Performance Counters**

**How to install (Amazon Linux):**
```bash
# Install CloudWatch Agent
sudo yum install -y amazon-cloudwatch-agent

# Configure using wizard
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard

# Start agent
sudo systemctl start amazon-cloudwatch-agent
sudo systemctl enable amazon-cloudwatch-agent
```

---

## 14.4 Billing Alerts with CloudWatch

Monitor your AWS spending and get notified before your bill exceeds a budget:

```
Steps:
1. Login as Root user → My Account → Preferences → Enable "Receive Billing Alerts"
2. Navigate to CloudWatch (must use us-east-1 — N. Virginia for billing)
3. CloudWatch → Alarms → Billing → Create Alarm
4. Select metric: "Total Estimated Charge"
5. Set threshold: e.g., alert when charges exceed $50
6. Action: Send SNS notification to your email
7. Save alarm

Result: You receive an email when your monthly AWS bill approaches $50
```

---

## 14.5 CloudWatch Free Tier Summary

| Feature | Free Tier |
|---|---|
| Metrics | 10 custom metrics and 10 alarms |
| API requests | 1 million API requests/month |
| Logs | 5 GB ingestion and 5 GB archive |
| Dashboards | 3 dashboards (50 metrics each) |
| Basic monitoring | Free for EC2, EBS, ELB, RDS |

---

## 14.6 Integration with Other AWS Services

| Service | CloudWatch Integration |
|---|---|
| **EC2** | CPU, network, disk metrics automatically sent |
| **RDS** | Database CPU, connections, read/write IOPS |
| **ELB** | Request count, latency, healthy host count |
| **Lambda** | Invocations, duration, errors, throttles |
| **Auto Scaling** | Trigger scaling actions based on CloudWatch alarms |
| **SNS** | Alarm notifications delivered via SNS |
| **S3** | Storage metrics, request counts |
| **DynamoDB** | Read/Write capacity consumed, throttled requests |
| **CloudTrail** | API activity logs streamed to CloudWatch Logs |

---

## 14.7 Real-Time DevOps Production Scenario

**Application:** A production payment processing API — needs strict monitoring, instant alerts, and comprehensive logging for compliance.

**Metrics Strategy:**
```
System Metrics (via CloudWatch default):
├── EC2 CPUUtilization → Alert if > 80% for 5 minutes
├── ELB TargetResponseTime → Alert if > 1 second (payment SLA)
├── ELB HealthyHostCount → Alert if < 2 (availability risk)
└── RDS CPUUtilization → Alert if > 75%

Application Metrics (via CloudWatch Agent):
├── Memory utilization → Alert if > 85%
├── Disk space → Alert if > 80%
└── Custom metric: PaymentFailureRate → Alert if > 2%

Business Metrics (Custom — published via API):
├── TransactionsPerMinute → Dashboard widget
├── AverageTransactionValue → Dashboard widget
└── PaymentGatewayLatency → Alert if > 500ms
```

**CloudWatch Logs Architecture:**
```
EC2 Application Logs (/var/log/payment-api/app.log)
    ↓ CloudWatch Agent
    → CloudWatch Log Group: /prod/payment-api/application

Log Group Metric Filters:
├── Filter "ERROR" → Custom metric: PaymentErrors
├── Filter "TIMEOUT" → Custom metric: PaymentTimeouts
└── Filter "FRAUD_DETECTED" → Alert immediately via SNS

Log Retention: 90 days (compliance requirement)
After 90 days: Export to S3 → Glacier Deep Archive (7-year retention)
```

**CloudWatch Dashboard — "Payment API Health":**
```
Row 1: Current status — Healthy instances, Request rate, Error rate
Row 2: Performance — Response time P50/P95/P99, CPU average
Row 3: Business — Transactions/min, Revenue/hour, Failed payments
Row 4: Infrastructure — Memory %, Disk %, DB connections
```

**Alarm Escalation Policy:**
```
Level 1 (Warning):  CPU > 70% → Email to DevOps team
Level 2 (Critical): CPU > 85% → Email + SMS + PagerDuty call
Level 3 (Emergency):HealthyHosts < 2 → PagerDuty + Auto-Scale immediately
```

**CloudWatch Events Automation:**
```
Event: EC2 instance enters "stopped" state unexpectedly
    ↓ CloudWatch Event rule detects
    ↓ Triggers Lambda function
    ↓ Lambda sends Slack message with instance details
    ↓ Lambda triggers Auto Scaling to maintain desired capacity
```

**Monitoring Approach:**
- 24/7 monitoring via CloudWatch Alarms
- SNS → PagerDuty integration for on-call rotation
- Weekly CloudWatch Insights queries to analyze error trends
- Monthly performance reports generated from CloudWatch metrics

---

## 14.8 Benefits

- **Real-time visibility** — Know what's happening in your environment right now
- **Automated response** — Alarms trigger Auto Scaling, Lambda, or EC2 actions automatically
- **Centralized** — All AWS services send metrics to one place
- **Cost monitoring** — Track spend and set budget alerts
- **Log management** — Store, search, and analyze logs at scale
- **Custom metrics** — Monitor anything your application generates
- **Free tier** — Generous free tier for basic monitoring

---

## 14.9 Common Use Cases

- CPU/memory/disk utilization monitoring and alerting
- Application error rate monitoring
- Billing alerts to prevent surprise AWS bills
- Auto Scaling trigger based on custom application metrics
- Centralized log management across all EC2 instances
- Security monitoring — alert on unusual API activity
- Business metric dashboards for operations teams
- Automated responses to infrastructure events

---

## 14.10 Summary

CloudWatch is the eyes and ears of your AWS infrastructure. It collects metrics, stores logs, triggers alarms, and responds to events — automatically. Install the CloudWatch Agent on EC2 for memory and disk metrics. Create alarms that notify your team and trigger Auto Scaling before problems escalate. Build dashboards that give your team a single-pane view of system health. Use CloudWatch Logs to centralize and analyze logs from every component of your application.

---
---

# 15. 🌐 Amazon Route 53

---

## 15.1 What is Amazon Route 53?

**Amazon Route 53** is AWS's highly available, scalable **DNS (Domain Name System) and domain registration service**.

Think of DNS like a **phone book for the internet**. When you type `www.amazon.com` in your browser, Route 53 translates that human-friendly name into the IP address (like `205.251.242.103`) that computers use to actually connect.

**Why "Route 53"?** DNS uses **port 53** — that's where the name comes from.

Route 53 is an **authoritative DNS** service — it has the final answer for DNS queries about your domains.

---

## 15.2 Key DNS Concepts

### Domain Name Structure
```
http://api.myapp.com
            |   |
            |   └── Top-Level Domain (TLD): .com
            └────── Second-Level Domain: myapp
                    Subdomain: api
```

**Top-Level Domains (TLDs)** are managed by **IANA (Internet Assigned Numbers Authority)** — `.com`, `.net`, `.org`, `.gov`, `.io`, etc.

### Domain Registration
- You purchase domain names from a **registrar** (GoDaddy, BigRock, Route 53 itself)
- Domain becomes registered in the **WHOIS database**
- Route 53 can act as your domain registrar and/or your DNS provider

### Name Servers (NS Records)
Name servers are computers that **translate domain names to IP addresses**.
- When you register a domain, you point it to name servers
- Route 53 provides name servers for your hosted zone
- These NS records tell the internet "go to these servers for DNS info about this domain"

---

## 15.3 Record Types

| Record Type | Purpose | Example |
|---|---|---|
| **A** | Maps domain name to IPv4 address | `myapp.com → 54.23.11.45` |
| **AAAA** | Maps domain name to IPv6 address | `myapp.com → 2001:db8::1` |
| **CNAME** | Alias pointing to another domain name | `www.myapp.com → myapp.com` |
| **MX** | Mail exchange — where to send emails for domain | `myapp.com → mail.myapp.com` |
| **NS** | Name server records for the hosted zone | Points to Route 53 name servers |
| **SOA** | Start of Authority — metadata about the zone | Zone serial, refresh intervals |
| **PTR** | Reverse lookup — IP address to domain name | `54.23.11.45 → myapp.com` |
| **TXT** | Text information — domain verification, SPF records | `"v=spf1 include:..."` |
| **SRV** | Service location — hostname and port for services | VoIP, gaming services |
| **Alias** | AWS-specific — like CNAME but for root domain | `myapp.com → ALB DNS name` |

**Important:** Use **Alias records** (not CNAME) for AWS resources like ELB, CloudFront, S3 websites — Alias records work at the root domain level and are free of charge for DNS queries.

---

## 15.4 Hosted Zones

A **Hosted Zone** is a container for DNS records for a specific domain.

| Type | Description |
|---|---|
| **Public Hosted Zone** | Routes internet traffic to your domain (accessible from internet) |
| **Private Hosted Zone** | Routes traffic within one or more VPCs (internal DNS resolution) |

When you create a hosted zone, Route 53 automatically creates:
- **NS record** — four name servers for your domain
- **SOA record** — metadata about the zone

**Private Hosted Zone use case:** Internally resolve `database.internal` to your RDS endpoint without exposing it to the internet.

---

## 15.5 Routing Policies

Route 53 offers **seven routing policies** — the most important differentiator from other DNS services:

### 🔵 Simple Routing Policy
- **Default policy** — one resource serves the domain
- DNS returns the same answer every time
- If multiple IP addresses defined — returns all of them in random order (client picks one)
- **No health checks**
- **Use case:** Single web server, single resource

### 🟡 Weighted Routing Policy
- Route traffic to **multiple resources in specified proportions**
- Assign a weight (0–255) to each record — Route 53 sends traffic proportionally

```
Example: A/B Testing
Record 1: New version (v2) → Weight 10 → Gets 10% of traffic
Record 2: Old version (v1) → Weight 90 → Gets 90% of traffic
```

**Use cases:**
- **Load balancing** across regions
- **A/B testing** (send 10% to new feature, 90% to stable version)
- **Gradual rollout** (slowly shift traffic from old to new)

### 🟠 Latency-Based Routing Policy
- Routes users to the **AWS region with lowest network latency** for that user
- You create records in multiple regions — Route 53 serves the one with best latency

```
Example:
User in India → ap-south-1 (Mumbai) — lowest latency for them
User in USA  → us-east-1 (Virginia) — lowest latency for them
User in UK   → eu-west-2 (London)  — lowest latency for them
```

**Use case:** Global applications where you want each user to get the fastest experience.

### 🔴 Failover Routing Policy
- **Active-passive failover** configuration
- Route 53 monitors your primary resource with a **health check**
- If primary fails health check → automatically routes traffic to secondary (DR) resource
- When primary recovers → automatically routes back

```
Primary:   EC2 in us-east-1 → health check monitors /health endpoint
Secondary: EC2 in ap-south-1 (Disaster Recovery site)

Normal: All traffic → Primary (us-east-1)
If primary fails: All traffic → Secondary (ap-south-1) automatically
When primary recovers: Traffic returns to Primary
```

**Use case:** High-availability applications with a dedicated disaster recovery site.

### 🟣 Geolocation Routing Policy
- Routes traffic based on the **geographic location of the user** (where the DNS query originates)
- More precise than Latency-Based — you explicitly control which users go where

```
Example:
Users from India → ap-south-1 Mumbai servers (local language content, INR pricing)
Users from Europe → eu-west-1 Ireland servers (GDPR-compliant, EUR pricing)
Users from USA → us-east-1 Virginia servers (USD pricing)
Default → Any other location → global-default servers
```

**Use cases:**
- Content localization (local language, local pricing)
- Compliance (EU user data must stay in EU)
- Restrict content to certain countries
- Load balancing by user geography

### 🟤 Multivalue Answer Routing Policy
- Returns **up to 8 healthy records** randomly for each DNS query
- Route 53 performs health checks and only returns healthy records
- Provides basic **client-side load balancing** without an actual load balancer
- **Not a substitute for ELB** — but useful for simple scenarios

### ⚪ Geoproximity Routing Policy (Traffic Flow)
- Routes traffic based on geographic location of resources and users
- You can **bias** traffic toward or away from specific resources
- Requires Route 53 **Traffic Flow** (visual policy editor)

---

## 15.6 Health Checks

Route 53 Health Checks monitor the health of your endpoints:

**What can be monitored:**
- HTTP/HTTPS endpoint (checks response code and optionally content)
- TCP connection
- Other CloudWatch alarms
- Calculated health checks (combine multiple health checks)

**Health check configuration:**
- **Protocol:** HTTP, HTTPS, or TCP
- **IP/Domain:** What to check
- **Port:** Which port
- **Path:** URL path for HTTP/HTTPS (e.g., `/health`)
- **Interval:** 10 or 30 seconds
- **Failure threshold:** 3 consecutive failures = unhealthy

---

## 15.7 Integration with Other AWS Services

| Service | Route 53 Integration |
|---|---|
| **ELB** | Alias record pointing domain to ELB DNS name |
| **CloudFront** | Alias record pointing domain to CloudFront distribution |
| **S3** | Alias record for S3 static website hosting |
| **EC2** | A record pointing to Elastic IP |
| **Elastic Beanstalk** | Alias record for Beanstalk environment URL |
| **API Gateway** | Custom domain mapping via Route 53 |
| **VPC** | Private hosted zones for internal DNS resolution |
| **CloudWatch** | Health check failures can trigger CloudWatch alarms |

---

## 15.8 Real-Time DevOps Production Scenario

**Application:** A global SaaS platform with users in India, USA, and Europe — requires high availability, low latency, and disaster recovery.

**Domain Setup:**
```
Registered Domain: myplatform.io (registered via Route 53)
Hosted Zone: myplatform.io (Public)

Subdomains:
├── www.myplatform.io → Main web app
├── api.myplatform.io → REST API
├── cdn.myplatform.io → CloudFront (static assets)
├── admin.myplatform.io → Internal admin panel
└── db.internal.myplatform.io → RDS (Private Hosted Zone)
```

**Routing Strategy:**

*Latency-Based Routing for API:*
```
api.myplatform.io:
├── Region: ap-south-1 (Mumbai ALB) → serves Indian users
├── Region: us-east-1 (Virginia ALB) → serves US users
└── Region: eu-west-1 (Ireland ALB) → serves European users

Result: Every user automatically routed to the nearest/fastest region
```

*Failover Routing for Critical Admin:*
```
admin.myplatform.io:
├── Primary: us-east-1 ALB (Health Check: /health every 10 seconds)
└── Secondary: ap-south-1 ALB (DR site — activates if primary fails)

Result: Admin always available, automatic failover with ~60-second RTO
```

*Weighted Routing for Deployment (Blue-Green):*
```
New version deployment:
├── v2 (new version): Weight 10 → 10% canary traffic
└── v1 (stable): Weight 90 → 90% production traffic

Monitor: Error rates, latency for v2 traffic
If stable: Gradually increase v2 weight to 100%, then remove v1
If issues: Change v2 weight to 0 instantly — instant rollback
```

*Geolocation Routing for Compliance:*
```
/user-data API endpoint:
├── European users → eu-west-1 (GDPR compliant — data stays in EU)
├── Indian users → ap-south-1 (data stays in India — compliance)
└── All others → us-east-1 (global default)
```

**Private Hosted Zone (Internal DNS):**
```
Zone: internal.myplatform.io (attached to Production VPC)

Records:
├── db.internal → RDS cluster endpoint (no public DNS needed)
├── cache.internal → ElastiCache cluster endpoint
├── queue.internal → SQS queue URL
└── search.internal → Elasticsearch endpoint

Benefit: Services communicate using friendly internal names
         If endpoints change, update ONE Route 53 record — all services auto-pick up
```

**Monitoring:**
- Health Checks: Every endpoint monitored every 10 seconds
- CloudWatch: Alert if health check fails for any region
- Route 53 Resolver logs: Monitor DNS query patterns for security anomalies

---

## 15.9 Benefits

- **Highly available and reliable** — Distributed globally, 100% SLA
- **Low latency** — DNS responses delivered from nearest Route 53 location worldwide
- **Intelligent routing** — Seven routing policies for any use case
- **Health checking** — Automatic failover on endpoint failures
- **Domain registration** — One-stop shop for domain and DNS management
- **Deep AWS integration** — Alias records for ELB, CloudFront, S3 at no query cost
- **Private DNS** — Internal DNS resolution within VPCs

---

## 15.10 Common Use Cases

- Domain registration and DNS management for web applications
- Global traffic routing with latency-based or geolocation policies
- Disaster recovery with automatic failover routing
- Blue-green and canary deployments with weighted routing
- A/B testing of new application versions
- Compliance-driven geographic traffic routing
- Internal service discovery with private hosted zones
- CDN integration (Route 53 → CloudFront → S3/EC2)

---

## 15.11 Summary

Route 53 is AWS's DNS service that translates domain names to IP addresses and intelligently routes traffic. Its seven routing policies — Simple, Weighted, Latency, Failover, Geolocation, Multivalue, and Geoproximity — make it a powerful tool for building globally available, resilient applications. Always use Alias records (not CNAME) for AWS resources. Use health checks with Failover routing for automatic disaster recovery. Use Private Hosted Zones for clean internal service discovery within your VPC.

---
---

# 16. 🔒 VPC — Virtual Private Cloud

---

## 16.1 What is Amazon VPC?

**Amazon VPC (Virtual Private Cloud)** is your own **logically isolated, private network** within the AWS cloud — similar to designing and operating a traditional data center network, but in the cloud.

Think of VPC like a **fenced-off section of AWS** that only you can access. Within your VPC, you define IP address ranges, create subnets, set up routing rules, and control all network traffic — just like configuring a physical network, but without any physical hardware.

**Every AWS account gets a default VPC** in each region — pre-configured and ready to use immediately.

---

## 16.2 Key Components

### CIDR Block (IP Address Range)
When you create a VPC, you assign a **CIDR (Classless Inter-Domain Routing)** block — the IP address range for your entire VPC.

```
Example CIDR blocks:
10.0.0.0/16    → 65,536 total IP addresses (recommended for production)
192.168.0.0/16 → 65,536 total IP addresses
172.16.0.0/16  → 65,536 total IP addresses

Rules:
- Minimum: /28 (16 IP addresses)
- Maximum: /16 (65,536 IP addresses)
- Cannot be changed after VPC creation
- Must not overlap with networks you want to connect to (on-premises, peered VPCs)
```

### Subnets
A **Subnet** is a **segment** of your VPC's IP address range where you launch resources.

**Key rules:**
- One subnet = One Availability Zone (but one AZ can have multiple subnets)
- Subnets cannot span AZs

**Three types of subnets:**

| Type | Route to Internet? | Use Case |
|---|---|---|
| **Public Subnet** | Yes — has route to Internet Gateway | Web servers, load balancers, NAT gateways |
| **Private Subnet** | No — no route to Internet Gateway | Application servers, databases |
| **VPN-Only Subnet** | Via Virtual Private Gateway only | On-premises connected resources |

**In each subnet, AWS reserves 5 IP addresses** (first 4 and last 1):
```
For subnet 10.0.1.0/24:
10.0.1.0   → Network address
10.0.1.1   → VPC router
10.0.1.2   → DNS
10.0.1.3   → Reserved for future use
10.0.1.255 → Broadcast address
→ Usable: 10.0.1.4 – 10.0.1.254 = 251 addresses
```

### Internet Gateway (IGW)
An **Internet Gateway** allows communication between instances in your VPC and the internet.

**Key facts:**
- Horizontally scaled, redundant, highly available — AWS manages it
- **One IGW per VPC** — you cannot attach multiple
- After creating, must **Attach to VPC** explicitly
- EC2 instances need a **public IP or Elastic IP** to communicate through the IGW
- To enable internet access for a subnet:
  1. Attach IGW to VPC
  2. Add route `0.0.0.0/0 → IGW` to the subnet's route table
  3. Ensure instances have public IPs

### Route Tables
A **Route Table** contains rules (routes) that determine where network traffic is directed.

```
Example Route Table (Public Subnet):
Destination       Target
10.0.0.0/16      local           ← All VPC traffic stays internal
0.0.0.0/0        igw-xxxxxxxx   ← All other traffic goes to Internet Gateway
```

```
Example Route Table (Private Subnet):
Destination       Target
10.0.0.0/16      local           ← All VPC traffic stays internal
0.0.0.0/0        nat-xxxxxxxx   ← Internet access via NAT Gateway
```

**Rules:**
- Every VPC has a **main route table** (default, modifiable)
- Subnets not explicitly associated use the main route table
- You can create custom route tables per subnet
- The most specific route wins (longest prefix match)

### Security Groups
- **Stateful virtual firewall** at the **instance level**
- Allow rules only (no deny rules)
- Changes take effect immediately
- *(Covered in detail in EC2 section)*

### Network Access Control Lists (NACLs)
- **Stateless firewall** at the **subnet level**
- Supports both **Allow AND Deny** rules
- Rules evaluated in **numbered order** (lowest number first)
- **Stateless** — must explicitly allow both inbound and outbound for a connection

**Security Group vs NACL:**

| Feature | Security Group | Network ACL |
|---|---|---|
| Level | Instance | Subnet |
| Rules | Allow only | Allow and Deny |
| Stateful/Stateless | Stateful ✅ | Stateless ❌ |
| Rule evaluation | All rules evaluated | Number order (first match wins) |
| Default | Deny all inbound, allow all outbound | Allow all inbound and outbound |
| Scope | Applied to specific instances | Applied to all instances in subnet |

**Ephemeral Ports** — Remember to open these in NACLs for return traffic:
| Service | Port Range |
|---|---|
| Linux clients | 32768–61000 |
| Windows Server 2008+ | 49152–65535 |
| ELB | 1024–65535 |
| NAT Gateway | 1024–65535 |

---

## 16.3 NAT — Network Address Translation

Private subnet instances need internet access for software updates and external API calls, but shouldn't be directly reachable from the internet. **NAT** provides outbound internet access for private instances.

### NAT Instance (Legacy)
- An EC2 instance in the **public subnet** acting as a NAT device
- Uses a special **Amazon Linux NAT AMI** (found in Community AMIs by searching "NAT")
- **Must disable Source/Destination Check** on the NAT instance — because NAT traffic is neither from nor to the NAT instance itself
- Add route `0.0.0.0/0 → NAT Instance ID` to private subnet route table
- **Performance depends on instance size** — upgrade instance type if bottlenecking
- **Single point of failure** unless you build HA yourself
- Security group must allow HTTP (80) and HTTPS (443) outbound

### NAT Gateway (Recommended)
A **managed, highly available** NAT solution — no EC2 to manage.

| Feature | NAT Gateway | NAT Instance |
|---|---|---|
| Management | Fully managed by AWS | You manage EC2 |
| Availability | Highly available within AZ | Single instance — single point of failure |
| Bandwidth | Up to 45 Gbps | Depends on instance size |
| Security Groups | Not associated | Must configure |
| Source/Destination Check | Not needed | Must disable |
| Patching | Automatic | Manual |
| Cost | Hourly + data processing | EC2 instance cost |

**Creating a NAT Gateway:**
```
Steps:
1. VPC Console → NAT Gateways → Create NAT Gateway
2. Select: Public Subnet (NAT must be in PUBLIC subnet)
3. Allocate or assign an Elastic IP (required)
4. Create

Then update Private Subnet route table:
Destination: 0.0.0.0/0 → Target: nat-xxxxxxxx (NAT Gateway ID)
```

⚠️ **Important:** For high availability, create **one NAT Gateway per AZ**. If your NAT Gateway is in AZ-1a and that AZ goes down, private instances in AZ-1b lose internet access.

---

## 16.4 VPC Peering

**VPC Peering** connects two VPCs privately — instances communicate as if they're in the same network.

**Key rules:**
- Works within the **same AWS account** or **between different accounts**
- Works within the **same region** (Inter-Region peering also available)
- **No transitive peering** — if A peers with B, and B peers with C, A **cannot** reach C through B
- CIDRs of peered VPCs **cannot overlap**
- One-to-one relationship between VPCs
- Request/accept protocol — requester sends request, peer VPC owner accepts within 1 week

```
Valid:   VPC-A ↔ VPC-B ↔ VPC-C    (A↔B works, B↔C works, but A cannot reach C)
To fix:  Create separate peering A↔C
```

---

## 16.5 VPC Flow Logs

**VPC Flow Logs** capture information about **IP traffic flowing through your VPC**, subnets, or network interfaces.

**What's captured:**
```
Version  AccountID  InterfaceID  SrcAddr  DstAddr  SrcPort  DstPort  Protocol  Packets  Bytes  Start  End  Action  LogStatus
```

**Can be stored in:**
- **Amazon CloudWatch Logs** (real-time analysis)
- **Amazon S3** (long-term storage, Athena queries)

**Use cases:**
- Security analysis — detect unexpected traffic flows
- Troubleshoot connectivity issues
- Compliance and audit logging
- Network performance analysis

---

## 16.6 Bastion Host

A **Bastion Host** (jump server) is an EC2 instance in the **public subnet** used to securely SSH/RDP into instances in **private subnets**.

```
Architecture:
Internet → SSH to Bastion Host (Public Subnet)
         → SSH from Bastion to Private Instance (Private Subnet)

Security:
Bastion Security Group: Allow SSH (22) from YOUR IP only (not 0.0.0.0/0)
Private Instance Security Group: Allow SSH (22) from Bastion Security Group only
```

This means private instances are **never directly reachable from the internet** — all access goes through the bastion.

---

## 16.7 VPC Endpoints

**VPC Endpoints** allow your VPC to **privately connect to AWS services** without requiring an Internet Gateway, NAT, or VPN.

```
Without endpoint: EC2 → Internet Gateway → Public Internet → S3 (charges + security risk)
With endpoint:    EC2 → VPC Endpoint → S3 (private, no internet, cheaper)
```

**Two types:**
- **Gateway Endpoint:** For S3 and DynamoDB — free
- **Interface Endpoint:** For most other AWS services — small hourly charge

---

## 16.8 VPC Design — Full Custom VPC Walkthrough

**Use Case:**
- Production VPC: `192.168.0.0/16`
- Public Subnet (Web): `192.168.1.0/24` in AZ-1a → Web servers
- Private Subnet (DB): `192.168.2.0/24` in AZ-1b → Database servers

**Step-by-Step:**

```
STEP 1: Create VPC
  Name: Production-VPC
  CIDR: 192.168.0.0/16
  Tenancy: Default

STEP 2: Create Subnets
  Subnet 1: Production-Public
    VPC: Production-VPC
    AZ: ap-south-1a
    CIDR: 192.168.1.0/24
  
  Subnet 2: Production-Private
    VPC: Production-VPC
    AZ: ap-south-1b
    CIDR: 192.168.2.0/24

STEP 3: Create & Attach Internet Gateway
  Name: Production-IGW
  Action: Attach to Production-VPC

STEP 4: Create Public Route Table
  Name: Production-Public-RT
  VPC: Production-VPC
  Routes:
    10.0.0.0/16 → local
    0.0.0.0/0  → Production-IGW
  Subnet Association: Production-Public subnet

STEP 5: Create NAT Gateway
  Subnet: Production-Public (must be public!)
  EIP: Allocate new EIP

STEP 6: Update Main Route Table (for Private Subnet)
  Routes:
    192.168.0.0/16 → local
    0.0.0.0/0      → NAT Gateway ID

STEP 7: Enable Auto-assign Public IP for Public Subnet
  Subnet Settings → Enable auto-assign public IPv4

STEP 8: Launch Instances
  Web Server → Public Subnet → Gets public IP
  DB Server  → Private Subnet → No public IP
```

---

## 16.9 Integration with Other AWS Services

| Service | VPC Integration |
|---|---|
| **EC2** | All instances launched inside VPC |
| **RDS** | DB instances in private subnets for security |
| **ELB** | Load balancers deployed across VPC subnets |
| **Lambda** | Lambda functions deployed inside VPC for private resource access |
| **ECS/EKS** | Containers run in VPC subnets |
| **Direct Connect** | Connect on-premises network to VPC |
| **VPN** | Site-to-site VPN via Virtual Private Gateway |
| **S3/DynamoDB** | VPC Endpoints for private connectivity |
| **CloudWatch** | VPC Flow Logs sent to CloudWatch or S3 |

---

## 16.10 Real-Time DevOps Production Scenario

**Application:** A 3-tier banking application — web tier, application tier, database tier — with strict security and compliance requirements.

**VPC Architecture:**
```
Production VPC: 10.0.0.0/16 (Region: ap-south-1)
│
├── Public Subnets (Internet-facing)
│   ├── 10.0.1.0/24 (AZ: ap-south-1a) → ALB + NAT Gateway
│   └── 10.0.2.0/24 (AZ: ap-south-1b) → ALB + NAT Gateway
│
├── Application Subnets (Private — only accessible from public tier)
│   ├── 10.0.3.0/24 (AZ: ap-south-1a) → App servers (Node.js)
│   └── 10.0.4.0/24 (AZ: ap-south-1b) → App servers (Node.js)
│
├── Database Subnets (Private — only accessible from app tier)
│   ├── 10.0.5.0/24 (AZ: ap-south-1a) → RDS Primary
│   └── 10.0.6.0/24 (AZ: ap-south-1b) → RDS Standby (Multi-AZ)
│
└── Management Subnet (Private)
    └── 10.0.7.0/24 (AZ: ap-south-1a) → Bastion Host, monitoring tools
```

**Security Layers:**
```
Layer 1 — NACL (Subnet level):
  Public Subnet NACL:
    Inbound: Allow 443, 80 from 0.0.0.0/0
    Inbound: Allow ephemeral ports (1024-65535) from 0.0.0.0/0
    Outbound: Allow all

  Private App NACL:
    Inbound: Allow 3000 (Node.js) from 10.0.1.0/24, 10.0.2.0/24 (public subnets only)
    Deny: Everything else explicitly

  Database NACL:
    Inbound: Allow 3306 (MySQL) from 10.0.3.0/24, 10.0.4.0/24 (app subnets only)
    Deny: All other inbound — databases unreachable from anywhere else

Layer 2 — Security Groups (Instance level):
  ALB-SG: Allow 443 from 0.0.0.0/0
  App-SG: Allow 3000 from ALB-SG only
  DB-SG: Allow 3306 from App-SG only
  Bastion-SG: Allow 22 from Company-IP-Range only
```

**Traffic Flow:**
```
User → HTTPS:443 → ALB (Public Subnet)
     → HTTP:3000 → App Servers (Private App Subnet)
     → MySQL:3306 → RDS (Private DB Subnet)

Admin → SSH:22 → Bastion (Management Subnet)
      → SSH:22 → App Server (Private — only from Bastion)

App Server → HTTPS → NAT Gateway (Public Subnet) → Internet (for payment gateway API calls)
```

**VPC Flow Logs Configuration:**
- Flow Logs enabled on all subnets
- Logs stored in S3 → analyzed with Athena for security anomalies
- CloudWatch Alarms: Alert if unusual ports accessed on DB subnet

---

## 16.11 Benefits

- **Complete network control** — Define your own IP ranges, subnets, route tables
- **Isolation** — Your resources are logically isolated from other AWS customers
- **Security** — Multiple layers (NACLs, Security Groups, private subnets)
- **Flexibility** — Public and private subnets for different tiers
- **Connectivity** — Connect to on-premises via Direct Connect or VPN
- **Compliance** — Keep sensitive data in private subnets, never internet-exposed
- **Integration** — All major AWS services support VPC deployment

---

## 16.12 Summary

VPC is your private, isolated network inside AWS where you deploy all your resources. Design with multiple subnets across multiple AZs for high availability. Use public subnets for internet-facing resources and private subnets for databases and internal servers. Use NAT Gateways for outbound internet from private subnets, NACLs for subnet-level firewall rules, and Security Groups for instance-level firewalls. VPC is the foundation of all production AWS architecture — get this right and everything else becomes easier.

---
---

# 17. 🗃️ Amazon RDS — Relational Database Service

---

## 17.1 What is Amazon RDS?

**Amazon RDS (Relational Database Service)** is a **fully managed service** that makes it easy to set up, operate, and scale relational databases in the cloud — without managing the underlying infrastructure.

Think of RDS like **outsourcing your DBA (Database Administrator) work to AWS**. AWS handles hardware provisioning, OS patching, database engine patches, automated backups, monitoring, and failover — you focus on your schema, queries, and application.

**The alternative** is running a database engine on an EC2 instance yourself — which gives more control but requires you to handle everything (patching, backups, HA, replication, storage management).

---

## 17.2 Supported Database Engines

| Engine | Type | Best For |
|---|---|---|
| **Amazon Aurora** | MySQL/PostgreSQL compatible, AWS-optimized | High-performance, highly available apps |
| **MySQL** | Open source relational DB | Web apps, blogs, e-commerce |
| **PostgreSQL** | Advanced open source relational DB | Complex queries, geospatial, analytics |
| **MariaDB** | MySQL fork with enterprise features | MySQL workloads, MariaDB migrations |
| **Oracle** | Commercial enterprise database | Legacy enterprise apps |
| **Microsoft SQL Server** | Commercial Microsoft database | .NET apps, Windows workloads |

---

## 17.3 OLTP vs OLAP

| Type | Description | AWS Service |
|---|---|---|
| **OLTP** (Online Transaction Processing) | Frequent read/write operations, small transactions | RDS |
| **OLAP** (Online Analytical Processing) | Complex queries, large dataset analysis, reporting | Redshift |

**Rule:** Use RDS for transactional workloads. Use Redshift for analytical/reporting workloads.

---

## 17.4 RDS Instance Classes

| Family | Use Case | Examples |
|---|---|---|
| **Standard** | General purpose | db.m5.large, db.m5.xlarge |
| **Memory Optimized** | High-performance databases | db.r5.large, db.r5.2xlarge |
| **Burstable** | Dev/test, light workloads | db.t3.micro, db.t3.small |

---

## 17.5 Storage Options

| Type | Description | Max IOPS | Use Case |
|---|---|---|---|
| **General Purpose SSD (gp2)** | Baseline 3 IOPS/GB, bursts to 3,000 | 16,000 | Most workloads |
| **Provisioned IOPS SSD (io1)** | Consistent high IOPS | 80,000 | High-performance, IOPS-intensive |
| **Magnetic** | Legacy, low cost | 1,000 | Infrequent access, backward compatibility |

Storage scales from **20 GB to 64 TB** depending on engine and storage type.

---

## 17.6 Backup and Recovery

### Automated Backups
- Continuously backs up your database — full daily backup during the **backup window** + transaction logs throughout the day
- **Retention period:** 1–35 days (default: 7 days)
- Stored in S3 — free storage equal to RDS database size
- **Enables Point-in-Time Recovery (PITR)** — restore to any second within the retention period
- **Deleted when DB instance is deleted** — you lose automated backups when you delete the instance

### Manual DB Snapshots
- User-initiated at any time
- **Retained until you explicitly delete them** — persist even after DB deletion
- Can be shared with other AWS accounts or made public
- Can be copied to another region for cross-region DR

### Recovery
- **Always creates a NEW DB instance** — cannot restore to existing instance
- Gets a new endpoint DNS name
- PITR (using automated backup): Restore to specific timestamp, creates new instance
- Snapshot restore: Choose a snapshot, creates new instance

---

## 17.7 Multi-AZ Deployment

**Multi-AZ** creates a **synchronous standby replica** of your database in a different Availability Zone.

```
AZ-1a: Primary DB instance (active, handles all reads and writes)
        ↓ synchronous replication
AZ-1b: Standby DB instance (passive, cannot be read from directly)
```

**Key facts:**
- AWS **automatically handles replication** — you don't configure it
- **Automatic failover:** If primary fails, AWS promotes standby in ~1-2 minutes
- You **always use the same DNS endpoint** — the failover happens transparently
- **Standby is NOT for read scaling** — it cannot receive queries
- Available for all RDS engines
- Increases cost (you're running two instances)

**When failover occurs:**
- Primary AZ outage
- Primary DB instance failure
- Primary OS maintenance
- DB instance class change
- Manual failover triggered

**Multi-AZ = High Availability + Disaster Recovery (not for performance)**

---

## 17.8 Read Replicas

**Read Replicas** create **asynchronous read-only copies** of your primary database for scaling read-heavy workloads.

```
Primary DB (Read + Write)
    ↓ asynchronous replication
Read Replica 1 (Read Only) — same region
Read Replica 2 (Read Only) — different region
Read Replica 3 (Read Only) — can create replica of a replica
```

**Key facts:**
- Supported engines: MySQL, PostgreSQL, MariaDB, Aurora
- Up to **5 read replicas** per primary DB
- Can be in the **same region or different regions**
- Each read replica gets its own **DNS endpoint** — your app must direct reads to replica endpoints
- **Requires automated backups** to be enabled on source DB
- Can be **promoted to standalone DB** — breaks replication

**Read Replicas = Performance/Scaling (not for HA/DR)**

### Multi-AZ vs Read Replicas

| Feature | Multi-AZ | Read Replicas |
|---|---|---|
| Purpose | High availability, DR | Read scaling |
| Replication | Synchronous | Asynchronous |
| Readable? | No (standby passive) | Yes (read-only) |
| Failover | Automatic | Manual promotion |
| Cross-region? | No | Yes |
| Endpoint | Same endpoint (auto-switch) | New endpoint per replica |

---

## 17.9 Amazon Aurora

**Aurora** is AWS's own cloud-optimized relational database engine — compatible with **MySQL and PostgreSQL** but delivers significantly better performance.

**Key Aurora features:**

| Feature | Aurora | Standard MySQL |
|---|---|---|
| Performance | Up to 5x faster than MySQL | Baseline |
| Storage | Auto-scales up to 128 TB | Manual management |
| Copies | 6 copies across 3 AZs | Manual replication |
| Replicas | Up to 15 Aurora replicas | Up to 5 read replicas |
| Failover | ~30 seconds | ~1-2 minutes |
| Self-healing | Yes (auto-repairs corrupted data) | No |

**Aurora storage:** 2 copies in each of 3 AZs = **6 copies total** — can lose 2 copies without affecting writes, 3 copies without affecting reads.

**Aurora Serverless:** Database that automatically starts up, scales up, and shuts down based on actual application demand — pay per second, perfect for infrequent/unpredictable workloads.

---

## 17.10 RDS Licensing

| Engine | Licensing Model |
|---|---|
| MySQL, PostgreSQL, MariaDB | Open source — no additional license cost |
| Aurora | AWS-managed, included in RDS pricing |
| Oracle | **License Included** (AWS includes Oracle license) OR **BYOL** (Bring Your Own License) |
| SQL Server | **License Included** OR **BYOL** |

---

## 17.11 Integration with Other AWS Services

| Service | RDS Integration |
|---|---|
| **VPC** | RDS deployed in private subnets — no internet exposure |
| **EC2** | Application servers connect to RDS via DB endpoint |
| **IAM** | IAM DB Authentication — use IAM users to connect (MySQL, PostgreSQL) |
| **KMS** | Encrypt RDS storage with KMS keys |
| **CloudWatch** | DB metrics — CPU, connections, read/write IOPS, replication lag |
| **SNS** | RDS Event Notifications — instance reboots, failovers, backup completion |
| **S3** | Automated backup storage, snapshot export |
| **AWS Backup** | Centralized backup management across RDS instances |

---

## 17.12 Real-Time DevOps Production Scenario

**Application:** A high-traffic e-commerce platform — order management, product catalog, user accounts — using RDS MySQL with read-heavy workload.

**Architecture:**
```
Production Environment:
├── Primary RDS: db.r5.2xlarge (Multi-AZ)
│   ├── AZ-1a: Primary (handles all writes + some reads)
│   └── AZ-1b: Standby (automatic failover, no reads)
│
├── Read Replicas:
│   ├── Replica 1 (db.r5.xlarge) → ap-south-1a → Product catalog queries
│   ├── Replica 2 (db.r5.xlarge) → ap-south-1b → Order history queries
│   └── Replica 3 (db.r5.large) → us-east-1   → Cross-region DR + reporting
│
├── ElastiCache Redis in front of replicas → Cache hot product data
│
└── RDS Proxy → Connection pooling → Handles Lambda/serverless connection spikes
```

**Backup Strategy:**
```
Automated Backups:
  Window: 02:00–03:00 AM IST (lowest traffic)
  Retention: 14 days
  PITR: Enabled (restore to any minute in last 14 days)

Manual Snapshots:
  Before major deployments (safety net)
  Monthly snapshots retained for 1 year
  Cross-region copy: Snapshot copied to ap-southeast-1 for DR
```

**Application Connection Strategy:**
```python
# Application code uses separate endpoints
DB_WRITE_ENDPOINT = "mydb.cluster-xxxx.ap-south-1.rds.amazonaws.com"  # Primary
DB_READ_ENDPOINT  = "mydb.cluster-ro-xxxx.ap-south-1.rds.amazonaws.com"  # Read Replica

# Write operations: orders, user registration
db_write.execute("INSERT INTO orders ...")

# Read operations: product searches, order history
db_read.execute("SELECT * FROM products ...")
```

**Deployment Process:**
1. Pre-deployment: Take manual RDS snapshot (rollback point)
2. Deploy application changes to staging (uses separate RDS)
3. Run smoke tests against staging
4. Deploy to production during maintenance window
5. Monitor CloudWatch: connection count, query latency, CPU
6. If issue: Restore from pre-deployment snapshot (PITR to exact moment before deploy)

**Monitoring Approach:**
- CloudWatch Alarms: `CPUUtilization > 75%` → Alert DevOps team
- CloudWatch Alarms: `DatabaseConnections > 800` → Alert (connection limit approaching)
- CloudWatch Alarms: `ReplicaLag > 60 seconds` → Alert (replica falling behind)
- CloudWatch Alarms: `FreeStorageSpace < 20%` → Alert (storage running low)
- RDS Enhanced Monitoring: Per-process metrics (which query is using most CPU)
- Performance Insights: Identify slow queries and locking issues

---

## 17.13 Benefits

- **Fully managed** — AWS handles patching, backups, hardware failures
- **High availability** — Multi-AZ deployment with automatic failover
- **Scalability** — Read replicas for read scaling, storage auto-scaling
- **Multiple engines** — Choose from 6 database engines
- **Security** — VPC isolation, encryption at rest/transit, IAM authentication
- **Automated backups** — PITR with up to 35 days retention
- **Cost-effective** — Pay-as-you-go, no hardware purchase

---

## 17.14 Common Use Cases

- Web application backend databases (e-commerce, SaaS, mobile apps)
- ERP, CRM, and line-of-business application databases
- Multi-tier application data storage
- Read-heavy workloads scaled with read replicas
- Applications requiring ACID compliance and complex joins
- Replacing on-premises Oracle or SQL Server databases

---

## 17.15 Summary

RDS is a fully managed relational database service supporting MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, and Aurora. Use Multi-AZ for high availability with automatic failover. Use Read Replicas for read scaling. Use Aurora when you need maximum performance and availability. Always deploy RDS in private subnets, enable automated backups, set appropriate retention, and monitor with CloudWatch. Remember: Multi-AZ is for HA/DR, Read Replicas are for read scaling — don't confuse the two.

---
---

# 18. ⚡ Amazon DynamoDB

---

## 18.1 What is Amazon DynamoDB?

**Amazon DynamoDB** is a **fully managed, serverless NoSQL database** that delivers fast and consistent single-digit millisecond performance at any scale.

Think of DynamoDB like a **superfast key-value and document store** in the cloud. While RDS is like a spreadsheet with strict rows and columns, DynamoDB is more like a flexible JSON document store — each item can have different attributes.

**What makes DynamoDB special:**
- Handles **10+ trillion requests per day** globally (used by Amazon.com itself)
- Scales to **millions of requests per second** automatically
- **No server management** — truly serverless
- **Millisecond latency** at any scale — doesn't slow down as data grows

---

## 18.2 Key Concepts

### Tables, Items, and Attributes
```
DynamoDB Structure:
Table (like a spreadsheet)
  └── Items (like rows — but flexible structure)
      └── Attributes (like columns — but not fixed)

Example Table: "Users"
Item 1: { UserID: "101", Name: "Alice", Email: "alice@example.com", Age: 28 }
Item 2: { UserID: "102", Name: "Bob", City: "Mumbai" }   ← Different attributes — that's OK!
Item 3: { UserID: "103", Name: "Carol", Orders: ["ORD1", "ORD2"] }  ← Nested attributes
```

### Primary Key
Every DynamoDB table must have a **Primary Key** — uniquely identifies each item.

**Two options:**
- **Simple Primary Key:** Just a **Partition Key** (single attribute)
- **Composite Primary Key:** **Partition Key + Sort Key** (two attributes combined)

```
Example:
Simple PK: UserID = "101" → uniquely identifies a user
Composite: OrderID = "ORD1" + UserID = "101" → uniquely identifies order per user
```

### Partition Key (Hash Key)
- DynamoDB uses this to **distribute data across partitions** (physical storage nodes)
- Good partition keys have **high cardinality** (many unique values) — e.g., UserID, SessionID
- Bad partition keys: Date (too few unique values), Status (only a few possible values)

---

## 18.3 Capacity Modes

### Provisioned Capacity Mode
- You **specify** how many reads and writes per second you need
- **Read Capacity Units (RCU):** 1 RCU = 1 strongly consistent read/sec for items up to 4 KB
- **Write Capacity Units (WCU):** 1 WCU = 1 write/sec for items up to 1 KB
- **Auto Scaling available** — DynamoDB adjusts capacity based on actual usage
- Predictable, cost-effective for steady-state workloads

### On-Demand Capacity Mode
- **No capacity planning** — DynamoDB handles everything
- Pay per request — great for unpredictable or spiky workloads
- More expensive per request than provisioned (but no idle capacity waste)
- **Recommended for:** New applications, unknown traffic patterns, development/testing

---

## 18.4 DynamoDB Features

### Secondary Indexes
Allow you to query on attributes other than the primary key:

| Type | Description |
|---|---|
| **Global Secondary Index (GSI)** | Query on any attribute — has its own partition and sort key, different from table's PK |
| **Local Secondary Index (LSI)** | Same partition key as table but different sort key — must be created at table creation |

### DynamoDB Streams
- Captures **time-ordered sequence of item modifications** (insert, update, delete) in a table
- Data retained for **24 hours**
- Can trigger **Lambda functions** to react to database changes
- **Use case:** Real-time data processing, event-driven architectures, cross-region replication

### DynamoDB Accelerator (DAX)
- **In-memory cache** specifically for DynamoDB
- Reduces read latency from **milliseconds to microseconds** (1,000x faster for cached items)
- Fully managed, highly available, sits between application and DynamoDB
- No application code changes needed (compatible API)
- **Use case:** Read-heavy applications, gaming leaderboards, e-commerce catalogs

### TTL (Time to Live)
- Automatically **delete items** after a specified timestamp
- Free of charge — no additional throughput consumed
- **Use case:** Session management (expire old sessions), temporary data, log records

### Global Tables
- **Multi-region, multi-master** replication
- Data automatically replicated across chosen AWS Regions
- Read and write from any region — active-active setup
- **Use case:** Global applications requiring low-latency access worldwide

---

## 18.5 Consistency Models

| Type | Description | When to Use |
|---|---|---|
| **Eventually Consistent** | May read slightly stale data (milliseconds old) | Default — better performance, lower cost |
| **Strongly Consistent** | Always reads the most recent, confirmed data | When you must have latest data (uses 2x RCU) |

---

## 18.6 Integration with Other AWS Services

| Service | DynamoDB Integration |
|---|---|
| **Lambda** | DynamoDB Streams trigger Lambda for event-driven processing |
| **API Gateway** | REST APIs directly read/write DynamoDB |
| **EC2** | Application servers query DynamoDB via SDK |
| **IAM** | Fine-grained access control per table, item, attribute |
| **CloudWatch** | Monitor RCU/WCU consumed, throttled requests, latency |
| **S3** | Export DynamoDB data to S3 for analytics |
| **Athena** | Query exported DynamoDB data in S3 using SQL |
| **Kinesis** | Stream DynamoDB changes to Kinesis for real-time analytics |
| **DAX** | In-memory caching layer in front of DynamoDB |

---

## 18.7 Real-Time DevOps Production Scenario

**Application:** A real-time food delivery app (like Swiggy/Zomato) — tracking millions of live orders simultaneously.

**Why DynamoDB over RDS:**
- **Order tracking** requires millisecond reads (customer refreshes app every 5 seconds)
- **Variable schema** — different delivery partners have different attributes
- **Unpredictable spikes** — dinner time is 10x lunch traffic
- **Scale:** Millions of concurrent orders during peak hours

**Table Design:**
```
Table: Orders
Primary Key:
  Partition Key: CustomerId
  Sort Key: OrderId

Attributes per item:
  Status: "placed" | "preparing" | "out_for_delivery" | "delivered"
  RestaurantId: "REST-101"
  DeliveryAgentId: "AGENT-55"
  EstimatedDelivery: "2024-01-15T19:30:00Z"
  Items: [{ "name": "Biryani", "qty": 2, "price": 350 }]
  TTL: 1705344600  ← Delete order data after 30 days automatically

GSI 1: RestaurantId-index (partition: RestaurantId, sort: OrderTimestamp)
  → Restaurant dashboard queries all orders for their restaurant

GSI 2: DeliveryAgent-index (partition: DeliveryAgentId, sort: Status)
  → Dispatch system finds all active deliveries per agent
```

**Architecture Flow:**
```
Customer places order
    ↓ API Gateway → Lambda → DynamoDB write
    ↓ DynamoDB Stream triggered
    ↓ Lambda processes stream event
    ↓ Pushes real-time update to customer via WebSocket (API Gateway)
    ↓ Notifies restaurant via SNS
    ↓ Notifies delivery agent via SNS

Every 5 seconds customer refreshes:
    ↓ App → API Gateway → Lambda → DynamoDB read (eventually consistent)
    ↓ Response in < 5ms — customer sees live status
    
Hot path: Customer → DAX Cache → DynamoDB
  99% of active order reads served from DAX (microseconds)
  Only cache misses go to DynamoDB
```

**Capacity Configuration:**
```
Mode: On-Demand (handles dinner rush spikes automatically)

DAX Cluster:
  3 nodes (r4.large) — Multi-AZ
  Cache TTL: 60 seconds for order items
  Results: Order reads serve from cache 99% of time

DynamoDB Streams → Lambda:
  Processes every order status change
  Sends push notifications, updates analytics
  
TTL: Orders expire after 90 days automatically (free storage management)
```

**Monitoring:**
- CloudWatch: `ConsumedReadCapacityUnits` vs provisioned — ensure no throttling
- CloudWatch: `SuccessfulRequestLatency` — alert if P99 > 10ms
- CloudWatch: `ThrottledRequests` — alert immediately (user-facing impact)
- DAX: `CacheHitRate` — should be > 95% for hot keys

---

## 18.8 Benefits

- **Serverless** — No infrastructure to manage whatsoever
- **Unlimited scale** — Scales from zero to millions of requests/second seamlessly
- **Millisecond latency** — Consistent at any scale
- **Flexible schema** — No rigid column definitions, evolve your data model freely
- **Built-in HA** — Data replicated across 3 AZs automatically
- **Streams** — Built-in change data capture for event-driven architectures
- **Global Tables** — Multi-region replication for global apps
- **Fully managed** — Backups, patching, scaling handled by AWS

---

## 18.9 Common Use Cases

- Session management (user login sessions with TTL)
- Real-time gaming leaderboards
- Shopping cart storage
- User preference and profile storage
- IoT device state storage
- Real-time event tracking (clicks, views, actions)
- Mobile app backends
- Microservices data stores

---

## 18.10 Summary

DynamoDB is AWS's fully managed, serverless NoSQL database delivering millisecond performance at any scale. It's the go-to choice when you need massive scale, flexible schemas, and predictable low latency. Design your tables around your access patterns (not normalization rules), use GSIs for different query needs, DAX for ultra-fast caching, Streams for event-driven processing, and TTL for automatic data cleanup. DynamoDB is a key enabler of serverless and microservices architectures on AWS.

---
---

# 19. 📦 Amazon Redshift

---

## 19.1 What is Amazon Redshift?

**Amazon Redshift** is a **fully managed, petabyte-scale cloud data warehouse** — optimized for **OLAP (Online Analytical Processing)** workloads like complex reporting, business intelligence, and large-scale data analysis.

Think of Redshift like a **super-powered SQL database designed for analytics** — instead of handling thousands of small transactions per second (like RDS), it's built to execute complex analytical queries across **billions or trillions of rows** in seconds.

**The key difference from RDS:** RDS is for transactional workloads (inserts, updates, lookups). Redshift is for analytical workloads (aggregations, group-bys, joins across massive datasets).

---

## 19.2 Architecture

### Clusters and Nodes
A **Cluster** is the core component — composed of a **Leader Node** and one or more **Compute Nodes**.

```
Redshift Cluster
├── Leader Node (1)
│   ├── Receives client queries via JDBC/ODBC
│   ├── Parses and develops execution plans
│   ├── Coordinates parallel query execution
│   └── Aggregates results from compute nodes
│
└── Compute Nodes (1–128)
    ├── Execute the actual queries in parallel
    ├── Store the data (columnar storage on SSD)
    └── Return results to leader node
```

### Two Cluster Configurations

| Type | Description | Use Case |
|---|---|---|
| **Single Node** | 160 GB — leader and compute combined | Dev, testing, small datasets |
| **Multi-Node** | Leader node + 1–128 compute nodes | Production, large datasets |

---

## 19.3 Key Technical Features

### Columnar Storage
Traditional databases store data **row by row** — good for transactions.
Redshift stores data **column by column** — dramatically better for analytics.

```
Row Storage (RDS):
Row1: [Alice, 25, Mumbai, Engineer, 80000]
Row2: [Bob, 30, Delhi, Manager, 120000]
→ To calculate average salary: read EVERY field of EVERY row

Columnar Storage (Redshift):
Column: [Alice, Bob, Carol, Dave, Eve...]  ← Name
Column: [25, 30, 28, 35, 22...]            ← Age
Column: [80000, 120000, 95000, 150000...]  ← Salary
→ To calculate average salary: read ONLY the Salary column
→ 80-90% less data read → massively faster for analytics
```

### Massively Parallel Processing (MPP)
- Queries are automatically distributed across all compute nodes
- All nodes process their portion of data simultaneously
- Results are combined by the leader node
- More compute nodes = faster query execution (linear scaling)

### Data Compression
- Redshift automatically compresses data using columnar storage patterns
- Significantly reduces storage requirements and I/O — further improving query speed

### Based on PostgreSQL
- Standard SQL syntax — most existing SQL tools work without modification
- Connect via **JDBC/ODBC** — works with Tableau, Power BI, Looker, Excel

---

## 19.4 Integration with Other AWS Services

| Service | Redshift Integration |
|---|---|
| **S3** | Load data from S3 using COPY command; unload query results to S3 |
| **RDS** | Federated queries — query RDS data from Redshift |
| **DynamoDB** | COPY command loads DynamoDB data into Redshift |
| **Kinesis** | Stream real-time data into Redshift via Kinesis Firehose |
| **QuickSight** | BI dashboards directly connected to Redshift |
| **Glue** | ETL jobs to transform and load data into Redshift |
| **IAM** | Control access to Redshift clusters and data |
| **VPC** | Deploy Redshift cluster inside private VPC |
| **CloudWatch** | Monitor cluster CPU, connections, query performance |

---

## 19.5 Real-Time DevOps Production Scenario

**Application:** A large retail company's analytics platform — analyzing 5 years of sales transactions (500 billion rows) for business intelligence.

**Architecture:**
```
Data Sources:
├── RDS MySQL (daily sales transactions) → AWS Glue ETL → S3 (staging)
├── DynamoDB (website clickstream) → Kinesis Firehose → S3 (staging)
├── On-premises ERP → AWS Snowball → S3 (historical data)
└── Third-party data (market trends) → S3 (staging)
                        ↓
                  S3 Data Lake (raw data)
                        ↓ Glue ETL (transform, clean)
                  S3 Data Lake (processed data)
                        ↓ Redshift COPY command
               Redshift Cluster (ra3.4xlarge × 8 nodes)
                        ↓
              BI Tools (Tableau, Power BI, QuickSight)
                        ↓
              Business Dashboards (executives, analysts)
```

**Sample Analytical Queries on Redshift:**
```sql
-- Revenue by region, last 12 months
SELECT region, SUM(revenue) as total_revenue
FROM sales_facts
WHERE sale_date >= DATEADD(year, -1, GETDATE())
GROUP BY region
ORDER BY total_revenue DESC;

-- Customer lifetime value calculation across 500 billion rows
-- Completes in seconds on Redshift vs hours on RDS
```

**Monitoring:**
- CloudWatch: Query execution time, disk space, CPU utilization
- Redshift Query Monitoring Rules: Auto-cancel queries running > 10 minutes (runaway queries)
- Weekly: Review slow query logs, optimize table distribution keys

---

## 19.6 Benefits

- **Petabyte scale** — Handle massive datasets cost-effectively
- **Fast analytics** — Columnar storage + MPP = complex queries in seconds
- **SQL-compatible** — Existing SQL skills and BI tools work
- **Fully managed** — Backups, patching, scaling handled by AWS
- **Cost-effective** — Much cheaper than traditional data warehouse appliances
- **Scales easily** — Add or remove compute nodes as needs change
- **S3 integration** — Seamlessly load from and unload to S3

---

## 19.7 Summary

Amazon Redshift is AWS's data warehouse solution for analytics and business intelligence. Use it when you need to run complex SQL queries across massive datasets — sales analysis, user behavior analysis, financial reporting. It uses columnar storage and parallel processing to deliver results in seconds rather than hours. Always keep Redshift in its own VPC, use COPY from S3 for bulk loading, and connect your BI tools via JDBC/ODBC for dashboards and reporting.

---
---

# 20. 🚀 Amazon ElastiCache

---

## 20.1 What is Amazon ElastiCache?

**Amazon ElastiCache** is a **fully managed in-memory caching service** that improves application performance by storing frequently accessed data in memory — delivering **sub-millisecond response times** instead of fetching from a database on every request.

Think of ElastiCache like a **short-term memory for your application**. Instead of asking the database the same question thousands of times per second (expensive and slow), you ask once, store the answer in ElastiCache's memory, and serve it instantly for all subsequent requests.

**The core benefit:** Dramatically reduce database load and response times for read-heavy applications.

---

## 20.2 Two Cache Engines

### 🔵 Redis
A rich in-memory data store supporting advanced data structures:

| Feature | Details |
|---|---|
| Data structures | Strings, hashes, lists, sets, sorted sets, bitmaps, geospatial |
| **Persistence** | Optional — can save data to disk |
| **Replication** | Master/slave replication supported |
| **Multi-AZ** | Yes — automatic failover |
| **Pub/Sub** | Real-time messaging between services |
| **Sorted Sets** | Perfect for leaderboards, rankings |

**Best for:** Session management, gaming leaderboards, real-time analytics, Pub/Sub messaging, complex caching needs.

### 🟡 Memcached
A simple, high-performance distributed memory caching system:

| Feature | Details |
|---|---|
| Data structures | Simple key-value strings only |
| **Persistence** | No — pure in-memory only |
| **Replication** | No |
| **Multi-AZ** | No |
| **Multi-threading** | Yes — can use multiple CPU cores |

**Best for:** Simple caching, maximum raw performance, stateless horizontal scaling.

### Redis vs Memcached

| Feature | Redis | Memcached |
|---|---|---|
| Data types | Rich (lists, sets, sorted sets) | Simple key-value only |
| Persistence | Optional | No |
| Replication | Yes (Master/Replica) | No |
| Multi-AZ Failover | Yes | No |
| Cluster mode | Yes (horizontal sharding) | Yes |
| Pub/Sub | Yes | No |
| Use case | Complex caching, sessions | Simple high-speed caching |

---

## 20.3 Caching Strategies

### Lazy Loading (Cache-Aside)
```
1. Application requests data
2. Check ElastiCache first
3. If found (cache HIT): Return data immediately → fast!
4. If not found (cache MISS):
   a. Fetch from database
   b. Write to ElastiCache
   c. Return data → slower (DB hit)

Pros: Only caches data that's actually requested
Cons: First request is always slow (cache miss), stale data risk
```

### Write-Through
```
1. Application writes data to database
2. Simultaneously write to ElastiCache
3. Cache always stays current

Pros: Cache never stale
Cons: All writes are slower, caches data that may never be read
```

---

## 20.4 Integration with Other AWS Services

| Service | ElastiCache Integration |
|---|---|
| **RDS** | Cache frequent RDS query results — reduce database load |
| **DynamoDB** | Cache hot DynamoDB items (DAX is DynamoDB-specific, Redis for general use) |
| **EC2** | Application servers connect to ElastiCache cluster |
| **Auto Scaling** | Cached data reduces per-instance database load, helps scaling |
| **VPC** | ElastiCache cluster deployed inside VPC private subnets |
| **CloudWatch** | Monitor cache hits, misses, evictions, memory usage |

---

## 20.5 Real-Time DevOps Production Scenario

**Application:** A ticket booking platform (like BookMyShow) — massive concurrent reads during popular event releases.

**The Problem Without Cache:**
- Popular event released → 100,000 users simultaneously hit "Get Available Seats"
- Each request hits RDS MySQL → 100,000 DB queries/second → RDS crashes
- Result: Booking system down during peak demand

**Solution With ElastiCache Redis:**
```
First user requests "Show seats for Event-12345":
    App → Cache MISS → RDS query (50ms)
    → Store result in Redis: Key="seats:12345", TTL=10 seconds
    → Return to user

Next 99,999 users request same data:
    App → Cache HIT → Redis response (0.2ms)
    → No DB query — RDS protected
    → 250x faster response for users

RDS load: From 100,000 queries/sec → ~6 queries/sec (one per TTL refresh)
```

**Session Management with Redis:**
```
User logs in:
    → Create session: { userId: 123, cart: [...], preferences: {...} }
    → Store in Redis: Key="session:abc123", TTL=3600 seconds (1 hour)

User makes any subsequent request:
    → App reads session from Redis (not DB)
    → Fast, consistent across all app servers in Auto Scaling Group

User logs out or session expires (TTL):
    → Redis automatically deletes session
```

**Redis Cluster Setup:**
```
ElastiCache Redis (Multi-AZ):
├── Primary Node (ap-south-1a): Write endpoint
├── Read Replica 1 (ap-south-1a): Read endpoint
└── Read Replica 2 (ap-south-1b): Read endpoint (failover)

Application:
├── Write/delete operations → Primary endpoint
└── Read operations → Reader endpoint (load balanced across replicas)

Automatic failover:
If primary fails → ElastiCache promotes a replica in ~60 seconds
Application continues with same endpoint (DNS updates automatically)
```

**Monitoring:**
- CloudWatch: `CacheHitRate` — should be > 90%
- CloudWatch: `Evictions` — if high, cache is too small (increase node size)
- CloudWatch: `CurrConnections` — alert if approaching connection limit
- CloudWatch: `FreeableMemory` — alert if memory < 20% (evictions will increase)

---

## 20.6 Benefits

- **Massive performance boost** — Sub-millisecond response vs 10-50ms database query
- **Database protection** — Reduces read load on RDS by 90%+
- **Fully managed** — AWS handles patching, failover, backups (Redis)
- **Highly available** — Multi-AZ Redis with automatic failover
- **Flexible data structures** (Redis) — Handles sessions, leaderboards, pub/sub
- **Cost effective** — Cheaper to cache data than scale up expensive RDS instances

---

## 20.7 Summary

ElastiCache provides in-memory caching to dramatically improve application performance. Use Redis for rich data structures, persistence, replication, and Multi-AZ failover — it's the preferred choice for most production use cases. Use Memcached for simple high-throughput key-value caching at maximum speed. Always deploy ElastiCache in private subnets, monitor cache hit rates, and use TTL to prevent stale data. Cache what's frequently read but rarely changed — database query results, session data, computed values.

---
---

# 21. 📬 Amazon SQS — Simple Queue Service

---

## 21.1 What is Amazon SQS?

**Amazon SQS (Simple Queue Service)** is a **fully managed message queuing service** that enables you to **decouple** and **scale microservices, distributed systems, and serverless applications**.

Think of SQS like a **post office mailbox system**. The sender (producer) drops a letter (message) into a mailbox (queue). The recipient (consumer) picks up the letter when they're ready — the sender doesn't need to wait, and the recipient processes at their own pace. Neither party needs to know the other exists directly.

**The key concept:** SQS **decouples** the components of your application — if the consumer is slow or temporarily down, messages wait in the queue. No data is lost, no producer is blocked.

---

## 21.2 Key Concepts

### Messages
- Text-based messages in **any format** (JSON, XML, plain text)
- **Maximum message size: 256 KB**
- **Minimum charge unit:** 64 KB chunks (a 256 KB message = 4 billing chunks)

### Message Retention
- Messages stay in queue until consumed or retention expires
- **Default retention: 4 days**
- **Maximum retention: 14 days**

### Visibility Timeout
When a consumer picks up a message, it becomes **invisible** to other consumers for the **Visibility Timeout** period.

```
Consumer picks up message → Message invisible for 30 seconds
If consumer processes and deletes message → Done ✅
If consumer fails (crashes) → After 30 seconds, message becomes visible again → Another consumer picks it up
```
Maximum Visibility Timeout: **12 hours**

### Dead Letter Queue (DLQ)
If a message fails processing repeatedly (e.g., bad data), it gets sent to a **Dead Letter Queue** instead of being retried forever — allows you to examine and debug failed messages.

---

## 21.3 SQS Queue Types

### Standard Queue
- **At-least-once delivery** — each message delivered at least once (occasionally more than once)
- **Best-effort ordering** — messages generally delivered in order, but not guaranteed
- **Nearly unlimited throughput** — virtually unlimited messages per second
- **Use case:** Most applications where occasional duplicates and out-of-order processing are acceptable

### FIFO Queue (First-In-First-Out)
- **Exactly-once processing** — no duplicate messages
- **Strict ordering** — messages processed exactly in the order sent
- **Limited throughput** — 300 messages/second (3,000 with batching)
- **Use case:** Financial transactions, order processing — where order and exactly-once matter

---

## 21.4 SQS Pricing

- First **1 million requests per month** — **FREE**
- After that: **$0.50 per 1 million requests**
- Each 64 KB chunk is billed as 1 request
  - 256 KB message = 4 × 64 KB = billed as **4 requests**

---

## 21.5 How SQS Works in a Distributed System

```
Without SQS (tightly coupled):
Order Service → directly calls → Payment Service
If Payment Service is down → Order Service fails too → Outage cascades

With SQS (loosely coupled):
Order Service → puts message in SQS queue → returns immediately ✅
Payment Service → reads from SQS queue → processes when available
If Payment Service is down → messages wait safely in queue
When Payment Service recovers → processes all queued messages
Orders never lost, Order Service unaffected by Payment Service downtime
```

---

## 21.6 Integration with Other AWS Services

| Service | SQS Integration |
|---|---|
| **Lambda** | Lambda triggered by SQS messages — auto-scale processing |
| **EC2** | Worker EC2 instances poll and process SQS messages |
| **Auto Scaling** | Scale worker fleet based on SQS queue depth |
| **SNS** | SNS fan-out to multiple SQS queues (pub/sub pattern) |
| **S3** | S3 events sent to SQS for processing |
| **CloudWatch** | Monitor queue depth, age of oldest message |
| **IAM** | Control who can send/receive from queues |

---

## 21.7 Real-Time DevOps Production Scenario

**Application:** An e-commerce order processing system — orders must be processed reliably even during peak sales.

**Architecture:**
```
Customer places order
    ↓ Order Service (EC2/Lambda)
    ↓ Validates order, generates OrderID
    ↓ Sends message to SQS: OrderQueue
    ↓ Immediately responds to customer: "Order Confirmed!"

SQS OrderQueue:
    ↓ Payment Processing Service (EC2 Auto Scaling Group)
    ├── Picks up order message
    ├── Processes payment via payment gateway
    ├── If success: sends to InventoryQueue + NotificationQueue
    └── If failure: message returns to OrderQueue (retry 3 times → Dead Letter Queue)

InventoryQueue → Warehouse Service: Picks and packs items
NotificationQueue → Email/SMS Service: Sends confirmation to customer

Dead Letter Queue → CloudWatch Alarm → Alerts DevOps team to investigate failed orders
```

**Auto Scaling based on Queue Depth:**
```
CloudWatch Alarm:
  If SQS OrderQueue depth > 1000 messages → Scale Out workers to 20 instances
  If SQS OrderQueue depth < 100 messages → Scale In workers to 2 instances

Result: Queue never backs up during sales, workers scale down at night to save cost
```

**Monitoring:**
- CloudWatch: `ApproximateNumberOfMessagesVisible` — queue depth
- CloudWatch: `ApproximateAgeOfOldestMessage` — alert if messages sitting > 5 minutes (consumer slow)
- CloudWatch: `NumberOfMessagesSent` vs `NumberOfMessagesDeleted` — detect processing lag
- DLQ size increasing → Alert immediately (orders failing to process)

---

## 21.8 Benefits

- **Decoupling** — Components are independent, failures don't cascade
- **Reliability** — Messages stored durably across multiple AZs
- **Scalability** — Unlimited throughput on Standard queues
- **Flexible** — Standard (high throughput) or FIFO (strict ordering)
- **Dead Letter Queue** — Handle failed messages gracefully
- **Fully managed** — No servers, no infrastructure to manage
- **Cost effective** — First million requests free, fractions of a cent after

---

## 21.9 Summary

SQS is the foundation of decoupled, resilient distributed systems on AWS. Use it to buffer requests between services, enable asynchronous processing, and protect downstream services from being overwhelmed. Use Standard queues for high-throughput workloads and FIFO queues when order and exactly-once processing matter. Always monitor queue depth and oldest message age to detect processing bottlenecks early.

---
---

# 22. 📢 Amazon SNS — Simple Notification Service

---

## 22.1 What is Amazon SNS?

**Amazon SNS (Simple Notification Service)** is a **fully managed publish-subscribe (Pub/Sub) messaging service** that enables you to send notifications to multiple recipients simultaneously through multiple channels.

Think of SNS like a **notification broadcast system**. When something happens (a server alarm, a new order, a deployment), SNS instantly **pushes notifications** to all subscribers — email, SMS, mobile push, Lambda functions, SQS queues — all at once, without polling.

**Key difference from SQS:**
- **SQS** = Pull model. Consumers **poll** the queue to get messages.
- **SNS** = Push model. SNS **pushes** notifications to all subscribers immediately.

---

## 22.2 Key Concepts

### Topics
A **Topic** is a logical **communication channel** — subscribers subscribe to it and publishers send messages to it.

```
Example: "order-events" topic
├── Subscriber 1: Email (billing@company.com)
├── Subscriber 2: SMS (warehouse manager's phone)
├── Subscriber 3: Lambda function (triggers order processing)
├── Subscriber 4: SQS queue (analytics processing)
└── Subscriber 5: Mobile push (customer notification app)

When publisher sends to topic → ALL subscribers receive instantly
```

### Publishers
Services or applications that send messages to a topic — EC2 application, CloudWatch alarm, S3 event, another microservice.

### Subscribers
Endpoints that receive messages from a topic:

| Subscriber Type | Use Case |
|---|---|
| **Email** | Human-readable notifications to operations team |
| **Email-JSON** | Machine-readable email notifications |
| **SMS** | Text message to phone numbers |
| **HTTP/HTTPS** | Webhook to external services |
| **SQS Queue** | Queue messages for asynchronous processing |
| **Lambda** | Trigger function immediately on message |
| **Mobile Push** | Push notifications to iOS, Android, Kindle, Windows |
| **Kinesis Firehose** | Stream messages to S3, Redshift for analytics |

### Mobile Push Platforms
SNS supports push notifications to:
- **Apple (APNs)** — iOS devices
- **Google (FCM/GCM)** — Android devices
- **Amazon (ADM)** — Kindle Fire devices
- **Microsoft (WNS)** — Windows devices
- **Baidu Cloud Push** — Android devices in China

---

## 22.3 SNS Fan-Out Pattern

**Fan-Out** = One SNS topic → Multiple SQS queues (parallel processing of the same event)

```
Classic Fan-Out Architecture:
S3 uploads image
    ↓ S3 Event → SNS Topic "image-uploaded"
    ├── SQS Queue → Lambda: Resize to thumbnail (128×128)
    ├── SQS Queue → Lambda: Resize to medium (600×600)
    ├── SQS Queue → Lambda: Moderate content (AI check)
    └── SQS Queue → Lambda: Update search index

All four operations happen in parallel, triggered by one SNS publish
None depend on each other — fastest possible processing
```

---

## 22.4 Message Redundancy
SNS stores all published messages **redundantly across multiple AZs** — ensuring no message is lost even if an AZ fails before delivery.

---

## 22.5 SNS vs SQS

| Feature | SNS | SQS |
|---|---|---|
| Model | Push (pub/sub) | Pull (queue) |
| Persistence | No (deliver or lost) | Yes (up to 14 days) |
| Consumers | Many simultaneously | One consumer per message |
| Pattern | Broadcast | Work queue |
| Use case | Notifications, fan-out | Task queues, decoupling |

---

## 22.6 Integration with Other AWS Services

| Service | SNS Integration |
|---|---|
| **CloudWatch** | Alarms send notifications via SNS |
| **Lambda** | SNS message triggers Lambda function |
| **SQS** | SNS fans out to multiple SQS queues |
| **S3** | S3 events sent to SNS for notifications |
| **EC2 Auto Scaling** | Scaling events notify via SNS |
| **RDS** | DB events (failover, backup) notify via SNS |
| **CloudFormation** | Stack events notify via SNS |
| **Snowball** | Device status notifications via SNS |

---

## 22.7 Real-Time DevOps Production Scenario

**Application:** A DevOps team managing a microservices production environment — needs instant alerts for any infrastructure issues.

**SNS Topic Architecture:**
```
Topics:
├── "critical-alerts" — outages, data loss risk
├── "warning-alerts"  — performance degradation
├── "info-alerts"     — deployments, scaling events
└── "billing-alerts"  — cost threshold breaches

"critical-alerts" Subscribers:
├── Email: entire-devops-team@company.com
├── SMS: all on-call engineers (5 phone numbers)
├── Lambda: auto-creates PagerDuty incident
├── SQS: feeds incident logging system
└── Slack Webhook (HTTPS): posts to #alerts channel

"info-alerts" Subscribers:
└── Email: devops-team@company.com only (no SMS — not urgent)
```

**CloudWatch + SNS Integration:**
```
CloudWatch Alarm: EC2 CPU > 85% for 5 minutes
    ↓ Alarm state = ALARM
    ↓ Triggers SNS topic "warning-alerts"
    ↓ All subscribers notified simultaneously:
        - Email to team
        - SMS to on-call engineer
        - Slack message: "⚠️ PROD-WEB-01 CPU at 91%"
        - Lambda: checks if Auto Scaling already triggered, if not → manually scale out
```

**Customer Notification System:**
```
Order placed by customer
    ↓ Order Service publishes to SNS "order-events" topic
    ├── Lambda: Send order confirmation email to customer
    ├── SQS → Payment processing service
    ├── Lambda: Send push notification to customer's mobile app
    └── SQS → Inventory reservation service
```

**Creating and Using SNS (Console Steps):**
```
1. SNS Console → Create Topic → Standard → Name: "production-alerts"
2. Create Subscription → Protocol: Email → Endpoint: team@company.com
3. Subscriber receives confirmation email → clicks "Confirm subscription"
4. Create Subscription → Protocol: SMS → Endpoint: +91-XXXXXXXXXX
5. Create Subscription → Protocol: Lambda → Endpoint: arn:aws:lambda:...

Publishing:
Applications/CloudWatch send to topic ARN automatically
```

---

## 22.8 Benefits

- **Instant delivery** — Messages pushed immediately, no polling delay
- **Fan-out** — One message → many subscribers simultaneously
- **Multiple protocols** — Email, SMS, push, Lambda, SQS, HTTP all supported
- **Reliable** — Messages stored redundantly across AZs
- **Scalable** — Handles millions of messages per second
- **Fully managed** — No infrastructure to operate
- **Mobile reach** — Native push notifications for all major mobile platforms

---

## 22.9 Summary

SNS is the notification and messaging backbone of your AWS architecture. Use it to broadcast events to multiple subscribers simultaneously — alerting teams, triggering Lambda functions, fanning out to multiple SQS queues, and sending mobile push notifications. Combine SNS with SQS for the fan-out pattern where one event triggers multiple parallel downstream processes. The SNS-SQS fan-out is one of the most powerful and commonly used patterns in AWS microservices architecture.

---
---

# 23. 🌍 Amazon CloudFront

---

## 23.1 What is Amazon CloudFront?

**Amazon CloudFront** is AWS's **global Content Delivery Network (CDN)** — it distributes your content (web pages, images, videos, APIs) to end users from **edge locations** around the world with the lowest possible latency.

Think of CloudFront like having **copies of your content in hundreds of cities worldwide**. Instead of every user reaching back to your central server in Mumbai (causing delay), users in New York get content from the nearest New York edge location, users in Tokyo from Tokyo, users in London from London — all at maximum speed.

---

## 23.2 Key Concepts

### Edge Locations
- **Physical data centers** spread across **hundreds of cities worldwide**
- Store cached copies of your content
- More locations than AWS Regions — specifically optimized for content delivery
- When a user requests content, they're routed to the **nearest edge location**

### Distribution
A **Distribution** is the CloudFront configuration that defines how your content is delivered.
- Created with a DNS name like `d111111abcdef8.cloudfront.net`
- Use this domain name instead of your server's domain
- Or point your custom domain (via Route 53 alias) to the CloudFront distribution

### Origins
The **Origin** is the source where CloudFront fetches content when it's not cached at the edge:
- **Amazon S3 bucket** (most common for static content)
- **Application Load Balancer** (for dynamic content)
- **EC2 instance** (for application responses)
- **HTTP server** (any web server, including on-premises)

### Cache Control
- Content cached at edge for **default 24 hours (86,400 seconds)**
- **TTL (Time to Live):** Configurable — how long objects stay in edge cache
- **Cache invalidation:** Manually remove objects from edge cache (charged per path)
- When TTL expires or cache is invalidated: CloudFront fetches fresh copy from origin

---

## 23.3 CloudFront Request Flow

```
Without CloudFront:
User in New York → Request → Server in Mumbai → Response
Latency: ~200ms (round trip across the globe)

With CloudFront:
1st request (cache MISS):
User in New York → Nearest CloudFront Edge (New York) → Cache MISS → Origin (Mumbai)
→ Content fetched, cached at New York edge → Delivered to user
Latency: ~200ms (same, but cached now)

All subsequent requests (cache HIT):
User in New York → Nearest CloudFront Edge (New York) → Cache HIT → Instant response
Latency: ~5ms — 40x faster! Origin never contacted.
```

---

## 23.4 Origin Access Identity (OAI)

**OAI** ensures that S3 bucket content is **only accessible through CloudFront** — not directly from the S3 URL.

```
Without OAI: Users can bypass CloudFront and directly access S3 objects
With OAI:    S3 bucket policy allows access only from CloudFront's OAI identity
             Direct S3 URL access → 403 Forbidden
             CloudFront URL → Content served ✅
```

This is the recommended security practice for S3 + CloudFront setups.

---

## 23.5 Signed URLs and Signed Cookies

For **private content** that should only be accessible to authorized users:

| Method | Use Case |
|---|---|
| **Signed URL** | Restrict access to individual files, time-limited (e.g., video download link expires in 1 hour) |
| **Signed Cookie** | Restrict access to multiple files (e.g., premium subscriber can access entire video library) |

Both use **public/private key pairs** for authentication.

---

## 23.6 CloudFront Security Features

- **AWS WAF Integration** — Block SQL injection, XSS, rate limiting at the edge
- **AWS Shield** — DDoS protection (Standard free, Advanced paid)
- **HTTPS/SSL** — Enforce HTTPS, use ACM certificates free with CloudFront
- **Geo-Restriction** — Block or allow specific countries from accessing your content
- **Field-Level Encryption** — Encrypt specific fields in POST data all the way to your application

---

## 23.7 Integration with Other AWS Services

| Service | CloudFront Integration |
|---|---|
| **S3** | Most common origin — static websites, media files |
| **ALB** | Origin for dynamic application content |
| **API Gateway** | Accelerate API responses globally |
| **Lambda@Edge** | Run code at edge locations (customize requests/responses) |
| **ACM** | Free SSL certificates for custom domains |
| **Route 53** | Alias record pointing custom domain to CloudFront |
| **WAF** | Web application firewall rules at edge |
| **Shield** | DDoS protection at edge |
| **CloudWatch** | Monitor request counts, cache hit ratios, error rates |

---

## 23.8 Real-Time DevOps Production Scenario

**Application:** A global video streaming platform — serves video content to users in 100+ countries.

**Architecture:**
```
Video Files Storage:
└── S3 Bucket (us-east-1) — original video files (4K, HD, SD versions)
    ↓ CloudFront Distribution (Global)
    ├── Edge Location: New York → US users
    ├── Edge Location: London → European users
    ├── Edge Location: Mumbai → Indian users
    ├── Edge Location: Tokyo → Japanese users
    └── Edge Location: São Paulo → Brazilian users

Security:
└── S3 Bucket: Private (no public access)
    CloudFront OAI: Only CloudFront can read from S3
    Signed URLs: Generated per user per video (valid for 4 hours)
    WAF: Block bots, rate-limit suspicious IPs
    HTTPS: Enforced (HTTP redirected to HTTPS)

Cache Strategy:
└── Videos (large files): TTL = 7 days (rarely changes)
    Thumbnails: TTL = 24 hours
    Manifest files: TTL = 5 minutes (updates frequently)
    API responses: TTL = 0 (no caching — always fresh)
```

**Lambda@Edge for Dynamic Customization:**
```
Viewer Request → Lambda@Edge runs at edge:
├── Check if user is premium subscriber (from cookie)
├── If premium: Serve 4K version URL
├── If standard: Serve HD version URL
└── Log request to Kinesis for analytics

Result: Content personalized at edge — no round trip to origin for customization
```

**Cost & Performance Results:**
```
Without CloudFront:
  All 10 million daily requests → Origin servers in us-east-1
  Latency for Indian users: 180-200ms
  Origin bandwidth cost: $0.09/GB

With CloudFront:
  90% cache hit rate → Only 1 million requests to origin
  Latency for Indian users: 5-15ms (served from Mumbai edge)
  CloudFront cost: $0.02/GB (cheaper than data transfer from S3)
  Origin bandwidth 90% reduced → Massive cost saving
```

**Monitoring:**
- CloudWatch: `CacheHitRate` — target > 85%
- CloudWatch: `4xxErrorRate` — alert if > 1% (auth issues)
- CloudWatch: `OriginLatency` — alert if > 200ms (origin performance issue)
- Real-time CloudFront logs → Kinesis → Athena → Dashboard

---

## 23.9 Benefits

- **Global low latency** — Content served from nearest edge location
- **High throughput** — AWS global network backbone
- **Cost effective** — Reduce origin bandwidth 80-90%+ with caching
- **Security** — WAF, DDoS protection, signed URLs, OAI, geo-restriction
- **HTTPS** — Free SSL certificates via ACM
- **Scalable** — Handles traffic spikes automatically
- **Lambda@Edge** — Customize content at edge for zero additional latency

---

## 23.10 Summary

CloudFront is AWS's CDN that caches your content at hundreds of edge locations worldwide, serving it to users with millisecond latency regardless of where they are. Use S3 as origin for static content, ALB for dynamic content, and always use OAI to prevent direct S3 access. Configure appropriate TTLs, use signed URLs for private content, and integrate WAF for security. CloudFront dramatically improves user experience globally while reducing origin costs.

---
---

# 24. 🚀 AWS Global Accelerator

---

## 24.1 What is AWS Global Accelerator?

**AWS Global Accelerator** is a networking service that **improves availability and performance** of your applications for global users by routing traffic through the **AWS global network** instead of the public internet.

Think of Global Accelerator like a **private express highway** for your application traffic. Instead of internet traffic taking unpredictable routes through multiple ISPs and internet exchanges (causing latency and packet loss), Global Accelerator routes traffic through the fast, reliable AWS backbone network from the moment it enters an AWS edge location.

---

## 24.2 How It Works

```
Without Global Accelerator:
User in Mumbai → 15 internet hops across various ISPs → Server in us-east-1
Issues: Variable latency, packet loss, congestion at each hop

With Global Accelerator:
User in Mumbai → Nearest AWS Edge Location (Mumbai) → Fast AWS backbone → Server in us-east-1
Benefits: Consistent latency, minimal packet loss, AWS network quality
```

**Global Accelerator provides:**
- **2 static anycast IP addresses** — your application gets two static IPs globally
- Traffic enters AWS at the nearest edge location
- Routes to optimal healthy endpoint using AWS backbone

---

## 24.3 Global Accelerator vs CloudFront

| Feature | CloudFront | Global Accelerator |
|---|---|---|
| **Type** | CDN (caches content) | Network accelerator (no caching) |
| **Content** | Static and dynamic | All TCP/UDP traffic |
| **Benefit** | Cache hits at edge | Faster routing via AWS backbone |
| **IP** | Changes (DNS based) | **Static IPs** (anycast) |
| **Use case** | Web content, APIs | Gaming, IoT, VoIP, non-HTTP apps |
| **Health checks** | No | Yes — instant failover |

---

## 24.4 Real-Time Production Scenario

**Application:** A global multiplayer gaming platform requiring ultra-low latency worldwide.

```
2 Static IPs (anycast): 54.x.x.x and 71.x.x.x

Player in Tokyo → AWS Edge Tokyo → AWS backbone → Gaming Server (us-east-1)
Player in London → AWS Edge London → AWS backbone → Gaming Server (eu-west-1)
Player in India → AWS Edge Mumbai → AWS backbone → Gaming Server (ap-south-1)

Health Check:
If ap-south-1 gaming server fails:
    Global Accelerator detects in <30 seconds
    Reroutes Indian players to next closest healthy endpoint
    Players experience minimal disruption
```

**Speed test:** Use `https://speedtest.globalaccelerator.aws/#/` to compare latency before/after.

---

## 24.5 Summary

AWS Global Accelerator improves global application performance by routing traffic through the AWS backbone network from the nearest edge location. Unlike CloudFront (which caches content), Global Accelerator accelerates all traffic — HTTP, TCP, UDP — without caching. It provides two static anycast IPs, instant health-based failover, and is ideal for gaming, IoT, real-time applications, and any use case requiring consistent global low latency.

---
---

# 25. 💾 AWS Storage Gateway

---

## 25.1 What is AWS Storage Gateway?

**AWS Storage Gateway** is a **hybrid cloud storage service** that connects your **on-premises IT environment** to AWS cloud storage — allowing you to seamlessly extend your data center storage into the cloud.

Think of Storage Gateway like a **bridge between your physical data center and AWS cloud storage**. Your on-premises applications use standard storage protocols (NFS, SMB, iSCSI) while Storage Gateway transparently stores the data in AWS (S3, Glacier, EBS).

---

## 25.2 Four Gateway Types

### 🔵 Amazon S3 File Gateway
- Presents a **file interface (NFS/SMB)** — applications see it as a network file share
- Files stored as **objects in Amazon S3**
- Local cache keeps frequently accessed files for low-latency access
- **Use case:** File shares migrated to cloud, backup workflows, media workflows

### 🟡 Amazon FSx File Gateway
- Provides **on-premises access to Amazon FSx for Windows File Server**
- Uses **SMB protocol** — fully Windows-compatible
- Local cache for frequently accessed data
- **Use case:** Windows file shares, user home directories needing cloud backup

### 🟠 Tape Gateway (Virtual Tape Library — VTL)
- Presents a **virtual tape library** to your backup software
- Your existing backup software (Veritas, Commvault, etc.) sees virtual tape drives
- Data stored in **Amazon S3 and Glacier**
- **Use case:** Replace physical tape infrastructure with cloud-based virtual tapes

### 🔴 Volume Gateway
- Presents **iSCSI block storage volumes** to on-premises applications
- Data backed up as **Amazon EBS snapshots**

**Two modes:**
- **Cached Volumes:** Primary data in S3, cache frequently used data locally
- **Stored Volumes:** Primary data stored locally, asynchronously backed up to S3

---

## 25.3 Real-Time DevOps Production Scenario

**Application:** A hospital with 20TB of medical records on-premises — needs cost-effective cloud backup without changing existing workflows.

**Solution: S3 File Gateway**
```
On-Premises Hospital:
├── EMR System (Electronic Medical Records) writes to \\storage\patient-records\
├── Storage Gateway (VM deployed on-premises) appears as NFS mount
├── EMR continues writing files normally — no application changes
└── Gateway transparently:
    ├── Caches recent files locally (fast access for recent records)
    ├── Uploads files to Amazon S3 (standard class)
    └── Older files tiered to S3 Glacier automatically (lifecycle policy)

Result:
- Zero application changes
- Infinite cloud storage
- Local cache: sub-millisecond access for recent records
- Older records: available in hours via Glacier retrieval
- Cost: S3 + Glacier << cost of on-premises SAN expansion
```

---

## 25.4 Summary

AWS Storage Gateway bridges on-premises infrastructure and AWS cloud storage using familiar storage protocols. Use File Gateway for NFS/SMB file shares backed by S3, Tape Gateway to replace physical tape with cloud virtual tapes, and Volume Gateway for iSCSI block storage with cloud backup. It's the primary service for **hybrid cloud storage** migrations and workloads that must span on-premises and AWS simultaneously.

---
---

# 26. 🔍 AWS CloudTrail

---

## 26.1 What is AWS CloudTrail?

**AWS CloudTrail** is a service that **records all API calls and actions** taken in your AWS account — who did what, when, from where, and on which resources.

Think of CloudTrail as a **CCTV system for your entire AWS account**. Every action — launching an instance, modifying a security group, deleting an S3 bucket, or logging into the console — is recorded with full details including user identity, timestamp, IP address, and request/response.

---

## 26.2 What CloudTrail Records

Every log entry contains:

| Field | Description |
|---|---|
| **Who** | IAM user, role, or AWS service that made the call |
| **When** | Exact timestamp of the action |
| **Where from** | Source IP address |
| **What** | API action taken (e.g., `RunInstances`, `DeleteBucket`) |
| **Which resource** | Resource ARN affected |
| **Result** | Success or failure (with error code if failed) |

---

## 26.3 Event Types

| Type | Description | Example |
|---|---|---|
| **Management Events** | Control plane operations — managing AWS resources | Creating EC2, deleting S3, modifying security groups |
| **Data Events** | Data plane operations — actions on resource data | S3 object reads/writes, Lambda invocations, DynamoDB reads |
| **Insight Events** | Unusual API activity patterns detected by CloudTrail AI | Sudden spike in IAM role creation, unusual API error rates |

**Default:** Management events logged automatically at no extra cost for last **90 days**.

To store logs **beyond 90 days** or enable data events: create a **Trail** that stores to S3.

---

## 26.4 Creating a Trail

```
CloudTrail → Trails → Create Trail
├── Trail Name: production-audit-trail
├── Storage location: S3 bucket (new or existing)
├── Log file validation: Enabled (detect if logs were tampered with)
├── CloudWatch Logs: Enable (for real-time monitoring and alerting)
├── SNS notification: Enable (notify on log file delivery)
├── Management events: Read + Write
├── Data events: S3 (All buckets) + Lambda
└── Insights events: Enable (detect unusual activity)
```

**Log File Validation:** CloudTrail creates a **digital signature (hash)** for each log file. If someone modifies a log file, validation detects the tampering — critical for compliance.

---

## 26.5 Integration with Other AWS Services

| Service | CloudTrail Integration |
|---|---|
| **S3** | Stores all CloudTrail log files |
| **CloudWatch Logs** | Stream logs for real-time alerts (e.g., alert when Root user logs in) |
| **SNS** | Notify team when new log files delivered |
| **Athena** | Query CloudTrail logs using SQL |
| **AWS Config** | Works alongside CloudTrail for configuration change tracking |
| **GuardDuty** | Uses CloudTrail data to detect threats |
| **Security Hub** | Aggregates CloudTrail findings for security posture |

---

## 26.6 Real-Time DevOps Production Scenario

**Application:** A fintech company with strict regulatory compliance — every AWS action must be logged and retained for 7 years, and security team must be alerted on suspicious activities.

**CloudTrail Setup:**
```
Trail: financial-audit-trail
  ├── All Management Events (Read + Write)
  ├── S3 Data Events: Enabled for all buckets
  ├── Lambda Data Events: Enabled for all functions
  ├── Insights Events: Enabled
  └── Log Storage: S3 → financial-audit-logs-bucket
      ↓ Lifecycle Policy:
      0-90 days: S3 Standard (active investigation)
      91-365 days: S3 Standard-IA (periodic review)
      366 days-7 years: S3 Glacier Deep Archive (compliance)
```

**Real-time Security Alerts via CloudWatch:**
```
CloudWatch Log Metric Filters on CloudTrail:
├── Root account login → Alert immediately (Critical)
├── IAM policy change → Alert DevOps lead (High)
├── Security group rule added → Alert security team (Medium)
├── S3 bucket made public → Alert immediately + auto-remediate via Lambda
└── MFA disabled on any account → Alert security team (High)
```

**Incident Investigation:**
```
Scenario: Unauthorized EC2 instances launched in ap-southeast-1 (unexpected region)

Investigation using CloudTrail:
1. Query Athena: SELECT * FROM cloudtrail_logs WHERE eventName = 'RunInstances' AND awsRegion = 'ap-southeast-1'
2. Find: API call made by IAM user 'developer-3' from IP 103.45.xx.xx
3. Cross-check: That IP is not from corporate network
4. Action: Disable developer-3's credentials immediately
5. Terminate unauthorized instances
6. Full audit trail preserved for forensics and compliance reporting
```

---

## 26.7 Benefits

- **Complete audit trail** — Every AWS action recorded
- **Security analysis** — Detect unauthorized access, unusual activity
- **Compliance** — Meets SOC, ISO, PCI-DSS, HIPAA audit requirements
- **Troubleshooting** — Understand exactly what changed and when
- **Log integrity** — Tamper-evident log validation
- **Automatic** — No setup needed for 90-day event history

---

## 26.8 Summary

CloudTrail is your AWS account's audit log — it records every API call and management action. Enable it in every account and every region, store logs in S3 with lifecycle policies for long-term retention, enable log file validation for tamper detection, and create CloudWatch alarms for critical security events. CloudTrail answers the crucial question during any incident: "Who did this, when, and from where?"

---
---

# 27. ⚙️ AWS Config

---

## 27.1 What is AWS Config?

**AWS Config** is a service that **continuously records and evaluates the configurations** of your AWS resources — tracking what your resources look like at every point in time and whether they comply with your defined rules.

Think of AWS Config like a **configuration history timeline and compliance checker**. While CloudTrail records *actions* (who called which API), AWS Config records *states* (what does this resource look like right now and how has it changed over time).

---

## 27.2 What AWS Config Does

| Capability | Description |
|---|---|
| **Configuration Recording** | Records the configuration of every AWS resource continuously |
| **Configuration History** | View how a resource's config changed over time |
| **Configuration Snapshots** | Point-in-time snapshot of all resource configurations |
| **Compliance Rules** | Define rules — Config checks resources against them and flags non-compliant ones |
| **Relationships** | Shows relationships between resources (which EC2 uses which security group) |
| **Change Notifications** | Sends SNS notifications when config changes |

---

## 27.3 What You Can See Per Resource

For each resource, AWS Config shows:
1. **Configuration Details** — Current configuration attributes
2. **Relationships** — Connected resources (e.g., EC2 → Security Group → VPC)
3. **Changes** — Timeline of configuration changes (before vs after)
4. **CloudTrail Events** — API calls that caused the change
5. **Compliance** — Which Config rules this resource passes or fails

---

## 27.4 Config Rules

Config Rules define **desired configurations** — Config evaluates resources against these rules and reports compliance:

**AWS Managed Rules examples:**
| Rule | What It Checks |
|---|---|
| `ec2-instance-no-public-ip` | EC2 instances should not have public IPs |
| `s3-bucket-server-side-encryption-enabled` | All S3 buckets must have encryption enabled |
| `iam-password-policy` | IAM password policy meets requirements |
| `rds-storage-encrypted` | All RDS instances must be encrypted |
| `restricted-ssh` | Security groups should not allow SSH from 0.0.0.0/0 |
| `mfa-enabled-for-iam-console-access` | All IAM users must have MFA enabled |

---

## 27.5 Integration with Other AWS Services

| Service | AWS Config Integration |
|---|---|
| **S3** | Store Config logs and snapshots |
| **CloudTrail** | Config uses CloudTrail data to detect configuration changes |
| **SNS** | Notifications on configuration changes and compliance status |
| **Lambda** | Auto-remediate non-compliant resources (Config Rule + Lambda) |
| **CloudWatch** | Monitor Config compliance metrics |
| **Security Hub** | Config findings aggregated in Security Hub dashboard |
| **Systems Manager** | Automated remediation via Systems Manager Automation |

---

## 27.6 Real-Time DevOps Production Scenario

**Application:** A healthcare company — must comply with HIPAA requirements. Every configuration change must be tracked and non-compliant resources auto-remediated.

**Config Setup:**
```
AWS Config enabled in all regions
Recording: All resource types
S3 bucket: config-logs-healthcare-prod (7-year retention)
SNS: compliance-alerts topic

Config Rules:
├── rds-storage-encrypted → All RDS must be encrypted
├── s3-bucket-public-read-prohibited → No public S3 buckets
├── ec2-instances-in-vpc → All EC2 must be in VPC
├── iam-no-inline-policy → IAM inline policies not allowed
└── cloudtrail-enabled → CloudTrail must be enabled in all regions
```

**Auto-Remediation:**
```
Config detects: S3 bucket made public (violates rule)
    ↓ Config Rule triggers → Non-compliant
    ↓ Config triggers Lambda (remediation action)
    ↓ Lambda: aws s3api put-public-access-block --bucket xxxx --block-public-access
    ↓ SNS: Alert sent to security team
    ↓ S3 bucket blocked automatically within seconds
```

---

## 27.7 Summary

AWS Config is your configuration compliance and change tracking service. It records the state of every AWS resource over time, evaluates them against compliance rules, and helps you understand relationships between resources. Use it alongside CloudTrail — CloudTrail tells you who made a change, Config tells you what the resource looked like before and after. Essential for compliance frameworks (PCI-DSS, HIPAA, SOC2) and drift detection in infrastructure.

---
---

# 28. 🏗️ AWS CloudFormation

---

## 28.1 What is AWS CloudFormation?

**AWS CloudFormation** is an **Infrastructure as Code (IaC)** service that lets you model and provision your entire AWS infrastructure using **template files** (JSON or YAML).

Think of CloudFormation like **Lego instructions for your AWS infrastructure**. Instead of manually clicking through the AWS console to create VPCs, EC2 instances, RDS databases, and security groups — you write a template once and CloudFormation builds everything automatically, in the right order, every time.

---

## 28.2 Key Concepts

### Templates
A CloudFormation **Template** is a JSON or YAML file that describes your desired AWS resources.

```yaml
# Simple CloudFormation Template (YAML)
AWSTemplateFormatVersion: '2010-09-09'
Description: Simple web server stack

Resources:
  MyEC2Instance:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: ami-0abcdef1234567890
      InstanceType: t2.micro
      SecurityGroups:
        - !Ref MySecurityGroup

  MySecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: Allow HTTP
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: 80
          ToPort: 80
          CidrIp: 0.0.0.0/0
```

### Stacks
A **Stack** is a collection of AWS resources created and managed together as a single unit — defined by a template.

```
Template file → CloudFormation → Stack → AWS Resources

One stack could create:
├── VPC
├── 2 Public Subnets
├── 2 Private Subnets
├── Internet Gateway
├── NAT Gateway
├── 3 EC2 instances
├── 1 RDS database
├── 1 ALB
└── Multiple Security Groups
```

**Stack operations:**
- **Create:** Deploy all resources in template
- **Update:** Change resources (CloudFormation figures out what changed and updates minimally)
- **Delete:** Tear down all resources in the stack (clean, complete removal)

### Change Sets
Before updating a stack, create a **Change Set** to preview what will change — like a "diff" for your infrastructure.

---

## 28.3 Benefits of Infrastructure as Code

| Manual Console | CloudFormation (IaC) |
|---|---|
| Error-prone, human mistakes | Repeatable, consistent |
| Undocumented configuration | Self-documenting templates |
| Hard to replicate | Identical environments from same template |
| No version control | Templates stored in Git — full change history |
| Manual rollback | Automatic rollback on failure |
| Slow | Entire infrastructure deployed in minutes |

---

## 28.4 Use Cases

- **Replicate environments:** Use one template to create identical dev, staging, and production environments
- **Disaster recovery:** Recreate entire infrastructure in another region from template
- **Compliance:** Enforce standardized, approved configurations via templates
- **Version control:** Store infrastructure changes in Git — code review, approval workflows
- **Team collaboration:** Share infrastructure templates across teams

---

## 28.5 Integration with Other AWS Services

| Service | CloudFormation Integration |
|---|---|
| **All AWS Services** | CloudFormation can provision virtually any AWS resource |
| **S3** | Templates stored in S3 buckets |
| **CodePipeline** | Automated infrastructure deployment in CI/CD pipelines |
| **SNS** | Stack events (create, update, delete) sent to SNS |
| **IAM** | CloudFormation assumes IAM roles to create resources |
| **Systems Manager** | Parameter Store integration for secrets/configs in templates |

---

## 28.6 Real-Time DevOps Production Scenario

**Application:** A SaaS company needs identical environments for dev, staging, and production — and must deploy new customer environments on demand.

**Template Structure:**
```
templates/
├── vpc.yaml               (VPC, subnets, IGW, NAT)
├── security-groups.yaml   (All security group definitions)
├── rds.yaml               (RDS MySQL Multi-AZ)
├── ec2-asg.yaml           (EC2 Launch Template + Auto Scaling Group)
├── alb.yaml               (Application Load Balancer)
└── master.yaml            (Nested stack — references all above)
```

**Deployment Pipeline:**
```
Developer pushes infrastructure change to Git
    ↓ Pull Request → Code review by senior architect
    ↓ Approved → Merged to main
    ↓ CodePipeline triggered
    ↓ CloudFormation Change Set created
    ↓ DevOps reviews Change Set (what exactly will change)
    ↓ Approved → Stack update deployed
    ↓ If failure: CloudFormation automatically rolls back to previous state
    ↓ SNS notification: "Stack update successful/failed"
```

**New customer onboarding:**
```
New enterprise customer signs up
    ↓ API call: aws cloudformation create-stack
        --stack-name "customer-acme-corp"
        --template-url s3://cf-templates/master.yaml
        --parameters CustomerName=acme Environment=production
    ↓ CloudFormation creates isolated environment for ACME Corp
    ↓ VPC, subnets, EC2, RDS, ALB all created automatically
    ↓ ~15 minutes → Customer's environment ready
    ↓ DNS record created → customer.acme.myplatform.com live
```

---

## 28.7 Summary

CloudFormation is AWS's Infrastructure as Code service — it lets you define your entire AWS infrastructure in templates and deploy it consistently, repeatably, and automatically. Store templates in Git for version control, use Change Sets to safely preview updates, and leverage stacks to group related resources. CloudFormation is the foundation of DevOps and GitOps practices on AWS — enabling infrastructure to be treated with the same discipline as application code.

---
---

# 29. 🛡️ AWS Trusted Advisor

---

## 29.1 What is AWS Trusted Advisor?

**AWS Trusted Advisor** is an **automated best practices advisor** that continuously analyzes your AWS environment and provides **real-time recommendations** to help you reduce costs, improve performance, increase security, improve fault tolerance, and stay within service limits.

Think of Trusted Advisor like a **team of AWS experts constantly reviewing your account** — looking for waste, security holes, performance bottlenecks, and potential failures, and telling you how to fix them.

---

## 29.2 Five Check Categories

### 💰 1. Cost Optimization
Find resources you're paying for but not fully using.

**Examples:**
- Idle EC2 instances (low CPU utilization for 14+ days)
- Underutilized EBS volumes
- Reserved Instances with low utilization
- Idle RDS DB instances
- Unassociated Elastic IP addresses (charged when not in use)

### ⚡ 2. Performance
Find opportunities to improve application response times.

**Examples:**
- EC2 instances with high CPU utilization (need to be upsized)
- CloudFront not enabled for S3 content delivery
- EBS provisioned IOPS above what the instance can utilize
- Overutilized RDS instances

### 🔒 3. Security
Identify security risks and gaps.

**Examples:**
- Security groups with unrestricted access (0.0.0.0/0) on sensitive ports (22, 3389)
- S3 buckets with public read or write access
- IAM users without MFA enabled
- Root account with no MFA
- AWS CloudTrail not enabled
- Exposed access keys (checks GitHub and public code repositories!)

### 🏥 4. Fault Tolerance
Identify single points of failure.

**Examples:**
- EC2 instances not in Auto Scaling Groups
- RDS instances without Multi-AZ enabled
- EBS volumes without recent snapshots
- Route 53 records without health checks
- Load balancers with instances only in one AZ

### 📊 5. Service Limits
Alert before you hit AWS service quotas.

**Examples:**
- EC2 instance count approaching limit
- VPCs per region approaching limit
- IAM groups approaching limit
- ELBs approaching limit

---

## 29.3 Traffic Light System

| Color | Meaning |
|---|---|
| 🔴 **Red** | Action recommended — serious issue to fix |
| 🟡 **Yellow** | Investigation recommended — potential issue |
| 🟢 **Green** | No problem detected — best practices followed |

---

## 29.4 Access Levels by Support Plan

| Support Plan | Trusted Advisor Access |
|---|---|
| **Basic** (Free) | 7 core security checks + all service limit checks |
| **Developer** | Same as Basic |
| **Business** | All **115+ checks** across all five categories |
| **Enterprise** | All checks + programmatic access via API |

---

## 29.5 Real-Time Production Scenario

**Scenario:** A DevO
