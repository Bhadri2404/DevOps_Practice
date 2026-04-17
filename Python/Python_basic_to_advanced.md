# 🐍 Python for DevOps — Complete Notes
### From Basics to Advanced | Real-World AWS & Linux Automation

---

## 📋 Table of Contents

1. [Python Basics](#1-python-basics)
2. [Control Flow](#2-control-flow)
3. [Data Structures](#3-data-structures)
4. [Functions](#4-functions)
5. [Modules & Packages](#5-modules--packages)
6. [File Handling](#6-file-handling)
7. [Exception Handling](#7-exception-handling)
8. [OOP Concepts](#8-oop-concepts)
9. [Advanced Topics](#9-advanced-topics)
10. [Real-World Production Programs](#10-real-world-production-programs)

---

## 1. Python Basics

### 🔹 What is Python?

Python is a **high-level, interpreted, object-oriented programming language** widely used in DevOps for:
- **Automation** — eliminating repetitive manual tasks
- **Scripting** — writing tools for deployments, monitoring, etc.
- **CI/CD pipelines** — Jenkins, GitHub Actions, GitLab CI helpers
- **Cloud operations** — AWS, Azure, GCP automation via SDKs
- **Infrastructure management** — Terraform helpers, Ansible dynamic inventory

> **Why Python in DevOps?** Because it has an English-like syntax (easy to read), a massive library ecosystem (`boto3`, `paramiko`, `requests`, `psutil`), and runs on every OS without recompilation.

---

### 🔹 Python Setup

**Linux (Ubuntu/Debian):**
```bash
sudo apt install python3
python3 --version          # Verify: Python 3.12.3
```

**Windows:** Download from [python.org](https://python.org)

**Run a Python script:**
```bash
python3 script.py
```

---

### 🔹 Python Syntax & Indentation

> ⚠️ **Most Important Rule:** Python uses **indentation** (spaces/tabs) to define code blocks instead of `{}` curly braces.

```python
# CORRECT ✅
if True:
    print("Hello Python")   # 4 spaces indent

# WRONG ❌
if True:
print("Hello Python")       # IndentationError
```

**💡 Production Best Practice:** Always use **4 spaces** (not tabs) for indentation. Configure your editor (VS Code, PyCharm) to auto-convert tabs to 4 spaces.

---

### 🔹 Variables & Data Types

**Variables** are containers that store data in memory.

```python
# DevOps-relevant variable examples
server_name   = "web-prod-01"        # str  — text/string
port          = 8080                  # int  — integer
cpu_threshold = 85.5                  # float — decimal
is_running    = True                  # bool — True/False
```

**Python Data Types — Quick Reference:**

| Type         | Syntax Example              | Ordered | Mutable  | Unique Values |
|--------------|-----------------------------|---------|----------|---------------|
| `int`        | `port = 22`                 | N/A     | N/A      | N/A           |
| `float`      | `cpu = 85.5`                | N/A     | N/A      | N/A           |
| `str`        | `host = "10.0.0.1"`         | N/A     | N/A      | N/A           |
| `bool`       | `active = True`             | N/A     | N/A      | N/A           |
| `list`       | `[item1, item2]`            | ✅ Yes  | ✅ Yes   | ❌ No         |
| `tuple`      | `(item1, item2)`            | ✅ Yes  | ❌ No    | ❌ No         |
| `set`        | `{item1, item2}`            | ❌ No   | ✅ Yes   | ✅ Yes        |
| `dict`       | `{"key": "value"}`          | ✅ Yes  | ✅ Yes   | Keys unique   |

> **Interview Tip 🎯:** The most common question — *"Difference between list, tuple, set?"*
> - **List** → Ordered + Mutable → use for changeable sequences (`servers = ["web01", "db01"]`)
> - **Tuple** → Ordered + Immutable → use for fixed data (`credentials = ("admin", "pass123")`)
> - **Set** → Unordered + Unique → use for deduplication (`unique_ips = {"10.0.0.1", "10.0.0.2"}`)

---

### 🔹 Input & Output

```python
# Taking input from the user
server_name = input("Enter the server name: ")
print(f"Connecting to {server_name}, please wait...")
```

**String Formatting (f-strings) — Always use this in Python 3.6+:**
```python
tool    = "Ansible"
version = "2.15"
region  = "us-east-1"

# ❌ Wrong — variable not expanded
print("Tool is tool in version")

# ✅ Correct — f-string formatting
print(f"Tool is {tool} version {version} deployed in {region}")
# Output: Tool is Ansible version 2.15 deployed in us-east-1
```

> **Common Mistake 🔴:** Forgetting the `f` prefix before the string — the variable name prints literally instead of its value.

---

### 🔹 Type Conversion (Type Casting)

Two types:

**1. Implicit** — Python converts automatically to avoid data loss:
```python
a = 10        # int
b = 5.5       # float
c = a + b     # Python auto-converts int → float
print(c)      # 15.5
print(type(c)) # <class 'float'>
```

**2. Explicit** — You manually convert using built-in functions:
```python
# String → Integer (common in DevOps when reading config files)
port_str = "8080"
port_int = int(port_str)
print(type(port_int))   # <class 'int'>

# Integer → String (common when building log messages)
status_code = 200
message = "Response code: " + str(status_code)
print(message)          # Response code: 200

# List → Set (deduplication of IPs)
ip_list = ["10.0.0.1", "10.0.0.2", "10.0.0.1"]
unique_ips = set(ip_list)
print(unique_ips)       # {'10.0.0.1', '10.0.0.2'}
```

---

### 🔹 Operators

```python
a, b = 10, 3

# Arithmetic
print(a + b)   # 13 — addition
print(a - b)   # 7  — subtraction
print(a * b)   # 30 — multiplication
print(a / b)   # 3.333... — division (always float)
print(a // b)  # 3  — floor division (integer result)
print(a % b)   # 1  — modulus (remainder) — useful for batch processing
print(a ** b)  # 1000 — exponentiation

# Comparison
print(a > b)   # True
print(a == b)  # False
print(a != b)  # True

# Logical — critical for condition checks in DevOps scripts
x, y = True, False
print(x and y)   # False — both must be True
print(x or y)    # True  — at least one must be True
print(not x)     # False — negates the value
```

**DevOps Use Case — Logical Operators:**
```python
cpu_usage    = 90
memory_usage = 85

# Alert only when BOTH exceed thresholds
if cpu_usage > 80 and memory_usage > 80:
    print("🚨 CRITICAL: High CPU and Memory — Scale up immediately!")

# Alert when EITHER exceeds threshold
if cpu_usage > 80 or memory_usage > 80:
    print("⚠️  WARNING: Resource usage is high — investigate!")
```

---

### 🔹 String Operations

```python
log_message = "ERROR: Connection to DB01 failed at 14:30 UTC"

print(log_message.upper())           # Convert to uppercase
print(log_message.lower())           # Convert to lowercase
print(log_message.split(":"))        # Split into list by delimiter
print(log_message.replace("ERROR", "CRITICAL"))  # Replace text
print(log_message.strip())           # Remove leading/trailing whitespace
print("ERROR" in log_message)        # True — check if substring exists
print(log_message.startswith("ERROR")) # True
print(len(log_message))              # String length
```

**DevOps Use Case — Parse a log line:**
```python
log = "2024-01-15 14:30:00 ERROR nginx[1234]: Connection refused"

parts     = log.split(" ")
date      = parts[0]
time      = parts[1]
log_level = parts[2]

print(f"Date: {date}, Time: {time}, Level: {log_level}")
# Date: 2024-01-15, Time: 14:30:00, Level: ERROR
```

---

### 🔹 Comments

```python
# This is a single-line comment — interpreter ignores this line

"""
This is a multi-line comment (docstring).
Use this to describe functions, classes, or modules.
Best practice: always document your DevOps automation scripts.
"""

def deploy_app(env):
    """
    Deploy application to the specified environment.
    Args:
        env (str): Target environment — 'dev', 'staging', or 'prod'
    """
    print(f"Deploying to {env}...")
```

---

## 2. Control Flow

### 🔹 Conditional Statements (if / elif / else)

Control flow allows programs to **make decisions** based on conditions.

```python
# Basic if-elif-else
server_status = "running"

if server_status == "running":
    print("✅ Server is healthy")
elif server_status == "stopped":
    print("🔴 Server is down — restarting service...")
elif server_status == "terminated":
    print("💀 Server terminated — launch replacement")
else:
    print("❓ Unknown status — manual investigation needed")
```

**Nested Conditions — DevOps Alert Script:**
```python
cpu_usage    = 88
memory_usage = 92

if cpu_usage > 75:
    if memory_usage > 80:
        print("🚨 CRITICAL: High CPU + Memory — Scale up servers NOW!")
    else:
        print("⚠️  CPU is high — monitor closely")
else:
    print("✅ All systems normal")
```

**Shorthand (Ternary/Inline) if-else:**
```python
# One-liner condition — great for quick status checks
status = "up"
message = "Server is UP ✅" if status == "up" else "Server is DOWN 🔴"
print(message)
```

---

### 🔹 Loops

**For Loop — Iterate over sequences:**
```python
servers = ["web-01", "web-02", "db-01", "cache-01"]

# Iterate over list
for server in servers:
    print(f"🔄 Checking health of {server}...")

# Iterate with range
for batch in range(1, 4):    # 1, 2, 3
    print(f"📦 Deploying services — batch {batch}")

# Loop over dictionary items (very common in DevOps config parsing)
server_info = {"web-01": "running", "db-01": "stopped", "cache-01": "running"}

for name, status in server_info.items():
    if status == "running":
        print(f"✅ {name} is healthy")
    else:
        print(f"🔴 {name} is down — restarting service...")
```

**While Loop — Run until condition is met:**
```python
# Deployment retry counter
retry_count = 0
max_retries = 3

while retry_count < max_retries:
    print(f"🔄 Deployment attempt {retry_count + 1}/{max_retries}")
    retry_count += 1
    # In real scripts, add actual deploy logic + break on success

print("❌ Max retries reached — deployment failed")
```

> ⚠️ **Common Mistake:** Forgetting to increment the counter in a while loop → causes an **infinite loop** that crashes the script.

---

### 🔹 Loop Control Statements

```python
# BREAK — exit the loop immediately
servers = ["web-01", "db-01", "FAILED", "cache-01"]

for server in servers:
    if server == "FAILED":
        print(f"🛑 Critical failure detected — stopping scan")
        break
    print(f"✅ {server} — OK")

# CONTINUE — skip current iteration, continue loop
log_entries = ["INFO: startup", "ERROR: disk full", "INFO: running", "ERROR: OOM"]

for entry in log_entries:
    if entry.startswith("INFO"):
        continue    # Skip INFO logs, only process ERRORs
    print(f"🚨 Alert: {entry}")

# PASS — placeholder (does nothing, prevents syntax error)
for server in servers:
    if server == "FAILED":
        pass        # TODO: Add alerting logic here
    else:
        print(f"✅ {server}")
```

---

## 3. Data Structures

### 🔹 List — Ordered & Mutable

```python
# DevOps use case: managing a list of servers
servers = ["web-01", "jenkins", "ansible", "kubernetes"]

# Access by index (zero-based)
print(servers[0])    # web-01 (first)
print(servers[-1])   # kubernetes (last)

# Add a server
servers.append("terraform")
print(servers)

# Remove a server
servers.remove("jenkins")
print(servers)

# Modify (update) a server name — possible because lists are MUTABLE
servers[1] = "gitlab"
print(servers)

# Loop through all servers
for s in servers:
    print(f"🔄 Checking logs for {s} container...")
```

**List Comprehension — Pythonic & fast:**
```python
# Get only running servers from a list of dicts
all_servers = [
    {"name": "web-01", "status": "running"},
    {"name": "db-01",  "status": "stopped"},
    {"name": "web-02", "status": "running"}
]

running = [s["name"] for s in all_servers if s["status"] == "running"]
print(running)    # ['web-01', 'web-02']
```

---

### 🔹 Tuple — Ordered & Immutable

```python
# Use tuples for FIXED data that should never change
db_credentials = ("admin", "S3cur3P@ss!", "5432")

print(db_credentials[0])    # admin
print(db_credentials[1])    # S3cur3P@ss!

# Trying to modify → TypeError
# db_credentials[0] = "root"   # ❌ TypeError: 'tuple' object does not support item assignment
```

> **DevOps Use Case 🎯:** Tuples are perfect for storing **credentials, connection strings, config constants** that must not be accidentally modified.

---

### 🔹 Set — Unordered & Unique

```python
# Remove duplicate IPs from logs
raw_ips = {"10.0.0.1", "10.0.0.2", "10.0.0.1", "10.0.0.3", "10.0.0.2"}
unique_ips = set(raw_ips)
print(unique_ips)    # {'10.0.0.1', '10.0.0.2', '10.0.0.3'} — duplicates removed

# Set operations — very useful for comparing server lists
prod_servers    = {"web-01", "web-02", "db-01", "cache-01"}
running_servers = {"web-01", "db-01"}

# Union — all servers
print(prod_servers | running_servers)

# Intersection — servers that exist in both sets
print(prod_servers & running_servers)   # {'web-01', 'db-01'}

# Difference — servers in prod but NOT running (DOWN servers!)
down_servers = prod_servers - running_servers
print(f"🔴 Down servers: {down_servers}")  # {'web-02', 'cache-01'}
```

---

### 🔹 Dictionary — Key-Value Pairs

```python
# Server inventory as dictionary
server = {
    "name":    "web-prod-01",
    "ip":      "10.0.1.50",
    "status":  "running",
    "region":  "us-east-1"
}

# Access by key
print(server["name"])             # web-prod-01
print(server.get("region", "N/A")) # us-east-1 (safe get with default)

# Add new key
server["os"] = "Ubuntu 22.04"

# Update existing key
server["status"] = "stopped"

# Delete a key
del server["ip"]

# Loop through all key-value pairs
for key, value in server.items():
    print(f"  {key}: {value}")
```

**Nested Data Structures — Real DevOps Use:**
```python
# List of dictionaries (most common in DevOps for server inventories)
servers = [
    {"name": "web-01", "status": "running", "region": "us-east-1"},
    {"name": "db-01",  "status": "stopped", "region": "us-west-2"},
    {"name": "web-02", "status": "running", "region": "us-east-1"}
]

# Get only running servers
for s in servers:
    if s["status"] == "running":
        print(f"✅ {s['name']} — HEALTHY in {s['region']}")

# Dictionary of lists (environments → server lists)
deployment = {
    "production": ["web-01", "web-02"],
    "staging":    ["stg-01"],
    "dev":        ["dev-01", "dev-02", "dev-03"]
}

for env, server_list in deployment.items():
    print(f"Environment: {env} — Servers: {', '.join(server_list)}")
```

---

## 4. Functions

### 🔹 Defining & Calling Functions

```python
# Basic function — no parameters
def show_banner():
    """Print a DevOps script banner."""
    print("=" * 50)
    print("  🚀 DevOps Automation Script v1.0")
    print("=" * 50)

show_banner()   # Call the function

# Function with parameters and return value
def check_server_health(server_name, status):
    """Check if a server is healthy."""
    if status == "running":
        return f"✅ {server_name} is HEALTHY"
    else:
        return f"🔴 {server_name} is DOWN — restart required"

result = check_server_health("web-prod-01", "running")
print(result)
```

---

### 🔹 Types of Function Arguments

**1. Positional Arguments — order matters:**
```python
def deploy(environment, version):
    print(f"🚀 Deploying version {version} to {environment}")

deploy("production", "2.4.1")    # ✅ Correct order
# deploy("2.4.1", "production")  # ❌ Wrong order — logic error
```

**2. Keyword Arguments — order doesn't matter:**
```python
deploy(version="2.4.1", environment="staging")  # ✅ Order doesn't matter
```

**3. Default Arguments — fallback values:**
```python
def start_ec2(instance_type="t3.micro", region="us-east-1"):
    print(f"🖥️  Starting {instance_type} in {region}")

start_ec2()                              # t3.micro in us-east-1 (defaults)
start_ec2("t3.large", "ap-south-1")     # Override defaults
start_ec2(instance_type="m5.xlarge")    # Override only instance type
```

**4. Variable-Length Arguments — `*args` and `**kwargs`:**
```python
# *args — multiple positional arguments (tuple internally)
def install_tools(*tools):
    for tool in tools:
        print(f"📦 Installing {tool}...")

install_tools("docker", "kubectl", "terraform", "ansible", "helm")

# **kwargs — multiple keyword arguments (dict internally)
def configure_server(**settings):
    for key, value in settings.items():
        print(f"  ⚙️  {key}: {value}")

configure_server(hostname="web-prod-01", ip="10.0.1.50", os="Ubuntu 22.04", cpu=8)
```

> **Interview Tip 🎯:** `*args` collects extra positional arguments into a **tuple**. `**kwargs` collects extra keyword arguments into a **dictionary**. Both names are conventions — `*tools` or `**settings` work just as well.

---

### 🔹 Lambda Functions

Anonymous one-liner functions — great for quick transformations:

```python
# Standard function vs Lambda
def square(x):
    return x * x

square_lambda = lambda x: x * x  # Same thing, one line

print(square(5))         # 25
print(square_lambda(5))  # 25

# DevOps use case — filter only running servers
servers = [
    {"name": "web-01", "status": "running"},
    {"name": "db-01",  "status": "stopped"},
    {"name": "web-02", "status": "running"}
]

running = list(filter(lambda s: s["status"] == "running", servers))
print([s["name"] for s in running])   # ['web-01', 'web-02']

# Sort servers by name
sorted_servers = sorted(servers, key=lambda s: s["name"])
```

---

### 🔹 Variable Scope — Local vs Global

```python
deployment_count = 0    # GLOBAL variable — accessible anywhere

def run_deployment():
    global deployment_count     # Declare intent to modify global variable
    local_status = "success"    # LOCAL variable — only inside this function
    deployment_count += 1
    print(f"  Deployment #{deployment_count}: {local_status}")

run_deployment()   # Deployment #1: success
run_deployment()   # Deployment #2: success

print(f"Total deployments: {deployment_count}")  # 2
# print(local_status)  # ❌ NameError — local_status doesn't exist here
```

---

## 5. Modules & Packages

### 🔹 What is a Module?

A **module** is simply a `.py` file containing functions, variables, and classes that can be imported and reused.

**Create a custom module (`devops_utils.py`):**
```python
# devops_utils.py

def start_server(server_name):
    """Start a server."""
    print(f"🟢 Starting server: {server_name}")

def stop_server(server_name):
    """Stop a server."""
    print(f"🔴 Stopping server: {server_name}")

def get_status(server_name):
    """Get server status."""
    print(f"🔍 Checking status of: {server_name}")
    return "running"
```

**Import and use the module (`main.py`):**
```python
# main.py
import devops_utils

devops_utils.start_server("web-prod-01")
devops_utils.stop_server("db-stg-01")
status = devops_utils.get_status("cache-01")
print(f"Status: {status}")
```

**Run from terminal:**
```bash
python3 main.py
```

---

### 🔹 Built-in Python Modules for DevOps

#### OS Module — Interact with the Operating System

```python
import os

# Get current working directory
print(os.getcwd())           # /home/user/scripts

# Change directory
os.chdir("/tmp")

# Create a directory
os.makedirs("/tmp/logs/archive", exist_ok=True)   # exist_ok prevents error if exists

# List files in a directory
files = os.listdir("/var/log")
print(files)

# Check if file exists
if os.path.exists("/etc/nginx/nginx.conf"):
    print("✅ Nginx config found")

# Rename a file
os.rename("old_log.txt", "archived_log.txt")

# Delete a file
os.remove("/tmp/temp_file.txt")

# Get environment variable
db_password = os.environ.get("DB_PASSWORD", "default_pass")
print(f"DB Password: {db_password}")

# Run OS command (basic — prefer subprocess for full control)
os.system("systemctl status nginx")
```

#### SYS Module — System-Specific Parameters

```python
import sys

print(sys.version)         # Python version
print(sys.platform)        # 'linux', 'darwin', 'win32'
print(sys.path)            # List of directories Python searches for modules

# Command-line arguments
# Run: python3 script.py web-prod-01 us-east-1
script_name = sys.argv[0]   # script.py
server      = sys.argv[1]   # web-prod-01
region      = sys.argv[2]   # us-east-1

print(f"Managing {server} in {region}")

# Exit script with a status code
if not os.path.exists("/etc/app/config.yml"):
    print("❌ Config file missing — aborting!")
    sys.exit(1)   # Exit with error code 1
```

#### Subprocess Module — Run Shell Commands from Python

```python
import subprocess

# Run a command and capture output
result = subprocess.run(
    ["df", "-h"],           # Command as list (preferred — no shell injection)
    capture_output=True,    # Capture stdout and stderr
    text=True               # Decode bytes to string
)
print(result.stdout)

# Check if nginx is running
result = subprocess.run(["systemctl", "is-active", "nginx"], capture_output=True, text=True)
if result.stdout.strip() == "active":
    print("✅ Nginx is running")
else:
    print("🔴 Nginx is down — restarting...")
    subprocess.run(["sudo", "systemctl", "restart", "nginx"])

# Run shell command (use shell=True carefully — risk of shell injection!)
output = subprocess.check_output("uptime", shell=True, text=True)
print(f"System uptime: {output.strip()}")

# Get command exit code
result = subprocess.run(["ping", "-c", "1", "8.8.8.8"])
if result.returncode == 0:
    print("✅ Internet is reachable")
else:
    print("❌ No internet connectivity")
```

> **Production Best Practice 🔐:** Never use `shell=True` with user input — it opens the door to **shell injection attacks**. Always pass commands as a list.

#### Shutil Module — High-Level File Operations

```python
import shutil

# Copy a file
shutil.copy("nginx.conf", "/etc/nginx/nginx.conf.backup")

# Move a file (also used for renaming)
shutil.move("old_deploy.log", "/var/log/archive/deploy_2024.log")

# Copy entire directory tree
shutil.copytree("/app/config", "/app/config_backup")

# Delete entire directory tree
shutil.rmtree("/tmp/old_artifacts")

# Archive a directory (zip)
shutil.make_archive("/tmp/backup_2024", "zip", "/var/log/app")
# Creates: /tmp/backup_2024.zip
```

#### JSON Module — Parse & Generate JSON

```python
import json

# Python dictionary → JSON string (serialization)
server_config = {
    "name":    "web-prod-01",
    "ip":      "10.0.1.50",
    "port":    8080,
    "active":  True
}
json_string = json.dumps(server_config, indent=4)
print(json_string)

# Write JSON to file
with open("server_config.json", "w") as f:
    json.dump(server_config, f, indent=4)

# Read JSON from file
with open("server_config.json", "r") as f:
    loaded_config = json.load(f)
print(loaded_config["name"])    # web-prod-01

# JSON string → Python dictionary (deserialization)
api_response = '{"status": "healthy", "uptime": "15 days", "version": "2.4.1"}'
data = json.loads(api_response)
print(f"App status: {data['status']}, version: {data['version']}")
```

#### YAML Module — Parse Kubernetes/Ansible Configs

```bash
pip install pyyaml
```

```python
import yaml

# Write YAML config (Kubernetes-style deployment)
deployment_config = {
    "app":         "web-frontend",
    "environment": "production",
    "replicas":    3,
    "image":       "nginx:1.25",
    "port":        80
}

with open("deployment.yaml", "w") as f:
    yaml.dump(deployment_config, f, default_flow_style=False)

# deployment.yaml output:
# app: web-frontend
# environment: production
# image: nginx:1.25
# port: 80
# replicas: 3

# Read YAML config
with open("deployment.yaml", "r") as f:
    config = yaml.safe_load(f)   # safe_load is safer than load()

print(f"Deploying {config['app']} with {config['replicas']} replicas")
```

> **Production Best Practice:** Always use `yaml.safe_load()` instead of `yaml.load()` — the latter can execute arbitrary code if the YAML file is malicious.

#### Datetime Module — Timestamps for Logs & Archives

```python
from datetime import datetime, timedelta

# Current datetime
now = datetime.now()
print(now)                                  # 2024-01-15 14:30:45.123456

# Format for log filenames (no spaces or colons)
timestamp = now.strftime("%Y%m%d_%H%M%S")
log_filename = f"deploy_{timestamp}.log"    # deploy_20240115_143045.log
print(log_filename)

# Human-readable format
readable = now.strftime("%d-%m-%Y %H:%M:%S")
print(readable)                             # 15-01-2024 14:30:45

# Calculate time differences
deploy_start = datetime(2024, 1, 15, 14, 0, 0)
deploy_end   = datetime.now()
duration     = deploy_end - deploy_start
print(f"Deployment took: {duration.seconds} seconds")

# Calculate future/past dates (useful for log retention)
retention_date = datetime.now() - timedelta(days=30)
print(f"Delete logs older than: {retention_date.strftime('%Y-%m-%d')}")
```

---

### 🔹 Third-Party Libraries for DevOps

Install via pip:
```bash
pip install boto3 paramiko requests psutil
```

| Library    | Purpose                              | Use Case                              |
|------------|--------------------------------------|---------------------------------------|
| `boto3`    | AWS SDK for Python                   | EC2, S3, Lambda, RDS automation       |
| `paramiko` | SSH client library                   | Remote server execution               |
| `requests` | HTTP client library                  | REST API calls (Jenkins, GitHub, etc.)|
| `psutil`   | System monitoring                    | CPU, memory, disk, process monitoring |

**Quick examples:**
```python
import requests

# Check GitHub API / Jenkins / any REST API
response = requests.get("https://api.github.com/repos/kubernetes/kubernetes")
if response.status_code == 200:
    data = response.json()
    print(f"Repo: {data['full_name']}, Stars: {data['stargazers_count']}")
else:
    print(f"❌ API Error: {response.status_code}")
```

---

### 🔹 Creating a Custom Package

**Package structure:**
```
devops_tools/           ← Package directory
├── __init__.py         ← Marks this as a package
├── aws_utils.py        ← AWS automation module
└── docker_utils.py     ← Docker automation module
```

```python
# devops_tools/__init__.py
# Marks this folder as a Python package

# devops_tools/aws_utils.py
def deploy_ec2(instance_name):
    print(f"🖥️  Deploying EC2 instance: {instance_name}")

# devops_tools/docker_utils.py
def start_container(container_name):
    print(f"🐳 Starting container: {container_name}")

# main.py
from devops_tools import aws_utils, docker_utils

aws_utils.deploy_ec2("web-prod-01")
docker_utils.start_container("nginx-frontend")
```

---

## 6. File Handling

### 🔹 File Modes

| Mode  | Description                                      |
|-------|--------------------------------------------------|
| `r`   | Read (default) — file must exist                 |
| `w`   | Write — creates new file or **overwrites** existing |
| `a`   | Append — adds to end of file, creates if missing |
| `x`   | Create — fails if file already exists            |
| `r+`  | Read + Write                                     |
| `rb`  | Read binary (images, PDFs)                       |

### 🔹 Reading & Writing Files

```python
# WRITE to a file
with open("servers.txt", "w") as f:
    f.write("web-01\n")
    f.write("db-01\n")
    f.write("cache-01\n")
# File is automatically closed after 'with' block

# READ entire file
with open("servers.txt", "r") as f:
    content = f.read()
    print(content)

# READ line by line (memory efficient for large files)
with open("servers.txt", "r") as f:
    for line in f:
        print(f"Processing: {line.strip()}")

# APPEND to existing file (adds to end without overwriting)
with open("servers.txt", "a") as f:
    f.write("new-server-01\n")
```

> **Production Best Practice:** **Always use `with open()`** — it guarantees the file is properly closed even if an error occurs. Never use `f = open()` + `f.close()` in production code.

### 🔹 Log Analysis — Common DevOps Task

```python
# Count errors in a log file
def analyze_logs(log_file_path):
    error_count   = 0
    warning_count = 0
    error_lines   = []

    with open(log_file_path, "r") as f:
        for line in f:
            if "ERROR" in line:
                error_count += 1
                error_lines.append(line.strip())
            elif "WARNING" in line:
                warning_count += 1

    print(f"📊 Log Analysis Results:")
    print(f"   Errors:   {error_count}")
    print(f"   Warnings: {warning_count}")

    if error_count > 0:
        print("\n🚨 Recent Errors:")
        for err in error_lines[-5:]:   # Show last 5 errors
            print(f"   {err}")

analyze_logs("/var/log/app/application.log")
```

### 🔹 Log Rotation

```python
import shutil
from datetime import datetime

def rotate_log(log_file):
    """Archive a log file with a timestamp suffix."""
    if not os.path.exists(log_file):
        print(f"❌ Log file not found: {log_file}")
        return

    timestamp   = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_name = f"{log_file}.{timestamp}.bak"

    shutil.move(log_file, backup_name)
    print(f"✅ Log rotated: {log_file} → {backup_name}")

rotate_log("/var/log/app/app.log")
```

---

## 7. Exception Handling

### 🔹 Why Exception Handling?

Without proper exception handling, **one error crashes the entire script** — critical in production automation where you need graceful degradation.

```python
# ❌ Without exception handling — script crashes completely
result = 10 / 0     # ZeroDivisionError: division by zero
print("This never executes")   # Unreachable code!

# ✅ With exception handling — script continues gracefully
try:
    result = 10 / 0
except ZeroDivisionError:
    print("⚠️  Cannot divide by zero — skipping calculation")
print("Script continues normally...")    # This DOES execute now
```

### 🔹 try / except / else / finally

```python
def read_server_config(config_path):
    try:
        with open(config_path, "r") as f:
            config = json.load(f)
        # This line only runs if no exception occurred above
    except FileNotFoundError:
        print(f"❌ Config file not found: {config_path}")
        return None
    except json.JSONDecodeError as e:
        print(f"❌ Invalid JSON in config: {e}")
        return None
    except PermissionError:
        print(f"❌ Permission denied reading: {config_path}")
        return None
    else:
        # Runs ONLY when no exception occurred
        print(f"✅ Config loaded successfully from {config_path}")
        return config
    finally:
        # ALWAYS runs — exception or not — perfect for cleanup
        print("🔒 File operation complete (finally block)")
```

> **Interview Tip 🎯:**
> - `else` → runs only when **no exception** occurred
> - `finally` → runs **always**, even after `return` statements — use for cleanup (closing connections, releasing locks)

### 🔹 Common Python Exceptions in DevOps

| Exception              | When it occurs                                        |
|------------------------|-------------------------------------------------------|
| `FileNotFoundError`    | File or directory doesn't exist                       |
| `ZeroDivisionError`    | Division by zero                                      |
| `ValueError`           | Wrong value type (e.g., `int("abc")`)                 |
| `KeyError`             | Dictionary key doesn't exist                          |
| `IndexError`           | List index out of range                               |
| `TypeError`            | Wrong data type for operation                         |
| `ImportError`          | Module not found                                      |
| `TimeoutError`         | Operation timed out (API calls, SSH connections)      |
| `PermissionError`      | Insufficient file/directory permissions               |
| `ConnectionError`      | Network connection failed                             |

### 🔹 Raising Custom Exceptions

```python
class DeploymentError(Exception):
    """Custom exception for deployment failures."""
    pass

class InvalidVersionError(Exception):
    """Raised when an invalid version number is provided."""
    pass

def deploy_application(version):
    if not version or float(version) < 1.0:
        raise InvalidVersionError(f"Invalid version: {version}. Must be >= 1.0")

    if version == "BROKEN":
        raise DeploymentError("Deployment package is corrupted!")

    print(f"✅ Deploying version {version}...")

# Usage
try:
    deploy_application("0.8")
except InvalidVersionError as e:
    print(f"❌ Version Error: {e}")
except DeploymentError as e:
    print(f"❌ Deploy Error: {e}")
```

### 🔹 Retry Logic — Critical in DevOps

```python
import time

def connect_to_server(server_ip, max_retries=3, delay=2):
    """Attempt to connect with exponential backoff."""
    for attempt in range(1, max_retries + 1):
        try:
            print(f"🔄 Attempt {attempt}/{max_retries}: Connecting to {server_ip}...")

            # Simulate connection (replace with actual SSH/API call)
            if attempt < max_retries:
                raise ConnectionError("Connection refused")

            print(f"✅ Connected to {server_ip} successfully!")
            return True

        except ConnectionError as e:
            print(f"   ❌ Attempt {attempt} failed: {e}")
            if attempt < max_retries:
                wait_time = delay * attempt  # Exponential backoff
                print(f"   ⏳ Retrying in {wait_time} seconds...")
                time.sleep(wait_time)
    
    print(f"💀 All {max_retries} attempts failed for {server_ip}")
    return False

connect_to_server("10.0.1.50")
```

### 🔹 Logging Exceptions to File

```python
import logging

# Configure logging
logging.basicConfig(
    filename="errors.log",                           # Log to file
    level=logging.ERROR,                             # Only log ERROR and above
    format="%(asctime)s - %(levelname)s - %(message)s",  # Log format
    datefmt="%Y-%m-%d %H:%M:%S"
)

def divide(a, b):
    try:
        return a / b
    except ZeroDivisionError as e:
        logging.error(f"Division by zero error: {e} — a={a}, b={b}")
        return None

# Using different log levels
logging.basicConfig(level=logging.DEBUG)
logging.debug("Starting deployment script")
logging.info("Connecting to server web-prod-01")
logging.warning("CPU usage at 78% — approaching threshold")
logging.error("Failed to connect to db-prod-01")
logging.critical("Production database is unreachable!")
```

> **Production Best Practice:** Never use `print()` for important messages in production scripts. Always use the `logging` module — it gives you timestamps, log levels, and file output.

---

## 8. OOP Concepts

### 🔹 What is OOP?

**Object-Oriented Programming** organizes code into **objects** that combine:
- **Data (attributes)** — properties like `name`, `ip`, `status`
- **Behavior (methods)** — actions like `start()`, `stop()`, `restart()`

The 4 pillars of OOP:
1. **Encapsulation** — hide internal details
2. **Inheritance** — reuse code from parent classes
3. **Polymorphism** — same method name, different behaviors
4. **Abstraction** — hide complexity from users

### 🔹 Class & Object

```python
class Server:
    """Blueprint for a server object."""

    def __init__(self, name, ip):
        """
        Constructor — automatically called when object is created.
        self refers to the current instance of the class.
        """
        self.name = name    # Instance attribute
        self.ip   = ip      # Instance attribute

    def start(self):
        print(f"🟢 Server {self.name} ({self.ip}) is starting...")

    def stop(self):
        print(f"🔴 Server {self.name} ({self.ip}) is stopping...")

    def get_info(self):
        return f"Server: {self.name} | IP: {self.ip}"

# Create objects (instances of the class)
web_server = Server("web-prod-01", "10.0.1.50")  # __init__ is auto-called
db_server  = Server("db-prod-01",  "10.0.2.30")

web_server.start()
db_server.stop()
print(db_server.get_info())
```

> **Interview Tip 🎯:** `__init__` is the **constructor** — it initializes object attributes automatically when the object is created using `ClassName()`.

### 🔹 Encapsulation — Hide Internal Details

```python
class JenkinsPipeline:
    """Encapsulates Jenkins pipeline logic."""

    def __init__(self, job_name):
        self.job_name = job_name        # Public attribute
        self.__secret_token = "abc123"  # Private (name mangled to _JenkinsPipeline__secret_token)
        self.__build_count  = 0         # Private counter

    def __build(self):
        """Private method — cannot be called from outside the class."""
        self.__build_count += 1
        print(f"  🔨 Building {self.job_name} (build #{self.__build_count})...")

    def __deploy(self):
        """Private method."""
        print(f"  🚀 Deploying {self.job_name}...")

    def trigger_pipeline(self):
        """Public method — the only external interface."""
        print(f"▶️  Pipeline triggered: {self.job_name}")
        self.__build()   # Call private method internally
        self.__deploy()  # Call private method internally
        print(f"✅ Pipeline complete!")

# Usage
pipeline = JenkinsPipeline("deploy-webapp")
pipeline.trigger_pipeline()   # ✅ Works

# pipeline.__build()          # ❌ AttributeError — private method
```

> **DevOps Use Case:** Encapsulation protects sensitive data like API keys, credentials, and internal build steps from being accidentally accessed or modified.

### 🔹 Inheritance — Reuse Code

```python
class Server:
    """Base/Parent class."""

    def __init__(self, name, ip):
        self.name = name
        self.ip   = ip

    def start(self):
        print(f"🟢 Starting {self.name} at {self.ip}")

    def stop(self):
        print(f"🔴 Stopping {self.name}")

class WebServer(Server):
    """Child class — inherits Server and adds web-specific methods."""

    def __init__(self, name, ip, domain):
        super().__init__(name, ip)   # Call parent constructor
        self.domain = domain

    def deploy_app(self, app_name):
        print(f"🌐 Deploying {app_name} to {self.domain}")

class DatabaseServer(Server):
    """Child class — inherits Server and adds DB-specific methods."""

    def __init__(self, name, ip, db_type):
        super().__init__(name, ip)
        self.db_type = db_type

    def run_backup(self):
        print(f"💾 Running {self.db_type} backup on {self.name}")

# Usage
web = WebServer("nginx-prod-01", "10.0.1.50", "app.example.com")
db  = DatabaseServer("postgres-prod-01", "10.0.2.30", "PostgreSQL")

web.start()          # Inherited from Server
web.deploy_app("e-commerce v2.1")

db.start()           # Inherited from Server
db.run_backup()
```

### 🔹 Polymorphism — Same Interface, Different Behavior

```python
class Server:
    def restart(self):
        print("Restarting generic server...")

class WebServer(Server):
    def restart(self):
        print("🌐 Gracefully restarting Nginx — draining connections first...")

class DatabaseServer(Server):
    def restart(self):
        print("💾 Restarting PostgreSQL — waiting for transactions to complete...")

class CacheServer(Server):
    def restart(self):
        print("⚡ Restarting Redis — flushing cache warm-up required...")

# Polymorphism in action — same method, different behaviors
servers = [WebServer(), DatabaseServer(), CacheServer()]

for server in servers:
    server.restart()   # Each calls its OWN restart() method

# Output:
# 🌐 Gracefully restarting Nginx — draining connections first...
# 💾 Restarting PostgreSQL — waiting for transactions to complete...
# ⚡ Restarting Redis — flushing cache warm-up required...
```

### 🔹 Abstraction — Hide Complexity

```python
from abc import ABC, abstractmethod

class CloudProvider(ABC):
    """Abstract base class — cannot be instantiated directly."""

    @abstractmethod
    def create_instance(self, instance_type):
        """Every cloud provider MUST implement this method."""
        pass

    @abstractmethod
    def delete_instance(self, instance_id):
        pass

class AWSProvider(CloudProvider):
    """Concrete implementation for AWS."""

    def create_instance(self, instance_type):
        print(f"☁️  AWS: Launching EC2 instance of type {instance_type}")
        return "i-0abc123def456"

    def delete_instance(self, instance_id):
        print(f"☁️  AWS: Terminating EC2 instance {instance_id}")

class AzureProvider(CloudProvider):
    """Concrete implementation for Azure."""

    def create_instance(self, instance_type):
        print(f"☁️  Azure: Creating VM of size {instance_type}")
        return "vm-azure-001"

    def delete_instance(self, instance_id):
        print(f"☁️  Azure: Deleting VM {instance_id}")

# ✅ Concrete classes work fine
aws   = AWSProvider()
azure = AzureProvider()
aws.create_instance("t3.large")
azure.create_instance("Standard_D2s_v3")

# ❌ Abstract class cannot be instantiated
# cloud = CloudProvider()  # TypeError: Can't instantiate abstract class
```

### 🔹 Magic (Dunder) Methods

```python
class Server:
    def __init__(self, name, services):
        self.name     = name
        self.services = services    # List of services

    def __str__(self):
        """Called when you print() the object."""
        return f"Server({self.name}) running {len(self.services)} services"

    def __len__(self):
        """Called when you use len() on the object."""
        return len(self.services)

    def __repr__(self):
        """Developer-friendly representation."""
        return f"Server(name='{self.name}', services={self.services})"

server = Server("web-prod-01", ["nginx", "nodejs", "redis"])

print(server)       # Server(web-prod-01) running 3 services
print(len(server))  # 3
print(repr(server)) # Server(name='web-prod-01', services=['nginx', 'nodejs', 'redis'])
```

---

## 9. Advanced Topics

### 🔹 Iterators

An **iterator** is an object that allows you to traverse through elements one at a time.

```python
# Convert a list to an iterator
servers    = ["web-01", "db-01", "cache-01"]
server_iter = iter(servers)

# Traverse one by one
print(next(server_iter))   # web-01
print(next(server_iter))   # db-01
print(next(server_iter))   # cache-01
# print(next(server_iter)) # ❌ StopIteration — exhausted

# More practical — use for loop (which uses iterator internally)
for server in servers:
    print(f"Processing: {server}")
```

### 🔹 Generators — Memory-Efficient Iteration

A **generator** uses `yield` instead of `return` — it produces values **one at a time**, saving memory when dealing with large datasets (like huge log files).

```python
# Regular function — loads ALL servers into memory at once
def get_all_servers():
    return ["server-{:03d}".format(i) for i in range(1, 1001)]  # 1000 servers in memory

# Generator — yields ONE server at a time (memory efficient!)
def get_servers_generator():
    for i in range(1, 1001):
        yield f"server-{i:03d}"   # yield pauses here, resumes on next()

# Usage — only ONE item is in memory at any time
for server in get_servers_generator():
    print(f"Provisioning {server}...")
    # In real scripts: call AWS API here

# DevOps use case — parse large log files line by line
def read_large_log(filepath):
    """Generator that reads log file line by line — handles 10GB files easily."""
    with open(filepath, "r") as f:
        for line in f:
            yield line.strip()

for log_line in read_large_log("/var/log/app/access.log"):
    if "ERROR" in log_line:
        print(f"🚨 {log_line}")
```

> **Interview Tip 🎯:** Generators are crucial in DevOps for processing large log files, streaming API responses, and batch processing without running out of memory.

### 🔹 Decorators — Add Functionality Without Modifying Code

A **decorator** wraps a function to add extra behavior (logging, timing, auth checks) without changing the original function.

```python
import time
import functools

# Logging decorator
def log_execution(func):
    @functools.wraps(func)   # Preserves original function name/docstring
    def wrapper(*args, **kwargs):
        print(f"▶️  Starting: {func.__name__}")
        start_time = time.time()

        result = func(*args, **kwargs)   # Execute original function

        duration = time.time() - start_time
        print(f"✅ Completed: {func.__name__} in {duration:.2f}s")
        return result
    return wrapper

# Retry decorator
def retry(max_attempts=3, delay=1):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            for attempt in range(1, max_attempts + 1):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    print(f"  Attempt {attempt} failed: {e}")
                    if attempt < max_attempts:
                        time.sleep(delay)
            raise Exception(f"Function failed after {max_attempts} attempts")
        return wrapper
    return decorator

# Apply decorators using @ syntax
@log_execution
@retry(max_attempts=3, delay=2)
def deploy_to_production(version):
    """Deploy app to production."""
    print(f"🚀 Deploying version {version} to production...")
    # Add actual deployment logic here

deploy_to_production("2.4.1")
```

### 🔹 Regular Expressions (re module)

```python
import re

# Search for patterns in text — critical for log parsing
log_text = """
2024-01-15 14:30:00 ERROR: Connection failed from 192.168.1.100
2024-01-15 14:30:05 INFO: Request from user admin@company.com
2024-01-15 14:30:10 ERROR: Disk usage at 95% on /dev/sda1
"""

# Find all IP addresses
ip_pattern  = r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"
ip_addresses = re.findall(ip_pattern, log_text)
print(f"IP addresses found: {ip_addresses}")   # ['192.168.1.100']

# Find all email addresses
email_pattern = r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b"
emails        = re.findall(email_pattern, log_text)
print(f"Emails found: {emails}")               # ['admin@company.com']

# Find all ERROR lines
error_lines = re.findall(r".+ERROR.+", log_text)
for line in error_lines:
    print(f"🚨 {line.strip()}")

# Extract timestamps
timestamps = re.findall(r"\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}", log_text)
print(f"Timestamps: {timestamps}")
```

### 🔹 Multi-threading — Concurrent I/O Operations

Use when tasks spend most time **waiting** (I/O-bound): API calls, SSH connections, file reads.

```python
import threading
import time

def health_check(server_name, delay=1):
    """Check health of a server (simulates network I/O)."""
    time.sleep(delay)   # Simulate network delay
    print(f"✅ {server_name} — healthy")

servers = ["web-01", "web-02", "db-01", "cache-01", "lb-01"]

# ❌ Sequential — takes 5+ seconds (each server waits for the previous)
start = time.time()
for s in servers:
    health_check(s)
print(f"Sequential: {time.time() - start:.1f}s")   # ~5 seconds

# ✅ Multi-threaded — all checks run simultaneously (~1 second!)
start   = time.time()
threads = []

for server in servers:
    t = threading.Thread(target=health_check, args=(server,))
    threads.append(t)
    t.start()

for t in threads:
    t.join()   # Wait for all threads to complete

print(f"Multi-threaded: {time.time() - start:.1f}s")   # ~1 second
print("🎉 All servers checked!")
```

### 🔹 Multi-processing — True Parallel CPU Execution

Use when tasks are **CPU-bound** (calculations, data processing) — bypasses Python's GIL.

```python
from multiprocessing import Process
import time

def process_logs(log_file, process_id):
    """CPU-intensive log processing."""
    print(f"🔄 Process {process_id}: Processing {log_file}")
    time.sleep(2)   # Simulate CPU work
    print(f"✅ Process {process_id}: Done processing {log_file}")

log_files = ["access.log", "error.log", "security.log", "audit.log"]

processes = []
for idx, log in enumerate(log_files):
    p = Process(target=process_logs, args=(log, idx + 1))
    processes.append(p)
    p.start()

for p in processes:
    p.join()   # Wait for all processes

print("🎉 All log files processed in parallel!")
```

> **Interview Tip 🎯:**
> - **Multi-threading** → I/O-bound tasks (network calls, file reads) — shared memory, GIL applies
> - **Multi-processing** → CPU-bound tasks (data processing, encryption) — separate memory, no GIL

### 🔹 argparse — Command-Line Arguments

```python
import argparse

def parse_args():
    parser = argparse.ArgumentParser(
        description="DevOps Deployment Script"
    )
    parser.add_argument("--env",     required=True, help="Target environment: dev/staging/prod")
    parser.add_argument("--version", required=True, help="Application version to deploy")
    parser.add_argument("--region",  default="us-east-1", help="AWS region (default: us-east-1)")
    parser.add_argument("--dry-run", action="store_true", help="Simulate without actual deployment")

    return parser.parse_args()

args = parse_args()

if args.dry_run:
    print(f"🔍 DRY RUN: Would deploy v{args.version} to {args.env} in {args.region}")
else:
    print(f"🚀 Deploying v{args.version} to {args.env} in {args.region}...")
```

**Usage:**
```bash
# Deploy to production
python3 deploy.py --env prod --version 2.4.1 --region us-west-2

# Dry run
python3 deploy.py --env staging --version 2.4.1 --dry-run

# Show help
python3 deploy.py --help
```

### 🔹 Environment Variables

**Never hardcode secrets in code!** Use environment variables:

```python
import os

# Read environment variables (with defaults)
db_host     = os.environ.get("DB_HOST",     "localhost")
db_port     = os.environ.get("DB_PORT",     "5432")
db_password = os.environ.get("DB_PASSWORD", "")    # No default for secrets!
aws_region  = os.environ.get("AWS_DEFAULT_REGION", "us-east-1")

if not db_password:
    raise ValueError("❌ DB_PASSWORD environment variable not set!")

print(f"Connecting to {db_host}:{db_port}")
```

**Set environment variables:**
```bash
# Linux/macOS
export DB_PASSWORD="supersecretpass"
export AWS_DEFAULT_REGION="us-east-1"
python3 script.py

# Use .env file with python-dotenv (install: pip install python-dotenv)
```

```python
from dotenv import load_dotenv
load_dotenv()   # Loads .env file into environment variables
```

### 🔹 Scheduling — Periodic Task Automation

```python
import schedule
import time

def health_check():
    print(f"🔍 [{datetime.now().strftime('%H:%M:%S')}] Checking server health...")

def backup_database():
    print(f"💾 [{datetime.now().strftime('%H:%M:%S')}] Running database backup...")

def send_daily_report():
    print(f"📊 [{datetime.now().strftime('%H:%M:%S')}] Sending daily report...")

# Schedule jobs
schedule.every(30).seconds.do(health_check)       # Every 30 seconds
schedule.every(1).hours.do(backup_database)        # Every hour
schedule.every().day.at("08:00").do(send_daily_report)  # Daily at 8 AM

print("🕐 Scheduler started — press Ctrl+C to stop")
while True:
    schedule.run_pending()
    time.sleep(1)
```

**Install schedule:**
```bash
pip install schedule
```

---

## 10. Real-World Production Programs

### 🏭 Program 1: AWS EC2 Health Monitor with Auto-Restart

```python
#!/usr/bin/env python3
"""
EC2 Health Monitor with Auto-Restart
Purpose: Monitor EC2 instances and automatically restart stopped ones
Usage:   python3 ec2_health_monitor.py --region us-east-1
"""

import boto3
import argparse
import logging
import time
from datetime import datetime

# Configure structured logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler(f"ec2_monitor_{datetime.now().strftime('%Y%m%d')}.log")
    ]
)
log = logging.getLogger(__name__)


class EC2HealthMonitor:
    """Monitors EC2 instances and handles auto-recovery."""

    def __init__(self, region: str):
        self.region = region
        self.ec2     = boto3.client("ec2", region_name=region)
        log.info(f"EC2 Health Monitor initialized | Region: {region}")

    def get_all_instances(self) -> list:
        """Fetch all EC2 instances in the region."""
        try:
            response  = self.ec2.describe_instances()
            instances = []

            for reservation in response["Reservations"]:
                for inst in reservation["Instances"]:
                    name = next(
                        (tag["Value"] for tag in inst.get("Tags", []) if tag["Key"] == "Name"),
                        "Unnamed"
                    )
                    instances.append({
                        "id":     inst["InstanceId"],
                        "name":   name,
                        "state":  inst["State"]["Name"],
                        "type":   inst["InstanceType"],
                        "az":     inst["Placement"]["AvailabilityZone"]
                    })
            return instances

        except Exception as e:
            log.error(f"Failed to fetch instances: {e}")
            return []

    def restart_instance(self, instance_id: str, instance_name: str) -> bool:
        """Start a stopped EC2 instance."""
        try:
            log.warning(f"⚠️  Instance stopped — attempting restart: {instance_name} ({instance_id})")
            self.ec2.start_instances(InstanceIds=[instance_id])

            # Wait for instance to be running
            waiter = self.ec2.get_waiter("instance_running")
            waiter.wait(InstanceIds=[instance_id])

            log.info(f"✅ Instance restarted successfully: {instance_name} ({instance_id})")
            return True

        except Exception as e:
            log.error(f"❌ Failed to restart {instance_name}: {e}")
            return False

    def run_health_check(self):
        """Run one health check cycle."""
        log.info("=" * 60)
        log.info("🔍 Starting EC2 Health Check")

        instances   = self.get_all_instances()
        healthy     = 0
        unhealthy   = 0
        restarted   = 0

        for inst in instances:
            state = inst["state"]

            if state == "running":
                healthy += 1
                log.info(f"  ✅ {inst['name']:<25} {inst['id']}  RUNNING")
            elif state == "stopped":
                unhealthy += 1
                log.warning(f"  🔴 {inst['name']:<25} {inst['id']}  STOPPED")
                if self.restart_instance(inst["id"], inst["name"]):
                    restarted += 1
            else:
                log.info(f"  ⚠️  {inst['name']:<25} {inst['id']}  {state.upper()}")

        log.info("-" * 60)
        log.info(f"📊 Summary | Total: {len(instances)} | Healthy: {healthy} | "
                 f"Stopped: {unhealthy} | Restarted: {restarted}")
        log.info("=" * 60)


def main():
    parser = argparse.ArgumentParser(description="EC2 Health Monitor with Auto-Restart")
    parser.add_argument("--region",   default="us-east-1",  help="AWS region")
    parser.add_argument("--interval", type=int, default=300, help="Check interval in seconds (default: 300)")
    parser.add_argument("--once",     action="store_true",   help="Run once and exit")
    args = parser.parse_args()

    monitor = EC2HealthMonitor(region=args.region)

    if args.once:
        monitor.run_health_check()
    else:
        log.info(f"🕐 Monitoring every {args.interval}s — press Ctrl+C to stop")
        while True:
            try:
                monitor.run_health_check()
                time.sleep(args.interval)
            except KeyboardInterrupt:
                log.info("👋 Monitoring stopped by user")
                break


if __name__ == "__main__":
    main()
```

**Run:**
```bash
pip install boto3

# Run once
python3 ec2_health_monitor.py --region us-east-1 --once

# Run continuously every 5 minutes
python3 ec2_health_monitor.py --region us-east-1 --interval 300
```

---

### 🏭 Program 2: Automated Log Cleanup & Archival Script

```python
#!/usr/bin/env python3
"""
Log Cleanup & Archival Script
Purpose: Archive logs older than N days, delete archives older than M days
Usage:   python3 log_cleanup.py --log-dir /var/log/app --keep-days 7 --archive-days 30
"""

import os
import shutil
import argparse
import logging
from datetime import datetime, timedelta
from pathlib import Path

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler("/var/log/log_cleanup.log")
    ]
)
log = logging.getLogger(__name__)


class LogCleaner:
    """Handles log rotation, archival, and cleanup."""

    def __init__(self, log_dir: str, archive_dir: str, keep_days: int, archive_days: int):
        self.log_dir      = Path(log_dir)
        self.archive_dir  = Path(archive_dir)
        self.keep_days    = keep_days
        self.archive_days = archive_days

        # Create archive directory if it doesn't exist
        self.archive_dir.mkdir(parents=True, exist_ok=True)

    def get_file_age_days(self, filepath: Path) -> float:
        """Return file age in days."""
        mtime = datetime.fromtimestamp(filepath.stat().st_mtime)
        return (datetime.now() - mtime).days

    def archive_old_logs(self) -> dict:
        """Archive log files older than keep_days."""
        stats = {"archived": 0, "size_freed_mb": 0}

        for log_file in self.log_dir.glob("*.log"):
            age_days = self.get_file_age_days(log_file)

            if age_days >= self.keep_days:
                timestamp    = datetime.now().strftime("%Y%m%d_%H%M%S")
                archive_name = self.archive_dir / f"{log_file.stem}_{timestamp}.log.gz"

                try:
                    # Compress and move to archive
                    file_size = log_file.stat().st_size / (1024 * 1024)  # MB

                    import gzip
                    with open(log_file, "rb") as f_in:
                        with gzip.open(archive_name, "wb") as f_out:
                            shutil.copyfileobj(f_in, f_out)

                    log_file.unlink()   # Delete original after compression

                    stats["archived"]       += 1
                    stats["size_freed_mb"]  += file_size
                    log.info(f"  📦 Archived: {log_file.name} → {archive_name.name} ({file_size:.1f} MB)")

                except Exception as e:
                    log.error(f"  ❌ Failed to archive {log_file.name}: {e}")

        return stats

    def cleanup_old_archives(self) -> dict:
        """Delete archives older than archive_days."""
        stats = {"deleted": 0, "size_freed_mb": 0}

        for archive in self.archive_dir.glob("*.log.gz"):
            age_days = self.get_file_age_days(archive)

            if age_days >= self.archive_days:
                try:
                    file_size = archive.stat().st_size / (1024 * 1024)
                    archive.unlink()

                    stats["deleted"]       += 1
                    stats["size_freed_mb"] += file_size
                    log.info(f"  🗑️  Deleted old archive: {archive.name} ({file_size:.1f} MB, {age_days}d old)")

                except Exception as e:
                    log.error(f"  ❌ Failed to delete {archive.name}: {e}")

        return stats

    def count_errors_in_logs(self) -> dict:
        """Analyze current logs for error counts."""
        error_summary = {}

        for log_file in self.log_dir.glob("*.log"):
            error_count   = 0
            warning_count = 0

            try:
                with open(log_file, "r", errors="ignore") as f:
                    for line in f:
                        if "ERROR"   in line: error_count   += 1
                        if "WARNING" in line: warning_count += 1

                error_summary[log_file.name] = {
                    "errors":   error_count,
                    "warnings": warning_count
                }
            except Exception as e:
                log.warning(f"Could not analyze {log_file.name}: {e}")

        return error_summary

    def run(self):
        """Execute full cleanup cycle."""
        log.info("=" * 60)
        log.info(f"🧹 Log Cleanup Started | Dir: {self.log_dir}")
        log.info(f"   Keep logs: {self.keep_days} days | Delete archives: {self.archive_days} days")

        # Step 1: Analyze errors
        log.info("\n📊 Error Analysis:")
        errors = self.count_errors_in_logs()
        for filename, counts in errors.items():
            log.info(f"  {filename:<30} Errors: {counts['errors']:<6} Warnings: {counts['warnings']}")

        # Step 2: Archive old logs
        log.info(f"\n📦 Archiving logs older than {self.keep_days} days:")
        arch_stats = self.archive_old_logs()
        log.info(f"  Archived {arch_stats['archived']} files "
                 f"({arch_stats['size_freed_mb']:.1f} MB compressed)")

        # Step 3: Delete old archives
        log.info(f"\n🗑️  Removing archives older than {self.archive_days} days:")
        del_stats = self.cleanup_old_archives()
        log.info(f"  Deleted {del_stats['deleted']} archives "
                 f"({del_stats['size_freed_mb']:.1f} MB freed)")

        log.info("=" * 60)
        log.info("✅ Log cleanup complete!")


def main():
    parser = argparse.ArgumentParser(description="Log Cleanup & Archival Script")
    parser.add_argument("--log-dir",      default="/var/log/app",     help="Log directory path")
    parser.add_argument("--archive-dir",  default="/var/log/archive",  help="Archive directory path")
    parser.add_argument("--keep-days",    type=int, default=7,          help="Archive logs older than N days")
    parser.add_argument("--archive-days", type=int, default=30,         help="Delete archives older than N days")
    args = parser.parse_args()

    cleaner = LogCleaner(
        log_dir      = args.log_dir,
        archive_dir  = args.archive_dir,
        keep_days    = args.keep_days,
        archive_days = args.archive_days
    )
    cleaner.run()


if __name__ == "__main__":
    main()
```

**Run:**
```bash
# Archive logs older than 7 days, delete archives older than 30 days
python3 log_cleanup.py --log-dir /var/log/app --keep-days 7 --archive-days 30

# Add to cron for daily execution at 2 AM
# 0 2 * * * /usr/bin/python3 /opt/scripts/log_cleanup.py --log-dir /var/log/app
```

---

### 🏭 Program 3: Multi-threaded Server Health Dashboard

```python
#!/usr/bin/env python3
"""
Multi-threaded Server Health Dashboard
Purpose: Check health of multiple servers simultaneously using threading
Usage:   python3 server_health.py --config servers.yaml
"""

import subprocess
import threading
import json
import argparse
import logging
import time
from datetime import datetime
from concurrent.futures import ThreadPoolExecutor, as_completed

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)
log = logging.getLogger(__name__)

# Thread-safe lock for shared data
results_lock = threading.Lock()


def ping_server(host: str, count: int = 3) -> dict:
    """Ping a server and return latency metrics."""
    try:
        result = subprocess.run(
            ["ping", "-c", str(count), "-W", "2", host],
            capture_output=True,
            text=True,
            timeout=10
        )

        if result.returncode == 0:
            # Parse average latency from ping output
            lines = result.stdout.split("\n")
            for line in lines:
                if "avg" in line or "rtt" in line:
                    parts = line.split("/")
                    if len(parts) >= 5:
                        avg_ms = float(parts[4])
                        return {"reachable": True, "latency_ms": avg_ms}

            return {"reachable": True, "latency_ms": 0.0}
        else:
            return {"reachable": False, "latency_ms": None}

    except subprocess.TimeoutExpired:
        return {"reachable": False, "latency_ms": None, "error": "timeout"}
    except Exception as e:
        return {"reachable": False, "latency_ms": None, "error": str(e)}


def check_http_endpoint(host: str, port: int = 80, path: str = "/health") -> dict:
    """Check HTTP endpoint availability."""
    import urllib.request
    import urllib.error

    url = f"http://{host}:{port}{path}"
    try:
        start    = time.time()
        response = urllib.request.urlopen(url, timeout=5)
        duration = (time.time() - start) * 1000   # ms

        return {
            "http_ok":       True,
            "status_code":   response.status,
            "response_ms":   round(duration, 1)
        }
    except urllib.error.HTTPError as e:
        return {"http_ok": False, "status_code": e.code, "response_ms": None}
    except Exception:
        return {"http_ok": False, "status_code": None, "response_ms": None}


def check_server(server_config: dict, all_results: list):
    """Perform full health check on a single server."""
    host    = server_config["host"]
    name    = server_config.get("name", host)
    role    = server_config.get("role", "unknown")
    http    = server_config.get("http_check", False)
    port    = server_config.get("port", 80)

    result = {
        "name":      name,
        "host":      host,
        "role":      role,
        "timestamp": datetime.now().isoformat(),
        "status":    "unknown"
    }

    # Ping check
    ping_result = ping_server(host)
    result.update(ping_result)

    # HTTP check (optional)
    if http and ping_result["reachable"]:
        http_result = check_http_endpoint(host, port)
        result.update(http_result)

    # Determine overall status
    if not result["reachable"]:
        result["status"] = "🔴 DOWN"
    elif http and not result.get("http_ok", True):
        result["status"] = "⚠️  DEGRADED"
    elif result.get("latency_ms", 0) and result["latency_ms"] > 100:
        result["status"] = "🟡 SLOW"
    else:
        result["status"] = "🟢 HEALTHY"

    # Thread-safe append to shared list
    with results_lock:
        all_results.append(result)

    return result


def print_dashboard(results: list, elapsed: float):
    """Print a formatted health dashboard."""
    print("\n" + "=" * 80)
    print(f"  🖥️  SERVER HEALTH DASHBOARD  |  "
          f"Checked: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}  |  "
          f"Duration: {elapsed:.1f}s")
    print("=" * 80)
    print(f"  {'NAME':<20} {'HOST':<18} {'ROLE':<12} {'STATUS':<15} {'LATENCY':>10}")
    print("-" * 80)

    healthy   = 0
    unhealthy = 0

    # Sort by status (DOWN first)
    results.sort(key=lambda x: x["status"])

    for r in results:
        latency = f"{r['latency_ms']:.1f} ms" if r.get("latency_ms") else "N/A"
        print(f"  {r['name']:<20} {r['host']:<18} {r['role']:<12} "
              f"{r['status']:<15} {latency:>10}")

        if "HEALTHY" in r["status"]:
            healthy += 1
        else:
            unhealthy += 1

    print("-" * 80)
    print(f"  Total: {len(results)} | 🟢 Healthy: {healthy} | 🔴 Issues: {unhealthy}")
    print("=" * 80)

    # Alert on failures
    failed = [r for r in results if "DOWN" in r["status"]]
    if failed:
        print("\n🚨 ALERT: The following servers are unreachable:")
        for f in failed:
            print(f"   ❌ {f['name']} ({f['host']}) — {f['role']}")
        print()


def main():
    parser = argparse.ArgumentParser(description="Multi-threaded Server Health Dashboard")
    parser.add_argument("--config",   default="servers.json", help="Server config file (JSON)")
    parser.add_argument("--interval", type=int, default=0,    help="Repeat interval in seconds (0=run once)")
    parser.add_argument("--workers",  type=int, default=20,   help="Max concurrent threads (default: 20)")
    args = parser.parse_args()

    # Sample servers config (normally loaded from args.config file)
    servers = [
        {"name": "web-prod-01",   "host": "10.0.1.10",  "role": "web",      "http_check": True},
        {"name": "web-prod-02",   "host": "10.0.1.11",  "role": "web",      "http_check": True},
        {"name": "db-prod-01",    "host": "10.0.2.10",  "role": "database", "http_check": False},
        {"name": "cache-prod-01", "host": "10.0.3.10",  "role": "cache",    "http_check": False},
        {"name": "jenkins",       "host": "10.0.4.10",  "role": "ci/cd",    "http_check": True, "port": 8080},
        {"name": "google-dns",    "host": "8.8.8.8",    "role": "external", "http_check": False},
    ]

    def run_checks():
        all_results = []
        start_time  = time.time()

        # Run all checks concurrently
        with ThreadPoolExecutor(max_workers=args.workers) as executor:
            futures = {
                executor.submit(check_server, server, all_results): server
                for server in servers
            }
            for future in as_completed(futures):
                try:
                    future.result()
                except Exception as e:
                    log.error(f"Health check failed: {e}")

        elapsed = time.time() - start_time
        print_dashboard(all_results, elapsed)

        # Save results to JSON
        with open("health_report.json", "w") as f:
            json.dump({
                "timestamp": datetime.now().isoformat(),
                "duration_s": round(elapsed, 2),
                "servers": all_results
            }, f, indent=2)

    if args.interval > 0:
        print(f"🔄 Monitoring {len(servers)} servers every {args.interval}s — Ctrl+C to stop")
        while True:
            try:
                run_checks()
                time.sleep(args.interval)
            except KeyboardInterrupt:
                print("\n👋 Monitoring stopped")
                break
    else:
        run_checks()


if __name__ == "__main__":
    main()
```

**Run:**
```bash
# Single check
python3 server_health.py

# Monitor every 60 seconds
python3 server_health.py --interval 60 --workers 50
```

---

### 🏭 Program 4: YAML/JSON Config-Driven Deployment Pipeline

```python
#!/usr/bin/env python3
"""
Config-Driven Deployment Pipeline
Purpose: Read deployment config from YAML, validate, and execute deployment steps
Usage:   python3 deploy_pipeline.py --config deploy.yaml --env production
"""

import yaml
import json
import os
import subprocess
import argparse
import logging
import time
from datetime import datetime
from dataclasses import dataclass
from typing import List, Optional

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler(f"deploy_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log")
    ]
)
log = logging.getLogger(__name__)


# Sample deploy.yaml content:
SAMPLE_CONFIG = """
application:
  name: web-frontend
  version: "2.4.1"
  repo: https://github.com/company/web-frontend.git

environments:
  development:
    servers: ["dev-01.internal"]
    replicas: 1
    health_check_url: "http://dev-01.internal:8080/health"
    deploy_timeout: 120

  staging:
    servers: ["stg-01.internal", "stg-02.internal"]
    replicas: 2
    health_check_url: "http://stg-lb.internal/health"
    deploy_timeout: 180

  production:
    servers: ["prod-01.internal", "prod-02.internal", "prod-03.internal"]
    replicas: 3
    health_check_url: "https://app.company.com/health"
    deploy_timeout: 300
    require_approval: true

steps:
  - name: "Run Unit Tests"
    command: "pytest tests/ -v --tb=short"
    on_failure: "abort"

  - name: "Build Docker Image"
    command: "docker build -t {app_name}:{version} ."
    on_failure: "abort"

  - name: "Push to Registry"
    command: "docker push {registry}/{app_name}:{version}"
    on_failure: "abort"

  - name: "Update Kubernetes Deployment"
    command: "kubectl set image deployment/{app_name} {app_name}={registry}/{app_name}:{version}"
    on_failure: "rollback"

  - name: "Wait for Rollout"
    command: "kubectl rollout status deployment/{app_name} --timeout=300s"
    on_failure: "rollback"

notifications:
  slack_webhook: ""
  email: "devops-team@company.com"
"""


@dataclass
class DeploymentStep:
    name:       str
    command:    str
    on_failure: str = "abort"


class DeploymentPipeline:
    """Executes a config-driven deployment pipeline."""

    def __init__(self, config: dict, environment: str, dry_run: bool = False):
        self.config      = config
        self.environment = environment
        self.dry_run     = dry_run
        self.app         = config["application"]
        self.env_config  = config["environments"][environment]
        self.steps       = [DeploymentStep(**s) for s in config["steps"]]
        self.start_time  = datetime.now()

        log.info(f"🚀 Deployment Pipeline Initialized")
        log.info(f"   App:         {self.app['name']} v{self.app['version']}")
        log.info(f"   Environment: {environment}")
        log.info(f"   Servers:     {', '.join(self.env_config['servers'])}")
        log.info(f"   Dry Run:     {dry_run}")

    def validate_config(self) -> bool:
        """Validate required config fields."""
        required_app    = ["name", "version"]
        required_env    = ["servers", "replicas"]
        errors          = []

        for field in required_app:
            if field not in self.app:
                errors.append(f"Missing app.{field}")

        for field in required_env:
            if field not in self.env_config:
                errors.append(f"Missing environments.{self.environment}.{field}")

        if self.environment not in self.config["environments"]:
            errors.append(f"Environment '{self.environment}' not found in config")

        if errors:
            for err in errors:
                log.error(f"❌ Config validation error: {err}")
            return False

        log.info("✅ Configuration validated successfully")
        return True

    def check_approval(self) -> bool:
        """Require manual approval for production deployments."""
        if self.env_config.get("require_approval", False) and not self.dry_run:
            log.warning("⚠️  Production deployment requires manual approval!")
            response = input(f"\n  Deploy {self.app['name']} v{self.app['version']} "
                             f"to PRODUCTION? (yes/no): ").strip().lower()
            if response != "yes":
                log.info("❌ Deployment cancelled by user")
                return False
        return True

    def execute_step(self, step: DeploymentStep) -> bool:
        """Execute a single deployment step."""
        # Substitute template variables in command
        command = step.command.format(
            app_name = self.app["name"],
            version  = self.app["version"],
            registry = os.environ.get("DOCKER_REGISTRY", "registry.company.com"),
            env      = self.environment
        )

        log.info(f"\n  📌 Step: {step.name}")
        log.info(f"     Command: {command}")

        if self.dry_run:
            log.info(f"     [DRY RUN] Would execute: {command}")
            time.sleep(0.5)   # Simulate execution time
            return True

        try:
            start   = time.time()
            result  = subprocess.run(
                command.split(),
                capture_output=True,
                text=True,
                timeout=self.env_config.get("deploy_timeout", 300)
            )
            duration = time.time() - start

            if result.returncode == 0:
                log.info(f"     ✅ Success ({duration:.1f}s)")
                if result.stdout.strip():
                    log.debug(f"     Output: {result.stdout.strip()[:200]}")
                return True
            else:
                log.error(f"     ❌ Failed (exit code: {result.returncode})")
                log.error(f"     Error: {result.stderr.strip()[:300]}")
                return False

        except subprocess.TimeoutExpired:
            log.error(f"     ❌ Step timed out after {self.env_config.get('deploy_timeout')}s")
            return False
        except Exception as e:
            log.error(f"     ❌ Unexpected error: {e}")
            return False

    def rollback(self):
        """Execute rollback procedure."""
        log.warning("\n⏪ Initiating Rollback...")
        rollback_cmd = (f"kubectl rollout undo deployment/{self.app['name']}")
        if not self.dry_run:
            subprocess.run(rollback_cmd.split(), capture_output=True)
        log.warning("⏪ Rollback completed")

    def generate_report(self, success: bool, steps_results: list):
        """Generate deployment report."""
        duration = (datetime.now() - self.start_time).seconds
        report   = {
            "deployment": {
                "app":         self.app["name"],
                "version":     self.app["version"],
                "environment": self.environment,
                "timestamp":   self.start_time.isoformat(),
                "duration_s":  duration,
                "success":     success,
                "dry_run":     self.dry_run
            },
            "steps": steps_results
        }

        report_file = f"deploy_report_{self.app['name']}_{self.environment}_{self.start_time.strftime('%Y%m%d_%H%M%S')}.json"
        with open(report_file, "w") as f:
            json.dump(report, f, indent=2)

        log.info(f"📋 Deployment report saved: {report_file}")
        return report_file

    def run(self) -> bool:
        """Execute the full deployment pipeline."""
        log.info("\n" + "=" * 70)
        log.info(f"🚀 DEPLOYMENT STARTED: {self.app['name']} v{self.app['version']} → {self.environment.upper()}")
        log.info("=" * 70)

        # Validate configuration
        if not self.validate_config():
            return False

        # Check for manual approval
        if not self.check_approval():
            return False

        steps_results = []
        overall_success = True

        # Execute each step
        for i, step in enumerate(self.steps, 1):
            log.info(f"\n[{i}/{len(self.steps)}] {step.name}")
            success = self.execute_step(step)

            steps_results.append({
                "step":    step.name,
                "success": success,
                "command": step.command
            })

            if not success:
                overall_success = False
                if step.on_failure == "rollback":
                    self.rollback()
                break   # Abort remaining steps

        # Final summary
        duration = (datetime.now() - self.start_time).seconds
        log.info("\n" + "=" * 70)
        if overall_success:
            log.info(f"✅ DEPLOYMENT SUCCESSFUL in {duration}s")
        else:
            log.error(f"❌ DEPLOYMENT FAILED after {duration}s")

        log.info(f"   Steps completed: {len(steps_results)}/{len(self.steps)}")
        log.info("=" * 70)

        # Generate report
        self.generate_report(overall_success, steps_results)
        return overall_success


def main():
    parser = argparse.ArgumentParser(description="Config-Driven Deployment Pipeline")
    parser.add_argument("--config",  required=True, help="Path to deploy.yaml config file")
    parser.add_argument("--env",     required=True,
                        choices=["development", "staging", "production"],
                        help="Target environment")
    parser.add_argument("--dry-run", action="store_true",
                        help="Simulate without executing commands")
    args = parser.parse_args()

    # Load config (create sample if not found)
    config_path = args.config
    if not os.path.exists(config_path):
        log.warning(f"Config not found — creating sample: {config_path}")
        with open(config_path, "w") as f:
            f.write(SAMPLE_CONFIG)

    with open(config_path, "r") as f:
        config = yaml.safe_load(f)

    # Run deployment
    pipeline = DeploymentPipeline(
        config      = config,
        environment = args.env,
        dry_run     = args.dry_run
    )

    success = pipeline.run()
    exit(0 if success else 1)    # Exit code for CI/CD integration


if __name__ == "__main__":
    main()
```

**Run:**
```bash
pip install pyyaml

# Dry run to staging
python3 deploy_pipeline.py --config deploy.yaml --env staging --dry-run

# Actual production deployment
python3 deploy_pipeline.py --config deploy.yaml --env production

# In CI/CD (check exit code)
python3 deploy_pipeline.py --config deploy.yaml --env production
if [ $? -eq 0 ]; then echo "Deployment succeeded"; fi
```

---

## 📌 Quick Reference — DevOps Python Cheatsheet

### Common Mistakes to Avoid 🔴

| Mistake                                   | Fix                                              |
|-------------------------------------------|--------------------------------------------------|
| `print()` instead of `logging`            | Always use `logging` in production scripts       |
| Hardcoding passwords/keys in code         | Use `os.environ.get()` or `.env` files           |
| `yaml.load()` instead of `yaml.safe_load()`| Always use `safe_load()` to prevent code execution |
| Missing `with` for file operations        | Always use `with open()` for auto-close          |
| `shell=True` with user input in subprocess | Pass commands as list, avoid shell injection     |
| No exception handling in automation scripts | Wrap API calls and file ops in try/except       |
| Infinite loops without exit conditions    | Always have a break condition in while loops     |
| Modifying a list while iterating over it  | Iterate over a copy: `for item in list.copy()`  |

### Interview Quick-Fire Answers 🎯

| Question                              | Answer                                                      |
|---------------------------------------|-------------------------------------------------------------|
| Difference: `list` vs `tuple`         | List = mutable; Tuple = immutable                           |
| What is `__init__`?                   | Constructor — auto-called when object is created            |
| `*args` vs `**kwargs`                 | `*args` = variable positional args (tuple); `**kwargs` = variable keyword args (dict) |
| `yield` vs `return`                   | `return` exits function; `yield` pauses and resumes (generator) |
| Threading vs Multiprocessing          | Threading = I/O-bound (shared memory); Multiprocessing = CPU-bound (separate memory) |
| Why use decorators?                   | Add functionality (logging, retry, auth) without modifying original code |
| `finally` block purpose?              | Always executes — use for cleanup (close connections, release locks) |
| How to avoid hardcoding secrets?      | `os.environ.get()`, `.env` files with `python-dotenv`       |

---

> 💡 **Final Advice from the Instructor:** Python is a **practice-first** language. Write every example yourself, modify it, break it intentionally, then fix it. That's how DevOps engineers truly master Python. The concepts covered here — from basic variables all the way to OOP, threading, and production automation — form the complete foundation you need for real-world DevOps work and interviews.
