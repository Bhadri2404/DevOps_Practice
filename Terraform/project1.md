# AWS Infrastructure with Terraform

This Terraform configuration creates a complete AWS infrastructure including VPC, subnet, EC2 instance, and security groups.

## Architecture Overview

This setup creates:
- **VPC** with CIDR block `10.0.0.0/16`
- **Public Subnet** in availability zone `us-east-1a`
- **Internet Gateway** for public internet access
- **Route Table** with routes to the internet gateway
- **Security Group** allowing SSH access from your IP
- **EC2 Instance** (t2.micro) with Amazon Linux 2
- **SSH Key Pair** for secure server access

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed (version 0.12+)
- [AWS CLI](https://aws.amazon.com/cli/) configured with credentials
- SSH client (OpenSSH or similar)
- Your public IP address

## Creating SSH Key Pair (PEM File)

Before running Terraform, you need to create an SSH key pair locally:

### On Windows (PowerShell/Git Bash):

```bash
ssh-keygen -t rsa -b 2048 -f "c:\NewTerraform\my_ssh_key.pem" -N '""' -m PEM
```

### On Linux/Mac:

```bash
ssh-keygen -t rsa -b 2048 -f ./my_ssh_key.pem -N "" -m PEM
```

**What this does:**
- `-t rsa`: Creates an RSA key pair
- `-b 2048`: Uses 2048-bit encryption
- `-f`: Specifies the output file name
- `-N ""`: Sets an empty passphrase (no password required)
- `-m PEM`: Saves the key in PEM format (required for AWS)

This command creates two files:
- `my_ssh_key.pem` - **Private key** (keep this secure, never share)
- `my_ssh_key.pem.pub` - **Public key** (uploaded to AWS)

### Setting Correct Permissions (Linux/Mac only):

```bash
chmod 400 my_ssh_key.pem
```

## Configuration Files

### main.tf

```terraform
provider "aws" {
    region = "us-east-1" 
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "main_vpc"
  }
  
}

resource "aws_subnet" "main_subnet" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "public_subnet"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "main_igw"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public_rt"
    }
}

resource "aws_route_table_association" "public_rt_assoc" {
    subnet_id      = aws_subnet.main_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

variable "myip" {
}

resource "aws_security_group" "main_sg" {
    name        = "main_sg"
    description = "Main security group"
    vpc_id      = aws_vpc.main.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.myip]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "main_sg"
    }
}

resource "aws_key_pair" "ssh_key" {
    key_name   = "my_ssh_key"
    public_key = file("${path.module}/my_ssh_key.pem.pub")
}

resource "aws_instance" "web_server" {
    ami           = "ami-07ff62358b87c7116" # Amazon Linux 2 AMI (HVM), SSD Volume Type
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.main_subnet.id
    vpc_security_group_ids = [aws_security_group.main_sg.id]
    associate_public_ip_address = true
    key_name      = aws_key_pair.ssh_key.key_name

    tags = {
        Name = "web_server"
    }
}

output "instance_public_ip" {
    value = aws_instance.web_server.public_ip
}
```

## Deployment Steps

### 1. Get Your Public IP Address

```bash
# Windows PowerShell
(Invoke-WebRequest -Uri "https://api.ipify.org").Content

# Linux/Mac
curl https://api.ipify.org
```

### 2. Initialize Terraform

```bash
terraform init
```

**What this does:** Downloads the AWS provider plugin and initializes the working directory.

### 3. Review the Execution Plan

```bash
terraform plan
```

When prompted, enter your public IP address in CIDR notation (e.g., `203.0.113.45/32`).

**What this does:** Shows what resources will be created without actually creating them.

### 4. Apply the Configuration

```bash
terraform apply
```

Or use auto-approve to skip confirmation:

```bash
terraform apply -auto-approve
```

Enter your public IP when prompted for the `myip` variable.

**What this does:** Creates all the AWS resources defined in the configuration.

### 5. Get the Instance Public IP

After successful deployment, Terraform will output the public IP address of your EC2 instance.

## Connecting to Your EC2 Instance

### Using SSH:

```bash
ssh -i my_ssh_key.pem ec2-user@<INSTANCE_PUBLIC_IP>
```

Replace `<INSTANCE_PUBLIC_IP>` with the IP address from the Terraform output.

**Note:** If you get a connection timeout, verify:
- Your current public IP matches the one you provided to Terraform
- The security group ingress rule allows your IP
- The instance is in a running state

## Resource Breakdown

### VPC (Virtual Private Cloud)
Creates an isolated network environment in AWS with the CIDR block `10.0.0.0/16`, allowing up to 65,536 IP addresses.

### Subnet
A public subnet within the VPC (`10.0.1.0/24`) that can communicate with the internet via the Internet Gateway.

### Internet Gateway
Allows resources in the VPC to access the internet and be accessed from the internet.

### Route Table
Defines routing rules. The route `0.0.0.0/0` → Internet Gateway sends all internet-bound traffic through the IGW.

### Security Group
Acts as a virtual firewall:
- **Ingress Rule**: Allows SSH (port 22) only from your IP address
- **Egress Rule**: Allows all outbound traffic

### Key Pair
- **Public key** is uploaded to AWS and injected into the EC2 instance
- **Private key** remains on your local machine for authentication

### EC2 Instance
A t2.micro instance running Amazon Linux 2, configured with:
- Public IP address for internet access
- SSH key for secure authentication
- Security group for firewall rules

## Cleanup

To destroy all created resources:

```bash
terraform destroy
```

**Warning:** This will permanently delete all resources created by this configuration.

## Security Best Practices

1. **Never commit** `my_ssh_key.pem` to version control
2. **Add to .gitignore**:
   ```
   *.pem
   *.tfstate
   *.tfstate.backup
   .terraform/
   ```
3. **Restrict SSH access** to only your IP address
4. **Use strong key encryption** (minimum 2048-bit RSA)
5. **Rotate keys regularly** and update AWS accordingly

## Troubleshooting

### Connection Timeout
- Verify your current public IP matches the security group rule
- Check that the instance is running
- Ensure the route table is properly associated

### Permission Denied (SSH)
- Verify key file permissions: `chmod 400 my_ssh_key.pem` (Linux/Mac)
- Ensure you're using the correct username (`ec2-user` for Amazon Linux)

### Key File Not Found
- Ensure `my_ssh_key.pem.pub` exists in the same directory as `main.tf`
- Run the `ssh-keygen` command before `terraform apply`

## Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `myip` | Your public IP in CIDR notation | `203.0.113.45/32` |

## Outputs

| Output | Description |
|--------|-------------|
| `instance_public_ip` | Public IP address of the EC2 instance |

## License

This project is open source and available under the MIT License.
