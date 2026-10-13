# Terraform Advanced Interview Preparation — 50 Questions with Answers

**Role:** Azure SRE / DevOps Engineer (5+ years) — State Street client preparation

**Study format:** Every answer includes **1. Concept**, **2. Implementation — Step by Step**, **3. Production Example**, and **4. Troubleshooting**, in simple English. Commands and values are examples; confirm permissions, provider versions and your environment before use.

**Important for production:** Never apply unreviewed plans, manipulate state without backups, or disable state locking to bypass an incident.

---

## Clickable Table of Contents

### [Section A — Terraform State, Drift and Synchronization (Questions 1–10)](#section-a)
- [Q1. Terraform manages 100 Azure resources, and someone changes 20 through Azure Portal. How do you detect and synchronize changes without importing everything again?](#q01)
- [Q2. What is the difference between Terraform configuration, state and actual infrastructure, and how does Terraform reconcile drift?](#q02)
- [Q3. Explain `terraform plan`, `plan -refresh-only`, `apply -refresh-only` and `terraform import`. When do you use each?](#q03)
- [Q4. How would you automatically detect Terraform drift across multiple subscriptions without applying risky changes?](#q04)
- [Q5. How do you adopt 200 manually created Azure resources using import blocks or Azure Export for Terraform?](#q05)
- [Q6. How would you import 30 existing resources and create 20 new resources when teams request parallel execution?](#q06)
- [Q7. What happens if two Azure DevOps pipelines execute `terraform apply` against the same state at the same time?](#q07)
- [Q8. How is importing into one state different from managing resources in separate Terraform states?](#q08)
- [Q9. After importing an existing production resource, Terraform wants to destroy and recreate it. How do you prevent downtime?](#q09)
- [Q10. How would you synchronize emergency Portal changes with Terraform while preserving change control?](#q10)

### [Section B — Terraform State Recovery, Locking and Failure Troubleshooting (Questions 11–20)](#section-b)
- [Q11. Your production Terraform state file is accidentally deleted from Azure Blob Storage. Infrastructure is running. How do you recover it?](#q11)
- [Q12. Terraform state is lost and no backup exists. How would you reconstruct state without destroying production infrastructure?](#q12)
- [Q13. Terraform creates some resources and fails halfway through `apply`. How do you recover without duplicates?](#q13)
- [Q14. Explain Terraform state locking in Azure Blob Storage. What if a lock remains after a pipeline failure?](#q14)
- [Q15. How would you design and secure a Terraform remote backend using Azure Blob Storage?](#q15)
- [Q16. Explain `terraform state list`, `show`, `mv`, `rm`, `pull` and `push` with production examples.](#q16)
- [Q17. What if Terraform state becomes corrupted or inconsistent with Azure resources?](#q17)
- [Q18. Terraform state may contain secrets. How would you protect credentials and sensitive state data?](#q18)
- [Q19. `terraform init` cannot reach the Azure Storage backend. How would you troubleshoot authentication and networking?](#q19)
- [Q20. How would you migrate Terraform state from local to Azure Blob Storage or Terraform Enterprise safely?](#q20)

### [Section C — Terraform Modules, Advanced HCL and Azure Provisioning (Questions 21–30)](#section-c)
- [Q21. How would you design reusable Terraform modules for Azure subscriptions, VNets, AKS clusters, regions and applications?](#q21)
- [Q22. What is the difference between `count`, `for_each` and `dynamic` blocks, and when would you use each?](#q22)
- [Q23. How do Terraform provider aliases deploy resources into two Azure subscriptions?](#q23)
- [Q24. How would you provision VNets, subnets, NSGs, routes, private endpoints and private DNS using Terraform modules?](#q24)
- [Q25. Explain `ignore_changes`, `prevent_destroy`, `create_before_destroy` and `replace_triggered_by`. What are their production risks?](#q25)
- [Q26. How do you manage dependencies between resources, modules and separate Terraform states?](#q26)
- [Q27. How would you move a Terraform-managed resource from the root into a child module without recreating it?](#q27)
- [Q28. Write Terraform using `for_each` and `dynamic` blocks to generate Azure NSG rules from YAML or JSON.](#q28)
- [Q29. How do variable validation, locals, preconditions, postconditions and check blocks protect Terraform deployments?](#q29)
- [Q30. How do you manage Terraform module/provider versions, and what if an AzureRM upgrade proposes replacements?](#q30)

### [Section D — Terraform with Azure DevOps, CI/CD and Production Deployments (Questions 31–39)](#section-d)
- [Q31. Design an Azure DevOps Terraform pipeline with `init`, `fmt`, `validate`, `plan`, manual approval and `apply`.](#q31)
- [Q32. How would you ensure an approver reviews the exact Terraform plan that production will apply?](#q32)
- [Q33. Terraform works locally but fails in Azure DevOps with authentication or authorization errors. How do you investigate?](#q33)
- [Q34. Terraform pipeline fails halfway through AKS or networking provisioning. How would you recover?](#q34)
- [Q35. How would you integrate TFLint, Checkov and policy-as-code into Terraform CI/CD?](#q35)
- [Q36. How would you prevent multiple engineers or pipelines from conflicting on production infrastructure?](#q36)
- [Q37. Terraform completes successfully, but the application deployment fails. What is your rollback plan?](#q37)
- [Q38. How does infrastructure rollback differ from application rollback, especially for irreversible changes?](#q38)
- [Q39. How would you use Python to read Terraform plan JSON and report resources being created, deleted or replaced?](#q39)

### [Section E — Terraform Enterprise and Automation (Questions 40–45)](#section-e)
- [Q40. What is Terraform Enterprise? Compare Terraform CLI, HCP Terraform and Terraform Enterprise.](#q40)
- [Q41. How does Terraform Enterprise handle workspaces, remote plans, run queues, approvals, state versions and concurrency?](#q41)
- [Q42. How would you configure Terraform Enterprise agents to deploy Azure resources reachable only through private VNets?](#q42)
- [Q43. What is the difference between Sentinel and OPA in Terraform Enterprise, and how do you block public IPs or disallowed regions?](#q43)
- [Q44. How would you migrate many Azure DevOps Terraform pipelines into Terraform Enterprise without losing state?](#q44)
- [Q45. How would you build a Python tool that triggers Terraform Enterprise runs, monitors status and reports results?](#q45)

### [Section F — Cloud Migration, Disaster Recovery and Real Production Scenarios (Questions 46–50)](#section-f)
- [Q46. How would you migrate manually managed on-premises and Azure infrastructure into Terraform with minimal downtime?](#q46)
- [Q47. How would you use Terraform to provision Azure disaster recovery in a second region?](#q47)
- [Q48. Two teams share networking infrastructure but have independent Terraform deployments. How do you handle ownership and dependencies?](#q48)
- [Q49. How would you use Terraform for Azure Event Hubs, Storage Queues, Event Grid, App Service, private endpoints and monitoring?](#q49)
- [Q50. During an incident, someone modifies Azure resources manually while Terraform is applying. How do you prevent conflicts, preserve the fix and restore IaC control?](#q50)

---

<a id="section-a"></a>
## Section A — Terraform State, Drift and Synchronization (Questions 1–10)

<a id="q01"></a>
### Question 1: Terraform manages 100 Azure resources, and someone changes 20 through Azure Portal. How do you detect and synchronize changes without importing everything again?

#### 1. Concept
Terraform uses **HCL configuration** as the desired infrastructure, a **state file** to remember which actual resources it manages, and provider APIs to read **real Azure infrastructure**. A normal plan refreshes managed-resource information in memory and compares it with HCL. Changes made in the Azure Portal are called **drift**. Existing managed resources do **not** need importing again just because their settings changed. Import is for bringing an **unmanaged** resource under Terraform control.

There are two legitimate outcomes: **restore desired state** (let Terraform change Azure back to the approved HCL), or **accept an authorized manual change** (update the HCL so Terraform will maintain it). A refresh-only operation updates state with real values but **does not update HCL**, so it is not a permanent solution for conflicting configuration.

#### 2. Implementation — Step by Step
1. Pause conflicting production changes and confirm you are using the correct subscription, workspace, backend and Git commit.
2. Run `terraform init`, then `terraform plan -out=drift.tfplan`. Read the drift notices and any resource replacement or deletion actions.
3. Inspect a specific resource with `terraform state show 'azurerm_linux_virtual_machine.app'` and compare it with the Azure Portal and the HCL resource block.
4. If the Portal change was unauthorized, get approval and apply the reviewed plan to return to HCL. If approved, update HCL/variables, review another plan, then apply the approved configuration.
5. Optionally run `terraform plan -refresh-only` to inspect differences between state and Azure, then `terraform apply -refresh-only` **only if you intentionally want to update state**. This does not accept changes into HCL.

```bash
terraform init
terraform plan -out=drift.tfplan
terraform show drift.tfplan
terraform plan -refresh-only
```

#### 3. Production Example
A payment VM was changed from a smaller to a larger SKU during a traffic incident. I would confirm the change ticket and monitoring evidence. If the new size is approved, I update `vm_size` in production variables, review the plan and merge it through the deployment pipeline. If someone instead opened an unauthorized NSG port, I remove that rule through a controlled Terraform apply and investigate the security event. Daily read-only drift checks would catch both cases.

#### 4. Troubleshooting
If the plan shows **replacement**, identify which changed field is `ForceNew`, whether a provider version changed, or whether the resource address moved. If access fails, verify the Terraform identity's Azure RBAC and provider subscription. Never set `-refresh=false` to hide real drift; never use `ignore_changes` for security-critical attributes merely to make the plan clean. **Interview conclusion:** detect drift, decide which state is correct, reconcile HCL, review the plan, and only then apply.

---

<a id="q02"></a>
### Question 2: What is the difference between Terraform configuration, state and actual infrastructure, and how does Terraform reconcile drift?

#### 1. Concept
**Configuration (`.tf`)** describes what should exist; **state** records Terraform resource addresses, cloud IDs, attributes and dependencies; **actual infrastructure** is what Azure currently has. Terraform state is not simply a full backup of Azure. The state is especially important because it maps `azurerm_resource_group.main` to a particular Azure resource ID. At plan time, Terraform normally reads the live values through the provider and compares them to the desired configuration.

#### 2. Implementation — Step by Step
1. Describe approved infrastructure in HCL, with variables and required provider versions.
2. Use an Azure Blob remote backend so engineers and pipelines share the same state with locking.
3. Run `terraform plan` to see proposed create, update, replace or delete operations; review the `-/+` replacement marker carefully.
4. Run `terraform apply` only after approval. Terraform updates Azure and saves new resource mappings/state.
5. For an unmanaged Azure resource, add configuration and use an `import` block; a normal refresh cannot discover it automatically.

```bash
terraform state list
terraform state show azurerm_resource_group.main
terraform plan -detailed-exitcode   # 0=no changes, 2=changes, 1=error
```

#### 3. Production Example
Git says a storage account must have public access disabled. An engineer turns it on through the Portal. The next normal plan reads Azure, detects drift and proposes returning public access to the HCL value. After investigation I run the security-reviewed apply, then alert on future manual changes through Azure Activity Log and Azure Policy.

#### 4. Troubleshooting
If Terraform proposes creating an already-existing resource, check whether the address is missing from state, whether the backend key/workspace is wrong, or whether HCL references the wrong provider alias. If a planned delete is unexpected, stop and investigate removed configuration, changed `for_each` keys, or state mistakes. **Interview conclusion:** HCL is the approved target, state is the mapping, and Azure is the live system.

---

<a id="q03"></a>
### Question 3: Explain `terraform plan`, `plan -refresh-only`, `apply -refresh-only` and `terraform import`. When do you use each?

#### 1. Concept
A regular **plan** refreshes information and proposes Azure changes to match HCL. **`plan -refresh-only`** shows proposed *state-only* updates from remote objects. **`apply -refresh-only`** commits those updates to state without changing live Azure resources. **Import** attaches an already-existing cloud object to an HCL resource address in state; it does not generate a production-ready desired configuration by itself unless used with supported configuration-generation workflows.

#### 2. Implementation — Step by Step
```bash
terraform plan                          # Proposed infrastructure changes
terraform plan -refresh-only           # Preview state reconciliation only
terraform apply -refresh-only          # Update state after approval, no Azure change
terraform import azurerm_resource_group.existing /subscriptions/<sub>/resourceGroups/rg-existing
```
1. First decide whether the Azure object is **already managed**. Use `terraform state list` and `state show`.
2. For existing managed objects changed in Portal, use normal plan to understand drift; update HCL or restore its approved values.
3. For state accuracy only, carefully use refresh-only; an unchanged HCL may still produce a later ordinary plan proposing changes.
4. For previously unmanaged objects, declare the resource in HCL and import it to the correct address. Review before applying.
5. Prefer declarative `import` blocks for reviewable bulk onboarding; never assume an import creates the real resource.

#### 3. Production Example
A manually created Storage Account is needed by an app. I use an `import` block because no Terraform state mapping exists. A different, Terraform-managed VM has been manually resized: I review the normal plan, modify HCL to reflect the approved size, and do not re-import that VM.

#### 4. Troubleshooting
If import reports the object is already managed, search state and avoid duplicate mappings. If refresh-only removes a missing object from the state, check credentials, subscription and actual deletion before approving. Avoid the deprecated `terraform refresh` command because it updates state without the same review workflow. **Interview conclusion:** refreshing and importing solve different problems.

---

<a id="q04"></a>
### Question 4: How would you automatically detect Terraform drift across multiple subscriptions without applying risky changes?

#### 1. Concept
**Drift detection** is a scheduled read-and-compare workflow. It should report differences and make them visible to engineers, not automatically destroy or replace infrastructure. Separate state files and deployment identities allow an organization to scan many subscriptions with clear ownership. Terraform Enterprise/HCP Terraform also offers supported health-assessment and drift-detection features, depending on edition and workspace configuration.

#### 2. Implementation — Step by Step
1. Keep a manifest of Terraform roots/workspaces, Azure subscriptions, responsible teams and state keys.
2. Schedule a pipeline per root/workspace with **read access** where feasible and `terraform init -input=false` followed by `terraform plan -detailed-exitcode -input=false -no-color`.
3. Interpret exit code `0` as no change, `2` as changes detected and `1` as plan error. Do not combine a plan error with drift status.
4. Capture a machine-readable saved plan with `terraform show -json` only in protected artifacts because plans can contain sensitive data. Summarize changes and owners with Python.
5. Create a ticket or alert for resource replacement, public exposure, unapproved tags or deletions; review against Azure Activity Log and planned releases.
6. Allow remediation only through an approved production apply pipeline, not the scanning job.

```bash
terraform init -input=false
terraform plan -detailed-exitcode -out=drift.plan -input=false
terraform show -json drift.plan > drift.json
```

#### 3. Production Example
I schedule nightly non-mutating plans against 15 production workspaces. A Python report groups drift by subscription, resource and severity. A changed public network access flag creates a high-priority security incident; a tag difference goes into the regular maintenance queue.

#### 4. Troubleshooting
Read-only identities may be unable to acquire backend locks or read certain resources—grant minimum permissions required for the chosen workflow. Check provider throttling and workspace locks when jobs are slow. Account for intentional autoscaling fields, but don't broadly ignore security settings. **Interview conclusion:** detect automatically; remediate deliberately.

---

<a id="q05"></a>
### Question 5: How do you adopt 200 manually created Azure resources using import blocks or Azure Export for Terraform?

#### 1. Concept
Bulk import moves **ownership of existing infrastructure** into Terraform. It is not redeployment and must not disrupt active production workloads. You need a correct HCL declaration and a one-to-one mapping between each resource instance and Azure ID. Tools include Terraform `import` blocks, provider-supported bulk discovery/generation (verify Terraform/provider support), and Microsoft **Azure Export for Terraform (`aztfexport`)**.

#### 2. Implementation — Step by Step
1. Inventory resources using Azure Resource Graph and map ownership, dependencies, secrets, roles and regions.
2. Decide state boundaries—for example shared network, security, platform and application. Take verified state snapshots and freeze competing applies.
3. Export a **test resource group** into a temporary directory; review generated resource names, dependencies and HCL rather than blindly applying output.
4. For a small batch, create `resource` and `import` blocks. For large batches, use `aztfexport resource-group` or `aztfexport query`, and use the documented `--append` workflow where adding to an existing configuration/state.
5. Run `terraform plan`, remove any unexpected creates/replacements, adjust provider-specific attributes, then apply only the approved imports. Validate with `terraform state list` and a subsequent clean plan.

```hcl
resource "azurerm_resource_group" "legacy" {
  name     = "rg-legacy"
  location = "eastus"
}
import {
  to = azurerm_resource_group.legacy
  id = "/subscriptions/<sub-id>/resourceGroups/rg-legacy"
}
```
```bash
aztfexport resource-group rg-legacy   # Run in a dedicated, clean working directory
terraform plan
```

#### 3. Production Example
For 200 existing resources, I divide the transition into platform, networking and workload batches. The network team imports VNet, subnets and NSGs first; applications import their dependent resources after the owners approve. I save before/after plans and resource IDs for audit.

#### 4. Troubleshooting
The export may include defaults or resource properties differing from approved configuration. Some resources/providers may need AzAPI or manual refinement. If a plan proposes replacement after import, **do not apply** until you align HCL and verify `ForceNew` properties. Prevent the same Azure ID being managed by two states. **Interview conclusion:** discover, generate, review, import gradually and enforce single ownership.

---

<a id="q06"></a>
### Question 6: How would you import 30 existing resources and create 20 new resources when teams request parallel execution?

#### 1. Concept
Importing and creating resources both can **write Terraform state**. Two independent applies on the **same state** should not run in parallel; backend locking serializes writes but does not eliminate the risk of conflicting plans or ownership mistakes. Terraform can itself create independent resources concurrently within **one approved apply**, controlled by its dependency graph and `-parallelism`.

#### 2. Implementation — Step by Step
1. Identify whether the 30 imports and 20 creates belong to the same Terraform root/state. If yes, build one coherent HCL configuration with `import` blocks for existing resources plus `resource` blocks for new ones.
2. Freeze any separately running pipeline using that state. Back up the latest state and review resource addresses/IDs.
3. Run one plan; confirm **30 imports**, **20 creates**, and **zero unwanted deletes/replacements** (numbers may change due to dependencies).
4. Have the appropriate owners review and approve. Run a **single state-writing apply** under the backend lock.
5. If different teams need truly parallel deployments, split resources into **independent states with non-overlapping ownership**, explicit shared-resource interfaces, and separate pipelines. Coordinate cross-state prerequisites before parallel work.

```bash
terraform plan -out=production.tfplan
terraform show production.tfplan
terraform apply production.tfplan
```

#### 3. Production Example
I would keep hub networking in a platform state, import existing app resource groups into application states, and let independent applications deploy in parallel **after** central networking exists. No two workspaces would manage the same subnet or NSG rule.

#### 4. Troubleshooting
When Azure says “resource already exists,” check if it needs import instead of creation. If a pipeline blocks on a lock, do not bypass the lock. If a create references an imported subnet and fails, check the resource ID mapping and dependency wiring. **Interview conclusion:** parallelize independent resources/workspaces, not competing state writers.

---

<a id="q07"></a>
### Question 7: What happens if two Azure DevOps pipelines execute `terraform apply` against the same state at the same time?

#### 1. Concept
A compatible Azure Blob backend places a **lease/lock** on the state while performing state-writing operations. One pipeline obtains the lock; the other usually waits if configured with a timeout or fails to acquire the lock. Locking helps protect state consistency, but it does **not** resolve business conflicts between two code branches. The second plan can be stale after the first apply.

#### 2. Implementation — Step by Step
1. Configure both pipelines to use exactly the intended storage account, container and state blob key.
2. Enable Azure DevOps **environment approvals and checks** or another deployment concurrency control to serialize production applies per state.
3. Keep plan artifacts tied to the pipeline run, Git commit, environment and state key.
4. Use `-lock-timeout` for bounded waiting when supported in the command; on timeout, stop rather than disabling locking.
5. After the first apply, generate a fresh plan for the second change if its previous plan is stale.

```bash
terraform plan -lock-timeout=5m -out=tfplan
terraform apply -lock-timeout=5m tfplan
```

#### 3. Production Example
One PR adds an NSG rule while another changes AKS node-pool sizing. Both target `prod/platform.tfstate`. I allow the first approved deployment to finish, then re-plan the second against the new current state. This also avoids accepting a plan that accidentally reverses someone else's change.

#### 4. Troubleshooting
For `Error acquiring the state lock`, identify who owns the run, check active Azure DevOps jobs and the blob lease, and wait for legitimate work. If an agent died, verify no active apply before a carefully approved `terraform force-unlock <LOCK_ID>`. Never casually use `-lock=false` or manually break a live lease. **Interview conclusion:** backend locks protect state; pipeline serialization protects production workflow.

---

<a id="q08"></a>
### Question 8: How is importing into one state different from managing resources in separate Terraform states?

#### 1. Concept
One state offers a shared dependency graph and coordinated changes, but a larger blast radius, longer plans and more contention. Multiple states enable separate access, ownership and release schedules, but require explicit interfaces for shared values and careful sequencing. Every real resource should have **one controlling state**—not duplicated ownership.

#### 2. Implementation — Step by Step
1. Map all resources and responsible teams: central hub/network, security services, common identity, AKS platform, applications.
2. Keep highly coupled resources in a shared root only when one team owns their full lifecycle.
3. Split independent areas into separate state keys/workspaces and identities.
4. Share approved resource IDs through module inputs, data sources or outputs; use `terraform_remote_state` only when access to the referenced state is acceptable, since it can expose more data than intended.
5. When handing off resources, use planned `removed { lifecycle { destroy = false } }` blocks and `import` in the destination, or coordinated state operations. Freeze both pipelines, back up states and confirm no duplicate ownership.

#### 3. Production Example
`network-prod.tfstate` controls hub firewall and shared private DNS. `payments-prod.tfstate` controls the payments AKS namespace-related Azure resources and app dependencies. The payments team reads the hub VNet/subnet ID, but cannot modify the firewall.

#### 4. Troubleshooting
If separate workspaces both track an Azure route table, one team may undo the other's modifications. Search state addresses, inspect cloud IDs, and establish a single owning team. If downstream plans fail because outputs are unavailable, confirm upstream state has deployed and that the output contract is versioned. **Interview conclusion:** state boundaries are operational ownership and failure boundaries.

---

<a id="q09"></a>
### Question 9: After importing an existing production resource, Terraform wants to destroy and recreate it. How do you prevent downtime?

#### 1. Concept
Import adds the mapping from HCL address to real Azure object. It does not guarantee the HCL values match that object. Some AzureRM arguments force resource replacement when changed. A plan displaying `-/+` or “must be replaced” is a strong warning for production resources, especially databases, storage accounts and networking.

#### 2. Implementation — Step by Step
1. **Stop; do not apply.** Save the proposed plan and state backup.
2. Inspect the Azure resource's actual properties, Terraform `state show`, provider documentation, and the HCL variables.
3. Locate the field forcing replacement in the plan details; common causes include different names, resource group, location, immutable settings or provider changes.
4. Change HCL to match the approved real resource instead of changing live infrastructure by default.
5. If the resource truly must move, design a separate migration with a new resource, data copy, DNS/cutover and rollback. Use `prevent_destroy` as an additional guard where appropriate, not as a complete protection.

```bash
terraform state show azurerm_storage_account.legacy
terraform plan -out=check.tfplan
terraform show check.tfplan
```

#### 3. Production Example
After importing a payments database, the code uses the wrong region variable. Terraform proposes replacement. I correct the variable to the real region and run a new plan, then take any wanted configuration changes in a later maintenance window.

#### 4. Troubleshooting
If mismatches persist, examine the correct resource type, API/provider version, computed attributes and missing configuration. Don't add `ignore_changes = all` to silence a problem—you may hide later configuration drift. **Interview conclusion:** a clean import should finish with no unintended destructive actions.

---

<a id="q10"></a>
### Question 10: How would you synchronize emergency Portal changes with Terraform while preserving change control?

#### 1. Concept
During an incident, operators sometimes make urgent changes in Azure Portal—for example increasing AKS capacity or adjusting a firewall rule. Terraform still must become the approved source of truth afterward. The goal is to **retain a justified emergency fix**, remove risky temporary changes and record why it happened.

#### 2. Implementation — Step by Step
1. Open an incident/change record with operator, timestamp, affected resources and the intended emergency action.
2. Apply only the smallest approved change; capture Azure Activity Log and current settings before/after.
3. Put automated applies for the same state on hold, so no pipeline immediately reverts the emergency change.
4. Run `terraform plan` to inspect drift; update Terraform variables/HCL for the changes that must remain.
5. Submit an emergency pull request, perform expedited review and deploy a saved, approved plan.
6. Remove temporary exceptions (such as broad NSG rules), close incident action items and strengthen runbooks/automated controls.

#### 3. Production Example
An AKS node pool needs short-term extra capacity after a sudden load spike. We temporarily scale capacity through approved emergency operations. After service stabilizes, I change Terraform/autoscaler settings to the agreed values and run a controlled apply; any temporary capacity is reduced later with a rollback plan.

#### 4. Troubleshooting
If a pipeline threatens to roll back the emergency fix, cancel the apply and compare HCL with live Azure immediately. If someone changes a setting but the plan is empty, verify you're looking at the correct state, resource instance and attribute (including `ignore_changes`). **Interview conclusion:** emergency changes are allowed through control; reconciliation into IaC is mandatory afterward.

---

<a id="section-b"></a>
## Section B — Terraform State Recovery, Locking and Failure Troubleshooting (Questions 11–20)

<a id="q11"></a>
### Question 11: Your production Terraform state file is accidentally deleted from Azure Blob Storage. Infrastructure is running. How do you recover it?

#### 1. Concept
Deleting a Terraform state blob does **not** immediately delete Azure VMs, storage, VNets or AKS. However, Terraform can lose the mapping between HCL resource addresses and those existing Azure objects. Running a normal apply with an empty state could propose duplicate creates and conflicts. The safest recovery is to restore the **latest verified state version** rather than rebuild infrastructure.

#### 2. Implementation — Step by Step
1. **Stop all Terraform plans/applies and protect the storage backend.** Record affected storage account, container, blob key and deletion time. Never run an unreviewed apply against empty state.
2. In Azure Portal open Storage Account → Data storage → Containers → state container. Investigate deleted blobs, blob versions, soft-delete and backup/restore options configured **before** the incident.
3. Select the correct blob/version. Restore it to the expected key using documented Blob restore/version procedures. If recovery is from a Terraform Enterprise workspace, follow its state-version recovery procedure rather than treating it as a raw Azure blob.
4. Validate the recovered file, lineage/serial and expected resources. Reconfigure the backend and run read-only inspection.
5. Check for Azure changes made after the restored snapshot and reconcile them through normal plan or controlled imports. Restart pipelines after team approval.

```bash
terraform init -reconfigure
terraform state list
terraform plan -out=recovery-check.tfplan
terraform show recovery-check.tfplan
```

#### 3. Production Example
A user deletes the `prod/network.tfstate` blob. Blob soft-delete/versioning was enabled. I freeze deployment pipelines, restore the latest known-good blob, verify hub VNet and Firewall addresses in `state list`, check for any post-backup activity, and restart work only when the normal plan is safe.

#### 4. Troubleshooting
If the restored version is old, state might omit resources created later—import only the missing mappings after inventory. If authentication fails, check storage data-plane RBAC and private networking. If `terraform plan` proposes 100 creates, **stop**: the backend key may be wrong or recovery incomplete. Do not blindly use `terraform state push -force`. **Interview conclusion:** freeze, restore a verified version, validate state-to-Azure mapping, then resume.

---

<a id="q12"></a>
### Question 12: Terraform state is lost and no backup exists. How would you reconstruct state without destroying production infrastructure?

#### 1. Concept
Without any state backup, there is no one-command reconstruction of all Terraform resource mappings. Live Azure resources still exist, so recovery means building correct HCL resource blocks and importing existing cloud IDs into a **new, controlled state**. This is a sensitive inventory and reconciliation exercise, not a reason to recreate production.

#### 2. Implementation — Step by Step
1. Disable all automatic applies and safeguard original code, pipeline artifacts and audit logs.
2. Inventory Azure resources using Azure Resource Graph, CLI and the existing Git configuration. Determine ownership; separate resources managed by other Terraform workspaces.
3. Set up a new remote backend key in a **recovery workspace**, protect it with role-based access, then declare appropriate HCL addresses/modules.
4. Add `import` blocks or run controlled `terraform import` for each existing ID. Use `aztfexport` to assist with generated HCL for larger sets, then **review and adjust** it.
5. Validate `terraform state list`, `state show`, provider versions and live IDs. Keep running plans until there are **no unintended creates/deletes/replacements**.
6. Obtain change approval before promoting reconstructed state to production ownership. Take a backup/version snapshot and enable deletion protection.

```bash
# Example: after declaring azurerm_resource_group.existing in HCL
terraform import azurerm_resource_group.existing \
  /subscriptions/<sub-id>/resourceGroups/rg-existing
terraform state list
terraform plan
```

#### 3. Production Example
A legacy team has no recoverable state for 40 Azure resources. I split them by owner, import the non-destructive resources into a staging recovery backend, compare Azure IDs, and require the app/database owners to sign off before adopting the new state.

#### 4. Troubleshooting
Common problems: cloud IDs mapped to the wrong HCL address, duplicated ownership, secret values unknown, provider gaps, and imported resources that want replacing. Do not approve a plan containing unexpected `+ create` actions for already-existing infrastructure. **Interview conclusion:** restore mapping through safe imports and explicit ownership; never apply blind changes.

---

<a id="q13"></a>
### Question 13: Terraform creates some resources and fails halfway through `apply`. How do you recover without duplicates?

#### 1. Concept
Terraform is **not an all-or-nothing transaction** across Azure resources. If the apply creates a VNet and two subnets but fails on AKS, successfully completed resources normally remain deployed and are recorded in state. Some failures can happen after Azure creates a resource but before Terraform successfully records it, so you must check both state and Azure.

#### 2. Implementation — Step by Step
1. Stop repeated pipeline retries and preserve the failed apply logs, run ID and correlation/request IDs.
2. Inspect the failed resource operation in Azure Activity Log and deployment operation details.
3. Run `terraform state list`; compare completed objects with Azure CLI or Resource Graph.
4. Fix the real cause—quota, Azure Policy denial, subnet delegation, permissions, resource provider registration, unsupported SKU or a transient Azure API failure.
5. If Azure created an object but state lacks it, **import** the existing object into the correct address. If state already tracks it, do not import again.
6. Generate a new plan from the current state, review expected remaining operations and apply only after approval.

```bash
terraform state list
terraform plan -out=retry.tfplan
terraform show retry.tfplan
terraform apply retry.tfplan
```

#### 3. Production Example
A pipeline provisions a VNet and subnets but AKS creation fails due to insufficient regional quota. I confirm the network resources are recorded, request quota or adjust approved capacity, then create a new plan. Terraform should show the AKS work still required, not a full recreation of networking.

#### 4. Troubleshooting
Check Azure errors such as 403 (permissions/policy), 409 (name or resource conflict), 429 (throttling) and allocation failures. If the state backend write failed, Terraform may have written an emergency local state file—secure it and follow HashiCorp's recovery guidance rather than starting a fresh apply. **Interview conclusion:** inspect partial success, reconcile state, solve the root cause, re-plan.

---

<a id="q14"></a>
### Question 14: Explain Terraform state locking in Azure Blob Storage. What if a lock remains after a pipeline failure?

#### 1. Concept
Terraform state locking prevents two writers from updating the same state concurrently. The AzureRM backend uses an **Azure Blob lease** on the state blob to coordinate supported operations. A stale lock may remain if an execution agent dies or loses network connectivity. Forcing it open without checking could allow concurrent modifications and state loss.

#### 2. Implementation — Step by Step
1. Identify the environment, storage account, container, blob key and Terraform lock ID displayed in the error.
2. Check Azure DevOps/HCP Terraform for a still-running or stuck apply. Contact the run owner and verify that no process is actively writing state.
3. Inspect the Azure blob lease status and pipeline logs; investigate whether storage networking or credentials caused the lock to remain.
4. If it is truly an orphaned lock, follow an approved recovery procedure to unlock using Terraform's lock ID. For storage-level lease problems, use Azure storage recovery procedures with the backend owner.
5. Re-run `terraform plan` and look for unexpected changes before resuming apply.

```bash
terraform plan -lock-timeout=5m
# ONLY after proving the locking process is dead:
terraform force-unlock <LOCK_ID>
```

#### 3. Production Example
An Azure DevOps agent crashes while applying a route table change. A second run fails to obtain the lock. I inspect the original run and Azure Activity Log to ensure it is no longer changing resources, force-unlock only with change approval, and validate state consistency before re-running.

#### 4. Troubleshooting
If `force-unlock` refuses the ID, check that your working directory points to the same state key/workspace. A locked blob might also indicate missing Blob Data permissions. Avoid `-lock=false`; it may hide the symptom while creating two writers. **Interview conclusion:** first establish the lock owner and state health; unlock only a confirmed orphan.

---

<a id="q15"></a>
### Question 15: How would you design and secure a Terraform remote backend using Azure Blob Storage?

#### 1. Concept
Remote state enables team collaboration, state locking and centralized protection. The state can contain passwords, connection strings and other sensitive values even if Terraform marks CLI outputs as sensitive. Production backend design needs **identity, encryption, backups, private networking, access control and audit logs**.

#### 2. Implementation — Step by Step
1. Create a dedicated storage account and private state container (often in a platform subscription) with public blob access disabled.
2. Enable storage encryption, blob versioning/soft delete where compatible, appropriate retention, monitoring and backup procedures.
3. Protect network access using a private endpoint plus Private DNS and ensure CI agents can actually resolve/reach it.
4. Assign least-privilege **Storage Blob Data Contributor** for state-writing identities at the narrowest suitable scope. Prefer Microsoft Entra authentication and workload identity federation/managed identity over account keys.
5. Configure the `azurerm` backend and authenticate separately for the AzureRM provider as needed. Never commit backend secrets to Git.

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstateexample123"
    container_name       = "tfstate"
    key                  = "prod/network.tfstate"
    use_azuread_auth     = true
  }
}
```

```bash
terraform init
terraform state list
```

#### 3. Production Example
Each production team uses a distinct backend key, one protected storage platform and CI identities with access to only relevant state. Blob versioning provides recovery evidence, while Azure DevOps environment checks control production applies. State access logs are retained according to the organization's policy.

#### 4. Troubleshooting
A 403 at initialization may involve Azure Storage **data-plane** RBAC, bad token/tenant or storage firewall. A DNS timeout often means an agent cannot reach the private endpoint; verify private DNS from that actual agent network. If locking fails, confirm lease permissions. **Interview conclusion:** backend state deserves controls comparable to sensitive production data.

---

<a id="q16"></a>
### Question 16: Explain `terraform state list`, `show`, `mv`, `rm`, `pull` and `push` with production examples.

#### 1. Concept
Terraform state commands inspect or intentionally change the relationship between HCL addresses and cloud resources. They are powerful, so state mutation must be coordinated. **`state rm` forgets a resource; it does not delete the live object.** **`state push` writes a snapshot to a backend** and is risky, particularly with `-force`.

#### 2. Implementation — Step by Step
| Command | Purpose | Production use |
|---|---|---|
| `terraform state list` | List managed addresses | Inventory resources tracked by a state |
| `terraform state show ADDRESS` | Inspect one object | Compare its ID and settings with Azure |
| `terraform state mv SOURCE DEST` | Move an address within the state | Refactor module/resource addresses carefully |
| `terraform state rm ADDRESS` | Remove binding only | Handover to another owner without deleting Azure object |
| `terraform state pull` | Export current state snapshot | Secure recovery/diagnostic backup |
| `terraform state push FILE` | Write state snapshot | Rare approved disaster recovery operation |

```bash
terraform state list
terraform state show azurerm_resource_group.app
terraform state pull > protected-backup.tfstate
# Protected-backup.tfstate may contain secrets: encrypt, restrict and delete securely.
```

For refactoring, prefer **declarative `moved` blocks** committed to Git. For long-lived handoffs, consider `removed` blocks with `destroy = false` when supported.

#### 3. Production Example
A resource previously at `azurerm_resource_group.app` must move to `module.foundation.azurerm_resource_group.app`. I add a `moved` block in the same PR and verify the plan shows an address move rather than destroy/recreate. I would not casually manipulate state by hand.

#### 4. Troubleshooting
Before mutating state, back it up, stop concurrent applies, confirm the correct backend and check whether a target address already exists. If `state push` reports lineage or serial conflicts, do **not** bypass it without understanding the mismatch. **Interview conclusion:** state is a live production control plane, not an ordinary editable file.

---

<a id="q17"></a>
### Question 17: What if Terraform state becomes corrupted or inconsistent with Azure resources?

#### 1. Concept
Corruption could mean unreadable JSON, missing mappings, wrong resource IDs, provider schema incompatibility or a failed backend write. Some “inconsistencies” are ordinary Azure drift, not file corruption. Recovery must identify which case exists before changing state.

#### 2. Implementation — Step by Step
1. Stop all state writers and preserve the error output, current backend blob and available versions.
2. Check whether Terraform can read state with `terraform state list` or `terraform state pull`. Protect any extracted file as sensitive.
3. Compare the state snapshot with a recent validated version, code commit and actual Azure resources.
4. If actual state bytes are damaged, restore an earlier verified version using backend-specific recovery (Blob versioning/soft delete or Enterprise state history).
5. If mappings are missing but the file is valid, use supported state/import operations to reconcile one resource at a time. If a provider change is responsible, review provider pinning/schema migration before altering state.
6. Run a normal plan and demand **zero unexpected destructive changes** before resuming.

#### 3. Production Example
A deployment logs a failure saving state to remote Azure Storage. Terraform has saved an emergency local snapshot. I secure the file, freeze pipelines, verify it matches Azure changes, and follow the supported state recovery procedure rather than overwriting production with an older snapshot.

#### 4. Troubleshooting
Check backend network access, blob lease, storage permissions and state lineage/serial. A plan with resources missing is not proof they were deleted: inspect Azure directly. Do not hand-edit JSON or run `state push -force` as a first response. **Interview conclusion:** preserve evidence, restore from trusted history, then reconcile reality before apply.

---

<a id="q18"></a>
### Question 18: Terraform state may contain secrets. How would you protect credentials and sensitive state data?

#### 1. Concept
Marking a Terraform variable `sensitive = true` hides values from some CLI display, but sensitive values may still exist in **state and saved plan files**. Therefore protecting state is a data-security and compliance requirement, especially for banking systems.

#### 2. Implementation — Step by Step
1. Store state in a controlled remote backend, not Git or a shared engineer laptop.
2. Use managed identity/workload identity federation; avoid long-lived service-principal secrets and account keys.
3. Grant separate least-privilege backend permissions to plan identities, apply identities and auditors.
4. Restrict backend networking (private endpoints where suitable), enable encryption, logging, versioning/soft-delete and restricted restore access.
5. Mask pipeline outputs, lock down saved plans and do not publish `terraform show -json` artifacts publicly—plan JSON can contain sensitive values.
6. Keep application secrets in Key Vault and prefer runtime secret references or external secret stores, while verifying how each Terraform resource stores secret content in state.
7. Rotate exposed credentials immediately and audit state access if leakage is suspected.

#### 3. Production Example
For a payments AKS platform, Terraform identities access Azure only via federated service connections, and the remote state account is in a protected subscription. Plan artifacts are kept for a short policy-approved retention period, accessible only to deployment reviewers.

#### 4. Troubleshooting
If a secret appears in a CI log, revoke/rotate it, restrict artifact access and check Git history, build logs and state snapshots. Simply adding `sensitive = true` later does not remove earlier copies. **Interview conclusion:** secure state and plans as carefully as application secrets.

---

<a id="q19"></a>
### Question 19: `terraform init` cannot reach the Azure Storage backend. How would you troubleshoot authentication and networking?

#### 1. Concept
`terraform init` first initializes the **backend** before normal provider operations. Backend authentication and network reachability may differ from the credentials used to create Azure resources. A pipeline that can deploy an Azure VM can still fail to access the Blob state container.

#### 2. Implementation — Step by Step
1. Read the actual error: DNS timeout, TCP/TLS issue, 401 authentication, 403 authorization, blob/container not found or lease conflict.
2. Check backend configuration: storage account name, resource group, container, state key, subscription and tenant context.
3. Verify the agent's identity and **Blob data-plane role**; test access using Azure CLI with Microsoft Entra authentication where configured.
4. From the agent network, check the storage FQDN, private endpoint DNS resolution and outbound HTTPS connectivity.
5. Validate OIDC token/workload identity settings, token audience/issuer, federated credential and Azure DevOps service connection.
6. If recently changing backend configuration, use `terraform init -reconfigure` after confirming the intended destination, and `-migrate-state` only for an explicitly approved state migration.

```bash
az account show
nslookup <storage-account>.blob.core.windows.net
az storage blob list --account-name <storage-account> \
  --container-name tfstate --auth-mode login -o table
```

#### 3. Production Example
A self-hosted agent is moved to a new subnet. Terraform init starts timing out because the private DNS zone isn't linked to the agent VNet. I fix the DNS and route path instead of opening the state account publicly.

#### 4. Troubleshooting
Differentiate storage control-plane permissions from `Storage Blob Data Contributor`. An HTTP 403 can also come from the storage firewall even when RBAC is correct. Avoid printing backend credentials. **Interview conclusion:** troubleshoot identity, DNS, network, and backend target independently.

---

<a id="q20"></a>
### Question 20: How would you migrate Terraform state from local to Azure Blob Storage or Terraform Enterprise safely?

#### 1. Concept
Backend migration changes **where state is stored**, not where the Azure resources run. If done correctly, existing Azure resources retain their identities. An incorrect migration can create an empty state in the destination and lead to duplicate resource plans.

#### 2. Implementation — Step by Step
1. Freeze all applies and record exact source state, Git commit, Terraform version, provider lockfile and workspace name.
2. Back up the local state securely; inspect lineage, serial and expected resource addresses.
3. Provision and secure the destination Azure backend or Enterprise workspace; configure access and workspace naming.
4. Add or update backend/cloud configuration and follow Terraform's prompted state migration procedure, typically using `terraform init -migrate-state` for supported backends.
5. Inspect destination with `terraform state list` and compare mapping counts/resource IDs.
6. Run a normal plan and confirm no unexpected resource recreation. After validation, revoke unnecessary access to old state and securely retire local copies.

```bash
terraform state pull > protected-before-migration.tfstate
terraform init -migrate-state
terraform state list
terraform plan
```

#### 3. Production Example
A five-engineer team has been using state files on one laptop. I migrate each application root into a dedicated production Azure Blob backend key, introduce approvals and roles, then validate clean plans before enabling automated pipelines.

#### 4. Troubleshooting
If the destination shows no resources, check backend key/workspace selection before any apply. Terraform Enterprise remote-run workflow is different from an Azure backend; confirm destination semantics rather than copying local files blindly. Protect backup files and never commit them to Git. **Interview conclusion:** freeze, back up, migrate, verify resource mapping, then resume.

---

<a id="section-c"></a>
## Section C — Terraform Modules, Advanced HCL and Azure Provisioning (Questions 21–30)

<a id="q21"></a>
### Question 21: How would you design reusable Terraform modules for Azure subscriptions, VNets, AKS clusters, regions and applications?

#### 1. Concept
A **Terraform module** is a reusable package of configuration. The root module calls child modules using `module` blocks and supplies variables. Modules reduce copied code and enforce organizational standards, but they should have clear ownership and narrow responsibilities. Enterprise design usually combines reusable modules with **separate environment root configurations and separate state files**.

#### 2. Implementation — Step by Step
1. Create modules for `resource-group`, `network`, `private-endpoint`, `aks`, `monitoring` and `key-vault`, each with documented variables, outputs and required provider versions.
2. Use folders such as `environments/dev`, `environments/qa`, `environments/prod`, each with its own backend key and deployment identity.
3. Pin reviewed module versions (for example Git release tags or an internal module registry), and use code review before upgrades.
4. Keep secrets out of module defaults; use references and identities, and validate important inputs (CIDRs, locations, sizes).
5. Connect modules through outputs: network module exports subnet IDs consumed by AKS/application modules. Avoid circular dependencies.

```hcl
module "network" {
  source              = "../../modules/network"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.20.0.0/16"]
}
module "aks" {
  source    = "../../modules/aks"
  subnet_id = module.network.aks_subnet_id
  location  = var.location
}
```

#### 3. Production Example
Our networking team maintains a reviewed VNet module. Payments, fraud and reporting teams use the same module version in different subscriptions. Platform engineers upgrade one environment at a time after a plan shows no unintended replacements.

#### 4. Troubleshooting
When changes in a shared module unexpectedly affect many resources, check version pinning and module output contracts. Avoid mega-modules that manage everything; a network fix should not require an application database migration. **Interview conclusion:** reusable module standards plus isolated environment states make Terraform maintainable and safer.

---

<a id="q22"></a>
### Question 22: What is the difference between `count`, `for_each` and `dynamic` blocks, and when would you use each?

#### 1. Concept
`count` repeats a **resource or module by numeric index** (e.g. `[0]`, `[1]`). `for_each` repeats resources/modules by stable **map keys or set values** (e.g. `["payments"]`), which is usually safer for independently named infrastructure. `dynamic` repeats **nested blocks inside a resource**; it does not itself create multiple top-level resources.

#### 2. Implementation — Step by Step
**Count**, useful for identical temporary resources:
```hcl
resource "azurerm_resource_group" "batch" {
  count    = 2
  name     = "rg-batch-${count.index + 1}"
  location = "eastus"
}
```
**For each**, useful for named environments:
```hcl
resource "azurerm_resource_group" "team" {
  for_each = toset(["payments", "fraud"])
  name     = "rg-${each.key}"
  location = "eastus"
}
```
**Dynamic**, useful for a nested set of NSG rules:
```hcl
resource "azurerm_network_security_group" "app" {
  name                = "nsg-app"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = security_rule.value.source
      destination_address_prefix = "*"
    }
  }
}
```

#### 3. Production Example
I use `for_each` for named NSGs, subnets and environments. If a team is removed from a map, other resources keep their stable keys. I use a `dynamic` block for repeated inline rules when appropriate, or separate rule resources if independent management is needed.

#### 4. Troubleshooting
With `count`, removing the middle item of a list can shift indexes and produce unwanted changes. With `for_each`, changing the key itself changes resource identity; use a `moved` block where appropriate. Never manage the same NSG security rules as both inline blocks and separate rule resources. **Interview conclusion:** choose identity stability first, then code convenience.

---

<a id="q23"></a>
### Question 23: How do Terraform provider aliases deploy resources into two Azure subscriptions?

#### 1. Concept
A provider configuration tells Terraform which Azure subscription and tenant it will use. **Provider aliases** let one root configuration address multiple subscriptions—for example central hub networking in Subscription A and application networking in Subscription B. Every action must use the intended provider identity and permissions.

#### 2. Implementation — Step by Step
1. Prepare two authorized deployment identities or a federated identity with access to both subscriptions.
2. Configure default and aliased `azurerm` providers with the correct subscription IDs and supported credentials.
3. Set `provider = azurerm.app` on individual resources or pass provider mappings to child modules.
4. Use explicit, non-overlapping VNet CIDRs and both VNet IDs for cross-subscription peering.
5. Check state address and provider metadata during plan reviews.

```hcl
provider "azurerm" {
  features {}
  subscription_id = var.hub_subscription_id
}
provider "azurerm" {
  alias           = "app"
  features {}
  subscription_id = var.app_subscription_id
}
resource "azurerm_resource_group" "hub" {
  name     = "rg-hub"
  location = "eastus"
}
resource "azurerm_resource_group" "app" {
  provider = azurerm.app
  name     = "rg-app"
  location = "eastus"
}
```

#### 3. Production Example
A hub-and-spoke design places Azure Firewall and shared DNS in a connectivity subscription, with application VNets in separate workload subscriptions. One coordinated networking root can create cross-subscription peering if approved identities have network permissions in both subscriptions.

#### 4. Troubleshooting
An error like `AuthorizationFailed` may mean the apply identity has access to the hub but not the app subscription. Verify `subscription_id`, tenant, access scopes, provider alias in a child module and role assignments. Never “fix” by granting Owner across all subscriptions. **Interview conclusion:** aliases separate resource targets; permissions and state boundaries provide control.

---

<a id="q24"></a>
### Question 24: How would you provision VNets, subnets, NSGs, routes, private endpoints and private DNS using Terraform modules?

#### 1. Concept
Azure networking has dependencies. A VNet must exist before its subnets; subnet associations need the referenced NSGs/route tables; private endpoints often need service resources and DNS zones. Terraform infers dependencies from attribute references, so one plan can apply resources in a safe order without manually writing every `depends_on`.

#### 2. Implementation — Step by Step
1. Define address-space and subnet CIDR variables with validation and no overlaps.
2. Create the VNet, subnet resources, NSGs and route tables in a `network` module.
3. Associate NSGs and route tables with subnets using distinct Terraform resources. For UDRs, specify next hop and firewall/NVA IP only when the routing design requires it.
4. Create private endpoints in approved subnets; configure the service's appropriate Private DNS zone, zone group and VNet links.
5. Configure private DNS and test endpoint names from the workload network before disabling public service access.
6. Output subnet, NSG, route-table and private DNS zone IDs for dependent modules. Enable diagnostics and enforce rules through Azure Policy.

```hcl
resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.app.id
}
resource "azurerm_subnet_route_table_association" "app" {
  subnet_id      = azurerm_subnet.app.id
  route_table_id = azurerm_route_table.app.id
}
```

#### 3. Production Example
I configure `10.20.0.0/16` as the app VNet with dedicated AKS, database private endpoint and application subnets. A central Azure Firewall inspects selected outbound routes. The AKS module consumes the `aks_subnet_id` output and database connectivity uses private DNS rather than public IPs.

#### 4. Troubleshooting
If a private endpoint resolves publicly, check DNS zone name, zone group, links and custom DNS forwarding. If traffic is blocked, inspect effective routes and NSGs; Terraform apply success alone doesn't guarantee connectivity. **Interview conclusion:** model network dependencies in HCL and validate traffic paths after deployment.

---

<a id="q25"></a>
### Question 25: Explain `ignore_changes`, `prevent_destroy`, `create_before_destroy` and `replace_triggered_by`. What are their production risks?

#### 1. Concept
Terraform `lifecycle` settings modify normal creation, update and replacement behavior. They are **safety/design controls**, not substitutes for change approvals. `ignore_changes` suppresses updates for selected configured attributes; `prevent_destroy` blocks a planned destruction while the rule remains in configuration; `create_before_destroy` attempts replacement by building new before removing old; `replace_triggered_by` triggers replacement when named managed dependencies change.

#### 2. Implementation — Step by Step
```hcl
resource "azurerm_storage_account" "critical" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags["LastPatchedBy"]]
  }
}
```
1. Use `prevent_destroy` selectively on critical stateful resources, understanding that removing the entire resource block can remove that protection.
2. Use `ignore_changes` narrowly where another approved system owns an attribute. Never ignore all security settings.
3. Use `create_before_destroy` only where Azure allows temporary duplicate resources and names/quotas permit it.
4. Use `replace_triggered_by` for explicitly connected resources that must be rebuilt on a managed change.
5. Review every plan's lifecycle-induced replacement behavior.

#### 3. Production Example
I protect a critical storage account with `prevent_destroy`. A deployment that would remove it fails before deleting the account, prompting a review. For VM replacements behind a load balancer, I plan capacity and unique names before considering create-before-destroy.

#### 4. Troubleshooting
An immutable storage account name prevents creating the replacement with the same name first. A lifecycle rule can also propagate dependencies or hide important drift. If a delete unexpectedly becomes possible, verify the protection block still exists. **Interview conclusion:** lifecycle settings are useful guardrails with real limitations.

---

<a id="q26"></a>
### Question 26: How do you manage dependencies between resources, modules and separate Terraform states?

#### 1. Concept
Terraform builds a dependency graph based on **references**. When Resource B references Resource A's `id`, Terraform understands A must be handled first. `depends_on` adds an explicit dependency when no data reference captures the relationship. **Separate states** do not share one automatic dependency graph, so teams must sequence deployments and manage inputs deliberately.

#### 2. Implementation — Step by Step
1. Prefer direct references such as `subnet_id = module.network.subnet_id` inside the same state.
2. Use `depends_on` sparingly when a resource has a real ordering dependency but does not reference another value.
3. For separate states, publish needed subnet IDs, private DNS zone IDs or resource IDs through stable outputs or a governed configuration interface.
4. Deploy network/base services first; validate outputs; trigger workload deployment afterward.
5. Use pipeline dependency gates or Terraform Enterprise run triggers where suitable, and enforce access control for shared outputs.

```hcl
module "aks" {
  source    = "../../modules/aks"
  subnet_id = module.network.aks_subnet_id
}
```

#### 3. Production Example
The networking team controls a shared hub and spoke subnet. The payments AKS deployment consumes the approved subnet ID after the network pipeline succeeds. Database and application components then deploy in dependency order, but their individual states remain team-owned.

#### 4. Troubleshooting
If a module shows “depends on resource that is not yet ready,” verify both the reference and the Azure resource's actual readiness, since API propagation may take time. If separate teams change outputs without warning, downstream plans fail—version and document interfaces. Excessive `depends_on` can make plans overly conservative. **Interview conclusion:** references within a state, contracts and orchestration across states.

---

<a id="q27"></a>
### Question 27: How would you move a Terraform-managed resource from the root into a child module without recreating it?

#### 1. Concept
Changing an HCL resource address ordinarily looks like a deletion at the old address and creation at the new one. A Terraform **`moved` block** tells Terraform these two addresses refer to the same resource, so it updates the state mapping without deleting the Azure object.

#### 2. Implementation — Step by Step
1. Back up state and stop competing applies.
2. Create the child module and make sure it uses the same resource attributes and provider configuration.
3. Remove the old root resource block, add the equivalent resource inside the module, then put a `moved` block in the parent/root configuration.
4. Run `terraform plan`. Confirm it reports a move and **no unexpected replacement**.
5. Merge and apply through the normal approved production workflow. Keep the move mapping for downstream workspaces until they have migrated.

```hcl
module "foundation" {
  source = "../../modules/foundation"
}

moved {
  from = azurerm_resource_group.app
  to   = module.foundation.azurerm_resource_group.app
}
```

#### 3. Production Example
An early project created resource groups in the root module. We standardize them under `foundation`. The moved block preserves existing Azure resource IDs and avoids business disruption while bringing the project in line with enterprise module standards.

#### 4. Troubleshooting
If the plan still suggests recreation, check source/target addresses, resource types, module arguments and provider aliases. If two states are involved, a simple `moved` block is not a complete cross-state transfer process; plan a controlled handoff/import. **Interview conclusion:** refactor state addresses, not production infrastructure.

---

<a id="q28"></a>
### Question 28: Write Terraform using `for_each` and `dynamic` blocks to generate Azure NSG rules from YAML or JSON.

#### 1. Concept
Instead of hardcoding 20 similar rules, we can store a reviewed **YAML or JSON rule specification**, parse it using Terraform, validate it and generate nested NSG rules. This makes firewall rule reviews simpler, but requires strict validation so configuration files cannot introduce dangerous `0.0.0.0/0` inbound access.

#### 2. Implementation — Step by Step
Example `nsg-rules.yaml`:
```yaml
app:
  - name: AllowHttpsFromCorporate
    priority: 110
    port: "443"
    source: "10.100.0.0/16"
  - name: AllowApiFromWeb
    priority: 120
    port: "8080"
    source: "10.20.2.0/24"
```
Terraform configuration:
```hcl
locals {
  nsg_rules = yamldecode(file("${path.module}/nsg-rules.yaml"))
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = local.nsg_rules
  name                = "nsg-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = each.value
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = security_rule.value.source
      destination_address_prefix = "*"
    }
  }
}
```

#### 3. Production Example
We manage different `web`, `api` and `admin` NSGs through separate YAML entries. A PR adding port 443 requires review of source CIDR, port and priority, and pipeline validation blocks insecure ranges.

#### 4. Troubleshooting
Duplicate priorities or invalid address ranges cause Azure API failures. YAML indentation errors can make `yamldecode` fail; verify with `terraform console` and `terraform validate`. For finer ownership, use separate NSG rule resources **instead of** inline rules, not both on the same NSG. **Interview conclusion:** configuration-driven rules require validation and policy controls.

---

<a id="q29"></a>
### Question 29: How do variable validation, locals, preconditions, postconditions and check blocks protect Terraform deployments?

#### 1. Concept
Terraform supports several layers of validation. **Variable validation** checks inputs; **locals** simplify derived expressions; **preconditions** enforce assumptions before proceeding with a resource/data/output operation; **postconditions** assert conditions about results; **check blocks** evaluate non-blocking assertions and report warnings rather than normally preventing deployment.

#### 2. Implementation — Step by Step
```hcl
variable "location" {
  type = string
  validation {
    condition     = contains(["eastus", "westus2"], var.location)
    error_message = "Location must be an approved Azure region."
  }
}
variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "Unknown environment."
  }
}
locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
```
1. Validate required tags, approved regions, CIDRs and SKU limits at the module boundary.
2. Use preconditions when a data-source output or resource dependency must meet an assumption before creating something.
3. Use postconditions to check important resulting properties and document contract expectations.
4. Use check blocks for independent health assertions and warnings, not as the sole guard against unsafe production changes.
5. Also enforce external policy (Sentinel/OPA, Azure Policy, security scanning) for organization-wide controls.

#### 3. Production Example
A team requests an AKS deployment in an unapproved region. Variable validation rejects the configuration before an Azure API call. A policy check separately blocks public IP resources in production regardless of which module is used.

#### 4. Troubleshooting
If a variable passes validation but Azure rejects a value, check provider-specific constraints and the resolved variable source (`tfvars`, pipeline variables). If a check only warns, it might not stop apply—use a blocking validation or policy where enforcement is required. **Interview conclusion:** catch mistakes early and enforce critical rules centrally.

---

<a id="q30"></a>
### Question 30: How do you manage Terraform module/provider versions, and what if an AzureRM upgrade proposes replacements?

#### 1. Concept
Providers translate Terraform resources into Azure API requests. Provider upgrades can change defaults, schemas, validation or the handling of attributes. Module releases can also introduce breaking changes. **Production should not automatically absorb every new provider/module release.**

#### 2. Implementation — Step by Step
1. Define required Terraform and provider constraints in `terraform` blocks.
2. Commit `.terraform.lock.hcl` so the team uses selected provider versions. Pin reusable modules to versioned registry releases or Git tags.
3. Test upgrades first in a small nonproduction environment and review provider release notes/migration instructions.
4. Run `terraform init -upgrade` only in a controlled upgrade branch, then review a full plan.
5. Compare resources marked for replacement, provider aliases and state migrations. Resolve breaking changes or postpone upgrade before promoting to QA/prod.

```hcl
terraform {
  required_version = ">= 1.6, < 2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"  # Example policy; pin a reviewed version via lockfile
    }
  }
}
```

#### 3. Production Example
We test an AzureRM major upgrade in dev. A VM argument is deprecated and two resources show replacement. The team updates module code and tests the migration on noncritical resources; only after a clean QA plan do we promote the new lockfile.

#### 4. Troubleshooting
If replacements appear unexpectedly, compare old/new provider schemas, changed defaults and implicit resource IDs. Do not run `terraform apply` in production merely to see whether it works. Reverting Git configuration alone may not fully reverse a provider-driven state schema upgrade—plan rollback compatibility before changing versions. **Interview conclusion:** version changes are managed migrations, not automatic housekeeping.

---

<a id="section-d"></a>
## Section D — Terraform with Azure DevOps, CI/CD and Production Deployments (Questions 31–39)

<a id="q31"></a>
### Question 31: Design an Azure DevOps Terraform pipeline with `init`, `fmt`, `validate`, `plan`, manual approval and `apply`.

#### 1. Concept
A safe infrastructure pipeline separates **validation**, **reviewable planning**, **production approval** and **application**. The plan stage should not modify Azure; the apply stage uses the **approved saved plan**. Azure DevOps **Environments** can have approvals and checks configured in the Azure DevOps UI. Those approvals are not normally authored directly inside the YAML file.

#### 2. Implementation — Step by Step
1. Store Terraform in Git and configure an Azure Storage remote backend with locking. Protect the main branch.
2. Configure an Azure Resource Manager service connection with workload identity federation (when supported) and appropriate permissions.
3. Run Terraform `fmt -check`, `init -input=false`, `validate`, static checks and a saved `plan` in the first pipeline stage.
4. Publish the saved plan as a **restricted pipeline artifact**; also publish a human-readable summary of its actions for review.
5. Create a `production` Azure DevOps Environment and configure required approvers/checks in the UI.
6. In a `deployment` job targeting that environment, download the **same saved plan**, initialize the same backend and use `terraform apply tfplan`. Validate service health and archive audit evidence.

Illustrative pipeline structure:
```yaml
stages:
- stage: Plan
  jobs:
  - job: TerraformPlan
    steps:
    - script: terraform fmt -check -recursive
    - script: terraform init -input=false && terraform validate
    - script: terraform plan -input=false -out=tfplan
    - publish: tfplan
      artifact: terraform-plan

- stage: Apply
  dependsOn: Plan
  jobs:
  - deployment: ProductionApply
    environment: production   # Configure approval in the Environment UI
    strategy:
      runOnce:
        deploy:
          steps:
          - download: current
            artifact: terraform-plan
          # Authenticate using an approved Azure service connection.
          # Initialize the EXACT SAME backend before this step.
          - script: terraform apply -input=false "$(Pipeline.Workspace)/terraform-plan/tfplan"
```
This is a **pipeline skeleton**: working directories, Terraform installation, authentication, backend configuration and protected artifacts must be configured for your project.

#### 3. Production Example
The networking team raises a PR to add a private endpoint. CI validates code, security scans it and creates a plan. A platform owner reviews the actual affected resources and approves the Azure DevOps production environment. Only then does the deployment job apply the saved plan and verify DNS/connectivity.

#### 4. Troubleshooting
If the apply agent cannot find the plan, check artifact path and working directory. If apply has no Azure credentials, check the service connection is available in the deployment job—not just the plan job. If an approval isn't triggered, confirm the deployment job actually targets the protected Environment. **Interview conclusion:** plan once, approve evidence, apply that exact plan with secure credentials.

---

<a id="q32"></a>
### Question 32: How would you ensure an approver reviews the exact Terraform plan that production will apply?

#### 1. Concept
A common mistake is running `terraform plan` in one stage but plain `terraform apply` in another. A plain apply recalculates a **new plan**, so the reviewer may not be approving the actual changes. A **saved execution plan** connects approval to a specific plan. Treat it as sensitive because plan data may include secret values.

#### 2. Implementation — Step by Step
1. Check out the exact Git commit and pin Terraform/provider versions and the dependency lockfile.
2. Generate `terraform plan -out=tfplan`. Display the human-readable `terraform show tfplan` output to authorized reviewers.
3. Publish `tfplan` as a restricted, immutable-in-practice artifact associated with that pipeline run. Optionally record an artifact hash and run ID in the approval record.
4. Configure required checks/approvals on the Azure DevOps production Environment or protected resource.
5. After approval, download the **same artifact**, re-initialize the same backend, and run `terraform apply tfplan`, **not** a new bare apply.
6. If the plan is rejected as stale or state changed, discard it, create and reapprove a fresh plan.

```bash
terraform plan -out=tfplan
terraform show tfplan
sha256sum tfplan      # Example audit fingerprint on Linux agents
terraform apply tfplan
```

#### 3. Production Example
A proposed NSG change includes one rule addition. The reviewer checks the plan for unexpected public IPs or deletes. The later production stage runs the saved plan from the reviewed pipeline. Another pipeline's intervening state changes cause a stale-plan error rather than silent re-planning.

#### 4. Troubleshooting
Saved plans include backend/state assumptions and potentially sensitive values. Check backend key, Terraform/provider versions, workspace and artifact integrity if apply fails. A stale plan is **protection**, not something to bypass; re-plan and reapprove. **Interview conclusion:** approval must bind to the exact saved plan and state snapshot.

---

<a id="q33"></a>
### Question 33: Terraform works locally but fails in Azure DevOps with authentication or authorization errors. How do you investigate?

#### 1. Concept
A developer might use personal `az login`, while the pipeline uses a service connection/federated identity. These are different Azure principals and can have different RBAC permissions. Also, Terraform's **backend storage access** and **provider resource permissions** can require separate checks. Errors can originate from identity, Azure Policy, private networking or wrong subscription.

#### 2. Implementation — Step by Step
1. Identify whether the error occurs in `init`, `plan` or `apply`. Save status code and Azure correlation ID.
2. Verify the Azure DevOps service connection's subscription, tenant, federated credential and approved resource scope.
3. Inspect which identity actually reaches Azure in the pipeline; compare with local account permissions. Use an approved `AzureCLI@2` task or suitable Terraform task to establish identity and documented OIDC variables.
4. For Azure resource 403s, check Reader/Contributor/Network Contributor or resource-specific roles and Azure Policy. For Blob backend errors, check `Storage Blob Data Contributor` plus storage firewall/private DNS.
5. Validate self-hosted agent reachability to the Azure management endpoint and any private storage/Key Vault endpoints.
6. Retry only after fixing the underlying access or network issue.

```bash
az account show --query '{subscription:id,tenant:tenantId,user:user.name}'
az role assignment list --assignee <principal-object-id> --all -o table
```

#### 3. Production Example
My local plan succeeds because I have broad Contributor access, but the CI service principal cannot create VNet peering in Subscription B. I grant the minimum networking permission to the pipeline identity in B and rerun through approval instead of using personal credentials in CI.

#### 4. Troubleshooting
401 suggests credentials/token issues; 403 suggests permission, policy or network restrictions; 404 may mean wrong subscription/resource ID or limited visibility. Federated credentials can also fail due to issuer/subject mismatch. Never add a client secret to logs as a shortcut. **Interview conclusion:** confirm the pipeline identity and distinguish backend permissions from provider permissions.

---

<a id="q34"></a>
### Question 34: Terraform pipeline fails halfway through AKS or networking provisioning. How would you recover?

#### 1. Concept
Azure creates resources through asynchronous APIs. A Terraform operation may return an error after earlier resources succeeded or while a later resource is still provisioning. You need to distinguish a failed Terraform process from a failed Azure deployment operation. Automatic retrying without state verification can create duplicate names or inconsistent resources.

#### 2. Implementation — Step by Step
1. Stop repeated pipeline retries and record the Terraform logs, Azure activity IDs and the exact failed step.
2. Run `terraform state list` against the correct remote state and inspect relevant Azure Resource Provider operations.
3. For AKS, inspect managed cluster provisioning state, subnet capacity, IP exhaustion, route/NSG settings, VM quota, identity permissions and node-pool status.
4. Fix the problem with the appropriate team; if Azure created an untracked resource, import it instead of recreating it.
5. Generate a **new** reviewed plan after partial failure. Do not reuse the old saved plan after state changes.
6. Resume deployment only after validating healthy networking/cluster prerequisites and obtaining approval.

```bash
az aks show -g <rg> -n <aks> --query provisioningState -o tsv
az network vnet subnet show -g <rg> --vnet-name <vnet> -n <subnet> --query addressPrefix -o tsv
terraform state list
terraform plan
```

#### 3. Production Example
An AKS cluster creation fails due to exhausted subnet addresses. The VNet and ACR already exist. I confirm their state entries, select a corrected, approved subnet strategy, recreate a plan that touches only remaining tasks, and perform a smoke test once AKS is ready.

#### 4. Troubleshooting
For permission errors check managed identity role assignments; for DNS issues check private cluster DNS; for quota errors check regional SKU availability. A failed apply is not a reason to run `terraform destroy`. **Interview conclusion:** establish what's already created, repair the cause, then re-plan from current state.

---

<a id="q35"></a>
### Question 35: How would you integrate TFLint, Checkov and policy-as-code into Terraform CI/CD?

#### 1. Concept
Infrastructure security needs more than syntax validation. `terraform fmt` checks formatting, `validate` checks configuration consistency, TFLint catches linting/provider issues, Checkov scans IaC security policies, and Sentinel/OPA can enforce mandatory organization rules. Azure Policy independently constrains what Azure can deploy.

#### 2. Implementation — Step by Step
1. Run fast checks in PR validation: formatting, `init -backend=false` where appropriate, validation and linting.
2. Run Checkov with an approved policy baseline and produce machine-readable reports.
3. Review exceptions with explicit reason, owner and expiry; block high-risk misconfigurations such as public access to sensitive storage.
4. On an actual Terraform plan, enforce organization-wide policy-as-code before the production apply.
5. Store reports and approvals with the pipeline for audit and improve policies based on production incidents.

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
tflint --init && tflint
checkov -d .
```

#### 3. Production Example
A PR adds an NSG that allows management ports from `0.0.0.0/0`. Checkov flags the dangerous rule, and an organization-level policy blocks the planned production deployment. The developer corrects the source range before merge.

#### 4. Troubleshooting
False positives occur when tools do not see runtime values or provider defaults. Inspect the exact violated control; do not disable entire scanners. Keep scanner rule versions pinned and treat missing scans as build failures where mandated. **Interview conclusion:** layering lint, static security, plan policy and Azure governance catches different failure types.

---

<a id="q36"></a>
### Question 36: How would you prevent multiple engineers or pipelines from conflicting on production infrastructure?

#### 1. Concept
Protecting one state file requires **backend state locking**, while protecting production operations requires **change management and pipeline scheduling**. Terraform locking cannot prevent someone with sufficient permissions from making a manual Azure Portal change or from changing a resource through a different state.

#### 2. Implementation — Step by Step
1. Limit production deploy permission to a dedicated pipeline identity; developers make changes through pull requests.
2. Protect the production branch with reviewers and required status checks.
3. Configure Azure DevOps deployment environments with approvals, checks and a deliberate concurrency policy per environment/state.
4. Give each ownership boundary a separate remote state key/workspace; never track the same resource in multiple states.
5. Require re-plan after any earlier apply updates the targeted state.
6. Detect manual changes using Azure Activity Logs, Policy and read-only Terraform drift scans.

#### 3. Production Example
The network team wants to add a firewall rule, while the application team wants to alter AKS networking in the same state. Their PR plans can run in parallel for feedback, but approved state-changing production applies are queued. Independent application workspaces may deploy at the same time because their resources and state do not overlap.

#### 4. Troubleshooting
If plan review and apply disagree, suspect concurrent changes, stale plan, wrong state key or manual Azure modifications. If an engineer bypasses the pipeline, recover the approved configuration and investigate permissions. **Interview conclusion:** lock state, serialize conflicting deployments, and separate resource ownership.

---

<a id="q37"></a>
### Question 37: Terraform completes successfully, but the application deployment fails. What is your rollback plan?

#### 1. Concept
A successful Terraform apply means infrastructure changes were applied, not that the application is healthy. Rollback must be planned across two layers: **infrastructure** and **application releases**. Terraform does not have a guaranteed automatic reverse-transaction command; reversing HCL can destroy data or cause downtime.

#### 2. Implementation — Step by Step
1. Stop further releases, declare incident severity and inspect application health checks, deployment logs and Azure Monitor metrics.
2. Check whether the infrastructure change is compatible with the previous application version. If so, restore the prior known-good app release, container tag or App Service deployment slot.
3. If the infrastructure itself caused failure, design a **forward fix or reviewed reverse change** in HCL. Check Terraform's plan for replacements and data risk.
4. Preserve database backups, state snapshots and transaction integrity. Perform migrations using backward-compatible schema changes whenever possible.
5. Verify service health, user-visible SLOs and dependencies; finish with incident review and prevention actions.

#### 3. Production Example
Terraform changes Application Gateway routing correctly, but the newly deployed application returns HTTP 500. I roll back the container release first if the infrastructure supports it, using readiness probes and backend health checks. I avoid tearing down the gateway just because the application code failed.

#### 4. Troubleshooting
If the old application cannot run after a database schema migration, a quick code rollback may be unsafe. Diagnose compatibility and use a planned forward correction. If a Terraform reverse plan shows database replacement, stop and seek the data owner's review. **Interview conclusion:** restore service first, then reconcile IaC without treating `destroy` as rollback.

---

<a id="q38"></a>
### Question 38: How does infrastructure rollback differ from application rollback, especially for irreversible changes?

#### 1. Concept
Application rollback often means switching to an earlier image, package or deployment slot. Infrastructure rollback means changing real Azure resources and possibly data, routing, IPs or identities. Some infrastructure operations cannot be safely reversed without a data migration, backup restore or a new resource. **Reverting a Git commit doesn't necessarily revert Azure safely.**

#### 2. Implementation — Step by Step
1. Classify every planned change as in-place update, replacement, deletion, additive change or data migration.
2. For application releases, keep immutable images/artifacts and use slot swaps, canary releases or prior Helm chart versions.
3. For risky infrastructure, make backups, snapshot configuration, test restoration and define a cutback path before apply.
4. Prefer expand-and-contract changes: create the new component, migrate traffic/data, verify, then retire old infrastructure.
5. For failed change, run a fresh Terraform plan using the desired recovery configuration and get approval before any reverse apply.

#### 3. Production Example
Replacing an AKS node pool can be handled by creating a new pool and safely draining workloads. Replacing a production storage account is much more complex because data and endpoints must be migrated; there is no universal “undo” button.

#### 4. Troubleshooting
A rollback can fail due to Azure quota, immutability, database schema incompatibility or missing backups. Record these risks in the change plan and test them before production. **Interview conclusion:** application releases are often reversible; infrastructure/data changes require explicit recovery engineering.

---

<a id="q39"></a>
### Question 39: How would you use Python to read Terraform plan JSON and report resources being created, deleted or replaced?

#### 1. Concept
A Terraform saved plan can be converted to JSON. The `resource_changes` array normally includes each resource address and a `change.actions` list such as `create`, `update`, `delete`, `no-op`, or both `delete` and `create` for replacement. Python can flag destructive operations for reviewers. **Do not publish raw plan JSON publicly** because it may contain secrets.

#### 2. Implementation — Step by Step
1. Generate a saved plan under a protected CI pipeline identity.
2. Convert it to JSON in the same restricted workspace.
3. Parse `resource_changes`, display action counts and mark replacements/deletes as high risk.
4. Fail a policy stage for unapproved destruction, generate a short summary and keep JSON only as long as required.

```bash
terraform plan -out=tfplan
terraform show -json tfplan > tfplan.json
python3 review_plan.py tfplan.json
```

```python
# review_plan.py
import json
import sys

with open(sys.argv[1], encoding="utf-8") as f:
    plan = json.load(f)

risky = []
for resource in plan.get("resource_changes", []):
    actions = resource.get("change", {}).get("actions", [])
    if actions == ["no-op"]:
        continue
    print(resource["address"], ", ".join(actions))
    if "delete" in actions:
        risky.append(resource["address"])

if risky:
    print("REVIEW REQUIRED for destructive/replacement actions:", risky)
    sys.exit(2)
```

#### 3. Production Example
The risk report is published next to the protected Terraform plan review. A planned VM node pool resize produces an update; a database replacement causes the pipeline to pause for an explicit database-owner review.

#### 4. Troubleshooting
Some planned resource changes can be nested in modules, but addresses still identify them. `actions` order may differ for create-before-destroy, so check **membership**, not just the exact list. Use robust error handling for invalid JSON, and remember that secrets can be present in the source file. **Interview conclusion:** Python turns technical plan details into understandable production risk evidence.

---

<a id="section-e"></a>
## Section E — Terraform Enterprise and Automation (Questions 40–45)

<a id="q40"></a>
### Question 40: What is Terraform Enterprise? Compare Terraform CLI, HCP Terraform and Terraform Enterprise.

#### 1. Concept
**Terraform CLI** runs Terraform commands locally or in a CI runner and uses your chosen backend. **HCP Terraform** is HashiCorp's hosted platform for collaboration, workspaces, remote runs, policies, teams, private modules and state management. **Terraform Enterprise (TFE)** delivers the organization-managed/private deployment option for enterprises needing additional control over deployment location and platform operations. Features and licensing vary by edition—always verify the installed TFE version and entitlement.

#### 2. Implementation — Step by Step
1. Establish an organization, project and workspaces for infrastructure teams and environments.
2. Connect the workspace to Git via VCS-driven workflow, or select API/CLI-driven execution based on requirements.
3. Set Terraform version, working directory, state ownership, variable sets, sensitive variables and permitted teams.
4. Configure remote execution and **agent pools** when Terraform needs network connectivity to private Azure endpoints.
5. Apply policy sets (Sentinel/OPA as supported), run tasks, run approvals and audit controls.
6. Document backup/DR, upgrades, monitoring and agent operations for a self-managed Enterprise installation.

```hcl
terraform {
  cloud {
    organization = "example-org"
    workspaces {
      name = "payments-prod"
    }
  }
}
```

#### 3. Production Example
A regulated finance company needs private execution for Azure production networks. It uses an organization-managed Terraform Enterprise deployment, workspace role separation, approved module versions, agents inside secure networks and centralized policies preventing internet-exposed infrastructure.

#### 4. Troubleshooting
If a workspace doesn't plan, check VCS integration, run queue, Terraform version, agent capacity, credentials and policy failures. Do not assume Terraform Enterprise itself runs within Azure or that all TFE/HCP Terraform features are available in every edition. **Interview conclusion:** Terraform Enterprise is a controlled collaborative operating platform built around Terraform workflows.

---

<a id="q41"></a>
### Question 41: How does Terraform Enterprise handle workspaces, remote plans, run queues, approvals, state versions and concurrency?

#### 1. Concept
A Terraform Enterprise **workspace** connects configuration, variables, state and runs for a particular infrastructure ownership boundary. Runs usually progress through planning, optional policy and run-task checks, and an apply approval/confirmation stage. For the **same workspace**, state-changing runs are serialized; teams can plan independently across separate workspaces, though shared Azure resources must still have one owner.

#### 2. Implementation — Step by Step
1. Create dedicated workspaces such as `network-prod`, `aks-prod` and `payments-prod` rather than one huge mixed workspace.
2. Set VCS/API/CLI workflow, permitted teams, Terraform version and execution mode.
3. Add sensitive Azure authentication variables via dynamic credentials/agent integration where supported.
4. Configure mandatory policies and manual apply confirmation for sensitive environments.
5. Review queued, planning, needs-confirmation, applied, failed or discarded run statuses; inspect state version history before recovery actions.
6. Use workspace run triggers or an external orchestrator to coordinate dependent workspaces where supported.

#### 3. Production Example
A networking PR creates a new subnet and produces a Terraform Enterprise plan. A security policy verifies no broad inbound management ports are opened. The production owner reviews and confirms the run. A dependent AKS workspace then consumes the approved subnet output and deploys.

#### 4. Troubleshooting
If a run is stuck waiting, check earlier runs and required approvals/policy overrides. An agent pool with no healthy agents can block execution. If state was overwritten, review the workspace's state versions and initiate a controlled restore—not an unapproved force-push. **Interview conclusion:** workspace queues, policies and approvals provide safer team operations than isolated CLI scripts.

---

<a id="q42"></a>
### Question 42: How would you configure Terraform Enterprise agents to deploy Azure resources reachable only through private VNets?

#### 1. Concept
Terraform Enterprise/HCP Terraform agents run Terraform workload operations in **your controlled network**. They are useful when Terraform must contact private Azure Storage backends, private Key Vault endpoints, internal registries or private APIs that hosted remote execution cannot reach. The agents need secure outbound connectivity to the Terraform platform plus private access to Azure endpoints.

#### 2. Implementation — Step by Step
1. Deploy approved agent hosts/containers inside a dedicated management subnet or secured Kubernetes cluster, according to the supported agent configuration.
2. Configure a Terraform agent pool and create a short-lived or tightly controlled agent token.
3. Supply token through an external secrets mechanism, not the image or Git repository.
4. Configure DNS, routes, NSGs and proxy/firewall allowlists for outbound communication to the Terraform Enterprise platform and required Azure APIs.
5. Make Azure private endpoints reachable from the agent subnet, and configure dynamic Azure credentials/managed identity with the least privileges possible.
6. Assign the agent pool to designated production workspaces and test a harmless plan before enabling applies.

#### 3. Production Example
The company's state storage and Key Vault only allow private endpoint access. A Terraform agent pool runs inside an Azure hub VNet linked to the relevant Private DNS zones. The agents provision spoke workloads without opening backend services to the public internet.

#### 4. Troubleshooting
If runs stay queued, inspect agent pool health/capacity and tokens. If they start but fail `init`, test DNS and TCP 443 reachability to the private Blob endpoint from the **agent machine**, not from an engineer's laptop. Rotate exposed agent tokens and avoid giving agents unrestricted subscription Owner access. **Interview conclusion:** private agents bring Terraform execution closer to private infrastructure with controlled identity and networking.

---

<a id="q43"></a>
### Question 43: What is the difference between Sentinel and OPA in Terraform Enterprise, and how do you block public IPs or disallowed regions?

#### 1. Concept
**Sentinel** is HashiCorp's policy-as-code framework; **OPA** uses the Rego policy language. Both can inspect a Terraform run/plan and enforce organizational rules, depending on Enterprise edition and policy-run support. Policy failures can be advisory, require authorized override or block deployment according to the enforcement settings. This works **before Terraform applies**; Azure Policy acts as an additional platform-side control.

#### 2. Implementation — Step by Step
1. Create a policy repository with version-controlled rules and tests.
2. Write a policy that inspects planned resources, e.g. rejects production `azurerm_public_ip` creations or Azure resources with disallowed `location` values.
3. Set a policy set scoped to the appropriate Terraform Enterprise organization/projects/workspaces.
4. Make critical financial-security rules mandatory; route permitted exceptions through a documented approval process rather than editing policies ad hoc.
5. Run policy tests and inspect the policy evaluation results on every production plan.
6. Layer with Azure Policy denying unwanted cloud-side resources even when created manually outside Terraform.

Policy logic at a high level:
```text
for every proposed production resource:
    if resource.type == "azurerm_public_ip": deny
    if resource.location not in approved_regions: deny
otherwise: allow
```
This expresses the rule; production Sentinel/Rego syntax depends on the policy input format and organization setup.

#### 3. Production Example
A developer requests a public IP for a new banking VM. Terraform syntax validation succeeds, but mandatory plan policy blocks the run. The team redesigns access through private networking and Azure Bastion. Azure Policy reinforces the control if someone tries the same change in Portal.

#### 4. Troubleshooting
If a compliant plan is blocked, inspect policy input/resource addresses, resource-type matching and enforcement mode. Avoid globally disabling policies; test an exception with security-owner approval. **Interview conclusion:** policy-as-code protects Terraform changes while Azure Policy protects Azure resources regardless of deployment tool.

---

<a id="q44"></a>
### Question 44: How would you migrate many Azure DevOps Terraform pipelines into Terraform Enterprise without losing state?

#### 1. Concept
The aim is to move **execution, approvals, policy and state ownership** into Terraform Enterprise while preserving existing Azure resources. It is a migration of the Terraform **management workflow**, not an Azure infrastructure rebuild. State lineage/resource mappings and team roles must remain consistent throughout the cutover.

#### 2. Implementation — Step by Step
1. Inventory every pipeline, backend state key, Terraform/provider version, code repository, Azure credential and environment dependency.
2. Select a pilot nonproduction workspace; map its Terraform root to a new Enterprise workspace and verify state migration support.
3. Freeze the old pipeline, back up state, configure TFE variables/dynamic credentials, and transfer state through the documented backend-to-workspace migration workflow.
4. Run read-only plans in the destination. Confirm resources are **recognized rather than proposed as new**, and policies/agents work.
5. Configure team access, run triggers, approvals, secrets, notifications and recovery plan. Disable the old pipeline's write credentials only after successful validation.
6. Migrate workload groups in batches, documenting go/no-go decisions and rollback options for each state.

#### 3. Production Example
We migrate 60 Azure DevOps pipelines in waves: shared networking first in a tested pilot, then lower-risk applications, and finally banking production systems. Each wave is signed off with matching state-resource counts and no unexpected create/delete actions.

#### 4. Troubleshooting
The common failure is **two active systems managing the same state/resources**. Revoke old write paths during cutover. A different workspace name or incorrect working directory can create an apparently empty plan. Check cloud credentials and agent private DNS before assuming state migration failed. **Interview conclusion:** migrate state ownership and process carefully, without changing the Azure resource IDs.

---

<a id="q45"></a>
### Question 45: How would you build a Python tool that triggers Terraform Enterprise runs, monitors status and reports results?

#### 1. Concept
Terraform Enterprise exposes APIs for workspaces, runs, configuration versions and related operations. Python can integrate internal ticketing, approvals and notifications with those APIs. A production tool should authenticate securely, use **timeouts and rate-limit handling**, understand run states, and never auto-approve destructive infrastructure changes.

#### 2. Implementation — Step by Step
1. Store a limited-scope API token in a secrets manager and read it securely at runtime.
2. Call the Terraform Enterprise API over HTTPS with the correct organization host, workspace ID and versioned content type.
3. Create a run against an existing workspace with suitable configuration, then poll run status with bounded waits and backoff.
4. Report statuses such as `pending`, `planning`, `planned`, `needs_confirmation`, `applying`, `applied`, `errored` and `discarded` according to the platform response.
5. Keep apply approval human-controlled. Do not treat “plan completed” as “infrastructure deployed.”

Illustrative run trigger (endpoint/permissions must match your TFE deployment):
```python
import os
import requests

host = os.environ["TFE_HOST"].rstrip("/")
workspace_id = os.environ["TFE_WORKSPACE_ID"]
token = os.environ["TFE_TOKEN"]
headers = {
    "Authorization": f"Bearer {token}",
    "Content-Type": "application/vnd.api+json",
}
body = {
    "data": {
        "type": "runs",
        "attributes": {"message": "Approved infrastructure request"},
        "relationships": {
            "workspace": {"data": {"type": "workspaces", "id": workspace_id}}
        },
    }
}
with requests.Session() as session:
    response = session.post(
        f"{host}/api/v2/runs", headers=headers, json=body, timeout=30
    )
    response.raise_for_status()
    run_id = response.json()["data"]["id"]
    print("Created TFE run:", run_id)
```

#### 3. Production Example
An internal self-service portal accepts a request for a test environment, validates it, creates a controlled Terraform Enterprise run, then returns a link for engineers to review. Production changes still require policy checks and human confirmation.

#### 4. Troubleshooting
401 means bad/expired token, 403 indicates insufficient team permissions, 422 may indicate invalid run state/request, and 429 calls for retry/backoff. Protect token and API response content from logs. Distinguish VCS-driven configuration availability from an API-driven configuration upload. **Interview conclusion:** automation may trigger/observe runs, but production authorization stays controlled.

---

<a id="section-f"></a>
## Section F — Cloud Migration, Disaster Recovery and Real Production Scenarios (Questions 46–50)

<a id="q46"></a>
### Question 46: How would you migrate manually managed on-premises and Azure infrastructure into Terraform with minimal downtime?

#### 1. Concept
Terraform manages supported cloud/on-prem resources through providers; it does **not automatically move application data, VM images or databases** from one platform to another. The migration combines **discovery, target architecture, Terraform provisioning, resource imports, application/data migration and traffic cutover**. Two main cases exist: adopting already-running Azure infrastructure and moving workloads from on-premises to Azure.

#### 2. Implementation — Step by Step
1. Inventory servers, networks, dependencies, firewall rules, DNS, databases, recovery targets and compliance constraints.
2. Design Azure landing zones: subscriptions, management groups, hub/spoke networking, hybrid VPN/ExpressRoute, identity, policy, backup and monitoring.
3. Build reusable Terraform modules for VNets, private endpoints, storage, compute, AKS, databases and diagnostics.
4. For Azure resources already deployed manually, generate HCL and import their IDs under one state owner; check for zero unintended replacements.
5. For on-premises apps, provision new Azure infrastructure with Terraform while keeping old workloads running. Migrate data using an appropriate service/tool, synchronize changes and test connectivity, identity and performance.
6. Perform gradual cutover using DNS/routing/load-balancer changes with rollback and DR preparation. Decommission legacy only after signoff.

#### 3. Production Example
A payroll application runs on-premises with SQL Server. I provision Azure network, application VMs/App Service, private SQL target, backup and Azure Monitor using Terraform. Database migration tools replicate data and teams validate application functionality. After low-traffic cutover, monitoring and transaction checks decide whether to continue or roll back.

#### 4. Troubleshooting
Watch for overlapping CIDRs, DNS suffix conflicts, unrecognized dependencies, identity changes, latency and database compatibility. If import suggests replacement, pause. If the target app fails, redirect traffic to the still-operational source according to the cutover plan. **Interview conclusion:** Terraform builds/manages infrastructure; migration success depends on data, networking, testing and reversible cutover.

---

<a id="q47"></a>
### Question 47: How would you use Terraform to provision Azure disaster recovery in a second region?

#### 1. Concept
Disaster recovery aims to meet agreed **RTO** (time to restore service) and **RPO** (acceptable data loss). Terraform is excellent for reproducible regional infrastructure, but **Terraform alone does not replicate application data or perform database failover**. An effective DR plan needs data replication, regional networking, global traffic routing, monitoring and tested runbooks.

#### 2. Implementation — Step by Step
1. Agree workload RTO/RPO and choose active-passive or active-active based on cost and data consistency.
2. Use region-parameterized Terraform modules to provision comparable VNets, subnets, firewalls, identities, compute and monitoring in primary and secondary regions.
3. Enable appropriate data-layer replication: Azure SQL failover groups/geo-replication, Storage redundancy, databases' own replicas, or Azure Site Recovery for supported VMs.
4. Configure Front Door/Traffic Manager or workload-specific failover mechanisms; protect region-dependent DNS, certificates, secrets and images.
5. Separate state/ownership carefully so losing a regional application does not prevent using the DR environment; protect Terraform backends and execution agents themselves.
6. Run regular failover exercises, measure actual RTO/RPO and keep the runbook version-controlled.

#### 3. Production Example
An API runs on AKS in East US with warm standby in Central US. Terraform provisions both regions. Container images and secrets are available in both, the data layer replicates based on database capabilities, and Front Door routes to the healthy region after application checks and approved failover behavior.

#### 4. Troubleshooting
A warm secondary cluster can still fail from missing DNS links, firewall rules, stale data or quota shortages. If Terraform cannot run during an incident, the recovery plan should still support necessary failover operations. Test data consistency and business transactions, not only VM health. **Interview conclusion:** Terraform builds predictable DR infrastructure; replication and tested failover deliver low RTO/RPO.

---

<a id="q48"></a>
### Question 48: Two teams share networking infrastructure but have independent Terraform deployments. How do you handle ownership and dependencies?

#### 1. Concept
When many teams share a VNet, route table or Azure Firewall, allowing each team to modify the same object creates conflict and drift. The safest architecture uses a **platform network owner** with a separate state, while application teams own independent resources and request changes through an interface or change process.

#### 2. Implementation — Step by Step
1. Define ownership boundaries: platform team owns shared hub, firewall, DNS and spoke VNet; application team owns its compute and allowed application-specific resources.
2. Publish stable IDs and outputs for application modules. Use read-only data sources or a governed remote-state interface.
3. Grant application deployment identities access only to application scopes. Avoid giving every team Network Contributor over the hub.
4. Request shared firewall changes through a separate platform PR/workflow, with network-security review.
5. Deploy networking changes first, then independent application changes; run them in parallel only where state and resources truly do not overlap.
6. Use drift reports and Azure Policy to detect accidental manual changes outside the owning workflow.

#### 3. Production Example
Payments and fraud applications share a hub firewall but each has a separate spoke VNet/application state. A fraud team needing a new outbound rule requests a network PR. The platform pipeline applies it, then the fraud team deploys the workload independently.

#### 4. Troubleshooting
If a network change causes app outages, inspect shared routing/firewall changes and correlate with Activity Log. If two states manage the same NSG rules, consolidate ownership and reconcile duplicate state mappings under a planned maintenance change. **Interview conclusion:** shared infrastructure should have one owner and a governed consumer interface.

---

<a id="q49"></a>
### Question 49: How would you use Terraform for Azure Event Hubs, Storage Queues, Event Grid, App Service, private endpoints and monitoring?

#### 1. Concept
Terraform can build an event-driven Azure application platform: **Event Hubs** for high-throughput event streams, **Storage Queues** for work items, **Event Grid** for push-style event routing, **App Service** for application hosting, **Private Link** for supported private service access, and **Azure Monitor** for operations. Terraform creates platform resources; Python or application code implements event producers, consumers and business logic.

#### 2. Implementation — Step by Step
1. Create a resource group, secured storage account, Event Hubs namespace/hub and appropriate Event Grid resources through supported AzureRM/AzAPI resources.
2. Configure Event Hubs partitions, consumer groups, retention and authorized identities. Set Storage Queues and event-subscription filters, dead-letter destinations or retry options as supported.
3. Deploy an App Service plan and application, configure VNet integration for outbound access and private endpoint for inbound access if required.
4. Assign managed identities and data-plane roles instead of embedding connection strings where services support Microsoft Entra authentication.
5. Configure Private DNS zones for every relevant service's private endpoint and test connectivity from the app environment.
6. Deploy Azure Monitor diagnostic settings and alerts for Event Hub throughput/throttling, delivery failures, queue backlogs and application errors.

```hcl
resource "azurerm_eventhub_namespace" "events" {
  name                = var.eventhub_namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 1
}
resource "azurerm_eventhub" "transactions" {
  name              = "transactions"
  namespace_id      = azurerm_eventhub_namespace.events.id
  partition_count   = 2
  message_retention = 1
}
```
Provider versions may differ in schema and optional settings; verify the current AzureRM registry documentation during implementation.

#### 3. Production Example
An online transaction app publishes events to Event Hubs. A Python worker consumes and checkpoints messages. Event Grid notifies another function when a report file arrives in secure Blob Storage, while a queue processes durable background tasks. Terraform consistently builds networking, identity and diagnostic settings in QA and production.

#### 4. Troubleshooting
If events cannot publish, inspect namespace connectivity, RBAC, private DNS, throughput limits and SDK errors. If a queue grows, check worker health, poison messages and visibility timeout. If Event Grid doesn't deliver, inspect subscription filters, endpoint health, delivery failures and dead lettering. **Interview conclusion:** Terraform standardizes the secure platform; app monitoring proves event flow works.

---

<a id="q50"></a>
### Question 50: During an incident, someone modifies Azure resources manually while Terraform is applying. How do you prevent conflicts, preserve the fix and restore IaC control?

#### 1. Concept
This is a **race condition between real Azure changes and a Terraform run**. Backend state locking only coordinates Terraform writers using that state. It does **not** stop an administrator from changing resources directly in the Azure Portal. During an incident, the priorities are restoring service, avoiding another harmful write and preserving an audit trail.

#### 2. Implementation — Step by Step
1. Declare the incident and identify both the running Terraform operation and the manual change. If feasible, pause subsequent deployments while preserving logs.
2. Coordinate with the active apply owner—do not kill an in-progress Terraform operation without understanding whether Azure requests are already in flight.
3. Record Azure Activity Log events, affected resource IDs, old/new values, Terraform pipeline/plan ID and state key.
4. Decide which emergency change must remain. Review the final Terraform state after the active operation completes or fails; do not assume its last plan represents current Azure.
5. Run a fresh `terraform plan` and compare HCL, state and live infrastructure. Update HCL for approved emergency settings or plan to revert unauthorized settings.
6. Obtain expedited review, apply the new saved plan under the state lock and validate application health, security and audit controls.
7. Improve controls: limited Portal write access, PIM, pipeline change freezes, drift monitoring and emergency runbooks.

#### 3. Production Example
During a payments latency incident, one engineer manually increases VM Scale Set capacity while a production Terraform pipeline is deploying routing changes. I coordinate with both teams and stop additional deployments. After stabilization, I confirm the real instance count and policy, update scaling configuration in Git if the change should persist, then apply a fresh approved plan.

#### 4. Troubleshooting
An apply may fail with Azure conflict/etag errors, overwrite the emergency change or propose unrelated drift on retry. Investigate provider errors, Azure Activity Log and state mappings. Never “solve” by disabling locking or blindly running refresh-only; refresh-only does not update HCL. **Interview conclusion:** stabilize first, capture evidence, reconcile desired state in Git, re-plan safely, then enforce controls to reduce manual drift.

---

## Official References for Further Practice

These are reference materials for verifying the commands and platform behavior in the notes:

- [HashiCorp — Terraform state and purpose](https://developer.hashicorp.com/terraform/language/state)
- [HashiCorp — Refresh-only state reconciliation](https://developer.hashicorp.com/terraform/tutorials/state/refresh)
- [HashiCorp — Import existing resources](https://developer.hashicorp.com/terraform/language/block/import)
- [HashiCorp — Bulk import workflow](https://developer.hashicorp.com/terraform/language/import/bulk)
- [Microsoft — Azure Export for Terraform](https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-terraform-overview)
- [HashiCorp — AzureRM remote backend](https://developer.hashicorp.com/terraform/language/backend/azurerm)
- [HashiCorp — State storage and locking](https://developer.hashicorp.com/terraform/language/state/backends)
- [HashiCorp — State locking and force-unlock](https://developer.hashicorp.com/terraform/language/state/locking)
- [HashiCorp — State recovery](https://developer.hashicorp.com/terraform/cli/state/recover)
- [Microsoft — Secure Blob Storage / recovery](https://learn.microsoft.com/en-us/azure/storage/blobs/secure-blobs)
- [HashiCorp — Lifecycle meta-arguments](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)
- [HashiCorp — Plans and saved plan execution](https://developer.hashicorp.com/terraform/cli/commands/plan)
- [HashiCorp — Terraform Enterprise remote runs](https://developer.hashicorp.com/terraform/enterprise/workspaces/run/cli)
- [HashiCorp — Terraform Enterprise policy enforcement](https://developer.hashicorp.com/terraform/enterprise/workspaces/policy-enforcement)
- [Microsoft — Terraform in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage)
