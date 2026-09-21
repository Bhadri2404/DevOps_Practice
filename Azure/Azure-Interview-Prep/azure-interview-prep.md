# 🎯 Azure Interview Prep — Senior DevOps Engineer (Endava)

> **Purpose:** Focused, interview-ready notes for an Azure (primary) + AWS DevOps role
> **Assumes:** You already know cloud/DevOps fundamentals and AWS — every topic includes a 💡 "If you know AWS" anchor
> **Every section includes:** a flow diagram, hands-on UI/CLI steps (with 📍 click-paths), a real-world example, and (for key topics) interview Q&A
> **Depth tiers:** 🔴 Full · 🟠 Medium · 🟡 Know-this-much — but UI steps + flow diagrams appear in ALL sections

---

# 📋 TABLE OF CONTENTS

### 🌱 Foundations
1. [Azure Hierarchy — Management Groups, Subscriptions, Resource Groups](#1--azure-hierarchy--management-groups-subscriptions-resource-groups) 🟠
2. [Azure Resource Manager (ARM)](#2--azure-resource-manager-arm) 🟠

### 🔐 Identity & Access
3. [Microsoft Entra ID — Core + Features](#3--microsoft-entra-id--core--features) 🔴
4. [Azure RBAC](#4--azure-rbac) 🔴
5. [Service Principals](#5--service-principals) 🔴
6. [Managed Identities (System vs User-assigned)](#6--managed-identities-system-vs-user-assigned) 🔴
7. [Workload Identity Federation (WIF) / OIDC](#7--workload-identity-federation-wif--oidc) 🔴
8. [Conditional Access & PIM](#8--conditional-access--pim) 🟡

### 🌐 Networking
9. Networking Fundamentals (IP, CIDR, ports) 🟠
10. Virtual Network (VNet) 🔴
11. Subnets 🔴
12. Network Security Groups (NSG) 🔴
13. Application Security Groups (ASG) 🟠
14. Route Tables / UDR 🟠
15. Service Endpoints 🟠
16. Private Endpoints 🔴
17. VNet Peering 🟠
18. Hub-and-Spoke Topology 🔴
19. Azure Virtual WAN 🟡
20. NAT Gateway 🟡
21. Azure DNS — Public Zones 🟡
22. Azure DNS — Private Zones 🟠
23. Azure Load Balancer 🟠
24. Application Gateway 🟠
25. Web Application Firewall (WAF) 🟡
26. Azure Firewall 🟠
27. DDoS Protection 🟡
28. Network Watcher 🟡
29. Connection Monitor 🟡
30. VPN Gateway 🟡
31. ExpressRoute 🟡

### 🔑 Secrets
32. Azure Key Vault 🔴
33. Key Vault Integrations (Pipelines, AKS, ACR, Managed Identity) 🔴

### 🛠️ Azure DevOps & CI/CD
34. Azure DevOps Overview 🟠
35. Azure DevOps Permissions & Security 🔴
36. Git Branching Strategies 🔴
37. Branch Policies & Branch Protection 🔴
38. Pull Request Workflow & Code Reviews 🟠
39. Service Connections 🔴
40. Azure Pipelines — YAML Deep Dive 🔴
41. Multi-Stage Pipeline Design (Dev→QA→Staging→Prod) 🔴
42. Pipeline Variables, Variable Groups & Templates 🔴
43. Pipeline Caching & Artifacts 🟡
44. Azure DevOps Agents (Microsoft-hosted vs Self-hosted) 🟠
45. Environments 🟠
46. Approvals & Checks / Release Gates 🔴
47. Azure Boards ↔ Repos/GitHub Traceability 🟡

### 🏗️ Infrastructure as Code
48. ARM Templates 🟡
49. Bicep 🟠
50. Terraform + Azure DevOps 🔴
51. Terraform State Locking & Remote Backend 🔴
52. Terraform Modules & Reusability 🟠
53. IaC in CI/CD with Plan Approval Gates 🟠

### 📦 Containers
54. Dockerfile Best Practices & Multi-Stage Builds 🟠
55. Azure Container Registry (ACR) 🔴
56. Azure Kubernetes Service (AKS) 🔴
57. AKS Ingress Controllers 🟠
58. AKS Persistent Volumes & Storage 🟡
59. Helm 🟠
60. AKS Autoscaling (Cluster Autoscaler + HPA) 🟠

### 🔁 Integrations
61. GitHub → Azure (Actions, OIDC, branch policies) 🔴
62. Jenkins → Azure 🟠

### 🚀 Deployment & Observability
63. Deployment Strategies — Blue/Green 🔴
64. Deployment Strategies — Canary, Rolling & Rollback 🔴
65. Feature Flags & Azure App Configuration 🟠
66. Azure Monitor & Metrics 🟠
67. Log Analytics & KQL Basics 🔴
68. Application Insights & Distributed Tracing 🟠
69. Alerting Strategy & Incident Response 🟡
70. SLI / SLO / SLA & Error Budgets 🟡
71. DevSecOps on Azure 🔴
72. AI-Assisted DevOps (AIOps) 🟠

### 🔥 Production Cross-Cutting
73. Tagging & Naming Conventions 🟡
74. Azure Landing Zones 🟡
75. Cost Management & FinOps Basics 🟡
76. Disaster Recovery & Backup (RTO/RPO) 🟡

### 🎯 Interview Prep
77. Compute Essentials (VM, VMSS, App Service, Slots) 🟠
78. Storage Essentials (Storage Account, Blob, SAS, tiers) 🟡
79. All 10 Integration Flows Consolidated 🔴
80. Rapid-Fire Interview Q&A 🔴
81. Final Quick Reference (numbers, AWS↔Azure table, one-liners) 🔴

---
---

# 1. 🏢 Azure Hierarchy — Management Groups, Subscriptions, Resource Groups
> 🟠 MEDIUM

---

## 1.1 What Problem Does This Solve?

A real organization doesn't just have a handful of cloud resources — it has thousands, spread across many teams, projects, and environments (dev, test, production). Without structure, this becomes chaos: nobody knows who owns what, billing is impossible to break down, and access control is a nightmare.

Azure solves this with a **four-level hierarchy** that organizes everything from the very top of your organization down to a single resource.

> 💡 **If you know AWS:** Azure's hierarchy maps roughly to: Management Group ≈ AWS Organizations OU, Subscription ≈ AWS Account, Resource Group ≈ (no direct AWS equal — closest is a tag/grouping convention), Resource ≈ Resource. The big mental shift: in AWS you separate things using multiple *accounts*; in Azure you separate using multiple *subscriptions* under one identity (Entra ID) tenant.

---

## 1.2 The Four Levels (Flow Diagram)

```
┌─────────────────────────────────────────────────────────┐
│  MANAGEMENT GROUP                                        │
│  (organizes many subscriptions; apply policy/access once │
│   and it cascades down to everything below)              │
│                                                          │
│   ┌───────────────────────────────────────────────┐    │
│   │  SUBSCRIPTION                                   │    │
│   │  (billing boundary + access boundary +          │    │
│   │   quota/limit boundary)                          │    │
│   │                                                  │    │
│   │   ┌──────────────────────────────────────┐     │    │
│   │   │  RESOURCE GROUP                        │     │    │
│   │   │  (logical folder for related resources │     │    │
│   │   │   — delete the group, delete it all)   │     │    │
│   │   │                                         │     │    │
│   │   │   ┌────────────┐  ┌────────────┐       │     │    │
│   │   │   │ RESOURCE   │  │ RESOURCE   │       │     │    │
│   │   │   │ (a VM)     │  │ (a VNet)   │  ...  │     │    │
│   │   │   └────────────┘  └────────────┘       │     │    │
│   │   └──────────────────────────────────────┘     │    │
│   └───────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘

Anything you set at a HIGHER level (policy, access) automatically
flows DOWN to everything beneath it.
```

| Level | What It Is | Real Purpose |
|---|---|---|
| **Management Group** | A container for multiple subscriptions | Apply governance (Policy, RBAC) across many subscriptions at once |
| **Subscription** | The billing + access + quota boundary | Separate billing/access per environment or team (e.g., "Prod" vs "Dev" subscriptions) |
| **Resource Group** | A logical folder for related resources | Group everything for one app/project; manage & delete together |
| **Resource** | A single thing (VM, Storage Account, VNet) | The actual stuff you deploy |

---

## 1.3 Key Rules to Remember (Interview-Relevant)

```
✅ A Resource belongs to exactly ONE Resource Group (but can be moved)
✅ A Resource Group belongs to exactly ONE Subscription
✅ Deleting a Resource Group deletes EVERYTHING inside it (permanently!)
✅ A Resource Group has a region, but resources inside it can be in
   DIFFERENT regions (the RG's region only stores its metadata)
✅ Billing is tracked per Subscription — so orgs often use separate
   subscriptions for Prod / Dev / Test to cleanly separate costs
✅ Policy or RBAC applied at Management Group level cascades to ALL
   subscriptions & resources underneath it
```

---

## 1.4 UI Steps — Creating a Resource Group in the Portal

```
📍 START: portal.azure.com
    ↓
In the top search bar, type "Resource groups" → click it
    ↓
Click "+ Create" (top-left)
    ↓
   ┌──────────────────────────────────────────┐
   │ Subscription:   [choose your subscription] │
   │ Resource group: myapp-prod-rg              │
   │ Region:         Central India              │
   └──────────────────────────────────────────┘
    ↓
Click "Review + Create" → "Create"

📍 RESULT: You now have an empty Resource Group ready to hold your
   app's resources (VMs, databases, networking, etc.)
```

**CLI equivalent:**
```bash
az group create --name myapp-prod-rg --location centralindia
```

---

## 1.5 Real-World Example

**Situation:** Your company is starting a new customer portal project and wants clean cost separation and access control across environments.

```
Management Group: "Contoso"
    │
    ├── Subscription: "Contoso-Production"
    │       └── Resource Group: "customerportal-prod-rg"
    │             ├── VM, VNet, Azure SQL, App Gateway (all Production)
    │
    └── Subscription: "Contoso-NonProd"
            ├── Resource Group: "customerportal-dev-rg"
            └── Resource Group: "customerportal-test-rg"

Why this structure?
- Finance can see EXACTLY what Production costs vs Non-Prod (separate subscriptions)
- Developers get access to the NonProd subscription only — they literally
  cannot touch Production
- When the project ends, delete the resource groups → everything cleaned
  up instantly, no forgotten resources billing you
```

---

## 1.6 Interview Q&A

**Q: What's the difference between a Subscription and a Resource Group?**
> A Subscription is the billing and access boundary — it's how Azure separates costs and quotas, and organizations often use separate subscriptions per environment. A Resource Group is a logical folder *within* a subscription that groups related resources for a single app or project, allowing you to manage and delete them together.

**Q: Why would an organization use multiple subscriptions?**
> To cleanly separate billing (e.g., see Production costs vs Dev costs), to separate access (developers get the Dev subscription, not Prod), and to work within per-subscription quota limits. Management Groups then let you apply governance policies across all of them at once.

**Q: What happens when you delete a Resource Group?**
> Everything inside it is permanently deleted. This is powerful for cleaning up test environments in one action, but dangerous in production — always double-check before deleting.

---

## 1.7 Summary

Azure organizes everything into a four-level hierarchy: **Management Group → Subscription → Resource Group → Resource.** Subscriptions are the billing/access boundary (orgs use separate ones for Prod/Dev/Test), Resource Groups are logical folders grouping an app's resources for shared management and deletion, and governance applied at higher levels cascades down. Master this hierarchy — it underpins how permissions (RBAC), policies, and costs work throughout Azure.

---
---

# 2. ⚙️ Azure Resource Manager (ARM)
> 🟠 MEDIUM

---

## 2.1 What Problem Does This Solve?

You can interact with Azure in many ways — the Portal (clicking), the CLI (`az` commands), PowerShell, or Infrastructure-as-Code tools (Bicep, Terraform). Without a common layer underneath, each of these could behave differently, apply different security rules, or produce inconsistent results.

**Azure Resource Manager (ARM)** is the single management layer that ALL of these go through — guaranteeing consistent behavior, security, and organization no matter how you interact with Azure.

> 💡 **If you know AWS:** ARM is roughly the equivalent of the AWS control plane / CloudFormation engine combined — it's the thing that actually receives your "create this resource" requests and orchestrates carrying them out, with consistent auth (RBAC) applied throughout.

---

## 2.2 ARM as the "Front Desk" (Flow Diagram)

```
   Azure Portal (clicking)  ─┐
   Azure CLI (az commands)  ─┤
   PowerShell (Az module)   ─┼──►  ┌─────────────────────────┐
   REST API (direct calls)  ─┤     │  AZURE RESOURCE MANAGER  │
   Bicep / ARM Templates    ─┤     │         (ARM)            │
   Terraform (azurerm)      ─┘     │  • Authenticates (RBAC)  │
                                    │  • Validates request     │
                                    │  • Orchestrates creation │
                                    │  • Handles dependencies  │
                                    └───────────┬─────────────┘
                                                ↓
                          ┌─────────────────────────────────────┐
                          │   RESOURCE PROVIDERS                  │
                          │  Microsoft.Compute   (VMs)            │
                          │  Microsoft.Storage   (Storage)        │
                          │  Microsoft.Network   (VNet, NSG, LB)  │
                          │  Microsoft.KeyVault  (Key Vault)      │
                          └─────────────────────────────────────┘

No matter which "door" you enter through, you all reach the SAME front
desk (ARM), which applies the SAME rules and talks to the actual
backend services (Resource Providers).
```

---

## 2.3 Key ARM Concepts

### Resource Providers
Each Azure service is represented by a provider namespace, e.g.:
- `Microsoft.Compute` → Virtual Machines
- `Microsoft.Storage` → Storage Accounts
- `Microsoft.Network` → VNets, NSGs, Load Balancers

*(These namespaces show up constantly in RBAC custom roles and policy definitions — worth recognizing.)*

### Resource ID
Every resource has a unique ID that reads like a file path:
```
/subscriptions/{sub-id}/resourceGroups/{rg-name}/providers/{provider}/{type}/{name}

Example:
/subscriptions/abc-123/resourceGroups/prod-rg/providers/Microsoft.Compute/virtualMachines/web-vm-01
```

### Declarative Deployment
With ARM/Bicep, you describe **what** you want (the end state), not the step-by-step **how**. ARM figures out the correct order and dependencies automatically (e.g., it knows a VNet must exist before a VM that plugs into it).

### Tags
Key-value labels on resources for organizing and cost-tracking (e.g., `Environment=Production`, `Owner=team@company.com`). Covered fully in Section 73.

---

## 2.4 UI Steps — Seeing ARM in Action (View a Resource's ARM Details)

```
📍 START: portal.azure.com → open any resource (e.g., a Virtual Machine)
    ↓
In the resource's left-hand menu, scroll down to "Automation"
    ↓
Click "Export template"
    ↓
📍 RESULT: You see the ARM Template (JSON) that Azure would use to
   recreate this exact resource — proving that everything in Azure is,
   under the hood, an ARM resource definition. You can download this
   and reuse it to recreate the resource elsewhere.
```

**CLI equivalent (see a resource's full ARM representation):**
```bash
az resource show --ids "/subscriptions/.../virtualMachines/web-vm-01"
```

---

## 2.5 Real-World Example

**Situation:** A developer accidentally deleted a critical Storage Account's configuration, and the team wants to understand exactly how it was set up to recreate it identically.

```
Step 1: Because everything in Azure goes through ARM, the team goes to
        the resource → "Export template" → gets the exact ARM JSON
        definition.

Step 2: They now have a precise, reusable blueprint of that resource's
        configuration.

Step 3: Going forward, they commit these templates (or better, convert
        to Bicep — Section 49) into Git, so infrastructure is
        version-controlled and can be recreated consistently, rather
        than relying on remembering what was clicked in the Portal.

This is the gateway concept to Infrastructure as Code (Sections 48-53).
```

---

## 2.6 Interview Q&A

**Q: What is Azure Resource Manager?**
> It's the management/deployment layer that every interaction with Azure goes through — Portal, CLI, PowerShell, Bicep, Terraform all send their requests to ARM, which authenticates them (via RBAC), validates them, handles resource dependencies, and orchestrates the actual creation through Resource Providers. This ensures consistent behavior and security regardless of the tool used.

**Q: What's a Resource Provider?**
> A namespace representing an Azure service — like `Microsoft.Compute` for VMs or `Microsoft.Storage` for storage. ARM routes your request to the appropriate provider to actually fulfill it.

**Q: What does "declarative" mean in the context of ARM/Bicep?**
> You describe the desired end state ("I want these resources configured this way"), and ARM figures out the how — the correct order, dependencies, and API calls — automatically, rather than you scripting each step imperatively.

---

## 2.7 Summary

Azure Resource Manager (ARM) is the consistent management layer beneath everything in Azure — every tool (Portal, CLI, PowerShell, Bicep, Terraform) sends requests through ARM, which applies uniform authentication (RBAC), validation, and dependency handling before routing to the appropriate Resource Provider. Because of ARM, your security rules, tags, and organizational structure work identically no matter how you interact with Azure — and it's the foundation that makes Infrastructure as Code possible.

---
---

# 3. 🔐 Microsoft Entra ID — Core + Features
> 🔴 FULL

---

## 3.1 What Problem Does This Solve?

Every organization needs to answer one fundamental question constantly: **"Who is this, and should they be allowed in?"** Whether it's an employee logging into the Azure Portal, an application authenticating to a database, or a CI/CD pipeline deploying resources — something needs to verify identity before granting any access.

**Microsoft Entra ID** (formerly **Azure Active Directory / Azure AD** — both names still used everywhere) is Azure's cloud identity service: the central directory of every user, group, and application identity in your organization, and the system that authenticates them.

> 💡 **If you know AWS:** Entra ID is like AWS IAM's identity side + AWS SSO/Identity Center + a full directory service, combined. Key difference: in AWS, IAM handles both *who you are* and *what you can do*. In Azure, these are **split** — Entra ID handles **authentication (who you are)**, and RBAC (Section 4) handles **authorization (what you can do)**. Keep these two separate in your head — interviewers test it.

---

## 3.2 Authentication vs Authorization (The Core Split)

```
┌────────────────────────────────────────────────────────────┐
│  AUTHENTICATION  →  "Who are you?"                          │
│  Handled by: MICROSOFT ENTRA ID                             │
│  Example: You log in with username + password + MFA         │
│           → Entra ID confirms "Yes, this is Sarah"          │
└────────────────────────────────────────────────────────────┘
                            ↓ (identity confirmed)
┌────────────────────────────────────────────────────────────┐
│  AUTHORIZATION   →  "What are you allowed to do?"           │
│  Handled by: AZURE RBAC (Section 4)                         │
│  Example: RBAC checks "Sarah has Contributor on dev-rg"     │
│           → She can create resources there, but not in Prod │
└────────────────────────────────────────────────────────────┘
```

---

## 3.3 Core Building Blocks

### Tenant
Your organization's dedicated, isolated instance of Entra ID. One tenant = one organization's identity boundary. Multiple Azure subscriptions can trust the same tenant.

### Users
Identities for people. Two types:
- **Cloud-only** — created directly in Entra ID
- **Synced/Hybrid** — synced from an on-premises Active Directory via **Azure AD Connect** (common in enterprises that already had on-prem AD)

### Groups
Collections of users (or devices). Assign access to a *group*, and all members inherit it. Two types:
- **Security Groups** — for controlling access to resources
- **Microsoft 365 Groups** — for collaboration (Teams, SharePoint)

Membership can be **Assigned** (manual) or **Dynamic** (rule-based, e.g., "everyone with department = Engineering is auto-added").

### Service Principals & App Registrations
Identities for *applications* (not people) — covered in depth in Section 5.

---

## 3.4 Key Entra ID Features (Production-Relevant)

| Feature | What It Does | Why Orgs Use It |
|---|---|---|
| **MFA (Multi-Factor Auth)** | Requires a 2nd proof (phone app, SMS) beyond password | Blocks ~99% of account-takeover attacks even if password is stolen |
| **Conditional Access** | Context-aware access rules (Section 8) | "Require MFA if signing in from outside the office network" |
| **PIM (Privileged Identity Management)** | Just-in-time, time-limited admin access (Section 8) | Nobody has standing admin rights — they request it when needed |
| **Identity Protection** | ML-based risky sign-in detection | Auto-flags "impossible travel," leaked-credential logins |
| **App Registrations** | Register apps that need to authenticate | Enables Service Principals, OIDC, API access |
| **SSO (Single Sign-On)** | One login for many apps | Employees log in once, access everything |

---

## 3.5 UI Steps — Creating a User and a Group in Entra ID

```
📍 START: portal.azure.com
    ↓
In the top search bar, type "Microsoft Entra ID" → click it
    ↓
── To create a USER ──
Left menu → "Users" → "+ New user" → "Create new user"
    ↓
   ┌────────────────────────────────────┐
   │ User principal name: sarah@contoso  │
   │ Display name:        Sarah Lee       │
   │ Password:            (auto-generate) │
   └────────────────────────────────────┘
    ↓
Click "Review + create" → "Create"

── To create a GROUP ──
Left menu → "Groups" → "+ New group"
    ↓
   ┌────────────────────────────────────┐
   │ Group type:  Security               │
   │ Group name:  DevOps-Engineers        │
   │ Members:     [add Sarah and others]  │
   └────────────────────────────────────┘
    ↓
Click "Create"

📍 RESULT: You have a user (Sarah) and a security group (DevOps-Engineers)
   with Sarah as a member. Next, you'd assign an RBAC role to the GROUP
   (Section 4), and Sarah automatically inherits it.
```

---

## 3.6 UI Steps — Enforcing MFA (via Conditional Access)

```
📍 START: portal.azure.com → search "Microsoft Entra ID" → open it
    ↓
Left menu → "Security" → "Conditional Access"
    ↓
Click "+ New policy"
    ↓
   ┌──────────────────────────────────────────────┐
   │ Name:          Require MFA for all users       │
   │ Users:         All users                       │
   │ Target:        All cloud apps                  │
   │ Grant control: Require multifactor authentication │
   └──────────────────────────────────────────────┘
    ↓
Set "Enable policy" = On → click "Create"

📍 RESULT: Every user must now complete MFA when signing in — one of the
   single highest-impact security improvements any org can make.
```

---

## 3.7 Real-World Example

**Situation:** A new employee, Sarah, joins the DevOps team. Instead of manually granting her dozens of individual permissions, the org uses group-based access.

```
Step 1: Create Sarah's user account in Entra ID (authentication — she can
        now log in).

Step 2: Add Sarah to the "DevOps-Engineers" security group.

Step 3: That group already has an RBAC role assignment: "Contributor on
        the Dev subscription" (authorization). Sarah instantly inherits
        exactly the right access — no manual per-resource permission setup.

Step 4: Conditional Access requires her to set up MFA on first login.

Step 5: When Sarah eventually leaves, removing her from the group instantly
        revokes all that access — no risk of forgotten leftover permissions.

This "authenticate via Entra ID, authorize via RBAC group membership"
pattern is how real organizations manage access at scale.
```

---

## 3.8 Interview Q&A

**Q: What's the difference between Entra ID and RBAC?**
> Entra ID handles authentication — proving *who* you are (username, password, MFA). RBAC handles authorization — deciding *what* you're allowed to do once your identity is confirmed. They work together but are distinct systems.

**Q: What's the difference between a Security Group and a Microsoft 365 Group?**
> Security Groups are used to control access to resources (you assign RBAC roles to them). Microsoft 365 Groups are for collaboration — they come bundled with a shared mailbox, Teams, SharePoint site, etc.

**Q: Why use groups for access instead of assigning roles to individual users?**
> Scalability and safety. Assign a role to a group once, and every member inherits it; add/remove people from the group to grant/revoke access instantly. This avoids the unmanageable mess of per-user permissions and the security risk of forgetting to remove a departing employee's access.

**Q: What is Conditional Access?**
> A feature that enforces access rules based on context/conditions — like requiring MFA only when signing in from an untrusted network, blocking logins from certain countries, or requiring a compliant/managed device. It moves beyond a simple "password + MFA always" to smart, risk-aware access control.

**Q: How would you secure privileged (admin) accounts?**
> Enforce MFA on all of them, minimize the number of standing Global Admins, and use PIM (Privileged Identity Management) so admin rights are granted just-in-time and time-limited — nobody carries permanent admin access they're not actively using.

---

## 3.9 Summary

Microsoft Entra ID is Azure's cloud identity service — the central directory of users, groups, and application identities, responsible for **authentication** (proving *who* you are). It's deliberately separate from RBAC, which handles **authorization** (*what* you can do). Core building blocks are Tenants, Users (cloud-only or synced from on-prem AD), Groups (assign access to a group, members inherit it), and Service Principals for apps. Production-critical features include MFA, Conditional Access (context-aware rules), and PIM (just-in-time admin access). The standard enterprise pattern: authenticate via Entra ID, authorize via RBAC role assignments on groups.

---
---

# 4. 🗝️ Azure RBAC (Role-Based Access Control)
> 🔴 FULL

---

## 4.1 What Problem Does This Solve?

Once Entra ID confirms *who* someone is, the next question is *what are they allowed to do?* You don't want every employee able to delete the production database. **Azure RBAC** is how you grant precise, controlled permissions — the right people (and applications) get exactly the access they need, and nothing more.

> 💡 **If you know AWS:** RBAC is Azure's equivalent of AWS IAM policies/roles — but structured differently. Instead of writing JSON policy documents attached to users/roles, in Azure you assign a **Role** (a bundle of permissions) to an **identity** at a **Scope** (a level in the hierarchy). The concept of "least privilege" is identical.

---

## 4.2 The RBAC Formula (Flow Diagram)

```
A "Role Assignment" is built from three things:

┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│    WHO        │  +  │   WHAT ROLE   │  +  │   WHAT SCOPE  │
│ (identity)    │     │ (permissions) │     │  (level)      │
├──────────────┤     ├──────────────┤     ├──────────────┤
│ • User        │     │ • Owner       │     │ • Mgmt Group  │
│ • Group       │     │ • Contributor │     │ • Subscription│
│ • Service     │     │ • Reader      │     │ • Resource    │
│   Principal   │     │ • (custom)    │     │   Group       │
│ • Managed     │     │               │     │ • Resource    │
│   Identity    │     │               │     │               │
└──────────────┘     └──────────────┘     └──────────────┘
                            ↓
                = ONE ROLE ASSIGNMENT
       e.g., "Sarah (who) + Contributor (role) + dev-rg (scope)"
       = Sarah can manage resources in dev-rg, nothing else
```

---

## 4.3 The Three Roles You MUST Know Cold

| Role | Can Do | Cannot Do |
|---|---|---|
| **Owner** | Everything, INCLUDING granting access to others | (nothing — full control) |
| **Contributor** | Create / modify / delete resources | Grant access to others (can't touch permissions) |
| **Reader** | View everything | Create / modify / delete anything |

**The Owner vs Contributor distinction is a classic interview question:** Both can fully manage resources, but only Owner can manage *access* (assign roles to other people). A Contributor can build and delete a VM, but cannot give someone else permission to the resource.

---

## 4.4 Scope & Inheritance (Critical Concept)

A role assignment applies at a scope, and **cascades down** to everything beneath it:

```
Assign "Contributor" at the SUBSCRIPTION level
    ↓ automatically inherited by...
    ├── every Resource Group in that subscription
    └── every Resource in those resource groups

Assign "Contributor" at ONE Resource Group level
    ↓ applies ONLY to...
    └── resources in that single resource group (nothing else)
```

**Least privilege in action:** Scope role assignments as narrowly as possible. Give someone Contributor on the *one resource group* they work in, not on the whole subscription "to be safe."

---

## 4.5 UI Steps — Assigning a Role (This Is a Must-Know Portal Flow)

```
📍 START: portal.azure.com → navigate to the SCOPE you want to grant
   access at (e.g., open a specific Resource Group like "dev-rg")
    ↓
In the left menu, click "Access control (IAM)"
   ⭐ Remember this menu name — "IAM" is where ALL RBAC happens,
      and it appears on every subscription, resource group, and resource
    ↓
Click "+ Add" → "Add role assignment"
    ↓
── Tab 1: Role ──
Select a role (e.g., "Contributor") → Next
    ↓
── Tab 2: Members ──
"Assign access to": User, group, or service principal
Click "+ Select members" → pick the group "DevOps-Engineers" → Next
    ↓
── Tab 3: Review + assign ──
Click "Review + assign"

📍 RESULT: The DevOps-Engineers group now has Contributor access,
   scoped to just "dev-rg". Every member of that group inherits it.
```

---

## 4.6 Custom Roles

When the built-in Owner/Contributor/Reader roles don't fit, create a **Custom Role** defining exactly which actions are allowed.

```json
{
  "Name": "VM Restart Operator",
  "IsCustom": true,
  "Description": "Can view and restart VMs, but not create/delete them",
  "Actions": [
    "Microsoft.Compute/virtualMachines/read",
    "Microsoft.Compute/virtualMachines/restart/action"
  ],
  "AssignableScopes": ["/subscriptions/{sub-id}"]
}
```

**When you'd use this:** e.g., a support engineer who should be able to restart a stuck VM in an emergency, but must never be able to delete it or create new ones.

---

## 4.7 Real-World Example

**Situation:** Set up access for three teams across Dev and Prod, following least privilege.

```
Group "Developers"       → Contributor @ dev-rg ONLY
                           (build freely in Dev, zero Prod access)

Group "DevOps-Engineers" → Contributor @ Subscription level
                           (manage infra across all environments)

Group "Finance"          → Reader @ Subscription + "Cost Management Reader"
                           (see everything & costs, change nothing)

Service Principal        → Custom Role @ prod-webapp-rg ONLY
"cicd-pipeline"            (deploy the app, but can't delete the whole RG)

Result: A compromised developer account can't touch Production. A
compromised pipeline identity can only affect one resource group. This
is defense-in-depth applied to access.
```

---

## 4.8 Interview Q&A

**Q: Explain the RBAC model.**
> A role assignment = WHO (a user, group, service principal, or managed identity) + WHAT ROLE (a bundle of permissions like Contributor) + WHAT SCOPE (Management Group, Subscription, Resource Group, or Resource). The assignment cascades down from the scope to everything beneath it.

**Q: Owner vs Contributor — what's the difference?**
> Both can fully manage resources (create/modify/delete). The difference: Owner can also grant access to others (manage role assignments), while Contributor cannot touch permissions at all.

**Q: How do you apply least privilege with RBAC?**
> Scope role assignments as narrowly as possible — grant access at the specific resource group or resource level rather than the whole subscription, use the least-powerful role that still lets the person/app do their job, and use groups so access is easy to grant and revoke consistently.

**Q: Where in the Portal do you manage RBAC?**
> Through the "Access control (IAM)" blade, which appears on every scope level — subscription, resource group, and individual resource.

---

## 4.9 Summary

Azure RBAC controls *what* an authenticated identity is allowed to do. A role assignment combines an identity (WHO), a role/permission bundle (WHAT), and a scope/level (WHERE), cascading down the hierarchy. Know the three core roles cold: Owner (full control + can grant access), Contributor (full resource control but can't grant access), and Reader (view only). Always apply least privilege — scope narrowly, use the weakest sufficient role, and assign to groups rather than individuals. All RBAC is managed through the "Access control (IAM)" blade on any scope.

---
---

# 5. 🤖 Service Principals
> 🔴 FULL

---

## 5.1 What Problem Does This Solve?

Users are identities for *people*. But applications, scripts, and CI/CD pipelines also need to authenticate to Azure and do things — and they can't type a password and complete MFA like a human can. A **Service Principal** is an identity for a *non-human* — an application, automation script, or pipeline — so it can authenticate and be granted RBAC permissions just like a user.

> 💡 **If you know AWS:** A Service Principal is very close to an **IAM Role assumed by an application** or an **IAM user with access keys used programmatically**. It's the "machine identity" concept — something that isn't a person but still needs credentials and permissions.

---

## 5.2 App Registration vs Service Principal (Commonly Confused)

```
┌─────────────────────────────────────────────────────────┐
│  APP REGISTRATION                                        │
│  = the GLOBAL definition/blueprint of your application   │
│    (lives in your "home" tenant, defines the app's        │
│     identity, permissions it can request, etc.)           │
└───────────────────────┬─────────────────────────────────┘
                        │ creates an instance in a tenant
                        ↓
┌─────────────────────────────────────────────────────────┐
│  SERVICE PRINCIPAL                                       │
│  = the LOCAL identity/instance of that app IN a specific │
│    tenant — this is what actually gets RBAC roles         │
│    assigned and does the authenticating                   │
└─────────────────────────────────────────────────────────┘

Analogy: The App Registration is like the master design of a company
ID-badge system. The Service Principal is the actual physical badge
issued to work in one specific building (tenant).
```

For most day-to-day DevOps purposes, when people say "create a service principal for the pipeline," creating an App Registration produces its Service Principal automatically.

---

## 5.3 How a Service Principal Authenticates

A Service Principal proves its identity using one of:

| Credential Type | Description | Security |
|---|---|---|
| **Client Secret** | A password string with an expiry date | ⚠️ Can leak; must be rotated before expiry |
| **Certificate** | A certificate instead of a password | ✅ More secure than a secret |
| **Federated Credential (WIF/OIDC)** | No stored secret — short-lived token via trust (Section 7) | ✅✅ Best — nothing to leak |

```
Service Principal authentication flow:
Application / Pipeline
    ↓ presents its (App ID / Client ID) + (Secret or Cert or OIDC token)
Entra ID
    ↓ verifies the credential
    ↓ issues a short-lived access token
Application uses that token to call Azure (limited by its RBAC roles)
```

---

## 5.4 UI Steps — Creating a Service Principal (via App Registration)

```
📍 START: portal.azure.com → search "Microsoft Entra ID" → open it
    ↓
Left menu → "App registrations" → "+ New registration"
    ↓
   ┌────────────────────────────────────┐
   │ Name: cicd-pipeline-sp              │
   │ Supported account types:            │
   │   "Accounts in this org directory   │
   │    only" (single tenant)             │
   └────────────────────────────────────┘
    ↓
Click "Register"
    ↓
📍 Note down the "Application (client) ID" and "Directory (tenant) ID"
   from the Overview page — you'll need these.
    ↓
── To add a Client Secret ──
Left menu → "Certificates & secrets" → "+ New client secret"
    ↓
Set a description and expiry → click "Add"
    ↓
⚠️ COPY THE SECRET VALUE NOW — it's shown only once and can never be
   retrieved again after you leave this page!
    ↓
── Now grant it permissions (RBAC) ──
Go to the Resource Group you want it to manage → "Access control (IAM)"
→ "+ Add" → "Add role assignment" → choose "Contributor"
→ Members → "+ Select members" → search for "cicd-pipeline-sp" → assign

📍 RESULT: You have a Service Principal with a client ID + secret, and
   Contributor access scoped to one resource group. A pipeline can now
   authenticate as this identity and deploy resources there.
```

**CLI equivalent (much faster):**
```bash
az ad sp create-for-rbac \
  --name "cicd-pipeline-sp" \
  --role Contributor \
  --scopes /subscriptions/{sub-id}/resourceGroups/prod-webapp-rg
# Outputs the appId, password (secret), and tenant — save these securely
```

---

## 5.5 Real-World Example

**Situation:** A Jenkins server (running outside Azure) needs to deploy resources into Azure.

```
Step 1: Create a Service Principal "jenkins-deployer-sp" with a Client
        Secret (or better, a certificate).

Step 2: Assign it a Custom Role scoped to ONLY the resource groups
        Jenkins deploys to — not the whole subscription.

Step 3: Store the Service Principal's credentials securely in Jenkins'
        credential store (NEVER hardcoded in a Jenkinsfile).

Step 4: Jenkins authenticates as this Service Principal to deploy.

Step 5: Set a calendar reminder to rotate the Client Secret before it
        expires — OR, better, migrate to Workload Identity Federation
        (Section 7) to eliminate the secret entirely.

⚠️ The secret-expiry and secret-leak risks are exactly why modern setups
   prefer WIF/OIDC over Service Principal secrets wherever possible.
```

---

## 5.6 Interview Q&A

**Q: What is a Service Principal and when do you use one?**
> A Service Principal is a non-human identity in Entra ID — for applications, scripts, or CI/CD pipelines that need to authenticate to Azure and be granted RBAC permissions. You use one whenever something automated (not a person) needs to act on Azure resources.

**Q: What's the difference between an App Registration and a Service Principal?**
> An App Registration is the global definition/blueprint of an application. A Service Principal is the local instance of that application's identity within a specific tenant — it's the Service Principal that actually gets RBAC roles assigned and does the authenticating.

**Q: What are the ways a Service Principal can authenticate, and which is most secure?**
> A client secret (a password with an expiry — riskiest, can leak), a certificate (more secure), or a federated credential via Workload Identity Federation/OIDC (most secure — no stored secret at all, just short-lived tokens). Modern best practice is WIF/OIDC.

**Q: Why are Service Principal secrets a security concern?**
> They're long-lived credentials that can be accidentally leaked (e.g., committed to Git) and must be manually rotated before they expire — a failed rotation can break your pipeline, and a leaked secret grants an attacker whatever access the Service Principal has. This is why Managed Identities (Section 6) and WIF (Section 7) are preferred.

---

## 5.7 Summary

A Service Principal is a non-human identity in Entra ID used by applications, scripts, and CI/CD pipelines to authenticate to Azure and receive RBAC permissions. It stems from an App Registration (the global app definition) and authenticates via a client secret, certificate, or — best of all — a federated credential (WIF/OIDC) that avoids stored secrets entirely. Always scope a Service Principal's RBAC role narrowly (least privilege), store its credentials securely (never in code), and prefer secretless authentication to avoid the leak-and-rotation risks of client secrets.

---
---

# 6. 🆔 Managed Identities (System vs User-Assigned)
> 🔴 FULL

---

## 6.1 What Problem Does This Solve?

Service Principals (Section 5) work, but they have an annoying downside: someone has to manage their secrets/certificates — store them safely, and rotate them before they expire. If a secret leaks or a rotation is forgotten, you have a security incident or a broken pipeline.

A **Managed Identity** solves this completely: it's a special type of Service Principal that Azure **fully manages for you** — there are **no credentials for you to store, rotate, or ever even see.** Azure handles all of it invisibly.

> 💡 **If you know AWS:** A Managed Identity is Azure's equivalent of an **IAM Role attached to an EC2 instance / Lambda** (via an instance profile). The whole point in both clouds is the same — the compute resource gets an identity automatically, with no access keys stored on it. This is the single most important security best practice for service-to-service auth.

---

## 6.2 The Big Win (Flow Diagram)

```
❌ WITHOUT Managed Identity (using a Service Principal secret):
   VM needs to read from Key Vault
       ↓
   VM stores a Service Principal's client secret somewhere on disk
       ↓
   ⚠️ That secret can leak, must be rotated, is a liability

✅ WITH Managed Identity:
   VM has a Managed Identity enabled
       ↓
   VM asks Azure's local metadata endpoint for a token
   (169.254.169.254 — only reachable from inside the VM)
       ↓
   Azure automatically provides a short-lived token — NO secret stored
   ANYWHERE, ever
       ↓
   VM uses that token to read from Key Vault (limited by RBAC)

The credential lifecycle is 100% handled by Azure. You never see,
store, or rotate anything.
```

---

## 6.3 Two Types of Managed Identity

```
┌──────────────────────────────────────────────────────────┐
│  SYSTEM-ASSIGNED Managed Identity                         │
│  • Tied to the lifecycle of ONE resource (e.g., one VM)   │
│  • Created WHEN you enable it on that resource            │
│  • DELETED automatically when that resource is deleted    │
│  • 1-to-1: one resource, one identity                     │
│  → Use when: an identity is needed by just one resource    │
│    and should die with it                                  │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│  USER-ASSIGNED Managed Identity                           │
│  • A standalone resource you create independently         │
│  • Can be attached to MANY resources at once              │
│  • Survives even if the resources using it are deleted    │
│  • 1-to-many: one identity, shared across resources       │
│  → Use when: multiple resources (e.g., 10 VMs, or a whole  │
│    VM Scale Set) need to share the SAME identity/permissions│
└──────────────────────────────────────────────────────────┘
```

| | System-Assigned | User-Assigned |
|---|---|---|
| Lifecycle | Tied to one resource | Independent, standalone |
| Sharing | One resource only | Shared across many resources |
| Deleted when resource deleted? | Yes | No |
| Best for | Single-resource needs | Shared identity for a fleet/group |

---

## 6.4 UI Steps — Enabling a System-Assigned Managed Identity on a VM

```
📍 START: portal.azure.com → open your Virtual Machine
    ↓
In the VM's left menu → "Security" section → click "Identity"
    ↓
── System assigned tab ──
Toggle "Status" to "On"
    ↓
Click "Save" → confirm "Yes"
    ↓
📍 The VM now has an identity in Entra ID. Now grant it permissions:
    ↓
Still on the Identity page → click "Azure role assignments"
→ "+ Add role assignment"
    ↓
   ┌────────────────────────────────────────┐
   │ Scope:  Resource group                  │
   │ Resource group: the Key Vault's RG       │
   │ Role:   Key Vault Secrets User           │
   └────────────────────────────────────────┘
    ↓
Click "Save"

📍 RESULT: The VM can now retrieve secrets from Key Vault using its
   Managed Identity — with ZERO credentials stored on the VM.
```

**UI Steps — Creating a User-Assigned Managed Identity:**
```
📍 portal.azure.com → search "Managed Identities" → "+ Create"
    ↓
Choose Subscription, Resource Group, Region, Name (e.g., "shared-app-identity")
    ↓
"Review + create" → "Create"
    ↓
📍 Then attach it to resources: open a VM/VMSS → Identity →
   "User assigned" tab → "+ Add" → select "shared-app-identity"
```

---

## 6.5 Real-World Example

**Situation:** A VM Scale Set of 10 web servers all need to read the same database password from Key Vault.

```
Choice: USER-ASSIGNED Managed Identity (because MANY resources share
        the same identity/permission need).

Step 1: Create a User-Assigned Managed Identity "webapp-identity".

Step 2: Grant "webapp-identity" the "Key Vault Secrets User" role on
        the Key Vault holding the database password.

Step 3: Attach "webapp-identity" to the VM Scale Set — every VM in the
        set (including new ones added by autoscaling) automatically uses
        this identity.

Step 4: Each web server retrieves the DB password from Key Vault at
        runtime using this identity — no secret is stored on any VM,
        and new autoscaled VMs work automatically with zero setup.

Why not System-Assigned here? Because that would create 10 separate
identities (one per VM), and you'd have to grant Key Vault access to
each one individually — and re-grant it for every new autoscaled VM.
User-Assigned = one identity, one permission grant, shared by all.
```

---

## 6.6 Interview Q&A

**Q: What is a Managed Identity and why is it better than a Service Principal with a secret?**
> A Managed Identity is a special Service Principal that Azure fully manages — there are no credentials for you to store, rotate, or ever see. It's better than a Service Principal with a secret because it eliminates the entire class of risks around secret leakage and rotation — the credential lifecycle is handled entirely and invisibly by Azure.

**Q: What's the difference between System-Assigned and User-Assigned Managed Identity?**
> System-Assigned is tied to the lifecycle of a single resource — created when you enable it on that resource, deleted when the resource is deleted. User-Assigned is a standalone identity you create independently, which can be shared across multiple resources and survives independently of them. Use User-Assigned when many resources need to share the same identity/permissions (like a VM Scale Set), and System-Assigned for a single resource's needs.

**Q: How does a Managed Identity actually get a token without any stored credential?**
> The resource (e.g., a VM) requests a token from Azure's Instance Metadata Service endpoint (169.254.169.254), which is only reachable from inside that resource. Azure recognizes the resource's Managed Identity and issues a short-lived token automatically — no secret is ever stored or transmitted by you.

---

## 6.7 Summary

A Managed Identity is a fully Azure-managed Service Principal with no credentials for you to store or rotate — the single best practice for service-to-service authentication in Azure. **System-Assigned** identities are tied to one resource's lifecycle (1-to-1, deleted with the resource); **User-Assigned** identities are standalone and shareable across many resources (1-to-many), ideal for fleets like VM Scale Sets. The resource obtains short-lived tokens automatically from Azure's metadata endpoint, so nothing sensitive is ever stored. Whenever a VM, App Service, Function, or AKS pod needs to access another Azure service (like Key Vault), reach for a Managed Identity first.

---
---

# 7. 🔗 Workload Identity Federation (WIF) / OIDC
> 🔴 FULL

---

## 7.1 What Problem Does This Solve?

Managed Identities (Section 6) are perfect when your workload runs *inside* Azure. But what about workloads running *outside* Azure that still need to deploy *into* Azure — like a **GitHub Actions** workflow, a **Jenkins** server, or an external CI/CD system? They can't use a Managed Identity (that's Azure-internal only), so historically they used a Service Principal with a **client secret** — bringing back all the secret-leakage and rotation problems.

**Workload Identity Federation (WIF)**, built on the **OIDC (OpenID Connect)** standard, solves this: it lets an external system authenticate to Azure using **short-lived tokens via a trust relationship — with no stored secret at all.**

> 💡 **If you know AWS:** This is *exactly* the same concept as **GitHub Actions → AWS via OIDC** (the `aws-actions/configure-aws-credentials` OIDC flow) or IAM OIDC identity providers. If you've set up GitHub → AWS without access keys, WIF is the identical pattern for Azure. This is a strong point to make in the interview since the JD spans both clouds.

---

## 7.2 How WIF Works (Flow Diagram)

```
The core idea: Azure TRUSTS tokens issued by an external identity
provider (like GitHub's OIDC provider), for a specific, narrowly-defined
workload — so no secret ever changes hands.

┌────────────────────────────────────────────────────────────────┐
│  ONE-TIME SETUP:                                                 │
│  In Entra ID, on a Service Principal, you configure a            │
│  "Federated Credential" that says:                               │
│  "TRUST tokens from GitHub's OIDC issuer, but ONLY for the       │
│   repo 'myorg/myrepo' on the 'main' branch"                      │
└────────────────────────────────────────────────────────────────┘

RUNTIME (every pipeline run):

  GitHub Actions workflow starts
       ↓
  GitHub's OIDC provider issues a short-lived token that says
  "this is myorg/myrepo, main branch"
       ↓
  The workflow presents this token to Entra ID
       ↓
  Entra ID checks: "Do I trust GitHub's issuer for this exact repo/branch?"
       ↓ YES (matches the Federated Credential we configured)
  Entra ID issues an Azure access token (scoped by the SP's RBAC roles)
       ↓
  Workflow deploys to Azure — NO secret was ever stored or transmitted
```

**The magic:** the trust is scoped to a *specific* repo and branch (or environment). A different repo, or even the same repo on a different branch, won't be trusted — so even the trust itself is least-privilege.

---

## 7.3 Why This Is the Modern Best Practice

| Old Way (Client Secret) | WIF / OIDC |
|---|---|
| Long-lived secret stored in GitHub/Jenkins | No secret stored anywhere |
| Can leak (e.g., in logs, in Git) | Nothing to leak |
| Must be rotated before expiry | Nothing to rotate |
| If leaked, valid until expiry | Tokens are short-lived (minutes) |

**Interview gold:** When asked "how would you authenticate GitHub Actions / a pipeline to Azure securely?", the top answer is **"Workload Identity Federation using OIDC — no stored secrets, short-lived tokens, and the trust is scoped to a specific repo/branch/environment."**

---

## 7.4 UI Steps — Configuring a Federated Credential (for GitHub Actions → Azure)

```
📍 START: portal.azure.com → search "Microsoft Entra ID" → open it
    ↓
Left menu → "App registrations" → open your app (e.g., "github-deployer-sp")
   (create one first if needed — see Section 5)
    ↓
Left menu → "Certificates & secrets" → click the "Federated credentials" tab
    ↓
Click "+ Add credential"
    ↓
   ┌──────────────────────────────────────────────────┐
   │ Federated credential scenario:                     │
   │   "GitHub Actions deploying Azure resources"       │
   │                                                    │
   │ Organization:  myorg                               │
   │ Repository:    myrepo                              │
   │ Entity type:   Branch                              │
   │ Branch:        main                                │
   │   (this scopes the trust to ONLY myorg/myrepo@main)│
   └──────────────────────────────────────────────────┘
    ↓
Click "Add"
    ↓
📍 Then assign RBAC to this app (Section 4): go to the target Resource
   Group → Access control (IAM) → assign it "Contributor" (scoped narrowly)

📍 RESULT: GitHub Actions from myorg/myrepo's main branch can now
   authenticate to Azure with zero stored secrets. In your workflow you
   use the azure/login action with the app's client-id + tenant-id +
   subscription-id (these are NOT secrets — they're just identifiers).
```

**Corresponding GitHub Actions snippet:**
```yaml
permissions:
  id-token: write   # ← required for OIDC
  contents: read
steps:
  - uses: azure/login@v2
    with:
      client-id: ${{ vars.AZURE_CLIENT_ID }}       # not a secret
      tenant-id: ${{ vars.AZURE_TENANT_ID }}        # not a secret
      subscription-id: ${{ vars.AZURE_SUBSCRIPTION_ID }}  # not a secret
```

---

## 7.5 Real-World Example

**Situation:** Your team's GitHub Actions workflows deploy to Azure, and the security team has banned all long-lived secrets in the CI/CD system after a near-miss where a secret was almost committed to a repo.

```
Step 1: Create an App Registration "github-prod-deployer".

Step 2: Add a Federated Credential trusting GitHub OIDC for ONLY
        "myorg/myrepo" on the "main" branch (and optionally a separate
        one for the "production" GitHub Environment for extra control).

Step 3: Grant it Contributor RBAC scoped to only "prod-webapp-rg".

Step 4: Update the GitHub workflow to use azure/login with OIDC (no
        secret) — passing only the non-secret client/tenant/subscription IDs.

Step 5: Delete the old client secret entirely.

Result: Deployments work exactly as before, but there is now literally
no secret anywhere that could leak. Even if an attacker gained read
access to the repo, there's nothing credential-like to steal, and the
trust only works from the specific repo/branch anyway.
```

---

## 7.6 Interview Q&A

**Q: What is Workload Identity Federation and why use it?**
> It's a way for an external workload (like GitHub Actions or Jenkins) to authenticate to Azure using short-lived tokens via an OIDC trust relationship, instead of a stored client secret. You use it to eliminate long-lived secrets from CI/CD — nothing to store, leak, or rotate — which is the modern security best practice.

**Q: How does the trust actually work?**
> You configure a Federated Credential on a Service Principal in Entra ID that trusts a specific external OIDC issuer (e.g., GitHub) for a specific, narrowly-scoped workload (e.g., one repo + one branch). At runtime, the external system presents an OIDC token proving its identity; Entra ID verifies it matches the configured trust and issues a short-lived Azure token.

**Q: Is WIF more secure than a Service Principal secret? Why?**
> Yes. There's no long-lived secret stored anywhere, so nothing to leak or rotate; the tokens are short-lived (valid for minutes); and the trust is scoped to a specific repo/branch/environment, so even a stolen token from elsewhere wouldn't be accepted.

**Q: How does this relate to AWS?**
> It's the same concept as GitHub Actions authenticating to AWS via OIDC (IAM OIDC identity providers). Both clouds let external CI/CD federate identity via OIDC to avoid storing static credentials — the mechanism is analogous.

---

## 7.7 Summary

Workload Identity Federation (WIF), built on OIDC, lets workloads *outside* Azure (GitHub Actions, Jenkins, external CI/CD) authenticate to Azure with **no stored secret** — using short-lived tokens issued via a trust relationship scoped to a specific repo/branch/environment. It's the modern best practice, eliminating the leak-and-rotate risks of Service Principal client secrets, and it directly mirrors the GitHub→AWS OIDC pattern. Configure it via a Federated Credential on a Service Principal, grant that principal narrow RBAC, and your external pipelines deploy securely with zero secrets to manage.

---
---

# 8. 🛂 Conditional Access & PIM
> 🟡 KNOW-THIS-MUCH

---

## 8.1 What Problem Does This Solve?

Basic security ("require a password + MFA always, and give admins permanent admin rights") is blunt. Real organizations need smarter, risk-aware access: *require* extra verification only in risky situations, and ensure powerful admin rights aren't sitting around permanently waiting to be abused if an account is compromised. **Conditional Access** and **PIM** provide this.

> 💡 **If you know AWS:** Conditional Access is loosely like combining IAM condition keys (IP/MFA/device conditions on policies) with a smarter, identity-centric policy engine. PIM is like a much more automated, built-in version of AWS's "assume an elevated role temporarily" pattern — just-in-time privilege elevation.

---

## 8.2 Conditional Access (Flow Diagram)

```
User attempts to sign in
       ↓
Conditional Access evaluates SIGNALS about the attempt:
   • Who is the user? (which group?)
   • Where from? (IP / country / trusted network?)
   • What device? (managed & compliant, or personal?)
   • How risky? (Entra ID Protection risk score — impossible travel?)
       ↓
Applies a DECISION based on policies you define:
   ┌────────────────────────────────────────────┐
   │ • GRANT access                              │
   │ • GRANT but REQUIRE MFA                     │
   │ • GRANT but require a compliant device      │
   │ • BLOCK access entirely                     │
   └────────────────────────────────────────────┘

Example policy: "If an admin signs in from OUTSIDE the corporate
network → require MFA AND a compliant device. If from a blocked
country → deny entirely."
```

---

## 8.3 PIM — Privileged Identity Management (Flow Diagram)

```
The problem: If someone is a permanent "Global Admin," and their account
is compromised, the attacker instantly has full control.

PIM's solution: Make admin roles ELIGIBLE, not permanently ACTIVE.

┌─────────────────────────────────────────────────────────┐
│  Normal state: Sarah is ELIGIBLE for "Global Admin"       │
│  but does NOT currently hold it. Day-to-day, she has no   │
│  admin power at all.                                       │
└───────────────────────┬───────────────────────────────────┘
                        ↓ (when she actually needs it)
┌─────────────────────────────────────────────────────────┐
│  Sarah "ACTIVATES" the role via PIM:                      │
│  • May require MFA to activate                            │
│  • May require a justification/reason                     │
│  • May require approval from a manager                    │
│  • Is TIME-LIMITED (e.g., 4 hours, then auto-expires)     │
└───────────────────────┬───────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│  Sarah has Global Admin for 4 hours → does her task →     │
│  access automatically expires. Everything is logged.      │
└─────────────────────────────────────────────────────────┘

Result: Even if Sarah's account is compromised, the attacker doesn't
automatically get admin rights — those are only briefly active, when
deliberately requested, with an audit trail.
```

---

## 8.4 UI Steps

**Conditional Access** (already shown in Section 3.6 for MFA):
```
📍 portal.azure.com → "Microsoft Entra ID" → Security → Conditional Access
   → "+ New policy" → define Users, Cloud apps, Conditions (location/device/risk),
   and Grant controls (require MFA / compliant device / block) → Enable → Create
```

**PIM:**
```
📍 START: portal.azure.com → search "Privileged Identity Management" → open it
    ↓
"Microsoft Entra roles" → "Roles" → pick a role (e.g., "Global Administrator")
    ↓
"+ Add assignments" → select the user → set assignment type to "Eligible"
   (not "Active") → set a duration/expiry
    ↓
📍 RESULT: The user can now ACTIVATE that role on-demand (with any
   MFA/approval/justification you configured), for a limited time,
   rather than holding it permanently.
```

---

## 8.5 Real-World Example

```
A financial services company applies both:

Conditional Access:
  • All users: require MFA always
  • Admins signing in from outside the office network: require MFA +
    a company-managed compliant device
  • Sign-ins from countries the company doesn't operate in: blocked

PIM:
  • No one holds standing "Owner" or "Global Admin" rights
  • Engineers are "Eligible" and must activate elevated access via PIM
    when needed — requiring MFA, a justification, and (for the most
    sensitive roles) manager approval, auto-expiring after 4 hours

Result: A dramatically reduced attack surface — compromised credentials
alone don't grant admin power, and all privilege activation is logged
for compliance audits.
```

---

## 8.6 Interview Q&A

**Q: What is Conditional Access?**
> A policy engine in Entra ID that makes access decisions based on real-time signals — who the user is, where they're signing in from, what device they're using, and how risky the sign-in looks — applying controls like requiring MFA, requiring a compliant device, or blocking access entirely.

**Q: What problem does PIM solve?**
> It eliminates permanent standing privileged access. Instead of users holding admin roles all the time (a big risk if compromised), PIM makes them "eligible" to activate those roles just-in-time — time-limited, often requiring MFA/justification/approval, and fully audited.

---

## 8.7 Summary

Conditional Access enforces smart, context-aware sign-in rules based on signals like user, location, device compliance, and risk — for example, requiring MFA only from untrusted networks or blocking risky sign-ins entirely. PIM (Privileged Identity Management) eliminates permanent admin access by making privileged roles "eligible" rather than always-active, so users activate them just-in-time with time limits, MFA, justification, and approval — all logged. Together they enforce a least-privilege, risk-aware security posture that real enterprises rely on.

---

---
---

# 9. 🌐 Networking Fundamentals (IP, CIDR, Ports)
> 🟠 MEDIUM

---

## 9.1 What Problem Does This Solve?

Before you can design any Azure network, you need to understand the basic building blocks that ALL networking is built on — IP addresses, address ranges (CIDR), and ports. This section builds these from scratch, because getting them wrong is the #1 cause of "why can't my app reach the database?" production incidents.

> 💡 **If you know AWS:** These fundamentals are cloud-agnostic — the exact same IP/CIDR/port concepts apply identically in AWS VPCs. If you're solid on VPC CIDR blocks, you can skim this.

---

## 9.2 IP Addresses — The Basics

An **IP address** is a unique identifier for a device on a network — like a postal address for a computer. The common form (IPv4) looks like four numbers (0–255) separated by dots:
```
10.0.1.5      192.168.0.100      172.16.2.45
```

**Public vs Private IPs:**

| Type | Reachable From | Example Use |
|---|---|---|
| **Public IP** | Anywhere on the internet | A public web server, a load balancer's front-end |
| **Private IP** | Only within your own network (VNet) | Databases, app servers — things that shouldn't face the internet |

**Best practice (repeated throughout Azure networking):** Only assign Public IPs to resources that genuinely need direct internet access. Everything else should use Private IPs only.

---

## 9.3 CIDR Notation — Explained From Scratch

**CIDR (Classless Inter-Domain Routing)** is a compact way of describing a *range* of IP addresses, written as an IP followed by a `/number`:
```
10.0.0.0/24      10.0.0.0/16      10.0.0.0/8
```

The `/number` tells you how many addresses are in the range. **The counter-intuitive part: a SMALLER number after the slash = a LARGER range of addresses.**

```
/24  →  256 addresses    (10.0.1.0  to  10.0.1.255)   ← small, good for one subnet
/16  →  65,536 addresses (10.0.0.0  to  10.0.255.255) ← large, good for a whole VNet
/8   →  16.7 million addresses                         ← huge

Simple mental shortcut:
   /24 = small  (a single subnet)
   /16 = big    (an entire VNet)
   Remember: bigger slash number = smaller range
```

**Why does it work this way?** An IPv4 address is 32 bits under the hood. The slash number says how many bits are "locked" as the network portion. `/24` locks 24 bits, leaving 8 bits free → 2^8 = 256 possible addresses. You don't need to do this math live — just remember the /24 = 256 and /16 = 65,536 anchors.

---

## 9.4 Ports — The Basics

If an IP address is like a building's street address, a **port** is like an apartment/room number inside that building — it tells traffic *which specific service* on that machine to talk to.

| Port | Common Use |
|---|---|
| **22** | SSH (remote login to Linux) |
| **80** | HTTP (web traffic, unencrypted) |
| **443** | HTTPS (web traffic, encrypted) |
| **3389** | RDP (remote login to Windows) |
| **1433** | SQL Server database |
| **3306** | MySQL database |
| **5432** | PostgreSQL database |

**Security note:** Ports 22 (SSH) and 3389 (RDP) are constantly scanned by attackers — never expose them to the whole internet (covered in NSG section 12 and Bastion later).

---

## 9.5 How It All Fits Together (Flow Diagram)

```
A request to reach a web server:

Client somewhere on the internet
       ↓ wants to reach:
   IP Address: 20.50.11.45   (WHICH machine)
   Port:       443           (WHICH service on that machine — HTTPS)
       ↓
The web server at 20.50.11.45, listening on port 443, receives it.

Inside your Azure network, private communication looks like:
   App server (private IP 10.0.2.5)
       ↓ connects to:
   Database (private IP 10.0.3.8) on Port 1433
       ↓
   Both are inside the VNet's address range (e.g., 10.0.0.0/16),
   in different subnets (/24 slices), never touching the internet.
```

---

## 9.6 UI Steps — Seeing IP/CIDR When Creating a VNet

```
📍 START: portal.azure.com → search "Virtual networks" → "+ Create"
    ↓
On the "IP Addresses" tab, you'll see:
   ┌──────────────────────────────────────────┐
   │ IPv4 address space:  10.0.0.0/16          │  ← the whole VNet's range (65,536 addresses)
   │                                            │
   │ Subnets:                                   │
   │   default:  10.0.0.0/24                    │  ← one /24 slice (256 addresses)
   └──────────────────────────────────────────┘
    ↓
📍 RESULT: This is where the theory becomes concrete — the VNet gets a
   large /16 range, and you carve smaller /24 subnets out of it.
   (Full VNet & subnet detail in the next two sections.)
```

---

## 9.7 Real-World Example

**Situation:** You're planning the IP layout for a new 3-tier application before creating anything.

```
Plan on paper first (a real DevOps habit):

VNet address space:  10.0.0.0/16   (65,536 addresses — plenty of room)
    ├── web-subnet:  10.0.1.0/24    (256 addresses for web servers)
    ├── app-subnet:  10.0.2.0/24    (256 addresses for app servers)
    └── db-subnet:   10.0.3.0/24    (256 addresses for databases)

Ports each tier accepts:
    web-subnet: 80, 443  (from internet)
    app-subnet: 8080     (from web tier only)
    db-subnet:  1433     (from app tier only)

Planning IP ranges and ports up front prevents overlap problems later
(e.g., you can't peer two VNets with overlapping ranges — Section 17).
```

---

## 9.8 Interview Q&A

**Q: What does a /24 versus a /16 CIDR mean?**
> The number after the slash indicates how many bits are the fixed network portion — the smaller the number, the larger the address range. A /24 gives 256 addresses (good for a single subnet), a /16 gives 65,536 addresses (good for a whole VNet). Counter-intuitively, a smaller slash number means a bigger range.

**Q: What's the difference between a public and private IP?**
> A public IP is reachable from the internet; a private IP is only reachable within your own network (VNet) or connected networks. Best practice is to only give public IPs to resources that genuinely need internet exposure.

**Q: What port does SQL Server use, and why does it matter for networking?**
> 1433. It matters because your NSG rules must explicitly allow the app tier to reach the database tier on port 1433 — and only from the app tier, not from anywhere else — to keep the database secure while still functional.

---

## 9.9 Summary

Networking fundamentals underpin everything: an IP address identifies a machine (public = internet-reachable, private = internal-only), CIDR notation describes ranges (smaller slash number = bigger range; /24 = 256 addresses, /16 = 65,536), and ports identify which service on a machine to reach (443 = HTTPS, 1433 = SQL, 22 = SSH). Plan your VNet's /16 range and its /24 subnets on paper before building, and remember that ports 22/3389 should never be open to the whole internet.

---
---

# 10. 🔷 Virtual Network (VNet)
> 🔴 FULL

---

## 10.1 What Problem Does This Solve?

Your Azure resources — VMs, databases, containers — need a private, isolated network to live in and communicate through, separate from every other Azure customer. A **Virtual Network (VNet)** is that private network: your own logically isolated slice of Azure's networking, where you control the IP ranges, segmentation, routing, and security.

> 💡 **If you know AWS:** A VNet is the direct equivalent of an **AWS VPC**. Two important differences: (1) Azure has **no separate "Internet Gateway" resource** to create/attach — a resource with a Public IP just has internet connectivity; (2) Azure subnets are **not tied to a single Availability Zone** the way AWS subnets are — zone placement is chosen per-resource, not per-subnet.

---

## 10.2 What a VNet Gives You (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  YOUR VIRTUAL NETWORK: "production-vnet"                  │
│  Address space: 10.0.0.0/16                               │
│  (Completely isolated from every other Azure customer)    │
│                                                            │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐      │
│   │ web-subnet  │  │ app-subnet  │  │ db-subnet   │      │
│   │ 10.0.1.0/24 │  │ 10.0.2.0/24 │  │ 10.0.3.0/24 │      │
│   │             │  │             │  │             │      │
│   │  Web VMs    │  │  App VMs    │  │  Database   │      │
│   └──────┬──────┘  └──────┬──────┘  └──────┬──────┘      │
│          │                │                │              │
│          └────────────────┴────────────────┘             │
│         Resources in the same VNet can communicate        │
│         privately by default (subject to NSG rules)       │
└──────────────────────────────────────────────────────────┘
          │
          ↓ (only if a resource has a Public IP)
       Internet
```

**What you control in a VNet:**
- The overall IP address space (CIDR)
- How it's divided into subnets
- Routing rules (Route Tables / UDR — Section 14)
- Security rules (NSGs — Section 12)
- Connectivity out (internet, other VNets, on-premises)

---

## 10.3 Key Facts to Remember

```
✅ A VNet lives in ONE region (but can connect to VNets in other
   regions via Peering — Section 17)
✅ A VNet belongs to ONE subscription
✅ Resources in the same VNet can talk to each other privately by
   default (subject to NSG rules)
✅ You can add multiple address spaces to a VNet later if you run out
✅ VNet address spaces must NOT overlap with networks you want to
   connect to (on-premises, or peered VNets)
✅ There's no "Internet Gateway" to attach — internet access comes
   automatically to any resource with a Public IP
```

---

## 10.4 UI Steps — Creating a VNet

```
📍 START: portal.azure.com → search "Virtual networks" → "+ Create"
    ↓
── Basics tab ──
   ┌──────────────────────────────────────────┐
   │ Subscription:   [your subscription]        │
   │ Resource group: production-rg              │
   │ Name:           production-vnet            │
   │ Region:         Central India              │
   └──────────────────────────────────────────┘
    ↓
── IP Addresses tab ──
   ┌──────────────────────────────────────────┐
   │ IPv4 address space: 10.0.0.0/16           │
   │ + Add subnet:                              │
   │     Name: web-subnet   Range: 10.0.1.0/24 │
   │     Name: app-subnet   Range: 10.0.2.0/24 │
   │     Name: db-subnet    Range: 10.0.3.0/24 │
   └──────────────────────────────────────────┘
    ↓
Click "Review + create" → "Create"

📍 RESULT: A private, isolated network with three subnets, ready for
   you to deploy resources into.
```

**CLI equivalent:**
```bash
az network vnet create \
  --resource-group production-rg \
  --name production-vnet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name web-subnet \
  --subnet-prefix 10.0.1.0/24
```

---

## 10.5 Real-World Example

**Situation:** You're setting up the network foundation for a new application that must be secure by design.

```
Step 1: Create "production-vnet" with address space 10.0.0.0/16.

Step 2: Carve it into purpose-specific subnets: web (public-facing),
        app (internal), db (most locked down).

Step 3: Only the web tier's load balancer will get a Public IP —
        everything else stays private, invisible to the internet.

Step 4: Later sections add the security layers: NSGs (Section 12) to
        control traffic between subnets, Private Endpoints (Section 16)
        for secure access to Azure services, and Bastion for management
        access without public IPs.

The VNet is the foundation — get the address planning right first,
because it's painful to change later once resources are deployed.
```

---

## 10.6 Interview Q&A

**Q: What is a VNet?**
> A Virtual Network is your own private, logically isolated network within Azure — you define its IP address space, divide it into subnets, and control routing and security. It's isolated from every other Azure customer even though it runs on shared underlying infrastructure.

**Q: Does Azure need an Internet Gateway like AWS?**
> No. In Azure there's no separate Internet Gateway resource — any resource that has a Public IP assigned automatically has internet connectivity. This is a notable difference from AWS, where you must explicitly create and attach an Internet Gateway to a VPC.

**Q: Can resources in a VNet talk to each other by default?**
> Yes — resources in the same VNet can communicate privately by default, subject to any NSG rules you've applied. You don't need to explicitly enable intra-VNet communication.

**Q: What's a key rule about VNet address spaces when connecting networks?**
> They must not overlap. You can't peer two VNets (or connect a VNet to an on-premises network) if their address ranges overlap, because routing would be ambiguous.

---

## 10.7 Summary

A Virtual Network (VNet) is your private, isolated network in Azure — the equivalent of an AWS VPC — where you control the IP address space, subnet segmentation, routing, and security. Resources within a VNet communicate privately by default (subject to NSGs). Remember the Azure-specific quirks: no Internet Gateway resource (Public IP = internet access), subnets aren't zone-bound, and address spaces must never overlap with networks you plan to connect. Plan your address space carefully up front, since it's the foundation everything else builds on.

---
---

# 11. 🧩 Subnets
> 🔴 FULL

---

## 11.1 What Problem Does This Solve?

Putting every resource into one big flat network is insecure and disorganized — a breached web server could directly reach your database. **Subnets** solve this by dividing your VNet into smaller, isolated segments, letting you apply different security rules to each and separate your application into tiers.

> 💡 **If you know AWS:** Subnets are the same concept as AWS subnets. Key difference: AWS subnets each live in exactly one Availability Zone, so you create one subnet per AZ. Azure subnets are **not** tied to a zone — you place resources into zones individually, so you don't need a subnet-per-zone.

---

## 11.2 Subnets Divide a VNet (Flow Diagram)

```
VNet: 10.0.0.0/16  (65,536 total addresses)
│
├── Subnet "web-subnet":  10.0.1.0/24  ┐
│     • Public-facing tier              │
│     • NSG: allow 80/443 from internet │  Each subnet:
│                                       │  • is a slice of the VNet's range
├── Subnet "app-subnet":  10.0.2.0/24  │  • has its OWN security rules (NSG)
│     • Internal tier                   │  • separates one tier from another
│     • NSG: allow only from web-subnet │
│                                       │
└── Subnet "db-subnet":   10.0.3.0/24  ┘
      • Most locked-down tier
      • NSG: allow only from app-subnet
```

---

## 11.3 The 5 Reserved IPs (Important Detail)

Azure **reserves 5 IP addresses in every subnet** for its own internal use, so a /24 subnet (256 total addresses) actually gives you **251 usable** addresses:
```
For subnet 10.0.1.0/24:
  10.0.1.0   → Network address (reserved)
  10.0.1.1   → Default gateway (reserved)
  10.0.1.2   → Azure DNS (reserved)
  10.0.1.3   → Azure DNS (reserved)
  10.0.1.255 → Broadcast address (reserved)
  → Usable: 10.0.1.4 through 10.0.1.254 = 251 addresses
```

---

## 11.4 Special Subnets (Azure Requires Exact Names)

Some Azure services require their own dedicated subnet with a **specific, exact name** — a common gotcha:

| Service | Required Subnet Name |
|---|---|
| VPN Gateway / ExpressRoute Gateway | `GatewaySubnet` |
| Azure Firewall | `AzureFirewallSubnet` |
| Azure Bastion | `AzureBastionSubnet` |

If you don't name these exactly right, the service won't deploy.

---

## 11.5 UI Steps — Adding a Subnet to an Existing VNet

```
📍 START: portal.azure.com → open your VNet (e.g., "production-vnet")
    ↓
Left menu → "Subnets" → "+ Subnet"
    ↓
   ┌──────────────────────────────────────────┐
   │ Name:            app-subnet                │
   │ Subnet address range: 10.0.2.0/24          │
   │ Network security group: [attach app-nsg]   │  ← optional but recommended
   │ Route table:            [attach if needed]  │
   └──────────────────────────────────────────┘
    ↓
Click "Save"

📍 RESULT: A new subnet exists within the VNet, optionally pre-associated
   with an NSG (security rules) and Route Table (custom routing).
```

**CLI equivalent:**
```bash
az network vnet subnet create \
  --resource-group production-rg \
  --vnet-name production-vnet \
  --name app-subnet \
  --address-prefix 10.0.2.0/24
```

---

## 11.6 Real-World Example

**Situation:** Securing the 3-tier app so a breach of one tier can't directly reach another.

```
Three subnets, each with its own NSG restricting traffic:

web-subnet (10.0.1.0/24):
   Accepts: ports 80/443 from the internet
   → the only tier exposed to the outside world

app-subnet (10.0.2.0/24):
   Accepts: only traffic FROM web-subnet, on the app's port
   → not reachable from the internet at all

db-subnet (10.0.3.0/24):
   Accepts: only traffic FROM app-subnet, on port 1433
   → the most locked-down tier; even if an attacker breached a web
     server, they still couldn't reach the database directly

This tier-by-tier isolation is "defense in depth" — a key interview phrase.
```

---

## 11.7 Interview Q&A

**Q: Why divide a VNet into subnets instead of using one flat network?**
> For security and organization — each subnet can have its own NSG (firewall rules), letting you isolate application tiers so that, for example, the database subnet only accepts traffic from the app subnet and is completely unreachable from the internet. This layered isolation is defense in depth.

**Q: How many usable IPs are in a /24 subnet in Azure?**
> 251. A /24 has 256 total addresses, but Azure reserves 5 in every subnet (network address, gateway, two for DNS, and broadcast).

**Q: Are Azure subnets tied to Availability Zones?**
> No — unlike AWS, Azure subnets aren't bound to a single zone. You choose zone placement per-resource when deploying, so you don't need a separate subnet per zone.

**Q: What's special about a subnet named "AzureBastionSubnet"?**
> Certain Azure services require a dedicated subnet with an exact name — Azure Bastion needs one named exactly "AzureBastionSubnet", Azure Firewall needs "AzureFirewallSubnet", and gateways need "GatewaySubnet". The service won't deploy if the name is wrong.

---

## 11.8 Summary

Subnets divide a VNet into smaller, isolated segments — typically one per application tier (web, app, db) — so you can apply different NSG security rules to each and isolate tiers from one another (defense in depth). Remember Azure reserves 5 IPs per subnet (a /24 gives 251 usable), subnets aren't zone-bound (unlike AWS), and certain services need dedicated subnets with exact names (GatewaySubnet, AzureFirewallSubnet, AzureBastionSubnet). Attach an NSG to each subnet to control what traffic can flow in and out.

---
---

# 12. 🛡️ Network Security Groups (NSG)
> 🔴 FULL

---

## 12.1 What Problem Does This Solve?

Once you have VMs in subnets, you need to control exactly what network traffic is allowed to reach them and leave them — which ports, from which sources. A **Network Security Group (NSG)** is Azure's virtual firewall that filters this traffic using rules you define.

> 💡 **If you know AWS:** An NSG is like AWS Security Groups + Network ACLs combined. Unlike AWS (Security Groups = allow-only, attach to instances; NACLs = allow/deny, attach to subnets), a single Azure NSG supports **both allow AND deny rules**, and attaches at **both subnet and NIC level**.

---

## 12.2 How NSG Rule Evaluation Works (Flow Diagram)

```
A packet tries to reach your VM...
       ↓
NSG checks rules in PRIORITY ORDER (lowest number first),
stops at the FIRST match:

   Priority 100: Allow 443 from Internet?  → MATCH → ✅ ALLOW (stop)
   Priority 200: Allow 22 from OfficeIP?   → (only checked if 100 didn't match)
   Priority 4096: Deny all                  → catch-all
   Priority 65500 (hidden default): Deny All Inbound

Key: There's ALWAYS a hidden default "Deny All Inbound" at the bottom.
So anything NOT explicitly allowed is BLOCKED. NSGs are "deny by default."
```

---

## 12.3 Anatomy of an NSG Rule

| Field | Meaning | Example |
|---|---|---|
| **Priority** | 100–4096, lower checked first | `100` |
| **Direction** | Inbound or Outbound | `Inbound` |
| **Source** | Where traffic comes FROM | `Internet`, an IP/CIDR, or an ASG |
| **Destination** | Where it goes TO | `Any`, a subnet, or an ASG |
| **Port** | Which port(s) | `443` |
| **Protocol** | TCP / UDP / Any | `TCP` |
| **Action** | Allow or Deny | `Allow` |

```
Example inbound rules for a web server:
Priority │ Source              │ Port │ Action
  100    │ Internet            │ 443  │ Allow
  110    │ Internet            │ 80   │ Allow
  200    │ 203.0.5.0/24 (office)│ 22  │ Allow
  4096   │ Any                 │ Any  │ Deny
```

---

## 12.4 Stateful — Crucial Concept

NSGs are **stateful**: if you allow an inbound request, the outbound response is **automatically allowed** — no separate return rule needed.
```
Customer request IN on 443 → allowed by your inbound rule
Server response OUT to customer → AUTOMATICALLY allowed (no rule needed)
```
**Interview trap:** Don't claim you need separate request/response rules — you don't, because NSGs track connection state.

---

## 12.5 Two Attachment Levels

```
Subnet-level NSG: applies to EVERY resource in the subnet
NIC-level NSG:    applies to ONE specific VM

If both exist: traffic must pass BOTH to get through.
Inbound: Subnet NSG checked first → then NIC NSG → then the VM.
```
**Best practice:** Use subnet-level NSGs for broad tier rules (simpler, consistent).

---

## 12.6 UI Steps — Creating & Attaching an NSG

```
📍 START: portal.azure.com → search "Network security groups" → "+ Create"
    ↓
Choose Subscription, Resource Group, Name ("web-nsg"), Region
→ "Review + create" → "Create"
    ↓
📍 Open the NSG → left menu → "Inbound security rules" → "+ Add"
    ↓
   ┌──────────────────────────────────────┐
   │ Source:            Service Tag         │
   │ Source service tag: Internet           │
   │ Destination:       Any                 │
   │ Service:           HTTPS (auto = 443)  │
   │ Action:            Allow               │
   │ Priority:          100                 │
   │ Name:              Allow-HTTPS         │
   └──────────────────────────────────────┘
    ↓
Click "Add"
    ↓
📍 ATTACH IT: NSG left menu → "Subnets" → "+ Associate"
   → choose your VNet + subnet ("web-subnet") → "OK"

📍 RESULT: web-subnet now only allows inbound HTTPS from the internet
   (plus Azure defaults), blocking everything else inbound.
```

**Note the "Service Tag":** Instead of memorizing Azure IP ranges, use labels like `Internet`, `VirtualNetwork`, `AzureLoadBalancer`, `Storage` — Azure keeps them updated automatically.

---

## 12.7 Common Beginner Mistake (Interviewers Probe This)

```
⚠️ NEVER DO THIS:
Priority │ Source │ Port │ Action
  100    │ Any    │ 22   │ Allow    ← opens SSH to the ENTIRE internet!

Bots continuously scan the internet brute-forcing ports 22 (SSH) and
3389 (RDP). Always restrict management ports to a specific office IP,
or better, use Azure Bastion so you never expose them at all.
```

---

## 12.8 Real-World Example

```
3-tier app secured with subnet NSGs:
   web-subnet NSG: allow 80/443 from Internet
   app-subnet NSG: allow app-port ONLY from web-subnet
   db-subnet NSG:  allow 1433 ONLY from app-subnet
   (all: deny everything else — the default)

Result: database only reachable from app tier — even a breached web
server can't reach it directly. Defense in depth.
```

---

## 12.9 Interview Q&A

**Q: How does an NSG decide which rule wins?**
> Rules are evaluated by priority number, lowest first, and the first matching rule wins — evaluation stops there. There's a hidden default "deny all inbound" at the bottom, so anything not explicitly allowed is blocked.

**Q: What does "stateful" mean for an NSG?**
> If you allow an inbound request, the outbound response for that same connection is automatically allowed without needing a separate rule, because Azure tracks the connection state.

**Q: Can you attach an NSG to both a subnet and a NIC?**
> Yes. When both exist, traffic must be allowed by both to pass — the subnet NSG is checked first for inbound, then the NIC NSG.

---

## 12.10 Summary

A Network Security Group is Azure's virtual firewall — a prioritized list of allow/deny rules (lowest priority number wins, with a default deny-all backstop) controlling inbound/outbound traffic. NSGs are stateful (return traffic auto-allowed) and attach at both subnet and NIC level for layered control. Use Service Tags instead of raw IP ranges, never expose SSH/RDP to "Any" source, and apply subnet-level NSGs per tier to build defense-in-depth architectures.

---
---

# 13. 🏷️ Application Security Groups (ASG)
> 🟠 MEDIUM

---

## 13.1 What Problem Does This Solve?

Imagine 20 web servers that all need a rule allowing them to reach the database tier. Without ASGs, you'd have to list all 20 IP addresses in your NSG rule — and update that list every time autoscaling adds or removes a server (which happens constantly). **Application Security Groups (ASGs)** solve this by letting you group VMs by *role* and reference that role name in NSG rules instead of fragile IP lists.

> 💡 **If you know AWS:** An ASG is like referencing "another Security Group" as a source in an AWS Security Group rule — you group by role, not by IP.

---

## 13.2 The Problem & Solution (Flow Diagram)

```
❌ WITHOUT ASGs — brittle, breaks with autoscaling:
   NSG rule: Allow FROM [10.0.1.4, 10.0.1.5, 10.0.1.6, ...20 IPs...]
   Problem: every new autoscaled VM has a new IP → must edit the rule
   every time → impossible to keep accurate

✅ WITH ASGs — robust, autoscaling-friendly:

   ┌──────────────────────────┐         ┌──────────────────────────┐
   │  ASG: "web-servers"       │         │  ASG: "db-servers"        │
   │   ├── web-vm-1            │  NSG    │   ├── db-vm-1             │
   │   ├── web-vm-2            │  rule:  │   └── db-vm-2             │
   │   └── web-vm-3 (auto-added)│  allow →│                          │
   └──────────────────────────┘  1433   └──────────────────────────┘

   NSG rule: Allow FROM "web-servers" (ASG) TO "db-servers" (ASG) on 1433

   New autoscaled VM? Just add it to "web-servers" ASG → the rule
   applies to it automatically. Zero rule edits.
```

---

## 13.3 UI Steps — Creating an ASG and Using It

```
📍 START: portal.azure.com → search "Application security groups" → "+ Create"
    ↓
Choose Subscription, RG, Name ("web-servers-asg"), Region
→ "Review + create" → "Create"
   (repeat to create "db-servers-asg")
    ↓
📍 ADD VMs to the ASG: open a VM → left menu "Networking" →
   click the network interface → "Application security groups" →
   "Configure the application security groups" → select "web-servers-asg" → Save
    ↓
📍 USE the ASG in an NSG rule: open your NSG → "Inbound security rules"
   → "+ Add" →
   ┌──────────────────────────────────────────┐
   │ Source:      Application security group    │
   │ Source ASG:  web-servers-asg               │
   │ Destination: Application security group    │
   │ Dest ASG:    db-servers-asg                │
   │ Port:        1433                          │
   │ Action:      Allow                         │
   └──────────────────────────────────────────┘
   → "Add"

📍 RESULT: Any VM in "web-servers-asg" can reach any VM in "db-servers-asg"
   on 1433 — and it stays correct automatically as VMs come and go.
```

---

## 13.4 Real-World Example

```
An autoscaling web tier + a database tier:

Step 1: Create "web-asg" and "db-asg".
Step 2: Add all web VMs to "web-asg", all db VMs to "db-asg".
Step 3: NSG rule: allow web-asg → db-asg on 1433.
Step 4: During a traffic spike, the VM Scale Set adds 5 new web VMs.
        You just ensure they join "web-asg" (Scale Sets can be configured
        to do this automatically) → the security rule instantly applies
        to them, with zero manual rule changes.

This is why ASGs are essential when working with autoscaling.
```

---

## 13.5 Interview Q&A

**Q: What's the difference between an NSG and an ASG?**
> An NSG is the firewall itself — the actual allow/deny rules. An ASG is a logical grouping of VMs by role (like "web-servers") that you reference *inside* NSG rules instead of hardcoding IP addresses. ASGs make rules stay correct automatically as VMs are added/removed by autoscaling.

**Q: Why are ASGs especially important with VM Scale Sets?**
> Because autoscaling constantly changes which VMs (and IPs) exist. An IP-based NSG rule would need constant manual updates, but an ASG-based rule just requires new VMs to join the ASG — the rule then applies automatically, with no edits.

---

## 13.6 Summary

Application Security Groups let you write NSG rules based on VM *roles* (like "web-servers" → "db-servers") instead of brittle, hardcoded IP lists. This is essential with autoscaling VM Scale Sets, where the set of VMs and IPs constantly changes — new VMs simply join the ASG and existing rules apply automatically. ASGs are always used *together with* NSGs (the ASG is referenced as a source/destination inside an NSG rule).

---
---

# 14. 🧭 Route Tables / User-Defined Routes (UDR)
> 🟠 MEDIUM

---

## 14.1 What Problem Does This Solve?

By default, Azure automatically routes traffic sensibly — within a VNet, and out to the internet for resources with public IPs. But sometimes you need to **override** this default routing — most commonly, to force all outbound traffic through a security appliance (like Azure Firewall) for inspection, instead of letting it go straight to the internet. A **Route Table** (containing **User-Defined Routes, UDRs**) lets you do this.

> 💡 **If you know AWS:** A Route Table / UDR is the direct equivalent of an **AWS Route Table**. Same concept — rules that say "traffic to this destination goes to this next hop."

---

## 14.2 How Custom Routing Works (Flow Diagram)

```
DEFAULT (no custom route table):
   App VM's outbound traffic → straight to the internet
   (hard to inspect or control)

WITH a Route Table forcing traffic through a firewall:

   App VM (in app-subnet)
       ↓ wants to reach the internet (0.0.0.0/0)
   Route Table on app-subnet says:
       "0.0.0.0/0 → Next hop: Azure Firewall (10.0.99.4)"
       ↓
   Traffic goes to Azure Firewall FIRST
       ↓ firewall inspects & allows/denies
   → then out to the internet (if allowed)

Now ALL outbound traffic is inspected/controlled centrally.
```

`0.0.0.0/0` is special CIDR meaning "everything / all destinations" — a catch-all.

---

## 14.3 Route Components

| Field | Meaning | Example |
|---|---|---|
| **Address Prefix** | The destination range | `0.0.0.0/0` (everything) |
| **Next Hop Type** | Where to send it | `Virtual Appliance`, `Internet`, `VirtualNetwork`, `VNet Peering` |
| **Next Hop Address** | Specific IP (for Virtual Appliance) | `10.0.99.4` (the firewall's IP) |

**Most specific route wins** (longest prefix match) — same as AWS.

---

## 14.4 UI Steps — Creating a Route Table and Forcing Traffic Through a Firewall

```
📍 START: portal.azure.com → search "Route tables" → "+ Create"
    ↓
Choose Subscription, RG, Name ("app-subnet-routes"), Region → Create
    ↓
📍 Open the route table → left menu "Routes" → "+ Add"
    ↓
   ┌──────────────────────────────────────────┐
   │ Route name:       force-through-firewall   │
   │ Address prefix:   0.0.0.0/0                 │
   │ Next hop type:    Virtual appliance         │
   │ Next hop address: 10.0.99.4  (firewall IP)  │
   └──────────────────────────────────────────┘
    ↓
Click "Add"
    ↓
📍 ATTACH to a subnet: route table left menu → "Subnets" → "+ Associate"
   → choose VNet + "app-subnet" → OK

📍 RESULT: All outbound traffic from app-subnet is now routed through
   the firewall for inspection instead of going straight to the internet.
```

---

## 14.5 Real-World Example

```
A company must inspect and log ALL outbound internet traffic from
their application servers for compliance:

Step 1: Deploy Azure Firewall (Section 26) into AzureFirewallSubnet.
Step 2: Create a Route Table with 0.0.0.0/0 → the firewall's private IP.
Step 3: Attach it to all application subnets.
Step 4: Now every outbound connection from those subnets flows through
        the firewall, where it's inspected against allow-rules (e.g.,
        "only *.windowsupdate.com and *.paymentgateway.com allowed")
        and logged for the compliance audit trail.

Without the UDR, the firewall would exist but traffic would bypass it —
the Route Table is what actually forces traffic through it.
```

---

## 14.6 Interview Q&A

**Q: What is a User-Defined Route and when do you use one?**
> A UDR is a custom routing rule in a Route Table that overrides Azure's default routing. The most common use is forcing outbound traffic through a network virtual appliance (like Azure Firewall) for inspection, by setting a route of 0.0.0.0/0 to the firewall's IP and attaching it to a subnet.

**Q: What does a next hop of "0.0.0.0/0 → Virtual Appliance" achieve?**
> It redirects all traffic (0.0.0.0/0 = everything) to a specified appliance (like a firewall) instead of its default path — so all traffic gets inspected/controlled before proceeding.

---

## 14.7 Summary

A Route Table containing User-Defined Routes (UDRs) lets you override Azure's default network routing — most commonly to force outbound traffic from a subnet through a security appliance like Azure Firewall for inspection and logging. A route specifies a destination prefix (e.g., 0.0.0.0/0 for everything), a next hop type/address, and is attached to one or more subnets. Remember: deploying a firewall alone doesn't route traffic through it — the UDR is what actually forces the traffic to flow through it.

---
---

# 15. 🔌 Service Endpoints
> 🟠 MEDIUM

---

## 15.1 What Problem Does This Solve?

By default, when a VM in your VNet talks to an Azure PaaS service like Blob Storage or Azure SQL, that traffic goes out over the public internet to the service's public endpoint — even though both are within Azure. This is a security concern (the service is reachable from the internet) and can be slower. A **Service Endpoint** improves this by extending your VNet's identity to the Azure service over Microsoft's backbone, and letting you restrict the service to only accept traffic from your VNet.

> 💡 **If you know AWS:** A Service Endpoint is loosely similar to an AWS **Gateway VPC Endpoint** (for S3/DynamoDB) — it keeps traffic on the cloud backbone and lets you lock the service to your network. But note: the service still uses its *public* IP with a Service Endpoint (unlike Private Endpoints, next section, which give it a private IP). Private Endpoint ≈ AWS PrivateLink/Interface Endpoint and is the more complete isolation.

---

## 15.2 How Service Endpoints Work (Flow Diagram)

```
WITHOUT a Service Endpoint:
   VM in VNet → out to internet → Storage public endpoint
   (Storage is reachable from the whole internet by default)

WITH a Service Endpoint:
   VM in VNet → Microsoft backbone (stays off public internet)
              → Storage
   PLUS: you configure the Storage account firewall to
   "only accept traffic from web-subnet in production-vnet"
       ↓
   Now the Storage account rejects traffic from anywhere else —
   even though it technically still has a public IP/endpoint.
```

**Key limitation to know:** The Azure service still uses its **public IP** with a Service Endpoint — the traffic just stays on the backbone and the service firewall restricts *who* can connect. For full private-IP isolation, you use a **Private Endpoint** (next section).

---

## 15.3 UI Steps — Enabling a Service Endpoint

```
📍 START: portal.azure.com → open your VNet → left menu "Subnets"
    ↓
Click the subnet (e.g., "web-subnet")
    ↓
Find "Service endpoints" → "Services" dropdown → select
   "Microsoft.Storage" (or Microsoft.Sql, etc.) → Save
    ↓
📍 NOW restrict the service side: open your Storage Account →
   left menu "Networking" → "Firewalls and virtual networks"
    ↓
Select "Enabled from selected virtual networks and IP addresses"
   → "+ Add existing virtual network" → choose production-vnet + web-subnet
   → Save

📍 RESULT: The Storage account now only accepts traffic from web-subnet,
   and that traffic travels over the Microsoft backbone instead of the
   public internet.
```

---

## 15.4 Real-World Example

```
A web app's VMs need to read from Blob Storage, and security wants that
Storage account NOT reachable from the general internet:

Step 1: Enable the Microsoft.Storage Service Endpoint on web-subnet.
Step 2: Configure the Storage account firewall to only allow web-subnet.
Step 3: Now, the web VMs can reach Storage (over the backbone), but
        someone with the Storage account's public URL from an outside
        network gets denied.

Note: For the STRONGEST isolation (giving Storage a private IP inside
the VNet, fully off the public internet), you'd use a Private Endpoint
instead — see the next section. Service Endpoints are simpler/free;
Private Endpoints are more complete.
```

---

## 15.5 Interview Q&A

**Q: What's a Service Endpoint?**
> It extends your VNet's identity to an Azure PaaS service (like Storage or SQL) over the Microsoft backbone, and lets you configure that service's firewall to only accept traffic from your VNet/subnet — improving security and keeping traffic off the public internet. However, the service still uses its public IP.

**Q: Service Endpoint vs Private Endpoint — what's the key difference?**
> A Service Endpoint keeps traffic on the backbone and restricts access via the service's firewall, but the service still uses its public IP. A Private Endpoint goes further — it gives the service a private IP address *inside your VNet*, so it's fully private with no public exposure at all. Private Endpoints are the more complete, more secure (but more involved) option.

---

## 15.6 Summary

A Service Endpoint extends your VNet's identity to an Azure PaaS service over Microsoft's backbone and lets you lock that service's firewall to accept only your VNet's traffic — improving security and performance without cost. Its limitation: the service still uses its public IP. For full private-IP isolation, use a Private Endpoint (next section). Service Endpoints are the lighter-weight option; Private Endpoints are the stronger, enterprise-grade choice.

---
---

# 16. 🔒 Private Endpoints
> 🔴 FULL

---

## 16.1 What Problem Does This Solve?

Service Endpoints (previous section) improve security but leave the Azure service on its public IP. For sensitive workloads — and for most enterprise/regulated environments — you want an Azure PaaS service (Storage, SQL, Key Vault) to be **completely private**, reachable only from within your network, with **no public internet exposure at all**. A **Private Endpoint** achieves this by giving the service a **private IP address inside your VNet**.

> 💡 **If you know AWS:** A Private Endpoint is the direct equivalent of an **AWS Interface VPC Endpoint (AWS PrivateLink)** — it projects a service into your VNet with a private IP, so traffic never touches the public internet. This is a ⭐⭐⭐ interview topic your checklist specifically flagged.

---

## 16.2 How Private Endpoints Work (Flow Diagram)

```
WITHOUT Private Endpoint:
   VM → (public internet or backbone) → Storage's PUBLIC endpoint
   Storage has a public IP, potentially reachable from outside

WITH Private Endpoint:

   ┌──────────────────────────────────────────────────────┐
   │  YOUR VNet: production-vnet (10.0.0.0/16)             │
   │                                                        │
   │   VM (10.0.1.5)                                        │
   │      ↓ connects to Storage using a PRIVATE IP          │
   │   ┌────────────────────────────────────┐             │
   │   │ Private Endpoint for Storage         │             │
   │   │ Private IP: 10.0.1.20                │  ← Storage now
   │   │ (a network interface INSIDE your VNet)│    has a private
   │   └────────────────────────────────────┘    IP in YOUR network!
   └──────────────────────────────────────────────────────┘
              ↓ (private link over Microsoft backbone)
        Azure Storage account
        (its public endpoint can be fully DISABLED)

   Result: The VM reaches Storage at 10.0.1.20 — a private IP inside
   the VNet. Storage has NO public exposure. Even works from
   on-premises over VPN/ExpressRoute.
```

---

## 16.3 The Role of Private DNS

A key detail: when you create a Private Endpoint, the service's normal DNS name (e.g., `mystorageacct.blob.core.windows.net`) needs to resolve to the **private IP** (10.0.1.20) instead of the public one. This is handled by an automatically-created (or linked) **Private DNS Zone** (Section 22), so your applications keep using the normal name and it transparently resolves to the private IP.

```
App asks DNS for: mystorageacct.blob.core.windows.net
   ↓ (Private DNS Zone linked to your VNet)
Resolves to: 10.0.1.20  (the private endpoint's IP, NOT the public IP)
   ↓
App connects privately — no code change needed
```

---

## 16.4 UI Steps — Creating a Private Endpoint (for a Storage Account)

```
📍 START: portal.azure.com → open your Storage Account
    ↓
Left menu → "Networking" → "Private endpoint connections" tab
   → "+ Private endpoint"
    ↓
── Basics ──
   Name: storage-pe, Region: (same as VNet)
    ↓
── Resource ──
   Target sub-resource: "blob" (for Blob Storage)
    ↓
── Virtual Network ──
   ┌──────────────────────────────────────────┐
   │ Virtual network: production-vnet           │
   │ Subnet:          web-subnet                │
   └──────────────────────────────────────────┘
    ↓
── DNS ──
   "Integrate with private DNS zone": Yes
   (Azure auto-creates/links the Private DNS Zone so the name resolves
    to the private IP)
    ↓
"Review + create" → "Create"
    ↓
📍 THEN disable public access: Storage → Networking → "Public network
   access" → set to "Disabled"

📍 RESULT: The Storage account now has a private IP inside your VNet,
   its public endpoint is disabled, and apps using the normal DNS name
   transparently reach it privately.
```

---

## 16.5 Real-World Example

```
A bank's application must access Azure SQL Database with ZERO public
internet exposure, for regulatory compliance:

Step 1: Create a Private Endpoint for the Azure SQL server, placing its
        private IP in the data-subnet of the bank's VNet.
Step 2: Enable Private DNS integration so the SQL server's normal
        hostname resolves to that private IP.
Step 3: Disable public network access on the SQL server entirely.
Step 4: The application (running on VMs in the same VNet) connects to
        SQL using the normal connection string — DNS transparently
        routes it to the private IP. On-premises staff connecting via
        ExpressRoute also reach it privately.

Result: The database is completely invisible from the public internet —
it has no reachable public endpoint at all — satisfying strict
compliance requirements, while applications need zero code changes.
```

---

## 16.6 Service Endpoint vs Private Endpoint (Side-by-Side)

| | Service Endpoint | Private Endpoint |
|---|---|---|
| Service gets a private IP in your VNet? | ❌ No (still public IP) | ✅ Yes |
| Public endpoint can be fully disabled? | Partially (firewall restricts) | ✅ Yes, completely |
| Works from on-premises (VPN/ExpressRoute)? | ❌ No | ✅ Yes |
| Cost | Free | Has an hourly + data cost |
| Best for | Basic hardening, cost-sensitive | Enterprise, regulated, strongest isolation |

---

## 16.7 Interview Q&A

**Q: What is a Private Endpoint?**
> It's a network interface that gives an Azure PaaS service (like Storage, SQL, or Key Vault) a private IP address inside your VNet, so it's reachable privately with no public internet exposure. It uses Azure Private Link over the Microsoft backbone, and typically pairs with a Private DNS Zone so the service's normal hostname resolves to the private IP.

**Q: How is a Private Endpoint different from a Service Endpoint?**
> A Service Endpoint keeps traffic on the backbone and restricts access via the service's firewall, but the service still has a public IP. A Private Endpoint gives the service an actual private IP inside your VNet, letting you fully disable its public endpoint — providing complete private isolation. Private Endpoints also work from on-premises over VPN/ExpressRoute, which Service Endpoints don't.

**Q: Why is Private DNS important for Private Endpoints?**
> Because the service's normal DNS name needs to resolve to the new private IP instead of the public one. A Private DNS Zone linked to your VNet handles this automatically, so applications keep using the standard hostname/connection string with no code changes, and it transparently routes to the private endpoint.

---

## 16.8 Summary

A Private Endpoint projects an Azure PaaS service (Storage, SQL, Key Vault, etc.) into your VNet with a private IP, enabling completely private access with no public internet exposure — the equivalent of AWS PrivateLink/Interface Endpoints, and a ⭐⭐⭐ interview topic. It relies on a Private DNS Zone to transparently resolve the service's normal hostname to the private IP, so applications need no code changes. Choose Private Endpoints over Service Endpoints for enterprise/regulated workloads needing the strongest isolation and on-premises connectivity; Service Endpoints remain a simpler, free, lighter-weight alternative.

---

---
---

# 17. 🔗 VNet Peering
> 🟠 MEDIUM

---

## 17.1 What Problem Does This Solve?

Real organizations rarely have just one VNet. You might have a "shared services" VNet (with common tools like DNS, monitoring, firewall) and separate VNets for different applications or teams. These VNets need to communicate privately — but by default, separate VNets are completely isolated from each other. **VNet Peering** connects them so resources can talk using private IPs, over Microsoft's backbone, as if they were on the same network.

> 💡 **If you know AWS:** VNet Peering is the direct equivalent of **AWS VPC Peering** — including the same critical limitation: peering is **not transitive** (if A peers with B and B peers with C, A cannot reach C through B).

---

## 17.2 How Peering Works (Flow Diagram)

```
┌─────────────────────────┐         ┌─────────────────────────┐
│  VNet-A                  │         │  VNet-B                  │
│  "shared-services-vnet"  │◄───────►│  "application-vnet"      │
│  10.0.0.0/16             │ PEERING │  10.1.0.0/16             │
│                          │         │                          │
│  DNS, monitoring, firewall│        │  App VMs, databases      │
└─────────────────────────┘         └─────────────────────────┘

A VM in VNet-A can reach a VM in VNet-B using its PRIVATE IP,
over Microsoft's fast backbone — never touching the public internet.

⚠️ Address spaces must NOT overlap (10.0.x vs 10.1.x — good).
⚠️ Peering is NOT transitive:
      VNet-A ↔ VNet-B ↔ VNet-C
      A↔B works, B↔C works, but A CANNOT reach C through B.
      To connect A and C, create a direct A↔C peering.
```

---

## 17.3 Key Rules

```
✅ Address spaces must NOT overlap between peered VNets
✅ Peering is NOT transitive (no "hopping" through a middle VNet)
✅ Works same-region, cross-region (Global Peering), and even across
   different subscriptions/tenants
✅ Low latency, high bandwidth — traffic stays on Microsoft's backbone
✅ Peering must be established on BOTH sides (A→B and B→A) to work fully
   (the portal can do both at once if you have permissions on both)
```

---

## 17.4 UI Steps — Creating a VNet Peering

```
📍 START: portal.azure.com → open VNet-A ("shared-services-vnet")
    ↓
Left menu → "Peerings" → "+ Add"
    ↓
   ┌──────────────────────────────────────────────────┐
   │ This VNet:                                          │
   │   Peering link name: shared-to-app                  │
   │ Remote VNet:                                        │
   │   Peering link name: app-to-shared                  │
   │   Virtual network:   application-vnet               │
   │   ✅ Allow traffic to/from remote VNet              │
   └──────────────────────────────────────────────────┘
    ↓
Click "Add"

📍 RESULT: Azure creates BOTH sides of the peering at once (if you have
   access to both VNets). Resources in each VNet can now reach each
   other via private IPs.
```

---

## 17.5 Real-World Example

```
A company centralizes shared infrastructure and connects team VNets to it:

shared-services-vnet: contains Azure Firewall, DNS servers, monitoring
application-vnet:      contains the actual application VMs/databases

Step 1: Peer application-vnet ↔ shared-services-vnet.
Step 2: Now the application VNet can use the centralized DNS and route
        its traffic through the shared firewall — without duplicating
        those tools in every VNet.

This "one central hub VNet, multiple connected VNets" idea is the basis
of the Hub-and-Spoke topology — the next section.
```

---

## 17.6 Interview Q&A

**Q: What is VNet Peering?**
> It connects two VNets so their resources can communicate using private IPs over Microsoft's backbone, as if on the same network — without traversing the public internet. It works same-region, cross-region, and across subscriptions/tenants.

**Q: Is VNet Peering transitive?**
> No. If VNet-A peers with VNet-B, and VNet-B peers with VNet-C, VNet-A cannot reach VNet-C through B. You'd need a direct A↔C peering. This non-transitivity is a key limitation and a common interview question.

**Q: What's a requirement for two VNets to be peered?**
> Their address spaces must not overlap, since overlapping ranges would make routing ambiguous.

---

## 17.7 Summary

VNet Peering privately connects two VNets over Microsoft's backbone so their resources communicate via private IPs — working same-region, cross-region (Global Peering), and across subscriptions. Remember the two key rules: address spaces must not overlap, and peering is **not transitive** (no hopping through a middle VNet). Peering is the building block for the Hub-and-Spoke topology, covered next.

---
---

# 18. 🎯 Hub-and-Spoke Topology
> 🔴 FULL

---

## 18.1 What Problem Does This Solve?

As an organization grows to many VNets (per team, per app, per environment), two problems emerge: (1) shared infrastructure like firewalls, DNS, and VPN gateways would have to be duplicated in every VNet (expensive and hard to manage), and (2) security and connectivity become inconsistent. The **Hub-and-Spoke topology** is the standard enterprise network design that solves both — and it's one of the most commonly asked network-design interview questions.

> 💡 **If you know AWS:** This is the same pattern as an AWS "Transit Gateway" / shared-services VPC design, or a hub VPC with peered spoke VPCs. The concept is cloud-agnostic — a central hub for shared services, with isolated spokes for workloads.

---

## 18.2 The Topology (Flow Diagram)

```
                    ┌─────────────────────────────┐
                    │   HUB VNet                   │
                    │   (shared services)          │
                    │                              │
                    │   • Azure Firewall           │
                    │   • VPN / ExpressRoute Gateway│
                    │   • DNS servers              │
                    │   • Azure Bastion            │
                    │   • Monitoring tools         │
                    └───────┬──────────┬───────────┘
                    PEERING │          │ PEERING
              ┌─────────────┘          └─────────────┐
              ↓                                        ↓
   ┌──────────────────────┐              ┌──────────────────────┐
   │  SPOKE VNet 1         │              │  SPOKE VNet 2         │
   │  (Team A's app)       │              │  (Team B's app)       │
   │  • App VMs            │              │  • App VMs            │
   │  • Databases          │              │  • Databases          │
   └──────────────────────┘              └──────────────────────┘

• Each spoke is ISOLATED from other spokes (peering isn't transitive!)
• Each spoke is PEERED to the hub, sharing the hub's central services
• Shared infrastructure (firewall, gateway, DNS) exists ONCE, in the hub
```

---

## 18.3 Why Organizations Use This Pattern

```
✅ Centralized security: ONE firewall in the hub inspects traffic for
   all spokes — configured and audited in one place
✅ Cost efficiency: expensive shared resources (VPN Gateway, Firewall,
   Bastion) exist once in the hub, not duplicated per spoke
✅ Isolation: spokes can't reach each other directly (peering isn't
   transitive), so a breach in Team A's spoke can't spread to Team B's
✅ Centralized connectivity: on-premises connectivity (VPN/ExpressRoute)
   terminates in the hub and is shared by all spokes
✅ Consistency: every spoke follows the same security/routing pattern
```

---

## 18.4 How Spokes Reach Each Other (When Needed) & the Internet

Since peering isn't transitive, if Spoke 1 genuinely needs to reach Spoke 2, or reach the internet through the hub's firewall, you use **User-Defined Routes (Section 14)** in the spokes pointing to the hub's firewall as the next hop:

```
Spoke 1 wants to reach the internet (or Spoke 2):
   UDR in Spoke 1: "0.0.0.0/0 → Hub's Azure Firewall IP"
       ↓
   Traffic routes to the hub's firewall
       ↓
   Firewall inspects it, then forwards to the internet (or to Spoke 2)

This gives centralized inspection AND controlled spoke-to-spoke
communication, all through the hub.
```

---

## 18.5 UI Steps — Building a Basic Hub-and-Spoke

```
📍 This combines pieces from earlier sections. High-level portal flow:

Step 1: Create the Hub VNet
   portal.azure.com → Virtual networks → + Create → "hub-vnet" (10.0.0.0/16)
   Add subnets: AzureFirewallSubnet, GatewaySubnet, AzureBastionSubnet

Step 2: Create Spoke VNets
   Create "spoke1-vnet" (10.1.0.0/16), "spoke2-vnet" (10.2.0.0/16)
   (non-overlapping ranges!)

Step 3: Peer each spoke to the hub
   Open hub-vnet → Peerings → + Add → peer with spoke1-vnet (both directions)
   Repeat for spoke2-vnet
   (Do NOT peer spoke1 ↔ spoke2 directly — keep them isolated)

Step 4: Deploy shared services in the hub
   Deploy Azure Firewall into AzureFirewallSubnet, Bastion into
   AzureBastionSubnet, VPN Gateway into GatewaySubnet

Step 5: Add UDRs in the spokes
   Create Route Tables on the spoke subnets: 0.0.0.0/0 → hub firewall IP
   Attach them, so all spoke traffic is inspected by the hub firewall

📍 RESULT: A production-standard enterprise network — isolated spokes,
   centralized shared services, consistent security.
```

---

## 18.6 Real-World Example

```
A company with three application teams:

hub-vnet: Azure Firewall (central egress inspection), VPN Gateway
          (single on-premises connection shared by all), Bastion
          (secure management access to all VMs), central DNS

spoke-team-a-vnet: Team A's app + database (isolated from B and C)
spoke-team-b-vnet: Team B's app + database (isolated from A and C)
spoke-team-c-vnet: Team C's app + database (isolated from A and B)

Benefits realized:
- One firewall to configure/audit for the whole company's egress
- One VPN connection to on-premises, not three
- One Bastion for secure VM access across all teams
- Teams fully isolated from each other — a compromised Team A server
  cannot reach Team B's database
- New team? Just add a new spoke and peer it to the hub — instant
  consistent security & connectivity

This is THE standard enterprise Azure network design — be ready to
draw it in an interview.
```

---

## 18.7 Interview Q&A

**Q: Explain the Hub-and-Spoke network topology.**
> It's an enterprise network design with a central "hub" VNet containing shared services (firewall, VPN/ExpressRoute gateway, DNS, Bastion), and multiple "spoke" VNets (one per team/app/environment) each peered to the hub. Spokes share the hub's central services but are isolated from each other. It centralizes security and connectivity, avoids duplicating expensive shared resources, and keeps workloads isolated.

**Q: How do spokes communicate with each other in a hub-and-spoke, given peering isn't transitive?**
> You use User-Defined Routes in the spokes pointing to the hub's firewall (or a router) as the next hop, so spoke-to-spoke traffic (and internet-bound traffic) routes through the hub for inspection. Direct spoke-to-spoke peering is deliberately avoided to maintain isolation and centralized control.

**Q: Why is hub-and-spoke better than just putting everything in one big VNet?**
> It provides isolation between teams/workloads (a breach in one spoke can't spread), centralizes shared/expensive infrastructure in one place, and enforces consistent security and connectivity patterns — all while remaining easy to extend by adding new spokes.

---

## 18.8 Summary

Hub-and-Spoke is the standard enterprise Azure network topology: a central hub VNet holds shared services (Azure Firewall, VPN/ExpressRoute Gateway, DNS, Bastion), and multiple spoke VNets — each peered to the hub — host isolated workloads. Spokes share the hub's services but can't reach each other directly (peering isn't transitive), giving strong isolation; when spoke-to-spoke or internet traffic is needed, UDRs route it through the hub's firewall for inspection. This design centralizes security and connectivity, avoids duplicating expensive resources, and scales cleanly by adding spokes — a must-know network-design interview topic.

---
---

# 19. 🌐 Azure Virtual WAN
> 🟡 KNOW-THIS-MUCH

---

## 19.1 What Problem Does This Solve?

Hub-and-spoke (previous section) works great within a region, but very large organizations have many offices, many regions, and complex global connectivity needs — managing all those peerings, VPN connections, and routing manually becomes overwhelming. **Azure Virtual WAN** is a managed service that automates and scales global network connectivity — think of it as "hub-and-spoke on autopilot, at global scale."

> 💡 **If you know AWS:** Virtual WAN is broadly comparable to **AWS Transit Gateway** (especially with Transit Gateway inter-region peering) — a managed, scalable hub for connecting many networks and sites globally.

---

## 19.2 What It Provides (Flow Diagram)

```
                  ┌─────────────────────────────────────┐
                  │      AZURE VIRTUAL WAN                │
                  │  (Microsoft-managed global backbone)  │
                  │                                       │
                  │   Virtual Hub        Virtual Hub      │
                  │   (Region 1)         (Region 2)       │
                  └──┬────┬────┬──────────┬────┬────┬─────┘
        ┌────────────┘    │    │          │    │    └────────────┐
   Branch Office 1   VNet A  VPN      ExpressRoute VNet B   Branch Office 2
   (SD-WAN/VPN)                                             (SD-WAN/VPN)

Virtual WAN automatically manages the connectivity and routing between:
  • Multiple branch offices (via VPN or SD-WAN)
  • Multiple VNets (spokes)
  • Multiple regions (via interconnected Virtual Hubs)
  • On-premises (via VPN and ExpressRoute)
All through Microsoft's managed global backbone.
```

---

## 19.3 When You'd Use It

```
Use Virtual WAN when:
  • You have MANY branch offices needing to connect to Azure
  • You operate across MANY Azure regions
  • You want Microsoft to manage the complex routing automatically
  • Manual hub-and-spoke + VPN management has become too complex

For smaller setups (a few VNets in one or two regions), plain
hub-and-spoke with VNet Peering (Section 18) is simpler and sufficient.
```

---

## 19.4 UI Steps — Creating a Virtual WAN

```
📍 START: portal.azure.com → search "Virtual WANs" → "+ Create"
    ↓
Choose Subscription, RG, Name ("global-vwan"), Region, Type (Standard)
→ "Review + create" → "Create"
    ↓
📍 Add a Virtual Hub: open the Virtual WAN → "Hubs" → "+ New Hub"
   → choose a region and hub address space
    ↓
📍 Connect things to the hub: within the hub, connect VNets, create
   VPN/ExpressRoute gateways, or connect branch sites — Virtual WAN
   handles the routing between them automatically.

📍 RESULT: A managed global network hub that automatically routes
   between your VNets, offices, and regions.
```

---

## 19.5 Real-World Example

```
A retail company with 200 stores across India, each needing secure
connectivity to central Azure-hosted systems:

Instead of manually setting up and managing 200 individual VPN
connections and complex routing, they use Azure Virtual WAN:
  • Each store connects via VPN/SD-WAN to the nearest Virtual Hub
  • Virtual Hubs in multiple regions are automatically interconnected
  • Central application VNets are connected as spokes
  • Microsoft manages all the routing automatically

Result: Global-scale connectivity that would be a nightmare to manage
manually, handled by a managed service.
```

---

## 19.6 Interview Q&A

**Q: What is Azure Virtual WAN and when would you use it?**
> It's a managed networking service that automates large-scale, global connectivity between many VNets, branch offices, and regions through Microsoft's managed backbone — essentially hub-and-spoke automated at global scale. You use it when you have many sites/regions and manual hub-and-spoke management has become too complex; for smaller setups, plain VNet Peering hub-and-spoke is simpler.

---

## 19.7 Summary

Azure Virtual WAN is a managed service that automates global-scale network connectivity — interconnecting many VNets, branch offices, and regions through Microsoft-managed Virtual Hubs, comparable to AWS Transit Gateway. It's the right choice for large enterprises with many sites and regions where manual hub-and-spoke and VPN management becomes unwieldy; for smaller deployments, standard hub-and-spoke with VNet Peering remains simpler and sufficient.

---
---

# 20. 🚪 NAT Gateway
> 🟡 KNOW-THIS-MUCH

---

## 20.1 What Problem Does This Solve?

Resources in a private subnet (with only private IPs) often still need to reach *out* to the internet — to download OS updates, call an external API, or pull packages — even though they should never be reachable *from* the internet. A **NAT Gateway** provides this controlled, one-way outbound internet access for private resources.

> 💡 **If you know AWS:** Azure NAT Gateway is the direct equivalent of the **AWS NAT Gateway** — same purpose: outbound-only internet for private subnets.

---

## 20.2 How It Works (Flow Diagram)

```
Private subnet VMs (private IPs only, e.g., 10.0.2.5)
       ↓ need to reach the internet (updates, APIs)
   ┌──────────────────────┐
   │   NAT Gateway         │  ← has a static Public IP
   │   (attached to subnet) │
   └──────────┬───────────┘
              ↓ (all outbound traffic appears to come FROM
                 the NAT Gateway's single public IP)
           Internet

Key properties:
  • OUTBOUND only — the internet CANNOT initiate connections back in
  • VMs keep their private IPs (never exposed)
  • All outbound traffic shares the NAT Gateway's public IP(s)
  • Provides a predictable, static outbound IP (useful for allow-listing
    with third-party APIs that require a known source IP)
```

---

## 20.3 UI Steps — Creating and Attaching a NAT Gateway

```
📍 START: portal.azure.com → search "NAT gateways" → "+ Create"
    ↓
   ┌──────────────────────────────────────────┐
   │ Name:       app-nat-gateway                │
   │ Region:     (same as your VNet)            │
   │ Public IP:  create new "app-nat-pip"       │
   └──────────────────────────────────────────┘
    ↓
On the "Subnet" tab → select the private subnet (e.g., "app-subnet")
    ↓
"Review + create" → "Create"

📍 RESULT: VMs in app-subnet can now reach the internet outbound
   (through the NAT Gateway's public IP), while remaining completely
   unreachable from the internet inbound. Notably, in Azure you attach
   the NAT Gateway directly to the subnet — no manual route table entry
   needed (simpler than some other clouds).
```

---

## 20.4 Real-World Example

```
Private app servers need to call an external payment API that requires
source-IP allow-listing (the payment provider only accepts requests
from IPs on their approved list):

Step 1: Attach a NAT Gateway (with a static public IP) to the app-subnet.
Step 2: Give the payment provider that static NAT Gateway IP to add to
        their allow-list.
Step 3: Now all outbound calls from any app server (even new autoscaled
        ones) appear to come from that single, predictable IP — so they
        pass the provider's allow-list — while the app servers themselves
        remain completely private and unreachable from the internet.
```

---

## 20.5 Interview Q&A

**Q: What is a NAT Gateway used for?**
> It provides outbound-only internet access for resources in a private subnet — so they can reach out (for updates, external APIs) while remaining unreachable from the internet inbound. It also gives a predictable static outbound public IP, useful for third-party API allow-listing.

**Q: How is attaching a NAT Gateway in Azure different from AWS?**
> In Azure you associate the NAT Gateway directly with the subnet, and it automatically handles outbound routing — you don't need to manually add a route table entry pointing to it (which AWS requires). It's a slightly simpler setup.

---

## 20.6 Summary

A NAT Gateway gives private-subnet resources controlled, outbound-only internet access — they can reach out for updates and external APIs while staying completely unreachable from the internet inbound. It provides a predictable static outbound IP (useful for third-party allow-listing) and, in Azure, attaches directly to a subnet without needing a manual route table entry. It's the standard, secure way to let private resources reach the internet.

---
---

# 21. 🌍 Azure DNS — Public Zones
> 🟡 KNOW-THIS-MUCH

---

## 21.1 What Problem Does This Solve?

Users reach your application via a friendly name like `www.myapp.com`, but computers need IP addresses. **DNS** translates names to addresses. **Azure DNS Public Zones** let you host your domain's public DNS records in Azure, so the internet can resolve your domain names to your Azure resources.

> 💡 **If you know AWS:** Azure DNS is Azure's equivalent of **Route 53's hosting** function. Key difference: Azure DNS does NOT register domains (you buy the domain elsewhere and point it at Azure); Route 53 can also register domains directly.

---

## 21.2 How It Works (Flow Diagram)

```
You own "myapp.com" (bought from a registrar like GoDaddy)
       ↓
You create a Public DNS Zone in Azure for "myapp.com"
       ↓
Azure gives you 4 name server addresses
       ↓
You update your registrar's settings to use those 4 Azure name servers
   (this "delegates" DNS management for the domain to Azure)
       ↓
Now a user types "www.myapp.com":
   Browser → asks DNS → Azure DNS Zone answers with the IP → browser connects
```

⚠️ **Key clarification:** Azure DNS hosts your *records* — it does not *sell/register* domain names. You register the domain separately and delegate it to Azure.

---

## 21.3 Common Record Types

| Record | Purpose | Example |
|---|---|---|
| **A** | Name → IPv4 address | `myapp.com → 20.50.11.45` |
| **CNAME** | Name → another name (alias) | `www.myapp.com → myapp.com` |
| **MX** | Where to deliver email | `myapp.com → mail server` |
| **TXT** | Text (domain verification, SPF) | proof of ownership |
| **Alias** | Azure-specific — points at an Azure resource, auto-updates if its IP changes, works at the root domain | `myapp.com → Application Gateway` |

**Use Alias records** (not CNAME) when pointing your root domain at an Azure resource like Application Gateway, Load Balancer, or Front Door — they work at the root/apex level and auto-track IP changes.

---

## 21.4 UI Steps — Creating a Public DNS Zone and a Record

```
📍 START: portal.azure.com → search "DNS zones" → "+ Create"
    ↓
   ┌────────────────────────────────┐
   │ Resource group: production-rg   │
   │ Name:           myapp.com       │
   └────────────────────────────────┘
   → "Review + create" → "Create"
    ↓
📍 Copy the 4 name servers shown on the Overview page → go to your
   domain registrar → update the domain's name servers to these 4.
    ↓
📍 Add a record: open the DNS zone → "+ Record set"
   ┌────────────────────────────────┐
   │ Name:  www                      │
   │ Type:  A  (or Alias)            │
   │ Value: 20.50.11.45              │
   └────────────────────────────────┘
   → "OK"

📍 RESULT: www.myapp.com now resolves to your resource. (DNS changes
   can take some time to propagate globally.)
```

---

## 21.5 Real-World Example

```
You've deployed a web app behind an Application Gateway and want it
reachable at myapp.com:

Step 1: Create a Public DNS Zone for "myapp.com" in Azure.
Step 2: Delegate the domain to Azure's name servers at your registrar.
Step 3: Create an ALIAS record: myapp.com → the Application Gateway
        (Alias, so it works at the root and auto-updates if the
         gateway's IP ever changes).
Step 4: Create a CNAME: www.myapp.com → myapp.com (so both work).

Result: Customers reach your app at both myapp.com and www.myapp.com.
```

---

## 21.6 Interview Q&A

**Q: Does Azure DNS register domain names?**
> No — Azure DNS hosts the DNS records for a domain you already own, but you register the domain through a separate registrar and then delegate it to Azure's name servers. This differs from Route 53, which can also register domains.

**Q: When should you use an Alias record instead of a CNAME?**
> Use an Alias record when pointing your root/apex domain at an Azure resource (Application Gateway, Load Balancer, Front Door) — Alias records work at the root level (where CNAMEs aren't allowed) and automatically track the resource's IP if it changes.

---

## 21.7 Summary

Azure DNS Public Zones host your domain's public DNS records so the internet can resolve your domain names to Azure resources. Azure DNS hosts records but doesn't register domains — you register elsewhere and delegate to Azure's name servers. Use Alias records (not CNAME) when pointing root domains at Azure resources, since they work at the apex level and auto-track IP changes.

---
---

# 22. 🏠 Azure DNS — Private Zones
> 🟠 MEDIUM

---

## 22.1 What Problem Does This Solve?

Inside your VNet, resources need to find each other and find Azure services — but you don't want to hardcode private IP addresses everywhere (IPs change, and hardcoding is fragile). **Azure Private DNS Zones** let you use friendly internal names (like `db.internal.myapp.com` or a Private Endpoint's hostname) that resolve to private IPs, only within your VNet — no public internet exposure.

> 💡 **If you know AWS:** Private DNS Zones are the equivalent of **Route 53 Private Hosted Zones**. Same purpose — internal name resolution within your private network.

---

## 22.2 How It Works (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  VNet: production-vnet                                    │
│  (linked to Private DNS Zone "internal.myapp.com")        │
│                                                            │
│   App VM asks: "what's the IP of db.internal.myapp.com?"   │
│       ↓                                                    │
│   Private DNS Zone answers: 10.0.3.8  (a PRIVATE IP)       │
│       ↓                                                    │
│   App connects to the database privately                   │
│                                                            │
│   (This name resolution ONLY works inside the linked VNet  │
│    — it's invisible to the public internet)                │
└──────────────────────────────────────────────────────────┘
```

---

## 22.3 The #1 Use Case: Private Endpoints

Recall from Section 16 that Private Endpoints give an Azure service a private IP inside your VNet. Private DNS Zones are what make the service's *normal hostname* resolve to that private IP automatically:

```
Without Private DNS: your app would have to know the raw private IP
   (10.0.1.20) of the Private Endpoint — fragile and awkward.

With Private DNS: the Storage account's normal name
   "mystorageacct.blob.core.windows.net" automatically resolves to the
   private IP 10.0.1.20 inside your VNet → app uses the normal name,
   no code changes, and it routes privately.

This is why "Integrate with private DNS zone: Yes" is a step when
creating a Private Endpoint.
```

---

## 22.4 UI Steps — Creating a Private DNS Zone and Linking It

```
📍 START: portal.azure.com → search "Private DNS zones" → "+ Create"
    ↓
   ┌────────────────────────────────┐
   │ Resource group: production-rg   │
   │ Name:  internal.myapp.com       │
   └────────────────────────────────┘
   → "Review + create" → "Create"
    ↓
📍 LINK it to your VNet: open the Private DNS Zone → left menu
   "Virtual network links" → "+ Add"
   ┌────────────────────────────────┐
   │ Link name:      prod-vnet-link  │
   │ Virtual network: production-vnet │
   └────────────────────────────────┘
   → "OK"
    ↓
📍 Add a record: in the zone → "+ Record set"
   Name: db,  Type: A,  Value: 10.0.3.8
   → "OK"

📍 RESULT: Resources inside production-vnet can now resolve
   "db.internal.myapp.com" → 10.0.3.8, privately. The zone is
   invisible from the public internet.
```

---

## 22.5 Real-World Example

```
A team wants clean internal service names instead of hardcoded IPs:

Private DNS Zone "internal.myapp.com" linked to production-vnet:
   db.internal.myapp.com     → 10.0.3.8  (database private IP)
   cache.internal.myapp.com  → 10.0.3.20 (Redis private IP)
   queue.internal.myapp.com  → 10.0.3.30 (Service Bus private endpoint)

Now application code connects to "db.internal.myapp.com" instead of a
raw IP. If the database's IP ever changes, they update ONE DNS record —
every application automatically picks up the change, with no code
redeployment. Plus, all these names are private and invisible to the
internet.
```

---

## 22.6 Interview Q&A

**Q: What's a Private DNS Zone used for?**
> Internal name resolution within your VNet(s) — mapping friendly names to private IPs that only resolve inside your linked networks, never exposed to the public internet. It's commonly used for clean internal service discovery and, critically, to make Private Endpoint hostnames resolve to their private IPs automatically.

**Q: How do Private DNS Zones relate to Private Endpoints?**
> When you create a Private Endpoint, the Azure service's normal public hostname needs to resolve to the new private IP. A Private DNS Zone linked to your VNet handles this automatically, so applications keep using the standard hostname/connection string with no code changes, and it transparently routes to the private endpoint.

---

## 22.7 Summary

Azure Private DNS Zones provide internal name resolution within your VNets — mapping friendly names to private IPs that only resolve inside linked networks, invisible to the public internet. Their most important use is making Private Endpoint hostnames automatically resolve to their private IPs (so apps need no code changes), and they also enable clean internal service discovery where you update one DNS record instead of hunting down hardcoded IPs across your applications.

---
---

# 23. ⚖️ Azure Load Balancer
> 🟠 MEDIUM

---

## 23.1 What Problem Does This Solve?

When you run multiple identical servers (e.g., a VM Scale Set of web servers), you need incoming traffic spread evenly across them, and you need traffic to automatically avoid any server that's unhealthy. A **Load Balancer** does exactly this — distributing traffic and providing high availability.

> 💡 **If you know AWS:** Azure Load Balancer operates at Layer 4 (TCP/UDP), making it the equivalent of an AWS **Network Load Balancer (NLB)**. For Layer 7 (HTTP-aware) routing, Azure uses Application Gateway (next section), which is like an AWS ALB.

---

## 23.2 How It Works (Flow Diagram)

```
                     Customers
                         ↓
              ┌────────────────────┐
              │   Load Balancer     │  ← single stable entry point
              │   (Layer 4: TCP/UDP)│
              └─────────┬──────────┘
       Health Probes    │  distributes traffic across healthy backends
     ┌──────────────────┼──────────────────┐
     ↓                  ↓                    ↓
  VM 1 ✅            VM 2 ✅              VM 3 ❌ (unhealthy)
  (gets traffic)    (gets traffic)       (NO traffic — probe failed)

The Load Balancer continuously health-probes each backend. Traffic
only goes to healthy VMs. If VM 3's probe fails, it's removed from
rotation automatically — customers never notice.
```

---

## 23.3 Key Concepts

| Concept | Meaning |
|---|---|
| **Frontend IP** | The entry-point IP (public or private) customers connect to |
| **Backend Pool** | The group of VMs/Scale Set that receives traffic |
| **Health Probe** | Repeated check (e.g., every 15s) determining which backends are healthy |
| **Load Balancing Rule** | Maps a frontend port to a backend port (e.g., frontend 443 → backend 443) |
| **Public vs Internal** | Public = internet-facing; Internal = private, for tier-to-tier traffic within the VNet |

**SKU:** Always use **Standard SKU** for production (supports Availability Zones, more secure defaults). Basic SKU is legacy/being retired.

---

## 23.4 UI Steps — Creating a Load Balancer

```
📍 START: portal.azure.com → search "Load balancers" → "+ Create"
    ↓
── Basics ──
   Name: web-lb, Region, Type: Public, SKU: Standard
    ↓
── Frontend IP configuration ──
   "+ Add" → create/select a Public IP ("web-lb-pip")
    ↓
── Backend pools ──
   "+ Add" → name it "web-backend" → add your VMs or VM Scale Set
    ↓
── Inbound rules → Load balancing rule ──
   ┌────────────────────────────────────┐
   │ Frontend port: 443                  │
   │ Backend port:  443                  │
   │ Backend pool:  web-backend          │
   │ Health probe:  create (HTTP, /, 15s) │
   └────────────────────────────────────┘
    ↓
"Review + create" → "Create"

📍 RESULT: Customers connect to the Load Balancer's public IP on 443;
   traffic is spread across all healthy VMs in the backend pool.
```

---

## 23.5 Real-World Example

```
A web app runs on a VM Scale Set that autoscales between 2 and 20 VMs:

Step 1: Create a Standard Public Load Balancer, backend pool = the Scale Set.
Step 2: Configure a health probe checking port 443 every 15 seconds.
Step 3: Point your domain (via Azure DNS Alias record) at the Load
        Balancer's public IP.

Now:
- Customers always hit one stable address (the LB)
- Traffic spreads evenly across however many VMs currently exist
- When autoscaling adds VMs, they auto-join the backend pool
- If a VM's app crashes, the health probe detects it within ~45 seconds
  and stops sending it traffic — zero customer-visible downtime
```

---

## 23.6 Interview Q&A

**Q: What layer does Azure Load Balancer operate at, and what does that mean?**
> Layer 4 (TCP/UDP). It makes routing decisions based on IP address and port only — it's extremely fast but can't inspect actual request content (like URL paths). For content-based routing, you'd use Application Gateway (Layer 7) instead.

**Q: How does a Load Balancer provide high availability?**
> Through health probes — it continuously checks each backend VM's health and only routes traffic to healthy ones. If a VM becomes unhealthy, it's automatically removed from rotation, so a single server failure doesn't cause customer-visible downtime.

**Q: Public vs Internal Load Balancer?**
> Public has a public IP and distributes internet-facing traffic; Internal has only a private IP and distributes traffic between internal tiers (e.g., app servers to a pool of internal API servers) that shouldn't be internet-reachable.

---

## 23.7 Summary

Azure Load Balancer distributes traffic across a backend pool of VMs at Layer 4 (TCP/UDP), using health probes to ensure traffic only reaches healthy servers — providing high availability without customers noticing individual failures. It works seamlessly with autoscaling Scale Sets (backend pool stays in sync automatically). Use Standard SKU for production, Public for internet-facing traffic, and Internal for tier-to-tier traffic. For HTTP-aware (Layer 7) routing, use Application Gateway instead — covered next.

---
---

# 24. 🚪 Application Gateway
> 🟠 MEDIUM

---

## 24.1 What Problem Does This Solve?

Azure Load Balancer (previous section) is fast but "dumb" — it only sees IPs and ports, not the actual content of web requests. Many real applications need smarter routing: send `/api/*` requests to one set of servers, `/images/*` to another, or route different domain names to different backends. This requires understanding HTTP — Layer 7 — which is what **Application Gateway** provides.

> 💡 **If you know AWS:** Application Gateway is Azure's equivalent of an AWS **Application Load Balancer (ALB)** — a Layer 7, HTTP-aware load balancer.

---

## 24.2 How It Works (Flow Diagram)

```
                    Customers (HTTPS)
                         ↓
              ┌──────────────────────────┐
              │   Application Gateway      │  ← Layer 7 (understands HTTP)
              │   (inspects URL path/host) │
              └───────────┬───────────────┘
        Routes based on the ACTUAL request content:
     ┌───────────────┬───────────────┬────────────────┐
     ↓               ↓                ↓                 ↓
  /api/*          /images/*        /admin/*          /* (default)
  API servers    Static servers   Admin servers     Web servers

A Load Balancer couldn't do this — it can't see "/api/" vs "/images/".
Application Gateway reads the request and routes intelligently.
```

---

## 24.3 Key Capabilities

| Capability | What It Does |
|---|---|
| **Path-based routing** | Route by URL path (`/api/*` → API pool) |
| **Host-based (multi-site) routing** | Route by domain (`shop.x.com` vs `blog.x.com`) |
| **SSL/TLS termination** | Handles HTTPS decryption, offloading it from backend servers |
| **WAF (Web Application Firewall)** | Optional add-on blocking common web attacks (Section 25) |
| **Autoscaling** | The v2 SKU scales the gateway itself with traffic |
| **Cookie-based session affinity** | Keep a user's requests going to the same backend |

---

## 24.4 UI Steps — Creating an Application Gateway with Path-Based Routing

```
📍 START: portal.azure.com → search "Application gateways" → "+ Create"
    ↓
── Basics ──
   Name: app-gw, Region, Tier: "WAF V2" (includes WAF) or "Standard V2"
   Choose the VNet + a dedicated subnet for the gateway
    ↓
── Frontends ──
   Add a Public IP for the gateway
    ↓
── Backends ──
   "+ Add backend pool" → "api-pool" (add API servers)
   "+ Add backend pool" → "web-pool" (add web servers)
    ↓
── Configuration → Routing rule ──
   Create a listener (HTTPS, 443, with a certificate)
   Add path-based rules:
   ┌────────────────────────────────────┐
   │ /api/*  → api-pool                  │
   │ /*      → web-pool (default)        │
   └────────────────────────────────────┘
    ↓
"Review + create" → "Create"

📍 RESULT: Requests to /api/* go to the API servers; everything else
   goes to the web servers — all through one gateway, one domain, one
   HTTPS certificate.
```

---

## 24.5 Real-World Example

```
An e-commerce platform with separate backend services:

Application Gateway (WAF V2 tier) routes by path:
   /api/catalog/*  → Product Catalog servers
   /api/payment/*  → Payment servers (isolated, extra-restricted subnet)
   /images/*       → Static content servers
   /*              → Main website servers

Plus:
   • SSL termination: customers connect via HTTPS; the gateway decrypts
     and forwards internally, offloading CPU work from backend servers
   • WAF enabled: blocks SQL injection / XSS attacks before they reach
     any backend (Section 25)
   • One domain, one certificate, intelligent routing to 4 different
     backend service pools

Result: A single smart entry point serving a complex microservices
backend, with built-in security.
```

---

## 24.6 Interview Q&A

**Q: What's the difference between Azure Load Balancer and Application Gateway?**
> Load Balancer operates at Layer 4 (TCP/UDP) — fast, but only routes based on IP and port. Application Gateway operates at Layer 7 (HTTP/HTTPS) — it inspects actual request content, enabling path-based and host-based routing, SSL termination, and an optional Web Application Firewall. Use Application Gateway when you need smart, content-aware routing for web traffic.

**Q: What is SSL/TLS termination and why is it useful?**
> The Application Gateway handles HTTPS decryption itself, then forwards requests to backend servers (often over plain HTTP within the private, secure VNet). This offloads the CPU-intensive encryption work from your application servers and centralizes certificate management at the gateway.

**Q: What is path-based routing?**
> Routing requests to different backend pools based on the URL path — e.g., `/api/*` goes to API servers while `/images/*` goes to static content servers — all through a single gateway and domain.

---

## 24.7 Summary

Application Gateway is Azure's Layer 7 (HTTP/HTTPS-aware) load balancer — the equivalent of an AWS ALB — capable of routing based on actual request content (path-based, host-based), terminating SSL to offload work from backend servers, and offering an optional built-in Web Application Firewall. Use it whenever you need intelligent, content-aware routing for web applications, versus the simpler, faster Layer 4 Azure Load Balancer for non-HTTP or pure IP/port distribution. Its WAF capability is covered next.

---

---
---

# 25. 🛡️ Web Application Firewall (WAF)
> 🟡 KNOW-THIS-MUCH

---

## 25.1 What Problem Does This Solve?

Your web application is exposed to the internet, which means it's constantly targeted by automated attacks — bots trying SQL injection, cross-site scripting, and other common exploits. Writing defenses against every known attack pattern yourself would be a full-time job. A **Web Application Firewall (WAF)** blocks these common web attacks automatically, before they ever reach your application.

> 💡 **If you know AWS:** Azure WAF is the equivalent of **AWS WAF** — and like AWS, it attaches to a Layer 7 entry point (Application Gateway or Front Door, similar to AWS WAF attaching to ALB/CloudFront).

---

## 25.2 How It Works (Flow Diagram)

```
Attacker's malicious request (e.g., SQL injection in a form field)
       ↓
┌──────────────────────────────────────────────┐
│  WAF (on Application Gateway or Front Door)    │
│  Inspects the request against known attack     │
│  patterns (OWASP Core Rule Set)                │
│       ↓                                        │
│  Recognizes SQL injection pattern → ❌ BLOCKED │
└──────────────────────────────────────────────┘
       ✗ (never reaches the backend)

Legitimate request
       ↓
   WAF inspects → looks clean → ✅ allowed through → backend servers
```

The WAF uses the **OWASP (Open Web Application Security Project) Core Rule Set** — an industry-standard, continuously-updated catalog of known attack patterns — so you get strong protection without writing detection rules yourself.

---

## 25.3 Common Attacks WAF Blocks

| Attack | What It Is |
|---|---|
| **SQL Injection** | Sneaking malicious database commands into form inputs |
| **Cross-Site Scripting (XSS)** | Injecting malicious scripts that run in other users' browsers |
| **Command Injection** | Trying to execute OS commands on your server |
| **Rate/bot abuse** | Flooding your app; custom rate-limiting rules can block this |

---

## 25.4 WAF Modes

| Mode | Behavior |
|---|---|
| **Detection** | Logs suspicious requests but doesn't block them — useful for testing/tuning before going live |
| **Prevention** | Actively blocks detected attacks — the production setting |

---

## 25.5 UI Steps — Enabling WAF (on Application Gateway)

```
📍 OPTION A — when creating an Application Gateway:
   On the Basics tab, choose Tier = "WAF V2" (instead of "Standard V2")
    ↓
📍 Configure the WAF Policy:
   portal.azure.com → search "Web Application Firewall policies" → "+ Create"
   ┌────────────────────────────────────────┐
   │ Policy for: Application Gateway          │
   │ Mode:       Prevention (blocks attacks)  │
   │ Managed rules: OWASP Core Rule Set (default)│
   │ Custom rules: e.g., rate-limit >1000/min per IP │
   └────────────────────────────────────────┘
    ↓
   Associate the policy with your Application Gateway (or a specific listener)

📍 RESULT: All web traffic through the gateway is now inspected and
   malicious requests are blocked before reaching your backend.
```

---

## 25.6 Real-World Example

```
An e-commerce site is being probed by bots attempting SQL injection
on the login form and scraping product data aggressively:

Step 1: Deploy Application Gateway with the WAF V2 tier.
Step 2: Attach a WAF Policy in Prevention mode with the OWASP Core Rule
        Set enabled — instantly blocking SQL injection, XSS, etc.
Step 3: Add a custom rate-limiting rule: block any IP making more than
        1,000 requests per minute — stopping the aggressive scrapers and
        brute-force login attempts.
Step 4: Initially run in Detection mode for a few days to ensure no
        legitimate traffic is being falsely blocked, then switch to
        Prevention mode.

Result: Common web attacks are blocked automatically at the edge,
before ever touching the application servers.
```

---

## 25.7 Interview Q&A

**Q: What is a WAF and where does it sit?**
> A Web Application Firewall inspects incoming web (HTTP/HTTPS) traffic for common attack patterns — like SQL injection and XSS — and blocks malicious requests before they reach your application. In Azure it attaches to a Layer 7 service: Application Gateway (regional) or Front Door (global).

**Q: What's the difference between Detection and Prevention mode?**
> Detection mode logs suspicious requests but lets them through — useful for testing and tuning to avoid false positives. Prevention mode actively blocks detected attacks — the setting used in production.

---

## 25.8 Summary

A Web Application Firewall (WAF) protects web applications by inspecting incoming traffic against the OWASP Core Rule Set and blocking common attacks (SQL injection, XSS, and more) before they reach your servers. It attaches to Application Gateway (regional) or Front Door (global), runs in Detection mode (log only, for tuning) or Prevention mode (actively block, for production), and supports custom rules like rate-limiting to stop bots and brute-force attempts.

---
---

# 26. 🔥 Azure Firewall
> 🟠 MEDIUM

---

## 26.1 What Problem Does This Solve?

NSGs (Section 12) control traffic based on IPs and ports, applied per-subnet or per-NIC. But large organizations need *centralized*, more *intelligent* network security — filtering by domain name (not just IP), automatically blocking known-malicious destinations, and managing all of it in one place across many subnets/VNets. **Azure Firewall** is a managed, cloud-native network firewall that provides this.

> 💡 **If you know AWS:** Azure Firewall is comparable to **AWS Network Firewall** — a managed, centralized, stateful firewall service (more capable than basic security-group/NACL filtering).

---

## 26.2 Azure Firewall vs NSG (Flow Diagram)

```
NSG = a lock on each door (per-subnet/NIC, filters by IP + port only)
Azure Firewall = a central security checkpoint everyone must pass through
                 (filters by IP, port, AND domain name; blocks known
                  threats; centrally managed)

Typical placement (in a Hub-and-Spoke, Section 18):

   Spoke VNets' outbound traffic
       ↓ (forced via UDR — Section 14)
   ┌──────────────────────────────────┐
   │  AZURE FIREWALL (in the hub)       │
   │  • Allow only *.windowsupdate.com  │  ← domain-based filtering
   │  • Allow only *.paymentgateway.com │    (NSGs can't do this!)
   │  • Block known-malicious IPs        │  ← threat intelligence
   │  • Log everything (compliance)      │
   └──────────────┬───────────────────┘
                  ↓ (only approved traffic proceeds)
               Internet
```

---

## 26.3 What Makes It More Powerful Than NSGs

| Capability | NSG | Azure Firewall |
|---|---|---|
| Filter by IP + port | ✅ | ✅ |
| Filter by domain name (FQDN) | ❌ | ✅ ("only allow *.microsoft.com") |
| Threat intelligence (auto-block known bad IPs) | ❌ | ✅ |
| Centralized across many VNets | ❌ (per subnet/NIC) | ✅ |
| Built-in high availability | You design it | ✅ built in |

---

## 26.4 UI Steps — Deploying Azure Firewall

```
📍 PREP: your VNet needs a subnet named EXACTLY "AzureFirewallSubnet"
   (open VNet → Subnets → + Subnet → name it AzureFirewallSubnet)
    ↓
📍 START: portal.azure.com → search "Firewalls" → "+ Create"
   ┌────────────────────────────────────────┐
   │ Name:          hub-firewall             │
   │ Region:        (same as VNet)           │
   │ Virtual network: hub-vnet               │
   │ Public IP:     create new               │
   └────────────────────────────────────────┘
   → "Review + create" → "Create"
    ↓
📍 Add rules: open the Firewall → "Rules" (or via a Firewall Policy) →
   Application rule collection:
   ┌────────────────────────────────────────┐
   │ Allow → *.windowsupdate.com (port 443)  │
   │ Allow → *.paymentgateway.com (port 443) │
   │ (everything else denied by default)     │
   └────────────────────────────────────────┘
    ↓
📍 Force traffic through it: create a Route Table (Section 14) with
   0.0.0.0/0 → firewall's private IP, attach to your spoke/app subnets

📍 RESULT: All outbound traffic from those subnets is inspected by the
   firewall — only approved domains allowed, known threats blocked,
   everything logged.
```

---

## 26.5 Real-World Example

```
A financial company must strictly control and audit ALL outbound
internet access from application servers, for compliance:

Step 1: Deploy Azure Firewall in the hub VNet's AzureFirewallSubnet.
Step 2: Configure Application Rules allowing ONLY the specific domains
        the apps legitimately need (Windows Update, the payment gateway).
Step 3: Enable Threat Intelligence — the firewall auto-blocks traffic
        to/from known-malicious IPs using Microsoft's threat feed.
Step 4: Force all spoke/app subnet outbound traffic through the firewall
        via UDRs.

Result: Even if an attacker breached an app server, they couldn't use
it to "phone home" to a malicious server — only two approved domains
are reachable. The security team has ONE central place to audit every
allowed outbound connection company-wide, satisfying compliance auditors.
```

---

## 26.6 Interview Q&A

**Q: When would you use Azure Firewall instead of (or in addition to) NSGs?**
> When you need centralized network security with capabilities NSGs lack — filtering by domain name (FQDN) rather than just IP/port, automatic threat-intelligence blocking of known-malicious IPs, and central management/auditing across many VNets. It's commonly placed in the hub of a hub-and-spoke topology to control and log all outbound traffic. NSGs still handle basic per-subnet/NIC filtering alongside it.

**Q: How do you actually force traffic through Azure Firewall?**
> By using a User-Defined Route (Route Table) with 0.0.0.0/0 pointing to the firewall's private IP, attached to the subnets whose traffic you want inspected. Deploying the firewall alone doesn't route traffic through it — the UDR does.

---

## 26.7 Summary

Azure Firewall is a managed, centralized, cloud-native network firewall offering capabilities NSGs lack: domain-name (FQDN) filtering, automatic threat-intelligence blocking, and central management/auditing across many VNets. It's typically deployed in the hub of a hub-and-spoke topology, with UDRs forcing spoke traffic through it for inspection and logging. Use NSGs for basic per-subnet/NIC rules and Azure Firewall for centralized, intelligent, auditable network control — especially for compliance-driven outbound traffic restriction.

---
---

# 27. 🛡️ DDoS Protection
> 🟡 KNOW-THIS-MUCH

---

## 27.1 What Problem Does This Solve?

A **DDoS (Distributed Denial of Service)** attack floods your application with massive fake traffic from thousands of sources, aiming to overwhelm it so real users can't get through. **Azure DDoS Protection** automatically detects and mitigates these attacks, keeping your application available.

> 💡 **If you know AWS:** Azure DDoS Protection is the equivalent of **AWS Shield** (Standard/Advanced tiers map to Azure's Basic/Network Protection tiers).

---

## 27.2 How It Works (Flow Diagram)

```
Attacker's botnet (thousands of machines) floods your app with fake traffic
       ↓
┌────────────────────────────────────────────────┐
│  AZURE DDoS PROTECTION                            │
│  • Continuously monitors traffic patterns         │
│  • Detects the abnormal flood (vs normal traffic) │
│  • Automatically "scrubs" — drops the attack       │
│    traffic while letting real traffic through      │
└──────────────────┬───────────────────────────────┘
                   ↓ (only legitimate traffic)
              Your application (stays available)
```

---

## 27.3 Two Tiers

| Tier | What You Get |
|---|---|
| **DDoS Network Protection (Basic)** | Automatically enabled for FREE on all Azure resources — baseline protection against common network-layer attacks |
| **DDoS Network Protection (paid)** | Enhanced protection — tuned to your app's traffic, attack analytics/reports, cost protection (credits for scale-out during an attack), and access to DDoS rapid-response experts |

---

## 27.4 UI Steps — Enabling DDoS Network Protection (paid tier)

```
📍 START: portal.azure.com → search "DDoS protection plans" → "+ Create"
    ↓
Choose Subscription, RG, Name, Region → "Review + create" → "Create"
    ↓
📍 Associate it with a VNet: open the DDoS plan (or the VNet →
   "DDoS protection") → enable it and link the VNet you want protected

📍 RESULT: Resources in that VNet get enhanced, tuned DDoS mitigation
   with attack telemetry and cost protection.
   (Note: the free Basic tier is already always-on for all resources,
    with no setup needed.)
```

---

## 27.5 Real-World Example

```
A public-facing e-commerce site during a major sale is a prime DDoS
target (attackers know it's high-value and high-traffic):

Step 1: Enable the paid DDoS Network Protection tier on the VNet hosting
        the public-facing Application Gateway/Front Door.
Step 2: During an actual attack, Azure automatically detects the abnormal
        traffic surge and scrubs the malicious traffic — real customers
        keep shopping, mostly unaware anything happened.
Step 3: After the attack, the team reviews the attack analytics report
        and receives cost-protection credits for any autoscaling that
        was triggered by the attack traffic.

Result: The site stays available through the attack, and the org isn't
penalized financially for scaling up to absorb it.
```

---

## 27.6 Interview Q&A

**Q: What does Azure DDoS Protection do, and what are the tiers?**
> It detects and mitigates DDoS attacks (floods of fake traffic aiming to make your app unavailable) by monitoring traffic patterns and automatically scrubbing attack traffic while letting legitimate traffic through. The Basic tier is free and always-on for all Azure resources; the paid Network Protection tier adds app-tuned mitigation, attack analytics, cost protection, and rapid-response support.

---

## 27.7 Summary

Azure DDoS Protection defends against Distributed Denial of Service attacks by automatically detecting abnormal traffic floods and scrubbing the malicious traffic while preserving legitimate access. The Basic tier is free and always-on for every Azure resource; the paid Network Protection tier adds tuned mitigation, attack analytics, cost protection, and expert support — worth it for high-value public-facing applications. It's Azure's equivalent of AWS Shield.

---
---

# 28. 🔍 Network Watcher
> 🟡 KNOW-THIS-MUCH

---

## 28.1 What Problem Does This Solve?

When network connectivity fails — "my VM can't reach the database, why?" — you need diagnostic tools to figure out *where* the traffic is being blocked or lost. **Network Watcher** is Azure's suite of network monitoring and diagnostic tools for troubleshooting exactly these problems. This is directly relevant to your JD's "troubleshoot deployment and operational issues end-to-end."

> 💡 **If you know AWS:** Network Watcher is comparable to AWS's **VPC Reachability Analyzer + VPC Flow Logs + network troubleshooting tools** combined.

---

## 28.2 Key Tools Within Network Watcher (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  NETWORK WATCHER — troubleshooting toolkit                │
│                                                            │
│  • IP Flow Verify: "Is traffic from IP-X to IP-Y on port  │
│    Z allowed or denied — and by WHICH NSG rule?"           │
│                                                            │
│  • NSG Diagnostics / Effective Security Rules: shows the   │
│    COMBINED effect of all NSG rules applied to a VM        │
│                                                            │
│  • Connection Troubleshoot: tests actual connectivity      │
│    between two points and shows where it fails             │
│                                                            │
│  • Next Hop: "if traffic leaves this VM heading to IP-X,   │
│    where does it actually go?" (checks routing/UDRs)       │
│                                                            │
│  • NSG Flow Logs: records all traffic through NSGs for     │
│    analysis (feeds Traffic Analytics)                      │
│                                                            │
│  • Packet Capture: captures actual network packets for     │
│    deep debugging                                          │
└──────────────────────────────────────────────────────────┘
```

---

## 28.3 The Most Useful Tool: IP Flow Verify

The single most practical troubleshooting tool — instantly answers "is this traffic allowed, and if not, which rule is blocking it?"

```
Scenario: "My app server can't reach the database on port 1433."

IP Flow Verify:
   Source:      app server's IP
   Destination: database's IP
   Port:        1433
   Direction:   Outbound
       ↓
   Result: "DENIED by NSG rule 'Deny-All' (priority 4096)"
       ↓
   Now you know EXACTLY why — you're missing an Allow rule for 1433.
   Add it, and the connection works.
```

---

## 28.4 UI Steps — Using IP Flow Verify

```
📍 START: portal.azure.com → search "Network Watcher" → open it
    ↓
Left menu → "IP flow verify"
    ↓
   ┌────────────────────────────────────────┐
   │ Virtual machine: app-vm-01              │
   │ Direction:       Outbound               │
   │ Protocol:        TCP                     │
   │ Local IP/port:   app-vm's IP             │
   │ Remote IP/port:  database IP : 1433      │
   └────────────────────────────────────────┘
    ↓
Click "Check"
    ↓
📍 RESULT: Azure tells you "Access Allowed" or "Access Denied" — and if
   denied, exactly which NSG rule is responsible. Instant root cause.
```

---

## 28.5 Real-World Example

```
An engineer reports: "The new app server can't connect to the SQL
database — the app just times out."

Troubleshooting with Network Watcher:
Step 1: IP Flow Verify from the app server to the DB on 1433 (outbound)
        → returns "Denied by NSG rule X"
Step 2: This immediately reveals the app-subnet's NSG is missing an
        Allow rule for port 1433 to the db-subnet.
Step 3: (If IP Flow said "Allowed"): use Next Hop to check whether a
        UDR is misrouting the traffic, or Connection Troubleshoot for
        a live end-to-end test.

Result: Instead of guessing for hours, the engineer pinpoints the exact
cause in minutes — a missing NSG rule — and fixes it.
```

---

## 28.6 Interview Q&A

**Q: How would you troubleshoot a VM that can't reach a database?**
> I'd use Network Watcher's IP Flow Verify — specifying the source, destination, and port — which instantly tells me whether the traffic is allowed or denied, and if denied, exactly which NSG rule is responsible. If it shows allowed, I'd use Next Hop to check for routing/UDR issues, or Connection Troubleshoot for a live end-to-end connectivity test.

**Q: What's Network Watcher?**
> Azure's suite of network diagnostic and monitoring tools — including IP Flow Verify, Effective Security Rules, Next Hop, Connection Troubleshoot, NSG Flow Logs, and Packet Capture — used to troubleshoot connectivity issues and understand traffic flow.

---

## 28.7 Summary

Network Watcher is Azure's network troubleshooting toolkit — its most practical tool, IP Flow Verify, instantly tells you whether traffic between two points on a given port is allowed or denied and which NSG rule is responsible, turning hours of guessing into minutes of diagnosis. Other tools (Next Hop for routing checks, Connection Troubleshoot for live tests, NSG Flow Logs for traffic recording, Packet Capture for deep debugging) round out the suite. This is directly relevant to the JD's emphasis on end-to-end operational troubleshooting.

---
---

# 29. 📡 Connection Monitor
> 🟡 KNOW-THIS-MUCH

---

## 29.1 What Problem Does This Solve?

Network Watcher's IP Flow Verify (previous section) is great for a one-time "is this allowed right now?" check. But sometimes you need *continuous, ongoing* monitoring of connectivity — "alert me if my app server ever loses its connection to the database, or if latency degrades." **Connection Monitor** (part of Network Watcher) provides this continuous connectivity monitoring over time.

> 💡 **If you know AWS:** Connection Monitor is loosely comparable to AWS's connectivity/reachability monitoring capabilities combined with CloudWatch-style ongoing alerting on network health.

---

## 29.2 How It Works (Flow Diagram)

```
Connection Monitor continuously tests a connection over time:

   Source (e.g., app-vm)  ──────test every 30s──────►  Destination
                                                        (e.g., database,
                                                         or an external URL)
       ↓
   Continuously measures:
   • Reachability (is it up or down?)
   • Latency (how fast is the round-trip?)
   • Packet loss (are packets being dropped?)
       ↓
   Feeds results into Azure Monitor → alerts you if connectivity
   drops or latency/loss crosses a threshold
```

Unlike a one-time check, this runs 24/7 and can alert you the moment connectivity degrades — often before users even notice.

---

## 29.3 UI Steps — Creating a Connection Monitor

```
📍 START: portal.azure.com → search "Network Watcher" → open it
    ↓
Left menu → "Connection monitor" → "+ Create"
    ↓
   ┌────────────────────────────────────────┐
   │ Name:        app-to-db-monitor           │
   │ Source:      app-vm (or an Azure agent)   │
   │ Destination: database IP:1433             │
   │              (or an external URL)         │
   │ Test frequency: every 30 seconds          │
   └────────────────────────────────────────┘
    ↓
Configure alert thresholds (e.g., alert if reachable drops below 100%,
or latency exceeds a limit) → "Create"

📍 RESULT: Azure continuously tests the connection and alerts you the
   moment it degrades or fails — proactive network monitoring.
```

---

## 29.4 Real-World Example

```
A payment application's servers depend on reaching an external payment
gateway. If that connection ever fails, payments stop — a critical issue.

Step 1: Set up a Connection Monitor from the app servers to the payment
        gateway's endpoint, testing every 30 seconds.
Step 2: Configure an alert: if reachability drops or latency spikes
        above the SLA threshold, immediately notify the on-call engineer.
Step 3: One day, the payment gateway has an outage. Connection Monitor
        detects the failed connectivity within seconds and alerts the
        team — who can immediately begin incident response and
        communicate with the payment provider, rather than finding out
        from a flood of customer complaints.

Result: Proactive detection of a critical dependency failure, faster
incident response.
```

---

## 29.5 Interview Q&A

**Q: What's the difference between IP Flow Verify and Connection Monitor?**
> IP Flow Verify is a one-time, on-demand check of whether specific traffic is allowed or denied right now (great for troubleshooting a reported issue). Connection Monitor is continuous — it tests a connection over time, measuring reachability, latency, and packet loss, and alerts you proactively when connectivity degrades, often before users notice.

---

## 29.6 Summary

Connection Monitor (part of Network Watcher) provides continuous, ongoing monitoring of network connectivity between two points — measuring reachability, latency, and packet loss over time, and alerting you proactively when things degrade. It complements the one-time IP Flow Verify check: use IP Flow Verify to diagnose a reported problem, and Connection Monitor to continuously watch critical connections (like an app-to-payment-gateway link) and catch failures before users do.

---
---

# 30. 🔐 VPN Gateway
> 🟡 KNOW-THIS-MUCH

---

## 30.1 What Problem Does This Solve?

Many organizations need to securely connect their on-premises office/datacenter network to their Azure VNet — so on-premises servers and Azure resources can communicate privately. A **VPN Gateway** creates an encrypted tunnel over the public internet to make this connection.

> 💡 **If you know AWS:** VPN Gateway is the equivalent of AWS's **Site-to-Site VPN / Virtual Private Gateway**. For dedicated private (non-internet) connectivity, both clouds offer a premium option — Azure's is ExpressRoute (next section), AWS's is Direct Connect.

---

## 30.2 How It Works (Flow Diagram)

```
┌──────────────────────────┐                    ┌──────────────────────────┐
│  On-Premises Network      │                    │  Azure VNet               │
│  (office / datacenter)    │                    │  "production-vnet"        │
│                           │                    │                           │
│  Servers, employees       │◄══════════════════►│  VMs, databases           │
│                           │  Encrypted VPN      │                           │
│  On-prem VPN device       │  tunnel over the    │  VPN Gateway (in the      │
│                           │  PUBLIC INTERNET    │  "GatewaySubnet")         │
└──────────────────────────┘                    └──────────────────────────┘

On-prem and Azure can now communicate using private IPs, securely,
over an encrypted tunnel — but the traffic still travels over the
public internet (just encrypted).
```

---

## 30.3 Two Connection Types

| Type | Connects | Use Case |
|---|---|---|
| **Site-to-Site (S2S)** | An entire on-premises network ↔ Azure VNet | Whole office/datacenter needs ongoing access |
| **Point-to-Site (P2S)** | A single device (e.g., one laptop) ↔ Azure VNet | Individual remote workers needing occasional secure access |

---

## 30.4 UI Steps — Creating a VPN Gateway (Site-to-Site)

```
📍 PREP: your VNet needs a subnet named EXACTLY "GatewaySubnet"
   (VNet → Subnets → + Subnet → name it GatewaySubnet)
    ↓
📍 START: portal.azure.com → search "Virtual network gateways" → "+ Create"
   ┌────────────────────────────────────────┐
   │ Name:          prod-vpn-gateway         │
   │ Gateway type:  VPN                       │
   │ VPN type:      Route-based               │
   │ Virtual network: production-vnet         │
   │ Public IP:     create new                │
   └────────────────────────────────────────┘
   → "Review + create" → "Create"
   (Note: gateway creation can take ~30-45 minutes)
    ↓
📍 Create a "Local network gateway" representing your on-prem network
   (its public IP + address ranges), then create a "Connection" between
   the VPN Gateway and the Local network gateway with a shared key.

📍 RESULT: An encrypted tunnel between on-premises and Azure — private
   communication over the public internet.
```

---

## 30.5 Real-World Example

```
A company's head office needs its employees to securely access an
internal admin dashboard hosted in Azure (which has no public IP):

Step 1: Deploy a VPN Gateway in the Azure VNet's GatewaySubnet.
Step 2: Set up a Site-to-Site VPN connecting the head office network
        to the Azure VNet.
Step 3: Now office employees reach the internal dashboard using its
        private IP (or an internal DNS name) — as if it were hosted on
        a server in their own building — with all traffic encrypted.
Step 4: A few work-from-home employees get individual Point-to-Site VPN
        connections on their laptops for the same secure access.

Result: Secure hybrid connectivity without exposing the internal
dashboard to the public internet.
```

---

## 30.6 Interview Q&A

**Q: What's a VPN Gateway and what's the difference between Site-to-Site and Point-to-Site?**
> A VPN Gateway creates an encrypted tunnel over the public internet connecting an external network to an Azure VNet. Site-to-Site connects an entire on-premises network to Azure (for whole offices/datacenters); Point-to-Site connects a single device like a laptop (for individual remote workers).

**Q: VPN Gateway vs ExpressRoute — when would you choose each?**
> VPN Gateway is quicker and cheaper to set up but runs over the public internet (encrypted, but with less predictable performance). ExpressRoute is a dedicated private connection that never touches the public internet — more consistent, higher bandwidth, but more expensive and involved. Use VPN for smaller needs or as a backup; ExpressRoute for high-bandwidth, latency-sensitive, or compliance-driven enterprise connectivity.

---

## 30.7 Summary

A VPN Gateway securely connects an on-premises network (Site-to-Site) or individual device (Point-to-Site) to an Azure VNet via an encrypted tunnel over the public internet. It requires a dedicated subnet named exactly "GatewaySubnet." It's the affordable, quick-to-deploy hybrid connectivity option — for higher-bandwidth, more consistent, private (non-internet) connectivity, organizations use ExpressRoute instead (next section), often keeping VPN as a backup.

---
---

# 31. 🔌 ExpressRoute
> 🟡 KNOW-THIS-MUCH

---

## 31.1 What Problem Does This Solve?

A VPN Gateway (previous section) is good, but its traffic travels over the public internet — so performance can be inconsistent, and for large enterprises with strict latency, bandwidth, or compliance requirements, that's not good enough. **ExpressRoute** provides a *dedicated, private* connection between on-premises and Azure that never touches the public internet at all.

> 💡 **If you know AWS:** ExpressRoute is the direct equivalent of **AWS Direct Connect** — a dedicated, private, high-bandwidth physical connection bypassing the public internet.

---

## 31.2 VPN Gateway vs ExpressRoute (Flow Diagram)

```
VPN GATEWAY:
   On-premises ──(encrypted tunnel over PUBLIC INTERNET)──► Azure
   • Cheaper, quick to set up
   • Performance depends on the public internet (variable latency)

EXPRESSROUTE:
   On-premises ──(dedicated PRIVATE fiber connection, via a
                  connectivity provider, NEVER touching the
                  public internet)──► Azure
   • Consistent low latency, high bandwidth (up to 100 Gbps)
   • More expensive, longer to provision (physical circuit)
   • Required for many compliance scenarios (data must not
     traverse the public internet)
```

---

## 31.3 Key Facts

```
✅ Private connection — traffic never touches the public internet
✅ Consistent, predictable latency and high bandwidth
✅ Set up through a connectivity provider (a telecom/network partner)
✅ Often used WITH a VPN Gateway as a backup (if ExpressRoute fails,
   traffic fails over to the VPN)
✅ ExpressRoute Global Reach can connect two on-premises sites to each
   other THROUGH the Microsoft backbone
✅ Requires a Gateway in the VNet (an ExpressRoute Gateway, in the
   GatewaySubnet)
```

---

## 31.4 UI Steps — Creating an ExpressRoute Circuit

```
📍 START: portal.azure.com → search "ExpressRoute circuits" → "+ Create"
   ┌────────────────────────────────────────┐
   │ Name:             prod-expressroute      │
   │ Provider:         [your connectivity     │
   │                    provider, e.g., a      │
   │                    telecom partner]       │
   │ Peering location: [nearest provider POP]  │
   │ Bandwidth:        1 Gbps (or up to 100)   │
   └────────────────────────────────────────┘
   → "Review + create" → "Create"
    ↓
📍 Azure generates a "Service Key" — you give this to your connectivity
   provider, who provisions the actual physical circuit on their side.
    ↓
📍 Once the provider confirms the circuit, create an ExpressRoute
   Gateway in your VNet's GatewaySubnet and link the circuit to your VNet.

📍 RESULT: A dedicated private connection between on-premises and Azure.
   (Note: unlike most Azure resources, this involves a physical circuit
    provisioned by a third-party provider — not purely self-service.)
```

---

## 31.5 Real-World Example

```
A bank runs a hybrid setup — core banking on-premises, analytics
microservices on Azure — with regulatory requirements that financial
data must NOT traverse the public internet, and strict low-latency needs:

Step 1: Provision a 10 Gbps ExpressRoute circuit through a connectivity
        provider, connecting the bank's Mumbai datacenter to Azure.
Step 2: Traffic between on-premises and Azure now flows over the
        dedicated private circuit — consistent sub-2ms latency, never
        touching the public internet (satisfying compliance).
Step 3: Keep a Site-to-Site VPN configured as an automatic backup — if
        the ExpressRoute circuit ever fails, traffic fails over to the
        VPN so connectivity isn't fully lost.

Result: High-performance, private, compliant hybrid connectivity with
redundancy.
```

---

## 31.6 Interview Q&A

**Q: What is ExpressRoute and when would you use it over a VPN Gateway?**
> ExpressRoute is a dedicated, private connection between on-premises and Azure (via a connectivity provider) that never touches the public internet — offering consistent low latency, high bandwidth, and compliance suitability. You'd choose it over a VPN Gateway for high-bandwidth, latency-sensitive, or compliance-driven enterprise workloads where the public-internet path of a VPN isn't acceptable. It's Azure's equivalent of AWS Direct Connect.

**Q: How do organizations make ExpressRoute resilient?**
> Commonly by keeping a Site-to-Site VPN Gateway configured as an automatic backup — if the ExpressRoute circuit fails, traffic fails over to the VPN, so connectivity isn't completely lost.

---

## 31.7 Summary

ExpressRoute provides a dedicated, private connection between on-premises and Azure that bypasses the public internet entirely — delivering consistent low latency, high bandwidth (up to 100 Gbps), and compliance suitability. It's Azure's equivalent of AWS Direct Connect, provisioned through a connectivity provider (involving a physical circuit), and is typically paired with a VPN Gateway as an automatic backup. Choose it over a VPN for high-performance, latency-sensitive, or regulated enterprise hybrid connectivity.

---
---

# 32. 🔑 Azure Key Vault
> 🔴 FULL

---

## 32.1 What Problem Does This Solve?

Applications need secrets — database passwords, API keys, certificates. The worst thing you can do is hardcode these in source code or config files, where they can leak (e.g., committed to Git) and are painful to rotate. **Azure Key Vault** is a secure, centralized store for all your secrets, keys, and certificates, with tightly controlled access. This is a ⭐⭐⭐⭐⭐ topic — secrets management is explicitly called out in your JD's DevSecOps requirement.

> 💡 **If you know AWS:** Key Vault combines the roles of **AWS Secrets Manager** (secrets), **AWS KMS** (encryption keys), and **AWS Certificate Manager** (certificates) into one service.

---

## 32.2 What It Stores (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  AZURE KEY VAULT: "myapp-kv"                              │
│  (a secure digital safe — access tightly controlled)      │
│                                                            │
│  SECRETS      → passwords, connection strings, API keys    │
│  KEYS         → cryptographic keys for encrypt/decrypt      │
│  CERTIFICATES → SSL/TLS certificates for HTTPS              │
└──────────────────────────────────────────────────────────┘

The magic: applications retrieve these at RUNTIME using a Managed
Identity — so no secret is ever stored in code, config, or Git.
```

---

## 32.3 The Core Secure Pattern (No Stored Credentials!)

```
❌ WITHOUT Key Vault:
   appsettings.json:  "DbPassword": "SuperSecret123!"
   → visible to anyone who can read the file, leaks into Git, etc.

✅ WITH Key Vault + Managed Identity:

   App (with a Managed Identity — Section 6)
       ↓ authenticates to Key Vault using its Managed Identity
         (NO password needed for this step — Azure handles it)
   Key Vault checks RBAC: "Does this identity have 'Key Vault Secrets
   User' permission?"
       ↓ Yes
   Returns the actual secret at runtime
       ↓
   The real password NEVER appears in code, config, or Git — anywhere.
```

---

## 32.4 Access Control: RBAC vs Access Policies

Two ways to control who/what can access a Key Vault's contents:

| Method | Description |
|---|---|
| **Azure RBAC** (modern, recommended) | Use standard RBAC roles like "Key Vault Secrets User" (read secrets) or "Key Vault Secrets Officer" (manage secrets), assigned at the vault's scope |
| **Access Policies** (older/legacy) | A list directly on the vault specifying which identities can do which operations |

**Recommendation:** Use RBAC for new setups — consistent with how you manage access everywhere else in Azure, and easier to audit.

---

## 32.5 Safety Features

- **Soft Delete:** Deleted secrets/keys/certs are recoverable for a retention period (protects against accidental deletion)
- **Purge Protection:** Prevents even an admin from *permanently* deleting vault contents before the retention period expires (protects against malicious deletion)

---

## 32.6 UI Steps — Creating a Key Vault and Storing a Secret

```
📍 START: portal.azure.com → search "Key vaults" → "+ Create"
   ┌────────────────────────────────────────┐
   │ Name:  myapp-kv                          │
   │ Region, Resource Group                   │
   │ Permission model: Azure RBAC (recommended)│
   │ Soft-delete: Enabled (default)           │
   │ Purge protection: Enable (recommended)   │
   └────────────────────────────────────────┘
   → "Review + create" → "Create"
    ↓
📍 Store a secret: open the Key Vault → left menu "Secrets" → "+ Generate/Import"
   ┌────────────────────────────────────────┐
   │ Name:  db-connection-string             │
   │ Value: Server=...;Password=...          │
   └────────────────────────────────────────┘
   → "Create"
    ↓
📍 Grant an app access: Key Vault → "Access control (IAM)" →
   "+ Add role assignment" → role "Key Vault Secrets User" →
   assign to the app's Managed Identity

📍 RESULT: The secret is securely stored, and only the specified Managed
   Identity can read it — retrieved at runtime, never hardcoded.
```

---

## 32.7 Real-World Example

```
A web app on App Service needs a database connection string, a payment
API key, and an SSL certificate — none should ever be in code:

Step 1: Create Key Vault "myapp-kv" (RBAC model, purge protection on).
Step 2: Store: secret "db-connection-string", secret "payment-api-key",
        certificate "myapp-ssl-cert".
Step 3: Enable a System-Assigned Managed Identity on the App Service.
Step 4: Grant that identity "Key Vault Secrets User" on the vault.
Step 5: In App Service configuration, reference the secrets via Key
        Vault References (e.g., @Microsoft.KeyVault(SecretUri=...))
        instead of pasting actual values.

Result: No developer, config file, or CI/CD log ever contains the real
database password or API key — everything is fetched securely at runtime
via the Managed Identity.
```

---

## 32.8 Interview Q&A

**Q: What is Azure Key Vault and why use it?**
> It's a secure, centralized store for secrets (passwords, connection strings, API keys), cryptographic keys, and certificates, with tightly controlled, auditable access. You use it to eliminate hardcoded secrets in code/config — combined with Managed Identities, applications retrieve secrets securely at runtime with no stored credentials of their own.

**Q: How does an application access Key Vault without storing a credential?**
> The application uses a Managed Identity to authenticate to Key Vault — Azure handles that authentication automatically with no secret involved. Key Vault then checks the identity's RBAC permissions and returns the requested secret. Nothing sensitive is ever stored in the app.

**Q: What are Soft Delete and Purge Protection?**
> Soft Delete keeps deleted vault items recoverable for a retention period (guards against accidental deletion). Purge Protection prevents anyone — even an admin — from permanently deleting items before that retention period expires (guards against malicious deletion). Together they protect your secrets from being lost.

---

## 32.9 Summary

Azure Key Vault is the secure, centralized home for secrets, keys, and certificates — eliminating the dangerous practice of hardcoding sensitive values in code or config. Combined with Managed Identities, applications retrieve secrets at runtime with zero stored credentials. Use RBAC (not legacy Access Policies) for access control, enable Soft Delete and Purge Protection as safety nets, and remember this is a ⭐⭐⭐⭐⭐ interview topic given the JD's secrets-management focus. How Key Vault integrates specifically with Pipelines, AKS, and ACR is covered in the next section.

---
---

# 33. 🔗 Key Vault Integrations (Pipelines, AKS, ACR, Managed Identity)
> 🔴 FULL

---

## 33.1 What Problem Does This Solve?

Key Vault (Section 32) stores secrets securely — but the real interview value is knowing *how it connects to the tools you actually use*: how a CI/CD pipeline pulls a secret, how a Kubernetes pod mounts one, how ACR/AKS authenticate. Your checklist explicitly lists "Managed Identity + Key Vault," "Azure DevOps Key Vault integration," and the AKS→Key Vault flow. This section walks each integration flow.

> 💡 **If you know AWS:** These flows mirror how you'd wire AWS Secrets Manager to CodePipeline, to EKS (via the Secrets Store CSI driver / IRSA), and to services via IAM roles. Same patterns, Azure names.

---

## 33.2 Integration 1: Azure Pipeline → Key Vault (Flow Diagram)

```
Azure Pipeline needs a secret (e.g., an API key) during a deployment:

   Azure Pipeline
       ↓ via a Service Connection (Section 39)
   Entra ID authenticates the pipeline's identity (Service Principal/WIF)
       ↓
   RBAC check: does this identity have "Key Vault Secrets User"?
       ↓ Yes
   Key Vault returns the secret
       ↓
   Secret injected into the pipeline as a variable (automatically MASKED
   in logs, so it never appears in plain text in pipeline output)
```

**Two common ways to do this in Azure DevOps:**
1. **Variable Group linked to Key Vault** — link a pipeline Variable Group (Section 42) to a Key Vault; secrets appear as pipeline variables automatically
2. **AzureKeyVault@2 task** — a pipeline task that fetches secrets at runtime

```yaml
# Example: AzureKeyVault task in a pipeline
- task: AzureKeyVault@2
  inputs:
    azureSubscription: 'my-service-connection'  # Section 39
    KeyVaultName: 'myapp-kv'
    SecretsFilter: 'db-connection-string,payment-api-key'
# The secrets are now available as pipeline variables, masked in logs
```

---

## 33.3 Integration 2: AKS → Key Vault via Workload Identity + CSI Driver (Flow Diagram)

This is the modern, secretless way for Kubernetes pods to get Key Vault secrets — a ⭐ flow from your checklist.

```
   AKS Pod needs a secret (e.g., DB password)
       ↓
   Pod uses AKS WORKLOAD IDENTITY (a Managed Identity federated to a
   Kubernetes service account — no stored secret)
       ↓
   Authenticates to Entra ID → gets a token
       ↓
   The SECRETS STORE CSI DRIVER (an AKS add-on) uses that token to
   fetch the secret from Key Vault
       ↓
   The secret is mounted into the Pod as a file (or synced as a
   Kubernetes secret) — the app just reads a normal file
       ↓
   The secret never lives in the container image, Kubernetes YAML, or
   Git — only in Key Vault, fetched at runtime.
```

**Setup at a glance:**
```
1. Enable the Key Vault Secrets Store CSI Driver add-on on the AKS cluster
2. Enable Workload Identity on the cluster
3. Create a Managed Identity, grant it "Key Vault Secrets User" on the vault
4. Federate that identity to a Kubernetes service account
5. Define a "SecretProviderClass" telling the CSI driver which secrets to mount
6. Pods using that service account get the secrets mounted automatically
```

---

## 33.4 Integration 3: AKS → ACR (Image Pull) (Flow Diagram)

Not a Key Vault flow, but a critical, closely-related "how does AKS authenticate to pull images" integration your checklist flags:

```
   AKS needs to pull a container image to run a Pod
       ↓
   AKS uses its Managed Identity (attached to the cluster)
       ↓
   That identity has the "AcrPull" RBAC role on the ACR
       ↓
   AKS pulls the image securely — NO registry username/password stored

Setup is a single command:
   az aks update --name myAKS --resource-group myRG --attach-acr myACR
   (this grants the cluster's identity AcrPull on the registry automatically)
```

---

## 33.5 Integration 4: App Service / VM → Key Vault via Managed Identity

The simplest and most common flow (covered in Sections 6 and 32, consolidated here):

```
   App Service (or VM) has a Managed Identity
       ↓
   Managed Identity has "Key Vault Secrets User" on the vault
       ↓
   App references secrets via Key Vault References in its configuration:
       @Microsoft.KeyVault(SecretUri=https://myapp-kv.vault.azure.net/secrets/db-password/)
       ↓
   At runtime, App Service transparently fetches the real value from
   Key Vault using the Managed Identity — the app code just reads a
   normal config setting.
```

---

## 33.6 The Unifying Principle (Interview Gold)

```
Every single one of these integrations follows the SAME pattern:

   Something needs a secret / to authenticate
       ↓
   It uses a MANAGED IDENTITY (or Workload Identity / Service Principal)
       ↓
   ENTRA ID verifies that identity
       ↓
   RBAC checks what it's allowed to access
       ↓
   Access granted — with NO stored credential anywhere

If you can say this pattern out loud, you can explain ALL of these
integrations, because they're fundamentally the same flow with
different endpoints (Key Vault, ACR, etc.).
```

---

## 33.7 Real-World Example

```
A containerized app running on AKS, deployed via Azure Pipelines, needs
a database password and pulls its image from ACR:

1. PIPELINE → KEY VAULT: The Azure Pipeline uses an AzureKeyVault task
   to fetch a deployment-time secret, masked in logs.

2. PIPELINE → ACR: The pipeline builds the container image and pushes it
   to ACR (authenticating via its Service Connection).

3. AKS → ACR: AKS pulls that image using its Managed Identity with AcrPull
   role — no registry credentials stored.

4. AKS POD → KEY VAULT: At runtime, the pod uses Workload Identity + the
   Secrets Store CSI Driver to mount the database password from Key Vault
   — never storing it in the image or YAML.

Every step uses managed identities and RBAC — there is not a single
hardcoded secret or stored credential anywhere in the entire flow.
That's the story to tell in the interview.
```

---

## 33.8 Interview Q&A

**Q: How does an Azure Pipeline securely get a secret from Key Vault?**
> Through its Service Connection identity, which authenticates to Entra ID and has RBAC access ("Key Vault Secrets User") to the vault. You either link a Variable Group to Key Vault or use the AzureKeyVault pipeline task — either way, the secret is injected as a pipeline variable and automatically masked in logs, never hardcoded.

**Q: How do Kubernetes pods in AKS get secrets from Key Vault without storing credentials?**
> Using Workload Identity (a Managed Identity federated to a Kubernetes service account) combined with the Key Vault Secrets Store CSI Driver add-on. The pod authenticates via Workload Identity, the CSI driver fetches the secret from Key Vault and mounts it into the pod as a file — so the secret never lives in the image, YAML, or Git.

**Q: How does AKS authenticate to pull images from ACR?**
> Via the cluster's Managed Identity, which is granted the "AcrPull" RBAC role on the registry (done with a single `az aks update --attach-acr` command). No registry username or password is stored anywhere.

**Q: What's the common pattern across all these integrations?**
> They all use a managed identity (or workload identity/service principal) verified by Entra ID, with RBAC controlling access — so authentication happens with no stored credentials anywhere. Whether it's Key Vault, ACR, or another service, the pattern is identical: identity → Entra ID → RBAC → access.

---

## 33.9 Summary

Key Vault's real interview value is in the integration flows: Pipelines fetch secrets via a Service Connection identity + the AzureKeyVault task/linked Variable Group (masked in logs); AKS pods fetch secrets via Workload Identity + the Secrets Store CSI Driver (mounted as files, never in the image); AKS pulls ACR images via its Managed Identity with the AcrPull role; and App Services/VMs fetch secrets via Managed Identity + Key Vault References. Every one of these follows the identical pattern — **identity → Entra ID → RBAC → access, with no stored credentials** — which is the single most powerful thing you can articulate about Azure secrets/auth in the interview.

---

---
---

# 34. 🛠️ Azure DevOps Overview
> 🟠 MEDIUM

---

## 34.1 What Problem Does This Solve?

Delivering software involves many activities: planning work, storing code, building/testing/deploying it, and sharing packages. Using separate disconnected tools for each is painful. **Azure DevOps** brings the entire software delivery lifecycle into one connected suite — and it's the single most important technology in your JD (listed first under "Technologies").

> 💡 **If you know AWS:** Azure DevOps is like AWS's CodeCommit + CodeBuild + CodeDeploy + CodePipeline + CodeArtifact all combined into one integrated product — plus a work-planning tool (Boards) that AWS has no direct equivalent for.

---

## 34.2 The Five Services (Flow Diagram)

```
┌─────────────────────────────────────────────────────────────┐
│  AZURE DEVOPS                                                │
│                                                              │
│  📋 Azure Boards    → plan & track work (Epics, Stories, Tasks)│
│  📦 Azure Repos     → Git source control                      │
│  🔄 Azure Pipelines → CI/CD (build, test, deploy automation)  │
│  📚 Azure Artifacts → package management (npm, NuGet, etc.)   │
│  🧪 Azure Test Plans→ manual & exploratory testing            │
└─────────────────────────────────────────────────────────────┘

They're designed to work together, but you can mix & match — e.g., many
teams use Azure Pipelines with GitHub for source control instead of Repos.
```

---

## 34.3 How the Pieces Connect (Typical Flow)

```
1. A feature is planned as a User Story in Azure BOARDS
       ↓
2. A developer branches in Azure REPOS, writes code, links commits to
   that Story
       ↓
3. Opens a Pull Request → branch policy requires a passing build
   (Azure PIPELINES runs automatically) + a reviewer's approval
       ↓
4. On merge, Azure PIPELINES builds, tests, and deploys the change
       ↓
5. Shared packages are pulled from / published to Azure ARTIFACTS
       ↓
6. The Story in Azure BOARDS auto-updates to "Done"

Everything is linked: you can trace a deployed change back to the
exact code commit and the work item that requested it.
```

---

## 34.4 UI Steps — Creating an Azure DevOps Project

```
📍 START: dev.azure.com → sign in
    ↓
If you don't have an Organization yet: "New organization" → name it
    ↓
Click "+ New project"
   ┌────────────────────────────────────────┐
   │ Project name:  MyApp                    │
   │ Visibility:    Private                   │
   │ Version control: Git                     │
   │ Work item process: Agile / Scrum / Basic │
   └────────────────────────────────────────┘
   → "Create"
    ↓
📍 RESULT: You land in the project with all five services in the left
   nav — Boards, Repos, Pipelines, Test Plans, Artifacts — ready to use.
```

---

## 34.5 Real-World Example

```
A startup sets up a professional delivery workflow from day one:

Step 1: Create an Azure DevOps project "MyApp" with the Agile process.
Step 2: In Boards, set up a Kanban board and start tracking work as
        User Stories and Tasks.
Step 3: Put code in Azure Repos (or connect to their existing GitHub).
Step 4: Set up an Azure Pipeline to build & test on every Pull Request,
        and deploy on merge to main.
Step 5: As they grow and share internal libraries across projects, use
        Azure Artifacts to host those packages centrally.

Result: A fully connected pipeline from "planned work" to "deployed
software," with full traceability throughout.
```

---

## 34.6 Interview Q&A

**Q: What are the five services in Azure DevOps?**
> Azure Boards (planning/work tracking), Azure Repos (Git source control), Azure Pipelines (CI/CD automation), Azure Artifacts (package management), and Azure Test Plans (manual/exploratory testing). They're integrated but can be used independently — for example, Pipelines with GitHub instead of Repos.

**Q: Can you use Azure Pipelines with GitHub instead of Azure Repos?**
> Yes — Azure DevOps services are modular. A very common real-world setup is using GitHub for source control and Azure Pipelines for CI/CD, since the components don't have to be used all-or-nothing.

---

## 34.7 Summary

Azure DevOps is Microsoft's integrated software delivery suite — Boards (planning), Repos (Git), Pipelines (CI/CD), Artifacts (packages), and Test Plans (testing) — the single most important technology in your JD. The services work together to give full traceability from planned work to deployed code, but are modular (you can mix Azure Pipelines with GitHub, for instance). The following sections dive deep into the parts that matter most for your interview: permissions, branching, pipelines, and service connections.

---
---

# 35. 🔐 Azure DevOps Permissions & Security
> 🔴 FULL

---

## 35.1 What Problem Does This Solve?

In a real organization, not everyone should be able to do everything in Azure DevOps — a junior developer shouldn't be able to delete a repository or approve their own production deployment. You need to control *who can do what* within Azure DevOps itself. You specifically asked about "how users are given permission in Azure DevOps" — this section covers exactly that.

> 💡 **If you know AWS:** This is Azure DevOps's *internal* permission system — separate from Azure RBAC (which governs Azure resources). Think of it like the permission model *inside* a SaaS tool. AWS doesn't have a direct single equivalent since it splits CI/CD across many services each with their own IAM permissions.

---

## 35.2 The Permission Hierarchy (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  ORGANIZATION  (dev.azure.com/your-org)                   │
│  Org-level settings, billing, who can create projects      │
│                                                            │
│   ┌──────────────────────────────────────────────────┐   │
│   │  PROJECT  (e.g., "MyApp")                          │   │
│   │  Project-level access via SECURITY GROUPS:          │   │
│   │    • Project Administrators (full control)          │   │
│   │    • Contributors (write code, run pipelines)       │   │
│   │    • Readers (view only)                            │   │
│   │                                                    │   │
│   │   ┌────────────────────────────────────────────┐  │   │
│   │   │  Resource-level permissions (finer control):  │  │   │
│   │   │   • Per-Repository permissions                 │  │   │
│   │   │   • Per-Pipeline permissions                   │  │   │
│   │   │   • Per-Environment permissions                │  │   │
│   │   │   • Service Connection permissions             │  │   │
│   │   └────────────────────────────────────────────┘  │   │
│   └──────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────┘
```

---

## 35.3 How Users Get Permissions — Security Groups

The key concept: you rarely assign permissions to individuals. Instead, you add users to **Security Groups**, and the group's permissions apply to all members — exactly like Entra ID groups + Azure RBAC (Section 20), but this is Azure DevOps's own internal group system.

**Built-in project security groups:**
| Group | Typical Permissions |
|---|---|
| **Project Administrators** | Full control over the project |
| **Contributors** | Create/edit code, create & run pipelines, create work items |
| **Readers** | View everything, change nothing |
| **Build Administrators** | Manage build pipelines and resources |

**Users can also be tied to Entra ID groups**, so DevOps access aligns with your organizational identity (add someone to the "DevOps-Engineers" Entra ID group → they automatically get the corresponding Azure DevOps access).

---

## 35.4 Resource-Level Permissions (Fine-Grained Control)

Beyond project-wide groups, you can set permissions on individual resources:

```
Repository permissions:  "Only the senior team can force-push or delete
                          the main repo"
Pipeline permissions:    "Only leads can edit the production pipeline"
Environment permissions: "Only specific approvers can deploy to the
                          Production environment" (ties into Approvals,
                          Section 46)
Service Connection perms: "Only certain pipelines can use the production
                          Azure service connection" (Section 39)
```

These resource-level controls are how you enforce, e.g., "a developer can run the pipeline but only a lead can approve the production deployment."

---

## 35.5 UI Steps — Managing Permissions

```
── Project-level (adding a user to a group) ──
📍 dev.azure.com → your project → "Project settings" (bottom-left gear)
    ↓
"Permissions" (under General) → pick a group (e.g., "Contributors")
   → "Members" tab → "+ Add" → add the user
    ↓
📍 RESULT: The user now has that group's permissions across the project.

── Resource-level (e.g., restricting who can approve an Environment) ──
📍 dev.azure.com → your project → "Pipelines" → "Environments" →
   open the "Production" environment
    ↓
"⋮" menu → "Security" → set who can administer/use it
   (and configure Approvals — Section 46 — for who can approve deploys)

── Organization-level ──
📍 dev.azure.com → "Organization settings" (bottom-left) → "Permissions"
   or "Users" → manage org-wide access and who can create projects
```

---

## 35.6 Real-World Example

```
Setting up least-privilege access for a team in Azure DevOps:

Developers (Entra ID group "Developers"):
   → mapped to the "Contributors" DevOps group
   → can write code, open PRs, run pipelines
   → CANNOT approve production deployments or delete the repo

Team Leads (Entra ID group "Leads"):
   → "Contributors" + added as approvers on the Production Environment
   → can do everything developers can, PLUS approve prod deploys

DevOps Engineers:
   → "Project Administrators" — manage pipelines, service connections,
     agents, and permissions

Auditors:
   → "Readers" — can view everything for compliance, change nothing

Result: Clear separation of duties — e.g., a developer can trigger a
deployment pipeline, but it PAUSES for a lead's approval before reaching
production. Nobody can approve their own production release.
```

---

## 35.7 Interview Q&A

**Q: How do you manage permissions in Azure DevOps?**
> Primarily through Security Groups at the project level (built-in ones like Project Administrators, Contributors, Readers), adding users to groups rather than assigning permissions individually. These groups can be tied to Entra ID groups so DevOps access aligns with organizational identity. For finer control, you set resource-level permissions on individual repositories, pipelines, environments, and service connections.

**Q: How would you ensure a developer can run a deployment pipeline but not approve the production release themselves?**
> Put developers in the Contributors group (they can run pipelines), but configure the Production Environment with required Approvals (Section 46) where only team leads are listed as approvers. So a developer's pipeline run pauses at the production stage until a lead approves — enforcing separation of duties.

**Q: What's the difference between Azure DevOps permissions and Azure RBAC?**
> Azure DevOps permissions govern what you can do *inside* the Azure DevOps tool (repos, pipelines, boards). Azure RBAC governs what you can do to *Azure resources* (VMs, storage, etc.). They're separate systems — a pipeline's ability to deploy *to Azure* is controlled by RBAC (via a Service Connection), while who can *edit that pipeline* is controlled by Azure DevOps permissions.

---

## 35.8 Summary

Azure DevOps has its own internal permission system (separate from Azure RBAC), organized hierarchically: Organization → Project → resource-level. Users get permissions primarily through Security Groups (Project Administrators, Contributors, Readers), ideally tied to Entra ID groups for consistency with organizational identity. Fine-grained resource-level permissions on repositories, pipelines, environments, and service connections let you enforce separation of duties — for example, developers can run a pipeline while only leads can approve the production deployment. This is exactly how "who can do what" is controlled within Azure DevOps.

---
---

# 36. 🌿 Git Branching Strategies
> 🔴 FULL

---

## 36.1 What Problem Does This Solve?

When many developers work on the same codebase, how they organize their work in Git branches dramatically affects how smoothly (or painfully) code gets integrated and released. Your JD explicitly calls out **trunk-based development**, and interviewers love asking about branching strategies. Note: this is a Git/process concept, so the "steps" here are `git` commands and Azure DevOps repo settings, not Azure Portal clicks.

> 💡 **If you know AWS:** Branching strategy is cloud-agnostic — identical whether your repo is in Azure Repos, GitHub, or CodeCommit. If you know GitFlow/GitHub Flow from any context, it applies directly.

---

## 36.2 The Main Strategies (Flow Diagrams)

### Trunk-Based Development (What Your JD Wants)
```
Everyone commits small, frequent changes to ONE shared branch (main):

main  ──●──●──●──●──●──●──●──►   (constant small commits)
         ↑  ↑  ↑     ↑
      short-lived branches (hours, not weeks), merged quickly

• Feature flags hide incomplete features in production
• CI runs on every commit
• Minimal branching = minimal merge conflicts
• Enables continuous deployment
```

### GitHub Flow (Simple)
```
main  ──●─────────────●────────●──►
          \          /
feature    ●──●──●──●   (branch → work → PR → merge to main → deploy)

• One main branch (always deployable)
• Short-lived feature branches merged via PR
• Simple; good for continuous delivery
```

### GitFlow (Complex, Older)
```
main     ──●──────────────●──────►  (production releases only)
             \            /
release       ●──●──●──●─●
             /
develop  ──●──●──●──●──●──●──►  (integration branch)
            \        /
feature      ●──●──●

• Multiple long-lived branches (main, develop, release, feature, hotfix)
• More structure, but more complex & more merge overhead
• Falling out of favor vs trunk-based for fast-moving teams
```

---

## 36.3 Comparison Table

| Strategy | Branches | Best For | Merge Pain |
|---|---|---|---|
| **Trunk-Based** | Mainly just `main` | Fast CI/CD, mature teams, feature flags | Minimal |
| **GitHub Flow** | `main` + short feature branches | Continuous delivery, simpler teams | Low |
| **GitFlow** | main, develop, release, feature, hotfix | Scheduled releases, versioned products | Higher |

---

## 36.4 Trunk-Based Development + Feature Flags (The Key Combo)

The reason trunk-based works without shipping half-finished features: **feature flags** let you deploy incomplete code to production while keeping it turned OFF.

```python
if feature_flags.is_enabled("new_checkout"):
    new_checkout()      # deployed, but hidden until flag is ON
else:
    old_checkout()
```
```
This DECOUPLES deploying (code is live but off) from releasing (flag
turned on). "Rollback" becomes flipping a flag OFF — instant, no
redeploy. (Feature flags + Azure App Configuration are covered in
Section 65.)
```

---

## 36.5 Steps — Working in a Trunk-Based Flow (Git + Azure Repos)

```
📍 This is done via Git + Azure Repos branch settings, not the Azure Portal.

# Developer's daily flow (trunk-based):
git checkout main
git pull                              # always start from latest main
git checkout -b quick-fix             # short-lived branch (hours)
# ... make a small change ...
git commit -m "Add null check to checkout"
git push origin quick-fix
# → open a Pull Request in Azure Repos targeting main

📍 In Azure Repos, a Branch Policy (Section 37) on "main" requires:
   • a passing CI build
   • at least one reviewer approval
   before the PR can merge — keeping main always healthy.

# After approval, the branch is merged (often "squash merge") into main
# and deleted. The change is now on main, ready to deploy.
```

---

## 36.6 Real-World Example

```
A product team moves from painful GitFlow to trunk-based development:

BEFORE (GitFlow): developers worked on feature branches for weeks;
merging them back caused huge, painful conflicts, and releases were
slow and risky.

AFTER (trunk-based):
Step 1: Everyone commits small changes to main multiple times a day,
        via short-lived branches (merged within hours).
Step 2: Incomplete features are hidden behind feature flags (Azure App
        Configuration), so unfinished work can safely be on main/in
        production without being visible to users.
Step 3: A branch policy on main requires passing CI + one approval
        before any merge.
Step 4: Every merge to main can be automatically deployed (continuous
        deployment), because main is always in a releasable state.

Result: Far fewer merge conflicts, faster & safer releases, and
"rollback" is often just flipping a feature flag off.
```

---

## 36.7 Interview Q&A

**Q: What is trunk-based development?**
> A branching strategy where all developers commit small, frequent changes to a single shared branch (main) — using short-lived branches (hours, not weeks) and feature flags to hide incomplete work. It minimizes merge conflicts, keeps main always releasable, and enables continuous deployment. It's the strategy modern fast-moving teams (and this JD) favor.

**Q: How does trunk-based development avoid shipping half-finished features?**
> Through feature flags — incomplete code is deployed to production but kept turned off behind a flag, then gradually enabled when ready. This decouples deploying code from releasing the feature to users, and makes rollback as simple as flipping the flag off.

**Q: GitFlow vs trunk-based — when would you use each?**
> GitFlow (multiple long-lived branches: develop, release, feature, hotfix) suits products with scheduled, versioned releases but adds merge complexity. Trunk-based (mainly just main + feature flags) suits fast-moving teams doing continuous delivery with minimal merge overhead. Modern DevOps generally favors trunk-based; GitFlow is more for versioned/packaged software with distinct release cycles.

---

## 36.8 Summary

Git branching strategy shapes how smoothly a team integrates and releases code. Trunk-based development — everyone committing small, frequent changes to a single `main` branch, using short-lived branches and feature flags to hide incomplete work — is what your JD wants and what modern CI/CD teams favor, because it minimizes merge conflicts and keeps main always releasable. GitHub Flow is a simple middle ground; GitFlow's multiple long-lived branches suit versioned releases but add complexity. Feature flags are the key enabler that lets trunk-based work by decoupling deployment from release.

---
---

# 37. 🚧 Branch Policies & Branch Protection
> 🔴 FULL

---

## 37.1 What Problem Does This Solve?

Trunk-based development (Section 36) depends on `main` always being healthy and releasable. But how do you *stop* someone from merging broken, untested, or unreviewed code directly into `main`? **Branch Policies** (Azure Repos' term for branch protection) enforce quality gates that must be satisfied before any code can merge into a protected branch.

> 💡 **If you know AWS:** Branch Policies are the equivalent of **GitHub's branch protection rules** — the concept is identical across Azure Repos, GitHub, and GitLab.

---

## 37.2 What Branch Policies Enforce (Flow Diagram)

```
Developer opens a Pull Request targeting "main"
       ↓
┌──────────────────────────────────────────────────────┐
│  BRANCH POLICY on "main" checks:                       │
│    ✅ Required reviewers approved? (e.g., 2 approvals)  │
│    ✅ Build validation passed? (CI pipeline succeeded)  │
│    ✅ Linked to a work item? (traceability)            │
│    ✅ All comments resolved?                           │
│    ✅ No merge conflicts?                              │
└───────────────────────┬───────────────────────────────┘
                        ↓
         ALL satisfied? → ✅ merge ALLOWED
         ANY failing?   → ❌ merge BLOCKED

Result: Broken or unreviewed code CANNOT reach main. Ever.
```

---

## 37.3 Key Policies to Know

| Policy | What It Does |
|---|---|
| **Require a minimum number of reviewers** | e.g., 2 people must approve the PR |
| **Build validation** | A CI pipeline must run and pass before merge (catches broken code) |
| **Check for linked work items** | Every change must link to a Board work item (traceability) |
| **Check for comment resolution** | All PR review comments must be resolved |
| **Limit merge types** | Control how PRs merge (squash / rebase / merge commit) |
| **Reset approvals on new changes** | If new commits are pushed, prior approvals reset (re-review required) |

---

## 37.4 Merge Types (Commonly Asked)

```
Merge commit:  keeps all the branch's individual commits + a merge commit
               (full history, but messier)
Squash merge:  combines all the branch's commits into ONE clean commit
               on main (tidiest history — popular for trunk-based)
Rebase:        replays the branch's commits onto main linearly
               (linear history, no merge commit)
```
Branch policies can *require* a specific merge type to keep history consistent.

---

## 37.5 Steps — Configuring a Branch Policy (Azure Repos)

```
📍 This is done in Azure DevOps (dev.azure.com), not the Azure Portal.

📍 START: dev.azure.com → your project → "Repos" → "Branches"
    ↓
Find "main" → click the "⋮" (more options) → "Branch policies"
    ↓
   ┌────────────────────────────────────────────────┐
   │ ✅ Require a minimum number of reviewers: 2      │
   │    ✅ Reset approvals when new changes pushed    │
   │ ✅ Check for linked work items: Required         │
   │ ✅ Check for comment resolution: Required        │
   │ ✅ Build Validation: + Add → select your CI      │
   │    pipeline (must pass before merge)             │
   │ Merge types: allow only "Squash merge"           │
   └────────────────────────────────────────────────┘
    ↓
(Policies save automatically)

📍 RESULT: "main" is now protected — no PR can merge unless it has 2
   approvals, a passing CI build, a linked work item, all comments
   resolved, and uses a squash merge.
```

---

## 37.6 Real-World Example

```
A team enforces quality on their main branch:

Branch Policy on "main":
   • 2 required reviewers (no self-approval of your own PR)
   • Build validation: the CI pipeline (unit tests + security scan)
     must pass
   • Linked work item required (so every change traces to a Board item)
   • Squash merge only (clean, linear history)

What happens in practice:
- A developer pushes code with a failing test → opens a PR → the build
  validation runs, FAILS → the PR is BLOCKED from merging until fixed.
- A developer's PR has no reviewer approvals yet → BLOCKED until 2
  teammates approve.
- Result: main is ALWAYS in a healthy, tested, reviewed state — which is
  exactly what trunk-based development and continuous deployment require.
```

---

## 37.7 Interview Q&A

**Q: What are Branch Policies and why are they important?**
> Branch Policies (branch protection) are rules on a protected branch like main that must be satisfied before any PR can merge — such as requiring reviewer approvals, a passing CI build (build validation), linked work items, and comment resolution. They're essential because they prevent broken or unreviewed code from ever reaching main, which is what keeps main always releasable — a prerequisite for trunk-based development and continuous deployment.

**Q: What is "build validation" in a branch policy?**
> A policy that automatically triggers a CI pipeline on every Pull Request and blocks the merge unless that build (and its tests) pass. It catches broken code before it's merged, rather than after.

**Q: What's the difference between squash merge and a regular merge?**
> Squash merge combines all of a branch's commits into a single clean commit on main (tidy history), while a regular merge commit preserves all individual commits plus a merge commit (fuller but messier history). Branch policies can enforce a specific type for consistency — squash is popular for trunk-based development's clean history.

---

## 37.8 Summary

Branch Policies (Azure Repos' branch protection) enforce quality gates before code can merge into a protected branch like main — requiring reviewer approvals, passing CI builds (build validation), linked work items, and resolved comments. They're what makes trunk-based development and continuous deployment safe, by guaranteeing main stays healthy and releasable. They also control merge types (squash/rebase/merge) for consistent history. Configure them in Azure Repos → Branches → Branch policies.

---
---

# 38. 🔀 Pull Request Workflow & Code Reviews
> 🟠 MEDIUM

---

## 38.1 What Problem Does This Solve?

Code shouldn't go straight into the main branch without anyone else looking at it — that's how bugs and security issues slip through. A **Pull Request (PR)** is the mechanism for proposing a change, having teammates review it, and safely merging it. It's the daily heartbeat of real team development.

> 💡 **If you know AWS:** A Pull Request is identical to a GitHub Pull Request or a GitLab Merge Request — the concept is the same in Azure Repos.

---

## 38.2 The PR Workflow (Flow Diagram)

```
1. Developer creates a branch, makes changes, pushes it
       ↓
2. Opens a PULL REQUEST targeting "main"
   (describes what changed and why; links the work item)
       ↓
3. BRANCH POLICY (Section 37) kicks in automatically:
   • CI build runs (build validation)
   • Reviewers are required
       ↓
4. CODE REVIEW: teammates review the diff, leave comments,
   request changes, or approve
       ↓
5. Developer addresses comments, pushes updates (re-triggers CI)
       ↓
6. Once approved + build passes → PR is MERGED into main
       ↓
7. The branch is deleted; the linked work item auto-moves to "Done"
```

---

## 38.3 What Reviewers Look For

```
✅ Does the code actually do what the work item asked?
✅ Is it readable and maintainable?
✅ Are there tests? Do they cover the change?
✅ Any security concerns (hardcoded secrets, injection risks)?
✅ Any performance issues?
✅ Does it follow team conventions?
```

Code review isn't just bug-catching — it spreads knowledge across the team and maintains consistency.

---

## 38.4 Steps — Creating and Reviewing a PR (Azure Repos)

```
📍 In Azure DevOps (dev.azure.com), not the Azure Portal.

── Creating a PR ──
📍 Repos → "Pull requests" → "+ New pull request"
   ┌────────────────────────────────────────┐
   │ Source branch: my-feature-branch        │
   │ Target branch: main                     │
   │ Title & description: what & why          │
   │ Reviewers: add teammates                 │
   │ Work items: link the User Story/Bug      │
   └────────────────────────────────────────┘
   → "Create"
    ↓
── Reviewing a PR ──
📍 Repos → "Pull requests" → open the PR → "Files" tab
   → review the diff, click a line to leave a comment,
   → set your vote: Approve / Approve with suggestions /
     Wait for author / Reject
    ↓
── Completing ──
📍 Once policies are satisfied (approvals + passing build) →
   "Complete" → choose merge type (e.g., Squash) → confirm

📍 RESULT: The reviewed, tested change is merged into main.
```

---

## 38.5 Real-World Example

```
A developer fixes a bug in the checkout flow:

Step 1: Creates branch "fix-checkout-tax-bug", makes the fix, pushes it.
Step 2: Opens a PR to main, links the bug work item, adds two reviewers.
Step 3: The branch policy auto-runs the CI pipeline (tests pass) and
        requires the two approvals.
Step 4: A reviewer spots that the fix doesn't handle a null case and
        leaves a comment; the developer pushes an update (CI re-runs).
Step 5: Both reviewers approve; the PR merges (squash) into main; the
        bug work item auto-moves to "Done".

Result: The fix is peer-reviewed, tested, traceable to the work item,
and safely integrated — the everyday rhythm of professional development.
```

---

## 38.6 Interview Q&A

**Q: Walk me through a typical Pull Request workflow.**
> A developer creates a branch, makes changes, and opens a PR targeting main. Branch policies automatically run the CI build and require reviewer approvals. Teammates review the diff, leave comments, and vote. The developer addresses feedback (which re-triggers CI). Once approved and the build passes, the PR is merged (often squash) into main, the branch is deleted, and the linked work item auto-moves to Done.

**Q: Why are code reviews valuable beyond just catching bugs?**
> They spread knowledge across the team (more people understand each change), maintain code consistency and conventions, catch security and performance issues early, and provide a documented discussion of why a change was made — all while keeping main healthy.

---

## 38.7 Summary

A Pull Request is how changes are proposed, reviewed, and safely merged — the daily heartbeat of team development. The workflow: branch → open PR → branch policies auto-run CI and require approvals → teammates review and comment → developer addresses feedback → merge into main → linked work item auto-completes. Code review catches bugs and security/performance issues while spreading knowledge and enforcing consistency. Combined with branch policies (Section 37), PRs guarantee that only reviewed, tested code reaches main.

---
---

# 39. 🔗 Service Connections
> 🔴 FULL

---

## 39.1 What Problem Does This Solve?

Your Azure Pipeline runs on a temporary build agent. When it needs to *do* something in Azure — deploy a VM, push to ACR, read from Key Vault — Azure asks "who are you and are you allowed?" A **Service Connection** is how the pipeline proves its identity and gets permission to act on Azure resources, without any human typing a password. This is a ⭐⭐⭐⭐⭐ topic and a top "integration flow" from your checklist.

> 💡 **If you know AWS:** A Service Connection is like configuring the IAM Role (or OIDC federation) that your CodePipeline/GitHub Actions assumes to deploy into AWS — a non-human identity with scoped permissions.

---

## 39.2 The Full Authentication Flow (MEMORIZE THIS)

```
   Azure Pipeline               "I need to deploy to Azure"
        ↓
   Service Connection           the bridge between Azure DevOps & Azure
        ↓
   Entra ID                     verifies the identity
        ↓
   Service Principal / Managed Identity / Workload Identity Federation
        ↓
   RBAC                         "what is this identity ALLOWED to do?"
        ↓                        (e.g., Contributor on prod-rg)
   Azure Subscription
        ↓
   Azure Resource               VM / ACR / AKS / Key Vault / etc.

Say it in the interview: "The pipeline uses a Service Connection, which
authenticates to Entra ID as a Service Principal or Workload Identity,
and that identity's RBAC role assignment — scoped narrowly — determines
what it can do."
```

---

## 39.3 The Three Authentication Types

| Type | How It Works | Security | Use When |
|---|---|---|---|
| **Service Principal + Secret** | App identity + a client secret that expires | ⚠️ Secret can leak, must be rotated | Legacy, or where WIF isn't possible |
| **Managed Identity** | Azure-managed, no secret | ✅ Good | Self-hosted agents running on Azure VMs |
| **Workload Identity Federation (OIDC)** | Short-lived tokens via trust, NO stored secret | ✅✅ Best | **Recommended default for new setups** |

**Interview gold:** "How would you securely authenticate a pipeline to Azure?" → **"Workload Identity Federation using OIDC — no long-lived secret to store, leak, or rotate."**

---

## 39.4 UI Steps — Creating a Service Connection

```
📍 START: dev.azure.com → your project → "Project settings" (bottom-left gear)
    ↓
Under "Pipelines" → "Service connections" → "New service connection"
    ↓
Choose "Azure Resource Manager" → "Next"
    ↓
Authentication method:
   ┌────────────────────────────────────────────────┐
   │ ✅ Workload Identity federation (automatic)      │ ← pick this (secretless)
   │    Service principal (automatic)                 │
   │    Service principal (manual)                    │
   │    Managed identity                              │
   └────────────────────────────────────────────────┘
    ↓
Select your Azure Subscription (sign in to authorize)
    ↓
⭐ Scope narrowly: choose a specific Resource Group, not the whole
   subscription (least privilege!)
    ↓
Name it (e.g., "prod-rg-connection") → "Save"

📍 RESULT: Azure DevOps auto-created a Service Principal (or WIF trust)
   in Entra ID with a Contributor role at the scope you chose. Pipelines
   reference this connection by name.
```

---

## 39.5 Using It in a Pipeline

```yaml
- task: AzureCLI@2
  inputs:
    azureSubscription: 'prod-rg-connection'   # ← the Service Connection name
    scriptType: 'bash'
    scriptLocation: 'inlineScript'
    inlineScript: |
      az group list --output table
```
The `azureSubscription:` field wires the whole authentication flow into your pipeline via one line.

---

## 39.6 Real-World Example

```
A pipeline must deploy to "prod-webapp-rg" but security insists it have
NO access to anything else in the subscription:

Step 1: Create a Service Connection using Workload Identity Federation
        (no secret to manage).
Step 2: Scope it to ONLY the "prod-webapp-rg" resource group.
Step 3: This auto-creates an Entra ID identity with Contributor RBAC
        scoped to just that one resource group.
Step 4: If this pipeline's identity were ever compromised, the blast
        radius is one resource group — it literally cannot touch the
        production database in another RG. Least privilege for automation.
```

---

## 39.7 Interview Q&A

**Q: Walk me through how an Azure Pipeline authenticates to Azure.**
> Pipeline → Service Connection → Entra ID (as a Service Principal or Workload Identity) → RBAC role assignment → Subscription/Resource → the resource. The Service Connection is the bridge; Entra ID verifies identity; RBAC decides what's allowed.

**Q: What's the most secure Service Connection authentication method, and why?**
> Workload Identity Federation (OIDC) — it uses short-lived tokens via a trust relationship, so there's no long-lived client secret stored anywhere to leak or rotate.

**Q: How do you limit what a pipeline can do in Azure?**
> Scope the Service Connection's RBAC role assignment as narrowly as possible — ideally a specific role on a single resource group, not Contributor/Owner across the whole subscription.

---

## 39.8 Summary

A Service Connection is the bridge that lets an Azure Pipeline securely act on Azure resources. It authenticates through Entra ID — ideally via secretless Workload Identity Federation (OIDC) — and its RBAC role assignment, scoped as narrowly as possible, determines what it can do. Memorize the flow: **Pipeline → Service Connection → Entra ID → Service Principal/WIF → RBAC → Azure Resource.** It's one of the most commonly tested integration flows for this role, and the secure-by-default answer is always "WIF/OIDC, least-privilege scoped."

---
---

# 40. 📜 Azure Pipelines — YAML Deep Dive
> 🔴 FULL

---

## 40.1 What Problem Does This Solve?

Azure Pipelines automates build, test, and deployment. Modern pipelines are defined as **YAML files stored in your Git repository** ("pipeline as code") rather than clicked together in a UI — giving version control, code review, and history. Understanding the YAML structure (stages, jobs, steps, tasks, triggers) is essential — this is the core of your JD's "YAML-based CI/CD pipelines."

> 💡 **If you know AWS:** An Azure Pipelines YAML file is analogous to a `buildspec.yml` (CodeBuild) + CodePipeline definition combined — but more powerful, defining the entire multi-stage build-and-deploy flow in one version-controlled file.

---

## 40.2 The YAML Structure (Flow Diagram)

```
PIPELINE (the whole azure-pipelines.yml file)
│
├── TRIGGER  → what starts it (a push to main, a PR, a schedule)
│
├── STAGE: Build                          ┐
│   └── JOB: BuildJob                      │ Stages run in sequence;
│       ├── STEP (task): install deps      │ jobs within a stage can
│       ├── STEP (task): run tests         │ run in parallel; steps
│       └── STEP (task): build artifact    │ within a job run in order
│                                          │
├── STAGE: DeployToDev                     │
│   └── JOB: deploy                        │
│       └── STEP (task): deploy to Dev     │
│                                          │
└── STAGE: DeployToProd                    ┘
    └── (with an approval gate — Section 46)

Hierarchy: Pipeline → Stages → Jobs → Steps (Tasks)
```

| Level | What It Is |
|---|---|
| **Trigger** | What automatically starts the pipeline (push, PR, schedule) |
| **Stage** | A major phase (Build, Test, Deploy) — run sequentially, can have gates between them |
| **Job** | A unit of work that runs on one agent; jobs can run in parallel |
| **Step / Task** | An individual action (run a script, use a prebuilt task) |
| **Agent (Pool)** | The machine that runs the job (Section 44) |

---

## 40.3 A Complete Example Pipeline

```yaml
# azure-pipelines.yml (lives in the repo root)

trigger:                     # CI trigger: runs on pushes to main
  branches:
    include: [ main ]

pr:                          # also runs on PRs targeting main
  branches:
    include: [ main ]

pool:
  vmImage: 'ubuntu-latest'   # Microsoft-hosted agent (Section 44)

stages:
- stage: Build
  jobs:
  - job: BuildAndTest
    steps:
      - task: UsePythonVersion@0
        inputs:
          versionSpec: '3.11'
      - script: pip install -r requirements.txt
        displayName: 'Install dependencies'
      - script: pytest tests/
        displayName: 'Run tests'          # pipeline STOPS here if tests fail
      - task: Docker@2
        inputs:
          containerRegistry: 'acr-connection'   # a Service Connection
          repository: 'myapp'
          command: 'buildAndPush'
          tags: '$(Build.BuildId)'         # unique tag per run

- stage: Deploy
  dependsOn: Build           # only runs if Build succeeded
  jobs:
  - deployment: DeployToAKS
    environment: 'production'  # ties into Environments + Approvals (Sections 45-46)
    strategy:
      runOnce:
        deploy:
          steps:
            - task: KubernetesManifest@1
              inputs:
                action: 'deploy'
                kubernetesServiceConnection: 'aks-connection'
                manifests: 'manifests/*.yaml'
```

---

## 40.4 Triggers (What Starts a Pipeline)

| Trigger | Fires When |
|---|---|
| **CI trigger** (`trigger:`) | Code is pushed to specified branches |
| **PR trigger** (`pr:`) | A Pull Request targets specified branches |
| **Scheduled trigger** (`schedules:`) | On a cron schedule (e.g., nightly) |
| **Pipeline trigger** | Another pipeline completes |

---

## 40.5 Steps — Creating a YAML Pipeline in Azure DevOps

```
📍 In Azure DevOps (dev.azure.com), not the Azure Portal.

📍 START: dev.azure.com → your project → "Pipelines" → "Create Pipeline"
    ↓
"Where is your code?" → choose Azure Repos Git (or GitHub)
    ↓
Select your repository
    ↓
"Configure your pipeline" → "Starter pipeline" (or it detects your app type)
    ↓
Edit the azure-pipelines.yml in the browser (or it uses the one already
in your repo)
    ↓
"Save and run" → commits the YAML to your repo and runs the pipeline

📍 RESULT: The pipeline definition lives in your repo (version-controlled),
   and runs automatically on every push/PR per its triggers.
```

---

## 40.6 Real-World Example

```
A multi-service voting app's pipeline:

trigger: runs on every push to main AND every PR
Build stage: installs deps, runs unit tests (fails fast if broken),
             builds a Docker image tagged with the unique build ID,
             pushes it to ACR
Deploy stage: depends on Build succeeding; deploys the exact image just
             built to AKS via Kubernetes manifests; gated by a production
             approval

Because it's YAML in the repo:
- The pipeline is version-controlled alongside the code
- Changes to the pipeline go through PR review like any code
- You can see exactly what pipeline config produced any past build
```

---

## 40.7 Interview Q&A

**Q: What's the structure of an Azure Pipelines YAML file?**
> Pipeline → Stages → Jobs → Steps (Tasks). A trigger defines what starts it; stages are major phases (Build, Deploy) that run sequentially and can have gates between them; jobs run on agents (and can run in parallel); steps/tasks are individual actions. The whole thing lives as a YAML file in the repo.

**Q: Why use YAML pipelines instead of Classic (UI) pipelines?**
> Because YAML pipelines are "pipeline as code" — stored in the repo alongside your application, so they're version-controlled, reviewable via Pull Requests, and you can see exactly what pipeline configuration was used for any past build. Classic UI pipelines lack this version control and reviewability.

**Q: What's the difference between a CI trigger and a PR trigger?**
> A CI trigger (`trigger:`) runs the pipeline when code is pushed to specified branches (e.g., after a merge to main). A PR trigger (`pr:`) runs it when a Pull Request targets specified branches — before merge — so combined with a branch policy, broken code can be caught before it's even merged.

---

## 40.8 Summary

Azure Pipelines YAML defines your CI/CD "as code" in a version-controlled file in your repo, structured as Pipeline → Stages → Jobs → Steps (Tasks), started by triggers (CI on push, PR on pull request, scheduled, or pipeline-chained). YAML is preferred over the older Classic UI approach because it's version-controlled, PR-reviewable, and traceable. Master the structure and the example flow — build/test/package in a Build stage, then deploy in a dependent Deploy stage — because it's the core of your JD's YAML-pipeline requirement. Multi-stage design and promotion across environments is covered next.

---
---

# 41. 🚀 Multi-Stage Pipeline Design (Dev → QA → Staging → Prod)
> 🔴 FULL

---

## 41.1 What Problem Does This Solve?

You never want to deploy untested code straight to production. Real organizations promote a build through a series of environments — Dev → QA → Staging → Production — with increasing confidence and control at each step. A **multi-stage pipeline** models this promotion flow, so the exact same tested artifact flows through each environment, with gates before the sensitive ones.

> 💡 **If you know AWS:** This is the same concept as promoting an artifact through CodePipeline stages across multiple environments/accounts, with manual approval actions before production.

---

## 41.2 The Promotion Flow (Flow Diagram)

```
Code merged to main
       ↓
┌─────────────┐   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│  BUILD      │──►│  DEV        │──►│  QA / STAGING│──►│  PRODUCTION  │
│  once       │   │  auto-deploy │   │  auto-deploy │   │  deploy AFTER│
│  build the  │   │  + smoke     │   │  + full test │   │  MANUAL      │
│  artifact   │   │  tests       │   │  suite       │   │  APPROVAL    │
└─────────────┘   └─────────────┘   └─────────────┘   └─────────────┘

⭐ KEY PRINCIPLE: Build the artifact ONCE, then promote that SAME
   artifact through each environment. Never rebuild per environment —
   that would risk deploying something different than what you tested.
```

---

## 41.3 Why "Build Once, Deploy Many"

```
❌ WRONG: rebuild the app separately for Dev, QA, and Prod
   Risk: the Prod build could differ subtly from what QA tested
   (different dependency versions, build environment, etc.)

✅ RIGHT: build ONE artifact (e.g., one Docker image with a unique tag),
   and deploy that EXACT same image to Dev, then QA, then Prod
   → what you tested is precisely what reaches production
```

---

## 41.4 Increasing Control at Each Stage

| Stage | Deploy Trigger | Testing | Gate |
|---|---|---|---|
| **Dev** | Automatic on merge | Smoke tests | None (fast feedback) |
| **QA / Staging** | Automatic after Dev passes | Full test suite, integration tests | Maybe an automated quality gate |
| **Production** | After manual approval | — | Manual approval + checks (Section 46) |

---

## 41.5 Example Multi-Stage Pipeline

```yaml
stages:
- stage: Build
  jobs:
  - job: Build
    steps:
      - task: Docker@2
        inputs:
          containerRegistry: 'acr-connection'
          repository: 'myapp'
          command: 'buildAndPush'
          tags: '$(Build.BuildId)'   # the ONE artifact we'll promote

- stage: DeployDev
  dependsOn: Build
  jobs:
  - deployment: Dev
    environment: 'dev'               # no approval — auto-deploys
    strategy:
      runOnce:
        deploy:
          steps:
            - script: ./deploy.sh dev $(Build.BuildId)

- stage: DeployQA
  dependsOn: DeployDev
  jobs:
  - deployment: QA
    environment: 'qa'
    strategy:
      runOnce:
        deploy:
          steps:
            - script: ./deploy.sh qa $(Build.BuildId)   # SAME image tag
            - script: ./run-full-tests.sh

- stage: DeployProd
  dependsOn: DeployQA
  condition: succeeded()
  jobs:
  - deployment: Prod
    environment: 'production'        # ⭐ approval gate configured here (Section 46)
    strategy:
      runOnce:
        deploy:
          steps:
            - script: ./deploy.sh prod $(Build.BuildId)  # SAME image tag
```

Notice `$(Build.BuildId)` is the same tag throughout — the identical artifact is promoted, never rebuilt.

---

## 41.6 Steps — Setting Up Environments for a Multi-Stage Pipeline

```
📍 In Azure DevOps (dev.azure.com).

📍 Create Environments: Pipelines → "Environments" → "New environment"
   → create "dev", "qa", "production" (Section 45 covers Environments)
    ↓
📍 Add an approval to the production Environment:
   open "production" → "⋮" → "Approvals and checks" → "+ Approvals"
   → add the required approvers (e.g., team leads)
    ↓
📍 The multi-stage YAML references these environments by name
   (environment: 'production'), so deployments to production
   automatically pause for approval.

📍 RESULT: The pipeline auto-flows through Dev and QA, then PAUSES for
   approval before Production — the same tested artifact promoted throughout.
```

---

## 41.7 Real-World Example

```
An e-commerce team's release flow:

1. Developer merges a change to main.
2. BUILD stage: builds one Docker image tagged with the build ID, pushes
   to ACR.
3. DEV stage: auto-deploys that image to the Dev AKS namespace; smoke
   tests confirm it starts up.
4. QA stage: auto-deploys the SAME image to QA; the full automated test
   suite + integration tests run.
5. PRODUCTION stage: pauses. A team lead reviews and clicks "Approve."
   Only then does the SAME image deploy to production.

If QA tests fail, the pipeline stops — production is never reached.
Because the identical artifact flowed through every stage, there's zero
risk that production got something different than what QA validated.
```

---

## 41.8 Interview Q&A

**Q: Describe a multi-stage pipeline for promoting a release.**
> The pipeline builds the artifact once, then promotes that same artifact through a series of environment stages — typically Dev (auto-deploy + smoke tests), QA/Staging (auto-deploy + full test suite), and Production (deploy only after a manual approval). Each stage depends on the previous succeeding, and gates/approvals protect the sensitive environments.

**Q: Why is "build once, deploy many" important?**
> Because rebuilding separately per environment risks the production build differing from what was tested in QA (different dependency versions, build conditions, etc.). Building one artifact and promoting that exact same artifact through each environment guarantees that what reaches production is precisely what was validated in earlier stages.

**Q: How do you protect the production stage in a multi-stage pipeline?**
> By tying the production deployment to an Azure DevOps Environment that has required Approvals (and optionally automated checks) configured — so the pipeline pauses and waits for a designated approver before deploying to production, enforcing separation of duties.

---

## 41.9 Summary

A multi-stage pipeline models the real-world promotion of a release through Dev → QA → Staging → Production, with increasing control and testing at each step and a manual approval gate before production. The critical principle is "build once, deploy many" — build a single artifact (e.g., one uniquely-tagged Docker image) and promote that exact artifact through every environment, guaranteeing production gets precisely what was tested. Environments and approvals (Sections 45–46) provide the gating; this design is central to the JD's "smooth, repeatable deployments across environments."

---

---
---

# 42. 🔧 Pipeline Variables, Variable Groups & Templates
> 🔴 FULL

---

## 42.1 What Problem Does This Solve?

Pipelines need configuration values (environment names, connection strings, flags) that differ between environments and shouldn't be hardcoded. And as you build many pipelines, you don't want to copy-paste the same YAML everywhere. **Variables** hold configuration, **Variable Groups** share it across pipelines (and pull secrets from Key Vault), and **Templates** let you reuse pipeline logic — the building blocks of maintainable, DRY pipelines.

> 💡 **If you know AWS:** Variables/Variable Groups are like CodeBuild environment variables + Parameter Store/Secrets Manager references; Templates are like reusable CloudFormation/CDK constructs or shared buildspec fragments.

---

## 42.2 The Three Concepts (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  VARIABLES        → single config values used in a pipeline│
│                     (e.g., environmentName = "production") │
│                                                            │
│  VARIABLE GROUPS  → a SHARED set of variables reusable     │
│                     across multiple pipelines; can be      │
│                     LINKED to Key Vault to pull secrets     │
│                                                            │
│  TEMPLATES        → reusable YAML files (a set of steps/    │
│                     jobs/stages) referenced by many         │
│                     pipelines — write once, use everywhere  │
└──────────────────────────────────────────────────────────┘
```

---

## 42.3 Variables

```yaml
# Inline variables in a pipeline
variables:
  buildConfiguration: 'Release'
  environmentName: 'production'

steps:
  - script: echo "Building in $(buildConfiguration) for $(environmentName)"
    # $(variableName) is how you reference a variable
```

**Types of variables:**
- **Plain variables** — visible values (build config, environment name)
- **Secret variables** — masked in logs, set in the pipeline UI or from Key Vault (never printed in plain text)

---

## 42.4 Variable Groups (Shared + Key Vault Integration)

A **Variable Group** is a named set of variables, defined once in Azure DevOps and reused across many pipelines. Critically, it can be **linked to a Key Vault** so secrets are pulled securely at runtime (this is one of the Key Vault integration methods from Section 33).

```yaml
variables:
  - group: 'production-config'   # references a Variable Group
  - group: 'production-secrets'  # this one is LINKED to Key Vault

steps:
  - script: echo "DB host is $(dbHost)"          # from production-config
  - script: ./deploy.sh --key $(apiKey)          # apiKey pulled from Key Vault
    # apiKey is automatically masked in the logs
```

```
Variable Group linked to Key Vault (flow):
   Pipeline references the Variable Group
       ↓
   Variable Group is linked to Key Vault "myapp-kv"
       ↓ (via the Service Connection's identity + RBAC)
   Secrets from the vault appear as pipeline variables, masked in logs
```

---

## 42.5 Templates (Reusable YAML)

Templates let you write pipeline logic once and reuse it, avoiding copy-paste across many pipelines.

```yaml
# templates/build-and-test.yml (a reusable template)
parameters:
  - name: pythonVersion
    default: '3.11'

steps:
  - task: UsePythonVersion@0
    inputs:
      versionSpec: ${{ parameters.pythonVersion }}
  - script: pip install -r requirements.txt
  - script: pytest tests/
```

```yaml
# azure-pipelines.yml (uses the template)
steps:
  - template: templates/build-and-test.yml   # reuse the shared logic
    parameters:
      pythonVersion: '3.12'
```

**Why templates matter in real orgs:** A standard "build and test" or "deploy to AKS" template is written once by the platform team, and every project's pipeline references it — ensuring consistency and letting you update the standard in one place.

---

## 42.6 Steps — Creating a Variable Group Linked to Key Vault

```
📍 In Azure DevOps (dev.azure.com).

📍 START: Pipelines → "Library" → "+ Variable group"
   ┌────────────────────────────────────────────┐
   │ Variable group name: production-secrets      │
   │ ✅ Link secrets from an Azure Key Vault       │
   │    Azure subscription: [Service Connection]   │
   │    Key Vault name:      myapp-kv              │
   │    + Add: select which secrets to expose      │
   └────────────────────────────────────────────┘
   → "Save"
    ↓
📍 Reference it in a pipeline with:
   variables:
     - group: 'production-secrets'

📍 RESULT: The pipeline can use the Key Vault secrets as variables,
   automatically masked in logs — no secret ever hardcoded.
```

---

## 42.7 Real-World Example

```
A team has three environments and wants DRY, secure, consistent pipelines:

Variable Groups:
   "dev-config"  / "qa-config"  / "prod-config"  → environment-specific
      plain values (DB hostnames, feature flags, instance counts)
   "prod-secrets" → LINKED to Key Vault, pulls the production DB password
      and API keys securely

Templates:
   "templates/build.yml"     → the standard build + test + scan steps
   "templates/deploy-aks.yml" → the standard AKS deployment steps

Each environment's pipeline stage references the right Variable Group
and the shared templates. Result:
- Zero hardcoded secrets (all via Key Vault-linked Variable Group)
- Consistent build/deploy logic (all via shared templates)
- Environment differences isolated to Variable Groups, not scattered
  through the YAML
- To update the standard build process, edit ONE template — every
  pipeline picks it up.
```

---

## 42.8 Interview Q&A

**Q: What's the difference between a variable, a variable group, and a template?**
> A variable is a single config value used within a pipeline. A variable group is a named, shared set of variables reusable across multiple pipelines — and it can be linked to Key Vault to pull secrets securely. A template is a reusable YAML file (steps/jobs/stages) referenced by many pipelines so you write logic once and reuse it everywhere.

**Q: How do you get secrets into a pipeline securely?**
> Use a Variable Group linked to Azure Key Vault (or the AzureKeyVault task). The secrets are pulled at runtime via the Service Connection's identity and RBAC, exposed as pipeline variables, and automatically masked in the logs — so nothing is ever hardcoded in the YAML.

**Q: Why use pipeline templates?**
> To avoid copy-pasting the same YAML across many pipelines. A platform team writes a standard template (e.g., build-and-test, or deploy-to-AKS) once, and every project references it — ensuring consistency and letting you update the standard in one central place.

---

## 42.9 Summary

Variables hold single config values; Variable Groups are shared, reusable sets of variables that can be linked to Key Vault for secure secret retrieval (masked in logs); and Templates are reusable YAML fragments that eliminate copy-paste and enforce consistency across pipelines. Together they make pipelines DRY, secure, and maintainable — environment differences live in Variable Groups, secrets come from Key Vault-linked groups, and standard logic lives in shared Templates you update in one place.

---
---

# 43. 💾 Pipeline Caching & Artifacts
> 🟡 KNOW-THIS-MUCH

---

## 43.1 What Problem Does This Solve?

Two related pipeline efficiency needs: (1) rebuilding the same dependencies from scratch on every run is slow and wasteful — **caching** speeds this up; and (2) the output of one stage (a built app) needs to be passed to a later stage (deploy) — **pipeline artifacts** handle this.

> 💡 **If you know AWS:** Pipeline caching is like CodeBuild's local/dependency caching; pipeline artifacts are like the artifacts passed between CodePipeline stages (via S3).

---

## 43.2 Caching vs Artifacts (Flow Diagram)

```
CACHING — speeds up repeated work:
   Run 1: download all npm/pip dependencies (slow) → cache them
   Run 2: restore dependencies from cache (fast!) → skip re-downloading

ARTIFACTS — passes output between stages:
   Build Stage: compiles the app → publishes it as a "pipeline artifact"
       ↓ (artifact stored by the pipeline)
   Deploy Stage: downloads that same artifact → deploys it

Different purposes: caching = reuse across RUNS; artifacts = hand off
between STAGES within a run.
```

---

## 43.3 Caching Example

```yaml
steps:
  - task: Cache@2
    inputs:
      key: 'npm | "$(Agent.OS)" | package-lock.json'  # cache key
      path: '$(npm_config_cache)'                       # what to cache
    displayName: 'Cache npm dependencies'
  - script: npm ci
    # If the cache key matches (package-lock.json unchanged), dependencies
    # are restored from cache instead of re-downloaded — much faster.
```

---

## 43.4 Pipeline Artifacts Example

```yaml
stages:
- stage: Build
  jobs:
  - job: Build
    steps:
      - script: npm run build         # produces a "dist" folder
      - publish: dist                  # publish it as a pipeline artifact
        artifact: myapp-build

- stage: Deploy
  dependsOn: Build
  jobs:
  - job: Deploy
    steps:
      - download: current              # download the artifact from Build
        artifact: myapp-build
      - script: ./deploy.sh $(Pipeline.Workspace)/myapp-build
```

This is how the "build once, deploy many" principle (Section 41) works mechanically — the Build stage publishes an artifact, and each deploy stage downloads that same artifact.

---

## 43.5 Steps — Enabling Caching & Artifacts

```
📍 Both are configured in the pipeline YAML (shown above), not the Portal.

Caching:  add a Cache@2 task before your dependency-install step.
Artifacts: use "publish" in the build stage and "download" in later stages.

📍 You can view published artifacts in Azure DevOps:
   Pipelines → open a run → "Related" / "Artifacts" section shows the
   published pipeline artifacts for that run.
```

---

## 43.6 Real-World Example

```
A Node.js app's pipeline was taking 8 minutes per run, mostly on
"npm install" downloading hundreds of packages every time:

Step 1: Add a Cache@2 task keyed on package-lock.json. Now, unless
        dependencies change, they're restored from cache in seconds
        instead of re-downloaded → build time drops to ~3 minutes.

Step 2: The Build stage publishes the compiled "dist" folder as a
        pipeline artifact.

Step 3: The Dev, QA, and Prod deploy stages each download that same
        artifact and deploy it — guaranteeing the identical build is
        promoted through all environments (build once, deploy many).

Result: Faster pipelines (caching) and safe artifact promotion across
stages (artifacts).
```

---

## 43.7 Interview Q&A

**Q: What's the difference between pipeline caching and pipeline artifacts?**
> Caching speeds up repeated work across pipeline runs by storing and restoring things like downloaded dependencies (keyed on something like a lock file). Artifacts pass the output of one stage (like a built app) to later stages within the same run — enabling "build once, deploy many" where the Build stage publishes an artifact and each deploy stage downloads that same artifact.

---

## 43.8 Summary

Pipeline caching speeds up runs by reusing downloaded dependencies across runs (via a Cache task keyed on a lock file), while pipeline artifacts pass a build's output between stages (publish in Build, download in Deploy) — the mechanism behind "build once, deploy many." Caching optimizes speed; artifacts ensure the same tested build is promoted through every environment.

---
---

# 44. 🏃 Azure DevOps Agents (Microsoft-hosted vs Self-hosted)
> 🟠 MEDIUM

---

## 44.1 What Problem Does This Solve?

A pipeline's steps have to actually *run somewhere* — on a machine with the right tools installed. That machine is called an **agent**. You choose between Microsoft managing those machines for you (Microsoft-hosted) or running your own (self-hosted) — a choice with real trade-offs around convenience, control, cost, and network access.

> 💡 **If you know AWS:** Agents are like CodeBuild's build environment — Microsoft-hosted is like CodeBuild's managed compute, while self-hosted is like running your own build servers (e.g., on EC2) for more control/network access.

---

## 44.2 The Two Types (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  MICROSOFT-HOSTED AGENT                                   │
│  • Microsoft provides a fresh, clean VM for each pipeline  │
│    run, pre-loaded with common tools                       │
│  • Destroyed after the run (clean slate every time)        │
│  • Zero maintenance for you                                │
│  • BUT: can't access your private network/resources        │
│    directly, limited customization, usage-minute limits    │
│  → Use for: most standard builds, public/cloud deployments │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│  SELF-HOSTED AGENT                                        │
│  • YOU run the agent (on a VM, on-premises, or in a        │
│    container) and install the tools you need               │
│  • Persists between runs (can cache things, faster starts) │
│  • CAN access your private network (private VNet resources,│
│    on-premises systems, private package feeds)             │
│  • BUT: you maintain/patch/secure it yourself              │
│  → Use for: private network access, custom tools, high     │
│    volume, or specific compliance needs                    │
└──────────────────────────────────────────────────────────┘
```

---

## 44.3 Comparison Table

| Aspect | Microsoft-hosted | Self-hosted |
|---|---|---|
| Maintenance | None (Microsoft manages) | You manage/patch/secure |
| State between runs | Fresh/clean each time | Persists (faster, cacheable) |
| Private network access | ❌ Limited | ✅ Yes (key reason to use it) |
| Custom tools | Limited to pre-installed | Install anything you need |
| Cost model | Included minutes + parallel job charges | You pay for the machine, but no per-minute agent charge |
| Best for | Standard cloud builds | Private resources, custom needs, high volume |

---

## 44.4 The #1 Reason to Use Self-Hosted: Private Network Access

```
Scenario: Your pipeline needs to deploy to resources in a PRIVATE VNet
that has no public access (e.g., a database behind a Private Endpoint,
or an on-premises system).

Microsoft-hosted agent: runs in Microsoft's cloud → can't reach your
                        private VNet resources directly.

Self-hosted agent: run it INSIDE your VNet (or on-premises) → it can
                   reach those private resources directly.

This is the most common real reason organizations use self-hosted agents.
```

---

## 44.5 Steps — Setting Up Agents

```
── Using a Microsoft-hosted agent (default) ──
📍 Just specify a vmImage in your YAML — nothing to set up:
   pool:
     vmImage: 'ubuntu-latest'    # or 'windows-latest'

── Setting up a Self-hosted agent ──
📍 In Azure DevOps: "Project settings" → "Agent pools" → "Add pool"
   → type "Self-hosted" → name it (e.g., "private-vnet-pool")
    ↓
📍 On your own VM (inside your VNet): download the agent software from
   the pool's instructions, run the config script (providing your org
   URL + a Personal Access Token), and the agent registers itself.
    ↓
📍 Reference it in YAML:
   pool:
     name: 'private-vnet-pool'

📍 RESULT: Your pipeline now runs on your own machine inside your VNet,
   able to reach private resources.
```

---

## 44.6 Real-World Example

```
A company deploys to an AKS cluster and Azure SQL that are BOTH locked
behind Private Endpoints (no public access, for security):

Problem: Microsoft-hosted agents run in Microsoft's cloud and can't
reach these private resources.

Solution:
Step 1: Provision a small VM inside the company's VNet.
Step 2: Install a self-hosted Azure DevOps agent on it, registered to
        a "private-agents" pool.
Step 3: Point the deployment pipeline stages at this self-hosted pool.
Step 4: Now the pipeline agent, running inside the VNet, can reach the
        private AKS cluster and private database directly to deploy.

For the earlier build/test stages (which don't need private access),
they keep using free Microsoft-hosted agents — a common hybrid approach.
```

---

## 44.7 Interview Q&A

**Q: What's the difference between Microsoft-hosted and self-hosted agents?**
> Microsoft-hosted agents are fresh, clean VMs Microsoft provides and manages for each pipeline run (zero maintenance, but can't reach your private network and have usage limits). Self-hosted agents are machines you run yourself (on a VM, on-premises, or in a container) — you maintain them, but they can access private network resources, run custom tools, and persist state between runs.

**Q: When would you need a self-hosted agent?**
> Most commonly when the pipeline needs to reach resources on a private network that Microsoft-hosted agents can't — like a database behind a Private Endpoint, a private AKS cluster, an on-premises system, or a private package feed. Also for custom tooling, specific compliance requirements, or very high build volume.

---

## 44.8 Summary

Pipeline steps run on agents — either Microsoft-hosted (fresh, managed VMs per run, zero maintenance, but no private-network access and usage limits) or self-hosted (your own machines, requiring maintenance, but able to reach private resources, run custom tools, and persist state). The #1 reason to use self-hosted is accessing private-network resources (private AKS, Private Endpoint databases, on-premises systems). A common hybrid: Microsoft-hosted for build/test, self-hosted for deploying to private environments.

---
---

# 45. 🌍 Environments
> 🟠 MEDIUM

---

## 45.1 What Problem Does This Solve?

When a pipeline deploys, it deploys *to* something — Dev, QA, Production. Azure DevOps **Environments** represent these deployment targets, giving you a place to add protections (approvals, checks), see deployment history, and control who can deploy where. They're the foundation for safe, governed deployments.

> 💡 **If you know AWS:** Environments are conceptually like CodePipeline's stages/deployment targets combined with the approval/gate capabilities — a named deployment target you can protect and track.

---

## 45.2 What an Environment Provides (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  ENVIRONMENT: "production"                                │
│                                                            │
│  • Deployment history: every deploy to prod, when, by whom │
│  • Approvals & Checks: who must approve before deploying    │
│    here (Section 46)                                        │
│  • Security: who is allowed to deploy to this environment   │
│  • Resources: can link the actual AKS namespace / VMs        │
└──────────────────────────────────────────────────────────┘

A pipeline's deployment job targets an environment by name:
   environment: 'production'
   → the environment's approvals/checks/security automatically apply
```

---

## 45.3 How Pipelines Use Environments

```yaml
jobs:
- deployment: DeployProd
  environment: 'production'   # ← targets the "production" Environment
  strategy:
    runOnce:
      deploy:
        steps:
          - script: ./deploy.sh prod
```

Because the deployment job references `environment: 'production'`, any approvals or checks configured on that Environment (Section 46) automatically gate this deployment — and the deployment is recorded in the Environment's history.

---

## 45.4 Steps — Creating an Environment

```
📍 In Azure DevOps (dev.azure.com).

📍 START: Pipelines → "Environments" → "New environment"
   ┌────────────────────────────────────────┐
   │ Name:        production                  │
   │ Description: Production deployment target │
   │ Resource:    None / Kubernetes / VMs      │
   │  (optionally link the actual AKS namespace│
   │   or VMs for richer tracking)             │
   └────────────────────────────────────────┘
   → "Create"
    ↓
📍 (Optional) Add approvals/checks: open the environment → "⋮" →
   "Approvals and checks" (Section 46)
    ↓
📍 Reference it in your pipeline YAML: environment: 'production'

📍 RESULT: A named, trackable, protectable deployment target. Every
   deployment to it is recorded, and any approvals/checks apply automatically.
```

---

## 45.5 Real-World Example

```
A team sets up three Environments matching their release flow:

"dev"        → no approvals; auto-deploys for fast feedback
"qa"         → no approvals; auto-deploys after Dev; runs full tests
"production" → requires 1 lead's approval + a business-hours check
               (Section 46), and is linked to the production AKS namespace
               so every deploy shows up in its history

The multi-stage pipeline (Section 41) references these environments by
name. Result: deployments flow automatically through dev and qa, then
pause at production for approval — with a complete audit trail of who
deployed what, when, to each environment.
```

---

## 45.6 Interview Q&A

**Q: What is an Azure DevOps Environment?**
> A named representation of a deployment target (like Dev, QA, or Production) that a pipeline deploys to. It provides deployment history (an audit trail of what was deployed when and by whom), a place to attach approvals and checks (gates), security controls over who can deploy, and optional linking to the actual resources (like an AKS namespace).

**Q: How do Environments enable safe deployments?**
> By letting you attach approvals and checks to sensitive environments like Production — so when a pipeline's deployment job targets that environment, it automatically pauses for the required approvals/checks before proceeding. This enforces governance and separation of duties without cluttering the pipeline YAML itself.

---

## 45.7 Summary

Azure DevOps Environments represent deployment targets (Dev, QA, Production), providing deployment history, security controls, and — most importantly — a place to attach approvals and checks that automatically gate deployments to sensitive environments. A pipeline's deployment job references an environment by name, and that environment's protections apply automatically. Environments are the foundation for governed, auditable, multi-stage deployments (Section 41), with approvals/checks covered next.

---
---

# 46. ✅ Approvals & Checks / Release Gates
> 🔴 FULL

---

## 46.1 What Problem Does This Solve?

Even in a fully automated pipeline, you often need a human checkpoint or an automated condition before deploying to production — "a lead must approve," "only during business hours," "no active incidents." **Approvals and Checks** on an Environment provide these gates, giving you controlled, governed deployments without sacrificing automation elsewhere. This directly supports your JD's "release readiness and rollback procedures."

> 💡 **If you know AWS:** Approvals are like CodePipeline's manual approval actions; automated checks are like approval conditions/gates you'd build with Lambda or CloudWatch alarms before a production stage.

---

## 46.2 Approvals vs Checks (Flow Diagram)

```
A pipeline tries to deploy to the "production" Environment
       ↓
┌──────────────────────────────────────────────────────────┐
│  APPROVALS (human gates)                                  │
│    • A designated person (e.g., a team lead) must click    │
│      "Approve" before the deployment proceeds              │
│    • Can require multiple approvers, add timeouts          │
│    • Enforces separation of duties (you can't approve      │
│      your own deployment)                                  │
│                                                            │
│  CHECKS (automated gates)                                 │
│    • Business hours: only deploy during allowed times      │
│    • Invoke an Azure Function / REST API: e.g., "is there  │
│      an active incident?" — proceed only if the check      │
│      returns OK                                            │
│    • Query Azure Monitor: e.g., "is error rate healthy?"   │
│    • Require a specific branch, or a ServiceNow change      │
│      ticket to be approved                                 │
└───────────────────────┬───────────────────────────────────┘
                        ↓
       ALL approvals + checks pass → deployment PROCEEDS
       Any pending/failing → deployment WAITS or is BLOCKED
```

---

## 46.3 Common Approvals & Checks

| Type | Example |
|---|---|
| **Manual Approval** | "A team lead must approve before prod deploy" |
| **Business Hours check** | "Only deploy Mon–Fri, 9am–5pm" (avoid risky Friday-night deploys) |
| **Invoke Azure Function/REST API** | "Only proceed if the incident-management system reports no active P1" |
| **Query Azure Monitor Alerts** | "Only proceed if there are no firing critical alerts" |
| **Required template / branch control** | "Only deployments from main are allowed to prod" |

---

## 46.4 Steps — Adding an Approval to an Environment

```
📍 In Azure DevOps (dev.azure.com).

📍 START: Pipelines → "Environments" → open "production" → "⋮" →
   "Approvals and checks"
    ↓
Click "+ " → choose "Approvals"
   ┌────────────────────────────────────────┐
   │ Approvers:  [team leads / release mgrs]  │
   │ Advanced:                                 │
   │   ✅ Requesters cannot approve their own   │
   │      runs (separation of duties)          │
   │   Timeout: 30 days                        │
   └────────────────────────────────────────┘
   → "Create"
    ↓
📍 (Optional) Add automated checks: "+ " → e.g., "Business Hours"
   (allowed deploy window) or "Invoke Azure Function" (custom condition)

📍 RESULT: Any pipeline deploying to the "production" environment now
   pauses for lead approval (and any checks) before proceeding — with
   the approver unable to be the person who triggered the deployment.
```

---

## 46.5 How This Enables Rollback / Release Readiness

```
Release readiness: the approval step IS the "release readiness gate" —
   the approver verifies tests passed, the change is ready, and there's
   no active incident, before allowing production deployment.

Rollback: if a deployment goes wrong, you re-run the pipeline targeting
   the previous known-good artifact (build once/deploy many, Section 41),
   which flows through the same approval gate — OR, for slot-based/
   feature-flag deployments (Sections 63-65), rollback is an instant
   slot-swap-back or flag-off, no full pipeline needed.
```

---

## 46.6 Real-World Example

```
A payment platform enforces strict production deployment controls:

On the "production" Environment:
   • Manual Approval: requires a release manager's approval, and the
     developer who triggered it CANNOT approve their own deploy
   • Business Hours check: production deploys only allowed Mon–Thu
     9am–4pm (never Friday afternoon or weekends, to avoid deploying
     right before nobody's around to fix issues)
   • Invoke Azure Function check: queries the incident system — if
     there's an active P1 incident, the deploy is blocked

Flow: a developer's pipeline builds and passes QA automatically, then
PAUSES at production. The release manager reviews (release readiness),
the business-hours + incident checks pass, they approve, and only then
does production deploy.

Result: automated speed through dev/qa, with strict, auditable human
and automated control at the production boundary.
```

---

## 46.7 Interview Q&A

**Q: What's the difference between Approvals and Checks?**
> Approvals are human gates — a designated person must manually approve before a deployment to an environment proceeds (often with separation of duties so you can't approve your own). Checks are automated gates — conditions like business hours, querying an incident system or Azure Monitor, or requiring a specific branch/change ticket — that must be satisfied automatically before proceeding. Both are attached to an Environment.

**Q: How do you enforce separation of duties in deployments?**
> By configuring a manual Approval on the production Environment with the "requesters cannot approve their own runs" option — so the developer who triggered a deployment cannot be the one who approves it to production; a different designated approver (like a team lead) must.

**Q: How does this relate to release readiness and rollback?**
> The approval step is effectively the release-readiness gate — the approver confirms the change is tested and safe and there's no active incident before allowing production. For rollback, you either re-run the pipeline with the previous known-good artifact (which passes through the same gate) or, with slot/feature-flag deployments, do an instant slot-swap-back or feature-flag-off.

---

## 46.8 Summary

Approvals and Checks attach to Azure DevOps Environments to gate deployments: Approvals are human checkpoints (a lead must approve, with separation of duties), while Checks are automated conditions (business hours, no active incidents, healthy monitoring, correct branch). Together they give governed, auditable production deployments — the approval step serves as the release-readiness gate — while keeping earlier stages fully automated. This directly supports the JD's release-readiness and rollback responsibilities.

---
---

# 47. 🔗 Azure Boards ↔ Repos/GitHub Traceability
> 🟡 KNOW-THIS-MUCH

---

## 47.1 What Problem Does This Solve?

In a real organization, you need to answer: "Why was this code changed? What requirement drove it? Which deployment included it?" **Traceability** links work items (Boards) → code commits/PRs (Repos/GitHub) → builds → deployments, so you have a complete, auditable thread from "business requirement" to "running in production."

> 💡 **If you know AWS:** AWS has no single native equivalent (it lacks a built-in work-tracking tool), so this Boards-to-code linkage is a distinctive Azure DevOps strength.

---

## 47.2 The Traceability Chain (Flow Diagram)

```
Work Item (Boards)          "As a user, I want to reset my password"
   ↓ linked to
Commit / Branch (Repos/GitHub)  the actual code changes
   ↓ part of
Pull Request                the reviewed merge
   ↓ triggers
Build (Pipelines)           the CI build that included it
   ↓ deployed by
Release/Deployment          which environments it reached & when

Result: from ANY point you can trace the full thread — e.g., "this
production deployment included PR #42, which implemented User Story
#101 (password reset), reviewed by Sarah, built in run #512."
```

---

## 47.3 How the Links Are Created

```
✅ Linking a commit to a work item: include the work item ID in the
   commit message (e.g., "Fix login bug #101") or link it in the PR
✅ Branch policy "Check for linked work items" (Section 37) can REQUIRE
   every PR to link a work item — enforcing traceability
✅ Work items automatically show their linked commits, PRs, builds, and
   deployments in their "Development" and "Links" sections
✅ Azure Boards ↔ GitHub integration: connect a GitHub repo to Azure
   Boards, then reference work items in GitHub commits/PRs with "AB#101"
```

---

## 47.4 Steps — Connecting Azure Boards to GitHub

```
📍 In Azure DevOps (dev.azure.com).

📍 START: your project → "Project settings" → "GitHub connections"
   → "Connect your GitHub account" → authorize → select the repo(s)
    ↓
📍 Now in GitHub commits or PRs, reference an Azure Boards work item
   with "AB#101" (e.g., commit message "Add password reset AB#101")
    ↓
📍 The work item in Azure Boards automatically shows the linked GitHub
   commit/PR under its "Development" section.

── For Azure Repos (built-in, no setup) ──
📍 Just include "#101" in a commit message or link the work item when
   creating the PR — the linkage appears automatically.

📍 RESULT: A traceable thread from work item → code → PR → build → deploy.
```

---

## 47.5 Real-World Example

```
An auditor asks: "Prove that the change deploying customer data
encryption was properly reviewed and traces to an approved requirement."

Because of traceability:
Step 1: Find the deployment in the pipeline history.
Step 2: It links to build #512, which included PR #42.
Step 3: PR #42 was reviewed and approved by two engineers, and links to
        User Story #101 ("Encrypt customer data at rest"), which was
        planned and approved in the sprint.
Step 4: The whole thread — requirement → reviewed code → build →
        deployment — is documented automatically.

Result: The audit requirement is satisfied in minutes, using the
built-in traceability, rather than manually reconstructing history.
```

---

## 47.6 Interview Q&A

**Q: How does Azure DevOps provide traceability?**
> By linking work items (Boards) to commits and PRs (Repos/GitHub) to builds and deployments (Pipelines). You link a commit to a work item via its ID in the commit message or PR, and a branch policy can require every PR to link a work item. This creates a complete auditable thread from business requirement through reviewed code to production deployment.

**Q: How do you link GitHub commits to Azure Boards work items?**
> Connect the GitHub repo to Azure Boards (via Project settings → GitHub connections), then reference work items in GitHub commits/PRs using the "AB#<id>" syntax (e.g., "AB#101") — the work item then shows the linked GitHub activity automatically.

---

## 47.7 Summary

Traceability links the full chain — work item (Boards) → commit/PR (Repos or GitHub) → build → deployment — giving a complete, auditable thread from business requirement to production. Links are created by referencing work item IDs in commits/PRs (and can be *required* via a branch policy), and Azure Boards integrates with GitHub using the "AB#<id>" syntax. This is invaluable for audits, incident investigation, and understanding *why* any change was made — a distinctive Azure DevOps strength.

---
---

# 48. 📄 ARM Templates
> 🟡 KNOW-THIS-MUCH

---

## 48.1 What Problem Does This Solve?

Manually clicking through the Portal to create resources isn't repeatable, version-controlled, or reviewable. **Infrastructure as Code (IaC)** solves this by describing infrastructure in text files. **ARM Templates** are Azure's original native IaC format — JSON files describing the resources you want. (Your primary IaC skill is Terraform, so this is know-this-much level.)

> 💡 **If you know AWS:** ARM Templates are Azure's equivalent of **AWS CloudFormation templates** — declarative JSON describing your desired resources, deployed through the cloud's native engine.

---

## 48.2 How It Works (Flow Diagram)

```
You write an ARM Template (JSON describing desired resources)
       ↓
Deploy it (Portal, CLI, or pipeline)
       ↓
Azure Resource Manager (Section 2) reads it, figures out dependencies
and order, and creates/updates the resources
       ↓
Your infrastructure exists exactly as described — repeatably
```

ARM is **declarative**: you describe the desired end state, and ARM figures out how to achieve it.

---

## 48.3 Basic Structure

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "storageName": { "type": "string" }
  },
  "variables": {},
  "resources": [
    {
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2023-01-01",
      "name": "[parameters('storageName')]",
      "location": "centralindia",
      "sku": { "name": "Standard_LRS" },
      "kind": "StorageV2"
    }
  ],
  "outputs": {}
}
```

| Section | Purpose |
|---|---|
| **parameters** | Inputs you pass in (e.g., resource names, sizes) |
| **variables** | Reusable values computed within the template |
| **resources** | The actual resources to create |
| **outputs** | Values returned after deployment (e.g., a resource's ID) |

**The honest downside:** JSON is verbose and hard to read/write by hand — which is exactly why Bicep (next section) was created.

---

## 48.4 Steps — Deploying an ARM Template

```
── Via CLI ──
az deployment group create \
  --resource-group my-rg \
  --template-file template.json \
  --parameters storageName=mystorageacct123

── Via Portal ──
📍 portal.azure.com → search "Deploy a custom template" →
   "Build your own template in the editor" → paste/load your JSON →
   fill in parameters → "Review + create" → "Create"

── Preview changes first (what-if) ──
az deployment group what-if --resource-group my-rg --template-file template.json
```

---

## 48.5 Real-World Example

```
A team inherited some existing ARM Templates and wants to understand them:

Step 1: They read the template — parameters (what varies per deployment),
        resources (what gets created), outputs (what's returned).
Step 2: They use "what-if" to preview exactly what a deployment would
        change before running it.
Step 3: Going forward, they decide to convert these to Bicep (Section 49)
        for readability, since Bicep compiles down to the same ARM JSON
        but is far easier to work with.

Note: For NEW infrastructure, most teams now use Bicep or Terraform
rather than hand-writing ARM JSON.
```

---

## 48.6 Interview Q&A

**Q: What are ARM Templates?**
> Azure's original native Infrastructure-as-Code format — JSON files that declaratively describe the Azure resources you want, deployed through Azure Resource Manager, which handles dependencies and ordering. They give repeatability and version control, but the JSON is verbose, which is why Bicep was created as a cleaner alternative that compiles to the same ARM.

---

## 48.7 Summary

ARM Templates are Azure's original native IaC — declarative JSON (with parameters, variables, resources, outputs) deployed through Azure Resource Manager for repeatable, version-controlled infrastructure. They're the equivalent of AWS CloudFormation. The main drawback is verbose JSON syntax, which led to Bicep (next section) — a cleaner language that compiles to the same ARM. For new work, most teams use Bicep or Terraform rather than hand-writing ARM JSON.

---
---

# 49. 💪 Bicep
> 🟠 MEDIUM

---

## 49.1 What Problem Does This Solve?

ARM Templates (Section 48) work but their JSON is verbose and painful to write by hand. **Bicep** is a modern, much cleaner language for Azure IaC that compiles down to the exact same ARM Templates — giving you the same native Azure deployment engine with a dramatically better authoring experience. Your JD lists "ARM/Bicep" as expected knowledge.

> 💡 **If you know AWS:** Bicep is roughly Azure's equivalent of the **AWS CDK's** goal of nicer authoring — though Bicep is a purpose-built declarative DSL (not a general programming language). Simplest framing: Bicep is "ARM Templates, but readable."

---

## 49.2 Bicep vs ARM — Same Thing, Better Syntax (Flow Diagram)

```
You write Bicep (clean, concise)
       ↓
Bicep compiles ("transpiles") to ARM Template JSON automatically
       ↓
Azure Resource Manager deploys it (same engine as ARM Templates)

So Bicep is NOT a different engine — it's a much nicer way to WRITE
the exact same ARM deployment. Everything ARM can do, Bicep can do,
with ~70% less code.
```

### The Same Storage Account — ARM vs Bicep
```
ARM (JSON — verbose):                    Bicep (clean):
{                                        param storageName string
  "type": "Microsoft.Storage/...",
  "apiVersion": "2023-01-01",            resource sa 'Microsoft.Storage/
  "name": "[parameters('storageName')]",   storageAccounts@2023-01-01' = {
  "location": "centralindia",              name: storageName
  "sku": { "name": "Standard_LRS" },       location: 'centralindia'
  "kind": "StorageV2"                       sku: { name: 'Standard_LRS' }
}                                           kind: 'StorageV2'
                                         }
```

---

## 49.3 Why Bicep Is Nicer

```
✅ ~70% less code than equivalent ARM JSON
✅ No curly-brace/quotation-mark noise everywhere
✅ Type safety + IntelliSense in VS Code (catches errors before deploy)
✅ Native MODULES (reusable, composable — no clunky nested-template linking)
✅ No separate state file to manage (unlike Terraform — Azure tracks state)
✅ Day-one support for new Azure features (it's Microsoft's own tool)
✅ "what-if" preview before deploying (like a diff)
```

---

## 49.4 Bicep Modules (Reusability)

```bicep
// modules/storage.bicep (reusable module)
param storageName string
resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageName
  location: resourceGroup().location
  sku: { name: 'Standard_LRS' }
  kind: 'StorageV2'
}

// main.bicep (uses the module)
module storage 'modules/storage.bicep' = {
  name: 'storageDeploy'
  params: { storageName: 'myapp storage' }
}
```

Modules let you build reusable, composable infrastructure — a "network module," a "storage module" — used consistently across projects.

---

## 49.5 Steps — Deploying Bicep & Previewing Changes

```
── Preview changes first (what-if — always do this!) ──
az deployment group what-if \
  --resource-group my-rg \
  --template-file main.bicep \
  --parameters storageName=mystorageacct123
   → shows a diff: what will be created / modified / deleted

── Deploy ──
az deployment group create \
  --resource-group my-rg \
  --template-file main.bicep \
  --parameters storageName=mystorageacct123

── In a pipeline (YAML) ──
- task: AzureCLI@2
  inputs:
    azureSubscription: 'my-service-connection'
    scriptType: 'bash'
    inlineScript: |
      az deployment group create --resource-group my-rg \
        --template-file main.bicep
```

---

## 49.6 Real-World Example

```
An Azure-only team wants clean, version-controlled, reusable IaC:

Step 1: Write Bicep modules — modules/network.bicep, modules/storage.bicep,
        modules/aks.bicep — each a reusable building block.
Step 2: main.bicep composes these modules to define a full environment.
Step 3: In their Azure Pipeline, a stage runs "az deployment group
        what-if" so reviewers see exactly what will change (shown in the
        PR/pipeline), then "az deployment group create" applies it after
        approval.
Step 4: To spin up an identical Staging environment, they deploy the
        same Bicep with different parameters.

Result: Clean, readable, reusable, version-controlled Azure infrastructure
with day-one support for new Azure features — all with no separate state
file to manage (Azure tracks the deployment state itself).
```

---

## 49.7 Interview Q&A

**Q: What is Bicep and how does it relate to ARM Templates?**
> Bicep is a modern, concise domain-specific language for Azure IaC that compiles down to the exact same ARM Template JSON. It's not a different engine — it's a far more readable way to author the same ARM deployments, with ~70% less code, type safety, IntelliSense, native modules, and no separate state file (Azure tracks state itself).

**Q: Bicep vs Terraform — when would you use each?**
> Use Bicep for Azure-only projects wanting the cleanest native experience and day-one support for new Azure features, with no state file to manage. Use Terraform when you need to manage multiple clouds (Azure + AWS) with one consistent tool/language — which is common, and relevant to this JD spanning both clouds. (Terraform is covered in the next sections.)

**Q: How do you preview Bicep changes before applying them?**
> With `az deployment group what-if`, which shows a diff of exactly what resources will be created, modified, or deleted — letting you catch mistakes before anything actually changes.

---

## 49.8 Summary

Bicep is a modern, concise language for Azure Infrastructure as Code that compiles to the same ARM Templates — giving the native Azure engine with ~70% less code, type safety, IntelliSense, reusable modules, no separate state file, and day-one support for new Azure features. Use `what-if` to preview changes before deploying. Choose Bicep for Azure-only projects wanting the cleanest native authoring; choose Terraform (next sections) when spanning multiple clouds like this JD's Azure + AWS scope.

---

---
---

# 50. 🏗️ Terraform + Azure DevOps
> 🔴 FULL

---

## 50.1 What Problem Does This Solve?

Terraform is likely your primary IaC skill, and the JD lists it alongside Azure. The key thing to master for this interview isn't Terraform basics (you know those) — it's **how Terraform authenticates to and deploys into Azure**, and **how it runs inside an Azure DevOps pipeline**. This is one of the "integration flows" your checklist highlights.

> 💡 **If you know AWS:** You've used Terraform with the `aws` provider. Azure uses the `azurerm` provider — same Terraform workflow (init/plan/apply), same HCL language, just a different provider and a different authentication mechanism (Service Principal/WIF instead of AWS keys).

---

## 50.2 How Terraform Authenticates to Azure (Flow Diagram)

```
   Terraform (running locally, or in an Azure Pipeline)
        ↓ uses the azurerm PROVIDER
   Authenticates to Azure via ONE of:
        • Azure CLI login (local dev)
        • Service Principal + secret (older CI/CD)
        • Workload Identity Federation / OIDC (modern CI/CD — best)
        • Managed Identity (self-hosted agent on an Azure VM)
        ↓
   Entra ID verifies the identity
        ↓
   RBAC checks what it's allowed to create/modify
        ↓
   Terraform creates/updates Azure resources (VNet, AKS, Storage, etc.)

Notice: this is the SAME identity → Entra ID → RBAC pattern as
everything else in Azure (Sections 5-7, 39). Terraform just plugs
into it via the azurerm provider.
```

---

## 50.3 A Basic Terraform Config for Azure

```hcl
# providers.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
provider "azurerm" {
  features {}
}

# main.tf
resource "azurerm_resource_group" "rg" {
  name     = "terraform-rg"
  location = "Central India"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "tf-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location   # references, not hardcoded
  resource_group_name = azurerm_resource_group.rg.name
}
```

Notice resources reference each other (`azurerm_resource_group.rg.name`), so Terraform automatically understands dependencies and creates things in the right order.

---

## 50.4 The Core Terraform Workflow

```
terraform init      → downloads the azurerm provider, sets up the backend
terraform plan      → PREVIEWS what will change (create/modify/destroy)
terraform apply     → actually makes the changes (asks for confirmation)
terraform destroy   → tears down everything Terraform manages
```

The `plan` step is critical — it's your safety preview before touching real infrastructure.

---

## 50.5 Running Terraform in an Azure Pipeline (Flow Diagram)

```
Git (Terraform .tf files)
   ↓ push / PR
Azure Pipeline
   ↓ Stage 1: terraform init  (connects to remote state — Section 51)
   ↓ Stage 2: terraform plan   (output shown in the PR for review)
   ↓ ── APPROVAL GATE ──  (a human reviews the plan — Section 53)
   ↓ Stage 3: terraform apply  (applies the reviewed plan)
   ↓
Azure resources created/updated

Authentication: the pipeline's Service Connection (Section 39),
ideally via Workload Identity Federation, provides the identity
Terraform uses to authenticate to Azure.
```

---

## 50.6 Steps — Setting Up Terraform in Azure DevOps

```
📍 Two common approaches:

── Using the Terraform extension tasks ──
📍 Install the "Terraform" extension from the Azure DevOps Marketplace
   (Organization settings → Extensions).
📍 In your pipeline YAML, use TerraformTaskV4 tasks for init/plan/apply,
   pointing at your Service Connection (Section 39) for Azure auth.

── Using plain Azure CLI + terraform commands ──
- task: AzureCLI@2
  inputs:
    azureSubscription: 'my-service-connection'   # provides Azure auth
    scriptType: 'bash'
    inlineScript: |
      terraform init
      terraform plan -out=tfplan
      # (approval gate between plan and apply — Section 53)
      terraform apply tfplan

📍 RESULT: Terraform runs inside the pipeline, authenticating to Azure
   via the Service Connection, with plan output reviewable before apply.
```

---

## 50.7 Real-World Example

```
A team manages Azure infra with Terraform via Azure DevOps:

Step 1: Terraform .tf files live in Git (version-controlled).
Step 2: A Service Connection using Workload Identity Federation gives
        the pipeline a secretless identity, scoped (least privilege) to
        the resource groups Terraform manages.
Step 3: On a PR, the pipeline runs "terraform plan" — the plan output is
        posted so reviewers see EXACTLY what infrastructure will change
        before approving the PR.
Step 4: After merge + a manual approval gate, the pipeline runs
        "terraform apply" to make the changes.

Result: Infrastructure changes are as safe, reviewed, and auditable as
application code — no more "someone clicked something in the Portal."
```

---

## 50.8 Interview Q&A

**Q: How does Terraform authenticate to Azure?**
> Via the azurerm provider, using an Azure identity — Azure CLI login for local dev, or in CI/CD a Service Principal (with secret), Workload Identity Federation/OIDC (best, secretless), or a Managed Identity (on a self-hosted agent on an Azure VM). That identity is verified by Entra ID and its RBAC roles determine what Terraform can create — the same identity→Entra ID→RBAC pattern used everywhere in Azure.

**Q: How do you run Terraform in an Azure Pipeline?**
> The pipeline uses a Service Connection (ideally Workload Identity Federation) for Azure authentication, then runs terraform init → plan → apply, typically with the plan output reviewed and a manual approval gate before apply. You can use the Terraform Marketplace extension tasks or plain terraform commands within an AzureCLI task.

**Q: What's different about using Terraform with Azure vs AWS?**
> The workflow (init/plan/apply) and HCL language are identical. The differences are the provider (`azurerm` vs `aws`) and the authentication mechanism (Azure uses Service Principal/WIF/Managed Identity verified by Entra ID + RBAC, versus AWS access keys or IAM roles/OIDC).

---

## 50.9 Summary

The interview value of Terraform + Azure is understanding the integration: Terraform uses the `azurerm` provider and authenticates via an Azure identity (Service Principal, or ideally Workload Identity Federation for secretless CI/CD) that Entra ID verifies and RBAC scopes — the same identity→Entra ID→RBAC pattern as everything else. In a pipeline, it runs init → plan (reviewed) → apply (after approval), with the Service Connection providing Azure auth. The Terraform workflow itself is identical to AWS; only the provider and auth mechanism differ.

---
---

# 51. 🔐 Terraform State Locking & Remote Backend
> 🔴 FULL

---

## 51.1 What Problem Does This Solve?

Terraform keeps a **state file** that records what it has created and the current configuration — it's Terraform's "memory." Two critical problems arise on a team: (1) if the state file lives on one person's laptop, nobody else can collaborate; and (2) if two people run `terraform apply` at the same time, they can corrupt the state or conflict. A **remote backend** with **state locking** solves both — and it's a very common interview question.

> 💡 **If you know AWS:** In AWS you'd use an S3 backend + DynamoDB table for state + locking. In Azure, the equivalent is an **Azure Storage Account** as the backend (with built-in blob leasing for locking) — same concept, Azure services.

---

## 51.2 What the State File Is (Flow Diagram)

```
terraform apply
       ↓
Terraform creates resources in Azure
       ↓
Terraform records what it created + their config in the STATE FILE
   (terraform.tfstate)
       ↓
On the NEXT plan/apply, Terraform compares:
   [desired state in .tf files]  vs  [current state in tfstate]  vs  [real Azure]
       ↓
   ...and figures out exactly what needs to change.

⚠️ The state file is Terraform's source of truth. If it's lost, or
   out of sync with reality, Terraform gets confused.
```

---

## 51.3 Local State (Bad for Teams) vs Remote Backend (Good)

```
❌ LOCAL state (terraform.tfstate on your laptop):
   • Only YOU have it — teammates can't collaborate
   • No locking — two people applying at once corrupts it
   • If your laptop dies, the state is lost
   → Fine for solo learning ONLY

✅ REMOTE BACKEND (state stored in an Azure Storage Account):
   • The whole team shares one central state file
   • State LOCKING: while one person runs apply, others are blocked
     from applying simultaneously (via blob lease)
   • Durable & backed up (Storage redundancy)
   → Required for any real team project
```

---

## 51.4 Configuring an Azure Storage Backend

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstatestorage001"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"   # the state file's name
  }
}
```

With this, Terraform stores its state in the Azure Storage Account (not locally), and Azure Blob's leasing mechanism provides automatic state locking.

---

## 51.5 State Locking in Action (Flow Diagram)

```
Engineer A runs "terraform apply"
       ↓
Terraform acquires a LOCK on the state file (via blob lease)
       ↓
Engineer B tries "terraform apply" at the same time
       ↓
   ❌ BLOCKED: "Error acquiring the state lock — held by Engineer A"
       ↓
Engineer A's apply finishes → lock released
       ↓
Engineer B can now apply safely

Result: no two applies ever corrupt the state by running simultaneously.
```

---

## 51.6 Steps — Setting Up the Remote Backend

```
📍 First, create the backend storage (one-time, often done manually or
   with a small separate Terraform config / CLI):

az group create --name terraform-state-rg --location centralindia
az storage account create --name tfstatestorage001 \
  --resource-group terraform-state-rg --sku Standard_LRS
az storage container create --name tfstate \
  --account-name tfstatestorage001

📍 Then add the backend "azurerm" block (shown above) to your Terraform
   config and run:

terraform init
   → Terraform connects to the Azure Storage backend; if you had local
     state, it offers to migrate it to the remote backend.

📍 RESULT: State now lives centrally in Azure Storage, shared by the
   team, with automatic locking preventing concurrent-apply corruption.
```

---

## 51.7 Real-World Example

```
A team of 5 DevOps engineers manages shared Azure infrastructure:

Problem (before): the state file was on one engineer's machine — nobody
else could run Terraform, and when they tried sharing it via Git, they
kept overwriting each other's state and corrupting it.

Solution:
Step 1: Create a dedicated Storage Account for Terraform state.
Step 2: Configure the azurerm backend in their Terraform config.
Step 3: Run terraform init to migrate to the remote backend.

Now:
- All 5 engineers share one central, durable state file.
- If two try to apply at once, the second is automatically blocked by
  state locking until the first finishes — no corruption.
- The state is backed up via the Storage Account's redundancy.
- Their Azure Pipeline also uses this same remote backend, so pipeline
  runs and local runs share consistent state.
```

⚠️ **Golden rule (interview-worthy):** Once a resource is managed by Terraform, make ALL changes through Terraform — never manually edit it in the Portal, or the state file will drift out of sync with reality, causing confusing errors.

---

## 51.8 Interview Q&A

**Q: What is the Terraform state file and why does it matter?**
> It's Terraform's record of what it has created and their current configuration — its source of truth. On each plan/apply, Terraform compares the desired config, the state file, and real infrastructure to determine what to change. If the state is lost or drifts out of sync with reality, Terraform gets confused, so it must be stored safely.

**Q: Why do you need a remote backend, and how do you set one up in Azure?**
> Because a local state file can't be shared across a team and offers no protection against concurrent applies. In Azure, you use an Azure Storage Account as the remote backend (configured with a `backend "azurerm"` block) — it centralizes the state for the whole team and provides state locking (via blob leasing) so two applies can't run simultaneously and corrupt it.

**Q: What is state locking and why is it important?**
> When someone runs terraform apply, Terraform locks the state file so no one else can apply at the same time — preventing two simultaneous changes from corrupting the state. In Azure's Storage backend, this is done automatically via blob leasing.

**Q: What's the golden rule about Terraform-managed resources?**
> Never manually modify them in the Portal. Once Terraform manages a resource, all changes should go through Terraform — otherwise the state file drifts out of sync with reality, causing errors and unexpected behavior on the next plan/apply.

---

## 51.9 Summary

Terraform's state file is its memory of what it manages — critical to keep safe and in sync. For any team, store it in a **remote backend** (an Azure Storage Account via the `backend "azurerm"` block) rather than locally, which enables team collaboration and provides **state locking** (via blob leasing) so simultaneous applies can't corrupt it. This is Azure's equivalent of the AWS S3 + DynamoDB backend pattern. And remember the golden rule: once Terraform manages a resource, only change it through Terraform, never manually in the Portal.

---
---

# 52. 📦 Terraform Modules & Reusability
> 🟠 MEDIUM

---

## 52.1 What Problem Does This Solve?

As infrastructure grows, you end up needing the same patterns repeatedly — a standard VNet setup, a standard AKS cluster, a standard storage configuration. Copy-pasting Terraform code for each is error-prone and inconsistent. **Modules** let you package reusable infrastructure into building blocks you can use across many projects and environments.

> 💡 **If you know AWS:** Terraform modules work identically with the `aws` provider — this is a Terraform concept, not Azure-specific. If you've used modules for AWS, it's the same for Azure's `azurerm` resources.

---

## 52.2 What a Module Is (Flow Diagram)

```
A MODULE = a reusable package of Terraform resources with inputs & outputs

┌────────────────────────────────────────────────┐
│  Module: "network"                                │
│    Inputs (variables): vnet_name, address_space   │
│    Creates: VNet + subnets + NSGs                 │
│    Outputs: subnet IDs, vnet ID                   │
└────────────────────────────────────────────────┘
         ↑ reused by ↑          ↑ reused by ↑
   Dev environment          Prod environment
   (different inputs)       (different inputs)

Write the network setup ONCE as a module, use it everywhere with
different parameters — consistent, DRY, maintainable.
```

---

## 52.3 Module Structure

```hcl
# modules/network/main.tf  (the reusable module)
variable "vnet_name" {}
variable "address_space" {}

resource "azurerm_virtual_network" "vnet" {
  name          = var.vnet_name
  address_space = [var.address_space]
  # ...
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
```

```hcl
# main.tf  (using the module)
module "dev_network" {
  source        = "./modules/network"
  vnet_name     = "dev-vnet"
  address_space = "10.0.0.0/16"
}

module "prod_network" {
  source        = "./modules/network"   # SAME module, different inputs
  vnet_name     = "prod-vnet"
  address_space = "10.1.0.0/16"
}
```

---

## 52.4 Module Sources

| Source | Example |
|---|---|
| **Local path** | `source = "./modules/network"` |
| **Terraform Registry** | `source = "Azure/vnet/azurerm"` (public, community/verified modules) |
| **Git repository** | `source = "git::https://github.com/org/modules.git//network"` |

Many organizations keep a private Git repo of their standard, approved modules that all teams reference.

---

## 52.5 Steps — Creating & Using a Module

```
📍 This is done in Terraform code (HCL), not the Azure Portal.

Step 1: Create a folder: modules/network/ with main.tf, variables.tf,
        outputs.tf defining the reusable resources.
Step 2: Reference it from your root config with a "module" block,
        passing in the parameters (shown above).
Step 3: Run:
        terraform init    → initializes the module
        terraform plan    → preview
        terraform apply    → creates resources from the module

📍 RESULT: The same infrastructure pattern, deployed consistently
   wherever the module is used — update the module once, and all users
   benefit.
```

---

## 52.6 Real-World Example

```
An organization standardizes infrastructure with a private module library:

They maintain a Git repo of approved modules:
   modules/network  → standard VNet + subnets + NSGs (secure by default)
   modules/aks      → standard AKS cluster (right networking, monitoring)
   modules/storage  → standard Storage Account (encryption, private endpoint)

Every team's Terraform references these modules instead of writing
resources from scratch:
   module "network" {
     source = "git::https://github.com/org/tf-modules.git//network?ref=v1.2"
     ...
   }

Benefits:
- Consistency: every team's network is set up the same secure way
- Maintainability: to improve the standard (e.g., add a security rule),
  update the module once and bump the version — all teams adopt it
- Speed: teams compose environments from proven building blocks instead
  of reinventing them
```

---

## 52.7 Interview Q&A

**Q: What are Terraform modules and why use them?**
> Modules are reusable packages of Terraform resources with defined inputs (variables) and outputs. You use them to avoid copy-pasting infrastructure code — write a pattern once (like a standard VNet or AKS setup) and reuse it across environments and projects with different parameters, ensuring consistency and making it maintainable (update the module once, all users benefit).

**Q: How do organizations manage shared modules?**
> Commonly by keeping a private Git repository (or private registry) of standard, approved, versioned modules that all teams reference by source URL and version. This enforces consistent, secure-by-default infrastructure patterns across the organization, and lets the platform team improve standards centrally.

---

## 52.8 Summary

Terraform modules package reusable infrastructure (with inputs and outputs) into building blocks used across environments and projects — eliminating copy-paste, ensuring consistency, and improving maintainability (update once, all users benefit). Organizations typically maintain a private, versioned library of standard modules (VNet, AKS, storage) that all teams reference, enforcing secure-by-default patterns centrally. Modules are a core Terraform concept that works identically for Azure and AWS.

---
---

# 53. 🚦 IaC in CI/CD with Plan Approval Gates
> 🟠 MEDIUM

---

## 53.1 What Problem Does This Solve?

Running Terraform (or Bicep) manually from a laptop is risky and unauditable — someone could apply an untested change directly to production. The professional practice is to run IaC *through a CI/CD pipeline* with a **plan-review-then-apply** flow, so every infrastructure change is reviewed and approved before it touches real resources. This ties together IaC (Sections 48-52) with pipelines (Sections 40-46).

> 💡 **If you know AWS:** Same pattern as running Terraform through CodePipeline (or GitHub Actions) with a manual approval action between `plan` and `apply` — the concept is cloud-agnostic.

---

## 53.2 The Plan → Approve → Apply Flow (Flow Diagram)

```
Developer changes .tf (or .bicep) files → opens a PR
       ↓
Azure Pipeline runs automatically:
   ┌────────────────────────────────────────────────┐
   │  Stage 1: terraform plan / az deployment what-if │
   │    → produces a DIFF: what will be created,       │
   │      modified, or destroyed                       │
   │    → the plan output is shown IN THE PR so         │
   │      reviewers see exactly what will change        │
   └────────────────────┬───────────────────────────┘
                        ↓
   ── PR review + APPROVAL GATE (Section 46) ──
   A human reviews the plan and approves
                        ↓
   ┌────────────────────────────────────────────────┐
   │  Stage 2: terraform apply / az deployment create │
   │    → applies EXACTLY the reviewed plan            │
   └────────────────────────────────────────────────┘
       ↓
   Azure infrastructure updated — reviewed, approved, auditable
```

**The key safety principle:** never `apply` something that wasn't reviewed as a `plan` first. The approval gate sits between plan and apply.

---

## 53.3 Why This Matters (Especially for Production Infra)

```
❌ WITHOUT this: an engineer runs "terraform apply" from their laptop
   → could accidentally destroy a production database, with no review,
     no approval, and no audit trail of who did what

✅ WITH this: the change goes through a PR (peer review of the code),
   the pipeline shows the exact plan (peer review of the effect), a
   designated approver signs off (governance), and only then is it
   applied — with a full audit trail in the pipeline history
```

---

## 53.4 Example Pipeline (Terraform Plan Gate)

```yaml
stages:
- stage: Plan
  jobs:
  - job: TerraformPlan
    steps:
      - task: AzureCLI@2
        inputs:
          azureSubscription: 'infra-service-connection'   # Section 39
          scriptType: 'bash'
          inlineScript: |
            terraform init
            terraform plan -out=tfplan
      - publish: tfplan            # save the plan as an artifact (Section 43)
        artifact: tfplan

- stage: Apply
  dependsOn: Plan
  jobs:
  - deployment: TerraformApply
    environment: 'production-infra'   # ⭐ approval configured here (Section 46)
    strategy:
      runOnce:
        deploy:
          steps:
            - download: current
              artifact: tfplan
            - task: AzureCLI@2
              inputs:
                azureSubscription: 'infra-service-connection'
                scriptType: 'bash'
                inlineScript: |
                  terraform init
                  terraform apply $(Pipeline.Workspace)/tfplan/tfplan
                  # applies the EXACT plan that was reviewed & approved
```

Note: the plan is saved as an artifact and the apply uses that exact saved plan — so what's applied is precisely what was reviewed (no drift between review and apply).

---

## 53.5 Steps — Setting This Up

```
📍 In Azure DevOps (dev.azure.com).

Step 1: Create a Service Connection (Section 39, ideally WIF) scoped to
        the resource groups your IaC manages.
Step 2: Configure a remote backend (Section 51) so pipeline and local
        runs share state.
Step 3: Create an Environment (Section 45) like "production-infra" with
        a required Approval (Section 46).
Step 4: Build the two-stage pipeline: Plan stage (runs terraform plan,
        publishes it), then Apply stage targeting the approval-gated
        Environment (runs terraform apply on the reviewed plan).

📍 RESULT: Every infrastructure change flows through: code review (PR) →
   plan review (in pipeline) → approval gate → apply — fully governed
   and auditable.
```

---

## 53.6 Real-World Example

```
A team enforces governed infrastructure changes:

1. An engineer proposes adding a new subnet + NSG, editing the .tf files
   and opening a PR.
2. The pipeline runs "terraform plan" — the output ("+ 1 subnet, + 1 NSG")
   is posted in the PR. Reviewers confirm it's exactly the intended change
   (and nothing unexpected, like accidentally destroying something).
3. The PR is approved and merged.
4. The Apply stage targets the "production-infra" Environment, which
   requires the platform lead's approval. The lead reviews the saved plan
   and approves.
5. "terraform apply" runs on that exact reviewed plan — the subnet and
   NSG are created.

If the plan had shown something dangerous (e.g., "- 1 database" —
destroying a database), reviewers would catch it BEFORE apply, and reject
the change. This is the safety net that manual laptop-based Terraform lacks.
```

---

## 53.7 Interview Q&A

**Q: How do you run Infrastructure as Code safely in a pipeline?**
> Through a plan → approve → apply flow: the pipeline first runs `terraform plan` (or `az deployment what-if`) to produce a diff of exactly what will change, which is reviewed in the PR; then a manual approval gate (on an Environment) requires a human to sign off; then `terraform apply` runs on that exact reviewed plan. This ensures every infrastructure change is code-reviewed, plan-reviewed, approved, and auditable — never an unreviewed apply from someone's laptop.

**Q: Why save the plan as an artifact and apply that exact plan?**
> So that what gets applied is precisely what was reviewed and approved — there's no risk of drift between the plan that was reviewed and the actual apply (which could otherwise pick up new changes if it re-planned at apply time).

---

## 53.8 Summary

Running IaC through CI/CD with a plan-approval gate is the professional, safe practice: the pipeline runs `terraform plan`/`what-if` to show exactly what will change (reviewed in the PR), a manual approval gate on an Environment requires human sign-off, and only then does `terraform apply` run — ideally on the exact saved plan so what's applied matches what was reviewed. This gives code review + plan review + approval + audit trail for every infrastructure change, versus the risky, unauditable alternative of manual laptop-based applies.

---
---

# 54. 🐳 Dockerfile Best Practices & Multi-Stage Builds
> 🟠 MEDIUM

---

## 54.1 What Problem Does This Solve?

You likely know Docker already — so the interview value here is knowing how to build **efficient, secure, small** container images, and specifically **multi-stage builds** (a very common interview topic). Poorly-written Dockerfiles produce huge, slow, insecure images; good ones are small, fast, and secure. (This is Docker/code, so "steps" are Dockerfile syntax, not Portal clicks.)

> 💡 **If you know AWS:** Dockerfiles are identical everywhere — this is container knowledge, not Azure-specific. The image you build is pushed to ACR (Azure) just as you'd push to ECR (AWS).

---

## 54.2 Multi-Stage Builds (The Key Concept) — Flow Diagram

```
The problem: your build needs build-time tools (compilers, dev
dependencies), but you DON'T want those in the final image (they bloat
it and increase the attack surface).

Multi-stage build solves this:

┌────────────────────────────────────────────────┐
│  STAGE 1: "build"                                 │
│  • Use a full image with all build tools          │
│  • Compile/build the application                  │
│  • Produces build artifacts (e.g., compiled code)  │
└────────────────────┬─────────────────────────────┘
                     ↓ copy ONLY the built artifacts
┌────────────────────────────────────────────────┐
│  STAGE 2: "runtime" (the FINAL image)             │
│  • Use a tiny, minimal base image                 │
│  • Copy in ONLY the artifacts from Stage 1        │
│  • No compilers or build tools included            │
└────────────────────────────────────────────────┘

Result: the final image is small (just runtime + app), secure (no
build tools to exploit), and fast to pull/deploy.
```

---

## 54.3 Multi-Stage Dockerfile Example

```dockerfile
# ---- STAGE 1: Build ----
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install               # includes dev dependencies for building
COPY . .
RUN npm run build             # produces the "dist" folder

# ---- STAGE 2: Runtime (final image) ----
FROM node:18-alpine           # tiny base image
WORKDIR /app
COPY --from=build /app/dist ./dist         # copy ONLY the built output
COPY package*.json ./
RUN npm install --production  # only production dependencies, no dev tools
EXPOSE 3000
CMD ["node", "dist/server.js"]
```

The final image contains only the runtime, production dependencies, and built app — none of the build-time bloat.

---

## 54.4 Key Dockerfile Best Practices

```
✅ Use multi-stage builds → small, secure final images
✅ Use minimal/slim base images (e.g., alpine) → smaller, fewer vulnerabilities
✅ Use a specific image tag (node:18-alpine), NOT "latest" → reproducible builds
✅ Order layers by change frequency: copy package.json & install deps
   BEFORE copying the rest of the code → Docker caches the dependency
   layer, so code changes don't force a full dependency reinstall
✅ Run as a non-root user → security (don't run containers as root)
✅ Use .dockerignore → keep secrets, node_modules, .git out of the image
✅ Minimize layers and installed packages → smaller attack surface
✅ NEVER bake secrets into the image → use runtime injection (Key Vault, env vars)
```

---

## 54.5 Layer Caching (Why Order Matters)

```
Docker builds images in LAYERS and caches them. Order matters:

❌ Inefficient (copy everything first):
   COPY . .
   RUN npm install     ← ANY code change invalidates the cache here,
                         forcing a full re-install every build

✅ Efficient (copy dependency manifest first):
   COPY package*.json ./
   RUN npm install     ← only re-runs if package.json changed
   COPY . .            ← code changes only invalidate from here down

Result: faster builds, because unchanged dependency layers are reused
from cache.
```

---

## 54.6 Steps — Building & Pushing to ACR

```
📍 Done via Docker CLI (+ ACR from Section 55), not the Azure Portal.

# Build the image using your multi-stage Dockerfile
docker build -t myapp:v1 .

# Tag it for your Azure Container Registry
docker tag myapp:v1 myregistry.azurecr.io/myapp:v1

# Log in to ACR (using Azure credentials)
az acr login --name myregistry

# Push it
docker push myregistry.azurecr.io/myapp:v1

📍 In a pipeline, the Docker@2 task does buildAndPush in one step
   (shown in Section 40).
```

---

## 54.7 Real-World Example

```
A team's Node.js image was 1.2 GB, slow to pull, and flagged by security
scanning for vulnerabilities in build tools that shouldn't be in production:

Step 1: Rewrite the Dockerfile as a multi-stage build — Stage 1 uses the
        full node:18 image to build; Stage 2 uses tiny node:18-alpine and
        copies in only the built artifacts + production dependencies.
Step 2: Reorder layers so dependencies install before copying app code
        (better cache use → faster builds).
Step 3: Add a .dockerignore to exclude .git, node_modules, and any local
        secrets.
Step 4: Run as a non-root user.

Result: the final image drops from 1.2 GB to ~150 MB, pulls & deploys
faster, and security scanning (Section 71) finds far fewer vulnerabilities
because build tools are no longer in the production image.
```

---

## 54.8 Interview Q&A

**Q: What is a multi-stage Docker build and why use it?**
> It's a Dockerfile with multiple stages where a "build" stage uses a full image with build tools to compile the app, and a final "runtime" stage uses a minimal base image and copies in only the built artifacts. This produces a small, secure final image without build-time tools/dependencies — smaller to store and pull, and a reduced attack surface.

**Q: Why does the order of instructions in a Dockerfile matter?**
> Because Docker caches image layers. If you copy dependency manifests (like package.json) and install dependencies before copying the rest of your code, the dependency layer is cached and reused unless dependencies actually change — so routine code changes don't trigger a slow full dependency reinstall. Copying everything first would invalidate the cache on every code change.

**Q: Name a few Dockerfile security best practices.**
> Use minimal base images (like alpine) to reduce vulnerabilities, use multi-stage builds to exclude build tools from the final image, run as a non-root user, never bake secrets into the image (inject them at runtime), use a .dockerignore to keep secrets/junk out, and pin specific image tags instead of "latest" for reproducibility.

---

## 54.9 Summary

Efficient, secure Docker images come from multi-stage builds (a build stage with tools, a minimal final runtime stage with only the artifacts), minimal base images, smart layer ordering for caching (dependencies before code), running as non-root, using .dockerignore, pinning specific tags, and never baking in secrets. These practices produce small, fast, secure images — pushed to ACR (next section) and deployed to AKS. Multi-stage builds and layer caching are the two most commonly asked Docker interview topics.

---
---

# 55. 📦 Azure Container Registry (ACR)
> 🔴 FULL

---

## 55.1 What Problem Does This Solve?

Once you build a container image (Section 54), it needs to live somewhere private and secure that your deployment targets (AKS, App Service) can pull from. **Azure Container Registry (ACR)** is Azure's private, managed registry for storing container images — with deep Azure security integration. This is a ⭐ topic given the JD's container focus and the ACR→AKS delivery path.

> 💡 **If you know AWS:** ACR is the direct equivalent of **Amazon ECR** — a private container registry integrated with the cloud's identity system.

---

## 55.2 Where ACR Fits (Flow Diagram)

```
Developer / Pipeline builds an image
       ↓ docker push
┌──────────────────────────────────────┐
│  AZURE CONTAINER REGISTRY (ACR)        │
│  myregistry.azurecr.io                 │
│    • myapp:v1                          │
│    • myapp:v2                          │
│    • catalog-service:v1                │
│  (private, secure image storage)       │
└──────────────────┬─────────────────────┘
                   ↓ docker pull (via Managed Identity, no stored creds)
        AKS / App Service / Container Apps
        (pull the image to run it)
```

---

## 55.3 Why ACR Over a Public Registry (like Docker Hub)?

```
✅ Private — your proprietary app images aren't publicly accessible
✅ Azure identity integration — AKS/App Service pull images via Managed
   Identity + RBAC, no stored registry credentials
✅ Vulnerability scanning — automatically scans images for known CVEs
   (integrates with Microsoft Defender)
✅ Geo-replication — replicate images to multiple regions for fast pulls
   in globally-distributed deployments
✅ Content trust / signing — verify image authenticity
```

---

## 55.4 The Critical Integration: ACR → AKS (Flow Diagram)

This is the ⭐ flow from your checklist — how AKS pulls images securely:

```
AKS needs to pull "myregistry.azurecr.io/myapp:v1" to run a pod
       ↓
AKS uses its MANAGED IDENTITY (attached to the cluster)
       ↓
That identity has the "AcrPull" RBAC role on the ACR
       ↓
AKS pulls the image securely — NO registry username/password stored anywhere

Setup is a SINGLE command:
   az aks update --name myAKS --resource-group myRG --attach-acr myACR
   → this grants the AKS cluster's identity the AcrPull role automatically
```

---

## 55.5 Steps — Creating ACR & Pushing an Image

```
📍 Create ACR in the Portal:
   portal.azure.com → search "Container registries" → "+ Create"
   ┌────────────────────────────────────┐
   │ Registry name: myregistry           │
   │ SKU: Basic / Standard / Premium      │
   │      (Premium adds geo-replication,  │
   │       private endpoints, more)       │
   └────────────────────────────────────┘
   → "Review + create" → "Create"

📍 Push an image (CLI):
   az acr login --name myregistry                      # auth via Azure creds
   docker tag myapp:v1 myregistry.azurecr.io/myapp:v1
   docker push myregistry.azurecr.io/myapp:v1

📍 Connect ACR to AKS (one command):
   az aks update --name myAKS --resource-group myRG --attach-acr myregistry

📍 RESULT: Images are stored privately in ACR, and AKS can pull them
   securely via its Managed Identity with zero stored credentials.
```

---

## 55.6 Real-World Example

```
The multi-service e-commerce app (8 microservices) needs secure,
scanned image storage with automated CI/CD:

Step 1: Create ACR "ecommerceacr" (Premium tier for geo-replication +
        private endpoint + vulnerability scanning).
Step 2: The CI pipeline builds each microservice's image and pushes it
        to ACR, tagged with the build ID (traceable to the exact commit).
Step 3: Enable vulnerability scanning (via Defender) so every pushed
        image is checked for known CVEs, alerting on critical findings.
Step 4: Attach ACR to the AKS cluster (az aks update --attach-acr), so
        AKS pulls images via its Managed Identity — no credentials stored.
Step 5: For global deployments, geo-replicate the registry so each
        region's AKS pulls from a nearby copy (faster).

Result: a secure, scanned, automated image supply chain from "developer
pushes code" to "AKS runs the scanned, versioned image."
```

---

## 55.7 Interview Q&A

**Q: What is ACR and why use it over a public registry?**
> Azure Container Registry is a private, managed container image registry. Over a public registry like Docker Hub, it offers privacy for proprietary images, deep Azure identity integration (AKS/App Service pull via Managed Identity + RBAC with no stored credentials), automatic vulnerability scanning, and geo-replication for fast global pulls.

**Q: How does AKS securely pull images from ACR?**
> Via the AKS cluster's Managed Identity, which is granted the "AcrPull" RBAC role on the registry — set up with a single `az aks update --attach-acr` command. No registry username or password is stored anywhere; it's the standard identity→RBAC pattern.

**Q: What does the Premium ACR tier add?**
> Geo-replication (replicate images across regions for fast local pulls), private endpoints (private-network-only access), higher storage/throughput, and content trust — beyond the Basic/Standard tiers.

---

## 55.8 Summary

Azure Container Registry (ACR) is Azure's private, managed container image registry — the equivalent of AWS ECR. It's preferred over public registries for privacy, deep Azure identity integration (AKS/App Service pull via Managed Identity + RBAC, no stored credentials), automatic vulnerability scanning, and geo-replication. The key flow to know: AKS pulls images securely via its Managed Identity with the AcrPull role, set up with a single `az aks update --attach-acr` command. ACR is the middle link in the container delivery chain: build (Section 54) → ACR → AKS (next section).

---
---

# 56. ☸️ Azure Kubernetes Service (AKS)
> 🔴 FULL

---

## 56.1 What Problem Does This Solve?

Running containers at scale — many copies, auto-restart on failure, rolling updates, service discovery, load balancing — is complex. **Kubernetes** automates all of it, and **AKS** is Azure's managed Kubernetes service that runs the complex control plane for you (for free), so you only manage and pay for the worker nodes. The JD lists Kubernetes as "desirable," so aim for confident conceptual command plus the AKS-specific integrations.

> 💡 **If you know AWS:** AKS is Azure's equivalent of **Amazon EKS**. Key difference: AKS's control plane is **free** — you only pay for worker nodes; EKS charges an hourly control-plane fee on top of node costs.

---

## 56.2 Kubernetes Core Concepts (Quick Refresher)

| Concept | What It Is |
|---|---|
| **Cluster** | The whole Kubernetes environment (control plane + nodes) |
| **Node** | A worker VM that runs your containers |
| **Pod** | Smallest unit — wraps one (or a few tightly-coupled) containers |
| **Deployment** | Manages a set of identical Pod replicas + rolling updates |
| **Service** | Stable network endpoint for a group of Pods |
| **Ingress** | HTTP(S) routing rules into the cluster (Section 57) |
| **Namespace** | Logical isolation within a cluster (e.g., dev/prod) |

```
AKS CLUSTER
├── Control Plane (MANAGED BY AZURE, FREE — the "brain")
│     schedules pods, tracks state, handles the K8s API
│
└── Node Pool (YOU pay for these — worker VMs)
      ├── Node 1: [Pod] [Pod]
      ├── Node 2: [Pod] [Pod]
      └── Node 3: [Pod]
```

---

## 56.3 AKS-Specific Features (What Makes It "Azure" Kubernetes)

| Feature | What It Does |
|---|---|
| **Free managed control plane** | Azure runs/patches the K8s control plane; you only pay for nodes |
| **Node Pools = VM Scale Sets** | Worker nodes are VMSS under the hood → Cluster Autoscaler can add/remove nodes |
| **Managed Identity** | The cluster has an identity for pulling from ACR, etc. |
| **Workload Identity** | Individual pods get a Managed Identity to access Key Vault/Storage (Section 33) |
| **Azure CNI networking** | Pods get IPs directly from your VNet (integrates with NSGs, peering) |
| **ACR integration** | `az aks update --attach-acr` for secure image pulls (Section 55) |
| **Azure Monitor / Container Insights** | Built-in cluster/pod monitoring (Section 66-68) |

---

## 56.4 Steps — Creating an AKS Cluster & Deploying

```
📍 Create AKS in the Portal:
   portal.azure.com → search "Kubernetes services" → "+ Create" →
   "Create a Kubernetes cluster"
   ┌────────────────────────────────────────┐
   │ Cluster name:  my-aks                    │
   │ Region, Resource Group                   │
   │ Node pool: node size + node count (e.g. 3)│
   │ Networking: Azure CNI                    │
   │ Integrations: link ACR, enable Container │
   │               Insights (monitoring)      │
   └────────────────────────────────────────┘
   → "Review + create" → "Create"

📍 Connect kubectl (CLI):
   az aks get-credentials --resource-group myRG --name my-aks
   kubectl get nodes           # verify connection

📍 Deploy an app:
   kubectl apply -f deployment.yaml   # (Deployment + Service YAML)
   kubectl get pods
   kubectl get service                # find the external IP
```

---

## 56.5 Deployment & Service YAML (Basic)

```yaml
# deployment.yaml — run 3 copies of the app
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 3
  selector:
    matchLabels: { app: myapp }
  template:
    metadata:
      labels: { app: myapp }
    spec:
      containers:
      - name: myapp
        image: myregistry.azurecr.io/myapp:v1   # pulled from ACR via Managed Identity
        ports:
        - containerPort: 80
---
# service.yaml — expose it via a load balancer
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  type: LoadBalancer
  selector: { app: myapp }
  ports:
  - port: 80
    targetPort: 80
```

---

## 56.6 Real-World Example

```
Modernizing an app from VMs to containers on AKS:

Step 1: Create an AKS cluster (3-node pool, Azure CNI, Container Insights
        on, ACR attached).
Step 2: Enable the Cluster Autoscaler so the node pool (a VM Scale Set)
        automatically adds nodes under load and removes them when idle —
        controlling cost.
Step 3: Define a Deployment (5 replicas for reliability) pulling the image
        from ACR via the cluster's Managed Identity (no stored creds).
Step 4: Expose it via a Service (LoadBalancer) or Ingress (Section 57).
Step 5: Pods needing secrets use Workload Identity + the Key Vault CSI
        driver (Section 33) — no secrets in the image.

Result: efficient, self-healing, auto-scaling container platform — Azure
manages the control plane for free, and everything authenticates via
managed identities with no stored credentials anywhere.
```

---

## 56.7 Interview Q&A

**Q: What is AKS and how does it differ from running Kubernetes yourself?**
> AKS is Azure's managed Kubernetes service — Azure runs and patches the complex control plane for you (for free), while you manage and pay for only the worker nodes. This removes the hardest operational burden of Kubernetes. It also integrates deeply with Azure — Managed Identity, Workload Identity, ACR, Azure CNI networking, and Azure Monitor.

**Q: How is AKS different from EKS?**
> Conceptually they're both managed Kubernetes. The most cited difference: AKS's control plane is free (you pay only for worker nodes), whereas EKS charges an hourly fee for the control plane in addition to node costs. AKS also integrates natively with Entra ID/Managed Identity and Azure networking.

**Q: What are AKS node pools and how do they relate to autoscaling?**
> Node pools are groups of worker VMs, implemented under the hood as VM Scale Sets. This lets the Cluster Autoscaler automatically add or remove nodes based on whether there's capacity to schedule pending pods — controlling infrastructure cost based on actual workload. (Pod-level scaling via HPA is separate — Section 60.)

---

## 56.8 Summary

AKS is Azure's managed Kubernetes service, running the control plane for free while you manage/pay for worker nodes (implemented as VM Scale Sets, enabling the Cluster Autoscaler). It integrates deeply with Azure: Managed Identity and ACR for secure image pulls, Workload Identity + Key Vault CSI for secretless secret access, Azure CNI for VNet-integrated pod networking, and Container Insights for monitoring. It's the container orchestration foundation — build (54) → ACR (55) → AKS (56) → exposed via Ingress (57) → autoscaled (60). Aim for confident conceptual command plus these Azure-specific integrations.

---
---

# 57. 🚪 AKS Ingress Controllers
> 🟠 MEDIUM

---

## 57.1 What Problem Does This Solve?

A Kubernetes Service of type `LoadBalancer` gives one app a public IP — but if you have 10 microservices, you don't want 10 separate public load balancers (expensive, hard to manage). An **Ingress** provides a single entry point that routes HTTP(S) traffic to different internal services based on the URL path or hostname — and an **Ingress Controller** is the component that actually does this routing.

> 💡 **If you know AWS:** An AKS Ingress is conceptually like using an ALB Ingress Controller on EKS — one smart HTTP entry point routing to many backend services, instead of one load balancer per service.

---

## 57.2 How Ingress Works (Flow Diagram)

```
                    Internet (one domain, one entry point)
                         ↓
              ┌────────────────────────────┐
              │   INGRESS CONTROLLER         │  (e.g., NGINX or App Gateway
              │   (reads Ingress rules,      │   Ingress Controller)
              │    routes by path/host)      │
              └───────────┬──────────────────┘
        Routes based on the URL path:
     ┌───────────────┬───────────────┬────────────────┐
     ↓               ↓                ↓                 ↓
  /api/catalog    /api/orders      /api/payment      /  (default)
  catalog-svc     orders-svc       payment-svc       web-svc
  (internal)      (internal)       (internal)        (internal)

ONE public entry point, ONE domain → routed to MANY internal services.
No need for a separate public load balancer per service.
```

---

## 57.3 Ingress vs Ingress Controller (Common Confusion)

```
INGRESS (the rules):        a Kubernetes resource (YAML) that DEFINES the
                            routing rules ("/api/* → api-service")
INGRESS CONTROLLER (the doer): the actual running software that READS those
                            rules and DOES the routing

You need BOTH: the Ingress resource is just config; the Controller is
what executes it. The Ingress resource does nothing without a Controller
installed in the cluster.
```

---

## 57.4 Common Ingress Controllers on AKS

| Controller | Description |
|---|---|
| **NGINX Ingress Controller** | The community standard — widely used, flexible, works the same as on any Kubernetes |
| **Application Gateway Ingress Controller (AGIC)** | Azure-native — uses Azure Application Gateway (Section 24) as the ingress, giving you Azure's WAF, SSL termination, and native integration |

---

## 57.5 Ingress Resource Example

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ecommerce-ingress
spec:
  rules:
  - http:
      paths:
      - path: /api/catalog
        pathType: Prefix
        backend:
          service:
            name: catalog-service
            port: { number: 80 }
      - path: /api/orders
        pathType: Prefix
        backend:
          service:
            name: orders-service
            port: { number: 80 }
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-service
            port: { number: 80 }
```

---

## 57.6 Steps — Setting Up Ingress on AKS

```
📍 Done via kubectl/Helm + AKS, not the Azure Portal directly.

── Option A: NGINX Ingress Controller (via Helm — Section 59) ──
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx
   → installs the controller (gets a public IP)
Then: kubectl apply -f ingress.yaml   (your routing rules)

── Option B: Application Gateway Ingress Controller (Azure-native) ──
📍 Enable it as an AKS add-on:
   az aks enable-addons --addons ingress-appgw --name myAKS \
     --resource-group myRG --appgw-name myAppGateway --appgw-subnet-cidr "10.2.0.0/16"
   → AKS uses an Azure Application Gateway (with WAF, SSL) as its ingress

📍 RESULT: One public entry point routes traffic to many internal
   services by path/host, per your Ingress rules.
```

---

## 57.7 Real-World Example

```
The 8-microservice e-commerce app on AKS:

Without Ingress: you'd need up to 8 separate public LoadBalancer Services
(8 public IPs, 8 things to manage, expensive).

With Ingress (using Application Gateway Ingress Controller for Azure-native
WAF + SSL):
   ONE public entry point (one domain, one certificate) routes:
     /api/catalog → catalog-service    /api/orders → orders-service
     /api/payment → payment-service    /  → web-service
   ...to the internal ClusterIP services (none of which are directly
   internet-exposed).

Result: one clean domain for customers, WAF protection at the edge (via
AGIC), SSL termination, and only ONE public entry point managing routing
to all 8 services.
```

---

## 57.8 Interview Q&A

**Q: What's the difference between a Kubernetes Service (LoadBalancer) and an Ingress?**
> A LoadBalancer Service gives one service its own public IP/load balancer — fine for one app, but wasteful for many. An Ingress provides a single entry point that routes HTTP(S) traffic to many internal services based on URL path or hostname — so you have one public IP/domain for the whole application instead of one per service.

**Q: What's the difference between an Ingress and an Ingress Controller?**
> The Ingress is the Kubernetes resource (YAML) that defines the routing rules. The Ingress Controller is the actual running software (like NGINX or Application Gateway Ingress Controller) that reads those rules and performs the routing. You need both — the rules do nothing without a controller to execute them.

**Q: What's special about the Application Gateway Ingress Controller on AKS?**
> It uses Azure's native Application Gateway as the ingress, giving you Azure's WAF, SSL termination, and tight Azure integration — rather than the community NGINX controller. It's the Azure-native option for ingress with built-in web application firewall protection.

---

## 57.9 Summary

An Ingress provides a single HTTP(S) entry point that routes traffic to many internal Kubernetes services by URL path or hostname — avoiding a separate public load balancer per service. The Ingress resource defines the rules; the Ingress Controller (NGINX for the community standard, or Application Gateway Ingress Controller for Azure-native WAF/SSL) actually performs the routing. This gives one clean domain and entry point for a multi-service application, with backend services kept internal.

---

---
---

# 58. 💾 AKS Persistent Volumes & Storage
> 🟡 KNOW-THIS-MUCH

---

## 58.1 What Problem Does This Solve?

Containers are **ephemeral** — when a pod is deleted or restarted, anything written inside it is lost. That's fine for stateless apps, but databases and any app that must *keep* data need **persistent storage** that survives pod restarts. Kubernetes solves this with Persistent Volumes, and AKS backs them with Azure storage.

> 💡 **If you know AWS:** This mirrors EKS using EBS/EFS via the CSI driver for Persistent Volumes — same Kubernetes concepts (PV/PVC), just backed by Azure Disks or Azure Files instead.

---

## 58.2 The Core Concepts (Flow Diagram)

```
Pod needs to keep data even if it restarts
       ↓
Pod claims storage via a PERSISTENT VOLUME CLAIM (PVC)
   "I need 10 GB of fast storage"
       ↓
Kubernetes fulfills it with a PERSISTENT VOLUME (PV)
   backed by actual Azure storage:
       ├── Azure Disk  (fast, attached to ONE pod — like a hard drive)
       └── Azure Files (shared, mountable by MANY pods — like a network share)
       ↓
Pod restarts / moves to another node → it re-attaches the SAME
persistent volume → data survives.
```

| Concept | What It Is |
|---|---|
| **Persistent Volume (PV)** | The actual storage resource (backed by Azure Disk or Files) |
| **Persistent Volume Claim (PVC)** | A pod's request for storage ("I need 10 GB") |
| **Storage Class** | Defines *what kind* of storage to provision (e.g., Azure Disk Premium SSD) |

---

## 58.3 Azure Disk vs Azure Files for AKS

| Backing | Attach | Best For |
|---|---|---|
| **Azure Disk** | One pod at a time (ReadWriteOnce) | Databases, single-pod stateful apps needing fast storage |
| **Azure Files** | Many pods simultaneously (ReadWriteMany) | Shared storage multiple pods need to read/write (e.g., shared uploads) |

---

## 58.4 Example PVC (Backed by Azure Disk)

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: data-claim
spec:
  accessModes:
    - ReadWriteOnce            # Azure Disk = one pod at a time
  storageClassName: managed-csi-premium   # Azure Premium SSD Disk
  resources:
    requests:
      storage: 10Gi
```
```yaml
# In a pod/deployment, mount the claim:
    volumeMounts:
    - name: data
      mountPath: /var/data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: data-claim
```

---

## 58.5 Steps — Using Persistent Storage in AKS

```
📍 Done via kubectl, not the Azure Portal (AKS auto-provisions the
   underlying Azure storage via the CSI driver).

Step 1: AKS comes with built-in Storage Classes (managed-csi for Azure
        Disk, azurefile-csi for Azure Files) — check with:
        kubectl get storageclass
Step 2: Create a PVC (kubectl apply -f pvc.yaml) requesting storage.
Step 3: Kubernetes + the Azure CSI driver automatically provision the
        actual Azure Disk/File and bind it to the PVC.
Step 4: Mount the PVC in your pod/deployment.

📍 RESULT: The pod's data now lives on durable Azure storage that
   survives pod restarts and rescheduling.
```

---

## 58.6 Real-World Example

```
A team runs a small database in AKS that must not lose data on restarts:

Step 1: Create a PVC requesting 50 GB of Premium SSD (Azure Disk,
        ReadWriteOnce — a database needs fast, single-attach storage).
Step 2: Mount it into the database pod at its data directory.
Step 3: When Kubernetes restarts or reschedules the pod (e.g., during a
        node update), the pod re-attaches the SAME Azure Disk → the
        database data is fully intact.

Separately, a group of web pods needs SHARED access to uploaded files:
   → they use a PVC backed by Azure Files (ReadWriteMany), so all pods
     mount the same shared storage simultaneously.

(Note: for production databases, many teams prefer a managed Azure
database service over self-hosting in AKS — but persistent volumes make
stateful workloads in AKS possible when needed.)
```

---

## 58.7 Interview Q&A

**Q: How do you persist data in AKS given containers are ephemeral?**
> Using Persistent Volumes. A pod requests storage via a Persistent Volume Claim (PVC), which Kubernetes fulfills with a Persistent Volume backed by Azure storage — Azure Disk (fast, single-pod) or Azure Files (shared across many pods). When the pod restarts or moves, it re-attaches the same volume, so the data survives.

**Q: When would you use Azure Disk vs Azure Files for a Persistent Volume?**
> Azure Disk (ReadWriteOnce — one pod at a time) for fast, single-pod stateful workloads like a database. Azure Files (ReadWriteMany — many pods simultaneously) for shared storage that multiple pods need to read/write at once, like shared uploaded files.

---

## 58.8 Summary

Containers are ephemeral, so stateful AKS workloads use Persistent Volumes: a pod requests storage via a PVC, which Kubernetes provisions (via the Azure CSI driver) as a PV backed by Azure Disk (fast, single-pod) or Azure Files (shared, multi-pod). The data survives pod restarts and rescheduling. Use Azure Disk for databases/single-pod state, Azure Files for shared storage — the same PV/PVC pattern as EKS, backed by Azure storage.

---
---

# 59. ⎈ Helm
> 🟠 MEDIUM

---

## 59.1 What Problem Does This Solve?

Deploying an app to Kubernetes often means applying many YAML files (Deployment, Service, Ingress, ConfigMap, PVC...). Managing all these, keeping them consistent across environments, versioning them, and upgrading/rolling them back is painful with raw `kubectl apply`. **Helm** is the "package manager for Kubernetes" — it bundles all these YAMLs into a single, parameterized, versioned package called a **Chart**.

> 💡 **If you know AWS:** Helm is Kubernetes-native and cloud-agnostic — identical on EKS, AKS, or anywhere. If you've used Helm on EKS, it's the same on AKS. (There's no direct standalone AWS-service equivalent; it's a Kubernetes ecosystem tool.)

---

## 59.2 What Helm Provides (Flow Diagram)

```
Without Helm: you manage many separate YAML files, hand-edited per
environment, applied one by one with kubectl. Messy and error-prone.

With Helm:
   ┌────────────────────────────────────────────────┐
   │  HELM CHART (a package)                           │
   │    templates/  → parameterized K8s YAML           │
   │    values.yaml → default configuration values     │
   │    Chart.yaml  → chart metadata + version         │
   └────────────────────┬─────────────────────────────┘
                        ↓ helm install (with values)
        Kubernetes cluster — all resources deployed together,
        configured for this specific environment

One command deploys the whole app. Different values.yaml per environment
(dev/prod) configure the same chart differently.
```

---

## 59.3 Key Helm Concepts

| Concept | What It Is |
|---|---|
| **Chart** | A Helm package — a bundle of templated Kubernetes YAML + defaults |
| **values.yaml** | Configuration values injected into the templates (differ per environment) |
| **Release** | An installed instance of a chart in a cluster |
| **Repository** | Where charts are stored/shared (public repos, or ACR can host Helm charts) |
| **Templating** | Charts use placeholders (`{{ .Values.replicas }}`) filled in from values.yaml |

---

## 59.4 Why Helm Is So Useful

```
✅ One command deploys a whole multi-resource app (helm install)
✅ Same chart, different values per environment (dev vs prod) — DRY
✅ Versioned releases → easy UPGRADES (helm upgrade) and ROLLBACKS
   (helm rollback — revert to a previous release instantly)
✅ Huge ecosystem of public charts (install NGINX Ingress, Prometheus,
   etc. with one command)
✅ Templating avoids copy-pasting/hand-editing YAML per environment
```

---

## 59.5 Common Helm Commands (Steps)

```
📍 Done via the Helm CLI, not the Azure Portal.

# Add a chart repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# Install a public chart (e.g., NGINX Ingress Controller) in one command
helm install my-ingress ingress-nginx/ingress-nginx

# Install YOUR app's chart with environment-specific values
helm install myapp ./myapp-chart -f values-prod.yaml

# Upgrade to a new version
helm upgrade myapp ./myapp-chart -f values-prod.yaml

# Roll back to the previous release (instant!)
helm rollback myapp

# See release history
helm history myapp
```

---

## 59.6 Real-World Example

```
The 8-microservice e-commerce app is deployed to AKS via Helm:

Structure: a Helm chart bundles all the Deployments, Services, Ingress,
ConfigMaps, and PVCs for the whole application.

Environment configs:
   values-dev.yaml:  replicas: 1, small resources, dev image tags
   values-prod.yaml: replicas: 5, larger resources, prod image tags

Deployment:
   Dev:  helm install ecommerce ./chart -f values-dev.yaml
   Prod: helm install ecommerce ./chart -f values-prod.yaml
   → SAME chart, different values → consistent structure, environment-
     appropriate config.

Upgrade & rollback:
   A new version is released → helm upgrade ecommerce ...
   A problem is found → helm rollback ecommerce → instantly reverts to
   the previous known-good release, no manual YAML fiddling.

In their CI/CD pipeline, the deploy stage runs "helm upgrade" to deploy
the newly-built image's chart to AKS.

Result: the entire multi-service app is packaged, versioned, deployed,
upgraded, and rolled back as one unit — vastly simpler than managing
dozens of raw YAML files per environment.
```

---

## 59.7 Interview Q&A

**Q: What is Helm and why use it?**
> Helm is the package manager for Kubernetes. It bundles all of an application's Kubernetes YAML (Deployments, Services, Ingress, etc.) into a single, parameterized, versioned package called a Chart. This lets you deploy a whole multi-resource app with one command, use the same chart with different values per environment (dev/prod), and easily upgrade and roll back versioned releases — far simpler than managing many raw YAML files.

**Q: How does Helm handle different environments?**
> Through values files. The chart's templates use placeholders filled in from a values.yaml; you provide a different values file per environment (values-dev.yaml, values-prod.yaml) to configure the same chart differently — e.g., 1 replica in dev, 5 in prod — keeping the structure consistent (DRY) while varying the config.

**Q: How do you roll back a Helm deployment?**
> With `helm rollback <release>`, which instantly reverts to a previous release version. Because Helm tracks versioned releases, rollback is a single command — no manual re-applying of old YAML.

---

## 59.8 Summary

Helm is the package manager for Kubernetes — it bundles an app's many Kubernetes YAML files into a single parameterized, versioned Chart, so you deploy the whole app with one command, configure it per-environment via values files (DRY), and easily upgrade (`helm upgrade`) and roll back (`helm rollback`) versioned releases. It's a Kubernetes ecosystem standard (identical on AKS or EKS), and in CI/CD the deploy stage typically runs `helm upgrade` to deploy the newly-built chart. It dramatically simplifies managing complex, multi-resource, multi-environment deployments.

---
---

# 60. 📈 AKS Autoscaling (Cluster Autoscaler + HPA)
> 🟠 MEDIUM

---

## 60.1 What Problem Does This Solve?

Kubernetes workloads need to scale with demand — but at *two* different levels: (1) do you have enough *pods* to handle the traffic? and (2) do you have enough *nodes* (VMs) to run those pods? AKS solves both with two complementary autoscalers: the **Horizontal Pod Autoscaler (HPA)** scales pods, and the **Cluster Autoscaler** scales nodes. Understanding both — and how they work together — is a common interview topic.

> 💡 **If you know AWS:** HPA is identical on EKS (Kubernetes-native). The Cluster Autoscaler is the same concept as on EKS (or Karpenter) — scaling the underlying node count. AKS's nodes being VM Scale Sets is analogous to EKS node groups being ASGs.

---

## 60.2 The Two-Level Scaling (Flow Diagram)

```
Traffic increases → more load on the app
       ↓
LEVEL 1 — HORIZONTAL POD AUTOSCALER (HPA):
   Watches pod metrics (e.g., CPU > 70%)
       ↓
   Adds more POD replicas (3 → 5 → 8 pods)
       ↓
   But wait — are there enough NODES to run all these new pods?
       ↓
LEVEL 2 — CLUSTER AUTOSCALER:
   Notices some pods can't be scheduled (no room on existing nodes)
       ↓
   Adds more NODES (VMs) to the node pool (which is a VM Scale Set)
       ↓
   New pods now have nodes to run on

When traffic drops: HPA removes excess pods → Cluster Autoscaler
removes now-empty nodes → cost goes back down.
```

**Key insight (interview-worthy):** HPA and Cluster Autoscaler work *together* — HPA decides "we need more pods," and Cluster Autoscaler ensures "there are enough nodes for those pods." One scales the app, the other scales the infrastructure.

---

## 60.3 The Two Autoscalers Compared

| | Horizontal Pod Autoscaler (HPA) | Cluster Autoscaler |
|---|---|---|
| **Scales** | Number of pod replicas | Number of nodes (VMs) |
| **Based on** | Pod metrics (CPU, memory, custom) | Whether pods can be scheduled (pending pods) |
| **Analogy** | "Add more workers" | "Add more desks for the workers" |

*(There's also a Vertical Pod Autoscaler that resizes individual pods' resources, but HPA + Cluster Autoscaler are the main duo to know.)*

---

## 60.4 HPA Example

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: myapp-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: myapp
  minReplicas: 3
  maxReplicas: 20
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70   # scale pods to keep avg CPU at 70%
```

---

## 60.5 Steps — Enabling Both Autoscalers

```
── Cluster Autoscaler (scales NODES) — enable on the AKS node pool ──
📍 Portal: AKS cluster → "Node pools" → select the pool → "Scale" →
   enable "Autoscale" → set min & max node count
   OR CLI:
   az aks update --resource-group myRG --name myAKS \
     --enable-cluster-autoscaler --min-count 2 --max-count 10

── Horizontal Pod Autoscaler (scales PODS) — via kubectl ──
📍 kubectl apply -f hpa.yaml   (the HPA YAML above)
   OR quickly:
   kubectl autoscale deployment myapp --cpu-percent=70 --min=3 --max=20

📍 RESULT: Pods scale with CPU (HPA), and nodes scale to fit the pods
   (Cluster Autoscaler) — automatic scaling at both levels.
```

---

## 60.6 Real-World Example

```
A web app on AKS handles daily traffic spikes:

Configuration:
   HPA: keep the "web" Deployment between 3 and 20 pods, targeting 70% CPU
   Cluster Autoscaler: keep the node pool between 2 and 10 nodes

During a traffic spike:
1. CPU rises above 70% → HPA scales pods from 3 → 12.
2. The existing 2 nodes can't fit 12 pods → some pods are "Pending."
3. Cluster Autoscaler notices the pending pods → adds nodes (2 → 5).
4. The pending pods now schedule onto the new nodes. Traffic is handled.

After the spike:
5. CPU drops → HPA scales pods back down (12 → 3).
6. Now nodes are underused → Cluster Autoscaler removes empty nodes
   (5 → 2). Cost returns to baseline.

Result: fully automatic two-level scaling — the app scales (pods) and
the infrastructure scales to match (nodes) — with cost tracking demand.
```

---

## 60.7 Interview Q&A

**Q: What are the two types of autoscaling in AKS and how do they differ?**
> The Horizontal Pod Autoscaler (HPA) scales the number of pod replicas based on pod metrics like CPU; the Cluster Autoscaler scales the number of nodes (VMs) based on whether pods can be scheduled. HPA scales the application; Cluster Autoscaler scales the underlying infrastructure to fit those pods.

**Q: How do HPA and Cluster Autoscaler work together?**
> HPA adds pods when load rises. If the existing nodes can't fit the new pods (they go "Pending"), the Cluster Autoscaler detects the unschedulable pods and adds nodes to accommodate them. When load drops, HPA removes pods, and the Cluster Autoscaler removes the now-empty nodes. Together they provide automatic scaling at both the pod and node levels, with cost tracking actual demand.

**Q: What are AKS node pools implemented as, and why does that matter for autoscaling?**
> Node pools are implemented as VM Scale Sets under the hood, which is what enables the Cluster Autoscaler to add and remove node VMs automatically based on scheduling demand.

---

## 60.8 Summary

AKS autoscaling works at two complementary levels: the Horizontal Pod Autoscaler (HPA) scales pod replicas based on metrics like CPU, while the Cluster Autoscaler scales the number of nodes (VMs, implemented as VM Scale Sets) based on whether pods can be scheduled. They work together — HPA adds pods, Cluster Autoscaler adds nodes to fit them, and both scale back down when demand drops so cost tracks actual usage. Knowing this two-level model (app scaling vs infrastructure scaling) and how they cooperate is a common interview point.

---
---

# 61. 🐙 GitHub → Azure (Actions, OIDC, Branch Policies)
> 🔴 FULL

---

## 61.1 What Problem Does This Solve?

Your JD explicitly lists **GitHub Actions** alongside Azure DevOps. Many organizations use GitHub for source control and GitHub Actions for CI/CD, deploying to Azure. The key things to understand: how GitHub Actions authenticates to Azure (securely, via OIDC — no stored secrets), and how GitHub's branch protection works. This is one of the "integration flows" your checklist highlights.

> 💡 **If you know AWS:** GitHub Actions → Azure via OIDC is the exact same pattern as GitHub Actions → AWS via OIDC (which you may know). The mechanism is identical; only the cloud identity system differs (Entra ID + RBAC vs IAM).

---

## 61.2 GitHub Actions Basics (Flow Diagram)

```
GitHub Actions = GitHub's built-in CI/CD (workflows defined in YAML,
stored in .github/workflows/ in your repo)

Code pushed / PR opened
       ↓
GitHub Actions WORKFLOW triggers (defined in a .yml file)
       ↓
Runs JOBS on GitHub-hosted runners (or self-hosted)
       ↓
Each job has STEPS (run commands, or use prebuilt "Actions")
       ↓
Deploys to Azure (authenticating via OIDC — next)
```

Conceptually similar to Azure Pipelines: workflows → jobs → steps, triggered by events.

---

## 61.3 The Key Topic: GitHub → Azure via OIDC (Secretless — Flow Diagram)

This is the ⭐ integration flow — how GitHub Actions authenticates to Azure with NO stored secret:

```
ONE-TIME SETUP:
   In Entra ID, create an App Registration + a FEDERATED CREDENTIAL
   that TRUSTS GitHub's OIDC issuer, scoped to a specific repo/branch/
   environment. Grant it RBAC on the target Azure resources. (Section 7)

EVERY WORKFLOW RUN:
   GitHub Actions workflow runs
       ↓ GitHub's OIDC provider issues a short-lived token
         ("this is myorg/myrepo, main branch")
       ↓ workflow presents it to Entra ID via the azure/login action
       ↓ Entra ID checks the federated credential trust → matches
       ↓ issues a short-lived Azure token (scoped by RBAC)
       ↓
   Workflow deploys to Azure — NO secret stored in GitHub, ever.
```

**This is the modern best practice** — no long-lived Azure credentials stored in GitHub Secrets.

---

## 61.4 GitHub Actions Workflow Using OIDC to Azure

```yaml
# .github/workflows/deploy.yml
name: Deploy to Azure
on:
  push:
    branches: [ main ]

permissions:
  id-token: write      # ← REQUIRED for OIDC
  contents: read

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: azure/login@v2       # authenticate to Azure via OIDC
        with:
          client-id: ${{ vars.AZURE_CLIENT_ID }}        # NOT a secret
          tenant-id: ${{ vars.AZURE_TENANT_ID }}         # NOT a secret
          subscription-id: ${{ vars.AZURE_SUBSCRIPTION_ID }}  # NOT a secret

      - run: az webapp deploy --name myapp --resource-group prod-rg ...
```

Notice: the client/tenant/subscription IDs are **not secrets** — they're just identifiers. There's no password/secret anywhere because OIDC provides short-lived tokens.

---

## 61.5 GitHub Branch Policies (Branch Protection)

Just like Azure Repos (Section 37), GitHub has **branch protection rules** to enforce quality before merging to protected branches:

```
Branch protection on "main":
   ✅ Require pull request reviews (e.g., 2 approvals)
   ✅ Require status checks to pass (the CI workflow must succeed)
   ✅ Require branches to be up to date before merging
   ✅ Require linear history / signed commits (optional)
   ✅ Restrict who can push
```

Same purpose as Azure Repos branch policies: keep `main` healthy, enforce review + passing CI before merge — supporting trunk-based development.

---

## 61.6 Steps — Setting Up GitHub → Azure OIDC

```
── In Azure (Entra ID) ──
📍 portal.azure.com → Entra ID → App registrations → New registration
   → then "Certificates & secrets" → "Federated credentials" tab →
   "+ Add credential" → scenario "GitHub Actions deploying Azure resources"
   → enter your org, repo, branch (scopes the trust) → Add
📍 Grant the app RBAC: target Resource Group → Access control (IAM) →
   assign it a scoped role (e.g., Contributor on that RG)

── In GitHub ──
📍 Repo → Settings → Secrets and variables → Actions → Variables tab →
   add AZURE_CLIENT_ID, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID
   (as variables, NOT secrets — they're just identifiers)
📍 Add the workflow .yml (above) using azure/login with OIDC

── Branch protection ──
📍 Repo → Settings → Branches → "Add branch protection rule" for "main"
   → require PR reviews + required status checks (your CI workflow)

📍 RESULT: GitHub Actions deploys to Azure with no stored secrets, and
   main is protected by review + passing-CI requirements.
```

---

## 61.7 Real-World Example

```
A team uses GitHub for source control and GitHub Actions for CI/CD to Azure:

Step 1: Set up OIDC federation — an Entra ID App Registration trusting
        GitHub OIDC for "myorg/myrepo" on "main", with Contributor RBAC
        scoped to only the production resource group.
Step 2: The GitHub Actions workflow uses azure/login with OIDC (no
        secret) to authenticate, then deploys the app to Azure.
Step 3: Branch protection on main requires 2 PR approvals + the CI
        workflow passing before any merge.

Security win: even though the CI/CD system is GitHub (external to Azure),
there is NO long-lived Azure credential stored in GitHub — authentication
is via short-lived OIDC tokens, scoped to exactly this repo/branch.
```

---

## 61.8 Interview Q&A

**Q: How does GitHub Actions authenticate to Azure securely?**
> Via OpenID Connect (OIDC) / Workload Identity Federation — you configure a federated credential on an Entra ID app registration that trusts GitHub's OIDC issuer for a specific repo/branch, and grant it scoped RBAC. The GitHub workflow uses the azure/login action to get a short-lived token via that trust — with no long-lived secret stored in GitHub. This is the modern best practice, identical in concept to GitHub Actions → AWS via OIDC.

**Q: Why is OIDC better than storing an Azure service principal secret in GitHub?**
> Because there's no long-lived secret to leak or rotate — OIDC issues short-lived tokens via a trust relationship scoped to a specific repo/branch. Even if someone gained read access to the GitHub repo, there's no credential to steal, and the trust only works from the configured repo/branch.

**Q: How do GitHub branch protection rules relate to Azure Repos branch policies?**
> They're the same concept in a different tool — both enforce quality gates before merging to protected branches (required PR reviews, required passing CI status checks). Both support trunk-based development by keeping main always healthy and reviewed.

---

## 61.9 Summary

GitHub Actions is GitHub's built-in CI/CD (workflows → jobs → steps), and the key integration to know is authenticating to Azure via **OIDC/Workload Identity Federation** — a federated credential in Entra ID trusts GitHub's OIDC issuer for a specific repo/branch, so the `azure/login` action gets short-lived tokens with no stored secret (identical to the GitHub→AWS OIDC pattern). GitHub branch protection rules mirror Azure Repos branch policies (required reviews + passing CI). This is a ⭐ integration flow and a likely interview topic given the JD's GitHub Actions requirement.

---
---

# 62. 🔧 Jenkins → Azure
> 🟠 MEDIUM

---

## 62.1 What Problem Does This Solve?

Your JD lists **Jenkins** as a CI/CD tool. You likely already know Jenkins itself — so the interview value is specifically *how Jenkins authenticates to and deploys into Azure*. Many organizations have existing Jenkins pipelines and need them to deploy to Azure resources (ACR, AKS, VMs, App Service).

> 💡 **If you know AWS:** Just as Jenkins deploys to AWS using an IAM user's credentials or an assumed role, Jenkins deploys to Azure using a Service Principal (or Managed Identity if Jenkins runs on an Azure VM). Same "Jenkins needs cloud credentials" concept, Azure identity system.

---

## 62.2 How Jenkins Authenticates to Azure (Flow Diagram)

```
   Jenkins (running on a VM, on-prem, or in a container)
        ↓ needs to deploy to Azure
   Authenticates using an Azure identity:
        • Service Principal + secret (most common for external Jenkins)
        • Managed Identity (if Jenkins runs on an Azure VM — no secret!)
        ↓ credentials stored securely in Jenkins' Credentials Store
          (NEVER hardcoded in the Jenkinsfile)
        ↓
   Entra ID verifies the identity
        ↓
   RBAC checks what it's allowed to do (scoped narrowly)
        ↓
   Jenkins deploys to Azure: ACR / AKS / VMs / App Service

Same identity → Entra ID → RBAC pattern as everything else in Azure.
```

---

## 62.3 The Secure Setup

```
✅ Create a Service Principal (Section 5) scoped (least privilege) to
   ONLY the resource groups Jenkins deploys to
✅ Store its credentials in Jenkins' built-in Credentials Store (encrypted)
   — reference them in the Jenkinsfile by credential ID, never paste the
   actual secret in the Jenkinsfile
✅ Rotate the Service Principal secret before it expires — OR, if Jenkins
   runs on an Azure VM, use a Managed Identity to avoid a secret entirely
✅ Use the Azure CLI (az login --service-principal) or Azure Jenkins
   plugins to authenticate within the pipeline
```

---

## 62.4 Jenkinsfile Example (Deploying to Azure)

```groovy
pipeline {
  agent any
  environment {
    // Reference credentials stored in Jenkins (NOT hardcoded)
    AZURE_CREDS = credentials('azure-service-principal')
  }
  stages {
    stage('Login to Azure') {
      steps {
        sh '''
          az login --service-principal \
            -u $AZURE_CREDS_CLIENT_ID \
            -p $AZURE_CREDS_CLIENT_SECRET \
            --tenant $AZURE_TENANT_ID
        '''
      }
    }
    stage('Build & Push to ACR') {
      steps {
        sh '''
          az acr login --name myregistry
          docker build -t myregistry.azurecr.io/myapp:${BUILD_NUMBER} .
          docker push myregistry.azurecr.io/myapp:${BUILD_NUMBER}
        '''
      }
    }
    stage('Deploy to AKS') {
      steps {
        sh '''
          az aks get-credentials --resource-group myRG --name myAKS
          kubectl set image deployment/myapp myapp=myregistry.azurecr.io/myapp:${BUILD_NUMBER}
        '''
      }
    }
  }
}
```

The credentials come from Jenkins' secure store (`credentials('azure-service-principal')`), never hardcoded.

---

## 62.5 Steps — Setting Up Jenkins → Azure

```
── In Azure ──
📍 Create a Service Principal scoped to the target resource group (CLI):
   az ad sp create-for-rbac --name jenkins-deployer \
     --role Contributor \
     --scopes /subscriptions/{sub}/resourceGroups/prod-rg
   → note the appId, password, tenant

── In Jenkins ──
📍 Manage Jenkins → Credentials → add the Service Principal's appId/
   password/tenant as secured credentials (e.g., ID "azure-service-principal")
📍 (Optional) Install Azure-related Jenkins plugins (Azure CLI, Azure
   Container Registry, Kubernetes) for smoother integration
📍 In the Jenkinsfile, reference the stored credentials by ID and use
   az login --service-principal to authenticate

📍 RESULT: Jenkins can build, push to ACR, and deploy to AKS/Azure,
   authenticating via the scoped Service Principal — with credentials
   secured in Jenkins, never in the Jenkinsfile.
```

---

## 62.6 Real-World Example

```
A company has existing Jenkins pipelines and is adopting Azure:

Step 1: Create a Service Principal "jenkins-deployer" scoped ONLY to the
        resource groups Jenkins deploys to (least privilege).
Step 2: Store its credentials securely in Jenkins' Credentials Store.
Step 3: Update the Jenkinsfile to: log in to Azure via the Service
        Principal → build the image → push to ACR → deploy to AKS.
Step 4: Set a reminder to rotate the SP secret before expiry (or, since
        their Jenkins runs on an Azure VM, migrate to a Managed Identity
        to eliminate the secret entirely).

Result: existing Jenkins pipelines now deploy to Azure securely, reusing
the team's Jenkins expertise while following Azure's identity/RBAC model.
```

---

## 62.7 Interview Q&A

**Q: How does Jenkins authenticate to and deploy into Azure?**
> Jenkins uses an Azure identity — most commonly a Service Principal (with its credentials stored securely in Jenkins' Credentials Store, never hardcoded in the Jenkinsfile), or a Managed Identity if Jenkins runs on an Azure VM. It authenticates via `az login --service-principal`, and its RBAC roles — scoped narrowly to only the needed resource groups — determine what it can deploy (ACR, AKS, VMs, App Service).

**Q: How do you keep Jenkins→Azure credentials secure?**
> Store the Service Principal credentials in Jenkins' encrypted Credentials Store and reference them by ID in the Jenkinsfile (never paste the secret in code). Scope the Service Principal with least privilege to only the target resource groups. Rotate the secret before expiry — or better, if Jenkins runs on an Azure VM, use a Managed Identity to avoid a stored secret entirely.

---

## 62.8 Summary

Jenkins deploys to Azure by authenticating with an Azure identity — typically a Service Principal (credentials secured in Jenkins' Credentials Store, referenced by ID, never hardcoded), or a Managed Identity if Jenkins runs on an Azure VM. It follows the same identity → Entra ID → RBAC pattern as everything else, with the Service Principal scoped least-privilege to only the needed resource groups. The Jenkinsfile logs in via `az login --service-principal`, then builds, pushes to ACR, and deploys to AKS/Azure. The interview focus is the authentication mechanism, not Jenkins itself (which you already know).

---
---

# 63. 🔵🟢 Deployment Strategies — Blue/Green
> 🔴 FULL

---

## 63.1 What Problem Does This Solve?

The naive way to deploy a new version — stop the old one, start the new one — causes downtime and offers no easy way back if something's wrong. Your JD explicitly calls out **Blue/Green** and **Canary** deployments. **Blue/Green** eliminates downtime and gives instant rollback by running two complete environments and switching between them.

> 💡 **If you know AWS:** Blue/Green is a cloud-agnostic strategy — the same concept whether implemented via CodeDeploy Blue/Green, ALB target group swaps, or Azure's equivalents. On Azure, App Service Deployment Slots make it especially easy.

---

## 63.2 How Blue/Green Works (Flow Diagram)

```
Two identical production environments: "Blue" (live) and "Green" (idle)

STATE 1:  Blue = LIVE (v1, serving 100% of users)    Green = idle
              ↓
STATE 2:  Deploy v2 to Green (Blue still serves users — ZERO impact)
          Test Green directly (it has its own test URL)
              ↓
STATE 3:  SWITCH all traffic from Blue → Green (instant)
          Green = LIVE (v2)    Blue = idle (kept as rollback target)
              ↓
STATE 4:  Problem found? SWITCH back to Blue instantly → instant rollback
          All good? Blue becomes the idle target for the NEXT release

Key benefits: ZERO downtime (switch is instant), INSTANT rollback
(switch back), and you TEST the new version in a real prod-identical
environment before sending users to it.
```

---

## 63.3 How Blue/Green Is Implemented on Azure

| Platform | Blue/Green Mechanism |
|---|---|
| **App Service** | Deployment Slots — deploy to a "staging" slot, then "swap" it with production (near-instant, instant swap-back for rollback) |
| **AKS** | Two Deployments/Services; switch the Service selector or Ingress to point at the new version |
| **VMs / VMSS** | Two VM Scale Sets behind a load balancer/App Gateway; switch the backend pool to the new set |
| **Azure Container Apps** | Native revision-based traffic switching |

**App Service Deployment Slots** are the classic, easiest Blue/Green implementation on Azure — worth highlighting.

---

## 63.4 App Service Slot Swap (The Easiest Blue/Green) — Flow Diagram

```
App Service with two slots:
   "production" slot (Blue — live)
   "staging" slot    (Green — for the new version)

1. Deploy v2 to the "staging" slot
2. Warm it up & test it via its own URL (myapp-staging.azurewebsites.net)
3. Click "Swap" → Azure swaps the two slots:
      what was "staging" (v2) instantly becomes "production"
      what was "production" (v1) becomes "staging"
4. If v2 has a problem → Swap again → instant rollback to v1

The swap is near-instant and includes a warm-up, so users experience
zero downtime.
```

---

## 63.5 Steps — Blue/Green via App Service Deployment Slots

```
📍 In the Azure Portal:

Step 1: Open your App Service → left menu "Deployment slots" → "+ Add Slot"
        → name it "staging" (this is your Green environment)
    ↓
Step 2: Deploy the NEW version to the "staging" slot (via pipeline or
        manual deploy) — production keeps serving users, unaffected
    ↓
Step 3: Test the staging slot via its URL (myapp-staging.azurewebsites.net)
    ↓
Step 4: When satisfied → on the App Service → "Deployment slots" →
        click "Swap" → source: staging, target: production → "Swap"
        → Azure swaps them (with warm-up) — near-zero downtime
    ↓
Step 5: If a problem appears → click "Swap" again → instant rollback

📍 RESULT: Zero-downtime deployment with instant rollback, using the two
   slots as your Blue and Green environments.
```

---

## 63.6 Real-World Example

```
A web app team wants zero-downtime releases with instant rollback:

Step 1: Their App Service has "production" (Blue) and "staging" (Green) slots.
Step 2: Their pipeline deploys the new version to the "staging" slot.
Step 3: Automated smoke tests run against the staging slot's URL.
Step 4: If tests pass, the pipeline performs a slot swap → the new
        version is instantly live in production, users experience no
        downtime (the swap warms up the new version first).
Step 5: The old version now sits in the staging slot — if a problem is
        discovered post-swap, they swap back instantly to recover.

Result: releases with zero downtime and a one-click (or automated)
instant rollback path — exactly the release reliability the JD wants.
```

---

## 63.7 Interview Q&A

**Q: Explain Blue/Green deployment.**
> You maintain two identical production environments — Blue (currently live) and Green (idle). You deploy the new version to the idle Green environment (with zero impact on live users), test it there, then switch all traffic from Blue to Green instantly. Green becomes live; Blue stays as an instant rollback target. If a problem appears, you switch back to Blue immediately. Benefits: zero downtime and instant rollback.

**Q: How would you implement Blue/Green on Azure App Service?**
> Using Deployment Slots. You have a "production" slot (Blue) and a "staging" slot (Green). You deploy the new version to staging, warm it up and test it via its own URL, then perform a slot "swap" — which near-instantly makes staging the new production (with a warm-up so there's no downtime). If there's a problem, you swap back for an instant rollback.

**Q: What's the main trade-off of Blue/Green?**
> It requires running two full environments during the transition (roughly double the resources for that window), and the switch is all-or-nothing (100% of traffic moves at once). Canary (next section) addresses the all-or-nothing aspect by shifting traffic gradually.

---

## 63.8 Summary

Blue/Green deployment runs two identical environments — Blue (live) and Green (idle) — deploying the new version to the idle one, testing it, then instantly switching all traffic over, with the old environment kept as an instant rollback target. It delivers zero downtime and instant rollback. On Azure, App Service Deployment Slots make this especially easy (deploy to staging slot → swap with production). The trade-off is running two environments and an all-or-nothing switch — which Canary (next) refines by shifting traffic gradually.

---
---

# 64. 🐤 Deployment Strategies — Canary, Rolling & Rollback
> 🔴 FULL

---

## 64.1 What Problem Does This Solve?

Blue/Green (Section 63) switches 100% of traffic at once — if the new version has a subtle problem, all users hit it immediately. **Canary** deployment reduces this risk by shifting a *small* percentage of traffic to the new version first, watching closely, then gradually increasing. **Rolling** deployment updates instances in batches. And **Rollback** is how you recover when something goes wrong. Your JD explicitly lists Canary, Rolling, and Rollback.

> 💡 **If you know AWS:** Canary/Rolling/Rollback are cloud-agnostic strategies — same concepts as CodeDeploy canary/linear/rolling configs, or Kubernetes rolling updates. Azure implements them via App Service traffic routing, Front Door/App Gateway weights, or Kubernetes.

---

## 64.2 Canary Deployment (Flow Diagram)

```
Named after canaries in coal mines (early warning system):

Deploy v2 alongside v1, then shift traffic GRADUALLY:

   v2 traffic: 5%   → monitor error rate & latency for 30 min
                      ↓ healthy?
   v2 traffic: 25%  → monitor
                      ↓ healthy?
   v2 traffic: 50%  → monitor
                      ↓ healthy?
   v2 traffic: 100% → v1 retired

At ANY step, if metrics degrade (errors/latency spike):
   → shift v2 back to 0% instantly → only a small % of users were
     ever affected → investigate & fix

Benefit: limits the "blast radius" — a bad release only impacts a small
fraction of users before it's caught.
```

---

## 64.3 Rolling Deployment (Flow Diagram)

```
Update instances in small BATCHES, not all at once:

10 instances running v1
   ↓
Batch 1 (2 instances): update to v2 → health check → OK → proceed
Batch 2 (2 instances): update to v2 → health check → OK → proceed
... continue until all 10 run v2

At every moment, enough healthy instances (a mix of v1 & v2) serve
traffic → no downtime, no separate second environment needed.

This is Kubernetes' DEFAULT deployment behavior — update a Deployment's
image and it rolls pods gradually automatically.
```

---

## 64.4 Comparing the Strategies

| Strategy | How | Rollback | Best For |
|---|---|---|---|
| **Blue/Green** | Two full environments, instant switch | Instant (switch back) | Zero-downtime, simple rollback |
| **Canary** | Gradual % traffic shift to new version | Instant (% → 0) | Limiting blast radius, high-traffic apps |
| **Rolling** | Update instances batch by batch | Roll back batches / redeploy previous | Default K8s behavior, no extra infra |

---

## 64.5 Rollback — How to Recover

```
Rollback approach depends on the deployment strategy:

Blue/Green:   swap back to the old slot/environment → INSTANT
Canary:       set new-version traffic weight to 0% → INSTANT
Rolling:      redeploy the previous version (rolls back in batches)
Helm:         helm rollback <release> → instant revert to prior release
Feature flags: flip the flag OFF → instant (no redeploy at all — Section 65)

⭐ The best rollback is the fastest one that limits user impact —
   slot swaps, canary-to-0%, and feature-flag-off are all near-instant.
```

---

## 64.6 Canary on Azure — App Service Traffic Routing (Steps)

```
📍 App Service supports percentage-based traffic routing between slots
   (a built-in canary capability):

Step 1: Deploy v2 to the "staging" slot (as in Blue/Green, Section 63).
Step 2: Instead of an immediate full swap, route a SMALL % of production
        traffic to the staging slot:
   Portal: App Service → "Deployment slots" → set "Traffic %" on the
   staging slot to 10 (10% of live traffic now hits v2)
   OR CLI:
   az webapp traffic-routing set --distribution staging=10 \
     --name myapp --resource-group prod-rg
    ↓
Step 3: Monitor v2's error rate/latency (Application Insights, Section 68).
Step 4: Healthy? Gradually increase (10 → 25 → 50 → 100), then swap fully.
        Problem? Set staging=0 instantly → canary aborted, minimal impact.

📍 RESULT: A gradual, monitored, low-risk rollout with instant abort.
```

For **AKS**, canary is typically done with a service mesh or a tool like Flagger/Argo Rollouts that automatically shifts traffic and auto-rolls-back based on metrics.

---

## 64.7 Real-World Example

```
A payment API needs the safest possible rollout given its criticality:

Step 1: Deploy v2 to the staging slot.
Step 2: Route just 5% of payment traffic to v2 (an especially cautious
        canary % given how critical payments are).
Step 3: Monitor v2's payment success rate & latency (Application Insights)
        for several hours.
Step 4: Success rate stays healthy → gradually increase 5% → 25% → 50%
        → 100% over the day, confirming health at each step.
Step 5: If at ANY point payment failures rise on v2 → set v2 traffic to
        0% instantly → only a small % of payments were ever affected →
        investigate before retrying.

Result: a change to the most critical service rolls out with minimal
blast radius and instant abort capability — maximum safety.
```

---

## 64.8 Interview Q&A

**Q: What is a Canary deployment and how does it differ from Blue/Green?**
> Canary shifts a small percentage of traffic to the new version first (e.g., 5%), monitors it, then gradually increases (25% → 50% → 100%) — limiting the blast radius if something's wrong. Blue/Green switches 100% of traffic at once. Canary is gradual and lower-risk-per-user but more complex to monitor; Blue/Green is instant and all-or-nothing.

**Q: What is a Rolling deployment?**
> Updating instances (or pods) in small batches one group at a time, with health checks between batches, so there are always enough healthy instances serving traffic — no downtime and no separate second environment. It's Kubernetes' default deployment behavior.

**Q: How do you roll back a bad deployment?**
> It depends on the strategy: Blue/Green — swap back to the old environment (instant); Canary — set the new version's traffic to 0% (instant); Rolling — redeploy the previous version; Helm — `helm rollback`; feature flags — flip the flag off (instant, no redeploy). The best rollback is the fastest one that minimizes user impact.

---

## 64.9 Summary

Canary deployment shifts a small, increasing percentage of traffic to the new version (5% → 25% → 100%) while monitoring, limiting blast radius and allowing instant abort (traffic → 0%). Rolling deployment updates instances/pods in batches (Kubernetes' default), maintaining availability without a second environment. Rollback recovers from failures — instantly via slot-swap-back, canary-to-0%, `helm rollback`, or feature-flag-off, or by redeploying the previous version. On Azure, App Service traffic routing enables native canary; AKS uses service mesh/Flagger. Together with Blue/Green (Section 63), these are the modern deployment strategies the JD requires.

---
---

# 65. 🚩 Feature Flags & Azure App Configuration
> 🟠 MEDIUM

---

## 65.1 What Problem Does This Solve?

Sometimes you want to deploy code to production but *not* turn the feature on yet — or turn it on gradually, or instantly turn it off if there's a problem, without redeploying. **Feature Flags** enable this by decoupling *deploying* code from *releasing* a feature. **Azure App Configuration** is Azure's managed service for centrally storing and managing these flags (and app settings). This underpins trunk-based development (Section 36).

> 💡 **If you know AWS:** Azure App Configuration's feature flags are comparable to AWS AppConfig feature flags — centralized, dynamic feature toggling separate from your code.

---

## 65.2 Deploy vs Release — The Key Idea (Flow Diagram)

```
Traditional: deploying code = releasing the feature (same moment).
Feature flags SEPARATE these:

   Deploy code (feature is present but flag = OFF)
       ↓ feature is LIVE in production but INVISIBLE to users
   Turn flag ON for internal testers → test in real production
       ↓
   Turn flag ON for 10% of users → monitor
       ↓
   Turn flag ON for 100% → fully released
       ↓
   Problem at any point? → flip flag OFF → INSTANT "rollback"
                            (no redeploy needed — just a config change)
```

```python
# In application code:
if featureManager.isEnabled("new_checkout"):
    return newCheckout()      # runs only when the flag is ON
else:
    return oldCheckout()
```

---

## 65.3 What Azure App Configuration Provides

```
┌──────────────────────────────────────────────────────────┐
│  AZURE APP CONFIGURATION                                  │
│                                                            │
│  • Feature Flags: on/off toggles, with targeting          │
│    (enable for specific users, %, or groups)               │
│  • Centralized App Settings: shared config across apps/    │
│    environments (change once, all apps pick it up)         │
│  • Dynamic: change a flag/setting WITHOUT redeploying —    │
│    the app reads the new value at runtime                  │
│  • Integrates with Key Vault for any secret values          │
└──────────────────────────────────────────────────────────┘
```

The **Feature Manager** is the part specifically for feature flags (this is what the AZ-400 exam and your checklist reference).

---

## 65.4 Steps — Creating a Feature Flag in App Configuration

```
📍 In the Azure Portal:

Step 1: portal.azure.com → search "App Configuration" → "+ Create"
        → name it, choose RG/region → Create
    ↓
Step 2: Open it → left menu "Feature manager" → "+ Create"
   ┌────────────────────────────────────────┐
   │ Feature flag name: new_checkout          │
   │ Enabled: Off (deploy dark, enable later)  │
   │ (optionally add a Feature Filter:         │
   │  targeting % of users, or specific groups)│
   └────────────────────────────────────────┘
   → Apply
    ↓
Step 3: The application (using the Feature Management SDK) reads this
        flag at runtime — connected to App Configuration via a Managed
        Identity (Section 6).
    ↓
Step 4: To release the feature → toggle the flag On (optionally to a %
        first). To roll back → toggle it Off. No redeploy needed.

📍 RESULT: You control feature releases dynamically, separate from code
   deployments, with instant on/off.
```

---

## 65.5 Real-World Example

```
A team practices trunk-based development (Section 36) with feature flags:

Step 1: A developer builds a new checkout flow, merging small commits to
        main behind a feature flag "new_checkout" (created in App
        Configuration, initially OFF).
Step 2: The code is deployed to production repeatedly as they work — but
        it's INVISIBLE to users because the flag is OFF ("deploy dark").
Step 3: When ready, they enable the flag for internal testers only
        (targeting filter), testing in real production.
Step 4: Then enable it for 10% of users, monitoring error rates.
Step 5: Healthy → ramp to 100%. If a problem appears at any point → flip
        the flag OFF instantly (no redeploy) → the old checkout is back.

Result: deployment is decoupled from release; incomplete work ships
safely behind flags; and "rollback" is an instant config change, not a
redeploy — exactly what makes trunk-based development safe.
```

---

## 65.6 Interview Q&A

**Q: What are feature flags and how do they relate to deployment?**
> Feature flags are toggles that turn features on or off at runtime, decoupling deploying code from releasing a feature. You can deploy code to production with a feature turned off ("deploy dark"), then enable it gradually (internal testers → 10% → 100%), and instantly turn it off if there's a problem — without redeploying. This makes trunk-based development safe and turns rollback into an instant config change.

**Q: What is Azure App Configuration?**
> A managed Azure service for centrally storing and managing application settings and feature flags. Its Feature Manager handles feature flags (with targeting for %/users/groups), and it lets apps read config and flags dynamically at runtime without redeploying — change a flag or setting once, and apps pick it up. It integrates with Key Vault for secret values.

**Q: How do feature flags enable safer rollbacks?**
> Because turning a feature off is just flipping a flag (a config change), it's instant and requires no redeployment — unlike rebuilding and redeploying a previous version. If a newly-enabled feature causes problems, you flip its flag off immediately to revert to the prior behavior.

---

## 65.7 Summary

Feature flags decouple deploying code from releasing a feature — you deploy code with a feature off ("dark"), then enable it gradually and instantly disable it if there's a problem, all without redeploying. Azure App Configuration is the managed service for centrally storing feature flags (via Feature Manager, with %/user/group targeting) and app settings, read dynamically at runtime. This underpins trunk-based development (Section 36) and provides instant, redeploy-free rollback — a key modern deployment practice the JD's trunk-based-development requirement depends on.

---

---
---

# 66. 📊 Azure Monitor & Metrics
> 🟠 MEDIUM

---

## 66.1 What Problem Does This Solve?

You can't operate what you can't see. Once your app is running in production, you need visibility into its health — CPU, memory, request rates, errors — and alerts when something goes wrong. **Azure Monitor** is Azure's central observability platform; **Metrics** are the numerical health signals it collects. Your JD emphasizes services being "observable and supportable in production."

> 💡 **If you know AWS:** Azure Monitor is Azure's equivalent of **Amazon CloudWatch**. Metrics ≈ CloudWatch Metrics, Alerts ≈ CloudWatch Alarms. (Logs and Application Insights are separate sub-sections coming next, mirroring CloudWatch Logs and X-Ray.)

---

## 66.2 What Azure Monitor Collects (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  AZURE MONITOR (the umbrella observability platform)      │
│                                                            │
│  METRICS  → numerical values over time (CPU %, req/sec)    │
│             (this section)                                 │
│  LOGS     → detailed text records, queried with KQL        │
│             (Section 67 — Log Analytics)                   │
│  TRACES   → app-level request tracing                      │
│             (Section 68 — Application Insights)            │
│                                                            │
│  → ALERTS fire when a metric/log condition is met          │
│  → DASHBOARDS visualize everything                         │
└──────────────────────────────────────────────────────────┘

Data flows in from every Azure resource (VMs, AKS, App Service,
databases, load balancers) automatically.
```

---

## 66.3 Metrics — The Basics

**Metrics** are numerical values sampled over time. Azure collects many automatically from every resource, with no setup:

| Example Metric | What It Measures |
|---|---|
| `Percentage CPU` | CPU usage of a VM/App Service |
| `Requests` | Request count to a web app/gateway |
| `Response Time` | How long requests take |
| `Failed Requests` | Error count |
| `Available Memory` | Free memory (requires an agent for guest-OS metrics) |

⚠️ **Common gotcha (interview-worthy):** Azure Monitor collects basic host-level metrics (like CPU) automatically, but does NOT collect *guest-OS* metrics like memory usage or disk space from inside a VM by default — you need the **Azure Monitor Agent** installed on the VM for those.

---

## 66.4 Alerts & Action Groups (Flow Diagram)

```
A metric crosses a threshold you defined
       ↓
ALERT RULE fires (e.g., "CPU > 85% for 5 minutes")
       ↓
Triggers an ACTION GROUP — defines WHO/WHAT gets notified:
   • Email / SMS / voice call to on-call engineers
   • Push to Teams / Slack (webhook)
   • Trigger an Azure Function or Logic App (auto-remediation)
   • Create an incident (PagerDuty / ServiceNow)

Result: the team is alerted (or automated action taken) the moment
something goes wrong — proactively, before users complain.
```

---

## 66.5 Steps — Creating a Metric Alert

```
📍 In the Azure Portal:

Step 1: Open the resource to monitor (e.g., a VM or App Service) →
        left menu "Alerts" → "+ Create" → "Alert rule"
    ↓
Step 2: Condition → select a signal (e.g., "Percentage CPU") → set the
        threshold ("Greater than 85%", aggregated over 5 minutes)
    ↓
Step 3: Actions → "+ Create action group" → add notifications
        (email the DevOps team, SMS the on-call engineer, or trigger a
         Logic App)
    ↓
Step 4: Give the alert rule a name & severity → "Create"

📍 RESULT: The moment CPU exceeds 85% for 5 minutes, the action group
   fires — notifying the team (or auto-remediating) proactively.
```

---

## 66.6 Real-World Example

```
A production payment API needs proactive monitoring:

Metric Alerts configured:
   • VM CPU > 80% for 5 min → email + SMS the on-call engineer
   • App Gateway response time > 1 sec → alert (payment SLA breach risk)
   • Healthy backend count < 2 → alert immediately (availability risk)
   • Failed request rate > 2% → page on-call + trigger a Logic App that
     posts details to the incident Teams channel

Action Groups route these by severity: warnings → email; critical →
email + SMS + PagerDuty.

The Azure Monitor Agent is installed on the VMs so memory and disk
metrics are also visible (not just CPU).

Result: the team learns about problems within minutes — often before
customers notice — instead of finding out from support tickets.
```

---

## 66.7 Interview Q&A

**Q: What is Azure Monitor?**
> Azure's central observability platform, collecting Metrics (numerical signals over time), Logs (detailed records, via Log Analytics), and Traces (app-level, via Application Insights) from every Azure resource. It fires Alerts when conditions are met and visualizes data in dashboards — the equivalent of AWS CloudWatch (plus X-Ray for the tracing part).

**Q: What's a common gotcha with VM metrics in Azure Monitor?**
> Azure Monitor collects host-level metrics like CPU automatically, but NOT guest-OS metrics like memory usage or disk space from inside the VM by default. To get those, you must install the Azure Monitor Agent on the VM.

**Q: What's an Action Group?**
> It defines what happens when an alert fires — who/what gets notified or triggered: emails, SMS, voice calls, Teams/Slack webhooks, triggering an Azure Function or Logic App for auto-remediation, or creating an incident in PagerDuty/ServiceNow. Alerts reference an Action Group to route their response.

---

## 66.8 Summary

Azure Monitor is Azure's central observability platform (the CloudWatch equivalent), collecting Metrics (numerical signals), Logs (Section 67), and Traces (Section 68) from every resource. Metrics like CPU are collected automatically, but guest-OS metrics (memory/disk) need the Azure Monitor Agent. Alert Rules fire when metric thresholds are crossed, triggering Action Groups that notify the team or auto-remediate — enabling proactive detection of problems before users are affected, directly supporting the JD's "observable and supportable in production" requirement.

---
---

# 67. 🔎 Log Analytics & KQL Basics
> 🔴 FULL

---

## 67.1 What Problem Does This Solve?

Metrics (Section 66) tell you *that* something is wrong (CPU spiked). **Logs** tell you *why* (a specific error occurred repeatedly at that time). **Log Analytics** is where Azure Monitor stores logs, and **KQL (Kusto Query Language)** is how you query them. Your checklist explicitly flags KQL basics as important — being able to investigate logs is central to the JD's "log and metric-based issue investigation."

> 💡 **If you know AWS:** Log Analytics is Azure's equivalent of **CloudWatch Logs**, and KQL is like CloudWatch Logs Insights query language — but KQL is generally more powerful and expressive.

---

## 67.2 How Logs Flow (Flow Diagram)

```
Logs come from many sources:
   VMs (via Azure Monitor Agent) · App Service · AKS/Containers ·
   Azure Activity Log · Application Insights · NSG Flow Logs · databases
       ↓ all sent to a...
┌──────────────────────────────────────────────────────────┐
│  LOG ANALYTICS WORKSPACE                                  │
│  (central store where logs are ingested & retained)       │
│  Organized into TABLES (e.g., AzureActivity, Perf,         │
│  ContainerLog, AppRequests, AppExceptions)                 │
└──────────────────────┬─────────────────────────────────────┘
                       ↓ you query it with...
                    KQL (Kusto Query Language)
                       ↓
               Answers, visualizations, and log-based alerts
```

---

## 67.3 KQL Basics — The Essential Syntax

KQL reads top-to-bottom, piping (`|`) data through operators. You don't need to be an expert — know the common operators:

| Operator | What It Does | Example |
|---|---|---|
| `where` | Filter rows | `where TimeGenerated > ago(1h)` |
| `summarize` | Aggregate (count, avg, etc.) | `summarize count() by Computer` |
| `project` | Select specific columns | `project TimeGenerated, Message` |
| `order by` | Sort | `order by count_ desc` |
| `take` / `limit` | Return N rows | `take 100` |
| `ago()` | Time relative to now | `ago(24h)` = last 24 hours |

### Example Queries
```kql
// Show CPU usage over the last hour, averaged per machine in 5-min buckets
Perf
| where ObjectName == "Processor" and CounterName == "% Processor Time"
| where TimeGenerated > ago(1h)
| summarize avg(CounterValue) by Computer, bin(TimeGenerated, 5m)

// Find all application errors in the last hour, grouped by type
AppExceptions
| where TimeGenerated > ago(1h)
| summarize count() by type
| order by count_ desc

// Who deleted resources recently? (from the Activity Log)
AzureActivity
| where OperationNameValue contains "delete"
| where TimeGenerated > ago(24h)
| project TimeGenerated, Caller, OperationNameValue, ResourceGroup
```

**The pattern:** start with a table → `where` to filter → `summarize` to aggregate → `order by` to sort. That covers most investigation needs.

---

## 67.4 Log-Based Alerts

Beyond metric alerts (Section 66), you can create alerts based on KQL queries — e.g., "alert if this query finds more than 10 'PaymentFailed' log entries in 5 minutes." This lets you alert on things that only appear in log content, not just numeric metrics.

---

## 67.5 Steps — Querying Logs with KQL

```
📍 In the Azure Portal:

Step 1: Open your Log Analytics Workspace (or any resource →
        "Logs" in its menu) → this opens the KQL query editor
    ↓
Step 2: Pick a table from the left (e.g., AppExceptions, Perf,
        AzureActivity) and write a KQL query:
        AppExceptions
        | where TimeGenerated > ago(1h)
        | summarize count() by type
    ↓
Step 3: Click "Run" → see the results as a table or chart
    ↓
Step 4: (Optional) "+ New alert rule" from a query → turns the KQL into
        a recurring log-based alert

📍 RESULT: You investigate exactly what happened, and can turn any
   query into a proactive alert.
```

---

## 67.6 Real-World Example

```
An engineer gets a metric alert: "error rate spiked at 3:15 PM." Now
they need to find out WHY — this is where logs + KQL come in:

Step 1: Open Log Analytics → query the exceptions table:
        AppExceptions
        | where TimeGenerated between (datetime(3:10) .. datetime(3:20))
        | summarize count() by type, outerMessage
        | order by count_ desc
    ↓
Step 2: The results show a spike of "SqlTimeoutException" — the database
        was timing out.
    ↓
Step 3: Drill deeper with another query joining request logs to see which
        endpoint triggered it → discover a specific slow query.
    ↓
Step 4: Fix the query, and create a LOG-BASED ALERT so next time
        "SqlTimeoutException" count exceeds a threshold, the team is
        paged immediately.

Result: metrics told them SOMETHING was wrong; KQL log queries told them
EXACTLY what and why — turning a vague alert into a precise root cause.
```

---

## 67.7 Interview Q&A

**Q: What's the difference between metrics and logs?**
> Metrics are numerical values over time that tell you *that* something is happening (CPU is at 90%). Logs are detailed text records that tell you *why* (a specific exception occurred repeatedly). You use metrics to detect problems and logs (queried with KQL) to investigate their root cause.

**Q: What is Log Analytics and KQL?**
> Log Analytics is the Azure Monitor component that stores logs from across your environment in a workspace, organized into tables. KQL (Kusto Query Language) is how you query those logs — a pipe-based language where you start with a table and pipe it through operators like `where` (filter), `summarize` (aggregate), and `order by` (sort) to investigate issues.

**Q: Give a basic KQL query to find recent errors.**
> `AppExceptions | where TimeGenerated > ago(1h) | summarize count() by type | order by count_ desc` — this filters to the last hour, counts exceptions grouped by type, and sorts by the most frequent. That start-with-a-table → where → summarize → order by pattern covers most investigation needs.

---

## 67.8 Summary

Log Analytics is where Azure Monitor stores logs (in a workspace, organized into tables), and KQL (Kusto Query Language) is how you query them — a pipe-based language using `where` (filter), `summarize` (aggregate), `order by` (sort), and `ago()` (time). Metrics tell you *that* something's wrong; KQL log queries tell you *why*. You can also turn KQL queries into log-based alerts. Being able to write basic KQL for log investigation is directly relevant to the JD's "log and metric-based issue investigation" and is flagged in your checklist.

---
---

# 68. 🔬 Application Insights & Distributed Tracing
> 🟠 MEDIUM

---

## 68.1 What Problem Does This Solve?

Azure Monitor metrics/logs give infrastructure-level visibility, but you also need to understand your *application's* behavior — which requests are slow, which specific code path failed, and how a single request flows across multiple microservices. **Application Insights** is Azure Monitor's Application Performance Monitoring (APM) component that provides exactly this deep, code-level visibility.

> 💡 **If you know AWS:** Application Insights combines the roles of **AWS X-Ray** (distributed tracing) and CloudWatch application-level insights — deep APM for your actual application code.

---

## 68.2 What Application Insights Provides (Flow Diagram)

```
You add the Application Insights SDK to your app (or enable it
codeless for App Service/AKS)
       ↓
It automatically collects APPLICATION-level telemetry:
   • Request rates, response times, failure rates (per endpoint)
   • Dependency calls (DB queries, external API calls) & their timing
   • Exceptions with full stack traces
   • Custom events/metrics you define
   • Live Metrics — real-time, sub-second telemetry
       ↓
All flows into Azure Monitor / Log Analytics → queryable with KQL,
visualized, and alertable
```

---

## 68.3 Distributed Tracing — The Standout Feature

In a microservices app, a single user request might touch 5 different services. When it's slow or fails, *which* service caused it? **Distributed Tracing** follows a request across all the services it touches, showing the full end-to-end journey and where time was spent.

```
A single "place order" request:

   Web Frontend  →  Order Service  →  Payment Service  →  Inventory Service
      (20ms)          (15ms)            (SLOW: 3200ms!)      (10ms)
                                            ↑
Application Insights' distributed trace shows the ENTIRE journey and
immediately reveals the Payment Service is the bottleneck — without
tracing, you'd only know "the order request was slow" but not WHERE.
```

This is invaluable for diagnosing issues in microservices architectures (like the JD's environment).

---

## 68.4 The Application Map

Application Insights auto-generates an **Application Map** — a visual diagram of all your services and their dependencies, with health/performance overlaid, so you can see at a glance which component is unhealthy or slow and how everything connects.

---

## 68.5 Steps — Enabling Application Insights

```
📍 In the Azure Portal:

── For App Service (codeless — easiest) ──
Step 1: Open your App Service → left menu "Application Insights" →
        "Turn on Application Insights" → create/select a resource → Apply
        → telemetry starts flowing automatically, no code change needed
    ↓
── For custom apps / AKS ──
Step 1: Create an Application Insights resource
        (portal → search "Application Insights" → "+ Create")
Step 2: Add the App Insights SDK to your application and configure it
        with the connection string (stored in Key Vault / App Config)
    ↓
── Viewing insights ──
📍 Open the Application Insights resource:
   • "Application map" → visual service/dependency diagram
   • "Failures" → exceptions & failed requests with stack traces
   • "Performance" → slowest requests & dependencies
   • "Live metrics" → real-time telemetry
   • "Logs" → query the telemetry with KQL (Section 67)

📍 RESULT: Deep, code-level visibility into your app's performance,
   failures, and end-to-end request flows.
```

---

## 68.6 Real-World Example

```
The 8-microservice e-commerce app has intermittent slow checkouts, but
the team can't tell which service is responsible:

Step 1: Application Insights is enabled across all services, with
        distributed tracing correlating requests across them.
Step 2: A slow checkout is investigated in the "Performance" view →
        the distributed trace for that request shows it spent 3.2
        seconds in the Payment Service (vs milliseconds elsewhere).
Step 3: Drilling into the Payment Service's trace reveals a slow external
        call to the payment gateway's API.
Step 4: The Application Map confirms the Payment Service node is showing
        elevated latency.
Step 5: They add a timeout + retry policy and cache, and set an alert on
        payment-dependency latency.

Result: distributed tracing pinpointed the exact service and dependency
causing slow checkouts — impossible to isolate with infrastructure
metrics alone.
```

---

## 68.7 Interview Q&A

**Q: What is Application Insights?**
> It's Azure Monitor's Application Performance Monitoring (APM) component — it collects code-level telemetry from your application: request rates and response times per endpoint, dependency call timings (DB, external APIs), exceptions with stack traces, and custom metrics. It's the equivalent of AWS X-Ray plus application-level insights.

**Q: What is distributed tracing and why is it valuable?**
> Distributed tracing follows a single request across all the microservices it touches, showing the end-to-end journey and where time was spent. It's invaluable in microservices architectures because when a request is slow or fails, tracing immediately reveals *which specific service* caused it — something infrastructure metrics alone can't tell you.

**Q: What's the Application Map?**
> An auto-generated visual diagram of all your services and their dependencies with health/performance overlaid — letting you see at a glance how components connect and which one is unhealthy or slow.

---

## 68.8 Summary

Application Insights is Azure Monitor's APM component, giving deep application-level visibility: per-endpoint performance, dependency timings, exceptions with stack traces, and custom metrics. Its standout feature is distributed tracing — following a single request across all the microservices it touches to reveal exactly where slowness or failure occurs — plus an auto-generated Application Map of your service dependencies. It's the equivalent of AWS X-Ray, essential for diagnosing issues in microservices architectures, and directly supports the JD's observability and troubleshooting requirements.

---
---

# 69. 🚨 Alerting Strategy & Incident Response
> 🟡 KNOW-THIS-MUCH

---

## 69.1 What Problem Does This Solve?

Having monitoring is only useful if the right people are notified at the right time and know what to do. A poor alerting strategy causes either missed incidents (no alerts) or "alert fatigue" (so many alerts that people ignore them all). A good **alerting strategy** plus a clear **incident response** process ensures problems are detected fast and resolved calmly — directly supporting the JD's "faster issue detection and resolution."

> 💡 **If you know AWS:** This is process/practice knowledge (SRE/DevOps culture), cloud-agnostic — the same principles apply whether alerts come from Azure Monitor or CloudWatch.

---

## 69.2 A Good Alerting Strategy (Flow Diagram)

```
Bad: alert on EVERYTHING → alert fatigue → people ignore alerts →
     real incidents missed

Good: TIERED, ACTIONABLE alerts routed by severity:

   Severity 0 (Critical): service DOWN / data loss risk
      → page on-call immediately (phone/SMS + PagerDuty)
   Severity 1 (High): major degradation (error rate high)
      → SMS + Teams alert to the team
   Severity 2 (Warning): early warning (CPU rising, disk 80%)
      → email / Teams (no 3am wake-up)
   Severity 3 (Info): informational (deployment completed)
      → dashboard / log only

Principle: every alert should be ACTIONABLE (someone can do something
about it) and routed to the right people at the right urgency.
```

---

## 69.3 Key Alerting Principles

```
✅ Alert on SYMPTOMS users feel (high error rate, slow responses),
   not just causes (high CPU) — CPU being high isn't a problem if users
   are unaffected
✅ Make every alert actionable — if there's nothing to do about it, it
   shouldn't page anyone
✅ Route by severity — critical pages the on-call; warnings just email
✅ Avoid alert fatigue — too many false/noisy alerts train people to
   ignore them
✅ Use ML-based/dynamic thresholds where possible (Section 72) to reduce
   false positives
```

---

## 69.4 Incident Response Process (Flow Diagram)

```
Alert fires (or issue reported)
       ↓
1. DETECT & ACKNOWLEDGE — on-call engineer acknowledges the alert
       ↓
2. TRIAGE — assess severity & impact (how many users? data at risk?)
       ↓
3. MITIGATE — stop the bleeding FIRST (rollback, feature-flag-off,
   scale out, failover) — restore service before finding root cause
       ↓
4. INVESTIGATE — use metrics (Section 66), logs/KQL (Section 67), and
   traces (Section 68) to find the root cause
       ↓
5. RESOLVE — apply the fix
       ↓
6. POST-INCIDENT REVIEW (blameless post-mortem) — what happened, why,
   and what to improve so it doesn't recur
```

**Key principle:** mitigate first (restore service), investigate root cause second. Users care about the service being back, not about you finding the root cause immediately.

---

## 69.5 On-Call & Runbooks

```
On-call rotation: a schedule of who responds to alerts at any given time
   (integrated via PagerDuty/Opsgenie with Azure Monitor Action Groups)

Runbooks: documented step-by-step procedures for handling known issues
   ("if the payment queue backs up, do X, Y, Z") — so responders don't
   have to figure everything out from scratch at 3am
```

---

## 69.6 Real-World Example

```
A team sets up a mature alerting + incident response practice:

Alerting:
   • Critical (service down): PagerDuty pages the on-call engineer's phone
   • High (error rate > 5%): SMS + Teams alert
   • Warning (disk > 80%): email only
   All alerts link to a runbook with initial troubleshooting steps.

Incident response for a real outage:
   1. Payment failures spike → critical alert pages the on-call engineer.
   2. They acknowledge, triage (payments are failing — high impact).
   3. MITIGATE first: they roll back the recent deployment (or flip a
      feature flag off) → service restored within minutes.
   4. INVESTIGATE: using Application Insights distributed tracing + KQL
      logs, they find the root cause (a bad config in the new release).
   5. RESOLVE: fix the config, redeploy carefully (canary).
   6. Blameless post-mortem: document the timeline, root cause, and
      action items (e.g., add a test that would've caught it).

Result: fast detection, calm structured response (mitigate-then-
investigate), and continuous improvement — faster issue resolution, as
the JD wants.
```

---

## 69.7 Interview Q&A

**Q: How do you design a good alerting strategy?**
> Make alerts tiered by severity and always actionable — critical issues page the on-call immediately, warnings just email, info goes to dashboards. Alert on symptoms users actually feel (high error rates, slow responses) rather than just causes (high CPU that may not affect users). Avoid alert fatigue from noisy/false alerts, since that trains people to ignore alerts and miss real incidents.

**Q: Walk me through an incident response process.**
> Detect & acknowledge the alert, triage severity/impact, mitigate first (rollback, feature-flag-off, failover — restore service before finding root cause), then investigate using metrics, logs/KQL, and traces, resolve with a fix, and finally run a blameless post-mortem to capture what happened and how to prevent recurrence. The key principle is mitigate-then-investigate — restore the service before chasing root cause.

---

## 69.8 Summary

A good alerting strategy is tiered by severity and actionable — critical issues page the on-call, warnings email, and alerts focus on user-felt symptoms to avoid alert fatigue. Incident response follows a structured flow: detect → acknowledge → triage → **mitigate first** (rollback/flag-off/failover to restore service) → investigate root cause (metrics, KQL logs, traces) → resolve → blameless post-mortem. On-call rotations (via PagerDuty/Action Groups) and runbooks ensure fast, calm responses. This process discipline is what delivers the JD's "faster issue detection and resolution."

---
---

# 70. 🎯 SLI / SLO / SLA & Error Budgets
> 🟡 KNOW-THIS-MUCH

---

## 70.1 What Problem Does This Solve?

"Is our service reliable enough?" is a vague question until you can measure it. SLIs, SLOs, and SLAs provide a precise, agreed-upon way to define, measure, and commit to reliability — a core Site Reliability Engineering (SRE) concept that increasingly comes up in senior DevOps interviews and aligns with the JD's "delivery speed, reliability, and security" systems thinking.

> 💡 **If you know AWS:** These are cloud-agnostic SRE concepts, not tied to any provider. The same definitions apply everywhere.

---

## 70.2 The Three Terms (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  SLI (Service Level INDICATOR)                            │
│  = a MEASUREMENT of some aspect of service health          │
│    e.g., "% of requests that succeed" = 99.95%             │
│    (the actual measured number)                           │
└──────────────────────┬─────────────────────────────────────┘
                       ↓ you set a target for the SLI...
┌──────────────────────────────────────────────────────────┐
│  SLO (Service Level OBJECTIVE)                            │
│  = the internal TARGET/GOAL for an SLI                     │
│    e.g., "99.9% of requests should succeed"                │
│    (what you AIM for)                                      │
└──────────────────────┬─────────────────────────────────────┘
                       ↓ and you promise customers (contractually)...
┌──────────────────────────────────────────────────────────┐
│  SLA (Service Level AGREEMENT)                            │
│  = a CONTRACTUAL promise to customers, with consequences   │
│    e.g., "99.5% uptime or we refund you 10%"               │
│    (the external commitment, usually looser than the SLO)  │
└──────────────────────────────────────────────────────────┘

Simple memory hook:
   SLI = Indicator (the measurement)
   SLO = Objective (the internal goal)
   SLA = Agreement (the customer promise, with penalties)
Usually: SLA (loosest) < SLO (stricter internal goal) < actual performance
```

---

## 70.3 Error Budgets (The Clever Part)

An **Error Budget** is the flip side of an SLO — if your SLO is 99.9% success, then 0.1% failure is your "budget" of allowed unreliability.

```
SLO: 99.9% of requests succeed
   → Error Budget: 0.1% of requests are ALLOWED to fail

How it's used to balance reliability vs speed (the key insight):
   • Budget remaining? → you can take more risk: ship features faster,
     do more deployments
   • Budget exhausted (too many failures already)? → STOP shipping risky
     changes; focus on stability until reliability recovers

Error budgets turn "reliability vs feature velocity" from an argument
into a data-driven decision.
```

---

## 70.4 Common SLI Types

| SLI | Measures |
|---|---|
| **Availability** | % of time the service is up / requests that succeed |
| **Latency** | % of requests served faster than a threshold (e.g., < 300ms) |
| **Error rate** | % of requests that fail |
| **Throughput** | Requests handled per second |

---

## 70.5 Steps — Implementing SLOs with Azure Monitor

```
📍 SLIs/SLOs are measured using Azure Monitor + Application Insights:

Step 1: Define your SLI — e.g., "% of requests with HTTP 2xx/3xx" —
        measurable from Application Insights request telemetry.
Step 2: Set your SLO target — e.g., 99.9% success over 30 days.
Step 3: Build a KQL query (Section 67) / dashboard computing the SLI:
        AppRequests
        | summarize SuccessRate = 100.0 * countif(success == true) / count()
Step 4: Create an alert when the SLI approaches breaching the SLO (i.e.,
        the error budget is being consumed too fast).
Step 5: Track the error budget over time on a dashboard to inform the
        "ship features vs focus on stability" decision.

📍 RESULT: reliability becomes measurable, targeted, and used to balance
   feature velocity against stability.
```

---

## 70.6 Real-World Example

```
A payment platform defines its reliability formally:

SLI:  % of payment requests that succeed (measured via App Insights)
SLO:  99.95% success over a rolling 30 days (internal target)
SLA:  99.9% success promised to enterprise customers (with service
      credits if breached — looser than the internal SLO for safety margin)
Error Budget: 0.05% of payments allowed to fail per month

Usage:
   • Early in the month, plenty of error budget remains → the team ships
     new features and does frequent deployments confidently.
   • Mid-month, a bad release burns through much of the error budget →
     the team FREEZES risky changes and focuses on stability until the
     budget recovers, protecting the customer-facing SLA.

Result: a data-driven, non-emotional way to balance moving fast with
staying reliable — exactly the "systems thinking across delivery speed,
reliability, and security" the JD wants.
```

---

## 70.7 Interview Q&A

**Q: What's the difference between SLI, SLO, and SLA?**
> An SLI (Indicator) is a measurement of service health, like the measured percentage of successful requests. An SLO (Objective) is your internal target for that SLI, like "99.9% success." An SLA (Agreement) is a contractual promise to customers with consequences, like "99.5% uptime or we issue credits" — usually looser than the internal SLO to give a safety margin.

**Q: What is an error budget and how is it used?**
> An error budget is the allowed amount of unreliability — the inverse of the SLO (a 99.9% SLO means a 0.1% error budget). It's used to balance feature velocity against reliability: if budget remains, the team can ship faster and take more risk; if it's exhausted, they stop shipping risky changes and focus on stability. It turns the reliability-vs-speed trade-off into a data-driven decision.

---

## 70.8 Summary

SLI (Indicator) is a measurement of service health, SLO (Objective) is your internal reliability target for that SLI, and SLA (Agreement) is the contractual customer promise (usually looser than the SLO). An error budget is the inverse of the SLO — the allowed unreliability — used to data-drive the balance between shipping features fast (when budget remains) and focusing on stability (when it's exhausted). Measured via Azure Monitor/Application Insights, these SRE concepts turn reliability into something precise and actionable, aligning with the JD's systems-thinking-across-reliability expectation.

---
---

# 71. 🔐 DevSecOps on Azure
> 🔴 FULL

---

## 71.1 What Problem Does This Solve?

Security added at the end — right before (or after) release — is slow, expensive, and risky. **DevSecOps** means building security *into* the development and deployment process from the start ("shift left"), so vulnerabilities are caught early and cheaply. Your JD explicitly requires "basic DevSecOps practices, including secrets management and policy controls."

> 💡 **If you know AWS:** DevSecOps is a practice/culture, cloud-agnostic — the same shift-left principles and scanning types apply, just with Azure-native tools (Defender for Cloud, Azure Policy) instead of AWS ones (Security Hub, Config).

---

## 71.2 "Shift Left" — Security at Every Stage (Flow Diagram)

```
❌ OLD WAY: build everything → security review at the end → find big
   problems → scramble to fix under deadline pressure (or ship with risk)

✅ DEVSECOPS ("shift left"): security checks at EVERY stage, automatically

   Code commit                    → Secret scanning (no committed secrets)
       ↓
   Build / PR                     → SAST (scan code for vulnerabilities)
                                  → SCA (scan dependencies for known CVEs)
       ↓
   Container build                → Image scanning (scan for OS/lib CVEs)
       ↓
   IaC (Terraform/Bicep)          → IaC scanning (misconfigurations)
       ↓
   Deploy to staging              → DAST (scan the running app)
       ↓
   Deploy to Azure                → Azure Policy (block non-compliant
                                    resources — final backstop)
       ↓
   Runtime                        → Defender for Cloud (posture + threats)

Each stage catches a different class of issue, early and cheaply.
```

---

## 71.3 The Types of Security Scanning

| Scan Type | What It Checks | Example Tools |
|---|---|---|
| **Secret scanning** | Accidentally committed passwords/keys | GitHub secret scanning, Gitleaks |
| **SAST** (Static App Security Testing) | Vulnerable patterns in your source code | SonarQube, CodeQL, Checkmarx |
| **SCA** (Software Composition Analysis) | Known CVEs in third-party dependencies | Dependabot, Mend, OWASP Dependency-Check |
| **Container image scanning** | Vulnerabilities in the built image's OS/libs | Trivy, Defender for Containers, Aqua |
| **IaC scanning** | Misconfigurations in Terraform/Bicep | Checkov, tfsec, PSRule |
| **DAST** (Dynamic App Security Testing) | Vulnerabilities in the running app | OWASP ZAP |

---

## 71.4 The Three Pillars for This JD

### Pillar 1: Secrets Management (Explicitly Required)
Never hardcode secrets — store them in **Key Vault** (Section 32), retrieve them via **Managed Identity** (Section 6) at runtime, and use **secret scanning** to catch any accidental commits. (Covered fully in Sections 32-33.)

### Pillar 2: Policy Controls (Explicitly Required)
**Azure Policy** enforces governance at the infrastructure level — and can *proactively block* non-compliant resources at deployment time (not just detect them). E.g., "deny creating any Storage Account without encryption." This is the final backstop even if a pipeline scan missed something.

### Pillar 3: Least-Privilege Pipeline Identity
The pipeline's Service Connection (Section 39) should have RBAC scoped narrowly to only what it needs — so a compromised pipeline has a limited blast radius.

---

## 71.5 Azure Policy as a Security Backstop (Flow Diagram)

```
Even if a pipeline's IaC scan missed an insecure config:

Pipeline tries to deploy a Storage Account WITHOUT encryption
       ↓
Azure Policy (with a "Deny" effect) evaluates it AT DEPLOYMENT TIME
       ↓
   Policy matches → deployment REJECTED
       ↓
The insecure resource is never created — defense in depth, where
security doesn't rely on any single check passing.
```

Azure Policy can also **auto-remediate** (e.g., automatically enable a missing security setting) via its DeployIfNotExists effect.

---

## 71.6 Steps — Adding Security Gates to a Pipeline

```
📍 In your Azure Pipeline YAML, add scanning stages that FAIL the
   pipeline if serious issues are found:

stages:
- stage: SecurityScans
  jobs:
  - job: Scans
    steps:
      - script: gitleaks detect        # secret scanning
      - script: sonar-scanner          # SAST
      - script: trivy image myapp:$(Build.BuildId)   # container scan
      - script: checkov -d ./terraform  # IaC scanning
      # if any of these find critical issues, they exit non-zero →
      # the pipeline STOPS, blocking the insecure change

📍 Plus, enable Azure Policy (Portal → "Policy" → assign an initiative
   like "CIS Azure Benchmark" or a Deny policy) at the subscription/
   management-group level as the infrastructure backstop.

📍 And enable Microsoft Defender for Cloud (Section 37 concept) for
   continuous posture management + runtime threat detection.

📍 RESULT: security is enforced automatically at every stage — code,
   dependencies, containers, IaC, deployment, and runtime.
```

---

## 71.7 Real-World Example

```
A fintech team implements DevSecOps in their existing pipeline:

Pipeline security gates (each FAILS the build on critical findings):
   1. Secret scanning — blocks any accidentally committed credential
   2. SAST (SonarQube) — blocks new critical code vulnerabilities
   3. SCA (Dependabot/Mend) — blocks critical unpatched dependency CVEs
   4. Container scan (Trivy) — blocks images with critical OS/lib CVEs
   5. IaC scan (Checkov) — blocks Terraform that would create insecure
      resources (e.g., public storage)

Secrets: all in Key Vault, retrieved via Managed Identity — the pipeline
   uses a Key Vault-linked Variable Group (Section 42), never hardcoded.

Policy backstop: Azure Policy denies creating any unencrypted database/
   storage, even if a scan somehow missed it.

Least privilege: the pipeline's Service Connection (WIF) is scoped to
   only the target resource group.

Runtime: Defender for Cloud continuously monitors posture + threats.

Result: security is continuous and automated — vulnerabilities are
caught within minutes of being introduced, not in a stressful pre-release
review, with Azure Policy as a final safety net.
```

---

## 71.8 Interview Q&A

**Q: What is DevSecOps and what does "shift left" mean?**
> DevSecOps means building security into the development and deployment process from the start, rather than as a final gate. "Shift left" means moving security checks earlier in the process — scanning code, dependencies, containers, and IaC automatically in the pipeline — so vulnerabilities are caught early and cheaply, when they're easiest to fix, rather than discovered late or after release.

**Q: What types of security scanning would you put in a pipeline?**
> Secret scanning (catch committed credentials), SAST (source code vulnerabilities), SCA (vulnerable dependencies), container image scanning (image CVEs), IaC scanning (misconfigured Terraform/Bicep), and optionally DAST (scan the running app in staging). Each catches a different class of issue, and critical findings should fail the pipeline to block the insecure change.

**Q: How does Azure Policy fit into DevSecOps?**
> Azure Policy provides a governance backstop at the infrastructure level — it can proactively *deny* the creation of non-compliant resources at deployment time (e.g., an unencrypted storage account) even if a pipeline scan missed it, and can auto-remediate missing settings. It's defense in depth — security doesn't rely on any single pipeline check passing.

**Q: How do you handle secrets in a DevSecOps pipeline?**
> Never hardcode them — store secrets in Key Vault, retrieve them at runtime via Managed Identity (or a Key Vault-linked Variable Group in the pipeline, masked in logs), and run secret scanning to catch any accidental commits. This is the secrets-management pillar the JD explicitly requires.

---

## 71.9 Summary

DevSecOps builds security into every stage of the pipeline ("shift left") — secret scanning, SAST, SCA, container scanning, IaC scanning, and DAST — each failing the build on critical findings so issues are caught early and cheaply. For this JD specifically: secrets management (Key Vault + Managed Identity + secret scanning, never hardcoded), policy controls (Azure Policy proactively denying non-compliant resources as an infrastructure backstop), and least-privilege pipeline identities. Microsoft Defender for Cloud adds continuous runtime posture management. Together this is defense in depth — security enforced automatically and continuously, not relying on any single check.

---
---

# 72. 🤖 AI-Assisted DevOps (AIOps)
> 🟠 MEDIUM

---

## 72.1 What Problem Does This Solve?

Your JD has a whole section on **AI-Assisted DevOps** — using AI to improve productivity and troubleshooting: pipeline failure analysis, AI-assisted reviews, and log/metric investigation. The goal isn't building AI models; it's *applying* existing AI tools to reduce manual toil in everyday DevOps work.

> 💡 **If you know AWS:** This is tool-and-practice knowledge that's largely cloud-agnostic — the same AI-assisted patterns (Copilot-style code help, LLM log analysis, ML anomaly detection) apply whether your stack is Azure or AWS.

---

## 72.2 Where AI Helps in DevOps (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  Traditional (manual)          →  AI-Assisted             │
│                                                            │
│  Read 500 lines of failed      →  AI summarizes the log &  │
│  pipeline logs to find error       suggests the root cause │
│                                                            │
│  Manually review every PR's    →  AI flags anti-patterns/  │
│  YAML/IaC for issues               security gaps for you   │
│                                                            │
│  Hand-write complex KQL/log    →  Describe the query in     │
│  queries during an incident        plain English → AI       │
│                                     generates the KQL       │
│                                                            │
│  Hand-tune every alert         →  ML-based anomaly          │
│  threshold                          detection (dynamic       │
│                                     thresholds)             │
└──────────────────────────────────────────────────────────┘
```

---

## 72.3 The Four JD-Specific Applications

### 1. Pipeline Failure Analysis (Explicitly in the JD)
```
Pipeline fails → an automated step sends the failure log to an AI service
(e.g., Azure OpenAI Service) with a prompt: "summarize the root cause and
suggest a fix" → the AI's summary is posted to Teams / the pipeline run.

Example output: "Likely root cause: the Service Connection lacks
'Microsoft.Web/sites/write' permission on the target resource group.
Suggested fix: grant it the Contributor role on that RG."

→ turns 20 minutes of log-scrolling into a 2-minute verify-and-fix.
```

### 2. AI-Assisted Reviews (Explicitly in the JD)
```
Tools like GitHub Copilot review PRs containing pipeline YAML, Bicep/
Terraform, or Kubernetes manifests, automatically flagging issues:
   "This NSG rule allows SSH from Any — restrict it or use Bastion."
   "This pipeline stage has no timeout — a hung step could block the queue."
→ human reviewers start from a pre-annotated PR (faster, more consistent).
```

### 3. Log & Metric Investigation (Explicitly in the JD)
```
Instead of hand-writing KQL: describe it in plain English →
"show all errors in the last hour grouped by service" → AI-assisted
tooling generates the KQL (Section 67), runs it, returns results.
→ lowers the barrier to effective log investigation.
```

### 4. Anomaly Detection
```
Instead of hardcoding "alert if CPU > 80%", Azure Monitor's ML-based
DYNAMIC THRESHOLDS learn each metric's normal daily/weekly pattern and
alert only on genuinely unusual deviations → fewer false alarms, catches
both unusual spikes AND drops.
```

---

## 72.4 Relevant Azure/Microsoft Tools

| Tool | AIOps Use |
|---|---|
| **Azure OpenAI Service** | Call GPT models from a pipeline/script to summarize failures, generate config, etc. |
| **GitHub Copilot** | AI-assisted code/YAML/IaC authoring and PR review |
| **Azure Monitor Dynamic Thresholds** | ML-based alerting (learns normal patterns) |
| **App Insights Smart Detection** | Auto-detects anomalies (failure spikes, performance degradation) without manual thresholds |
| **Microsoft Sentinel (UEBA/Fusion)** | ML-based security anomaly/threat correlation (Section 37) |

---

## 72.5 Steps — Adding AI-Assisted Pipeline Failure Analysis

```
📍 A realistic, interview-ready pattern (a lightweight script, not an
   ML project):

In your Azure Pipeline YAML, add a step that runs ONLY on failure:

- task: AzureCLI@2
  condition: failed()          # ← runs only when the pipeline failed
  inputs:
    azureSubscription: 'my-service-connection'
    scriptType: 'bash'
    inlineScript: |
      # 1. collect the failed job's logs
      # 2. call Azure OpenAI Service with a prompt: "summarize the root
      #    cause of this pipeline failure log and suggest a fix: <log>"
      # 3. post the AI's response to Teams / as a comment on the run

📍 RESULT: whenever the pipeline fails, an AI-generated root-cause summary
   and suggested fix appears automatically — speeding up troubleshooting.
```

---

## 72.6 Real-World Example

```
A team reduces incident/pipeline troubleshooting time with AIOps:

Before: pipeline failures required an experienced engineer to scroll
through logs (15-20 min); production incidents required manually
cross-referencing multiple dashboards.

After:
   • A failure-analysis step calls Azure OpenAI on any pipeline failure,
     posting a root-cause summary + suggested fix to Teams within seconds.
     Junior engineers now resolve most failures themselves in minutes.
   • GitHub Copilot flags common IaC/pipeline anti-patterns in PRs before
     human review.
   • Azure Monitor dynamic thresholds replaced dozens of hand-tuned alert
     thresholds, cutting false alarms significantly.
   • App Insights Smart Detection auto-surfaced a memory leak nobody had
     written an alert for.

Result: faster mean-time-to-resolution and less manual toil — with humans
always VERIFYING AI suggestions before acting (AI is a co-pilot, not an
autonomous decision-maker).
```

---

## 72.7 The Important Caveat

AI-assisted tools are **productivity multipliers, not replacements for judgment.** Every AI suggestion — a root-cause diagnosis, a review comment, a generated query — should be **verified by a human** before acting, especially for production. Think of AI as a fast, well-read junior colleague pointing you in a promising direction, not an infallible authority.

---

## 72.8 Interview Q&A

**Q: How can AI assist with DevOps work?**
> By reducing manual toil: summarizing pipeline failure logs and suggesting root causes (instead of manually scrolling logs), AI-assisted PR reviews flagging IaC/pipeline anti-patterns, translating plain-English questions into log queries (KQL), and ML-based anomaly detection replacing hand-tuned alert thresholds. The goal is applying existing AI tools (Azure OpenAI, GitHub Copilot, Azure Monitor's ML features) to work faster — not building AI models.

**Q: Describe a concrete example of AI-assisted pipeline failure analysis.**
> Add a pipeline step that runs only on failure (`condition: failed()`), collects the failed job's logs, sends them to Azure OpenAI Service with a prompt asking for the root cause and a suggested fix, and posts the AI's response to Teams or the pipeline run. This turns minutes of manual log-reading into a quick verify-and-fix — while the engineer still verifies the suggestion before acting.

**Q: What's the key caveat with AI-assisted DevOps?**
> AI suggestions are productivity aids, not authoritative decisions — they must always be verified by a human before acting, especially for anything touching production. AI is a co-pilot that points you in a promising direction quickly, not a replacement for engineering judgment.

---

## 72.9 Summary

AIOps applies existing AI tools to reduce manual DevOps toil — the JD's four focus areas: AI-summarized pipeline failure analysis (via Azure OpenAI), AI-assisted PR/IaC/config reviews (via GitHub Copilot), natural-language log/metric investigation (plain English → KQL), and ML-based anomaly detection (Azure Monitor dynamic thresholds, App Insights Smart Detection). The realistic pattern is lightweight — e.g., a pipeline step that calls Azure OpenAI on failure to post a root-cause summary — not building ML models. Crucially, AI suggestions are always human-verified before acting; AI is a co-pilot, not an autonomous authority.

---

---
---

# 73. 🏷️ Tagging & Naming Conventions
> 🟡 KNOW-THIS-MUCH

---

## 73.1 What Problem Does This Solve?

In a real organization with thousands of resources, chaos sets in fast: nobody knows which resource belongs to which team/project, costs can't be broken down, and cleanup is impossible. **Tags** (metadata labels) and **naming conventions** (consistent resource names) bring order — enabling cost attribution, ownership tracking, automation, and governance. This is a practice, so "steps" are Portal tagging + Azure Policy enforcement.

> 💡 **If you know AWS:** Azure tags work exactly like AWS resource tags — key-value pairs for organizing, cost-tracking, and automation. Same concept and best practices.

---

## 73.2 Tags (Flow Diagram)

```
Every resource gets key-value TAGS:

   VM "web-prod-01"
     Environment: Production
     Project:     CustomerPortal
     Owner:       jane.doe@company.com
     CostCenter:  CC-1234
        ↓ these tags enable...
   ┌────────────────────────────────────────────────┐
   │ • Cost Management: filter the bill by CostCenter  │
   │   or Project → "CustomerPortal cost us $4,200"    │
   │ • Ownership: know who owns/contact for a resource  │
   │ • Automation: "shut down all Environment=Dev VMs   │
   │   at night" (Section 39)                          │
   │ • Governance: find/report on untagged resources    │
   └────────────────────────────────────────────────┘
```

---

## 73.3 Common Tags & Naming Patterns

**Common tags:**
| Tag | Purpose |
|---|---|
| `Environment` | Production / Staging / Dev |
| `Project` / `Application` | Which app/project it belongs to |
| `Owner` | Who's responsible (email) |
| `CostCenter` | For chargeback/cost attribution |
| `ManagedBy` | e.g., "Terraform" (so people don't hand-edit IaC-managed resources) |

**Naming convention example:**
```
Pattern: <resource-type>-<app>-<environment>-<region>-<instance>
Example: vm-customerportal-prod-cin-01
         rg-customerportal-prod
         kv-customerportal-prod   (Key Vault)
         st customerportalprod    (Storage — no hyphens allowed)

Consistent names make resources instantly identifiable and sortable.
```

---

## 73.4 Enforcing Tags with Azure Policy

Tagging only works if it's *consistent* — so organizations enforce it with **Azure Policy** (Section 71):
```
Azure Policy can:
   • REQUIRE certain tags on resource creation (deny if missing)
   • Auto-APPEND a tag (e.g., inherit CostCenter from the resource group)
   • Audit which resources are non-compliant (missing tags)
```

---

## 73.5 Steps — Applying & Enforcing Tags

```
📍 Apply tags to a resource (Portal):
   Open any resource (or resource group) → left menu "Tags" →
   add key-value pairs (e.g., Environment=Production) → Save

📍 Apply tags at scale (CLI):
   az resource tag --tags Environment=Production Project=Portal \
     --ids <resource-id>

📍 Enforce required tags (Azure Policy):
   Portal → "Policy" → "Assignments" → "Assign policy" → choose the
   built-in "Require a tag on resources" policy → specify the tag
   (e.g., "CostCenter") → resources without it are denied/flagged

📍 RESULT: consistent, enforced tagging → accurate cost attribution,
   clear ownership, and automation targeting.
```

---

## 73.6 Real-World Example

```
A company brings order to a sprawling Azure environment:

Naming convention: rg-<app>-<env>, vm-<app>-<env>-<nn>, etc. — every
   resource instantly identifiable.

Required tags (enforced by Azure Policy): Environment, Project, Owner,
   CostCenter — no resource can be created without them.

Benefits realized:
   • Finance runs Cost Management filtered by CostCenter → accurate
     per-team/per-project cost breakdown for chargeback.
   • An automation runbook shuts down all Environment=Dev VMs nightly
     (Section 39) → cost savings.
   • When a mystery resource appears, the Owner tag says who to ask.
   • A "ManagedBy: Terraform" tag warns engineers not to hand-edit
     IaC-managed resources.

Result: a governable, cost-attributable, automatable environment instead
of untraceable chaos.
```

---

## 73.7 Interview Q&A

**Q: Why are tags and naming conventions important?**
> They bring order to large environments: tags (key-value labels like Environment, Project, Owner, CostCenter) enable cost attribution/chargeback, ownership tracking, automation targeting (e.g., shut down all Dev resources), and governance reporting. Consistent naming conventions make resources instantly identifiable. Both are typically enforced with Azure Policy so they're applied consistently.

**Q: How do you enforce tagging consistency?**
> With Azure Policy — you can require specific tags on resource creation (denying resources that lack them), auto-append tags (e.g., inherit CostCenter from the resource group), and audit for non-compliant untagged resources. This ensures tagging is consistent rather than relying on people to remember.

---

## 73.8 Summary

Tags (key-value metadata like Environment, Project, Owner, CostCenter) and consistent naming conventions bring order to large Azure environments — enabling cost attribution, ownership tracking, automation targeting, and governance. They're enforced with Azure Policy (require/append tags, audit non-compliance) so they stay consistent. A well-tagged, well-named environment is governable and cost-attributable; an untagged one is chaos. Same concept and best practices as AWS tags.

---
---

# 74. 🏗️ Azure Landing Zones
> 🟡 KNOW-THIS-MUCH

---

## 74.1 What Problem Does This Solve?

When a large organization adopts Azure, they need a well-architected, secure, governed foundation *before* teams start deploying workloads — otherwise every team sets things up differently, security is inconsistent, and it becomes ungovernable. An **Azure Landing Zone** is a pre-configured, best-practice environment (the "landing zone" for your workloads) that provides this consistent, secure, scalable foundation from day one.

> 💡 **If you know AWS:** An Azure Landing Zone is directly comparable to **AWS Landing Zone / AWS Control Tower** — a governed, multi-account (multi-subscription) foundation set up with best practices before workloads land.

---

## 74.2 What a Landing Zone Provides (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  AZURE LANDING ZONE (the governed foundation)             │
│                                                            │
│  Management Group hierarchy (Section 1) organizing subs:   │
│                                                            │
│  Root MG                                                   │
│   ├── Platform MG   → shared services subscriptions:       │
│   │     • Identity (Entra ID config)                       │
│   │     • Management (monitoring, Log Analytics)           │
│   │     • Connectivity (hub VNet, firewall, ExpressRoute)  │
│   │                                                        │
│   └── Landing Zones MG → where WORKLOADS go:               │
│         • per-app / per-team subscriptions ("landing zones")│
│                                                            │
│  Applied consistently across all of it:                    │
│    • Azure Policy (governance/compliance guardrails)       │
│    • RBAC (consistent access control)                      │
│    • Networking (hub-and-spoke, Section 18)                │
│    • Monitoring, security (Defender), tagging standards    │
└──────────────────────────────────────────────────────────┘

Teams deploy their apps INTO a pre-built, governed landing zone — the
security, networking, and governance are already correctly set up.
```

---

## 74.3 Key Design Principles

```
✅ Subscriptions as units of scale — separate subscriptions per workload/
   team/environment (Section 1), organized under Management Groups
✅ Policy-driven governance — Azure Policy enforces standards everywhere
   automatically (encryption required, allowed regions, tagging, etc.)
✅ Centralized shared services — identity, connectivity (hub VNet),
   management/monitoring in dedicated platform subscriptions
✅ Consistent networking — hub-and-spoke topology built in
✅ Secure & compliant by default — new workloads inherit the guardrails
✅ Automated & repeatable — the whole thing is deployed via IaC
```

---

## 74.4 Steps — Getting Started with a Landing Zone

```
📍 Microsoft provides accelerators (not a single button), typically
   deployed via IaC:

Step 1: Use the Azure Landing Zone accelerator (available in the Portal
        under "Azure landing zones" / deployed via Bicep or Terraform
        templates Microsoft provides).
Step 2: It sets up the Management Group hierarchy, platform subscriptions
        (identity/management/connectivity), Azure Policy assignments,
        RBAC, and hub networking automatically.
Step 3: Teams then get their own "landing zone" subscription (a spoke)
        to deploy workloads into — already governed and connected.

📍 In the Portal: search "Azure landing zones" for the guided
   accelerator experience.

📍 RESULT: a consistent, secure, governed foundation that all workloads
   deploy into, rather than each team improvising their own setup.
```

---

## 74.5 Real-World Example

```
An enterprise moving many teams to Azure sets up a Landing Zone first:

Platform subscriptions (shared, set up once):
   • Connectivity: the hub VNet with Azure Firewall + ExpressRoute to
     on-premises (Section 18)
   • Identity: Entra ID configuration, Conditional Access, PIM
   • Management: central Log Analytics, Defender for Cloud, monitoring

Governance applied across everything (via Azure Policy):
   • "All storage must be encrypted" (deny otherwise)
   • "Resources only in approved regions"
   • "Required tags: CostCenter, Owner, Environment"

Workload landing zones:
   • Each team gets a spoke subscription, peered to the hub, inheriting
     all the security/networking/governance automatically.

Result: when Team A deploys a new app, it's automatically in a secure,
monitored, compliant, connected environment — no reinventing the
foundation, no inconsistent security, fully governed from day one.
```

---

## 74.6 Interview Q&A

**Q: What is an Azure Landing Zone?**
> A pre-configured, best-practice Azure environment that provides a secure, governed, scalable foundation for deploying workloads — including a Management Group/subscription hierarchy, centralized shared services (identity, connectivity/hub networking, monitoring), and consistent governance via Azure Policy and RBAC. Teams deploy their apps into these ready-made "landing zones" rather than each setting up their own foundation inconsistently. It's comparable to AWS Landing Zone / Control Tower.

**Q: Why use a Landing Zone instead of just creating resources as needed?**
> Because at enterprise scale, ad-hoc setup leads to inconsistent security, ungovernable sprawl, and duplicated shared infrastructure. A Landing Zone provides a consistent, secure, compliant foundation up front — with centralized identity, networking (hub-and-spoke), monitoring, and policy-driven guardrails — so every workload inherits best practices automatically, deployed repeatably via IaC.

---

## 74.7 Summary

An Azure Landing Zone is a pre-built, best-practice foundation for enterprise Azure adoption — a Management Group/subscription hierarchy with centralized platform services (identity, hub-and-spoke connectivity, monitoring) and consistent governance (Azure Policy, RBAC, tagging) applied throughout. Teams deploy workloads into ready-made, governed "landing zone" subscriptions rather than improvising their own setup, ensuring security, compliance, and consistency from day one. It's the equivalent of AWS Landing Zone / Control Tower, and is deployed repeatably via IaC accelerators.

---
---

# 75. 💰 Cost Management & FinOps Basics
> 🟡 KNOW-THIS-MUCH

---

## 75.1 What Problem Does This Solve?

Cloud costs can spiral out of control fast — forgotten VMs running 24/7, oversized resources, orphaned disks. Organizations need visibility into spending and a discipline for optimizing it. **Azure Cost Management** provides the visibility/controls, and **FinOps** is the practice/culture of managing cloud cost as a team responsibility. The JD values "systems thinking across delivery speed, reliability, and security" — cost-consciousness rounds this out.

> 💡 **If you know AWS:** Azure Cost Management is the equivalent of **AWS Cost Explorer + Budgets**, and FinOps is the same cross-cloud discipline (the FinOps Foundation framework applies to both).

---

## 75.2 Azure Cost Management (Flow Diagram)

```
┌──────────────────────────────────────────────────────────┐
│  AZURE COST MANAGEMENT + BILLING                          │
│                                                            │
│  • Cost Analysis: visualize & break down spend by          │
│    resource type, resource group, subscription, or TAG     │
│    (Section 73 — e.g., "CustomerPortal cost $4,200")       │
│                                                            │
│  • Budgets: set spending thresholds with ALERTS at         │
│    50% / 75% / 90% / 100% → catch overspend BEFORE the      │
│    bill arrives                                            │
│                                                            │
│  • Recommendations: (via Azure Advisor) — idle VMs,        │
│    orphaned disks, right-sizing, Reserved Instance savings  │
└──────────────────────────────────────────────────────────┘
```

---

## 75.3 Common Cost Optimization Levers

| Lever | Savings |
|---|---|
| **Shut down non-prod resources off-hours** | Dev VMs off nights/weekends (Section 39) → big savings |
| **Right-size** | Downsize over-provisioned VMs (Advisor flags idle ones) |
| **Reserved Instances / Savings Plans** | Commit 1-3 years for steady workloads → up to ~72% off |
| **Spot VMs** | For fault-tolerant/batch workloads → up to ~90% off |
| **Delete orphaned resources** | Unattached disks, unused public IPs still cost money |
| **Autoscaling** | Scale down when idle (VMSS/AKS/App Service) — pay for actual demand |
| **Storage lifecycle/tiers** | Move old blobs to Cool/Archive tiers automatically |

---

## 75.4 What is FinOps?

**FinOps** (Financial Operations) is the cultural practice of making cloud cost a shared, ongoing, team responsibility — bringing engineering, finance, and business together to continuously optimize cloud spend.

```
FinOps principles:
   • Visibility: everyone can see what things cost (via tags + Cost Mgmt)
   • Accountability: teams own their own costs (chargeback via CostCenter tags)
   • Optimization: continuous right-sizing, reservations, cleanup
   • Cost as a first-class metric alongside performance & reliability
```

---

## 75.5 Steps — Setting Up Cost Visibility & Budgets

```
📍 In the Azure Portal:

── Cost Analysis ──
Step 1: Search "Cost Management + Billing" → "Cost analysis" → filter/
        group by Tag (e.g., CostCenter) or Resource Group to see exactly
        what's costing what.

── Budgets with alerts ──
Step 2: "Cost Management" → "Budgets" → "+ Add" →
   ┌────────────────────────────────────────┐
   │ Scope:  a subscription or resource group │
   │ Amount: $5,000 / month                   │
   │ Alerts: at 50%, 75%, 90%, 100%           │
   │ Action: email the finance + DevOps teams  │
   └────────────────────────────────────────┘
   → Create

── Recommendations ──
Step 3: "Azure Advisor" → "Cost" tab → review & act on idle-resource,
        right-sizing, and Reserved Instance recommendations.

📍 RESULT: full cost visibility, proactive budget alerts before overspend,
   and actionable savings recommendations.
```

---

## 75.6 Real-World Example

```
A startup's Azure bill is creeping up; the team applies FinOps discipline:

Step 1: Ensure everything is tagged (Section 73) with CostCenter/Project.
Step 2: In Cost Analysis, filter by tag → discover Dev VMs running 24/7
        despite only being used 9-6 weekdays are a big chunk of the bill.
Step 3: Azure Advisor confirms these same VMs are chronically idle.
Step 4: Set up an automation runbook (Section 39) to shut down Dev VMs
        nights/weekends → ~60% savings on that environment's compute.
Step 5: Purchase Reserved Instances for the always-on production VMs →
        significant discount on predictable workloads.
Step 6: Delete a batch of orphaned unattached disks that were still
        being billed.
Step 7: Set monthly Budgets with alerts at 50/75/90/100% so they're
        never surprised by the bill again.

Result: meaningful, ongoing cost reduction with no impact on needed
capacity — cost treated as a first-class engineering concern.
```

---

## 75.7 Interview Q&A

**Q: How do you manage and control Azure costs?**
> Using Azure Cost Management for visibility — Cost Analysis (broken down by tag/resource group/subscription) to see what's costing what, and Budgets with alerts (50/75/90/100%) to catch overspend before the bill arrives. Then optimization levers: shut down non-prod resources off-hours, right-size (via Advisor), buy Reserved Instances/Savings Plans for steady workloads, use Spot VMs for fault-tolerant work, delete orphaned resources, and use autoscaling and storage tiering. Tagging (Section 73) underpins accurate cost attribution.

**Q: What is FinOps?**
> The cultural practice of managing cloud cost as a shared, continuous team responsibility — bringing engineering, finance, and business together with cost visibility (via tags), accountability (teams own their spend via chargeback), and ongoing optimization, treating cost as a first-class metric alongside performance and reliability.

---

## 75.8 Summary

Azure Cost Management provides cost visibility (Cost Analysis broken down by tag/resource group) and control (Budgets with tiered alerts to catch overspend early), while Azure Advisor surfaces savings recommendations. Key optimization levers: shut down non-prod off-hours, right-size, Reserved Instances/Savings Plans for steady workloads, Spot VMs for fault-tolerant work, delete orphaned resources, autoscaling, and storage tiering. FinOps is the discipline of treating cloud cost as a shared, ongoing, first-class engineering responsibility — underpinned by consistent tagging (Section 73).

---
---

# 76. 🔄 Disaster Recovery & Backup (RTO/RPO)
> 🟡 KNOW-THIS-MUCH

---

## 76.1 What Problem Does This Solve?

Things fail — a region outage, accidental data deletion, ransomware. **Backup** protects your data so you can restore it; **Disaster Recovery (DR)** ensures you can bring your whole application back after a major disruption. Defining **RTO** and **RPO** turns "how resilient are we?" into precise, measurable targets — core to the JD's reliability focus.

> 💡 **If you know AWS:** Azure Backup ≈ AWS Backup; Azure Site Recovery ≈ AWS Elastic Disaster Recovery / CloudEndure. RTO/RPO are universal, cloud-agnostic DR concepts.

---

## 76.2 RTO & RPO — The Two Key Metrics (Flow Diagram)

```
                    ← RPO →              disaster            ← RTO →
   ──────●──────────────●──────────────────✗───────────────────●──────►
      last backup    data lost          outage            service back up
                     (up to RPO)                           (within RTO)

RPO (Recovery Point Objective): "How much DATA can we afford to lose?"
   = the time between your last backup and the disaster
   e.g., RPO of 1 hour → you back up hourly → at most 1 hour of data lost

RTO (Recovery Time Objective): "How long can we be DOWN?"
   = the time to restore service after a disaster
   e.g., RTO of 30 min → you must be back up within 30 minutes

Lower RTO/RPO = more resilient, but more expensive. You set targets
based on how critical the system is.
```

---

## 76.3 Azure Backup

**Azure Backup** protects your data — VMs, disks, databases, files — by taking scheduled backups you can restore from.

```
Azure Backup (via a Recovery Services Vault):
   • Scheduled backups (e.g., daily) with retention (days/months/years)
   • Point-in-time restore (recover to a specific past backup)
   • Cross-region restore (restore in a different region)
   • Soft delete (deleted backups recoverable for 14 days — protects
     against accidental/malicious deletion)
   → Primarily addresses RPO (how recent your recoverable data is) and
     recovery from data loss/corruption/ransomware.
```

---

## 76.4 Azure Site Recovery (ASR) — For Regional DR

**Azure Site Recovery** replicates your VMs/workloads to another region continuously, so if your primary region has a major outage, you can **fail over** to the secondary region quickly.

```
Primary Region (running)
   ↓ ASR continuously replicates VMs to...
Secondary Region (standby replica)

Region outage → FAIL OVER to the secondary region → service restored
   → Primarily addresses RTO (how fast you can be back up) for
     region-level disasters.
When primary recovers → fail back.
```

---

## 76.5 DR Strategies by RTO/RPO (Cost vs Resilience)

| Strategy | RTO/RPO | Cost | How |
|---|---|---|---|
| **Backup & Restore** | Hours | Lowest | Restore from backups after a disaster |
| **Pilot Light** | ~Tens of min | Low-med | Minimal standby core in another region, scale up on failover |
| **Warm Standby** | Minutes | Med-high | A scaled-down running copy in another region, scale up on failover |
| **Active-Active (Hot)** | Near-zero | Highest | Full running copies in multiple regions serving traffic simultaneously |

You pick based on how critical the system is — a marketing site might use Backup & Restore; a payment system might need Active-Active.

---

## 76.6 Steps — Setting Up Backup & DR

```
── Azure Backup ──
📍 Portal → search "Recovery Services vaults" → "+ Create" → then
   "Backup" → select what to protect (VM, disk, files, SQL) → define a
   Backup Policy (schedule + retention) → enable.

── Azure Site Recovery (regional DR) ──
📍 In the Recovery Services vault → "Site Recovery" → set up replication
   of your VMs to a secondary region → configure a recovery plan (the
   order/steps to fail over) → periodically TEST failover (a "test
   failover" that doesn't disrupt production).

📍 RESULT: your data is backed up (meeting RPO) and your workloads can
   fail over to another region (meeting RTO) — with tested, documented
   recovery.
```

**Key practice:** regularly TEST your restores and failovers — an untested backup/DR plan is not a reliable one.

---

## 76.7 Real-World Example

```
A payment platform defines and implements its DR posture:

Requirements: RPO of 5 minutes (lose at most 5 min of transactions),
RTO of 15 minutes (be back within 15 min of a regional outage) — strict,
because payments are critical.

Implementation:
   • Azure Backup: frequent backups of databases/VMs with cross-region
     restore + soft delete (protects against data loss/ransomware).
   • Azure Site Recovery / Active-passive: the database uses geo-
     replication and the app is replicated to a secondary region, so on
     a regional outage they fail over within the RTO.
   • They run a TEST failover quarterly to verify the plan actually works
     and meets the RTO — catching issues before a real disaster.

For a less-critical internal reporting tool, they use simple Backup &
Restore (RTO of hours is acceptable) — matching the strategy to criticality.

Result: measurable, tested resilience matched to each system's importance.
```

---

## 76.8 Interview Q&A

**Q: What's the difference between RTO and RPO?**
> RPO (Recovery Point Objective) is how much data you can afford to lose — the gap between your last backup and the disaster (a 1-hour RPO means backing up hourly, losing at most 1 hour of data). RTO (Recovery Time Objective) is how long you can be down — the time to restore service after a disaster. Lower values mean more resilience but higher cost; you set them based on how critical the system is.

**Q: What's the difference between Azure Backup and Azure Site Recovery?**
> Azure Backup protects your data with scheduled, retained backups you can restore from — mainly addressing RPO and recovery from data loss/corruption/ransomware. Azure Site Recovery continuously replicates your workloads to another region so you can fail over during a regional outage — mainly addressing RTO for region-level disasters. They're complementary: Backup for data recovery, Site Recovery for regional failover.

**Q: What's a key practice with backup/DR?**
> Regularly test your restores and failovers. An untested backup or DR plan isn't reliable — you only know it works if you've actually tried recovering. Many teams run periodic test failovers that don't disrupt production.

---

## 76.9 Summary

Backup protects data (Azure Backup — scheduled, retained, cross-region restore, soft delete) and Disaster Recovery restores whole applications after major outages (Azure Site Recovery — cross-region replication + failover). RPO (how much data you can lose) and RTO (how long you can be down) are the measurable targets, set by criticality, driving the choice between Backup & Restore, Pilot Light, Warm Standby, or Active-Active strategies (cost vs resilience). The essential practice: regularly test restores and failovers, since an untested plan isn't reliable. This underpins the JD's reliability focus.

---
---

# 77. 🖥️ Compute Essentials (VM, VMSS, App Service, Slots)
> 🟠 MEDIUM

---

## 77.1 What Problem Does This Solve?

Azure offers several ways to run your application, trading off control vs convenience. Knowing the main compute options — and when to use each — is fundamental AZ-104 knowledge that rounds out your interview readiness.

> 💡 **If you know AWS:** VM ≈ EC2, VMSS ≈ Auto Scaling Group, App Service ≈ Elastic Beanstalk / App Runner. The IaaS→PaaS control-vs-convenience spectrum is the same.

---

## 77.2 The Compute Options (Flow Diagram)

```
More control ←──────────────────────────────────→ More convenience
(you manage more)                              (Azure manages more)

  Virtual Machines  →  VM Scale Sets  →  App Service  →  (Functions/
  (IaaS: full OS       (autoscaling      (PaaS: just     Container Apps
   control)             group of VMs)     deploy code)    — serverless)

Choose based on: how much OS-level control you need vs how much you want
Azure to handle for you.
```

| Option | What It Is | Use When |
|---|---|---|
| **Virtual Machine** | A single IaaS server you fully control | You need full OS control, legacy apps, specific configs |
| **VM Scale Set (VMSS)** | An autoscaling group of identical VMs | You need VMs that scale automatically with demand |
| **App Service** | PaaS for hosting web apps/APIs — just deploy code | Standard web apps where you don't want to manage the OS |
| **Deployment Slots** | Staging environments within an App Service | Zero-downtime Blue/Green deployments (Section 63) |

---

## 77.3 Virtual Machines (Recap)

A VM is an IaaS virtual server — you choose the OS, size (B/D/F/E/N series), and manage everything above the hypervisor (OS patching, app, config). Full control, most management responsibility. (Covered from the storage/networking angle throughout — here as the compute baseline.)

---

## 77.4 VM Scale Sets (Recap)

A group of identical VMs that autoscale based on demand (metric-based or scheduled), with self-healing (replaces unhealthy instances). The autoscaling foundation, and what AKS node pools are built on. (Autoscaling detail in Section 60's AKS context; same engine.)

---

## 77.5 App Service (PaaS Web Hosting)

**App Service** is PaaS for hosting web apps, REST APIs, and backends — you just deploy your code (or container), and Azure handles the OS, patching, load balancing, and scaling.

```
App Service concepts:
   • App Service Plan: defines the underlying compute (size/tier) that
     one or more Web Apps run on
   • Web App: your actual deployed application
   • Tiers: Free/Shared (testing) → Basic → Standard → Premium → Isolated
     (higher tiers add autoscale, deployment slots, VNet integration)
   • Built-in: autoscale, free SSL certs, custom domains, "Easy Auth"
     (Entra ID authentication with no code)
```

---

## 77.6 Deployment Slots (Recap — Key for Deployments)

**Deployment Slots** are live staging environments within an App Service (Standard tier+). Deploy to a "staging" slot, test it, then "swap" it with production for near-zero-downtime Blue/Green deployments with instant rollback (swap back). Also support percentage-based traffic routing for canary. (Covered fully in Section 63.)

---

## 77.7 Steps — Creating an App Service with a Deployment Slot

```
📍 In the Azure Portal:

Step 1: Search "App Services" → "+ Create" → choose runtime (Node/.NET/
        Python/container), an App Service Plan tier (Standard+ for slots)
        → Create.
Step 2: Deploy your code (via pipeline, Git, or ZIP).
Step 3: Add a slot: App Service → "Deployment slots" → "+ Add Slot" →
        "staging".
Step 4: Deploy new versions to "staging", test, then "Swap" with
        production (Section 63) for zero-downtime releases.

📍 RESULT: a fully managed web app with zero-downtime deployment capability
   — no OS or servers to manage.
```

---

## 77.8 Real-World Example

```
Choosing compute for different components of a system:

• A standard web API → App Service (PaaS — just deploy code, get
  autoscale + slots + free SSL, no OS to manage). Uses deployment slots
  for zero-downtime releases.
• A fleet of app servers needing OS-level customization + autoscaling →
  VM Scale Set.
• A legacy app requiring a specific old OS + full control → a Virtual
  Machine (IaaS).
• Event-driven background processing → Azure Functions (serverless).

Matching each workload to the right compute option balances control,
convenience, and cost.
```

---

## 77.9 Interview Q&A

**Q: When would you use a VM vs App Service?**
> Use a VM (IaaS) when you need full OS-level control — legacy apps, specific OS configs, or software that requires OS access. Use App Service (PaaS) for standard web apps/APIs where you just want to deploy code and let Azure handle the OS, patching, load balancing, and scaling — less control but far less management overhead.

**Q: What are App Service Deployment Slots used for?**
> Zero-downtime Blue/Green deployments. You deploy a new version to a "staging" slot, test it, then swap it with production (near-instant, with warm-up), and can swap back instantly for rollback. Slots also support percentage-based traffic routing for canary deployments.

---

## 77.10 Summary

Azure's compute options span a control-vs-convenience spectrum: Virtual Machines (IaaS, full control), VM Scale Sets (autoscaling VM groups), App Service (PaaS — just deploy code, Azure handles the OS/scaling/SSL), and serverless options like Functions. App Service Deployment Slots enable zero-downtime Blue/Green deployments (deploy to staging → swap with production → instant rollback). Match each workload to the right option based on how much OS-level control you need versus how much you want Azure to manage.

---
---

# 78. 🗄️ Storage Essentials (Storage Account, Blob, SAS, Tiers)
> 🟡 KNOW-THIS-MUCH

---

## 78.1 What Problem Does This Solve?

Applications need to store files, and Azure Storage is the foundation. Knowing the essentials — Storage Accounts, Blob Storage, access control (SAS), and access tiers — is fundamental AZ-104 knowledge that appears in interviews and underpins many other services (Terraform state, pipeline artifacts, backups).

> 💡 **If you know AWS:** Blob Storage ≈ S3, SAS tokens ≈ S3 pre-signed URLs, access tiers (Hot/Cool/Cold/Archive) ≈ S3 storage classes (Standard/IA/Glacier). Redundancy (LRS/ZRS/GRS) is Azure's explicit version of S3's durability model.

---

## 78.2 Storage Account & Blob Basics (Flow Diagram)

```
STORAGE ACCOUNT ("mycompanystorage" — globally unique name)
   provides four storage services:
   ├── BLOB STORAGE  → unstructured files (images, videos, backups, logs)
   │     └── Containers (like folders) → Blobs (the files)
   ├── AZURE FILES   → shared network drives (SMB/NFS)
   ├── QUEUE STORAGE → simple message queues
   └── TABLE STORAGE → simple NoSQL key-value data

Blob URL: https://mycompanystorage.blob.core.windows.net/<container>/<blob>
```

---

## 78.3 Access Tiers (Cost vs Access Speed)

| Tier | For | Cost |
|---|---|---|
| **Hot** | Frequently accessed data | Highest storage, cheapest access |
| **Cool** | Infrequent (min 30 days) | Lower storage, higher access cost |
| **Cold** | Rare (min 90 days) | Even lower storage |
| **Archive** | Almost never (min 180 days), retrieval takes HOURS | Cheapest by far |

**Lifecycle Management** auto-moves blobs between tiers as they age (e.g., Hot → Cool after 30 days → Archive after 180) to control cost.

---

## 78.4 Access Control — How to Grant Access

| Method | What It Is |
|---|---|
| **Access Keys** | Master keys for the whole account — powerful, use sparingly, rotate |
| **SAS (Shared Access Signature)** | A time-limited, scoped URL granting specific access (e.g., "read this one blob for 1 hour") without sharing account keys |
| **Azure AD / RBAC** | Grant identities (users/apps/Managed Identities) roles like "Storage Blob Data Reader" — the modern, recommended approach |
| **Public access** | Make a container publicly readable — use with extreme caution, disable by default |

```
SAS token flow (like S3 pre-signed URLs):
   App needs to give a user temporary access to one file
       ↓
   Generate a SAS URL: read-only, valid 1 hour, for that specific blob
       ↓
   User uses the SAS URL to download → works for 1 hour, then expires,
   and grants access to nothing else. No account keys shared.
```

---

## 78.5 Redundancy (Recap)

How many copies Azure keeps and where: **LRS** (3 copies, one datacenter), **ZRS** (across 3 zones), **GRS** (+ a paired region), **GZRS** (zones + paired region). More redundancy = higher cost, lower risk of data loss.

---

## 78.6 Steps — Creating Storage, a Container, and a SAS Token

```
📍 In the Azure Portal:

Step 1: Search "Storage accounts" → "+ Create" → name (globally unique,
        lowercase/numbers), redundancy (e.g., ZRS), access tier (Hot) →
        Create.
Step 2: Open it → "Containers" → "+ Container" → name it (e.g., "uploads").
Step 3: Upload blobs into the container, or let apps write to it.
Step 4: Generate a SAS for temporary access: open a blob (or the account →
        "Shared access signature") → set permissions (Read), expiry
        (1 hour), scope → "Generate SAS token and URL" → share that URL.

📍 For lifecycle tiering: Storage account → "Lifecycle management" → add
   a rule (e.g., move to Cool after 30 days, Archive after 180).

📍 RESULT: file storage with cost-appropriate tiering and secure,
   time-limited access via SAS (or RBAC for apps).
```

---

## 78.7 Real-World Example

```
A photo-sharing app uses Azure Storage:

• User photos → Blob Storage, Hot tier initially, with a Lifecycle rule
  moving photos not accessed in 90 days to Cool, then Archive after a
  year → controls storage cost as content ages.
• Redundancy: GRS (losing users' photos would be serious).
• Access: the app disables public access; to let a user download their
  own photo, it generates a short-lived SAS URL (read-only, 1 hour,
  that specific blob) — no account keys exposed. Apps that need ongoing
  access use a Managed Identity with the "Storage Blob Data Reader" RBAC
  role instead.

Result: scalable, durable, cost-optimized, securely-accessed file storage.
```

---

## 78.8 Interview Q&A

**Q: What's a SAS token and when would you use it?**
> A Shared Access Signature is a time-limited, scoped URL that grants specific access to a storage resource (e.g., read-only access to one blob for 1 hour) without sharing the account keys. You use it to give temporary, limited access — like letting a user download their own file — similar to an S3 pre-signed URL. For ongoing application access, RBAC with a Managed Identity is preferred.

**Q: Explain the Blob Storage access tiers.**
> Hot (frequently accessed — highest storage cost, cheapest access), Cool (infrequent, min 30 days), Cold (rare, min 90 days), and Archive (almost never, min 180 days, retrieval takes hours, cheapest by far). Lifecycle Management automatically moves blobs between tiers as they age to optimize cost.

---

## 78.9 Summary

Azure Storage Accounts provide Blob (files), Files (shares), Queue, and Table storage. Blobs live in Containers, with access tiers (Hot/Cool/Cold/Archive) balancing storage cost against access speed and Lifecycle Management automating tier transitions. Access is granted via Access Keys (master, use sparingly), SAS tokens (time-limited scoped URLs, like S3 pre-signed URLs), or — best — Azure AD/RBAC with Managed Identities. Redundancy (LRS/ZRS/GRS/GZRS) controls how many copies exist. These essentials underpin Terraform state, pipeline artifacts, backups, and more.

---
---

# 79. 🔥 All 10 Integration Flows Consolidated
> 🔴 FULL

---

## 79.1 Why This Section Matters Most

Your checklist stressed this repeatedly: interviewers don't just want you to know individual services — they want you to explain **how services connect and authenticate to each other end-to-end**. This section consolidates the 10 key integration flows into one quick-reference. If you can draw and narrate these, you can handle most scenario-based interview questions. **The unifying theme:** almost every flow is *identity → Entra ID → RBAC → access, with no stored credentials.*

---

## 79.2 Flow 1 — Azure DevOps → Azure

```
Azure Pipeline → Service Connection → Entra ID
   → Service Principal / Workload Identity Federation → RBAC → Azure Resource

"The pipeline authenticates via a Service Connection (ideally WIF, no
secret) that Entra ID verifies, and its RBAC role — scoped narrowly —
determines what it can deploy." (Section 39)
```

## 79.3 Flow 2 — Pipeline → Key Vault

```
Azure Pipeline → Service Connection identity → Entra ID → RBAC
   ("Key Vault Secrets User") → Key Vault → secret (masked in logs)

Via a Key Vault-linked Variable Group or the AzureKeyVault task. (Section 33, 42)
```

## 79.4 Flow 3 — Pipeline → ACR (build & push image)

```
Git → Azure Pipeline → docker build → push to ACR
   (authenticated via the Service Connection / az acr login). (Section 40, 55)
```

## 79.5 Flow 4 — ACR → AKS (pull image)

```
AKS → its Managed Identity (with "AcrPull" RBAC role) → ACR → pulls image
Set up with: az aks update --attach-acr. No stored credentials. (Section 55)
```

## 79.6 Flow 5 — Terraform → Azure

```
Terraform (azurerm provider) → Service Principal / WIF → Entra ID → RBAC
   → creates/updates Azure resources. State in a remote backend (Azure
   Storage) with locking. (Section 50, 51)
```

## 79.7 Flow 6 — AKS Pod → Key Vault

```
AKS Pod → Workload Identity (Managed Identity federated to a K8s service
   account) → Entra ID → RBAC → Key Vault → secret mounted via the
   Secrets Store CSI Driver. No secret in the image/YAML. (Section 33)
```

## 79.8 Flow 7 — Application → Monitoring

```
Application (App Insights SDK) / infrastructure → Azure Monitor
   → Metrics + Logs (Log Analytics) + Traces (App Insights)
   → KQL queries → Alerts → Action Group → notify/remediate. (Sections 66-68)
```

## 79.9 Flow 8 — GitHub → Azure

```
GitHub Actions → OIDC token (scoped to repo/branch) → Entra ID
   (federated credential trust) → RBAC → Azure. No stored secret. (Section 61)
```

## 79.10 Flow 9 — Jenkins → Azure

```
Jenkins → Service Principal (creds in Jenkins Credentials Store, or
   Managed Identity if on an Azure VM) → Entra ID → RBAC
   → deploys to ACR / AKS / VMs / App Service. (Section 62)
```

## 79.11 Flow 10 — Terraform → Azure DevOps (full IaC pipeline)

```
Git (.tf files) → Azure DevOps YAML Pipeline → terraform init → plan
   (reviewed in PR) → APPROVAL GATE → terraform apply → Azure resources.
   Auth via Service Connection; state in remote backend. (Section 53)
```

---

## 79.12 The One Pattern Behind Almost All of Them

```
┌────────────────────────────────────────────────────────────┐
│  IDENTITY  (Service Principal / Managed Identity / Workload  │
│             Identity / WIF)                                  │
│       ↓                                                      │
│  ENTRA ID  (verifies the identity)                          │
│       ↓                                                      │
│  RBAC      (scoped to least privilege — determines access)   │
│       ↓                                                      │
│  THE TARGET (Key Vault / ACR / AKS / Storage / any resource) │
│                                                              │
│  ...with NO stored credentials wherever possible (Managed    │
│  Identity / WIF / OIDC).                                     │
└────────────────────────────────────────────────────────────┘

If you internalize THIS pattern, you can reason through ANY Azure
authentication/integration question — they're all variations of it.
```

---

## 79.13 Interview Q&A

**Q: A pipeline needs to build a container, push it, and deploy it to AKS, pulling a secret from Key Vault. Walk through the auth end-to-end.**
> The pipeline authenticates to Azure via a Service Connection (ideally Workload Identity Federation — no secret), verified by Entra ID with RBAC scoped to the target resource group. It builds the image and pushes it to ACR (Flow 3). It deploys to AKS; AKS pulls the image using its own Managed Identity with the AcrPull role (Flow 4 — no registry credentials). At runtime, the pod fetches the secret from Key Vault using Workload Identity + the Secrets Store CSI Driver (Flow 6 — no secret in the image). Every step uses managed/federated identities and RBAC — no stored credentials anywhere.

**Q: What's the common thread across all Azure integrations?**
> Identity → Entra ID → RBAC → access, with no stored credentials wherever possible (Managed Identity, Workload Identity, or OIDC federation). Whether it's a pipeline, Terraform, GitHub Actions, AKS, or an app reaching Key Vault, they all follow this same pattern — an identity verified by Entra ID, authorized by narrowly-scoped RBAC.

---

## 79.14 Summary

The 10 integration flows — Azure DevOps→Azure, Pipeline→Key Vault, Pipeline→ACR, ACR→AKS, Terraform→Azure, AKS Pod→Key Vault, App→Monitoring, GitHub→Azure, Jenkins→Azure, and Terraform→Azure DevOps — are what interviewers probe most, because they test whether you understand how services actually connect. Nearly all follow one unifying pattern: **an identity (Service Principal/Managed Identity/Workload Identity/WIF) verified by Entra ID, authorized by least-privilege RBAC, accessing a target — with no stored credentials wherever possible.** Master this pattern and you can reason through any integration question.

---
---

# 80. 🎓 Rapid-Fire Interview Q&A
> 🔴 FULL

---

## 80.1 Identity & Access

**Q: Entra ID vs RBAC?**
> Entra ID = authentication (who you are); RBAC = authorization (what you can do). Separate systems that work together.

**Q: Service Principal vs Managed Identity?**
> Both are non-human identities. A Service Principal has credentials you manage (secret/cert); a Managed Identity is fully Azure-managed with no credentials to store or rotate. Prefer Managed Identity.

**Q: System-assigned vs User-assigned Managed Identity?**
> System-assigned is tied to one resource's lifecycle (deleted with it); User-assigned is standalone and shareable across many resources. Use User-assigned for fleets like VM Scale Sets.

**Q: Most secure way for CI/CD to authenticate to Azure?**
> Workload Identity Federation (OIDC) — short-lived tokens via a trust relationship, no stored secret.

**Q: Owner vs Contributor?**
> Both fully manage resources; only Owner can also grant access to others.

## 80.2 Networking

**Q: /24 vs /16 CIDR?**
> /24 = 256 addresses (a subnet); /16 = 65,536 (a VNet). Smaller slash number = bigger range.

**Q: NSG vs Azure Firewall?**
> NSG = basic per-subnet/NIC allow/deny by IP/port. Azure Firewall = centralized, filters by domain name (FQDN), threat intelligence, managed across VNets.

**Q: Service Endpoint vs Private Endpoint?**
> Service Endpoint keeps traffic on the backbone but the service keeps its public IP. Private Endpoint gives the service a private IP inside your VNet (fully private) — use Private Endpoint for strong isolation.

**Q: Is VNet Peering transitive?**
> No — A↔B and B↔C doesn't let A reach C. Need a direct A↔C peering.

**Q: Explain Hub-and-Spoke.**
> A central hub VNet with shared services (firewall, gateway, DNS, Bastion) and multiple spoke VNets (per team/app) peered to it — spokes share the hub's services but are isolated from each other.

**Q: How to troubleshoot "VM can't reach the database"?**
> Network Watcher's IP Flow Verify — it tells you if traffic is allowed/denied and which NSG rule is responsible.

## 80.3 Secrets & Security

**Q: How do you handle secrets?**
> Store in Key Vault, retrieve at runtime via Managed Identity (or Key Vault-linked Variable Group in pipelines), never hardcode. Run secret scanning to catch accidental commits.

**Q: How does an app access Key Vault with no stored credential?**
> Via a Managed Identity — Azure handles the authentication automatically; Key Vault checks the identity's RBAC and returns the secret.

**Q: What is DevSecOps / shift-left?**
> Building security into every pipeline stage (secret/SAST/SCA/container/IaC scanning) so issues are caught early, plus Azure Policy as an infrastructure backstop.

## 80.4 Azure DevOps & CI/CD

**Q: YAML vs Classic pipelines?**
> YAML = pipeline-as-code in the repo (version-controlled, reviewable); Classic = UI-configured. YAML is the modern standard.

**Q: What is a Service Connection?**
> The bridge that lets a pipeline authenticate to Azure — via Entra ID (Service Principal/WIF) with scoped RBAC.

**Q: What is trunk-based development?**
> Everyone commits small, frequent changes to main, using short-lived branches and feature flags to hide incomplete work — minimizes merge conflicts, keeps main releasable.

**Q: What do Branch Policies enforce?**
> Required reviewers, passing CI build (build validation), linked work items, before a PR can merge to a protected branch.

**Q: Explain "build once, deploy many."**
> Build one artifact and promote that exact artifact through Dev→QA→Prod, so production gets precisely what was tested (never rebuild per environment).

**Q: Microsoft-hosted vs self-hosted agents?**
> Microsoft-hosted = managed, fresh VM per run, no private-network access. Self-hosted = your own machine, can reach private resources — the main reason to use it.

## 80.5 Containers

**Q: What's a multi-stage Docker build?**
> A build stage with tools compiles the app; a minimal final stage copies only the artifacts — small, secure image without build tools.

**Q: How does AKS pull from ACR securely?**
> Via the cluster's Managed Identity with the AcrPull role (`az aks update --attach-acr`) — no stored credentials.

**Q: AKS vs EKS key difference?**
> AKS's control plane is free (pay only for nodes); EKS charges for the control plane.

**Q: HPA vs Cluster Autoscaler?**
> HPA scales pods (based on CPU/metrics); Cluster Autoscaler scales nodes (when pods can't be scheduled). They work together.

**Q: What is Helm?**
> The Kubernetes package manager — bundles app YAML into versioned, parameterized Charts; deploy/upgrade/rollback with one command.

## 80.6 Deployment & Observability

**Q: Blue/Green vs Canary?**
> Blue/Green switches 100% of traffic at once (instant rollback via switch-back). Canary shifts traffic gradually (5%→100%), limiting blast radius.

**Q: How do you roll back?**
> Slot swap-back, canary-to-0%, helm rollback, feature-flag-off (all instant), or redeploy the previous artifact.

**Q: Metrics vs logs?**
> Metrics tell you *that* something's wrong (numerical); logs (queried with KQL) tell you *why* (detailed records).

**Q: What is distributed tracing?**
> Following a single request across all microservices it touches to pinpoint where slowness/failure occurred — via Application Insights.

**Q: RTO vs RPO?**
> RTO = how long you can be down (recovery time); RPO = how much data you can lose (recovery point).

**Q: SLI vs SLO vs SLA?**
> SLI = the measurement; SLO = the internal target; SLA = the customer-facing contractual promise (with penalties).

## 80.7 Scenario Questions

**Q: How would you securely deploy a containerized app to AKS via CI/CD?**
> Pipeline (YAML) authenticates via a WIF Service Connection with scoped RBAC → build & test → security scans → build image → push to ACR → deploy to AKS (which pulls via its Managed Identity/AcrPull) → pod gets secrets from Key Vault via Workload Identity → gated by an approval on the production Environment → canary/blue-green rollout → monitored via App Insights. No stored credentials anywhere.

**Q: A production deployment caused errors — what do you do?**
> Mitigate first (roll back via slot-swap/feature-flag-off/canary-to-0%) to restore service, then investigate root cause using metrics, KQL logs, and distributed tracing, resolve, and run a blameless post-mortem.

---

## 80.8 Summary

This rapid-fire set covers the highest-probability interview questions across every topic. Practice saying each answer out loud concisely — interviewers assess whether you can *communicate* clearly, not just recognize the answer. For scenario questions, narrate the end-to-end flow (referencing the integration flows from Section 79), and always emphasize the recurring themes: least-privilege, no stored credentials (Managed Identity/WIF), build-once-deploy-many, mitigate-then-investigate, and defense-in-depth.

---
---

# 81. 📌 Final Quick Reference (Numbers, AWS↔Azure Table, One-Liners)
> 🔴 FULL

---

## 81.1 AWS ↔ Azure Service Map (Your Fast Anchor)

| Category | AWS | Azure |
|---|---|---|
| Identity | IAM | Entra ID + Azure RBAC |
| Non-human identity | IAM Role | Service Principal / Managed Identity |
| CI/CD → cloud auth | IAM OIDC | Workload Identity Federation (OIDC) |
| Virtual server | EC2 | Virtual Machine |
| Autoscaling group | Auto Scaling Group | VM Scale Set (VMSS) |
| Object storage | S3 | Blob Storage |
| Pre-signed URL | S3 pre-signed URL | SAS token |
| Block storage | EBS | Managed Disks |
| Shared file storage | EFS | Azure Files |
| Private network | VPC | Virtual Network (VNet) |
| Firewall (basic) | Security Group + NACL | NSG (does both) |
| Firewall (central) | Network Firewall | Azure Firewall |
| Private service access | PrivateLink / Interface Endpoint | Private Endpoint |
| L4 load balancer | Network Load Balancer | Azure Load Balancer |
| L7 load balancer | Application Load Balancer | Application Gateway |
| DNS | Route 53 | Azure DNS |
| Dedicated connection | Direct Connect | ExpressRoute |
| Site VPN | Site-to-Site VPN | VPN Gateway |
| Secrets | Secrets Manager / KMS | Key Vault |
| SQL database | RDS | Azure SQL Database |
| NoSQL | DynamoDB | Cosmos DB |
| Kubernetes | EKS (paid control plane) | AKS (free control plane) |
| Container registry | ECR | ACR |
| Serverless functions | Lambda | Azure Functions |
| CI/CD suite | CodePipeline/Build/Deploy | Azure DevOps / GitHub Actions |
| IaC (native) | CloudFormation | ARM / Bicep |
| IaC (multi-cloud) | Terraform | Terraform |
| Monitoring | CloudWatch | Azure Monitor |
| Distributed tracing | X-Ray | Application Insights |
| Log querying | CloudWatch Logs Insights | Log Analytics / KQL |
| Security posture | Security Hub | Defender for Cloud |
| SIEM | (GuardDuty + others) | Microsoft Sentinel |
| Cost tools | Cost Explorer + Budgets | Cost Management |
| Governance/policy | Config + SCPs | Azure Policy |
| Landing zone | Control Tower | Azure Landing Zone |

---

## 81.2 Key Numbers to Remember

| Fact | Value |
|---|---|
| CIDR /24 | 256 addresses (a subnet) |
| CIDR /16 | 65,536 addresses (a VNet) |
| Reserved IPs per subnet | 5 (a /24 gives 251 usable) |
| Min Availability Zones (in a zone-enabled region) | 3 |
| NSG rule priority range | 100–4096 (lower = evaluated first) |
| AKS control plane cost | Free (pay only for nodes) |
| Azure SQL PITR backup retention | Up to 35 days |
| Blob durability (GZRS) | Up to 16 nines |
| Spot VM eviction notice | 30 seconds |
| Key Vault soft-delete | Recoverable (default retention) |
| Common ports | 22 SSH, 80 HTTP, 443 HTTPS, 3389 RDP, 1433 SQL |
| Special subnet names | GatewaySubnet, AzureFirewallSubnet, AzureBastionSubnet |

---

## 81.3 "Say This in the Interview" One-Liners

```
Authentication pattern (use for ANY integration question):
  "Identity → Entra ID → RBAC → resource, with no stored credentials
   wherever possible via Managed Identity or Workload Identity Federation."

Secrets:
  "Never hardcode — Key Vault + Managed Identity, retrieved at runtime."

Pipeline auth:
  "Service Connection via Workload Identity Federation — secretless,
   short-lived tokens, least-privilege RBAC scoped to one resource group."

Deployment:
  "Build once, deploy many — promote the same tested artifact through
   Dev→QA→Prod, with an approval gate before production."

Networking security:
  "Defense in depth — private subnets, NSGs per tier, Private Endpoints,
   Bastion for management, Azure Firewall for centralized egress."

Trunk-based development:
  "Small frequent commits to main, short-lived branches, feature flags to
   decouple deploy from release — rollback is a flag flip."

Incident response:
  "Mitigate first to restore service (rollback/flag-off), then investigate
   root cause with metrics, KQL logs, and distributed tracing."

Reliability:
  "Define RTO/RPO and SLOs; use error budgets to balance velocity vs
   stability."

Hub-and-spoke:
  "Central hub for shared services (firewall, gateway, DNS, Bastion),
   isolated spokes per team — centralized security, workload isolation."
```

---

## 81.4 Night-Before Checklist

```
✅ Can you draw the identity → Entra ID → RBAC → resource pattern?
✅ Can you draw a Hub-and-Spoke topology and explain why each piece exists?
✅ Can you walk through a full CI/CD flow: code → build → scan → ACR →
   AKS → Key Vault → approval → canary → monitor?
✅ Can you explain the Pipeline → Service Connection → Azure auth flow?
✅ Can you explain Service Endpoint vs Private Endpoint?
✅ Can you explain NSG (+ ASG) vs Azure Firewall?
✅ Can you explain Blue/Green vs Canary vs Rolling, and rollback for each?
✅ Can you explain how AKS pulls from ACR and how pods get Key Vault secrets?
✅ Can you write a basic KQL query and explain metrics vs logs vs traces?
✅ Can you explain trunk-based development + feature flags?
✅ Can you explain RTO/RPO and SLI/SLO/SLA?
✅ Can you explain how you'd handle a production incident?
✅ Can you relate each Azure service to its AWS equivalent (you know AWS)?
```

---

## 81.5 Final Note

You now have a complete, interview-focused Azure reference covering everything in your JD and the AZ-104/AZ-400 checklist — foundations, identity, deep networking, secrets, Azure DevOps/CI-CD, IaC, containers, GitHub/Jenkins integration, deployment strategies, observability, DevSecOps, AIOps, production cross-cutting concerns, and the 10 integration flows. Since you already know AWS, lean on the relate-notes as anchors, but make sure you can explain each concept on its own terms. The single most valuable thing you can internalize is the recurring **identity → Entra ID → RBAC → resource (no stored credentials)** pattern — it unlocks most integration/authentication questions. Focus your final review on the 🔴 FULL sections and the integration flows (Section 79). Good luck!

---
