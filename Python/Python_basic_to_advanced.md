# 🐍 Python for DevOps — Complete Notes (Beginner to Advanced)

---

## 📌 Table of Contents
1. [What is Python & Why DevOps Engineers Use It](#1-what-is-python--why-devops-engineers-use-it)
2. [Python Setup & Installation](#2-python-setup--installation)
3. [Python Basics](#3-python-basics)
4. [Control Flow](#4-control-flow)
5. [Data Structures](#5-data-structures)
6. [Functions](#6-functions)
7. [Modules & Packages](#7-modules--packages)
8. [File Handling](#8-file-handling)
9. [Exception Handling](#9-exception-handling)
10. [Object-Oriented Programming (OOP)](#10-object-oriented-programming-oop)
11. [Advanced Topics](#11-advanced-topics)

---

## 1. What is Python & Why DevOps Engineers Use It

### 📖 What is Python?
Python is a **high-level, interpreted, object-oriented programming language** with a very clean, English-like syntax. It is one of the most popular programming languages in the world today.

### ✅ Why Python in DevOps?
| Use Case | Example |
|---|---|
| Automation | Auto-restart crashed services, auto-cleanup logs |
| Infrastructure Management | Automate EC2 start/stop via Boto3 |
| CI/CD Pipelines | Trigger builds, check status via API |
| Cloud Operations | S3 uploads, Lambda invocations |
| Monitoring & Alerting | Check CPU/memory and send alerts |
| Log Analysis | Parse logs, count errors, rotate files |
| API Integration | Call GitHub API, Jenkins API |
| Configuration Management | Read/write YAML, JSON config files |

### 💡 Why Python is Popular in DevOps
- **Rich library ecosystem** — Boto3 (AWS), Paramiko (SSH), Requests (HTTP)
- **Easy syntax** — Code reads almost like English
- **Cross-platform** — Works on Linux, Windows, macOS
- **Huge community** — Solutions available for almost every problem
- **AI/ML Integration** — Used heavily in modern cloud-native tooling

---

## 2. Python Setup & Installation

### 🖥️ On Linux (Ubuntu/Debian)
```bash
# Install Python 3
sudo apt install python3

# Verify installation
python3 --version

# Output example:
# Python 3.12.3
```

### 🖥️ On Windows
- Download from: [https://www.python.org/downloads/](https://www.python.org/downloads/)
- During install, check **"Add Python to PATH"**
- Verify: open Command Prompt → `python --version`

### ▶️ Running a Python Script
```bash
# Method 1: Using Python interpreter
python3 script.py

# Method 2: Using shebang line (Linux only)
#!/usr/bin/env python3
# Make executable:
chmod +x script.py
./script.py
```

### 💡 Production Best Practice
> Always use **Python 3** — Python 2 is end-of-life. In production, use **virtual environments** (`venv`) to isolate dependencies per project.

---

## 3. Python Basics

### 3.1 Indentation
Python uses **indentation (spaces/tabs)** to define code blocks — NOT curly braces like Java or C.

```python
# ✅ Correct indentation
if True:
    print("Hello Python")

# ❌ Wrong — will throw IndentationError
if True:
print("Hello Python")
```

> **🎯 Interview Tip:** Python uses indentation to define scope. 4 spaces is the standard (PEP 8). Never mix tabs and spaces.

> **⚠️ Common Mistake:** Mixing tabs and spaces causes `TabError`. Always use spaces.

---

### 3.2 Variables & Data Types

**Variables** are containers (memory locations) for storing data values.

```python
# Variables — no need to declare type explicitly
name    = "Dh"          # str  — text/string
age     = 25            # int  — whole number
salary  = 80000.50      # float — decimal number
is_devops = True        # bool — True/False
```

#### Python Data Types Summary
| Type | Example | Notes |
|---|---|---|
| `int` | `10` | Whole numbers |
| `float` | `3.14` | Decimal numbers |
| `str` | `"hello"` | Text — in quotes |
| `bool` | `True / False` | Must be capitalized |
| `list` | `[1, 2, 3]` | Ordered, mutable — square brackets |
| `tuple` | `(1, 2, 3)` | Ordered, **immutable** — round brackets |
| `set` | `{1, 2, 3}` | Unordered, **unique** — curly braces |
| `dict` | `{"key": "value"}` | Key-value pairs — curly braces |

#### 🔑 Key Differences to Remember (Very Common Interview Question)
| Property | List | Tuple | Set |
|---|---|---|---|
| Bracket | `[ ]` | `( )` | `{ }` |
| Ordered | ✅ Yes | ✅ Yes | ❌ No |
| Mutable | ✅ Yes | ❌ No | ✅ Yes |
| Duplicates Allowed | ✅ Yes | ✅ Yes | ❌ No |

> **🎯 Interview Tip:** "Use a tuple when data should NOT change — like server credentials or config constants."

---

### 3.3 Input & Output

```python
# Taking input from user
name = input("Enter your name: ")

# Printing output — f-string formatting (recommended)
print(f"Hello {name}, welcome to DevOps!")
```

#### DevOps Example — Server Connection Script
```python
server = input("Enter server name: ")
print(f"Connecting to {server}... please wait.")
```

```bash
# Run it
python3 server_info.py
# Enter server name: prod-server-01
# Output: Connecting to prod-server-01... please wait.
```

> **⚠️ Common Mistake:** Forgetting the `f` prefix in f-strings. `print("Hello {name}")` will literally print `{name}` — not the variable value.

---

### 3.4 Type Conversion (Type Casting)

Two types:

#### Implicit Type Conversion (Automatic)
Python automatically converts types to avoid data loss.

```python
a = 10      # int
b = 5.5     # float

c = a + b
print(c)       # 15.5  (float)
print(type(c)) # <class 'float'>
# Python automatically promoted int to float
```

#### Explicit Type Conversion (Manual)
You manually convert using built-in functions.

```python
# String to Integer
port_str = "8080"
port_int = int(port_str)
print(type(port_int))  # <class 'int'>

# Integer to String
exit_code = 0
exit_str = str(exit_code)
print("Exit code: " + exit_str)  # Works now (can't concat int + str directly)

# String to Float
cpu_usage = float("87.5")
print(cpu_usage)  # 87.5

# List to Tuple (immutable snapshot of data)
servers = ["web01", "db01", "cache01"]
server_tuple = tuple(servers)
print(server_tuple)  # ('web01', 'db01', 'cache01')
```

> **💼 DevOps Use Case:** API responses often return numbers as strings. You must cast them to `int` or `float` before doing math (e.g., calculating CPU %).

---

### 3.5 Comments

```python
# This is a single-line comment — use # symbol

"""
This is a
multi-line comment
using triple double-quotes
"""

'''
This also works
as a multi-line comment
'''
```

---

### 3.6 Operators

#### Arithmetic Operators
```python
a, b = 10, 3

print(a + b)   # 13 — Addition
print(a - b)   # 7  — Subtraction
print(a * b)   # 30 — Multiplication
print(a / b)   # 3.333... — Division (always float)
print(a // b)  # 3  — Floor Division (integer result)
print(a % b)   # 1  — Modulus (remainder)
print(a ** b)  # 1000 — Exponent (10^3)
```

#### Comparison Operators
```python
print(10 == 10)  # True
print(10 != 5)   # True
print(10 > 5)    # True
print(10 < 5)    # False
print(10 >= 10)  # True
print(10 <= 9)   # False
```

#### Logical Operators
```python
x = True
y = False

print(x and y)  # False — both must be True
print(x or y)   # True  — at least one must be True
print(not x)    # False — negates the value
```

---

### 3.7 String Operations

```python
message = "Python for DevOps"

# String methods
print(message.upper())           # PYTHON FOR DEVOPS
print(message.lower())           # python for devops
print(message.replace("DevOps", "AWS"))  # Python for AWS
print(message.split(" "))        # ['Python', 'for', 'DevOps']
print(message.strip())           # removes leading/trailing spaces
print(len(message))              # 17 — length

# String formatting
tool = "Ansible"
print(f"{tool} is a configuration management tool.")
```

> **💼 DevOps Use Case:** Parsing log lines — split by space or colon to extract timestamps, error codes, IP addresses.

---

## 4. Control Flow

### 4.1 Conditional Statements (if / elif / else)

```python
# Basic if-else
server_status = "running"

if server_status == "running":
    print("Server is healthy ✅")
elif server_status == "stopped":
    print("Server is down ⚠️")
else:
    print("Unknown status ❓")
```

#### DevOps Example — Nested Condition for CPU + Memory Alert
```python
cpu_usage    = 80
memory_usage = 90

if cpu_usage > 75:
    if memory_usage > 80:
        print("🚨 HIGH CPU + MEMORY — Scale up immediately!")
    else:
        print("⚠️ CPU is high — Monitor closely.")
else:
    print("✅ System resources are normal.")
```

#### Shorthand If (Inline / Ternary)
```python
status = "up"
result = "Server is UP ✅" if status == "up" else "Server is DOWN ❌"
print(result)
```

---

### 4.2 Loops

#### For Loop
```python
# Iterating over a list
tools = ["Docker", "Jenkins", "Ansible"]

for tool in tools:
    print(f"Installing {tool}...")

# Using range()
for i in range(1, 4):   # 1, 2, 3 (4 is excluded)
    print(f"Deploying service batch {i}")
```

#### While Loop
```python
count = 0

while count < 3:
    print(f"Running pipeline — attempt {count + 1}")
    count += 1  # Important: increment to avoid infinite loop
```

> **⚠️ Common Mistake:** Forgetting to increment the counter in a `while` loop causes an **infinite loop**. Always make sure the condition will eventually become `False`.

---

### 4.3 Loop Control Statements

```python
# break — exit the loop early
for i in range(1, 6):
    if i == 3:
        print("Stopping at 3!")
        break
    print(i)
# Output: 1, 2, Stopping at 3!

# continue — skip current iteration
for i in range(1, 6):
    if i == 3:
        continue   # skip 3
    print(i)
# Output: 1, 2, 4, 5

# pass — do nothing (placeholder)
for i in range(3):
    pass   # code here later
```

#### else with Loop
```python
# else block runs when loop completes without break
for i in range(3):
    print(f"Checking node {i}")
else:
    print("✅ All nodes checked successfully!")
```

---

#### 🔥 DevOps Example — Server Status Checker
```python
servers = {
    "web01":   "running",
    "db01":    "stopped",
    "cache01": "running"
}

for name, status in servers.items():
    if status == "running":
        print(f"✅ {name} is healthy")
    else:
        print(f"❌ {name} is DOWN — Restarting service...")
```

---

## 5. Data Structures

### 5.1 Lists — Ordered & Mutable

```python
tools = ["Docker", "Jenkins", "Ansible", "Kubernetes"]

# Access by index (starts at 0)
print(tools[0])   # Docker
print(tools[-1])  # Kubernetes (last element)

# Add
tools.append("Terraform")       # Add at end
tools.insert(1, "GitLab")       # Add at index 1

# Modify
tools[1] = "GitHub Actions"     # Update element

# Remove
tools.remove("Jenkins")         # Remove by value
tools.pop(0)                    # Remove by index
del tools[0]                    # Also removes by index

# Iterate
for tool in tools:
    print(f"Tool: {tool}")

print(len(tools))               # Length of list
```

---

### 5.2 Tuples — Ordered & Immutable

```python
# Use tuples for data that should NEVER change
credentials = ("admin", "securePass123")

print(credentials[0])   # admin
print(credentials[1])   # securePass123

# Attempting to modify throws TypeError
# credentials[0] = "root"   # ❌ TypeError!
```

> **💼 DevOps Use Case:** Store DB credentials, AWS region names, port numbers — data that must not change accidentally.

---

### 5.3 Sets — Unordered & Unique

```python
# Sets automatically remove duplicates
active_servers = {"web01", "db01", "web01", "cache01"}
print(active_servers)  # {'web01', 'db01', 'cache01'} — duplicate removed

# Set operations
set1 = {"Docker", "Ansible", "Jenkins"}
set2 = {"AWS", "Terraform", "Docker"}

# Union — all elements from both
print(set1 | set2)   # {'Docker', 'Ansible', 'Jenkins', 'AWS', 'Terraform'}

# Intersection — common elements only
print(set1 & set2)   # {'Docker'}

# Difference — in set1 but not set2
print(set1 - set2)   # {'Ansible', 'Jenkins'}
```

> **💼 DevOps Use Case:** Find which servers are in both staging and production, or find tools used in multiple pipelines.

---

### 5.4 Dictionaries — Key-Value Pairs

```python
server = {
    "name":   "web01",
    "ip":     "192.168.1.10",
    "status": "running"
}

# Access
print(server["name"])         # web01
print(server.get("status"))   # running (safer — returns None if key missing)

# Add / Update
server["region"] = "ap-south-1"    # Add new key
server["status"] = "stopped"       # Update existing key

# Delete
del server["ip"]                    # Remove key-value pair

# Iterate
for key, value in server.items():
    print(f"{key}: {value}")

# Check key existence
if "region" in server:
    print("Region is defined")
```

---

### 5.5 Nested Data Structures

#### List of Dictionaries (Very common in DevOps — AWS API responses)
```python
servers = [
    {"name": "web01",   "status": "running"},
    {"name": "db01",    "status": "stopped"},
    {"name": "cache01", "status": "running"}
]

# Filter only running servers
for s in servers:
    if s["status"] == "running":
        print(f"✅ {s['name']} is healthy")
```

#### Dictionary of Lists
```python
deployments = {
    "production": ["web01", "web02"],
    "staging":    ["stg01", "stg02"]
}

for env, servers in deployments.items():
    print(f"Environment: {env}")
    for server in servers:
        print(f"  → {server}")
```

---

## 6. Functions

### 6.1 Basic Function

```python
# Define
def greet():
    print("Welcome to Python for DevOps!")

# Call
greet()
```

### 6.2 Function with Parameters & Return Value

```python
def check_service(status):
    if status == "running":
        return "✅ Healthy"
    else:
        return "❌ Issue Detected"

# Call and store result
result = check_service("running")
print(result)   # ✅ Healthy
```

---

### 6.3 Types of Function Arguments

#### Positional Arguments
```python
def deploy(environment, version):
    print(f"Deploying version {version} to {environment}")

deploy("production", "2.1.0")   # order matters!
```

#### Keyword Arguments
```python
deploy(version="2.1.0", environment="staging")  # order doesn't matter
```

#### Default Arguments
```python
def start_server(name, region="ap-south-1"):
    print(f"Starting {name} in region {region}")

start_server("web01")                   # uses default region
start_server("web02", "us-east-1")      # overrides default
```

#### Variable-Length Positional Arguments (`*args`)
```python
def install_tools(*tools):
    for tool in tools:
        print(f"Installing {tool}...")

install_tools("Docker", "Jenkins", "Ansible")
install_tools("Docker", "Jenkins", "Ansible", "Terraform", "ArgoCD")
# Any number of arguments!
```

#### Variable-Length Keyword Arguments (`**kwargs`)
```python
def server_details(**info):
    for key, value in info.items():
        print(f"{key}: {value}")

server_details(name="web01", ip="10.0.0.1", status="running", memory="8GB")
```

---

### 6.4 Lambda Functions

**Lambda** = small, anonymous, one-line function.

```python
# Syntax: lambda parameters: expression
square = lambda x: x * x
print(square(5))   # 25

# DevOps use case — filter running servers
servers = [
    {"name": "web01", "status": "running"},
    {"name": "db01",  "status": "stopped"},
    {"name": "api01", "status": "running"}
]

running = list(filter(lambda s: s["status"] == "running", servers))
print(running)
# [{'name': 'web01', 'status': 'running'}, {'name': 'api01', 'status': 'running'}]
```

---

### 6.5 Variable Scope (Local vs Global)

```python
instance_count = 5   # Global variable

def launch_instances():
    new_count = 3    # Local variable — only accessible inside this function
    print(f"Launching {new_count} new instances")
    print(f"Total running: {instance_count}")  # Can read global

launch_instances()
print(instance_count)   # 5 — accessible anywhere
# print(new_count)      # ❌ NameError — local variable not accessible outside
```

---

### 6.6 Nested Functions

```python
def devops_pipeline():
    def build():
        print("🔨 Building code...")
    def deploy():
        print("🚀 Deploying to servers...")

    build()    # must call inner functions
    deploy()

devops_pipeline()
```

---

### 🔥 Simple DevOps Programs — Functions

#### Program 1: Disk Space Checker
```python
import random

def check_disk_space(server_name):
    """Simulate checking disk space on a server"""
    usage = random.randint(50, 95)   # Simulated usage %
    print(f"📊 {server_name} — Disk Usage: {usage}%")
    
    if usage > 85:
        print(f"  🚨 ALERT: High disk usage on {server_name}! Cleanup required.")
    else:
        print(f"  ✅ Disk usage is normal.")

# Call for multiple servers
check_disk_space("web-server-01")
check_disk_space("db-server-01")
check_disk_space("app-server-01")
```
**Explanation:** Simulates a real monitoring scenario where you check disk usage on multiple servers. In production, replace `random.randint` with actual `psutil.disk_usage('/')` calls.

---

#### Program 2: Log Error Counter
```python
def count_errors(log_lines):
    """Count ERROR occurrences in log lines"""
    error_count = 0
    for line in log_lines:
        if "ERROR" in line:
            error_count += 1
    return error_count

# Simulated log data
logs = [
    "2024-01-01 INFO Service started",
    "2024-01-01 ERROR Database connection failed",
    "2024-01-01 INFO Retry attempt 1",
    "2024-01-01 ERROR Timeout reached",
    "2024-01-01 INFO Service recovered"
]

total_errors = count_errors(logs)
print(f"📋 Total errors found: {total_errors}")
```
**Explanation:** Demonstrates a basic log analyzer — a very common DevOps task. Functions make it reusable — you can call it for different log files.

---

#### Program 3: EC2 Instance Action Simulator
```python
def manage_ec2(action, instance_id):
    """Simulate EC2 start/stop/status actions"""
    valid_actions = ["start", "stop", "status"]
    
    if action not in valid_actions:
        return f"❌ Invalid action: {action}. Use: {valid_actions}"
    
    if action == "start":
        return f"✅ Starting EC2 instance: {instance_id}"
    elif action == "stop":
        return f"⛔ Stopping EC2 instance: {instance_id}"
    elif action == "status":
        return f"📊 Fetching status of: {instance_id}"

# Usage
print(manage_ec2("start",  "i-1234567890abcdef0"))
print(manage_ec2("stop",   "i-0987654321fedcba0"))
print(manage_ec2("status", "i-1234567890abcdef0"))
print(manage_ec2("reboot", "i-1234567890abcdef0"))  # Invalid
```
**Explanation:** Shows how to build a reusable utility function for cloud operations. In real-world use, replace the `return` statements with actual Boto3 calls.

---

#### Program 4: Deploy Version Tracker
```python
def deploy_app(app_name, version, environment="staging"):
    """Track and validate deployments"""
    valid_envs = ["staging", "production", "dev"]
    
    if environment not in valid_envs:
        print(f"❌ Unknown environment: {environment}")
        return
    
    if environment == "production" and not version.startswith("v"):
        print("❌ Production versions must start with 'v' (e.g., v2.1.0)")
        return
    
    print(f"🚀 Deploying {app_name} version {version} to {environment}...")
    print(f"✅ Deployment complete!")

deploy_app("my-api",    "v2.1.0",  "production")
deploy_app("my-api",    "latest",  "production")   # Will fail validation
deploy_app("my-api",    "latest",  "staging")      # Works fine
deploy_app("my-api",    "v1.0.0",  "qa")           # Unknown env
```
**Explanation:** Shows input validation in deployment functions — a best practice in real CI/CD automation. Prevents accidental deployments with wrong version formats.

---

## 7. Modules & Packages

### 7.1 What is a Module?
A **module** is simply a `.py` file that contains functions, variables, and classes that you can **import and reuse** in other scripts.

```python
# File: devops_utils.py
def start_server(server_name):
    print(f"🟢 Starting server: {server_name}")

def stop_server(server_name):
    print(f"🔴 Stopping server: {server_name}")

def get_status(server_name):
    print(f"📊 Checking status of: {server_name}")
```

```python
# File: main.py
import devops_utils

devops_utils.start_server("web01")
devops_utils.stop_server("db01")
devops_utils.get_status("cache01")
```

```bash
python3 main.py
# 🟢 Starting server: web01
# 🔴 Stopping server: db01
# 📊 Checking status of: cache01
```

#### Import Styles
```python
import os                             # import whole module
from os import getcwd, listdir        # import specific functions
from os import getcwd as get_dir      # import with alias
import os as operating_system         # module alias
```

---

### 7.2 Built-in Python Modules (Critical for DevOps)

#### `os` Module — Interact with Operating System
```python
import os

# Current working directory
print(os.getcwd())

# Change directory
os.chdir("/home/ubuntu")

# List files and folders
print(os.listdir("."))

# Create directory
os.makedirs("backup/logs", exist_ok=True)  # exist_ok prevents error if exists

# Remove directory
os.rmdir("old_logs")

# Rename file
os.rename("old.log", "archive.log")

# Delete file
os.remove("temp.txt")

# Run shell command (simple)
os.system("ls -la")

# Get environment variable
db_host = os.getenv("DB_HOST", "localhost")   # default = "localhost"
print(f"DB Host: {db_host}")
```

---

#### `sys` Module — System Information
```python
import sys

print(sys.version)      # Python version
print(sys.platform)     # 'linux', 'win32', etc.
print(sys.argv)         # Command-line arguments as a list
print(sys.path)         # Python module search paths

# Exit script with code
# sys.exit(0)    # 0 = success
# sys.exit(1)    # 1 = error
```

```bash
python3 script.py hello world
# sys.argv = ['script.py', 'hello', 'world']
```

---

#### `subprocess` Module — Run Shell Commands
```python
import subprocess

# Run command and get output
output = subprocess.check_output("uptime", shell=True, text=True)
print(f"Server uptime: {output.strip()}")

# Run command — check return code
result = subprocess.run(
    ["df", "-h"],          # command as list (safer)
    capture_output=True,
    text=True
)
print(result.stdout)
print("Return code:", result.returncode)  # 0 = success

# Run with error handling
result = subprocess.run(
    ["systemctl", "status", "nginx"],
    capture_output=True,
    text=True
)
if result.returncode == 0:
    print("✅ Nginx is running")
else:
    print("❌ Nginx is not running")
    print(result.stderr)
```

> **💼 DevOps Use Case:** Check service status, restart services, run Ansible playbooks, execute kubectl commands — all from Python.

---

#### `shutil` Module — High-Level File Operations
```python
import shutil

# Copy file
shutil.copy("source.txt", "backup/source.txt")

# Copy entire directory
shutil.copytree("configs/", "configs_backup/")

# Move file
shutil.move("source.txt", "archive/source.txt")

# Delete entire directory tree
shutil.rmtree("old_logs/")
```

---

#### `json` Module — Work with JSON Data
```python
import json

# Python dictionary → JSON string (serialization)
server_info = {
    "name": "web01",
    "ip":   "10.0.0.1",
    "port": 8080
}

json_str = json.dumps(server_info, indent=4)
print(json_str)
print(type(json_str))   # <class 'str'>

# JSON string → Python dictionary (deserialization)
json_data = '{"name": "db01", "status": "running"}'
parsed = json.loads(json_data)
print(parsed["name"])    # db01
print(type(parsed))      # <class 'dict'>

# Write JSON to file
with open("config.json", "w") as f:
    json.dump(server_info, f, indent=4)

# Read JSON from file
with open("config.json", "r") as f:
    config = json.load(f)
    print(config["name"])
```

> **💼 DevOps Use Case:** Parse AWS CLI output (JSON), read Terraform state files, store deployment configs.

---

#### `datetime` Module — Dates & Times
```python
from datetime import datetime, date, timedelta

# Current date and time
now = datetime.now()
print(f"Current datetime: {now}")

# Today's date only
today = date.today()
print(f"Today: {today}")

# Format dates
formatted = now.strftime("%d-%m-%Y %H:%M:%S")
print(f"Formatted: {formatted}")

# Timestamp for log file names
timestamp = now.strftime("%Y%m%d_%H%M%S")
log_file = f"app_{timestamp}.log"
print(f"Log file: {log_file}")   # app_20240115_143022.log

# Date arithmetic
tomorrow = today + timedelta(days=1)
last_week = today - timedelta(days=7)
print(f"Tomorrow: {tomorrow}")
print(f"Last week: {last_week}")
```

> **💼 DevOps Use Case:** Add timestamps to backup files, log rotation names, calculate certificate expiry dates.

---

### 7.3 What is a Package?
A **package** is a **directory (folder)** containing multiple Python modules along with a special `__init__.py` file. The `__init__.py` file marks the folder as a Python package.

```
devops_tools/           ← Package (folder)
├── __init__.py         ← Marks as package
├── aws_utils.py        ← Module
└── docker_utils.py     ← Module
main.py
```

```python
# devops_tools/__init__.py
# Mark this folder as a package
```

```python
# devops_tools/aws_utils.py
def deploy_ec2(instance_name):
    print(f"🚀 Deploying EC2 instance: {instance_name}")
```

```python
# devops_tools/docker_utils.py
def start_container(container_name):
    print(f"🐳 Starting Docker container: {container_name}")
```

```python
# main.py
from devops_tools import aws_utils, docker_utils

aws_utils.deploy_ec2("web-server-01")
docker_utils.start_container("nginx-container")
```

```bash
python3 main.py
# 🚀 Deploying EC2 instance: web-server-01
# 🐳 Starting Docker container: nginx-container
```

---

### 7.4 Third-Party Libraries for DevOps

Install with `pip`:
```bash
pip3 install boto3 paramiko requests psutil
```

| Library | Purpose |
|---|---|
| `boto3` | AWS SDK — manage EC2, S3, Lambda, etc. |
| `paramiko` | SSH into remote servers |
| `requests` | HTTP requests — call REST APIs |
| `psutil` | System monitoring — CPU, memory, disk |
| `pyyaml` | Read/write YAML files |
| `python-dotenv` | Load `.env` environment variable files |

```python
# boto3 — AWS EC2 example
import boto3

ec2 = boto3.client("ec2", region_name="us-east-1")

# List all EC2 instances
response = ec2.describe_instances()
for reservation in response["Reservations"]:
    for instance in reservation["Instances"]:
        print(f"ID: {instance['InstanceId']} | State: {instance['State']['Name']}")
```

```python
# paramiko — SSH to remote server
import paramiko

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect("192.168.1.100", username="ubuntu", key_filename="/home/user/.ssh/id_rsa")

stdin, stdout, stderr = client.exec_command("uptime")
print(stdout.read().decode())
client.close()
```

```python
# requests — Check GitHub API
import requests

response = requests.get("https://api.github.com/repos/torvalds/linux")
if response.status_code == 200:
    data = response.json()
    print(f"Stars: {data['stargazers_count']}")
else:
    print(f"❌ Request failed: {response.status_code}")
```

---

### 🔥 Simple DevOps Programs — Modules

#### Program 1: OS Module — Disk & Directory Management
```python
import os

def setup_log_directory(base_path):
    """Create log directory if it doesn't exist"""
    log_dir = os.path.join(base_path, "logs")
    
    if not os.path.exists(log_dir):
        os.makedirs(log_dir)
        print(f"✅ Created log directory: {log_dir}")
    else:
        print(f"📁 Log directory already exists: {log_dir}")
    
    # List existing files
    files = os.listdir(log_dir)
    print(f"📋 Files in log dir: {files if files else 'Empty'}")

setup_log_directory("/tmp")
```
**Explanation:** Uses `os.path.exists`, `os.makedirs`, and `os.listdir` — three of the most frequently used OS module functions in DevOps automation scripts.

---

#### Program 2: JSON Module — Read Config File
```python
import json
import os

def read_deployment_config(config_file):
    """Read and validate deployment configuration"""
    if not os.path.exists(config_file):
        print(f"❌ Config file not found: {config_file}")
        return None
    
    with open(config_file, "r") as f:
        config = json.load(f)
    
    print(f"🚀 App Name  : {config.get('app_name', 'Unknown')}")
    print(f"🌍 Environment: {config.get('environment', 'Unknown')}")
    print(f"📦 Version    : {config.get('version', 'Unknown')}")
    return config

# Create a sample config first
config_data = {
    "app_name":    "my-web-app",
    "environment": "production",
    "version":     "v2.1.0",
    "replicas":    3
}
with open("deploy_config.json", "w") as f:
    json.dump(config_data, f, indent=4)

# Read and use the config
read_deployment_config("deploy_config.json")
```
**Explanation:** This is a very real-world pattern — reading a JSON config file before starting a deployment. The `config.get()` method with a default value is a best practice (prevents `KeyError`).

---

#### Program 3: Subprocess Module — Service Health Check
```python
import subprocess

def check_service_status(service_name):
    """Check if a Linux service is running"""
    result = subprocess.run(
        ["systemctl", "is-active", service_name],
        capture_output=True,
        text=True
    )
    
    status = result.stdout.strip()
    
    if status == "active":
        print(f"✅ {service_name} is RUNNING")
    elif status == "inactive":
        print(f"⚠️  {service_name} is STOPPED")
    else:
        print(f"❓ {service_name} status: {status}")
    
    return status

# Check multiple services
services = ["nginx", "sshd", "cron"]
for service in services:
    check_service_status(service)
```
**Explanation:** Uses `subprocess.run()` — the modern, recommended way to execute shell commands from Python. `capture_output=True` captures both stdout and stderr. Essential for automation scripts.

---

#### Program 4: Datetime + OS — Timestamped Backup
```python
import os
import shutil
from datetime import datetime

def backup_config_file(source_file):
    """Create a timestamped backup of a config file"""
    if not os.path.exists(source_file):
        print(f"❌ Source file not found: {source_file}")
        return
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_file = f"{source_file}.backup_{timestamp}"
    
    shutil.copy2(source_file, backup_file)
    print(f"✅ Backup created: {backup_file}")
    return backup_file

# Create a sample file to backup
with open("nginx.conf", "w") as f:
    f.write("# Nginx configuration\nserver { listen 80; }")

backup_config_file("nginx.conf")
# Output: ✅ Backup created: nginx.conf.backup_20240115_143022
```
**Explanation:** A real DevOps pattern — always back up config files before modifying them. Timestamp in filename makes it easy to find the most recent backup.

---

## 8. File Handling

### 8.1 File Modes

| Mode | Description |
|---|---|
| `r` | Read — default, file must exist |
| `w` | Write — creates file if not exists, **overwrites** if exists |
| `a` | Append — adds to end of file, creates if not exists |
| `x` | Create — creates new file, **error** if already exists |
| `r+` | Read + Write |
| `b` | Binary mode (e.g., `rb`, `wb`) |

---

### 8.2 Writing, Reading, Appending

```python
# WRITE (creates or overwrites file)
file = open("devops_notes.txt", "w")
file.write("Python makes DevOps automation easy.\n")
file.write("Log monitoring is essential.\n")
file.close()   # Always close the file!

# READ
file = open("devops_notes.txt", "r")
content = file.read()
print(content)
file.close()

# APPEND (add to end without deleting existing content)
file = open("devops_notes.txt", "a")
file.write("Always secure your secrets!\n")
file.close()
```

---

### 8.3 Context Manager — The Right Way (`with` statement)

The `with` statement **automatically closes** the file even if an error occurs. This is the **recommended approach** in production.

```python
# Writing
with open("servers.txt", "w") as f:
    f.write("web01\n")
    f.write("db01\n")
    f.write("cache01\n")
# File is automatically closed here

# Reading all at once
with open("servers.txt", "r") as f:
    content = f.read()
    print(content)

# Reading line by line (memory efficient for large files)
with open("servers.txt", "r") as f:
    for line in f:
        print(f"Server: {line.strip()}")   # .strip() removes \n
```

---

### 8.4 JSON File Handling

```python
import json

# Write JSON to file
config = {
    "app": "web-app",
    "servers": ["web01", "web02"],
    "environment": "production"
}

with open("config.json", "w") as f:
    json.dump(config, f, indent=4)
print("✅ config.json written")

# Read JSON from file
with open("config.json", "r") as f:
    data = json.load(f)
    print(f"App: {data['app']}")
    print(f"Servers: {data['servers']}")
    print(f"Environment: {data['environment']}")
```

---

### 8.5 YAML File Handling

```bash
# Install PyYAML first
pip3 install pyyaml
```

```python
import yaml

# Write YAML file
deployment = {
    "app": "nginx",
    "environment": "staging",
    "replicas": 3,
    "image": "nginx:1.25"
}

with open("deployment.yaml", "w") as f:
    yaml.dump(deployment, f, default_flow_style=False)

# deployment.yaml looks like:
# app: nginx
# environment: staging
# replicas: 3
# image: nginx:1.25

# Read YAML file
with open("deployment.yaml", "r") as f:
    config = yaml.safe_load(f)   # safe_load is more secure
    print(f"App: {config['app']}")
    print(f"Replicas: {config['replicas']}")
```

> **💼 DevOps Use Case:** Parse Kubernetes YAML manifests, Ansible playbooks, Docker Compose files.

---

### 8.6 CSV File Handling

```python
import csv

# Write CSV
with open("servers.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["Server", "IP", "Status"])          # Header row
    writer.writerow(["web01", "10.0.0.1", "running"])
    writer.writerow(["db01",  "10.0.0.2", "stopped"])

# Read CSV
with open("servers.csv", "r") as f:
    reader = csv.DictReader(f)   # DictReader reads rows as dicts
    for row in reader:
        print(f"{row['Server']} ({row['IP']}) — {row['Status']}")
```

---

### 8.7 Log Analysis Example

```python
def analyze_log(log_file):
    """Count errors in a log file"""
    error_count   = 0
    warning_count = 0
    
    with open(log_file, "r") as f:
        for line in f:
            if "ERROR" in line:
                error_count += 1
            elif "WARNING" in line:
                warning_count += 1
    
    print(f"📊 Log Analysis — {log_file}")
    print(f"  ❌ Errors:   {error_count}")
    print(f"  ⚠️  Warnings: {warning_count}")

analyze_log("system.log")
```

---

### 8.8 Log Rotation

```python
import shutil
import os
from datetime import datetime

def rotate_log(log_file):
    """Rotate a log file with timestamp"""
    if not os.path.exists(log_file):
        print(f"❌ Log file not found: {log_file}")
        return
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    archived_name = f"{log_file}.{timestamp}.bak"
    
    shutil.move(log_file, archived_name)
    print(f"✅ Log rotated → {archived_name}")
    
    # Create fresh empty log file
    open(log_file, "w").close()
    print(f"📄 New empty log file created: {log_file}")

rotate_log("app.log")
```

---

## 9. Exception Handling

### 9.1 Why Exception Handling?

Without exception handling, your script crashes at the first error and all subsequent code is skipped.

```python
# Without exception handling — BAD ❌
print("Script starting...")
result = 10 / 0         # ZeroDivisionError — script stops here
print("Script completed")   # Never executes!
```

```python
# With exception handling — GOOD ✅
print("Script starting...")
try:
    result = 10 / 0
except ZeroDivisionError:
    print("⚠️ Cannot divide by zero!")
print("Script completed")   # Now this WILL execute
```

---

### 9.2 try / except / else / finally

```python
try:
    # Code that might raise an exception
    file = open("config.txt", "r")
    content = file.read()

except FileNotFoundError:
    # Runs ONLY if FileNotFoundError occurs
    print("❌ File not found!")

except PermissionError:
    # Runs ONLY if PermissionError occurs
    print("❌ Permission denied!")

else:
    # Runs ONLY if NO exception occurred
    print("✅ File read successfully!")
    print(content)

finally:
    # ALWAYS runs — whether exception occurred or not
    print("🔒 Closing file operation.")
```

#### Key Rules
| Block | When it runs |
|---|---|
| `try` | Always — contains code that might fail |
| `except` | Only when the specified exception occurs |
| `else` | Only when NO exception occurred |
| `finally` | **Always** — even if exception occurs |

> **🎯 Interview Tip:** `finally` is used for cleanup — closing files, DB connections, releasing locks.

---

### 9.3 Common Python Exceptions

| Exception | Cause |
|---|---|
| `FileNotFoundError` | File doesn't exist |
| `ZeroDivisionError` | Dividing by zero |
| `ValueError` | Wrong value type |
| `KeyError` | Dictionary key not found |
| `IndexError` | List index out of range |
| `TypeError` | Wrong data type in operation |
| `ImportError` | Module not found |
| `TimeoutError` | Operation timed out |
| `PermissionError` | Insufficient permissions |
| `ConnectionError` | Network connection failed |

---

### 9.4 Multiple Exceptions

```python
def safe_divide(num_str):
    try:
        result = 10 / int(num_str)
        print(f"Result: {result}")
    except ZeroDivisionError:
        print("❌ Cannot divide by zero!")
    except ValueError:
        print("❌ Please enter a valid number!")

safe_divide("5")    # Result: 2.0
safe_divide("0")    # Cannot divide by zero!
safe_divide("abc")  # Please enter a valid number!
```

---

### 9.5 Raising Custom Exceptions with `raise`

```python
class DeploymentError(Exception):
    """Custom exception for deployment failures"""
    pass

def deploy(version):
    if float(version) < 1.0:
        raise DeploymentError(f"❌ Invalid version {version}. Must be >= 1.0")
    print(f"✅ Deploying version {version}")

try:
    deploy("0.8")
except DeploymentError as e:
    print(f"Deployment failed: {e}")
```

---

### 9.6 Creating Custom Exception Classes

```python
class ServerNotFoundError(Exception):
    """Raised when a server cannot be reached"""
    pass

class InsufficientResourcesError(Exception):
    """Raised when server lacks required resources"""
    def __init__(self, required, available):
        super().__init__(
            f"Required: {required}GB, Available: {available}GB"
        )

# Usage
try:
    available_memory = 2
    required_memory  = 8
    if available_memory < required_memory:
        raise InsufficientResourcesError(required_memory, available_memory)
except InsufficientResourcesError as e:
    print(f"❌ Resource Error: {e}")
```

---

### 9.7 Retry Pattern (Very Common in DevOps)

```python
import time

def connect_to_server(server_ip, max_retries=3):
    """Retry connection with backoff"""
    for attempt in range(1, max_retries + 1):
        try:
            print(f"🔌 Connecting to {server_ip} — Attempt {attempt}/{max_retries}")
            
            # Simulate connection failure
            raise ConnectionError("Connection refused")
            
            print(f"✅ Connected to {server_ip}")
            return True
            
        except ConnectionError as e:
            print(f"  ❌ Failed: {e}")
            if attempt < max_retries:
                wait = attempt * 2   # Exponential backoff: 2s, 4s, 6s...
                print(f"  ⏳ Retrying in {wait} seconds...")
                time.sleep(wait)
    
    print(f"💀 Could not connect to {server_ip} after {max_retries} attempts.")
    return False

connect_to_server("10.0.0.1")
```

---

### 9.8 Logging Exceptions to File

```python
import logging

# Configure logging
logging.basicConfig(
    filename="errors.log",
    level=logging.ERROR,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

def risky_operation():
    try:
        result = 10 / 0
    except ZeroDivisionError as e:
        logging.error(f"Math error occurred: {e}")
        print("❌ Error logged to errors.log")

risky_operation()
```

> **💡 Production Best Practice:** Never use `print()` for errors in production. Always use `logging`. It writes to files, supports levels (`DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`), and includes timestamps.

---

## 10. Object-Oriented Programming (OOP)

### 10.1 What is OOP?

OOP organizes code into **objects** — entities that combine **data (attributes)** and **behavior (methods)** together.

| Concept | Simple Definition |
|---|---|
| **Class** | Blueprint / Template |
| **Object** | Instance created from blueprint |
| **Encapsulation** | Hide internal details (private variables/methods) |
| **Inheritance** | Child class reuses code from parent class |
| **Polymorphism** | Same method name — different behavior |
| **Abstraction** | Hide complexity, show only what's needed |

---

### 10.2 Class & Object

```python
class Server:
    def __init__(self, name, ip):
        # __init__ = constructor — runs automatically when object is created
        self.name = name   # instance variable
        self.ip   = ip     # instance variable
    
    def start(self):
        print(f"🟢 Starting server {self.name} at {self.ip}")
    
    def stop(self):
        print(f"🔴 Stopping server {self.name}")
    
    def status(self):
        print(f"📊 {self.name} ({self.ip}) — checking status...")

# Create objects (instances of Server class)
web_server = Server("web01", "192.168.1.10")
db_server  = Server("db01",  "192.168.1.20")

web_server.start()
db_server.stop()
```

---

### 10.3 Encapsulation

Hide internal data using **private variables/methods** (prefix with `__`).

```python
class JenkinsPipeline:
    def __init__(self, project_name):
        self.__project = project_name   # Private variable
        self.__build_number = 0         # Private variable
    
    def __run_build(self):
        # Private method — can only be called inside this class
        self.__build_number += 1
        print(f"🔨 Running build #{self.__build_number} for {self.__project}")
    
    def trigger_pipeline(self):
        # Public method — callable from outside
        print(f"🚀 Triggering pipeline for {self.__project}")
        self.__run_build()
        print(f"✅ Pipeline complete!")

pipeline = JenkinsPipeline("my-web-app")
pipeline.trigger_pipeline()

# pipeline.__run_build()  # ❌ AttributeError — private method!
```

---

### 10.4 Inheritance

Child class inherits properties and methods from parent class.

```python
class Server:
    """Parent class"""
    def __init__(self, name):
        self.name = name
    
    def start(self):
        print(f"🟢 Starting server: {self.name}")

class WebServer(Server):
    """Child class — inherits from Server"""
    def deploy(self, app_name):
        print(f"🚀 Deploying {app_name} on {self.name}")

class DatabaseServer(Server):
    """Child class — inherits from Server"""
    def backup(self):
        print(f"💾 Creating backup on {self.name}")

# WebServer gets start() from Server + has its own deploy()
web = WebServer("nginx-server")
web.start()      # Inherited from Server
web.deploy("my-app")  # Own method

db = DatabaseServer("postgres-server")
db.start()   # Inherited from Server
db.backup()  # Own method
```

---

### 10.5 Polymorphism

Same method name — different behavior in different classes.

```python
class Server:
    def restart(self):
        print("🔄 Restarting generic server...")

class WebServer(Server):
    def restart(self):
        print("🔄 Restarting Nginx web server — draining connections first...")

class DatabaseServer(Server):
    def restart(self):
        print("🔄 Restarting MySQL — flushing data & closing connections...")

# Polymorphism in action
servers = [WebServer(), DatabaseServer()]

for server in servers:
    server.restart()   # Same method call — different output!
```

---

### 10.6 Abstraction

Hide complexity from users. Use `ABC` (Abstract Base Class).

```python
from abc import ABC, abstractmethod

class CloudProvider(ABC):
    """Abstract class — defines interface"""
    
    @abstractmethod
    def create_instance(self, instance_type):
        pass   # No implementation — subclass MUST implement this
    
    @abstractmethod
    def delete_instance(self, instance_id):
        pass

class AWS(CloudProvider):
    def create_instance(self, instance_type):
        print(f"☁️  AWS: Launching EC2 {instance_type}")
    
    def delete_instance(self, instance_id):
        print(f"☁️  AWS: Terminating {instance_id}")

class Azure(CloudProvider):
    def create_instance(self, instance_type):
        print(f"☁️  Azure: Launching VM {instance_type}")
    
    def delete_instance(self, instance_id):
        print(f"☁️  Azure: Deleting {instance_id}")

aws   = AWS()
azure = Azure()
aws.create_instance("t3.micro")
azure.create_instance("Standard_D2s_v3")

# cloud = CloudProvider()  # ❌ TypeError — can't instantiate abstract class!
```

---

### 10.7 Class Variables vs Instance Variables

```python
class Server:
    # Class variable — shared by ALL instances
    datacenter = "AP-South-1"
    
    def __init__(self, name):
        # Instance variable — unique to each instance
        self.name = name

s1 = Server("web01")
s2 = Server("db01")

print(s1.name)        # web01    — unique to s1
print(s2.name)        # db01     — unique to s2
print(s1.datacenter)  # AP-South-1 — same for both!
print(s2.datacenter)  # AP-South-1 — same for both!
```

---

### 10.8 Magic Methods (Dunder Methods)

```python
class Server:
    def __init__(self, name, services):
        self.name     = name
        self.services = services
    
    def __str__(self):
        """Called when you print(object)"""
        return f"Server: {self.name} | Services: {', '.join(self.services)}"
    
    def __len__(self):
        """Called when you use len(object)"""
        return len(self.services)
    
    def __repr__(self):
        """Unambiguous representation — for debugging"""
        return f"Server(name={self.name!r}, services={self.services!r})"

s = Server("web01", ["nginx", "nodejs", "redis"])
print(s)        # Calls __str__ — Server: web01 | Services: nginx, nodejs, redis
print(len(s))   # Calls __len__ — 3
print(repr(s))  # Calls __repr__
```

---

## 11. Advanced Topics

### 11.1 Iterators

An **iterator** is an object that returns elements one at a time.

```python
# Convert list to iterator
servers = ["web01", "web02", "web03"]
it = iter(servers)

print(next(it))   # web01
print(next(it))   # web02
print(next(it))   # web03
# next(it)        # StopIteration error — no more elements
```

---

### 11.2 Generators

A **generator** uses `yield` instead of `return` — produces values **one at a time** without loading everything into memory. Ideal for large files or large datasets.

```python
def get_log_lines(filepath):
    """Memory-efficient log reader — one line at a time"""
    with open(filepath, "r") as f:
        for line in f:
            yield line.strip()

# Process a 10GB log file without loading it all into memory!
for line in get_log_lines("large.log"):
    if "ERROR" in line:
        print(f"Error found: {line}")
```

> **💼 DevOps Use Case:** Processing large log files, streaming S3 objects, generating large config files.

---

### 11.3 Decorators

A **decorator** is a function that adds functionality to another function **without modifying its code**.

```python
import time

def timer(func):
    """Decorator — measures execution time of any function"""
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"⏱️  {func.__name__} took {end - start:.4f} seconds")
        return result
    return wrapper

def logger(func):
    """Decorator — logs function calls"""
    def wrapper(*args, **kwargs):
        print(f"📋 Calling: {func.__name__}")
        result = func(*args, **kwargs)
        print(f"✅ Completed: {func.__name__}")
        return result
    return wrapper

@timer
@logger
def deploy_application(app_name):
    print(f"🚀 Deploying {app_name}...")
    time.sleep(1)   # Simulate deployment

deploy_application("my-app")
# 📋 Calling: deploy_application
# 🚀 Deploying my-app...
# ✅ Completed: deploy_application
# ⏱️  deploy_application took 1.0023 seconds
```

---

### 11.4 Regular Expressions (`re` module)

```python
import re

# Find email addresses in text
text = "Contact: admin@company.com or support@devops.io for help"
emails = re.findall(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b', text)
print(f"Emails found: {emails}")

# Extract IP addresses from log file
log = """
2024-01-15 ERROR from 192.168.1.10
2024-01-15 WARNING from 10.0.0.55
2024-01-15 INFO from 172.16.0.1
"""
ips = re.findall(r'\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b', log)
print(f"IP addresses: {ips}")

# Extract HTTP status codes from access log
access_log = "GET /api/health 200 OK\nGET /api/data 500 Error\nGET /login 404 Not Found"
codes = re.findall(r'\b[2-5]\d{2}\b', access_log)
print(f"Status codes: {codes}")
```

---

### 11.5 Multi-threading

Run multiple **threads** (lightweight tasks) **concurrently** — good for I/O-bound tasks (API calls, file reads, network operations).

```python
import threading
import time

def check_server(server_name, delay):
    """Simulate checking a server's health"""
    time.sleep(delay)   # Simulate network latency
    print(f"✅ {server_name} — Health check complete")

servers = [
    ("web01", 1),
    ("db01",  2),
    ("api01", 1.5)
]

print("🔍 Starting parallel health checks...")
start = time.time()

threads = []
for name, delay in servers:
    t = threading.Thread(target=check_server, args=(name, delay))
    threads.append(t)
    t.start()

# Wait for all threads to complete
for t in threads:
    t.join()

elapsed = time.time() - start
print(f"⏱️  All checks done in {elapsed:.2f}s (vs {sum(d for _,d in servers)}s sequential)")
```

---

### 11.6 Multi-processing

Run multiple **processes** with **separate memory** — good for CPU-bound tasks. Bypasses Python's GIL.

```python
import multiprocessing
import time

def compress_logs(server_name):
    """Simulate compressing logs on a server"""
    print(f"🗜️  Compressing logs on {server_name}...")
    time.sleep(2)
    print(f"✅ Done compressing on {server_name}")

if __name__ == "__main__":   # Required for multiprocessing on Windows/Mac
    servers = ["web01", "db01", "cache01"]
    
    processes = []
    for server in servers:
        p = multiprocessing.Process(target=compress_logs, args=(server,))
        processes.append(p)
        p.start()
    
    for p in processes:
        p.join()
    
    print("✅ Log compression complete on all servers!")
```

| Feature | Multi-threading | Multi-processing |
|---|---|---|
| Memory | Shared | Separate |
| Best for | I/O-bound (API, files, network) | CPU-bound (math, compression) |
| GIL affected | Yes | No |
| Use case | Parallel API calls | Parallel data processing |

---

### 11.7 argparse — Command Line Arguments

```python
# deploy.py
import argparse

parser = argparse.ArgumentParser(description="Deployment automation script")

parser.add_argument("--env",      required=True,  help="Target environment (dev/staging/production)")
parser.add_argument("--version",  required=True,  help="App version to deploy (e.g., v2.1.0)")
parser.add_argument("--replicas", type=int, default=2, help="Number of replicas (default: 2)")
parser.add_argument("--dry-run",  action="store_true", help="Simulate without actually deploying")

args = parser.parse_args()

print(f"🚀 Deployment Config:")
print(f"   Environment : {args.env}")
print(f"   Version     : {args.version}")
print(f"   Replicas    : {args.replicas}")
print(f"   Dry Run     : {args.dry_run}")

if not args.dry_run:
    print(f"\n✅ Deploying {args.version} to {args.env} with {args.replicas} replicas...")
else:
    print(f"\n🧪 DRY RUN — No actual deployment made.")
```

```bash
# Run it
python3 deploy.py --env production --version v2.1.0 --replicas 3
python3 deploy.py --env staging --version v2.1.0 --dry-run

# Built-in help
python3 deploy.py --help
```

---

### 11.8 Environment Variables

```python
import os

# Read environment variable (with default fallback)
db_host     = os.getenv("DB_HOST",     "localhost")
db_password = os.getenv("DB_PASSWORD", "")         # Don't hardcode secrets!
aws_region  = os.getenv("AWS_REGION",  "us-east-1")
environment = os.getenv("APP_ENV",     "development")

print(f"DB Host:     {db_host}")
print(f"AWS Region:  {aws_region}")
print(f"Environment: {environment}")

if not db_password:
    print("⚠️  WARNING: DB_PASSWORD environment variable not set!")
```

```bash
# Set environment variables
export DB_HOST="prod-db.company.com"
export DB_PASSWORD="super_secret_password"
export APP_ENV="production"

python3 app.py
```

> **💡 Production Best Practice:** **Never hardcode secrets** (passwords, API keys, tokens) in your code. Always use environment variables or a secrets manager (AWS Secrets Manager, HashiCorp Vault).

---

### 11.9 Task Scheduling

#### Using `time.sleep()` for delays
```python
import time

def backup_databases():
    print("💾 Starting database backup...")
    time.sleep(3)   # Simulate backup taking 3 seconds
    print("✅ Database backup complete!")

print("⏰ Starting backup job...")
backup_databases()
```

#### Using `schedule` library for periodic tasks
```bash
pip3 install schedule
```

```python
import schedule
import time

def health_check():
    print("🔍 Running server health check...")
    # Add real health check logic here

def cleanup_logs():
    print("🗑️  Cleaning up old log files...")

# Schedule jobs
schedule.every(10).seconds.do(health_check)   # Every 10 seconds
schedule.every(1).hours.do(cleanup_logs)       # Every hour
schedule.every().day.at("02:00").do(backup_databases)  # Daily at 2 AM

print("⏰ Scheduler started. Press Ctrl+C to stop.")
while True:
    schedule.run_pending()
    time.sleep(1)
```

---

## 🎯 Production Best Practices Summary

### ✅ Code Quality
```python
# 1. Use f-strings (not .format() or %)
name = "web01"
print(f"Server: {name}")   # ✅

# 2. Use context managers for files/connections
with open("file.txt", "r") as f:   # ✅ Auto-closes
    data = f.read()

# 3. Use os.getenv() for configs
host = os.getenv("DB_HOST", "localhost")   # ✅

# 4. Always validate function inputs
def deploy(version):
    if not version:
        raise ValueError("Version cannot be empty")
    # proceed...

# 5. Use logging, not print()
import logging
logging.basicConfig(level=logging.INFO)
logging.info("Deployment started")      # ✅
logging.error("Connection failed")     # ✅
```

### ✅ Error Handling
```python
# Always catch specific exceptions
try:
    result = int(user_input)
except ValueError:        # ✅ Specific
    print("Invalid input")

# NOT this:
try:
    result = int(user_input)
except Exception:         # ⚠️ Too broad — catches everything including bugs!
    pass
```

### ✅ Security
```python
# Never do this:
password = "mypassword123"           # ❌ Hardcoded secret!

# Always do this:
password = os.getenv("DB_PASSWORD")  # ✅ From environment variable
```

---

## 🎯 Interview-Focused Quick Reference

| Question | Answer |
|---|---|
| List vs Tuple | List is mutable (changeable), Tuple is immutable |
| List vs Set | List is ordered, Set is unordered and unique |
| `*args` vs `**kwargs` | `*args` = multiple positional args; `**kwargs` = multiple keyword args |
| What is GIL? | Global Interpreter Lock — Python threads can't run truly in parallel; use multiprocessing for CPU tasks |
| What is a decorator? | A function that adds functionality to another function without modifying it |
| `yield` vs `return` | `return` exits function; `yield` pauses and produces a value — used in generators |
| What is `__init__`? | Constructor — automatically called when an object is created |
| `finally` vs `else` in try/except | `finally` always runs; `else` runs only if no exception occurred |
| What is encapsulation? | Hiding internal data using private variables (`__var`) — protects data integrity |
| Why use `with` for files? | Automatically closes file even if error occurs — prevents resource leaks |

---

## 🚀 Complete DevOps Automation Script (Putting It All Together)

```python
#!/usr/bin/env python3
"""
DevOps Server Health Monitor
Checks CPU, memory, disk, and reports status
"""

import os
import sys
import json
import logging
import argparse
from datetime import datetime

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.FileHandler("monitor.log"),
        logging.StreamHandler(sys.stdout)
    ]
)
log = logging.getLogger(__name__)

def get_thresholds():
    """Load thresholds from environment or use defaults"""
    return {
        "cpu":    int(os.getenv("CPU_THRESHOLD",    "80")),
        "memory": int(os.getenv("MEMORY_THRESHOLD", "85")),
        "disk":   int(os.getenv("DISK_THRESHOLD",   "90"))
    }

def check_server(server_name, cpu, memory, disk):
    """Check server metrics against thresholds"""
    thresholds = get_thresholds()
    alerts = []
    
    if cpu > thresholds["cpu"]:
        alerts.append(f"CPU {cpu}% > {thresholds['cpu']}%")
    if memory > thresholds["memory"]:
        alerts.append(f"Memory {memory}% > {thresholds['memory']}%")
    if disk > thresholds["disk"]:
        alerts.append(f"Disk {disk}% > {thresholds['disk']}%")
    
    status = "CRITICAL" if alerts else "HEALTHY"
    return {"server": server_name, "status": status, "alerts": alerts}

def generate_report(results, output_file=None):
    """Generate JSON report"""
    report = {
        "timestamp":    datetime.now().isoformat(),
        "total_servers": len(results),
        "healthy":       sum(1 for r in results if r["status"] == "HEALTHY"),
        "critical":      sum(1 for r in results if r["status"] == "CRITICAL"),
        "results":       results
    }
    
    if output_file:
        with open(output_file, "w") as f:
            json.dump(report, f, indent=4)
        log.info(f"Report saved to: {output_file}")
    
    return report

def main():
    parser = argparse.ArgumentParser(description="Server Health Monitor")
    parser.add_argument("--output", help="Output JSON report file")
    args = parser.parse_args()
    
    # Simulated server metrics (in real use, fetch via psutil or API)
    servers = [
        {"name": "web01",   "cpu": 45, "memory": 60,  "disk": 70},
        {"name": "db01",    "cpu": 85, "memory": 90,  "disk": 65},
        {"name": "cache01", "cpu": 30, "memory": 45,  "disk": 92},
    ]
    
    log.info("🔍 Starting health checks...")
    results = []
    
    for s in servers:
        result = check_server(s["name"], s["cpu"], s["memory"], s["disk"])
        results.append(result)
        
        if result["status"] == "CRITICAL":
            log.warning(f"🚨 {s['name']}: {', '.join(result['alerts'])}")
        else:
            log.info(f"✅ {s['name']}: All metrics normal")
    
    report = generate_report(results, args.output)
    
    print(f"\n📊 Summary: {report['healthy']} healthy, {report['critical']} critical")
    
    # Exit with error code if any critical servers
    sys.exit(1 if report["critical"] > 0 else 0)

if __name__ == "__main__":
    main()
```

```bash
# Run it
python3 monitor.py
python3 monitor.py --output health_report.json

# Check exit code (useful in CI/CD pipelines)
echo "Exit code: $?"
```

---

> 📘 **Final Advice:** Python is a skill that grows with **practice**. For every concept here, write the code yourself, modify it, break it, and fix it. DevOps automation becomes second nature once you've written enough scripts. Focus on `os`, `subprocess`, `json`, `requests`, and `boto3` — these five are what you'll use 80% of the time in real DevOps work.
