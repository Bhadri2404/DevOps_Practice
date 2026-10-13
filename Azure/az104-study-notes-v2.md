# 🎯 AZ-104 Microsoft Azure Administrator — Complete Study Notes

> **Source:** Alan Rodrigues — AZ-104 Microsoft Azure Administrator Certification (Udemy)
> **Style:** Beginner-friendly · Exam-ready · Real-world DevOps production scenarios
> **Assumes:** You know cloud fundamentals and AWS — every topic includes a 💡 "If you know AWS" anchor
> **Every topic includes:** a plain-English explanation with an analogy, a flow diagram, 📍 UI/CLI steps, an integration table, a production scenario, benefits, use cases, and exam Q&A
> **Depth tiers:** 🔴 Full · 🟠 Medium · 🟡 Know-this-much
> **Course lecture numbers** appear under each topic so you can jump back to the video.

---

# 📋 TABLE OF CONTENTS

### 🚀 Starting with Azure
1. [Introduction to Azure](#1--introduction-to-azure) 🟡
2. [The Azure Free Account](#2--the-azure-free-account) 🟡
3. [Tour of the Azure Portal](#3--tour-of-the-azure-portal) 🟡

### 🖥️ Compute — Virtual Machines
4. [Azure Virtual Machines — Service Overview & Anatomy](#4--azure-virtual-machines--service-overview--anatomy) 🔴
5. [Lab — Building a Windows VM & Connecting (RDP)](#5--lab--building-a-windows-vm--connecting-rdp) 🔴
6. [Lab — Resizing the Virtual Machine](#6--lab--resizing-the-virtual-machine) 🟠
7. [Connecting from macOS & Troubleshooting Connectivity](#7--connecting-from-macos--troubleshooting-connectivity) 🟠
8. [Lab — Web Server (IIS) on the Windows VM](#8--lab--web-server-iis-on-the-windows-vm) 🟠
9. [Azure Regions & Costing](#9--azure-regions--costing) 🟠
10. [Virtual Machine Sizes](#10--virtual-machine-sizes) 🟠
11. [Lab — Building a Linux VM & Connecting](#11--lab--building-a-linux-vm--connecting) 🔴
12. [Lab — Web Server on the Linux VM](#12--lab--web-server-on-the-linux-vm) 🟠
13. [Lab — Linux VM with SSH Keys](#13--lab--linux-vm-with-ssh-keys) 🟠
14. [Azure VM Disks & Adding Data Disks](#14--azure-vm-disks--adding-data-disks) 🔴
15. [Stopping a VM & Data Disk Snapshots](#15--stopping-a-vm--data-disk-snapshots) 🟠
16. [Disk Encryption — SSE, Key Vault, Disk Encryption Sets & ADE](#16--disk-encryption--sse-key-vault-disk-encryption-sets--ade) 🟠
17. [Custom Script Extensions (Windows & Linux)](#17--custom-script-extensions-windows--linux) 🟠
18. [Linux Cloud-init & Boot Diagnostics](#18--linux-cloud-init--boot-diagnostics) 🟡
19. [Availability Sets](#19--availability-sets) 🟠
20. [Availability Zones](#20--availability-zones) 🟠
21. [Virtual Machine Scale Sets](#21--virtual-machine-scale-sets) 🔴

### 🌐 Compute — Web Apps & Containers
22. [Azure Web Apps (App Service)](#22--azure-web-apps-app-service) 🔴
23. [Web App Deployment Slots & Autoscaling](#23--web-app-deployment-slots--autoscaling) 🟠
24. [Container-Based Applications & Docker on a VM](#24--container-based-applications--docker-on-a-vm) 🟠
25. [Azure Container Registry (ACR)](#25--azure-container-registry-acr) 🟠
26. [Azure Container Instances & Container Groups](#26--azure-container-instances--container-groups) 🟠
27. [Multi-Container Applications](#27--multi-container-applications) 🟡
28. [Azure Container Apps](#28--azure-container-apps) 🟠

### 🌐 Networking
29. [Networking Fundamentals (IP, CIDR, Subnet Mask)](#29--networking-fundamentals-ip-cidr-subnet-mask) 🟠
30. [Virtual Network (VNet)](#30--virtual-network-vnet) 🔴
31. [Subnets](#31--subnets) 🔴
32. [Network Security Groups (NSG)](#32--network-security-groups-nsg) 🔴
33. [Application Security Groups (ASG)](#33--application-security-groups-asg) 🟠
34. [VNet Peering](#34--vnet-peering) 🟠
35. [Azure Bastion](#35--azure-bastion) 🟠
36. [Network Watcher](#36--network-watcher) 🟠
37. [Connection Monitor](#37--connection-monitor) 🟡
38. [User-Defined Routes (UDR)](#38--user-defined-routes-udr) 🟠
39. [Azure Load Balancer](#39--azure-load-balancer) 🔴
40. [Azure DNS — Fundamentals & Public DNS](#40--azure-dns--fundamentals--public-dns) 🟠
41. [Azure DNS — Private DNS](#41--azure-dns--private-dns) 🟠
42. [Web App VNet Integration & Custom Domains](#42--web-app-vnet-integration--custom-domains) 🟡

### 💾 Storage
43. [Azure Storage Accounts & Types](#43--azure-storage-accounts--types) 🔴
44. [Azure Blob Service](#44--azure-blob-service) 🔴
45. [Blob Authorization (Keys, SAS, Stored Access Policy)](#45--blob-authorization-keys-sas-stored-access-policy) 🔴
46. [Immutable Blob Storage](#46--immutable-blob-storage) 🟡
47. [Data Redundancy](#47--data-redundancy) 🟠
48. [Access Tiers & Lifecycle Management](#48--access-tiers--lifecycle-management) 🟠
49. [Blob Snapshots, Versioning & Object Replication](#49--blob-snapshots-versioning--object-replication) 🟡
50. [Azure File Shares](#50--azure-file-shares) 🟠
51. [AzCopy & Premium Storage](#51--azcopy--premium-storage) 🟡

### ⌨️ PowerShell & CLI
52. [Azure PowerShell](#52--azure-powershell) 🟠
53. [Azure Cloud Shell](#53--azure-cloud-shell) 🟡
54. [Azure CLI](#54--azure-cli) 🟠

### 📄 ARM Templates
55. [ARM Templates — Structure & Deployment](#55--arm-templates--structure--deployment) 🟠
56. [ARM Templates — Parameters, Variables & Dependencies](#56--arm-templates--parameters-variables--dependencies) 🟠

### 💪 Bicep
57. [Bicep — Fundamentals & Deployment](#57--bicep--fundamentals--deployment) 🟠
58. [Bicep — Parameters, Loops & Modules](#58--bicep--parameters-loops--modules) 🟠
59. [Bicep Modules — Full Infrastructure Project](#59--bicep-modules--full-infrastructure-project) 🟠
60. [Service Endpoints](#60--service-endpoints) 🟠
61. [Private Endpoints](#61--private-endpoints) 🔴

### 🔐 Identity & Governance
62. [Microsoft Entra ID](#62--microsoft-entra-id) 🔴
63. [Role-Based Access Control (RBAC)](#63--role-based-access-control-rbac) 🔴
64. [Custom Roles](#64--custom-roles) 🟠
65. [Microsoft Entra ID Roles](#65--microsoft-entra-id-roles) 🟠
66. [External Identities (B2B)](#66--external-identities-b2b) 🟡
67. [Microsoft Entra ID Licenses](#67--microsoft-entra-id-licenses) 🟡
68. [Self-Service Password Reset (SSPR)](#68--self-service-password-reset-sspr) 🟡
69. [Resource Tags](#69--resource-tags) 🟠
70. [Moving & Locking Resources](#70--moving--locking-resources) 🟡
71. [Management Groups](#71--management-groups) 🟠
72. [Azure Policy](#72--azure-policy) 🔴

### 📊 Monitor & Backup
73. [Azure Monitor & Alerts](#73--azure-monitor--alerts) 🔴
74. [Log Analytics & KQL](#74--log-analytics--kql) 🔴
75. [Azure VM Insights](#75--azure-vm-insights) 🟡
76. [Azure Backup (Recovery Services Vault)](#76--azure-backup-recovery-services-vault) 🔴
77. [MARS Agent Backup](#77--mars-agent-backup) 🟠
78. [File Share & Web App Backup](#78--file-share--web-app-backup) 🟡
79. [Azure Site Recovery](#79--azure-site-recovery) 🟠
80. [Azure Backup Vault](#80--azure-backup-vault) 🟡

### 🧩 JD-Aligned Additions (beyond the AZ-104 course)
81. [Azure Event Hubs](#81--azure-event-hubs) 🔴
82. [Azure Event Grid & Event Subscriptions](#82--azure-event-grid--event-subscriptions) 🟠
83. [Azure Storage Queues](#83--azure-storage-queues) 🟠
84. [Azure AI Foundry](#84--azure-ai-foundry) 🟠
85. [Azure Machine Learning Workspace & Endpoints](#85--azure-machine-learning-workspace--endpoints) 🟠
86. [Terraform on Azure](#86--terraform-on-azure) 🔴

---
---

# 1. ☁️ Introduction to Azure
> 🟡 KNOW-THIS-MUCH
> 📚 Course lecture: 3 (Introduction to Azure)

---

## 1.1 What Is Azure?

**Microsoft Azure** is Microsoft's **public cloud** — the on-demand delivery of IT resources (compute, storage, networking, databases, and hundreds of other services) **over the internet with pay-as-you-go pricing.**

Think of Azure like **electricity for IT**. You don't build your own power plant to light your house — you plug into the grid and pay for what you use. Azure works the same way: instead of buying servers and running a datacenter, you rent exactly the infrastructure you need, turn it on in minutes, and switch it off when you're done.

> 💡 **If you know AWS:** Azure is Microsoft's equivalent of AWS — same idea, different names (VM = EC2, VNet = VPC, Blob = S3, Entra ID ≈ IAM + directory). The single biggest mental shift: Azure ties everything to **Microsoft Entra ID** (identity) and organizes resources into **Subscriptions** and **Resource Groups** instead of AWS accounts.

---

## 1.2 Traditional IT vs Cloud

| Traditional IT | Cloud (Azure) |
|---|---|
| Buy hardware up front (capital expense) | Pay only for what you use (operating expense) |
| Weeks to provision servers | Provision in minutes |
| You run the datacenter | Microsoft runs the datacenter |
| Fixed capacity (guess ahead) | Scales up/down on demand |
| Over-provision (waste) or under-provision (outage) | Right-sized automatically |

---

## 1.3 Who Manages What? IaaS vs PaaS vs SaaS (Flow Diagram)

```
                 ON-PREMISES      IaaS          PaaS          SaaS
                 (your own DC)    (VMs)         (App Service) (Microsoft 365)
                ┌────────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
 Application    │   YOU      │  │   YOU    │  │   YOU    │  │  AZURE/  │
 Data           │   YOU      │  │   YOU    │  │   YOU    │  │  VENDOR  │
 Runtime        │   YOU      │  │   YOU    │  │  AZURE   │  │  AZURE   │
 Operating Sys  │   YOU      │  │   YOU    │  │  AZURE   │  │  AZURE   │
 Virtualization │   YOU      │  │  AZURE   │  │  AZURE   │  │  AZURE   │
 Servers        │   YOU      │  │  AZURE   │  │  AZURE   │  │  AZURE   │
 Storage        │   YOU      │  │  AZURE   │  │  AZURE   │  │  AZURE   │
 Networking     │   YOU      │  │  AZURE   │  │  AZURE   │  │  AZURE   │
                └────────────┘  └──────────┘  └──────────┘  └──────────┘
   More control ◄──────────────────────────────────────────► More convenience
```

| Model | You manage | Analogy | Azure example |
|---|---|---|---|
| **IaaS** (Infrastructure) | OS, runtime, app, data | Renting an empty plot of land | Virtual Machines, Virtual Networks |
| **PaaS** (Platform) | App and data only | Renting a furnished office | App Service, Azure SQL Database |
| **SaaS** (Software) | Just use it | Renting a hotel room | Microsoft 365, Dynamics 365 |

⭐ **Shared responsibility:** no matter the model, **you always own your data, your identities, and your accounts.** Microsoft always owns the physical datacenter.

---

## 1.4 Azure's Global Footprint (Flow Diagram)

```
GEOGRAPHY   (e.g., India — a data-residency / compliance boundary)
   │
   └── REGION   (e.g., Central India, South India, West US)
          │      a set of datacenters in one area
          │
          ├── AVAILABILITY ZONES  (3 physically separate datacenters
          │                        inside the region — supported regions only)
          │
          └── REGION PAIR  (each region is paired with another in the same
                            geography for disaster recovery & staggered updates)
```

| Term | Meaning |
|---|---|
| **Geography** | A market/compliance boundary containing one or more regions |
| **Region** | A set of datacenters connected by a low-latency network (e.g., Central India) |
| **Availability Zone** | A physically separate datacenter inside a region (independent power/cooling/network) |
| **Region pair** | Two regions paired for geo-redundant replication and staggered maintenance |

```
✅ You choose a REGION for most resources (affects latency, price, compliance, availability)
✅ Not every service / VM size exists in every region
✅ Prices differ between regions
✅ A Resource Group's region only stores its metadata — resources inside can be elsewhere
```

---

## 1.5 Azure Service Categories (What Exists)

| Category | Examples | AWS equivalent |
|---|---|---|
| **Compute** | Virtual Machines, App Service, Functions, AKS | EC2, Elastic Beanstalk, Lambda, EKS |
| **Networking** | Virtual Network, Load Balancer, Application Gateway, DNS | VPC, ELB/ALB, Route 53 |
| **Storage** | Blob, Files, Disks | S3, EFS, EBS |
| **Databases** | Azure SQL, Cosmos DB | RDS, DynamoDB |
| **Identity** | Microsoft Entra ID | IAM / Directory Service |
| **Management** | Monitor, Policy, Backup | CloudWatch, Config, AWS Backup |

---

## 1.6 How Azure Fits Together (Resource Hierarchy)

```
Management Group  →  Subscription  →  Resource Group  →  Resource
(governance across    (billing +        (logical folder      (VM, VNet,
 many subscriptions)   access boundary)  for related items)   Storage...)
```

| Level | Relates to | Covered in course |
|---|---|---|
| **Management Group** | Governance across many subscriptions | Section 10 (lecture 275) |
| **Subscription** | Billing + access boundary | Section 10 |
| **Resource Group** | Logical folder for an app/project | Section 10 (lecture 272) |
| **Resource** | The actual thing you deploy | Everywhere |

For now, remember: **everything you create lives in a Resource Group, inside a Subscription.**

---

## 1.7 Real-World Scenario — Choosing a Hosting Model

**Situation:** A company wants to host an internal HR web application and compares three approaches.

```
Option A — IaaS (Virtual Machine):
   Rent a VM, install Windows + IIS, patch it, back it up.
   → Full control, but the company owns OS patching and security updates.

Option B — PaaS (App Service):
   Just deploy the web app code. Azure patches the OS, load-balances, and scales.
   → Less control, far less admin work.

Option C — SaaS (an off-the-shelf HR product):
   Subscribe and configure it. No servers at all.
   → Least control, least effort.

Decision flow:
   Custom code, no special OS needs?        → PaaS (App Service)
   Legacy app needing OS-level access?      → IaaS (VM)
   Problem already solved by a product?     → SaaS

Result: the HR app is custom code → App Service (PaaS). The company
avoids managing servers entirely while keeping its code and data.
```

---

## 1.8 Benefits

- **No up-front hardware** — shift from capital expense to pay-as-you-go operating expense
- **Speed** — provision resources in minutes instead of weeks
- **Elastic scale** — grow and shrink with demand, no capacity guessing
- **Global reach** — deploy close to users across worldwide regions in minutes
- **Resilience** — Availability Zones and region pairs protect against failures
- **Breadth** — hundreds of services for compute, data, AI, networking, and security
- **Hybrid-friendly** — connect on-premises datacenters to Azure

---

## 1.9 Common Use Cases

- Hosting web and line-of-business applications (IaaS or PaaS)
- Migrating on-premises servers and datacenters to the cloud ("lift and shift")
- Disaster recovery and backup targets
- Dev/test environments spun up and torn down on demand
- Big data, analytics, and AI/ML workloads
- Global applications needing low-latency access in many regions

---

## 1.10 Exam Q&A

**Q: What's the difference between IaaS, PaaS, and SaaS?**
> IaaS gives you virtualized infrastructure (like VMs) where you manage the OS and up. PaaS gives you a managed platform (like App Service) where you manage only your app and data. SaaS is a finished application (like Microsoft 365) where you just use it. Moving IaaS → SaaS, you gain convenience and lose control.

**Q: What does the shared responsibility model say?**
> Microsoft is responsible for the physical datacenter, and the customer is always responsible for their data, identities, and access — with OS/runtime/app responsibilities split depending on IaaS, PaaS, or SaaS.

**Q: What's the difference between a Region and an Availability Zone?**
> A Region is a geographic area with one or more datacenters (e.g., Central India). An Availability Zone is a physically separate datacenter within a region, with independent power, cooling, and networking — used to survive a single datacenter failure.

**Q: Why does the region you choose matter?**
> It affects latency to users, price, data-residency/compliance, and which services and VM sizes are available.

**Q: What is a region pair?**
> Two regions in the same geography paired by Azure for disaster recovery — geo-redundant storage replicates to the pair, and Azure staggers platform updates across the pair to avoid simultaneous outages.

---

## 1.11 Summary

Azure is Microsoft's public cloud, delivering compute, networking, storage, databases, identity, and management services on a pay-as-you-go basis. Know the three service models — **IaaS** (you manage OS and up), **PaaS** (you manage app and data), **SaaS** (you just use it) — and the shared-responsibility rule that you always own your data and identities. Resources run in **Regions** (optionally with **Availability Zones** for datacenter-level resilience, and **region pairs** for DR), and everything you create sits in a **Resource Group** inside a **Subscription**.

[↑ Back to top](#-table-of-contents)

---
---

# 2. 🆓 The Azure Free Account
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 4 (The Azure Free Account), 5 (Creating an Azure Free Account)

---

## 2.1 What Is the Azure Free Account?

The **Azure Free Account** is a starter offer that gives you a sandbox with credit and free-tier services so you can follow every lab in this course at little or no cost.

Think of it like a **theme-park day pass with free-ride tokens**. You get some tokens to spend on any ride for a limited time (the credit), a set of rides that are free for a year (12-month free services), and a few rides that are always free (always-free services). When the tokens run out, nothing charges you automatically — you decide whether to buy more.

> 💡 **If you know AWS:** This is Azure's equivalent of the **AWS Free Tier**. The structural difference: Azure gives you a **time-limited credit** (spend within 30 days) *plus* 12-months-free amounts of popular services *plus* always-free services. Always confirm current limits at **azure.microsoft.com/free** — offers change.

---

## 2.2 What a Free Account Typically Includes (Flow Diagram)

```
AZURE FREE ACCOUNT
│
├── 💵 Starter CREDIT (about $200, valid for 30 days)
│      → spend on ANY Azure service during the first 30 days
│
├── 📅 12 MONTHS of free amounts of popular services
│      → e.g., small Linux/Windows VM hours, Blob storage,
│        managed disks, a small SQL database (limited quantity/month)
│
└── ♾️ ALWAYS-FREE services (with usage limits)
       → e.g., App Service (free tier), Functions grant, Entra ID (free tier)

After 30 days OR when the credit runs out:
   → credit-consuming resources are DISABLED until you UPGRADE
   → you are NOT charged automatically — upgrading is a deliberate step
```

⚠️ Credit amounts, durations, and free-service lists change over time. Treat the numbers above as a guide and confirm on the official page before signing up.

---

## 2.3 What You Need to Sign Up

```
✅ A Microsoft account (Outlook/Hotmail/Live) — or a work/school account
✅ A phone number (SMS/call identity verification)
✅ A credit/debit card (identity verification only — not charged unless you upgrade)
✅ One free trial per person — you can't stack multiple free accounts
```

Signing up with a personal Microsoft account also creates a default **Microsoft Entra ID tenant (directory)** and a subscription named something like **"Azure subscription 1"** (Free Trial).

---

## 2.4 UI Steps — Creating the Free Account

```
📍 START: azure.microsoft.com/free → "Try Azure for free" / "Start free"
    ↓
Sign in with your Microsoft account (or create one)
    ↓
── Step 1: Profile ──  Country/Region (cannot change later), name, email, phone
    ↓
── Step 2: Phone verification ──  receive a code → enter it
    ↓
── Step 3: Card verification ──  enter card details (verification only)
    ↓
── Step 4: Agreement ──  accept the customer agreement → "Sign up"
    ↓
"Go to Azure portal"

📍 RESULT: You land in portal.azure.com with a Free Trial subscription and
   your starter credit. Check it: search "Subscriptions" → your subscription.
```

**Check your credit:** search **Cost Management + Billing** → **Credits** (where available), or **Subscriptions → Overview** (shows offer = Free Trial).

---

## 2.5 Lab Hygiene — Protecting Your Credit

```
✅ Delete resource groups when a lab is finished (deletes everything inside)
✅ STOP (deallocate) VMs when idle — a running VM burns credit
✅ Remember leftovers still cost money: disks, static public IPs, etc.
✅ Set a Budget with alerts:  Cost Management → Budgets → + Add
✅ Prefer small sizes (B-series) for practice
✅ Don't leave labs running overnight "to finish tomorrow"
```

---

## 2.6 Real-World Scenario — Three Weeks of Labs

```
Week 1: Create the free account → build Windows + Linux VMs.
        End each session: delete the lab's Resource Group.
Week 2: Credit drops faster than expected → Cost Analysis shows a VM ran
        overnight. Delete it, add a $5 budget alert at 80%.
Week 3: The 30-day credit window ends. Choice: let the subscription disable,
        or upgrade to pay-as-you-go while keeping 12-month free amounts.

Lesson: the free account is generous but time-boxed — plan labs, clean up
after each one, and set a budget alert on day one.
```

---

## 2.7 Benefits

- **Risk-free learning** — real Azure, minimal or zero cost
- **No automatic charges** — resources disable rather than bill you when credit ends
- **Covers the whole course** — enough to complete every AZ-104 lab
- **Real tenant + subscription** — you learn on the same structures used in production
- **Budget controls** — set alerts so you never overspend

---

## 2.8 Common Use Cases

- Following along with AZ-104 labs
- Trying a service before committing to paid usage
- Personal learning projects and proofs of concept
- Short-lived dev/test environments

---

## 2.9 Exam Q&A

**Q: Are you charged automatically when the free trial credit runs out?**
> No. When the credit is used up or the 30-day period ends, credit-consuming resources are disabled until you explicitly upgrade to pay-as-you-go.

**Q: Why does Azure ask for a credit card on a free account?**
> For identity verification and abuse prevention. The card isn't charged unless you upgrade to a paid subscription.

**Q: What are the three parts of the free account offer?**
> A time-limited starter credit (~30 days), popular services free in limited amounts for 12 months, and always-free services with usage limits.

**Q: How do you avoid unexpected charges while learning?**
> Delete resource groups after labs, deallocate idle VMs, use small sizes, and set a Cost Management budget with alerts.

---

## 2.10 Summary

The Azure Free Account gives a starter credit (~$200 for 30 days), 12-months-free amounts of popular services, and always-free services — enough for the course labs. Sign-up needs a Microsoft account, phone, and a card for identity verification only; you're never billed automatically when credit ends (resources simply disable until you upgrade). Protect your credit by deleting Resource Groups after labs, deallocating idle VMs, and setting a budget alert. Always confirm current terms at azure.microsoft.com/free.

[↑ Back to top](#-table-of-contents)

---
---

# 3. 🧭 Tour of the Azure Portal
> 🟡 KNOW-THIS-MUCH
> 📚 Course lecture: 6 (Tour of the Azure Portal)

---

## 3.1 What Is the Azure Portal?

The **Azure Portal** (portal.azure.com) is the **web-based console** where you create, configure, and manage every Azure resource through a browser.

Think of it like the **cockpit of an aircraft**. Every instrument, switch, and gauge you need to fly is reachable from one place — and once you know where the search bar, the command line, and the notifications are, you can operate anything.

> 💡 **If you know AWS:** The Azure Portal is the equivalent of the **AWS Management Console**. The search bar works like AWS's global search, **Cloud Shell** mirrors AWS CloudShell, and the per-resource **Access control (IAM)** blade is where RBAC lives (like IAM on a resource).

---

## 3.2 Portal Layout (Flow Diagram)

```
┌──────────────────────────────────────────────────────────────────────┐
│ ☰  Microsoft Azure   [ 🔍 Search resources, services, and docs ]  >_ 🔔 ⚙ ? 👤│
├────────┬─────────────────────────────────────────────────────────────┤
│ ☰ MENU │   HOME                                                       │
│ • Home │   + Create a resource | Virtual machines | Storage | ...     │
│ • Dash-│   Recent resources / Favorites                               │
│   board│   Navigate: Subscriptions | Resource groups | All resources  │
│ • All  │                                                              │
│  servi-│                                                              │
│  ces   │                                                              │
└────────┴─────────────────────────────────────────────────────────────┘

TOP BAR (left → right):
   ☰   open/close the left menu
   🔍  Search bar — fastest way to reach ANY service or resource
   >_  Cloud Shell (Bash or PowerShell in the browser)
   🔔  Notifications (deployment progress & results)
   ⚙   Portal settings (theme, language, directories + subscriptions)
   ?   Help + support
   👤  Account, switch directory, sign out
```

---

## 3.3 Key Portal Pieces

| Piece | What it does |
|---|---|
| **Search bar** | Jump straight to any service ("Virtual machines") or resource by name |
| **+ Create a resource** | Starts a Marketplace creation wizard |
| **All services** | A–Z list of every service by category |
| **Resource groups** | The logical folders holding your resources |
| **All resources** | Flat list of everything in the selected subscriptions |
| **Subscriptions** | Billing/access boundaries; see resources and costs |
| **Cloud Shell (>_)** | Browser Bash/PowerShell, pre-authenticated, with `az` and Az PowerShell |
| **Directory + subscription filter** | Switch which Entra tenant and subscriptions you view |
| **Notifications 🔔** | Deployment progress — check here when a "Create" seems stuck |

### Anatomy of a resource page (blade)

```
Left menu (per resource):           Main pane:
 • Overview            → status + key info + action buttons (Connect, Start, Stop, Delete)
 • Activity log        → who did what to this resource, and when
 • Access control(IAM) → RBAC role assignments on this resource
 • Tags                → key-value labels for organizing/billing
 • Settings            → Networking, Disks, Size, ...
 • Automation          → Export template (the ARM template for this resource)
```

---

## 3.4 UI Steps — A Quick Guided Tour

```
📍 START: portal.azure.com
    ↓
1. Search  → type "Resource groups" → open it
2. Create  → "+ Create" → name "tour-rg", Region "Central India" → Create
3. Notify  → click 🔔 → "Resource group created successfully"
4. Cloud Shell → click ">_" → Bash → run:  az group list --output table
             → you should see "tour-rg"
5. Switch directory/subscription → 👤 "Switch directory" OR ⚙ "Directories + subscriptions"
6. Clean up → open "tour-rg" → "Delete resource group" → type its name to confirm

📍 RESULT: You've used search, create, notifications, Cloud Shell, and directory
   switching — the five actions you'll repeat all course long.
```

---

## 3.5 One Platform, Many Doors (Flow Diagram)

```
   Azure Portal (click)          ─┐
   Azure CLI  (az ...)           ─┤
   Azure PowerShell (New-Az...)  ─┼──►  AZURE RESOURCE MANAGER (ARM)
   ARM templates / Bicep         ─┤        the single API every tool uses
   REST API / SDKs               ─┘

Same result no matter which door. The course covers all:
   Portal labs → Sections 3–5, 10, 11 · PowerShell & CLI → Section 6
   ARM templates → Section 7 · Bicep → Sections 8–9
```

---

## 3.6 Real-World Scenario — "Who Deleted My VM?"

```
A teammate says "the VM I created last night is gone."

Step 1: Search "Resource groups" → open the VM's resource group.
Step 2: Left menu → "Activity log".
Step 3: Filter: Operation = "Delete Virtual Machine", Timespan = Last 24 hours.
Step 4: The log shows WHO deleted it, WHEN, and from which client/IP.
Step 5: If the whole resource group was deleted, check "Activity log" at the
        subscription level to find that event.

Result: a missing-resource mystery solved in two minutes with Activity log.
```

---

## 3.7 Benefits

- **Single pane of glass** — manage every Azure service from one browser console
- **Fast navigation** — search jumps to any service or resource instantly
- **Built-in command line** — Cloud Shell needs no local install
- **Consistent layout** — every resource page follows the same structure
- **Auditability** — Activity log answers "who did what, when"
- **Customizable** — dashboards, favorites, theme, and language

---

## 3.8 Common Use Cases

- Creating and configuring resources without scripting
- Troubleshooting with the Activity log and resource Overview
- Running quick CLI/PowerShell commands via Cloud Shell
- Switching between multiple tenants/subscriptions
- Building shareable dashboards for teams

---

## 3.9 Exam Q&A

**Q: What is Azure Cloud Shell?**
> A browser-based command line (Bash or PowerShell) built into the portal, already authenticated, with Azure CLI and Azure PowerShell preinstalled. Its files persist in an Azure Files share.

**Q: Where do you look to see who deleted a resource?**
> The Activity log of the resource, its resource group, or the subscription — it records management-plane operations including who performed them and when.

**Q: Difference between "Resource groups" and "All resources" in the portal?**
> Resource groups shows the logical containers and their contents; All resources is a flat list of every resource across the selected subscriptions regardless of group.

**Q: How do you switch to a different tenant or subscription?**
> Account menu (top-right) → Switch directory, or the settings gear → "Directories + subscriptions".

**Q: Do the portal, CLI, and PowerShell produce different results?**
> No — they all call Azure Resource Manager, so outcomes match; the choice is about convenience and automation.

---

## 3.10 Summary

The Azure Portal is the browser console for everything in Azure. Master the top bar — **search, Cloud Shell (>_), notifications, settings/directories** — and the predictable resource-page layout (**Overview, Activity log, Access control (IAM), Tags, Settings, Export template**). The portal, CLI, PowerShell, ARM templates, and Bicep are all doors into the same **Azure Resource Manager**, and this course teaches each. Use the **Activity log** to answer "who did what, when."

[↑ Back to top](#-table-of-contents)

---
---

# 4. 🖥️ Azure Virtual Machines — Service Overview & Anatomy
> 🔴 FULL
> 📚 Course lectures: 8 (Azure virtual machine service), 9 (Anatomy of building a VM)

---

## 4.1 What Is an Azure Virtual Machine?

An **Azure Virtual Machine (VM)** is an **on-demand virtual server** in Microsoft's datacenter — you pick the OS, CPU, RAM, disks, and network, and it's running in minutes, billed only while it runs.

Think of a VM like **renting a computer in someone else's datacenter**. You choose the specs, you get full admin control, and you hand it back (deallocate or delete) when you're done. But in Azure, a "VM" is really a **bundle of separate resources** that work together — a point the exam loves to test.

> 💡 **If you know AWS:** An Azure VM is the equivalent of an **EC2 instance**. Mapping: VM size ≈ instance type, Managed Disk ≈ EBS volume, VNet/subnet ≈ VPC/subnet, NSG ≈ Security Group, Public IP ≈ Elastic IP, Availability Set/Zone ≈ placement/AZ choice.

---

## 4.2 A VM Is Really Several Resources (Flow Diagram)

```
Clicking "Create" on a VM builds a connected set of resources:

                       ┌───────────────────────────┐
                       │  RESOURCE GROUP  (lab-rg)  │
                       │   ┌─────────────────────┐  │
                       │   │  VIRTUAL MACHINE     │  │  ← compute: CPU + RAM
                       │   │  (size, image, auth) │  │    (pay while it RUNS)
                       │   └──────────┬──────────┘  │
                       │   ┌──────────┴──────────┐  │
                       │   ▼                     ▼  │
                       │ OS DISK            DATA DISK(s)   ← Managed Disks
                       │ (always)           (optional)       (pay even if STOPPED)
                       │                            │
                       │   NETWORK INTERFACE (NIC)   │  ← the VM's "network card"
                       │     ├── Private IP (from subnet)
                       │     ├── Public IP  (optional)
                       │     └── NSG        (firewall)
                       │   VIRTUAL NETWORK + SUBNET  │  ← where the NIC lives
                       └───────────────────────────┘

DELETE the VM → the NIC, disks, public IP, NSG, and VNet may STILL EXIST
(and still bill you) unless you delete them or delete the Resource Group.
```

---

## 4.3 The "Create a VM" Wizard — Decisions That Matter

| Tab | Key settings | What to know |
|---|---|---|
| **Basics** | Subscription, RG, name, **Region**, availability option, image, **size**, auth, inbound ports | Region, image, size drive cost + capability |
| **Disks** | OS disk type, data disks, encryption | Premium SSD / Standard SSD / Standard HDD |
| **Networking** | VNet, subnet, public IP, NSG | The NIC and its firewall rules |
| **Management** | Monitoring, auto-shutdown, backup, identity | Auto-shutdown saves money on labs |
| **Monitoring** | Boot diagnostics | Helps troubleshooting |
| **Advanced** | Extensions, cloud-init / custom data | Run scripts at deployment |
| **Tags** | Key-value labels | Cost tracking |

**Availability options:**
```
No infrastructure redundancy  → single VM (99.9% SLA only with Premium SSD)
Availability zone             → separate datacenter (99.99% with 2+ VMs)
Availability set              → separate racks (99.95% with 2+ VMs)
Virtual machine scale set     → autoscaling group of identical VMs
```

**VM size families:** B = burstable (labs), D = general purpose, E = memory, F = compute, L = storage, N = GPU. Naming: `Standard_D2s_v5` = D series, 2 vCPUs, premium-storage capable ("s"), v5.

**Authentication:** Windows → username + password. Linux → SSH public key (recommended) or password.

⚠️ Opening RDP (3389) / SSH (22) to "Any" source exposes the VM to the whole internet — restrict by source IP or use **Azure Bastion**.

---

## 4.4 What You're Billed For

| VM state | Compute billed? | Disks billed? | Dynamic public IP kept? |
|---|---|---|---|
| Running | ✅ | ✅ | ✅ |
| Stopped (OS shutdown only) | ✅ **still billed** | ✅ | ✅ |
| **Stopped (deallocated)** | ❌ | ✅ | ❌ |
| Deleted | ❌ | Only leftover disks | Only leftover IPs |

⭐ Compute stops only when the VM is **deallocated** (portal Stop / `az vm deallocate`). Disks and leftover static IPs keep costing money.

---

## 4.5 UI Steps — Walking the Wizard

```
📍 portal.azure.com → "Virtual machines" → "+ Create" → "Azure virtual machine"
    ↓
Basics → Subscription / RG / name / Region / availability option / image / size / auth / ports
Disks → OS disk type (+ optional data disks)
Networking → VNet, subnet, public IP, NSG (auto-created if not chosen)
Management → enable Auto-shutdown for labs
Review + create → see the estimated hourly cost → Create
```

**CLI — one command creates the whole bundle:**
```bash
az vm create \
  --resource-group lab-rg --name demo-vm \
  --image Ubuntu2204 --size Standard_B2s \
  --admin-username azureuser --generate-ssh-keys

az resource list --resource-group lab-rg --output table   # see every resource created
```

---

## 4.6 Integration with Other Azure Services

| Service | Integration with VMs |
|---|---|
| **Managed Disks** | OS and data disks for the VM (persistent block storage) |
| **Virtual Network / NSG** | The VM's NIC lives in a subnet; NSG filters its traffic |
| **Public IP / Load Balancer** | Inbound internet access and traffic distribution |
| **Microsoft Entra ID + RBAC** | Who can manage the VM; VM login with Entra ID |
| **Managed Identity** | VM accesses Key Vault/Storage with no stored credentials |
| **Azure Monitor / VM Insights** | CPU, memory, disk, network metrics and logs |
| **Azure Backup** | Scheduled VM backups and restore |
| **Availability Set / Zone / Scale Set** | High availability and autoscaling |
| **Key Vault** | Secrets and disk-encryption keys for the VM |

---

## 4.7 Real-World Scenario — Right-Sizing a Finance VM

```
Request: a VM to run a legacy Windows reporting tool for the finance team.

Decisions:
   Region:       Central India (users in India; data residency)
   Image:        Windows Server 2022 Datacenter
   Size:         Standard_D4s_v5 (general purpose, steady load — not B-series)
   Disks:        Premium SSD OS disk + 1 Premium SSD data disk (report DB)
   Networking:   private subnet, NO public IP, NSG allows RDP only from Bastion
   Availability: single VM acceptable (internal tool); Azure Backup enabled
   Management:   auto-shutdown OFF (needed at month-end), backup ON
   Tags:         Environment=Prod, Owner=finance-it, CostCenter=FIN-204

Result: a right-sized, secured, tagged VM with cost visible by CostCenter tag
        and no direct internet exposure.
```

---

## 4.8 Benefits

- **Full control** — any supported OS, software, and configuration
- **Fast** — a server in minutes, not weeks
- **Flexible billing** — per-second compute, deallocate to stop paying
- **Resizable** — change size later without rebuilding
- **Resilient options** — Availability Sets, Zones, Scale Sets
- **Secure** — VNet isolation, NSGs, Managed Identity, disk encryption

---

## 4.9 Common Use Cases

- Lift-and-shift of on-premises servers
- Legacy or specialized apps needing OS-level access
- Windows Server / SQL Server workloads
- Custom databases or middleware you want to self-manage
- Dev/test environments and jump/bastion hosts

---

## 4.10 Exam Q&A

**Q: When you create a VM, what other resources are created?**
> At minimum a managed OS disk and a NIC, plus — unless you pick existing ones — a VNet and subnet, a public IP, and an NSG. They're separate resources in the resource group.

**Q: If you delete a VM, are its disks and NIC deleted?**
> Not necessarily. The OS disk can be set to delete with the VM, but data disks, NICs, and public IPs often remain and keep billing unless deleted (or you delete the resource group).

**Q: "Stopped" vs "Stopped (deallocated)"?**
> Shutting down inside the OS leaves the VM allocated and still billing compute. Stopping from the portal/CLI deallocates it, releasing compute and stopping compute billing (disks still bill).

**Q: What does `Standard_D2s_v5` tell you?**
> D-series (general purpose), 2 vCPUs, "s" = premium-storage capable, v5 hardware.

**Q: Must a VM and its VNet be in the same region?**
> Yes — a VM's NIC must connect to a VNet in the same region as the VM.

---

## 4.11 Summary

An Azure VM is the IaaS building block — but really a **bundle**: the VM (compute), an OS disk (+ optional data disks), a NIC, a private (and optional public) IP, an NSG, and a VNet/subnet. The wizard tabs — **Basics, Disks, Networking, Management, Monitoring, Advanced, Tags** — map to your key decisions: **region, availability option, image, size, authentication, open ports** (never RDP/SSH to "Any"). Billing matters: compute stops only when **deallocated**, while disks and leftover IPs keep costing — so delete the resource group when a lab is done.

[↑ Back to top](#-table-of-contents)

---
---

# 5. 🪟 Lab — Building a Windows VM & Connecting (RDP)
> 🔴 FULL
> 📚 Course lectures: 10 (Building a Windows VM), 11 (Connecting to the VM)

---

## 5.1 What This Lab Does

This lab turns the VM anatomy into a running **Windows Server** you can log into over **RDP** — the foundation for nearly every later lab (web servers, disks, NSGs, Bastion).

Think of it like **getting the keys to a new rental and walking through the front door for the first time**. You build the house (create the VM), get the key (credentials), and open the door (RDP) — and you learn the first security lesson: which doors you leave unlocked to the street.

> 💡 **If you know AWS:** Same as launching a Windows EC2 instance and connecting via RDP. Differences: in Azure you set the admin username/password at creation (no key-pair password decryption), and the firewall rule is an **NSG** rule instead of a Security Group.

---

## 5.2 The Flow (Flow Diagram)

```
YOU (laptop)                                         AZURE
    │ 1. Create VM in portal ───────────────────────►│ creates VM+disk+NIC+
    │                                                 │ public IP+NSG+VNet
    │ 2. Download RDP file (VM → Connect) ◄───────────│
    │ 3. Open RDP → enter admin username/password     │
    │    ── TCP 3389 over the internet ──────────────►│ NSG: allow 3389? ✅
    │ 4. Windows desktop appears ◄───────────────────►│

If step 3 fails → almost always: NSG rule, VM not running, wrong IP, or a
local firewall blocking outbound 3389.
```

---

## 5.3 Settings Used

| Setting | Value |
|---|---|
| Resource group | `lab-rg` (new) · VM name `win-vm-01` · Region Central India |
| Image | Windows Server 2022 Datacenter: Azure Edition |
| Size | Standard_B2s (low cost) |
| Username | `azureadmin` (not "admin"/"administrator") |
| Password | 12+ chars, upper + lower + number + symbol |
| Inbound ports | RDP (3389) · OS disk Standard SSD |

---

## 5.4 UI Steps — Build the VM

```
📍 "Virtual machines" → "+ Create" → Azure virtual machine → Basics:
   RG=lab-rg(new), name=win-vm-01, Region=Central India,
   Availability=No infrastructure redundancy, Image=Windows Server 2022,
   Size=Standard_B2s, Username=azureadmin, Password=****,
   Public inbound ports=Allow selected → RDP (3389)
    ↓
Disks → Standard SSD · Management → enable Auto-shutdown
    ↓
Review + create → Create → 🔔 "Deployment succeeded" → "Go to resource"
```

**CLI:**
```bash
az group create --name lab-rg --location centralindia
az vm create -g lab-rg -n win-vm-01 \
  --image MicrosoftWindowsServer:WindowsServer:2022-datacenter-azure-edition:latest \
  --size Standard_B2s --admin-username azureadmin \
  --admin-password '<Strong-Password>' --public-ip-sku Standard
az vm open-port -g lab-rg -n win-vm-01 --port 3389
```

---

## 5.5 UI Steps — Connect with RDP

```
📍 VM → "Connect" → "Connect" → "Download RDP File"
    ↓
Open the .rdp file → enter azureadmin + password → accept certificate → Yes
    ↓
📍 RESULT: the Windows Server desktop (Server Manager) appears.
```

From Windows CLI: `az vm show -d -g lab-rg -n win-vm-01 --query publicIps -o tsv` then `mstsc /v:<ip>`. macOS uses the Windows App / Remote Desktop client (next topic).

---

## 5.6 Security Lesson — What "Allow RDP" Really Means

```
The wizard's "RDP (3389)" creates this NSG rule:
   Priority 1000 | RDP | 3389 | TCP | Source: Any | Allow
                                       ↑ the WHOLE internet can attempt login

Within minutes of a public IP appearing, bots start brute-forcing RDP/SSH.
Safer options (later in the course):
   ✅ Restrict the rule SOURCE to your own public IP
   ✅ Use Azure BASTION (RDP/SSH over TLS, no public IP)
   ✅ Just-in-Time VM access (Defender for Cloud)
```

---

## 5.7 Troubleshooting — "Can't Connect"

```
1. VM Running (not "Stopped (deallocated)")?  → Start it
2. Public IP changed after a deallocate?       → re-download the RDP file
3. NSG allows 3389 inbound?                     → VM → Networking
4. Is your source IP still in the rule?         → home IPs change
5. Your network blocks outbound 3389?           → try another network
6. Right username/password?                     → VM → Reset password
7. Still stuck?                                  → Network Watcher (IP flow verify)
```

---

## 5.8 Integration with Other Azure Services

| Service | Role in this lab |
|---|---|
| **NSG** | The inbound 3389 rule that lets RDP through |
| **Public IP** | The address you RDP to |
| **Managed Disk** | The VM's OS disk |
| **Azure Bastion** | Safer browser-based RDP with no public IP |
| **Reset password (VMAccess extension)** | Recover lost credentials |
| **Network Watcher** | Diagnose blocked connections |

---

## 5.9 Real-World Scenario — Two-Day Installer Test

```
Day 1 AM: Create win-vm-01 (B2s) in a NEW "dev-test-rg", auto-shutdown 8 PM,
          restrict the RDP rule to the office IP, tag Owner/Environment.
Day 1 PM: Auto-shutdown deallocates the VM overnight → compute billing stops.
Day 2:    Test done → delete the whole "dev-test-rg" → VM, disk, NIC, IP, NSG,
          VNet all gone → nothing left to bill.

Result: a short-lived Windows test env that cost a few dollars, was never
exposed to the whole internet, and left nothing behind.
```

---

## 5.10 Benefits

- **Hands-on foundation** — the base VM for most later labs
- **Full Windows desktop** — manage via familiar Server Manager
- **Cheap for labs** — B-series + auto-shutdown
- **Easy cleanup** — delete the resource group to remove everything
- **Recoverable** — Reset password / Bastion if you lose access

---

## 5.11 Common Use Cases

- Windows Server application and installer testing
- Short-lived demo environments
- Learning RDP, NSG rules, and VM lifecycle
- A jump host to reach private resources (when secured)

---

## 5.12 Exam Q&A

**Q: Which port/protocol does RDP use, and what controls reachability?**
> TCP 3389. An NSG inbound Allow rule (on NIC and/or subnet) must permit it.

**Q: You can't RDP after a stop/start — likely cause?**
> The dynamic public IP changed on restart; re-download the RDP file (or use a static IP).

**Q: How do you stop paying for compute but keep the VM?**
> Stop (deallocate) it from the portal/CLI → status "Stopped (deallocated)". OS shutdown alone keeps billing; disks still bill.

**Q: Safer alternative to opening 3389 to the internet?**
> Azure Bastion, Just-in-Time access, restricting the NSG source IP, or private connectivity via VPN.

**Q: Remove everything from this lab in one action?**
> Delete the resource group.

---

## 5.13 Summary

Build a Windows VM (Windows Server 2022, B2s, `azureadmin`, RDP allowed) via **Basics → Disks → Networking → Management → Review + create**, then connect with **VM → Connect → Download RDP file** and your credentials. The wizard's "Allow RDP" opens 3389 to **Any** source — fine for a quick lab, but restrict it or use **Bastion** for anything real. Remember billing (**deallocate** to stop compute), common failure causes (VM not running, changed IP, missing NSG rule), and clean up by **deleting the resource group**.

[↑ Back to top](#-table-of-contents)

---
---

# 6. 📐 Lab — Resizing the Virtual Machine
> 🟠 MEDIUM
> 📚 Course lecture: 12 (Resizing the Virtual Machine)

---

## 6.1 What Is VM Resizing?

**Resizing** changes a VM's size (its CPU/RAM allocation) after creation — scaling **up** for more power or **down** to save money — without rebuilding the server.

Think of it like **swapping the engine in a car you already own**. The body, paint, and contents (OS and disks) stay the same; you just change the horsepower under the hood. But the car has to stop while you swap the engine — resizing always involves at least a restart.

> 💡 **If you know AWS:** Same as changing an **EC2 instance type** (stop → change type → start). Azure's portal does it in a click, but the VM still **restarts**. Resizing is *vertical* scaling; adding more VMs via a Scale Set is *horizontal* scaling.

---

## 6.2 What Happens During a Resize (Flow Diagram)

```
Choose a new size
   │ Available on the SAME hardware cluster the VM runs on?
   ├── YES → VM RESTARTS (short downtime), stays on same hardware
   └── NO  → VM must be DEALLOCATED first (portal does it) → moved to new
             hardware → started
                 ⚠️ Dynamic public IP may CHANGE
                 ⚠️ Temporary disk contents are LOST
Either way:  ✅ OS + data disks preserved   ❌ VM unavailable during restart
```

---

## 6.3 Key Rules (Exam-Relevant)

```
✅ A resize ALWAYS involves downtime (at least a restart)
✅ OS + data disks survive; the TEMP disk (D:/ /mnt) is wiped on a hardware move
✅ A dynamic public IP can change if the VM is deallocated; a STATIC IP stays
✅ Not every size is available in every region / on every hardware cluster
✅ Your regional vCPU QUOTA for that family must allow the new size
✅ Availability Set: a new size not on the cluster may require deallocating ALL set VMs
✅ Resizing changes the PRICE from when it's applied
✅ Sizes without "s" can't use Premium SSD
```

---

## 6.4 UI Steps — Resize the VM

```
📍 VM → "Availability + scaling" → "Size"
   (filter by vCPUs, RAM, Premium-disk support; greyed-out = unavailable here)
   → select Standard_B2ms → "Resize"
    ↓
🔔 "Updating virtual machine size" → VM restarts → refresh Overview → new size
    ↓
Reconnect (re-download RDP file if the public IP changed)
```

**CLI:**
```bash
az vm list-vm-resize-options -g lab-rg -n win-vm-01 -o table   # sizes w/o deallocating
az vm resize -g lab-rg -n win-vm-01 --size Standard_B2ms
# If the size isn't on the current cluster:
az vm deallocate -g lab-rg -n win-vm-01
az vm resize     -g lab-rg -n win-vm-01 --size Standard_D4s_v5
az vm start      -g lab-rg -n win-vm-01
```

---

## 6.5 When a Resize Fails

| Symptom | Cause | Fix |
|---|---|---|
| Size greyed out | Not on current hardware/region | Deallocate, then resize |
| "Quota exceeded" | Regional vCPU quota used up | Request increase (Usage + quotas) |
| Can't pick Premium SSD size | Size lacks "s" | Choose an "s" size |
| Resize OK but app slow | Wrong family (B-series out of credits) | Move to D/E/F series |

---

## 6.6 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Managed Disks** | Preserved across the resize (data safe) |
| **Public IP (static)** | Keeps the address stable through a deallocate/move |
| **Usage + quotas** | Gates which sizes you can resize to |
| **VM Scale Sets** | The no-downtime alternative (horizontal scaling) |
| **Azure Monitor** | Metrics that tell you when to resize |

---

## 6.7 Real-World Scenario — Month-End Spike

```
A finance reporting VM runs fine all month, then month-end processing exhausts memory.

Plan (resize = downtime, so schedule a window):
   Fri 8 PM: notify users of a 10-minute outage.
   Resize D2s_v5 (8 GiB) → D8s_v5 (32 GiB). Data disk untouched.
   Run month-end processing quickly on the bigger size.
   Mon: resize BACK DOWN to D2s_v5 to save cost.

For a recurring need → automate with Azure Automation, or move the workload to
a Scale Set / PaaS that scales without manual resizing.
```

---

## 6.8 Benefits

- **Right-size on demand** — match power to the workload
- **No rebuild** — disks and data are preserved
- **Cost control** — scale down when the extra power isn't needed
- **Simple** — one click in the portal or one CLI command

---

## 6.9 Common Use Cases

- Temporarily boosting a VM for a heavy batch/month-end job
- Correcting an initial undersize (app is slow) or oversize (wasting money)
- Moving off a struggling B-series onto D/F-series for steady load

---

## 6.10 Exam Q&A

**Q: Does resizing cause downtime?**
> Yes — at least a restart, and a deallocate/move if the new size isn't on the current hardware cluster.

**Q: What data is lost when you resize?**
> Temporary-disk data can be lost if the VM moves hardware. OS and data disks are preserved.

**Q: Why is a size greyed out?**
> Not available on the current hardware cluster (deallocating often unlocks more), not offered in the region, or it would exceed your vCPU quota.

**Q: Resize fails with a quota error — what do you do?**
> Request a vCPU quota increase for that family/region, or pick a family with remaining quota.

**Q: How do you scale with no downtime?**
> Scale out horizontally with a VM Scale Set behind a load balancer, instead of resizing one VM.

---

## 6.11 Summary

Resize via **Availability + scaling → Size → Resize** (or `az vm resize`), but it always causes at least a **restart** — and a **deallocate/move** if the new size isn't on the current cluster. Disks and data persist; the **temp disk is wiped** on a move and a **dynamic public IP may change**. Resizes can be blocked by hardware availability, region, or **vCPU quota**. Resizing is **vertical scaling with downtime**; for no-downtime scaling use **Scale Sets**.

[↑ Back to top](#-table-of-contents)

---
---

# 7. 🍎 Connecting from macOS & Troubleshooting Connectivity
> 🟠 MEDIUM
> 📚 Course lectures: 13 (Connecting from macOS), 14 (Troubleshooting connectivity)

---

## 7.1 What This Covers

Two practical skills: (1) connecting to a Windows VM from a **Mac**, and (2) a **repeatable method** to diagnose "I can't connect to my VM" instead of guessing.

Think of troubleshooting connectivity like a **plumber checking a blocked pipe section by section** — is the water even on (VM running)? Is the right tap open (NSG rule)? Is the pipe to the house clear (your network)? You test one joint at a time, top to bottom, and the leak reveals itself.

> 💡 **If you know AWS:** Same layered checks as on EC2 — instance running → public IP/route → Security Group/NACL → OS firewall → credentials. Azure's equivalents are VM state → public IP → **NSG** → OS firewall → credentials, plus Azure tools (Reset password, Redeploy, Serial console, Network Watcher).

---

## 7.2 Connecting from macOS (Flow Diagram)

```
Mac ──► Windows App / Microsoft Remote Desktop ──► TCP 3389 ──► NSG (allow?) ──► Windows VM
```

```
📍 Mac App Store → install "Windows App" (formerly "Microsoft Remote Desktop")
📍 Azure portal → VM → Overview → copy the Public IP
📍 Windows App → "+" → "Add PC":
      PC name:  <VM public IP>
      User account: azureadmin + password
    → Save → double-click the tile → accept certificate → Continue
📍 RESULT: the Windows desktop opens on your Mac.
```

Other ways in: **VM → Connect → Bastion** (browser-based, no public IP), or Cloud Shell.

---

## 7.3 The Troubleshooting Method (Flow Diagram)

```
"I can't connect"
 ① VM RUNNING?                 → ✘ Start it
 ② Using CURRENT public IP?    → ✘ re-copy IP / re-download RDP file
 ③ NSG ALLOWS the port?        → ✘ add Allow rule (3389 RDP / 22 SSH)
 ④ Your SOURCE IP allowed?     → ✘ update source (home IPs change)
 ⑤ Your network allows outbound?→ ✘ try another network / use Bastion
 ⑥ OS firewall / service OK?   → ✘ Run command / Serial console
 ⑦ CREDENTIALS right?          → ✘ VM → Help → Reset password
 ⑧ Still stuck →  Boot diagnostics, Serial console, Network Watcher, Redeploy
```

Work **top to bottom** — most issues are solved in steps ①–④.

---

## 7.4 The Azure Tools That Help

| Tool | Where | What it does |
|---|---|---|
| **Connect → Check access** | VM → Connect | Tests whether the NSG allows your IP to the port |
| **Effective security rules** | NIC | Combined result of subnet NSG + NIC NSG |
| **Reset password** | VM → Help | Reset admin password / re-enable RDP (VM must be running) |
| **Boot diagnostics** | VM → Help | Screenshot + serial log to see if the OS booted |
| **Serial console** | VM → Help | Text access without any network (needs boot diagnostics) |
| **Run command** | VM → Operations | Run scripts inside the VM without network login |
| **Redeploy + reapply** | VM → Help | Move the VM to a new host; fixes stuck host/network issues |
| **Network Watcher** | Search | IP flow verify, Next hop, Connection troubleshoot |

**Test from your machine:**
```bash
Test-NetConnection -ComputerName <ip> -Port 3389   # Windows
nc -vz <ip> 3389                                    # macOS/Linux
# "succeeded" → path+NSG OK (check creds/OS) · "timed out" → NSG/VM/IP/network
# "connection refused" → reached the VM but nothing listening (OS service/firewall)
```

---

## 7.5 Integration with Other Azure Services

| Service | Role |
|---|---|
| **NSG + Effective security rules** | The firewall layer most failures trace to |
| **Public IP (static)** | Avoids IP-change surprises after deallocate |
| **Azure Bastion** | Connect with no public IP at all |
| **VMAccess extension** | Powers Reset password / Reset SSH key |
| **Serial console / Run command** | Reach the VM through the fabric, not the network |
| **Network Watcher** | IP flow verify pinpoints the blocking rule |

---

## 7.6 Real-World Scenario — "Worked Friday, Not Monday"

```
① Status "Stopped (deallocated)" — Friday 7 PM auto-shutdown ran. Start it.
② Restart assigned a NEW dynamic public IP. Copy the new IP.
③ NSG Allow-RDP rule exists, source = the dev's HOME IP.
④ Dev is in the office today → different public IP → blocked.
   → Add the office IP range to the rule (or use Bastion).

Fix time: ~3 minutes, using only VM Overview and Networking.
Prevention: static IP (or Bastion), corporate IP range in rules, document auto-shutdown.
```

---

## 7.7 Benefits

- **Fast root cause** — a fixed order beats random guessing
- **Multiple recovery paths** — Reset password, Serial console, Run command, Redeploy
- **Cross-platform** — connect from Windows, macOS, or the browser (Bastion)
- **Visibility** — Effective rules and Network Watcher show exactly what's blocking

---

## 7.8 Common Use Cases

- Diagnosing "can't RDP/SSH" after a stop/start or NSG change
- Recovering a VM with lost credentials or a stuck OS
- Connecting to Windows VMs from Mac/Linux workstations
- Verifying a port is reachable before deploying an app

---

## 7.9 Exam Q&A

**Q: Which tool shows the combined subnet-NSG + NIC-NSG effect?**
> Effective security rules (on the NIC), also via Network Watcher's NSG diagnostics.

**Q: "Timed out" vs "connection refused"?**
> Timeout → packets dropped (NSG, wrong IP, VM stopped, blocking network). Refused → traffic reached the VM but nothing was listening on that port (OS service/firewall).

**Q: Forgot the admin password — how to regain access?**
> VM → Help → Reset password (VMAccess extension; VM must be running).

**Q: Reach a VM with no working network?**
> Serial console (needs boot diagnostics) or Run command — through the Azure fabric, not the network.

**Q: Which macOS client for RDP?**
> Microsoft's "Windows App" (formerly Microsoft Remote Desktop); use the VM's public IP as the PC name.

---

## 7.10 Summary

From a Mac, install **Windows App / Remote Desktop**, add a PC with the VM's **public IP** and admin credentials. When connection fails, work in order: **VM running → current public IP → NSG allows the port → your source IP is allowed → your network allows outbound → OS firewall/service → credentials → boot diagnostics/serial console/Network Watcher/redeploy**. "Timeout" points to network/NSG/VM state; "refused" points to the OS service.

[↑ Back to top](#-table-of-contents)

---
---

# 8. 🌐 Lab — Web Server (IIS) on the Windows VM
> 🟠 MEDIUM
> 📚 Course lecture: 15 (Setting up a web server on the VM)

---

## 8.1 What This Lab Does

A VM only you can log into isn't very useful — most real VMs **serve something**. This lab installs **IIS** (Internet Information Services) on the Windows VM and makes it reachable from the internet.

Think of it like **opening a shop inside your rented building**. Installing IIS is stocking the shelves; opening the NSG port is unlocking the street-facing door. Customers only get in if **both** the building's main door (NSG) *and* your shop door (Windows Firewall) are open.

> 💡 **If you know AWS:** Identical to installing IIS on EC2 and opening port 80 in the **Security Group**. Azure's equivalent is the **NSG**; the Windows Defender Firewall inside the VM is the same as the instance's OS firewall.

---

## 8.2 The Request Path — Two Firewalls (Flow Diagram)

```
Browser: http://<VM public IP>  (TCP 80)
     ▼
 Public IP ──► NSG (Allow 80 inbound?)   ← LAYER 1 (Azure)
                    │ ✅
               NIC → Windows VM
                    │
         Windows Firewall (WWW Services rule)  ← LAYER 2 (enabled by IIS install)
                    │ ✅
         IIS listening on :80 → serves C:\inetpub\wwwroot

Page won't load? One of: IIS not running · Windows Firewall blocks 80 ·
NSG has no Allow 80 · wrong/changed public IP.
```

---

## 8.3 UI Steps — Install IIS

```
📍 RDP into win-vm-01 → Server Manager → "Manage" → "Add Roles and Features"
   → Role-based installation → this server → tick "Web Server (IIS)"
   → Add Features → Next → Install → Close
📍 Test INSIDE the VM first:  open Edge → http://localhost → IIS welcome page ✅
```

**PowerShell (inside the VM, as Admin):**
```powershell
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
Get-Service W3SVC     # should show Running
```

---

## 8.4 UI Steps — Open Port 80 in the NSG

```
📍 portal → win-vm-01 → "Networking" → "Create port rule" → "Inbound port rule":
      Source=Any · Service=HTTP (port 80) · Protocol=TCP · Action=Allow
      Priority=310 · Name=Allow-HTTP-80  → Add
📍 From your laptop:  http://<VM public IP> → IIS welcome page ✅
```

**CLI (no RDP needed):**
```bash
az vm open-port -g lab-rg -n win-vm-01 --port 80 --priority 310
az vm run-command invoke -g lab-rg -n win-vm-01 --command-id RunPowerShellScript \
  --scripts "Install-WindowsFeature -Name Web-Server -IncludeManagementTools"
az vm show -d -g lab-rg -n win-vm-01 --query publicIps -o tsv
```

**Change the page:** edit `C:\inetpub\wwwroot\index.html` (IIS default folder). Later labs automate this with **Custom Script Extensions** so you don't RDP into each server.

---

## 8.5 Key Rules

```
✅ TWO layers must both allow traffic: NSG (Azure) + Windows Firewall (OS)
✅ NSG rules evaluate by PRIORITY (lowest number first) — a lower-numbered Deny wins
✅ IIS content folder: C:\inetpub\wwwroot · HTTP=80, HTTPS=443 (needs a cert)
✅ NSGs are stateful → no return/outbound rule needed for replies
✅ Always test http://localhost first to separate VM vs network problems
✅ A single-VM web server is a single point of failure (add Sets/Zones + LB later)
```

---

## 8.6 Integration with Other Azure Services

| Service | Role |
|---|---|
| **NSG** | Opens port 80 to the internet |
| **Public IP** | The address users browse to |
| **Custom Script Extension** | Automate IIS install + content at deploy time |
| **Load Balancer / App Gateway** | Spread traffic across multiple web VMs |
| **Azure DNS** | Map a friendly domain to the public IP |
| **Azure Monitor** | Watch request count, CPU, availability |

---

## 8.7 Real-World Scenario — Client Demo Site

```
Tue: Build win-vm-01 → install IIS via Run command → copy prototype files to wwwroot.
     NSG "Allow-HTTP-80" SOURCE = the client's office IP range (not "Any").
Thu: Client opens http://<public IP> → sees the prototype.
Fri: Delete the resource group → site gone, billing stopped.

Better long-term: static site → Storage static website / Static Web Apps;
dynamic app → App Service (PaaS, no IIS/OS to manage).
```

---

## 8.8 Benefits

- **Turns a VM into a server** — serve web content to users
- **Clear two-firewall lesson** — NSG + OS firewall, the core of VM networking
- **Automatable** — Run command / Custom Script Extension install without RDP
- **Scalable later** — add load balancing and multiple VMs

---

## 8.9 Common Use Cases

- Hosting a website or internal web app on a VM
- Quick client demos and prototypes
- Learning NSG rules, priorities, and stateful behavior
- Baseline for building a load-balanced web tier

---

## 8.10 Exam Q&A

**Q: IIS works on localhost but not from the internet — what's missing?**
> An NSG inbound rule allowing TCP 80 (assuming a public IP and Windows Firewall allows HTTP).

**Q: Priority 200 Deny 80 and priority 300 Allow 80 — what happens?**
> Denied. Lowest priority number wins, so the 200 Deny applies first.

**Q: Do you need an outbound NSG rule for the web server's replies?**
> No — NSGs are stateful; replies to allowed inbound connections are automatically allowed.

**Q: Default IIS content folder?**
> `C:\inetpub\wwwroot`.

**Q: Install software on a VM without logging in?**
> Run command (`az vm run-command invoke`) or a Custom Script Extension.

---

## 8.11 Summary

Install IIS (Server Manager → Web Server (IIS), or `Install-WindowsFeature Web-Server`), verify at **http://localhost**, then add an **NSG inbound rule for port 80** and browse to the **public IP**. Remember the two-firewall rule (**NSG + Windows Firewall**), NSG **priority order** (lowest wins), stateful rules (no return rule), and the content folder **C:\inetpub\wwwroot**. Restrict the source where you can, and note a single VM is a single point of failure.

[↑ Back to top](#-table-of-contents)

---
---

# 9. 🌍 Azure Regions & Costing
> 🟠 MEDIUM
> 📚 Course lectures: 16 (Understanding Azure regions), 17 (Costing for Azure resources)

---

## 9.1 What This Covers

Two questions precede every deployment: **"Where should this run?"** and **"What will it cost?"** The region affects latency, compliance, available services, resilience, and price; and you need tools to estimate and control spend.

Think of choosing a region like **choosing where to open a warehouse**. You pick it for closeness to customers (latency), local laws (compliance), what the location offers (services/sizes), and rent (price) — and you watch the bills so costs don't creep up unnoticed.

> 💡 **If you know AWS:** Azure **Regions** = AWS Regions; **region pairs** ≈ AWS cross-region DR; **Pricing Calculator** ≈ AWS Pricing Calculator; **Reservations/Savings Plans/Spot** ≈ Reserved Instances/Savings Plans/Spot; **Cost Management** ≈ Cost Explorer + Budgets.

---

## 9.2 Regions, Zones & Pairs (Flow Diagram)

```
GEOGRAPHY (India) → REGION: Central India ◄── REGION PAIR ──► REGION: South India
                       ├── Availability Zone 1 ┐ physically separate datacenters
                       ├── Availability Zone 2 ├─ (zone-enabled regions only)
                       └── Availability Zone 3 ┘
Other: sovereign clouds (Azure Government/China); not all regions have zones.
```

**How to choose a region:** compliance/data residency → latency → service & size availability → zone support → price → quota → DR plan. A **Resource Group's region only stores metadata**; resources inside can be elsewhere. A VM and its VNet must be in the **same region**.

---

## 9.3 What Determines Cost?

```
Cost = RESOURCE TYPE × SIZE/TIER × REGION × TIME/USAGE
     + DATA TRANSFER (outbound) + LICENSING (Windows/SQL) − DISCOUNTS
```

| Dimension | Examples |
|---|---|
| Compute | Per second while a VM is allocated |
| Storage | Per GB-month (+ transactions on some tiers) |
| Networking | Inbound free; outbound beyond a free allowance billed |
| Managed services | Per hour/unit (App Service plan, SQL vCore) |
| Idle resources | Static public IPs, load balancers, Bastion bill even when idle |

**Cost-saving levers:** right-sizing · deallocate/auto-shutdown · **Reservations** (1/3-yr) · **Savings Plan** · **Azure Hybrid Benefit** (reuse Windows/SQL licenses) · **Spot VMs** · delete orphans (unattached disks, unused IPs) · autoscale · storage tiering. Discount percentages vary — check current pricing.

---

## 9.4 UI Steps — Estimate & Track Cost

```
── Estimate BEFORE deploying (Pricing Calculator) ──
📍 azure.microsoft.com → Pricing → "Pricing calculator" → add Virtual Machines
   → set Region / OS / size / hours / savings option → read the monthly estimate
   → try changing region, size, and savings option to compare

── Track ACTUAL cost (portal) ──
📍 "Cost Management + Billing" → "Cost analysis" → Group by Resource group / Tag
📍 "Budgets" → "+ Add" → scope + amount + alerts (80% actual, 100% forecast) + email
📍 "Azure Advisor" → "Cost" tab → act on idle/right-size/reservation recommendations
```

**CLI:**
```bash
az account list-locations -o table                 # regions
az disk list --query "[?managedBy==null].name" -o table   # orphaned disks still billing
```

---

## 9.5 Integration with Other Azure Services

| Service | Role in region/cost decisions |
|---|---|
| **Pricing Calculator** | Estimate a design before deploying |
| **Cost Management + Billing** | Actual spend, breakdown by tag/RG, budgets |
| **Azure Advisor** | Cost/right-sizing/reservation recommendations |
| **Tags** | Attribute cost to teams/projects (chargeback) |
| **Azure Policy** | Restrict allowed regions/SKUs to control cost & compliance |
| **Availability Zones** | Region choice depends on zone support |

---

## 9.6 Real-World Scenario — Costing a 3-VM Web Tier

```
Step 1: Pricing Calculator — 3× D2s_v5 Windows, 730 h/month.
        PAYG baseline = 100%; + Hybrid Benefit = lower; + 3-yr Reservation = much lower.
        A cheaper region fails the data-residency rule → rejected.
Step 2: Pick Central India (compliance+latency), 1-yr reservation for steady VMs,
        Hybrid Benefit for existing Windows licenses.
Step 3: Dev/test: B-series + auto-shutdown at 8 PM, in a Dev/Test subscription.
Step 4: Tag everything (CostCenter, Environment); budget with alerts at 80%/100%;
        review Advisor monthly.

Result: design costed up front, biggest discounts on steady workloads, overspend
caught early.
```

---

## 9.7 Benefits

- **Informed placement** — balance latency, compliance, price, and resilience
- **Predictable spend** — estimate before building, alert before overspending
- **Automatic savings** — Advisor surfaces idle resources and discounts
- **Accountability** — tags map cost to teams and projects

---

## 9.8 Common Use Cases

- Choosing a region for a new workload (latency + compliance)
- Estimating monthly cost before committing
- Setting budgets and alerts to avoid bill shock
- Monthly cost-optimization reviews (right-size, reservations, cleanup)

---

## 9.9 Exam Q&A

**Q: What is a region pair and why does it exist?**
> Two regions in the same geography paired for DR — geo-redundant storage replicates to the pair, and Azure applies platform updates to one region of a pair at a time.

**Q: Can resources in a resource group be in different regions?**
> Yes — the RG's region only stores metadata; resources inside can be anywhere.

**Q: Which tool estimates cost before deployment?**
> The Azure Pricing Calculator (Cost Management + Billing for actual spend afterward).

**Q: How do you get alerted before exceeding a limit?**
> A budget in Cost Management with alert thresholds (e.g., 80% actual, 100% forecast).

**Q: Cheapest VM option that can be reclaimed with little notice?**
> Spot VMs — deep discount but can be evicted; use for fault-tolerant work.

---

## 9.10 Summary

Choose a **region** by compliance/data residency, latency, service/size availability, zone support, price, and quota (remember **geographies**, **region pairs**, **zones**, and that an RG's region is just metadata). Cost = **type × size × region × usage + transfer + licensing − discounts**. Estimate with the **Pricing Calculator**, track with **Cost Management** (analysis, budgets, alerts), optimize with **Advisor**, and save via **right-sizing, deallocating, Reservations/Savings Plans, Hybrid Benefit, Spot, tags, and deleting orphans**.

[↑ Back to top](#-table-of-contents)

---
---

# 10. 📏 Virtual Machine Sizes
> 🟠 MEDIUM
> 📚 Course lecture: 18 (Virtual Machine sizes)

---

## 10.1 What Are VM Sizes?

A **VM size** defines the hardware a VM gets — vCPUs, RAM, disk/NIC limits, and special features. Azure groups hundreds of sizes into **families** optimized for different workloads.

Think of sizes like **vehicles for different jobs**. A scooter (B-series) is cheap for short errands; a sedan (D-series) is the balanced daily driver; a van (E-series) hauls lots of cargo (memory); a sports car (F-series) is all engine (CPU); a truck (L-series) carries heavy loads (storage/IO); and a race car with a trailer (N-series) brings a GPU. Pick the wrong vehicle and you overpay or get stuck.

> 💡 **If you know AWS:** VM size = **EC2 instance type**. B ≈ T (burstable), D ≈ M/T (general), E ≈ R (memory), F ≈ C (compute), N ≈ P/G (GPU), L ≈ I/D (storage). `Standard_D4s_v5` reads like AWS's `m5.xlarge`, with letters encoding capabilities.

---

## 10.2 Choosing a Family (Flow Diagram)

```
What does the workload need MOST?
 Light/bursty → B (burstable)        Lots of RAM → E (memory)
 Balanced     → D (general purpose)  Lots of CPU → F (compute)
 Fast local disk → L (storage)       GPU → N
Then check: region availability · vCPU quota · price · Premium SSD ("s")
```

| Series | Optimized for | Typical workloads |
|---|---|---|
| **B** | Burstable, lowest cost | Labs, dev/test, small web/DB |
| **D** | General purpose (≈1:4 vCPU:RAM) | Web/app servers, small-medium DBs |
| **E** | Memory (≈1:8) | SQL Server, caches, analytics |
| **F** | Compute | Batch, CPU-heavy front-ends, game servers |
| **L** | Storage/IO | NoSQL, data warehousing |
| **N** | GPU | AI/ML, rendering, video encoding |
| **M / H** | Huge memory / HPC | SAP HANA, scientific simulation |

---

## 10.3 Decoding a Size Name

```
Standard _ D 4 d s _ v5
          │ │ │ │   └ Version (hardware gen)
          │ │ │ └──── s = Premium SSD capable
          │ │ └────── d = local temp disk
          │ └──────── vCPU count (4)
          └────────── Family (D = general purpose)
Other letters: a = AMD · p = Arm · l = low memory · i = isolated · m = high memory
Examples: B2s · D2s_v5 · E8ds_v5 · F4s_v2
```

**B-series credits:** burstable VMs have a baseline CPU %; below it they **earn** credits, above it they **spend** them. Out of credits → throttled to baseline (bad for sustained high CPU → use D/F).

---

## 10.4 Limits & Quotas

Each size caps **vCPUs/RAM, max data disks, max NICs, max IOPS/throughput, network bandwidth, temp-disk size, Premium-storage support, accelerated networking**. ⭐ A fast disk on a small VM is still limited by the **VM's** IOPS cap.

**Quota:** Azure limits vCPUs **per region, per family** (plus a regional total). Exceeding it fails creation until you request an increase.

---

## 10.5 UI Steps — Browse Sizes & Check Quota

```
📍 VM create wizard → Size → "See all sizes" → filter by Type/vCPUs/RAM/Premium
   → sort by "Cost/month" to compare → select one
📍 Quota: search "Quotas" (or Subscriptions → Usage + quotas) → Compute →
   Location → view Current usage vs Limit per family → "Request quota increase"
```

**CLI:**
```bash
az vm list-sizes --location centralindia -o table
az vm list-usage --location centralindia -o table          # quota usage
az vm list-skus --location centralindia --size Standard_D -o table   # availability/restrictions
```

---

## 10.6 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Managed Disks** | Premium SSD needs an "s" size; VM caps disk IOPS |
| **Usage + quotas** | Gates which sizes you can deploy |
| **Pricing Calculator / Advisor** | Compare and right-size |
| **VM Scale Sets** | Use sizes as the template for autoscaling |
| **Accelerated networking** | Supported on many 2+ vCPU sizes |

---

## 10.7 Real-World Scenario — Three Requests, Three Sizes

```
1. Intern practice server (light, idle most of the day) → B2s + auto-shutdown.
2. Production SQL with a 64 GiB working set → E8ds_v5 + Premium SSD data disks.
3. Nightly video transcoding (CPU-bound, interruptible) → F16s_v2, possibly Spot.

Pitfall caught: a build server on B-series ran at 80% CPU all day, exhausted
credits, and throttled → moved to D4s_v5.
Quota issue: creating E8ds_v5 failed ("quota exceeded for ESv5") → requested an
increase from 10 to 24 vCPUs.
```

---

## 10.8 Benefits

- **Right tool for the job** — families match workload shape
- **Cost efficiency** — pick the smallest size that performs
- **Predictable performance** — know the IOPS/NIC/bandwidth caps
- **Flexibility** — resize between sizes as needs change

---

## 10.9 Common Use Cases

- Choosing a family for a new workload (CPU vs memory vs IO vs GPU)
- Decoding a size name to confirm capabilities before deploying
- Planning vCPU quota before a large rollout
- Selecting Spot-friendly sizes for batch jobs

---

## 10.10 Exam Q&A

**Q: Best family for an in-memory database?**
> E-series (memory optimized).

**Q: What happens when a B-series VM runs out of CPU credits?**
> It's throttled to baseline CPU, so sustained-load apps slow down.

**Q: What does the "s" in `Standard_D4s_v5` mean?**
> The size supports Premium SSD storage.

**Q: Creation fails with a quota error though the size exists in the region?**
> Request a vCPU quota increase for that family/region (Usage + quotas), or pick another family.

**Q: A Premium SSD on a small VM isn't delivering its rated IOPS — why?**
> The VM size caps IOPS/throughput; use a larger size.

---

## 10.11 Summary

Choose a size by workload: **B** (burstable/cheap), **D** (general), **E** (memory), **F** (compute), **L** (storage/IO), **N** (GPU). Decode names like `Standard_D4ds_v5` — family, vCPUs, letters (**d** local disk, **s** Premium capable, **a** AMD, **p** Arm), version. Sizes cap **disks, NICs, IOPS, throughput, bandwidth**, and creation is gated by **regional/family vCPU quotas**. Compare with the portal size picker, `az vm list-sizes`, and the Pricing Calculator; request quota increases when needed.

[↑ Back to top](#-table-of-contents)

---
---

# 11. 🐧 Lab — Building a Linux VM & Connecting
> 🔴 FULL
> 📚 Course lectures: 19 (Building a Linux VM), 20 (Connecting to Linux), 21 (Connecting from macOS)

---

## 11.1 What This Lab Does

Builds an **Ubuntu** VM and connects to it over **SSH** from Windows and macOS — the Linux counterpart to the Windows VM lab. Most of the world's servers are Linux: cheaper (no Windows license), lighter, managed over SSH.

Think of SSH keys like a **tamper-proof lock and a single physical key**. The lock (public key) is bolted to the door on the VM; you keep the only key (private key) in your pocket. No password is ever shouted across the street (network), so burglars can't overhear it.

> 💡 **If you know AWS:** Same as launching an Ubuntu EC2 instance and `ssh -i key.pem ...`. In Azure the default admin user is whatever **you** choose (commonly `azureuser`), not a fixed `ubuntu`/`ec2-user`, and the key pair is created in the VM wizard.

---

## 11.2 The Flow (Flow Diagram)

```
YOU                                                    AZURE
 1. Create Ubuntu VM — choose SSH public key auth ────►│ VM+disk+NIC+IP+NSG(22)+VNet
 2. Download the PRIVATE key (.pem) — shown ONCE  ◄─────│
 3. ssh -i key.pem azureuser@<public IP> ── TCP 22 ───►│ NSG allow 22? ✅
                                      VM checks your key vs ~/.ssh/authorized_keys
 4. Shell prompt: azureuser@linux-vm-01:~$ ◄───────────│
Private key stays with YOU · Public key lives on the VM · No password on the wire.
```

---

## 11.3 Settings Used

| Setting | Value |
|---|---|
| Name | `linux-vm-01` · Region Central India |
| Image | Ubuntu Server 22.04 LTS (x64 Gen2) |
| Size | Standard_B1s / B2s |
| Authentication | **SSH public key** · Username `azureuser` |
| Key source | Generate new key pair → `linux-vm-01_key` |
| Inbound ports | SSH (22) · OS disk Standard SSD |

---

## 11.4 UI Steps — Build + Connect

```
📍 "Virtual machines" → "+ Create" → Basics: RG=lab-rg, name=linux-vm-01,
   Image=Ubuntu 22.04, Size=B2s, Auth=SSH public key, Username=azureuser,
   Key source=Generate new key pair, Inbound=SSH (22) → Review + create → Create
    ↓
⚠️ POP-UP: "Download private key and create resource" → linux-vm-01_key.pem downloads
   (THIS IS THE ONLY TIME you can download it — store it safely)
    ↓
── Connect from Windows (built-in OpenSSH) ──
   ssh -i .\linux-vm-01_key.pem azureuser@<public-ip>   → type "yes" on first connect
── Connect from macOS/Linux (Terminal) ──
   chmod 400 ~/.ssh/linux-vm-01_key.pem
   ssh -i ~/.ssh/linux-vm-01_key.pem azureuser@<public-ip>
```

**CLI:**
```bash
az vm create -g lab-rg -n linux-vm-01 --image Ubuntu2204 --size Standard_B2s \
  --admin-username azureuser --generate-ssh-keys
az vm open-port -g lab-rg -n linux-vm-01 --port 22
```

If you see **"UNPROTECTED PRIVATE KEY FILE"**, restrict permissions (`chmod 400` on macOS/Linux; `icacls` on Windows). Other ways in: portal **Connect → SSH tab**, Cloud Shell, **Bastion**, or `az ssh vm`.

---

## 11.5 First Commands

```bash
whoami; hostname; cat /etc/os-release   # identity + OS
df -h; free -h; lsblk                    # disks, memory, block devices
sudo apt update                          # refresh packages (needs outbound internet)
```

---

## 11.6 Troubleshooting SSH

| Error | Cause / Fix |
|---|---|
| `Connection timed out` | NSG blocks 22 / VM stopped / wrong IP / network blocks 22 |
| `Connection refused` | sshd not running → Run command / Serial console |
| `Permission denied (publickey)` | Wrong key/username → check `-i` path + username; reset key |
| `UNPROTECTED PRIVATE KEY FILE` | `chmod 400 key.pem` |
| `REMOTE HOST ID CHANGED` | New VM reused old IP → `ssh-keygen -R <ip>` |
| Lost private key | VM → Help → Reset password → **Reset SSH public key** |

---

## 11.7 Integration with Other Azure Services

| Service | Role |
|---|---|
| **NSG** | Allows inbound SSH (22) |
| **Managed Disk** | The Ubuntu OS disk |
| **Azure Bastion** | Browser SSH with no public IP |
| **VMAccess extension** | Reset SSH key if lost |
| **Microsoft Entra ID login** | Keyless SSH via Entra identities + RBAC |
| **Network Watcher** | Diagnose blocked SSH |

---

## 11.8 Real-World Scenario — Python API Prototype

```
Day 1: Build linux-vm-01 (B2s, Ubuntu). Move the key to ~/.ssh with chmod 400.
       NSG rule for 22 restricted to the office IP range (not "Any").
       ssh in → sudo apt install -y python3-pip → deploy the API.
Day 3: Laptop replaced → copy the private key securely, OR (if lost) use
       "Reset SSH public key" to install a new public key on the VM.

Lesson: the private key is the only credential. Password login is disabled by
default for key-based VMs, which is exactly why bots can't brute-force it.
```

---

## 11.9 Benefits

- **Strong auth** — key-based login, no passwords on the wire
- **Cheaper** — no Windows license cost
- **Cross-platform** — connect from Windows, macOS, Linux, or Bastion
- **Recoverable** — reset the public key if the private key is lost

---

## 11.10 Common Use Cases

- Hosting Linux web/app servers and APIs
- Container and DevOps tooling hosts
- Learning SSH, key management, and Linux administration
- Jump/bastion hosts (when secured)

---

## 11.11 Exam Q&A

**Q: Port/protocol for SSH, and what must allow it?**
> TCP 22; the NSG (and any OS firewall) must allow inbound TCP 22.

**Q: Where is the public key stored, and where does the private key live?**
> Public key in the admin user's `~/.ssh/authorized_keys` on the VM; private key stays on your machine (never uploaded).

**Q: You didn't download the generated private key — can you retrieve it later?**
> No. Azure doesn't keep it. Reset the VM's SSH public key to one you control.

**Q: Is password login allowed on a key-auth Linux VM?**
> No — disabled by default.

**Q: "Timed out" vs "permission denied (publickey)"?**
> Timed out → network/NSG/VM state. Permission denied → reached sshd but key/username rejected.

---

## 11.12 Summary

Build a Linux VM (**Ubuntu LTS**, small **B-series**, **SSH public key** auth, user `azureuser`, allow **SSH 22**); download the **private key once**. Connect with `ssh -i key.pem azureuser@<ip>` from Windows (OpenSSH), macOS/Linux (after `chmod 400`), Cloud Shell, or Bastion. Troubleshoot by symptom: **timeout → NSG/VM/IP**, **refused → sshd**, **permission denied → key/username**, **unprotected key → permissions**.

[↑ Back to top](#-table-of-contents)

---
---

# 12. 🌐 Lab — Web Server on the Linux VM
> 🟠 MEDIUM
> 📚 Course lecture: 22 (Deploying a web server on the Linux VM)

---

## 12.1 What This Lab Does

Installs a web server (**Nginx** or **Apache**) on the Ubuntu VM and makes it reachable from the internet — the IIS lesson repeated on Linux.

Think of it, again, like **opening a shop with two doors**: the building's street door (NSG) and your shop door (the OS firewall, `ufw`). On Azure's Ubuntu images the shop door is usually already propped open (ufw inactive), so the NSG is normally the only lock you must open.

> 💡 **If you know AWS:** Identical to installing Nginx/Apache on an EC2 Ubuntu instance and opening port 80 in the Security Group. The `apt` commands and file paths are the same; only the firewall layer is the **NSG**.

---

## 12.2 The Request Path (Flow Diagram)

```
Browser: http://<VM public IP>  (TCP 80)
  ▼
Public IP ──► NSG (Allow 80 inbound?)   ← LAYER 1 (Azure)
                   │ ✅
              NIC → Linux VM
                   │
       OS firewall (ufw/iptables)  ← LAYER 2 (usually INACTIVE on Azure images)
                   │ ✅
       nginx/apache2 listening :80 → serves /var/www/html
```

---

## 12.3 Terminal Steps — Install & Start

```bash
# SSH in, then:
sudo apt update
sudo apt install -y nginx            # or: apache2
sudo systemctl enable --now nginx    # start now + on every boot
systemctl status nginx               # "active (running)"
curl -I http://localhost             # test INSIDE the VM first → HTTP/1.1 200 OK
```

## 12.4 UI Steps — Open Port 80 in the NSG

```
📍 portal → linux-vm-01 → "Networking" → "Create port rule" → Inbound:
   Source=Any · Service=HTTP (80) · TCP · Allow · Priority=310 → Add
📍 Browser: http://<VM public IP> → "Welcome to nginx!" ✅
```

**CLI:** `az vm open-port -g lab-rg -n linux-vm-01 --port 80 --priority 310`

**Change the page:** `echo "<h1>Hello from $(hostname)</h1>" | sudo tee /var/www/html/index.html`

---

## 12.5 Troubleshooting — "Page Won't Load"

```
① systemctl status nginx       → ✘ sudo systemctl start nginx ; journalctl -u nginx
② sudo ss -tlnp | grep ':80'    → listening?
③ curl -I http://localhost      → works locally? (fix the server before the network)
④ sudo ufw status               → if "active", sudo ufw allow 80/tcp
⑤ NSG allows 80? (priorities)   → add Allow-HTTP-80; no lower-numbered Deny
⑥ Right IP + http:// (not https)?
```

---

## 12.6 Integration with Other Azure Services

| Service | Role |
|---|---|
| **NSG** | Opens port 80 |
| **Public IP / DNS** | Address and friendly name |
| **Load Balancer / App Gateway** | Spread traffic across web VMs |
| **Custom Script Extension / cloud-init** | Automate the install |
| **Azure Monitor** | Availability and performance |

---

## 12.7 Key Rules

```
✅ Two firewalls: NSG (Azure) + OS firewall (ufw, usually inactive on Azure images)
✅ systemctl enable --now = start now AND on every reboot
✅ Content folder: /var/www/html · test curl http://localhost first
✅ NSGs are stateful · installs need outbound internet · HTTPS(443) needs a cert
✅ A single VM web server is a single point of failure
```

---

## 12.8 Real-World Scenario — Campaign Landing Page

```
Build: Ubuntu B1s + Nginx; files in /var/www/html.
       NSG: Allow 80/443 from Any; Allow 22 only from the office IP.
       DNS: custom domain A record → the VM's STATIC public IP.
       TLS: certbot --nginx → free certificate → HTTPS on 443.
After the campaign: delete the resource group.

Better long-term: static site → Storage static website / Static Web Apps;
dynamic → App Service (no OS to patch).
```

---

## 12.9 Benefits

- **Serve content from Linux** — cheap, fast web hosting
- **Reinforces the two-firewall model** on Linux
- **Automatable** — cloud-init / Custom Script Extension
- **Scalable** — add load balancing and multiple VMs

---

## 12.10 Common Use Cases

- Hosting a Linux website or web app
- Reverse proxy / API front-end
- Campaign landing pages and prototypes
- Learning Linux services, systemctl, and NSGs

---

## 12.11 Exam Q&A

**Q: Nginx works on `curl localhost` but not from the browser — first check?**
> NSG inbound rules — ensure TCP 80 is allowed with no lower-numbered Deny, and use the current public IP.

**Q: What does `systemctl enable --now nginx` do?**
> Starts the service now and configures it to start at boot.

**Q: Do Azure Ubuntu images block port 80 at the OS level by default?**
> Typically no — `ufw` is installed but inactive, so the NSG is the main control.

**Q: Default content folder on Ubuntu?**
> `/var/www/html`.

---

## 12.12 Summary

Install `nginx`/`apache2`, start with **`systemctl enable --now`**, verify with **`curl http://localhost`**, then open **TCP 80 in the NSG** and browse to the **public IP**. Content lives in **/var/www/html**. Troubleshoot layer by layer — **service → listening port → localhost → OS firewall → NSG → IP/URL** — and remember a single VM is a single point of failure.

[↑ Back to top](#-table-of-contents)

---
---

# 13. 🔑 Lab — Linux VM with SSH Keys
> 🟠 MEDIUM
> 📚 Course lecture: 23 (Deploying a Linux machine — SSH keys)

---

## 13.1 What This Covers

Creating **your own** SSH key pair, deploying a VM that trusts it, and managing keys afterward — because passwords get guessed, reused, and brute-forced.

Think of it like a **challenge-and-response at a secret club**. The bouncer (VM) holds your photo (public key). You prove it's you by answering a riddle only the matching private key can solve — your actual secret never leaves your pocket, so eavesdroppers learn nothing.

> 💡 **If you know AWS:** Same as EC2 key pairs. Differences: Azure lets you **bring your own public key**, store a key as an Azure **SSH public key resource**, and **reset the key** on a running VM — whereas AWS key pairs are fixed at launch unless you edit `authorized_keys`.

---

## 13.2 How Key Login Works (Flow Diagram)

```
YOUR COMPUTER                                   LINUX VM
 PRIVATE KEY (~/.ssh/id_rsa, secret)            PUBLIC KEY (~/.ssh/authorized_keys)
    │ 1. "log in as azureuser" ────────────────────►│
    │ 2. VM sends a random CHALLENGE (encrypted with your public key) ◄─┤
    │ 3. Only the PRIVATE key decrypts it → send back the answer ──────►│
    │ 4. VM verifies → ✅ access granted (no password)                   │
Lost/stolen private key → generate a new pair, replace the PUBLIC key on the VM.
```

| | Private key | Public key |
|---|---|---|
| Lives | Your computer only | On the VM (+ optionally stored in Azure) |
| Shareable? | ❌ Never | ✅ Yes |
| Protect with | `chmod 400`, optional passphrase | — |

---

## 13.3 Three Ways to Supply the Key

| Wizard option | What it does | Use when |
|---|---|---|
| **Generate new key pair** | Azure creates the pair; private `.pem` downloads once | Quick labs |
| **Use existing key stored in Azure** | Choose a saved SSH key resource | Reusing across VMs |
| **Use existing public key** | Paste your `id_rsa.pub` text | You already own a key pair (most common) |

---

## 13.4 Steps — Create Your Own Key & Deploy

```bash
# 1. Generate a key pair on YOUR computer (Windows/macOS/Linux)
ssh-keygen -t rsa -b 4096 -C "azure-lab-key"        # or: -t ed25519
# → ~/.ssh/id_rsa (PRIVATE) + ~/.ssh/id_rsa.pub (PUBLIC)

# 2. Copy the PUBLIC key text
cat ~/.ssh/id_rsa.pub        # Windows: Get-Content $env:USERPROFILE\.ssh\id_rsa.pub
```
```
📍 3. VM create wizard → Auth=SSH public key, Username=azureuser,
      SSH public key source = "Use existing public key" → paste the .pub text
      → Review + create → Create   (no private-key download — you own it)
📍 4. Connect:  ssh -i ~/.ssh/id_rsa azureuser@<public-ip>
```

**CLI shortcuts:**
```bash
az vm create -g lab-rg -n linux-vm-02 --image Ubuntu2204 --admin-username azureuser \
  --ssh-key-values ~/.ssh/id_rsa.pub
az sshkey create -g lab-rg --name team-key        # store a public key in Azure
```

---

## 13.5 Managing Keys on an Existing VM

```
📍 VM → Help → "Reset password" → mode "Reset SSH public key" →
   username azureuser + paste NEW public key → Update  (VM must be running)
CLI:  az vm user update -g lab-rg -n linux-vm-02 -u azureuser \
        --ssh-key-value "$(cat ~/.ssh/new_key.pub)"
# Add a teammate's key manually (on the VM):
echo "ssh-rsa AAAA... teammate" >> ~/.ssh/authorized_keys
# Revoke: remove that line from authorized_keys
```

---

## 13.6 Integration with Other Azure Services

| Service | Role |
|---|---|
| **SSH public key resource** | Reuse one public key across many VMs |
| **VMAccess extension** | Reset/replace the public key via the portal/CLI |
| **Microsoft Entra ID login (AADSSHLoginForLinux)** | Keyless team access via Entra + RBAC |
| **Azure Bastion** | SSH with no public IP / no key exposure |
| **Key Vault** | Store private keys/secrets securely |

---

## 13.7 Real-World Scenario — Team Access to a Jump Host

```
Bad:  one Azure-generated .pem emailed around → no audit trail, can't revoke one person.
Better: each engineer generates their OWN key pair and sends only the PUBLIC key;
        admin appends each to ~/.ssh/authorized_keys; leaver → delete their one line.
Best:  enable "Login with Microsoft Entra ID" (AADSSHLoginForLinux) + RBAC roles
       (Virtual Machine Administrator/User Login) → no keys to manage, MFA + Conditional
       Access apply; or use Bastion so no public IP/SSH is exposed.
```

---

## 13.8 Benefits

- **No passwords** — eliminates brute-force and reuse risk
- **Individual accountability** — per-person public keys, revoke one at a time
- **Flexible** — bring your own key, reuse via an Azure key resource
- **Recoverable** — reset the public key if a private key is lost

---

## 13.9 Common Use Cases

- Securing Linux VM access for individuals and teams
- Shared jump/utility hosts with per-person keys
- CI/CD agents authenticating to Linux hosts
- Migrating from password to key-based (or Entra ID) login

---

## 13.10 Exam Q&A

**Q: Public vs private key?**
> Public key goes on the VM (`authorized_keys`), shareable; private key stays on your machine and proves identity. Only the matching private key authenticates.

**Q: Lost the private key — regain access?**
> Reset password → Reset SSH public key (or `az vm user update`); VM must be running.

**Q: Command to generate a key pair?**
> `ssh-keygen` (e.g., `-t rsa -b 4096` or `-t ed25519`).

**Q: Give a teammate access without sharing a private key?**
> Add their public key to `authorized_keys`, or enable Entra ID login with the VM User/Administrator Login role.

---

## 13.11 Summary

Key auth uses a **private key (yours, secret)** and a **public key (on the VM in `~/.ssh/authorized_keys`)**, removing passwords. Create with **`ssh-keygen`**, paste the **public key** (Use existing public key) or let Azure generate a pair (private `.pem` downloads **once**). Fix lost keys with **Reset SSH public key**. Protect keys (**`chmod 400`**, passphrase), give each person their own key or use **Entra ID login/Bastion**, and debug with **`ssh -vvv`**.

[↑ Back to top](#-table-of-contents)

---
---

# 14. 💽 Azure VM Disks & Adding Data Disks
> 🔴 FULL
> 📚 Course lectures: 24 (VM Disks), 25 (Adding data disks)

---

## 14.1 What Are VM Disks?

A VM needs storage for its **OS**, your **application data**, and **scratch** space — and each has different needs for durability, speed, and cost. Azure **Managed Disks** let you separate these and pick the right tier for each.

Think of a VM's storage like a **laptop**: the built-in SSD with the operating system (OS disk), an external drive you plug in for your files (data disk), and a scratchpad whiteboard you wipe at the end of the day (temporary disk). Never keep anything important on the whiteboard.

> 💡 **If you know AWS:** Managed Disks ≈ **EBS volumes**; OS disk = root volume; data disk = extra EBS; **Temporary disk ≈ instance store** (ephemeral). SKUs map: Ultra ≈ io2 Block Express, Premium SSD ≈ gp3/io1, Standard SSD ≈ gp2, Standard HDD ≈ st1/sc1.

---

## 14.2 Three Kinds of Disk (Flow Diagram)

```
┌──────────────── VIRTUAL MACHINE ────────────────┐
│ ① OS DISK      C:\ or /       ← always; durable  │
│ ② DATA DISK(s) E:\ or /dev/sdc ← optional; durable; count depends on SIZE │
│ ③ TEMP DISK    D:\ or /mnt     ← FAST, free, ⚠️ WIPED on deallocate/resize-move/redeploy │
└──────────────────────────────────────────────────┘
```

| Disk | Persistent? | Typical contents | Billed? |
|---|---|---|---|
| **OS disk** | ✅ | System files | Yes (by tier) |
| **Data disk** | ✅ | Databases, app data, logs | Yes (by tier) |
| **Temporary disk** | ❌ | Page/swap, caches, scratch | Included in VM price |

---

## 14.3 Disk Types (Performance Tiers)

| Type | Best for | Notes |
|---|---|---|
| **Ultra Disk** | Top-tier DBs, sub-ms latency | Config IOPS/throughput independently; limited regions; not OS disk |
| **Premium SSD v2** | Production DBs | Capacity/IOPS/throughput set separately; data disk only |
| **Premium SSD** | Production | Needs "s" size; perf tied to size tier (P10, P20, P30…) |
| **Standard SSD** | Web/light apps, dev/test | Cheaper, consistent |
| **Standard HDD** | Backup, infrequent | Cheapest, highest latency |

Always use **Managed Disks** (unmanaged VHDs are legacy). You're billed for the **provisioned tier**, not data used. Performance = **min(disk limit, VM-size limit)**. Host caching per disk: **None** (write-heavy logs), **ReadOnly** (data), **ReadWrite** (OS default). Disks can be **expanded, never shrunk**.

---

## 14.4 UI Steps — Add a Data Disk

```
📍 VM → Settings → "Disks" → "+ Create and attach a new disk":
   LUN=0 · name=win-vm-01-data-01 · Storage type=Standard SSD · Size=64 GiB
   · Host caching=Read-only · Delete with VM=☐ → Save
📍 RESULT: disk attached but RAW — the OS can't use it until you format it.
```

**CLI:**
```bash
az vm disk attach -g lab-rg --vm-name win-vm-01 --name win-vm-01-data-01 \
  --new --size-gb 64 --sku StandardSSD_LRS
```

**Initialise — Windows:** Disk Management → Initialize Disk (GPT) → New Simple Volume → NTFS → drive letter.
**Initialise — Linux:**
```bash
lsblk                                            # find the new disk (e.g., sdc)
sudo parted /dev/sdc --script mklabel gpt mkpart xfspart ext4 0% 100%
sudo mkfs.ext4 /dev/sdc1
sudo mkdir /datadrive && sudo mount /dev/sdc1 /datadrive
UUID=$(sudo blkid -s UUID -o value /dev/sdc1)
echo "UUID=$UUID /datadrive ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
```
⭐ Use the **UUID** and **`nofail`** in `/etc/fstab` so a changed device name or detached disk never blocks boot.

---

## 14.5 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Managed Disks** | The disk resources themselves |
| **Snapshots / Azure Backup** | Point-in-time copies and scheduled backups |
| **Disk Encryption Set / Key Vault** | Customer-managed encryption keys |
| **VM sizes** | Determine max data disks and disk IOPS cap |
| **Azure Monitor** | Disk IOPS, throughput, queue depth metrics |

---

## 14.6 Real-World Scenario — SQL Server Disk Layout

```
r5-class VM:
   OS disk:     P10 Premium SSD 128 GiB  (Windows only — no DB files)
   Data disk 1: P30 Premium SSD 1 TiB    (.mdf data)   caching: ReadOnly
   Data disk 2: P20 Premium SSD 512 GiB  (.ldf logs)   caching: None
   Temp disk D: tempdb (fast, recreated on startup)

Why: data and logs on SEPARATE disks → no I/O contention, independent sizing.
Rebuild the VM → detach + re-attach the data disks → data survives.
Hard lesson: a backup folder on D: (temp disk) was WIPED after a resize-move.
```

---

## 14.7 Benefits

- **Durable storage** — OS and data survive stop/restart
- **Right-tier per disk** — Ultra/Premium/Standard to match need
- **Separation** — isolate OS, data, and logs for performance
- **Flexible** — attach/detach, expand, snapshot
- **Secure** — encrypted at rest by default

---

## 14.8 Common Use Cases

- Database data/log volumes
- Application and file storage separate from the OS
- Expanding storage without rebuilding the VM
- Moving a data disk to a replacement VM

---

## 14.9 Exam Q&A

**Q: Three disk types on a VM?**
> OS disk and data disk(s) (durable managed disks) + a temporary disk (local, non-persistent scratch).

**Q: What happens to temp-disk data on deallocate/redeploy?**
> It's lost — the temp disk is on the host, not durable storage.

**Q: Added a data disk but it's not in Explorer — why?**
> New disks are RAW; initialise, partition, and format them in the OS.

**Q: Can you shrink a managed disk?**
> No — only expand (then extend the partition).

**Q: What determines how many data disks you can attach?**
> The VM size.

---

## 14.10 Summary

VMs use **OS disk** (persistent), **data disks** (persistent, count limited by VM size), and a **temporary disk** (non-persistent — wiped on deallocate/redeploy). Choose SKUs by need — **Ultra / Premium SSD v2 / Premium SSD / Standard SSD / Standard HDD** — remembering **billing is by provisioned tier**, **performance is capped by the lower of disk and VM limits**, and **Premium SSD needs an "s" size**. Add via **VM → Disks → Create and attach**, then **initialise/format** (Disk Management on Windows; `parted/mkfs/mount` + UUID-based **fstab with `nofail`** on Linux). Disks expand but never shrink.

[↑ Back to top](#-table-of-contents)

---
---

# 15. ⏸️ Stopping a VM & Data Disk Snapshots
> 🟠 MEDIUM
> 📚 Course lectures: 26 (What happens when we stop the machine), 27 (Data Disks Snapshot)

---

## 15.1 What This Covers

Two everyday questions: **"If I stop my VM, what do I lose and still pay for?"** and **"How do I take a quick backup copy before a risky change?"**

Think of deallocating a VM like **checking out of a hotel but leaving your luggage in storage**. You stop paying for the room (compute), but the storage locker (disks) still costs a little, and anything left on the nightstand (temp disk) is thrown out. A **snapshot** is like photographing the room's contents before you rearrange them — if it goes wrong, you can put everything back exactly.

> 💡 **If you know AWS:** Stopping an EC2 instance ≈ **deallocating** an Azure VM. The trap: **"Stopped" ≠ "Stopped (deallocated)"** — an OS-level shutdown still bills compute. Managed-disk snapshots ≈ **EBS snapshots** (Azure's can be **full** or **incremental**).

---

## 15.2 Power States & Billing (Flow Diagram)

```
 Deallocated ──Start──► Running ──Stop (portal/CLI)──► Stopped (DEALLOCATED)
                          │                             compute released, billing stops
                          │ shutdown INSIDE the OS
                          ▼
                     Stopped (OS only)  ⚠️ STILL ALLOCATED, STILL BILLING COMPUTE
```

| State | Compute billed? | Disks billed? | Dynamic public IP | Temp disk |
|---|---|---|---|---|
| Running | ✅ | ✅ | Kept | Kept |
| Stopped (OS only) | ✅ **Yes** | ✅ | Kept | Kept |
| **Stopped (deallocated)** | ❌ | ✅ | **Released** (static kept) | **Wiped** |
| Deleted | ❌ | Only leftover disks | Released | Gone |

⭐ Exam trap: **`az vm stop` does NOT deallocate** — use **`az vm deallocate`**. The portal Stop button deallocates.

---

## 15.3 What Deallocation Does

```
✅ Releases compute (CPU/RAM host slot) → compute billing stops
✅ OS + data disks remain (still bill for storage); NIC/VNet/NSG/STATIC IP remain
❌ Dynamic public IP released → new address on next start
❌ Temp disk wiped; RAM contents lost (apps stop — nothing is "paused")
❌ On start the VM may land on different hardware; capacity isn't guaranteed (rare allocation error)
```

---

## 15.4 UI/CLI — Stop, Observe, Start

```
📍 VM → Overview → "Stop" → Yes → "Stopped (deallocated)"
   (dynamic public IP disappears; disks still listed; compute cost stops accumulating)
📍 "Start" → note whether the public IP changed → reconnect → temp disk reset
```
```bash
az vm deallocate -g lab-rg -n win-vm-01   # stop compute billing
az vm start      -g lab-rg -n win-vm-01
az vm stop       -g lab-rg -n win-vm-01   # ⚠️ stops but does NOT deallocate
```

---

## 15.5 Snapshots — What & Why (Flow Diagram)

```
LIVE DATA DISK ──snapshot──► SNAPSHOT (read-only, frozen at that moment)
     │ (bad change later)              │ restore
     ▼                                 ▼
corrupted/deleted data   ◄── create a NEW disk from it → attach / swap into VM
Use for: backup before risky changes · copy to another region/subscription · clone · recover
```

| Type | Stores | Cost | Notes |
|---|---|---|---|
| **Full** | A complete copy | Full disk size | Independent |
| **Incremental** (recommended) | Only changed blocks | Changes only | Each still restores independently |

Snapshots are their own resource (survive VM/disk deletion), can be taken while the VM **runs** (crash-consistent), and live in the **same region** as the source disk (copyable elsewhere). For application-consistent backups, quiesce the app or use **Azure Backup**.

---

## 15.6 UI Steps — Create & Restore a Snapshot

```
📍 Search "Snapshots" → "+ Create": name · Region (same as disk) ·
   Snapshot type=Incremental · Source=Disk → pick win-vm-01-data-01 → Create
   (shortcut: VM → Disks → click the disk → "Create snapshot")

── Restore ──
📍 Snapshots → open the snapshot → "+ Create disk" → new managed disk
📍 VM → Disks → "Attach existing disks" → pick the restored disk → Save
   Windows: Disk Management → Online (no reformat). Linux: mount it.
   OS disk: deallocate VM → VM → Disks → "Swap OS disk" → pick restored OS disk → Start.
```
```bash
DISK_ID=$(az disk show -g lab-rg -n win-vm-01-data-01 --query id -o tsv)
az snapshot create -g lab-rg -n data-snap1 --source "$DISK_ID" --incremental true --sku Standard_LRS
```

---

## 15.7 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Managed Disks** | Source and target of snapshots |
| **Azure Backup** | Scheduled, policy-based backups (vs manual snapshots) |
| **Auto-shutdown (DevTest Labs / Automation)** | Deallocate on a schedule to save cost |
| **Static Public IP** | Keep the address stable across deallocate |
| **Cost Management** | See compute cost stop when deallocated |

---

## 15.8 Real-World Scenario — Snapshot Before a Risky Upgrade

```
Before (Fri PM): quiesce the DB (app-consistent) → snapshot OS + data disks
   (incremental), tag Purpose=pre-upgrade.
Upgrade fails: deallocate VM → "Swap OS disk" with a disk from the OS snapshot →
   attach a disk from the data snapshot → Start → back to pre-upgrade state in minutes.
Upgrade succeeds: keep snapshots a week, then DELETE them (they cost money).

Lesson: snapshots are the quick safety net for planned changes; Azure Backup is
the scheduled, policy-driven net for everyday protection.
```

---

## 15.9 Benefits

- **Cost control** — deallocate to stop compute billing
- **Fast safety net** — snapshot before risky changes, restore in minutes
- **Cheap copies** — incremental snapshots store only changes
- **Portable** — copy snapshots across regions/subscriptions
- **Crash-consistent on live VMs** — no shutdown needed for a basic snapshot

---

## 15.10 Common Use Cases

- Stopping idle VMs overnight/weekends to save money
- Taking a rollback point before patching or upgrades
- Cloning a disk for testing
- Recovering from corruption or accidental deletion
- Seeding a replacement VM from an existing disk

---

## 15.11 Exam Q&A

**Q: "Stopped" vs "Stopped (deallocated)"?**
> "Stopped" = OS shut down but still allocated and billing compute. "Stopped (deallocated)" = compute released, compute billing stops (disks still bill).

**Q: Which CLI command stops compute billing?**
> `az vm deallocate` (`az vm stop` leaves it allocated).

**Q: What happens to a dynamic public IP on deallocate?**
> Released; a different one is usually assigned on next start. A static IP is kept.

**Q: Full vs incremental snapshots — which is cheaper?**
> Incremental — it stores only changed blocks.

**Q: Can you snapshot a disk attached to a running VM?**
> Yes (crash-consistent). For app-consistent copies, quiesce the app or use Azure Backup.

---

## 15.12 Summary

Only **"Stopped (deallocated)"** stops compute billing — an OS shutdown or `az vm stop` keeps billing. Deallocation releases compute, **wipes the temp disk**, **releases a dynamic public IP**, and may move the VM, but **OS/data disks persist and keep billing**. **Snapshots** are read-only point-in-time copies (**full** or cheaper **incremental**), made via **Snapshots → Create** or `az snapshot create`, crash-consistent on running VMs. Restore by **creating a disk from the snapshot** and attaching it (or **swapping the OS disk** while deallocated); delete old snapshots to avoid hidden cost. Use **Azure Backup** for scheduled protection.

[↑ Back to top](#-table-of-contents)

---
---

# 16. 🔐 Disk Encryption — SSE, Key Vault, Disk Encryption Sets & ADE
> 🟠 MEDIUM
> 📚 Course lectures: 28 (Server-Side Encryption), 29 (Key Vault service), 30 (Disk Encryption Sets), 31 (Azure Disk Encryption)

---

## 16.1 What Is Disk Encryption?

Disk encryption scrambles the data on a VM's disks so that if the underlying storage is ever stolen, copied, or improperly accessed, the bytes are useless without the key. Azure offers several layers, from automatic to fully customer-controlled.

Think of it like a **safe inside a locked building**. Azure already locks the building automatically (Server-Side Encryption with platform keys — free, always on). If you want to control the key to the safe yourself, you hold it in a vault you own (customer-managed keys via a Disk Encryption Set). And if you want to lock each individual document inside the safe too, you encrypt the OS/data volumes within the VM's operating system (Azure Disk Encryption).

> 💡 **If you know AWS:** SSE with platform keys ≈ **default EBS encryption**; customer-managed keys via a Disk Encryption Set ≈ **EBS encryption with a KMS CMK**; Azure Disk Encryption (BitLocker/dm-crypt) ≈ **OS-level LUKS/BitLocker**. Azure **Key Vault** plays the role of **AWS KMS** for key storage and access control.

---

## 16.2 The Layers (Flow Diagram)

```
① SSE with PLATFORM-managed keys  → ON by default, free, Azure owns the key
          │ want to own the key?
          ▼
② SSE with CUSTOMER-managed keys  → your key in Key Vault, linked via a
          │                          DISK ENCRYPTION SET
          │ want OS-level encryption inside the VM too?
          ▼
③ AZURE DISK ENCRYPTION (ADE)     → BitLocker (Windows) / dm-crypt (Linux),
                                     keys/secrets stored in Key Vault

(①/② protect the managed disk at the storage layer; ③ encrypts within the OS.
 You can combine ② + ③ — this is "double encryption at rest.")
```

| Layer | Who holds the key | Scope | Cost |
|---|---|---|---|
| **SSE + platform key** | Microsoft | Managed disk at rest | Free, automatic |
| **SSE + customer key (DES)** | You (Key Vault) | Managed disk at rest | Key Vault cost |
| **Azure Disk Encryption (ADE)** | You (Key Vault) | Inside the OS volume | Key Vault cost |

---

## 16.3 Key Pieces

- **Azure Key Vault** — the secure store for your encryption **keys** (and secrets/certs). Needs **soft delete** and **purge protection** enabled to be used for disk encryption.
- **Disk Encryption Set (DES)** — the resource that links your managed disks to a **customer-managed key** in Key Vault. You attach disks/VMs to a DES to encrypt them with your key.
- **Azure Disk Encryption (ADE)** — uses the VM's own OS tools (**BitLocker**/**dm-crypt**) to encrypt the OS and/or data volumes; the keys live in Key Vault.

---

## 16.4 UI Steps — Customer-Managed Key via a Disk Encryption Set

```
📍 1. Create a Key Vault (enable Soft delete + Purge protection) → add a Key.
📍 2. Search "Disk Encryption Sets" → "+ Create" → pick the Key Vault + Key → Create.
📍 3. Grant the DES access to the Key Vault (the portal offers to do this automatically).
📍 4. New disk/VM: on the Disks tab → "Key management" → "Customer-managed key" → select the DES.
      Existing disk: VM must be deallocated → Disk → "Encryption" → choose the DES.
📍 RESULT: the managed disk is encrypted at rest with YOUR key.
```

**Enable ADE (CLI):**
```bash
az vm encryption enable -g lab-rg -n win-vm-01 \
  --disk-encryption-keyvault myKeyVault --volume-type All
az vm encryption show -g lab-rg -n win-vm-01   # check status
```

---

## 16.5 Integration with Other Azure Services

| Service | Role in disk encryption |
|---|---|
| **Azure Key Vault** | Stores the customer-managed keys and ADE secrets |
| **Disk Encryption Set** | Links managed disks to a Key Vault key |
| **Managed Disks** | The resources being encrypted |
| **Microsoft Entra ID + RBAC** | Controls who can access the key/vault |
| **Azure Policy** | Enforce "all disks must be encrypted with a CMK" |
| **Azure Backup** | Can back up and restore encrypted VMs |

---

## 16.6 Real-World Scenario — Regulated Data on a VM

```
A healthcare app must prove patient data on VM disks is encrypted with keys the
company controls (not just Microsoft's), and that keys can be revoked.

Step 1: Create Key Vault "health-kv" (soft delete + purge protection), add an RSA key.
Step 2: Create a Disk Encryption Set pointing at that key.
Step 3: Deploy VMs with OS + data disks encrypted via the DES (customer-managed key).
Step 4: (Extra assurance) Enable ADE for OS-level encryption → double encryption at rest.
Step 5: Azure Policy denies any disk not using the approved DES.
Audit: if a key is ever compromised, rotating/revoking it in Key Vault renders the
       disks unreadable — satisfying the "revocable keys" compliance requirement.
```

---

## 16.7 Benefits

- **Always-on baseline** — SSE with platform keys protects every managed disk for free
- **Key ownership** — customer-managed keys put you in control (rotation, revocation, audit)
- **Defense in depth** — combine storage-layer (DES) and OS-layer (ADE) encryption
- **Compliance** — meets regulatory requirements for encryption and key control
- **Centralized keys** — Key Vault manages and audits all key access

---

## 16.8 Common Use Cases

- Meeting regulatory requirements (health, finance, government)
- Customer-managed-key mandates where Microsoft must not hold the key
- Protecting sensitive OS/data volumes with OS-level encryption
- Enforcing encryption org-wide via Azure Policy

---

## 16.9 Exam Q&A

**Q: Is data on an Azure managed disk encrypted by default, and who holds the key?**
> Yes — Server-Side Encryption (SSE) is on automatically for every managed disk, at no extra cost, using **platform-managed keys** that Microsoft owns and rotates. You don't configure anything to get this baseline protection. You only need to act if your organization requires *control* of the key — then you switch to customer-managed keys.

**Q: What is a Disk Encryption Set and why would you use one?**
> A Disk Encryption Set (DES) is the resource that links your managed disks to a **customer-managed key stored in Key Vault**, so the disk is encrypted at rest with *your* key instead of Microsoft's. You use it when compliance requires that your organization — not the cloud provider — can rotate and revoke the encryption key, which also gives you an audit trail of key access in Key Vault.

**Q: How is Azure Disk Encryption (ADE) different from SSE?**
> SSE encrypts the managed disk at the **storage/platform layer** and is transparent to the OS. ADE encrypts **inside the guest OS** using BitLocker (Windows) or dm-crypt (Linux), with keys in Key Vault. SSE is automatic; ADE is something you enable on the VM. They can be combined, giving "double encryption at rest" — one layer at the storage level and one inside the OS.

**Q: What two settings must a Key Vault have to be used for disk encryption?**
> **Soft delete** and **purge protection** must be enabled. These prevent an encryption key from being permanently deleted (accidentally or maliciously) while disks still depend on it — losing the key would make the encrypted data unrecoverable, so Azure requires these safeguards before a vault can back disk encryption.

**Q: If a customer-managed key is revoked, what happens to the disks using it?**
> They become unreadable — the data is still there but can't be decrypted without the key. This is exactly the point of customer-managed keys: revoking the key in Key Vault is an effective "kill switch" for the data, which is why regulated industries require it over platform-managed keys.

---

## 16.10 Summary

Azure encrypts every managed disk at rest automatically with **SSE + platform keys** (free). For key control, use **customer-managed keys** stored in **Key Vault** and linked to disks through a **Disk Encryption Set**; for OS-level encryption inside the VM, use **Azure Disk Encryption (BitLocker/dm-crypt)** — and combine both for double encryption at rest. Key Vault needs **soft delete + purge protection**, and Azure Policy can enforce encryption org-wide. Customer-managed keys give you rotation, revocation, and audit — the capabilities regulated workloads require.

[↑ Back to top](#-table-of-contents)

---
---

# 17. 📜 Custom Script Extensions (Windows & Linux)
> 🟠 MEDIUM
> 📚 Course lectures: 32 (Custom Script Extensions), 33 (Windows CSE), 34 (Linux CSE)

---

## 17.1 What Is a Custom Script Extension?

A **Custom Script Extension (CSE)** downloads and runs a script **inside a VM automatically** — at deployment or on demand — so you can install software and configure the machine without ever logging in.

Think of it like leaving a **to-do note for a new employee on their first day**. Instead of standing over their shoulder (RDP/SSH) to show them how to set up their desk, you leave written instructions (the script) and they follow them automatically when they arrive (VM boots). Every new hire (VM) sets up their desk identically.

> 💡 **If you know AWS:** A CSE is like **EC2 User Data run via the SSM Run Command / custom-script document** — a way to bootstrap or re-run configuration on an instance. User Data runs once at first boot; a CSE can run at deploy *and* be re-invoked later, and it's a formal VM extension (visible and manageable in the portal/CLI).

---

## 17.2 How It Works (Flow Diagram)

```
You define a CSE on the VM (portal / CLI / ARM / Bicep):
   ├── settings:        where the script lives (a URL / Storage blob / GitHub raw)
   └── protectedSettings: the command to run + any secrets (encrypted)
          ▼
VM Agent (on every Azure VM) downloads the script → runs it as SYSTEM/root
          ▼
Software installed / config applied  →  extension status: Succeeded / Failed
          ▼
Status + output visible in the portal (VM → Extensions) and via CLI
```

CSE is idempotent-ish: re-running the same extension re-runs the script, so write scripts that can safely run more than once.

---

## 17.3 UI / CLI Steps

```
📍 Portal: VM → "Extensions + applications" → "+ Add" → "Custom Script Extension"
   → provide the script file (or a URL) + arguments → Review + create
```

**Windows (install IIS) — CLI:**
```bash
az vm extension set -g lab-rg --vm-name win-vm-01 \
  --name CustomScriptExtension --publisher Microsoft.Compute \
  --settings '{"commandToExecute":"powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server"}'
```

**Linux (install Nginx) — CLI:**
```bash
az vm extension set -g lab-rg --vm-name linux-vm-01 \
  --name customScript --publisher Microsoft.Azure.Extensions \
  --settings '{"commandToExecute":"apt-get update && apt-get install -y nginx"}'
```

**Where logs go:** Windows — `C:\WindowsAzure\Logs\Plugins\...`; Linux — `/var/log/azure/custom-script/`. Check status with `az vm extension list -g lab-rg --vm-name <vm> -o table`.

---

## 17.4 Integration with Other Azure Services

| Service | Role with CSE |
|---|---|
| **VM Agent** | Runs the extension inside the VM |
| **Azure Storage (blob)** | Common place to host script files securely |
| **Key Vault** | Supply secrets to the script (via protected settings) |
| **VM Scale Sets** | Apply the same CSE to every instance automatically |
| **ARM / Bicep** | Declare the CSE as part of infrastructure as code |
| **Managed Identity** | Let the script authenticate to Azure with no stored creds |

---

## 17.5 Real-World Scenario — Golden Config for a Web Tier

```
A team deploys a VM Scale Set of web servers that must all be configured identically.

Instead of a "golden image" rebuilt monthly, they use a CSE referenced in Bicep:
   1. Script stored in a private Storage blob (pulled via the VM's Managed Identity).
   2. On every new instance the CSE runs:
         - installs Nginx + the app runtime
         - pulls the latest app build from Storage
         - writes config from Key Vault (DB connection string, API keys)
         - registers the instance with monitoring
   3. Scale out adds 10 VMs at 2 AM → each self-configures in ~90 seconds, no human.

Result: consistent, repeatable, credential-free configuration at any scale.
```

---

## 17.6 Benefits

- **No manual login** — configure VMs without RDP/SSH
- **Consistency** — every VM configured identically
- **Scale-friendly** — applies automatically to each Scale Set instance
- **IaC-native** — declare it in ARM/Bicep/Terraform
- **Auditable** — extension status and logs are visible

---

## 17.7 Common Use Cases

- Installing web servers, agents, or runtimes at deployment
- Pulling and starting an application build on first boot
- Domain-join, monitoring-agent install, security hardening
- Re-applying configuration across a fleet on demand

---

## 17.8 Exam Q&A

**Q: What does a Custom Script Extension do, and when does it run?**
> It downloads a script you specify and runs it inside the VM — typically at deployment, but you can also invoke it later on a running VM. It's executed by the VM Agent (present on every Azure VM) as a privileged account, which is how you can install software and apply configuration without ever logging into the machine.

**Q: Why put the "commandToExecute" and secrets in protectedSettings rather than settings?**
> `protectedSettings` is encrypted, so anything sensitive — commands containing credentials, tokens, or connection strings — isn't exposed in plain text in the VM's extension metadata. Non-sensitive values like the script's download URL can go in the regular `settings`, which is not encrypted.

**Q: How does a CSE compare to a golden/custom image for configuring VMs?**
> A custom image bakes software in ahead of time (fast boot, but you must rebuild the image to update it). A CSE configures the VM *at deploy time* from a script, so updates are as simple as editing the script — no image rebuild — at the cost of a slightly longer first boot. Many teams combine them: a lean base image plus a CSE for the frequently-changing parts.

**Q: Where do you check whether a Custom Script Extension succeeded?**
> In the portal under the VM's **Extensions + applications** blade (it shows Succeeded/Failed and provisioning details), or via `az vm extension list`. For the actual script output and errors, read the extension logs on the VM — `C:\WindowsAzure\Logs\Plugins\...` on Windows or `/var/log/azure/custom-script/` on Linux.

**Q: Your CSE needs to download a script from a private Storage account — how do you authenticate without storing keys?**
> Give the VM a **Managed Identity** with access to the Storage account and have the script authenticate with it, so no storage key or credential is embedded in the extension. This keeps the bootstrap process credential-free, which is the recommended pattern.

---

## 17.9 Summary

A Custom Script Extension runs a script **inside a VM automatically** (at deploy or on demand) so you can install software and configure the machine with no manual login — via the portal, CLI, or ARM/Bicep. Put sensitive commands/secrets in encrypted **protectedSettings**, host scripts in **Storage** (pulled via a **Managed Identity**), and read status in **VM → Extensions** with logs on the VM. It's the key to consistent, repeatable, scale-friendly VM configuration, and pairs naturally with **Scale Sets** and **infrastructure as code**.

[↑ Back to top](#-table-of-contents)

---
---

# 18. 🐧 Linux Cloud-init & Boot Diagnostics
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 35 (Linux VMs — Cloud-init), 36 (VM — Boot Diagnostics)

---

## 18.1 What Are Cloud-init & Boot Diagnostics?

**Cloud-init** is the industry-standard way to configure a **Linux** VM on its very first boot — install packages, write files, create users — before anyone logs in. **Boot diagnostics** captures a **screenshot and serial log** of the VM as it boots, so you can see what's happening when a VM won't come up.

Think of cloud-init like a **welcome kit left in a new apartment** that sets itself up the moment you move in (updates, software, a config file) — it's the Linux-native cousin of a Custom Script Extension. And think of boot diagnostics like a **dashcam for the VM's startup**: if the VM "crashes on the way in," you replay the footage (serial log + screenshot) to see exactly where it went wrong, even when you can't connect.

> 💡 **If you know AWS:** Cloud-init is the **exact same tool** used on EC2 (passed as User Data), so your existing cloud-init YAML works on Azure Linux VMs. Boot diagnostics ≈ EC2 **"Get system log" / instance screenshot** — a view into boot-time failures without needing network access.

---

## 18.2 Cloud-init (Flow Diagram)

```
Create Linux VM → supply a cloud-init file as "Custom data" (Advanced tab)
        ▼
First boot: cloud-init runs ONCE, as root, before login is available
        ├── package upgrades / installs
        ├── writes config files
        ├── creates users / adds SSH keys
        └── runs commands
        ▼
VM is ready, pre-configured, with no manual SSH
```

**Example cloud-init (`cloud-init.txt`):**
```yaml
#cloud-config
package_upgrade: true
packages:
  - nginx
write_files:
  - path: /var/www/html/index.html
    content: "<h1>Configured by cloud-init</h1>"
runcmd:
  - systemctl enable --now nginx
```
```bash
az vm create -g lab-rg -n linux-vm-03 --image Ubuntu2204 \
  --admin-username azureuser --generate-ssh-keys \
  --custom-data cloud-init.txt
```

**Cloud-init vs Custom Script Extension:** cloud-init runs **once, at first boot, Linux-only**, natively; a CSE is an Azure **extension** (Windows *or* Linux) that can also run **later on demand** and reports status in the portal. Use cloud-init for initial Linux provisioning; use a CSE when you need Windows support or to re-run config on existing VMs.

---

## 18.3 Boot Diagnostics (Flow Diagram)

```
VM boots → boot diagnostics captures:
   ├── a SCREENSHOT of the console (e.g., a kernel panic, login prompt, blue screen)
   └── the SERIAL LOG (boot-time kernel/OS messages)
        ▼
Stored in a managed storage account (or one you choose)
        ▼
View in: VM → Help → "Boot diagnostics"  →  diagnose "VM won't start / no network"
Also enables the SERIAL CONSOLE (interactive text access with no network)
```

```
📍 Enable: VM create → Monitoring tab → Boot diagnostics = On (managed storage account)
📍 Use:    VM → Help → "Boot diagnostics" → Screenshot / Serial log
           VM → Help → "Serial console" (needs boot diagnostics enabled)
```

---

## 18.4 Integration with Other Azure Services

| Service | Role |
|---|---|
| **cloud-init** | First-boot provisioning for Linux VMs |
| **Custom Script Extension** | Alternative/complement (Windows + Linux, re-runnable) |
| **Storage Account** | Holds boot-diagnostics screenshots and serial logs |
| **Serial Console** | Network-free interactive access (depends on boot diagnostics) |
| **VM Scale Sets** | cloud-init applies to every new Linux instance |
| **Azure Monitor** | Ongoing metrics (vs boot-time diagnostics) |

---

## 18.5 Real-World Scenario — Diagnosing a Boot Failure

```
A Linux VM stops responding after an fstab edit; SSH times out.

Without boot diagnostics: you'd be blind — is it the network, the OS, or a crash?
With boot diagnostics:
   1. VM → Help → Boot diagnostics → Serial log shows:
      "Failed to mount /datadrive ... dropping to emergency shell."
   2. Root cause: a bad /etc/fstab entry (missing the nofail option) blocked boot.
   3. VM → Help → Serial console → log in to the emergency shell → fix fstab → reboot.

Lesson: boot diagnostics turns an invisible "VM is dead" into a precise, fixable
root cause — and the serial console lets you repair it with no network at all.
```

(For new Linux VMs, cloud-init would have set up `/datadrive` correctly in the first place.)

---

## 18.6 Benefits

- **Zero-touch Linux setup** — cloud-init configures VMs before first login
- **Portable** — reuse the same cloud-init YAML from AWS/other clouds
- **Boot-time visibility** — screenshots + serial logs for VMs that won't start
- **Network-free repair** — serial console fixes OS problems with no connectivity
- **Scale-friendly** — cloud-init applies to every Scale Set instance

---

## 18.7 Common Use Cases

- Bootstrapping Linux VMs (packages, users, config) at first boot
- Standardizing fleets of Linux instances
- Troubleshooting VMs stuck at boot (bad fstab, kernel panic, failed service)
- Recovering a VM with no network via the serial console

---

## 18.8 Exam Q&A

**Q: What is cloud-init and on which VMs does it run?**
> Cloud-init is the standard first-boot configuration tool for **Linux** VMs — you pass a YAML `#cloud-config` as the VM's custom data and it installs packages, writes files, creates users, and runs commands once, as root, before login is available. It doesn't apply to Windows VMs (use a Custom Script Extension there), and because it's the same tool used on AWS and other clouds, existing cloud-init files are portable to Azure.

**Q: When would you use a Custom Script Extension instead of cloud-init?**
> When you need Windows support (cloud-init is Linux-only) or when you need to **re-run** configuration on an already-running VM, since cloud-init runs only once at first boot. A CSE is a managed Azure extension that reports Succeeded/Failed status in the portal and can be invoked again later, so it's better for ongoing/ad-hoc config and cross-platform fleets.

**Q: What does boot diagnostics capture, and why is it useful?**
> It captures a **console screenshot** and the **serial/boot log** of the VM as it starts, stored in a storage account. It's the primary way to diagnose a VM that won't boot or has no network — you can see a kernel panic, a stuck service, or a Windows blue screen directly, instead of guessing why you can't connect.

**Q: What does boot diagnostics enable beyond viewing logs?**
> It enables the **Serial Console** — an interactive text session with the VM's OS that works even when networking is broken. This lets you log into an emergency shell to fix things like a bad `/etc/fstab`, a misconfigured network, or a failed service, which you couldn't reach over SSH/RDP.

**Q: A Linux VM boots to an emergency shell after an fstab change — how do you recover?**
> Use boot diagnostics to confirm the cause in the serial log, then open the **Serial Console** (no network needed), log in, correct the `/etc/fstab` entry (adding `nofail` so a bad mount can't block boot), and reboot. This whole flow depends on boot diagnostics being enabled beforehand.

---

## 18.9 Summary

**Cloud-init** configures Linux VMs on first boot via a portable `#cloud-config` YAML passed as custom data — the Linux-native way to install packages, write files, and run commands with no manual login (use a **Custom Script Extension** for Windows or re-runnable config). **Boot diagnostics** captures a **screenshot + serial log** so you can diagnose VMs that won't start, and it enables the **Serial Console** for network-free repair. Together they make Linux VM provisioning and startup troubleshooting fast and hands-off.

[↑ Back to top](#-table-of-contents)

---
---

# 19. 🛡️ Availability Sets
> 🟠 MEDIUM
> 📚 Course lectures: 37 (Availability Sets), 38 (Review), 39 (Lab)

---

## 19.1 What Is an Availability Set?

A single VM is a single point of failure. An **Availability Set** tells Azure to spread a group of VMs across **separate physical hardware** within one datacenter and to **never reboot them all at once** during maintenance — so the group survives hardware failures and planned updates.

Think of it like **seating a group across different tables and different waiters' sections in a restaurant**. If one table's leg breaks (a rack fails) or one waiter goes on break (maintenance reboot), only the people at that table are affected — everyone else keeps eating. Put everyone at one table and a single mishap ruins the whole party.

> 💡 **If you know AWS:** The closest AWS idea is a **Spread Placement Group** (spreading instances across racks). For datacenter-level resilience, the stronger AWS equivalent is deploying across multiple **Availability Zones** — which in Azure is the separate (and stronger) feature **Availability Zones** (next topic). Availability Sets protect *inside one datacenter*; Zones protect *across datacenters*.

---

## 19.2 Fault Domains & Update Domains (Flow Diagram)

```
AVAILABILITY SET "web-avset" (3 fault domains, 5 update domains)
 ┌──────────────── ONE DATACENTER ────────────────┐
 │ FAULT DOMAIN 0   FAULT DOMAIN 1   FAULT DOMAIN 2 │  separate power + network
 │  VM1 (UD0)        VM2 (UD1)         VM3 (UD2)     │
 │  VM4 (UD3) ← wraps around                         │
 └───────────────────────────────────────────────────┘
FAULT DOMAIN (FD) = hardware sharing power/network → protects UNPLANNED failures
UPDATE DOMAIN (UD) = VMs Azure reboots TOGETHER → only ONE UD rebooted at a time
Rack B dies? only VM2 affected. Maintenance? UD0 reboots first; others stay up.
```

| Concept | Protects against | Default | Max |
|---|---|---|---|
| **Fault Domain** | Hardware failure (rack/power/switch) | 2 | 3 (most regions) |
| **Update Domain** | Planned host maintenance/reboots | 5 | 20 |

---

## 19.3 Key Rules

```
✅ 99.95% VM SLA (needs 2+ VMs in the set) · the set itself is FREE
✅ Chosen at VM CREATION time — generally can't drop an existing VM into a set later
✅ Use "Aligned" managed disks so disks spread across fault domains too
✅ A VM is in an Availability Set OR an Availability Zone — NOT both
✅ One set per TIER (web-avset, app-avset, db-avset) — never mix tiers
✅ Pair with a Load Balancer — the set spreads VMs; the LB reroutes around a failed one
```

---

## 19.4 UI / CLI Steps

```
📍 Search "Availability sets" → "+ Create": name=web-avset, Fault domains=2(or 3),
   Update domains=5, Use managed disks=Aligned → Create
📍 VM create → Basics → Availability options = "Availability set" → web-avset
   (deploy 2+ VMs into the same set)
📍 Verify: open the Availability Set → Overview shows each VM's FD and UD number
```
```bash
az vm availability-set create -g lab-rg -n web-avset \
  --platform-fault-domain-count 3 --platform-update-domain-count 5
az vm create -g lab-rg -n web-vm-01 --image Win2022Datacenter \
  --availability-set web-avset --admin-username azureadmin
```

---

## 19.5 Availability Set vs Zone vs Single VM

| | Single VM | Availability Set | Availability Zone |
|---|---|---|---|
| Protects against | Nothing | Rack/host failure + maintenance | **Whole datacenter** failure |
| Scope | One host | One datacenter | Separate datacenters in a region |
| SLA | 99.9% (Premium SSD) | **99.95%** | **99.99%** |
| Extra cost | — | Free | Free (cross-zone transfer billed) |
| Region support | All | All | Zone-enabled regions only |

Rule of thumb: use **Zones** where the region supports them; use **Sets** where it doesn't or for older designs.

---

## 19.6 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Load Balancer / App Gateway** | Routes traffic only to healthy VMs in the set |
| **Managed Disks (Aligned)** | Disks spread across fault domains |
| **VM Scale Sets** | Modern alternative that manages spreading + scaling |
| **Azure Monitor** | Detect unhealthy instances |
| **Availability Zones** | The stronger (datacenter-level) alternative |

---

## 19.7 Real-World Scenario — Two Web Servers, No Outage

```
Before: two "redundant" web VMs landed on the SAME rack → rack failure took both down.
After: web-avset (FD0/FD1) with web-vm-01 (Rack A) + web-vm-02 (Rack B), behind a
       Load Balancer; db-avset for the database tier.
   - A rack failure takes down at most one web server; the LB's health probe removes
     it and users never notice.
   - Monthly host patching reboots one update domain at a time → at least one web
     server always serving.
   - The set costs nothing extra, and the VMs now qualify for the 99.95% SLA.
```

---

## 19.8 Benefits

- **Survives hardware failures** — fault domains isolate rack/power/network faults
- **Survives maintenance** — update domains reboot in staggered groups
- **Higher SLA** — 99.95% with 2+ VMs
- **Free** — you pay only for the VMs
- **Simple** — placement is handled by Azure once you join the set

---

## 19.9 Common Use Cases

- Multi-VM web/app tiers needing resilience within a region
- Regions that don't support Availability Zones
- Classic (pre-Zone) high-availability designs
- Any tier where a single host failure must not cause an outage

---

## 19.10 Exam Q&A

**Q: What problem does an Availability Set solve, and how?**
> It removes the single-point-of-failure risk of running VMs on one host by spreading them across **Fault Domains** (separate power/network hardware — protecting against unplanned failures) and **Update Domains** (staggered reboot groups — protecting against planned maintenance). With two or more VMs in the set you also get a 99.95% SLA, because Azure guarantees not all of them go down together.

**Q: Fault Domain vs Update Domain?**
> A Fault Domain is a group of physical hardware sharing the same power and network, so it protects against **unplanned** hardware failures. An Update Domain is a logical group of VMs that Azure reboots **together** during planned maintenance, one group at a time — so it protects against planned downtime. A VM is placed into one of each.

**Q: Default and maximum fault/update domain counts?**
> Fault domains default to 2 (maximum 3 in most regions); update domains default to 5 (maximum 20). You set these when you create the set, and they determine how finely Azure spreads your VMs across hardware and reboot groups.

**Q: Can you add an existing VM to an Availability Set?**
> Generally no — the set is chosen at VM creation time, so moving a VM into one typically means recreating or redeploying it. This is a common exam trap, and it's why you decide on availability options up front.

**Q: Does an Availability Set route traffic around a failed VM by itself?**
> No — it only controls *placement*. You still need a Load Balancer (or Application Gateway) with health probes in front of the set to actually stop sending traffic to a failed VM; the set and the load balancer work together to deliver true high availability.

---

## 19.11 Summary

An Availability Set spreads VMs across **Fault Domains** (separate racks — unplanned failures) and **Update Domains** (staggered reboots — planned maintenance), giving a **99.95% SLA** for 2+ VMs at no extra cost. Remember: defaults/maximums (FD 2/3, UD 5/20), selection at **creation time**, same region only, one set per tier, **Aligned** managed disks, and pair with a **Load Balancer** to reroute traffic. It protects within a single datacenter; for datacenter-level protection (99.99%), use **Availability Zones** (next).

[↑ Back to top](#-table-of-contents)

---
---

# 20. 🌐 Availability Zones
> 🟠 MEDIUM
> 📚 Course lectures: 40 (Availability Zones), 41 (Lab), 42 (Review)

---

## 20.1 What Are Availability Zones?

**Availability Zones (AZs)** are **physically separate datacenters within one region**, each with independent power, cooling, and networking. Spreading VMs across zones protects your application from an **entire datacenter** failing — not just a rack.

Think of it like **storing copies of an important document in three different buildings across a city** rather than three rooms of the same building. If one building floods (a datacenter outage — power, fire, flood), the copies in the other buildings are untouched. An Availability Set keeps copies in different rooms of one building; Zones keep them in different buildings.

> 💡 **If you know AWS:** Azure Availability Zones are the direct equivalent of **AWS Availability Zones**. Deploying across zones for datacenter-level resilience is identical in concept. The main Azure quirk: subnets are **not** zone-bound (unlike AWS) — you choose a resource's zone at creation, not the subnet's.

---

## 20.2 How Zones Protect You (Flow Diagram)

```
REGION: Central India
 ┌── Availability Zone 1 ──┐  ┌── Availability Zone 2 ──┐  ┌── Availability Zone 3 ──┐
 │  web-vm-01              │  │  web-vm-02              │  │  web-vm-03              │
 │  (own power/cool/net)   │  │  (own power/cool/net)   │  │  (own power/cool/net)   │
 └─────────────────────────┘  └─────────────────────────┘  └─────────────────────────┘
          └──────────── Standard Load Balancer (zone-redundant) ────────────┘
Zone 1 datacenter fails entirely → VM02 + VM03 keep serving → no outage.
```

```
✅ 99.99% VM SLA when VMs are spread across 2+ zones
✅ Zones are only in ZONE-ENABLED regions (not every region has them)
✅ A VM is in a Zone OR an Availability Set — not both
✅ Pair with a ZONE-REDUNDANT Standard Load Balancer / App Gateway
✅ Use zone-redundant services where possible (ZRS storage, zone-redundant SQL, etc.)
⚠️ Cross-zone data transfer within a region is billed
```

---

## 20.3 Zonal vs Zone-Redundant

```
ZONAL        → a resource pinned to ONE specific zone (e.g., a VM in Zone 1)
ZONE-REDUNDANT → a service automatically spread across zones by Azure
                 (e.g., ZRS storage, a zone-redundant Standard Load Balancer)
Design: put zonal VMs in different zones behind a zone-redundant load balancer.
```

---

## 20.4 UI / CLI Steps

```
📍 VM create → Basics → Availability options = "Availability zone" → choose Zone 1
   Deploy additional VMs choosing Zone 2 and Zone 3.
📍 Front them with a Standard (zone-redundant) Load Balancer.
```
```bash
az vm create -g lab-rg -n web-vm-01 --image Ubuntu2204 --zone 1 \
  --admin-username azureuser --generate-ssh-keys
az vm create -g lab-rg -n web-vm-02 --image Ubuntu2204 --zone 2 ...
az vm create -g lab-rg -n web-vm-03 --image Ubuntu2204 --zone 3 ...
```

---

## 20.5 Integration with Other Azure Services

| Service | Role with zones |
|---|---|
| **Standard Load Balancer / App Gateway** | Zone-redundant front end routing across zones |
| **Managed Disks** | A zonal VM's disk lives in the same zone |
| **ZRS Storage / zone-redundant SQL** | Data layer that survives a zone failure |
| **VM Scale Sets** | Can spread instances across zones automatically |
| **Public IP (Standard, zone-redundant)** | Highly available entry point |

---

## 20.6 Real-World Scenario — 99.99% Web Tier

```
A public API must survive a full datacenter outage in its region.
Design:
   web-vm-01 → Zone 1 · web-vm-02 → Zone 2 · web-vm-03 → Zone 3
   Standard (zone-redundant) Load Balancer in front
   Database: zone-redundant Azure SQL · Storage: ZRS
Event: Zone 2's datacenter loses power.
   → The LB's health probe drops VM02; VM01 + VM03 (other zones) keep serving.
   → Zone-redundant SQL + ZRS keep data available.
   → Users see no downtime; the app meets its 99.99% SLA.
Cost note: cross-zone traffic is billed, accepted for the resilience gained.
```

---

## 20.7 Benefits

- **Datacenter-level resilience** — survive a full AZ outage
- **Highest VM SLA** — 99.99% across 2+ zones
- **No extra per-zone fee** — you pay only for VMs (cross-zone transfer billed)
- **Composable** — pair with zone-redundant LB, storage, and database
- **Simple** — pick a zone at creation

---

## 20.8 Common Use Cases

- Mission-critical public applications needing the highest SLA
- Workloads with regulatory/availability requirements
- Zone-redundant data tiers (ZRS, zone-redundant SQL)
- Any design where losing one datacenter must not cause an outage

---

## 20.9 Exam Q&A

**Q: What is an Availability Zone and what does it protect against?**
> An Availability Zone is a physically separate datacenter within a region, with its own independent power, cooling, and networking. Spreading resources across zones protects against an **entire datacenter** failing — a stronger guarantee than an Availability Set, which only spreads across racks inside one datacenter.

**Q: Availability Set vs Availability Zone — SLA and scope?**
> An Availability Set spreads VMs across fault/update domains *within one datacenter* for a 99.95% SLA. Availability Zones spread VMs across *separate datacenters* in the region for a 99.99% SLA. Use Zones where the region supports them (stronger protection); use Sets where it doesn't.

**Q: Can a VM be in both an Availability Set and an Availability Zone?**
> No — you choose one or the other for a given VM. They are mutually exclusive placement strategies, so you decide at creation whether datacenter-level (Zone) or in-datacenter (Set) protection is appropriate.

**Q: What's the difference between a zonal and a zone-redundant resource?**
> A zonal resource is pinned to one specific zone (e.g., a VM you place in Zone 1), whereas a zone-redundant resource is automatically spread across zones by Azure (e.g., ZRS storage or a zone-redundant Standard Load Balancer). A good HA design uses zonal VMs in different zones behind a zone-redundant front end.

**Q: What should front a zone-spread set of VMs, and why?**
> A Standard (zone-redundant) Load Balancer or Application Gateway, because it stays available even if one zone fails and routes traffic only to healthy VMs in the surviving zones. Without a zone-redundant front end, the entry point itself could become the single point of failure.

---

## 20.10 Summary

Availability Zones are physically separate datacenters within a region; spreading VMs across **2+ zones** gives a **99.99% SLA** and survives a full datacenter outage — stronger than an Availability Set (99.95%, within one datacenter). Zones exist only in zone-enabled regions, a VM is in a Zone **or** a Set (not both), and you should front zonal VMs with a **zone-redundant Standard Load Balancer** and use **zone-redundant data services** (ZRS, zone-redundant SQL). Cross-zone transfer is billed — a fair trade for the resilience.

[↑ Back to top](#-table-of-contents)

---
---

# 21. 📈 Virtual Machine Scale Sets
> 🔴 FULL
> 📚 Course lectures: 43 (VMSS), 44 (Lab), 45 (Scale out), 46 (Scaling process), 47 (Scale in), 48 (Flexible Orchestration)

---

## 21.1 What Is a VM Scale Set?

A **Virtual Machine Scale Set (VMSS)** manages a **group of identical VMs that automatically grows and shrinks** with demand — adding instances when load rises and removing them when it falls — all behind a single configuration and (usually) a load balancer.

Think of a Scale Set like a **call center that hires temps automatically when the phones light up and sends them home when it quiets down**. You don't manually onboard each agent (VM); you define the role (the model) and the rules ("add agents when calls per agent exceed X"), and the center staffs itself. This is **horizontal scaling** — more servers, no downtime — versus resizing one VM (vertical, with downtime).

> 💡 **If you know AWS:** A VMSS is the direct equivalent of an **EC2 Auto Scaling Group**. Same concepts: a launch template/model, min/max/desired, scaling policies on metrics, and health-based instance replacement. Azure's **Flexible orchestration** mode is like mixing instance types/capabilities in one group.

---

## 21.2 How It Works (Flow Diagram)

```
                       Load Balancer / App Gateway
                                 │
                 ┌───────────────┼───────────────┐
          VMSS Instance 1   Instance 2   ... Instance N   (all from ONE model/image)
                                 │
            Autoscale rules watch a metric (e.g., avg CPU):
               CPU > 70% for 5 min → ADD instances (scale OUT)
               CPU < 30% for 10 min → REMOVE instances (scale IN)
               Health probe fails → instance replaced automatically (self-healing)
```

| Setting | Meaning |
|---|---|
| **Instance model / image** | The blueprint every instance is built from |
| **Min / Max / Default (desired)** | Floor, ceiling, and baseline instance counts |
| **Scaling rules** | Metric + threshold + action (scale out/in) |
| **Upgrade policy** | How updates roll out (Manual / Automatic / Rolling) |

---

## 21.3 Scaling Options

```
MANUAL              → you set the instance count
METRIC-BASED (auto) → scale on CPU, memory, queue length, custom metrics
SCHEDULED           → scale on a known pattern (e.g., out at 9 AM, in at 8 PM)
```
Scale sets integrate with **Custom Script Extension / cloud-init** so each new instance self-configures, and with **ASGs/NSGs** so security rules apply automatically as instances come and go.

---

## 21.4 Orchestration Modes

| Mode | Description | When |
|---|---|---|
| **Uniform** | All instances identical, built from the set's model | Classic autoscaling of identical VMs |
| **Flexible** | Mix VM sizes/types, add standalone VMs to the set, more control | Mixed fleets, spreading across zones, finer control (modern default) |

---

## 21.5 UI / CLI Steps

```
📍 Search "Virtual machine scale sets" → "+ Create":
   name, image, size, Orchestration=Flexible, Instance count=2,
   Scaling → custom autoscale (CPU > 70% → +1; CPU < 30% → −1),
   Load balancing → attach a Load Balancer/App Gateway,
   Zones → select 1,2,3 for zone spread → Create
📍 Observe: Scale Set → "Scaling" to tune rules; "Instances" to watch count change
```
```bash
az vmss create -g lab-rg -n web-vmss --image Ubuntu2204 \
  --instance-count 2 --admin-username azureuser --generate-ssh-keys \
  --orchestration-mode Flexible --zones 1 2 3
az monitor autoscale create -g lab-rg --resource web-vmss --resource-type Microsoft.Compute/virtualMachineScaleSets \
  --name web-autoscale --min-count 2 --max-count 10 --count 2
```

---

## 21.6 Integration with Other Azure Services

| Service | Role with VMSS |
|---|---|
| **Load Balancer / App Gateway** | Distributes traffic across instances; backend auto-updates |
| **Azure Monitor / autoscale** | Metrics drive scale-out/scale-in |
| **Custom Script Extension / cloud-init** | Each new instance self-configures |
| **Availability Zones** | Spread instances across zones for resilience |
| **Managed Identity / Key Vault** | Credential-free secret access on every instance |
| **ASG / NSG** | Security rules follow instances automatically |

---

## 21.7 Real-World Scenario — Ride-Share Backend Peaks

```
Pattern: dramatic morning (7–9 AM) and evening (5–8 PM) traffic spikes.
Config:
   VMSS (Flexible, zones 1–3) behind an App Gateway, min 4 / max 40.
   cloud-init on each instance installs the app + pulls config from Key Vault.
   Metric rule: ALB requests/instance > 500 → scale out; < 500 for 15 min → scale in.
   Scheduled rule: set desired=15 at 7 AM, 20 at 5 PM, 4 at night.
Morning rush: requests climb → autoscale adds 10 VMs → each self-configures in ~90s
   → traffic handled with no manual action.
Instance crashes: health probe fails → VMSS replaces it from the model in ~3 min.
Result: right-sized capacity around the clock, cost tracking demand, self-healing.
```

---

## 21.8 Benefits

- **Elastic & automatic** — scales out/in with demand, no manual intervention
- **No downtime scaling** — horizontal, unlike resizing one VM
- **Self-healing** — unhealthy instances are replaced automatically
- **Consistent** — every instance built from one model + bootstrap script
- **Resilient** — spread across zones; integrates with load balancers
- **Cost-efficient** — scale in (and use Spot) to minimize idle capacity

---

## 21.9 Common Use Cases

- Web/API tiers with variable or spiky traffic
- Worker fleets scaling on queue depth
- Batch/compute that scales out to finish faster, then scales in
- Stateless microservices needing elastic capacity
- Large identical fleets needing consistent configuration

---

## 21.10 Exam Q&A

**Q: What is a VM Scale Set and how does it differ from resizing a VM?**
> A VMSS manages a group of identical VMs that automatically scale **out and in** with demand — horizontal scaling, with no downtime, because capacity is added by launching more instances rather than changing one machine. Resizing a single VM is **vertical** scaling and requires a restart; a Scale Set is the right tool when you need elastic capacity without interrupting service.

**Q: What are the scaling options for a VMSS?**
> Manual (you set the count), metric-based autoscale (scale on CPU, memory, queue length, or custom metrics), and scheduled (scale on a known time pattern). Teams often combine scheduled scaling for predictable peaks with metric-based scaling for unexpected spikes.

**Q: Uniform vs Flexible orchestration?**
> Uniform builds every instance from the set's single model and is the classic mode for identical VMs. Flexible lets you mix sizes/types, add standalone VMs, and spread across zones with finer control — it's the more capable, modern default for mixed or zone-spread fleets.

**Q: How does a Scale Set keep the fleet healthy?**
> Through health probes: when an instance fails its probe, the Scale Set automatically removes and replaces it from the model, so a crashed VM self-heals in minutes without human intervention. This is why you attach a load balancer with proper health checks.

**Q: How do new instances get configured as the set scales out?**
> Each new instance is built from the set's image/model and runs its bootstrap — cloud-init or a Custom Script Extension — to install software and pull config (often from Key Vault via a Managed Identity). That's how a scale-out of 10 VMs at 2 AM self-configures with no human involved.

---

## 21.11 Summary

A Virtual Machine Scale Set manages a fleet of identical VMs that **autoscale** with demand (manual, metric-based, or scheduled), self-heal via health probes, and sit behind a load balancer. Each instance is built from one model and self-configures with **cloud-init / CSE** (secrets from **Key Vault** via **Managed Identity**), and **Flexible** orchestration adds zone-spread and mixed-type flexibility. It's **horizontal, no-downtime scaling** — the elastic alternative to resizing one VM — and the equivalent of an AWS Auto Scaling Group.

[↑ Back to top](#-table-of-contents)

---
---

# 22. 🌐 Azure Web Apps (App Service)
> 🔴 FULL
> 📚 Course lectures: 49 (Intro to Web Apps), 50–52 (Labs: create, change, add an app)

---

## 22.1 What Is Azure App Service / Web Apps?

**Azure App Service (Web Apps)** is a **Platform-as-a-Service (PaaS)** for hosting web apps, REST APIs, and backends — you deploy your **code (or container)** and Azure runs the OS, web server, patching, load balancing, and scaling for you.

Think of it like **renting a fully furnished, staffed office** instead of an empty building. You just bring your laptop (your code) and start working; the landlord handles the power, cleaning, security, and maintenance (OS, patching, scaling). You give up control of the building's plumbing in exchange for never having to fix it.

> 💡 **If you know AWS:** App Service is Azure's equivalent of **Elastic Beanstalk / AWS App Runner** — managed app hosting where you deploy code and the platform handles servers. The **App Service Plan** is like the underlying compute tier (instance size/count) that your app(s) run on.

---

## 22.2 Core Concepts (Flow Diagram)

```
APP SERVICE PLAN  (the compute: size/tier + instance count — you pay for this)
   ├── WEB APP 1  (your deployed code/container)
   ├── WEB APP 2  (multiple apps can share one plan)
   └── ...
Deploy via: Git / GitHub Actions / Azure DevOps / ZIP / container image / VS Code
Azure handles: OS, web server, patching, load balancing, scaling, free SSL, custom domains
```

| Concept | What it is |
|---|---|
| **App Service Plan** | The underlying compute (tier + size + instance count) that apps run on |
| **Web App** | Your actual deployed application |
| **Pricing tiers** | Free/Shared (testing) → Basic → Standard → Premium → Isolated |
| **Runtime stacks** | .NET, Node.js, Python, Java, PHP, or a custom container |

Higher tiers unlock **autoscale, deployment slots, VNet integration, custom domains, and more instances**.

---

## 22.3 Key Features

- **Built-in load balancing & scaling** — scale up (bigger tier) or out (more instances)
- **Free managed TLS/SSL** and **custom domains**
- **"Easy Auth"** — add Microsoft Entra ID / social login with no code
- **Deployment slots** (Standard+) — staging + swap for zero-downtime releases (next topic)
- **Continuous deployment** from GitHub/Azure DevOps
- **App settings / connection strings** — configuration injected as environment variables (can reference **Key Vault**)

---

## 22.4 UI / CLI Steps — Create and Deploy a Web App

```
📍 Search "App Services" → "+ Create":
   RG, name (becomes <name>.azurewebsites.net), Publish=Code (or Container),
   Runtime stack (e.g., Node 20 LTS), OS, Region,
   App Service Plan → create new → pick a tier (Standard+ for slots/autoscale) → Create
📍 Deploy: App Service → "Deployment Center" → GitHub / Azure Repos / ZIP → connect
📍 Config: App Service → "Environment variables / Configuration" → add app settings
           (reference secrets as @Microsoft.KeyVault(SecretUri=...))
```
```bash
az appservice plan create -g lab-rg -n myplan --sku S1 --is-linux
az webapp create -g lab-rg -p myplan -n myapp123 --runtime "NODE:20-lts"
az webapp deploy -g lab-rg -n myapp123 --src-path app.zip --type zip
```

---

## 22.5 Integration with Other Azure Services

| Service | Role with App Service |
|---|---|
| **App Service Plan** | The compute the app runs on |
| **Azure SQL / Cosmos DB** | Managed data tier for the app |
| **Key Vault + Managed Identity** | Secrets referenced at runtime, no hardcoding |
| **Application Insights** | App performance monitoring and tracing |
| **Azure DNS / App Service domains** | Custom domain names |
| **VNet integration / Private Endpoint** | Reach private resources / be reached privately |
| **Deployment slots** | Zero-downtime blue/green releases |
| **CDN / Front Door** | Global acceleration and caching |

---

## 22.6 Real-World Scenario — SaaS API Backend

```
A startup runs a Python API for its mobile app.
Setup:
   App Service Plan (Standard S2, Linux) hosting the API Web App.
   Config: DB connection string + API keys referenced from Key Vault (Managed Identity).
   CI/CD: GitHub Actions deploys on every merge to main.
   Monitoring: Application Insights (request rate, latency, failures, distributed traces).
   Custom domain api.myapp.io + free managed TLS certificate.
Benefits realized:
   - No servers to patch — Azure manages the OS and web server.
   - Scales out automatically under load (autoscale — next topic).
   - Zero-downtime releases via a staging slot + swap.
   - Secrets never in code; monitoring shows exactly which endpoint is slow.
```

---

## 22.7 Benefits

- **No infrastructure management** — deploy code, Azure runs everything
- **Fast to ship** — from code to live URL in minutes
- **Built-in scale & load balancing** — up and out
- **Secure by default** — free TLS, Easy Auth, Managed Identity, Key Vault references
- **CI/CD-ready** — native GitHub/Azure DevOps integration
- **Zero-downtime deploys** — slots and swap (Standard+)

---

## 22.8 Common Use Cases

- Web applications and REST/GraphQL APIs
- Mobile and SPA backends
- Line-of-business internal apps
- Containerized web workloads without managing Kubernetes
- Rapid MVPs and startup products

---

## 22.9 Exam Q&A

**Q: What is Azure App Service and how does it differ from a VM?**
> App Service is a **PaaS** for hosting web apps and APIs — you deploy code or a container and Azure manages the OS, web server, patching, load balancing, and scaling. A VM is **IaaS** where you manage the OS and everything above it. Choose App Service when you want to ship an app without running servers; choose a VM when you need OS-level control or special software.

**Q: What is an App Service Plan and how does it relate to Web Apps?**
> The App Service Plan is the **underlying compute** — the tier (Free/Basic/Standard/Premium/Isolated), VM size, and instance count — that one or more Web Apps run on. You pay for the plan, and multiple apps can share one plan, so sizing the plan correctly (and choosing a tier that supports slots/autoscale) is a key decision.

**Q: How do you avoid hardcoding secrets in an App Service app?**
> Store secrets in **Key Vault** and reference them in the app's configuration with a Key Vault reference (`@Microsoft.KeyVault(SecretUri=...)`), authenticated by the app's **Managed Identity**. At runtime App Service fetches the real value, so the app code just reads a normal setting and no secret ever lives in code or config files.

**Q: What does "scale up" vs "scale out" mean in App Service?**
> Scale **up** moves to a bigger/more powerful plan tier (more CPU/RAM per instance); scale **out** adds more instances of the same tier (and higher tiers allow autoscale). You scale up for heavier per-request work and out for more concurrent traffic.

**Q: Which tier do you need for deployment slots and autoscale?**
> Standard tier or higher. Free/Shared/Basic tiers don't support deployment slots or autoscale, so if you need zero-downtime blue/green releases or automatic scaling, you must choose at least Standard.

---

## 22.10 Summary

Azure App Service (Web Apps) is **PaaS** for hosting web apps, APIs, and containers — you deploy code and Azure manages the OS, web server, patching, load balancing, and scaling. Apps run on an **App Service Plan** (tier + size + instances), with built-in **TLS, custom domains, Easy Auth, Key Vault-referenced secrets (via Managed Identity), Application Insights, and CI/CD**. Scale **up** (bigger tier) or **out** (more instances), and use **Standard+** for **deployment slots** and **autoscale** (next topic). It's the fastest way to run a web app on Azure without servers.

[↑ Back to top](#-table-of-contents)

---
---

# 23. 🔁 Web App Deployment Slots & Autoscaling
> 🟠 MEDIUM
> 📚 Course lectures: 53 (Deployment Slots), 54 (Lab), 55 (Autoscaling for Web Apps)

---

## 23.1 What Are Slots & Autoscaling?

**Deployment slots** are live, separate copies of your Web App (e.g., "staging") that you can deploy to, test, and then **swap** into production with near-zero downtime. **Autoscaling** automatically adds or removes App Service instances based on demand.

Think of a slot swap like a **theatre revolving stage**. The next scene (new version) is fully built and rehearsed on the hidden half of the stage (staging slot) while the audience watches the current scene (production). When ready, the stage spins — the new scene is instantly live, and if it flops, you spin it right back. Autoscaling is like the theatre **adding or removing seats automatically** as the crowd grows or thins.

> 💡 **If you know AWS:** Slot swaps are Azure's built-in **blue/green deployment** (like swapping Elastic Beanstalk environments or ALB target groups). App Service autoscale ≈ an **Auto Scaling policy** for the app tier. Percentage traffic routing between slots gives you a simple **canary** release.

---

## 23.2 Deployment Slots — Swap (Flow Diagram)

```
PRODUCTION slot (v1, live) ── staging slot (v2, tested on its own URL)
        │ 1. deploy v2 to staging · 2. warm up + test myapp-staging.azurewebsites.net
        ▼
   SWAP → v2 instantly becomes production (warm-up avoids downtime)
          v1 moves to staging (instant rollback: swap back)
Also: route a % of production traffic to staging = CANARY release.
```

```
✅ Slots require Standard tier or higher
✅ Swaps are near-instant and warmed up → zero/near-zero downtime
✅ Swap back = instant rollback
✅ Some settings are "slot-specific" (sticky); others swap with the app
```

---

## 23.3 Autoscaling (Flow Diagram)

```
Autoscale rules on the App Service Plan:
   CPU > 70% (or requests/queue/custom) → scale OUT (add instances)
   CPU < 30% for N minutes            → scale IN (remove instances)
   + Scheduled profiles (e.g., more instances during business hours)
Min / Max / Default instance counts bound the scaling.
```

---

## 23.4 UI / CLI Steps

```
── Slots ──
📍 App Service → "Deployment slots" → "+ Add Slot" → "staging"
   → deploy v2 to staging → test via its URL → "Swap" (source=staging, target=production)
   → canary: set "Traffic %" on the staging slot (e.g., 10) to route 10% of live traffic

── Autoscale ──
📍 App Service Plan → "Scale out (App Service plan)" → "Custom autoscale"
   → rule: Metric=CPU Percentage, >70% → +1; <30% → −1; Min 2 / Max 10
```
```bash
az webapp deployment slot create -g lab-rg -n myapp123 --slot staging
az webapp deployment slot swap   -g lab-rg -n myapp123 --slot staging --target-slot production
az webapp traffic-routing set     -g lab-rg -n myapp123 --distribution staging=10   # canary
```

---

## 23.5 Integration with Other Azure Services

| Service | Role |
|---|---|
| **App Service Plan** | Hosts the slots; autoscale operates on it |
| **Azure Monitor / Application Insights** | Metrics that drive autoscale; watch canary health |
| **CI/CD (GitHub/Azure DevOps)** | Deploy to staging, run tests, then swap |
| **Azure DNS / Front Door** | Route traffic to the app; global distribution |
| **Key Vault** | Slot-specific vs shared secrets via app settings |

---

## 23.6 Real-World Scenario — Zero-Downtime Release + Peak Scaling

```
Release flow:
   CI/CD deploys v2 to the "staging" slot → automated smoke tests run on its URL.
   Route 10% of production traffic to staging (canary) → monitor errors/latency in App Insights.
   Healthy → full swap → v2 is live with no downtime. Problem → swap back instantly.

Scaling:
   Autoscale: min 2 / max 10 instances, scale out at CPU > 70%, scale in at < 30%.
   Scheduled profile adds 2 baseline instances during business hours.
Result: safe, reversible releases + capacity that tracks demand, no manual effort.
```

---

## 23.7 Benefits

- **Zero-downtime deployments** — warm-up swap, no outage
- **Instant rollback** — swap back to the previous version
- **Canary releases** — percentage traffic routing to staging
- **Elastic capacity** — autoscale up/down with demand
- **Safe testing** — validate on a real, isolated slot before going live

---

## 23.8 Common Use Cases

- Blue/green and canary web releases
- Pre-production validation on a staging slot
- Scaling web tiers for peak traffic (sales, launches)
- Cost control by scaling in during quiet periods

---

## 23.9 Exam Q&A

**Q: What is a deployment slot and how does a swap achieve zero downtime?**
> A deployment slot is a separate, live instance of your Web App (like "staging") with its own URL, where you deploy and test a new version without touching production. The **swap** exchanges the staging and production slots after warming up the new version, so traffic moves to the already-running new code near-instantly — and if something's wrong you swap back for an immediate rollback.

**Q: How do you do a canary release with App Service?**
> Deploy the new version to a staging slot, then use **traffic routing** to send a small percentage (e.g., 10%) of production traffic to that slot while monitoring errors and latency in Application Insights. If it's healthy you increase the percentage and finally swap; if not, you set the percentage back to 0 — limiting the blast radius to a small set of users.

**Q: Which App Service tier is required for deployment slots and autoscale?**
> Standard tier or higher. Free, Shared, and Basic tiers don't support slots or autoscale, so any zero-downtime release or automatic scaling strategy requires at least Standard.

**Q: What's the difference between "scale up" and "autoscale (scale out)" for a web app?**
> Scale up changes the plan to a more powerful tier (more CPU/RAM per instance) and is a manual sizing decision. Autoscale (scale out) automatically adds or removes instances of the current tier based on metrics or a schedule, so capacity tracks demand without manual action.

**Q: Why might some settings not move during a slot swap?**
> Certain settings are marked **slot-specific (sticky)** — such as connection strings or settings that must differ between staging and production — so they stay with the slot rather than swapping. This lets staging point at a test database while production points at the real one, even as the app code swaps.

---

## 23.10 Summary

**Deployment slots** (Standard+ tier) give Web Apps **zero-downtime blue/green releases**: deploy to a staging slot, test on its own URL, optionally route a **percentage of traffic (canary)**, then **swap** — with **swap-back as instant rollback**. **Autoscaling** adds/removes App Service instances on metrics or a schedule (min/max/default). Together they deliver safe, reversible deployments and capacity that tracks demand — the PaaS equivalent of blue/green plus an auto-scaling group.

[↑ Back to top](#-table-of-contents)

---
---

# 24. 🐳 Container-Based Applications & Docker on a VM
> 🟠 MEDIUM
> 📚 Course lectures: 56 (Container-based applications), 57 (Docker on a VM), 58 (Containerize an application)

---

## 24.1 What Are Containers?

A **container** packages an application together with everything it needs to run — code, runtime, libraries, and config — into one portable unit that runs the same on any machine with a container engine (**Docker**). A VM virtualizes hardware; a container virtualizes the **operating system**, so it's far lighter and faster to start.

Think of a container like a **shipping container**. Whatever you pack inside (your app and its dependencies) travels sealed and unchanged whether it's on a truck, a ship, or a train (your laptop, a VM, Azure). The ports and cranes (Docker, Azure) don't care what's inside — they move the standard box the same way. A **VM** by contrast is like shipping the whole truck.

> 💡 **If you know AWS:** Docker is identical everywhere — this is container knowledge, not Azure-specific. Running Docker on an Azure VM mirrors running it on an EC2 instance. The image you build here is later pushed to **ACR** (Azure's **ECR**) and run on **ACI/AKS/Container Apps**.

---

## 24.2 Containers vs VMs (Flow Diagram)

```
VIRTUAL MACHINE                         CONTAINER
┌──────────────┐                        ┌──────────────┐
│   App A       │                        │   App A       │
│   Guest OS    │ ← full OS per app      │   (shares host OS kernel)
│   Virtual HW  │                        └──────┬───────┘
└──────┬───────┘                         ┌──────┴───────┐  Docker Engine
   Hypervisor                            │   Host OS     │
   Physical server                       │   Server      │
Heavy (GBs, minutes to boot)             Light (MBs, seconds to start)
```

| | VM | Container |
|---|---|---|
| Virtualizes | Hardware | The OS |
| Size / boot | GBs / minutes | MBs / seconds |
| Isolation | Strong (own OS) | Process-level (shared kernel) |
| Density | Few per host | Many per host |
| Best for | Full OS control, legacy | Microservices, portable apps |

---

## 24.3 Core Docker Concepts

| Term | Meaning |
|---|---|
| **Dockerfile** | A text recipe describing how to build an image |
| **Image** | A read-only, built template (app + dependencies) |
| **Container** | A running instance of an image |
| **Registry** | Where images are stored/shared (ACR, Docker Hub) |

**Minimal Dockerfile (Node app):**
```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --production
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]
```

---

## 24.4 UI / CLI Steps — Docker on an Azure VM

```
📍 Create a Linux VM (Ubuntu) → SSH in → install Docker:
   sudo apt update && sudo apt install -y docker.io
   sudo systemctl enable --now docker
📍 Containerize an app:
   docker build -t myapp:v1 .                 # build the image from the Dockerfile
   docker run -d -p 80:3000 myapp:v1          # run it, map host port 80 → container 3000
   docker ps                                   # list running containers
📍 Open NSG port 80 → browse http://<VM public IP> → the app responds
```

Useful: `docker images`, `docker logs <id>`, `docker stop/rm <id>`, `docker exec -it <id> sh`.

---

## 24.5 Integration with Other Azure Services

| Service | Role with containers |
|---|---|
| **Azure Container Registry (ACR)** | Private store for your built images (next topic) |
| **Azure Container Instances (ACI)** | Run a single container without managing a VM |
| **Azure Container Apps / AKS** | Run containers at scale (serverless / Kubernetes) |
| **App Service for Containers** | Deploy a container as a managed web app |
| **Managed Identity** | Credential-free pulls from ACR |
| **Azure Monitor** | Container logs and metrics |

---

## 24.6 Real-World Scenario — From Laptop to Azure

```
A dev builds an app locally, containers it, and runs it the same way everywhere.
   1. Write a Dockerfile → docker build -t voteapp:v1 .
   2. Test locally: docker run -p 8080:80 voteapp:v1 → works on the laptop.
   3. SSH to an Azure VM with Docker → docker run the same image → identical behavior.
   4. Later: push to ACR (next topic) → run on Container Apps/AKS — no "works on my
      machine" surprises, because the container is the same box everywhere.
Result: consistent, portable deployment from dev to production.
```

---

## 24.7 Benefits

- **Portable** — runs identically on any Docker host
- **Lightweight & fast** — seconds to start, high density
- **Consistent** — eliminates "works on my machine" issues
- **Microservice-friendly** — small, independent, scalable units
- **Foundation for Azure container services** — ACR, ACI, Container Apps, AKS

---

## 24.8 Common Use Cases

- Packaging apps for portability across environments
- Microservices architectures
- CI/CD build artifacts (one image promoted through environments)
- Dev/test parity with production
- Modernizing apps before moving to managed container platforms

---

## 24.9 Exam Q&A

**Q: How does a container differ from a VM?**
> A VM virtualizes hardware and runs a full guest OS, so it's large (GBs) and slow to boot (minutes); a container virtualizes the OS and shares the host kernel, so it's small (MBs) and starts in seconds with many per host. Use VMs for full OS control or legacy apps, and containers for portable, lightweight microservices.

**Q: What's the difference between a Docker image and a container?**
> An image is a read-only, built template (app + dependencies) produced from a Dockerfile; a container is a running instance of that image. You build an image once and can run many containers from it — the image is the recipe, the container is the dish.

**Q: Why are containers described as "portable"?**
> Because they bundle the app with its runtime, libraries, and config into one standardized unit, so it runs the same on any machine with a container engine — your laptop, an Azure VM, or a managed service. This removes environment drift and the classic "works on my machine" problem.

**Q: Where do you run containers on Azure after building an image?**
> You push the image to a registry (ACR) and run it on **Azure Container Instances** (single container, no VM), **App Service for Containers** (managed web app), **Azure Container Apps** (serverless containers), or **AKS** (full Kubernetes) — choosing based on scale and control needs.

**Q: What does a Dockerfile do?**
> It's a text recipe listing the steps to build an image — the base image, files to copy, dependencies to install, the port to expose, and the command to run. `docker build` executes it to produce the image, making builds repeatable and version-controllable.

---

## 24.10 Summary

Containers package an app with its dependencies into one portable, lightweight unit that runs identically anywhere via **Docker** — virtualizing the OS (fast, dense) rather than hardware (like a VM). Know the core objects — **Dockerfile → image → container → registry** — and the workflow: `docker build` → `docker run`. Running Docker on an Azure VM proves the concept; in production you push images to **ACR** and run them on **ACI, App Service, Container Apps, or AKS**. Containers are the foundation of Azure's container ecosystem.

[↑ Back to top](#-table-of-contents)

---
---

# 25. 📦 Azure Container Registry (ACR)
> 🟠 MEDIUM
> 📚 Course lectures: 59 (ACR service), 60 (Publishing to ACR)

---

## 25.1 What Is ACR?

**Azure Container Registry (ACR)** is a **private, managed registry** for storing and distributing your container images — the secure warehouse your Azure services pull images from.

Think of ACR like a **private, members-only warehouse for your shipping containers**. Instead of leaving your goods in a public depot (Docker Hub) where anyone can see them, you keep them in a secured warehouse with keycard access (Azure identity), inventory scanning for contraband (vulnerability scanning), and branch warehouses worldwide (geo-replication) so trucks pick up from the nearest one.

> 💡 **If you know AWS:** ACR is the direct equivalent of **Amazon ECR** — a private container registry integrated with the cloud's identity system. Pulling from ACR via a Managed Identity mirrors pulling from ECR via an IAM role.

---

## 25.2 Where ACR Fits (Flow Diagram)

```
Developer / Pipeline builds an image
        │ docker push
        ▼
┌──────────────────────────────┐
│  AZURE CONTAINER REGISTRY     │  myregistry.azurecr.io
│   myapp:v1, myapp:v2, ...      │  (private, secure image storage)
└──────────────┬────────────────┘
               │ docker pull (via Managed Identity — no stored creds)
               ▼
   ACI / AKS / App Service / Container Apps  (run the image)
```

| Tier | Adds |
|---|---|
| **Basic** | Entry-level storage |
| **Standard** | More storage/throughput |
| **Premium** | Geo-replication, private endpoints, content trust, higher limits |

---

## 25.3 Why ACR Over a Public Registry

```
✅ Private — your proprietary images aren't publicly accessible
✅ Azure identity integration — pull via Managed Identity + RBAC, no stored creds
✅ Vulnerability scanning — images checked for known CVEs (Defender)
✅ Geo-replication (Premium) — fast pulls from the nearest region
✅ Content trust / signing — verify image authenticity
```

---

## 25.4 UI / CLI Steps — Create, Push, Pull

```
📍 Search "Container registries" → "+ Create": name=myregistry, SKU=Standard → Create
```
```bash
az acr login --name myregistry                         # authenticate with Azure creds
docker tag myapp:v1 myregistry.azurecr.io/myapp:v1
docker push myregistry.azurecr.io/myapp:v1             # publish

# Let a Web App / ACI / AKS pull it — e.g., attach ACR to AKS:
az aks update -n myAKS -g lab-rg --attach-acr myregistry   # grants AcrPull, no creds stored
az acr repository list --name myregistry -o table
```

---

## 25.5 Integration with Other Azure Services

| Service | Role with ACR |
|---|---|
| **AKS / ACI / App Service / Container Apps** | Pull and run images from ACR |
| **Managed Identity + RBAC (AcrPull)** | Credential-free image pulls |
| **Microsoft Defender for Cloud** | Scans pushed images for vulnerabilities |
| **Azure DevOps / GitHub Actions** | Build and push images in CI/CD |
| **Private Endpoint (Premium)** | Private-network-only registry access |
| **Geo-replication (Premium)** | Nearby pulls for global deployments |

---

## 25.6 Real-World Scenario — Secure Image Supply Chain

```
A multi-service app needs private, scanned image storage with automated CI/CD.
   1. Create ACR "ecommerceacr" (Premium: geo-replication + private endpoint + scanning).
   2. CI pipeline builds each service's image and pushes it, tagged with the build ID.
   3. Defender scans every pushed image for CVEs; alerts on critical findings.
   4. Attach ACR to the AKS cluster (az aks update --attach-acr) → AKS pulls via its
      Managed Identity (AcrPull) — no registry credentials stored anywhere.
   5. Geo-replicate so each region's workloads pull from a nearby copy.
Result: a private, scanned, automated image pipeline from "code pushed" to "running".
```

---

## 25.7 Benefits

- **Private & secure** — your images, your access control
- **Identity-integrated** — Managed Identity + RBAC pulls, no stored secrets
- **Vulnerability scanning** — catch CVEs before deployment
- **Geo-replication** — fast global pulls (Premium)
- **CI/CD-friendly** — native build/push from pipelines

---

## 25.8 Common Use Cases

- Storing proprietary application images privately
- Serving images to AKS/ACI/App Service/Container Apps
- Scanning images for vulnerabilities in the supply chain
- Geo-replicated image distribution for global apps
- CI/CD artifact storage (one image promoted across environments)

---

## 25.9 Exam Q&A

**Q: What is ACR and why use it over Docker Hub?**
> ACR is Azure's **private, managed container registry**. Over a public registry it offers privacy for proprietary images, deep Azure identity integration (pull via Managed Identity + RBAC with no stored credentials), built-in vulnerability scanning, and geo-replication for fast global pulls — all of which matter for secure, production container delivery.

**Q: How does a service like AKS pull images from ACR securely?**
> Via a **Managed Identity** granted the **AcrPull** RBAC role on the registry — commonly set up with a single `az aks update --attach-acr` command. No registry username or password is stored anywhere; it's the standard identity → RBAC pattern used throughout Azure.

**Q: What does the Premium ACR tier add?**
> Geo-replication (replicate images across regions for fast local pulls), private endpoints (private-network-only access), content trust/signing, and higher storage and throughput limits — features aimed at enterprise and globally distributed workloads.

**Q: How do you authenticate to ACR to push an image?**
> Run `az acr login --name <registry>`, which uses your Azure credentials to log Docker into the registry; then `docker tag` the image to `<registry>.azurecr.io/...` and `docker push`. In CI/CD, a service principal or Managed Identity with push permissions is used instead of an interactive login.

**Q: Where does image vulnerability scanning come from with ACR?**
> From Microsoft Defender for Cloud (Defender for Containers), which scans images pushed to ACR for known CVEs and surfaces findings so you can block or remediate vulnerable images before they're deployed.

---

## 25.10 Summary

Azure Container Registry (ACR) is Azure's **private, managed** container image registry — the equivalent of AWS ECR. It's preferred over public registries for privacy, **Managed Identity + RBAC** pulls (no stored credentials), **vulnerability scanning**, and **geo-replication** (Premium). Build and `docker push` images, then let AKS/ACI/App Service/Container Apps pull them — e.g., `az aks update --attach-acr` grants **AcrPull** with no secrets. ACR is the secure middle link: **build → ACR → run**.

[↑ Back to top](#-table-of-contents)

---
---

# 26. 📦 Azure Container Instances & Container Groups
> 🟠 MEDIUM
> 📚 Course lectures: 61 (Azure Container Instances), 65 (Azure Container Group)

---

## 26.1 What Are ACI & Container Groups?

**Azure Container Instances (ACI)** runs a **single container** in the cloud without you provisioning or managing any VM — the fastest, simplest way to run a container. A **Container Group** runs **multiple containers together** on the same host, sharing network and storage (like a Kubernetes pod).

Think of ACI like **calling a ride-share instead of buying a car**. You need to get somewhere (run a container) right now; you don't want to buy, insure, and maintain a vehicle (a VM). You request a ride, it arrives in seconds, you pay only for the trip, and it's gone when you're done. A **Container Group** is a shared ride where a few passengers (containers) travel together in one car.

> 💡 **If you know AWS:** ACI is closest to **AWS Fargate (serverless containers)** — run a container with no servers to manage, billed per second. A Container Group is like a **Fargate task with multiple containers** / a Kubernetes pod — co-located containers sharing a network namespace and volumes.

---

## 26.2 How It Works (Flow Diagram)

```
You specify: image (from ACR/Docker Hub) + CPU/memory + ports + env vars
        ▼
ACI provisions an isolated container instance in seconds (no VM to manage)
   ├── gets a public IP / DNS label (optional)
   ├── runs until it exits (jobs) or stays running (services)
   └── billed per second of CPU + memory used

CONTAINER GROUP (multiple containers on one host):
   ┌── container: web (port 80) ──┐
   │   container: sidecar (logs)  │ share the same IP, ports, and mounted volumes
   └── container: redis cache     ┘
```

---

## 26.3 When to Use ACI

```
✅ Simple single-container apps or microservices
✅ Short-lived jobs / batch tasks (run → exit → stop paying)
✅ Build agents, scheduled tasks, event-driven processing
✅ Burst capacity for AKS (virtual nodes)
❌ Complex orchestration, autoscaling across many nodes → use AKS/Container Apps
```

---

## 26.4 UI / CLI Steps

```
📍 Search "Container instances" → "+ Create": name, Image source=ACR/Docker Hub,
   image, CPU/memory, Networking → public IP + DNS label, Ports → 80 → Create
📍 Browse http://<dns-label>.<region>.azurecontainer.io
```
```bash
az container create -g lab-rg -n myaci \
  --image myregistry.azurecr.io/myapp:v1 \
  --cpu 1 --memory 1.5 --ports 80 --dns-name-label myapp-demo \
  --registry-login-server myregistry.azurecr.io \
  --assign-identity                                   # pull from ACR via identity
az container logs -g lab-rg -n myaci
az container show -g lab-rg -n myaci --query ipAddress.fqdn -o tsv
```

A **Container Group** is created from a YAML file listing multiple containers that share the IP/ports/volumes.

---

## 26.5 Integration with Other Azure Services

| Service | Role with ACI |
|---|---|
| **ACR** | Private source of the container image |
| **Managed Identity** | Credential-free ACR pulls |
| **Azure Files** | Shared persistent volume mounted into containers |
| **AKS (virtual nodes)** | Burst pods onto ACI without adding VM nodes |
| **Logic Apps / Event Grid** | Trigger ACI jobs on events |
| **Azure Monitor** | Container logs and metrics |

---

## 26.6 Real-World Scenario — Nightly Batch Job

```
A reporting job runs once a night and shouldn't pay for an idle VM all day.
   Logic App (schedule) → creates an ACI container from the report image at 2 AM.
   The container: pulls data, generates the report, writes to Azure Files, then EXITS.
   ACI stops billing the moment the container exits.
   For a multi-part job, a Container Group runs the report container + a log-shipping
   sidecar together, sharing a mounted Azure Files volume.
Result: pay-per-second batch processing with zero idle cost and no VM to manage.
```

---

## 26.7 Benefits

- **Serverless containers** — no VM to provision or manage
- **Fast start** — containers up in seconds
- **Per-second billing** — pay only while running (great for jobs)
- **Simple** — one command to run a container with a public endpoint
- **Container Groups** — co-locate helper containers (sidecars, caches)
- **Burst for AKS** — virtual nodes offload spikes to ACI

---

## 26.8 Common Use Cases

- Short-lived batch and scheduled jobs
- Simple single-container microservices
- Event-driven processing (triggered by Logic Apps/Event Grid)
- CI/CD build agents
- Burst capacity for AKS via virtual nodes

---

## 26.9 Exam Q&A

**Q: What is Azure Container Instances and when would you use it?**
> ACI runs a **single container in the cloud with no VM to manage**, billed per second — the fastest, simplest way to run a container. You use it for simple microservices, short-lived batch/scheduled jobs, build agents, and event-driven tasks, where you don't need the orchestration, autoscaling, or node management of AKS.

**Q: What is a Container Group?**
> A Container Group runs **multiple containers together on the same host**, sharing a network (IP/ports) and storage volumes — conceptually like a Kubernetes pod. It's used to co-locate tightly coupled containers, such as an app container plus a logging or caching sidecar.

**Q: How does ACI billing make it ideal for batch jobs?**
> ACI is billed per second of CPU and memory while the container runs, and a job container stops billing the moment it exits. So a nightly job pays only for the few minutes it runs, with zero idle cost — unlike a VM that would bill around the clock.

**Q: How does ACI compare to AKS?**
> ACI is serverless and single-container-focused — minimal management, ideal for simple or short-lived workloads. AKS is full Kubernetes for orchestrating many containers across a cluster with autoscaling and advanced networking. Use ACI for simplicity and bursts; use AKS when you need orchestration at scale (they also combine via virtual nodes).

**Q: How does ACI pull a private image from ACR without stored credentials?**
> Assign the container group a **Managed Identity** with the AcrPull role on the registry and reference ACR as the login server, so ACI authenticates with the identity instead of a stored username/password — the same credential-free pattern used across Azure.

---

## 26.10 Summary

Azure Container Instances (ACI) runs a **single container serverlessly** — no VM, fast start, billed per second — ideal for simple microservices and short-lived/batch jobs. A **Container Group** co-locates multiple containers (app + sidecars) sharing network and storage, like a pod. ACI pulls images from **ACR** via a **Managed Identity**, mounts **Azure Files** for persistence, can be triggered by events, and provides **burst capacity for AKS**. For orchestration at scale, step up to **Container Apps or AKS**; for simplicity and jobs, ACI wins.

[↑ Back to top](#-table-of-contents)

---
---

# 27. 🧩 Multi-Container Applications
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 62 (Building a multi-container app), 63 (Custom MySQL image), 64 (Rebuild PHP app & push to ACR)

---

## 27.1 What Is a Multi-Container Application?

Most real apps aren't one container — they're **several containers working together** (e.g., a web front end + a database + a cache). A multi-container app defines these pieces and how they connect, so they deploy and run as a coordinated unit.

Think of it like a **restaurant kitchen**: the chef (web/app container), the pantry (database container), and the prep station (cache container) each do one job but must work together and talk to each other. You don't hire one person to do everything — you set up specialized stations that coordinate.

> 💡 **If you know AWS:** This mirrors a **docker-compose stack** or an **ECS task with multiple containers** / a Kubernetes pod or deployment set. The idea — multiple cooperating containers with defined networking and dependencies — is identical; Azure runs them on **Container Groups (ACI)**, **Container Apps**, or **AKS**.

---

## 27.2 How the Pieces Connect (Flow Diagram)

```
MULTI-CONTAINER APP (e.g., a PHP voting app)
   ┌──────────────┐   HTTP    ┌──────────────┐   SQL    ┌──────────────┐
   │ web (PHP)     │ ────────► │ app logic     │ ───────► │ MySQL (data)  │
   └──────────────┘           └──────────────┘          └──────────────┘
                                     │ cache
                                     ▼
                              ┌──────────────┐
                              │ Redis cache   │
                              └──────────────┘
Each container = one image in ACR. They share a network and reference each other
by name. Build custom images (e.g., a seeded MySQL image) and push each to ACR.
```

---

## 27.3 Building & Publishing the Pieces

```
Typical flow for each component:
   1. Write a Dockerfile (e.g., a custom MySQL image pre-seeded with the schema).
   2. docker build -t myregistry.azurecr.io/voteapp-db:v1 .
   3. docker push myregistry.azurecr.io/voteapp-db:v1
   4. Repeat for the PHP web image.
   5. Deploy all components together (Container Group / Container Apps / AKS),
      wiring env vars so the web container finds the DB container by name/host.
```

Running options: a **Container Group** (ACI) for a few co-located containers, **Azure Container Apps** for serverless multi-container with scaling, or **AKS** for full Kubernetes orchestration.

---

## 27.4 Integration with Other Azure Services

| Service | Role |
|---|---|
| **ACR** | Stores each component's image |
| **Container Groups / Container Apps / AKS** | Run the multi-container app together |
| **Azure Database for MySQL / Cosmos DB** | Managed data tier (vs a DB container) |
| **Azure Files** | Shared persistent storage between containers |
| **Key Vault + Managed Identity** | Inject connection strings/secrets safely |
| **Azure Monitor** | Logs/metrics across all containers |

---

## 27.5 Real-World Scenario — PHP Voting App

```
Components:
   web   → PHP front end (custom image in ACR)
   db    → MySQL, custom image pre-seeded with the voting schema (in ACR)
   cache → Redis for vote tallies
Build each image → push to ACR → deploy as a Container Group (dev) sharing a network.
   web talks to db by its container name; cache speeds up reads.
For production: move the database to a managed Azure Database for MySQL (durability,
backups, HA), keep web/cache as containers on Container Apps/AKS, inject the DB
connection string from Key Vault via Managed Identity.
Result: a coordinated multi-tier app, portable in dev, hardened in production.
```

---

## 27.6 Benefits

- **Separation of concerns** — each tier is its own container/image
- **Independent updates** — rebuild/redeploy one component at a time
- **Portable** — the whole stack moves between environments
- **Scalable** — scale busy tiers independently (on Container Apps/AKS)
- **Reusable images** — custom images (e.g., seeded DB) stored in ACR

---

## 27.7 Common Use Cases

- Web + database + cache application stacks
- Microservices that must deploy together
- Dev/test environments mirroring production topology
- Apps with sidecars (logging, proxy, cache) alongside the main container

---

## 27.8 Exam Q&A

**Q: What is a multi-container application?**
> It's an app composed of **several cooperating containers** — e.g., a web front end, a database, and a cache — each built as its own image and deployed together with defined networking so they can talk to each other. It reflects how real applications are structured as separate, independently updatable tiers.

**Q: Where can you run a multi-container app on Azure?**
> On a **Container Group (ACI)** for a few co-located containers, **Azure Container Apps** for serverless multi-container with scaling, or **AKS** for full Kubernetes orchestration — choosing based on how much scale and control you need.

**Q: Why might you move the database out of a container in production?**
> A DB container is fine for dev, but production databases need durability, automated backups, high availability, and patching — so you typically use a **managed service** (Azure Database for MySQL/PostgreSQL or Cosmos DB) instead, keeping the stateless web/cache tiers as containers. This separates fragile state from easily-replaceable compute.

**Q: How do the containers in a stack find each other?**
> They share a network and reference each other by name/host (and port), often configured via environment variables — so the web container connects to the database container by its service name rather than a hardcoded IP. On Container Apps/AKS this is handled by built-in service discovery.

**Q: Why build custom images (like a seeded MySQL image) and push them to ACR?**
> A custom image bakes in the schema/config you need so the component starts ready-to-use and identically everywhere, and storing it privately in **ACR** gives secure, versioned, identity-controlled distribution to your Azure container services.

---

## 27.9 Summary

Real applications are **multi-container** — cooperating tiers (web, database, cache) each built as its own image, pushed to **ACR**, and deployed together on a **Container Group**, **Container Apps**, or **AKS** with networking that lets them find each other. Build custom images (e.g., a seeded DB) for ready-to-run components, inject secrets from **Key Vault** via **Managed Identity**, and in production swap the DB container for a **managed database** for durability and HA. It's the container equivalent of a docker-compose/ECS task stack.

[↑ Back to top](#-table-of-contents)

---
---

# 28. 🚀 Azure Container Apps
> 🟠 MEDIUM
> 📚 Course lectures: 66 (Azure Container Apps), 67 (Lab), 68 (Web Apps — Container deployment)

---

## 28.1 What Are Azure Container Apps?

**Azure Container Apps (ACA)** is a **serverless container platform** that runs and **autoscales** containerized apps and microservices — including **scale-to-zero** — without you managing any servers or Kubernetes.

Think of it like a **food-court stall that staffs itself**. When a queue forms, more servers appear instantly (scale out); when it's empty, everyone goes home and the stall costs nothing (scale to zero). You don't hire, schedule, or manage staff (no VMs, no Kubernetes control plane) — you just run your stall and the platform handles the rest. It's the middle ground between the "one quick container" of ACI and the "full kitchen" of AKS.

> 💡 **If you know AWS:** Container Apps is closest to **AWS App Runner / ECS Fargate with autoscaling (and scale-to-zero via KEDA)**. It's Kubernetes-based under the hood (and uses KEDA for event-driven scaling and Dapr for microservices) but you never touch Kubernetes — like a managed, serverless slice of EKS.

---

## 28.2 Where It Fits (Flow Diagram)

```
ACI ───────────────► CONTAINER APPS ───────────────► AKS
single container,    serverless microservices,       full Kubernetes,
no scaling/orchestr. autoscale + scale-to-zero,       max control + complexity
simplest             ingress, revisions, Dapr/KEDA

CONTAINER APP:
   image (from ACR) → autoscale rules (HTTP traffic / events / CPU)
                    → built-in HTTPS ingress + custom domains
                    → REVISIONS (versions) → split traffic for blue/green & canary
```

| Concept | Meaning |
|---|---|
| **Container Apps Environment** | The secure boundary several apps share (networking, logging) |
| **Container App** | Your deployed containerized service |
| **Revision** | An immutable version of the app; traffic can be split across revisions |
| **Scale rules** | HTTP concurrency, CPU/memory, or event sources (queues) — incl. scale-to-zero |

---

## 28.3 When to Use Container Apps

```
✅ Microservices and APIs that should autoscale (incl. to zero when idle)
✅ Event-driven / background processors (scale on queue length via KEDA)
✅ You want containers without managing Kubernetes
✅ Built-in ingress, revisions, blue/green & canary via traffic splitting
❌ Need full Kubernetes control / custom operators → use AKS
❌ A single quick/one-off container or batch job → ACI is simpler
```

---

## 28.4 UI / CLI Steps

```
📍 Search "Container Apps" → "+ Create": name, create a Container Apps Environment,
   Image source=ACR, image, Ingress=Enabled (HTTPS) + target port,
   Scaling → min 0 / max 10, rule = HTTP concurrency → Create
📍 Browse the app's auto-generated HTTPS URL
```
```bash
az containerapp env create -g lab-rg -n my-aca-env --location centralindia
az containerapp create -g lab-rg -n myapp --environment my-aca-env \
  --image myregistry.azurecr.io/myapp:v1 --target-port 80 --ingress external \
  --min-replicas 0 --max-replicas 10 --registry-server myregistry.azurecr.io

# New version + canary traffic split across revisions:
az containerapp update -g lab-rg -n myapp --image myregistry.azurecr.io/myapp:v2
az containerapp ingress traffic set -g lab-rg -n myapp \
  --revision-weight <rev-v1>=90 <rev-v2>=10         # 10% canary to v2
```

**Also:** you can deploy a container directly to **App Service for Containers** (lecture 68) when you want managed-web-app features (slots, Easy Auth) around a single container image.

---

## 28.5 Integration with Other Azure Services

| Service | Role with Container Apps |
|---|---|
| **ACR** | Private source of the container images |
| **Managed Identity + RBAC** | Credential-free ACR pulls and access to Azure services |
| **Key Vault** | Inject secrets at runtime |
| **Azure Monitor / Log Analytics** | Centralized logs and metrics |
| **KEDA** | Event-driven autoscaling (e.g., on queue length) |
| **Dapr** | Microservice building blocks (service calls, pub/sub, state) |
| **VNet / Private Endpoint** | Private networking for the environment |

---

## 28.6 Real-World Scenario — Serverless Microservices

```
A startup runs several APIs with spiky, unpredictable traffic and a tight budget.
Setup:
   One Container Apps Environment hosts: orders-api, payments-api, notify-worker.
   Images pulled from ACR via Managed Identity; secrets from Key Vault.
   orders-api / payments-api → scale on HTTP concurrency, min 1 (always warm).
   notify-worker → scale on Service Bus queue length via KEDA, min 0 (scale-to-zero).
   Releases: deploy a new revision, route 10% canary traffic, then shift to 100%.
Results:
   - Idle worker costs nothing (scales to zero); busy APIs scale out automatically.
   - No Kubernetes to manage; built-in HTTPS, revisions, and canary.
Result: Kubernetes-grade scaling and release safety with serverless simplicity.
```

---

## 28.7 Benefits

- **Serverless autoscale** — including **scale-to-zero** for idle services
- **No Kubernetes management** — containers without cluster ops
- **Built-in ingress + HTTPS** and custom domains
- **Revisions & traffic splitting** — easy blue/green and canary
- **Event-driven** — KEDA scaling on queues/events
- **Microservice features** — Dapr for service calls, pub/sub, and state

---

## 28.8 Common Use Cases

- Autoscaling microservices and REST APIs
- Event-driven and background processors (queue consumers)
- Cost-sensitive services that should scale to zero when idle
- Blue/green and canary releases without Kubernetes
- Modernizing apps that need scaling but not full AKS

---

## 28.9 Exam Q&A

**Q: What is Azure Container Apps and how does it differ from ACI and AKS?**
> ACA is a **serverless container platform** that autoscales containerized apps (including **scale-to-zero**) with built-in ingress, revisions, and event-driven scaling — without managing servers or Kubernetes. ACI is simpler (one container, no orchestration/autoscaling) and AKS is full Kubernetes (maximum control and complexity); Container Apps sits in between for autoscaling microservices without cluster ops.

**Q: What does "scale to zero" mean and why does it matter?**
> It means a Container App can scale down to **zero running replicas** when there's no traffic, so an idle service costs nothing and spins up on the next request/event. This is ideal for intermittent workloads and background processors, where paying for always-on instances would be wasteful.

**Q: How do you do blue/green or canary releases in Container Apps?**
> Each deployment creates an immutable **revision**, and you can **split ingress traffic** across revisions by weight — e.g., 90% to the old revision and 10% to the new one for a canary, then shift to 100% when healthy (or back to 0% to roll back). This is built in, no extra tooling required.

**Q: How does Container Apps scale on events like a queue?**
> It uses **KEDA** (Kubernetes Event-Driven Autoscaling) under the hood, so you can define a scale rule based on an event source such as a Service Bus or Storage queue's length — adding replicas as the backlog grows and removing them (down to zero) as it drains.

**Q: How does a Container App pull private images and read secrets securely?**
> It uses a **Managed Identity** with AcrPull to pull images from ACR without stored registry credentials, and it reads secrets from **Key Vault** at runtime — so no credentials live in the image or configuration, following Azure's identity → RBAC pattern.

---

## 28.10 Summary

Azure Container Apps is a **serverless container platform** for autoscaling microservices — including **scale-to-zero** — with built-in **HTTPS ingress, revisions, traffic splitting (blue/green & canary)**, **KEDA** event-driven scaling, and **Dapr** microservice features, all without managing Kubernetes. Apps live in a shared **environment**, pull images from **ACR** via **Managed Identity**, and read secrets from **Key Vault**. It's the sweet spot between **ACI** (simplest, single container) and **AKS** (full Kubernetes) — Kubernetes-grade scaling with serverless simplicity.

[↑ Back to top](#-table-of-contents)

---
---

# 29. 🌐 Networking Fundamentals (IP, CIDR, Subnet Mask)
> 🟠 MEDIUM
> 📚 Course lectures: 71 (Networks, devices, IP basics), 72 (IP addresses), 73 (Subnet Mask & CIDR blocks)

---

## 29.1 What Are These Fundamentals?

Before designing any Azure network, you need the building blocks everything rests on: **IP addresses** (who a device is), **CIDR notation** (a range of addresses), and **ports** (which service on a device). Get these wrong and you get the #1 production incident: "why can't my app reach the database?"

Think of it like **addressing mail**. The **IP address** is the building's street address (which machine); the **port** is the apartment number inside (which service — web, SSH, database); and **CIDR** is a way to describe a whole block of addresses at once ("houses 10.0.1.0 through 10.0.1.255"). Plan the street map before you build the houses.

> 💡 **If you know AWS:** These are cloud-agnostic — identical to VPC CIDR blocks and ports. If you're solid on AWS networking, skim this; the only thing to re-learn is Azure's resource names (VNet/subnet/NSG).

---

## 29.2 IP Addresses

An **IPv4 address** is four numbers (0–255) separated by dots: `10.0.1.5`, `192.168.0.100`.

| Type | Reachable from | Example use |
|---|---|---|
| **Public IP** | Anywhere on the internet | Web server, load balancer front end |
| **Private IP** | Only within your network (VNet) | Databases, app servers |

**Best practice:** give **public IPs only to resources that genuinely need internet access**; everything else stays private.

---

## 29.3 CIDR Notation (Flow Diagram)

```
CIDR = an IP + /number describing a RANGE. Smaller /number = BIGGER range.
   /24  → 256 addresses     (10.0.1.0 – 10.0.1.255)   ← a single subnet
   /16  → 65,536 addresses  (10.0.0.0 – 10.0.255.255) ← a whole VNet
   /8   → 16.7 million
Anchors to memorize: /24 = 256 (small, one subnet) · /16 = 65,536 (big, a VNet)
(The slash number = bits locked as the network portion; a 32-bit IPv4 address.)
```

---

## 29.4 Ports

An IP says *which machine*; a **port** says *which service* on it.

| Port | Service | Port | Service |
|---|---|---|---|
| 22 | SSH (Linux) | 1433 | SQL Server |
| 80 | HTTP | 3306 | MySQL |
| 443 | HTTPS | 5432 | PostgreSQL |
| 3389 | RDP (Windows) | | |

⚠️ Ports **22 (SSH)** and **3389 (RDP)** are constantly scanned by attackers — never open them to the whole internet.

---

## 29.5 How It Fits Together (Flow Diagram)

```
Client → IP 20.50.11.45 : Port 443 → the web server listening on 443 (HTTPS)

Inside your VNet (10.0.0.0/16), private traffic:
   App server (10.0.2.5) → Database (10.0.3.8) : Port 1433
   Both private, in different /24 subnets, never touching the internet.
```

---

## 29.6 UI Steps — Seeing IP/CIDR When Creating a VNet

```
📍 "Virtual networks" → "+ Create" → IP Addresses tab:
      IPv4 address space: 10.0.0.0/16   ← the whole VNet (65,536 addresses)
      Subnets:  default 10.0.0.0/24     ← one /24 slice (256 addresses)
This is where the theory becomes concrete — carve /24 subnets from a /16 VNet.
```

---

## 29.7 Integration with Other Azure Services

| Concept | Where it's used in Azure |
|---|---|
| **IP addresses** | VNets, NICs, public IPs, load balancers |
| **CIDR** | VNet address space and subnet ranges |
| **Ports** | NSG rules, load-balancer rules, service endpoints |
| **Private IPs** | Databases/app tiers; Private Endpoints |
| **Public IPs** | Internet-facing VMs, LBs, gateways |

---

## 29.8 Real-World Scenario — Planning a 3-Tier App on Paper

```
Plan the IP layout BEFORE creating anything (a real admin habit):
   VNet:        10.0.0.0/16   (65,536 addresses — plenty of room)
     web-subnet: 10.0.1.0/24  (256)  accepts 80/443 from the internet
     app-subnet: 10.0.2.0/24  (256)  accepts 8080 from web tier only
     db-subnet:  10.0.3.0/24  (256)  accepts 1433 from app tier only
Planning ranges up front prevents overlap problems later (you can't peer two
VNets with overlapping address spaces).
```

---

## 29.9 Benefits

- **Prevents the #1 connectivity bug** — correct ranges and ports
- **Clean segmentation** — plan subnets per tier
- **Security by design** — expose only the ports/IPs you must
- **Avoids rework** — non-overlapping ranges keep future peering possible
- **Cloud-agnostic** — the same knowledge applies everywhere

---

## 29.10 Common Use Cases

- Designing a VNet's address space and subnet layout
- Deciding which resources get public vs private IPs
- Writing NSG rules by port and source
- Planning ranges so VNets can peer without overlap

---

## 29.11 Exam Q&A

**Q: What does a /24 vs a /16 CIDR mean?**
> The number after the slash is how many bits are the fixed network portion — the **smaller the number, the larger the range**. A /24 gives 256 addresses (good for a single subnet) and a /16 gives 65,536 (good for a whole VNet). Counter-intuitively, the smaller slash number is the bigger block.

**Q: Public vs private IP?**
> A public IP is reachable from the internet; a private IP is reachable only within your VNet (or connected networks). Best practice is to assign public IPs only to resources that genuinely need internet exposure, keeping databases and app servers on private IPs.

**Q: What port does SQL Server use and why does it matter for networking?**
> TCP **1433**. It matters because your NSG rules must explicitly allow the app tier to reach the database on 1433 — and only from the app tier, not from anywhere else — so the database stays functional but protected.

**Q: Why must VNet/subnet CIDR ranges not overlap?**
> Overlapping ranges make routing ambiguous — Azure couldn't tell which network an address belongs to. That's why you can't peer two VNets (or connect to on-premises) if their address spaces overlap, so plan non-overlapping ranges up front.

**Q: Why never open ports 22/3389 to the whole internet?**
> Bots continuously scan the internet brute-forcing SSH (22) and RDP (3389). Exposing them to `0.0.0.0/0` invites attack, so restrict the source to specific IPs or, better, use **Azure Bastion** so those ports are never exposed publicly at all.

---

## 29.12 Summary

Networking rests on three fundamentals: an **IP address** identifies a machine (public = internet-reachable, private = internal-only), **CIDR** describes a range (smaller slash = bigger range; **/24 = 256**, **/16 = 65,536**), and a **port** identifies the service (**443** HTTPS, **1433** SQL, **22** SSH). Plan a **/16 VNet** carved into **/24 subnets per tier** on paper first, assign public IPs only where needed, keep ranges non-overlapping for future peering, and never expose **22/3389** to the internet.

[↑ Back to top](#-table-of-contents)

---
---

# 30. 🔷 Virtual Network (VNet)
> 🔴 FULL
> 📚 Course lectures: 74 (Intro to VNets), 75 (Building a VNet), 79 (Understanding IP addresses), 80 (Secondary NIC)

---

## 30.1 What Is a Virtual Network?

A **Virtual Network (VNet)** is your own **private, isolated network inside Azure** — a logically separate slice of Azure's networking where you control the IP ranges, segmentation, routing, and security. It's the foundation every other networked resource plugs into.

Think of a VNet like **leasing a private, gated plot of land inside a huge industrial park**. The park (Azure) provides power and roads, but inside your fence you decide the street layout (subnets), who can enter (NSGs), and where traffic flows (routes). Your plot is completely walled off from every other tenant's plot, even though you share the same park.

> 💡 **If you know AWS:** A VNet is the direct equivalent of an **AWS VPC**. Two key differences: (1) Azure has **no separate Internet Gateway resource** — any resource with a public IP just has internet connectivity; (2) Azure **subnets aren't tied to a single Availability Zone** (unlike AWS) — you pick a resource's zone per-resource, not per-subnet.

---

## 30.2 What a VNet Gives You (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  VIRTUAL NETWORK "production-vnet"  (10.0.0.0/16)          │
│  Completely isolated from every other Azure customer       │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│   │ web-subnet  │  │ app-subnet  │  │ db-subnet   │        │
│   │ 10.0.1.0/24 │  │ 10.0.2.0/24 │  │ 10.0.3.0/24 │        │
│   └──────┬──────┘  └──────┬──────┘  └──────┬──────┘        │
│          └──── talk privately by default (subject to NSGs) ─┘
└──────────────────────────┬────────────────────────────────┘
                           ▼ (only if a resource has a Public IP)
                        Internet
You control: IP address space (CIDR) · subnets · routing (UDRs) · security (NSGs)
             · connectivity out (internet, peering, on-premises)
```

---

## 30.3 Key Facts

```
✅ A VNet lives in ONE region (connect to other regions via Peering)
✅ A VNet belongs to ONE subscription
✅ Resources in the same VNet talk privately by default (subject to NSGs)
✅ You can add multiple address spaces later if you run out
✅ Address spaces must NOT overlap with networks you connect to (on-prem, peers)
✅ No "Internet Gateway" — internet access comes with any resource that has a Public IP
✅ A VM can have a SECONDARY NIC (another interface in a subnet) for multi-NIC designs
```

---

## 30.4 UI / CLI Steps — Create a VNet

```
📍 "Virtual networks" → "+ Create":
   Basics → RG=production-rg, Name=production-vnet, Region=Central India
   IP Addresses → IPv4 address space = 10.0.0.0/16
      + add subnets: web-subnet 10.0.1.0/24, app-subnet 10.0.2.0/24, db-subnet 10.0.3.0/24
   → Review + create → Create
```
```bash
az network vnet create -g production-rg -n production-vnet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name web-subnet --subnet-prefix 10.0.1.0/24
```

---

## 30.5 Integration with Other Azure Services

| Service | Role with a VNet |
|---|---|
| **Subnets** | Segments of the VNet where resources live |
| **NSG / ASG** | Firewall rules applied to subnets/NICs |
| **VNet Peering** | Connect VNets privately |
| **VPN / ExpressRoute Gateway** | Connect to on-premises |
| **Private Endpoint / Service Endpoint** | Private access to PaaS services |
| **Load Balancer / App Gateway / Bastion** | Traffic distribution + secure management |
| **Route Tables (UDR)** | Override default routing |

---

## 30.6 Real-World Scenario — Secure-by-Design Foundation

```
Setting up the network for a new app that must be secure from day one:
   1. Create "production-vnet" (10.0.0.0/16).
   2. Carve purpose-specific subnets: web (public-facing), app (internal),
      db (most locked down).
   3. Only the web tier's load balancer gets a Public IP — everything else stays private.
   4. Later layers add NSGs (tier isolation), Private Endpoints (PaaS access),
      and Bastion (management without public IPs).
The VNet is the foundation — get the address planning right first, because it's
painful to change once resources are deployed.
```

---

## 30.7 Benefits

- **Isolation** — your own private network, walled off from other tenants
- **Full control** — IP space, subnets, routing, security
- **Private communication** — resources talk internally by default
- **Hybrid connectivity** — peering, VPN, ExpressRoute
- **Foundation** — everything networked plugs into the VNet

---

## 30.8 Common Use Cases

- Hosting multi-tier applications with segmented subnets
- Isolating workloads from the public internet
- Connecting Azure to on-premises (hybrid)
- Private access to PaaS services (Private Endpoints)
- Secure management access via Bastion

---

## 30.9 Exam Q&A

**Q: What is a VNet?**
> A Virtual Network is your own private, logically isolated network inside Azure where you define the IP address space, divide it into subnets, and control routing and security. It's isolated from every other Azure customer even though it runs on shared underlying infrastructure, and it's the foundation every networked resource connects to.

**Q: Does Azure need an Internet Gateway like AWS?**
> No. In Azure there's no separate Internet Gateway resource — any resource assigned a public IP automatically has internet connectivity. This is a notable difference from AWS, where you must create and attach an Internet Gateway to a VPC before instances can reach the internet.

**Q: Can resources in a VNet communicate by default?**
> Yes — resources in the same VNet can talk privately by default, subject to any NSG rules applied. You don't need to explicitly enable intra-VNet communication, though you often restrict it with NSGs for tier isolation.

**Q: What's a key rule about VNet address spaces when connecting networks?**
> They must **not overlap**. You can't peer two VNets (or connect a VNet to an on-premises network) if their ranges overlap, because routing would be ambiguous — so plan non-overlapping address spaces from the start.

**Q: Are Azure subnets tied to an Availability Zone?**
> No — unlike AWS, Azure subnets aren't bound to a single zone. You choose a resource's zone when you deploy it, so you don't need a separate subnet per zone.

---

## 30.10 Summary

A VNet is your **private, isolated network in Azure** — the equivalent of an AWS VPC — where you control the **IP address space, subnet segmentation, routing, and security**. Resources inside communicate privately by default (subject to NSGs). Remember the Azure quirks: **no Internet Gateway** (public IP = internet access), **subnets aren't zone-bound**, and **address spaces must never overlap** with networks you'll connect. Plan the address space carefully up front — it's the foundation everything else builds on.

[↑ Back to top](#-table-of-contents)

---
---

# 31. 🧩 Subnets
> 🔴 FULL
> 📚 Course lectures: 76 (Understanding subnets), 77–78 (Deploy VMs to subnets), 89–90 (NSG + subnets)

---

## 31.1 What Is a Subnet?

A **subnet** divides a VNet into smaller, isolated segments. Putting every resource in one flat network is insecure (a breached web server could reach the database directly); subnets let you separate the app into **tiers** and apply **different security rules** to each.

Think of subnets like **floors in an office building with separate keycard access**. Reception (web subnet) is open to visitors; the office floor (app subnet) only to staff; the server room (db subnet) only to IT. A thief who talks their way into reception still can't reach the server room — each floor has its own locked door (NSG).

> 💡 **If you know AWS:** Subnets are the same concept as AWS subnets. The key difference: AWS subnets each live in **one Availability Zone** (so one per AZ), while Azure subnets are **not zone-bound** — you place resources into zones individually, so you don't need a subnet-per-zone.

---

## 31.2 Subnets Divide a VNet (Flow Diagram)

```
VNet 10.0.0.0/16 (65,536 addresses)
 ├── web-subnet 10.0.1.0/24  → public tier · NSG: allow 80/443 from internet
 ├── app-subnet 10.0.2.0/24  → internal tier · NSG: allow only from web-subnet
 └── db-subnet  10.0.3.0/24  → locked down · NSG: allow 1433 only from app-subnet
Each subnet = a slice of the VNet's range, with its OWN security rules (NSG).
```

---

## 31.3 The 5 Reserved IPs

Azure **reserves 5 IPs in every subnet**, so a /24 (256 total) gives **251 usable**:
```
10.0.1.0   network address        10.0.1.3   Azure DNS
10.0.1.1   default gateway        10.0.1.255 broadcast
10.0.1.2   Azure DNS              → usable: 10.0.1.4 – 10.0.1.254 = 251
```

---

## 31.4 Special Subnets (Exact Names Required)

| Service | Required subnet name |
|---|---|
| VPN / ExpressRoute Gateway | `GatewaySubnet` |
| Azure Firewall | `AzureFirewallSubnet` |
| Azure Bastion | `AzureBastionSubnet` |

Name them wrong and the service won't deploy — a classic gotcha.

---

## 31.5 UI / CLI Steps — Add a Subnet

```
📍 VNet → "Subnets" → "+ Subnet":
   Name=app-subnet, Range=10.0.2.0/24, (optional) attach app-nsg + route table → Save
```
```bash
az network vnet subnet create -g production-rg --vnet-name production-vnet \
  -n app-subnet --address-prefix 10.0.2.0/24
```

---

## 31.6 Integration with Other Azure Services

| Service | Role with subnets |
|---|---|
| **NSG** | Per-subnet firewall rules (tier isolation) |
| **Route Table (UDR)** | Custom routing per subnet |
| **Service / Private Endpoints** | Enabled per subnet |
| **Gateways / Firewall / Bastion** | Each needs its own dedicated, exact-named subnet |
| **VMs / VMSS / App Service (VNet integration)** | Deployed into subnets |

---

## 31.7 Real-World Scenario — Tier Isolation (Defense in Depth)

```
Securing a 3-tier app so a breach of one tier can't reach another:
   web-subnet (10.0.1.0/24): accepts 80/443 from the internet — the only exposed tier.
   app-subnet (10.0.2.0/24): accepts only traffic FROM web-subnet on the app port —
      not reachable from the internet.
   db-subnet  (10.0.3.0/24): accepts only traffic FROM app-subnet on 1433 — the most
      locked-down tier; even a breached web server can't reach the database directly.
This tier-by-tier isolation is "defense in depth" — a key exam phrase.
```

---

## 31.8 Benefits

- **Security segmentation** — isolate tiers with per-subnet NSGs
- **Organization** — group resources by role
- **Defense in depth** — a breach in one tier can't cascade
- **Service enablement** — dedicated subnets for gateways/firewall/Bastion
- **Routing control** — per-subnet UDRs

---

## 31.9 Common Use Cases

- Separating web / app / database tiers
- Dedicated subnets for Firewall, Bastion, and gateways
- Applying different NSGs or routes per segment
- Hosting Private Endpoints or VNet-integrated services

---

## 31.10 Exam Q&A

**Q: Why divide a VNet into subnets instead of one flat network?**
> For security and organization — each subnet can have its own NSG, letting you isolate tiers so, for example, the database subnet only accepts traffic from the app subnet and is completely unreachable from the internet. This layered isolation (defense in depth) means a breach in one tier can't directly reach another.

**Q: How many usable IPs are in a /24 subnet in Azure?**
> **251**. A /24 has 256 total addresses, but Azure reserves 5 in every subnet (network address, default gateway, two for DNS, and broadcast), leaving 251 for your resources.

**Q: Are Azure subnets tied to Availability Zones?**
> No — unlike AWS, Azure subnets aren't bound to a single zone. You choose zone placement per-resource at deployment, so a single subnet can hold resources in different zones and you don't need a subnet per zone.

**Q: What's special about a subnet named "AzureBastionSubnet"?**
> Certain Azure services require a dedicated subnet with an **exact** name — Bastion needs `AzureBastionSubnet`, Azure Firewall needs `AzureFirewallSubnet`, and gateways need `GatewaySubnet`. If the name is wrong, the service won't deploy, so these are reserved, exact-match names.

**Q: Where do you attach an NSG — subnet or NIC?**
> You can attach an NSG at the **subnet** level (applies to all resources in it) and/or the **NIC** level (one VM). Subnet-level NSGs are the common choice for broad tier rules; when both exist, traffic must be allowed by both to pass.

---

## 31.11 Summary

Subnets divide a VNet into isolated segments — typically one per tier (web/app/db) — so you can apply different **NSG** rules to each and isolate tiers (**defense in depth**). Remember Azure **reserves 5 IPs per subnet** (a /24 gives **251 usable**), subnets **aren't zone-bound** (unlike AWS), and certain services need **dedicated, exact-named subnets** (`GatewaySubnet`, `AzureFirewallSubnet`, `AzureBastionSubnet`). Attach an NSG to each subnet to control what flows in and out.

[↑ Back to top](#-table-of-contents)

---
---

# 32. 🛡️ Network Security Groups (NSG)
> 🔴 FULL
> 📚 Course lectures: 81 (About NSGs), 82–86 (Priorities, inter-VM, outbound, ICMP), 87–90 (Two-tier, subnets, NIC)

---

## 32.1 What Is an NSG?

A **Network Security Group (NSG)** is Azure's **virtual firewall** — a prioritized list of **allow/deny rules** that control which network traffic can reach and leave your resources, by port, protocol, source, and destination.

Think of an NSG like a **bouncer with a numbered guest list**. Each rule is a line on the list checked in order (by priority number, lowest first); the bouncer acts on the **first matching line** and stops reading. Anyone not explicitly on the "allow" list is turned away (there's always a hidden "deny everyone else" at the bottom).

> 💡 **If you know AWS:** An NSG is like **AWS Security Groups + Network ACLs combined**. Unlike AWS (Security Groups = allow-only on instances; NACLs = allow/deny on subnets), a single Azure NSG supports **both allow AND deny rules** and attaches at **both subnet and NIC level**.

---

## 32.2 How Rule Evaluation Works (Flow Diagram)

```
A packet tries to reach your VM:
   Rules checked by PRIORITY (lowest number first), STOP at the first match:
      100: Allow 443 from Internet?  → MATCH → ✅ ALLOW (stop)
      200: Allow 22 from OfficeIP?   → (only if 100 didn't match)
      4096: Deny all                  → catch-all
      65500 (hidden default): Deny All Inbound
Anything NOT explicitly allowed is BLOCKED → NSGs are "deny by default".
```

| Field | Example |
|---|---|
| **Priority** | 100–4096 (lower = checked first) |
| **Direction** | Inbound / Outbound |
| **Source / Destination** | `Internet`, an IP/CIDR, a service tag, or an **ASG** |
| **Port / Protocol** | 443 / TCP |
| **Action** | Allow / Deny |

---

## 32.3 Stateful & Two Attachment Levels

```
STATEFUL: allow an inbound request → the outbound reply is AUTOMATICALLY allowed
          (no separate return rule needed) — common exam trap.

ATTACH at:  SUBNET level (all resources in the subnet) and/or NIC level (one VM).
            If both exist, traffic must pass BOTH. Inbound: subnet NSG → NIC NSG → VM.
```

**Service tags** (e.g., `Internet`, `VirtualNetwork`, `AzureLoadBalancer`, `Storage`) let you reference Azure IP ranges by name instead of memorizing them — Azure keeps them updated.

---

## 32.4 UI / CLI Steps — Create & Attach an NSG

```
📍 "Network security groups" → "+ Create" (name=web-nsg) → Create
📍 Open it → "Inbound security rules" → "+ Add":
   Source=Service Tag "Internet", Destination=Any, Service=HTTPS (443),
   Action=Allow, Priority=100, Name=Allow-HTTPS → Add
📍 Attach: NSG → "Subnets" → "+ Associate" → VNet + web-subnet → OK
```
```bash
az network nsg create -g production-rg -n web-nsg
az network nsg rule create -g production-rg --nsg-name web-nsg -n Allow-HTTPS \
  --priority 100 --access Allow --protocol Tcp --direction Inbound \
  --source-address-prefixes Internet --destination-port-ranges 443
```

⚠️ **Never** create `Allow | Any | 22 (or 3389)` — that opens SSH/RDP to the whole internet. Restrict to your IP or use **Bastion**.

---

## 32.5 Integration with Other Azure Services

| Service | Role with NSGs |
|---|---|
| **Subnets / NICs** | Where NSGs attach |
| **ASG** | Referenced as source/destination (role-based rules) |
| **Service tags** | Reference Azure ranges by name |
| **Azure Firewall** | Centralized, domain-aware filtering beyond NSGs |
| **Network Watcher** | IP flow verify / effective rules to debug NSGs |
| **NSG Flow Logs** | Record traffic for analysis |

---

## 32.6 Real-World Scenario — 3-Tier Defense in Depth

```
Subnet NSGs enforcing tier isolation:
   web-subnet NSG: allow 80/443 from Internet
   app-subnet NSG: allow the app port ONLY from web-subnet
   db-subnet  NSG: allow 1433 ONLY from app-subnet
   (all: deny everything else — the default)
Result: the database is reachable only from the app tier — even a breached web
server can't reach it directly. Defense in depth, enforced at the subnet boundary.
```

---

## 32.7 Benefits

- **Virtual firewall** — control traffic by port/source without hardware
- **Both allow AND deny** — finer control than AWS Security Groups
- **Stateful** — return traffic auto-allowed
- **Layered** — attach at subnet and NIC
- **Maintainable** — service tags + ASGs avoid brittle IP lists
- **Free** — NSGs incur no charge

---

## 32.8 Common Use Cases

- Isolating application tiers (web/app/db)
- Restricting management ports (22/3389) to specific IPs
- Allowing only specific internet traffic (80/443) to web tiers
- Role-based rules with ASGs for autoscaling fleets

---

## 32.9 Exam Q&A

**Q: How does an NSG decide which rule wins?**
> Rules are evaluated by **priority number, lowest first**, and the **first matching rule wins** — evaluation stops there. There's a hidden default "deny all inbound" at the bottom, so anything not explicitly allowed is blocked (deny by default).

**Q: What does "stateful" mean for an NSG?**
> If you allow an inbound request, the **outbound response for that same connection is automatically allowed** without a separate rule, because Azure tracks the connection state. A common trap is thinking you need matching request/response rules — you don't.

**Q: Can you attach an NSG to both a subnet and a NIC?**
> Yes. When both exist, traffic must be allowed by **both** to pass — for inbound, the subnet NSG is checked first, then the NIC NSG, then the VM. Subnet-level NSGs are typical for broad tier rules; NIC-level for per-VM exceptions.

**Q: What are service tags and why use them?**
> Service tags are named labels (e.g., `Internet`, `VirtualNetwork`, `AzureLoadBalancer`, `Storage`) that represent Azure IP ranges, which Microsoft keeps updated. Using them in NSG rules avoids hardcoding and maintaining large IP lists, so rules stay correct automatically as Azure's ranges change.

**Q: Why is `Allow | Any | 22` a dangerous rule?**
> It opens SSH to the **entire internet**, where bots constantly brute-force port 22 (and 3389 for RDP). You should restrict the source to a specific office IP, or avoid exposing these ports at all by using **Azure Bastion**.

---

## 32.10 Summary

An NSG is Azure's **virtual firewall** — a prioritized list of **allow/deny** rules (lowest priority number wins, with a default **deny-all** backstop) controlling inbound/outbound traffic by port, protocol, source, and destination. NSGs are **stateful** (return traffic auto-allowed) and attach at **both subnet and NIC** level. Use **service tags** and **ASGs** instead of raw IP lists, **never** expose SSH/RDP to "Any", and apply **subnet-level NSGs per tier** to build defense-in-depth architectures. They're free and central to Azure network security.

[↑ Back to top](#-table-of-contents)

---
---

# 33. 🏷️ Application Security Groups (ASG)
> 🟠 MEDIUM
> 📚 Course lectures: 91 (Application Security Groups), 92 (Applying ASGs)

---

## 33.1 What Is an ASG?

An **Application Security Group (ASG)** lets you group VMs by **role** (e.g., "web-servers") and reference that group name in NSG rules — instead of hardcoding a brittle list of IP addresses that breaks every time autoscaling adds or removes a VM.

Think of an ASG like a **job-title lanyard** instead of a photo of each employee. A security rule that says "anyone wearing a 'Web Server' lanyard may enter the database room" keeps working no matter how many web servers you hire or fire — you just hand each new hire the lanyard. Without it, you'd have to update the door's photo list every single time staff changes.

> 💡 **If you know AWS:** An ASG is like **referencing another Security Group as the source** in an AWS Security Group rule — you group by role, not by IP. It lets rules survive constant instance churn.

---

## 33.2 The Problem & Solution (Flow Diagram)

```
❌ WITHOUT ASGs (brittle, breaks with autoscaling):
   NSG rule: Allow FROM [10.0.1.4, 10.0.1.5, ... 20 IPs ...] → every new VM = edit the rule

✅ WITH ASGs (robust):
   ASG "web-servers"  ── NSG rule: Allow FROM "web-servers" TO "db-servers" on 1433 ──► ASG "db-servers"
   New autoscaled VM? Just add it to "web-servers" → the rule applies automatically. Zero edits.
```

---

## 33.3 UI / CLI Steps

```
📍 "Application security groups" → "+ Create" (name=web-servers-asg) → Create (repeat for db-servers-asg)
📍 Add VMs: VM → Networking → the NIC → "Application security groups" → select web-servers-asg → Save
📍 Use in a rule: NSG → Inbound → "+ Add":
   Source=Application security group → web-servers-asg,
   Destination=Application security group → db-servers-asg, Port=1433, Allow → Add
```
```bash
az network asg create -g production-rg -n web-servers-asg
az network nic update -g production-rg -n <nic> --application-security-groups web-servers-asg
```

---

## 33.4 Integration with Other Azure Services

| Service | Role with ASGs |
|---|---|
| **NSG** | ASGs are referenced as source/destination inside NSG rules |
| **VM Scale Sets** | New instances join the ASG → rules apply automatically |
| **NICs** | VMs join an ASG via their network interface |
| **VNet / Subnets** | ASGs group VMs within the same VNet |

---

## 33.5 Real-World Scenario — Autoscaling Web Tier

```
An autoscaling web tier + a database tier:
   1. Create "web-asg" and "db-asg".
   2. Add all web VMs to web-asg, all db VMs to db-asg.
   3. NSG rule: allow web-asg → db-asg on 1433.
   4. Traffic spike: the Scale Set adds 5 new web VMs → ensure they join web-asg
      (Scale Sets can do this automatically) → the security rule instantly covers them,
      with zero manual rule changes.
This is why ASGs are essential with autoscaling — rules stay correct as VMs churn.
```

---

## 33.6 Benefits

- **Role-based rules** — reference "web-servers", not IP lists
- **Autoscaling-friendly** — rules survive instance churn automatically
- **Maintainable** — add/remove a VM from a group, not edit rules
- **Clear intent** — rules read by role, not opaque addresses
- **Free** — no additional charge

---

## 33.7 Common Use Cases

- Securing autoscaling fleets (VM Scale Sets)
- Role-based tier-to-tier rules (web → db)
- Large, changing sets of VMs that share the same rule
- Simplifying complex NSG rule sets

---

## 33.8 Exam Q&A

**Q: What's the difference between an NSG and an ASG?**
> An NSG is the firewall itself — the actual allow/deny rules. An ASG is a **logical grouping of VMs by role** (like "web-servers") that you reference *inside* NSG rules instead of hardcoding IP addresses. The NSG enforces; the ASG makes the rule's source/destination role-based so it stays correct automatically.

**Q: Why are ASGs especially important with VM Scale Sets?**
> Because autoscaling constantly changes which VMs and IPs exist. An IP-based NSG rule would need constant manual updates, but an ASG-based rule just requires each new VM to join the ASG — which Scale Sets can do automatically — so the rule applies to new instances with no edits.

**Q: How does a VM join an ASG?**
> Through its **network interface (NIC)** — you associate the NIC with one or more ASGs (in the VM's Networking blade or via `az network nic update`). Once associated, any NSG rule referencing that ASG applies to the VM.

**Q: Are ASGs used on their own?**
> No — an ASG is always used **together with an NSG**; it's referenced as the source or destination inside an NSG rule. On its own it just defines a group of VMs; the NSG is what actually permits or denies the traffic.

**Q: Must ASG members be in the same VNet?**
> Yes — ASGs group VMs within the same virtual network, so the NSG rules referencing them apply to resources in that VNet. For cross-VNet scenarios you'd use peering plus other constructs.

---

## 33.9 Summary

Application Security Groups let you write NSG rules based on VM **roles** (e.g., "web-servers" → "db-servers") instead of brittle, hardcoded IP lists. This is essential with autoscaling **VM Scale Sets**, where VMs and IPs constantly change — new VMs simply join the ASG (often automatically) and existing rules apply. ASGs are always used **together with NSGs** (referenced as a source/destination), VMs join via their **NIC**, and they're free.

[↑ Back to top](#-table-of-contents)

---
---

# 34. 🔗 VNet Peering
> 🟠 MEDIUM
> 📚 Course lectures: 93 (Peering — setup), 94 (Peering — implementation)

---

## 34.1 What Is VNet Peering?

**VNet Peering** connects two Virtual Networks so their resources can communicate **privately, using private IPs, over Microsoft's backbone** — as if they were on the same network. By default, separate VNets are completely isolated; peering bridges them.

Think of peering like **building a private, guarded bridge between two gated communities**. Residents of each community can now visit each other directly without going out onto the public road (internet), but the bridge connects only those two communities — you can't use it to hop through one community to reach a third.

> 💡 **If you know AWS:** VNet Peering is the direct equivalent of **AWS VPC Peering**, including the same critical limitation: peering is **not transitive** (if A peers with B and B peers with C, A cannot reach C through B).

---

## 34.2 How Peering Works (Flow Diagram)

```
┌───────────────────────┐   PEERING   ┌───────────────────────┐
│ VNet-A "shared-vnet"   │◄──────────►│ VNet-B "app-vnet"      │
│ 10.0.0.0/16            │            │ 10.1.0.0/16            │
│ DNS, monitoring, fw    │            │ App VMs, databases     │
└───────────────────────┘            └───────────────────────┘
A VM in A reaches a VM in B by PRIVATE IP over the Microsoft backbone (never the internet).
⚠️ Address spaces must NOT overlap.   ⚠️ Peering is NOT transitive:
   A↔B, B↔C → A still CANNOT reach C through B (create a direct A↔C peering).
```

```
✅ Works same-region, cross-region (Global Peering), and across subscriptions/tenants
✅ Low latency, high bandwidth — traffic stays on Microsoft's backbone
✅ Must be established on BOTH sides (the portal can do both at once)
```

---

## 34.3 UI / CLI Steps

```
📍 Open VNet-A → "Peerings" → "+ Add":
   This VNet link name=shared-to-app, Remote link name=app-to-shared,
   Remote VNet=app-vnet, ✅ Allow traffic to/from remote VNet → Add
   (Azure creates BOTH sides if you have access to both VNets)
```
```bash
az network vnet peering create -g rg -n shared-to-app --vnet-name shared-vnet \
  --remote-vnet app-vnet --allow-vnet-access
az network vnet peering create -g rg -n app-to-shared --vnet-name app-vnet \
  --remote-vnet shared-vnet --allow-vnet-access
```

---

## 34.4 Integration with Other Azure Services

| Service | Role with peering |
|---|---|
| **Hub-and-Spoke topology** | Peering connects spokes to the hub |
| **Azure Firewall / UDR** | Route spoke traffic through a hub firewall (peering isn't transitive) |
| **Private DNS zones** | Shared name resolution across peered VNets |
| **Gateway transit** | A peered VNet can use the hub's VPN/ExpressRoute gateway |
| **NSGs** | Still apply to control traffic between peered VNets |

---

## 34.5 Real-World Scenario — Centralized Shared Services

```
A company centralizes shared infrastructure and connects team VNets to it:
   shared-services-vnet: Azure Firewall, DNS servers, monitoring
   application-vnet:      the application VMs/databases
   1. Peer application-vnet ↔ shared-services-vnet.
   2. The app VNet now uses the centralized DNS and can route its traffic through the
      shared firewall — without duplicating those tools in every VNet.
This "one central hub, many connected VNets" idea is the basis of the Hub-and-Spoke
topology (the standard enterprise design).
```

---

## 34.6 Benefits

- **Private connectivity** — VNets talk via private IPs, no internet
- **Fast** — low latency, high bandwidth over Microsoft's backbone
- **Flexible** — same-region, cross-region, cross-subscription/tenant
- **Foundation** — enables hub-and-spoke designs
- **Secure** — NSGs still control traffic; nothing is public

---

## 34.7 Common Use Cases

- Connecting a shared-services VNet to app VNets (hub-and-spoke)
- Private communication between teams'/apps' VNets
- Cross-region connectivity (Global Peering)
- Cross-subscription/tenant connectivity in large orgs

---

## 34.8 Exam Q&A

**Q: What is VNet Peering?**
> It connects two VNets so their resources communicate using **private IPs over Microsoft's backbone**, as if on the same network — without traversing the public internet. It works same-region, cross-region (Global Peering), and across subscriptions and tenants.

**Q: Is VNet Peering transitive?**
> **No.** If VNet-A peers with VNet-B and VNet-B peers with VNet-C, VNet-A cannot reach VNet-C through B. You'd need a direct A↔C peering (or route through a hub firewall). This non-transitivity is a key limitation and a common exam question.

**Q: What's a requirement for two VNets to be peered?**
> Their address spaces must **not overlap**, since overlapping ranges make routing ambiguous. You also must establish the peering on both sides (the portal can do both at once if you have permissions on both VNets).

**Q: How do spokes communicate in a hub-and-spoke given peering isn't transitive?**
> Spokes peer to the hub but not to each other; to connect spoke-to-spoke (or reach the internet centrally), you use **User-Defined Routes** pointing to the hub's firewall as the next hop, so traffic routes through the hub for inspection rather than relying on transitive peering.

**Q: Can peered VNets be in different regions or subscriptions?**
> Yes — Global Peering connects VNets in different regions, and peering also works across different subscriptions and even tenants. Traffic still stays on the Microsoft backbone and uses private IPs.

---

## 34.9 Summary

VNet Peering privately connects two VNets over Microsoft's backbone so their resources communicate via **private IPs** — working same-region, cross-region (Global Peering), and across subscriptions. Remember the two key rules: **address spaces must not overlap**, and peering is **not transitive** (no hopping through a middle VNet). It's the building block of the **Hub-and-Spoke** topology, where spokes peer to a hub and use **UDRs to a hub firewall** for any spoke-to-spoke or internet traffic.

[↑ Back to top](#-table-of-contents)

---
---

# 35. 🏰 Azure Bastion
> 🟠 MEDIUM
> 📚 Course lectures: 95 (Azure Bastion), 96 (Lab)

---

## 35.1 What Is Azure Bastion?

**Azure Bastion** is a managed service that lets you **RDP/SSH into your VMs directly from the Azure portal (over TLS in the browser)** — with **no public IP on the VM** and no need to open port 22/3389 to the internet.

Think of Bastion like a **secure reception desk and escort service in a locked building**. Instead of giving every office a street-facing door (public IP + open RDP/SSH), visitors check in at one guarded reception (Bastion), which escorts them to the right office through internal corridors. The offices have no exposed doors at all, so there's nothing for burglars outside to pick.

> 💡 **If you know AWS:** Bastion is a managed version of the classic **bastion/jump host** pattern (like EC2 Instance Connect / SSM Session Manager for browser-based, keyless access). You get secure VM access without exposing SSH/RDP or maintaining your own jump box.

---

## 35.2 How It Works (Flow Diagram)

```
You (browser) ── HTTPS/TLS (443) ──► Azure Portal ──► AZURE BASTION ──► VM (private IP, RDP/SSH)
                                                      (lives in AzureBastionSubnet)
VM has NO public IP · NO inbound 22/3389 from the internet · session is in the browser.
```

```
✅ Requires a dedicated subnet named EXACTLY "AzureBastionSubnet"
✅ VMs need no public IP and no open RDP/SSH ports to the internet
✅ Access is over TLS in the browser (no local RDP/SSH client needed)
✅ Protects against port-scanning/brute-force on 22/3389
```

---

## 35.3 UI / CLI Steps

```
📍 Add the subnet: VNet → Subnets → "+ Subnet" → name EXACTLY "AzureBastionSubnet"
📍 "Bastions" → "+ Create": name, VNet, Bastion subnet, a Public IP (for Bastion itself) → Create
📍 Connect: VM → "Connect" → "Bastion" → enter username + password (or SSH key) → Connect
   → the VM's desktop/shell opens in a new browser tab
```
```bash
az network bastion create -g production-rg -n my-bastion \
  --vnet-name production-vnet --public-ip-address bastion-pip
```

---

## 35.4 Integration with Other Azure Services

| Service | Role with Bastion |
|---|---|
| **VMs (private IP)** | The targets Bastion connects you to |
| **AzureBastionSubnet** | The dedicated subnet Bastion runs in |
| **Public IP** | Assigned to Bastion itself (not the VMs) |
| **NSGs** | Still control traffic; Bastion removes the need to open 22/3389 publicly |
| **Microsoft Entra ID + RBAC** | Controls who may use Bastion to reach VMs |
| **Hub-and-Spoke** | One Bastion in the hub serves spoke VMs |

---

## 35.5 Real-World Scenario — No-Public-IP Management

```
A company must manage production VMs without exposing RDP/SSH to the internet.
   1. Deploy Azure Bastion in the hub VNet's AzureBastionSubnet (one Bastion for all VMs).
   2. Remove public IPs from the VMs; NSGs no longer need any inbound 22/3389 from Internet.
   3. Admins open the portal → VM → Connect → Bastion → RDP/SSH in the browser over TLS.
   4. RBAC controls which admins can use Bastion to reach which VMs.
Result: zero internet-exposed management ports, no jump box to maintain, and
browser-based access that bots can't brute-force.
```

---

## 35.6 Benefits

- **No public IPs needed** on VMs for management
- **No open 22/3389** to the internet → removes brute-force exposure
- **Browser-based** — RDP/SSH over TLS, no local client
- **Managed** — no jump host to build, patch, or secure yourself
- **Centralized** — one Bastion in a hub can serve many spoke VMs

---

## 35.7 Common Use Cases

- Secure management of production VMs without public IPs
- Replacing self-managed jump/bastion hosts
- Meeting "no exposed RDP/SSH" security/compliance requirements
- Centralized VM access in hub-and-spoke designs

---

## 35.8 Exam Q&A

**Q: What problem does Azure Bastion solve?**
> It lets you RDP/SSH into VMs **without giving them a public IP or opening 22/3389 to the internet** — you connect through the Azure portal over TLS in the browser. This eliminates the brute-force exposure of internet-facing management ports and removes the need to build and maintain your own jump host.

**Q: What subnet does Bastion require, and what's special about it?**
> A dedicated subnet named **exactly** `AzureBastionSubnet` — the name is reserved and must match precisely, or Bastion won't deploy. It's one of several Azure services (along with Firewall and gateways) that need an exact-named dedicated subnet.

**Q: Does the VM need a public IP to connect via Bastion?**
> No — that's the point. The VM uses only its **private IP**, and Bastion (which has the public endpoint) relays your browser session to it over the VNet. You can remove public IPs and close internet-facing 22/3389 entirely.

**Q: How do users connect through Bastion?**
> From the portal: open the VM → **Connect → Bastion**, enter credentials (password or SSH key), and the VM's desktop/shell opens in a browser tab over TLS — no local RDP/SSH client required. RBAC governs who is allowed to do this.

**Q: How does Bastion fit a hub-and-spoke topology?**
> You deploy a single Bastion in the **hub** VNet, and it can serve VMs in peered spoke VNets — so one managed, secured access point covers many workloads instead of a Bastion (or jump host) per VNet.

---

## 35.9 Summary

Azure Bastion provides **secure, browser-based RDP/SSH** to your VMs over **TLS** through the portal, with **no public IP on the VMs** and **no internet-facing 22/3389** — eliminating brute-force exposure and the need for a self-managed jump host. It requires a dedicated subnet named exactly **`AzureBastionSubnet`**, uses its own public IP, and is governed by **RBAC**. Deploy one in a **hub** to serve many spoke VMs — the modern, managed replacement for the classic bastion/jump-host pattern.

[↑ Back to top](#-table-of-contents)

---
---

# 36. 🔍 Network Watcher
> 🟠 MEDIUM
> 📚 Course lectures: 97 (Network Watcher), 98 (Connection Troubleshoot), 100–103 (IP Flow Verify, Next hop, NSG Diagnostic, Flow logs)

---

## 36.1 What Is Network Watcher?

**Network Watcher** is Azure's **suite of network diagnostic and monitoring tools** — it answers "why can't my VM reach X?" by showing exactly where traffic is allowed, blocked, or misrouted.

Think of Network Watcher like a **set of diagnostic instruments for a plumber** — a pressure gauge, a leak detector, a camera snake. Instead of guessing which joint is blocked, you point the right instrument at the pipe and it tells you precisely where and why the water stopped. It turns hours of "is it the network?" guessing into a two-minute, evidence-based answer.

> 💡 **If you know AWS:** Network Watcher is comparable to **VPC Reachability Analyzer + VPC Flow Logs + network troubleshooting tools** combined — a toolkit for diagnosing connectivity and understanding traffic flow.

---

## 36.2 Key Tools (Flow Diagram)

```
NETWORK WATCHER — troubleshooting toolkit
 • IP Flow Verify      → "Is traffic from IP-X to IP-Y on port Z allowed/denied, and by WHICH NSG rule?"
 • Effective Security Rules → the COMBINED effect of all NSG rules on a VM
 • Connection Troubleshoot → live end-to-end test between two points
 • Next Hop            → "where does traffic to IP-X actually go?" (checks routing/UDRs)
 • NSG Flow Logs       → records all traffic through NSGs (feeds Traffic Analytics)
 • Packet Capture      → capture real packets for deep debugging
```

**The most practical tool — IP Flow Verify:**
```
"My app server can't reach the DB on 1433."
   Source=app IP · Destination=DB IP · Port=1433 · Direction=Outbound → Check
   Result: "DENIED by NSG rule 'Deny-All' (priority 4096)"  → you're missing an Allow for 1433.
```

---

## 36.3 UI / CLI Steps

```
📍 Search "Network Watcher" → "IP flow verify":
   VM=app-vm-01, Direction=Outbound, Protocol=TCP, Local IP=app IP,
   Remote IP:port = DB IP : 1433 → "Check" → Allowed/Denied (+ the responsible rule)
📍 "Next hop" → confirm routing · "Connection troubleshoot" → live test ·
   "NSG flow logs" → enable recording to a storage account
```
```bash
az network watcher test-ip-flow -g rg --vm app-vm-01 \
  --direction Outbound --protocol TCP --local "10.0.2.5:12345" --remote "10.0.3.8:1433"
az network watcher show-next-hop -g rg --vm app-vm-01 \
  --source-ip 10.0.2.5 --dest-ip 10.0.3.8
```

---

## 36.4 Integration with Other Azure Services

| Service | Role with Network Watcher |
|---|---|
| **NSG** | IP flow verify / effective rules diagnose NSG decisions |
| **Route Tables (UDR)** | Next hop checks custom routing |
| **Storage / Log Analytics** | Destinations for NSG flow logs |
| **Traffic Analytics** | Visualizes flow-log data |
| **Connection Monitor** | Continuous version of connectivity testing (next topic) |

---

## 36.5 Real-World Scenario — "App Can't Reach the Database"

```
An engineer reports the app server times out connecting to SQL.
   1. IP Flow Verify from app → DB on 1433 (outbound) → "Denied by NSG rule X".
   2. This immediately reveals the app-subnet NSG lacks an Allow rule for 1433 to db-subnet.
   3. (If it had said "Allowed") Next Hop would check whether a UDR is misrouting the
      traffic, or Connection Troubleshoot would run a live end-to-end test.
Result: exact root cause (a missing NSG rule) in minutes, not hours of guessing.
```

---

## 36.6 Benefits

- **Fast root cause** — pinpoints the exact blocking rule or misroute
- **Evidence-based** — replaces guessing with tool output
- **Comprehensive** — rules, routing, live tests, flow logs, packet capture
- **Operational** — directly supports day-to-day troubleshooting
- **Flow visibility** — NSG flow logs + Traffic Analytics for patterns

---

## 36.7 Common Use Cases

- Diagnosing blocked connectivity between tiers
- Verifying NSG/UDR behavior before/after changes
- Recording traffic (flow logs) for security and analysis
- Deep packet-level debugging of tricky issues

---

## 36.8 Exam Q&A

**Q: How would you troubleshoot a VM that can't reach a database?**
> Use **IP Flow Verify** in Network Watcher — specify source, destination, and port, and it instantly tells you whether the traffic is allowed or denied and, if denied, **which NSG rule** is responsible. If it shows allowed, use **Next Hop** to check for routing/UDR issues or **Connection Troubleshoot** for a live end-to-end test.

**Q: What does IP Flow Verify return?**
> "Access Allowed" or "Access Denied" for a specific source/destination/port/direction, and when denied, the **exact NSG rule name and priority** that blocked it. This makes it the single most practical tool for fixing "can't connect" problems quickly.

**Q: Which tool shows the combined effect of subnet and NIC NSGs?**
> **Effective Security Rules** (available via Network Watcher / the NIC), which merges all applicable NSG rules so you see the real, net result rather than reasoning about subnet and NIC rules separately.

**Q: What does the Next Hop tool tell you?**
> Where traffic from a VM toward a given destination will actually go — e.g., to the VNet, an Internet gateway, a peered VNet, or a **virtual appliance** (firewall). It's how you confirm whether a User-Defined Route is sending traffic where you expect.

**Q: What are NSG Flow Logs used for?**
> They record all traffic allowed/denied through an NSG to a storage account (and feed Traffic Analytics), so you can analyze traffic patterns, detect anomalies, support security investigations, and audit what's actually flowing — beyond point-in-time checks.

---

## 36.9 Summary

Network Watcher is Azure's **network troubleshooting toolkit**. Its most practical tool, **IP Flow Verify**, instantly tells you whether traffic between two points on a port is allowed/denied and **which NSG rule** is responsible. Round it out with **Effective Security Rules** (combined NSG effect), **Next Hop** (routing/UDR checks), **Connection Troubleshoot** (live tests), **NSG Flow Logs** (traffic recording), and **Packet Capture** (deep debugging). It turns connectivity guessing into fast, evidence-based diagnosis.

[↑ Back to top](#-table-of-contents)

---
---

# 37. 📡 Connection Monitor
> 🟡 KNOW-THIS-MUCH
> 📚 Course lecture: 99 (Network Watcher — Connection Monitor)

---

## 37.1 What Is Connection Monitor?

**Connection Monitor** (part of Network Watcher) provides **continuous, ongoing monitoring** of connectivity between two points — measuring reachability, latency, and packet loss over time, and alerting you when it degrades.

Think of IP Flow Verify (previous topic) as **taking someone's pulse once**, and Connection Monitor as a **heart-rate monitor worn 24/7**. The one-time check tells you if the connection is OK right now; the continuous monitor watches around the clock and raises an alarm the moment the signal weakens — often before anyone notices.

> 💡 **If you know AWS:** Connection Monitor is loosely like combining AWS reachability/connectivity monitoring with **CloudWatch-style ongoing alerting** on network health — continuous testing plus thresholds, versus a one-off reachability check.

---

## 37.2 How It Works (Flow Diagram)

```
Source (e.g., app-vm) ──test every 30s──► Destination (DB / external URL / endpoint)
        measures continuously:
           • Reachability (up/down)
           • Latency (round-trip time)
           • Packet loss
        ▼
   Feeds Azure Monitor → ALERT if reachability drops or latency/loss crosses a threshold
Runs 24/7 — catches degradation before users do (unlike a one-time check).
```

---

## 37.3 UI Steps

```
📍 Network Watcher → "Connection monitor" → "+ Create":
   Name=app-to-db-monitor, Source=app-vm (or an Azure agent),
   Destination=DB IP:1433 (or an external URL), Test frequency=every 30s,
   configure alert thresholds (reachability < 100%, or latency over a limit) → Create
```

---

## 37.4 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Network Watcher** | Connection Monitor is part of it |
| **Azure Monitor / Alerts** | Thresholds and notifications on results |
| **Log Analytics** | Stores monitoring data for analysis |
| **VMs / endpoints** | Sources and destinations being tested |

---

## 37.5 Real-World Scenario — Critical Dependency Watch

```
A payment app depends on reaching an external payment gateway; if it fails, payments stop.
   1. Connection Monitor from the app servers to the gateway endpoint, testing every 30s.
   2. Alert: if reachability drops or latency spikes above the SLA threshold, page on-call.
   3. During a real gateway outage, Connection Monitor detects the failure within seconds
      and alerts the team — who begin incident response and contact the provider, instead
      of finding out from a flood of customer complaints.
Result: proactive detection of a critical dependency failure and faster response.
```

---

## 37.6 Benefits

- **Proactive** — catches degradation before users complain
- **Continuous** — 24/7 vs a one-time check
- **Rich metrics** — reachability, latency, packet loss over time
- **Alerting** — integrates with Azure Monitor thresholds
- **Dependency assurance** — watch critical links (e.g., to external APIs)

---

## 37.7 Common Use Cases

- Monitoring links to critical external dependencies (payment gateways, APIs)
- Watching app-to-database connectivity over time
- Detecting latency/packet-loss degradation early
- SLA monitoring for network paths

---

## 37.8 Exam Q&A

**Q: What's the difference between IP Flow Verify and Connection Monitor?**
> IP Flow Verify is a **one-time, on-demand** check of whether specific traffic is allowed or denied right now — ideal for troubleshooting a reported issue. Connection Monitor is **continuous** — it tests a connection over time, measuring reachability, latency, and packet loss, and alerts you proactively when connectivity degrades, often before users notice.

**Q: What does Connection Monitor measure?**
> Reachability (is the path up or down), latency (round-trip time), and packet loss between a source and destination, sampled continuously (e.g., every 30 seconds). These metrics flow into Azure Monitor where you set thresholds for alerts.

**Q: When would you choose Connection Monitor over a one-time check?**
> When you need ongoing assurance of a connection's health — such as a critical link to an external payment gateway or a database — so you're alerted the moment it degrades, rather than only being able to confirm status at the instant you happen to run a manual check.

**Q: How does Connection Monitor notify you of problems?**
> It feeds its results into **Azure Monitor**, where you configure alert rules on thresholds (e.g., reachability below 100% or latency above a limit) that trigger notifications or actions — the same alerting pipeline used for other Azure metrics.

---

## 37.9 Summary

Connection Monitor (part of Network Watcher) provides **continuous** monitoring of connectivity between two points — measuring **reachability, latency, and packet loss** over time and alerting via **Azure Monitor** when things degrade. It complements the one-time **IP Flow Verify**: use IP Flow Verify to diagnose a reported problem, and Connection Monitor to continuously watch critical links (like app-to-payment-gateway) and catch failures before users do.

[↑ Back to top](#-table-of-contents)

---
---

# 38. 🧭 User-Defined Routes (UDR)
> 🟠 MEDIUM
> 📚 Course lectures: 104 (User Defined Routes), 105 (Lab)

---

## 38.1 What Is a User-Defined Route?

By default, Azure routes traffic sensibly (within a VNet, and out to the internet for resources with public IPs). A **Route Table** containing **User-Defined Routes (UDRs)** lets you **override** that default routing — most commonly to force all outbound traffic through a security appliance (like **Azure Firewall**) for inspection.

Think of a UDR like **a detour sign the city installs on a road**. Normally cars take the direct route (Azure's default routing), but the detour forces every car through a checkpoint (the firewall) before continuing. Without the sign, cars bypass the checkpoint entirely — so the sign (UDR) is what actually makes traffic go through inspection.

> 💡 **If you know AWS:** A Route Table / UDR is the direct equivalent of an **AWS Route Table** — rules saying "traffic to this destination goes to this next hop." Same concept, same "most specific route wins" (longest prefix match).

---

## 38.2 How Custom Routing Works (Flow Diagram)

```
DEFAULT: app VM's outbound traffic → straight to the internet (hard to inspect)

WITH a UDR forcing traffic through a firewall:
   app-subnet route table:  0.0.0.0/0 → Next hop: Virtual appliance (Azure Firewall 10.0.99.4)
   app VM → wants the internet → routed to the FIREWALL first → inspected/allowed → internet
Now ALL outbound traffic is inspected/controlled centrally.
```

| Route field | Example |
|---|---|
| **Address prefix** | `0.0.0.0/0` (everything — a catch-all) |
| **Next hop type** | Virtual appliance, Internet, VirtualNetwork, VNet Peering, None |
| **Next hop address** | `10.0.99.4` (the firewall's private IP) |

---

## 38.3 UI / CLI Steps

```
📍 "Route tables" → "+ Create" (name=app-subnet-routes) → Create
📍 Open it → "Routes" → "+ Add":
   Route name=force-through-firewall, Address prefix=0.0.0.0/0,
   Next hop type=Virtual appliance, Next hop address=10.0.99.4 → Add
📍 "Subnets" → "+ Associate" → VNet + app-subnet → OK
```
```bash
az network route-table create -g rg -n app-subnet-routes
az network route-table route create -g rg --route-table-name app-subnet-routes \
  -n force-through-firewall --address-prefix 0.0.0.0/0 \
  --next-hop-type VirtualAppliance --next-hop-ip-address 10.0.99.4
```

---

## 38.4 Integration with Other Azure Services

| Service | Role with UDRs |
|---|---|
| **Azure Firewall / NVA** | The next-hop appliance traffic is forced through |
| **Subnets** | Route tables attach to subnets |
| **Hub-and-Spoke** | UDRs send spoke traffic to the hub firewall (peering isn't transitive) |
| **Network Watcher (Next Hop)** | Verify where traffic actually routes |

---

## 38.5 Real-World Scenario — Compliance Egress Inspection

```
A company must inspect and log ALL outbound internet traffic from app servers.
   1. Deploy Azure Firewall into AzureFirewallSubnet.
   2. Create a Route Table with 0.0.0.0/0 → the firewall's private IP.
   3. Attach it to all application subnets.
   4. Now every outbound connection flows through the firewall, which allows only
      approved domains (e.g., *.windowsupdate.com, *.paymentgateway.com) and logs
      everything for the compliance audit trail.
Without the UDR, the firewall would exist but traffic would bypass it — the UDR is
what actually forces traffic through it.
```

---

## 38.6 Benefits

- **Routing control** — override Azure's defaults
- **Centralized inspection** — force traffic through a firewall/NVA
- **Compliance** — guarantee all egress is inspected and logged
- **Hub-and-spoke enabler** — route spoke traffic via the hub
- **Flexible** — per-subnet routes with next-hop choices

---

## 38.7 Common Use Cases

- Forcing outbound traffic through Azure Firewall for inspection/logging
- Routing spoke-to-spoke or internet traffic via a hub (hub-and-spoke)
- Sending traffic to a network virtual appliance (NVA)
- Blocking internet access from a subnet (next hop = None)

---

## 38.8 Exam Q&A

**Q: What is a User-Defined Route and when do you use one?**
> A UDR is a custom routing rule in a Route Table that **overrides Azure's default routing**. The most common use is forcing outbound traffic through a network virtual appliance (like Azure Firewall) for inspection, by adding a `0.0.0.0/0 → the firewall's IP` route and attaching it to a subnet.

**Q: What does a route of "0.0.0.0/0 → Virtual Appliance" achieve?**
> `0.0.0.0/0` matches **all destinations**, so the route redirects every outbound packet to the specified appliance (e.g., a firewall) instead of its default path — ensuring all traffic is inspected/controlled before proceeding to the internet or another network.

**Q: If you deploy Azure Firewall, does traffic automatically go through it?**
> No — deploying the firewall alone doesn't route anything through it. You must add a **UDR** (`0.0.0.0/0 → the firewall's private IP`) on the relevant subnets to force traffic through it. The firewall is the checkpoint; the UDR is the detour sign that sends cars to it.

**Q: Which route wins when multiple routes could match?**
> The **most specific** route (longest prefix match) wins — the same rule as AWS. So a `/32` route for a single IP takes precedence over a `0.0.0.0/0` catch-all for that IP's traffic.

**Q: How do UDRs support a hub-and-spoke topology?**
> Since VNet peering isn't transitive, spokes can't reach each other or route internet traffic through the hub automatically. You add UDRs in the spokes pointing `0.0.0.0/0` (or specific prefixes) to the **hub's firewall** as the next hop, so spoke traffic is centrally inspected and controlled.

---

## 38.9 Summary

A Route Table with **User-Defined Routes (UDRs)** overrides Azure's default routing — most commonly to force outbound traffic from a subnet through **Azure Firewall** (or an NVA) for inspection and logging. A route specifies a destination **prefix** (e.g., `0.0.0.0/0`), a **next hop type/address**, and attaches to one or more subnets; the **most specific route wins**. Remember: deploying a firewall alone doesn't route traffic to it — **the UDR is what forces traffic through it**, and UDRs are essential to hub-and-spoke designs.

[↑ Back to top](#-table-of-contents)

---
---

# 39. ⚖️ Azure Load Balancer
> 🔴 FULL
> 📚 Course lectures: 106 (The Azure Load Balancer Service), 107–109 (Standard SKU Setup/Implementation/Inbound NAT Rules), 110 (Outbound Connectivity), 111–112 (VM Scale Set)

---

## 39.1 What Problem Does This Solve?

A single VM is a single point of failure and a single-performance ceiling. To make an app **highly available** and **scalable**, you run several identical VMs — but clients need **one** address to connect to, and traffic must only go to **healthy** VMs. The **Azure Load Balancer** gives you one frontend IP, spreads incoming connections across a **backend pool** of VMs, and uses **health probes** to stop sending traffic to a VM that's down.

Think of a load balancer like **the host at a busy restaurant with many identical tables**. Guests (clients) all arrive at one door (the frontend IP). The host seats each guest at an open table (distributes connections) and never seats anyone at a table that's being cleaned (an unhealthy VM the probe failed). Guests never need to know which table exists or how many there are.

> 💡 **If you know AWS:** Azure Load Balancer is a **Layer 4 (TCP/UDP)** load balancer — closest to the AWS **Network Load Balancer (NLB)**. For Layer 7 (HTTP path/host routing, WAF, SSL offload) Azure uses **Application Gateway** (≈ AWS ALB). Backend pool ≈ Target Group; health probe ≈ Target Group health check; the **Standard SKU** ≈ the modern NLB with zone-redundancy.

---

## 39.2 How the Load Balancer Works (Flow Diagram)

```
                 Internet client → http://20.40.x.x (Frontend Public IP)
                                        │
                              ┌─────────▼──────────┐
                              │   LOAD BALANCER    │  (Layer 4: TCP/UDP)
                              │  frontend IP:port  │
                              └─────────┬──────────┘
            Health probe (every 5s) ────┤  only healthy VMs receive traffic
                                        │
         ┌──────────────┬──────────────┼──────────────┐
         ▼              ▼               ▼              ▼
     web-vm-1       web-vm-2        web-vm-3       web-vm-4   ← BACKEND POOL
     :80 ✅         :80 ✅          :80 ❌ probe    :80 ✅
                                    fails → removed

Load-balancing RULE ties it together:
   Frontend IP:80  →  Backend pool:80  (using health probe + session persistence)
```

| Component | Purpose |
|---|---|
| **Frontend IP** | The address clients connect to (public or private/internal) |
| **Backend pool** | The set of VMs (or a VM Scale Set) receiving traffic |
| **Health probe** | TCP/HTTP check that marks each VM healthy/unhealthy |
| **Load-balancing rule** | Maps frontend IP:port → backend pool:port |
| **Inbound NAT rule** | Maps frontend port → ONE specific VM (e.g., RDP/SSH to a single node) |
| **Outbound rule** (Standard) | Defines SNAT for backend VMs' outbound internet access |

---

## 39.3 Public vs Internal, and Basic vs Standard SKU

```
PUBLIC Load Balancer      → public frontend IP; balances internet → VMs (web tier)
INTERNAL Load Balancer    → private frontend IP; balances VNet-internal traffic
                            (e.g., web tier → a pool of app/DB servers)
```

| | **Basic SKU** (legacy) | **Standard SKU** (recommended) |
|---|---|---|
| Backend pool size | up to 300 | up to 1000 |
| Availability Zones | ❌ no | ✅ zone-redundant / zonal |
| Health probe | TCP/HTTP | TCP/HTTP/HTTPS |
| Secure by default | open | **closed** — needs an NSG to allow traffic |
| SLA | none | **99.99%** |
| Outbound rules | implicit | explicit, configurable |

⭐ **Standard SKU is closed by default** — you MUST have an NSG allowing the traffic, or the probe/data path fails. This is a classic exam gotcha. The Basic SKU is being retired, so assume Standard.

---

## 39.4 UI / CLI Steps — Build a Standard Public Load Balancer

```
📍 portal.azure.com → "Load balancers" → "+ Create"
   ┌───────────────────────────────────────────────┐
   │ SKU: Standard   Type: Public                    │
   │ Tier: Regional                                  │
   │ Frontend IP: + Add → new Standard Public IP     │
   └───────────────────────────────────────────────┘
    ↓
📍 Backend pools → + Add → select VNet → add web-vm-1..4 (by NIC or IP)
    ↓
📍 Health probes → + Add
   name=http-probe, Protocol=HTTP, Port=80, Path=/ , Interval=5s, Unhealthy threshold=2
    ↓
📍 Load balancing rules → + Add
   name=http-rule, Frontend IP, Port=80, Backend port=80,
   Backend pool=web-pool, Health probe=http-probe,
   Session persistence=None, Idle timeout=4 min
    ↓
📍 Inbound NAT rule (manage ONE VM directly, e.g. RDP to web-vm-1):
   Frontend port=5001 → web-vm-1 : 3389
    ↓
⚠️ NSG on the backend subnet/NIC: allow TCP 80 from Internet (Standard LB is closed!)
    ↓
📍 Browse http://<LB public IP> → refreshes land on different VMs ✅
```

**CLI:**
```bash
az network lb create -g rg -n web-lb --sku Standard \
  --public-ip-address web-lb-pip --frontend-ip-name fe --backend-pool-name web-pool

az network lb probe create -g rg --lb-name web-lb -n http-probe \
  --protocol Http --port 80 --path /

az network lb rule create -g rg --lb-name web-lb -n http-rule \
  --protocol Tcp --frontend-port 80 --backend-port 80 \
  --frontend-ip-name fe --backend-pool-name web-pool --probe-name http-probe

# Inbound NAT to a single VM (SSH to one node via frontend port 5001)
az network lb inbound-nat-rule create -g rg --lb-name web-lb -n ssh-vm1 \
  --protocol Tcp --frontend-port 5001 --backend-port 22 --frontend-ip-name fe
```

---

## 39.5 Integration with Other Azure Services

| Service | Role with Load Balancer |
|---|---|
| **VM Scale Sets** | The ideal backend pool — scales VM instances in/out automatically behind the LB |
| **Availability Zones** | Standard LB is zone-redundant → survives a datacenter failure |
| **NSG** | Required to allow probe + data traffic (Standard LB is closed by default) |
| **Public IP (Standard)** | The zone-redundant frontend for a public LB |
| **Application Gateway** | Used *instead* when you need L7 (URL routing, WAF, SSL offload) |
| **Azure Monitor** | Metrics (data path availability, health probe status, SNAT usage) |

---

## 39.6 Real-World Scenario — Highly Available Web Tier

```
An e-commerce site must stay up during a flash sale and survive a datacenter outage.
   1. Deploy a VM Scale Set of web VMs spread across 3 Availability Zones.
   2. Front them with a Standard (zone-redundant) Public Load Balancer.
   3. HTTP health probe on "/health" → an app crash on one VM removes it in ~10s;
      users never hit the broken node.
   4. Load-balancing rule distributes port 80/443 across all healthy instances.
   5. Autoscale rule: CPU > 70% adds instances; the LB picks them up automatically
      as they pass the probe.
   6. An Inbound NAT rule maps frontend:5001 → one specific VM for admin SSH,
      without exposing SSH on every node.
Result: one stable public IP, traffic only to healthy VMs, automatic scaling,
and zone-level resilience — all with a 99.99% SLA.
```

---

## 39.7 Benefits

- **High availability** — traffic only to healthy VMs; survives VM failures (and zones with Standard)
- **Scalability** — pairs with VM Scale Sets for automatic scale-out
- **Single entry point** — one frontend IP hides the fleet behind it
- **Low latency** — Layer 4 pass-through is extremely fast
- **99.99% SLA** (Standard SKU)
- **Flexible** — public or internal; load-balancing rules + inbound NAT in one resource

---

## 39.8 Common Use Cases

- Distributing internet traffic across a web/VM tier (public LB)
- Balancing internal multi-tier traffic, e.g., web → app/DB pool (internal LB)
- Front end for a VM Scale Set with autoscale
- Providing outbound internet (SNAT) for backend VMs with no public IPs
- Port-forwarding admin access (RDP/SSH) to specific VMs via Inbound NAT rules

---

## 39.9 Exam Q&A

**Q: At which OSI layer does Azure Load Balancer operate, and when would you choose Application Gateway instead?**
> Azure Load Balancer works at **Layer 4 (TCP/UDP)** — it distributes connections without understanding HTTP. Choose **Application Gateway (Layer 7)** when you need HTTP-aware features: URL path-based or host-based routing, SSL/TLS offload, cookie-based session affinity, or a Web Application Firewall. If you only need fast TCP/UDP distribution, the Load Balancer is cheaper and faster.

**Q: A Standard Load Balancer's backend VMs aren't receiving any traffic even though the config looks correct. What's the most likely cause?**
> The **Standard SKU is closed by default**, so without an NSG explicitly allowing the traffic (and the health probe), both the probe and the data path fail. You must add an NSG rule allowing the frontend port from the internet (and allow the `AzureLoadBalancer` service tag for probes). The Basic SKU was open by default, which is why this surprises people migrating.

**Q: What is the role of the health probe, and what happens when a VM fails it?**
> The health probe periodically checks each backend VM (TCP connect, or an HTTP/HTTPS GET to a path). When a VM **fails** the probe for the configured threshold, the LB **stops sending new connections** to it, so clients only reach healthy nodes. When it passes again, it's automatically returned to rotation. This is what turns a pool of VMs into a self-healing, highly available service.

**Q: What is the difference between a load-balancing rule and an inbound NAT rule?**
> A **load-balancing rule** maps a frontend port to a backend pool so traffic is **distributed across many VMs** (e.g., port 80 → all web VMs). An **inbound NAT rule** maps a frontend port to **one specific VM** (e.g., frontend 5001 → web-vm-1:3389 for RDP). Use load-balancing rules for the app's traffic and NAT rules for direct admin access to individual nodes.

**Q: Why would you deploy an internal (private) load balancer rather than a public one?**
> An **internal LB** has a **private** frontend IP and balances traffic that originates **inside the VNet**, such as a web tier calling a pool of application or database servers. It keeps that tier off the internet entirely — only reachable from within the virtual network — which is both more secure and the standard pattern for multi-tier architectures.

**Q: How do you give backend VMs with no public IPs outbound internet access through a Standard Load Balancer?**
> Configure an **outbound rule** (or use the implicit outbound SNAT of a public LB) so the VMs share the LB's public IP for **source NAT** when connecting out. For heavier or more predictable outbound needs, a **NAT Gateway** is preferred because it provides far more SNAT ports and avoids port exhaustion.

---

## 39.10 Summary

The **Azure Load Balancer** is a **Layer 4 (TCP/UDP)** distributor that gives a fleet of VMs **one frontend IP**, spreads connections across a **backend pool**, and uses **health probes** to route only to healthy VMs. Key parts: **frontend IP, backend pool, health probe, load-balancing rule** (many VMs), and **inbound NAT rule** (one VM). Choose **Standard SKU** for zone-redundancy and a **99.99% SLA** — but remember it's **closed by default**, so an **NSG must allow the traffic**. It can be **public** (internet-facing web tier) or **internal** (VNet-internal multi-tier), pairs perfectly with **VM Scale Sets + Availability Zones**, and for HTTP-aware routing you use **Application Gateway** instead.

[↑ Back to top](#-table-of-contents)

---
---

# 40. 🌍 Azure DNS — Fundamentals & Public DNS
> 🟠 MEDIUM
> 📚 Course lectures: 113 (DNS Fundamentals), 114 (DNS name for an Azure VM), 115 (Azure Public DNS)

---

## 40.1 What Problem Does This Solve?

Humans remember names (`www.contoso.com`), but networks route by IP addresses (`20.40.12.5`). **DNS** is the system that translates names → IPs. **Azure DNS** lets you **host your domain's DNS zone in Azure**, so you manage all your records (A, CNAME, MX, TXT…) in the portal/CLI with Azure's global, high-availability name servers — instead of at a third-party registrar's DNS.

Think of DNS like **the phone book / contacts app for the internet**. You look up a person by name ("Contoso Web") and it gives you the number to actually dial (the IP). Azure Public DNS is you **running that phone book yourself** for your own domain, so you control every listing.

> 💡 **If you know AWS:** **Azure DNS (public zone)** is the direct equivalent of **AWS Route 53 (public hosted zone)**. Hosting a zone, delegating via NS records, and record types (A/AAAA/CNAME/MX/TXT/SRV) are identical concepts. Azure's **Alias record** ≈ Route 53's **Alias record** (points at an Azure resource like a Public IP / Traffic Manager and auto-updates). Note: Azure DNS does **not** register domain names — you still buy the domain from a registrar (App Service Domains is the exception).

---

## 40.2 How Name Resolution Works (Flow Diagram)

```
Browser wants www.contoso.com
     │
     ▼
 Recursive resolver (ISP) ── asks the DNS hierarchy ──►
     Root (.) → TLD (.com) → "Who is authoritative for contoso.com?"
                                   │
                                   ▼
                    Registrar has NS records → Azure DNS name servers
                    (ns1-01.azure-dns.com, ns2-01.azure-dns.net, ...)
                                   │
                                   ▼
                         AZURE DNS ZONE "contoso.com"
                         www  A  20.40.12.5   ◄── your record
                                   │
                                   ▼
                      Browser connects to 20.40.12.5 ✅
```

**Delegation** is the key step: at your **registrar** (GoDaddy, Namecheap, etc.) you replace the NS records with the **four Azure name servers** shown on the zone. That's what makes Azure authoritative for your domain.

---

## 40.3 Common Record Types

| Record | Maps | Example |
|---|---|---|
| **A** | name → IPv4 | `www` → `20.40.12.5` |
| **AAAA** | name → IPv6 | `www` → `2603:...` |
| **CNAME** | name → another name (alias) | `shop` → `www.contoso.com` |
| **MX** | mail routing | `@` → `mail.contoso.com` (priority 10) |
| **TXT** | text (SPF, domain verification) | `@` → `"v=spf1 include:..."` |
| **NS** | delegation | subdomain → name servers |
| **SRV** | service location | `_sip._tcp` → host:port |
| **Alias** (A/AAAA/CNAME) | → an Azure resource | `@` → a Standard Public IP / Traffic Manager / CDN |

⭐ **Alias records** are special: they point to an **Azure resource** rather than a hard-coded IP, so if that resource's IP changes the DNS updates automatically. They can also sit at the **zone apex** (`@`), which a plain CNAME cannot.

---

## 40.4 UI / CLI Steps — Host a Public Zone & Delegate

```
📍 portal.azure.com → "DNS zones" → "+ Create"
   Name = contoso.com → Create
    ↓
📍 Open the zone → copy the 4 NS name servers (ns1-..azure-dns.com, etc.)
    ↓
📍 At your REGISTRAR's site → replace the domain's name servers with the 4 Azure ones
    (propagation can take minutes to 48h)
    ↓
📍 Back in the zone → "+ Record set"
   Name=www  Type=A  TTL=3600  IP=20.40.12.5 → OK
   Name=@    Type=A (Alias) → Azure resource → your Standard Public IP → OK
    ↓
📍 Test:  nslookup www.contoso.com   → returns 20.40.12.5 ✅
```

**CLI:**
```bash
az network dns zone create -g rg -n contoso.com
# (copy the nameServers from the output → set them at your registrar)

az network dns record-set a add-record -g rg -z contoso.com \
  -n www -a 20.40.12.5

# Alias A record at the apex pointing to a Public IP resource
az network dns record-set a create -g rg -z contoso.com -n "@" \
  --target-resource "/subscriptions/.../publicIPAddresses/web-pip"
```

### 40.4b DNS name for a single VM (lecture 114)
A VM's public IP can get a free Azure-provided label: `myvm.centralindia.cloudapp.azure.com`.
```
📍 VM → Public IP → Configuration → DNS name label = myvm → Save
   Now reachable by name even if the IP changes (within that region).
```

---

## 40.5 Integration with Other Azure Services

| Service | Role with Azure DNS |
|---|---|
| **Public IP / Load Balancer** | Alias A record points the domain at the app's public IP |
| **App Service** | Custom domain validation uses CNAME/TXT records here |
| **Traffic Manager** | Alias record targets a Traffic Manager profile for global routing |
| **Azure CDN / Front Door** | Alias records map the apex/subdomain to the endpoint |
| **App Service Domains** | The one way to actually *buy* a domain inside Azure |

---

## 40.6 Real-World Scenario — Launching a Company Website

```
Contoso bought contoso.com at a registrar and hosts their site on Azure VMs behind
a Standard Public Load Balancer.
   1. Create a public DNS zone "contoso.com" in Azure.
   2. Delegate: set the registrar's NS records to the 4 Azure name servers.
   3. Apex (@) → Alias A record → the Load Balancer's Standard Public IP
      (Alias so it auto-tracks the IP and works at the apex).
   4. www → CNAME → contoso.com  (or its own Alias A).
   5. MX records → their Microsoft 365 mail servers; TXT → SPF/DKIM + domain verification.
Now contoso.com and www.contoso.com resolve to the site, mail routes correctly, and
if the Load Balancer IP ever changes the Alias record updates automatically.
```

---

## 40.7 Benefits

- **Full control** of all records in the Azure portal/CLI/ARM
- **Global, high-availability** anycast name servers (100% SLA for queries)
- **Alias records** auto-track Azure resources and work at the zone apex
- **Unified management** — DNS lives with the rest of your Azure resources (RBAC, locks, tags)
- **Fast, programmable** record changes via CLI/PowerShell/IaC

---

## 40.8 Common Use Cases

- Hosting a company's public domain records in Azure
- Pointing a custom domain at an Azure web app / load balancer / CDN
- Managing MX/TXT records for email (M365) and domain verification
- Apex-domain mapping to an Azure endpoint via Alias records
- Giving a VM a friendly, region-stable DNS name label

---

## 40.9 Exam Q&A

**Q: What must you do at your domain registrar to make Azure DNS authoritative for your domain?**
> You must **delegate** the domain by replacing the registrar's **NS (name server) records** with the **four Azure name servers** listed on the Azure DNS zone. Until that delegation is done, Azure's records are ignored because the internet still asks the old name servers. This is the single most important step when moving a zone to Azure.

**Q: You need the zone apex (contoso.com, "@") to point at an Azure Public IP. Why can't you use a CNAME, and what do you use instead?**
> A **CNAME is not allowed at the zone apex** (DNS rules forbid a CNAME coexisting with the required SOA/NS records there). You use an **Alias A record**, which points directly at the Azure resource (Public IP, Traffic Manager, Front Door), works at the apex, and automatically updates if the resource's IP changes.

**Q: What is the advantage of an Alias record over a standard A record?**
> A standard A record stores a **hard-coded IP**, so if the underlying Azure resource's IP changes you must manually update it. An **Alias record references the Azure resource itself**, so DNS always resolves to the resource's current IP automatically — no manual maintenance, and it can also prevent dangling records if the resource is deleted.

**Q: Does Azure DNS let you register/buy a new domain name?**
> No — **Azure DNS hosts and manages records** for a domain you already own; you still purchase the domain from a registrar. The only way to buy a domain within Azure is **App Service Domains**, which registers the domain (via a partner) and can auto-create the DNS zone.

**Q: A record change isn't taking effect for some users. What DNS concept explains this?**
> **TTL (Time To Live)** and caching — resolvers cache a record for its TTL, so old values persist until it expires. Lowering the TTL *before* a planned change reduces this window. Right after delegating a new zone, propagation of the NS change can also take up to ~48 hours.

---

## 40.10 Summary

**DNS** translates names to IPs, and **Azure Public DNS** lets you host your domain's zone on Azure's global, highly available name servers. The critical step is **delegation** — pointing your registrar's **NS records** at the four Azure name servers so Azure becomes authoritative. You then manage record sets (**A, AAAA, CNAME, MX, TXT, SRV, NS**). Use **Alias records** to point at Azure resources (Public IP, Traffic Manager, Front Door) because they **work at the zone apex** and **auto-update** when the resource's IP changes. Azure DNS **hosts** records but does **not register** domains (that's App Service Domains), and remember **TTL** governs how long changes take to appear.

[↑ Back to top](#-table-of-contents)

---
---

# 41. 🏠 Azure DNS — Private DNS
> 🟠 MEDIUM
> 📚 Course lectures: 116 (Designing a Private DNS Foundation), 117–118 (AD DS/DNS lab & local resolution), 119 (Azure Private DNS), 120 (Lab - Azure Private DNS)

---

## 41.1 What Problem Does This Solve?

Inside a VNet, resources often need to find each other by **name** rather than by private IP (which can change). Public DNS can't resolve private, internal names — and you don't want internal hostnames exposed to the internet anyway. **Azure Private DNS** provides **name resolution within and between VNets** for your own private domain (e.g., `internal.contoso.com`), with **automatic registration** of VM records, without you running any DNS server.

Think of Private DNS like **an internal company directory that only staff can see**. Outsiders (the public internet) can't look anyone up, but inside the building everyone can find "db-server" or "app-vm-3" by name — and when a new employee joins, they're added to the directory automatically.

> 💡 **If you know AWS:** Azure **Private DNS zone** ≈ a **Route 53 Private Hosted Zone** associated with a VPC. Linking a VNet with **auto-registration on** is like Route 53's VPC DNS auto-registering instance records. The alternative — running your own **AD DS + DNS on a Windows VM** (lectures 117–118) — mirrors running a self-managed DNS server on EC2.

---

## 41.2 Private DNS Architecture (Flow Diagram)

```
                 Private DNS Zone:  internal.contoso.com
                 ┌───────────────────────────────────────┐
                 │  app-vm   A   10.0.1.4   (auto-added)   │
                 │  db-vm    A   10.0.2.5   (auto-added)   │
                 └───────────────────┬───────────────────┘
          VNet links (one per VNet)  │
          ┌────────────────┬─────────┴────────────┐
          ▼                ▼                       ▼
    VNet-Hub          VNet-Spoke1             VNet-Spoke2
   (registration    (resolution only)       (resolution only)
    link: auto-adds                          
    its VMs)

Inside any linked VNet:
   app-vm pings  db-vm.internal.contoso.com  → resolves to 10.0.2.5 ✅
   (no public exposure, no DNS server to manage)
```

| Concept | Meaning |
|---|---|
| **Private DNS zone** | Your internal domain (e.g., `internal.contoso.com`) |
| **Virtual network link** | Connects a VNet to the zone so its VMs can resolve names |
| **Auto-registration** | On a link, Azure auto-creates/removes A records for VMs in that VNet |
| **Resolution-only link** | VNet can resolve names but its VMs aren't auto-registered |
| **168.63.129.16** | Azure's internal DNS resolver IP (the "magic" platform address) |

⭐ **Only ONE** VNet link per zone can have **auto-registration** enabled... per VNet (each VNet links once); a VNet can't be registration-linked to two zones. Spokes typically use **resolution-only** links.

---

## 41.3 Private DNS vs Private Endpoint DNS

```
A very common real use of Private DNS zones is with PRIVATE ENDPOINTS:
   When you give a PaaS service (Storage, SQL) a private endpoint, its public
   FQDN must resolve to the PRIVATE IP inside your VNet.
   Azure uses a special zone like  privatelink.blob.core.windows.net
   linked to your VNet, so  mystorage.blob.core.windows.net → 10.0.3.4 (private).
(See Topic 61 — Private Endpoints.)
```

---

## 41.4 UI / CLI Steps — Create & Link a Private Zone

```
📍 portal.azure.com → "Private DNS zones" → "+ Create"
   Name = internal.contoso.com → Create
    ↓
📍 Open the zone → "Virtual network links" → "+ Add"
   Link name = hub-link, VNet = VNet-Hub,
   ☑ Enable auto registration  → OK
    ↓
📍 Add another link for a spoke:
   Link name = spoke1-link, VNet = VNet-Spoke1,  ☐ auto registration OFF (resolution only)
    ↓
📍 (Optional) manual record:  + Record set → db  A  10.0.2.5
    ↓
📍 Test from a VM in a linked VNet:
   nslookup app-vm.internal.contoso.com  → 10.0.1.4 ✅
```

**CLI:**
```bash
az network private-dns zone create -g rg -n internal.contoso.com

az network private-dns link vnet create -g rg -z internal.contoso.com \
  -n hub-link -v VNet-Hub --registration-enabled true

az network private-dns link vnet create -g rg -z internal.contoso.com \
  -n spoke1-link -v VNet-Spoke1 --registration-enabled false
```

---

## 41.5 Integration with Other Azure Services

| Service | Role with Private DNS |
|---|---|
| **Private Endpoints** | `privatelink.*` zones resolve PaaS FQDNs to private IPs |
| **Virtual Networks** | Linked to the zone; VMs resolve/auto-register names |
| **VNet Peering / Hub-Spoke** | One central zone linked to many VNets for shared resolution |
| **VM Scale Sets** | Instances auto-register in the zone as they scale |
| **AD DS on a VM** | Alternative/complement: custom DNS server set on the VNet |

---

## 41.6 Real-World Scenario — Internal Multi-Tier App Naming

```
A 3-tier app (web, app, db) spread across a hub and two spoke VNets needs stable
internal names so config files don't hard-code IPs.
   1. Create private zone "corp.internal".
   2. Link the hub VNet WITH auto-registration (its VMs register automatically).
   3. Link both spoke VNets as resolution-only.
   4. App config references db.corp.internal instead of 10.0.2.5.
   5. When the DB VM is rebuilt and gets a new IP, its record auto-updates — the app
      keeps working with no config change.
   6. The same VNet is linked to privatelink.database.windows.net so the app reaches
      Azure SQL over a private endpoint by its normal FQDN.
Nothing is exposed publicly, and there's no DNS server VM to patch or back up.
```

---

## 41.7 Benefits

- **No DNS server to manage** — fully managed, no VM to patch/back up
- **Automatic VM registration** — records created/removed as VMs come and go
- **Private & secure** — internal names never exposed to the internet
- **Cross-VNet resolution** — one zone shared across hub + spokes
- **Private Endpoint enabler** — makes PaaS services resolve to private IPs
- **Stable naming** — apps reference names, not changeable IPs

---

## 41.8 Common Use Cases

- Internal name resolution for multi-tier apps across VNets
- Auto-registering VM/scale-set records in a hub-and-spoke network
- Resolving Private Endpoint FQDNs to private IPs (`privatelink.*` zones)
- Replacing hard-coded private IPs in app configuration with stable names
- Shared internal DNS without deploying/maintaining a DNS server

---

## 41.9 Exam Q&A

**Q: What is the difference between an Azure *public* DNS zone and a *private* DNS zone?**
> A **public zone** answers queries from the **internet** and is used for your externally reachable domain (delegated via NS records at a registrar). A **private zone** resolves names **only inside the VNets you link to it** — it's for internal hostnames (e.g., `db.corp.internal`) and is never reachable from the internet, so it needs no delegation.

**Q: What does enabling "auto-registration" on a virtual network link do?**
> With **auto-registration on**, Azure automatically **creates an A record** for every VM in that linked VNet (and removes it when the VM is deleted), keeping the zone in sync without manual effort. A VNet can have auto-registration for **only one** private zone, so typically the primary/hub VNet uses registration and other VNets link as **resolution-only**.

**Q: You linked a VNet to a private DNS zone but VMs still can't resolve the names. What's a likely cause?**
> The VNet is likely **not linked** to that zone (or linked as resolution-only when you expected auto-registration), or the VM is using a **custom DNS server** on the VNet that doesn't forward to Azure's resolver (**168.63.129.16**). Azure Private DNS only works for VNets explicitly linked to the zone and using Azure-provided DNS (or a custom server configured to forward to it).

**Q: How are private DNS zones used with Private Endpoints?**
> When you create a Private Endpoint for a PaaS service, its **public FQDN must resolve to the private IP** inside your VNet. Azure uses a dedicated zone such as **`privatelink.blob.core.windows.net`**, linked to your VNet, so the service's normal hostname resolves to the endpoint's **private** IP for in-VNet clients while remaining unchanged for code — no app changes needed.

**Q: When would you run AD DS/DNS on a Windows VM instead of using Azure Private DNS?**
> When you need **full Active Directory domain services** (domain join, Group Policy, Kerberos) or advanced DNS features (conditional forwarders, zone transfers, integration with on-premises AD). Azure Private DNS handles **name resolution** elegantly but isn't a domain controller; for AD-dependent workloads you deploy **AD DS + DNS** on a VM (or use **Microsoft Entra Domain Services**) and set it as the VNet's custom DNS.

---

## 41.10 Summary

**Azure Private DNS** provides managed **internal name resolution** inside and across VNets for your own private domain, with **no DNS server to run**. You create a **private zone** (e.g., `corp.internal`), then add a **virtual network link** per VNet — enabling **auto-registration** on the primary VNet so VM records are created/removed automatically, and using **resolution-only** links elsewhere. It keeps internal names **off the public internet**, lets apps reference **stable names instead of changeable IPs**, and is the mechanism behind **Private Endpoint** DNS (`privatelink.*` zones resolving PaaS FQDNs to private IPs). For full Active Directory, you'd instead run **AD DS + DNS** on a VM; for pure name resolution, Private DNS is simpler and fully managed.

[↑ Back to top](#-table-of-contents)

---
---

# 42. 🔌 Web App VNet Integration & Custom Domains
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 121 (Web App VNet Integration), 122–124 (Lab: DB server / App setup / Implementation), 125 (Custom domain names)

---

## 42.1 What Problem Does This Solve?

An **App Service** web app runs on a shared, Microsoft-managed platform — by default it has **no footprint in your VNet**, so it can't reach private resources (a database VM, a private endpoint) using private IPs. **VNet Integration** gives the web app an **outbound** path into your VNet. Separately, apps are born with an ugly `*.azurewebsites.net` address — **Custom Domains** let you present `www.contoso.com` instead (with a TLS certificate).

Think of VNet Integration like **giving a remote contractor a badge to walk into your private office** — they still work from their own building (the App Service platform), but now they can enter your facility to reach internal systems. A custom domain is like **putting your company name on the door** instead of the generic building number.

> 💡 **If you know AWS:** App Service **VNet Integration** ≈ attaching a **Lambda/managed service to a VPC** for outbound access to private subnets. It's **outbound only** — for *inbound* private access you'd use a **Private Endpoint** (≈ VPC endpoint / PrivateLink to the app). Custom domain + managed certificate ≈ Route 53 CNAME + ACM certificate on an app.

---

## 42.2 Inbound vs Outbound — Two Different Features (Flow Diagram)

```
OUTBOUND (VNet Integration):  web app ──► into VNet ──► DB VM / private endpoint
   "The app needs to CALL private resources."

INBOUND (Private Endpoint):   clients in VNet ──► private IP ──► web app
   "Private clients need to REACH the app without going over the internet."

                 ┌───────────────── App Service ─────────────────┐
  Internet ─────►│  myapp.azurewebsites.net   (public inbound)    │
                 │        │ VNet Integration (outbound)            │
                 └────────┼───────────────────────────────────────┘
                          ▼
                 Delegated subnet in your VNet
                          │
                 ┌────────┴─────────┐
                 ▼                  ▼
            db-vm (10.0.2.5)   Storage private endpoint
```

⚠️ **Exam trap:** VNet Integration is **outbound only**. It does **not** let VNet clients reach the app privately — that's a **Private Endpoint**.

---

## 42.3 Key Facts

| Feature | Detail |
|---|---|
| **Requires** | Standard/Premium App Service plan (not Free/Shared) |
| **Dedicated subnet** | VNet Integration needs an **empty, delegated** subnet (`Microsoft.Web`) |
| **Direction** | Outbound from app → VNet resources |
| **Custom domain requires** | DNS validation (CNAME/TXT) + a verified ownership record |
| **TLS cert options** | App Service Managed Certificate (free), or upload/Key Vault cert |
| **Apex domain** | Use an **A record (to the app's inbound IP) + TXT**, or Azure DNS Alias |

---

## 42.4 UI / CLI Steps

```
── VNet Integration ──
📍 App Service → "Networking" → "Virtual network integration" → "+ Add"
   Select VNet → select/create an EMPTY delegated subnet → Connect
    ↓
   App can now reach db-vm.internal / private endpoints by private IP.

── Custom domain ──
📍 App Service → "Custom domains" → "+ Add custom domain"
   Enter www.contoso.com → Azure shows the CNAME + TXT to create
    ↓
📍 In Azure DNS (or registrar): add
   www  CNAME  myapp.azurewebsites.net
   asuid.www  TXT  <verification id>
    ↓
📍 Validate → Add → then "Add binding" → App Service Managed Certificate → Create
   → HTTPS on www.contoso.com ✅
```

```bash
az webapp vnet-integration add -g rg -n myapp --vnet VNet-Hub --subnet app-integration-subnet
az webapp config hostname add -g rg --webapp-name myapp --hostname www.contoso.com
az webapp config ssl create -g rg --name myapp --hostname www.contoso.com   # managed cert
```

---

## 42.5 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Azure SQL / DB VM** | The private backend the web app reaches via VNet Integration |
| **Private Endpoints** | App reaches PaaS privately; or exposes the app privately (inbound) |
| **Azure DNS** | Hosts the CNAME/TXT/A records that validate and route the custom domain |
| **Key Vault** | Stores the TLS certificate bound to the custom domain |
| **NSG / UDR** | Control traffic from the integration subnet onward |

---

## 42.6 Real-World Scenario — Public Web App, Private Database

```
A SaaS web app must be public but its database must NOT be exposed to the internet.
   1. Deploy the app on a Standard App Service plan.
   2. Enable VNet Integration to an empty delegated subnet in the app's VNet.
   3. The database (Azure SQL) has a Private Endpoint in that VNet; link the
      privatelink DNS zone so the app resolves it to a private IP.
   4. The app now connects to the DB over the private network — the DB firewall
      denies all public access.
   5. Add custom domain app.contoso.com with a managed TLS certificate for a
      professional, secure public URL.
Result: public front door on a branded HTTPS domain, private-only backend.
```

---

## 42.7 Benefits

- **Private backend access** — reach VMs/PaaS privately without public exposure
- **Security** — keep databases and internal APIs off the internet
- **Professional branding** — custom domain instead of `*.azurewebsites.net`
- **Free managed TLS** — App Service Managed Certificates auto-renew
- **No infra to manage** — stays PaaS; no gateway VM required

---

## 42.8 Common Use Cases

- Web app connecting to a private database or internal API
- Reaching PaaS services (Storage, SQL) via private endpoints from an app
- Branding a web app with a company domain + HTTPS
- Hybrid apps calling on-premises systems via the VNet (S2S VPN/ExpressRoute)

---

## 42.9 Exam Q&A

**Q: A web app needs to connect to a database VM using its private IP. Which feature do you enable, and what's its direction?**
> Enable **VNet Integration**, which gives the app an **outbound** path into the VNet so it can reach private resources by private IP. It is **outbound only** — it lets the app *call into* the VNet, not the VNet call into the app. It also requires a Standard/Premium plan and an empty, delegated subnet.

**Q: Clients inside your VNet must reach the web app over a private IP (never the internet). Is VNet Integration the answer?**
> No. VNet Integration is **outbound**. To make the app reachable **privately (inbound)** from the VNet you create a **Private Endpoint** for the app, which gives it a private IP in your subnet. The two features are complementary and often used together — Private Endpoint for inbound, VNet Integration for outbound.

**Q: What DNS records are typically required to add and validate a custom domain on App Service?**
> A **CNAME** (e.g., `www` → `myapp.azurewebsites.net`) to route traffic, plus a **TXT** record (e.g., `asuid.www`) that Azure checks to **verify you own the domain**. For an apex/root domain you use an **A record** to the app's inbound IP (plus the TXT), or an **Alias** record in Azure DNS. After validation you bind a TLS certificate.

**Q: What are the certificate options for securing a custom domain, and which is easiest?**
> You can use a **free App Service Managed Certificate** (auto-issued and auto-renewed — the easiest), **import a certificate from Key Vault**, or **upload** your own PFX. The managed certificate is the simplest for standard subdomains and removes renewal maintenance, making it the common choice on the exam.

**Q: Why does VNet Integration require a dedicated, empty subnet?**
> App Service **delegates** the subnet to `Microsoft.Web` and uses its address space to route the app's outbound traffic into the VNet; it must be **empty and delegated** so Azure can manage it exclusively. Sizing the subnet appropriately matters because scaling the plan consumes addresses from it.

---

## 42.10 Summary

**VNet Integration** gives an App Service web app an **outbound** path into your VNet (requiring a Standard/Premium plan and an **empty, delegated subnet**), so it can reach private resources like databases and private endpoints by private IP. It is **outbound only** — making the app reachable **privately inbound** requires a **Private Endpoint** instead. **Custom Domains** replace `*.azurewebsites.net` with your own domain, validated via **CNAME + TXT** records (A record/Alias for the apex) and secured with a **free App Service Managed Certificate** or a Key Vault/uploaded cert. Together they deliver a branded, HTTPS public front end with a private, protected backend.

[↑ Back to top](#-table-of-contents)

---
---

# 43. 📦 Azure Storage Accounts & Types
> 🔴 FULL
> 📚 Course lectures: 127 (Introduction to Storage Accounts), 128 (Different types of storage accounts), 129 (Lab - Creating a storage account)

---

## 43.1 What Problem Does This Solve?

Applications need somewhere durable, scalable, and cheap to keep data — files, backups, logs, images, queues of messages, tables of records. A **Storage Account** is the top-level Azure container that bundles four data services (**Blob, File, Queue, Table**) under one namespace, one set of access keys, and one set of settings for redundancy, performance, security, and networking. Choosing the right **account type/kind** and **performance tier** decides what the account can do and what it costs.

Think of a Storage Account like **a single bank branch** that offers several products at one address: a safe-deposit vault (Blobs), shared filing cabinets (File shares), an in/out mail tray (Queues), and a ledger of records (Tables). You open **one** account (with one set of keys and policies), then use whichever services you need.

> 💡 **If you know AWS:** There's no single AWS equivalent — a Storage Account groups what AWS splits across services: **Blob ≈ S3**, **File ≈ EFS/FSx (SMB/NFS)**, **Queue ≈ SQS**, **Table ≈ DynamoDB (basic)**. The account is a management/billing/security boundary (like an S3-account-level config plus shared keys). The **globally unique account name** becomes the DNS prefix: `mystorage.blob.core.windows.net`.

---

## 43.2 The Four Services Under One Account (Flow Diagram)

```
                 Storage Account:  mystorageacct   (globally unique name)
                 ┌───────────────────────────────────────────────────────┐
                 │  🗄️  BLOB  → unstructured objects (files, images, backups)│
                 │        mystorageacct.blob.core.windows.net              │
                 │  📁  FILE  → SMB/NFS file shares (lift-and-shift, shares) │
                 │        mystorageacct.file.core.windows.net              │
                 │  📨  QUEUE → messages between app components              │
                 │        mystorageacct.queue.core.windows.net             │
                 │  🗂️  TABLE → NoSQL key-value records                     │
                 │        mystorageacct.table.core.windows.net             │
                 └───────────────────────────────────────────────────────┘
          Shared across all four:  access keys · redundancy · firewall · identity
```

---

## 43.3 Account Kinds & Performance Tiers

```
RECOMMENDED kind for almost everything:  StorageV2 (general-purpose v2)
   → supports all services, all tiers (Hot/Cool/Cold/Archive), all redundancy.

Legacy/niche:
   • General-purpose v1  → older, fewer features (upgrade to V2)
   • BlobStorage         → blobs only (superseded by V2)
   • Premium kinds       → specialized: Premium Block Blobs, Premium File Shares,
                           Premium Page Blobs (for unmanaged disks)
```

| Performance tier | Backed by | Use for |
|---|---|---|
| **Standard** | HDD-based, lower cost | General data, backups, logs, infrequent access |
| **Premium** | SSD-based, low latency, high IOPS | Transaction-heavy workloads, large-scale/real-time apps; chosen **per service kind** (block blob / file / page blob) |

| Setting chosen at creation | Options |
|---|---|
| **Kind** | StorageV2 (default), premium variants |
| **Performance** | Standard / Premium |
| **Redundancy** | LRS, ZRS, GRS, GZRS, RA-GRS, RA-GZRS (Topic 47) |
| **Access tier (default)** | Hot / Cool (blob-level override later) |

---

## 43.4 UI / CLI Steps — Create a Storage Account

```
📍 portal.azure.com → "Storage accounts" → "+ Create"
   ┌──────────────────────────────────────────────────────────┐
   │ Resource group:  storage-rg                                │
   │ Name:            mystorageacct2026  (3–24 chars, lowercase │
   │                   + numbers, GLOBALLY unique)              │
   │ Region:          Central India                             │
   │ Performance:     Standard                                  │
   │ Redundancy:      LRS (cheapest) / GRS (geo)                │
   └──────────────────────────────────────────────────────────┘
    ↓
   Advanced:  ☑ Require secure transfer (HTTPS)   Min TLS 1.2
   Networking: public / selected networks / private endpoint
   Data protection: soft delete, versioning, point-in-time restore
    ↓
   Review + Create → Create
    ↓
📍 Open it → see Containers / File shares / Queues / Tables in the left menu
   Access keys → key1, key2 + connection strings
```

**CLI:**
```bash
az storage account create -g storage-rg -n mystorageacct2026 \
  --location centralindia --sku Standard_LRS --kind StorageV2 \
  --min-tls-version TLS1_2 --https-only true

az storage account show -g storage-rg -n mystorageacct2026 --query primaryEndpoints
az storage account keys list -g storage-rg -n mystorageacct2026 -o table
```

---

## 43.5 Integration with Other Azure Services

| Service | How it uses the Storage Account |
|---|---|
| **Virtual Machines** | Boot diagnostics, unmanaged disks (page blobs), file shares |
| **Azure Backup / Site Recovery** | Stores recovery data (via vaults) |
| **Azure Functions / App Service** | Requires a storage account for state, triggers, logs |
| **Azure Monitor / Log storage** | Archive diagnostic logs and metrics |
| **Key Vault + Managed Identity** | Keyless, RBAC-based (Entra) access to blobs/files |
| **Private Endpoints / Service Endpoints** | Lock storage to specific VNets |
| **CDN / Front Door** | Cache and serve blob content globally |

---

## 43.6 Real-World Scenario — Central Data Platform for an App

```
A media company needs one storage foundation for a new app.
   1. Create a StorageV2 account, Standard performance, GZRS redundancy
      (geo + zone resilience) with HTTPS-only + TLS 1.2 enforced.
   2. BLOB: user-uploaded videos/images (Hot tier), old content lifecycled to Cool/Archive.
   3. FILE: an SMB share for the content team to drop assets.
   4. QUEUE: upload events queued for a transcoding worker to process.
   5. TABLE: lightweight metadata (upload id, owner, status).
   6. Security: disable account-key access where possible, use Entra RBAC +
      managed identities; restrict networking to the app's VNet via a private endpoint.
Result: one governed, redundant, secure account serving four data needs with
consistent policies and billing.
```

---

## 43.7 Benefits

- **Unified** — four data services, one account, one set of policies/keys
- **Massively scalable & durable** — designed for huge capacity and high durability
- **Flexible redundancy** — from cheap LRS to geo+zone GZRS
- **Cost control** — access tiers + lifecycle rules (blobs)
- **Secure** — HTTPS-only, TLS floor, firewall/VNet rules, Entra RBAC, private endpoints
- **Globally accessible** — REST endpoints, SDKs, CLI, Storage Explorer

---

## 43.8 Common Use Cases

- Object storage for app content, backups, logs, and static website hosting (Blob)
- Shared file storage / lift-and-shift of on-prem shares (File)
- Decoupling app components with messaging (Queue)
- Simple NoSQL metadata storage (Table)
- Required backing store for VMs, Functions, and other Azure services

---

## 43.9 Exam Q&A

**Q: Which storage account kind should you choose for a new general-purpose deployment, and why?**
> **StorageV2 (general-purpose v2)** — it supports **all four services**, **all access tiers** (Hot/Cool/Cold/Archive), and **all redundancy options**, with the latest features and pricing. V1 and BlobStorage are legacy; V2 is the default recommendation for essentially every new account unless you specifically need a Premium variant for low-latency SSD performance.

**Q: What makes a storage account name special, and what are its rules?**
> The account name must be **globally unique across all of Azure** because it becomes the **DNS label** in the service endpoints (e.g., `name.blob.core.windows.net`). It must be **3–24 characters, lowercase letters and numbers only**. Uniqueness and DNS-safety are why you can't reuse a name another tenant already took.

**Q: What's the difference between Standard and Premium performance tiers?**
> **Standard** uses HDD-backed storage — lower cost, suited to general data, backups, and infrequent access. **Premium** uses **SSD-backed** storage for **low latency and high IOPS/throughput**, chosen **per service kind** (Premium Block Blobs, Premium File Shares, or Premium Page Blobs). You pick Premium for transaction-intensive or latency-sensitive workloads and accept the higher price.

**Q: Which four services does a storage account provide, and what is each for?**
> **Blob** (unstructured objects — files, images, backups), **File** (SMB/NFS file shares), **Queue** (messages to decouple app components), and **Table** (simple NoSQL key-value records). They share the account's keys, redundancy, networking, and security settings, which is why the account is the management and billing boundary.

**Q: How can you access a storage account without using its access keys?**
> Use **Microsoft Entra ID with RBAC** (e.g., assign *Storage Blob Data Contributor*) combined with a **managed identity** or user principal — this is **keyless**, auditable, and avoids distributing shared secrets. You can even **disable shared-key access** on the account to force Entra-based authorization, which is the recommended security posture.

---

## 43.10 Summary

A **Storage Account** is the top-level container bundling **Blob, File, Queue, and Table** services under one globally unique, DNS-based name, with shared **keys, redundancy, networking, and security** settings. Use **StorageV2 (general-purpose v2)** for almost everything — it supports all services, tiers, and redundancy. Pick **Standard** (HDD) for general data or **Premium** (SSD) for low-latency, high-IOPS workloads. Names are **3–24 lowercase alphanumeric characters, globally unique**. Secure it with **HTTPS-only, TLS 1.2, firewall/VNet rules, private endpoints**, and prefer **Entra RBAC + managed identities** over access keys. It's the foundational data service many other Azure services depend on.

[↑ Back to top](#-table-of-contents)

---
---

# 44. 🗄️ Azure Blob Service
> 🔴 FULL
> 📚 Course lectures: 130 (Azure Blob service), 131 (Lab - Uploading objects), 132 (Lab - Accessing objects)

---

## 44.1 What Problem Does This Solve?

Most application data is **unstructured** — images, videos, documents, backups, logs, installers. The **Blob (Binary Large Object) service** stores massive amounts of this data cheaply and durably, organized into **containers**, each holding **blobs** accessed by URL over HTTP(S). It's Azure's answer to "where do I put files at any scale?" — the storage behind static websites, media apps, data lakes, and backup targets.

Think of the Blob service like **an infinitely large online drive/bucket**. You create folders (**containers**), drop files (**blobs**) into them, and each file gets a web address you can read from (and secure). You never worry about disks filling up — it scales for you.

> 💡 **If you know AWS:** The Blob service is **Amazon S3**. A **container ≈ an S3 bucket (per-account)**, a **blob ≈ an S3 object**, and the blob URL ≈ the S3 object URL. **Block blobs ≈ standard S3 objects**. Access tiers (Hot/Cool/Cold/Archive) ≈ S3 Standard/Standard-IA/Glacier. One difference: in Azure the globally unique **account** is the DNS root and containers live beneath it (`account.blob.core.windows.net/container/blob`).

---

## 44.2 Blob Structure & Types (Flow Diagram)

```
Storage Account:  mystorageacct.blob.core.windows.net
   │
   ├── container: images          (access level: Private / Blob / Container)
   │       ├── logo.png     ──► https://mystorageacct.blob.core.windows.net/images/logo.png
   │       └── banner.jpg
   │
   ├── container: backups
   │       └── db-2026-10-13.bak
   │
   └── container: $web            (static website hosting)
           └── index.html

Three BLOB TYPES:
   • Block blob  → files/objects (images, docs, backups)         ← the default & common
   • Append blob → append-only (logging scenarios)
   • Page blob   → random read/write 512-byte pages (VHD disks)
```

| Container access level | Who can read anonymously |
|---|---|
| **Private** (default) | Nobody — auth required (key/SAS/Entra) |
| **Blob** | Anonymous read of **individual blobs** (if you know the URL) |
| **Container** | Anonymous read + **list** all blobs in the container |

⚠️ Anonymous access must also be **allowed at the account level**; Microsoft now **disables it by default** — a common exam/security point.

---

## 44.3 UI / CLI Steps — Create a Container, Upload & Access

```
📍 Storage account → "Containers" → "+ Container"
   Name=images,  Public access level=Private → Create
    ↓
📍 Open container → "Upload" → pick logo.png → (Advanced: set tier/folder) → Upload
    ↓
📍 Click the blob → "Properties" shows the URL
   Private container → the raw URL returns 404/AuthError without a SAS/key
    ↓
📍 Download/access options:
   • Generate SAS (time-limited signed URL)
   • Storage Explorer (desktop) for drag-and-drop
   • azcopy / az CLI for bulk
```

**CLI:**
```bash
# Create a container
az storage container create --account-name mystorageacct -n images --auth-mode login

# Upload a blob
az storage blob upload --account-name mystorageacct -c images \
  -n logo.png -f ./logo.png --auth-mode login

# List blobs
az storage blob list --account-name mystorageacct -c images -o table --auth-mode login

# Download a blob
az storage blob download --account-name mystorageacct -c images \
  -n logo.png -f ./downloaded.png --auth-mode login
```

---

## 44.4 Static Website Hosting

```
📍 Storage account → "Static website" → Enabled
   Index document = index.html,  Error document = 404.html → Save
    ↓
   Azure creates a special "$web" container + a PRIMARY ENDPOINT URL
   (https://mystorageacct.z13.web.core.windows.net)
    ↓
   Upload your site files to $web → served directly, no web server needed.
   Add Azure CDN/Front Door + custom domain for performance and HTTPS.
```

---

## 44.5 Integration with Other Azure Services

| Service | Role with Blob |
|---|---|
| **CDN / Front Door** | Cache and globally serve blob content; HTTPS + custom domain |
| **Azure Backup / snapshots** | Store backups and VM disk data |
| **Event Grid** | Fire events on blob created/deleted (e.g., trigger a Function) |
| **Azure Functions** | Blob trigger processes new blobs automatically |
| **Data Factory / Synapse** | Blob/ADLS Gen2 as a data lake source/sink |
| **Private Endpoint / firewall** | Restrict blob access to specific VNets |

---

## 44.6 Real-World Scenario — Media Upload Pipeline

```
A photo-sharing app stores and serves user images.
   1. Container "uploads" (Private) receives new images via the app (SAS upload URLs).
   2. Event Grid fires on "BlobCreated" → an Azure Function generates a thumbnail into
      container "thumbnails".
   3. Served container is fronted by Azure CDN with a custom domain + HTTPS for fast,
      cached global delivery.
   4. Lifecycle rule: move images not accessed in 90 days to Cool, 365 days to Archive.
   5. Soft delete + versioning protect against accidental deletes/overwrites.
Result: scalable, event-driven media storage that's cheap at rest and fast to serve.
```

---

## 44.7 Benefits

- **Virtually unlimited scale** and high durability
- **Low cost**, tunable further with access tiers + lifecycle rules
- **Direct HTTP(S) access** — URLs, SDKs, REST, static website hosting
- **Event-driven** — integrates with Event Grid/Functions
- **Secure & flexible auth** — keys, SAS, Entra RBAC; private endpoints
- **Data protection** — soft delete, versioning, snapshots, immutability

---

## 44.8 Common Use Cases

- Storing app content: images, videos, documents, installers
- Backups and archive/long-term retention
- Static website and asset hosting (with CDN)
- Data lake storage for analytics (ADLS Gen2)
- Logs and big-data ingestion; event-driven processing pipelines

---

## 44.9 Exam Q&A

**Q: What is the hierarchy of the Blob service — account, container, blob?**
> A **storage account** contains **containers** (like top-level folders), and each container holds **blobs** (the actual objects). The URL reflects this: `https://<account>.blob.core.windows.net/<container>/<blob>`. Containers set the anonymous access level; blobs are the data you read and write. There's no true nested-folder hierarchy — "folders" are just name prefixes (virtual directories).

**Q: What are the three blob types and when is each used?**
> **Block blobs** store files/objects (images, documents, backups) and are the default and most common. **Append blobs** are optimized for **append-only** workloads like logging. **Page blobs** support **random read/write in 512-byte pages** and back **VHD disks** (unmanaged disks). For almost all general storage you use block blobs.

**Q: You set a container's access level to "Blob" but anonymous requests still fail. Why?**
> Anonymous access also has to be **enabled at the storage-account level** ("Allow Blob anonymous access"). Microsoft now **disables it by default** for security, so even a container marked Blob/Container won't serve anonymously until the account setting permits it. The fix is to enable anonymous access on the account — or, better, use **SAS or Entra** instead of anonymous access.

**Q: How do you host a static website directly from Blob storage?**
> Enable the **Static website** feature on the account; Azure provisions a special **`$web` container** and a **web endpoint**. You upload your HTML/CSS/JS to `$web`, set the index and error documents, and the content is served directly with **no web server**. Add **CDN/Front Door** and a **custom domain** for HTTPS and global caching.

**Q: What built-in features protect blobs against accidental deletion or overwrite?**
> **Soft delete** (for blobs and containers) retains deleted data for a configurable retention period so you can restore it; **versioning** automatically keeps previous versions on overwrite; **snapshots** capture point-in-time read-only copies; and **immutable (WORM) policies** can prevent deletion/modification entirely for compliance. Together they provide layered data protection.

**Q: A container's blobs must only be reachable from your application's VNet. How do you enforce that?**
> Restrict the storage account's networking to **selected networks** (service endpoint) or deploy a **Private Endpoint** so the blob service gets a **private IP** in your VNet, then set the firewall to deny public access. Combined with Entra RBAC, this ensures only in-VNet, authorized callers reach the blobs.

---

## 44.10 Summary

The **Blob service** stores massive amounts of **unstructured data** as **blobs inside containers**, accessed by URL (`account.blob.core.windows.net/container/blob`). Containers have an **access level** (Private/Blob/Container), but **anonymous access is disabled by default at the account level** — prefer **SAS or Entra RBAC**. Three blob types exist: **block** (files — the default), **append** (logging), and **page** (VHD disks). The service powers **static websites** (`$web` container), **event-driven pipelines** (Event Grid/Functions), and **data lakes** (ADLS Gen2). Protect data with **soft delete, versioning, snapshots, and immutability**, and reduce cost with **access tiers + lifecycle management** (next topics). It is Azure's equivalent of **Amazon S3**.

[↑ Back to top](#-table-of-contents)

---
---

# 45. 🔑 Blob Authorization (Keys, SAS, Stored Access Policy)
> 🔴 FULL
> 📚 Course lectures: 133 (Different authorization techniques), 134/136 (Storage Explorer), 135 (Storage access keys), 137–139 (SAS: Blob / Container / Account level), 140 (Stored Access Policy)

---

## 45.1 What Problem Does This Solve?

Blob data is private by default, so every caller must prove they're allowed in. Azure offers **several authorization techniques**, each with different power and risk: full-power **access keys**, time-limited **Shared Access Signatures (SAS)**, centrally revocable **Stored Access Policies**, and identity-based **Microsoft Entra RBAC**. Knowing which to use — and how to revoke access — is core exam material and core security hygiene.

Think of the options like **ways to let someone into a building**: the **master key** (access key — opens everything, dangerous if copied), a **time-limited visitor pass** (SAS — works until it expires), a **visitor pass tied to a revocable policy** (Stored Access Policy — you can cancel all passes at once), and a **staff badge from HR** (Entra RBAC — identity-based, auditable, revoke by removing the role).

> 💡 **If you know AWS:** Access keys ≈ **root/account access keys** (avoid sharing). **SAS tokens ≈ S3 pre-signed URLs** (time-limited, scoped). **Entra RBAC ≈ IAM roles/policies** (identity-based, least privilege). A **Stored Access Policy** is like a server-side policy that pre-signed URLs reference, so you can revoke them centrally — handy because a plain SAS can't be revoked without rotating keys.

---

## 45.2 The Authorization Options Compared (Flow Diagram)

```
Who/what is calling?
   │
   ├── A trusted app/admin needing full control ──► ACCESS KEY  (key1/key2)
   │        ⚠ full access to the WHOLE account; rotate if leaked; hard to scope
   │
   ├── A user/partner for a limited time/scope ──► SAS TOKEN
   │        scope: Account / Container / Blob;  perms: r,w,d,l; start+expiry; IP; HTTPS
   │        └─ reference a STORED ACCESS POLICY → central expiry + REVOCATION
   │
   └── An Azure identity (user, app, managed identity) ──► ENTRA RBAC  ✅ best practice
            e.g., "Storage Blob Data Reader/Contributor"; no secrets; auditable
```

| Technique | Scope | Revocation | Best for |
|---|---|---|---|
| **Access key** | Entire account | Rotate key1/key2 (breaks all users of that key) | Backend/admin, trusted automation |
| **SAS (ad-hoc)** | Account/Container/Blob | Only by rotating the signing key | Short-lived, delegated access |
| **SAS + Stored Access Policy** | Container-level | **Delete/modify the policy** (instant, central) | Reusable, revocable delegated access |
| **Entra RBAC** | Account→container→blob (via roles) | Remove the role assignment | **Default best practice** |

⭐ Two **account keys** (key1, key2) exist so you can **rotate without downtime**: switch apps to key2, regenerate key1, then switch back.

---

## 45.3 Shared Access Signature (SAS) Anatomy

```
A SAS is a signed query string appended to a blob URL:

https://acct.blob.core.windows.net/images/logo.png?sv=2024-...&ss=b&srt=o
   &sp=r&se=2026-10-14T18:00Z&sip=20.1.2.0-20.1.2.255&spr=https&sig=<HMAC>

   sp  = permissions (r read, w write, d delete, l list, a add, c create)
   se  = expiry time         st = start time
   sip = allowed IP range     spr = https only
   sig = signature (proves it was signed by the account key or policy)

THREE SAS SCOPES:
   • Account SAS   → multiple services + resource types (broad)
   • Service/Container SAS → one container (can bind to a Stored Access Policy)
   • Blob SAS      → a single blob (narrowest)

USER DELEGATION SAS (best): signed with an ENTRA credential, not the account key
   → more secure, revocable by removing the identity's permissions.
```

---

## 45.4 Stored Access Policy — Why It Matters

```
PROBLEM: a plain SAS can't be revoked — once issued, it's valid until expiry, and the
         only way to kill it early is rotating the account key (breaks EVERYTHING).

SOLUTION: define a STORED ACCESS POLICY on a container (name + perms + expiry),
          then issue SAS tokens that REFERENCE that policy.
   • Change the policy  → all referencing SAS tokens change.
   • Delete the policy  → all referencing SAS tokens are INSTANTLY revoked.
   (Up to 5 stored access policies per container.)
```

---

## 45.5 UI / CLI Steps

```
── Access keys ──
📍 Storage account → "Access keys" → Show key1 / key2 + connection strings
   "Rotate key1" regenerates it.

── Generate a SAS (blob level) ──
📍 Container → blob → "Generate SAS"
   Permissions=Read, Start/Expiry, Allowed IPs, HTTPS only → "Generate SAS token and URL"

── Stored Access Policy ──
📍 Container → "Access policy" → "+ Add policy"
   Identifier=readonly-partner, Permissions=Read+List, Expiry=... → Save
   Then: blob/container → Generate SAS → choose "Stored access policy = readonly-partner"

── Storage Explorer (desktop GUI) ──
📍 Connect via account key, SAS, or Entra login → drag-and-drop uploads/downloads
```

**CLI:**
```bash
# Account key rotation
az storage account keys renew -g rg -n acct --key primary

# Blob SAS (expires in 1 hour, read-only)
end=$(date -u -d "1 hour" '+%Y-%m-%dT%H:%MZ')
az storage blob generate-sas --account-name acct -c images -n logo.png \
  --permissions r --expiry $end --https-only --full-uri

# Stored access policy + SAS referencing it
az storage container policy create --account-name acct -c images \
  -n readonly-partner --permissions rl --expiry $end
az storage blob generate-sas --account-name acct -c images -n logo.png \
  --policy-name readonly-partner --full-uri
```

---

## 45.6 Integration with Other Azure Services

| Service | Role in Blob authorization |
|---|---|
| **Microsoft Entra ID** | Identity-based RBAC; signs User Delegation SAS |
| **Key Vault** | Stores/rotates connection strings and keys securely |
| **Managed Identities** | Keyless access for VMs/apps/Functions |
| **Azure Policy** | Enforce "disable shared-key access", HTTPS-only, etc. |
| **Storage Explorer / AzCopy** | Tools that authenticate via key/SAS/Entra |

---

## 45.7 Real-World Scenario — Secure Partner Access

```
A partner needs read access to one container for 30 days, and you must be able to cut
it off instantly if the partnership ends.
   1. Create a Stored Access Policy "partner-read" on the container (Read+List, 30-day expiry).
   2. Issue a SAS that references the policy; share the SAS URL with the partner.
   3. Partner reads blobs via the SAS; your apps keep using Entra RBAC (no keys shared).
   4. Partnership ends early → DELETE the policy → the partner's SAS dies immediately,
      with zero impact on anything else.
Meanwhile, internal apps authenticate with managed identities + "Storage Blob Data
Reader", so no account keys are ever distributed.
```

---

## 45.8 Benefits

- **Choice of trust level** — from full keys to narrow, time-boxed SAS to identity RBAC
- **Central revocation** — Stored Access Policies kill all referencing SAS instantly
- **Least privilege** — scope SAS to blob/container + specific permissions + IP + HTTPS
- **Keyless security** — Entra RBAC + managed identities avoid shared secrets
- **Zero-downtime rotation** — dual keys (key1/key2)

---

## 45.9 Common Use Cases

- Temporary, scoped download/upload links for users or partners (SAS)
- Revocable delegated access with central control (SAS + Stored Access Policy)
- Backend/admin and automation access (keys — ideally via Key Vault)
- Secure, auditable app access without secrets (Entra RBAC + managed identity)
- Desktop data management (Storage Explorer)

---

## 45.10 Exam Q&A

**Q: You issued a SAS token that doesn't expire for 6 months and now need to revoke it immediately. How, and how could you have avoided the problem?**
> A plain (ad-hoc) SAS can only be killed early by **rotating the account key that signed it** — which breaks every other token/app using that key. To avoid this, issue the SAS against a **Stored Access Policy**; then you simply **delete or modify the policy** to revoke all referencing SAS tokens instantly, with no key rotation and no collateral impact.

**Q: What are the three scopes of a SAS, and which is most restrictive?**
> **Account SAS** (spans multiple services/resource types — broadest), **Service/Container SAS** (one container, and can bind to a stored access policy), and **Blob SAS** (a single blob — most restrictive). Choosing the narrowest scope that still works follows least privilege and limits blast radius if the token leaks.

**Q: Why does a storage account have two access keys?**
> To enable **zero-downtime key rotation**. You point applications at **key2**, **regenerate key1**, then (optionally) move apps back — so you can rotate a potentially compromised key without an outage. Both keys grant **full account access**, which is exactly why they should be guarded (and ideally replaced by Entra RBAC).

**Q: What is a User Delegation SAS and why is it preferred over a key-signed SAS?**
> A **User Delegation SAS** is signed with a **Microsoft Entra credential** rather than the storage account key. It's more secure because it's tied to an **identity with RBAC permissions** (not a shared secret), is **auditable**, and can be revoked by removing the identity's access — avoiding the risk of distributing or over-scoping account keys.

**Q: What's the most secure, recommended way for an Azure VM app to read blobs?**
> Give the VM a **managed identity**, assign it a least-privilege role like **Storage Blob Data Reader** on the account/container, and have the app authenticate via **Entra ID** (`--auth-mode login`). This is **keyless** (no secrets in code/config), **auditable**, and revoked simply by removing the role — the opposite of embedding an account key.

**Q: Which permissions can a SAS grant, and what extra constraints can you add?**
> Common permissions are **read (r), write (w), delete (d), list (l), add (a), create (c)**. You can further constrain a SAS with a **start/expiry time**, an **allowed IP range (sip)**, and **HTTPS-only (spr=https)** — tightening it to exactly when, from where, and how it may be used.

---

## 45.11 Summary

Blobs are private by default, and Azure offers layered **authorization**: **account keys** (full power — rotate via dual key1/key2, guard carefully), **SAS tokens** (time-limited, scoped to account/container/blob with r/w/d/l perms, IP and HTTPS limits), **Stored Access Policies** (container-level policies that SAS reference so you can **revoke centrally and instantly**), and **Entra RBAC** (identity-based, keyless, auditable — the **recommended** approach, especially with **managed identities** and **User Delegation SAS**). The headline exam point: a plain SAS **can't be revoked** without rotating keys, so bind it to a **Stored Access Policy** when you need revocation. **Storage Explorer** is the desktop tool for managing data via any of these methods.

[↑ Back to top](#-table-of-contents)

---
---

# 46. 🔒 Immutable Blob Storage
> 🟡 KNOW-THIS-MUCH
> 📚 Course lecture: 141 (Azure Storage Accounts - Immutable Blob Storage)

---

## 46.1 What Problem Does This Solve?

Some data must be **provably unchangeable** for a period — financial records, legal evidence, medical data, audit logs. Regulations (SEC 17a-4, FINRA, HIPAA, GDPR) demand **WORM (Write Once, Read Many)** storage so data can't be altered or deleted, even by an administrator. **Immutable Blob Storage** enforces this with **time-based retention** or **legal hold** policies.

Think of immutable storage like **a notary sealing a document in a tamper-proof box with a "do not open until" date**. Once sealed, nobody — not even the person who made it or the building owner (the admin) — can change or shred it until the date passes (time-based) or the court releases it (legal hold).

> 💡 **If you know AWS:** This is **S3 Object Lock** (WORM) — with **Retention periods** (≈ Governance/Compliance mode) and **Legal holds**. Same purpose: satisfy regulatory WORM requirements and protect against tampering/ransomware.

---

## 46.2 Two Policy Types (Flow Diagram)

```
IMMUTABILITY POLICY on a container (or version-level):
   ┌──────────────────────────────────────────────────────────┐
   │ 1) TIME-BASED RETENTION                                     │
   │    "Keep for N days" → can't modify/delete until it expires │
   │    • Locked policy = cannot be shortened (only extended)    │
   │                                                             │
   │ 2) LEGAL HOLD                                               │
   │    "Hold until lifted" (no end date) → tagged, can't delete │
   │    until a user with permission explicitly removes the hold │
   └──────────────────────────────────────────────────────────┘

State:  Unlocked (testing — editable)  ──lock──►  Locked (enforced, irreversible)
```

| Policy | End condition | Can shorten? | Use |
|---|---|---|---|
| **Time-based retention** | Fixed duration | Locked → only extend, never shorten | Regulatory retention windows |
| **Legal hold** | Until explicitly removed | n/a (tag-based) | Litigation/investigation holds |

⚠️ Once a time-based policy is **Locked**, even the subscription owner **cannot delete the data or shorten the period** before expiry — that's the point (ransomware/insider protection too).

---

## 46.3 UI / CLI Steps

```
📍 Storage account → Container → "Access policy" (or right-click → Access policy)
   → "Immutable blob storage" → "+ Add policy"
   ┌──────────────────────────────────────────────┐
   │ Policy type: Time-based retention              │
   │ Retention period: 365 days                     │
   │ ☐ Allow protected append writes (append blobs) │
   └──────────────────────────────────────────────┘
   Save → initially UNLOCKED (test) → when ready, "Lock policy" (irreversible)
    ↓
   OR: Legal hold → add a tag (e.g., "case-2026") → data locked until tag removed
```

```bash
# Enable version-level immutability support at account/container creation, then:
az storage container immutability-policy create \
  --account-name acct -c records --period 365
az storage container immutability-policy lock \
  --account-name acct -c records --if-match '<etag>'

az storage container legal-hold set --account-name acct -c records --tags case-2026
```

---

## 46.4 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Blob versioning** | Enables version-level immutability (per-version WORM) |
| **Soft delete / lifecycle** | Complement retention; lifecycle can't delete locked data early |
| **Azure Policy** | Enforce immutability on required containers/accounts |
| **Microsoft Purview / compliance** | Governance and regulatory reporting |

---

## 46.5 Real-World Scenario — Regulatory Records Retention

```
A brokerage must retain trade confirmations for 7 years, unaltered (SEC 17a-4).
   1. Store confirmations as blobs in a dedicated container.
   2. Apply a time-based retention policy of 2555 days and LOCK it.
   3. Even an admin now cannot delete or modify a confirmation before 7 years elapse —
      satisfying the regulator and defeating ransomware/insider tampering.
   4. For an active lawsuit, add a LEGAL HOLD tag to the relevant blobs so they're
      preserved beyond their normal retention until the case closes.
Result: provable WORM compliance with auditable, tamper-proof retention.
```

---

## 46.6 Benefits

- **Regulatory compliance** — satisfies SEC/FINRA/HIPAA WORM requirements
- **Tamper-proof** — not even admins can alter/delete during the window
- **Ransomware/insider protection** — locked data can't be encrypted or wiped
- **Flexible** — fixed retention or open-ended legal hold
- **Granular** — container-level or version-level

---

## 46.7 Common Use Cases

- Financial, legal, and healthcare records retention
- Audit logs that must be immutable
- Litigation/legal hold preservation
- Protecting critical backups from deletion/encryption (ransomware defense)

---

## 46.8 Exam Q&A

**Q: What are the two types of immutability policies, and how do they differ?**
> **Time-based retention** keeps data unchangeable for a **fixed duration** (e.g., 7 years), after which it can be modified/deleted. **Legal hold** preserves data **indefinitely until a user explicitly removes the hold** (no end date), typically for litigation. Both enforce WORM; the difference is a fixed clock versus an open-ended, manually released hold.

**Q: Once a time-based retention policy is *locked*, can an administrator delete the data early?**
> **No.** A locked policy **cannot be shortened or removed** — it can only be **extended** — so no one, including the subscription owner, can delete or modify the data before the retention period expires. This is precisely what makes it compliant and a strong defense against ransomware and malicious insiders.

**Q: What regulatory requirement does Immutable Blob Storage address?**
> **WORM (Write Once, Read Many)** — required by regulations such as **SEC 17a-4, FINRA, HIPAA, and GDPR** for records that must be retained unaltered for defined periods. Immutable storage provides a certified, auditable way to guarantee data cannot be tampered with during its retention window.

**Q: You locked a policy in testing by mistake with too long a period. What are your options?**
> Very few — a **locked** time-based policy can only be **extended, never shortened or deleted**, and the data can't be removed until expiry. This is why you first create the policy in the **Unlocked** state to test behavior, and only **lock** it once you're certain. (The account/container itself also can't be deleted while locked immutable data exists.)

---

## 46.9 Summary

**Immutable Blob Storage** enforces **WORM** — data that can't be modified or deleted — via two policy types: **time-based retention** (unchangeable for a fixed period; once **locked**, it can only be **extended**, never shortened or deleted by anyone) and **legal hold** (preserved until explicitly removed). It satisfies regulations like **SEC 17a-4, FINRA, and HIPAA**, and doubles as **ransomware/insider protection** because locked data is untouchable. Test in the **Unlocked** state, then **lock** when certain. It's Azure's equivalent of **S3 Object Lock**.

[↑ Back to top](#-table-of-contents)

---
---

# 47. 🌐 Data Redundancy
> 🟠 MEDIUM
> 📚 Course lecture: 142 (Azure Storage Accounts - Data Redundancy)

---

## 47.1 What Problem Does This Solve?

Hardware fails, datacenters have outages, and whole regions can suffer disasters. **Data redundancy** options decide **how many copies** of your data Azure keeps and **where** — within one datacenter, across zones, or across a second region — trading **cost** against **durability and disaster resilience**. Choosing correctly is a frequent exam topic and a real business decision.

Think of redundancy like **how many backup copies of an important document you keep and where**: a photocopy in the same drawer (LRS), copies in three different rooms of the building (ZRS), and a copy mailed to another city (GRS/GZRS). More copies, further apart = safer but costlier.

> 💡 **If you know AWS:** S3 stores data redundantly across AZs by default (≈ ZRS). Azure makes it an explicit **choice**: **LRS** (single datacenter), **ZRS** (across zones — like S3's default multi-AZ), **GRS/GZRS** (cross-region replication — like **S3 Cross-Region Replication**), and **RA-** variants that allow **read access** to the secondary region.

---

## 47.2 The Redundancy Options (Flow Diagram)

```
                     ┌───────── PRIMARY REGION ─────────┐   ┌─ SECONDARY REGION (100s of km away) ─┐

LRS   (3 copies)     [ one datacenter: ●●● ]                   (none)
     cheapest; protects against disk/node failure only.

ZRS   (3 copies)     [ AZ1 ● | AZ2 ● | AZ3 ● ]                 (none)
     protects against a whole datacenter/zone failure.

GRS   (6 copies)     [ datacenter: ●●● (LRS) ] ───async──►    [ datacenter: ●●● (LRS) ]  (read only on failover)

GZRS  (6 copies)     [ AZ1●|AZ2●|AZ3● (ZRS) ] ──async──►      [ datacenter: ●●● (LRS) ]  (read only on failover)

RA-GRS / RA-GZRS  = GRS/GZRS + you can READ the secondary ANYTIME (-secondary endpoint)
```

| Option | Copies | Protects against | Secondary readable? |
|---|---|---|---|
| **LRS** | 3 (one datacenter) | Disk/rack/node failure | — |
| **ZRS** | 3 (across 3 zones) | Datacenter/zone failure | — |
| **GRS** | 6 (3 primary LRS + 3 secondary LRS) | Regional disaster | Only after failover |
| **GZRS** | 6 (3 primary ZRS + 3 secondary LRS) | Zone **and** regional disaster | Only after failover |
| **RA-GRS** | 6 | Regional disaster | ✅ anytime (read) |
| **RA-GZRS** | 6 | Zone + regional disaster | ✅ anytime (read) |

⭐ Durability climbs LRS → ZRS → GRS → GZRS (Azure quotes "eleven nines" and beyond). **Geo-redundant secondaries are read-only** unless you fail over; writes always go to the primary.

---

## 47.3 Key Rules to Remember

```
✅ LRS   = cheapest, same datacenter (3 copies)
✅ ZRS   = across Availability Zones in one region
✅ GRS   = cross-region (async), secondary NOT readable until failover
✅ GZRS  = ZRS in primary + geo copy (best of both)
✅ RA-*  = "Read Access" → read the secondary region anytime
✅ Replication to the secondary is ASYNCHRONOUS → a tiny RPO (possible data loss window)
✅ You can change redundancy later (some transitions need a migration/support request)
✅ Archive tier + geo has special handling; Premium has limited redundancy options
```

---

## 47.4 UI / CLI Steps

```
📍 At creation: Storage account → Basics → "Redundancy" dropdown → pick LRS/ZRS/GRS/GZRS/RA-*
📍 Later: Storage account → "Redundancy" (or Configuration) → change option → Save
📍 RA-GRS/RA-GZRS: a secondary read endpoint appears:
   mystorageacct-secondary.blob.core.windows.net
📍 Account failover (DR): Storage account → "Redundancy" → "Prepare for failover"
   (makes the secondary the new primary — last-sync time shows potential data loss)
```

```bash
az storage account create -g rg -n acct --sku Standard_GZRS --kind StorageV2 --location centralindia
az storage account update -g rg -n acct --sku Standard_RAGZRS
az storage account show -g rg -n acct --query "statusOfPrimary"
az storage account failover -g rg -n acct     # initiate account failover
```

---

## 47.5 Integration with Other Azure Services

| Service | Relationship to redundancy |
|---|---|
| **Availability Zones** | ZRS/GZRS spread copies across zones |
| **Azure Backup / Recovery vaults** | Vaults have their own LRS/ZRS/GRS choice |
| **Disaster Recovery planning** | Redundancy sets RPO; failover procedure defines RTO |
| **Object replication** | App-level blob replication (complements account redundancy) |

---

## 47.6 Real-World Scenario — Choosing Redundancy by Workload

```
A company sets redundancy per workload to balance cost and resilience.
   • Temp/dev data & easily-regenerated caches → LRS (cheapest; loss acceptable).
   • Production app data within one region, must survive a datacenter outage → ZRS.
   • Compliance backups that must survive a regional disaster → GRS.
   • Mission-critical system needing BOTH zone resilience AND geo-DR, with the ability
     to read a secondary copy for reporting → RA-GZRS.
When the primary region had an outage, the RA-GZRS account kept serving READS from the
secondary endpoint, and after a declared failover it became writable — meeting the DR plan.
```

---

## 47.7 Benefits

- **Tunable durability vs cost** — pick exactly the protection each workload needs
- **Zone resilience** (ZRS/GZRS) — survive a full datacenter failure
- **Geo-disaster recovery** (GRS/GZRS) — survive a regional disaster
- **Read scalability/DR reads** (RA-*) — read the secondary anytime
- **Changeable** — adjust as requirements evolve

---

## 47.8 Common Use Cases

- LRS: dev/test, temp data, data you can regenerate
- ZRS: production data needing high in-region availability
- GRS/GZRS: backups and compliance data needing cross-region protection
- RA-GRS/RA-GZRS: apps that read from a secondary region or need DR read access

---

## 47.9 Exam Q&A

**Q: What is the difference between LRS and ZRS?**
> **LRS** keeps **3 copies in a single datacenter** — protecting only against disk/node/rack failures, and it's the cheapest. **ZRS** keeps **3 copies across three Availability Zones** in the region, so it survives a **whole datacenter/zone failure**. Choose ZRS when in-region high availability matters; LRS when cost is the priority and local failure protection is enough.

**Q: With GRS, can you read the data in the secondary region at any time?**
> **No** — with plain **GRS/GZRS** the secondary copy is **not accessible** until you perform an **account failover**. If you need to **read the secondary region anytime** (e.g., for reporting or DR reads), you must choose the **RA- (read-access)** variant: **RA-GRS** or **RA-GZRS**, which expose a secondary read endpoint.

**Q: What does GZRS provide that GRS does not?**
> **GZRS** stores the **primary copies across Availability Zones (ZRS)** *and* asynchronously replicates to a **second region**, so it protects against **both a zone failure and a regional disaster**. Plain **GRS** uses **LRS in the primary** (single datacenter), so it survives a regional disaster but **not** a zone-level datacenter failure in the primary. GZRS is the most resilient option.

**Q: Is replication to the secondary region synchronous or asynchronous, and why does it matter?**
> It's **asynchronous**, meaning recently written data may not yet have replicated when a disaster strikes — creating a small **RPO (potential data-loss window)**. Within a region (LRS/ZRS) copies are written **synchronously**. This is why geo-redundancy guards against regional disasters but can't guarantee zero data loss on failover; the portal shows the **last sync time**.

**Q: How many copies of your data does each option keep?**
> **LRS = 3** (one datacenter), **ZRS = 3** (across zones), and the geo options **GRS/GZRS/RA-GRS/RA-GZRS = 6** (3 in the primary region + 3 in the secondary). More copies spread further apart means higher durability and resilience, at higher cost.

---

## 47.10 Summary

**Data redundancy** sets how many copies of your storage Azure keeps and where, trading cost for durability: **LRS** (3 copies, one datacenter — cheapest), **ZRS** (3 copies across **zones** — survives a datacenter failure), **GRS** (6 copies, **cross-region async** — survives a regional disaster, secondary **not readable** until failover), and **GZRS** (ZRS primary + geo secondary — survives **zone and region** failures). The **RA-** variants (**RA-GRS/RA-GZRS**) add **anytime read access** to the secondary. Cross-region replication is **asynchronous** (small RPO), writes always go to the **primary**, and you can **change** redundancy or **fail over** for DR. Pick per workload: LRS for throwaway data, ZRS for in-region HA, GRS/GZRS for geo-DR, RA-* when you must read the secondary.

[↑ Back to top](#-table-of-contents)

---
---

# 48. 🌡️ Access Tiers & Lifecycle Management
> 🟠 MEDIUM
> 📚 Course lectures: 143 (Introduction to Access Tiers), 144 (Lab - Configuring access tiers), 145–146 (Blob Storage lifecycle management)

---

## 48.1 What Problem Does This Solve?

Not all data is used equally — some blobs are read every minute, others haven't been touched in years but must be kept. Paying "hot" prices to store cold data wastes money. **Access tiers** (Hot, Cool, Cold, Archive) let you match **storage cost vs access cost** to how often data is read, and **Lifecycle Management** automates moving or deleting blobs as they age — so cost optimization runs itself.

Think of access tiers like **where you keep your belongings**: things you use daily stay on your desk (Hot — instant, but prime real estate costs more). Seasonal items go in a closet (Cool). Rarely needed items go to the basement (Cold). Things you must legally keep but never touch go to a cheap off-site storage unit where retrieval takes hours and costs a fee (Archive). **Lifecycle rules** are the assistant who automatically moves things to cheaper storage the longer they sit untouched.

> 💡 **If you know AWS:** Hot/Cool/Cold/Archive ≈ **S3 Standard / Standard-IA / (One Zone-IA-ish) / Glacier**. **Lifecycle Management** is the direct equivalent of **S3 Lifecycle policies**. Archive's **rehydration** delay ≈ Glacier restore. Azure's **Cool/Cold have minimum retention periods** with early-deletion fees, just like S3-IA/Glacier.

---

## 48.2 The Four Tiers (Flow Diagram)

```
  COST OF STORAGE  high ◄──────────────────────────────────────► low
  COST TO ACCESS   low  ◄──────────────────────────────────────► high
  ACCESS LATENCY   ms   ms          ms            ms      HOURS (rehydrate)

   ┌────────┐    ┌────────┐    ┌────────┐    ┌───────────────┐
   │  HOT   │    │  COOL  │    │  COLD  │    │   ARCHIVE      │
   │ freq.  │    │ ≥30 d  │    │ ≥90 d  │    │  ≥180 d        │
   │ access │    │ infreq.│    │ rare   │    │ offline! must  │
   └────────┘    └────────┘    └────────┘    │ REHYDRATE first│
                                             └───────────────┘
   Hot/Cool/Cold = online (instant read).  Archive = OFFLINE (hours to rehydrate).
```

| Tier | Min retention | Access pattern | Notes |
|---|---|---|---|
| **Hot** | none | Frequent | Highest storage cost, lowest access cost |
| **Cool** | 30 days | Infrequent (monthly) | Early-delete fee before 30 days |
| **Cold** | 90 days | Rare | Cheaper than Cool; early-delete fee |
| **Archive** | 180 days | Almost never | **Offline** — must **rehydrate** (hours) to read; cheapest storage |

⚠️ **Archive is offline**: you can't read a blob directly — you must **rehydrate** it to Hot/Cool first (Standard priority: up to ~15 hrs; High priority: faster, costlier). Tier is set **per blob** (default comes from the account).

---

## 48.3 Lifecycle Management (Flow Diagram)

```
Lifecycle policy = JSON rules applied to blobs (optionally filtered by prefix/tags):

   IF base blob  lastModified > 30 days   → move to COOL
   IF base blob  lastModified > 90 days   → move to ARCHIVE
   IF base blob  lastModified > 365 days  → DELETE
   IF previous VERSIONS  age > 90 days     → DELETE
   IF SNAPSHOTS age > 60 days              → DELETE

   Actions:  tierToCool · tierToCold · tierToArchive · delete
   Conditions: daysAfterModificationGreaterThan,
               daysAfterLastAccessTimeGreaterThan (needs access tracking),
               daysAfterCreationGreaterThan (snapshots/versions)
```

Rules run **automatically once per day** — no manual intervention. This is the main lever for storage cost optimization on the exam.

---

## 48.4 UI / CLI Steps

```
── Set a blob's tier manually ──
📍 Container → blob → "Change tier" → Hot / Cool / Cold / Archive → Save
📍 Rehydrate from Archive: "Change tier" → Hot/Cool + Priority (Standard/High) → wait

── Default account tier ──
📍 Storage account → "Configuration" → Blob access tier (default) = Hot or Cool

── Lifecycle rule ──
📍 Storage account → "Lifecycle management" → "+ Add a rule"
   Scope: all blobs / filtered by prefix (e.g., logs/)
   If base blobs "last modified more than" 30 days → Move to cool
   Add: 90 days → archive;  365 days → delete → Add
```

```bash
az storage blob set-tier --account-name acct -c data -n old.bak --tier Archive --auth-mode login

az storage account management-policy create -g rg --account-name acct \
  --policy @lifecycle.json
# lifecycle.json defines rules (tierToCool/Archive/delete with day thresholds)
```

---

## 48.5 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Blob versioning / snapshots** | Lifecycle rules can age-out old versions/snapshots |
| **Last access tracking** | Enables "days after last access" conditions |
| **Azure Monitor / Cost Management** | Observe savings and access patterns |
| **Azure Backup / Archive workloads** | Long-term retention in Archive tier |

---

## 48.6 Real-World Scenario — Log Archival Cost Optimization

```
An app writes GBs of logs daily to a "logs/" container — rarely read after a month, but
must be kept 7 years for audit.
   1. New logs land in Hot (actively queried for troubleshooting).
   2. Lifecycle rule (prefix logs/):
        >30 days  → Cool
        >90 days  → Archive
        >2555 days → Delete
   3. Audit retrieval: rehydrate the needed archived logs to Hot (a few hours), read, done.
Result: recent logs are instant and cheap-to-read; old logs cost a fraction to store;
deletion is automatic at 7 years — all with zero manual effort.
```

---

## 48.7 Benefits

- **Major cost savings** — pay storage prices matched to real access frequency
- **Automation** — lifecycle rules tier/delete data with no manual work
- **Granular** — tier per blob; rules filtered by prefix or tags
- **Compliance-friendly** — cheap long-term retention (Archive) + auto-delete at end of life
- **Flexible** — four tiers covering the full hot-to-cold spectrum

---

## 48.8 Common Use Cases

- Tiering down logs, backups, and old media as they age
- Cheap long-term/compliance retention (Archive)
- Auto-deleting expired data, old versions, and snapshots
- Right-sizing storage spend across a large data estate

---

## 48.9 Exam Q&A

**Q: What is special about the Archive tier compared to Hot/Cool/Cold?**
> **Archive is offline** — the data isn't immediately readable. To access an archived blob you must **rehydrate** it to an online tier (Hot or Cool), which can take **up to ~15 hours** at Standard priority (faster at High priority, for a higher fee). It has the **cheapest storage** but the highest access cost/latency and a **180-day minimum retention**, making it ideal for data you almost never read but must keep.

**Q: You moved a blob to the Cool tier and deleted it after 10 days. What happens?**
> You incur an **early-deletion charge**, because Cool has a **30-day minimum retention period** — deleting (or moving/overwriting) before that incurs a prorated fee for the remaining days. Cold (90 days) and Archive (180 days) have the same concept with longer minimums. This discourages using cold tiers for data that churns quickly.

**Q: How do you automatically move blobs to cheaper tiers as they age without manual work?**
> Configure a **Lifecycle Management policy** — JSON rules that run **daily** and perform actions (`tierToCool`, `tierToCold`, `tierToArchive`, `delete`) based on conditions like **days since last modification or last access**. You can scope rules by **prefix or blob index tags**. This is the standard, hands-off way to optimize storage cost at scale.

**Q: At what level is the access tier set, and where does the default come from?**
> The access tier is set **per blob**, and a blob with no explicit tier **inherits the account's default tier** (Hot or Cool, set in the account's Configuration). You can override individual blobs manually or via lifecycle rules. Only **block blobs** support tiering (not append/page blobs in the same way).

**Q: A lifecycle rule should move files to Cool only if they haven't been *read* in 60 days (not just modified). What must be enabled?**
> You must enable **last access time tracking** on the storage account, which lets lifecycle conditions use **`daysAfterLastAccessTimeGreaterThan`**. Without it, rules can only key off **last modified** or **creation** time, which wouldn't reflect read activity. Tracking adds minor overhead but enables access-pattern-based tiering.

---

## 48.10 Summary

**Access tiers** match storage cost to access frequency: **Hot** (frequent, priciest storage/cheapest reads), **Cool** (infrequent, 30-day min), **Cold** (rare, 90-day min), and **Archive** (almost never, 180-day min, **offline — must rehydrate over hours to read**). Tier is set **per blob**, defaulting to the account's setting, and cold tiers charge **early-deletion fees**. **Lifecycle Management** policies automate the whole thing — JSON rules running **daily** that tier down or delete blobs (and old versions/snapshots) based on **age or last access** (the latter needs access tracking enabled). Together they're Azure's primary blob **cost-optimization** tools, equivalent to **S3 storage classes + lifecycle policies**.

[↑ Back to top](#-table-of-contents)

---
---

# 49. 📸 Blob Snapshots, Versioning & Object Replication
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 147 (Blob Snapshots), 148 (Blob Versioning), 149 (Lab - Object Replication)

---

## 49.1 What Problem Does This Solve?

Blobs get overwritten or deleted by mistake, and some data needs to exist in more than one region for latency or resilience. Three features address this: **Snapshots** (manual point-in-time read-only copies), **Versioning** (automatic history on every overwrite), and **Object Replication** (async copy of blobs from one account to another). Together they provide **data protection** and **geo-distribution** at the blob level.

Think of these like **document safety habits**: a **snapshot** is you choosing to "Save a copy as it is right now." **Versioning** is the app's automatic "track changes / version history" that keeps every past copy without you asking. **Object replication** is auto-syncing a folder to a colleague's drive in another office so they have a local copy.

> 💡 **If you know AWS:** **Versioning ≈ S3 Versioning** (keeps prior versions on overwrite/delete). **Snapshots** are an Azure blob concept (point-in-time read-only copies, similar to S3 versioned copies). **Object Replication ≈ S3 Cross-Region/Same-Region Replication (CRR/SRR)** — async, rule-based blob replication between buckets/accounts.

---

## 49.2 The Three Features (Flow Diagram)

```
SNAPSHOT (manual):
   blob "report.docx"  --take snapshot-->  report.docx?snapshot=2026-10-13T10:00
   original keeps changing; snapshot is a frozen, read-only copy you can restore/read.

VERSIONING (automatic, if enabled):
   overwrite report.docx → previous content auto-saved as a VERSION
   report.docx (current) + version1 + version2 ...  → restore any prior version.

OBJECT REPLICATION (async, account-to-account):
   SOURCE account (versioning on) ──replication rule──► DEST account (versioning on)
   container "images" ──async copy──► container "images-replica" (another region)
```

| Feature | Trigger | Keeps | Main purpose |
|---|---|---|---|
| **Snapshot** | Manual (you take it) | Read-only point-in-time copy | On-demand backup before a risky change |
| **Versioning** | Automatic on overwrite/delete | Every prior version | Effortless recovery from overwrites/deletes |
| **Object Replication** | Async per rules | A copy in another account/region | Latency, DR, data distribution |

⭐ **Object Replication requires blob versioning enabled on BOTH source and destination** accounts, and replicates only block blobs. Snapshots/versions also combine with **soft delete** and **lifecycle** rules for full protection and cost control.

---

## 49.3 UI / CLI Steps

```
── Snapshot ──
📍 Container → blob → "Create snapshot"  → "View snapshots" to list/restore/promote

── Versioning ──
📍 Storage account → "Data protection" → ☑ "Enable versioning for blobs" → Save
   (now every overwrite keeps the old version automatically)

── Object Replication ──
📍 Enable versioning on BOTH accounts first.
📍 Source account → "Object replication" → "+ Create replication rules"
   Destination account, source container → destination container, filters → Create
```

```bash
az storage blob snapshot --account-name acct -c docs -n report.docx --auth-mode login
az storage account blob-service-properties update -g rg --account-name acct --enable-versioning true
az storage account or-policy create -g rg --account-name srcacct \
  --destination-account destacct --source-container images --destination-container images
```

---

## 49.4 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Soft delete** | Recover deleted blobs/snapshots/versions within retention |
| **Lifecycle management** | Auto-delete aged snapshots/versions to control cost |
| **Point-in-time restore** | Uses versioning + change feed to roll a container back |
| **Data redundancy (GRS)** | Account-level geo copy (different from app-level object replication) |

---

## 49.5 Real-World Scenario — Protecting a Content Platform

```
A CMS stores articles and assets as blobs and must recover from mistakes and serve
users in two regions.
   1. Enable versioning → any accidental overwrite of an article is instantly recoverable
      by restoring the previous version.
   2. Before a bulk migration, take snapshots of critical blobs as a known-good point.
   3. Enable soft delete (7 days) as a safety net for outright deletions.
   4. Object replication copies the "published" container to a West-region account so the
      West user base reads from a nearby copy (lower latency) and has a DR copy.
   5. Lifecycle rule deletes versions/snapshots older than 90 days to keep costs down.
Result: layered recovery (snapshots + versions + soft delete) and geo-distributed reads.
```

---

## 49.6 Benefits

- **Overwrite/delete recovery** — versioning + snapshots + soft delete
- **Point-in-time copies** — snapshots freeze a known-good state
- **Geo-distribution & DR** — object replication copies blobs to another region/account
- **Automatic history** — versioning needs no per-change effort
- **Cost control** — lifecycle rules age-out old versions/snapshots

---

## 49.7 Common Use Cases

- Protecting documents/assets from accidental overwrite or deletion
- Capturing a safe point before risky bulk changes (snapshots)
- Replicating content to another region for latency or DR (object replication)
- Meeting recovery objectives alongside soft delete and PITR

---

## 49.8 Exam Q&A

**Q: What is the difference between a blob snapshot and blob versioning?**
> A **snapshot** is a **manual**, read-only point-in-time copy you explicitly create (good before a risky change). **Versioning** is **automatic** — once enabled, every **overwrite or delete** of a blob preserves the prior content as a version with no action needed. Snapshots are deliberate and on-demand; versioning is continuous and hands-off. Both allow restoring earlier states.

**Q: What are the prerequisites for Object Replication?**
> **Blob versioning must be enabled on both the source and destination storage accounts**, and you define **replication rules** mapping source containers to destination containers (which can be in a **different region or account**). It replicates **block blobs asynchronously**, so the destination is eventually consistent — suitable for latency reduction and DR, not synchronous guarantees.

**Q: How do versioning, snapshots, and soft delete relate for data protection?**
> They're **complementary layers**: **versioning** auto-keeps prior content on overwrite/delete, **snapshots** capture deliberate point-in-time copies, and **soft delete** retains deleted blobs/versions/snapshots for a **retention window** so they can be undeleted. Using them together maximizes recoverability; **lifecycle rules** then prune old versions/snapshots to manage cost.

**Q: Object replication vs GRS — what's the difference?**
> **GRS/GZRS** is **account-level** redundancy managed by Azure (a full geo copy you can't selectively control, secondary not readable without failover unless RA-). **Object replication** is **application-level**: you choose **specific containers** to replicate to **another account/region**, and the destination is **readable/writable independently**. Use GRS for whole-account DR; object replication for selective, readable geo-copies.

---

## 49.9 Summary

Three blob features provide protection and distribution: **Snapshots** are **manual** read-only point-in-time copies; **Versioning** **automatically** preserves prior content on every overwrite/delete once enabled; and **Object Replication** **asynchronously** copies selected containers to **another account/region** (requiring **versioning on both** accounts, block blobs only). They layer with **soft delete** (undelete within a retention window), **point-in-time restore**, and **lifecycle rules** (to age-out old versions/snapshots for cost control). Versioning ≈ **S3 versioning**; object replication ≈ **S3 CRR/SRR**. Unlike account-level **GRS**, object replication is selective and the destination is independently readable.

[↑ Back to top](#-table-of-contents)

---
---

# 50. 📁 Azure File Shares
> 🟠 MEDIUM
> 📚 Course lectures: 150 (Working with File shares), 151 (Connecting from macOS), 152 (File share snapshots), 153 (Azure File - Soft delete)

---

## 50.1 What Problem Does This Solve?

Many workloads expect a **traditional network file share** — a drive letter or mount point that multiple machines read and write using the **SMB** (or **NFS**) protocol. **Azure Files** provides fully managed cloud file shares you can mount from Windows, Linux, and macOS, on-prem or in Azure, replacing on-premises file servers and enabling **lift-and-shift** of apps that need a shared filesystem.

Think of Azure Files like **a shared network drive in the cloud** — the same `\\server\share` experience your office always had, except Microsoft runs the server, it's reachable from anywhere, and it never runs out of disk or needs patching.

> 💡 **If you know AWS:** Azure Files (SMB) ≈ **Amazon FSx for Windows File Server**; Azure Files (NFS) ≈ **Amazon EFS / FSx for Lustre-style NFS**. **Azure File Sync** (caching shares on local servers) ≈ **AWS Storage Gateway (File Gateway)**. Unlike Blob/S3, this is a **real filesystem with directories and file locking**, mounted via SMB/NFS rather than accessed as objects.

---

## 50.2 Azure Files Essentials (Flow Diagram)

```
                 Storage Account → File service → Share "company-share"
                 mount path: \\acct.file.core.windows.net\company-share
                          │  (SMB 3.x, port 445)   or  NFS 4.1 (premium)
       ┌──────────────────┼───────────────────────┬──────────────────┐
       ▼                  ▼                        ▼                  ▼
  Windows VM          Linux VM                macOS laptop       On-prem server
  net use Z:          mount -t cifs           smb://...          (via Azure File Sync
                                                                  caches it locally)

  Auth: Storage account key  OR  Entra ID / AD DS identity-based (SMB)
  Protect: share Snapshots (point-in-time)  +  Soft delete (recover deleted shares)
```

| Aspect | Detail |
|---|---|
| **Protocols** | **SMB 3.x** (Windows/Linux/macOS) and **NFS 4.1** (Premium only) |
| **Port** | SMB uses **TCP 445** (often blocked by ISPs — use VPN/private endpoint) |
| **Tiers** | Transaction optimized, Hot, Cool (Standard); **Premium** (SSD, low latency) |
| **Auth** | Storage account key, or **identity-based** (AD DS / Entra ID / Entra Domain Services) |
| **Protection** | **Share snapshots** + **soft delete** |
| **Hybrid** | **Azure File Sync** caches shares on local Windows Servers |

⚠️ **Port 445** is commonly blocked by home/ISP networks — mounting then fails from outside Azure unless you use a **VPN, ExpressRoute, or Private Endpoint**. Classic troubleshooting point.

---

## 50.3 UI / CLI Steps — Create, Mount, Protect

```
📍 Storage account → "File shares" → "+ File share"
   Name=company-share, Tier=Transaction optimized → Create
    ↓
📍 Open the share → "Connect" → pick OS → copy the generated mount script:

   Windows (PowerShell):  net use Z: \\acct.file.core.windows.net\company-share /user:...
   Linux:    sudo mount -t cifs //acct.file.core.windows.net/company-share /mnt/share \
               -o vers=3.0,username=acct,password=<key>,serverino
   macOS:    Finder → Go → Connect to Server → smb://acct.file.core.windows.net/company-share
    ↓
📍 Protect:
   Share → "Snapshots" → "+ Add snapshot"  (point-in-time, read-only)
   Storage account → Data protection → ☑ Enable soft delete for file shares (N days)
```

```bash
az storage share-rm create -g rg --storage-account acct -n company-share --quota 100
az storage share snapshot --account-name acct -n company-share
```

---

## 50.4 Integration with Other Azure Services

| Service | Role with Azure Files |
|---|---|
| **Azure File Sync** | Cache/tier shares on on-prem Windows Servers (hybrid) |
| **VMs / AKS / App Service** | Mount shares for shared config, content, persistent volumes |
| **AD DS / Entra ID** | Identity-based SMB auth + NTFS ACLs |
| **Private Endpoint / VPN** | Reach shares privately without exposing port 445 |
| **Azure Backup** | Scheduled backup of file shares (snapshot-based) |

---

## 50.5 Real-World Scenario — Replacing an On-Prem File Server

```
A company retires an aging on-prem file server used by staff and an app.
   1. Create a Premium file share for low-latency app access; a Standard share for
      general staff documents.
   2. Enable identity-based auth (AD DS) so existing NTFS permissions/users carry over.
   3. Deploy Azure File Sync on a local Windows Server as a cache so office users get
      LAN-speed access while the cloud holds the full dataset (cloud tiering frees local disk).
   4. Enable soft delete (14 days) + daily snapshots + Azure Backup for recovery.
   5. Remote staff connect over the company VPN (avoids the port-445 ISP block).
Result: a managed, resilient file share with familiar permissions, hybrid caching, and
built-in backup — no file server to maintain.
```

---

## 50.6 Benefits

- **Fully managed** — no file server OS to patch, scale, or back up
- **Cross-platform** — SMB (Windows/Linux/macOS) and NFS (Premium)
- **Lift-and-shift** — apps needing a shared filesystem move unchanged
- **Hybrid** — Azure File Sync caches shares on-prem with cloud tiering
- **Secure** — identity-based auth + NTFS ACLs, private endpoints
- **Protected** — snapshots, soft delete, and Azure Backup

---

## 50.7 Common Use Cases

- Replacing/extending on-prem file servers (with Azure File Sync)
- Shared storage for lift-and-shift apps and multiple VMs
- Persistent volumes for containers (AKS) and shared App Service content
- Departmental document shares with AD-based permissions

---

## 50.8 Exam Q&A

**Q: You can mount an Azure file share from a VM in Azure but not from your home laptop. What's the most likely cause?**
> **Port 445 (SMB) is blocked** — many ISPs and home routers block outbound TCP 445. From inside Azure it works, but from the internet you need a **VPN, ExpressRoute, or a Private Endpoint** to reach the share privately (or ensure the client/network allows 445). This is the classic Azure Files connectivity gotcha.

**Q: Which protocols does Azure Files support, and what's the limitation on NFS?**
> Azure Files supports **SMB 3.x** (Windows, Linux, macOS) and **NFS 4.1**. **NFS is only available on Premium file shares** (FileStorage accounts) and has no account-key/AD auth in the same way — it relies on network-level security (private endpoint/VNet). SMB is the broadly compatible default; choose NFS for Linux workloads needing POSIX semantics on Premium.

**Q: How can staff keep using their existing file permissions when moving to Azure Files?**
> Enable **identity-based authentication** (on-prem **AD DS**, **Microsoft Entra Domain Services**, or **Entra ID** for SMB), which lets users authenticate with their domain identities and preserves **NTFS ACLs** on files and folders. This makes the migration transparent — the same users and permissions apply, rather than everyone sharing a storage account key.

**Q: What features protect an Azure file share against accidental deletion or changes?**
> **Share snapshots** provide read-only point-in-time copies for restoring files/folders, **soft delete** retains a deleted share for a configurable retention period so it can be recovered, and **Azure Backup** can schedule snapshot-based backups with retention. Together they cover accidental file changes, share deletion, and longer-term recovery.

**Q: What is Azure File Sync and when would you use it?**
> **Azure File Sync** caches Azure file shares on one or more **on-premises Windows Servers**, with **cloud tiering** that keeps hot files local and tiers cold files to the cloud to save local disk. Use it for **hybrid** scenarios — giving branch offices LAN-speed access while centralizing the authoritative data (and backup) in Azure, effectively modernizing traditional file servers.

---

## 50.9 Summary

**Azure Files** offers fully managed cloud **file shares** mounted over **SMB 3.x** (Windows/Linux/macOS) or **NFS 4.1** (Premium only), ideal for **lift-and-shift** apps and replacing on-prem file servers. Shares live in a storage account (`acct.file.core.windows.net\share`), use **TCP 445** for SMB (**often blocked by ISPs** — use VPN/ExpressRoute/Private Endpoint), and support **account-key or identity-based auth** (AD DS/Entra) with **NTFS ACLs**. Protect data with **snapshots, soft delete, and Azure Backup**, and extend to hybrid with **Azure File Sync** (local caching + cloud tiering). Tiers run from **Transaction optimized/Hot/Cool (Standard)** to **Premium (SSD)**.

[↑ Back to top](#-table-of-contents)

---
---

# 51. 🚚 AzCopy & Premium Storage
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 154 (AzCopy Tool), 155 (Premium Storage Accounts)

---

## 51.1 What Problem Does This Solve?

Two practical storage topics. **AzCopy** is a command-line tool for **high-performance bulk data transfer** into, out of, and between storage accounts — far faster and more reliable than portal uploads for large or scripted migrations. **Premium storage** uses **SSD** backing to deliver **low latency and high IOPS/throughput** for transaction-intensive workloads that Standard (HDD) storage can't satisfy.

Think of **AzCopy** like a **professional moving company with a fleet of trucks** — instead of carrying boxes one at a time through the browser, it moves everything in parallel, resumes if interrupted, and follows a checklist (sync). Think of **Premium storage** like **upgrading from a warehouse to an express courier hub** — same goods, but retrieval is near-instant and handles huge request volumes.

> 💡 **If you know AWS:** **AzCopy ≈ the AWS CLI `s3 cp/sync`** (and parts of DataSync) — parallelized, resumable transfers with sync semantics. **Premium storage ≈ choosing SSD-backed options** (e.g., `io2`/provisioned-IOPS EBS for disks, or S3-latency-sensitive setups) — paying for guaranteed low-latency, high-IOPS performance.

---

## 51.2 AzCopy Essentials (Flow Diagram)

```
AzCopy — parallel, resumable transfers; auth via Entra login OR SAS token.

   Local disk ──copy──►  Blob container          (upload)
   Blob container ──copy──►  Local disk           (download)
   Account A ──copy──►  Account B                 (server-to-server, no local hop)
   Source ──sync──►  Destination                  (mirror: only changed/new files)

   azcopy login                      # Entra auth
   azcopy copy "C:\data\*" "https://acct.blob.core.windows.net/data?<SAS>" --recursive
   azcopy sync "C:\site" "https://acct.blob.core.windows.net/$web?<SAS>" --delete-destination=true
```

Key AzCopy traits: **parallelism** (fast), **resume** on failure, **recursive**, **sync** (incremental mirror), **server-to-server** copy (no download/upload round-trip), and **wildcards/filters**.

---

## 51.3 Premium Storage Essentials

```
STANDARD = HDD-backed → general use, lower cost, variable latency.
PREMIUM  = SSD-backed → consistent low latency + high IOPS/throughput.

Premium comes in dedicated account KINDS (chosen per service):
   • Premium Block Blobs  → high-transaction blob workloads (small, frequent ops)
   • Premium File Shares  → low-latency SMB/NFS shares (databases, HPC, lift-and-shift)
   • Premium Page Blobs   → unmanaged disks / low-latency page-blob workloads

Billing model differs: Premium often bills on PROVISIONED capacity, not just used.
Redundancy is limited (mainly LRS/ZRS; no geo for some premium kinds).
```

| | Standard | Premium |
|---|---|---|
| Media | HDD | **SSD** |
| Latency | variable | **consistently low (single-digit ms)** |
| IOPS/throughput | moderate | **high** |
| Cost model | pay for used | often **provisioned** |
| Redundancy | all options | limited (LRS/ZRS mainly) |

---

## 51.4 UI / CLI Steps

```
── AzCopy ──
📍 Download AzCopy → authenticate:
   azcopy login                       (Entra)   — or append a ?SAS to URLs
📍 Upload a folder:
   azcopy copy "/data" "https://acct.blob.core.windows.net/backups?<SAS>" --recursive
📍 Mirror a site (incremental):
   azcopy sync "./public" "https://acct.blob.core.windows.net/$web?<SAS>"
📍 Account-to-account:
   azcopy copy "https://a.blob...../c?<SAS>" "https://b.blob...../c?<SAS>" --recursive

── Premium account ──
📍 Create storage account → Performance = Premium → choose premium kind
   (Block blobs / File shares / Page blobs) → pick LRS/ZRS → Create
```

---

## 51.5 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Storage Explorer** | GUI that uses AzCopy under the hood for transfers |
| **Static website / CDN** | `azcopy sync` deploys site content to `$web` |
| **Azure Migrate / DMS** | Bulk data movement in migrations |
| **Databases / HPC / AKS** | Premium file/disk performance for latency-sensitive workloads |
| **Managed disks** | Premium SSD/Ultra for high-IOPS VM storage |

---

## 51.6 Real-World Scenario — Fast Migration + Performance Tier

```
A team migrates 5 TB of on-prem files to Azure and runs a latency-sensitive database.
   1. Use AzCopy to move the 5 TB: parallel, resumable transfer directly to a blob
      container (far faster than the portal), authenticated with a scoped SAS.
   2. Nightly "azcopy sync" keeps a staging container mirrored during cutover.
   3. For the database's shared storage, provision a PREMIUM file share (SSD) to get
      consistent single-digit-ms latency and high IOPS that Standard HDD can't deliver.
   4. Static marketing site content is pushed to $web with "azcopy sync" in CI/CD.
Result: a fast, reliable bulk migration and the right performance tier for each workload.
```

---

## 51.7 Benefits

- **AzCopy:** fast parallel transfers, resumable, sync/mirroring, server-to-server, scriptable
- **Premium:** consistent low latency, high IOPS/throughput for demanding workloads
- **Right-sizing:** match performance tier to workload, pay Standard prices elsewhere
- **Automation-friendly:** AzCopy fits CI/CD and migration pipelines

---

## 51.8 Common Use Cases

- Bulk uploads/downloads and large migrations (AzCopy)
- Mirroring content to `$web`/containers in CI/CD (azcopy sync)
- Server-to-server copies between storage accounts
- Premium file shares for databases, HPC, and latency-sensitive apps
- Premium block/page blobs for high-transaction or disk workloads

---

## 51.9 Exam Q&A

**Q: Why use AzCopy instead of uploading through the portal for a large migration?**
> AzCopy performs **parallelized, high-throughput transfers** that are **resumable** after interruptions, supports **recursive** folder copies, **sync** (incremental mirroring), **wildcards/filters**, and **server-to-server** copies (no local download/upload hop). The portal is fine for a few files but is slow and fragile for large or scripted transfers, where AzCopy is dramatically faster and more reliable.

**Q: What is the difference between `azcopy copy` and `azcopy sync`?**
> `copy` transfers the specified source to the destination (optionally recursive), re-copying regardless of what's already there. `sync` performs an **incremental mirror** — it transfers only **new or changed** files and (with `--delete-destination`) can remove files at the destination that no longer exist at the source. Use `sync` for repeatable deployments/mirrors, `copy` for one-time transfers.

**Q: When should you choose Premium storage over Standard?**
> Choose **Premium (SSD-backed)** when you need **consistently low latency and high IOPS/throughput** — transaction-heavy blob workloads, latency-sensitive **file shares** (databases, HPC, lift-and-shift), or high-performance **page-blob/disk** workloads. **Standard (HDD)** is cheaper and fine for general data, backups, and infrequent access. The trade-off is Premium's higher cost and often **provisioned** billing.

**Q: How does Premium storage billing and redundancy differ from Standard?**
> Premium frequently bills on **provisioned capacity** (you pay for the size you allocate, not just what's used), whereas Standard bills on **consumed** capacity. Premium also has **more limited redundancy** options (mainly **LRS/ZRS**, with geo-redundancy unavailable for some premium kinds), so it emphasizes performance over the full range of geo-DR choices.

**Q: How does AzCopy authenticate to storage?**
> Two main ways: **`azcopy login`** using **Microsoft Entra ID** (identity-based, recommended, with an appropriate RBAC data role), or appending a **SAS token** to the resource URL (good for scoped, time-limited access without a login). Entra auth avoids embedding secrets; SAS is convenient for delegated or cross-tenant transfers.

---

## 51.10 Summary

**AzCopy** is the command-line workhorse for **bulk storage transfers** — parallel, resumable, recursive, with **sync** (incremental mirroring) and **server-to-server** copies — authenticated via **Entra login or SAS**, and ideal for migrations and CI/CD deployments to `$web`/containers. **Premium storage** is **SSD-backed**, delivering **consistent low latency and high IOPS/throughput** for demanding workloads, offered as dedicated kinds (**Premium Block Blobs, File Shares, Page Blobs**); it typically bills on **provisioned** capacity and has **limited redundancy** (LRS/ZRS). Pick Premium where performance matters and Standard elsewhere, and reach for AzCopy whenever the portal would be too slow or manual. This completes the **Storage** section.

[↑ Back to top](#-table-of-contents)

---
---

# 52. ⌨️ Azure PowerShell
> 🟠 MEDIUM
> 📚 Course lectures: 157–159 (Install PowerShell & Az modules), 160–161 (RG & VNet), 163–170 (Subnet, NIC, Public IP, NSG, VM, Data disk, Storage, Web App labs)

---

## 52.1 What Problem Does This Solve?

Clicking through the portal doesn't scale and isn't repeatable. **Azure PowerShell** (the **Az module**) lets you manage Azure from scripts — creating and configuring resources with cmdlets, automating repetitive tasks, and producing consistent, version-controllable deployments. It's the natural choice for Windows-centric admins and anyone already fluent in PowerShell.

Think of Azure PowerShell like **writing a recipe instead of cooking from memory each time**. The portal is cooking by hand (fine once); a PowerShell script is the written recipe — run it again and again, share it, tweak one ingredient, and get the same dish every time without the guesswork.

> 💡 **If you know AWS:** Azure PowerShell (Az module) is the counterpart to **AWS Tools for PowerShell**. The `New-Az*` / `Get-Az*` / `Remove-Az*` verb-noun cmdlets map to AWS's PowerShell cmdlets. If you've used AWS CloudShell/CLI, Azure PowerShell plays the same scripting role on the Microsoft side, with strongly-typed objects you can pipe between cmdlets.

---

## 52.2 Cmdlet Pattern & Core Workflow (Flow Diagram)

```
Azure PowerShell cmdlets follow Verb-AzNoun:
   New-Az...   Get-Az...   Set-Az...   Remove-Az...   Update-Az...

   Install-Module -Name Az -Scope CurrentUser      # one-time: get the Az module
        │
   Connect-AzAccount                               # sign in (browser/device code)
        │
   Set-AzContext -Subscription "<sub-id>"          # pick the subscription
        │
   New-AzResourceGroup -Name rg -Location centralindia
        │
   New-AzVirtualNetwork / New-AzVM / ...           # build resources
        │
   Get-AzResource / Remove-AzResourceGroup         # inspect / clean up
```

| Concept | Cmdlet example |
|---|---|
| **Install module** | `Install-Module -Name Az` |
| **Sign in** | `Connect-AzAccount` |
| **Select subscription** | `Set-AzContext -Subscription <id>` |
| **Create resource group** | `New-AzResourceGroup` |
| **Create a VM** | `New-AzVM` |
| **List resources** | `Get-AzResource` |
| **Delete** | `Remove-AzResourceGroup -Force` |

⭐ **Az** is the current module; the old **AzureRM** module is **retired** — a likely exam detail. Cmdlets return **objects**, so you can store them in variables and pipe them.

---

## 52.3 UI / Script Steps — Build a VM Stack in PowerShell

```powershell
# One-time setup
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
Connect-AzAccount
Set-AzContext -Subscription "<subscription-id>"

# Resource group + network
New-AzResourceGroup -Name lab-rg -Location centralindia
$vnet   = New-AzVirtualNetwork -ResourceGroupName lab-rg -Location centralindia `
            -Name lab-vnet -AddressPrefix 10.0.0.0/16
Add-AzVirtualNetworkSubnetConfig -Name web -AddressPrefix 10.0.1.0/24 -VirtualNetwork $vnet
$vnet | Set-AzVirtualNetwork

# Public IP, NSG, NIC
$pip = New-AzPublicIpAddress -ResourceGroupName lab-rg -Location centralindia -Name web-pip -AllocationMethod Static -Sku Standard
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName lab-rg -Location centralindia -Name web-nsg
$nic = New-AzNetworkInterface -ResourceGroupName lab-rg -Location centralindia -Name web-nic `
         -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id

# Create the VM
$cred = Get-Credential
New-AzVM -ResourceGroupName lab-rg -Location centralindia -Name web-vm `
  -Image Win2022Datacenter -Size Standard_B2s -Credential $cred -NetworkInterfaceId $nic.Id
```

---

## 52.4 Integration with Other Azure Services

| Service | Role with PowerShell |
|---|---|
| **Azure Automation** | Run PowerShell runbooks on a schedule/trigger |
| **Azure Cloud Shell** | Browser-based PowerShell, pre-authenticated |
| **ARM / Bicep** | `New-AzResourceGroupDeployment` deploys templates |
| **Azure DevOps / GitHub Actions** | Run Az scripts in CI/CD pipelines |
| **Key Vault** | Retrieve secrets in scripts securely |

---

## 52.5 Real-World Scenario — Repeatable Environment Provisioning

```
A team must spin up identical dev/test environments on demand.
   1. Write a parameterized PowerShell script that creates the RG, VNet, subnets, NSG,
      NICs, and VMs with standard tags.
   2. Store it in Git; reviewers approve changes like code.
   3. A new environment = run the script with different parameters (name, region, size).
   4. Teardown at night: Remove-AzResourceGroup -Name <env> -Force stops all billing.
   5. Schedule routine tasks (start/stop VMs) via Azure Automation runbooks using the
      same cmdlets.
Result: consistent, auditable, hands-off provisioning instead of manual portal clicks.
```

---

## 52.6 Benefits

- **Repeatable & consistent** — scripts eliminate manual drift
- **Automatable** — runbooks, scheduled tasks, CI/CD
- **Object pipeline** — pass typed objects between cmdlets
- **Cross-platform** — PowerShell 7 runs on Windows/Linux/macOS
- **Deep coverage** — manage virtually every Azure resource

---

## 52.7 Common Use Cases

- Scripted/bulk resource creation and configuration
- Scheduled operational tasks (start/stop VMs, cleanups) via Automation
- Deploying ARM/Bicep templates
- CI/CD infrastructure steps
- Admin reporting and queries across subscriptions

---

## 52.8 Exam Q&A

**Q: Which PowerShell module do you use for Azure today, and which is deprecated?**
> The current module is **Az** (`Install-Module -Name Az`). The older **AzureRM** module is **retired/deprecated** and no longer supported, so new work uses **Az** cmdlets. Knowing this distinction matters because some legacy scripts/docs reference `*-AzureRm*` cmdlets, which should be migrated to the `*-Az*` equivalents.

**Q: What is the typical sequence to start managing Azure from a local PowerShell session?**
> Install the module (`Install-Module -Name Az`), **authenticate** with **`Connect-AzAccount`**, then **select the subscription** with **`Set-AzContext -Subscription <id>`**. After that you run resource cmdlets (e.g., `New-AzResourceGroup`, `New-AzVM`). Cloud Shell skips the install/auth steps because it's pre-authenticated.

**Q: What naming convention do Azure PowerShell cmdlets follow?**
> **Verb-AzNoun** — e.g., `New-AzResourceGroup`, `Get-AzVM`, `Set-AzNetworkSecurityGroup`, `Remove-AzResourceGroup`. The approved PowerShell **verbs** (New/Get/Set/Remove/Update) make cmdlets predictable, and the **Az** prefix identifies the Azure module. Cmdlets return **objects**, enabling variable capture and piping between commands.

**Q: Why choose PowerShell over the portal for operational tasks?**
> Because it's **repeatable, scriptable, and automatable** — you get consistent results, can version-control and review changes, run tasks on a **schedule** (Automation runbooks) or in **CI/CD**, and operate at **scale/bulk**. The portal is best for exploration and one-off changes; PowerShell is for anything you'll do more than once or need to be reproducible and auditable.

---

## 52.9 Summary

**Azure PowerShell** (the **Az** module — AzureRM is retired) manages Azure through **Verb-AzNoun** cmdlets that return typed, pipeable objects. The core flow is **`Install-Module -Name Az` → `Connect-AzAccount` → `Set-AzContext` → resource cmdlets** (`New-AzResourceGroup`, `New-AzVM`, etc.). It delivers **repeatable, automatable** infrastructure management — powering **Automation runbooks**, **CI/CD**, and **ARM/Bicep deployments** — and runs cross-platform on PowerShell 7. Use it whenever portal clicks won't scale or must be reproducible. It's Azure's parallel to **AWS Tools for PowerShell**.

[↑ Back to top](#-table-of-contents)

---
---

# 53. ☁️ Azure Cloud Shell
> 🟡 KNOW-THIS-MUCH
> 📚 Course lecture: 162 (Using Azure Cloud Shell)

---

## 53.1 What Problem Does This Solve?

Installing and updating CLIs/modules locally, keeping them authenticated, and configuring credentials is friction — especially from a browser, a locked-down machine, or a colleague's computer. **Azure Cloud Shell** is a **browser-based shell**, pre-installed with **Azure CLI and Azure PowerShell**, **already authenticated** to your account, with persistent storage — so you can run commands from anywhere with zero setup.

Think of Cloud Shell like **a fully stocked workshop you can walk into anywhere** — all the tools are already on the bench, plugged in, and labeled with your name. You don't bring or install anything; you just start working, and your personal drawer (file share) is there every time.

> 💡 **If you know AWS:** Azure Cloud Shell is the direct equivalent of **AWS CloudShell** — a browser terminal, pre-authenticated, with the CLI ready to go and persistent storage. It removes the "install and configure credentials" step entirely.

---

## 53.2 Cloud Shell Essentials (Flow Diagram)

```
   portal.azure.com → [>_] Cloud Shell icon (top bar)  — or  shell.azure.com
        │
   First launch: prompts to create/associate a STORAGE ACCOUNT + FILE SHARE
        │  (persists your home dir / scripts across sessions)
        ▼
   Choose environment:  ┌─ Bash  (Azure CLI, az)        ┐
                        └─ PowerShell  (Az module)       ┘  (switch anytime)
        │
   Already signed in → run  az ...  or  Get-Az...  immediately (no Connect-AzAccount)

   Pre-installed extras: git, kubectl, terraform, python, jq, code (editor), etc.
   Session times out after ~20 min idle; files in the share persist.
```

| Feature | Detail |
|---|---|
| **Access** | Portal `>_` icon or `shell.azure.com` |
| **Shells** | **Bash** (Azure CLI) and **PowerShell** (Az) — switchable |
| **Auth** | **Pre-authenticated** to your account (no sign-in cmdlet) |
| **Persistence** | Backed by an **Azure Files share** (a small storage cost) |
| **Pre-installed** | az, Az module, git, kubectl, terraform, python, jq, editor |
| **Idle timeout** | ~20 minutes (files persist, session resets) |

⚠️ Cloud Shell **requires a storage account/file share** for persistence (the only real cost). It also runs commands as **your identity**, so it inherits your RBAC permissions.

---

## 53.3 UI Steps

```
📍 portal.azure.com → click the ">_" Cloud Shell icon in the top toolbar
    ↓
📍 First time: "You have no storage mounted" → Create storage (RG + storage account + share)
    ↓
📍 Pick Bash or PowerShell (toggle in the top-left of the shell)
    ↓
📍 Run immediately (already signed in):
     Bash:        az group list -o table
     PowerShell:  Get-AzResourceGroup
    ↓
📍 Upload/download files via the shell's toolbar; edit with built-in "code ."
```

---

## 53.4 Integration with Other Azure Services

| Service | Role with Cloud Shell |
|---|---|
| **Azure Files** | Persists the Cloud Shell home directory/scripts |
| **Azure CLI & PowerShell** | The two pre-installed, pre-authenticated environments |
| **Managed tools** | git, kubectl, terraform, Bicep for IaC and Kubernetes |
| **RBAC / Entra** | Runs as your identity with your permissions |

---

## 53.5 Real-World Scenario — Zero-Setup Admin from Anywhere

```
An admin is helping troubleshoot from a locked-down client machine with nothing installed.
   1. Open portal.azure.com → click Cloud Shell → it's already authenticated.
   2. Run az/PowerShell commands to inspect NSGs, restart a VM, check logs — no local tools.
   3. Their frequently used scripts are in the mounted file share from previous sessions.
   4. When done, close the browser; nothing was installed on the client machine.
Result: full administrative capability from any browser, instantly and securely, with
personal scripts persisted in the file share.
```

---

## 53.6 Benefits

- **Zero setup** — no installs, no credential config
- **Pre-authenticated** — starts in your account context
- **Anywhere** — any browser, any device
- **Both shells** — Bash/CLI and PowerShell/Az in one place
- **Persistent** — scripts/files saved in the file share
- **Loaded** — git, kubectl, terraform, Bicep, editor included

---

## 53.7 Common Use Cases

- Quick administration from a browser or borrowed machine
- Running CLI/PowerShell without local installation
- Ad-hoc troubleshooting and resource inspection
- Running kubectl/terraform/Bicep without a local toolchain
- Teaching/demos where setup should be avoided

---

## 53.8 Exam Q&A

**Q: What must you set up the first time you use Cloud Shell, and why?**
> Cloud Shell prompts you to **create or associate a storage account with an Azure Files share**, which persists your **home directory and scripts** across sessions (sessions themselves are ephemeral and reset after idle timeout). This file share is the only notable cost of Cloud Shell, and without it your files wouldn't survive between sessions.

**Q: Do you need to run `Connect-AzAccount` or `az login` in Cloud Shell?**
> **No** — Cloud Shell is **already authenticated** as the identity you signed into the portal with, so you can run `az` or `Az` cmdlets immediately. This pre-authentication (plus pre-installed tools) is the main convenience over a local shell, where you'd have to install the tooling and sign in manually.

**Q: Which shell environments does Cloud Shell offer, and can you switch between them?**
> It offers **Bash** (with the **Azure CLI**) and **PowerShell** (with the **Az** module), and you can **switch between them** from the shell's selector at any time. Both run the same pre-installed tooling (git, kubectl, terraform, Bicep), so you choose whichever syntax you prefer for a given task.

**Q: Cloud Shell runs commands using whose permissions?**
> It runs as **your signed-in identity**, so it's bound by **your RBAC role assignments** — you can only do what your permissions allow. There's no privilege escalation; Cloud Shell simply provides a convenient, pre-configured environment for the access you already have.

---

## 53.9 Summary

**Azure Cloud Shell** is a **browser-based, pre-authenticated** shell offering both **Bash (Azure CLI)** and **PowerShell (Az)** with no local installation. Launch it from the portal's **`>_`** icon or **shell.azure.com**; on first use it provisions an **Azure Files share** to persist your home directory and scripts (its only real cost). It comes loaded with **git, kubectl, terraform, Bicep, and an editor**, runs as **your identity** (bound by your RBAC), and times out after ~20 minutes idle while keeping your files. It's ideal for zero-setup administration from anywhere — Azure's equivalent of **AWS CloudShell**.

[↑ Back to top](#-table-of-contents)

---
---

# 54. 🖥️ Azure CLI
> 🟠 MEDIUM
> 📚 Course lectures: 171 (Azure CLI), 172–179 (CLI labs: RG, VNet, Public IP, NIC, NSG, Storage, VM, Web App)

---

## 54.1 What Problem Does This Solve?

The **Azure CLI** (`az`) is a cross-platform command-line tool for managing Azure with concise, readable commands. It's the scripting tool of choice for Linux/macOS admins, DevOps pipelines, and anyone who prefers a simple `az <group> <command>` syntax over PowerShell's verb-noun objects. Like PowerShell, it makes deployments **repeatable, scriptable, and automatable**.

Think of the Azure CLI like **a universal remote with clearly labeled buttons** — `az vm create`, `az network vnet create`. The command reads almost like plain English (noun then verb), works the same on any OS, and slots neatly into shell scripts and pipelines.

> 💡 **If you know AWS:** The Azure CLI is the counterpart to the **AWS CLI** (`aws`). Structure differs slightly — Azure uses **`az <group> <subgroup> <action>`** (e.g., `az vm create`) versus AWS's `aws <service> <action>`. Output formats (`--output table/json/tsv`) and `--query` (**JMESPath**) match the AWS CLI's `--output` and `--query` exactly.

---

## 54.2 CLI Structure & Core Workflow (Flow Diagram)

```
Azure CLI pattern:   az  <group> [<subgroup>] <command>  [--options]

   az login                                   # sign in (browser/device code)
   az account set --subscription "<id>"       # choose subscription
        │
   az group create -n lab-rg -l centralindia
   az network vnet create -g lab-rg -n lab-vnet --address-prefix 10.0.0.0/16 \
        --subnet-name web --subnet-prefix 10.0.1.0/24
   az vm create -g lab-rg -n web-vm --image Ubuntu2204 --size Standard_B2s \
        --admin-username azureuser --generate-ssh-keys
        │
   az resource list -o table                  # inspect
   az group delete -n lab-rg --yes            # clean up

   Helpful: --output table|json|tsv   --query "<JMESPath>"   az <cmd> --help   az interactive
```

| Concept | Command example |
|---|---|
| **Sign in** | `az login` |
| **Select subscription** | `az account set --subscription <id>` |
| **Create RG** | `az group create -n rg -l centralindia` |
| **Create VM** | `az vm create ...` |
| **Output format** | `--output table` / `json` / `tsv` |
| **Filter/query** | `--query "[?location=='centralindia'].name"` |
| **Help** | `az vm create --help` |

⭐ `--query` uses **JMESPath** and `--output tsv` is ideal for capturing values in scripts (e.g., `IP=$(az vm show -d ... --query publicIps -o tsv)`).

---

## 54.3 UI / Script Steps — Build a VM Stack in CLI

```bash
az login
az account set --subscription "<subscription-id>"

# Resource group + network
az group create -n lab-rg -l centralindia
az network vnet create -g lab-rg -n lab-vnet \
  --address-prefix 10.0.0.0/16 --subnet-name web --subnet-prefix 10.0.1.0/24

# Public IP + NSG
az network public-ip create -g lab-rg -n web-pip --sku Standard
az network nsg create -g lab-rg -n web-nsg
az network nsg rule create -g lab-rg --nsg-name web-nsg -n allow-ssh \
  --priority 300 --destination-port-ranges 22 --access Allow --protocol Tcp

# NIC + VM
az network nic create -g lab-rg -n web-nic --vnet-name lab-vnet --subnet web \
  --public-ip-address web-pip --network-security-group web-nsg
az vm create -g lab-rg -n web-vm --nics web-nic --image Ubuntu2204 \
  --size Standard_B2s --admin-username azureuser --generate-ssh-keys

# Get the public IP
az vm show -d -g lab-rg -n web-vm --query publicIps -o tsv
```

---

## 54.4 Integration with Other Azure Services

| Service | Role with Azure CLI |
|---|---|
| **Cloud Shell** | Pre-installed, pre-authenticated `az` (Bash) |
| **CI/CD (DevOps/GitHub Actions)** | `az` steps deploy and configure resources |
| **ARM / Bicep** | `az deployment group create` deploys templates |
| **AKS / containers** | `az aks`, `az acr` manage Kubernetes/registries |
| **Key Vault** | `az keyvault secret show` retrieves secrets in scripts |

---

## 54.5 Real-World Scenario — DevOps Pipeline Provisioning

```
A DevOps pipeline must provision infrastructure before deploying an app.
   1. The pipeline authenticates with a service principal: az login --service-principal ...
   2. az group create + az deployment group create deploy a Bicep/ARM template.
   3. az commands capture outputs (--query -o tsv) like the app's URL and connection strings.
   4. The app is deployed, and smoke-test commands verify it.
   5. Ephemeral PR environments are torn down with az group delete --yes --no-wait.
Result: fully scripted, cross-platform infrastructure automation inside CI/CD, with
readable commands the whole team can maintain.
```

---

## 54.6 Benefits

- **Cross-platform** — Windows, Linux, macOS, Cloud Shell
- **Readable syntax** — `az <group> <command>`, close to plain English
- **Scriptable/automatable** — ideal for Bash and CI/CD
- **Powerful output control** — `--output` formats + `--query` (JMESPath)
- **Complete coverage** — manages the full breadth of Azure services
- **Discoverable** — `--help` and `az interactive`

---

## 54.7 Common Use Cases

- Scripted resource provisioning and configuration
- CI/CD infrastructure and deployment steps
- Capturing resource values for scripts (`-o tsv` + `--query`)
- Managing AKS, ACR, and PaaS from the command line
- Cross-platform automation where PowerShell isn't preferred

---

## 54.8 Exam Q&A

**Q: How is Azure CLI command structure organized?**
> As **`az <group> [<subgroup>] <command> [--options]`** — for example `az vm create`, `az network vnet subnet create`, `az storage account list`. The **group** names the service area and the **command** the action, making commands readable and discoverable (`az <group> --help` lists what's available). This differs from PowerShell's Verb-AzNoun object model.

**Q: You need to capture just a VM's public IP in a Bash script. Which options help?**
> Use **`--query`** (JMESPath) to select the field and **`--output tsv`** to get a raw, unquoted value, e.g. `IP=$(az vm show -d -g rg -n vm --query publicIps -o tsv)`. `--query` filters/projects the JSON and `-o tsv` makes it script-friendly (no quotes/brackets), which is the standard pattern for using CLI output in automation.

**Q: How does the Azure CLI authenticate in an automated pipeline (no interactive user)?**
> With a **service principal** (or managed identity): `az login --service-principal -u <appId> -p <secret/cert> --tenant <tenantId>`. This provides non-interactive, scoped credentials for CI/CD, replacing the browser-based `az login`. Using a managed identity (on an Azure-hosted agent) is even better since there's no secret to store.

**Q: Azure CLI vs Azure PowerShell — how do you choose?**
> Both are **cross-platform** and fully capable; the choice is largely **preference and ecosystem**. Pick the **CLI** for Bash/Linux-centric workflows and simple, readable commands; pick **PowerShell** when you want the **object pipeline** and you're in a Windows/PowerShell-heavy environment. Many teams standardize on one for consistency; the exam treats them as equivalent tools.

**Q: What output formats does the Azure CLI support, and when is each useful?**
> **json** (default — full structured output, good for parsing with jq), **table** (human-readable columns for quick reading), and **tsv** (raw tab-separated values, ideal for capturing single values in scripts). Choosing the right `--output` format makes CLI results either easy to read or easy to consume programmatically.

---

## 54.9 Summary

The **Azure CLI** (`az`) is a **cross-platform** command-line tool using the readable **`az <group> <command>`** pattern. The core flow is **`az login` → `az account set` → resource commands** (`az group create`, `az vm create`, etc.). It shines in **Bash and CI/CD**, authenticates non-interactively via **service principals/managed identities**, and offers powerful output control with **`--output table/json/tsv`** and **`--query` (JMESPath)** — use `-o tsv` + `--query` to capture values in scripts. It's functionally equivalent to **Azure PowerShell** (choose by preference) and is pre-installed and pre-authenticated in **Cloud Shell**. This completes the **PowerShell & CLI** section.

[↑ Back to top](#-table-of-contents)

---
---

# 55. 📄 ARM Templates — Structure & Deployment
> 🟠 MEDIUM
> 📚 Course lectures: 180–181 (What are ARM templates), 182 (ARM Template structure), 183 (VS Code setup), 184–186 (Deploying RG & Storage Account)

---

## 55.1 What Problem Does This Solve?

Scripts (PowerShell/CLI) create resources **imperatively** — step by step, and you must handle "does it already exist?" logic yourself. **ARM templates** take a **declarative** approach: you describe the **desired end state** in **JSON**, and Azure Resource Manager figures out how to get there, creating/updating resources **idempotently**. This is **Infrastructure as Code (IaC)** — repeatable, version-controlled, consistent deployments.

Think of the difference like **giving directions vs. giving an address**. A script is turn-by-turn directions ("create this, then that, then check if..."). An ARM template is just the **destination address** — you declare *what* you want, and Azure's GPS (Resource Manager) works out the route and skips steps already done.

> 💡 **If you know AWS:** ARM templates are Azure's **AWS CloudFormation**. Both are declarative JSON (CloudFormation also YAML) describing desired state, deployed as a managed **stack/deployment**, idempotent, with parameters, resources, and outputs. **Bicep** (next topics) is the cleaner DSL that compiles to ARM — roughly analogous to the CDK/alternative authoring experiences on AWS.

---

## 55.2 ARM Template Structure (Flow Diagram)

```
A template is a JSON document with these top-level sections:

   {
     "$schema": "...deploymentTemplate.json#",   ← tells tools it's an ARM template
     "contentVersion": "1.0.0.0",
     "parameters":  { ... },   ← inputs supplied at deploy time (env, size, name)
     "variables":   { ... },   ← computed/reused values inside the template
     "resources":   [ ... ],   ← WHAT to deploy (the required core section)
     "outputs":     { ... }    ← values returned after deployment (IPs, IDs)
   }

Deployment SCOPES:  Resource Group (common) · Subscription · Management Group · Tenant

Deploy:  az deployment group create -g rg --template-file azuredeploy.json \
            --parameters @azuredeploy.parameters.json
         (or New-AzResourceGroupDeployment in PowerShell)
```

| Section | Purpose | Required? |
|---|---|---|
| **$schema** | Identifies the template language version | ✅ |
| **contentVersion** | Your own version string | ✅ |
| **parameters** | Deploy-time inputs | optional |
| **variables** | Reusable computed values | optional |
| **resources** | The resources to deploy | ✅ (the heart) |
| **outputs** | Values returned post-deploy | optional |

⭐ ARM deployments are **idempotent** — redeploying the same template is safe; Azure only changes what differs from current state (**incremental** mode by default; **complete** mode deletes resources not in the template).

---

## 55.3 Deployment Modes

```
INCREMENTAL (default):  adds/updates resources in the template; LEAVES others alone.
COMPLETE:               makes the RG match the template EXACTLY — resources in the RG
                        but NOT in the template are DELETED.  ⚠ use with care.
```

---

## 55.4 UI / CLI Steps — Author & Deploy

```
📍 Install VS Code + the "Azure Resource Manager (ARM) Tools" extension
   (IntelliSense, snippets like "arm!", validation)
    ↓
📍 Create azuredeploy.json (schema + a resources array, e.g., a storage account)
    ↓
📍 Validate and deploy:
```
```bash
# What-if preview (shows changes before applying)
az deployment group what-if -g lab-rg --template-file azuredeploy.json

# Deploy (incremental by default)
az deployment group create -g lab-rg \
  --template-file azuredeploy.json \
  --parameters storageName=mystore2026

# PowerShell equivalent
New-AzResourceGroupDeployment -ResourceGroupName lab-rg `
  -TemplateFile azuredeploy.json -storageName mystore2026
```
```
📍 Template to deploy a RESOURCE GROUP itself uses a SUBSCRIPTION-scope deployment:
   az deployment sub create --location centralindia --template-file rg.json
```

Minimal storage-account resource snippet:
```json
"resources": [{
  "type": "Microsoft.Storage/storageAccounts",
  "apiVersion": "2023-01-01",
  "name": "[parameters('storageName')]",
  "location": "[resourceGroup().location]",
  "sku": { "name": "Standard_LRS" },
  "kind": "StorageV2"
}]
```

---

## 55.5 Integration with Other Azure Services

| Service | Role with ARM |
|---|---|
| **Azure Resource Manager** | The engine that validates and deploys templates |
| **Bicep** | Compiles to ARM JSON (authoring layer) |
| **CI/CD pipelines** | Deploy templates via `az deployment`/PowerShell |
| **Template specs** | Store/version templates as first-class Azure resources |
| **Azure Policy** | Governs/validates what templates may deploy |
| **VS Code ARM Tools** | Authoring, IntelliSense, validation |

---

## 55.6 Real-World Scenario — Standardized Landing Zones

```
A company must deploy identical, compliant environments for each new project.
   1. Author an ARM template defining the VNet, subnets, NSGs, storage, and tags.
   2. Store it in Git and publish it as a Template Spec (versioned, shareable).
   3. For each project: deploy with project-specific parameters (name, region, CIDR).
   4. Run "what-if" in CI to preview changes before applying — no surprises.
   5. Because deployments are idempotent, re-running corrects drift back to the declared state.
Result: consistent, auditable, policy-compliant environments from a single source of truth.
```

---

## 55.7 Benefits

- **Declarative IaC** — describe desired state, not steps
- **Idempotent** — safe to redeploy; only changes what differs
- **Repeatable & consistent** — eliminate configuration drift
- **Version-controlled** — templates reviewed and tracked like code
- **what-if preview** — see changes before applying
- **Full coverage & ordering** — ARM handles dependencies and parallelism

---

## 55.8 Common Use Cases

- Repeatable environment/landing-zone deployments
- Standardized, compliant multi-resource stacks
- CI/CD infrastructure deployments
- Sharing versioned templates via Template Specs
- Correcting drift by redeploying the declared state

---

## 55.9 Exam Q&A

**Q: What is the difference between an imperative script and a declarative ARM template?**
> An **imperative** script (PowerShell/CLI) specifies the **exact steps** and must handle existence/ordering logic itself. A **declarative** ARM template describes the **desired end state** in JSON, and **Azure Resource Manager** determines how to achieve it — creating or updating only what's needed, handling dependencies, and running **idempotently**. Declarative IaC is more repeatable and drift-resistant.

**Q: Which section of an ARM template is required, and what are the other key sections?**
> The **`resources`** array is the essential section (what to deploy), along with **`$schema`** and **`contentVersion`**. Optional but common sections are **`parameters`** (deploy-time inputs), **`variables`** (reusable computed values), and **`outputs`** (values returned after deployment, like IPs or resource IDs). Together they make templates parameterized and reusable.

**Q: What is the difference between Incremental and Complete deployment modes?**
> **Incremental** (the **default**) adds or updates the resources in the template and **leaves existing resources alone**. **Complete** mode makes the resource group **exactly match** the template — any resource in the RG but **not** in the template is **deleted**. Complete mode is powerful for enforcing exact state but risky, so it's used deliberately and usually previewed with what-if.

**Q: How can you preview what a template deployment will change before running it?**
> Use the **what-if** operation — `az deployment group what-if` (or `-WhatIf` in PowerShell) — which reports what would be **created, modified, or deleted** without applying changes. This is especially important before **Complete**-mode deployments, and in CI/CD it provides a safe review gate before infrastructure changes are committed.

**Q: Are ARM deployments idempotent, and why does that matter?**
> **Yes** — redeploying the same template produces the same result and only changes resources that **differ** from the current state (in incremental mode). This matters because you can **safely re-run** deployments to correct **drift** or apply updates without fear of duplicating resources or causing errors, which is fundamental to reliable Infrastructure as Code.

---

## 55.10 Summary

**ARM templates** are **declarative JSON** describing the **desired state** of Azure resources, deployed **idempotently** by **Azure Resource Manager** — the foundation of **Infrastructure as Code** on Azure (equivalent to **AWS CloudFormation**). A template has **$schema**, **contentVersion**, optional **parameters/variables/outputs**, and the required **resources** array. Deploy with **`az deployment group create`** / **`New-AzResourceGroupDeployment`**, preview with **what-if**, and choose **Incremental** (default, additive) or **Complete** (exact match — deletes extras) mode. Author in **VS Code with the ARM Tools extension**. Next: parameters, variables, and dependencies in depth, then **Bicep** — the cleaner language that compiles to ARM.

[↑ Back to top](#-table-of-contents)

---
---

# 56. 🧩 ARM Templates — Parameters, Variables & Dependencies
> 🟠 MEDIUM
> 📚 Course lectures: 187 (Multiple copies of a resource), 194 (Using parameters), 195 (Secure String), 196 (Parameters file), 197 (Dependency across resources), 198–200 (Availability Set/VM, Data disk, Custom Script Extensions)

---

## 56.1 What Problem Does This Solve?

A hard-coded template only deploys one exact thing. To make templates **reusable** across environments and to deploy resources in the **right order**, ARM provides **parameters** (deploy-time inputs), **variables** (reusable computed values), **copy loops** (deploy N copies), **secure parameters** (for secrets), and **dependencies** (`dependsOn`) so resources build in the correct sequence. These features turn a static template into a flexible, production-grade IaC asset.

Think of it like **a blueprint with fill-in-the-blanks and a build order**. Parameters are the blanks you fill per project (building name, number of floors). Variables are measurements derived once and reused. The dependency list is the construction order — you can't install windows before the walls exist. Copy loops are "repeat this floor 10 times."

> 💡 **If you know AWS:** Parameters ≈ **CloudFormation Parameters**; variables ≈ CFN **Mappings/`!Sub` values**; `dependsOn` ≈ CFN **`DependsOn`** (with implicit dependencies via references); copy loops ≈ CFN **`Count`/loops**; **secureString** ≈ **NoEcho** parameters (ideally sourced from **Key Vault**, like SSM/Secrets Manager references).

---

## 56.2 The Reusability & Ordering Features (Flow Diagram)

```
PARAMETERS (inputs)          VARIABLES (computed, reused)
   "vmSize": { "type":"string",   "nicName": "[concat(parameters('vmName'),'-nic')]"
      "defaultValue":"Standard_B2s",
      "allowedValues":[...] }

SECURE PARAMETER (secrets never logged)
   "adminPassword": { "type": "secureString" }    ← or reference KEY VAULT in params file

COPY LOOP (N copies of a resource)
   "copy": { "name":"vmLoop", "count": "[parameters('vmCount')]" }
   name: "[concat('vm-', copyIndex())]"           ← vm-0, vm-1, vm-2 ...

DEPENDENCIES (ordering)
   VM  dependsOn  →  [ NIC ]   NIC dependsOn → [ VNet, Public IP ]
   (referencing another resource's property creates an IMPLICIT dependency too)
```

| Feature | Purpose |
|---|---|
| **parameters** | Inputs at deploy time (with `defaultValue`, `allowedValues`, types) |
| **variables** | Values computed once and reused (e.g., derived names) |
| **secureString / secureObject** | Secrets that are never logged/returned |
| **parameters file** | External JSON supplying values per environment |
| **copy / copyIndex()** | Deploy multiple copies of a resource/property |
| **dependsOn** | Explicit deployment ordering between resources |

⭐ Referencing one resource inside another (via `resourceId()`/`reference()`) creates an **implicit dependency**, so you often don't need explicit `dependsOn`. Use **secureString** (or Key Vault references) for passwords — never plain parameters.

---

## 56.3 Parameters File & Secure Values

```
azuredeploy.json              ← the template (defines parameters)
azuredeploy.parameters.json   ← values for a specific environment:

   {
     "$schema": "...parameters.json#",
     "parameters": {
       "vmName":   { "value": "web-prod" },
       "vmSize":   { "value": "Standard_D2s_v5" },
       "adminPassword": {
         "reference": {                         ← pull a secret from Key Vault
           "keyVault": { "id": "/subscriptions/.../vaults/my-kv" },
           "secretName": "vmAdminPassword"
         }
       }
     }
   }
```
Deploy per environment by swapping the parameters file — same template, different inputs.

---

## 56.4 UI / CLI Steps — Parameters, Loop, Dependency

```bash
# Deploy with a parameters file (per-environment values)
az deployment group create -g lab-rg \
  --template-file azuredeploy.json \
  --parameters @azuredeploy.parameters.prod.json

# Override a single parameter inline
az deployment group create -g lab-rg --template-file azuredeploy.json \
  --parameters vmCount=3 vmSize=Standard_B2s
```

Copy-loop + dependency snippet:
```json
"resources": [
  {
    "type": "Microsoft.Network/networkInterfaces",
    "apiVersion": "2023-05-01",
    "name": "[concat('nic-', copyIndex())]",
    "copy": { "name": "nicLoop", "count": "[parameters('vmCount')]" },
    "location": "[resourceGroup().location]",
    "properties": { "...": "..." }
  },
  {
    "type": "Microsoft.Compute/virtualMachines",
    "apiVersion": "2023-09-01",
    "name": "[concat('vm-', copyIndex())]",
    "copy": { "name": "vmLoop", "count": "[parameters('vmCount')]" },
    "dependsOn": [ "[concat('nic-', copyIndex())]" ],   // VM waits for its NIC
    "properties": { "...": "..." }
  }
]
```

---

## 56.5 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Key Vault** | Supplies secrets to secure parameters via references |
| **Custom Script Extension** | A VM resource that runs post-deploy configuration scripts |
| **Availability Sets / Managed disks** | Deployed and ordered within templates (dependsOn) |
| **Template Specs / CI/CD** | Reuse parameterized templates across environments |
| **Bicep** | Offers the same features with far cleaner syntax |

---

## 56.6 Real-World Scenario — One Template, Many Environments

```
A team deploys the same app stack to dev, test, and prod from one template.
   1. The template exposes parameters: environment name, VM count, size, and admin password.
   2. Three parameters files (dev/test/prod) set different values; prod pulls the admin
      password from Key Vault via a secure reference (never stored in the file).
   3. A copy loop deploys the right number of VMs per environment (dev=1, prod=4),
      each into an Availability Set with a data disk.
   4. dependsOn ensures NIC → VM ordering; a Custom Script Extension installs the app after
      the VM exists.
   5. CI/CD runs what-if, then deploys with the matching parameters file.
Result: a single, reviewed template produces correctly-sized, secure, ordered deployments
for every environment.
```

---

## 56.7 Benefits

- **Reusable** — one template, many environments via parameters/parameters files
- **Secure** — secrets via secureString/Key Vault references, never logged
- **Scalable authoring** — copy loops deploy N resources without duplication
- **Correct ordering** — dependsOn (and implicit references) sequence deployments
- **Maintainable** — variables centralize derived values and naming
- **Post-deploy config** — Custom Script Extensions finish VM setup

---

## 56.8 Common Use Cases

- Multi-environment deployments (dev/test/prod) from one template
- Deploying N identical resources (VMs, NICs, disks) via copy loops
- Injecting secrets securely from Key Vault
- Enforcing resource build order (network → NIC → VM)
- Running post-provision configuration with Custom Script Extensions

---

## 56.9 Exam Q&A

**Q: What's the difference between parameters and variables in an ARM template?**
> **Parameters** are **inputs supplied at deploy time** (with optional `defaultValue`, `allowedValues`, and types), used to customize a deployment per environment. **Variables** are **values computed once inside the template** and reused — typically for derived names or repeated expressions. Parameters change between deployments; variables keep the template DRY and consistent within a deployment.

**Q: How should you pass a VM admin password or other secret into a template?**
> Declare the parameter as **`secureString`** (or `secureObject`), which ensures the value is **never logged or returned in outputs**. Better still, store the secret in **Key Vault** and **reference it** from the parameters file (`keyVault`/`secretName`), so the secret is never placed in the template or parameters file at all. Never use a plain string parameter for secrets.

**Q: How do you deploy multiple copies of a resource, and how do you name each one uniquely?**
> Use the **`copy`** element with a **`count`**, and use the **`copyIndex()`** function to generate unique names/values (e.g., `concat('vm-', copyIndex())` → vm-0, vm-1, …). This deploys N instances from a single resource definition, avoiding copy-paste, and `copyIndex()` also lets you vary per-instance properties.

**Q: What are implicit vs explicit dependencies, and why do they matter?**
> An **explicit** dependency is declared with **`dependsOn`**, forcing one resource to deploy after another. An **implicit** dependency is created automatically when one resource **references** another (e.g., a VM referencing its NIC via `resourceId()`), so ARM infers the order. They matter because ARM deploys resources **in parallel by default** — dependencies ensure prerequisites (like a NIC or VNet) exist before dependents (like a VM) are created.

**Q: What is a parameters file and why use one?**
> A **parameters file** is a separate JSON file that supplies **values** for a template's parameters, letting you deploy the **same template** with **different inputs per environment** (dev/test/prod) by simply swapping files. It keeps environment-specific values (and Key Vault secret references) out of the template itself, improving reuse, clarity, and security.

**Q: What does the Custom Script Extension do in a VM deployment?**
> It's a VM extension that **runs a script on the VM after it's provisioned** (e.g., install software, configure the app), enabling **post-deployment configuration** as part of the template. This bridges infrastructure provisioning and software setup, so a single deployment can produce a fully configured, ready-to-use VM.

---

## 56.10 Summary

ARM's reusability and ordering features turn static templates into production IaC: **parameters** (deploy-time inputs with defaults/allowed values), **variables** (reused computed values), **parameters files** (per-environment values), **secureString/Key Vault references** (for secrets — never plain strings), **copy loops + copyIndex()** (deploy N resources), and **dependsOn** plus **implicit references** (correct build order, since ARM deploys in parallel by default). **Custom Script Extensions** add post-deploy VM configuration. Together they let **one reviewed template** deploy securely and correctly across **dev/test/prod**. These same capabilities exist in **Bicep** with far cleaner syntax — the next section. This completes the **ARM Templates** section.

[↑ Back to top](#-table-of-contents)

---
---

# 57. 💪 Bicep — Fundamentals & Deployment
> 🟠 MEDIUM
> 📚 Course lectures: 202–203 (Introduction to Bicep), 204–205 (RG & Storage Account), 207–212 (VNet, Public IP, NIC, NSG, associate, VM), 217 (Web App)

---

## 57.1 What Problem Does This Solve?

ARM templates are powerful but their **JSON is verbose, bracket-heavy, and hard to read/write** (`"[concat(...)]"` everywhere). **Bicep** is a **domain-specific language (DSL)** that compiles down to ARM JSON but is dramatically cleaner — no mandatory schema boilerplate, simple syntax, automatic dependency detection, and first-class tooling. It gives you all of ARM's declarative, idempotent power with a fraction of the friction.

Think of Bicep like **writing in plain prose instead of legal boilerplate**. ARM JSON is the dense legal contract (correct, but exhausting to read). Bicep is the plain-language summary that says exactly the same thing — and a tool automatically "translates" it back into the formal contract (ARM JSON) that Azure requires.

> 💡 **If you know AWS:** Bicep is a **transpiled IaC language** that compiles to ARM JSON — conceptually like using a cleaner authoring layer over CloudFormation (similar in spirit to the **AWS CDK**, though Bicep is declarative/DSL rather than imperative code). If you found CloudFormation YAML more pleasant than raw JSON, Bicep is that leap for Azure — and Microsoft's **recommended** IaC language going forward.

---

## 57.2 Bicep vs ARM & Core Syntax (Flow Diagram)

```
   main.bicep  ──(az bicep build / automatic on deploy)──►  ARM JSON  ──► Azure
   (you write this, clean)                                  (generated)

ARM JSON (verbose):                      Bicep (clean):
 "resources":[{                           resource sa 'Microsoft.Storage/
   "type":"Microsoft.Storage/                 storageAccounts@2023-01-01' = {
      storageAccounts",                     name: storageName
   "apiVersion":"2023-01-01",               location: resourceGroup().location
   "name":"[parameters('n')]",              sku: { name: 'Standard_LRS' }
   "location":"[resourceGroup()              kind: 'StorageV2'
      .location]", ... }]                  }

Key Bicep elements:
   param    name string = 'default'     ← input (typed, optional default)
   var      nicName = '${vmName}-nic'   ← computed value (string interpolation)
   resource <symbolic> '<type>@<api>' = { ... }   ← a resource
   output   saId string = sa.id         ← return a value
   module   net 'vnet.bicep' = { ... }  ← reuse another Bicep file
```

| Bicep improvement over ARM JSON | Benefit |
|---|---|
| No `$schema`/brackets boilerplate | Far less noise |
| **Automatic dependency detection** | Rarely need `dependsOn` (uses symbolic references) |
| **String interpolation** `'${x}'` | Cleaner than `concat()` |
| **Modules** | Native, simple reuse (vs linked templates) |
| **Type safety + IntelliSense** | Errors caught while authoring |
| Transparent **decompile/build** | `az bicep decompile` / `build` convert to/from ARM |

⭐ Bicep is **idempotent and declarative** exactly like ARM (it *is* ARM underneath), and needs **no separate state file** (unlike Terraform) — Azure is the source of truth.

---

## 57.3 UI / CLI Steps — Author & Deploy Bicep

```
📍 Install VS Code + the "Bicep" extension (IntelliSense, validation, snippets)
📍 Azure CLI has Bicep built in (az automatically compiles .bicep on deploy)
    ↓
📍 Write main.bicep (a storage account example):
```
```bicep
param storageName string
param location string = resourceGroup().location

resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageName
  location: location
  sku: { name: 'Standard_LRS' }
  kind: 'StorageV2'
  properties: { minimumTlsVersion: 'TLS1_2', supportsHttpsTrafficOnly: true }
}

output storageId string = sa.id
```
```bash
# Deploy directly (az compiles the .bicep automatically)
az deployment group create -g lab-rg \
  --template-file main.bicep --parameters storageName=mystore2026

# Preview changes
az deployment group what-if -g lab-rg --template-file main.bicep --parameters storageName=mystore2026

# Convert between Bicep and ARM
az bicep build --file main.bicep        # Bicep → ARM JSON
az bicep decompile --file azuredeploy.json   # ARM JSON → Bicep
```

---

## 57.4 Integration with Other Azure Services

| Service | Role with Bicep |
|---|---|
| **Azure Resource Manager** | Executes the compiled ARM JSON |
| **VS Code Bicep extension** | Authoring, IntelliSense, validation, visualizer |
| **CI/CD (DevOps/GitHub Actions)** | `az deployment` deploys .bicep files |
| **Key Vault** | `getSecret()` / references for secrets |
| **Template Specs** | Publish Bicep as versioned, shareable templates |
| **Modules** | Reuse building blocks (next topic) |

---

## 57.5 Real-World Scenario — Modern IaC Adoption

```
A team on verbose ARM JSON wants cleaner, maintainable IaC.
   1. Decompile existing ARM templates to Bicep (az bicep decompile) as a starting point.
   2. Clean up the generated Bicep; add params and string interpolation for readability.
   3. Developers now author infrastructure in VS Code with IntelliSense catching errors early.
   4. CI/CD deploys the .bicep directly (az compiles it) with what-if gates.
   5. No state file to manage — Azure remains the single source of truth.
Result: the same reliable, idempotent deployments as ARM, but far easier to read, review,
and maintain — accelerating infrastructure changes.
```

---

## 57.6 Benefits

- **Concise & readable** — a fraction of ARM JSON's verbosity
- **Automatic dependencies** — symbolic references remove most `dependsOn`
- **Tooling** — IntelliSense, type checking, validation, visualizer
- **No state file** — Azure is the source of truth (unlike Terraform)
- **Full ARM power** — compiles to ARM; same idempotency and coverage
- **Convertible** — build to ARM, decompile from ARM

---

## 57.7 Common Use Cases

- Authoring new Azure IaC (Microsoft's recommended language)
- Modernizing/replacing verbose ARM JSON templates
- CI/CD infrastructure deployments
- Reusable building blocks via modules
- Teaching/learning Azure IaC with readable syntax

---

## 57.8 Exam Q&A

**Q: What is Bicep and how does it relate to ARM templates?**
> Bicep is a **declarative domain-specific language** for deploying Azure resources that **compiles ("transpiles") into ARM JSON**. It's not a separate engine — Azure Resource Manager still executes the resulting JSON — so Bicep has **identical capabilities and idempotency** to ARM, just with far **cleaner, more readable syntax**. It's Microsoft's **recommended** IaC language for Azure.

**Q: Name three concrete advantages Bicep has over authoring raw ARM JSON.**
> (1) **Concise syntax** — no `$schema`/bracket boilerplate and **string interpolation** instead of `concat()`; (2) **automatic dependency management** — referencing a resource's symbolic name creates the dependency, so explicit `dependsOn` is rarely needed; (3) **superior tooling** — the VS Code extension provides **IntelliSense, type checking, and validation** that catch errors while you write. (Also: native **modules** for reuse.)

**Q: Does Bicep require a separate state file like Terraform?**
> **No.** Bicep (like ARM) is **stateless from the author's perspective** — **Azure itself is the source of truth** for current resource state, and deployments are **idempotent** (they reconcile declared state against what's actually in Azure). This avoids the operational overhead and risks of managing/locking a separate state file, which is a key difference from Terraform.

**Q: How do you move between ARM JSON and Bicep?**
> Use the Bicep CLI (built into `az`): **`az bicep build --file main.bicep`** compiles Bicep **to ARM JSON**, and **`az bicep decompile --file template.json`** converts existing **ARM JSON to Bicep**. Decompiling is a common first step when **migrating** existing templates, after which you refine the generated Bicep for readability.

**Q: How do you deploy a Bicep file, and do you have to compile it first?**
> Deploy it just like a template: **`az deployment group create -g <rg> --template-file main.bicep`** (or the PowerShell equivalent). You **don't need to compile manually** — the Azure CLI/PowerShell **automatically compiles** the `.bicep` to ARM JSON at deploy time. You can still preview with **what-if** before applying.

---

## 57.9 Summary

**Bicep** is Azure's **recommended** Infrastructure-as-Code language — a clean **DSL that compiles to ARM JSON**, giving identical **declarative, idempotent** deployments with a fraction of the verbosity. Core elements: **`param`**, **`var`** (with `'${}'` interpolation), **`resource <symbolic> '<type>@<api>' = {}`**, **`output`**, and **`module`**. It provides **automatic dependency detection** (via symbolic references), excellent **VS Code tooling**, and needs **no state file** (Azure is the source of truth). Deploy with **`az deployment group create --template-file main.bicep`** (auto-compiled), preview with **what-if**, and convert with **`az bicep build/decompile`**. Next: parameters, loops, and modules in Bicep.

[↑ Back to top](#-table-of-contents)

---
---

# 58. 🔁 Bicep — Parameters, Loops & Modules
> 🟠 MEDIUM
> 📚 Course lectures: 206 (Multiple copies of a resource), 213 (Using parameters), 214 (Availability Sets), 215 (Adding data disks), 216 (Custom Script Extensions)

---

## 58.1 What Problem Does This Solve?

As with ARM, a flat Bicep file isn't reusable or scalable on its own. Bicep adds the same capabilities with cleaner syntax: **parameters** (typed inputs with decorators like `@allowed`), **loops** (`for` to deploy N resources), **modules** (reuse one Bicep file from another — far simpler than ARM linked templates), and easy integration of **data disks, Availability Sets, and Custom Script Extensions**. These make Bicep production-ready and composable.

Think of these like **upgrading from one printed form to a form-builder toolkit**: parameters are the configurable fields, loops are "generate 10 copies with incrementing numbers," and modules are **reusable form sections** (an address block) you drop into many forms instead of retyping.

> 💡 **If you know AWS:** Bicep **modules** ≈ **CloudFormation nested stacks** (but much simpler) or CDK **constructs**; `for` loops ≈ CFN `Count`/CDK loops; `@allowed`/`@secure` decorators ≈ CFN parameter constraints/`NoEcho`. The composition model (modules with inputs/outputs) will feel like reusable, parameterized building blocks.

---

## 58.2 Parameters, Loops & Modules (Flow Diagram)

```
PARAMETERS with decorators:
   @description('VM size')
   @allowed([ 'Standard_B2s', 'Standard_D2s_v5' ])
   param vmSize string = 'Standard_B2s'
   @secure()
   param adminPassword string            ← never logged

LOOPS (deploy N resources):
   resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = [for i in range(0, vmCount): {
     name: 'vm-${i}'                      ← vm-0, vm-1, ...
     ...
   }]

MODULES (reuse another .bicep file):
   module vnet 'modules/vnet.bicep' = {
     name: 'vnetDeploy'
     params: { vnetName: 'app-vnet', addressSpace: '10.0.0.0/16' }
   }
   // use its outputs:  vnet.outputs.subnetId
```

| Feature | Bicep syntax | Purpose |
|---|---|---|
| **Typed parameters** | `param name type = default` | Inputs with validation |
| **Decorators** | `@allowed`, `@secure`, `@description`, `@minValue` | Constraints/metadata |
| **Loops** | `[for item in array: { ... }]` / `range()` | Deploy multiple copies |
| **Modules** | `module x 'file.bicep' = { params: {} }` | Reuse & compose |
| **Outputs from modules** | `moduleName.outputs.value` | Pass values between modules |

⭐ Bicep **modules** are the clean replacement for ARM **linked/nested templates** — no external URLs or staging required; you just reference a local `.bicep` file. Use **`@secure()`** for passwords (equivalent to ARM's secureString).

---

## 58.3 Data Disks, Availability Sets & Extensions in a Loop

```bicep
// Availability Set + VMs in a loop, each with a data disk and a setup script
param vmCount int = 3
@secure()
param adminPassword string

resource avset 'Microsoft.Compute/availabilitySets@2023-09-01' = {
  name: 'web-avset'
  location: resourceGroup().location
  sku: { name: 'Aligned' }
  properties: { platformFaultDomainCount: 2, platformUpdateDomainCount: 5 }
}

resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = [for i in range(0, vmCount): {
  name: 'web-vm-${i}'
  location: resourceGroup().location
  properties: {
    availabilitySet: { id: avset.id }          // implicit dependency on avset
    hardwareProfile: { vmSize: 'Standard_B2s' }
    storageProfile: {
      dataDisks: [ { lun: 0, createOption: 'Empty', diskSizeGB: 32 } ]
    }
    // osProfile, networkProfile omitted for brevity
  }
}]
```

---

## 58.4 UI / CLI Steps

```
📍 Structure files:
   main.bicep           (orchestrates, calls modules, defines loops)
   modules/vnet.bicep   (reusable network)
   modules/vm.bicep     (reusable VM)
   main.parameters.json (per-environment values)
    ↓
📍 Deploy with parameters file:
```
```bash
az deployment group create -g lab-rg \
  --template-file main.bicep \
  --parameters main.parameters.json vmCount=3

# Pass a secret securely from Key Vault (via parameters file reference), or prompt:
az deployment group create -g lab-rg --template-file main.bicep \
  --parameters adminPassword=$MY_SECRET vmCount=2
```

---

## 58.5 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Key Vault** | Supplies `@secure()` parameters via references |
| **Availability Sets / Managed disks** | Deployed and ordered within Bicep |
| **Custom Script Extension** | Post-deploy VM configuration (software install) |
| **Modules registry / Template Specs** | Share versioned modules across teams |
| **CI/CD** | Deploy composed Bicep with per-environment parameters |

---

## 58.6 Real-World Scenario — Composable, Multi-Environment Stack

```
A platform team builds reusable modules for all projects.
   1. Author modules: vnet.bicep, storage.bicep, vm.bicep — each with typed params + outputs.
   2. main.bicep composes them, wiring outputs (e.g., vnet.outputs.subnetId → vm module).
   3. A for-loop in the vm module deploys the right VM count per environment into an
      Availability Set, each with a data disk.
   4. @allowed restricts vmSize to approved SKUs; @secure() handles the admin password.
   5. A Custom Script Extension installs the app after each VM is created.
   6. dev/test/prod differ only by parameters files.
Result: a clean, composable, governed IaC codebase where teams reuse vetted modules
instead of copy-pasting resource definitions.
```

---

## 58.7 Benefits

- **Reusable modules** — compose infrastructure from vetted building blocks
- **Scalable** — loops deploy N resources without duplication
- **Validated inputs** — decorators (`@allowed`, `@minValue`) catch bad values early
- **Secure** — `@secure()` for secrets; Key Vault references
- **Readable composition** — module outputs wire resources together cleanly
- **Simpler than ARM linked templates** — local file references, no staging

---

## 58.8 Common Use Cases

- Building a library of reusable infrastructure modules
- Deploying N VMs/disks/NICs via loops
- Enforcing approved values with parameter decorators
- Multi-environment deployments via parameters files
- Post-provision configuration with Custom Script Extensions

---

## 58.9 Exam Q&A

**Q: How do Bicep modules improve on ARM linked templates?**
> Bicep **modules** let you reference another **local `.bicep` file** directly (`module x 'file.bicep' = { params: {} }`) with typed inputs and accessible **outputs**, and Bicep handles the wiring automatically. ARM **linked templates** require the template to be **accessible via URI** (often staged in storage with SAS), which is cumbersome. Modules make **reuse and composition** simple and local, with no external hosting.

**Q: How do you deploy multiple copies of a resource in Bicep?**
> Use a **`for` loop**: `resource vm '...@api' = [for i in range(0, count): { name: 'vm-${i}' ... }]`. This iterates over a range or an array to deploy N instances from one definition, with the loop variable (e.g., `i`) used to create **unique names/properties**. It's the Bicep equivalent of ARM's `copy`/`copyIndex()` but with cleaner syntax.

**Q: How do you mark a parameter as a secret and restrict its allowed values in Bicep?**
> Use **decorators**: **`@secure()`** above a parameter ensures it's **never logged or output** (for passwords/keys), and **`@allowed([...])`** restricts a parameter to a defined set of valid values. Other decorators include `@description`, `@minValue/@maxValue`, and `@minLength/@maxLength`. Decorators provide validation and metadata at authoring and deploy time.

**Q: How do you pass a value produced by one module into another resource or module?**
> Define an **`output`** in the first module (e.g., `output subnetId string = ...`) and reference it via **`moduleName.outputs.subnetId`** where needed. Because this reference creates an **implicit dependency**, Bicep also ensures the first module deploys **before** the consumer — composing infrastructure correctly without manual `dependsOn`.

**Q: What is the Custom Script Extension typically used for in a Bicep VM deployment?**
> To run a **post-provisioning script** on the VM (install/configure software, bootstrap the app), so a single deployment yields a **fully configured** VM. It's defined as a child/extension resource of the VM and runs after the VM exists, bridging **infrastructure provisioning** and **application configuration** within the IaC deployment.

---

## 58.10 Summary

Bicep makes infrastructure **reusable and scalable** with clean syntax: **typed parameters** plus **decorators** (`@allowed`, `@secure`, `@description`, `@minValue`) for validated, safe inputs; **`for` loops** (`[for i in range(0,n): {...}]`) to deploy N resources; and **modules** — local `.bicep` files referenced with inputs and **outputs** — a far simpler replacement for ARM **linked templates**. Module outputs wire resources together and create **implicit dependencies** for correct ordering. These compose production stacks with **Availability Sets, data disks, and Custom Script Extensions**, differing across **dev/test/prod** only by parameters files. Next: a full infrastructure project built entirely from Bicep modules.

[↑ Back to top](#-table-of-contents)

---
---

# 59. 🏗️ Bicep Modules — Full Infrastructure Project
> 🟠 MEDIUM
> 📚 Course lectures: 218–238 (Project Overview through VNet Peering: VNet/Storage/NSG/VM modules, multiple copies, outputs, Bastion, Custom Script Extensions, Internal Load Balancer, test network, peering)

---

## 59.1 What Problem Does This Solve?

Individual Bicep skills only matter when they combine into a **real, maintainable project**. This topic ties everything together: a **main (orchestrator) Bicep file** calling **purpose-built modules** (network, storage, NSG, VM, Bastion, load balancer, peering) with a **parameters file**, **loops**, and **outputs wiring modules together** — the pattern used for production **landing zones** and complete environments.

Think of it like **building a house from prefabricated rooms**. Each module is a finished room (kitchen, bathroom, bedroom) built to spec. The **main file is the architect's plan** that places the rooms, connects the plumbing (outputs → inputs), and says "build three identical bedrooms" (loops). You assemble a whole house from tested components rather than pouring every wall by hand.

> 💡 **If you know AWS:** This is the equivalent of a **well-structured CloudFormation project with nested stacks** (or a CDK app composed of constructs) — a root template orchestrating reusable sub-stacks for network, compute, and security, deployed as one coordinated stack to stand up an entire environment/landing zone.

---

## 59.2 Project Structure & Orchestration (Flow Diagram)

```
project/
├── main.bicep                 ← ORCHESTRATOR: calls all modules, wires outputs
├── main.parameters.json       ← per-environment values
└── modules/
    ├── vnet.bicep             → VNet + subnets        (outputs: subnetIds)
    ├── nsg.bicep              → NSGs + rules          (outputs: nsgId)
    ├── storage.bicep          → storage account
    ├── vm.bicep               → VM(s) via a LOOP      (outputs: privateIps)
    ├── bastion.bicep          → Public IP + Bastion host
    ├── loadbalancer.bicep     → Internal Load Balancer
    └── peering.bicep          → VNet peering (prod ↔ test)

main.bicep wiring:
   module net 'modules/vnet.bicep'  = { params: {...} }
   module nsg 'modules/nsg.bicep'   = { params: { subnetId: net.outputs.webSubnetId } }
   module vm  'modules/vm.bicep'    = { params: { subnetId: net.outputs.webSubnetId, count: 3 } }
      │ net deploys first (vm references its output) → implicit ordering
      ▼
   One coordinated deployment builds the ENTIRE environment.
```

| Module | Deploys | Key outputs |
|---|---|---|
| **vnet** | VNet + subnets | subnet resource IDs |
| **nsg** | NSGs + rules, subnet association | nsg ID |
| **storage** | Storage account | account name/ID |
| **vm** (loop) | N VMs + disks + extensions | private IPs / VM IDs |
| **bastion** | Public IP + Bastion host | — |
| **loadbalancer** | Internal LB + pool/probe/rules | frontend IP |
| **peering** | VNet-to-VNet peering | — |

⭐ The **main file references module outputs as inputs**, which creates **implicit dependencies** and the correct **deployment order** automatically — no manual sequencing for the whole environment.

---

## 59.3 UI / CLI Steps — Deploy the Whole Project

```
📍 Author modules under modules/; main.bicep composes them; set values in main.parameters.json
    ↓
📍 Validate the composition:
```
```bash
az deployment group validate -g project-rg \
  --template-file main.bicep --parameters main.parameters.json

az deployment group what-if -g project-rg \
  --template-file main.bicep --parameters main.parameters.json

# Deploy the entire environment in one command
az deployment group create -g project-rg \
  --template-file main.bicep --parameters main.parameters.json
```
```
📍 main.bicep calling modules (excerpt):
```
```bicep
module net 'modules/vnet.bicep' = {
  name: 'vnetDeploy'
  params: { vnetName: 'prod-vnet', addressSpace: '10.0.0.0/16' }
}
module vms 'modules/vm.bicep' = {
  name: 'vmDeploy'
  params: {
    subnetId: net.outputs.webSubnetId   // wires modules + sets order
    vmCount: 3
    adminPassword: adminPassword
  }
}
output webVmIps array = vms.outputs.privateIps
```

---

## 59.4 Integration with Other Azure Services

| Service | Role in the project |
|---|---|
| **Azure Bastion** | Secure RDP/SSH to the VMs (no public IPs on VMs) |
| **Internal Load Balancer** | Distributes internal traffic across the VM pool |
| **VNet Peering** | Connects prod and test networks |
| **Private DNS / Endpoints** | Internal name resolution and private PaaS access |
| **Key Vault** | Supplies `@secure()` parameters |
| **CI/CD** | Deploys the whole project with environment parameters |

---

## 59.5 Real-World Scenario — A Repeatable Landing Zone

```
An organization needs identical, secure environments per business unit.
   1. Build a module library (vnet, nsg, storage, vm, bastion, loadbalancer, peering).
   2. main.bicep composes a full environment: a VNet with web/app subnets, NSGs attached,
      3 web VMs (loop) with no public IPs, an internal load balancer in front, Bastion for
      secure admin access, and peering to a shared services VNet.
   3. Each business unit = one deployment with its own parameters file (name, CIDR, counts).
   4. what-if runs in CI for review; deployment is a single coordinated command.
   5. Updating the standard = update a module once; redeploy to roll it out everywhere.
Result: entire environments stood up (and kept consistent) from one versioned,
modular codebase — the essence of a landing zone.
```

---

## 59.6 Benefits

- **Composable** — assemble environments from tested modules
- **Coordinated** — one command deploys the whole stack, correctly ordered
- **Maintainable** — fix/upgrade a module once, reuse everywhere
- **Consistent** — every environment built from the same source of truth
- **Scalable** — loops + parameters size each environment appropriately
- **Secure by design** — Bastion, internal LB, NSGs, private access baked in

---

## 59.7 Common Use Cases

- Landing zones and standardized environment provisioning
- Full multi-tier environments (network + compute + security) as code
- Per-team/per-environment deployments from shared modules
- Connected prod/test networks via peering
- Governed, repeatable infrastructure at scale

---

## 59.8 Exam Q&A

**Q: In a modular Bicep project, how does the main file control the order modules deploy in?**
> By **referencing one module's outputs as another module's inputs** (e.g., `subnetId: net.outputs.webSubnetId`). That reference creates an **implicit dependency**, so Bicep automatically deploys the referenced module (vnet) **before** the consumer (vm). You rarely need explicit `dependsOn` — the data flow between modules defines the correct order for the whole environment.

**Q: What is the role of the "main" (orchestrator) Bicep file versus the modules?**
> The **main file** composes the deployment — it **calls modules**, supplies their **parameters**, **wires their outputs** together, defines **loops/counts**, and exposes overall **outputs**. The **modules** each encapsulate one reusable building block (network, VM, NSG, etc.) with its own params and outputs. This separation gives **reuse** (modules) plus **coordination** (main), mirroring nested-stack architectures.

**Q: Why deploy an entire environment from one modular project rather than many separate deployments?**
> It gives a **single source of truth** and a **coordinated, correctly-ordered** deployment, ensures **consistency** across environments, and makes updates easy — **change a module once** and redeploy everywhere. It also enables **what-if review** of the whole environment before applying and supports **landing-zone** patterns where every business unit gets an identical, governed setup.

**Q: In this project, why do the VMs have no public IPs, and how do admins connect?**
> For **security** — VMs with no public IPs aren't directly exposed to the internet. Admins connect via **Azure Bastion**, which provides **RDP/SSH through the browser** over a private connection, and internal traffic is distributed by an **Internal Load Balancer**. This reduces the attack surface while keeping full administrative and application access.

**Q: How are prod and test networks connected in the project, and what must you remember about that connectivity?**
> Via **VNet peering** (a `peering.bicep` module), which gives **low-latency private connectivity** between the two VNets. Remember that peering is **non-transitive** and requires **non-overlapping address spaces**; if traffic must flow through a central hub/firewall between many networks, you'd add **UDRs**, since peering alone won't route transitively.

---

## 59.9 Summary

A **full Bicep project** composes an entire environment from **reusable modules** (vnet, nsg, storage, vm, bastion, load balancer, peering) orchestrated by a **main.bicep** that supplies **parameters**, drives **loops**, and **wires module outputs into inputs** — which creates **implicit dependencies** and the correct **deployment order** automatically. One coordinated **`az deployment group create`** stands up the whole stack (previewed with **what-if**), and **per-environment parameters files** size and name each deployment. This modular pattern delivers **consistent, maintainable landing zones** — fix a module once and redeploy everywhere — with security built in (Bastion for admin access, internal LB, NSGs, no public IPs on VMs). This completes the **Bicep** build-out; next are **Service Endpoints** and **Private Endpoints**.

[↑ Back to top](#-table-of-contents)

---
---

# 60. 🔗 Service Endpoints
> 🟠 MEDIUM
> 📚 Course lectures: 240–241 (Storage Service Endpoints - Preparation/Implementation), 242 (NSG outbound to storage), 243 (Service endpoint policies), 245 (Storage Service Encryption)

---

## 60.1 What Problem Does This Solve?

PaaS services like **Storage** and **SQL** have **public endpoints** by default — reachable over the internet (if credentials/keys allow). Many organizations want these services reachable **only from their VNet**, not the whole internet. **Service Endpoints** extend a VNet's identity to the PaaS service over Azure's backbone, so you can configure the service's firewall to **allow only specific subnets** — keeping traffic off the public internet and blocking everyone else.

Think of a service endpoint like **adding your office building to a club's approved-visitors list**. The club (Storage account) still has a public street address, but the bouncer (service firewall) now only lets people in if they're coming from your building's subnet. Everyone else is turned away, even though the address is technically public.

> 💡 **If you know AWS:** Service Endpoints are closest to **AWS Gateway VPC Endpoints** (for S3/DynamoDB) — they keep traffic on the provider backbone and let you restrict the service to specific subnets/VPCs via policies, **without a private IP**. (Azure's **Private Endpoint** — next topic — is the equivalent of **Interface VPC Endpoints / PrivateLink**, which *does* give a private IP.)

---

## 60.2 How Service Endpoints Work (Flow Diagram)

```
WITHOUT service endpoint:
   Subnet VM ── public internet ──► Storage public endpoint (open to all; key-gated)

WITH service endpoint (Microsoft.Storage) on the subnet:
   Subnet VM ── Azure backbone (optimized) ──► Storage
                        │
   Storage firewall:  "Allow only VNet/subnet: app-subnet"  → everyone else DENIED

   Traffic still goes to the storage account's PUBLIC endpoint/DNS, but:
     • it travels over Azure's backbone (not the internet)
     • the source is identified as the VNet/subnet (not a public IP)
     • the service firewall restricts access to approved subnets
```

| Aspect | Service Endpoint behaviour |
|---|---|
| **Private IP for the service?** | ❌ No — service keeps its public endpoint/DNS |
| **Traffic path** | Over the Azure backbone, not the public internet |
| **Access control** | Service firewall allows **specific VNets/subnets** |
| **Scope** | Per **subnet**, per **service type** (Microsoft.Storage, Microsoft.Sql, …) |
| **Cost** | **Free** |
| **Service endpoint policies** | Further restrict *which specific accounts* a subnet can reach |

⚠️ Service endpoints secure access **to the whole service type's regional resources** you allow, not a single resource via a private IP. Use **service endpoint policies** to limit a subnet to **specific storage accounts**. For a true **private IP** and on-prem reach, use a **Private Endpoint**.

---

## 60.3 Service Endpoints vs Private Endpoints (Preview)

```
SERVICE ENDPOINT                         PRIVATE ENDPOINT
   • No private IP                           • Gets a PRIVATE IP in your subnet
   • Uses the service's PUBLIC endpoint      • Uses privatelink.* DNS → private IP
   • Free                                    • Has a cost (per endpoint + data)
   • Subnet-level allow on service firewall  • Granular to a SPECIFIC resource
   • Not reachable from on-prem              • Reachable from on-prem (VPN/ExpressRoute)
```

---

## 60.4 UI / CLI Steps

```
📍 VNet → Subnets → select app-subnet → "Service endpoints"
   Add service: Microsoft.Storage → Save
    ↓
📍 Storage account → "Networking" → "Enabled from selected virtual networks and IP addresses"
   + Add existing virtual network → VNet + app-subnet → Save
   (Default action becomes Deny for everyone else)
    ↓
📍 (Optional) Service endpoint policy: restrict app-subnet to ONLY specific storage accounts
📍 (Optional) NSG: use the "Storage" service tag to control outbound to storage
```

```bash
az network vnet subnet update -g rg --vnet-name app-vnet -n app-subnet \
  --service-endpoints Microsoft.Storage

az storage account network-rule add -g rg --account-name acct \
  --vnet-name app-vnet --subnet app-subnet

az storage account update -g rg -n acct --default-action Deny
```

---

## 60.5 Integration with Other Azure Services

| Service | Role with Service Endpoints |
|---|---|
| **Storage / SQL / Key Vault / etc.** | PaaS services that support service endpoints |
| **Service endpoint policies** | Limit a subnet to specific resources (e.g., certain storage accounts) |
| **NSG service tags** | Control outbound traffic to a service (e.g., `Storage`) |
| **Storage Service Encryption** | Data at rest is always encrypted (SSE) — complements network security |
| **Private Endpoints** | The upgrade path when you need a private IP / on-prem access |

---

## 60.6 Real-World Scenario — Locking Storage to the App Subnet

```
A storage account must be reachable only from the app tier, never the public internet.
   1. Enable the Microsoft.Storage service endpoint on app-subnet.
   2. In the storage account's firewall, allow only app-subnet and set default action = Deny.
   3. Now app VMs reach storage over the Azure backbone; all other sources (including the
      developers' laptops and the internet) are denied.
   4. Add a service endpoint policy so app-subnet can reach ONLY the approved storage
      accounts (prevents data exfiltration to a rogue account).
   5. Data at rest stays encrypted by Storage Service Encryption (SSE) by default.
Result: storage is network-restricted to the right subnet, traffic avoids the internet,
and exfiltration paths are constrained — at no extra cost.
```

---

## 60.7 Benefits

- **Restrict PaaS to your VNet** — service firewall allows only chosen subnets
- **Traffic off the public internet** — routed over Azure's backbone
- **Free** — no per-endpoint cost
- **Simple** — enable per subnet + service type
- **Exfiltration control** — service endpoint policies limit which resources are reachable
- **Complements encryption** — pairs with SSE for defense in depth

---

## 60.8 Common Use Cases

- Allowing only app subnets to access Storage/SQL/Key Vault
- Keeping PaaS traffic on the Azure backbone (not the internet)
- Restricting a subnet to specific storage accounts (endpoint policies)
- Cost-sensitive network restriction where a private IP isn't required

---

## 60.9 Exam Q&A

**Q: What does a Service Endpoint actually do, and does the PaaS service get a private IP?**
> A service endpoint extends your **VNet/subnet identity** to the PaaS service over the **Azure backbone**, so the service's **firewall can allow only specific subnets** and deny everyone else. The service **keeps its public endpoint and DNS — it does NOT get a private IP**. Traffic is still destined for the public endpoint but travels privately over Azure's network and is source-identified as your subnet.

**Q: What is the key difference between a Service Endpoint and a Private Endpoint?**
> A **Service Endpoint** restricts access to a service via its **public endpoint** (no private IP, free, subnet-level allow, not reachable from on-prem). A **Private Endpoint** gives the service a **private IP inside your subnet** (via PrivateLink), is reachable from **on-premises** over VPN/ExpressRoute, is **resource-specific**, and has a **cost**. Choose Private Endpoints when you need a private IP, on-prem access, or per-resource granularity.

**Q: How do you ensure a subnet with a storage service endpoint can only reach *approved* storage accounts?**
> Apply a **Service Endpoint Policy** to the subnet, which **whitelists specific storage account resource IDs**. Without it, the service endpoint would allow the subnet to reach any storage account that trusts that VNet; the policy prevents **data exfiltration** to unauthorized/rogue accounts by limiting exactly which accounts the subnet may access.

**Q: After enabling a service endpoint and the storage firewall, developers can no longer reach the account from their laptops. Why, and is that expected?**
> **Yes, that's expected.** Setting the storage firewall to **allow only selected subnets** (default action **Deny**) blocks all other sources — including internet-based developer laptops. To restore access you'd add their **public IPs** to the firewall allow-list, connect them through the VNet (VPN/Bastion), or use a Private Endpoint. The whole point is to deny access from outside the approved networks.

**Q: Are service endpoints a replacement for encryption of data at rest?**
> **No** — they're **network access controls**, not encryption. Data at rest in Storage is always encrypted by **Storage Service Encryption (SSE)** regardless of network settings. Service endpoints and SSE are **complementary layers**: SSE protects the data if the storage is somehow accessed, while service endpoints restrict **who on the network** can reach the service at all.

---

## 60.10 Summary

**Service Endpoints** extend a **subnet's identity** to a PaaS service (Storage, SQL, Key Vault, etc.) over the **Azure backbone**, letting the service's **firewall allow only specific subnets** and deny everyone else. The service **keeps its public endpoint/DNS — no private IP is created** — but traffic stays off the public internet and is source-identified as your VNet. They're **free**, configured **per subnet + service type**, and can be tightened with **service endpoint policies** (limit a subnet to specific accounts, preventing exfiltration). They **complement** always-on **Storage Service Encryption (SSE)**. When you need a **private IP**, **on-prem access**, or **per-resource** targeting, use a **Private Endpoint** instead (next topic). Think **AWS Gateway VPC Endpoints**.

[↑ Back to top](#-table-of-contents)

---
---

# 61. 🔒 Private Endpoints
> 🔴 FULL
> 📚 Course lectures: 244 (Azure Storage Private Endpoints), 239 (Azure Private DNS Zone), 245 (Storage Service Encryption)

---

## 61.1 What Problem Does This Solve?

Service endpoints keep a PaaS service's **public endpoint** but restrict who can use it. Many organizations need more: the PaaS service should have a **private IP address inside the VNet**, with **no public exposure at all**, reachable from **on-premises** over VPN/ExpressRoute, and targeted at a **specific resource** (one storage account, not all of Storage). **Private Endpoints** (built on **Azure Private Link**) deliver exactly this — a network interface with a **private IP** that maps to a specific PaaS resource.

Think of a private endpoint like **installing a private internal phone line directly to a specific vendor's desk**. Instead of calling the vendor's public switchboard (even a restricted one), you have a dedicated internal extension (private IP) that rings only that one desk (the specific resource) — reachable from any office in your building (VNet) or branch (on-prem), and invisible to the outside world.

> 💡 **If you know AWS:** Private Endpoints = **AWS Interface VPC Endpoints (powered by PrivateLink)**. They place an **ENI/NIC with a private IP** in your subnet mapping to a specific service/resource, reachable from the VPC and on-prem, with the service no longer needing public exposure. Azure's **privatelink.* Private DNS zones** play the same role as PrivateLink's private DNS integration.

---

## 61.2 How Private Endpoints Work (Flow Diagram)

```
                 Private Endpoint = a NIC with a PRIVATE IP in your subnet,
                 mapped (via Private Link) to a SPECIFIC resource.

   app-subnet (10.0.1.0/24)
      │
      ├── Private Endpoint NIC: 10.0.1.9  ──Private Link──►  mystorageacct (Blob)
      │
   DNS problem & fix:
      Storage FQDN is still  mystorageacct.blob.core.windows.net
      → must resolve to the PRIVATE IP (10.0.1.9) inside the VNet.
      → Azure creates/links a Private DNS zone:
           privatelink.blob.core.windows.net
           mystorageacct → 10.0.1.9   ✅  (in-VNet clients get the private IP)
      → public DNS still returns the public IP for outside clients (which are now blocked).

   On-prem (via VPN/ExpressRoute) can ALSO reach 10.0.1.9 — service endpoints can't do this.
```

| Aspect | Private Endpoint behaviour |
|---|---|
| **Private IP?** | ✅ Yes — a NIC in your subnet |
| **Granularity** | A **specific resource** (this storage account/blob sub-resource) |
| **Public access** | Can be **fully disabled** on the resource |
| **On-prem access** | ✅ Yes, via VPN/ExpressRoute |
| **DNS** | Needs **privatelink.* Private DNS** to resolve FQDN → private IP |
| **Cost** | Per-endpoint + data processing charges |

⭐ **DNS is the make-or-break detail**: without the **`privatelink.*` Private DNS zone** linked to the VNet, the service's FQDN still resolves to its **public IP** and the private endpoint won't be used. This is the #1 Private Endpoint exam/troubleshooting point.

---

## 61.3 Service vs Private Endpoint — Decision

```
Need just "only my subnets can use this service", cheaply?         → SERVICE ENDPOINT
Need a PRIVATE IP, NO public exposure, ON-PREM access, per-resource? → PRIVATE ENDPOINT
```

---

## 61.4 UI / CLI Steps — Create a Private Endpoint for Storage

```
📍 Storage account → "Networking" → "Private endpoint connections" → "+ Private endpoint"
   (or: Private Link Center → + Private endpoint)
   ┌──────────────────────────────────────────────────────────┐
   │ Resource: mystorageacct,  Target sub-resource: blob         │
   │ VNet/Subnet: app-vnet / app-subnet                          │
   │ ☑ Integrate with private DNS zone                           │
   │    → creates/links privatelink.blob.core.windows.net        │
   └──────────────────────────────────────────────────────────┘
    ↓
📍 Storage account → Networking → "Public network access" = Disabled (optional, recommended)
    ↓
📍 From an app VM:  nslookup mystorageacct.blob.core.windows.net
   → returns the PRIVATE IP (e.g., 10.0.1.9) ✅
```

```bash
az network private-endpoint create -g rg -n blob-pe \
  --vnet-name app-vnet --subnet app-subnet \
  --private-connection-resource-id "/subscriptions/.../storageAccounts/mystorageacct" \
  --group-id blob --connection-name blob-conn

# Link the privatelink DNS zone to the VNet (so the FQDN resolves to the private IP)
az network private-dns zone create -g rg -n privatelink.blob.core.windows.net
az network private-dns link vnet create -g rg -z privatelink.blob.core.windows.net \
  -n app-link -v app-vnet --registration-enabled false
```

---

## 61.5 Integration with Other Azure Services

| Service | Role with Private Endpoints |
|---|---|
| **Azure Private Link** | The underlying technology |
| **Private DNS zones (`privatelink.*`)** | Resolve the service FQDN to the private IP |
| **VPN / ExpressRoute** | Enable on-prem access to the private endpoint |
| **Storage / SQL / Key Vault / Web Apps** | Services exposed privately per-resource |
| **NSGs / UDRs** | Control and route traffic to the endpoint |
| **Storage Service Encryption (SSE)** | Encryption at rest complements private networking |

---

## 61.6 Real-World Scenario — Zero Public Exposure for Sensitive Data

```
A healthcare app must ensure its storage is NEVER reachable from the public internet and
is accessible from both Azure and the on-prem datacenter.
   1. Create a Private Endpoint for the storage account's blob sub-resource in app-subnet
      (gets private IP 10.0.1.9).
   2. Integrate with the privatelink.blob.core.windows.net Private DNS zone, linked to the
      VNet, so the storage FQDN resolves to 10.0.1.9 for all in-VNet clients.
   3. Set the storage account's public network access = Disabled.
   4. Link the same private DNS zone across the hub so on-prem clients (via ExpressRoute)
      also resolve and reach the private IP.
   5. Apps use the normal FQDN unchanged — only the resolution (and path) is now private.
Result: the storage account has no public attack surface, is reachable privately from
cloud and on-prem, and apps need no code changes. SSE keeps data encrypted at rest.
```

---

## 61.7 Benefits

- **True private IP** — PaaS resource lives in your subnet's address space
- **No public exposure** — public access can be fully disabled
- **On-prem reach** — accessible via VPN/ExpressRoute (service endpoints can't)
- **Per-resource granularity** — targets a specific account/sub-resource
- **No app changes** — same FQDN; only DNS/path changes
- **Exfiltration-resistant** — maps to one specific resource, not a whole service

---

## 61.8 Common Use Cases

- Exposing Storage/SQL/Key Vault/Web Apps with no public endpoint
- Private, on-prem-reachable access to PaaS over ExpressRoute/VPN
- Compliance/regulated workloads requiring zero public exposure
- Hub-and-spoke designs sharing private endpoints via linked DNS
- Replacing service endpoints when a private IP or per-resource control is required

---

## 61.9 Exam Q&A

**Q: What does a Private Endpoint give you that a Service Endpoint does not?**
> A Private Endpoint provides a **private IP address** for the PaaS resource **inside your subnet** (via Private Link), lets you **fully disable public access**, is reachable from **on-premises** (VPN/ExpressRoute), and targets a **specific resource**. A Service Endpoint keeps the service's **public endpoint** (no private IP), can't be reached from on-prem, and allows access at the **subnet-to-service** level. Private Endpoints are the choice for true private, on-prem-capable, per-resource access.

**Q: You created a Private Endpoint but apps still connect to the storage account's public IP. What's wrong?**
> The **Private DNS configuration is missing or not linked**. The service FQDN (e.g., `acct.blob.core.windows.net`) must resolve to the **private IP** via the **`privatelink.blob.core.windows.net`** Private DNS zone **linked to the VNet**. Without that zone (or if clients use a DNS server that doesn't resolve it), the FQDN still returns the **public IP**, so the private endpoint isn't used. DNS integration is the critical step.

**Q: Why is a Private Endpoint considered more secure against data exfiltration than a Service Endpoint?**
> A Private Endpoint maps to **one specific resource** (e.g., a single storage account/sub-resource), so a compromised subnet can only reach **that** resource. A Service Endpoint opens the subnet to the **service type** (and relies on service endpoint policies to narrow it). By pinning access to an exact resource with a private IP and disabling public access, Private Endpoints inherently limit lateral/exfiltration paths.

**Q: Can on-premises systems use a Private Endpoint, and how?**
> **Yes.** Because the endpoint has a **private IP** in the VNet, on-prem systems connected via **VPN or ExpressRoute** can reach it — provided their **DNS resolves the service FQDN to the private IP** (typically by forwarding to Azure's resolver or using the linked `privatelink.*` zone, often via DNS forwarders). This cross-premises private access is something **service endpoints cannot provide**.

**Q: What target "sub-resource" do you select when creating a Private Endpoint, and why does it matter?**
> You choose the **group ID / sub-resource** (e.g., `blob`, `file`, `table`, `queue` for Storage; `sqlServer` for SQL). It matters because a storage account offers multiple services, and the private endpoint (and its `privatelink.*` DNS zone) is **specific to the sub-resource** — you'd create separate private endpoints (and link the matching zones, like `privatelink.blob...` vs `privatelink.file...`) for each service you need privately.

**Q: Do Private Endpoints replace the need for Storage Service Encryption?**
> **No.** Private Endpoints are a **network** control (how/where the service is reachable); **Storage Service Encryption (SSE)** always encrypts **data at rest** regardless. They're **complementary layers of defense** — SSE protects the stored data, while the private endpoint ensures the service is only reachable privately with no public exposure.

---

## 61.10 Summary

**Private Endpoints** (built on **Azure Private Link**) place a **NIC with a private IP** in your subnet that maps to a **specific PaaS resource** (e.g., one storage account's `blob` sub-resource), letting you **disable public access entirely** and reach the service **privately from the VNet and on-premises** (VPN/ExpressRoute). The **critical detail** is **DNS**: the **`privatelink.*` Private DNS zone** must be **linked to the VNet** so the service's FQDN resolves to the **private IP** — otherwise clients still hit the public endpoint. Compared to **service endpoints** (no private IP, public endpoint, free, no on-prem, subnet-level), Private Endpoints are **per-resource, private-IP, on-prem-capable, exfiltration-resistant** — at a per-endpoint cost. They pair with always-on **SSE** for defense in depth, and are Azure's equivalent of **AWS Interface VPC Endpoints / PrivateLink**. This completes the **Bicep & Endpoints** section.

[↑ Back to top](#-table-of-contents)

---
---

# 62. 🔐 Microsoft Entra ID
> 🔴 FULL
> 📚 Course lectures: 246 (What is Microsoft Entra ID), 247 (Creating a user), 248 (Logging in as the new user), 249 (Deploy resources)

---

## 62.1 What Problem Does This Solve?

Every cloud needs an **identity system** — who are you, and what are you allowed to do? **Microsoft Entra ID** (formerly **Azure Active Directory / Azure AD**) is Azure's cloud-based **identity and access management (IAM)** service. It stores **users, groups, and applications**, authenticates sign-ins, and is the foundation that **RBAC**, **Microsoft 365**, and thousands of SaaS apps use to control access. Without it, there's no one to grant permissions to.

Think of Entra ID like **the HR department + security desk of a company**. HR maintains the roster of employees (users) and teams (groups); the security desk checks IDs at the door (authentication) and issues badges that open certain rooms (authorization). Everything about "who can go where" starts with this directory.

> 💡 **If you know AWS:** Entra ID is **not** the same as AWS IAM. AWS IAM combines identity *and* resource permissions; Azure **splits** them — **Entra ID** handles **identities and authentication** (closer to **AWS IAM Identity Center / the identity side**, plus federation like **Cognito/SSO**), while **Azure RBAC** handles **resource authorization** (the IAM-policy side). A **tenant** ≈ an AWS account's identity boundary / an Organizations identity store. Entra ID is also the SSO/directory behind Microsoft 365.

---

## 62.2 Entra ID Core Concepts (Flow Diagram)

```
                 Microsoft Entra ID TENANT  (your organization's directory)
                 = a dedicated identity boundary (contoso.onmicrosoft.com)
                 ┌───────────────────────────────────────────────────────┐
                 │  USERS       — members (employees) & guests (B2B)        │
                 │  GROUPS      — Security groups / Microsoft 365 groups    │
                 │  APP REGS    — applications & service principals         │
                 │  DEVICES     — registered/joined devices                 │
                 │  ROLES       — Entra roles (Global Admin, User Admin...)  │
                 └───────────────────────────────────────────────────────┘
                              │ authenticates sign-ins (who you are)
                              ▼
         Azure resources  ◄── Azure RBAC uses these identities for authorization
         Microsoft 365    ◄── same identities sign in (SSO)
         SaaS apps        ◄── SSO / federation

   Tenant vs Subscription:
      One TENANT (identity) ── can trust ──► many SUBSCRIPTIONS (billing/resource containers)
```

| Concept | Meaning |
|---|---|
| **Tenant** | A dedicated instance of Entra ID — your org's identity directory |
| **User** | An identity: **Member** (internal) or **Guest** (external/B2B) |
| **Group** | Collection of users/devices for bulk access (Security / M365) |
| **Service principal** | An identity for an app/automation (from an app registration) |
| **Managed identity** | An Azure-managed service principal for resources (no secrets) |
| **Entra role** | Directory-level admin role (e.g., Global Administrator) |

⚠️ **Entra ID (directory) roles ≠ Azure RBAC roles.** Entra roles manage the **directory** (users, groups, Entra settings); **Azure RBAC** manages **Azure resources** (VMs, storage). Confusing the two is a classic exam trap (covered more in Topic 65).

---

## 62.3 Users, Groups & Authentication

```
USER TYPES:
   • Cloud-only       — created directly in Entra ID
   • Synced           — from on-prem AD via Entra Connect (hybrid identity)
   • Guest (B2B)      — invited external users (another org/Microsoft account)

AUTHENTICATION / SECURITY (Entra features):
   • Multi-Factor Authentication (MFA)
   • Conditional Access (require MFA/compliant device by condition)  [P1/P2]
   • Self-Service Password Reset (SSPR)
   • Identity Protection, PIM (Privileged Identity Management)       [P2]

LICENSE TIERS:  Free → Entra ID P1 → P2  (more security/governance features higher up)
```

---

## 62.4 UI / CLI Steps — Create a User & Sign In

```
📍 portal.azure.com → "Microsoft Entra ID" → "Users" → "+ New user" → Create new user
   ┌──────────────────────────────────────────────┐
   │ User principal name: alice@contoso.onmicrosoft │
   │ Display name: Alice                             │
   │ Password: auto-generate (must change at sign-in)│
   │ Groups / Roles: optionally assign               │
   └──────────────────────────────────────────────┘
    ↓
📍 Sign in as the new user (incognito) → forced password change → lands with NO access
   to resources yet (identity ≠ authorization).
    ↓
📍 Grant access later via Azure RBAC (Topic 63) so the user can deploy/see resources.
```

```bash
az ad user create --display-name "Alice" \
  --user-principal-name alice@contoso.onmicrosoft.com \
  --password '<TempPassw0rd!>' --force-change-password-next-sign-in true

az ad group create --display-name "Engineers" --mail-nickname engineers
az ad group member add --group "Engineers" --member-id <alice-object-id>
```

---

## 62.5 Integration with Other Azure Services

| Service | Role with Entra ID |
|---|---|
| **Azure RBAC** | Uses Entra identities to authorize resource access |
| **Microsoft 365 / SaaS apps** | Sign in via Entra (SSO, federation) |
| **Managed identities** | Entra identities for Azure resources (keyless auth) |
| **Conditional Access / MFA / PIM** | Secure and govern sign-ins (P1/P2) |
| **Entra Connect** | Sync on-prem AD users (hybrid identity) |
| **Key Vault / Storage** | Authorize via Entra tokens instead of keys |

---

## 62.6 Real-World Scenario — Onboarding a New Team

```
A company onboards a new engineering team into Azure.
   1. Create user accounts in Entra ID (or sync them from on-prem AD via Entra Connect).
   2. Create a "Engineers" security group and add the users.
   3. Require MFA via Conditional Access for all admins (P1).
   4. Grant the GROUP (not individuals) the Contributor role on the dev resource group
      via Azure RBAC → everyone in the group gets access; new hires inherit it by joining.
   5. Apps/automation use service principals or managed identities, not user credentials.
Result: centralized identities, group-based access that scales with hiring, and secured
sign-ins — the foundation for all resource authorization.
```

---

## 62.7 Benefits

- **Centralized identity** — one directory for users, groups, apps, devices
- **SSO everywhere** — Azure, Microsoft 365, and thousands of SaaS apps
- **Foundation for RBAC** — identities to assign resource permissions to
- **Strong security** — MFA, Conditional Access, Identity Protection, PIM
- **Hybrid & external** — sync on-prem AD; invite external B2B guests
- **Keyless app auth** — managed identities and service principals

---

## 62.8 Common Use Cases

- Managing organizational users and groups for Azure/M365
- Single sign-on to cloud and SaaS applications
- Securing sign-ins with MFA and Conditional Access
- Hybrid identity (syncing on-prem AD) and external collaboration (B2B)
- Providing identities for apps/automation (service principals, managed identities)

---

## 62.9 Exam Q&A

**Q: What is the difference between a Microsoft Entra ID tenant and an Azure subscription?**
> A **tenant** is a dedicated instance of **Entra ID** — the **identity/directory boundary** holding users, groups, and apps. A **subscription** is a **billing and resource container** for Azure resources. One tenant can be **trusted by many subscriptions**, and identities in the tenant are used (via RBAC) to access resources in those subscriptions. They're separate concepts: identity (tenant) vs resources/billing (subscription).

**Q: After creating a new user in Entra ID, they can sign in but can't see or manage any Azure resources. Why?**
> Because **authentication (identity) is separate from authorization (permissions)**. Creating the user only establishes **who they are** in Entra ID; it grants **no access to Azure resources**. You must separately assign an **Azure RBAC role** (e.g., Reader/Contributor) at the appropriate **scope** for them to see or manage resources. A brand-new user has an identity but zero resource authorization.

**Q: How do Microsoft Entra ID (directory) roles differ from Azure RBAC roles?**
> **Entra ID roles** manage the **directory itself** — users, groups, domains, and Entra features (e.g., **Global Administrator**, **User Administrator**). **Azure RBAC roles** manage **Azure resources** — VMs, storage, networks (e.g., **Owner**, **Contributor**, **Reader**). They apply to different planes; being a Global Admin in Entra doesn't automatically grant resource access (and vice versa), which is a common point of confusion.

**Q: What is the recommended way to grant access so it scales as people join and leave?**
> Assign roles to **groups**, not individual users. Add users to a **security group** and grant **that group** the RBAC role at the right scope; then **new hires inherit access by joining** the group, and removing someone from the group revokes it. This group-based model is far more scalable and auditable than per-user assignments.

**Q: What identity options exist for applications and automation (not people)?**
> **Service principals** (created via an **app registration**) and **managed identities** (service principals **automatically managed by Azure** for resources like VMs/Functions). Managed identities are preferred because they're **keyless** — no secrets to store or rotate — and are granted RBAC roles like any other identity. These let apps authenticate to Azure/Key Vault/Storage securely without user credentials.

---

## 62.10 Summary

**Microsoft Entra ID** (formerly Azure AD) is Azure's cloud **identity and access management** service — the **directory** of **users, groups, apps, and devices** that authenticates sign-ins and underpins **Azure RBAC**, **Microsoft 365**, and SaaS SSO. Key concepts: a **tenant** (identity boundary) can be trusted by many **subscriptions** (resource/billing containers); users are **members, synced, or guests (B2B)**; apps use **service principals/managed identities**. Crucially, **authentication ≠ authorization** — a new user has an identity but **no resource access** until granted an **RBAC** role, and **Entra (directory) roles are distinct from Azure RBAC roles**. Secure it with **MFA, Conditional Access, PIM** (P1/P2), extend it with **Entra Connect** (hybrid) and **B2B** (external), and prefer **group-based** access for scale.

[↑ Back to top](#-table-of-contents)

---
---

# 63. 🛡️ Role-Based Access Control (RBAC)
> 🔴 FULL
> 📚 Course lectures: 250 (Introduction to RBAC), 251–258 (Assignments at resource/RG level, Contributor, User Access Administrator, Storage, conditions, VM assignments)

---

## 63.1 What Problem Does This Solve?

Once you have identities (Entra ID), you must control **what each one can do to which Azure resources** — ideally with **least privilege** (only the access needed). **Azure RBAC** provides fine-grained authorization by combining three things: **who** (a security principal), **what they can do** (a role definition), and **where** (a scope). It replaces blunt "admin or nothing" access with precise, auditable permissions.

Think of RBAC like **a building's keycard system**. Each person (principal) is issued a keycard programmed with specific permissions (role) that work only on certain floors or rooms (scope). A cleaner's card opens all floors after hours (Contributor at a broad scope); a contractor's card opens just one room during business hours (Reader on one resource). You hand out exactly the access each person needs — no master keys for everyone.

> 💡 **If you know AWS:** Azure RBAC ≈ **AWS IAM policies/roles** applied to resources. A **role definition** ≈ an IAM policy (a set of allowed **Actions**), a **scope** ≈ the resource/account/OU the policy applies to, and a **role assignment** ≈ attaching the policy to a principal. Azure's built-in **Owner/Contributor/Reader** are like broad AWS managed policies; **scopes** (management group → subscription → RG → resource) mirror the **Organizations → account → resource** hierarchy with inheritance.

---

## 63.2 The Three Elements & Scope Hierarchy (Flow Diagram)

```
ROLE ASSIGNMENT = WHO  +  WHAT  +  WHERE

   WHO  (Security principal): User · Group · Service principal · Managed identity
   WHAT (Role definition):    Owner / Contributor / Reader / <specific> / Custom
   WHERE(Scope):              Management group → Subscription → Resource group → Resource
                               └──────────── access INHERITS downward ───────────┘

   Example:  Assign "Contributor" (what) to the "Engineers" group (who)
             on "dev-rg" (where) → all members can manage everything in dev-rg,
             and in every resource inside it (inheritance).

BUILT-IN FUNDAMENTAL ROLES:
   • Owner        → full access + can GRANT access to others
   • Contributor  → fullManage access but CANNOT grant access (no role assignments)
   • Reader       → view only
   • User Access Administrator → ONLY manage access (assign roles), not resources
```

| Element | Examples |
|---|---|
| **Security principal (who)** | User, Group, Service principal, Managed identity |
| **Role definition (what)** | Owner, Contributor, Reader, Storage Blob Data Contributor, VM Contributor, custom |
| **Scope (where)** | Management group, Subscription, Resource group, Resource |

⭐ **Scope inheritance**: a role at a **subscription** applies to **all RGs and resources** beneath it. **Least-privilege** = assign the **narrowest role** at the **narrowest scope** that still works. Roles are **additive** (you get the union of all assignments); an explicit **Deny assignment** overrides allows.

---

## 63.3 Contributor vs Owner vs User Access Administrator

```
THE KEY DISTINCTION (common exam question):

   Contributor  → can CREATE/MANAGE/DELETE resources,
                  but CANNOT assign roles to others.        (do the work)
   Owner        → everything Contributor can + CAN assign roles. (do work + grant)
   User Access   → can ONLY assign roles (manage access),
   Administrator   but CANNOT manage the resources themselves.   (grant only)

So: to let someone manage resources AND grant others access → Owner.
    To let someone manage resources but NOT grant access     → Contributor.
    To let someone grant access but NOT touch resources      → User Access Administrator.
```

---

## 63.4 Data-Plane Roles & Conditions

```
MANAGEMENT PLANE vs DATA PLANE:
   • Contributor (mgmt plane) can manage a STORAGE ACCOUNT (create, delete, keys)
     but does NOT automatically grant access to the DATA (blobs) inside it.
   • To read/write BLOBS you need a DATA-plane role:
        "Storage Blob Data Reader" / "Storage Blob Data Contributor"
   (Same for queues/files — data roles are separate from management roles.)

ROLE ASSIGNMENT CONDITIONS (ABAC): refine a role with conditions, e.g.
   "Storage Blob Data Contributor — but ONLY for blobs tagged project=alpha"
```

---

## 63.5 UI / CLI Steps — Assign a Role

```
📍 Scope (e.g., Resource group dev-rg) → "Access control (IAM)" → "+ Add" → "Add role assignment"
   ┌──────────────────────────────────────────────┐
   │ Role:     Contributor                           │
   │ Assign to: User, group, or service principal    │
   │ Members:  Engineers (group)                     │
   │ (optional) Condition: restrict by tag/attribute │
   └──────────────────────────────────────────────┘
   Review + assign
    ↓
📍 Check effective access: IAM → "Check access" → pick a user → see their roles
📍 "Role assignments" tab lists who has what at this scope
```

```bash
# Assign Contributor to a group at a resource-group scope
az role assignment create --assignee <group-object-id> \
  --role "Contributor" \
  --scope "/subscriptions/<sub>/resourceGroups/dev-rg"

# Data-plane role for blobs at a storage account scope
az role assignment create --assignee <user-object-id> \
  --role "Storage Blob Data Contributor" \
  --scope "/subscriptions/<sub>/resourceGroups/dev-rg/providers/Microsoft.Storage/storageAccounts/acct"

az role assignment list --scope "/subscriptions/<sub>/resourceGroups/dev-rg" -o table
```

---

## 63.6 Integration with Other Azure Services

| Service | Role with RBAC |
|---|---|
| **Microsoft Entra ID** | Provides the principals (users/groups/SPs/MIs) |
| **Management groups** | Top scope — assign roles once, inherit to many subscriptions |
| **Azure Policy** | Governs resource *compliance* (complements RBAC's *access*) |
| **PIM (Entra P2)** | Just-in-time, time-bound elevation of RBAC roles |
| **Managed identities** | Granted RBAC roles for keyless resource access |
| **Activity Log** | Audits who did what (paired with RBAC) |

---

## 63.7 Real-World Scenario — Least-Privilege Access Model

```
A company sets up tiered access for a project.
   1. Developers → Contributor on "dev-rg" only (manage dev resources, can't grant access).
   2. Team lead → Owner on "dev-rg" (manage + grant access to new developers).
   3. Auditors → Reader at the SUBSCRIPTION scope (view everything, change nothing).
   4. App's managed identity → Storage Blob Data Contributor on just the app's storage
      account (data-plane access, nothing else).
   5. A central admin who assigns roles but shouldn't touch resources → User Access
      Administrator.
   6. Highly privileged roles are made eligible via PIM (just-in-time) rather than permanent.
Result: everyone has exactly the access they need at the narrowest scope — least privilege,
auditable, and scalable via groups.
```

---

## 63.8 Benefits

- **Least privilege** — precise access by role + scope
- **Granular** — hundreds of built-in roles (management and data plane) + custom
- **Scalable** — assign to groups; inherit through scope hierarchy
- **Separation of duties** — Contributor vs Owner vs User Access Administrator
- **Auditable** — clear assignments + Activity Log
- **Conditions (ABAC)** — refine access by resource attributes/tags

---

## 63.9 Common Use Cases

- Granting teams scoped management access (Contributor on an RG)
- Read-only access for auditors (Reader at subscription)
- Data-plane access for apps (Storage Blob Data roles via managed identity)
- Delegating access management without resource control (User Access Administrator)
- Enterprise-wide access via management-group assignments

---

## 63.10 Exam Q&A

**Q: What three elements make up an Azure role assignment?**
> **Security principal (who)** — a user, group, service principal, or managed identity; **role definition (what)** — the set of permitted actions (e.g., Owner/Contributor/Reader/custom); and **scope (where)** — the level it applies to (management group, subscription, resource group, or resource). Together they answer "**who** can perform **what** actions **where**," and access **inherits** down the scope hierarchy.

**Q: What is the difference between the Owner and Contributor roles?**
> Both grant **full management** of resources, but **Owner can also assign roles** to other principals (grant access), whereas **Contributor cannot manage access** (no role assignments). So if someone must both manage resources **and** grant others access, they need **Owner**; if they should manage resources but **not** control who else has access, give them **Contributor**. This separation limits privilege escalation.

**Q: A user has the Contributor role on a storage account but can't read the blobs inside it. Why?**
> Because **Contributor is a management-plane role** — it lets them manage the **account** (create/delete, manage keys) but does **not** grant **data-plane** access to the blob contents. To read/write blobs they need a **data role** like **Storage Blob Data Reader/Contributor**. Azure deliberately separates managing the resource from accessing the data within it.

**Q: How does scope inheritance work, and how does it relate to least privilege?**
> A role assigned at a **higher scope** (e.g., subscription) is **inherited** by everything beneath it (all RGs and resources). **Least privilege** means assigning the **narrowest role** at the **narrowest scope** that still accomplishes the task — e.g., Contributor on a single RG rather than the whole subscription — so a principal can't affect resources it shouldn't. Over-broad, high-scope assignments violate least privilege.

**Q: If a user is a member of two groups with different roles on the same scope, what access do they get?**
> RBAC is **additive** — the user gets the **union** of all their role assignments (the combined permissions). For example, Reader from one group plus Contributor from another yields Contributor-level access. The exception is an explicit **Deny assignment**, which **overrides** allow assignments. There's no "most-restrictive-wins" by default; allows accumulate.

**Q: What is the User Access Administrator role for?**
> It lets a principal **manage access (assign/remove roles)** at a scope **without** granting the ability to **manage the resources** themselves. It's used for **separation of duties** — e.g., a security/identity admin who should control who has access but shouldn't be able to create or delete resources — complementing Contributor (manage resources, not access) and Owner (both).

---

## 63.11 Summary

**Azure RBAC** authorizes **what identities can do to which resources** via role assignments = **who (principal)** + **what (role definition)** + **where (scope)**, with access **inheriting** down **management group → subscription → resource group → resource**. Core roles: **Owner** (manage + grant access), **Contributor** (manage, **can't grant**), **Reader** (view), and **User Access Administrator** (grant only, no resource management). **Management-plane** roles (manage a storage account) are **separate from data-plane** roles (**Storage Blob Data Contributor** to read blobs). Assignments are **additive** (union), with **Deny** overriding allows, and can be refined with **conditions (ABAC)**. Follow **least privilege** (narrowest role + scope), assign to **groups** for scale, and elevate sensitive roles **just-in-time via PIM**. It's Azure's equivalent of **AWS IAM policies/roles**.

[↑ Back to top](#-table-of-contents)

---
---

# 64. 🧰 Custom Roles
> 🟠 MEDIUM
> 📚 Course lecture: 259 (Lab - Custom Roles)

---

## 64.1 What Problem Does This Solve?

Azure's **built-in roles** cover most needs, but sometimes none fits: you need to grant **exactly** a specific set of actions — more than Reader but far less than Contributor — following least privilege. **Custom roles** let you define your own role with a precise list of **allowed actions** (and NotActions, data actions), then assign it like any built-in role. They're for the gaps the built-ins don't fill cleanly.

Think of custom roles like **tailoring a uniform when off-the-rack doesn't fit**. The store's standard sizes (built-in roles) work for most people, but occasionally you need a custom cut — specific sleeves, specific length — so the wearer has exactly what the job requires, nothing extra.

> 💡 **If you know AWS:** A custom role is a **customer-managed IAM policy** — you enumerate the exact **Actions** (and deny/exclude some) instead of using an AWS-managed policy. Azure custom roles are defined in **JSON** with `Actions`, `NotActions`, `DataActions`, `NotDataActions`, and **AssignableScopes** (where the role can be used).

---

## 64.2 Custom Role Definition (Flow Diagram)

```
Start from a built-in role (clone) OR from scratch → define JSON:

   {
     "Name": "Virtual Machine Operator",
     "Description": "Start/stop/restart VMs, but not create or delete them",
     "Actions": [
        "Microsoft.Compute/virtualMachines/start/action",
        "Microsoft.Compute/virtualMachines/restart/action",
        "Microsoft.Compute/virtualMachines/deallocate/action",
        "Microsoft.Compute/virtualMachines/read",
        "Microsoft.Resources/subscriptions/resourceGroups/read"
     ],
     "NotActions": [],
     "DataActions": [],
     "NotDataActions": [],
     "AssignableScopes": [ "/subscriptions/<sub-id>" ]   ← where it can be assigned
   }

Permission = (Actions − NotActions)  for the management plane,
             (DataActions − NotDataActions) for the data plane.
```

| Field | Meaning |
|---|---|
| **Actions** | Management-plane operations **allowed** |
| **NotActions** | Operations **excluded** from Actions (subtracted) |
| **DataActions** | Data-plane operations allowed (e.g., read blobs) |
| **NotDataActions** | Data operations excluded |
| **AssignableScopes** | Subscriptions/RGs/MGs where the role **can be assigned** |

⚠️ **NotActions is NOT a deny** — it simply **removes** those actions from the Actions set; a separate assignment granting them would still apply. **AssignableScopes** limits where the role is usable, not what it can act on. Custom roles count against a **limited quota** (e.g., 5,000 per tenant).

---

## 64.3 UI / CLI Steps — Create & Assign a Custom Role

```
📍 Scope (e.g., Subscription) → "Access control (IAM)" → "+ Add" → "Add custom role"
   ┌──────────────────────────────────────────────┐
   │ Start from scratch / clone a role / from JSON  │
   │ Add permissions: search "Microsoft.Compute/    │
   │   virtualMachines/start/action" etc.           │
   │ Assignable scopes: this subscription            │
   └──────────────────────────────────────────────┘
   Review + create
    ↓
📍 Assign it like any role: IAM → Add role assignment → pick the custom role → member
```

```bash
# Create from a JSON definition
az role definition create --role-definition vm-operator.json

# Assign it
az role assignment create --assignee <user-object-id> \
  --role "Virtual Machine Operator" \
  --scope "/subscriptions/<sub>/resourceGroups/prod-rg"

# List/update custom roles
az role definition list --custom-role-only true -o table
az role definition update --role-definition vm-operator.json
```

---

## 64.4 Integration with Other Azure Services

| Service | Role with Custom Roles |
|---|---|
| **Azure RBAC** | Custom roles are assigned exactly like built-in roles |
| **Entra ID principals** | Assigned to users/groups/SPs/managed identities |
| **Management groups** | Can be an assignable scope for broad reuse |
| **PIM** | Custom roles can be made eligible (just-in-time) |
| **Azure Policy** | Governs resources; custom roles govern actions |

---

## 64.5 Real-World Scenario — Operators Who Can't Delete

```
A NOC team must start/stop/restart production VMs during incidents but must NEVER be able
to create or delete VMs (to prevent costly mistakes).
   1. No built-in role fits: Reader can't start VMs; VM Contributor can delete them.
   2. Create a custom "Virtual Machine Operator" role with only start/restart/deallocate/read.
   3. Set AssignableScopes to the production subscription.
   4. Assign it to the NOC security group at the prod resource group scope.
   5. Operators can now manage VM power state during incidents, with zero ability to
      create/delete resources — least privilege precisely enforced.
Result: exactly the needed access, no more — impossible with built-in roles alone.
```

---

## 64.6 Benefits

- **Precise least privilege** — grant exactly the needed actions
- **Fills built-in gaps** — when no built-in role fits cleanly
- **Reusable** — assign across chosen scopes like any role
- **Management + data plane** — control both via Actions/DataActions
- **Clonable** — start from a built-in role and trim/extend

---

## 64.7 Common Use Cases

- "Operator" roles (power-manage VMs without create/delete)
- Narrow data-plane access (specific storage/queue operations only)
- Delegating a single administrative task safely
- Meeting compliance that forbids over-permissioned built-in roles

---

## 64.8 Exam Q&A

**Q: When should you create a custom role instead of using a built-in one?**
> When **no built-in role matches the exact permissions needed** — typically when a built-in role grants **too much** (e.g., Contributor allows delete) or **too little** (Reader can't perform an action). Custom roles let you enumerate the **precise set of actions** for true least privilege. If a built-in role fits, you should use it; custom roles add management overhead and count against a quota.

**Q: What are Actions, NotActions, DataActions, and NotDataActions in a custom role?**
> **Actions** are allowed **management-plane** operations; **NotActions** are **subtracted** from Actions (excluded). **DataActions** are allowed **data-plane** operations (e.g., reading blob content); **NotDataActions** are subtracted from those. Effective permissions are **(Actions − NotActions)** and **(DataActions − NotDataActions)**. This separation lets a role manage a resource, access its data, or both — precisely.

**Q: Is NotActions a deny rule?**
> **No.** NotActions simply **removes** those operations from what this role's Actions grant — it is **not** a global deny. If the same principal has **another** role assignment that grants those actions, they'll still be allowed, because RBAC is **additive**. True denies require explicit **Deny assignments**, which are separate from custom role definitions.

**Q: What does the AssignableScopes field control?**
> It defines **where the custom role can be assigned** — the subscriptions, resource groups, or management groups at which the role is available for assignment. It does **not** limit what the role can act on once assigned (that's the assignment's scope); it controls the role's **availability**. For example, a role with AssignableScopes of one subscription can't be assigned in a different subscription.

**Q: How do you create a custom role, and can you base it on an existing one?**
> Define it in **JSON** (Name, Description, Actions/NotActions/DataActions, AssignableScopes) and create it via the portal ("Add custom role"), **`az role definition create`**, or PowerShell. You can **clone a built-in role** as a starting point and then **add or remove actions**, which is often easier than starting from scratch. Once created, it's assigned exactly like a built-in role.

---

## 64.9 Summary

**Custom roles** let you define RBAC roles with a **precise set of permissions** when **built-in roles don't fit** — granting exactly what's needed for least privilege. They're JSON definitions with **Actions/NotActions** (management plane), **DataActions/NotDataActions** (data plane), and **AssignableScopes** (where the role can be assigned). Effective access is **(Actions − NotActions)** and **(DataActions − NotDataActions)**; note **NotActions is a subtraction, not a deny**, since RBAC is **additive**. Create them from scratch, from JSON, or by **cloning a built-in role**, then assign them like any role. They're Azure's equivalent of **customer-managed IAM policies**, ideal for "operator" roles and other narrow, compliance-driven access needs.

[↑ Back to top](#-table-of-contents)

---
---

# 65. 👔 Microsoft Entra ID Roles
> 🟠 MEDIUM
> 📚 Course lectures: 260 (Microsoft Entra ID Roles), 261 (Lab), 262 (Note - Entra ID Custom Roles)

---

## 65.1 What Problem Does This Solve?

Managing the **directory itself** — creating users, resetting passwords, managing groups, configuring Entra settings — is a different job from managing Azure resources. **Microsoft Entra ID roles** (directory roles) grant administrative permissions **over the directory**, separate from **Azure RBAC** (which governs resources). Understanding this split, and which role does what, prevents both over-privileging and "why can't I do this?" confusion.

Think of the two role systems like **two different sets of keys for two different buildings**. Entra ID roles are keys to the **HR/identity building** (manage people, groups, directory settings). Azure RBAC roles are keys to the **data center** (manage VMs, storage, networks). Being the head of HR (Global Admin) doesn't automatically let you into the data center, and vice versa — they're deliberately separate.

> 💡 **If you know AWS:** Entra ID roles manage the **identity provider/directory** (users, groups, app registrations, SSO) — closer to administering **IAM Identity Center / the org's identity store** itself, rather than resource permissions. **Global Administrator** ≈ the identity-tenant super-admin. This is distinct from **resource** permissions (Azure RBAC ≈ IAM resource policies), just as managing your IdP differs from managing workloads.

---

## 65.2 Entra Roles vs Azure RBAC (Flow Diagram)

```
   ┌──────────────── MICROSOFT ENTRA ID ROLES ────────────────┐
   │  Manage the DIRECTORY: users, groups, domains, Entra conf  │
   │  Scope: the TENANT (directory-wide) or Administrative Units │
   │  e.g., Global Administrator, User Administrator,            │
   │        Password Administrator, Billing Administrator,       │
   │        Helpdesk Administrator, Global Reader                │
   └────────────────────────────────────────────────────────────┘
                         ⚠ SEPARATE FROM ⚠
   ┌──────────────────── AZURE RBAC ROLES ─────────────────────┐
   │  Manage RESOURCES: VMs, storage, networks                  │
   │  Scope: MG → Subscription → RG → Resource                  │
   │  e.g., Owner, Contributor, Reader                          │
   └────────────────────────────────────────────────────────────┘

   Bridge: a GLOBAL ADMIN can ELEVATE access to gain the "User Access
   Administrator" RBAC role at root, to bootstrap resource access — but by
   default the two planes are independent.
```

| Common Entra ID role | Can do |
|---|---|
| **Global Administrator** | Everything in Entra (and can elevate to Azure) — guard tightly |
| **User Administrator** | Create/manage users and groups, reset most passwords |
| **Password Administrator** | Reset passwords for non-admins |
| **Helpdesk Administrator** | Reset passwords, manage some user support tasks |
| **Billing Administrator** | Manage subscriptions/billing |
| **Global Reader** | Read-only view of everything (audit) |

⭐ Entra roles are assigned at the **tenant** level (or scoped via **Administrative Units**), and the highest, **Global Administrator**, should be **limited, MFA-protected, and ideally PIM-eligible (just-in-time)**. Entra also supports **custom directory roles** (P1).

---

## 65.3 UI / CLI Steps — Assign an Entra Role

```
📍 portal.azure.com → "Microsoft Entra ID" → "Roles and administrators"
    ↓
📍 Pick a role (e.g., "User Administrator") → "+ Add assignments" → select users/groups
   (optionally scope to an Administrative Unit)
    ↓
📍 Review assignments under the role; sensitive roles should be PIM-eligible (Entra P2)
📍 Elevate access (Global Admin only): Entra ID → Properties →
   "Access management for Azure resources" = Yes  (grants root User Access Administrator)
```

```bash
# List directory roles
az rest --method GET --url "https://graph.microsoft.com/v1.0/directoryRoles"

# Assign via Microsoft Graph (PowerShell: New-MgRoleManagementDirectoryRoleAssignment)
# Azure CLI focuses on resource RBAC; Entra roles are managed via Graph/portal/PowerShell.
```

---

## 65.4 Integration with Other Azure Services

| Service | Role with Entra ID roles |
|---|---|
| **Azure RBAC** | Separate plane; Global Admin can elevate to bootstrap RBAC |
| **PIM (Entra P2)** | Just-in-time activation of privileged directory roles |
| **Administrative Units** | Scope Entra roles to a subset of users/groups |
| **Conditional Access** | Enforce MFA for admin role holders |
| **Microsoft 365** | Many M365 admin tasks map to Entra roles |

---

## 65.5 Real-World Scenario — Delegating Helpdesk Without Over-Privileging

```
A company wants helpdesk staff to reset passwords but NOT manage resources or be full admins.
   1. Assign the "Helpdesk Administrator" (or Password Administrator) Entra role to the
      helpdesk group — they can reset non-admin passwords, nothing more.
   2. Scope it with an Administrative Unit so they only manage their region's users.
   3. Global Administrator is held by just two people, MFA-enforced, and made PIM-eligible
      so it's activated just-in-time with approval, not standing access.
   4. Auditors get Global Reader for directory visibility without change rights.
   5. Resource access is handled entirely separately via Azure RBAC.
Result: precise directory delegation, a tiny protected Global Admin footprint, and clean
separation between identity administration and resource management.
```

---

## 65.6 Benefits

- **Separation of duties** — directory admin distinct from resource admin
- **Granular directory roles** — helpdesk/password/user admin, etc.
- **Scoping** — Administrative Units limit roles to user subsets
- **Governable** — PIM just-in-time + MFA for privileged roles
- **Auditable** — Global Reader and sign-in/audit logs
- **Custom directory roles** — tailor directory permissions (P1)

---

## 65.7 Common Use Cases

- Delegating password resets to helpdesk (Helpdesk/Password Administrator)
- User/group lifecycle management (User Administrator)
- Read-only directory auditing (Global Reader)
- Protecting and time-boxing Global Administrator via PIM
- Regionally scoped admin via Administrative Units

---

## 65.8 Exam Q&A

**Q: What is the fundamental difference between Microsoft Entra ID roles and Azure RBAC roles?**
> **Entra ID (directory) roles** grant administrative control over the **directory** — users, groups, domains, and Entra configuration (e.g., Global Administrator, User Administrator). **Azure RBAC roles** grant control over **Azure resources** — VMs, storage, networks (e.g., Owner, Contributor, Reader). They operate on **different planes** and are assigned/managed separately, so holding one doesn't automatically grant the other.

**Q: Does being a Global Administrator in Entra ID give you access to manage Azure resources?**
> **Not by default.** Global Administrator is an **Entra directory** role; it doesn't inherently include **Azure RBAC** permissions over resources. However, a Global Admin can **"elevate access"** (Entra ID → Properties) to be granted the **User Access Administrator** RBAC role at the **root scope**, which then lets them assign themselves resource access. Absent that deliberate elevation, the planes remain separate.

**Q: Which Entra role should you give helpdesk staff who only need to reset user passwords?**
> **Helpdesk Administrator** or **Password Administrator** — these allow resetting passwords for **non-admin** users without granting broader directory or resource control. This follows least privilege, avoiding the over-powerful **User Administrator** (which can also create/manage users and groups) or **Global Administrator**. You can further limit scope with **Administrative Units**.

**Q: How should the Global Administrator role be protected?**
> Keep the number of Global Admins **minimal**, enforce **MFA** (via Conditional Access), and make the role **PIM-eligible (Entra ID P2)** so it's activated **just-in-time** with approval and time limits rather than held as standing access. Monitor with **audit logs** and keep a break-glass emergency account. Because Global Admin can control the entire directory (and elevate to Azure), it's the highest-value target to safeguard.

**Q: Can you scope an Entra ID role to only part of the directory?**
> Yes — using **Administrative Units (AUs)**, you can scope certain directory roles (like User/Helpdesk Administrator) to a **subset of users/groups** (e.g., one region or department), rather than the entire tenant. This enables delegated, regionally- or departmentally-bounded administration, mirroring the least-privilege, narrow-scope principle used in Azure RBAC.

---

## 65.9 Summary

**Microsoft Entra ID (directory) roles** administer the **directory** — users, groups, domains, and Entra settings — and are **separate from Azure RBAC**, which administers **resources**. Common roles include **Global Administrator** (everything in Entra — guard tightly), **User Administrator** (manage users/groups), **Password/Helpdesk Administrator** (reset passwords), **Billing Administrator**, and **Global Reader** (audit). Entra roles apply at the **tenant** level or can be scoped with **Administrative Units**, and privileged roles should be **MFA-protected and PIM-eligible (just-in-time)**. A **Global Admin** can deliberately **"elevate access"** to bootstrap Azure RBAC, but by default the two planes are independent. Entra also supports **custom directory roles** (P1). Keeping directory and resource administration distinct is the core exam takeaway.

[↑ Back to top](#-table-of-contents)

---
---

# 66. 🤝 External Identities (B2B)
> 🟡 KNOW-THIS-MUCH
> 📚 Course lecture: 263 (Microsoft Entra ID - Inviting external identities)

---

## 66.1 What Problem Does This Solve?

Organizations collaborate with **partners, vendors, and contractors** who have their own identities elsewhere. Creating internal accounts for every external person is insecure and unmanageable. **Microsoft Entra External Identities (B2B)** lets you **invite external users as guests** — they sign in with **their own existing credentials** (another Entra tenant, a Microsoft account, Google, email OTP), and you grant them scoped access to your resources/apps without ever managing their passwords.

Think of B2B like **issuing a visitor badge to a contractor who keeps their own company ID**. They don't become your employee or get a new corporate identity; they badge in with credentials their own company manages, and your security desk decides which rooms the visitor badge opens. When the project ends, you deactivate the visitor badge.

> 💡 **If you know AWS:** B2B guest access is like **federated/external access via SAML/OIDC** or cross-account access — external principals authenticate with **their own IdP** and are granted scoped permissions in your environment, without you provisioning full internal accounts or credentials for them.

---

## 66.2 How B2B Guest Access Works (Flow Diagram)

```
   YOUR TENANT (contoso)                         PARTNER'S IDENTITY
   ┌──────────────────────┐    invite email     ┌─────────────────────┐
   │ Invite partner@fabrikam ──────────────────► │ partner@fabrikam.com │
   │                       │                      │ (their own tenant / │
   │ Guest user object     │ ◄── accepts invite ──│  MS account / Google│
   │  partner@fabrikam.com │                      │  / email OTP)        │
   │  (userType = Guest)   │                      └─────────────────────┘
   └──────────┬───────────┘
              │ grant access like any principal:
              ├─ Azure RBAC role on a resource/RG
              └─ Add to groups / assign to apps (SSO)

   The guest authenticates in THEIR home directory; you never store their password.
```

| Aspect | B2B detail |
|---|---|
| **Guest user type** | `userType = Guest` in your directory |
| **Credentials managed by** | The guest's **home** identity provider (not you) |
| **Sign-in options** | Another Entra tenant, Microsoft account, Google, **email OTP**, SAML/OIDC |
| **Access granted via** | **Azure RBAC**, group membership, app assignment — same as members |
| **Governance** | Access reviews, Conditional Access, expiration (Entra P2 for reviews) |

⚠️ B2B (**guests into your tenant**) differs from **B2C** (a **separate** customer-facing identity product for your app's end-users). Also distinguish **B2B collaboration** (guest in your directory) from **B2B direct connect** (Teams shared channels).

---

## 66.3 UI / CLI Steps — Invite a Guest

```
📍 Entra ID → "Users" → "+ New user" → "Invite external user"
   ┌──────────────────────────────────────────────┐
   │ Email: partner@fabrikam.com                     │
   │ Display name: Partner (Fabrikam)                │
   │ Groups/roles: optionally add now                │
   │ Invitation message: optional                    │
   └──────────────────────────────────────────────┘
   Invite → guest receives an email → accepts → appears as Guest in your directory
    ↓
📍 Grant access: Resource/RG → Access control (IAM) → assign an RBAC role to the guest
📍 Govern: External Identities → settings (who can invite, allowed domains);
   Access Reviews to periodically recertify guests (P2)
```

```bash
az ad user invite --invited-user-email-address partner@fabrikam.com \
  --invite-redirect-url "https://myapps.microsoft.com"

# Then assign RBAC like any principal
az role assignment create --assignee <guest-object-id> \
  --role "Reader" --scope "/subscriptions/<sub>/resourceGroups/shared-rg"
```

---

## 66.4 Integration with Other Azure Services

| Service | Role with B2B |
|---|---|
| **Azure RBAC** | Grant guests scoped resource access |
| **Groups & app assignments** | Add guests for SSO to apps |
| **Conditional Access** | Apply MFA/conditions to guest sign-ins |
| **Access Reviews (P2)** | Periodically recertify/remove stale guests |
| **Entra External ID settings** | Control who can invite and which domains are allowed |

---

## 66.5 Real-World Scenario — Partner Collaboration on a Project

```
A company shares a project workspace and some Azure resources with an external consultancy.
   1. Invite each consultant as a B2B guest (they use their own Fabrikam/Google credentials).
   2. Add guests to a "Project-X Partners" group; grant that group Reader on the project RG
      and access to the project's SharePoint/Teams.
   3. Conditional Access requires MFA for all guest sign-ins.
   4. An Access Review every 90 days recertifies which guests still need access; lapsed
      ones are auto-removed.
   5. At project end, disable/delete the guests — the consultancy's own identities are
      unaffected.
Result: secure, low-overhead external collaboration with no internal passwords to manage
and governed, time-bound access.
```

---

## 66.6 Benefits

- **No credential management** — guests use their own identities
- **Secure collaboration** — scoped access via RBAC/groups/apps
- **Flexible sign-in** — other tenants, Microsoft/Google accounts, email OTP
- **Governable** — Conditional Access + Access Reviews + expiration
- **Low overhead** — invite and revoke without provisioning full accounts

---

## 66.7 Common Use Cases

- Partner/vendor/contractor access to apps and resources
- Sharing SharePoint/Teams/Power BI with external collaborators
- Granting temporary, scoped Azure resource access to consultants
- Cross-organization project collaboration

---

## 66.8 Exam Q&A

**Q: What is Microsoft Entra B2B, and who manages the guest's credentials?**
> **B2B (External Identities / collaboration)** lets you **invite external users as guests** into your tenant so they can access your resources and apps. Crucially, their **credentials are managed by their own home identity provider** (another Entra tenant, a Microsoft/Google account, or email OTP) — you **never store or reset their password**. The guest appears in your directory as `userType = Guest` and is granted access like any principal.

**Q: How do you grant a B2B guest access to an Azure resource?**
> Exactly like any other principal — assign them an **Azure RBAC role** at the appropriate **scope** (or add them to a **group** that has the role, or assign them to an **app**). Once invited and accepted, the guest object behaves like a member for authorization purposes; the only difference is **where they authenticate** (their home directory) and that they're flagged as a guest.

**Q: What's the difference between Entra B2B and B2C?**
> **B2B** brings **external business users (guests)** into **your** corporate directory to collaborate on your resources/apps. **B2C** is a **separate customer identity product** for building sign-up/sign-in for **your application's external consumers** (customers), with customizable identity experiences and social logins — it's not about guests in your corporate tenant. B2B = partners/vendors; B2C = your app's end customers.

**Q: How can you ensure external guests don't retain access longer than needed?**
> Use **Access Reviews** (Entra ID **P2**) to periodically **recertify** guest access and automatically remove those no longer needed, set **expiration** on guest access, and apply **Conditional Access** (e.g., require MFA) to guest sign-ins. Governing guest lifecycle this way prevents stale external access from accumulating, which is a key security and compliance concern.

---

## 66.9 Summary

**Microsoft Entra External Identities (B2B)** let you **invite external partners/vendors/contractors as guest users** who sign in with **their own existing credentials** (another Entra tenant, Microsoft or Google account, or **email OTP**) — so you **never manage their passwords**. Guests appear as `userType = Guest` and are granted **scoped access via Azure RBAC, groups, or app assignments**, just like members. Govern them with **Conditional Access (MFA)**, **Access Reviews (P2)**, and **expiration**. Distinguish **B2B** (external business guests in your tenant) from **B2C** (a separate product for your app's customer identities). It enables secure, low-overhead external collaboration with governed, revocable access.

[↑ Back to top](#-table-of-contents)

---
---

# 67. 🎫 Microsoft Entra ID Licenses
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 264 (Entra ID Licenses), 265 (Assigning to users), 266 (Assigning to groups), 267 (Group-based licensing)

---

## 67.1 What Problem Does This Solve?

Entra ID's advanced security and governance features aren't all free — they're gated behind **license tiers**. To use **Conditional Access**, **self-service password reset for cloud users**, **PIM**, **Identity Protection**, or **access reviews**, you need the right license (**P1** or **P2**), and those licenses must be **assigned** to the users who benefit. Managing licenses — ideally via **groups** — ensures the right people have the right capabilities without manual per-user churn.

Think of licenses like **membership tiers at a gym**. Basic membership (Free) gets you the treadmills; Premium (P1) unlocks the pool and classes; Elite (P2) adds the spa and personal trainer. You pay per member and assign the tier each person needs — and with a corporate plan you enroll whole teams at once (group-based licensing) instead of signing people up one by one.

> 💡 **If you know AWS:** There's no direct AWS analog — AWS bundles IAM features without separate identity license tiers. The closest mindset is **feature entitlements per edition/plan**: certain capabilities require a higher-tier subscription, and you must allocate those entitlements to the identities that use them.

---

## 67.2 License Tiers & Assignment (Flow Diagram)

```
ENTRA ID EDITIONS (feature gating):
   FREE        → basic users/groups, SSO, security defaults
   P1          → Conditional Access, SSPR for cloud users, group-based licensing,
                 dynamic groups, Entra Connect advanced, self-service group mgmt
   P2          → everything in P1 + PIM, Identity Protection, Access Reviews,
                 risk-based Conditional Access
   (P1/P2 also come bundled in Microsoft 365 E3/E5)

ASSIGNMENT:
   Direct (per user)        → fiddly at scale
   GROUP-BASED licensing ✅ → assign the license to a GROUP; members inherit it;
                              leaving the group removes it (requires P1)

   ⚠ License needs a USAGE LOCATION set on the user (for legal/regional availability).
```

| Tier | Key features unlocked |
|---|---|
| **Free** | Users/groups, SSO, Security Defaults, basic self-service |
| **P1** | Conditional Access, SSPR (cloud), group-based licensing, dynamic groups |
| **P2** | P1 + PIM, Identity Protection, Access Reviews, risk-based policies |

⭐ **Group-based licensing** (P1) is the scalable approach — assign a product license to a group and all members inherit it automatically; conflicts/errors surface per user if prerequisites aren't met.

---

## 67.3 UI / CLI Steps — Assign Licenses

```
📍 Entra ID → "Licenses" → "All products" → select a product (e.g., Entra ID P1/P2)
    ↓
── Per user ──
📍 Product → "+ Assign" → select users → set/verify Usage location → Assign

── Group-based (recommended) ──
📍 Product → "+ Assign" → select a GROUP → choose service plans → Assign
   → all current and future members inherit the license
    ↓
📍 Check "Licensed users" / per-user license status to catch assignment errors
```

```powershell
# Microsoft Graph PowerShell
Update-MgUser -UserId alice@contoso.com -UsageLocation "IN"
Set-MgUserLicense -UserId alice@contoso.com -AddLicenses @{SkuId="<sku-guid>"} -RemoveLicenses @()
# Group-based licensing is configured in the portal / via Graph group license APIs
```

---

## 67.4 Integration with Other Azure Services

| Feature gated by license | Tier |
|---|---|
| **Conditional Access** | P1 |
| **Self-Service Password Reset (cloud users)** | P1 (writeback for hybrid also P1) |
| **Dynamic groups / group-based licensing** | P1 |
| **Privileged Identity Management (PIM)** | P2 |
| **Identity Protection / risk policies** | P2 |
| **Access Reviews** | P2 |

---

## 67.5 Real-World Scenario — Rolling Out Advanced Security

```
A company wants MFA via Conditional Access for all staff and PIM for admins.
   1. Purchase Entra ID P1 for all staff and P2 for the admin group.
   2. Set usage location on users (often synced from on-prem).
   3. Use GROUP-BASED licensing: assign P1 to an "All Staff" dynamic group and P2 to
      an "Admins" group → new hires and new admins inherit the right license automatically.
   4. With P1 in place, enable Conditional Access requiring MFA; with P2, make admin roles
      PIM-eligible with just-in-time activation.
   5. Monitor the licenses blade for assignment errors (e.g., missing usage location).
Result: the right capabilities reach the right people automatically, scaling cleanly as
the org changes.
```

---

## 67.6 Benefits

- **Feature access** — unlock Conditional Access, PIM, Identity Protection, etc.
- **Scalable assignment** — group-based licensing auto-manages membership
- **Right-sizing** — assign P1 broadly, P2 to those who need it
- **Automatic lifecycle** — join/leave a group to gain/lose a license
- **Error visibility** — per-user license status flags problems

---

## 67.7 Common Use Cases

- Enabling Conditional Access/MFA org-wide (P1)
- Enabling PIM, Identity Protection, Access Reviews for admins (P2)
- Group-based licensing for scalable assignment
- Right-sizing security spend across user populations

---

## 67.8 Exam Q&A

**Q: Which Entra ID license tier is required for Conditional Access, and which for PIM?**
> **Conditional Access requires P1**; **Privileged Identity Management (PIM) requires P2**. P2 is a superset of P1, also adding **Identity Protection** (risk-based policies) and **Access Reviews**. Knowing which feature needs which tier is a common exam point — if a scenario needs just-in-time privileged access (PIM) or risk-based sign-in, it's **P2**.

**Q: What is group-based licensing and why use it?**
> **Group-based licensing** (a **P1** capability) lets you assign a product license to a **security group**; all **current and future members inherit** the license automatically, and **losing membership removes it**. This scales far better than per-user assignment — new hires added to the group get licensed automatically — and reduces manual errors, though you must still monitor per-user status for assignment conflicts.

**Q: A license assignment fails for a user. What's a common prerequisite to check?**
> The user's **Usage Location** — licenses are region/legally gated, so a user **must have a usage location set** before certain licenses can be assigned; otherwise assignment fails. Other causes include **conflicting service plans** or missing dependencies between products. The per-user license status surfaces the specific error to resolve.

**Q: How are P1/P2 features typically obtained besides standalone Entra licenses?**
> They're frequently **bundled in Microsoft 365 plans** — e.g., **Microsoft 365 E3 includes Entra ID P1** and **E5 includes P2**. So an organization already on M365 E5 effectively has P2 capabilities (PIM, Identity Protection, Access Reviews) without buying standalone Entra licenses. This bundling is worth remembering when a scenario mentions existing M365 licensing.

---

## 67.9 Summary

**Microsoft Entra ID licenses** gate advanced features across tiers: **Free** (basic users/groups/SSO), **P1** (**Conditional Access**, cloud **SSPR**, **group-based licensing**, dynamic groups), and **P2** (P1 + **PIM**, **Identity Protection**, **Access Reviews**, risk-based policies). Licenses must be **assigned** to users — best done via **group-based licensing** (P1) so members **inherit** them automatically — and users need a **Usage Location** set or assignment fails. P1/P2 also come **bundled in Microsoft 365 E3/E5**. Match the tier to the capability a scenario needs: **Conditional Access → P1**, **PIM/Identity Protection/Access Reviews → P2**.

[↑ Back to top](#-table-of-contents)

---
---

# 68. 🔁 Self-Service Password Reset (SSPR)
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 268 (What is SSPR), 269 (Enabling SSPR), 270 (Performing a reset)

---

## 68.1 What Problem Does This Solve?

Password resets are the #1 helpdesk ticket, costing time and money and locking users out while they wait. **Self-Service Password Reset (SSPR)** lets users **reset or unlock their own accounts** securely, after verifying their identity through registered methods (phone, email, authenticator app, security questions) — no helpdesk required. It reduces costs, cuts downtime, and improves security by tying resets to strong verification.

Think of SSPR like a **self-service kiosk at the bank for a forgotten PIN**. Instead of waiting in line for a teller (helpdesk), you verify yourself at the kiosk with ID and a one-time code sent to your phone, then set a new PIN yourself — faster for you and frees the teller for other work.

> 💡 **If you know AWS:** Conceptually similar to a **self-service account recovery flow** (like Cognito's forgot-password with verified contact methods) — the user proves identity through pre-registered factors and resets their own credential, rather than an admin doing it.

---

## 68.2 How SSPR Works (Flow Diagram)

```
SETUP (admin):  Entra ID → Password reset → enable for Selected group / All users
                → choose required # of auth methods (1 or 2) and which methods allowed

REGISTRATION (user): first time → register methods (mobile phone, email,
                     Microsoft Authenticator, security questions)

RESET (user):   aka.ms/sspr  (or "Forgot my password" at sign-in)
                 │
                 ├─ enter username + captcha
                 ├─ verify via registered method(s) (e.g., code to phone + app approval)
                 └─ set a new password → done (no helpdesk)

HYBRID: "Password writeback" syncs the new password back to on-prem AD (needs P1 + Entra
        Connect) so it works everywhere.
```

| Element | Detail |
|---|---|
| **Scope** | None / Selected group / All users |
| **Auth methods** | Mobile phone (SMS/call), email, Microsoft Authenticator, security questions |
| **Methods required** | Admin sets 1 or 2 for a reset |
| **Registration** | Users register methods (can be enforced) |
| **Password writeback** | Syncs resets to on-prem AD (hybrid) — needs **P1** + Entra Connect |

⚠️ **SSPR for cloud users** benefits from **P1**; **password writeback** (hybrid) **requires P1**. Combined registration lets users register SSPR and MFA methods together.

---

## 68.3 UI Steps — Enable & Use SSPR

```
📍 Entra ID → "Password reset" → "Properties"
   Self-service password reset enabled: Selected / All → Save
    ↓
📍 "Authentication methods" → number of methods required (e.g., 2) + which methods allowed
📍 "Registration" → require users to register when signing in (Yes), re-confirm every N days
📍 (Hybrid) "On-premises integration" → enable Password writeback (needs Entra Connect + P1)
    ↓
── User experience ──
📍 User visits  https://aka.ms/sspr  → enters username → verifies via registered methods →
   sets a new password  ✅  (or clicks "Forgot my password?" on the sign-in page)
```

---

## 68.4 Integration with Other Azure Services

| Service | Role with SSPR |
|---|---|
| **Entra Connect** | Password writeback to on-prem AD (hybrid) |
| **MFA / combined registration** | Shared verification methods, unified registration |
| **Conditional Access** | Governs sign-ins alongside SSPR |
| **Entra ID P1** | Required for writeback; enhances cloud SSPR |
| **Audit logs** | Track registrations and reset events |

---

## 68.5 Real-World Scenario — Cutting Helpdesk Load

```
A company's helpdesk is overwhelmed by password-reset tickets.
   1. Enable SSPR for all users, requiring 2 verification methods.
   2. Enforce registration at next sign-in via combined registration (SSPR + MFA together).
   3. Enable password writeback (P1 + Entra Connect) so resets also update on-prem AD —
      users' domain-joined machines accept the new password.
   4. Users now self-reset at aka.ms/sspr in minutes, any time, without a ticket.
   5. Audit logs track reset activity for security review.
Result: a large drop in helpdesk tickets, less user downtime, and resets secured by strong,
pre-registered verification.
```

---

## 68.6 Benefits

- **Fewer helpdesk tickets** — users self-serve resets
- **Less downtime** — reset anytime, no waiting
- **Secure** — tied to strong, pre-registered verification methods
- **Hybrid-ready** — writeback keeps on-prem AD in sync
- **Unified registration** — combined SSPR + MFA setup

---

## 68.7 Common Use Cases

- Reducing password-reset helpdesk volume
- Enabling users to unlock/reset accounts out of hours
- Hybrid environments needing on-prem password sync (writeback)
- Strengthening reset security with multi-method verification

---

## 68.8 Exam Q&A

**Q: What is SSPR and what's its main benefit?**
> **Self-Service Password Reset** lets users **reset or unlock their own accounts** after verifying identity via **pre-registered methods** (phone, email, Authenticator, security questions), without contacting the helpdesk. The main benefits are **reduced helpdesk cost/volume** and **less user downtime**, while maintaining security by requiring strong verification before a reset is allowed.

**Q: What does password writeback do, and what does it require?**
> **Password writeback** synchronizes a password **reset done in the cloud back to on-premises Active Directory**, so hybrid users can use the new password on domain-joined resources. It requires **Microsoft Entra Connect** (for sync) and an **Entra ID P1** license. Without writeback, a cloud SSPR reset wouldn't propagate to on-prem AD, causing a mismatch in hybrid environments.

**Q: How can an admin ensure users can actually use SSPR when they need it?**
> **Enforce registration** of authentication methods (e.g., require users to register at next sign-in, ideally via **combined registration** with MFA), enable SSPR for the appropriate **scope** (selected group/all), and configure the **required number and types** of verification methods. If users haven't registered methods, they can't complete a self-service reset, so enforced registration is key.

**Q: Which license is associated with SSPR capabilities, particularly for hybrid?**
> Cloud-user SSPR is enhanced with **Entra ID P1**, and **password writeback** for **hybrid** users specifically **requires P1**. (Security Defaults/Free provide limited self-service for some scenarios, but full SSPR configuration and writeback align with **P1**.) A hybrid scenario needing on-prem sync should flag **P1 + Entra Connect** as prerequisites.

---

## 68.9 Summary

**Self-Service Password Reset (SSPR)** lets users **reset/unlock their own accounts** via **pre-registered verification methods** (phone, email, Microsoft Authenticator, security questions), slashing helpdesk tickets and downtime while keeping resets secure. Admins enable it per **scope** (selected group/all), set the **number and types of methods required**, and **enforce registration** (ideally **combined** with MFA). For hybrid, **password writeback** syncs resets to **on-prem AD** and **requires Entra ID P1 + Entra Connect**. Users reset at **aka.ms/sspr** or via "Forgot my password?" at sign-in.

[↑ Back to top](#-table-of-contents)

---
---

# 69. 🏷️ Resource Tags
> 🟠 MEDIUM
> 📚 Course lecture: 271 (Resource tags)

---

## 69.1 What Problem Does This Solve?

In a large Azure estate with hundreds of resources, you need to **organize, track cost, automate, and govern** them by attributes that Azure's folder structure (subscriptions/RGs) alone can't express — like which **cost center**, **environment**, **owner**, or **project** a resource belongs to. **Tags** are **name:value metadata** you attach to resources, resource groups, and subscriptions, enabling filtering, cost reporting, and policy/automation based on those labels.

Think of tags like **sticky labels on filing boxes**. The boxes sit in rooms (resource groups), but labels like "Dept: Finance", "Project: Apollo", "Env: Prod" let you instantly find, bill, and act on boxes across every room — slicing your inventory by meaning, not just location.

> 💡 **If you know AWS:** Azure tags are **identical in concept to AWS resource tags** — key:value pairs for organization, **cost allocation** (like AWS cost allocation tags), automation, and policy. Both support tag-based filtering and governance. One difference: in Azure, tags applied to a **resource group are NOT inherited** by its resources by default (you enforce inheritance via Azure Policy).

---

## 69.2 How Tags Work (Flow Diagram)

```
TAG = name : value   (e.g., Environment : Production)

   Apply to:  Subscriptions · Resource groups · Resources (most types)

   Resource "web-vm":
      Environment = Production
      CostCenter  = CC-1024
      Owner       = alice@contoso.com
      Project     = Apollo

   USES:
   • Cost Management → group/filter spend by CostCenter or Project
   • Governance      → Azure Policy requires/append tags
   • Automation      → scripts target resources where Environment=Dev (e.g., auto-shutdown)
   • Search/organize → filter the portal/CLI by tag

   ⚠ RG tags do NOT auto-inherit to resources (use Azure Policy to enforce/inherit).
   ⚠ Limits: up to 50 tags per resource; some resource types don't support tags.
```

| Aspect | Detail |
|---|---|
| **Format** | `name:value` pairs |
| **Applies to** | Subscriptions, resource groups, most resources |
| **Max per resource** | 50 tags |
| **Inheritance** | **Not** automatic from RG → resources (enforce via Policy) |
| **Common uses** | Cost allocation, environment/owner labeling, automation targeting, governance |

---

## 69.3 UI / CLI Steps — Apply & Use Tags

```
📍 Resource / RG / Subscription → "Tags" → add name:value pairs → Save
📍 Bulk: "All resources" → select multiple → "Assign tags"
📍 Cost: Cost Management → Cost analysis → Group by "Tag" → pick CostCenter/Project
📍 Govern: Azure Policy → assign "Require a tag on resources" / "Inherit a tag from the RG"
```

```bash
# Tag a resource
az resource tag --tags Environment=Production CostCenter=CC-1024 \
  --ids "/subscriptions/<sub>/resourceGroups/prod-rg/providers/Microsoft.Compute/virtualMachines/web-vm"

# Tag a resource group
az group update -n prod-rg --tags Environment=Production Project=Apollo

# Find all resources with a given tag
az resource list --tag Environment=Dev -o table
```

---

## 69.4 Integration with Other Azure Services

| Service | Role with Tags |
|---|---|
| **Cost Management + Billing** | Cost allocation/reporting by tag |
| **Azure Policy** | Require, append, or inherit tags (governance) |
| **Automation / scripts** | Target resources by tag (e.g., auto-shutdown Dev) |
| **Resource Graph** | Query resources by tag at scale |
| **RBAC/organization** | Complement scopes with cross-cutting labels |

---

## 69.5 Real-World Scenario — Cost Accountability & Automation

```
A company needs per-department cost reporting and automatic dev shutdowns.
   1. Define a tagging standard: Environment, CostCenter, Owner, Project.
   2. Enforce it with Azure Policy: deny resource creation without a CostCenter tag; inherit
      Environment from the resource group.
   3. Cost Management groups spend by CostCenter → each department sees its own bill.
   4. An automation runbook stops all VMs tagged Environment=Dev at 8 PM to save money.
   5. Ownership tags make it clear who to contact about any resource.
Result: accurate chargeback, enforced consistency, and tag-driven automation across the estate.
```

---

## 69.6 Benefits

- **Cost allocation** — report/charge back spend by project/department
- **Organization** — slice resources by meaning across RGs/subscriptions
- **Automation** — target resources by tag (shutdowns, backups)
- **Governance** — enforce/inherit tags via Azure Policy
- **Accountability** — owner/contact metadata on every resource

---

## 69.7 Common Use Cases

- Cost chargeback/showback by CostCenter or Project
- Labeling environment (Prod/Dev/Test) for automation and clarity
- Enforcing required tags with Azure Policy
- Targeting resources for scheduled automation (auto-shutdown/backup)
- Tracking ownership and compliance metadata

---

## 69.8 Exam Q&A

**Q: What are Azure tags and what are they used for?**
> Tags are **name:value metadata** applied to subscriptions, resource groups, and resources to **organize, allocate cost, automate, and govern** the estate by attributes like environment, owner, cost center, or project. They enable **cross-cutting** grouping that the subscription/RG hierarchy can't express — e.g., finding or billing all "Project=Apollo" resources regardless of which RG they live in.

**Q: Do resources automatically inherit tags from their resource group?**
> **No** — by default, tags on a **resource group are not inherited** by the resources inside it. If you want inheritance, you enforce it with **Azure Policy** (e.g., the "Inherit a tag from the resource group" policy), which appends the RG's tag value to resources. This is a frequent exam gotcha: RG-level tags don't propagate on their own.

**Q: How do tags support cost management?**
> In **Cost Management**, you can **group and filter spend by tag** (e.g., CostCenter or Project), enabling **chargeback/showback** so each department or project sees its own costs. This turns a single Azure bill into meaningful, attributable spending reports — provided resources are consistently tagged, which is why organizations often **enforce required tags via Azure Policy**.

**Q: How can you ensure every resource has required tags?**
> Use **Azure Policy** — assign policies that **require** specific tags (denying creation of untagged resources), **append** a default tag value if missing, or **inherit** a tag from the resource group. This enforces a consistent tagging standard automatically, rather than relying on users to tag correctly, ensuring reliable cost reporting and governance.

---

## 69.9 Summary

**Tags** are **name:value metadata** attached to subscriptions, resource groups, and most resources, enabling **cost allocation, organization, automation, and governance** by cross-cutting attributes (Environment, CostCenter, Owner, Project) that the resource hierarchy can't express. Key facts: up to **50 tags per resource**, some resource types don't support tags, and **RG tags do NOT auto-inherit** to resources (enforce inheritance/requirements with **Azure Policy**). Tags power **Cost Management** reporting/chargeback, **tag-targeted automation** (e.g., auto-shutdown Dev), and **Resource Graph** queries. They're conceptually identical to **AWS resource tags**.

[↑ Back to top](#-table-of-contents)

---
---

# 70. 🔐 Moving & Locking Resources
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 272 (Moving resources across resource groups), 273 (Moving across subscriptions), 274 (Locking Resources)

---

## 70.1 What Problem Does This Solve?

Resources sometimes need to **move** — reorganizing into the right resource group, or shifting to another subscription (for billing, ownership, or lifecycle). And critical resources need **protection** from accidental change or deletion. Azure provides **resource move** operations and **resource locks** (**CanNotDelete** and **ReadOnly**) to reorganize safely and to guard important resources against costly mistakes.

Think of moving like **relocating furniture between rooms or houses** (RG vs subscription) — mostly fine, but some items are bolted down or won't fit through certain doors (move limitations). Locks are like **putting a "do not remove" seal on critical equipment** — CanNotDelete means "you can use and adjust it but not throw it away," and ReadOnly means "look but don't touch."

> 💡 **If you know AWS:** Moving between resource groups/subscriptions is like **reorganizing resources across accounts/OUs** (though AWS often requires recreate/migrate rather than a native move). **Resource locks** are akin to **termination protection / SCP-style guardrails** — preventing deletion or changes regardless of the user's IAM permissions.

---

## 70.2 Moving & Locking (Flow Diagram)

```
MOVING RESOURCES:
   Resource → "Move" → { to another Resource Group | to another Subscription }
      • Source and destination may need the SAME region/constraints for some types
      • Not ALL resource types can be moved; some have dependencies that must move together
      • During a move, the resources are briefly LOCKED (read-only); IDs change afterward
      • Validate first ("Validate move") to catch unsupported resources

RESOURCE LOCKS (inherited DOWNWARD like RBAC scope):
   ┌──────────────────────────────────────────────────────────┐
   │ CanNotDelete → can read & modify, but CANNOT delete         │
   │ ReadOnly     → can read only; cannot modify OR delete       │
   └──────────────────────────────────────────────────────────┘
   Apply at: Subscription / Resource group / Resource → inherited by children.
   ⚠ Locks OVERRIDE RBAC: even an Owner cannot delete a CanNotDelete-locked resource
     until the lock is removed (needs Microsoft.Authorization/locks permissions).
```

| Lock type | Allowed | Blocked |
|---|---|---|
| **CanNotDelete** | Read, modify | Delete |
| **ReadOnly** | Read | Modify **and** delete |

⭐ **Locks apply to everyone regardless of RBAC role** — an Owner must **remove the lock first** to delete. **ReadOnly** can cause surprising side effects (some operations that look like "read" actually write). Managing locks needs the **Owner** or **User Access Administrator** role (lock permissions).

---

## 70.3 UI / CLI Steps — Move & Lock

```
── Move ──
📍 Resource (or RG) → "Move" → "Move to another resource group" / "...subscription"
   → select destination → validate → confirm (acknowledge IDs will change)

── Lock ──
📍 Resource / RG / Subscription → "Locks" → "+ Add"
   Lock name, Lock type = Delete (CanNotDelete) or Read-only → OK
```

```bash
# Move resources to another resource group
az resource move --destination-group new-rg \
  --ids "/subscriptions/<sub>/resourceGroups/old-rg/providers/Microsoft.Compute/virtualMachines/web-vm"

# Create a delete lock on a resource group
az lock create --name protect-prod --lock-type CanNotDelete \
  --resource-group prod-rg

# List / delete locks
az lock list -g prod-rg -o table
az lock delete --name protect-prod -g prod-rg
```

---

## 70.4 Integration with Other Azure Services

| Service | Role |
|---|---|
| **RBAC** | Locks override RBAC; managing locks needs Owner/User Access Administrator |
| **Azure Policy** | Can enforce lock presence / govern configuration |
| **Cost/billing** | Moving across subscriptions shifts billing ownership |
| **Resource Manager** | Executes validated move operations |

---

## 70.5 Real-World Scenario — Reorganize Safely, Protect Production

```
A company restructures resources and must protect critical production assets.
   1. Validate and move dev resources from a legacy RG into a new, properly named RG.
   2. Move a workload to another subscription to align billing with the owning department
      (acknowledging resource IDs change and updating any scripts referencing old IDs).
   3. Apply a CanNotDelete lock on the production resource group so no one — not even an
      Owner — can accidentally delete production resources.
   4. Apply ReadOnly to a stable, audited resource that must not change.
   5. To perform a legitimate deletion later, an admin removes the lock first, deletes, done.
Result: a cleaner structure, correct billing ownership, and production safeguarded against
accidental deletion.
```

---

## 70.6 Benefits

- **Reorganization** — move resources between RGs/subscriptions
- **Billing alignment** — shift ownership to the right subscription
- **Accident prevention** — CanNotDelete guards critical resources
- **Change freeze** — ReadOnly prevents modification
- **Override RBAC** — protection independent of role assignments

---

## 70.7 Common Use Cases

- Reorganizing resources into correctly structured resource groups
- Transferring workloads/billing to another subscription
- Protecting production resource groups from deletion (CanNotDelete)
- Freezing configuration of audited/stable resources (ReadOnly)

---

## 70.8 Exam Q&A

**Q: What are the two types of resource locks and what does each prevent?**
> **CanNotDelete** (Delete lock) allows reading and modifying a resource but **prevents deletion**; **ReadOnly** allows **reading only**, preventing both **modification and deletion**. They protect critical resources from accidental or unauthorized destructive changes, and apply at the subscription, resource group, or individual resource level (inherited by children).

**Q: An Owner tries to delete a resource but can't. What's likely in place, and how do they proceed?**
> A **CanNotDelete (or ReadOnly) lock** — **locks override RBAC**, so even an **Owner** cannot delete a locked resource. To proceed, they must first **remove the lock** (requires permissions on `Microsoft.Authorization/locks`, i.e., Owner or User Access Administrator), then perform the deletion. This deliberate two-step is what protects critical resources from accidental deletion.

**Q: What should you know before moving resources between subscriptions or resource groups?**
> Not **all resource types support moving**; some must **move together with dependencies**; the resources are briefly **locked (read-only)** during the move; and **resource IDs change** afterward (so update scripts/automation referencing old IDs). Always run a **validate move** first to catch unsupported resources. Some moves also have region/constraint requirements, so planning avoids mid-move failures.

**Q: Why can ReadOnly locks sometimes cause unexpected failures?**
> Because some operations that appear to be simple reads actually perform **write operations under the hood** (e.g., listing storage keys, certain management actions), which a **ReadOnly** lock blocks. This can break tooling or portal features unexpectedly. For that reason, **CanNotDelete** is often preferred when the goal is just preventing deletion, reserving ReadOnly for true change-freeze needs.

---

## 70.9 Summary

Azure lets you **move resources** between **resource groups** and **subscriptions** (for reorganization or billing ownership) — but **not all types are movable**, dependencies may need to move together, resources are briefly **read-only** during the move, and **resource IDs change** afterward, so **validate first** and update automation. **Resource locks** protect critical resources: **CanNotDelete** (read/modify but no delete) and **ReadOnly** (read only — no modify or delete). Locks apply at subscription/RG/resource scope (inherited downward) and **override RBAC** — even an **Owner** must **remove the lock first** to delete. Prefer **CanNotDelete** when you only need to prevent deletion, since **ReadOnly** can block operations that secretly write.

[↑ Back to top](#-table-of-contents)

---
---

# 71. 🗂️ Management Groups
> 🟠 MEDIUM
> 📚 Course lectures: 275 (Management Groups), 276 (A quick look into Management Groups)

---

## 71.1 What Problem Does This Solve?

Enterprises often have **many subscriptions** (per department, environment, or team), and applying governance — RBAC roles and Azure Policies — to each one individually is tedious and error-prone. **Management Groups** sit **above subscriptions** in a hierarchy, letting you apply **access and policy once at a group level** and have it **inherited by all subscriptions beneath**. They bring enterprise-scale governance to a multi-subscription estate.

Think of management groups like **regional headquarters above individual store branches**. Instead of issuing the same rulebook to each store (subscription) separately, corporate sets policy at the regional HQ (management group), and every store under it automatically follows — change it once at HQ and it cascades everywhere.

> 💡 **If you know AWS:** Management Groups are Azure's **AWS Organizations + Organizational Units (OUs)**. Just as OUs let you apply **Service Control Policies** and consolidated governance across many AWS accounts, management groups let you apply **Azure Policy and RBAC** across many **subscriptions**, with **inheritance** down the tree and a single **root** group at the top.

---

## 71.2 The Governance Hierarchy (Flow Diagram)

```
                    ┌──────────────── Root Management Group ────────────────┐
                    │        (one per tenant; all MGs/subs live under it)     │
                    └───────────────────────┬────────────────────────────────┘
                        ┌───────────────────┼───────────────────┐
                        ▼                   ▼                   ▼
                  MG: Corp             MG: Sandbox          MG: Production
                  (policy: allowed      (policy: cost         (policy: strict
                   regions, tags)        limits, auto-expire)  security baseline)
                   │        │                                   │       │
                   ▼        ▼                                   ▼       ▼
                Sub: HR   Sub: Finance                     Sub: Prod-A  Sub: Prod-B

   SCOPE HIERARCHY (top → bottom), access + policy INHERIT downward:
      Management Group → Subscription → Resource Group → Resource

   Assign an RBAC role or Azure Policy at "Production" MG → applies to Prod-A AND Prod-B
   and everything inside them.
```

| Aspect | Detail |
|---|---|
| **Position** | Above subscriptions (top of the scope hierarchy) |
| **Root MG** | One per tenant; everything lives under it |
| **Nesting** | Up to 6 levels deep (excluding root/subscription) |
| **What you assign** | **Azure Policy** and **Azure RBAC** (inherited down) |
| **Membership** | A subscription belongs to **one** management group |

⭐ Assigning **policy/RBAC at a management group** is the scalable way to govern **many subscriptions at once** — the assignment **inherits** to every subscription, RG, and resource beneath. The **root** MG is ideal for organization-wide, non-negotiable guardrails.

---

## 71.3 UI / CLI Steps — Create & Organize

```
📍 portal.azure.com → "Management groups" → "+ Create" (e.g., "Production")
   (enable Management Groups first if prompted — needs tenant-level setup by Global Admin)
    ↓
📍 Build the hierarchy: create child MGs; "Add subscription" to move subs under an MG
    ↓
📍 Assign governance AT the MG:
   MG → "Access control (IAM)" → assign RBAC role (inherited by all subs)
   MG → "Policies" / Azure Policy → assign policy/initiative at this MG scope
```

```bash
az account management-group create --name Production --display-name "Production"
az account management-group subscription add --name Production --subscription <sub-id>

# Assign a policy at the management-group scope
az policy assignment create --name allowed-regions \
  --scope "/providers/Microsoft.Management/managementGroups/Production" \
  --policy <policy-definition-id>
```

---

## 71.4 Integration with Other Azure Services

| Service | Role with Management Groups |
|---|---|
| **Azure Policy** | Assign policies/initiatives once, inherit to all subs |
| **Azure RBAC** | Assign roles at MG scope for broad access |
| **Subscriptions** | Organized beneath MGs for governance |
| **Azure Landing Zones / Blueprints** | Use MG hierarchy as the governance backbone |
| **Cost Management** | Aggregate/organize spend across grouped subscriptions |

---

## 71.5 Real-World Scenario — Enterprise Governance at Scale

```
An enterprise has 20 subscriptions and must enforce consistent governance.
   1. Build an MG hierarchy: Root → Corp, Production, Sandbox (with child MGs as needed).
   2. At the ROOT MG: assign org-wide guardrails (allowed regions, required CostCenter tag,
      deny public IPs on certain resources).
   3. At the Production MG: assign a stricter security baseline initiative; it inherits to
      all production subscriptions automatically.
   4. At the Sandbox MG: allow cheap SKUs only and auto-expiry policies.
   5. Assign the security team Reader at the Root MG so they can audit everything.
   6. New subscriptions are placed under the right MG and instantly inherit all governance.
Result: policy and access defined once per group govern every subscription consistently,
scaling effortlessly as new subscriptions are added.
```

---

## 71.6 Benefits

- **Govern at scale** — apply policy/RBAC once across many subscriptions
- **Inheritance** — assignments cascade down the hierarchy automatically
- **Consistency** — uniform guardrails across the organization
- **Flexible structure** — mirror org/environment with nested groups
- **Instant onboarding** — new subscriptions inherit governance by placement

---

## 71.7 Common Use Cases

- Applying organization-wide policy/RBAC across all subscriptions
- Separating governance by environment (Prod vs Sandbox) or business unit
- Enterprise landing zones / cloud adoption frameworks
- Enforcing non-negotiable guardrails at the root management group

---

## 71.8 Exam Q&A

**Q: What are management groups and where do they sit in the Azure hierarchy?**
> Management groups are containers that sit **above subscriptions**, at the **top of the scope hierarchy**: **Management Group → Subscription → Resource Group → Resource**. They let you organize **multiple subscriptions** and apply **Azure Policy** and **RBAC** at the group level, which then **inherit** down to all subscriptions and resources beneath — enabling governance across the whole organization from one place.

**Q: Why assign a policy or role at a management group rather than per subscription?**
> Because the assignment is **inherited by every subscription (and its resources) under that management group**, so you **define governance once** instead of repeating it across many subscriptions. This ensures **consistency**, reduces error, and means **new subscriptions automatically inherit** the governance simply by being placed under the right management group — the scalable approach for enterprises.

**Q: How many management groups can a subscription belong to, and what is the root management group?**
> A subscription belongs to **exactly one** management group. The **root management group** is a single, automatically created group at the **top of the tenant** under which **all** management groups and subscriptions ultimately sit. It's the ideal place for **organization-wide, non-negotiable guardrails**, since everything inherits from it — but changes there affect the entire tenant, so they're made carefully.

**Q: What can and cannot be assigned at the management group scope?**
> You **can** assign **Azure Policy/initiatives** and **Azure RBAC roles** at the management group scope (both inherit downward). You **cannot** place individual **resources** directly in a management group — only **subscriptions** (and child management groups) belong there; resources live in resource groups within subscriptions. Governance flows down, but the resource containment model stays subscription → RG → resource.

---

## 71.9 Summary

**Management Groups** sit **above subscriptions** at the top of the scope hierarchy (**Management Group → Subscription → Resource Group → Resource**), letting you apply **Azure Policy** and **RBAC** **once** and have it **inherited** by all subscriptions and resources beneath. A tenant has one **root** management group (ideal for org-wide guardrails), groups can nest up to **6 levels**, and each subscription belongs to **exactly one** management group. They deliver **consistent, scalable enterprise governance** — new subscriptions inherit policy/access automatically by placement — and are the backbone of **landing zones**. They're Azure's equivalent of **AWS Organizations + OUs**.

[↑ Back to top](#-table-of-contents)

---
---

# 72. 📋 Azure Policy
> 🔴 FULL
> 📚 Course lectures: 277 (Using the Azure Policy Service), 278 (Azure Policy - Not Allowed Resource types)

---

## 72.1 What Problem Does This Solve?

RBAC controls **who can do what**, but it doesn't stop an authorized user from doing something **non-compliant** — like deploying a resource in a forbidden region, creating an oversized VM, or leaving resources untagged. **Azure Policy** enforces **organizational rules and standards** on resources: it can **audit**, **deny**, or **remediate** configurations, ensuring everything deployed meets your governance, security, and cost requirements — automatically and at scale.

Think of Azure Policy like **building codes enforced by an inspector**. RBAC decides who's allowed on the construction site (permissions), but building codes (policies) dictate **what you're allowed to build** — no structures over a certain height, must use approved materials, must have smoke detectors. The inspector either **blocks** non-compliant work (deny), **flags** it (audit), or **fixes** it (remediate).

> 💡 **If you know AWS:** Azure Policy ≈ **AWS Config rules + Service Control Policies (SCPs) + some AWS Organizations guardrails** combined. Like **SCPs**, it can **deny** actions org-wide (via management groups); like **AWS Config**, it continuously **evaluates compliance** and can **remediate**. The distinction from RBAC (permissions) vs Policy (resource compliance) mirrors IAM policies vs Config/SCP guardrails.

---

## 72.2 How Azure Policy Works (Flow Diagram)

```
POLICY DEFINITION (a rule, in JSON):  IF <condition> THEN <effect>
   e.g., IF resource location NOT IN [centralindia, eastus]  THEN  Deny

   │ group many definitions into an →  INITIATIVE (policy set), e.g., "Security Baseline"
   ▼
ASSIGN the definition/initiative to a SCOPE:
   Management Group / Subscription / Resource Group   (inherits downward)
   │
   ▼
EVALUATION:
   • New/updated resources → evaluated at deploy time (Deny can BLOCK creation)
   • Existing resources    → evaluated for COMPLIANCE (shown in the dashboard)
   • Remediation tasks      → fix non-compliant existing resources (DeployIfNotExists/Modify)

COMMON EFFECTS:
   Deny · Audit · Append · Modify · DeployIfNotExists · AuditIfNotExists · Disabled
```

| Effect | What it does |
|---|---|
| **Deny** | Blocks creation/update of non-compliant resources |
| **Audit** | Allows, but flags non-compliant resources in reports |
| **Append** | Adds fields (e.g., a tag) during creation |
| **Modify** | Adds/updates properties/tags (supports remediation) |
| **DeployIfNotExists** | Deploys a related resource if missing (remediation) |
| **AuditIfNotExists** | Flags if a related resource is missing |
| **Disabled** | Turns the policy off |

⭐ Policy governs **what** resources can exist/how they're configured (compliance); **RBAC** governs **who** can act (permissions) — they're **complementary**. **Initiatives** bundle many policies (e.g., an entire security baseline) for one assignment. Assign at a **management group** to govern the whole org.

---

## 72.3 Policy vs RBAC (Key Distinction)

```
RBAC:          "Alice (Contributor) CAN create VMs."         (WHO + permission)
AZURE POLICY:  "...but any VM must be in India, Standard_B/D SKUs, and tagged."  (WHAT/compliance)

Both apply together: Alice is allowed to create a VM (RBAC), but Policy will DENY it if it
breaks the rules (wrong region/SKU/missing tag). Neither replaces the other.
```

---

## 72.4 UI / CLI Steps — Assign a Policy

```
📍 Search "Policy" → "Definitions" → find a built-in (e.g., "Allowed locations" or
   "Not allowed resource types") — or "+ Policy definition" for custom
    ↓
📍 "Assignments" → "Assign policy"
   ┌──────────────────────────────────────────────┐
   │ Scope:      subscription / RG / management group│
   │ Policy def: Allowed locations                   │
   │ Parameters: allowed = [Central India, East US]  │
   │ Effect:     Deny (from the definition)          │
   │ Remediation: managed identity (for Modify/DINE) │
   └──────────────────────────────────────────────┘
   Create
    ↓
📍 "Compliance" → see compliant/non-compliant resources; create remediation tasks
```

```bash
# Assign the built-in "Allowed locations" policy at a resource group
az policy assignment create --name allowed-locations \
  --scope "/subscriptions/<sub>/resourceGroups/prod-rg" \
  --policy "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c" \
  --params '{ "listOfAllowedLocations": { "value": ["centralindia","eastus"] } }'

# Check compliance state
az policy state summarize --resource-group prod-rg
```

---

## 72.5 Integration with Other Azure Services

| Service | Role with Azure Policy |
|---|---|
| **Management groups** | Assign policies org-wide (inherited to all subs) |
| **RBAC** | Complementary: permissions (RBAC) vs compliance (Policy) |
| **Tags** | Require/append/inherit tags via policy |
| **Managed identity** | Executes remediation (Modify/DeployIfNotExists) |
| **Microsoft Defender for Cloud** | Security recommendations backed by policy initiatives |
| **Azure Monitor / compliance dashboard** | Report and alert on compliance state |

---

## 72.6 Real-World Scenario — Enforcing Standards Automatically

```
A company must guarantee resources meet security, cost, and data-residency rules.
   1. Assign at the Production MG an INITIATIVE bundling:
        • Allowed locations = India only (data residency) — Deny
        • Allowed VM SKUs = approved list (cost control) — Deny
        • Not allowed resource types = e.g., no classic/expensive services — Deny
        • Require a CostCenter tag — Deny; inherit Environment tag from RG — Modify
        • Ensure diagnostic logs are enabled — DeployIfNotExists (auto-remediate)
   2. New non-compliant deployments are BLOCKED at creation (Deny).
   3. Existing resources show in the Compliance dashboard; remediation tasks fix the
      fixable ones (e.g., enable diagnostics) via a managed identity.
   4. Everything inherits to all production subscriptions automatically.
Result: standards are enforced automatically at scale — compliant by construction, with
visibility and auto-remediation for the rest.
```

---

## 72.7 Benefits

- **Enforce standards** — deny non-compliant deployments automatically
- **Compliance visibility** — dashboard of compliant/non-compliant resources
- **Auto-remediation** — fix existing resources (Modify/DeployIfNotExists)
- **Scale** — assign initiatives at management groups across the org
- **Cost & security control** — restrict SKUs, regions, resource types; require tags
- **Complements RBAC** — governs configuration, not just permissions

---

## 72.8 Common Use Cases

- Restricting resource locations (data residency) and allowed SKUs (cost)
- Blocking disallowed resource types
- Requiring/inheriting tags for governance and cost reporting
- Enforcing security baselines (diagnostics, encryption, endpoints)
- Continuous compliance reporting and auto-remediation

---

## 72.9 Exam Q&A

**Q: What is the difference between Azure Policy and Azure RBAC?**
> **RBAC** controls **who** can perform actions (permissions) on resources; **Azure Policy** controls **what** resources can be created and **how they must be configured** (compliance). They're **complementary**: RBAC might allow Alice to create a VM, but Policy can **deny** it if it violates rules (wrong region/SKU/missing tag). Neither replaces the other — you need both for complete governance.

**Q: Name three common Azure Policy effects and what each does.**
> **Deny** blocks creation/update of non-compliant resources; **Audit** permits them but **flags** non-compliance in reports; and **DeployIfNotExists** **remediates** by deploying a required related resource if it's missing (e.g., enabling diagnostics). Others include **Append**/**Modify** (add fields/tags), **AuditIfNotExists**, and **Disabled**. The effect determines whether a policy blocks, reports, or fixes.

**Q: What is a policy initiative, and why use one?**
> An **initiative** (policy set) is a **group of policy definitions** bundled and assigned together — for example, an entire **security baseline** of dozens of rules. Using an initiative lets you **assign and track many related policies as a unit**, simplifying management and compliance reporting instead of assigning each policy individually. Microsoft provides built-in initiatives (e.g., for regulatory standards).

**Q: How do you enforce a policy across all subscriptions in an organization?**
> **Assign the policy or initiative at a management group** (ideally the root or an environment-level MG). Because governance **inherits down the hierarchy**, the policy applies to **all subscriptions, resource groups, and resources** beneath — and **new subscriptions inherit it automatically** by placement. This is the scalable way to enforce org-wide standards from a single assignment.

**Q: Policy effects like DeployIfNotExists and Modify need something extra to remediate existing resources. What, and why?**
> They require a **managed identity** (assigned to the policy assignment) with appropriate **RBAC permissions**, because **remediation tasks actually create or change resources** on your behalf — which needs an identity authorized to do so. Without the managed identity and its role, the policy can **evaluate/flag** compliance but can't perform the **remediation** (deploy the missing resource or modify properties).

**Q: You assigned a Deny policy for allowed locations, but existing resources in other regions still exist. Is that expected?**
> **Yes.** A **Deny** effect blocks **new or updated** non-compliant deployments; it does **not retroactively delete** existing non-compliant resources. Those existing resources are marked **non-compliant** in the compliance dashboard, and you'd address them separately (move/recreate, or use remediation for fixable properties). Deny prevents future violations; it doesn't automatically remove past ones.

---

## 72.10 Summary

**Azure Policy** enforces **organizational rules on resources** — auditing, denying, or remediating configurations to meet governance, security, cost, and compliance requirements. A **policy definition** (IF condition THEN **effect**) is **assigned to a scope** (management group/subscription/RG) and **inherits downward**; **initiatives** bundle many definitions (e.g., a security baseline). Key **effects**: **Deny** (block), **Audit** (flag), **Append/Modify** (add fields/tags), and **DeployIfNotExists** (remediate — needs a **managed identity**). Policy governs **what/how** (compliance) and **complements RBAC**, which governs **who** (permissions). **Deny blocks new** violations but doesn't delete existing non-compliant resources (they show as non-compliant). Assign at a **management group** to govern the whole org. It's Azure's blend of **AWS Config rules + SCPs**. This completes the **Identity & Governance** section.

[↑ Back to top](#-table-of-contents)

---
---

# 73. 📊 Azure Monitor & Alerts
> 🔴 FULL
> 📚 Course lectures: 280 (Preparing infrastructure), 281–282 (What is Azure Monitor), 283 (Alerts), 284 (Alert - Activity Log), 285 (Suppressing alerts)

---

## 73.1 What Problem Does This Solve?

You can't manage what you can't see. Resources fail, slow down, or behave unexpectedly, and you need to **know when** — ideally **before** users complain. **Azure Monitor** is Azure's unified observability platform: it **collects metrics and logs** from every resource, lets you **visualize** them, and **alerts** you (email, SMS, webhook, automation) when something crosses a threshold or an event occurs. It's the foundation of operational awareness and incident response.

Think of Azure Monitor like **the dashboard + warning lights in a car**. Gauges show real-time readings (metrics: speed, temperature), the trip computer logs history (logs), and warning lights fire when something needs attention (alerts: low oil, engine hot). Without it you'd only discover a problem when the car breaks down on the highway.

> 💡 **If you know AWS:** Azure Monitor ≈ **Amazon CloudWatch** (metrics, logs, alarms/alerts, dashboards). **Metrics ≈ CloudWatch Metrics**, **Alerts ≈ CloudWatch Alarms**, **Action Groups ≈ SNS topics/actions**, and the **Activity Log ≈ AWS CloudTrail** (control-plane audit of who did what). Log Analytics (next topic) ≈ CloudWatch Logs Insights.

---

## 73.2 Azure Monitor Data & Alerting (Flow Diagram)

```
                 DATA SOURCES → AZURE MONITOR → ACTIONS
   ┌──────────────┐
   │ METRICS       │ numeric, near-real-time (CPU %, disk IOPS, latency) — platform/default
   │ LOGS          │ rich, queryable events/records → Log Analytics (KQL)
   │ ACTIVITY LOG  │ control-plane audit: who created/changed/deleted resources
   │ APP telemetry │ Application Insights (app performance)
   └──────┬────────┘
          ▼
     ALERT RULE:  (signal: metric OR log OR activity-log event)
                  + condition (e.g., CPU > 80% for 5 min)
                  + severity (0 critical … 4 verbose)
          │ fires →
          ▼
     ACTION GROUP:  Email / SMS / Push / Voice · Webhook · Azure Function ·
                    Logic App · Automation Runbook · ITSM
          │
          └─ Alert processing rules → SUPPRESS alerts (e.g., during maintenance)
```

| Component | Purpose |
|---|---|
| **Metrics** | Numeric, time-series, near-real-time performance data |
| **Logs** | Detailed records queried with **KQL** (via Log Analytics) |
| **Activity Log** | Audit of subscription-level (control-plane) operations |
| **Alert rule** | Signal + condition + severity that triggers on breach/event |
| **Action group** | The set of notifications/automations an alert triggers |
| **Alert processing rule** | Suppress/route alerts (e.g., maintenance windows) |

⭐ Alerts have three signal types: **metric** (threshold on numeric data), **log** (a KQL query result), and **activity log** (a control-plane event, e.g., a VM was deleted). **Action groups** are reusable across many alerts, and **suppression** prevents alert storms during planned maintenance.

---

## 73.3 Metric vs Log vs Activity Log Alerts

```
METRIC alert        → "CPU > 80% for 5 minutes"         (fast, numeric, cheap)
LOG alert           → "KQL: >10 failed logins in 5 min"  (rich, flexible, queries logs)
ACTIVITY LOG alert  → "A resource of type X was deleted" / service health event
                       (governance/audit + Azure service health notifications)
```

---

## 73.4 UI / CLI Steps — Create an Alert

```
📍 Monitor → "Alerts" → "+ Create" → "Alert rule"
   ┌──────────────────────────────────────────────┐
   │ Scope:     select resource (e.g., a VM)         │
   │ Condition: signal = Percentage CPU,             │
   │            threshold > 80, over 5 min            │
   │ Actions:   action group (email ops@, SMS, etc.) │
   │ Details:   severity = 2 (Warning), name         │
   └──────────────────────────────────────────────┘
   Create
    ↓
📍 Activity Log alert: Monitor → Alerts → Create → signal type "Activity Log" →
   e.g., "Delete Virtual Machine" → action group
📍 Suppress: Monitor → Alerts → "Alert processing rules" → suppress during maintenance window
```

```bash
# Action group
az monitor action-group create -g rg -n ops-ag --short-name ops \
  --action email ops ops@contoso.com

# Metric alert: CPU > 80%
az monitor metrics alert create -n high-cpu -g rg \
  --scopes "/subscriptions/<sub>/resourceGroups/rg/providers/Microsoft.Compute/virtualMachines/web-vm" \
  --condition "avg Percentage CPU > 80" --window-size 5m --evaluation-frequency 1m \
  --action ops-ag --severity 2
```

---

## 73.5 Integration with Other Azure Services

| Service | Role with Azure Monitor |
|---|---|
| **Log Analytics** | Stores/queries log data with KQL (next topic) |
| **Application Insights** | App performance monitoring feeds Monitor |
| **Action groups** | Deliver notifications/automation on alerts |
| **Logic Apps / Functions / Automation** | Automated responses to alerts |
| **Service Health** | Activity-log-based Azure outage/maintenance alerts |
| **Autoscale** | Metric-driven scaling of VM Scale Sets/App Service |

---

## 73.6 Real-World Scenario — Proactive Operations

```
An ops team wants to catch problems before users do.
   1. Create an "Ops" action group (email + SMS to on-call + a webhook to Teams).
   2. Metric alerts: CPU > 80% (5 min), available memory < 10%, disk latency high.
   3. Log alert (KQL): more than 20 HTTP 5xx errors in 5 minutes on the web tier.
   4. Activity Log alert: notify if anyone deletes a production resource (governance).
   5. Service Health alert: warn of Azure outages/maintenance in their region.
   6. Alert processing rule suppresses alerts during the Sunday 2 AM maintenance window.
Result: the team is notified proactively, responds faster, and avoids alert noise during
planned work — operational awareness without constant manual checking.
```

---

## 73.7 Benefits

- **Unified observability** — metrics, logs, traces, and audit in one platform
- **Proactive alerting** — know about issues before users do
- **Flexible signals** — metric, log (KQL), and activity-log alerts
- **Reusable actions** — action groups drive notifications and automation
- **Noise control** — suppression/processing rules for maintenance
- **Automation-ready** — trigger Functions/Logic Apps/runbooks on alerts

---

## 73.8 Common Use Cases

- Performance alerts (CPU, memory, disk, latency)
- Error-rate/log-based alerts via KQL
- Governance/audit alerts (resource deletion, policy changes)
- Azure Service Health notifications
- Auto-remediation and incident routing via action groups

---

## 73.9 Exam Q&A

**Q: What are the three signal types for Azure Monitor alerts, and when is each used?**
> **Metric alerts** fire on numeric thresholds (e.g., CPU > 80%) — fast and near-real-time; **Log alerts** run a **KQL query** on log data and fire on its results (e.g., >10 errors in 5 min) — flexible and rich; **Activity Log alerts** fire on **control-plane events** (e.g., a VM was deleted, or an Azure Service Health event). Choose metric for performance, log for complex/log-based conditions, and activity log for governance/service-health.

**Q: What is an action group and why is it useful?**
> An **action group** is a **reusable collection of actions** — email, SMS, push, voice, webhook, Azure Function, Logic App, Automation runbook, ITSM — triggered when an alert fires. It's useful because you define notification/automation targets **once** and reference the same group across **many alerts**, ensuring consistent response and easy maintenance (update recipients in one place).

**Q: What is the difference between the Activity Log and resource logs/metrics?**
> The **Activity Log** records **subscription/control-plane operations** — who created, modified, or deleted resources, and service health events (an audit trail, like CloudTrail). **Metrics** are numeric performance data about a resource, and **resource (diagnostic) logs** are detailed data-plane records emitted by the resource. Activity Log answers "**who did what**"; metrics/logs answer "**how is it performing / what happened inside it**."

**Q: During planned maintenance, alerts flood the team. How do you prevent this?**
> Use an **alert processing rule** to **suppress** alerts for the affected scope during the **maintenance window** (or disable specific alert rules temporarily). This stops the known, expected alerts from firing while work is in progress, avoiding alert fatigue, and automatically resumes normal alerting afterward — far better than ignoring alerts or deleting rules.

**Q: How can alerts trigger automated remediation rather than just notifying people?**
> Configure the alert's **action group** to invoke an **Azure Function, Logic App, or Automation runbook** (or a webhook), which performs the remediation (e.g., restart a service, scale out, clear a queue). This turns monitoring into **self-healing**, responding to conditions automatically. Metric-driven **autoscale** is a related built-in mechanism for scaling based on load.

---

## 73.10 Summary

**Azure Monitor** is Azure's unified observability platform, collecting **metrics** (numeric, near-real-time), **logs** (queried with KQL via Log Analytics), **Activity Log** (control-plane audit — who did what, like CloudTrail), and app telemetry. **Alert rules** combine a **signal** (metric / log / activity-log), a **condition**, and a **severity**, and trigger **action groups** (reusable sets of email/SMS/webhook/Function/Logic App/runbook actions). **Alert processing rules** **suppress** noise during maintenance. Use metric alerts for performance, log alerts for complex conditions, and activity-log alerts for governance/service health — and wire action groups to **automate remediation**. It's Azure's equivalent of **CloudWatch (+ CloudTrail)**.

[↑ Back to top](#-table-of-contents)

---
---

# 74. 🔎 Log Analytics & KQL
> 🔴 FULL
> 📚 Course lectures: 286 (What is a Log Analytics Workspace), 287 (Creating a workspace), 288 (Connecting a VM), 289–290 (Log Analytics Queries), 291 (Alerts), 292 (Collecting IIS logs)

---

## 74.1 What Problem Does This Solve?

Metrics tell you *that* something changed; **logs** tell you *why*. But logs are voluminous and scattered. A **Log Analytics Workspace** is the central store where Azure Monitor keeps **log data** from VMs, resources, and applications, and **KQL (Kusto Query Language)** is the powerful language you use to **search, filter, aggregate, and visualize** that data — to troubleshoot, analyze trends, and drive **log-based alerts**. It's how you turn raw log noise into answers.

Think of a Log Analytics Workspace like **a giant, searchable logbook warehouse**, and KQL like **a skilled librarian with instant search**. Instead of flipping through millions of pages (raw logs), you ask precise questions ("show me all errors from web servers in the last hour, grouped by type") and get instant, organized answers.

> 💡 **If you know AWS:** A Log Analytics Workspace ≈ a **CloudWatch Logs log group / a central logging store**, and **KQL ≈ CloudWatch Logs Insights query language** (or Athena-style querying over logs). Connecting VMs via the agent ≈ installing the **CloudWatch agent** to ship logs. KQL is also the query language behind Microsoft Sentinel (≈ a SIEM like AWS Security Lake/GuardDuty analytics).

---

## 74.2 Workspace, Data Collection & KQL (Flow Diagram)

```
   DATA IN → LOG ANALYTICS WORKSPACE → KQL OUT
   ┌──────────────────────────────┐
   │ VMs (Azure Monitor Agent/AMA) │ performance, Syslog, Windows events, IIS logs
   │ Azure resources (diagnostics) │ platform/resource logs
   │ Activity Log                  │ control-plane audit
   │ Application Insights          │ app telemetry
   └──────────────┬───────────────┘
                  ▼  stored in TABLES (Heartbeat, Perf, Event, Syslog, AzureActivity, W3CIISLog...)
            ┌───────────────────────────────────────────┐
            │  KQL QUERY example:                         │
            │    Perf                                     │
            │    | where ObjectName == "Processor"        │
            │    | where CounterName == "% Processor Time"│
            │    | summarize avg(CounterValue) by Computer│
            │    | order by avg_CounterValue desc         │
            └───────────────────────────────────────────┘
                  ▼
         Results → charts · workbooks · LOG ALERTS · dashboards
```

| Element | Detail |
|---|---|
| **Workspace** | The container/store for log data (has a region, retention, cost) |
| **Data collection** | Via **Azure Monitor Agent (AMA)** + **Data Collection Rules (DCR)** |
| **Tables** | Data organized into schemas (Perf, Event, Syslog, Heartbeat, W3CIISLog…) |
| **KQL** | Query language: `where`, `summarize`, `project`, `join`, `render`, `order by` |
| **Retention** | Configurable (affects cost); archive for long-term |
| **Uses** | Troubleshooting, trend analysis, **log alerts**, dashboards, Sentinel |

⭐ VMs send logs to a workspace only after the **agent + Data Collection Rule** are configured (what to collect: performance counters, Windows events, Syslog, **IIS logs**). KQL is **read-only** and pipeline-based (`|`) — the same language powers **log alerts**, **Workbooks**, and **Sentinel**.

---

## 74.3 Essential KQL Operators

```
   TableName
   | where   <filter>                 (e.g., TimeGenerated > ago(1h), Level == "Error")
   | project <columns>                (select specific columns)
   | summarize <agg> by <group>       (count(), avg(), max() … grouped)
   | order by <col> desc              (sort)
   | top 10 by <col>                  (limit)
   | render timechart                 (visualize)

   ago(1h) / ago(7d)  = relative time    |  join = combine tables
```

---

## 74.4 UI / CLI Steps — Workspace, Connect a VM, Query

```
📍 "Log Analytics workspaces" → "+ Create" (name, region, retention) → Create
    ↓
📍 Connect a VM: VM → "Monitoring" / use a Data Collection Rule (AMA) → associate workspace
   → choose data to collect (Perf counters, Windows Event logs, Syslog, IIS logs)
    ↓
📍 Workspace → "Logs" → write KQL:
     Heartbeat | summarize arg_max(TimeGenerated, *) by Computer   // are VMs reporting?
     Perf | where CounterName == "% Processor Time"
          | summarize avg(CounterValue) by Computer, bin(TimeGenerated, 5m)
          | render timechart
    ↓
📍 Create a LOG ALERT from a query: Logs → "+ New alert rule" → set threshold/frequency
```

```bash
az monitor log-analytics workspace create -g rg -n ops-law --location centralindia

# Run a KQL query against the workspace
az monitor log-analytics query -w <workspace-id> \
  --analytics-query "Heartbeat | summarize count() by Computer" -o table
```

---

## 74.5 Integration with Other Azure Services

| Service | Role with Log Analytics |
|---|---|
| **Azure Monitor** | Workspace is its log store; log alerts run KQL here |
| **VM Insights** | Stores its data in a workspace (next topic) |
| **Microsoft Sentinel** | SIEM built on Log Analytics + KQL |
| **Application Insights** | App telemetry queryable via KQL |
| **Workbooks / Dashboards** | Visualize KQL results |
| **Azure Monitor Agent + DCR** | Collect and route data into the workspace |

---

## 74.6 Real-World Scenario — Troubleshooting with KQL

```
A web app intermittently errors, and the team needs root cause.
   1. VMs are connected to a Log Analytics workspace via AMA + a Data Collection Rule
      that collects performance counters and IIS (W3CIISLog) logs.
   2. KQL query: W3CIISLog | where scStatus >= 500 | summarize count() by csUriStem,
      bin(TimeGenerated, 5m) | render timechart → reveals a spike on one endpoint.
   3. Correlate with Perf: CPU spiking on one VM at the same time.
   4. Create a LOG ALERT: fire if 5xx errors exceed 20 in 5 minutes, notifying the ops
      action group.
   5. Build a Workbook dashboard of error rates and CPU for ongoing visibility.
Result: fast root-cause analysis from centralized logs, plus a standing alert so the issue
is caught automatically next time.
```

---

## 74.7 Benefits

- **Centralized logs** — one queryable store across VMs, resources, apps
- **Powerful querying** — KQL filters, aggregates, joins, visualizes
- **Log-based alerting** — alert on complex conditions, not just metrics
- **Troubleshooting & trends** — root-cause analysis and historical insight
- **Extensible** — foundation for VM Insights, Workbooks, and Sentinel (SIEM)
- **Flexible collection** — choose exactly what each VM sends (DCR)

---

## 74.8 Common Use Cases

- Root-cause troubleshooting across servers/resources
- Collecting and analyzing IIS/Syslog/Windows event logs
- Log-based alerts (error rates, failed logins, custom conditions)
- Building operational dashboards (Workbooks)
- Security analytics via Microsoft Sentinel

---

## 74.9 Exam Q&A

**Q: What is a Log Analytics Workspace and what is KQL?**
> A **Log Analytics Workspace** is the **centralized store** where Azure Monitor keeps **log data** (from VMs, resources, apps, Activity Log), organized into **tables**. **KQL (Kusto Query Language)** is the **read-only, pipeline-based query language** used to **search, filter, aggregate, and visualize** that data (operators like `where`, `summarize`, `project`, `render`). Together they enable troubleshooting, analysis, and log-based alerting.

**Q: What must be configured for an Azure VM to send logs to a workspace?**
> The VM needs the **Azure Monitor Agent (AMA)** and an associated **Data Collection Rule (DCR)** that specifies **what to collect** (performance counters, Windows event logs, Syslog, IIS logs) and routes it to the target **workspace**. Without the agent and DCR, the VM's guest-level data won't appear in the workspace — only platform metrics/activity log are available by default.

**Q: Write a KQL query to find the average CPU per computer over the last hour.**
> `Perf | where TimeGenerated > ago(1h) | where CounterName == "% Processor Time" | summarize avg(CounterValue) by Computer | order by avg_CounterValue desc`. This filters the **Perf** table to the last hour and the CPU counter, **aggregates** the average per computer, and **sorts** descending. It illustrates KQL's pipeline model: each `|` passes results to the next operator.

**Q: How do log alerts differ from metric alerts, and what powers them?**
> **Log alerts** run a **KQL query** against the workspace on a schedule and fire based on its **results** (e.g., count of errors exceeding a threshold), enabling **complex, log-based conditions** across multiple data types. **Metric alerts** only evaluate a single numeric metric against a threshold in near-real-time. Log alerts are more flexible but evaluate on a frequency, whereas metric alerts are faster and cheaper.

**Q: What else is built on Log Analytics and KQL?**
> **VM Insights** (stores its performance/map data in a workspace), **Workbooks/dashboards** (visualize KQL results), **Application Insights** (app telemetry queryable via KQL), and **Microsoft Sentinel** — Azure's **SIEM/SOAR** — which uses Log Analytics as its data lake and KQL for threat detection/hunting. Mastering KQL therefore unlocks troubleshooting, monitoring, and security analytics alike.

---

## 74.10 Summary

A **Log Analytics Workspace** is Azure Monitor's central **log store**, organizing data into **tables** (Perf, Event, Syslog, Heartbeat, W3CIISLog…), and **KQL (Kusto Query Language)** is the pipeline-based (`|`) language to **filter (`where`), select (`project`), aggregate (`summarize`), sort (`order by`), and visualize (`render`)** it. VMs feed the workspace via the **Azure Monitor Agent + Data Collection Rules** (choosing performance counters, events, Syslog, **IIS logs**). KQL powers **troubleshooting**, **trend analysis**, **log alerts** (complex conditions metric alerts can't express), **Workbooks**, and **Microsoft Sentinel** (SIEM). It's Azure's equivalent of **CloudWatch Logs + Logs Insights**.

[↑ Back to top](#-table-of-contents)

---
---

# 75. 🗺️ Azure VM Insights
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 293 (Azure VM Insights), 294 (Azure Monitor cleanup)

---

## 75.1 What Problem Does This Solve?

Basic VM metrics (CPU, disk) don't show what's happening **inside** the guest OS or how VMs **connect** to each other. **VM Insights** is a pre-built Azure Monitor feature that gives **deep performance monitoring** (CPU, memory, disk, network from inside the OS) plus an interactive **dependency map** showing processes and connections between VMs — all without writing KQL. It's the quick, visual way to understand VM health and relationships.

Think of VM Insights like **a health monitor + relationship chart for your servers**. Instead of reading raw vital signs yourself (KQL queries), you get a ready-made dashboard of each server's vitals and a live diagram of who's talking to whom — like a fitness tracker that also shows your social connections.

> 💡 **If you know AWS:** VM Insights ≈ **CloudWatch's detailed/enhanced EC2 monitoring + the CloudWatch agent for in-guest metrics**, combined with a **dependency/service map** (comparable to AWS's application/service maps). It's the curated, visual layer over the raw metrics/logs you'd otherwise query yourself.

---

## 75.2 What VM Insights Provides (Flow Diagram)

```
   Enable VM Insights on a VM / VM Scale Set
        │ installs Azure Monitor Agent + (Dependency agent for the map)
        │ stores data in a Log Analytics WORKSPACE
        ▼
   ┌──────────────────────────────────────────────────────────┐
   │ PERFORMANCE view  → CPU, available memory, logical disk     │
   │                     space/IOPS, network — from INSIDE the OS │
   │ MAP view          → processes running + inbound/outbound     │
   │                     connections between VMs & external deps   │
   │ Health (where available) → guest health state                │
   └──────────────────────────────────────────────────────────┘
        │
        └─ Pre-built charts & a dependency map — no KQL required
           (underlying data is still queryable via KQL if desired)
```

| Feature | What it shows |
|---|---|
| **Performance** | In-guest CPU, memory, disk (space/IOPS/latency), network |
| **Map** | Processes and network connections between VMs and dependencies |
| **Requires** | Azure Monitor Agent (+ Dependency agent for the map) + a workspace |
| **Scope** | Single VM, VM Scale Sets, or at scale across subscriptions |

⚠️ VM Insights **requires a Log Analytics workspace** and the **agents**, which means **cost** (data ingestion/retention) — hence the "Azure Monitor cleanup" lecture: disable/clean up to avoid ongoing charges when not needed.

---

## 75.3 UI Steps — Enable & Explore

```
📍 VM → "Insights" (under Monitoring) → "Enable"
   → select/create a Log Analytics workspace → agents are deployed
    ↓
📍 Explore tabs:
   • "Performance" → in-guest CPU/memory/disk/network charts
   • "Map" → interactive diagram of processes + connections between VMs
    ↓
📍 At scale: Monitor → "Virtual Machines" (Insights) → view all monitored VMs together
📍 Cleanup: disable Insights / remove the DCR + agents / reduce retention to control cost
```

---

## 75.4 Integration with Other Azure Services

| Service | Role with VM Insights |
|---|---|
| **Log Analytics** | Stores the performance and map data |
| **Azure Monitor Agent / Dependency agent** | Collect in-guest metrics and connection data |
| **Alerts** | Alert on VM Insights performance data |
| **Workbooks** | VM Insights uses prebuilt workbooks; extend with custom ones |

---

## 75.5 Real-World Scenario — Understanding a Slow Application

```
A multi-VM application is slow and the team doesn't know which tier is the bottleneck.
   1. Enable VM Insights across all the app's VMs (pointing to a shared workspace).
   2. The Map view reveals the web VMs all connect to one database VM — and that DB VM's
      Performance view shows memory pressure and high disk latency.
   3. The dependency map also surfaces an unexpected connection to a deprecated service.
   4. They resize the DB VM (memory-optimized) and remove the stray dependency.
   5. Afterward, they run "Azure Monitor cleanup" on test VMs no longer needed to cut costs.
Result: visual, KQL-free diagnosis pinpointed the bottleneck and a hidden dependency fast.
```

---

## 75.6 Benefits

- **Deep in-guest metrics** — CPU, memory, disk, network from the OS
- **Dependency map** — see processes and VM-to-VM connections visually
- **No KQL required** — prebuilt charts and maps out of the box
- **At-scale view** — monitor many VMs together
- **Troubleshooting** — quickly spot bottlenecks and hidden dependencies

---

## 75.7 Common Use Cases

- Diagnosing VM performance bottlenecks (memory/disk/network)
- Visualizing application/VM dependencies and connections
- Discovering unexpected or legacy connections
- Fleet-wide VM health monitoring

---

## 75.8 Exam Q&A

**Q: What two main capabilities does VM Insights provide?**
> (1) **Performance monitoring** — detailed **in-guest** metrics (CPU, memory, disk space/IOPS/latency, network) beyond the basic host metrics; and (2) the **Map** — an interactive **dependency map** showing **processes** running on each VM and the **network connections** between VMs and their dependencies. Both come as **prebuilt** views, so you get deep insight **without writing KQL**.

**Q: What does VM Insights require to work, and what's the cost implication?**
> It requires the **Azure Monitor Agent** (and the **Dependency agent** for the Map) on the VMs and a **Log Analytics workspace** to store the data. Because it continuously **ingests and retains** performance/connection data, it incurs **cost** (data ingestion and retention), which is why you should **clean up** (disable Insights, remove agents/DCRs, or reduce retention) on VMs that no longer need it.

**Q: How does VM Insights differ from basic Azure Monitor metrics for a VM?**
> Basic metrics are **host-level** (collected from the hypervisor — e.g., host CPU, disk IOPS) and don't see **inside the guest OS**. **VM Insights** deploys an **agent** to collect **in-guest** performance data (like actual **memory** usage and logical disk details) and adds the **dependency Map** — richer, OS-level visibility and relationship mapping that raw platform metrics can't provide.

**Q: When would you use the Map view specifically?**
> When you need to **understand dependencies and communication** between servers — e.g., identifying which VMs a slow app tier talks to, spotting a **bottleneck dependency** (like an overloaded database), or discovering **unexpected/legacy connections**. The Map visualizes processes and inbound/outbound connections, making it ideal for troubleshooting multi-tier applications without manually correlating logs.

---

## 75.9 Summary

**VM Insights** is a prebuilt Azure Monitor feature delivering **deep in-guest performance monitoring** (CPU, memory, disk space/IOPS/latency, network) and an interactive **dependency Map** (processes + VM-to-VM connections) — **without KQL**. It requires the **Azure Monitor Agent** (plus the **Dependency agent** for the Map) and a **Log Analytics workspace**, so it carries **cost** (hence cleanup when unneeded). Use the **Performance** view to spot bottlenecks beyond host-level metrics and the **Map** view to understand dependencies and find hidden connections. It's the curated, visual layer over Azure Monitor's raw data — akin to **enhanced CloudWatch monitoring + a service map**.

[↑ Back to top](#-table-of-contents)

---
---

# 76. 💾 Azure Backup (Recovery Services Vault)
> 🔴 FULL
> 📚 Course lectures: 295 (What is Azure Backup), 296 (Recovery Services Vault), 297 (Enable Backup), 298 (Initial backup), 299 (File Restore), 300 (VM Restore)

---

## 76.1 What Problem Does This Solve?

Data loss — from accidental deletion, corruption, ransomware, or disaster — can be catastrophic. **Azure Backup** is Azure's managed backup service that protects VMs, files, databases, and more, storing recovery points in a **Recovery Services Vault**. It's **agentless for Azure VMs**, policy-driven (schedules + retention), supports **application-consistent** backups, and enables **file-level or full-VM restore** — all without managing backup infrastructure.

Think of Azure Backup like **an automatic, off-site safety-deposit service for your data**. On a schedule it takes secure copies (recovery points), keeps them for as long as your policy says (retention), and lets you retrieve either a single document (file restore) or the entire box (full VM restore) whenever you need — with the vault handling storage, security, and redundancy for you.

> 💡 **If you know AWS:** Azure Backup ≈ **AWS Backup** (centralized, policy-based backups across services). A **Recovery Services Vault** ≈ an **AWS Backup vault**. VM backup ≈ **EBS snapshots / AMI-based backup managed by AWS Backup**. Backup policies (schedule + retention) mirror AWS Backup plans, and **application-consistent** backups parallel VSS-based consistent snapshots.

---

## 76.2 How Azure Backup Works (Flow Diagram)

```
                 RECOVERY SERVICES VAULT  (stores recovery points, redundancy: LRS/ZRS/GRS)
                 ┌───────────────────────────────────────────────────────────┐
                 │  Backup POLICY: schedule (e.g., daily 2 AM) + RETENTION      │
                 │     (daily 30d, weekly 12w, monthly 12m, yearly 10y)         │
                 └───────────────────────────────┬───────────────────────────┘
      Protects:                                   │
        • Azure VMs (AGENTLESS extension)          ▼
        • On-prem/files (MARS agent)         RECOVERY POINTS (snapshots)
        • SQL/SAP in VMs                           │
        • Azure Files                              ▼
                                           RESTORE options:
                                             • Full VM restore (new/replace)
                                             • File/folder restore (mount recovery point)
                                             • Restore disks only
                                           App-consistent (VSS) vs crash-consistent

   Soft delete: deleted backups retained ~14 days (ransomware/accidental-delete protection).
```

| Concept | Detail |
|---|---|
| **Recovery Services Vault** | Container for backup data + recovery points |
| **Backup policy** | Schedule + retention (daily/weekly/monthly/yearly) |
| **Azure VM backup** | **Agentless** (uses a VM extension), app-consistent via VSS |
| **Recovery point** | A restorable snapshot in time |
| **Restore types** | Full VM, file/folder, disks only |
| **Vault redundancy** | LRS / ZRS / GRS (choose at vault creation) |
| **Soft delete** | Retains deleted backups (~14 days) against ransomware |

⭐ For **Azure VMs**, backup is **agentless** (an extension handles it) and can be **application-consistent** (VSS on Windows). **File restore** mounts a recovery point so you can copy individual files without restoring the whole VM. **Vault redundancy** (and soft delete / immutability) are key protection settings.

---

## 76.3 Restore Options

```
FULL VM restore    → create a new VM (or replace the existing) from a recovery point
DISKS only         → restore disks, then attach/build a VM manually (more control)
FILE/FOLDER restore→ mount the recovery point as a drive → copy specific files out
                     (fast for "I deleted one file" — no full restore needed)
```

---

## 76.4 UI / CLI Steps — Protect & Restore a VM

```
📍 "Recovery Services vaults" → "+ Create" (name, region, redundancy) → Create
    ↓
📍 Vault → "Backup" → Datasource = Azure → VM → select the VM(s)
   → choose/define a Backup policy (schedule + retention) → "Enable backup"
    ↓
📍 Run an initial backup now: vault → Backup items → VM → "Backup now"
    ↓
── Restore a file ──
📍 Backup item → "File Recovery" → mount a recovery point → run the script → copy files
── Restore a full VM ──
📍 Backup item → "Restore VM" → pick recovery point → create new VM / replace existing
```

```bash
az backup vault create -g rg -n ops-vault --location centralindia
az backup protection enable-for-vm -g rg --vault-name ops-vault \
  --vm web-vm --policy-name DefaultPolicy
az backup protection backup-now -g rg --vault-name ops-vault \
  --container-name web-vm --item-name web-vm --retain-until 01-01-2027
```

---

## 76.5 Integration with Other Azure Services

| Service | Role with Azure Backup |
|---|---|
| **Recovery Services Vault** | Stores backups/recovery points with chosen redundancy |
| **Azure VMs** | Primary protected workload (agentless) |
| **MARS agent** | Backs up on-prem/VM files & folders (next topic) |
| **Azure Files** | File share backup via the vault |
| **Azure Monitor / Backup Reports** | Monitor jobs and report on backup health |
| **RBAC / Backup roles** | Backup Operator/Contributor for delegated management |

---

## 76.6 Real-World Scenario — Protecting Production VMs

```
A company must protect production VMs with daily backups, long retention, and fast restore.
   1. Create a Recovery Services Vault with GRS redundancy (geo-protection) + soft delete on.
   2. Define a policy: daily backup at 2 AM; retain daily 30d, weekly 12w, monthly 12m,
      yearly 7y (compliance).
   3. Enable backup on all production VMs (agentless) and run an initial backup.
   4. App-consistent backups ensure databases are in a recoverable state.
   5. When a user deletes a critical file, use File Recovery to mount a recovery point and
      copy just that file back — no full restore needed.
   6. After a ransomware incident, restore an entire clean VM from a pre-incident recovery
      point (soft delete protected the backups from tampering).
Result: resilient, policy-driven protection with granular and full restore, geo-redundancy,
and ransomware safeguards.
```

---

## 76.7 Benefits

- **Managed & agentless (VMs)** — no backup infrastructure to run
- **Policy-driven** — automated schedules + flexible retention
- **Granular + full restore** — file-level or entire-VM recovery
- **App-consistent** — recoverable application/database state (VSS)
- **Secure** — soft delete, immutability, vault redundancy (LRS/ZRS/GRS)
- **Centralized** — one vault manages many protected items with reporting

---

## 76.8 Common Use Cases

- Scheduled backup of production Azure VMs
- Long-term/compliance retention of recovery points
- Fast file-level restore after accidental deletion
- Full VM recovery after corruption/ransomware
- Centralized backup management and reporting

---

## 76.9 Exam Q&A

**Q: What is a Recovery Services Vault and what does a backup policy define?**
> A **Recovery Services Vault** is the Azure container that **stores backup data and recovery points**, with a chosen **redundancy** (LRS/ZRS/GRS) and protection features (soft delete, immutability). A **backup policy** defines **when** backups run (**schedule**) and **how long** recovery points are kept (**retention** — daily/weekly/monthly/yearly). Together they automate protection: the vault holds the data, the policy governs frequency and lifespan.

**Q: Is Azure VM backup agent-based or agentless, and what does "application-consistent" mean?**
> Azure **VM backup is agentless** — it uses a **VM extension** rather than requiring you to install/manage a backup agent in the OS. **Application-consistent** backups (via **VSS** on Windows) capture the VM with **applications/databases in a consistent, recoverable state** (pending writes flushed), as opposed to **crash-consistent** (like pulling the plug). App-consistent is preferred for databases to ensure clean recovery.

**Q: A user deleted one important file from a backed-up VM. What's the quickest recovery method?**
> Use **File Recovery (item-level restore)** — mount the relevant **recovery point** as a drive and **copy just that file** back, without restoring the entire VM. This is far faster and less disruptive than a **full VM restore**, which you'd reserve for whole-VM corruption/loss. Azure Backup supports **file/folder, disk-only, and full-VM** restore to match the situation.

**Q: How does Azure Backup protect against ransomware or malicious deletion of backups?**
> With **soft delete**, which **retains deleted backup data for ~14 days** so it can be recovered even if someone (or ransomware) deletes it — attackers can't immediately destroy your recovery points. Additional protections include **immutability** on the vault and requiring **MFA/security PINs** for critical operations. Choosing **GRS** also protects against regional disasters.

**Q: How do you choose vault redundancy, and when does it matter?**
> You select **LRS, ZRS, or GRS** at (or for) the vault: **LRS** keeps backups in one datacenter (cheapest), **ZRS** across zones, and **GRS** replicates to a **secondary region** for **geo-disaster** protection (often with cross-region restore). It matters for your **recovery objectives** — if you must recover backups after a **regional outage**, choose **GRS**; for lower cost where regional DR isn't required, LRS/ZRS suffice. Redundancy is best set **before** protecting items (some changes are restricted afterward).

---

## 76.10 Summary

**Azure Backup** is Azure's managed, policy-driven backup service storing recovery points in a **Recovery Services Vault** (with **LRS/ZRS/GRS** redundancy and **soft delete** for ransomware protection). For **Azure VMs** it's **agentless** (extension-based) and can be **application-consistent** (VSS). A **backup policy** sets the **schedule + retention** (daily/weekly/monthly/yearly). Restore options include **full VM**, **disks only**, and fast **file/folder** recovery (mount a recovery point). It protects VMs, on-prem/files (MARS agent), SQL/SAP-in-VM, and Azure Files, all centrally managed with **Backup Reports**. It's Azure's equivalent of **AWS Backup**. Next: the MARS agent, file-share/web-app backup, Site Recovery, and the newer Backup Vault.

[↑ Back to top](#-table-of-contents)

---
---

# 77. 🖥️ MARS Agent Backup
> 🟠 MEDIUM
> 📚 Course lectures: 301 (Azure Recovery Services Agent), 302 (MARS agent - Taking the Backup), 303 (MARS agent - Recovery), 304 (Azure Backup Reports)

---

## 77.1 What Problem Does This Solve?

Azure VM backup is agentless, but what about **on-premises servers**, or backing up **specific files/folders** rather than a whole machine? The **MARS agent** (Microsoft Azure Recovery Services agent) is a lightweight agent you install on **Windows machines (on-prem or in Azure)** to back up **files, folders, and system state** directly to a **Recovery Services Vault** — giving file-level cloud backup for physical/virtual Windows servers without a full-image backup.

Think of the MARS agent like **a personal cloud-backup app installed on a specific computer** (think a consumer backup tool, but enterprise). You choose which folders to protect and a schedule; it quietly uploads encrypted copies to your Azure vault, and you can restore individual files anytime — from that machine or another.

> 💡 **If you know AWS:** The MARS agent is like installing a **backup agent on an on-prem/EC2 server to send file-level backups to AWS Backup / S3-based backup** (comparable to the AWS Backup agent or Storage Gateway-based file backup). It's the **agent-based, file/folder** counterpart to Azure's agentless VM backup.

---

## 77.2 MARS Agent Essentials (Flow Diagram)

```
   Install MARS agent on a Windows machine (on-prem OR Azure VM)
        │ register it with a Recovery Services Vault (download vault credentials + passphrase)
        ▼
   Configure a backup:
     • SELECT files/folders (and/or System State)   ← granular, not whole-image
     • SCHEDULE (up to 3x/day) + retention
     • ENCRYPTION passphrase (you keep it — needed to restore!) 🔑
        │
        ▼
   Backups upload to the VAULT → recovery points
        │
        ▼
   RESTORE: pick a recovery point → recover files/folders to the SAME or ANOTHER machine
            (install agent + use the vault credentials + passphrase)

   Azure BACKUP REPORTS: cross-vault reporting on jobs, storage, retention, success/failure.
```

| Aspect | MARS agent |
|---|---|
| **Protects** | **Files/folders** + **System State** on Windows (on-prem or Azure VM) |
| **Not** | A full bare-metal/whole-VM image (that's MABS/DPM or Azure VM backup) |
| **Target** | Recovery Services Vault |
| **Schedule** | Up to **3 backups per day** |
| **Encryption** | **Passphrase you control** — required to restore (don't lose it!) |
| **Restore to** | Same machine or an **alternate** machine (with agent + credentials + passphrase) |

⚠️ The **encryption passphrase is yours** — Microsoft can't recover it; **lose it and you can't restore**. MARS does **file/folder + system state**, **not** full application/bare-metal backup (for that you use **MABS/DPM**). **Azure Backup Reports** give cross-vault visibility into all backup jobs.

---

## 77.3 UI / Agent Steps — Back Up & Restore with MARS

```
📍 Recovery Services vault → "Backup" → Where = "On-premises", What = "Files and folders"
   → download the MARS agent installer + vault credentials
    ↓
📍 On the Windows machine: install the agent → "Register Server" using vault credentials
   → set an ENCRYPTION PASSPHRASE (store it safely) 🔑
    ↓
📍 Agent console → "Schedule Backup" → select folders → schedule + retention → finish
📍 "Back Up Now" to run immediately
    ↓
── Restore ──
📍 Agent console → "Recover Data" → this/another server → pick recovery point →
   browse and restore files/folders (passphrase required)
    ↓
📍 Monitor across vaults: Backup center / "Backup Reports" → job status, storage, trends
```

---

## 77.4 Integration with Other Azure Services

| Service | Role with MARS |
|---|---|
| **Recovery Services Vault** | Stores MARS backups and recovery points |
| **Azure Backup Reports** | Cross-vault reporting on jobs/storage/retention |
| **MABS / System Center DPM** | For app-aware/bare-metal backup (beyond MARS) |
| **On-prem Windows servers / Azure VMs** | Hosts running the agent |

---

## 77.5 Real-World Scenario — Protecting On-Prem File Servers

```
A company must back up critical folders on several on-prem Windows file servers to Azure.
   1. Create a Recovery Services Vault; download the MARS agent + vault credentials.
   2. Install and register the agent on each server, setting a strong encryption passphrase
      stored securely in the company password vault.
   3. Configure backups of the shared data folders + System State, 2x/day, retained 90 days.
   4. When a server's disk fails, install the agent on a replacement, register with the vault,
      and restore the folders to the new machine using the passphrase.
   5. Ops uses Azure Backup Reports to confirm nightly success across all servers and spot
      any failures.
Result: off-site, encrypted, file-level protection for on-prem Windows servers with
alternate-machine restore and centralized reporting.
```

---

## 77.6 Benefits

- **On-prem + file-level** — protects Windows files/folders/system state to Azure
- **Granular** — choose exactly what to back up (not a whole image)
- **Off-site & encrypted** — data secured in the vault with your passphrase
- **Alternate-machine restore** — recover to a different server
- **Centralized reporting** — Azure Backup Reports across vaults
- **Lightweight** — simple agent, up to 3 backups/day

---

## 77.7 Common Use Cases

- Backing up on-prem Windows file servers to Azure
- File/folder + System State protection for physical/virtual Windows machines
- Off-site retention of critical folders
- Restoring files to an alternate machine after hardware failure

---

## 77.8 Exam Q&A

**Q: What does the MARS agent back up, and how does it differ from Azure VM backup?**
> The **MARS agent** backs up **files, folders, and System State** on **Windows machines** (on-prem or Azure VMs) directly to a **Recovery Services Vault**. Unlike **Azure VM backup** (which is **agentless** and backs up the **entire VM**), MARS is **agent-based** and **file/folder-level** — ideal for on-prem servers or when you only need specific data protected, not a whole-machine image.

**Q: Why is the MARS encryption passphrase so important?**
> Because backups are **encrypted with a passphrase that only you control** — **Microsoft cannot recover it**. If you **lose the passphrase, you cannot restore** your data. It must be stored securely (e.g., in a password manager/vault), and it's also **required when restoring to an alternate machine**. This design ensures your backup data is private, but it places responsibility for the key entirely on you.

**Q: Can MARS perform a full application-consistent or bare-metal backup?**
> **No** — MARS handles **files/folders and System State** only, not application-aware (e.g., SQL/Exchange) or **bare-metal/whole-image** backups. For those you use **Microsoft Azure Backup Server (MABS)** or **System Center DPM**, which support application-consistent and bare-metal recovery. MARS is the lightweight, file-level option; MABS/DPM are the heavier, application/bare-metal solutions.

**Q: How can you monitor backup success across multiple vaults and servers?**
> Use **Azure Backup Reports** (via Backup center), which provide **cross-vault** visibility into **backup jobs, success/failure, storage consumption, and retention trends**. This centralized reporting lets ops confirm that scheduled MARS (and other) backups are succeeding across all servers/vaults and quickly identify failures to remediate — rather than checking each agent individually.

**Q: Can you restore MARS backups to a different machine than the one that created them?**
> **Yes** — you can restore to an **alternate machine** by installing the MARS agent on it, registering it with the **same vault** (using the vault credentials), and providing the **encryption passphrase**. This is essential for **recovering after hardware failure**, where the original server is gone and you need its files on a replacement. Without the passphrase, however, the restore cannot proceed.

---

## 77.9 Summary

The **MARS agent** (Microsoft Azure Recovery Services agent) is a lightweight **agent-based** backup for **Windows** machines (on-prem or Azure VMs) that protects **files, folders, and System State** — not whole images — sending encrypted recovery points to a **Recovery Services Vault** (up to **3 backups/day**). The **encryption passphrase is yours alone** (Microsoft can't recover it) and is **required to restore**, including to an **alternate machine**. For **application-consistent or bare-metal** backup you use **MABS/DPM** instead. **Azure Backup Reports** give **cross-vault** monitoring of jobs, storage, and trends. MARS is the file-level, on-prem complement to agentless Azure VM backup.

[↑ Back to top](#-table-of-contents)

---
---

# 78. 📂 File Share & Web App Backup
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 305 (Azure file share backup), 306 (Azure Web App backup)

---

## 78.1 What Problem Does This Solve?

Backup isn't just for VMs — **Azure File shares** hold important business data, and **Web Apps** have content and configuration worth protecting. Azure provides **native backup for Azure Files** (snapshot-based, managed via a vault) and a **backup feature in App Service** (content + configuration, optionally to a database). These let you recover shares and apps after accidental changes, deletions, or failed deployments.

Think of these like **version-history/undo for your cloud file drive and your website**. Just as a document app lets you roll back to yesterday's version, file-share backup and web-app backup let you restore a share or a site to a known-good point if something goes wrong.

> 💡 **If you know AWS:** Azure Files backup ≈ **AWS Backup for EFS / FSx** (scheduled, snapshot-based, point-in-time restore). Web App backup ≈ **Elastic Beanstalk/app backup or snapshotting app content + config to storage** — capturing the app's files, settings, and optionally its database for restore/clone.

---

## 78.2 File Share & Web App Backup (Flow Diagram)

```
AZURE FILE SHARE BACKUP (via Recovery Services Vault):
   Backup policy (schedule + retention) → SNAPSHOTS of the file share
        │  (snapshots are also usable directly on the share)
        ▼
   Restore: entire share OR individual files/folders → original or alternate location
   + Soft delete on file shares guards against accidental share deletion.

AZURE WEB APP BACKUP (App Service, Standard+ tiers):
   Backup = app CONTENT + CONFIGURATION (+ optionally a linked DATABASE)
        │  stored in an Azure STORAGE account (container)
        ▼
   Scheduled or on-demand; Restore to the same or a NEW app (clone).
   ⚠ Requires Standard/Premium plan; size limits apply; custom/manual DB options vary.
```

| Target | Mechanism | Restore |
|---|---|---|
| **Azure Files** | Snapshot-based backup via **Recovery Services Vault** + soft delete | Full share or **item-level** (files/folders) |
| **Web App (App Service)** | Backup of **content + config (+ optional DB)** to a **storage account** | Same app or a **new** app (clone); partial restore possible |

⭐ File-share backup is **snapshot-based** and supports **item-level restore**; **soft delete** protects shares from accidental deletion. Web App backup requires a **Standard+ App Service plan**, stores backups in a **storage account**, and can **include a database** — useful for safe deployments and cloning.

---

## 78.3 UI Steps

```
── Azure File share backup ──
📍 Recovery Services vault → "Backup" → Datasource = Azure File Share →
   select storage account + share → assign a backup policy → Enable backup
📍 Restore: Backup item → "Restore share" or "File Recovery" (item-level) → pick recovery point
📍 Also enable "Soft delete for file shares" on the storage account

── Azure Web App backup ──
📍 App Service → "Backups" → configure a Storage account + container →
   set schedule + retention → optionally include a linked database → "Backup now"
📍 Restore: "Backups" → pick a backup → restore to this app or a NEW app
```

---

## 78.4 Integration with Other Azure Services

| Service | Role |
|---|---|
| **Recovery Services Vault** | Manages Azure Files backup policies/recovery points |
| **Azure Files + soft delete** | The protected share + accidental-delete safety net |
| **App Service (Standard+)** | Hosts the web app backup feature |
| **Storage account** | Destination for web app backups |
| **Linked database** | Optionally included in a web app backup |

---

## 78.5 Real-World Scenario — Protecting Shares and a Web App

```
A company protects a departmental file share and a production web app.
   1. Enable Azure Files backup on the "finance" share: daily snapshots retained 30 days,
      plus soft delete to guard against accidental share deletion.
   2. When a user overwrites a spreadsheet, use item-level file recovery to restore just
      that file from yesterday's recovery point.
   3. Before a risky web app deployment, take an on-demand Web App backup (content + config
      + the linked SQL database) to a storage account.
   4. The deployment breaks the app → restore the backup to the same app, instantly reverting
      to the known-good state; or restore to a NEW app to test the fix.
Result: quick, granular recovery for file data and a safety net for web app deployments.
```

---

## 78.6 Benefits

- **Native file-share protection** — scheduled snapshots + item-level restore
- **Accidental-delete safety** — soft delete for file shares
- **Web app safety net** — back up content, config, and database
- **Deployment confidence** — restore or clone an app after a bad deploy
- **Flexible restore** — original or alternate/new location

---

## 78.7 Common Use Cases

- Scheduled backup of business-critical Azure file shares
- Item-level recovery of overwritten/deleted files
- Pre-deployment web app backups (content + config + DB)
- Cloning a web app to a new instance for testing/recovery

---

## 78.8 Exam Q&A

**Q: How does Azure File share backup work, and can you restore individual files?**
> Azure Files backup is **snapshot-based**, managed through a **Recovery Services Vault** with a **backup policy** (schedule + retention). You can restore the **entire share** or perform **item-level restore** of specific **files/folders** to the original or an alternate location. **Soft delete** for file shares adds protection against accidental **share deletion**, retaining it for recovery.

**Q: What does Azure Web App backup capture, and what's a key prerequisite?**
> It captures the app's **content and configuration**, and optionally a **linked database**, storing the backup in an **Azure storage account**. A key prerequisite is a **Standard (or higher) App Service plan** — the backup feature isn't available on Free/Shared tiers. Backups can be **scheduled or on-demand**, and there are **size limits** to be aware of.

**Q: You're about to deploy a risky change to a production web app. How can backup help?**
> Take an **on-demand Web App backup** (content + config + database) **before** deploying. If the deployment breaks the app, you can **restore the backup** to revert to the known-good state — or **restore to a new app** to test a fix without touching production. This provides a reliable rollback/clone capability around risky deployments.

**Q: Where are Azure Web App backups stored, and where can they be restored?**
> They're stored in an **Azure storage account/container** that you configure. You can **restore to the same app** (overwriting it) or to a **new/different app** (effectively cloning it) — useful for testing, migration, or recovering into a clean instance. This flexibility, plus optional database inclusion, makes it a practical safety net for App Service workloads.

---

## 78.9 Summary

Beyond VMs, Azure natively protects **file shares** and **web apps**. **Azure Files backup** is **snapshot-based** via a **Recovery Services Vault** with a **policy** (schedule + retention), supports **item-level restore** of files/folders, and pairs with **soft delete** to guard against accidental share deletion. **Azure Web App backup** (requires a **Standard+ App Service plan**) captures **content + configuration + optionally a database** into a **storage account**, with restore to the **same or a new app** — ideal as a **rollback/clone** around risky deployments. Both give targeted, granular recovery for non-VM workloads.

[↑ Back to top](#-table-of-contents)

---
---

# 79. 🌐 Azure Site Recovery
> 🟠 MEDIUM
> 📚 Course lectures: 307 (Azure Site Recovery), 308 (ASR - Enabling replication), 309 (ASR - Performing the failover)

---

## 79.1 What Problem Does This Solve?

Backup restores **data**, but after a regional disaster you also need your **workloads running again fast**, in another location — that's **disaster recovery (DR)**, not just backup. **Azure Site Recovery (ASR)** continuously **replicates** VMs (Azure-to-Azure, or on-prem-to-Azure) to a secondary region, so you can **fail over** and have systems running there with minimal downtime, then **fail back** when the primary recovers. It's about **business continuity** and meeting **RTO/RPO** targets.

Think of ASR like **keeping a warm standby duplicate of your entire operation in another city, continuously synced**. If your main site goes down (disaster), you flip a switch and the standby city takes over running the business (failover) with only seconds-to-minutes of lost data — then switch back once the main site is restored.

> 💡 **If you know AWS:** ASR ≈ **AWS Elastic Disaster Recovery (DRS)** (formerly CloudEndure) — continuous block-level replication to a target region with orchestrated failover/failback. **Recovery plans** ≈ DR runbooks/orchestration. Where **Azure Backup** ≈ AWS Backup (point-in-time data restore), **ASR** ≈ AWS DRS (keep workloads running elsewhere).

---

## 79.2 How ASR Works (Flow Diagram)

```
   PRIMARY REGION                          SECONDARY (DR) REGION
   ┌──────────────┐  continuous async     ┌──────────────────────┐
   │ Production VMs │ ──replication──────► │ Replicated data +      │
   │ (Azure or      │   (near-real-time)    │ recovery points        │
   │  on-prem)      │                       │ (VMs created ON failover)
   └──────────────┘                        └──────────────────────┘
          │                                          ▲
          │ DISASTER                                 │
          ▼                                          │
   FAILOVER (planned or unplanned) ──────────────────┘
      • Test failover  → validate DR in isolation (no impact to production)
      • Failover       → spin up VMs in the secondary region, resume operations
      • Failback       → replicate back and return to primary when recovered

   RECOVERY PLANS: orchestrate multi-VM failover order + scripts (e.g., DB before app).
   Targets:  RPO (data loss window) + RTO (time to recover).
```

| Concept | Detail |
|---|---|
| **Replication** | Continuous, **asynchronous** block-level to the secondary region |
| **Recovery points** | Crash-consistent + app-consistent points to fail over to |
| **Test failover** | Validate DR **without** disrupting production |
| **Failover** | Bring workloads up in the secondary region |
| **Failback** | Return to the primary once restored |
| **Recovery plan** | Orchestrates **order** + scripts for multi-VM failover |
| **RPO / RTO** | Data-loss window / time-to-recover objectives |

⭐ ASR is **DR (keep running elsewhere)**, distinct from **Backup (restore data)** — the exam often contrasts them. **Test failover** is critical: it validates your DR plan safely. **Recovery plans** sequence tiers (e.g., database before app servers).

---

## 79.3 Backup vs Site Recovery (Key Distinction)

```
AZURE BACKUP          → point-in-time COPIES for restore (data recovery, long retention).
                        Answers: "recover this file/VM to how it was."
AZURE SITE RECOVERY   → continuous REPLICATION + failover (business continuity/DR).
                        Answers: "keep the whole system running in another region NOW."
Many orgs use BOTH: Backup for data/retention, ASR for regional disaster recovery.
```

---

## 79.4 UI Steps — Enable Replication & Fail Over

```
📍 Recovery Services vault → "Site Recovery" → "Enable replication"
   Source: Azure region + VMs  →  Target: secondary region + target settings
   → set replication policy (recovery point retention, app-consistent frequency) → Enable
    ↓
📍 Monitor replication health until "Protected"
    ↓
📍 Test failover: Replicated item → "Test Failover" → pick recovery point + isolated VNet
   → validate → "Clean up test failover"
    ↓
📍 Real failover: "Failover" → choose recovery point → VMs come up in secondary region
📍 Failback / re-protect once primary is healthy
📍 (Optional) build a "Recovery Plan" to orchestrate multiple VMs + scripts
```

---

## 79.5 Integration with Other Azure Services

| Service | Role with ASR |
|---|---|
| **Recovery Services Vault** | Manages replication, recovery points, failover |
| **Secondary region / VNet** | Target for replicated VMs on failover |
| **Recovery plans + Automation** | Orchestrate ordered, scripted failovers |
| **Azure Backup** | Complementary — data restore vs DR |
| **Azure Monitor** | Alert on replication health |

---

## 79.6 Real-World Scenario — Regional Disaster Recovery

```
A business must keep a critical 3-tier app running even if its primary region fails.
   1. Enable ASR replication for all app VMs from the primary to a secondary region.
   2. Create a Recovery Plan that fails over the database tier first, then the app tier,
      then the web tier, running a script to update connection strings.
   3. Quarterly, run a TEST FAILOVER into an isolated VNet to validate DR without touching
      production — confirming RTO/RPO targets are met.
   4. When the primary region suffers a real outage, execute the recovery plan → the app is
      running in the secondary region within the RTO, losing only seconds of data (RPO).
   5. After the primary recovers, fail back and re-protect.
Result: validated, orchestrated business continuity that meets recovery objectives — far
beyond what backup alone provides.
```

---

## 79.7 Benefits

- **Business continuity** — keep workloads running after a regional disaster
- **Low RPO/RTO** — continuous replication + fast failover
- **Safe validation** — test failover without impacting production
- **Orchestration** — recovery plans sequence multi-tier failover + scripts
- **Flexible sources** — Azure-to-Azure and on-prem-to-Azure
- **Complements backup** — DR alongside point-in-time data restore

---

## 79.8 Common Use Cases

- Regional DR for critical Azure workloads (Azure-to-Azure)
- Migrating/DR for on-premises VMs to Azure
- Meeting compliance RTO/RPO requirements
- Orchestrated, ordered failover of multi-tier applications
- Periodic DR drills via test failover

---

## 79.9 Exam Q&A

**Q: What is the difference between Azure Backup and Azure Site Recovery?**
> **Azure Backup** creates **point-in-time copies** for **data recovery** (restore a file/VM to a past state, with long retention). **Azure Site Recovery (ASR)** provides **continuous replication + failover** for **disaster recovery/business continuity** — keeping entire workloads **running in another region** after an outage. Backup answers "recover this data"; ASR answers "keep the system running elsewhere now." They're complementary and often used together.

**Q: What is a test failover and why is it important?**
> A **test failover** spins up the replicated VMs in an **isolated network** in the secondary region **without disrupting production or affecting ongoing replication**. It's important because it **validates the DR plan** — confirming VMs boot, apps work, and RTO/RPO are achievable — so you have confidence the real failover will succeed. Regular test failovers are a DR best practice (and often a compliance requirement).

**Q: What do RPO and RTO mean in the context of ASR?**
> **RPO (Recovery Point Objective)** is the **maximum acceptable data loss**, i.e., how far back the recovery point is (ASR's continuous async replication yields a **low RPO**, often seconds/minutes). **RTO (Recovery Time Objective)** is the **maximum acceptable downtime** — how quickly you must be running again after a disaster. ASR is designed to meet aggressive RPO/RTO targets via replication and fast, orchestrated failover.

**Q: What is a recovery plan in ASR?**
> A **recovery plan** **orchestrates failover** of **multiple VMs** in a defined **order** (groups/tiers) and can run **scripts or Automation runbooks** at each step — e.g., fail over the **database** tier first, run a script to update configuration, then the **app** and **web** tiers. This ensures a **multi-tier application** comes up correctly and in the right sequence during a disaster, rather than all at once.

**Q: Can ASR protect on-premises machines, and what's the typical flow?**
> **Yes** — ASR supports **on-premises-to-Azure** replication (for VMware/Hyper-V/physical servers) in addition to **Azure-to-Azure**. The flow is the same: **replicate** to Azure, run **test failovers** to validate, **fail over** to Azure during a disaster (or migration), and **fail back** to on-prem when recovered. This also makes ASR a popular **migration** tool, not just DR.

---

## 79.10 Summary

**Azure Site Recovery (ASR)** delivers **disaster recovery / business continuity** by **continuously replicating** VMs (**Azure-to-Azure** or **on-prem-to-Azure**) to a **secondary region**, enabling **failover** to keep workloads running after an outage and **failback** when the primary recovers. Key ideas: **continuous async replication** (low **RPO**), fast **failover** (meets **RTO**), **test failover** to validate DR safely, and **recovery plans** to orchestrate ordered, scripted multi-tier failover. It's distinct from **Azure Backup** — **ASR keeps systems running elsewhere** (DR), while **Backup restores data** (point-in-time) — and the two are commonly used together. It's Azure's equivalent of **AWS Elastic Disaster Recovery**.

[↑ Back to top](#-table-of-contents)

---
---

# 80. 🗄️ Azure Backup Vault
> 🟡 KNOW-THIS-MUCH
> 📚 Course lectures: 310 (Azure Backup Vault - Azure VM), 311 (Azure Backup Vault - Blobs)

---

## 80.1 What Problem Does This Solve?

The **Recovery Services Vault** (Topic 76) is the long-standing backup store, but Azure introduced a newer **Backup Vault** to support **newer workloads** — such as **Azure Blobs**, **Azure Disks**, **Azure Database for PostgreSQL**, and **Kubernetes (AKS)** — under a modern management model. Knowing there are **two vault types** and which workloads each supports prevents confusion when configuring backup for these newer services.

Think of it like **two different safe-deposit vault designs at the same bank**. The classic vault (Recovery Services) handles the traditional valuables (VMs, files, Azure Files, on-prem via MARS). The newer vault (Backup Vault) is built for newer asset types (blobs, disks, certain databases, Kubernetes). You pick the vault that's built for what you're protecting.

> 💡 **If you know AWS:** This is like AWS evolving its backup to cover **more resource types over time** under **AWS Backup**. The distinction mirrors "older snapshot mechanisms vs the unified/newer backup service" — in Azure, the **workload** dictates which **vault type** you use.

---

## 80.2 Two Vault Types & What They Protect (Flow Diagram)

```
   ┌──────────────── RECOVERY SERVICES VAULT (classic) ────────────────┐
   │ Azure VMs · Azure Files · SQL/SAP in Azure VMs · on-prem (MARS/MABS)│
   │ + Azure Site Recovery (ASR)                                         │
   └──────────────────────────────────────────────────────────────────┘

   ┌──────────────────── BACKUP VAULT (newer) ─────────────────────────┐
   │ Azure Blobs (operational backup) · Azure Managed Disks ·            │
   │ Azure Database for PostgreSQL · Azure Kubernetes Service (AKS)      │
   └──────────────────────────────────────────────────────────────────┘

   Choose the vault by WORKLOAD. Both: policy-driven, secure, with redundancy options.
```

| Vault type | Primary workloads |
|---|---|
| **Recovery Services Vault** | Azure VMs, Azure Files, SQL/SAP-in-VM, on-prem (MARS/MABS), **ASR** |
| **Backup Vault** | **Azure Blobs**, **Managed Disks**, **PostgreSQL**, **AKS** |

```
BLOB backup (operational): continuous, local point-in-time restore using soft delete +
   versioning + change feed → restore blobs to an earlier state (within the retention window).
DISK backup: snapshot-based protection of managed disks via the Backup Vault.
```

⭐ The **workload decides the vault type**. **Blob operational backup** leverages **soft delete + versioning + change feed** for point-in-time restore of blob data. Both vault types are **policy-driven** with **redundancy** choices.

---

## 80.3 UI Steps

```
📍 "Backup vaults" → "+ Create" (name, region, redundancy) → Create
    ↓
📍 Backup vault → "+ Backup" → Datasource type:
   • Azure Blobs → select storage account → policy (operational/point-in-time) → configure
   • Azure Disks → select managed disk(s) → snapshot policy → configure
   • PostgreSQL / AKS → select instance → policy → configure
    ↓
📍 Restore: Backup vault → backup instance → restore to a point in time / to a target
```

```bash
az dataprotection backup-vault create -g rg --vault-name blob-bkv \
  -l centralindia --storage-settings datastore-type="VaultStore" type="LocallyRedundant"
# Then configure a backup policy + instance for blobs/disks via dataprotection commands.
```

---

## 80.4 Integration with Other Azure Services

| Service | Role with Backup Vault |
|---|---|
| **Azure Blob storage** | Operational point-in-time backup (soft delete/versioning/change feed) |
| **Managed Disks** | Snapshot-based disk backup |
| **Azure Database for PostgreSQL** | Database backup |
| **AKS** | Kubernetes cluster/resource backup |
| **Azure Policy / Backup center** | Govern and centrally manage backups across vault types |

---

## 80.5 Real-World Scenario — Protecting Newer Workloads

```
A company protects a mix of modern workloads.
   1. VMs and Azure Files are protected by a Recovery Services Vault (classic).
   2. For critical blob containers, they create a Backup Vault and enable operational blob
      backup (soft delete + versioning + change feed) → point-in-time restore if data is
      corrupted or wrongly overwritten.
   3. Managed disks for a specialized workload are backed up via the Backup Vault's snapshot
      policy.
   4. An Azure Database for PostgreSQL instance is protected through the Backup Vault too.
   5. Backup center gives a single pane across both vault types for governance and reporting.
Result: the right vault protects each workload — classic for VMs/Files, Backup Vault for
blobs/disks/PostgreSQL/AKS — managed centrally.
```

---

## 80.6 Benefits

- **Covers newer workloads** — blobs, disks, PostgreSQL, AKS
- **Operational blob backup** — point-in-time restore via soft delete/versioning/change feed
- **Policy-driven & secure** — schedules, retention, redundancy
- **Right tool per workload** — choose vault type by resource
- **Central management** — Backup center spans both vault types

---

## 80.7 Common Use Cases

- Point-in-time protection of critical Blob data
- Backing up Azure Managed Disks
- Protecting Azure Database for PostgreSQL
- Backing up AKS cluster resources
- Centralized backup governance across vault types

---

## 80.8 Exam Q&A

**Q: What is the difference between a Recovery Services Vault and a Backup Vault?**
> A **Recovery Services Vault** is the **classic** vault for **Azure VMs, Azure Files, SQL/SAP-in-VM, on-prem (MARS/MABS)**, and **Azure Site Recovery**. A **Backup Vault** is the **newer** vault supporting **Azure Blobs, Managed Disks, Azure Database for PostgreSQL, and AKS**. The **workload determines which vault type** you use — you can't protect a classic workload in a Backup Vault or vice versa, so matching workload to vault type is the key point.

**Q: How does operational backup for Azure Blobs provide point-in-time restore?**
> It leverages **soft delete, blob versioning, and the change feed** to track changes, enabling you to **restore blob data to an earlier point in time** within the retention window — recovering from corruption, accidental overwrites, or deletes. It's a **local, continuous** operational backup (not copying data to a separate vault store), configured via a **Backup Vault** policy on the storage account.

**Q: You need to back up an Azure Managed Disk and an AKS cluster. Which vault type do you use?**
> A **Backup Vault** — it's the vault type that supports **newer workloads including Managed Disks and AKS** (as well as Blobs and PostgreSQL). The classic **Recovery Services Vault** doesn't cover these; it's for VMs, Azure Files, in-VM SQL/SAP, on-prem agents, and ASR. Selecting the correct vault type up front avoids configuration dead-ends.

**Q: How can you manage backups across both vault types centrally?**
> Use **Backup center**, a unified management experience in the portal that spans **both Recovery Services Vaults and Backup Vaults**, giving centralized **monitoring, policy management, compliance, and reporting** across all protected workloads. Combined with **Azure Policy**, it lets you govern and enforce backup across the estate regardless of which vault type each workload requires.

---

## 80.9 Summary

Azure has **two vault types**, and the **workload decides which to use**. The **Recovery Services Vault** (classic) protects **Azure VMs, Azure Files, SQL/SAP-in-VM, on-prem (MARS/MABS)**, and powers **Azure Site Recovery**. The newer **Backup Vault** protects **Azure Blobs, Managed Disks, Azure Database for PostgreSQL, and AKS**. **Blob operational backup** uses **soft delete + versioning + change feed** for **point-in-time restore**, and disk backup is **snapshot-based**. Both are **policy-driven** with **redundancy** options and are governed centrally through **Backup center**. Knowing the split — classic vault for traditional workloads, Backup Vault for newer ones — is the exam takeaway. This completes the **Monitor & Backup** section and the full AZ-104 study notes. 🎉

[↑ Back to top](#-table-of-contents)

---
---

> # 🧩 JD-Aligned Additions (beyond the AZ-104 course)
> These topics aren't part of the Alan Rodrigues AZ-104 course but appear as **required Azure services/skills** in the target job description (messaging/eventing, AI, and Terraform IaC). They use the exact same merged format so they slot in seamlessly. Skills from the JD that are **not Azure resources** (Python automation, CI/CD pipelines, Harness, LangGraph/LangChain, agentic AI) are noted at the end rather than given resource topics.

---

# 81. 📡 Azure Event Hubs
> 🔴 FULL
> 📚 JD reference: "Azure services such as Compute, Storage, **Event Hub**, Event Subscription, Storage Queue, and PaaS services"

---

## 81.1 What Problem Does This Solve?

Modern systems emit **huge streams of events** — telemetry, logs, clickstreams, IoT sensor data — millions of events per second that must be ingested reliably and handed to many consumers (analytics, storage, real-time processing). **Azure Event Hubs** is a **big-data streaming / event-ingestion** platform (PaaS) built for exactly this: it accepts massive event throughput, buffers it durably, and lets multiple downstream systems read the same stream at their own pace.

Think of Event Hubs like **a conveyor belt at a massive package-sorting facility**. Packages (events) pour onto the belt from thousands of senders; the belt holds them in order for a set time, and multiple sorting stations (consumers) each read from the belt independently without slowing the others down. It's built for firehose volume, not one-at-a-time delivery.

> 💡 **If you know AWS:** Event Hubs ≈ **Amazon Kinesis Data Streams** (high-throughput streaming ingestion). **Partitions ≈ Kinesis shards**, **consumer groups ≈ Kinesis consumers/enhanced fan-out**, and the Kafka-compatible endpoint means Event Hubs can also act like **Amazon MSK (managed Kafka)**. It's streaming/ingestion — different from **Service Bus** (enterprise messaging ≈ SQS/SNS) and from **Event Grid** (discrete event routing ≈ EventBridge).

---

## 81.2 How Event Hubs Works (Flow Diagram)

```
   PRODUCERS (send events)                EVENT HUB (within a Namespace)
   ┌────────────────┐   AMQP / Kafka /   ┌──────────────────────────────────┐
   │ apps, devices,  │   HTTPS            │  Partition 0 ▸ ▸ ▸ ▸ ▸ (ordered log)│
   │ IoT, services   │ ─────────────────►│  Partition 1 ▸ ▸ ▸ ▸ ▸              │
   │ (millions/sec)  │                   │  Partition 2 ▸ ▸ ▸ ▸ ▸              │
   └────────────────┘                   │  (events retained N days)           │
                                         └───────────────┬────────────────────┘
   CONSUMER GROUPS (independent readers), each tracks its own offset:
        ├─ "analytics"  → Azure Stream Analytics / Databricks
        ├─ "archive"    → Event Hubs Capture → Blob/Data Lake (auto)
        └─ "alerts"     → Azure Function

   Throughput: Throughput Units (Standard) / Processing Units (Premium) /
               Capacity Units (Dedicated) — scale ingest & egress.
```

| Concept | Meaning |
|---|---|
| **Namespace** | The management container (DNS endpoint) holding one or more event hubs |
| **Event Hub** | The stream itself (like a Kafka "topic") |
| **Partition** | A parallel, ordered log; ordering is **within** a partition |
| **Producer** | Sends events (AMQP, HTTPS, or **Kafka** protocol) |
| **Consumer group** | An independent view of the stream; each tracks its own **offset** |
| **Retention** | Events kept for a configurable period (then dropped) |
| **Capture** | Auto-archive the stream to Blob/Data Lake (no code) |
| **Throughput Units** | Scaling unit for ingress/egress (Standard tier) |

⭐ **Event Hubs = streaming ingestion** (high volume, pull-based, multiple consumers reading the same ordered log). It is **not** a queue (that's Storage Queue / Service Bus) and **not** discrete event routing (that's Event Grid). Ordering is guaranteed **only within a partition**, and **consumer groups** let many pipelines read independently.

---

## 81.3 Event Hubs vs Service Bus vs Event Grid vs Storage Queue

```
EVENT HUBS    → BIG event STREAMS (telemetry/logs/IoT), millions/sec, multiple readers,
                replayable log, partitions.           (≈ Kinesis/Kafka)
SERVICE BUS   → Enterprise MESSAGING (queues/topics), ordering, sessions, transactions,
                dead-letter — reliable commands.       (≈ SQS/SNS advanced)
EVENT GRID    → Discrete EVENT routing/notifications (reactive, push, pub-sub). (≈ EventBridge)
STORAGE QUEUE → Simple, cheap queue for decoupling app components.             (≈ basic SQS)
```

---

## 81.4 UI / CLI Steps — Create & Send/Receive

```
📍 portal.azure.com → "Event Hubs" → "+ Create" (Namespace: name, tier=Standard, TUs)
    ↓
📍 Open the namespace → "+ Event Hub" → name=telemetry, partition count=4, retention=1 day
    ↓
📍 (Optional) Enable "Capture" → archive to a Blob container / Data Lake automatically
    ↓
📍 Access: "Shared access policies" (SAS connection string) OR Entra RBAC
   ("Azure Event Hubs Data Sender" / "Data Receiver")
    ↓
📍 Consume with a consumer group (e.g., "$Default") via SDK / Stream Analytics / Function
```

```bash
az eventhubs namespace create -g rg -n my-eh-ns --sku Standard --capacity 2
az eventhubs eventhub create -g rg --namespace-name my-eh-ns -n telemetry \
  --partition-count 4 --message-retention 1
az eventhubs eventhub consumer-group create -g rg --namespace-name my-eh-ns \
  --eventhub-name telemetry -n analytics
```

---

## 81.5 Integration with Other Azure Services

| Service | Role with Event Hubs |
|---|---|
| **Azure Stream Analytics / Databricks** | Real-time processing of the stream |
| **Event Hubs Capture → Blob / Data Lake** | Automatic archival for batch/analytics |
| **Azure Functions** | Serverless per-batch event processing (trigger) |
| **IoT Hub** | Device ingestion built on Event Hubs under the hood |
| **Azure Monitor** | Can stream diagnostic logs/metrics into an Event Hub |
| **Kafka ecosystem** | Kafka-protocol clients connect without code changes |

---

## 81.6 Real-World Scenario — Telemetry Ingestion Pipeline

```
A platform ingests millions of IoT/app telemetry events per minute for real-time and
historical analysis.
   1. Producers send events to an Event Hub "telemetry" (4 partitions) via AMQP/Kafka.
   2. Consumer group "analytics" → Azure Stream Analytics computes real-time dashboards.
   3. Consumer group "archive" → Event Hubs Capture auto-writes raw events to a Data Lake
      for later batch processing (no custom code).
   4. Consumer group "alerts" → an Azure Function fires on anomaly batches.
   5. Access is keyless via managed identities with "Event Hubs Data Sender/Receiver" roles.
Result: one durable, replayable stream feeds multiple independent pipelines at massive
scale — exactly what a queue couldn't do.
```

---

## 81.7 Benefits

- **Massive scale** — millions of events/second ingestion
- **Multiple independent consumers** — consumer groups read the same stream
- **Replayable** — events retained for a window; readers track their own offset
- **No-code archival** — Capture to Blob/Data Lake
- **Open protocols** — AMQP, HTTPS, and **Kafka**-compatible
- **PaaS** — fully managed, elastic throughput units

---

## 81.8 Common Use Cases

- Telemetry, logs, and metrics ingestion at scale
- IoT and clickstream/event streaming
- Real-time analytics pipelines (Stream Analytics/Databricks)
- Streaming Azure diagnostic logs to external SIEM/analytics
- Kafka-compatible streaming without running Kafka

---

## 81.9 Exam/Interview Q&A

**Q: What is Azure Event Hubs designed for, and how does it differ from a queue?**
> Event Hubs is a **big-data streaming/event-ingestion** service built to accept **millions of events per second** and expose them as an **ordered, replayable log** that **multiple consumers** read independently. A **queue** (Storage Queue/Service Bus) is for **discrete message delivery** where each message is typically processed once and removed. Event Hubs keeps events for a retention window and lets many pipelines read the same data — it's streaming, not point-to-point messaging.

**Q: What are partitions and consumer groups, and how do they relate to ordering and parallelism?**
> **Partitions** are parallel, ordered logs within an event hub — ordering is guaranteed **only within a partition**, and partitions enable **parallel throughput**. **Consumer groups** are independent "views" of the entire stream; each maintains its **own offset**, so multiple downstream systems (analytics, archive, alerts) can read the **same events** without interfering. Partition count sets max read parallelism per consumer group.

**Q: When would you choose Event Hubs over Service Bus or Event Grid?**
> Choose **Event Hubs** for **high-volume streaming/telemetry** that many consumers replay (IoT, logs, clickstream). Choose **Service Bus** for **reliable enterprise messaging** (ordered commands, sessions, transactions, dead-lettering). Choose **Event Grid** for **discrete, reactive event routing** (e.g., "a blob was created → trigger a function"). The deciding factor is **stream of many events** (Event Hubs) vs **individual reliable messages** (Service Bus) vs **event notifications/routing** (Event Grid).

**Q: What is Event Hubs Capture?**
> **Capture** automatically writes the incoming event stream to **Azure Blob Storage or Data Lake** in near-real-time (Avro format) with **no code** — giving you a durable archive for batch processing/analytics alongside real-time consumers. It's configured on the event hub and decouples long-term storage from stream retention, which is otherwise limited to the configured window.

**Q: How do you secure access to an Event Hub?**
> Via **Shared Access Signatures (SAS)** policies with send/listen/manage rights, or — preferably — **Microsoft Entra RBAC** using roles like **Azure Event Hubs Data Sender** and **Data Receiver** assigned to users/apps/**managed identities**. Entra-based auth is keyless and auditable, and you can combine it with **private endpoints/firewall** to restrict network access.

---

## 81.10 Summary

**Azure Event Hubs** is a managed **big-data streaming/ingestion** service (PaaS) for **millions of events per second** — telemetry, logs, IoT, clickstream. Events land in an **event hub** (inside a **namespace**), split across **partitions** (ordering is per-partition), and are read by **consumer groups** that each track their own **offset**, so many pipelines replay the same stream independently. **Capture** auto-archives to **Blob/Data Lake**; access is via **SAS or Entra RBAC** (Data Sender/Receiver); scaling is by **throughput units**. It supports **AMQP, HTTPS, and Kafka**. Remember the contrasts: **Event Hubs = streaming** (≈ Kinesis/Kafka), **Service Bus = enterprise messaging** (≈ SQS/SNS), **Event Grid = event routing** (≈ EventBridge), **Storage Queue = simple queue**.

[↑ Back to top](#-table-of-contents)

---
---

# 82. ⚡ Azure Event Grid & Event Subscriptions
> 🟠 MEDIUM
> 📚 JD reference: "Event Subscription" and PaaS eventing

---

## 82.1 What Problem Does This Solve?

Systems need to **react to things happening** — a blob was uploaded, a resource was created, an order was placed — without constantly polling for changes. **Azure Event Grid** is a fully managed **event routing** service that implements **publish-subscribe**: event **sources** publish discrete events, and **Event Subscriptions** route those events (with filtering) to **handlers** (Functions, webhooks, queues, Logic Apps). It's the glue for **reactive, serverless, event-driven** architectures.

Think of Event Grid like **a smart mailroom with subscription slips**. When mail (events) arrives from any department (sources), the mailroom checks everyone's subscription slips ("I only want invoices over $500 from Finance") and instantly routes matching mail to the right desks (handlers) — no one has to keep walking to the mailroom to check.

> 💡 **If you know AWS:** Event Grid ≈ **Amazon EventBridge** (event bus, pub-sub routing with filtering to targets). An **Event Subscription ≈ an EventBridge rule + target**. It's for **discrete event notifications/routing** — distinct from **Event Hubs** (Kinesis-style streaming) and **Service Bus/Storage Queue** (message queues).

---

## 82.2 How Event Grid Works (Flow Diagram)

```
   EVENT SOURCES (publish discrete events)        EVENT GRID (push, pub-sub)
   ┌───────────────────────────────┐             ┌──────────────────────────┐
   │ Storage (BlobCreated/Deleted)   │            │ Topic / System topic       │
   │ Resource Groups (resource events)│ ──────────►│    │                       │
   │ Event Hubs / IoT / Custom topics │            │    ▼  EVENT SUBSCRIPTIONS   │
   └───────────────────────────────┘             │    (with FILTERS)          │
                                                  └────────┬───────────────────┘
       routes matching events (push) to HANDLERS:
         ├─ Azure Function          ├─ Webhook (HTTPS endpoint)
         ├─ Logic App               ├─ Storage Queue / Service Bus / Event Hub
         └─ Automation / Hybrid connections

   Reliability: retries + dead-letter (to a storage account) if a handler fails.
```

| Concept | Meaning |
|---|---|
| **Event source** | What emits events (Storage, resource groups, custom apps…) |
| **System topic** | Built-in topic for Azure service events (e.g., a storage account) |
| **Custom topic** | Your own topic for application events |
| **Event Subscription** | The rule that routes (and **filters**) events to a handler |
| **Handler/endpoint** | Where events go: Function, webhook, queue, Logic App, etc. |
| **Filtering** | By event type, subject prefix/suffix, or advanced fields |
| **Dead-letter** | Undeliverable events sent to a storage account |

⭐ Event Grid is **push-based** and for **discrete reactive events** (not streams, not durable queues). **Event Subscriptions** carry the **filters** and point to the **handler**, with built-in **retries + dead-lettering** for reliability.

---

## 82.3 UI / CLI Steps — Subscribe to Blob Events

```
📍 Storage account → "Events" → "+ Event Subscription"
   ┌──────────────────────────────────────────────┐
   │ Name: on-blob-created                           │
   │ Event types: Blob Created                        │
   │ Endpoint type: Azure Function / Webhook / Queue  │
   │ Filters: subject begins with /blobServices/.../uploads/ │
   └──────────────────────────────────────────────┘
   Create → new blobs in "uploads" now push an event to the handler
    ↓
📍 Custom topic: Event Grid Topics → + Create → publish app events to its endpoint →
   add Event Subscriptions with filters → handlers
```

```bash
az eventgrid system-topic create -g rg -n storage-topic \
  --source "/subscriptions/<sub>/resourceGroups/rg/providers/Microsoft.Storage/storageAccounts/acct" \
  --topic-type Microsoft.Storage.StorageAccounts --location centralindia

az eventgrid system-topic event-subscription create -n on-blob-created \
  -g rg --system-topic-name storage-topic \
  --endpoint <function-or-webhook-url> \
  --included-event-types Microsoft.Storage.BlobCreated
```

---

## 82.4 Integration with Other Azure Services

| Service | Role with Event Grid |
|---|---|
| **Azure Functions / Logic Apps** | Common serverless handlers |
| **Blob Storage** | A top event source (BlobCreated/Deleted) |
| **Storage Queue / Service Bus / Event Hub** | Durable handler endpoints |
| **Resource Groups / Subscriptions** | Emit resource lifecycle events |
| **Custom apps** | Publish business events to custom topics |

---

## 82.5 Real-World Scenario — Serverless Image Processing

```
Uploaded images must be processed the instant they arrive — no polling.
   1. Create an Event Subscription on the storage account for "Blob Created" events,
      filtered to the "uploads/" path.
   2. The handler is an Azure Function that generates thumbnails.
   3. When a user uploads an image, Event Grid PUSHES the event to the Function immediately.
   4. If the Function is down, Event Grid retries with backoff; persistently failed events
      go to a dead-letter storage container for later inspection.
Result: a fully reactive, serverless pipeline that scales to zero when idle and fires
instantly on each upload — no scheduled polling, minimal cost.
```

---

## 82.6 Benefits

- **Reactive & serverless** — handlers fire instantly on events
- **Pub-sub with filtering** — route only the events each handler cares about
- **Reliable** — automatic retries + dead-lettering
- **No infrastructure** — fully managed, scales automatically, pay-per-event
- **Broad integration** — many Azure sources and handler types

---

## 82.7 Common Use Cases

- Triggering functions/workflows on blob or resource events
- Decoupled, event-driven microservice communication (custom topics)
- Automation on resource lifecycle events (created/deleted)
- Fan-out notifications to multiple handlers with filters

---

## 82.8 Exam/Interview Q&A

**Q: What is an Event Subscription in Azure Event Grid?**
> An **Event Subscription** is the configuration that **routes events from a source/topic to a handler**, including the **filters** (event types, subject prefix/suffix, advanced fields) that decide which events are delivered and the **endpoint** (Function, webhook, queue, Logic App) that receives them. It's the core object you create to make a handler react to specific events — the rule that ties source → filter → destination.

**Q: How does Event Grid differ from Event Hubs and Service Bus?**
> **Event Grid** routes **discrete, reactive events** (push, pub-sub, with filtering) — e.g., "a blob was created." **Event Hubs** handles **high-volume streaming** (telemetry/logs, replayable log, many consumers). **Service Bus** provides **reliable enterprise messaging** (ordered queues/topics, sessions, transactions). In short: **Event Grid = event notifications/routing, Event Hubs = streaming, Service Bus = messaging** — each solves a different integration pattern.

**Q: What happens if an Event Grid handler fails to receive an event?**
> Event Grid **retries** delivery with an exponential back-off schedule for a configured period. If the event still can't be delivered, it's sent to a **dead-letter** destination (an Azure Storage container you configure), so no event is silently lost and you can inspect/replay failures. This built-in retry + dead-lettering is what makes Event Grid reliable for production event-driven systems.

**Q: How do you limit a subscription to only the events you care about?**
> Use **filtering** on the Event Subscription — by **event type** (e.g., only `BlobCreated`), **subject begins-with/ends-with** (e.g., only a specific container/path or file extension), or **advanced filters** on event data fields. This ensures the handler is invoked only for relevant events, reducing noise and cost and avoiding unnecessary handler executions.

---

## 82.9 Summary

**Azure Event Grid** is a managed **event-routing (pub-sub)** service for **discrete, reactive events** — sources publish events, and **Event Subscriptions** (carrying **filters**) **push** matching events to **handlers** (Functions, webhooks, queues, Logic Apps), with built-in **retries and dead-lettering**. Sources include **Blob Storage** (BlobCreated/Deleted), resource groups, Event Hubs, and **custom topics** for app events. It's the backbone of **serverless, event-driven** architectures. Remember the distinction: **Event Grid = event routing/notifications** (≈ EventBridge), separate from **Event Hubs** (streaming) and **Service Bus/Storage Queue** (messaging/queues).

[↑ Back to top](#-table-of-contents)

---
---

# 83. 📨 Azure Storage Queues
> 🟠 MEDIUM
> 📚 JD reference: "Storage Queue" (one of the four storage account services)

---

## 83.1 What Problem Does This Solve?

Application components shouldn't call each other directly and synchronously — if the receiver is slow or down, the sender stalls or fails. **Azure Storage Queues** provide a **simple, durable, cheap message queue** (part of the Storage account) to **decouple** producers and consumers: a producer drops a message, the consumer picks it up later and processes it, absorbing load spikes and surviving outages. It's the lightweight queue option in Azure.

Think of a Storage Queue like **a ticket spike at a diner kitchen**. Waiters (producers) clip orders onto the spike; cooks (consumers) take them off one at a time when ready. Orders don't get lost if the kitchen is briefly slammed, and waiters never have to wait for a cook to be free — the spike decouples them.

> 💡 **If you know AWS:** Azure Storage Queue ≈ **Amazon SQS (standard)** — a simple, durable, pull-based queue with **visibility timeout** semantics. For richer messaging (ordering, sessions, topics/subscriptions, transactions, dead-letter) Azure has **Service Bus** (≈ SQS FIFO + SNS). Storage Queue is the **simple/cheap** option; Service Bus is the **enterprise** option.

---

## 83.2 How Storage Queues Work (Flow Diagram)

```
   Storage account → Queue service → queue "orders"
        acct.queue.core.windows.net/orders

   PRODUCER ──put message──► [ msg1 | msg2 | msg3 | ... ]  (up to 64 KB each)
                                         │
   CONSUMER ──get message──► message becomes INVISIBLE (visibility timeout)
                              │ process it...
                              ├─ success → DELETE message  ✅
                              └─ crash/timeout → message REAPPEARS for retry 🔁

   Scale: up to ~500 TB (storage-account limit); millions of messages.
   No built-in ordering guarantee; at-least-once delivery.
```

| Feature | Storage Queue |
|---|---|
| **Message size** | up to **64 KB** |
| **Capacity** | Very large (bounded by storage account, up to ~500 TB) |
| **Delivery** | At-least-once; **visibility timeout** hides a message while processing |
| **Ordering** | **Not guaranteed** (best-effort FIFO) |
| **Access** | Account key, **SAS**, or **Entra RBAC** (Storage Queue Data roles) |
| **TTL** | Messages expire after a configurable time-to-live |

⭐ Key mechanic: when a consumer **reads** a message it becomes **invisible** for the **visibility timeout**; the consumer must **delete** it after processing, otherwise it **reappears** (at-least-once → design idempotent consumers). Choose **Storage Queue** for simple/cheap decoupling; **Service Bus** when you need ordering, sessions, topics, or transactions.

---

## 83.3 Storage Queue vs Service Bus Queue

```
STORAGE QUEUE  → simple, cheap, huge capacity, 64 KB msgs, no ordering, basic. (≈ SQS std)
SERVICE BUS    → ordering (FIFO/sessions), topics+subscriptions (pub-sub), transactions,
                 dead-letter, larger messages, duplicate detection. (enterprise messaging)
Pick Storage Queue for lightweight decoupling; Service Bus for rich/ordered messaging.
```

---

## 83.4 UI / CLI Steps — Create & Use a Queue

```
📍 Storage account → "Queues" → "+ Queue" → name=orders → OK
📍 Add/peek messages in the portal, or use SDK/CLI:
```
```bash
az storage queue create --account-name acct -n orders --auth-mode login
az storage message put --account-name acct -q orders --content "order-123" --auth-mode login
az storage message get --account-name acct -q orders --auth-mode login   # becomes invisible
# ...process, then delete using the returned id + pop-receipt...
az storage message delete --account-name acct -q orders \
  --id <msg-id> --pop-receipt <pop-receipt> --auth-mode login
```

---

## 83.5 Integration with Other Azure Services

| Service | Role with Storage Queue |
|---|---|
| **Azure Functions** | **Queue trigger** processes messages serverlessly |
| **Event Grid** | Can deliver events into a storage queue (durable handler) |
| **Web/Worker apps** | Decouple front-end from background processing |
| **Managed identities / RBAC** | Keyless access via Storage Queue Data roles |

---

## 83.6 Real-World Scenario — Decoupling a Web App from Workers

```
A web app accepts orders but processing (payment, email, inventory) is slow.
   1. The web front-end writes each order as a message to the "orders" Storage Queue and
      returns immediately — users get a fast response.
   2. An Azure Function with a QUEUE TRIGGER picks up messages and processes orders in the
      background, scaling out automatically with the queue depth.
   3. If a worker crashes mid-message, the visibility timeout expires and the message
      reappears for another worker (consumers are idempotent to handle retries safely).
   4. A traffic spike just lengthens the queue instead of overwhelming the backend.
Result: a resilient, scalable, decoupled design — the queue absorbs load and survives
worker failures.
```

---

## 83.7 Benefits

- **Decoupling** — producers and consumers run independently
- **Load leveling** — absorbs spikes; backend processes at its own pace
- **Durable & cheap** — simple queue at storage pricing, huge capacity
- **Resilient** — visibility timeout + reappear-on-failure (at-least-once)
- **Serverless-friendly** — native Azure Functions queue trigger
- **Secure** — key, SAS, or Entra RBAC access

---

## 83.8 Common Use Cases

- Offloading slow/background work from a web front-end
- Load leveling for spiky workloads
- Simple task/job queues for worker processes
- Buffering between decoupled microservices

---

## 83.9 Exam/Interview Q&A

**Q: What is the visibility timeout in a Storage Queue, and why does it matter?**
> When a consumer **retrieves** a message, it becomes **invisible** to other consumers for the **visibility timeout** while being processed. If the consumer **deletes** it before the timeout, it's gone; if the consumer **crashes or times out**, the message **reappears** for another consumer to retry. This provides **at-least-once** delivery and failure resilience — but means consumers should be **idempotent** since a message could be processed more than once.

**Q: When should you use a Storage Queue versus Azure Service Bus?**
> Use a **Storage Queue** for **simple, cheap, high-capacity** decoupling where you don't need advanced features. Use **Service Bus** when you need **ordering/FIFO, sessions, topics & subscriptions (pub-sub), transactions, duplicate detection, dead-lettering, or larger messages**. Storage Queue is the lightweight option (≈ SQS standard); Service Bus is the enterprise messaging platform. The requirements (ordering/transactions/topics) usually make the choice obvious.

**Q: What are the message size and capacity characteristics of a Storage Queue?**
> Each message can be up to **64 KB**, and a queue can hold a very large number of messages — bounded by the **storage account capacity (up to ~500 TB)**. Messages also have a configurable **time-to-live** after which they expire. For payloads larger than 64 KB, you typically store the data in Blob storage and put a **pointer (reference) to the blob** in the queue message.

**Q: How does a Storage Queue integrate with serverless processing?**
> Azure **Functions** provide a built-in **queue trigger** that automatically invokes the function for each message and **scales out** with queue depth, deleting the message on success and letting it reappear on failure. This makes Storage Queues a natural buffer for **serverless background processing**, turning a simple queue into an auto-scaling worker pipeline with no infrastructure to manage.

---

## 83.10 Summary

**Azure Storage Queues** are a **simple, durable, inexpensive** message queue within the **Storage account**, used to **decouple** producers and consumers and **level load**. Messages (up to **64 KB**) are read with a **visibility timeout** — the consumer must **delete** the message after processing, or it **reappears** (at-least-once delivery → build **idempotent** consumers). Capacity is huge, **ordering isn't guaranteed**, and access is via **key/SAS/Entra RBAC**. They pair naturally with the **Azure Functions queue trigger** for auto-scaling serverless workers. Choose Storage Queue for lightweight decoupling (≈ **SQS standard**) and **Service Bus** when you need ordering, topics, sessions, or transactions.

[↑ Back to top](#-table-of-contents)

---
---

# 84. 🧠 Azure AI Foundry
> 🟠 MEDIUM
> 📚 JD reference: "Basic understanding of **Azure AI Foundry** and AI-related Azure service setup" + "Exposure to Claude or enterprise LLM integrations"

---

## 84.1 What Problem Does This Solve?

Building AI applications means wrangling many pieces — choosing models, deploying them, grounding them on your data, testing prompts, adding safety, and monitoring usage. **Azure AI Foundry** (the evolution of Azure AI Studio) is a **unified platform to build, customize, evaluate, deploy, and manage AI/GenAI applications** — a **model catalog** (OpenAI, Meta, Mistral, and more), prompt/agent tooling, RAG on your data, content safety, and deployment endpoints, all governed under Azure security and cost controls.

Think of Azure AI Foundry like **a fully equipped film studio for AI apps**. Instead of sourcing cameras, sets, editing bays, and distribution separately, the studio provides everything in one place — a catalog of talent (models), sound stages (playgrounds), editing suites (evaluation/prompt flow), safety/compliance review, and distribution (deployed endpoints) — so you go from idea to released production efficiently.

> 💡 **If you know AWS:** Azure AI Foundry ≈ **Amazon Bedrock + parts of SageMaker Studio** — a managed catalog of **foundation models** with tooling to customize (fine-tune/RAG), evaluate, add guardrails, and deploy behind **endpoints/APIs**. The **model catalog ≈ Bedrock model access**, **content safety ≈ Bedrock Guardrails**, and project workspaces ≈ Bedrock/SageMaker projects.

---

## 84.2 Azure AI Foundry Building Blocks (Flow Diagram)

```
   AZURE AI FOUNDRY  (hub + projects)
   ┌──────────────────────────────────────────────────────────────────┐
   │ MODEL CATALOG   → Azure OpenAI (GPT), Meta Llama, Mistral, Phi, +  │
   │ PLAYGROUNDS     → test chat/prompts interactively                  │
   │ PROMPT FLOW     → build/orchestrate LLM app flows (RAG, tools)     │
   │ YOUR DATA (RAG) → ground answers on your data (Azure AI Search)    │
   │ EVALUATION      → score quality, groundedness, safety              │
   │ CONTENT SAFETY  → filter harmful content; guardrails               │
   │ AGENTS          → tool-using agents / assistants                   │
   │ DEPLOY          → managed ENDPOINTS (REST API + keys/Entra)        │
   └──────────────────────────────────────────────────────────────────┘
        Governed by: Entra RBAC · networking (private endpoints) ·
                     Monitor (usage/metrics) · cost controls

   App → calls the deployed endpoint → model responds (grounded + safe).
```

| Component | Purpose |
|---|---|
| **Hub / Project** | Collaboration + governance container for AI work |
| **Model catalog** | Foundation models to deploy (Azure OpenAI, Llama, Mistral, Phi…) |
| **Playground** | Interactive prompt/chat testing |
| **Prompt flow** | Orchestrate LLM app logic (RAG, tool calls, chaining) |
| **RAG on your data** | Ground models on your content via **Azure AI Search** |
| **Evaluation** | Measure quality, groundedness, safety of outputs |
| **Content Safety** | Filter/guardrail harmful content |
| **Deployment/endpoint** | Expose a model as a secured REST API |

⭐ AI Foundry is the **unified GenAI platform**; **Azure OpenAI** is one model provider within its catalog. It bakes in **grounding (RAG)**, **evaluation**, **content safety**, and **deployment endpoints**, all under Azure **RBAC, networking (private endpoints), and cost/monitoring** governance.

---

## 84.3 UI Steps — From Model to Endpoint

```
📍 ai.azure.com (Azure AI Foundry) → create a Hub + Project (ties to a resource group)
    ↓
📍 "Model catalog" → pick a model (e.g., an Azure OpenAI GPT model) → "Deploy"
   → creates a deployment with an ENDPOINT URL + key (or Entra auth)
    ↓
📍 "Playground" → test prompts; add "Your data" (Azure AI Search index) for RAG grounding
    ↓
📍 "Prompt flow" → build the app flow (prompt + tools + post-processing) → evaluate
    ↓
📍 "Content safety" → configure filters/guardrails
    ↓
📍 App calls the endpoint (REST) with the key/token → secure with RBAC + private endpoint
```

---

## 84.4 Integration with Other Azure Services

| Service | Role with AI Foundry |
|---|---|
| **Azure OpenAI** | Primary model provider in the catalog |
| **Azure AI Search** | Vector/semantic index for RAG grounding |
| **Azure ML** | Underlying MLOps platform (shared concepts/workspace) |
| **Key Vault** | Store endpoint keys/secrets |
| **Entra RBAC + Managed Identity** | Keyless, governed access to endpoints/data |
| **Azure Monitor** | Track usage, latency, and cost of deployments |
| **Private Endpoints / networking** | Keep AI endpoints off the public internet |

---

## 84.5 Real-World Scenario — Enterprise RAG Assistant

```
A company builds an internal assistant that answers from its own documents, securely.
   1. In AI Foundry, create a project; deploy a chat model from the catalog as an endpoint.
   2. Index the company's documents in Azure AI Search; connect it as "Your data" for RAG so
      answers are grounded (and cite sources) rather than hallucinated.
   3. Build the logic in Prompt Flow (retrieve → prompt → format), then run Evaluation to
      score groundedness and safety.
   4. Enable Content Safety filters; secure the endpoint with Entra RBAC + a private endpoint.
   5. Monitor usage/cost in Azure Monitor; store keys in Key Vault.
Result: a governed, grounded, safety-filtered GenAI assistant deployed as a secured API —
built from catalog models without managing model infrastructure.
```

---

## 84.6 Benefits

- **Unified GenAI platform** — catalog, build, evaluate, deploy in one place
- **Model choice** — many foundation models (OpenAI, Llama, Mistral, Phi…)
- **Grounding (RAG)** — accurate, source-backed answers on your data
- **Safety & evaluation** — content filters and quality scoring built in
- **Enterprise governance** — Entra RBAC, private networking, Monitor, cost controls
- **Fast path to production** — managed endpoints, no model infra to run

---

## 84.7 Common Use Cases

- Enterprise RAG chat assistants over internal data
- Prototyping and evaluating prompts/models
- Deploying GenAI features behind secure APIs
- Building tool-using agents/assistants
- Adding content safety/guardrails to AI apps

---

## 84.8 Exam/Interview Q&A

**Q: What is Azure AI Foundry and how does it relate to Azure OpenAI?**
> **Azure AI Foundry** is a **unified platform to build, customize, evaluate, deploy, and manage AI/GenAI applications**, including a **model catalog**, playgrounds, prompt flow, RAG, evaluation, content safety, and deployment endpoints. **Azure OpenAI** is **one model provider within** that catalog (GPT models). In short, AI Foundry is the end-to-end **platform/workbench**, while Azure OpenAI is a **model service** you consume through it (or directly).

**Q: How does Azure AI Foundry help ground model responses on an organization's own data?**
> Through **retrieval-augmented generation (RAG)** — you index your content (e.g., in **Azure AI Search**) and connect it as "Your data," so at query time relevant documents are retrieved and fed to the model as context. This makes answers **accurate and source-backed** rather than relying only on the model's trained knowledge, reducing hallucination and enabling citations — all configurable in the Foundry project.

**Q: What governance and security controls apply to AI Foundry deployments?**
> Deployments are governed like other Azure resources: **Entra RBAC** for access, **managed identities** for keyless auth, **private endpoints/networking** to keep endpoints off the public internet, **Key Vault** for secrets, **Content Safety** guardrails on inputs/outputs, and **Azure Monitor** for usage/latency/cost. This lets enterprises adopt GenAI while meeting security, compliance, and **cost** requirements — matching the JD's "security and cost best practices."

**Q: How would you integrate an enterprise LLM (e.g., Claude) in an Azure-centric architecture?**
> You deploy or access the model (via the **model catalog**/a provider endpoint or an external API), expose it through a **secured endpoint**, and integrate from your app using **Python** (API calls, JSON handling) with **grounding (RAG via AI Search)**, **content safety**, **Entra-based auth**, and **Monitor** for observability/cost. The pattern — catalog/endpoint + RAG + guardrails + governed access + monitoring — is the same regardless of which foundation model you choose.

---

## 84.9 Summary

**Azure AI Foundry** (formerly Azure AI Studio) is Azure's **unified platform to build, customize, evaluate, deploy, and manage AI/GenAI apps**. It provides a **model catalog** (Azure OpenAI GPT, Llama, Mistral, Phi, and more), **playgrounds**, **prompt flow**, **RAG grounding** (via **Azure AI Search**), **evaluation**, **content safety**, and managed **deployment endpoints** — all under Azure **Entra RBAC, private networking, Key Vault, Monitor, and cost** governance. **Azure OpenAI is one provider within** the catalog. The canonical pattern is **catalog model → deploy endpoint → ground with RAG → add safety/evaluation → secure with RBAC/private endpoint → monitor cost/usage**, consumed from apps (often via **Python**). It's Azure's answer to **Amazon Bedrock (+ SageMaker Studio)**.

[↑ Back to top](#-table-of-contents)

---
---

# 85. 🤖 Azure Machine Learning Workspace & Endpoints
> 🟠 MEDIUM
> 📚 JD reference (Good to Have): "Azure ML Workspace, model registry, and managed endpoints" + "MLOps / LLMOps knowledge"

---

## 85.1 What Problem Does This Solve?

Taking machine-learning models from experiment to reliable production is hard — you need somewhere to train, track experiments, version models, and serve them at scale with monitoring. **Azure Machine Learning (Azure ML)** is the managed platform for the full ML lifecycle: a **Workspace** (the central hub), **compute** for training, a **Model Registry** (versioned model storage), and **Managed Endpoints** (deploy models as scalable, monitored APIs) — the backbone of **MLOps/LLMOps** on Azure.

Think of Azure ML like **a professional kitchen + restaurant for models**. The Workspace is the whole establishment; compute clusters are the ovens (training); the Model Registry is the recipe book with versioned, approved recipes; and managed endpoints are the service window where dishes (predictions) are served to customers reliably and at scale, with health monitoring throughout.

> 💡 **If you know AWS:** Azure ML ≈ **Amazon SageMaker**. **Workspace ≈ SageMaker domain/Studio**, **Model Registry ≈ SageMaker Model Registry**, **Managed online endpoints ≈ SageMaker real-time endpoints**, **batch endpoints ≈ SageMaker batch transform**, and training compute clusters ≈ SageMaker training jobs. Both center on the end-to-end **MLOps** lifecycle.

---

## 85.2 Azure ML Building Blocks (Flow Diagram)

```
                 AZURE ML WORKSPACE  (central hub; backed by Storage, Key Vault, ACR, App Insights)
                 ┌───────────────────────────────────────────────────────────────┐
                 │ COMPUTE      → instances (dev) + clusters (train, auto-scale)    │
                 │ DATA ASSETS  → registered datasets/datastores                    │
                 │ JOBS         → training runs, pipelines (tracked experiments)    │
                 │ MODEL REGISTRY → versioned models (v1, v2 …) + lineage/metadata  │
                 │ ENVIRONMENTS → reproducible conda/docker definitions             │
                 │ ENDPOINTS    → deploy models:                                    │
                 │    • ONLINE (managed) → real-time REST API, autoscale             │
                 │    • BATCH            → score large datasets asynchronously       │
                 └───────────────────────────────────────────────────────────────┘
       MLOps: train → register (versioned) → deploy to endpoint → monitor → retrain (CI/CD).
```

| Component | Purpose |
|---|---|
| **Workspace** | Top-level hub for all ML assets (region, RBAC, linked resources) |
| **Compute** | Compute instances (dev) and clusters (scalable training) |
| **Model Registry** | Versioned, tracked models with lineage/metadata |
| **Managed online endpoint** | Real-time REST inference API with **autoscaling** + monitoring |
| **Batch endpoint** | Asynchronous scoring of large datasets |
| **Environments** | Reproducible runtime (conda/Docker) definitions |
| **Pipelines/Jobs** | Repeatable training/experiment workflows |

⭐ **Managed endpoints** let Azure handle the serving infrastructure (provisioning, scaling, health) — **online** for real-time APIs, **batch** for bulk scoring. The **Model Registry** versions models so you can promote/roll back and keep **lineage** — the heart of **MLOps**. The Workspace is governed by **Entra RBAC** and backed by Storage/Key Vault/ACR/App Insights.

---

## 85.3 UI / CLI Steps — Register & Deploy a Model

```
📍 "Azure Machine Learning" → create a Workspace (links Storage, Key Vault, ACR, App Insights)
📍 ml.azure.com (Studio) → create Compute (instance for dev, cluster for training)
    ↓
📍 Train a model (job/pipeline) → REGISTER it in the Model Registry (versioned)
    ↓
📍 Create a MANAGED ONLINE ENDPOINT → deploy the registered model version →
   get a scoring REST URL + key/token; set instance type + autoscale
    ↓
📍 Monitor: App Insights / Azure Monitor for latency, errors, data drift
```

```bash
az ml workspace create -g rg -n ml-ws --location centralindia
az ml model create -g rg -w ml-ws -n fraud-model -v 1 --path ./model
az ml online-endpoint create -g rg -w ml-ws -n fraud-ep
az ml online-deployment create -g rg -w ml-ws --endpoint-name fraud-ep \
  -n blue -f deployment.yml   # references model fraud-model:1 + instance type
```

---

## 85.4 Integration with Other Azure Services

| Service | Role with Azure ML |
|---|---|
| **Azure AI Foundry** | GenAI layer; shares ML concepts/infrastructure |
| **Storage / Key Vault / ACR / App Insights** | Backing resources for a workspace |
| **Azure DevOps / GitHub Actions** | CI/CD for MLOps (train→register→deploy) |
| **Managed identities + Entra RBAC** | Secure, keyless access to the workspace/endpoints |
| **Azure Monitor** | Endpoint metrics, logging, and data-drift monitoring |
| **Private endpoints** | Keep the workspace/endpoints private |

---

## 85.5 Real-World Scenario — MLOps for a Fraud Model

```
A team must productionize a fraud-detection model with safe updates.
   1. Train in an Azure ML Workspace on an auto-scaling compute cluster; experiments tracked.
   2. Register the best model as "fraud-model:2" in the Model Registry (versioned, with lineage).
   3. Deploy to a managed online endpoint using blue/green: new version to "green" with a
      small traffic %, validate, then shift 100% — instant rollback if metrics degrade.
   4. A CI/CD pipeline (Azure DevOps) automates train → register → deploy on each change.
   5. Azure Monitor tracks latency/errors and data drift, triggering retraining when drift
      is detected.
Result: a governed MLOps loop — versioned models, safe rollouts, autoscaled serving, and
monitoring-driven retraining.
```

---

## 85.6 Benefits

- **Full ML lifecycle** — train, track, register, deploy, monitor in one platform
- **Versioned models** — Model Registry with lineage, promotion, rollback
- **Managed serving** — online (real-time) and batch endpoints, autoscaled
- **MLOps-ready** — pipelines + CI/CD for repeatable, automated workflows
- **Governed & secure** — Entra RBAC, private endpoints, Key Vault-backed
- **Observability** — metrics, logging, and data-drift monitoring

---

## 85.7 Common Use Cases

- Training and deploying custom ML models at scale
- Real-time inference APIs (managed online endpoints)
- Bulk/offline scoring (batch endpoints)
- MLOps pipelines with versioning and CI/CD
- Monitoring and retraining on data drift

---

## 85.8 Exam/Interview Q&A

**Q: What is an Azure ML Workspace and what does it contain?**
> The **Workspace** is the **top-level hub** for Azure Machine Learning — it holds **compute**, **data assets**, **jobs/experiments**, the **model registry**, **environments**, and **endpoints**, governed by **Entra RBAC**. It's backed by linked resources (**Storage, Key Vault, Container Registry, Application Insights**). Everything in an ML project lives in and is governed through the workspace, making it the organizing boundary for the ML lifecycle.

**Q: What is the Model Registry and why is it important for MLOps?**
> The **Model Registry** stores **versioned models** (v1, v2, …) with **metadata and lineage** (which data/run produced them). It's central to **MLOps** because it enables **promotion** (e.g., staging → production), **rollback** to a known-good version, reproducibility, and auditability. Deployments reference a **specific registered version**, so you always know exactly what's serving and can revert safely.

**Q: What's the difference between a managed online endpoint and a batch endpoint?**
> A **managed online endpoint** serves **real-time, low-latency** predictions via a **REST API** with **autoscaling** and health monitoring — for interactive/synchronous inference. A **batch endpoint** performs **asynchronous scoring of large datasets** (bulk, throughput-oriented), suitable when you don't need an immediate per-request response. You choose based on whether the workload is **real-time** (online) or **bulk/offline** (batch).

**Q: How do managed endpoints support safe model rollouts?**
> Managed online endpoints support **multiple deployments behind one endpoint with traffic splitting** (e.g., **blue/green** or canary), so you can route a **small percentage** of traffic to a new model version, validate metrics, then shift to 100% — or **roll back instantly** if issues arise. Combined with **Azure Monitor** (latency/errors/drift) and CI/CD, this delivers controlled, low-risk production updates.

---

## 85.9 Summary

**Azure Machine Learning** is the managed platform for the **end-to-end ML lifecycle** (MLOps/LLMOps). The **Workspace** is the central hub (backed by Storage, Key Vault, ACR, App Insights) holding **compute**, **data**, **jobs**, **environments**, the **Model Registry** (versioned models with lineage for promotion/rollback), and **endpoints**. **Managed online endpoints** serve **real-time** autoscaled REST inference (with **traffic-split blue/green** rollouts), while **batch endpoints** score large datasets asynchronously. It's governed by **Entra RBAC** and **private networking**, integrates with **CI/CD** for automated **train→register→deploy**, and uses **Azure Monitor** for metrics and **data-drift**-driven retraining. It's Azure's equivalent of **Amazon SageMaker**.

[↑ Back to top](#-table-of-contents)

---
---

# 86. 🏗️ Terraform on Azure
> 🔴 FULL
> 📚 JD reference (Mandatory): "Strong knowledge of Terraform — Terraform state, plan/apply, troubleshooting failures, migration risks, Terraform Enterprise concepts" (Screening Priority)

---

## 86.1 What Problem Does This Solve?

ARM and Bicep are **Azure-only** IaC. Many organizations standardize on **Terraform** — a **cloud-agnostic**, declarative Infrastructure-as-Code tool by HashiCorp — to provision Azure (and multi-cloud/SaaS) resources with one workflow and language (**HCL**). Terraform describes desired state, computes a **plan** of changes, and **applies** it, tracking what it manages in **state**. The JD makes Terraform a **top mandatory skill**, so understanding its model, workflow, state, and failure/migration risks is essential.

Think of Terraform like **a universal, meticulous general contractor with a detailed ledger**. You hand it blueprints (HCL); it compares them to its ledger of what's already built (**state**), shows you exactly what it will add/change/demolish (**plan**), and — on your approval — executes (**apply**). The ledger is critical: lose or corrupt it and the contractor forgets what it built.

> 💡 **If you know AWS:** Terraform is the **same tool you'd use for AWS** (the `aws` provider) — here with the **`azurerm` provider**. Compared to Azure-native IaC, Terraform ≈ a cloud-agnostic **CloudFormation/Bicep alternative** with its own **state** model (unlike ARM/Bicep, which are stateless because Azure is the source of truth). **Terraform Cloud/Enterprise ≈ a managed backend + collaboration/governance layer** (remote state, runs, policy-as-code).

---

## 86.2 Core Workflow & State (Flow Diagram)

```
   Write HCL (.tf)                 →  terraform init   (download providers + configure backend)
        │                                    │
        ▼                                    ▼
   terraform plan   ── compares DESIRED (HCL) vs STATE vs REAL Azure ──► shows +/~/- changes
        │  (review carefully — the safety gate)
        ▼
   terraform apply  ── makes the changes, then UPDATES state ──►  Azure resources
        │
        ▼
   terraform destroy  ── tears down everything in state (use with care)

   STATE (terraform.tfstate): Terraform's RECORD of what it manages (resource IDs → config).
     • Local by default — risky for teams (no locking, can be lost, holds SECRETS).
     • REMOTE BACKEND (Azure Storage / Terraform Cloud) → shared + STATE LOCKING + encrypted.

   Key files/blocks:  provider "azurerm" {}  ·  resource "azurerm_*" {}  ·
                      variables/outputs  ·  modules  ·  backend config
```

| Concept | Meaning |
|---|---|
| **HCL** | HashiCorp Configuration Language (the `.tf` files) |
| **Provider** | Plugin for a platform — **`azurerm`** for Azure |
| **`init`** | Download providers, set up the backend |
| **`plan`** | Preview add/change/destroy **before** applying (the safety gate) |
| **`apply`** | Execute the plan and update state |
| **`destroy`** | Remove all managed resources |
| **State** | Terraform's record of managed resources (maps config → real IDs) |
| **Remote backend** | Shared state with **locking** (Azure Storage, Terraform Cloud/Enterprise) |
| **Module** | Reusable, parameterized set of resources |

⭐ **State is the heart of Terraform** — it's how Terraform knows what it manages. Keep it in a **remote backend with locking** (never local for teams), treat it as **sensitive** (it can contain secrets), and **never hand-edit** it. `plan` is the **critical review step**; drift (out-of-band changes) and state issues are the top sources of failures.

---

## 86.3 State, Troubleshooting & Migration Risks (JD Focus)

```
TROUBLESHOOTING common failures:
   • State drift        → someone changed a resource in the portal → plan shows unexpected
                          changes → `terraform refresh`/re-plan, or import the real state.
   • State lock stuck   → a crashed run holds the lock → `terraform force-unlock <id>` (carefully).
   • Resource exists    → "already exists" error → `terraform import` the existing resource
                          into state instead of recreating.
   • Provider/auth      → wrong subscription/credentials → check `az login`/ARM_* env vars,
                          provider version pinning.
   • Dependency/ordering→ use `depends_on`; read the error's resource address.

MIGRATION RISKS (why plans can be dangerous):
   • A change may force REPLACE (-/+) → destroys & recreates (data loss / downtime!) →
     always READ THE PLAN for "forces replacement".
   • Moving/renaming resources → use `moved {}` blocks or `terraform state mv` to avoid
     destroy+create.
   • State file corruption/loss → back up remote state; enable versioning on the backend.
   • Upgrading providers/Terraform versions → review breaking changes; test in non-prod.
```

---

## 86.4 UI / CLI Steps — Provision Azure with Terraform

```hcl
# main.tf
terraform {
  required_providers { azurerm = { source = "hashicorp/azurerm", version = "~> 3.100" } }
  backend "azurerm" {                      # REMOTE STATE + locking
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestore2026"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
provider "azurerm" { features {} }

resource "azurerm_resource_group" "rg" {
  name     = "app-rg"
  location = "centralindia"
}
resource "azurerm_storage_account" "sa" {
  name                     = "appstore2026"
  resource_group_name      = azurerm_resource_group.rg.name   # implicit dependency
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
output "sa_id" { value = azurerm_storage_account.sa.id }
```
```bash
az login                        # authenticate the azurerm provider
terraform init                  # download azurerm + configure the backend
terraform plan -out=tfplan      # PREVIEW changes (review "forces replacement"!)
terraform apply tfplan          # apply the reviewed plan
terraform import azurerm_resource_group.rg /subscriptions/<sub>/resourceGroups/app-rg  # adopt existing
terraform state list            # inspect what Terraform manages
terraform destroy               # tear down (careful!)
```

---

## 86.5 Integration with Other Azure Services

| Service | Role with Terraform |
|---|---|
| **Azure Storage (backend)** | Stores remote state + provides **state locking** (via blob lease) |
| **Entra ID / Service Principal / Managed Identity** | Auth for the `azurerm` provider (esp. in CI/CD) |
| **Azure DevOps / GitHub Actions / Harness** | Run `init/plan/apply` in CI/CD pipelines |
| **Key Vault** | Source secrets instead of hardcoding in `.tf`/state |
| **Terraform Cloud/Enterprise** | Managed remote state, runs, **policy-as-code (Sentinel)**, RBAC |
| **Azure Policy** | Complements Terraform — enforces compliance on what's deployed |

---

## 86.6 Real-World Scenario — Team IaC with Safe Changes

```
A team manages Azure infrastructure as code with Terraform, safely and collaboratively.
   1. State lives in an Azure Storage backend (versioned + locking) so concurrent runs can't
      corrupt it; secrets come from Key Vault, never hardcoded.
   2. Changes flow through Git + a CI/CD pipeline: `terraform plan` runs on pull requests so
      reviewers SEE exactly what will change (and catch any "forces replacement" that would
      destroy data).
   3. `apply` runs only after approval, using a service principal scoped with least privilege.
   4. An existing resource created manually is adopted via `terraform import` rather than
      recreated; a renamed resource uses a `moved {}` block to avoid destroy+create.
   5. Terraform Enterprise adds remote runs, policy-as-code guardrails, and audit.
Result: repeatable, reviewed, locked, auditable infrastructure changes with minimal risk of
accidental destruction — exactly the Terraform competencies the JD screens for.
```

---

## 86.7 Benefits

- **Cloud-agnostic IaC** — one tool/workflow for Azure + multi-cloud/SaaS
- **Explicit plan step** — preview and review changes before applying
- **State-driven** — tracks managed resources, detects drift
- **Reusable modules** — compose infrastructure from vetted building blocks
- **Collaboration & governance** — remote backends, locking, Terraform Enterprise policy-as-code
- **Large ecosystem** — thousands of providers and community modules

---

## 86.8 Common Use Cases

- Provisioning and managing Azure infrastructure as code
- Multi-cloud / hybrid IaC under one workflow
- CI/CD-driven infrastructure changes with plan-review gates
- Enterprise governance with Terraform Cloud/Enterprise (remote state + Sentinel policies)
- Importing and standardizing existing resources under IaC

---

## 86.9 Exam/Interview Q&A

**Q: What is Terraform state, and why is it so important?**
> **State** (`terraform.tfstate`) is Terraform's **record of the resources it manages**, mapping your configuration to **real resource IDs**. It's essential because Terraform uses it to compute **diffs** (plan) and know what already exists — without it, Terraform can't tell what to create, change, or destroy. State should be stored in a **remote backend with locking** (e.g., Azure Storage), treated as **sensitive** (it can hold secrets), **backed up/versioned**, and **never hand-edited**, since corruption or loss can break management of live infrastructure.

**Q: What's the difference between `terraform plan` and `terraform apply`, and why review the plan?**
> **`plan`** computes and **previews** the changes (add `+`, change `~`, destroy `-`) needed to reach the desired state — without making any changes. **`apply`** executes those changes and updates state. Reviewing the plan is critical because it reveals **destructive operations** — especially **"forces replacement" (`-/+`)**, where a resource is **destroyed and recreated** (risking **data loss/downtime**). The plan is the safety gate; applying without reading it is how accidents happen.

**Q: A Terraform apply fails because the resource "already exists." How do you resolve it?**
> The resource exists in Azure but **not in Terraform's state**, so Terraform tries to create it and conflicts. The fix is **`terraform import`** — bring the existing resource **into state** (mapping it to the config address), after which `plan` will reconcile config vs reality. This adopts the resource under Terraform management instead of recreating it. (Going forward, avoid out-of-band/manual creation of resources Terraform should own.)

**Q: What are the main migration/change risks in Terraform and how do you mitigate them?**
> The biggest is a change that **forces replacement** (destroy + recreate), risking **data loss/downtime** — mitigate by **reading the plan** and using `lifecycle`/design to avoid it. **Renaming/moving** resources can cause destroy+create — use **`moved {}` blocks** or **`terraform state mv`** to preserve them. **State loss/corruption** — use a **versioned remote backend** and backups. **Provider/Terraform version upgrades** can introduce breaking changes — **pin versions** and test in **non-prod** first. A **stuck lock** from a crashed run is cleared with **`force-unlock`** (carefully).

**Q: What is Terraform Enterprise (or Terraform Cloud) and what does it add over open-source Terraform?**
> **Terraform Cloud/Enterprise** is HashiCorp's **managed platform** that adds **remote state storage with locking**, **remote runs** (consistent `plan`/`apply` execution), **collaboration/RBAC**, **VCS integration**, **private module registry**, and **policy-as-code (Sentinel/OPA)** to enforce governance guardrails before apply. **Enterprise** is the self-hosted/advanced tier for larger orgs (SSO, audit, private networking). It addresses the **team/governance** gaps of running open-source Terraform with local state and manual coordination.

**Q: How does Terraform authenticate to Azure, especially in automation?**
> Via the **`azurerm` provider**, using **`az login`** (interactive/dev), or — in CI/CD — a **service principal** (client ID/secret or cert via `ARM_*` environment variables) or a **managed identity** on the build agent. For least privilege, the principal is scoped with only the needed **RBAC** at the appropriate scope. Managed identity is preferred where available since it avoids storing secrets, aligning with the JD's security best practices.

---

## 86.10 Summary

**Terraform** is a **cloud-agnostic, declarative IaC** tool (HCL) that provisions Azure via the **`azurerm` provider**. Its workflow is **`init` → `plan` (preview) → `apply` (execute) → (`destroy`)**, and its defining feature is **state** — the record of managed resources that drives diffs and drift detection. For teams, keep state in a **remote backend with locking** (Azure Storage or Terraform Cloud/Enterprise), treat it as **sensitive**, version it, and **never hand-edit** it. The JD's focus areas: **always read the plan** (watch for **"forces replacement"** → data loss), resolve "already exists" with **`terraform import`**, handle renames with **`moved {}`/`state mv`**, clear stuck locks with **`force-unlock`**, and **pin provider/Terraform versions**. **Terraform Enterprise/Cloud** adds remote runs, RBAC, and **policy-as-code**. Unlike ARM/Bicep (stateless, Azure-only), Terraform is **state-based and multi-cloud** — which is exactly why it's a top screening skill for this role.

[↑ Back to top](#-table-of-contents)

---
---

## 🏁 You've reached the end — 80 AZ-104 topics + 6 JD-aligned additions

This single file covers the entire **Alan Rodrigues AZ-104** course across all 12 sections, from Azure fundamentals through Compute, Networking, Storage, PowerShell/CLI, ARM, Bicep, Identity & Governance, and Monitor & Backup — plus a **JD-Aligned Additions** section (**Event Hubs, Event Grid/Event Subscriptions, Storage Queues, Azure AI Foundry, Azure ML, and Terraform**) covering Azure services/skills required by the target job description. Each topic merges the depth-tier study format (💡 AWS anchors, flow diagrams, 📍 UI/CLI steps, Exam/Interview Q&A) with analogies, integration tables, real-world scenarios, benefits, and common use cases.

> **JD skills that are NOT Azure resources** (so they're referenced within topics rather than given their own resource sections): **Python** for API integration/automation/JSON-YAML (used throughout AI Foundry, ML, and Terraform/CI-CD tooling), **CI/CD pipelines** and **pipeline troubleshooting** (Azure DevOps/GitHub Actions/**Harness** — run `terraform`/deployments as shown in topics 55–61 and 86), and **agentic AI / LangGraph / LangChain / Claude** concepts (built on top of **Azure AI Foundry**, topic 84). If you'd like, these can be written up as their own dedicated skill topics too.

**How to use these notes:** work section by section, do the hands-on 📍 labs in a free Azure account, and drill the **Exam Q&A** blocks the week before your test. Focus your heaviest revision on the 🔴 FULL topics (VMs, VNet/NSG, Load Balancer, Storage Accounts/Blob/Authorization, Private Endpoints, Entra ID, RBAC, Azure Policy, Azure Monitor, Log Analytics, Azure Backup) since they map to the most heavily weighted exam domains.

Good luck on the AZ-104! 🚀

[↑ Back to top](#-table-of-contents)













