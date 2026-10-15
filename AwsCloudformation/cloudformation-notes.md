# 🏗️ AWS CloudFormation — Complete DevOps Notes (Interview Edition)

> **Level:** 4–6 years DevOps / SRE
> **Style:** Beginner-friendly → Advanced, Interview-ready, with Console UI steps, ASCII flow diagrams, and real production scenarios
> **Prepared for:** AWS DevOps Engineer interview prep

---

# 📋 TABLE OF CONTENTS

1. [What is CloudFormation & How It Works](#1-what-is-cloudformation--how-it-works)
2. [Template Structure (YAML/JSON)](#2-template-structure-yamljson)
3. [Stacks & Stack Lifecycle](#3-stacks--stack-lifecycle)
4. [Parameters, Resources, Outputs, Mappings, Conditions](#4-parameters-resources-outputs-mappings-conditions)
5. [Intrinsic Functions](#5-intrinsic-functions)
6. [Change Sets & Stack Updates](#6-change-sets--stack-updates)
7. [Drift Detection & Remediation](#7-drift-detection--remediation)
8. [Nested Stacks vs StackSets](#8-nested-stacks-vs-stacksets)
9. [Cross-Stack References & Exports](#9-cross-stack-references--exports)
10. [Stack Rollback & Failure Troubleshooting](#10-stack-rollback--failure-troubleshooting)
11. [DeletionPolicy vs UpdateReplacePolicy](#11-deletionpolicy-vs-updatereplacepolicy)
12. [Stack Policies & Termination Protection](#12-stack-policies--termination-protection)
13. [DependsOn & Resource Dependencies](#13-dependson--resource-dependencies)
14. [Custom Resources](#14-custom-resources)
15. [CreationPolicy & WaitCondition](#15-creationpolicy--waitcondition)
16. [Dynamic References, Secrets Manager & SSM](#16-dynamic-references-secrets-manager--ssm)
17. [IAM Roles & Capabilities](#17-iam-roles--capabilities)
18. [Multi-Environment Deployments (Dev/QA/Prod)](#18-multi-environment-deployments-devqaprod)
19. [Multi-Account & Multi-Region Deployments](#19-multi-account--multi-region-deployments)
20. [CI/CD Integration (Jenkins / CodePipeline)](#20-cicd-integration-jenkins--codepipeline)
21. [CloudFormation CLI Commands](#21-cloudformation-cli-commands)
22. [CloudFormation vs Terraform](#22-cloudformation-vs-terraform)
23. [Full Infrastructure Deployment Project](#23-full-infrastructure-deployment-project)
24. [Resource Import](#24-resource-import)
25. [AWS CDK & CloudFormation Relationship](#25-aws-cdk--cloudformation-relationship)
- [Appendix A: CLI Cheat Sheet](#appendix-a-cli-cheat-sheet)
- [Appendix B: Key Numbers & Limits](#appendix-b-key-numbers--limits)
- [Appendix C: Helper Scripts (cfn-init / cfn-signal / cfn-hup)](#appendix-c-helper-scripts)

---
---

# 1. What is CloudFormation & How It Works

## What

**AWS CloudFormation** is AWS's **Infrastructure as Code (IaC)** service. You describe your desired AWS infrastructure in a **template** (YAML or JSON), and CloudFormation provisions and manages those resources for you — in the right order, with dependency handling, and repeatably.

Think of CloudFormation like **Lego instructions**. You write the instruction sheet once; CloudFormation assembles the bricks (EC2, VPC, RDS, IAM) the same way every time, in the correct order.

**Declarative, not imperative:** You declare *what* you want (a VPC with 2 subnets), not *how* to build it (the sequence of API calls). CloudFormation computes the how.

## How It Works — Under the Hood

```
   You write template.yaml
          |
          v
   Submit to CloudFormation (Console / CLI / SDK)
          |
          v
   CloudFormation parses template
          |
          v
   Builds dependency graph (what must come first)
          |
          v
   Calls AWS service APIs in correct order
   (CreateVpc -> CreateSubnet -> RunInstances ...)
          |
          v
   Tracks everything in a STACK
          |
          v
   Resources live + state stored by AWS
```

**Key point vs Terraform:** CloudFormation **stores state for you** (AWS-managed). There is no `terraform.tfstate` file to manage, lock, or store in S3. AWS keeps the record of what's deployed inside the stack itself.

## Why It Matters

| Manual Console Clicks | CloudFormation (IaC) |
|---|---|
| Error-prone, human mistakes | Repeatable, consistent |
| No documentation of what exists | Template IS the documentation |
| Hard to replicate environments | Same template → identical Dev/QA/Prod |
| No version history | Templates in Git — full history, code review |
| Manual rollback | Automatic rollback on failure |
| Slow | Entire environment in minutes |

## AWS Console UI Steps (first-time use)

1. Open **AWS Console** → search **CloudFormation** → open the service.
2. Click **Create stack** → **With new resources (standard)**.
3. Upload a template or use a sample → follow the wizard (detailed in Topic 3).
4. CloudFormation shows the **Stacks** list with live status.

**UI navigation flow:**
```
AWS Console
    |
    v
Search "CloudFormation"
    |
    v
CloudFormation Dashboard
    |
    +--> Stacks        (view/manage deployed stacks)
    +--> StackSets      (multi-account/region)
    +--> Exports        (cross-stack values)
    +--> Designer       (visual template builder)
```

## Real Production Scenario

A company runs identical infrastructure across **dev, staging, and prod** using one template set stored in Git. When a new region launch is needed, they deploy the same templates to `eu-west-1` — the entire VPC, app tier, and database come up in ~15 minutes, identical to `ap-south-1`. No manual clicking, no configuration drift between environments.

**Interview tip:** "CloudFormation is declarative IaC native to AWS. Its biggest operational advantage over Terraform is AWS-managed state — no state file to store, lock, or corrupt. The trade-off is it's AWS-only."

---
---

# 2. Template Structure (YAML/JSON)

## What

A CloudFormation template is a text file with up to **9 top-level sections**. Only **`Resources`** is mandatory.

**YAML vs JSON:** Both valid. YAML is preferred in real work — cleaner, supports comments (`#`), fewer bracket errors. All examples here use YAML.

## The 9 Sections

| Section | Required? | Purpose |
|---|---|---|
| `AWSTemplateFormatVersion` | No | Schema version — always `2010-09-09` |
| `Description` | No | Free-text description |
| `Metadata` | No | Extra info (e.g., console UI grouping) |
| `Parameters` | No | Deploy-time inputs (like variables) |
| `Mappings` | No | Static lookup tables (region → AMI) |
| `Conditions` | No | Create resources only when logic is true |
| `Transform` | No | Macros / SAM for serverless shorthand |
| `Resources` | **Yes** | The actual AWS resources |
| `Outputs` | No | Values returned after creation |

**Mnemonic:** **A D**umb **M**onkey **P**lays **M**usic **C**onsidering **T**he **R**eal **O**utcome
→ **A**WSTemplateFormatVersion, **D**escription, **M**etadata, **P**arameters, **M**appings, **C**onditions, **T**ransform, **R**esources, **O**utputs

## Skeleton Template

```yaml
AWSTemplateFormatVersion: '2010-09-09'

Description: Production web stack

Metadata:
  AWS::CloudFormation::Interface:
    ParameterGroups:
      - Label: { default: "Network Config" }
        Parameters: [VpcCidr]

Parameters:
  InstanceType:
    Type: String
    Default: t3.micro

Mappings:
  RegionAMI:
    ap-south-1: { AMI: ami-0f65f6c2650bf6dd5 }

Conditions:
  IsProd: !Equals [!Ref EnvironmentName, prod]

Transform: AWS::Serverless-2016-10-31   # only for SAM

Resources:                               # MANDATORY
  MyBucket:
    Type: AWS::S3::Bucket

Outputs:
  BucketName:
    Value: !Ref MyBucket
```

## Structure Flow

```
template.yaml
    |
    +-- AWSTemplateFormatVersion  (version tag)
    +-- Description               (what this does)
    +-- Metadata                  (console hints)
    +-- Parameters   --------+    (inputs)
    +-- Mappings     --------+--> referenced by
    +-- Conditions   --------+    Resources
    +-- Transform             
    +-- Resources     <------+    (THE resources - required)
    +-- Outputs               --> returns values out
```

## AWS Console UI Steps (authoring/validating)

1. **CloudFormation Console** → **Create stack** → **With new resources**.
2. Under **Specify template**, choose **Create template in Designer** for a visual drag-and-drop editor, OR
3. **Upload a template file** → select your `.yaml` → the console validates syntax on **Next**.
4. Syntax errors appear immediately in a red banner at the top.

**UI navigation flow:**
```
Create stack
    |
    v
Prepare template --> [Template is ready] or [Create in Designer]
    |
    v
Specify template --> Upload .yaml --> Next
    |
    v
(syntax validated automatically)
```

## Real Production Scenario

A team keeps templates modular — separate files for `network.yaml`, `security.yaml`, `rds.yaml`, `app.yaml`. Each follows the same section order (Parameters → Mappings → Conditions → Resources → Outputs) so any engineer can read any file instantly. A pre-commit hook runs `aws cloudformation validate-template` to catch syntax errors before code review.

**Interview tip:** "Only `Resources` is mandatory. `Transform` is what turns a template into a SAM template for serverless. A common mistake is forgetting `Transform: AWS::Serverless-2016-10-31` when using SAM shorthand."

---
---

# 3. Stacks & Stack Lifecycle

## What is a Stack?

A **stack** is a collection of AWS resources created and managed together as one unit, defined by one template. You operate on the whole group via the stack.

Analogy: template = **shopping list**, stack = **filled cart**. Check out → everything created together. Empty cart → everything deleted together (in correct order).

## Stack Lifecycle States

| Status | Meaning |
|---|---|
| `CREATE_IN_PROGRESS` | Resources being created |
| `CREATE_COMPLETE` | All created successfully |
| `CREATE_FAILED` | Creation failed |
| `ROLLBACK_IN_PROGRESS` | Create failed → deleting what it made |
| `ROLLBACK_COMPLETE` | ⚠️ Dead-end — must **delete** before retry |
| `UPDATE_IN_PROGRESS` | Update being applied |
| `UPDATE_COMPLETE` | Update succeeded |
| `UPDATE_ROLLBACK_IN_PROGRESS` | Update failed → reverting |
| `UPDATE_ROLLBACK_COMPLETE` | Reverted to pre-update state |
| `UPDATE_ROLLBACK_FAILED` | ⚠️ Revert itself failed — manual recovery |
| `DELETE_IN_PROGRESS` | Being deleted |
| `DELETE_COMPLETE` | Gone |
| `DELETE_FAILED` | A resource couldn't delete (e.g., non-empty S3) |

**Gotcha:** `ROLLBACK_COMPLETE` happens when a **brand-new** stack fails on first creation. You **cannot update** out of it — delete and recreate.

## Lifecycle Flow

```
   CREATE STACK
        |
        v
  CREATE_IN_PROGRESS
        |
    +---+---+
    |       |
  success  fail
    |       |
    v       v
CREATE_   ROLLBACK_IN_PROGRESS
COMPLETE       |
    |          v
    |     ROLLBACK_COMPLETE  (delete + recreate only)
    |
    v
  UPDATE STACK --> UPDATE_IN_PROGRESS
    |                   |
    |               +---+---+
    |            success   fail
    |               |       |
    |               v       v
    |          UPDATE_   UPDATE_ROLLBACK_IN_PROGRESS
    |          COMPLETE       |
    |                     +---+---+
    |                  success   fail
    |                     |       |
    |                     v       v
    |         UPDATE_ROLLBACK_  UPDATE_ROLLBACK_FAILED
    |            COMPLETE        (continue-update-rollback)
    v
  DELETE STACK --> DELETE_IN_PROGRESS --> DELETE_COMPLETE
```

## AWS Console UI Steps

**Create:**
1. **CloudFormation Console** → **Create stack** → **With new resources (standard)**.
2. **Prepare template** → **Template is ready**.
3. **Specify template** → **Upload a template file** → choose YAML → **Next**.
4. **Stack name** (e.g., `prod-network-stack`) + fill **Parameters** → **Next**.
5. **Configure stack options** → Tags, IAM role (Permissions), Stack policy, Rollback config → **Next**.
6. **Review** → tick **Capabilities** (e.g., IAM) if prompted → **Submit**.
7. Watch **Events** tab: each resource `CREATE_IN_PROGRESS` → `CREATE_COMPLETE`.

**Update:** Select stack → **Update** → **Replace existing template** → upload → **Next** → **Submit** (or create change set first).

**Delete:** Select stack → **Delete** → confirm → watch Events.

**UI navigation flow:**
```
CloudFormation --> Create stack --> With new resources
    |
    v
Prepare template --> Specify template (upload YAML)
    |
    v
Stack name + Parameters
    |
    v
Stack options (Tags, IAM role, Stack policy, Rollback)
    |
    v
Review + Capabilities checkbox
    |
    v
Submit --> Events tab (monitor CREATE_COMPLETE)
```

## CLI Equivalent

```bash
aws cloudformation create-stack \
  --stack-name prod-network-stack \
  --template-body file://network.yaml \
  --parameters ParameterKey=EnvironmentName,ParameterValue=prod \
  --capabilities CAPABILITY_IAM

aws cloudformation update-stack --stack-name prod-network-stack --template-body file://network.yaml

aws cloudformation delete-stack --stack-name prod-network-stack

aws cloudformation describe-stacks --stack-name prod-network-stack \
  --query "Stacks[0].StackStatus"
```

## Real Production Scenario

A fintech manages infra as **layered stacks** by change frequency + blast radius:

```
prod-network-stack   (VPC, subnets, IGW, NAT)      <- rarely changes
        |
prod-security-stack  (Security Groups, IAM roles)  <- occasional
        |
prod-data-stack      (RDS, ElastiCache)            <- protected, Retain
        |
prod-app-stack       (ALB, ASG, EC2)               <- changes every deploy
```

A daily app deploy can never touch the VPC or delete the DB. The data stack has **termination protection** + `DeletionPolicy: Retain`. On a first-creation failure (`ROLLBACK_COMPLETE`), the runbook: read Events → find `CREATE_FAILED` cause → fix template → **delete dead stack** → recreate.

**Interview tip:** "I split infra into layered stacks by change frequency and blast radius — network, security, data, app. Data stack gets termination protection and `DeletionPolicy: Retain` so a daily app deploy can't endanger the database."

---
---

# 4. Parameters, Resources, Outputs, Mappings, Conditions

## Parameters — Inputs

Deploy-time inputs, like Terraform variables. Turn a one-off template into a reusable one.

```yaml
Parameters:
  EnvironmentName:
    Type: String
    Default: dev
    AllowedValues: [dev, staging, prod]
  InstanceType:
    Type: String
    Default: t3.micro
    AllowedValues: [t3.micro, t3.small, t3.medium]
  DBPassword:
    Type: String
    NoEcho: true          # masks value in console/logs
  KeyName:
    Type: AWS::EC2::KeyPair::KeyName   # AWS-specific type = dropdown + validation
```

Reference: `!Ref EnvironmentName`.
Properties: `Type`, `Default`, `AllowedValues`, `AllowedPattern`, `MinLength`/`MaxLength`, `MinValue`/`MaxValue`, `NoEcho`.

## Resources — The Core (Mandatory)

```yaml
Resources:
  MyVPC:                      # Logical ID (you choose)
    Type: AWS::EC2::VPC       # AWS::Service::Type
    Properties:
      CidrBlock: 10.0.0.0/16
      Tags:
        - Key: Name
          Value: !Sub '${EnvironmentName}-vpc'
```

## Outputs — Return Values

```yaml
Outputs:
  VpcId:
    Description: The VPC ID
    Value: !Ref MyVPC
    Export:
      Name: !Sub '${EnvironmentName}-vpc-id'   # exportable to other stacks
```

## Mappings — Static Lookup Tables

```yaml
Mappings:
  RegionAMIMap:
    ap-south-1: { AMI: ami-0f65f6c2650bf6dd5 }
    us-east-1:  { AMI: ami-0abcdef1234567890 }
```
Lookup: `!FindInMap [RegionAMIMap, !Ref 'AWS::Region', AMI]`
**Limit:** values must be static — no intrinsic functions/parameters inside mapping values.

## Conditions — Conditional Creation

```yaml
Conditions:
  IsProd: !Equals [!Ref EnvironmentName, prod]

Resources:
  ProdNatGateway:
    Type: AWS::EC2::NatGateway
    Condition: IsProd         # only created when prod
    Properties: { ... }
```
Functions: `!Equals`, `!And`, `!Or`, `!Not`, `!If`.

## How They Connect

```
Parameters --(!Ref)-------+
Mappings  --(!FindInMap)--+--> Resources --(!Ref/!GetAtt)--> Outputs
Conditions --(Condition:)-+                                    |
                                                        (Export -> other stacks)
```

## AWS Console UI Steps

1. On **Specify stack details** page, every `Parameter` renders as an input field.
2. `AllowedValues` → shows a **dropdown**.
3. `NoEcho: true` → field masked as `****`.
4. `AWS::EC2::KeyPair::KeyName` type → dropdown of your real key pairs.
5. After creation → **Outputs** tab shows all output values; **Exports** are visible under **CloudFormation → Exports**.

**UI flow:**
```
Specify stack details
    |
    v
Parameters render as form fields
  - String       -> text box
  - AllowedValues-> dropdown
  - NoEcho       -> masked ****
  - AWS:: types  -> validated dropdown
    |
    v
Create --> Outputs tab (view returned values)
```

## Real Production Scenario

One template serves all environments. `dev.params.json` sets `t3.micro`, `prod.params.json` sets `m5.large`. The `IsProd` condition creates NAT Gateway + Multi-AZ RDS only in prod — saving cost in dev. AWS-specific parameter types (`AWS::EC2::VPC::Id`) prevent typo'd IDs by forcing dropdown selection validated against the account.

**Interview tip:** "`NoEcho` masks sensitive params, but the real best practice is dynamic references to Secrets Manager/SSM so the secret never appears in the template or parameters at all. Mappings are static-only — for dynamic AMI lookup use the SSM public parameter type instead."

---
---

# 5. Intrinsic Functions

## What

Built-in functions that resolve values dynamically at deploy time — the glue of every template.

| Function | Does | Example |
|---|---|---|
| `!Ref` | Parameter value OR resource's default ID | `!Ref MyVPC` |
| `!GetAtt` | A specific resource attribute | `!GetAtt WebServer.PublicIp` |
| `!Sub` | String substitution with variables | `!Sub '${EnvironmentName}-vpc'` |
| `!Join` | Concatenate a list into a string | `!Join ['-', [prod, web]]` |
| `!FindInMap` | Lookup in Mappings | `!FindInMap [AMIMap, !Ref 'AWS::Region', AMI]` |
| `!Select` | Pick list item by index | `!Select [0, !GetAZs '']` |
| `!Split` | String → list | `!Split [',', 'a,b,c']` |
| `!GetAZs` | List AZs in region | `!GetAZs ''` |
| `!ImportValue` | Import exported output | `!ImportValue prod-vpc-id` |
| `!If` | Conditional value | `!If [IsProd, m5.large, t3.micro]` |
| `!Base64` | Base64 encode (e.g., UserData) | `!Base64 !Sub '...'` |
| `!Cidr` | Generate CIDR blocks | `!Cidr [10.0.0.0/16, 4, 8]` |

## `!Ref` vs `!GetAtt` (classic question)

- `!Ref` → the resource's **default identifier** (EC2 → Instance ID; S3 → bucket name; Parameter → its value).
- `!GetAtt` → a **named attribute** (`.PublicIp`, `.Arn`, `.DNSName`).

Rule: need the ID → `!Ref`; need any other property → `!GetAtt`.

## `!Sub` Example

```yaml
UserData:
  Fn::Base64: !Sub |
    #!/bin/bash
    echo "Environment: ${EnvironmentName}" > /tmp/env.txt
    echo "Region: ${AWS::Region}" >> /tmp/env.txt
```

## Resolution Flow

```
Deploy time
    |
    v
!Ref MyVPC --------> "vpc-0a1b2c3d"
!GetAtt LB.DNSName -> "my-lb-123.elb.amazonaws.com"
!Sub '${Env}-app' -> "prod-app"
!ImportValue x ----> value exported by another stack
    |
    v
Final concrete values injected into resource properties
```

## AWS Console UI Steps

Intrinsic functions are **template-only** — no direct UI. But you can verify resolved values:
1. After deploy → stack → **Resources** tab shows actual physical IDs (`!Ref` results).
2. **Outputs** tab shows resolved `!GetAtt` / `!Sub` values.
3. **Template** tab → **View in Designer** shows the raw functions.

## Real Production Scenario

A reusable module names every resource with `!Sub '${EnvironmentName}-${AWS::Region}-${AWS::AccountId}-app'` — guaranteeing globally unique, self-documenting names across accounts. EC2 UserData uses `!Base64 !Sub` to inject the environment name and pull the right config from S3 at boot.

**Interview tip:** "`!Ref` on a resource returns its physical ID; `!GetAtt` returns a named attribute. For S3 bucket, `!Ref` gives the name and `!GetAtt Bucket.Arn` gives the ARN. `!Sub` is cleaner than `!Join` for building strings with embedded variables."

---
---

# 6. Change Sets & Stack Updates

## What

A **Change Set** is a *preview* of a stack update — shows resources to be **Added**, **Modified**, **Removed**, and critically which get **Replaced** (destroyed + recreated). Nothing changes until you execute.

**Why it matters:** "Modify" is safe; "Replace" can mean downtime or data loss (e.g., replacing RDS). Change Sets are the safety gate before prod.

## Update Behaviors

| Behavior | Impact |
|---|---|
| **Update with no interruption** | Resource updated in place, no downtime |
| **Update with some interruption** | Brief interruption (e.g., EC2 reboot for instance type change) |
| **Replacement** | ⚠️ Old resource destroyed, new created — new ID, possible data loss |

## AWS Console UI Steps

1. **CloudFormation Console** → **Stacks** → select stack.
2. **Stack actions** → **Create change set for current stack**.
3. **Replace existing template** → upload edited YAML → adjust Parameters → **Next** → **Next** → **Create change set**.
4. Name it (e.g., `add-cw-alarm`) → **Create change set**.
5. Open **Changes** tab → read **Action** (Add/Modify/Remove) and **Replacement** (True/False/Conditional).
6. If `Replacement: True` → ⚠️ investigate before executing.
7. Satisfied → **Execute change set** → watch **Events**.
8. Not satisfied → **Delete change set** (live stack untouched).

**UI flow:**
```
Stacks --> Select stack --> Stack actions --> Create change set
    |
    v
Upload edited YAML --> Create change set
    |
    v
Changes tab -- review Action + Replacement columns
    |
    v
Replacement = True? --yes--> investigate / approval (data loss risk)
    |                 --no--> safe
    v
Execute change set --> Events tab --> UPDATE_COMPLETE
    |
    (or) Delete change set --> stack untouched
```

## CLI Equivalent

```bash
aws cloudformation create-change-set \
  --stack-name my-stack --change-set-name add-cw-alarm \
  --template-body file://template.yaml

aws cloudformation describe-change-set \
  --stack-name my-stack --change-set-name add-cw-alarm   # review

aws cloudformation execute-change-set \
  --stack-name my-stack --change-set-name add-cw-alarm   # apply
```

Note: `aws cloudformation deploy` creates + executes a change set automatically under the hood.

## Real Production Scenario

No prod update goes straight to `deploy`. Jenkins runs `create-change-set`, posts `describe-change-set` output to Slack/PR. A reviewer checks the **Replacement** column; if RDS/EBS shows `Replacement: True`, the pipeline **pauses for manual approval** (new endpoint + data loss risk). On approval, `execute-change-set` runs in the maintenance window. This prevents the classic incident: a property change silently replacing the prod database.

**Interview tip:** "`deploy` auto-creates and executes a change set. For production I create the change set separately so I can review the Replacement column and gate it behind approval before executing."

---
---

# 7. Drift Detection & Remediation

## What

**Drift detection** checks whether resources were **changed manually outside CloudFormation** (console, CLI, another tool). It compares the *actual* live config against the *expected* template config for supported resources.

Analogy: the template is the **blueprint**; drift detection is the **inspection** that flags "someone added a door that isn't on the plans."

## Drift Statuses

| Status | Meaning |
|---|---|
| `IN_SYNC` | Matches template |
| `MODIFIED` | Changed outside CFN |
| `DELETED` | Resource deleted outside CFN |
| `NOT_CHECKED` | Resource type doesn't support drift detection |

## AWS Console UI Steps

1. **CloudFormation Console** → **Stacks** → select stack.
2. **Stack actions** → **Detect drift**.
3. Wait → **Stack actions** → **View drift results**.
4. Overall stack shows `DRIFTED` or `IN_SYNC`.
5. Click a drifted resource → **View drift details** → side-by-side **Expected vs Actual** diff (green/red).

**UI flow:**
```
Stacks --> Select stack --> Stack actions --> Detect drift
    |
    v
(detection runs)
    |
    v
Stack actions --> View drift results
    |
    v
DRIFTED? --> click resource --> View drift details
    |
    v
Expected vs Actual diff (what changed manually)
```

## CLI Equivalent

```bash
aws cloudformation detect-stack-drift --stack-name my-stack
# returns StackDriftDetectionId

aws cloudformation describe-stack-drift-detection-status \
  --stack-drift-detection-id <id>

aws cloudformation describe-stack-resource-drifts \
  --stack-name my-stack --stack-resource-drift-status-filters MODIFIED DELETED
```

## Remediation

CloudFormation does **not** auto-fix drift. To remediate:
1. **Re-apply the template** (update stack) → CFN pushes config back to template state, OR
2. **Update the template** to match the intentional manual change, then redeploy.

## Real Production Scenario

Someone opens SSH (port 22) to `0.0.0.0/0` on a prod Security Group during an incident and forgets to revert. A scheduled **EventBridge rule runs `detect-stack-drift` nightly** across all prod stacks; results feed a Lambda that posts drift to Slack + Security Hub. The on-call sees the SG drift, confirms it's unwanted, and runs a stack update to snap it back to template state — closing the hole.

**Interview tip:** "Drift detection is read-only — it detects, it doesn't fix. I automate nightly drift checks via EventBridge + Lambda and alert on `MODIFIED`/`DELETED`. Remediation is either re-applying the template or updating the template to codify an intentional change. Note: not all resource types support drift detection."

---
---

# 8. Nested Stacks vs StackSets

## Two Different Problems

- **Nested Stacks** → break ONE large template into smaller **reusable child templates** (within one account/region).
- **StackSets** → deploy the SAME stack across **many accounts and/or regions** at once.

## Nested Stacks

A parent template references child templates (stored in S3) via `AWS::CloudFormation::Stack`.

```yaml
Resources:
  NetworkStack:
    Type: AWS::CloudFormation::Stack
    Properties:
      TemplateURL: https://s3.amazonaws.com/mybucket/network.yaml
      Parameters:
        VpcCidr: 10.0.0.0/16

  AppStack:
    Type: AWS::CloudFormation::Stack
    Properties:
      TemplateURL: https://s3.amazonaws.com/mybucket/app.yaml
      Parameters:
        VpcId: !GetAtt NetworkStack.Outputs.VpcId   # pass child output to child
```

```
        PARENT (root) stack
               |
     +---------+---------+
     |         |         |
  Network    App       Data
  child      child     child
  stack      stack     stack
```

**Reusability:** one `vpc.yaml` reused by many projects.

## StackSets

One operation → N accounts × M regions.

```
         Admin / Management Account
                   |
            StackSet definition
                   |
     +-------------+-------------+
     |             |             |
  Account A     Account B     Account C
   (3 regions)   (3 regions)   (3 regions)
     |             |             |
  stack instances created in each
```

**Permission models:** **Self-managed** (you create IAM roles) or **Service-managed** (via AWS Organizations — automatic).

## Comparison

| Feature | Nested Stacks | StackSets |
|---|---|---|
| Purpose | Modularize one big template | Deploy across accounts/regions |
| Scope | Single account + region | Many accounts + many regions |
| Structure | Parent → child templates | StackSet → stack instances |
| Reuse | Reusable components | Standardize org-wide |
| Use case | Big infra split up | Guardrails, security baselines |

## AWS Console UI Steps

**Nested Stack:** deploy the parent like any stack (Topic 3). Child templates must be uploaded to S3 first; parent references their `TemplateURL`.

**StackSet:**
1. **CloudFormation Console** → **StackSets** → **Create StackSet**.
2. Choose **Service-managed** (Organizations) or **Self-managed** permissions.
3. Upload template → **Next**.
4. Set Parameters → **Next**.
5. **Deployment targets** → choose OUs/accounts → select **Regions** → set **rollout** (concurrency, failure tolerance) → **Next**.
6. **Submit** → monitor per-instance status.

**UI flow (StackSet):**
```
StackSets --> Create StackSet
    |
    v
Permissions (Service-managed / Self-managed)
    |
    v
Upload template + Parameters
    |
    v
Targets: OUs / accounts + Regions
    |
    v
Rollout options (concurrency, failure tolerance)
    |
    v
Submit --> per-account/region instance status
```

## CLI

```bash
# Nested: just deploy parent (package first to upload children to S3)
aws cloudformation package --template-file parent.yaml \
  --s3-bucket mybucket --output-template-file packaged.yaml
aws cloudformation deploy --template-file packaged.yaml --stack-name parent

# StackSet
aws cloudformation create-stack-set --stack-set-name security-baseline \
  --template-body file://baseline.yaml --permission-model SERVICE_MANAGED \
  --auto-deployment Enabled=true,RetainStacksOnAccountRemoval=false

aws cloudformation create-stack-instances --stack-set-name security-baseline \
  --deployment-targets OrganizationalUnitIds=ou-xxxx \
  --regions ap-south-1 us-east-1
```

## Real Production Scenario

An org with **10 accounts** enforces a security baseline (CloudTrail on, Config rules, IAM password policy, S3 block public access) using a **Service-managed StackSet** tied to AWS Organizations. New accounts added to the OU get the baseline **auto-deployed**. Meanwhile, within the prod app account, a large template is split into **nested stacks** (network/security/app) for maintainability.

**Interview tip:** "Nested stacks = modularity within one account. StackSets = scale across accounts/regions. For org-wide guardrails I use Service-managed StackSets with auto-deployment so new accounts in the OU inherit the baseline automatically."

---
---

# 9. Cross-Stack References & Exports

## What

Share values between **separate stacks** in the same account/region using `Export` (in Outputs) + `!ImportValue`.

```yaml
# Network stack exports
Outputs:
  VpcId:
    Value: !Ref MyVPC
    Export:
      Name: prod-vpc-id

# App stack imports
Resources:
  AppSubnet:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !ImportValue prod-vpc-id
```

```
  Network Stack                 App Stack
  -----------                   ---------
  Outputs:                      Resources:
   VpcId Export "prod-vpc-id" --> !ImportValue prod-vpc-id
```

## Cross-Stack vs Nested

| | Cross-Stack (Export/Import) | Nested Stacks |
|---|---|---|
| Coupling | Loosely coupled, independent lifecycles | Tightly coupled (one parent) |
| Sharing | Export values account/region-wide | Pass via parameters/outputs |
| Best for | Separate team-owned stacks | One logical app split up |

## Critical Gotcha

**You cannot delete or modify an exported output while another stack imports it.** CloudFormation blocks it to prevent breaking the consumer. To change it: update the consumer first to stop importing, then modify the exporter.

## AWS Console UI Steps

1. **CloudFormation Console** → **Exports** (left nav) → lists all exported values + which stack exports them.
2. Click an export → see **Importing stacks** (who depends on it).
3. Deploy stacks normally; imports resolve automatically if the export exists.

**UI flow:**
```
CloudFormation --> Exports
    |
    v
See all Export Names + exporting stack
    |
    v
Click export --> "Stacks importing this export"
    |
    (cannot delete exporter while importers exist)
```

## Real Production Scenario

The **network team** owns `prod-network-stack` and exports `prod-vpc-id`, `prod-public-subnets`, `prod-private-subnets`. The **app team** owns `prod-app-stack` and imports those — without ever knowing the actual IDs. Teams deploy independently. When the network team needs to change the VPC, the Exports page shows every importing stack, so they coordinate before making breaking changes.

**Interview tip:** "Export/ImportValue is for loosely-coupled stacks owned by different teams. The big gotcha: you can't delete an export that's in use — CloudFormation protects consumers. For values within one app I prefer nested stacks; across teams I use exports."

---
---

# 10. Stack Rollback & Failure Troubleshooting

## What

When a create/update fails, CloudFormation automatically **rolls back** to the last known-good state to avoid half-built infrastructure.

## Failure States & Meaning

| State | What happened | Action |
|---|---|---|
| `CREATE_FAILED` → `ROLLBACK_COMPLETE` | New stack failed first create | Delete + recreate (can't update) |
| `UPDATE_ROLLBACK_COMPLETE` | Update failed, reverted cleanly | Fix template, update again |
| `UPDATE_ROLLBACK_FAILED` | ⚠️ Revert itself failed | `continue-update-rollback` |
| `DELETE_FAILED` | Resource won't delete | Fix dependency, retry delete |

## Common Failure Causes

- Insufficient IAM permissions
- Resource limit reached (e.g., EIP limit, VPC limit)
- Invalid property / bad AMI ID / wrong region
- Dependency not ready (fix with `DependsOn`)
- Non-empty S3 bucket on delete
- Security group still attached to an ENI

## Troubleshooting Flow

```
Stack failed
    |
    v
Open Events tab (scroll to FIRST failure - bottom up)
    |
    v
Read "Status reason" on the CREATE_FAILED / UPDATE_FAILED row
    |
    +--> Permission error?   fix IAM role / capabilities
    +--> Limit error?        request limit increase / clean up
    +--> Bad property?       fix template
    +--> Dependency error?   add DependsOn
    |
    v
UPDATE_ROLLBACK_FAILED?
    |
    v
Fix root cause --> continue-update-rollback
    |           (skip resource ONLY if unavoidable)
    v
UPDATE_ROLLBACK_COMPLETE --> fix template --> update again
```

## Recovering `UPDATE_ROLLBACK_FAILED`

1. **Events tab** → find the resource that failed to roll back and why.
2. Manually fix the underlying issue (e.g., detach SG, empty bucket, fix IAM).
3. Run `continue-update-rollback`.
4. If a specific resource is unrecoverable, skip it: `--resources-to-skip LogicalId` — but this leaves it inconsistent with the template, so use sparingly and reconcile after.

## AWS Console UI Steps

1. Select stack → **Events** tab → scroll to the **earliest** failure (root cause, not the cascade).
2. Read **Status reason** column.
3. For `UPDATE_ROLLBACK_FAILED`: **Stack actions** → **Continue update rollback** → optionally expand **Advanced** → select resources to skip → **Continue update rollback**.

**UI flow:**
```
Stack --> Events tab
    |
    v
Find FIRST *_FAILED row --> read Status reason
    |
    v
Fix root cause (IAM / limit / dependency / property)
    |
    v
UPDATE_ROLLBACK_FAILED? --> Stack actions --> Continue update rollback
    |
    v
(Advanced: skip stuck resource only if needed)
    |
    v
UPDATE_ROLLBACK_COMPLETE
```

## CLI

```bash
aws cloudformation describe-stack-events --stack-name my-stack \
  --query "StackEvents[?ResourceStatus=='CREATE_FAILED']"

aws cloudformation continue-update-rollback --stack-name my-stack
# skip a stuck resource (last resort)
aws cloudformation continue-update-rollback --stack-name my-stack \
  --resources-to-skip MyStuckResource
```

## Real Production Scenario

A prod update fails because a new IAM policy referenced a non-existent resource; rollback then fails because a Lambda-backed custom resource timed out → `UPDATE_ROLLBACK_FAILED`. Runbook: Events tab → identify the custom resource timeout → fix the Lambda → `continue-update-rollback` → reaches `UPDATE_ROLLBACK_COMPLETE` → fix the IAM policy in template → re-run change set.

**Interview tip:** "I always read the Events tab bottom-up to find the FIRST failure — the rest are cascade noise. For `UPDATE_ROLLBACK_FAILED` I fix the root cause then `continue-update-rollback`, and only use `--resources-to-skip` as a last resort because it leaves the resource inconsistent with the template."

---
---

# 11. DeletionPolicy vs UpdateReplacePolicy

## What

Both protect resources from data loss, but trigger on different events.

| Policy | Triggers when... | Controls |
|---|---|---|
| `DeletionPolicy` | Resource removed from stack / stack deleted | What happens to the resource |
| `UpdateReplacePolicy` | An update **replaces** the resource | What happens to the OLD resource |

## Values

- `Delete` (default for most) — remove the resource
- `Retain` — keep the resource (orphaned from stack, not deleted)
- `Snapshot` — take a final snapshot before deleting (RDS, EBS, ElastiCache, Redshift)

```yaml
Resources:
  ProdDatabase:
    Type: AWS::RDS::DBInstance
    DeletionPolicy: Retain             # keep DB if removed from stack
    UpdateReplacePolicy: Snapshot      # snapshot before replacement
    Properties:
      Engine: mysql
      DBInstanceClass: db.r5.large
```

## Flow

```
Resource removed / stack deleted
    |
    v
DeletionPolicy = ?
    Delete   --> resource destroyed
    Retain   --> resource kept (orphaned)
    Snapshot --> final snapshot taken, then deleted

Update requires replacement
    |
    v
UpdateReplacePolicy = ?
    Delete   --> old resource destroyed after new created
    Retain   --> old resource kept
    Snapshot --> old resource snapshotted before removal
```

## AWS Console UI Steps

These are **template-only** attributes — no console toggle. To verify:
1. Stack → **Template** tab → confirm `DeletionPolicy`/`UpdateReplacePolicy` present on critical resources.
2. On stack delete, retained resources remain visible in their service console (e.g., RDS console) after `DELETE_COMPLETE`.

## Real Production Scenario

Every production database and critical S3 bucket carries `DeletionPolicy: Retain` (and RDS additionally `UpdateReplacePolicy: Snapshot`). When an engineer accidentally runs `delete-stack` on the data stack, the RDS instance and S3 data **survive** — only the stack wrapper is removed. For a planned RDS instance-class change that forces replacement, `Snapshot` guarantees a restore point before the swap.

**Interview tip:** "`DeletionPolicy` fires on resource/stack deletion; `UpdateReplacePolicy` fires when an update forces replacement. For prod RDS I set `DeletionPolicy: Retain` + `UpdateReplacePolicy: Snapshot` — together they protect data from both accidental deletion and replacement-triggering updates."

---
---

# 12. Stack Policies & Termination Protection

## Stack Policy — Protect Resources During Updates

A JSON document that controls which resources **can be updated**. By default all resources are updatable; a stack policy can **Deny** updates to critical ones (e.g., prod DB) to prevent accidental replacement.

```json
{
  "Statement": [
    { "Effect": "Allow", "Action": "Update:*", "Principal": "*", "Resource": "*" },
    { "Effect": "Deny", "Action": "Update:Replace", "Principal": "*",
      "Resource": "LogicalResourceId/ProdDatabase" }
  ]
}
```

To update a protected resource, you must temporarily override the policy.

## Termination Protection — Prevent Stack Deletion

A simple on/off flag that **blocks `delete-stack`** entirely. Must be disabled before the stack can be deleted.

## Stack Policy vs Termination Protection

| | Stack Policy | Termination Protection |
|---|---|---|
| Protects against | Updates/replacements of resources | Deletion of the whole stack |
| Granularity | Per-resource | Entire stack |
| Format | JSON policy document | Boolean flag |

## AWS Console UI Steps

**Termination Protection:**
1. Select stack → **Stack actions** → **Edit termination protection** → **Activated** → **Save**.
2. To delete later: disable it first, then **Delete**.

**Stack Policy:**
1. Set during create: **Configure stack options** → **Advanced options** → **Stack policy** → paste JSON / upload.
2. View/edit later: Stack → **Stack actions** → **Edit stack policy** (updating a policy itself may require an override).

**UI flow:**
```
Termination protection:
Stack --> Stack actions --> Edit termination protection --> Activated --> Save

Stack policy:
Create stack --> Configure stack options --> Advanced --> Stack policy (JSON)
   (later) Stack --> Stack actions --> Edit stack policy
```

## CLI

```bash
aws cloudformation update-termination-protection \
  --stack-name prod-data-stack --enable-termination-protection

aws cloudformation set-stack-policy \
  --stack-name prod-data-stack --stack-policy-body file://policy.json
```

## Real Production Scenario

Every prod stack has **termination protection ON**. The data stack additionally carries a **stack policy** denying `Update:Replace` on the RDS logical ID — so even if someone submits a template change that would replace the DB, CloudFormation blocks it until an admin explicitly overrides the policy. Two independent guardrails: one against deletion, one against replacement.

**Interview tip:** "Termination protection stops the whole stack being deleted; stack policy stops specific resources being updated/replaced. On prod I use both — they protect against different mistakes. Deleting is still possible after disabling termination protection, so I pair it with `DeletionPolicy: Retain` for true data safety."

---
---

# 13. DependsOn & Resource Dependencies

## What

CloudFormation auto-detects dependencies when one resource **references** another via `!Ref` or `!GetAtt`, and orders creation accordingly. `DependsOn` adds an **explicit** dependency when there's no reference but order still matters.

## Implicit (preferred)

```yaml
PublicSubnet:
  Type: AWS::EC2::Subnet
  Properties:
    VpcId: !Ref MyVPC    # implicit: VPC created before subnet
```

## Explicit (`DependsOn`)

```yaml
GatewayAttachment:
  Type: AWS::EC2::VPCGatewayAttachment
  Properties:
    VpcId: !Ref MyVPC
    InternetGatewayId: !Ref MyIGW

PublicRoute:
  Type: AWS::EC2::Route
  DependsOn: GatewayAttachment    # route needs IGW *attached* first
  Properties:
    RouteTableId: !Ref PublicRT
    DestinationCidrBlock: 0.0.0.0/0
    GatewayId: !Ref MyIGW
```

## Flow

```
Resource references another (!Ref / !GetAtt)?
    |
   yes --> implicit dependency (auto-ordered)
    |
   no but order matters?
    |
   yes --> add DependsOn: <LogicalId>
    |
    v
CloudFormation builds dependency graph --> creates in order
```

## AWS Console UI Steps

- **Template-only.** To visualize: Stack → **Template** tab → **View in Designer** → Designer draws dependency arrows between resources.

## Real Production Scenario

A classic bug: a public route to `0.0.0.0/0` via an Internet Gateway fails intermittently because the IGW isn't fully *attached* to the VPC yet — there's no property reference forcing the order. Adding `DependsOn: GatewayAttachment` to the route guarantees the attachment completes first, eliminating the race. Similarly, EC2 instances that need a NAT Gateway for bootstrap use `DependsOn` on the NAT.

**Interview tip:** "Prefer implicit dependencies via `!Ref`/`!GetAtt` — they're self-documenting. Use `DependsOn` only when order matters but there's no reference, like a route depending on a VPC-gateway attachment. Over-using `DependsOn` serializes creation and slows deploys."

---
---

# 14. Custom Resources

## What

**Custom Resources** let CloudFormation manage things it doesn't natively support — by invoking a **Lambda function** (or SNS topic) during create/update/delete. Your Lambda does the work and signals success/failure back.

Use cases: look up an AMI dynamically, call a third-party API, run a script, seed a database, fetch data not available as a native resource.

```yaml
Resources:
  AmiLookup:
    Type: Custom::AmiLookup
    Properties:
      ServiceToken: !GetAtt AmiLookupFunction.Arn   # Lambda ARN
      Region: !Ref AWS::Region

  WebServer:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: !GetAtt AmiLookup.Id                 # use custom resource output
      InstanceType: t3.micro
```

## Flow

```
CloudFormation reaches Custom::X
    |
    v
Sends event (Create/Update/Delete) to Lambda (ServiceToken)
    |
    v
Lambda runs your logic
    |
    v
Lambda sends SUCCESS/FAILED + data back to a pre-signed S3 URL
    |
    +-- SUCCESS --> stack continues, outputs available via !GetAtt
    +-- FAILED  --> stack rolls back
    +-- (no response) --> waits up to 1 hour then times out
```

**Critical:** the Lambda **must** send a response (success or failure) to the callback URL, even on error — otherwise the stack hangs until timeout (~1 hour).

## AWS Console UI Steps

- Deploy the stack normally; the custom resource runs automatically during create/update.
- Debug via **Lambda Console** → the function's **CloudWatch Logs** (custom resource failures show here).
- Stack **Events** tab shows `Custom::X` status and any failure reason.

## Real Production Scenario

A template needs the latest hardened "golden AMI" ID, which lives in a DynamoDB table updated by a separate AMI-bake pipeline. A **custom resource Lambda** queries that table at deploy time and returns the current AMI ID, so every deployment picks up the newest approved image without editing the template. The Lambda has robust try/except that always sends a FAILED response on error to avoid hanging the stack.

**Interview tip:** "Custom resources extend CloudFormation to anything via Lambda. The #1 gotcha: the Lambda must always send a response to the callback URL — on success AND failure — or the stack hangs for an hour. Modern alternative for simple lookups is to use SSM public parameters or CloudFormation modules instead."

---
---

# 15. CreationPolicy & WaitCondition

## What

Both make CloudFormation **wait for a success signal** from inside a resource (e.g., app finished installing) before marking it complete — not just "the EC2 API returned."

- **CreationPolicy** — attached to EC2/ASG; waits for N `cfn-signal` calls within a timeout.
- **WaitCondition** — a standalone resource that waits for a signal (more flexible, older pattern).

## CreationPolicy (preferred)

```yaml
WebServer:
  Type: AWS::EC2::Instance
  CreationPolicy:
    ResourceSignal:
      Count: 1
      Timeout: PT10M          # ISO8601: 10 minutes
  Properties:
    ImageId: ami-xxxx
    InstanceType: t3.micro
    UserData:
      Fn::Base64: !Sub |
        #!/bin/bash
        yum install -y httpd
        systemctl start httpd
        # signal success back to CloudFormation
        /opt/aws/bin/cfn-signal -e $? \
          --stack ${AWS::StackName} \
          --resource WebServer \
          --region ${AWS::Region}
```

## Difference vs DependsOn

- `DependsOn` waits for the resource to be **created** (API-level).
- `CreationPolicy`/`WaitCondition` wait for the resource to be **ready** (app-level success signal).

## Flow

```
EC2 launches
    |
    v
UserData runs (install app)
    |
    v
cfn-signal -e 0  (success)  OR  -e 1 (failure)
    |
    v
CreationPolicy counts signals
    |
    +-- Count met before Timeout --> CREATE_COMPLETE
    +-- Timeout first            --> CREATE_FAILED --> rollback
```

## AWS Console UI Steps

- Deploy normally; stack **Events** tab shows the resource in `CREATE_IN_PROGRESS` until signals arrive.
- If it times out, Events shows: *"Failed to receive N resource signal(s) within the specified duration"*.
- Debug by SSHing to the instance and checking `/var/log/cloud-init-output.log`.

## Real Production Scenario

An ASG rollout must not mark instances healthy until the app is actually serving. Each instance's UserData installs the app, runs a health check, then calls `cfn-signal`. The ASG's `CreationPolicy` requires all N instances to signal within `PT15M`. If the app fails to start, no signal arrives, CloudFormation times out and rolls back — preventing a "green" stack sitting on top of dead apps.

**Interview tip:** "`DependsOn` = resource created; `CreationPolicy` + `cfn-signal` = application inside is actually ready. I use CreationPolicy on EC2/ASG so the stack only succeeds once the app signals healthy, not just when the instance boots."

---
---

# 16. Dynamic References, Secrets Manager & SSM

## What

**Dynamic references** pull values from **SSM Parameter Store** or **Secrets Manager** at deploy time — so secrets never sit in the template, parameters, or Git.

## Syntax

```yaml
# SSM plaintext parameter
InstanceType: '{{resolve:ssm:/prod/app/instance-type}}'

# SSM SecureString (encrypted)
ApiKey: '{{resolve:ssm-secure:/prod/app/api-key}}'

# Secrets Manager
MasterUserPassword: '{{resolve:secretsmanager:prod/db/credentials:SecretString:password}}'
```

## Why

| Bad | Good |
|---|---|
| Hardcode password in template | Dynamic reference to Secrets Manager |
| Pass secret as parameter | Secret resolved at deploy, never stored |
| Secret visible in Git/logs | Only the reference string is in Git |

## Flow

```
Deploy time
    |
    v
CloudFormation sees {{resolve:secretsmanager:...}}
    |
    v
Calls Secrets Manager / SSM API
    |
    v
Injects real value into resource (RDS password, etc.)
    |
    v
Secret never written to template, params, or stack events
```

## AWS Console UI Steps

**Store the secret first:**
1. **Secrets Manager Console** → **Store a new secret** → choose type (e.g., RDS credentials) → set key/value → name it `prod/db/credentials` → **Store**.
   OR **Systems Manager** → **Parameter Store** → **Create parameter** → name `/prod/app/api-key` → type **SecureString** → value → **Create**.
2. Reference it in the template via `{{resolve:...}}`.
3. Deploy — CloudFormation resolves at runtime.

**UI flow:**
```
Secrets Manager --> Store a new secret --> name: prod/db/credentials
    |                                            |
SSM --> Parameter Store --> Create (SecureString)|
    |                                            |
    +--------------------+-----------------------+
                         v
         Template: '{{resolve:secretsmanager:...}}'
                         |
                         v
            Deploy --> value resolved at runtime
```

## Real Production Scenario

The RDS stack sets `MasterUserPassword: '{{resolve:secretsmanager:prod/db/credentials:SecretString:password}}'`. The password is generated and rotated by Secrets Manager (30-day rotation), never appears in the template, Git, parameters, or stack events. The app similarly pulls DB creds from Secrets Manager at runtime. IAM ensures only the CFN role and the app role can read the secret.

**Interview tip:** "Dynamic references (`{{resolve:...}}`) keep secrets out of templates and Git. `ssm-secure` and `secretsmanager` handle encrypted values; Secrets Manager adds automatic rotation. Never pass production passwords as parameters even with NoEcho — resolve them dynamically."

---
---

# 17. IAM Roles & Capabilities

## Two IAM Concepts in CloudFormation

1. **Service Role** — the IAM role CloudFormation **assumes** to create resources. Lets you scope what a stack can do (least privilege) independent of the user deploying it.
2. **Capabilities** — an explicit acknowledgement you must pass when a template creates **IAM resources** or uses **macros**.

## Capabilities

| Capability | Required when... |
|---|---|
| `CAPABILITY_IAM` | Template creates IAM resources (roles, policies) |
| `CAPABILITY_NAMED_IAM` | Template creates IAM resources with **custom names** |
| `CAPABILITY_AUTO_EXPAND` | Template uses macros / nested transforms (e.g., SAM) |

Without the right capability, the deploy fails: *"Requires capabilities: [CAPABILITY_IAM]"*.

## Service Role Example

```yaml
# Deploy with a scoped role instead of the user's own permissions
aws cloudformation deploy \
  --template-file app.yaml --stack-name app \
  --role-arn arn:aws:iam::123456789012:role/cfn-deploy-role \
  --capabilities CAPABILITY_NAMED_IAM
```

## Flow

```
Deploy stack
    |
    v
Template creates IAM resources? --yes--> must pass CAPABILITY_IAM
    |                                     (or CAPABILITY_NAMED_IAM if named)
    v
Service role (--role-arn) provided?
    |
   yes --> CFN assumes that role (scoped least-privilege)
    no  --> CFN uses the deploying user's permissions
    |
    v
Resources created within those permissions
```

## AWS Console UI Steps

**Capabilities:**
1. On the final **Review** page, if the template has IAM resources, a blue box appears: *"I acknowledge that AWS CloudFormation might create IAM resources"* → tick it → **Submit**.

**Service Role:**
1. **Configure stack options** → **Permissions** → **IAM role** → select the CFN service role (or leave blank to use your own permissions).

**UI flow:**
```
Configure stack options --> Permissions --> IAM role (service role)
    |
    v
Review page --> [x] acknowledge IAM capability checkbox
    |
    v
Submit
```

## Real Production Scenario

CI/CD never deploys with broad admin. Jenkins assumes a dedicated **`cfn-deploy-role`** scoped to exactly the services the app needs (EC2, ELB, RDS, S3, IAM pass-role). Deploys pass `--role-arn` so even if the Jenkins credentials were broad, the stack can only create what the service role allows — least privilege at the stack level. Templates creating named IAM roles pass `CAPABILITY_NAMED_IAM`.

**Interview tip:** "Capabilities are a safety acknowledgement for IAM-creating templates — `CAPABILITY_IAM`, or `CAPABILITY_NAMED_IAM` for custom-named roles, or `CAPABILITY_AUTO_EXPAND` for SAM/macros. The service role (`--role-arn`) scopes what the stack itself can do, so I give pipelines a least-privilege deploy role rather than relying on the user's permissions."

---
---

# 18. Multi-Environment Deployments (Dev/QA/Prod)

## What

Reuse **one template** across environments by supplying **different parameter files** per environment, each as a **separate stack**.

```
            template.yaml  (one source of truth)
                   |
     +-------------+-------------+
     |             |             |
  dev.params   qa.params    prod.params
  t3.micro     t3.small     m5.large
  count=1      count=2      count=5
     |             |             |
  dev-stack    qa-stack    prod-stack   (isolated stacks)
```

## Parameter Files

```json
// dev.params.json
[
  { "ParameterKey": "EnvironmentName", "ParameterValue": "dev" },
  { "ParameterKey": "InstanceType",    "ParameterValue": "t3.micro" },
  { "ParameterKey": "InstanceCount",   "ParameterValue": "1" }
]
```

```json
// prod.params.json
[
  { "ParameterKey": "EnvironmentName", "ParameterValue": "prod" },
  { "ParameterKey": "InstanceType",    "ParameterValue": "m5.large" },
  { "ParameterKey": "InstanceCount",   "ParameterValue": "5" }
]
```

Combine with **Conditions** (`IsProd`) so prod-only resources (NAT, Multi-AZ RDS) appear only in prod.

## AWS Console UI Steps

1. **Create stack** → upload the **same** template.
2. Name it per environment (`dev-app-stack`, `prod-app-stack`).
3. On **Specify stack details**, enter the environment-specific parameter values.
4. Repeat for each environment — three separate stacks from one template.

**UI flow:**
```
Same template.yaml
    |
    +--> Create stack "dev-app-stack"  (dev params)
    +--> Create stack "qa-app-stack"   (qa params)
    +--> Create stack "prod-app-stack" (prod params)
```

## CLI

```bash
aws cloudformation deploy --template-file app.yaml \
  --stack-name dev-app-stack \
  --parameter-overrides file://dev.params.json

aws cloudformation deploy --template-file app.yaml \
  --stack-name prod-app-stack \
  --parameter-overrides file://prod.params.json
```

## Real Production Scenario

One Git repo holds `app.yaml` + `params/{dev,qa,prod}.json`. The Jenkins pipeline promotes the **same template** dev → qa → prod, changing only the parameter file. Prod uses `m5.large × 5` with Multi-AZ RDS (via `IsProd` condition); dev uses `t3.micro × 1` with single-AZ — identical architecture, right-sized per environment, zero code divergence between environments.

**Interview tip:** "Same template, different parameter files, separate stacks per environment. Conditions gate prod-only resources like NAT and Multi-AZ. This guarantees dev/qa/prod are architecturally identical, eliminating 'works in dev, breaks in prod' drift."

---
---

# 19. Multi-Account & Multi-Region Deployments

## What

Deploy the same stack across many accounts/regions using **StackSets** (see Topic 8). This is the standard for org-wide governance.

## Architecture

```
        Management / Admin account
                   |
            StackSet "security-baseline"
                   |
   +---------------+---------------+---------------+
   |               |               |               |
Account A       Account B       Account C       Account D
 ap-south-1      ap-south-1      ap-south-1      ...
 us-east-1       us-east-1       us-east-1
   |               |               |
 stack instance per (account x region)
```

## Permission Models

| Model | Setup | Best for |
|---|---|---|
| **Self-managed** | You create admin + execution IAM roles in each account | Accounts not in Organizations |
| **Service-managed** | AWS Organizations handles roles automatically | Org-wide, with auto-deploy to new accounts |

## Rollout Controls

- **Max concurrent accounts** — how many deploy at once.
- **Failure tolerance** — how many failures before stopping.
- **Region order** — deploy region-by-region (canary a region first).

## AWS Console UI Steps

1. **CloudFormation Console** → **StackSets** → **Create StackSet**.
2. **Permissions:** Service-managed (Organizations) or Self-managed.
3. Upload template → set Parameters → **Next**.
4. **Deployment targets:** choose OUs/accounts.
5. **Specify regions:** add target regions.
6. **Deployment options:** concurrency, failure tolerance, region order → **Next**.
7. **Submit** → monitor each instance's status (per account/region).

**UI flow:**
```
StackSets --> Create StackSet
    |
    v
Permissions (Service-managed / Self-managed)
    |
    v
Template + Parameters
    |
    v
Targets (OUs/accounts) + Regions
    |
    v
Rollout (concurrency, failure tolerance, region order)
    |
    v
Submit --> grid of account x region status
```

## Real Production Scenario

A company with 10 accounts enforces, via **Service-managed StackSet** tied to Organizations: CloudTrail enabled, AWS Config rules, IAM password policy, S3 account-level block-public-access, and a standard VPC. **Auto-deployment** is on, so any new account added to the OU automatically receives the baseline. Rollout uses failure tolerance = 1 and deploys `us-east-1` first as a canary before fanning out.

**Interview tip:** "Multi-account/region = StackSets. For an Organization I use the Service-managed model with auto-deployment so new accounts inherit the security baseline automatically. I control blast radius with failure tolerance and concurrency, and canary one region before the rest."

---
---

# 20. CI/CD Integration (Jenkins / CodePipeline)

## What

CloudFormation deployments are automated through pipelines — template in Git, validated, change-set previewed, approved, deployed.

## Jenkins Pipeline Flow

```
Git push (template.yaml)
    |
    v
Jenkins: Checkout
    |
    v
validate-template (lint + cfn-lint)
    |
    v
Assume AWS IAM deploy role (STS)
    |
    v
create-change-set
    |
    v
describe-change-set --> print Add/Modify/Remove/Replacement
    |
    v
[PROD] Manual approval gate
    |
    v
execute-change-set
    |
    v
Wait for UPDATE_COMPLETE / verify
```

## Jenkinsfile (sketch)

```groovy
pipeline {
  agent any
  stages {
    stage('Validate') {
      steps { sh 'aws cloudformation validate-template --template-body file://template.yaml' }
    }
    stage('Lint') { steps { sh 'cfn-lint template.yaml' } }
    stage('Change Set') {
      steps {
        sh '''aws cloudformation create-change-set \
          --stack-name prod-app --change-set-name cs-${BUILD_NUMBER} \
          --template-body file://template.yaml \
          --capabilities CAPABILITY_NAMED_IAM'''
        sh 'aws cloudformation describe-change-set --stack-name prod-app --change-set-name cs-${BUILD_NUMBER}'
      }
    }
    stage('Approve') { steps { input message: 'Deploy to PROD?' } }
    stage('Execute') {
      steps { sh 'aws cloudformation execute-change-set --stack-name prod-app --change-set-name cs-${BUILD_NUMBER}' }
    }
  }
}
```

## CodePipeline Flow

```
Source (CodeCommit/GitHub)
    |
    v
Build (CodeBuild: validate + cfn-lint + package)
    |
    v
Deploy (CloudFormation action: CREATE_CHANGE_SET)
    |
    v
Manual Approval
    |
    v
Deploy (CloudFormation action: EXECUTE_CHANGE_SET)
```

## AWS Console UI Steps (CodePipeline)

1. **CodePipeline Console** → **Create pipeline**.
2. **Source:** CodeCommit/GitHub → select repo/branch.
3. **Build:** CodeBuild project (runs `validate-template`, `cfn-lint`, `package`).
4. **Deploy:** add action → provider **AWS CloudFormation** → action mode **Create or replace a change set** → point at template artifact.
5. Add a **Manual approval** stage.
6. Add a second CloudFormation action → mode **Execute a change set** → **Create pipeline**.

**UI flow:**
```
CodePipeline --> Create pipeline
    |
    v
Source (repo/branch)
    |
    v
Build (CodeBuild: validate/lint/package)
    |
    v
Deploy action: CREATE_CHANGE_SET
    |
    v
Manual approval stage
    |
    v
Deploy action: EXECUTE_CHANGE_SET
```

## Real Production Scenario

Every infra change is a PR to the IaC repo. Merge triggers Jenkins: `validate-template` + `cfn-lint` → assume the scoped `cfn-deploy-role` via STS → `create-change-set` → the change set (with Replacement column) is posted to Slack → a senior approves in the Jenkins `input` gate during the maintenance window → `execute-change-set`. Dev/QA auto-deploy without approval; only prod has the gate.

**Interview tip:** "My pipeline always: validate → lint → create-change-set → review Replacement → manual approval for prod → execute. The change set is the review artifact. Pipelines assume a scoped deploy role via STS, never long-lived admin keys, and only prod has an approval gate."

---
---

# 21. CloudFormation CLI Commands

## Core Commands

```bash
# Validate syntax
aws cloudformation validate-template --template-body file://template.yaml

# Create / update via change set (recommended, idempotent)
aws cloudformation deploy --template-file template.yaml \
  --stack-name my-stack \
  --parameter-overrides EnvironmentName=prod \
  --capabilities CAPABILITY_NAMED_IAM

# Low-level create / update
aws cloudformation create-stack --stack-name my-stack --template-body file://template.yaml
aws cloudformation update-stack --stack-name my-stack --template-body file://template.yaml

# Inspect
aws cloudformation describe-stacks --stack-name my-stack
aws cloudformation describe-stack-events --stack-name my-stack
aws cloudformation list-stack-resources --stack-name my-stack
aws cloudformation get-template --stack-name my-stack

# Change sets
aws cloudformation create-change-set --stack-name my-stack --change-set-name cs1 --template-body file://template.yaml
aws cloudformation describe-change-set --stack-name my-stack --change-set-name cs1
aws cloudformation execute-change-set --stack-name my-stack --change-set-name cs1

# Drift
aws cloudformation detect-stack-drift --stack-name my-stack
aws cloudformation describe-stack-resource-drifts --stack-name my-stack

# Rollback recovery
aws cloudformation continue-update-rollback --stack-name my-stack

# Package (upload nested templates/Lambda code to S3)
aws cloudformation package --template-file parent.yaml --s3-bucket mybucket --output-template-file packaged.yaml

# Delete
aws cloudformation delete-stack --stack-name my-stack

# Wait for completion (great in scripts/pipelines)
aws cloudformation wait stack-create-complete --stack-name my-stack
aws cloudformation wait stack-update-complete --stack-name my-stack
```

## `deploy` vs `create-stack`/`update-stack`

| `deploy` | `create-stack` / `update-stack` |
|---|---|
| One command for create OR update | Separate commands |
| Uses change sets internally | Direct apply |
| Idempotent, pipeline-friendly | More granular control |
| No error if no changes | `update-stack` errors on "No updates" |

**Interview tip:** "`aws cloudformation deploy` is the modern, idempotent command — it figures out create vs update, uses change sets internally, and doesn't error when there are no changes. `wait` commands are essential in pipelines to block until a stack reaches a terminal state before the next stage."

---
---

# 22. CloudFormation vs Terraform

| Aspect | CloudFormation | Terraform |
|---|---|---|
| Vendor | AWS-only | Multi-cloud + many providers |
| Language | YAML / JSON | HCL |
| State | **AWS-managed** (no state file) | Self-managed (`tfstate`, needs S3+lock) |
| Modularity | Nested stacks, StackSets | Modules, workspaces |
| Drift detection | Built-in (`detect-stack-drift`) | `terraform plan` shows drift |
| Preview changes | Change Sets | `terraform plan` |
| Rollback | Automatic on failure | No auto-rollback (manual) |
| Secrets | Dynamic references (SSM/Secrets Mgr) | Vault, SSM, variables |
| Multi-account/region | StackSets | Providers + workspaces/automation |
| Extensibility | Custom resources (Lambda) | Providers, external data sources |
| Cost | Free (pay for resources) | Free OSS (pay for Cloud/Enterprise tiers) |

## When to Choose Which

- **CloudFormation:** AWS-only shop, want native integration, no state management, tight AWS service support on day one.
- **Terraform:** Multi-cloud, want one tool across AWS/Azure/GCP + SaaS, prefer HCL, want a large module ecosystem.

## Flow Comparison

```
CloudFormation:  template.yaml --> CFN (manages state) --> AWS resources
Terraform:       main.tf --> terraform plan --> apply --> tfstate (you manage) --> resources
```

**Interview tip:** "Biggest practical differences: CloudFormation is AWS-only with AWS-managed state and automatic rollback; Terraform is multi-cloud with self-managed state and no auto-rollback. Change Sets ≈ `terraform plan`. I'd pick CloudFormation for pure-AWS with deep native integration, Terraform when I need multi-cloud or a shared tool across providers."

---
---

# 23. Full Infrastructure Deployment Project

## Scenario

Deploy a complete 2-tier web app: **VPC → public/private subnets → IGW/NAT → ALB → ASG (EC2) → RDS** — the CloudFormation equivalent of your Terraform VPC+ALB example.

## Architecture

```
Internet
   |
   v
Internet Gateway
   |
   v
Public Subnets (1a, 1b) ---- ALB ---- NAT Gateway
                               |
                               v
Private Subnets (1a, 1b) -- ASG (EC2 web servers)
                               |
                               v
Private DB Subnets (1a,1b) -- RDS (Multi-AZ, Retain)
```

## Layered Stack Approach (recommended)

```
network.yaml  --> exports VpcId, subnet IDs
     |
security.yaml --> imports VpcId, exports SG IDs
     |
data.yaml     --> imports subnet+SG, RDS (Retain/Snapshot)
     |
app.yaml      --> imports everything, ALB+ASG
```

## Deployment Order Flow

```
1. deploy network-stack   (VPC, subnets, IGW, NAT)        [exports]
        |
2. deploy security-stack  (ALB-SG, App-SG, DB-SG)         [imports VpcId]
        |
3. deploy data-stack      (RDS Multi-AZ, Retain+Snapshot) [imports subnets/SG]
        |
4. deploy app-stack       (ALB, TG, Launch Template, ASG) [imports all]
        |
        v
   Outputs: ALB DNS name --> hit in browser
```

## AWS Console UI Steps

1. Create `network-stack` first (exports subnet/VPC IDs) → wait `CREATE_COMPLETE`.
2. Create `security-stack` (imports VPC) → wait.
3. Create `data-stack` (RDS) → **Configure stack options** → enable **Termination protection** → wait.
4. Create `app-stack` (ALB+ASG) → on **Review**, acknowledge IAM capability → **Submit**.
5. `app-stack` **Outputs** tab → copy **ALB DNS name** → open in browser.

## CLI (full order)

```bash
aws cloudformation deploy --template-file network.yaml --stack-name prod-network
aws cloudformation deploy --template-file security.yaml --stack-name prod-security
aws cloudformation deploy --template-file data.yaml --stack-name prod-data \
  --parameter-overrides DBPassword='{{resolve:secretsmanager:prod/db:SecretString:password}}'
aws cloudformation deploy --template-file app.yaml --stack-name prod-app \
  --capabilities CAPABILITY_NAMED_IAM
aws cloudformation describe-stacks --stack-name prod-app \
  --query "Stacks[0].Outputs[?OutputKey=='ALBDnsName'].OutputValue" --output text
```

## Real Production Scenario

This is the standard layered production pattern: network rarely changes, data is protected, the app stack redeploys daily via CI/CD. The ASG uses a `CreationPolicy` with `cfn-signal` so the stack only succeeds when instances are serving. RDS uses `DeletionPolicy: Retain` + `UpdateReplacePolicy: Snapshot`, credentials via Secrets Manager dynamic reference. The ALB DNS is exported for Route 53 alias records in a separate DNS stack.

**Interview tip:** "I deploy in dependency order as layered stacks: network → security → data → app, using exports/imports between them. The data stack is protected (Retain + Snapshot + termination protection), the app stack redeploys daily. ASG uses CreationPolicy + cfn-signal so success means the app is actually healthy."

---
---

# 24. Resource Import

## What

Bring **existing AWS resources** (created manually or by another tool) **under CloudFormation management** without recreating them — so you can manage them as IaC going forward.

## Requirements

- The resource type must support import.
- You need a template describing the resource **matching its current config**.
- Each resource needs a `DeletionPolicy` (required during import).
- You supply the resource's **physical ID** to map it.

## Import Flow

```
Existing resource (manual S3 bucket)
    |
    v
Write template block with DeletionPolicy + matching properties
    |
    v
Create import change set (--change-set-type IMPORT)
    |
    v
Provide physical ID mapping (bucket name)
    |
    v
Execute --> resource now tracked in stack
    |
    v
(recommended) detect-stack-drift to confirm template matches reality
```

## AWS Console UI Steps

1. **CloudFormation Console** → **Create stack** → **With existing resources (import resources)**.
2. Upload a template describing the existing resource (with `DeletionPolicy`).
3. **Identify resources** → enter the physical ID (e.g., bucket name, instance ID).
4. Review the import change set → **Import resources**.
5. After import → run **Detect drift** to confirm template matches actual config.

**UI flow:**
```
Create stack --> With existing resources (import resources)
    |
    v
Upload template (resource + DeletionPolicy)
    |
    v
Identify resources (enter physical IDs)
    |
    v
Review import change set --> Import resources
    |
    v
Detect drift (confirm match)
```

## CLI

```bash
aws cloudformation create-change-set \
  --stack-name import-demo --change-set-name import-cs \
  --change-set-type IMPORT \
  --resources-to-import file://resources-to-import.json \
  --template-body file://template.yaml

aws cloudformation execute-change-set --stack-name import-demo --change-set-name import-cs
```

## Real Production Scenario

A legacy prod S3 bucket and RDS instance were created manually years ago. To bring them under IaC governance (for compliance + consistency), the team writes templates matching the current config, imports them with `DeletionPolicy: Retain`, then runs drift detection to confirm the template is accurate — mirroring the `terraform import` workflow in your Terraform notes.

**Interview tip:** "Import brings existing resources under CloudFormation without recreating them — essential for legacy infra. The template must match current config and every imported resource needs a DeletionPolicy. I always run drift detection right after import to confirm the template matches reality before making changes."

---
---

# 25. AWS CDK & CloudFormation Relationship

## What

**AWS CDK (Cloud Development Kit)** lets you define infrastructure in **real programming languages** (TypeScript, Python, Java, Go, C#). CDK code **synthesizes** into a CloudFormation template, which CloudFormation then deploys.

**Key relationship:** CDK is a higher-level abstraction **on top of** CloudFormation. CloudFormation is still the engine doing the actual provisioning.

```
CDK code (Python/TS)
    |
   cdk synth
    |
    v
CloudFormation template (generated)
    |
   cdk deploy  (uses CloudFormation under the hood)
    |
    v
CloudFormation Stack --> AWS resources
```

## CDK Example (Python)

```python
from aws_cdk import Stack, aws_s3 as s3
from constructs import Construct

class MyStack(Stack):
    def __init__(self, scope: Construct, id: str, **kwargs):
        super().__init__(scope, id, **kwargs)
        s3.Bucket(self, "MyBucket", versioned=True)   # ~ 20 lines of YAML, one line here
```

## CDK vs Raw CloudFormation

| | CDK | Raw CloudFormation |
|---|---|---|
| Language | TS/Python/Java/Go/C# | YAML/JSON |
| Abstraction | High (constructs, loops, logic) | Low (declarative) |
| Reuse | Classes, npm/pip packages | Nested stacks |
| Output | Synthesizes to CFN template | IS the template |
| Learning curve | Need programming | Just YAML |

## Key CDK Commands

```bash
cdk init app --language python   # new project
cdk synth                        # generate CloudFormation template
cdk diff                         # like a change set preview
cdk deploy                       # deploy via CloudFormation
cdk destroy                      # delete the stack
```

## AWS Console UI Steps

- CDK is CLI/code-first; there's no "CDK console." But after `cdk deploy`, the result **appears in the CloudFormation Console as a normal stack** — you manage/monitor/rollback it there exactly like any CFN stack.
- `cdk synth` output can be viewed and even uploaded manually to the CloudFormation console if desired.

## Real Production Scenario

A team with strong developers uses **CDK in TypeScript** to express complex, repetitive infra (dozens of near-identical microservice stacks) using loops and classes — impossible to keep DRY in raw YAML. CDK synthesizes to CloudFormation, so they still get CFN's managed state, change sets, and rollback. Ops teams monitor the resulting stacks in the CloudFormation console as usual.

**Interview tip:** "CDK is not a replacement for CloudFormation — it generates CloudFormation. You write TypeScript/Python, run `cdk synth` to get a template, and `cdk deploy` provisions it through CloudFormation. You still get managed state, change sets (`cdk diff`), and rollback. CDK shines when you need loops, conditionals, and real code reuse that YAML can't express cleanly."

---
---

# Appendix A: CLI Cheat Sheet

```bash
# Validate
aws cloudformation validate-template --template-body file://t.yaml

# Deploy (create or update, idempotent)
aws cloudformation deploy --template-file t.yaml --stack-name s \
  --parameter-overrides K=V --capabilities CAPABILITY_NAMED_IAM

# Inspect
aws cloudformation describe-stacks --stack-name s
aws cloudformation describe-stack-events --stack-name s
aws cloudformation list-stack-resources --stack-name s

# Change sets
aws cloudformation create-change-set  --stack-name s --change-set-name c --template-body file://t.yaml
aws cloudformation describe-change-set --stack-name s --change-set-name c
aws cloudformation execute-change-set  --stack-name s --change-set-name c

# Drift
aws cloudformation detect-stack-drift --stack-name s
aws cloudformation describe-stack-resource-drifts --stack-name s

# Rollback recovery
aws cloudformation continue-update-rollback --stack-name s

# Protection
aws cloudformation update-termination-protection --stack-name s --enable-termination-protection
aws cloudformation set-stack-policy --stack-name s --stack-policy-body file://policy.json

# Package + StackSets + Import + Wait
aws cloudformation package --template-file p.yaml --s3-bucket b --output-template-file out.yaml
aws cloudformation create-stack-set --stack-set-name ss --template-body file://t.yaml --permission-model SERVICE_MANAGED
aws cloudformation wait stack-create-complete --stack-name s

# Delete
aws cloudformation delete-stack --stack-name s
```

---

# Appendix B: Key Numbers & Limits

| Fact | Value |
|---|---|
| Template format version | `2010-09-09` (only valid value) |
| Max template size (local) | 1 MB (51,200 bytes inline in API; up to 1 MB via S3) |
| Max template size (S3) | 1 MB |
| Max resources per template | 500 |
| Max parameters per template | 200 |
| Max outputs per template | 200 |
| Max mappings per template | 200 |
| Custom resource response timeout | ~1 hour (if Lambda never signals) |
| CreationPolicy timeout format | ISO8601 (e.g., `PT15M` = 15 min) |
| Stacks per region (soft limit) | 2,000 |
| Only mandatory template section | `Resources` |
| Dead-end state | `ROLLBACK_COMPLETE` (delete + recreate) |
| Capability for named IAM | `CAPABILITY_NAMED_IAM` |
| Capability for SAM/macros | `CAPABILITY_AUTO_EXPAND` |

---

# Appendix C: Helper Scripts

Pre-installed on Amazon Linux AMIs for bootstrapping EC2 inside CloudFormation.

| Script | Purpose |
|---|---|
| `cfn-init` | Reads `AWS::CloudFormation::Init` metadata → installs packages, writes files, starts services |
| `cfn-signal` | Signals success/failure back to a CreationPolicy / WaitCondition |
| `cfn-hup` | Daemon that detects metadata changes and re-runs `cfn-init` (config updates without replacement) |
| `cfn-get-metadata` | Fetches a resource's metadata on the instance |

```yaml
WebServer:
  Type: AWS::EC2::Instance
  Metadata:
    AWS::CloudFormation::Init:
      config:
        packages:
          yum: { httpd: [] }
        files:
          /var/www/html/index.html:
            content: "<h1>Hello from cfn-init</h1>"
        services:
          sysvinit:
            httpd: { enabled: true, ensureRunning: true }
  CreationPolicy:
    ResourceSignal: { Count: 1, Timeout: PT10M }
  Properties:
    UserData:
      Fn::Base64: !Sub |
        #!/bin/bash
        /opt/aws/bin/cfn-init -v --stack ${AWS::StackName} --resource WebServer --region ${AWS::Region}
        /opt/aws/bin/cfn-signal -e $? --stack ${AWS::StackName} --resource WebServer --region ${AWS::Region}
```

**Interview tip:** "`cfn-init` applies the `AWS::CloudFormation::Init` metadata (declarative bootstrap), `cfn-signal` reports readiness to CreationPolicy, and `cfn-hup` watches for metadata changes to apply config updates without replacing the instance. This is the clean alternative to cramming everything into UserData."

---

> ✅ **All 25 EPAM checklist topics covered — basic to advanced — with console UI steps, flow diagrams, CLI, and production scenarios.**
> 📄 See `cloudformation-interview-questions.md` for the Q&A + scenario solutions + practical YAML templates.
