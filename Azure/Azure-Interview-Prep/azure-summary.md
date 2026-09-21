# ⚡ Azure Interview Summary — Senior DevOps (Endava) — Quick Revision

> **Companion to the full notes.** Feature-complete but condensed — scanning this should trigger the full memory from the main notes.
> **Each topic:** What it is → flow diagram → all key features → UI path → rapid interview Q&A → 💡 AWS anchor.
> **Tiers:** 🔴 Full · 🟠 Medium · 🟡 Know-this-much

---

# 📋 TABLE OF CONTENTS

### 🌱 Foundations
1. [Azure Hierarchy (Mgmt Groups, Subscriptions, RGs)](#1--azure-hierarchy-)
2. [Azure Resource Manager (ARM)](#2--azure-resource-manager-arm-)

### 🔐 Identity & Access
3. [Microsoft Entra ID](#3--microsoft-entra-id-)
4. [Azure RBAC](#4--azure-rbac-)
5. [Service Principals](#5--service-principals-)
6. [Managed Identities](#6--managed-identities-)
7. [Workload Identity Federation (WIF) / OIDC](#7--workload-identity-federation-wif--oidc-)
8. [Conditional Access & PIM](#8--conditional-access--pim-)

### 🌐 Networking
9. [Networking Fundamentals (IP, CIDR, Ports)](#9--networking-fundamentals-)
10. [Virtual Network (VNet)](#10--virtual-network-vnet-)
11. [Subnets](#11--subnets-)
12. [Network Security Groups (NSG)](#12--network-security-groups-nsg-)
13. [Application Security Groups (ASG)](#13--application-security-groups-asg-)
14. [Route Tables / UDR](#14--route-tables--udr-)
15. [Service Endpoints](#15--service-endpoints-)
16. [Private Endpoints](#16--private-endpoints-)
17. [VNet Peering](#17--vnet-peering-)
18. [Hub-and-Spoke Topology](#18--hub-and-spoke-topology-)
19. [Azure Virtual WAN](#19--azure-virtual-wan-)
20. [NAT Gateway](#20--nat-gateway-)
21. [Azure DNS — Public Zones](#21--azure-dns--public-zones-)
22. [Azure DNS — Private Zones](#22--azure-dns--private-zones-)
23. [Azure Load Balancer](#23--azure-load-balancer-)
24. [Application Gateway](#24--application-gateway-)
25. [Web Application Firewall (WAF)](#25--web-application-firewall-waf-)
26. [Azure Firewall](#26--azure-firewall-)
27. [DDoS Protection](#27--ddos-protection-)
28. [Network Watcher](#28--network-watcher-)
29. [Connection Monitor](#29--connection-monitor-)
30. [VPN Gateway](#30--vpn-gateway-)
31. [ExpressRoute](#31--expressroute-)

### 🔑 Secrets
32. [Azure Key Vault](#32--azure-key-vault-)
33. [Key Vault Integrations (Pipelines, AKS, ACR)](#33--key-vault-integrations-)

### 🛠️ Azure DevOps & CI/CD
34. [Azure DevOps Overview](#34--azure-devops-overview-)
35. [Azure DevOps Permissions & Security](#35--azure-devops-permissions--security-)
36. [Git Branching Strategies](#36--git-branching-strategies-)
37. [Branch Policies & Branch Protection](#37--branch-policies--branch-protection-)
38. [Pull Request Workflow & Code Reviews](#38--pull-request-workflow--code-reviews-)
39. [Service Connections](#39--service-connections-)
40. [Azure Pipelines — YAML](#40--azure-pipelines--yaml-)
41. [Multi-Stage Pipeline Design](#41--multi-stage-pipeline-design-)
42. [Pipeline Variables, Groups & Templates](#42--pipeline-variables-groups--templates-)
43. [Pipeline Caching & Artifacts](#43--pipeline-caching--artifacts-)
44. [Azure DevOps Agents](#44--azure-devops-agents-)
45. [Environments](#45--environments-)
46. [Approvals & Checks / Release Gates](#46--approvals--checks--release-gates-)
47. [Azure Boards ↔ Repos/GitHub Traceability](#47--azure-boards--reposgithub-traceability-)

### 🏗️ Infrastructure as Code
48. [ARM Templates](#48--arm-templates-)
49. [Bicep](#49--bicep-)
50. [Terraform + Azure DevOps](#50--terraform--azure-devops-)
51. [Terraform State Locking & Remote Backend](#51--terraform-state-locking--remote-backend-)
52. [Terraform Modules & Reusability](#52--terraform-modules--reusability-)
53. [IaC in CI/CD with Plan Approval Gates](#53--iac-in-cicd-with-plan-approval-gates-)

### 📦 Containers
54. [Dockerfile Best Practices & Multi-Stage Builds](#54--dockerfile-best-practices--multi-stage-builds-)
55. [Azure Container Registry (ACR)](#55--azure-container-registry-acr-)
56. [Azure Kubernetes Service (AKS)](#56--azure-kubernetes-service-aks-)
57. [AKS Ingress Controllers](#57--aks-ingress-controllers-)
58. [AKS Persistent Volumes & Storage](#58--aks-persistent-volumes--storage-)
59. [Helm](#59--helm-)
60. [AKS Autoscaling (Cluster Autoscaler + HPA)](#60--aks-autoscaling-cluster-autoscaler--hpa-)

### 🔁 Integrations
61. [GitHub → Azure](#61--github--azure-)
62. [Jenkins → Azure](#62--jenkins--azure-)

### 🚀 Deployment & Observability
63. [Deployment — Blue/Green](#63--deployment--bluegreen-)
64. [Deployment — Canary, Rolling & Rollback](#64--deployment--canary-rolling--rollback-)
65. [Feature Flags & Azure App Configuration](#65--feature-flags--azure-app-configuration-)
66. [Azure Monitor & Metrics](#66--azure-monitor--metrics-)
67. [Log Analytics & KQL Basics](#67--log-analytics--kql-basics-)
68. [Application Insights & Distributed Tracing](#68--application-insights--distributed-tracing-)
69. [Alerting Strategy & Incident Response](#69--alerting-strategy--incident-response-)
70. [SLI / SLO / SLA & Error Budgets](#70--sli--slo--sla--error-budgets-)
71. [DevSecOps](#71--devsecops-)
72. [AI-Assisted DevOps (AIOps)](#72--ai-assisted-devops-aiops-)

### 🔥 Production Cross-Cutting
73. [Tagging & Naming Conventions](#73--tagging--naming-conventions-)
74. [Azure Landing Zones](#74--azure-landing-zones-)
75. [Cost Management & FinOps](#75--cost-management--finops-basics-)
76. [Disaster Recovery & Backup (RTO/RPO)](#76--disaster-recovery--backup-rtorpo-)

### 🎓 Interview Prep
77. [Compute Essentials](#77--compute-essentials-)
78. [Storage Essentials](#78--storage-essentials-)
79. [All 10 Integration Flows](#79--all-10-integration-flows-)
80. [Rapid-Fire Interview Q&A](#80--rapid-fire-interview-qa-)
81. [Final Quick Reference](#81--final-quick-reference-)

---

# 1. 🏢 Azure Hierarchy `🟠`

**What:** How Azure organizes everything, top to bottom.
```
Management Group  (governs many subscriptions — policy/RBAC cascades down)
   └── Subscription  (billing + access + quota boundary)
        └── Resource Group  (logical folder; delete it = delete all inside)
             └── Resource  (VM, VNet, Storage...)
```
**Key facts:** A resource → 1 RG; RG → 1 subscription; deleting an RG deletes everything in it; resources in an RG can be in different regions; policy/RBAC set high cascades down. Orgs use separate subscriptions per env (Prod/Dev/Test) for clean billing & access separation.
**UI:** `portal → Resource groups → + Create → sub + name + region`
**🎯 Q&A:** *Subscription vs Resource Group?* → Subscription = billing/access/quota boundary (separate per env); RG = folder grouping an app's resources for shared management/deletion. *Why multiple subs?* → separate billing, access, and quota limits.
**💡 AWS:** Management Group ≈ Organizations OU · Subscription ≈ Account · RG ≈ (no exact equal, ~tag grouping).

---

# 2. ⚙️ Azure Resource Manager (ARM) `🟠`

**What:** The management layer *everything* goes through — Portal, CLI, PowerShell, Bicep, Terraform all hit ARM.
```
Portal/CLI/PowerShell/Bicep/Terraform → ARM (auth via RBAC, validate, order deps) → Resource Providers (Microsoft.Compute/Storage/Network...)
```
**Key facts:** **Resource Providers** = service namespaces (`Microsoft.Compute`); **Resource ID** = path-like unique ID; **declarative** = describe end-state, ARM handles how/order; **Tags** = key-value labels. Consistent RBAC/behavior regardless of tool.
**UI:** any resource → `Automation → Export template` shows its ARM JSON.
**🎯 Q&A:** *What is ARM?* → the layer all Azure interactions go through; applies uniform auth/validation/dependency-handling via Resource Providers. *Declarative meaning?* → describe desired state, ARM figures out the how.
**💡 AWS:** ARM ≈ AWS control plane + CloudFormation engine combined.

---

# 3. 🔐 Microsoft Entra ID `🔴`

**What:** Azure's cloud identity service = **authentication** ("who are you?"). Separate from RBAC = authorization.
```
Login (user+pass+MFA) → Entra ID confirms identity → [then RBAC decides what you can do]
```
**Key features:** **Tenant** (org's identity boundary); **Users** (cloud-only or synced from on-prem AD via Azure AD Connect); **Groups** (Security = access control, M365 = collaboration; Assigned or Dynamic membership); **Service Principals** (app identities); **MFA**; **Conditional Access** (context-aware rules); **PIM** (just-in-time admin); **Identity Protection** (risky sign-in ML detection); **App Registrations**; **SSO**.
**UI:** `portal → Microsoft Entra ID → Users/Groups → + New`; MFA via `Security → Conditional Access → New policy → require MFA`.
**🎯 Q&A:** *Entra ID vs RBAC?* → authentication (who) vs authorization (what). *Security vs M365 group?* → access control vs collaboration. *Why groups for access?* → scalable, safe (add/remove = grant/revoke instantly). *Secure admin accounts?* → MFA + minimize Global Admins + PIM.
**💡 AWS:** Entra ID ≈ IAM identities + AWS SSO/Identity Center + a directory service. (Azure splits auth/authz; AWS IAM does both.)

---

# 4. 🗝️ Azure RBAC `🔴`

**What:** Authorization = *what* an identity can do.
```
Role Assignment = WHO (user/group/SP/MI) + ROLE (permission bundle) + SCOPE (Mgmt Group/Sub/RG/Resource)
   → cascades DOWN from the scope
```
**Core roles:** **Owner** (full + can grant access), **Contributor** (full resource mgmt, CANNOT grant access), **Reader** (view only). **Custom roles** for precise needs. Always **least privilege** — scope to one RG, weakest sufficient role, assign to groups.
**UI:** any scope → `Access control (IAM) → + Add role assignment → role → member/group → assign`. (⭐ "IAM" blade = where all RBAC happens, on every scope.)
**🎯 Q&A:** *Owner vs Contributor?* → both manage resources; only Owner grants access to others. *Least privilege?* → narrow scope + weakest role + assign to groups. *Where manage RBAC?* → Access control (IAM) blade.
**💡 AWS:** RBAC ≈ IAM policies/roles (role+scope model vs JSON policy docs).

---

# 5. 🤖 Service Principals `🔴`

**What:** A non-human identity (for apps/scripts/pipelines) that authenticates and gets RBAC.
```
App Registration (global app definition) → Service Principal (its instance in a tenant, gets RBAC)
App/Pipeline → presents App ID + (secret/cert/OIDC token) → Entra ID → token → acts (limited by RBAC)
```
**Auth methods:** Client Secret (⚠️ expires/can leak), Certificate (better), **Federated Credential/WIF/OIDC** (best — no secret). Scope RBAC narrowly; store creds securely, never in code.
**UI:** `Entra ID → App registrations → New registration` → `Certificates & secrets → New client secret` (⚠️ copy value once!) → grant RBAC on target RG. CLI: `az ad sp create-for-rbac --role Contributor --scopes /...`
**🎯 Q&A:** *What/when?* → non-human identity for automation needing Azure access. *App Reg vs SP?* → global definition vs local tenant instance (SP gets RBAC). *Most secure auth?* → WIF/OIDC (no stored secret). *Why secrets risky?* → leak + rotation burden.
**💡 AWS:** ≈ IAM role assumed by an app / IAM user access keys used programmatically.

---

# 6. 🆔 Managed Identities `🔴`

**What:** A fully Azure-managed Service Principal — **no credentials to store or rotate**. Best practice for service-to-service auth.
```
Resource (VM/Function/App) → asks Azure metadata endpoint (169.254.169.254) → gets short-lived token → accesses target (Key Vault etc.) via RBAC. No secret anywhere.
```
**Two types:** **System-assigned** (tied to 1 resource's lifecycle, deleted with it, 1:1) · **User-assigned** (standalone, shared across many resources, survives independently — use for fleets like VMSS).
**UI:** VM → `Security → Identity → System assigned → On → Save` → `Azure role assignments → + Add`. User-assigned: create as its own resource, then attach.
**🎯 Q&A:** *Why better than SP secret?* → no credential to store/rotate/leak; Azure manages it. *System vs User-assigned?* → tied-to-one-resource vs standalone/shareable (User for VMSS/fleets). *How gets token w/o secret?* → from the instance metadata endpoint, only reachable inside the resource.
**💡 AWS:** ≈ IAM role attached to EC2/Lambda (instance profile).

---

# 7. 🔗 Workload Identity Federation (WIF) / OIDC `🔴`

**What:** Lets workloads *outside* Azure (GitHub Actions, Jenkins, external CI/CD) auth to Azure with **no stored secret** — short-lived tokens via a trust relationship.
```
Setup: Entra ID SP gets a Federated Credential trusting an OIDC issuer (e.g. GitHub) for a specific repo/branch.
Run: external system's OIDC token → Entra ID checks trust → issues short-lived Azure token → deploy. No secret.
```
**Key facts:** trust scoped to a specific repo/branch/environment; tokens are short-lived (minutes); nothing to leak or rotate. **Modern best practice** for CI/CD auth.
**UI:** `Entra ID → App registrations → your app → Certificates & secrets → Federated credentials → + Add → GitHub Actions scenario → org/repo/branch → Add` → grant RBAC.
**🎯 Q&A:** *What/why?* → external workload auth via short-lived OIDC tokens, no stored secret — eliminates leak/rotate risk. *How trust works?* → federated credential trusts an OIDC issuer scoped to a repo/branch; token verified at runtime. *More secure than SP secret?* → yes: no long-lived secret, short-lived tokens, scoped trust.
**💡 AWS:** Identical to GitHub Actions → AWS via OIDC (IAM OIDC provider).

---

# 8. 🛂 Conditional Access & PIM `🟡`

**What:** Smart, risk-aware access (Conditional Access) + just-in-time admin (PIM).
```
Conditional Access: sign-in → evaluate signals (user/location/device/risk) → Grant / Require MFA / Require compliant device / Block
PIM: user is ELIGIBLE (not active) for admin → activates on-demand (MFA + justification + approval + time-limited) → auto-expires
```
**Key facts:** CA = context-aware policies (e.g., MFA only off-network, block risky countries). PIM = no standing admin rights → activated just-in-time, time-limited, audited → limits damage if account compromised.
**UI:** CA: `Entra ID → Security → Conditional Access → New policy`. PIM: `Privileged Identity Management → Entra roles → assign as Eligible`.
**🎯 Q&A:** *Conditional Access?* → policy engine making access decisions on signals (user/location/device/risk) — require MFA, compliant device, or block. *PIM problem solved?* → eliminates permanent standing admin; roles activated just-in-time, time-limited, audited.
**💡 AWS:** CA ≈ IAM condition keys + smarter engine; PIM ≈ automated temporary-role-assumption.

---

# 9. 🌐 Networking Fundamentals `🟠`

**What:** IP, CIDR, ports — the building blocks.
**Key facts:**
- **Public IP** = internet-reachable; **Private IP** = internal only (give public only when truly needed).
- **CIDR:** smaller /number = BIGGER range. `/24`=256 addrs (a subnet), `/16`=65,536 (a VNet).
- **Ports:** 22 SSH, 80 HTTP, 443 HTTPS, 3389 RDP, 1433 SQL. (Never expose 22/3389 to the internet.)
- **IP = which machine; Port = which service on it.**
**🎯 Q&A:** */24 vs /16?* → 256 vs 65,536 addresses; smaller slash = bigger range. *Public vs private IP?* → internet-reachable vs internal-only. *SQL port?* → 1433 (allow only from app tier).
**💡 AWS:** Identical concepts — same as VPC CIDR/ports.

---

# 10. 🔷 Virtual Network (VNet) `🔴`

**What:** Your private, isolated network in Azure.
```
VNet (10.0.0.0/16) → subnets (web/app/db) → resources communicate privately by default (subject to NSGs)
                                          → internet only if a resource has a Public IP
```
**Key facts:** lives in 1 region, 1 subscription; resources in same VNet talk privately by default; address spaces must NOT overlap (for peering); can add more address spaces later. **No Internet Gateway resource** (public IP = internet access). Subnets **not zone-bound** (unlike AWS).
**UI:** `portal → Virtual networks → + Create → address space + subnets`.
**🎯 Q&A:** *What is a VNet?* → private isolated network; you control IP space/subnets/routing/security. *Need an Internet Gateway?* → no — a Public IP is enough (differs from AWS). *Can VNet resources talk by default?* → yes, subject to NSGs.
**💡 AWS:** VNet ≈ VPC (but no IGW resource; subnets not AZ-bound).

---

# 11. 🧩 Subnets `🔴`

**What:** Slices of a VNet, each isolatable with its own NSG.
```
VNet 10.0.0.0/16 → web-subnet /24 · app-subnet /24 · db-subnet /24 (each = a tier, own NSG)
```
**Key facts:** **5 IPs reserved per subnet** (a /24 = 251 usable); subnets NOT zone-bound; **special subnets need exact names**: `GatewaySubnet` (VPN/ER gateway), `AzureFirewallSubnet`, `AzureBastionSubnet`. Isolate tiers = defense in depth.
**UI:** VNet → `Subnets → + Subnet → name + range + (attach NSG/route table)`.
**🎯 Q&A:** *Why subnets not one flat network?* → security/isolation (per-tier NSGs = defense in depth). *Usable IPs in /24?* → 251 (5 reserved). *AzureBastionSubnet?* → services needing an exact-named dedicated subnet.
**💡 AWS:** ≈ subnets, but not tied to one AZ.

---

# 12. 🛡️ Network Security Groups (NSG) `🔴`

**What:** Azure's virtual firewall — prioritized allow/deny rules, in/outbound.
```
Packet → rules checked by PRIORITY (lowest first) → first match wins → default hidden "Deny all inbound" at bottom
```
**Key facts:** **stateful** (allowed inbound → response auto-allowed); supports **allow AND deny**; attaches at **subnet AND NIC level** (both must pass); rule = priority/direction/source/dest/port/protocol/action; use **Service Tags** (`Internet`, `VirtualNetwork`, `AzureLoadBalancer`) instead of raw IPs. ⚠️ never allow port 22/3389 from `Any`.
**UI:** `portal → Network security groups → + Create → Inbound rules → + Add → Subnets → Associate`.
**🎯 Q&A:** *Which rule wins?* → lowest priority number, first match; default deny-all inbound. *Stateful?* → return traffic auto-allowed. *Subnet + NIC both?* → traffic must pass both.
**💡 AWS:** ≈ Security Groups + NACLs combined (allow AND deny, both levels).

---

# 13. 🏷️ Application Security Groups (ASG) `🟠`

**What:** Group VMs by *role* to reference in NSG rules instead of brittle IP lists — essential with autoscaling.
```
ASG "web-servers" + ASG "db-servers" → NSG rule: allow web-servers → db-servers on 1433
New autoscaled VM → just add to ASG → rule applies automatically (no rule edits)
```
**Key facts:** always used *inside* NSG rules (as source/dest); solves the "IPs constantly change with autoscaling" problem.
**UI:** `Application security groups → + Create` → add VM NICs to it → reference the ASG in an NSG rule.
**🎯 Q&A:** *NSG vs ASG?* → NSG = the firewall rules; ASG = logical VM grouping by role referenced *in* rules. *Why important with VMSS?* → rules stay correct as VMs come/go (new VMs just join the ASG).
**💡 AWS:** ≈ referencing another Security Group as a source.

---

# 14. 🧭 Route Tables / UDR `🟠`

**What:** Override default routing — commonly to force traffic through a firewall.
```
UDR on app-subnet: 0.0.0.0/0 → Next hop = Azure Firewall's IP → all outbound inspected first
```
**Key facts:** route = address prefix + next hop type (Virtual Appliance/Internet/VNet/Peering); `0.0.0.0/0` = everything; most specific route wins; attach to subnets. Deploying a firewall alone doesn't route through it — **the UDR does**.
**UI:** `Route tables → + Create → Routes → + Add (0.0.0.0/0 → appliance IP) → Subnets → Associate`.
**🎯 Q&A:** *UDR use?* → override default routing, e.g. force outbound through a firewall (0.0.0.0/0 → firewall IP). *Why needed with a firewall?* → the firewall only inspects traffic the UDR routes to it.
**💡 AWS:** ≈ VPC Route Tables.

---

# 15. 🔌 Service Endpoints `🟠`

**What:** Extend VNet identity to an Azure PaaS service over the backbone + lock the service to your VNet — BUT the service keeps its **public IP**.
```
VM → backbone → Storage; Storage firewall = "only allow web-subnet" (rejects elsewhere), but still a public endpoint
```
**Key facts:** free; traffic on backbone; service firewall restricts access; **does NOT work from on-premises**; service still has a public IP. For full private-IP isolation → Private Endpoint.
**UI:** VNet subnet → `Service endpoints → add Microsoft.Storage` → Storage → `Networking → allow only that VNet/subnet`.
**🎯 Q&A:** *Service vs Private Endpoint?* → Service = backbone + firewall restriction but public IP remains; Private = actual private IP in your VNet, fully private, works on-prem. *Cost?* → Service Endpoint is free.
**💡 AWS:** loosely ≈ Gateway VPC Endpoint (lighter than PrivateLink).

---

# 16. 🔒 Private Endpoints `🔴`

**What:** Gives an Azure PaaS service a **private IP inside your VNet** — fully private, no public exposure. ⭐ interview topic.
```
VM → private IP (10.0.1.20) → Private Endpoint → Storage/SQL/Key Vault (public endpoint can be fully DISABLED)
Private DNS Zone makes the service's NORMAL hostname resolve to the private IP → no app code change
```
**Key facts:** uses Azure Private Link; **needs a Private DNS Zone** so the normal name resolves to the private IP; works from on-premises (VPN/ExpressRoute); has an hourly cost. Strongest isolation → use for enterprise/regulated workloads.
**UI:** Storage/SQL → `Networking → Private endpoint connections → + Private endpoint → VNet/subnet → integrate private DNS: Yes` → then disable public access.
**🎯 Q&A:** *What is it?* → PaaS service gets a private IP in your VNet, no public exposure, via Private Link + Private DNS. *vs Service Endpoint?* → Private = actual private IP + can disable public + works on-prem; Service = public IP remains. *Why Private DNS?* → resolves the normal hostname to the private IP so apps need no change.
**💡 AWS:** ≈ Interface Endpoint / PrivateLink.

---

# 17. 🔗 VNet Peering `🟠`

**What:** Privately connect two VNets over Microsoft's backbone.
```
VNet-A ↔ VNet-B (private IPs, backbone). ⚠️ NOT transitive: A↔B + B↔C ≠ A→C.
```
**Key facts:** address spaces must NOT overlap; **not transitive** (no hopping); works same/cross-region (Global) and cross-subscription/tenant; both sides must be established. Basis of Hub-and-Spoke.
**UI:** VNet-A → `Peerings → + Add` (creates both directions if you have access).
**🎯 Q&A:** *What is it?* → connects VNets for private-IP comms over the backbone. *Transitive?* → NO — need a direct peering between any two that must talk. *Requirement?* → non-overlapping address spaces.
**💡 AWS:** ≈ VPC Peering (same non-transitive limitation).

---

# 18. 🎯 Hub-and-Spoke Topology `🔴`

**What:** The standard enterprise network design — central hub for shared services, isolated spokes for workloads. (Draw this in the interview.)
```
              HUB VNet (shared: Firewall, VPN/ER Gateway, DNS, Bastion, monitoring)
              ↙ peering        ↘ peering
   SPOKE 1 (Team A app)   SPOKE 2 (Team B app)   ← isolated from each other (peering not transitive)
```
**Key facts:** shared/expensive services live ONCE in the hub; spokes peer to hub but not each other (isolation); spoke-to-spoke or internet traffic routed through the hub firewall via UDRs; add a new team = add a spoke. Centralized security + workload isolation + cost efficiency.
**UI:** create hub VNet (with AzureFirewall/Gateway/Bastion subnets) + spoke VNets (non-overlapping) → peer each spoke↔hub → deploy shared services in hub → UDRs in spokes → hub firewall.
**🎯 Q&A:** *Explain hub-and-spoke.* → central hub with shared services, spokes per team/app peered to it, spokes isolated from each other. *How do spokes reach each other/internet?* → UDR routing through the hub firewall (peering isn't transitive). *Why over one big VNet?* → isolation + centralized shared services + consistent security.
**💡 AWS:** ≈ Transit Gateway / shared-services VPC design.

---

# 19. 🌐 Azure Virtual WAN `🟡`

**What:** Managed, automated global connectivity — "hub-and-spoke on autopilot at global scale."
```
Virtual WAN → Virtual Hubs (per region, auto-interconnected) → connect VNets, branch offices (VPN/SD-WAN), ExpressRoute
```
**Key facts:** Microsoft manages the complex routing; connects many sites/VNets/regions. Use when many offices/regions make manual hub-and-spoke too complex; for small setups, plain peering is simpler.
**UI:** `Virtual WANs → + Create → add Hubs → connect VNets/VPN/ER`.
**🎯 Q&A:** *What/when?* → managed global connectivity across many VNets/offices/regions; use when manual hub-and-spoke gets too complex.
**💡 AWS:** ≈ Transit Gateway (with inter-region peering).

---

# 20. 🚪 NAT Gateway `🟡`

**What:** Outbound-only internet for private-subnet resources.
```
Private VMs (private IPs) → NAT Gateway (static public IP) → Internet. Internet CANNOT initiate back in.
```
**Key facts:** outbound only; VMs stay private; provides a predictable static outbound IP (good for third-party API allow-listing); in Azure it attaches directly to a subnet (no manual route entry needed).
**UI:** `NAT gateways → + Create → public IP → Subnet tab → select private subnet`.
**🎯 Q&A:** *Use?* → outbound-only internet for private resources (updates, external APIs) while staying unreachable inbound; static IP for allow-listing. *vs AWS?* → attaches directly to the subnet, no route table entry needed.
**💡 AWS:** ≈ NAT Gateway.

---

# 21. 🌍 Azure DNS — Public Zones `🟡`

**What:** Hosts your domain's public DNS records (does NOT register domains).
```
Own domain (bought elsewhere) → create Public DNS Zone → delegate to Azure's 4 name servers → records resolve
```
**Key facts:** Azure DNS hosts records but doesn't sell domains (differs from Route 53); records A/CNAME/MX/TXT; use **Alias records** (not CNAME) for root domain → Azure resource (works at apex, auto-tracks IP).
**UI:** `DNS zones → + Create → copy 4 name servers → update at registrar → + Record set`.
**🎯 Q&A:** *Registers domains?* → No — hosts records only; register elsewhere and delegate. *Alias vs CNAME?* → Alias works at the root/apex and auto-tracks Azure resource IPs.
**💡 AWS:** ≈ Route 53 hosting (Route 53 also registers domains).

---

# 22. 🏠 Azure DNS — Private Zones `🟠`

**What:** Internal name resolution within your VNets (invisible to internet).
```
VNet linked to Private Zone "internal.myapp.com" → db.internal.myapp.com resolves to 10.0.3.8 (private)
```
**Key facts:** friendly internal names → private IPs, only inside linked VNets; **#1 use = making Private Endpoint hostnames resolve to their private IPs automatically** (so apps need no code change); update one record if an IP changes.
**UI:** `Private DNS zones → + Create → Virtual network links → + Add → + Record set`.
**🎯 Q&A:** *Use?* → internal-only name resolution; clean service discovery. *Relation to Private Endpoints?* → makes the service's normal hostname resolve to its private IP automatically (no app change).
**💡 AWS:** ≈ Route 53 Private Hosted Zones.

---

# 23. ⚖️ Azure Load Balancer `🟠`

**What:** Layer 4 (TCP/UDP) traffic distribution across healthy backends.
```
Customers → Load Balancer → [health-probed backends] → only HEALTHY VMs get traffic
```
**Key facts:** L4 (IP/port only, no content routing — fast); Public or Internal; **health probes** remove unhealthy VMs automatically; backend pool auto-syncs with VMSS; use **Standard SKU** for prod (zones, secure defaults).
**UI:** `Load balancers → + Create (Standard) → frontend IP + backend pool + health probe + LB rule`.
**🎯 Q&A:** *What layer?* → L4 (IP/port, no content awareness — fast). *How HA?* → health probes route only to healthy backends. *Public vs Internal?* → internet-facing vs internal tier-to-tier.
**💡 AWS:** ≈ Network Load Balancer (NLB).

---

# 24. 🚪 Application Gateway `🟠`

**What:** Layer 7 (HTTP/HTTPS-aware) load balancer — routes by request content.
```
Customers → App Gateway (reads URL/host) → /api/* → API pool · /images/* → static pool · /* → web pool
```
**Key facts:** **path-based** + **host-based (multi-site)** routing; **SSL/TLS termination** (offload from backends); optional built-in **WAF**; v2 SKU autoscales; cookie session affinity.
**UI:** `Application gateways → + Create (WAF_v2 or Standard_v2) → backends + listener + path rules`.
**🎯 Q&A:** *Load Balancer vs App Gateway?* → L4 IP/port vs L7 content-aware (path/host routing, SSL, WAF). *SSL termination?* → gateway decrypts HTTPS, offloading backends. *Path-based routing?* → route by URL path to different backend pools.
**💡 AWS:** ≈ Application Load Balancer (ALB).

---

# 25. 🛡️ Web Application Firewall (WAF) `🟡`

**What:** Blocks common web attacks (SQLi, XSS) before they reach your app. Attaches to App Gateway or Front Door.
```
Attacker request → WAF inspects vs OWASP Core Rule Set → malicious? BLOCKED. Clean? passes through.
```
**Key facts:** uses industry-standard OWASP rules; **Detection mode** (log only, for tuning) vs **Prevention mode** (block, for prod); supports custom rules (e.g., rate-limit >1000 req/min).
**UI:** App Gateway tier = `WAF V2` + attach a WAF Policy (Prevention mode, OWASP rules).
**🎯 Q&A:** *What/where?* → blocks SQLi/XSS etc. via OWASP rules; on App Gateway (regional) or Front Door (global). *Detection vs Prevention?* → log-only (tuning) vs actively block (prod).
**💡 AWS:** ≈ AWS WAF.

---

# 26. 🔥 Azure Firewall `🟠`

**What:** Centralized, managed network firewall — smarter than NSGs.
```
Spoke traffic → (via UDR) → Azure Firewall in hub → allow only *.approved.com, block known-bad IPs, log all → Internet
```
**Key facts:** filters by **domain name (FQDN)** not just IP/port; **threat intelligence** (auto-blocks known-malicious IPs); centrally managed across VNets; needs `AzureFirewallSubnet`; forced via UDR. Common use = controlled/audited outbound egress.
**UI:** create `AzureFirewallSubnet` → `Firewalls → + Create` → add Application/Network rules → UDR (0.0.0.0/0 → firewall) on spokes.
**🎯 Q&A:** *vs NSG?* → NSG = basic IP/port per-subnet; Firewall = central, FQDN filtering, threat intel, cross-VNet. *How force traffic through it?* → UDR 0.0.0.0/0 → firewall IP.
**💡 AWS:** ≈ AWS Network Firewall.

---

# 27. 🛡️ DDoS Protection `🟡`

**What:** Detects & mitigates DDoS traffic floods, keeping your app available.
```
Botnet flood → Azure DDoS Protection detects abnormal pattern → scrubs attack traffic → real traffic passes
```
**Key facts:** **Basic** tier = free, always-on for all resources; **Network Protection (paid)** = tuned mitigation, attack analytics, cost protection, expert support. Worth it for high-value public apps.
**UI:** `DDoS protection plans → + Create → associate with VNet` (Basic needs no setup).
**🎯 Q&A:** *What/tiers?* → detects & scrubs DDoS floods; Basic free/always-on, paid tier adds tuned mitigation + analytics + cost protection.
**💡 AWS:** ≈ AWS Shield (Standard/Advanced ≈ Basic/Network Protection).

---

# 28. 🔍 Network Watcher `🟡`

**What:** Network troubleshooting toolkit — key tool is **IP Flow Verify**.
```
IP Flow Verify: source + dest + port → "Allowed" or "Denied by NSG rule X" → instant root cause
```
**Key facts:** tools = IP Flow Verify, Effective Security Rules, Next Hop (routing check), Connection Troubleshoot (live test), NSG Flow Logs, Packet Capture. Directly relevant to JD's "troubleshoot end-to-end."
**UI:** `Network Watcher → IP flow verify → VM + direction + IP:port → Check`.
**🎯 Q&A:** *"VM can't reach DB" — how troubleshoot?* → IP Flow Verify → tells you allowed/denied + which NSG rule; then Next Hop for routing, Connection Troubleshoot for a live test.
**💡 AWS:** ≈ VPC Reachability Analyzer + Flow Logs.

---

# 29. 📡 Connection Monitor `🟡`

**What:** Continuous connectivity monitoring over time (vs IP Flow Verify's one-time check).
```
Source → tests every 30s → Destination: measures reachability/latency/packet loss → alerts on degradation
```
**Key facts:** proactive; watches critical links (e.g., app→payment gateway) and alerts the moment they degrade — often before users notice.
**UI:** `Network Watcher → Connection monitor → + Create → source + dest + frequency + alert thresholds`.
**🎯 Q&A:** *IP Flow Verify vs Connection Monitor?* → one-time allowed/denied check vs continuous reachability/latency/loss monitoring with proactive alerts.
**💡 AWS:** ≈ ongoing reachability/network health monitoring.

---

# 30. 🔐 VPN Gateway `🟡`

**What:** Encrypted tunnel over the public internet connecting on-prem/remote users to an Azure VNet.
```
On-prem network ⇄ (encrypted VPN over internet) ⇄ Azure VNet (VPN Gateway in "GatewaySubnet")
```
**Key facts:** **Site-to-Site** (whole office/datacenter) vs **Point-to-Site** (single laptop/remote worker); needs `GatewaySubnet`; runs over public internet (encrypted, but variable perf) — cheaper/quicker than ExpressRoute; often used as ExpressRoute's backup.
**UI:** create `GatewaySubnet` → `Virtual network gateways → + Create (VPN)` → Local network gateway + Connection.
**🎯 Q&A:** *S2S vs P2S?* → whole network vs single device. *VPN vs ExpressRoute?* → VPN cheaper/quicker but public-internet path; ExpressRoute dedicated/private/consistent but pricier.
**💡 AWS:** ≈ Site-to-Site VPN / Virtual Private Gateway.

---

# 31. 🔌 ExpressRoute `🟡`

**What:** Dedicated PRIVATE connection to Azure, bypassing the public internet entirely.
```
On-prem ⇄ (dedicated private fiber via connectivity provider) ⇄ Azure — never touches public internet
```
**Key facts:** consistent low latency, high bandwidth (up to 100 Gbps); needed for compliance (data off public internet); provisioned via a connectivity provider (physical circuit); often paired with a VPN Gateway as backup; Global Reach connects on-prem sites through the backbone.
**UI:** `ExpressRoute circuits → + Create → provider + peering location + bandwidth → get service key → provider provisions → link to VNet gateway`.
**🎯 Q&A:** *What/when over VPN?* → dedicated private connection, consistent low latency/high bandwidth, compliance — for high-perf/regulated hybrid workloads. *Resilience?* → pair with a VPN Gateway backup for auto-failover.
**💡 AWS:** ≈ Direct Connect.

---

# 32. 🔑 Azure Key Vault `🔴`

**What:** Secure central store for secrets, keys, certificates. ⭐ (JD's secrets-management requirement).
```
App (Managed Identity) → Entra ID (auto-auth, no password) → RBAC check → Key Vault → secret at runtime
→ real secret NEVER in code/config/Git
```
**Key facts:** stores **Secrets** (passwords/conn strings/API keys), **Keys** (crypto), **Certificates**; access via **RBAC** (recommended: "Key Vault Secrets User") or legacy Access Policies; **Soft Delete** + **Purge Protection** safety nets; retrieved via Managed Identity — no hardcoding.
**UI:** `Key vaults → + Create (RBAC model, purge protection) → Secrets → + Generate/Import → IAM → grant Managed Identity "Key Vault Secrets User"`.
**🎯 Q&A:** *What/why?* → central secure store for secrets/keys/certs; eliminates hardcoding; apps fetch at runtime via Managed Identity. *Access without stored credential?* → Managed Identity auto-auths, Key Vault checks RBAC, returns secret. *Soft Delete/Purge Protection?* → recover accidental deletes / block malicious permanent deletion.
**💡 AWS:** ≈ Secrets Manager + KMS + Certificate Manager combined.

---

# 33. 🔗 Key Vault Integrations `🔴`

**What:** How Key Vault connects to Pipelines, AKS, ACR, apps — all one pattern.
```
Pipeline → KV:  Service Connection identity → RBAC → KV (via AzureKeyVault task / KV-linked Variable Group; masked in logs)
AKS pod → KV:   Workload Identity + Secrets Store CSI Driver → secret mounted as a file (not in image/YAML)
AKS → ACR:      cluster Managed Identity + "AcrPull" role → pulls image (az aks update --attach-acr)
App → KV:       Managed Identity + Key Vault References in config
```
**Unifying pattern (say this!):** *identity → Entra ID → RBAC → target, with NO stored credentials.*
**🎯 Q&A:** *Pipeline gets a secret?* → Service Connection identity + RBAC + AzureKeyVault task/linked Variable Group (masked). *AKS pod gets a secret?* → Workload Identity + CSI driver, mounted as a file. *AKS pulls from ACR?* → cluster Managed Identity + AcrPull role (`--attach-acr`). *Common thread?* → identity → Entra ID → RBAC → access, no stored credentials.
**💡 AWS:** ≈ Secrets Manager → CodePipeline / EKS (CSI + IRSA) / services via IAM roles.

---

# 34. 🛠️ Azure DevOps Overview `🟠`

**What:** Microsoft's integrated software delivery suite (top tech in the JD).
```
Boards (plan) → Repos (Git) → Pipelines (CI/CD) → Artifacts (packages) · Test Plans (testing)
Full traceability: work item → commit/PR → build → deployment
```
**Key facts:** 5 services, modular (can use Pipelines + GitHub instead of Repos); connected for end-to-end traceability.
**UI:** `dev.azure.com → + New project → Git + Agile process`.
**🎯 Q&A:** *5 services?* → Boards, Repos, Pipelines, Artifacts, Test Plans. *Use Pipelines with GitHub?* → yes, modular.
**💡 AWS:** ≈ CodePipeline/Build/Deploy/Artifact + a work-tracking tool (no AWS equal for Boards).

---

# 35. 🔐 Azure DevOps Permissions & Security `🔴`

**What:** Controls who can do what *inside* Azure DevOps (separate from Azure RBAC).
```
Organization → Project (Security Groups: Project Admins / Contributors / Readers) → resource-level perms (repo/pipeline/environment/service connection)
```
**Key facts:** users get access via **Security Groups** (tied to Entra ID groups), not individually; **resource-level permissions** enforce separation of duties (e.g., devs run pipelines but only leads approve prod via Environment approvals). Separate from Azure RBAC (which governs Azure resources).
**UI:** `Project settings → Permissions → group → Members → + Add`; per-resource: Environment → `⋮ → Security / Approvals`.
**🎯 Q&A:** *How manage permissions?* → Security Groups (Project Admins/Contributors/Readers), tied to Entra ID groups; resource-level for fine control. *Dev runs pipeline but not approve prod?* → Contributors group + Environment approval where only leads are approvers. *DevOps perms vs Azure RBAC?* → inside-the-tool vs Azure-resource access.
**💡 AWS:** internal SaaS permission model (no single AWS equal).

---

# 36. 🌿 Git Branching Strategies `🔴`

**What:** How teams organize branches. JD wants **trunk-based development**.
```
Trunk-Based: everyone commits small/frequent to main; short-lived branches; feature flags hide incomplete work → min conflicts, main always releasable
GitHub Flow: main + short feature branches via PR (simple)
GitFlow: main/develop/release/feature/hotfix (complex, versioned releases)
```
**Key facts:** trunk-based = modern CI/CD favorite; **feature flags decouple deploy from release** (rollback = flip flag off). GitFlow = more structure but more merge overhead.
**Steps:** short-lived branch → PR → branch policy (CI + reviews) → squash merge to main.
**🎯 Q&A:** *Trunk-based dev?* → small frequent commits to main, short branches, feature flags — min conflicts, main releasable. *Avoids shipping half-finished features how?* → feature flags (deploy dark, enable later). *GitFlow vs trunk-based?* → versioned/scheduled releases (complex) vs fast continuous delivery (simple).
**💡 AWS:** cloud-agnostic (same on any Git host).

---

# 37. 🚧 Branch Policies & Branch Protection `🔴`

**What:** Quality gates before merging to a protected branch (keeps main healthy).
```
PR → policy checks: reviewers approved? build passed? work item linked? comments resolved? → all pass = merge allowed
```
**Key facts:** enforce min reviewers, **build validation** (CI must pass), linked work items, comment resolution, merge type (squash/rebase/merge), reset approvals on new commits. Prerequisite for trunk-based/continuous deployment.
**UI:** `Repos → Branches → main → ⋮ → Branch policies`.
**🎯 Q&A:** *What/why?* → rules a PR must satisfy before merging (reviews + passing CI + linked item) — keeps main always releasable. *Build validation?* → auto-run CI on PRs, block merge if it fails. *Squash vs merge?* → one clean commit vs preserve all commits.
**💡 AWS:** ≈ GitHub branch protection rules.

---

# 38. 🔀 Pull Request Workflow & Code Reviews `🟠`

**What:** Propose → review → safely merge changes.
```
branch → PR → branch policy runs CI + requires approvals → reviewers comment → address → merge → work item auto-Done
```
**Key facts:** reviewers check correctness/tests/security/conventions; spreads knowledge; combined with branch policies = only reviewed+tested code reaches main.
**UI:** `Repos → Pull requests → + New` → review in Files tab → vote → Complete (squash).
**🎯 Q&A:** *PR workflow?* → branch → PR → policies run CI + require approvals → review/comment → merge → item auto-completes. *Value beyond bug-catching?* → knowledge sharing, consistency, security/perf checks.
**💡 AWS:** ≈ GitHub PR / GitLab MR.

---

# 39. 🔗 Service Connections `🔴`

**What:** The bridge letting a Pipeline authenticate to Azure. ⭐ top integration flow.
```
Pipeline → Service Connection → Entra ID → Service Principal/Managed Identity/WIF → RBAC → Subscription → Resource
```
**Auth types:** SP+secret (⚠️ legacy), Managed Identity (self-hosted agent on Azure VM), **WIF/OIDC (best — secretless)**. Scope RBAC to ONE resource group. **Governance:** pipeline permissions (which pipelines may use it) + approval checks on the connection. Types: ARM, Docker/ACR, Kubernetes, GitHub, generic.
**UI:** `Project settings → Service connections → New → Azure Resource Manager → Workload Identity federation → subscription → scope to one RG → Save`. YAML: `azureSubscription: 'name'`.
**🎯 Q&A:** *Auth flow?* → Pipeline→SC→Entra ID→SP/WIF→RBAC→resource. *Most secure?* → WIF/OIDC (no stored secret). *Limit pipeline access?* → scope RBAC to one RG + pipeline permissions + approval checks.
**💡 AWS:** ≈ IAM role/OIDC federation CodePipeline assumes.

---

# 40. 📜 Azure Pipelines — YAML `🔴`

**What:** CI/CD defined as code (YAML in the repo). Core of the JD's "YAML pipelines."
```
Pipeline → Trigger (push/PR/schedule) → Stages → Jobs → Steps(Tasks); run on Agents
Build stage → Deploy stage (dependsOn Build) → gated by Environment approvals
```
**Key facts:** hierarchy Pipeline→Stages→Jobs→Steps; triggers CI (`trigger:`), PR (`pr:`), scheduled, pipeline-chained. **YAML preferred over Classic** — version-controlled, PR-reviewable, traceable.
**UI:** `Pipelines → Create Pipeline → repo → Starter/detect → edit YAML → Save and run`.
**🎯 Q&A:** *Structure?* → Pipeline→Stages→Jobs→Steps, started by triggers. *YAML vs Classic?* → pipeline-as-code (versioned/reviewable) vs UI-configured. *CI vs PR trigger?* → on push to branch vs on PR before merge.
**💡 AWS:** ≈ buildspec.yml + CodePipeline definition combined.

---

# 41. 🚀 Multi-Stage Pipeline Design `🔴`

**What:** Promote a release through Dev→QA→Staging→Prod with gates.
```
BUILD once → Dev (auto + smoke) → QA (auto + full tests) → PROD (manual approval) — promote the SAME artifact throughout
```
**Key facts:** ⭐ **build once, deploy many** — build one artifact, promote that exact one (never rebuild per env → prod = what was tested); increasing control per stage; approval gate before prod (via Environment). Supports JD's "repeatable deployments across environments."
**UI:** create Environments (dev/qa/production) + approval on production; YAML stages `dependsOn` + `environment:`.
**🎯 Q&A:** *Describe it.* → build once, promote same artifact through env stages with increasing control + approval before prod. *Why build-once-deploy-many?* → guarantees prod gets exactly what was tested. *Protect prod stage?* → Environment with required approval.
**💡 AWS:** ≈ artifact promotion through CodePipeline stages/accounts + manual approvals.

---

# 42. 🔧 Pipeline Variables, Groups & Templates `🔴`

**What:** Config, shared config + secrets, and reusable YAML.
```
Variables (single values) · Variable Groups (shared, LINKABLE to Key Vault for secrets) · Templates (reusable YAML fragments)
```
**Key facts:** secret variables masked in logs; **Variable Group linked to Key Vault** = secure secret retrieval (masked); Templates = write once/reuse (platform team standardizes build/deploy). DRY + secure + maintainable.
**UI:** `Pipelines → Library → + Variable group → Link secrets from Key Vault`. YAML: `variables: - group: 'name'` / `- template: file.yml`.
**🎯 Q&A:** *Variable vs group vs template?* → single value / shared reusable set (KV-linkable) / reusable YAML. *Secrets into a pipeline?* → KV-linked Variable Group or AzureKeyVault task (masked in logs). *Why templates?* → avoid copy-paste, enforce consistency, update centrally.
**💡 AWS:** ≈ env vars + Parameter Store/Secrets + reusable CFN/buildspec fragments.

---

# 43. 💾 Pipeline Caching & Artifacts `🟡`

**What:** Speed up runs (caching) + pass output between stages (artifacts).
```
Caching: cache deps across RUNS (restore instead of re-download)
Artifacts: Build stage publishes → Deploy stage downloads (mechanism behind "build once, deploy many")
```
**Key facts:** cache keyed on a lock file (e.g., package-lock.json); artifacts publish/download between stages.
**Steps (YAML):** `Cache@2` task before install; `publish:` in build, `download:` in deploy.
**🎯 Q&A:** *Caching vs artifacts?* → reuse deps across runs (speed) vs hand off a build's output between stages (build once, deploy many).
**💡 AWS:** ≈ CodeBuild caching + artifacts passed between CodePipeline stages.

---

# 44. 🏃 Azure DevOps Agents `🟠`

**What:** The machines that run pipeline steps.
```
Microsoft-hosted: fresh managed VM per run, zero maintenance, NO private-network access, usage limits
Self-hosted: your own machine — CAN reach private resources, custom tools, persists — you maintain it
```
**Key facts:** #1 reason for self-hosted = **reach private-network resources** (private AKS/DB behind Private Endpoint, on-prem). Common hybrid: MS-hosted for build/test, self-hosted for private deploys.
**UI:** MS-hosted: `pool: vmImage: 'ubuntu-latest'`. Self-hosted: `Project settings → Agent pools → Add pool` → install agent on your VM.
**🎯 Q&A:** *MS-hosted vs self-hosted?* → managed fresh VM (no private access) vs your machine (private access, custom tools, you maintain). *When self-hosted?* → reach private resources, custom tooling, high volume.
**💡 AWS:** ≈ CodeBuild managed compute vs your own build servers.

---

# 45. 🌍 Environments `🟠`

**What:** Named deployment targets (Dev/QA/Prod) with history, security, and gates.
```
deployment job → environment: 'production' → the env's approvals/checks/security apply automatically + recorded in history
```
**Key facts:** provides deployment history (audit trail), a place to attach **approvals & checks**, security over who can deploy, optional resource linking (AKS namespace). Foundation for governed multi-stage deploys.
**UI:** `Pipelines → Environments → New environment` → `⋮ → Approvals and checks`.
**🎯 Q&A:** *What is an Environment?* → a named deploy target with history, security, and attachable approvals/checks. *How enable safe deploys?* → attach approvals to sensitive envs so deploys auto-pause for sign-off.
**💡 AWS:** ≈ CodePipeline stages + approval/gate capabilities.

---

# 46. ✅ Approvals & Checks / Release Gates `🔴`

**What:** Human + automated gates before deploying to an Environment. Supports JD's "release readiness & rollback."
```
Approvals (human): a lead must approve (separation of duties — can't approve own run)
Checks (automated): business hours, invoke Function/API (no active incident?), query Azure Monitor, required branch
```
**Key facts:** the approval = the release-readiness gate; separation of duties via "requesters can't approve own runs"; checks enforce conditions automatically.
**UI:** `Environments → production → ⋮ → Approvals and checks → + Approvals` (approvers + can't-approve-own).
**🎯 Q&A:** *Approvals vs Checks?* → human sign-off vs automated conditions (business hours, no active incident, correct branch). *Separation of duties?* → "requesters cannot approve their own runs." *Relation to rollback?* → approval = release-readiness gate; rollback via re-run/slot-swap/flag-off.
**💡 AWS:** ≈ CodePipeline manual approvals + Lambda/CloudWatch gate conditions.

---

# 47. 🔗 Azure Boards ↔ Repos/GitHub Traceability `🟡`

**What:** Links work item → commit/PR → build → deployment (full audit thread).
```
Work Item (Boards) → Commit/PR (Repos/GitHub) → Build → Deployment — trace any point end-to-end
```
**Key facts:** link commit to work item via ID in message/PR; branch policy can REQUIRE linked work items; GitHub integration uses `AB#101` syntax. Invaluable for audits/incident investigation.
**UI:** `Project settings → GitHub connections` (for GitHub); Azure Repos links automatically via `#101` in commits.
**🎯 Q&A:** *How provide traceability?* → link work items to commits/PRs to builds to deployments (required via branch policy). *GitHub → Boards?* → connect the repo, reference `AB#<id>` in commits/PRs.
**💡 AWS:** distinctive Azure DevOps strength (no single AWS equal — AWS lacks native work tracking).

---

# 48. 📄 ARM Templates `🟡`

**What:** Azure's original native IaC — declarative JSON.
```
Write JSON (parameters/variables/resources/outputs) → deploy → ARM handles order/dependencies
```
**Key facts:** declarative; deployed via ARM; **verbose JSON** (why Bicep exists). Sections: parameters (inputs), variables, resources, outputs.
**UI:** `Deploy a custom template` in portal, or `az deployment group create --template-file`. Preview: `what-if`.
**🎯 Q&A:** *What are they?* → native JSON IaC, declarative, deployed via ARM; verbose (Bicep is the cleaner successor).
**💡 AWS:** ≈ CloudFormation.

---

# 49. 💪 Bicep `🟠`

**What:** Modern clean IaC language that compiles to ARM (same engine, ~70% less code).
```
Write Bicep (concise) → compiles to ARM JSON → ARM deploys (same engine)
```
**Key facts:** type safety + IntelliSense; native **modules** (reusable); **no separate state file** (Azure tracks state); day-one new-feature support; **`what-if`** previews changes.
**UI:** `az deployment group what-if` (preview) → `az deployment group create --template-file main.bicep`.
**🎯 Q&A:** *Bicep vs ARM?* → cleaner DSL compiling to same ARM; ~70% less code, modules, no state file. *Bicep vs Terraform?* → Bicep for Azure-only/native + day-one features; Terraform for multi-cloud. *Preview changes?* → `what-if`.
**💡 AWS:** ≈ CloudFormation with a nicer authoring layer (spirit of CDK).

---

# 50. 🏗️ Terraform + Azure DevOps `🔴`

**What:** How Terraform authenticates to Azure and runs in pipelines.
```
Terraform (azurerm provider) → SP/WIF/Managed Identity → Entra ID → RBAC → Azure resources
In pipeline: init → plan (reviewed in PR) → APPROVAL → apply
```
**Key facts:** same init/plan/apply workflow + HCL as AWS; differs by provider (`azurerm`) and auth (Entra ID + RBAC, ideally WIF); Service Connection provides pipeline auth; resources reference each other → auto dependency ordering.
**UI/YAML:** `AzureCLI@2` task with `azureSubscription:` running terraform commands, or Terraform Marketplace tasks.
**🎯 Q&A:** *How auth to Azure?* → azurerm provider via SP/WIF/Managed Identity, verified by Entra ID + RBAC (same pattern as everything). *Run in a pipeline?* → Service Connection auth, init→plan(reviewed)→approval→apply. *vs AWS?* → same workflow/HCL, different provider + auth.
**💡 AWS:** same tool, `aws` provider + access keys/OIDC instead.

---

# 51. 🔐 Terraform State Locking & Remote Backend `🔴`

**What:** Terraform's state file = its memory; store it remotely with locking for teams.
```
Local state = solo only. Remote backend (Azure Storage Account) = shared state + state LOCKING (blob lease)
Engineer A applies → locks state → Engineer B's apply BLOCKED until A finishes → no corruption
```
**Key facts:** state = source of truth (comparing desired vs state vs real); remote backend via `backend "azurerm"` (Azure Storage) enables team sharing + locking. **Golden rule:** never manually edit Terraform-managed resources (causes drift).
**Steps:** create Storage Account for state → add `backend "azurerm"` block → `terraform init` (migrates state).
**🎯 Q&A:** *What/why state?* → record of what TF manages; must be safe + in sync. *Remote backend in Azure?* → Azure Storage Account backend → team sharing + locking. *State locking?* → blocks simultaneous applies (blob lease) to prevent corruption. *Golden rule?* → only change TF-managed resources via TF.
**💡 AWS:** ≈ S3 backend + DynamoDB lock table.

---

# 52. 📦 Terraform Modules & Reusability `🟠`

**What:** Reusable infra packages (inputs/outputs) — write once, use everywhere.
```
Module "network" (inputs: name/cidr; creates VNet+subnets; outputs: IDs) → reused by dev + prod with different params
```
**Key facts:** eliminates copy-paste, ensures consistency, update-once benefits all; sources = local path / Terraform Registry / Git; orgs keep a private versioned module library.
**Steps:** create `modules/network/` → reference with a `module` block passing params → init/plan/apply.
**🎯 Q&A:** *What/why modules?* → reusable infra packages with inputs/outputs; consistency + maintainability (update once). *Org management?* → private versioned Git module library referenced by all teams.
**💡 AWS:** identical Terraform concept (same for aws provider).

---

# 53. 🚦 IaC in CI/CD with Plan Approval Gates `🟠`

**What:** Run IaC safely via pipeline: plan → review → approve → apply.
```
.tf change → PR → pipeline: terraform plan (diff shown in PR) → APPROVAL GATE → terraform apply (on the exact reviewed plan)
```
**Key facts:** never apply un-reviewed; save plan as an artifact and apply that exact plan (no drift between review and apply); code review + plan review + approval + audit trail. Far safer than laptop-based applies.
**Steps:** Plan stage (publish plan artifact) → Apply stage targeting an approval-gated Environment (apply the saved plan).
**🎯 Q&A:** *Run IaC safely in a pipeline?* → plan (diff reviewed in PR) → approval gate → apply on the exact reviewed plan. *Why save & apply the exact plan?* → so what's applied = what was reviewed (no drift).
**💡 AWS:** ≈ Terraform via CodePipeline with a manual approval between plan and apply.

---

# 54. 🐳 Dockerfile Best Practices & Multi-Stage Builds `🟠`

**What:** Build small, secure container images. Key concept = **multi-stage builds**.
```
STAGE 1 "build": full image + build tools → compile app
STAGE 2 "runtime": tiny base (alpine) + copy ONLY artifacts → small, secure final image (no build tools)
```
**Key facts:** minimal base images; **pin specific tags** (not `latest`); order layers by change frequency (deps before code → cache reuse); run as non-root; `.dockerignore`; NEVER bake in secrets (inject at runtime).
**Steps:** `docker build -t app:v1 .` → tag for ACR → `az acr login` → `docker push`.
**🎯 Q&A:** *Multi-stage build?* → build stage with tools + minimal runtime stage copying only artifacts → small/secure image. *Why layer order matters?* → Docker caches layers; deps-before-code means code changes don't re-install deps. *Security practices?* → minimal base, multi-stage, non-root, no baked secrets, `.dockerignore`, pinned tags.
**💡 AWS:** identical Docker concepts; push to ACR vs ECR.

---

# 55. 📦 Azure Container Registry (ACR) `🔴`

**What:** Private managed container image registry. ⭐ (ACR→AKS path).
```
build → docker push → ACR (myregistry.azurecr.io) → AKS pulls via Managed Identity (AcrPull role)
```
**Key facts:** private; **AKS pulls via cluster Managed Identity + AcrPull role** — one command: `az aks update --attach-acr`; vulnerability scanning (Defender); geo-replication (Premium); no stored registry creds.
**UI:** `Container registries → + Create` → `az acr login` + push → `az aks update --attach-acr`.
**🎯 Q&A:** *Why over Docker Hub?* → private, Azure identity integration (no stored creds), scanning, geo-replication. *AKS pulls securely how?* → cluster Managed Identity + AcrPull role (`--attach-acr`). *Premium adds?* → geo-replication, private endpoints, content trust.
**💡 AWS:** ≈ ECR.

---

# 56. ☸️ Azure Kubernetes Service (AKS) `🔴`

**What:** Managed Kubernetes — Azure runs the control plane **free**; you pay only for nodes.
```
Control Plane (Azure-managed, FREE) + Node Pool (worker VMs = VM Scale Sets, you pay)
Concepts: Cluster · Node · Pod · Deployment · Service · Ingress · Namespace
```
**Key facts:** node pools = VMSS (→ Cluster Autoscaler); **Managed Identity** (ACR pulls), **Workload Identity** (pods → Key Vault, §33), **Azure CNI** (pods get VNet IPs), Container Insights monitoring.
**UI:** `Kubernetes services → + Create` → `az aks get-credentials` → `kubectl apply -f deployment.yaml`.
**🎯 Q&A:** *AKS vs self-managed K8s?* → Azure runs/patches the control plane free; you manage only nodes. *vs EKS?* → AKS control plane is free (EKS charges for it). *Node pools & autoscaling?* → nodes are VMSS → Cluster Autoscaler adds/removes them.
**💡 AWS:** ≈ EKS (but free control plane).

---

# 57. 🚪 AKS Ingress Controllers `🟠`

**What:** Single HTTP(S) entry point routing to many internal services (vs one LoadBalancer per service).
```
Internet → Ingress Controller (reads rules) → /api/catalog → catalog-svc · /api/orders → orders-svc · / → web-svc
```
**Key facts:** **Ingress** = the rules (YAML); **Ingress Controller** = the software that executes them (need both); options = **NGINX** (community) or **Application Gateway Ingress Controller/AGIC** (Azure-native, WAF+SSL).
**Steps:** install controller (Helm for NGINX, or `az aks enable-addons ingress-appgw`) → `kubectl apply -f ingress.yaml`.
**🎯 Q&A:** *Service (LoadBalancer) vs Ingress?* → one public IP per service vs one entry point routing to many by path/host. *Ingress vs Ingress Controller?* → the rules vs the software that performs the routing (need both). *AGIC?* → uses Azure App Gateway as ingress (native WAF/SSL).
**💡 AWS:** ≈ ALB Ingress Controller on EKS.

---

# 58. 💾 AKS Persistent Volumes & Storage `🟡`

**What:** Persist data despite ephemeral containers.
```
Pod → PVC (claim: "10Gi") → PV (backed by Azure Disk = single-pod, or Azure Files = shared) → survives pod restarts
```
**Key facts:** PV (storage) / PVC (request) / StorageClass (what kind); **Azure Disk** (ReadWriteOnce — databases/single-pod) vs **Azure Files** (ReadWriteMany — shared across pods); auto-provisioned via CSI driver.
**Steps:** `kubectl get storageclass` → `kubectl apply -f pvc.yaml` → mount in pod.
**🎯 Q&A:** *Persist data in AKS?* → PVC → PV backed by Azure Disk/Files; survives pod restarts. *Disk vs Files?* → Disk (single-pod, fast, DBs) vs Files (shared across many pods).
**💡 AWS:** ≈ EBS/EFS via CSI on EKS.

---

# 59. ⎈ Helm `🟠`

**What:** Package manager for Kubernetes — bundles app YAML into a versioned, parameterized Chart.
```
Chart (templates + values.yaml + Chart.yaml) → helm install/upgrade/rollback → whole app deployed as one unit
```
**Key facts:** one command deploys a multi-resource app; same chart + different values per env (DRY); **versioned releases** → easy `helm upgrade` / instant `helm rollback`; huge public chart ecosystem.
**Steps:** `helm install app ./chart -f values-prod.yaml` · `helm upgrade` · `helm rollback app`.
**🎯 Q&A:** *What/why Helm?* → K8s package manager; deploy whole app with one command, per-env values, easy upgrade/rollback of versioned releases. *Different environments?* → different values files. *Rollback?* → `helm rollback` (instant, versioned).
**💡 AWS:** cloud-agnostic (same on EKS).

---

# 60. 📈 AKS Autoscaling (Cluster Autoscaler + HPA) `🟠`

**What:** Two-level scaling — pods (HPA) + nodes (Cluster Autoscaler), working together.
```
Load ↑ → HPA adds POD replicas (CPU>70%) → pods can't schedule? → Cluster Autoscaler adds NODES (VMSS) → pods fit
Load ↓ → HPA removes pods → Cluster Autoscaler removes empty nodes → cost drops
```
**Key facts:** HPA scales pods on metrics; Cluster Autoscaler scales nodes when pods are pending; nodes are VMSS. HPA = "add workers," CA = "add desks."
**Steps:** CA: `az aks update --enable-cluster-autoscaler --min-count --max-count`. HPA: `kubectl apply -f hpa.yaml`.
**🎯 Q&A:** *Two autoscaler types?* → HPA (pod replicas on metrics) + Cluster Autoscaler (nodes when pods can't schedule). *How work together?* → HPA adds pods, CA adds nodes to fit them; both scale down on low load. *Nodes are?* → VM Scale Sets.
**💡 AWS:** HPA identical; Cluster Autoscaler ≈ EKS CA/Karpenter.

---

# 61. 🐙 GitHub → Azure `🔴`

**What:** GitHub Actions CI/CD deploying to Azure. ⭐ integration flow (JD lists GitHub Actions).
```
Setup: Entra ID federated credential trusts GitHub OIDC (scoped to repo/branch) + RBAC
Run: workflow → OIDC token → Entra ID (trust check) → short-lived Azure token → deploy. NO stored secret.
```
**Key facts:** Actions = workflows→jobs→steps (like Pipelines); **auth via OIDC/WIF** (client/tenant/sub IDs are NOT secrets); `azure/login@v2` action; **branch protection** = same as Repos branch policies (required reviews + status checks).
**UI:** Entra ID federated credential (GitHub scenario) → grant RBAC → GitHub repo variables (IDs) → workflow with `azure/login` OIDC → branch protection rules.
**🎯 Q&A:** *GitHub Actions auth to Azure securely?* → OIDC/WIF — federated credential trusting GitHub's issuer for a repo/branch; `azure/login` gets short-lived tokens, no stored secret. *Why OIDC over a secret?* → nothing to leak/rotate, short-lived, scoped trust.
**💡 AWS:** identical to GitHub Actions → AWS via OIDC.

---

# 62. 🔧 Jenkins → Azure `🟠`

**What:** How Jenkins authenticates to and deploys into Azure (you know Jenkins; focus on the auth).
```
Jenkins → Service Principal (creds in Jenkins Credentials Store) [or Managed Identity if on Azure VM] → Entra ID → RBAC → ACR/AKS/VM/App Service
```
**Key facts:** SP creds in Jenkins Credentials Store (never in Jenkinsfile); scope RBAC to needed RGs; `az login --service-principal`; rotate secret (or use Managed Identity to avoid it).
**Steps:** `az ad sp create-for-rbac --role Contributor --scopes /...rg` → store creds in Jenkins → Jenkinsfile logs in + builds + pushes to ACR + deploys to AKS.
**🎯 Q&A:** *Jenkins auth to Azure?* → Service Principal (creds in Jenkins Credentials Store) or Managed Identity (on Azure VM), verified by Entra ID + scoped RBAC. *Keep creds secure?* → Credentials Store (never in Jenkinsfile), least-privilege scope, rotate or use Managed Identity.
**💡 AWS:** ≈ Jenkins with an IAM user/assumed role.

---

# 63. 🔵🟢 Deployment — Blue/Green `🔴`

**What:** Two identical environments; deploy to idle, switch traffic instantly, instant rollback.
```
Blue (live v1) · Green (idle) → deploy v2 to Green → test → SWITCH all traffic to Green → Blue = rollback target
```
**Key facts:** zero downtime + instant rollback (switch back); on Azure = **App Service Deployment Slots** (deploy to staging slot → swap with production); trade-off = 2 environments + all-or-nothing switch.
**UI:** App Service → `Deployment slots → + Add "staging"` → deploy → test → `Swap`.
**🎯 Q&A:** *Blue/Green?* → two identical envs, deploy to idle, switch traffic instantly, old env = instant rollback. *On App Service?* → Deployment Slots — deploy to staging, swap with production, swap back to roll back. *Trade-off?* → two environments + all-or-nothing switch (Canary fixes the latter).
**💡 AWS:** ≈ CodeDeploy Blue/Green / ALB target group swap.

---

# 64. 🐤 Deployment — Canary, Rolling & Rollback `🔴`

**What:** Gradual traffic shift (Canary), batch updates (Rolling), and recovery (Rollback).
```
Canary: v2 5% → 25% → 50% → 100% (monitor each step; abort = v2→0%) — limits blast radius
Rolling: update instances in batches (K8s default) — always enough healthy, no 2nd env
Rollback: slot swap-back / canary→0% / helm rollback / feature-flag-off (all instant) / redeploy previous
```
**Key facts:** Canary = gradual/low-blast-radius; Rolling = Kubernetes default; on Azure Canary = App Service traffic routing (`az webapp traffic-routing set --distribution staging=10`) or AKS service mesh/Flagger.
**🎯 Q&A:** *Canary vs Blue/Green?* → gradual % traffic shift (limits blast radius) vs instant 100% switch. *Rolling?* → update in batches, always enough healthy, no 2nd env (K8s default). *Roll back?* → slot-swap-back / canary→0% / helm rollback / flag-off (instant) or redeploy previous.
**💡 AWS:** ≈ CodeDeploy canary/linear + K8s rolling updates.

---

# 65. 🚩 Feature Flags & Azure App Configuration `🟠`

**What:** Decouple deploying code from releasing a feature; toggle on/off at runtime.
```
Deploy code (flag OFF, "dark") → enable for testers → 10% → 100%. Problem? flip flag OFF = instant rollback (no redeploy)
```
**Key facts:** **Azure App Configuration** = managed store for feature flags (**Feature Manager**, with %/user/group targeting) + app settings, read dynamically at runtime; underpins trunk-based development; integrates with Key Vault for secret values.
**UI:** `App Configuration → + Create → Feature manager → + Create flag`.
**🎯 Q&A:** *Feature flags & deployment?* → decouple deploy from release; deploy dark, enable gradually, disable instantly — makes trunk-based dev safe, rollback = flag flip. *Azure App Configuration?* → managed store for flags (Feature Manager) + settings, dynamic at runtime.
**💡 AWS:** ≈ AWS AppConfig feature flags.

---

# 66. 📊 Azure Monitor & Metrics `🟠`

**What:** Central observability platform; Metrics = numerical health signals.
```
Every resource → Azure Monitor (Metrics + Logs + Traces) → Alert Rule (threshold) → Action Group (email/SMS/Teams/Function)
```
**Key facts:** metrics auto-collected (CPU); ⚠️ **guest-OS metrics (memory/disk) need the Azure Monitor Agent**; Alert Rules fire → Action Groups notify/auto-remediate.
**UI:** resource → `Alerts → + Create → condition (metric+threshold) → Action group`.
**🎯 Q&A:** *What is Azure Monitor?* → central observability (Metrics/Logs/Traces) + Alerts + dashboards (≈ CloudWatch). *VM metrics gotcha?* → memory/disk need the Azure Monitor Agent. *Action Group?* → defines what happens when an alert fires (notify/remediate).
**💡 AWS:** ≈ CloudWatch (Alerts ≈ Alarms).

---

# 67. 🔎 Log Analytics & KQL Basics `🔴`

**What:** Where logs are stored + how you query them (KQL). Metrics say *that*; logs say *why*.
```
Logs → Log Analytics Workspace (tables) → KQL query → answers / log-based alerts
KQL pattern: TableName | where ... | summarize ... | order by ...
```
**Key facts:** KQL operators = `where` (filter), `summarize` (aggregate), `project` (columns), `order by`, `ago()` (time); example: `AppExceptions | where TimeGenerated > ago(1h) | summarize count() by type | order by count_ desc`; can turn queries into log-based alerts.
**UI:** Log Analytics Workspace → `Logs` → write KQL → Run → optionally `+ New alert rule`.
**🎯 Q&A:** *Metrics vs logs?* → numerical "that something's wrong" vs detailed "why." *Log Analytics & KQL?* → log store (tables) queried with a pipe-based language (`where`→`summarize`→`order by`). *Basic KQL for errors?* → `AppExceptions | where TimeGenerated > ago(1h) | summarize count() by type`.
**💡 AWS:** ≈ CloudWatch Logs + Logs Insights (KQL more powerful).

---

# 68. 🔬 Application Insights & Distributed Tracing `🟠`

**What:** APM — deep application-level visibility + tracing across microservices.
```
App (App Insights SDK) → request rates/latency, dependency timings, exceptions+stack traces, custom metrics
Distributed trace: follows ONE request across all services → pinpoints WHICH service is slow/failing
```
**Key facts:** **distributed tracing** = standout (find the bottleneck service); **Application Map** = auto service-dependency diagram; Live Metrics; availability tests; feeds Log Analytics (KQL).
**UI:** App Service → `Application Insights → Turn on` (codeless), or add SDK; view Application map / Failures / Performance / Live metrics.
**🎯 Q&A:** *App Insights?* → APM: per-endpoint perf, dependency timings, exceptions, custom metrics (≈ X-Ray+). *Distributed tracing value?* → follows a request across microservices to reveal exactly which service caused slowness/failure. *Application Map?* → auto service-dependency diagram with health.
**💡 AWS:** ≈ X-Ray + CloudWatch app insights.

---

# 69. 🚨 Alerting Strategy & Incident Response `🟡`

**What:** Tiered actionable alerts + a structured incident process.
```
Alerts: tier by severity (Critical=page on-call · High=SMS · Warning=email · Info=dashboard); alert on user-felt SYMPTOMS
Incident: Detect → Acknowledge → Triage → MITIGATE FIRST (rollback/flag-off/failover) → Investigate → Resolve → blameless post-mortem
```
**Key facts:** avoid alert fatigue (actionable only); **mitigate-then-investigate** (restore service before root cause); on-call rotation + runbooks.
**🎯 Q&A:** *Good alerting strategy?* → tiered by severity, always actionable, alert on user-felt symptoms, avoid fatigue. *Incident response?* → detect→ack→triage→mitigate first→investigate (metrics/KQL/traces)→resolve→blameless post-mortem.
**💡 AWS:** cloud-agnostic SRE practice.

---

# 70. 🎯 SLI / SLO / SLA & Error Budgets `🟡`

**What:** Measure & commit to reliability.
```
SLI = the measurement (e.g., 99.95% success)
SLO = internal target (e.g., 99.9%)         SLA = customer promise w/ penalties (e.g., 99.5%) — loosest
Error Budget = inverse of SLO (0.1% allowed failure) → budget left = ship fast; exhausted = focus on stability
```
**Key facts:** memory hook — Indicator / Objective / Agreement; usually SLA < SLO < actual; error budget data-drives velocity-vs-stability; measured via Azure Monitor/App Insights.
**🎯 Q&A:** *SLI vs SLO vs SLA?* → measurement vs internal target vs customer contract (with penalties). *Error budget?* → allowed unreliability (inverse of SLO); budget left → ship features, exhausted → focus on stability.
**💡 AWS:** cloud-agnostic SRE concept.

---

# 71. 🔐 DevSecOps `🔴`

**What:** Security built into every pipeline stage ("shift left"). JD requires secrets mgmt + policy controls.
```
commit → secret scan · build/PR → SAST + SCA · container → image scan · IaC → scan · staging → DAST · deploy → Azure Policy (backstop) · runtime → Defender for Cloud
```
**Key facts:** scan types = Secret / SAST (code) / SCA (deps) / container image / IaC / DAST — fail build on critical findings. **3 JD pillars:** (1) secrets = Key Vault + Managed Identity, never hardcode; (2) policy = **Azure Policy denies non-compliant resources** at deploy time (backstop); (3) least-privilege pipeline identity.
**Steps (YAML):** scan stages (gitleaks/sonar/trivy/checkov) that fail on critical + assign Azure Policy + enable Defender for Cloud.
**🎯 Q&A:** *DevSecOps / shift-left?* → security checks at every stage (scan code/deps/containers/IaC) so issues caught early. *Scan types?* → secret, SAST, SCA, container, IaC, DAST. *Azure Policy role?* → deny non-compliant resources at deploy time (defense-in-depth backstop). *Secrets?* → Key Vault + Managed Identity + secret scanning.
**💡 AWS:** same practice; Defender ≈ Security Hub, Azure Policy ≈ Config+SCPs.

---

# 72. 🤖 AI-Assisted DevOps (AIOps) `🟠`

**What:** Apply existing AI tools to reduce DevOps toil (JD's dedicated AI section).
```
Pipeline failure → Azure OpenAI summarizes log + suggests fix → posted to Teams
PR review → Copilot flags IaC/pipeline anti-patterns · Log investigation → plain English → KQL · Alerts → ML dynamic thresholds
```
**Key facts:** 4 JD areas = failure analysis, AI-assisted reviews, log/metric investigation, anomaly detection; tools = Azure OpenAI, GitHub Copilot, Monitor Dynamic Thresholds, App Insights Smart Detection, Sentinel. ⚠️ AI = co-pilot; **always human-verify** before acting.
**Steps (YAML):** step with `condition: failed()` → send logs to Azure OpenAI → post root-cause summary.
**🎯 Q&A:** *How AI helps DevOps?* → summarize pipeline failures, AI PR reviews, plain-English→KQL, ML anomaly detection — apply existing tools, not build models. *Concrete failure-analysis example?* → `condition: failed()` step sends logs to Azure OpenAI, posts root cause + fix to Teams. *Key caveat?* → always human-verify; AI is a co-pilot.
**💡 AWS:** cloud-agnostic (same Copilot/LLM/ML patterns).

---

# 73. 🏷️ Tagging & Naming Conventions `🟡`

**What:** Key-value labels + consistent names → order, cost attribution, automation, governance.
```
Tags: Environment / Project / Owner / CostCenter / ManagedBy → filter bills, find owners, target automation
Naming: <type>-<app>-<env>-<region>  (e.g., vm-portal-prod-cin-01)
```
**Key facts:** enforce with **Azure Policy** (require/append tags, audit non-compliance); tags enable cost breakdown (by CostCenter), ownership, and automation targeting ("shut down all Env=Dev").
**UI:** any resource → `Tags`; enforce via `Policy → assign "Require a tag on resources"`.
**🎯 Q&A:** *Why tags/naming?* → cost attribution, ownership, automation, governance. *Enforce consistency?* → Azure Policy (require/append/audit tags).
**💡 AWS:** ≈ AWS resource tags (same concept).

---

# 74. 🏗️ Azure Landing Zones `🟡`

**What:** Pre-built, governed foundation for enterprise Azure adoption — workloads "land" into it.
```
Root MG → Platform MG (Identity + Connectivity/hub + Management subs) + Landing Zones MG (per-workload spoke subs)
+ Azure Policy, RBAC, hub-spoke networking, monitoring applied consistently
```
**Key facts:** subscriptions as units of scale; policy-driven governance; centralized shared services (identity/hub networking/monitoring); secure-by-default; deployed via IaC accelerators. Teams inherit guardrails automatically.
**UI:** portal → "Azure landing zones" accelerator (Bicep/Terraform).
**🎯 Q&A:** *What is a Landing Zone?* → pre-configured governed foundation (MG/sub hierarchy + shared services + policy/RBAC/networking) that workloads deploy into. *Why?* → consistent security/governance from day one vs ad-hoc sprawl.
**💡 AWS:** ≈ AWS Landing Zone / Control Tower.

---

# 75. 💰 Cost Management & FinOps `🟡`

**What:** Cost visibility + control + the discipline of managing cloud spend.
```
Cost Management: Cost Analysis (break down by tag/RG/sub) + Budgets (alerts at 50/75/90/100%) + Advisor recommendations
FinOps: cost as a shared, continuous, first-class team responsibility
```
**Key facts:** optimization levers = shut down non-prod off-hours, right-size, Reserved Instances/Savings Plans (steady), Spot (fault-tolerant), delete orphaned resources, autoscaling, storage tiering. Tagging (§73) underpins attribution.
**UI:** `Cost Management + Billing → Cost analysis / Budgets`; `Advisor → Cost`.
**🎯 Q&A:** *Manage/control costs?* → Cost Analysis (by tag) + Budgets with alerts + Advisor; levers = shut down non-prod, right-size, Reservations, Spot, delete orphans. *FinOps?* → cost as a shared, ongoing, first-class responsibility.
**💡 AWS:** ≈ Cost Explorer + Budgets; FinOps identical.

---

# 76. 🔄 Disaster Recovery & Backup (RTO/RPO) `🟡`

**What:** Protect data (Backup) + recover apps after major outages (DR). Measured by RTO/RPO.
```
RPO = how much DATA you can lose (backup frequency) · RTO = how long you can be DOWN (recovery time)
Azure Backup → data recovery (scheduled, cross-region, soft delete)
Azure Site Recovery → replicate to another region → fail over on regional outage
```
**Key facts:** DR strategies by RTO/RPO (cost vs resilience) = Backup&Restore (hours) → Pilot Light → Warm Standby → Active-Active (near-zero). **Always TEST restores/failovers** — untested = unreliable.
**UI:** `Recovery Services vaults → + Create → Backup / Site Recovery`.
**🎯 Q&A:** *RTO vs RPO?* → how long down (recovery time) vs how much data lost (recovery point). *Azure Backup vs Site Recovery?* → data recovery (backups) vs regional failover (replication). *Key practice?* → regularly test restores/failovers.
**💡 AWS:** Backup ≈ AWS Backup; Site Recovery ≈ Elastic DR; RTO/RPO universal.

---

# 77. 🖥️ Compute Essentials `🟠`

**What:** Ways to run apps, control ↔ convenience.
```
Virtual Machine (IaaS, full control) → VM Scale Set (autoscaling VMs) → App Service (PaaS, just deploy code) → Functions (serverless)
```
**Key facts:** VM = full OS control (legacy/custom); VMSS = autoscaling group (self-healing, = AKS node pool engine); **App Service** = PaaS web hosting (App Service Plan + Web App; autoscale, free SSL, Easy Auth); **Deployment Slots** = zero-downtime Blue/Green (deploy to staging → swap).
**UI:** `App Services → + Create` (Standard+ for slots) → `Deployment slots → + Add → Swap`.
**🎯 Q&A:** *VM vs App Service?* → full OS control (IaaS) vs just deploy code, Azure manages OS/scaling (PaaS). *Deployment Slots?* → zero-downtime Blue/Green (staging → swap → instant rollback).
**💡 AWS:** VM≈EC2 · VMSS≈ASG · App Service≈Elastic Beanstalk.

---

# 78. 🗄️ Storage Essentials `🟡`

**What:** Storage Account foundation — Blob, access control, tiers.
```
Storage Account → Blob (files, in Containers) · Files (shares) · Queue · Table
Tiers: Hot → Cool → Cold → Archive (Archive = hours to retrieve) · Lifecycle auto-tiers
Access: Access Keys / SAS (time-limited scoped URL) / RBAC+Managed Identity (best) / public (disable by default)
```
**Key facts:** SAS ≈ S3 pre-signed URL; redundancy LRS/ZRS/GRS/GZRS; underpins TF state, pipeline artifacts, backups.
**UI:** `Storage accounts → + Create → Containers → + Container`; SAS via `Shared access signature`; lifecycle via `Lifecycle management`.
**🎯 Q&A:** *SAS token?* → time-limited scoped URL granting specific access without account keys (≈ S3 pre-signed URL). *Access tiers?* → Hot/Cool/Cold/Archive (Archive = hours retrieval); Lifecycle auto-moves them.
**💡 AWS:** Blob≈S3 · SAS≈pre-signed URL · tiers≈storage classes.

---

# 79. 🔥 All 10 Integration Flows `🔴`

**⭐ THE most important section — interviewers probe how services connect. Memorize these.**
```
1. Azure DevOps → Azure:   Pipeline → Service Connection → Entra ID → SP/WIF → RBAC → Resource
2. Pipeline → Key Vault:   SC identity → RBAC → KV (AzureKeyVault task / KV-linked Variable Group, masked)
3. Pipeline → ACR:         Git → Pipeline → docker build → push to ACR
4. ACR → AKS:              AKS Managed Identity (AcrPull role) → pulls image (az aks update --attach-acr)
5. Terraform → Azure:      TF (azurerm) → SP/WIF → Entra ID → RBAC → resources (remote state + locking)
6. AKS Pod → Key Vault:    Workload Identity → Entra ID → RBAC → KV (Secrets Store CSI Driver mounts as file)
7. App → Monitoring:       App (App Insights SDK) → Azure Monitor → Metrics/Logs(KQL)/Traces → Alert → Action Group
8. GitHub → Azure:         GitHub Actions → OIDC token (repo/branch) → Entra ID (federated trust) → RBAC → Azure
9. Jenkins → Azure:        Jenkins → Service Principal (or Managed Identity) → Entra ID → RBAC → ACR/AKS/VM
10. Terraform → DevOps:    Git → Pipeline → init → plan (reviewed) → APPROVAL → apply → Azure
```
**⭐ THE unifying pattern (say this for ANY integration question):**
```
IDENTITY (Service Principal / Managed Identity / Workload Identity / WIF)
  → ENTRA ID (verifies)
  → RBAC (least-privilege scope = what it can access)
  → TARGET (Key Vault / ACR / AKS / Storage / any resource)
...with NO stored credentials wherever possible.
```
**🎯 Scenario Q:** *Pipeline builds a container, pushes it, deploys to AKS, pulls a secret — walk the auth.* → SC (WIF) → build+push to ACR → AKS pulls via its Managed Identity (AcrPull) → pod gets secret via Workload Identity + CSI driver. Every step: identity → Entra ID → RBAC → target, no stored creds.

---

# 80. 🎓 Rapid-Fire Interview Q&A `🔴`

**Identity:** Entra ID=auth / RBAC=authz · SP has managed creds, Managed Identity has none (prefer MI) · System-assigned=1 resource, User-assigned=shared/fleets · secure CI/CD auth=WIF/OIDC · Owner grants access, Contributor doesn't.

**Networking:** /24=256, /16=65,536 (smaller slash=bigger) · NSG=basic IP/port allow+deny (subnet+NIC, stateful), Firewall=central+FQDN+threat intel · Service Endpoint=public IP stays, Private Endpoint=private IP in VNet (use for isolation) · Peering NOT transitive · Hub-spoke=central shared services + isolated spokes · troubleshoot connectivity=IP Flow Verify.

**Secrets/Security:** secrets in Key Vault + Managed Identity, never hardcode · app→KV via Managed Identity (no stored cred) · DevSecOps=shift-left scanning (secret/SAST/SCA/container/IaC) + Azure Policy backstop.

**Azure DevOps:** YAML=pipeline-as-code (versioned/reviewable) vs Classic UI · Service Connection=pipeline→Azure auth (WIF, scoped RBAC) · trunk-based=small commits to main + feature flags · Branch Policies=reviews+CI before merge · build once/deploy many · MS-hosted vs self-hosted (self=private access).

**Containers:** multi-stage build=tools stage + minimal runtime stage · AKS pulls ACR via Managed Identity (AcrPull, --attach-acr) · AKS control plane FREE (vs EKS) · HPA=pods, Cluster Autoscaler=nodes (together) · Helm=K8s package manager (versioned, rollback).

**Deploy/Observe:** Blue/Green=instant 100% switch+rollback (App Service slots) vs Canary=gradual % (limits blast radius) · rollback=slot-swap/canary-0%/helm-rollback/flag-off · metrics=that / logs(KQL)=why · distributed tracing=which microservice is slow · RTO=downtime, RPO=data loss · SLI=measure/SLO=target/SLA=contract.

**Scenarios:** *Secure CI/CD to AKS?* → WIF Service Connection (scoped RBAC) → build+test+scan → ACR → AKS (Managed Identity/AcrPull) → pod secrets via Workload Identity+CSI → prod approval gate → canary → App Insights. No stored creds. *Prod deploy caused errors?* → mitigate first (rollback/flag-off), then investigate (metrics/KQL/traces), resolve, blameless post-mortem.

**Recurring themes to emphasize:** least privilege · no stored credentials (Managed Identity/WIF) · build once, deploy many · mitigate-then-investigate · defense-in-depth · identity→Entra ID→RBAC→resource.

---

# 81. 📌 Final Quick Reference `🔴`

**AWS ↔ Azure map:**
```
IAM→Entra ID+RBAC · IAM Role→Service Principal/Managed Identity · OIDC→WIF
EC2→VM · ASG→VMSS · S3→Blob · pre-signed URL→SAS · EBS→Managed Disks · EFS→Azure Files
VPC→VNet · SG+NACL→NSG · Network Firewall→Azure Firewall · PrivateLink→Private Endpoint
NLB→Load Balancer · ALB→App Gateway · Route 53→Azure DNS · Direct Connect→ExpressRoute · S2S VPN→VPN Gateway
Secrets Manager/KMS→Key Vault · RDS→Azure SQL · DynamoDB→Cosmos DB
EKS(paid CP)→AKS(FREE CP) · ECR→ACR · Lambda→Functions
CodePipeline→Azure DevOps/GitHub Actions · CloudFormation→ARM/Bicep · Terraform→Terraform
CloudWatch→Azure Monitor · X-Ray→App Insights · Logs Insights→Log Analytics/KQL
Security Hub→Defender for Cloud · Config+SCPs→Azure Policy · Control Tower→Landing Zone
```
**Key numbers:** /24=256 · /16=65,536 · 5 IPs reserved/subnet (/24=251 usable) · ≥3 AZs · NSG priority 100-4096 (low first) · AKS control plane FREE · SQL PITR ≤35 days · Blob GZRS=16 nines · Spot eviction=30s · ports: 22/80/443/3389/1433 · special subnets: GatewaySubnet, AzureFirewallSubnet, AzureBastionSubnet.

**"Say this" one-liners:**
- Auth (any integration): *"Identity → Entra ID → RBAC → resource, no stored credentials via Managed Identity or WIF."*
- Secrets: *"Never hardcode — Key Vault + Managed Identity at runtime."*
- Pipeline auth: *"Service Connection via WIF — secretless, least-privilege scoped to one RG."*
- Deployment: *"Build once, deploy many — same artifact through Dev→QA→Prod, approval before prod."*
- Networking security: *"Defense in depth — private subnets, NSGs, Private Endpoints, Bastion, Azure Firewall egress."*
- Trunk-based: *"Small commits to main + feature flags — rollback = flag flip."*
- Incident: *"Mitigate first, then investigate with metrics/KQL/traces."*
- Reliability: *"Define RTO/RPO and SLOs; error budgets balance velocity vs stability."*
- Hub-spoke: *"Central hub for shared services, isolated spokes per team."*

**Night-before checklist:** ✅ Draw identity→Entra ID→RBAC→resource · ✅ Draw hub-and-spoke · ✅ Walk full CI/CD to AKS · ✅ Service Connection auth flow · ✅ Service vs Private Endpoint · ✅ NSG/ASG vs Firewall · ✅ Blue/Green vs Canary + rollback · ✅ AKS↔ACR + pod↔Key Vault · ✅ basic KQL + metrics/logs/traces · ✅ trunk-based + feature flags · ✅ RTO/RPO + SLI/SLO/SLA · ✅ incident response · ✅ relate each service to AWS.

**#1 thing to internalize:** the **identity → Entra ID → RBAC → resource (no stored credentials)** pattern — it unlocks most integration/auth questions. Good luck! 🚀

---
