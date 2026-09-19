# =============================================================================
# Azure Infrastructure - Highly Available Web Application
# Equivalent of the AWS VPC + ALB + EC2 project, ported to Azure
# =============================================================================

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------
variable "location" {
}

variable "vnet_cidr" {
}

variable "subnet_cidr" {
}

variable "admin_username" {
}

variable "dns_label_prefix" {
}

# -----------------------------------------------------------------------------
# Resource Group - Azure's container for all resources in this project
# (AWS has no equivalent; every Azure resource must live inside one)
# -----------------------------------------------------------------------------
resource "azurerm_resource_group" "main" {
  name     = "demo-rg"
  location = var.location
}

# -----------------------------------------------------------------------------
# Networking Layer
# -----------------------------------------------------------------------------

# Virtual Network - equivalent of AWS VPC
resource "azurerm_virtual_network" "main" {
  name                = "demo-vnet"
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Name = "demo_vnet"
  }
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

# Subnet - hosts both web servers (they land in different Availability Zones,
# not different subnets, since Azure subnets already span all zones in a region)
resource "azurerm_subnet" "web" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_cidr]
}

output "subnet_id" {
  value = azurerm_subnet.web.id
}

# -----------------------------------------------------------------------------
# NAT Gateway - lets the web servers reach the internet for updates,
# without giving them a public IP of their own (equivalent of AWS NAT Gateway)
# -----------------------------------------------------------------------------
resource "azurerm_public_ip" "nat_gateway_ip" {
  name                = "nat-gateway-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Name = "nat_gateway_ip"
  }
}

resource "azurerm_nat_gateway" "main" {
  name                = "demo-natgw"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku_name            = "Standard"

  tags = {
    Name = "demo_natgw"
  }
}

resource "azurerm_nat_gateway_public_ip_association" "main" {
  nat_gateway_id       = azurerm_nat_gateway.main.id
  public_ip_address_id = azurerm_public_ip.nat_gateway_ip.id
}

# Attaching the NAT Gateway to the subnet is what makes every VM in that
# subnet route its outbound internet traffic through it automatically -
# no manual route table entry needed, unlike AWS.
resource "azurerm_subnet_nat_gateway_association" "main" {
  subnet_id      = azurerm_subnet.web.id
  nat_gateway_id = azurerm_nat_gateway.main.id
}

# -----------------------------------------------------------------------------
# Security Layer - Network Security Group (equivalent of AWS Security Group)
# -----------------------------------------------------------------------------
resource "azurerm_network_security_group" "web_nsg" {
  name                = "web-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  # Only allow port 80 from Azure's Load Balancer infrastructure -
  # this is the Azure equivalent of AWS's "security group chaining"
  # (ec2_sg only accepting traffic from load_balancer_sg)
  security_rule {
    name                       = "Allow-HTTP-From-LoadBalancer"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  # Wide outbound access so VMs can reach the internet (via NAT Gateway)
  # for package updates - equivalent of AWS's "egress all to anywhere"
  security_rule {
    name                       = "Allow-All-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Name = "web_nsg"
  }
}

resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

# -----------------------------------------------------------------------------
# SSH Key - generated automatically for this demo so you don't need to
# create one yourself first. For real production use, manage keys via
# Azure Key Vault instead of letting Terraform generate and store one.
# -----------------------------------------------------------------------------
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/azure_vm_key.pem"
  file_permission = "0600"
}

# -----------------------------------------------------------------------------
# Compute Layer - Virtual Machines (equivalent of AWS EC2 instances)
# -----------------------------------------------------------------------------

# Network Interface for Web Server 1 - Azure VMs require a separate NIC
# resource; AWS lets you configure networking inline on the instance itself.
resource "azurerm_network_interface" "web_server1_nic" {
  name                = "web-server-1-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "web_server2_nic" {
  name                = "web-server-2-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "web_server1" {
  name                = "web-server-1"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B1s" # closest equivalent to AWS t2.micro
  admin_username      = var.admin_username
  zone                = "1" # Availability Zone 1

  network_interface_ids = [
    azurerm_network_interface.web_server1_nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = filebase64("web-server-1-init.sh")

  tags = {
    Name = "WebServer1"
  }
}

resource "azurerm_linux_virtual_machine" "web_server2" {
  name                = "web-server-2"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  zone                = "2" # Availability Zone 2 - spreads the two VMs for high availability

  network_interface_ids = [
    azurerm_network_interface.web_server2_nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = filebase64("web-server-2-init.sh")

  tags = {
    Name = "WebServer2"
  }
}

# -----------------------------------------------------------------------------
# Load Balancing Layer (equivalent of AWS Application Load Balancer)
# -----------------------------------------------------------------------------
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-public-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = var.dns_label_prefix

  tags = {
    Name = "lb_public_ip"
  }
}

resource "azurerm_lb" "app_lb" {
  name                = "app-lb"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }

  tags = {
    Name = "app_lb"
  }
}

resource "azurerm_lb_backend_address_pool" "app_tg" {
  loadbalancer_id = azurerm_lb.app_lb.id
  name            = "app-tg"
}

resource "azurerm_network_interface_backend_address_pool_association" "web_server1" {
  network_interface_id   = azurerm_network_interface.web_server1_nic.id
  ip_configuration_name  = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.app_tg.id
}

resource "azurerm_network_interface_backend_address_pool_association" "web_server2" {
  network_interface_id   = azurerm_network_interface.web_server2_nic.id
  ip_configuration_name  = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.app_tg.id
}

resource "azurerm_lb_probe" "http_health_probe" {
  loadbalancer_id     = azurerm_lb.app_lb.id
  name                = "http-health-probe"
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 30
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "http_rule" {
  loadbalancer_id                = azurerm_lb.app_lb.id
  name                           = "http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.app_tg.id]
  probe_id                       = azurerm_lb_probe.http_health_probe.id
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------
output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "load_balancer_public_ip" {
  value = azurerm_public_ip.lb_public_ip.ip_address
}

output "load_balancer_fqdn" {
  value = azurerm_public_ip.lb_public_ip.fqdn
}

output "web_server1_private_ip" {
  value = azurerm_network_interface.web_server1_nic.private_ip_address
}

output "web_server2_private_ip" {
  value = azurerm_network_interface.web_server2_nic.private_ip_address
}
