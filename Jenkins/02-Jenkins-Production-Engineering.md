# Jenkins Handbook — Part 2: Production Engineering (Security, Tools, Docker, Kubernetes, Terraform, Agents, Shared Libraries)

> Picks up where Part 1 (Fundamentals) left off. Every "Simple Definition" includes a plain-English analogy before the technical depth, examples, troubleshooting, and interview questions.

## Table of Contents
- [15. Jenkins Credentials Management](#15-jenkins-credentials-management)
- [16. Using withCredentials in Pipelines](#16-using-withcredentials-in-pipelines)
- [17. User Management & RBAC](#17-user-management--rbac)
- [18. Jenkins Security & Production Hardening](#18-jenkins-security--production-hardening)
- [19. Global Tools Configuration](#19-global-tools-configuration)
- [20. Docker and Jenkins](#20-docker-and-jenkins)
- [21. Kubernetes and Jenkins](#21-kubernetes-and-jenkins)
- [22. Terraform and Jenkins](#22-terraform-and-jenkins)
- [23. Jenkins Master/Agent Architecture](#23-jenkins-masteragent-architecture)
- [24. Configuring and Scaling Agents](#24-configuring-and-scaling-agents)
- [25. Complete CI/CD Pipeline Design](#25-complete-cicd-pipeline-design)
- [26. Jenkins Shared Libraries](#26-jenkins-shared-libraries)
- [27. Remote Build Triggering](#27-remote-build-triggering)

---

## 15. Jenkins Credentials Management

### In Plain English (Beginner Explanation)
Credentials are like a locked safe in the manager's office. Instead of writing the safe's combination on a sticky note taped to a recipe card where anyone walking by can read it (hardcoding a password directly in your Jenkinsfile), you just write "use Safe #4" (a Credential ID), and Jenkins knows to securely fetch the actual combination only when it's actually needed.

### Simple Definition
Jenkins **Credentials** are a secure storage system for secrets (passwords, tokens, keys) so they never need to be typed directly into a Jenkinsfile or job configuration in plain text.

### Credential Types, In Detail
| Type | Used For | Real-World Example |
|---|---|---|
| **Secret Text** | A single token/string | An API key for a third-party service |
| **Username with Password** | Basic auth pairs | Login for a private Docker registry |
| **SSH Username with Private Key** | SSH-based access | Cloning a private Git repo over SSH, or connecting to an SSH agent |
| **Certificate** | Client certificates | Mutual-TLS-secured internal systems |
| **AWS Credentials** | Access key/secret key pairs | AWS CLI/SDK calls (though IAM roles are preferred where possible) |

### Jenkins UI Navigation
```
Manage Jenkins → Credentials → System → Global credentials (unrestricted) → Add Credentials
  → choose Kind (Secret Text / Username-Password / SSH Key / etc.)
  → set an ID (this exact string is what your Jenkinsfile will reference)
  → Save
```

### How It Works in a Pipeline
Every credential gets a unique **Credential ID**. Instead of putting the secret itself in your Jenkinsfile, you reference this ID, and Jenkins injects the actual value at runtime — automatically masking it in console logs so it never appears in plain text in build output.

### Why It Matters
Storing secrets in plaintext inside a Jenkinsfile (which lives in Git, visible to your whole team and possibly the public) is a serious security risk. The Credentials Store keeps secrets completely out of source code.

### Extended Walkthrough: Adding and Using a Secret Text Credential
```
1. Manage Jenkins → Credentials → System → Global credentials → Add Credentials
2. Kind: Secret Text
3. Secret: <paste your actual API key>
4. ID: my-api-key
5. Save
```
Then in a Jenkinsfile:
```groovy
withCredentials([string(credentialsId: 'my-api-key', variable: 'API_KEY')]) {
    sh 'curl -H "Authorization: Bearer $API_KEY" https://api.example.com/status'
}
```

### Additional Production Knowledge: Safer AWS Authentication
Rather than storing long-lived AWS access keys as Jenkins Credentials, a more secure production pattern is to attach an **IAM role** directly to the EC2 instance (or Kubernetes service account) running the Jenkins agent. The AWS SDK/CLI then automatically picks up temporary, auto-rotating credentials from the instance's role — meaning there's no long-lived secret to store, leak, or manually rotate at all.

### Scoping Credentials — Global vs Folder-Level
- **Global credentials** are visible to any job across the entire Jenkins instance.
- **Folder-scoped credentials** are only visible to jobs inside that specific folder, letting you isolate one team's secrets from another's — an important least-privilege practice as your Jenkins instance grows to serve multiple teams.

### Common Mistakes
- Hardcoding secrets directly in a Jenkinsfile or shell step instead of using Credentials.
- Using long-lived AWS access keys when an IAM role would work and is genuinely more secure.
- Granting credentials broader scope/folder access than necessary, violating least privilege.
- Reusing the same credential across many unrelated teams/projects instead of scoping narrowly.

### Debugging/Troubleshooting
- **Symptom:** "Credential ID not found" → **Cause:** typo in the ID, or the credential is scoped to a different folder than the job → **Fix:** verify the exact ID and its configured scope in Manage Jenkins → Credentials.
- **Symptom:** Credential works in one job but not another → **Cause:** folder-scoped credential not visible outside its own folder → **Fix:** move it to a shared parent folder or global scope if genuinely needed by multiple teams.

### Best Practices
- Always reference credentials by ID; never inline secret values anywhere.
- Scope credentials to the folder/job that actually needs them, not globally, wherever practical.
- Prefer IAM roles over static AWS keys when running Jenkins on AWS infrastructure.
- Rotate long-lived secrets periodically, even if they aren't known to be compromised.

### Interview Questions
**Q: How does Jenkins prevent a stored credential from leaking into build logs?**
A: When a credential is accessed via `withCredentials`, Jenkins automatically masks its actual value in console output wherever it detects the known secret string being printed.

**Q: Why prefer an IAM role over storing AWS access keys as a Jenkins credential?**
A: An IAM role attached to the instance provides temporary, automatically-rotating credentials with no long-lived secret to leak or manually rotate, whereas static access keys are a persistent secret that must be stored, protected, and rotated manually.

**Q: What's the difference between global and folder-scoped credentials?**
A: Global credentials are visible to any job in the Jenkins instance; folder-scoped credentials are only visible to jobs within that specific folder, supporting least-privilege isolation between teams/projects.

**What You Should Remember:** Credentials Store keeps secrets out of your Jenkinsfiles and source code. Reference by Credential ID; prefer IAM roles over static AWS keys when possible; scope credentials narrowly.

---

## 16. Using withCredentials in Pipelines

### In Plain English (Beginner Explanation)
`withCredentials` is like handing a cook the safe combination just long enough to grab exactly what they need for one specific task, then immediately taking it back — the combination is never left lying around in view (in the logs) once the task is finished.

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
- Inside the `sh` block, `$DOCKER_USER` / `$DOCKER_PASS` behave like normal environment variables, but Jenkins automatically masks their actual values in the console log output.
- `echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin` — logs into the registry without ever typing the password directly as a command-line argument (which risks exposure in process listings visible to other users on the same machine).

### Extended Example: Using Multiple Credential Types at Once
```groovy
withCredentials([
    usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS'),
    string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN'),
    file(credentialsId: 'eks-kubeconfig', variable: 'KUBECONFIG')
]) {
    sh '''
        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
        mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN
        kubectl get pods
    '''
}
```
A single `withCredentials` block can pull in several different credential types simultaneously — a username/password pair, a plain secret token, and a file-based kubeconfig — each mapped to its own variable, all scoped to just this one block of steps.

### Why It Matters
This is the standard, secure way to use any secret inside a pipeline step — masking prevents secrets from leaking into build logs even if a script accidentally attempts to print them.

### Common Mistakes
- Accidentally `echo`-ing a credential variable directly (e.g., `echo $DOCKER_PASS`) — even though Jenkins tries to mask known secret values wherever they appear, this remains risky practice and should be avoided as a habit.
- Using credential variables outside the `withCredentials` block's scope, where they're no longer defined or masked.
- Writing secrets to a file on disk without cleaning it up afterward, leaving them readable on the agent long after the build finishes.

### Debugging/Troubleshooting
- **Symptom:** A credential variable is empty/undefined → **Cause:** the step referencing it is outside the `withCredentials` block → **Fix:** move the step inside the block, or restructure so the block wraps everything that needs the secret.
- **Symptom:** Secret appears unmasked in logs → **Cause:** the actual runtime value differs from what Jenkins expects to mask (e.g., it was transformed/encoded before printing) → **Fix:** never manipulate a secret value in a way that could produce a different string before it's logged.

### Best Practices
- Keep the `withCredentials` block as narrow/short as possible — only wrap the exact steps that genuinely need the secret.
- Never write raw secret values to log files, build artifacts, or any persisted output.
- Clean up any temporary files containing secrets (like a downloaded kubeconfig) at the end of the stage if they aren't needed afterward.

### Interview Questions
**Q: Why is `withCredentials` preferred over simply setting an environment variable manually with a secret value?**
A: `withCredentials` scopes the secret's availability narrowly to the wrapped block and enables Jenkins's automatic log masking, whereas manually setting a plain environment variable offers neither protection.

**Q: Can `withCredentials` handle multiple different credential types in one block?**
A: Yes — a single `withCredentials([...])` call can list several credential bindings (username/password, secret text, file, etc.) simultaneously, each mapped to its own variable.

**What You Should Remember:** `withCredentials` securely injects a credential into scoped variables for a block of steps, with automatic log masking — the standard, safe way to use secrets in a pipeline.

---

## 17. User Management & RBAC

### In Plain English (Beginner Explanation)
RBAC is like a restaurant's staff badge system: a dishwasher's badge doesn't open the manager's office, and an intern's badge doesn't let them fire the whole kitchen staff. Everyone gets exactly the access their actual job requires — nothing more, nothing less.

### Simple Definition
RBAC (Role-Based Access Control) controls **who can do what** in Jenkins — which users/groups can view, configure, build, or administer specific jobs and folders.

### Why It Matters
By default, a freshly installed Jenkins often grants fairly broad access to any logged-in user. In a team/production setting, you need fine-grained control — e.g., developers can trigger builds but not change security settings; only DevOps admins can edit credentials or system configuration.

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

### Extended Walkthrough: Setting Up a Team-Scoped Role
```
1. Manage Roles → Item Roles → Add
   Name: "team-alpha-dev"
   Pattern: "team-alpha-.*"     (matches any job whose name starts with "team-alpha-")
   Permissions: Job/Build, Job/Read, Job/Configure

2. Assign Roles → Item Roles → "team-alpha-dev"
   Add users: alice, bob

Result: alice and bob can build/read/configure any job named "team-alpha-*",
        but have no access whatsoever to jobs outside that naming pattern.
```
This pattern-based scoping is what lets one Jenkins instance safely serve many independent teams without them being able to see or touch each other's jobs.

### Common Mistakes
- Giving every user the built-in "admin" role for convenience — a direct violation of least privilege that turns any single compromised account into a full system compromise.
- Not scoping Item Roles to specific folders/patterns, accidentally granting access across the entire Jenkins instance instead of just one team's jobs.
- Forgetting to periodically audit role assignments as team membership changes — former employees or transferred staff may retain access they no longer need.

### Debugging/Troubleshooting
- **Symptom:** A user can't see a job they should have access to → **Cause:** their assigned role's pattern doesn't match that job's name, or they weren't actually assigned the role → **Fix:** review the Item Role's pattern and the user's role assignments.
- **Symptom:** A user has more access than intended → **Cause:** an overly broad pattern (e.g., `.*` matching everything) → **Fix:** tighten the pattern to only match the intended job naming convention.

### Best Practices
- Apply **least privilege**: give each role/user only the permissions their actual job requires.
- Use folder-scoped or pattern-based Item Roles to isolate teams/projects from each other.
- Regularly audit role assignments as team membership changes — treat this like any other access-review process.

### Interview Questions
**Q: What's the difference between a Global Role and an Item Role in the Role-based Strategy plugin?**
A: Global Roles apply system-wide; Item Roles are scoped to specific folders/jobs using a name pattern, letting you isolate access per team or project.

**Q: How would you design RBAC for three independent teams sharing one Jenkins instance?**
A: Use a consistent job-naming convention per team (e.g., `team-x-*`), then create an Item Role per team matching that pattern, and assign only that team's members to it — ensuring no team can see or modify another's jobs.

**What You Should Remember:** RBAC via the Role-based Authorization Strategy plugin lets you define Global Roles (system-wide) and Item Roles (folder/job-scoped) and assign them to users — always following least privilege.

---

## 18. Jenkins Security & Production Hardening

### In Plain English (Beginner Explanation)
Production hardening is like locking every door, installing security cameras, and requiring ID badges throughout the entire restaurant — not just the safe. It's the sum of many smaller security habits (encrypted connections, verified logins, restricted permissions) that together make the whole building genuinely secure, rather than relying on any single lock.

### Authentication & Authorization
- **Authentication**: verifying *who* a user is (login) — Jenkins supports its own user database, LDAP, SSO/SAML, and others via plugins.
- **Authorization**: verifying *what* an authenticated user is allowed to do — configured via strategies like Role-Based Strategy (Section 17) or Matrix-based security.

### CSRF Protection
Jenkins enables **CSRF Protection** (Cross-Site Request Forgery) by default, requiring a valid "crumb" token on state-changing requests — this should never be disabled in production, even though some automation scripts find it inconvenient (the correct fix is to properly fetch/use the crumb, not disable protection entirely).

### Script Approval
Certain Groovy operations in Scripted Pipelines/Shared Libraries are considered "unsafe" and require an admin to explicitly approve the script before it runs, preventing arbitrary code execution by lower-privileged users.
```
Manage Jenkins → Script Approval → review and approve/reject pending scripts
```

### Agent Security
- Agents should connect over secure channels (SSH or encrypted inbound TCP), never unauthenticated plaintext connections.
- Agents shouldn't run with more OS-level privilege than the build actually requires — avoid running agent processes as `root` by default.

### Plugin Security
- Only install plugins from trusted sources (the official Jenkins Update Center).
- Keep plugins updated — older versions can carry known, publicly documented vulnerabilities.
- Review the **Manage Jenkins → Plugins → Security warnings** section periodically, not just when something breaks.

### Network & HTTPS
- Serve the Jenkins UI over HTTPS (via a reverse proxy like Nginx, or an AWS load balancer with a certificate) rather than plain HTTP — especially since login credentials and secrets can otherwise traverse the network unencrypted.
- Restrict inbound network access (security groups/firewalls) to only what's necessary.

### Folder Permissions & Audit Considerations
- Use folders to segment teams/projects, applying RBAC per folder.
- Enable an audit trail plugin if compliance requires tracking who changed what configuration and when.

### Extended Example: A Basic Production Security Checklist Walkthrough
```
1. Manage Jenkins → Security → Authentication: Jenkins' own user database (or LDAP/SSO)
2. Manage Jenkins → Security → Authorization: Role-Based Strategy, not "Anyone can do anything"
3. Manage Jenkins → Security → CSRF Protection: confirmed enabled (default)
4. Manage Jenkins → Plugins → Security warnings: reviewed, none outstanding
5. Reverse proxy / load balancer: HTTPS certificate installed and enforced
6. Security Group: only necessary ports/IPs allowed inbound
7. Agents: connect via SSH keys or secure inbound TCP, not unauthenticated plaintext
```

### Common Mistakes
- Disabling CSRF protection "to make automation easier" — a genuinely risky shortcut that should never be taken.
- Running the Jenkins controller/agents as `root` unnecessarily.
- Leaving Jenkins reachable on the public internet without HTTPS or IP restrictions.
- Ignoring plugin security warnings for months because "nothing's broken yet."

### Best Practices
- HTTPS everywhere, least-privilege everywhere, keep plugins patched, restrict network exposure, and use RBAC + folder-scoping to isolate teams.
- Periodically review the full security checklist above as a recurring habit, not a one-time setup task.

### Interview Questions
**Q: Why should CSRF protection never be disabled in production, even if it's inconvenient for a script?**
A: Disabling it removes a defense against forged state-changing requests; the correct fix for automation inconvenience is properly fetching and using the crumb token, not removing the protection.

**Q: What's the purpose of Script Approval?**
A: It prevents lower-privileged users from running arbitrary, potentially dangerous Groovy code (in Scripted Pipelines or Shared Libraries) without an administrator explicitly reviewing and approving it first.

**What You Should Remember:** Production Jenkins hardening = authentication + authorization (RBAC) + CSRF protection left on + script approval for untrusted code + patched plugins + HTTPS + restricted network access + least-privilege agents.

---

## 19. Global Tools Configuration

### In Plain English (Beginner Explanation)
Global Tools configuration is like a shared equipment closet in the kitchen — instead of every single cook bringing (or forgetting) their own knife, mixer, or oven, Jenkins keeps a stocked, labeled closet so every recipe automatically grabs the exact right, correctly-sized tool it needs, without anyone having to remember to install it manually beforehand.

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
- Jenkins installs them automatically (if configured that way) before the stages run, so `mvn` and `java` commands work without you manually installing anything on the agent beforehand.

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

### Extended Example: Requesting Multiple Tools and Verifying Versions
```groovy
pipeline {
    agent any
    tools {
        jdk 'jdk17'
        maven 'maven3'
        nodejs 'node20'
    }
    stages {
        stage('Verify Toolchain') {
            steps {
                sh 'java -version'
                sh 'mvn -v'
                sh 'node -v'
            }
        }
    }
}
```
Adding a "Verify Toolchain" stage as the very first stage of a pipeline is a useful diagnostic habit — if the wrong tool version is picked up, you find out immediately, rather than several stages later with a confusing, unrelated-looking error.

### Common Mistakes
- Assuming a tool is available on every agent without confirming — leads to "command not found" errors on agents that don't have it installed.
- Using different tool versions across environments/agents, causing "works on this agent but not that one" inconsistencies.
- Not pinning an exact tool version, causing builds to silently pick up a newer (potentially incompatible) version after an agent is rebuilt or updated.

### Debugging/Troubleshooting
- **Symptom:** `mvn: command not found` despite `tools { maven '...' }` being declared → **Cause:** the named tool installation doesn't actually exist under that exact name in Manage Jenkins → Tools → **Fix:** verify the tool name matches exactly (case-sensitive) between the Jenkinsfile and the configured installation.
- **Symptom:** Wrong tool version used → **Cause:** a different, unpinned version already exists on the agent's system `PATH` and is taking priority → **Fix:** always reference tools through the `tools {}` directive rather than assuming a global system install.

### Best Practices
- Pin exact tool versions in the pipeline (`tools { maven 'maven3' }` referencing a specific configured version) rather than relying on whatever happens to already be on the `PATH`.
- Use labeled agents (Section 23) to guarantee jobs land where the required tools genuinely exist.
- Add a "Verify Toolchain" step early in complex pipelines to fail fast on tool misconfiguration.

### Interview Questions
**Q: Why declare tools via the `tools {}` directive instead of assuming they're already on the agent's system `PATH`?**
A: It ensures the pipeline uses a specific, known, Jenkins-managed version consistently, rather than depending on whatever happens to be pre-installed (or not) on any given agent — improving reproducibility across the fleet.

**What You Should Remember:** `Manage Jenkins → Tools` configures named tool installations; the `tools { }` directive in a Jenkinsfile requests them by name, ensuring consistent versions across builds.

---

## 20. Docker and Jenkins

### In Plain English (Beginner Explanation)
Docker is like a fully self-contained meal kit — everything needed to make the dish (ingredients, exact instructions, even the right-sized pan) is bundled into one box, so it cooks exactly the same way no matter which kitchen (server) opens the box. That consistency is Docker's whole value proposition for software.

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
Here, `mvn` doesn't need to be installed on the agent at all — Jenkins spins up a temporary container from the `maven` image, runs the build inside it, then discards the container afterward.

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
- `Checkout` stage — pulls source code, as covered in Part 1, Section 7.
- `Build Application` — compiles the app (e.g., via Maven) before containerizing it.
- `docker build -t ${ECR_REPO}:${IMAGE_TAG} .` — builds the Docker image using the `Dockerfile` in the current directory, tagging it with the build number for traceability.
- `trivy image --exit-code 1 --severity HIGH,CRITICAL ...` — scans the freshly built image for known vulnerabilities; `--exit-code 1` makes the pipeline **fail** if any HIGH/CRITICAL vulnerabilities are found, preventing insecure images from being pushed further down the pipeline.
- `aws ecr get-login-password ... | docker login ...` — authenticates Docker with Amazon ECR using a short-lived token from the AWS CLI (assuming the agent has IAM permissions, ideally via an instance role rather than static keys — see Section 15).
- `docker tag` — re-tags the local image with the full ECR repository URI required for pushing.
- `docker push` — uploads the image to the ECR repository.
- `post { always { docker rmi ... } }` — cleans up the local image copy after the pipeline finishes (success or failure) to avoid filling up agent disk space over time.

### Docker-in-Docker & Docker Socket Considerations
When Jenkins agents themselves run as containers (e.g., in Kubernetes), building Docker images from inside a container requires either:
- **Mounting the host's Docker socket** (`/var/run/docker.sock`) into the agent container — simpler, but gives that container effective root-level access to the host's Docker daemon (a real security consideration worth understanding, not just a technicality).
- **Docker-in-Docker (DinD)** — running a nested, isolated Docker daemon inside the agent container — more isolated, but has its own performance and complexity trade-offs.
- **Rootless/daemonless builders (e.g., Kaniko, Buildah)** — increasingly preferred in Kubernetes-based CI for building images without needing Docker socket access at all.

### Extended Example: Multi-Stage Dockerfile Used by the Pipeline
```dockerfile
# Stage 1: build
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: runtime
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
```
Multi-stage builds keep the final image small and clean — the heavy build toolchain (Maven, full JDK) never ends up in the final shipped image, only the compiled artifact and a lightweight JRE runtime, reducing both image size and its attack surface.

### Common Mistakes
- Not cleaning up built images/containers on agents — disk fills up over time ("Jenkins disk full" is a very common real-world incident).
- Pushing images without a vulnerability scan step, only discovering critical CVEs after they're already sitting in production.
- Mounting the Docker socket into untrusted build containers without understanding the security implications of doing so.
- Using a single-stage Dockerfile that ships the entire build toolchain in the final production image unnecessarily.

### Best Practices
- Tag images meaningfully (build number, git commit SHA, or semantic version) — never rely solely on `latest`.
- Scan images before pushing (Trivy or equivalent) and fail the pipeline on critical vulnerabilities.
- Clean up local images/containers in a `post { always { } }` block.
- Use multi-stage Dockerfiles to keep final images minimal.

### Interview Questions
**Q: Why fail the pipeline with `--exit-code 1` on a Trivy scan instead of just logging the results?**
A: Logging alone doesn't stop a vulnerable image from being pushed and deployed; failing the pipeline enforces the security gate as a hard requirement rather than an easily-ignored warning.

**Q: What's the security concern with mounting the Docker socket into a build container?**
A: It effectively grants that container root-level access to the host's Docker daemon, meaning a compromised or malicious build step could potentially control or damage the underlying host, not just its own isolated container.

**Q: Why use a multi-stage Dockerfile?**
A: It keeps the final production image small and secure by excluding the build toolchain (compilers, build caches) — only the compiled artifact and a minimal runtime are shipped.

**What You Should Remember:** Docker in Jenkins = build → tag → scan → push, ideally as one linear, fail-fast pipeline. Docker agents let you avoid installing every tool directly on Jenkins agents; multi-stage builds keep final images lean.

---

## 21. Kubernetes and Jenkins

> This section extends beyond a typical beginner course with production-relevant Kubernetes + Jenkins knowledge, marked as **Additional Production Knowledge**.

### In Plain English (Beginner Explanation)
Kubernetes is like a massive, automated restaurant chain manager: it decides which of hundreds of kitchen locations should cook which meal kit right now, restarts a kitchen if it catches fire, and can spin up a brand-new temporary kitchen just for one big order, then tear it back down the moment it's done.

### Simple Definition
Kubernetes (K8s) is a system for running and managing containerized applications at scale. Jenkins integrates with Kubernetes both as a **deployment target** (deploying your app to a cluster) and as a **dynamic build infrastructure** (running Jenkins agents themselves as Kubernetes pods).

### Kubernetes Plugin: Dynamic/Ephemeral Agents
Instead of maintaining a fixed pool of static Jenkins agents, the **Kubernetes plugin** lets Jenkins spin up a brand-new agent **pod** on demand for each build, then delete it when the build finishes.

**Why it matters:** No idle agents wasting resources/cost, every build gets a genuinely clean environment, and you can scale to as many concurrent builds as your cluster capacity allows, without pre-provisioning anything.

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
- `container('maven') { }` / `container('kubectl') { }` — the pod has multiple containers (defined in the pod template); this directive specifies *which container* the following steps should execute inside.
- `serviceAccountName: jenkins-agent` — the Kubernetes Service Account the pod runs as, which via **RBAC** determines what the pod is allowed to do inside the cluster (e.g., permission to deploy to a specific namespace only).

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
- `kubectl rollout status ... --timeout=120s` — waits for the rollout to actually succeed (new pods healthy) and fails the pipeline if it doesn't complete within 2 minutes — this is precisely what prevents "Jenkins says success but the app isn't actually working."

### Rollback
```bash
kubectl rollout undo deployment/myapp -n production
```
Reverts to the previous working version if a deployment causes problems — a critical safety net that should be documented and rehearsed before you actually need it under pressure.

### RBAC and Service Accounts for Jenkins-in-Kubernetes
The Jenkins agent's Kubernetes Service Account should be granted only the specific permissions it needs (e.g., "deploy to this namespace") via a Kubernetes `Role`/`RoleBinding` — not cluster-admin — following the same least-privilege principle as Jenkins's own RBAC (Section 17).

### Extended Example: A Role and RoleBinding Scoping Jenkins to One Namespace
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: production
  name: jenkins-deployer
rules:
  - apiGroups: ["apps"]
    resources: ["deployments"]
    verbs: ["get", "list", "update", "patch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: jenkins-deployer-binding
  namespace: production
subjects:
  - kind: ServiceAccount
    name: jenkins-agent
    namespace: jenkins
roleRef:
  kind: Role
  name: jenkins-deployer
  apiGroup: rbac.authorization.k8s.io
```
This grants the `jenkins-agent` service account permission to view and update Deployments *only* within the `production` namespace — nothing more, nothing cluster-wide.

### Troubleshooting Pods
| Symptom | Likely Cause | What to Check |
|---|---|---|
| Pod stuck `Pending` | Insufficient cluster resources, or unschedulable (bad node selector/taint) | `kubectl describe pod <name>` for scheduling events |
| Pod `CrashLoopBackOff` | Application crashing on startup | `kubectl logs <pod> --previous` |
| `ImagePullBackOff` | Wrong image tag, or missing registry credentials | Check image name/tag and imagePullSecrets |
| Deployment "succeeds" but app broken | No health checks / readiness probes configured | Add liveness/readiness probes; check `kubectl rollout status` actually passed |

### Common Mistakes
- Not setting resource requests/limits on agent pods — one build can starve others of cluster resources.
- Granting the Jenkins service account cluster-admin "to make things easier" — a major security risk that violates least privilege badly.
- Not waiting on `kubectl rollout status` — a pipeline can report SUCCESS even though the new pods are crash-looping in the background.
- Forgetting that a rollback command exists at all, and scrambling to figure it out for the first time during an actual incident.

### Best Practices
- Use dynamic/ephemeral pod agents for a clean, scalable build environment.
- Always wait on rollout status with a timeout, and have a clear, tested rollback step/procedure documented in advance.
- Scope RBAC tightly per namespace/team using Role/RoleBinding, never cluster-admin for CI service accounts.

### Interview Questions
**Q: How does the Kubernetes plugin change Jenkins's build infrastructure model?**
A: It creates ephemeral agent pods on demand per build (via pod templates), rather than maintaining a fixed pool of always-on static agents — eliminating idle cost and guaranteeing a clean environment per build.

**Q: Why is it important to check `kubectl rollout status` after a deployment, rather than just running `kubectl apply`?**
A: `kubectl apply`/`set image` can succeed at the API level immediately, while the new pods might still fail to actually become healthy afterward; `rollout status` waits for genuine health confirmation, catching failures the apply command alone would miss.

**Q: How would you scope a Jenkins service account's Kubernetes permissions safely?**
A: Create a namespace-scoped `Role` granting only the specific verbs/resources actually needed (e.g., updating Deployments in one namespace), bound to the Jenkins service account via a `RoleBinding` — avoiding cluster-admin entirely.

**What You Should Remember:** Kubernetes + Jenkins = dynamic agent pods (via pod templates) for builds, plus `kubectl`/Helm-based deployment stages for releases. Always confirm rollout status — don't assume deployment succeeded just because the pipeline didn't error.

---

## 22. Terraform and Jenkins

> Additional Production Knowledge extending beyond a typical beginner course.

### In Plain English (Beginner Explanation)
Terraform is like an architect's blueprint for the restaurant building itself (the servers, networks, and infrastructure) rather than the food. `plan` is like showing the blueprint to the building owner before construction actually starts, so nothing gets built by surprise, and nobody is shocked by what shows up.

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
- `parameters { choice(...) }` — lets the user pick which environment (dev/staging/prod) this run targets.
- `TF_WORKSPACE = "${params.ENVIRONMENT}"` — maps the chosen environment to a Terraform workspace, keeping each environment's state isolated.
- `terraform fmt -check` — fails the build if code isn't properly formatted, enforcing consistency without modifying files in CI.
- `terraform init -backend=false` + `terraform validate` — a lightweight syntax/config check that doesn't need real backend/state access, useful as an early fast-fail gate.
- `terraform plan -out=tfplan` — computes the exact planned changes and saves them to a file, so the **exact same plan** that was reviewed is what gets applied later (rather than re-planning right before apply, which could pick up unrelated drift in the meantime).
- `input message: "..."` — pauses for a human to review the plan output and explicitly approve before anything real happens — critical for production infrastructure changes.
- `terraform apply -auto-approve tfplan` — applies the exact, previously-reviewed plan file without prompting again (since a human already approved via the `input` step).

### Remote State & State Locking
- **Remote state**: Terraform's knowledge of current infrastructure ("state") is stored remotely (e.g., an S3 bucket) instead of only on one person's/agent's local disk — essential so multiple pipeline runs/team members see a consistent view of what already exists.
- **State locking**: prevents two `apply` operations from running simultaneously and corrupting state (commonly implemented via a DynamoDB table alongside an S3 backend).

### Extended Example: A Remote State Backend Configuration
```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "myapp/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```
- `bucket` — where state files live, durably, in S3.
- `key` — uses the current Terraform workspace name in the path, automatically separating state per environment.
- `dynamodb_table` — provides the locking mechanism, preventing two simultaneous `apply` runs from corrupting the same state file.
- `encrypt = true` — encrypts the state file at rest, since state can contain sensitive values (like resource IDs or even secrets, depending on what's provisioned).

### Environment Separation
Each environment (dev/staging/prod) should use a separate Terraform workspace or entirely separate state file/backend path, so an error in one environment's plan can never accidentally affect another.

### Credentials & Security
- Terraform needs AWS credentials to plan/apply — same guidance as Section 15: prefer an IAM role attached to the Jenkins agent over static keys.
- Apply approval gates are mandatory for production — never auto-apply against `prod` without a human review step, no matter how routine the change seems.

### Common Mistakes
- Running `terraform apply` directly without ever reviewing a `plan` — risks unexpected, potentially destructive changes going live unreviewed.
- Not locking state, leading to corrupted/conflicting state if two runs overlap.
- Sharing one state file across all environments instead of separating them, letting a dev mistake potentially affect production infrastructure.
- Re-running `terraform plan` right before `apply` instead of applying a previously saved plan file — introduces a window where drift could sneak in unreviewed.

### Debugging/Troubleshooting
- **Symptom:** `Error acquiring the state lock` → **Cause:** another run is already applying, or a previous run crashed while holding the lock → **Fix:** wait for the other run to finish, or carefully investigate/clear a genuinely stale lock (`terraform force-unlock`, used cautiously).
- **Symptom:** `terraform plan` shows unexpected changes to resources nobody touched → **Cause:** configuration drift (someone made a manual change outside Terraform) → **Fix:** investigate the drift's source and decide whether to import it into Terraform's management or revert the manual change.

### Best Practices
- Always `plan` → human review → `apply`, using a saved plan file so what's reviewed is exactly what's applied.
- Use remote state with locking (S3 + DynamoDB, or an equivalent) in any team/production setting.
- Separate state per environment using workspaces or distinct backend keys.

### Interview Questions
**Q: Why apply a saved plan file (`terraform apply tfplan`) instead of just running `terraform apply` directly?**
A: Applying a saved plan guarantees the exact changes a human reviewed and approved are what gets applied, with no risk of the plan silently changing (due to drift or a race condition) between review and apply.

**Q: What problem does state locking solve?**
A: It prevents two concurrent `apply` operations from modifying the same state file simultaneously, which could otherwise corrupt Terraform's record of real infrastructure.

**Q: Why is IAM-role-based authentication preferred over static AWS keys for Terraform running in Jenkins?**
A: It avoids storing a long-lived secret that could leak, since the role provides short-lived, automatically-rotating credentials scoped to the Jenkins agent's instance.

**What You Should Remember:** Terraform + Jenkins = fmt → validate → plan (saved to a file) → manual approval → apply that exact plan. Remote state + locking + environment separation are non-negotiable for team/production use.

---

## 23. Jenkins Master/Agent Architecture

### In Plain English (Beginner Explanation)
This is the deeper version of the head-chef-and-line-cooks idea from Part 1 — specifically, how you actually connect a brand-new line cook (agent) to the kitchen and give them their own station.

### Why Use Agents/Worker Nodes?
- **Isolation**: build workloads don't compete with or destabilize the controller's UI/scheduling responsibilities.
- **Scalability**: add more agents as build volume grows, rather than one increasingly overloaded controller trying to do everything.
- **Specialization**: different agents can have different tools/OS/hardware (e.g., a GPU agent for ML builds, a Windows agent for .NET builds).
- **Security**: build steps (which may run untrusted code from a repository) execute on agents, not on the controller that holds all credentials/configuration for the entire instance.

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
| **Kubernetes plugin (dynamic)** | Ephemeral pod-based agents, created/destroyed per build — see Section 21. |
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
`agent { label 'linux docker' }` tells Jenkins to only run this pipeline on an agent that has **both** labels — ensuring it lands somewhere with the right OS and tools already available.

### Extended Walkthrough: Diagnosing a Newly Added Agent That Won't Connect
```
1. Manage Jenkins → Nodes → click the new agent's name
2. Check the "Log" tab for connection errors
3. Common findings:
   - "Connection refused" → firewall blocking the SSH port from the controller to the agent
   - "Authentication failed" → wrong SSH credential, or the public key isn't authorized on the agent
   - "Host key verification failed" → the Host Key Verification Strategy rejected the agent's key (expected on first connect if set to strict verify without pre-approval)
4. Fix the specific issue, then click "Launch agent" again to retry
```

### Common Mistakes
- Not assigning meaningful labels, so jobs land on random agents that may lack required tools.
- Using SSH launch with weak host key verification in a production environment.
- Overloading a single agent with too many executors relative to its actual CPU/memory capacity.

### Best Practices
- Label agents by capability (`docker`, `terraform`, `high-memory`), not just by hostname.
- Match executor counts to actual agent resources.
- Prefer dynamic (Kubernetes/Docker) agents in cloud-native setups for elasticity and cost efficiency.

### Interview Questions
**Q: What's the difference between SSH-launched and inbound (JNLP) agents?**
A: SSH launch has the controller initiate the connection outward to the agent; inbound/JNLP has the agent initiate the connection to the controller instead — useful when the agent sits behind a firewall/NAT that the controller can't reach directly.

**Q: How would you ensure a pipeline only runs on an agent with both Docker and Terraform installed?**
A: Assign both labels (e.g., `docker` and `terraform`) to that agent, then use `agent { label 'docker && terraform' }` (or `'docker terraform'`, depending on syntax) in the pipeline.

**What You Should Remember:** Agents can be connected via SSH (static, simple), inbound/JNLP (agent behind firewall), or dynamically via Kubernetes/Docker plugins (ephemeral, scalable). Labels are how pipelines request the right kind of agent.

---

## 24. Configuring and Scaling Agents

### In Plain English (Beginner Explanation)
Static agents are like permanent, full-time cooks you always pay whether there's a rush or not. Dynamic agents are like calling in temp staff only during a rush, and letting them go the moment the rush ends — nobody sits around idle, but you need a system in place to call and manage them properly.

### Static vs Dynamic Agents
- **Static agents**: always-on machines registered with Jenkins ahead of time. Simple to reason about, but you pay for idle capacity and must maintain them (patching, tool updates) manually over time.
- **Dynamic/ephemeral agents** (Docker or Kubernetes-based): created on demand for each build and destroyed afterward. No idle cost, always a clean environment, but adds infrastructure complexity (a cluster/orchestration platform is needed).

### Distributed Builds & Workload Separation
In a mature setup, different categories of work run on purpose-built agent pools:
- Build/compile jobs → agents with language toolchains (Maven, Node, etc.)
- Docker image builds → agents with Docker installed
- Infrastructure jobs → agents with Terraform/AWS CLI
- Heavy test suites → higher-CPU/memory agents

This avoids one generic agent pool trying to be everything to everyone, which leads to bloated images, tool version conflicts, and unpredictable performance across unrelated jobs.

### Controller Performance: Avoiding Builds on the Controller
```
Manage Jenkins → Nodes → (built-in node / controller) → Configure → set "# of executors" to 0
```
Setting the controller's executor count to `0` forces **all** builds onto agents, protecting the controller's responsiveness — a standard production practice that should be applied from day one in any real deployment.

### Agent Offline Troubleshooting
| Symptom | Likely Cause | Fix |
|---|---|---|
| Agent shows "offline" in Manage Jenkins → Nodes | Network/SSH connectivity lost, or agent process crashed | Check agent's system logs; re-launch via "Launch agent" button; verify SSH credentials still valid |
| Build stuck in queue, "waiting for next available executor" | No agent matches required label, or all executors busy | Check labels match; check if more agents/executors are needed |
| "No executor available" | Every online executor across matching agents is currently busy | Scale up agent count, or increase executors on existing agents (if resources allow) |

### Extended Example: Sizing Executors Realistically
A `high-memory` labeled agent with 16 GB RAM running memory-heavy integration tests that each use ~3 GB should probably run **4–5 executors at most** (leaving headroom for the OS and Jenkins's own agent process), not 16, even though 16 might seem like a "round number" — matching executor count to actual, measured resource usage (not theoretical CPU core count alone) avoids builds silently competing for memory and slowing each other down or crashing.

### Common Mistakes
- Leaving executors enabled on the controller "just in case," letting heavy builds accidentally land there over time.
- Not monitoring agent health, discovering an agent has been offline for days only when someone notices builds queuing unexpectedly.
- Setting executor counts based on CPU core count alone, ignoring memory constraints that are often the real bottleneck.

### Best Practices
- Set controller executors to 0 in production, without exception.
- Monitor agent online/offline status (via Jenkins's own UI, or external monitoring hooked into Jenkins's API/metrics).
- Prefer dynamic agents for elastic, cost-efficient scaling in cloud environments.
- Size executors based on real, measured resource usage per build, not just core count.

### Interview Questions
**Q: Why is setting the controller's executor count to 0 considered a production best practice?**
A: It guarantees all build workloads run on dedicated agents, protecting the controller's own responsiveness and reducing the security exposure of running potentially untrusted build code with controller-level access.

**Q: How would you decide the right number of executors for a given agent?**
A: Base it on the agent's actual measured resource usage per build (CPU and especially memory), not just its core count — oversubscribing executors relative to real resource capacity causes builds to compete and slow each other down or fail.

**What You Should Remember:** Scaling Jenkins = adding/right-sizing agents (static or dynamic), keeping the controller executor-free, and using labels to route work to appropriately equipped agents.

---

## 25. Complete CI/CD Pipeline Design

### In Plain English (Beginner Explanation)
This section is the full dinner-service walkthrough: an order comes in, ingredients arrive, food is cooked, tasted for quality, checked for safety, plated, delivered to the table — and someone double-checks the customer is actually happy, not just that the plate physically left the kitchen.

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
- **Checkout** — gets the exact code version to build.
- **Build** — compiles/packages the application.
- **Unit Tests** — catches functional regressions early, before anything is containerized or deployed anywhere.
- **SonarQube** — catches code quality/maintainability/security issues that tests alone might miss entirely.
- **Docker Build** — packages the app into a portable, consistent unit.
- **Trivy Scan** — catches known vulnerabilities in the image before it ever reaches a registry or production environment.
- **Push to ECR** — makes the image available for deployment.
- **Deploy to EKS** — actually rolls the new version out, and `rollout status` confirms it's genuinely healthy — not just "kubectl didn't return an error."
- **Smoke Test** — a final, real-world check that the live application actually responds correctly after deployment.
- **Notification** — ensures humans know the outcome without needing to babysit the Jenkins UI continuously.

### Extended Discussion: What "Fail Fast" Really Means Here
Notice the stage order: cheap, fast checks (unit tests) run *before* expensive, slow ones (building a Docker image, deploying to a real cluster). This is deliberate — if unit tests fail, the pipeline stops in seconds without wasting time building an image or touching a real Kubernetes cluster at all. Reordering these stages (e.g., deploying before testing) would waste significant time and resources on code that was already known to be broken.

### Extended Example: Adding a Manual Approval Gate Before Production
```groovy
stage('Approve Production Deploy') {
    when { branch 'main' }
    steps {
        timeout(time: 1, unit: 'HOURS') {
            input message: "Deploy build ${IMAGE_TAG} to production?", ok: 'Deploy'
        }
    }
}
```
Inserted just before the "Deploy to EKS" stage, this adds a human checkpoint specifically for production deployments, while still allowing feature-branch builds to run fully automated up through the security scan.

### Common Mistakes
- Skipping the smoke test — a deployment can "succeed" at the Kubernetes level while the application itself is broken (e.g., wrong config, missing environment variable).
- Running security/quality scans only occasionally instead of on every single pipeline run.
- Not setting an overall `timeout`, risking a stuck pipeline holding an executor indefinitely.
- Placing slow/expensive stages before cheap/fast ones, wasting time and resources on code already known to be broken.

### Best Practices
- Fail fast: put cheaper/faster checks (unit tests) before expensive/slow ones (deployment) so problems are caught earlier and cheaper.
- Treat every gate (tests, quality, security) as blocking by default — bypassing them should require a deliberate, visible decision, not silent tolerance.
- Add a manual approval gate before production deployments specifically, even if lower environments are fully automated.

### Interview Questions
**Q: Why does stage ordering matter in a CI/CD pipeline?**
A: Placing cheap, fast checks (like unit tests) before expensive, slow ones (like deployment) means failures are caught earlier and cheaper, avoiding wasted time/resources on code already known to be broken — this is the "fail fast" principle.

**Q: What would you add to prevent a scenario where Jenkins reports success but the application is actually broken?**
A: A genuine smoke test stage after deployment (hitting a real health endpoint), combined with verifying `kubectl rollout status` actually passed with an adequate timeout — not just assuming success from the deploy command alone.

**What You Should Remember:** A production CI/CD pipeline chains together build → test → quality → security → package → deploy → verify → notify, with each stage acting as a gate that can stop bad code before it reaches users — ordered from cheapest/fastest checks to most expensive/slowest ones.

---

## 26. Jenkins Shared Libraries

### In Plain English (Beginner Explanation)
A Shared Library is like a master recipe binder kept in a central office that every restaurant location borrows from, instead of every location's chef re-inventing (and possibly messing up) their own version of the same basic sauce recipe independently.

### Simple Definition
A **Shared Library** is a reusable collection of Pipeline code (custom steps, functions, classes) stored in its own Git repository, which multiple Jenkinsfiles across different projects can import and reuse — instead of copy-pasting the same logic everywhere.

### Why Shared Libraries Are Needed
Imagine 30 different application repositories, each with a nearly identical Jenkinsfile doing "checkout → build → Docker → scan → push → deploy." Without Shared Libraries:
- Any improvement (e.g., adding a new security check) means editing all 30 Jenkinsfiles individually, one by one.
- Bugs get fixed in some repos but not others, causing quiet inconsistency across the organization.

With a Shared Library, that common logic lives in **one place**, and each Jenkinsfile just calls it — improvements/fixes propagate everywhere at once, with a single change.

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

### Extended Example: A `src/` Class With Reusable Logic
```groovy
// src/org/example/DockerHelper.groovy
package org.example

class DockerHelper implements Serializable {
    def script
    DockerHelper(script) { this.script = script }

    def buildTagPush(String repo, String tag) {
        script.sh "docker build -t ${repo}:${tag} ."
        script.sh "docker tag ${repo}:${tag} ${repo}:latest"
        script.sh "docker push ${repo}:${tag}"
        script.sh "docker push ${repo}:latest"
    }
}
```
Used from a Jenkinsfile:
```groovy
@Library('my-shared-library@main') import org.example.DockerHelper

pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script {
                    def docker = new DockerHelper(this)
                    docker.buildTagPush('myapp', "${BUILD_NUMBER}")
                }
            }
        }
    }
}
```
- `implements Serializable` — required so Jenkins's Pipeline engine (which can pause/resume pipelines, even across controller restarts) can properly serialize this object's state.
- `def script` / `DockerHelper(script)` — passing in the pipeline's own script context lets the class call pipeline steps like `sh` from inside a plain Groovy class.
- This pattern (`src/` classes) suits more complex, stateful, or heavily-parameterized logic better than a simple `vars/` step.

### Library Versioning
The `@main` (or `@v1.2.0`, `@some-branch`) part of `@Library('name@version')` lets different pipelines pin to different versions of the shared logic — useful for gradually rolling out changes to the library without breaking every consuming pipeline simultaneously.

### Trusted vs Untrusted Libraries
- **Trusted (Global) Libraries**: configured by an admin at the Jenkins system level; code runs with fewer Groovy sandbox restrictions since it's vetted centrally by a trusted administrator.
- **Untrusted (Folder-level) Libraries**: configured per-folder, can be added by teams without full admin access, but code runs inside the Groovy security sandbox with more restrictions — a safer default for less-trusted contributors.

### Testing Shared Libraries
Shared Library code (especially `src/` classes) can be unit-tested like regular Groovy/Java code, ideally in its own dedicated CI pipeline, before being consumed by other project pipelines — catching bugs before they affect every single consumer at once.

### Common Mistakes
- Putting complex, untested logic directly in `vars/` without ever testing it standalone first.
- Not versioning consumers (`@main` for everyone) — a breaking change to the library instantly breaks every single project using it at the exact same moment.
- Overloading Shared Libraries with business logic that's too project-specific — defeats the purpose of a *shared*, general-purpose library meant to serve many different projects.
- Forgetting `implements Serializable` on `src/` classes, causing confusing pipeline serialization errors.

### Best Practices
- Version-pin consumers to specific tags/releases for stability; only advance the pin deliberately after testing the new version.
- Keep Shared Library code generic and well-documented; project-specific logic stays in the project's own Jenkinsfile.
- Test library code independently before rolling it out broadly across many consuming pipelines.

### Interview Questions
**Q: What's the difference between `vars/` and `src/` in a Shared Library?**
A: `vars/` provides simple, directly-callable global steps (one Groovy file per step, using a `call` method); `src/` provides full Groovy classes for more complex, object-oriented, or stateful reusable logic.

**Q: Why should Shared Library consumers pin to a specific version rather than always tracking `@main`?**
A: Pinning prevents a breaking change pushed to the library's main branch from instantly affecting every consuming pipeline simultaneously; teams can upgrade deliberately, on their own schedule, after testing.

**Q: What's the difference between Trusted and Untrusted Shared Libraries?**
A: Trusted libraries are configured globally by an admin and run with fewer Groovy sandbox restrictions; Untrusted (folder-level) libraries can be added by teams without full admin rights but run inside the Groovy security sandbox with tighter restrictions.

**What You Should Remember:** Shared Libraries centralize reusable Pipeline logic (`vars/` for callable steps, `src/` for classes, `resources/` for static files), imported via `@Library('name@version')` — the standard way to keep dozens of Jenkinsfiles DRY and consistent.

---

## 27. Remote Build Triggering

### In Plain English (Beginner Explanation)
Remote build triggering is like a takeout app that lets someone press "start cooking" from their phone, using a secret order code, instead of physically walking into the kitchen and asking a cook directly.

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
This allows integration with systems outside Git's webhook model — e.g., another internal tool, a scheduled external script, or a different CI system that needs to hand off a task to Jenkins programmatically.

### Extended Example: Triggering With Parameters
```
curl "https://jenkins.example.com/job/deploy-app/buildWithParameters?token=THE_SECRET_TOKEN&ENVIRONMENT=QA&APP_VERSION=2.3.1"
```
Note the different endpoint (`buildWithParameters` instead of `build`) — required specifically when triggering a parameterized job remotely, with each parameter passed as a query string value.

### Security Considerations
- The token should be treated as a secret (stored securely, not committed to a public repo or documentation).
- Combine with network-level restrictions (only allow the calling system's IP) where possible, as defense in depth.
- Prefer this only when webhook-based, event-driven triggers genuinely don't fit the use case (Part 1, Section 8).

### Common Mistakes
- Using an easily-guessable token.
- Exposing the trigger URL publicly (e.g., in documentation or a public repository) without realizing anyone with the token can trigger builds.
- Using the plain `build` endpoint for a parameterized job (which may silently ignore parameters or fail) instead of `buildWithParameters`.

### Best Practices
- Treat remote-trigger tokens exactly like any other credential — rotate them periodically, never commit them to source control.
- Restrict which systems/IPs can call the trigger URL wherever network-level controls are feasible.

### Interview Questions
**Q: How would you trigger a parameterized Jenkins job from an external script?**
A: Call the `buildWithParameters` endpoint (not the plain `build` endpoint) with the authentication token and each parameter as a query string value.

**What You Should Remember:** Remote triggering uses a secret token in a URL to let external systems start Jenkins builds programmatically — treat the token like any other credential, and use `buildWithParameters` for parameterized jobs.

---

*End of Part 2 — Production Engineering. Continue to Part 3: Operations, Troubleshooting, Interview Prep & Reference.*
