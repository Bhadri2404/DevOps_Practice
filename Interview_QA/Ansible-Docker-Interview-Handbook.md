# Ansible & Docker Interview Handbook

> Sample playbooks and Dockerfiles you can write on a whiteboard or explain verbally in an interview — every attribute/instruction explained simply first, then technically, with the "why" behind each choice.

---

## Table of Contents

**Part 1: Ansible**
- [1.1 What Is Ansible (Quick Context)](#11-what-is-ansible-quick-context)
- [1.2 Sample Production-Style Playbook](#12-sample-production-style-playbook)
- [1.3 Line-by-Line Explanation](#13-line-by-line-explanation)
- [1.4 Key Ansible Concepts](#14-key-ansible-concepts)
- [1.5 Ansible Interview Q&A](#15-ansible-interview-qa)

**Part 2: Dockerfile — Every Instruction Explained**
- [2.1 FROM](#21-from)
- [2.2 WORKDIR](#22-workdir)
- [2.3 COPY vs ADD](#23-copy-vs-add)
- [2.4 RUN](#24-run)
- [2.5 ENV vs ARG](#25-env-vs-arg)
- [2.6 EXPOSE](#26-expose)
- [2.7 VOLUME](#27-volume)
- [2.8 USER](#28-user)
- [2.9 LABEL](#29-label)
- [2.10 HEALTHCHECK](#210-healthcheck)
- [2.11 ENTRYPOINT vs CMD](#211-entrypoint-vs-cmd)
- [2.12 Full Simple Dockerfile (Python)](#212-full-simple-dockerfile-python)

**Part 3: Multi-Stage Dockerfile**
- [3.1 Why Multi-Stage Builds](#31-why-multi-stage-builds)
- [3.2 Full Multi-Stage Example (Python), Explained](#32-full-multi-stage-example-python-explained)

**Part 4: Docker Networking**
- [4.1 Network Drivers Overview](#41-network-drivers-overview)
- [4.2 bridge (default)](#42-bridge-default)
- [4.3 host](#43-host)
- [4.4 none](#44-none)
- [4.5 overlay](#45-overlay)
- [4.6 macvlan](#46-macvlan)
- [4.7 Creating and Using a Custom Network](#47-creating-and-using-a-custom-network)

**Part 5: Docker Volumes**
- [5.1 Why Volumes Exist](#51-why-volumes-exist)
- [5.2 Named Volumes](#52-named-volumes)
- [5.3 Bind Mounts](#53-bind-mounts)
- [5.4 tmpfs Mounts](#54-tmpfs-mounts)
- [5.5 Anonymous Volumes](#55-anonymous-volumes)
- [5.6 Volumes Comparison Table](#56-volumes-comparison-table)

**Part 6: Docker CLI Commands — Build, Run, Manage, Clean Up**
- [6.1 Building Images](#61-building-images)
- [6.2 Running and Inspecting Containers](#62-running-and-inspecting-containers)
- [6.3 Docker Layer Caching](#63-docker-layer-caching)
- [6.4 Stopping and Removing Containers and Images](#64-stopping-and-removing-containers-and-images)
- [6.5 Cleaning Up Build Cache and System Resources](#65-cleaning-up-build-cache-and-system-resources)

**Reference**
- [7. Interview Q&A Bank (Ansible + Docker)](#7-interview-qa-bank-ansible--docker)
- [8. Cheat Sheet](#8-cheat-sheet)

---

## Part 1: Ansible

## 1.1 What Is Ansible (Quick Context)

### In Plain English
Ansible is a checklist-runner for servers. You write down the steps you want done ("install nginx, copy this config, restart the service"), and Ansible goes to each server on your list and makes sure those steps are done — skipping steps that are already satisfied, so running the same checklist twice doesn't cause harm.

### Simple Definition
**Ansible** is an agentless configuration management and automation tool. It connects to target machines over SSH (no software needs to be pre-installed on them) and applies a desired state described in YAML files called **playbooks**.

### Why It Matters
Before tools like Ansible, server setup was either manual (slow, inconsistent) or required a heavyweight agent installed on every managed machine (more moving parts to maintain). Ansible needs only SSH access and Python on the target — nothing to install and keep updated on hundreds of servers.

### When to Use It
Server provisioning/configuration, application deployment steps, ensuring configuration drift doesn't creep in over time, and orchestrating multi-server rollouts in a defined order.

---

## 1.2 Sample Production-Style Playbook

```yaml
---
- name: Configure and deploy web application
  hosts: webservers
  become: true
  vars:
    app_port: 8080
    app_dir: /opt/myapp
    app_version: "{{ lookup('env', 'APP_VERSION') | default('1.0.0', true) }}"

  tasks:
    - name: Install required packages
      apt:
        name:
          - python3
          - python3-pip
          - nginx
        state: present
        update_cache: true

    - name: Create application directory
      file:
        path: "{{ app_dir }}"
        state: directory
        owner: www-data
        group: www-data
        mode: '0755'

    - name: Copy application code
      copy:
        src: ./app/
        dest: "{{ app_dir }}"
        owner: www-data
        group: www-data

    - name: Install Python dependencies
      pip:
        requirements: "{{ app_dir }}/requirements.txt"

    - name: Template environment file
      template:
        src: app.env.j2
        dest: "{{ app_dir }}/.env"
        owner: www-data
        mode: '0640'
      no_log: true

    - name: Configure Nginx site
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/sites-available/myapp
      notify: Restart nginx

    - name: Enable Nginx site
      file:
        src: /etc/nginx/sites-available/myapp
        dest: /etc/nginx/sites-enabled/myapp
        state: link
      notify: Restart nginx

    - name: Ensure app service is running
      systemd:
        name: myapp
        state: started
        enabled: true

    - name: Wait for application to respond
      uri:
        url: "http://localhost:{{ app_port }}/health"
        status_code: 200
      register: health_check
      retries: 5
      delay: 3
      until: health_check.status == 200

  handlers:
    - name: Restart nginx
      systemd:
        name: nginx
        state: restarted
```

---

## 1.3 Line-by-Line Explanation

- `hosts: webservers` — targets a group named `webservers` defined in your **inventory** file, not a single machine; the playbook runs against every host in that group.
- `become: true` — runs tasks with elevated privileges (like `sudo`), needed for package installs and system-level file changes.
- `vars:` — playbook-level variables, referenced later using `{{ }}` Jinja2 templating syntax.
- `lookup('env', 'APP_VERSION') | default('1.0.0', true)` — reads an environment variable from the control machine, falling back to a default if it's unset — a common pattern for injecting a CI-provided value (e.g., a build number) into a playbook run.
- `apt: ... state: present` — **idempotent**: running this task twice doesn't reinstall packages already present; Ansible checks current state first and only acts if a change is actually needed.
- `file: ... state: directory` — ensures the directory exists with the specified owner/group/permissions; also idempotent — if it already matches, nothing happens.
- `copy:` — copies files from the control machine (where Ansible runs) to the target host.
- `pip: requirements: ...` — installs Python packages listed in a `requirements.txt` on the target.
- `template:` — like `copy`, but processes the source file as a Jinja2 template first, substituting variables — used here for both the app's environment file and the Nginx config, since these need per-host or per-environment values injected.
- `no_log: true` — suppresses this task's output from logs, important here since the templated `.env` file likely contains secrets; without this, secret values could be printed in Ansible's verbose output.
- `notify: Restart nginx` — doesn't restart Nginx immediately; it queues the named **handler** to run once, at the end of the play, but only if this task actually changed something. If both the "Configure" and "Enable" tasks notify the same handler, Nginx still only restarts once.
- `systemd: ... state: started, enabled: true` — ensures the service is both currently running and will start on boot.
- `uri:` with `register`, `retries`, `delay`, `until` — a **post-deployment health check**: calls the app's health endpoint, retrying up to 5 times with a 3-second delay between attempts, until it gets a 200 status — this is the Ansible equivalent of a smoke test after deployment, catching a "deployed but not actually healthy" situation.
- `handlers:` — a separate section for actions that should run only in response to a change elsewhere in the play, not unconditionally as part of the normal task sequence.

---

## 1.4 Key Ansible Concepts

### Inventory
A file (INI or YAML) listing the hosts Ansible manages, organized into groups:
```ini
[webservers]
web1.example.com
web2.example.com

[dbservers]
db1.example.com

[webservers:vars]
ansible_user=deploy
```
`hosts: webservers` in a playbook targets every host under that `[webservers]` group. Groups can nest and share variables (`[webservers:vars]`).

### Modules
Reusable units of work Ansible ships with (`apt`, `copy`, `template`, `systemd`, `uri`, hundreds more) — each module knows how to check current state and only make changes when needed, which is what provides idempotency without you writing that logic yourself.

### Idempotency
Running the same playbook multiple times produces the same end state as running it once — no duplicate side effects. This is Ansible's core design promise, and it's what makes playbooks safe to re-run for drift correction or repeated deploys.

### Handlers
Tasks that only run when notified by another task that reported a change, and only run once even if notified multiple times, and only at the end of the play (by default) — ideal for "restart the service if its config changed" patterns.

### Roles
A standardized directory structure for organizing related tasks, variables, templates, and handlers into a reusable, shareable unit:
```
roles/
  nginx/
    tasks/main.yml
    handlers/main.yml
    templates/nginx.conf.j2
    vars/main.yml
    defaults/main.yml
```
A playbook then just says `roles: [nginx]` instead of inlining all those tasks — the Ansible equivalent of a Jenkins Shared Library or an Azure DevOps template: write once, reuse across many playbooks/projects.

### Variables & Precedence
Variables can come from many places (playbook `vars`, inventory, role defaults, command-line `-e`, facts gathered from the host). Ansible has a defined precedence order; command-line `-e` extra-vars win over almost everything else, and role `defaults/` are the easy-to-override baseline.

### Facts
Ansible automatically gathers information about each target host (OS, IP addresses, memory, etc.) at the start of a play (`gather_facts: true`, the default) — accessible as variables like `ansible_distribution`, useful for conditional logic ("only run this task on Ubuntu").

### Playbook vs Play vs Task vs Role
| Term | Meaning |
|---|---|
| **Playbook** | The whole YAML file — one or more plays. |
| **Play** | One mapping of hosts to a set of tasks/roles (a playbook can have several plays targeting different host groups). |
| **Task** | A single call to a module. |
| **Role** | A reusable, packaged bundle of tasks/handlers/templates/vars. |

### Common Mistakes
- Not using `become` where root access is actually needed, causing confusing permission-denied failures.
- Forgetting `no_log: true` on tasks handling secrets, leaking them into verbose logs.
- Writing shell/command tasks (`shell:`, `command:`) for things a dedicated idempotent module already does — losing idempotency and getting "changed" on every run even when nothing really changed.
- Not pinning module behavior (e.g., `state: present` vs `state: latest`) deliberately — `latest` on every run can cause unplanned upgrades.

### Best Practices
- Prefer dedicated modules (`apt`, `copy`, `template`, `systemd`) over raw `shell`/`command` wherever one exists — you get idempotency and clearer intent for free.
- Organize non-trivial playbooks into **roles** for reusability.
- Use `handlers` for restart/reload actions rather than putting them inline in every task that might need one.
- Mark tasks touching secrets with `no_log: true`.

---

## 1.5 Ansible Interview Q&A

**Q: What makes Ansible "agentless"?**
A: It connects to target hosts over standard SSH (or WinRM for Windows) and requires only Python on the target — no persistent agent software needs to be installed and maintained on every managed machine.

**Q: What is idempotency, and why does it matter?**
A: Running the same playbook repeatedly produces the same end result as running it once, with no duplicate side effects — this makes playbooks safe to re-run for drift correction, retries, or repeated deployments without manually tracking what's already been done.

**Q: What's the difference between a task and a handler?**
A: A task runs every time the play executes (Ansible decides internally whether a change is needed); a handler only runs if explicitly notified by a task that reported a change, runs once even if notified multiple times, and typically runs at the end of the play.

**Q: What's the difference between `copy` and `template`?**
A: `copy` transfers a file as-is; `template` processes the file through the Jinja2 templating engine first, substituting variables — used whenever the file's content needs to differ per host/environment.

**Q: How do you organize a large, reusable set of Ansible logic?**
A: Using roles — a standard directory structure (`tasks/`, `handlers/`, `templates/`, `vars/`, `defaults/`) that packages related automation into a reusable unit referenced from any playbook.

**Q: How would you avoid leaking a secret into Ansible's logs?**
A: Add `no_log: true` to the specific task handling the secret, which suppresses that task's output from being printed/logged.

**Q: How do you verify a deployment actually succeeded, not just that the playbook ran without error?**
A: Add a post-deployment check task (e.g., the `uri` module hitting a health endpoint) with `register`/`retries`/`until`, so the playbook itself confirms the application responds correctly before considering the run successful.

**What You Should Remember:** Ansible = agentless, SSH-based, idempotent automation via YAML playbooks. Modules provide the idempotency; handlers react to changes; roles provide reusability; inventory defines targets.

---

## Part 2: Dockerfile — Every Instruction Explained

## 2.1 FROM

### In Plain English
`FROM` picks the starting point — the base ingredients you're building on top of, instead of starting from a completely empty box.

### Simple Definition
`FROM` specifies the base image the rest of the Dockerfile builds on.

```dockerfile
FROM python:3.11-slim
```

### Why Used
Choosing a minimal, specific base (`-slim`, `-alpine`) keeps the final image small and reduces attack surface, versus a full OS image with lots of unused tooling. Pinning an exact version (`3.11-slim`, not `latest`) makes builds reproducible.

### Interview One-Liner
> "We always pin the base image tag — `latest` silently changes over time and can break builds or introduce untested behavior."

---

## 2.2 WORKDIR

### In Plain English
`WORKDIR` is like saying "cd into this folder, and stay there for everything that follows" — every subsequent instruction runs relative to it.

### Simple Definition
`WORKDIR` sets the working directory for any following `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, and `ADD` instructions, creating the directory if it doesn't exist.

```dockerfile
WORKDIR /app
```

### Why Used
Avoids messy, repeated absolute paths and avoids relying on whatever the base image's default directory happens to be.

### Interview One-Liner
> "`WORKDIR` beats `RUN cd /app` because `cd` in a `RUN` only affects that one layer — it doesn't persist to the next instruction. `WORKDIR` actually changes context for everything after it."

---

## 2.3 COPY vs ADD

### In Plain English
Both instructions bring files from your project into the image. `COPY` is the plain, predictable version — literally copy this to that. `ADD` does everything `COPY` does, plus a couple of "magic" extra behaviors (auto-extracting tar archives, fetching remote URLs) that most engineers consider surprising rather than helpful.

### Simple Definition
```dockerfile
COPY requirements.txt .
COPY . /app
```
```dockerfile
ADD archive.tar.gz /app/     # auto-extracts the tarball into /app
```

### Why Used
`COPY` is preferred by default because its behavior is simple and explicit. `ADD`'s auto-extraction and remote-URL-fetching behavior can cause unexpected results (e.g., accidentally extracting a file you meant to just copy as-is) — use `ADD` only when you specifically want that extraction behavior.

### Interview One-Liner
> "We use `COPY` almost everywhere and reserve `ADD` for the one case it's actually good at — auto-extracting a local tarball during the build."

---

## 2.4 RUN

### In Plain English
`RUN` executes a command *while building* the image, and whatever that command changes (installed packages, created files) becomes a permanent part of the image itself.

### Simple Definition
```dockerfile
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
```

### Why Used
Each `RUN` creates a new image layer. Chaining commands with `&&` into one `RUN` (rather than multiple separate `RUN` lines) keeps the layer count down and lets you clean up temporary files (like apt cache) *within the same layer* — cleaning up in a later, separate `RUN` doesn't shrink the image, since the earlier layer already committed those bytes.

### Interview One-Liner
> "We chain install-and-cleanup into a single `RUN` because Docker layers are append-only — deleting a file in a later layer doesn't reclaim the space from an earlier layer."

---

## 2.5 ENV vs ARG

### In Plain English
`ARG` is a value you can only use *during the build* — like a note passed to the builder that gets thrown away once the box is sealed. `ENV` is a value that's *baked into the final image* and available every time a container runs from it.

### Simple Definition
```dockerfile
ARG APP_VERSION=1.0.0          # build-time only, not present in the running container unless also set as ENV
ENV APP_ENV=production         # persists into the running container
ENV PORT=8080
```
You can combine them:
```dockerfile
ARG APP_VERSION
ENV APP_VERSION=${APP_VERSION}   # promotes a build-time ARG into a runtime ENV
```

### Why Used
- `ARG` is for build-time choices (which version to build, which base image variant) that don't need to persist into the running application.
- `ENV` is for runtime configuration your application actually reads (`os.environ` in Python), and it's visible via `docker inspect` and to anyone who runs the image.

### Interview One-Liner
> "Never put a real secret in `ARG` or `ENV` — both end up visible in the image's build history/metadata. Secrets belong in a runtime secret store or injected at container-start, not baked into the image."

---

## 2.6 EXPOSE

### In Plain English
`EXPOSE` is documentation, not a lock or a switch — it tells anyone reading the Dockerfile (and some tooling) "this container expects to listen on this port," but it doesn't actually open the port to the outside world by itself.

### Simple Definition
```dockerfile
EXPOSE 8080
```

### Why Used
It's metadata for humans and orchestration tools (e.g., some tools use it to auto-detect ports). Actually publishing the port to the host requires `-p 8080:8080` at `docker run` time, or a `ports:` mapping in Kubernetes/Compose — `EXPOSE` alone does nothing to network traffic.

### Interview One-Liner
> "`EXPOSE` is purely declarative — it doesn't open anything. If someone forgets `-p` at runtime, `EXPOSE` won't save them; the port simply isn't reachable from outside the container."

---

## 2.7 VOLUME

### In Plain English
`VOLUME` marks a directory inside the image as "this data shouldn't live and die with the container" — it tells Docker to keep this folder's contents outside the container's writable layer, in storage that survives even if the container is deleted.

### Simple Definition
```dockerfile
VOLUME /var/lib/mysql
```

### Why Used
Containers are meant to be disposable; anything written only inside a container's own filesystem is lost when the container is removed. Declaring `VOLUME` for directories holding real data (databases, uploads) signals that this path needs persistent storage — though in practice, most production setups explicitly mount a named volume or bind mount at `docker run`/Compose/Kubernetes level rather than relying solely on the Dockerfile's `VOLUME` instruction.

### Interview One-Liner
> "`VOLUME` in a Dockerfile is a hint about what data needs to persist; in production we typically still explicitly define the actual volume at deploy time so we control exactly where that data lives."

---

## 2.8 USER

### In Plain English
By default, a container runs as `root` unless told otherwise — which is like giving every guest in your house a master key. `USER` switches to a regular, less-privileged account for running the actual application.

### Simple Definition
```dockerfile
RUN adduser --disabled-password --gecos '' appuser
USER appuser
```

### Why Used
Running as `root` inside a container is a real security risk — if an attacker exploits the application, they get root inside the container, which increases the potential impact (especially if there's any container-escape vulnerability). Switching to a non-root user is a standard hardening practice.

### Interview One-Liner
> "We create and switch to a dedicated non-root user with `USER` — running as root in a container is unnecessary risk for almost any application workload."

---

## 2.9 LABEL

### In Plain English
`LABEL` is a sticky note attached to the image — metadata like who maintains it, what version it is, or which commit it was built from.

### Simple Definition
```dockerfile
LABEL maintainer="devops-team@example.com" \
      version="1.2.0" \
      description="Asset pulling backend service"
```

### Why Used
Useful for organizing/auditing images (e.g., querying `docker inspect` for all images by a maintainer, or tracking which commit produced which image), and some tools/registries surface labels in their UI.

### Interview One-Liner
> "We label images with the git commit SHA and build number so any running container's exact origin is traceable via `docker inspect`."

---

## 2.10 HEALTHCHECK

### In Plain English
`HEALTHCHECK` teaches Docker how to ask the container "are you actually okay?" instead of just assuming a container is healthy because its process hasn't crashed.

### Simple Definition
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1
```

### Line-by-Line
- `--interval=30s` — how often to run the check.
- `--timeout=3s` — how long to wait for the check command before considering it failed.
- `--start-period=10s` — a grace period after container start before failures count (avoids false negatives while the app is still booting).
- `--retries=3` — how many consecutive failures before marking the container `unhealthy`.
- `CMD curl -f ... || exit 1` — the actual check command; a non-zero exit means unhealthy.

### Why Used
A process can be "running" but completely unresponsive (deadlocked, out of connections). `HEALTHCHECK` lets Docker (and orchestrators built on top of it) detect this and act — e.g., an orchestrator can restart or stop routing traffic to an unhealthy container.

### Interview One-Liner
> "A container can be alive but broken — `HEALTHCHECK` is how we let Docker/Kubernetes tell the difference between 'the process exists' and 'the application actually works.'"

---

## 2.11 ENTRYPOINT vs CMD

### In Plain English
`ENTRYPOINT` is the fixed command the container always runs — the container's whole reason for existing. `CMD` supplies default arguments to that command, which anyone running the container can easily override.

### Simple Definition
```dockerfile
ENTRYPOINT ["python", "app.py"]
CMD ["--port", "8080"]
```
Running `docker run myimage` executes `python app.py --port 8080`.
Running `docker run myimage --port 9090` overrides just the `CMD` part, executing `python app.py --port 9090`.

### Why Used
- **`ENTRYPOINT` alone**: the container always runs this exact program — good when the image does exactly one job.
- **`CMD` alone** (no `ENTRYPOINT`): the whole command is easily replaced at runtime (`docker run myimage bash` runs `bash` instead).
- **Both together**: `ENTRYPOINT` fixes the program, `CMD` supplies overridable default arguments — a common, flexible production pattern.

### Interview One-Liner
> "We use `ENTRYPOINT` for the program itself so it can't accidentally be swapped out, and `CMD` for default flags so someone can still override just the arguments at `docker run` time without touching the Dockerfile."

---

## 2.12 Full Simple Dockerfile (Python)

```dockerfile
FROM python:3.11-slim

WORKDIR /app

RUN adduser --disabled-password --gecos '' appuser

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV APP_ENV=production
ENV PORT=8080

EXPOSE 8080

USER appuser

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

ENTRYPOINT ["python", "app.py"]
CMD ["--port", "8080"]
```

### Why This Order Matters
`requirements.txt` is copied and installed **before** the rest of the application code. Docker caches each layer; if only application code changes (not dependencies), Docker reuses the cached dependency-install layer instead of reinstalling everything — a significant build-speed optimization. Copying everything (`COPY . .`) too early would invalidate that cache on every single code change.

### Interview One-Liner
> "Copying `requirements.txt` and installing dependencies before copying the rest of the code is a deliberate cache-optimization — code changes constantly, dependencies don't, so we let Docker's layer cache skip the expensive reinstall step on every build."

---

## Part 3: Multi-Stage Dockerfile

## 3.1 Why Multi-Stage Builds

### In Plain English
A single-stage build is like shipping the entire messy kitchen — flour dust, mixing bowls, recipe notes, and all — to the customer along with the finished cake. A multi-stage build cooks in one kitchen (with all the mess) but only ships the finished cake, leaving the mess behind.

### Simple Definition
A **multi-stage build** uses multiple `FROM` instructions in one Dockerfile; each stage can use a different base image, and later stages selectively copy only what they need from earlier stages — everything else (compilers, build caches, dev dependencies) is left behind, never entering the final image.

### Why Used in Production
- **Smaller final images** — no build toolchain, dev dependencies, or intermediate files ship to production.
- **Smaller attack surface** — fewer packages/tools in the final image means fewer potential vulnerabilities.
- **Still simple to build** — you don't need a separate build script or CI step to strip things out; it's expressed in one Dockerfile.

---

## 3.2 Full Multi-Stage Example (Python), Explained

```dockerfile
# ---------- Stage 1: builder ----------
FROM python:3.11 AS builder

WORKDIR /build

COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

COPY . .
RUN python -m compileall .

# ---------- Stage 2: final runtime image ----------
FROM python:3.11-slim

WORKDIR /app

RUN adduser --disabled-password --gecos '' appuser

# Copy only the installed Python packages and app code from the builder stage
COPY --from=builder /root/.local /home/appuser/.local
COPY --from=builder /build /app

ENV PATH=/home/appuser/.local/bin:$PATH
ENV APP_ENV=production
ENV PORT=8080

EXPOSE 8080

USER appuser

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

ENTRYPOINT ["python", "app.py"]
CMD ["--port", "8080"]
```

### Line-by-Line
- `FROM python:3.11 AS builder` — the **first stage**, named `builder`; uses the full (non-slim) Python image since it may need build tools for compiling certain Python packages with native extensions.
- `pip install --user -r requirements.txt` — installs dependencies into the user's local site-packages directory (`/root/.local`), making them easy to selectively copy later.
- `RUN python -m compileall .` — precompiles Python bytecode as part of the build (an example of build-time work that doesn't need to happen again at runtime).
- `FROM python:3.11-slim` — the **second, final stage**; a fresh, minimal image with no relation to the builder stage's installed packages or build tools.
- `COPY --from=builder /root/.local /home/appuser/.local` — copies **only the installed dependencies** from the builder stage into the final image — none of the build tools, caches, or intermediate files that were also present in that stage come along.
- `COPY --from=builder /build /app` — copies only the application code (already compiled) from the builder stage.
- `ENV PATH=/home/appuser/.local/bin:$PATH` — ensures any installed console scripts from the copied packages are runnable.
- Everything else (`USER`, `HEALTHCHECK`, `ENTRYPOINT`, `CMD`) works exactly as in the single-stage example — multi-stage only changes *how the filesystem is assembled*, not how the container runs.

### Why This Specific Design
The **builder** stage is allowed to be "messy" — full Python image, full pip cache, any extra build dependencies needed for packages with native extensions. None of that mess is present in the final image; only the two `COPY --from=builder` lines selectively pull across exactly what's needed to actually run the app.

### Interview One-Liner
> "Multi-stage builds let us use a heavier, fully-equipped image to compile/build, then discard everything except the compiled output in the final image — smaller image, smaller attack surface, same single Dockerfile."

### Common Mistakes
- Copying the entire builder stage (`COPY --from=builder / /`) instead of only the specific paths needed — defeats the purpose entirely.
- Forgetting to name the build stage (`AS builder`), making later `--from=` references harder to read (they'd have to use a numeric index like `--from=0`).
- Using the same heavy base image for both stages when a slim variant would work fine for the final stage.

---

## Part 4: Docker Networking

## 4.1 Network Drivers Overview

### In Plain English
A network driver decides *how* containers can talk to each other and to the outside world — like choosing whether apartments in a building share a common hallway, are each wired directly to the street, are completely soundproofed and isolated, or are spread across multiple buildings but still on one shared phone line.

### Simple Definition
Docker's **network drivers** determine the networking behavior when you create a Docker network. Each driver suits a different use case.

| Driver | Use Case |
|---|---|
| **bridge** | Default; containers on one Docker host, isolated from the host network but can reach each other. |
| **host** | Container shares the host's network stack directly — no isolation, no port mapping needed. |
| **none** | No networking at all — fully isolated container. |
| **overlay** | Multi-host networking — containers on different Docker hosts (e.g., Swarm) communicate as if on one network. |
| **macvlan** | Assigns a container its own MAC address, making it appear as a physical device on the network. |

---

## 4.2 bridge (default)

### In Plain English
Bridge networking is like an apartment building's shared internal hallway — every unit (container) can walk to any other unit's door directly, but to reach the outside world, mail has to go through the building's front desk (NAT), and outsiders can't just walk into a unit unless the front desk explicitly lets them (port publishing).

### Simple Definition
The **bridge** driver creates a private internal network on the Docker host. Containers on the same bridge network can communicate with each other by container name; reaching the internet or the host requires Docker's built-in NAT, and reaching a container *from* the host/outside requires explicitly publishing a port.

### Example
```bash
docker network create my-bridge-net
docker run -d --name api --network my-bridge-net myapi:latest
docker run -d --name db --network my-bridge-net --network-alias db postgres:16
```
Inside the `api` container, connecting to `db:5432` just works — Docker's embedded DNS resolves the container name to its internal IP, no manual IP tracking needed.

### Why Used
This is Docker's default for a reason — good isolation between unrelated containers/projects, easy container-to-container communication by name within the same custom network, and explicit control over what's actually exposed to the outside via `-p`.

### Interview One-Liner
> "A custom bridge network gives us built-in DNS-based service discovery by container name — that's why `api` can just connect to `db` by name instead of hardcoding an IP address."

---

## 4.3 host

### In Plain English
Host networking removes the walls entirely — the container doesn't get its own private hallway; it's directly wired into the same network the host machine itself uses. There's no address translation and no port-mapping step, but also no isolation.

### Simple Definition
With the **host** driver, a container shares the host machine's network namespace directly — no NAT, no isolated IP, no port mapping needed (a service listening on port 8080 in the container is simply on port 8080 on the host).

### Example
```bash
docker run -d --network host myapp:latest
```

### Why Used
Slightly better network performance (no NAT overhead) and simpler port handling for specific cases — but you lose network isolation entirely, and if two containers both try to bind the same port, they conflict directly on the host. Generally used sparingly, for specific performance-sensitive or network-tooling use cases (not the default for typical application containers).

### Interview One-Liner
> "Host networking trades away isolation for a small performance/simplicity gain — we reserve it for specific cases like network monitoring tools, not general application containers."

---

## 4.4 none

### In Plain English
`none` is a container in a soundproofed room with no phone line at all — it can't talk to anything over the network, by design.

### Simple Definition
The **none** driver gives a container no network interfaces beyond loopback — complete network isolation.

### Example
```bash
docker run --network none my-batch-job:latest
```

### Why Used
For workloads that genuinely need zero network access — a pure CPU-bound batch/compute job processing local files, or a security-sensitive sandboxed task where any network access at all would be an unwanted risk.

### Interview One-Liner
> "We'd use `none` for a task that has no legitimate reason to make any network call — it's the strongest network-isolation guarantee Docker offers."

---

## 4.5 overlay

### In Plain English
Overlay networking is like a shared company phone line that works no matter which office building (Docker host) an employee is physically sitting in — extensions dial each other the same way, regardless of physical location.

### Simple Definition
The **overlay** driver creates a virtual network spanning **multiple Docker hosts** (used in Docker Swarm, and conceptually similar to what Kubernetes' CNI plugins provide), letting containers on different physical machines communicate as if they were on the same local network.

### Example
```bash
docker network create -d overlay --attachable my-overlay-net
docker service create --name api --network my-overlay-net myapi:latest
```

### Why Used
Needed the moment you scale beyond a single Docker host — without it, containers on different machines would have no built-in way to discover and reach each other by name.

### Interview One-Liner
> "Overlay networks are what make multi-host container communication possible without manually wiring up cross-host routing — Swarm (and conceptually, Kubernetes networking) relies on this same idea."

---

## 4.6 macvlan

### In Plain English
Macvlan gives a container its own "ID card" on the physical network — instead of hiding behind the host's one IP address (like bridge does), the container gets to look like an entirely separate physical device with its own MAC and IP address, directly on the same network as everything else.

### Simple Definition
The **macvlan** driver assigns each container a unique MAC address and IP address on the physical network, making it appear as a distinct physical device rather than a NAT'd process behind the host.

### Example
```bash
docker network create -d macvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  -o parent=eth0 \
  my-macvlan-net

docker run -d --network my-macvlan-net --ip 192.168.1.50 legacy-app:latest
```

### Why Used
Useful for legacy applications that expect to be directly addressable on the physical LAN (e.g., an app that must present its own IP for licensing, monitoring, or network-appliance reasons), bypassing Docker's usual NAT layer entirely.

### Interview One-Liner
> "Macvlan is the escape hatch for legacy or network-appliance-style workloads that genuinely need their own real IP/MAC on the physical network, rather than living behind the host's NAT like a normal bridge-networked container."

---

## 4.7 Creating and Using a Custom Network

```bash
# Create a custom bridge network (recommended over the default 'bridge' network)
docker network create --driver bridge app-network

# Run containers attached to it
docker run -d --name backend --network app-network mybackend:latest
docker run -d --name frontend --network app-network myfrontend:latest

# Inspect the network
docker network inspect app-network

# List all networks
docker network ls
```

### Why a Custom Network Instead of Docker's Default `bridge`?
Docker's automatically-created default `bridge` network does **not** provide DNS-based container-name resolution — containers on it can only reach each other by IP, which is fragile since IPs can change. Any **user-created** bridge network *does* provide automatic DNS resolution by container name. This is why production Compose files and manual setups almost always create a named custom network rather than relying on Docker's original default one.

### Interview One-Liner
> "We always create a named custom bridge network rather than relying on Docker's original default `bridge` network, specifically to get built-in DNS resolution by container name."

---

## Part 5: Docker Volumes

## 5.1 Why Volumes Exist

### In Plain English
Containers are meant to be disposable — like a hotel room you check out of, expecting housekeeping to reset everything for the next guest. But some things (a database's actual data, uploaded files) shouldn't disappear just because the "room" gets reset. Volumes are the hotel's safety deposit box — separate from the room itself, surviving no matter what happens to the room.

### Simple Definition
A **volume** (in the broad sense) is any mechanism for persisting or sharing data outside a container's own writable layer, so that data survives container removal/recreation, or can be shared between containers/host.

### The Core Problem Volumes Solve
Without any persistence mechanism, a container's filesystem changes vanish the moment the container is removed (`docker rm`). For stateful workloads (databases, file uploads, logs you want to inspect from the host), that's unacceptable — volumes decouple data lifetime from container lifetime.

---

## 5.2 Named Volumes

### In Plain English
A named volume is a storage box that Docker manages for you, given a name you choose, living independently in Docker's own storage area — you don't need to know or care exactly where on disk it physically lives.

### Simple Definition
```bash
docker volume create db-data
docker run -d --name postgres -v db-data:/var/lib/postgresql/data postgres:16
```
Or in Compose:
```yaml
services:
  db:
    image: postgres:16
    volumes:
      - db-data:/var/lib/postgresql/data
volumes:
  db-data:
```

### Why Used
Fully managed by Docker (creation, location, cleanup via `docker volume prune`), portable across container recreations, and the recommended default for most persistent data (databases, application state) because Docker handles the underlying details safely.

### Interview One-Liner
> "Named volumes are our default for database storage — recreating the `postgres` container (say, for an image upgrade) doesn't touch the actual data, since it lives in the named volume, not the container's own filesystem."

---

## 5.3 Bind Mounts

### In Plain English
A bind mount is like pointing directly at a specific folder on your own computer's desk and saying "the container should read/write exactly here" — no Docker-managed abstraction in between, just a direct link to a real path you chose.

### Simple Definition
```bash
docker run -d -v /home/user/app-config:/app/config myapp:latest
```
Or in Compose:
```yaml
services:
  app:
    image: myapp:latest
    volumes:
      - ./config:/app/config
```

### Why Used
Ideal for local development — edit code/config on the host with your normal editor, and see changes reflected instantly inside the running container without rebuilding the image. Also used for mounting specific host paths into a container (like the Docker socket, `/var/run/docker.sock`, for Docker-in-Docker style tooling).

### Interview One-Liner
> "In local dev we bind-mount the source code directory so edits show up instantly in the running container — in production, we generally prefer named volumes or object storage over bind mounts, since bind mounts couple you to a specific host's filesystem layout."

---

## 5.4 tmpfs Mounts

### In Plain English
A `tmpfs` mount is a storage area that lives entirely in memory (RAM), not on disk — like a whiteboard that gets wiped clean the instant the container stops, because it was never actually written to a hard drive in the first place.

### Simple Definition
```bash
docker run -d --tmpfs /app/cache:size=100m myapp:latest
```

### Why Used
For temporary, sensitive, or performance-critical data that shouldn't persist at all and benefits from RAM-speed access — e.g., a cache that's fine to lose on restart, or temporary files containing sensitive data that you specifically don't want ever written to disk.

### Interview One-Liner
> "We use `tmpfs` for data that should never persist to disk at all — either for speed, or because we specifically don't want sensitive temporary files to ever touch the host's actual storage."

---

## 5.5 Anonymous Volumes

### In Plain English
An anonymous volume is like a storage box Docker creates for you on the spot without asking you to name it — it works, but since nothing refers to it by a memorable name, it's easy to lose track of and forget to clean up.

### Simple Definition
```dockerfile
VOLUME /var/lib/mysql
```
```bash
docker run -d myimage    # Docker auto-creates an anonymous volume for /var/lib/mysql, with a random generated ID
```

### Why Used (and Why to Be Careful)
Created automatically whenever a container starts from an image with a `VOLUME` instruction (or an unnamed `-v /path` without a source), without you explicitly naming or tracking it. Because it has no memorable name, it's easy to accumulate many orphaned anonymous volumes over time (`docker volume prune` cleans these up, but only if you remember to run it) — generally, named volumes are preferred in practice specifically to avoid this accumulation problem.

### Interview One-Liner
> "Anonymous volumes are what you get if you don't name one explicitly — they work, but they're easy to lose track of, which is exactly why we prefer explicitly named volumes in any setup we actually maintain."

---

## 5.6 Volumes Comparison Table

| Type | Managed By | Survives Container Removal | Typical Use Case | Visible on Host Filesystem? |
|---|---|---|---|---|
| **Named volume** | Docker | Yes | Databases, persistent app state | Yes, but in Docker's own managed storage area, not a path you pick |
| **Bind mount** | You (the host filesystem) | Yes (it's just a host path) | Local dev, config injection, exposing specific host resources | Yes, at the exact host path you specify |
| **tmpfs mount** | Docker (in-memory) | No — gone when container stops | Sensitive temp data, high-speed cache | No — never written to disk at all |
| **Anonymous volume** | Docker (auto-created, unnamed) | Yes, but easy to lose track of | Default persistence from a Dockerfile's `VOLUME` instruction | Yes, in Docker's storage area, under a random ID |

### Interview One-Liner (Summary)
> "Named volumes for anything we want Docker to manage long-term, bind mounts when we need a specific host path (mainly local dev), tmpfs for anything sensitive or ephemeral that should never touch disk, and we actively avoid relying on anonymous volumes because they're hard to track and clean up."

---

## Part 6: Docker CLI Commands — Build, Run, Manage, Clean Up

> These are the day-to-day operational commands around a Dockerfile — building the image, running/inspecting the container, and cleaning up afterward. Together with Parts 2–3 (Dockerfile instructions) this covers the full "write it, build it, run it, verify it, clean it up" lifecycle interviewers commonly ask about.

## 6.1 Building Images

### `docker build -t <name>:<tag> .`
```bash
docker build -t retail-ui:9.0.0 .
```
**In Plain English:** This is "assemble the box according to the instructions in the Dockerfile sitting in this folder, and put a label on it so I can find it later."

**What Each Part Does:**
- `docker build` — reads a Dockerfile and executes its instructions to produce an image.
- `-t retail-ui:9.0.0` — tags (names + versions) the resulting image; without a tag it still builds, just with an unmemorable auto-generated ID.
- `.` — the **build context**: the directory whose contents Docker can reference in `COPY`/`ADD` instructions. Docker uploads this entire directory to the build process first, which is exactly why a `.dockerignore` matters (see below) — a huge or irrelevant build context slows every build down before a single instruction even runs.

**Why Used:** This is the fundamental command that turns a Dockerfile into a runnable image. Tagging with a meaningful version (not just `latest`) makes images traceable and rollback-able.

### `docker build --no-cache -t <name>:<tag> .`
```bash
docker build --no-cache -t retail-ui:10.0.0 .
```
**In Plain English:** "Ignore everything you remember from last time — rebuild every single step from absolute zero."

**Why Used:** Normally Docker reuses cached layers for speed (see 6.3). `--no-cache` forces a completely fresh rebuild — useful when you suspect a cached layer is stale or wrong (e.g., a `RUN apt-get install` layer cached an old package mirror state), or when validating that a build genuinely works from scratch before shipping it, without any leftover cache masking a real problem.

**Interview One-Liner:** *"We use `--no-cache` sparingly — mainly to validate a truly clean build before a release, or to troubleshoot a suspicious cached layer — since it trades away all the speed benefits of layer caching."*

---

## 6.2 Running and Inspecting Containers

### `docker run -d --name <container> -p <host-port>:<container-port> <image>`
```bash
docker run -d --name retail-ui -p 8080:8080 retail-ui:9.0.0
```
**In Plain English:** "Start a container from this image, run it in the background, give it a friendly name, and connect port 8080 on my machine to port 8080 inside the container."

**What Each Flag Does:**
- `-d` (detached) — runs the container in the background, returning control of your terminal immediately, instead of blocking your shell with the container's live output.
- `--name retail-ui` — gives the container a human-readable name, so later commands (`docker exec -it retail-ui`, `docker stop retail-ui`) don't require you to look up an auto-generated container ID.
- `-p 8080:8080` — publishes the container's port to the host (`host:container`); this is the actual action that makes a port reachable from outside, unlike the Dockerfile's `EXPOSE` which is only documentation (see Part 2.6).

**Why Used:** This is the standard way to start a long-running service container in the background with a memorable name and an actually-reachable port.

### `docker ps`
```bash
docker ps
```
**In Plain English:** "Show me what's currently running."

**Why Used:** The first command to check when you want to confirm a container actually started, see its status, uptime, and which ports are mapped. Add `-a` (`docker ps -a`) to also see stopped/exited containers — useful when a container crashed immediately after starting and no longer shows in the default list.

### `docker exec -it <container> sh`
```bash
docker exec -it retail-ui sh
```
**In Plain English:** "Open a live terminal session inside this already-running container, so I can look around."

**What Each Flag Does:**
- `-i` (interactive) — keeps input open so you can type commands.
- `-t` (tty) — allocates a pseudo-terminal, making the session behave like a normal interactive shell (proper prompts, line editing) rather than raw piped output.
- `sh` — the command to run inside the container; `sh` is used here instead of `bash` because minimal base images (like the runtime stage of a multi-stage build) often don't include `bash` at all.

**Why Used:** This is how you verify what's actually inside a running container — checking that build tools were correctly excluded from the final image, inspecting config files, or debugging a live issue. For example, checking `which mvn` returns "not found" and `ls /src` returns "no such directory" is direct proof that a multi-stage build successfully kept the heavy build tooling and source code out of the final runtime image.

**Interview One-Liner:** *"After a multi-stage build, `docker exec -it <container> sh` followed by checking for the absence of build tools is how we actually verify — not just assume — that the final image is clean."*

---

## 6.3 Docker Layer Caching

### The Concept
Every instruction in a Dockerfile (`RUN`, `COPY`, `ENV`, etc.) produces one image **layer**. When you rebuild, Docker checks each instruction: if nothing relevant has changed since the last build (the instruction itself and any files it references are identical), Docker reuses the previously-built layer instead of re-executing it — shown in build output as a `CACHED` step instead of a freshly-timed one.

### Why It Matters
| Benefit | In Plain English |
|---|---|
| Faster builds | Skipping unchanged steps means only genuinely new work takes time. |
| Faster feedback loop | Changing only application code re-triggers just the "copy code + package" steps, not a full dependency reinstall. |
| Smaller registry pushes | Only new/changed layers need to be uploaded when pushing an updated image. |
| Encourages good structure | To benefit from caching, you naturally learn to order a Dockerfile from least-often-changing to most-often-changing instructions. |

### The Practical Implication for How You Write a Dockerfile
This is *why* dependency files get copied and installed **before** application source code (as shown in Part 2.12 and Part 3.2): dependency manifests (`pom.xml`, `requirements.txt`, `package.json`) change rarely, while source code changes constantly. Structuring the Dockerfile in that order means a pure code change reuses the cached, already-completed dependency-installation layer — often the single most time-consuming step in the whole build — instead of repeating it on every single build.

**Interview One-Liner:** *"Layer caching is the real reason Dockerfile instruction order matters — it's not just style, it directly controls how much of the build gets skipped on the next run."*

---

## 6.4 Stopping and Removing Containers and Images

### `docker stop <container>`
```bash
docker stop retail-ui
```
**In Plain English:** "Ask this running container to shut down gracefully."
**Why Used:** Sends a termination signal and gives the container a grace period to shut down cleanly (e.g., finish in-flight requests) before force-killing it if it doesn't stop in time.

### `docker rm <container>`
```bash
docker rm retail-ui
```
**In Plain English:** "Delete this container." (It must already be stopped, or you'd need `docker rm -f` to force it.)
**Why Used:** A stopped container still exists on disk (its writable layer, logs, exit status) until removed. `docker rm` actually deletes that container instance — separate from deleting the *image* it was created from.

### `docker rmi <image>:<tag>`
```bash
docker rmi retail-ui:9.0.0
```
**In Plain English:** "Delete this image itself" — the packaged template, not just one running instance of it.
**Why Used:** Frees disk space taken by an image you no longer need; will fail if a container (even a stopped one) still references that image, which is a useful safety check preventing you from deleting an image something still depends on.

**Interview One-Liner:** *"Stopping, removing the container, and removing the image are three separate, deliberate steps — Docker doesn't quietly delete an image just because you stopped using it, which prevents accidental data/image loss."*

---

## 6.5 Cleaning Up Build Cache and System Resources

### `docker builder prune`
```bash
docker builder prune
docker builder prune -f          # skip the confirmation prompt
docker builder prune --all       # also remove cache from untagged/unused builds, not just dangling ones
docker builder prune --all -f
```
**In Plain English:** "Clear out old, unused leftovers from previous builds that are just taking up disk space now."
**Why Used:** Layer caching (6.3) is great for speed, but over weeks/months of iterative builds, the cache itself accumulates and can consume significant disk space. `builder prune` reclaims that space; `--all` is more aggressive, also clearing cache tied to images that aren't currently tagged/in-use.

### `docker system prune`
```bash
docker system prune                       # removes stopped containers, unused networks, dangling images, build cache
docker system prune --volumes             # also removes unused volumes
docker system prune -a --volumes -f       # the "disaster option": removes ALL unused images (not just dangling ones), all unused volumes, no confirmation prompt
```
**In Plain English:** "Do a full spring clean of everything on this machine that Docker created but nothing is currently using."

**What Each Flag Does:**
- (no flags) — removes stopped containers, networks not used by any container, dangling images (untagged, orphaned layers), and build cache.
- `-a` / `--all` — also removes images that aren't referenced by *any* container, not just dangling ones — meaning even a perfectly good, tagged image gets deleted if nothing is currently running from it.
- `--volumes` — additionally removes volumes not currently used by any container — **this can permanently delete real data** (database contents, uploaded files) if that data was only ever stored in a now-unused volume.
- `-f` — skips the interactive confirmation prompt.

**Why This Is Called the "Disaster Option"**
`docker system prune -a --volumes -f` is the most aggressive cleanup Docker offers, combining "delete every unused image, even tagged ones" with "delete every unused volume, even ones holding real data" and "don't ask me first." It's genuinely useful for reclaiming a development machine's disk space, but running it against a host with anything important that isn't currently actively running is how people accidentally lose data — hence treating it with real caution, not routine habit.

**Interview One-Liner:** *"We're careful with `system prune -a --volumes -f` specifically because of the `--volumes` flag — an unused volume might just be old test data, or it might be the only copy of something real; the command has no way to tell the difference, so we check `docker volume ls` first rather than habitually reaching for the 'nuke everything' flags."*

### Quick Decision Guide
| Goal | Command |
|---|---|
| Just reclaim build-cache disk space | `docker builder prune` |
| Also clean stopped containers/networks/dangling images | `docker system prune` |
| Also remove unused (even tagged) images | `docker system prune -a` |
| Also remove unused volumes (⚠️ can delete real data) | add `--volumes` |
| Skip confirmation prompts | add `-f` |

---

## 7. Interview Q&A Bank (Ansible + Docker)

### Ansible
**Q: How does Ansible connect to target machines?**
A: Over SSH (or WinRM for Windows targets) — no persistent agent is required on the managed host, only Python.

**Q: What ensures a playbook is safe to run repeatedly?**
A: Idempotency — Ansible modules check the current state before acting, so re-running a playbook doesn't repeat side effects unnecessarily.

**Q: When would you write a custom `shell`/`command` task instead of using a dedicated module?**
A: Only when no dedicated module exists for the needed operation — dedicated modules provide idempotency and clearer intent that raw shell commands don't.

**Q: How do roles improve playbook maintainability?**
A: They package related tasks, handlers, templates, and variables into a standard, reusable directory structure that can be shared across multiple playbooks/projects, similar to a Jenkins Shared Library.

### Docker — Dockerfile
**Q: Why avoid `latest` as a base image tag in production?**
A: `latest` can silently point to a different image over time, breaking build reproducibility; pinning an explicit version tag ensures every build starts from the same known base.

**Q: What's the security risk of not specifying a `USER` in a Dockerfile?**
A: The container runs as `root` by default, which increases the potential impact of any application-level compromise, especially if combined with a container-escape vulnerability.

**Q: Why does instruction order matter in a Dockerfile?**
A: Docker caches each layer; placing rarely-changing instructions (like dependency installation) before frequently-changing ones (like copying source code) lets Docker reuse cached layers and avoid unnecessary rebuild work.

**Q: What's the difference between `ENTRYPOINT` and `CMD`?**
A: `ENTRYPOINT` defines the fixed command a container always runs; `CMD` supplies default arguments to it that can be easily overridden at `docker run` time. Used together, you get a fixed program with overridable default flags.

**Q: Why doesn't `EXPOSE` actually open a port to the outside world?**
A: `EXPOSE` is purely documentation/metadata; actual port publishing requires `-p` at `docker run` time (or an equivalent mapping in Compose/Kubernetes).

### Docker — Multi-Stage Builds
**Q: What problem do multi-stage builds solve?**
A: They let you use a full-featured image to compile/build an application, then copy only the necessary compiled output into a minimal final image — avoiding shipping build tools, caches, or dev dependencies to production.

**Q: How do you copy files from an earlier build stage?**
A: Using `COPY --from=<stage-name-or-index> <src> <dest>`, referencing a named stage (`FROM ... AS buildername`) or its numeric index.

### Docker — Networking
**Q: What's the difference between Docker's default `bridge` network and a custom bridge network?**
A: The default `bridge` network doesn't provide DNS-based container-name resolution (only IP-based reachability); any user-created bridge network does, which is why custom networks are preferred in practice.

**Q: When would you use `host` networking instead of `bridge`?**
A: When you need to avoid NAT overhead or need direct host-port binding for a specific performance-sensitive or network-tooling use case — accepting the loss of network isolation that comes with it.

**Q: What is an overlay network used for?**
A: Enabling containers on different physical Docker hosts (e.g., in a Swarm cluster) to communicate as if they were on the same local network.

**Q: When would macvlan be the right choice?**
A: When a container (often a legacy application) needs to appear as its own distinct device on the physical network, with its own real MAC/IP address, rather than being hidden behind the host's NAT.

### Docker — Volumes
**Q: What's the difference between a named volume and a bind mount?**
A: A named volume is fully managed by Docker in its own storage area; a bind mount points directly at a specific path on the host filesystem that you choose and control yourself.

**Q: Why prefer named volumes over bind mounts for production database storage?**
A: Named volumes are portable and managed consistently by Docker regardless of the underlying host's filesystem layout, whereas bind mounts couple your setup to a specific host path.

**Q: When would you use a `tmpfs` mount?**
A: For data that should never be written to disk — either for performance (RAM-speed access) or to avoid persisting sensitive temporary data at all.

**Q: What's the downside of relying on anonymous volumes?**
A: Since they have no memorable name, they're easy to lose track of and accumulate as orphaned storage over time unless you deliberately run cleanup commands like `docker volume prune`.

### Docker — CLI Commands
**Q: What does the `.` at the end of `docker build -t myapp:1.0 .` actually mean?**
A: It's the build context — the directory Docker uploads and makes available to `COPY`/`ADD` instructions. It's not optional decoration; without a valid context path, `docker build` has nothing to build from.

**Q: Why would you run `docker build --no-cache`?**
A: To force every layer to rebuild from scratch, bypassing potentially stale cached layers — useful when validating a truly clean build before release or troubleshooting a suspicious cached step, at the cost of losing caching's speed benefit for that run.

**Q: What's the difference between `docker stop`, `docker rm`, and `docker rmi`?**
A: `docker stop` gracefully halts a running container (it still exists afterward); `docker rm` deletes that stopped container instance; `docker rmi` deletes the underlying image itself, and will refuse to do so while any container (even a stopped one) still references it.

**Q: How would you verify that a multi-stage build actually excluded your build tools from the final image?**
A: Run the container, then `docker exec -it <container> sh` into it and check directly — e.g., confirm `which mvn` returns "not found" and the source directory doesn't exist — rather than just assuming the multi-stage build worked.

**Q: What's the risk of running `docker system prune -a --volumes -f` casually?**
A: The `--volumes` flag removes any volume not currently attached to a running container — which can permanently delete real data (like database contents) if that data only exists in a volume that happens to be unused at that moment; it's worth checking `docker volume ls` first rather than treating this as a routine cleanup habit.

---

## 8. Cheat Sheet

### Ansible Quick Reference
```yaml
- name: Play name
  hosts: group_name
  become: true
  vars: { key: value }
  tasks:
    - name: Task description
      module_name:
        param: value
      notify: Handler name
      register: result_var
      when: condition
  handlers:
    - name: Handler name
      module_name:
        param: value
```
```bash
ansible-playbook -i inventory.ini playbook.yml       # run a playbook
ansible-playbook playbook.yml --check                # dry run
ansible-playbook playbook.yml -e "var=value"          # pass extra vars
ansible all -m ping -i inventory.ini                  # connectivity test
```

### Dockerfile Instruction Quick Reference
```dockerfile
FROM image:tag              # base image (pin the tag)
WORKDIR /app                 # set working directory
COPY src dest                 # copy files in (predictable)
ADD src dest                   # copy + auto-extract archives / fetch URLs (use sparingly)
RUN command                     # execute at build time (chain with && to reduce layers)
ARG NAME=default                 # build-time-only variable
ENV NAME=value                    # runtime variable (persists in image/container)
EXPOSE port                        # documentation only — doesn't publish the port
VOLUME /path                        # marks a path for persistent/external storage
USER username                        # drop root privileges
LABEL key=value                       # metadata
HEALTHCHECK CMD command                # define container health check
ENTRYPOINT ["executable"]               # fixed command
CMD ["default", "args"]                  # overridable default arguments
```

### Multi-Stage Build Pattern
```dockerfile
FROM base AS builder
# ... build steps ...

FROM slim-base
COPY --from=builder /path/in/builder /path/in/final
```

### Docker Networking Quick Reference
```bash
docker network create --driver bridge my-net    # custom bridge (gets DNS resolution)
docker network create -d overlay my-overlay      # multi-host network
docker run --network host ...                     # share host's network stack
docker run --network none ...                      # no networking at all
docker network ls                                    # list networks
docker network inspect my-net                         # inspect a network
```

### Docker CLI Operations Quick Reference
```bash
docker build -t app:1.0 .                       # build image from Dockerfile in current dir
docker build --no-cache -t app:1.0 .              # rebuild ignoring all cached layers
docker run -d --name app -p 8080:8080 app:1.0      # run detached, named, port-published
docker ps                                             # list running containers
docker ps -a                                           # list all containers, including stopped
docker exec -it app sh                                  # open a shell inside a running container
docker stop app                                          # gracefully stop a running container
docker rm app                                             # delete a stopped container
docker rmi app:1.0                                         # delete an image
docker images                                               # list local images
docker builder prune -f                                      # clear unused build cache
docker system prune -a --volumes -f                            # remove ALL unused containers/images/volumes (⚠️ can delete real data)
```

### Docker Volumes Quick Reference
```bash
docker volume create my-vol                    # named volume
docker run -v my-vol:/data ...                  # use named volume
docker run -v /host/path:/data ...               # bind mount
docker run --tmpfs /data:size=100m ...            # tmpfs (in-memory)
docker volume ls                                    # list volumes
docker volume prune                                  # clean up unused volumes
```

### The "Why" Behind Common Production Choices
| Choice | Why |
|---|---|
| Pin exact base image tags | Reproducible builds; `latest` can silently change |
| Copy dependency files before app code | Maximize Docker layer cache reuse |
| Non-root `USER` in every image | Reduce blast radius of a container compromise |
| Multi-stage builds | Ship only compiled output, not build tools/caches |
| Custom bridge network, not default `bridge` | Get DNS-based container-name resolution |
| Named volumes over bind mounts in prod | Portable, Docker-managed, not tied to one host's filesystem |
| `HEALTHCHECK` on every service image | Let orchestrators detect "running but broken," not just "process exists" |
| Ansible modules over raw `shell`/`command` | Preserve idempotency and safe re-runs |
| `no_log: true` on secret-handling tasks | Prevent secrets leaking into Ansible's verbose logs |

---

*End of handbook.*
