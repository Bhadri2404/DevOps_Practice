Here are some **production challenge stories** you can tell, customized to your resume and the stack you’ve been describing (AWS, Terraform, Kubernetes, Jenkins, Ansible Tower, Artifactory, Prometheus/Grafana, IBM ELM, Jira, hybrid infra). [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/86772080/800df8b6-7b76-4cd7-b657-364e0ba693cc/BHADRESH.pdf)

You can almost read these verbatim, or shorten them depending on time.

***

## 1. Challenge: Kubernetes app outage due to misconfigured resources

**Context you can mention**

> “In my current role at MicroGenesis, I manage Kubernetes workloads on AWS with Terraform, Jenkins/GitHub Actions, Prometheus, and Grafana.” [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/86772080/800df8b6-7b76-4cd7-b657-364e0ba693cc/BHADRESH.pdf)

**Problem (how you tell it)**

> “We had a production microservice that started crashing frequently after a new release. From the user side it looked like intermittent 5xx errors and timeouts. Our dashboards showed restart spikes for that deployment.”

**What you did – step by step**

1. **Detection**  
   - Grafana alert fired: Pod restarts and error rate increased.  
   - Alertmanager sent an email to the on‑call DevOps group.  
2. **Initial triage**  
   - Checked `kubectl get pods` and saw Pods in `CrashLoopBackOff`.  
   - Looked at `kubectl logs` and saw OOM errors and slow queries.  
3. **Root cause analysis**  
   - New version added additional features without adjusting resource requests/limits.  
   - HPA and cluster autoscaler were fine; the Pod itself was starved.  
4. **Fix**  
   - Tuned resource requests/limits in Helm values (CPU/memory).  
   - Updated deployment config in Git, let Argo CD sync to cluster.  
   - Verified via metrics that restarts dropped and latency normalized.  
5. **Long‑term improvement**  
   - Added resource budget checks in CI (simple YAML validation).  
   - Documented performance baselines for each service and reviewed them regularly.

**How to close the story**

> “The key takeaway was that even with autoscaling, per‑Pod resource requests and limits matter. We used Kubernetes metrics plus Prometheus/Grafana to quickly identify the bottleneck, then fixed it in Git and let Argo CD roll out the change safely.”

***

## 2. Challenge: Flaky Jenkins pipeline and overloaded build agents

**Context**

> “At Infosys, I worked as a Jenkins Administrator and Senior Systems Engineer, automating CI/CD with Jenkins and Ansible Tower on Linux build nodes.” [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/86772080/800df8b6-7b76-4cd7-b657-364e0ba693cc/BHADRESH.pdf)

**Problem**

> “We had frequent pipeline failures during peak hours. Jobs would stay in queue for a long time or fail because agents were overloaded or misconfigured.”

**What you did – step by step**

1. **Detection**  
   - Developers complained about slow builds and intermittent failures.  
   - Jenkins dashboard showed many queued builds and some agents offline.  
2. **Analysis**  
   - Checked node configuration in Jenkins: some agents had too many concurrent executors for their CPU/RAM.  
   - Logs showed timeouts and disk space issues on some agents.  
3. **Fix – infra & config**  
   - Used Ansible Tower to standardize agent configuration:
     - One role to install required tools (JDK, Docker, build dependencies).  
     - Standardized number of executors per node based on hardware.  
   - Cleaned disks and added automatic workspace cleanup.  
4. **Scaling strategy**  
   - Introduced a clear labeling strategy (e.g., `docker`, `heavy-build`, `light-build`) so pipelines used the right agents.  
   - For some workloads, added additional agents and updated Jenkins node templates.  
5. **Outcome**  
   - Queue times went down, build stability improved.  
   - On‑call issues around “Jenkins is slow” reduced significantly.

**Interview line**

> “I treated Jenkins as a production platform: standardized nodes using Ansible Tower, tuned executors, and improved labeling. This significantly reduced flaky builds and made our CI more predictable.”

***

## 3. Challenge: Terraform drift and manual changes in AWS

**Context**

> “Across both roles I worked with Terraform to provision AWS resources like EC2, VPC, EKS, ALB, and IAM.” [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/86772080/800df8b6-7b76-4cd7-b657-364e0ba693cc/BHADRESH.pdf)

**Problem**

> “We discovered that some AWS resources (security groups and load balancer config) didn’t match what was in Terraform. Teams had been making manual console changes to fix urgent issues, which caused drift and unpredictable behavior.”

**What you did – step by step**

1. **Detection**  
   - Terraform plan started showing large, unexpected changes for some stacks.  
   - Differences in SG rules and ALB listeners vs. what was expected.  
2. **Investigation**  
   - Compared current AWS state with Terraform state (`terraform plan` and console).  
   - Talked to application teams and found ad‑hoc console changes made during incidents.  
3. **Controlled remediation**  
   - Took a snapshot of current AWS config and documented it.  
   - Aligned Terraform code with the agreed‑upon final configuration:
     - Some manual emergency changes were kept but codified.  
     - Some were rolled back because they were too permissive.  
   - Applied Terraform in a controlled change window.  
4. **Process improvement**  
   - Introduced a clear rule: **all infrastructure changes must go through Terraform PRs**, no direct console edits except break‑glass.  
   - Added `terraform plan` checks in Jenkins/GitHub Actions and mandatory code reviews.  
5. **Outcome**  
   - Reduced drift, made future Terraform plans small and predictable.  
   - Compliance/security posture improved (easier auditing of infra changes).

**Interview line**

> “The lesson was to enforce Infrastructure‑as‑Code discipline and capture all legitimate manual fixes into Terraform so the desired state is always in Git, not just in the AWS console.”

***

## 4. Challenge: Secrets mis‑use and standardizing secret management

**Context**

> “I worked with Ansible Tower, Terraform, Kubernetes, and Jenkins, and we had multiple ways secrets were being handled.” [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/86772080/800df8b6-7b76-4cd7-b657-364e0ba693cc/BHADRESH.pdf)

**Problem**

> “In one early phase, teams stored some passwords directly in Jenkins pipeline scripts or plain Ansible vars. This was risky and hard to rotate.”

**What you did – step by step**

1. **Assessment**  
   - Reviewed Jenkins pipelines and Ansible roles for any hardcoded passwords/API keys.  
   - Found places where DB passwords, Jira admin passwords, and SSH keys were in code.  
2. **Design a standard**  
   - Defined a simple policy:
     - All infra/app secrets go into Ansible Vault or vault‑like secret stores.  
     - CI/CD uses credential stores and environment variables, not literals.  
     - Kubernetes uses Secrets per app & env; manifests only refer to Secret names.  
3. **Migration**  
   - Moved Jenkins hardcoded creds into Jenkins Credentials store and replaced them with `credentials()` or environment bindings.  
   - Moved Ansible plain vars into Vault‑encrypted files and updated playbooks to read from Vault.  
   - Created Kubernetes Secrets from these sources instead of putting values in YAML.  
4. **Education and guardrails**  
   - Documented best practices for secrets in a runbook or internal wiki.  
   - Added checks in code review and pre‑commit to catch obvious secret patterns.  
5. **Outcome**  
   - Reduced risk of accidental secret leaks.  
   - Rotations became a standard process instead of ad‑hoc editing of code.

**Interview line**

> “One of the bigger challenges was cleaning up legacy secret usage. I drove a migration to centralized secret management using Ansible Vault, CI credential stores, and Kubernetes Secrets, and added lightweight checks and documentation so new projects followed the same model.”

***

## 5. Challenge: IBM ELM / Jira availability and backups

**Context**

> “I also supported IBM ELM and Jira administration, including availability, user management, and backups.” [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/86772080/800df8b6-7b76-4cd7-b657-364e0ba693cc/BHADRESH.pdf)

**Problem**

> “We had cases where Jira or IBM ELM became slow or briefly unavailable, and backups were initially manual and inconsistent.”

**What you did – step by step**

1. **Stability improvements**  
   - Monitored system resource usage on the underlying Linux servers.  
   - Tuned JVM memory and database connections based on load.  
   - Cleaned up old logs/indexes that were consuming disk.  
2. **Automated backups**  
   - Implemented scheduled backups using scripts/cron:
     - Daily application backups and database dumps.  
   - Stored backups on separate storage (e.g., NFS/S3), verified restore procedures.  
3. **Monitoring and alerts**  
   - Added basic health checks and monitoring for these tools.  
   - Set up alerts for high CPU/disk, service down, and failed backups.  
4. **Operational runbooks**  
   - Documented restart and recovery procedures.  
   - Reduced MTTR during incidents because steps were clear and tested.

**Interview line**

> “For IBM ELM and Jira, I focused on making them stable ‘platform tools’: tuning resources, automating backups, and adding monitoring so we could respond quickly and confidently restore if needed.”

***

If you pick 2–3 of these stories and polish them, you’ll have strong “real production challenge” answers.  
Which one do you want to refine first into a concise 1–2 minute spoken answer (we can practice wording)?

## Scenario – Terraform apply failed, partial changes in AWS, how I fixed it

### Typical interview question

“You are running Terraform from Jenkins to manage AWS infrastructure. `terraform apply` fails in the middle with errors like ‘resource already exists’ or ‘resource in use’. Some resources are created, some are not. How did you handle this situation in production?”

---

### Step 1 – Understand what exactly failed

1. First, I looked at the **Jenkins build log** where Terraform was executed.  
2. I checked:
   - What was the **exact error message** from Terraform.  
   - At which **resource** it failed (for example, a Security Group, Load Balancer, or RDS instance).  
3. I also looked at the **Terraform plan** output in that build to see:
   - Which resources were supposed to be created/changed/destroyed.  

**Why:**  
Before touching anything, I need to know if the failure is due to:
- A configuration error (wrong reference, missing dependency).  
- A **conflict with existing resources** (Terraform trying to create something that already exists).  
- Or some AWS quota/limit issue.

---

### Step 2 – Check the actual AWS state

1. I logged into the **AWS console** or used CLI to see the real state of the resource:
   - Example: if it failed on `aws_lb.my_app_alb`, I checked if an ALB with that name/tag already exists.  
   - If it failed on a Security Group, I checked whether a SG with the same name was already there.  
2. I verified whether Terraform had already created **some** resources successfully before failing:
   - For example, the VPC and subnets might already be created, but the ALB failed.  

**Why:**  
Terraform state file might not perfectly match AWS if it failed mid‑way, so I confirm what is really there in AWS.

---

### Step 3 – Sync Terraform state with real AWS resources (if needed)

**Case A – Resource already exists but is not tracked by Terraform**

1. If I saw a resource existing in AWS that **Terraform did not know about**, I used `terraform import` to bring it under Terraform control.  
2. For example:
   ```bash
   terraform import aws_lb.my_app_alb arn:aws:elasticloadbalancing:...
   ```
3. After importing, I ran:
   ```bash
   terraform plan
   ```
   to make sure Terraform now treats that resource as “managed” instead of trying to recreate it.

**Case B – Terraform state has a resource, but AWS does not**

1. If Terraform thought a resource existed but it was actually deleted in AWS:
   - I fixed the state either by re‑creating it or by running `terraform state rm` (very carefully) and then letting Terraform recreate it.  
2. Again, I always followed with a `terraform plan` to confirm.

**Why:**  
Terraform assumes its state is correct. If state and AWS are out of sync, you will keep seeing “already exists” or similar errors until you import or fix state.

---

### Step 4 – Rerun `terraform plan` and review changes

1. Once state and real AWS were aligned, I ran:
   ```bash
   terraform plan
   ```
2. I carefully reviewed:
   - Which resources would be created, changed, or destroyed now.  
   - That Terraform **was not about to destroy** something important unexpectedly.  
3. If the plan looked safe, I proceeded.

**Why:**  
After a failure and manual fixes, you must re‑validate the plan before applying again, especially in production.

---

### Step 5 – Rerun `terraform apply` from Jenkins in a controlled way

1. I retriggered the Jenkins job that runs Terraform, often with:
   - The same parameters (ENV, REGION).  
   - Sometimes extra logging or dry‑run stage first.  
2. The job executed:
   - `terraform init` (to ensure backend and providers are OK).  
   - `terraform plan` (printed in logs).  
   - `terraform apply -auto-approve` if plan was acceptable.  
3. I watched the apply log to ensure it passed the problematic resource and finished successfully.

**Why:**  
I want the “source of truth” (Jenkins pipeline) to be used again, so the next runs are consistent and reproducible.

---

### Step 6 – Prevent the same problem in the future

After fixing the immediate issue, I worked on **prevention**:

1. **Process / discipline**
   - Made sure infra changes go through Terraform only (no manual console changes), or if manual changes are made in emergencies, they are later captured in Terraform code and state.  

2. **Code improvements**
   - Used proper `depends_on` and references to avoid race conditions.  
   - Named resources carefully to avoid collisions with existing names.  

3. **Pipeline safeguards**
   - Added a separate **plan‑only job** which developers could run and review before apply.  
   - Restricted `apply` in prod to specific people and change windows.  

**How I summarize this in an interview**

> “We had a case where Terraform apply failed mid‑way from Jenkins, leaving AWS in a partially updated state. I first analyzed the exact error and checked the real AWS resources. Then I aligned Terraform state with reality using import or state fixes, re‑ran `terraform plan` to confirm a safe change set, and finally re‑ran apply from Jenkins. After that, we tightened our process so manual console changes were minimized and all infra changes flowed through Terraform and reviewed plans.”


## Scenario – Jenkins agents going offline and pipelines failing

### Typical interview question

“Your Jenkins pipelines are failing or sitting in queue because agents are offline or unstable. How did you troubleshoot and stabilize your Jenkins agent setup in production?”

---

### Step 1 – Confirm the symptom

1. I first looked at the Jenkins dashboard:
   - Under “Build Queue” I saw many jobs waiting.  
   - Under “Build Executor Status” some agents were marked as **offline** or repeatedly going offline during builds.[web:271][web:280]  
2. Developers also reported:
   - Builds staying in the queue for a long time.  
   - Builds failing with messages like “Agent went offline during the build”.[web:277]  

**Why:**  
Before changing anything, I confirm it is truly an **agent** problem, not a Git issue, credentials issue, or broken pipeline script.

---

### Step 2 – Check agent logs and connectivity

1. In Jenkins, I went to:
   - `Manage Jenkins` → `Manage Nodes and Clouds` → selected the problematic agent → viewed the **node log**.  
2. From the logs I checked for:
   - SSH / JNLP connection errors.  
   - Java version or remoting version mismatches.  
   - Frequent disconnects due to network timeouts or authentication failures.[web:267][web:268][web:269]  
3. On the agent host (Linux):
   - Checked basic network with `ping` and `ssh` from controller to agent.  
   - Confirmed Java was installed and version matched the Jenkins controller requirements.  

**Why:**  
Most agent offline issues come from network/SSH/JNLP or Java mismatches. Fixing these at OS/network level is often the first step.

---

### Step 3 – Fix the agent configuration and stability

1. **Connectivity and Java**  
   - Ensured that:
     - The SSH keys or credentials used by Jenkins were valid and not expired.  
     - The agent’s Java version was supported and consistent with the controller.  
     - Firewalls/network rules allowed controller ↔ agent communication.[web:269][web:280]  
2. **Agent service**  
   - On the agent machine:
     - Restarted the agent service or JNLP process.  
     - Ensured it was configured to start automatically on boot.  
3. **Re‑create agent if corrupted**  
   - If logs showed persistent issues:
     - Removed the agent configuration in Jenkins.  
     - Cleaned the agent workspace directory.  
     - Re‑created the node in Jenkins UI and re‑connected it.[web:269]  

**Why:**  
Sometimes the cleanest fix is to delete and re‑create the agent config when it’s clearly inconsistent or corrupted.

---

### Step 4 – Standardize agents with Ansible

1. To avoid “snowflake” agents, I used **Ansible Tower** to standardize them:
   - Wrote an Ansible role that:
     - Installs the correct Java version.  
     - Installs required build tools (Docker, JDKs, Python, Ansible, etc.).  
     - Configures directories and permissions for Jenkins workspaces.  
2. Any new agent (or rebuilt agent) used this same role:
   - Ensuring consistent environment across all build nodes.  

**Why:**  
Standardization reduces random build failures caused by missing tools, wrong versions, or misconfigured environments.[file:241]

---

### Step 5 – Tune executors and labels

1. I checked each node’s **executors**:
   - If a machine was 2 vCPU / 4 GB RAM but had 4 executors, it was overloaded.  
   - I reduced executors to match hardware capacity (e.g., 1–2 executors).[web:280]  
2. I improved **labeling**:
   - Labeled nodes as `docker`, `ansible`, `heavy-build`, etc.  
   - Pipelines were updated to request appropriate labels instead of using any node.  

**Why:**  
Too many executors on weak hardware and poor label usage cause instability, timeouts, and “agent offline during build” symptoms.

---

### Step 6 – Add monitoring and alerting

1. Integrated agents into existing monitoring:
   - Node exporter → Prometheus → Grafana dashboards for CPU, memory, disk.  
   - Alerts for high load, low disk space, or node down.  
2. Used Jenkins metrics (via plugin or API) to monitor:
   - Queue length, number of offline nodes.  
   - Failures per agent.  

**Why:**  
Instead of waiting for developers to complain, monitoring tells us early when an agent is unhealthy or overloaded.

---

### How I summarize this in an interview

> “We had recurring issues where Jenkins agents were going offline or failing mid‑build. I debugged the node logs and network/Java configuration, re‑created problematic agents, and then standardized agent setup using Ansible Tower so all nodes had the same tooling and sane executor counts. I also improved labels and added monitoring, which stabilized our CI platform and reduced build failures significantly.”

---

## Scenario – Jenkins + Ansible playbook failures and how I stabilized them

### Typical interview question

“You use Jenkins to run Ansible playbooks (via Ansible Tower or CLI). Sometimes these jobs fail or behave inconsistently. Can you explain a real issue you faced and how you resolved it?”

---

### Step 1 – Identify the failure pattern

1. In Jenkins, some jobs that called Ansible (directly or via Tower API) started failing with:
   - `hudson.AbortException: Ansible Playbook Execution Failed`  
   - Or `UNREACHABLE!` / SSH errors in Ansible output.  
2. Failures were:
   - Intermittent on some hosts.  
   - More frequent after plugin updates or environment changes.[web:273][web:279]  

**Why:**  
First, I need to know whether this is a **Jenkins problem** (environment, plugin) or an **Ansible problem** (playbook, SSH, target host).

---

### Step 2 – Inspect Jenkins console output and Ansible logs

1. From the Jenkins job:
   - Opened the **Console Output** to see full Ansible command and logs.  
   - Confirmed whether Jenkins was running `ansible-playbook` directly or calling Ansible Tower API.  
2. For direct Ansible:
   - Checked that `ansible-playbook` existed on the agent (`which ansible-playbook`).  
   - Verified Python/Ansible versions on the agent.  
3. For Ansible Tower:
   - Checked Tower job template logs (via Tower UI) to see detailed failure reasons.  

**Why:**  
Most issues show up clearly once you look at Ansible’s verbose output (e.g., authentication issue, missing module, wrong inventory).

---

### Step 3 – Increase Ansible verbosity to pinpoint the issue

1. Modified the Jenkins pipeline to run Ansible with verbosity flags during troubleshooting:
   ```sh
   ansible-playbook -i inventory.ini site.yml -vvv
   ```
   or for Tower: enabled more detailed logs.[web:273]  
2. With `-vvv` I could see:
   - Which **task** failed.  
   - Exact **stderr** from modules (e.g., “permission denied”, “file not found”, “timeout”).  

**Why:**  
Standard `ansible-playbook` output is sometimes too short; verbosity quickly shows if the problem is SSH, sudo, path, or a specific task.

---

### Step 4 – Fix environment and connectivity issues

Depending on what logs showed:

1. **SSH/auth errors (UNREACHABLE)**  
   - Updated credentials/SSH keys in Ansible inventory or Tower credentials.  
   - Verified that target hosts were reachable from the Jenkins agent (ping, ssh).  
2. **Missing Ansible binary in Jenkins agent**  
   - Used Ansible (or manual provisioning) to install Ansible on the Jenkins agent.  
   - Ensured PATH includes the Ansible binary location.[web:276]  
3. **Python/module mismatches**  
   - Installed required Python packages or Ansible collections.  
   - Standardized versions across agents using Ansible Tower roles.  

**Why:**  
Environment‑related issues (SSH, binary paths, dependencies) are very common when Jenkins + Ansible are combined.

---

### Step 5 – Make playbooks idempotent and resilient

1. Reviewed failing tasks and made them **idempotent**:
   - So re‑running playbooks from Jenkins would not break anything or cause duplicate changes.  
2. Added `block` / `rescue` in Ansible for important tasks:
   - To capture failure details and handle partial failures more gracefully.[web:275]  
3. For transient issues (e.g., temporary network problems):
   - Used `retries` and `delay` on tasks that depended on external services.  

**Why:**  
CI/CD often reruns jobs after failures; idempotent Ansible roles ensure that retries do not cause chaos.

---

### Step 6 – Wrap Ansible execution in a reusable Jenkins pattern

1. Created a **shared pipeline library** or common script step for Ansible:
   - Standardized how `ansible-playbook` is invoked.  
   - Centralized credentials handling and verbosity flags.  
2. For Tower:
   - Used one common function to call the Tower job template via API, wait for completion, and parse result.  

**Why:**  
Instead of each Jenkinsfile calling Ansible differently, a common wrapper reduces errors and makes troubleshooting easier.[web:273]

---

### Step 7 – Integrate Ansible failures with alerting and reporting

1. Configured Jenkins to:
   - Mark build as failed when Ansible returns non‑zero.  
   - Send failure notifications (email/Slack) with key log lines.  
2. For critical automation (e.g., nightly infra config):
   - Added Prometheus exporters / metrics about success/failure counts.  
   - Alerted on repeated failures so the team could react early.

**Why:**  
Ansible failures shouldn’t be hidden. They must surface clearly in CI and monitoring so they can be fixed quickly.

---

### How I summarize this in an interview

> “We had cases where Jenkins‑triggered Ansible runs (both CLI and Tower) were failing intermittently. I systematically checked Jenkins console logs and Tower logs, increased Ansible verbosity, and fixed environment issues like SSH credentials and missing Ansible binaries on agents. Then I improved the playbooks to be idempotent and added a shared Jenkins wrapper for Ansible calls. This made our Jenkins + Ansible integration much more stable and easier to troubleshoot.”


### Jenkins Agent Production Issue – Story Format (1.5–2 Minutes)

> "One production issue I worked on was Jenkins agents frequently going offline, which started impacting our CI/CD process.
>
> We first noticed the issue when developers reported that their builds were stuck in the queue for a long time, and some deployments were failing because the agent disconnected during execution. Since multiple teams were affected and releases were getting delayed, we treated it as a high-priority incident.
>
> I started by checking the Jenkins dashboard and node logs. I found that a few agents were repeatedly disconnecting. To identify the root cause, I worked closely with the Linux and network teams. Together, we checked server health, connectivity, and agent configurations.
>
> During the investigation, we found multiple issues. Some agents had unstable SSH connections, a few had Java version mismatches, and some nodes were overloaded because too many executors were configured for the available CPU and memory.
>
> We fixed the connectivity issues, updated Java versions, restarted and reconnected the affected agents, and recreated a few corrupted agents. We also optimized executor counts and improved node labeling so workloads were sent to the right agents.
>
> After resolving the immediate issue, I wanted to make sure it wouldn't happen again. I created an Ansible-based standard configuration for Jenkins agents so every new agent would have the same Java version, tools, permissions, and settings. We also added monitoring through Prometheus and Grafana with alerts for CPU, memory, disk usage, and agent availability.
>
> Finally, I documented the complete RCA, troubleshooting steps, recovery procedure, and standard agent setup process in Confluence and shared it with the team. Because of these improvements, Jenkins became much more stable, build failures reduced significantly, and developers were able to deploy applications without delays."

This version sounds natural, practical, and shows **ownership, collaboration, troubleshooting, automation, monitoring, and documentation** within about **2 minutes**.



### Kubernetes Production Outage – Story Format (1.5–2 Minutes)

> "One production issue I worked on involved a Kubernetes microservice running on AWS that started crashing frequently after a new application release.
>
> The issue was first identified through Grafana alerts. We noticed an increase in pod restarts and application error rates. At the same time, users were experiencing intermittent 5xx errors and request timeouts while accessing the application.
>
> Since it was a production-facing service, we immediately started investigating. I checked the Grafana dashboards and then used `kubectl get pods` to verify the pod status. I found that several pods were in a CrashLoopBackOff state.
>
> Next, I reviewed the application logs using `kubectl logs` and collaborated with the application development team to understand what changes were introduced in the latest release. During the analysis, we found that the new version included additional features that increased memory consumption significantly.
>
> I also checked Kubernetes metrics and noticed that the pods were hitting their memory limits and getting terminated due to Out Of Memory (OOM) events. Initially, we verified whether HPA or Cluster Autoscaler was causing the issue, but both were working correctly. The actual problem was that the pod resource requests and limits were not updated to match the new application's resource requirements.
>
> To fix the issue, I worked with the developers to estimate the required CPU and memory values. We updated the resource requests and limits in the Helm values file, committed the changes to Git, and allowed Argo CD to synchronize the updated deployment to the Kubernetes cluster.
>
> After deployment, we closely monitored Grafana dashboards and Prometheus metrics. We observed that pod restarts stopped, memory utilization stabilized, latency returned to normal levels, and user-reported errors disappeared.
>
> To prevent similar issues in the future, I introduced resource validation checks in our CI pipeline and documented recommended CPU and memory baselines for each microservice. We also added a review step during deployments to ensure resource configurations are evaluated whenever major application changes are introduced.
>
> The main lesson from this incident was that even when autoscaling is configured correctly, proper pod resource requests and limits are critical for application stability. By using Kubernetes metrics, Prometheus, and Grafana, we quickly identified the bottleneck, fixed it through our GitOps process, and restored the service with minimal downtime."

### Short Interview Version (45–60 Seconds)

> "After a new release, one of our production microservices started showing 5xx errors and timeouts. Grafana alerts indicated increased pod restarts. I checked the Kubernetes cluster and found pods in CrashLoopBackOff. Using pod logs and metrics, I identified Out Of Memory errors. I collaborated with the development team and found that the new release increased memory usage, but the Kubernetes resource limits had not been updated. We modified the CPU and memory requests/limits in the Helm configuration, committed the changes to Git, and Argo CD deployed them automatically. After deployment, pod restarts stopped and application performance normalized. We then added resource validation checks and documented performance baselines to avoid similar incidents in future releases."

