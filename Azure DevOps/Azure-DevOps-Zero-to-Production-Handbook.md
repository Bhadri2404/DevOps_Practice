# Azure DevOps Zero to Production — Complete DevOps Handbook

> A complete, beginner-friendly, technically accurate learning handbook covering Azure DevOps from absolute basics to production-grade CI/CD — Boards, Repos, Pipelines, Artifacts — with every concept explained in plain English first, then in full technical depth, with real YAML examples, troubleshooting, and interview preparation.

---

## Table of Contents

**Part 1: Foundations**
- [1. Introduction to Azure DevOps](#1-introduction-to-azure-devops)
- [2. CI/CD Fundamentals](#2-cicd-fundamentals)
- [3. Azure DevOps Architecture](#3-azure-devops-architecture)
- [4. Setting Up Your Organization and Project](#4-setting-up-your-organization-and-project)

**Part 2: Azure Repos & Boards**
- [5. Azure Repos & Git Basics](#5-azure-repos--git-basics)
- [6. Branch Policies & Pull Request Workflows](#6-branch-policies--pull-request-workflows)
- [7. Azure Boards Overview](#7-azure-boards-overview)

**Part 3: Azure Pipelines Fundamentals**
- [8. Introduction to Azure Pipelines: Classic vs YAML](#8-introduction-to-azure-pipelines-classic-vs-yaml)
- [9. Your First YAML Pipeline](#9-your-first-yaml-pipeline)
- [10. Pipeline Structure: Stages, Jobs, Steps, Tasks](#10-pipeline-structure-stages-jobs-steps-tasks)
- [11. Pipeline Triggers](#11-pipeline-triggers)
- [12. Variables and Variable Groups](#12-variables-and-variable-groups)
- [13. Parameters](#13-parameters)

**Part 4: Reusability & Security**
- [14. Templates](#14-templates)
- [15. Service Connections](#15-service-connections)
- [16. Azure Key Vault Integration](#16-azure-key-vault-integration)
- [17. Environments and Approvals](#17-environments-and-approvals)

**Part 5: Artifacts & Packaging**
- [18. Azure Artifacts & Feeds](#18-azure-artifacts--feeds)
- [19. Docker and Azure Container Registry (ACR)](#19-docker-and-azure-container-registry-acr)

**Part 6: Cloud-Native & Infrastructure**
- [20. Kubernetes and AKS Integration](#20-kubernetes-and-aks-integration)
- [21. Terraform and Bicep with Azure Pipelines](#21-terraform-and-bicep-with-azure-pipelines)

**Part 7: Advanced Pipeline Engineering**
- [22. Complete Multi-Stage CI/CD Pipeline Design](#22-complete-multi-stage-cicd-pipeline-design)
- [23. Release Pipelines (Classic) vs YAML Multi-Stage](#23-release-pipelines-classic-vs-yaml-multi-stage)

**Part 8: Agents & Scaling**
- [24. Agents and Agent Pools](#24-agents-and-agent-pools)

**Part 9: Administration & Security**
- [25. Azure DevOps RBAC & Security](#25-azure-devops-rbac--security)
- [26. Organization Administration & Extensions](#26-organization-administration--extensions)
- [27. Backup, Recovery & Maintenance](#27-backup-recovery--maintenance)

**Part 10: Troubleshooting**
- [28. Troubleshooting Guide](#28-troubleshooting-guide)

**Part 11: Interview Preparation**
- [29. Interview Questions Bank](#29-interview-questions-bank)

**Part 12: Reference**
- [30. Azure DevOps Revision Cheat Sheet](#30-azure-devops-revision-cheat-sheet)
- [31. Beginner → Production Learning Roadmap](#31-beginner--production-learning-roadmap)

---

## 1. Introduction to Azure DevOps

### In Plain English (Beginner Explanation)
Imagine you're opening a restaurant, and instead of buying a separate machine for taking orders, another for tracking recipes, another for storing ingredients, and yet another for cooking — you get one all-in-one kitchen suite where everything is already wired together. Azure DevOps is that all-in-one suite for building software: it bundles the tools for planning work, storing code, building and shipping it, and storing the packaged results, all under one roof from Microsoft.

### Simple Definition
Azure DevOps is a **suite of integrated services from Microsoft** for the entire software delivery lifecycle — planning, source control, building, testing, deploying, and package management — accessible either as a cloud service (Azure DevOps Services) or self-hosted (Azure DevOps Server).

### The Five Core Services
| Service | What It Does |
|---|---|
| **Azure Boards** | Plan and track work — user stories, tasks, bugs, sprints, Kanban boards. |
| **Azure Repos** | Host Git (or TFVC) source code repositories with branch policies and pull requests. |
| **Azure Pipelines** | Build, test, and deploy code automatically — the CI/CD engine. |
| **Azure Artifacts** | Host and share packages (NuGet, npm, Maven, Python) and pipeline artifacts. |
| **Azure Test Plans** | Manual and exploratory testing tools (less commonly used than the other four). |

### Why It Matters
Before all-in-one suites, teams stitched together separate tools — one for issue tracking, another for source control, a third for CI/CD — each with its own login, permissions model, and integration headaches. Azure DevOps integrates all of these so a work item in Boards can link directly to the code commit in Repos that fixed it, which links to the pipeline run in Pipelines that deployed it — full traceability from idea to production.

### Azure DevOps vs GitHub (A Common Point of Confusion)
Microsoft owns both. Broadly: **GitHub** leans toward open-source, developer-community, and GitHub Actions for CI/CD; **Azure DevOps** leans toward enterprise teams wanting integrated boards + repos + pipelines + artifacts with fine-grained governance. Many enterprises use Azure DevOps for internal projects; the concepts you learn here transfer heavily to GitHub Actions too.

### When to Use It
Any team that wants an integrated, enterprise-grade platform for planning, source control, and automated build/release — especially teams already invested in the Azure cloud ecosystem.

### Common Mistakes
- Assuming Azure DevOps only works with the Azure cloud — it can deploy to AWS, GCP, on-prem, anywhere.
- Thinking you must use all five services — most teams heavily use Repos + Pipelines + Boards and lightly touch the rest.
- Confusing "Azure DevOps" (the platform) with "DevOps" (the culture/practice) — the platform is one tool that supports the practice.

### Interview Questions
**Q: What is Azure DevOps, and what are its main services?**
A: An integrated Microsoft suite for the software delivery lifecycle, comprising Azure Boards (planning), Repos (source control), Pipelines (CI/CD), Artifacts (package management), and Test Plans (testing).

**Q: Can Azure DevOps deploy to non-Azure targets?**
A: Yes — despite the name, Azure Pipelines can deploy to AWS, GCP, on-premises servers, and anywhere else; the "Azure" refers to the platform's origin, not a deployment restriction.

**What You Should Remember:** Azure DevOps is Microsoft's all-in-one software delivery suite — Boards, Repos, Pipelines, Artifacts, Test Plans — with deep integration between them for end-to-end traceability. It can deploy anywhere, not just Azure.

---

## 2. CI/CD Fundamentals

### In Plain English (Beginner Explanation)
Think of CI/CD like an assembly line at a car factory. **CI** (Continuous Integration) is like every worker checking their part fits the moment it's attached, instead of waiting until the whole car is built to discover a problem. **Continuous Delivery** means the finished car is always parked at the end of the line ready to drive — but a manager signs off before it ships. **Continuous Deployment** means the car drives itself off the lot the moment it's ready, no manager needed.

### Simple Definition
**CI/CD** stands for **Continuous Integration** and **Continuous Delivery/Deployment** — practices that let teams build, test, and release software frequently, safely, and automatically. Azure Pipelines is the tool that implements these practices in the Azure DevOps world.

### Continuous Integration (CI) — In Depth
Developers merge code changes into a shared repository frequently, and every merge automatically triggers a build + test run in Azure Pipelines. Small, frequent changes are far easier to test and debug than one giant merge weeks later. In Azure DevOps, this typically means a CI trigger on your `main` (or feature) branches that runs a build pipeline on every push.

### Continuous Delivery (CD) — In Depth
After CI passes, the application is automatically packaged and made ready to deploy at all times — but a human approves the actual production release (via **Environments and approvals**, covered in [Section 17](#17-environments-and-approvals)). This gives automation's safety with a human's final judgment on timing.

### Continuous Deployment — In Depth
Every change passing all automated gates deploys straight to production automatically, with no manual approval step. This requires very high confidence in your automated tests and gates.

### Delivery vs Deployment — The One Sentence to Remember
**Delivery = always ready, human presses the button. Deployment = it deploys itself, no button needed.**

### The Full CI/CD Flow in Azure DevOps
```
Developer writes code
      │
      ▼
Push / PR to Azure Repos (or GitHub)
      │
      ▼
CI trigger fires Azure Pipeline
      │
      ▼
Checkout code
      │
      ▼
Build / compile
      │
      ▼
Run automated tests + publish results
      │
      ▼
Code quality / security scan
      │
      ▼
Build artifact (e.g. Docker image) → push to ACR / publish artifact
      │
      ▼
Deploy to Environment (Dev → Test → Prod) with approvals
      │
      ▼
Smoke test
      │
      ▼
Notify team (Teams / email)
```
Each box becomes a **stage** or **job** in a multi-stage YAML pipeline — you'll build this exact flow throughout this handbook.

### Common Mistakes
- Treating CI and CD as the same thing — they solve different problems (integration/testing vs release).
- Skipping automated tests to "save time" — defeats the whole point of CI.
- Deploying to production with no approval gate or staging environment.

### Interview Questions
**Q: Explain CI, Continuous Delivery, and Continuous Deployment.**
A: CI = frequent integration with automated build/test. Continuous Delivery = always deployable, human approves release. Continuous Deployment = fully automatic release with no human gate.

**Q: How does Azure DevOps implement the human-approval gate in Continuous Delivery?**
A: Through Environments with approval checks — a deployment to a protected environment (like Production) pauses until a designated approver signs off.

**What You Should Remember:** CI catches problems early via frequent tested integration. Continuous Delivery keeps you always release-ready with a human gate (Environments + approvals); Continuous Deployment removes that gate once automation is trustworthy.

---

## 3. Azure DevOps Architecture

### In Plain English (Beginner Explanation)
Picture a company with a headquarters (your **Organization**), which contains several departments (**Projects**), each with its own staff, files, and workflows. Within each department, work happens through pipelines that run on "workers" (**Agents**) grouped into staffing agencies (**Agent Pools**). Understanding this nesting — Organization → Project → the services inside it → Agents that do the actual work — is the foundation for everything else.

### Core Hierarchy
```
Organization (e.g. dev.azure.com/mycompany)
  └── Project (e.g. "ecommerce-platform")
        ├── Boards      (work items, sprints)
        ├── Repos       (Git repositories)
        ├── Pipelines   (build/release pipelines)
        ├── Artifacts   (package feeds)
        └── Test Plans
```

### Key Architectural Concepts
| Concept | What It Is |
|---|---|
| **Organization** | The top-level container, tied to a URL (`dev.azure.com/<org>`). Holds billing, org-level policies, and projects. |
| **Project** | A container for one product/team's work — its own boards, repos, pipelines, and permissions. |
| **Agent** | A machine (Microsoft-hosted or self-hosted) that actually runs pipeline jobs. |
| **Agent Pool** | A group of agents that pipelines target; jobs are dispatched to an available agent in the pool. |
| **Pipeline** | The definition of a build/release process (YAML or Classic). |
| **Job** | A unit of work in a pipeline that runs on a single agent. |
| **Environment** | A named deployment target (e.g. "Production") with approvals, checks, and deployment history. |

### How a Pipeline Run Works, Step by Step
1. A trigger fires (push, PR, schedule, or manual run).
2. Azure Pipelines queues the run and requests an agent from the target **agent pool**.
3. An available **agent** picks up a **job**, prepares a clean working directory, and checks out the code.
4. Each **step/task** in the job runs sequentially on that agent.
5. Artifacts, test results, and logs are published back to Azure DevOps.
6. If the pipeline has multiple **stages**, later stages (e.g., deploy) may target **Environments** with approval gates.

### Microsoft-Hosted vs Self-Hosted Agents
- **Microsoft-hosted agents**: Microsoft provides fresh, fully-managed VMs for each run (Ubuntu, Windows, macOS). Zero maintenance, but limited customization and subject to usage limits/parallelism costs.
- **Self-hosted agents**: your own VMs/containers that you install the agent on. Full control over installed tools, persistent caches, and network access to private resources — but you maintain them. Covered fully in [Section 24](#24-agents-and-agent-pools).

### Common Mistakes
- Cramming many unrelated products into one giant Project instead of separating concerns — makes permissions and boards messy.
- Not understanding that a single job runs entirely on one agent — steps in the same job share a workspace, but different jobs may run on different agents and don't automatically share files.

### Interview Questions
**Q: What's the difference between an Organization and a Project in Azure DevOps?**
A: An Organization is the top-level container (tied to a URL and billing); a Project sits inside it and contains one team/product's boards, repos, pipelines, and permissions.

**Q: What's the difference between an Agent and an Agent Pool?**
A: An agent is a single machine that runs pipeline jobs; an agent pool is a named group of agents that pipelines target, with jobs dispatched to whichever agent in the pool is available.

**What You Should Remember:** Organization → Project → services (Boards/Repos/Pipelines/Artifacts). Pipelines run jobs on Agents, grouped into Agent Pools. A single job runs entirely on one agent.

---

## 4. Setting Up Your Organization and Project

### In Plain English (Beginner Explanation)
This is the "unlock the building and set up the departments" step — creating your company headquarters (Organization), then setting up your first department (Project), choosing how work is tracked, and inviting your team in.

### Step-by-Step Setup
```
1. Go to https://dev.azure.com and sign in with a Microsoft/Azure AD account.
2. Create an Organization:
   - Choose a name (becomes dev.azure.com/<name>)
   - Choose the region where your data is hosted
3. Create a Project inside the organization:
   - Name it (e.g. "ecommerce-platform")
   - Visibility: Private (default) or Public
   - Version control: Git (recommended) or TFVC
   - Work item process: Basic, Agile, Scrum, or CMMI
4. Invite team members: Organization Settings → Users → Add users
5. Assign them to the project and set permission levels.
```

### Choosing a Work Item Process
| Process | Best For |
|---|---|
| **Basic** | Small teams / newcomers — simple Issues, Tasks, Epics. |
| **Agile** | Teams using Agile terminology — User Stories, Bugs, Features. |
| **Scrum** | Teams following Scrum — Product Backlog Items, Sprints. |
| **CMMI** | Formal/regulated environments needing more process rigor. |

### Billing and Parallel Jobs
Azure DevOps offers a free tier (with limited Microsoft-hosted pipeline minutes and one free parallel job for private projects). As you scale, you pay for additional **parallel jobs** (how many pipeline jobs can run simultaneously) and additional user licenses. Understanding parallel jobs matters because it directly caps how many builds/deployments can happen at once.

### Common Mistakes
- Picking the wrong region for the organization (data residency can matter for compliance and can't be changed easily later).
- Choosing a work item process that doesn't match how the team actually works, then fighting the tooling.
- Not planning project structure — one project per product/team is usually cleaner than one massive shared project.

### Interview Questions
**Q: What decisions do you make when creating a new Azure DevOps project?**
A: Project name and visibility, version control type (Git vs TFVC), and the work item process (Basic/Agile/Scrum/CMMI) — each affecting how the team tracks and manages work.

**Q: What is a parallel job and why does it matter?**
A: A parallel job is one concurrent pipeline job slot; the number you have caps how many builds/deployments can run simultaneously, directly affecting throughput and cost.

**What You Should Remember:** Set up Organization → Project, choosing region, Git, and the right work item process. Parallel jobs cap concurrent pipeline runs and are a key scaling/cost lever.

---

## 5. Azure Repos & Git Basics

### In Plain English (Beginner Explanation)
Azure Repos is the filing cabinet where all your code lives, plus a full history of every change ever made — like a time machine for your project. Instead of emailing files around or overwriting each other's work, everyone pulls from and pushes to this shared, versioned cabinet.

### Simple Definition
**Azure Repos** provides Git repositories (and legacy TFVC) hosted inside your Azure DevOps project, where your source code, its full change history, and branches live.

### Git vs TFVC
- **Git** (distributed version control): the modern default; every clone has the full history, supports branching/merging heavily. Recommended for nearly all new projects.
- **TFVC** (Team Foundation Version Control, centralized): legacy; a single central server holds history. Only relevant for older, existing projects.

### Core Git Concepts (Quick Refresher)
| Term | Meaning |
|---|---|
| **Repository (repo)** | The project's code + full history. |
| **Clone** | A local copy of the repo on your machine. |
| **Commit** | A saved snapshot of changes with a message. |
| **Branch** | An independent line of development (e.g., `main`, `feature/login`). |
| **Merge** | Combining changes from one branch into another. |
| **Pull Request (PR)** | A request to merge one branch into another, with review. |

### Common Git Workflow with Azure Repos
```bash
git clone https://dev.azure.com/myorg/myproject/_git/myrepo
git checkout -b feature/add-login
# ... make changes ...
git add .
git commit -m "Add login feature"
git push origin feature/add-login
# Then open a Pull Request in the Azure DevOps UI
```

### Azure DevOps UI Navigation
```
Project → Repos → Files       → browse code, branches, commits
Project → Repos → Branches    → create/manage branches, set policies
Project → Repos → Pull requests → open, review, and complete PRs
Project → Repos → Commits     → view commit history
```

### Why It Matters
Source control is the single source of truth for your code, and Azure Repos ties commits directly to Boards work items and Pipelines runs — so you can trace exactly which commit fixed which bug and which pipeline deployed it.

### Common Mistakes
- Committing secrets (passwords, keys) directly into the repo — they persist in history even after deletion; use Key Vault / secure variables instead.
- Working directly on `main` instead of feature branches, bypassing review.
- Not writing meaningful commit messages, making history hard to understand later.

### Interview Questions
**Q: What's the difference between Git and TFVC in Azure Repos?**
A: Git is distributed (every clone has full history, branch-heavy, the modern default); TFVC is centralized (single server holds history) and is legacy, relevant mainly for older projects.

**Q: How does Azure Repos link to other Azure DevOps services?**
A: Commits and pull requests can link to Boards work items and trigger Pipelines, providing end-to-end traceability from a tracked task to the code change to its deployment.

**What You Should Remember:** Azure Repos hosts Git repos with full history, integrated with Boards and Pipelines. Use feature branches + pull requests, and never commit secrets.

---

## 6. Branch Policies & Pull Request Workflows

### In Plain English (Beginner Explanation)
A branch policy is like a bouncer at the door of your most important branch (`main`). Before any code gets in, the bouncer checks: Did at least one other person review it? Did the automated build pass? Is it linked to a tracked work item? Only if all the rules are satisfied does the code get let through.

### Simple Definition
**Branch policies** are protection rules applied to important branches (like `main`) that enforce quality gates — required reviewers, successful builds, linked work items — before a pull request can be merged.

### Common Branch Policies
| Policy | What It Enforces |
|---|---|
| **Require a minimum number of reviewers** | At least N people must approve the PR. |
| **Check for linked work items** | The PR must link to a Boards work item (traceability). |
| **Check for comment resolution** | All PR comments must be resolved before merging. |
| **Build validation** | A pipeline must run and pass against the PR's changes. |
| **Require merge strategy** | Enforce squash/rebase/merge-commit consistency. |
| **Automatically included reviewers** | Auto-add specific people/groups as reviewers. |

### Azure DevOps UI Navigation
```
Project → Repos → Branches → (hover over branch) → ⋯ → Branch policies
  → toggle required reviewers, build validation, work item linking, etc.
```

### Build Validation (PR Validation Pipeline)
This is the key CI-for-pull-requests mechanism: you attach a pipeline as a **build validation** policy so that whenever a PR is opened/updated against `main`, that pipeline automatically builds and tests the proposed changes. The PR cannot be completed until the pipeline passes — this is how you prevent broken code from ever reaching `main`.

### The Pull Request Workflow, Step by Step
1. Developer creates a feature branch and pushes changes.
2. Developer opens a Pull Request targeting `main`.
3. Branch policies kick in: the validation pipeline runs, reviewers are notified, work item linking is checked.
4. Reviewers comment/approve; the developer addresses feedback.
5. Once all policies are satisfied (approvals + passing build + resolved comments), the PR can be **completed** (merged).
6. Optionally, the source branch is auto-deleted after merge.

### Why It Matters
Branch policies are the enforcement layer of code quality and traceability. Without them, anyone could push untested, unreviewed code straight to your production branch.

### Common Mistakes
- Not enabling build validation, so PRs can be merged without ever being tested.
- Setting required reviewers to a number the team can't realistically sustain, causing bottlenecks.
- Allowing admins to bypass policies routinely, undermining the whole system.

### Interview Questions
**Q: How do you prevent untested code from reaching the main branch in Azure DevOps?**
A: Apply a branch policy with build validation — a pipeline runs against each PR and must pass before the PR can be completed — combined with required reviewers.

**Q: What is a build validation policy?**
A: A branch policy that automatically runs a specified pipeline against a pull request's changes and blocks completion of the PR until that pipeline succeeds.

**What You Should Remember:** Branch policies (required reviewers + build validation + work item linking) are how you enforce quality and traceability on protected branches. Build validation is CI applied to pull requests.

---

## 7. Azure Boards Overview

### In Plain English (Beginner Explanation)
Azure Boards is the project whiteboard where you write down everything the team needs to do, who's doing it, and how far along it is — organized so nothing falls through the cracks. It turns vague "we should build a login feature" into concrete, trackable, assignable pieces of work.

### Simple Definition
**Azure Boards** is the work-tracking service — it manages work items (epics, features, user stories, tasks, bugs), backlogs, sprints, and Kanban/Scrum boards.

### Work Item Hierarchy (Agile Process Example)
```
Epic          (large body of work, e.g. "Checkout Experience")
  └── Feature (e.g. "Guest Checkout")
        └── User Story (e.g. "As a guest, I can pay without an account")
              └── Task (e.g. "Build payment form")
              └── Bug  (e.g. "Payment button misaligned on mobile")
```

### Key Boards Features
| Feature | Purpose |
|---|---|
| **Backlogs** | Prioritized lists of work items to be done. |
| **Boards (Kanban)** | Visual columns (To Do → In Progress → Done) for workflow. |
| **Sprints** | Time-boxed iterations for Scrum teams. |
| **Queries** | Custom searches/filters across work items. |
| **Dashboards** | Visual widgets showing progress, burndown, velocity. |

### Traceability: Linking Work to Code and Deployments
The real power is linking. A work item can link to:
- The **branch/commit/PR** in Repos that implements it.
- The **pipeline run** in Pipelines that built/deployed it.

This means you can answer "which deployment included the fix for bug #142?" by following the links — invaluable for auditing and debugging in production.

### Azure DevOps UI Navigation
```
Project → Boards → Work items    → all work items
Project → Boards → Boards        → Kanban board view
Project → Boards → Backlogs      → prioritized backlog
Project → Boards → Sprints       → sprint planning and taskboard
```

### Common Mistakes
- Not linking commits/PRs to work items, losing traceability.
- Overcomplicating the work item hierarchy for a small team that just needs Tasks.
- Letting the backlog grow unmanaged into an unusable dumping ground.

### Interview Questions
**Q: How does Azure Boards support end-to-end traceability?**
A: Work items can link to the commits, branches, and pull requests that implement them, and to the pipeline runs that deploy them — so you can trace a requirement from planning through code to production.

**What You Should Remember:** Azure Boards tracks work (epics → features → stories → tasks/bugs) via backlogs, boards, and sprints, and links work items to code and deployments for full traceability.

---

## 8. Introduction to Azure Pipelines: Classic vs YAML

### In Plain English (Beginner Explanation)
Azure Pipelines is the automated kitchen assistant that builds, tests, and ships your code. It comes in two flavors: **Classic** (build your pipeline by clicking through a visual UI, like assembling with drag-and-drop) and **YAML** (write your pipeline as a text file stored alongside your code, like a written recipe). YAML is the modern, recommended way because the recipe travels with your code and is version-controlled.

### Simple Definition
**Azure Pipelines** is the CI/CD service that automatically builds, tests, and deploys code. Pipelines can be defined either **Classic** (UI-based, visual designer) or as **YAML** (pipeline-as-code stored in your repository).

### Classic vs YAML — The Core Comparison
| Aspect | Classic (UI) | YAML (Pipeline-as-Code) |
|---|---|---|
| **Definition** | Clicked through a visual designer | Written in a `azure-pipelines.yml` file |
| **Version control** | Stored in Azure DevOps, not your repo | Lives in your repo, versioned with code |
| **Reviewability** | Hard to review changes | Reviewed via pull requests like any code |
| **Portability** | Tied to one project | Copyable across repos/projects |
| **Recommended?** | Legacy — still used for some release pipelines | Yes — the modern standard |

### Why YAML Is Preferred
Because the pipeline definition lives in your repository, it is:
- **Version-controlled** — full history of every change, with the ability to roll back.
- **Reviewable** — pipeline changes go through pull requests like application code.
- **Portable and consistent** — the same pipeline can be reused across branches and repos.
- **Auditable** — you always know exactly what pipeline ran for a given commit, because they're stored together.

### A Note on Release Pipelines
Historically, Azure DevOps separated **Build pipelines** (CI) from **Release pipelines** (CD), where Release pipelines were Classic/UI-only. Modern practice uses **multi-stage YAML pipelines** to cover both build and deploy in one YAML file. Classic Release pipelines still exist and are covered in [Section 23](#23-release-pipelines-classic-vs-yaml-multi-stage).

### When to Use Which
- **YAML**: default for all new work — CI and CD both.
- **Classic**: only when maintaining existing Classic pipelines, or in rare cases where a team relies on a specific Classic-only release feature.

### Common Mistakes
- Starting new projects with Classic pipelines out of habit, missing out on version control and reviewability.
- Mixing Classic build + Classic release when a single multi-stage YAML pipeline would be cleaner and fully code-managed.

### Interview Questions
**Q: What's the difference between Classic and YAML pipelines, and which is recommended?**
A: Classic pipelines are built through a visual UI and stored in Azure DevOps; YAML pipelines are defined as code in your repository. YAML is recommended because it's version-controlled, reviewable via PRs, portable, and auditable.

**Q: How does modern Azure DevOps handle CD that previously required Classic Release pipelines?**
A: Through multi-stage YAML pipelines, which define both build and deployment stages (including environments and approvals) as code in a single YAML file.

**What You Should Remember:** Azure Pipelines comes in Classic (UI) and YAML (code) forms. YAML is the modern standard — version-controlled, reviewable, portable. Multi-stage YAML covers both CI and CD.

---

## 9. Your First YAML Pipeline

### In Plain English (Beginner Explanation)
This is your "hello world" — the smallest possible written recipe that proves the whole kitchen works end to end. Once this runs successfully, you know your repo, pipeline, and agents are all wired together correctly, and you can start adding real steps.

### Simple Definition
A YAML pipeline is defined in a file (conventionally `azure-pipelines.yml`) at the root of your repository, describing what to run and when.

### A Minimal Pipeline
```yaml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

steps:
  - script: echo "Hello from Azure Pipelines!"
    displayName: 'Say hello'
```

### Line-by-Line Explanation
- `trigger: - main` — a CI trigger; this pipeline runs automatically whenever code is pushed to the `main` branch.
- `pool: vmImage: 'ubuntu-latest'` — requests a Microsoft-hosted Ubuntu agent to run the pipeline.
- `steps:` — the list of actions to perform.
- `- script: echo "..."` — runs a shell command (a `script` step is a shortcut for running command-line/bash).
- `displayName:` — a friendly label shown in the pipeline run UI, making logs easier to read.

### How to Create It
```
1. Add azure-pipelines.yml to your repo root (content above).
2. In Azure DevOps: Pipelines → New pipeline → select your repo →
   "Existing Azure Pipelines YAML file" → pick the file.
3. Run it, and watch the live logs.
```

### A Slightly More Realistic First Pipeline
```yaml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

steps:
  - task: UseDotNet@2
    inputs:
      packageType: 'sdk'
      version: '8.x'
    displayName: 'Install .NET SDK'

  - script: dotnet build --configuration Release
    displayName: 'Build'

  - script: dotnet test --configuration Release
    displayName: 'Run tests'
```
This installs a specific .NET SDK, builds the project, and runs tests — a miniature real CI pipeline. (Swap the tasks for Maven, npm, etc., for other languages.)

### Common Mistakes
- Putting the YAML file in the wrong location or misnaming it, so Azure DevOps can't find it.
- YAML indentation errors — YAML is whitespace-sensitive; mixing tabs and spaces breaks it.
- Forgetting the `trigger`, so the pipeline never runs automatically on push.

### Interview Questions
**Q: Where does a YAML pipeline definition live, and why does that matter?**
A: In a YAML file (conventionally `azure-pipelines.yml`) at the repo root, stored with the code — meaning it's version-controlled, reviewable, and always matched to the commit it built.

**What You Should Remember:** A YAML pipeline lives in your repo, defines `trigger`, `pool`, and `steps`, and is whitespace-sensitive. Start minimal, confirm it runs, then add real build/test steps.

---

## 10. Pipeline Structure: Stages, Jobs, Steps, Tasks

### In Plain English (Beginner Explanation)
Think of a pipeline like organizing a big event. **Stages** are the major phases (setup → the event → cleanup). **Jobs** are teams working within a phase (the catering team, the AV team) — different teams can work in parallel and may be in different rooms (agents). **Steps** are the individual actions each team performs, and **Tasks** are pre-built, reusable actions (like a rented machine that does one job well).

### The Four-Level Hierarchy
```
Pipeline
  └── Stage        (major phase: Build, Test, Deploy)
        └── Job    (runs on ONE agent; jobs can run in parallel)
              └── Step   (a single action)
                    - Task    (a prebuilt reusable action, e.g. Docker@2)
                    - Script  (an inline shell command)
```

### Definitions
| Level | What It Is | Key Fact |
|---|---|---|
| **Stage** | A major division of the pipeline (e.g., Build, Deploy). | Stages run sequentially by default; can depend on each other. |
| **Job** | A set of steps that run together on a single agent. | Different jobs may run on different agents; jobs can run in parallel. |
| **Step** | A single action within a job. | The smallest unit; either a task or a script. |
| **Task** | A prebuilt, reusable step (published by Microsoft or the marketplace). | Referenced like `Docker@2`, `AzureCLI@2` — the number is the task version. |

### Full Multi-Stage Example
```yaml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

stages:
  - stage: Build
    jobs:
      - job: BuildJob
        steps:
          - script: echo "Building..."
            displayName: 'Build step'

  - stage: Test
    dependsOn: Build
    jobs:
      - job: TestJob
        steps:
          - script: echo "Testing..."
            displayName: 'Test step'

  - stage: Deploy
    dependsOn: Test
    jobs:
      - job: DeployJob
        steps:
          - script: echo "Deploying..."
            displayName: 'Deploy step'
```

### Line-by-Line Explanation
- `stages:` — the top-level list of major phases.
- `- stage: Build` — defines a stage named "Build".
- `dependsOn: Build` — makes the Test stage wait for Build to succeed before starting (controls order).
- `jobs:` — the jobs within a stage.
- `- job: BuildJob` — a job that runs on a single agent.
- `steps:` — the actions within that job.

### Jobs in Parallel vs Sequential
By default, jobs within a stage run **in parallel** (if agents are available). Stages run **sequentially** by default (via `dependsOn`). This lets you, for example, run unit tests and linting as two parallel jobs in one stage, then move to a deploy stage only after both pass.

### Deployment Jobs (Special Job Type)
A special `deployment` job type targets an **Environment** and records deployment history, and supports strategies like `runOnce`, `rolling`, and `canary`:
```yaml
- deployment: DeployWeb
  environment: 'production'
  strategy:
    runOnce:
      deploy:
        steps:
          - script: echo "Deploying to production"
```

### Common Mistakes
- Assuming files created in one job are available in another — they're not, unless explicitly published/downloaded as artifacts (different jobs may be different agents).
- Forgetting `dependsOn`, causing stages to run in an unintended order or in parallel.
- Confusing a regular `job` with a `deployment` job — only the latter targets Environments and records deployment history.

### Interview Questions
**Q: Explain the stage/job/step/task hierarchy in Azure Pipelines.**
A: A pipeline contains stages (major phases), each stage contains jobs (each running on one agent, potentially in parallel), each job contains steps (single actions), and a step can be a prebuilt task or an inline script.

**Q: Do files persist between jobs automatically?**
A: No — different jobs may run on different agents; to share files between jobs you must publish them as pipeline artifacts in one job and download them in another.

**Q: What's special about a deployment job?**
A: It targets an Environment, records deployment history, and supports deployment strategies (runOnce, rolling, canary) — unlike a regular job.

**What You Should Remember:** Pipeline → Stages → Jobs → Steps (Tasks/Scripts). Stages are sequential by default; jobs run in parallel; each job is one agent. Files don't cross jobs unless published as artifacts. Deployment jobs target Environments.

---

## 11. Pipeline Triggers

### In Plain English (Beginner Explanation)
A trigger is the doorbell that tells your pipeline "start now." Different doorbells ring for different reasons: someone pushed code, someone opened a pull request, a scheduled alarm went off, or another pipeline finished and handed off the baton.

### Types of Triggers
| Trigger | Fires When |
|---|---|
| **CI trigger** (`trigger`) | Code is pushed to specified branches. |
| **PR trigger** (`pr`) | A pull request targets specified branches (for validation). |
| **Scheduled trigger** (`schedules`) | On a cron-based schedule (e.g., nightly). |
| **Pipeline trigger** (`resources.pipelines`) | Another pipeline completes (chaining). |

### CI Trigger Example (with Path/Branch Filters)
```yaml
trigger:
  branches:
    include:
      - main
      - releases/*
    exclude:
      - releases/experimental
  paths:
    include:
      - src/*
    exclude:
      - docs/*
```
- `branches: include/exclude` — run only for pushes to these branches.
- `paths: include/exclude` — only run if changed files match these paths (e.g., skip pipeline runs for docs-only changes).

### PR Trigger Example
```yaml
pr:
  branches:
    include:
      - main
```
This runs the pipeline against pull requests targeting `main` — the code-side equivalent of the build validation branch policy from [Section 6](#6-branch-policies--pull-request-workflows). Note: for Azure Repos, PR triggers are configured via branch policies rather than the `pr:` key (which is used for GitHub repos); this is a common source of confusion.

### Scheduled Trigger Example
```yaml
schedules:
  - cron: "0 2 * * *"
    displayName: 'Daily 2 AM build'
    branches:
      include:
        - main
    always: true
```
- `cron: "0 2 * * *"` — runs at 2:00 AM daily (standard cron syntax).
- `always: true` — runs even if there were no code changes since the last run.

### Pipeline Trigger (Chaining) Example
```yaml
resources:
  pipelines:
    - pipeline: upstreamBuild
      source: 'Build-Pipeline-Name'
      trigger:
        branches:
          include:
            - main
```
This runs the current pipeline automatically when the referenced upstream pipeline completes on `main`.

### Common Mistakes
- Using the `pr:` YAML key for Azure Repos (it's for GitHub); for Azure Repos, configure PR validation through branch policies.
- Forgetting `always: true` on scheduled builds, so they skip when there are no changes.
- Overly broad triggers causing unnecessary runs (use path filters to scope them).

### Interview Questions
**Q: What are the main types of pipeline triggers in Azure DevOps?**
A: CI triggers (on push), PR triggers (on pull request/validation), scheduled triggers (cron-based), and pipeline triggers (when another pipeline completes).

**Q: How do you avoid running a pipeline for documentation-only changes?**
A: Use path filters in the CI trigger to include only relevant source paths and exclude docs.

**Q: How is PR validation configured for Azure Repos vs GitHub?**
A: For GitHub, via the `pr:` trigger key in YAML; for Azure Repos, via a build validation branch policy on the target branch.

**What You Should Remember:** Triggers = CI (push), PR (validation), scheduled (cron), and pipeline (chaining). Use branch/path filters to scope runs. For Azure Repos, PR validation comes from branch policies, not the `pr:` key.

---

## 12. Variables and Variable Groups

### In Plain English (Beginner Explanation)
Variables are labeled sticky notes your pipeline reads at run time — "the environment is production," "the version is 2.3.1." A **variable group** is a shared drawer of these sticky notes that many pipelines can pull from, so you set a value once (like a connection string) and every pipeline uses the same one. And for secrets, there's a locked drawer that masks the value so it never shows up in logs.

### Simple Definition
**Variables** store reusable values (strings, flags, secrets) used across a pipeline. **Variable groups** bundle variables so they can be shared across multiple pipelines, and can link to Azure Key Vault for secrets.

### Defining Variables Inline
```yaml
variables:
  environment: 'production'
  buildConfiguration: 'Release'

steps:
  - script: echo "Building $(buildConfiguration) for $(environment)"
```
- `variables:` — declares pipeline variables.
- `$(variableName)` — the syntax to reference a variable's value in steps.

### Variable Syntax — Three Forms
| Syntax | When Evaluated | Use For |
|---|---|---|
| `$(var)` | Runtime (macro) | Most common — substituted when the step runs. |
| `${{ var }}` | Compile time (template expression) | Structural decisions before the run starts. |
| `$[ var ]` | Runtime expression | Conditions and expressions evaluated at runtime. |

### Secret Variables
Secret variables are masked in logs and not exposed to scripts unless explicitly mapped:
```yaml
steps:
  - script: echo "Deploying with key"
    env:
      API_KEY: $(mySecretVar)   # secret mapped into an env var for this step only
```
Secrets are typically set in the pipeline UI (marked as secret) or come from a Key Vault-linked variable group — never hardcoded in YAML.

### Variable Groups
```
Pipelines → Library → + Variable group
  → name it (e.g. "prod-config")
  → add variables (mark secrets as secret)
  → optionally link to Azure Key Vault
```
Referenced in YAML:
```yaml
variables:
  - group: 'prod-config'
  - name: localVar
    value: 'something'

steps:
  - script: echo "Using $(sharedConnectionString) from the group"
```
- `- group: 'prod-config'` — imports all variables from that variable group.
- You can mix group references and inline variables.

### Why It Matters
Variable groups centralize configuration and secrets so you don't duplicate (and later, inconsistently update) the same values across many pipelines. Linking to Key Vault means secrets live in one secure, auditable place.

### Common Mistakes
- Hardcoding secrets directly in YAML (visible in the repo) instead of using secret variables or Key Vault.
- Mixing up `$(var)`, `${{ var }}`, and `$[ var ]` syntax — they evaluate at different times and aren't interchangeable.
- Not marking a sensitive value as "secret," so it appears in plain text in logs.

### Interview Questions
**Q: What's the difference between `$(var)`, `${{ var }}`, and `$[ var ]`?**
A: `$(var)` is a runtime macro substituted when a step runs; `${{ var }}` is a compile-time template expression evaluated before the run; `$[ var ]` is a runtime expression used in conditions.

**Q: What is a variable group and when would you use one?**
A: A reusable set of variables (Pipelines → Library) shared across multiple pipelines, optionally linked to Azure Key Vault for secrets — used to centralize configuration and avoid duplicating values.

**Q: How does Azure DevOps protect secret variables?**
A: Secret variables are masked in logs and not exposed to scripts unless explicitly mapped into an environment variable for a specific step; they're ideally sourced from Key Vault.

**What You Should Remember:** Variables store reusable values; variable groups share them across pipelines and can link to Key Vault. Use `$(var)` most often; mark secrets as secret; never hardcode secrets in YAML.

---

## 13. Parameters

### In Plain English (Beginner Explanation)
Parameters are like the options on a coffee machine you choose before it starts brewing — size, strength, milk or no milk. Unlike variables (which the pipeline reads while running), parameters are chosen up front (at queue time or in a template) and can even change the shape of the pipeline itself, like adding or removing whole stages.

### Simple Definition
**Runtime parameters** let you provide typed inputs when a pipeline is queued (or when a template is used), and — unlike variables — they're evaluated at compile time, so they can conditionally include/exclude stages, jobs, or steps.

### Parameters vs Variables — The Key Difference
| | Parameters | Variables |
|---|---|---|
| Evaluated | Compile time (before run) | Mostly runtime |
| Can change pipeline structure? | Yes (add/remove stages) | No |
| Typed? | Yes (string, boolean, number, object, etc.) | Generally strings |
| Set when? | At queue time or template use | In YAML/UI/group |

### Defining and Using Parameters
```yaml
parameters:
  - name: environment
    displayName: 'Target Environment'
    type: string
    default: 'dev'
    values:
      - dev
      - test
      - prod
  - name: runTests
    type: boolean
    default: true

steps:
  - script: echo "Deploying to ${{ parameters.environment }}"

  - ${{ if eq(parameters.runTests, true) }}:
    - script: echo "Running tests"
```

### Line-by-Line Explanation
- `parameters:` — declares typed inputs.
- `type: string` with `values:` — creates a dropdown of allowed choices (like a Choice parameter).
- `default:` — the value used if none is provided.
- `${{ parameters.environment }}` — compile-time reference to a parameter's value.
- `${{ if eq(parameters.runTests, true) }}:` — conditionally includes the following step(s) only if `runTests` is true — this structural conditioning is something variables cannot do.

### Real-World Production Scenario
A deployment pipeline has an `environment` parameter (dev/test/prod) and a `deployInfra` boolean. When queued for prod, an approver selects `prod`; the parameter drives which service connection, variable group, and target the pipeline uses — and the `deployInfra` flag can conditionally include an entire Terraform stage only when infrastructure changes are needed.

### Common Mistakes
- Trying to use a variable where structural conditioning is needed — only parameters (compile-time) can add/remove stages.
- Forgetting that parameters are set at queue time, not mid-run — you can't change them once the run starts.
- Using `$(param)` syntax instead of `${{ parameters.param }}` — parameters use template expression syntax.

### Interview Questions
**Q: What's the difference between a parameter and a variable in Azure Pipelines?**
A: Parameters are typed, evaluated at compile time (before the run), can change pipeline structure (include/exclude stages), and are set at queue time; variables are mostly runtime string values that can't alter pipeline structure.

**Q: How would you conditionally include an entire stage based on user input?**
A: Use a runtime parameter (e.g., a boolean) with a `${{ if }}` template expression, since parameters are evaluated at compile time and can add or remove pipeline structure.

**What You Should Remember:** Parameters are typed, compile-time inputs set at queue time; they can conditionally shape the pipeline (add/remove stages) — something variables can't do. Reference them with `${{ parameters.x }}`.

---

## 14. Templates

### In Plain English (Beginner Explanation)
A template is a master recipe binder kept in one place that every kitchen borrows from, instead of each kitchen rewriting (and possibly messing up) the same basic steps. Write the "build and test a .NET app" steps once as a template, and every pipeline just references it — fix or improve it once, and every pipeline benefits.

### Simple Definition
**Templates** are reusable YAML fragments (steps, jobs, stages, or variables) stored in separate files that pipelines can include, reducing duplication and centralizing common logic.

### Types of Templates
| Type | Reuses |
|---|---|
| **Step template** | A reusable sequence of steps. |
| **Job template** | A reusable job (with its steps). |
| **Stage template** | A reusable stage (with its jobs). |
| **Variable template** | A reusable set of variables. |

### Step Template Example
Template file `templates/build-steps.yml`:
```yaml
parameters:
  - name: buildConfiguration
    type: string
    default: 'Release'

steps:
  - script: dotnet build --configuration ${{ parameters.buildConfiguration }}
    displayName: 'Build'
  - script: dotnet test --configuration ${{ parameters.buildConfiguration }}
    displayName: 'Test'
```

Main pipeline referencing it:
```yaml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

steps:
  - template: templates/build-steps.yml
    parameters:
      buildConfiguration: 'Release'
```

### Line-by-Line Explanation
- `parameters:` in the template — makes the template configurable per use.
- `- template: templates/build-steps.yml` — includes the template's steps at this point.
- `parameters:` under the reference — passes values into the template.

### Templates from a Different Repository
Templates can be shared org-wide by storing them in a central repo and referencing it as a resource:
```yaml
resources:
  repositories:
    - repository: templates
      type: git
      name: SharedProject/pipeline-templates

steps:
  - template: build-steps.yml@templates
```
- `resources.repositories` — declares an external repo containing templates.
- `@templates` — references the template from that declared repo alias.

### Why It Matters
Without templates, 30 pipelines each duplicate the same build logic; a single improvement means editing all 30. With templates, common logic lives once, centrally maintained — the same DRY principle as Jenkins Shared Libraries.

### Template Security & Governance
Templates can also enforce standards: a required template (via approvals/checks) can guarantee every pipeline runs mandatory security scans or follows org policy — the template becomes a governance control, not just a convenience.

### Common Mistakes
- Duplicating the same steps across many pipelines instead of extracting a template.
- Not parameterizing templates, making them rigid and single-use.
- Not versioning shared template repos, so a breaking template change instantly affects all consumers.

### Interview Questions
**Q: What problem do templates solve in Azure Pipelines?**
A: They eliminate duplicated pipeline logic by centralizing reusable steps/jobs/stages/variables in shared files, so improvements or fixes are made once and propagate to all consuming pipelines — similar to Jenkins Shared Libraries.

**Q: How can templates be shared across an entire organization?**
A: By storing them in a central Git repository, declaring that repo under `resources.repositories`, and referencing templates with the `@repoAlias` syntax.

**Q: How can templates enforce governance?**
A: A required template (enforced via approvals/checks) can mandate that every pipeline includes standard steps like security scans, turning the template into a policy control.

**What You Should Remember:** Templates (step/job/stage/variable) centralize reusable YAML, reducing duplication and enforcing standards — Azure DevOps's answer to Jenkins Shared Libraries. Parameterize and version them.

---

## 15. Service Connections

### In Plain English (Beginner Explanation)
A Service Connection is like a pre-approved supplier account. Instead of every recipe (pipeline) knowing the supplier's login details, you set up the account once, name it, and every recipe just says "use the approved supplier account" without ever seeing the actual password.

### Simple Definition
A **Service Connection** is a secure, reusable configuration storing the credentials/permissions to connect to an external service (Azure subscription, Docker registry, GitHub, Kubernetes, etc.), so pipelines reference it by name instead of embedding secrets in YAML.

### How It Works
Created once per project (scoped appropriately), a Service Connection authenticates against a target service — often via a **Service Principal** (Azure AD's service-account equivalent), a **Managed Identity**, or **Workload Identity Federation**. Pipelines reference it by name, and Azure DevOps injects authentication behind the scenes.

### Types of Service Connections
| Type | Used For |
|---|---|
| **Azure Resource Manager (ARM)** | Deploying to Azure resources (App Service, AKS, VMs). |
| **Docker Registry** | Pushing/pulling images from ACR, Docker Hub. |
| **GitHub** | Checking out code / triggering from GitHub repos. |
| **Kubernetes** | Connecting to a cluster for `kubectl`-based steps. |
| **Generic** | Any REST API needing a token/key. |

### Azure DevOps UI Navigation
```
Project Settings → Pipelines → Service connections → New service connection
  → choose type (Azure Resource Manager, Docker Registry, etc.)
  → authenticate (Service Principal / Managed Identity / Workload Identity Federation / manual)
  → name it (this name is what your YAML references)
  → Save
```

### YAML Pipeline Example
```yaml
steps:
  - task: AzureCLI@2
    inputs:
      azureSubscription: 'my-azure-connection'
      scriptType: 'bash'
      scriptLocation: 'inlineScript'
      inlineScript: |
        az group list --output table
```

### Line-by-Line Explanation
- `task: AzureCLI@2` — a built-in task running Azure CLI commands authenticated via a Service Connection.
- `azureSubscription: 'my-azure-connection'` — references the Service Connection by name; Azure DevOps handles the login.
- `inlineScript` — the CLI commands, now authenticated with no credentials in the YAML.

### Real-World Production Scenario
A team has `prod-azure-connection` scoped to a Service Principal with only Contributor rights on the production resource group — not the whole subscription. Every deployment pipeline references it by name; nobody sees the secret, and a compromised pipeline's blast radius is limited to that one resource group.

### Workload Identity Federation (Modern Best Practice)
Rather than long-lived Service Principal client secrets (which expire and can leak), **Workload Identity Federation** lets Azure DevOps authenticate to Azure using short-lived, automatically-issued tokens with no stored secret — the recommended modern approach, analogous to preferring IAM roles over static keys in AWS.

### Common Mistakes
- Granting a Service Connection Owner/Contributor at the subscription level "to avoid permission issues" — a serious least-privilege violation.
- Sharing one Service Connection across dev and prod, risking a dev pipeline touching production.
- Forgetting a Service Principal client secret can expire, causing confusing auth failures months later.

### Debugging/Troubleshooting
- **Symptom:** "AADSTS7000215: Invalid client secret" → **Cause:** expired Service Principal secret → **Fix:** rotate it in Azure AD and update the connection (or migrate to Workload Identity Federation).
- **Symptom:** "Authorization failed" mid-pipeline → **Cause:** the connection's identity lacks permission on the target → **Fix:** check the RBAC role assignment on the exact resource/resource group.

### Best Practices
- Scope each Service Connection as narrowly as possible (resource group, not subscription).
- Use separate connections per environment (dev/staging/prod).
- Prefer Workload Identity Federation / Managed Identity over long-lived client secrets.

### Interview Questions
**Q: What's the difference between a Service Connection and a Service Principal?**
A: A Service Principal is Azure AD's identity object for an application/service; a Service Connection is the Azure DevOps-side configuration storing and using that identity's credentials for pipeline tasks.

**Q: Why prefer Workload Identity Federation over a client secret for an ARM service connection?**
A: It avoids storing a long-lived secret that can expire or leak, using short-lived, automatically-issued tokens instead — more secure and lower-maintenance.

**Q: Why scope a Service Connection to a resource group instead of the whole subscription?**
A: To limit the blast radius if the connection is compromised — the principle of least privilege.

**What You Should Remember:** Service Connections keep external credentials out of YAML, referenced by name and scoped narrowly. Prefer Workload Identity Federation / Managed Identity over long-lived secrets.

---

## 16. Azure Key Vault Integration

### In Plain English (Beginner Explanation)
Azure Key Vault is a bank vault specifically for secrets — passwords, connection strings, certificates. Instead of scattering secrets across pipelines and variable groups, you store them once in the vault, and pipelines securely fetch exactly what they need at run time, with a full audit log of who accessed what.

### Simple Definition
**Azure Key Vault** is a managed Azure service for securely storing secrets, keys, and certificates. Azure Pipelines can pull secrets from it at runtime, either via a Key Vault-linked variable group or a dedicated task.

### Why Use Key Vault Instead of Pipeline Secrets
- **Centralized** — one secure store, not secrets duplicated across many pipelines/variable groups.
- **Auditable** — access is logged; you can see who/what retrieved a secret and when.
- **Rotatable** — update a secret in one place and every pipeline gets the new value.
- **Governed** — access controlled by Azure RBAC / access policies, separate from Azure DevOps permissions.

### Method 1: Key Vault-Linked Variable Group
```
Pipelines → Library → + Variable group → toggle "Link secrets from an Azure key vault"
  → select the Azure subscription (Service Connection) and the Key Vault
  → choose which secrets to expose
```
Then reference like any variable group:
```yaml
variables:
  - group: 'keyvault-secrets'

steps:
  - script: echo "Using secret"
    env:
      DB_PASSWORD: $(dbPassword)   # pulled from Key Vault via the linked group
```

### Method 2: AzureKeyVault Task
```yaml
steps:
  - task: AzureKeyVault@2
    inputs:
      azureSubscription: 'my-azure-connection'
      KeyVaultName: 'my-prod-vault'
      SecretsFilter: 'dbPassword,apiKey'
      RunAsPreJob: true
  - script: echo "Fetched secrets are now available as pipeline variables"
```
- `SecretsFilter` — which secrets to fetch (or `*` for all).
- Fetched secrets become masked pipeline variables for subsequent steps.

### Why It Matters
Storing secrets in Key Vault (rather than pipeline UI secrets) gives you centralized rotation, auditing, and Azure-native RBAC — critical for compliance and for reducing the number of places a secret could leak from.

### Common Mistakes
- Giving the Service Connection's identity broad access to the entire vault when it only needs a few secrets.
- Not rotating secrets, defeating one of Key Vault's main benefits.
- Fetching all secrets (`*`) when only two are needed, over-exposing the pipeline.

### Interview Questions
**Q: What are the ways to consume Azure Key Vault secrets in a pipeline?**
A: Via a Key Vault-linked variable group, or the AzureKeyVault task — both retrieve secrets at runtime and expose them as masked pipeline variables.

**Q: Why use Key Vault instead of storing secrets directly as pipeline secret variables?**
A: Centralized storage, audit logging, easy rotation across all consumers, and Azure-native RBAC governance separate from Azure DevOps permissions.

**What You Should Remember:** Key Vault centralizes secrets with auditing, rotation, and Azure RBAC. Consume it via a linked variable group or the AzureKeyVault task; grant least-privilege access and fetch only needed secrets.

---

## 17. Environments and Approvals

### In Plain English (Beginner Explanation)
An Environment is a named destination for your deployments — like "Production" or "Staging" — with a security gate in front of it. Approvals are the bouncer at that gate: before anything deploys to Production, a designated person must click "approve." This is how you keep automated pipelines from shipping to production without a human's final okay.

### Simple Definition
An **Environment** is a named deployment target in Azure Pipelines that records deployment history and supports **approvals and checks** — gates that must pass before a deployment job runs against it.

### How It Works
Deployment jobs (`deployment:`) target an environment. If that environment has an approval check, the pipeline **pauses** at that stage until a designated approver acts. Environments also track which pipeline run deployed what, giving deployment history and traceability.

### Azure DevOps UI Navigation
```
Pipelines → Environments → New environment
  → name it (e.g. "production")
  → (optionally add resources like a Kubernetes namespace or VM)
  → Approvals and checks → add:
      - Approvals (specific users/groups must approve)
      - Branch control (only deploy from certain branches)
      - Business hours (only deploy during allowed times)
      - Invoke Azure Function / REST API checks
```

### YAML Deployment Job Targeting an Environment
```yaml
stages:
  - stage: DeployProd
    jobs:
      - deployment: DeployWebApp
        environment: 'production'
        strategy:
          runOnce:
            deploy:
              steps:
                - script: echo "Deploying to production"
```
- `deployment:` — a special job type that targets an environment.
- `environment: 'production'` — the named environment; if it has an approval, the pipeline pauses here.
- `strategy: runOnce` — a deployment strategy (also `rolling`, `canary`).

### Types of Checks
| Check | Purpose |
|---|---|
| **Approvals** | Require named people/groups to approve. |
| **Branch control** | Only allow deployment from specific branches. |
| **Business hours** | Restrict deployments to allowed time windows. |
| **Invoke REST API / Azure Function** | Custom automated gates (e.g., query a change-management system). |
| **Exclusive lock** | Prevent concurrent deployments to the same environment. |

### Real-World Production Scenario
A pipeline deploys automatically to `dev` and `test`, but the `production` environment has an approval requiring a release manager plus a branch-control check allowing deploys only from `main`. When the pipeline reaches the prod stage, it pauses; the release manager reviews and approves during business hours, and only then does production deployment proceed.

### Deployment Strategies
- **runOnce** — deploy once, straightforwardly (most common).
- **rolling** — update instances in batches to reduce downtime.
- **canary** — deploy to a small subset first, validate, then roll out fully.

### Common Mistakes
- Not putting an approval on the production environment, allowing unreviewed production deploys.
- Confusing a regular `job` with a `deployment` job — only the latter targets environments and honors approvals.
- Setting approvals so broadly that any team member can approve production, undermining control.

### Interview Questions
**Q: How do you implement a manual approval before a production deployment in YAML pipelines?**
A: Use a `deployment` job targeting a `production` Environment that has an Approvals check configured — the pipeline pauses at that stage until a designated approver signs off.

**Q: What deployment strategies does Azure Pipelines support?**
A: runOnce (straightforward), rolling (batched updates to reduce downtime), and canary (deploy to a subset first, validate, then full rollout).

**Q: What kinds of checks can gate an environment besides manual approvals?**
A: Branch control, business hours, exclusive locks, and automated checks like invoking a REST API or Azure Function.

**What You Should Remember:** Environments are named deployment targets with approvals/checks and deployment history. Deployment jobs target them; approvals pause the pipeline until a human signs off. Strategies: runOnce, rolling, canary.

---

## 18. Azure Artifacts & Feeds

### In Plain English (Beginner Explanation)
Azure Artifacts is your private pantry of pre-made ingredients — reusable code packages (libraries, modules) that your teams build once and share across many projects. Instead of copying the same library into every project, you publish it once to a **feed** (a shelf in the pantry), and every project pulls the exact version it needs.

### Simple Definition
**Azure Artifacts** hosts package **feeds** for NuGet, npm, Maven, Python (pip), and Universal packages, letting teams publish, version, and share dependencies privately — plus store pipeline build artifacts.

### Two Kinds of "Artifacts"
1. **Package artifacts** (Azure Artifacts feeds) — versioned reusable packages (a shared .NET library, an npm module).
2. **Pipeline artifacts** — files produced by one pipeline job/stage and consumed by another (e.g., a compiled build passed from a Build stage to a Deploy stage).

### Feeds
```
Artifacts → + Create Feed → name it → set visibility/scope (project or organization)
```
A feed is a container for packages, with its own permissions and upstream sources.

### Publishing and Consuming a Package (npm Example)
```yaml
steps:
  - task: npmAuthenticate@0
    inputs:
      workingFile: .npmrc
  - script: npm publish
    displayName: 'Publish package to feed'
```
Consuming projects point their `.npmrc`/`nuget.config` at the feed URL and install packages as usual.

### Upstream Sources
A feed can have **upstream sources** (like the public npm registry or NuGet.org). When a package isn't in your feed, it's fetched from upstream and cached — giving you a single, controlled, auditable source for both internal and public packages, plus protection if the public source has an outage.

### Pipeline Artifacts (Passing Files Between Stages)
```yaml
# In the Build stage
- task: PublishPipelineArtifact@1
  inputs:
    targetPath: '$(Build.ArtifactStagingDirectory)'
    artifact: 'drop'

# In the Deploy stage
- task: DownloadPipelineArtifact@2
  inputs:
    artifact: 'drop'
    path: '$(Pipeline.Workspace)/drop'
```
- `PublishPipelineArtifact` — saves build output so later stages/jobs can retrieve it.
- `DownloadPipelineArtifact` — retrieves it in a later stage (which may run on a different agent).

### Why It Matters
Package feeds enable safe internal code reuse with proper versioning; pipeline artifacts are how build output survives the jump between jobs/stages that run on different agents.

### Common Mistakes
- Assuming build output automatically flows between stages — it doesn't; you must publish/download pipeline artifacts.
- Not versioning packages properly (e.g., always overwriting `latest`), breaking reproducibility.
- Over-broadening feed permissions, letting anyone publish/overwrite packages.

### Interview Questions
**Q: What's the difference between package artifacts and pipeline artifacts?**
A: Package artifacts are versioned reusable dependencies hosted in Azure Artifacts feeds (NuGet/npm/Maven/pip); pipeline artifacts are files produced in one pipeline job/stage and consumed in another via publish/download tasks.

**Q: What are upstream sources in a feed?**
A: External package sources (like npm.org or NuGet.org) that a feed proxies and caches, giving a single controlled source for both internal and public packages and resilience against upstream outages.

**What You Should Remember:** Azure Artifacts feeds host versioned packages (with upstream sources for public deps). Pipeline artifacts (publish/download tasks) move build output between jobs/stages that run on different agents.

---

## 19. Docker and Azure Container Registry (ACR)

### In Plain English (Beginner Explanation)
Docker packages your app into a self-contained box (an image) that runs the same anywhere. **Azure Container Registry (ACR)** is your private warehouse for these boxes. The pipeline builds the box, checks it for defects (scanning), and stores it in the warehouse, ready to be deployed to servers or Kubernetes.

### Simple Definition
Azure Pipelines can build **Docker images** and push them to **Azure Container Registry (ACR)** — Azure's private, managed Docker registry — for later deployment.

### The Docker Task
```yaml
steps:
  - task: Docker@2
    inputs:
      containerRegistry: 'my-acr-connection'
      repository: 'myapp'
      command: 'buildAndPush'
      Dockerfile: '**/Dockerfile'
      tags: |
        $(Build.BuildId)
        latest
```

### Line-by-Line Explanation
- `task: Docker@2` — the built-in Docker task (version 2).
- `containerRegistry: 'my-acr-connection'` — a Docker Registry Service Connection pointing at your ACR (handles authentication).
- `repository: 'myapp'` — the image repository name within ACR.
- `command: 'buildAndPush'` — builds the image and pushes it in one step.
- `Dockerfile:` — which Dockerfile to build.
- `tags:` — tags the image with both the unique build ID (traceable) and `latest`.

### Complete Pipeline: Build → Scan → Push to ACR
```yaml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

variables:
  imageRepo: 'myapp'
  tag: '$(Build.BuildId)'

stages:
  - stage: BuildAndPush
    jobs:
      - job: Docker
        steps:
          - task: Docker@2
            displayName: 'Build image'
            inputs:
              containerRegistry: 'my-acr-connection'
              repository: '$(imageRepo)'
              command: 'build'
              Dockerfile: '**/Dockerfile'
              tags: '$(tag)'

          - script: |
              trivy image --exit-code 1 --severity HIGH,CRITICAL $(imageRepo):$(tag)
            displayName: 'Scan image with Trivy'

          - task: Docker@2
            displayName: 'Push image'
            inputs:
              containerRegistry: 'my-acr-connection'
              repository: '$(imageRepo)'
              command: 'push'
              tags: '$(tag)'
```

### Explanation of Key Choices
- Building and pushing are split so a **Trivy scan** can run between them — the scan's `--exit-code 1` fails the pipeline if HIGH/CRITICAL vulnerabilities are found, preventing an insecure image from ever reaching ACR.
- Tagging with `$(Build.BuildId)` gives each image a unique, traceable version tied to the exact pipeline run.

### ACR Authentication
The Docker Registry Service Connection handles ACR login. In production, prefer authenticating via a Service Principal or Managed Identity scoped to just push/pull on that registry — not broad credentials.

### Why It Matters
This is the packaging heart of container-based CD: a consistent, scanned, versioned image in ACR is what gets deployed to AKS or App Service downstream.

### Common Mistakes
- Relying only on the `latest` tag, losing the ability to trace or roll back to a specific version.
- Skipping image scanning, discovering critical CVEs only after they're in production.
- Not cleaning up old images in ACR, letting registry storage (and cost) grow unbounded.

### Interview Questions
**Q: How does an Azure pipeline authenticate to push images to ACR?**
A: Via a Docker Registry Service Connection (ideally backed by a Service Principal or Managed Identity scoped to that registry), referenced by the Docker task's `containerRegistry` input.

**Q: Why split the Docker build and push into separate steps?**
A: To insert a security scan (e.g., Trivy) between them so a vulnerable image fails the pipeline before it's ever pushed to the registry.

**Q: Why tag images with the build ID rather than just `latest`?**
A: For traceability and rollback — each image maps to a specific pipeline run, whereas `latest` is ambiguous and constantly overwritten.

**What You Should Remember:** The Docker@2 task builds/pushes images to ACR via a registry Service Connection. Split build/push to scan in between, tag with the build ID for traceability, and prefer Managed Identity for auth.

---

## 20. Kubernetes and AKS Integration

### In Plain English (Beginner Explanation)
Kubernetes runs and manages your containerized apps at scale; **AKS (Azure Kubernetes Service)** is Azure's managed Kubernetes. Your pipeline's job is to take the image from ACR and tell AKS "run this new version" — then confirm it actually came up healthy, not just that the command didn't error.

### Simple Definition
Azure Pipelines deploys containerized applications to **Azure Kubernetes Service (AKS)** using `kubectl`, Helm, or the Kubernetes manifest task, authenticated via a Kubernetes Service Connection or an Environment resource.

### Deploying with the Kubernetes Manifest Task
```yaml
- task: KubernetesManifest@1
  displayName: 'Deploy to AKS'
  inputs:
    action: 'deploy'
    kubernetesServiceConnection: 'my-aks-connection'
    namespace: 'production'
    manifests: |
      manifests/deployment.yaml
      manifests/service.yaml
    containers: 'myacr.azurecr.io/myapp:$(Build.BuildId)'
```

### Line-by-Line Explanation
- `task: KubernetesManifest@1` — the task for applying Kubernetes manifests.
- `action: 'deploy'` — apply the manifests to the cluster.
- `kubernetesServiceConnection:` — the Service Connection authenticating to AKS.
- `namespace:` — the target Kubernetes namespace.
- `manifests:` — the YAML files describing the desired state (Deployment, Service).
- `containers:` — the specific image (with build-ID tag) to inject into the deployment, ensuring the exact version built by this run is deployed.

### Deploying with kubectl Directly
```yaml
- task: Kubernetes@1
  inputs:
    connectionType: 'Kubernetes Service Connection'
    kubernetesServiceConnection: 'my-aks-connection'
    command: 'set'
    arguments: 'image deployment/myapp myapp=myacr.azurecr.io/myapp:$(Build.BuildId) -n production'
```
Followed by a rollout check:
```yaml
- script: |
    kubectl rollout status deployment/myapp -n production --timeout=120s
  displayName: 'Verify rollout'
```
The `rollout status` check with a timeout is critical — it confirms the new pods are actually healthy, preventing "the pipeline says success but the app is broken."

### Deploying with Helm
```yaml
- task: HelmDeploy@0
  inputs:
    connectionType: 'Kubernetes Service Connection'
    kubernetesServiceConnection: 'my-aks-connection'
    namespace: 'production'
    command: 'upgrade'
    chartType: 'FilePath'
    chartPath: 'charts/myapp'
    releaseName: 'myapp'
    overrideValues: 'image.tag=$(Build.BuildId)'
```
Helm packages Kubernetes manifests as reusable, parameterized **charts** — cleaner for complex apps than raw manifests.

### Environments + AKS (Approvals for Prod)
Point the deployment job's `environment` at an AKS-resource-backed environment, and add an approval check so production Kubernetes deployments pause for sign-off (as in [Section 17](#17-environments-and-approvals)).

### Rollback
```bash
kubectl rollout undo deployment/myapp -n production
```
Or with Helm: `helm rollback myapp <revision>`. Have this documented and rehearsed before you need it under pressure.

### Common Mistakes
- Not checking `rollout status`, so the pipeline reports success while pods crash-loop in the background.
- Granting the Kubernetes Service Connection cluster-admin instead of namespace-scoped permissions.
- Deploying `latest` instead of a specific image tag, making rollback ambiguous.

### Troubleshooting Pods
| Symptom | Likely Cause | Check |
|---|---|---|
| Pod `Pending` | Insufficient cluster resources / scheduling | `kubectl describe pod <name>` |
| `CrashLoopBackOff` | App crashing on startup | `kubectl logs <pod> --previous` |
| `ImagePullBackOff` | Wrong image tag or missing pull secret | Image name/tag; ACR pull permission |

### Interview Questions
**Q: How do you deploy to AKS from Azure Pipelines?**
A: Using the KubernetesManifest task, the Kubernetes/kubectl task, or HelmDeploy — authenticated via a Kubernetes Service Connection or an environment resource — injecting the specific image tag built by the pipeline.

**Q: How do you ensure a Kubernetes deployment actually succeeded, not just that kubectl returned no error?**
A: Run `kubectl rollout status` with a timeout after the deploy, which waits for the new pods to become healthy and fails the pipeline if they don't.

**Q: How would you add a manual approval before deploying to production AKS?**
A: Target the deployment job at an Environment (backed by the AKS namespace) that has an Approvals check configured, pausing the pipeline for sign-off.

**What You Should Remember:** Deploy to AKS via KubernetesManifest/kubectl/Helm tasks with a Kubernetes Service Connection, always inject a specific image tag, always verify with `rollout status`, scope permissions per namespace, and gate prod with Environment approvals.

---

## 21. Terraform and Bicep with Azure Pipelines

### In Plain English (Beginner Explanation)
Terraform and Bicep are blueprints for the building itself — the servers, networks, and cloud resources — rather than the application. Instead of clicking around the Azure portal to create resources by hand, you describe them in code, and the pipeline builds/updates them predictably. The `plan` step is like showing the blueprint to the owner before construction starts, so nothing is built by surprise.

### Simple Definition
**Terraform** (multi-cloud) and **Bicep** (Azure-native) are Infrastructure-as-Code tools. Azure Pipelines can run them to provision and manage cloud infrastructure with a safe plan → approve → apply flow.

### Terraform Core Commands
| Command | Purpose |
|---|---|
| `terraform fmt` | Auto-formats code consistently. |
| `terraform validate` | Checks syntax without touching real infra. |
| `terraform init` | Initializes providers and remote state backend. |
| `terraform plan` | Dry run — shows exactly what would change. |
| `terraform apply` | Makes the real changes. |
| `terraform destroy` | Tears down managed infrastructure. |

### Terraform Pipeline: fmt → validate → plan → approval → apply
```yaml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

stages:
  - stage: Plan
    jobs:
      - job: TerraformPlan
        steps:
          - task: TerraformInstaller@1
            inputs:
              terraformVersion: 'latest'
          - script: terraform fmt -check
            displayName: 'Format check'
          - task: TerraformTaskV4@4
            displayName: 'Init'
            inputs:
              provider: 'azurerm'
              command: 'init'
              backendServiceArm: 'my-azure-connection'
              backendAzureRmResourceGroupName: 'tfstate-rg'
              backendAzureRmStorageAccountName: 'tfstatestorage'
              backendAzureRmContainerName: 'tfstate'
              backendAzureRmKey: 'prod.terraform.tfstate'
          - task: TerraformTaskV4@4
            displayName: 'Validate'
            inputs:
              command: 'validate'
          - task: TerraformTaskV4@4
            displayName: 'Plan'
            inputs:
              provider: 'azurerm'
              command: 'plan'
              environmentServiceNameAzureRM: 'my-azure-connection'
              commandOptions: '-out=tfplan'

  - stage: Apply
    dependsOn: Plan
    jobs:
      - deployment: TerraformApply
        environment: 'infra-production'   # approval configured here
        strategy:
          runOnce:
            deploy:
              steps:
                - task: TerraformTaskV4@4
                  displayName: 'Apply'
                  inputs:
                    provider: 'azurerm'
                    command: 'apply'
                    environmentServiceNameAzureRM: 'my-azure-connection'
                    commandOptions: 'tfplan'
```

### Explanation of Key Choices
- **fmt/validate** run early as fast, cheap fail-gates.
- **Remote state** is stored in an Azure Storage account (the `backend*` inputs) so state is shared, durable, and consistent across runs — not stuck on one agent's disk.
- **plan -out=tfplan** saves the exact plan; the apply stage applies that same saved plan, so what's approved is exactly what's applied.
- The **Apply stage is a deployment job targeting an environment with an approval**, so a human reviews the plan before any real infrastructure changes.

### Remote State & State Locking
Terraform state records what infrastructure exists. Storing it remotely (Azure Storage) with locking (Azure Storage blob leases) prevents two applies from corrupting state simultaneously and lets the whole team/pipeline share one consistent view.

### Bicep (Azure-Native Alternative)
Bicep is Azure's own IaC language (compiles to ARM templates). Deploy via Azure CLI:
```yaml
- task: AzureCLI@2
  inputs:
    azureSubscription: 'my-azure-connection'
    scriptType: 'bash'
    scriptLocation: 'inlineScript'
    inlineScript: |
      az deployment group create \
        --resource-group my-rg \
        --template-file main.bicep \
        --parameters environment=prod
```
Bicep needs no separate state file (Azure tracks resource state), making it simpler for purely-Azure environments; Terraform is preferred for multi-cloud or when a large existing Terraform codebase exists.

### Common Mistakes
- Running `apply` without reviewing a `plan` — risks unexpected destructive changes.
- Not using remote state with locking, leading to corrupted/conflicting state.
- Sharing one state file across all environments instead of separating dev/staging/prod.
- Re-planning right before apply instead of applying a saved plan, letting drift sneak in unreviewed.

### Interview Questions
**Q: How do you safely run Terraform in an Azure pipeline for production?**
A: fmt → validate (fast gates) → init with remote state → plan saved to a file → a deployment job targeting an environment with an approval → apply the exact saved plan file.

**Q: Why store Terraform state remotely with locking?**
A: So the team/pipeline shares one consistent, durable view of infrastructure, and to prevent two simultaneous applies from corrupting state.

**Q: When would you choose Bicep over Terraform?**
A: For purely-Azure environments where Azure-native tooling and no separate state file is preferred; Terraform suits multi-cloud or existing large Terraform codebases.

**What You Should Remember:** IaC in Azure Pipelines = fmt → validate → plan (saved) → approval (environment) → apply the saved plan. Use remote state + locking, separate state per environment. Bicep = Azure-native, no state file; Terraform = multi-cloud.

---

## 22. Complete Multi-Stage CI/CD Pipeline Design

### In Plain English (Beginner Explanation)
This is the full dinner service, end to end: an order comes in, ingredients are gathered, the dish is cooked, tasted for quality, checked for safety, plated, delivered to each table (dev → test → prod), and someone confirms the customer is actually happy — not just that the plate left the kitchen.

### Simple Definition
This section combines everything into one realistic multi-stage YAML pipeline: from code push to a running app in AKS, with quality/security gates and environment approvals along the way.

### The Full Flow
```
Push to Azure Repos → CI trigger
   → Build
   → Unit Tests (publish results)
   → Code Quality (SonarQube)
   → Docker Build → Trivy Scan → Push to ACR
   → Deploy to Dev (auto)
   → Deploy to Test (auto)
   → Deploy to Prod (approval required)
   → Smoke Test
   → Notify (Teams)
```

### Complete Pipeline
```yaml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

variables:
  - group: 'shared-config'
  - name: imageRepo
    value: 'myapp'
  - name: tag
    value: '$(Build.BuildId)'

stages:
  - stage: Build
    jobs:
      - job: BuildAndTest
        steps:
          - task: UseDotNet@2
            inputs:
              packageType: 'sdk'
              version: '8.x'
          - script: dotnet build --configuration Release
            displayName: 'Build'
          - script: dotnet test --configuration Release --logger trx
            displayName: 'Unit tests'
          - task: PublishTestResults@2
            inputs:
              testResultsFormat: 'VSTest'
              testResultsFiles: '**/*.trx'
            condition: always()
          - task: SonarCloudPrepare@2
            inputs:
              SonarCloud: 'sonarcloud-connection'
              organization: 'my-org'
              scannerMode: 'MSBuild'
              projectKey: 'myapp'
          - task: SonarCloudAnalyze@2

  - stage: Package
    dependsOn: Build
    jobs:
      - job: DockerBuildScanPush
        steps:
          - task: Docker@2
            displayName: 'Build image'
            inputs:
              containerRegistry: 'my-acr-connection'
              repository: '$(imageRepo)'
              command: 'build'
              Dockerfile: '**/Dockerfile'
              tags: '$(tag)'
          - script: trivy image --exit-code 1 --severity HIGH,CRITICAL $(imageRepo):$(tag)
            displayName: 'Security scan'
          - task: Docker@2
            displayName: 'Push image'
            inputs:
              containerRegistry: 'my-acr-connection'
              repository: '$(imageRepo)'
              command: 'push'
              tags: '$(tag)'

  - stage: DeployDev
    dependsOn: Package
    jobs:
      - deployment: DeployToDev
        environment: 'dev'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: KubernetesManifest@1
                  inputs:
                    action: 'deploy'
                    kubernetesServiceConnection: 'aks-dev'
                    namespace: 'dev'
                    manifests: 'manifests/deployment.yaml'
                    containers: 'myacr.azurecr.io/$(imageRepo):$(tag)'

  - stage: DeployProd
    dependsOn: DeployDev
    jobs:
      - deployment: DeployToProd
        environment: 'production'   # approval configured on this environment
        strategy:
          runOnce:
            deploy:
              steps:
                - task: KubernetesManifest@1
                  inputs:
                    action: 'deploy'
                    kubernetesServiceConnection: 'aks-prod'
                    namespace: 'production'
                    manifests: 'manifests/deployment.yaml'
                    containers: 'myacr.azurecr.io/$(imageRepo):$(tag)'
                - script: kubectl rollout status deployment/myapp -n production --timeout=120s
                  displayName: 'Verify rollout'
                - script: curl -f https://myapp.example.com/health || exit 1
                  displayName: 'Smoke test'
```

### Why Each Stage Exists
- **Build** — compile, run unit tests (published for visibility), and static analysis (SonarCloud) to catch issues early.
- **Package** — build the Docker image, scan it (fail on HIGH/CRITICAL), and push to ACR only if clean.
- **DeployDev** — automatic deploy to a low-risk environment for integration validation.
- **DeployProd** — gated by an environment approval; after deploy, `rollout status` confirms health and a **smoke test** confirms the live app actually responds.

### Fail Fast Principle
Cheap, fast checks (unit tests, analysis) run before expensive ones (image build, cluster deploy). If unit tests fail, the pipeline stops in seconds without wasting time building/pushing images or touching a cluster.

### Common Mistakes
- Skipping the smoke test — deployment can "succeed" at the Kubernetes level while the app is actually broken.
- No approval on production, allowing unreviewed prod deploys.
- Slow/expensive stages before cheap ones, wasting resources on code already known to be broken.

### Interview Questions
**Q: Walk me through a complete multi-stage Azure DevOps CI/CD pipeline for a containerized app.**
A: Build + unit tests + static analysis → Docker build + security scan + push to ACR → auto-deploy to dev → approval-gated deploy to prod with rollout verification and a smoke test → notification — each stage a gate, ordered cheapest-check-first.

**Q: How do you prevent "the pipeline says success but the app is broken"?**
A: Add a `rollout status` check and a real smoke test (hitting a health endpoint) after deployment, so success reflects genuine application health, not just that the deploy command returned no error.

**What You Should Remember:** A production multi-stage pipeline chains build → test → quality → security → package → deploy (dev→prod with approvals) → verify → notify, ordered cheapest-check-first, with environment approvals gating production.

---

## 23. Release Pipelines (Classic) vs YAML Multi-Stage

### In Plain English (Beginner Explanation)
Older Azure DevOps split things in two: one tool to build (Build pipeline) and a separate visual tool to deploy (Release pipeline). The modern approach folds both into one written recipe (multi-stage YAML). Knowing both matters because many real companies still run Classic Release pipelines you'll need to maintain or migrate.

### Simple Definition
**Classic Release pipelines** are UI-based CD pipelines with visual stages, gates, and approvals. **Multi-stage YAML** achieves the same CD capabilities as code in a single YAML file — the modern recommended approach.

### Classic Release Pipeline Concepts
| Concept | Meaning |
|---|---|
| **Artifact** | The build output (from a build pipeline) that the release deploys. |
| **Stage** | A deployment target/phase (Dev, QA, Prod) in the visual designer. |
| **Pre/Post-deployment approvals** | Manual gates before/after a stage. |
| **Gates** | Automated checks (e.g., query monitoring before proceeding). |
| **Triggers** | Continuous deployment triggers when a new artifact is available. |

### Classic vs YAML — Comparison
| Aspect | Classic Release | Multi-Stage YAML |
|---|---|---|
| Definition | Visual UI designer | Code in repo |
| Version control | Stored in Azure DevOps | In your repo, versioned |
| Reviewable via PR | No | Yes |
| Approvals | Pre/post-deploy approvals | Environment checks/approvals |
| Recommended | Legacy/maintenance | Yes (modern default) |

### Why Migrate to YAML
Same reasons YAML beats Classic build pipelines: version control, reviewability, portability, auditability. Modern teams define the entire CI+CD flow in one YAML file with environments and approvals replacing Classic's release stages and gates.

### When Classic Still Appears
- Existing enterprise setups with mature Classic Release pipelines not yet migrated.
- Occasional reliance on a specific Classic-only integration or gate.

### Common Mistakes
- Starting new CD work in Classic Release out of habit instead of multi-stage YAML.
- Assuming Classic and YAML approvals are configured the same way — Classic uses pre/post-deploy approvals; YAML uses environment checks.

### Interview Questions
**Q: What's the difference between a Classic Release pipeline and a multi-stage YAML pipeline?**
A: Classic Release is a UI-based CD tool stored in Azure DevOps with visual stages/gates/approvals; multi-stage YAML defines the same CD as code in the repo, with environments and checks — version-controlled, reviewable, and the modern default.

**Q: How are approvals handled differently between the two?**
A: Classic uses pre/post-deployment approvals configured on release stages; YAML uses approvals-and-checks configured on Environments that deployment jobs target.

**What You Should Remember:** Classic Release = UI-based CD (legacy). Multi-stage YAML = CD as code (modern default), using Environments + checks in place of Classic release stages/gates. Know both; prefer YAML.

---

## 24. Agents and Agent Pools

### In Plain English (Beginner Explanation)
Agents are the workers who actually cook (run your pipeline jobs). **Microsoft-hosted** agents are like temp staff Microsoft sends fresh for each shift — zero maintenance, but you can't customize them much. **Self-hosted** agents are your own permanent staff — fully customizable with your exact tools and network access, but you maintain them. Agent **pools** are the staffing agencies that dispatch whichever worker is free.

### Simple Definition
An **agent** is a machine that runs pipeline jobs; an **agent pool** is a named group of agents that pipelines target. Agents are either **Microsoft-hosted** (managed, ephemeral) or **self-hosted** (your own, persistent).

### Microsoft-Hosted vs Self-Hosted
| Aspect | Microsoft-Hosted | Self-Hosted |
|---|---|---|
| Maintenance | None (Microsoft manages) | You patch/update them |
| Environment | Fresh VM each run | Persistent (caches survive) |
| Customization | Limited to preinstalled software | Full — any tools, any config |
| Private network access | No (public only) | Yes (can reach private resources) |
| Cost model | Parallel job minutes | Your own VM/infra cost |
| Best for | Standard builds, quick start | Custom toolchains, private resources, heavy caching |

### Targeting a Pool in YAML
```yaml
# Microsoft-hosted
pool:
  vmImage: 'ubuntu-latest'

# Self-hosted (by pool name, optionally with demands)
pool:
  name: 'my-selfhosted-pool'
  demands:
    - docker
    - agent.os -equals Linux
```
- `vmImage` — requests a Microsoft-hosted image.
- `name` — targets a self-hosted pool.
- `demands` — capability requirements (like Jenkins labels); the job only runs on agents that have those capabilities.

### Setting Up a Self-Hosted Agent
```
Organization Settings → Agent pools → (pool) → New agent
  → download the agent package for your OS
  → configure it with a Personal Access Token (PAT) and pool name
  → run it as a service so it persists
```

### Capabilities and Demands
Self-hosted agents advertise **capabilities** (installed software, environment variables). Pipelines specify **demands**, and jobs are dispatched only to agents meeting all demands — the Azure DevOps equivalent of Jenkins labels for routing jobs to the right agent.

### Scaling Strategies
- **Scale set agents**: back a self-hosted pool with an Azure Virtual Machine Scale Set that auto-scales agent count based on demand — combining self-hosted flexibility with elastic, cost-efficient scaling.
- **Container jobs**: run steps inside a specified container image for a clean, consistent environment without maintaining tool installs on the agent itself.

### Common Mistakes
- Using Microsoft-hosted agents when the build needs private network access they can't reach.
- Not using demands, so jobs land on agents missing required tools.
- Letting self-hosted agents drift (inconsistent tool versions across the pool), causing "works on one agent, not another."
- Under-provisioning parallel jobs, bottlenecking concurrent pipeline runs.

### Debugging/Troubleshooting
- **Symptom:** Job stuck "waiting for an available agent" → **Cause:** no idle agent matches the pool/demands, or parallelism is exhausted → **Fix:** add agents/parallel jobs, or check that demands match an agent's capabilities.
- **Symptom:** Self-hosted agent offline → **Cause:** the agent service stopped, PAT expired, or network lost → **Fix:** restart the agent service, renew the PAT, verify connectivity.

### Interview Questions
**Q: When would you use a self-hosted agent over a Microsoft-hosted one?**
A: When you need custom tools/software not preinstalled, access to private network resources, persistent caches for speed, or specific hardware — accepting that you maintain the agents.

**Q: What's the Azure DevOps equivalent of Jenkins labels for routing jobs?**
A: Capabilities (advertised by agents) and demands (required by pipelines) — jobs only run on agents meeting all specified demands.

**Q: How do you scale self-hosted agents elastically?**
A: Use a scale set agent pool backed by an Azure VM Scale Set that auto-scales agent count with demand.

**What You Should Remember:** Agents run jobs; pools group them. Microsoft-hosted = managed/ephemeral; self-hosted = customizable/persistent with private access. Route jobs via demands/capabilities; scale with VM scale set agents.

---

## 25. Azure DevOps RBAC & Security

### In Plain English (Beginner Explanation)
RBAC is the staff badge system: a dishwasher's badge doesn't open the manager's office, and an intern's badge doesn't let them delete the whole project. Everyone gets exactly the access their role requires — nothing more. In Azure DevOps this spans who can see/edit boards, push to repos, run pipelines, and administer the organization.

### Simple Definition
Azure DevOps security is layered: **organization-level** and **project-level** permissions, **security groups**, and **object-level** permissions (on repos, pipelines, environments), controlling who can do what.

### Permission Layers
| Layer | Controls |
|---|---|
| **Organization** | Create projects, manage billing, manage org policies. |
| **Project** | Access to a project's boards/repos/pipelines. |
| **Object-level** | Specific repo, branch, pipeline, or environment permissions. |

### Built-in Security Groups
| Group | Typical Access |
|---|---|
| **Project Administrators** | Full control within a project. |
| **Contributors** | Standard dev access — commit, create PRs, run pipelines. |
| **Readers** | Read-only. |
| **Project Collection Administrators** | Org-wide administration. |

### Access Levels (Licensing)
Separate from permissions, **access levels** (Stakeholder, Basic, Basic + Test Plans) determine which features a user can use based on their license — e.g., Stakeholders get limited free access (mostly Boards), while Basic gives full Repos/Pipelines access.

### Securing Pipelines Specifically
- **Service connection security**: restrict which pipelines can use a connection; require approvals for its use in certain environments.
- **Environment checks**: approvals, branch control, and exclusive locks (Section 17) protect deployment targets.
- **Protected resources**: service connections, agent pools, variable groups, and secure files can all require explicit pipeline authorization before use.
- **Secret management**: Key Vault + secret variables, never secrets in YAML.

### Personal Access Tokens (PATs)
PATs authenticate external tools/scripts/agents to Azure DevOps. Best practices: scope them minimally (only needed permissions), set short expiries, and rotate/revoke promptly — a leaked broad PAT is a serious risk.

### Real-World Production Scenario
Three teams share an organization. Each has its own project with Contributors scoped to that project only. Production environments require approval from a release-manager group. Service connections for prod are scoped to prod resource groups and restricted to specific pipelines. PATs used by CI tools are narrowly scoped with 30-day expiries.

### Common Mistakes
- Adding everyone to Project Administrators for convenience — violates least privilege.
- Broad, long-lived PATs — a leak grants wide access.
- Not restricting which pipelines can use production service connections.
- Storing secrets in YAML instead of Key Vault/secret variables.

### Interview Questions
**Q: What are the layers of security in Azure DevOps?**
A: Organization-level, project-level, and object-level (repo/branch/pipeline/environment) permissions, applied via built-in and custom security groups, plus access levels controlling feature availability by license.

**Q: How do you secure a production service connection?**
A: Scope its identity to just the needed resources (least privilege, ideally Workload Identity Federation), restrict which pipelines may use it, and require environment approvals for deployments that use it.

**Q: What are best practices for Personal Access Tokens?**
A: Minimal scope, short expiry, prompt rotation/revocation — treating them as sensitive credentials since a leaked broad PAT grants wide access.

**What You Should Remember:** Azure DevOps security = org/project/object permissions + security groups + access levels. Protect pipelines via scoped service connections, environment approvals, and Key Vault. Keep PATs minimal and short-lived.

---

## 26. Organization Administration & Extensions

### In Plain English (Beginner Explanation)
This is the manager's back office for the whole company (organization) — the room with master settings, policies, billing, and the "app store" (Marketplace extensions) where you install extra tools to bolt onto Azure DevOps.

### Key Administrative Areas
```
Organization Settings →
  Overview / Billing         → parallel jobs, user licenses, region
  Users                       → add/remove users, set access levels
  Projects                    → create/manage projects
  Policies                    → org-wide policies (e.g., third-party app access)
  Security / Permissions      → org-level security groups
  Agent pools                 → shared self-hosted/scale-set pools
  Extensions                  → installed Marketplace extensions
```

### Marketplace Extensions
The **Visual Studio Marketplace** offers extensions that add tasks, dashboard widgets, and integrations (e.g., SonarQube, Slack/Teams notifications, additional deployment tasks). Install org-wide, then use added tasks in pipelines like built-in ones.

### Project Collection vs Project Settings
- **Organization (Collection) Settings**: affect the whole org — billing, users, org policies, shared agent pools.
- **Project Settings**: affect one project — its service connections, environments, repos, and project-scoped permissions.

### Auditing
Azure DevOps provides an **auditing** stream (Organization Settings → Auditing) logging significant events — permission changes, pipeline modifications, service connection changes — useful for compliance and incident investigation.

### Common Mistakes
- Installing many unused extensions, increasing attack surface and maintenance.
- Confusing org-level and project-level settings when configuring service connections or pools.
- Not reviewing the audit log, missing unauthorized changes.

### Interview Questions
**Q: What's the difference between organization settings and project settings?**
A: Organization settings affect the whole org (billing, users, org policies, shared agent pools); project settings affect one project (its service connections, environments, repos, permissions).

**Q: How do you extend Azure DevOps with additional capabilities?**
A: Install extensions from the Visual Studio Marketplace, which add pipeline tasks, widgets, and integrations usable across the organization.

**What You Should Remember:** Org settings = whole-org (billing, users, policies, shared pools); project settings = single project. Marketplace extensions add tasks/integrations. Use the audit log for compliance/investigation.

---

## 27. Backup, Recovery & Maintenance

### In Plain English (Beginner Explanation)
For Azure DevOps Services (the cloud version), Microsoft handles the heavy lifting of backups and infrastructure — like renting a fully-managed building where the landlord handles structural maintenance. But you're still responsible for the furniture inside: your pipeline definitions, configurations, and the discipline to keep things clean and recoverable.

### Simple Definition
For **Azure DevOps Services** (SaaS), Microsoft manages platform availability and data durability. Your responsibility is protecting your *definitions and configurations* and maintaining hygiene. For **Azure DevOps Server** (self-hosted), you manage backups of the underlying SQL databases yourself.

### What You're Responsible For (Cloud)
- **Pipeline definitions**: stored as YAML in your repos — automatically version-controlled and recoverable (a key reason YAML beats Classic).
- **Repos**: Git is distributed; every clone is effectively a backup, but rely on Azure Repos plus developer clones.
- **Configuration**: service connections, variable groups, environments, and Classic pipelines are *not* in your repos — document them (ideally as code / infrastructure-as-code where possible) so they can be recreated.
- **Key Vault secrets**: backed up/rotated at the Azure level, separate from Azure DevOps.

### Azure DevOps Server (Self-Hosted) Backups
The self-hosted Server stores data in SQL Server databases; back these up regularly (full + transaction log backups), test restores, and keep the application tier configuration documented for disaster recovery.

### Maintenance & Hygiene
- **Retention policies**: configure how long pipeline runs, test results, and artifacts are kept (Project Settings → Pipelines → Settings → Retention) to control storage and cost.
- **Clean up old artifacts/images**: prune old ACR images and Azure Artifacts package versions to control cost.
- **Review permissions/PATs**: periodically audit access and revoke stale PATs.
- **Agent maintenance** (self-hosted): patch OS, update the agent software, keep tool versions consistent.

### Disaster Recovery Mindset
Because YAML pipelines live in Git, recreating a project's *automation* is largely restoring the repo. The gaps are the *non-repo config* (service connections, variable groups, environment approvals) — which is exactly why documenting or codifying these matters.

### Common Mistakes
- Assuming "cloud = nothing to back up" and never documenting non-repo config (service connections, variable groups), making recovery painful.
- Never setting retention policies, letting runs/artifacts accumulate and inflate cost.
- Not testing Azure DevOps Server restores (for self-hosted), discovering backup gaps during a real incident.

### Interview Questions
**Q: What are you responsible for backing up in Azure DevOps Services vs Server?**
A: In Services (cloud), Microsoft handles platform durability; you protect definitions/config — YAML in repos is recoverable, but non-repo config (service connections, variable groups, environments) must be documented/codified. In Server (self-hosted), you back up the underlying SQL databases yourself.

**Q: Why does using YAML pipelines improve disaster recovery?**
A: YAML pipeline definitions live in Git, so they're version-controlled and recoverable with the repo — unlike Classic pipelines stored only in Azure DevOps.

**What You Should Remember:** Cloud = Microsoft handles platform durability; you protect definitions (YAML in Git) and document non-repo config. Server = back up SQL yourself. Set retention policies and prune artifacts to control cost.

---

## 28. Troubleshooting Guide

### In Plain English (Beginner Explanation)
Troubleshooting is detective work: something went wrong, and you look for clues (symptoms), suspects (causes), the crime scene (where to look), and the fix. For each issue: **Symptoms → Likely Causes → Where to Check → Fix**.

### Pipeline Not Triggering
- **Symptoms**: Pushing code doesn't start the pipeline.
- **Causes**: Trigger branch/path filters exclude the change; CI trigger disabled; for Azure Repos, expecting the `pr:` key to work (it's GitHub-only).
- **Check**: The `trigger`/`pr` config and filters; pipeline settings; branch policies for PR validation.
- **Fix**: Adjust branch/path filters; for Azure Repos PR validation, use a build validation branch policy.

### YAML Syntax / Indentation Errors
- **Symptoms**: Pipeline fails to compile with a YAML parse error before running.
- **Causes**: Wrong indentation, tabs mixed with spaces, misplaced keys.
- **Check**: The exact line/column in the error; validate YAML formatting.
- **Fix**: Use consistent spaces (no tabs); use the pipeline editor's validation; check nesting under stages/jobs/steps.

### Job Waiting for an Available Agent
- **Symptoms**: Job stuck "waiting for an agent."
- **Causes**: No idle agent matches the pool/demands; parallel jobs exhausted; self-hosted agents offline.
- **Check**: Agent pool status; parallelism/billing; demands vs agent capabilities.
- **Fix**: Add agents/parallel jobs; bring self-hosted agents online; align demands with capabilities.

### Self-Hosted Agent Offline
- **Symptoms**: Agent shows offline in the pool.
- **Causes**: Agent service stopped; PAT expired; lost network/connectivity.
- **Check**: Agent host's service status and logs; PAT validity.
- **Fix**: Restart the agent service; renew the PAT; restore connectivity.

### Service Connection Authorization Failed
- **Symptoms**: "Authorization failed" or the pipeline can't use a connection.
- **Causes**: The connection's identity lacks RBAC on the target; pipeline not authorized to use the connection; expired Service Principal secret.
- **Check**: RBAC role on the exact resource/resource group; connection's pipeline authorization; secret expiry.
- **Fix**: Grant the needed role; authorize the pipeline; rotate the secret (or move to Workload Identity Federation).

### Invalid Client Secret (AADSTS7000215)
- **Symptoms**: Azure auth fails months after setup.
- **Causes**: The Service Principal's client secret expired.
- **Check**: The Service Principal's secret expiry in Azure AD.
- **Fix**: Rotate the secret and update the service connection, or migrate to Workload Identity Federation to avoid expiring secrets entirely.

### Key Vault Secret Not Available
- **Symptoms**: A Key Vault-sourced variable is empty or the task fails.
- **Causes**: The service connection's identity lacks Key Vault get/list permission; wrong vault/secret name; secret disabled.
- **Check**: Key Vault access policy / RBAC for the identity; secret name and status.
- **Fix**: Grant get/list on secrets; correct the name; enable the secret.

### Docker Build/Push to ACR Failing
- **Symptoms**: Docker task errors on build or push.
- **Causes**: Wrong registry service connection; identity lacks AcrPush; Dockerfile path wrong.
- **Check**: The `containerRegistry` connection; ACR role assignment; Dockerfile path glob.
- **Fix**: Fix the connection; grant AcrPush; correct the Dockerfile path.

### Trivy Scan Failing the Pipeline
- **Symptoms**: Pipeline stops at the scan step.
- **Causes**: HIGH/CRITICAL vulnerabilities found (working as intended), or Trivy not installed on the agent.
- **Check**: Scan output for actual CVEs; whether Trivy is available on the agent.
- **Fix**: Remediate the vulnerabilities (update base image/dependencies); install Trivy on self-hosted agents or use a container that includes it.

### Kubernetes/AKS Deployment Failure
- **Symptoms**: Deploy step fails or `rollout status` times out.
- **Causes**: Wrong image tag; pods crash-looping; insufficient cluster resources; missing pull secret.
- **Check**: `kubectl describe pod`, `kubectl logs --previous`, image tag correctness.
- **Fix**: Correct the tag; fix the app/config causing crashes; scale resources; fix ACR pull permissions.

### "Pipeline Succeeds but App Isn't Working"
- **Symptoms**: Green pipeline, broken app.
- **Causes**: No smoke test; `rollout status` not checked (or timeout too short); missing health/readiness probes.
- **Fix**: Add a smoke test hitting a real health endpoint; verify `rollout status` with adequate timeout; add liveness/readiness probes to the deployment.

### Files Missing Between Jobs/Stages
- **Symptoms**: A later job can't find files from an earlier one.
- **Causes**: Different jobs run on different agents; artifacts not published/downloaded.
- **Check**: Whether PublishPipelineArtifact/DownloadPipelineArtifact are used.
- **Fix**: Publish the files as a pipeline artifact in the producing job; download it in the consuming job.

### Variable/Parameter Not Resolving
- **Symptoms**: `$(var)` shows literally, or a parameter is empty.
- **Causes**: Wrong syntax for the context (`$(var)` vs `${{ }}` vs `$[ ]`); variable not in scope; secret not mapped.
- **Check**: The syntax and where the variable/parameter is defined and used.
- **Fix**: Use the correct expression syntax; ensure scope; map secrets into `env:` for scripts.

### Approval Stuck / Deployment Paused
- **Symptoms**: Pipeline paused indefinitely at a deployment stage.
- **Causes**: Waiting on an environment approval; approver unavailable; business-hours check.
- **Check**: The environment's pending approvals/checks.
- **Fix**: Have an authorized approver act; verify the approver group; check business-hours windows.

### General Diagnostic Flow
```
Pipeline failed?
  ├── Read the failing step's log first — always.
  ├── Compile/YAML error?         → fix indentation/syntax.
  ├── "Waiting for agent"?        → pool/demands/parallelism.
  ├── Auth/permission error?      → service connection RBAC, PAT, secret expiry.
  ├── Missing files across jobs?  → publish/download pipeline artifacts.
  ├── "Success" but app broken?   → add smoke test + rollout status.
  └── Still stuck?                → check environment approvals + agent capabilities.
```

**What You Should Remember:** Most Azure DevOps pipeline issues cluster into: trigger/filter misconfig, YAML indentation, agent/parallelism, service-connection auth/secret expiry, missing artifacts between jobs, and deployments that "succeed" without verifying real health. Build guardrails (smoke tests, rollout checks, Workload Identity Federation, retention) proactively.

---

## 29. Interview Questions Bank

### In Plain English (Beginner Explanation)
This is your interview rehearsal room — practice explaining these ideas in your own words, focusing on the *why* behind each choice, not just definitions.

### Beginner
**Q: What is Azure DevOps and what are its main services?**
A: An integrated Microsoft suite for the software delivery lifecycle: Azure Boards (planning), Repos (source control), Pipelines (CI/CD), Artifacts (packages), and Test Plans (testing).

**Q: What's the difference between CI, Continuous Delivery, and Continuous Deployment?**
A: CI = frequent integration with automated build/test. Continuous Delivery = always deployable, human approves release. Continuous Deployment = fully automatic release with no manual gate.

**Q: What's the difference between Classic and YAML pipelines?**
A: Classic is UI-designed and stored in Azure DevOps; YAML is defined as code in the repo — version-controlled, reviewable, portable, and the modern recommended approach.

**Q: What is a build validation policy?**
A: A branch policy that runs a pipeline against each pull request and blocks completion until it passes — CI for pull requests.

**Q: What are stages, jobs, steps, and tasks?**
A: A pipeline has stages (major phases), each with jobs (each on one agent, parallelizable), each with steps (single actions), where a step is a prebuilt task or an inline script.

### Intermediate
**Q: What's the difference between variables and parameters?**
A: Parameters are typed, compile-time inputs set at queue time that can change pipeline structure (add/remove stages); variables are mostly runtime string values that can't alter structure.

**Q: What is a variable group and how does it relate to Key Vault?**
A: A reusable set of variables shared across pipelines (Pipelines → Library), which can be linked to Azure Key Vault so secrets are centrally stored, audited, and rotated.

**Q: What is a Service Connection?**
A: A secure, reusable configuration storing credentials/permissions to an external service (Azure, ACR, Kubernetes), referenced by name in pipelines so secrets aren't embedded in YAML.

**Q: How do you share files between two jobs?**
A: Publish them as a pipeline artifact in the producing job and download them in the consuming job, since different jobs may run on different agents.

**Q: What are templates and what problem do they solve?**
A: Reusable YAML fragments (step/job/stage/variable) that eliminate duplication across pipelines and can enforce standards — Azure DevOps's equivalent of Jenkins Shared Libraries.

### Advanced
**Q: How do you implement a manual approval before production deployment?**
A: Use a deployment job targeting a production Environment that has an Approvals check; the pipeline pauses at that stage until an authorized approver signs off.

**Q: How do you safely run Terraform for production in Azure Pipelines?**
A: fmt → validate → init with remote state → plan saved to a file → a deployment job on an environment with an approval → apply the exact saved plan; use remote state with locking and per-environment separation.

**Q: What are the deployment strategies available for deployment jobs?**
A: runOnce (straightforward), rolling (batched to reduce downtime), and canary (subset first, validate, then full rollout).

**Q: Why prefer Workload Identity Federation over a Service Principal client secret?**
A: It avoids storing a long-lived secret that can expire or leak, using short-lived automatically-issued tokens — more secure and lower-maintenance.

### Production / Scenario-Based
**Q: Design a complete CI/CD pipeline for a containerized app deploying to AKS.**
A: Build + unit tests + static analysis → Docker build + Trivy scan + push to ACR → auto-deploy to dev → approval-gated deploy to prod with `rollout status` verification and a smoke test → Teams notification; cheapest checks first, prod gated by environment approval.

**Q: A pipeline shows success but the app is broken — how do you fix that?**
A: Add a smoke test hitting a real health endpoint and verify `kubectl rollout status` with an adequate timeout, plus liveness/readiness probes on the deployment, so success reflects genuine health.

**Q: How do you secure secrets in Azure Pipelines?**
A: Store them in Azure Key Vault (linked variable group or AzureKeyVault task) or as secret variables — never in YAML; grant least-privilege access and mask them in logs.

**Q: How do you scale build capacity?**
A: Add parallel jobs and agents; use self-hosted scale set agent pools for elastic, cost-efficient scaling and private network access; route jobs via demands/capabilities.

**Q: How would you set up PR validation for an Azure Repos repository?**
A: Configure a build validation branch policy on the target branch (e.g., `main`) that runs a pipeline against each PR and requires it to pass — plus required reviewers and work item linking.

**Q: How do you handle recovery/disaster preparedness in Azure DevOps Services?**
A: Rely on YAML pipelines in Git (version-controlled, recoverable) and document/codify non-repo config (service connections, variable groups, environments); Microsoft handles platform durability, but you protect definitions and config.

**Q: How would you enforce that every pipeline runs a security scan?**
A: Use a required/shared template that includes the security scan step, enforced via environment checks or org governance, so no pipeline can skip it.

**What You Should Remember:** Interviews probe *why* — be ready to justify trade-offs (Classic vs YAML, Microsoft-hosted vs self-hosted agents, Workload Identity Federation vs client secrets, variables vs parameters) rather than reciting definitions.

---

## 30. Azure DevOps Revision Cheat Sheet

### In Plain English (Beginner Explanation)
The laminated quick-reference card taped inside the kitchen door — what experienced staff glance at mid-shift instead of re-reading the whole handbook.

### Core Terminology
| Term | Meaning |
|---|---|
| Organization | Top-level container (dev.azure.com/&lt;org&gt;) |
| Project | Container for one team/product's boards, repos, pipelines |
| Azure Boards | Work tracking (epics/features/stories/tasks/bugs) |
| Azure Repos | Git repositories with branch policies & PRs |
| Azure Pipelines | CI/CD engine (Classic or YAML) |
| Azure Artifacts | Package feeds (NuGet/npm/Maven/pip) |
| Stage / Job / Step / Task | Pipeline hierarchy (phase / agent-unit / action / prebuilt action) |
| Agent / Pool | Machine running jobs / group of agents |
| Service Connection | Secure named connection to external services |
| Environment | Named deployment target with approvals/checks |
| Variable Group | Shared variables (Pipelines → Library), can link Key Vault |
| Template | Reusable YAML fragment |

### Pipeline Skeleton
```yaml
trigger:
  - main
pool:
  vmImage: 'ubuntu-latest'
variables:
  - group: 'shared-config'
stages:
  - stage: Build
    jobs:
      - job: BuildJob
        steps:
          - script: echo "build"
  - stage: Deploy
    dependsOn: Build
    jobs:
      - deployment: DeployJob
        environment: 'production'
        strategy:
          runOnce:
            deploy:
              steps:
                - script: echo "deploy"
```

### Variable Syntax
```
$(var)      → runtime macro (most common)
${{ var }}  → compile-time template expression (structure decisions)
$[ var ]    → runtime expression (conditions)
```

### Parameters
```yaml
parameters:
  - name: env
    type: string
    default: dev
    values: [dev, test, prod]
# use: ${{ parameters.env }}
```

### Triggers
```yaml
trigger:            # CI on push
  branches:
    include: [main]
  paths:
    exclude: [docs/*]
pr:                 # PR validation (GitHub); Azure Repos uses branch policies
  branches:
    include: [main]
schedules:
  - cron: "0 2 * * *"
    branches: { include: [main] }
    always: true
```

### Common Task References
```yaml
- task: Docker@2                    # build/push images
- task: KubernetesManifest@1        # deploy to Kubernetes
- task: HelmDeploy@0                # Helm deployments
- task: AzureCLI@2                  # run Azure CLI (via service connection)
- task: AzureKeyVault@2             # fetch secrets from Key Vault
- task: TerraformTaskV4@4           # Terraform init/plan/apply
- task: PublishPipelineArtifact@1   # publish files for later stages
- task: DownloadPipelineArtifact@2  # download them
- task: PublishTestResults@2        # publish test results
```

### Pipeline Artifacts Between Jobs
```yaml
- task: PublishPipelineArtifact@1
  inputs: { targetPath: '$(Build.ArtifactStagingDirectory)', artifact: 'drop' }
- task: DownloadPipelineArtifact@2
  inputs: { artifact: 'drop', path: '$(Pipeline.Workspace)/drop' }
```

### UI Navigation Quick Paths
```
Project Settings → Service connections     → external service auth
Pipelines → Library                        → variable groups / secure files
Pipelines → Environments                   → deploy targets + approvals
Repos → Branches → Branch policies         → PR validation, reviewers
Organization Settings → Agent pools        → self-hosted/scale-set agents
Organization Settings → Auditing           → audit log
```

### Troubleshooting Quick Checks
```
Not triggering?          → trigger branch/path filters; Azure Repos PR = branch policy
Waiting for agent?       → pool/demands/parallelism; self-hosted online?
Auth failed?             → service connection RBAC / PAT / secret expiry
Missing files in stage?  → publish/download pipeline artifacts
"Success" but broken?    → add smoke test + rollout status
Approval stuck?          → environment pending approvals/checks
```

### Security Checklist
- [ ] Secrets in Key Vault / secret variables (never in YAML)
- [ ] Service connections scoped narrowly (resource group, not subscription)
- [ ] Workload Identity Federation preferred over client secrets
- [ ] Production environment requires approval
- [ ] Branch policies (reviewers + build validation) on protected branches
- [ ] PATs minimally scoped and short-lived
- [ ] Least-privilege project/object permissions
- [ ] Image scanning (Trivy) fails pipeline on HIGH/CRITICAL
- [ ] Retention policies set to control cost

---

## 31. Beginner → Production Learning Roadmap

### In Plain English (Beginner Explanation)
Your training schedule as a new hire: what to learn day one versus what to save until you've mastered the basics, so you're never in over your head.

### Recommended Study Order

1. **Foundations** — What Azure DevOps is, CI/CD concepts, the org/project/agent architecture.
2. **Organization & Project Setup** — Create an org and project; choose Git and a work item process.
3. **Azure Repos & Boards** — Git workflow, branches, pull requests, branch policies, and basic work tracking.
4. **First YAML Pipeline** — Get a minimal `trigger`/`pool`/`steps` pipeline running; understand the run lifecycle.
5. **Pipeline Structure** — Stages, jobs, steps, tasks; parallel vs sequential; deployment jobs.
6. **Triggers, Variables, Parameters** — CI/PR/scheduled triggers; variable groups; typed parameters.
7. **Templates** — Extract reusable YAML once you have repeated logic across pipelines.
8. **Service Connections & Key Vault** — Secure external auth and secret management before touching real deployments.
9. **Environments & Approvals** — Deployment jobs targeting environments with approval gates.
10. **Docker & ACR** — Build, scan, and push container images.
11. **AKS Deployment** — Deploy to Kubernetes with `rollout status` verification and smoke tests.
12. **Terraform / Bicep** — Infrastructure as code with plan → approval → apply.
13. **Complete Multi-Stage Pipeline** — Combine everything into one realistic build→test→scan→deploy→verify flow.
14. **Agents & Scaling** — Microsoft-hosted vs self-hosted, demands/capabilities, scale set agents.
15. **RBAC, Admin, Backup/Recovery** — Security layers, org/project administration, recovery mindset.
16. **Troubleshooting Practice** — Deliberately break things (bad triggers, expired secrets, missing artifacts) and diagnose them.
17. **Interview Preparation** — Review the interview bank and cheat sheet, focusing on the *why* behind trade-offs.

### A Note on Pacing
Don't rush stages 1–9 — they form the mental model everything else builds on. Most people who feel lost in AKS/Terraform pipelines actually have a gap in fundamentals (usually pipeline structure, service connections, or environments), not in the advanced material itself. If something in the later parts feels confusing, revisit the corresponding fundamental first.

### How Azure DevOps Concepts Map to Jenkins (If You Know Jenkins)
| Jenkins | Azure DevOps |
|---|---|
| Jenkinsfile | azure-pipelines.yml |
| Stages/steps | Stages/jobs/steps/tasks |
| Credentials | Service connections + Key Vault + secret variables |
| Agents/labels | Agents/pools + demands/capabilities |
| Shared Libraries | Templates |
| Input step (approval) | Environment approvals |
| Multibranch Pipeline | CI/PR triggers + branch policies |
| Controller/Agent | Organization + agents/pools |

**What You Should Remember:** Learn in the order real systems are built — foundations, repos/boards, a working pipeline, then reusability, security, deployment targets, and finally scaling/admin. If you know Jenkins, the concepts map closely; the syntax and integrations differ.

---

*End of handbook.*
