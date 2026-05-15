
---

## 📌 Table of Contents
1. [What is Configuration Management?](#1-what-is-configuration-management)
2. [What is Ansible?](#2-what-is-ansible)
3. [Key Terminologies](#3-key-terminologies)
4. [Installing Ansible](#4-installing-ansible)
5. [Inventory — Static](#5-inventory--static)
6. [ansible.cfg — Configuration File](#6-ansiblecfg--configuration-file)
7. [Ad-hoc Commands](#7-ad-hoc-commands)
8. [Modules](#8-modules)
9. [Facts — setup module](#9-facts--setup-module)
10. [Playbooks](#10-playbooks)
11. [YAML Basics](#11-yaml-basics)
12. [Variables](#12-variables)
13. [Register Module](#13-register-module)
14. [Debug Module](#14-debug-module)
15. [vars_prompt — User Input](#15-vars_prompt--user-input)
16. [Handlers](#16-handlers)
17. [Conditionals — when](#17-conditionals--when)
18. [Templates — Jinja2](#18-templates--jinja2)
19. [Loops — with_items](#19-loops--with_items)
20. [Tags](#20-tags)
21. [Roles](#21-roles)
22. [Error Handling](#22-error-handling)
23. [Ansible Vault](#23-ansible-vault)
24. [include / import](#24-include--import)
25. [Best Practices](#25-best-practices--production-level)
26. [Debugging & Troubleshooting](#26-debugging--troubleshooting)
27. [Interview Preparation](#27-interview-preparation-section)

---

## 1. What is Configuration Management?

### 📖 Concept Explanation
- **Configuration Management (CM)** tools manage the configuration of IT infrastructure — OS, software, network devices, applications, cloud services.
- IT infrastructure changes constantly — packages are added, removed, patched. Doing this manually on **hundreds of servers** is time-consuming and error-prone.
- CM tools allow you to **automate all those changes from a centralized place**.

### 🔑 Key Features of CM Tools
- **Centralized Configuration** — Manage all servers from one control node.
- **Enforcement** — Ensures servers stay in the **desired state**. Prevents **configuration drift**.
- **Abstraction** — One config file works across Ubuntu, CentOS, RHEL, etc.
- **Version Control Friendly** — All configs are plain text → Git trackable.
- **Replication** — Easily replicate production, staging, dev environments identically.

### 🌍 Popular CM Tools
| Tool | Language | Agent? | Style |
|---|---|---|---|
| Ansible | Python | ❌ Agentless | Push |
| Puppet | Ruby | ✅ Agent | Pull |
| Chef | Ruby | ✅ Agent | Pull |
| Saltstack | Python | Optional | Push/Pull |
| CFEngine | C | ✅ Agent | Pull |

### 🏭 DevOps Lifecycle Fit
- CM fits in the **Deploy + Configure** phase of CI/CD.
- Jenkins builds artifact → Ansible deploys and configures EC2 instances → App runs.

---

## 2. What is Ansible?

### 📖 Concept Explanation
- **Ansible** is an open-source, agentless automation tool for:
  - Configuration Management
  - Application Deployment
  - Orchestration
  - Provisioning
- Written in **Python**.
- Communicates over **SSH** (Linux) and **WinRM** (Windows).
- **No agent needed** — SSH is built into Linux by default.
- **No database, no daemons** — install once on control machine and manage entire fleet.

### 🔑 Why Ansible Over Others?
- **Simplest** to learn — uses YAML (human-readable).
- **Agentless** — no setup on managed nodes.
- **Idempotent** — run a playbook 10 times, result is same as running once.
- **Masterless** — no separate master server required.

### 🔑 Idempotency — Critical Concept
> If a package is already installed, Ansible will NOT reinstall it.
> If a file already exists with the same content, Ansible will NOT overwrite it.
> Running the same playbook multiple times always produces the **same end state**.
changed: true → Task made a change on the host
changed: false → Host already in desired state, no change made

text

### 🏭 Production Scenario
EC2 fleet of 100 servers needs Nginx installed.
→ Run Ansible playbook once
→ Ansible SSHes into all 100 servers in parallel
→ Installs Nginx where missing, skips where already installed
→ Total time: ~2 minutes vs hours of manual work

text

### ⚠️ When NOT to Use Ansible
- Complex stateful workflows → Use Terraform for infrastructure provisioning.
- Windows-heavy environments with complex DSC → Consider PowerShell DSC.

---

## 3. Key Terminologies

### 📖 Core Terms

| Term | Definition |
|---|---|
| **Control Machine** | Server where Ansible is installed. Runs playbooks. |
| **Managed Node** | Remote server Ansible manages (no Ansible install needed). |
| **Inventory** | List of managed nodes (hosts/groups). |
| **Playbook** | YAML file containing plays — the main automation script. |
| **Play** | Maps a group of hosts to a set of tasks. |
| **Task** | Single unit of work — a module call. |
| **Module** | Pre-built function that does actual work (yum, apt, service, copy…). |
| **Handler** | Special task triggered only when notified by another task. |
| **Role** | Reusable, structured collection of tasks, variables, templates, handlers. |
| **Facts** | System info auto-gathered from managed nodes (OS, IP, memory…). |
| **Vault** | Encrypted storage for secrets. |

### 📖 Key Process Terms

**Change Management** — Formal process for modifying production systems (approval → execute → validate).

**Provisioning** — Preparing a system to reach a ready state:
- Installing web software
- Copying configs
- Copying web files
- Installing security updates
- Starting services

**Orchestration** — Coordinating multiple automated tasks in a **defined order** across multiple systems.
> Like an orchestra — each instrument (system) plays at the right time in the right order.
Example Orchestration Order:

Setup Database (so web can connect to it)

Setup Web Service (connects to DB on startup)

Setup Load Balancer (adds web servers to pool)

Setup Monitoring (monitors LB, web, DB)

text

---

## 4. Installing Ansible

### 📟 Installation Commands

**RHEL / CentOS:**
```bash
sudo yum install epel-release -y
sudo yum install ansible -y
```

**Ubuntu / Debian:**
```bash
sudo apt-get install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y
```

**Verify Installation:**
```bash
ansible --version
```

### 🔑 Quick Notes
- Ansible is installed **only on the Control Machine**.
- Requires **Python 2.6/2.7+** on control machine.
- **Windows is NOT supported** as a control machine.
- Managed nodes need **Python 2.6+** as well.
- No daemons to start — Ansible is stateless.

### ⚙️ SSH Key Exchange (Production Best Practice)
```bash
# Generate SSH key on Ansible control machine
ssh-keygen -t rsa

# Copy public key to managed node
ssh-copy-id ubuntu@<node-ip>

# Now Ansible can SSH without password
```

---

## 5. Inventory — Static

### 📖 Concept Explanation
- **Inventory** is a text file listing all managed hosts and groups.
- Default location: `/etc/ansible/hosts`
- Custom inventory: pass with `-i <path>` flag.
- Groups help apply tasks to multiple hosts at once.

### 📟 Basic Inventory Syntax

```ini
# inventory-dev

web1 ansible_host=192.168.1.13 ansible_user=vagrant ansible_password=vagrant
db1  ansible_host=192.168.1.14 ansible_user=vagrant ansible_password=vagrant

[webservers]
web1

[dbservers]
db1
```

### 📟 Production-Level Inventory (SSH Key, /etc/hosts)

```bash
# /etc/hosts
192.168.1.13  web1
192.168.1.14  db1
```

```ini
# inventory-prod (clean, no passwords)
[webservers]
web1

[dbservers]
db1
```

### 📟 Group of Groups + Group Variables

```ini
[webservers]
web1
web2

[dbservers]
db1

# Master group containing other groups
[datacenter:children]
webservers
dbservers

# Variables for entire datacenter group
[datacenter:vars]
ansible_user=vagrant
ansible_password=vagrant
```

### 🔑 Important Inventory Variables

| Variable | Purpose |
|---|---|
| `ansible_host` | IP or hostname to connect to |
| `ansible_port` | SSH port (default: 22) |
| `ansible_user` | SSH username |
| `ansible_password` | SSH password (use Vault!) |
| `ansible_ssh_private_key_file` | Path to SSH private key |

> **Note:** Ansible 2.0+ uses `ansible_user`, `ansible_password`, `ansible_port`.
> Older versions used `ansible_ssh_user`, `ansible_ssh_pass`, `ansible_ssh_port`.

### 📁 Production Directory Layout
production/
├── inventory
├── group_vars/
│ ├── all # Variables for ALL hosts
│ └── dbservers # Variables for dbservers group only
└── host_vars/
└── web1 # Variables for web1 host only

staging/
├── inventory
├── group_vars/
│ └── all
└── host_vars/

text

### 🏭 Production Scenario
> Ansible manages 50 EC2 web servers and 10 RDS-connected app servers:
```ini
[webservers]
web-01.prod.internal
web-02.prod.internal
...

[appservers]
app-01.prod.internal

[prod:children]
webservers
appservers

[prod:vars]
ansible_user=ec2-user
ansible_ssh_private_key_file=~/.ssh/prod-key.pem
```

### ⚠️ Common Mistakes
- **Storing passwords in plain text inventory** — Use Vault or SSH keys instead.
- **No grouping** — Grouping is essential for targeting correct servers.
- **Mixing prod and staging in same inventory** — Use separate inventory directories.

---

## 6. ansible.cfg — Configuration File

### 📖 Concept Explanation
- Global Ansible configuration file.
- Default: `/etc/ansible/ansible.cfg`
- **Local `ansible.cfg`** (in your project directory) **takes higher precedence** than global.

### 📟 Sample ansible.cfg

```ini
[defaults]
inventory         = inventory-dev
remote_user       = ubuntu
host_key_checking = False
# ask_sudo_pass   = True
```

### 🔑 Precedence Order (High → Low)
1. Environment variables (`ANSIBLE_HOST_KEY_CHECKING=False`)
2. Project-level `./ansible.cfg`
3. User-level `~/.ansible.cfg`
4. Global `/etc/ansible/ansible.cfg`

### 🔑 Common Config Parameters

```ini
[defaults]
inventory           = ./inventory
remote_user         = ec2-user
private_key_file    = ~/.ssh/mykey.pem
host_key_checking   = False
forks               = 20       # Parallel connections
timeout             = 30
log_path            = /var/log/ansible.log
retry_files_enabled = False

[privilege_escalation]
become       = True
become_method = sudo
become_user  = root
```

### 🏭 DevOps Scenario
> In a Jenkins CI/CD pipeline, place `ansible.cfg` in the project root so it auto-discovers inventory and uses EC2 SSH keys:
```ini
[defaults]
inventory         = ./inventory/prod
remote_user       = ec2-user
private_key_file  = /var/jenkins/keys/prod.pem
host_key_checking = False
log_path          = /var/log/ansible/deploy.log
```

### ⚠️ Common Mistake
- Forgetting to disable `host_key_checking` in automated CI pipelines → pipeline hangs waiting for keyboard input.

---

## 7. Ad-hoc Commands

### 📖 Concept Explanation
- Quick, one-time commands to run a **single module** on remote hosts without writing a playbook.
- Used for: quick checks, one-off tasks, testing connectivity, gathering facts.
- **Not reusable** — for repeated tasks, use playbooks.

### 📟 Command Structure

```bash
ansible <host/group> -i <inventory> -m <module> -a "<arguments>" [options]
```

### 📟 Common Ad-hoc Examples

```bash
# Test connectivity (ping module)
ansible all -i inventory-dev -m ping

# Run a command on remote host
ansible webservers -m command -a "uptime"

# Install a package (yum - RHEL)
ansible webservers -i inventory-dev -m yum -a "name=httpd state=present" --become

# Install a package (apt - Ubuntu)
ansible webservers -m apt -a "name=nginx state=present" --become

# Start a service
ansible webservers -m service -a "name=httpd state=started" --become

# Copy file to remote
ansible all -m copy -a "src=/etc/hosts dest=/tmp/hosts"

# Change file permissions
ansible webservers -m file -a "dest=/opt/info.txt mode=600 owner=devops group=devops"

# Ensure package at latest version
ansible webservers -m yum -a "name=httpd state=latest" --become

# Remove a package
ansible webservers -m yum -a "name=httpd state=absent" --become

# Reboot servers
ansible webservers -m command -a "/sbin/reboot -t now" --become
```

### 🔑 Ad-hoc Output Explained

```json
web1 | SUCCESS => {
    "changed": true,    // Task made a change
    "name": "httpd",
    "state": "started"
}

web1 | SUCCESS => {
    "changed": false,   // Already in desired state — IDEMPOTENT
    "name": "httpd",
    "state": "started"
}
```

### 🔑 Key Flags

| Flag | Purpose |
|---|---|
| `-i` | Specify inventory file |
| `-m` | Module name |
| `-a` | Module arguments |
| `--become` | Run with sudo (privilege escalation) |
| `-u` | Remote username |
| `--private-key` | Path to SSH key |
| `-v / -vvv` | Verbosity level |

### 🏭 DevOps Scenario
> Quick health check across 50 prod EC2 web servers before a deployment:
```bash
ansible webservers -i inventory/prod -m ping
ansible webservers -m command -a "df -h"
ansible webservers -m command -a "free -m"
```

### ⚠️ Common Mistakes
- Using `--sudo` (deprecated) instead of `--become`.
- Not specifying inventory with `-i` when no `ansible.cfg` is present → defaults to `/etc/ansible/hosts`.

---

## 8. Modules

### 📖 Concept Explanation
- **Modules** are the actual workers in Ansible — they do the real job.
- Each task in a playbook is a **module call**.
- 1000s of built-in modules available.
- View all modules: `ansible-doc -l`
- View specific module docs: `ansible-doc yum`

### 🔑 Essential Modules Reference

| Module | Purpose | OS |
|---|---|---|
| `ping` | Test connectivity | All |
| `yum` | Package management | RHEL/CentOS |
| `apt` | Package management | Ubuntu/Debian |
| `service` | Manage services | All |
| `copy` | Copy files | All |
| `file` | Manage files/dirs/permissions | All |
| `template` | Copy Jinja2 template | All |
| `command` | Run commands (no shell features) | All |
| `shell` | Run shell commands (with pipes/redirects) | All |
| `user` | Manage users | All |
| `group` | Manage groups | All |
| `git` | Clone/pull git repos | All |
| `docker_container` | Manage Docker containers | All |
| `ec2` | Launch AWS EC2 instances | AWS |
| `s3` | Manage AWS S3 buckets | AWS |
| `setup` | Gather facts | All |
| `debug` | Print messages/variables | All |
| `register` | Store output of a task | All |
| `mysql_db` | Manage MySQL databases | All |
| `mysql_user` | Manage MySQL users | All |
| `iptables` | Manage firewall rules | Linux |

### 📟 Module Syntax Styles

**Old Style (inline):**
```yaml
tasks:
  - yum: name=httpd state=present
```

**New Style (YAML dict — recommended):**
```yaml
tasks:
  - name: Install Apache
    yum:
      name: httpd
      state: present
```

### ⚠️ Common Mistake
- Using `shell` or `command` module when a dedicated module exists:
```yaml
# ❌ BAD — not idempotent
- shell: apt-get install nginx

# ✅ GOOD — idempotent
- apt:
    name: nginx
    state: present
```

---

## 9. Facts — setup module

### 📖 Concept Explanation
- **Facts** are system variables automatically gathered from managed nodes at the start of every playbook run.
- Facts include: IP addresses, OS type, memory, CPU, hostname, kernel version, etc.
- Used in **conditionals**, **templates**, and **dynamic logic**.
- Gathered by the `setup` module automatically (runs as "Gathering Facts" task).

### 📟 Gather Facts Manually

```bash
# View all facts for a host
ansible -m setup web1

# Filter specific facts
ansible all -m setup -a 'filter=ansible_*_mb'     # Memory facts
ansible all -m setup -a 'filter=ansible_os_family' # OS family
ansible all -m setup -a 'filter=ansible_eth[0-2]'  # Network interfaces

# Gather only subset of facts
ansible all -m setup -a 'gather_subset=network,virtual'

# Minimal facts (faster playbooks)
ansible all -m setup -a 'gather_subset=!all'

# Store facts to files
ansible all -m setup --tree /tmp/facts
```

### 🔑 Commonly Used Facts

| Fact Variable | Value Example |
|---|---|
| `ansible_os_family` | `"RedHat"`, `"Debian"` |
| `ansible_distribution` | `"CentOS"`, `"Ubuntu"` |
| `ansible_hostname` | `"web1"` |
| `ansible_default_ipv4.address` | `"192.168.1.10"` |
| `ansible_memtotal_mb` | `2048` |
| `ansible_processor_cores` | `4` |
| `ansible_kernel` | `"5.4.0-42-generic"` |
| `inventory_hostname` | Name of host as defined in inventory |

### 📟 Disable Facts (Faster Playbooks)

```yaml
***
- hosts: webservers
  gather_facts: false
  tasks:
    - name: Just restart nginx
      service:
        name: nginx
        state: restarted
```

### 🏭 Production Scenario
> Use facts to dynamically configure Nginx differently on different EC2 instance types:
```yaml
- name: Set worker processes based on CPU count
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
# In template: worker_processes {{ ansible_processor_cores }};
```

---

## 10. Playbooks

### 📖 Concept Explanation
- **Playbooks** are Ansible's main automation scripts — written in **YAML**.
- A playbook contains one or more **plays**.
- A **play** maps a group of hosts to a list of **tasks**.
- Think: Playbook = Instruction Manual, Modules = Tools, Inventory = Raw Material.
- Playbooks should be **stored in Git** and version controlled.

### 📟 Basic Playbook Structure

```yaml
***
- hosts: webservers          # Which hosts/groups to target
  become: yes                # Run as sudo
  gather_facts: yes          # Collect system facts (default: yes)
  vars:                      # Playbook-level variables
    http_port: 80

  tasks:
    - name: Install Apache
      yum:
        name: httpd
        state: present

    - name: Start Apache
      service:
        name: httpd
        state: started
        enabled: yes
```

### 📟 Full Production Playbook — Web + DB Server Setup

```yaml
***
- hosts: webservers
  become: yes
  tasks:
    - name: Ensure Apache is installed
      yum:
        name: httpd
        state: present

    - name: Create web directory
      file:
        path: /var/www/html
        state: directory

    - name: Deploy webpage
      copy:
        src: index.html
        dest: /var/www/html/index.html
        mode: '0644'

    - name: Ensure Apache is running and enabled
      service:
        name: httpd
        state: started
        enabled: yes

    - name: Allow port 80 through firewall
      iptables:
        chain: INPUT
        protocol: tcp
        destination_port: 80
        jump: ACCEPT
        state: present

- hosts: dbservers
  become: yes
  tasks:
    - name: Install MySQL
      yum:
        name: mysql-server
        state: present

    - name: Start MySQL service
      service:
        name: mysqld
        state: started
        enabled: yes

    - name: Install MySQL Python client
      yum:
        name: MySQL-python
        state: present

    - name: Create application database
      mysql_db:
        name: devops
        state: present

    - name: Create database user
      mysql_user:
        name: appuser
        password: "{{ db_password }}"
        priv: '*.*:ALL'
        state: present
```

### 📟 Execute a Playbook

```bash
# Basic run
ansible-playbook web_db.yml

# Specify inventory
ansible-playbook -i inventory/prod web_db.yml

# Dry run (check mode — no changes made)
ansible-playbook web_db.yml --check

# Check + show diffs
ansible-playbook web_db.yml --check --diff

# Verbose output
ansible-playbook web_db.yml -v
ansible-playbook web_db.yml -vvv

# Syntax check only
ansible-playbook web_db.yml --syntax-check

# Run only specific tags
ansible-playbook web_db.yml --tags "install"

# Skip specific tags
ansible-playbook web_db.yml --skip-tags "firewall"

# Limit to specific host
ansible-playbook web_db.yml --limit web1
```

### 🔑 Playbook Execution Output Explained
PLAY [webservers] 
TASK [Gathering Facts] **** # setup module runs automatically
ok: [web1]
TASK [Ensure Apache installed] 
changed: [web1] # Package was installed
TASK [Start Apache] 
ok: [web1] # Already running — no change

PLAY RECAP 
web1 : ok=3 changed=1 unreachable=0 failed=0

text

### 🏭 DevOps CI/CD Scenario
Developer pushes code to GitHub (main branch)
→ Jenkins detects push via webhook
→ Jenkins runs: ansible-playbook -i inventory/prod deploy.yml
→ Ansible SSHes into EC2 instances
→ Pulls latest code, updates Nginx config, restarts service only if config changed
→ Deployment complete ✅

text

---

## 11. YAML Basics

### 📖 Key YAML Rules for Ansible

```yaml
---                          # Start of YAML document (optional but recommended)

# List (bullet items)
fruits:
  - Apple
  - Orange
  - Mango

# Dictionary (key: value)
server:
  name: web1
  ip: 192.168.1.10
  port: 80

# List of dictionaries
employees:
  - name: Bhadresh
    role: DevOps
    skills:
      - Ansible
      - Terraform
  - name: Ravi
    role: Developer
    skills:
      - Python
      - Docker

# Inline (abbreviated) style
server: {name: web1, ip: 192.168.1.10}
fruits: ['Apple', 'Orange', 'Mango']

...                          # End of YAML document (optional)
```

### ⚠️ YAML Gotchas
- **Indentation uses SPACES only — NEVER tabs.**
- Colon `:` must be followed by a space.
- Strings with special characters must be quoted: `"Hello: World"`.
- Boolean values: `yes/no`, `true/false`, `on/off` — all valid YAML booleans.

---

## 12. Variables

### 📖 Concept Explanation
- Variables allow you to make playbooks **dynamic and reusable**.
- Instead of hardcoding values, define variables and reference them as `{{ varname }}`.
- Variable sources (precedence — higher number wins):
  1. Role defaults
  2. Inventory group_vars/all
  3. Inventory group_vars/\<group\>
  4. Inventory host_vars/\<host\>
  5. Playbook vars
  6. Playbook vars_prompt
  7. Extra vars (`-e`) — **highest priority**

### 📟 Variables in Playbook

```yaml
***
- hosts: dbservers
  become: yes
  vars:
    dbname: devops
    dbuser: appuser
    dbpass: "{{ vault_db_password }}"   # Use Vault for secrets!
    http_port: 8080

  tasks:
    - name: Create database
      mysql_db:
        name: "{{ dbname }}"
        state: present

    - name: Create DB user
      mysql_user:
        name: "{{ dbuser }}"
        password: "{{ dbpass }}"
        priv: '*.*:ALL'
        state: present
```

### 📟 group_vars and host_vars

```bash
# File: group_vars/all
# Applies to ALL hosts in inventory
user: deployuser
group: devops
timezone: Asia/Kolkata
```

```bash
# File: group_vars/dbservers
# Applies ONLY to dbservers group
dbname: devops
dbuser: appuser
dbpass: secret123
```

```bash
# File: host_vars/web1
# Applies ONLY to web1 host
user: webadmin            # Overrides group_vars/all for web1
http_port: 8080
doc_root: /var/www/html
```

### 🔑 Variable Precedence
- `host_vars/web1` **overrides** `group_vars/all` for host `web1`.
- `-e "key=value"` at command line **overrides everything**.

### 📟 Extra Variables at Runtime

```bash
ansible-playbook deploy.yml -e "env=production version=2.3.0"
```

### 🏭 Production Scenario
```bash
# Same playbook, different environments
ansible-playbook deploy.yml -e "env=staging db_host=staging-db.internal"
ansible-playbook deploy.yml -e "env=production db_host=prod-db.internal"
```

### ⚠️ Common Mistakes
- **Hardcoding values** — use variables for anything that can change between environments.
- **Storing passwords in plain text** — always use Ansible Vault.
- Forgetting `{{ }}` around variable names → treated as literal string.

---

## 13. Register Module

### 📖 Concept Explanation
- **`register`** captures the output of a task and stores it in a variable.
- Used to use the result of one task in subsequent tasks.

### 📟 Syntax

```yaml
***
- hosts: webservers
  become: yes
  tasks:
    - name: Get current user
      shell: /usr/bin/whoami
      register: current_user

    - name: Show captured output
      debug:
        msg: "Running as: {{ current_user.stdout }}"

    - name: Set file ownership using captured user
      file:
        path: /tmp/info.txt
        owner: "{{ current_user.stdout }}"
        state: touch

    - name: Check if app is running
      shell: pgrep -x nginx
      register: nginx_status
      ignore_errors: yes

    - name: Start nginx if not running
      service:
        name: nginx
        state: started
      when: nginx_status.rc != 0
```

### 🔑 Register Output Fields

| Field | Meaning |
|---|---|
| `.stdout` | Standard output as string |
| `.stdout_lines` | Output as list of lines |
| `.stderr` | Error output |
| `.rc` | Return code (0 = success) |
| `.changed` | Whether task changed something |
| `.failed` | Whether task failed |

---

## 14. Debug Module

### 📖 Concept Explanation
- Prints messages or variable values during playbook execution.
- Essential for **troubleshooting** variable values and task outputs.

### 📟 Syntax

```yaml
***
- hosts: all
  vars:
    http_port: 8087
    app_version: "2.3.0"

  tasks:
    - name: Print inventory hostname
      debug:
        msg: "Processing host: {{ inventory_hostname }}"

    - name: Print variable values
      debug:
        msg: "Port: {{ http_port }} | Version: {{ app_version }}"

    - name: Print entire variable content
      debug:
        var: ansible_default_ipv4

    - name: Debug at verbosity level 2+
      debug:
        msg: "Detailed debug info"
        verbosity: 2
```

---

## 15. vars_prompt — User Input

### 📖 Concept Explanation
- **`vars_prompt`** asks for user input at runtime when running a playbook.
- Useful for sensitive values you don't want in files (like one-time passwords).
- In production CI/CD, avoid `vars_prompt` — use Vault instead.

### 📟 Syntax

```yaml
***
- hosts: dbservers
  vars:
    http_port: 8087
  vars_prompt:
    - name: dbpass
      prompt: "Enter database password"
      private: yes       # Hides input (like password field)

  tasks:
    - name: Show DB password was received
      debug:
        msg: "Password captured (length): {{ dbpass | length }}"

    - name: Create DB user
      mysql_user:
        name: appuser
        password: "{{ dbpass }}"
        priv: '*.*:ALL'
        state: present
```

### ⚠️ Note
- `private: yes` masks the input (doesn't display typed characters).
- Use Vault for production — not `vars_prompt`.

---

## 16. Handlers

### 📖 Concept Explanation
- **Handlers** are special tasks that run **only when notified** by another task.
- A task notifies a handler **only when its state is `changed: true`**.
- If the file wasn't changed (already up to date), the handler is **NOT triggered**.
- Handlers run **at the end of the play** (not immediately when notified).
- Use case: Restart a service **only when its config file changes**.

### 📟 Syntax

```yaml
***
- hosts: webservers
  become: yes
  tasks:
    - name: Copy Apache config
      copy:
        src: httpd.conf
        dest: /etc/httpd/conf/httpd.conf
      notify:
        - Restart Apache              # Only triggers if file was changed

    - name: Copy Nginx config
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
      notify:
        - Restart Nginx

  handlers:
    - name: Restart Apache
      service:
        name: httpd
        state: restarted

    - name: Restart Nginx
      service:
        name: nginx
        state: restarted
```

### 🔑 Handler Behavior
- If config file is **different** → `changed: true` → handler **triggers** → service restarts.
- If config file is **same** → `changed: false` → handler **skipped** → no unnecessary restart.
- Multiple tasks can notify the same handler — handler runs only **once**.

### 🏭 Production Scenario
Jenkins pushes new Nginx config → Ansible copies to 20 EC2 servers
→ Config changed on 5 servers → Nginx restarts only on those 5 servers
→ Other 15 servers: no restart needed → Zero unnecessary downtime ✅

text

### ⚠️ Common Mistake
- Expecting handler to run immediately — handlers run at **end of play**.
- Use `meta: flush_handlers` to force handlers to run immediately mid-play.

---

## 17. Conditionals — when

### 📖 Concept Explanation
- **`when`** is Ansible's conditional — like `if/else` in programming.
- Task executes **only if** the condition evaluates to `true`.
- If condition is `false`, task is **skipped**.
- Commonly used with **facts** to handle multi-OS playbooks.

### 📟 Syntax

```yaml
***
- hosts: webservers
  become: yes
  tasks:
    - name: Install Apache on RHEL/CentOS
      yum:
        name: httpd
        state: present
      when: ansible_os_family == "RedHat"

    - name: Install Apache on Ubuntu/Debian
      apt:
        name: apache2
        state: present
      when: ansible_os_family == "Debian"

    - name: Install on specific distro version
      yum:
        name: httpd
        state: present
      when: ansible_distribution == "CentOS" and ansible_distribution_major_version == "7"

    - name: Skip if already configured
      template:
        src: app.conf.j2
        dest: /etc/app/app.conf
      when: app_configured is not defined or not app_configured

    - name: Run only in production
      command: /opt/run-migration.sh
      when: env == "production"
```

### 🔑 Condition Operators

```yaml
when: variable == "value"
when: variable != "value"
when: variable is defined
when: variable is not defined
when: variable | bool
when: result.rc == 0
when: condition1 and condition2
when: condition1 or condition2
```

### 🏭 Production Scenario
```yaml
# Multi-OS playbook for 100-server fleet (mix of Ubuntu and CentOS)
- name: Install nginx
  yum:
    name: nginx
    state: present
  when: ansible_os_family == "RedHat"

- name: Install nginx
  apt:
    name: nginx
    state: present
  when: ansible_os_family == "Debian"
```

---

## 18. Templates — Jinja2

### 📖 Concept Explanation
- **Templates** are files containing **variables and logic** that get rendered before being copied to managed nodes.
- Template files use **Jinja2** syntax and have `.j2` extension.
- Similar to `copy` module but **dynamic** — variables get substituted with actual values.
- Use case: Generate config files customized per host/environment.

### 📟 Template File Example — nginx.conf.j2

```jinja2
# nginx.conf.j2
server {
    listen {{ http_port }};
    server_name {{ server_name }};
    root {{ doc_root }};

    location / {
        index index.html index.htm;
    }

    # Auto-populated from facts
    # Server: {{ ansible_hostname }}
    # IP: {{ ansible_default_ipv4.address }}
}
```

### 📟 Playbook Using Template

```yaml
***
- hosts: webservers
  become: yes
  vars:
    http_port: 80
    server_name: myapp.example.com
    doc_root: /var/www/html

  tasks:
    - name: Deploy Nginx configuration
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
        owner: root
        group: root
        mode: '0644'
      notify:
        - Restart Nginx

  handlers:
    - name: Restart Nginx
      service:
        name: nginx
        state: restarted
```

### 🔑 Jinja2 Template Features

```jinja2
{# Comment — not included in output #}

{# Variable substitution #}
Hello {{ username }}!

{# Conditional #}
{% if env == "production" %}
worker_processes {{ ansible_processor_cores }};
{% else %}
worker_processes 1;
{% endif %}

{# Loop #}
{% for server in groups['webservers'] %}
upstream backend {
    server {{ server }};
}
{% endfor %}

{# Filters #}
{{ username | upper }}
{{ items | length }}
{{ path | basename }}
```

### 🏭 Production Scenario
100 EC2 web servers need Nginx config with different IPs and hostnames.
→ Single template nginx.conf.j2 with {{ ansible_hostname }} and {{ ansible_default_ipv4.address }}
→ Ansible renders unique config for each server
→ No manual editing of 100 config files ✅

text

---

## 19. Loops — with_items

### 📖 Concept Explanation
- **Loops** allow running the same task multiple times with different values.
- `with_items` (classic) or `loop` (modern Ansible 2.5+) syntax.
- Each iteration's value is accessed via `{{ item }}`.

### 📟 Syntax

```yaml
***
- hosts: webservers
  become: yes
  tasks:
    # Install multiple packages
    - name: Install required packages
      yum:
        name: "{{ item }}"
        state: present
      loop:
        - httpd
        - php
        - mysql
        - git

    # Create multiple users
    - name: Create application users
      user:
        name: "{{ item.name }}"
        group: "{{ item.group }}"
        state: present
      loop:
        - { name: 'appuser1', group: 'devops' }
        - { name: 'appuser2', group: 'devops' }
        - { name: 'dbadmin', group: 'dba' }

    # Create multiple directories
    - name: Create directory structure
      file:
        path: "{{ item }}"
        state: directory
        mode: '0755'
      loop:
        - /opt/app/logs
        - /opt/app/config
        - /opt/app/data

    # Old style (still valid)
    - name: Install packages (old style)
      yum:
        name: "{{ item }}"
        state: present
      with_items:
        - httpd
        - php
```

### 🏭 Production Scenario
```yaml
# Deploy multiple microservices in one play
- name: Start all application services
  service:
    name: "{{ item }}"
    state: started
    enabled: yes
  loop:
    - auth-service
    - payment-service
    - notification-service
    - api-gateway
```

---

## 20. Tags

### 📖 Concept Explanation
- **Tags** allow you to **selectively run** specific tasks in a playbook without running everything.
- Saves time in large playbooks when you only need to apply partial changes.
- Use `--tags` to run only tagged tasks.
- Use `--skip-tags` to skip specific tasks.

### 📟 Syntax

```yaml
***
- hosts: webservers
  become: yes
  tasks:
    - name: Install Apache
      yum:
        name: httpd
        state: present
      tags:
        - install
        - packages

    - name: Copy config file
      template:
        src: httpd.conf.j2
        dest: /etc/httpd/conf/httpd.conf
      tags:
        - configure

    - name: Start Apache
      service:
        name: httpd
        state: started
      tags:
        - service
        - start

    - name: Deploy application code
      git:
        repo: https://github.com/company/app.git
        dest: /var/www/html
        version: main
      tags:
        - deploy
        - code
```

```bash
# Run only install tasks
ansible-playbook playbook.yml --tags "install"

# Run install + configure
ansible-playbook playbook.yml --tags "install,configure"

# Skip deploy tasks
ansible-playbook playbook.yml --skip-tags "deploy"

# List all available tags
ansible-playbook playbook.yml --list-tags
```

### 🏭 Production Scenario
```bash
# Full deployment
ansible-playbook deploy.yml

# Quick config update only (no reinstall)
ansible-playbook deploy.yml --tags "configure"

# Emergency service restart only
ansible-playbook deploy.yml --tags "service"
```

---

## 21. Roles

### 📖 Concept Explanation
- **Roles** are a way to organize playbooks into **reusable, structured packages**.
- Large projects split into multiple roles (nginx role, mysql role, app role).
- Roles enforce a **standard directory structure** automatically recognized by Ansible.
- Use `ansible-galaxy` to download community roles.

### 📁 Role Directory Structure
````md
# Ansible Role Directory Structure

```text
roles/
└── nginx/
    ├── tasks/
    │   └── main.yml
    │
    ├── handlers/
    │   └── main.yml
    │
    ├── templates/
    │   └── nginx.conf.j2
    │
    ├── files/
    │   └── index.html
    │
    ├── vars/
    │   └── main.yml
    │
    ├── defaults/
    │   └── main.yml
    │
    ├── meta/
    │   └── main.yml
    │
    └── README.md
```

## Explanation

| Directory/File | Purpose |
|---|---|
| `tasks/main.yml` | Contains the main tasks executed by the role |
| `handlers/main.yml` | Contains handlers such as service restart/reload |
| `templates/` | Stores Jinja2 template files (`.j2`) |
| `files/` | Stores static files to copy directly to target servers |
| `vars/main.yml` | Role variables with higher precedence |
| `defaults/main.yml` | Default variables with lowest precedence (can be overridden) |
| `meta/main.yml` | Contains role metadata and dependencies |
| `README.md` | Documentation about the role |
````


### 📟 Role tasks/main.yml

```yaml
# roles/nginx/tasks/main.yml
***
- name: Install Nginx
  apt:
    name: nginx
    state: present
  tags: install

- name: Deploy Nginx config
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  notify: Restart Nginx
  tags: configure

- name: Ensure Nginx is started
  service:
    name: nginx
    state: started
    enabled: yes
  tags: service
```

### 📟 Role handlers/main.yml

```yaml
# roles/nginx/handlers/main.yml
***
- name: Restart Nginx
  service:
    name: nginx
    state: restarted
```

### 📟 Role defaults/main.yml

```yaml
# roles/nginx/defaults/main.yml
***
http_port: 80
server_name: localhost
doc_root: /var/www/html
worker_processes: auto
```

### 📟 Using Roles in a Playbook

```yaml
# site.yml
***
- hosts: webservers
  become: yes
  roles:
    - nginx
    - { role: nodejs, node_version: "18" }

- hosts: dbservers
  become: yes
  roles:
    - mysql
```

### 📟 Create Role Skeleton

```bash
ansible-galaxy init nginx
# Creates complete directory structure automatically
```

### 🏭 Production Project Structure
````md
# Ansible Infrastructure Project Structure

```text
my-infra/
├── ansible.cfg
├── site.yml
│
├── inventory/
│   ├── prod
│   └── staging
│
├── group_vars/
│   ├── all.yml
│   └── webservers.yml
│
├── host_vars/
│   └── web1.yml
│
└── roles/
    ├── common/
    ├── nginx/
    ├── nodejs/
    ├── mysql/
    └── monitoring/
```

## Explanation

| File/Directory | Purpose |
|---|---|
| `ansible.cfg` | Main Ansible configuration file |
| `site.yml` | Master playbook that calls all required roles |
| `inventory/` | Contains inventory files for different environments |
| `inventory/prod` | Production server inventory |
| `inventory/staging` | Staging server inventory |
| `group_vars/` | Variables applied to groups of servers |
| `group_vars/all.yml` | Variables applied to all hosts |
| `group_vars/webservers.yml` | Variables specific to web server group |
| `host_vars/` | Variables applied to specific hosts |
| `host_vars/web1.yml` | Variables for the `web1` server |
| `roles/` | Contains reusable Ansible roles |
| `roles/common/` | Common base configuration for all servers |
| `roles/nginx/` | Nginx setup and configuration |
| `roles/nodejs/` | Node.js installation and configuration |
| `roles/mysql/` | MySQL installation and database configuration |
| `roles/monitoring/` | Monitoring and observability setup |
````


---

## 22. Error Handling

### 📖 Concept Explanation
- By default, Ansible **stops execution** on the host where a task fails.
- Error handling allows you to control what happens when tasks fail.

### 📟 ignore_errors

```yaml
- name: Try to stop a service (may not exist)
  service:
    name: oldservice
    state: stopped
  ignore_errors: yes          # Continue even if this fails
```

### 📟 failed_when — Custom Failure Condition

```yaml
- name: Run a script
  shell: /opt/check_status.sh
  register: result
  failed_when: result.rc != 0 and "WARNING" not in result.stdout
```

### 📟 Blocks — Group Tasks with Error Handling

```yaml
***
- hosts: webservers
  become: yes
  tasks:
    - block:
        - name: Install application
          yum:
            name: myapp
            state: present

        - name: Start application
          service:
            name: myapp
            state: started

      rescue:
        # Runs only if block fails
        - name: Send alert on failure
          debug:
            msg: "Deployment failed! Alerting team..."

        - name: Rollback to previous version
          shell: /opt/rollback.sh

      always:
        # Always runs regardless of success or failure
        - name: Log deployment status
          shell: echo "Deployment attempted at $(date)" >> /var/log/deploy.log
```

### 📟 any_errors_fatal

```yaml
***
- hosts: webservers
  any_errors_fatal: true      # Stop ALL hosts if ANY host fails
  tasks:
    - name: Critical database migration
      shell: /opt/db-migrate.sh
```

---

## 23. Ansible Vault

### 📖 Concept Explanation
- **Ansible Vault** encrypts sensitive data (passwords, API keys, secrets) stored in YAML files.
- Encrypted files can be safely committed to Git.
- Vault uses AES-256 encryption.

### 📟 Vault Commands

```bash
# Create a new encrypted file
ansible-vault create secrets.yml

# Encrypt an existing file
ansible-vault encrypt vars/passwords.yml

# Decrypt a file (permanently)
ansible-vault decrypt vars/passwords.yml

# View encrypted file
ansible-vault view secrets.yml

# Edit encrypted file
ansible-vault edit secrets.yml

# Re-encrypt with new password
ansible-vault rekey secrets.yml

# Encrypt a single string value
ansible-vault encrypt_string 'MySecret123' --name 'db_password'
```

### 📟 Vault File Content (after encryption)

```yaml
# secrets.yml — encrypted with vault
$ANSIBLE_VAULT;1.1;AES256
38306438386138646236316536633665...
```

### 📟 Using Vault in Playbooks

```yaml
# group_vars/dbservers/vault.yml  (encrypted)
vault_db_password: "SuperSecret123"
vault_api_key: "abc123xyz"

# group_vars/dbservers/vars.yml  (plain text, references vault)
db_password: "{{ vault_db_password }}"
api_key: "{{ vault_api_key }}"
```

### 📟 Running Playbooks with Vault

```bash
# Prompt for vault password
ansible-playbook deploy.yml --ask-vault-pass

# Use vault password file
ansible-playbook deploy.yml --vault-password-file ~/.vault_pass

# Use vault ID (multiple vaults)
ansible-playbook deploy.yml --vault-id prod@~/.vault_pass_prod
```

### 🏭 Production Scenario
```bash
# Store AWS credentials in vault
ansible-vault create group_vars/all/vault.yml
# Add: vault_aws_access_key, vault_aws_secret_key

# In CI/CD (Jenkins):
ansible-playbook deploy.yml --vault-password-file /var/jenkins/vault_pass
```

### ⚠️ Common Mistakes
- **Committing unencrypted secret files** — always encrypt before git push.
- Storing vault password in the repo itself.

---

## 24. include / import

### 📖 Concept Explanation
- Split large playbooks into smaller, manageable files.
- `import_playbook` — statically imports entire playbook.
- `include_tasks` — dynamically includes task files at runtime.

### 📟 Syntax

```yaml
# site.yml — Master playbook
***
- import_playbook: webservers.yml
- import_playbook: dbservers.yml
- import_playbook: monitoring.yml
```

```yaml
# Include task files conditionally
- name: Include OS-specific tasks
  include_tasks: "{{ ansible_os_family }}.yml"
  # Loads RedHat.yml or Debian.yml based on OS
```

---

## 25. Best Practices — Production Level

### 🌿 Directory Structure
# Ansible Project Structure with Ansible Vault

```text
project/
├── ansible.cfg
├── site.yml
│
├── inventory/
│   ├── prod
│   └── staging
│
├── group_vars/
│   ├── all/
│   │   ├── vars.yml
│   │   └── vault.yml
│   │
│   └── webservers.yml
│
├── host_vars/
│
└── roles/
    └── nginx/
```

## Explanation

| File/Directory | Purpose |
|---|---|
| `ansible.cfg` | Main Ansible configuration settings |
| `site.yml` | Main playbook used to run all roles |
| `inventory/` | Stores inventory files for environments |
| `inventory/prod` | Production inventory file |
| `inventory/staging` | Staging inventory file |
| `group_vars/` | Group-level variables |
| `group_vars/all/vars.yml` | Common variables shared across all hosts |
| `group_vars/all/vault.yml` | Encrypted secrets using Ansible Vault |
| `group_vars/webservers.yml` | Variables specific to web servers |
| `host_vars/` | Host-specific variables |
| `roles/` | Contains reusable Ansible roles |
| `roles/nginx/` | Nginx role configuration and tasks |

### ✅ Production Rules
- **Always use roles** for reusable, modular code.
- **Never use `shell`/`command`** when a dedicated module exists — not idempotent.
- **Use variables** — never hardcode values in tasks.
- **Use Ansible Vault** for all secrets — never plaintext passwords.
- **Use `--check --diff`** before applying changes to production.
- **Run `ansible-lint`** on playbooks before committing.
- **Use tags** for selective execution in large playbooks.
- **Use `gather_facts: false`** when facts aren't needed — speeds up execution.
- **Test in staging** before running on production.
- **Store everything in Git** — treat automation code like application code.

### 🔑 Commit Message for Ansible Changes
feat(ansible): add nginx role for web tier
fix(ansible): correct handler name in mysql role
chore(ansible): update group_vars for prod inventory

text

---

## 26. Debugging & Troubleshooting

### 📟 Essential Debug Commands

```bash
# Test SSH connectivity to all hosts
ansible all -m ping

# Test specific host
ansible web1 -m ping -i inventory/prod

# Syntax check playbook (no execution)
ansible-playbook playbook.yml --syntax-check

# Dry run (no actual changes)
ansible-playbook playbook.yml --check

# Dry run + show what would change
ansible-playbook playbook.yml --check --diff

# Verbose levels
ansible-playbook playbook.yml -v      # Basic verbose
ansible-playbook playbook.yml -vv     # More detail
ansible-playbook playbook.yml -vvv    # Connection debug
ansible-playbook playbook.yml -vvvv   # Full SSH debug

# List all tasks without running
ansible-playbook playbook.yml --list-tasks

# List all hosts targeted
ansible-playbook playbook.yml --list-hosts

# List all tags
ansible-playbook playbook.yml --list-tags

# View inventory as JSON
ansible-inventory -i inventory/prod --list

# View facts for a host
ansible -m setup web1 -i inventory/prod

# View specific fact
ansible all -m setup -a 'filter=ansible_os_family'
```

### 🔑 Verbosity Levels

| Level | Flag | Shows |
|---|---|---|
| 0 | (none) | Task names + status |
| 1 | `-v` | Task results |
| 2 | `-vv` | Input/output details |
| 3 | `-vvv` | SSH connection details |
| 4 | `-vvvv` | Full SSH debug |

### 🔑 Common Errors & Fixes

| Error | Cause | Fix |
|---|---|---|
| `UNREACHABLE` | SSH not working | Check SSH keys, firewall, host IP |
| `Host Key Checking failed` | First connection | Set `host_key_checking = False` in ansible.cfg |
| `Permission denied` | Missing sudo | Add `become: yes` to play |
| `MODULE FAILURE` | Wrong module args | Check `ansible-doc <module>` |
| `YAML syntax error` | Bad indentation | Use spaces, not tabs. Use `ansible-lint` |
| `Variable undefined` | Var not set | Check group_vars, host_vars, spelling |

---

## 27. 🎯 Interview Preparation Section

### 📋 Common Interview Questions

**Q1: What is Ansible and why is it preferred over Puppet/Chef?**
> Ansible is an agentless, open-source automation tool using YAML playbooks. It's preferred because: no agent installation on nodes, SSH-based (uses existing infrastructure), easiest syntax (YAML), idempotent, and fastest to set up.

**Q2: What is idempotency in Ansible?**
> Running the same playbook multiple times produces the same result. If Apache is already installed, Ansible won't reinstall it (`changed: false`). This prevents duplicate operations and ensures consistent state.

**Q3: What is the difference between Ad-hoc commands and Playbooks?**
| | Ad-hoc | Playbook |
|---|---|---|
| Use case | Quick, one-time tasks | Complex, repeatable automation |
| Format | Single command | YAML file |
| Reusable? | ❌ | ✅ |
| Multi-task? | Single task | Multiple tasks in order |

**Q4: What is the difference between `copy` and `template` module?**
> `copy` transfers static files as-is. `template` processes Jinja2 variables in the file before copying — content is dynamically rendered per host.

**Q5: What is a handler and when does it execute?**
> A handler is a special task that runs only when notified by another task AND only when that task has `changed: true`. Handlers run at the END of the play (not immediately). Used for service restarts when config changes.

**Q6: What is the difference between `group_vars` and `host_vars`?**
> `group_vars/<groupname>` — variables apply to all hosts in that group. `host_vars/<hostname>` — variables apply only to that specific host. `host_vars` has higher precedence than `group_vars`.

**Q7: What is Ansible Vault?**
> Ansible Vault encrypts sensitive data (passwords, keys) using AES-256. Encrypted files can be safely stored in Git. Used with `--ask-vault-pass` or `--vault-password-file` at runtime.

**Q8: What are roles in Ansible?**
> Roles are reusable, structured collections of tasks, handlers, templates, files, and variables in a standard directory layout. They make playbooks modular, maintainable, and shareable via Ansible Galaxy.

**Q9: What is the difference between `import_tasks` and `include_tasks`?**
> `import_tasks` — static, processed at playbook parse time. Tags/conditions apply to all imported tasks. `include_tasks` — dynamic, processed at runtime. Allows conditional inclusion (e.g., include based on OS).

**Q10: How do you handle multi-OS environments in Ansible?**
> Use facts (`ansible_os_family`, `ansible_distribution`) with `when` conditionals, or use `include_tasks` to include OS-specific task files dynamically.

---

### 🎭 Scenario-Based Questions

**Scenario 1:** 50 EC2 servers need Nginx deployed, but 20 already have it. What happens?
> Ansible runs the playbook on all 50. On 20 that already have Nginx, the install task returns `changed: false` (idempotent). On 30 that don't have it, `changed: true`. Only those 30 are modified.

**Scenario 2:** Config file changes should automatically restart the service. How?
> Use `notify` in the copy/template task and define the restart as a `handler`. Handler triggers only when file content actually changes.

**Scenario 3:** You need different DB passwords for staging and production. How?
> Use separate Vault-encrypted files in `group_vars/staging/vault.yml` and `group_vars/prod/vault.yml` with different passwords. Same playbook, different inventory directories.

**Scenario 4:** A playbook fails mid-way. 10 of 50 servers were configured. What do you do?
> Re-run the same playbook — Ansible's idempotency ensures already-configured servers are skipped (`changed: false`) and only the remaining 40 get configured.

---

### 📊 Quick Comparison Tables

**Ansible vs Chef vs Puppet:**
| Feature | Ansible | Chef | Puppet |
|---|---|---|---|
| Language | YAML | Ruby (DSL) | Puppet DSL |
| Agent | ❌ Agentless | ✅ Required | ✅ Required |
| Architecture | Push | Pull | Pull |
| Learning curve | Low | High | Medium |
| Protocol | SSH/WinRM | SSH | HTTPS |

**Static vs Dynamic Inventory:**
| | Static | Dynamic |
|---|---|---|
| Format | INI/YAML file | Script/Plugin |
| Updates | Manual | Auto-discovers cloud resources |
| Use case | On-premise, fixed infra | AWS, GCP, Azure |
| Example | `inventory.ini` | `aws_ec2` plugin |

---

*📝 Notes prepared by: BHADRESH H | Senior DevOps Engineer*
