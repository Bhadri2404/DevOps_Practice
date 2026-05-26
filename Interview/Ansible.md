# Ansible – 50 Advanced Questions and Answers

> Focus areas: idempotent configuration management, inventories, playbooks, roles, handlers, variables, templates, conditionals, tags, Ansible Vault, Ansible + Terraform/Jenkins integration, debugging, and scenario-based operations automation.[web:73][web:75][web:82]

---

## 1. Core Concepts and Architecture

### Q1. What is Ansible and how does it fit alongside Terraform in this role?

**Answer:**  
Ansible is an agentless configuration management and automation tool that uses SSH/WinRM and YAML playbooks to manage configuration, deploy applications, and orchestrate tasks across servers.[web:73][web:82] In this role, Terraform provisions infrastructure (VPCs, VMs, clusters), and Ansible configures OS, installs dependencies, sets up application runtimes, and performs operational tasks on provisioned machines.

**Real-time Production Scenario:**  
Terraform creates EC2 instances for a data processing cluster; Ansible then configures Python, JDK, security hardening, monitoring agents, and application code deployment on those instances.

**Common Mistakes:**

- Using Ansible to create cloud resources that should be handled by Terraform.
- Using Terraform provisioners heavily instead of Ansible for configuration.

**Debugging Tips:**

- If Ansible fails to connect, check SSH/WinRM connectivity, keys, and inventories.
- Separate infra issues (Terraform) from config issues (Ansible) in incident analysis.

**Follow-up Questions:**

- How would you orchestrate Terraform and Ansible in a Jenkins pipeline?
- When would you use only Terraform vs Terraform + Ansible?

---

### Q2. Explain Ansible’s architecture: control node, managed nodes, inventory, and modules.

**Answer:**  

- **Control node:** where Ansible is installed and playbooks run.
- **Managed nodes:** servers/VMs/containers configured via SSH/WinRM from the control node.
- **Inventory:** list of managed nodes, grouped by environment, role, etc. (INI/YAML/dynamic).[web:73][web:80]
- **Modules:** units of work (e.g., `apt`, `yum`, `service`, `user`, `copy`, `shell`) that Ansible executes on managed nodes.

**Key property:** agentless – no agent installed on managed nodes.

**Common Mistakes:**

- Hardcoding host details everywhere instead of using inventory groups and variables.
- Using `shell`/`command` instead of appropriate modules.

**Debugging Tips:**

- Use `ansible all -m ping -i inventory` to confirm connectivity.
- Use `-vvv` verbosity to see connect details and module execution.

**Follow-up Questions:**

- How do you organize inventories for dev/stage/prod?
- When would you use a dynamic inventory (e.g., AWS, Azure)?

---

### Q3. What is a playbook in Ansible, and what is its typical structure?

**Answer:**  
A playbook is a YAML file that defines **one or more plays**; each play maps a set of hosts to tasks (modules) and configuration steps.[web:75] Typical structure:

- `hosts`: target host/group.
- `vars`: variables.
- `tasks`: list of tasks with modules and parameters.
- `handlers`: special tasks triggered by `notify`.

**Example:**

```yaml
- name: Configure web servers
  hosts: webservers
  become: true

  vars:
    http_port: 80

  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
      notify: restart nginx

  handlers:
    - name: restart nginx
      service:
        name: nginx
        state: restarted
```

**Common Mistakes:**

- Putting everything into one huge playbook instead of roles.
- Using `become: true` per task instead of at play level when appropriate.

**Follow-up Questions:**

- How do you break large playbooks into roles?
- How do handlers improve idempotency and efficiency?

---

### Q4. Explain idempotency in Ansible and why it matters.

**Answer:**  
Idempotency means running the same playbook multiple times leads to the same final state without unintended changes. Ansible modules are designed to be idempotent; they change state only when needed.[web:82]

**Importance:**

- Safe to rerun playbooks for drift correction.
- Supports “infrastructure convergence” model similar to Terraform.

**Common Mistakes:**

- Overusing `shell`/`command` to run non-idempotent scripts (e.g., `useradd` without checks).
- Not using `creates`/`removes` arguments or `only_if`/`when` for commands that should run conditionally.

**Debugging Tips:**

- Enable diff mode (`--diff`) to see what changes Ansible is making.
- Review module documentation for idempotent usage patterns.

**Follow-up Questions:**

- How do you make a custom script task idempotent?
- Why is idempotency crucial for production runbooks?

---

### Q5. What are roles in Ansible, and how do you organize them?

**Answer:**  
Roles are a way to organize reusable Ansible content (tasks, handlers, variables, templates, files, defaults) into a standardized directory structure.[web:75][web:80] Roles promote reuse and clean separation of concerns.

**Example structure:**

```text
roles/
  webserver/
    tasks/main.yml
    handlers/main.yml
    templates/
    files/
    vars/main.yml
    defaults/main.yml
```

**Usage in a playbook:**

```yaml
- hosts: webservers
  roles:
    - webserver
```

**Best Practices:**

- One role per concern (web, db, logging, monitoring).
- Use `defaults` for role defaults; `vars` for internal constants.
- Publish internal role library for teams.

**Common Mistakes:**

- Huge roles doing everything (web + db + monitoring).
- Putting host-specific config inside roles rather than using group/host vars.

**Follow-up Questions:**

- How would you structure roles for a Python microservice platform?
- How do you test roles independently (molecule, CI)?

---

## 2. Inventories, Variables, and Templates

### Q6. How do you structure inventory for multiple environments (dev, QA, prod)?

**Answer:**  

Typical layout:

```text
inventory/
  dev/
    hosts.ini
    group_vars/
    host_vars/
  qa/
  prod/
```

- `hosts.ini` defines host groups (`web`, `db`, `app`, etc.).
- `group_vars/<group>.yml` defines variables for each group.
- `host_vars/<host>.yml` defines host-specific overrides.

**Patterns:**

- Keep environment-specific things in separate inventory directories.
- Use `-i inventory/dev` or `-i inventory/prod` to select env.

**Common Mistakes:**

- Single global inventory with conditions everywhere.
- Hardcoding environment differences inside playbooks instead of inventory.

**Debugging Tips:**

- Use `ansible-inventory --graph -i inventory/dev` to visualize inventory.
- If variables not applied, confirm the correct inventory path and group/host names.

**Follow-up Questions:**

- Have you used dynamic inventory scripts/plugins (AWS, Azure, Kubernetes)?
- How do you manage inventory for auto-scaling clusters?

---

### Q7. Explain variable precedence in Ansible.

**Answer:**  
Ansible has a clear variable precedence hierarchy (simplified order from lowest to highest priority):

1. Role defaults.
2. Inventory group vars.
3. Inventory host vars.
4. Play vars.
5. Task vars.
6. Extra vars (`-e`) override almost everything.[web:73][web:84]

**Importance:**

- Knowing precedence avoids confusion when values appear “ignored.”
- Helps debug variable-related issues effectively.

**Common Mistakes:**

- Using `-e` with global values that override everything unexpectedly.
- Not documenting where key variables are defined (role defaults vs group_vars vs host_vars).

**Debugging Tips:**

- Use `debug` module to print out variable values in playbooks.
- Use `ansible-config dump` and `ansible-inventory` to inspect variable sources.

**Follow-up Questions:**

- When is it appropriate to use `-e` extra vars?
- How would you structure variables for multiple regions and environments?

---

### Q8. How do you use Jinja2 templates in Ansible, and what are common pitfalls?

**Answer:**  
Templates allow you to generate configuration files dynamically based on variables and logic.

**Example:**

`templates/nginx.conf.j2`:

```jinja2
server {
  listen {{ http_port }};
  server_name {{ server_name }};

  location / {
    proxy_pass http://{{ upstream }};
  }
}
```

Playbook task:

```yaml
- name: Render nginx config
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  notify: restart nginx
```

**Common Pitfalls:**

- Complex logic in templates instead of in vars or roles.
- Missing `notify`/handlers, so config changes don’t trigger service reloads.
- Syntax errors in Jinja (unbalanced braces, etc.).

**Debugging Tips:**

- Use `ansible-playbook --check --diff` to see template output without applying changes.
- Use `debug` statements or `to_nice_json` filters to inspect variables.

**Follow-up Questions:**

- How would you template a Kubernetes manifest via Ansible (if needed)?
- How do you prevent secrets from appearing in rendered templates accidentally?

---

## 3. Modules, Handlers, Conditionals, and Tags

### Q9. When do you use `shell`/`command` modules vs specialized modules?

**Answer:**  

- Prefer specialized modules (e.g., `apt`, `yum`, `service`, `user`, `copy`, `git`) because they:
  - Are idempotent.
  - Understand OS/package manager semantics.
- Use `command`/`shell` when:
  - No module exists for what you need.
  - You need exact CLI behavior.

**Rules of thumb:**

- Use `command` for simple commands without shell features.
- Use `shell` only when you need shell features (pipes, redirects, `&&`, environment).

**Common Mistakes:**

- Overusing `shell` for tasks that have modules (e.g., `apt-get`, `systemctl`).
- Forgetting `creates`/`removes` or checks, leading to non-idempotent tasks.

**Debugging Tips:**

- Add `set -euxo pipefail` to complex shell scripts.
- Use `--check` to ensure the task is truly idempotent.

**Follow-up Questions:**

- Give an example of replacing a `shell` task with a module.
- How do you run commands with specific environment variables?

---

### Q10. Explain handlers in Ansible and give an example from production.

**Answer:**  
Handlers are special tasks that run **only when notified** by other tasks (when tasks report “changed”). They are often used for actions like service reload/restart.

**Example:**

```yaml
tasks:
  - name: Deploy new config
    template:
      src: app.conf.j2
      dest: /etc/app/app.conf
    notify: restart app

handlers:
  - name: restart app
    service:
      name: app
      state: restarted
```

**Benefits:**

- Avoid unnecessary restarts when nothing changed.
- Consolidate multiple “notify” events into a single restart at play end.

**Common Mistakes:**

- Using tasks instead of handlers for service restart; restarts every time.
- Handlers in wrong role/play not triggered due to scoping.

**Follow-up Questions:**

- How do you ensure handlers run even if a task fails beforehand (`--force-handlers`)?[web:77]
- Can you chain handlers (one handler notifies another)?

---

### Q11. How do you use `when` conditionals and loops in Ansible?

**Answer:**  

Conditionals:

```yaml
- name: Install nginx on Debian-based systems
  apt:
    name: nginx
    state: present
  when: ansible_os_family == "Debian"
```

Loops:

```yaml
- name: Create multiple users
  user:
    name: "{{ item }}"
    state: present
  loop:
    - alice
    - bob
    - carol
```

Combination:

- Use `loop` for repeated tasks.
- Use `when` expressions to target specific systems or conditions.

**Common Mistakes:**

- Complex conditions that are hard to read/debug.
- Using loops over large sets without performance considerations.

**Debugging Tips:**

- Use `debug` tasks to inspect facts and variables used in `when` expressions.
- Break complicated logic into separate roles or tasks files.

**Follow-up Questions:**

- How do you handle OS-specific paths or packages using `when` + `vars`?
- How do you loop over dictionaries (`dict2items` filter)?

---

### Q12. What are tags in Ansible and how do you use them effectively?

**Answer:**  
Tags group tasks so you can select or skip them when running playbooks.[web:77]

**Example:**

```yaml
tasks:
  - name: Install packages
    apt:
      name: nginx
      state: present
    tags: [packages]

  - name: Configure nginx
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/nginx.conf
    tags: [config]
```

Run only config tasks:

```bash
ansible-playbook site.yml --tags config
```

Skip non-idempotent tasks:

```bash
ansible-playbook site.yml --skip-tags non_idempotent
```

**Use Cases:**

- “Quick” config runs vs full provisioning.
- Maintenance operations (e.g., only DB tasks).

**Common Mistakes:**

- No tags; long playbooks always run everything.
- Inconsistent or overly generic tags.

**Follow-up Questions:**

- How would you structure tags for “security hardening” vs “application deploy”?
- Have you used tags to separate first-time provisioning from day-2 operations?

---

## 4. Execution Strategies, Check Mode, and Error Handling

### Q13. How does Ansible’s `--check` (dry run) mode work and when is it useful?

**Answer:**  
`--check` runs playbooks in dry-run mode: modules report what changes **would be made** but do not make them, where possible.[web:77]

**Usefulness:**

- Preview potential changes before running on production.
- Validate that tasks are idempotent and correctly structured.

**Limitations:**

- Some modules cannot fully simulate changes in check mode.
- Shell commands and some external operations might not be accurate.

**Common Mistakes:**

- Relying solely on check mode for safety; must still review logic and test in non-prod.

**Follow-up Questions:**

- How do you combine `--check` with `--diff`?
- Have you seen modules behave differently in check mode vs actual run?

---

### Q14. How do you handle failures in Ansible (ignore, retry, stop)?

**Answer:**  

Options:

- Default: task failure stops play for that host.
- `ignore_errors: yes` to continue even if a task fails (use sparingly).
- `failed_when` to define custom failure conditions.
- `retries` + `delay` with `until` for retry loops.

**Example (retry until service responds):**

```yaml
- name: Wait for app health
  uri:
    url: http://localhost:8000/health
    status_code: 200
  register: result
  retries: 5
  delay: 10
  until: result.status == 200
```

**Common Mistakes:**

- Globally ignoring errors, hiding real issues.
- No explicit retries for flaky network calls.

**Debugging Tips:**

- Use `-vvv` and `--step` to step through tasks interactively in dev.
- Use `--force-handlers` to ensure cleanup handlers run even on failure.[web:77]

**Follow-up Questions:**

- When is it appropriate to use `ignore_errors`?
- How do you capture partial failures for RCA?

---

### Q15. How do you optimize Ansible performance on large inventories?

**Answer:**  

Techniques:

- Use **forks** parameter to control parallelism (default 5; increase for large fleets).
- Minimize facts collection when not needed (`gather_facts: false` or `setup` module with filters).
- Use `delegate_to` and `run_once` for tasks that should run only once (e.g., generating templates, hitting APIs).
- Avoid unnecessary `shell`/`command` tasks; use efficient modules.
- Use `serial` keyword to roll out changes gradually (for sensitive deployments).

**Example:**

```yaml
- hosts: webservers
  serial: 10
  tasks:
    - name: Update app
      ...
```

**Common Mistakes:**

- Running all tasks on all hosts at once for risky changes (no canary or batches).
- Heavy facts collection on every run when not needed.

**Follow-up Questions:**

- How would you design a rolling deployment with Ansible using `serial`, `max_fail_percentage`, etc.?
- How do you balance speed with safety for production changes?

## 5. Security, Ansible Vault, and Secret Management

### Q16. What is Ansible Vault and when do you use it?

**Answer:**  
Ansible Vault encrypts sensitive data such as passwords, API keys, and private configuration files so they can be safely stored in version control.[web:73][web:80] It lets you encrypt entire files or variable values and decrypt them at runtime using a password or key file.

**Typical Uses:**

- Encrypt `group_vars/prod.yml` that contains DB passwords, API keys.
- Encrypt TLS private keys or SSH keys stored alongside playbooks.

**Common Mistakes:**

- Storing vault passwords in the same repo or on shared drives without access control.
- Using a single global vault password for all environments and teams.

**Debugging Tips:**

- If you see “Decryption failed” errors, verify:
  - You provided the correct vault password (`--ask-vault-pass` or `--vault-password-file`).
  - The file was encrypted with the expected vault ID.

**Follow-up Questions:**

- How would you manage vault passwords in CI/CD securely?
- Have you used multiple vault IDs for different environments or teams?

---

### Q17. How do you encrypt and decrypt files with Ansible Vault?

**Answer:**  

Commands:

- Encrypt a file:

```bash
ansible-vault encrypt group_vars/prod.yml
```

- Decrypt a file:

```bash
ansible-vault decrypt group_vars/prod.yml
```

- Edit an encrypted file:

```bash
ansible-vault edit group_vars/prod.yml
```

- Re-key (change password):

```bash
ansible-vault rekey group_vars/prod.yml
```

**Runtime Usage:**

- Provide password at runtime:

```bash
ansible-playbook site.yml --ask-vault-pass
```

or use a password file (with appropriate filesystem permissions).

**Common Mistakes:**

- Commit decrypted versions by mistake after editing.
- Forgetting to rotate passwords when team members leave.

**Follow-up Questions:**

- How do you integrate Vault with Jenkins/GitHub Actions securely?
- Would you combine Vault with external secret managers (AWS/Azure) or choose one?

---

### Q18. How do you structure secret handling with Ansible + cloud secret managers?

**Answer:**  

Patterns:

- Use Ansible Vault for **“CI/CD-level” secrets** (e.g., credentials for Ansible itself) but prefer cloud secret managers (AWS Secrets Manager, Azure Key Vault) as **source of truth** for application secrets.
- Use Ansible modules to fetch secrets at runtime from secret managers and populate config files or environment variables.

**Example:**  
Use `aws_secret` or `azure_keyvault_secret` modules (or HTTP calls) to retrieve secrets and template them into configs.

**Common Mistakes:**

- Duplicating secrets across Vault, secret managers, and plain YAML.
- Caching secrets in logs or debug output.

**Follow-up Questions:**

- How do you avoid leaking secrets in Ansible logs?
- How do you handle secret rotation with minimal downtime?

---

## 6. Dynamic Inventory, Cloud, and Kubernetes

### Q19. What is dynamic inventory in Ansible and why is it useful?

**Answer:**  
Dynamic inventory sources host lists directly from external systems (cloud APIs, CMDB, Kubernetes), rather than static inventory files.[web:79]

**Use cases:**

- Auto-discovered EC2 instances tagged with `env=dev` or `role=app`.
- Azure VMs discovered by subscription/resource group.
- Kubernetes pods/services for cluster operations.

**Benefits:**

- No manual host list updates when infrastructure scales up/down.
- Aligns better with auto-scaling and ephemeral infrastructure.

**Common Mistakes:**

- Relying on static hostnames in fast-changing cloud environments.
- Misconfigured filters resulting in wrong hosts targeted.

**Follow-up Questions:**

- How would you configure dynamic inventory for AWS (EC2 plugin)?
- How do you separate environments with dynamic inventory (tags, naming)?

---

### Q20. How do you run Ansible against Kubernetes, and when is that appropriate?

**Answer:**  

Options:

- Use Kubernetes inventory plugin to treat pods/services as hosts.
- Use modules or `kubectl`/`k8s` module to manage Kubernetes resources.

**Appropriate uses:**

- Bootstrapping cluster-level tools (e.g., installing agents on nodes).
- Managing non-Helm Kubernetes resources when you want Ansible-driven workflows.

**Cautions:**

- For ongoing app deployments, Helm or ArgoCD/GitOps is often more suitable.
- Avoid mixing too many orchestration tools (Jenkins, Terraform, Ansible, Helm, GitOps) for the same resources without clear responsibility boundaries.

**Follow-up Questions:**

- Example scenario where you used Ansible with Kubernetes nodes.
- How would you decide between Ansible vs Helm vs Terraform for certain K8s tasks?

---

## 7. CI/CD Integration with Jenkins, Terraform, and Ansible

### Q21. How do you integrate Ansible into Jenkins pipelines for configuration tasks?

**Answer:**  

Typical Jenkins pipeline:

1. Checkout infra repo.
2. Optionally run Terraform to provision infra.
3. Run Ansible playbooks from Jenkins agent (control node) against provisioned hosts.

**Example Stage:**

```groovy
stage('Configure App Servers') {
  agent { label 'ansible' }
  steps {
    sh '''
      ansible-playbook -i inventory/prod \
        playbooks/app_config.yml \
        --vault-password-file ~/.vault_pass.txt
    '''
  }
}
```

**Best Practices:**

- Use separate agents with Ansible installed.
- Store inventory and playbooks in Git.
- Pass environment parameters (e.g., `-e env=prod`).

**Common Mistakes:**

- Running Ansible from random developer machines instead of CI/CD.
- No RBAC around who can trigger config changes.

**Follow-up Questions:**

- How do you ensure Ansible runs are traceable to change tickets?
- How do you handle Ansible return codes and failures in Jenkins?

---

### Q22. How do you coordinate Terraform and Ansible in a single pipeline without race conditions?

**Answer:**  

Approach:

- Stage 1: Terraform provisions or updates infra; `apply` completes.
- Stage 2: Ansible uses Terraform outputs (IPs, hostnames) either via:
  - Terraform output files consumed by Ansible dynamic inventory.
  - Passing outputs via environment variables or generated inventory.

Key points:

- Wait until Terraform `apply` finishes successfully before Ansible starts.
- Avoid Ansible trying to reach resources before they exist or become reachable (use wait/retry tasks).

**Common Mistakes:**

- Overlapping Ansible config runs during Terraform `apply`.
- Not updating inventory after Terraform changes.

**Follow-up Questions:**

- How do you test this pipeline in non-prod first?
- How do you handle partial Terraform failures with Ansible?

---

### Q23. How do you design Ansible roles to be reusable across different environments and clouds?

**Answer:**  

Patterns:

- Avoid hard-coded hostnames, IPs, or cloud-specific details in roles.
- Use variables (`vars`, `group_vars`) to inject environment-specific and cloud-specific data.
- Use `when` conditions and variables to handle OS-specific differences.

Example:

- Role `webserver` installs nginx; environment-specific ports, logging, and backends defined in group/host vars.

**Common Mistakes:**

- Roles tightly tied to one environment or IP addressing scheme.
- No clear separation between role defaults and environment overrides.

**Follow-up Questions:**

- How do you structure `group_vars`/`host_vars` for multi-region deployments?
- How would you adapt roles when migrating from on-prem to cloud?

---

## 8. Scenario-Based Configuration and Operations

### Q24. Scenario: Package installation differs across Linux distributions. How do you handle it?

**Scenario:**  
You need to install a monitoring agent on Ubuntu and RHEL hosts, with different package names and repositories.

**Solution Approach:**

- Use facts (`ansible_os_family`, `ansible_distribution`) in `when` conditions.
- Separate tasks per OS with appropriate modules.

**Example:**

```yaml
- name: Install agent on Debian
  apt:
    name: monitor-agent-deb
    state: present
  when: ansible_os_family == 'Debian'

- name: Install agent on RedHat
  yum:
    name: monitor-agent-rpm
    state: present
  when: ansible_os_family == 'RedHat'
```

**Best Practices:**

- Keep OS-specific logic in roles structured by OS.
- Use `vars` files per OS if differences are many.

**Follow-up Questions:**

- How do you avoid duplicating similar tasks for many OSes?
- How do you test playbooks across multiple OS versions?

---

### Q25. Scenario: A playbook partially fails on some hosts. How do you recover?

**Scenario:**  
An app deployment playbook fails on 3 out of 20 hosts due to insufficient disk space.

**Handling:**

1. Inspect results:
   - Identify failed hosts via Ansible output.
2. Fix underlying issue:
   - Increase disk or clean space on those hosts.
3. Rerun playbook, optionally using `--limit`:
   - `ansible-playbook deploy.yml --limit failed_hosts_group`.

**Best Practices:**

- Use `serial` to limit rollout; avoid all-or-nothing big bang.
- Use `max_fail_percentage` to stop when too many hosts fail.

**Follow-up Questions:**

- How would you create a group of failed hosts from Ansible results?
- How do you design playbooks so they are safe to rerun after partial failures?

---

### Q26. Scenario: Need a zero-downtime rolling deployment with Ansible. How do you implement it?

**Answer:**  

Pattern:

- Use `serial` to update subset of hosts at a time.
- Remove hosts from load balancer before updating; re-add after health check passes.

**Example:**

```yaml
- hosts: appservers
  serial: 2
  pre_tasks:
    - name: Drain host from load balancer
      # call LB API or use cloud module
  tasks:
    - name: Deploy new version
      ...
  post_tasks:
    - name: Add host back to load balancer
      ...
```

**Best Practices:**

- Combine with health checks and `until` loops to verify application readiness before moving on.

**Follow-up Questions:**

- How would you integrate this with Kubernetes-based services (if any)?
- How do you handle DB migrations in rolling deployments?

---

### Q27. Scenario: You need to run a one-off data fix on hundreds of servers. How do you do it safely with Ansible?

**Answer:**  

Approach:

1. Implement fix as an idempotent Ansible task or role.
2. Tag it (e.g., `data_fix`).
3. Run playbook with `--limit` and `serial` to control rollout.

```yaml
- hosts: appservers
  serial: 10
  tasks:
    - name: Apply data fix
      command: /usr/local/bin/data_fix.sh
      register: fix_result
      changed_when: fix_result.rc == 0
      tags: data_fix
```

**Safety:**

- Test in staging first.
- Use `--check` with caution (if meaningful) and capture logs per host.
- Roll out to small batch, verify, then proceed.

**Follow-up Questions:**

- How do you capture and store outputs for RCA or audit?
- How do you track which hosts have had the fix applied?

---

### Q28. Scenario: Ansible fails mid-run due to a transient network error. How do you design resilience?

**Answer:**  

Approach:

- Use retries and `until` for known transient operations (HTTP, DB queries).
- For SSH connectivity, rely on Ansible’s built-in retries/forks; avoid too-aggressive timeouts.
- Rerun playbook; idempotent tasks ensure safe re-run.

Example for transient HTTP call:

```yaml
- name: Call external API
  uri:
    url: "https://api.example.com/endpoint"
    method: GET
  register: result
  retries: 5
  delay: 10
  until: result.status == 200
```

**Follow-up Questions:**

- How do you configure SSH control persist or bastion hosts for reliability?
- How do you differentiate between transient vs persistent errors?

---

### Q29. Scenario: You discover configuration drift between servers that should be identical. How do you fix it?

**Answer:**  

Steps:

1. Use facts and tasks to gather configuration from all servers.
2. Compare differences (e.g., file hashes, package versions).
3. Adjust playbooks/roles to enforce desired config explicitly (not just assumed).
4. Run playbooks in `--check` mode to preview corrections, then actual run.

**Best Practices:**

- Treat Ansible as convergence tool; rerun playbooks regularly to heal drift.
- Add new tasks to enforce previously implicit assumptions.

**Follow-up Questions:**

- Have you used Ansible for regular compliance checks?
- How do you alert when drift recurs?

---

### Q30. Scenario: You need to support both on-prem Linux servers and cloud VMs. How do you design Ansible architecture?

**Answer:**  

Architecture:

- Single control node (or HA pair) inside secure network.
- Inventories split by environment and location (on-prem, AWS, Azure).
- Dynamic inventory for cloud, static or CMDB integration for on-prem.
- Roles parameterized to handle on-prem vs cloud-specific config (e.g., monitoring, logging endpoints).

**Security:**

- SSH keys managed centrally; jump hosts/bastions when needed.
- Vault for sensitive credentials.

**Best Practices:**

- Keep roles generic; environment specifics in group/host vars.
- Use the same playbooks to converge all hosts to desired baseline, with environment-specific overrides.

**Follow-up Questions:**

- How do you handle network connectivity constraints (VPN, firewalls) for control node?
- How would you gradually migrate on-prem hosts to cloud while keeping playbooks usable?

## 9. Ansible Tower/AWX, Governance, and Large-Scale Operations

### Q31. What are Ansible Tower/AWX and why would you use them?

**Answer:**  
Ansible Tower (commercial) and AWX (upstream) are web-based UI/API layers on top of Ansible that provide role-based access control, centralized credential management, job scheduling, logging, and REST APIs.[web:79][web:83] They help move from CLI-only Ansible to a managed, auditable automation platform.

**Use in enterprise:**

- Allow L1/L2 ops to trigger pre-defined playbooks via UI/API without giving shell access.
- Centralize execution logs, inventories, and credentials.
- Integrate with LDAP/AD and SSO for governance.

**Common Mistakes:**

- Treating Tower simply as a GUI wrapper without leveraging RBAC and workflows.
- Migrating too many ad-hoc playbooks into Tower without standardization.

**Follow-up Questions:**

- How would you design inventories and projects in Tower for multiple teams?
- How do you integrate Tower/AWX with Jenkins and change management?

---

### Q32. How do you manage credentials securely in Tower/AWX?

**Answer:**  

Patterns:

- Store credentials (SSH keys, vault passwords, cloud API keys) in Tower’s encrypted credential store.
- Map credentials to inventories, projects, or job templates with RBAC.
- Use machine credentials for SSH, vault credentials for Ansible Vault, cloud credentials for AWS/Azure modules.[web:83]

**Best Practices:**

- Principle of least privilege for credentials.
- Rotate credentials regularly; use external credential plugins if possible (e.g., HashiCorp Vault integration).

**Common Mistakes:**

- Reusing same global credential for multiple environments.
- Giving too many users permission to view/decrypt credentials.

**Follow-up Questions:**

- How do you restrict who can use vs view credentials?
- Have you used external secrets integration in Tower/AWX?

---

### Q33. How would you expose Ansible operations safely to non-DevOps users (e.g., L2 support)?

**Answer:**  

Approach:

- Use Tower/AWX job templates or Jenkins parameterized jobs representing **safe, pre-defined** operations (restart service, clear cache, run health check).
- Define input parameters with validation (e.g., environment, service name).
- Leverage RBAC to allow certain users to run specific jobs but not edit playbooks.

**Benefits:**

- L2 can trigger runbooks without logging into servers.
- Consistent, audited execution path.

**Common Mistakes:**

- Job templates too generic (allow arbitrary command execution).
- No guardrails on parameters (e.g., environment, host selection).

**Follow-up Questions:**

- Example of a “button” you’d provide for L2.
- How do you version control playbooks that back these operations?

---

## 10. Advanced CI/CD and Deployment Patterns with Ansible

### Q34. How do you combine Ansible with blue–green deployments at the VM level?

**Answer:**  

Pattern:

- Maintain two sets of app servers or ASGs (blue and green).
- Use Ansible to:

  - Provision/configure green nodes.
  - Run tests on green.
  - Update load balancer (Terraform/cloud modules) to route traffic to green.
  - Optionally decommission blue after validation.

**Ansible role responsibilities:**

- Install app on green servers.
- Register/deregister from load balancer.

**Common Mistakes:**

- Updating DNS or LB before confirming green is ready.
- Not cleaning up old blue environment, leading to cost and confusion.

**Follow-up Questions:**

- How would you integrate this flow into Jenkins pipelines?
- How do you track which environment is currently live?

---

### Q35. How can you use Ansible for canary deployments (without Kubernetes)?

**Answer:**  

Idea:

- Treat a small subset of servers as “canary”.
- Ansible inventory groups: `app_canary`, `app_stable`.

Flow:

1. Deploy new version to `app_canary` only.
2. Monitor metrics (errors, latency) from canary servers.
3. If healthy, deploy to larger subset or full fleet via Ansible.

**Implementation:**

- Use inventory groups and `--limit app_canary` first.
- Then apply to `app_servers` with `serial` control.

**Common Mistakes:**

- No proper monitoring; canary stage is just nominal.
- Not clearly labeling and isolating canary servers.

**Follow-up Questions:**

- How would you choose canary host(s)?
- How do you roll back if canary shows issues?

---

### Q36. How would you integrate Ansible with fast-moving application CI/CD (e.g., Jenkins + Docker + K8s)?

**Answer:**  

Patterns:

- Ansible focuses on:

  - Base OS hardening for nodes (VMs, worker nodes).
  - Installing shared tools (monitoring, logging, security agents).
  - Managing non-containerized services and legacy systems.

- Jenkins + Helm/Kubernetes handle:

  - Packaging services into containers.
  - Deploying to clusters.

**Integration Points:**

- Jenkins pipeline runs Ansible steps for node-level configuration before or alongside K8s deployments.
- Ansible used to manage jump hosts, bastions, or DB nodes that K8s apps depend on.

**Common Mistakes:**

- Trying to use Ansible to deploy container workloads directly when Helm/GitOps is more appropriate.
- Mixing responsibilities without clear boundaries.

**Follow-up Questions:**

- Example of a node-level task that you would only do with Ansible.
- How do you version-control Ansible configuration alongside app infrastructure code?

---

## 11. Troubleshooting and Debugging Complex Failures

### Q37. How do you debug Ansible playbooks that behave differently on different hosts?

**Answer:**  

Steps:

1. Use `-vvv` verbosity and `--limit` to focus on one problematic host.
2. Run `setup` module (`gather_facts`) to inspect facts; differences in OS, paths, or packages may cause behavior differences.
3. Add `debug` tasks to print variable values and condition evaluations.
4. Check logs and return values from modules (e.g., `register` variables).

**Common Causes:**

- OS differences, different package versions, or misaligned configs.
- Host-specific overrides in `host_vars` that you forgot about.

**Follow-up Questions:**

- How do you ensure consistent facts across similar hosts?
- Have you used `ansible-console` for interactive debugging?

---

### Q38. How do you approach debugging performance issues where Ansible runs are too slow?

**Answer:**  

Consider:

- Number of hosts and tasks.
- `forks` and parallelism.
- Heavy tasks (e.g., large file transfers, remote repository operations).

Optimizations:

- Increase `forks` (up to safe limits).
- Disable unnecessary fact gathering (`gather_facts: false`), or use `setup` only with filters.
- Use `run_once` for tasks that don’t need to run on every host (e.g., API calls).
- Use `async` + `poll` for long-running tasks.

**Common Mistakes:**

- Per-host heavy operations that could be done once and distributed (e.g., file generation).
- Using `serial: 1` for tasks that could be parallelized.

**Follow-up Questions:**

- How would you profile where time is being spent in a playbook?
- How do you ensure optimizations don’t compromise safety?

---

### Q39. How do you handle differences between development and production environments with Ansible?

**Answer:**  

Patterns:

- Separate inventories (`inventory/dev`, `inventory/prod`).
- Environment-specific variables in `group_vars/dev.yml`, `group_vars/prod.yml`.
- Same roles/playbooks, different inputs.

Examples of differences:

- Log levels (debug in dev, info/warn in prod).
- Package versions pinned more strictly in prod.
- Security hardening stricter in prod.

**Common Mistakes:**

- Conditionals based on hostnames inside tasks instead of inventory.
- No clear separation of dev/test/prod, leading to accidental runs on wrong env.

**Follow-up Questions:**

- How would you mark prod inventory clearly to avoid mistakes?
- How do you handle new features that should only be turned on in non-prod?

---

### Q40. How do you manage OS hardening and baseline configuration with Ansible?

**Answer:**  

Approach:

- Create hardened baseline roles (e.g., `os_hardening`, `ssh_hardening`, `auditd`).
- Apply them to all servers early in provisioning.
- Use CIS or internal security benchmarks as reference; implement as Ansible tasks.

**Elements:**

- SSH config (Disable root login, key-only auth).
- Packages (security updates, minimal packages).
- Filesystem permissions, logging, auditing.

**Common Mistakes:**

- Applying hardening late, creating drift and exceptions.
- Not re-running hardening roles regularly; manual changes slip in.

**Follow-up Questions:**

- How do you coordinate OS hardening with security teams?
- How do you avoid breaking applications with too strict hardening?

---

## 12. Governance, Standards, and Real RCAs

### Q41. How do you ensure Ansible playbooks follow coding and style standards?

**Answer:**  

Tools and practices:

- Use `ansible-lint` to enforce best practices (no bare `command`, tasks named, etc.).
- Code reviews for Ansible changes, just like application code.
- Clear guidelines: use roles, variables, proper naming, consistent tags.

**CI Integration:**

- Jenkins/GitHub Actions runs `ansible-lint` on PRs.
- Fail builds on severe lint violations.

**Follow-up Questions:**

- Example of a bug caught by `ansible-lint`.
- How would you structure a contribution guide for playbook authors?

---

### Q42. Describe a production incident caused by Ansible and how you handled it.

**Answer (example narrative):**  

**Incident:**  
A playbook intended for dev accidentally ran against prod inventory, changing firewall rules and causing brief connectivity outages.

**Root Causes:**

- Single inventory file with dev and prod hosts; not clearly separated.
- No environment confirmation step or RBAC restrictions.

**Resolution:**

1. Immediately ran rollback playbook that restored known-good firewall rules.
2. Verified services recovered using monitoring and health checks.
3. Implemented controls:
   - Separate inventories and repos for prod vs non-prod.
   - Extra “Are you sure?” prompts for prod (`--check` + manual review).
   - RBAC so only senior engineers can run prod playbooks.

**Follow-up Questions:**

- How do you avoid environment mix-ups in this role?
- What signals would you have on your dashboards to detect such misconfiguration quickly?

---

### Q43. How do you document and share Ansible runbooks with the wider team?

**Answer:**  

Approach:

- Store playbooks and roles in Git with README per role.
- Add usage examples, parameter descriptions, and “when to use” sections.
- Use Confluence or internal wiki with diagrams and links to repository.
- Tower/AWX job templates with descriptions linking back to documentation.

**Common Mistakes:**

- Tribal knowledge only; runbooks known only to a few engineers.
- Documentation not updated when playbooks change.

**Follow-up Questions:**

- How would you keep documentation in sync with playbooks (e.g., CI checks)?
- How do you onboard new engineers to Ansible usage?

---

### Q44. How do you approach refactoring a large, messy Ansible codebase?

**Answer:**  

Steps:

1. Identify frequently used playbooks/roles and their problems.
2. Add `ansible-lint` and basic tests for critical parts to avoid regressions.
3. Gradually refactor into roles, group/env-based vars, and standardized patterns.
4. Create platform roles for commonly repeated tasks (user management, logging, monitoring).
5. Deprecate and remove unused/duplicate roles.

**Best Practices:**

- Refactor incrementally; don’t “big-bang” rework everything.
- Keep behavior backward-compatible where possible.

**Follow-up Questions:**

- Example of a refactor you performed and its impact.
- How do you prioritize which playbooks/roles to clean up first?

---

### Q45. How do you handle Ansible version upgrades in an enterprise?

**Answer:**  

Steps:

1. Pin Ansible version in requirements (control node/Python env).
2. Test new Ansible version in a staging environment:
   - Run existing playbooks, check for warnings/deprecations.
3. Fix deprecated features or incompatible behaviors.
4. Roll out new version gradually:
   - Non-prod control nodes first, then prod.

**Common Mistakes:**

- Unpinned versions; upgrade accidentally via OS package manager.
- Not reading release notes and ignoring deprecation warnings.

**Follow-up Questions:**

- How have you handled Python version upgrades impacting Ansible?
- How do you verify that upgrade did not break any critical roles?

---

### Q46. How do you run Ansible safely in parallel with other automation tools (Chef, Puppet, scripts)?

**Answer:**  

Key considerations:

- Avoid having multiple tools manage the same resource attributes (e.g., same config file).
- Decide clear ownership: e.g., Ansible for app deployment, Chef for base OS config, or vice versa.
- Use “no-op” mode or check conditions when migrating.

**Common Mistakes:**

- Overlapping ownership causing configuration fights (tools switching file content back and forth).
- No central documentation of who owns what.

**Follow-up Questions:**

- Example of coexistence you have seen (Ansible + Puppet).
- How would you migrate from one tool to Ansible with minimal disruption?

---

### Q47. How do you handle sensitive operations like database schema changes with Ansible?

**Answer:**  

Approach:

- Treat DB changes as “mini releases”:
  - Use playbooks that run migrations using dedicated modules or shell commands.
- Include:
  - Backup or snapshot step.
  - Dry-run or validation of migration logic in staging.
  - Strict `serial` and `run_once` semantics (single node executes DB migration).
- Integrate with CI/CD approvals and change tickets.

**Common Mistakes:**

- Running DB changes concurrently from multiple hosts.
- No rollback plan (e.g., no backup or revert scripts).

**Follow-up Questions:**

- How would you coordinate DB migrations with app deployments?
- How do you test DB migrations in lower environments?

---

### Q48. How do you support L2/L3 production support using Ansible?

**Answer:**  

Examples:

- Runbooks for:
  - Restarting services.
  - Rotating logs.
  - Flushing caches.
  - Running diagnostic scripts.
- Scheduled playbooks for daily health checks (e.g., checking disk usage, service status).
- Read-only diagnostic roles that gather facts and logs without making changes.

**Benefits:**

- Consistent, repeatable steps for incidents.
- Reduced manual errors.

**Follow-up Questions:**

- Example of an L2 operation you automated with Ansible.
- How do you gate high-risk operations behind approvals?

---

### Q49. How do you ensure Ansible is safe and auditable enough for a bank?

**Answer:**  

Controls:

- Version control for all playbooks/roles.
- CI to enforce linting and tests.
- RBAC via Tower/AWX or CI (who can run what, where).
- Logging and archiving of playbook runs, including inventory, parameters, and results.
- Integration with change management systems (Jira/ServiceNow).

**Common Mistakes:**

- Manual runs from laptops without logging.
- No separation between prod and non‑prod automation environments.

**Follow-up Questions:**

- How do you prove to auditors what changes were made by Ansible?
- How would you enforce approvals for prod operations?

---

### Q50. What are the biggest Ansible pitfalls you’ve seen, and how would you avoid them here?

**Answer (structured):**  

1. **Scripting mindset instead of idempotent configuration**  
   - Avoid: prefer modules, not shell; ensure tasks are re-runnable.

2. **Spaghetti playbooks with no roles or structure**  
   - Avoid: roles, inventories, clear separation of concerns.

3. **Environment confusion and accidental prod runs**  
   - Avoid: separate repos/inventories, environment prompts, RBAC.

4. **Secrets in plain text or poor vault use**  
   - Avoid: Vault + secret managers, strong vault password hygiene.

5. **No testing or linting**  
   - Avoid: `ansible-lint`, test runs, staging validations.

For the SocGen Specialist DevOps role, highlight that Ansible will be used to harden and configure servers, integrate with Jenkins/Terraform pipelines, and provide safe, auditable runbooks for production support.

**Follow-up Questions:**

- Which pitfalls have you fixed before?
- How would you design an Ansible platform from scratch for this environment?
