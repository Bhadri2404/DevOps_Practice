# Jenkins Advanced Administration, Pipelines & Infrastructure - Complete Notes

## Table of Contents

- [1. Jenkins Administration and Monitoring - Part 1](#1-jenkins-administration-and-monitoring---part-1)
  - [1.1 Jenkins Folders](#11-jenkins-folders)
  - [1.2 Folder-Scoped Credentials](#12-folder-scoped-credentials)
  - [1.3 Folder Health Metrics](#13-folder-health-metrics)
  - [1.4 Jenkins Script Console](#14-jenkins-script-console)
  - [1.5 Global Security Settings](#15-global-security-settings)
  - [1.6 Markup Formatters](#16-markup-formatters)
  - [1.7 Access Control for Builds](#17-access-control-for-builds)
  - [1.8 Job Restrictions Plugin](#18-job-restrictions-plugin)
  - [1.9 Job Configuration History Plugin](#19-job-configuration-history-plugin)
  - [1.10 Build Monitor View](#110-build-monitor-view)
  - [1.11 Monitoring with JavaMelody](#111-monitoring-with-javamelody)
- [2. Shared Libraries in Jenkins](#2-shared-libraries-in-jenkins)
  - [2.1 Introduction to Shared Libraries](#21-introduction-to-shared-libraries)
  - [2.2 Shared Library Repository Structure](#22-shared-library-repository-structure)
  - [2.3 Loading Shared Libraries in Pipelines](#23-loading-shared-libraries-in-pipelines)
  - [2.4 Creating Custom Library Steps (TrivyScan)](#24-creating-custom-library-steps-trivyscan)
  - [2.5 Library Resources](#25-library-resources)
- [3. Agents and Nodes in Jenkins](#3-agents-and-nodes-in-jenkins)
  - [3.1 Types of Agents](#31-types-of-agents)
  - [3.2 Creating and Configuring Nodes](#32-creating-and-configuring-nodes)
  - [3.3 Utilizing Agents in Jobs](#33-utilizing-agents-in-jobs)
  - [3.4 Docker Image Agent](#34-docker-image-agent)
  - [3.5 Dockerfile Agent](#35-dockerfile-agent)
  - [3.6 newContainerPerStage](#36-newcontainerperstage)
  - [3.7 Kubernetes Pod as Agent](#37-kubernetes-pod-as-agent)
  - [3.8 Sharing Files Between Containers](#38-sharing-files-between-containers)
- [4. Pipeline Enhancement and Caching](#4-pipeline-enhancement-and-caching)
  - [4.1 Refactoring Pipelines](#41-refactoring-pipelines)
  - [4.2 Sequential Stages](#42-sequential-stages)
  - [4.3 Stash and Unstash](#43-stash-and-unstash)
  - [4.4 Pipeline Caching with Job Cacher](#44-pipeline-caching-with-job-cacher)
  - [4.5 Cache Invalidation](#45-cache-invalidation)
- [5. Pipeline Structure - Scripted vs Declarative](#5-pipeline-structure---scripted-vs-declarative)
  - [5.1 Key Differences](#51-key-differences)
  - [5.2 Declarative Pipeline Features](#52-declarative-pipeline-features)
  - [5.3 Scripted Pipeline Patterns](#53-scripted-pipeline-patterns)
  - [5.4 Scripted Pipeline with Kubernetes](#54-scripted-pipeline-with-kubernetes)
  - [5.5 Best Practices for Scripted Pipelines](#55-best-practices-for-scripted-pipelines)
- [6. Jenkins Administration and Monitoring - Part 2](#6-jenkins-administration-and-monitoring---part-2)
  - [6.1 Jenkins Supervision Overview](#61-jenkins-supervision-overview)
  - [6.2 Log Recorders](#62-log-recorders)
  - [6.3 Audit Trail Plugin](#63-audit-trail-plugin)
  - [6.4 Forwarding Audit Logs to External Servers](#64-forwarding-audit-logs-to-external-servers)
  - [6.5 Groovy Sandbox and Script Approval](#65-groovy-sandbox-and-script-approval)
  - [6.6 Migrating Jenkins to Another Node](#66-migrating-jenkins-to-another-node)
- [7. Backup and Configuration Management](#7-backup-and-configuration-management)
  - [7.1 Backing Up and Restoring Jenkins](#71-backing-up-and-restoring-jenkins)
  - [7.2 Thin Backup Plugin](#72-thin-backup-plugin)
  - [7.3 Validating Backups](#73-validating-backups)
  - [7.4 Upgrading Jenkins](#74-upgrading-jenkins)
  - [7.5 Jenkins Configuration as Code (JCasC)](#75-jenkins-configuration-as-code-jcasc)
  - [7.6 Pipeline Durability](#76-pipeline-durability)
  - [7.7 Migrating to GitHub Actions](#77-migrating-to-github-actions)

---

## 1. Jenkins Administration and Monitoring - Part 1

### 1.1 Jenkins Folders

Jenkins folders create independent namespaces to organize jobs, credentials, and configurations. They prevent naming collisions and scope resources per team or project.

**Why It Matters in Production:**
In enterprises with multiple teams sharing one Jenkins instance, folders prevent credential leakage between teams and allow independent pipeline library configuration per folder.

**Key Concepts:**
- Identically named jobs (e.g., `build`) won't collide across folders
- Credentials are scoped per folder
- Pipelines access only libraries, credentials, and cloud profiles in their folder tree
- Folders can be nested (e.g., `shared-infrastructure/team-a`)

**Creating a Folder:**
1. Jenkins Dashboard → New Item → Enter name (e.g., `shared-infrastructure`) → Select **Folder** → OK
2. Configure Display Name, Description, Health Metrics
3. Advanced: Docker labels, registry URLs, pipeline libraries, Kubernetes cloud

**Real-Time Scenario:**
In a microservices company with 10 teams on AWS EKS, each team gets a folder with their own AWS credentials, Docker registry credentials, and shared library versions. Team A cannot accidentally use Team B's production database credentials.

**Summary:**
Folders are Jenkins' primary organizational unit for multi-team environments. They isolate credentials, jobs, and configurations into team-specific namespaces, making large Jenkins installations manageable and secure.

---

### 1.2 Folder-Scoped Credentials

Credentials defined in a folder are only visible to that folder and its subfolders—not to sibling or parent folders.

**Credential Inheritance Rules:**

| Credential Location | Visible To |
|---|---|
| Parent folder (shared-infrastructure) | All child folders (team-a, team-b) |
| team-a folder | Items in team-a only |
| team-b folder | Items in team-b only |

**Example Jenkinsfile Using Folder Credentials:**

```groovy
pipeline {
    agent any
    environment {
        SHARED_DB_CREDS = credentials('shared-db-creds')   // From parent folder
        TEAM_A_CREDS    = credentials('team-a-creds')      // From current folder
    }
    stages {
        stage('Accessing Credentials') {
            steps {
                echo "Shared DB Username: ${SHARED_DB_CREDS_USR}"
                echo "Team A Username: ${TEAM_A_CREDS_USR}"
            }
        }
    }
}
```

**Common Mistake:**
A pipeline in `team-b` trying to access `team-a-creds` will fail with an error. Credentials flow DOWN (parent to child) but never SIDEWAYS (sibling to sibling).

**Cloning Folders:**
When you copy a folder (e.g., team-a → team-c), all pipelines, credentials, and folder-level configurations are inherited. Copied jobs start in disabled state and must be manually enabled.

> ⚠️ **Best Practice:** Never print full secret values in logs. Always reference credentials via `credentials()` to keep them masked.

**Summary:**
Folder-scoped credentials enforce the principle of least privilege. Parent credentials inherit downward; sibling folders are isolated. This is essential for multi-tenant Jenkins environments.

---

### 1.3 Folder Health Metrics

By default, Jenkins folder health icons only reflect direct children's build stability. Failures deep in nested folders may not bubble up to the parent dashboard.

**Weather Icons:**

| Icon | Health % | Meaning |
|---|---|---|
| ☀️ Sunny | > 80% | Excellent stability |
| 🌤️ Partly Sunny | 60–80% | Good |
| ☁️ Cloudy | 40–60% | Moderate |
| 🌧️ Rainy | 20–40% | Unstable |
| ⛈️ Stormy | < 20% | Critical |

**Propagating Worst-Child Health:**
1. Click target folder → Configure
2. Health metrics → Add → **Worst child health**
3. Check **Recursive** to include all nested descendants
4. Apply → Save

**Production Scenario:**
On a Jenkins dashboard managing 50+ microservices across nested folders, without recursive health propagation, a failing production deployment job buried three levels deep would show the parent as "sunny." With worst-child health enabled recursively, the parent immediately reflects the failure.

> 💡 **Plugin Required:** [Folder Health Metrics Plugin](https://plugins.jenkins.io/cloudbees-folder-health-metrics/)

**Summary:**
Enable "Worst child health" with recursive option on parent folders to ensure dashboard weather icons always surface the true health of deeply nested pipelines.

---

### 1.4 Jenkins Script Console

The Script Console allows administrators to execute Groovy scripts directly on the controller or connected agents for debugging, configuration, and maintenance.

> ⚠️ **Security Warning:** The Script Console provides unrestricted control. Only trusted admin users should have access.

**Accessing:**
- Dashboard → Manage Jenkins → Script Console
- Or: Manage Nodes → Built-In Node → Script Console

**Common Scripts:**

```groovy
// List all installed plugins
println Jenkins.instance.pluginManager.plugins

// Show environment and OS info
println System.getenv("PATH")
println "uname -a".execute().text

// Print Jenkins version
import jenkins.model.Jenkins
println "Jenkins Version: ${Jenkins.instance.version}"
```

**Retrieving Job Details:**

```groovy
import jenkins.model.Jenkins

Jenkins.instance.getAllItems().each { job ->
    println "Job: ${job.fullName}"
    println "URL: ${job.absoluteUrl}"
    println "Last Build: ${job.lastBuild?.number}"
    println "Type: ${job.getClass().name}"
    println "---"
}
```

**Count Executors on All Nodes:**

```groovy
import jenkins.model.Jenkins

Jenkins.instance.computers.eachWithIndex { node, idx ->
    println "[${idx+1}] ${node.displayName}: ${node.numExecutors}"
}
println "Total executors: ${Jenkins.instance.computers.sum { it.numExecutors }}"
```

**Disabling Jenkins CLI (Security Hardening):**

```groovy
import hudson.remoting.AgentProtocol
import jenkins.model.Jenkins
import hudson.model.RootAction

def protocols = AgentProtocol.all()
protocols.findAll { it.name.contains("CLI") }.each { protocols.remove(it) }

Jenkins.instance.getExtensionList(RootAction).findAll { 
    it.class.name.contains("CLIAction") 
}.each { Jenkins.instance.getExtensionList(RootAction).remove(it) }

println "CLI access disabled."
```

**Community Script Resources:**
- [jenkinsci/jenkins-scripts](https://github.com/jenkinsci/jenkins-scripts)
- [samrocketman/jenkins-script-console-scripts](https://github.com/samrocketman/jenkins-script-console-scripts)

> 💡 **Best Practice:** Always review third-party scripts before executing. Test in non-production first.

**Summary:**
The Script Console is the most powerful Jenkins admin tool for diagnostics, bulk operations, and automation. Restrict access to admins only and always review scripts before execution.

---

### 1.5 Global Security Settings

#### Markup Formatting

Controls how user-supplied descriptions are rendered. Without proper controls, malicious users could inject XSS attacks.

| Formatter | Tags Allowed | Security Level |
|---|---|---|
| Plain text (default) | None | Safest |
| Safe HTML | `<b>`, `<i>`, `<u>`, `<p>` | Moderate |
| Custom (plugins) | Varies | Depends on plugin |

**Plain text** escapes all HTML, rendering it literally. **Safe HTML** strips `<script>` tags but allows basic styling.

#### CSRF Protection

Jenkins defends against CSRF by issuing a **crumb** (token) for every form and state-changing API call. Requests missing a valid crumb are rejected.

- Enabled by default — keep it that way
- Located: Manage Jenkins → Configure Global Security → "Prevent Cross Site Request Forgery exploits"

**How CSRF Attacks Work:**
1. Attacker crafts malicious link targeting Jenkins endpoint
2. Authenticated user clicks link while logged in
3. Jenkins executes request under user's credentials

**Summary:**
Use Plain text formatter for high-security environments. Keep CSRF protection enabled always. These are non-negotiable security baselines for production Jenkins.

---

### 1.6 Markup Formatters

**Changing the Formatter:**
1. Manage Jenkins → Configure Global Security
2. Locate Markup Formatter section
3. Change from Plain Text to Safe HTML
4. Save

**Safe HTML strips:**
- `<script>` tags
- Inline event handlers (onclick, onload)
- Unsafe attributes

**Safe HTML allows:**
- `<strong>`, `<em>`, `<ul>`, `<ol>`, `<li>`
- Basic inline styles

**Use Case:** System messages with formatted maintenance announcements:

```html
<strong style="color:red">Server maintenance at 10 PM UTC.</strong>
<ol>
  <li>Service A</li>
  <li>Service B</li>
</ol>
```

**Summary:**
Safe HTML is the recommended formatter when you need styled system messages while maintaining XSS protection. Never use unrestricted HTML in multi-user environments.

---

### 1.7 Access Control for Builds

By default, every build runs as the internal `SYSTEM` user with full rights. The **Authorize Project** plugin enforces least-privilege by specifying which user context a build runs under.

**Authorization Strategies:**

| Strategy | Description |
|---|---|
| Run as SYSTEM | Default, full permissions |
| Run as User who Triggered Build | Inherits triggering user's permissions |
| Run as Specific User | Fixed user account |
| Run as Anonymous | Minimal read-only permissions |

**Configuration Steps:**
1. Install "Authorize Project" plugin
2. Manage Jenkins → Configure Global Security → Access Control for Builds
3. Add "Project Default Build Authorization"
4. Per-job: Job → Configure → Authorization dropdown

**Verification in Console Output:**
```
Started by user siddharth
Running as siddharth    ← Confirms build runs under correct user
```

> ⚠️ **Important:** Ensure triggering user has Build and Read permissions, otherwise the build fails.

**Production Scenario:**
In a regulated environment (SOX, HIPAA), builds must run with the permissions of the user who triggered them, ensuring audit trails show exactly who deployed what code to production.

**Summary:**
The Authorize Project plugin is critical for enterprise Jenkins where audit compliance requires builds to run under specific user contexts rather than the all-powerful SYSTEM account.

---

### 1.8 Job Restrictions Plugin

Controls which jobs can run on specific nodes using regex-based name matching, user filters, and logical operators.

**Configuration:**
1. Install "Job Restrictions" plugin
2. Manage Jenkins → Manage Nodes → built-in node → Configure
3. Node Properties → Check "Job Restrictions"
4. Add → Regular Expression — Job Name

**Example Regex:**
```regex
^Dasher_.*
```
Only jobs starting with `Dasher_` can run on this node.

**Common Restriction Types:**

| Type | Purpose | Example |
|---|---|---|
| Regular Expression — Job Name | Match by name pattern | `^Dasher_.*` |
| Started by User | Allow specific users | `Emma` |
| Parameterized Job | Restrict by parameter values | `env=production` |

**Combining Rules:** Use AND, OR, NOT logic to create complex rules.

> ⚠️ **Warning:** Jobs that don't meet restriction rules remain queued indefinitely. Monitor the queue.

**Production Scenario:**
A production deployment node only accepts jobs matching `^prod-deploy-.*` pattern OR triggered by users in the "release-managers" group, preventing accidental test jobs from running on production infrastructure.

**Summary:**
Job Restrictions plugin provides node-level access control beyond labels, enabling regex-based and user-based policies for which jobs execute where.

---

### 1.9 Job Configuration History Plugin

Automatically archives every job and system configuration change with diff views and rollback capability.

**Features:**

| Feature | Description |
|---|---|
| Automatic Backups | Saves config on every change |
| Diff Viewer | Side-by-side XML comparison |
| Restore & Rollback | Revert to any prior version |
| System Config Tracking | Monitors global settings |
| Deleted Job Recovery | Restore jobs after deletion |

**Storage Location:** `/var/lib/jenkins/config-history`

**History XML Example:**
```xml
<?xml version='1.1' encoding='UTF-8'?>
<hudson.plugins.jobConfigHistory.HistoryDescr>
  <user>siddharth</user>
  <userId>siddharth</userId>
  <operation>Changed</operation>
  <timestamp>2024-10-02_09-52-27</timestamp>
</hudson.plugins.jobConfigHistory.HistoryDescr>
```

> ⚠️ **Warning:** Keeping every configuration change can consume significant disk space. Monitor storage and set retention limits.

**Summary:**
This plugin is the "git blame" for Jenkins configurations. Essential for audit compliance, debugging config regressions, and recovering from accidental deletions.

---

### 1.10 Build Monitor View

A live dashboard displaying job status, progress, and triggering user with auto-refresh.

**Setup:**
1. Install Build Monitor View Plugin
2. New View → Enter name → Select "Build Monitor View" → OK
3. Configure job filters (individual, regex, or all)
4. Apply → Save

**Display Options:**

| Option | Description |
|---|---|
| Text scale | Font size |
| Number of columns | Layout columns |
| Colorblind mode | High-contrast palette |
| Reduce motion | Disable CSS animations |
| Show badges | Build badges (PR #) |

**Status Colors:**
- **Green:** Success
- **Red:** Failure
- **Orange:** Unstable

**Production Scenario:**
Mounted on a wall-mounted TV in the DevOps team area, the Build Monitor View shows all 30+ microservice pipelines' real-time status, enabling instant visibility into build health across the organization.

**Summary:**
Build Monitor View is the "information radiator" for CI/CD teams, providing at-a-glance pipeline health visibility suitable for team dashboards and wall displays.

---

### 1.11 Monitoring with JavaMelody

JavaMelody provides in-depth performance dashboards for Jenkins, tracking memory, CPU, HTTP requests, and threads.

**Installation:**
1. Manage Jenkins → Manage Plugins → Search "Monitoring" → Install
2. Restart Jenkins

**Metrics Tracked:**

| Category | Details |
|---|---|
| Memory & CPU | Heap/non-heap, system CPU, load averages |
| HTTP Requests | Counts, cumulative times, mean/max durations |
| Thread Monitoring | Active vs. idle, creation rate, peak |
| Errors & Logs | Exception counts, severity breakdown |
| Reporting | HTML or PDF export |

**Accessing:**
- Manage Jenkins → Monitoring of Jenkins Instance (controller)
- Manage Jenkins → Monitoring of Jenkins Agents (nodes)

**Agent Monitoring Includes:**
- Garbage collection triggers
- Heap dump generation
- Memory histogram visualizations
- Active HTTP session details

> ⚠️ **Warning:** Monitoring plugins introduce additional JVM overhead. Monitor resource usage on production systems.

**Production Scenario:**
Before a production deployment window, check JavaMelody for thread pool saturation or memory pressure. If heap usage is above 80%, defer deployments until GC stabilizes.

**Summary:**
JavaMelody is a built-in APM for Jenkins. Use it for real-time diagnostics, capacity planning, and identifying bottlenecks before they impact build throughput.

---

## 2. Shared Libraries in Jenkins

### 2.1 Introduction to Shared Libraries

A Shared Library is a Git-hosted collection of Groovy scripts defining reusable pipeline steps. It centralizes common logic, eliminating duplication across Jenkinsfiles.

**Problems Without Shared Libraries:**
- **Duplication:** Copy-pasting identical pipeline blocks across repos
- **Inconsistency:** Updates in one pipeline aren't reflected in others
- **Complexity:** Scattering changes across repositories is error-prone

**Before (Hardcoded):**
```groovy
pipeline {
    agent any
    stages {
        stage('Welcome') {
            steps {
                sh 'echo Welcome to the DevOps team from Dasher Organization'
            }
        }
    }
}
```

**After (Shared Library):**
```groovy
// vars/welcomeMessage.groovy
def call() {
    sh 'echo Welcome to the DevOps team from Dasher Organization'
}
```

```groovy
// Jenkinsfile
@Library('kode-kloud-shared-library') _
pipeline {
    agent any
    stages {
        stage('Welcome') {
            steps {
                welcomeMessage()
            }
        }
    }
}
```

Now changing the organization name updates ALL pipelines automatically.

**Summary:**
Shared Libraries implement DRY (Don't Repeat Yourself) for Jenkins pipelines. One change in the library propagates to hundreds of pipelines, ensuring consistency and reducing maintenance burden.

---

### 2.2 Shared Library Repository Structure

```
(shared-library-repo)
├── src/           # Optional: compiled Groovy/Java classes
├── vars/          # Required: one .groovy per pipeline step
│   ├── welcomeMessage.groovy
│   └── welcomeMessage.txt   # Documentation for the step
└── resources/     # Optional: non-code files (JSON, shell scripts, templates)
```

| Directory | Purpose |
|---|---|
| src/ | Standard Java/Groovy classes (compiled on classpath) |
| vars/ | Each Groovy file defines a pipeline step; filenames use camelCase |
| resources/ | Static files loaded via `libraryResource` |

**Global Pipeline Libraries Configuration:**

| Field | Value |
|---|---|
| Name | `kode-kloud-shared-library` |
| Default Version | `main` (branch or tag) |
| Retrieval Method | Modern SCM (Git) with repository URL |
| Allow override | Enable to load other branches via @Library |

**Location:** Manage Jenkins → Configure System → Global Pipeline Libraries

**Summary:**
The `vars/` directory is the heart of shared libraries—each `.groovy` file becomes a callable pipeline step. Use `resources/` for shell scripts and templates that separate logic from Groovy code.

---

### 2.3 Loading Shared Libraries in Pipelines

**Loading Syntax:**
```groovy
@Library('dashers-trusted-shared-library') _
```

> 💡 The underscore (`_`) after `@Library` is mandatory syntax when importing.

**Loading a Specific Branch:**
```groovy
@Library('dashers-trusted-shared-library@featureTrivyScan') _
```

**Verification in Console Log:**
```
Loading library dashers-trusted-shared-library@main
git fetch --no-tags --progress ...
git checkout -f main
```

**Replacing Inline Methods:**
Remove inline utility functions (like Slack notifications) from Jenkinsfile and replace with library calls:

```groovy
// DELETE this from Jenkinsfile:
def slackNotificationMethod(String buildStatus = 'STARTED') { ... }

// REPLACE with:
@Library('dashers-trusted-shared-library') _
// Then in post block:
post {
    always {
        slackNotification(currentBuild.result)
    }
}
```

**Summary:**
Use `@Library` annotation to load shared libraries. Specify branch/tag versions for testing new library features before merging to main. The library is fetched from Git on every build.

---

### 2.4 Creating Custom Library Steps (TrivyScan)

**Goal:** Replace hardcoded Trivy vulnerability scan commands with reusable library functions.

**vars/TrivyScan.groovy:**
```groovy
def vulnerability(String imageName) {
    sh """
      echo "🔒 Scanning image: ${imageName}"
      trivy image ${imageName} \
        --severity LOW,MEDIUM,HIGH \
        --exit-code 0 --quiet \
        --format json -o trivy-medium.json

      trivy image ${imageName} \
        --severity CRITICAL \
        --exit-code 1 --quiet \
        --format json -o trivy-critical.json
    """
}

def reportsConverter() {
    sh '''
      trivy convert --format template \
        --template "@/usr/local/share/trivy/templates/html.tpl" \
        --output trivy-medium.html trivy-medium.json
      trivy convert --format template \
        --template "@/usr/local/share/trivy/templates/junit.tpl" \
        --output trivy-medium.xml trivy-medium.json
    '''
}
```

**Usage in Jenkinsfile:**
```groovy
@Library('shared-libraries@feature/trivy-scan') _

pipeline {
    agent any
    stages {
        stage('Security Checks') {
            steps {
                script {
                    TrivyScan.vulnerability("my-org/app:${env.GIT_COMMIT}")
                    TrivyScan.reportsConverter()
                }
            }
        }
    }
}
```

> 💡 **Important:** In Declarative Pipelines, method calls on shared library objects must be wrapped in `script {}` blocks.

**Summary:**
Centralize security scanning logic in shared libraries. Teams consume it with one line, and security teams can update scan parameters (severity levels, exit codes) without touching application repos.

---

### 2.5 Library Resources

Library Resources allow bundling static assets (shell scripts, YAML templates) under `resources/`. At runtime, pipelines load these via `libraryResource`.

**Structure:**
```
resources/
└── scripts/
    └── trivy.sh
vars/
├── TrivyScanScript.groovy
└── loadScript.groovy
```

**resources/scripts/trivy.sh:**
```bash
#!/bin/bash
set -euo pipefail
echo "imageName = $1"
echo "severity  = $2"
echo "exitCode  = $3"
trivy image "$1" --severity "$2" --exit-code "$3" \
  --format json -o "trivy-image-$2-results.json"
```

**vars/loadScript.groovy (Generic Loader):**
```groovy
def call(Map config = [:]) {
    def scriptData = libraryResource "scripts/${config.name}"
    writeFile file: config.name, text: scriptData
    sh "chmod +x ./${config.name}"
}
```

**vars/TrivyScanScript.groovy:**
```groovy
def vulnerability(Map config = [:]) {
    loadScript(name: 'trivy.sh')
    sh "./trivy.sh ${config.imageName} ${config.severity} ${config.exitCode}"
}
```

**Jenkinsfile Usage:**
```groovy
TrivyScanScript.vulnerability(
    imageName: 'my-app:latest',
    severity: 'CRITICAL',
    exitCode: '1'
)
```

**Benefits:**
- Shell scripts are version-controlled alongside Groovy
- Decouples script logic from Groovy code
- Pipeline authors pass custom arguments without touching library code

**Common Mistake:** Forgetting to quote the script name in `loadScript(name: 'trivy.sh')` — Groovy will try to resolve `trivy` as a property, causing `MissingPropertyException`.

**Summary:**
Library Resources separate static assets (shell scripts, templates) from Groovy orchestration code. Use `libraryResource` to load files and `writeFile` to make them available in the workspace.

---

## 3. Agents and Nodes in Jenkins

### 3.1 Types of Agents

| Agent Type | Description | Use Case |
|---|---|---|
| Permanent Agents | Dedicated nodes with pre-installed tools | Stable environments |
| Docker Agents | Ephemeral containers per build | Isolation, reproducibility |
| Cloud-Based Agents | On-demand VMs/pods (AWS, Azure, K8s) | Elastic scaling |
| Label-Based Agents | Nodes tagged by labels | Decoupling from topology |

**Agent Declarations in Jenkinsfile:**

```groovy
// Run anywhere
pipeline { agent any }

// Label-based
pipeline { agent { label 'my-agent' } }

// Docker
pipeline {
    agent {
        docker {
            image 'node:latest'
            args '-v $HOME/.npm:/root/.npm'
        }
    }
}

// Stage-level override
pipeline {
    agent { label 'my-agent' }
    stages {
        stage('Build') {
            agent { label 'nodejs-agent' }  // Override for this stage
            steps { sh 'npm install' }
        }
    }
}
```

> ⚠️ **Warning:** Permanent agents remain online even when idle, consuming resources. Use ephemeral Docker or cloud agents for variable workloads.

**Summary:**
Choose agent types based on workload patterns: permanent for stable baseline, Docker for reproducibility, Kubernetes for elastic scaling. Use labels to abstract physical topology from pipeline logic.

---

### 3.2 Creating and Configuring Nodes

**Steps to Add a JNLP Agent:**

1. Manage Jenkins → Manage Nodes → New Node
2. Configure:

| Field | Example |
|---|---|
| Description | Ubuntu build executor |
| # of Executors | 2 |
| Remote Root Directory | /home/jenkins-agent |
| Labels | docker jdk17 ubuntu |
| Usage | Only build jobs with matching labels |
| Launch method | JNLP |

3. Enable TCP Inbound Agent Port: Manage Jenkins → Configure Global Security → Agents → Fixed/Random

**Connecting the Agent:**
```bash
curl -sO http://<JENKINS_HOST>:8080/jnlpJars/agent.jar
echo <SECRET_TOKEN> > secret-file
chmod 600 secret-file

java -jar agent.jar \
  -url http://<JENKINS_HOST>:8080/ \
  -secret @secret-file \
  -name "ubuntu-agent" \
  -workDir "/home/jenkins-agent"
```

**Successful Connection Log:**
```
INFO: Connected
Inbound agent connected from 165.233.191.207:55522
Agent successfully connected and online
```

> ⚠️ **Security:** Keep the secret-file secure. Exposing it allows unauthorized agents to connect.

**Summary:**
JNLP agents are the standard for connecting external nodes to Jenkins. Secure the secret token, use dedicated service accounts, and monitor agent connectivity.

---

### 3.3 Utilizing Agents in Jobs

**Freestyle Job on External Agent:**
- Configuration → "Restrict where this project can be run" → Enter agent label

**Pipeline with Stage-Level Agent:**
```groovy
pipeline {
    agent any
    stages {
        stage('S1-Any Agent') {
            steps { sh 'node -v' }
        }
        stage('S2-Ubuntu Agent') {
            agent { label 'ubuntu-docker-jdk17-node20' }
            steps { sh 'node -v' }
        }
    }
}
```

**Workspace Comparison:**

| Scope | Workspace Path |
|---|---|
| Pipeline-level (agent any) | /var/lib/jenkins/workspace/job-name |
| Stage-level (external agent) | /home/jenkins-agent/workspace/job-name |

> 💡 **Best Practice:** Avoid running resource-intensive builds on the controller. Use labels to route to dedicated agents.

**Summary:**
Use stage-level agents to run specific stages on specialized hardware (GPU nodes, high-memory machines) while keeping other stages on general-purpose agents.

---

### 3.4 Docker Image Agent

Run build steps inside Docker containers for clean, reproducible environments.

```groovy
pipeline {
    agent {
        docker {
            image 'node:18-alpine'
            label 'ubuntu-docker-jdk17-node20'  // Run container ON this node
            alwaysPull true
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'node -v'
                sh 'npm -v'
            }
        }
    }
}
```

**What Happens Under the Hood:**
1. Jenkins pulls image (if alwaysPull=true)
2. Runs `docker run -d -v workspace:workspace ... node:18-alpine cat`
3. Executes `sh` steps inside container
4. Stops and removes container after pipeline completes
5. Image remains in local cache

**Docker Agent Configuration Options:**

| Field | Description |
|---|---|
| image | Docker image to run |
| args | Additional docker run flags |
| label | Node where container runs |
| registryUrl | Private registry URL |
| credentialsId | Registry auth credentials |
| alwaysPull | Pull every time (true/false) |

**Summary:**
Docker agents provide disposable, consistent build environments. The container is created per-build and destroyed after, ensuring no state leakage between builds.

---

### 3.5 Dockerfile Agent

Build a custom Docker image from a Dockerfile and use it as the build environment.

**Dockerfile.cowsay:**
```dockerfile
FROM node:18-alpine
RUN apk update && \
    apk add --no-cache git perl && \
    cd /tmp && \
    git clone https://github.com/jasonm23/cowsay.git && \
    cd cowsay && \
    ./install.sh /usr/local
```

**Jenkinsfile:**
```groovy
pipeline {
    agent any
    stages {
        stage('S4-Dockerfile Agent') {
            agent {
                dockerfile {
                    filename 'Dockerfile.cowsay'
                    label 'ubuntu-docker-jdk17-node20'
                }
            }
            steps {
                sh 'node -v'
                sh 'cowsay -f dragon "Running in custom container"'
            }
        }
    }
}
```

**Docker vs Dockerfile Agent:**

| Type | Definition | Use Case |
|---|---|---|
| docker | Uses pre-built remote image | Standard toolchains |
| dockerfile | Builds image locally from Dockerfile | Custom tools not in any image |

**Summary:**
Use Dockerfile agents when you need tools not available in any public image. Jenkins builds the image locally, caches layers, and runs your steps inside it.

---

### 3.6 newContainerPerStage

Controls container lifecycle: single shared container vs. fresh container per stage.

**Default Behavior (Single Container):**
All stages share one container and workspace. Files created in Stage 1 are available in Stage 2.

**With newContainerPerStage():**
```groovy
pipeline {
    agent {
        dockerfile { filename 'Dockerfile.cowsay' }
    }
    options {
        newContainerPerStage()
    }
    stages {
        stage('Stage-1') {
            steps {
                sh 'echo data > /tmp/file.txt'  // Creates file
            }
        }
        stage('Stage-2') {
            steps {
                sh 'cat /tmp/file.txt'  // FAILS - file doesn't exist
            }
        }
    }
}
```

> ⚠️ Files created in one stage are NOT available in subsequent stages with `newContainerPerStage()`.

| Approach | Isolation | File Sharing |
|---|---|---|
| Single container (default) | None | Files persist across stages |
| newContainerPerStage() | Full | No shared files |

**Summary:**
Use `newContainerPerStage()` when you need clean-slate environments for each stage (e.g., testing different configurations). Avoid it when stages need to share artifacts like compiled binaries.

---

### 3.7 Kubernetes Pod as Agent

Dynamically provision Kubernetes Pods as build agents using the Jenkins Kubernetes plugin.

**Kubernetes Cloud Configuration:**
1. Install Kubernetes plugin
2. Manage Jenkins → Clouds → Add Kubernetes
3. Configure: URL, namespace, credentials, pod retention

**Inline Pod Template:**
```groovy
pipeline {
    agent {
        kubernetes {
            cloud 'dasher-prod-k8s-us-east'
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
    - name: ubuntu-container
      image: ubuntu
      command: ["sleep"]
      args: ["infinity"]
    - name: node-container
      image: node:18-alpine
      command: ["cat"]
      tty: true
'''
            defaultContainer 'ubuntu-container'
        }
    }
    stages {
        stage('Node Commands') {
            steps {
                container('node-container') {
                    sh 'node -v'
                    sh 'npm -v'
                }
            }
        }
    }
}
```

**Key Points:**
- Jenkins automatically adds a `jnlp` sidecar container for agent communication
- Use `container('name')` to target specific containers per step
- `defaultContainer` sets which container runs steps without explicit `container()` block
- Pod Retention options: Never, On failure, Always

**External YAML File:**
```groovy
agent {
    kubernetes {
        cloud 'dasher-prod-k8s-us-east'
        yamlFile 'k8s-agent.yaml'
        defaultContainer 'node-18'
    }
}
```

**Service Account Setup for Least Privilege:**
```bash
kubectl create namespace jenkins
kubectl -n jenkins create serviceaccount jenkins-sa
kubectl -n jenkins create token jenkins-sa --duration=115d
kubectl -n jenkins create rolebinding jenkins-admin-binding \
  --clusterrole=admin --serviceaccount=jenkins:jenkins-sa
```

**Summary:**
Kubernetes agents provide auto-scaling, multi-container build environments. Define pod templates with specialized containers (build tools, database sidecars, security scanners) and target them per stage.

---

### 3.8 Sharing Files Between Containers

All containers in the same Kubernetes Pod share filesystem via `emptyDir` volumes.

```groovy
pipeline {
    agent { kubernetes { /* pod with ubuntu + node containers */ } }
    stages {
        stage('Write in Ubuntu') {
            steps {
                sh 'echo important_data > data.txt'
            }
        }
        stage('Read in Node.js') {
            steps {
                container('node-container') {
                    sh 'cat data.txt'  // Works! Same volume
                }
            }
        }
    }
}
```

**Pod Volume Spec:**
```yaml
spec:
  volumes:
    - name: workspace-volume
      emptyDir: {}
  containers:
    - name: ubuntu-container
      volumeMounts:
        - name: workspace-volume
          mountPath: /workspace
    - name: node-container
      volumeMounts:
        - name: workspace-volume
          mountPath: /workspace
```

**Summary:**
Within a single K8s Pod, all containers share the workspace volume. This enables workflows where one container builds and another tests without file transfer overhead.

---

## 4. Pipeline Enhancement and Caching

### 4.1 Refactoring Pipelines

Streamlining pipelines by removing unnecessary stages improves iteration speed during development.

**Refactored Pipeline (Essential Stages Only):**
```groovy
pipeline {
    agent any
    environment {
        MONGO_URI      = "mongodb+srv://supercluster.d83jj.mongodb.net/superData"
        MONGO_DB_CREDS = credentials('mongo-db-credentials')
    }
    options { timestamps() }
    stages {
        stage('Installing Dependencies') {
            steps { sh 'npm install --no-audit' }
        }
        stage('Dependency Scanning') {
            parallel {
                stage('NPM Audit') {
                    steps { sh 'npm audit --json > npm-audit-results.json' }
                }
            }
        }
        stage('Unit Testing') {
            steps { sh 'npm test' }
        }
        stage('Code Coverage') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'npm run coverage'
                }
            }
        }
        stage('Build Docker Image') {
            steps { sh 'docker build -t org/app:$GIT_COMMIT .' }
        }
        stage('Trivy Scan') {
            steps {
                sh 'trivy image org/app:$GIT_COMMIT --severity LOW,MEDIUM,HIGH --exit-code 0 --format json -o trivy-results.json'
            }
            post {
                always {
                    publishHTML([reportDir: '.', reportFiles: 'trivy-results.html', reportName: 'Trivy Report'])
                }
            }
        }
    }
}
```

**Summary:**
Remove deployment and notification stages during development. Use feature branches for experimental pipeline changes. Keep pipelines focused on the task at hand.

---

### 4.2 Sequential Stages

Sequential stages break down work inside parallel branches into ordered steps, improving visibility.

```groovy
stage('NodeJS 20') {
    agent { docker { image 'node:20-alpine' } }
    stages {
        stage('Install Dependencies') {
            steps { sh 'npm install --no-audit' }
        }
        stage('Testing') {
            steps { sh 'npm test' }
        }
    }
}
```

**Key Benefit:** Each sub-stage appears separately in the pipeline visualization, eliminating the need to drill into logs to monitor progress.

**Combined with Parallel:**
```groovy
stage('Unit Testing') {
    parallel {
        stage('NodeJS 18') { steps { sh 'npm test' } }
        stage('NodeJS 19') {
            steps {
                container('node-19') { sh 'npm test' }
            }
        }
        stage('NodeJS 20') {
            agent { docker { image 'node:20-alpine' } }
            stages {
                stage('Install') { steps { sh 'npm install' } }
                stage('Test') { steps { sh 'npm test' } }
            }
        }
    }
}
```

> ⚠️ **Important:** Docker agents in parallel branches don't share volumes with Kubernetes Pod agents. Install dependencies separately in each.

**Summary:**
Sequential stages within parallel branches provide granular visibility. Use them when a parallel branch has multiple ordered steps that benefit from individual status tracking.

---

### 4.3 Stash and Unstash

Transfer files between stages running on different agents.

| Step | Action |
|---|---|
| stash | Save files for later retrieval |
| unstash | Retrieve previously stashed files |

```groovy
pipeline {
    agent any
    options { preserveStashes(buildCount: 5) }
    stages {
        stage('Install') {
            steps {
                sh 'npm install'
                stash includes: 'node_modules/**', name: 'npm-deps'
            }
        }
        stage('Test on Different Agent') {
            agent { label 'test-node' }
            steps {
                unstash 'npm-deps'
                sh 'npm test'
            }
        }
    }
}
```

**Key Points:**
- Stashes are discarded when pipeline finishes (unless `preserveStashes()` is set)
- `preserveStashes(buildCount: 5)` retains stashes from last 5 builds
- Enables restarting from later stages without re-running earlier ones

**Common Error Without Stash:**
```
cat: quote.txt: No such file or directory
```
Files created on Agent A don't exist on Agent B without explicit transfer.

**Summary:**
Stash/unstash is the mechanism for sharing files between different agents or nodes within a pipeline. Use `preserveStashes()` to enable stage restart capability.

---

### 4.4 Pipeline Caching with Job Cacher

The Job Cacher plugin caches dependencies (like `node_modules`) across builds, dramatically reducing CI time.

**Installation:** Manage Jenkins → Manage Plugins → Install "Job Cacher"

**Configuration:**
```groovy
stage('Installing Dependencies') {
    steps {
        cache(maxCacheSize: 550, caches: [
            arbitraryFileCache(
                cacheName: 'npm-dependency-cache',
                cacheValidityDecidingFile: 'package-lock.json',
                includes: '**/*',
                path: 'node_modules'
            )
        ]) {
            sh 'npm install --no-audit'
            stash includes: 'node_modules/**', name: 'npm-deps'
        }
    }
}
```

**First Build (Cache Miss):**
```
Skip restoring cache as no up-to-date cache exists
+ npm install --no-audit
added 365 packages in 3s
Creating cache...
cache created in 164ms
```

**Subsequent Build (Cache Hit):**
```
Found cache for npm-dependency-cache
Restoring cache...
+ npm install --no-audit
up to date in 1s
Skip cache creation as the cache is up-to-date
```

**Summary:**
Pipeline caching eliminates redundant dependency downloads. The `cacheValidityDecidingFile` (package-lock.json) determines when the cache needs rebuilding. Combine with stash for multi-agent pipelines.

---

### 4.5 Cache Invalidation

The cache automatically invalidates when `package-lock.json` changes (new dependency added/removed).

**Trigger:** Adding a new package:
```bash
npm install localtunnel
git add package.json package-lock.json
git commit -m "Add localtunnel dependency"
git push
```

**Build Log (Cache Invalidation):**
```
hash does not match - cache outdated
+ npm install --no-audit
added 7 packages in 2s
Creating cache...
got hash 5a1549c4b8a6882fddf4b8ef16c2 for cacheValidityDecidingFile
Cache created in 2179ms
```

| Scenario | Cache Restored | Action |
|---|---|---|
| package-lock.json unchanged | Yes (hit) | Skip install, restore cache |
| package-lock.json modified | No (miss) | Reinstall & create new cache |

> 💡 **Best Practice:** Always commit `package-lock.json` to source control. Cache validity depends on this file's checksum.

**Summary:**
Cache invalidation is automatic based on the deciding file's hash. When dependencies change, the cache rebuilds. When they don't, builds are nearly instant.

---

## 5. Pipeline Structure - Scripted vs Declarative

### 5.1 Key Differences

| Feature | Declarative | Scripted |
|---|---|---|
| SCM Checkout | Automatic | Must add `checkout scm` |
| Syntax | Structured DSL (pipeline, stages, post) | Free-form Groovy (node, try-catch-finally) |
| Restart from Stage | Supported | Not supported |
| Post Actions | Built-in `post` block | `finally` block |
| Error Handling | `catchError`, `post { failure {} }` | `try-catch-finally` |

**Declarative:**
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps { sh 'echo building' }
        }
    }
    post {
        always { sh 'echo cleanup' }
    }
}
```

**Scripted:**
```groovy
node {
    try {
        stage('Build') {
            checkout scm  // Must be explicit!
            sh 'echo building'
        }
    } catch (err) {
        echo "Failed: ${err}"
    } finally {
        sh 'echo cleanup'
    }
}
```

**Summary:**
Declarative pipelines are recommended for most use cases due to built-in SCM checkout, stage restart, and structured syntax. Scripted pipelines offer full Groovy flexibility for complex logic.

---

### 5.2 Declarative Pipeline Features

**preserveStashes for Stage Restart:**
```groovy
pipeline {
    agent any
    options { preserveStashes(buildCount: 5) }
    stages {
        stage('Generate') {
            agent { label 'ubuntu-agent' }
            steps {
                writeFile file: 'data.txt', text: 'important'
                stash name: 'data', includes: 'data.txt'
            }
        }
        stage('Display') {
            steps {
                unstash 'data'
                sh 'cat data.txt'
            }
        }
    }
}
```

Without `preserveStashes`, restarting from "Display" stage fails because the stash from a previous run isn't retained.

**Summary:**
Declarative pipelines support stage restart, which is critical for long-running pipelines where a late stage fails and you don't want to re-run hours of earlier stages.

---

### 5.3 Scripted Pipeline Patterns

**Tool Setup:**
```groovy
node {
    env.NODEJS_HOME = tool 'nodejs-22-6-0'
    env.PATH = "${env.NODEJS_HOME}/bin:${env.PATH}"

    properties([
        disableConcurrentBuilds(abortPrevious: true),
        disableResume()
    ])

    stage('Checkout') { checkout scm }

    wrap([$class: 'TimestamperBuildWrapper']) {
        stage('Install') {
            cache(maxCacheSize: 550, caches: [
                arbitraryFileCache(
                    cacheName: 'npm-cache',
                    cacheValidityDecidingFile: 'package-lock.json',
                    path: 'node_modules'
                )
            ]) {
                sh 'npm install --no-audit'
                stash includes: 'node_modules/**', name: 'deps'
            }
        }
    }
}
```

**Credentials in Scripted Pipeline:**
```groovy
node('ubuntu-agent') {
    stage('Unit Testing') {
        env.MONGO_URI = 'mongodb+srv://...'
        withCredentials([usernamePassword(
            credentialsId: 'mongo-db-creds',
            usernameVariable: 'MONGO_USERNAME',
            passwordVariable: 'MONGO_PASSWORD'
        )]) {
            sh 'npm test'
        }
    }
}
```

> 💡 Scripted pipelines don't support declarative `environment` blocks. Use `withCredentials` instead.

**Summary:**
Scripted pipelines require explicit tool setup, checkout, and credential injection. They offer full Groovy power but need more boilerplate code for common tasks.

---

### 5.4 Scripted Pipeline with Kubernetes

```groovy
podTemplate(
    cloud: 'dasher-prod-k8s-us-east',
    label: 'nodejs-pod',
    containers: [
        containerTemplate(
            name: 'node-18', image: 'node:18-alpine',
            command: 'sleep', args: '9999999',
            ttyEnabled: true, privileged: true
        )
    ]
) {
    node('ubuntu-agent') {
        // Static agent: checkout + install
        stage('Checkout') { checkout scm }
        stage('Install') {
            sh 'npm install --no-audit'
            stash includes: 'node_modules/**', name: 'deps'
        }
    }

    node('nodejs-pod') {
        container('node-18') {
            // K8s pod: test
            checkout scm        // Must checkout again!
            unstash 'deps'      // Must unstash!
            stage('Test') { sh 'npm test' }
        }
    }
}
```

**Critical Points:**
- Switching nodes does NOT carry workspace or files
- Always `checkout scm` on every new node
- Use `stash`/`unstash` to transfer between agents

**Common Failure:**
```
npm ERR! ENOENT: no such file or directory, open 'package.json'
```
**Fix:** Add `checkout scm` inside the K8s node block.

**Summary:**
In scripted pipelines with K8s agents, explicit checkout and file transfer is mandatory when switching between nodes. The coding agent doesn't inherit workspace context across different agents.

---

### 5.5 Best Practices for Scripted Pipelines

| Practice | Benefit |
|---|---|
| Stick to basic Groovy syntax | Easier debugging |
| Avoid direct Jenkins API calls | Use Pipeline Step Plugins instead |
| Prefer CLI tools over Groovy libraries | Reduce controller memory |
| Don't do raw network/I/O in Jenkinsfile | Use sh/bat steps |
| Keep pipelines under 300 steps | Maintainability |
| Delegate heavy work to agents | Keep controller responsive |

> ⚠️ **Never:** Invoke `hudson.model.*` APIs from Jenkinsfile. Develop a custom Pipeline Step Plugin instead.

> ⚠️ **Never:** Fetch URLs or read/write files directly in Groovy. Wrap in `sh` or `bat` steps.

**Summary:**
Pipelines should be "glue code" that orchestrates external tools. Keep Groovy simple, avoid internal API calls, and delegate computation to agents and CLI tools.

---

## 6. Jenkins Administration and Monitoring - Part 2

### 6.1 Jenkins Supervision Overview

Proactive monitoring prevents disruptions, reduces deployment delays, and maintains throughput.

**Log Locations by Installation:**

| Type | Location | Config File |
|---|---|---|
| Debian (APT) | /var/log/jenkins/jenkins.log | /etc/default/jenkins |
| Red Hat (YUM) | /var/log/jenkins/jenkins.log | /etc/sysconfig/jenkins |
| Docker | Container stdout | N/A |
| Windows | %JENKINS_HOME%\jenkins.out | Jenkins.xml |

**Built-In Load Statistics:** Manage Jenkins → Load Statistics
- Available Executors, Busy Executors, Queue Size, Overall Load

**Monitoring Plugins:**

| Plugin | Purpose |
|---|---|
| Monitoring (JavaMelody) | CPU, memory, GC, HTTP, threads |
| Disk Usage | Per-job storage tracking |
| Build Monitor | Dashboard of job statuses |
| Prometheus + Grafana | Enterprise metrics/dashboards |
| Datadog/New Relic | APM integration |

**Auditing Plugins:**
- **Audit Trail:** Records every user action (file, syslog, elasticsearch)
- **Job Config History:** Version-controls config.xml with diff/rollback

**Summary:**
Combine JavaMelody for real-time diagnostics, Prometheus/Grafana for historical metrics, and Audit Trail + Job Config History for compliance and debugging.

---

### 6.2 Log Recorders

Custom log recorders allow targeted debugging of specific Jenkins components.

**5 Configuration Methods:**

| Method | Persistence |
|---|---|
| UI Logger | Runtime only |
| Groovy init script | Persistent |
| logging.properties file | Persistent |
| File system XML recorder | Persistent |
| XML via UI | Resets on restart |

**Creating via UI:**
1. Manage Jenkins → System Log → Add new log recorder
2. Name it (e.g., `k8s-logs`)
3. Add logger package: `io.fabric8.kubernetes.client`
4. Set level: ALL/FINE/FINEST

**Groovy Init Script (persistent):**
```groovy
// JENKINS_HOME/init.groovy.d/logging.groovy
import java.util.logging.Level
import java.util.logging.Logger

Logger.getLogger("hudson.plugins.git.GitStatus").setLevel(Level.SEVERE)
```

**Debugging K8s Connection:**
```
FINEST io.fabric8.kubernetes.client.HttpLoggingInterceptor
> GET https://cluster.../namespaces/jenkins/pods
> Authorization: Bearer eyJh...
< 403 Forbidden
```

> 💡 Delete custom log recorders after troubleshooting to restore performance.

**Summary:**
Log recorders provide surgical debugging capability. Enable verbose logging only for the specific package causing issues, diagnose, then disable. Never leave FINE/FINEST logging enabled in production.

---

### 6.3 Audit Trail Plugin

Records every user action for security compliance and forensics.

**Installation:** Manage Plugins → Install "Audit Trail"

**Configuration:**
1. Manage Jenkins → Configure System → Audit Trail
2. Logger: Log file (daily rotation)
3. Pattern: `/var/log/jenkins/custom-audit-%g.log`

**URL Patterns to Log:**
```
*/(configSubmit|doDelete|postBuildResult|enable|disable|cancelQueue|stop|toggleLogKeep|doWipeOutWorkspace|createItem|createView|toggleOffline|cancelQuietDown|quietDown|restart|exit)
```

**Sample Log Entry:**
```
Nov 10 10:29:36 PM job/monitor-jenkins/configSubmit by siddharth from 124.123.186.17
Nov 10 10:29:37 PM job/monitor-jenkins/#29 Started by user siddharth
```

**Logger Types:**

| Type | Use Case |
|---|---|
| File Logger | Local rotating files |
| Syslog Logger | Centralized syslog server |
| Console Logger | Debug only (not production) |
| Elasticsearch Logger | Advanced search/analytics |

**Summary:**
Audit Trail is mandatory for regulated environments. It answers "who did what, when, from where" for every Jenkins action. Forward to centralized logging for long-term retention.

---

### 6.4 Forwarding Audit Logs to External Servers

Ship Jenkins audit logs to Elasticsearch/Elastic Cloud for centralized analysis.

**Steps:**
1. Set up Elastic Cloud Observability trial
2. Install Elastic Agent on Jenkins controller
3. Configure agent to read `/var/log/jenkins/custom*`
4. Verify in Kibana → Observability → Logs

**elastic-agent.yml Configuration:**
```yaml
outputs:
  default:
    type: elasticsearch
    hosts: ['https://cluster.us-central1.gcp.cloud.es.io:443']
    api_key: 'YOUR_API_KEY'

inputs:
  - id: jenkins-audit-logs
    type: logfile
    streams:
      - paths:
          - /var/log/jenkins/custom*
        exclude_files: ['*.gz']
        tags: ['jenkins', 'audit']
```

```bash
sudo systemctl restart elastic-agent
```

**Summary:**
Centralizing audit logs in Elasticsearch enables advanced search, correlation with other system events, and long-term retention beyond local disk. Essential for enterprise compliance.

---

### 6.5 Groovy Sandbox and Script Approval

Jenkins protects against malicious Groovy code using two layers: Groovy Sandbox and In-Process Script Approval.

**Groovy Sandbox:**
- Enabled by default for pipeline scripts
- Restricts available APIs
- Blocks unapproved methods/classes

**In-Process Script Approval:**
- Queues scripts requiring extra permissions
- Admins review and approve/deny

**Disabling Sandbox → Error:**
```
scriptsecurity.scripts.UnapprovedUsageException: script not yet approved for use
```

**Approval Flow:**
1. Build fails with permission error
2. Manage Jenkins → In-Process Script Approval
3. Review pending signature
4. Click Approve
5. Rebuild succeeds

**Whitelists and Blacklists:**
- Whitelist: `staticField jenkins.model.Jenkins VERSION` (allowed)
- Blacklist: `staticMethod hudson.model.Hudson getInstance` (blocked by default)

**Example (Requires Approval):**
```groovy
pipeline {
    agent any
    stages {
        stage('Get Hudson Instance') {
            steps {
                script {
                    def hudson = hudson.model.Hudson.getInstance()
                    println "Hudson: ${hudson}"
                }
            }
        }
    }
}
```

**Enforcing Sandbox Globally:**
1. Manage Jenkins → Configure Global Security
2. Check "Force Use of Groovy Sandbox"
3. Check "Hide the sandbox checkbox in Pipeline jobs"

> ⚠️ Hiding checkbox only affects UI. Users can still disable via CLI or REST API.

**Summary:**
The Groovy Sandbox is Jenkins' primary defense against malicious pipeline code. Keep it enabled, review approval requests carefully, and enforce it globally for non-admin users.

---

### 6.6 Migrating Jenkins to Another Node

**Prerequisites:**
- Jenkins versions must match on both VMs
- JDK versions must be identical
- Root/sudo access on both machines

**Steps:**

**On Source Node:**
```bash
systemctl stop jenkins
systemctl disable jenkins
cd /var/lib
tar -czf jenkins-backup.tar.gz jenkins
scp jenkins-backup.tar.gz root@TARGET_IP:/tmp/
```

**On Target Node:**
```bash
systemctl stop jenkins
systemctl disable jenkins
mv /tmp/jenkins-backup.tar.gz /var/lib/
cd /var/lib
rm -rf jenkins
tar -xzf jenkins-backup.tar.gz
chown -R jenkins:jenkins jenkins
systemctl enable jenkins
systemctl start jenkins
```

**Verification:** Open browser to `http://TARGET_IP:8080` — all jobs, credentials, plugins intact.

> ⚠️ If versions differ, you risk plugin incompatibilities or startup failures.

**Summary:**
Jenkins migration is essentially a tar backup of JENKINS_HOME, transfer to new host, and restore with correct ownership. Ensure version parity between source and target.

---

## 7. Backup and Configuration Management

### 7.1 Backing Up and Restoring Jenkins

**Backup Methods:**

| Method | Pros | Cons |
|---|---|---|
| Filesystem Snapshots (LVM/Cloud) | Fast, consistent | Requires compatible storage |
| Thin Backup Plugin | Easy, automated | Plugin limitations |
| Custom Shell Scripts (rsync/tar) | Fully customizable | Requires maintenance |
| Hybrid (local + offsite) | Maximum redundancy | More complex |

**Essential Directories in JENKINS_HOME:**

| Component | Purpose |
|---|---|
| config.xml | Main system settings |
| jobs/ | Job definitions & build history |
| plugins/ | Installed plugins |
| secrets/ | Encryption keys & credentials |
| userContent/ | Static files |
| workspace/ | Working directories (safe to skip) |

> ⚠️ **Never** store unencrypted secrets in shared backup locations. Always encrypt backups containing `secrets/`.

**Restore Steps:**
```bash
sudo systemctl stop jenkins
# Restore backup to /var/lib/jenkins
sudo chown -R jenkins:jenkins /var/lib/jenkins
sudo systemctl start jenkins
sudo journalctl -u jenkins -f
```

**Summary:**
Back up JENKINS_HOME regularly. Focus on config.xml, jobs/, plugins/, and secrets/. Skip workspace/ (recreated on build). Schedule daily incrementals + weekly full backups.

---

### 7.2 Thin Backup Plugin

Lightweight, configurable backup of Jenkins home content.

**Configuration:**
1. Manage Jenkins → Configure System → Thin Backup
2. Set Backup Directory: `/var/lib/jenkins/Jenkins_backup`
3. Options: Schedule, max backup sets, exclude patterns, include build results

**Manual Backup:** Manage Jenkins → Tools and Actions → Backup Now

**Restoring:**
1. Manage Jenkins → Thin Backup → Restore Configuration
2. Select backup date → Restore
3. Restart Jenkins

**Recovering Deleted Jobs:**
1. Delete job from dashboard
2. Job Config History → Filter "Deleted Jobs"
3. Find delete event → Restore

> ⚠️ Backing up build results and artifacts consumes significant disk space. Monitor storage.

**Summary:**
Thin Backup is the simplest automated backup solution for Jenkins. Configure scheduled backups with retention limits, and test restores periodically to validate integrity.

---

### 7.3 Validating Backups

Always validate backup archives in an isolated environment before trusting them for disaster recovery.

**Create Backup:**
```bash
cd /var/lib
tar -zcvf /tmp/jenkins_home-$(date +"%Y%m%d%H%M").tar.gz jenkins
```

**Validate in Sandbox:**
```bash
systemctl stop jenkins
cp -r jenkins /tmp/jenkins-backup
export JENKINS_HOME=/tmp/jenkins-backup
java -jar jenkins.war --httpPort=9999
```

**Verify:** Open `http://host:9999` → Confirm all jobs, plugins, credentials present.

> 💡 **Best Practice:** Use timestamps in backup filenames for easy tracking and rotation.

**Summary:**
Untested backups are not backups. Periodically restore to a sandbox environment on a different port to verify completeness. Include this in your DR runbook.

---

### 7.4 Upgrading Jenkins

**Safe Upgrade Process:**

1. **Check updates:** Manage Jenkins → shows available version
2. **Review changelog:** Confirm no breaking changes
3. **Prepare for Shutdown:** Manage Jenkins → Prepare for Shutdown (blocks new builds)
4. **Wait for queue to drain**
5. **Stop service:**
```bash
sudo systemctl stop jenkins
```
6. **Backup current WAR:**
```bash
sudo mv /usr/share/java/jenkins.war /usr/share/java/jenkins.war.bak
```
7. **Download new WAR:**
```bash
sudo wget -O /usr/share/java/jenkins.war \
  https://updates.jenkins.io/download/war/2.492.1/jenkins.war
```
8. **Start:**
```bash
sudo systemctl start jenkins
```
9. **Verify version** in dashboard footer

**Release Types:**

| Type | Frequency | Use For |
|---|---|---|
| LTS | Every 12 weeks | Production |
| Weekly | Every week | Testing latest features |

> 💡 "Prepare for Shutdown" lets in-flight builds complete while preventing new ones from starting.

**Summary:**
Always use "Prepare for Shutdown" before upgrades to prevent interrupted builds. Back up the WAR file, verify the changelog, and test plugin compatibility after upgrade.

---

### 7.5 Jenkins Configuration as Code (JCasC)

Define entire Jenkins controller configuration in YAML, stored in Git for version control.

**Installation:** Install "Configuration as Code" plugin

**Accessing:** Manage Jenkins → Configuration as Code → View/Replace/Reload

**Sample YAML:**
```yaml
jenkins:
  systemMessage: "Managed by JCasC"
  numExecutors: 2
  mode: NORMAL
  securityRealm:
    local:
      allowsSignup: false
  authorizationStrategy:
    globalMatrix:
      permissions:
        - "USER:Overall/Administer:admin"
        - "GROUP:Overall/Read:authenticated"

tools:
  nodejs:
    installations:
      - name: "nodejs-22-6-0"
        properties:
          - installSource:
              installers:
                - nodeJSInstaller:
                    id: "22.6.0"

credentials:
  system:
    domainCredentials:
      - credentials:
          - usernamePassword:
              id: "gitea-creds"
              username: "admin"
              password: "{encrypted}"
              scope: GLOBAL

jobs:
  - script: >
      folder('test-jobs')
  - script: >
      pipelineJob('test-jobs/hello') {
        definition {
          cps {
            script("""
              pipeline {
                agent any
                stages {
                  stage('test') { steps { echo 'hello' } }
                }
              }
            """.stripIndent())
          }
        }
      }
```

**Applying:**
1. Save YAML to `/var/lib/jenkins/casc.yaml`
2. Manage Jenkins → Configuration as Code → Replace Configuration → path
3. Apply New Configuration

> ⚠️ **Prerequisite for jobs section:** Install the "Job DSL" plugin, otherwise you get `UnknownConfiguratorException`.

**Benefits:**
- Version-controlled in Git
- Reproducible across environments
- No manual clicking
- Easy rollback via git revert

**Summary:**
JCasC is the gold standard for managing Jenkins at scale. Store your YAML in Git, apply on startup, and treat Jenkins configuration like any other code artifact.

---

### 7.6 Pipeline Durability

Controls how pipeline state is written to disk for crash recovery.

| Level | Description | Trade-off |
|---|---|---|
| MAX_SURVIVABILITY | Writes state after every step | Safest, most I/O |
| SURVIVABLE_NON_ATOMIC | Compromise | Balanced |
| PERFORMANCE_OPTIMIZED | Minimal disk writes | Fastest, no resume on crash |

**Configuration Scopes:**
1. **Global:** Manage Jenkins → Configure System → Pipeline Speed/Durability
2. **Branch-level:** Multibranch → Property strategy → Named branches
3. **Per-job:** Job → Configure → Pipeline Speed and Durability

**MAX_SURVIVABILITY Demo:**
```
Resuming build at Sun Nov 10 17:22:47 UTC 2024 after Jenkins restart
[Pipeline] sh
+ echo 40
```
Build resumes from where it left off.

**PERFORMANCE_OPTIMIZED After Crash:**
```
ERROR: Cannot resume build because FlowNode could not be loaded.
Finished: FAILURE
```

> 💡 Use MAX_SURVIVABILITY for production deployments, PERFORMANCE_OPTIMIZED for fast feedback loops on feature branches.

**Summary:**
Pipeline durability is a trade-off between resilience and speed. Critical pipelines (production deployments) need MAX_SURVIVABILITY; fast CI feedback loops benefit from PERFORMANCE_OPTIMIZED.

---

### 7.7 Migrating to GitHub Actions

The GitHub Actions Importer CLI tool converts Jenkins jobs to GitHub Actions workflows.

**Limitations:**
- Only declarative pipelines supported
- Secrets must be recreated manually
- Unknown plugins need manual handling

**Process:**
```bash
# Install
gh extension install github/gh-actions-importer

# Configure
gh actions-importer configure  # Enter GitHub token + Jenkins token

# Dry run
gh actions-importer dry-run jenkins \
  --source-url http://jenkins:8080/job/MyJob/ \
  --output-dir tmp/dry-run

# Migrate (creates PR)
gh actions-importer migrate jenkins \
  --source-url http://jenkins:8080/job/MyJob/ \
  --target-url https://github.com/org/repo \
  --output-dir tmp/migrate
```

**Generated Workflow:**
```yaml
name: MyJob
on:
  workflow_dispatch:
  push:
    branches: [main]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Build
        run: npm install && npm test
```

**Summary:**
The Actions Importer automates most of the migration from Jenkins to GitHub Actions. Review generated workflows, manually add secrets, and handle any unconverted plugins. Use dry-run first to preview changes.

---

## Final Production Best Practices Summary

| Area | Best Practice |
|---|---|
| Security | Enable CSRF, use Groovy Sandbox, scope credentials to folders |
| Monitoring | JavaMelody + Prometheus/Grafana + Audit Trail |
| Backup | Daily incremental + weekly full + test restores |
| Configuration | JCasC in Git, Job DSL for jobs |
| Agents | Kubernetes for scaling, Docker for isolation, labels for routing |
| Pipelines | Shared Libraries for DRY, caching for speed, stash for multi-agent |
| Upgrades | Prepare for Shutdown → backup → upgrade → verify |
| Durability | MAX_SURVIVABILITY for prod, PERFORMANCE_OPTIMIZED for dev |
