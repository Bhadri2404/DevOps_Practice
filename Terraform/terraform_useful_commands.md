# Essential Terraform Commands - Quick Reference

The most commonly used Terraform commands for day-to-day infrastructure management.

---

## Core Workflow Commands

### `terraform init`
Initialize your Terraform working directory (run this first!).

```bash
# Basic initialization
terraform init

# Upgrade provider versions
terraform init -upgrade
```

**Output Example:**
```
Initializing the backend... 

Initializing provider plugins... 
- Finding hashicorp/aws versions matching "~> 5.0"... 
- Installing hashicorp/aws v5.31.0...
- Installed hashicorp/aws v5.31.0 (signed by HashiCorp)

Terraform has been successfully initialized! 

You may now begin working with Terraform.  Try running "terraform plan" to see
any changes that are required for your infrastructure. 
```

---

### `terraform plan`
Preview changes before applying them.

```bash
# See what will change
terraform plan

# Save plan to file
terraform plan -out=tfplan

# Plan with variables
terraform plan -var-file="prod.tfvars"
```

**Output Example:**
```
Terraform used the selected providers to generate the following execution plan. 
Resource actions are indicated with the following symbols:
  + create
  ~ update in-place
  - destroy

Terraform will perform the following actions:

  # aws_instance.web will be created
  + resource "aws_instance" "web" {
      + ami                          = "ami-0c55b159cbfafe1f0"
      + instance_type                = "t2.micro"
      + id                           = (known after apply)
      + public_ip                    = (known after apply)
      + vpc_security_group_ids       = (known after apply)
      
      + tags = {
          + "Name" = "WebServer"
        }
    }

  # aws_security_group.allow_http will be updated in-place
  ~ resource "aws_security_group" "allow_http" {
        id          = "sg-0123456789"
      ~ description = "Allow HTTP" -> "Allow HTTP and HTTPS"
        name        = "allow_http"
    }

Plan: 1 to add, 1 to change, 0 to destroy.

Changes to Outputs:
  + instance_ip = (known after apply)
```

---

### `terraform apply`
Apply changes to your infrastructure. 

```bash
# Apply with confirmation
terraform apply

# Apply without confirmation
terraform apply -auto-approve

# Apply saved plan
terraform apply tfplan
```

**Output Example:**
```
Terraform used the selected providers to generate the following execution plan. 
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions: 

  # aws_instance.web will be created
  + resource "aws_instance" "web" {
      + ami                          = "ami-0c55b159cbfafe1f0"
      + instance_type                = "t2.micro"
      + id                           = (known after apply)
      + public_ip                    = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy. 

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve. 

  Enter a value: yes

aws_instance.web: Creating... 
aws_instance.web: Still creating... [10s elapsed]
aws_instance.web: Still creating... [20s elapsed]
aws_instance. web: Creation complete after 25s [id=i-0a1b2c3d4e5f6g7h8]

Apply complete! Resources:  1 added, 0 changed, 0 destroyed. 

Outputs: 

instance_ip = "54.123.45.67"
```

---

### `terraform destroy`
Destroy all managed infrastructure.

```bash
# Destroy with confirmation
terraform destroy

# Destroy without confirmation
terraform destroy -auto-approve

# Destroy specific resource
terraform destroy -target=aws_instance.web
```

**Output Example:**
```
Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_instance.web will be destroyed
  - resource "aws_instance" "web" {
      - ami                          = "ami-0c55b159cbfafe1f0" -> null
      - instance_type                = "t2.micro" -> null
      - id                           = "i-0a1b2c3d4e5f6g7h8" -> null
      - public_ip                    = "54.123.45.67" -> null
      - tags                         = {
          - "Name" = "WebServer"
        } -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm. 

  Enter a value: yes

aws_instance.web: Destroying...  [id=i-0a1b2c3d4e5f6g7h8]
aws_instance.web: Still destroying... [id=i-0a1b2c3d4e5f6g7h8, 10s elapsed]
aws_instance.web: Destruction complete after 15s

Destroy complete! Resources: 1 destroyed. 
```

---

## State Management (Most Used)

### `terraform state list`
List all resources in your state.

```bash
terraform state list
```

**Output Example:**
```
aws_instance.web
aws_instance.api
aws_s3_bucket.data
aws_security_group.allow_http
aws_vpc.main
aws_subnet.public
module.database. aws_db_instance. main
module.database.aws_db_subnet_group.main
```

---

### `terraform state show`
Show details of a specific resource. 

```bash
terraform state show aws_instance.web
```

**Output Example:**
```
# aws_instance.web:
resource "aws_instance" "web" {
    ami                                  = "ami-0c55b159cbfafe1f0"
    arn                                  = "arn:aws:ec2:us-east-1:123456789012:instance/i-0a1b2c3d4e5f6g7h8"
    associate_public_ip_address          = true
    availability_zone                    = "us-east-1a"
    cpu_core_count                       = 1
    cpu_threads_per_core                 = 1
    disable_api_termination              = false
    id                                   = "i-0a1b2c3d4e5f6g7h8"
    instance_state                       = "running"
    instance_type                        = "t2.micro"
    ipv6_address_count                   = 0
    ipv6_addresses                       = []
    monitoring                           = false
    primary_network_interface_id         = "eni-0123456789abcdef0"
    private_dns_name                     = "ip-10-0-1-50.ec2.internal"
    private_ip                           = "10.0.1.50"
    public_dns                           = "ec2-54-123-45-67.compute-1.amazonaws.com"
    public_ip                            = "54.123.45.67"
    secondary_private_ips                = []
    security_groups                      = []
    source_dest_check                    = true
    subnet_id                            = "subnet-0abc123def456"
    tags                                 = {
        "Environment" = "production"
        "Name"        = "WebServer"
    }
    tags_all                             = {
        "Environment" = "production"
        "Name"        = "WebServer"
    }
    tenancy                              = "default"
    vpc_security_group_ids               = [
        "sg-0123456789abcdef0",
    ]
}
```

---

### `terraform state rm`
Remove a resource from state (doesn't destroy it).

```bash
terraform state rm aws_instance.web
```

**Output Example:**
```
Removed aws_instance.web
Successfully removed 1 resource instance(s).
```

---

## Code Quality Commands

### `terraform fmt`
Auto-format your Terraform files. 

```bash
# Format current directory
terraform fmt

# Format all subdirectories
terraform fmt -recursive
```

**Output Example:**
```
main.tf
variables.tf
outputs.tf
modules/networking/main.tf
```

**If already formatted:**
```
(no output - files are already formatted)
```

---

### `terraform validate`
Check if your configuration is valid. 

```bash
terraform validate
```

**Output Example (Success):**
```
Success! The configuration is valid.
```

**Output Example (Error):**
```
╷
│ Error:  Missing required argument
│ 
│   on main.tf line 15, in resource "aws_instance" "web": 
│   15: resource "aws_instance" "web" {
│ 
│ The argument "ami" is required, but no definition was found. 
╵

╷
│ Error: Reference to undeclared resource
│ 
│   on main.tf line 25, in output "instance_ip":
│   25:   value = aws_instance.app.public_ip
│ 
│ A managed resource "aws_instance" "app" has not been declared in the root
│ module. 
╵
```

---

## Output & Information

### `terraform output`
Display output values from your state.

```bash
# Show all outputs
terraform output

# Show specific output
terraform output instance_ip

# Raw output (no quotes)
terraform output -raw instance_ip
```

**Output Example (all outputs):**
```
instance_ip = "54.123.45.67"
instance_id = "i-0a1b2c3d4e5f6g7h8"
database_endpoint = "mydb.c9akciq32.us-east-1.rds.amazonaws.com:3306"
s3_bucket_name = "my-app-data-bucket-20260115"
vpc_id = "vpc-0a1b2c3d4e5f6g7h8"
```

**Output Example (specific output):**
```
"54.123.45.67"
```

**Output Example (raw):**
```
54.123.45.67
```

---

### `terraform show`
Show current state or saved plan.

```bash
# Show current state
terraform show

# Show saved plan
terraform show tfplan
```

**Output Example:**
```
# aws_instance.web:
resource "aws_instance" "web" {
    ami                          = "ami-0c55b159cbfafe1f0"
    arn                          = "arn: aws:ec2:us-east-1:123456789012:instance/i-0a1b2c3d4e5f6g7h8"
    availability_zone            = "us-east-1a"
    id                           = "i-0a1b2c3d4e5f6g7h8"
    instance_type                = "t2.micro"
    public_ip                    = "54.123.45.67"
    tags                         = {
        "Name" = "WebServer"
    }
}

# aws_security_group.allow_http:
resource "aws_security_group" "allow_http" {
    arn         = "arn:aws:ec2:us-east-1:123456789012:security-group/sg-0123456789"
    description = "Allow HTTP and HTTPS"
    id          = "sg-0123456789abcdef0"
    name        = "allow_http"
    vpc_id      = "vpc-0a1b2c3d4e5f6g7h8"
    
    ingress {
        cidr_blocks = [
            "0.0.0.0/0",
        ]
        from_port   = 80
        protocol    = "tcp"
        to_port     = 80
    }
}

Outputs: 

instance_ip = "54.123.45.67"
```

---

## Workspace Commands (for multiple environments)

```bash
# List workspaces
terraform workspace list

# Create new workspace
terraform workspace new dev

# Switch workspace
terraform workspace select prod

# Show current workspace
terraform workspace show
```

**Output Example (list):**
```
  default
* dev
  staging
  prod
```
*(asterisk shows current workspace)*

**Output Example (new):**
```
Created and switched to workspace "dev"! 

You're now on a new, empty workspace.  Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration. 
```

**Output Example (select):**
```
Switched to workspace "prod". 
```

**Output Example (show):**
```
prod
```

---

## Import Existing Resources

### `terraform import`
Bring existing infrastructure under Terraform management.

```bash
# Import AWS EC2 instance
terraform import aws_instance.web i-0a1b2c3d4e5f6g7h8

# Import S3 bucket
terraform import aws_s3_bucket.mybucket my-bucket-name
```

**Output Example:**
```
aws_instance.web: Importing from ID "i-0a1b2c3d4e5f6g7h8"... 
aws_instance.web: Import prepared! 
  Prepared aws_instance for import
aws_instance.web: Refreshing state...  [id=i-0a1b2c3d4e5f6g7h8]

Import successful! 

The resources that were imported are shown above.  These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

---

## Common Command Combinations

```bash
# Standard workflow
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply

# Before making changes - backup state
terraform state pull > backup.tfstate

# Check what's managed
terraform state list

# Clean formatting before commit
terraform fmt -recursive && terraform validate
```

**Output Example (workflow):**
```
$ terraform init
Initializing the backend... 
Terraform has been successfully initialized!

$ terraform fmt
main.tf

$ terraform validate
Success! The configuration is valid.

$ terraform plan
Plan: 3 to add, 0 to change, 0 to destroy. 

$ terraform apply
... 
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

---

## Quick Tips

| Command | What It Does |
|---------|-------------|
| `terraform init` | Initialize directory (first command to run) |
| `terraform plan` | Preview changes (always run before apply!) |
| `terraform apply` | Apply changes to infrastructure |
| `terraform destroy` | Delete all infrastructure |
| `terraform state list` | See all managed resources |
| `terraform state show <resource>` | See resource details |
| `terraform fmt` | Format code |
| `terraform validate` | Check syntax |
| `terraform output` | Show output values |

---

## Daily Workflow

```bash
# 1. Pull latest code
git pull

# 2. Initialize (if first time or providers changed)
terraform init

# 3. Format and validate
terraform fmt -recursive
terraform validate

# 4. Plan changes
terraform plan -out=tfplan

# 5. Review plan, then apply
terraform apply tfplan

# 6. Check outputs
terraform output
```

---

**Pro Tip:** Always run `terraform plan` before `terraform apply` to avoid surprises!  🚀
