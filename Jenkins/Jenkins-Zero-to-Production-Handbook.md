# Jenkins Zero to Production — Complete DevOps Handbook

> A complete, beginner-friendly, technically accurate learning handbook covering Jenkins from absolute basics to production-grade CI/CD, built from a full Jenkins course transcript plus additional production knowledge required for real-world DevOps and AWS work.

---

## Table of Contents

**Part 1: Foundations**
- [1. Introduction to Jenkins](#1-introduction-to-jenkins)
- [2. CI/CD Fundamentals](#2-cicd-fundamentals)
- [3. Jenkins Architecture](#3-jenkins-architecture)

**Part 2: Getting Started**
- [4. Installing Jenkins (AWS EC2 + Linux)](#4-installing-jenkins-aws-ec2--linux)
- [5. First Login and Initial Setup](#5-first-login-and-initial-setup)

**Part 3: Freestyle Jobs**
- [6. Freestyle Projects Deep Dive](#6-freestyle-projects-deep-dive)
- [7. Source Code Management (SCM) Integration](#7-source-code-management-scm-integration)
- [8. Build Triggers](#8-build-triggers)
- [9. Parameterized Builds](#9-parameterized-builds)
- [10. Post-Build Actions & Notifications](#10-post-build-actions--notifications)

**Part 4: Pipelines**
- [11. Introduction to Jenkins Pipeline](#11-introduction-to-jenkins-pipeline)
- [12. Declarative vs Scripted Pipeline](#12-declarative-vs-scripted-pipeline)
- [13. Pipeline Syntax Deep Dive](#13-pipeline-syntax-deep-dive)
- [14. Multibranch Pipelines & Organization Folders](#14-multibranch-pipelines--organization-folders)

**Part 5: Credentials & Security**
- [15. Jenkins Credentials Management](#15-jenkins-credentials-management)
- [16. Using withCredentials in Pipelines](#16-using-withcredentials-in-pipelines)
- [17. User Management & Role-Based Access Control (RBAC)](#17-user-management--role-based-access-control-rbac)
- [18. Jenkins Security & Production Hardening](#18-jenkins-security--production-hardening)

**Part 6: Tools & Integrations**
- [19. Global Tools Configuration](#19-global-tools-configuration)
- [20. Docker and Jenkins](#20-docker-and-jenkins)
- [21. Kubernetes and Jenkins (Additional Production Knowledge)](#21-kubernetes-and-jenkins-additional-production-knowledge)
- [22. Terraform and Jenkins (Additional Production Knowledge)](#22-terraform-and-jenkins-additional-production-knowledge)

**Part 7: Distributed Builds**
- [23. Jenkins Master/Agent Architecture](#23-jenkins-masteragent-architecture)
- [24. Configuring and Scaling Agents](#24-configuring-and-scaling-agents)

**Part 8: Advanced Pipeline Engineering**
- [25. Complete CI/CD Pipeline Design](#25-complete-cicd-pipeline-design)
- [26. Jenkins Shared Libraries](#26-jenkins-shared-libraries)
- [27. Remote Build Triggering](#27-remote-build-triggering)

**Part 9: Operations**
- [28. Plugin Management](#28-plugin-management)
- [29. Jenkins Administration & Configuration](#29-jenkins-administration--configuration)
- [30. Backup, Recovery & Maintenance (Additional Production Knowledge)](#30-backup-recovery--maintenance-additional-production-knowledge)

**Part 10: Troubleshooting**
- [31. Troubleshooting Guide](#31-troubleshooting-guide)

**Part 11: Interview Preparation**
- [32. Interview Questions Bank](#32-interview-questions-bank)

**Part 12: Reference**
- [33. Jenkins Revision Cheat Sheet](#33-jenkins-revision-cheat-sheet)
- [34. Beginner → Production Learning Roadmap](#34-beginner--production-learning-roadmap)

---

## 1. Introduction to Jenkins

### Simple Definition
Jenkins is a free, open-source **automation server** — a program that runs on a server and automatically performs repetitive software tasks (building code, running tests, deploying applications) whenever you tell it to, so humans don't have to do them by hand every time.

### How It Works
Jenkins sits between your source code repository (GitHub, GitLab, etc.) and your deployment targets (servers, containers, cloud). When code changes, Jenkins can automatically pull the new code, compile/build it, run tests against it, and push it out to wherever it needs to go — all without a person manually running commands.

### Why It Matters
Before tools like Jenkins, developers manually built and deployed software — copying files, running scripts, restarting servers by hand. This was slow, error-prone, and didn't scale as teams and release frequency grew. Jenkins automates this so teams can ship code faster and more reliably.

### Why Use Jenkins? (Plugins & Open Source)
- **Free and open source** — no licensing cost, huge community.
- **Plugin ecosystem** — thousands of plugins let Jenkins integrate with almost any tool (Git, Docker, Kubernetes, Slack, AWS, SonarQube, and more), so you rarely have to build integrations yourself.
- **Extensible and flexible** — works for nearly any language, platform, or deployment target.
- **Mature and battle-tested** — used across the industry for over a decade, so most problems you'll hit already have documented solutions.

### Benefits of Jenkins
- **Time-saving**: automates manual, repetitive build/deploy steps.
- **Meets deadlines reliably**: consistent, repeatable automated process instead of relying on manual steps someone might forget.
- **Early bug detection**: automatically running tests on every change catches issues before they reach production.
- **Consistency**: the exact same steps run every time — no "it worked on my machine" surprises from manual deployment.

### When to Use It
Any time you have a repeatable software delivery process — building, testing, packaging, or deploying — that you don't want to do by hand every time.

**What You Should Remember:** Jenkins is an automation server that removes manual, repetitive steps from building, testing, and deploying software. Its plugin ecosystem is what makes it flexible enough to fit into almost any tech stack.

---

## 2. CI/CD Fundamentals

### Simple Definition
**CI/CD** stands for **Continuous Integration** and **Continuous Delivery/Deployment** — a set of practices that let teams build, test, and release software changes frequently, safely, and automatically.

### Continuous Integration (CI)
**Definition:** Developers frequently merge (integrate) their code changes into a shared repository, and each merge automatically triggers a build and test cycle.

**How it works:** Instead of one developer working alone for weeks and merging a giant, risky change at the end, everyone merges small changes often (multiple times a day). Every merge automatically triggers Jenkins to build the project and run automated tests.

**Why it matters:** Small, frequent changes are much easier to test, review, and fix than one giant change. If something breaks, you know almost immediately, because CI just built and tested that exact change.

### Continuous Delivery (CD)
**Definition:** After CI succeeds, the application is automatically packaged and prepared so it's **always in a deployable state** — but the final deployment to production is triggered manually (usually with human approval).

**Why it matters:** You get all the safety of automated build/test/package, but a human still makes the final call on exactly when something goes live — useful for regulated environments or when business timing matters.

### Continuous Deployment (CD)
**Definition:** The next step beyond Continuous Delivery — every change that passes all automated checks is deployed to production **automatically**, with no manual approval step at all.

**Why it matters:** Enables the fastest possible release cycle. Requires very high confidence in your automated tests, since there's no human safety net before production.

**Continuous Delivery vs Continuous Deployment — the one thing to remember:** Delivery = ready to deploy anytime, human presses the button. Deployment = it deploys itself, no button needed.

### The CI/CD Flow in Detail
A typical flow looks like this:

```
Developer writes code
      │
      ▼
Push to GitHub/GitLab
      │
      ▼
Webhook triggers Jenkins
      │
      ▼
Jenkins checks out code
      │
      ▼
Build (compile/package)
      │
      ▼
Run automated tests
      │
      ▼
Code quality / security scan
      │
      ▼
Build artifact (e.g. Docker image)
      │
      ▼
Push artifact to registry
      │
      ▼
Deploy to target environment (DEV/QA/PROD)
      │
      ▼
Notify team (Slack/Email)
```

Each of these boxes maps directly to a **stage** in a Jenkins Pipeline, which you'll build starting in Part 4.

### Common Mistakes
- Treating CI and CD as the same thing — they solve different problems (integration/testing vs. release).
- Skipping automated tests "to save time" — this defeats the entire purpose of CI.
- Deploying straight to production without any Continuous Delivery safety net (no staging environment, no approval gate).

**What You Should Remember:** CI = integrate and test code constantly. Continuous Delivery = always deployable, human approves the release. Continuous Deployment = fully automatic release with no human gate.

---

## 3. Jenkins Architecture

### Simple Definition
Jenkins runs on a **Controller** (formerly called "Master") which coordinates everything, and can delegate actual build work to one or more **Agents** (formerly called "Nodes" or "Slaves") — separate machines that do the heavy lifting.

### Core Architecture Components

| Component | What It Is |
|---|---|
| **Controller** | The central Jenkins server. Hosts the UI, stores configuration, schedules jobs, and manages agents. Should generally **not** run heavy builds itself in production. |
| **Agent (Node)** | A separate machine (physical, VM, container, or Kubernetes pod) that actually executes build steps, connected to the controller. |
| **Executor** | A "slot" on a controller or agent that can run one build at a time. An agent with 4 executors can run up to 4 builds simultaneously. |
| **Label** | A tag assigned to an agent (e.g. `linux`, `docker`, `high-memory`) so pipelines can request "run this on an agent with label X." |
| **Queue** | Holds builds that are waiting for a free executor. |
| **Workspace** | A dedicated directory on the controller/agent where a job's source code is checked out and build steps run. Each job typically gets its own workspace. |

### How It Works
1. A build is triggered (manually, by webhook, by schedule, etc.) and enters the **queue**.
2. Jenkins looks for an agent (or the controller itself) with a free **executor** that matches any required **label**.
3. Jenkins checks out the source code into a **workspace** on that executor.
4. Build steps run inside that workspace.
5. Results (logs, artifacts, test reports) are recorded and shown in **build history**.

### Why It Matters
Understanding this separation is critical for scaling: as your team grows, you add more agents (rather than overloading a single controller), and use labels to route specific kinds of jobs (e.g., Docker builds) to agents that actually have the right tools installed.

### Jenkins UI Navigation
```
Jenkins Dashboard → Manage Jenkins → Nodes → lists all Controller + Agent nodes and their executor counts
Job → Build History → shows every past execution of that job
Job (running) → Console Output → live/streamed logs of the current build
```

### Real-World Production Scenario
A company has one Jenkins controller and three agents: one labeled `docker` (has Docker installed, used for image builds), one labeled `terraform` (has Terraform + AWS CLI, used for infra jobs), and one labeled `test` (heavier CPU, used for long test suites). Pipelines specify `agent { label 'docker' }` to guarantee they land on a machine with the right tools — instead of guessing.

### Common Mistakes
- Running all builds directly on the controller — this slows down the entire Jenkins UI for everyone and is a security risk (build steps run with controller-level access).
- Not using labels — jobs land on random agents that may be missing required tools, causing "command not found" failures.

### Best Practices
- Keep the controller **build-free** in production; it should orchestrate, not execute.
- Use labels deliberately so jobs always land on agents with the right toolchain.
- Size executor counts based on actual agent CPU/memory, not arbitrarily.

**What You Should Remember:** Controller = brain/coordinator. Agent = worker that does the actual build. Executor = a slot for one build. Label = how you route jobs to the right agent. Workspace = where the job's files live during the build.

---

## 4. Installing Jenkins (AWS EC2 + Linux)

### Simple Definition
Before you can use Jenkins, you need a server to run it on, Java installed (Jenkins runs on the JVM), the correct network access opened up, and Jenkins itself installed as a service.

### Prerequisites
- A Linux server (an AWS EC2 instance is a common, realistic choice for learning and production).
- **Java (JDK)** installed — Jenkins is a Java application and won't run without it.
- Correct **inbound security group / firewall rules** so you can reach Jenkins's web UI (default port `8080`) and SSH into the box (port `22`).

### Jenkins UI Navigation / Setup Steps
```
1. Launch an EC2 instance (Ubuntu/Amazon Linux), size depends on load (t3.medium+ recommended for real use).
2. Configure AWS Security Group:
   - Allow inbound TCP 22 (SSH) from your IP
   - Allow inbound TCP 8080 (Jenkins UI) from your IP or team's IP range
3. SSH into the instance.
4. Install Java:
   sudo apt update
   sudo apt install openjdk-17-jdk -y
   java -version   # verify installation
5. Install Jenkins (Debian/Ubuntu example):
   curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
     /usr/share/keyrings/jenkins-keyring.asc > /dev/null
   echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
     https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
     /etc/apt/sources.list.d/jenkins.list > /dev/null
   sudo apt-get update
   sudo apt-get install jenkins -y
6. Start Jenkins and enable it on boot:
   sudo systemctl start jenkins
   sudo systemctl enable jenkins
   sudo systemctl status jenkins   # verify it's running
```

### Why It Matters
Jenkins needs a compatible Java version to run at all — a mismatched or missing JDK is one of the most common "Jenkins won't start" issues for beginners. Similarly, forgetting to open port 8080 in the security group means you install Jenkins correctly but simply can't reach it from your browser.

### Common Mistakes
- Forgetting to open port 8080 in the AWS Security Group, then assuming the installation failed.
- Installing an incompatible Java version for the Jenkins release being installed.
- Not enabling the Jenkins service (`systemctl enable`), so it doesn't survive a server reboot.

### Troubleshooting: Port Issues
If you can't reach Jenkins at `http://<server-ip>:8080`:
1. Confirm Jenkins is actually running: `sudo systemctl status jenkins`
2. Confirm the security group allows inbound 8080 from your IP.
3. Confirm no other process is already bound to port 8080: `sudo lsof -i :8080`
4. Check the OS-level firewall (e.g., `ufw`) isn't blocking the port separately from the AWS security group.

**What You Should Remember:** Jenkins install = Java + Jenkins package + open port 8080 + start/enable the service. Most first-time failures are Java version mismatches or a closed security group port — not Jenkins itself.

---

## 5. First Login and Initial Setup

### Simple Definition
The first time you open Jenkins in a browser, it walks you through an "Unlock Jenkins" step, plugin installation, and creating your first admin user.

### How It Works — Step by Step
1. **Unlock Jenkins**: Jenkins generates a random initial admin password on first start, stored in a file on the server:
   ```
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```
   Paste this into the browser's "Unlock Jenkins" screen.
2. **Install Suggested Plugins**: Jenkins offers a default bundle of commonly needed plugins (Git, Pipeline, credentials support, etc.). For most learners and most production setups, "Install Suggested Plugins" is the right starting choice; you can add/remove plugins later.
3. **Create First Admin User**: Set a real username and password instead of relying on the default admin account long-term — this is a basic security hygiene step.
4. **Instance Configuration**: Confirm the Jenkins URL (how Jenkins refers to itself, important for webhooks and notification links later).

### Understanding the Jenkins "Master Node" (Controller)
By default, right after installation, the controller itself acts as a **build node too** — meaning it will happily run jobs directly on itself unless you configure agents. This is fine for learning, but as covered in [Section 3](#3-jenkins-architecture) and [Section 23](#23-jenkins-masteragent-architecture), production setups move real build work off the controller and onto dedicated agents.

### Post-Installation Configuration Review
After setup, it's worth reviewing:
```
Manage Jenkins → System → confirm Jenkins URL, admin email
Manage Jenkins → Plugins → confirm installed plugin list
Manage Jenkins → Security → confirm authentication is configured (not left wide open)
```

### Common Mistakes
- Leaving the default `admin`/initial-password combination in place long-term.
- Skipping suggested plugins entirely, then discovering core features (like Git support) are missing later.
- Not noting down the Jenkins URL setting, then having broken webhook/notification links later.

**What You Should Remember:** First-run setup = unlock with the generated password → install plugins → create a real admin user → confirm system URL. Do this once, carefully — it sets the foundation for everything else.

---

## 6. Freestyle Projects Deep Dive

### Simple Definition
A **Freestyle project** is Jenkins's original, general-purpose job type — configured entirely through UI forms rather than code. It's the simplest way to get started, though Pipelines (covered in Part 4) are the production-standard approach today.

### How It Works
You create a job, tell it where to get code from, what shell commands to run, and what to do afterward — all through UI sections rather than a script.

### Jenkins UI Navigation
```
Dashboard → New Item → enter job name → select "Freestyle project" → OK
```

### Key Configuration Sections (What Each One Does)
| Section | Purpose |
|---|---|
| **Description** | Free-text notes shown on the job's page. |
| **Discard Old Builds** | Automatically deletes old build history/logs after a set number of builds or days — prevents disk space from growing forever. |
| **This project is parameterized** | Enables input parameters — see [Section 9](#9-parameterized-builds). |
| **Throttle builds** | Limits how many times a job can run in a given time window. |
| **Execute concurrent builds if necessary** | Allows multiple runs of the same job in parallel instead of queuing them one after another. |
| **Source Code Management** | Where to pull code from (e.g., Git) — see [Section 7](#7-source-code-management-scm-integration). |
| **Build Triggers** | What causes the job to run automatically — see [Section 8](#8-build-triggers). |
| **Environment** | Environment variables, workspace cleanup before build, secrets injection, console timestamps, and other run-context settings. |
| **Build Steps** | The actual commands/tasks to execute (e.g., "Execute shell"). |
| **Post-build Actions** | What to do after the build finishes — see [Section 10](#10-post-build-actions--notifications). |

### Build Steps: Executing Shell Commands
The most common Freestyle build step is **"Execute shell"**, where you write ordinary shell commands:
```bash
git clone https://github.com/example/app.git
cd app
mvn compile
./run.sh
```
Jenkins runs these exactly as if you'd typed them in a terminal inside the job's workspace.

### Build History and Logs
Every execution of a job is recorded with a build number. Clicking into a specific build shows:
- **Console Output** — the full live/streamed log of that run (first place to check when something fails).
- Build duration, who/what triggered it, and artifacts produced.

### Why It Matters
Even though Pipelines are the modern standard, Freestyle projects are how most people first understand *what* Jenkins actually does at each step — build, test, notify — before layering on Pipeline-as-code.

### Common Mistakes
- Not enabling "Discard Old Builds," letting disk usage grow unbounded over months of daily builds.
- Manually editing UI-configured jobs repeatedly instead of migrating to a Pipeline once complexity grows — this becomes unmaintainable and isn't version-controlled.

### Best Practices
- Use Freestyle only for very simple jobs or quick experiments; move anything with real logic to a Pipeline/Jenkinsfile, which is version-controlled alongside your code.
- Always set Discard Old Builds.

**What You Should Remember:** A Freestyle project is a UI-configured job. It's the easiest entry point to learn Jenkins concepts, but production teams move to code-based Pipelines for anything beyond trivial tasks.

---

## 7. Source Code Management (SCM) Integration

### Simple Definition
SCM configuration tells Jenkins **where your code lives** and how to pull it in before running any build steps.

### How It Works
In a Freestyle job, the SCM section (usually set to **Git**) asks for:
- **Repository URL** (e.g., `https://github.com/org/repo.git`)
- **Credentials** (if the repo is private — see [Section 15](#15-jenkins-credentials-management))
- **Branch to build** (e.g., `main`, `*/main`, or a wildcard)

When the build runs, Jenkins clones/checks out that exact branch into the job's workspace before running any build steps.

### Jenkinsfile Example (Declarative Pipeline `checkout`)
```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/example/app.git',
                    credentialsId: 'github-creds'
            }
        }
    }
}
```

### Line-by-Line Explanation
- `git branch: 'main'` — which branch to pull.
- `url: '...'` — the repository location.
- `credentialsId: 'github-creds'` — references a credential stored in Jenkins (never a raw username/password in the file itself).

### Additional Production Knowledge: Shallow Clone, Polling vs Webhooks, Branch Discovery
- **Shallow clone**: fetches only the latest commit history instead of the entire repo history — much faster for large repos with long histories, at the cost of not having full git log available in the workspace.
- **Polling SCM** vs **Webhooks**: polling means Jenkins periodically checks the repo for new commits (wastes resources, has delay); webhooks mean the Git provider actively notifies Jenkins the instant a push happens (faster, more efficient — the production-preferred approach). Covered further in [Section 8](#8-build-triggers).
- **Branch Discovery / Multibranch**: rather than hardcoding one branch, Jenkins can automatically discover and build every branch (and even pull requests) in a repository — see [Section 14](#14-multibranch-pipelines--organization-folders).

### Common Mistakes
- Using "Poll SCM" with a very frequent schedule (e.g., every minute) on many jobs — this hammers the Git server unnecessarily; a webhook is almost always better.
- Forgetting to attach credentials to a private repository, causing checkout to fail with an authentication error.

### Troubleshooting: Git Checkout Failures
- **Symptom:** "Permission denied" / "repository not found" → **Cause:** missing or wrong credentials, or wrong repo URL → **Fix:** verify the `credentialsId` matches a valid, working credential in **Manage Jenkins → Credentials**.
- **Symptom:** Checkout hangs → **Cause:** agent has no network access to the Git host → **Fix:** verify connectivity/firewall rules from the agent.

**What You Should Remember:** SCM config = where code comes from + which branch + which credentials. Webhooks (event-driven) are the production-preferred way to trigger builds on new commits, versus polling (delayed, resource-wasteful).

---

## 8. Build Triggers

### Simple Definition
Build triggers define **what causes a job to start running automatically** — instead of a person clicking "Build Now" every time.

### Types of Triggers
| Trigger | What It Does |
|---|---|
| **Trigger builds remotely** | Starts a build via an API call/URL with a security token — useful for external systems to kick off a Jenkins job. See [Section 27](#27-remote-build-triggering). |
| **Build after other projects are built** | Chains jobs together — this job runs automatically once a specified upstream job finishes (optionally, only on a specific status like SUCCESS). |
| **Build periodically** | Runs on a fixed schedule using Cron syntax (e.g., nightly builds), regardless of whether code changed. |
| **GitHub hook trigger for GITScm polling** | Builds automatically the instant GitHub sends a push-event webhook — the modern, event-driven, low-latency approach. |
| **Poll SCM** | Jenkins checks the repository on a Cron-like schedule (e.g., every 2 minutes) for new commits, and only builds if something changed. |

### Cron Syntax Basics
Jenkins uses standard 5-field Cron syntax: `MINUTE HOUR DAY MONTH DAY_OF_WEEK`
```
H 2 * * *      → run once daily, sometime around 2 AM (H = Jenkins spreads load automatically)
H/15 * * * *   → run roughly every 15 minutes
```

### Why It Matters
Choosing the right trigger affects both speed (how fast a change gets built) and resource usage (how much load is placed on Git servers/Jenkins itself). Webhooks are near-instant and efficient; polling is delayed and wasteful, but sometimes necessary if webhooks can't reach Jenkins (e.g., Jenkins is on a private network the Git provider can't call into).

### Real-World Production Scenario
A team's Jenkins is on a private VPC without a public endpoint, so GitHub can't send it a webhook directly. They either expose a secured public endpoint, use an intermediary (like a GitHub Actions runner or a tunneling service) to relay the event, or fall back to Poll SCM with a reasonable interval as a pragmatic compromise.

### Common Mistakes
- Relying solely on Poll SCM in a modern setup when webhooks are available — adds unnecessary delay and load.
- Not securing the "trigger build remotely" token, allowing anyone with the URL to trigger builds.

### Troubleshooting: Webhook Not Triggering
1. Check **GitHub repo → Settings → Webhooks** for delivery attempts and response codes.
2. Confirm Jenkins's URL (Manage Jenkins → System) is publicly reachable from GitHub's servers.
3. Confirm the correct plugin (e.g., GitHub plugin) is installed and the job has "GitHub hook trigger" checked.

**What You Should Remember:** Webhooks = instant, event-driven, production-preferred. Polling = periodic check, slower, use only when webhooks aren't possible. Upstream/downstream job chaining links dependent jobs together.

---

## 9. Parameterized Builds

### Simple Definition
A parameterized build is a Jenkins job that asks the user for input — like a form — before it runs, instead of running identically every time.

### How It Works
When "This project is parameterized" is enabled, clicking "Build Now" is replaced with "Build with Parameters," showing a form. The values entered are injected as variables the build steps or Jenkinsfile can read.

### Why It Matters
Without parameters, you'd need a separate job for every environment or variation (DEV job, QA job, PROD job...). Parameters let one job handle all of them by asking "which one this time?"

### When to Use It
- Deploying to different environments (DEV/QA/PROD)
- Choosing an application version or Docker image tag
- Choosing a region or deployment type
- Any run-time decision a human needs to make

### Parameter Types
| Type | Purpose | Example |
|---|---|---|
| **String** | Free-text input | Application version: `1.2.5` |
| **Choice** | Dropdown of fixed options | Environment: `DEV`, `QA`, `PROD` |
| **Boolean** | Checkbox (true/false) | Run tests? |
| **Password** | Masked input | Temporary token (real secrets should still use Credentials, not this) |
| **File** | Upload a file for use during the build | Config override |

### Jenkins UI Navigation
```
Job → Configure → General → check "This project is parameterized"
  → Add Parameter → choose type → set Name, Default Value, Description → Save
```

### Jenkinsfile Example
```groovy
pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['DEV', 'QA', 'PROD'], description: 'Select deployment environment')
        string(name: 'APP_VERSION', defaultValue: '1.0.0', description: 'Application version to deploy')
        booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'Run unit tests before deploy?')
    }

    stages {
        stage('Show Inputs') {
            steps {
                echo "Deploying version ${params.APP_VERSION} to ${params.ENVIRONMENT}"
            }
        }
        stage('Test') {
            when { expression { params.RUN_TESTS == true } }
            steps {
                echo 'Running unit tests...'
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying to ${params.ENVIRONMENT} environment"
            }
        }
    }
}
```

### Line-by-Line Explanation
- `parameters { }` — declares the input form shown before the build starts.
- `choice(...)` — a dropdown; `choices` lists allowed values.
- `string(...)` — a free-text box with a `defaultValue`.
- `booleanParam(...)` — a checkbox.
- `params.X` — how you read a parameter's value anywhere in the pipeline.
- `when { expression { ... } }` — makes a stage conditional based on parameter values.

### Real-World Production Scenario
One `deploy-app` job replaces three separate DEV/QA/PROD jobs. It asks "which environment?" and "which version?", then picks credentials, config, and target servers accordingly — one job, multiple destinations, zero duplication.

### Common Mistakes
- No default values → automated triggers (webhooks/cron) fail since nobody is there to fill the form.
- Putting real secrets in `string`/`password` parameters instead of using Jenkins Credentials — exposes them in build history.
- Not validating parameter values in pipeline logic.

### Debugging/Troubleshooting
- Automated trigger fails on missing parameter → add sensible defaults to every parameter.
- `params.X` is null → check the exact parameter name (case-sensitive) matches the declaration.

### Best Practices
- Prefer `Choice` over `String` whenever the valid values are known — prevents typos.
- Use Credentials + `withCredentials` for real secrets, not Password parameters.
- Use clear, uppercase, descriptive parameter names.

### Interview Questions
**Q: Difference between a String and Password parameter?**
A: Both take text input; Password masks the value in the UI and tries to hide it in logs — but real secrets should still go through Jenkins Credentials + `withCredentials`, which is designed specifically for secret handling.

**Q: How do you read a parameter inside a Jenkinsfile?**
A: Through the `params` object, e.g. `params.ENVIRONMENT`.

**What You Should Remember:** Parameterized builds turn one static job into a flexible, reusable one by collecting input at run time; access values via `params.X`.

---

## 10. Post-Build Actions & Notifications

### Simple Definition
Post-build actions define **what Jenkins does after a build finishes** — archiving results, publishing reports, or notifying people, regardless of whether the build succeeded or failed.

### How It Works
After all build steps complete, Jenkins runs any configured post-build actions, which can behave differently depending on the build's final status (success, failure, unstable).

### Common Post-Build Actions
- **Archive the artifacts** — saves build outputs (e.g., a `.jar`, `.zip`, or Docker image manifest) so they're downloadable later.
- **Publish JUnit test result report** — parses test XML output so Jenkins shows pass/fail counts and trends over time.
- **E-mail Notification** — sends an email on build completion, often only on failure or "unstable" (tests failed but build succeeded) status.

### Installing the Email Extension Plugin
The core email feature is basic; the **Email Extension Plugin** allows richer, templated notifications (conditional recipients, HTML templates, attaching logs).
```
Manage Jenkins → Plugins → Available Plugins → search "Email Extension" → Install
Manage Jenkins → System → configure SMTP server, default recipients, default subject/content templates
```

### Jenkinsfile Example (Declarative `post` block)
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
    post {
        success {
            echo 'Build succeeded!'
        }
        failure {
            mail to: 'team@example.com',
                 subject: "FAILED: Job ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "Check console output at ${env.BUILD_URL}"
        }
        always {
            archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            junit '**/target/surefire-reports/*.xml'
        }
    }
}
```

### Line-by-Line Explanation
- `post { }` — a special block that runs after all stages, regardless of outcome.
- `success { }` / `failure { }` / `always { }` — conditions that determine when that sub-block runs.
- `mail to: ...` — sends an email; `env.JOB_NAME`, `env.BUILD_NUMBER`, `env.BUILD_URL` are Jenkins-provided environment variables giving context about the current run.
- `archiveArtifacts` — saves matching files as downloadable build artifacts; `fingerprint: true` lets Jenkins track that exact file across jobs.
- `junit` — parses test report XML files and shows them as a pass/fail summary on the build page.

### Common Mistakes
- Sending success emails on every single build — leads to notification fatigue; most teams only alert on failure/unstable.
- Forgetting `always` for archiving — if only placed under `success`, failed builds lose their logs/artifacts for debugging.

### Best Practices
- Notify on failure and recovery ("build is green again"), not on every success.
- Always archive test reports (`junit`) so failure trends are visible over time, not just the latest run.

**What You Should Remember:** Post-build actions run after the build (success/failure/always) — used for archiving artifacts, publishing test reports, and sending notifications. `post { }` in a Jenkinsfile is the Pipeline equivalent of Freestyle's post-build action section.

---

## 11. Introduction to Jenkins Pipeline

### Simple Definition
A **Pipeline** is a Jenkins job defined as **code** (in a file called a `Jenkinsfile`) instead of clicked-through UI forms. It describes the entire build/test/deploy process as a sequence of stages.

### Why It Matters
Unlike Freestyle jobs, a Jenkinsfile lives inside your source repository, alongside your application code. That means:
- It's **version-controlled** — you can see history, review changes, and roll back.
- It's **portable** — the same pipeline definition can be reused/copied across projects.
- It supports **complex logic** — loops, conditionals, parallel execution, reusable functions — that Freestyle's UI simply can't express.

### How It Works
Jenkins reads the `Jenkinsfile` (usually from the root of your Git repo) and executes it stage by stage: checkout code → build → test → deploy → notify, exactly as defined in code.

### When to Use It
Essentially always, for any real production CI/CD — Pipelines are the modern standard. Freestyle remains useful only for very simple, one-off tasks.

**What You Should Remember:** A Pipeline is Jenkins-as-code via a Jenkinsfile — version-controlled, reusable, and capable of expressing real logic, unlike Freestyle's UI-only configuration.

---

## 12. Declarative vs Scripted Pipeline

### Simple Definition
Jenkins supports two syntaxes for writing a Jenkinsfile: **Declarative** (structured, opinionated, easier to read) and **Scripted** (full Groovy programming language, more flexible but more complex).

### Declarative Pipeline
- Uses a fixed, predictable structure: `pipeline { agent {} stages {} post {} }`.
- Easier for beginners to read and validate; Jenkins can catch structural mistakes early.
- Recommended default for most teams and most use cases.

```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
            }
        }
    }
}
```

### Scripted Pipeline
- Written in raw Groovy code, wrapped in a `node { }` block.
- Full programming flexibility (loops, try/catch, custom functions) without Declarative's structural constraints.
- Steeper learning curve; easier to write unmaintainable, hard-to-read pipelines if not careful.

```groovy
node {
    stage('Build') {
        echo 'Building the application...'
    }
    stage('Test') {
        echo 'Running tests...'
    }
}
```

### Line-by-Line Explanation (Declarative)
- `pipeline { }` — the top-level block marking this as a Declarative Pipeline.
- `agent any` — tells Jenkins to run this on any available agent (or the controller if none configured).
- `stages { }` — container for all pipeline stages.
- `stage('Build') { }` — a named phase shown as its own box in the Jenkins UI's pipeline visualization.
- `steps { }` — the actual commands executed within that stage.

### Line-by-Line Explanation (Scripted)
- `node { }` — allocates an executor and workspace; equivalent in purpose to Declarative's `agent`.
- `stage('...') { }` — same concept as Declarative, but without the surrounding `stages`/`steps` wrapper — just plain Groovy code blocks.

### When to Use Which
| Use Declarative when... | Use Scripted when... |
|---|---|
| You want a standard, structured, easy-to-review pipeline | You need complex custom logic Declarative can't express cleanly |
| Your team is newer to Jenkins/Groovy | Your team is comfortable writing Groovy |
| Most everyday CI/CD needs | Rare edge cases, or wrapping Scripted logic inside Declarative's `script { }` block |

**Important note:** Declarative Pipelines can drop into Scripted-style Groovy at any point using a `script { }` block — giving you an escape hatch for complex logic without abandoning Declarative structure entirely.

### Common Mistakes
- Mixing Declarative top-level structure with raw Scripted syntax outside of a `script { }` block — causes syntax errors.
- Choosing Scripted "because it's more powerful" for a simple pipeline that Declarative handles just fine — adds unnecessary complexity.

**What You Should Remember:** Declarative = structured, opinionated, recommended default. Scripted = full Groovy flexibility, more complex. Declarative can embed Scripted logic via `script { }` when needed.

---

## 13. Pipeline Syntax Deep Dive

### Core Declarative Directives

| Directive | Purpose |
|---|---|
| `agent` | Where the pipeline (or a specific stage) runs — `any`, `none`, `label 'x'`, or `docker { image '...' }`. |
| `stages` / `stage` | The named phases of the pipeline, shown visually in the Jenkins UI. |
| `steps` | The commands executed within a stage. |
| `environment` | Defines environment variables available to the pipeline or a specific stage. |
| `parameters` | Declares input parameters — see [Section 9](#9-parameterized-builds). |
| `tools` | Auto-installs/configures tools like JDK, Maven, or Node.js for this pipeline run — see [Section 19](#19-global-tools-configuration). |
| `options` | Pipeline-wide behavior settings, e.g. `timeout`, `retry`, `disableConcurrentBuilds`. |
| `triggers` | Automated triggers defined in code (cron, polling) instead of UI — see [Section 8](#8-build-triggers). |
| `post` | Actions to run after the pipeline/stage finishes — see [Section 10](#10-post-build-actions--notifications). |
| `when` | Conditional logic to decide if a stage should run. |
| `input` | Pauses the pipeline to wait for manual approval before continuing. |
| `parallel` | Runs multiple stages simultaneously instead of sequentially. |

### Full Example Using Several Directives
```groovy
pipeline {
    agent any

    options {
        timeout(time: 30, unit: 'MINUTES')
        retry(2)
        disableConcurrentBuilds()
    }

    environment {
        APP_ENV = 'staging'
    }

    stages {
        stage('Build') {
            steps {
                sh 'echo Building for $APP_ENV'
            }
        }

        stage('Parallel Checks') {
            parallel {
                stage('Unit Tests') {
                    steps { sh 'echo Running unit tests' }
                }
                stage('Lint') {
                    steps { sh 'echo Running lint checks' }
                }
            }
        }

        stage('Approve Deploy') {
            when { branch 'main' }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
            }
        }

        stage('Deploy') {
            when { branch 'main' }
            steps {
                sh 'echo Deploying to production'
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed — check console output.'
        }
    }
}
```

### Line-by-Line Explanation
- `timeout(time: 30, unit: 'MINUTES')` — automatically kills the build if it runs longer than 30 minutes, preventing "stuck forever" builds from hogging an executor.
- `retry(2)` — if a stage/step fails, retry it up to 2 more times before giving up (useful for flaky network calls).
- `disableConcurrentBuilds()` — prevents two runs of this same pipeline from executing at once.
- `environment { APP_ENV = 'staging' }` — sets an environment variable accessible via `$APP_ENV` or `env.APP_ENV`.
- `parallel { }` — the two nested stages (Unit Tests, Lint) run at the same time rather than one after another, saving overall pipeline time.
- `when { branch 'main' }` — this stage only runs if the current branch is `main`.
- `input message: '...'` — pauses the pipeline and waits for a human to click "Deploy" (or abort) in the Jenkins UI before continuing — a manual approval gate.

### Error Handling: catchError
```groovy
stage('Optional Scan') {
    steps {
        catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
            sh 'run-optional-scan.sh'
        }
    }
}
```
`catchError` lets a stage fail internally (marked `FAILURE` for that stage) while still letting the overall pipeline continue running, with the whole build marked `UNSTABLE` rather than fully `FAILURE` — useful for non-blocking checks.

### Additional Production Knowledge: Matrix Builds
A **matrix** build runs the same set of stages across multiple combinations of variables (e.g., testing against Java 11, 17, and 21, on both Linux and Windows) without duplicating pipeline code:
```groovy
matrix {
    axes {
        axis {
            name 'JAVA_VERSION'
            values '11', '17', '21'
        }
    }
    stages {
        stage('Test') {
            steps {
                sh "echo Testing on Java ${JAVA_VERSION}"
            }
        }
    }
}
```

### Common Mistakes
- Forgetting `timeout` — a hung build occupies an executor indefinitely, blocking other work.
- Using `parallel` for stages that actually depend on each other's output — causes race conditions/failures.
- Placing an `input` step without a timeout — a forgotten approval gate can block a pipeline (and its executor) for days.

### Best Practices
- Always set a `timeout` at the pipeline or stage level.
- Use `input` with a `timeout` option so forgotten approvals don't block resources forever:
  ```groovy
  input message: 'Deploy?', ok: 'Yes'
  ```
  wrapped with `timeout(time: 1, unit: 'HOURS') { input ... }`.
- Use `parallel` only for genuinely independent tasks.

**What You Should Remember:** Directives like `options`, `when`, `input`, and `parallel` give Declarative Pipelines real control-flow power without dropping into Scripted Groovy. `catchError` lets non-critical steps fail softly.

---

## 14. Multibranch Pipelines & Organization Folders

### Simple Definition
A **Multibranch Pipeline** automatically discovers every branch (and optionally pull requests) in a repository and creates/runs a Jenkins job for each one — using the `Jenkinsfile` found in that branch.

### How It Works
Instead of manually creating a job per branch, you point Jenkins at the repository once. Jenkins periodically (or via webhook) scans it, and for every branch containing a `Jenkinsfile`, automatically creates a corresponding sub-job.

### Why It Matters
Modern teams work across many feature branches simultaneously. Multibranch Pipelines mean every branch — and every pull request — gets its own automatic build/test cycle without any manual job setup, which is essential for validating PRs before merge.

### Jenkins UI Navigation
```
Dashboard → New Item → enter name → select "Multibranch Pipeline" → OK
  → Branch Sources → Add source (Git/GitHub) → repository URL + credentials
  → Behaviors → configure branch discovery (all branches, PRs, etc.)
  → Scan Multibranch Pipeline Triggers → configure how often Jenkins re-scans for new/removed branches
```

### Organization Folders (Additional Production Knowledge)
An **Organization Folder** goes one level higher: instead of pointing at a single repository, it points at an entire GitHub organization or user account, and automatically creates a Multibranch Pipeline for **every repository** that contains a `Jenkinsfile`. Useful for large orgs managing dozens/hundreds of repos without manually configuring each one.

### PR Validation Workflow
1. Developer opens a pull request.
2. Jenkins (via Multibranch discovery of PRs) automatically builds and tests that PR's branch.
3. Build status is reported back to GitHub (pass/fail check on the PR).
4. Team only merges once the check passes — enforced via GitHub branch protection rules.

### Common Mistakes
- Not configuring "Discover pull requests" behavior, so PRs never get automatically validated.
- Forgetting each branch needs its own `Jenkinsfile` (or one is expected at a specific path) — branches without one are simply skipped, which can look like a silent failure to someone unfamiliar with the concept.

### Best Practices
- Use branch protection rules in GitHub/GitLab requiring the Jenkins PR check to pass before merge.
- Combine Multibranch/Organization Folders with Shared Libraries ([Section 26](#26-jenkins-shared-libraries)) so every branch's Jenkinsfile can stay short by calling shared, centrally-maintained logic.

**What You Should Remember:** Multibranch Pipeline = auto-discovers branches/PRs in one repo. Organization Folder = auto-discovers across an entire org. Both are foundational for PR-validation workflows.

---

## 15. Jenkins Credentials Management

### Simple Definition
Jenkins **Credentials** are a secure storage system for secrets (passwords, tokens, keys) so they never need to be typed directly into a Jenkinsfile or job configuration in plain text.

### Credential Types
| Type | Used For |
|---|---|
| **Secret Text** | A single token/string (e.g., an API key). |
| **Username with Password** | Basic auth pairs (e.g., a private Docker registry login). |
| **SSH Username with Private Key** | SSH-based Git access or agent connections. |
| **Certificate** | Client certificates for mutual-TLS-secured systems. |
| **AWS Credentials** | Access key/secret key pairs for AWS CLI/SDK actions (though IAM roles are preferred where possible — see below). |

### Jenkins UI Navigation
```
Manage Jenkins → Credentials → System → Global credentials (unrestricted) → Add Credentials
  → choose Kind (Secret Text / Username-Password / SSH Key / etc.)
  → set an ID (this is what your Jenkinsfile references)
  → Save
```

### How It Works in a Pipeline
Every credential gets a unique **Credential ID**. Instead of putting the secret itself in your Jenkinsfile, you reference this ID, and Jenkins injects the actual value at runtime — masking it in console logs automatically.

### Why It Matters
Storing secrets in plaintext in a Jenkinsfile (which lives in Git, visible to your whole team and possibly the public) is a serious security risk. Credentials Store keeps secrets out of source code entirely.

### Additional Production Knowledge: Safer AWS Authentication
Rather than storing long-lived AWS access keys as Jenkins Credentials, a more secure production pattern is to attach an **IAM role** directly to the EC2 instance (or Kubernetes service account) running the Jenkins agent. The AWS SDK/CLI automatically picks up temporary, auto-rotating credentials from the instance's role — meaning there's no long-lived secret to store, leak, or rotate manually at all.

### Common Mistakes
- Hardcoding secrets directly in a Jenkinsfile or shell step instead of using Credentials.
- Using long-lived AWS access keys when an IAM role would work and is more secure.
- Granting credentials broader scope/folder access than necessary (should follow least privilege).

### Best Practices
- Always reference credentials by ID; never inline secret values.
- Scope credentials to the folder/job that actually needs them, not globally, wherever practical.
- Prefer IAM roles over static AWS keys when running Jenkins on AWS infrastructure.

**What You Should Remember:** Credentials Store keeps secrets out of your Jenkinsfiles and source code. Reference by Credential ID; prefer IAM roles over static AWS keys when possible.

---

## 16. Using withCredentials in Pipelines

### Simple Definition
`withCredentials` is the Pipeline step that securely pulls a stored credential into a temporary variable, usable only within its block, then automatically discards/masks it afterward.

### Jenkinsfile Example
```groovy
pipeline {
    agent any
    stages {
        stage('Docker Login and Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push myapp:latest
                    '''
                }
            }
        }
    }
}
```

### Line-by-Line Explanation
- `withCredentials([...])` — opens a scoped block; credentials are only available inside it.
- `usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')` — pulls the stored credential by ID and exposes it as two shell-accessible variables.
- Inside the `sh` block, `$DOCKER_USER` / `$DOCKER_PASS` are available like normal environment variables, but Jenkins automatically masks their actual values in the console log output.
- `echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin` — logs into the registry without ever typing the password directly as a command argument (which would risk exposure in process listings).

### Why It Matters
This is the standard, secure way to use any secret inside a pipeline step — masking prevents secrets from leaking into build logs even if a script accidentally echoes them.

### Common Mistakes
- Accidentally `echo`-ing a credential variable directly (e.g., `echo $DOCKER_PASS`) — even though Jenkins tries to mask known secret values, this is still risky practice and should be avoided.
- Using credentials outside the `withCredentials` block scope where they're no longer masked/available.
- Writing secrets to a file without cleaning it up afterward, leaving them on the agent's disk.

### Best Practices
- Keep the `withCredentials` block as narrow/short as possible — only wrap the exact steps that need the secret.
- Never write raw secret values to log files or artifacts.

**What You Should Remember:** `withCredentials` securely injects a credential into scoped variables for a block of steps, with automatic log masking — the standard, safe way to use secrets in a pipeline.

---

## 17. User Management & Role-Based Access Control (RBAC)

### Simple Definition
RBAC controls **who can do what** in Jenkins — which users/groups can view, configure, build, or administer specific jobs and folders.

### Why It Matters
By default, a freshly installed Jenkins often grants broad access to any logged-in user. In a team/production setting, you need fine-grained control — e.g., developers can trigger builds but not change security settings; only DevOps admins can edit credentials.

### Installing the Role-Based Strategy Plugin
```
Manage Jenkins → Plugins → Available Plugins → search "Role-based Authorization Strategy" → Install → restart if prompted
Manage Jenkins → Security → Authorization → select "Role-Based Strategy" → Save
```

### Defining Roles and Permissions
```
Manage Jenkins → Manage and Assign Roles → Manage Roles
  → Create Global Roles (e.g., "admin", "developer", "viewer") with specific permission checkboxes
  → Create Item Roles (folder/job-scoped permissions, using a pattern to match job names)
Manage Jenkins → Manage and Assign Roles → Assign Roles
  → assign specific users/groups to the roles created above
```

### Example Role Design
| Role | Permissions |
|---|---|
| **admin** | Full control — configure system, manage credentials, manage plugins. |
| **developer** | Build, read, and configure jobs within their team's folder only. |
| **viewer** | Read-only access — can see build status and logs, cannot trigger or configure anything. |

### Common Mistakes
- Giving every user the built-in "admin" role for convenience — violates least privilege.
- Not scoping Item Roles to specific folders, accidentally granting access across the entire Jenkins instance.

### Best Practices
- Apply **least privilege**: give each role/user only the permissions their actual job requires.
- Use folder-scoped Item Roles to isolate teams/projects from each other.
- Regularly audit role assignments as team membership changes.

**What You Should Remember:** RBAC via the Role-based Authorization Strategy plugin lets you define Global Roles (system-wide) and Item Roles (folder/job-scoped) and assign them to users — always following least privilege.

---

## 18. Jenkins Security & Production Hardening

### Simple Definition
Beyond credentials and RBAC, Jenkins has several other security layers that matter in a production deployment.

### Authentication & Authorization
- **Authentication**: verifying *who* a user is (login) — Jenkins supports its own user database, LDAP, SSO/SAML, and others via plugins.
- **Authorization**: verifying *what* an authenticated user is allowed to do — configured via strategies like Role-Based Strategy ([Section 17](#17-user-management--role-based-access-control-rbac)) or Matrix-based security.

### CSRF Protection
Jenkins enables **CSRF Protection** (Cross-Site Request Forgery) by default, requiring a valid "crumb" token on state-changing requests — this should never be disabled in production, even though some automation scripts find it inconvenient (the correct fix is to properly fetch/use the crumb, not disable protection).

### Script Approval
Certain Groovy operations in Scripted Pipelines/Shared Libraries are considered "unsafe" and require an admin to explicitly approve the script before it runs, preventing arbitrary code execution by lower-privileged users.
```
Manage Jenkins → Script Approval → review and approve/reject pending scripts
```

### Agent Security
- Agents should connect over secure channels (SSH or encrypted inbound TCP), never unauthenticated plaintext connections.
- Agents shouldn't run with more OS-level privilege than the build actually requires.

### Plugin Security
- Only install plugins from trusted sources (the official Jenkins Update Center).
- Keep plugins updated — older versions can carry known vulnerabilities.
- Review the **Manage Jenkins → Plugins → Security warnings** section periodically.

### Network & HTTPS
- Serve the Jenkins UI over HTTPS (via a reverse proxy like Nginx, or an AWS load balancer with a certificate) rather than plain HTTP — especially since login credentials and secrets can otherwise traverse the network unencrypted.
- Restrict inbound network access (security groups/firewalls) to only what's necessary.

### Folder Permissions & Audit Considerations
- Use folders to segment teams/projects, applying RBAC per folder.
- Enable an audit trail plugin if compliance requires tracking who changed what configuration and when.

### Common Mistakes
- Disabling CSRF protection to "make automation easier."
- Running the Jenkins controller/agents as `root` unnecessarily.
- Leaving Jenkins reachable on the public internet without HTTPS or IP restrictions.

### Best Practices
- HTTPS everywhere, least-privilege everywhere, keep plugins patched, restrict network exposure, and use RBAC + folder-scoping to isolate teams.

**What You Should Remember:** Production Jenkins hardening = authentication + authorization (RBAC) + CSRF protection left on + script approval for untrusted code + patched plugins + HTTPS + restricted network access + least-privilege agents.

---

## 19. Global Tools Configuration

### Simple Definition
Jenkins can auto-install and manage the exact versions of tools your builds need (JDK, Maven, Gradle, Node.js, Git, Docker, kubectl, Terraform, AWS CLI) so every job uses a consistent, known toolchain.

### Jenkins UI Navigation
```
Manage Jenkins → Tools → configure installations for JDK, Git, Maven, Gradle, NodeJS, etc.
  → for each, click "Add" → give it a name → either point to an existing install path,
    or check "Install automatically" and pick a version for Jenkins to download itself
```

### How Jenkins Uses Tools
Once configured, a Jenkinsfile can request a specific tool by the name you gave it:
```groovy
pipeline {
    agent any
    tools {
        jdk 'jdk17'
        maven 'maven3'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -v'
                sh 'mvn clean package'
            }
        }
    }
}
```

### Line-by-Line Explanation
- `tools { jdk 'jdk17'; maven 'maven3' }` — tells Jenkins to make sure these named tool installations (configured in Manage Jenkins → Tools) are on the `PATH` for this pipeline run.
- Jenkins installs them automatically (if configured that way) before the stages run, so `mvn` and `java` commands work without you manually installing anything on the agent.

### Tools Commonly Needed for DevOps/AWS Work (Additional Production Knowledge)
| Tool | Purpose |
|---|---|
| **kubectl** | Interact with Kubernetes clusters (deployments, rollout status). |
| **Helm** | Package/deploy Kubernetes applications via charts. |
| **Terraform** | Provision/manage cloud infrastructure as code. |
| **AWS CLI** | Interact with AWS services directly from pipeline steps. |
| **SonarQube Scanner** | Run static code quality/security analysis. |
| **Trivy** | Scan Docker images/filesystems for known vulnerabilities. |
| **Docker registries (Docker Hub, Amazon ECR)** | Store and retrieve built container images. |

These tools are typically pre-installed on the **agent** (rather than auto-installed by Jenkins itself, since they're not always available via the standard Tools auto-installer), and then simply invoked with `sh` steps once configured with the right credentials/config.

### Common Mistakes
- Assuming a tool is available on every agent without confirming — leads to "command not found" errors on agents that don't have it installed.
- Using different tool versions across environments/agents, causing "works on this agent but not that one" inconsistencies.

### Best Practices
- Pin exact tool versions in the pipeline (`tools { maven 'maven3' }` referencing a specific configured version) rather than relying on whatever happens to be on the `PATH`.
- Use labeled agents ([Section 3](#3-jenkins-architecture)) to guarantee jobs land where the required tools actually exist.

**What You Should Remember:** `Manage Jenkins → Tools` configures named tool installations; the `tools { }` directive in a Jenkinsfile requests them by name, ensuring consistent versions across builds.

---

## 20. Docker and Jenkins

### Simple Definition
Docker lets Jenkins package an application (and everything it needs to run) into a portable **image**, which can then be run consistently anywhere — a build agent, a test environment, or production.

### Docker Installation/Integration
Docker must be installed on any agent that will build/run images, and the Jenkins user (or the agent process) needs permission to use the Docker daemon (commonly by adding the `jenkins` user to the `docker` group).

### Docker Agents
Instead of installing every tool an application needs directly on a Jenkins agent, you can run the build itself **inside a Docker container** that already has those tools:
```groovy
pipeline {
    agent {
        docker { image 'maven:3.9-eclipse-temurin-17' }
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}
```
Here, `mvn` doesn't need to be installed on the agent at all — Jenkins spins up a temporary container from the `maven` image, runs the build inside it, then discards the container.

### Building and Tagging Docker Images
```groovy
stage('Build Docker Image') {
    steps {
        sh 'docker build -t myapp:${BUILD_NUMBER} .'
    }
}
```
- `docker build -t myapp:${BUILD_NUMBER}` — builds an image and tags it using the current Jenkins build number, giving each image a unique, traceable version.

### Complete Jenkinsfile: Git → Build → Docker Image → Trivy Scan → ECR Push
```groovy
pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '123456789012'
        AWS_REGION     = 'us-east-1'
        ECR_REPO       = 'myapp'
        IMAGE_TAG      = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/example/app.git'
            }
        }

        stage('Build Application') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${ECR_REPO}:${IMAGE_TAG} ."
            }
        }

        stage('Scan Image with Trivy') {
            steps {
                sh "trivy image --exit-code 1 --severity HIGH,CRITICAL ${ECR_REPO}:${IMAGE_TAG}"
            }
        }

        stage('Push to Amazon ECR') {
            steps {
                sh """
                    aws ecr get-login-password --region ${AWS_REGION} \
                      | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    docker tag ${ECR_REPO}:${IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}
                    docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}
                """
            }
        }
    }

    post {
        always {
            sh "docker rmi ${ECR_REPO}:${IMAGE_TAG} || true"
        }
    }
}
```

### Line-by-Line Explanation
- `environment { }` — defines reusable values (account ID, region, repo name, image tag) referenced throughout the pipeline.
- `Checkout` stage — pulls source code, as covered in [Section 7](#7-source-code-management-scm-integration).
- `Build Application` — compiles the app (e.g., via Maven) before containerizing it.
- `docker build -t ${ECR_REPO}:${IMAGE_TAG} .` — builds the Docker image using the `Dockerfile` in the current directory, tagging it with the build number for traceability.
- `trivy image --exit-code 1 --severity HIGH,CRITICAL ...` — scans the freshly built image for known vulnerabilities; `--exit-code 1` makes the pipeline **fail** if any HIGH/CRITICAL vulnerabilities are found, preventing insecure images from being pushed.
- `aws ecr get-login-password ... | docker login ...` — authenticates Docker with Amazon ECR using a short-lived token from the AWS CLI (assuming the agent has IAM permissions, ideally via an instance role rather than static keys — see [Section 15](#15-jenkins-credentials-management)).
- `docker tag` — re-tags the local image with the full ECR repository URI required for pushing.
- `docker push` — uploads the image to the ECR repository.
- `post { always { docker rmi ... } }` — cleans up the local image copy after the pipeline finishes (success or failure) to avoid filling up agent disk space over time.

### Docker-in-Docker & Docker Socket Considerations (Additional Production Knowledge)
When Jenkins agents themselves run as containers (e.g., in Kubernetes), building Docker images from inside a container requires either:
- **Mounting the host's Docker socket** (`/var/run/docker.sock`) into the agent container — simpler, but gives that container effective root-level access to the host's Docker daemon (a real security consideration).
- **Docker-in-Docker (DinD)** — running a nested, isolated Docker daemon inside the agent container — more isolated, but has its own performance and complexity trade-offs.
- **Rootless/daemonless builders (e.g., Kaniko, Buildah)** — increasingly preferred in Kubernetes-based CI for building images without needing Docker socket access at all.

### Common Mistakes
- Not cleaning up built images/containers on agents — disk fills up over time ("Jenkins disk full" is a very common real-world incident).
- Pushing images without a vulnerability scan step, only discovering critical CVEs after they're already in production.
- Mounting the Docker socket into untrusted build containers without understanding the security implications.

### Best Practices
- Tag images meaningfully (build number, git commit SHA, or semantic version) — never rely solely on `latest`.
- Scan images before pushing (Trivy or equivalent) and fail the pipeline on critical vulnerabilities.
- Clean up local images/containers in a `post { always { } }` block.

**What You Should Remember:** Docker in Jenkins = build → tag → scan → push, ideally as one linear, failing-fast pipeline. Docker agents let you avoid installing every tool directly on Jenkins agents.

---

## 21. Kubernetes and Jenkins (Additional Production Knowledge)

> This section extends beyond the original transcript with production-relevant Kubernetes + Jenkins knowledge.

### Simple Definition
Kubernetes (K8s) is a system for running and managing containerized applications at scale. Jenkins integrates with Kubernetes both as a **deployment target** (deploying your app to a cluster) and as a **dynamic build infrastructure** (running Jenkins agents as Kubernetes pods).

### Kubernetes Plugin: Dynamic/Ephemeral Agents
Instead of maintaining a fixed pool of static Jenkins agents, the **Kubernetes plugin** lets Jenkins spin up a brand-new agent **pod** on demand for each build, then delete it when the build finishes.

**Why it matters:** No idle agents wasting resources/cost, every build gets a clean environment, and you can scale to as many concurrent builds as your cluster capacity allows.

### Pod Templates
A pod template defines what a dynamically-created agent pod looks like — which container image(s) it uses, resource limits, and service account.
```yaml
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: jenkins-agent
  containers:
    - name: maven
      image: maven:3.9-eclipse-temurin-17
      command: ["cat"]
      tty: true
    - name: kubectl
      image: bitnami/kubectl:latest
      command: ["cat"]
      tty: true
```
Referenced in a Jenkinsfile:
```groovy
pipeline {
    agent {
        kubernetes {
            yaml readTrusted('pod-template.yaml')
        }
    }
    stages {
        stage('Build') {
            steps {
                container('maven') {
                    sh 'mvn clean package'
                }
            }
        }
        stage('Deploy') {
            steps {
                container('kubectl') {
                    sh 'kubectl apply -f k8s/deployment.yaml'
                }
            }
        }
    }
}
```

### Line-by-Line Explanation
- `agent { kubernetes { yaml ... } }` — tells Jenkins to create a pod (using the given pod template) as the agent for this run, instead of using a pre-existing static agent.
- `container('maven') { }` / `container('kubectl') { }` — the pod has multiple containers (defined in the pod template); this directive says *which container* the following steps should execute inside.
- `serviceAccountName: jenkins-agent` — the Kubernetes Service Account the pod runs as, which via **RBAC** determines what the pod is allowed to do inside the cluster (e.g., permission to deploy to a specific namespace).

### Deploying to Amazon EKS
```groovy
stage('Deploy to EKS') {
    steps {
        withCredentials([file(credentialsId: 'eks-kubeconfig', variable: 'KUBECONFIG')]) {
            sh '''
                kubectl set image deployment/myapp myapp=myrepo/myapp:${BUILD_NUMBER} -n production
                kubectl rollout status deployment/myapp -n production --timeout=120s
            '''
        }
    }
}
```
- `kubectl set image ...` — updates the running deployment to use the newly built image tag.
- `kubectl rollout status ... --timeout=120s` — waits for the rollout to actually succeed (new pods healthy) and fails the pipeline if it doesn't complete within 2 minutes — this is what prevents "Jenkins says success but the app isn't actually working."

### Rollback
```bash
kubectl rollout undo deployment/myapp -n production
```
Reverts to the previous working version if a deployment causes problems.

### RBAC and Service Accounts for Jenkins-in-Kubernetes
The Jenkins agent's Kubernetes Service Account should be granted only the specific permissions it needs (e.g., "deploy to this namespace") via a Kubernetes `Role`/`RoleBinding` — not cluster-admin — following the same least-privilege principle as Jenkins's own RBAC.

### Troubleshooting Pods
| Symptom | Likely Cause | What to Check |
|---|---|---|
| Pod stuck `Pending` | Insufficient cluster resources, or unschedulable (bad node selector/taint) | `kubectl describe pod <name>` for scheduling events |
| Pod `CrashLoopBackOff` | Application crashing on startup | `kubectl logs <pod> --previous` |
| `ImagePullBackOff` | Wrong image tag, or missing registry credentials | Check image name/tag and imagePullSecrets |
| Deployment "succeeds" but app broken | No health checks / readiness probes configured | Add liveness/readiness probes; check `kubectl rollout status` actually passed |

### Common Mistakes
- Not setting resource requests/limits on agent pods — one build can starve others of cluster resources.
- Granting the Jenkins service account cluster-admin "to make things easier" — a major security risk.
- Not waiting on `kubectl rollout status` — a pipeline can report SUCCESS even though the new pods are crash-looping in the background.

### Best Practices
- Use dynamic/ephemeral pod agents for a clean, scalable build environment.
- Always wait on rollout status with a timeout, and have a clear rollback step/procedure.
- Scope RBAC tightly per namespace/team.

**What You Should Remember:** Kubernetes + Jenkins = dynamic agent pods (via pod templates) for builds, plus `kubectl`/Helm-based deployment stages for releases. Always confirm rollout status — don't assume deployment succeeded just because the pipeline didn't error.

---

## 22. Terraform and Jenkins (Additional Production Knowledge)

> This section extends beyond the original transcript with production-relevant Terraform + Jenkins knowledge.

### Simple Definition
Terraform is an **Infrastructure as Code** tool — instead of manually clicking through the AWS console to create servers, networks, etc., you describe the desired infrastructure in code, and Terraform creates/updates/destroys real cloud resources to match it. Jenkins can automate running Terraform safely, with human approval before anything actually changes.

### Terraform Core Commands
| Command | Purpose |
|---|---|
| `terraform fmt` | Auto-formats code to a consistent style. |
| `terraform validate` | Checks the code is syntactically valid, without touching real infrastructure. |
| `terraform init` | Downloads required providers/modules and sets up the backend (where state is stored). |
| `terraform plan` | Shows exactly what would change, without applying anything — a dry run. |
| `terraform apply` | Actually creates/updates real infrastructure to match the code. |
| `terraform destroy` | Tears down infrastructure that Terraform manages. |

### Jenkinsfile: fmt → validate → plan → manual approval → apply
```groovy
pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging', 'prod'], description: 'Target environment')
    }

    environment {
        TF_WORKSPACE = "${params.ENVIRONMENT}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/example/infra.git'
            }
        }

        stage('Terraform Format Check') {
            steps {
                sh 'terraform fmt -check'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform init -backend=false'
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                    terraform init
                    terraform plan -out=tfplan
                '''
            }
        }

        stage('Manual Approval') {
            steps {
                input message: "Apply Terraform plan to ${params.ENVIRONMENT}?", ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
}
```

### Line-by-Line Explanation
- `parameters { choice(...) }` — lets the user pick which environment (dev/staging/prod) this run targets, as covered in [Section 9](#9-parameterized-builds).
- `TF_WORKSPACE = "${params.ENVIRONMENT}"` — maps the chosen environment to a Terraform workspace, keeping each environment's state isolated.
- `terraform fmt -check` — fails the build if code isn't properly formatted, enforcing consistency without modifying files in CI.
- `terraform init -backend=false` + `terraform validate` — a lightweight syntax/config check that doesn't need real backend/state access, useful as an early fast-fail gate.
- `terraform plan -out=tfplan` — computes the exact planned changes and saves them to a file, so the **exact same plan** that was reviewed is what gets applied later (rather than re-planning right before apply, which could pick up unrelated drift).
- `input message: "..."` — pauses for a human to review the plan output and explicitly approve before anything real happens — critical for production infrastructure changes.
- `terraform apply -auto-approve tfplan` — applies the exact, previously-reviewed plan file without prompting again (since a human already approved via the `input` step).

### Remote State & State Locking
- **Remote state**: Terraform's knowledge of current infrastructure ("state") is stored remotely (e.g., an S3 bucket) instead of only on one person's/agent's local disk — essential so multiple pipeline runs/team members see a consistent view.
- **State locking**: prevents two `apply` operations from running simultaneously and corrupting state (commonly implemented via a DynamoDB table alongside an S3 backend).

### Environment Separation
Each environment (dev/staging/prod) should use a separate Terraform workspace or entirely separate state file/backend path, so an error in one environment's plan can never accidentally affect another.

### Credentials & Security
- Terraform needs AWS credentials to plan/apply — same guidance as [Section 15](#15-jenkins-credentials-management): prefer an IAM role attached to the Jenkins agent over static keys.
- Apply approval gates are mandatory for production — never auto-apply against `prod` without a human review step.

### Common Mistakes
- Running `terraform apply` directly without ever reviewing a `plan` — risks unexpected destructive changes.
- Not locking state, leading to corrupted/conflicting state if two runs overlap.
- Sharing one state file across all environments instead of separating them.

### Best Practices
- Always `plan` → human review → `apply`, using a saved plan file so what's reviewed is exactly what's applied.
- Use remote state with locking (S3 + DynamoDB, or an equivalent) in any team/production setting.
- Separate state per environment.

**What You Should Remember:** Terraform + Jenkins = fmt → validate → plan (saved to a file) → manual approval → apply that exact plan. Remote state + locking + environment separation are non-negotiable for team/production use.

---

## 23. Jenkins Master/Agent Architecture

### Simple Definition
As introduced in [Section 3](#3-jenkins-architecture), Jenkins separates the **Controller** (coordination, UI, scheduling) from **Agents** (actual build execution). This section covers *why* and *how* to set this up in practice.

### Why Use Agents/Worker Nodes?
- **Isolation**: build workloads don't compete with or destabilize the controller's UI/scheduling responsibilities.
- **Scalability**: add more agents as build volume grows, rather than one increasingly overloaded controller.
- **Specialization**: different agents can have different tools/OS/hardware (e.g., a GPU agent for ML builds, a Windows agent for .NET builds).
- **Security**: build steps (which may run untrusted code from a repo) execute on agents, not on the controller that holds all credentials/configuration.

### Configuring a Worker Node (Agent)
```
Manage Jenkins → Nodes → New Node → enter name → select "Permanent Agent" → OK
  → Remote root directory: e.g. /home/jenkins/agent
  → Labels: e.g. "linux docker"
  → Launch method: choose how Jenkins connects (see below)
```

### Connecting Controller and Agent via SSH
The most common launch method for a static Linux agent:
```
Launch method: "Launch agents via SSH"
  → Host: agent's IP address
  → Credentials: an SSH Username with Private Key credential (Section 15)
  → Host Key Verification Strategy: choose appropriately for your security posture
```
Once saved, Jenkins connects to the agent over SSH and installs a small Java agent process to communicate going forward.

### Other Agent Launch Methods
| Method | Use Case |
|---|---|
| **Launch agent via SSH** | Simple, static Linux agents you control directly. |
| **Launch agent by connecting it to the controller (inbound/JNLP)** | Agent initiates the connection outward — useful when the agent is behind NAT/firewall and the controller can't reach it directly. |
| **Kubernetes plugin (dynamic)** | Ephemeral pod-based agents, created/destroyed per build — see [Section 21](#21-kubernetes-and-jenkins-additional-production-knowledge). |
| **Docker plugin (dynamic)** | Similar to Kubernetes, but spins up plain Docker containers as agents. |

### Running a Job on a Specific Worker Node
In a Jenkinsfile:
```groovy
pipeline {
    agent { label 'linux docker' }
    stages {
        stage('Build') {
            steps { sh 'echo Running on a labeled agent' }
        }
    }
}
```
`agent { label 'linux docker' }` tells Jenkins to only run this pipeline on an agent that has **both** labels — ensuring it lands somewhere with the right OS and tools.

### Common Mistakes
- Not assigning meaningful labels, so jobs land on random agents that may lack required tools.
- Using SSH launch with weak host key verification in a production environment.
- Overloading a single agent with too many executors relative to its actual CPU/memory.

### Best Practices
- Label agents by capability (`docker`, `terraform`, `high-memory`), not just by hostname.
- Match executor counts to actual agent resources.
- Prefer dynamic (Kubernetes/Docker) agents in cloud-native setups for elasticity and cost efficiency.

**What You Should Remember:** Agents can be connected via SSH (static, simple), inbound/JNLP (agent behind firewall), or dynamically via Kubernetes/Docker plugins (ephemeral, scalable). Labels are how pipelines request the right kind of agent.

---

## 24. Configuring and Scaling Agents

### Static vs Dynamic Agents
- **Static agents**: always-on machines registered with Jenkins ahead of time. Simple to reason about, but you pay for idle capacity and must maintain them (patching, tool updates) manually.
- **Dynamic/ephemeral agents** (Docker or Kubernetes-based): created on demand for each build and destroyed afterward. No idle cost, always a clean environment, but adds infrastructure complexity (cluster/orchestration needed).

### Distributed Builds & Workload Separation
In a mature setup, different categories of work run on purpose-built agent pools:
- Build/compile jobs → agents with language toolchains (Maven, Node, etc.)
- Docker image builds → agents with Docker installed
- Infrastructure jobs → agents with Terraform/AWS CLI
- Heavy test suites → higher-CPU/memory agents

This avoids one generic agent pool trying to be everything to everyone, which leads to bloated images, tool version conflicts, and unpredictable performance.

### Controller Performance: Avoiding Builds on the Controller
```
Manage Jenkins → Nodes → (built-in node / controller) → Configure → set "# of executors" to 0
```
Setting the controller's executor count to `0` forces **all** builds onto agents, protecting the controller's responsiveness — a standard production practice.

### Agent Offline Troubleshooting
| Symptom | Likely Cause | Fix |
|---|---|---|
| Agent shows "offline" in Manage Jenkins → Nodes | Network/SSH connectivity lost, or agent process crashed | Check agent's system logs; re-launch via "Launch agent" button; verify SSH credentials still valid |
| Build stuck in queue, "waiting for next available executor" | No agent matches required label, or all executors busy | Check labels match; check if more agents/executors are needed |
| "No executor available" | Every online executor across matching agents is currently busy | Scale up agent count, or increase executors on existing agents (if resources allow) |

### Common Mistakes
- Leaving executors enabled on the controller "just in case," letting heavy builds accidentally land there.
- Not monitoring agent health, discovering an agent has been offline for days only when someone notices builds queuing.

### Best Practices
- Set controller executors to 0 in production.
- Monitor agent online/offline status (via Jenkins's own UI, or external monitoring hooked into Jenkins's API/metrics).
- Prefer dynamic agents for elastic, cost-efficient scaling in cloud environments.

**What You Should Remember:** Scaling Jenkins = adding/right-sizing agents (static or dynamic), keeping the controller executor-free, and using labels to route work to appropriately equipped agents.

---

## 25. Complete CI/CD Pipeline Design

### Simple Definition
This section ties together everything learned so far into one realistic, production-style pipeline: a full journey from a developer's code push to a running application in Kubernetes, with quality and security gates along the way.

### The Full Flow
```
Developer → GitHub → Webhook → Jenkins
   → Checkout
   → Build
   → Unit Tests
   → SonarQube (code quality)
   → Security Scan (Trivy)
   → Docker Build
   → Push to Amazon ECR
   → Deploy to EKS
   → Smoke Test
   → Notification (Slack/Email)
```

### Complete Jenkinsfile
```groovy
pipeline {
    agent any

    environment {
        AWS_REGION     = 'us-east-1'
        AWS_ACCOUNT_ID = '123456789012'
        ECR_REPO       = 'myapp'
        IMAGE_TAG      = "${BUILD_NUMBER}"
        SONAR_HOST     = 'https://sonar.example.com'
    }

    options {
        timeout(time: 45, unit: 'MINUTES')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/example/app.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Unit Tests') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('Code Quality: SonarQube') {
            steps {
                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                    sh "mvn sonar:sonar -Dsonar.host.url=${SONAR_HOST} -Dsonar.login=${SONAR_TOKEN}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${ECR_REPO}:${IMAGE_TAG} ."
            }
        }

        stage('Security Scan: Trivy') {
            steps {
                sh "trivy image --exit-code 1 --severity HIGH,CRITICAL ${ECR_REPO}:${IMAGE_TAG}"
            }
        }

        stage('Push to ECR') {
            steps {
                sh """
                    aws ecr get-login-password --region ${AWS_REGION} \
                      | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    docker tag ${ECR_REPO}:${IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}
                    docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}
                """
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([file(credentialsId: 'eks-kubeconfig', variable: 'KUBECONFIG')]) {
                    sh """
                        kubectl set image deployment/myapp myapp=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG} -n production
                        kubectl rollout status deployment/myapp -n production --timeout=120s
                    """
                }
            }
        }

        stage('Smoke Test') {
            steps {
                sh 'curl -f https://app.example.com/health || exit 1'
            }
        }
    }

    post {
        success {
            echo "Pipeline succeeded for build ${IMAGE_TAG}"
        }
        failure {
            mail to: 'devops-team@example.com',
                 subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "Check ${env.BUILD_URL}"
        }
        always {
            sh "docker rmi ${ECR_REPO}:${IMAGE_TAG} || true"
        }
    }
}
```

### Why Each Stage Exists
- **Checkout** — gets the exact code version to build ([Section 7](#7-source-code-management-scm-integration)).
- **Build** — compiles/packages the application.
- **Unit Tests** — catches functional regressions early, before anything is containerized or deployed.
- **SonarQube** — catches code quality/maintainability/security issues that tests alone might miss.
- **Docker Build** — packages the app into a portable, consistent unit.
- **Trivy Scan** — catches known vulnerabilities in the image before it ever reaches a registry or production.
- **Push to ECR** — makes the image available for deployment.
- **Deploy to EKS** — actually rolls the new version out, and `rollout status` confirms it's genuinely healthy — not just "kubectl didn't error."
- **Smoke Test** — a final, real-world check that the live application actually responds correctly post-deploy.
- **Notification** — ensures humans know the outcome without needing to babysit the Jenkins UI.

### Common Mistakes
- Skipping the smoke test — a deployment can "succeed" at the Kubernetes level while the application itself is broken (e.g., wrong config, missing environment variable).
- Running security/quality scans only occasionally instead of on every pipeline run.
- Not setting an overall `timeout`, risking a stuck pipeline holding an executor indefinitely.

### Best Practices
- Fail fast: put cheaper/faster checks (unit tests) before expensive/slow ones (deployment) so problems are caught earlier.
- Treat every gate (tests, quality, security) as blocking by default — bypassing them should require a deliberate, visible decision, not silent tolerance.

**What You Should Remember:** A production CI/CD pipeline chains together build → test → quality → security → package → deploy → verify → notify, with each stage acting as a gate that can stop bad code before it reaches users.

---

## 26. Jenkins Shared Libraries

### Simple Definition
A **Shared Library** is a reusable collection of Pipeline code (custom steps, functions, classes) stored in its own Git repository, which multiple Jenkinsfiles across different projects can import and reuse — instead of copy-pasting the same logic everywhere.

### Why Shared Libraries Are Needed
Imagine 30 different application repositories, each with a nearly identical Jenkinsfile doing "checkout → build → Docker → scan → push → deploy." Without Shared Libraries:
- Any improvement (e.g., adding a new security check) means editing all 30 Jenkinsfiles individually.
- Bugs get fixed in some repos but not others, causing inconsistency.

With a Shared Library, that common logic lives in **one place**, and each Jenkinsfile just calls it — improvements/fixes propagate everywhere at once.

### Folder Structure
```
shared-library-repo/
├── vars/
│   ├── buildAndPush.groovy         # a custom "global step" — callable directly
│   └── deployToKubernetes.groovy
├── src/
│   └── org/example/
│       └── DockerHelper.groovy     # a reusable Groovy class
└── resources/
    └── org/example/
        └── k8s-template.yaml       # static files usable from library code
```

- **`vars/`** — each file here becomes a callable "step" usable directly in a Jenkinsfile (e.g., `buildAndPush()`), like a custom pipeline function.
- **`src/`** — standard Groovy classes (namespaced like Java packages), for more complex, object-oriented reusable logic.
- **`resources/`** — non-code files (templates, configs) that library code can load at runtime via `libraryResource(...)`.

### Example: A `vars/` Global Step
```groovy
// vars/buildAndPush.groovy
def call(String imageName, String imageTag) {
    sh "docker build -t ${imageName}:${imageTag} ."
    sh "trivy image --exit-code 1 --severity HIGH,CRITICAL ${imageName}:${imageTag}"
    sh "docker push ${imageName}:${imageTag}"
}
```
- `def call(...)` — the special method name Jenkins looks for; this is what runs when the step is invoked by name in a Jenkinsfile.
- Parameters (`imageName`, `imageTag`) let each calling pipeline customize behavior without duplicating the underlying logic.

### Using the Library in a Jenkinsfile
```groovy
@Library('my-shared-library@main') _

pipeline {
    agent any
    stages {
        stage('Build and Push') {
            steps {
                buildAndPush('myapp', "${BUILD_NUMBER}")
            }
        }
    }
}
```
- `@Library('my-shared-library@main') _` — imports the Shared Library named `my-shared-library`, specifically the `main` branch/tag version; the trailing underscore is required Groovy syntax when no specific class is being imported directly.
- `buildAndPush('myapp', "${BUILD_NUMBER}")` — calls the reusable step defined in `vars/buildAndPush.groovy`, passing in this project's specific image name and tag.

### Configuring a Shared Library Globally
```
Manage Jenkins → System → Global Trusted Pipeline Libraries → Add
  → Name: my-shared-library
  → Default version: main
  → Retrieval method: Modern SCM → Git → repository URL
```
Once registered globally, any Jenkinsfile in the entire Jenkins instance can reference it via `@Library('my-shared-library')`.

### Library Versioning
The `@main` (or `@v1.2.0`, `@some-branch`) part of `@Library('name@version')` lets different pipelines pin to different versions of the shared logic — useful for gradually rolling out changes to the library without breaking every pipeline simultaneously.

### Trusted vs Untrusted Libraries
- **Trusted (Global) Libraries**: configured by an admin at the Jenkins system level; code runs with fewer Groovy sandbox restrictions since it's vetted centrally.
- **Untrusted (Folder-level) Libraries**: configured per-folder, can be added by teams without full admin access, but code runs inside the Groovy security sandbox with more restrictions — safer default for less-trusted contributors.

### Testing Shared Libraries
Shared Library code (especially `src/` classes) can be unit-tested like regular Groovy/Java code, ideally in its own CI pipeline, before being consumed by other project pipelines — catching bugs before they affect every consumer.

### Common Mistakes
- Putting complex, untested logic directly in `vars/` without ever testing it standalone.
- Not versioning consumers (`@main` for everyone) — a breaking change to the library instantly breaks every single project using it at once.
- Overloading Shared Libraries with business logic that's too project-specific — defeats the purpose of a *shared*, general-purpose library.

### Best Practices
- Version-pin consumers to specific tags/releases for stability; only advance the pin deliberately after testing.
- Keep Shared Library code generic and well-documented; project-specific logic stays in the project's own Jenkinsfile.
- Test library code independently before rolling it out broadly.

**What You Should Remember:** Shared Libraries centralize reusable Pipeline logic (`vars/` for callable steps, `src/` for classes, `resources/` for static files), imported via `@Library('name@version')` — the standard way to keep dozens of Jenkinsfiles DRY and consistent.

---

## 27. Remote Build Triggering

### Simple Definition
Jenkins can be triggered to start a build **remotely**, via a simple authenticated URL call, instead of a human clicking "Build Now" — useful for other systems/scripts to kick off a Jenkins job programmatically.

### How It Works
```
Job → Configure → Build Triggers → check "Trigger builds remotely (e.g., from scripts)"
  → set an Authentication Token (a secret string)
```
Then, any external system can trigger the build with:
```
curl "https://jenkins.example.com/job/my-job/build?token=THE_SECRET_TOKEN"
```

### Why It Matters
This allows integration with systems outside Git's webhook model — e.g., another internal tool, a scheduled external script, or a different CI system that needs to hand off a task to Jenkins.

### Security Considerations
- The token should be treated as a secret (stored securely, not committed to a public repo).
- Combine with network-level restrictions (only allow the calling system's IP) where possible.
- Prefer this only when webhook-based, event-driven triggers ([Section 8](#8-build-triggers)) genuinely don't fit the use case.

### Common Mistakes
- Using an easily-guessable token.
- Exposing the trigger URL publicly (e.g., in documentation or a public repo) without realizing anyone with the token can trigger builds.

**What You Should Remember:** Remote triggering uses a secret token in a URL to let external systems start Jenkins builds programmatically — treat the token like any other credential.

---

## 28. Plugin Management

### Simple Definition
Plugins extend Jenkins's core functionality — integrations with Git, Docker, Kubernetes, Slack, cloud providers, security tools, and much more. Almost every capability beyond the bare basics comes from a plugin.

### Jenkins UI Navigation
```
Manage Jenkins → Plugins
  → "Available Plugins" tab: search and install new plugins
  → "Installed Plugins" tab: view/manage/uninstall currently installed plugins
  → "Updates" tab: shows plugins with newer versions available
```

### Plugin Dependencies and Compatibility
Many plugins depend on other plugins to function (e.g., the Pipeline plugin suite depends on several supporting plugins). Jenkins automatically installs required dependencies when you install a plugin, but compatibility issues can still arise between plugin versions and your Jenkins core version.

### Plugin Upgrades and Rollback Considerations
- Upgrading a plugin can occasionally introduce breaking changes to existing job configurations or pipeline syntax.
- Jenkins keeps the previous plugin version's `.jpi.bak` file on disk, allowing a manual rollback if an upgrade causes problems — though this should be tested in a non-production Jenkins instance first wherever possible.

### Managing Plugins Safely
- Test plugin upgrades in a staging/non-production Jenkins instance before applying to production.
- Read release notes for major version jumps, since breaking changes are more likely there.
- Avoid installing plugins from unofficial or unverified sources.

### Common Plugin Failures
| Symptom | Likely Cause |
|---|---|
| Jenkins fails to restart after a plugin update | Version incompatibility between the plugin and Jenkins core, or between two interdependent plugins |
| A pipeline step suddenly "doesn't exist" | A plugin providing that step was uninstalled/downgraded |
| UI errors after an update | Cached browser assets conflicting with updated plugin UI — try a hard refresh or clearing cache |

### Best Practices
- Keep an eye on **Manage Jenkins → Plugins → Security warnings** and prioritize updating flagged plugins.
- Only install plugins you actually need — each one is additional attack surface and maintenance burden.
- Snapshot/back up Jenkins (see [Section 30](#30-backup-recovery--maintenance-additional-production-knowledge)) before major plugin upgrades.

**What You Should Remember:** Plugins are how Jenkins gains almost all of its integrations. Manage them deliberately: test upgrades in non-prod first, watch for security warnings, and back up before major changes.

---

## 29. Jenkins Administration & Configuration

### Simple Definition
The **Manage Jenkins** area is the central control panel for system-wide configuration — everything from global tools to security to system logs lives here.

### Key Administrative Areas
```
Jenkins Dashboard → Manage Jenkins →
  System               → global settings: Jenkins URL, admin email, global environment variables
  Tools                → JDK/Maven/Git/etc. installations (Section 19)
  Credentials          → the Credentials Store (Section 15)
  Nodes                → agents/executors (Sections 3, 23, 24)
  Clouds               → dynamic agent providers (Kubernetes, Docker, EC2 plugin, etc.)
  Security             → authentication/authorization/CSRF (Section 18)
  Plugins              → plugin management (Section 28)
  System Information   → Jenkins version, environment variables, system properties — useful for debugging
  System Log           → Jenkins's own internal logs, useful when the controller itself is misbehaving
  Script Console       → run raw Groovy scripts directly against the running Jenkins instance (admin-only, powerful, use with caution)
```

### Script Console — Use With Caution
```
Manage Jenkins → Script Console
```
Lets an administrator run arbitrary Groovy code with full access to Jenkins's internal Java objects — genuinely useful for advanced troubleshooting or bulk configuration changes, but also genuinely dangerous (it can modify or delete anything). Access should be restricted to trusted administrators only, and treated as an emergency/expert tool, not routine usage.

### Environment Variables & System Settings
`Manage Jenkins → System` lets you define global environment variables available to every job/pipeline — useful for values that are truly global (e.g., a shared internal registry hostname), though most values are better scoped to individual pipelines' `environment { }` blocks.

### Email/Notification Configuration
```
Manage Jenkins → System → E-mail Notification (basic) / Extended E-mail Notification (Email Extension plugin)
  → SMTP server, port, authentication, default recipients
```

### Common Mistakes
- Giving Script Console access to non-admin users — effectively equivalent to full system access.
- Setting values that should be pipeline-specific as global environment variables, causing unexpected behavior across unrelated jobs.

### Best Practices
- Restrict Script Console and System configuration access to a small trusted admin group.
- Regularly review System Information/Log when diagnosing controller-level issues.

**What You Should Remember:** `Manage Jenkins` is the hub for all system-wide administration. Script Console is powerful but should be tightly restricted — treat it like root access, because it effectively is.

---

## 30. Backup, Recovery & Maintenance (Additional Production Knowledge)

> This section extends beyond the original transcript with production-relevant operational knowledge.

### Simple Definition
Jenkins's entire configuration, job definitions, credentials, and history live in a directory called **`JENKINS_HOME`** — protecting and maintaining this directory is the foundation of disaster recovery.

### What's in JENKINS_HOME
```
JENKINS_HOME/
├── config.xml              # global system configuration
├── jobs/                    # every job's configuration and build history
├── plugins/                  # installed plugin files
├── secrets/                  # encryption keys and the Credentials Store
├── users/                    # user account data
└── nodes/                    # agent configuration
```

### Backup Strategy
- **Full backup**: regularly snapshot the entire `JENKINS_HOME` directory (e.g., via a scheduled job copying it to S3, or an EBS/disk snapshot if Jenkins runs on AWS).
- **Credentials backup consideration**: the `secrets/` directory includes the master encryption key — losing it makes previously-encrypted credentials unrecoverable even if the rest of the backup is intact, so it must always be backed up together with the rest of `JENKINS_HOME`, never separately or omitted.
- **Configuration-as-code**: increasingly, teams manage Jenkins system configuration itself as versioned YAML (via the Jenkins Configuration as Code / JCasC plugin) so the *entire setup* can be recreated from source control, not just restored from a backup blob.

### Restore Process
1. Provision a fresh Jenkins instance (same version, ideally).
2. Stop the Jenkins service.
3. Replace the new instance's `JENKINS_HOME` with the backed-up copy.
4. Start Jenkins and verify jobs, credentials, and plugins all loaded correctly.

### Build Retention & Log Cleanup
- **Discard Old Builds** (per job, or globally): automatically deletes build history/logs beyond a configured count or age, preventing `JENKINS_HOME/jobs/*/builds/` from growing indefinitely.
- **Workspace cleanup**: deleting a job's workspace directory between/after builds (via the "Delete workspace before build starts" option, or an explicit `cleanWs()` pipeline step) prevents leftover files from one build silently affecting the next.

### Disk-Space Management
"Jenkins disk full" is one of the most common real-world operational incidents. Common contributors:
- Unbounded build history/logs (fix: Discard Old Builds).
- Leftover Docker images/containers on agents (fix: cleanup steps in `post { always { } }`, as shown in [Section 20](#20-docker-and-jenkins)).
- Large, un-rotated system logs.

### Monitoring & Health Checks
- Track disk usage, executor utilization, and queue length over time (via Jenkins's own metrics/monitoring plugins, or external monitoring scraping Jenkins's API).
- Set alerts before disk usage becomes critical, rather than discovering it only after builds start failing.

### Upgrades
- Upgrade Jenkins core and plugins deliberately and incrementally (not skipping many versions at once), testing in a non-production instance first, with a full backup taken immediately before any upgrade.

### Common Mistakes
- Never testing the actual **restore** process — a backup you've never restored from is unverified and might not work when you actually need it.
- Letting build/log retention grow unbounded until a disk-full incident forces action.

### Best Practices
- Automate regular `JENKINS_HOME` backups to durable storage (e.g., S3) and periodically test restoring them.
- Set retention policies (Discard Old Builds) on every job as a default habit, not an afterthought.
- Consider Configuration as Code (JCasC) so your entire Jenkins setup is reproducible from source control, not solely dependent on backups.

**What You Should Remember:** `JENKINS_HOME` is everything Jenkins is — back it up (including `secrets/`) regularly, test restores, and set retention/cleanup policies so disk space doesn't silently become an incident.

---

## 31. Troubleshooting Guide

For each issue: **Symptoms → Likely Causes → Where to Check → Fix**

### Agent Offline
- **Symptoms**: Node shows "offline" in Manage Jenkins → Nodes; jobs targeting its label sit in queue.
- **Causes**: SSH connection dropped, agent process crashed, network/firewall change, disk full on the agent.
- **Check**: Node's status page ("Log" tab); agent's own system logs; connectivity via `ping`/`ssh` from the controller.
- **Fix**: Re-launch via "Launch agent" button; resolve underlying network/resource issue; restart the agent process if needed.

### Build Stuck in Queue / No Executor Available
- **Symptoms**: Job sits in "queue," never starts.
- **Causes**: No agent matches the requested label; all matching executors are busy; a quiet period/throttle is delaying it.
- **Check**: Queue item's "why is it in the queue" hover text in the Jenkins UI; Manage Jenkins → Nodes for executor availability.
- **Fix**: Add/free up agents matching the label; increase executor count if resources allow; adjust throttling settings.

### Jenkins Controller Overloaded
- **Symptoms**: UI sluggish/unresponsive for everyone, high CPU/memory on the controller host.
- **Causes**: Builds running directly on the controller (executors > 0); too many heavy jobs/plugins.
- **Check**: `Manage Jenkins → Nodes → built-in node` executor count; system resource monitoring.
- **Fix**: Set controller executors to 0; move builds to dedicated agents ([Section 24](#24-configuring-and-scaling-agents)).

### Git Checkout Failure
- **Symptoms**: Pipeline fails at Checkout stage; "repository not found" or "permission denied."
- **Causes**: Wrong repo URL, missing/expired/incorrect credentials, network blocked to Git host.
- **Check**: The `credentialsId` referenced actually exists and is valid in Manage Jenkins → Credentials; connectivity from the agent to the Git host.
- **Fix**: Correct the URL/credentials; verify SSH keys or tokens haven't expired.

### Webhook Not Triggering
- **Symptoms**: Pushing code doesn't start a build automatically.
- **Causes**: Webhook not configured on the Git provider side; Jenkins URL not publicly reachable; job doesn't have the trigger enabled.
- **Check**: Git provider's webhook delivery log (response codes); job's Build Triggers config.
- **Fix**: Fix Jenkins URL/reachability; re-configure webhook; enable the correct trigger on the job.

### Credentials Not Found
- **Symptoms**: Pipeline fails with a "credential ID not found" style error.
- **Causes**: Typo in `credentialsId`; credential scoped to a different folder than the job; credential was deleted.
- **Check**: Manage Jenkins → Credentials, confirm the exact ID and its scope.
- **Fix**: Correct the ID; adjust credential scope/domain if needed.

### Permission Denied
- **Symptoms**: A build step fails with an OS-level "permission denied," or a Jenkins UI action is blocked.
- **Causes**: File/directory permissions on the agent; the Jenkins/agent process user lacks required rights; RBAC restricting the user's Jenkins-level action.
- **Check**: File ownership/permissions on the agent workspace; the acting user's assigned RBAC role.
- **Fix**: Correct file permissions (e.g., add the jenkins user to the right group); adjust RBAC role if it's a Jenkins-level permission issue.

### Docker Command Not Found
- **Symptoms**: `sh: docker: command not found`.
- **Causes**: Docker isn't installed on the agent that picked up this build, or the job wasn't routed to a Docker-capable agent.
- **Check**: Which agent the build landed on; whether that agent has Docker installed.
- **Fix**: Install Docker on the agent, or add/require a `docker` label and use `agent { label 'docker' }`.

### kubectl Command Not Found
- **Symptoms**: `sh: kubectl: command not found`.
- **Causes**: Same pattern as Docker — missing tool on the agent that ran the build.
- **Fix**: Install kubectl on the agent, or route the job to an agent/pod template that includes it ([Section 21](#21-kubernetes-and-jenkins-additional-production-knowledge)).

### AWS Authentication Failure
- **Symptoms**: AWS CLI commands fail with "Unable to locate credentials" or "Access Denied."
- **Causes**: Missing/expired AWS credentials, or an IAM role/policy that doesn't grant the needed permission.
- **Check**: Whether the agent/instance has an attached IAM role, or if using static keys, whether the Jenkins credential is still valid; the IAM policy attached.
- **Fix**: Attach/fix the IAM role (preferred), or update the stored credentials; adjust IAM policy permissions.

### ECR Login Failure
- **Symptoms**: `docker login` to ECR fails.
- **Causes**: Expired/invalid AWS session; wrong AWS region in the ECR repository URI; missing ECR permissions on the IAM role/user.
- **Check**: `aws sts get-caller-identity` to confirm valid AWS auth; the region in the ECR URI matches the actual repository's region.
- **Fix**: Refresh AWS credentials/role permissions; correct the region in the ECR URI.

### Terraform Errors
- **Symptoms**: `terraform plan`/`apply` fails.
- **Causes**: State lock conflict (another run in progress), drifted/corrupted state, invalid credentials, syntax errors.
- **Check**: `terraform validate` output; state lock status (e.g., the DynamoDB lock table, if used); credentials used for the backend/provider.
- **Fix**: Wait for/clear a stale lock (carefully); fix syntax per `validate` output; refresh credentials.

### Kubernetes Deployment Failure / Pod Pending / CrashLoopBackOff
- **Symptoms**: `kubectl rollout status` never succeeds; pods unhealthy.
- **Causes**: Insufficient cluster resources (Pending); application crashing on startup (CrashLoopBackOff); wrong image or missing config (ImagePullBackOff, app errors).
- **Check**: `kubectl describe pod <name>` and `kubectl logs <pod> --previous`.
- **Fix**: Scale cluster resources; fix the application/config causing the crash; correct the image tag/registry credentials.

### Workspace Full / Jenkins Disk Full
- **Symptoms**: Builds fail with "no space left on device."
- **Causes**: Unbounded build history/logs, leftover Docker images, un-rotated logs.
- **Check**: `df -h` on the controller/agent; size of `JENKINS_HOME/jobs/*/builds`.
- **Fix**: Enable Discard Old Builds; clean up Docker images in `post { always { } }`; rotate/clean system logs.

### OutOfMemoryError
- **Symptoms**: Jenkins controller or an agent JVM crashes/restarts with an OOM error.
- **Causes**: Controller running too many heavy jobs directly; insufficient JVM heap configured relative to workload.
- **Check**: JVM heap settings; number of concurrent executors relative to available RAM.
- **Fix**: Move builds off the controller; increase heap size or reduce concurrent executor count; add more/larger agents.

### Pipeline Syntax Errors
- **Symptoms**: Pipeline fails immediately with a Groovy/Declarative syntax error, before any stage runs.
- **Causes**: Mismatched braces, mixing Scripted syntax into Declarative without `script { }`, typos in directive names.
- **Check**: The exact error line/column Jenkins reports; use the **Pipeline Syntax Generator** (`Job → Pipeline Syntax`) to generate correct snippets instead of hand-writing unfamiliar steps.
- **Fix**: Correct the syntax per the error message; wrap any raw Groovy logic in `script { }` within a Declarative pipeline.

### Plugin Conflicts
- **Symptoms**: Jenkins fails to start, or a pipeline step suddenly errors out after an update.
- **Causes**: Incompatible plugin versions, or a required dependency plugin missing/outdated.
- **Check**: Jenkins system log at startup for plugin loading errors.
- **Fix**: Roll back the problematic plugin version; update dependent plugins together, consistently.

### Pipeline Hanging
- **Symptoms**: A build runs indefinitely, never completing.
- **Causes**: A forgotten `input` approval step with no timeout; a hung network call with no timeout; a deadlocked `parallel` block.
- **Check**: The pipeline's current stage in the UI; whether it's paused on an `input` step.
- **Fix**: Always wrap long-running/approval steps with `timeout()`; add appropriate timeouts to network calls.

### Failed Approvals
- **Symptoms**: A pipeline aborts or times out at an `input` step.
- **Causes**: Nobody approved in time (if a timeout was set); the approving user lacked the correct permission.
- **Fix**: Ensure the right people have permission to approve; set a reasonable timeout with clear notification beforehand.

### Failed Deployments / "Jenkins Reports Success But the App Isn't Working"
- **Symptoms**: Pipeline shows green/SUCCESS, but the application is actually broken in production.
- **Causes**: No smoke test after deployment; `kubectl rollout status` wasn't checked (or wasn't given enough timeout); missing health checks.
- **Fix**: Always add a real smoke test stage after deployment ([Section 25](#25-complete-cicd-pipeline-design)); always verify rollout status with an adequate timeout; add liveness/readiness probes to the Kubernetes deployment itself.

**What You Should Remember:** Most Jenkins production incidents fall into a handful of patterns: missing tools on the wrong agent, expired/misconfigured credentials, unbounded disk usage, and pipelines that report success without actually verifying real-world health. Build guardrails (timeouts, smoke tests, retention policies) against all four proactively.

---

## 32. Interview Questions Bank

### Beginner
**Q: What is Jenkins?**
A: An open-source automation server used to automate building, testing, and deploying software, most commonly as the engine behind CI/CD pipelines.

**Q: What's the difference between Continuous Integration, Continuous Delivery, and Continuous Deployment?**
A: CI = frequently merging and automatically building/testing code. Continuous Delivery = code is always kept in a deployable state, but a human triggers the actual production release. Continuous Deployment = every passing change is released automatically, with no manual gate.

**Q: What is a Freestyle project?**
A: Jenkins's original UI-configured job type, where build steps and triggers are set through forms rather than code — simple, but not version-controlled or highly flexible.

**Q: What is a Jenkinsfile?**
A: A text file, usually stored in the project's Git repository, that defines a Pipeline as code.

### Intermediate
**Q: Declarative vs Scripted Pipeline — when would you choose each?**
A: Declarative for most day-to-day CI/CD — structured, easier to read/validate. Scripted (or `script {}` blocks within Declarative) when you need complex custom logic Declarative's directives can't express directly.

**Q: What does the `agent` directive do?**
A: Specifies where the pipeline (or a specific stage) executes — e.g., any available agent, a labeled agent, or inside a Docker container.

**Q: How do parameters get accessed inside a Jenkinsfile?**
A: Through the `params` object, e.g. `params.ENVIRONMENT`, after being declared in a `parameters { }` block.

**Q: What's the purpose of `withCredentials`?**
A: To securely inject a stored credential into scoped variables for a specific block of steps, with automatic log masking, rather than hardcoding secrets.

### Advanced
**Q: How would you design a Shared Library, and why use one?**
A: Structure it with `vars/` for callable global steps, `src/` for reusable Groovy classes, and `resources/` for static files; use one to centralize common CI/CD logic (e.g., build-scan-push routines) so dozens of Jenkinsfiles stay consistent and any fix/improvement is made once, in one place.

**Q: How does the Kubernetes plugin change Jenkins's scaling model compared to static agents?**
A: It creates ephemeral agent pods on demand per build (using pod templates) and tears them down afterward, instead of maintaining a fixed pool of always-on agents — reducing idle cost and guaranteeing a clean environment per build, at the cost of added orchestration complexity.

**Q: How do you prevent a stuck pipeline from holding an executor indefinitely?**
A: Set `timeout()` at the pipeline or stage level (including around any `input` approval steps), and use `options { timeout(...) }` as a default safety net on every pipeline.

### Production / Scenario-Based
**Q: How would you design a Jenkins CI/CD pipeline for a containerized app deploying to AWS?**
A: Checkout → build/compile → unit tests → static code analysis (SonarQube) → Docker build → vulnerability scan (Trivy) → push to Amazon ECR → deploy to EKS (`kubectl set image` + `rollout status`) → smoke test → notify — each stage acting as a gate, with credentials handled via IAM roles/`withCredentials` and a manual approval gate before production deploys.

**Q: An agent keeps going offline — how do you troubleshoot it?**
A: Check its status/log in Manage Jenkins → Nodes, verify SSH/network connectivity from the controller, check the agent host's own resource usage (disk/CPU/memory), and confirm credentials used for the connection are still valid; re-launch once the root cause is fixed.

**Q: How would you secure credentials in a Jenkins pipeline handling AWS deployments?**
A: Prefer an IAM role attached to the Jenkins agent/instance over static AWS keys; for any secrets that must be stored, use the Jenkins Credentials Store with `withCredentials`, scoped narrowly, never hardcoded in a Jenkinsfile.

**Q: How would you scale Jenkins to support many concurrent teams/builds?**
A: Move all builds off the controller (0 executors there), add labeled static agents or dynamic Kubernetes/Docker agents matched to workload types, and use folder-scoped RBAC so teams are isolated from each other.

**Q: How do you implement an approval gate before a production deployment?**
A: Use an `input` step (ideally wrapped in a `timeout()`) placed before the deploy stage, restricted via RBAC so only authorized approvers can act on it.

**Q: How would you troubleshoot a failed pipeline where Jenkins reports success but the deployed application isn't working?**
A: Add/verify a genuine smoke test stage after deployment, confirm `kubectl rollout status` (or equivalent) was actually checked with an adequate timeout, and ensure the Kubernetes deployment itself has liveness/readiness probes so unhealthy pods are caught at the platform level too.

**Q: How would you recover Jenkins after a total failure?**
A: Restore `JENKINS_HOME` (including the `secrets/` directory) from the most recent backup onto a fresh instance of a compatible Jenkins version, verify jobs/credentials/plugins load correctly, and — if using Configuration as Code — reapply the JCasC definitions to confirm system settings match.

**What You Should Remember:** Production interviews tend to probe *why*, not just *what* — be ready to explain trade-offs (static vs dynamic agents, Declarative vs Scripted, IAM roles vs static keys) rather than just definitions.

---

## 33. Jenkins Revision Cheat Sheet

### Core Terminology
| Term | Meaning |
|---|---|
| Controller | Central Jenkins server; coordinates everything |
| Agent / Node | A machine that executes builds |
| Executor | A slot on a controller/agent that runs one build at a time |
| Label | Tag on an agent used to route specific jobs to it |
| Workspace | Directory where a job's code/build files live during execution |
| Freestyle Project | UI-configured job type |
| Pipeline | Code-defined job type, written in a Jenkinsfile |
| Declarative Pipeline | Structured, opinionated Pipeline syntax |
| Scripted Pipeline | Full Groovy-based Pipeline syntax |
| Multibranch Pipeline | Auto-discovers branches/PRs in a repo, one job per branch |
| Organization Folder | Auto-discovers Multibranch Pipelines across an entire org |
| Shared Library | Reusable Pipeline code, shared across multiple Jenkinsfiles |
| Credentials Store | Secure storage for secrets, referenced by ID |
| RBAC | Role-Based Access Control — who can do what in Jenkins |

### Key UI Navigation Paths
```
Manage Jenkins → Tools                        → global tool installations
Manage Jenkins → Credentials                   → Credentials Store
Manage Jenkins → Nodes                         → agents/executors
Manage Jenkins → Security                      → authentication/authorization/CSRF
Manage Jenkins → Plugins                       → install/update/manage plugins
Manage Jenkins → System                        → global settings, email/SMTP config
Manage Jenkins → Manage and Assign Roles        → RBAC (Role-based Strategy plugin)
Manage Jenkins → Script Console                 → raw Groovy execution (admin only)
Job → Configure → Build Triggers                → webhook/poll/cron/remote trigger config
Job → Pipeline Syntax                           → generates correct Jenkinsfile step syntax
```

### Declarative Pipeline Skeleton
```groovy
pipeline {
    agent any
    options { timeout(time: 30, unit: 'MINUTES') }
    environment { KEY = 'value' }
    parameters { string(name: 'X', defaultValue: '', description: '') }
    stages {
        stage('Name') {
            when { branch 'main' }
            steps { echo 'step' }
        }
    }
    post {
        success { echo 'ok' }
        failure { echo 'failed' }
        always  { echo 'always runs' }
    }
}
```

### Parameterized Build Syntax
```groovy
parameters {
    string(name: 'APP_VERSION', defaultValue: '1.0.0', description: '')
    choice(name: 'ENV', choices: ['DEV','QA','PROD'], description: '')
    booleanParam(name: 'RUN_TESTS', defaultValue: true, description: '')
}
// access: params.APP_VERSION / params.ENV / params.RUN_TESTS
```

### Credentials Syntax
```groovy
withCredentials([
    usernamePassword(credentialsId: 'id', usernameVariable: 'U', passwordVariable: 'P'),
    string(credentialsId: 'token-id', variable: 'TOKEN'),
    file(credentialsId: 'kubeconfig-id', variable: 'KUBECONFIG')
]) {
    sh 'use $U $P $TOKEN'
}
```

### Shared Library Structure
```
lib-repo/
├── vars/step.groovy        → def call(...) { ... }   (callable as step(...))
├── src/org/pkg/Class.groovy → reusable Groovy classes
└── resources/...            → static files via libraryResource()

Jenkinsfile: @Library('lib-name@version') _
```

### Common Commands Quick Reference
```bash
sudo systemctl status jenkins            # check Jenkins service status
sudo cat /var/lib/jenkins/secrets/initialAdminPassword   # first-run password
docker build -t app:tag .                # build image
trivy image --exit-code 1 --severity HIGH,CRITICAL app:tag   # scan image
aws ecr get-login-password --region <r> | docker login ... # ECR auth
kubectl set image deployment/app app=img:tag -n ns
kubectl rollout status deployment/app -n ns --timeout=120s
kubectl rollout undo deployment/app -n ns
terraform fmt -check && terraform validate
terraform plan -out=tfplan && terraform apply -auto-approve tfplan
```

### Troubleshooting Quick Checks
```
Node offline?              → Manage Jenkins → Nodes → check status/log
Build stuck in queue?      → check label match + executor availability
Controller sluggish?       → confirm controller executors = 0
Checkout failing?          → verify credentialsId + repo URL + network
Webhook silent?            → check provider's webhook delivery log + Jenkins URL reachability
Disk full?                 → check Discard Old Builds + leftover Docker images
"Success" but app broken?  → add smoke test + verify rollout status was checked
```

### Security Practices Checklist
- [ ] CSRF protection enabled (never disabled)
- [ ] RBAC configured with least privilege
- [ ] Credentials Store used for all secrets (never hardcoded)
- [ ] IAM roles preferred over static AWS keys
- [ ] HTTPS enforced for the Jenkins UI
- [ ] Plugins kept updated, installed only from official sources
- [ ] Script Console access restricted to trusted admins
- [ ] Controller executors set to 0 in production

---

## 34. Beginner → Production Learning Roadmap

Recommended study order:

1. **Foundations** — What Jenkins is, CI/CD concepts (CI vs Delivery vs Deployment), Jenkins architecture (controller/agent/executor/label).
2. **Installation** — Set up Jenkins yourself on an EC2/Linux instance; get comfortable with the first-run setup.
3. **Freestyle Projects** — Build a few simple jobs by hand to internalize SCM, triggers, parameters, and post-build actions through the UI first.
4. **Pipelines (Declarative)** — Rewrite your Freestyle jobs as Jenkinsfiles; learn stages/steps/environment/parameters/post as code.
5. **Git/SCM Integration & Multibranch** — Move to real repositories, webhooks, and Multibranch Pipelines for PR validation.
6. **Credentials & Security Basics** — Learn the Credentials Store, `withCredentials`, and basic RBAC before touching anything with real secrets.
7. **Tools & Docker** — Configure Global Tools, then build/tag/scan/push Docker images from a pipeline.
8. **Distributed Builds (Agents)** — Move builds off the controller onto labeled static agents; understand executors and scaling.
9. **Kubernetes & Terraform** — Deploy to a real cluster with `kubectl`/EKS, and provision infrastructure safely with Terraform's plan → approve → apply flow.
10. **Complete CI/CD Pipeline Design** — Combine everything into one realistic build → test → scan → deploy → verify → notify pipeline.
11. **Shared Libraries** — Once you have 2+ similar pipelines, extract common logic into a Shared Library.
12. **Administration, Plugins, Backup/Recovery** — Learn to operate Jenkins itself: plugin management, system configuration, `JENKINS_HOME` backup/restore.
13. **Production Hardening** — Revisit security end-to-end: authentication, RBAC, CSRF, script approval, network/HTTPS, least privilege everywhere.
14. **Troubleshooting Practice** — Deliberately break things (agent disconnects, bad credentials, full disk) in a test environment and practice diagnosing them using the troubleshooting guide.
15. **Interview Preparation** — Review the interview questions bank and the cheat sheet, focusing on *why* decisions are made (trade-offs), not just definitions.

**What You Should Remember:** Learn Jenkins in the order real production systems are built — concepts, then a working single job, then pipelines-as-code, then scaling/security, then automation of the whole delivery chain. Trying to jump straight to Kubernetes/Terraform pipelines before understanding the basics of agents and credentials is the most common beginner mistake.

---

*End of handbook.*
