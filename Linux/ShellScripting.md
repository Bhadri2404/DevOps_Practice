# 🐚 Shell Scripting for DevOps Engineers — Complete Master Guide

---

## 📋 Table of Contents

- [Introduction](#introduction)
- [Day 1 — Linux Architecture & Shell Scripting Basics](#day-1)
  - [Linux Architecture](#linux-architecture)
  - [What is a Shell?](#what-is-a-shell)
  - [How Shell Works Internally](#how-shell-works-internally)
  - [What is Scripting?](#what-is-scripting)
  - [Why Scripting in DevOps?](#why-scripting-in-devops)
  - [Real-World DevOps Scenarios](#real-world-devops-scenarios)
  - [What is Shell Scripting?](#what-is-shell-scripting)
  - [Shebang (#!)](#shebang)
  - [Types of Shells](#types-of-shells)
  - [Writing & Executing Your First Shell Script](#writing-and-executing-your-first-shell-script)
  - [Day 1 Summary](#day-1-summary)
- [Day 2 — Variables & Operators](#day-2)
  - [Variables in Shell Scripting](#variables-in-shell-scripting)
  - [Types of Variables](#types-of-variables)
  - [Temporary vs Permanent Variables](#temporary-vs-permanent-variables)
  - [Rules for Naming Variables](#rules-for-naming-variables)
  - [Operators](#operators)
  - [Arithmetic Operators](#arithmetic-operators)
  - [Relational / Comparison Operators](#relational-comparison-operators)
  - [Conditional Statements (if/elif/else)](#conditional-statements-day2)
  - [Day 2 Summary](#day-2-summary)
- [Day 3 — Loops (for & while)](#day-3)
  - [What Are Loops?](#what-are-loops)
  - [Types of Loops](#types-of-loops)
  - [For Loop](#for-loop)
  - [While Loop](#while-loop)
  - [Day 3 Summary](#day-3-summary)
- [Day 4 — Conditional Statements, Command Line Arguments & Functions](#day-4)
  - [Conditional Statements (Deep Dive)](#conditional-statements-deep-dive)
  - [Command Line Arguments](#command-line-arguments)
  - [Functions](#functions)
  - [Day 4 Summary](#day-4-summary)
- [Day 5 — Scheduling & Cron Jobs](#day-5)
  - [What is Scheduling?](#what-is-scheduling)
  - [Types of Scheduling in Linux](#types-of-scheduling-in-linux)
  - [One-Time Execution — at Command](#one-time-execution-at-command)
  - [Recurring Execution — Cron Jobs](#recurring-execution-cron-jobs)
  - [Cron Expression Format](#cron-expression-format)
  - [Configuring Cron Jobs with crontab](#configuring-cron-jobs-with-crontab)
  - [Day 5 Summary](#day-5-summary)
- [Day 6 — 25 Real-Time DevOps Shell Scripts](#day-6)
  - [Script 1: System Health Monitoring](#script-1)
  - [Script 2: Automated Log Cleanup](#script-2)
  - [Script 3: Backup and Restore](#script-3)
  - [Script 4: Kubernetes Pod Health Check](#script-4)
  - [Script 5: AWS S3 Bucket Sync](#script-5)
  - [Script 6: Check if a Service is Running](#script-6)
  - [Script 7: Find Top 5 Large Files](#script-7)
  - [Script 8: Show Active SSH Sessions](#script-8)
  - [Script 9: Check Disk Space and Alert](#script-9)
  - [Script 10: Simple User Creation](#script-10)
  - [Script 11: Find All Running Docker Containers](#script-11)
  - [Script 12: Delete Old Docker Images](#script-12)
  - [Script 13: Check Kubernetes Node Status](#script-13)
  - [Script 14: Trigger a Jenkins Job via CLI](#script-14)
  - [Script 15: Check Jenkins Job Status](#script-15)
  - [Script 16: Restart All Pods in a Namespace](#script-16)
  - [Script 17: Monitor Kubernetes Pod Status](#script-17)
  - [Script 18: Check System Uptime](#script-18)
  - [Script 19: Check Disk Space Usage](#script-19)
  - [Script 20: Check CPU & Memory Usage](#script-20)
  - [Script 21: Backup a Directory](#script-21)
  - [Script 22: Create User with Required Permissions](#script-22)
  - [Script 23: List AWS EC2 Instances with Public IPs](#script-23)
  - [Script 24: Backup Docker Containers and Images](#script-24)
  - [Script 25: SSL Certificate Expiry Checker (Bonus)](#script-25)
- [Debugging & Troubleshooting Shell Scripts](#debugging-and-troubleshooting)
- [Shell Scripting Best Practices](#best-practices)
- [Interview Questions & Answers — All Topics](#interview-questions)
- [Master Summary — Complete Handbook Recap](#master-summary)

---

<a name="introduction"></a>

## 🌟 Introduction

This is a **Professional DevOps Shell Scripting Master Guide** built for:

- DevOps & Cloud Engineers
- Linux System Administrators
- Automation Engineers
- CI/CD Pipeline Engineers
- Interview preparation (L1 → L3 levels)
- Anyone writing real-world production-grade shell scripts

This guide covers everything from **basic Linux architecture** to **25 real-world DevOps automation scripts**, explained step-by-step with examples, outputs, best practices, debugging tips, and interview Q&A.

> 💡 **How to use this guide:** Read sequentially if you're a beginner. Jump to specific sections if you're preparing for interviews or need a reference for a specific topic.

---

<a name="day-1"></a>

# 📅 Day 1 — Linux Architecture & Shell Scripting Basics

---

<a name="linux-architecture"></a>

## 🏗️ Linux Architecture

### What is it?

Linux architecture describes **how a user communicates with the hardware** of a computer. It is layered, meaning each layer has a specific role, and communication flows from top to bottom and back.

### The 4 Layers of Linux Architecture

```
┌──────────────────────────────────────────┐
│              USER                        │  ← You (gives instructions)
├──────────────────────────────────────────┤
│              SHELL                       │  ← Translates user commands
├──────────────────────────────────────────┤
│              KERNEL                      │  ← Core of the OS
├──────────────────────────────────────────┤
│              HARDWARE                    │  ← CPU, RAM, Disk, etc.
└──────────────────────────────────────────┘
```

### How Each Layer Works

| Layer | Role | Example |
|---|---|---|
| **User** | Gives instructions | Types `pwd` in terminal |
| **Shell** | Reads user input, checks syntax, translates to kernel language | Validates `pwd` command |
| **Kernel** | Core of OS, converts shell instructions to hardware instructions | Sends instruction to disk to find directory |
| **Hardware** | Executes the physical operation | Returns directory path from disk |

### Why Does This Matter for DevOps?

As a DevOps engineer, you interact with the **shell** every day:
- Deploying applications
- Running pipelines
- Managing servers (EC2 instances, VMs)
- Executing automation scripts

Understanding this architecture helps you understand **why your commands work the way they do** and **how to debug them when they fail**.

### 🔎 Real-World Analogy

Think of it like ordering food at a restaurant:
- **You** = User (customer placing order)
- **Waiter** = Shell (takes your order, communicates with kitchen)
- **Chef** = Kernel (prepares the food based on the order)
- **Kitchen Equipment** = Hardware (the physical tools used to cook)

---

<a name="what-is-a-shell"></a>

## 🐚 What is a Shell?

### Simple Definition

A **shell** is an **interface** between you (the user) and the operating system kernel. It provides an **environment** where you can type and execute Linux commands.

When you open a terminal (like MobaXterm, PuTTY, or a simple terminal window) and connect to an EC2 instance, what you see is the **shell**.

### What Does Shell Do?

1. **Reads** the command you typed
2. **Checks** the syntax (is the command valid?)
3. **Translates** the command into kernel-understandable language
4. **Passes** it to the kernel
5. **Returns** the output to you

```bash
# Example: User types this command
pwd

# Shell reads "pwd"
# Shell checks: valid command? YES
# Shell translates → kernel understands
# Kernel asks hardware: what is current directory?
# Output: /home/ec2-user
```

---

<a name="how-shell-works-internally"></a>

## ⚙️ How Shell Works Internally

### Step-by-Step Process

```
User Types Command
        ↓
Shell READS the command
        ↓
Shell CHECKS the syntax
        ↓
   Is syntax correct?
   /          \
 YES           NO
  ↓             ↓
Shell converts   Shell prints error
to kernel        (e.g., "command not found")
language
  ↓
Kernel receives instruction
  ↓
Kernel converts to hardware instruction
  ↓
Hardware executes
  ↓
Output returned to user
```

### Example with `pwd` command

```bash
# You type:
pwd

# Internal process:
# 1. Shell reads: "pwd"
# 2. Shell checks: is "pwd" a valid command? YES
# 3. Shell converts to kernel request
# 4. Kernel asks hardware: find current working directory
# 5. Hardware returns path from disk
# 6. Shell displays: /home/ec2-user
```

---

<a name="what-is-scripting"></a>

## 📝 What is Scripting?

### Simple Definition

> **Scripting** = Writing a series of commands in a file that can be executed to automate tasks.

### Without Scripting (Manual Way)

Imagine you need to run these commands every morning as a DevOps engineer:

```bash
whoami        # Check who I am
pwd           # Check current directory
date          # Check today's date
cal 2025      # See calendar
ls -l         # List files
df -h         # Check disk usage
free -m       # Check memory usage
```

Running 7 commands **every single day manually** is:
- Time-consuming
- Error-prone (you might forget one)
- Not scalable

### With Scripting (Automated Way)

You write all 7 commands in ONE file and execute the file:

```bash
# File: morning_check.sh
# Execute: sh morning_check.sh
# Result: All 7 commands run automatically!
```

### Key Concept

```
Manual way:       Type commands one by one → 7 minutes → human error possible
Scripting way:    Execute ONE file         → 3 seconds → zero human error
```

---

<a name="why-scripting-in-devops"></a>

## 🎯 Why Scripting in DevOps?

### 4 Main Reasons

#### 1️⃣ Automation — Remove Repetitive Manual Work

```
Without Scripting:
   Day 1: Type 10 commands manually
   Day 2: Type same 10 commands again
   Day 3: Type same 10 commands again
   ... (forever)

With Scripting:
   Day 1: Write script once
   Day 2+: Execute script → Done in seconds
```

**Examples of repetitive tasks:**
- Taking server backups every morning
- Checking disk space every hour
- Analyzing log files daily
- Performing health checks every 5 minutes

#### 2️⃣ Efficiency — Save Time & Reduce Human Errors

- Instead of typing 10 commands, you run 1 script
- No risk of typing wrong commands under pressure
- Saves 10–15 minutes every day = hours per week

#### 3️⃣ Consistency — Same Result Every Time

```
Manual execution:
   Monday: Executed 10 commands ✅
   Tuesday: Forgot 2 commands ❌ (human error)
   Wednesday: Executed wrong order ❌

Script execution:
   Monday: All 10 commands in correct order ✅
   Tuesday: All 10 commands in correct order ✅
   Wednesday: All 10 commands in correct order ✅
```

#### 4️⃣ Monitoring & Maintenance

- Automated server health checks
- Automated backup creation
- Automated cleanup of old files
- Automated alerting when thresholds are breached

---

<a name="real-world-devops-scenarios"></a>

## 🌍 Real-World DevOps Scenarios for Scripting

| Scenario | What the Script Does |
|---|---|
| **Backup Automation** | Every morning at 9AM, backup all files to S3 |
| **Log Analysis** | Every hour, scan logs for errors and send alerts |
| **System Health Checks** | Every 5 mins, check CPU/memory/disk usage |
| **Deployment Automation** | On code push, automatically deploy to server |
| **Temp File Cleanup** | Every Sunday, delete temp files older than 7 days |
| **User Management** | Create 50 users with proper permissions in one run |
| **Docker Cleanup** | Daily, remove unused Docker images and containers |

---

<a name="what-is-shell-scripting"></a>

## 🔧 What is Shell Scripting?

### Definition

> **Shell Scripting** = The process of writing scripts using a shell (like Bash) to automate tasks in Linux/Unix environments.

### Shell Script File Extension

Shell script files use the `.sh` extension:

```
morning_check.sh
backup.sh
health_check.sh
deploy.sh
cleanup.sh
```

Just like:
- Word documents use `.docx`
- PDFs use `.pdf`
- Images use `.jpg`

Shell scripts use `.sh`

### What's Inside a Shell Script?

```bash
#!/bin/bash           # Shebang line (tells OS which shell to use)
whoami                # Command 1
pwd                   # Command 2
date                  # Command 3
cal 2025              # Command 4
ls -l                 # Command 5
```

---

<a name="shebang"></a>

## ❗ Shebang (`#!`)

### What is it?

The **shebang** is the **first line of every shell script**. It tells the operating system **which interpreter (shell) to use** to execute the script.

### Syntax

```bash
#!/bin/bash
```

Let's break this down:
- `#!` — This is called the "shebang" or "hashbang"
- `/bin/bash` — This is the path to the Bash shell on the system

### Is it Mandatory?

**No, it is not mandatory — but it is strongly recommended.**

Why recommended?
- It removes ambiguity about which shell will execute the script
- On different systems, the default shell may vary (sh, bash, zsh, etc.)
- It ensures **consistency and clarity**

### Examples

```bash
#!/bin/bash    # Use Bash shell (most common in DevOps)
#!/bin/sh      # Use Bourne shell
#!/bin/zsh     # Use Z shell
```

### Common Mistake

```bash
# Wrong (no shebang) — might run with wrong shell
whoami
pwd

# Correct (with shebang) — always uses bash
#!/bin/bash
whoami
pwd
```

---

<a name="types-of-shells"></a>

## 🐢 Types of Shells

| Shell | Full Name | Command | Notes |
|---|---|---|---|
| **Bash** | Bourne Again Shell | `/bin/bash` | **Default in Amazon Linux, CentOS, RHEL** — Most used in DevOps |
| **sh** | Bourne Shell | `/bin/sh` | Original Unix shell |
| **Zsh** | Z Shell | `/bin/zsh` | Popular on macOS (default since Catalina) |
| **Ksh** | Korn Shell | `/bin/ksh` | Used in enterprise Unix environments |
| **Csh** | C Shell | `/bin/csh` | Syntax similar to C programming language |

### Most Important for DevOps

```bash
# Amazon Linux / CentOS / RHEL → Default shell is Bash
/bin/bash

# Always use Bash for DevOps scripts unless you have a specific reason not to
```

---

<a name="writing-and-executing-your-first-shell-script"></a>

## ✍️ Writing & Executing Your First Shell Script

### Setting Up: Launch EC2 Instance

1. Go to AWS Console → EC2 → Launch Instance
2. Select: **Amazon Linux 2023 AMI**
3. Instance type: **t2.micro** (Free tier eligible)
4. Create a key pair (`.pem` file)
5. Connect using MobaXterm or PuTTY

### Script 1: Welcome Message (Interactive Script)

**Step 1: Create the file**

```bash
vi welcome.sh
```

**Step 2: Press `i` to enter Insert mode, then write:**

```bash
#!/bin/bash
# This is a welcome script that greets the user
# The shebang line tells the system to use Bash

echo "Enter Your Name: "
# echo → prints the message to screen
# This asks the user to type their name

read user_name
# read → reads input from the user
# user_name → stores the input in this variable

echo "Hello $user_name, Welcome to Shell Scripting Course by Kastro"
# echo → prints the greeting message
# $user_name → retrieves the value stored in user_name variable
# The $ symbol is used to access a variable's value
```

**Step 3: Save and exit**
```
Press Esc → type :wq → press Enter
```

**Step 4: Verify the file content**
```bash
cat welcome.sh
```

**Step 5: Execute the script — 3 Methods**

---

### 🔑 Method 1: Give Executable Permission Then Run

```bash
# Step 1: Give execute permission
sudo chmod +x welcome.sh
# chmod → change mode (permissions)
# +x    → add executable permission
# welcome.sh → the file to give permission to

# Step 2: Check permissions (x = executable, green color)
ls -l welcome.sh
# Output: -rwxr-xr-x 1 ec2-user ec2-user 93 Mar 1 welcome.sh

# Step 3: Run the script
./welcome.sh
# ./ → means "current directory"
# This tells shell to run welcome.sh from here
```

---

### 🔑 Method 2: Direct Execution with `sh`

```bash
sh welcome.sh
# sh → invoke the shell directly
# No permission needed
# Runs the script using the sh shell
```

---

### 🔑 Method 3: Direct Execution with `bash`

```bash
bash welcome.sh
# bash → invoke bash directly
# No permission needed
# Runs the script explicitly using bash shell
```

---

### Expected Output

```
Enter Your Name:
Castro Kiran
Hello Castro Kiran, Welcome to Shell Scripting Course by Kastro
```

---

### Script 2: Linux Commands Script

```bash
#!/bin/bash
# Script 2: Demonstrates running multiple Linux commands automatically
# All commands run when you execute this ONE file

echo "Executing simple Linux commands"
# Print a header message so user knows what's happening

whoami
# Prints the current user (e.g., ec2-user)

pwd
# Prints the present working directory (e.g., /home/ec2-user)

date
# Prints today's date and time

cal 2025
# Prints the full calendar for year 2025

mkdir Castro
# Creates a new directory named "Castro"

touch Castro.txt
# Creates a new empty file named "Castro.txt"
```

**Execute:**
```bash
sh linux_commands.sh
```

**Expected Output:**
```
Executing simple Linux commands
ec2-user
/home/ec2-user
Sat Mar  1 10:25:33 UTC 2025
   January 2025
Su Mo Tu We Th Fr Sa
          1  2  3  4
 5  6  7  8  9 10 11
...
(full 2025 calendar)
```

After running: `ls` shows `Castro` directory and `Castro.txt` file created!

---

### Script 3: System Details Script

```bash
#!/bin/bash
# Script 3: Displays basic system information
# Uses $() syntax to run commands and use their output as values

echo "Display basic system information"
# Header message

echo "Current User: $(whoami)"
# $(whoami) → runs whoami command and substitutes its output here
# Output: Current User: ec2-user

echo "Current Directory: $(pwd)"
# $(pwd) → runs pwd command and substitutes its output
# Output: Current Directory: /home/ec2-user

echo "Today's Date: $(date)"
# $(date) → runs date command and substitutes its output
# Output: Today's Date: Sat Mar 1 10:25:33 UTC 2025

echo "Calendar: $(cal)"
# $(cal) → runs cal command (shows current month's calendar)
# Output: Current month calendar
```

**Execute:**
```bash
bash system_details.sh
```

**Expected Output:**
```
Display basic system information
Current User: ec2-user
Current Directory: /home/ec2-user
Today's Date: Sat Mar  1 10:25:33 UTC 2025
Calendar:      March 2025
Su Mo Tu We Th Fr Sa
                   1
 2  3  4  5  6  7  8
...
```

---

<a name="day-1-summary"></a>

## 🔎 Day 1 Summary

| Concept | Key Takeaway |
|---|---|
| Linux Architecture | User → Shell → Kernel → Hardware |
| Shell | Interface between user and OS kernel |
| Scripting | Writing a series of commands in a file |
| Shell Scripting | Using a shell (Bash) to write automated scripts |
| Shebang | `#!/bin/bash` — first line of every script |
| `.sh` extension | Every shell script ends with `.sh` |
| 3 Execution Methods | `chmod +x` then `./`, or `sh`, or `bash` |

**5-Point Interview-Ready Recap:**

1. **Shell is an interface** — translates human commands to kernel language
2. **Scripting = automation** — write once, execute many times
3. **Shebang** tells the OS which interpreter to use
4. **Bash is the default** shell for Amazon Linux/CentOS/RHEL
5. **3 ways to execute:** chmod+x, sh, bash

**Production Takeaway:**  
In real DevOps environments, every automation task starts with a `.sh` file. Whether it's CI/CD, deployments, monitoring, or cleanup — it's all driven by shell scripts running on Linux servers.

---

<a name="day-2"></a>

# 📅 Day 2 — Variables & Operators

---

<a name="variables-in-shell-scripting"></a>

## 📦 Variables in Shell Scripting

### What is a Variable?

A **variable** is used to **store data in a key-value format**.

Think of it as a labelled box:
```
Box label: name        Box contents: Castro
Box label: age         Box contents: 30
Box label: role        Box contents: DevOps Engineer
```

In shell scripting:
```bash
name="Castro"        # key = name,   value = Castro
age=30               # key = age,    value = 30
role="DevOps Engineer"  # key = role, value = DevOps Engineer
```

### Why Do We Need Variables in DevOps?

1. **Store configuration values** — server IPs, paths, credentials
2. **Reuse values** — define once, use many times
3. **Dynamic scripts** — change behavior based on variable values
4. **Avoid hardcoding** — makes scripts maintainable

### Accessing Variables — The `$` Symbol

To **access (read) the value** stored in a variable, use `$` before the variable name:

```bash
name="Castro"        # Store value
echo $name           # Access value → prints: Castro
echo "Hello $name"   # Access inside string → prints: Hello Castro
```

### Variables Don't Need Data Types

Unlike Java (`String name = "Castro"`) or Python, shell variables **don't need explicit type declarations**:

```bash
# Shell scripting — no data types needed
name="Castro"        # string
age=30               # number
path="/home/ec2"     # path string
flag=true            # boolean-like

# All work the same way!
```

---

<a name="types-of-variables"></a>

## 🗂️ Types of Variables

### Type 1: System (Environment) Variables

**Definition:** Variables that are **pre-defined by the operating system itself**. The system creates and manages them automatically.

```bash
# Common system variables
echo $USER       # Currently logged in user → ec2-user
echo $HOME       # Home directory of user → /home/ec2-user
echo $PATH       # Directories searched for commands
echo $SHELL      # Current shell → /bin/bash
echo $PWD        # Present working directory
```

**See ALL system variables:**
```bash
env
# Lists all environment variables
# Output: SHELL=/bin/bash, USER=ec2-user, HOME=/home/ec2-user, ...
```

**How to create a system-level variable temporarily:**
```bash
export COURSE="Shell Scripting"
# export → makes variable available to current session
echo $COURSE
# Output: Shell Scripting
```

---

### Type 2: User-Defined Variables

**Definition:** Variables that **you create** in your scripts based on your needs.

```bash
# Creating user-defined variables (2 ways)

# Way 1: Without export (only available in current script)
name="Castro"
echo $name          # Works: Castro

# Way 2: With export (available to child processes)
export trainer="Castro Kiran"
echo $trainer       # Works: Castro Kiran
```

**Beginner Example:**

```bash
#!/bin/bash
# User-defined variables example

course="Shell Scripting"        # Define variable
trainer="Castro Kiran"          # Define variable
duration="6 Lectures"           # Define variable

# Access variables using $ symbol
echo "Course: $course"
echo "Trainer: $trainer"
echo "Duration: $duration"
```

**Output:**
```
Course: Shell Scripting
Trainer: Castro Kiran
Duration: 6 Lectures
```

---

<a name="temporary-vs-permanent-variables"></a>

## ⏳ Temporary vs Permanent Variables

This is **critical to understand** for production scripting.

### Temporary Variables

```bash
export MY_VAR="Hello DevOps"
echo $MY_VAR           # Works: Hello DevOps
```

**Problem:** When you close the terminal and reconnect → the variable is **GONE**.

```bash
# Terminal Session 1:
export MY_VAR="Hello DevOps"
echo $MY_VAR    # Hello DevOps ✅

# Close terminal → Reconnect
# Terminal Session 2:
echo $MY_VAR    # (empty) ❌ — Value is LOST
```

### Permanent Variables

To make a variable **persist across terminal sessions**, add it to `~/.bashrc`:

**Step 1: Open `.bashrc`**
```bash
vi ~/.bashrc
# ~/.bashrc is a configuration file that runs every time you open a terminal
```

**Step 2: Add your variable at the bottom**
```bash
export MY_COURSE="Shell Scripting by Castro"
export MY_ROLE="DevOps Engineer"
```

**Step 3: Press `Esc` → `:wq` → Enter to save**

**Step 4: Apply the changes (IMPORTANT!)**
```bash
source ~/.bashrc
# source → reloads the .bashrc file
# Without this, changes won't take effect in current session
```

**Step 5: Verify**
```bash
echo $MY_COURSE
# Output: Shell Scripting by Castro
# This will work EVEN after closing and reopening terminal!
```

**View `.bashrc` content:**
```bash
cat -n ~/.bashrc
# -n → shows line numbers
# You'll see your export lines at the bottom
```

### Removing a Variable — `unset`

```bash
export NAME="Castro"
echo $NAME           # Castro

unset NAME           # Remove the variable
echo $NAME           # (empty — variable no longer exists)
```

> ⚠️ **Note:** `unset` removes the variable from the current session but does NOT remove it from `.bashrc`. If you want permanent removal, edit `.bashrc` and remove the export line.

---

<a name="rules-for-naming-variables"></a>

## 📏 Rules for Naming Variables

### Rule 1: Cannot Start with a Digit

```bash
# WRONG ❌
1name="Castro"
123var="hello"

# CORRECT ✅
name1="Castro"
var123="hello"
```

### Rule 2: Cannot Contain `-`, `@`, or `#`

```bash
# WRONG ❌
my-name="Castro"      # Hyphen not allowed
my@var="value"        # @ not allowed
my#var="value"        # # not allowed

# CORRECT ✅
my_name="Castro"      # Underscore is ALLOWED
myvar="value"         # No special chars
```

### Rule 3: Convention — UPPERCASE for Environment, lowercase for user-defined

```bash
# Environment/System variables (convention: UPPERCASE)
export DATABASE_URL="mysql://localhost:3306"
export AWS_REGION="us-east-1"
export LOG_LEVEL="INFO"

# User-defined script variables (convention: lowercase)
name="Castro"
backup_dir="/home/ec2-user/backups"
count=0
```

> ⚠️ This is **convention, not a strict rule**. But following it makes your scripts readable and professional.

---

<a name="operators"></a>

## 🔢 Operators

An **operator** is used to **perform operations** on values — math calculations, comparisons, logical checks, etc.

### Types of Operators in Shell Scripting

| Type | Purpose | Example |
|---|---|---|
| **Arithmetic** | Math calculations | `+`, `-`, `*`, `/`, `%` |
| **Relational/Comparison** | Compare values | `==`, `!=`, `>`, `<`, `>=`, `<=` |
| **Logical** | Combine conditions | `&&`, `||`, `!` |
| **String** | Work with strings | `-z`, `-n`, `==` |
| **File Test** | Check file properties | `-f`, `-d`, `-e`, `-r`, `-w` |

---

<a name="arithmetic-operators"></a>

## ➕ Arithmetic Operators

### Operators Available

| Operator | Meaning | Example | Result |
|---|---|---|---|
| `+` | Addition | `$((10 + 5))` | `15` |
| `-` | Subtraction | `$((10 - 5))` | `5` |
| `*` | Multiplication | `$((10 * 5))` | `50` |
| `/` | Division | `$((10 / 3))` | `3` (integer only) |
| `%` | Modulus (remainder) | `$((10 % 3))` | `1` |

### Syntax — The Double Parentheses `$(( ))`

```bash
# Syntax for arithmetic operations
result=$(( expression ))

# Examples
echo $((100 + 200))      # 300
echo $((50 - 30))        # 20
echo $((10 * 10))        # 100
echo $((15 / 4))         # 3 (integer division, no decimals!)
echo $((15 % 4))         # 3 (remainder of 15 ÷ 4)
```

> ⚠️ **Important:** Shell arithmetic only works with **integers**. `10/3 = 3`, NOT `3.333...`. For decimal math, use `bc` or `awk`.

### Beginner Script: Add Two Fixed Numbers

```bash
#!/bin/bash
# Script: addition.sh
# Purpose: Adds two predefined numbers and displays result

num1=500              # First number stored in variable num1
num2=600              # Second number stored in variable num2

# Perform addition using $(( )) syntax
# num1 and num2 are accessed with $ inside the expression
sum=$(( num1 + num2))

# Print the result
echo "The result is: $sum"
# $sum retrieves the value we calculated and stored in sum variable
```

**Execute:**
```bash
sh addition.sh
```

**Output:**
```
The result is: 1100
```

---

### Interactive Script: Take Input from User

```bash
#!/bin/bash
# Script: add_dynamic.sh
# Purpose: Takes 3 numbers from user and calculates their sum

echo "Enter Num 1:"          # Prompt user to enter first number
read num1                    # read → captures user input and stores in num1

echo "Enter Num 2:"          # Prompt for second number
read num2                    # Store second number in num2

echo "Enter Num 3:"          # Prompt for third number
read num3                    # Store third number in num3

# Calculate sum of all three numbers
# $num1, $num2, $num3 → retrieve values from each variable
echo "The sum is: $(( num1 + num2 + num3 ))"
```

**Execute:**
```bash
sh add_dynamic.sh
```

**Expected Output:**
```
Enter Num 1:
10
Enter Num 2:
20
Enter Num 3:
30
The sum is: 60
```

---

### Script: Multiple Mathematical Operations

```bash
#!/bin/bash
# Script: multiple_operations.sh
# Purpose: Demonstrates all arithmetic operators

echo "Enter two numbers:"
read num1    # First number from user
read num2    # Second number from user

# Arithmetic operations using $(( )) syntax
sum=$(( num1 + num2 ))           # Addition
difference=$(( num1 - num2 ))    # Subtraction
product=$(( num1 * num2 ))       # Multiplication
division=$(( num1 / num2 ))      # Division (integer only)

# Display all results
echo "Sum is: $sum"
echo "Difference is: $difference"
echo "Product is: $product"
echo "Division is: $division"
```

**Execute:**
```bash
sh multiple_operations.sh
# Enter: 10 and 2
```

**Output:**
```
Enter two numbers:
10
2
Sum is: 12
Difference is: 8
Product is: 20
Division is: 5
```

> 💡 **Why does `10/20 = 0`?** Shell uses **integer arithmetic**. `10 ÷ 20 = 0.5`, but shell drops the decimal and shows `0`. To get `0.5`, use: `echo "scale=2; 10/20" | bc`

---

<a name="relational-comparison-operators"></a>

## ⚖️ Relational / Comparison Operators

### What Are They?

Used to **compare two values** and return `true` or `false`. These are used inside conditional statements (`if/elif/else`).

### Comparison Operators Reference

| Operator | Meaning | Numeric Use | String Use |
|---|---|---|---|
| `-eq` or `==` | Equal to | `[ 5 -eq 5 ]` | `[ "$a" == "$b" ]` |
| `-ne` or `!=` | Not equal to | `[ 5 -ne 3 ]` | `[ "$a" != "$b" ]` |
| `-gt` or `>` | Greater than | `[ 10 -gt 5 ]` | — |
| `-ge` or `>=` | Greater than or equal | `[ 10 -ge 10 ]` | — |
| `-lt` or `<` | Less than | `[ 5 -lt 10 ]` | — |
| `-le` or `<=` | Less than or equal | `[ 5 -le 5 ]` | — |

> 💡 **Best Practice for numbers:** Use `-eq`, `-ne`, `-gt`, `-ge`, `-lt`, `-le`  
> **For strings:** Use `==`, `!=`

---

<a name="conditional-statements-day2"></a>

## 🔀 Conditional Statements (`if/elif/else`)

### Syntax

```bash
if [ condition ]; then
    # Statements executed if condition is TRUE
elif [ condition ]; then
    # Statements executed if second condition is TRUE
else
    # Statements executed if ALL above conditions are FALSE
fi
# fi → closes the if block (if spelled backwards!)
```

### Beginner Example: Compare Two Numbers

```bash
#!/bin/bash
# Script: comparison.sh
# Purpose: Compares two numbers and tells which is greater

echo "Enter two numbers:"
read num1    # Get first number from user
read num2    # Get second number from user

# Check if both numbers are equal
if [ $num1 -eq $num2 ]; then
    echo "$num1 is equal to $num2"

# Check if first number is greater
elif [ $num1 -gt $num2 ]; then
    echo "$num1 is greater than $num2"

# If neither above, first must be less
else
    echo "$num1 is less than $num2"
fi
# fi → end the if-elif-else block
```

**Execute:**
```bash
sh comparison.sh
# Enter: 10 and 15
```

**Output:**
```
Enter two numbers:
10
15
10 is less than 15
```

---

### Script: Password Strength Checker

```bash
#!/bin/bash
# Script: password.sh
# Purpose: Checks password strength based on character count

echo "Enter your password:"
read password    # User types their password

# ${#password} → gets the LENGTH of the string stored in password
length=${#password}

# Check if password is weak (less than 8 characters)
if [ $length -lt 8 ]; then
    echo "Your password is WEAK (less than 8 characters)"

# Check if password is moderate (8 to 12 characters)
elif [ $length -ge 8 ] && [ $length -le 12 ]; then
    echo "Your password is MODERATE (between 8 to 12 characters)"

# Password is strong (more than 12 characters)
else
    echo "Your password is STRONG (more than 12 characters)"
fi
```

**Execute:**
```bash
sh password.sh
```

**Test Outputs:**

```
Enter your password:
abc123
Your password is WEAK (less than 8 characters)

Enter your password:
mypassword
Your password is MODERATE (between 8 to 12 characters)

Enter your password:
myverylongpassword123
Your password is STRONG (more than 12 characters)
```

---

### Script: Grade Calculator

```bash
#!/bin/bash
# Script: grade.sh
# Purpose: Calculates student grade based on score (0-100)

echo "Enter your score (0 to 100):"
read score    # User enters their exam score

# Grade A: 90 to 100
if [ $score -ge 90 ] && [ $score -le 100 ]; then
    echo "Your grade is: A (Excellent!)"

# Grade B: 80 to 89
elif [ $score -ge 80 ] && [ $score -lt 90 ]; then
    echo "Your grade is: B (Good!)"

# Grade C: 70 to 79
elif [ $score -ge 70 ] && [ $score -lt 80 ]; then
    echo "Your grade is: C (Average)"

# Grade D: 60 to 69
elif [ $score -ge 60 ] && [ $score -lt 70 ]; then
    echo "Your grade is: D (Below Average)"

# Grade E: Below 60 (Fail)
else
    echo "Your grade is: E (Fail — Please retake the exam)"
fi
```

**Execute:**
```bash
sh grade.sh
# Enter: 85
```

**Output:**
```
Enter your score (0 to 100):
85
Your grade is: B (Good!)
```

---

<a name="day-2-summary"></a>

## 🔎 Day 2 Summary

| Concept | Key Takeaway |
|---|---|
| Variables | Store data as key=value pairs |
| `$variable` | Access a variable's value using `$` |
| System Variables | Pre-defined by OS: `$USER`, `$HOME`, `$PATH` |
| User-Defined Variables | Created by you for your script's needs |
| Temporary Variables | Lost when terminal closes |
| Permanent Variables | Stored in `~/.bashrc`, use `source ~/.bashrc` |
| `unset` | Removes a variable from current session |
| Arithmetic | Uses `$(( ))` syntax, integers only |
| Comparison | `-eq`, `-ne`, `-gt`, `-ge`, `-lt`, `-le` |
| `if/elif/else/fi` | Core conditional structure |

**Interview-Ready Phrases:**

1. "Variables in Bash don't need data type declarations — they're dynamically typed."
2. "To make a variable permanent, add it to `.bashrc` and run `source ~/.bashrc`."
3. "Shell arithmetic uses `$(( ))` and works only with integers — for decimals, use `bc`."
4. "`fi` closes an `if` block in Bash — it's `if` spelled backwards."
5. "`${#variable}` gives the length of a string stored in that variable."

---

<a name="day-3"></a>

# 📅 Day 3 — Loops (for & while)

---

<a name="what-are-loops"></a>

## 🔄 What Are Loops?

### The Problem Without Loops

Imagine you want to print the message `"Welcome to Shell Scripting"` 15 times. Without loops, you'd write:

```bash
#!/bin/bash
echo "Welcome to Shell Scripting"
echo "Welcome to Shell Scripting"
echo "Welcome to Shell Scripting"
# ... 12 more times
echo "Welcome to Shell Scripting"   # 15th time
```

This is **terrible** for 15 repetitions. What about 100? Or 1000?

### The Solution: Loops

> **Loops** are used to **execute the same statement multiple times** until a condition is satisfied.

With a loop:
```bash
# This prints the message 15 times — writing echo ONCE
for (( i=1; i<=15; i++ ))
do
    echo "Welcome to Shell Scripting"
done
```

Write the statement **once**. Execute it **as many times as needed**.

---

<a name="types-of-loops"></a>

## 📊 Types of Loops

| Loop Type | Category | When to Use |
|---|---|---|
| `for` loop | Range-based | When you **KNOW** how many times to execute |
| `while` loop | Condition-based | When you **DON'T KNOW** the count but know the stopping condition |

### Range-Based vs Condition-Based

```
Range-based (for loop):
   "Print numbers from 1 to 15" → You KNOW the range is 1-15

Condition-based (while loop):
   "Keep asking for password until user enters the correct one"
   → You DON'T KNOW how many wrong attempts they'll make
   → But you know the CONDITION: stop when password is correct
```

---

<a name="for-loop"></a>

## 🔁 For Loop

### Syntax

```bash
for (( initialization; condition; modification ))
do
    # Statements to execute
done
```

**Breaking it down:**

| Part | Purpose | Example |
|---|---|---|
| **Initialization** | Starting value | `i=1` (start from 1) |
| **Condition** | When to keep looping | `i<=15` (keep going while i ≤ 15) |
| **Modification** | How to change the counter | `i++` (increase by 1 each time) |
| **do** | Start of the loop body | — |
| **done** | End of the loop | — |

### How it works internally

```
Step 1: i = 1 (initialization)
Step 2: Is 1 <= 15? YES → execute body → print 1
Step 3: i++ → i = 2
Step 4: Is 2 <= 15? YES → execute body → print 2
Step 5: i++ → i = 3
...
Step N: Is 16 <= 15? NO → STOP loop
```

---

### Beginner Script: Print Numbers 1 to 15

```bash
#!/bin/bash
# Script: file1.sh
# Purpose: Prints numbers from 1 to 15 using for loop

for (( k=1; k<=15; k++ ))
# k=1      → Initialize: start counting from 1
# k<=15    → Condition: keep looping while k is ≤ 15
# k++      → Modification: increase k by 1 after each iteration
do
    echo $k    # Print the current value of k
done
# done → marks the end of the for loop
```

**Execute:**
```bash
sh file1.sh
```

**Output:**
```
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
```

---

### What Happens Without `k++`?

```bash
# THIS IS WRONG — no modification step!
for (( k=1; k<=15; ))   # No k++ ← PROBLEM
do
    echo $k
done
# Result: Infinite loop! Prints "1" forever
# Press Ctrl+C to stop
```

**Why?** `k` stays `1` forever. `1 <= 15` is always true → loop never ends!

---

### Script: Print Numbers in Reverse (15 to 1)

```bash
#!/bin/bash
# Script: reverse.sh
# Purpose: Prints numbers from 15 down to 1 (countdown)

for (( k=15; k>=1; k-- ))
# k=15     → Initialize: start from 15
# k>=1     → Condition: keep looping while k is ≥ 1
# k--      → Modification: DECREASE k by 1 each time (-- means subtract 1)
do
    echo $k    # Print current value of k
done
```

**Output:**
```
15
14
13
...
2
1
```

---

### Script: Print All `.txt` Files in a Directory

```bash
#!/bin/bash
# Script: file2.sh
# Purpose: Lists all text files in current directory

for file in *.txt
# "*.txt" → matches ALL files ending in .txt in current directory
# Each matching file is stored in variable "file" one at a time
do
    echo "Text file found: $file"
    # $file → prints the name of each .txt file found
done
```

**Setup to test:**
```bash
touch a1.txt a2.txt a3.txt a4.txt a5.txt   # Create test files
touch script.py                              # Non-txt file
sh file2.sh                                  # Run script
```

**Output:**
```
Text file found: a1.txt
Text file found: a2.txt
Text file found: a3.txt
Text file found: a4.txt
Text file found: a5.txt
(script.py is NOT printed because it doesn't match *.txt)
```

---

### Script: Iterate Over a List of Items

```bash
#!/bin/bash
# Script: servers.sh
# Purpose: Perform a check on a list of server names

# List of servers to check
for server in web-server-1 web-server-2 db-server-1 cache-server
# Each item in the list is assigned to "server" variable one by one
do
    echo "Checking server: $server"
    # In real DevOps, you'd run ping or ssh commands here
    # Example: ping -c 1 $server
done
```

**Output:**
```
Checking server: web-server-1
Checking server: web-server-2
Checking server: db-server-1
Checking server: cache-server
```

---

<a name="while-loop"></a>

## 🔁 While Loop

### What is it?

> **While loop** executes statements **as long as a condition is TRUE**. It's used when you **don't know the exact number of iterations** in advance.

### Syntax

```bash
while [ condition ]
do
    # Statements
done
```

### Key Difference from For Loop

```
For loop  → "Repeat 15 times" (you know the count)
While loop → "Repeat until condition is false" (you don't know the count)
```

---

### Beginner Script: Print 1 to 15 Using While Loop

```bash
#!/bin/bash
# Script: while1.sh
# Purpose: Prints numbers 1 to 15 using while loop

k=1             # Initialize counter variable to 1

while [ $k -le 15 ]
# While k is less than or equal to 15 → keep looping
# $k   → access current value of k
# -le  → less than or equal to comparison operator
do
    echo $k             # Print current value of k
    let k++             # Increment k by 1 (let → arithmetic in while loops)
    # Without this: k stays 1, condition always true → infinite loop!
done
```

**Output:**
```
1
2
3
...
14
15
```

---

### ⚠️ Infinite Loop Warning!

```bash
# DANGEROUS — missing increment!
k=1
while [ $k -le 15 ]
do
    echo $k
    # No k++ here! k stays 1 forever
    # 1 <= 15 is always TRUE → runs FOREVER
done
# Fix: Add "let k++" inside the loop
# To stop: Press Ctrl + C
```

---

### Script: Password Validation Loop

```bash
#!/bin/bash
# Script: while1.sh
# Purpose: Keep asking user for password until correct one is entered

correct_password="secret"    # Define the correct password

user_input=""
# Start with empty user_input so the while condition is true initially

while [ "$user_input" != "$correct_password" ]
# While what user typed is NOT EQUAL to the correct password
# Keep looping
do
    echo "Enter correct password:"
    read user_input    # Read password from user each time
    # If wrong: loop continues, asks again
    # If correct: condition becomes false, loop exits
done

# This line only runs AFTER correct password is entered
echo "✅ Access Granted!"
```

**Execute:**
```bash
sh while1.sh
```

**Output:**
```
Enter correct password:
hello
Enter correct password:
wrong
Enter correct password:
secret
✅ Access Granted!
```

---

### Script: Countdown Timer (DevOps Use: Deployment Cooldown)

```bash
#!/bin/bash
# Script: while3.sh
# Purpose: Countdown timer from 5 to 1 (like a deployment countdown)

counter=5    # Start countdown from 5

while [ $counter -ge 1 ]
# While counter is greater than or equal to 1 → keep counting
do
    echo "Countdown: $counter"
    # counter=$(( counter - 1 )) → decrease by 1 each iteration
    counter=$(( counter - 1 ))
    sleep 2    # Wait 2 seconds before next count
    # sleep 2 → pause execution for 2 seconds
done

# After countdown reaches 0, this message prints
echo "🚀 Deployment Starting!"
```

**Execute:**
```bash
sh while3.sh
```

**Output (with 2-second pauses):**
```
Countdown: 5
Countdown: 4
Countdown: 3
Countdown: 2
Countdown: 1
🚀 Deployment Starting!
```

---

### Real-World DevOps: While Loop for CPU Monitoring

```bash
#!/bin/bash
# Script: cpu_monitor.sh
# Purpose: Continuously monitor CPU usage until it drops below 80%

threshold=80    # Alert threshold: 80%

echo "Starting CPU Monitor..."

while true      # true → condition is ALWAYS true, loop runs indefinitely
do
    # Get current CPU usage percentage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'.' -f1)
    
    echo "Current CPU Usage: $cpu_usage%"
    
    if [ "$cpu_usage" -ge "$threshold" ]; then
        echo "⚠️ WARNING: CPU usage is HIGH: $cpu_usage%"
    fi
    
    sleep 5    # Check every 5 seconds
done
# This runs continuously until you press Ctrl+C
```

---

<a name="day-3-summary"></a>

## 🔎 Day 3 Summary

| Concept | Key Takeaway |
|---|---|
| Loops | Execute statements multiple times without writing them multiple times |
| For Loop | Use when you KNOW the range/count |
| While Loop | Use when you KNOW the condition but NOT the count |
| `do...done` | Marks start and end of loop body |
| `k++` / `let k++` | Increment counter (MUST have to avoid infinite loops) |
| `k--` | Decrement counter (for reverse loops) |
| `sleep N` | Pause execution for N seconds |
| `Ctrl+C` | Stop an infinite loop |

**Interview-Ready Phrases:**

1. "For loops are range-based — I use them when I know how many iterations are needed."
2. "While loops are condition-based — I use them when I have a stopping condition but don't know the iteration count."
3. "Forgetting the increment in a while loop causes an infinite loop — always include `let k++` or `k=$(( k + 1 ))`."
4. "In DevOps, `while true` loops are commonly used for monitoring scripts that run continuously."

---

<a name="day-4"></a>

# 📅 Day 4 — Conditional Statements, Command Line Arguments & Functions

---

<a name="conditional-statements-deep-dive"></a>

## 🔀 Conditional Statements — Deep Dive

### What Are They?

**Conditional statements** allow your script to **make decisions** — execute different blocks of code based on whether a condition is **true** or **false**.

### Three Types

| Type | When to Use |
|---|---|
| `if` | Single condition check |
| `if-else` | Two-way decision (true/false) |
| `if-elif-else` | Multiple conditions check (multi-way decision) |

---

### Script: Check if a File Exists

```bash
#!/bin/bash
# Script: ifelse.sh
# Purpose: Checks whether a specified file exists in the system

echo "Enter file name:"
read file_name    # User enters the file name to check

if [ -e "$file_name" ]
# -e → file test operator that checks if file EXISTS
# $file_name → the variable holding the user's input
then
    echo "$file_name is available ✅"
    # This block runs if the file IS found
else
    echo "$file_name is NOT available ❌"
    # This block runs if the file is NOT found
fi
# fi → end of the if-else block
```

**Execute:**
```bash
sh ifelse.sh
```

**Test 1 (file doesn't exist):**
```
Enter file name:
test.py
test.py is NOT available ❌
```

**Test 2 (after creating file with `touch test.py`):**
```
Enter file name:
test.py
test.py is available ✅
```

---

### File Test Operators — DevOps Essential

```bash
# Common file test operators:
-e    # File EXISTS (file or directory)
-f    # Regular FILE (not directory)
-d    # DIRECTORY exists
-r    # File is READABLE
-w    # File is WRITABLE
-x    # File is EXECUTABLE
-s    # File is NOT EMPTY (has size > 0)

# Usage examples:
if [ -d "/var/log" ]; then echo "Log directory exists"; fi
if [ -f "script.sh" ]; then echo "Script file exists"; fi
if [ -x "deploy.sh" ]; then echo "Deploy script is executable"; fi
```

---

### Script: Check File Type (File vs Directory)

```bash
#!/bin/bash
# Script: file_type.sh
# Purpose: Determine if a path is a file or a directory

echo "Enter a name (file or directory):"
read name    # User enters name to check

if [ -f "$name" ]; then
    # -f → checks if it's a regular FILE
    echo "The $name is a Normal File"

elif [ -d "$name" ]; then
    # -d → checks if it's a DIRECTORY
    echo "The $name is a Directory"

else
    echo "The $name does not exist or is an unknown type"
fi
```

---

### Script: Leap Year Checker

```bash
#!/bin/bash
# Script: ifelse2.sh
# Purpose: Check whether a year is a leap year or not

echo "Enter a year:"
read year    # User enters the year to check

# A year is a leap year if:
# 1. Divisible by 4 AND NOT divisible by 100
# OR
# 2. Divisible by 400

if [[ ( $((year % 4)) -eq 0 && $((year % 100)) -ne 0 ) || $((year % 400)) -eq 0 ]]
# $((year % 4)) → remainder of year ÷ 4
# -eq 0 → equals zero (means divisible by 4)
# $((year % 100)) -ne 0 → NOT divisible by 100
# || → OR operator
# $((year % 400)) -eq 0 → divisible by 400
then
    echo "$year is a Leap Year 🗓️"
else
    echo "$year is NOT a Leap Year"
fi
```

**Output:**
```
Enter a year:
2024
2024 is a Leap Year 🗓️

Enter a year:
2025
2025 is NOT a Leap Year
```

---

### Script: Day of the Week

```bash
#!/bin/bash
# Script: ifelse3.sh
# Purpose: Tells the day name based on number input (1-7)

echo "Enter a number (1=Sunday, 2=Monday, ... 7=Saturday):"
read day_num    # User enters number

# Check each number and print corresponding day name
if [ "$day_num" == "1" ]; then
    echo "Sunday"
elif [ "$day_num" == "2" ]; then
    echo "Monday"
elif [ "$day_num" == "3" ]; then
    echo "Tuesday"
elif [ "$day_num" == "4" ]; then
    echo "Wednesday"
elif [ "$day_num" == "5" ]; then
    echo "Thursday"
elif [ "$day_num" == "6" ]; then
    echo "Friday"
elif [ "$day_num" == "7" ]; then
    echo "Saturday"
else
    # If input is not between 1-7
    echo "Invalid input! Please enter a number between 1 and 7 only."
fi
```

**Output:**
```
Enter a number (1=Sunday, 2=Monday, ... 7=Saturday):
5
Thursday

Enter a number:
70
Invalid input! Please enter a number between 1 and 7 only.
```

---

<a name="command-line-arguments"></a>

## 📨 Command Line Arguments

### What Are They?

**Command Line Arguments (CLA)** are **values passed to a script when you execute it** — from the command line itself, not inside the script.

### Why Are They Useful?

They make scripts **dynamic** — you don't hardcode values inside the script. Instead, you pass different values each time you run it.

```bash
# Without CLA: values are hardcoded, not flexible
echo "Hello Castro"    # Always prints Castro

# With CLA: pass any name when running
sh greet.sh Castro    # Prints: Hello Castro
sh greet.sh Kiran     # Prints: Hello Kiran
sh greet.sh DevOps    # Prints: Hello DevOps
```

### Special CLA Variables

| Variable | What it Contains | Example |
|---|---|---|
| `$0` | **Script name** (the filename itself) | `./greet.sh` |
| `$1` | **First argument** passed | `Castro` |
| `$2` | **Second argument** passed | `Kiran` |
| `$3` | **Third argument** passed | `DevOps` |
| `$#` | **Total number** of arguments (excludes `$0`) | `3` |
| `$@` | **All arguments** as separate entities | `Castro Kiran DevOps` |
| `$*` | **All arguments** as single string | `Castro Kiran DevOps` |

---

### Beginner Script: CLA Demonstration

```bash
#!/bin/bash
# Script: cla.sh
# Purpose: Demonstrates all command line argument variables

echo "Script name: $0"
# $0 → contains the name of the script being executed

echo "First argument: $1"
# $1 → first value you pass after the script name

echo "Second argument: $2"
# $2 → second value you pass

echo "Third argument: $3"
# $3 → third value you pass

echo "All arguments: $@"
# $@ → all passed arguments, each treated separately

echo "Number of arguments: $#"
# $# → count of arguments passed (doesn't count $0)

echo "All as single string: $*"
# $* → all arguments as one combined string
```

**Execute:**
```bash
sh cla.sh Castro Kiran "shell scripting" lectures "learn with castro"
```

**Output:**
```
Script name: cla.sh
First argument: Castro
Second argument: Kiran
Third argument: shell scripting
All arguments: Castro Kiran shell scripting lectures learn with castro
Number of arguments: 5
All as single string: Castro Kiran shell scripting lectures learn with castro
```

> 💡 **Notice:** Quoted arguments like `"shell scripting"` are treated as one argument. 5 arguments were passed and `$#` correctly shows `5`.

---

### `$@` vs `$*` — The Important Difference

```bash
#!/bin/bash
# Script: compare_args.sh

echo "Using \$@:"
for arg in "$@"
# "$@" → treats each argument as SEPARATE quoted string
# "hello world" stays as ONE argument: "hello world"
do
    echo "  Arg: $arg"
done

echo ""
echo "Using \$*:"
for arg in "$*"
# "$*" → treats ALL arguments as ONE single string
# "hello world" and "foo" become: "hello world foo"
do
    echo "  Arg: $arg"
done
```

**Execute:**
```bash
sh compare_args.sh "hello world" foo bar
```

**Output:**
```
Using $@:
  Arg: hello world
  Arg: foo
  Arg: bar

Using $*:
  Arg: hello world foo bar
```

> 📌 **Rule:** In production scripts, **prefer `"$@"`** when you want to preserve argument boundaries. Use `"$*"` only when you want everything as one string.

---

### Real-World CLA Example: Deployment Script

```bash
#!/bin/bash
# Script: deploy.sh
# Purpose: Deploy application to specified environment
# Usage: sh deploy.sh dev v1.2.3 web-server-1

environment=$1      # First arg: environment (dev/staging/prod)
version=$2          # Second arg: version to deploy
server=$3           # Third arg: target server

# Validate that all required arguments are provided
if [ $# -lt 3 ]; then
    echo "Usage: $0 <environment> <version> <server>"
    echo "Example: $0 dev v1.2.3 web-server-1"
    exit 1    # Exit with error code 1
fi

echo "🚀 Deploying to: $environment"
echo "📦 Version: $version"
echo "🖥️  Server: $server"
echo "Deployment started..."
```

**Execute:**
```bash
sh deploy.sh dev v1.2.3 web-server-1
```

**Output:**
```
🚀 Deploying to: dev
📦 Version: v1.2.3
🖥️  Server: web-server-1
Deployment started...
```

---

<a name="functions"></a>

## 🧩 Functions

### What Are They?

A **function** is a **named, reusable block of code** that performs a specific task. You define it once and **call it as many times as needed**.

### Why Use Functions?

| Benefit | Explanation |
|---|---|
| **Reusability** | Write once, use anywhere in the script |
| **Organization** | Group related code together |
| **Avoid Repetition** | No need to copy-paste same code |
| **Modularity** | Break large scripts into smaller pieces |
| **Maintainability** | Fix one function, all calls benefit |

### Syntax

```bash
# Define the function
function_name() {
    # Code to execute
    echo "Inside the function"
}

# Call (invoke) the function
function_name
```

---

### Beginner Script: Greeting Function

```bash
#!/bin/bash
# Script: f1.sh
# Purpose: Defines and calls a greeting function

# DEFINE the function
greet() {
    # $1 → first argument passed TO THE FUNCTION (not the script)
    echo "Hello $1, Welcome to Shell Scripting Course by Kastro"
}

# CALL the function — pass "Castro" as argument to the function
greet "Castro"

# Call it again with different argument
greet "Kiran"

# Call it again
greet "DevOps Team"
```

**Execute:**
```bash
sh f1.sh
```

**Output:**
```
Hello Castro, Welcome to Shell Scripting Course by Kastro
Hello Kiran, Welcome to Shell Scripting Course by Kastro
Hello DevOps Team, Welcome to Shell Scripting Course by Kastro
```

---

### Script: Calculator with Functions

```bash
#!/bin/bash
# Script: f2.sh
# Purpose: Calculator using separate functions for each operation

# FUNCTION: Add two numbers
add() {
    # $1 → first argument passed to this function
    # $2 → second argument passed to this function
    echo "Sum: $(( $1 + $2 ))"
}

# FUNCTION: Subtract two numbers
subtract() {
    echo "Difference: $(( $1 - $2 ))"
}

# FUNCTION: Multiply two numbers
multiply() {
    echo "Product: $(( $1 * $2 ))"
}

# FUNCTION: Divide two numbers
divide() {
    if [ $2 -eq 0 ]; then
        echo "Error: Cannot divide by zero!"
    else
        echo "Division: $(( $1 / $2 ))"
    fi
}

# CALL functions with arguments
add 10 5           # Calls add() with 10 and 5
subtract 10 5      # Calls subtract() with 10 and 5
multiply 10 5      # Calls multiply() with 10 and 5
divide 10 5        # Calls divide() with 10 and 5
divide 10 0        # Tests the divide-by-zero protection
```

**Execute:**
```bash
sh f2.sh
```

**Output:**
```
Sum: 15
Difference: 5
Product: 50
Division: 2
Error: Cannot divide by zero!
```

---

### Real-World Function: System Info Reporter

```bash
#!/bin/bash
# Script: system_report.sh
# Purpose: Collects and displays system information using functions

# FUNCTION: Display CPU info
show_cpu() {
    echo "=== CPU Information ==="
    top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " $2 "%"}'
}

# FUNCTION: Display Memory info
show_memory() {
    echo "=== Memory Information ==="
    free -m | awk 'NR==2{printf "Memory: %s/%s MB (%.2f%%)\n", $3,$2,$3*100/$2}'
}

# FUNCTION: Display Disk info
show_disk() {
    echo "=== Disk Information ==="
    df -h / | awk 'NR==2{print "Disk: " $3 " used / " $2 " total (" $5 " used)"}'
}

# FUNCTION: Display uptime
show_uptime() {
    echo "=== System Uptime ==="
    uptime -p    # -p → human-readable format
}

# MAIN: Call all functions
echo "📊 System Health Report - $(date)"
echo "================================"
show_cpu
show_memory
show_disk
show_uptime
echo "================================"
echo "Report completed."
```

---

### Returning Values from Functions

```bash
#!/bin/bash
# Functions in Bash don't "return" values like other languages
# Instead, they echo output and you capture it with $()

calculate_square() {
    local num=$1          # local → variable only exists inside this function
    echo $(( num * num )) # echo the result (this is how you "return" values
}

# Capture the function's output using $()
result=$(calculate_square 7)
echo "Square of 7 is: $result"    # Output: Square of 7 is: 49

result=$(calculate_square 12)
echo "Square of 12 is: $result"   # Output: Square of 12 is: 144
```

---

<a name="day-4-summary"></a>

## 🔎 Day 4 Summary

| Concept | Key Takeaway |
|---|---|
| Conditional Statements | if/elif/else for decision making |
| File Test Operators | `-e`, `-f`, `-d`, `-r`, `-w`, `-x` |
| CLA | Values passed when executing script |
| `$0` | Script name |
| `$1`, `$2` | Positional arguments |
| `$#` | Count of arguments |
| `$@` | All arguments (separate) |
| `$*` | All arguments (single string) |
| Functions | Reusable named blocks of code |
| `local` | Variable scoped inside a function |

**Interview-Ready Phrases:**

1. "Command line arguments make scripts dynamic — I pass `$1`, `$2` instead of hardcoding values."
2. "I always validate `$#` at the start of scripts to ensure required arguments are provided."
3. "Functions improve code reusability — I write complex logic once and call it multiple times."
4. "I use `local` inside functions to prevent variable name conflicts with the main script."
5. "To return values from a function in Bash, I `echo` the result and capture it with `$()`."

---

<a name="day-5"></a>

# 📅 Day 5 — Scheduling & Cron Jobs

---

<a name="what-is-scheduling"></a>

## 📅 What is Scheduling?

### Definition

**Scheduling** is the ability to **run a shell script automatically at a specific time** or at regular intervals — without manually triggering it.

### Why is This Critical for DevOps?

| Without Scheduling | With Scheduling |
|---|---|
| Someone must manually run backup scripts | Backups run automatically at 2AM every day |
| Manual health checks miss off-hours incidents | Health checks run every 5 minutes, 24/7 |
| Log cleanup is forgotten | Logs auto-cleaned every Sunday |
| Disk usage only checked when someone remembers | Disk alerts fired automatically when >80% |

### Real-World DevOps Scheduling Use Cases

```
🕐 Every 5 minutes  → Health check script
🕐 Every hour       → Log rotation check
🕐 Daily at 2AM     → Database backup
🕐 Every Sunday     → Temporary file cleanup
🕐 Every Monday     → Weekly system report
🕐 1st of month     → Monthly billing report
```

---

<a name="types-of-scheduling-in-linux"></a>

## 📊 Types of Scheduling in Linux

| Type | Command | Use Case |
|---|---|---|
| **One-time execution** | `at` | Run script once at a specific future time |
| **Recurring execution** | `cron` | Run script repeatedly at fixed intervals |

---

<a name="one-time-execution-at-command"></a>

## ⏰ One-Time Execution — `at` Command

### What is it?

The `at` command schedules a script to run **exactly once** at a **specified future time**.

### Installation

```bash
# For RHEL/CentOS/Amazon Linux:
sudo yum install at -y

# For Ubuntu/Debian:
sudo apt install at -y

# Start the service:
sudo systemctl start atd
sudo systemctl enable atd

# Verify service is running:
sudo systemctl status atd
```

### Usage Syntax

```bash
# Schedule a command to run at specific time
echo "command to run" | at TIME

# Or schedule a script
echo "sh /path/to/script.sh" | at TIME
```

### Time Formats

```bash
# Run tomorrow at 10:30 AM
echo "sh /home/ec2-user/sample.sh" | at 10:30 AM tomorrow

# Run on specific date
echo "sh /home/ec2-user/backup.sh" | at 2:00 AM March 10

# Run in the next hour
echo "sh /home/ec2-user/report.sh" | at now + 1 hour

# Run at midnight tonight
echo "sh /home/ec2-user/cleanup.sh" | at midnight
```

### Managing `at` Jobs

```bash
# List scheduled at jobs
atq

# Remove a scheduled job (job number from atq)
atrm 1

# View a scheduled job's content
at -c 1    # View job number 1
```

### Limitation of `at`

> ⚠️ The `at` command runs **once only**. In real production DevOps, we rarely use `at` because we need jobs to run **repeatedly**. That's where **cron jobs** come in.

---

<a name="recurring-execution-cron-jobs"></a>

## 🔄 Recurring Execution — Cron Jobs

### What is Cron?

**Cron** is a Linux utility that **schedules commands or scripts to run automatically at fixed intervals**.

> Think of Cron as your **automated personal assistant** — you tell it what to do and when, and it does it every time without you needing to remember.

### What is a Cron Daemon?

The **cron daemon** (`crond`) is a **background process** that:
- Wakes up every minute
- Checks the cron table (crontab) for scheduled jobs
- Executes any job whose scheduled time matches the current time
- Goes back to sleep until the next minute

### Installation and Setup

```bash
# Install cronie (cron for RHEL/Amazon Linux)
sudo yum install cronie -y

# Start the cron service
sudo systemctl start crond

# Enable it to start automatically on system boot
sudo systemctl enable crond

# Check if cron is running
sudo systemctl status crond
# Look for: "Active: active (running)" in green
```

---

<a name="cron-expression-format"></a>

## 🗓️ Cron Expression Format

### The 5-Star Cron Format

```
*  *  *  *  *   command_to_execute
│  │  │  │  │
│  │  │  │  └─── Day of Week  (0–7, 0 and 7 both = Sunday)
│  │  │  └────── Month        (1–12)
│  │  └───────── Day of Month  (1–31)
│  └──────────── Hour          (0–23, uses 24-hour clock)
└─────────────── Minute        (0–59)
```

### Quick Reference Table

| Position | Field | Range | Special |
|---|---|---|---|
| 1st | Minute | 0–59 | `*/15` = every 15 mins |
| 2nd | Hour | 0–23 | `*/2` = every 2 hours |
| 3rd | Day of Month | 1–31 | `1` = 1st of month |
| 4th | Month | 1–12 | `6` = June |
| 5th | Day of Week | 0–7 | `1` = Monday, `0`/`7` = Sunday |

### Special Characters

| Character | Meaning | Example |
|---|---|---|
| `*` | Every/Any value | `* * * * *` = every minute |
| `*/n` | Every nth unit | `*/5 * * * *` = every 5 mins |
| `n` | Specific value | `0 9 * * *` = at 9:00 AM daily |
| `n-m` | Range | `1-5` = Monday to Friday |
| `n,m` | List | `1,15` = 1st and 15th |

### Cron Expression Examples

```bash
# Every minute
* * * * * /path/to/script.sh

# Every 5 minutes
*/5 * * * * /path/to/script.sh

# Every day at 9:00 AM
0 9 * * * /path/to/script.sh

# Every day at 5:00 PM (17:00 in 24-hour)
0 17 * * * /path/to/script.sh

# Every Monday at 10:30 AM
30 10 * * 1 /path/to/script.sh

# Every first day of the month at 2:00 AM
0 2 1 * * /path/to/script.sh

# Every Sunday at midnight
0 0 * * 0 /path/to/script.sh

# Every weekday (Monday to Friday) at 8:00 AM
0 8 * * 1-5 /path/to/script.sh

# Every 15 minutes
*/15 * * * * /path/to/script.sh

# On 1st and 15th of every month at 9:15 PM
15 21 1,15 * * /path/to/script.sh

# Every 2 minutes
*/2 * * * * /path/to/script.sh
```

> 💡 **Pro tip:** Use [https://crontab.guru/](https://crontab.guru/) to visually create and validate cron expressions.

---

<a name="configuring-cron-jobs-with-crontab"></a>

## ⚙️ Configuring Cron Jobs with `crontab`

### crontab Commands

```bash
# Open the crontab editor (to add/edit/remove cron jobs)
crontab -e

# List all scheduled cron jobs for current user
crontab -l

# Remove ALL cron jobs (use with caution!)
crontab -r
```

### Adding Your First Cron Job

**Step 1: Create your shell script**

```bash
vi /home/ec2-user/castro.sh
```

```bash
#!/bin/bash
# Script: castro.sh
# Purpose: Simple script scheduled to run via cron

pwd           # Print current directory
whoami        # Print current user
date          # Print date and time
cal           # Print this month's calendar

echo "Cron job executed at: $(date)" >> /home/ec2-user/cron_log.txt
# >> → appends output to file (so we can see history)
```

**Step 2: Give execute permission**
```bash
chmod +x /home/ec2-user/castro.sh
```

**Step 3: Open crontab editor**
```bash
crontab -e
```

**Step 4: Add your cron job**

Press `i` to enter insert mode, then type:

```bash
# Run castro.sh every 1 minute
*/1 * * * * /home/ec2-user/castro.sh

# Run backup every day at 2AM
0 2 * * * /home/ec2-user/backup.sh

# Run health check every 5 minutes
*/5 * * * * /home/ec2-user/health_check.sh
```

**Step 5: Save and exit**
```
Press Esc → :wq → Enter
```

**Step 6: Verify cron was saved**
```bash
crontab -l
# Should show your configured cron jobs
```

---

### Production Cron Job Examples

```bash
# Example 1: Run cleanup at 3 PM Mon-Fri
0 15 * * 1-5 /home/ec2-user/cleanup.sh

# Example 2: Run two commands at 3 PM every Monday
0 15 * * Mon pwd && whoami

# Example 3: Run script every 5 minutes, suppress stdout, email errors
MAILTO=devops@company.com
*/5 * * * * /home/ec2-user/monitor.sh > /dev/null

# Example 4: Run PHP script every 2 minutes, log output
*/2 * * * * /usr/bin/php /path/to/script.php >> /var/log/script.log

# Example 5: Run script every day 8AM-4PM, on the hour
00 08-16 * * * /path/to/script.sh

# Example 6: Custom environment variables for cron
HOME=/opt
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
SHELL=/bin/bash
MAILTO=devops@company.com
*/1 * * * * /home/ec2-user/monitor.sh
```

---

### Redirecting Cron Output

```bash
# Suppress all output (both stdout and stderr)
*/5 * * * * /path/to/script.sh > /dev/null 2>&1

# Log only errors
*/5 * * * * /path/to/script.sh > /dev/null 2>> /var/log/errors.log

# Log everything
*/5 * * * * /path/to/script.sh >> /var/log/cron_output.log 2>&1

# Append to log with timestamp
*/5 * * * * echo "$(date): Script ran" >> /var/log/script.log
```

---

<a name="day-5-summary"></a>

## 🔎 Day 5 Summary

| Concept | Key Takeaway |
|---|---|
| Scheduling | Automate script execution without manual intervention |
| `at` command | One-time future execution |
| Cron | Recurring execution at fixed intervals |
| `crond` | Background daemon that checks/runs cron jobs |
| Cron format | `minute hour day month weekday command` |
| `*/n` | Every nth unit of time |
| `crontab -e` | Edit cron jobs |
| `crontab -l` | List cron jobs |
| `crontab -r` | Remove all cron jobs |
| [crontab.guru](https://crontab.guru/) | Visual cron expression helper |

**Interview-Ready Phrases:**

1. "Cron is a Linux scheduling utility — I use it to automate backups, health checks, and cleanups on fixed schedules."
2. "The cron format is `minute hour day month weekday` — `0 2 * * *` means daily at 2AM."
3. "I always redirect cron output to a log file for debugging: `>> /var/log/script.log 2>&1`."
4. "For one-time future execution, I use the `at` command. For recurring, I use cron."
5. "I validate cron expressions using crontab.guru before adding to production."

---

<a name="day-6"></a>

# 📅 Day 6 — 25 Real-Time DevOps Shell Scripts

---

> 📌 **How to use this section:**
> - Read the **Problem Statement** to understand WHY the script exists
> - Study the **Full Script** with detailed line-by-line comments
> - Run it on your EC2 instance and compare with **Expected Output**
> - Note the **Production Use Case** and **Interview Relevance**

---

<a name="script-1"></a>

## ✅ Script 1: System Health Monitoring

### Problem Statement
As a DevOps engineer, you need to **monitor server health in real-time** and get alerted when CPU, memory, or disk usage exceeds safe thresholds — before it causes an outage.

### Why This is Needed in Production
- Servers under high load can slow down or crash applications
- Proactive monitoring prevents incidents
- Manual checks are impossible at scale (100+ servers)
- Alert when threshold is crossed, not after the crash

```bash
#!/bin/bash
# Script: system_health.sh
# Purpose: Monitor CPU, Memory, and Disk usage. Alert if thresholds exceeded.
# Usage: sh system_health.sh
# Production Use: Run via cron every 5 minutes

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
CPU_THRESHOLD=80      # Alert if CPU usage >= 80%
MEM_THRESHOLD=80      # Alert if Memory usage >= 80%
DISK_THRESHOLD=90     # Alert if Disk usage >= 90%
ALERT_EMAIL="devops@yourcompany.com"   # Email to send alerts (configure if needed)

# ─── HEADER ───────────────────────────────────────────────────────────────────
echo "======================================"
echo " System Health Check - $(date)"
echo "======================================"

# ─── CPU USAGE ────────────────────────────────────────────────────────────────
# top -bn1      → run top in batch mode (-b), only 1 iteration (-n1)
# grep "Cpu(s)" → filter the CPU line from top output
# awk '{print $2 + $4}' → add user CPU% and system CPU% together
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
CPU_INT=${CPU_USAGE%.*}   # Remove decimal: 45.2 → 45

echo "CPU Usage: $CPU_INT%"

# ─── MEMORY USAGE ─────────────────────────────────────────────────────────────
# free          → shows memory stats
# grep Mem      → filter the memory line
# awk '{print $3/$2 * 100.0}' → used/total * 100 = percentage
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
MEM_INT=${MEM_USAGE%.*}   # Remove decimal for integer comparison

echo "Memory Usage: $MEM_INT%"

# ─── DISK USAGE ───────────────────────────────────────────────────────────────
# df -h /       → disk free for root partition, human-readable
# awk 'NR==2 {print $5}' → get 5th column of line 2 (usage percentage)
# sed 's/%//'   → remove the % sign so we can compare numerically
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Disk Usage: $DISK_USAGE%"
echo ""
echo "─── ALERTS ───────────────────────────────"

# ─── CHECK THRESHOLDS AND ALERT ───────────────────────────────────────────────
ALERT_TRIGGERED=false    # Flag to track if any alert was triggered

# Check CPU threshold
if [ "$CPU_INT" -ge "$CPU_THRESHOLD" ]; then
    echo "⚠️  CPU ALERT: Usage is $CPU_INT% (Threshold: $CPU_THRESHOLD%)"
    ALERT_TRIGGERED=true
fi

# Check Memory threshold
if [ "$MEM_INT" -ge "$MEM_THRESHOLD" ]; then
    echo "⚠️  MEMORY ALERT: Usage is $MEM_INT% (Threshold: $MEM_THRESHOLD%)"
    ALERT_TRIGGERED=true
fi

# Check Disk threshold
if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    echo "⚠️  DISK ALERT: Usage is $DISK_USAGE% (Threshold: $DISK_THRESHOLD%)"
    ALERT_TRIGGERED=true
fi

# If no alerts, system is healthy
if [ "$ALERT_TRIGGERED" = false ]; then
    echo "✅ All metrics are within normal limits. System is healthy!"
fi

echo "======================================"
echo "Health Check Complete."
```

### Expected Output

```
======================================
 System Health Check - Mon Mar 3 09:15:00 UTC 2025
======================================
CPU Usage: 12%
Memory Usage: 45%
Disk Usage: 34%

─── ALERTS ───────────────────────────────
✅ All metrics are within normal limits. System is healthy!
======================================
Health Check Complete.
```

### Schedule via Cron (every 5 minutes)

```bash
*/5 * * * * /home/ec2-user/system_health.sh >> /var/log/health.log 2>&1
```

### Where It's Used

- **Production:** AWS EC2 fleet monitoring
- **CI/CD:** Pre-deployment checks
- **Incident Response:** Automated triage scripts

### Interview Relevance

> "I use `top`, `free`, and `df` in combination with `awk` and `sed` to extract numeric metrics. Then I compare them against thresholds using `-ge` and trigger alerts. This script runs via cron every 5 minutes in our environment."

---

<a name="script-2"></a>

## ✅ Script 2: Automated Log Cleanup

### Problem Statement
Servers accumulate log files over time. A server with 100GB disk can fill up in weeks if logs aren't cleaned. You need a script to **automatically delete log files older than X days**.

```bash
#!/bin/bash
# Script: log_cleanup.sh
# Purpose: Delete log files older than a specified number of days
# Usage: sh log_cleanup.sh
# Production Use: Run weekly via cron (Sunday midnight)

# ─── CONFIGURATION ────────────────────────────────��───────────────────────────
LOG_DIR="/var/log"    # Directory where logs are stored
DAYS=30               # Delete logs older than this many days
# Change DAYS to 7 for weekly cleanup, 90 for quarterly

# ─── PRE-CHECKS ───────────────────────────────────────────────────────────────
# Check if log directory exists before proceeding
if [ ! -d "$LOG_DIR" ]; then
    echo "ERROR: Log directory $LOG_DIR does not exist!"
    exit 1    # Exit with error code 1
fi

# ─── CLEANUP ──────────────────────────────────────────────────────────────────
echo "=== Log Cleanup Script ==="
echo "Started at: $(date)"
echo "Cleaning logs older than $DAYS days in: $LOG_DIR"
echo ""

# Count files BEFORE cleanup
BEFORE_COUNT=$(find $LOG_DIR -type f -name "*.log" | wc -l)
echo "Log files found before cleanup: $BEFORE_COUNT"

# find $LOG_DIR   → search in log directory
# -type f         → only regular files (not directories)
# -name "*.log"   → only files ending in .log
# -mtime +$DAYS   → files modified MORE than $DAYS days ago
# -exec rm -f {} \; → delete each found file
find $LOG_DIR -type f -name "*.log" -mtime +$DAYS -exec rm -f {} \;

# Count files AFTER cleanup
AFTER_COUNT=$(find $LOG_DIR -type f -name "*.log" | wc -l)
DELETED=$(( BEFORE_COUNT - AFTER_COUNT ))    # How many were deleted

echo "Log files deleted: $DELETED"
echo "Log files remaining: $AFTER_COUNT"
echo ""
echo "Log cleanup completed at: $(date)"
echo "=========================="
```

### Expected Output

```
=== Log Cleanup Script ===
Started at: Mon Mar 3 09:00:00 UTC 2025
Cleaning logs older than 30 days in: /var/log

Log files found before cleanup: 45
Log files deleted: 12
Log files remaining: 33

Log cleanup completed at: Mon Mar 3 09:00:01 UTC 2025
==========================
```

### Cron Schedule (Every Sunday at Midnight)

```bash
0 0 * * 0 /home/ec2-user/log_cleanup.sh >> /var/log/cleanup_history.log 2>&1
```

---

<a name="script-3"></a>

## ✅ Script 3: Backup and Restore

### Problem Statement
Critical application data must be backed up regularly. You need a script that **creates timestamped compressed backups** and can **restore** from any previous backup.

```bash
#!/bin/bash
# Script: backup_restore.sh
# Purpose: Backup a source directory and support restoration
# Usage: sh backup_restore.sh
# Production Use: Daily backup of web application files

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
BACKUP_DIR="/backup"              # Where backups are stored
SOURCE_DIR="/var/www/html"        # What to backup (your app files)
TIMESTAMP=$(date +"%F-%H-%M-%S")  # Format: 2025-03-03-09-15-30
BACKUP_FILE="$BACKUP_DIR/backup-$TIMESTAMP.tar.gz"
# Full backup file path: /backup/backup-2025-03-03-09-15-30.tar.gz

# ─── FUNCTION: CREATE BACKUP ──────────────────────────────────────────────────
backup() {
    echo "=== Starting Backup ==="
    echo "Source: $SOURCE_DIR"
    echo "Destination: $BACKUP_FILE"
    echo "Time: $(date)"

    # Create backup directory if it doesn't exist
    # -p → no error if directory already exists, creates parent dirs too
    mkdir -p $BACKUP_DIR

    # tar → archiving tool
    # -c  → create new archive
    # -z  → compress with gzip (.gz)
    # -f  → specifies archive filename
    # $BACKUP_FILE → output file path
    # $SOURCE_DIR  → what to archive
    tar -czf $BACKUP_FILE $SOURCE_DIR

    # Check if backup was successful ($? = exit code of last command)
    if [ $? -eq 0 ]; then
        echo "✅ Backup successful: $BACKUP_FILE"
        # Show backup file size
        ls -lh $BACKUP_FILE | awk '{print "Backup size: " $5}'
    else
        echo "❌ Backup FAILED!"
        exit 1
    fi
}

# ─── FUNCTION: RESTORE BACKUP ─────────────────────────────────────────────────
restore() {
    echo "=== Available Backups ==="
    ls -lh $BACKUP_DIR   # List all backup files with sizes

    echo ""
    echo "Enter the backup filename to restore:"
    read FILE    # User selects which backup to restore

    # Check if the file exists
    if [ ! -f "$BACKUP_DIR/$FILE" ]; then
        echo "❌ ERROR: Backup file not found: $BACKUP_DIR/$FILE"
        exit 1
    fi

    echo "Restoring from: $BACKUP_DIR/$FILE"

    # tar -x → extract
    # -z → decompress gzip
    # -f → file to extract from
    # -C / → extract to root (preserves original directory structure)
    tar -xzf "$BACKUP_DIR/$FILE" -C /

    if [ $? -eq 0 ]; then
        echo "✅ Restore completed successfully!"
    else
        echo "❌ Restore FAILED!"
    fi
}

# ─── MAIN MENU ────────────────────────────────────────────────────────────────
echo "==========================="
echo " Backup & Restore Script"
echo "==========================="
echo "1. Backup"
echo "2. Restore"
echo "Enter your choice (1 or 2):"
read CHOICE

# case statement → cleaner alternative to multiple if-elif
case $CHOICE in
    1) backup ;;     # Call backup function
    2) restore ;;    # Call restore function
    *) echo "Invalid option! Please enter 1 or 2." ;;  # Invalid input
esac
```

### Expected Output

```
===========================
 Backup & Restore Script
===========================
1. Backup
2. Restore
Enter your choice (1 or 2):
1
=== Starting Backup ===
Source: /var/www/html
Destination: /backup/backup-2025-03-03-09-15-30.tar.gz
Time: Mon Mar  3 09:15:30 UTC 2025
✅ Backup successful: /backup/backup-2025-03-03-09-15-30.tar.gz
Backup size: 2.3M
```

---

<a name="script-4"></a>

## ✅ Script 4: Kubernetes Pod Health Check

### Problem Statement
In a Kubernetes cluster, pods can crash or get stuck in error states. You need a script to **quickly identify any pods not in the Running state**.

```bash
#!/bin/bash
# Script: k8s_pod_health.sh
# Purpose: Check all Kubernetes pods in a namespace for unhealthy states
# Prerequisites: kubectl configured with cluster access
# Usage: sh k8s_pod_health.sh
# Production Use: Run every 5 minutes via cron, alert on failures

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
NAMESPACE="default"    # Change to your namespace (e.g., "production", "staging")

echo "=== Kubernetes Pod Health Check ==="
echo "Namespace: $NAMESPACE"
echo "Time: $(date)"
echo ""

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "❌ ERROR: kubectl is not installed or not in PATH"
    exit 1
fi

# Get all pods in the namespace, skip header line
# --no-headers → don't show column headers
# awk '$3 != "Running"' → filter pods WHERE status column ($3) is NOT "Running"
# print "⚠️ Pod " $1 " is in state " $3 → format the alert message
UNHEALTHY=$(kubectl get pods -n $NAMESPACE --no-headers | awk '$3 != "Running" {print "⚠️  Pod: " $1 " | State: " $3 " | Restarts: " $4}')

# If no unhealthy pods found
if [ -z "$UNHEALTHY" ]; then
    # -z → true if string is EMPTY (no unhealthy pods)
    echo "✅ All pods in '$NAMESPACE' are in Running state!"
else
    echo "⚠️  UNHEALTHY PODS DETECTED:"
    echo "$UNHEALTHY"
    echo ""
    echo "Total pods:"
    kubectl get pods -n $NAMESPACE
fi

echo ""
echo "Health check completed."
```

### Expected Output (Healthy Cluster)

```
=== Kubernetes Pod Health Check ===
Namespace: default
Time: Mon Mar 3 09:15:00 UTC 2025

✅ All pods in 'default' are in Running state!

Health check completed.
```

### Expected Output (Unhealthy Pods)

```
⚠️  UNHEALTHY PODS DETECTED:
⚠️  Pod: web-deployment-abc123 | State: CrashLoopBackOff | Restarts: 5
⚠️  Pod: db-pod-xyz456 | State: Error | Restarts: 3
```

---

<a name="script-5"></a>

## ✅ Script 5: AWS S3 Bucket Sync

### Problem Statement
You need to **automatically sync local files or backups to an S3 bucket** for offsite storage and disaster recovery.

```bash
#!/bin/bash
# Script: s3_sync.sh
# Purpose: Sync local backup directory to AWS S3 bucket
# Prerequisites: AWS CLI installed and configured with proper IAM permissions
# Usage: sh s3_sync.sh
# Production Use: Nightly backup sync, post-deployment artifact upload

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
BUCKET_NAME="my-company-backups"    # Replace with your actual S3 bucket name
SOURCE_DIR="/backup"                 # Local directory to sync
LOG_FILE="/var/log/s3_sync.log"      # Log file for sync history
REGION="us-east-1"                   # AWS region of your bucket

echo "=== AWS S3 Sync Script ==="
echo "Started: $(date)"
echo "Source: $SOURCE_DIR"
echo "Destination: s3://$BUCKET_NAME"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ ERROR: Source directory $SOURCE_DIR does not exist!"
    exit 1
fi

# Check if AWS CLI is available
if ! command -v aws &> /dev/null; then
    echo "❌ ERROR: AWS CLI not found. Please install it first."
    exit 1
fi

echo "Starting sync..."

# aws s3 sync     → sync command
# $SOURCE_DIR     → local source directory
# s3://$BUCKET_NAME → destination S3 bucket
# --delete        → delete files in S3 that no longer exist locally
# --region        → specify AWS region
# 2>&1            → redirect stderr to stdout (capture all output)
aws s3 sync $SOURCE_DIR s3://$BUCKET_NAME \
    --delete \
    --region $REGION \
    --storage-class STANDARD_IA \
    2>&1 | tee -a $LOG_FILE
# tee -a $LOG_FILE → display output AND append to log file simultaneously

# Check if sync was successful
if [ $? -eq 0 ]; then
    echo "✅ S3 Sync completed successfully at $(date)"
    # Show bucket size
    echo "Bucket contents:"
    aws s3 ls s3://$BUCKET_NAME --human-readable --summarize
else
    echo "❌ S3 Sync FAILED at $(date)"
    exit 1
fi
```

---

<a name="script-6"></a>

## ✅ Script 6: Check if a Service is Running

### Problem Statement
Critical services like Nginx, MySQL, or Apache can unexpectedly stop. You need to **automatically detect service failures and restart them** without waiting for manual intervention.

```bash
#!/bin/bash
# Script: service_check.sh
# Purpose: Check if a service is running; restart it if it's down
# Usage: sh service_check.sh
# Production Use: Run every 2 minutes via cron for critical services

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
SERVICE="nginx"    # Service to check (change to: mysql, apache2, httpd, etc.)
LOG_FILE="/var/log/service_monitor.log"    # Log file

echo "=== Service Monitor: $SERVICE ==="
echo "Check Time: $(date)"

# systemctl is-active → returns 0 (success) if service is active
# --quiet             → suppress output, just return exit code
if systemctl is-active --quiet $SERVICE; then
    # Service is running
    echo "✅ $SERVICE is running normally"
    echo "$(date): $SERVICE is RUNNING" >> $LOG_FILE

else
    # Service is NOT running
    echo "⚠️  $SERVICE is NOT running!"
    echo "$(date): $SERVICE is DOWN - Attempting restart" >> $LOG_FILE

    # Attempt to restart the service
    echo "Restarting $SERVICE..."
    sudo systemctl restart $SERVICE

    # Check if restart was successful
    if systemctl is-active --quiet $SERVICE; then
        echo "✅ $SERVICE successfully restarted at $(date)"
        echo "$(date): $SERVICE RESTARTED successfully" >> $LOG_FILE
    else
        echo "❌ CRITICAL: Failed to restart $SERVICE!"
        echo "$(date): $SERVICE RESTART FAILED - Manual intervention needed!" >> $LOG_FILE
        # In production: send alert email or PagerDuty notification here
        # mail -s "CRITICAL: $SERVICE down on $(hostname)" admin@company.com
        exit 1
    fi
fi
```

### Expected Output (Service Running)

```
=== Service Monitor: nginx ===
Check Time: Mon Mar 3 09:15:00 UTC 2025
✅ nginx is running normally
```

### Expected Output (Service Down, Auto-Restarted)

```
=== Service Monitor: nginx ===
Check Time: Mon Mar 3 09:20:00 UTC 2025
⚠️  nginx is NOT running!
Restarting nginx...
✅ nginx successfully restarted at Mon Mar 3 09:20:02 UTC 2025
```

### Cron Schedule (Every 2 Minutes)

```bash
*/2 * * * * /home/ec2-user/service_check.sh >> /var/log/service_check.log 2>&1
```

---

<a name="script-7"></a>

## ✅ Script 7: Find Top 5 Large Files

### Problem Statement
Disk space disappears. You need to **quickly find which files are consuming the most disk space** to clean up or archive them.

```bash
#!/bin/bash
# Script: large_files.sh
# Purpose: Find top 5 files consuming the most disk space
# Usage: sh large_files.sh [directory]
# Production Use: Disk cleanup investigation, storage optimization

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
SEARCH_DIR="${1:-/}"    # Use command line arg or default to root /
# ${1:-/} → use $1 if provided, otherwise use /
TOP_COUNT=5             # Show top N files

echo "=== Top $TOP_COUNT Largest Files ==="
echo "Searching in: $SEARCH_DIR"
echo "Please wait..."
echo ""

# find $SEARCH_DIR  → search in specified directory
# -type f           → only regular files (not directories)
# -exec du -h {} +  → run 'du -h' (disk usage, human-readable) on each file
# 2>/dev/null       → suppress permission denied errors
# sort -rh          → sort by size, reverse (largest first), human-readable
# head -n $TOP_COUNT → show only top N results
find $SEARCH_DIR -type f -exec du -h {} + 2>/dev/null | \
    sort -rh | \
    head -n $TOP_COUNT

echo ""
echo "Search completed at: $(date)"
```

### Expected Output

```
=== Top 5 Largest Files ===
Searching in: /
Please wait...

4.5G    /var/lib/docker/overlay2/abc123/merged/app/data.db
2.1G    /home/ec2-user/backup/backup-2025-03-01.tar.gz
1.8G    /var/log/application/app.log
987M    /tmp/large_temp_file.tmp
456M    /var/cache/yum/x86_64/packages/huge_package.rpm

Search completed at: Mon Mar 3 09:15:00 UTC 2025
```

---

<a name="script-8"></a>

## ✅ Script 8: Show Active SSH Sessions

### Problem Statement
Security monitoring requires knowing **who is currently connected to your servers via SSH** — for auditing and detecting unauthorized access.

```bash
#!/bin/bash
# Script: ssh_sessions.sh
# Purpose: Display all active SSH sessions on the server
# Usage: sh ssh_sessions.sh
# Production Use: Security auditing, unauthorized access detection

echo "=== Active SSH Sessions ==="
echo "Server: $(hostname)"
echo "Check Time: $(date)"
echo ""

# who → shows users currently logged in
# grep "pts" → filter for pseudo-terminal sessions (SSH connections)
# pts = pseudo-terminal slave (created for SSH connections)
SSH_SESSIONS=$(who | grep "pts")

if [ -z "$SSH_SESSIONS" ]; then
    echo "No active SSH sessions found."
else
    echo "Currently connected users:"
    echo "Username    | Terminal | Login Time        | IP Address"
    echo "─────────────────────────────────────────────────────"
    who | grep "pts" | awk '{print $1 " | " $2 " | " $3 " " $4 " | " $5}'
fi

echo ""
echo "Total users logged in: $(who | wc -l)"
echo "Last 5 login attempts:"
# last → shows login history
# head -n 5 → show only 5 most recent
last | head -n 5
```

---

<a name="script-9"></a>

## ✅ Script 9: Check Disk Space and Alert

### Problem Statement
Running out of disk space causes service crashes. You need to **continuously monitor disk usage and alert when it approaches capacity**.

```bash
#!/bin/bash
# Script: disk_alert.sh
# Purpose: Check disk usage and alert if above threshold
# Usage: sh disk_alert.sh
# Production Use: Run every 30 minutes via cron, alert team when disk is filling up

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
THRESHOLD=80              # Alert threshold in percentage
PARTITION="/"             # Partition to monitor (/ = root, can change to /data etc.)
ALERT_EMAIL="ops@company.com"   # Email to alert

echo "=== Disk Space Monitor ==="
echo "Monitoring: $PARTITION"
echo "Threshold: $THRESHOLD%"
echo "Time: $(date)"
echo ""

# df -h $PARTITION  → disk free for specific partition, human-readable
# awk 'NR==2'       → process only line 2 (skip header line 1)
# {print $5}        → print 5th column (use percentage)
# sed 's/%//'       → remove % sign for numeric comparison
DISK_USAGE=$(df -h $PARTITION | awk 'NR==2 {print $5}' | sed 's/%//')

# Get detailed disk info
TOTAL=$(df -h $PARTITION | awk 'NR==2 {print $2}')    # Total size
USED=$(df -h $PARTITION | awk 'NR==2 {print $3}')     # Used space
AVAILABLE=$(df -h $PARTITION | awk 'NR==2 {print $4}')  # Available space

echo "Disk Statistics:"
echo "  Total:     $TOTAL"
echo "  Used:      $USED ($DISK_USAGE%)"
echo "  Available: $AVAILABLE"
echo ""

# Compare disk usage against threshold
if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
    echo "⚠️  ALERT: Disk usage is HIGH!"
    echo "   Current: $DISK_USAGE%"
    echo "   Threshold: $THRESHOLD%"
    echo "   Partition: $PARTITION"
    echo ""
    echo "ACTION REQUIRED: Please clean up disk space on $(hostname)"

    # In production, uncomment to send email alert:
    # echo "Disk usage on $(hostname) is at $DISK_USAGE% (threshold: $THRESHOLD%)" | \
    #     mail -s "⚠️ Disk Alert: $(hostname)" $ALERT_EMAIL
else
    echo "✅ Disk usage is normal: $DISK_USAGE% (Threshold: $THRESHOLD%)"
fi

# Show top space consumers
echo ""
echo "Top 5 directories consuming space:"
du -h $PARTITION 2>/dev/null | sort -rh | head -n 5
```

---

<a name="script-10"></a>

## ✅ Script 10: Simple User Creation

### Problem Statement
In large organizations, DevOps teams often need to **create multiple user accounts quickly** on Linux servers with standard settings.

```bash
#!/bin/bash
# Script: create_user.sh
# Purpose: Create a new Linux user account with default password
# Usage: sh create_user.sh
# Production Use: Onboarding new team members, batch user creation

echo "=== User Creation Script ==="
echo ""

# Prompt for the username to create
echo "Enter the username to create:"
read USERNAME

# Validate: username cannot be empty
if [ -z "$USERNAME" ]; then
    echo "❌ ERROR: Username cannot be empty!"
    exit 1
fi

# Check if user already exists
# id command returns 0 if user exists, non-zero if not
if id "$USERNAME" &>/dev/null; then
    echo "❌ ERROR: User '$USERNAME' already exists!"
    exit 1
fi

# Default password (in production, use a more secure method)
DEFAULT_PASSWORD="Welcome@$(date +%Y)!"    # e.g., Welcome@2025!

# Create the user
# useradd    → add user command
# -m         → create home directory (/home/USERNAME)
# -s /bin/bash → set default shell to bash
sudo useradd -m -s /bin/bash "$USERNAME"

# Check if user creation was successful
if [ $? -ne 0 ]; then
    echo "❌ ERROR: Failed to create user '$USERNAME'"
    exit 1
fi

# Set the password
# echo "USER:PASS" | chpasswd → sets password for user
echo "$USERNAME:$DEFAULT_PASSWORD" | sudo chpasswd

echo ""
echo "✅ User created successfully!"
echo "   Username: $USERNAME"
echo "   Password: $DEFAULT_PASSWORD"
echo "   Home Dir: /home/$USERNAME"
echo ""
echo "⚠️  Please ask user to change password on first login!"
echo "   Command: passwd (after SSH login)"

# Force password change on first login
sudo passwd --expire "$USERNAME"
echo "   Password expiry set: User must change password on first login."
```

---

<a name="script-11"></a>

## ✅ Script 11: Find All Running Docker Containers

### Problem Statement
In a Docker environment, you need to **quickly see the status of all running containers** — especially useful in production monitoring.

```bash
#!/bin/bash
# Script: docker_containers.sh
# Purpose: List all running Docker containers in a formatted table
# Prerequisites: Docker installed and running
# Usage: sh docker_containers.sh
# Production Use: Container health audits, deployment verification

echo "=== Running Docker Containers ==="
echo "Server: $(hostname)"
echo "Time: $(date)"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed!"
    exit 1
fi

# Check if Docker daemon is running
if ! docker info &>/dev/null; then
    echo "❌ Docker daemon is not running!"
    exit 1
fi

# docker ps             → list running containers
# --format              → custom output format
# "table {{.ID}}..."   → display as table with these columns
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

echo ""

# Count running containers
RUNNING=$(docker ps -q | wc -l)         # -q → only show IDs
TOTAL=$(docker ps -a -q | wc -l)        # -a → show ALL (including stopped)
STOPPED=$(( TOTAL - RUNNING ))

echo "Summary:"
echo "  Running containers: $RUNNING"
echo "  Stopped containers: $STOPPED"
echo "  Total containers:   $TOTAL"
```

### Expected Output

```
=== Running Docker Containers ===
Server: ip-172-31-22-45
Time: Mon Mar 3 09:15:00 UTC 2025

CONTAINER ID    NAMES           IMAGE           STATUS          PORTS
a1b2c3d4e5f6    web-app         nginx:latest    Up 2 hours      0.0.0.0:80->80/tcp
b2c3d4e5f6a1    database        mysql:8.0       Up 3 days       3306/tcp
c3d4e5f6a1b2    redis-cache     redis:alpine    Up 5 days       6379/tcp

Summary:
  Running containers: 3
  Stopped containers: 2
  Total containers:   5
```

---

<a name="script-12"></a>

## ✅ Script 12: Delete Old Docker Images

### Problem Statement
Docker images accumulate over time and consume significant disk space. Old, unused images need to be **regularly cleaned up** to free disk space.

```bash
#!/bin/bash
# Script: docker_cleanup.sh
# Purpose: Remove unused Docker images to free disk space
# Usage: sh docker_cleanup.sh
# Production Use: Weekly cleanup cron job, CI/CD pipeline cleanup step

echo "=== Docker Image Cleanup ==="
echo "Started: $(date)"
echo ""

# Show disk usage BEFORE cleanup
echo "Disk usage BEFORE cleanup:"
docker system df    # Shows Docker disk usage overview

echo ""
echo "Starting cleanup..."

# Remove all unused images
# image prune     → remove dangling images (untagged)
# -a              → remove ALL unused images (not just dangling)
# -f              → force (no confirmation prompt)
docker image prune -a -f

# Also remove unused containers, networks, and volumes
echo ""
echo "Removing stopped containers..."
docker container prune -f    # Remove all stopped containers

echo ""
echo "Removing unused networks..."
docker network prune -f      # Remove unused networks

# Show disk usage AFTER cleanup
echo ""
echo "Disk usage AFTER cleanup:"
docker system df

echo ""
echo "✅ Docker cleanup completed at $(date)"
```

---

<a name="script-13"></a>

## ✅ Script 13: Check Kubernetes Node Status

### Problem Statement
Kubernetes nodes can become **NotReady** due to resource exhaustion, network issues, or kernel problems. You need a script to **detect and alert on unhealthy nodes**.

```bash
#!/bin/bash
# Script: k8s_node_status.sh
# Purpose: Check status of all Kubernetes nodes
# Prerequisites: kubectl configured with cluster access
# Usage: sh k8s_node_status.sh

echo "=== Kubernetes Node Status Check ==="
echo "Time: $(date)"
echo ""

# Get all nodes
echo "All Nodes:"
kubectl get nodes

echo ""
echo "─── Problem Nodes ───────────────────"

# kubectl get nodes  → list nodes
# grep -v "Ready"    → show lines NOT containing "Ready"
# This catches: NotReady, Unknown, SchedulingDisabled
PROBLEM_NODES=$(kubectl get nodes | grep -v "Ready" | grep -v "NAME")

if [ -z "$PROBLEM_NODES" ]; then
    echo "✅ All nodes are in Ready state!"
else
    echo "⚠️  UNHEALTHY NODES DETECTED:"
    echo "$PROBLEM_NODES"
    echo ""
    echo "ACTION REQUIRED: Investigate these nodes immediately!"
fi

# Show node resource usage
echo ""
echo "─── Node Resource Usage ──────────────"
kubectl top nodes 2>/dev/null || echo "(kubectl top not available — metrics-server not installed)"
```

---

<a name="script-14"></a>

## ✅ Script 14: Trigger a Jenkins Job via CLI

### Problem Statement
DevOps engineers often need to **trigger Jenkins builds programmatically** — from deployment scripts, monitoring scripts, or other automation.

```bash
#!/bin/bash
# Script: trigger_jenkins.sh
# Purpose: Trigger a Jenkins job via API without opening browser
# Prerequisites: Jenkins URL, job name, user credentials, API token
# Usage: sh trigger_jenkins.sh
# Production Use: Automated deployment triggers, CI/CD pipeline automation

# ─── CONFIGURATION ───────────────────────��────────────────────────────────────
JENKINS_URL="http://your-jenkins-server:8080"   # Your Jenkins URL
JOB_NAME="MyDeploymentJob"                       # Exact Jenkins job name
USER="admin"                                     # Jenkins username
API_TOKEN="your-api-token-here"                  # Jenkins API token
# Get API token: Jenkins → Your User Profile → Configure → API Token

echo "=== Jenkins Job Trigger ==="
echo "Jenkins URL: $JENKINS_URL"
echo "Job: $JOB_NAME"
echo "Triggered at: $(date)"
echo ""

# Check if curl is available
if ! command -v curl &>/dev/null; then
    echo "❌ curl is not installed!"
    exit 1
fi

# Trigger the Jenkins job via API
# curl -X POST   → make HTTP POST request
# --user         → authenticate with user:token
# URL pattern    → /job/JOBNAME/build triggers the build
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
    -X POST \
    "$JENKINS_URL/job/$JOB_NAME/build" \
    --user "$USER:$API_TOKEN")

# Check HTTP response code
if [ "$HTTP_CODE" -eq 201 ] || [ "$HTTP_CODE" -eq 200 ]; then
    echo "✅ Jenkins job '$JOB_NAME' triggered successfully!"
    echo "   HTTP Response: $HTTP_CODE"
    echo ""
    echo "Monitor build at: $JENKINS_URL/job/$JOB_NAME"
elif [ "$HTTP_CODE" -eq 403 ]; then
    echo "❌ Authentication failed! Check your API token."
    exit 1
elif [ "$HTTP_CODE" -eq 404 ]; then
    echo "❌ Job '$JOB_NAME' not found!"
    exit 1
else
    echo "❌ Unexpected response: HTTP $HTTP_CODE"
    exit 1
fi
```

---

<a name="script-15"></a>

## ✅ Script 15: Check Jenkins Job Status

```bash
#!/bin/bash
# Script: jenkins_status.sh
# Purpose: Check the status of the last Jenkins build
# Usage: sh jenkins_status.sh

JENKINS_URL="http://your-jenkins-server:8080"
JOB_NAME="MyDeploymentJob"
USER="admin"
API_TOKEN="your-api-token-here"

echo "=== Jenkins Job Status ==="
echo "Job: $JOB_NAME"
echo "Checking at: $(date)"
echo ""

# Fetch last build status as JSON
# curl -s        → silent mode (no progress meter)
# api/json       → Jenkins REST API endpoint
# jq -r '.result' → parse JSON and extract "result" field
# jq must be installed: sudo yum install jq -y
RESULT=$(curl -s \
    "$JENKINS_URL/job/$JOB_NAME/lastBuild/api/json" \
    --user "$USER:$API_TOKEN" | \
    jq -r '.result')

BUILD_NUM=$(curl -s \
    "$JENKINS_URL/job/$JOB_NAME/lastBuild/api/json" \
    --user "$USER:$API_TOKEN" | \
    jq -r '.number')

echo "Last Build #: $BUILD_NUM"
echo "Build Status: $RESULT"

# Act on build status
case $RESULT in
    "SUCCESS")
        echo "✅ Build SUCCEEDED"
        ;;
    "FAILURE")
        echo "❌ Build FAILED — Check build logs!"
        ;;
    "UNSTABLE")
        echo "⚠️  Build is UNSTABLE — Some tests failed"
        ;;
    "ABORTED")
        echo "🛑 Build was ABORTED"
        ;;
    "null"|"")
        echo "🔄 Build is still IN PROGRESS or status unavailable"
        ;;
    *)
        echo "❓ Unknown status: $RESULT"
        ;;
esac
```

---

<a name="script-16"></a>

## ✅ Script 16: Restart All Pods in a Namespace

```bash
#!/bin/bash
# Script: restart_pods.sh
# Purpose: Force restart all pods in a given namespace
# WARNING: This causes downtime! Use only when intentional.
# Usage: sh restart_pods.sh [namespace]

NAMESPACE="${1:-default}"    # Accept namespace as argument, default to "default"

echo "=== Pod Restart Script ==="
echo "⚠️  WARNING: This will restart ALL pods in namespace: $NAMESPACE"
echo ""

# Show current pods
echo "Current pods:"
kubectl get pods -n $NAMESPACE

echo ""
echo "Press ENTER to continue or Ctrl+C to cancel..."
read    # Wait for user confirmation

echo "Restarting all pods in '$NAMESPACE'..."

# kubectl delete pods --all → delete all pods (Kubernetes auto-recreates them)
# -n $NAMESPACE → in specified namespace
# --grace-period=0 → immediate deletion (no graceful shutdown)
# --force → force deletion even if pods are stuck
kubectl delete pods --all -n $NAMESPACE --grace-period=0 --force

echo "Waiting for pods to restart..."
sleep 10    # Give pods time to start coming up

# Show new pod status
echo "New pod status:"
kubectl get pods -n $NAMESPACE

echo ""
echo "✅ Pod restart completed at $(date)"
```

---

## ✅ Script 17: Monitor Kubernetes Pod Status

```bash
#!/bin/bash
# Script: k8s_pod_watch.sh
# Purpose: Continuously watch Kubernetes pod status changes in real-time
# Usage: sh k8s_pod_watch.sh [namespace]
# Press Ctrl+C to stop watching

NAMESPACE="${1:-default}"    # Use provided namespace or default to "default"

echo "=== Kubernetes Pod Monitor ==="
echo "Namespace: $NAMESPACE"
echo "Started at: $(date)"
echo "Press Ctrl+C to stop watching"
echo ""

# Check if kubectl is available
if ! command -v kubectl &>/dev/null; then
    echo "❌ kubectl is not installed or not in PATH"
    exit 1
fi

# Show current pod status first (snapshot)
echo "Current pod status:"
kubectl get pods -n $NAMESPACE
echo ""
echo "─── Live Updates Below ──────────────────────"

# kubectl get pods --watch   → streams real-time changes to pod status
# -n $NAMESPACE              → in the specified namespace
# Any pod state change (Pending → Running, Running → Error, etc.) shows instantly
kubectl get pods -n $NAMESPACE --watch
# This command keeps running until you press Ctrl+C
# Output updates line by line as pod states change
```

### Expected Output

```
=== Kubernetes Pod Monitor ===
Namespace: default
Started at: Mon Mar 3 09:15:00 UTC 2025
Press Ctrl+C to stop watching

Current pod status:
NAME                     READY   STATUS    RESTARTS   AGE
web-deployment-abc123    1/1     Running   0          2h
db-pod-xyz456            1/1     Running   0          3d

─── Live Updates Below ──────────────────────
NAME                     READY   STATUS    RESTARTS   AGE
web-deployment-abc123    1/1     Running   0          2h
db-pod-xyz456            1/1     Running   0          3d
new-pod-def789           0/1     Pending   0          0s
new-pod-def789           0/1     ContainerCreating   0   2s
new-pod-def789           1/1     Running   0          5s
```

### Where It's Used

- **Production:** Real-time deployment monitoring — watch pods come up after a rolling update
- **Incident Response:** Watch pods recover after a crash
- **CI/CD:** Verify new pods are healthy after deployment

### Interview Relevance

> "I use `kubectl get pods --watch` in scripts to monitor rolling deployments. It streams pod state changes live, so I can detect failures immediately without polling."

---

## ✅ Script 18: Check System Uptime

### Problem Statement
You need to know **how long a server has been running** — critical for maintenance windows, capacity planning, and troubleshooting intermittent issues that occur after reboots.

```bash
#!/bin/bash
# Script: system_uptime.sh
# Purpose: Display how long the system has been running with detailed breakdown
# Usage: sh system_uptime.sh
# Production Use: Pre-maintenance checks, incident reports, health dashboards

echo "=== System Uptime Report ==="
echo "Server: $(hostname)"           # Print server hostname
echo "Checked at: $(date)"           # Print current date and time
echo ""

# ─── BASIC UPTIME ─────────────────────────────────────────────────────────────
echo "─── Uptime Summary ──────────────────────────"

# uptime      → shows current time, uptime, users, load average
# Full output: 09:15:00 up 5 days, 3:22, 2 users, load average: 0.10, 0.08, 0.05
uptime

echo ""

# uptime -p   → human-readable uptime ONLY (e.g., "up 5 days, 3 hours, 22 minutes")
# -p          → pretty format (cleaner output than plain uptime)
echo "Uptime (readable): $(uptime -p)"

# uptime -s   → shows exact date/time system was last started
# -s          → since when (boot time)
echo "System boot time:  $(uptime -s)"

echo ""
echo "─── Load Average ────────────────────────────"

# /proc/loadavg → kernel file containing live load average data
# awk '{print...}' → extract the 3 load values (1min, 5min, 15min averages)
LOAD=$(cat /proc/loadavg | awk '{print "1 min: "$1 "  |  5 min: "$2 "  |  15 min: "$3}')
echo "CPU Load Average:"
echo "  $LOAD"
echo "  (Values below 1.0 per CPU core = healthy)"

echo ""
echo "─── Currently Logged In Users ───────────────"

# who      → lists currently logged in users with terminal and login time
# wc -l    → count number of lines = number of users
USER_COUNT=$(who | wc -l)
echo "Users currently logged in: $USER_COUNT"
who    # List each logged-in user

echo ""
echo "=== Uptime Report Complete ==="
```

### Expected Output

```
=== System Uptime Report ===
Server: ip-172-31-22-45
Checked at: Mon Mar 3 09:15:00 UTC 2025

─── Uptime Summary ──────────────────────────
 09:15:00 up 5 days,  3:22,  2 users,  load average: 0.10, 0.08, 0.05

Uptime (readable): up 5 days, 3 hours, 22 minutes
System boot time:  2025-02-26 05:52:47

─── Load Average ────────────────────────────
CPU Load Average:
  1 min: 0.10  |  5 min: 0.08  |  15 min: 0.05
  (Values below 1.0 per CPU core = healthy)

─── Currently Logged In Users ───────────────
Users currently logged in: 2
ec2-user pts/0        2025-03-03 08:45 (203.0.113.1)
ec2-user pts/1        2025-03-03 09:10 (203.0.113.2)

=== Uptime Report Complete ===
```

### Where It's Used

- **Pre-maintenance:** Confirm server has been running stably before a change window
- **Incident response:** Check if server recently rebooted unexpectedly
- **Capacity planning:** High load average = server needs scaling

---

## ✅ Script 19: Check Disk Space Usage

### Problem Statement
You need a **comprehensive disk space report** across all mounted filesystems to identify which partitions are at risk of filling up.

```bash
#!/bin/bash
# Script: disk_space.sh
# Purpose: Comprehensive disk space usage report for all partitions
# Usage: sh disk_space.sh
# Production Use: Daily disk reports, pre-deployment space checks

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
WARNING_THRESHOLD=70     # Warn at 70% usage
CRITICAL_THRESHOLD=90    # Critical at 90% usage

echo "=== Disk Space Usage Report ==="
echo "Server: $(hostname)"
echo "Report Time: $(date)"
echo ""

# ─── FULL DISK REPORT ─────────────────────────────────────────────────────────
echo "─── All Filesystems ──────────────────────────"

# df         → disk free command
# -h         → human-readable sizes (GB, MB instead of bytes)
# -T         → show filesystem type (ext4, xfs, tmpfs, etc.)
# --exclude-type=tmpfs    → skip tmpfs (temporary virtual filesystems)
# --exclude-type=devtmpfs → skip device filesystems
df -hT --exclude-type=tmpfs --exclude-type=devtmpfs

echo ""
echo "─── Partition Status Check ───────────────────"

# Loop through each partition and check usage level
# df -h       → human-readable
# --output=target,pcent → show only mount point and percent used
# NR>1        → skip header line (line 1)
# gsub(/%/,"") → remove % sign from percentage for numeric comparison
df -h --output=target,pcent | awk 'NR>1 {
    gsub(/%/, "", $2)           # Remove % sign
    if ($2+0 >= 90) {           # Critical: >= 90%
        print "❌ CRITICAL: " $1 " is at " $2 "%"
    } else if ($2+0 >= 70) {    # Warning: >= 70%
        print "⚠️  WARNING:  " $1 " is at " $2 "%"
    } else {                    # Healthy: below 70%
        print "✅ OK:        " $1 " is at " $2 "%"
    }
}'

echo ""
echo "─── Disk Summary ─────────────────────────────"

# Show root partition details
ROOT_USAGE=$(df -h / | awk 'NR==2 {print $3 " used out of " $2 " (" $5 " used, " $4 " free)"}')
echo "Root partition (/): $ROOT_USAGE"

echo ""
echo "─── Top 10 Largest Directories ──────────────"

# du -h /     → disk usage of all directories under root
# 2>/dev/null → suppress "permission denied" errors
# sort -rh    → sort by size (largest first), human-readable aware
# head -n 10  → show only top 10
du -h / 2>/dev/null | sort -rh | head -n 10

echo ""
echo "=== Report Complete ==="
```

### Expected Output

```
=== Disk Space Usage Report ===
Server: ip-172-31-22-45
Report Time: Mon Mar 3 09:15:00 UTC 2025

─── All Filesystems ──────────────────────────
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/xvda1     xfs     20G   12G  8.0G  60% /
/dev/xvdb1     ext4   100G   85G   15G  85% /data
tmpfs          tmpfs  982M     0  982M   0% /dev/shm

─── Partition Status Check ───────────────────
✅ OK:        / is at 60%
⚠️  WARNING:  /data is at 85%

─── Disk Summary ─────────────────────────────
Root partition (/): 12G used out of 20G (60% used, 8.0G free)
```

---

## ✅ Script 20: Check CPU & Memory Usage

### Problem Statement
You need a **real-time snapshot of CPU and RAM usage** to quickly assess server health and identify resource bottlenecks.

```bash
#!/bin/bash
# Script: cpu_memory.sh
# Purpose: Display detailed CPU and Memory usage statistics
# Usage: sh cpu_memory.sh
# Production Use: Performance baseline reports, incident triage

echo "=== CPU & Memory Usage Report ==="
echo "Server: $(hostname)"
echo "Time: $(date)"
echo ""

# ─── CPU INFORMATION ─────────────────────────────────��────────────────────────
echo "─── CPU Usage ────────────────────────────────"

# top -b      → batch mode (non-interactive, output to stdout)
# -n1         → only run 1 iteration (single snapshot, don't keep refreshing)
# grep "Cpu(s)" → filter only the CPU statistics line
# Output: %Cpu(s):  2.3 us,  0.7 sy,  0.0 ni, 96.7 id,  0.3 wa
CPU_LINE=$(top -b -n1 | grep "Cpu(s)")
echo "$CPU_LINE"
echo ""

# Extract individual CPU metrics using awk
# $2 = user space %, $4 = system %, $8 = idle %
CPU_USER=$(echo "$CPU_LINE" | awk '{print $2}')     # User processes
CPU_SYS=$(echo "$CPU_LINE" | awk '{print $4}')      # System/kernel processes
CPU_IDLE=$(echo "$CPU_LINE" | awk '{print $8}')     # Idle (not used)
CPU_USED=$(echo "$CPU_LINE" | awk '{print $2 + $4}')  # Total in use

echo "  User processes:   $CPU_USER%"
echo "  System processes: $CPU_SYS%"
echo "  Total CPU in use: $CPU_USED%"
echo "  CPU Idle:         $CPU_IDLE%"

# Show number of CPU cores
CPU_CORES=$(nproc)   # nproc → prints number of processing units
echo "  CPU Cores:        $CPU_CORES"

echo ""

# ─── MEMORY INFORMATION ───────────────────────────────────────────────────────
echo "─── Memory Usage ─────────────────────────────"

# free        → display memory stats
# -m          → show in Megabytes (easier to read than bytes)
echo "Raw memory stats (MB):"
free -m

echo ""

# Extract specific values for a cleaner summary
# free -m              → output in MB
# grep "^Mem:"         → get the line starting with "Mem:"
# awk '{...}'          → extract total, used, free columns
TOTAL_MEM=$(free -m | grep "^Mem:" | awk '{print $2}')   # Total RAM in MB
USED_MEM=$(free -m | grep "^Mem:" | awk '{print $3}')    # Used RAM in MB
FREE_MEM=$(free -m | grep "^Mem:" | awk '{print $4}')    # Free RAM in MB
CACHED_MEM=$(free -m | grep "^Mem:" | awk '{print $6}')  # Cached RAM in MB

# Calculate usage percentage
# Use awk for floating point arithmetic (shell can't do decimals)
MEM_PERCENT=$(awk "BEGIN {printf \"%.1f\", ($USED_MEM/$TOTAL_MEM)*100}")

echo "Memory Summary:"
echo "  Total RAM:    ${TOTAL_MEM} MB"
echo "  Used:         ${USED_MEM} MB (${MEM_PERCENT}%)"
echo "  Free:         ${FREE_MEM} MB"
echo "  Cached:       ${CACHED_MEM} MB"

echo ""

# ─── SWAP USAGE ───────────────────────────────────────────────────────────────
echo "─── Swap Usage ───────────────────────────────"
SWAP_TOTAL=$(free -m | grep "^Swap:" | awk '{print $2}')
SWAP_USED=$(free -m | grep "^Swap:" | awk '{print $3}')

if [ "$SWAP_TOTAL" -eq 0 ]; then
    echo "  No swap configured on this system."
else
    echo "  Swap Total: ${SWAP_TOTAL} MB"
    echo "  Swap Used:  ${SWAP_USED} MB"
    # High swap usage = RAM is full, system is swapping to disk (SLOW!)
    if [ "$SWAP_USED" -gt "$(( SWAP_TOTAL / 2 ))" ]; then
        echo "  ⚠️  WARNING: More than 50% swap in use — consider adding RAM!"
    fi
fi

echo ""
echo "─── Top 5 Memory-Consuming Processes ─────────"

# ps aux        → show all processes with resource usage
# --sort=-%mem  → sort by memory usage, highest first (- = descending)
# awk 'NR>1'    → skip header line
# head -n 5     → show only top 5
ps aux --sort=-%mem | awk 'NR>1 {printf "%-20s %5s%% %5s%%\n", $11, $3, $4}' | head -n 5
# $11 = command name, $3 = CPU%, $4 = MEM%

echo "(Format: Process | CPU% | MEM%)"

echo ""
echo "=== Report Complete ==="
```

### Expected Output

```
=== CPU & Memory Usage Report ===
Server: ip-172-31-22-45
Time: Mon Mar 3 09:15:00 UTC 2025

─── CPU Usage ────────────────────────────────
%Cpu(s):  5.2 us,  1.3 sy,  0.0 ni, 93.0 id,  0.3 wa, 0.0 hi, 0.2 si
  User processes:   5.2%
  System processes: 1.3%
  Total CPU in use: 6.5%
  CPU Idle:         93.0%
  CPU Cores:        2

─── Memory Usage ─────────────────────────────
Raw memory stats (MB):
              total        used        free      shared  buff/cache   available
Mem:           1983         892         123          17         968         918
Swap:             0           0           0

Memory Summary:
  Total RAM:    1983 MB
  Used:         892 MB (45.0%)
  Free:         123 MB
  Cached:       968 MB

─── Swap Usage ───────────────────────────────
  No swap configured on this system.

─── Top 5 Memory-Consuming Processes ─────────
java                  15.2%  18.5%
mysqld                 8.1%  12.3%
nginx                  0.2%   0.8%
sshd                   0.0%   0.1%
bash                   0.0%   0.1%
(Format: Process | CPU% | MEM%)
```

---

## ✅ Script 21: Backup a Directory

### Problem Statement
You need to **create timestamped compressed backups** of a specific directory (such as application files or configuration) automatically and regularly.

```bash
#!/bin/bash
# Script: backup_dir.sh
# Purpose: Create a timestamped compressed backup of a specified directory
# Usage: sh backup_dir.sh [source_dir] [backup_dir]
# Production Use: Application data backup, config backup before deployments

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
# Use command line arguments if provided, otherwise use defaults
SRC_DIR="${1:-/home/ec2-user/data}"       # Directory to back up
BACKUP_DIR="${2:-/home/ec2-user/backup}"  # Where to store backups
MAX_BACKUPS=7       # Keep only last 7 backups (auto-delete older ones)
LOG_FILE="$BACKUP_DIR/backup.log"         # Backup log file

# Create timestamp for unique backup filename
# date +"%Y-%m-%d_%H-%M-%S" → format: 2025-03-03_09-15-30
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_${TIMESTAMP}.tar.gz"

echo "=== Directory Backup Script ==="
echo "Source:      $SRC_DIR"
echo "Destination: $BACKUP_DIR"
echo "Backup file: $BACKUP_FILE"
echo "Started at:  $(date)"
echo ""

# ─── PRE-FLIGHT CHECKS ────────────────────────────────────────────────────────

# Check if source directory exists
if [ ! -d "$SRC_DIR" ]; then
    echo "❌ ERROR: Source directory does not exist: $SRC_DIR"
    exit 1
fi

# Check if source directory has any files
if [ -z "$(ls -A $SRC_DIR 2>/dev/null)" ]; then
    echo "⚠️  WARNING: Source directory is empty: $SRC_DIR"
    # Continue anyway — empty backup is still valid
fi

# Create backup directory if it doesn't exist
# mkdir -p → create directory and any missing parent directories
mkdir -p "$BACKUP_DIR"

# Check available disk space before backup
SRC_SIZE=$(du -sm "$SRC_DIR" 2>/dev/null | awk '{print $1}')  # Size in MB
AVAIL_SPACE=$(df -m "$BACKUP_DIR" | awk 'NR==2 {print $4}')   # Available MB

echo "Source size:        ~${SRC_SIZE} MB"
echo "Available space:     ${AVAIL_SPACE} MB"

# Warn if available space is less than 2x the source size (for safety margin)
if [ "$AVAIL_SPACE" -lt "$(( SRC_SIZE * 2 ))" ]; then
    echo "⚠️  WARNING: Low disk space! Available: ${AVAIL_SPACE}MB, Needed: ~${SRC_SIZE}MB"
fi

echo ""

# ─── PERFORM BACKUP ───────────────────────────────────────────────────────────
echo "Creating backup..."

# tar  → tape archive command (used for creating compressed archives)
# -c   → create a new archive
# -z   → compress using gzip (reduces file size significantly)
# -v   → verbose (shows files being added — remove for silent operation)
# -f   → specifies the output filename
tar -czf "$BACKUP_FILE" "$SRC_DIR" 2>&1

# Check if tar command succeeded
# $? → exit code of last command (0 = success, non-zero = failure)
if [ $? -eq 0 ]; then
    BACKUP_SIZE=$(du -sh "$BACKUP_FILE" | awk '{print $1}')
    echo "✅ Backup created successfully!"
    echo "   File: $BACKUP_FILE"
    echo "   Size: $BACKUP_SIZE"

    # Log the backup event
    echo "$(date): SUCCESS - Backup created: $BACKUP_FILE (size: $BACKUP_SIZE)" >> "$LOG_FILE"
else
    echo "❌ Backup FAILED!"
    echo "$(date): FAILED - Backup creation failed for: $SRC_DIR" >> "$LOG_FILE"
    exit 1
fi

# ─── ROTATE OLD BACKUPS ───────────────────────────────────────────────────────
echo ""
echo "Rotating old backups (keeping last $MAX_BACKUPS)..."

# ls -t         → list files sorted by time (newest first)
# grep ".tar.gz" → only backup files
# tail -n +N    → skip first N files (keep newest N, delete the rest)
# xargs rm -f   → delete the remaining (old) files
ls -t "$BACKUP_DIR"/*.tar.gz 2>/dev/null | \
    tail -n "+$(( MAX_BACKUPS + 1 ))" | \
    xargs -r rm -f
# -r in xargs → don't run if no input (prevents error when nothing to delete)

# Show remaining backups
BACKUP_COUNT=$(ls "$BACKUP_DIR"/*.tar.gz 2>/dev/null | wc -l)
echo "Current backups stored: $BACKUP_COUNT"
ls -lh "$BACKUP_DIR"/*.tar.gz 2>/dev/null

echo ""
echo "=== Backup Complete at $(date) ==="
```

### Expected Output

```
=== Directory Backup Script ===
Source:      /home/ec2-user/data
Destination: /home/ec2-user/backup
Backup file: /home/ec2-user/backup/backup_2025-03-03_09-15-30.tar.gz
Started at:  Mon Mar 3 09:15:30 UTC 2025

Source size:        ~45 MB
Available space:     8024 MB

Creating backup...
✅ Backup created successfully!
   File: /home/ec2-user/backup/backup_2025-03-03_09-15-30.tar.gz
   Size: 12M

Rotating old backups (keeping last 7)...
Current backups stored: 5
-rw-r--r-- 1 ec2-user ec2-user 12M Mar 3 09:15 backup_2025-03-03_09-15-30.tar.gz
-rw-r--r-- 1 ec2-user ec2-user 11M Mar 2 09:15 backup_2025-03-02_09-15-22.tar.gz
...

=== Backup Complete at Mon Mar 3 09:15:32 UTC 2025 ===
```

### Cron Schedule (Daily at 2AM)

```bash
0 2 * * * /home/ec2-user/backup_dir.sh /home/ec2-user/data /home/ec2-user/backup >> /var/log/backup.log 2>&1
```

---

## ✅ Script 22: Create User with Required Permissions

### Problem Statement
When onboarding team members or creating service accounts, you need to **create Linux users and configure precise file permissions** in one automated step.

```bash
#!/bin/bash
# Script: create_user_with_perms.sh
# Purpose: Create a user and set specific file permissions on their home directory
# Usage: sh create_user_with_perms.sh
# Production Use: User onboarding, service account creation, security provisioning

# ─── FUNCTION: Set permissions on user's home directory ───────────────────────
set_permissions() {
    local username=$1       # local → variable only exists inside this function
    local user_perms=$2     # Permissions for the user (owner)
    local group_perms=$3    # Permissions for the group
    local others_perms=$4   # Permissions for everyone else

    # eval echo ~$username → expands to user's home directory path
    # e.g., ~john → /home/john
    local user_home=$(eval echo ~$username)

    echo "Setting permissions on: $user_home"

    # chmod u=perms,g=perms,o=perms
    # u = user (owner), g = group, o = others
    # r = read, w = write, x = execute, - = no permission
    chmod u=$user_perms,g=$group_perms,o=$others_perms "$user_home"

    if [ $? -eq 0 ]; then
        echo "✅ Permissions set successfully!"
        echo "   Owner ($username): $user_perms"
        echo "   Group:             $group_perms"
        echo "   Others:            $others_perms"
        echo "   Home directory:    $user_home"

        # Show the result
        ls -ld "$user_home"    # -d → show directory info, not contents
    else
        echo "❌ Failed to set permissions on $user_home"
    fi
}

# ─── MAIN SCRIPT ──────────────────────────────────────────────────────────────
echo "=== User Creation with Permissions ==="
echo ""

# Step 1: Get username
echo "Enter the username to create:"
read username

# Validate username is not empty
if [ -z "$username" ]; then
    echo "❌ ERROR: Username cannot be empty!"
    exit 1
fi

# Validate username has no special characters (only letters, numbers, underscore)
if [[ ! "$username" =~ ^[a-zA-Z][a-zA-Z0-9_-]*$ ]]; then
    echo "❌ ERROR: Invalid username! Use only letters, numbers, underscore, hyphen."
    echo "   Must start with a letter."
    exit 1
fi

# Step 2: Check if user already exists
# id "$username" → returns 0 if user exists
# &>/dev/null    → suppress all output (we only care about exit code)
if id "$username" &>/dev/null; then
    echo "❌ ERROR: User '$username' already exists!"
    exit 1
fi

# Step 3: Create the user
echo "Creating user: $username"

# useradd       → add a new user to the system
# -m            → create home directory (/home/username)
# -s /bin/bash  → set bash as the default shell
sudo useradd -m -s /bin/bash "$username"

if [ $? -eq 0 ]; then
    echo "✅ User '$username' created successfully."
else
    echo "❌ Failed to create user '$username'."
    exit 1
fi

# Step 4: Collect permission inputs
echo ""
echo "─── Set Home Directory Permissions ──────────"
echo "Enter permissions for each category."
echo "Format examples:"
echo "  rwx = read + write + execute (full access)"
echo "  r-x = read + execute (no write)"
echo "  r-- = read only"
echo "  --- = no permissions"
echo ""

echo "Permissions for USER (owner):"
read user_perms

echo "Permissions for GROUP:"
read group_perms

echo "Permissions for OTHERS (everyone else):"
read others_perms

# Step 5: Validate permission format
# Regex: must be exactly 3 chars, each being r/w/x or -
if [[ ! "$user_perms" =~ ^[r-][w-][x-]$ ]] || \
   [[ ! "$group_perms" =~ ^[r-][w-][x-]$ ]] || \
   [[ ! "$others_perms" =~ ^[r-][w-][x-]$ ]]; then
    echo "❌ ERROR: Invalid permissions format!"
    echo "   Use format like: rwx, r-x, r--, ---"
    exit 1
fi

# Step 6: Apply permissions using our function
echo ""
set_permissions "$username" "$user_perms" "$group_perms" "$others_perms"

echo ""
echo "=== User Setup Complete ==="
echo "Username: $username"
echo "Home:     /home/$username"
echo ""
echo "⚠️  Remember to set a password:"
echo "   sudo passwd $username"
```

### Expected Output

```
=== User Creation with Permissions ===

Enter the username to create:
devops_john

Creating user: devops_john
✅ User 'devops_john' created successfully.

─── Set Home Directory Permissions ──────────
Enter permissions for each category.
...

Permissions for USER (owner):
rwx
Permissions for GROUP:
r-x
Permissions for OTHERS (everyone else):
---

Setting permissions on: /home/devops_john
✅ Permissions set successfully!
   Owner (devops_john): rwx
   Group:               r-x
   Others:              ---
   Home directory:      /home/devops_john
drwxr-x--- 2 devops_john devops_john 62 Mar 3 09:15 /home/devops_john

=== User Setup Complete ===
Username: devops_john
Home:     /home/devops_john

⚠��  Remember to set a password:
   sudo passwd devops_john
```

---

## ✅ Script 23: List AWS EC2 Instances with Public IPs

### Problem Statement
When managing a fleet of EC2 instances, you need to **quickly retrieve all instance IDs and their public IP addresses** without logging into the AWS console.

```bash
#!/bin/bash
# Script: list_ec2.sh
# Purpose: List all EC2 instances with their IDs, state, and public IPs
# Prerequisites: AWS CLI installed + configured (aws configure)
# Usage: sh list_ec2.sh [region]
# Production Use: Infrastructure audits, IP inventory, SSH automation

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
AWS_REGION="${1:-us-east-1}"    # Use provided region or default to us-east-1

echo "=== AWS EC2 Instance Inventory ==="
echo "Region: $AWS_REGION"
echo "Generated at: $(date)"
echo ""

# Check if AWS CLI is installed
if ! command -v aws &>/dev/null; then
    echo "❌ AWS CLI is not installed!"
    echo "   Install: curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o awscliv2.zip && unzip awscliv2.zip && sudo ./aws/install"
    exit 1
fi

# Check if AWS credentials are configured
if ! aws sts get-caller-identity &>/dev/null; then
    echo "❌ AWS credentials not configured or expired!"
    echo "   Run: aws configure"
    exit 1
fi

echo "─── All EC2 Instances ────────────────────────"

# aws ec2 describe-instances   → fetch all EC2 instance details
# --query                      → JMESPath query to filter/format output
# "Reservations[*].Instances[*].[InstanceId, State.Name, PublicIpAddress, PrivateIpAddress, Tags[?Key=='Name'].Value|[0]]"
#   → Extract: Instance ID, State, Public IP, Private IP, Name tag
# --output table               → format as readable table
# --region $AWS_REGION         → specify AWS region
aws ec2 describe-instances \
    --query "Reservations[*].Instances[*].[
        InstanceId,
        State.Name,
        PublicIpAddress,
        PrivateIpAddress,
        Tags[?Key=='Name'].Value|[0]
    ]" \
    --output table \
    --region "$AWS_REGION"

echo ""
echo "─── Summary ──────────────────────────────────"

# Count instances by state
RUNNING=$(aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].InstanceId" \
    --output text \
    --region "$AWS_REGION" | wc -w)

STOPPED=$(aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=stopped" \
    --query "Reservations[*].Instances[*].InstanceId" \
    --output text \
    --region "$AWS_REGION" | wc -w)

echo "Running instances: $RUNNING"
echo "Stopped instances: $STOPPED"
echo "Total:             $(( RUNNING + STOPPED ))"

echo ""
echo "=== Inventory Complete ==="
```

### Expected Output

```
=== AWS EC2 Instance Inventory ===
Region: us-east-1
Generated at: Mon Mar 3 09:15:00 UTC 2025

─── All EC2 Instances ────────────────────────
--------------------------------------------------------------------------------------
|                           DescribeInstances                                        |
+---------------------+----------+---------------+----------------+------------------+
|  i-0abc123def456789 | running  | 54.23.45.67   | 172.31.22.45   | web-server-prod  |
|  i-0def456abc123789 | running  | 54.23.45.89   | 172.31.22.67   | db-server-prod   |
|  i-0789abc123def456 | stopped  | None          | 172.31.22.89   | dev-server       |
+---------------------+----------+---------------+----------------+------------------+

─── Summary ──────────────────────────────────
Running instances: 2
Stopped instances: 1
Total:             3

=== Inventory Complete ===
```

---

## ✅ Script 24: Backup Docker Containers and Images

### Problem Statement
Before major Docker environment changes or migrations, you need to **backup all running containers and images** as tar files so they can be restored if something goes wrong.

```bash
#!/bin/bash
# Script: docker_backup.sh
# Purpose: Backup all running Docker containers and save all images as tar files
# Prerequisites: Docker installed and running
# Usage: sh docker_backup.sh [backup_directory]
# Production Use: Pre-migration backup, disaster recovery preparation

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
BACKUP_DIR="${1:-/backup/docker}"    # Where to store Docker backups
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")  # Timestamp for this backup run
BACKUP_PATH="$BACKUP_DIR/$TIMESTAMP" # Unique folder per backup run

echo "=== Docker Backup Script ==="
echo "Backup location: $BACKUP_PATH"
echo "Started at: $(date)"
echo ""

# Check if Docker is running
if ! docker info &>/dev/null; then
    echo "❌ Docker daemon is not running!"
    exit 1
fi

# Create backup directory structure
# -p → create all parent directories if they don't exist
mkdir -p "$BACKUP_PATH/containers"   # Folder for container backups
mkdir -p "$BACKUP_PATH/images"       # Folder for image backups

# ─── BACKUP RUNNING CONTAINERS ────────────────────────────────────────────────
echo "─── Backing Up Running Containers ───────────"

# docker ps -q → list only the IDs of running containers
# -q (quiet) = only IDs, no other columns
CONTAINER_IDS=$(docker ps -q)

if [ -z "$CONTAINER_IDS" ]; then
    echo "No running containers found to backup."
else
    # Loop through each running container
    for container_id in $CONTAINER_IDS; do
        # Get a clean name for the container (replace / with _ for filename)
        container_name=$(docker inspect --format='{{.Name}}' $container_id | sed 's|/||')

        echo "Backing up container: $container_name ($container_id)"

        # docker commit → create a NEW image from the container's current state
        # This captures any runtime changes made to the container's filesystem
        # $container_id          → source container
        # "${container_name}-backup" → name of the new backup image
        docker commit "$container_id" "${container_name}-backup"

        if [ $? -eq 0 ]; then
            # docker save → export an image to a tar archive file
            # -o "$BACKUP_PATH/containers/${container_name}.tar" → output file path
            # "${container_name}-backup" → the image we just committed
            docker save -o "$BACKUP_PATH/containers/${container_name}.tar" \
                "${container_name}-backup"

            if [ $? -eq 0 ]; then
                SIZE=$(du -sh "$BACKUP_PATH/containers/${container_name}.tar" | awk '{print $1}')
                echo "   ✅ Saved: ${container_name}.tar ($SIZE)"
            else
                echo "   ❌ Failed to save tar for: $container_name"
            fi

            # Clean up the temporary backup image we created
            docker rmi "${container_name}-backup" &>/dev/null
        else
            echo "   ❌ Failed to commit container: $container_name"
        fi
    done
fi

echo ""

# ─── BACKUP ALL DOCKER IMAGES ─────────────────────────────────────────────────
echo "─── Saving All Docker Images ─────────────────"

# docker images -q → list only the IDs of all local images
IMAGE_IDS=$(docker images -q | sort -u)   # sort -u → remove duplicates

if [ -z "$IMAGE_IDS" ]; then
    echo "No images found to backup."
else
    for image_id in $IMAGE_IDS; do
        # Get image name and tag for a descriptive filename
        # Format: repository:tag → replace : and / with _ for safe filename
        image_name=$(docker inspect --format='{{.RepoTags}}' $image_id | \
            tr -d '[]' | \
            sed 's/[:/]/_/g' | \
            awk '{print $1}')

        # If no tag, use image ID as filename
        if [ -z "$image_name" ] || [ "$image_name" = "" ]; then
            image_name="image_${image_id}"
        fi

        echo "Saving image: $image_name ($image_id)"

        # docker save → export the image as a tar file
        # -o → output file
        docker save -o "$BACKUP_PATH/images/${image_name}.tar" "$image_id"

        if [ $? -eq 0 ]; then
            SIZE=$(du -sh "$BACKUP_PATH/images/${image_name}.tar" | awk '{print $1}')
            echo "   ✅ Saved: ${image_name}.tar ($SIZE)"
        else
            echo "   ❌ Failed to save image: $image_name"
        fi
    done
fi

# ─── BACKUP SUMMARY ───────────────────────────────────────────────────────────
echo ""
echo "─── Backup Summary ───────────────────────────"

CONTAINER_BACKUPS=$(ls "$BACKUP_PATH/containers/" 2>/dev/null | wc -l)
IMAGE_BACKUPS=$(ls "$BACKUP_PATH/images/" 2>/dev/null | wc -l)
TOTAL_SIZE=$(du -sh "$BACKUP_PATH" | awk '{print $1}')

echo "Container backups: $CONTAINER_BACKUPS"
echo "Image backups:     $IMAGE_BACKUPS"
echo "Total backup size: $TOTAL_SIZE"
echo "Backup location:   $BACKUP_PATH"
echo ""
echo "✅ Docker backup completed at $(date)"
echo ""
echo "To restore an image from backup:"
echo "   docker load -i $BACKUP_PATH/images/<image_name>.tar"
```

### Expected Output

```
=== Docker Backup Script ===
Backup location: /backup/docker/2025-03-03_09-15
Started at: Mon Mar 3 09:15:00 UTC 2025

─── Backing Up Running Containers ───────────
Backing up container: web-app (a1b2c3d4e5f6)
   ✅ Saved: web-app.tar (245M)
Backing up container: mysql-db (b2c3d4e5f6a1)
   ✅ Saved: mysql-db.tar (412M)

─── Saving All Docker Images ─────────────────
Saving image: nginx_latest (sha256:abc123)
   ✅ Saved: nginx_latest.tar (187M)
Saving image: mysql_8.0 (sha256:def456)
   ✅ Saved: mysql_8.0.tar (389M)

─── Backup Summary ───────────────────────────
Container backups: 2
Image backups:     2
Total backup size: 1.2G
Backup location:   /backup/docker/2025-03-03_09-15

✅ Docker backup completed at Mon Mar 3 09:15:45 UTC 2025

To restore an image from backup:
   docker load -i /backup/docker/2025-03-03_09-15/images/<image_name>.tar
```

---

## ✅ Script 25: SSL Certificate Expiry Checker (Bonus)

### Problem Statement
SSL certificates expire. An expired certificate causes browsers to show security warnings, effectively **taking your website offline**. You need to **automatically check certificate expiry dates** and alert before they expire.

```bash
#!/bin/bash
# Script: ssl_checker.sh
# Purpose: Check SSL certificate expiry for a list of domains
# Usage: sh ssl_checker.sh
# Production Use: Daily automated SSL monitoring, pre-expiry alerts

# ─── CONFIGURATION ────────────────────────────────────────────────────────────
WARNING_DAYS=30      # Alert if certificate expires within 30 days
CRITICAL_DAYS=7      # Critical alert if expiring within 7 days
ALERT_EMAIL="devops@company.com"

# List of domains to check (add your domains here)
DOMAINS=(
    "google.com"
    "github.com"
    "your-company.com"
    "api.your-company.com"
)

echo "=== SSL Certificate Expiry Checker ==="
echo "Checked at: $(date)"
echo "Warning threshold:  $WARNING_DAYS days"
echo "Critical threshold: $CRITICAL_DAYS days"
echo ""

# Check if openssl is available
if ! command -v openssl &>/dev/null; then
    echo "❌ openssl is not installed!"
    exit 1
fi

# ─── FUNCTION: Check SSL for one domain ───────────────────────────────────────
check_ssl() {
    local domain=$1     # Domain to check

    # openssl s_client         → SSL/TLS client tool
    # -connect domain:443      → connect to domain on HTTPS port 443
    # -servername $domain      → SNI (Server Name Indication) for virtual hosts
    # 2>/dev/null              → suppress connection info output
    # openssl x509             → process certificate data
    # -noout                   → don't output the certificate itself
    # -dates                   → show validity start and end dates
    CERT_DATES=$(echo | openssl s_client \
        -connect "${domain}:443" \
        -servername "$domain" \
        2>/dev/null | \
        openssl x509 -noout -dates 2>/dev/null)

    # Check if we got certificate data (domain might be unreachable)
    if [ -z "$CERT_DATES" ]; then
        echo "❌ UNREACHABLE: $domain (Cannot connect or no SSL)"
        return
    fi

    # Extract the expiry date from the certificate
    # notAfter=Mar 15 12:00:00 2025 GMT
    EXPIRY_DATE=$(echo "$CERT_DATES" | grep "notAfter" | cut -d'=' -f2)

    # Convert expiry date to Unix timestamp for math comparison
    # date -d → parse a date string
    # +%s     → output as Unix timestamp (seconds since epoch)
    EXPIRY_TIMESTAMP=$(date -d "$EXPIRY_DATE" +%s 2>/dev/null)
    CURRENT_TIMESTAMP=$(date +%s)    # Current time as Unix timestamp

    # Calculate days remaining until expiry
    # (expiry - now) / 86400 → convert seconds to days
    DAYS_LEFT=$(( (EXPIRY_TIMESTAMP - CURRENT_TIMESTAMP) / 86400 ))

    # Determine status based on days remaining
    if [ "$DAYS_LEFT" -le 0 ]; then
        # Certificate has already expired!
        echo "💀 EXPIRED:   $domain | Expired on: $EXPIRY_DATE"

    elif [ "$DAYS_LEFT" -le "$CRITICAL_DAYS" ]; then
        # Expiring very soon — critical alert
        echo "🚨 CRITICAL:  $domain | Expires in $DAYS_LEFT days | Date: $EXPIRY_DATE"

    elif [ "$DAYS_LEFT" -le "$WARNING_DAYS" ]; then
        # Expiring within warning period
        echo "⚠️  WARNING:   $domain | Expires in $DAYS_LEFT days | Date: $EXPIRY_DATE"

    else
        # Certificate is valid with plenty of time
        echo "✅ OK:         $domain | Expires in $DAYS_LEFT days | Date: $EXPIRY_DATE"
    fi
}

# ─── CHECK ALL DOMAINS ────────────────────────────────────────────────────────
echo "─── Certificate Status ───────────────────────"

# Loop through the DOMAINS array and check each one
for domain in "${DOMAINS[@]}"; do
    check_ssl "$domain"    # Call the function for each domain
done

echo ""
echo "─── Check Complete ───────────────────────────"
echo "Total domains checked: ${#DOMAINS[@]}"
echo ""
echo "=== SSL Check Complete at $(date) ==="
```

### Expected Output

```
=== SSL Certificate Expiry Checker ===
Checked at: Mon Mar 3 09:15:00 UTC 2025
Warning threshold:  30 days
Critical threshold: 7 days

─── Certificate Status ──────────────���────────
✅ OK:         google.com | Expires in 287 days | Date: Dec 15 12:00:00 2025 GMT
✅ OK:         github.com | Expires in 312 days | Date: Jan 9 12:00:00 2026 GMT
⚠️  WARNING:   your-company.com | Expires in 18 days | Date: Mar 21 12:00:00 2025 GMT
🚨 CRITICAL:  api.your-company.com | Expires in 4 days | Date: Mar 7 12:00:00 2025 GMT

─── Check Complete ───────────────────────────
Total domains checked: 4

=== SSL Check Complete at Mon Mar 3 09:15:05 UTC 2025 ===
```

### Cron Schedule (Daily at 8AM)

```bash
0 8 * * * /home/ec2-user/ssl_checker.sh >> /var/log/ssl_check.log 2>&1
```

---

<a name="debugging-and-troubleshooting"></a>

# 🐛 Debugging & Troubleshooting Shell Scripts

---

## Why Scripts Fail in Production

| Cause | Example | Fix |
|---|---|---|
| Wrong permissions | Script not executable | `chmod +x script.sh` |
| Wrong path | File not found | Use absolute paths |
| Missing commands | `jq: command not found` | Install required tools |
| Cron environment | Works manually, fails in cron | Set full paths in cron |
| Undeclared variables | Variable is empty | Check with `set -u` |
| Silent failures | Command fails but script continues | Use `set -e` |
| Race conditions | Two scripts modify same file | Use file locking |

---

## 🔧 Debug Mode — `set -x`

`set -x` enables **trace mode** — it prints every command before executing it. This is the most useful debugging tool.

```bash
#!/bin/bash
set -x    # Enable debug mode — prints every command with a + prefix

name="Castro"
echo "Hello $name"
ls /nonexistent_path

set +x    # Disable debug mode (optional — re-enable after debugging a section)
echo "Debug mode is now off"
```

**Output:**
```
+ name=Castro
+ echo 'Hello Castro'
Hello Castro
+ ls /nonexistent_path
ls: cannot access '/nonexistent_path': No such file or directory
+ set +x
Debug mode is now off
```

> 💡 The `+` prefix shows commands as they execute. Extremely useful to trace exactly where a script is failing.

**Run script in debug mode without editing it:**
```bash
bash -x script.sh
# OR
sh -x script.sh
```

---

## 🛑 Strict Mode — `set -e`, `set -u`, `set -o pipefail`

### `set -e` — Exit on Any Error

```bash
#!/bin/bash
set -e    # Script STOPS immediately if any command fails (non-zero exit code)

echo "Step 1: Starting..."
cp /nonexistent/file /tmp/    # This FAILS
echo "Step 2: This will NOT run because step above failed"
# Without set -e: Script would continue even after failure!
```

### `set -u` — Treat Unset Variables as Errors

```bash
#!/bin/bash
set -u    # Script STOPS if you try to use a variable that was never set

echo $UNDEFINED_VARIABLE    # Without set -u: prints empty string silently
                             # With set -u: error! Unbound variable
```

### `set -o pipefail` — Catch Pipe Failures

```bash
#!/bin/bash
set -o pipefail    # If any command in a pipeline fails, the whole pipeline fails

# Without pipefail:
cat /nonexistent_file | grep "something"   # cat fails, but grep "succeeds" (exit 0)
echo $?   # Shows 0 (success!) — MISLEADING!

# With pipefail:
# The above command would correctly return non-zero exit code
```

### Best Practice: Use All Three Together

```bash
#!/bin/bash
# Professional production script header
set -euo pipefail
# -e → exit on error
# -u → exit on unset variable
# -o pipefail → exit on pipe failure
# Combined: script fails fast and visibly on any problem
```

---

## 🔍 Checking Exit Codes — `$?`

Every command in Linux returns an **exit code**:
- `0` = Success
- Non-zero (1, 2, 127, etc.) = Failure

```bash
#!/bin/bash
# Check exit code of commands

ls /home
echo "Exit code: $?"    # 0 = success (directory exists)

ls /nonexistent
echo "Exit code: $?"    # 2 = failure (no such file)

ping -c 1 google.com &>/dev/null
if [ $? -eq 0 ]; then
    echo "✅ Internet is working"
else
    echo "❌ No internet connection"
fi
```

### Common Exit Codes

| Code | Meaning |
|---|---|
| `0` | Success |
| `1` | General error |
| `2` | Misuse of shell builtin |
| `126` | Command found but not executable |
| `127` | Command not found |
| `128+n` | Fatal error signal n (e.g., 130 = Ctrl+C) |

---

## 🪤 Using `trap` — Handle Errors & Cleanup

`trap` lets you define what to do when the script exits, fails, or is interrupted.

```bash
#!/bin/bash
# Script: trap_example.sh
# Purpose: Demonstrate trap for cleanup on exit

# Create a temporary file at the start
TEMP_FILE=$(mktemp)     # mktemp → creates a unique temporary file

# FUNCTION: Cleanup — runs automatically when script exits
cleanup() {
    echo ""
    echo "Cleaning up temporary files..."
    rm -f "$TEMP_FILE"    # Always delete temp file, even if script crashes
    echo "Cleanup complete."
}

# trap → set up a handler
# cleanup    → function to call
# EXIT       → trigger: when script exits (for any reason)
# INT        → trigger: when user presses Ctrl+C (interrupt signal)
# ERR        → trigger: when any command fails
trap cleanup EXIT INT ERR

echo "Working with temp file: $TEMP_FILE"
echo "some data" > "$TEMP_FILE"
echo "Processing..."

# Simulate an error
# false      → command that always fails (exit code 1)
# false

echo "Script completed successfully!"
# cleanup() will run automatically here because of trap EXIT
```

---

## 🔬 `set -x` Targeted Debugging (Debug Specific Sections)

```bash
#!/bin/bash
# Only debug a specific section of a large script

echo "Normal section — no debug output"
cp file1.txt /tmp/

echo "─── Entering debug section ───"
set -x    # Turn ON debug mode

# Only these commands show debug output
backup_dir="/backup"
mkdir -p $backup_dir
ls -l $backup_dir

set +x    # Turn OFF debug mode
echo "─── Debug section complete ───"

echo "Back to normal output"
```

---

## 🐛 Debugging Cron Jobs

Cron jobs fail silently. Here's how to debug them:

```bash
# Problem: Script works manually but NOT in cron

# 1. Always use FULL paths in cron scripts
# WRONG:
cp config.txt /backup/    # cron doesn't know current directory

# CORRECT:
cp /home/ec2-user/config.txt /backup/

# 2. Capture ALL output (stdout + stderr) to a log file
*/5 * * * * /home/ec2-user/script.sh >> /var/log/script.log 2>&1
#                                     ↑ append stdout
#                                                             ↑ redirect stderr to stdout

# 3. Add PATH to cron environment (cron has minimal PATH)
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
*/5 * * * * /home/ec2-user/script.sh >> /var/log/script.log 2>&1

# 4. Test your script as if you were cron (minimal environment)
env -i HOME=/home/ec2-user /bin/bash /home/ec2-user/script.sh

# 5. Check the cron system log for errors
sudo tail -f /var/log/cron            # Amazon Linux / CentOS
sudo tail -f /var/log/syslog          # Ubuntu
sudo journalctl -u crond -f           # Systems using systemd
```

---

## 📋 Common Mistakes & Fixes

### Mistake 1: Missing Spaces in `[ ]` Conditions

```bash
# WRONG ❌ — no spaces around brackets
if [$name == "Castro"]; then

# CORRECT ✅ — spaces are REQUIRED inside [ ]
if [ $name == "Castro" ]; then
```

### Mistake 2: Forgetting Quotes Around Variables with Spaces

```bash
file_name="my report.pdf"

# WRONG ❌ — splits on space, becomes two arguments to ls
ls $file_name        # ls my report.pdf → error: no file called "my"

# CORRECT ✅ — quotes preserve spaces
ls "$file_name"      # ls "my report.pdf" → correct
```

### Mistake 3: Using `=` Instead of `-eq` for Numbers

```bash
# WRONG ❌ — string comparison, not numeric
if [ $count = 10 ]; then

# CORRECT ✅ — numeric comparison
if [ $count -eq 10 ]; then
```

### Mistake 4: Forgetting `fi` to Close if Blocks

```bash
# WRONG ❌ — no fi at end
if [ $age -gt 18 ]; then
    echo "Adult"

# CORRECT ✅
if [ $age -gt 18 ]; then
    echo "Adult"
fi    # Always close with fi
```

### Mistake 5: Integer Division (Decimal Results)

```bash
# WRONG assumption: expecting decimal output
echo $(( 10 / 3 ))    # Outputs: 3 (not 3.333!)

# CORRECT for decimals: use bc (basic calculator)
echo "scale=2; 10/3" | bc    # Outputs: 3.33
```

### Mistake 6: Script Has No Execute Permission

```bash
# ERROR: Permission denied
./script.sh

# FIX:
chmod +x script.sh
./script.sh
```

---

<a name="best-practices"></a>

# 🏆 Shell Scripting Best Practices

---

## 1. Always Start with a Proper Header

```bash
#!/bin/bash
# ============================================================
# Script Name:    backup.sh
# Description:    Automated daily backup of application files
# Author:         Castro (DevOps Team)
# Created Date:   2025-03-01
# Last Modified:  2025-03-03
# Usage:          sh backup.sh [source_dir] [dest_dir]
# Dependencies:   tar, aws-cli
# ============================================================
```

## 2. Use Strict Mode in Production

```bash
#!/bin/bash
set -euo pipefail
# Fail fast, fail visibly
```

## 3. Always Validate Input

```bash
# Always check that required variables/arguments are present
if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "ERROR: Directory does not exist: $SOURCE_DIR"
    exit 1
fi
```

## 4. Use Meaningful Variable Names

```bash
# BAD ❌
x="/home/ec2-user/backup"
y=30
z="nginx"

# GOOD ✅
backup_directory="/home/ec2-user/backup"
retention_days=30
service_name="nginx"
```

## 5. Use Functions for Repeated Logic

```bash
# Define log function once
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Use everywhere
log "Starting backup..."
log "Backup completed successfully"
log "ERROR: Backup failed!"
```

## 6. Always Log Script Activity

```bash
LOG_FILE="/var/log/myapp/script.log"
mkdir -p "$(dirname $LOG_FILE)"    # Create log directory if needed

# Redirect all output to log and screen simultaneously
exec > >(tee -a "$LOG_FILE") 2>&1
# All echo statements now go to BOTH screen AND log file
```

## 7. Use Absolute Paths

```bash
# BAD ❌ — depends on current working directory
cp config.txt /backup/

# GOOD ✅ — always works regardless of where script is run from
cp /home/ec2-user/app/config.txt /backup/
```

## 8. Add Exit Code Checks After Critical Commands

```bash
tar -czf backup.tar.gz /important/data
if [ $? -ne 0 ]; then
    echo "ERROR: Backup failed!"
    # Send alert, log error, etc.
    exit 1
fi
echo "Backup successful"
```

## 9. Make Scripts Idempotent

```bash
# GOOD: Checking before creating prevents errors on re-run
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# GOOD: -p flag in mkdir makes it idempotent (no error if already exists)
mkdir -p "$BACKUP_DIR"
```

## 10. Comment Generously

```bash
# Explain WHY, not just WHAT
# BAD comment:
cp file.txt /backup/    # Copy file

# GOOD comment:
cp file.txt /backup/    # Backup config before deployment — needed for rollback
```

---

<a name="interview-questions"></a>

# 🎤 Interview Questions & Answers

---

## 🔵 Level 1 — Basic (L1)

**Q1: What is a shell script?**
> A shell script is a text file containing a series of Linux commands and shell syntax that can be executed to automate tasks. It uses `.sh` extension and starts with `#!/bin/bash` (shebang line).

**Q2: What is the shebang line and why is it important?**
> The shebang (`#!/bin/bash`) is the first line of a shell script. It tells the operating system which interpreter to use to execute the script. Without it, the OS uses the default shell which may differ across systems.

**Q3: What is the difference between `sh script.sh`, `bash script.sh`, and `./script.sh`?**
> - `sh script.sh` — runs with sh interpreter, no execute permission needed
> - `bash script.sh` — runs explicitly with bash, no permission needed
> - `./script.sh` — runs with interpreter specified in shebang, requires execute permission (`chmod +x`)

**Q4: How do you declare and access a variable in bash?**
> Declare: `name="Castro"` (no spaces around `=`)  
> Access: `echo $name` or `echo ${name}`  
> Variables don't need data type declarations in bash.

**Q5: What is the difference between single quotes and double quotes?**
> ```bash
> name="Castro"
> echo '$name'   # Literal: $name (no variable expansion)
> echo "$name"   # Expanded: Castro (variable is substituted)
> ```

**Q6: How do you read user input in a shell script?**
> ```bash
> echo "Enter your name:"
> read user_name
> echo "Hello $user_name"
> ```

**Q7: What does `chmod +x script.sh` do?**
> Adds execute permission to `script.sh`. Without this, you get "Permission denied" when trying to run `./script.sh`. The `+x` adds the executable bit for all users.

---

## 🟡 Level 2 — Intermediate (L2)

**Q8: What is the difference between `$@` and `$*`?**
> Both represent all command line arguments, but:  
> - `"$@"` preserves argument boundaries — `"arg with spaces"` stays as ONE argument  
> - `"$*"` merges all args into ONE string — loses distinction between arguments  
> In practice, always prefer `"$@"` when iterating over arguments.

**Q9: Explain the difference between a for loop and while loop in bash.**
> - `for` loop is range-based — use when you KNOW how many iterations (e.g., loop 1 to 15)  
> - `while` loop is condition-based — use when you know the stopping CONDITION but not the count (e.g., keep asking for password until correct one is entered)

**Q10: What does `set -euo pipefail` do?**
> - `set -e` — exit script immediately if any command fails
> - `set -u` — exit if any unset variable is used  
> - `set -o pipefail` — exit if any command in a pipe fails  
> Combined, they create a "fail fast" script that doesn't silently continue after errors.

**Q11: How do you make a variable permanent across terminal sessions?**
> Add `export VARIABLE="value"` to `~/.bashrc`, then run `source ~/.bashrc`.  
> Variables set only with `export` in a terminal are temporary — lost when terminal closes.

**Q12: How do you check if a file exists in a shell script?**
> ```bash
> if [ -e "$file" ]; then echo "exists"; fi      # File or directory
> if [ -f "$file" ]; then echo "is a file"; fi   # Regular file only
> if [ -d "$dir" ]; then echo "is directory"; fi # Directory only
> ```

**Q13: What is the purpose of `$?` in shell scripting?**
> `$?` holds the exit code of the most recently executed command. `0` = success, non-zero = failure. Used to check if a command succeeded before proceeding.

**Q14: How do you schedule a script to run every day at 2AM?**
> ```bash
> crontab -e
> # Add:
> 0 2 * * * /path/to/script.sh >> /var/log/script.log 2>&1
> ```
> Format: `minute hour day month weekday command`

**Q15: What is the difference between temporary and permanent cron jobs?**
> All cron jobs configured via `crontab -e` are permanent — they persist across reboots and reconnections. The `at` command creates one-time jobs that execute once and are then gone.

---

## 🔴 Level 3 — Advanced (L3)

**Q16: How do you handle errors and ensure cleanup in a production shell script?**
> Use `trap` to register cleanup functions:
> ```bash
> TEMP_FILE=$(mktemp)
> cleanup() { rm -f "$TEMP_FILE"; }
> trap cleanup EXIT INT ERR
> ```
> Combined with `set -euo pipefail` for comprehensive error handling.

**Q17: How would you write an idempotent shell script?**
> An idempotent script can be run multiple times with the same result:
> ```bash
> # Check before creating
> [ -d "$DIR" ] || mkdir -p "$DIR"    # Only create if doesn't exist
> id "$USER" &>/dev/null || useradd "$USER"  # Only create user if not exists
> grep -q "entry" file || echo "entry" >> file  # Only add if not present
> ```

**Q18: How do you debug a cron job that works manually but fails in cron?**
> 1. **Capture output:** Add `>> /var/log/script.log 2>&1` to cron entry  
> 2. **Set PATH:** Cron has minimal PATH — add full paths or export PATH at top of script  
> 3. **Test in cron environment:** `env -i HOME=/home/user /bin/bash /path/to/script.sh`  
> 4. **Check cron logs:** `sudo tail -f /var/log/cron` (RHEL) or `journalctl -u crond -f`

**Q19: What is the difference between `>` and `>>` in shell scripting?**
> - `>` — redirect and **overwrite** (destroys previous content)
> - `>>` — redirect and **append** (adds to end of file)
> ```bash
> echo "line1" > file.txt    # Creates/overwrites file with "line1"
> echo "line2" >> file.txt   # Appends "line2" to file
> ```
> In production log files, ALWAYS use `>>` to preserve history.

**Q20: Explain `2>&1` and `> /dev/null`.**
> - `2>&1` — redirects file descriptor 2 (stderr) to file descriptor 1 (stdout)  
> - `> /dev/null` — discards stdout (sends to the null device, a virtual black hole)  
> - Combined `> /dev/null 2>&1` — silences ALL output (both stdout and stderr)  
> Used in cron jobs to suppress output when you're logging to a file instead.

**Q21: How do you pass and use arguments within a function in bash?**
> Functions have their own `$1`, `$2` etc. independent of the script's:
> ```bash
> greet() {
>     local name=$1    # $1 here = first arg passed TO THIS FUNCTION
>     echo "Hello $name"
> }
> greet "Castro"    # Passes "Castro" as $1 to the function
> ```
> `local` ensures the variable doesn't leak outside the function.

**Q22: What strategies do you use to make shell scripts production-ready?**
> 1. `set -euo pipefail` for strict error handling  
> 2. Logging with timestamps to files  
> 3. `trap` for cleanup on exit/error  
> 4. Input validation at the start  
> 5. Absolute paths everywhere  
> 6. Exit codes — return meaningful codes (`exit 0` success, `exit 1` error)  
> 7. Idempotent operations (safe to re-run)  
> 8. Header comments with description, usage, author  

---

<a name="master-summary"></a>

# 📚 Master Summary — Complete Handbook Recap

---

## Topic-by-Topic Quick Reference

| Day | Topic | Core Concept | Key Commands |
|---|---|---|---|
| Day 1 | Linux Architecture | User→Shell→Kernel→Hardware | `#!/bin/bash`, `chmod +x`, `sh`, `bash` |
| Day 1 | Shell Scripting | Automate with `.sh` files | `echo`, `read`, `cat`, `vi` |
| Day 2 | Variables | Key-value data storage | `$var`, `export`, `unset`, `source ~/.bashrc` |
| Day 2 | Operators | Arithmetic & comparison | `$(( ))`, `-eq`, `-gt`, `-lt` |
| Day 2 | Conditionals | Decision making | `if/elif/else/fi` |
| Day 3 | For Loop | Range-based iteration | `for (( i=1; i<=N; i++ )) do...done` |
| Day 3 | While Loop | Condition-based iteration | `while [ condition ] do...done` |
| Day 4 | CLA | Dynamic script inputs | `$0`, `$1-$9`, `$#`, `$@`, `$*` |
| Day 4 | Functions | Reusable code blocks | `name() { }`, call with `name arg` |
| Day 5 | Cron Jobs | Scheduled automation | `crontab -e`, `*/5 * * * *` |
| Day 6 | Real Scripts | Production DevOps patterns | 25 scripts covering all DevOps tools |

---

## The 5 Golden Rules of Shell Scripting

```
1. ALWAYS use #!/bin/bash as the first line
2. ALWAYS use set -euo pipefail in production scripts
3. ALWAYS use full/absolute paths (never relative in cron)
4. ALWAYS redirect cron output: >> /var/log/script.log 2>&1
5. ALWAYS test with bash -x script.sh before deploying
```

---

## Production-Ready Script Template

```bash
#!/bin/bash
# ============================================================
# Script:      template.sh
# Description: What this script does
# Author:      Your Name
# Usage:       sh template.sh [arg1] [arg2]
# ============================================================

set -euo pipefail    # Fail fast, fail visibly

# ─── CONFIGURATION ────────────────────────────────────────
LOG_FILE="/var/log/myscript.log"
SCRIPT_NAME=$(basename "$0")

# ─── LOGGING FUNCTION ─────────────────────────────────────
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$SCRIPT_NAME] $1" | tee -a "$LOG_FILE"
}

# ─── CLEANUP FUNCTION ─────────────────────────────────────
cleanup() {
    log "Script exiting — running cleanup..."
    # Add cleanup tasks here
}
trap cleanup EXIT INT ERR

# ─── INPUT VALIDATION ─────────────────────────────────────
if [ $# -lt 1 ]; then
    echo "Usage: $0 <required_argument>"
    exit 1
fi

# ─── MAIN LOGIC ───────────────────────────────────────────
log "Script started"
log "Arguments received: $*"

# Your script logic here

log "Script completed successfully"
exit 0
```

---

## Interview Quick-Fire Answers

| Question | 1-Line Answer |
|---|---|
| What is a shell? | Interface between user and kernel; translates commands |
| What is shebang? | `#!/bin/bash` — tells OS which interpreter to use |
| Temporary vs permanent var? | `export` = temporary; add to `.bashrc` = permanent |
| `$?` meaning? | Exit code of last command; 0=success, non-zero=failure |
| `$@` vs `$*`? | `$@` = each arg separate; `$*` = all args as one string |
| for vs while loop? | for = known count; while = unknown count with condition |
| How to debug a script? | `bash -x script.sh` or add `set -x` inside script |
| `set -e` does what? | Exits script immediately when any command fails |
| `2>&1` means what? | Redirects stderr (2) to stdout (1) — captures all output |
| `>> /dev/null` means? | Discards all output silently |
| Cron format? | `minute hour day month weekday command` |
| Make script executable? | `chmod +x script.sh` |
| `trap` purpose? | Execute cleanup code when script exits or errors |

---

> 🎯 **Final Note:** Shell scripting is a **practical skill** — reading is not enough. Execute every script in this guide on a real Linux instance (EC2, VM, or local). Modify them, break them, fix them. The engineers who master shell scripting are the ones who practice daily.
