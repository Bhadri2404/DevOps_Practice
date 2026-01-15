# Essential Terraform Commands - Quick Reference

The most commonly used Terraform commands for day-to-day infrastructure management.

---

## Core Workflow Commands

### `terraform init`
Initialize your Terraform working directory (run this first! ).

```bash
# Basic initialization
terraform init

# Upgrade provider versions
terraform init -upgrade
```

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

---

## State Management (Most Used)

### `terraform state list`
List all resources in your state.

```bash
terraform state list
```

**Output:**
```
aws_instance.web
aws_s3_bucket.data
aws_vpc.main
```

### `terraform state show`
Show details of a specific resource.

```bash
terraform state show aws_instance. web
```

### `terraform state rm`
Remove a resource from state (doesn't destroy it).

```bash
terraform state rm aws_instance.web
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

### `terraform validate`
Check if your configuration is valid.

```bash
terraform validate
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

### `terraform show`
Show current state or saved plan.

```bash
# Show current state
terraform show

# Show saved plan
terraform show tfplan
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

---

## Import Existing Resources

### `terraform import`
Bring existing infrastructure under Terraform management.

```bash
# Import AWS EC2 instance
terraform import aws_instance.web i-1234567890abcdef0

# Import S3 bucket
terraform import aws_s3_bucket.mybucket bucket-name
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
terraform state pull > backup. tfstate

# Check what's managed
terraform state list

# Clean formatting before commit
terraform fmt -recursive && terraform validate
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
