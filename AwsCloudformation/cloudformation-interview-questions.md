# 🎯 AWS CloudFormation — Interview Questions & Solutions

> **Companion to:** `cloudformation-notes.md`
> **Level:** 4–6 years DevOps / SRE (EPAM-style)
> **Contents:** 15 core Q&A (expanded) → 5 production scenarios (full solutions) → 12 extra high-probability questions → 5 practical YAML templates

---

# 📋 TABLE OF CONTENTS

- [Part 1 — Core 15 Questions (Expanded)](#part-1--core-15-questions-expanded)
- [Part 2 — Production Scenarios (Full Solutions)](#part-2--production-scenarios-full-solutions)
- [Part 3 — Extra High-Probability Questions](#part-3--extra-high-probability-questions)
- [Part 4 — Practical YAML Templates](#part-4--practical-yaml-templates)
  - [T1: EC2 with Parameters, Security Group, User Data](#t1-ec2-with-parameters-security-group--user-data)
  - [T2: VPC with Public/Private Subnets, Route Tables, Gateways](#t2-vpc-with-publicprivate-subnets-route-tables-gateways)
  - [T3: S3 with Encryption, Versioning, Lifecycle](#t3-s3-with-encryption-versioning--lifecycle)
  - [T4: ALB + Target Group + ASG + Launch Template](#t4-alb--target-group--asg--launch-template)
  - [T5: IAM Role (Least Privilege) attached to EC2](#t5-iam-role-least-privilege-attached-to-ec2)
- [Part 5 — Rapid-Fire One-Liners](#part-5--rapid-fire-one-liners)

---
---

# Part 1 — Core 15 Questions (Expanded)

### Q1. What is AWS CloudFormation?

**Answer:** CloudFormation is AWS's Infrastructure as Code (IaC) service. You describe infrastructure (EC2, VPC, S3, IAM, load balancers) in a YAML or JSON **template**, and CloudFormation provisions and manages those resources automatically, in the correct dependency order.

**Why it's used:** It replaces error-prone manual console work with repeatable, version-controlled, self-documenting infrastructure. One template produces identical environments every time.

**Production angle:** We store templates in Git, deploy them through CI/CD, and get consistent dev/qa/prod environments. AWS manages the state for us — unlike Terraform, there's no state file to store or lock.

---

### Q2. What is a CloudFormation Stack?

**Answer:** A stack is a collection of AWS resources created and managed together as a single unit, defined by one template. You create, update, and delete all those resources by operating on the stack.

**Why it's used:** It groups related resources so their lifecycle is managed together — deploy as one, delete as one, roll back as one.

**Production angle:** We split infrastructure into **layered stacks** by change frequency and blast radius: network → security → data → app. A daily app deployment can't accidentally touch the VPC or delete the database.

---

### Q3. What are the main sections of a CloudFormation template?

**Answer:**
- **Parameters** — deploy-time inputs
- **Resources** — the AWS resources (the only mandatory section)
- **Outputs** — values returned after deployment
- **Mappings** — static lookup tables (e.g., region → AMI)
- **Conditions** — logic to create resources only when true
- **Metadata** — extra info (e.g., console UI grouping)
- Plus `AWSTemplateFormatVersion`, `Description`, `Transform`

**Why it's used:** This structure separates inputs, logic, resources, and outputs cleanly.

**Production angle:** Every template in our repo follows the same section order so any engineer can read any file instantly. `Transform: AWS::Serverless-2016-10-31` turns it into a SAM template for serverless.

---

### Q4. What are intrinsic functions?

**Answer:** Built-in functions that resolve values dynamically at deploy time:
- `!Ref` — parameter value or a resource's default ID
- `!GetAtt` — a specific attribute of a resource (e.g., `.PublicIp`, `.Arn`)
- `!Sub` — string substitution with variables
- `!Join` — concatenate strings
- `!ImportValue` — import an exported value from another stack
- `!FindInMap`, `!Select`, `!GetAZs`, `!If`, `!Base64`

**Why it's used:** Templates can't hardcode IDs that don't exist until deploy time — intrinsic functions wire resources together dynamically.

**`!Ref` vs `!GetAtt`:** `!Ref` returns the default identifier (EC2 → instance ID); `!GetAtt` returns a named attribute (`WebServer.PublicIp`). Need the ID → `!Ref`; need another property → `!GetAtt`.

---

### Q5. What is a Change Set?

**Answer:** A Change Set is a preview of a stack update — it shows which resources will be **Added**, **Modified**, **Removed**, and critically which will be **Replaced** (destroyed and recreated). Nothing changes until you execute it.

**Why it's used:** "Modify" is safe; "Replace" can mean downtime or data loss (e.g., replacing RDS creates a new endpoint). The change set is the safety gate before touching production.

**Production angle:** Our pipeline runs `create-change-set`, posts the output to Slack, and if the **Replacement** column shows `True` on an RDS or EBS resource, it pauses for manual approval before `execute-change-set`. This prevents a property change silently replacing the prod database.

---

### Q6. What is drift detection?

**Answer:** Drift detection checks whether resources were changed manually outside CloudFormation (via console, CLI, or another tool). It compares the actual live configuration against the expected template configuration for supported resource types.

**Why it's used:** Manual "quick fixes" during incidents create drift — the live infra no longer matches the IaC. Drift detection surfaces this.

**Production angle:** We run `detect-stack-drift` nightly via an EventBridge rule across all prod stacks; results feed a Lambda that alerts to Slack and Security Hub. Example: someone opens SSH to 0.0.0.0/0 on a prod SG during an incident — drift detection flags it, and we remediate by re-applying the template. Note: drift detection only detects; it doesn't auto-fix.

---

### Q7. Difference between Nested Stacks and StackSets?

**Answer:**
- **Nested Stacks** break one large template into smaller reusable child templates — within a single account/region.
- **StackSets** deploy the same stack across multiple AWS accounts and/or regions.

**Why it's used:** Nested stacks = modularity and reuse. StackSets = org-wide standardization at scale.

**Production angle:** We use a **Service-managed StackSet** tied to AWS Organizations to push a security baseline (CloudTrail, Config rules, S3 block-public-access) to all 10 accounts, with auto-deployment so new accounts inherit it. Inside the app account, we use nested stacks to modularize network/security/app.

---

### Q8. What happens when a CloudFormation update fails?

**Answer:** CloudFormation automatically rolls back to the last known-good state to avoid half-built infrastructure. If the rollback itself fails, the stack enters `UPDATE_ROLLBACK_FAILED`, which needs manual recovery.

**Why it matters:** Auto-rollback means a failed update doesn't leave prod in a broken, half-applied state.

**Production angle:** We read the **Events tab bottom-up** to find the FIRST failure (the root cause — the rest is cascade noise), fix it, and retry.

---

### Q9. How do you troubleshoot `UPDATE_ROLLBACK_FAILED`?

**Answer:**
1. Open the **Events tab**, find the resource that failed to roll back and the status reason.
2. Fix the underlying issue (e.g., detach a security group, empty an S3 bucket, fix an IAM policy, repair a timed-out custom-resource Lambda).
3. Run `aws cloudformation continue-update-rollback`.
4. Only if a specific resource is unrecoverable, skip it with `--resources-to-skip LogicalId` — but this leaves the resource inconsistent with the template, so reconcile afterward.

**Production angle:** Common cause is a Lambda-backed custom resource that timed out. We fix the Lambda, then `continue-update-rollback`, reaching `UPDATE_ROLLBACK_COMPLETE`, then fix the template and re-run the change set. Resource skipping is a last resort.

---

### Q10. Difference between DeletionPolicy and UpdateReplacePolicy?

**Answer:**
- **`DeletionPolicy`** controls what happens when a resource is removed from the stack or the stack is deleted.
- **`UpdateReplacePolicy`** controls what happens to the OLD resource when an update forces replacement.
- Values: `Delete` (default), `Retain`, `Snapshot`.

**Why it's used:** To protect stateful resources (databases, buckets) from accidental data loss.

**Production angle:** Every prod RDS carries `DeletionPolicy: Retain` + `UpdateReplacePolicy: Snapshot`. If someone deletes the stack, the DB survives (Retain). If an update forces replacement (e.g., instance-class change), a snapshot is taken first (Snapshot). Two different triggers, both protected.

---

### Q11. How does CloudFormation handle resource dependencies?

**Answer:** CloudFormation auto-detects dependencies when resources reference each other with `!Ref` or `!GetAtt`, and orders creation accordingly (implicit dependencies). When there's no reference but order still matters, use `DependsOn` for an explicit dependency.

**Why it's used:** Resources must be created in the right order (VPC before subnet, IGW attached before route).

**Production angle:** A public route to 0.0.0.0/0 via an IGW can fail intermittently because the IGW isn't fully attached yet — there's no property reference forcing order. We add `DependsOn: GatewayAttachment` to the route to eliminate the race. We prefer implicit dependencies and use `DependsOn` sparingly since it serializes creation.

---

### Q12. How do you deploy CloudFormation through Jenkins?

**Answer:** Store the template in Git. Jenkins: checks out the code → validates (`validate-template` + `cfn-lint`) → assumes a scoped AWS IAM deploy role via STS → creates a change set → (for prod) pauses at a manual approval gate → executes the change set.

**Why it's used:** Automated, auditable, gated deployments with no manual console work and no long-lived admin keys.

**Production angle:** Dev/QA auto-deploy; only prod has the approval gate. The change set (with the Replacement column) is the review artifact posted to Slack. Jenkins uses a least-privilege `cfn-deploy-role`, not broad admin credentials.

---

### Q13. How do you manage multiple environments?

**Answer:** Reuse the same template with different **parameter files** (`dev.json`, `qa.json`, `prod.json`), each deployed as a **separate stack**. Combine with **Conditions** so prod-only resources (NAT, Multi-AZ RDS) appear only in prod.

**Why it's used:** Guarantees dev/qa/prod are architecturally identical, right-sized per environment, with zero code divergence.

**Production angle:** One repo holds `app.yaml` + `params/{dev,qa,prod}.json`. The pipeline promotes the same template through environments, changing only the parameter file. Prod = `m5.large × 5` + Multi-AZ; dev = `t3.micro × 1` + single-AZ, all via the `IsProd` condition.

---

### Q14. How do you manage secrets in CloudFormation?

**Answer:** Use **dynamic references** to AWS Secrets Manager or SSM Parameter Store instead of hardcoding — e.g., `'{{resolve:secretsmanager:prod/db:SecretString:password}}'` or `'{{resolve:ssm-secure:/prod/api-key}}'`. The secret is resolved at deploy time and never stored in the template, parameters, Git, or stack events.

**Why it's used:** Hardcoded or parameter-passed secrets leak into Git, logs, and console history. Dynamic references keep them out entirely; Secrets Manager adds automatic rotation.

**Production angle:** Our RDS stack sets `MasterUserPassword` via a Secrets Manager dynamic reference; the password is generated and rotated (30 days) by Secrets Manager. IAM ensures only the CFN role and app role can read it. We never use `NoEcho` parameters for production secrets.

---

### Q15. Difference between Terraform and CloudFormation?

**Answer:**
- **Scope:** Terraform is multi-cloud + many providers; CloudFormation is AWS-only.
- **Language:** Terraform uses HCL; CloudFormation uses YAML/JSON.
- **State:** Terraform maintains its own state file (needs S3 + locking); CloudFormation state is AWS-managed (nothing to store).
- **Rollback:** CloudFormation auto-rolls back on failure; Terraform does not.
- **Preview:** `terraform plan` ≈ CloudFormation Change Sets.

**Why it matters:** The choice depends on whether you're pure-AWS (CloudFormation's native integration + managed state) or multi-cloud (Terraform's single tool across providers).

**Production angle:** For an AWS-only shop wanting deep native integration and zero state management, I'd choose CloudFormation. For multi-cloud or a shared tool across AWS/Azure/GCP, Terraform.

---
---

# Part 2 — Production Scenarios (Full Solutions)

### Scenario 1 — Change Set shows RDS will be replaced. Protect data and avoid downtime.

**Situation:** You submit a template change and the change set shows `Replacement: True` on the RDS instance — meaning it will be destroyed and recreated (new endpoint, data loss).

**Solution steps:**
1. **Stop and investigate** — do NOT execute the change set. Identify *which property* forces replacement (e.g., `DBInstanceIdentifier`, `Engine`, `AvailabilityZone`, storage encryption change).
2. **Protect data first:**
   - Ensure `DeletionPolicy: Retain` + `UpdateReplacePolicy: Snapshot` are set on the RDS resource, so even if replaced, a snapshot is taken and old data isn't lost.
   - Take a **manual snapshot** as an extra safety net.
3. **Avoid the replacement if possible** — if the change isn't essential, revert that property. Many changes (instance class) cause *interruption* not *replacement*; only some force replacement.
4. **If replacement is required** (e.g., enabling encryption, which can't be done in place):
   - Plan it in a **maintenance window**.
   - Use a **read replica or snapshot-restore** strategy: snapshot → restore encrypted copy → migrate → cut over.
5. **Gate it** — require manual approval in the pipeline before executing.

**Interview soundbite:** "First I identify the property forcing replacement. I confirm `Retain` + `Snapshot` policies and take a manual snapshot. If replacement is unavoidable (like enabling encryption), I do a snapshot-restore migration in a maintenance window rather than letting CloudFormation replace the live DB."

---

### Scenario 2 — Stack stuck in `UPDATE_ROLLBACK_FAILED`. Troubleshoot.

**Solution steps:**
1. **Events tab, bottom-up** — find the FIRST resource that failed during rollback and read the **Status reason**.
2. **Identify the cause** — common ones:
   - A resource was modified/deleted manually (drift) so rollback can't reconcile.
   - A custom-resource Lambda timed out or errored.
   - A security group still attached to an ENI.
   - An S3 bucket not empty.
3. **Fix the underlying issue manually** — detach the SG, empty the bucket, repair the Lambda, recreate the manually-deleted dependency.
4. **Resume:** `aws cloudformation continue-update-rollback --stack-name <name>`.
5. **Last resort:** if one resource is truly unrecoverable, skip it: `--resources-to-skip <LogicalId>` — then reconcile that resource with the template afterward (it's now inconsistent).
6. **After reaching `UPDATE_ROLLBACK_COMPLETE`:** fix the template that caused the original failure, create a new change set, and redeploy.

**Interview soundbite:** "Events tab bottom-up to find the root cause, fix it manually, then `continue-update-rollback`. I only use `--resources-to-skip` as a last resort because it leaves the resource inconsistent with the template."

---

### Scenario 3 — Someone changed a Security Group rule outside CloudFormation. Detect and resolve.

**Solution steps:**
1. **Detect:** run drift detection — `aws cloudformation detect-stack-drift --stack-name <name>` → `describe-stack-resource-drifts`. The SG shows `MODIFIED` with an Expected vs Actual diff.
2. **Assess:** was the change intentional (should be codified) or accidental/unauthorized (should be reverted)?
3. **If unwanted:** re-apply the template via a stack update — CloudFormation snaps the SG back to the template-defined rules, closing the unauthorized rule.
4. **If intentional:** update the template to include the new rule, then redeploy so IaC matches reality.
5. **Prevent recurrence:** restrict who can modify prod SGs via IAM, and automate nightly drift detection (EventBridge + Lambda → Slack alert).

**Interview soundbite:** "Drift detection flags the `MODIFIED` SG with a diff. If it's unauthorized, I re-apply the template to revert it; if it's a legitimate change, I codify it in the template. Then I automate nightly drift checks so this is caught proactively, not during the next incident."

---

### Scenario 4 — 10 AWS accounts. Deploy common security resources.

**Solution steps:**
1. **Use StackSets with the Service-managed permission model** (tied to AWS Organizations) so IAM roles are handled automatically.
2. **Define the baseline template:** CloudTrail enabled, AWS Config + rules, IAM password policy, S3 account-level block-public-access, GuardDuty, a standard VPC.
3. **Target by OU**, not individual accounts, so membership is dynamic.
4. **Enable auto-deployment** — new accounts added to the OU automatically receive the baseline; removed accounts can retain or clean up.
5. **Control rollout:** set failure tolerance (e.g., 1) and max concurrency; deploy a **canary region** (e.g., us-east-1) first, then fan out.
6. **Operate:** update the StackSet once → it propagates to all accounts/regions.

**Interview soundbite:** "Service-managed StackSet targeting the OU, with auto-deployment so new accounts inherit the baseline. I canary one region, set failure tolerance to limit blast radius, and manage all 10 accounts from a single StackSet definition in the management account."

---

### Scenario 5 — Design a Jenkins pipeline: validate → change set → prod approval → deploy.

**Solution (pipeline stages):**
```
1. Checkout        -> pull template + params from Git
2. Validate        -> aws cloudformation validate-template
3. Lint            -> cfn-lint (catch best-practice issues)
4. Assume Role     -> STS assume scoped cfn-deploy-role
5. Create ChangeSet-> aws cloudformation create-change-set
6. Review          -> describe-change-set -> post Add/Modify/Remove/Replacement to Slack
7. Approval (PROD) -> input "Deploy to PROD?" (manual gate)
8. Execute         -> aws cloudformation execute-change-set
9. Wait/Verify     -> aws cloudformation wait stack-update-complete + smoke test
10. Notify         -> Slack success/failure
```

**Key design points:**
- Dev/QA stages **skip the approval gate**; only prod has it.
- The **change set is the review artifact** — reviewers see the Replacement column before approving.
- Jenkins uses a **least-privilege deploy role via STS**, never long-lived admin keys.
- `wait` commands block until the stack reaches a terminal state before smoke tests.
- On failure, the pipeline surfaces the Events tab reason and stops.

**Interview soundbite:** "validate → lint → create-change-set → review Replacement → manual approval for prod only → execute → wait → smoke test. The change set is the human review artifact, and the pipeline assumes a scoped role via STS rather than using admin credentials."

---
---

# Part 3 — Extra High-Probability Questions

### Q16. What are Capabilities in CloudFormation?

An explicit acknowledgement required when a template creates IAM resources or uses macros:
- `CAPABILITY_IAM` — template creates IAM resources
- `CAPABILITY_NAMED_IAM` — creates IAM resources with custom names
- `CAPABILITY_AUTO_EXPAND` — uses macros / SAM transforms

Without them, the deploy fails with *"Requires capabilities: [CAPABILITY_IAM]"*. It's a safety check so you don't accidentally create privilege-granting resources.

---

### Q17. What is a CloudFormation Service Role?

An IAM role that CloudFormation **assumes** to create resources (passed via `--role-arn`). It scopes what a stack can do, independent of the deploying user. In CI/CD we give pipelines a least-privilege `cfn-deploy-role` so even broad Jenkins credentials can only create what the service role allows.

---

### Q18. What is `CreationPolicy` and how does it differ from `DependsOn`?

`DependsOn` waits for a resource to be **created** (API-level). `CreationPolicy` + `cfn-signal` waits for the resource to be **ready** (application-level success signal). We use CreationPolicy on EC2/ASG so the stack only succeeds once the app inside signals healthy, not just when the instance boots.

---

### Q19. What is a Custom Resource?

A way to make CloudFormation manage anything it doesn't natively support, by invoking a Lambda during create/update/delete. The Lambda **must** send a success/failure response to the callback URL — on success AND failure — or the stack hangs for ~1 hour. Common use: dynamic AMI lookup, third-party API calls, DB seeding.

---

### Q20. How do you handle a template larger than the inline size limit?

Upload the template to **S3** and reference it by URL (`--template-url`). Inline templates are capped at ~51,200 bytes via the API; S3-hosted templates can be up to 1 MB. For nested stacks, `aws cloudformation package` auto-uploads child templates and Lambda code to S3 and rewrites the URLs.

---

### Q21. What is the difference between `create-stack` and `deploy`?

`deploy` is the modern, idempotent command — it figures out create vs update, uses change sets internally, and doesn't error when there are no changes. `create-stack`/`update-stack` are lower-level; `update-stack` errors with "No updates are to be performed" when nothing changed. Pipelines prefer `deploy`.

---

### Q22. Can you update a stack in `ROLLBACK_COMPLETE`?

No. `ROLLBACK_COMPLETE` happens when a brand-new stack fails on first creation — it's a dead-end state. You must **delete** the stack and recreate it. (This is different from `UPDATE_ROLLBACK_COMPLETE`, which you *can* update from.)

---

### Q23. How do you roll back to a previous template version?

CloudFormation doesn't keep a version history itself — that's why templates live in **Git**. To roll back, redeploy the previous template version from Git (or re-run the previous pipeline build). For automatic rollback on alarm, use **rollback triggers** (CloudWatch alarms configured on the stack) so a bad deploy auto-reverts if an alarm fires during the update.

---

### Q24. What are rollback triggers?

CloudWatch alarms attached to a stack operation. If any alarm fires during the create/update (plus a monitoring period after), CloudFormation automatically rolls back. Used to catch problems that only show up after deploy — e.g., error rate spikes — and auto-revert.

---

### Q25. How do you import existing resources?

Create an import-type change set (`--change-set-type IMPORT`), provide a template matching the resource's current config (each resource needs a `DeletionPolicy`), and map the physical ID. After import, run drift detection to confirm the template matches reality. Used to bring legacy/manually-created resources under IaC.

---

### Q26. What is AWS SAM?

**Serverless Application Model** — a CloudFormation extension (`Transform: AWS::Serverless-2016-10-31`) with shorthand resource types like `AWS::Serverless::Function` and `AWS::Serverless::Api`. It expands into standard CloudFormation at deploy. Needs `CAPABILITY_AUTO_EXPAND`. It makes serverless (Lambda/API Gateway/DynamoDB) templates far shorter.

---

### Q27. How is AWS CDK related to CloudFormation?

CDK lets you write infra in a real language (TypeScript/Python/etc.). `cdk synth` generates a CloudFormation template; `cdk deploy` provisions it through CloudFormation. CDK is an abstraction layer — CloudFormation is still the engine, so you keep managed state, change sets (`cdk diff`), and rollback. CDK shines for loops, conditionals, and code reuse YAML can't express.

---
---

# Part 4 — Practical YAML Templates

> These are the five templates you were told to be ready to write and explain. Each is deploy-ready and annotated.

## T1: EC2 with Parameters, Security Group & User Data

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: EC2 web server with SG and bootstrap

Parameters:
  InstanceType:
    Type: String
    Default: t3.micro
    AllowedValues: [t3.micro, t3.small, t3.medium]
  KeyName:
    Type: AWS::EC2::KeyPair::KeyName
    Description: Existing key pair for SSH
  SSHLocation:
    Type: String
    Default: 0.0.0.0/0
    Description: CIDR allowed to SSH (restrict in prod!)
  LatestAmi:
    Type: AWS::SSM::Parameter::Value<AWS::EC2::Image::Id>
    Default: /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64

Resources:
  WebSG:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: Allow HTTP and SSH
      SecurityGroupIngress:
        - { IpProtocol: tcp, FromPort: 80, ToPort: 80, CidrIp: 0.0.0.0/0 }
        - { IpProtocol: tcp, FromPort: 22, ToPort: 22, CidrIp: !Ref SSHLocation }

  WebServer:
    Type: AWS::EC2::Instance
    CreationPolicy:
      ResourceSignal: { Count: 1, Timeout: PT10M }
    Properties:
      ImageId: !Ref LatestAmi        # dynamic AMI via SSM — no hardcoding
      InstanceType: !Ref InstanceType
      KeyName: !Ref KeyName
      SecurityGroupIds: [!Ref WebSG]
      Tags: [{ Key: Name, Value: cfn-web-server }]
      UserData:
        Fn::Base64: !Sub |
          #!/bin/bash
          dnf install -y httpd
          systemctl enable --now httpd
          echo "<h1>Hello from CloudFormation</h1>" > /var/www/html/index.html
          /opt/aws/bin/cfn-signal -e $? --stack ${AWS::StackName} --resource WebServer --region ${AWS::Region}

Outputs:
  PublicIP:
    Value: !GetAtt WebServer.PublicIp
```

**Explain:** Dynamic AMI via the SSM public parameter (no hardcoded AMI ID). SG allows HTTP open, SSH restricted by parameter. UserData installs Apache and calls `cfn-signal`, so the `CreationPolicy` only marks success when the app is actually up.

---

## T2: VPC with Public/Private Subnets, Route Tables, Gateways

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: VPC with public + private subnets, IGW, NAT

Parameters:
  VpcCidr: { Type: String, Default: 10.0.0.0/16 }

Resources:
  VPC:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: !Ref VpcCidr
      EnableDnsHostnames: true
      Tags: [{ Key: Name, Value: cfn-vpc }]

  IGW:
    Type: AWS::EC2::InternetGateway
  IGWAttach:
    Type: AWS::EC2::VPCGatewayAttachment
    Properties: { VpcId: !Ref VPC, InternetGatewayId: !Ref IGW }

  PublicSubnet:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.0.1.0/24
      AvailabilityZone: !Select [0, !GetAZs '']
      MapPublicIpOnLaunch: true
  PrivateSubnet:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.0.2.0/24
      AvailabilityZone: !Select [1, !GetAZs '']

  PublicRT:
    Type: AWS::EC2::RouteTable
    Properties: { VpcId: !Ref VPC }
  PublicRoute:
    Type: AWS::EC2::Route
    DependsOn: IGWAttach            # explicit: IGW must be attached first
    Properties:
      RouteTableId: !Ref PublicRT
      DestinationCidrBlock: 0.0.0.0/0
      GatewayId: !Ref IGW
  PublicAssoc:
    Type: AWS::EC2::SubnetRouteTableAssociation
    Properties: { SubnetId: !Ref PublicSubnet, RouteTableId: !Ref PublicRT }

  NatEIP:
    Type: AWS::EC2::EIP
    Properties: { Domain: vpc }
  NatGW:
    Type: AWS::EC2::NatGateway
    Properties: { AllocationId: !GetAtt NatEIP.AllocationId, SubnetId: !Ref PublicSubnet }

  PrivateRT:
    Type: AWS::EC2::RouteTable
    Properties: { VpcId: !Ref VPC }
  PrivateRoute:
    Type: AWS::EC2::Route
    Properties:
      RouteTableId: !Ref PrivateRT
      DestinationCidrBlock: 0.0.0.0/0
      NatGatewayId: !Ref NatGW
  PrivateAssoc:
    Type: AWS::EC2::SubnetRouteTableAssociation
    Properties: { SubnetId: !Ref PrivateSubnet, RouteTableId: !Ref PrivateRT }

Outputs:
  VpcId:
    Value: !Ref VPC
    Export: { Name: cfn-vpc-id }
  PublicSubnetId:
    Value: !Ref PublicSubnet
    Export: { Name: cfn-public-subnet }
  PrivateSubnetId:
    Value: !Ref PrivateSubnet
    Export: { Name: cfn-private-subnet }
```

**Explain:** Public subnet routes to IGW; private subnet routes to NAT (outbound only). `DependsOn: IGWAttach` on the public route prevents the attach race. Outputs are **exported** so other stacks can import the VPC/subnet IDs.

---

## T3: S3 with Encryption, Versioning & Lifecycle

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: Secure S3 bucket

Parameters:
  BucketName: { Type: String }

Resources:
  SecureBucket:
    Type: AWS::S3::Bucket
    DeletionPolicy: Retain               # protect data on stack delete
    UpdateReplacePolicy: Retain
    Properties:
      BucketName: !Ref BucketName
      VersioningConfiguration: { Status: Enabled }
      BucketEncryption:
        ServerSideEncryptionConfiguration:
          - ServerSideEncryptionByDefault: { SSEAlgorithm: AES256 }
      PublicAccessBlockConfiguration:
        BlockPublicAcls: true
        BlockPublicPolicy: true
        IgnorePublicAcls: true
        RestrictPublicBuckets: true
      LifecycleConfiguration:
        Rules:
          - Id: TransitionAndExpire
            Status: Enabled
            Transitions:
              - { StorageClass: STANDARD_IA, TransitionInDays: 30 }
              - { StorageClass: GLACIER,     TransitionInDays: 90 }
            ExpirationInDays: 365

Outputs:
  BucketArn:
    Value: !GetAtt SecureBucket.Arn
```

**Explain:** Encryption at rest (AES256), versioning on, all public access blocked, lifecycle moves objects Standard → IA (30d) → Glacier (90d) → delete (365d). `DeletionPolicy: Retain` protects data if the stack is deleted.

---

## T4: ALB + Target Group + ASG + Launch Template

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: ALB + ASG behind it

Parameters:
  VpcId:         { Type: AWS::EC2::VPC::Id }
  PublicSubnets: { Type: List<AWS::EC2::Subnet::Id> }
  LatestAmi:
    Type: AWS::SSM::Parameter::Value<AWS::EC2::Image::Id>
    Default: /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64

Resources:
  ALBSG:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: ALB SG
      VpcId: !Ref VpcId
      SecurityGroupIngress:
        - { IpProtocol: tcp, FromPort: 80, ToPort: 80, CidrIp: 0.0.0.0/0 }
  AppSG:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: App SG
      VpcId: !Ref VpcId
      SecurityGroupIngress:
        - { IpProtocol: tcp, FromPort: 80, ToPort: 80, SourceSecurityGroupId: !Ref ALBSG }

  ALB:
    Type: AWS::ElasticLoadBalancingV2::LoadBalancer
    Properties:
      Type: application
      Subnets: !Ref PublicSubnets
      SecurityGroups: [!Ref ALBSG]
  TargetGroup:
    Type: AWS::ElasticLoadBalancingV2::TargetGroup
    Properties:
      VpcId: !Ref VpcId
      Port: 80
      Protocol: HTTP
      HealthCheckPath: /
  Listener:
    Type: AWS::ElasticLoadBalancingV2::Listener
    Properties:
      LoadBalancerArn: !Ref ALB
      Port: 80
      Protocol: HTTP
      DefaultActions: [{ Type: forward, TargetGroupArn: !Ref TargetGroup }]

  LaunchTemplate:
    Type: AWS::EC2::LaunchTemplate
    Properties:
      LaunchTemplateData:
        ImageId: !Ref LatestAmi
        InstanceType: t3.micro
        SecurityGroupIds: [!Ref AppSG]
        UserData:
          Fn::Base64: |
            #!/bin/bash
            dnf install -y httpd
            systemctl enable --now httpd
            echo "OK" > /var/www/html/index.html

  ASG:
    Type: AWS::AutoScaling::AutoScalingGroup
    Properties:
      VPCZoneIdentifier: !Ref PublicSubnets
      LaunchTemplate:
        LaunchTemplateId: !Ref LaunchTemplate
        Version: !GetAtt LaunchTemplate.LatestVersionNumber
      MinSize: '2'
      MaxSize: '6'
      DesiredCapacity: '2'
      TargetGroupARNs: [!Ref TargetGroup]
      HealthCheckType: ELB
      HealthCheckGracePeriod: 300

Outputs:
  ALBDns:
    Value: !GetAtt ALB.DNSName
```

**Explain:** ALB in public subnets (open :80), app SG only accepts traffic from the ALB SG (not the internet). Launch Template defines the instance config; ASG runs 2–6 instances across subnets, registers them with the Target Group, and uses ELB health checks. ALB DNS is the output.

---

## T5: IAM Role (Least Privilege) attached to EC2

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: EC2 with least-privilege S3 read role
# Deploy with: --capabilities CAPABILITY_NAMED_IAM

Parameters:
  AppBucket: { Type: String }

Resources:
  AppRole:
    Type: AWS::IAM::Role
    Properties:
      RoleName: app-s3-read-role
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal: { Service: ec2.amazonaws.com }
            Action: sts:AssumeRole
      Policies:
        - PolicyName: s3-read-only
          PolicyDocument:
            Version: '2012-10-17'
            Statement:
              - Effect: Allow
                Action: [s3:GetObject, s3:ListBucket]     # least privilege
                Resource:
                  - !Sub 'arn:aws:s3:::${AppBucket}'
                  - !Sub 'arn:aws:s3:::${AppBucket}/*'

  InstanceProfile:
    Type: AWS::IAM::InstanceProfile
    Properties: { Roles: [!Ref AppRole] }

  AppInstance:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: '{{resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64}}'
      InstanceType: t3.micro
      IamInstanceProfile: !Ref InstanceProfile    # attach role via instance profile

Outputs:
  RoleArn:
    Value: !GetAtt AppRole.Arn
```

**Explain:** The role grants only `s3:GetObject`/`s3:ListBucket` on one specific bucket (least privilege), is assumable only by EC2, and is attached via an **instance profile**. No access keys stored on the instance — it gets temporary rotating credentials. Deploy needs `CAPABILITY_NAMED_IAM` because the role has a custom name.

---
---

# Part 5 — Rapid-Fire One-Liners

- **Only mandatory section?** `Resources`.
- **Format version?** `2010-09-09` (only valid value).
- **`!Ref` vs `!GetAtt`?** Ref = default ID; GetAtt = named attribute.
- **Preview changes?** Change Set.
- **Detect manual changes?** Drift detection (detect-only, doesn't fix).
- **Modularize one template?** Nested stacks.
- **Deploy across accounts/regions?** StackSets.
- **Share values between stacks?** Export + `!ImportValue`.
- **Can't delete an export while...?** another stack imports it.
- **Protect DB from stack deletion?** `DeletionPolicy: Retain`.
- **Snapshot before replacement?** `UpdateReplacePolicy: Snapshot`.
- **Block whole-stack deletion?** Termination protection.
- **Block resource updates?** Stack policy.
- **Dead-end state?** `ROLLBACK_COMPLETE` (delete + recreate).
- **Resume failed rollback?** `continue-update-rollback`.
- **Wait for app readiness, not just creation?** `CreationPolicy` + `cfn-signal`.
- **Manage unsupported resources?** Custom resource (Lambda) — must signal back or hangs ~1hr.
- **Secrets?** Dynamic references `{{resolve:secretsmanager:...}}` / `{{resolve:ssm-secure:...}}`.
- **IAM resources need?** `CAPABILITY_IAM` / `CAPABILITY_NAMED_IAM`.
- **SAM/macros need?** `CAPABILITY_AUTO_EXPAND`.
- **Bring existing resources in?** Resource import (`--change-set-type IMPORT`).
- **CDK relationship?** CDK synthesizes to CloudFormation; CFN is still the engine.
- **Idempotent deploy command?** `aws cloudformation deploy`.
- **CFN vs Terraform state?** CFN = AWS-managed; Terraform = self-managed file.

---

> ✅ **All 15 core EPAM questions, 5 scenarios, 12 extra questions, and 5 practical templates covered.**
> 📄 Pair this with `cloudformation-notes.md` for the full topic-by-topic study.
> 🍀 Good luck tomorrow!
