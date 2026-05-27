# Certified Jenkins Engineer - Complete Production-Ready Notes

## Table of Contents

- [1. Introduction and Basics](#1-introduction-and-basics)
  - [1.1 Course Overview](#11-course-overview)
  - [1.2 Problem Statement - Dasher Team](#12-problem-statement---dasher-team)
  - [1.3 Introduction to Jenkins](#13-introduction-to-jenkins)
  - [1.4 Basics of SCM](#14-basics-of-scm)
  - [1.5 SCM Terminology](#15-scm-terminology)
  - [1.6 Basics of CI/CD](#16-basics-of-cicd)
  - [1.7 Software Testing](#17-software-testing)
- [2. Jenkins Setup and Interface](#2-jenkins-setup-and-interface)
  - [2.1 Jenkins Architecture](#21-jenkins-architecture)
  - [2.2 Jenkins Installation Options](#22-jenkins-installation-options)
  - [2.3 Jenkins Installation Demo](#23-jenkins-installation-demo)
  - [2.4 Running Jenkins WAR Standalone](#24-running-jenkins-war-standalone)
  - [2.5 Jenkins User Interface Overview](#25-jenkins-user-interface-overview)
  - [2.6 Build Timeout Plugin](#26-build-timeout-plugin)
  - [2.7 Timestamp Plugin](#27-timestamp-plugin)
  - [2.8 Types of Jenkins Projects](#28-types-of-jenkins-projects)
  - [2.9 Working with Freestyle Jobs](#29-working-with-freestyle-jobs)
- [3. Extending Jenkins and Administration](#3-extending-jenkins-and-administration)
  - [3.1 Jenkins Plugins Overview](#31-jenkins-plugins-overview)
  - [3.2 Installing Plugins](#32-installing-plugins)
  - [3.3 Managing Plugins](#33-managing-plugins)
  - [3.4 Manage Old Data](#34-manage-old-data)
  - [3.5 Reload Configuration from Disk](#35-reload-configuration-from-disk)
  - [3.6 Controller Failure - Freestyle Project](#36-controller-failure---freestyle-project)
  - [3.7 Jenkins Fingerprints](#37-jenkins-fingerprints)
- [4. Jenkins Pipelines](#4-jenkins-pipelines)
  - [4.1 Pipeline and Jenkinsfile](#41-pipeline-and-jenkinsfile)
  - [4.2 Additional Pipeline Configuration](#42-additional-pipeline-configuration)
  - [4.3 Build and Test via Pipeline](#43-build-and-test-via-pipeline)
  - [4.4 Pipeline Script from SCM](#44-pipeline-script-from-scm)
  - [4.5 Controller Failure - Pipeline Project](#45-controller-failure---pipeline-project)
  - [4.6 Blue Ocean Graphical Editor](#46-blue-ocean-graphical-editor)
- [5. Automation and Security](#5-automation-and-security)
  - [5.1 Organization Folder Project](#51-organization-folder-project)
  - [5.2 Adding Jenkinsfile to Solar System Repo](#52-adding-jenkinsfile-to-solar-system-repo)
  - [5.3 Using Options Directive](#53-using-options-directive)
  - [5.4 String Interpolation](#54-string-interpolation)
  - [5.5 Built-in When Conditions](#55-built-in-when-conditions)
- [6. Setting up CI Pipeline](#6-setting-up-ci-pipeline)
  - [6.1 Node.js Application Overview](#61-nodejs-application-overview)
  - [6.2 Solar System Application](#62-solar-system-application)
  - [6.3 Understanding DevOps Pipeline](#63-understanding-devops-pipeline)
  - [6.4 Installing Node.js Build Tool](#64-installing-nodejs-build-tool)
  - [6.5 Installing Dependencies](#65-installing-dependencies)
  - [6.6 Dependency Scanning](#66-dependency-scanning)
  - [6.7 Fixing Vulnerabilities and Publishing Reports](#67-fixing-vulnerabilities-and-publishing-reports)
- [7. Code Quality and Testing](#7-code-quality-and-testing)
  - [7.1 Unit Testing and JUnit Reports](#71-unit-testing-and-junit-reports)
  - [7.2 Code Coverage and Catch Errors](#72-code-coverage-and-catch-errors)
  - [7.3 Refactoring Jenkinsfile](#73-refactoring-jenkinsfile)
  - [7.4 SonarQube Introduction](#74-sonarqube-introduction)
  - [7.5 SAST Analysis with SonarQube](#75-sast-analysis-with-sonarqube)
  - [7.6 SonarQube Quality Gate and Refactoring](#76-sonarqube-quality-gate-and-refactoring)
- [8. Containerization and Deployment](#8-containerization-and-deployment)
  - [8.1 Building Docker Images](#81-building-docker-images)
  - [8.2 Vulnerability Scanning with Trivy](#82-vulnerability-scanning-with-trivy)
  - [8.3 Pushing to Docker Registry](#83-pushing-to-docker-registry)
  - [8.4 Understanding Deployment Approach](#84-understanding-deployment-approach)
  - [8.5 AWS Setup for Jenkins](#85-aws-setup-for-jenkins)
  - [8.6 Deploying to AWS EC2](#86-deploying-to-aws-ec2)
  - [8.7 Integration Testing on EC2](#87-integration-testing-on-ec2)
- [9. Kubernetes and GitOps](#9-kubernetes-and-gitops)
  - [9.1 Kubernetes Overview](#91-kubernetes-overview)
  - [9.2 Introduction to GitOps](#92-introduction-to-gitops)
  - [9.3 ArgoCD Concepts](#93-argocd-concepts)
  - [9.4 CI/CD with GitOps](#94-cicd-with-gitops)
  - [9.5 Manifest Repository and ArgoCD Configuration](#95-manifest-repository-and-argocd-configuration)
  - [9.6 Kubernetes Deploy - Update Image Tag](#96-kubernetes-deploy---update-image-tag)
  - [9.7 Kubernetes Deploy - Raise PR](#97-kubernetes-deploy---raise-pr)
  - [9.8 DAST and Manual Input](#98-dast-and-manual-input)
  - [9.9 Publishing Reports to AWS S3](#99-publishing-reports-to-aws-s3)
- [10. AWS Lambda and Advanced Deployment](#10-aws-lambda-and-advanced-deployment)
  - [10.1 AWS Lambda Basics](#101-aws-lambda-basics)
  - [10.2 Deploy to Production Gate](#102-deploy-to-production-gate)
  - [10.3 Using GenAI for Lambda Steps](#103-using-genai-for-lambda-steps)
  - [10.4 Manual Lambda Deployment](#104-manual-lambda-deployment)
  - [10.5 Lambda Deployment via Jenkinsfile](#105-lambda-deployment-via-jenkinsfile)
  - [10.6 Update Lambda Configuration](#106-update-lambda-configuration)
  - [10.7 Lambda Invoke Function](#107-lambda-invoke-function)

---

## 1. Introduction and Basics

### 1.1 Course Overview

Jenkins is the leading open-source automation server powering over **one million active installations** worldwide. Industry giants like AWS, IBM, and GitHub rely on Jenkins to streamline software delivery pipelines.

**Course Modules:**
1. Introduction to Jenkins (SCM, CI, CD)
2. Jenkins Architecture & Installation
3. Plugins Management
4. Jenkins Pipelines (Declarative & Scripted)
5. CI & Deployment (Node.js, SonarQube, Docker, AWS)
6. Kubernetes & GitOps (ArgoCD)
7. Administration & Monitoring (Prometheus, Grafana)
8. Backup & Configuration Management (JCasC, GitHub Actions)

> **Summary:** This course takes you from foundational Jenkins concepts to advanced production strategies including Kubernetes deployments, AWS Lambda, GitOps with ArgoCD, and enterprise security practices.

---

### 1.2 Problem Statement - Dasher Team

Dasher Technology's R&D team faces:
- No version control system
- Developers working in isolation
- Manual code integration and testing
- Infrequent merges causing instability
- Manual deployments across environments

**Solution Pipeline:**
1. Adopt GitHub for version control
2. Automate unit tests and code coverage
3. Build and push Docker images
4. Deploy to Kubernetes
5. Run automated integration tests

**Why Jenkins over other tools:**

| Tool | Pros | Cons |
|------|------|------|
| Jenkins | Extensible, self-hosted, large plugin library | Manual maintenance |
| Travis CI | Easy cloud setup | Limited concurrency |
| CircleCI | Fast workflows | Usage-based pricing |
| Spinnaker | K8s-centric | Complex configuration |

> **Summary:** In production, Jenkins is chosen for its extensibility, self-hosted nature, and massive plugin ecosystem. It requires more maintenance but provides unmatched flexibility for complex enterprise CI/CD pipelines.

---

### 1.3 Introduction to Jenkins

Jenkins is an open-source automation server that powers CI/CD — automating building, testing, and deploying applications every time code is pushed.

**How Jenkins Works:**
1. Developer pushes code to Git
2. Jenkins detects changes (polling or webhooks)
3. Checks out and builds the code
4. Runs unit tests and reports
5. Deploys on success
6. Provides feedback via UI/notifications

**Core Concepts:**

| Concept | Description |
|---------|-------------|
| **Job** | A task definition for building/testing/deploying |
| **Build** | A single execution of a job |
| **Freestyle Project** | GUI-based job with drag-and-drop steps |
| **Pipeline** | Groovy-based script in a Jenkinsfile |
| **Stage** | Logical block within a pipeline |
| **Node** | Machine where Jenkins executes tasks |
| **Plugin** | Extension to integrate external tools |

**Pros:**
- Free and open-source
- 1,800+ plugins
- Pipeline as Code (Jenkinsfile)
- Customizable with Groovy and shared libraries
- Scalable through distributed agents

**Cons:**
- Complex UI for beginners
- Requires regular maintenance
- Single server can become a bottleneck
- Security is user-managed
- Self-hosted (unlike GitHub Actions or GitLab CI)

> **Summary:** Jenkins is the most widely-used CI/CD automation server. It orchestrates the entire software delivery lifecycle through plugins, pipelines, and distributed agents. Its flexibility makes it ideal for complex enterprise workflows.

---

### 1.4 Basics of SCM

Source Code Management (SCM) stores every change to your codebase in a central repository, enabling parallel development.

**Key Benefits:**

| Feature | Benefit |
|---------|---------|
| Real-time Collaboration | Push/pull changes simultaneously |
| Code Review | Comment on PRs before merging |
| Conflict Resolution | Detect and resolve conflicts |
| Full Change History | Audit decisions, review past versions |
| Rollback Capability | Revert to stable versions |

**Popular SCM Platforms:**

| Platform | Hosting |
|----------|---------|
| GitHub | Cloud |
| GitLab | Cloud/Self-hosted |
| Bitbucket | Cloud |
| Gitea | Self-hosted |

**Basic Git Commands:**
```bash
git clone https://github.com/example/repo.git
git checkout -b feature/new-endpoint
git add .
git commit -m "Add new endpoint for user data"
git push origin feature/new-endpoint
```

> **Summary:** SCM is the foundation of CI/CD. It enables collaboration, versioning, code review, and rollback capabilities essential for any production environment.

---

### 1.5 SCM Terminology

| Term | Description |
|------|-------------|
| **Repository (Repo)** | Central storage for versioned code |
| **Diff** | Line-by-line comparison between versions |
| **Commit** | Snapshot of codebase at a point in time |
| **HEAD** | Pointer to the latest commit on current branch |
| **Pull Request (PR)** | Request to merge changes with review |
| **Branch** | Independent line of development |

**Best Practices:**
- One repository per product/microservice
- Assign read/write/admin roles
- Protect main branch with protection rules
- Use descriptive branch names (e.g., `feature/payment-api`)
- Never push directly to protected branches

> **Summary:** Understanding SCM terminology is critical for working with Jenkins pipelines. Every Jenkins pipeline starts with a checkout from SCM.

---

### 1.6 Basics of CI/CD

**Continuous Integration (CI)** automates frequent merging and testing of code changes:
1. Developer creates feature branch and commits
2. CI pipeline triggers on PR
3. Executes: Unit tests → Dependency scanning → Artifact building → Vulnerability scanning
4. If any stage fails, pipeline stops
5. Developer fixes issues and reruns

**CI Stages:**

| Stage | Purpose | Tools |
|-------|---------|-------|
| Unit Testing | Verify individual code units | pytest, JUnit |
| Dependency Scanning | Detect vulnerable libraries | npm audit, OWASP |
| Artifact Building | Package code | Docker, Maven |
| Security Scanning | Identify vulnerabilities | SonarQube, Snyk |

**Continuous Delivery vs Continuous Deployment:**
- **Continuous Delivery:** Automated deployment to staging; manual approval for production
- **Continuous Deployment:** Successful CI on main automatically deploys to production

> **Summary:** CI ensures code quality through automated testing on every commit. CD extends this to automated deployments. Together they form the backbone of modern DevOps practices.

---

### 1.7 Software Testing

**Types of Testing:**
- **Unit Testing** — Individual functions/methods in isolation
- **Integration Testing** — Modules communicate correctly
- **Smoke Testing** — Quick surface-level check of critical features
- **Functional Testing** — Validates against requirements
- **Non-Regression Testing** — New changes don't break existing functionality
- **Acceptance Testing** — End-user perspective testing
- **Code Quality/Static Analysis** — ESLint, SonarQube
- **Performance Testing** — Responsiveness under load
- **Security Testing** — SQL injection, XSS scanning

**Testing Principles:**

| Principle | Description |
|-----------|-------------|
| Speed & Frequency | Run unit tests on every commit |
| Cost Effectiveness | Maximize automated coverage |
| Failure Analysis | Fix smallest failing test first |
| Cascade Effect | Trace failures to smallest component |

> **Summary:** A balanced testing strategy runs fast unit tests on every commit, schedules heavier tests on build servers, and investigates failures from the bottom up.

---

## 2. Jenkins Setup and Interface

### 2.1 Jenkins Architecture

Jenkins uses a **distributed architecture** with a Controller-Agent model:

**Jenkins Controller (Master):**
- Authentication and authorization
- Defining, scheduling, and monitoring jobs
- Hosting the web UI and managing plugins
- Persisting credentials, job definitions, history

**Nodes (Agents/Workers):**
- Execute builds, tests, and deployments
- Connect via SSH or JNLP
- Can be physical, virtual, containers, or pods

**Executors:**
- Each node has configurable executors
- Each executor runs one build at a time
- Rule of thumb: one executor per CPU core

**Agent Types:**

| Agent Type | Description |
|-----------|-------------|
| SSH Agent | Controller connects via SSH |
| JNLP Agent | Node initiates connection to controller |
| Docker Agent | Builds inside containers |
| Kubernetes Agent | Ephemeral pods provisioned on demand |

**Deployment Topologies:**
- **Basic (Single-node):** Controller and worker are the same — for demos/POCs
- **Advanced (Distributed):** Separate controller and worker nodes — for production

> ⚠️ **Best Practice:** Never run resource-intensive builds on the controller in production. Keep it focused on coordination.

> **Summary:** Jenkins architecture separates coordination (controller) from execution (agents). This enables scalability, resilience, and isolation. In production, always use distributed topology with dedicated agents.

---

### 2.2 Jenkins Installation Options

**System Requirements:**

| Requirement | Minimum | Recommended |
|------------|---------|-------------|
| CPU | 2 cores | 4 cores |
| RAM | 256 MB | 4 GB |
| Disk | 1 GB | 50 GB |

**Installation Methods:**
1. **WAR File** — `java -jar jenkins.war`
2. **OS Packages** — `apt install jenkins` / `yum install jenkins`
3. **Graphical Installer** — Windows/macOS wizard
4. **Cloud Templates** — AWS Quick Start, Azure, GCP
5. **Docker** — `docker run -d -p 8080:8080 jenkins/jenkins:lts`

**JENKINS_HOME Directory:**

| Installation | Default Path |
|-------------|-------------|
| WAR File | `~/.jenkins` |
| Linux Package | `/var/lib/jenkins` |

> ⚠️ **Critical:** Always backup `JENKINS_HOME`. Losing it means losing ALL configurations, plugins, and build history.

> **Summary:** Jenkins can be installed multiple ways. For production, use OS packages or Docker with proper backup strategies for JENKINS_HOME.

---

### 2.3 Jenkins Installation Demo

**Step-by-step on Ubuntu:**

```bash
# Add Jenkins GPG key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add repository
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt-get update
sudo apt-get install -y jenkins

# Install Java 17 (required)
sudo apt install -y openjdk-17-jre fontconfig

# Start Jenkins
sudo systemctl restart jenkins
sudo systemctl status jenkins

# Get initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

**Setup Wizard:**
1. Open `http://<IP>:8080`
2. Enter admin password
3. Install suggested plugins or select manually
4. Create first admin user
5. Configure Jenkins URL

> **Summary:** Jenkins LTS on Ubuntu requires Java 17. After installation, the setup wizard guides you through plugin installation and user creation.

---

### 2.4 Running Jenkins WAR Standalone

Running Jenkins from WAR gives full control over JVM options, ports, and context paths:

```bash
# Download specific version
wget https://get.jenkins.io/war-stable/2.479.3/jenkins.war

# Run on custom port with context path
java -jar jenkins.war --httpPort=7777 --prefix=/dasher-technologies
```

**Common Startup Options:**

| Option | Description |
|--------|-------------|
| `--httpPort=<port>` | HTTP port (default 8080) |
| `--httpsPort=<port>` | HTTPS port |
| `--prefix=<path>` | URL context path |
| `--sessionTimeout=<min>` | Session timeout |
| `--httpsKeyStore=<path>` | Keystore for HTTPS |

> **Summary:** WAR-based deployment is useful for testing multiple Jenkins versions simultaneously or running Jenkins without OS package management.

---

### 2.5 Jenkins User Interface Overview

**Key UI Sections:**

| Section | Purpose |
|---------|---------|
| Dashboard | View all jobs, status, weather icons |
| Manage Jenkins | System settings, security, plugins |
| System Configuration | Home dir, executors, labels, URL |
| System Information | JVM properties, env vars, memory |
| Plugin Manager | Install, update, remove plugins |
| System Logs | Troubleshooting and diagnostics |

**Manage Jenkins Categories:**
- System Configuration
- Security
- System Information
- Troubleshooting
- Tools
- Actions (Reload config, safe restart, script console)

> **Summary:** The Jenkins UI provides centralized management for all CI/CD configurations. Familiarize yourself with Manage Jenkins for system administration tasks.

---

### 2.6 Build Timeout Plugin

Automatically terminates builds exceeding a specified duration.

> ⚠️ **Note:** This plugin does NOT apply to Pipeline jobs. Pipelines use their own `timeout` step.

**Timeout Strategies:**

| Strategy | Description |
|----------|-------------|
| Absolute | Fixed timeout in minutes (minimum 3) |
| Elastic | Percentage of recent successful builds |
| Deadline | Specific date/time cutoff |

**Post-Timeout Actions:**
- Abort the build
- Fail the build
- Execute extra build steps
- Write build description

**Configuration Scopes:**
- Global (all jobs)
- Job-level (Build Environment)
- Build-step level (Run with timeout)

> **Summary:** Build timeouts prevent runaway jobs from consuming resources. In production, configure global timeouts as a safety net and per-job timeouts for specific requirements.

---

### 2.7 Timestamp Plugin

Adds timestamps to console output for measuring step durations:

**Default format:** `HH:mm:ss`

**Custom format using Java SimpleDateFormat:**
```
yyyy-MM-dd'T'HH:mm:ss.SSSXXX
```

**Output example:**
```
2025-02-06T00:28:38.991+05:30  Started by user siddharth
2025-02-06T00:28:39.254+05:30  Finished: SUCCESS
```

**Configuration:**
- Per-job: Build Environment → Add timestamps to Console Output
- Global: Manage Jenkins → Configure System → Timestamper

> **Summary:** Timestamps are essential for debugging build performance and correlating events in production CI/CD pipelines.

---

### 2.8 Types of Jenkins Projects

| Project Type | Description | Best Use Case |
|-------------|-------------|---------------|
| Freestyle | UI-driven configuration | Simple tasks |
| Pipeline | Declarative/Scripted as code | Complex CI/CD workflows |
| Multibranch Pipeline | Auto branch discovery | GitFlow/feature branches |
| Maven Project | Native Maven integration | Java projects |
| Multi-configuration | Matrix builds | Cross-platform testing |
| Organization Folders | Scan and manage org repos | Large-scale teams |

**Limitations of Freestyle Projects:**
- Linear workflow only (no parallelism)
- Configuration not in source control
- Hard to manage and reuse
- Lacks conditional stages
- Cannot resume after controller failure

> **Summary:** In production, Pipeline or Multibranch Pipeline projects are preferred. They support versioning, parallelism, error recovery, and complex branching strategies.

---

### 2.9 Working with Freestyle Jobs

**Example: ASCII Artwork Generator Job**

```bash
#!/bin/bash
set -e

# Fetch advice from API
curl -s https://api.adviceslip.com/advice > advice.json

# Extract and validate
jq -r '.slip.advice' advice.json > advice.message
WORD_COUNT=$(wc -w < advice.message)
if [ "$WORD_COUNT" -le 5 ]; then
  echo "Advice has $WORD_COUNT words or less."
  exit 1
fi

# Install cowsay and render
sudo apt-get install cowsay -y
export PATH="$PATH:/usr/games:/usr/local/games"
cat advice.message | cowsay -f "$(shuf -n 1 /usr/share/cowsay/cows)"
```

> ⚠️ **Common Mistake:** Jenkins service user's PATH may exclude `/usr/games`. Always export PATH or configure it globally.

**Global Environment Variables:**
- Manage Jenkins → Configure System → Global properties → Environment variables

> **Summary:** Freestyle jobs are useful for simple automation tasks but lack the power of Pipeline jobs for complex workflows.

---

## 3. Extending Jenkins and Administration

### 3.1 Jenkins Plugins Overview

Jenkins plugins are distributed as `.hpi` or `.jpi` archives stored in `/var/lib/jenkins/plugins`.

**Common Plugin Categories:**

| Category | Examples |
|----------|----------|
| SCM | Git, GitHub Branch Source |
| Build Tools | Maven, Gradle |
| Quality & Security | SonarQube, OWASP |
| Notifications | Slack, Email Extension |
| Cloud | AWS Steps, Google Cloud Build |
| Distributed Builds | Swarm Plugin |

**Recommended Starter Plugins:**
- Git Integration
- Pipeline (Workflow)
- Maven Integration
- Docker Pipeline
- Blue Ocean

> **Summary:** Plugins extend Jenkins' capabilities. Choose verified plugins, keep them updated, and verify dependencies before uninstalling.

---

### 3.2 Installing Plugins

**Methods:**
1. **UI:** Manage Jenkins → Manage Plugins → Available → Search and Install
2. **CLI:** `jenkins-plugin-cli --plugins copyartifact:1.46.1`
3. **Upload HPI:** Advanced tab → Upload Plugin

**Copy Artifact Plugin Example:**
- Enables sharing build artifacts between jobs
- Permission must be configured: `copyArtifactPermission('job1,job2')`

**Yet Another Build Visualizer:**
- Displays upstream/downstream job relationships
- Visual pipeline flow diagrams

> **Summary:** Always install plugins from trusted sources and restart Jenkins when required. Use the Snippet Generator to understand plugin usage in pipelines.

---

### 3.3 Managing Plugins

**Uninstalling a Plugin:**
1. Manage Plugins → Installed → Uninstall
2. Plugin binary removed from `$JENKINS_HOME/plugins`
3. Job XMLs still reference the plugin until restart
4. **Must restart Jenkins** to fully clean up

> ⚠️ **Warning:** Removing a plugin can break dependent functionality. Always verify dependencies first.

> **Summary:** Plugin management requires careful dependency checking. After uninstalling, restart Jenkins and use Manage Old Data to clean orphaned configurations.

---

### 3.4 Manage Old Data

When plugins are uninstalled, their XML configurations remain in job configs.

**Steps to Clean:**
1. Navigate to Manage Jenkins → Troubleshooting → Manage Old Data
2. Restart Jenkins to detect stale entries
3. Click "Discard Unreadable Data"

> ⚠️ **Warning:** Discarding is irreversible. Backup job configurations before proceeding.

> **Summary:** Always clean up old data after uninstalling plugins to prevent `CannotResolveClassException` errors and maintain a healthy Jenkins instance.

---

### 3.5 Reload Configuration from Disk

Allows Jenkins to pick up filesystem changes without a full restart:

```bash
# Edit config.xml directly
vi /var/lib/jenkins/config.xml

# Change system message
<systemMessage>Welcome to Dasher Technologies</systemMessage>
```

Then: Manage Jenkins → Reload Configuration from Disk

**Use Cases:**
- Update `config.xml` settings
- Rename or move job folders
- Adjust security or plugin configs

> **Summary:** Reload from disk applies file-based edits instantly without restarting Jenkins. Useful for automated configuration management.

---

### 3.6 Controller Failure - Freestyle Project

**Key Finding:** When Jenkins controller stops, ALL running Freestyle jobs are **terminated** and do NOT resume after restart.

```bash
# Simulate controller failure
sudo systemctl stop jenkins

# Restart
sudo systemctl start jenkins
# Result: Freestyle job shows FAILURE
```

> ⚠️ **Critical Production Impact:** Freestyle projects cannot survive controller restarts. Use Pipeline projects for resilience.

> **Summary:** This is a major limitation of Freestyle projects. In production, always use Pipeline projects which checkpoint state and can resume after controller restarts.

---

### 3.7 Jenkins Fingerprints

Fingerprints track artifact usage across jobs using MD5 checksums.

**Configuration:**
1. Post-build Actions → Record fingerprints of files to track usage
2. Enter file pattern: `advice.json`

**Benefits:**
- Discover which builds produced/consumed a file
- Lightweight (stores checksum, not full artifact)
- View usage graph across pipeline

> **Summary:** Fingerprinting enables artifact traceability across complex job chains without storing duplicate copies.

---

## 4. Jenkins Pipelines

### 4.1 Pipeline and Jenkinsfile

A Jenkinsfile defines your CI/CD pipeline as code using Groovy syntax.

**Basic Structure:**
```groovy
pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Test') {
      steps {
        sh 'mvn test'
      }
    }
    stage('Deploy') {
      steps {
        sh 'kubectl apply -f deployment.yaml'
      }
    }
  }
}
```

**Declarative vs Scripted:**

| Feature | Declarative | Scripted |
|---------|-------------|----------|
| Syntax | Opinionated, structured | Unrestricted Groovy |
| Readability | High | Lower |
| Flexibility | Standard workflows | Full dynamic control |
| Error Handling | Built-in `post` | Custom try/catch |
| Learning Curve | Gentle | Steeper |

**Key Benefits:**
1. Code as Configuration (version controlled)
2. Resilience (resumes after restart)
3. Human Interaction (manual approvals)
4. Advanced Workflow (parallel, forks, loops)
5. Extensibility (plugins, shared libraries)

> **Summary:** Pipelines as code are the modern way to define CI/CD in Jenkins. They provide versioning, resilience, and complex workflow capabilities that Freestyle jobs cannot match.

---

### 4.2 Additional Pipeline Configuration

**Key Directives:**

| Directive | Purpose |
|-----------|---------|
| `pipeline` | Root block |
| `agent` | Where to execute |
| `environment` | Set env vars |
| `stages` | Group stages |
| `stage` | Named phase |
| `steps` | Commands to run |
| `post` | Post-build actions |
| `when` | Conditional execution |
| `script` | Arbitrary Groovy |
| `parameters` | User input |
| `parallel` | Concurrent execution |

**Environment Variables:**
```groovy
environment {
  GLOBAL_VAR = 'foo'
}
```

**Post Actions:**
```groovy
post {
  success { echo 'Succeeded!' }
  failure { echo 'Failed!' }
  always  { cleanWs() }
}
```

**Parallel Execution:**
```groovy
stage('Parallel Tasks') {
  parallel {
    stage('Unit Tests') { steps { sh 'mvn test' } }
    stage('Security Scan') { steps { sh './scan.sh' } }
  }
}
```

**Parameters:**
```groovy
parameters {
  string(name: 'ENV', defaultValue: 'dev', description: 'Environment')
  booleanParam(name: 'RUN_TESTS', defaultValue: true)
}
```

**Credentials:**
```groovy
withCredentials([usernamePassword(
  credentialsId: 'myCredentials',
  usernameVariable: 'USER',
  passwordVariable: 'PASS'
)]) {
  sh 'echo "Deploying as $USER"'
}
```

> **Summary:** Mastering pipeline directives is essential for building production-grade CI/CD workflows. Use parallel stages for speed, parameters for flexibility, and credentials for security.

---

### 4.3 Build and Test via Pipeline

```groovy
pipeline {
    agent any
    tools {
        maven "M398"
    }
    stages {
        stage('Echo Version') {
            steps {
                sh 'mvn -version'
            }
        }
        stage('Build') {
            steps {
                git branch: 'main', url: 'http://repo-url/jenkins-hello-world.git'
                sh 'mvn clean package -DskipTests=true'
            }
        }
        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
        }
    }
}
```

> ⚠️ **Common Mistake:** Default branch may be `main` not `master`. Always specify the branch explicitly.

> **Summary:** Pipeline stages separate build from test for clear failure identification. Use the Snippet Generator to craft correct Git checkout syntax.

---

### 4.4 Pipeline Script from SCM

**Best Practice:** Store Jenkinsfile in your repository, not inline in Jenkins UI.

**Configuration:**
1. Pipeline → Definition → "Pipeline script from SCM"
2. SCM: Git
3. Repository URL and branch
4. Script Path: `Jenkinsfile`

**Benefits:**
- Version controlled
- Code reviewable
- Shared across team
- Automatic checkout (no explicit `git` step needed)

```groovy
// Simplified - Jenkins auto-checks out the repo
pipeline {
  agent any
  tools { maven "M398" }
  stages {
    stage('Build') {
      steps {
        sh 'mvn clean package -DskipTests=true'
      }
    }
    stage('Unit Test') {
      steps {
        sh 'mvn test'
      }
    }
  }
}
```

> **Summary:** Always use "Pipeline script from SCM" in production. It ensures your pipeline definition is versioned alongside your application code.

---

### 4.5 Controller Failure - Pipeline Project

**Key Finding:** Pipeline projects **DO** survive controller restarts. They checkpoint state and resume from the last saved point.

```groovy
stage('Unit Test') {
  steps {
    script {
      for (int i = 0; i < 60; i++) {
        echo "${i + 1}"
        sleep 1
      }
    }
    sh 'mvn test'
  }
}
```

After controller restart:
```
Resuming build at Mon Aug 19 18:00:22 UTC 2024 after Jenkins restart
```

**To disable resume:**
- Job Configure → "Do not allow the pipeline to resume if the controller restarts"
- Or in Jenkinsfile: `options { disableResume() }`

> **Summary:** Pipeline resilience is a major advantage over Freestyle. In production, pipelines survive restarts and resume from checkpoints, ensuring long-running deployments complete successfully.

---

### 4.6 Blue Ocean Graphical Editor

Blue Ocean provides a modern UI for Jenkins pipelines:
- Visual pipeline editor
- Real-time stage monitoring
- Branch-level views for multibranch pipelines

**Installation:**
- Manage Plugins → Available → Search "blueocean" → Install

> **Summary:** Blue Ocean provides improved visualization for pipeline monitoring. While deprecated in newer Jenkins versions, it's still useful for visual pipeline creation and monitoring.

---

## 5. Automation and Security

### 5.1 Organization Folder Project

Automatically scans SCM organizations for repositories containing Jenkinsfiles:

**Benefits:**
- Single configuration for entire org
- Automatic branch discovery
- Scales with codebase
- Webhook-triggered builds

**Setup with Gitea:**
1. Install Gitea plugin
2. Configure Gitea server (API URL, credentials)
3. Create Organization Folder in Jenkins
4. Set owner to your org
5. Jenkins scans for Jenkinsfiles

**Scan Results:**
- Repos WITH Jenkinsfile → Pipeline created
- Repos WITHOUT Jenkinsfile → Skipped

> **Summary:** Organization Folders eliminate manual pipeline creation. In large organizations with hundreds of repos, this is the standard approach for pipeline management.

---

### 5.2 Adding Jenkinsfile to Solar System Repo

```groovy
pipeline {
  agent any
  tools {
    nodejs 'nodejs-22-6-0'
  }
  stages {
    stage('VM Node Version') {
      steps {
        sh '''
          node -v
          npm -v
        '''
      }
    }
  }
}
```

**Workflow:**
1. Create feature branch: `git checkout -b feature/enabling-cicd`
2. Add Jenkinsfile to repo root
3. Push branch
4. Jenkins detects via webhook
5. Multibranch pipeline auto-created

> **Summary:** Adding a Jenkinsfile to a repository is the first step in enabling CI/CD. Combined with Organization Folders, this enables automatic pipeline discovery and execution.

---

### 5.3 Using Options Directive

**Stage-level Options:**
```groovy
options {
  timestamps()  // Add timestamps to logs
  retry(2)      // Retry on failure
}
```

**Pipeline-level Options:**
```groovy
options {
  disableResume()                          // Don't resume after restart
  disableConcurrentBuilds(abortPrevious: true)  // Abort previous builds
}
```

| Option | Scope | Description |
|--------|-------|-------------|
| `timestamps()` | Stage | Prefix log lines with timestamp |
| `retry(count)` | Stage | Retry failing stage |
| `disableResume()` | Pipeline | Don't resume after restart |
| `disableConcurrentBuilds()` | Pipeline | Prevent concurrent runs |

> **Summary:** Options directive controls pipeline behavior at both stage and pipeline levels. Use `disableConcurrentBuilds(abortPrevious: true)` to prevent resource waste from superseded builds.

---

### 5.4 String Interpolation

**Key Rule:** Single quotes = literal, Double quotes = interpolation.

```groovy
def name = 'Jenkins'
echo 'Hello, ${name}!'    // Output: Hello, ${name}!
echo "Hello, ${name}!"    // Output: Hello, Jenkins!
```

**With Parameters:**
```groovy
echo "Hello, ${params.USER_NAME}"
```

**With Environment Variables:**
```groovy
echo "Greeting: ${env.GREETING}"
```

**With Expressions:**
```groovy
def x = 5; def y = 10
echo "Sum: ${x + y}"      // Output: Sum: 15
```

> **Summary:** Understanding string interpolation is crucial for dynamic pipeline configurations. Always use double quotes when you need variable expansion in Groovy.

---

### 5.5 Built-in When Conditions

Control stage execution based on conditions:

```groovy
// Branch condition
when { branch 'main' }

// Environment check
when { environment name: 'DEPLOY', value: 'pre-prod' }

// Expression
when { expression { return params.MANUAL_TEST == true } }

// Pull request
when { changeRequest() }

// Tag
when { buildingTag() }
when { tag 'feature-*' }

// Negation
when { not { branch 'pre-prod' } }

// Any of
when { anyOf { branch 'uat'; branch 'qa' } }

// All of
when { allOf { branch 'main'; environment name: 'DEPLOY', value: 'pre-prod' } }
```

> **Summary:** `when` conditions prevent unnecessary stage execution, saving build time and resources. They're essential for multi-branch pipelines where different branches need different workflows.

---

## 6. Setting up CI Pipeline

### 6.1 Node.js Application Overview

**Node.js** is a JavaScript runtime built on V8 engine. It runs JavaScript outside the browser for server-side apps, CLI tools, etc.

**npm** (Node Package Manager) helps discover, install, and manage JavaScript dependencies.

**Typical Project Structure:**

| File | Purpose |
|------|---------|
| package.json | Metadata and dependencies |
| index.js | Application entry point |
| test.js | Automated tests |

**Common Commands:**
```bash
npm install   # Install dependencies
npm test      # Run tests
npm start     # Start application
```

> **Summary:** Node.js is widely used in microservices architectures. Understanding its tooling is essential for building CI pipelines for JavaScript applications.

---

### 6.2 Solar System Application

A Node.js application using:
- **Express** for REST API
- **Mongoose** for MongoDB
- **Mocha & Chai** for testing
- **nyc** for code coverage
- **serverless-http** for AWS Lambda

**Key Files:**

| File | Purpose |
|------|---------|
| `app.js` | Express setup & MongoDB connection |
| `app.controller.js` | Routes & Mongoose schemas |
| `app-test.js` | Mocha/Chai test suite |
| `Dockerfile` | Containerization |
| `openapi.yaml` | API definitions |

**Environment Variables Required:**
- `MONGO_URI` — MongoDB connection string
- `MONGO_USERNAME` — Database username
- `MONGO_PASSWORD` — Database password

> **Summary:** The Solar System app serves as the example project throughout the course, demonstrating a real-world Node.js application with database connectivity, testing, and containerization.

---

### 6.3 Understanding DevOps Pipeline

**Complete Pipeline Stages:**

| Stage | Objective | Tools |
|-------|-----------|-------|
| CI | Build, test, secure code | npm, Jest, SonarCloud, Docker, Snyk |
| CD to EC2 | Deploy container | SSH, Docker CLI |
| CD to K8s | GitOps rollout | ArgoCD, OWASP ZAP |
| Post-Build | Reports and notifications | S3, Slack |

**CI Steps:**
1. Install Dependencies (`npm install`)
2. Dependency Vulnerability Checks (`npm audit`)
3. Unit Tests & Coverage (`npm test`, `npm run coverage`)
4. Static Code Analysis (SonarCloud)
5. Containerization (`docker build`)
6. Image Vulnerability Scan (Snyk/Trivy)
7. Push to Container Registry (`docker push`)

> **Summary:** A production DevOps pipeline includes security at every stage — from dependency scanning to container vulnerability analysis to DAST testing post-deployment.

---

### 6.4 Installing Node.js Build Tool

**Two approaches in Jenkins:**

1. **Host Installation** — Node.js installed directly on Jenkins server
2. **Jenkins-Managed Tool** — NodeJS Plugin handles installation

**Plugin Installation:**
1. Manage Jenkins → Manage Plugins → Install "NodeJS"
2. Global Tool Configuration → Add NodeJS (e.g., "Node.js 22.6.0")
3. Enable auto-install

**Usage in Freestyle:**
- Build Environment → Provide Node & npm bin/ folder to PATH

**Usage in Pipeline:**
```groovy
tools {
  nodejs 'nodejs-22-6-0'
}
```

> **Summary:** Using Jenkins-managed Node.js tools ensures consistent versions across all agents. This prevents "works on my machine" issues in production pipelines.

---

### 6.5 Installing Dependencies

```groovy
pipeline {
    agent any
    tools {
        nodejs 'nodejs-22-6-0'
    }
    stages {
        stage('Installing Dependencies') {
            steps {
                sh 'npm install --no-audit'
            }
        }
    }
}
```

> ⚠️ **Note:** `--no-audit` skips vulnerability checks during install. Run `npm audit` separately in a dedicated stage.

> **Summary:** Dependencies must be installed before any build/test steps. Use `--no-audit` during install and perform auditing in a dedicated security stage.

---

### 6.6 Dependency Scanning

**Two Methods:**

**1. NPM Audit:**
```groovy
stage('NPM Dependency Audit') {
  steps {
    sh 'npm audit --audit-level=critical'
  }
}
```

**2. OWASP Dependency-Check:**
```groovy
stage('OWASP Dependency Check') {
  steps {
    dependencyCheck additionalArguments: '''
      --scan ./
      --out ./
      --format 'ALL'
      --prettyPrint
    ''', odcInstallation: 'OWASP-DepCheck-10'

    dependencyCheckPublisher failedTotalCritical: 1,
                           pattern: 'dependency-check-report.xml',
                           stopBuild: true
  }
}
```

**Running Both in Parallel:**
```groovy
stage('Dependency Scanning') {
  parallel {
    stage('NPM Audit') { steps { sh 'npm audit --audit-level=critical' } }
    stage('OWASP Check') { steps { /* OWASP steps */ } }
  }
}
```

> **Summary:** Dependency scanning is a critical security gate. Use NPM audit for quick checks and OWASP Dependency-Check for comprehensive vulnerability analysis with quality gates.

---

### 6.7 Fixing Vulnerabilities and Publishing Reports

**Fix Critical Vulnerability:**
```bash
npm install @babel/traverse@^7.23.2
npm audit --audit-level=critical && echo $?  # Should return 0
```

**Publish HTML Report:**
```groovy
publishHTML(
  allowMissing: true,
  alwaysLinkToLastBuild: true,
  keepAll: true,
  reportDir: './',
  reportFiles: 'dependency-check-jenkins.html',
  reportName: 'Dependency Check HTML Report',
  useWrapperFileDirectly: true
)
```

**Publish JUnit XML Results:**
```groovy
junit allowEmptyResults: true,
      keepProperties: true,
      testResults: 'dependency-check-junit.xml'
```

> ⚠️ **CSP Note:** Jenkins may strip CSS in HTML reports. Fix via Script Console:
> ```java
> System.setProperty("hudson.model.DirectoryBrowserSupport.CSP",
>   "sandbox allow-same-origin; default-src 'self'; style-src 'self';");
> ```

> **Summary:** Always remediate critical vulnerabilities before deployment. Publish both HTML (for humans) and JUnit XML (for Jenkins integration) reports for full visibility.

---

## 7. Code Quality and Testing

### 7.1 Unit Testing and JUnit Reports

```groovy
stage('Unit Testing') {
  steps {
    withCredentials([usernamePassword(
      credentialsId: 'mongo-db-credentials',
      usernameVariable: 'MONGO_USERNAME',
      passwordVariable: 'MONGO_PASSWORD'
    )]) {
      sh 'npm test'
    }
    junit allowEmptyResults: true, testResults: '**/test-results.xml'
  }
}
```

**Common Error:** MongoDB credentials missing:
```
MongooseError: The `uri` parameter to `openUri()` must be a string, got `undefined`.
```

**Solution:** Use `withCredentials` or `environment` directive with Jenkins credentials.

> **Summary:** Unit tests require proper environment setup (database credentials, service URLs). Use Jenkins credentials binding to securely inject secrets at runtime.

---

### 7.2 Code Coverage and Catch Errors

**Coverage Stage:**
```groovy
stage('Code Coverage') {
  steps {
    withCredentials([...]) {
      catchError(
        buildResult: 'SUCCESS',
        stageResult: 'UNSTABLE',
        message: 'Coverage below threshold'
      ) {
        sh 'npm run coverage'
      }
    }
    publishHTML([
      reportDir: 'coverage/lcov-report',
      reportFiles: 'index.html',
      reportName: 'Code Coverage HTML Report'
    ])
  }
}
```

**catchError explained:**
- `buildResult: 'SUCCESS'` — Overall build remains green
- `stageResult: 'UNSTABLE'` — Stage marked yellow
- Allows downstream stages to continue even if coverage threshold fails

> **Summary:** `catchError` is essential for non-blocking quality gates. Use it when you want to track metrics without failing the entire pipeline (e.g., during initial coverage improvement phases).

---

### 7.3 Refactoring Jenkinsfile

**Problem:** Duplicate `withCredentials` blocks in multiple stages.

**Solution 1: Environment-level Credentials:**
```groovy
environment {
  MONGO_URI      = "mongodb+srv://..."
  MONGO_USERNAME = credentials('mongo-db-username')
  MONGO_PASSWORD = credentials('mongo-db-password')
}
```

When using `credentials()` in environment:
- `MONGO_DB_CREDS` → `username:password` (colon-separated)
- `MONGO_DB_CREDS_USR` → username only
- `MONGO_DB_CREDS_PSW` → password only (masked in logs)

**Solution 2: Centralize Reports in `post` block:**
```groovy
post {
  always {
    junit allowEmptyResults: true, testResults: 'test-results.xml'
    junit allowEmptyResults: true, testResults: 'dependency-check-junit.xml'
    publishHTML([
      reportDir: 'coverage/lcov-report',
      reportFiles: 'index.html',
      reportName: 'Code Coverage HTML Report'
    ])
  }
}
```

> **Summary:** Refactoring eliminates duplication and improves maintainability. Move credentials to the environment block and reports to the post block for cleaner pipelines.

---

### 7.4 SonarQube Introduction

SonarQube performs **Static Application Security Testing (SAST)** — analyzing source code WITHOUT executing it.

**Key Metrics:**

| Metric | Purpose | Threshold |
|--------|---------|-----------|
| Code Smells | Maintainability issues | < 5% |
| Security Hotspots | Requires security review | 0 unresolved |
| Code Coverage | Test coverage percentage | ≥ 80% |
| Duplications | Duplicate code blocks | < 3% |

**Quality Gates:** Define pass/fail conditions that automatically fail builds when thresholds are not met.

> **Summary:** SonarQube is the industry standard for code quality analysis. It integrates with Jenkins to enforce quality gates and prevent low-quality code from reaching production.

---

### 7.5 SAST Analysis with SonarQube

**Jenkins Integration:**

1. Install SonarQube Scanner plugin
2. Configure Global Tool: `sonarqube-scanner-6.1.0`
3. Add to pipeline:

```groovy
environment {
  SONAR_SCANNER_HOME = tool 'sonarqube-scanner-6.1.0'
}

stage('SAST - SonarQube') {
  steps {
    sh """
      $SONAR_SCANNER_HOME/bin/sonar-scanner \
        -Dsonar.projectKey=Solar-System-Project \
        -Dsonar.sources=app.js \
        -Dsonar.host.url=http://<host>:9000 \
        -Dsonar.javascript.lcov.reportPaths=./coverage/lcov.info \
        -Dsonar.login=<TOKEN>
    """
  }
}
```

> **Summary:** SAST catches security flaws early in the development cycle. Integrate SonarQube scanning after code coverage to import coverage data into SonarQube analysis.

---

### 7.6 SonarQube Quality Gate and Refactoring

**Webhook Flow:**
1. Jenkins → SonarScanner → SonarQube Server
2. SonarQube evaluates quality gate
3. SonarQube calls Jenkins webhook
4. Jenkins continues or aborts

**Refactored Stage:**
```groovy
stage('SAST - SonarQube') {
  steps {
    timeout(time: 60, unit: 'SECONDS') {
      withSonarQubeEnv('sonar-qube-server') {
        sh '''
          $SONAR_SCANNER_HOME/bin/sonar-scanner \
            -Dsonar.projectKey=Solar-System-Project \
            -Dsonar.sources=app.js \
            -Dsonar.javascript.lcov.reportPaths=./coverage/lcov.info
        '''
      }
    }
    waitForQualityGate abortPipeline: true
  }
}
```

**Key Points:**
- `withSonarQubeEnv` injects server URL and token (no hard-coding)
- `waitForQualityGate abortPipeline: true` fails build if gate fails
- Configure SonarQube webhook: `http://<JENKINS_URL>:8080/sonarqube-webhook/`

> ⚠️ **Security:** Never hardcode tokens in Jenkinsfile. Store them as Jenkins Secret Text credentials.

> **Summary:** Quality gates are the enforcement mechanism for code quality standards. Combined with `waitForQualityGate`, they automatically prevent substandard code from progressing through the pipeline.

---

## 8. Containerization and Deployment

### 8.1 Building Docker Images

```groovy
stage('Build Docker Image') {
  steps {
    sh 'printenv'
    sh 'docker build -t siddharth67/solar-system:$GIT_COMMIT .'
  }
}
```

**Key Jenkins Variables:**

| Variable | Description |
|----------|-------------|
| `GIT_COMMIT` | Current commit SHA |
| `BRANCH_NAME` | Active branch |
| `BUILD_NUMBER` | Sequential build number |
| `WORKSPACE` | Path to workspace |

**Dockerfile:**
```dockerfile
FROM node:18-alpine3.17
WORKDIR /usr/app
COPY package*.json ./
RUN npm install
COPY . .
ENV MONGO_URI=uriPlaceholder
EXPOSE 3000
CMD ["npm", "start"]
```

**.dockerignore:**
```
.git
node_modules
coverage
test-results.xml
```

> **Summary:** Tag Docker images with `GIT_COMMIT` for traceability. Every image can be traced back to exact source code. Use `.dockerignore` to optimize build context.

---

### 8.2 Vulnerability Scanning with Trivy

**Trivy** is an open-source security scanner from Aqua Security.

```groovy
stage('Trivy Vulnerability Scanner') {
  steps {
    sh '''
      # Non-critical scan (informational)
      trivy image myapp:$GIT_COMMIT \
        --severity LOW,MEDIUM,HIGH \
        --exit-code 0 \
        --quiet \
        --format json -o trivy-image-medium.json

      # Critical scan (fails build)
      trivy image myapp:$GIT_COMMIT \
        --severity CRITICAL \
        --exit-code 1 \
        --quiet \
        --format json -o trivy-image-critical.json
    '''
  }
  post {
    always {
      // Convert to HTML and JUnit
      sh '''
        trivy convert --format template \
          --template "/usr/local/share/trivy/templates/html.tpl" \
          --output trivy-image-critical.html trivy-image-critical.json
      '''
      junit allowEmptyResults: true, testResults: 'trivy-image-*.xml'
      publishHTML([...])
    }
  }
}
```

**Key Options:**
- `--exit-code 0` — Don't fail (informational)
- `--exit-code 1` — Fail on findings (enforcement)
- `--severity` — Filter by severity level

> **Summary:** Container image scanning is mandatory before pushing to registries. Use two-pass approach: informational for LOW/MEDIUM/HIGH, enforcement for CRITICAL.

---

### 8.3 Pushing to Docker Registry

```groovy
stage('Push Docker Image') {
  steps {
    withDockerRegistry(credentialsId: 'docker-hub-credentials', url: '') {
      sh 'docker push siddharth67/solar-system:$GIT_COMMIT'
    }
  }
}
```

**Requirements:**
- Install Docker Pipeline plugin
- Create Jenkins credentials (Username with password)
- `url: ''` uses default Docker Hub endpoint

> **Summary:** Use `withDockerRegistry` for secure authentication. Never hardcode Docker credentials. Tag images with commit SHA for production traceability.

---

### 8.4 Understanding Deployment Approach

| Stage | Trigger | Target | Tests |
|-------|---------|--------|-------|
| Feature Branch | Push to feature/* | AWS EC2 | Integration tests |
| Pull Request | Open PR | Kubernetes (ArgoCD) | OWASP ZAP DAST |
| Main Branch | Merge to main | AWS Lambda | Post-deploy invocation |

> **Summary:** Different branches deploy to different targets. Feature branches go to dev EC2, PRs trigger K8s deployment for security testing, and main goes to production Lambda.

---

### 8.5 AWS Setup for Jenkins

**Required Plugins:**
- Pipeline: AWS Steps (`withAWS`, `s3Upload`)
- SSH Agent (for EC2 deployment)

**Credentials to Configure:**

| Credential | Type | ID |
|-----------|------|-----|
| AWS Access Key | AWS Credentials | `aws-s3-ec2-lambda` |
| EC2 SSH Key | SSH Username with private key | `aws-dev-deploy-ec2` |
| Docker Hub | Username with password | `docker-hub-credentials` |

**IAM Policies Required:**
- AmazonEC2FullAccess
- AmazonS3FullAccess
- AWSLambda_FullAccess

> **Summary:** Configure all AWS and SSH credentials in Jenkins before building deployment stages. Use least-privilege IAM policies in production (not FullAccess).

---

### 8.6 Deploying to AWS EC2

```groovy
stage('Deploy - AWS EC2') {
  when { branch 'feature/*' }
  steps {
    script {
      sshagent(['aws-dev-deploy-ec2-instance']) {
        sh '''
          ssh -o StrictHostKeyChecking=no ubuntu@<EC2_IP> "
            if sudo docker ps -a | grep -q 'solar-system'; then
              sudo docker stop solar-system && sudo docker rm solar-system
            fi
            sudo docker run --name solar-system \
              -e MONGO_URI=$MONGO_URI \
              -e MONGO_USERNAME=$MONGO_USERNAME \
              -e MONGO_PASSWORD=$MONGO_PASSWORD \
              -p 3000:3000 \
              -d siddharth67/solar-system:$GIT_COMMIT
          "
        '''
      }
    }
  }
}
```

**Key Points:**
- `StrictHostKeyChecking=no` avoids interactive prompts in CI
- Stop and remove existing container before deploying new one
- Pass environment variables via `-e` flags
- Use `when { branch 'feature/*' }` to restrict to feature branches

> **Summary:** EC2 deployment via SSH is suitable for dev/staging environments. In production, prefer container orchestration (Kubernetes) for better scaling and reliability.

---

### 8.7 Integration Testing on EC2

```bash
#!/usr/bin/env bash
set -euo pipefail

# Discover EC2 public DNS
DATA=$(aws ec2 describe-instances)
URL=$(echo "$DATA" | jq -r '.Reservations[].Instances[]
  | select(.Tags[].Value == "dev-deploy") | .PublicDnsName')

# Test /live endpoint
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "http://$URL:3000/live")

# Test /planet endpoint
PLANET_DATA=$(curl -s -X POST "http://$URL:3000/planet" \
  -H "Content-Type: application/json" -d '{"id":"3"}')
PLANET_NAME=$(echo "$PLANET_DATA" | jq -r '.name')

# Validate
if [[ "$HTTP_CODE" -eq 200 && "$PLANET_NAME" == "Earth" ]]; then
  echo "Integration tests passed."
else
  exit 1
fi
```

**Pipeline Stage:**
```groovy
stage('Integration Testing - AWS EC2') {
  when { branch 'feature/*' }
  steps {
    withAWS(credentials: 'aws-s3-ec2-lambda-creds', region: 'us-east-2') {
      sh 'bash integration-testing-ec2.sh'
    }
  }
}
```

> **Summary:** Integration tests validate the deployed application against real endpoints. Use AWS CLI to dynamically discover EC2 instances by tag for flexible testing.

---

## 9. Kubernetes and GitOps

### 9.1 Kubernetes Overview

**Key Components:**

| Component | Role |
|-----------|------|
| Control Plane | API Server, Controller Manager, Scheduler, etcd |
| Worker Node | kubelet, kube-proxy, container runtime |
| Pod | Smallest deployable unit |
| Deployment | Declarative updates for Pods |
| Service | Network endpoint (ClusterIP, NodePort, LoadBalancer) |
| Ingress | HTTP/HTTPS routing |

**Service Types:**

| Type | Description |
|------|-------------|
| ClusterIP | Internal-only |
| NodePort | Static port on each node |
| LoadBalancer | External cloud LB |

> **Summary:** Kubernetes automates container orchestration. Understanding Pods, Deployments, and Services is essential for deploying Jenkins-built applications to production clusters.

---

### 9.2 Introduction to GitOps

GitOps uses Git as the single source of truth for infrastructure and application state.

**Principles:**
1. **Declarative** — Everything described in code
2. **Versioned** — Every change tracked in Git
3. **Automated** — GitOps operator syncs state
4. **Continuous Reconciliation** — Drift detection and correction

**Two Repository Architecture:**

| Repo Type | Contents | Purpose |
|-----------|----------|---------|
| Application | Source code, configs | Triggers CI builds |
| Configuration | K8s manifests | Source of truth for cluster |

**Rollback:**
```bash
git revert <commit-hash>
# GitOps operator detects and rolls back cluster
```

> **Summary:** GitOps ensures production environments always match what's declared in Git. Combined with ArgoCD, it provides automated, auditable, and reversible deployments.

---

### 9.3 ArgoCD Concepts

| Term | Description |
|------|-------------|
| Application | K8s CRD representing a deployable unit |
| Source Types | Helm, Kustomize, YAML, Plugin |
| Project | Namespace/repo isolation (multi-tenancy) |
| Target State | Desired state from Git |
| Live State | Actual running state |
| Sync | Reconciling live with target |
| Sync Status | Synced vs OutOfSync |
| Health | Healthy, Degraded, Progressing, Missing |

> **Summary:** ArgoCD is the most popular GitOps operator. It continuously monitors Git repos and automatically syncs Kubernetes cluster state to match the desired configuration.

---

### 9.4 CI/CD with GitOps

**Workflow:**
1. Developer pushes to application repo
2. CI pipeline builds, tests, pushes Docker image
3. Pipeline updates image tag in configuration repo
4. ArgoCD detects change in config repo
5. ArgoCD syncs cluster to new state

**Jenkins Pipeline Responsibilities:**
- Run tests
- Build Docker image
- Push to registry
- Clone config repo
- Update deployment manifest
- Commit and push (or create PR)

> **Summary:** With GitOps, Jenkins handles CI (build/test/push) and triggers CD by updating manifests. ArgoCD handles the actual deployment to Kubernetes.

---

### 9.5 Manifest Repository and ArgoCD Configuration

**Sealed Secrets for MongoDB Credentials:**
```bash
# Generate K8s secret (dry-run)
kubectl create secret generic mongo-db-creds \
  --from-literal=MONGO_URI='...' \
  --from-literal=MONGO_USERNAME='...' \
  --from-literal=MONGO_PASSWORD='...' \
  --dry-run=client -o yaml > secret.yaml

# Seal with Bitnami Sealed Secrets
kubeseal --cert sealed-secret-public-cert.crt \
  --scope cluster-wide \
  -o yaml < secret.yaml > sealed-secret.yaml
```

> ⚠️ **Critical:** Never commit raw secrets to Git. Use Sealed Secrets or external secret managers.

**ArgoCD Application Setup:**
- Application Name: `solar-system-argo-app`
- Sync Policy: Manual
- Repository: manifest repo URL
- Path: `kubernetes`
- Destination Namespace: `solar-system`

> **Summary:** Manifest repos contain deployment YAMLs and sealed secrets. ArgoCD watches these repos and syncs changes to the cluster automatically.

---

### 9.6 Kubernetes Deploy - Update Image Tag

```groovy
stage('K8S Update Image Tag') {
  when { branch 'PR*' }
  steps {
    sh 'git clone -b main http://<gitea>/dasher-org/solar-system-gitops-argo-cd'
    dir('solar-system-gitops-argo-cd/kubernetes') {
      sh '''
        git checkout -b feature-$BUILD_ID
        sed -i "s#image: .*#image: siddharth67/solar-system:$GIT_COMMIT#g" deployment.yml
        git config user.email "jenkins@dasher.com"
        git config user.name "Jenkins"
        git remote set-url origin http://$GITEA_TOKEN@<gitea>/dasher-org/solar-system-gitops-argo-cd
        git add deployment.yml
        git commit -m "Update Docker image to $GIT_COMMIT"
        git push -u origin feature-$BUILD_ID
      '''
    }
  }
}
```

> **Summary:** Jenkins automates the manifest update by cloning the config repo, using `sed` to replace the image tag, and pushing to a feature branch. This triggers the GitOps flow.

---

### 9.7 Kubernetes Deploy - Raise PR

```groovy
stage('K8S - Raise PR') {
  when { branch 'PR*' }
  steps {
    sh """
      curl -X POST \
        "http://<gitea>/api/v1/repos/dasher-org/solar-system-gitops-argocd/pulls" \
        -H "Authorization: token $GITEA_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "base": "main",
          "head": "feature-${BUILD_ID}",
          "title": "Updated Docker Image"
        }'
    """
  }
}
```

**After PR is merged:**
- ArgoCD detects change in main branch
- Syncs cluster with new image tag
- Application pods restart with new image

> **Summary:** Automating PR creation via API ensures the GitOps workflow is fully automated. Branch protection rules enforce review before deployment.

---

### 9.8 DAST and Manual Input

**Manual Approval Stage:**
```groovy
stage('App Deployed?') {
  when { branch 'PR*' }
  steps {
    timeout(time: 1, unit: 'DAYS') {
      input message: 'Has the PR been merged and Argo CD synced?',
            ok: 'Yes, proceed with DAST'
    }
  }
}
```

**OWASP ZAP DAST Scan:**
```groovy
stage('DAST - OWASP ZAP') {
  when { branch 'PR*' }
  steps {
    sh '''
      chmod 777 $(pwd)
      docker run -v $(pwd):/zap/wrk/:rw \
        ghcr.io/zaproxy/zaproxy zap-api-scan.py \
        -t http://<K8S_IP>:30000/api/docs/ \
        -f openapi \
        -r zap_report.html \
        -w zap_report.md \
        -J zap_report.json \
        -x zap_report.xml
    '''
  }
}
```

**ZAP Scan Modes:**

| Mode | Description |
|------|-------------|
| Baseline | Time-boxed passive scan |
| Full | AJAX Spider + active + passive |
| API | OpenAPI/GraphQL/SOAP endpoints |

> **Summary:** DAST probes live applications for runtime vulnerabilities. Combined with manual approval gates, it ensures security validation before production deployment.

---

### 9.9 Publishing Reports to AWS S3

```groovy
stage('Upload - AWS S3') {
  when { anyOf { branch 'PR*'; branch 'main' } }
  steps {
    withAWS(credentials: 'aws-s3-ec2-lambda-creds', region: 'us-east-2') {
      sh '''
        mkdir reports-$BUILD_ID
        cp -rf coverage/ reports-$BUILD_ID/
        cp dependency* test-results.xml trivy*.* zap*.* reports-$BUILD_ID/
      '''
      s3Upload(
        file: "reports-$BUILD_ID",
        bucket: 'solar-system-jenkins-reports-bucket',
        path: "jenkins-$BUILD_ID/"
      )
    }
  }
}
```

> **Summary:** Uploading reports to S3 centralizes build artifacts for long-term storage, compliance, and team sharing. Organize by build ID for easy retrieval.

---

## 10. AWS Lambda and Advanced Deployment

### 10.1 AWS Lambda Basics

AWS Lambda is Functions-as-a-Service (FaaS):
- No servers to provision or manage
- Automatic scaling
- Pay per millisecond of compute
- Built-in high availability
- Supports Node.js, Python, Java, Go, C#, Ruby

**For Express.js apps, use `serverless-http`:**
```javascript
const serverless = require('serverless-http');
const app = require('./app');
module.exports.handler = serverless(app);
```

> **Summary:** Lambda is ideal for production workloads that need auto-scaling and cost-efficiency. Wrapping Express apps with serverless-http enables seamless Lambda deployment.

---

### 10.2 Deploy to Production Gate

```groovy
stage('Deploy to Prod?') {
  when { branch 'main' }
  steps {
    timeout(time: 1, unit: 'DAYS') {
      input message: 'Deploy to Production?',
            ok: 'YES! Deploy',
            submitter: 'admin'
    }
  }
}
```

**Key Points:**
- `submitter: 'admin'` restricts approval to admin group
- `timeout` prevents indefinite pipeline blocking
- Only triggers on `main` branch

> **Summary:** Manual approval gates are essential for production deployments. They ensure human verification before changes reach end users.

---

### 10.3 Using GenAI for Lambda Steps

**Steps generated:**
1. Configure AWS CLI and Jenkins credentials
2. Install dependencies: `npm install`
3. Run tests: `npm test`
4. Package: `zip -r app.zip index.js node_modules`
5. Deploy: `aws lambda update-function-code --function-name my-app --zip-file fileb://app.zip`

**Code Modification for Lambda:**
```javascript
// Comment out Express listener
// app.listen(3000, () => {...});
// module.exports = app;

// Add Lambda handler
module.exports.handler = require('serverless-http')(app);
```

> **Summary:** GenAI tools can accelerate pipeline development by generating deployment steps. Always verify and test generated configurations before production use.

---

### 10.4 Manual Lambda Deployment

```bash
# 1. Modify app.js for Lambda
sed -i 's|app.listen(3000.*|//&|' app.js
echo "module.exports.handler = require('serverless-http')(app);" >> app.js

# 2. Install dependencies
npm install

# 3. Update version
sed -i 's/Solar System 3.0/Solar System 4.0/' index.html

# 4. Package
zip -qr solar-system-lambda.zip app.js package.json index.html node_modules

# 5. Upload to S3
aws s3 cp solar-system-lambda.zip s3://solar-system-lambda-bucket/

# 6. Update Lambda function
aws lambda update-function-code \
  --function-name solar-system-function \
  --s3-bucket solar-system-lambda-bucket \
  --s3-key solar-system-lambda.zip

# 7. Verify
aws lambda get-function-url-config --function-name solar-system-function
```

> **Summary:** Understanding manual Lambda deployment steps helps you understand what the automated pipeline does. Always test manually before automating.

---

### 10.5 Lambda Deployment via Jenkinsfile

```groovy
stage('Lambda - S3 Upload & Deploy') {
  when { branch 'main' }
  steps {
    withAWS(credentials: 'aws-s3-ec2-lambda-creds', region: 'us-east-2') {
      sh '''
        # Modify app.js for Lambda
        sed -i "/app\\.listen(3000/s/^\\/\\///" app.js
        sed -i "s|module.exports = app;|//module.exports = app;|g" app.js
        sed -i "s|//module.exports.handler|module.exports.handler|g" app.js

        # Package
        zip -qr solar-system-lambda-${BUILD_ID}.zip app* package* index.html node*
      '''

      s3Upload(
        file: "solar-system-lambda-${BUILD_ID}.zip",
        bucket: 'solar-system-lambda-bucket'
      )

      sh '''
        aws lambda update-function-code \
          --function-name solar-system-function \
          --s3-bucket solar-system-lambda-bucket \
          --s3-key solar-system-lambda-${BUILD_ID}.zip
      '''
    }
  }
}
```

> **Summary:** The automated Lambda deployment stage handles code modification, packaging, S3 upload, and function update in a single pipeline stage.

---

### 10.6 Update Lambda Configuration

```groovy
sh '''
  aws lambda update-function-configuration \
    --function-name solar-system-function \
    --environment "Variables={MONGO_USERNAME=${MONGO_USERNAME},MONGO_PASSWORD=${MONGO_PASSWORD},MONGO_URI=${MONGO_URI}}"
'''
```

**Environment Variable Syntax:**

| Format | Example |
|--------|---------|
| Shorthand | `Variables={KEY1=val1,KEY2=val2}` |
| JSON | `'{"Variables":{"KEY1":"val1"}}'` |

> ⚠️ **Important:** Environment variables must be set BEFORE `update-function-code` for the function to work correctly.

> **Summary:** Lambda configuration updates inject environment variables securely. Combined with Jenkins credentials, secrets never appear in logs or code.

---

### 10.7 Lambda Invoke Function

```groovy
stage('Lambda - Invoke Function') {
  when { branch 'main' }
  steps {
    withAWS(credentials: 'aws-s3-ec2-lambda-creds', region: 'us-east-2') {
      sh '''
        sleep 30s  # Wait for Lambda to stabilize

        # Get function URL
        function_url_data=$(aws lambda get-function-url-config \
          --function-name solar-system-function)
        function_url=$(echo $function_url_data | jq -r '.FunctionUrl | sub("/$"; "")')

        # Validate /live endpoint returns 200
        curl -Is $function_url/live | grep -i "200 OK"
      '''
    }
  }
}
```

**Response Verification:**
```bash
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
x-powered-by: Express
```

> **Summary:** Post-deployment validation is the final step in a production pipeline. Always verify the deployed function responds correctly before considering the deployment successful.

---

## Complete Production Pipeline Summary

The full Jenkins pipeline for the Solar System project includes:

| # | Stage | Branch | Purpose |
|---|-------|--------|---------|
| 1 | Install Dependencies | All | `npm install --no-audit` |
| 2 | Dependency Scanning | All | NPM Audit + OWASP (parallel) |
| 3 | Unit Testing | All | `npm test` with credentials |
| 4 | Code Coverage | All | `npm run coverage` with catchError |
| 5 | SAST - SonarQube | All | Static analysis + quality gate |
| 6 | Build Docker Image | All | `docker build -t app:$GIT_COMMIT` |
| 7 | Trivy Scan | All | Container vulnerability scan |
| 8 | Push Docker Image | All | Push to Docker Hub |
| 9 | Deploy - AWS EC2 | feature/* | SSH deploy to EC2 |
| 10 | Integration Testing | feature/* | HTTP endpoint validation |
| 11 | K8S Update Image Tag | PR* | Update manifest repo |
| 12 | K8S Raise PR | PR* | Create PR via API |
| 13 | App Deployed? | PR* | Manual approval (ArgoCD sync) |
| 14 | DAST - OWASP ZAP | PR* | Runtime security scan |
| 15 | Upload - AWS S3 | PR*, main | Archive reports |
| 16 | Deploy to Prod? | main | Manual approval gate |
| 17 | Lambda Deploy | main | Package, upload, update |
| 18 | Lambda Invoke | main | Post-deploy validation |

This represents a complete, production-grade CI/CD pipeline covering security, quality, containerization, multi-environment deployment, and GitOps practices.
