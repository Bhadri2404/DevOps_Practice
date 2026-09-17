# Jenkins Handbook — Part 3: Operations, Troubleshooting, Interview Prep & Reference

> Picks up where Part 2 (Production Engineering) left off. Covers plugin management, day-to-day administration, backup/recovery, a full troubleshooting guide, interview preparation, and a quick-reference cheat sheet + learning roadmap.

## Table of Contents
- [28. Plugin Management](#28-plugin-management)
- [29. Jenkins Administration & Configuration](#29-jenkins-administration--configuration)
- [30. Backup, Recovery & Maintenance](#30-backup-recovery--maintenance)
- [31. Troubleshooting Guide](#31-troubleshooting-guide)
- [32. Interview Questions Bank](#32-interview-questions-bank)
- [33. Jenkins Revision Cheat Sheet](#33-jenkins-revision-cheat-sheet)
- [34. Beginner → Production Learning Roadmap](#34-beginner--production-learning-roadmap)

---

## 28. Plugin Management

### In Plain English (Beginner Explanation)
Plugins are like specialty attachments for a stand mixer — the base mixer (Jenkins) does the basics, but attachments let it also knead dough, grind meat, or make pasta. You only install the attachments you actually need, and you always check they're compatible with your specific mixer model before attaching one.

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
Many plugins depend on other plugins to function (e.g., the Pipeline plugin suite depends on several supporting plugins). Jenkins automatically installs required dependencies when you install a plugin, but compatibility issues can still arise between plugin versions and your Jenkins core version — especially after skipping several Jenkins core versions at once.

### Plugin Upgrades and Rollback Considerations
- Upgrading a plugin can occasionally introduce breaking changes to existing job configurations or pipeline syntax.
- Jenkins keeps the previous plugin version's `.jpi.bak` file on disk, allowing a manual rollback if an upgrade causes problems — though this should be tested in a non-production Jenkins instance first wherever possible, rather than discovered as a surprise in production.

### Extended Walkthrough: A Safe Plugin Upgrade Process
```
1. Take a full JENKINS_HOME backup (Section 30) before touching anything.
2. Apply the plugin update on a staging/non-production Jenkins instance first.
3. Run a representative sample of jobs/pipelines against the staging instance.
4. Read the plugin's release notes for the specific version jump, watching for
   "breaking change" or "deprecation" notices.
5. Only after staging validation passes, apply the same update to production
   during a low-traffic window.
6. Monitor the first few production builds closely after the upgrade.
```

### Managing Plugins Safely
- Test plugin upgrades in a staging/non-production Jenkins instance before applying to production.
- Read release notes for major version jumps, since breaking changes are far more likely there than in minor patch releases.
- Avoid installing plugins from unofficial or unverified sources — stick to the official Jenkins Update Center.

### Common Plugin Failures
| Symptom | Likely Cause |
|---|---|
| Jenkins fails to restart after a plugin update | Version incompatibility between the plugin and Jenkins core, or between two interdependent plugins |
| A pipeline step suddenly "doesn't exist" | A plugin providing that step was uninstalled/downgraded |
| UI errors after an update | Cached browser assets conflicting with updated plugin UI — try a hard refresh or clearing cache |

### Best Practices
- Keep an eye on **Manage Jenkins → Plugins → Security warnings** and prioritize updating flagged plugins promptly.
- Only install plugins you actually need — each one is additional attack surface and additional long-term maintenance burden.
- Snapshot/back up Jenkins (Section 30) before major plugin upgrades, every time, without exception.

### Interview Questions
**Q: Why is it risky to upgrade many plugins simultaneously across several major versions at once?**
A: Compatibility issues compound — a failure could stem from any one of several simultaneously-changed plugins, making the root cause far harder to isolate than upgrading incrementally and testing between steps.

**Q: What's the safest way to roll out a plugin upgrade in a team environment?**
A: Back up first, test the upgrade on a staging instance with representative jobs, read release notes for breaking changes, and only then apply to production during a low-traffic window with close monitoring afterward.

**What You Should Remember:** Plugins are how Jenkins gains almost all of its integrations. Manage them deliberately: test upgrades in non-prod first, watch for security warnings, and back up before major changes.

---

## 29. Jenkins Administration & Configuration

### In Plain English (Beginner Explanation)
Manage Jenkins is the restaurant manager's back office — the room with the master keys, the staff schedule, the supplier contracts, and the settings for the whole building, separate from any single kitchen station.

### Simple Definition
The **Manage Jenkins** area is the central control panel for system-wide configuration — everything from global tools to security to system logs lives here.

### Key Administrative Areas
```
Jenkins Dashboard → Manage Jenkins →
  System               → global settings: Jenkins URL, admin email, global environment variables
  Tools                → JDK/Maven/Git/etc. installations
  Credentials          → the Credentials Store
  Nodes                → agents/executors
  Clouds               → dynamic agent providers (Kubernetes, Docker, EC2 plugin, etc.)
  Security             → authentication/authorization/CSRF
  Plugins              → plugin management
  System Information   → Jenkins version, environment variables, system properties — useful for debugging
  System Log           → Jenkins's own internal logs, useful when the controller itself is misbehaving
  Script Console       → run raw Groovy scripts directly against the running Jenkins instance (admin-only, powerful, use with caution)
```

### Script Console — Use With Caution
```
Manage Jenkins → Script Console
```
Lets an administrator run arbitrary Groovy code with full access to Jenkins's internal Java objects — genuinely useful for advanced troubleshooting or bulk configuration changes, but also genuinely dangerous (it can modify or delete anything in the entire instance). Access should be restricted to trusted administrators only, and treated as an emergency/expert tool, not routine usage.

### Extended Example: A Safe, Read-Only Script Console Query
```groovy
// Lists all jobs and their last build result — a read-only, low-risk example
Jenkins.instance.getAllItems(Job.class).each {
    println("${it.fullName}: ${it.lastBuild?.result}")
}
```
Even a "safe" read-only example like this should only be run by someone who understands exactly what it does — the Script Console has no undo button for destructive commands.

### Environment Variables & System Settings
`Manage Jenkins → System` lets you define global environment variables available to every job/pipeline — useful for values that are truly global (e.g., a shared internal registry hostname), though most values are better scoped to individual pipelines' `environment { }` blocks to avoid unexpected cross-job effects.

### Email/Notification Configuration
```
Manage Jenkins → System → E-mail Notification (basic) / Extended E-mail Notification (Email Extension plugin)
  → SMTP server, port, authentication, default recipients
```

### Common Mistakes
- Giving Script Console access to non-admin users — effectively equivalent to granting full system access, since arbitrary code execution can do anything the Jenkins process itself can do.
- Setting values that should be pipeline-specific as global environment variables, causing unexpected, hard-to-trace behavior across unrelated jobs.
- Never reviewing System Information/Log until an incident is already underway, instead of using it proactively.

### Best Practices
- Restrict Script Console and System configuration access to a small, trusted admin group only.
- Regularly review System Information/Log when diagnosing controller-level issues, and periodically even when nothing seems wrong.

### Interview Questions
**Q: Why is Script Console access tightly restricted, even for otherwise-trusted users?**
A: It allows arbitrary Groovy code execution with full access to Jenkins's internal objects — equivalent to root-level access over the entire instance, with no built-in undo for destructive actions.

**Q: When would you use a global environment variable versus a pipeline-level one?**
A: Global variables suit values that are truly universal across the whole instance (e.g., a shared internal hostname); pipeline-level `environment {}` blocks are safer for anything project-specific, avoiding unexpected effects on unrelated jobs.

**What You Should Remember:** `Manage Jenkins` is the hub for all system-wide administration. Script Console is powerful but should be tightly restricted — treat it like root access, because it effectively is.

---

## 30. Backup, Recovery & Maintenance

> Additional Production Knowledge extending beyond a typical beginner course.

### In Plain English (Beginner Explanation)
JENKINS_HOME is basically the restaurant's entire recipe book, staff records, and safe combinations all filed in one cabinet. If the whole building burned down, this cabinet — backed up somewhere safe, off-site — is what lets you rebuild the exact same restaurant elsewhere, quickly and accurately.

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

### Extended Example: A Simple Automated Backup Script
```bash
#!/bin/bash
# Runs as a scheduled cron job on the Jenkins controller host
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
sudo systemctl stop jenkins
tar -czf /tmp/jenkins-backup-$TIMESTAMP.tar.gz /var/lib/jenkins
aws s3 cp /tmp/jenkins-backup-$TIMESTAMP.tar.gz s3://my-jenkins-backups/
sudo systemctl start jenkins
rm /tmp/jenkins-backup-$TIMESTAMP.tar.gz
```
Note the brief `stop`/`start` around the backup — this avoids capturing a partially-written, inconsistent snapshot while Jenkins is actively writing to files. For less disruptive backups, an EBS volume snapshot (which doesn't require stopping the service) is often preferred in production.

### Restore Process
1. Provision a fresh Jenkins instance (same version, ideally, to avoid unexpected migration issues).
2. Stop the Jenkins service.
3. Replace the new instance's `JENKINS_HOME` with the backed-up copy.
4. Start Jenkins and verify jobs, credentials, and plugins all loaded correctly.
5. Run a test build on a non-critical job to confirm end-to-end functionality before relying on the restored instance for real work.

### Build Retention & Log Cleanup
- **Discard Old Builds** (per job, or globally): automatically deletes build history/logs beyond a configured count or age, preventing `JENKINS_HOME/jobs/*/builds/` from growing indefinitely.
- **Workspace cleanup**: deleting a job's workspace directory between/after builds (via the "Delete workspace before build starts" option, or an explicit `cleanWs()` pipeline step) prevents leftover files from one build silently affecting the next.

### Disk-Space Management
"Jenkins disk full" is one of the most common real-world operational incidents. Common contributors:
- Unbounded build history/logs (fix: Discard Old Builds).
- Leftover Docker images/containers on agents (fix: cleanup steps in `post { always { } }`).
- Large, un-rotated system logs.

### Monitoring & Health Checks
- Track disk usage, executor utilization, and queue length over time (via Jenkins's own metrics/monitoring plugins, or external monitoring scraping Jenkins's API).
- Set alerts before disk usage becomes critical, rather than discovering it only after builds start failing unexpectedly.

### Upgrades
- Upgrade Jenkins core and plugins deliberately and incrementally (not skipping many versions at once), testing in a non-production instance first, with a full backup taken immediately before any upgrade.

### Common Mistakes
- Never testing the actual **restore** process — a backup you've never restored from is unverified and might genuinely not work when you actually need it during a real incident.
- Letting build/log retention grow unbounded until a disk-full incident forces reactive action.
- Backing up `JENKINS_HOME` while Jenkins is actively writing to it without any consistency mechanism, risking a corrupted backup.

### Best Practices
- Automate regular `JENKINS_HOME` backups to durable storage (e.g., S3) and periodically test restoring them — schedule this as a recurring exercise, not a one-time setup task.
- Set retention policies (Discard Old Builds) on every job as a default habit, not an afterthought.
- Consider Configuration as Code (JCasC) so your entire Jenkins setup is reproducible from source control, not solely dependent on backups.

### Interview Questions
**Q: Why is it critical to back up the `secrets/` directory together with the rest of `JENKINS_HOME`, never separately?**
A: It contains the master encryption key used to encrypt all stored credentials; without it, restored credentials from the rest of the backup would be unreadable/unusable even if everything else restores correctly.

**Q: What's the risk of never testing a backup's restore process?**
A: The backup might be incomplete, corrupted, or incompatible with a fresh instance in ways that only become apparent during an actual disaster — by which point it's too late to fix calmly.

**What You Should Remember:** `JENKINS_HOME` is everything Jenkins is — back it up (including `secrets/`) regularly, test restores, and set retention/cleanup policies so disk space doesn't silently become an incident.

---

## 31. Troubleshooting Guide

### In Plain English (Beginner Explanation)
Troubleshooting is detective work: something went wrong, and you're looking for clues (symptoms), suspects (likely causes), the crime scene (where to look), and finally, how to fix it so it doesn't happen again.

For each issue below: **Symptoms → Likely Causes → Where to Check → Fix**

### Agent Offline
- **Symptoms**: Node shows "offline" in Manage Jenkins → Nodes; jobs targeting its label sit in queue indefinitely.
- **Causes**: SSH connection dropped, agent process crashed, network/firewall change, disk full on the agent itself.
- **Check**: Node's status page ("Log" tab); agent's own system logs; connectivity via `ping`/`ssh` from the controller.
- **Fix**: Re-launch via "Launch agent" button; resolve underlying network/resource issue; restart the agent process if needed.
- **Prevention**: Monitor agent connectivity proactively; alert on disk usage before it hits 100%.

### Build Stuck in Queue / No Executor Available
- **Symptoms**: Job sits in "queue," never starts.
- **Causes**: No agent matches the requested label; all matching executors are busy; a quiet period/throttle is delaying it.
- **Check**: Queue item's "why is it in the queue" hover text in the Jenkins UI; Manage Jenkins → Nodes for executor availability.
- **Fix**: Add/free up agents matching the label; increase executor count if resources allow; adjust throttling settings.
- **Prevention**: Size your agent pool ahead of expected peak concurrent build volume, not just average volume.

### Jenkins Controller Overloaded
- **Symptoms**: UI sluggish/unresponsive for everyone, high CPU/memory on the controller host.
- **Causes**: Builds running directly on the controller (executors > 0); too many heavy jobs/plugins.
- **Check**: `Manage Jenkins → Nodes → built-in node` executor count; system resource monitoring.
- **Fix**: Set controller executors to 0; move builds to dedicated agents.
- **Prevention**: Make "controller executors = 0" a non-negotiable default from day one of any production setup.

### Git Checkout Failure
- **Symptoms**: Pipeline fails at Checkout stage; "repository not found" or "permission denied."
- **Causes**: Wrong repo URL, missing/expired/incorrect credentials, network blocked to Git host.
- **Check**: The `credentialsId` referenced actually exists and is valid in Manage Jenkins → Credentials; connectivity from the agent to the Git host.
- **Fix**: Correct the URL/credentials; verify SSH keys or tokens haven't expired.
- **Prevention**: Set calendar reminders for credential/token expiry dates well before they lapse.

### Webhook Not Triggering
- **Symptoms**: Pushing code doesn't start a build automatically.
- **Causes**: Webhook not configured on the Git provider side; Jenkins URL not publicly reachable; job doesn't have the trigger enabled.
- **Check**: Git provider's webhook delivery log (response codes); job's Build Triggers config.
- **Fix**: Fix Jenkins URL/reachability; re-configure webhook; enable the correct trigger on the job.
- **Prevention**: After configuring any webhook, immediately test it with a small commit and confirm delivery succeeds before considering the setup complete.

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
- **Fix**: Install kubectl on the agent, or route the job to an agent/pod template that includes it.

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
- **Fix**: Always add a real smoke test stage after deployment; always verify rollout status with an adequate timeout; add liveness/readiness probes to the Kubernetes deployment itself.

### Quick Diagnostic Flowchart (General Approach)
```
Build failed or misbehaving?
   │
   ├── Check Console Output first — always.
   │      → Tells you exactly which step failed and the raw error message.
   │
   ├── Is it a "command not found" error?
   │      → Wrong agent / missing tool on that agent → check labels & tool install.
   │
   ├── Is it an authentication/permission error?
   │      → Check Credentials (ID, scope, expiry) and RBAC roles.
   │
   ├── Is it a network/connectivity error?
   │      → Check firewall/security group rules from that specific agent.
   │
   ├── Did it "succeed" but the real-world result looks wrong?
   │      → Missing smoke test / missing rollout status verification.
   │
   └── Still stuck?
          → Check Jenkins System Log (Manage Jenkins → System Log) for controller-level issues.
```

**What You Should Remember:** Most Jenkins production incidents fall into a handful of patterns: missing tools on the wrong agent, expired/misconfigured credentials, unbounded disk usage, and pipelines that report success without actually verifying real-world health. Build guardrails (timeouts, smoke tests, retention policies) against all four proactively, before they become incidents.

---

## 32. Interview Questions Bank

### In Plain English (Beginner Explanation)
This is your interview rehearsal room — a place to practice explaining these ideas out loud, in your own words, the way you'd explain them to an interviewer who's testing whether you truly understand the "why" behind each choice, not just the dictionary definitions.

### Beginner
**Q: What is Jenkins?**
A: An open-source automation server used to automate building, testing, and deploying software, most commonly as the engine behind CI/CD pipelines.

**Q: What's the difference between Continuous Integration, Continuous Delivery, and Continuous Deployment?**
A: CI = frequently merging and automatically building/testing code. Continuous Delivery = code is always kept in a deployable state, but a human triggers the actual production release. Continuous Deployment = every passing change is released automatically, with no manual gate.

**Q: What is a Freestyle project?**
A: Jenkins's original UI-configured job type, where build steps and triggers are set through forms rather than code — simple, but not version-controlled or highly flexible.

**Q: What is a Jenkinsfile?**
A: A text file, usually stored in the project's Git repository, that defines a Pipeline as code.

**Q: What is the difference between a build trigger and a build step?**
A: A trigger determines *when* a build starts (webhook, schedule, remote call); a build step is *what actually happens* during the build (compiling, testing, deploying).

**Q: What is an executor?**
A: A slot on a controller or agent capable of running one build at a time; the number of executors determines how many builds can run concurrently on that node.

### Intermediate
**Q: Declarative vs Scripted Pipeline — when would you choose each?**
A: Declarative for most day-to-day CI/CD — structured, easier to read/validate. Scripted (or `script {}` blocks within Declarative) when you need complex custom logic Declarative can't express directly.

**Q: What does the `agent` directive do?**
A: Specifies where the pipeline (or a specific stage) executes — e.g., any available agent, a labeled agent, or inside a Docker container.

**Q: How do parameters get accessed inside a Jenkinsfile?**
A: Through the `params` object, e.g. `params.ENVIRONMENT`, after being declared in a `parameters { }` block.

**Q: What's the purpose of `withCredentials`?**
A: To securely inject a stored credential into scoped variables for a specific block of steps, with automatic log masking, rather than hardcoding secrets.

**Q: What's the difference between Poll SCM and a webhook trigger?**
A: Poll SCM has Jenkins actively check on a schedule for changes (introduces delay); a webhook has the Git provider push a notification the instant a change happens (near-instant, more efficient).

**Q: What is a Multibranch Pipeline, and why is it useful for pull requests?**
A: It automatically discovers every branch (and optionally PRs) in a repository and builds each using its own Jenkinsfile — enabling automatic PR validation without manually creating a job per branch.

### Advanced
**Q: How would you design a Shared Library, and why use one?**
A: Structure it with `vars/` for callable global steps, `src/` for reusable Groovy classes, and `resources/` for static files; use one to centralize common CI/CD logic (e.g., build-scan-push routines) so dozens of Jenkinsfiles stay consistent and any fix/improvement is made once, in one place.

**Q: How does the Kubernetes plugin change Jenkins's scaling model compared to static agents?**
A: It creates ephemeral agent pods on demand per build (using pod templates) and tears them down afterward, instead of maintaining a fixed pool of always-on agents — reducing idle cost and guaranteeing a clean environment per build, at the cost of added orchestration complexity.

**Q: How do you prevent a stuck pipeline from holding an executor indefinitely?**
A: Set `timeout()` at the pipeline or stage level (including around any `input` approval steps), and use `options { timeout(...) }` as a default safety net on every pipeline.

**Q: What's the risk of applying `terraform apply` without reviewing a saved plan first?**
A: Infrastructure could change unexpectedly (due to drift or an unreviewed change in the configuration), potentially causing destructive, unreviewed modifications to real production infrastructure.

**Q: Why should Shared Library consumers version-pin rather than always tracking the library's main branch?**
A: A breaking change pushed to the library's main branch would otherwise instantly affect every consuming pipeline simultaneously; version-pinning lets teams upgrade deliberately, after testing, on their own schedule.

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

**Q: How would you design RBAC for three independent teams sharing one Jenkins instance?**
A: Use a consistent job-naming convention per team, create an Item Role per team matching that naming pattern, and assign only that team's members to it — ensuring no team can see or modify another's jobs.

**Q: Walk through how you'd safely roll out a Terraform-managed infrastructure change to production.**
A: `terraform fmt`/`validate` for a fast syntax check, `terraform plan -out=tfplan` to compute and save the exact changes, a manual `input` approval step where a human reviews the plan output, then `terraform apply` against that exact saved plan file — never re-planning right before apply, to avoid unreviewed drift sneaking in.

**What You Should Remember:** Production interviews tend to probe *why*, not just *what* — be ready to explain trade-offs (static vs dynamic agents, Declarative vs Scripted, IAM roles vs static keys) rather than just definitions.

---

## 33. Jenkins Revision Cheat Sheet

### In Plain English (Beginner Explanation)
Think of this as the laminated quick-reference card taped inside the kitchen door — everything experienced staff glance at instead of digging through the entire cookbook, mid-shift.

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
| JENKINS_HOME | The directory containing all of Jenkins's configuration, jobs, and secrets |

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
- [ ] JENKINS_HOME backed up regularly (including `secrets/`), with tested restores
- [ ] Discard Old Builds enabled on every job

---

## 34. Beginner → Production Learning Roadmap

### In Plain English (Beginner Explanation)
This is your training schedule as a brand-new kitchen hire: what to learn on day one versus what to save for after you've mastered the basics, so you're never thrown into the deep end before you're actually ready.

### Recommended Study Order

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

### A Note on Pacing
Don't rush stages 1–6; they form the mental model everything else depends on. Most beginners who feel "lost" in Kubernetes/Terraform pipelines later actually have a gap somewhere in stages 1–6 (usually around Pipeline syntax or Credentials), not in the advanced material itself. If something in Part 2 or 3 of this handbook feels confusing, it's often worth revisiting the corresponding fundamental in Part 1 first.

**What You Should Remember:** Learn Jenkins in the order real production systems are built — concepts, then a working single job, then pipelines-as-code, then scaling/security, then automation of the whole delivery chain. Trying to jump straight to Kubernetes/Terraform pipelines before understanding the basics of agents and credentials is the most common beginner mistake.

---

*End of handbook — Part 3 of 3.*
