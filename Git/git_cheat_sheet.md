
---

## 📌 Table of Contents
1. [What is Git & Version Control?](#1-what-is-git--version-control)
2. [Git vs GitHub](#2-git-vs-github)
3. [Git Architecture — Local vs Remote](#3-git-architecture--local-vs-remote)
4. [Installing Git](#4-installing-git)
5. [git init — Initialize Repository](#5-git-init--initialize-repository)
6. [Creating Remote Repository on GitHub](#6-creating-remote-repository-on-github)
7. [git clone — Clone a Repository](#7-git-clone--clone-a-repository)
8. [git status — Track Changes](#8-git-status--track-changes)
9. [git add — Staging Changes](#9-git-add--staging-changes)
10. [git commit — Save Changes Permanently](#10-git-commit--save-changes-permanently)
11. [git rm — Delete Files](#11-git-rm--delete-files)
12. [git log — View Commit History](#12-git-log--view-commit-history)
13. [git branch — Branching](#13-git-branch--branching)
14. [git checkout / git switch](#14-git-checkout--git-switch)
15. [git merge — Merging Branches](#15-git-merge--merging-branches)
16. [git push — Push to Remote](#16-git-push--push-to-remote)
17. [git pull & git fetch](#17-git-pull--git-fetch)
18. [git diff — Compare Changes](#18-git-diff--compare-changes)
19. [git stash — Save Work Temporarily](#19-git-stash--save-work-temporarily)
20. [git rebase — Rewrite Commit History](#20-git-rebase--rewrite-commit-history)
21. [git reset — Undo Changes](#21-git-reset--undo-changes)
22. [git revert — Safe Undo](#22-git-revert--safe-undo)
23. [git cherry-pick — Pick Specific Commits](#23-git-cherry-pick--pick-specific-commits)
24. [git reflog — Recovery Log](#24-git-reflog--recovery-log)
25. [git tag — Tagging Releases](#25-git-tag--tagging-releases)
26. [.gitignore — Ignore Files](#26-gitignore--ignore-files)
27. [GitHub — Pull Requests (PR)](#27-github--pull-requests-pr)
28. [Fork vs Clone](#28-fork-vs-clone)
29. [Branch Protection Rules](#29-branch-protection-rules)
30. [GitHub Actions — CI/CD Basics](#30-github-actions--cicd-basics)
31. [Webhooks](#31-webhooks)
32. [Best Practices — Production Level](#32-best-practices--production-level)
33. [🎯 Interview Preparation Section](#33-interview-preparation-section)

---

## 1. What is Git & Version Control?

### 📖 Concept Explanation
- **Git** is a **distributed version control system** that tracks every change you make to your files — who changed it, what changed, when, and where.
- It solves the critical problem of **losing previous versions** of code. If a client asks to revert to an older version, Git makes it possible in seconds.
- Git works on **almost any file type** — code (Python, JS, PHP), text files, images, even videos.
- Created by **Linus Torvalds** (the same person who built Linux).
- Once initialized, Git silently watches your project 24/7 and records every modification.

### 🔑 Why It Matters in DevOps
- Enables **CI/CD pipelines** — every push triggers automated build, test, and deploy.
- Provides **audit trail** for compliance and incident review.
- Allows **rollback** of bad deployments instantly.
- Foundation of **Infrastructure as Code (IaC)** with Terraform, Ansible, Kubernetes manifests.

### ✅ When to Use
- Every software project, always — no exceptions in production.

### ❌ When NOT to Use
- Do not store large binary files (videos, datasets) directly — use Git LFS instead.

---

## 2. Git vs GitHub

### 📖 Concept Explanation
| Feature | Git | GitHub |
|---|---|---|
| What is it? | Tool running locally on your machine | Cloud platform (remote server) |
| Purpose | Track changes, manage versions | Host & share repositories online |
| Works offline? | ✅ Yes | ❌ No |
| Owner | Open Source (Linux Foundation) | Microsoft |
| Alternatives | — | GitLab, Bitbucket |

> **Analogy:** Git is the coffee ☕. GitHub is the coffee shop 🏪 where that coffee is served.

### 🔑 Key Point
- GitHub is **not** required to use Git. You can use Git 100% locally.
- GitHub becomes essential when working in **teams** or using **CI/CD pipelines**.
- Other platforms: **GitLab** (popular in enterprises), **Bitbucket** (Atlassian ecosystem).

---

## 3. Git Architecture — Local vs Remote

### 📖 Concept Explanation
Working Directory → Staging Area (Index) → Local Repository → Remote Repository (GitHub)

text

| Area | Description |
|---|---|
| **Working Directory** | Where you edit files on your machine |
| **Staging Area (Index)** | Temporary holding area — changes ready to commit |
| **Local Repository** | `.git` folder — permanently saved commit history |
| **Remote Repository** | GitHub/GitLab — cloud backup for collaboration |

### 🔑 Git Internals
- When you run `git init`, Git creates a hidden `.git` folder — this is the **brain** of your repository.
- Inside `.git`, Git stores:
  - **Blob objects** → actual file content
  - **Tree objects** → directory structure
  - **Commit objects** → snapshot with message, author, timestamp, parent commit hash
- **HEAD** → a pointer to the current branch/commit you are on.
- **Commit Hash** → a unique SHA-1 string like `a3f9bc2...` that identifies every commit.

### 📦 Real-World DevOps Scenario
> Your team is working on a Kubernetes deployment. Each member pushes changes to GitHub. Jenkins picks up the push webhook, runs tests, builds Docker image, and deploys to AWS EKS — all triggered from a single `git push`.

---

## 4. Installing Git

### 💻 Installation Commands

**Verify after install:**
```bash
git --version
# Output: git version 2.x.x
```

**Windows:** Download installer from https://git-scm.com  
**Mac:**
```bash
brew install git
```
**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install git -y
```

### ⚙️ First-Time Global Configuration (Mandatory)
```bash
git config --global user.name "BHADRESH H"
git config --global user.email "bhadresh@example.com"

# Verify config
git config --list
```

> Use `--local` instead of `--global` to set config only for a specific project.

### ⚠️ Common Mistake
- Forgetting to configure user before first commit causes error: **"Please tell me who you are"**
- Fix: Run the two config commands above.

---

## 5. git init — Initialize Repository

### 📖 Concept Explanation
- `git init` tells Git: **"Start tracking this folder."**
- Creates a hidden `.git` directory — Git's internal storage.
- Use this to start a brand-new Git project locally.

### 📟 Command Syntax
```bash
mkdir my-project
cd my-project
git init
# Output: Initialized empty Git repository in /my-project/.git/
```

**Verify the .git folder exists:**
```bash
ls -la
# You'll see: .git/
```

### 🔑 Internals
- `.git/` contains: `HEAD`, `config`, `objects/`, `refs/` — entire history lives here.
- Delete `.git/` → Git stops tracking. Project becomes normal folder.

### 🏭 DevOps Scenario
> Creating a new Terraform project for AWS infra:
```bash
mkdir aws-infra-terraform
cd aws-infra-terraform
git init
git remote add origin https://github.com/bhadresh/aws-infra.git
```

### ⚠️ Common Mistake
- Running `git init` inside home directory `~` by accident — Git will track everything on your machine.
- Fix: Always `cd` into your project folder **before** running `git init`.

---

## 6. Creating Remote Repository on GitHub

### 📖 Steps
1. Go to https://github.com
2. Click **New** (green button)
3. Enter repository name (e.g., `git-journey`)
4. Set visibility: Public or Private
5. Click **Create Repository**

### 📟 Connect Local Repo to Remote
```bash
git remote add origin https://github.com/username/git-journey.git
git branch -M main
git push -u origin main
```

### 🔑 Key Points
- `origin` is just an **alias** (nickname) for the remote URL.
- You can rename it: `git remote rename origin upstream`
- View remotes: `git remote -v`

---

## 7. git clone — Clone a Repository

### 📖 Concept Explanation
- `git clone` downloads a remote repository to your local machine — **complete with full history**.
- Unlike `git init`, no setup needed — Git knows the remote automatically.
- Creates a `.git` folder just like `git init`.

### 📟 Command Syntax
```bash
git clone https://github.com/username/git-journey.git

# Clone into a specific folder name
git clone https://github.com/username/git-journey.git my-local-folder

# Clone a specific branch
git clone -b develop https://github.com/username/repo.git
```

### 🏭 DevOps Scenario
> New team member joins. They clone the repo to set up their local dev environment:
```bash
git clone https://github.com/company/k8s-manifests.git
cd k8s-manifests
kubectl apply -f deployment.yaml
```

### ⚠️ Common Mistakes
- Cloning with HTTPS but not setting up credentials (use SSH keys in production).
- Confusing **clone** with **fork** (fork is GitHub-level copy, clone is local copy).

---

## 8. git status — Track Changes

### 📖 Concept Explanation
- Shows the **current state** of your working directory and staging area.
- Tells you: What's modified? What's staged? What's untracked?
- Use it constantly — before every `git add` and `git commit`.

### 📟 Command Syntax
```bash
git status

# Short format
git status -s
```

### 🔑 Status Meanings
| Status | Meaning |
|---|---|
| `Untracked` | New file Git hasn't seen before |
| `Modified` | Existing file changed but not staged |
| `Staged` | File added to staging area |
| `Clean` | No pending changes |

### 🏭 DevOps Scenario
> Before pushing Ansible playbooks to production, always run `git status` to make sure you're not accidentally committing debug changes or secrets.

---

## 9. git add — Staging Changes

### 📖 Concept Explanation
- Moves changes from **Working Directory → Staging Area**.
- Think of it as saying: *"I want THIS change to be part of the next commit."*
- Gives you **selective control** — you can stage only what's ready.

### 📟 Command Syntax — All Variations
```bash
# Stage everything (new, modified, deleted) from any directory
git add -A
git add --all

# Stage everything in CURRENT directory only (not deleted files from parent dirs)
git add .

# Stage a specific file
git add filename.txt

# Stage a file inside a folder
git add myfolder/filename.txt

# Stage all .txt files (new/modified only, NOT deleted)
git add *.txt

# Unstage everything (move back to working directory)
git reset
```

### 🔑 Key Differences (Interview Important)
| Command | Stages New? | Stages Modified? | Stages Deleted? | Scope |
|---|---|---|---|---|
| `git add -A` | ✅ | ✅ | ✅ | Entire repo |
| `git add .` | ✅ | ✅ | ✅ | Current dir only |
| `git add *` | ✅ | ✅ | ❌ | Current dir |

### 🏭 DevOps Scenario
> Staging only infrastructure changes before a deployment commit:
```bash
git add terraform/main.tf
git add terraform/variables.tf
git commit -m "feat: add RDS module for production"
```

### ⚠️ Common Mistakes
- Using `git add *` and missing deleted files — use `git add -A` instead.
- Staging secrets accidentally — always check `.gitignore` first.

---

## 10. git commit — Save Changes Permanently

### 📖 Concept Explanation
- Moves changes from **Staging Area → Local Repository**.
- Creates a permanent **snapshot** with a unique SHA-1 hash.
- Commit = a checkpoint you can always return to.
- Think of it like taking a photo of your project at a specific moment.

### 📟 Command Syntax
```bash
# Standard commit with message
git commit -m "feat: add login feature"

# Stage + commit in one step (tracked files only)
git commit -am "fix: correct typo in config"

# Amend last commit message (before pushing)
git commit --amend -m "fix: correct typo in nginx config"

# Undo last commit (keep changes in working dir)
git reset HEAD~1

# Undo last commit and keep changes staged
git reset --soft HEAD~1
```

### 🔑 Internals
- Each commit stores: tree hash, parent commit hash, author, timestamp, message.
- **HEAD** always points to the latest commit on the current branch.

### 🏭 DevOps Scenario
```bash
# Feature development workflow
git checkout -b feature/auth-service
# ... make changes to code ...
git add .
git commit -m "feat: implement JWT authentication"
git push origin feature/auth-service
# → Raise PR → Review → Merge to main → GitHub Actions deploys to AWS
```

### ✅ Commit Message Best Practices (Conventional Commits)
feat: add user authentication
fix: resolve null pointer in payment service
docs: update README with setup instructions
chore: upgrade node version to 20
ci: add GitHub Actions workflow for testing

text

### ⚠️ Common Mistakes
- Vague messages like `"fix stuff"` or `"changes"` — makes debugging impossible.
- Committing directly to `main` branch in team projects.
- Committing secrets/passwords — use `.gitignore` and `git-secrets`.

---

## 11. git rm — Delete Files

### 📖 Concept Explanation
- Deletes a file AND stages the deletion in one command.
- Without `git rm`, you'd manually delete + `git add` the deletion separately.

### 📟 Command Syntax
```bash
# Delete file and stage deletion
git rm filename.txt

# Force delete (file has uncommitted changes)
git rm -f filename.txt

# Remove from staging/tracking but KEEP file on disk
git rm --cached filename.txt

# Recursively delete a folder
git rm -r foldername/

# Restore everything (files + changes) after accidental deletion
git reset --hard
```

### 🔑 Key Differences
| Command | Deletes File? | Removes from Staging? |
|---|---|---|
| `git rm file` | ✅ | ✅ |
| `git rm -f file` | ✅ (force) | ✅ |
| `git rm --cached file` | ❌ (keeps on disk) | ✅ |

### 🏭 DevOps Scenario
> Accidentally committed a `.env` file? Stop tracking it without deleting:
```bash
git rm --cached .env
echo ".env" >> .gitignore
git commit -m "chore: stop tracking .env file"
git push
```

### ⚠️ Common Mistakes
- `git rm` fails with "local modifications" error — use `-f` only if you're sure.
- `git reset` (without `--hard`) doesn't restore deleted files — must use `--hard`.

---

## 12. git log — View Commit History

### 📖 Concept Explanation
- Shows the **full commit history** of the repository.
- Each entry shows: commit hash, author, date, message.
- Used for auditing, debugging, and finding commit IDs to rollback.

### 📟 Command Syntax
```bash
# Full log
git log

# Compact one-line format (best for quick review)
git log --oneline

# Graph view (shows branching visually)
git log --oneline --graph --all

# Log for specific file
git log filename.txt

# Log by author
git log --author="BHADRESH"

# Last N commits
git log -5
```

### 🏭 DevOps Scenario
> Deployment broke in production. Find the last working commit:
```bash
git log --oneline
# a3f9bc2 feat: add payment gateway
# b1c4d3e fix: resolve DB timeout issue  ← last working
# 7e2f1a0 chore: update dependencies

git reset --hard b1c4d3e   # Roll back to this commit
```

### ⚠️ Common Mistake
- Forgetting commit IDs — always keep `git log --oneline` handy before a risky operation.

---

## 13. git branch — Branching

### 📖 Concept Explanation
- A **branch** is an independent line of development — like a parallel universe for your code.
- Default branch is called **main** (was `master` in older Git versions).
- Branches allow teams to work on features, bug fixes, and releases **without affecting main**.
- Internally, a branch is just a **lightweight pointer** to a commit.

### 📟 Command Syntax
```bash
# List all branches
git branch

# List remote branches
git branch -r

# List all (local + remote)
git branch -a

# Create a new branch
git branch feature-login

# Delete a branch (merged)
git branch -d feature-login

# Force delete (unmerged)
git branch -D feature-login

# Rename current branch
git branch -m new-branch-name
```

### 🏭 DevOps Production Branching Strategy
main → Production-ready code only
develop → Integration branch for features
feature/* → Individual feature development
hotfix/* → Emergency production fixes
release/* → Release preparation

text

```bash
# Create feature branch
git branch feature/user-authentication
git checkout feature/user-authentication

# Create hotfix branch from main
git checkout main
git checkout -b hotfix/fix-null-pointer
```

### 🔑 Internals
- A branch is stored in `.git/refs/heads/branchname` — it's simply a file containing the latest commit hash.
- Creating a branch is instantaneous — Git just writes a new pointer.

### ⚠️ Common Mistakes
- Working directly on `main` — always create a feature branch.
- Forgetting to switch to the new branch after creating it — use `git checkout -b` instead.

---

## 14. git checkout / git switch

### 📖 Concept Explanation
- `git checkout` switches between branches OR restores files.
- `git switch` (modern, Git 2.23+) is dedicated to switching branches — cleaner syntax.

### 📟 Command Syntax
```bash
# Switch to existing branch
git checkout develop
git switch develop            # Modern syntax

# Create and switch in one step
git checkout -b feature-login
git switch -c feature-login   # Modern syntax

# Restore a file to last committed state (discard changes)
git checkout -- filename.txt

# Checkout a specific commit (detached HEAD state)
git checkout a3f9bc2
```

### 🔑 Detached HEAD — What is it?
- When you checkout a **commit hash** (not a branch), you enter **Detached HEAD state**.
- HEAD no longer points to a branch — it points directly to a commit.
- Any commits made here are **not attached to any branch** and will be lost unless you create a branch.

```bash
# Fix detached HEAD
git checkout -b recovery-branch   # Create branch from detached state
```

### ⚠️ Common Mistakes
- Checking out a commit hash for debugging and making commits — those commits get lost.
- Forgetting which branch you're on — always run `git branch` or check prompt.

---

## 15. git merge — Merging Branches

### 📖 Concept Explanation
- Combines two branches into one — integrates changes from a feature branch back to main.
- Two types: **Fast-forward** and **Non-fast-forward (merge commit)**.

### 📟 Command Syntax
```bash
# Switch to target branch first
git checkout main

# Merge feature branch into main
git merge feature-login

# Merge with explicit merge commit (no fast-forward)
git merge --no-ff feature-login

# Abort a conflicting merge
git merge --abort
```

### 🔑 Internals — Fast-Forward vs Non-Fast-Forward
| Type | When | Result |
|---|---|---|
| **Fast-Forward** | No new commits on main since branch was created | Moves main pointer forward — no merge commit |
| **Non-Fast-Forward** | New commits on both branches | Creates a new merge commit |
Fast-Forward:
main: A → B
feature: → C → D

After merge:
main: A → B → C → D (pointer just moves)

Non-Fast-Forward:
main: A → B → E
feature: → C → D

After merge:
main: A → B → E → M (merge commit)
↗
C → D

text

### 🏭 DevOps Scenario
```bash
# Developer flow
git checkout main
git pull origin main
git merge --no-ff feature/auth
git push origin main
# → Jenkins webhook triggers → Docker build → AWS ECS deploy
```

### ⚠️ Merge Conflicts
- Happen when two branches edit the **same line** of the same file.
```bash
# Git marks conflict in file:
<<<<<<< HEAD
code from main
=======
code from feature branch
>>>>>>> feature-login

# Fix: Edit file manually, then:
git add conflicted-file.txt
git commit -m "fix: resolve merge conflict in auth module"
```

---

## 16. git push — Push to Remote

### 📖 Concept Explanation
- Uploads your local commits to the remote repository (GitHub).
- Shares your work with the team.
- Triggers CI/CD pipelines (GitHub Actions, Jenkins via webhooks).

### 📟 Command Syntax
```bash
# First push (set upstream)
git push -u origin main

# Subsequent pushes
git push

# Push specific branch
git push origin feature-login

# Push all branches
git push --all origin

# Force push (DANGEROUS — rewrites remote history)
git push --force origin feature-login

# Delete remote branch
git push origin --delete feature-login
```

### ⚠️ Common Mistakes
- **Force pushing to main** — this rewrites history and can break teammates' repos.
  - Fix: Enable branch protection on main to block force pushes.
- **Pushing without pulling** → rejected push (diverged histories).
  - Fix: Always `git pull --rebase` before pushing.

---

## 17. git pull & git fetch

### 📖 Concept Explanation
| Command | What it does |
|---|---|
| `git fetch` | Downloads remote changes but does NOT merge them |
| `git pull` | Downloads + merges (= fetch + merge) |

Use `fetch` when you want to inspect before merging. Use `pull` for daily sync.

### 📟 Command Syntax
```bash
# Pull and merge
git pull origin main

# Pull with rebase (cleaner history)
git pull --rebase origin main

# Fetch only (inspect before merging)
git fetch origin
git diff main origin/main    # See what changed
git merge origin/main        # Then merge manually
```

### 🏭 DevOps Scenario
> Start of every workday:
```bash
git checkout main
git pull origin main          # Sync latest prod code
git checkout -b feature/my-task
# Start working...
```

### ⚠️ Common Mistake
- Starting feature work without pulling main → creates divergence → harder merge later.

---

## 18. git diff — Compare Changes

### 📖 Concept Explanation
- Shows **line-by-line differences** between working directory, staging, commits, or branches.

### 📟 Command Syntax
```bash
# Changes in working dir vs last commit
git diff

# Changes in staging vs last commit
git diff --staged

# Compare two commits
git diff abc1234 def5678

# Compare two branches
git diff main feature-login

# Compare specific file
git diff filename.txt
```

### 🏭 DevOps Scenario
> Before raising a PR, review exactly what changed:
```bash
git diff main feature/k8s-update
```

---

## 19. git stash — Save Work Temporarily

### 📖 Concept Explanation
- Saves your **uncommitted changes** in a temporary stack and reverts working directory to clean state.
- Useful when you need to switch branches urgently without committing unfinished work.
- Think of it as a **clipboard** for your incomplete changes.

### 📟 Command Syntax
```bash
# Stash current changes
git stash

# Stash with a descriptive name
git stash save "WIP: adding payment API"

# List all stashes
git stash list

# Apply latest stash (keeps stash in stack)
git stash apply

# Apply and remove from stack
git stash pop

# Apply specific stash
git stash apply stash@{2}

# Delete a specific stash
git stash drop stash@{0}

# Clear all stashes
git stash clear
```

### 🏭 DevOps Scenario
> You're mid-feature when a PROD bug alert comes in:
```bash
git stash save "WIP: half-done auth feature"
git checkout main
git checkout -b hotfix/payment-null-pointer
# Fix the bug...
git commit -m "fix: resolve payment null pointer"
git push origin hotfix/payment-null-pointer
# Then back to feature:
git checkout feature/auth
git stash pop
```

### ⚠️ Common Mistakes
- Forgetting about old stashes — run `git stash list` regularly.
- Stash doesn't save untracked files by default — use `git stash -u` to include them.

---

## 20. git rebase — Rewrite Commit History

### 📖 Concept Explanation
- Re-applies your branch commits **on top of another branch** — creates a cleaner, linear history.
- Unlike merge (creates a merge commit), rebase **replays** commits one by one.
- Rewrites commit hashes — so **never rebase shared/public branches**.

### 📟 Command Syntax
```bash
# Rebase current branch onto main
git checkout feature-login
git rebase main

# Interactive rebase (squash, edit, reorder commits)
git rebase -i HEAD~3

# Abort ongoing rebase
git rebase --abort

# Continue after resolving conflicts
git rebase --continue
```

### 🔑 Rebase vs Merge — Critical Comparison (Interview)
| Feature | Merge | Rebase |
|---|---|---|
| History | Preserves full history | Creates linear history |
| Merge commit | ✅ Created | ❌ Not created |
| Safe on public branches? | ✅ Yes | ❌ No |
| Conflict handling | Once | Per commit replayed |
| Use case | Feature integration | Cleaning up feature branch before PR |

### 🔑 Interactive Rebase — Squash Commits
```bash
git rebase -i HEAD~3
# Opens editor:
pick a1b2c3 first commit
squash d4e5f6 second commit
squash g7h8i9 third commit
# → Squash all 3 into 1 clean commit
```

### 🏭 DevOps Scenario
> Before merging a feature PR, clean up messy commits:
```bash
git rebase -i HEAD~5   # Squash 5 WIP commits into 1
git push --force-with-lease origin feature-login   # Safe force push
```

### ⚠️ Common Mistakes
- Rebasing `main` or any shared branch → forces all teammates to reset their repos.
- Rule: **Never rebase after pushing** unless it's your own feature branch.

---

## 21. git reset — Undo Changes

### 📖 Concept Explanation
- Moves HEAD backwards, undoing commits. Three modes depending on what you want to keep.

### 📟 Command Syntax
```bash
# Unstage all (keep changes in working dir)
git reset

# Undo last commit (keep changes in working dir — SAFE)
git reset HEAD~1
git reset --mixed HEAD~1    # Same as above (default)

# Undo last commit and keep changes staged
git reset --soft HEAD~1

# Undo last commit AND discard all changes (DESTRUCTIVE)
git reset --hard HEAD~1

# Reset to specific commit
git reset --hard a3f9bc2
```

### 🔑 Three Modes of Reset (Interview Favourite)
| Mode | Undoes Commit? | Keeps Changes Staged? | Keeps Changes in Workdir? |
|---|---|---|---|
| `--soft` | ✅ | ✅ | ✅ |
| `--mixed` (default) | ✅ | ❌ | ✅ |
| `--hard` | ✅ | ❌ | ❌ |

### 🏭 DevOps Scenario
> Accidentally committed a wrong config:
```bash
git reset --soft HEAD~1
# Fix config file
git add .
git commit -m "fix: correct staging DB URL"
```

### ⚠️ Common Mistakes
- `git reset --hard` without backup — all uncommitted changes are **gone forever**.
- Using reset on pushed commits → teammates' history diverges.
  - Fix: Use `git revert` instead for pushed commits.

---

## 22. git revert — Safe Undo

### 📖 Concept Explanation
- Creates a **new commit** that reverses the changes of a previous commit.
- **Safe** — does not rewrite history. Ideal for undoing changes already pushed to remote.

### 📟 Command Syntax
```bash
# Revert the last commit
git revert HEAD

# Revert a specific commit
git revert a3f9bc2

# Revert without auto-commit (stage only)
git revert --no-commit a3f9bc2
```

### 🔑 Reset vs Revert (Interview Must-Know)
| Feature | `git reset` | `git revert` |
|---|---|---|
| Rewrites history? | ✅ Yes | ❌ No |
| Safe after push? | ❌ No | ✅ Yes |
| Creates new commit? | ❌ No | ✅ Yes |
| Use case | Undo local commits | Undo published commits |

### 🏭 DevOps Scenario
> A bad commit was merged and deployed to production:
```bash
git revert a3f9bc2
git push origin main
# → Triggers pipeline → Deploys reverted code → Production restored ✅
```

---

## 23. git cherry-pick — Pick Specific Commits

### 📖 Concept Explanation
- Applies a **specific commit** from one branch to another without merging the whole branch.
- Like picking one apple from a tree without taking the whole branch.

### 📟 Command Syntax
```bash
# Apply a specific commit to current branch
git cherry-pick a3f9bc2

# Cherry-pick without auto-committing
git cherry-pick --no-commit a3f9bc2

# Cherry-pick a range
git cherry-pick abc123..def456
```

### 🏭 DevOps Scenario
> A hotfix was applied on `hotfix` branch but you need the same fix on `develop`:
```bash
git checkout develop
git cherry-pick a3f9bc2   # Hotfix commit hash
git push origin develop
```

---

## 24. git reflog — Recovery Log

### 📖 Concept Explanation
- `reflog` records every movement of HEAD — even if commits are "deleted" via reset.
- Your **ultimate recovery tool** — saves you from almost any Git disaster.
- Reflog entries expire after ~90 days.

### 📟 Command Syntax
```bash
# View all HEAD movements
git reflog

# Recover to a specific state
git reset --hard HEAD@{3}

# Recover a deleted branch using reflog
git reflog
git checkout -b recovered-branch abc1234
```

### 🏭 Recovery Scenarios
```bash
# Scenario 1: Accidentally ran git reset --hard
git reflog
# Find commit before reset (e.g., HEAD@{2})
git reset --hard HEAD@{2}    # Restore everything ✅

# Scenario 2: Accidentally deleted a branch
git reflog
git checkout -b feature-login abc1234   # Recreate from hash ✅
```

---

## 25. git tag — Tagging Releases

### 📖 Concept Explanation
- Tags mark a **specific commit** as important — typically a release version.
- Unlike branches, tags don't move. They're permanent markers.

### 📟 Command Syntax
```bash
# Create lightweight tag
git tag v1.0.0

# Create annotated tag (with message — preferred for releases)
git tag -a v1.0.0 -m "Production release v1.0.0"

# List all tags
git tag

# Push tags to remote
git push origin v1.0.0
git push origin --tags   # Push all tags

# Delete tag locally
git tag -d v1.0.0

# Delete remote tag
git push origin --delete v1.0.0
```

### 🏭 DevOps Scenario
> After a successful release to production:
```bash
git tag -a v2.3.0 -m "Release v2.3.0 — Payment gateway integration"
git push origin v2.3.0
# GitHub creates a Release entry; Jenkins pipeline deploys tagged build
```

---

## 26. .gitignore — Ignore Files

### 📖 Concept Explanation
- Tells Git which files/folders to **never track**.
- Prevents sensitive data, build artifacts, and IDE configs from being committed.

### 📄 Common .gitignore Patterns
```gitignore
# Secrets & Credentials
.env
*.pem
*.key
secrets.yaml

# Build artifacts
node_modules/
dist/
build/
target/
*.class

# IDE files
.idea/
.vscode/
*.iml

# OS files
.DS_Store
Thumbs.db

# Terraform
.terraform/
*.tfstate
*.tfstate.backup

# Logs
*.log
logs/
```

### 📟 Commands
```bash
# Create .gitignore
touch .gitignore

# Stop tracking a file already committed
git rm --cached .env
echo ".env" >> .gitignore
git commit -m "chore: remove .env from tracking"
```

### ⚠️ Common Mistake
- Adding `.gitignore` AFTER secrets are already committed — they're still in history!
- Fix: Use `git filter-branch` or `BFG Repo-Cleaner` to purge secrets from history. Rotate the secrets immediately.

---

## 27. GitHub — Pull Requests (PR)

### 📖 Concept Explanation
- A **Pull Request (PR)** is a request to merge your branch into another (usually `main`).
- Enables **code review** before changes reach production.
- Central to **team collaboration** and **CI/CD gates**.

### 🏭 Complete PR Workflow
Developer creates feature branch locally

Makes commits, pushes to GitHub

Opens PR: feature/auth → main

GitHub Actions runs automated tests

Reviewers review code, leave comments

Developer addresses feedback, pushes fixes

Required reviewers approve

PR merged (squash/merge commit/rebase)

Branch deleted

CI/CD pipeline deploys to production

text

### 🔑 Merge Strategies
| Strategy | What it does | Use Case |
|---|---|---|
| **Merge Commit** | Creates a merge commit | Full history preservation |
| **Squash & Merge** | Squashes all PR commits to 1 | Clean main branch history |
| **Rebase & Merge** | Replays commits linearly | Clean linear history |

---

## 28. Fork vs Clone

### 📖 Concept Explanation
| | Fork | Clone |
|---|---|---|
| **Where** | GitHub (server-side copy) | Your local machine |
| **Purpose** | Contribute to someone else's repo | Work on any repo locally |
| **Connection to original** | Loose (via PR) | Direct (push/pull) |
| **Use case** | Open source contributions | Team project development |

### 🏭 Open Source Flow
Fork original repo → Clone your fork → Create branch →
Make changes → Push to your fork → Raise PR to original repo

text

---

## 29. Branch Protection Rules

### 📖 Concept Explanation
- GitHub settings that **protect important branches** (main, production) from direct pushes, force pushes, and unreviewed merges.

### ⚙️ Recommended Rules for Production
- ✅ Require pull request before merging
- ✅ Require at least 1 (or 2) approvals
- ✅ Require status checks to pass (CI tests)
- ✅ Require branches to be up to date before merging
- ✅ Block force pushes to main
- ✅ Block deletions of main

### 🏭 DevOps Scenario
> Set protection on `main` so no one (not even admins) can push directly. All changes go through PRs with CI passing.

---

## 30. GitHub Actions — CI/CD Basics

### 📖 Concept Explanation
- GitHub's built-in **CI/CD platform** — automates build, test, deploy on Git events.
- Defined in `.github/workflows/*.yml` files.

### 📄 Sample Workflow — Build & Deploy on Push
```yaml
# .github/workflows/deploy.yml
name: CI/CD Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '20'
    
    - name: Install dependencies
      run: npm install
    
    - name: Run tests
      run: npm test
    
    - name: Build Docker image
      run: docker build -t myapp:${{ github.sha }} .
    
    - name: Deploy to AWS ECS
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      run: |
        aws ecs update-service --cluster prod --service myapp
```

### 🔑 Key Concepts
- **Secrets** → Store credentials in `Settings → Secrets → Actions`, reference as `${{ secrets.MY_SECRET }}`
- **on:** → Trigger events (push, PR, schedule, manual)
- **jobs:** → Parallel or sequential tasks
- **steps:** → Individual actions within a job

---

## 31. Webhooks

### 📖 Concept Explanation
- GitHub sends an **HTTP POST** to your server when an event happens (push, PR, merge).
- Used to trigger **Jenkins builds**, deployment scripts, or notifications.

### 🏭 DevOps Scenario
Developer pushes to main
→ GitHub sends POST to Jenkins: http://jenkins.company.com/github-webhook/
→ Jenkins triggers pipeline
→ Build → Test → Deploy to AWS

text

**Setup:** GitHub Repo → Settings → Webhooks → Add webhook → Payload URL + Secret

---

## 32. Best Practices — Production Level

### 🌿 Branch Naming Conventions
feature/TICKET-123-user-auth
bugfix/TICKET-456-payment-null
hotfix/critical-login-crash
release/v2.3.0
chore/update-dependencies

text

### 💬 Commit Message Standards (Conventional Commits)
feat: add new feature
fix: bug fix
docs: documentation update
style: formatting, no logic change
refactor: code refactor
test: add/update tests
chore: maintenance tasks
ci: CI/CD changes

text

### 🏗️ Git Flow vs Trunk-Based Development
| | Git Flow | Trunk-Based |
|---|---|---|
| Branches | Many (feature, develop, release, hotfix, main) | Mostly one (main/trunk) |
| Release cycle | Scheduled | Continuous |
| Complexity | Higher | Lower |
| CI/CD fit | Medium | Best |
| Used by | Enterprise | Modern DevOps teams |

### 🛡️ Security Best Practices
- Never commit passwords, API keys, tokens.
- Always add `.env`, `*.pem`, `*.key` to `.gitignore` before writing secrets.
- Use **GitHub Secrets** for CI/CD credentials.
- Rotate secrets immediately if accidentally committed.
- Use `git-secrets` tool to scan commits for credentials.

### 📦 Repository Management
- Use tags for every production release.
- Archive old/unused repos instead of deleting.
- Use `git clone --depth=1` for shallow clones in CI pipelines (faster).
- Use `git lfs` (Large File Storage) for binary files > 50MB.

---

## 33. 🎯 Interview Preparation Section

### 📋 Common Git Interview Questions

**Q1: What is Git? How is it different from SVN?**
> Git is a **distributed** VCS — every developer has a full copy of the repo. SVN is **centralized** — only one central server. Git works offline; SVN needs server connection.

**Q2: What are the three areas of Git?**
> Working Directory → Staging Area (Index) → Local Repository → Remote Repository

**Q3: What is HEAD in Git?**
> HEAD is a pointer to the **current commit** on the current branch. When you commit, HEAD moves forward. In detached HEAD state, HEAD points directly to a commit hash, not a branch.

**Q4: What is the difference between `git fetch` and `git pull`?**
> `git fetch` downloads changes but does NOT merge. `git pull` = fetch + merge. Use fetch when you want to inspect before merging.

**Q5: What is the difference between `git merge` and `git rebase`?**
> Merge creates a merge commit preserving full history. Rebase replays commits creating linear history. Use merge for feature integration; use rebase to clean up local commits before PR. Never rebase shared branches.

**Q6: What is the difference between `git reset` and `git revert`?**
> `git reset` rewrites history by moving HEAD back — not safe after push. `git revert` creates a new commit that undoes changes — safe for pushed commits.

**Q7: What is a detached HEAD?**
> When you checkout a commit hash instead of a branch name. HEAD points to a commit, not a branch. Commits made here are lost unless you create a new branch.

**Q8: How do you recover a deleted branch?**
```bash
git reflog
git checkout -b recovered-branch <hash-from-reflog>
```

**Q9: How do you undo the last commit without losing changes?**
```bash
git reset --soft HEAD~1   # Keep changes staged
git reset HEAD~1          # Keep changes in working dir
```

**Q10: What is git stash and when do you use it?**
> `git stash` temporarily saves uncommitted changes and cleans working directory. Use it when you need to switch branches urgently without committing incomplete work.

---

### 🎭 Scenario-Based Questions

**Scenario 1:** You accidentally committed a password to GitHub. What do you do?
> 1. Immediately rotate/revoke the credential.  
> 2. `git rm --cached secretfile` and add to `.gitignore`.  
> 3. Use `BFG Repo-Cleaner` or `git filter-branch` to purge from history.  
> 4. Force push: `git push --force`.  
> 5. Alert security team.

**Scenario 2:** Production is down after a bad deployment. How do you rollback?
```bash
git log --oneline              # Find last good commit
git revert <bad-commit-hash>   # Safe undo
git push origin main           # Triggers pipeline re-deploy
```

**Scenario 3:** Two developers edited the same file. How do you resolve the conflict?
> Pull latest, merge conflict markers appear, manually edit file, `git add`, `git commit`.

**Scenario 4:** You need a hotfix from `hotfix` branch in `develop` branch. What do you do?
```bash
git checkout develop
git cherry-pick <hotfix-commit-hash>
```

---

### 📊 Quick Difference Reference Table

| Command | Purpose | Rewrites History? | Safe After Push? |
|---|---|---|---|
| `git reset --soft` | Undo commit, keep staged | ✅ | ❌ |
| `git reset --mixed` | Undo commit, keep in workdir | ✅ | ❌ |
| `git reset --hard` | Undo commit, discard all | ✅ | ❌ |
| `git revert` | Undo via new commit | ❌ | ✅ |
| `git merge` | Integrate branches | ❌ | ✅ |
| `git rebase` | Replay commits linearly | ✅ | ❌ (shared) |
| `git cherry-pick` | Copy specific commit | ❌ | ✅ |
| `git stash` | Temp save changes | ❌ | N/A |

---

*📝 Notes prepared by: BHADRESH H | DevOps Engineer*  
