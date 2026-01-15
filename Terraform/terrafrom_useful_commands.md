# Terraform Commands Reference Guide

A comprehensive guide to essential Terraform commands for infrastructure management.

## Table of Contents
- [Initialization](#initialization)
- [Planning and Applying](#planning-and-applying)
- [State Management](#state-management)
- [Workspace Management](#workspace-management)
- [Import and Output](#import-and-output)
- [Validation and Formatting](#validation-and-formatting)
- [Destroy and Cleanup](#destroy-and-cleanup)
- [Advanced Commands](#advanced-commands)

---

## Initialization

### `terraform init`
Initializes a Terraform working directory.  Downloads providers and modules. 

```bash
# Basic initialization
terraform init

# Reinitialize with plugin upgrade
terraform init -upgrade

# Initialize without backend configuration
terraform init -backend=false

# Initialize with specific backend config
terraform init -backend-config="bucket=my-bucket"
```

**What it does:**
- Downloads provider plugins
- Initializes backend configuration
- Downloads modules from registry or source

---

## Planning and Applying

### `terraform plan`
Creates an execution plan showing what Terraform will do. 

```bash
# Basic plan
terraform plan

# Save plan to a file
terraform plan -out=tfplan

# Plan with variable file
terraform plan -var-file="prod.tfvars"

# Plan with inline variables
terraform plan -var="instance_type=t2.micro"

# Plan to destroy
terraform plan -destroy
```

**What it does:**
- Shows resources to be created, modified, or destroyed
- Validates configuration syntax
- Checks current state vs desired state

### `terraform apply`
Applies the changes required to reach the desired state.

```bash
# Apply with confirmation prompt
terraform apply

# Auto-approve (skip confirmation)
terraform apply -auto-approve

# Apply a saved plan
terraform apply tfplan

# Apply with variables
terraform apply -var-file="prod.tfvars"

# Apply targeting specific resource
terraform apply -target=aws_instance.web
```

**What it does:**
- Creates, updates, or deletes infrastructure
- Updates state file
- Shows output values

---

## State Management

### `terraform state list`
Lists all resources in the Terraform state.

```bash
# List all resources
terraform state list

# Filter resources by pattern
terraform state list | grep aws_instance
```

**Output example:**
```
aws_instance.web
aws_security_group.allow_http
aws_vpc.main
```

### `terraform state show`
Shows detailed information about a specific resource.

```bash
# Show details of a specific resource
terraform state show aws_instance.web

# Show resource in JSON format
terraform state show -json aws_instance.web
```

**Output example:**
```
# aws_instance.web:
resource "aws_instance" "web" {
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    tags          = {
        "Name" = "WebServer"
    }
}
```

### `terraform state mv`
Moves items in the state file (rename resources).

```bash
# Rename a resource
terraform state mv aws_instance.old aws_instance.new

# Move resource to a module
terraform state mv aws_instance. web module.webserver. aws_instance.web

# Move resource to different state file
terraform state mv -state-out=other.tfstate aws_instance.web aws_instance.web
```

### `terraform state rm`
Removes items from the Terraform state. 

```bash
# Remove a resource from state (doesn't destroy it)
terraform state rm aws_instance.web

# Remove multiple resources
terraform state rm aws_instance.web aws_instance.api
```

**Use case:** When you want Terraform to stop managing a resource without destroying it.

### `terraform state pull`
Retrieves the current state and outputs to stdout.

```bash
# Pull current state
terraform state pull

# Pull and save to file
terraform state pull > backup. tfstate
```

### `terraform state push`
Uploads a local state file to remote backend.

```bash
# Push state file
terraform state push backup.tfstate
```

**⚠️ Warning:** Use with caution - can overwrite remote state.

### `terraform state replace-provider`
Replaces provider in state (useful when migrating providers).

```bash
# Replace provider
terraform state replace-provider registry.terraform.io/hashicorp/aws registry.terraform.io/hashicorp/aws
```

---

## Workspace Management

### `terraform workspace list`
Lists all workspaces.

```bash
# List workspaces
terraform workspace list
```

### `terraform workspace new`
Creates a new workspace.

```bash
# Create new workspace
terraform workspace new dev

# Create and switch to workspace
terraform workspace new staging
```

### `terraform workspace select`
Switches to a different workspace.

```bash
# Switch workspace
terraform workspace select prod
```

### `terraform workspace show`
Shows the current workspace name.

```bash
# Show current workspace
terraform workspace show
```

### `terraform workspace delete`
Deletes a workspace. 

```bash
# Delete workspace
terraform workspace delete dev
```

---

## Import and Output

### `terraform import`
Imports existing infrastructure into Terraform state.

```bash
# Import AWS EC2 instance
terraform import aws_instance.web i-1234567890abcdef0

# Import with module
terraform import module.webserver. aws_instance.web i-1234567890abcdef0

# Import S3 bucket
terraform import aws_s3_bucket.mybucket my-bucket-name
```

**What it does:**
- Adds existing infrastructure to state file
- Does NOT generate configuration code
- Requires resource address and ID

### `terraform output`
Reads and displays output values from state.

```bash
# Show all outputs
terraform output

# Show specific output
terraform output instance_ip

# Output in JSON format
terraform output -json

# Output raw value (no quotes)
terraform output -raw instance_ip
```

---

## Validation and Formatting

### `terraform validate`
Validates the Terraform configuration files.

```bash
# Validate configuration
terraform validate

# Validate with JSON output
terraform validate -json
```

**What it checks:**
- Syntax errors
- Invalid resource references
- Required argument presence

### `terraform fmt`
Formats Terraform configuration files to canonical style.

```bash
# Format all files in current directory
terraform fmt

# Format recursively
terraform fmt -recursive

# Check if files are formatted (returns exit code)
terraform fmt -check

# Show diff of formatting changes
terraform fmt -diff
```

### `terraform console`
Opens an interactive console for evaluating expressions.

```bash
# Open console
terraform console

# Example expressions in console: 
# > aws_instance.web. public_ip
# > var.region
# > length(aws_instance.web)
```

---

## Destroy and Cleanup

### `terraform destroy`
Destroys all managed infrastructure.

```bash
# Destroy with confirmation
terraform destroy

# Auto-approve destroy
terraform destroy -auto-approve

# Destroy specific resource
terraform destroy -target=aws_instance.web

# Destroy with variable file
terraform destroy -var-file="prod.tfvars"
```

**⚠️ Warning:** This will permanently delete resources!

---

## Advanced Commands

### `terraform graph`
Generates a visual dependency graph.

```bash
# Generate DOT format graph
terraform graph

# Generate and convert to image (requires graphviz)
terraform graph | dot -Tpng > graph.png

# Graph for plan
terraform graph -type=plan
```

### `terraform taint`
**Deprecated:** Use `terraform apply -replace` instead.

```bash
# Mark resource for recreation (old method)
terraform taint aws_instance.web

# New method (Terraform 0.15. 2+)
terraform apply -replace="aws_instance.web"
```

### `terraform untaint`
**Deprecated:** Manually remove from state instead.

```bash
# Remove taint (old method)
terraform untaint aws_instance.web
```

### `terraform refresh`
Updates state file with real-world infrastructure.

```bash
# Refresh state
terraform refresh

# Refresh with variables
terraform refresh -var-file="prod.tfvars"
```

**Note:** `terraform plan` and `terraform apply` automatically refresh state.

### `terraform show`
Shows current state or saved plan in human-readable format.

```bash
# Show current state
terraform show

# Show saved plan
terraform show tfplan

# Show in JSON format
terraform show -json

# Show state file
terraform show terraform.tfstate
```

### `terraform providers`
Shows provider requirements and versions.

```bash
# List providers
terraform providers

# Show provider dependency tree
terraform providers schema

# Mirror providers to local directory
terraform providers mirror ./terraform-providers
```

### `terraform version`
Shows Terraform version.

```bash
# Show version
terraform version

# Show version in JSON
terraform version -json
```

---

## Useful Command Combinations

### Backup State Before Changes
```bash
# Create state backup
terraform state pull > backup-$(date +%Y%m%d-%H%M%S).tfstate
```

### Targeted Apply for Specific Module
```bash
# Apply changes only to a specific module
terraform apply -target=module.networking
```

### Format and Validate Before Commit
```bash
# Format and validate
terraform fmt -recursive && terraform validate
```

### Plan with Detailed Logging
```bash
# Enable detailed logs
TF_LOG=DEBUG terraform plan
```

### Export Outputs to Environment Variables
```bash
# Export output as environment variable
export DB_HOST=$(terraform output -raw database_host)
```

### Check State Without Making Changes
```bash
# Refresh and show state
terraform refresh && terraform show
```

---

## Environment Variables

Useful environment variables for Terraform:

```bash
# Enable debug logging
export TF_LOG=DEBUG
export TF_LOG_PATH=./terraform.log

# Set input to false (no prompts)
export TF_INPUT=false

# Set variable via environment
export TF_VAR_region=us-west-2
export TF_VAR_instance_type=t2.micro

# Backend configuration
export TF_CLI_CONFIG_FILE=~/.terraformrc
```

---

## Best Practices

1. **Always run `terraform plan`** before `terraform apply`
2. **Use version control** for your Terraform files
3. **Use remote state** for team collaboration
4. **Use workspaces** for different environments
5. **Backup state files** before
