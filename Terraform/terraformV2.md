Day - 2

Terraform scripts start with a provider block and resources to create real AWS infrastructure. This transcript covers the complete workflow from writing your first `main.tf` to deploying and cleaning up.

## Provider Block
**What**: The `provider` block tells Terraform which cloud platform (AWS, Azure, GCP) to connect to and where (region). It's mandatory—first block in any `.tf` file.

**Why**: Acts as a plugin to communicate with cloud APIs. Without it, Terraform doesn't know where to create resources.

**AWS Example**:
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"  # Mumbai region
}
```

**When to use**: Every Terraform project. Change region for multi-region setups.

**Production Scenario**: Define `ap-south-1` for Mercedes-Benz India workloads; use aliases for multi-account setups.

**Common Mistake**: Wrong region code → Resources create in unexpected location.  
**Debug Tip**: `terraform plan` shows target region.  
**Best Practice**: Use variables: `region = var.aws_region`.

## Resource Block
**What**: `resource "type" "name" {}` creates real infrastructure (EC2, S3, VPC). `"aws_instance"` is the exact type name from Terraform Registry.

**Why**: Maps code to actual AWS objects. Block name (e.g., `"my_first_instance"`) lets you reference it elsewhere.

**AWS Example** (minimal EC2):
```hcl
resource "aws_instance" "my_first_instance" {
  ami           = "ami-0abcdef1234567890"  # Amazon Linux 2023 from AWS Console
  instance_type = "t3.micro"              # Free-tier eligible
  
  tags = {
    Name = "MyFirstEC2"
  }
}
```

**When to use**: Core of IaC—specify only required args (AMI, instance_type); defaults handle rest.

**Production Scenario**: Deploy Jenkins agents in t3.micro across regions.

**Common Mistake**: Wrong AMI ID → "InvalidAMIID.NotFound". Copy from AWS Console > EC2 > Launch Instance.  
**Debug Tip**: `terraform console` > `aws_instance.my_first_instance.ami`.  
**Best Practice**: Use `data "aws_ami"` to fetch latest AMIs dynamically.

## Terraform Workflow (iPad Mnemonic)
**Order**: **I**nit → **P**lan → **A**pply → (**D**estroy).

| Command | Purpose | Creates Files? | Cloud Impact? |
|---------|---------|----------------|---------------|
| `terraform init` | Downloads providers, initializes backend | `.terraform/`, `terraform.lock.hcl` | None |
| `terraform plan` | Previews changes (create/update/destroy) | None (use `-out=plan.tfplan` to save) | None |
| `terraform apply` | Executes plan, updates state | `terraform.tfstate` + backup | **Yes** |
| `terraform destroy` | Deletes ALL tracked resources | Clears state | **Yes** |

**Production Scenario**: Jenkins pipeline: init → plan (PR approval) → apply (merge).

## Terraform Init
**What**: Prepares directory—downloads AWS provider plugin, sets up state backend, validates config.

**Why**: One-time per project (rerun if providers/backend change).

**Example**: `cd my-terraform && terraform init` → Downloads to `.terraform/providers/`.

**When to use**: New project, provider version bump, backend change.

**Common Mistake**: Running in wrong directory → "No .tf files found".  
**Debug Tip**: `ls -la` shows hidden `.terraform/` folder after success.  
**Best Practice**: Add to Dockerfile or GitHub Actions first step.

## Terraform Plan
**What**: Compares desired state (`.tf`) vs actual state (`.tfstate`). Shows + (create), ~ (update), - (destroy).

**Why**: Safe preview—catches drift before costly applies.

**AWS Example Output**:
```
# terraform plan
Terraform will perform the following actions:
  # aws_instance.my_first_instance will be created
  + resource "aws_instance" "my_first_instance" {
      + ami           = "ami-0abcdef1234567890"
      + instance_type = "t3.micro"
      + subnet_id     = "(auto-picked default)"
    }
```

**Production Scenario**: Daily drift detection in prod—`plan` should show "No changes".

**Common Mistake**: Skipping plan → Surprise deletions.  
**Best Practice**: `terraform plan -out=tfplan && terraform apply tfplan`.

## Terraform Apply
**What**: Executes plan via provider APIs. Creates resources, updates `terraform.tfstate`.

**Why**: Interactive by default (type "yes"). Use `--auto-approve` in CI/CD.

**Example**: `terraform apply` → EC2 launches (ID: `i-1234567890abcdef0`), state captures public IP, ARN, subnet.

**Production Scenario**: Promote code from dev → staging → prod environments.

**Common Mistake**: Hitting Enter without "yes" → Hangs forever.  
**Debug Tip**: Ctrl+C safely interrupts.  
**Best Practice**: `--auto-approve` only in pipelines with approval gates.

## Terraform Destroy
**What**: Deletes ALL state-tracked resources. Interactive "yes?" prompt.

**Why**: Cleanup test/prod environments, stop billing.

**Example**: `terraform destroy` → EC2 terminates, state clears.

**Production Scenario**: Ephemeral EKS clusters for CI/CD testing.

**Common Mistake**: Forgetting → Orphaned resources rack up costs.  
**Best Practice**: Schedule via cron + `--auto-approve` for dev.

## Terraform State File (Recap)
Auto-created on first `apply`. Stores resource mappings (ID, attributes). **Never edit manually**—use `terraform state` commands.

**Production Best Practice**: S3 backend + DynamoDB locking:
```hcl
terraform {
  backend "s3" {
    bucket = "my-tf-state-bucket"
    key    = "prod/terraform.tfstate"
    region = "ap-south-1"
  }
}
```

**Common Mistake**: Local state in Git → Team overwrites.  
**Interview Tip**: "Always remote state with locking for collaboration."

## Behind the Scenes: RPC
**What**: Remote Procedure Call—internal comms between Terraform CLI, core, and provider plugins.

**Why**: Enables provider instructions (e.g., AWS API calls).

**When mentioned**: During `apply`/`destroy`—not user-configurable.

**Best Practice**: Ignore for interviews; focus on workflow commands.


Day - 3

Terraform state file and destroy operations are critical for safe infrastructure management. This transcript covers state tracking, selective destroys, lifecycle protection, and code quality commands with practical AWS examples.

## Terraform State File
**What**: `terraform.tfstate` is the **source of truth**—maps `.tf` config to real AWS resources (IDs, ARNs, IPs, AZs). Created/updated on `apply`.

**Why**: Detects create/update/destroy needs by comparing desired vs actual state. **Never edit manually**—risks corruption.

**AWS Example**: Deploy EC2 → State captures:
```json
{
  "resources": [{
    "mode": "managed",
    "type": "aws_instance",
    "name": "my_first_instance",
    "attributes": {
      "id": "i-1234567890abcdef0",
      "ami": "ami-0abcdef1234567890",
      "instance_state": "running"
    }
  }]
}
```

**When to use**: Always local for learning; **S3+DynamoDB remote** for teams.
**Production Scenario**: Mercedes-Benz CI/CD stores EKS state in `s3://tf-state-prod/terraform.tfstate`.

**Common Mistake**: Committing local state to Git → Team overwrites.  
**Best Practice**: `terraform { backend "s3" { bucket = "tf-state" key = "prod/state" } }`  
**Debug**: `cat terraform.tfstate | jq .resources`

## Verify State Resources
**Command**: `terraform state list`
**What**: Lists all tracked resources with exact addresses.
**Example**: `aws_instance.my_first_instance`, `aws_instance.my_second_instance`

**Production Scenario**: Pre-destroy inventory check in Jenkins pipeline.

## Terraform Plan & Apply Workflow
**Plan**: Previews changes (`terraform plan`). **Highly recommended** before apply.
**Apply**: Interactive (`terraform apply`) → Type "yes". Non-interactive: `terraform apply --auto-approve`.

**Example**:
```
$ terraform plan
+ create aws_instance.my_first_instance
  ami:           "ami-0abcdef1234567890"
  instance_type: "t3.micro"
  tags.Name:     "my-first-instance"

$ terraform apply --auto-approve  # Creates + updates state
```

**Common Mistake**: Skipping plan → Surprise dependencies (security groups, subnets auto-added).

## Terraform Destroy (Full)
**What**: Deletes **ALL** state-tracked resources. Uses state to identify targets.
**Example**: `terraform destroy --auto-approve` → Both EC2s terminate, state clears.

**Production Scenario**: Ephemeral dev EKS clusters post-CI testing.

**Common Mistake**: `--auto-approve` in prod → Disaster.  
**Best Practice**: Approval gates in GitHub Actions.

## Lifecycle: prevent_destroy
**What**: `lifecycle { prevent_destroy = true }` blocks `destroy` operations.

**AWS Example**:
```hcl
resource "aws_instance" "protected_db_server" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
  
  lifecycle {
    prevent_destroy = true  # Boolean: blocks destroy
  }
  
  tags = { Name = "prod-db-server" }
}
```

**Result**: `terraform destroy` → **Error**: "Instance cannot be destroyed. Lifecycle prevent_destroy is enabled."

**When to use**: Prod databases, compliance-mandated resources.
**Production Scenario**: RDS primary instance—blocks accidental deletes during maintenance.

**Interview Answer**: "Like EC2 termination protection but at IaC level."

## Targeted Destroy (-target)
**What**: Destroy **specific** resources: `terraform destroy -target=resource.address`

**AWS Example** (2 EC2s deployed):
```bash
$ terraform state list
aws_instance.my_first_instance
aws_instance.my_second_instance

$ terraform destroy -target=aws_instance.my_first_instance
# Only first instance deletes!
```

**Production Scenario**: Remove faulty ALB from stack without touching RDS.

**⚠️ Warning**: **Use cautiously**—breaks dependencies. Not for daily use.
**Common Mistake**: Wrong address → No error, wrong resource targeted.  
**Debug**: Always `terraform state list` first.

## Terraform Fmt
**What**: Auto-formats `.tf` files (indentation, `=` alignment).

**Commands**:
- `terraform fmt` → Apply formatting
- `terraform fmt -recursive` → All subfolders
- `terraform fmt -diff` → Preview changes

**Before → After**:
```hcl
# Messy
ami=ami-0abcdef1234567890
  instance_type="t3.micro"

# terraform fmt →
resource "aws_instance" "example" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
}
```

**Production**: Git pre-commit hook: `terraform fmt -check=false`.

## Terraform Validate
**What**: **Local syntax/config check**—no cloud API calls. Catches typos before `plan`.

**Example**:
```hcl
# Bad
resource "aws_instance" "bad" {
  ami  = "ami-123"
  instanc e_type = "t3.micro"  # Space!
}
```
`terraform validate` → **Error**: "Invalid block definition on line 7"

**Best Practice**: **Always** `fmt → validate → plan → apply` workflow.

**Production Scenario**: GitHub Actions PR gate—fails bad HCL instantly.

## IDE Recommendation
**VS Code + HashiCorp Terraform extension**: Hover shows resource types, required/optional args, validation.

**Interview Prep Summary**:
1. **State**: Source of truth, never edit manually, use S3 backend
2. **Destroy protection**: `prevent_destroy = true`
3. **Targeted destroy**: `-target=` (rare, dangerous)
4. **Workflow**: `fmt → validate → plan → apply`
5. **Mnemonic**: Plan before Apply (like PR before merge)


Day - 4

**Terraform Meta-Arguments** enable dynamic resource creation and control execution order across AWS/Azure/GCP. This transcript covers **count**, **for_each**, **depends_on**, and **provider** with hands-on AWS examples for production scenarios.

## Meta-Arguments Overview
**What**: Special arguments usable in `resource`, `module`, `data` blocks. 5 total: `count`, `for_each`, `depends_on`, `lifecycle` (3 options), `provider`.

**Why**: Avoid repetitive code, control dependencies, multi-region deployments.

## 1. Count Meta-Argument
**What**: Creates **identical copies** of a resource. `count = 3` → 3 identical EC2s.

**Syntax**: `count = N` | Reference: `resource.name[count.index]`

**AWS Example**:
```hcl
provider "aws" {
  region = "ap-south-1"  # Mumbai
}

resource "aws_instance" "my_first_instance" {
  count         = 3
  ami           = "ami-0abcdef1234567890"  # Region-specific
  instance_type = "t3.micro"
  
  tags = {
    Name = "my-instance-${count.index}"  # my-instance-0,1,2
  }
}
```

**Result**: `terraform apply --auto-approve` → Creates `my-instance-0`, `my-instance-1`, `my-instance-2`.

**When to use**: Identical resources (web servers, DB replicas).
**Production Scenario**: 3 Jenkins agents with identical config.

**Common Mistake**: Same name → All instances named "my-instance" (no `${count.index}`).
**Debug**: `terraform state list` shows `aws_instance.my_first_instance[0]`, ` [docs.aws.amazon](https://docs.aws.amazon.com/prescriptive-guidance/latest/terraform-aws-provider-best-practices/overview.html)`, ` [controlmonkey](https://controlmonkey.io/resource/terraform-aws-provider-guide/)`.

## 2. For_each Meta-Argument (Better than Count)
**What**: Creates resources from **map/set** with **unique configurations**. Auto-counts based on input size.

**Why**: **Different configs** per resource. Reduces code duplication.

**AWS Example**:
```hcl
resource "aws_instance" "servers" {
  for_each = toset(["dev-server", "qa-server", "prod-server"])  # Array → Set
  
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
  
  tags = {
    Name = each.key  # dev-server, qa-server, prod-server
  }
}
```

**Result**: 3 unique instances: `dev-server`, `qa-server`, `prod-server`.

**When to use**: Resources with different names/configs (env-specific servers).
**Production Scenario**: Multi-env EKS worker nodes from single block.

**Key Difference**:
| Count | For_each |
|-------|----------|
| Identical copies | Unique configs |
| `count.index` | `each.key`, `each.value` |
| Numeric array | Map/Set |
| Order matters | Order doesn't matter |

**Interview Answer**: "Use `for_each` for flexibility, `count` for identical copies."

## 3. Depends_on Meta-Argument
**What**: **Explicit dependency**—forces sequential creation. Terraform auto-detects most, but use for clarity.

**AWS Example** (EC2 → S3 sequential):
```hcl
resource "aws_instance" "my_server" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
  
  tags = { Name = "my-depends-on-instance" }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "aiops-demo-bucket-13112025"  # Globally unique
  
  depends_on = [aws_instance.my_server]  # Wait for EC2 first
}
```

**Result**: `terraform apply` → **EC2 creates first** → **S3 bucket second** (sequential).

**When to use**: Cross-resource dependencies Terraform can't auto-detect.
**Production Scenario**: Attach IAM role to running EC2 (not pending state).

**Common Mistake**: Circular dependencies → `terraform plan` fails.
**Best Practice**: Use **implicit** (reference outputs) when possible:
```hcl
resource "aws_s3_bucket" "implicit" {
  bucket = "my-bucket-${aws_instance.my_server.id}"
}
```

## 4. Provider Meta-Argument (Multi-Region)
**What**: Use **multiple provider configs** (aliases) in single `.tf` for different regions/accounts.

**AWS Multi-Region Example**:
```hcl
# Default provider (Mumbai)
provider "aws" {
  region = "ap-south-1"
}

# Alias provider (N. Virginia)
provider "aws" {
  alias  = "usa"
  region = "us-east-1"
}

# Mumbai instance (default provider)
resource "aws_instance" "mumbai_instance" {
  ami           = "ami-0abcdef1234567890"  # Mumbai AMI
  instance_type = "t3.micro"
  
  tags = { Name = "mumbai-instance" }
}

# USA instance (alias provider)
resource "aws_instance" "usa_instance" {
  provider      = aws.usa                 # Reference alias
  ami           = "ami-0fedcba0987654321"  # USA AMI (different!)
  instance_type = "t3.micro"
  
  tags = { Name = "usa-instance" }
}
```

**Result**: Mumbai EC2 in `ap-south-1`, USA EC2 in `us-east-1`.

**Common Mistake**: **Same AMI across regions** → "InvalidAMIID.NotFound".
**Debug**: Copy AMI from target region Console → EC2 → Launch Instance.
**Production Scenario**: Active-active DR setup (Mumbai + N. Virginia).

**Error Without Alias**:
```
A default provider was already given at main.tf:5. For multiple configurations, use aliases.
```

## Production Workflow
```
terraform fmt           # Clean code
terraform validate      # Syntax check
terraform plan          # Preview
terraform apply --auto-approve  # Deploy
```

## Interview Quick Hits
1. **Count**: `N` identical copies, `${count.index}`
2. **For_each**: Map/set → unique resources, `each.key`
3. **Depends_on**: Explicit sequencing `[resource.type.name]`
4. **Provider**: `alias = "name"`, `provider = aws.alias`
5. **Lifecycle**: Next video (prevent_destroy, ignore_changes, create_before_destroy)

**Mnemonic**: **C**ount/**F**or_each → **Create multiple**. **D**epends_on → **D**o one after another. **P**rovider → **P**ick region.



Day - 5

**Terraform Lifecycle Meta-Arguments** control **create/update/destroy behavior** for zero-downtime deployments and resource protection. This video completes the lifecycle block with **create_before_destroy**, **prevent_destroy**, and **ignore_changes**—all critical for production.

## Lifecycle Block Overview
**What**: `lifecycle {}` block inside resources defines special rules for resource management.

**Why**: Default Terraform behavior (destroy → create) causes downtime. Lifecycle prevents issues.

## 1. create_before_destroy
**What**: **Create NEW resource first**, then destroy OLD. Opposite of default (destroy → create).

**When**: Zero-downtime updates (AMI changes, load balancers, databases).

**AWS Example**:
```hcl
resource "aws_instance" "mumbai_instance" {
  ami           = "ami-0abcdef1234567890"  # Amazon Linux 2023
  instance_type = "t3.micro"
  
  lifecycle {
    create_before_destroy = true  # NEW first → OLD second
  }
  
  tags = {
    Name = "mumbai-instance"
  }
}
```

**Demo Flow**:
1. `terraform apply` → Creates Amazon Linux EC2
2. Change `ami` to Ubuntu → `terraform apply`
3. **Result**: Ubuntu EC2 **creates first** → Amazon Linux **destroys after**

**Console Observation**:
```
# Both running simultaneously
✅ mumbai-instance (Amazon Linux, t3.micro)
✅ mumbai-instance (Ubuntu, t3.micro) ← New

# Then old terminates
❌ mumbai-instance (Amazon Linux) ← Destroyed
✅ mumbai-instance (Ubuntu) ← Running
```

**Production Scenario**: Blue-green ELB target group updates—no traffic interruption.

**Interview Answer**: "Ensures zero-downtime during immutable updates like AMI changes."

## 2. prevent_destroy (Recap)
**What**: **Blocks `terraform destroy`** entirely. Boolean: `true`/`false`.

**AWS Example**:
```hcl
resource "aws_instance" "protected_server" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
  
  lifecycle {
    prevent_destroy = true  # Cannot destroy!
  }
}
```

**Result**: `terraform destroy` → **Error**: "Instance cannot be destroyed. Lifecycle prevent_destroy = true"

**To Destroy**: Set `prevent_destroy = false` → `terraform apply` → `terraform destroy`

**Production Scenario**: RDS primary database, compliance-mandated EKS control plane.

**Common Mistake**: Forgetting in prod → Manual console delete → **State drift**.
**Debug**: `terraform plan` shows "destroy blocked by lifecycle".

## 3. ignore_changes
**What**: **Ignores specific attribute changes** in `.tf` vs state. Prevents unwanted updates.

**Syntax**: `ignore_changes = [attr1, attr2, all]`

**AWS Example**:
```hcl
resource "aws_instance" "stable_instance" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"  # ← Ignore changes here
  
  lifecycle {
    ignore_changes = [instance_type]  # Ignore instance_type changes
  }
  
  tags = {
    Name = "a-instance"
  }
}
```

**Demo Flow**:
1. `terraform apply` → Creates `t3.micro`
2. Change `.tf` to `t3.small` → `terraform apply`
3. **Result**: "No changes. Infrastructure matches configuration."
4. **State file**: Still shows `t3.micro` (ignores `t3.small`)

**Name change works**:
```
# tags.Name = "ubuntu-instance" → "a-instance" ✅ Applies
# instance_type = "t3.small" → Ignored ❌ No change
```

**Production Scenario**: Ops team manually scales instance_type during incidents—Terraform doesn't fight them.

**Common Mistake**: `ignore_changes = all` → Ignores **everything** (dangerous).
**Best Practice**: `ignore_changes = [tags, instance_type]` for operational flexibility.

## Lifecycle Summary Table

| Option | Default | Use Case | Result |
|--------|---------|----------|--------|
| `create_before_destroy` | `false` | Zero-downtime | **NEW → OLD** |
| `prevent_destroy` | `false` | Prod protection | **Blocks destroy** |
| `ignore_changes` | `[]` | Ops flexibility | **Ignores updates** |

## Complete Production Example
```hcl
resource "aws_instance" "prod_web" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.medium"
  
  lifecycle {
    create_before_destroy = true    # Zero-downtime AMI updates
    prevent_destroy       = true    # Prod protection
    ignore_changes        = [tags]  # Ops can add monitoring tags
  }
  
  tags = {
    Name    = "prod-web-${count.index}"
    Environment = "production"
  }
  
  count = 3
}
```

## Interview Cheat Sheet
```
Q: "How to achieve zero-downtime with Terraform?"
A: "lifecycle { create_before_destroy = true } for immutable updates"

Q: "Prevent accidental prod destroy?"
A: "lifecycle { prevent_destroy = true }"

Q: "Ops team changes instance size manually?"
A: "lifecycle { ignore_changes = [instance_type] }"

Q: "Default destroy order?"
A: "Destroy old → Create new (downtime). Override with create_before_destroy."
```

## Production Best Practices
1. **Always** `prevent_destroy = true` for prod databases/primary LBs
2. **Use** `create_before_destroy` for Auto Scaling Groups, ALBs
3. **Ignore** operational tags (`Name`, `Owner`, monitoring tags)
4. **Test** lifecycle in dev first—can't easily remove later

**Mnemonic**: **C**reate-Before-Destroy → **C**ustomer-facing. **P**revent-Destroy → **P**roduction. **I**gnore-Changes → **I**nfrastructure-Ops harmony.



Day - 6

**Terraform Advanced Operations** cover parallelism control, resource replacement, drift detection, importing existing resources, and debugging. These are essential for production environments and troubleshooting.

## Parallelism Control
**What**: Controls **concurrent resource operations**. Default: **10 simultaneous**. Increase for faster large deployments.

**Command**: `terraform apply -parallelism=N`

**AWS Example** (15 identical EC2s):
```hcl
resource "aws_instance" "web_servers" {
  count         = 15
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
  
  tags = {
    Name = "web-${count.index}"
  }
}
```

**Demo Flow**:
```
# Default (10 parallel)
terraform apply --auto-approve
# Creates 10 → waits → creates 5

# Full parallel (15 parallel)  
terraform apply -parallelism=15 --auto-approve
# Creates all 15 simultaneously
```

**Production Scenario**: Deploy 50+ EKS worker nodes faster.
**Best Practice**: `-parallelism=50` max. Higher = more API throttling risk.

## Terraform Replace (Formerly Taint)
**What**: **Forcefully recreate** a resource without code changes. Marks resource as "tainted" → destroyed + recreated on next `apply`.

**Command**: `terraform plan` → `terraform apply` → **destroy + create**.

**AWS Example**:
```bash
# Current: aws_instance.mumbai_instance running
$ terraform apply -replace="aws_instance.mumbai_instance" --auto-approve

# Result:
# 1. mumbai_instance (old) → terminating ❌
# 2. mumbai_instance (new) → creating/provisioning ✅
```

**When to use**: 
- Resource corruption
- Manual console changes (drift)
- Testing recreate behavior

**Production Scenario**: Faulty Jenkins agent—replace without code changes.

**Difference from Lifecycle**: Replace = **destroy → create**. `create_before_destroy` = **create → destroy**.

## Terraform Refresh (Deprecated) → Drift Detection
**What**: Syncs `terraform.tfstate` with **real cloud state**. Detects manual console changes.

**Modern Workflow** (Terraform 1.0+):
```
1. Manual change in AWS Console (t3.small → t3.micro)
2. terraform plan -refresh-only    # Detects drift
3. terraform apply                 # Reconciles to desired state
```

**Drift Detection Demo**:
```
# AWS Console: Stop EC2 → Change t3.small → t3.micro → Start
# State file: Still shows t3.small
# Public IP changed (stop/start)

$ terraform plan -refresh-only
# + instance_type: "t3.micro" ← Detected drift
# + public_ip:    "54.XXX.XXX.XXX" ← New IP

$ terraform apply --auto-approve
# Reconciles: t3.micro → t3.small (desired state)
```

**Production Scenario**: Ops manually stops prod EC2 → Terraform restarts it.

## Terraform Import
**What**: **Brings existing AWS resources under Terraform management**. Creates state entry matching real resource.

**Syntax**: `terraform import resource.type.block_name resource_id`

**Complete Workflow**:
```hcl
# main.tf (MUST exist before import)
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_instance" {
  # AMI & instance_type required (others auto-populate)
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
}
```

```bash
# 1. Initialize new directory
$ mkdir import-test && cd import-test
$ terraform init

# 2. Import (resource.block = instance ID from AWS Console)
$ terraform import aws_instance.my_instance i-0a1b2c3d4e5f67890

# 3. Generate config (auto-populates attributes)
$ terraform plan -generate-config-out=ec2.tf

# 4. Review differences, apply
$ terraform apply
```

**Result**: Manual "manual-instance" → Terraform-tracked. `terraform destroy` now works.

**Production Scenario**: Legacy EC2s → IaC governance compliance.

**Common Mistake**: Missing `ami`/`instance_type` → Plan fails.
**Best Practice**: Import → `terraform plan -generate-config-out=` → Review → Commit.

## Debugging & Logging
**What**: Verbose logs for troubleshooting failed applies.

**Environment Variables**:
```bash
# Levels: trace > debug > info > warn > error
export TF_LOG=DEBUG          # Verbose logs
export TF_LOG_PATH=./tf-logs/terraform.log  # File output

# Run command
terraform apply --auto-approve

# Unset
unset TF_LOG
```

**Log Output** (with `TF_LOG=DEBUG`):
```
DEBUG: AWS API: EC2 RunInstances...
DEBUG: Instance i-0a1b2c3d4e5f67890 created
INFO: Apply complete! Resources: 1 added.
```

**Production Scenario**: Support ticket—"Share TF_LOG=DEBUG output".

## Advanced Commands Summary
| Command | Purpose | Use Case |
|---------|---------|----------|
| `-parallelism=N` | Concurrent operations | Large deployments |
| `-replace=` | Force recreate | Corrupted resources |
| `plan -refresh-only` | Detect drift | Manual console changes |
| `import` | Existing → Terraform | Legacy resource adoption |
| `TF_LOG=DEBUG` | Verbose troubleshooting | Failed applies |

## Interview Quick Hits
```
Q: "Default parallelism?"
A: "10 concurrent operations. Use -parallelism=20 for faster deploys"

Q: "Replace vs taint?"
A: "`terraform apply -replace=` (taint deprecated)"

Q: "Detect console changes?"
A: "`terraform plan -refresh-only` → Shows drift"

Q: "Import workflow?"
A: "1. Resource block → 2. `terraform import` → 3. `plan -generate-config-out` → 4. Review/apply"
```

**Production Golden Rule**: **Always** `plan -refresh-only` in CI/CD before apply to catch drift.


Day - 7

**Terraform State File Management** is the backbone of infrastructure tracking. Treat it like **production data**—critical, secure, and collaborative. This covers local storage, custom paths, S3 remote backend, locking, and state commands.

## State File Fundamentals
**What**: `terraform.tfstate` is the **source of truth**. Tracks resource IDs, dependencies, attributes (AMI, IP, ARN) for create/update/destroy decisions.

**Why Critical**: Without state → Terraform can't detect changes. **Never edit manually**—corrupts tracking.

**Lifecycle**:
```
terraform init  → No state file
terraform plan  → No state file  
terraform apply → Creates/updates terraform.tfstate
```

**Production Scenario**: Mercedes-Benz EKS cluster—state tracks 100+ resources across namespaces.

## Local Backend (Default)
**What**: Stores `terraform.tfstate` in working directory. Fine for solo dev, disastrous for teams.

**Example** (after `terraform apply`):
```json
{
  "resources": [{
    "type": "aws_instance",
    "name": "mumbai_instance",
    "attributes": {
      "id": "i-0a1b2c3d4e5f67890",
      "public_ip": "54.XXX.XXX.XXX",
      "ami": "ami-0abcdef1234567890"
    }
  }]
}
```

## Custom Local Path
**What**: Store state in separate directory for organization.

```hcl
# main.tf
terraform {
  backend "local" {
    path = "terraform/state-storage/secure.tfstate"
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "mumbai_instance" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
  tags = { Name = "mumbai-instance" }
}
```

**Migration**: `terraform init` → **"Backend initialization required"** → Type `yes`.

**Result**: State moves to `terraform/state-storage/secure.tfstate`. Original empties.

## S3 Remote Backend (Production Standard)
**What**: Centralized state storage + versioning. **Team collaboration essential**.

**Setup**:
1. Create S3 bucket (`aterraform-bucket`) with **versioning enabled**
2. Configure backend:

```hcl
terraform {
  backend "s3" {
    bucket = "aterraform-bucket"
    key    = "central.tfstate"
    region = "ap-south-1"
  }
}
```

**Migration from Local**:
```bash
terraform init -migrate-state  # Copies local → S3
terraform plan                # Reads from S3
terraform apply --auto-approve # Updates S3
```

**Result**: `s3://aterraform-bucket/central.tfstate` contains EC2 details. Local file ignored.

**Production Scenario**: 10 DevOps engineers at MBRDI managing EKS—centralized state prevents overwrites.

## State Locking (Critical for Teams)
**What**: **Prevents concurrent modifications**. One user locks → others wait.

**Modern S3 Config** (No DynamoDB needed):
```hcl
terraform {
  backend "s3" {
    bucket         = "aterraform-bucket"
    key            = "central.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"  # Optional: explicit lock table
  }
}
```

**Demo** (Two terminals):
```
# Terminal 1 (Person A)
$ terraform apply  # Locks state, shows: "Acquiring state lock..."
# Waits for "yes" input...

# Terminal 2 (Person B) - BLOCKED
$ terraform apply  
Error: Error locking state: S3 bucket "aterraform-bucket" locked by [lock-id]
```

**Unlock**: Operation completes → Lock auto-releases.

**Without Locking Risks**:
- Duplicate resources
- Wrong deletions  
- Corrupted state
- Unpredictable infrastructure

## State Commands
| Command | Purpose | Example |
|---------|---------|---------|
| `state list` | List tracked resources | `aws_instance.mumbai_instance` |
| `state show` | Resource details | All attributes (ID, IP, AMI) |
| `state mv` | Rename resource | `mv aws_instance.mumbai_instance aws_instance.mumbai_new_instance` |
| `state rm` | **AVOID** - Untracks | Resource becomes unmanaged orphan |

**Rename Demo**:
```bash
$ terraform state list
aws_instance.mumbai_instance

$ terraform state mv aws_instance.mumbai_instance aws_instance.mumbai_new_instance
Moved 1 object

$ terraform plan
# 1 to destroy + 1 to create (rename detected)
```

## Production Workflow
```
# 1. New project
mkdir prod-infra && cd prod-infra
terraform init

# 2. First apply → Creates S3 state
terraform apply --auto-approve

# 3. Team member clones repo
git clone && cd prod-infra
terraform init  # Auto-configures S3 backend
terraform plan  # Reads shared state
```

## Interview Cheat Sheet
```
Q: "Why remote state?"
A: "Team collaboration, no overwrites, versioning, centralized"

Q: "Local state problems?"
A: "Single-user only. Git commit = disaster"

Q: "State locking?"
A: "Prevents concurrent applies corrupting state"

Q: "Migration command?"
A: "terraform init -migrate-state"

Q: "State commands?"
A: "list, show, mv (rename), rm (avoid)"
```

## Best Practices [squareops](https://squareops.com/blog/terraform-state-management/)
✅ **Always** S3 + versioning  
✅ **Enable** state locking  
✅ **Never** commit local state to Git  
✅ **Separate** dev/staging/prod states  
✅ **Backup** via S3 versioning  
❌ **Never** `state rm` (orphans resources)  
❌ **Avoid** manual state edits  

**Mnemonic**: **S3 + Lock = Safe State**. Local = Learning only.


Day - 8

# Terraform Remote-Exec and User Data: Launching Configured EC2 Instances

These notes cover using Terraform's `remote-exec` provisioner and AWS `user_data` to bootstrap EC2 instances. Both methods install software (like Apache httpd) and deploy a simple webpage during launch. `remote-exec` uses SSH for post-launch commands, while `user_data` runs natively via AWS at boot. Neither is ideal for production—prefer config management tools like Ansible.

## Why Not Commonly Used?
Remote-exec requires SSH setup (keys, security groups) and isn't idempotent—reruns can fail if commands aren't safe. User data runs once at boot and ignores Terraform changes. Use Ansible, Chef, Puppet, or AWS Systems Manager for repeatable config management in real DevOps workflows.

**Production Scenario**: Quick PoC for a demo web server. For prod, integrate with Ansible Tower or AWS SSM for managed updates.

## 1. Remote-Exec Provisioner Setup

### Key Concepts
- **remote-exec**: Runs commands *on the remote EC2 instance* via SSH after creation. Opposite of `local-exec` (runs on your machine).
- **connection block**: Defines SSH details (type, user, private key, host).
- **provisioner "remote-exec"**: Executes inline commands or scripts remotely.
- **self.public_ip**: Dynamic reference to the instance's public IP (unavailable pre-creation).

**When to use**: Rare—temporary bootstrapping when user data isn't enough (e.g., multi-step installs needing instance details).
**Why important**: Enables Terraform to automate post-launch config without manual login.

**Common Mistake**: Wrong indentation or `=` vs `:` in connection (e.g., `type = "ssh"` not `type: ssh`).
**Debug Tip**: Check `terraform apply` logs for SSH errors. Verify key permissions (`chmod 400 key.pem`).

### Real-World AWS Example
Launch Amazon Linux 2023 EC2, SSH in, install httpd, start service, create `/var/www/html/index.html` with "Hello from Terraform".

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Change to your region
}

resource "aws_instance" "remote-exec-server" {
  ami           = "ami-0f65f6c2650bf6dd5"  # Amazon Linux 2023
  instance_type = "t3.micro"

  key_name                    = "AW-Linux"  # Your existing key pair
  vpc_security_group_ids      = ["sg-0123456789abcdef0"]  # SSH (22) + HTTP (80) open
  associate_public_ip_address = true
  tags = {
    Name = "remote-exec-server"
  }

  # SSH Connection Block
  connection {
    type        = "ssh"
    user        = "ec2-user"  # Default for Amazon Linux
    private_key = file("~/.keys/AW-Linux.pem")  # Local private key path
    host        = self.public_ip
  }

  # Remote-Exec Provisioner
  provisioner "remote-exec" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install -y httpd",
      "sudo systemctl enable --now httpd",
      "echo '<h1>Hello from Terraform</h1>' | sudo tee /var/www/html/index.html"
    ]
  }
}
```

**Apply Steps**:
```
terraform fmt
terraform plan  # Fixes: security_group_ids needs [] array for multi-SG
terraform apply --auto-approve
```

**Output**: Instance launches → SSH connects → Commands run → Browse `http://<public-ip>`.

**Production Scenario**: Spin up 5 temp instances for load testing. Terraform destroys them cleanly, but avoid in prod—use ASGs + user data.

**Best Practice**: Always `sudo` for root actions on Amazon Linux (`ec2-user`). Add timeouts: `connection { timeout = "5m" }`.

**Common Mistake**: Passing string instead of `["sg-id"]` array to `vpc_security_group_ids`.
**Debug Tip**: `terraform apply` shows install logs. Test SSH manually: `ssh -i key.pem ec2-user@public-ip`.

## 2. User Data Alternative (AWS Native)

### Key Concepts
- **user_data**: Base64-encoded script runs at boot via cloud-init (no SSH needed).
- **file()`: Reads local file content.
- **path.module**: Current Terraform module directory (use `${path.module}/userdata.txt`).

**When to use**: Simple boot-time setup (installs, services). Faster, no SSH overhead.
**Why important**: AWS-native, works on launch/destroy cycles, no external dependencies.

**Common Mistake**: Forgetting `#!/bin/bash` shebang or `base64encode` if not using `file()`.
**Debug Tip**: Check instance **System Log** (Actions → Monitor and troubleshoot → Get system log).

### Real-World AWS Example
Same httpd setup, but via `userdata.txt` file.

**userdata.txt** (in same dir as .tf):
```bash
#!/bin/bash
sudo dnf update -y
sudo dnf install -y httpd
sudo systemctl enable --now httpd
echo '<h1>Hello from User Data</h1>' | sudo tee /var/www/html/index.html
```

**Terraform Code**:
```hcl
resource "aws_instance" "user-data-server" {
  ami           = "ami-0f65f6c2650bf6dd5"
  instance_type = "t3.micro"

  key_name                    = "AW-Linux"
  vpc_security_group_ids      = ["sg-0123456789abcdef0"]
  associate_public_ip_address = true
  tags = {
    Name = "user-data-server"
  }

  # User Data from File
  user_data = file("${path.module}/userdata.txt")
}
```

**Apply**:
```
terraform fmt
terraform plan  # Shows +1 resource
terraform apply --auto-approve
```
Browse `http://<public-ip>` after ~2min boot.

**Production Scenario**: Auto-configure 100+ Spot Instances in an ASG for batch jobs. Scales better than remote-exec.

**Best Practice**: Keep scripts <16KB. Test standalone: Launch EC2 manually, paste into User Data field.

## Comparison Table

| Feature          | Remote-Exec                  | User Data                  |
|------------------|------------------------------|----------------------------|
| SSH Required?   | Yes                         | No                        |
| Runs When?      | Post-creation               | At boot                   |
| Idempotent?     | No (rerun risky)            | Once per boot             |
| Terraform Changes | Re-applies on `apply`      | Ignored after launch      |
| Best For        | Complex post-boot           | Simple init               |

## Key Takeaways for Interviews
- **remote-exec**: SSH-based provisioner for remote commands. Use `connection`, `self.public_ip`.
- **user_data**: Simpler, AWS boot script. Prefer over remote-exec.
- **Neither for Prod**: Use Ansible/SSM. Not idempotent, no drift detection.
- **Debug**: Logs in `apply`, AWS System Log, manual SSH.

**Best Practice**: Output public_ip for easy access:
```hcl
output "public_ip" {
  value = aws_instance.remote-exec-server.public_ip
}
```

Day - 9

# Terraform Required_Providers: Version Locking for Consistency

These notes explain Terraform's `required_providers` block inside the `terraform` block. It locks provider versions to prevent breaks from auto-upgrades. Providers are plugins connecting Terraform to clouds like AWS, exposing resources/data sources.

**Production Scenario**: Team of 5 DevOps engineers + CI/CD (GitHub Actions). Without locking, one uses v6.20.0 (works), another pulls latest v6.21.0 (breaks app). Locking ensures `terraform apply` behaves identically everywhere.

## What is a Terraform Provider?
- **Provider**: Plugin for AWS, Azure, etc. Handles authentication (region, credentials, profile) and exposes resources (e.g., `aws_instance`).
- **Auto-Download**: Terraform fetches latest on `init` if unspecified.

**provider "aws" {}**: Just config (no version).
```
provider "aws" {
  region = "us-east-1"
}
```

**When to use**: Always in prod—never rely on "latest".

## required_providers Block Explained

### Key Concepts
- **terraform { required_providers {} }**: Specifies exact provider source/version.
- **source**: Registry path (e.g., "hashicorp/aws").
- **version**: Semantic lock (e.g., "~> 6.0" allows 6.x patches, not 7.0).
- **Types**:
  | Type     | Description                  | Example                  |
  |----------|------------------------------|--------------------------|
  | Official| HashiCorp-maintained        | hashicorp/aws           |
  | Partner | Verified 3rd-party          | Browse registry/partners|
  | Community| User-contributed           | registry.terraform.io/community/... |

**When to use**: Lock versions in shared codebases (Git repos, CI/CD).
**Why important**: Prevents "works on my machine" issues. Latest can break code (new required fields, API changes).

**Find Versions**: [registry.terraform.io/providers/hashicorp/aws](https://registry.terraform.io/providers/hashicorp/aws) → "Use Provider" → Copy code (e.g., published 6 days ago: v6.21.0).

### Real-World AWS Example
Without locking (risky—pulls latest):
```hcl
terraform {
  # No required_providers = latest always
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
}
```

**With Locking** (safe—pins ~>6.20):
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.20.0"  # Allows 6.20.x, not 6.21 or 7.0
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "locked-example" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
}
```

**Workflow**:
```
terraform init  # Downloads pinned version to .terraform/providers
terraform plan
terraform apply
```

**Production Scenario**: Built VPC/EC2 stack on AWS provider v6.20.0. v6.21.0 drops deprecated `associate_public_ip` field → apply fails. Pinning avoids this.

## Benefits of Version Locking
- **Consistency**: You (v6.20), teammate (v6.21), senior (v5.3), CI/CD—all same behavior.
- **No Surprise Breaks**: Latest might change resource schemas.
- **CI/CD Safe**: Pipelines reproducible.

## Risks of NOT Locking (or Using Too-Old Versions)
- **Auto-Upgrade Breaks**: Code built on v6.20 fails on v6.21.
- **Deprecated Fields**: Errors on apply (e.g., removed attrs).
- **Incompat with Terraform Core**: Old providers fail new CLI.
- **Missed Security/Bugs**: No patches.

**Example Error** (unpinned latest):
```
Error: Unsupported argument "vpc_security_group_ids" (deprecated in v6.21)
```

## Upgrading Providers Safely
**Best Practice**: Gradual rollout.
1. Pin current: `~> 6.20.0`.
2. Review changelog: [Releases](https://github.com/hashicorp/terraform-provider-aws/releases).
3. Update lower envs: `version = "~> 6.21.0"`.
4. Test: Dev → Test → QA → UAT → Prod.
5. Commit `.terraform.lock.hcl` (auto-generated, tracks hashes).

**Common Mistake**: `version = "latest"` (ignores pinning).
**Debug Tip**: `terraform version` shows providers. `terraform init -upgrade` pulls latest (use cautiously).

## .terraform.lock.hcl (Bonus: Auto-Locking)
`terraform init` creates this file with exact hashes. **Always commit it** for reproducible builds.

**Example Snippet**:
```
provider "registry.terraform.io/hashicorp/aws" {
  version     = "6.20.0"
  constraints = "~> 6.20.0"
  hashes = ["h1:..."]
}
```

**Interview Tip**: "Why commit lock file? Ensures byte-identical providers across machines/pipelines, beyond just version."

## Commands Touched
| Command      | Purpose                          | Example Usage |
|--------------|----------------------------------|---------------|
| `terraform init` | Download/lock providers        | `terraform init` |
| `terraform version` | Check versions                | Shows core + providers |

**Best Practices Summary**:
- Always use `required_providers`.
- `~> MAJOR.MINOR` for patches.
- Commit `.terraform.lock.hcl`.
- Upgrade via lower envs.
- Official > Partner > Community.

**Common Mistake**: Forgetting `terraform { }` wrapper.
**Debug Tip**: `terraform providers` lists all with versions/sources.

Day - 10

# Terraform Variables: Parameterizing for Reusability

Terraform variables replace hardcoded values (AMI, instance_type, region) for clean, reusable code across environments (dev, UAT, QA, prod). Define in `variables.tf`, reference as `var.<name>`. Supports CLI overrides (`-var`), `terraform.tfvars`, or defaults.

**Production Scenario**: Single `.tf` stack deploys to dev/prod. Change `var.environment=prod` + `var.instance_type=t3.large`—no code edits. Scales to workspaces (next video).

## Variable Types and Usage

| Type      | Description                          | When/Why Use | Example Default |
|-----------|--------------------------------------|--------------|-----------------|
| **string**| Text (region, AMI ID)               | Single values | `"ap-south-1"` |
| **number**| Integers (count)                    | Counts/sizes | `2`            |
| **bool**  | True/false                          | Flags        | `true`         |
| **list(string)** | Ordered array (instance_types) | Pick from options | `["t3.micro", "t3.small"]` |
| **map(string)** | Key-value (tags)                | Metadata     | `{Name="test", Env="dev"}` |
| **object**| Structured data                     | Complex configs | `{ami="...", type="t3.micro"}` |
| **tuple** | Fixed-length typed list             | Strict lists | `tuple([string, number])` |
| **any**   | Any type (avoid)                    | Flexible     | N/A            |

**Type Inference**: Optional—Terraform guesses from default/usage. Always specify for clarity.

**Best Practice**: Defaults for non-sensitive. `sensitive = true` hides values (e.g., passwords).

## Hands-On Examples: EC2 with Variables

**Standard Structure** (prod-ready):
```
.
├── main.tf       # Resources + providers
├── variables.tf  # var blocks
├── outputs.tf    # outputs
└── terraform.tfvars  # env-specific values
```

### 1. String Variable (instance_type)
**variables.tf**:
```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
```

**main.tf**:
```hcl
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0f65f6c2650bf6dd5"  # Amazon Linux 2023
  instance_type = var.instance_type       # Reference!
}
```

**Apply**:
```
terraform plan  # Uses default t3.micro
terraform apply
```

**Change**: `terraform apply -var='instance_type=t3.small'` → Modifies in-place.

### 2. List Variable (Pick from Options)
**variables.tf**:
```hcl
variable "instance_types" {
  description = "Available instance types"
  type        = list(string)
  default     = ["t3.micro", "t3.small", "t3.medium"]
}
```

**main.tf** (pick index 1 = t3.small):
```hcl
resource "aws_instance" "list_example" {
  ami           = "ami-0f65f6c2650bf6dd5"
  instance_type = var.instance_types[1]  # Index starts at 0!
}
```

**Plan/Apply**: Creates t3.small. Change `[1]` to `[0]` → Downgrades to micro.

**Common Mistake**: Forgetting `[]` or quotes: `["t3.micro", "t3.small"]`.
**Debug Tip**: `terraform plan` shows computed values.

### 3. Number Variable (count)
**variables.tf**:
```hcl
variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 2
}
```

**main.tf**:
```hcl
resource "aws_instance" "count_example" {
  count        = var.instance_count
  ami          = "ami-0f65f6c2650bf6dd5"
  instance_type = "t3.small"

  tags = {
    Name = "my-instance-${count.index + 1}"  # Starts from 1
  }
}
```

**Apply**: Creates 2 instances: "my-instance-1", "my-instance-2".
**Change**: Set `default=1` → Plan shows 1 destroy, 0 create.

**Production Scenario**: `var.instance_count=10` for dev load tests → `=1` for prod.

### 4. Map Variable (tags)
**variables.tf**:
```hcl
variable "instance_tags" {
  description = "EC2 tags"
  type        = map(string)
  default = {
    Name       = "map-test"
    Environment = "dev"
    Project    = "demo"
    Owner      = "bhadresh"
    CostCenter = "12345"
  }
}
```

**main.tf**:
```hcl
resource "aws_instance" "tags_example" {
  count         = var.instance_count
  ami           = "ami-0f65f6c2650bf6dd5"
  instance_type = "t3.small"

  tags = var.instance_tags  # Applies to all!
}
```

**Plan**: Adds tags to existing instances.

### 5. Full Parameterized Example (All Types)
**variables.tf** (complete):
```hcl
variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "ami_id" {
  type    = string
  default = "ami-0f65f6c2650bf6dd5"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Project     = "terraform-demo"
  }
}
```

**main.tf**:
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.20"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "demo" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(var.instance_tags, {
    Name = "demo-${count.index + 1}"
  })
}
```

**terraform.tfvars** (override defaults):
```
instance_count = 1
instance_type  = "t3.small"
ami_id         = "ami-ubuntu"  # Switch OS!
```

**Workflow**:
```
terraform fmt     # Indents cleanly
terraform plan    # Detects changes
terraform apply --auto-approve
```

**Change AMI**: Edit `terraform.tfvars` → `plan` shows replace (stop/start).

## Best Practices & Common Mistakes
- **Separate Files**: `variables.tf` (defs), `terraform.tfvars` (values), `outputs.tf`.
- **Descriptions**: Help docs (`terraform console > var.instance_type`).
- **No Hardcoding**: Parameterize everything changeable.
- **Validation** (bonus):
  ```hcl
  variable "instance_type" {
    type = string
    validation {
      condition     = contains(["t3.micro", "t3.small"], var.instance_type)
      error_message = "Must be t3.micro or t3.small."
    }
  }
  ```

**Mistake**: Mismatch names (`var.instanace_type` vs `variable "instance_type"`). **Fix**: Red underline in editor + `terraform plan` error: "No declaration found".
**Debug Tip**: `terraform console` → Test `var.<name>` interactively. Workspace scans all `.tf` files.

**Interview Q**: "How override vars?" A: Defaults < `terraform.tfvars` < `-var` < env vars (`TF_VAR_foo`).

Fully parameterized = reusable across envs. Next: Workspaces for dev/prod isolation.

Day - 11

# Terraform tfvars + Workspaces: Multi-Environment Deployments

Build on variables: Use `*.tfvars` files for env-specific values (dev.tfvars, uat.tfvars, prod.tfvars). Workspaces provide state isolation per env. Together: Reuse code, deploy dev/UAT/prod without overrides/destroys.

**Production Scenario**: Single repo deploys VPC/EC2 to dev (t3.micro, 1 instance), UAT (t3.small, 2), prod (m5.large, 5 + prod tags). No code changes, isolated states.

## 1. tfvars Files: Environment Overrides

### Key Concepts
- **terraform.tfvars** (or `*.tfvars`): Auto-loaded key=value overrides defaults. Specify with `-var-file=dev.tfvars`.
- **No Defaults in vars.tf**: Force env-specific values via tfvars.
- **Precedence**: Defaults < terraform.tfvars < `-var-file` < `-var` CLI.

**When to use**: Quick multi-env without workspaces (small teams).
**Why important**: Parameterize without touching main.tf/variables.tf.

**Structure**:
```
.
├── main.tf
├── variables.tf  # No defaults!
├── dev.tfvars
├── uat.tfvars
└── prod.tfvars
```

**variables.tf** (remove defaults):
```hcl
variable "region" {
  type        = string
  description = "Region to deploy"
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "instance_tags" {
  type = map(string)
}
```

**dev.tfvars**:
```
region         = "ap-south-1"
ami_id         = "ami-0f65f6c2650bf6dd5"  # Amazon Linux
instance_type  = "t3.micro"
instance_count = 1
instance_tags = {
  Name        = "dev-instance"
  Environment = "dev"
}
```

**uat.tfvars** (copy + edit):
```
region         = "ap-south-1"
ami_id         = "ami-0f65f6c2650bf6dd5"
instance_type  = "t3.small"
instance_count = 2
instance_tags = {
  Name        = "uat-instance"
  Environment = "uat"
}
```

**prod.tfvars**:
```
region         = "ap-south-1"
ami_id         = "ami-prod-stable"  # Prod-optimized AMI
instance_type  = "m5.large"
instance_count = 5
instance_tags = {
  Name        = "prod-instance"
  Environment = "prod"
  CostCenter  = "12345"
}
```

**Deploy**:
```
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars" --auto-approve
```

**Problem**: Switching files overrides state—`apply -var-file=uat.tfvars` destroys dev resources!

**Common Mistake**: Defaults in variables.tf + tfvars conflict.
**Debug Tip**: `terraform plan -var-file=foo.tfvars` previews.

## 2. Workspaces: State Isolation

### Key Concepts
- **Workspace**: Separate Terraform state per env (dev, uat, prod). Default: "default".
- **terraform.tfstate.d/**: Local backend folders per workspace.
- **Isolation**: Resources in "dev" workspace invisible in "uat".

**When to use**: Multi-env with shared code. Local dev/testing.
**Why important**: Prevents accidental destroys across envs. Prod uses remote backends (S3).

**Commands**:
| Command                  | Purpose                          | Example |
|--------------------------|----------------------------------|---------|
| `terraform workspace list` | List workspaces                 | Shows default, dev... |
| `terraform workspace new <name>` | Create + switch                | `new dev` |
| `terraform workspace show` | Current workspace               | "dev" |
| `terraform workspace select <name>` | Switch                        | `select uat` |
| `terraform workspace delete <name>` | Delete (must be empty + not current) | `delete dev` |

### Full Workflow: Dev → UAT → Prod
1. **Init + Create**:
   ```
   terraform init
   terraform workspace new dev    # Creates terraform.tfstate.d/dev/
   terraform workspace new uat
   terraform workspace new prod
   terraform workspace list       # default, dev, uat, prod
   ```

2. **Deploy Dev**:
   ```
   terraform workspace select dev
   terraform workspace show       # dev
   terraform apply -var-file="dev.tfvars" --auto-approve  # Creates dev-instance
   ```

3. **Deploy UAT** (no destroy!):
   ```
   terraform workspace select uat
   terraform apply -var-file="uat.tfvars" --auto-approve  # Creates uat-instances
   ```

4. **Deploy Prod**:
   ```
   terraform workspace select prod
   terraform apply -var-file="prod.tfvars" --auto-approve  # 5x m5.large prod-instances
   ```

**Verify AWS**: 1 dev + 2 uat + 5 prod instances, isolated tags.

**Destroy Specific**:
```
terraform workspace select dev
terraform destroy -var-file="dev.tfvars"  # Empties dev workspace
terraform workspace select default        # Switch away
terraform workspace delete dev            # Now possible
```

**Common Mistake**: `destroy` without `-var-file` → Prompts vars.
**Error**: "Workspace not empty" → Destroy resources first. "Cannot delete current" → `select default`.

**Best Practice**:
- Local: Workspaces fine for solo/dev.
- Prod: Remote backend (S3+DynamoDB) + workspace names.
  ```hcl
  terraform {
    backend "s3" {
      bucket         = "my-terraform-state"
      key            = "prod/terraform.tfstate"
      region         = "ap-south-1"
      dynamodb_table = "terraform-locks"
      workspace_key_prefix = "env"  # dev/prod in path
    }
  }
  ```
- Script CI/CD: `terraform workspace select $ENV || terraform workspace new $ENV`.

## Comparison: tfvars vs Workspaces

| Feature          | tfvars Only                     | + Workspaces                  |
|------------------|---------------------------------|-------------------------------|
| State            | Single (overrides destroy)     | Isolated per env             |
| Deploy UAT       | Destroys dev                   | Keeps dev intact             |
| Best For         | Single env/single dev          | Multi-env/teams              |
| Local Backend    | terraform.tfstate              | terraform.tfstate.d/<ws>/    |

**Interview Q**: "tfvars vs workspaces?" A: tfvars=values, workspaces=state isolation.

**Debug Tip**: `terraform state list` shows resources in current workspace.

Day - 12

# Terraform Outputs, Dynamic Blocks, and Data Sources

Continuing from variables/workspaces: **Outputs** expose resource info (IPs, IDs), **dynamic blocks** eliminate repeated code, **data sources** fetch existing AWS resources (AMIs, VPCs). Standard structure: `main.tf` (resources), `variables.tf`, `outputs.tf`.

**Production Scenario**: Module outputs VPC ID to `locals` for dependent services. Dynamic ingress for 10+ ports. Data source fetches latest stable AMI.

## 1. Outputs: Expose Resource Information

### Key Concepts
- **output "block_name"**: Displays computed values after `apply`.
- **value**: Reference resource attributes (`aws_instance.web.public_ip`).
- **Separate File**: `outputs.tf` keeps main.tf clean.

**When to use**: Share IPs, ARNs, names with other modules/teams/users.
**Why important**: No AWS Console needed. JSON for CI/CD parsing.

### Real-World AWS Example
**main.tf**:
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.20"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "lab-output"
  }
}
```

**variables.tf**:
```hcl
variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "ami_id" {
  type    = string
  default = "ami-0f65f6c2650bf6dd5"
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
```

**outputs.tf**:
```hcl
output "instance_id" {
  description = "My instance ID"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "My instance public IP"
  value       = aws_instance.web.public_ip
}

output "private_ip" {
  description = "My instance private IP"
  value       = aws_instance.web.private_ip
}
```

**Workflow**:
```
terraform init
terraform plan    # Shows "changes to outputs"
terraform apply   # Creates + displays outputs
terraform output  # All outputs
terraform output public_ip  # Single output (case-sensitive!)
terraform output -json      # JSON for scripts
```

**Production Scenario**: Output ALB DNS to Route53 record:
```hcl
output "alb_dns" {
  value = aws_lb.web.dns_name
}
```

**Common Mistake**: Case mismatch (`Public_ip` vs `public_ip`). **Debug**: `terraform output` lists exact names.

## 2. Dynamic Blocks: DRY Code for Repeated Blocks

### Key Concepts
- **dynamic "ingress"**: Loops over list/map to generate identical blocks.
- **for_each**: Iterates `locals`/`var` data.
- **ingress.value.<attr>**: Access each iteration.

**When to use**: Security group rules, launch template metadata, repeated options.
**Why important**: Add ports without code duplication. Git-friendly.

### Real-World AWS Example: Multi-Port Security Group
**main.tf**:
```hcl
locals {
  ingress_rules = [
    { from_port = 22,   to_port = 22,   protocol = "tcp", description = "SSH" },
    { from_port = 80,   to_port = 80,   protocol = "tcp", description = "HTTP" },
    { from_port = 443,  to_port = 443,  protocol = "tcp", description = "HTTPS" },
    { from_port = 8080, to_port = 8080, protocol = "tcp", description = "App" },
    { from_port = 3306, to_port = 3306, protocol = "tcp", description = "MySQL" },
    { from_port = 2049, to_port = 2049, protocol = "tcp", description = "EFS" }
  ]
}

resource "aws_security_group" "my-tf-sg" {
  name_prefix = "my-tf-sg-dynamic-"

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]  # Restrict in prod!
      description = ingress.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dynamic SG Demo"
  }
}
```

**Add Port** (no resource changes):
```hcl
# Add to locals.ingress_rules:
{ from_port = 1433, to_port = 1433, protocol = "tcp", description = "MSSQL" },
```

**Apply**: `terraform plan` → +1 ingress rule, `apply` → Updated SG.

**Production Scenario**: 20 microservices ports → Single `locals` list vs 20x copy-paste blocks.

**Common Mistake**: Unclosed `{}` in other files → "unclosed configuration block". **Debug**: `terraform validate`, `terraform fmt`.

## 3. Data Sources: Fetch Existing Resources

### Key Concepts
- **data "aws_ami"**: Queries AWS for existing resources (latest AMI, VPC).
- **filter**: Match attributes (name, owner).
- **most_recent = true**: Pick newest matching.
- **Reference**: `data.aws_ami.al2023.id`.

**When to use**: Latest AMIs, existing VPC/subnets, canonical URNs.
**Why important**: No hardcoded IDs. Dynamic across regions/accounts.

### Real-World AWS Example: Latest Amazon Linux 2023
**ami-test.tf**:
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.20"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Data Source: Latest AL2023 AMI
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]  # Official AMIs

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]  # Pattern match
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Use dynamic AMI
resource "aws_instance" "web" {
  ami           = data.aws_ami.al2023.id  # No hardcoded ID!
  instance_type = "t3.micro"

  tags = {
    Name = "Amazon Linux 2023 Test"
  }
}
```

**Workflow**:
```
terraform validate  # Syntax check
terraform plan      # Fetches AMI ID dynamically
terraform apply --auto-approve
```

**Production Scenario**: Golden AMI pipeline → Data source always picks latest approved AMI.

**Common Mistake**: Wrong filter pattern → 0 results. **Debug**: `terraform console > data.aws_ami.al2023.id`.

## Standard File Structure (Prod-Ready)
```
.
├── main.tf       # Providers + resources
├── variables.tf  # var blocks
├── outputs.tf    # output blocks
├── locals.tf     # locals { }
├── dev.tfvars
└── terraform.tfstate.d/  # Workspaces
```

## Interview Quick Hits
- **Output?** "Expose resource attributes post-apply"
- **Dynamic?** "`for_each` for repeated nested blocks"
- **Data?** "Query existing cloud resources"
- **File separation?** "main/resources, variables.tf, outputs.tf, locals.tf"

**Best Practices**:
- `description` on outputs/vars
- `locals` for computed/reusable values
- Validate filters: `terraform console`
- Dynamic for >3 repeated blocks

Day - 13

# Terraform Modules: Reusable Infrastructure Code

Modules organize Terraform into scalable structures: **root module** (top-level main.tf calls children), **child modules** (service-specific: EC2, S3, VPC). Sources: local paths, Terraform Registry, Git, private registries. Standard: `main.tf` + `variables.tf` + `outputs.tf` per module.

**Production Scenario**: Monorepo with modules/EC2, modules/VPC, modules/RDS. Root deploys full stack. Registry for community-tested components (e.g., EKS).

## Module Structure & Sources

### Key Concepts
- **Root Module**: Executes `terraform` commands. Calls children via `module "name" { source = ... }`.
- **Child Module**: Self-contained dir with main.tf/variables.tf/outputs.tf.
- **source**:
  | Type       | Example                          | Use Case |
  |------------|----------------------------------|----------|
  | **Local** | `"./modules/s3"`                | Custom  |
  | **Registry** | `"terraform-aws-modules/s3/aws"` | Public |
  | **Git**   | `"git::https://github.com/...//s3?ref=v1.0"` | Versioned |
  | **Private**| Enterprise registries           | Org     |

**When to use**: >1 service/file. Reusability across projects/envs.
**Why important**: DRY, versioned, testable components.

**Project Structure**:
```
project-modules/
├── main.tf              # Root: Calls modules
├── variables.tf         # Root vars
├── outputs.tf           # Root outputs
├── terraform.tfvars     # Dev values
├── prd.tfvars           # Prod overrides
├── backend.tf           # S3 state
└── modules/
    ├── ec2/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── s3/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## 1. Local Modules Example

### Child: modules/ec2/main.tf
```hcl
# No provider here—inherits from root!

resource "aws_instance" "my_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.ec2_name
  }
}
```

**modules/ec2/variables.tf**:
```hcl
variable "ami" {
  description = "AMI ID to use with instance"
  type        = string
}

variable "instance_type" {
  type = string
}

variable "ec2_name" {
  type    = string
  default = "my-project-instance"
}
```

**modules/ec2/outputs.tf**:
```hcl
output "instance_id" {
  value = aws_instance.my_instance.id
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "private_ip" {
  value = aws_instance.my_instance.private_ip
}
```

### Child: modules/s3/main.tf
```hcl
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}
```

**modules/s3/variables.tf**:
```hcl
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}
```

**modules/s3/outputs.tf**:
```hcl
output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}
```

### Root: main.tf
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.20"
    }
  }
}

provider "aws" {
  region = var.region
}

module "ec2_module" {
  source = "./modules/ec2"

  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  ec2_name      = var.ec2_name
}

module "s3_module" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}
```

**Root variables.tf**:
```hcl
variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "ec2_ami" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "ec2_name" {
  type    = string
  default = "dev-ec2-instance"
}

variable "s3_bucket_name" {
  type = string
}
```

**Root outputs.tf**:
```hcl
output "ec2_instance_id" {
  value = module.ec2_module.instance_id
}

output "ec2_public_ip" {
  value = module.ec2_module.public_ip
}

output "s3_bucket_id" {
  value = module.s3_module.bucket_id
}
```

**terraform.tfvars** (dev):
```
ec2_ami            = "ami-0f65f6c2650bf6dd5"
ec2_instance_type  = "t3.micro"
ec2_name           = "dev-ec2-instance"
s3_bucket_name     = "my-aws-s3-yt-bucket"
```

**prd.tfvars** (prod):
```
ec2_ami            = "ami-prod-stable"
ec2_instance_type  = "t3.small"
ec2_name           = "prd-ec2-instance"
s3_bucket_name     = "prd-my-aws-s3-yt-bucket"
```

**Workflow**:
```
terraform init     # Downloads providers + validates module paths
terraform validate # Syntax
terraform plan -var-file="prd.tfvars"
terraform apply -var-file="prd.tfvars" --auto-approve
terraform output   # Module outputs!
```

**Verify**: EC2 ("prd-ec2-instance") + S3 bucket created.

## 2. Terraform Registry Modules

**Replace Local S3** in root main.tf:
```hcl
module "s3_registry" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket = "my-module-test-bkt"
  acl    = "private"
}
```
```
terraform init  # Fetches from registry
terraform plan  # Random → custom name (force replace)
```

**Naming**: `terraform-<provider>-<service>` (public GitHub repo).

**Common Mistake**: Wrong `source` path → "unreadable module directory". **Debug**: `terraform init` logs.

## 3. Remote State Backend (S3)

**backend.tf** (root):
```hcl
terraform {
  backend "s3" {
    bucket         = "tf-state-bkt"  # Existing bucket
    key            = "project/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    # dynamodb_table = "terraform-locks"  # Optional: Native now
  }
}
```

**Workflow**:
```
terraform init  # Migrates local → S3
terraform plan -var-file="prd.tfvars"
# State now in S3: project/terraform.tfstate
```

**Production Scenario**: Team shares state. Lock prevents concurrent applies.

**Best Practices**:
- Unique bucket names (env/account).
- Per-env keys: `${terraform.workspace}/state.tfstate`.
- Version modules.
- README.md per module.

**Destroy**:
```
terraform destroy -var-file="prd.tfvars"
```

**Interview Q**: "Module source local vs registry?" A: Local=custom, registry=pre-built (source=registry path, version pin).

Day - 14

# HCP Terraform (Cloud): GitOps UI Workflow

HCP Terraform (HashiCorp Cloud Platform) provides browser-based Terraform management with GitHub integration. Git commits → auto plan/apply → AWS resources. Three execution modes: **Remote** (cloud runs), **Local** (CLI + remote state), **Agent** (paid, self-hosted).

**Production Scenario**: DevOps team pushes VPC/EC2 changes to GitHub → HCP auto-plans → Team reviews → Auto-applies to dev/prod. State in HCP, drift detection daily.

## HCP Terraform Structure
```
Organization (ai-org)
└── Project (default)
    └── Workspace (tf-aws)
        ├── GitHub repo (tf-aws)
        ├── AWS credentials (env vars)
        └── State file (remote)
```

## 1. Setup: Organization → Workspace → GitHub

### Step-by-Step Account Creation
1. **app.hashicorp.com** → Free account → Unique username + email
2. **Verify email** → Click confirmation link
3. **Create Organization**: `ai-org` (unique, alphanumeric + dashes)
4. **Default Project** → Auto-created
5. **New Workspace** (`tf-aws`) → Default project

### GitHub Integration (VCS Workflow)
```
1. HCP Workspace → "Version Control Workflow"
2. GitHub.com → Authorize HCP Terraform app
3. Select repos: tf-aws (read/write)
4. Repo must have code (not empty)
```

**GitHub Verification**: Settings → Applications → "Terraform Cloud" (repo access confirmed).

**main.tf** (push to `tf-aws` repo):
```hcl
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "tf_server" {
  count         = 1  # Later: 2, 3
  ami           = "ami-0f65f6c2650bf6dd5"
  instance_type = "t3.micro"

  tags = {
    Name = "tf-aws-server"
  }
}
```

**Commit** → HCP detects → Ready.

## 2. AWS Credentials (Environment Variables)

**IAM User Setup**:
```
1. AWS Console → IAM → Users → Create
2. Attach: AdministratorAccess (demo) or least-privilege
3. Security Credentials → Access Keys → CLI → Copy
```

**HCP Workspace → Variables → Add**:
| Key                    | Value          | Sensitive | Type       |
|------------------------|----------------|-----------|------------|
| `AWS_ACCESS_KEY_ID`    | `AKIA...`      | ☑️        | Environment |
| `AWS_SECRET_ACCESS_KEY`| `abcd...`      | ☑️        | Environment |
| `TF_PROJECT`           | `demo`         | ☐️        | Terraform  |

**Best Practice**: Use IAM roles/OIDC in prod (no long-lived keys).

## 3. Runs: Plan → Confirm → Apply

**UI-Driven Run**:
```
Workspace → Runs → "Start New Plan"
→ Plan queued → Review changes
→ "Confirm & Apply" → Creating EC2...
→ Apply finished → State saved
```

**Auto GitOps** (VCS-Triggered):
```
GitHub commit → HCP auto-plan → Pending approval
Enable: Workspace Settings → "Auto apply on VCS"
→ Next commit → Plan + Apply (no approval)
```

**Run Status**:
| Status     | Meaning                     |
|------------|-----------------------------|
| **Queued** | Waiting for lock/agent     |
| **Planning** | `terraform plan` running |
| **Planned**| Review changes             |
| **Applying**| `terraform apply` running |
| **Applied**| Done ✅                    |

## 4. Workspace Settings (Key Options)

**Settings → General**:
```
Terraform Version: 1.14.0 (or Latest)
Auto Apply: ☑️ VCS, API, UI runs
Execution Mode: Remote (cloud) / Local (CLI) / Agent (paid)
```

| Setting          | Remote           | Local             |
|------------------|------------------|-------------------|
| **Plan/Apply**  | HCP servers     | Your machine     |
| **State**        | HCP (HTTP API)  | HCP (remote)     |
| **Best For**     | Teams/GitOps    | Local dev/debug  |

## 5. Local CLI + HCP Remote State

**Local Setup** (`remote-test/`):
**versions.tf** (remote backend):
```hcl
terraform {
  backend "remote" {
    organization = "ai-org"
    workspaces {
      name = "tf-aws"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.20"
    }
  }
}
```

**main.tf** (minimal, inherits workspace code):
```hcl
provider "aws" {
  region = "ap-south-1"
}
```

**Workflow**:
```
terraform login  # Browser → API token (7 days)
terraform init   # Connects to HCP workspace
terraform plan   # Uses remote state
terraform destroy  # Deletes EC2 (type 'yes')
```

**Destroy Error Fix**: Workspace → Settings → Execution Mode → **Local** → Save.

## 6. Advanced Features

### Locks
```
Run → Lock → Queues new runs
→ Manage Lock → Unlock
→ Pending runs execute
```

**Production**: Locks prevent concurrent applies.

### Drift Detection
```
Runs → "New Run" → "Refresh State"
→ Detects manual AWS Console changes
```

### Manual Runs
```
New Run Options:
- Plan + Apply (full)
- Plan-only (review)
- Refresh State (drift)
- Plan-only (empty apply allowed)
```

## Common Issues & Debug

| Error                          | Fix                                    |
|--------------------------------|----------------------------------------|
| **"Repo empty/not accessible"**| Add main.tf → Commit                  |
| **"No AWS resources"**         | Add AWS_ACCESS_KEY_ID/SECRET vars     |
| **"Workspace locked"**         | Runs → Manage Lock → Unlock           |
| **"VCS requires VCS workflow"**| Settings → Execution Mode → Local     |
| **"Duplicate outputs"**        | Unique names across modules           |

**Debug Tips**:
- **Runs → Logs** → Raw `terraform plan/apply` output
- **States** → View current tfstate
- **Variables** → Verify AWS keys loaded

## GitOps Workflow (Prod-Ready)
```
1. Developer: GitHub PR → main.tf (count=3)
2. HCP: Auto-plan → Slack notification
3. Approver: UI review → Confirm
4. HCP: Auto-apply → 3x EC2 created
5. State: HCP remote (encrypted, locked)
```

**Interview Qs**:
- **"HCP vs CLI?"** HCP=GitOps/collaboration, CLI=local speed
- **"Remote vs Local execution?"** Remote=cloud agents, Local=your machine + remote state
- **"State storage?"** HCP HTTP API backend

**Best Practices**:
- Least privilege IAM policies
- Auto-apply private repos only
- Lock before major changes
- Daily drift detection
- OIDC provider (no keys)

Day - 15

# HCP Terraform: Sentinel Policies & Cost Estimation

Continuation of HCP Terraform Cloud. **Sentinel Policies** enforce org standards (no public S3, approved instance types, mandatory tags). **Cost Estimation** shows $ impact pre-apply. Free plan limits: 1 mandatory policy, advisory unlimited.

**Production Scenario**: Org policy blocks t3.large+ instances, public S3. Devs attempt → Plan fails → Fix code → Re-PR. Cost estimates prevent surprise bills.

## 1. Sentinel Policies: Enforce Standards

### Key Concepts
- **Policy Set**: Container for 1+ policies. Global (all workspaces) or project-specific.
- **Policy Types**:
  | Enforcement      | Behavior                          | Free Plan Limit |
  |------------------|-----------------------------------|-----------------|
  | **Advisory**     | Warning (passes)                 | Unlimited      |
  | **Soft Mandatory**| Fail (override allowed)          | 1 total        |
  | **Hard Mandatory**| Fail (no override)               | 1 total        |

**When to use**: Security/compliance (no public buckets), cost control (no large instances), tagging.
**Why important**: GitOps guardrails. Prevents prod drifts.

### Setup: Policy Set + Policies
1. **Organization → Settings → Policy Sets → Connect Policy Set**
   ```
   Name: "my-org-standards"
   Scope: Global (all projects/workspaces)
   ```

2. **Create Policies** (Sentinel language):
   - **Block Public S3** (hard-mandatory):
     ```
     # Restrict public access block = false
     main = rule { public_access_block == true }
     ```
   - **Allowed Instance Types** (advisory):
     ```
     # Only t2.micro, t3.micro, t3.small
     main = rule { 
       all plan.changes.resources as r 
       r.type is "aws_instance" implies 
       contains(["t2.micro", "t3.micro", "t3.small"], r.change.after.instance_type)
     }
     ```

**Test**: Git push S3 public bucket → **Sentinel Failed** → "To continue, all validations must pass".

**Override** (soft-mandatory only): Run → "Override & Continue" → Admin bypass.

### Real-World Examples
**main.tf** (violates policies):
```hcl
resource "aws_s3_bucket" "public_violation" {
  bucket = "test-public-bucket"
  
  # VIOLATES: public_access_block = false
}

resource "aws_s3_bucket_public_access_block" "public_violation" {
  bucket = aws_s3_bucket.public_violation.id
  
  block_public_acls       = false  # Policy fails here
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_instance" "large_violation" {
  ami           = "ami-0f65f6c2650bf6dd5"
  instance_type = "m5.xlarge"  # Advisory warning
}
```

**Run Result**:
```
Sentinel Policies: ❌ FAILED (hard-mandatory)
"validate public access block is false"
→ Plan blocked
```

**Fix** → Re-commit → ✅ PASSED.

## 2. Cost Estimation

**Enable**: Workspace → Settings → "Enable cost estimation for all workspaces".

**Workflow Addition**:
```
1. Git commit → Plan
2. Cost Estimation (NEW) → $12.45/month (t3.micro)
3. Sentinel Policies → ✅ PASS
4. Confirm & Apply
```

**Sample Output**:
```
EC2 t3.micro x1:
├── Hourly: $0.0104
├── Monthly: $7.49 
└── Monthly Δ: +$7.49 (new)

Total Monthly: $7.49
```

**Production**: Blocks $10K+ surprise clusters.

## 3. HCP Plans & Limitations

| Feature\Plan     | **Free**       | **Essential** | **Standard/Premium** |
|------------------|----------------|---------------|---------------------|
| **Mandatory Policies** | 1           | 1             | Unlimited          |
| **Remote Runs**  | ✅             | ✅            | ✅                 |
| **VCS Integration** | ✅           | ✅            | ✅                 |
| **SSO**          | ❌             | ❌            | ✅                 |
| **Audit Logging**| ❌             | ❌            | ✅                 |
| **Drift Detection** | ❌          | ❌            | ✅                 |
| **Cost**         | $0             | $0.10/rsc/mo  | Custom             |

**Free Limits**:
- 1x Hard/Soft Mandatory policy
- 500/month resource-hours
- No team collaboration

## 4. Workspace Cleanup

**Delete Workspace** (must be empty):
```
Workspace → Settings → "Delete from HCP Terraform"
→ Type: "workspace-name" → Delete
```

**Delete Organization**:
```
Org Settings → "Delete Organization" → Type name → Delete
```

## Common Issues & Debug

| Error                        | Fix                                    |
|------------------------------|----------------------------------------|
| **"Sentinel policies failed"**| Fix code → Re-commit                  |
| **"Provider block not closed**| `terraform fmt` + syntax check        |
| **"Workspace locked"**       | Runs → "Manage Lock" → Unlock         |
| **"Cannot delete workspace"**| `count = 0` → Apply → Delete          |
| **"Policy override pending"**| Override (soft-only) or fix code      |

**Debug Tips**:
- **Policy Evaluation**: Workspace → "Evaluate Policies"
- **Run Logs**: Full `terraform plan` output
- **Cost Details**: Click "Cost Estimation" step

## Production Best Practices

```
# Mandatory Tags Policy (common org standard)
main = rule {
  all plan.changes.resources as r [
    r.type in ["aws_instance", "aws_s3_bucket"] implies
    r.change.after.tags.Project? and
    r.change.after.tags.Environment? and
    r.change.after.tags.CostCenter? and
    r.change.after.tags.Owner?
  ]
}
```

**CLI vs HCP**:
- **CLI**: Speed, unlimited policies, local control
- **HCP**: GitOps, collaboration, built-in governance

**Interview Qs**:
- **"Sentinel vs OPA?"** Sentinel=HCP-native, OPA=generic
- **"Hard vs Soft mandatory?"** Hard=no override, Soft=admin bypass
- **"Cost estimation when?"** Between plan + Sentinel, pre-apply

Most orgs: **CLI + S3 backend** (cost-effective). HCP for **teams/GitOps**.

Day - 16

# Terraform Project: S3 Static Website + CloudFront + Route53

Real-world project delivering **index.html** via secure **S3 → CloudFront → Route53 subdomain** (terraform.awsithainasready.com). Uses **Origin Access Control (OAC)** for private S3 access + **ACM SSL** (us-east-1). Professional structure with separate files.

**Production Scenario**: Marketing team deploys static landing pages. Content in S3, global CDN via CloudFront, custom domain via Route53. Zero-downtime updates via CI/CD.

## Project Structure (Production-Ready)
```
project-s3-cloudfront/
├── versions.tf      # TF version + providers
├── provider.tf      # AWS provider
├── backend.tf       # S3 remote state
├── variables.tf     # Configurable inputs
├── main.tf          # Core resources
├── outputs.tf       # Results
└── index.html       # Website content
```

## 1. versions.tf - Version Constraints

**Purpose**: Locks Terraform + AWS provider versions for reproducibility.

```hcl
terraform {
  required_version = ">= 1.3.0"  # Modern features (CloudFront OAC)
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # CloudFront OAC support
    }
  }
}
```

**When to use**: Always first file. Prevents "works on my machine" issues.
**Why important**: Breaking provider changes break prod.

## 2. provider.tf - AWS Provider

```hcl
provider "aws" {
  region = var.aws_region  # Flexible across envs
}
```

**variables.tf** (provider vars):
```hcl
variable "aws_region" {
  description = "AWS region to create resources"
  type        = string
  default     = "ap-south-1"
}
```

**Best Practice**: Never hardcode region. Use `terraform.tfvars` per env.

## 3. backend.tf - Remote State (S3)

```hcl
terraform {
  backend "s3" {
    bucket         = "ai-tf-bucket"      # Existing bucket
    key            = "serverless-website/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    # dynamodb_table = "terraform-locks" # Optional (S3 native locking)
    s3_bucket_tags = {
      Name = "Terraform State"
    }
  }
}
```

**Key Concepts**:
- **key**: `env/service/terraform.tfstate` (prod: `prd/website/terraform.tfstate`)
- **encrypt=true**: State encryption at rest
- **S3 versioning**: Recover accidental deletes [squareops](https://squareops.com/blog/terraform-state-management/)

**Production**: Team-shared state. Lock prevents concurrent applies.

## 4. variables.tf - Configurable Inputs

```hcl
variable "domain_name" {
  description = "Primary domain in Route53"
  type        = string
  default     = "awsithainasready.com"
}

variable "subdomain" {
  description = "Subdomain for CloudFront"
  type        = string
  default     = "terraform"
}

variable "s3_bucket_name" {
  description = "S3 bucket for website content"
  type        = string
  default     = "aisite.com"  # Existing bucket
}

variable "certificate_arn_us_east_1" {
  description = "ACM certificate ARN (us-east-1 for CloudFront)"
  type        = string
  default     = "arn:aws:acm:us-east-1:123:certificate/abc"
}

variable "index_document" {
  description = "Root document served by CloudFront"
  type        = string
  default     = "index.html"
}
```

**Interview Q**: "Why separate region for cert?" A: CloudFront requires **us-east-1** ACM certs globally.

## 5. main.tf - Core Infrastructure

### locals block (computed values)
```hcl
locals {
  fqdn = "${var.subdomain}.${var.domain_name}"  # terraform.awsithainasready.com
}
```

### S3 Bucket (Private - No Public Access)
```hcl
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.s3_bucket_name
}

# Block ALL public access
resource "aws_s3_bucket_public_access_block" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Upload index.html (in prod: use aws_s3_object)
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/html"
}
```

### CloudFront Origin Access Control (OAC)
```hcl
# Secure S3 access (NEW vs OAI)
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "website-oac"
  description                       = "OAC for S3 website"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name              = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id                = "S3-${var.s3_bucket_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = true
  is_ipv6_enabled    = true
  default_root_object = var.index_document

  aliases = [local.fqdn]  # Custom domain

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${var.s3_bucket_name}"
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"  # Low latency (US/Europe)

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn_us_east_1
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  depends_on = [aws_s3_bucket_public_access_block.website_bucket]
}
```

### S3 Bucket Policy (CloudFront Only)
```hcl
resource "aws_s3_bucket_policy" "website_policy" {
  depends_on = [aws_cloudfront_origin_access_control.oac]
  bucket     = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AllowCloudFrontServicePrincipal"
      Effect    = "Allow"
      Principal = { Service = "cloudfront.amazonaws.com" }
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.website_bucket.arn}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = aws_cloudfront_distribution.cdn.arn
        }
      }
    }]
  })
}
```

### Route53 Subdomain Record
```hcl
data "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "subdomain" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = local.fqdn
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}
```

## 6. outputs.tf - Results

```hcl
output "subdomain_fqdn" {
  description = "FQDN of the project"
  value       = local.fqdn
}

output "cloudfront_domain" {
  description = "CloudFront distribution name"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "s3_bucket_name" {
  description = "S3 bucket used for web content"
  value       = aws_s3_bucket.website_bucket.bucket
}
```

## 7. Deployment Workflow

```
terraform init    # Installs AWS 6.21.1, configures S3 backend
terraform plan    # Uses existing Route53 zone + S3 bucket
terraform apply --auto-approve
terraform output # terraform.awsithainasready.com
```

**Verify**: `https://terraform.awsithainasready.com` → **index.html** ✅

## Common Mistakes & Debug

| Issue                         | Fix                                      |
|-------------------------------|------------------------------------------|
| **"CloudFront invalid cert"** | ACM cert **us-east-1 only**             |
| **"S3 403 Forbidden"**        | Missing OAC + bucket policy             |
| **"Route53 not found"**       | Hosted zone exists (`data` source)      |
| **"State conflict"**          | `terraform init -migrate-state`         |
| **"Variable undefined"**      | VSCode red underline → Add to variables.tf |

**terraform fmt** - Auto-format (prevents syntax errors).

## Production Best Practices

```
# terraform.tfvars (dev/prod)
aws_region           = "ap-south-1"
s3_bucket_name       = "aisite-com-dev"
certificate_arn_us_east_1 = "arn:aws:acm:us-east-1:.../dev-cert"

# modules/website/main.tf (reusable)
module "website" {
  source = "./modules/website"
  env    = "dev"
}
```

**Key Learnings**:
1. **Manual first**: Console → understand S3 OAC → script
2. **Private S3**: Never `acl = "public-read"`
3. **us-east-1 cert**: CloudFront global requirement
4. **Separate files**: versions/provider/backend/variables/main/outputs
5. **Backup state**: S3 versioning + MFA Delete

**Interview Q**: **"OAI vs OAC?"** OAC=newer (SigV4), supports modern S3 policies. OAI=legacy.
