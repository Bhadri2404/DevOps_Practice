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
