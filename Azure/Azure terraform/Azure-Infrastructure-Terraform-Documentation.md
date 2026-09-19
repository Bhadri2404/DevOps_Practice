# Azure Infrastructure with Terraform — Complete Project Documentation

> The Azure equivalent of the AWS VPC + ALB + EC2 project — same architecture, same high-availability goals, ported resource-by-resource to Azure, with beginner-friendly explanations throughout.

## Table of Contents
- [1. Project Overview](#1-project-overview)
- [2. Architecture Diagram](#2-architecture-diagram)
- [3. AWS → Azure Component Mapping](#3-aws--azure-component-mapping)
- [4. Infrastructure Components](#4-infrastructure-components)
- [5. File Structure](#5-file-structure)
- [6. Configuration Files](#6-configuration-files)
- [7. Variables](#7-variables)
- [8. Outputs](#8-outputs)
- [9. Deployment Steps](#9-deployment-steps)
- [10. How It Works](#10-how-it-works)
- [11. Key Terraform and Azure Concepts Used](#11-key-terraform-and-azure-concepts-used)
- [12. Best Practices Implemented](#12-best-practices-implemented)
- [13. Cost Considerations](#13-cost-considerations)
- [14. Troubleshooting](#14-troubleshooting)
- [15. Cleanup](#15-cleanup)
- [16. Future Enhancements](#16-future-enhancements)
- [17. Conclusion](#17-conclusion)

---

## 1. Project Overview

### In Plain English
Think of this project as renting an entire small office building (a **Resource Group**), putting up walls to create a private area (a **Virtual Network**), and inside that private area, setting up two identical reception desks (**Virtual Machines**) that both answer the same phone number — a receptionist system (**Load Balancer**) picks whichever desk is free to answer each call. If one desk is unavailable, calls only go to the other one automatically.

### Technical Summary
This project deploys a production-grade, highly available web application on Microsoft Azure using Terraform. It mirrors an equivalent AWS architecture (Virtual Private Cloud, public/private subnets, Application Load Balancer, EC2 instances, NAT Gateway) using Azure's native services: Virtual Network, subnets, Azure Load Balancer, Virtual Machines, and NAT Gateway.

### Why Port This from AWS to Azure?
The underlying architecture pattern — isolated network, VMs not directly exposed to the internet, a load balancer distributing traffic, and a managed NAT service for outbound internet access — is a cloud-agnostic best practice. Learning to translate it between providers is one of the most valuable skills in DevOps/Cloud interviews, since the *concepts* transfer even though the *resource names and exact configuration* differ.

---

## 2. Architecture Diagram

```
                                    Internet
                                        |
                                        |
                              [Azure Load Balancer]
                              [Public IP - Standard SKU]
                                        |
        +-------------------------------------------------------------+
        |                  Resource Group: demo-rg                    |
        |                                                              |
        |          Virtual Network: demo-vnet (10.0.0.0/16)           |
        |                                                              |
        |     +----------------------------------------------------+  |
        |     |          Subnet: web-subnet (10.0.1.0/24)          |  |
        |     |                                                     |  |
        |     |   +----------------+      +----------------+       |  |
        |     |   | VM: WebServer1 |      | VM: WebServer2 |       |  |
        |     |   | Zone 1         |      | Zone 2         |       |  |
        |     |   | Private IP only|      | Private IP only|       |  |
        |     |   +--------+-------+      +-------+--------+       |  |
        |     |            |                      |                |  |
        |     |            +--- NSG: web-nsg -----+                |  |
        |     |            (allow 80 from LB only)                 |  |
        |     |                                                     |  |
        |     +----------------------[NAT Gateway]------------------+  |
        |                            [Public IP]                      |
        |                          (outbound only,                    |
        |                           for updates)                      |
        +-------------------------------------------------------------+
```

### Key Difference From the AWS Diagram
Notice there's only **one subnet**, not four. In AWS, each Availability Zone typically needs its own subnet (public + private × 2 AZs = 4 subnets). In Azure, a single subnet already spans every Availability Zone in the region — the VMs themselves are pinned to specific zones (`zone = "1"`, `zone = "2"`) instead of being placed in zone-specific subnets. This is one of the most important conceptual differences between the two clouds.

---

## 3. AWS → Azure Component Mapping

### In Plain English
If you already understand the AWS version of this project, this table is your Rosetta Stone — every AWS piece has a direct (though not always identical) Azure counterpart.

| AWS Component | Azure Component | Key Difference to Know |
|---|---|---|
| (no equivalent) | **Resource Group** | Azure requires every resource to belong to a Resource Group — a logical container with no AWS equivalent. |
| VPC | **Virtual Network (VNet)** | Conceptually identical — an isolated private network you define a CIDR range for. |
| Public + Private Subnets (per AZ) | **Subnet** (one, spanning all AZs) | Azure subnets aren't zone-specific; VMs are individually assigned a zone instead. |
| Internet Gateway | *(implicit)* | Azure VNets have built-in outbound internet routing by default; there's no separate gateway resource to attach. |
| NAT Gateway | **NAT Gateway** (`azurerm_nat_gateway`) | Same purpose; in Azure it's associated directly with a subnet rather than referenced via a route table entry. |
| Route Tables | *(mostly implicit)* | Azure's default system routes handle basic routing; you only add custom Route Tables for advanced scenarios (not needed here). |
| Security Group | **Network Security Group (NSG)** | Same purpose (a stateful firewall); Azure NSGs use the special `AzureLoadBalancer` service tag instead of referencing another security group's ID for load-balancer-sourced traffic. |
| EC2 Instance | **Virtual Machine (VM)** | Azure separates the VM resource from its network config — you must create a **Network Interface (NIC)** resource separately and attach it. |
| user_data | **custom_data** | Same purpose (bootstrap script), same base64-encoded delivery mechanism, executed by cloud-init on Ubuntu images. |
| Application Load Balancer (ALB) | **Azure Load Balancer (Standard SKU)** | AWS's ALB is Layer 7 (HTTP-aware routing rules); Azure's Standard Load Balancer here is Layer 4. For full Layer-7 feature parity (path-based routing, WAF), the closer Azure match is **Application Gateway** — see [Future Enhancements](#16-future-enhancements). |
| Target Group | **Backend Address Pool** | Same purpose — the set of VMs traffic gets distributed to. |
| Target Group Health Check | **Load Balancer Probe** | Same purpose — Azure's HTTP probe supports a request path just like AWS's target group health check. |
| Listener | **LB Rule** (`azurerm_lb_rule`) | Same purpose — maps a frontend port to a backend pool. |
| Elastic IP | **Public IP (Standard SKU, Static)** | Conceptually identical — a static, internet-routable IP address. |
| `terraform.tfstate` in S3 + DynamoDB lock (best practice) | `terraform.tfstate` in an **Azure Storage Account** container with blob leasing | Same concept, different backend service. |

**Interview One-Liner:** *"The biggest conceptual shift moving from AWS to Azure networking is that Availability Zones are a property of the resource, not the subnet — one Azure subnet can host VMs spread across multiple zones, whereas AWS typically dedicates a subnet per zone."*

---

## 4. Infrastructure Components

### 4.1 Networking Layer

#### Resource Group
- **Name**: `demo-rg`
- **Purpose**: The logical container every other resource in this project belongs to. Think of it as the folder everything lives in — delete the Resource Group, and (by default) everything inside it goes with it.

#### Virtual Network (VNet)
- **CIDR Block**: 10.0.0.0/16
- **Purpose**: An isolated private network, exactly like an AWS VPC — nothing outside it can reach your resources unless you explicitly allow it.
- **Tag**: `demo_vnet`

#### Subnet
- **web-subnet**: 10.0.1.0/24
- Hosts both VMs, spread across two Availability Zones for high availability — no need for separate subnets per zone the way AWS requires.

#### NAT Gateway
- **Purpose**: Lets VMs in the subnet reach the internet (e.g., to run `apt-get update`) without being directly reachable *from* the internet — the same one-way-door concept as AWS's NAT Gateway.
- **Public IP**: A dedicated static IP address (Standard SKU) attached to the NAT Gateway.
- **Association**: Attached directly to `web-subnet` — every VM in that subnet automatically uses it for outbound traffic, no manual route table entry required (a simpler setup than AWS's explicit route table + NAT Gateway route).

### 4.2 Security Layer

#### Network Security Group (`web-nsg`)
- **Inbound Rule**: Allow port 80, but **only** from the special `AzureLoadBalancer` service tag — this is Azure's way of saying "only traffic that's actually coming through our load balancer's health-check and routing infrastructure," the direct equivalent of AWS's "only from load_balancer_sg" chaining rule.
- **Outbound Rule**: Allow all outbound traffic, so VMs can reach the internet (via the NAT Gateway) for updates.

### 4.3 Compute Layer

#### Virtual Machines (Web Servers)
**Web Server 1:**
- **Image**: Canonical Ubuntu 22.04 LTS
- **Size**: `Standard_B1s` (Azure's closest match to AWS's `t2.micro` — both are low-cost "burstable" VM sizes)
- **Zone**: 1
- **NIC**: `web-server-1-nic`, in `web-subnet`, no public IP assigned (private-only, just like the AWS instance in a private subnet)
- **Custom Data**: `web-server-1-init.sh` (installs Apache, serves "Hello from Web Server 1 (Azure)")

**Web Server 2:**
- Identical setup, in **Zone 2** instead of Zone 1, running `web-server-2-init.sh`.

### 4.4 Load Balancing Layer

#### Azure Load Balancer
- **Name**: `app-lb`
- **SKU**: Standard (required to work with Standard SKU Public IPs and NAT Gateway in the same VNet)
- **Frontend**: A Standard SKU Public IP with a DNS label, giving you an FQDN similar to AWS's ALB DNS name.

#### Backend Address Pool
- **Name**: `app-tg` (kept the same name as the AWS target group, for easy side-by-side comparison)
- Both VMs' network interfaces are associated with this pool.

#### Health Probe
- **Protocol**: HTTP, **Path**: `/`, **Interval**: 30s, **Failures before unhealthy**: 2 — configured identically to the AWS target group's health check.

#### Load Balancing Rule
- **Port**: 80 → 80, using the backend pool and probe defined above — Azure's equivalent of AWS's Listener + default forwarding action.

---

## 5. File Structure

```
azure-terraform-project/
├── main.tf                    # Main Terraform configuration
├── terraform.tfvars           # Variable values
├── web-server-1-init.sh       # Bootstrap script for Web Server 1
├── web-server-2-init.sh       # Bootstrap script for Web Server 2
├── azure_vm_key.pem           # Auto-generated SSH private key (demo only!)
├── terraform.tfstate          # Current state file
└── terraform.tfstate.backup   # Backup state file
```

---

## 6. Configuration Files

### main.tf
Contains the AzureRM provider configuration, variable declarations, resource group, networking resources, NSG, VMs, load balancer configuration, and outputs — all in one file, mirroring the structure of the original AWS `main.tf`.

### terraform.tfvars
```hcl
location         = "East US"
vnet_cidr        = "10.0.0.0/16"
subnet_cidr      = "10.0.1.0/24"
admin_username   = "azureuser"
dns_label_prefix = "myapp-demo-2026"
```
**Note on `dns_label_prefix`:** This must be **globally unique across all of Azure** (it becomes part of a public DNS name like `myapp-demo-2026.eastus.cloudapp.azure.com`), so change it to something unique to you before deploying.

### web-server-1-init.sh (Web Server 1 Bootstrap Script)
```bash
#!/bin/bash
apt-get update
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "Hello from Web Server 1 (Azure)" > /var/www/html/index.html
```
**Purpose**: Identical to the AWS version's `test.sh` — installs Apache and serves a simple identifying page. Delivered via Azure's `custom_data` field (base64-encoded automatically by Terraform's `filebase64()` function), executed by cloud-init on boot — functionally the same mechanism as AWS's `user_data`.

### web-server-2-init.sh (Web Server 2 Bootstrap Script)
```bash
#!/bin/bash
apt-get update
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "Hello from Web Server 2 (Azure)" > /var/www/html/index.html
```

---

## 7. Variables

| Variable Name | Description | Type | Example Value |
|---|---|---|---|
| `location` | Azure region for deployment (Azure's equivalent of an AWS "region") | string | East US |
| `vnet_cidr` | CIDR block for the Virtual Network | string | 10.0.0.0/16 |
| `subnet_cidr` | CIDR block for the web subnet | string | 10.0.1.0/24 |
| `admin_username` | Login username for both VMs | string | azureuser |
| `dns_label_prefix` | Globally-unique prefix for the load balancer's public DNS name | string | myapp-demo-2026 |

---

## 8. Outputs

| Output Name | Description | Example Value |
|---|---|---|
| `resource_group_name` | Name of the created Resource Group | demo-rg |
| `vnet_id` | ID of the created Virtual Network | /subscriptions/.../virtualNetworks/demo-vnet |
| `subnet_id` | ID of the web subnet | /subscriptions/.../subnets/web-subnet |
| `load_balancer_public_ip` | Static public IP address of the load balancer | 20.121.45.10 |
| `load_balancer_fqdn` | Public DNS name of the load balancer (equivalent of AWS's ALB DNS name) | myapp-demo-2026.eastus.cloudapp.azure.com |
| `web_server1_private_ip` | Private IP of Web Server 1 | 10.0.1.4 |
| `web_server2_private_ip` | Private IP of Web Server 2 | 10.0.1.5 |

---

## 9. Deployment Steps

### Prerequisites
1. An Azure account/subscription with appropriate permissions.
2. Terraform installed (v1.0+).
3. Azure CLI installed and authenticated (`az login`), or a Service Principal configured for Terraform.
4. Appropriate role assignment (e.g., Contributor) on the target subscription/resource group.

### Step-by-Step Deployment

#### 1. Authenticate to Azure
```bash
az login
```
**What it does**: Opens a browser to sign in, and stores a session Terraform's AzureRM provider will use automatically — the Azure equivalent of configuring AWS CLI credentials.

#### 2. Initialize Terraform
```bash
terraform init
```
**What it does**:
- Downloads the AzureRM and TLS provider plugins.
- Initializes the backend.
- Prepares the working directory.

#### 3. Validate Configuration
```bash
terraform validate
```
**What it does**: Checks syntax and configuration validity, ensures all required variables are defined.

#### 4. Plan Infrastructure
```bash
terraform plan
```
**What it does**: Shows exactly what resources will be created — a dry run with zero real-world effect, letting you catch mistakes before anything actually gets built.

#### 5. Apply Configuration
```bash
terraform apply -auto-approve
```
**What it does**:
- Creates the Resource Group and all networking resources.
- Provisions both VMs with their bootstrap scripts.
- Configures the load balancer, backend pool, and health probe.
- Prints the outputs (load balancer IP/FQDN, VM private IPs, etc.).

#### 6. Verify Deployment
Access the load balancer's DNS name in a browser:
```
http://<load_balancer_fqdn>
```
You should see either:
- "Hello from Web Server 1 (Azure)" or
- "Hello from Web Server 2 (Azure)"

Refresh multiple times to see the load balancer distributing traffic between both VMs.

---

## 10. How It Works

### Traffic Flow
1. **User Request**: A user accesses the load balancer's public FQDN/IP over HTTP.
2. **Load Balancer**: Receives the request on its public frontend IP.
3. **Backend Pool + Probe**: The load balancer only forwards to VMs currently passing the health probe.
4. **Web Server**: The chosen VM (in the private subnet) receives the request via its private IP.
5. **Response**: Apache serves the HTML page.
6. **Return Path**: The response travels back through the load balancer to the user.

### High Availability
- **Multiple Zones**: The two VMs are deployed in Availability Zone 1 and Zone 2 respectively — if an entire zone has an outage, the other VM keeps serving traffic.
- **Load Balancing**: Traffic is distributed between both VMs.
- **Health Probes**: A VM that stops responding on `/` is automatically removed from rotation until it recovers.

### Security Features
1. **Network Isolation**: Web servers have no public IP at all — they're only reachable via the load balancer.
2. **NSG Chaining via Service Tag**: VMs only accept port 80 traffic tagged as coming from Azure's own load-balancer infrastructure (`AzureLoadBalancer`), not from the raw internet directly.
3. **NAT Gateway**: VMs can still reach the internet outbound (for updates) without needing a public IP of their own.
4. **Least Privilege**: The NSG has exactly one narrow inbound rule — nothing else is open.

---

## 11. Key Terraform and Azure Concepts Used

### Resource Dependencies
- **Implicit**: References like `azurerm_virtual_network.main.name` automatically tell Terraform to create the VNet before anything that references it — identical in spirit to AWS's implicit dependency style.
- **Explicit**: Not heavily needed here since Azure's resource-reference style naturally creates most orderings, but `depends_on` remains available for cases where no direct attribute reference exists.

### The "features {}" Block
Every AzureRM provider configuration requires an empty (or configured) `features {}` block — this has no AWS equivalent and is a common first-time gotcha (`terraform init`/`plan` will error without it).

### Custom Data vs User Data
Both work the same way in principle: a script handed to the VM at boot time, executed by cloud-init. Terraform's `filebase64()` function reads and encodes the script file, matching the base64 encoding Azure expects for `custom_data`.

### Availability Zones as a Resource Property
Unlike AWS (where you place a resource *into* a zone-specific subnet), Azure VMs declare their zone directly (`zone = "1"`) — the subnet itself is zone-agnostic.

### Outputs
Expose important values (load balancer address, VM private IPs) for verification and for other tooling/systems to consume — same purpose as the AWS project's outputs.

---

## 12. Best Practices Implemented

1. **Multi-Zone Deployment**: VMs spread across two Availability Zones.
2. **Narrow NSG Rules**: Only port 80 from the load balancer is allowed inbound; nothing else.
3. **No Public IPs on VMs**: Web servers are not directly exposed to the internet.
4. **NAT Gateway**: Secure, managed outbound internet access for private resources.
5. **Health Probes**: Automated detection and removal of unhealthy VMs from rotation.
6. **Tagging**: All resources tagged for identification and cost tracking.
7. **Variables**: Parameterized configuration (region, CIDRs, admin username) for easy reuse.
8. **Custom Data**: Automated VM configuration — Infrastructure as Code, not manual setup.

### A Note on the Auto-Generated SSH Key
This project generates an SSH key pair automatically via the `tls_private_key` resource purely so the demo works out of the box. **This is not a production practice** — a real deployment should either use a pre-existing key you manage yourself, or better yet, integrate with **Azure Key Vault** for key/secret management, so the private key never sits in your Terraform state file or local disk in plaintext.

---

## 13. Cost Considerations

### Billable Resources
- **Virtual Machines**: 2 × Standard_B1s (~$0.0104/hour each, similar tier to AWS t2.micro)
- **Azure Load Balancer (Standard SKU)**: ~$0.025/hour + data processing
- **NAT Gateway**: ~$0.045/hour + data processing (~$0.045/GB)
- **Public IPs (Standard, Static)**: Small hourly charge per IP (unlike AWS, where an Elastic IP is free while attached to a running resource — Azure charges for Standard SKU static IPs regardless)
- **Data Transfer**: Charges for outbound internet traffic

### Estimated Monthly Cost
Approximately **$40-55/month** depending on traffic volume — slightly higher than the AWS equivalent mainly due to Azure's Standard Public IP hourly charges, which AWS doesn't apply to an attached Elastic IP.

---

## 14. Troubleshooting

### Common Issues

**Problem**: Load balancer shows no healthy backend instances
- **Solution**: Check the NSG allows inbound port 80 from the `AzureLoadBalancer` service tag specifically.
- **Verify**: The health probe's path (`/`) actually returns HTTP 200 from Apache.
- **Check**: Apache is running on both VMs (`systemctl status apache2` via SSH or Azure's Run Command feature).

**Problem**: Can't access the load balancer's public IP/FQDN
- **Solution**: Confirm the Load Balancer's SKU and the Public IP's SKU both match (both must be "Standard" — mismatched SKUs are a common Azure-specific error).
- **Check**: The NSG isn't accidentally blocking inbound traffic somewhere in the chain.
- **Wait**: DNS propagation for the FQDN may take a few minutes.

**Problem**: VMs can't reach the internet for `apt-get update`
- **Solution**: Verify the NAT Gateway is associated with the subnet (`azurerm_subnet_nat_gateway_association`).
- **Check**: The NAT Gateway has a Public IP attached.
- **Verify**: The NSG's outbound rule actually allows the traffic.

**Problem**: `terraform apply` fails with a "features block is required" error
- **Solution**: This is the most common first-time AzureRM error — ensure your `provider "azurerm" { features {} }` block is present, even if empty.

### Verification Commands
```bash
# Check Terraform state
terraform show

# Verify outputs
terraform output

# Refresh state from Azure
terraform refresh

# View a specific resource
terraform state show azurerm_lb.app_lb

# Check VM status directly via Azure CLI
az vm list -d -g demo-rg -o table
```

---

## 15. Cleanup

To destroy all resources and avoid ongoing charges:

```bash
terraform destroy -auto-approve
```

**Warning**: This will delete all infrastructure including:
- Resource Group and everything inside it
- Virtual Network and subnet
- Virtual Machines and their network interfaces
- Load Balancer, backend pool, and public IP
- NAT Gateway and its public IP
- Network Security Group

Because every resource in this project lives inside one Resource Group, you could alternatively delete just the Resource Group directly via the Azure Portal or CLI (`az group delete --name demo-rg`) — but running `terraform destroy` is preferred since it keeps Terraform's state file in sync with reality.

---

## 16. Future Enhancements

1. **Autoscaling**: Replace fixed VMs with a **Virtual Machine Scale Set (VMSS)** for dynamic capacity — Azure's equivalent of an AWS Auto Scaling Group.
2. **HTTPS**: Add TLS termination — either on the Load Balancer with a certificate, or by upgrading to **Application Gateway**, which natively supports SSL/TLS and is Azure's true Layer-7 equivalent of an AWS ALB (path-based routing, WAF, host-based routing).
3. **Database**: Add an **Azure Database for PostgreSQL/MySQL** (managed) instance in the private subnet.
4. **Monitoring**: Integrate **Azure Monitor** and **Log Analytics** — the equivalent of AWS CloudWatch.
5. **Logging**: Enable diagnostic logging on the Load Balancer and NSG (NSG Flow Logs).
6. **Backup**: Configure **Azure Backup** for VM disk snapshots.
7. **CI/CD**: Integrate with **Azure DevOps Pipelines** or GitHub Actions for automated `plan`/`apply` on every change.
8. **Multiple Environments**: Use Terraform workspaces, or separate `.tfvars` files, for dev/staging/prod.
9. **Remote State**: Store state in an **Azure Storage Account** container, with state locking via the storage account's native blob leasing (Azure's equivalent of AWS's S3 + DynamoDB combination).
10. **Secrets Management**: Use **Azure Key Vault** for the VM SSH key and any other secrets, instead of the demo's auto-generated local key file.

---

## 17. Conclusion

This project demonstrates a production-ready, highly available web application infrastructure on Azure, built as a direct architectural port of an equivalent AWS project. The same core principles — network isolation, load-balanced compute, secure outbound-only internet access for private resources, and everything defined as version-controlled code — apply on both clouds, even though the specific resource types and a few structural details (subnets vs. zones, NSGs vs. Security Groups, the mandatory Resource Group container) differ.

Understanding *both* versions — and being able to explain exactly where and why they diverge — is exactly the kind of cross-cloud fluency that's valuable to demonstrate in a DevOps/Cloud interview.

---

## Resources and References

- [Terraform AzureRM Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Virtual Network Documentation](https://learn.microsoft.com/en-us/azure/virtual-network/)
- [Azure Load Balancer Documentation](https://learn.microsoft.com/en-us/azure/load-balancer/)
- [Azure Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

---

**Project Status**: Reference architecture — validate resource SKUs/quotas for your subscription before deploying.
**Terraform Version**: Compatible with Terraform 1.0+
**AzureRM Provider Version**: `~> 3.0`
