# Jenkins Handbook — Part 1: Fundamentals (Concepts, Setup, Freestyle Jobs & Pipelines)

> A complete, from-scratch, beginner-friendly guide to Jenkins fundamentals — what it is, how it's built, how to install it, and how to write your first jobs and pipelines. Every concept is explained twice: once in plain, everyday language, then again with full technical depth, examples, and practice material.

## Table of Contents
- [1. What Is Jenkins?](#1-what-is-jenkins)
- [2. CI/CD Fundamentals](#2-cicd-fundamentals)
- [3. Jenkins Architecture](#3-jenkins-architecture)
- [4. Installing Jenkins](#4-installing-jenkins)
- [5. First Login & Initial Setup](#5-first-login--initial-setup)
- [6. Freestyle Projects Deep Dive](#6-freestyle-projects-deep-dive)
- [7. Source Code Management (SCM)](#7-source-code-management-scm)
- [8. Build Triggers](#8-build-triggers)
- [9. Parameterized Builds](#9-parameterized-builds)
- [10. Post-Build Actions & Notifications](#10-post-build-actions--notifications)
- [11. Introduction to Jenkins Pipeline](#11-introduction-to-jenkins-pipeline)
- [12. Declarative vs Scripted Pipeline](#12-declarative-vs-scripted-pipeline)
- [13. Pipeline Syntax Deep Dive](#13-pipeline-syntax-deep-dive)
- [14. Multibranch Pipelines & Organization Folders](#14-multibranch-pipelines--organization-folders)

---

## 1. What Is Jenkins?

### In Plain English (Beginner Explanation)
Imagine you run a restaurant kitchen. Every time an order comes in, someone has to chop vegetables, cook the dish, plate it, and pass it to the waiter — the exact same steps, every single time, whether it's the first order of the day or the hundredth. Now imagine hiring a tireless kitchen assistant who never gets bored, never forgets a step, and never makes a typo — you teach it the steps once, and it repeats them perfectly forever. That's Jenkins. In software, the "order" is a code change, and the "steps" are building, testing, and delivering that code to users.

### Technical Definition
Jenkins is a free, open-source **automation server** — a piece of software that runs continuously on a server and automatically performs software delivery tasks (compiling code, running tests, packaging applications, deploying them) whenever triggered, instead of a person running each command by hand.

### How It Works — Step by Step
1. A **trigger** happens (someone pushes code, a schedule fires, or a person clicks a button).
2. Jenkins fetches the latest source code from your repository.
3. Jenkins runs whatever steps you've defined — compiling, testing, packaging, scanning, deploying.
4. Jenkins records the result (success/failure), keeps logs, and can notify people.
5. This entire cycle can repeat automatically, every single time new code shows up — with zero manual effort after initial setup.

### Why Jenkins Exists (The Problem It Solves)
Before automation tools like Jenkins existed, developers manually built and deployed software: SSH-ing into servers, copying files by hand, restarting services, hoping they didn't forget a step. This was:
- **Slow** — every release required a person's full attention for potentially hours.
- **Error-prone** — humans forget steps, especially at 2 AM during an "emergency" release.
- **Inconsistent** — one person's manual process rarely matches another's exactly.
- **Unscalable** — as a company grows from 5 releases a month to 50 releases a day, manual processes simply collapse.

### Why Use Jenkins Specifically? (Plugins & Open Source)
- **Free and open-source** — no license fees, and a massive global community actively maintaining it.
- **Plugin ecosystem** — thousands of official plugins connect Jenkins to almost any tool imaginable: Git, GitHub, GitLab, Docker, Kubernetes, Terraform, Slack, AWS, SonarQube, and more. Instead of building integrations from scratch, you usually just install a plugin.
- **Extensible and flexible** — works with virtually any programming language, operating system, or deployment target (cloud, on-prem, containers, bare metal).
- **Mature and battle-tested** — used across the software industry for well over a decade, meaning most problems you'll ever hit already have a documented solution somewhere.

### Benefits of Jenkins in Practice
| Benefit | What It Actually Means Day-to-Day |
|---|---|
| **Time-saving** | A 45-minute manual deploy process becomes a 3-minute automated one. |
| **Meets deadlines reliably** | The exact same steps run every time — no chance of a rushed manual mistake right before a deadline. |
| **Early bug detection** | Automated tests run on every single change, so a bug is caught within minutes of being introduced, not weeks later. |
| **Consistency** | The "it worked on my machine" problem disappears because the build/deploy steps are identical everywhere. |
| **Auditability** | Every build has a log, a timestamp, and a record of exactly what happened — useful for debugging and compliance. |

### When to Use Jenkins
Any time you have a repeatable process around building, testing, packaging, or deploying software that you don't want a human repeating manually, forever.

### Beginner Pitfall Corner
- **Pitfall**: Thinking Jenkins is only for "big companies" — even a solo developer benefits from automating tests/deploys on every commit.
- **Pitfall**: Assuming Jenkins does everything by itself out of the box — Jenkins is a coordinator; it relies on plugins and your own configuration/scripts to actually do useful work.
- **Pitfall**: Confusing Jenkins with the code itself — Jenkins doesn't write or fix your code; it automates *running* the processes around your code.

### Try It Yourself
Before moving on, write down (on paper, as the original course suggests) three repetitive tasks you currently do by hand in a software project — building, testing, deploying, sending status emails, etc. Keep this list; by the end of this handbook you'll know how to automate every one of them.

### Interview Questions
**Q: What is Jenkins, in one sentence?**
A: An open-source automation server that automates repetitive software build, test, and deployment tasks, most commonly as the engine behind CI/CD pipelines.

**Q: Why is Jenkins so widely adopted compared to writing custom automation scripts?**
A: Its plugin ecosystem means most integrations (Git, Docker, cloud providers, notification tools) already exist and are maintained by the community, so teams spend time configuring rather than building integrations from zero.

**What You Should Remember:** Jenkins removes manual, repetitive steps from software delivery. Its plugin ecosystem — not just its core — is what makes it fit into almost any tech stack.

---

## 2. CI/CD Fundamentals

### In Plain English (Beginner Explanation)
Think of CI/CD like an assembly line at a car factory. **CI** is like every worker checking their part fits correctly the *moment* it's attached, instead of waiting until the entire car is fully built to discover a part doesn't fit — by then, it's expensive and confusing to fix. **Continuous Delivery** means the finished car is always parked at the end of the line, fully ready to drive away — but a manager still has to sign paperwork before it leaves the lot. **Continuous Deployment** means the car drives itself off the lot the second it's ready, with no manager needed at all.

### Simple Definition
**CI/CD** stands for **Continuous Integration** and **Continuous Delivery/Deployment** — a set of practices that let teams build, test, and release software changes frequently, safely, and with as little manual effort as possible.

### Continuous Integration (CI) — In Depth
**Definition:** Developers merge their code changes into a shared repository frequently (often multiple times per day), and every merge automatically triggers an automated build and test cycle.

**Why frequent merging matters:** If ten developers each work alone for three weeks and then all merge at once, the resulting pile of changes is enormous, tangled, and nearly impossible to debug if something breaks. If those same ten developers merge small changes daily, any single merge that breaks something is easy to isolate — it's obviously "today's small change," not "three weeks of unknown changes."

**What CI actually automates:**
1. Compiling/building the code.
2. Running unit tests (and often integration tests).
3. Reporting pass/fail status back to the developer within minutes.

### Continuous Delivery (CD) — In Depth
**Definition:** After CI succeeds, the application is automatically packaged into a deployable, release-ready artifact (e.g., a Docker image or installable package) at all times — but an actual human decides *when* to push the button for production.

**Why keep a human in the loop:** Some organizations need a compliance sign-off, a business-timing decision (don't deploy during a big sales event), or simply extra caution for high-stakes systems (banking, healthcare, aviation software).

### Continuous Deployment — In Depth
**Definition:** Every change that passes all automated checks (build, tests, quality gates, security scans) is deployed straight to production automatically — no human clicks anything.

**Why this requires more maturity:** Since there's no human safety net right before production, your automated tests and quality gates must be extremely trustworthy. Teams usually build up to Continuous Deployment gradually, starting with Continuous Delivery first.

### Delivery vs Deployment — The One Sentence to Remember
**Delivery = always ready, human presses the button. Deployment = it deploys itself, no button needed.**

### The Full CI/CD Flow, Step by Step
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
Each box above becomes one **stage** in a Jenkins Pipeline — you'll build this exact flow, piece by piece, throughout this handbook.

### Real-World Analogy Recap Table
| CI/CD Term | Restaurant Analogy |
|---|---|
| CI | Every part of the dish is checked as it's cooked, not just at the very end. |
| Continuous Delivery | The finished plate sits ready at the pass — the head chef must approve before the waiter serves it. |
| Continuous Deployment | The plate goes straight to the table the moment it's cooked, no head chef check needed. |

### Common Mistakes
- Treating CI and CD as interchangeable buzzwords — they solve genuinely different problems.
- Skipping automated tests "just this once to save time" — this quietly defeats the entire purpose of CI and lets bugs slip through.
- Jumping straight to Continuous Deployment before your test suite is trustworthy enough to remove human review safely.
- Having no staging/QA environment at all — Continuous Delivery without a safe environment to validate in is much riskier.

### Debugging/Troubleshooting
- **Symptom:** "Our CI passes but bugs still reach production." → **Cause:** test coverage is too thin, or tests check the wrong things → **Fix:** audit what your automated tests actually verify; add tests for the specific bug categories reaching production.

### Best Practices
- Merge small, frequent changes rather than large, infrequent ones.
- Keep a staging environment that mirrors production as closely as possible for Continuous Delivery validation.
- Graduate to Continuous Deployment only after your automated gates have proven reliable over time.

### Interview Questions
**Q: Explain CI, Continuous Delivery, and Continuous Deployment, and how they differ.**
A: CI = frequent integration with automated build/test. Continuous Delivery = always deployable, human approves release. Continuous Deployment = fully automatic release, no human gate.

**Q: Why might a company choose Continuous Delivery over Continuous Deployment even if both are technically possible?**
A: Business, compliance, or risk-tolerance reasons — e.g., regulated industries, coordinated release timing, or simply wanting a final human sanity check before customer-facing changes go live.

**Q: What's the risk of skipping straight to Continuous Deployment?**
A: If automated tests/quality gates aren't mature enough, broken or insecure code can reach production instantly with no human catching it first.

**What You Should Remember:** CI catches problems early through frequent, tested integration. Continuous Delivery keeps you always release-ready with a human gate; Continuous Deployment removes that gate entirely once your automation is trustworthy enough.

---

## 3. Jenkins Architecture

### In Plain English (Beginner Explanation)
Picture that restaurant kitchen again. The **Controller** is the head chef — taking orders, deciding who cooks what, keeping the whole kitchen organized — but not necessarily cooking every single dish personally. **Agents** are the line cooks who actually do the cooking. An **Executor** is one cook's pair of free hands — one cook can only cook one dish at a time, so more executors means more dishes cooking simultaneously. A **Label** is a sticky note on a cook's uniform saying "grill specialist," so the head chef knows exactly who to send grill orders to. The **Workspace** is that cook's own cutting board and station, where that one dish actually gets assembled.

### Core Architecture Components
| Component | What It Is | Restaurant Equivalent |
|---|---|---|
| **Controller** | The central Jenkins server; hosts the UI, stores configuration, schedules jobs, manages agents. Shouldn't run heavy builds itself in production. | Head chef |
| **Agent (Node)** | A separate machine (physical, VM, container, Kubernetes pod) connected to the controller, which actually executes build steps. | Line cook |
| **Executor** | A "slot" that can run one build at a time. An agent with 4 executors runs up to 4 builds simultaneously. | A cook's two free hands |
| **Label** | A tag on an agent (e.g. `linux`, `docker`, `high-memory`) so pipelines can request "run this on an agent with label X." | Specialty sticker on a cook's uniform |
| **Queue** | Holds builds waiting for a free executor. | The order ticket rail |
| **Workspace** | A directory where a job's source code is checked out and build steps run — usually one per job. | The cook's own station |

### How It Works, in Detail
1. A build is triggered (manually, webhook, schedule) and enters the **queue**.
2. Jenkins searches for an agent (or the controller, if allowed) with a free **executor** matching any required **label**.
3. Jenkins checks out source code into a fresh **workspace** on that executor.
4. Build steps execute inside that workspace, in order.
5. Results (logs, artifacts, test reports) are recorded and displayed in **build history**.
6. The executor becomes free again, ready for the next queued build.

### Why This Separation Matters
As a team grows, so does build volume. Instead of overloading one server (the controller) with every single build, you add more **agents** — dedicated worker machines — and use **labels** to route specific kinds of work (e.g., Docker builds) to agents that actually have the right tools pre-installed. This is the foundation of Jenkins scaling.

### Jenkins UI Navigation
```
Jenkins Dashboard → Manage Jenkins → Nodes            → lists Controller + Agent nodes and executor counts
Job → Build History                                    → every past execution of that job
Job (currently running) → Console Output               → live/streamed logs of the current build
```

### Real-World Production Scenario
A company runs one Jenkins controller with three agents:
- Agent A, labeled `docker` — has Docker installed, handles image builds.
- Agent B, labeled `terraform` — has Terraform + AWS CLI, handles infrastructure jobs.
- Agent C, labeled `test` — extra CPU/memory, handles long-running test suites.

Pipelines specify `agent { label 'docker' }` (or `terraform`, or `test`) to guarantee they land on a machine with the right tools — instead of hoping a random agent happens to have what's needed.

### Extended Walkthrough: What Happens When You Click "Build Now"
1. Jenkins creates a new build number for the job (e.g., build #42).
2. The build enters the queue with any label requirements attached.
3. Jenkins's scheduler scans all connected, online agents for a match.
4. Once matched, a workspace directory (e.g., `/home/jenkins/workspace/my-job`) is prepared on that agent.
5. If SCM is configured, the code is checked out into that workspace first.
6. Each configured build step (or pipeline stage) runs sequentially inside that workspace.
7. Console output streams back to the controller in real time, viewable from the browser.
8. On completion, post-build actions/post blocks run, and the final status (SUCCESS/FAILURE/UNSTABLE) is recorded.

### Common Mistakes
- Running all builds directly on the controller — slows the entire Jenkins UI for every user and is a security risk (build steps then run with controller-level access to everything).
- Not using labels at all — jobs land on random agents that may lack required tools, producing confusing "command not found" errors.
- Setting far more executors on an agent than its CPU/memory can realistically support, causing builds to slow each other down or crash from resource exhaustion.

### Debugging/Troubleshooting
- **Symptom:** Build stuck "waiting for next available executor" → **Cause:** no online agent currently matches the required label, or all matching executors are busy → **Fix:** check Manage Jenkins → Nodes for label matches and current load; add capacity if genuinely needed.
- **Symptom:** Jenkins UI feels sluggish for everyone → **Cause:** builds running directly on the controller → **Fix:** set the controller's executor count to 0 and move workloads to agents.

### Best Practices
- Keep the controller build-free in production; it should orchestrate, not execute.
- Assign labels deliberately, based on actual installed tooling, not guesswork.
- Size executor counts to match real agent CPU/memory capacity — don't just pick a big number.
- Regularly review Manage Jenkins → Nodes to spot overloaded or idle agents.

### Interview Questions
**Q: What's the difference between the Controller and an Agent?**
A: The Controller coordinates — UI, scheduling, configuration storage. Agents actually execute build steps. Production setups typically keep the Controller build-free.

**Q: What is an Executor, and how does it relate to concurrency?**
A: An executor is a single "slot" that can run one build at a time; the number of executors on an agent determines how many builds that agent can run simultaneously.

**Q: How would you ensure a Docker-based pipeline always runs on an agent that actually has Docker installed?**
A: Assign a `docker` label to that agent, then specify `agent { label 'docker' }` in the pipeline so Jenkins only schedules it there.

**What You Should Remember:** Controller = brain/coordinator. Agent = worker executing builds. Executor = one concurrent build slot. Label = routing mechanism. Workspace = the job's working directory during a build.

---

## 4. Installing Jenkins

### In Plain English (Beginner Explanation)
Before you can cook anything, you need a kitchen (a server), a working stove (Java — since Jenkins is a Java application and won't run without it), and the front door unlocked so customers (you, in your browser) can actually walk in (an open network port). This section is literally about building that kitchen from an empty room, using an AWS EC2 instance as the "building."

### Prerequisites
- A Linux server — an AWS EC2 instance is a common, realistic, and genuinely production-relevant choice.
- **Java (JDK)** installed, since Jenkins runs on the Java Virtual Machine (JVM) and simply won't start without a compatible version.
- Correct **inbound security group / firewall rules** so you can reach Jenkins's web UI (default port `8080`) and SSH into the box (port `22`).

### Full Installation Walkthrough
```
1. Launch an EC2 instance (Ubuntu/Amazon Linux). Size depends on expected load
   (t3.medium or larger is a reasonable starting point for real use, not just a demo).

2. Configure the AWS Security Group:
   - Allow inbound TCP 22 (SSH) from your IP only (never 0.0.0.0/0 for SSH in production)
   - Allow inbound TCP 8080 (Jenkins UI) from your IP or your team's IP range

3. SSH into the instance:
   ssh -i your-key.pem ubuntu@<public-ip>

4. Update packages and install Java:
   sudo apt update
   sudo apt install openjdk-17-jdk -y
   java -version        # confirm the installed version

5. Add the Jenkins package repository and install Jenkins (Debian/Ubuntu example):
   curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
     /usr/share/keyrings/jenkins-keyring.asc > /dev/null
   echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
     https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
     /etc/apt/sources.list.d/jenkins.list > /dev/null
   sudo apt-get update
   sudo apt-get install jenkins -y

6. Start Jenkins and enable it to survive reboots:
   sudo systemctl start jenkins
   sudo systemctl enable jenkins
   sudo systemctl status jenkins     # confirm it's "active (running)"

7. Open a browser to:
   http://<your-ec2-public-ip>:8080
```

### Why Each Step Matters
- **Java version compatibility** is one of the single most common "Jenkins won't start" issues for beginners — always check the Jenkins release notes for the currently supported Java version before installing.
- **Security group rule for port 8080** is easy to forget — you can install Jenkins perfectly and still be unable to reach it if this rule is missing, which confuses many beginners into thinking the install itself failed.
- **Enabling the systemd service** (`systemctl enable`) ensures Jenkins automatically restarts if the server reboots — without this, an unrelated server reboot silently takes your Jenkins offline until someone notices and manually starts it again.

### Troubleshooting: Jenkins Port Issues
If `http://<server-ip>:8080` doesn't load:
1. Confirm Jenkins is actually running: `sudo systemctl status jenkins`.
2. Confirm the security group allows inbound port 8080 from your current IP.
3. Confirm nothing else is already bound to port 8080: `sudo lsof -i :8080`.
4. Check the OS-level firewall (e.g., `ufw status`) isn't blocking the port separately from the AWS security group.
5. If Jenkins crashed on startup, check its logs: `sudo journalctl -u jenkins -n 100 --no-pager`.

### Common Mistakes
- Forgetting to open port 8080 in the Security Group, then assuming installation itself failed.
- Installing an incompatible Java version for the specific Jenkins release.
- Not enabling the Jenkins systemd service, so it doesn't survive a reboot.
- Opening SSH (port 22) to the entire internet (`0.0.0.0/0`) instead of restricting it to known IPs.

### Best Practices
- Restrict both SSH and the Jenkins UI port to known IP ranges, never wide open to the internet.
- Take a fresh EC2/AMI snapshot right after a clean, working install — useful as a known-good recovery point.
- Document (or script, via Terraform/CloudFormation) your exact install steps so a fresh Jenkins server can be rebuilt quickly if needed.

### Interview Questions
**Q: What must be true for Jenkins to even start running on a server?**
A: A compatible JDK must be installed, since Jenkins is a Java application; without it, the Jenkins service will fail to start.

**Q: You installed Jenkins successfully but can't reach it in your browser — what's your first troubleshooting step?**
A: Check that the security group/firewall actually allows inbound traffic on port 8080 from your IP, since a successful install doesn't guarantee network reachability.

**What You Should Remember:** Jenkins install = compatible Java + Jenkins package + open port 8080 + start/enable the systemd service. Most first-time failures are Java mismatches or a closed security group port — rarely Jenkins itself.

---

## 5. First Login & Initial Setup

### In Plain English (Beginner Explanation)
The first time you walk into a brand-new kitchen, you unlock the front door with a key someone left for you (the initial admin password), stock the shelves with basic ingredients everyone needs (suggested plugins), and hire yourself as the permanent head chef (create a real admin account) instead of relying on a temporary guest pass forever.

### Step-by-Step First-Run Setup
1. **Unlock Jenkins**: On first start, Jenkins generates a random admin password stored in a file on the server. Retrieve it with:
   ```
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```
   Paste this value into the browser's "Unlock Jenkins" screen.

2. **Install Suggested Plugins**: Jenkins offers a curated default bundle (Git support, Pipeline support, credentials handling, and more). For most learners and most production setups, this is the right starting choice — you can always add/remove individual plugins later.

3. **Create the First Admin User**: Replace the temporary unlock flow with a real username and password. This is a basic security hygiene step — never leave the initial-password-based access as your long-term login method.

4. **Instance Configuration**: Confirm the Jenkins URL Jenkins uses to refer to itself. This matters more than it seems — webhook callback URLs, email notification links, and build-status links all depend on this being correct.

### Understanding the "Master Node" (Controller-as-Agent)
Right after installation, the Controller itself acts as a build agent too — it will happily run jobs directly on itself unless you explicitly configure and prefer dedicated agents. This is perfectly fine while learning, but as covered in Sections 3 and later production sections, real setups eventually move build workloads off the controller entirely.

### Post-Installation Configuration Review
It's worth deliberately reviewing these areas right after setup, rather than assuming defaults are fine:
```
Manage Jenkins → System        → confirm Jenkins URL and admin email are correct
Manage Jenkins → Plugins       → confirm the expected plugin list actually installed successfully
Manage Jenkins → Security      → confirm authentication is actually configured (not left wide open to anonymous users)
```

### Extended Walkthrough: Creating Your Very First Job
As a hands-on first exercise:
```
1. Dashboard → New Item
2. Enter a name, e.g. "hello-world"
3. Select "Freestyle project" → OK
4. Under Build Steps → Add build step → Execute shell
5. Enter: echo "Hello from Jenkins!"
6. Save, then click "Build Now"
7. Click the resulting build number → Console Output to see your message printed
```
This tiny exercise confirms your entire installation — Java, Jenkins service, plugins, and job execution — is working end-to-end before you move on to anything more complex.

### Common Mistakes
- Leaving the default admin/initial-password combination in place long-term instead of creating a proper account.
- Skipping suggested plugins entirely, then discovering core features (like Git support) are missing later and having to backtrack.
- Not correcting the Jenkins URL setting, leading to broken webhook/notification links discovered much later, often during an actual incident.

### Best Practices
- Immediately create a real, individually-named admin account per person — never share one generic login among a team.
- Revisit `Manage Jenkins → Security` early to plan proper authentication/authorization before opening Jenkins up to a wider team.
- Confirm the Jenkins URL setting is the address your team and any external systems (GitHub webhooks) will actually use to reach it.

### Interview Questions
**Q: Where does Jenkins store its initial admin password, and why is a file-based approach used?**
A: In `/var/lib/jenkins/secrets/initialAdminPassword` on the server — this ensures only someone with actual server access (not just anyone hitting the web UI) can complete the very first unlock step.

**Q: Why does the Jenkins URL system setting matter beyond just cosmetic branding?**
A: It's embedded in webhook callback URLs, email notification links, and build status links — an incorrect value can silently break integrations that otherwise look correctly configured.

**What You Should Remember:** First-run setup = unlock with the generated password → install plugins → create a real admin user → confirm the system URL. Do this carefully once; it's the foundation everything else builds on.

---

## 6. Freestyle Projects Deep Dive

### In Plain English (Beginner Explanation)
A Freestyle project is like following a recipe by filling in blanks on a printed recipe card — pick your ingredients from dropdown menus, tick some boxes, and you're done cooking. It's very beginner-friendly, but if you want a recipe that says "if the sauce is too thin, add more flour" or "do these two things at the same time," a printed card simply can't express that kind of logic — which is exactly where Pipelines (actual written code, covered starting in Section 11) take over.

### Simple Definition
A **Freestyle project** is Jenkins's original, general-purpose job type — configured entirely through UI forms rather than code. It's the simplest way to get started, though Pipelines are the production-standard approach today for anything beyond trivial tasks.

### Jenkins UI Navigation
```
Dashboard → New Item → enter job name → select "Freestyle project" → OK
```

### Key Configuration Sections Explained One by One
| Section | Purpose | Beginner Tip |
|---|---|---|
| **Description** | Free-text notes shown on the job's page. | Always fill this in — a job named "deploy2" with no description is a mystery to your future self. |
| **Discard Old Builds** | Automatically deletes old build history/logs after N builds or days. | Turn this on immediately — unlimited history quietly fills up server disk over months. |
| **This project is parameterized** | Enables input parameters at build time. | See [Section 9](#9-parameterized-builds) for the full deep dive. |
| **Throttle builds** | Limits how many times a job can run within a time window. | Useful to prevent one misbehaving trigger from hammering the system with builds. |
| **Execute concurrent builds if necessary** | Allows multiple runs of the *same* job in parallel. | Only enable this if your build steps are actually safe to run simultaneously (e.g., don't both write to the same file). |
| **Source Code Management** | Where to pull code from. | See [Section 7](#7-source-code-management-scm). |
| **Build Triggers** | What causes the job to run automatically. | See [Section 8](#8-build-triggers). |
| **Environment** | Environment variables, workspace cleanup, secret injection, console timestamps. | Enabling timestamps makes debugging slow builds much easier. |
| **Build Steps** | The actual commands/tasks to execute. | Most commonly "Execute shell." |
| **Post-build Actions** | What to do after the build finishes. | See [Section 10](#10-post-build-actions--notifications). |

### Build Steps: Executing Shell Commands
The most common Freestyle build step is **"Execute shell"**, where you write ordinary shell/bash commands exactly as you would type them into a terminal:
```bash
git clone https://github.com/example/app.git
cd app
mvn compile
./run.sh
```
Jenkins runs these line by line, inside the job's dedicated workspace directory, and captures every bit of output into the Console Output log.

### Build History and Console Output
Every execution of a job is recorded with an incrementing build number. Clicking into any specific build shows:
- **Console Output** — the full, streamed log of that exact run; this is always the first place to check when something fails.
- Build duration, who or what triggered it (a person, a webhook, a schedule), and any artifacts produced.
- A colored status indicator (blue/green for success historically, red for failure, yellow for unstable) at a glance.

### Extended Walkthrough: Building a Slightly Realistic Freestyle Job
```
1. New Item → name it "build-and-test-app" → Freestyle project
2. Source Code Management → Git → paste your repo URL → (add credentials if private)
3. Build Triggers → check "Poll SCM" → schedule: H/5 * * * *  (checks every ~5 minutes)
4. Build Steps → Add build step → Execute shell:
   mvn clean compile
   mvn test
5. Post-build Actions → Add post-build action → Publish JUnit test result report
   → Test report XMLs: **/target/surefire-reports/*.xml
6. Save → Build Now → watch Console Output stream live
```
This single job now automatically pulls code, compiles it, runs tests, and records results — a miniature version of real CI.

### Why It Matters
Even though Pipelines are the modern standard for anything with real complexity, Freestyle projects are how most people first genuinely understand *what* Jenkins actually does at each step — checkout, build, test, notify — before layering on Pipeline-as-code abstractions on top of the same underlying ideas.

### Common Mistakes
- Not enabling "Discard Old Builds," letting disk usage grow unbounded over months of daily builds — this is one of the most common real-world "Jenkins disk full" root causes.
- Manually editing UI-configured jobs repeatedly instead of migrating to a Pipeline once real logic/complexity is needed — this becomes unmaintainable and, critically, isn't version-controlled alongside your code.
- Forgetting that Freestyle job configuration lives only inside Jenkins itself — if Jenkins is lost without a backup, so is your entire job configuration.

### Debugging/Troubleshooting
- **Symptom:** Build fails immediately with no useful output → **Fix:** check Console Output first, always — it's the single most informative diagnostic tool for any Jenkins job.
- **Symptom:** Job runs but produces no test report → **Fix:** confirm the "Test report XMLs" glob pattern actually matches where your test tool writes its report files.

### Best Practices
- Use Freestyle only for very simple jobs or quick one-off experiments; move anything with real logic to a Pipeline/Jenkinsfile.
- Always set Discard Old Builds as a default habit on every job you create.
- Add a meaningful description to every job.

### Interview Questions
**Q: What's the main limitation of Freestyle projects compared to Pipelines?**
A: Freestyle configuration lives only in Jenkins's UI — it isn't version-controlled, can't express complex logic (loops, conditionals, parallel execution) cleanly, and isn't portable across projects the way a Jenkinsfile is.

**Q: Why is "Discard Old Builds" important even for a simple job?**
A: Without it, every single build's logs and artifacts accumulate indefinitely, and over months this can silently exhaust disk space on the Jenkins server, causing unrelated failures across all jobs.

**What You Should Remember:** A Freestyle project is a UI-configured job — the easiest entry point to learn core Jenkins concepts, but production teams migrate to code-based Pipelines for anything beyond trivial, one-off tasks.

---

## 7. Source Code Management (SCM)

### In Plain English (Beginner Explanation)
SCM integration is simply telling Jenkins, "here is the address of the grocery store where the ingredients (your code) are kept, and here's my membership card (credentials) to actually get in the door." Without this, Jenkins has no idea where your code even lives, and can't build anything at all.

### Simple Definition
SCM configuration tells Jenkins **where your code lives** and how to pull it before running any build steps.

### How It Works
In a Freestyle job, the SCM section (usually set to **Git**) asks for:
- **Repository URL** (e.g., `https://github.com/org/repo.git`)
- **Credentials** (required if the repository is private — see the Credentials section in Part 2 of this handbook)
- **Branch to build** (e.g., `main`, `*/main`, or a wildcard pattern)

When the build runs, Jenkins clones or checks out that exact branch into the job's workspace before any build steps execute.

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
- `git branch: 'main'` — specifies which branch to pull; without this, Jenkins may default to whatever the repo's default branch is.
- `url: '...'` — the exact repository location.
- `credentialsId: 'github-creds'` — references a credential stored securely in Jenkins (never a raw username/password typed directly into the file).

### Shallow Clone, Polling vs Webhooks, Branch Discovery — In Depth
- **Shallow clone**: fetches only the latest commit's snapshot instead of the entire repository history — much faster for large, long-lived repos, at the cost of not having the full `git log` available inside the workspace during the build.
- **Polling SCM** vs **Webhooks**: polling means Jenkins periodically checks the repo for new commits on a schedule (wastes resources, introduces delay); webhooks mean the Git provider actively notifies Jenkins the instant a push happens (faster, more efficient, and the production-preferred approach whenever Jenkins is network-reachable from the Git provider).
- **Branch Discovery / Multibranch**: instead of hardcoding one specific branch, Jenkins can automatically discover and build every branch — and even pull requests — in a repository. Covered fully in [Section 14](#14-multibranch-pipelines--organization-folders).

### Extended Example: Private Repository with SSH
```groovy
stage('Checkout via SSH') {
    steps {
        git branch: 'main',
            url: 'git@github.com:example/private-app.git',
            credentialsId: 'github-ssh-key'
    }
}
```
Here, `credentialsId` points to an **SSH Username with Private Key** credential rather than a username/password pair — a common pattern for private repositories accessed over SSH rather than HTTPS.

### Common Mistakes
- Using "Poll SCM" with a very frequent schedule (e.g., every minute) across many jobs — this hammers the Git server unnecessarily; a webhook is almost always the better production choice.
- Forgetting to attach credentials to a private repository, causing checkout to fail with an authentication error that can look confusing at first glance.
- Hardcoding a specific commit hash instead of a branch name, silently freezing the pipeline to always build the exact same old code.

### Debugging/Troubleshooting: Git Checkout Failures
- **Symptom:** "Permission denied" / "repository not found" → **Cause:** missing or incorrect credentials, or a wrong repo URL → **Fix:** verify the `credentialsId` matches a valid, currently-working credential in Manage Jenkins → Credentials.
- **Symptom:** Checkout hangs indefinitely → **Cause:** the agent has no network access to the Git host (firewall, DNS, or routing issue) → **Fix:** verify connectivity/firewall rules from that specific agent, not just the controller.
- **Symptom:** Checkout succeeds but the wrong code shows up → **Cause:** wrong branch specified, or a stale cached workspace → **Fix:** confirm the branch parameter, and consider "Delete workspace before build starts" to rule out stale files.

### Best Practices
- Prefer webhook-based triggers over polling wherever network connectivity allows it.
- Use shallow clones for large repositories where full history isn't actually needed during the build.
- Reference credentials by ID only — never embed raw secrets in a Jenkinsfile.

### Interview Questions
**Q: What's the difference between Poll SCM and a webhook trigger?**
A: Poll SCM has Jenkins actively check the repository on a schedule for changes (introduces delay, wastes resources on empty checks); a webhook has the Git provider push a notification to Jenkins the instant a change happens (near-instant, more efficient).

**Q: Why use a shallow clone?**
A: It fetches only the latest snapshot rather than full history, significantly speeding up checkout for large repositories where full git history isn't needed by the build itself.

**What You Should Remember:** SCM configuration = where code comes from + which branch + which credentials. Webhooks (event-driven) are production-preferred over polling (delayed, resource-wasteful) wherever feasible.

---

## 8. Build Triggers

### In Plain English (Beginner Explanation)
A build trigger is the "doorbell" that tells Jenkins "go start cooking now." A webhook is like a smart doorbell that rings the instant someone actually arrives (a code change happens). Polling is like walking to the front door every few minutes just to check whether someone's there — it works, but it's slower and more tiring than a doorbell that alerts you instantly.

### Types of Triggers
| Trigger | What It Does |
|---|---|
| **Trigger builds remotely** | Starts a build via an API call/URL using a security token — useful for external systems to programmatically kick off a Jenkins job. |
| **Build after other projects are built** | Chains jobs together — this job runs automatically once a specified upstream job finishes (optionally, only on a specific result like SUCCESS). |
| **Build periodically** | Runs on a fixed schedule using Cron syntax, regardless of whether the code actually changed (e.g., a nightly full regression suite). |
| **GitHub hook trigger for GITScm polling** | Builds automatically the instant GitHub sends a push-event webhook — the modern, event-driven, low-latency approach. |
| **Poll SCM** | Jenkins checks the repository on a Cron-like schedule for new commits, only building if something actually changed. |

### Cron Syntax Basics
Jenkins uses standard 5-field Cron syntax: `MINUTE HOUR DAY MONTH DAY_OF_WEEK`
```
H 2 * * *      → run once daily, sometime around 2 AM (the "H" lets Jenkins spread scheduled load automatically across many jobs)
H/15 * * * *   → run roughly every 15 minutes
0 9 * * 1-5    → run at exactly 9:00 AM, Monday through Friday only
```

### Why the Choice of Trigger Matters
Choosing the right trigger affects both speed (how fast a change actually gets built) and resource usage (load placed on Git servers and Jenkins itself). Webhooks are near-instant and efficient; polling is delayed and comparatively wasteful, but is sometimes the only option available — for instance, if Jenkins sits on a private network the Git provider genuinely cannot reach.

### Real-World Production Scenario
A team's Jenkins instance lives inside a private VPC with no public endpoint, so GitHub cannot send it a webhook directly. Their options are: (1) expose a properly secured public endpoint just for webhook delivery, (2) use an intermediary/relay service to forward the event inward, or (3) fall back to Poll SCM with a reasonable interval as a pragmatic compromise until a better network path exists.

### Extended Example: Chaining Jobs (Upstream/Downstream)
```
Job "build-app" → Post-build Actions → "Build other projects" → enter "deploy-app"
   → check "Trigger only if build is stable"
```
This means `deploy-app` automatically runs immediately after `build-app` succeeds — but never runs if `build-app` fails or is merely unstable, preventing broken code from being deployed automatically.

### Common Mistakes
- Relying solely on Poll SCM in a modern setup where webhooks are actually available — adds unnecessary delay and unnecessary load on the Git server.
- Not securing the "trigger build remotely" token — anyone who obtains the URL and token can trigger builds, potentially maliciously or accidentally.
- Setting an overly aggressive Cron schedule (e.g., polling every minute across dozens of jobs), overwhelming both Jenkins and the Git provider.

### Debugging/Troubleshooting: Webhook Not Triggering
1. Check **GitHub repo → Settings → Webhooks** for delivery attempts and their response codes.
2. Confirm Jenkins's configured URL (Manage Jenkins → System) is actually publicly reachable from GitHub's servers.
3. Confirm the relevant plugin (e.g., the GitHub plugin) is installed, and that the specific job has "GitHub hook trigger for GITScm polling" checked.
4. Test manually by re-sending a webhook delivery from GitHub's UI and watching for a response.

### Best Practices
- Prefer webhooks whenever network reachability allows it; reserve polling for genuinely constrained network setups.
- Treat remote-trigger tokens as secrets — never commit them to a public repository or documentation.
- Use upstream/downstream job chaining (with "only if stable" conditions) to build safe, automatic pipelines out of multiple simpler jobs when not yet using full Pipeline-as-code.

### Interview Questions
**Q: Why are webhooks generally preferred over Poll SCM in production?**
A: Webhooks trigger builds instantly upon an actual code change and don't waste resources checking when nothing changed, whereas polling introduces delay and periodic, often unnecessary, load.

**Q: When might you still need to use Poll SCM despite its downsides?**
A: When Jenkins genuinely cannot receive inbound webhook calls — e.g., it sits on a private network the Git provider can't reach, and no relay/tunnel solution has been set up yet.

**What You Should Remember:** Webhooks = instant, event-driven, production-preferred. Polling = periodic check, slower, reserved for cases where webhooks genuinely aren't possible. Upstream/downstream chaining links dependent jobs together safely.

---

## 9. Parameterized Builds

### In Plain English (Beginner Explanation)
A parameterized build is like a fast-food ordering kiosk instead of a single fixed meal. Instead of Jenkins always doing exactly the same thing, it now asks you questions first — "Which environment? Which version? Run tests or skip them?" — the same way a kiosk asks "small, medium, or large?" before making your order.

### Simple Definition
A parameterized build is a Jenkins job that asks the user for input — like a form — before it runs, instead of running identically every single time.

### How It Works
When "This project is parameterized" is enabled, clicking "Build Now" is replaced with **"Build with Parameters"**, which shows a form. The values entered are injected as variables that the build steps or Jenkinsfile can read.

### Why It Matters
Without parameters, you'd need a separate job for every environment or variation (a DEV job, a QA job, a PROD job...). Parameters let one single job handle all of them by simply asking "which one this time?"

### When to Use Parameterized Builds
- Deploying to different environments (DEV/QA/PROD)
- Choosing an application version or Docker image tag to deploy
- Choosing a target region or deployment type
- Any run-time decision that genuinely requires a human's input

### Parameter Types, In Detail
| Type | Purpose | Example |
|---|---|---|
| **String** | Free-text input | Application version: `1.2.5` |
| **Choice** | Dropdown of fixed options | Environment: `DEV`, `QA`, `PROD` |
| **Boolean** | Checkbox (true/false) | Run tests? |
| **Password** | Masked input (still not a substitute for real Credentials) | A short-lived token |
| **File** | Upload a file for use during the build | A config override file |

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
- `choice(...)` — a dropdown; `choices` lists the allowed values, first entry is the default shown.
- `string(...)` — a free-text box with a `defaultValue`.
- `booleanParam(...)` — a checkbox; `defaultValue: true` means it's checked by default.
- `params.X` — how you read a parameter's value anywhere in the pipeline.
- `when { expression { ... } }` — makes an entire stage conditional based on a parameter's value.

### Extended Example: Adding a Docker Image Tag Parameter
```groovy
parameters {
    string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Docker image tag to deploy')
    choice(name: 'REGION', choices: ['us-east-1', 'us-west-2', 'eu-west-1'], description: 'AWS region to deploy to')
}
stages {
    stage('Deploy') {
        steps {
            sh "aws ecs update-service --region ${params.REGION} --service myapp --force-new-deployment"
        }
    }
}
```
This lets one job deploy any image tag to any supported region, purely based on what's selected at build time — no duplicated jobs per region.

### Real-World Production Scenario
One `deploy-app` job replaces three separate DEV/QA/PROD jobs entirely. It asks "which environment?" and "which version?", then selects the right credentials, config files, and target servers based on those answers — one job, multiple destinations, zero duplicated logic.

### Common Mistakes
- No default values set → automated triggers (webhooks/cron) fail outright, since nobody is present to fill in the form when the build starts unattended.
- Putting real secrets into `string`/`password` parameters instead of using Jenkins Credentials — this exposes them in build history and parameter logs.
- Not validating parameter values inside the pipeline logic, assuming the dropdown alone guarantees safety (a malicious or buggy remote-trigger call can still pass unexpected values via the API).

### Debugging/Troubleshooting
- **Symptom:** Automated trigger fails on a missing parameter → **Fix:** add sensible default values to every single parameter, without exception.
- **Symptom:** `params.X` reads as null/empty → **Fix:** check the exact parameter name (case-sensitive) matches the declaration precisely.
- **Symptom:** A Choice parameter shows outdated options after a Jenkinsfile change → **Fix:** parameters defined in a Jenkinsfile only take effect after at least one build has run with the new definition; trigger one build to refresh the form.

### Best Practices
- Prefer `Choice` over `String` wherever the valid set of values is known in advance — this prevents typos entirely.
- Never use Password parameters for real secrets — use Jenkins Credentials + `withCredentials` (covered in Part 2 of this handbook) instead.
- Use clear, uppercase, descriptive parameter names (`APP_VERSION`, not `v` or `x`).

### Interview Questions
**Q: What's the difference between a String and Password parameter in Jenkins?**
A: Both accept text input, but Password parameters mask the value in the UI and try to hide it in logs — though for real secrets, Jenkins Credentials + `withCredentials` is the recommended, safer approach.

**Q: How do you access a parameter's value inside a Jenkinsfile?**
A: Through the `params` object, e.g. `params.ENVIRONMENT`.

**Q: What happens if a parameterized job is triggered automatically (e.g., by a webhook) with no defaults set?**
A: The build typically fails or uses empty/null values for any parameter without a default, since there's no human present to fill in the form — this is why every parameter should always have a sensible default.

**What You Should Remember:** Parameterized builds turn one static job into a flexible, reusable one by collecting input at run time; access values via `params.X`; always set defaults so automated triggers don't break.

---

## 10. Post-Build Actions & Notifications

### In Plain English (Beginner Explanation)
Post-build actions are like the cleanup and follow-up crew after a big event — packing away leftovers (archiving artifacts), writing a report card on how the event went (test reports), and calling the relevant people to let them know it's done (notifications) — regardless of whether the event was a smashing success or a total disaster.

### Simple Definition
Post-build actions define **what Jenkins does after a build finishes** — archiving results, publishing reports, or notifying people — and can behave differently depending on the build's final status (success, failure, unstable).

### Common Post-Build Actions
- **Archive the artifacts** — saves build outputs (e.g., a `.jar`, `.zip`, or Docker image manifest) so they're downloadable later, even long after the build finished.
- **Publish JUnit test result report** — parses test XML output so Jenkins shows pass/fail counts and trends over time, right on the job's page.
- **E-mail Notification** — sends an email on build completion, commonly configured to fire only on failure or "unstable" (tests failed but the build itself succeeded) status.

### Installing the Email Extension Plugin
The core email feature is fairly basic; the **Email Extension Plugin** enables richer, templated notifications — conditional recipients, HTML templates, attaching logs directly to the email.
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
- `post { }` — a special block that runs after all stages complete, regardless of the outcome.
- `success { }` / `failure { }` / `always { }` — conditions determining exactly when each sub-block runs.
- `mail to: ...` — sends an email; `env.JOB_NAME`, `env.BUILD_NUMBER`, `env.BUILD_URL` are Jenkins-provided environment variables giving useful context about the current run.
- `archiveArtifacts` — saves matching files as downloadable build artifacts; `fingerprint: true` lets Jenkins track that exact file's usage across other jobs too.
- `junit` — parses test report XML files and shows them as a pass/fail summary directly on the build page, with trend graphs over time.

### Extended Example: Conditional Notifications with Recovery Alerts
```groovy
post {
    failure {
        mail to: 'team@example.com', subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}", body: "See ${env.BUILD_URL}"
    }
    fixed {
        mail to: 'team@example.com', subject: "RECOVERED: ${env.JOB_NAME} is passing again", body: "Previous build failed; this one succeeded: ${env.BUILD_URL}"
    }
}
```
`fixed` is a special post condition that only fires when the *previous* build failed but *this* one succeeded — perfect for a "we're back to green" notification without spamming success emails on every single healthy run.

### Common Mistakes
- Sending success emails on every single build — leads to notification fatigue, and important failure alerts start getting ignored along with the noise.
- Forgetting `always` for archiving artifacts/test reports — if only placed under `success`, a failed build silently loses its logs and artifacts, making it much harder to debug exactly what went wrong.
- Not configuring SMTP correctly before relying on email notifications, discovering the gap only when a critical failure alert silently never arrives.

### Best Practices
- Notify on failure and on recovery ("build is green again"), not on every single success.
- Always archive test reports (`junit`) so failure trends are visible over time, not just the outcome of the latest run.
- Test your email/notification configuration deliberately (e.g., force a test failure) before relying on it for real incidents.

### Interview Questions
**Q: What's the Pipeline equivalent of Freestyle's post-build action section?**
A: The `post { }` block, with conditional sub-blocks like `success`, `failure`, and `always`.

**Q: Why is it a common mistake to send a notification email on every successful build?**
A: It causes notification fatigue — team members start ignoring the channel entirely, meaning a genuinely important failure alert can get lost in the noise.

**What You Should Remember:** Post-build actions run after the build finishes (success/failure/always) — used for archiving artifacts, publishing test reports, and sending notifications. `post { }` in a Jenkinsfile is the Pipeline equivalent of Freestyle's post-build action section.

---

## 11. Introduction to Jenkins Pipeline

### In Plain English (Beginner Explanation)
If a Freestyle project is a recipe card, a Pipeline is a full cookbook chapter written in a real programming language — one that can say "if the sauce is too thin, add more flour" (conditional logic) or "chop all the vegetables at once using three cooks" (parallel steps). It's kept in the same folder as your ingredients (your source code repository), so anyone can read exactly how the dish is made, and see its exact history of changes.

### Simple Definition
A **Pipeline** is a Jenkins job defined as **code** (in a file called a `Jenkinsfile`) instead of clicked-through UI forms. It describes the entire build/test/deploy process as a sequence of stages.

### Why It Matters
Unlike Freestyle jobs, a Jenkinsfile lives inside your source repository, alongside your application code. That means:
- It's **version-controlled** — you can see its history, review proposed changes, and roll back if a change breaks something.
- It's **portable** — the same pipeline definition can be copied/reused across similar projects.
- It supports **complex logic** — loops, conditionals, parallel execution, reusable functions — that Freestyle's UI simply cannot express.
- It's **reviewable** — teammates can review pipeline changes the exact same way they review application code, via pull requests.

### How It Works
Jenkins reads the `Jenkinsfile` (usually from the root of your Git repository) and executes it stage by stage: checkout code → build → test → deploy → notify, exactly as written.

### When to Use Pipelines
Essentially always, for any real production CI/CD — Pipelines are the modern standard. Freestyle remains useful only for very simple, one-off, throwaway tasks.

### Extended Example: A Minimal First Pipeline
```groovy
pipeline {
    agent any
    stages {
        stage('Hello') {
            steps {
                echo 'Hello from a Jenkins Pipeline!'
            }
        }
    }
}
```
Saved as a `Jenkinsfile` at the root of a repository, then referenced by a **Pipeline** job type (`New Item → Pipeline → Pipeline script from SCM → point at your repo`) — this is the code equivalent of the tiny Freestyle exercise from Section 5, but now version-controlled from day one.

### Common Mistakes
- Writing complex Groovy logic before understanding basic Declarative structure — leads to confusing, hard-to-debug pipelines early on.
- Keeping the Jenkinsfile only inside Jenkins's own job configuration instead of in the actual source repository — this defeats the entire point of version control.

### Best Practices
- Always store the Jenkinsfile in the same repository as the code it builds.
- Start with a minimal Declarative Pipeline and add complexity incrementally, testing after each addition.

### Interview Questions
**Q: What's the core advantage of a Jenkinsfile over a Freestyle job?**
A: It's version-controlled code stored alongside the application, reviewable like any other code change, portable across projects, and capable of expressing real logic that Freestyle's UI cannot.

**What You Should Remember:** A Pipeline is Jenkins-as-code via a Jenkinsfile — version-controlled, reusable, and capable of expressing real logic, unlike Freestyle's UI-only configuration.

---

## 12. Declarative vs Scripted Pipeline

### In Plain English (Beginner Explanation)
Declarative Pipeline is like a fill-in-the-blanks cookbook template — very structured, and it's genuinely hard to write something confusing by accident because the template's shape forces a certain structure on you. Scripted Pipeline is like being handed a blank notebook and a pen — total freedom to write whatever logic you want, but also total freedom to make an unreadable mess if you're not careful.

### Declarative Pipeline
- Uses a fixed, predictable structure: `pipeline { agent {} stages {} post {} }`.
- Easier for beginners to read and validate; Jenkins can catch structural mistakes early, often before a build even starts.
- The recommended default for most teams and most day-to-day use cases.

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
- `agent any` — tells Jenkins to run this on any available agent (or the controller, if no agents are configured).
- `stages { }` — container for all pipeline stages.
- `stage('Build') { }` — a named phase, shown as its own visual box in the Jenkins UI's pipeline graph.
- `steps { }` — the actual commands executed within that stage.

### Line-by-Line Explanation (Scripted)
- `node { }` — allocates an executor and workspace; serves the same purpose as Declarative's `agent`.
- `stage('...') { }` — the same organizational concept as Declarative, but written as plain Groovy code blocks without the surrounding `stages`/`steps` wrapper.

### When to Use Which
| Use Declarative when... | Use Scripted when... |
|---|---|
| You want a standard, structured, easy-to-review pipeline | You need complex custom logic Declarative can't express cleanly |
| Your team is newer to Jenkins/Groovy | Your team is comfortable writing Groovy |
| Most everyday CI/CD needs | Rare edge cases — or wrapped inside Declarative's `script { }` escape hatch |

**Important:** Declarative Pipelines can drop into Scripted-style Groovy at any point using a `script { }` block — giving you an escape hatch for complex logic without abandoning Declarative structure entirely.

### Extended Example: Using `script {}` Inside a Declarative Pipeline
```groovy
pipeline {
    agent any
    stages {
        stage('Conditional Logic') {
            steps {
                script {
                    def versions = ['1.0', '2.0', '3.0']
                    for (v in versions) {
                        echo "Would build version ${v}"
                    }
                }
            }
        }
    }
}
```
Here, a `for` loop (which Declarative's plain directives can't express directly) is written inside a `script { }` block, combining Declarative's overall structure with Scripted-style flexibility exactly where it's needed.

### Common Mistakes
- Mixing Declarative top-level structure with raw Scripted syntax outside of a `script { }` block — this causes syntax errors that can be confusing for beginners to diagnose.
- Choosing Scripted "because it seems more powerful" for a simple pipeline that Declarative would handle perfectly well — this adds unnecessary complexity and hurts readability for the whole team.

### Best Practices
- Default to Declarative for nearly everything; reach for `script { }` blocks only for the specific bits of logic that genuinely need it.
- Keep Scripted-style code (even inside `script { }`) as simple and well-commented as possible, since it's easier to write confusing logic in raw Groovy.

### Interview Questions
**Q: What's the key structural difference between Declarative and Scripted Pipelines?**
A: Declarative uses a fixed, predictable top-level structure (`pipeline { agent {} stages {} }`) that Jenkins can validate ahead of time; Scripted is plain Groovy wrapped in a `node {}` block, offering full programming flexibility at the cost of structure and easy validation.

**Q: Can you use Scripted-style logic inside a Declarative Pipeline? How?**
A: Yes — using a `script { }` block inside a `steps { }` block, which lets you drop into raw Groovy exactly where needed.

**What You Should Remember:** Declarative = structured, opinionated, recommended default. Scripted = full Groovy flexibility, more complex. Declarative can embed Scripted logic via `script { }` when genuinely needed.

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
| `tools` | Auto-installs/configures tools like JDK, Maven, or Node.js for this pipeline run. |
| `options` | Pipeline-wide behavior settings, e.g. `timeout`, `retry`, `disableConcurrentBuilds`. |
| `triggers` | Automated triggers defined in code (cron, polling) instead of UI — see [Section 8](#8-build-triggers). |
| `post` | Actions to run after the pipeline/stage finishes — see [Section 10](#10-post-build-actions--notifications). |
| `when` | Conditional logic to decide if a stage should run. |
| `input` | Pauses the pipeline to wait for manual approval before continuing. |
| `parallel` | Runs multiple stages simultaneously instead of sequentially. |

### Full Example Using Several Directives Together
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
- `timeout(time: 30, unit: 'MINUTES')` — automatically kills the build if it runs longer than 30 minutes, preventing a "stuck forever" build from permanently occupying an executor.
- `retry(2)` — if a stage/step fails, retries it up to 2 more times before giving up entirely; useful for flaky network calls.
- `disableConcurrentBuilds()` — prevents two runs of this same pipeline from executing at the exact same time.
- `environment { APP_ENV = 'staging' }` — sets an environment variable accessible via `$APP_ENV` (in shell steps) or `env.APP_ENV` (in Groovy code).
- `parallel { }` — the two nested stages (Unit Tests, Lint) run simultaneously rather than one after another, saving overall pipeline time.
- `when { branch 'main' }` — restricts this stage to only run if the current branch is `main`.
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
`catchError` lets a stage fail internally (marked `FAILURE` for that specific stage) while still letting the overall pipeline continue running, with the whole build marked `UNSTABLE` rather than fully `FAILURE` — useful for non-blocking, "nice to have" checks that shouldn't halt an otherwise-good build.

### Matrix Builds
A **matrix** build runs the same set of stages across multiple combinations of variables (e.g., testing against several Java versions) without duplicating pipeline code:
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

### Extended Example: `input` With a Safety Timeout
```groovy
stage('Approve Deploy') {
    steps {
        timeout(time: 1, unit: 'HOURS') {
            input message: 'Deploy to production?', ok: 'Deploy'
        }
    }
}
```
Wrapping `input` in a `timeout` means a forgotten approval automatically aborts the pipeline after an hour instead of holding an executor hostage indefinitely — a genuinely important production safeguard.

### Common Mistakes
- Forgetting `timeout` at the pipeline or stage level — a hung build occupies an executor indefinitely, blocking all other work that needs that agent.
- Using `parallel` for stages that actually depend on each other's output — causes race conditions and confusing, intermittent failures.
- Placing an `input` step without any timeout — a forgotten approval gate can block a pipeline (and its executor) for days or weeks.

### Best Practices
- Always set a `timeout` at the pipeline or stage level, as a default habit.
- Wrap every `input` step in its own `timeout`, so forgotten approvals don't silently block resources forever.
- Use `parallel` only for genuinely independent tasks that don't share state or depend on each other's output.

### Interview Questions
**Q: What does `catchError` let you do that a plain failing step doesn't?**
A: It lets a stage fail internally (marked as `FAILURE` for that stage alone) while the overall pipeline keeps running, typically marking the whole build `UNSTABLE` rather than fully failing it — useful for optional, non-blocking checks.

**Q: Why should every `input` step be wrapped in a `timeout`?**
A: Without a timeout, a forgotten manual approval can hold an executor (and block other builds needing that same resource) indefinitely.

**What You Should Remember:** Directives like `options`, `when`, `input`, and `parallel` give Declarative Pipelines real control-flow power without dropping into Scripted Groovy. `catchError` lets non-critical steps fail softly without failing the whole build.

---

## 14. Multibranch Pipelines & Organization Folders

### In Plain English (Beginner Explanation)
A Multibranch Pipeline is like a restaurant that automatically opens a new pop-up stand for every new recipe experiment (branch) someone in the kitchen is testing, without anyone having to manually build that stand each and every time. An Organization Folder does this across every restaurant location the company owns, not just one — automatically opening pop-ups for every repository, not just a single one.

### Simple Definition
A **Multibranch Pipeline** automatically discovers every branch (and optionally pull requests) in a repository and creates/runs a Jenkins job for each one — using the `Jenkinsfile` found in that specific branch.

### How It Works
Instead of manually creating a job per branch, you point Jenkins at the repository once. Jenkins periodically (or via webhook) scans it, and for every branch containing a `Jenkinsfile`, automatically creates a corresponding sub-job — visible as its own entry inside the Multibranch Pipeline job in the Jenkins UI.

### Why It Matters
Modern teams work across many feature branches simultaneously. Multibranch Pipelines mean every branch — and every pull request — automatically gets its own build/test cycle without any manual job setup, which is essential for validating pull requests before they're merged.

### Jenkins UI Navigation
```
Dashboard → New Item → enter name → select "Multibranch Pipeline" → OK
  → Branch Sources → Add source (Git/GitHub) → repository URL + credentials
  → Behaviors → configure branch discovery (all branches, PRs, etc.)
  → Scan Multibranch Pipeline Triggers → configure how often Jenkins re-scans for new/removed branches
```

### Organization Folders
An **Organization Folder** goes one level higher: instead of pointing at a single repository, it points at an entire GitHub organization or user account, and automatically creates a Multibranch Pipeline for **every repository** that contains a `Jenkinsfile`. Useful for large organizations managing dozens or hundreds of repositories without manually configuring each one individually.

### PR Validation Workflow, Step by Step
1. A developer opens a pull request.
2. Jenkins (via Multibranch discovery of PRs) automatically builds and tests that PR's exact branch.
3. Build status is reported back to GitHub as a check on the PR (pass/fail).
4. The team only merges once that check passes — enforced via GitHub branch protection rules requiring the Jenkins check to be green.

### Extended Example: A Jenkinsfile That Behaves Differently Per Branch
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps { sh 'mvn clean package' }
        }
        stage('Deploy to Staging') {
            when { branch 'develop' }
            steps { echo 'Deploying to staging environment' }
        }
        stage('Deploy to Production') {
            when { branch 'main' }
            steps { echo 'Deploying to production environment' }
        }
    }
}
```
Because this single Jenkinsfile lives identically across every branch (via Multibranch discovery), the `when { branch '...' }` conditions ensure each branch only performs the deployment actions appropriate to it — feature branches build and test but never deploy anywhere.

### Common Mistakes
- Not configuring "Discover pull requests" as a Behavior, so PRs are silently never automatically validated at all.
- Forgetting that every branch needs its own `Jenkinsfile` (or one at an expected path) — branches without one are simply skipped, which can look like a confusing silent failure to someone unfamiliar with the concept.
- Not setting up branch protection rules on the Git provider side, meaning the Jenkins check exists but nothing actually enforces that it must pass before merging.

### Best Practices
- Use branch protection rules in GitHub/GitLab requiring the Jenkins PR check to pass before allowing a merge.
- Combine Multibranch/Organization Folders with Shared Libraries (covered in Part 2 of this handbook) so every branch's Jenkinsfile can stay short by calling shared, centrally-maintained logic instead of duplicating it.
- Periodically review the "Scan Multibranch Pipeline Triggers" interval — too infrequent means slow discovery of new branches; too frequent adds unnecessary load.

### Interview Questions
**Q: What's the difference between a Multibranch Pipeline and an Organization Folder?**
A: A Multibranch Pipeline auto-discovers branches/PRs within a single repository; an Organization Folder auto-discovers Multibranch Pipelines across an entire organization's set of repositories.

**Q: How does Multibranch enable pull request validation?**
A: By automatically discovering and building each PR's branch using its own Jenkinsfile, then reporting the result back to the Git provider as a status check that can be required before merging.

**What You Should Remember:** Multibranch Pipeline = auto-discovers branches/PRs in one repo. Organization Folder = auto-discovers across an entire org. Both are foundational for automated PR-validation workflows.

---

*End of Part 1 — Fundamentals. Continue to Part 2: Production Engineering (Credentials, Security, Docker, Kubernetes, Terraform, Agents, Shared Libraries).*
