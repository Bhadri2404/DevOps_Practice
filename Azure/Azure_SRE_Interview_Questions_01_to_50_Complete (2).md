## Table of Contents — Questions 1–50

Click any question to jump directly to its answer.

### Azure Architecture, Networking and Private Connectivity (Questions 1–5)

- [Question 1: How would you design a secure three-tier application architecture in Azure? Explain VNets, subnets, NSGs, Azure Firewall, Application Gateway, private endpoints, and routing.](#question-1-how-would-you-design-a-secure-three-tier-application-architecture-in-azure-explain-vnets-subnets-nsgs-azure-firewall-application-gateway-private-endpoints-and-routing)
- [Question 2: How would you establish secure communication between two applications deployed in different Azure subscriptions? Explain VNet peering, Private Link, and alternative approaches.](#question-2-how-would-you-establish-secure-communication-between-two-applications-deployed-in-different-azure-subscriptions-explain-vnet-peering-private-link-and-alternative-approaches)
- [Question 3: Two Azure subscriptions have VNets with overlapping CIDR ranges. How would you establish communication between them without changing the existing application architecture?](#question-3-two-azure-subscriptions-have-vnets-with-overlapping-cidr-ranges-how-would-you-establish-communication-between-them-without-changing-the-existing-application-architecture)
- [Question 4: What is the difference between Azure Service Endpoints and Private Endpoints? Explain step by step how you would configure each for an Azure Storage Account.](#question-4-what-is-the-difference-between-azure-service-endpoints-and-private-endpoints-explain-step-by-step-how-you-would-configure-each-for-an-azure-storage-account)
- [Question 5: How would you configure VNet peering between two Azure subscriptions? What are the requirements, limitations, routing considerations, and troubleshooting steps?](#question-5-how-would-you-configure-vnet-peering-between-two-azure-subscriptions-what-are-the-requirements-limitations-routing-considerations-and-troubleshooting-steps)

### Azure Networking, Security, Governance (Questions 6–10)

- [Question 6: How would you secure an Azure VM in production? Explain network security, encryption, managed identities, patching, Bastion, Defender for Cloud, and monitoring.](#azure-q06)
- [Question 7: What is Azure Policy? Explain policy definitions, initiatives, assignments, effects, and remediation. How would you prevent VMs from having public IP addresses?](#azure-q07)
- [Question 8: What is the difference between Azure RBAC, Azure Policy, Microsoft Entra roles, and managed identities? How would you implement least privilege?](#azure-q08)
- [Question 9: How would you integrate an on-premises data center with Azure using VPN or ExpressRoute, and troubleshoot failures?](#azure-q09)
- [Question 10: A VM cannot reach an Azure database through a private endpoint. How do you troubleshoot NSGs, UDRs, Private DNS, Firewall, and connectivity?](#azure-q10)

### Load Balancing, Routing and Application Security (Questions 11–16)

- [Question 11: Compare Azure Load Balancer, Application Gateway, Azure Front Door, and Traffic Manager. Which would you select?](#azure-q11)
- [Question 12: How would you configure Azure Application Gateway with WAF, listeners, backend pools, HTTPS, and health probes?](#azure-q12)
- [Question 13: Application Gateway returns HTTP 502 but backend VMs are running. How do you troubleshoot?](#azure-q13)
- [Question 14: How would you implement hub-and-spoke architecture using Azure Firewall, route tables, and Private DNS?](#azure-q14)
- [Question 15: Compare NSG, Application Security Group, Azure Firewall, and WAF. How do you use them together?](#azure-q15)
- [Question 16: How would you troubleshoot asymmetric routing, DNS failures, and connection timeouts using Network Watcher?](#azure-q16)

### Azure Kubernetes Service (AKS) (Questions 17–24)

- [Question 17: How would you deploy and secure a production AKS cluster from scratch with networking, node pools, RBAC, managed identity, scaling, and monitoring?](#azure-q17)
- [Question 18: How would you troubleshoot an AKS pod stuck in CrashLoopBackOff?](#azure-q18)
- [Question 19: Explain the production AKS Kubernetes upgrade process with minimum downtime and recovery planning.](#azure-q19)
- [Question 20: AKS workloads are OOMKilled, CPU is high, and pods restart. How would you find the real problem?](#azure-q20)
- [Question 21: Compare HPA, VPA, Cluster Autoscaler, and KEDA. How would you scale AKS efficiently?](#azure-q21)
- [Question 22: How would you troubleshoot an AKS pod stuck in Pending or ImagePullBackOff?](#azure-q22)
- [Question 23: How would you implement secure AKS ingress/egress using Application Gateway, ACR, Key Vault, private endpoints, and workload identity?](#azure-q23)
- [Question 24: How would you migrate an on-premises Kubernetes application to AKS with minimal downtime and rollback?](#azure-q24)

### Azure Monitor, Centralized Logging and SRE (Questions 25–33)

- [Question 25: How would you implement centralized logging for Azure VMs, AKS, App Service and Azure SQL across multiple subscriptions?](#azure-q25)
- [Question 26: Explain step by step how to configure Azure Monitor, Log Analytics, AMA, DCR, diagnostic settings, alerts and Action Groups.](#azure-q26)
- [Question 27: Differentiate Azure Monitor, Log Analytics, Application Insights, Container Insights and managed Prometheus. How do they work together?](#azure-q27)
- [Question 28: How would you monitor CPU, memory, disk, latency, request failures and dependency health for a production application?](#azure-q28)
- [Question 29: How would you configure Azure Monitor alerts for CPU, HTTP 500 errors, latency, deployment failures and infrastructure availability?](#azure-q29)
- [Question 30: A production application is slow but CPU and memory are normal. How would you investigate logs, traces, network and database dependencies?](#azure-q30)
- [Question 31: How would you use KQL to investigate failed application requests, high-latency APIs, Azure resource errors and suspicious changes?](#azure-q31)
- [Question 32: Production logs suddenly stop appearing in Log Analytics. How would you troubleshoot AMA, DCR, diagnostics, permissions and connectivity?](#azure-q32)
- [Question 33: How would you define SLI, SLO, SLA and error budgets for a financial application, and automate incident alerting?](#azure-q33)

### Azure Storage, Event Hubs, Event Grid, Queues and PaaS (Questions 34–41)

- [Question 34: How would you securely connect an application in an Azure VNet to Azure Storage using Private Endpoint, service endpoint, DNS, managed identity and RBAC?](#azure-q34)
- [Question 35: Compare Event Hubs, Event Grid, Event Subscriptions, Azure Storage Queues and Service Bus. When would you use each?](#azure-q35)
- [Question 36: How would you configure Event Hubs for high-throughput ingestion? Explain partitions, consumer groups, checkpoints, security and monitoring.](#azure-q36)
- [Question 37: How would you trigger an Azure Function through Event Grid when a blob is uploaded? Explain filters, retries, delivery failure and dead-lettering.](#azure-q37)
- [Question 38: How would you implement Azure Storage Queue asynchronous processing, retries, visibility timeout, duplicate handling and worker scaling?](#azure-q38)
- [Question 39: An application cannot publish messages to Azure Event Hubs. How would you troubleshoot IAM, firewall, Private Endpoint, namespace and application logs?](#azure-q39)
- [Question 40: How would you deploy and secure Azure App Service with VNet integration, Private Endpoint, Key Vault, deployment slots and autoscaling?](#azure-q40)
- [Question 41: Azure Storage returns HTTP 403 from a VM or application. How do you troubleshoot firewall, DNS, SAS, managed identity and RBAC?](#azure-q41)

### Disaster Recovery, Migration, CI/CD, Cost and Azure AI (Questions 42–50)

- [Question 42: How would you design disaster recovery in Azure for low RTO and RPO? Compare active-active, active-passive, zones, replication and failover.](#azure-q42)
- [Question 43: How would you configure Azure Backup, Recovery Services Vault, Azure Site Recovery, backup policies and restore testing?](#azure-q43)
- [Question 44: What migration strategies would you use to move on-prem applications to Azure? Include rehost, replatform, refactor, databases, networking and rollback.](#azure-q44)
- [Question 45: An Azure DevOps production deployment fails midway. How would you troubleshoot pipeline logs, service connections, artifacts, approvals and rollback?](#azure-q45)
- [Question 46: How would you design a highly available application using VM Scale Sets, Availability Zones, Load Balancer, managed database and autoscaling?](#azure-q46)
- [Question 47: Application is completely down although Azure shows VMs and AKS clusters as healthy. How would you collect evidence and coordinate incident response?](#azure-q47)
- [Question 48: How would you optimize Azure cost using Advisor, reservations, savings plans, scaling, tags and Log Analytics controls?](#azure-q48)
- [Question 49: What is Azure AI Foundry (Microsoft Foundry), and how would you set up, secure, deploy and monitor an LLM application?](#azure-q49)
- [Question 50: What are Azure ML Workspace, model registry, managed online endpoints, MLOps, LLMOps, LangChain and agentic AI workflows?](#azure-q50)

---

# AZURE SRE INTERVIEW PREPARATION — QUESTIONS 1 TO 5

Role: Microsoft Azure SRE / DevOps Engineer Experience Level: 5+ Years Interview: State Street Client Format: Simple English + Detailed Practical Explanation + Production Scenarios

Each question follows the same four-point structure:

1. Concept — What it is, why we use it, and how it works.
2. Implementation — Step-by-step Azure Portal configuration and important commands.
3. Production Example — How to implement it in a real application.
4. Troubleshooting — Common issues, investigation steps, and solutions.

## Question 1: How would you design a secure three-tier application architecture in Azure? Explain VNets, subnets, NSGs, Azure Firewall, Application Gateway, private endpoints, and routing.

### 1. Concept

A three-tier architecture separates an application into three different layers to improve security, performance, scalability, and availability.

The three layers are:

- Web tier: Receives incoming requests from users and serves frontend content.
- Application tier: Handles application logic, APIs, authentication, and business operations.
- Database tier: Stores and manages application data.

In Azure, we use VNets and subnets to isolate these layers and control communication.

For security, we use:

| Azure Service                  | Purpose                                                               |
| ------------------------------ | --------------------------------------------------------------------- |
| Virtual Network (VNet)         | Provides a private network for application resources                  |
| Subnets                        | Separates the web, application, and database components               |
| Network Security Groups (NSGs) | Controls inbound and outbound traffic using network rules             |
| Application Gateway            | Distributes incoming HTTP/HTTPS requests and provides Layer 7 routing |
| Web Application Firewall (WAF) | Protects against common web attacks such as SQL injection and XSS     |
| Azure Firewall                 | Provides centralized network traffic filtering and inspection         |
| Private Endpoint               | Provides private connectivity to supported PaaS services              |
| User Defined Routes (UDRs)     | Controls the network path traffic follows                             |
| Azure Key Vault                | Securely manages secrets, certificates, and credentials               |

### 2. Implementation — Step by Step

Step 1: Create the Virtual Network

1. Open Azure Portal.
2. Navigate to Virtual Networks → Create.
3. Select the subscription and resource group.
4. Enter the VNet name, for example `prod-vnet`.
5. Configure the address space as `10.0.0.0/16`.
6. Create the required subnets.

Example subnet design:

| Subnet                  | CIDR        | Purpose                                    |
| ----------------------- | ----------- | ------------------------------------------ |
| appgw-subnet            | 10.0.1.0/24 | Application Gateway                        |
| web-subnet              | 10.0.2.0/24 | Frontend web servers                       |
| app-subnet              | 10.0.3.0/24 | Backend API servers                        |
| private-endpoint-subnet | 10.0.4.0/24 | Private endpoints for database and storage |

These are example address ranges; actual production sizing depends on capacity requirements.

Step 2: Configure NSGs

Navigate to Network Security Groups → Create, and associate the appropriate NSGs with application subnets.

Example traffic rules:

| Source               | Destination                 | Port | Action |
| -------------------- | --------------------------- | ---- | ------ |
| Internet             | Application Gateway         | 443  | Allow  |
| Application Gateway  | Web tier                    | 443  | Allow  |
| Web tier             | Application tier            | 8080 | Allow  |
| Application tier     | Database private endpoint   | 1433 | Allow  |
| Unauthorized sources | Sensitive application ports | Any  | Deny   |

Use least-privilege rules and evaluate both inbound and outbound traffic. Rules for the Application Gateway subnet must also preserve its required platform connectivity.

Step 3: Configure Application Gateway and WAF

1. Navigate to Application Gateways → Create.
2. Select the WAF_v2 SKU.
3. Select `prod-vnet` and `appgw-subnet`.
4. Configure a public frontend IP if the application is internet-facing.
5. Create an HTTPS listener and attach a TLS certificate.
6. Configure the backend pool containing the web servers.
7. Create backend settings, health probes, and routing rules.
8. Attach a WAF policy with appropriate managed rules.

Application Gateway will now receive HTTPS traffic and forward it to healthy web servers.

Step 4: Configure Azure Firewall and Routing

1. Create Azure Firewall in a dedicated hub VNet with its required `AzureFirewallSubnet`.
2. Peer the application VNet with the hub.
3. Create route tables for application subnets that must send outbound traffic through Azure Firewall.
4. Set the next hop to the firewall's private IP using `Virtual appliance`.
5. Associate the route tables with the required subnets.
6. Configure Firewall network and application rules.

Azure Firewall provides centralized traffic inspection. Peering, forwarding permissions, and return routing must also be configured correctly.

Step 5: Secure the Database and Storage

1. Create an Azure SQL Database or another suitable managed database.
2. Create a private endpoint in the private endpoint subnet.
3. Configure the required Private DNS zone.
4. Restrict or disable public network access after confirming private connectivity.
5. Use managed identities and appropriate database authorization instead of hardcoded credentials.
6. Store application secrets in Azure Key Vault.

Step 6: Enable Monitoring

Configure Azure Monitor, Application Insights, Log Analytics, Application Gateway access logs, and Azure Firewall logs.

Create alerts for application failures, high response times, unhealthy backends, and critical resource issues.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

+2



### 3. Production Example

Suppose we are deploying an online banking application using Azure.

The frontend runs on Azure VMs or App Service, the backend APIs run on AKS or VMs, and the database is Azure SQL.

The application traffic would flow like this:

Banking Customers

HTTPS requests — Port 443

Application Gateway + WAF

TLS, security rules, routing and health probes

Web Tier

Frontend application — private subnet

Application Tier

Backend APIs — private subnet

Database Tier

Azure SQL through Private Endpoint

NSGs • Firewall • Private DNS • Azure Monitor

For high availability, I would deploy multiple application instances across availability zones where supported, configure autoscaling, and use managed database high availability.

Users would access only the approved public application endpoint. Backend servers and databases would not be directly exposed to the internet.

### 4. Troubleshooting

Scenario: The frontend application is accessible, but users cannot complete transactions.

I would investigate the issue layer by layer.

1. Application Gateway: Check backend health, access logs, WAF logs, and HTTP response codes.
2. Web tier: Verify that the frontend is running and can communicate with the backend API.
3. NSG: Check whether port 8080 or the actual backend application port is allowed.
4. Azure Firewall: Check whether any firewall rule blocks traffic between components.
5. Routes: Use effective routes in Network Watcher to identify incorrect UDRs or missing return paths.
6. Database: Verify private endpoint connection status, DNS resolution, database availability, and authentication.
7. Monitoring: Use Application Insights dependency traces to identify whether the failure is in the application, networking, or database layer.

For network connectivity, I can use:

```
nslookup database-server.database.windows.net

nc -zv database-server.database.windows.net 1433

curl -v https://backend.example.com/health
```

Interview conclusion:

> I would secure each application tier using separate subnets, NSGs, private endpoints, managed identities, and centralized firewall controls. I would expose only the required frontend entry point and use Azure Monitor and Application Insights to identify performance and connectivity issues.

## Question 2: How would you establish secure communication between two applications deployed in different Azure subscriptions? Explain VNet peering, Private Link, and alternative approaches.

### 1. Concept

Azure resources can communicate privately even when they belong to different subscriptions.

For example:

- Subscription A: Frontend application in `VNet-A`.
- Subscription B: Backend API application in `VNet-B`.

There are multiple ways to establish connectivity.

| Method             | When to use                                                                                |
| ------------------ | ------------------------------------------------------------------------------------------ |
| VNet Peering       | Private network communication between VNets with non-overlapping IP ranges                 |
| Azure Private Link | Private access to a specific supported service, without opening broad network connectivity |
| Hub-and-Spoke      | Centralized networking, security, and routing across multiple subscriptions                |
| VPN Gateway        | Encrypted connectivity between supported networks                                          |
| ExpressRoute       | Dedicated private connectivity, typically for enterprise or hybrid networking              |

My first choice would depend on the requirement: VNet peering for general VNet-to-VNet communication, and Private Link for exposing only a specific service.

### 2. Implementation — Step by Step

Consider two subscriptions:

| Property      | Subscription A | Subscription B |
| ------------- | -------------- | -------------- |
| VNet          | VNet-A         | VNet-B         |
| Address space | 10.1.0.0/16    | 10.2.0.0/16    |
| Application   | Frontend       | Backend API    |

Approach 1: VNet Peering

1. Open Azure Portal and go to `VNet-A`.
2. Select Peerings → Add.
3. Choose the remote VNet from Subscription B.
4. Enable virtual network access.
5. Create the corresponding peering connection from `VNet-B` to `VNet-A`.
6. Verify that both peerings show `Connected`.
7. Configure NSG rules to allow the required application ports.
8. Configure DNS resolution if applications communicate using hostnames.

The VNets must have non-overlapping address spaces, and the required permissions must exist in both subscriptions.

Approach 2: Azure Private Link

Suppose Subscription B hosts an API behind a supported Azure Private Link Service configuration.

1. In Subscription B, place the API behind a supported Standard Load Balancer.
2. Configure Azure Private Link Service for the backend.
3. In Subscription A, create a Private Endpoint connected to that service.
4. Approve the private endpoint connection if required.
5. Configure DNS to resolve the backend application's name to the private endpoint IP.
6. Allow HTTPS communication through the required network and application security rules.

This allows Subscription A to access the backend through a private endpoint without providing general network access to Subscription B.

For PaaS services such as Azure SQL or Azure Storage, the resource's native Private Link capability can be used instead of building a custom Private Link Service.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

+1



### 3. Production Example

Suppose we have two teams:

- Application Team: Subscription A.
- Database Team: Subscription B.

The frontend application in Subscription A needs to access an Azure SQL Database in Subscription B.

I would use Azure Private Endpoint for the database because the application needs database connectivity, not access to the complete database VNet.

I would create the private endpoint in the application's VNet, configure DNS resolution for the database hostname, and grant the application identity the necessary database permissions.

For application-to-application communication where both VNets have compatible address ranges, I could use VNet peering instead.

In a larger organization with 20 subscriptions, I would consider a hub-and-spoke design with centralized Azure Firewall, DNS, and routing.

### 4. Troubleshooting

Scenario: After configuring VNet peering, the frontend cannot communicate with the backend.

I would check:

1. Peering status: Confirm both sides show `Connected`.
2. CIDR ranges: Verify that the VNet address spaces do not overlap.
3. NSGs: Verify that required inbound and outbound application ports are allowed.
4. Effective routes: Confirm traffic is routed to the peered VNet rather than to an incorrect next hop.
5. Azure Firewall: Check whether a centralized firewall is blocking the connection.
6. DNS: Verify that the hostname resolves to the correct backend IP.
7. Application: Confirm the backend process is listening on the expected port.

Useful commands:

```
nslookup backend.internal.example.com

nc -zv 10.2.1.4 443

curl -v https://backend.internal.example.com/health
```

If Private Link is used, I would additionally verify the private endpoint connection status, Private DNS configuration, and service-level authentication.

Interview conclusion:

> For cross-subscription connectivity, I would use VNet peering when applications need private network communication and their address ranges don't overlap. If the requirement is to securely access one specific Azure service, I would prefer Private Link with private DNS and least-privilege authentication.

## Question 3: Two Azure subscriptions have VNets with overlapping CIDR ranges. How would you establish communication between them without changing the existing application architecture?

### 1. Concept

In Azure, two VNets cannot be directly peered when their IP address ranges overlap.

For example:

| Property      | Subscription A | Subscription B |
| ------------- | -------------- | -------------- |
| VNet          | VNet-A         | VNet-B         |
| Address space | 10.0.0.0/16    | 10.0.0.0/16    |
| Application   | Frontend API   | Backend API    |

Both VNets use the same IP range.

If we try to establish VNet peering, Azure rejects the configuration because the overlapping IP addresses make routing ambiguous.

We can solve this using three main approaches:

Approach 1: Azure Private Link

This is a good option when an application needs to access a specific service in another VNet.

Private Link creates a private endpoint in the consuming VNet. The application communicates with that endpoint instead of directly routing to the other VNet's overlapping IP addresses.

Approach 2: Network Address Translation (NAT)

NAT translates IP addresses so overlapping networks can communicate through unique translated addresses.

For general network-to-network communication, this requires an appropriate NAT-capable network design, such as a supported network virtual appliance or gateway arrangement.

Approach 3: Change the VNet Address Space

We can migrate one VNet to a non-overlapping CIDR range, allowing normal VNet peering.

However, in an existing production environment, changing IP ranges can impact application connectivity, DNS, route tables, firewall rules, and dependencies.

Therefore, I would avoid renumbering unless broader VNet connectivity is genuinely required.

### 2. Implementation — Step by Step

Suppose the requirement is to connect a frontend application in Subscription A to a backend API in Subscription B.

I would consider Azure Private Link.

Step 1: Verify the overlapping CIDR ranges

Navigate to:

Azure Portal → Virtual Networks → Select VNet → Address Space.

Verify that both VNets use `10.0.0.0/16`.

We can also check using Azure CLI:

```
az network vnet show \
  --resource-group rg-app \
  --name vnet-a \
  --query "addressSpace.addressPrefixes"
```

Step 2: Configure the backend application

In Subscription B:

1. Ensure the backend API is running and listening on the required port.
2. Place the backend behind an internal Standard Load Balancer, where supported.
3. Create an Azure Private Link Service connected to the supported load balancer configuration.
4. Configure the permitted consumer subscriptions.
5. Record the Private Link Service resource ID.

Step 3: Create a private endpoint

In Subscription A:

1. Navigate to Private Endpoints → Create.
2. Select the subscription and resource group.
3. Choose the private endpoint's VNet and subnet.
4. Connect using the Private Link Service resource ID.
5. Submit the connection request.
6. Approve the connection from Subscription B if approval is required.

The private endpoint receives an IP address from Subscription A's VNet.

Step 4: Configure DNS

Create or update the internal DNS record so the frontend resolves the backend API hostname to the private endpoint IP.

For example:

```
backend.internal.example.com -> 10.0.1.10
```

Here, `10.0.1.10` represents the private endpoint address inside the consuming VNet.

Step 5: Validate the connection

```
nslookup backend.internal.example.com
```

```
curl -v https://backend.internal.example.com/health
```

The frontend connects to its local private endpoint. Private Link delivers the traffic to the supported backend service without needing VNet-to-VNet peering.

Important: Azure VPN Gateway NAT is not a general solution for directly peering two overlapping Azure VNets. Its documented NAT support primarily addresses overlapping on-premises/branch-to-Azure connectivity. Azure Private Link or a purpose-designed NAT/proxy architecture is more suitable here.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

+3



### 3. Production Example

Consider a company with two departments:

- The payments team has an application in Subscription A.
- The transaction-processing team has a backend API in Subscription B.

Both environments were created independently, and both use `10.0.0.0/16`.

The payments application needs to call only the transaction-processing API.

Instead of redesigning both networks, I would expose the backend API through an appropriate Private Link Service configuration.

The payments application would access the API using a private endpoint in its own VNet.

This provides private service-level connectivity without changing the application servers' existing IP addresses.

For general server-to-server communication requiring many protocols, I would evaluate a NAT-capable architecture or a planned IP readdressing exercise instead.

### 4. Troubleshooting

Scenario: The private endpoint is created, but the frontend still cannot reach the backend.

I would investigate:

1. Connection status: Verify that the private endpoint connection is Approved.
2. DNS: Confirm the backend hostname resolves to the private endpoint IP.
3. NSGs: Verify that frontend outbound traffic and relevant backend traffic are permitted.
4. Private Link Service: Verify the backend load balancer and service configuration.
5. Backend health: Confirm the application is running and responding on the configured port.
6. Routing: Check effective routes and confirm the application is not trying to connect directly to the overlapping remote IP.
7. Application logs: Check whether the connection fails at the network, TLS, authentication, or application layer.

Interview conclusion:

> When two VNets have overlapping address ranges, direct VNet peering is not supported. I would prefer Azure Private Link when only specific service connectivity is required. For broader network communication, I would evaluate a supported NAT architecture or plan a controlled VNet readdressing migration.

## Question 4: What is the difference between Azure Service Endpoints and Private Endpoints? Explain step by step how you would configure each for an Azure Storage Account.

### 1. Concept

Both Azure Service Endpoints and Private Endpoints help securely connect resources inside a VNet to supported Azure PaaS services, such as Azure Storage.

But they work differently.

Service Endpoint

A Service Endpoint extends the identity of an Azure VNet subnet to a supported Azure service.

It allows the service firewall to restrict access to specific authorized subnets.

The Azure service continues to use its public endpoint, but traffic from the Azure VNet uses the Azure backbone.

Private Endpoint

A Private Endpoint creates a private network interface with an IP address from our VNet.

The application accesses the Azure service through this private IP instead of its public endpoint.

Private Endpoints are particularly useful when we want to disable public network access entirely.

### Main Differences

| Feature                       | Service Endpoint                                      | Private Endpoint                                         |
| ----------------------------- | ----------------------------------------------------- | -------------------------------------------------------- |
| Destination IP                | Azure service public IP                               | Private IP from VNet                                     |
| Network access                | Public service endpoint with subnet restrictions      | Private Link connection                                  |
| Private DNS                   | Usually not required                                  | Required for normal hostname-based access                |
| Cross-subscription access     | Supported with applicable restrictions                | Supported                                                |
| Overlapping VNet support      | Doesn't provide direct cross-VNet communication       | Can expose a supported service across overlapping VNets  |
| Disable service public access | Not generally compatible with service endpoint access | Supported for compatible services                        |
| Additional endpoint charges   | No separate service endpoint charge                   | Private Link pricing applies                             |
| Typical usage                 | Restricting PaaS access to selected subnets           | Private PaaS connectivity and stronger network isolation |

### 2. Implementation — Step by Step

Suppose we have:

- Application VM inside `VNet-A`.
- Subnet named `app-subnet`.
- Storage Account named `mystorageaccount`.
- Requirement: Allow the application to access Azure Blob Storage securely.

### Approach A: Configure Service Endpoint

Step 1: Enable the Service Endpoint

1. Go to Azure Portal.
2. Open Virtual Networks.
3. Select `VNet-A`.
4. Navigate to Subnets.
5. Select `app-subnet`.
6. Under Service Endpoints, select `Microsoft.Storage`.
7. Save the configuration.

We can also configure it using Azure CLI:

```
az network vnet subnet update \
  --resource-group rg-app \
  --vnet-name VNet-A \
  --name app-subnet \
  --service-endpoints Microsoft.Storage
```

Step 2: Configure the Storage Account firewall

1. Open the Storage Account.
2. Navigate to Security + networking → Networking.
3. Select the option to enable public network access from selected networks.
4. Add the existing `VNet-A` and `app-subnet`.
5. Save the network configuration.

The storage firewall now allows network traffic from the selected subnet.

Step 3: Configure Storage Authentication

Network access alone is not enough.

I would assign the application's managed identity an appropriate data role, such as `Storage Blob Data Reader` or `Storage Blob Data Contributor`, depending on the requirement.

Step 4: Test Access

From the VM:

```
nslookup mystorageaccount.blob.core.windows.net
```

With Service Endpoints, the hostname normally resolves to the public service endpoint, while Azure routes qualifying subnet traffic over its backbone.

### Approach B: Configure Private Endpoint

Step 1: Create the Private Endpoint

1. Open Azure Portal → Private Endpoints.
2. Select Create.
3. Choose the resource group and region.
4. Select the Azure Storage Account as the target resource.
5. Choose the `blob` subresource.
6. Select `VNet-A`.
7. Select the subnet for the private endpoint.
8. Enable Private DNS integration.
9. Create the private endpoint.

For Blob Storage, the Private DNS zone is:

```
privatelink.blob.core.windows.net
```

Step 2: Configure Private DNS

Ensure the Private DNS zone is linked to the application's VNet.

A DNS lookup of the normal Storage Account hostname should resolve through the Private Link DNS configuration to the endpoint's private IP.

Step 3: Disable Public Network Access

Once the private endpoint has been tested successfully:

1. Open the Storage Account.
2. Navigate to Networking.
3. Change Public network access to Disabled.
4. Save the configuration.

Step 4: Configure Identity and RBAC

Assign the application's managed identity the required Storage Blob Data role.

Use Microsoft Entra authentication where supported rather than embedding storage account keys inside application code.

Step 5: Validate

From an application VM:

```
nslookup mystorageaccount.blob.core.windows.net
```

Expected result: a private address such as `10.0.4.10` in the DNS resolution chain.

Then verify connectivity:

```
curl -I https://mystorageaccount.blob.core.windows.net
```

An HTTP 403 or 400 response can still show that the HTTPS endpoint is reachable; it does not by itself prove that Storage authorization is working. Use an authenticated Blob operation for the final validation.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

+2



### 3. Production Example

Suppose an Azure application processes confidential customer documents and saves the files to an Azure Storage Account.

For this requirement, I would prefer a Private Endpoint.

My configuration would include:

- Application VMs or AKS workloads in private subnets.
- An Azure Storage Account with public network access disabled.
- A private endpoint connected to the storage account's Blob service.
- A Private DNS zone for storage name resolution.
- Managed identity with minimum required Blob permissions.
- Azure Monitor diagnostic settings for operational and security monitoring.

The application communicates with storage through the private endpoint, without requiring access to the storage account's public endpoint.

For a simpler internal workload where selected-subnet access is acceptable, a Service Endpoint may also be suitable.

### 4. Troubleshooting

Scenario: The application cannot access the Storage Account and receives HTTP 403 or connection timeout errors.

I would investigate differently based on the endpoint type.

For a Service Endpoint:

1. Verify that `Microsoft.Storage` is enabled on the correct subnet.
2. Confirm the storage firewall allows that subnet.
3. Check whether Public network access is configured to allow selected networks.
4. Verify the application's identity has the correct data-plane RBAC role.
5. Check network routes and DNS resolution.

For a Private Endpoint:

1. Confirm the private endpoint status is Approved.
2. Verify the private DNS zone is linked to the correct VNet.
3. Confirm the Storage Account hostname resolves to the private IP.
4. Check NSGs and route-table restrictions where applicable.
5. Verify Storage RBAC, SAS validity, or application authentication.
6. Use Network Watcher or TCP connectivity tests to identify connection failures.

Useful commands:

```
nslookup mystorageaccount.blob.core.windows.net
```

```
nc -zv mystorageaccount.blob.core.windows.net 443
```

Interview conclusion:

> Service Endpoints secure access to the public endpoint of an Azure service by restricting access to selected VNet subnets. Private Endpoints provide a private IP inside the VNet. For sensitive production applications, I would generally choose Private Endpoint, private DNS, and managed identity authentication when the service supports them.

## Question 5: How would you configure VNet peering between two Azure subscriptions? What are the requirements, limitations, routing considerations, and troubleshooting steps?

### 1. Concept

Azure VNet peering connects two virtual networks privately using Microsoft's backbone network.

After peering, resources in both VNets can communicate using private IP addresses, subject to network security rules and routing.

VNet peering supports:

- VNets in the same Azure region.
- VNets in different supported Azure regions, using global VNet peering.
- VNets in different Azure subscriptions.
- VNets in different Microsoft Entra tenants when the required permissions and cross-tenant configuration are in place.

Important requirements:

1. The VNet address spaces must not overlap.
2. The required permissions must exist on both VNets.
3. Both sides of the peering must be configured.
4. NSGs, firewalls, and routes must allow the intended communication.
5. VNet peering is not transitive by default.

For example, if VNet-A is peered with VNet-B and VNet-B is peered with VNet-C, that does not automatically allow VNet-A to communicate with VNet-C.

### 2. Implementation — Step by Step

Suppose we have:

| Property       | Subscription A | Subscription B |
| -------------- | -------------- | -------------- |
| Resource group | rg-app-a       | rg-app-b       |
| VNet           | vnet-a         | vnet-b         |
| Address space  | 10.1.0.0/16    | 10.2.0.0/16    |

### Method 1: Azure Portal

Step 1: Check Permissions

Ensure the administrator or deployment identity has the necessary network peering permissions in both subscriptions.

The built-in Network Contributor role is a common choice for the network setup.

If the subscriptions belong to different Microsoft Entra tenants, cross-tenant access or guest permissions must be configured.

Step 2: Create Peering from VNet-A

1. Open Azure Portal.
2. Navigate to Virtual Networks.
3. Open `vnet-a`.
4. Select Peerings → Add.
5. Select the option to connect to another virtual network.
6. Choose Subscription B and `vnet-b`, if the remote VNet is accessible.
7. Enable virtual network access.
8. Create the peering.

Step 3: Configure the Reverse Peering

Create the corresponding peering from `vnet-b` to `vnet-a`.

When both sides are configured correctly, the peering status should show:

```
Connected
```

Step 4: Configure NSGs

Suppose Application A must access Application B on HTTPS.

Allow the required traffic, for example:

```
Source:       10.1.0.0/16
Destination:  10.2.1.4
Protocol:     TCP
Port:         443
Action:       Allow
```

Configure the relevant source outbound and destination inbound rules.

Step 5: Verify Routing

Azure automatically creates system routes for the peered VNet address space.

I would check the VM network interface's effective routes to confirm traffic uses the `Virtual network peering` next hop.

If the architecture uses Azure Firewall or another network virtual appliance, I would also check UDRs, forwarded-traffic settings, and return routes.

### Method 2: Azure CLI

First, collect the VNet resource IDs from both subscriptions.

```
# Subscription A
az account set --subscription "<subscription-A-ID>"

VNET_A_ID=$(az network vnet show \
  --resource-group rg-app-a \
  --name vnet-a \
  --query id -o tsv)

# Subscription B
az account set --subscription "<subscription-B-ID>"

VNET_B_ID=$(az network vnet show \
  --resource-group rg-app-b \
  --name vnet-b \
  --query id -o tsv)
```

Now create the peering from A to B.

```
az account set --subscription "<subscription-A-ID>"

az network vnet peering create \
  --name peer-a-to-b \
  --resource-group rg-app-a \
  --vnet-name vnet-a \
  --remote-vnet "$VNET_B_ID" \
  --allow-vnet-access
```

Create the reverse peering from B to A.

```
az account set --subscription "<subscription-B-ID>"

az network vnet peering create \
  --name peer-b-to-a \
  --resource-group rg-app-b \
  --vnet-name vnet-b \
  --remote-vnet "$VNET_A_ID" \
  --allow-vnet-access
```

Verify the peering status:

```
az network vnet peering list \
  --resource-group rg-app-b \
  --vnet-name vnet-b \
  --output table
```

Both peerings should become `Connected`.

For different Entra tenants, the CLI authentication context must also be valid in the appropriate tenant; simply changing the subscription is not sufficient unless the signed-in identity has the necessary access.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn

+2



### 3. Production Example

Suppose an organization uses separate subscriptions for different application teams.

Subscription A contains frontend web applications, and Subscription B contains backend services.

For example:

Subscription A

Frontend Application

### 10.1.0.0/16

vnet-a

Subscription B

Backend API

### 10.2.0.0/16

vnet-b

Private VNet Peering

Traffic travels over the Azure backbone, subject to NSG, routing, firewall, and application controls.

I would configure VNet peering so the frontend securely communicates with the backend using private IP addresses.

I would also configure:

- NSGs allowing only the required ports.
- Private DNS resolution for application hostnames.
- Azure Firewall if centralized traffic inspection is required.
- Azure Monitor and network diagnostics.
- Infrastructure-as-Code using Terraform to manage the peering configuration.

This design allows each team to maintain separate subscriptions while enabling controlled connectivity.

### 4. Troubleshooting

Scenario: VNet peering shows Connected, but applications cannot communicate.

I would follow these checks.

Step 1: Verify Peering Status

```
az network vnet peering list \
  --resource-group rg-app-a \
  --vnet-name vnet-a \
  --output table
```

Confirm both sides show `Connected`.

Step 2: Check Address Spaces

Verify that neither VNet overlaps with the other.

```
az network vnet show \
  --resource-group rg-app-a \
  --name vnet-a \
  --query "addressSpace.addressPrefixes"
```

Step 3: Check NSG Rules

Open Network Watcher → IP Flow Verify or inspect effective security rules.

Check that the source and destination ports are allowed.

Step 4: Check Effective Routes

Use Network Watcher or the network interface's effective routes to verify that traffic is forwarded correctly.

If a UDR sends the traffic to Azure Firewall or a network virtual appliance, confirm that device allows and forwards the traffic and that return routing works.

Step 5: Check DNS

Try accessing the destination through both its private IP and hostname.

```
nslookup backend.internal.example.com
```

```
nc -zv 10.2.1.4 443
```

If direct IP connectivity works but hostname access fails, investigate DNS configuration.

VNet peering does not automatically provide cross-VNet hostname resolution for every DNS setup.

Step 6: Check Application Logs

If network connectivity works, check:

- Whether the application process is running.
- Whether the required port is listening.
- Application authentication errors.
- Backend health and application logs.

Interview conclusion:

> I would configure VNet peering between two subscriptions using the Azure Portal, Terraform, or Azure CLI. Before configuring it, I would validate IP ranges and permissions. After deployment, I would check peering status, NSGs, effective routes, DNS, and application connectivity. For production, I would manage the configuration through Terraform and enforce security controls.

## Final Revision — All Five Questions

| Question                                 | Main points to remember                                                                                                    |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| Q1: Three-tier architecture              | VNet → Subnets → NSGs → Application Gateway/WAF → Azure Firewall → Private Endpoints → Monitoring                          |
| Q2: Cross-subscription connectivity      | VNet peering for private network access, Private Link for service-level access, hub-and-spoke for centralized architecture |
| Q3: Overlapping CIDR ranges              | Direct peering not supported → Private Link for supported services → NAT architecture or controlled readdressing           |
| Q4: Service Endpoint vs Private Endpoint | Public service endpoint with subnet restriction vs private IP and private DNS                                              |
| Q5: VNet Peering                         | Permissions → Non-overlapping CIDRs → Both peering connections → NSG and routing → DNS → Troubleshooting                   |

These first five answers are intended to be detailed study notes that you can simplify while speaking in the interview. The implementation and troubleshooting parts are important because a senior-level interviewer may ask follow-up questions based on each service you mention.

Review the depth, language, and format. If this works for you, the same four-point structure can be used for the remaining Azure questions and then for Terraform and Python.

---

# Azure SRE Interview Preparation — Questions 6–50

**Role:** Microsoft Azure Site Reliability / DevOps Engineer (5+ years)  
**Focus:** State Street client-style production scenarios; Azure, networking, security, AKS, observability, messaging, DR, AI  
**Format for every answer:** 1. Concept · 2. Implementation · 3. Production Example · 4. Troubleshooting  
**Note:** Example names, CIDRs, thresholds, and commands are illustrative; check production-specific region, SKU, permissions, and organization policy. Questions 1–5 are in your previously approved notes. This document continues from Question 6.


## Table of Contents

This table of contents links directly to every question. Each answer follows **Concept → Implementation → Production Example → Troubleshooting**.

### [Section A — Azure Networking and Security (Questions 6–10)](#azure-section-a)

- [Q06. How would you secure an Azure VM in production? Explain network security, encryption, managed identities, patching, Bastion, Defender for Cloud, and monitoring.](#azure-q06)
- [Q07. What is Azure Policy? Explain policy definitions, initiatives, assignments, effects, and remediation. How would you prevent VMs from having public IP addresses?](#azure-q07)
- [Q08. What is the difference between Azure RBAC, Azure Policy, Microsoft Entra roles, and managed identities? How would you implement least privilege?](#azure-q08)
- [Q09. How would you integrate an on-premises data center with Azure using VPN or ExpressRoute, and troubleshoot failures?](#azure-q09)
- [Q10. A VM cannot reach an Azure database through a private endpoint. How do you troubleshoot NSGs, UDRs, Private DNS, Firewall, and connectivity?](#azure-q10)

### [Section B — Load Balancing, Routing and Application Security (Questions 11–16)](#azure-section-b)

- [Q11. Compare Azure Load Balancer, Application Gateway, Azure Front Door, and Traffic Manager. Which would you select?](#azure-q11)
- [Q12. How would you configure Azure Application Gateway with WAF, listeners, backend pools, HTTPS, and health probes?](#azure-q12)
- [Q13. Application Gateway returns HTTP 502 but backend VMs are running. How do you troubleshoot?](#azure-q13)
- [Q14. How would you implement hub-and-spoke architecture using Azure Firewall, route tables, and Private DNS?](#azure-q14)
- [Q15. Compare NSG, Application Security Group, Azure Firewall, and WAF. How do you use them together?](#azure-q15)
- [Q16. How would you troubleshoot asymmetric routing, DNS failures, and connection timeouts using Network Watcher?](#azure-q16)

### [Section C — Azure Kubernetes Service (Questions 17–24)](#azure-section-c)

- [Q17. How would you deploy and secure a production AKS cluster from scratch with networking, node pools, RBAC, managed identity, scaling, and monitoring?](#azure-q17)
- [Q18. How would you troubleshoot an AKS pod stuck in CrashLoopBackOff?](#azure-q18)
- [Q19. Explain the production AKS Kubernetes upgrade process with minimum downtime and recovery planning.](#azure-q19)
- [Q20. AKS workloads are OOMKilled, CPU is high, and pods restart. How would you find the real problem?](#azure-q20)
- [Q21. Compare HPA, VPA, Cluster Autoscaler, and KEDA. How would you scale AKS efficiently?](#azure-q21)
- [Q22. How would you troubleshoot an AKS pod stuck in Pending or ImagePullBackOff?](#azure-q22)
- [Q23. How would you implement secure AKS ingress/egress using Application Gateway, ACR, Key Vault, private endpoints, and workload identity?](#azure-q23)
- [Q24. How would you migrate an on-premises Kubernetes application to AKS with minimal downtime and rollback?](#azure-q24)

### [Section D — Azure Monitor, Centralized Logging and SRE (Questions 25–33)](#azure-section-d)

- [Q25. How would you implement centralized logging for Azure VMs, AKS, App Service and Azure SQL across multiple subscriptions?](#azure-q25)
- [Q26. Explain step by step how to configure Azure Monitor, Log Analytics, AMA, DCR, diagnostic settings, alerts and Action Groups.](#azure-q26)
- [Q27. Differentiate Azure Monitor, Log Analytics, Application Insights, Container Insights and managed Prometheus. How do they work together?](#azure-q27)
- [Q28. How would you monitor CPU, memory, disk, latency, request failures and dependency health for a production application?](#azure-q28)
- [Q29. How would you configure Azure Monitor alerts for CPU, HTTP 500 errors, latency, deployment failures and infrastructure availability?](#azure-q29)
- [Q30. A production application is slow but CPU and memory are normal. How would you investigate logs, traces, network and database dependencies?](#azure-q30)
- [Q31. How would you use KQL to investigate failed application requests, high-latency APIs, Azure resource errors and suspicious changes?](#azure-q31)
- [Q32. Production logs suddenly stop appearing in Log Analytics. How would you troubleshoot AMA, DCR, diagnostics, permissions and connectivity?](#azure-q32)
- [Q33. How would you define SLI, SLO, SLA and error budgets for a financial application, and automate incident alerting?](#azure-q33)

### [Section E — Storage, Event Hubs, Event Grid, Queues and PaaS (Questions 34–41)](#azure-section-e)

- [Q34. How would you securely connect an application in an Azure VNet to Azure Storage using Private Endpoint, service endpoint, DNS, managed identity and RBAC?](#azure-q34)
- [Q35. Compare Event Hubs, Event Grid, Event Subscriptions, Azure Storage Queues and Service Bus. When would you use each?](#azure-q35)
- [Q36. How would you configure Event Hubs for high-throughput ingestion? Explain partitions, consumer groups, checkpoints, security and monitoring.](#azure-q36)
- [Q37. How would you trigger an Azure Function through Event Grid when a blob is uploaded? Explain filters, retries, delivery failure and dead-lettering.](#azure-q37)
- [Q38. How would you implement Azure Storage Queue asynchronous processing, retries, visibility timeout, duplicate handling and worker scaling?](#azure-q38)
- [Q39. An application cannot publish messages to Azure Event Hubs. How would you troubleshoot IAM, firewall, Private Endpoint, namespace and application logs?](#azure-q39)
- [Q40. How would you deploy and secure Azure App Service with VNet integration, Private Endpoint, Key Vault, deployment slots and autoscaling?](#azure-q40)
- [Q41. Azure Storage returns HTTP 403 from a VM or application. How do you troubleshoot firewall, DNS, SAS, managed identity and RBAC?](#azure-q41)

### [Section F — Disaster Recovery, Migration, CI/CD, Cost and Azure AI (Questions 42–50)](#azure-section-f)

- [Q42. How would you design disaster recovery in Azure for low RTO and RPO? Compare active-active, active-passive, zones, replication and failover.](#azure-q42)
- [Q43. How would you configure Azure Backup, Recovery Services Vault, Azure Site Recovery, backup policies and restore testing?](#azure-q43)
- [Q44. What migration strategies would you use to move on-prem applications to Azure? Include rehost, replatform, refactor, databases, networking and rollback.](#azure-q44)
- [Q45. An Azure DevOps production deployment fails midway. How would you troubleshoot pipeline logs, service connections, artifacts, approvals and rollback?](#azure-q45)
- [Q46. How would you design a highly available application using VM Scale Sets, Availability Zones, Load Balancer, managed database and autoscaling?](#azure-q46)
- [Q47. Application is completely down although Azure shows VMs and AKS clusters as healthy. How would you collect evidence and coordinate incident response?](#azure-q47)
- [Q48. How would you optimize Azure cost using Advisor, reservations, savings plans, scaling, tags and Log Analytics controls?](#azure-q48)
- [Q49. What is Azure AI Foundry (Microsoft Foundry), and how would you set up, secure, deploy and monitor an LLM application?](#azure-q49)
- [Q50. What are Azure ML Workspace, model registry, managed online endpoints, MLOps, LLMOps, LangChain and agentic AI workflows?](#azure-q50)

---

<a id="azure-section-a"></a>
# Section A — Azure Networking and Security (Questions 6–10)

<a id="azure-q06"></a>
## Question 6: How would you secure an Azure VM in production? Explain network security, encryption, managed identities, patching, Bastion, Defender for Cloud, and monitoring.

### 1. Concept
A production VM needs **defense in depth**, not just an NSG. I secure the network, operating system, identity, data, and audit trail. The preferred setup is **no public IP**, private subnet, tightly scoped access, encrypted disks, centrally managed secrets, regular patches, and continuous monitoring. Azure Bastion provides an administrative connection without opening RDP/SSH to the internet; Defender for Cloud helps assess posture and detect threats.

| Area | Control | Why |
|---|---|---|
| Network | No public IP, NSG, Azure Firewall, private endpoint | Minimize exposure |
| Access | Entra RBAC, Bastion, PIM, managed identity | No shared administrator credentials |
| OS | Harden baseline, patch, endpoint protection | Reduce vulnerabilities |
| Data | Managed disk encryption, Key Vault/CMK if required | Protect data and keys |
| Monitoring | Azure Monitor Agent, DCR, logs, alerts | Detect operational and security issues |

### 2. Implementation — step by step
1. **Create network:** Azure Portal → Virtual Networks → create a private VM subnet. Attach an NSG with only necessary application traffic; deny unnecessary inbound paths.
2. **Create VM:** Virtual Machines → Create; pick a supported secure image and Trusted Launch where suitable; **Public inbound ports: None** and no public IP.
3. **Administrator access:** Create Azure Bastion in its required dedicated subnet; grant time-limited access with appropriate RBAC/PIM. For some scenarios enable Defender for Cloud Just-in-Time access where supported.
4. **Identity and secrets:** VM → Identity → enable system-assigned managed identity. Grant the identity only needed Key Vault or Storage data roles; don't put secrets in custom-data scripts.
5. **Encrypt and patch:** Use managed-disk encryption (platform-managed keys by default; CMK if policy requires), Azure Update Manager, hardened OS configuration, Defender for Servers if licensed.
6. **Collect evidence:** Create Log Analytics Workspace → install Azure Monitor Agent → associate a DCR for Syslog/Windows Events and performance counters → alerts and Action Groups. Send Activity Logs and applicable resource logs through diagnostic settings.
7. **Govern:** Assign Azure Policies to audit/deny public IPs, enforce allowed regions, diagnostic settings, and secure configurations. Roll out with Terraform and approval.

**Useful check:**
```bash
az vm show -g rg-prod -n vm-api-01 --query '{name:name,identity:identity.type,security:securityProfile.securityType}' -o json
az vm get-instance-view -g rg-prod -n vm-api-01 --query 'instanceView.statuses[].displayStatus' -o tsv
```

### 3. Production Example
For a financial transaction-processing VM, I place it behind an internal load balancer, allow API traffic only from the approved subnet, and connect to Azure SQL via a private endpoint. Operators use Bastion and approved RBAC. Application code reads secrets using managed identity. Azure Monitor gathers guest events; patch windows and recovery points are scheduled, with the changes auditable.

### 4. Troubleshooting
**Scenario:** Security sees repeated SSH attempts or the VM becomes unreachable.
1. Check the NIC for an accidental public IP and review NSG effective rules; close unexpected ingress first.
2. Examine Activity Log for changes, OS authentication logs in Log Analytics, Defender incidents, and Azure Firewall logs.
3. Check Bastion connectivity, guest firewall, VM power/agent/boot diagnostics, and whether the VM is listening on the port.
4. Contain a suspected compromised instance, preserve logs/snapshots according to incident policy, rotate exposed credentials, restore from trusted images if necessary.
5. Confirm patches, policy compliance, role assignments and alert coverage after recovery.

**Interview conclusion:** “I use private networking, least privilege, hardened and patched OS images, managed identity, encrypted storage, and centralized security monitoring, then validate them continuously with Azure Policy.”

---

<a id="azure-q07"></a>
## Question 7: What is Azure Policy? Explain policy definitions, initiatives, assignments, effects, and remediation. How would you prevent VMs from having public IP addresses?

### 1. Concept
**Azure Policy** evaluates resource properties against governance rules. A **definition** contains conditions and an effect; an **assignment** applies it to a management group, subscription, resource group or resource scope; an **initiative** groups definitions. **Compliance** reports resources that meet or violate the policy. RBAC controls *who can act*; Policy controls *what configurations are allowed or audited*.

Important effects include **Deny** (reject qualifying new/updated requests), **Audit**, **Modify**, **DeployIfNotExists**, and **AuditIfNotExists**. Deny does not automatically remove existing public IPs. DeployIfNotExists/Modify often require a managed identity and remediation tasks for existing resources.

### 2. Implementation — step by step
1. Azure Portal → Policy → Definitions → search for a built-in rule restricting public IP use; prefer a built-in if it matches the business requirement. To write a custom rule, define a narrowly scoped condition on `Microsoft.Network/publicIPAddresses` or on the association between a VM NIC and a public IP, depending on the requirement.
2. Select Policy → Definitions → Create policy definition; give it a name, mode, metadata, `policyRule` and parameters. Test with **Audit** in dev first.
3. Go to Policy → Assignments → Assign policy; choose subscription or management-group scope, optional excluded scopes, parameters, enforcement mode, and noncompliance message.
4. After a controlled pilot, use Deny for *new public IP resource creation* if that is the intended security control. Be careful: denying creation of **all** public IP resources also affects approved gateways/load balancers; use exemptions or a more targeted resource rule.
5. Policy → Compliance → review noncompliant resources and policy events. Existing exposures need approved manual remediation or an appropriate automated workflow.

**Illustrative custom definition (blocks creation of public IP resources, not merely VM associations):**
```json
{
  "mode": "All",
  "policyRule": {
    "if": {"field": "type", "equals": "Microsoft.Network/publicIPAddresses"},
    "then": {"effect": "Deny"}
  }
}
```
For a production rule that targets only VM NIC public-IP attachment, use a validated built-in definition or a correctly modeled NIC alias condition; do not claim the example above checks VM attachments.

### 3. Production Example
For a regulated workload, I assign an initiative containing approved-region, encryption, mandatory-tag, diagnostic-setting and public-exposure controls at the production management group. I test changes in audit mode, get the security team to approve exemptions for designated ingress resources, then enforce Deny. Exceptions have owners, reasons, and expiry dates.

### 4. Troubleshooting
**Scenario:** Terraform deployment fails with `RequestDisallowedByPolicy`.
1. Find the **failed operation** in Activity Log and read policy assignment/definition IDs in the error.
2. Open Policy → Compliance and identify the failing resource property and effective assignment at the scope.
3. Check initiative parameters, inheritance, exemptions, enforcement mode and alias support.
4. Update IaC to comply; request a scoped exemption only through approved governance if the use case is valid.
5. For Modify/DeployIfNotExists, check assignment identity, required roles, evaluation timing and remediation task status.

**Interview conclusion:** “Definition is the rule; assignment is where we enforce it; initiative is a collection; remediation handles eligible existing noncompliant resources. I test in audit mode before production enforcement.”

---

<a id="azure-q08"></a>
## Question 8: What is the difference between Azure RBAC, Azure Policy, Microsoft Entra roles, and managed identities? How would you implement least privilege?

### 1. Concept
These solve different security problems:

| Mechanism | Primary purpose | Example |
|---|---|---|
| Azure RBAC | Authorize operations on Azure resources | Network Contributor on one resource group |
| Azure Policy | Enforce/audit resource configuration | Deny unapproved regions |
| Microsoft Entra role | Administer directory objects and features | User Administrator |
| Managed identity | Give Azure workload an identity without storing a secret | VM reads Key Vault secret |

Azure resource **management-plane RBAC** is not always the same as **data-plane RBAC**. Contributor can manage a storage resource but does not automatically read its blobs. A managed identity still needs authorization to the target service.

### 2. Implementation — step by step
1. Identify the actor (human, pipeline, or workload), action (read/write), resource, and required duration.
2. Azure Portal → targeted resource → Access control (IAM) → Add role assignment → choose the narrowest built-in role and resource scope.
3. For human elevation, integrate Entra PIM (where licensed) with approvals and limited activation; use dedicated admin accounts when required.
4. For an application on VM/App Service/AKS, enable managed identity or AKS workload identity. Assign **data-plane** roles such as Storage Blob Data Reader or Key Vault Secrets User at the narrowest appropriate scope.
5. Policy → Assignments → apply configuration controls separately. Enable audit logs, access reviews, and periodic role cleanup.

**CLI example:**
```bash
az role assignment create \
  --assignee-object-id '<principal-object-id>' \
  --assignee-principal-type ServicePrincipal \
  --role 'Storage Blob Data Reader' \
  --scope '/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Storage/storageAccounts/<account>'
```

### 3. Production Example
An AKS payment API needs to read a configuration blob and one secret. I use a federated AKS workload identity rather than a client secret, grant Blob Data Reader on the specific storage account and Key Vault Secrets User where appropriate, and restrict private connectivity. Platform administrators have approved short-lived privileges, and Azure Policy prevents accidental public exposure.

### 4. Troubleshooting
**Scenario:** A Contributor can create a storage account but receives HTTP 403 reading blobs.
1. Confirm the identity actually used by the client (`az account show`, workload credential chain).
2. Inspect **data-plane** role assignments; Contributor alone may not include Blob Data Reader.
3. Check role assignment scope and propagation time, conditional-access requirements if applicable, and whether an explicit deny or conditions apply.
4. Check the Storage firewall/private endpoint and DNS to separate network 403 from authorization 403.
5. Look at resource diagnostics and request correlation IDs.

**Interview conclusion:** “RBAC grants permissions, Policy enforces configuration, Entra roles manage directory privileges, and managed identity authenticates workloads without long-lived secrets.”

---

<a id="azure-q09"></a>
## Question 9: How would you integrate an on-premises data center with Azure using VPN or ExpressRoute, and troubleshoot failures?

### 1. Concept
A hybrid network connects on-premises systems to Azure workloads. A **Site-to-Site VPN** encrypts IPsec/IKE traffic through the internet and is often a cost-effective starting point. **ExpressRoute** provides private connectivity through a connectivity provider, with predictable enterprise connectivity characteristics; it is not automatically end-to-end encrypted. Design redundant connections and VPN backup where justified.

**Key considerations:** non-overlapping CIDRs, routing/BGP, redundant gateways, DNS forwarders, NSGs/firewalls, bandwidth, latency, and change ownership.

### 2. Implementation — step by step
1. Inventory on-premises networks, DNS zones, security requirements, address-space overlaps, critical application ports and RTO expectations.
2. Create an Azure hub VNet with an appropriately sized **GatewaySubnet**; plan separate subnets for Azure Firewall and workloads.
3. **For VPN:** Portal → Virtual network gateway → VPN, route-based configuration; create Local Network Gateway with the on-premises public endpoint and address prefixes/BGP parameters; create Site-to-Site connection with a strong shared key or approved authentication.
4. Configure compatible tunnels/routes on the on-premises VPN appliance. Test both active paths if designing active-active.
5. **For ExpressRoute:** provision an ExpressRoute circuit with the provider, configure private peering, and link to an ExpressRoute virtual network gateway. Plan circuit/gateway redundancy.
6. Configure UDRs, Azure Firewall, NSGs, DNS Private Resolver or DNS forwarders, and route advertisements; validate return paths.
7. Enable VPN/ExpressRoute gateway diagnostics, connection monitoring and alerts for tunnel health and route changes.

**Basic checks:**
```bash
az network vpn-connection list -g rg-connectivity -o table
az network vnet-gateway list -g rg-connectivity -o table
nslookup api.private.example.com
```

### 3. Production Example
For an on-premises transaction engine calling a private Azure API, I use dual ExpressRoute circuits (where budget and scale justify it) with redundant gateways and an appropriately planned failover path. Private DNS lets on-prem clients resolve Azure private endpoints. Firewall rules allow only required API and database destinations, while monitoring measures tunnel health, latency and packet loss.

### 4. Troubleshooting
**Scenario:** On-prem servers cannot reach the Azure private API.
1. Check tunnel/circuit and gateway provisioning status, BGP peer sessions, advertised routes and effective routes.
2. Compare local and remote prefixes for overlap or missing advertisements; verify symmetric return routing.
3. Resolve the private hostname from **on-prem**, not only inside Azure; validate DNS forwarding to the relevant private zone.
4. Check Azure Firewall, NSGs, on-prem firewall, MTU/MSS, and actual application port connectivity.
5. Use Network Watcher Connection Troubleshoot, gateway diagnostics, packet capture where authorized, and traceroute cautiously.
6. Provide route tables, timestamps, circuit/tunnel IDs and correlation details when opening Microsoft/provider support cases.

**Interview conclusion:** “I design hybrid connectivity around redundant links, correct BGP routes, private DNS, and layered firewalls; I troubleshoot the network from both directions.”

---

<a id="azure-q10"></a>
## Question 10: A VM cannot reach an Azure database through a private endpoint. How do you troubleshoot NSGs, UDRs, Private DNS, Firewall, and connectivity?

### 1. Concept
A private endpoint places a service's network interface and private IP inside our VNet. For Azure SQL, the client normally uses the original database FQDN, which must resolve to the endpoint's private IP. Four components must work together: **private endpoint approval, DNS, networking/routing, and database authentication**.

A TCP timeout usually points toward DNS/routing/filtering/service reachability; SQL login errors often indicate authentication or authorization. Do not treat every failure as an NSG issue.

### 2. Implementation — step by step
1. Portal → SQL server → Networking → Private endpoint connections → confirm the endpoint is **Approved**.
2. Portal → Private endpoints → endpoint → view NIC private IP and selected `sqlServer` subresource.
3. Confirm `privatelink.database.windows.net` Private DNS zone contains the appropriate record and is linked to the client VNet (or resolved through a forwarding design).
4. Review source VM NSG effective security rules and effective routes; note UDRs may force traffic through a firewall/NVA. For private endpoint-subnet policies, verify the intended network policy settings.
5. Confirm SQL server public-network settings are compatible with your design and validate Entra/SQL authentication and database permissions.

**From the client VM:**
```bash
nslookup myserver.database.windows.net
nc -zv myserver.database.windows.net 1433
# Or PowerShell:
# Test-NetConnection myserver.database.windows.net -Port 1433
```
Use the normal server hostname so TLS certificate hostname verification remains correct.

### 3. Production Example
A backend API in Subscription A accesses Azure SQL in Subscription B. We create a private endpoint in the consuming subnet, link the appropriate Private DNS zone, disable public database access after testing, and grant the workload identity minimum database permissions. We monitor SQL connection errors and private endpoint changes.

### 4. Troubleshooting
1. **Wrong IP from DNS:** Check linked VNet, conditional forwarder, private DNS record, local DNS caches, and whether the client queries the expected resolver.
2. **Correct private IP but TCP timeout:** Check source NSG, subnet policy where relevant, UDR, firewall, asymmetric routing and target regional availability.
3. **TCP works but SQL login fails:** Check correct database, principal, authentication method, role membership, and TLS settings.
4. **Only one subnet affected:** Compare effective routes/security rules and DNS between working and failing clients.
5. **Intermittent failures:** Examine DNS caching, connection pool saturation, client-side retries and database throttling.

**Interview conclusion:** “I troubleshoot in order: endpoint approval → DNS private IP → port 1433 route and filtering → SQL identity/permission → performance and logs.”

---

<a id="azure-section-b"></a>
# Section B — Load Balancing, Routing and Application Security (Questions 11–16)

<a id="azure-q11"></a>
## Question 11: Compare Azure Load Balancer, Application Gateway, Azure Front Door, and Traffic Manager. Which would you select?

### 1. Concept
Azure offers different traffic services because not all traffic is HTTP and not every application spans multiple regions.

| Service | Main role | Scope | Common use |
|---|---|---|---|
| Azure Load Balancer | Layer 4 TCP/UDP distribution | Regional; cross-region option | Internal VM/VMSS TCP services |
| Application Gateway | Primarily Layer 7 regional reverse proxy, WAF and routing (also supports applicable L4 capabilities) | Regional | HTTPS ingress to web APIs |
| Azure Front Door | Global Layer 7 application delivery + WAF/CDN | Global | Multi-region websites, fast failover |
| Traffic Manager | DNS-based endpoint selection | Global | DNS routing for supported endpoint types |

Traffic Manager does **not** proxy request traffic; DNS caching affects failover time. A public-facing multi-region app can use **Front Door + regional Application Gateways**, while internal TCP workloads use Load Balancer.

### 2. Implementation — step by step
1. Identify **protocol** (TCP/UDP/HTTP), exposure (internal/public), scope (one region/global), WAF requirement and traffic routing requirements.
2. For internal TCP services: Portal → Load Balancers → Standard → internal frontend IP → backend pool → probe → load-balancing rule.
3. For regional HTTPS: Portal → Application Gateway → choose V2 SKU → dedicated subnet → listener → backend pool → backend settings → probe → routing rule; attach WAF policy if using WAF tier.
4. For multiple regions: Portal → Front Door → create profile, endpoint, origin group, regional origins, health probes, route and optional WAF rules.
5. For DNS-based routing: Traffic Manager → profile → routing method (Priority, Performance, Weighted, etc.) → endpoints → monitor settings → DNS record.
6. Enable access logs, backend health, metrics and alert rules, and test backend failures.

### 3. Production Example
A banking application has active deployments in Central India and South India. Azure Front Door receives global HTTPS traffic and selects a healthy regional origin. Each region runs Application Gateway with WAF to route to private web/API backends. Internal non-HTTP services use an internal Standard Load Balancer. I validate failover with controlled tests and protect origins against bypass.

### 4. Troubleshooting
**Scenario:** Users report intermittent 502s after traffic changes.
1. Check which layer emits 502: Front Door access logs or Application Gateway access logs.
2. Inspect origin/backend health probes, DNS/TLS hostnames, certificate chain, ports and timeout settings.
3. Query regional app logs and traces to distinguish gateway errors from backend exceptions.
4. If Traffic Manager is used, check endpoint monitoring and external DNS cache behavior; do not expect immediate client switchover.
5. Compare regional capacity, routing weights, WAF logs and deployment timelines.

**Interview conclusion:** “L4 TCP/UDP → Load Balancer; regional smart HTTP routing and WAF → Application Gateway; global web failover/acceleration → Front Door; DNS routing → Traffic Manager.”

---

<a id="azure-q12"></a>
## Question 12: How would you configure Azure Application Gateway with WAF, listeners, backend pools, HTTPS, and health probes?

### 1. Concept
**Application Gateway** is a managed application delivery controller. It can terminate TLS, inspect HTTP requests, apply routing rules and probe backend health. WAF adds protection against common web vulnerabilities. The main objects are **frontend IP, listener, routing rule, backend pool, backend settings, custom probe, and WAF policy**.

### 2. Implementation — step by step
1. Portal → Application Gateways → Create. Choose an appropriate v2/WAF v2 SKU, region, availability zones and a **dedicated subnet**.
2. Select public or private frontend IP based on app exposure; upload or reference a trusted certificate, typically from Key Vault where supported.
3. Configure an HTTPS listener on 443 with hostname (`api.example.com`) and TLS certificate.
4. Add backend pool containing VMSS addresses, VMs, or resolvable backend names.
5. Configure backend settings (HTTP/HTTPS, destination port, host header, timeouts, backend trust settings). Prefer end-to-end HTTPS where required.
6. Add a custom probe, for example `GET /health/ready` with acceptable HTTP status codes; ensure the probe's host and protocol match the backend.
7. Create basic or path-based routing: `/api/*` → API pool, `/web/*` → web pool.
8. Create and attach a WAF policy; begin in **Detection** mode, inspect false positives, then enable **Prevention** with documented exceptions.
9. Configure diagnostic settings to send access/firewall logs to Log Analytics, and alert on unhealthy hosts and 5xx responses.

### 3. Production Example
For a payment API, I use a private backend pool and a public WAF v2 gateway. Only TCP 443 is exposed to customers; API subnets allow traffic from approved gateway paths. Certificates are rotated through managed change processes, and readiness probes check critical dependencies without overloading the backend.

### 4. Troubleshooting
**Scenario:** Gateway returns 502 while VMs are powered on.
1. Open Application Gateway → **Backend health**; review probe error reason.
2. Test the same host header/path/protocol/port from a permitted network location.
3. Check backend certificate validity/trust, TLS versions, DNS resolution and timeout configuration.
4. Verify NSG/UDR/firewall rules permit gateway-to-backend and required platform traffic.
5. Check backend app health and deployment; examine WAF logs only if requests appear blocked, usually associated with 403 responses.

**Interview conclusion:** “I configure listener → rule → backend settings/pool, secure with TLS and WAF, and use meaningful health probes plus logs to detect failed backends.”

---

<a id="azure-q13"></a>
## Question 13: Application Gateway returns HTTP 502 but backend VMs are running. How do you troubleshoot?

### 1. Concept
An HTTP **502 Bad Gateway** means the gateway could not obtain a valid response from a backend. A VM showing `Running` only confirms compute state, **not** application readiness. Common causes include wrong probe path or host, blocked port, backend app crash, incorrect DNS resolution, TLS handshake/certificate issues, and response timeouts.

### 2. Implementation — systematic investigation
1. Portal → Application Gateway → **Backend health**. Identify which backend pool/settings are unhealthy and read the detailed reason.
2. Check listener-to-rule mapping and backend settings. Confirm destination port, protocol, override hostname and request timeout.
3. Test from inside the trusted network with the correct hostname, not just backend IP:
```bash
curl -vk --resolve api.example.com:443:10.2.1.4 \
  https://api.example.com/health/ready
nc -zv 10.2.1.4 443
```
`-k` is for isolated diagnosis only; production clients must validate certificates.
4. Verify the backend certificate SAN/CN, chain and SNI/host configuration when HTTPS is used.
5. Check NSG effective rules, subnet routes, Azure Firewall logs and DNS.
6. Query Application Gateway access logs and correlate timestamp/transaction ID with backend application logs and Application Insights.
7. Correct the failing probe/backend setting or roll back a faulty application deployment; wait for health to recover before reopening traffic.

### 3. Production Example
After deployment, the API starts returning 502. Backend health shows **unhealthy** because the new application returns HTTP 404 for `/health`, whereas the probe expects HTTP 200. I update the probe to the supported readiness path (after verifying that it actually represents readiness), redeploy through approved IaC, and verify backend health and request success rate.

### 4. Troubleshooting — diagnostic decision tree
- **Probe timeout:** Verify app is listening, network port is allowed, connection exhaustion and CPU stalls.
- **DNS resolution error:** Verify hostname, private DNS and custom DNS servers.
- **TLS error:** Verify certificate trust, chain, backend host name, port and protocol.
- **Unhealthy only after deployment:** Compare new app path, redirects, auth, startup timing, and resource saturation.
- **Some requests fail:** Inspect per-instance metrics, sticky sessions, connection pools and autoscaling.

**Interview conclusion:** “I start with Backend health, then validate probe and TLS settings, network connectivity and application logs. VM Running is not enough to prove the service is healthy.”

---

<a id="azure-q14"></a>
## Question 14: How would you implement hub-and-spoke architecture using Azure Firewall, route tables, and Private DNS?

### 1. Concept
Hub-and-spoke centralizes shared services in a **hub VNet**, while isolating workloads in multiple **spoke VNets**. A hub commonly hosts Azure Firewall, VPN/ExpressRoute gateway, private DNS resolution, and management services. Spokes host applications in separate subscriptions. VNet peering links hub↔spokes, but **peering is not transitive**; routing through the hub firewall requires planned forwarding and UDRs.

### 2. Implementation — step by step
1. Plan unique CIDRs: hub `10.0.0.0/16`, spoke-A `10.10.0.0/16`, spoke-B `10.20.0.0/16` (examples).
2. Create hub VNet and mandatory subnets such as `AzureFirewallSubnet`; deploy Azure Firewall with an appropriate policy.
3. Create spoke VNets in app subscriptions. Peer each spoke with the hub, enable required virtual-network access and forwarded-traffic settings. Enable gateway transit/use remote gateways only when supported and required.
4. Create route tables in spoke workloads: for example `0.0.0.0/0` → **Virtual appliance** → hub firewall private IP. Add routes for spoke-to-spoke traffic as needed; account for return routing.
5. Configure Azure Firewall network/application rules and DNAT only for approved exposures. Keep NSGs as an additional layer.
6. Deploy Azure DNS Private Resolver or approved DNS forwarders in the hub. Link private zones to spokes or arrange forwarding appropriately for private endpoints.
7. Validate effective routes, DNS and firewall policy from each spoke. Enable diagnostic logs and high-value alerts.

**Example route inspection:**
```bash
az network nic show-effective-route-table \
  -g rg-app --name nic-api-01 -o table
```

### 3. Production Example
An enterprise maintains independent subscriptions for payments, analytics and identity services. Each gets a dedicated spoke; only authorized east-west traffic is routed through the hub firewall. Hybrid offices connect through the hub gateway, and central DNS resolves private SQL/Storage endpoints. Networking is managed by a separate Terraform state and reviewed by a network team.

### 4. Troubleshooting
**Scenario:** Spoke-A cannot reach an API in Spoke-B.
1. Verify peering state and non-overlapping ranges; remember spokes are **not directly connected** by hub peering alone.
2. Check effective UDRs in both spokes; confirm forward and return traffic reach the firewall.
3. Check firewall rules and logs, forwarded-traffic setting, NSGs and routes.
4. Test hostname resolution through central DNS; compare with direct private-IP test.
5. Inspect packet capture/Connection Troubleshoot and latency, especially when all east-west flows traverse one hub.

**Interview conclusion:** “Hub-and-spoke gives centralized network security and shared services, but correct UDRs, forwarding, return routes, and DNS are critical.”

---

<a id="azure-q15"></a>
## Question 15: Compare NSG, Application Security Group, Azure Firewall, and WAF. How do you use them together?

### 1. Concept
These controls work at different points:

| Control | Function | Best placement |
|---|---|---|
| NSG | Stateful L3/L4 allow/deny using IP, port, protocol | Subnet or NIC |
| Application Security Group (ASG) | Group NICs by application role for NSG rule targets | Used within NSG rules |
| Azure Firewall | Centralized network/application filtering, egress and threat-related capabilities | Hub VNet |
| Web Application Firewall (WAF) | Inspect HTTP(S) web requests, OWASP-style threats | Application Gateway/Front Door |

An **ASG is not a firewall** by itself; it is a way to organize NSG rule endpoints. WAF does not replace host hardening or private network rules.

### 2. Implementation — step by step
1. Create a subnet NSG permitting only traffic paths: gateway→web 443; web→API 8080; API→database 1433 as applicable.
2. Create ASGs such as `asg-web` and `asg-api`; associate supported VM NICs and reference the groups in relevant NSG rules.
3. Deploy Azure Firewall in the hub; create rules for approved outbound FQDNs, network ports and DNS architecture. Add UDRs that actually direct inspected traffic through the firewall.
4. Deploy WAF on the HTTPS ingress; attach managed-rule policy, tune exclusions and begin with observation where appropriate.
5. Enable NSG-related diagnostics/flow telemetry through supported current monitoring approaches, Firewall logs, WAF logs and alerts.
6. Validate test cases: approved path succeeds; blocked path fails; WAF test patterns are handled according to policy.

### 3. Production Example
For customer-facing banking APIs, Front Door WAF protects the global endpoint, Application Gateway provides regional web routing, NSGs isolate API/backend subnets, and Azure Firewall restricts outbound access to approved services. ASGs simplify maintaining NSG rules for pools of VM-based API instances.

### 4. Troubleshooting
**Scenario:** Valid users get HTTP 403 while the API is healthy.
1. Determine the source of 403: WAF, application authentication, storage firewall, or something else.
2. Search WAF logs for rule ID, action, request URI and correlation ID; confirm false positives before adjusting policy.
3. If TCP fails rather than receiving HTTP, examine NSG effective rules, Firewall denies, UDRs and destination port.
4. For intermittent failures, compare backend instances, origin firewall restrictions and automated changes.
5. Use narrowly scoped WAF exclusions; avoid disabling entire rule groups during an incident unless approved.

**Interview conclusion:** “NSG controls subnet/NIC flows, ASG groups workloads, Azure Firewall centralizes network policies, and WAF protects the HTTP application layer.”

---

<a id="azure-q16"></a>
## Question 16: How would you troubleshoot asymmetric routing, DNS failures, and connection timeouts using Network Watcher?

### 1. Concept
A connection requires a valid forward path **and** return path. **Asymmetric routing** occurs when the two paths differ, potentially breaking stateful firewall inspection. DNS problems resolve names to wrong or unreachable IPs. A timeout can mean packet filtering, no route, a closed service, or service overload. Azure Network Watcher exposes effective routes, security rules, connectivity tests and packet capture.

### 2. Implementation — investigation steps
1. Capture source VM/NIC, destination FQDN/IP/port, precise UTC failure time and whether the problem is intermittent.
2. Run DNS and TCP tests from the failing workload:
```bash
nslookup api.private.example.com
nc -zv api.private.example.com 443
curl -v --connect-timeout 5 https://api.private.example.com/health
```
3. Portal → Network Watcher → **Connection troubleshoot** for source VM and destination IP/FQDN/port.
4. Review **effective security rules** and **IP flow verify** for NSG-related denies.
5. Review **effective routes** on source and destination NICs, including UDR, BGP and peering next hops.
6. Inspect Azure Firewall logs/NVA routes and return-path routing. Capture packets when authorized, checking SYN/SYN-ACK traffic.
7. Validate private DNS zone links and custom DNS forwarders; compare expected private IP to actual resolution.

### 3. Production Example
An API in a spoke sends traffic via Azure Firewall to a database, but the return traffic follows a different direct peering route. TCP sessions fail intermittently. I compare both sides' effective routes, fix the UDRs so the firewall sees symmetric flows, and validate connections and latency from several instances before closing the incident.

### 4. Troubleshooting
- **Wrong DNS IP:** Fix private zone link or conditional forwarding and clear relevant caches.
- **Correct IP, no SYN-ACK:** Investigate NSG, firewall, route, destination listener or health.
- **SYN/SYN-ACK but app fails:** Investigate TLS, auth, reverse proxy or application timeouts.
- **Works in one subnet:** Compare NSGs, UDRs, DNS settings and private endpoint access.
- **Only after migration:** Look for overlapping CIDRs, wrong BGP advertisements and stale DNS.

**Interview conclusion:** “I reproduce the failure, separate DNS from TCP and application, then check NSG and effective routes on both sides so I can identify the exact blocked hop.”

---
<a id="azure-section-c"></a>
# Section C — Azure Kubernetes Service (Questions 17–24)

<a id="azure-q17"></a>
## Question 17: How would you deploy and secure a production AKS cluster from scratch with networking, node pools, RBAC, managed identity, scaling, and monitoring?

### 1. Concept
AKS is a managed Kubernetes service: Microsoft operates the managed control plane, while our team still owns application manifests, node pools, access, network policies, security and reliability. A production cluster needs **private-by-design connectivity, separate system/user pools, resilient replicas, least-privilege identities, controlled egress and full observability**. AKS networking choice (for example Azure CNI Overlay versus other supported modes) affects IP planning and communication paths.

### 2. Implementation — step by step
1. **Plan** Azure region/availability zones, supported Kubernetes version, pod/service CIDRs, node subnet, DNS, Azure CNI mode, egress, scaling and capacity headroom.
2. **Provision networking:** hub/spoke VNet, cluster subnet(s), private DNS, firewall/NAT design, NSGs/routes. For regulated workloads, choose a **private AKS API endpoint** and a trusted operator connectivity path.
3. **Create AKS:** Azure Portal → Kubernetes services → Create → cluster type, private networking, system-assigned/user-assigned identity, Entra authorization, and supported Azure CNI configuration.
4. **Node pools:** Create zonal-capable system pool with multiple nodes and one or more user pools sized by actual requests. Set taints/labels where isolation is useful.
5. **Security:** Entra-based RBAC, Kubernetes RBAC, workload identity/OIDC issuer, Key Vault integration, admission/policy controls, network policies and secure ACR pull permissions. Avoid privileged pods and unnecessary public services.
6. **Deploy workloads:** resource requests/limits, 2+ replicas, readiness/liveness/startup probes, PodDisruptionBudgets, topology spread, separate namespaces and quotas.
7. **Scale:** enable node pool autoscaler and workload HPA/KEDA as appropriate; test dependency capacity.
8. **Observe and operate:** Azure Monitor Container Insights, managed Prometheus/Grafana as required, application tracing, alert rules, backup/DR and maintenance windows.

**Read-only inventory commands:**
```bash
az aks show -g rg-prod -n aks-prod --query '{version:kubernetesVersion,private:apiServerAccessProfile.enablePrivateCluster}'
az aks nodepool list -g rg-prod --cluster-name aks-prod -o table
kubectl get nodes -o wide
kubectl get pods -A
```

### 3. Production Example
For a banking microservices platform, I deploy a private AKS cluster with a zonal system pool and separate payments/API user pools. Application ingress comes through approved regional gateways, workloads use federated identities to reach Key Vault, and ACR/SQL/Storage use private connectivity where appropriate. GitOps or Azure DevOps manages application manifests; Terraform manages base cluster infrastructure.

### 4. Troubleshooting
**Scenario:** Newly deployed pods are Pending and APIs are failing.
1. `kubectl describe pod` to check scheduling events, CPU/memory requests, affinities and taints.
2. `kubectl get nodes` / `kubectl describe node` to check capacity, disk pressure and node readiness.
3. Check autoscaler max count, quota, subnet IP capacity and zone-specific SKU shortages.
4. If pods start but fail to serve, check readiness probes, service endpoints, ingress backend health, network policy and DNS.
5. Review Container Insights/Prometheus time series and recent IaC/deployment changes; scale only after confirming the bottleneck.

**Interview conclusion:** “I secure AKS through private networking and workload identity, isolate node pools, define reliable probes and scaling, and monitor the entire path from ingress to pods and dependencies.”

---

<a id="azure-q18"></a>
## Question 18: How would you troubleshoot an AKS pod stuck in CrashLoopBackOff?

### 1. Concept
`CrashLoopBackOff` means a container starts, exits or is killed, and Kubernetes delays its next restart. It is a **symptom**, not a root cause. Common causes are wrong command/entrypoint, application exceptions, missing environment variables or secrets, broken dependencies, failed probes, permission errors and memory exhaustion (`OOMKilled`).

### 2. Implementation — step by step
First identify the affected namespace, deployment and pod:
```bash
kubectl get pods -n payments
kubectl describe pod <pod> -n payments
kubectl logs <pod> -n payments --previous --tail=100
kubectl logs <pod> -n payments --tail=100
kubectl get events -n payments --sort-by=.metadata.creationTimestamp
```
Then:
1. In `describe`, check **Last State → Terminated → Reason/Exit Code** and event messages.
2. Review the **previous** container's logs: it may exit too fast for current logs to be useful. For multi-container pods add `-c <container>`.
3. Inspect deployment image tag, startup command, environment variables, ConfigMaps, Secrets references and volume mounts.
4. Check readiness/liveness/startup probe timing against application startup behavior.
5. Check CPU/memory usage and resource limits; inspect node pressure and dependent services (DNS, database, Key Vault).
6. Compare the newly deployed revision with the last healthy one. Use a controlled rollback if the release caused a customer-impacting outage.

**Additional useful commands:**
```bash
kubectl get deployment payments-api -n payments -o yaml
kubectl rollout history deployment/payments-api -n payments
kubectl top pod -n payments
kubectl rollout status deployment/payments-api -n payments
```

### 3. Production Example
After a release, the payments API restarts every 20 seconds. `kubectl describe pod` shows `OOMKilled`, and `kubectl top pod` shows increased memory during startup. I compare memory profiles and deployment changes, temporarily restore the previous healthy version if SLO is breached, adjust memory requests/limits only after measuring usage, and ask the application team to fix a suspected memory regression.

### 4. Troubleshooting — cause-specific fixes
- **Exit code 1 + stack trace:** Fix application configuration/code or missing dependency.
- **OOMKilled (often exit 137):** Confirm memory limit, heap/cache growth, memory leak and node capacity; optimize app or change measured limits.
- **Liveness probe failure:** Check endpoint, startup duration, TLS/port, initial delay and startup probe.
- **Secret/config missing:** Check secret name, namespace, CSI mounts and identity permissions; never print secret values in logs.
- **Database/DNS failure:** Check CoreDNS, network policy, private DNS, credentials, connection pool and service readiness.

**Interview conclusion:** “I check pod events and last termination reason, then previous logs, probes, config and dependencies; I roll back bad releases before making untested production changes.”

---

<a id="azure-q19"></a>
## Question 19: Explain the production AKS Kubernetes upgrade process with minimum downtime and recovery planning.

### 1. Concept
AKS upgrades affect the **Kubernetes control plane** and **node pools**. Nodes are commonly replaced or drained during supported rolling upgrade workflows. High availability relies on replicas, readiness probes, PodDisruptionBudgets (PDBs), spare capacity, supported version paths and tested deployment compatibility. An AKS upgrade is not the same as a simple application restart, and an in-place **downgrade is generally not the recovery plan**.

### 2. Implementation — step by step
1. Check Microsoft AKS version support, release notes, deprecations, API removals and add-on compatibility (CNI, CSI, ingress, policies and monitoring).
2. Inventory versions and allowed targets:
```bash
az aks show -g rg-prod -n aks-prod --query kubernetesVersion -o tsv
az aks get-upgrades -g rg-prod -n aks-prod -o table
kubectl get pdb -A
kubectl get apiservices
```
3. Test the target version in dev/staging using representative traffic. Scan manifests/Helm charts for deprecated APIs.
4. Confirm multiple healthy replicas, meaningful readiness probes, PDB settings that permit node draining, and adequate node/subnet/IP/VM quota capacity.
5. Configure maintenance windows and an appropriate **node-pool max surge** value. Notify operations and freeze unrelated changes.
6. Upgrade the control plane / cluster through a supported sequence, then upgrade node pools as needed according to supported AKS workflow. Example:
```bash
az aks nodepool update -g rg-prod --cluster-name aks-prod \
  -n userpool --max-surge 1
az aks upgrade -g rg-prod -n aks-prod \
  --kubernetes-version <supported-target-version> --yes
```
7. During upgrade monitor node draining, pod readiness, error rate, p95 latency, PDB-blocked evictions, and autoscaler events.
8. Validate workloads and dependencies after completion; use release/cluster restore procedures if a serious incompatibility is discovered.

### 3. Production Example
For a payments cluster, I upgrade a lower environment first, then production during a controlled window. With three API replicas spread across zones, max-surge node headroom, and a PDB keeping at least two available, the workload can survive routine drains. I monitor transaction errors and have a separate environment recovery/cutover plan rather than promising a Kubernetes downgrade.

### 4. Troubleshooting
**Scenario:** Upgrade stalls because nodes cannot drain.
1. `kubectl get pdb -A` and `kubectl describe pdb`; check whether minAvailable blocks eviction.
2. `kubectl get pods -A -o wide` and `kubectl describe node`; find long termination grace, stuck finalizers, local storage or nonready replicas.
3. Check surge node quota, subnet IP availability, taints/affinity and VM SKU capacity.
4. Review AKS operation status/Activity Log and Kubernetes events; address blockers without forcibly evicting critical replicas unless incident command approves.
5. If application errors rise, halt rollout where supported, revert **application changes** independently, and use backup/parallel-cluster cutover if cluster recovery is needed.

**Interview conclusion:** “I validate compatibility and PDBs, test in staging, add surge capacity, upgrade in supported steps, watch SLOs, and prepare recovery without relying on downgrade.”

---

<a id="azure-q20"></a>
## Question 20: AKS workloads are OOMKilled, CPU is high, and pods restart. How would you find the real problem?

### 1. Concept
`OOMKilled` means a container exceeded an enforced memory limit (or was subject to memory exhaustion context); **CPU throttling** can cause slowness even without high node CPU. Requests affect scheduler placement; limits cap container usage. Raising limits blindly can delay symptoms while exhausting nodes. We must distinguish **memory leak, traffic spike, slow dependency, bad requests/limits and node pressure**.

### 2. Implementation — step by step
1. Inspect pod state and termination reason:
```bash
kubectl describe pod <pod> -n prod
kubectl logs <pod> -n prod --previous --tail=100
kubectl top pod -n prod --containers
kubectl top nodes
```
2. Check Deployment resources: `requests.cpu`, `requests.memory`, `limits.cpu`, `limits.memory`, plus JVM/Node/Python runtime memory settings.
3. Review Container Insights/Prometheus metrics for memory working set, restarts, CPU throttling, request rate, latency and node pressure over the incident timeline.
4. Compare the current image, replica count and traffic against last known good deployment.
5. Inspect dependency latency and DB connection pools; slow downstream calls can accumulate memory and concurrent requests.
6. Mitigate safely: rollback bad release, scale replicas if stateless and downstream can handle it, tune requests/limits from measured data, or adjust node capacity.
7. Add alerts on container restart increases, near-limit memory, OOM events and user-facing SLO breaches.

### 3. Production Example
A busy payments endpoint receives 3× normal traffic. Pods hit 512Mi memory limit and restart; HPA raises replicas but downstream SQL connections also rise. I temporarily restore service with appropriately sized replicas and connection-pool limits, then profile the app, adjust memory requests and introduce load testing before the next release.

### 4. Troubleshooting
- **Memory rises steadily with constant load:** Suspect leak/cache buildup; profile app and inspect heap.
- **Memory spikes exactly at peak traffic:** Revisit concurrency limits, payload size, HPA and memory sizing.
- **Pods Pending after scaling:** Check Cluster Autoscaler max nodes, subnet capacity, quotas and PDB/affinity.
- **Only one node fails:** Check node memory/disk pressure, system pods and noisy neighbors.
- **CPU throttling with moderate usage:** Compare throttling metrics to CPU limits; tune limits only with evidence.

**Interview conclusion:** “I verify OOM reason, correlate container metrics with application traffic and deployments, then fix the bottleneck and requests/limits instead of only increasing replicas.”

---

<a id="azure-q21"></a>
## Question 21: Compare HPA, VPA, Cluster Autoscaler, and KEDA. How would you scale AKS efficiently?

### 1. Concept
These operate at different levels:

| Scaler | Changes | Trigger/example |
|---|---|---|
| HPA | Number of pod replicas | CPU, memory, custom/external metric |
| VPA | Pod CPU/memory recommendations or requests | Measured resource demand |
| Cluster Autoscaler | Number of nodes in a pool | Unschedulable pods / underused nodes |
| KEDA | Event-driven workload replicas | Azure Queue length, Event Hubs lag, external triggers |

HPA alone cannot create node capacity. KEDA generally manages its own HPA for a ScaledObject, so avoid a second conflicting HPA on the same workload. VPA and HPA targeting the same CPU/memory resource can conflict; use VPA recommendation mode for sizing.

### 2. Implementation — step by step
1. Measure steady-state traffic, peak traffic, average requests per pod, startup time and downstream limits.
2. Set realistic requests/limits and **minimum replicas >1** for critical always-on APIs.
3. Enable Cluster Autoscaler on suitable user node pools, for example:
```bash
az aks nodepool update -g rg-prod --cluster-name aks-prod \
  -n userpool --enable-cluster-autoscaler --min-count 3 --max-count 10
kubectl autoscale deployment payments-api -n prod \
  --cpu-percent=65 --min=3 --max=15
```
These figures are illustrative; choose from load testing.
4. Install/enable supported KEDA integration for queue workers and configure scaled objects with Azure authentication via workload identity where appropriate.
5. Use VPA recommendations to review requests, implement HPA stabilization windows and scale-up policies, and configure topology spread/PDB.
6. Validate performance, cost, pod pending time and DB connection capacity during load tests.

### 3. Production Example
A payment API always has at least three pods and scales using HPA on CPU and request rate. A queue consumer scales through KEDA based on Azure Storage Queue backlog, possibly to zero only if delay is acceptable. Cluster Autoscaler adds nodes when pods cannot schedule. We keep a minimum node baseline so a sudden spike does not depend entirely on slow VM startup.

### 4. Troubleshooting
**Scenario:** HPA says 12 desired replicas but only six run.
1. `kubectl get hpa -n prod` → check current metrics/targets and HPA events.
2. `kubectl describe pod` for Pending replicas → insufficient CPU, affinity, taints, or quotas.
3. Check cluster autoscaler events, maximum node counts, IP space and regional SKU capacity.
4. If replicas run but latency remains high, check database/queue throttling and hot partitions; adding pods may worsen contention.
5. Analyze rapid up/down oscillation and tune stabilization and request baselines.

**Interview conclusion:** “HPA/KEDA scale workload replicas; Cluster Autoscaler supplies nodes; VPA helps size pods. I coordinate all three against SLOs, cost, and downstream capacity.”

---

<a id="azure-q22"></a>
## Question 22: How would you troubleshoot an AKS pod stuck in Pending or ImagePullBackOff?

### 1. Concept
**Pending** usually means Kubernetes cannot schedule the pod or is waiting on volumes/other prerequisites. **ImagePullBackOff** means the node cannot pull the container image and Kubernetes backs off retries. They need different investigations: scheduling/capacity versus registry/image/auth/network.

### 2. Implementation — step by step
```bash
kubectl get pods -n prod -o wide
kubectl describe pod <pod> -n prod
kubectl get events -n prod --sort-by=.metadata.creationTimestamp
kubectl get nodes -o wide
kubectl describe node <node>
```
For **Pending**:
1. Read scheduler event: `Insufficient cpu`, `Insufficient memory`, taints, node selector/affinity, topology constraints, PVC unbound, or quotas.
2. Compare `kubectl top nodes`, allocatable versus requested resources, and node-pool autoscaler settings.
3. Check subnet IP capacity, VM quota, Azure zone/SKU availability and PVC/storage class status.

For **ImagePullBackOff**:
1. Read exact event: `unauthorized`, `manifest unknown`, DNS timeout, certificate error, or registry unavailable.
2. Confirm image name/tag/digest and whether image actually exists in ACR.
3. Confirm AKS kubelet identity has correct `AcrPull`/repository permissions for the registry configuration.
4. For private ACR, verify private endpoint DNS, routing and outbound connectivity from nodes.
5. Test a safe deployment after fixing identity, image reference or connectivity.

### 3. Production Example
A new release references `acrprod.azurecr.io/payment:2026.10.13`, but that image tag was never pushed. Pods stay in ImagePullBackOff. The events say `manifest unknown`. I verify the CI artifact, restore a known-good digest/roll back, correct the pipeline promotion logic, and add an image-existence validation step before deployment.

### 4. Troubleshooting
- **Unauthorized:** Identity/role or scope; avoid hardcoding registry passwords.
- **Manifest unknown:** Wrong repository, tag or digest.
- **Timeout:** Private DNS, NSG, Firewall, ACR Private Link or registry outage.
- **Insufficient resources:** Right-size requests, scale nodes, review quotas.
- **Unbound PVC:** Check CSI driver, StorageClass, allowed zones and access mode.

**Interview conclusion:** “I use pod events first: Pending means scheduling/storage; ImagePullBackOff means image path, auth or connectivity.”

---

<a id="azure-q23"></a>
## Question 23: How would you implement secure AKS ingress/egress using Application Gateway, ACR, Key Vault, private endpoints, and workload identity?

### 1. Concept
Ingress is traffic **entering** workloads; egress is traffic **leaving** them. A private AKS design keeps Kubernetes API and internal services away from the public internet, while exposing only approved HTTPS endpoints. Application Gateway/appropriate ingress handles web routing and WAF; Azure Firewall/NAT controls egress; private endpoints connect to ACR/Storage/Key Vault; workload identity removes long-lived application credentials.

### 2. Implementation — step by step
1. Create a private AKS cluster with a supported CNI mode, clearly planned DNS and a controlled operator-access path.
2. Deploy an appropriate Application Gateway/ingress controller or Application Gateway for Containers, selecting the supported integration for the application.
3. Configure HTTPS listeners, backend targets, routing, health probes and WAF where applicable. Ensure traffic reaches private workloads.
4. Assign AKS kubelet identity appropriate ACR pull permissions. If ACR has private network access, create the required ACR private endpoint/DNS and verify all necessary registry endpoints are reachable.
5. Enable OIDC issuer and workload identity; create a federated identity credential linking Kubernetes service account to a user-assigned managed identity.
6. Grant that identity only needed Key Vault or Blob Storage roles. Mount secrets using a supported CSI integration or retrieve them from SDK at runtime.
7. Define egress routes through Azure Firewall or approved NAT; allow Azure/AKS dependencies rather than blocking required control-plane traffic.
8. Enable application and gateway logs; test both ingress and external dependency access.

### 3. Production Example
A private payments AKS cluster receives public traffic only through WAF-protected regional ingress. Its workloads pull signed images from private ACR, read certificates/secrets from Key Vault using workload identity, and call Azure SQL through Private Link. Outbound access to third-party payment services is limited to approved destinations and logged centrally.

### 4. Troubleshooting
**Scenario:** After disabling public network access, pods cannot pull images or read secrets.
1. Check ACR image-pull events and identity assignments separately from workload secret-fetch failures.
2. Validate `nslookup` for ACR/Key Vault hostnames from within the network, confirm private IP resolution.
3. Inspect private endpoint approval, DNS zone links, firewall rules, NSG/UDR and node/pod egress.
4. For workload identity, verify OIDC issuer, federated subject, service account annotations and token audience.
5. Re-test with a least-privileged sample workload; don't solve by enabling public access indiscriminately.

**Interview conclusion:** “I isolate AKS networks, use controlled ingress and egress, use private service access, and authenticate pods with workload identity rather than secrets.”

---

<a id="azure-q24"></a>
## Question 24: How would you migrate an on-premises Kubernetes application to AKS with minimal downtime and rollback?

### 1. Concept
Kubernetes migration is more than moving manifests. We must migrate **container images, secrets, persistent data, DNS, networking, ingress, CI/CD, observability and traffic**. Stateless workloads are easier; stateful databases need replication and a defined cutover. Strategies include rehost/redeploy, gradual canary, blue-green and controlled traffic switching. RTO/RPO and compatibility decide the safest plan.

### 2. Implementation — step by step
1. Assess current cluster: Kubernetes version/API compatibility, Helm charts, ingress controller, CNI/network policies, storage classes, stateful dependencies, SLOs and node requirements.
2. Build private or appropriately secured AKS using Terraform, with namespaces, node pools, workload identities, ACR, Key Vault and monitoring.
3. Push images to ACR, update manifests/Helm values, replace on-prem storage/secret integrations with Azure equivalents.
4. Establish hybrid connectivity so the new AKS deployment can reach old dependencies during transition, using VPN/ExpressRoute and private DNS as necessary.
5. For stateful systems, choose DB migration/replication method and test consistency; do not copy a live PVC casually without an application-consistent backup.
6. Deploy in nonproduction; run functional, security, performance and failover tests.
7. Deploy production AKS side-by-side, run synthetic smoke tests, then shift a small percentage of traffic using a gateway or global frontend with the appropriate routing capabilities.
8. Monitor error rate, p95 latency, duplicate processing and data lag; complete cutover only after acceptance. Keep rollback and old environment available until the fallback window closes.

### 3. Production Example
An internal transaction API runs in an on-premises Kubernetes cluster. We build AKS in parallel, replicate database content with a tested migration mechanism, move only internal test traffic first, then shift 5%, 25% and 100% of eligible API traffic under an approved change. We verify transaction IDs and idempotency, then retire the old cluster after the observation period.

### 4. Troubleshooting
**Scenario:** New AKS pods work, but calls to on-prem database timeout.
1. Test DNS from AKS and compare private IP resolution with the old environment.
2. Inspect hybrid tunnel/BGP routes, egress SNAT and both-side firewall rules.
3. Validate database TLS trust, auth, permitted client IPs and connection pool limits.
4. Check migration-specific API and data-schema incompatibilities, then stop traffic shift or roll back before data diverges.
5. Re-run load tests and record cutover evidence to prevent repeat failures.

**Interview conclusion:** “I build AKS in parallel, validate network and data migration, shift traffic gradually, monitor business KPIs and keep a tested rollback path.”

---
<a id="azure-section-d"></a>
# Section D — Azure Monitor, Centralized Logging and SRE (Questions 25–33)

<a id="azure-q25"></a>
## Question 25: How would you implement centralized logging for Azure VMs, AKS, App Service and Azure SQL across multiple subscriptions?

### 1. Concept
**Centralized logging** means application, platform and audit telemetry from many resources can be searched and correlated consistently. Azure Monitor handles telemetry ingestion, queries and alerts; **Log Analytics Workspace** stores/query logs using KQL. Different sources use different ingestion paths: **Azure Monitor Agent + DCR** for VM guest logs, **Container Insights/managed Prometheus** for AKS telemetry, **Application Insights/OpenTelemetry** for app traces, and **diagnostic settings** for supported PaaS resource logs.

Azure Blob Storage is useful for long-term archive/export, **not** a drop-in replacement for Log Analytics querying. Storage can receive supported diagnostic categories directly; don't say every log is automatically “pulled by Log Analytics and stored in Blob.”

### 2. Implementation — step by step
1. Define a logging architecture: central or segmented Log Analytics workspaces based on data residency, RBAC, isolation, retention, ingestion cost and subscription ownership.
2. Portal → Log Analytics Workspaces → Create in a monitoring subscription; grant reader/contributor access based on least privilege.
3. **VMs:** Install Azure Monitor Agent; create a DCR selecting Windows events, Syslog, performance counters or supported custom text logs; associate VMs, or use Azure Policy for scale.
4. **AKS:** Enable Container Insights and optionally managed Prometheus; instrument app traces with OpenTelemetry/Application Insights.
5. **PaaS:** On App Service, SQL, Firewall, Key Vault, Application Gateway and Storage, configure supported **Diagnostic settings** categories to send resource logs to the central workspace; enable metrics/alerts separately.
6. **Subscriptions:** Export Activity Logs using subscription-level diagnostic settings where needed and scope access with management groups/RBAC.
7. Build KQL-based dashboards/workbooks and Action Group alerts for correlated transaction errors, unauthorized activity and service failures.
8. Define retention/archive and redact sensitive fields before ingestion when possible; test restore/query and access audits.

**Example KQL:**
```kusto
AzureActivity
| where TimeGenerated > ago(24h)
| where ActivityStatusValue == "Failure"
| summarize Failures=count() by ResourceGroup, OperationNameValue
| order by Failures desc
```

### 3. Production Example
Payments APIs run on AKS, integration agents on VMs and SQL as a managed database across three subscriptions. A central monitoring team owns a governed workspace. Each log includes service name, environment and correlation ID. Dashboards combine ingress 5xx, API dependencies, Kubernetes restarts, SQL errors and Azure Activity changes. Security-sensitive records are access-controlled with documented retention.

### 4. Troubleshooting
**Scenario:** A VM appears healthy but no guest logs arrive.
1. Confirm the AMA extension/agent health and correct subscription/workspace configuration.
2. Verify DCR associations, event facility/counter selection, supported OS data collection and network/DNS to ingestion endpoints.
3. Check ingestion time delay and query the **correct table**, workspace and time range; account for different table schemas.
4. Inspect DCR processing errors and agent logs; compare with a working VM.
5. For PaaS, check whether diagnostic settings include the correct categories/destination; AMA is not how most platform resource logs are collected.

**Interview conclusion:** “I centralize telemetry through AMA/DCRs, diagnostic settings and app instrumentation, then use Log Analytics KQL, dashboards, alerts and retention controls.”

---

<a id="azure-q26"></a>
## Question 26: Explain step by step how to configure Azure Monitor, Log Analytics, AMA, DCR, diagnostic settings, alerts and Action Groups.

### 1. Concept
**Azure Monitor** is the monitoring platform. **Log Analytics** is the workspace/query experience for logs. **Azure Monitor Agent (AMA)** collects guest telemetry; a **Data Collection Rule (DCR)** states which data to collect and its destination; a **DCR association** attaches it to supported resources. **Diagnostic settings** route supported Azure resource/platform logs. **Alert rules** evaluate metrics or log queries; **Action Groups** deliver notifications or trigger responses.

### 2. Implementation — step by step
1. Portal → **Log Analytics Workspaces** → Create `law-prod` in the approved region/resource group.
2. Portal → **Monitor → Data Collection Rules → Create**. Choose source type (Windows Event Logs, Syslog, performance counters), data flow, and destination `law-prod`.
3. Add target VMs in the DCR **Resources** tab. Ensure Azure Monitor Agent is installed on them; deploy through Azure Policy for a fleet.
4. Portal → VM → Extensions + applications, verify AMA status. Use association view to confirm the DCR is attached.
5. Portal → Azure SQL/App Gateway/Storage → **Diagnostic settings → Add**. Choose needed supported categories and send to `law-prod` (and Storage/Event Hubs if separately required).
6. Portal → **Monitor → Alerts → Create → Alert rule**. Select resource scope, signal (for example Percentage CPU > 85%), period/window, severity and evaluation frequency.
7. Create **Action Group** with email, SMS, webhook, Logic App or automation (depending on policy); attach to alert. Configure alert processing rules for planned maintenance where necessary.
8. Generate a controlled test event and confirm: data arrives → KQL query returns rows → alert fires → Action Group receives notification → incident ticket/runbook records evidence.

**DCR association example:**
```bash
az monitor data-collection rule association create \
  --name ama-prod-association \
  --rule-id '<DCR-resource-ID>' \
  --resource '<VM-resource-ID>'
```

### 3. Production Example
I set CPU alerts, disk-free thresholds, API 5xx rate alerts and Windows authentication-event collection across 80 application VMs. Application Insights measures requests and failures; SQL diagnostics show database errors; the on-call Action Group pages for critical alerts, while low-severity issues create tickets. Logs use central retention policies and RBAC.

### 4. Troubleshooting
**Scenario:** CPU metrics appear, but VM event logs and alerts do not.
1. Distinguish **platform CPU metrics** from AMA guest-event ingestion; CPU metrics can exist without AMA.
2. Check AMA extension, DCR data-source choice, association, destination and firewall/ingestion reachability.
3. Run KQL against the correct table and look at DCR ingestion errors.
4. Inspect alert rule scope, measure/threshold, query permissions, dimension filters and evaluation time window.
5. Test Action Group delivery and whether alert processing rules suppressed the notification.

**Interview conclusion:** “Create workspace → onboard AMA → create DCR + association → enable diagnostic settings → query data → configure alert rule + Action Group → test end to end.”

---

<a id="azure-q27"></a>
## Question 27: Differentiate Azure Monitor, Log Analytics, Application Insights, Container Insights and managed Prometheus. How do they work together?

### 1. Concept
These are complementary pieces of observability:

| Component | Main telemetry | Typical question |
|---|---|---|
| Azure Monitor | Metrics, logs, alerts and monitoring platform | Is service healthy? |
| Log Analytics | Log data and KQL | What error occurred? |
| Application Insights | Application requests, dependencies, exceptions, traces | Which API/dependency is slow? |
| Container Insights | AKS container/node inventories and logs | Which pod restarted? |
| Azure Monitor managed Prometheus | Prometheus-format metrics | How fast are pod requests/throttling growing? |
| Azure Managed Grafana | Visual dashboards | How do teams view time series? |

Application Insights can be workspace-based, sending application telemetry to a Log Analytics workspace. Managed Prometheus uses an Azure Monitor workspace for Prometheus metrics, **not the same resource type as a Log Analytics Workspace**.

### 2. Implementation — step by step
1. Select SLIs: availability, p95 request latency, error rate and saturation.
2. Enable Application Insights for API workloads; instrument with supported OpenTelemetry libraries/instrumentation and set meaningful operation names/correlation IDs.
3. Enable Container Insights for AKS logs/inventory; onboard managed Prometheus if Prometheus metrics and PromQL are required.
4. Connect Azure Managed Grafana (or supported Grafana deployment) to the Azure Monitor workspace and Log Analytics/Application Insights sources.
5. Create workbooks/dashboard panels and alerts for business SLIs, not only node CPU.
6. Enable controlled sampling/retention and avoid duplicating identical high-volume telemetry streams unnecessarily.

### 3. Production Example
At 11:00, customers report slow payments. Grafana shows p95 latency rises. Application Insights traces show most time in calls to Azure SQL. Container Insights shows all pods running, and managed Prometheus shows low pod CPU throttling. We investigate SQL connection pool and lock waits instead of wasting time resizing AKS nodes.

### 4. Troubleshooting
**Scenario:** Grafana shows CPU graphs, but transaction traces are missing.
1. Validate the app is instrumented and the connection string/endpoint is correct.
2. Check distributed tracing propagation (trace/context headers) through gateways and services.
3. Examine SDK sampling, failed exporters and outbound network restrictions.
4. Confirm data source type and workspace permissions: Prometheus metrics and Log Analytics logs are stored/query differently.
5. Correlate time zones, sampling settings and resource labels across dashboards.

**Interview conclusion:** “Monitor is the umbrella; Log Analytics diagnoses log events; App Insights follows application requests; Container Insights and Prometheus expose AKS health and metrics.”

---

<a id="azure-q28"></a>
## Question 28: How would you monitor CPU, memory, disk, latency, request failures and dependency health for a production application?

### 1. Concept
Effective monitoring needs both **infrastructure health** and **customer experience**. CPU, memory and disks reveal resource pressure. Request rate, **p95/p99 latency**, failed requests and dependency duration show whether users can successfully complete work. Azure platform metrics do not automatically expose every guest-OS metric: memory/disk counters often require AMA, DCR or agent instrumentation.

### 2. Implementation — step by step
1. Document baseline utilization, peak hours, SLIs/SLOs, critical endpoints, dependency map, owner and escalation path.
2. Enable Azure platform metrics for VM/AKS/App Service/SQL and guest performance counters through AMA+DCR where needed.
3. Add Application Insights to APIs; collect requests, dependency calls, exceptions and correlation IDs.
4. In AKS, collect node/pod metrics via managed Prometheus; add readiness metrics, restarts and resource saturation dashboards.
5. Create Azure Monitor Workbooks/Grafana panels: CPU percentiles, memory working set, disk free space/IOPS, transaction error rate, p95 latency, DB connections, queue lag.
6. Configure alerts based on sustained windows, severity and business impact; route to Action Groups and on-call.
7. Load test and run synthetic requests to validate the alert signal before a live incident.

**Sample KQL (workspace-based Application Insights):**
```kusto
AppRequests
| where TimeGenerated > ago(30m)
| summarize Requests=count(), Failures=countif(Success == false),
            P95ms=percentile(DurationMs, 95) by bin(TimeGenerated, 5m)
| order by TimeGenerated asc
```
Schema/column names depend on ingestion mode; confirm the actual table fields in your workspace.

### 3. Production Example
A payments endpoint has an illustrative p95 latency objective of 500 ms and availability objective of 99.95%. I alert on sustained error-rate increase and p95 breach, separately track disk capacity and high memory, and correlate Azure SQL dependency timing before deciding whether to scale web pods or investigate the database.

### 4. Troubleshooting
**Scenario:** Users see slowness, yet CPU alerts remain green.
1. Check application request rate/p95, dependency waterfall and downstream throttling.
2. Verify guest memory/disk telemetry is actually collected; don't assume CPU is the only bottleneck.
3. Check connection pools, network latency, thread exhaustion, queue backlog and SQL lock waits.
4. Check probe and synthetic monitoring, plus whether sampling or missing instrumentation hides failures.
5. Update alert design after RCA to catch the same user-impacting symptom next time.

**Interview conclusion:** “I alert primarily on user-facing availability and latency, backed by saturation and dependency metrics that explain why an application failed.”

---

<a id="azure-q29"></a>
## Question 29: How would you configure Azure Monitor alerts for CPU, HTTP 500 errors, latency, deployment failures and infrastructure availability?

### 1. Concept
Different failures require different alert signals:

| Problem | Suitable signal | Typical action |
|---|---|---|
| High CPU | Metric alert | Capacity investigation |
| HTTP 500 spike | Application Insights/Log query or suitable metric | Page API team |
| High p95 latency | Request-duration metric/log query | Performance incident |
| Failed Azure deployment | Activity Log alert | Notify platform owner |
| VM/endpoint unavailable | Resource health, synthetic availability, heartbeat where appropriate | Incident/on-call |

An Action Group defines **who or what gets notified**; an alert processing rule can suppress or route alerts during approved maintenance. Alert thresholds should consider baseline and sustained duration to avoid noisy incidents.

### 2. Implementation — step by step
1. Portal → Monitor → Alerts → Create → Alert rule.
2. Select **scope**: VM for CPU, Application Insights/workspace for API errors, subscription Activity Log for resource deployments.
3. Set condition and relevant dimensions; for example **CPU >85% for 10 minutes**, only as an illustrative starting point.
4. Select Action Group (on-call email/webhook/ITSM), severity, evaluation frequency and rule description/runbook URL.
5. For HTTP failures, prefer a **rate or ratio** and minimum request volume rather than a fixed count.
6. Configure planned-maintenance processing rules and separate warning/critical policies.
7. Cause a safe test failure, confirm query returns expected samples, alert triggers, and incident notification reaches the right person.

**Example KQL:**
```kusto
AppRequests
| where TimeGenerated > ago(15m)
| summarize Total=count(), Errors=countif(ResultCode startswith "5")
| extend ErrorPct=100.0*Errors/iff(Total==0,1,Total)
| where Total >= 20 and ErrorPct > 5
```
Validate exact field names and the lookback versus alert evaluation interval.

### 3. Production Example
For a card-payment API, one alert pages for error budget burn (sustained 5xx ratio); another pages for endpoint outage detected by synthetic probes. CPU and disk alerts are lower-severity unless directly affecting transactions. Failed production ARM/Terraform deployments create change-incident evidence and notify the platform team.

### 4. Troubleshooting
**Scenario:** Dashboard shows 5xx errors, but alert never fires.
1. Confirm rule scope, resource, query, time window and aggregation dimension.
2. Check whether minimum volume/threshold logic filters results, and whether query has data for the evaluation period.
3. Inspect alert rule enabled state and evaluation history.
4. Check Action Group test output, permissions and alert processing/suppression rules.
5. Validate telemetry ingestion delay and clock/timezone alignment; adjust evaluation windows if needed.

**Interview conclusion:** “Choose the signal that reflects the failure, tune thresholds against baseline, attach an Action Group, test it, and keep runbooks with alerts.”

---

<a id="azure-q30"></a>
## Question 30: A production application is slow but CPU and memory are normal. How would you investigate logs, traces, network and database dependencies?

### 1. Concept
Normal CPU/memory **does not prove application health**. Slow responses may come from Azure SQL lock waits, overloaded connection pools, dependency timeouts, DNS issues, TLS handshakes, storage throttling, queue delays, thread exhaustion or upstream network latency. The fastest method is to follow a failing **request end-to-end using its correlation/trace ID**.

### 2. Implementation — step by step
1. Confirm impact: which endpoints, regions, time window, customer groups, current error rate and p95 latency.
2. Open Application Insights → Failures/Performance/Transaction search; compare healthy and slow operation samples.
3. Follow distributed traces: frontend → gateway → backend API → database/queue/service; find the slowest **span/dependency**.
4. Compare changes over the same timeline: Azure DevOps release, SQL scaling, firewall policy update, DNS changes or traffic spike.
5. Inspect SQL metrics (CPU, DTU/vCore, workers, connections, deadlocks, blocking), storage throttling and gateway backend timing.
6. Test targeted network connectivity and DNS; use Network Watcher when RTT/packet loss or wrong routing is suspected.
7. Mitigate according to cause: rollback release, reduce request concurrency, fix DB query/index, scale measured bottleneck or repair network route.

**Useful KQL pattern:**
```kusto
AppDependencies
| where TimeGenerated > ago(1h)
| summarize Calls=count(), FailureRate=countif(Success==false)*100.0/count(),
            P95ms=percentile(DurationMs,95) by Target, Type
| order by P95ms desc
```

### 3. Production Example
A transaction API shows 1.8-second p95 against its 400-ms baseline, with pods only 35% CPU. Application Insights traces show Azure SQL queries taking 1.4 seconds. Database diagnostics reveal lock contention after a schema deployment. We roll back the risky DB change or apply an approved query fix, verify latency recovery, and document a load/regression test.

### 4. Troubleshooting
- **Dependency slow:** Check connection pool, service limits, deadlocks and retries.
- **DNS slow:** Compare lookup latency and resolver configuration.
- **Gateway slow:** Compare gateway access logs, probe and backend response time.
- **Only some users:** Compare region/origin selection, WAF processing and client network.
- **No traces:** Verify instrumentation, sampling, propagation and exporter egress.

**Interview conclusion:** “I prioritize the transaction trace and dependency timings rather than assuming we need bigger VMs because the application is slow.”

---

<a id="azure-q31"></a>
## Question 31: How would you use KQL to investigate failed application requests, high-latency APIs, Azure resource errors and suspicious changes?

### 1. Concept
**Kusto Query Language (KQL)** is used in Log Analytics and Application Insights to filter, aggregate, correlate and visualize log records. Common operators: `where` (filter), `project` (select), `summarize` (aggregate), `bin` (time grouping), `extend` (calculated fields), and `join` (correlate datasets). Table names vary by telemetry source and ingestion mode, so verify the workspace schema.

### 2. Implementation — step by step
1. Portal → Log Analytics Workspace → Logs. Select a short time range and run a simple count query to confirm ingestion.
2. Start with one table (`AppRequests`, `AzureActivity`, `Heartbeat`, supported resource-specific table).
3. Narrow using timestamps/resource IDs, then group by endpoint, status, region or operation ID.
4. Use a join or correlation IDs when you need app requests plus dependencies; limit columns/rows for cost and query speed.

**Failed requests:**
```kusto
AppRequests
| where TimeGenerated > ago(1h)
| where Success == false
| summarize Failures=count() by Name, ResultCode
| order by Failures desc
```
**Slow APIs:**
```kusto
AppRequests
| where TimeGenerated > ago(1h)
| summarize P95ms=percentile(DurationMs,95), Calls=count() by Name
| order by P95ms desc
```
**Azure control-plane failures:**
```kusto
AzureActivity
| where TimeGenerated > ago(24h)
| where ActivityStatusValue == "Failure"
| project TimeGenerated, Caller, OperationNameValue, ResourceId, ActivityStatusValue
| order by TimeGenerated desc
```
If `AppRequests` isn't populated in your environment, check the Application Insights `requests` table/column mapping and adapt the query.

### 3. Production Example
During a deployment incident, I use a failed-request query to find `/transactions/submit` has most failures, a p95 query to identify the latency regression, and an Activity Log query to confirm an NSG rule was changed by a service principal at the same time. I capture result snippets and correlation IDs for RCA.

### 4. Troubleshooting
**Scenario:** KQL returns zero rows though dashboards show failures.
1. Check correct workspace, table and selected time range.
2. Confirm ingestion path (application telemetry versus platform diagnostics) and ingestion delay.
3. Inspect actual field names and type (`ResultCode` may be string, duration schema may differ).
4. Remove restrictive filters gradually and add `take 10` to see data shape.
5. Check RBAC/workspace access and whether sampling drops individual request traces.

**Interview conclusion:** “I first locate the right table and time range, then use where/summarize/bin to find patterns and correlate with Azure Activity and dependency traces.”

---

<a id="azure-q32"></a>
## Question 32: Production logs suddenly stop appearing in Log Analytics. How would you troubleshoot AMA, DCR, diagnostics, permissions and connectivity?

### 1. Concept
Log ingestion is a pipeline: **source → collection/diagnostic configuration → transport → Azure Monitor ingestion → workspace table/query**. A break at any stage causes missing data. Diagnose whether the issue affects one VM, one resource category, all subscriptions, or only one query. Importantly, **AMA+DCR** and **PaaS diagnostic settings** are different routes.

### 2. Implementation — step by step
1. Determine the exact missing table/source and last successful ingestion time. Check workspace region, subscription, ingestion volume and time range.
2. For a VM: verify AMA extension state, agent process/health logs, local source events, DCR association and whether DCR selects the expected event facility/counter.
3. For PaaS: resource → Diagnostic settings → check categories and correct Log Analytics destination; confirm resource supports that category.
4. Check permissions and network path to monitoring ingestion endpoints, proxies, DNS and firewall egress.
5. Review DCR errors/metrics and the workspace's ingestion/retention settings.
6. Compare with a working VM/resource; create a controlled test event and trace it through the configured path.

**Useful KQL:**
```kusto
Heartbeat
| where TimeGenerated > ago(24h)
| summarize LastSeen=max(TimeGenerated) by Computer
| order by LastSeen asc
```
Heartbeat is useful only for sources that actually send it; don't assume all Azure services emit this table.

### 3. Production Example
After a network change, 40 Linux VMs stop sending Syslog but Azure platform CPU metrics still work. I find the egress firewall policy removed the required monitoring endpoint access. We restore an approved outbound rule, verify AMA/DCR associations, validate Syslog ingestion and add change checks so central monitoring connectivity is tested before firewall updates.

### 4. Troubleshooting
- **One VM:** AMA health, DCR association and local events.
- **All VMs in subnet:** DNS/proxy/Firewall/route to ingestion.
- **Only SQL logs:** Diagnostic categories or workspace destination.
- **Data in another workspace:** Incorrect DCR/diagnostic destination.
- **Query returns zero:** Wrong table/field, time range, ingestion delay or access.

**Interview conclusion:** “I isolate the failing stage of the collection pipeline and distinguish agent-based guest logs from resource diagnostic logs.”

---

<a id="azure-q33"></a>
## Question 33: How would you define SLI, SLO, SLA and error budgets for a financial application, and automate incident alerting?

### 1. Concept
- **SLI (service-level indicator):** A measurable signal, such as successful payment requests divided by eligible payment requests.
- **SLO (service-level objective):** Target for the indicator, e.g. **99.95% monthly availability**.
- **SLA:** Customer-facing contractual commitment with defined terms and potential consequences.
- **Error budget:** Allowed unreliability within an SLO period; 99.95% means **0.05% of eligible requests** may fail under the chosen definition, not necessarily 21.6 minutes of clock time unless the SLI is time-based.

SLOs should represent user-facing success, latency and correctness, not only Azure VM uptime. Exclude or include planned maintenance according to the written SLI definition—not by quietly editing data after incidents.

### 2. Implementation — step by step
1. Meet business owners and agree which transaction outcome counts as success (e.g. server-accepted, durable confirmation, correct response), and which errors are excluded.
2. Instrument the API using Application Insights/OpenTelemetry and trace/correlation IDs; collect total requests, successful requests, latency percentiles and dependency errors.
3. Define measurement window (e.g. rolling 30 days), SLO value and error-budget policy.
4. Example: 1,000,000 eligible monthly requests with 99.95% success target permit **500 failed requests** in that window under a request-based SLI.
5. Build dashboards and **burn-rate alerts** based on errors over short and long windows, with safeguards for low traffic; use Action Groups/on-call integration.
6. Agree runbooks, incident severity and release controls if a significant percentage of budget is consumed.
7. Review error budget and incident causes regularly with developers, network, DB and platform teams.

### 3. Production Example
A card authorization API has a 99.95% request-success SLO and p95 latency SLO under 500 ms. An error-rate spike during peak traffic triggers an immediate page, while slow budget burn prompts investigation during working hours. Deployments are paused or require elevated review when reliability falls below agreed policy thresholds.

### 4. Troubleshooting
**Scenario:** Alert reports an SLO breach but customers report no failures.
1. Validate numerator/denominator and whether health probes or client-caused 4xx errors were counted incorrectly.
2. Check sampling and telemetry loss, duplicate traces, cross-region aggregation and time window.
3. Compare with synthetic tests and transaction ledger/business outcome measures.
4. Fix the SLI definition or instrumentation through a reviewed process; don't simply raise the threshold to silence a real problem.

**Interview conclusion:** “SLI is measurement, SLO is target, SLA is commitment, and error budget tells us how much unreliability we can tolerate before changing release decisions.”

---
<a id="azure-section-e"></a>
# Section E — Storage, Event Hubs, Event Grid, Queues and PaaS (Questions 34–41)

<a id="azure-q34"></a>
## Question 34: How would you securely connect an application in an Azure VNet to Azure Storage using Private Endpoint, service endpoint, DNS, managed identity and RBAC?

### 1. Concept
A VNet-hosted application can reach Azure Storage using **Service Endpoints** (subnet-based access to the Storage public endpoint) or **Private Endpoints** (a private IP in the consumer VNet). Private Endpoint plus restricted public access is a common choice for confidential financial data. Network access is only one layer: the application should also use **Microsoft Entra managed identity + least-privilege Storage data role**.

Private Endpoints are configured per storage **subresource** such as `blob`, `file`, `queue` or `table` as necessary; a Blob private endpoint doesn't automatically make every Storage service privately accessible.

### 2. Implementation — step by step
1. Create a Storage Account with secure transfer/TLS settings, approved redundancy, encryption and access policies.
2. Portal → Storage Account → Networking → Private endpoint connections → Create → choose **blob** subresource, VNet and endpoint subnet.
3. Set up private DNS zone `privatelink.blob.core.windows.net` and link the application VNet; use corporate DNS forwarding if custom resolvers are in use.
4. Test `mystorage.blob.core.windows.net` resolution from the application VM. It should reach the private endpoint IP through the normal hostname.
5. Once private access is confirmed, disable public network access according to the service/client requirements.
6. Enable VM/App Service/AKS managed identity, grant a scoped `Storage Blob Data Reader` or `Storage Blob Data Contributor` role, then access Blob Storage with Azure SDK token authentication.
7. Set diagnostic settings/alerts for Storage operations and authentication failures. Validate that operational tooling and backup clients also retain access.

**Connectivity checks:**
```bash
nslookup mystorage.blob.core.windows.net
nc -zv mystorage.blob.core.windows.net 443
az role assignment list --assignee '<object-id>' --all -o table
```

### 3. Production Example
An invoice-processing API in an AKS private cluster stores customer documents in Blob Storage. A Blob private endpoint provides network connectivity; AKS workload identity authenticates the pod; Blob Data Contributor is scoped to the intended container/account according to the app's needs. Public access is disabled, operations are logged and retention/immutability follows compliance policy.

### 4. Troubleshooting
**Scenario:** API gets HTTP 403 while DNS resolves correctly.
1. Confirm whether 403 comes from Storage firewall or authentication using Storage diagnostics/request ID.
2. Validate identity, token audience, data-plane RBAC, role scope and propagation; Azure Contributor alone isn't sufficient for blob data access.
3. Check public/private endpoint policy, DNS zone link and whether Blob versus File/Queue endpoint is used.
4. For timeout, inspect NSGs/UDRs/Azure Firewall/proxy rather than solely RBAC.
5. Test with a controlled authorized SDK request, not only an unauthenticated `curl -I` response.

**Interview conclusion:** “Private Endpoint handles private network access; Private DNS maps the normal Storage hostname; managed identity and Storage data RBAC handle authorization.”

---

<a id="azure-q35"></a>
## Question 35: Compare Event Hubs, Event Grid, Event Subscriptions, Azure Storage Queues and Service Bus. When would you use each?

### 1. Concept
These Azure services serve different messaging patterns:

| Service | Main purpose | Example |
|---|---|---|
| Event Hubs | High-throughput append-only event streaming | Millions of telemetry/trade event records |
| Event Grid | Route discrete notifications about changes | Blob created notification |
| Event Subscription | Routing rule/handler configuration for Event Grid | Send BlobCreated events to Azure Function |
| Storage Queue | Simple durable asynchronous work queue | Background file processing jobs |
| Service Bus | Enterprise broker with richer features | Ordered/transactional business workflows |

Event Hubs uses **partitions, retention and consumer groups**; consumers track checkpoints. Event Grid generally uses **push/pull event routing with retry/dead-letter options** depending on the configuration. Storage Queues use **at-least-once delivery**, so consumers must be idempotent. Service Bus supports sessions, dead-letter queues and advanced broker behavior.

### 2. Implementation — step by step
1. Determine whether the requirement is **stream ingestion**, **notification routing**, or **durable task processing**.
2. **Event Hubs:** Portal → Event Hubs → namespace → event hub → choose partition count/capacity model and configure consumers/checkpoints.
3. **Event Grid:** Storage Account → Events → create subscription → event type `BlobCreated` → filter → Azure Function/endpoint destination → configure retries/dead-letter where supported.
4. **Storage Queue:** Storage Account → Queues → create queue → producer sends small work messages → worker processes and deletes only after successful completion.
5. **Service Bus:** Namespace → Queue/Topic → choose sessions, duplicate-detection/TTL/DLQ configuration when required.
6. Use managed identity/RBAC and private endpoints where supported for all services; monitor message lag, delivery failures and backlog.

### 3. Production Example
A trading platform sends high-volume market telemetry into Event Hubs for analytics, emits a `BlobCreated` notification via Event Grid when a reconciliation file lands, and uses Service Bus for reliable payment commands needing stronger workflow controls. A smaller housekeeping job might use Storage Queue. Each service has different SLOs and delivery guarantees.

### 4. Troubleshooting
**Scenario:** Events are published but not processed.
1. Verify the correct service first: Event Hubs consumer group/partition offsets versus Event Grid subscription delivery versus queue visibility.
2. For Event Hubs, check producer auth, namespace throughput/throttling, consumer checkpoint storage, lag and processor crashes.
3. For Event Grid, inspect subscription filters, destination handshake/permissions, retry and dead-letter outcomes.
4. For queues, check visibility timeout, poison-message behavior, worker exceptions and duplicate processing.
5. Confirm private DNS, firewall and identity roles; avoid blindly replaying financial commands without idempotency checks.

**Interview conclusion:** “Event Hubs streams high-volume data, Event Grid routes change events, Event Subscription connects an event source to a destination, and Queues/Service Bus handle durable work.”

---

<a id="azure-q36"></a>
## Question 36: How would you configure Event Hubs for high-throughput ingestion? Explain partitions, consumer groups, checkpoints, security and monitoring.

### 1. Concept
**Event Hubs** is an append-only event ingestion service. **Partitions** provide parallelism and ordered event streams *within each partition*, not a global order across all partitions. **Consumer groups** provide independent views of the stream for different applications. **Checkpoints** record where a processor should resume (commonly in Blob Storage with Azure SDK clients). Capacity is controlled by the tier and throughput/processing units or auto-inflate where supported.

### 2. Implementation — step by step
1. Estimate events/sec, average event size, retention requirements and the number of independent consumers.
2. Portal → Event Hubs → Create namespace with a suitable tier, region, capacity and network configuration.
3. Create an event hub with a partition count sized for future throughput/concurrency needs; choose partition keys for ordering of related events.
4. Create consumer groups for analytics, fraud detection and operational processing; avoid reusing a consumer group for unrelated independently checkpointing apps.
5. Enable private networking/approved firewall rules and assign `Azure Event Hubs Data Sender` / `Data Receiver` to managed identities or workload identities.
6. Configure producer batching and asynchronous send with bounded retry/backoff. Configure consumers with checkpoint storage and safe handling of duplicate delivery.
7. Monitor incoming/outgoing messages, throttled requests, server errors, consumer lag and checkpoint failures; scale based on metrics.

**Example CLI for inspecting hubs:**
```bash
az eventhubs eventhub list \
  --resource-group rg-stream --namespace-name ehns-prod -o table
```

### 3. Production Example
Market-event publishers send several event types to an Event Hubs namespace. Partition keys keep events for one account together when ordered processing matters. Fraud detection and analytics use separate consumer groups and each checkpoints independently. Throughput and consumer lag alerts warn before backlog violates processing SLOs.

### 4. Troubleshooting
**Scenario:** Producers succeed but fraud-processing lag keeps growing.
1. Check incoming versus outgoing throughput and any throttling/capacity-unit ceiling.
2. Verify consumer processor instances, partition ownership and whether parallelism is limited by partition count.
3. Check checkpoint Blob Storage identity, permissions, connectivity and stale offsets.
4. Examine processing time, exceptions, poison payloads and downstream database calls.
5. Scale consumers/processing or capacity only after identifying the actual bottleneck; ensure event ordering expectations are preserved.

**Interview conclusion:** “I size Event Hubs using partitions and capacity, give independent apps separate consumer groups, checkpoint reliably and monitor lag plus throttling.”

---

<a id="azure-q37"></a>
## Question 37: How would you trigger an Azure Function through Event Grid when a blob is uploaded? Explain filters, retries, delivery failure and dead-lettering.

### 1. Concept
Azure Event Grid can publish **BlobCreated** notifications when an object is written. An **event subscription** connects the Storage Account event source to a destination, such as an Azure Function with an Event Grid trigger. Event Grid delivery is generally **at least once**, so duplicate events are possible; consumers must process them idempotently.

### 2. Implementation — step by step
1. Create an Azure Storage Account and a container for uploaded reconciliation files.
2. Create an Azure Function App with an Event Grid-triggered function using a supported runtime and hosting plan. Add a managed identity for reading the blob contents if required.
3. Portal → Storage Account → Events → **+ Event Subscription**.
4. Select event type `Microsoft.Storage.BlobCreated`, choose the Functions endpoint and select the function.
5. Configure event subject filters such as path prefix `/blobServices/default/containers/reports/blobs/` and suffix `.csv` to prevent unrelated triggers.
6. Set retry/dead-letter options supported for the selected subscription/handler scenario, with authorized dead-letter storage if needed.
7. Grant the function managed identity Blob Data Reader and configure network connectivity; function callback and trigger networking must match the hosting plan limitations.
8. Upload a test file, inspect Function execution logs/Application Insights and Event Grid delivery metrics. Validate replay/idempotency.

### 3. Production Example
A financial reconciliation CSV arrives in Blob Storage. Event Grid triggers an Azure Function, which validates the schema, calculates a checksum, starts a controlled reconciliation job and records a unique file ID. Duplicate BlobCreated deliveries are detected from the processed-event table so the payment file is not processed twice.

### 4. Troubleshooting
**Scenario:** File arrives but Azure Function never executes.
1. Verify event subscription provisioning and whether the **subject filter** actually matches the blob name/path.
2. Check Event Grid delivery metrics and destination error codes; verify endpoint/function trigger configuration.
3. Inspect Function App health, scaling, network/firewall configuration and managed-identity permissions.
4. Check retries/dead-letter destination and whether the handler consistently returns retryable errors.
5. Reprocess failed events only through an idempotent path with an audit trail.

**Interview conclusion:** “BlobCreated is the event; Event Grid subscription routes it; Function processes it. Filters reduce noise and idempotency prevents duplicate financial processing.”

---

<a id="azure-q38"></a>
## Question 38: How would you implement Azure Storage Queue asynchronous processing, retries, visibility timeout, duplicate handling and worker scaling?

### 1. Concept
An **Azure Storage Queue** holds small messages representing units of work. A worker reads a message, which becomes temporarily invisible for a **visibility timeout**. On successful processing the worker deletes it. If processing fails or the worker crashes, the message becomes visible again and may be retried. Storage Queues offer **at-least-once delivery**; there is no built-in exactly-once processing or automatic dead-letter queue equivalent to Service Bus DLQ.

### 2. Implementation — step by step
1. Create a Storage Account and queue, e.g. `invoice-jobs`.
2. Give producer/consumer managed identities appropriate `Storage Queue Data Message Sender/Processor`-type permissions (use the exact least-privilege built-in roles for the operation).
3. Producer sends a message with **job ID + blob reference**, not confidential payload or huge file data.
4. Worker receives a message with an appropriate visibility timeout, fetches the referenced content and performs its task.
5. Persist an idempotency key or processing status so retries cannot duplicate business operations; delete the message only after successful durable completion.
6. On transient failure, allow retry with backoff/visibility extension; after a configured attempt threshold, explicitly move the message to an **application-managed poison queue** and alert.
7. Scale worker replicas against queue length and oldest-message age via KEDA/Azure Functions where appropriate.

**Python SDK pseudocode:**
```python
for msg in queue_client.receive_messages(visibility_timeout=60):
    if not already_processed(msg.id):
        process_job(msg.content)   # durable, idempotent implementation
    queue_client.delete_message(msg)
```
Real code must handle exceptions, dequeue count, processing leases and deletion tokens correctly.

### 3. Production Example
A document ingestion API uploads PDFs to Blob Storage and enqueues a job ID. Five worker pods process files independently. KEDA scales pods from queue depth. If a worker crashes, its message reappears; a status table prevents duplicate invoice posting. Poison messages go to a dedicated troubleshooting queue.

### 4. Troubleshooting
**Scenario:** Queue count grows but workers seem healthy.
1. Check queue depth, oldest-message age, dequeue counts and worker processing rate.
2. Review worker errors, identity/RBAC, Storage network connectivity and CPU/memory saturation.
3. Determine whether visibility timeout is shorter than actual processing, causing repeats.
4. Check whether workers acknowledge/delete after successful processing; inspect poison queue and external dependency bottlenecks.
5. Tune KEDA scaling and concurrency while protecting downstream service limits.

**Interview conclusion:** “I design queues for at-least-once delivery, idempotent workers, visibility timeout tuning, poison-message handling and backlog-based scaling.”

---

<a id="azure-q39"></a>
## Question 39: An application cannot publish messages to Azure Event Hubs. How would you troubleshoot IAM, firewall, Private Endpoint, namespace and application logs?

### 1. Concept
Sending to Event Hubs requires **network reachability, valid authentication/authorization, correct namespace/event-hub path, and available capacity**. Failures can look similar at the application layer, so I identify the exact error category before changing infrastructure. A managed identity typically requires the **Azure Event Hubs Data Sender** role at an appropriate scope.

### 2. Implementation — step by step
1. Capture the exact SDK exception, status/error code, UTC time, namespace FQDN, event hub name and correlation identifiers; do not log tokens.
2. Verify endpoint/name and connection settings (for example `*.servicebus.windows.net` for Event Hubs AMQP endpoints).
3. Check workload managed identity (VM/App Service/AKS workload identity), token acquisition and Data Sender role assignment.
4. Validate namespace network rules, private endpoint approval and DNS if private connectivity is required.
5. Test permitted outbound TCP/AMQP port 5671 or supported HTTPS/WebSockets transport on 443, depending on SDK/transport configuration.
6. Check Event Hubs namespace metrics for throttled requests, quota/capacity exhaustion, server failures and availability incidents.
7. Verify message size, encoding, partition-key rules and client retry/backoff behavior.

**Connectivity check:**
```bash
nslookup ehns-prod.servicebus.windows.net
nc -zv ehns-prod.servicebus.windows.net 5671
nc -zv ehns-prod.servicebus.windows.net 443
```
These only test DNS/TCP; SDK authentication and publish must be tested separately.

### 3. Production Example
After tightening Azure Firewall egress, a Python publisher stops sending transaction telemetry. SDK logs show AMQP connection timeouts. I confirm name resolution points to the configured private endpoint, inspect the firewall denies, allow the approved transport endpoint/path, then validate message send and consumer lag without using permanent broad outbound access.

### 4. Troubleshooting
- **401/Unauthorized:** Wrong identity, token audience, expired credentials or missing Data Sender role.
- **Timeout:** DNS, Private Link, Firewall, port restrictions, proxy, TLS inspection.
- **Throttling/quota:** Review capacity units, namespace limits and retry policy.
- **Wrong entity:** Verify namespace/event hub spelling and partition mapping.
- **Only after deployment:** Compare SDK version, identity environment variables, transport type and egress policy.

**Interview conclusion:** “I isolate authentication, network, entity configuration and capacity, and use application exception details plus namespace metrics for a precise fix.”

---

<a id="azure-q40"></a>
## Question 40: How would you deploy and secure Azure App Service with VNet integration, Private Endpoint, Key Vault, deployment slots and autoscaling?

### 1. Concept
**Azure App Service** hosts web applications without managing the underlying VM OS. **VNet Integration** primarily gives the app **outbound access** to resources in a VNet. An **App Service Private Endpoint** provides private **inbound** access to the app. These solve different network directions and usually use separate appropriate subnets. Deployment slots allow testing a staged release and swapping it into production; autoscale adjusts instance count within supported plans.

### 2. Implementation — step by step
1. Portal → App Services → Create with a suitable App Service Plan, supported runtime, region, zone redundancy as required, and managed identity.
2. Configure HTTPS-only, minimum TLS, access restrictions and secure application settings. Store secrets in Key Vault and use supported Key Vault references/managed identity.
3. For **outbound** private connectivity: App Service → Networking → VNet Integration → Add VNet → select a correctly **delegated** integration subnet in the same region.
4. For **inbound** private access: App Service → Networking → Private endpoint connections → create endpoint on a suitable subnet; configure private DNS `privatelink.azurewebsites.net` and approved callers.
5. If public access is not required, disable the appropriate public endpoint after testing any required SCM/Kudu and deployment paths.
6. Create **staging** deployment slot, mark environment-specific settings as slot settings, deploy and run smoke tests.
7. Set autoscale based on CPU, HTTP queue length or supported metrics, along with minimum instances and alerting.
8. Enable Application Insights, App Service diagnostics, slot swap monitoring and rollback plan.

### 3. Production Example
A customer-profile API runs on App Service Premium behind private ingress. It calls Azure SQL through VNet integration and Private Link, retrieves secrets through managed identity/Key Vault, and is released via staging slot → tests → swap. Autoscaling and Application Insights detect peak load and failures.

### 4. Troubleshooting
**Scenario:** App is reachable publicly but cannot call private SQL.
1. Confirm VNet Integration configured (not just an inbound private endpoint), subnet delegation, route-all setting when needed and region constraints.
2. Check private DNS resolution from the app and SQL private endpoint status.
3. Review outbound NSG/UDR/Firewall restrictions and SQL identity/port 1433.
4. For slot deployment issues, verify slot-specific secrets, connection strings, warm-up checks and identity assignments before swap.
5. For private inbound failures, test DNS and whether callers use the VNet/private endpoint path.

**Interview conclusion:** “VNet Integration is for App Service outbound traffic; Private Endpoint is for private inbound traffic. I combine both with identity, slots, autoscale and observability.”

---

<a id="azure-q41"></a>
## Question 41: Azure Storage returns HTTP 403 from a VM or application. How do you troubleshoot firewall, DNS, SAS, managed identity and RBAC?

### 1. Concept
HTTP **403** generally means the Storage service received a request but refused access. Causes include network firewall restrictions, invalid/expired SAS, missing data-plane RBAC, wrong tenant/identity, denied public access, request signing errors, or storage feature/policy restrictions. A network **timeout** is a different symptom. Troubleshooting should isolate **network path → authentication → authorization → resource/object constraints**.

### 2. Implementation — step by step
1. Capture the Storage `x-ms-request-id`, `x-ms-error-code`, UTC time, operation, resource path and sanitized client SDK error. Avoid exposing SAS tokens in tickets.
2. From the client, resolve the normal hostname to the intended public/private IP:
```bash
nslookup mystorage.blob.core.windows.net
nc -zv mystorage.blob.core.windows.net 443
```
3. Inspect Storage Account → Networking: public access restriction, selected-subnet rules/service endpoint, private endpoint approval, DNS zone links and any applicable trusted-service exceptions.
4. Identify auth mode: managed identity/Entra, account key, SAS or anonymous. Prefer managed identity for internal apps.
5. Check **data-plane** RBAC role at the right scope, token tenant/audience and propagation delay. Contributor on the Storage Account does not automatically authorize blob reads.
6. For SAS, inspect signature, expiry/start time, permissions, allowed protocol/IP and resource path; rotate a leaked SAS.
7. Query Storage diagnostic logs for precise failure reason and retry after one controlled fix.

### 3. Production Example
An AKS ingestion job can list Storage account properties but fails reading invoice blobs. The identity has Contributor but not Storage Blob Data Reader. I grant the scoped data role to the actual workload identity, validate network private resolution and test an SDK read. I then add a pre-deployment permission test so the error fails in staging rather than production.

### 4. Troubleshooting
- **AuthenticationFailed:** Wrong SAS/key signature, time skew or malformed request.
- **AuthorizationPermissionMismatch:** Insufficient permission for the operation.
- **AuthorizationFailure/network deny:** Storage firewall/endpoint restrictions or identity policy; review detailed error code.
- **Private Endpoint resolves publicly:** Fix DNS links/forwarding and verify public access policy.
- **403 only for one container/blob:** Check role scope, ACLs (for ADLS Gen2), immutability or resource-level permissions.

**Interview conclusion:** “I use the Storage error code and request ID, then verify DNS/network path and the actual data-plane identity or SAS permissions.”

---
<a id="azure-section-f"></a>
# Section F — Disaster Recovery, Migration, CI/CD, Cost and Azure AI (Questions 42–50)

<a id="azure-q42"></a>
## Question 42: How would you design disaster recovery in Azure for low RTO and RPO? Compare active-active, active-passive, zones, replication and failover.

### 1. Concept
**RTO (Recovery Time Objective)** is the maximum acceptable time to restore service. **RPO (Recovery Point Objective)** is the maximum acceptable data loss measured in time. Example: RTO 15 minutes and RPO 5 minutes means service must resume within 15 minutes and at most five minutes of committed data may be lost (subject to how data consistency is defined).

- **Availability Zones:** protect from data-center/zone faults within a region, not a whole-region outage.
- **Active-active:** Both regions serve traffic; lower failover time but challenging cross-region data consistency, duplicate transactions and cost.
- **Active-passive:** A primary serves traffic, secondary is warm/hot/cold; typically easier consistency control but depends on readiness and scale-up time.
- **Backup:** restores data after deletion/corruption; it is not the same as live replication.

### 2. Implementation — step by step
1. Categorize workloads and agree **measured RTO/RPO**, consistency needs, fault domains and data residency requirements with business owners.
2. Choose primary and eligible secondary Azure regions; verify service/feature availability and capacity reservations where needed.
3. For compute: deploy zone-resilient AKS/VMSS/App Service in primary; provision secondary application stack with Terraform and pre-tested images/configuration.
4. For state: use the service's documented HA and geo-replication/failover mechanism (for example Azure SQL failover groups where appropriate), understanding asynchronous data lag and failover consistency.
5. Replicate secrets, certificates, container images and configuration; plan private DNS, firewall rules, private endpoints and identity/permissions in both regions.
6. Frontend: configure Front Door/origin groups and health probes with expected regional traffic behavior. Prevent routing to a secondary that has unhealthy database dependencies.
7. Backup: configure immutable/protected backups where supported, appropriate retention and separate restoration tests.
8. Run controlled failover drills; measure actual recovery time, data lag, transaction correctness and failback steps. Document approval and incident communication.

### 3. Production Example
For a banking transaction API targeting 15-minute RTO and 5-minute RPO, I keep a warm secondary deployment with pre-provisioned network, AKS capacity and database replication. Front Door can shift eligible stateless traffic when the secondary is healthy, while database failover is coordinated to prevent writes to divergent primaries. We verify transaction reconciliation and potential replication lag before restoring full write traffic.

### 4. Troubleshooting
**Scenario:** Primary region fails but the secondary returns HTTP 500.
1. Confirm secondary service health, readiness and capacity; inspect origin health in Front Door.
2. Check DB failover status, DNS names, connection strings, authentication and replication lag.
3. Validate secondary Key Vault, storage, private endpoints, DNS and firewall policies.
4. Review write fencing, idempotency and data consistency before accepting financial transactions.
5. Record actual RTO/RPO and remediate any gaps found in the drill or incident.

**Interview conclusion:** “I design from business RTO/RPO, separate zone HA from regional DR, replicate every dependency, test failover regularly, and validate data correctness—not just that the webpage loads.”

---

<a id="azure-q43"></a>
## Question 43: How would you configure Azure Backup, Recovery Services Vault, Azure Site Recovery, backup policies and restore testing?

### 1. Concept
**Azure Backup** helps restore protected data, VMs and other supported workloads after data loss. A **Recovery Services Vault** stores backup-management configuration and recovery points for supported scenarios. **Azure Site Recovery (ASR)** replicates supported workloads for orchestrated failover in disaster scenarios; it is different from file/VM backup. Some newer workload protections use **Backup Vault**, so choose the correct vault/service for that workload.

### 2. Implementation — step by step
1. Classify VMs/applications by criticality, data retention and target RPO/RTO; choose backup and replication separately.
2. Portal → Recovery Services Vaults → Create in the required region; configure approved redundancy and security protections.
3. Open vault → Backup → select Azure VM/supported workload → configure policy (schedule, retention, restore-point frequency) → enable backup for the target.
4. Run an on-demand initial backup; monitor backup job completion and review recovery-point availability.
5. For supported VM DR: Portal → Site Recovery → enable replication to eligible target region, choose target resources/network and replication policy; follow supported ASR orchestration requirements.
6. Configure **test failover** into an isolated validation network; check boot, dependencies and application consistency without hijacking production DNS.
7. Enable soft delete, multi-user authorization/immutability features where applicable, resource locks and least-privilege vault access.
8. Alert on backup job failures and replication health, and schedule routine restore drills with documented RTO results.

**Useful inspection:**
```bash
az backup vault list -g rg-backup -o table
az backup policy list -g rg-backup --vault-name rsv-prod -o table
```
Check CLI extension/API support for the exact workload before scripting protection changes.

### 3. Production Example
Customer document VMs receive regular application-consistent backups, with retention defined by policy. A critical settlement VM may additionally use Site Recovery to a second region. Every quarter, the team performs an isolated VM and file restore plus an ASR test failover, checking that dependencies and database recovery meet targets.

### 4. Troubleshooting
**Scenario:** Backup job failed or restore VM does not start.
1. Check vault backup job error and policy scope; confirm VM extensions, agent health and snapshot compatibility.
2. Inspect subscription permissions, quotas, target region/SKU and storage encryption/key accessibility.
3. For ASR, examine replication status, recovery-point age, target network mapping and failover plan.
4. Use boot diagnostics and guest OS logs on restored VM; verify disks, IP/DNS and app dependencies.
5. Avoid deleting failed jobs/recovery points before collecting incident evidence; escalate with job IDs and time stamps.

**Interview conclusion:** “Backup restores lost data; Site Recovery orchestrates disaster failover. I monitor both and prove recovery in controlled tests.”

---

<a id="azure-q44"></a>
## Question 44: What migration strategies would you use to move on-prem applications to Azure? Include rehost, replatform, refactor, databases, networking and rollback.

### 1. Concept
Migration methods include **rehost** (lift and shift VMs), **replatform** (move to managed services with limited changes), **refactor** (redesign application/cloud-native), **retire**, **retain**, and **replace**. Selection depends on time, compatibility, licensing, regulatory controls, downtime window and long-term operational value. Infrastructure migration without **data, identity, networking, monitoring and operational readiness** is incomplete.

### 2. Implementation — step by step
1. Assess application portfolio: owners, dependencies, data size, traffic, security, OS versions, database engines, RTO/RPO, downtime tolerance and migration wave.
2. Build an Azure landing zone with subscription hierarchy, RBAC, Azure Policy, DNS, hub-and-spoke/hybrid network, logging and Terraform modules.
3. Choose strategy per workload: rehost legacy VM via suitable migration tooling, replatform web app onto App Service, or refactor containers onto AKS when justified.
4. Set up VPN/ExpressRoute and private DNS for hybrid access; verify non-overlapping address spaces/routes.
5. For databases, choose compatible Azure destination, plan migration tooling, replication/synchronization, schema compatibility, data validation and cutover/failback boundaries.
6. Replicate/test data and application in staging; conduct security, performance and disaster-recovery tests.
7. Perform change-controlled cutover: freeze relevant writes if required, measure final data lag, update traffic routing/DNS, monitor synthetic and business transactions.
8. Keep a defined rollback plan and old environment through the agreed stabilization period; recognize when backward data synchronization becomes difficult.

### 3. Production Example
An on-premises loan-processing stack has IIS web servers, SQL database and batch jobs. I rehost the least-change batch component, move suitable web components to App Service, and migrate SQL after compatibility assessment. Terraform builds private Azure resources, hybrid DNS and monitoring. We rehearse cutover, then switch traffic under a planned maintenance window and validate transaction counts.

### 4. Troubleshooting
**Scenario:** App works in Azure staging, but production cutover fails.
1. Check DNS TTL/propagation, firewall allowlists, TLS certificates, routing and connection strings.
2. Compare actual user traffic and credentials against staging environment.
3. Validate DB data freshness, compatibility, transaction isolation and scheduled job ownership.
4. Roll back traffic within the defined window if correctness is at risk; handle writes already committed to the new target explicitly.
5. Document gaps and re-run migration drills, not only server-level connectivity tests.

**Interview conclusion:** “I migrate in waves, build the Azure landing zone first, rehearse data cutover, validate business transactions and keep a tested fallback strategy.”

---

<a id="azure-q45"></a>
## Question 45: An Azure DevOps production deployment fails midway. How would you troubleshoot pipeline logs, service connections, artifacts, approvals and rollback?

### 1. Concept
A CI/CD deployment has stages such as build, test, artifact publish, infrastructure plan/apply, application deployment and health validation. A **pipeline failure** can leave **partial infrastructure or application changes**, so retrying blindly may be unsafe. Diagnosis starts by locating the failing step and establishing what was actually deployed. Production recovery must preserve audit and approval evidence.

### 2. Implementation — step by step
1. Open Azure DevOps → Pipelines → Runs → failed run → timeline/job/task logs. Record run ID, commit SHA, environment and exact error.
2. Determine failure stage: checkout, dependency build, permissions, Terraform backend, provider/API, YAML syntax, deployment, test or post-deployment verification.
3. Check service connection/workload identity federation, permissions in Azure RBAC, variables/secrets/Key Vault references and firewall/private agent reachability.
4. If Terraform was involved, check remote state lock, saved plan and resource state; **do not run `apply` or `state push` before reconciling partial changes**.
5. If app deployment failed, inspect target platform: AKS rollout, App Service deployment slot, ARM deployment status or VM/VMSS logs.
6. If users are affected, follow the incident runbook: roll back application image/slot or route traffic to healthy version; assess whether infra rollback is safe, since not every infrastructure change is reversible.
7. Fix in code/config, validate in lower environment, and redeploy with appropriate approvals using an immutable artifact.

**Commands:**
```bash
kubectl rollout status deployment/payments-api -n prod
kubectl rollout history deployment/payments-api -n prod
terraform plan -out=tfplan
# Review the plan before any approved apply
```

### 3. Production Example
An Azure DevOps pipeline deploys a new AKS service image after Terraform networking changes. Infrastructure succeeds, but readiness probes fail. I halt further rollout, confirm the prior API version, roll back the application through the approved release process, leave healthy networking intact, gather pod logs and create a corrected release after validation.

### 4. Troubleshooting
- **401/403:** Pipeline identity, expired/faulty federation, service connection authorization, data-plane role.
- **Backend lock:** Check another active Terraform run before considering unlock.
- **YAML error:** Validate indentation, template expansion, parameters and variable evaluation.
- **Timeout:** Check agent-to-private-resource connectivity, DNS, resource provisioning and quotas.
- **Deploy succeeded but app fails:** Validate health probes, secrets, image, configuration and database migration.

**Interview conclusion:** “I identify the failed stage, reconcile actual infrastructure, protect production with rollback/traffic control, then fix and rerun the approved pipeline with evidence.”

---

<a id="azure-q46"></a>
## Question 46: How would you design a highly available application using VM Scale Sets, Availability Zones, Load Balancer, managed database and autoscaling?

### 1. Concept
**High availability (HA)** reduces downtime from instance, process or zone failure. VM Scale Sets (VMSS) maintain a set of compute instances; Azure Load Balancer/Application Gateway directs traffic to healthy instances. Availability Zones provide separate data-center fault domains. HA also requires **database resilience, stateless app design, health probes and operational discipline**—not just two VMs.

### 2. Implementation — step by step
1. Define SLO, fault tolerance, peak demand and minimum capacity. Pick a supported region with required zones/VM sizes.
2. Create a secure VNet and backend subnet, NSGs, private connectivity and monitoring.
3. Create VMSS from a hardened immutable image or validated configuration. Distribute instances across supported zones and use multiple healthy instances.
4. Attach VMSS backend to a Standard internal/public Load Balancer or Application Gateway as appropriate.
5. Set health probes against a meaningful health endpoint and configure graceful shutdown/draining to avoid dropped sessions.
6. Configure autoscaling using CPU or application metrics with stable min/max settings and tested scaling response.
7. Use a managed database with appropriate zone redundancy/HA configuration. Store sessions in a shared durable service rather than local VM memory if app design requires consistency.
8. Enable alerts on unhealthy nodes, request failures, scale failures, database health and availability-zone events.

### 3. Production Example
A two-tier intranet application uses a zone-resilient VMSS running two or more API instances, behind an internal Load Balancer. Data resides on a zone-resilient managed database where supported. Traffic remains available if one VM fails; we rehearse zone/instance failure and validate backend health probes and remaining capacity.

### 4. Troubleshooting
**Scenario:** One VMSS instance fails but customer requests fail anyway.
1. Verify load balancer probe accurately marked the broken instance unhealthy.
2. Check remaining instances have enough capacity and no shared dependency failure.
3. Inspect autoscaling events, failed provisioning/quota or image configuration drift.
4. Investigate local-session dependency, fixed backend IPs or unhandled retries that defeat redundancy.
5. Improve fault-injection tests and traffic draining to meet measured availability targets.

**Interview conclusion:** “HA means redundant healthy instances across fault domains, correct traffic routing, resilient data and tested autoscaling—not only multiple servers.”

---

<a id="azure-q47"></a>
## Question 47: Application is completely down although Azure shows VMs and AKS clusters as healthy. How would you collect evidence and coordinate incident response?

### 1. Concept
Azure resource `Running` or cluster `Succeeded` is a **control-plane state**, not a customer transaction success signal. Failure may be at DNS, Front Door, Application Gateway, ingress, TLS, backend pods, identity, private endpoints, SQL, storage or messaging. As an SRE I prioritize **restore service first while preserving evidence** and escalate with facts, not guesses.

### 2. Implementation — step by step
1. Declare severity and incident commander/on-call roles. Confirm external customer impact through synthetic probes, SLO metrics and recent support reports.
2. Draw the request path: client → DNS → Front Door/WAF → regional ingress → service → pod/VM → database/queue/storage.
3. Compare each hop's metrics and logs: DNS resolution, gateway 5xx, backend health, Kubernetes endpoints/readiness, app exceptions, dependency latency and network rejects.
4. Pull Azure Activity Log and Azure DevOps change timeline. Identify configuration updates, certificate expiry, managed identity changes or DNS modifications.
5. Reproduce a controlled transaction, capture correlation ID, UTC timestamp, response code and region; redact sensitive customer data.
6. Apply safe mitigation: rollback recent app deployment, route away from failed region, recover private DNS/identity or scale the confirmed bottleneck.
7. Coordinate with app team for stack traces, network team for route/packet evidence, DB team for connectivity/locks and Microsoft support for platform faults.
8. After recovery, document incident timeline, actual root cause, preventative changes, alert gaps and verification evidence.

**Basic checks:**
```bash
nslookup api.example.com
curl -sv --max-time 10 https://api.example.com/health
kubectl get ingress,svc,endpoints,pods -n prod
kubectl get events -n prod --sort-by=.metadata.creationTimestamp
```

### 3. Production Example
Customer login fails across all regions while AKS nodes are Ready. Gateway access logs show successful TLS but APIs return 500. Traces reveal calls to Key Vault failing with 403 after a role assignment change. I coordinate a reviewed identity permission repair, restore service, validate token/secret access and add an alert on dependency authorization failures.

### 4. Troubleshooting
- **No HTTP response at all:** DNS, TLS, routing, firewall, global frontend.
- **502/503:** Backend health, ingress, endpoint readiness, app capacity.
- **500:** Application exception, secrets, DB/queue dependency, configuration.
- **Only one region:** Regional routing, origin health, private DNS and dependencies.
- **No telemetry:** Use control-plane logs, local pod/VM logs, network logs and synthetic probes; fix observability separately.

**Interview conclusion:** “I trace customer traffic end to end, correlate logs with changes, restore service safely, and share timestamps/resource IDs with the responsible teams.”

---

<a id="azure-q48"></a>
## Question 48: How would you optimize Azure cost using Advisor, reservations, savings plans, scaling, tags and Log Analytics controls?

### 1. Concept
**FinOps** balances reliability, performance and spend. Azure cost optimization means reducing waste without damaging SLOs: right-size compute, schedule nonproduction environments, select commitment discounts for suitable steady usage, control autoscaling, review storage tiers and prevent excessive telemetry ingestion. Cost governance needs **visibility by team/workload** through budgets and tags.

### 2. Implementation — step by step
1. Portal → Cost Management + Billing → Cost Analysis; group by subscription, service, resource group, resource tags and trend. Create budgets/anomaly alerts.
2. Azure Advisor → Cost recommendations: identify underutilized VMs, idle disks/public IPs and potential commitment coverage.
3. Evaluate **Reserved Instances/Reservations** for predictable eligible workloads, and **Azure savings plan for compute** where suitable; review commitment/region/SKU applicability before purchasing.
4. Use VMSS/AKS autoscaling with measured minimum capacity and HPA/KEDA for suitable apps. Schedule nonproduction VMs/AKS node pools where safe.
5. Review Storage access tiers and lifecycle management; avoid unnecessary geo-replication if requirements don't justify it.
6. Monitor Azure Monitor/Log Analytics ingestion: filter noisy logs with DCR transformations where supported, choose table plans and retention based on audit requirements, and sample high-volume application traces responsibly.
7. Enforce tags (`Environment`, `Owner`, `CostCenter`) through Azure Policy; automate weekly trend/cost report.
8. Measure cost per request/transaction against uptime, latency and incident frequency—not just absolute spend.

### 3. Production Example
An AKS staging pool runs 24/7 despite weekday-only testing. I reduce baseline staging capacity outside office hours, keep production pools resilient, right-size based on utilization and preserve production latency budgets. In Log Analytics, we discover verbose debug logs consume most ingestion; after security approval we filter debug events and adjust retention without losing audit records.

### 4. Troubleshooting
**Scenario:** Azure cost doubles after an AKS release.
1. Compare day-by-day cost, service/region and resource tags; identify new node sizes/counts, disks, Load Balancers or data egress.
2. Check HPA/Cluster Autoscaler histories for maxed-out nodes caused by high resource requests or scaling loops.
3. Examine Log Analytics ingestion volume by table; check whether a new debug instrumentation version multiplies events.
4. Validate whether reservations/savings plans are applied as expected and whether commitment overage occurred.
5. Optimize one area at a time, monitor SLO and rollback cost changes that harm reliability.

**Interview conclusion:** “I use Cost Management and Advisor for visibility, right-size and autoscale based on metrics, control log ingestion and never trade away production reliability without business approval.”

---

<a id="azure-q49"></a>
## Question 49: What is Azure AI Foundry (Microsoft Foundry), and how would you set up, secure, deploy and monitor an LLM application?

### 1. Concept
**Microsoft Foundry** is Microsoft's platform for building, deploying, monitoring and governing AI applications and agents. Many job descriptions still call it **Azure AI Foundry**. The platform includes model catalogs/deployment capabilities and agent/tool integration. For an Azure SRE role, key concerns are **identity, networking, quotas, governance, logging, cost and safe operational access**, not training a large language model from scratch.

### 2. Implementation — step by step
1. Confirm organization/region/model availability, data-classification policy, permitted models, responsible AI requirements, and which **Foundry resource/project experience** the organization uses. Portal names and deployment types vary across versions.
2. In the current Foundry portal/Azure Portal, create the appropriate Foundry resource/project or other supported AI resource under an approved subscription/resource group.
3. Deploy an approved model using the appropriate **model deployment type**, quota and region; set scaling/cost limits. Record the endpoint and deployment identifiers.
4. Secure access with Microsoft Entra authentication and managed identity/service identity where supported; scope RBAC narrowly. Prefer private connectivity and public-access restrictions **when the chosen resource/deployment supports them**.
5. Store any necessary API credentials in Key Vault; avoid logging prompts containing customer PII or credentials.
6. Instrument application-level request latency, error codes, token consumption, throughput limits, safety-filter decisions and operational cost. Use Azure Monitor/Application Insights/Foundry tracing as supported by the chosen setup.
7. Test rate limits, timeouts, retry with backoff, model fallback, retrieval authorization and data-redaction controls before production rollout.

### 3. Production Example
An internal SRE assistant summarizes Azure Monitor incidents and suggests relevant runbooks. The app runs inside a controlled Azure environment and calls an approved Foundry model deployment. Managed identity secures relevant tool access; users can view a proposed action, but restarting a VM or changing a firewall rule requires human approval. Sensitive logs are sanitized before they reach an LLM.

### 4. Troubleshooting
**Scenario:** Requests to the model endpoint return 401, 429 or timeout.
1. **401/403:** Confirm intended identity, token, RBAC, resource/model deployment, endpoint URL and approved network path.
2. **429:** Check quota, token/request rate, regional capacity and retry/backoff. Reduce concurrency or choose an approved capacity option.
3. **Timeout:** Validate DNS, private endpoint/support, firewall/proxy, TLS, model response time and request size.
4. **High cost:** Inspect token consumption, repeated prompts, cache opportunities and run frequency.
5. **Wrong answers:** Evaluate quality/grounding, source freshness, retrieval permissions and safety rules; avoid automated high-risk infra changes.

**Interview conclusion:** “As an SRE I secure and operate the model endpoint: identity, private networking where supported, quotas, alerts, latency, tokens, governance and human-controlled actions.”

---

<a id="azure-q50"></a>
## Question 50: What are Azure ML Workspace, model registry, managed online endpoints, MLOps, LLMOps, LangChain and agentic AI workflows?

### 1. Concept
These terms cover model lifecycle and operations:

| Term | Meaning | SRE/DevOps focus |
|---|---|---|
| Azure Machine Learning Workspace | Organizes ML assets, jobs, compute and model deployments | Identity, compute, network, monitoring |
| Model registry | Versions and tracks registered ML models/assets | Controlled promotion and lineage |
| Managed online endpoint | Managed API endpoint for real-time model inference | Deployment, traffic, scaling, monitoring |
| MLOps | CI/CD and observability for ML models and data | Reproducibility, drift, evaluation |
| LLMOps | Operational lifecycle of LLM apps | Prompt/version evaluation, RAG, tokens, latency |
| LangChain | Library/framework for LLM app pipelines and tool integrations | Secure integrations and tracing |
| LangGraph | Framework for stateful agent/workflow graphs | State, checkpoints, retries, control |
| Agentic AI | AI uses tools/steps to pursue bounded tasks | Permissions, approvals, audit, safe rollback |

A **model registry** is not the same as Azure Container Registry (ACR): the former tracks ML model assets; ACR stores container images/artifacts.

### 2. Implementation — step by step
1. Create an Azure ML Workspace with required supporting storage/Key Vault/ACR and appropriate identity/network settings; confirm SKU/region support.
2. Register versioned model artifacts in a model registry/workspace; capture training data/model lineage and validation results.
3. Deploy the approved model to a managed online endpoint with a named deployment, appropriate VM/SKU, replica settings and identity.
4. Test inference, authentication, request/response contracts and latency; introduce blue-green/canary traffic routing where supported.
5. CI/CD validates model/package, security scan, integration tests, evaluation and approval before promotion.
6. For LLMOps, version prompts/RAG indexes/evaluations; monitor hallucination rate, grounding/quality, tokens and operational cost.
7. For agent workflows, strictly allowlist tools, grant minimum privileges and require explicit approval before dangerous actions (restart, delete, firewall change, payment-related operation).

### 3. Production Example
An operations team deploys an anomaly-detection model in Azure ML to classify application errors. Azure DevOps promotes a versioned model after performance tests. A separate LLM assistant using LangGraph summarizes anomalies and proposes responses but **does not independently change production infrastructure**. All tool calls are logged, sanitized and reviewed.

### 4. Troubleshooting
**Scenario:** New model endpoint deploys but inference requests fail or latency doubles.
1. Check endpoint/deployment provisioning state, logs and model/container startup.
2. Confirm model artifact path, runtime dependencies, scoring script, schema and appropriate hardware capacity.
3. Verify endpoint authentication, private networking and outbound access to required dependencies.
4. Compare request rate, token/payload size, CPU/GPU memory and throttling with the prior version.
5. Shift traffic back to the last healthy deployment where supported, preserve logs and rerun validation before promotion.

**Interview conclusion:** “Azure ML runs versioned model workloads; MLOps manages the model lifecycle, LLMOps adds prompt/RAG/evaluation monitoring, and agentic workflows require restricted tool access and human approval.”

---

# Official References for Further Study

These are official Microsoft references for checking current portal names, product limits, SDK versions and supported configurations:

1. [Azure load-balancing service comparison](https://learn.microsoft.com/en-us/azure/architecture/guide/technology-choices/load-balancing-overview)
2. [AKS cluster reliability best practices](https://learn.microsoft.com/en-us/azure/aks/best-practices-app-cluster-reliability)
3. [AKS CLI commands and supported upgrades](https://learn.microsoft.com/en-us/cli/azure/aks)
4. [AKS scaling: HPA and autoscalers](https://learn.microsoft.com/en-us/azure/aks/horizontal-pod-autoscaler)
5. [Azure Monitor Data Collection Rules](https://learn.microsoft.com/en-us/azure/azure-monitor/data-collection/data-collection-rule-overview)
6. [Managing DCR associations](https://learn.microsoft.com/en-us/azure/azure-monitor/data-collection/data-collection-rule-associations)
7. [Compare Azure messaging services](https://learn.microsoft.com/en-us/azure/event-grid/compare-messaging-services)
8. [Compare Storage Queue and Service Bus](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-azure-and-service-bus-queues-compared-contrasted)
9. [Azure Event Grid Functions handlers](https://learn.microsoft.com/en-us/azure/event-grid/handler-functions)
10. [App Service VNet integration](https://learn.microsoft.com/en-us/azure/app-service/overview-vnet-integration)
11. [What is Microsoft Foundry?](https://learn.microsoft.com/en-us/azure/ai-foundry/what-is-foundry)
12. [Azure Well-Architected Framework—Reliability](https://learn.microsoft.com/en-us/azure/well-architected/reliability/)
13. [Azure Security best practices](https://learn.microsoft.com/en-us/azure/security/fundamentals/best-practices-and-patterns)

---

## Interview Answer Practice Template

For each question: **(1) 20–30 seconds on concept → (2) 60–90 seconds on configuration → (3) one specific production example → (4) 30–60 seconds on troubleshooting**. Adapt depth to the interviewer and be ready to explain a CLI command, failure mode or design tradeoff in detail. Use only experience you actually have; for a scenario you haven't performed, describe how you *would* implement it.
