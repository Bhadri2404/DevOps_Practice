# Jenkins / CI/CD – 50 Advanced Questions and Answers

## Beginner → Intermediate

### Q1. What is Jenkins and why is it preferred in regulated enterprises?

**Answer:**  
Jenkins is a self-hosted automation server used to implement CI/CD by running automated pipelines for build, test, packaging, and deployment whenever code or configuration changes. In regulated enterprises (like banks), Jenkins is preferred because it can run entirely inside controlled networks, integrate with legacy/on-prem systems, provide granular RBAC, and keep a full audit trail of builds and deployments.[web:42][web:47]

**Real-time Production Scenario:**  
SocGen hosts Jenkins inside its secure network. All CI/CD pipelines for risk, trading, and reporting services run on Jenkins, using internal Git, artifact repositories, and ticketing systems. Releases to production require approvals and are fully traceable.

**Common Mistakes:**

- Treating Jenkins as just a “build server”, not modeling full release workflows.
- Running all builds on the controller node (resource contention, instability).
- No folder-based separation for teams; everything mixed in “root”.

**Debugging Tips:**

- For overall slowness: check controller CPU/memory, build queue length, agent utilization.
- For job instability: check agent logs, workspace disk usage, SCM connectivity.
- For plugin-related issues: cross-check plugin versions with Jenkins LTS compatibility matrix.

**Follow-up Questions:**

- How would you migrate from freestyle jobs to Pipeline-as-Code?
- How do you design Jenkins for multi-team, multi-project environments?

---

### Q2. Explain CI vs CD and how Jenkins implements both.

**Answer:**  

- **CI (Continuous Integration):** Every code change is merged frequently into a shared branch and automatically built and tested. Jenkins achieves this through jobs triggered by SCM webhooks (Git push/PR), running automated builds and tests.
- **CD (Continuous Delivery/Deployment):** Automates packaging and release to environments (dev, QA, staging, prod) with approvals and checks. Jenkins implements this via multi-stage pipelines that include packaging, deployment, and post-deploy validation.[web:45]

**Real-time Scenario:**  
For a FastAPI + Pandas service, Jenkins runs CI on each PR (unit tests + lint). On merge to `develop`, it builds and publishes a Docker image and deploys to DEV. On merge/tag for release, it triggers gated deployment to UAT and PROD.

**Common Mistakes:**

- Equating CD with “always auto-deploy to prod” (in banks, CD often includes manual approval).
- Having one giant job that mixes CI and CD logic, hard to maintain.

**Debugging Tips:**

- If CI stages pass but CD fails, separate logs by stage, and verify environment-specific configuration.
- Ensure environment variables and kubeconfigs/credentials differ correctly across environments.

**Follow-up Questions:**

- How do you implement promotion of the same artifact across environments?
- Where should you enforce approvals – Jenkins, Jira/ServiceNow, or both?

---

### Q3. What is a Jenkinsfile, and what are the key sections of a Declarative pipeline?

**Answer:**  
A Jenkinsfile is a text file stored in the repo that defines the pipeline-as-code. In Declarative syntax, typical top-level sections are:

- `pipeline {}` – root.
- `agent {}` – where the pipeline runs.
- `environment {}` – environment variables.
- `options {}` – pipeline options (timeouts, timestamps, etc.).
- `stages {}` – sequence of `stage {}` blocks with `steps`.
- `post {}` – actions after success/failure/always.

**Code Example (simplified):**

```groovy
pipeline {
  agent { label 'python-docker' }
  options {
    timeout(time: 20, unit: 'MINUTES')
    timestamps()
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Test') {
      steps {
        sh '''
        python -m venv venv
        . venv/bin/activate
        pip install -r requirements.txt
        pytest
        '''
      }
    }
  }
  post {
    always {
      junit 'reports/**/*.xml'
    }
  }
}
```

**Common Mistakes:**

- Putting long shell scripts inline instead of separate scripts.
- Not defining `options { timeout }`, causing hung builds.

**Debugging Tips:**

- Use Jenkins “Replay” to quickly test changes on a failed run (non-prod).
- Validate the Jenkinsfile syntax in the UI or with a linter plugin.

**Follow-up Questions:**

- When would you choose Scripted over Declarative?
- How would you split a large Jenkinsfile into reusable pieces?

---

### Q4. Declarative vs Scripted pipeline – when to use which?

**Answer:**  

- **Declarative:** Opinionated, more structured; ideal for most team pipelines. Enforces best practices and is easier to read/maintain.
- **Scripted:** Pure Groovy; very flexible for dynamic logic, but easier to produce complex, fragile code.[web:42]

**Usage in this role:**

- Use Declarative + Shared Libraries for standard patterns (build, test, scan, deploy).
- Use Scripted or mixed when you need advanced dynamic constructs (e.g., dynamic stages based on metadata, heavy loops).

**Common Mistakes:**

- Writing all pipelines as long Scripted Groovy scripts with no documentation.
- Mixing declarative and scripted in confusing ways.

**Debugging Tips:**

- If a Scripted block misbehaves, log variable values and branch decisions (`println`).
- Start by re-implementing complex logic in small, testable functions in a Shared Library.

**Follow-up Questions:**

- How do you unit test pipeline logic?
- Give an example where a Declarative pipeline was limiting and you needed Scripted.

---

### Q5. What are Jenkins Shared Libraries, and how would you structure them in a data/ML-heavy environment?

**Answer:**  
Shared Libraries centralize reusable pipeline logic (Groovy code) in a separate repo. In a data/ML environment:

- One library for **core DevOps**: Git checkout, build, test, Docker image, Helm deploy, Terraform apply.
- Another library for **data platform tasks**: run Airflow backfills, trigger MLflow model registration, run PySpark jobs on Cloudera.

**Structure Example:**

- `vars/` – simple steps (e.g., `pythonBuild`, `dockerBuildPush`, `deployToK8s`, `terraformPlanApply`).
- `src/org/sg/devops/` – complex classes.

**Scenario:**  
All FastAPI + ML microservices call `sgPythonMicroservicePipeline()` from the library, which wraps standardized stages for building, testing, scanning, and deploying.

**Common Mistakes:**

- No versioning; library is always at `master`, causing breaking changes for everyone.
- Tightly coupling library functions to specific projects.

**Debugging Tips:**

- Pin libraries with `@version` in Jenkins:
  - `@Library('sg-devops-lib@1.5.0') _`
- When debugging, temporarily switch one pipeline to use a feature branch of the library.

**Follow-up Questions:**

- How do you migrate pipelines gradually to a new library version?
- How do you design library APIs so they remain backward compatible?

---

### Q6. How do you design Jenkins agents for scalability and security?

**Answer:**  

- Use **ephemeral Kubernetes-based agents** for most builds via the Kubernetes plugin.
- Use small number of **static agents** for legacy tools or special OSes.
- Define pod templates with minimal required tools (Python, kubectl, helm, terraform).
- Use labels to control where jobs run: `label 'python-k8s'`, `label 'terraform'`, etc.[web:46]

**Security:**

- Agents should not hold long-lived credentials; use short‑lived tokens and credentials binding.
- Do not mount sensitive host paths into agent pods unless necessary.
- Restrict which teams can use which labels.

**Common Mistakes:**

- Single “mega-agent” with everything; heavy images → slow scheduling.
- Overloaded agents: too many executors per node.

**Debugging Tips:**

- Agent pod fails to start: `kubectl describe pod jenkins-agent-…` for events (image pull errors, RBAC issues).
- Agent offline: inspect agent logs for connectivity problems.

**Follow-up Questions:**

- How would you design agent images for Python-heavy workloads?
- How do you manage Jenkins agent upgrades with minimal downtime?

---

### Q7. Explain how you integrate Docker into Jenkins pipelines for this role.

**Answer:**  

Typical patterns:

1. **Build and push images:**

```groovy
stage('Build & Push Image') {
  agent { label 'docker' }
  steps {
    script {
      def tag = "${env.BUILD_NUMBER}-${env.GIT_COMMIT.take(7)}"
      sh """
        docker build -t registry/fastapi-service:${tag} .
        docker push registry/fastapi-service:${tag}
      """
      env.IMAGE_TAG = tag
    }
  }
}
```

2. **Run build steps inside Docker containers** using `docker` or `docker.inside` from the Docker plugin to avoid “snowflake” agents.

**Common Mistakes:**

- Building on the controller instead of dedicated Docker agents.
- Not tagging images immutably (only using `latest`).

**Debugging Tips:**

- If build fails: run `docker build` locally with same context to reproduce.
- If push fails: check registry credentials, network, and file size limits.

**Follow-up Questions:**

- How do you integrate image scanning into the Jenkins pipeline?
- How would you handle multi-architecture images if required?

---

### Q8. How do you integrate Jenkins pipelines with Kubernetes deployments?

**Answer:**  

Common approach:

- Use `kubectl` or `helm` within the pipeline, with kubeconfig or service-account token available.
- Pipeline stages:
  - Build & push Docker image.
  - Update Helm values with new image tag.
  - `helm upgrade --install` or `kubectl apply -f` manifests.
  - `kubectl rollout status` to verify.

**Code Example (Helm):**

```groovy
stage('Deploy to Staging') {
  agent { label 'k8s-admin' }
  steps {
    sh """
      helm upgrade --install fastapi-service charts/fastapi-service \\
        --namespace staging \\
        --set image.tag=${env.IMAGE_TAG}
      kubectl rollout status deployment/fastapi-service -n staging
    """
  }
}
```

**Common Mistakes:**

- Using static YAML with hardcoded image tag, forgetting to update.
- No rollback strategy defined if deployment fails.

**Debugging Tips:**

- Logs: Check Jenkins logs, then `kubectl describe` and `kubectl logs`.
- If rollout stuck: inspect events, readiness probes, and resource requests/limits.

**Follow-up Questions:**

- How would you implement blue‑green or canary via Jenkins+Helm?
- How do you manage Kubernetes credentials securely in Jenkins?

---

### Q9. How would you connect Jenkins with Terraform for cloud infrastructure changes?

**Answer:**  

Standard pattern:

- `terraform fmt -check` and `terraform validate` in early stages.
- `terraform plan -out=tfplan` stage.
- Store the plan as an artifact.
- Require manual approval (or ticket reference) before `terraform apply tfplan`.
- Use remote backend (S3 + DynamoDB lock / Azure Storage) and workspace per environment.[web:28][web:46]

**Example Stage:**

```groovy
stage('Terraform Plan') {
  agent { label 'terraform' }
  steps {
    sh '''
      terraform init -backend-config=backend.hcl
      terraform validate
      terraform plan -out=tfplan
    '''
    archiveArtifacts artifacts: 'tfplan', fingerprint: true
  }
}
```

**Common Mistakes:**

- Running `apply` directly without review.
- Using local state; no locking.

**Debugging Tips:**

- If plan shows unexpected destroys: investigate resource addresses and module changes before applying.
- If state lock stuck: release lock carefully (DynamoDB/Azure table) after verifying no active run.

**Follow-up Questions:**

- How do you handle “plan in CI, apply by human” flow?
- How to ensure Terraform is idempotent in pipelines?

---

### Q10. How do you integrate GitHub Actions with Jenkins in a hybrid CI/CD model?

**Answer:**  

Typical model:

- **GitHub Actions**:
  - Run on PRs for fast CI (linting, unit tests, SAST, SCA).
- **Jenkins**:
  - Handles CD, infra changes, and internal integrations.

Integration patterns:

- GitHub Actions triggers Jenkins job via API/webhook when a merge occurs.
- GitHub Actions writes build metadata (e.g., Docker image tag) as outputs; Jenkins reads these to deploy the same artifact.

**Common Mistakes:**

- Duplicating identical logic in both systems.
- Not aligning environment names and branch strategies.

**Debugging Tips:**

- Use `curl` calls with logs from Actions to verify Jenkins job triggers.
- Check Jenkins build parameters to ensure data from Actions is passed correctly.

**Follow-up Questions:**

- How would you handle secrets configuration across both systems?
- How do you standardize pipeline behavior across Actions and Jenkins?

---

### Q11. What are typical CI/CD stages for a Python FastAPI service with Pandas in this role?

**Answer:**  

Reasonable stage breakdown:

1. **Checkout**
2. **Environment setup** (Python version, venv, dependencies).
3. **Static checks** (formatting, lint, type hints).
4. **Unit tests** with coverage.
5. **Integration tests** (if any).
6. **Build Docker image**.
7. **Security scans** (dependencies, container).
8. **Publish artifacts** (image to registry).
9. **Deploy to dev** (Helm/K8s).
10. **Smoke tests** (health endpoint, basic flows).
11. **Notification + metrics logging** (release event).

**Follow-up Questions:**

- Where do you put performance tests?
- How do you enforce minimum coverage thresholds?

---

### Q12. Jenkins security: how would you harden a Jenkins controller?

**Answer:**  

Key controls:

- Integrate with corporate SSO/LDAP; disable anonymous access.
- Use Role-Based Strategy plugin for RBAC; separate admins from users.
- Limit direct CLI and script console access to admins.
- Use HTTPS with modern TLS, behind corporate reverse proxy.
- Restrict what plugins can be installed; maintain plugin allowlist and patching schedule.
- Backup Jenkins configuration securely.

**Common Mistakes:**

- Everyone gets “admin” rights.
- No separation between prod and non‑prod Jenkins.

**Debugging Tips:**

- If RBAC misconfigured, use “safe mode” or restore from backup.
- Always test major security config changes in non‑prod first.

**Follow-up Questions:**

- How to audit who triggered deployments?
- How do you implement change approval flows with minimal friction?

---

### Q13. How do you design a multi-branch pipeline for trunk-based development?

**Answer:**  

For trunk-based dev:

- Allow only short-lived feature branches.
- PRs target `main`.
- Multibranch pipeline job or GitHub Actions workflows use branch patterns.

Behavior:

- Feature branches: build + unit tests + static checks.
- `main`: full pipeline plus deployment to dev/stage; tags or specific branches for prod.

**Common Mistakes:**

- Long-lived branches diverging from `main`.
- No automated tests on PRs.

**Debugging Tips:**

- If multibranch job doesn’t pick a branch, check SCM credentials, branch discovery settings, and naming patterns.

**Follow-up Questions:**

- How do you handle hotfixes in trunk-based flows?
- How do you align this with release tagging?

---

### Q14. What metrics would you track to evaluate CI/CD effectiveness?

**Answer:**  

Key metrics:

- **Lead time for change** (commit → prod).
- **Deployment frequency**.
- **Change failure rate** (deployments that cause incident/rollback).
- **Mean Time To Recover (MTTR)**.
- **Pipeline success rate** and average duration.
- **Queue time** vs execution time in Jenkins.

These map to DORA metrics and are very relevant in a bank’s DevOps maturity discussions.[web:23][web:26]

**Follow-up Questions:**

- How do you extract these metrics from Jenkins and visualize them (e.g., Grafana)?
- How would you set targets for these metrics in a regulated context?

---

### Q15. How do you approach debugging a flaky Jenkins pipeline?

**Answer:**  

Systematic approach:

1. **Identify pattern:** Does it fail only for certain branches, times, agents?
2. **Distinguish infra vs test flakiness:**
   - Infra issues: network, resource constraints, timeouts.
   - Test issues: ordering, shared state, race conditions.
3. **Isolate unstable steps:**
   - Add retries with `retry {}` for known transient steps (e.g., network calls).
   - Stabilize test data and environment.
4. **Add observability:**
   - More logging around failing parts.
   - Export metrics for pipeline duration and failures.[web:45][web:46]

**Common Mistakes:**

- Blindly adding `retry` everywhere without fixing root causes.
- Ignoring flakiness until it becomes “normal”.

**Follow-up Questions:**

- Give an example of a flaky test you fixed.
- How do you decide when a retry is acceptable vs when to fix the root cause?

---
