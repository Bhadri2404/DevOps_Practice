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
