# AWS Infrastructure with Terraform - Complete Project Documentation

## Project Overview

This project demonstrates the deployment of a production-grade, highly available web application infrastructure on AWS using Terraform. The architecture includes a Virtual Private Cloud (VPC) with public and private subnets across multiple Availability Zones, an Application Load Balancer, EC2 instances, and NAT Gateway for secure internet access from private subnets.

---

## Architecture Diagram

```
                                    Internet
                                        |
                                        |
                                [Internet Gateway]
                                        |
                    +-----------------------------------------+
                    |              VPC (10.0.0.0/16)         |
                    |                                         |
                    |  +----------------+  +----------------+ |
                    |  | Public Subnet1 |  | Public Subnet2 | |
                    |  | (10.0.1.0/24)  |  | (10.0.2.0/24)  | |
                    |  | us-east-1a     |  | us-east-1b     | |
                    |  |                |  |                | |
                    |  | [NAT Gateway]  |  |                | |
                    |  | [EIP]          |  |                | |
                    |  +-------+--------+  +-------+--------+ |
                    |          |                   |          |
                    |          +---[Load Balancer]-+          |
                    |                   |                     |
                    |  +----------------+  +----------------+ |
                    |  |Private Subnet1 |  |Private Subnet2 | |
                    |  | (10.0.3.0/24)  |  | (10.0.4.0/24)  | |
                    |  | us-east-1a     |  | us-east-1b     | |
                    |  |                |  |                | |
                    |  | [EC2 Instance] |  | [EC2 Instance] | |
                    |  | Web Server 1   |  | Web Server 2   | |
                    |  +----------------+  +----------------+ |
                    |                                         |
                    +-----------------------------------------+
```

---

## Infrastructure Components

### 1. **Networking Layer**

#### VPC (Virtual Private Cloud)
- **CIDR Block**: 10.0.0.0/16
- **Purpose**: Isolated network environment for all resources
- **Tag**: demo_vpc

#### Subnets
The infrastructure uses 4 subnets across 2 Availability Zones for high availability:

**Public Subnets:**
- **public_subnet1**: 10.0.1.0/24 (us-east-1a)
- **public_subnet2**: 10.0.2.0/24 (us-east-1b)
- Resources in these subnets have direct internet access via Internet Gateway

**Private Subnets:**
- **private_subnet1**: 10.0.3.0/24 (us-east-1a)
- **private_subnet2**: 10.0.4.0/24 (us-east-1b)
- Resources in these subnets access internet via NAT Gateway

#### Internet Gateway
- Enables communication between VPC and the internet
- Attached to VPC for public subnet routing

#### NAT Gateway
- **Location**: public_subnet1
- **Purpose**: Allows private subnet instances to access internet for updates
- **Elastic IP**: Dedicated static IP for NAT Gateway
- **Dependency**: Requires Internet Gateway to be created first

#### Route Tables

**Public Route Table:**
- Routes 0.0.0.0/0 traffic to Internet Gateway
- Associated with both public subnets

**Private Route Table:**
- Routes 0.0.0.0/0 traffic to NAT Gateway
- Associated with both private subnets

---

### 2. **Security Layer**

#### Load Balancer Security Group (`load_balancer_sg`)
- **Name**: lb_sg
- **Ingress Rules**:
  - Port 80 (HTTP) from anywhere (0.0.0.0/0)
- **Egress Rules**:
  - All traffic to anywhere
- **Purpose**: Controls traffic to the Application Load Balancer

#### EC2 Security Group (`ec2_sg`)
- **Name**: web_sg
- **Ingress Rules**:
  - Port 80 (HTTP) only from Load Balancer Security Group
- **Egress Rules**:
  - All traffic to anywhere
- **Purpose**: Restricts web server access to only load balancer traffic

---

### 3. **Compute Layer**

#### EC2 Instances (Web Servers)

**Web Server 1:**
- **AMI**: ami-0ecb62995f68bb549 (Ubuntu)
- **Instance Type**: t2.micro
- **Subnet**: private_subnet1 (us-east-1a)
- **Security Group**: ec2_sg
- **User Data**: test.sh (installs Apache, displays "Hello from Web Server 1")

**Web Server 2:**
- **AMI**: ami-0ecb62995f68bb549 (Ubuntu)
- **Instance Type**: t2.micro
- **Subnet**: private_subnet2 (us-east-1b)
- **Security Group**: ec2_sg
- **User Data**: test2.sh (installs Apache, displays "Hello from Web Server 2")

---

### 4. **Load Balancing Layer**

#### Application Load Balancer
- **Name**: app-lb
- **Type**: Application Load Balancer
- **Scheme**: Internet-facing
- **Subnets**: Both public subnets (for high availability)
- **Security Group**: load_balancer_sg

#### Target Group
- **Name**: app-tg
- **Port**: 80
- **Protocol**: HTTP
- **Health Check**:
  - Path: /
  - Protocol: HTTP
  - Expected Response: 200
  - Interval: 30 seconds
  - Timeout: 5 seconds
  - Healthy Threshold: 2
  - Unhealthy Threshold: 2

#### Target Group Attachments
- Web Server 1 registered on port 80
- Web Server 2 registered on port 80

#### Listener
- **Port**: 80
- **Protocol**: HTTP
- **Default Action**: Forward to target group (app_tg)

---

## File Structure

```
c:\NewTerraform\
├── main.tf                    # Main Terraform configuration
├── terraform.tfvars           # Variable values
├── test.sh                    # User data script for Web Server 1
├── test2.sh                   # User data script for Web Server 2
├── terraform.tfstate          # Current state file
├── terraform.tfstate.backup   # Backup state file
└── my_ssh_key.pem.pub        # SSH public key (legacy)
```

---

## Configuration Files

### main.tf

The main Terraform configuration file containing:
- AWS Provider configuration
- Variable declarations
- VPC and networking resources
- Security groups
- EC2 instances
- Load balancer configuration
- Output values

### terraform.tfvars

Variable values for the infrastructure:

```hcl
region = "us-east-1"
vpc_cidr = "10.0.0.0/16"
public_subnet1_cidr = "10.0.1.0/24"
public_subnet2_cidr = "10.0.2.0/24"
private_subnet1_cidr = "10.0.3.0/24"
private_subnet2_cidr = "10.0.4.0/24"
```

### test.sh (Web Server 1 Bootstrap Script)

```bash
#!/bin/bash
apt-get update
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "Hello from Web Server 1" > /var/www/html/index.html
```

**Purpose**: Automatically configures the first web server with Apache and custom content

### test2.sh (Web Server 2 Bootstrap Script)

```bash
#!/bin/bash
apt-get update
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "Hello from Web Server 2" > /var/www/html/index.html
```

**Purpose**: Automatically configures the second web server with Apache and custom content

---

## Variables

| Variable Name | Description | Type | Example Value |
|--------------|-------------|------|---------------|
| `region` | AWS region for deployment | string | us-east-1 |
| `vpc_cidr` | CIDR block for VPC | string | 10.0.0.0/16 |
| `public_subnet1_cidr` | CIDR for first public subnet | string | 10.0.1.0/24 |
| `public_subnet2_cidr` | CIDR for second public subnet | string | 10.0.2.0/24 |
| `private_subnet1_cidr` | CIDR for first private subnet | string | 10.0.3.0/24 |
| `private_subnet2_cidr` | CIDR for second private subnet | string | 10.0.4.0/24 |

---

## Outputs

The infrastructure provides the following outputs:

| Output Name | Description | Example Value |
|------------|-------------|---------------|
| `vpc_id` | ID of the created VPC | vpc-0123456789abcdef0 |
| `public_subnet_ids` | IDs of public subnets | ["subnet-abc123", "subnet-def456"] |
| `private_subnet_ids` | IDs of private subnets | ["subnet-ghi789", "subnet-jkl012"] |
| `load_balancer_dns` | DNS name of the load balancer | app-lb-1234567890.us-east-1.elb.amazonaws.com |

---

## Deployment Steps

### Prerequisites
1. AWS Account with appropriate credentials
2. Terraform installed (v1.0+)
3. AWS CLI configured with access keys
4. Appropriate IAM permissions

### Step-by-Step Deployment

#### 1. Initialize Terraform
```powershell
terraform init
```
**What it does**:
- Downloads the AWS provider plugin
- Initializes the backend
- Prepares the working directory

#### 2. Validate Configuration
```powershell
terraform validate
```
**What it does**:
- Checks syntax and configuration validity
- Ensures all required variables are defined

#### 3. Plan Infrastructure
```powershell
terraform plan
```
**What it does**:
- Shows what resources will be created
- Provides a preview of changes
- Validates variable values

#### 4. Apply Configuration
```powershell
terraform apply -auto-approve
```
**What it does**:
- Creates all AWS resources
- Provisions EC2 instances with user data
- Configures load balancer and target groups
- Outputs important values (VPC ID, Load Balancer DNS, etc.)

#### 5. Verify Deployment
Access the load balancer DNS name in a browser:
```
http://<load_balancer_dns>
```
You should see either:
- "Hello from Web Server 1" or
- "Hello from Web Server 2"

Refresh multiple times to see load balancing in action.

---

## How It Works

### Traffic Flow

1. **User Request**: User accesses the Load Balancer DNS name via HTTP
2. **Load Balancer**: Receives the request on port 80 in public subnet
3. **Target Group**: Load balancer forwards request to healthy target
4. **Web Server**: EC2 instance in private subnet receives request
5. **Response**: Apache serves the HTML page
6. **Return Path**: Response travels back through load balancer to user

### High Availability

- **Multiple AZs**: Resources distributed across us-east-1a and us-east-1b
- **Load Balancing**: Traffic distributed between two web servers
- **Health Checks**: Unhealthy instances automatically removed from rotation
- **Auto Recovery**: Load balancer only sends traffic to healthy instances

### Security Features

1. **Network Isolation**: Web servers in private subnets (no direct internet access)
2. **Security Group Chaining**: EC2 instances only accept traffic from load balancer
3. **NAT Gateway**: Private instances can update software without public IPs
4. **Least Privilege**: Minimal ingress rules on security groups

---

## Key Terraform Concepts Used

### Resource Dependencies
- Explicit: `depends_on` attribute for NAT Gateway and Load Balancer
- Implicit: References like `aws_vpc.main.id` create automatic dependencies

### Variable Management
- Centralized variable declarations
- External variable file (`terraform.tfvars`)
- Parameterized infrastructure for reusability

### State Management
- `terraform.tfstate`: Current infrastructure state
- `terraform.tfstate.backup`: Previous state for rollback

### File Functions
- `file()`: Loads external files (user data scripts)
- `path.module`: References current module path

### Outputs
- Expose important values for consumption
- Enable integration with other systems
- Provide verification data

---

## Best Practices Implemented

1. **Multi-AZ Deployment**: Resources spread across availability zones
2. **Security Groups**: Restrictive ingress rules, wide egress for updates
3. **Private Subnets**: Web servers not directly exposed to internet
4. **NAT Gateway**: Secure outbound internet access for private resources
5. **Health Checks**: Automated monitoring and recovery
6. **Tagging**: All resources tagged for identification and cost tracking
7. **Variables**: Parameterized configuration for easy modification
8. **User Data**: Automated instance configuration (Infrastructure as Code)

---

## Cost Considerations

### Billable Resources
- **EC2 Instances**: 2 × t2.micro (~$0.0116/hour each)
- **Application Load Balancer**: ~$0.0225/hour + data processing
- **NAT Gateway**: ~$0.045/hour + data processing ($0.045/GB)
- **Elastic IP**: Free when attached to running NAT Gateway
- **Data Transfer**: Charges for outbound internet traffic

### Estimated Monthly Cost
Approximately **$35-50/month** depending on traffic volume

---

## Migration from Previous Infrastructure

### Changes from Original Setup
1. **Removed**: SSH key pair and bastion host configuration
2. **Removed**: Single public subnet with direct EC2 access
3. **Added**: Private subnets for enhanced security
4. **Added**: NAT Gateway for secure internet access
5. **Added**: Application Load Balancer for high availability
6. **Added**: Second availability zone for redundancy
7. **Updated**: Security groups for load balancer architecture
8. **Updated**: AMI from Amazon Linux to Ubuntu

---

## Troubleshooting

### Common Issues

**Problem**: Load balancer shows unhealthy targets
- **Solution**: Check security group rules allow traffic from LB to EC2
- **Verify**: Health check path (/) returns HTTP 200
- **Check**: Apache is running on EC2 instances

**Problem**: Can't access load balancer DNS
- **Solution**: Verify load balancer is in public subnets
- **Check**: Security group allows inbound port 80 from 0.0.0.0/0
- **Wait**: DNS propagation may take a few minutes

**Problem**: EC2 instances can't access internet
- **Solution**: Verify NAT Gateway is running
- **Check**: Private route table points to NAT Gateway
- **Verify**: NAT Gateway has Elastic IP attached

### Verification Commands

```powershell
# Check Terraform state
terraform show

# Verify outputs
terraform output

# Refresh state from AWS
terraform refresh

# View specific resource
terraform state show aws_lb.app_lb
```

---

## Cleanup

To destroy all resources and avoid ongoing charges:

```powershell
terraform destroy -auto-approve
```

**Warning**: This will delete all infrastructure including:
- VPC and all subnets
- EC2 instances
- Load balancer and target groups
- NAT Gateway and Elastic IP
- Internet Gateway
- Security groups
- Route tables

---

## Future Enhancements

1. **Auto Scaling**: Add Auto Scaling Group for dynamic capacity
2. **HTTPS**: Implement SSL/TLS with ACM certificate
3. **Database**: Add RDS database in private subnets
4. **Monitoring**: Integrate CloudWatch alarms and dashboards
5. **Logging**: Enable access logs for load balancer
6. **Backup**: Implement automated EBS snapshots
7. **CI/CD**: Integrate with AWS CodePipeline or GitHub Actions
8. **Multiple Environments**: Use Terraform workspaces for dev/staging/prod
9. **Remote State**: Store state in S3 with DynamoDB locking
10. **Secrets Management**: Use AWS Secrets Manager or Parameter Store

---

## Conclusion

This project demonstrates a production-ready, highly available web application infrastructure on AWS. The architecture follows AWS best practices for security, scalability, and reliability. By using Terraform, the entire infrastructure is defined as code, making it version-controlled, repeatable, and easy to manage.

The multi-tier architecture with public and private subnets, load balancing, and multi-AZ deployment provides a solid foundation that can be extended for real-world applications.

---

## Resources and References

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [AWS Application Load Balancer Guide](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

---

**Project Status**: ✅ Deployed and Running  
**Last Updated**: January 18, 2026  
**Terraform Version**: Compatible with Terraform 1.0+  
**AWS Provider Version**: Compatible with hashicorp/aws latest
