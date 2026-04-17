# 🐍 Python for DevOps — Complete Notes with Simple Production Programs
### From Basics to Advanced | Every Concept from the Transcript Covered

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
10. [Simple Production Programs for Every Module](#10-simple-production-programs-for-every-module)

---

## 1. Python Basics

### 🔹 What is Python?

Python is a **high-level, interpreted, object-oriented programming language**.

Used in DevOps for:
- **Automation** — removing manual repetitive tasks
- **Scripting** — writing deployment and monitoring tools
- **CI/CD** — Jenkins, GitHub Actions helper scripts
- **Cloud operations** — AWS, Azure automation
- **Infrastructure management** — working with APIs, configs

> **Why Python in DevOps?**
> - Easy English-like syntax
> - Rich library ecosystem (`boto3`, `paramiko`, `requests`)
> - Runs on Linux, Windows, macOS without recompilation

---

### 🔹 Python Setup

**Linux (Ubuntu/Debian):**
```bash
sudo apt install python3
python3 --version         # Output: Python 3.12.3
```

**Windows:** Download from [python.org](https://python.org)

**Run a script:**
```bash
python3 script.py
```

---

### 🔹 Python Indentation — Most Important Rule

Python uses **spaces/tabs** to define code blocks. **No curly braces `{}`.**

```python
# ✅ CORRECT — 4 spaces indent
if True:
    print("Hello Python")

# ❌ WRONG — will give IndentationError
if True:
print("Hello Python")
```

> **Common Mistake 🔴:** Mixing tabs and spaces causes `IndentationError`. Always use **4 spaces**.

---

### 🔹 Variables & Data Types

Variables are **containers** that store data.

```python
# DevOps variable examples
server_name   = "web-prod-01"   # str   → text
port          = 22               # int   → whole number
cpu_usage     = 85.5             # float → decimal number
is_running    = True             # bool  → True or False
```

**All Python Data Types:**

| Type     | Example                        | Notes                        |
|----------|--------------------------------|------------------------------|
| `int`    | `port = 22`                    | Whole numbers                |
| `float`  | `cpu = 85.5`                   | Decimal numbers              |
| `str`    | `host = "10.0.0.1"`            | Text                         |
| `bool`   | `active = True`                | True or False only           |
| `list`   | `["web01", "db01"]`            | Ordered, Mutable             |
| `tuple`  | `("admin", "pass")`            | Ordered, Immutable           |
| `set`    | `{"web01", "db01"}`            | Unordered, Unique values     |
| `dict`   | `{"name": "web01"}`            | Key-value pairs              |

> **Interview Tip 🎯 — Most Asked:**
> - **List** → Ordered + Mutable (can change) → written in `[ ]`
> - **Tuple** → Ordered + Immutable (cannot change) → written in `( )`
> - **Set** → Unordered + Unique (no duplicates) → written in `{ }`
> - **Dictionary** → Key-value pairs → written in `{ key: value }`

---

### 🔹 Input and Output

```python
# Taking input from user
server_name = input("Enter the server name: ")

# Printing output — always use f-string formatting
print(f"Connecting to {server_name}, please wait...")
```

**String Formatting — f-strings (Python 3.6+):**
```python
tool    = "Ansible"
region  = "us-east-1"

# ❌ Wrong — variable not expanded
print("Tool is tool in region")

# ✅ Correct — use f before the string
print(f"Tool is {tool} in {region}")
# Output: Tool is Ansible in us-east-1
```

> **Common Mistake 🔴:** Forgetting the `f` before the string — variable name prints literally.

---

### 🔹 Type Conversion (Type Casting)

**Two types:**

**1. Implicit** — Python converts automatically:
```python
a = 10       # int
b = 5.5      # float
c = a + b    # Python auto-converts int → float
print(c)           # 15.5
print(type(c))     # <class 'float'>
```

**2. Explicit** — You manually convert using built-in functions:
```python
# String → Integer
port_str = "8080"
port_int = int(port_str)
print(type(port_int))    # <class 'int'>

# Integer → String
code = 200
msg  = "Status: " + str(code)
print(msg)               # Status: 200

# Integer → Float
age     = 25
age_flt = float(age)
print(age_flt)           # 25.0

# Integer → Boolean
print(bool(1))    # True
print(bool(0))    # False

# List → Tuple
servers      = ["web01", "db01"]
server_tuple = tuple(servers)
print(server_tuple)    # ('web01', 'db01')

# List → Set (removes duplicates)
ips     = ["10.0.0.1", "10.0.0.2", "10.0.0.1"]
unique  = set(ips)
print(unique)          # {'10.0.0.1', '10.0.0.2'}
```

---

### 🔹 Operators

```python
a, b = 10, 3

# ── Arithmetic Operators ──
print(a + b)    # 13  — addition
print(a - b)    # 7   — subtraction
print(a * b)    # 30  — multiplication
print(a / b)    # 3.33 — division (always float)
print(a // b)   # 3   — floor division
print(a % b)    # 1   — modulus (remainder)
print(a ** b)   # 1000 — exponentiation

# ── Comparison Operators ──
print(a == b)   # False — equal to
print(a != b)   # True  — not equal
print(a > b)    # True  — greater than
print(a < b)    # False — less than
print(a >= b)   # True  — greater than or equal
print(a <= b)   # False — less than or equal

# ── Logical Operators ──
x = True
y = False

print(x and y)   # False — both must be True
print(x or y)    # True  — at least one must be True
print(not x)     # False — negates the value
```

**DevOps Example — Logical Operators:**
```python
cpu_usage    = 90
memory_usage = 85

# Alert when BOTH are high
if cpu_usage > 80 and memory_usage > 80:
    print("CRITICAL: Scale up the server!")

# Alert when EITHER is high
if cpu_usage > 80 or memory_usage > 80:
    print("WARNING: Resource usage is high!")
```

---

### 🔹 String Operations

```python
message = "Python for DevOps"

print(message.upper())              # PYTHON FOR DEVOPS
print(message.lower())              # python for devops
print(message.split(" "))           # ['Python', 'for', 'DevOps']
print(message.replace("DevOps", "AWS"))  # Python for AWS
print(message.strip())              # removes extra spaces
print(len(message))                 # 17 — length
print("DevOps" in message)          # True — check substring
print(message.startswith("Python")) # True
```

---

### 🔹 Comments

```python
# This is a single-line comment

"""
This is a multi-line comment.
Use this to describe your script purpose.
"""

def deploy():
    """This function deploys the application."""
    print("Deploying...")
```

---

## 2. Control Flow

### 🔹 if / elif / else — Conditional Statements

Control flow allows programs to **make decisions**.

```python
server_status = "running"

if server_status == "running":
    print("Server is healthy")
elif server_status == "stopped":
    print("Server is down")
else:
    print("Unknown status")
```

**Nested Condition:**
```python
cpu_usage    = 88
memory_usage = 92

if cpu_usage > 75:
    if memory_usage > 80:
        print("High CPU and Memory — Scale up!")
    else:
        print("Only CPU is high — monitor closely")
```

**Shorthand (Inline) if-else:**
```python
status  = "up"
message = "Server is UP" if status == "up" else "Server is DOWN"
print(message)
```

---

### 🔹 For Loop

```python
# Loop over a list
tools = ["docker", "jenkins", "ansible"]

for tool in tools:
    print(f"Installing {tool}")

# Loop with range
for batch in range(1, 4):    # 1, 2, 3
    print(f"Deploying batch {batch}")

# Loop over dictionary
servers = {"web01": "running", "db01": "stopped"}

for name, status in servers.items():
    if status == "running":
        print(f"{name} is healthy")
    else:
        print(f"{name} is down — restarting")
```

---

### 🔹 While Loop

```python
count = 0

while count < 3:
    print(f"Running build pipeline attempt {count + 1}")
    count += 1    # increment — MUST have this to avoid infinite loop
```

> **Common Mistake 🔴:** Forgetting the increment `count += 1` creates an **infinite loop**.

---

### 🔹 Loop Control Statements

**break — exit the loop immediately:**
```python
servers = ["web01", "db01", "FAILED", "cache01"]

for server in servers:
    if server == "FAILED":
        print("Critical failure — stopping")
        break
    print(f"{server} — OK")
```

**continue — skip current iteration:**
```python
logs = ["INFO: started", "ERROR: disk full", "INFO: running"]

for log in logs:
    if log.startswith("INFO"):
        continue    # skip INFO, only process ERROR
    print(f"Alert: {log}")
```

**pass — placeholder, does nothing:**
```python
for server in servers:
    if server == "FAILED":
        pass    # TODO: add alert logic later
    else:
        print(f"{server} is OK")
```

**else with loop — executes when loop finishes normally:**
```python
for i in range(3):
    print(f"Checking node {i}")
else:
    print("All nodes checked successfully")
```

---

## 3. Data Structures

### 🔹 List — Ordered & Mutable

```python
servers = ["docker", "jenkins", "ansible", "kubernetes"]

# Access by index (starts at 0)
print(servers[0])     # docker  (first)
print(servers[-1])    # kubernetes (last)

# Add element at the end
servers.append("terraform")
print(servers)

# Remove specific element
servers.remove("jenkins")
print(servers)

# Modify (update) element — possible because list is MUTABLE
servers[1] = "gitlab"
print(servers)

# Loop through list
for s in servers:
    print(f"Checking logs for {s}")
```

---

### 🔹 Tuple — Ordered & Immutable

```python
credentials = ("admin", "password123")

print(credentials[0])    # admin
print(credentials[1])    # password123

# Trying to modify → ERROR
# credentials[0] = "root"
# TypeError: 'tuple' object does not support item assignment
```

> **DevOps Use:** Use tuples for **credentials, fixed config values** that must NOT be modified.

---

### 🔹 Set — Unordered & Unique

```python
# Removes duplicates automatically
tools = {"docker", "ansible", "docker", "terraform", "ansible"}
print(tools)    # {'docker', 'ansible', 'terraform'} — no duplicates

# Set operations
team_a = {"docker", "ansible", "jenkins"}
team_b = {"aws", "terraform", "docker"}

# Union — combine both
print(team_a | team_b)

# Intersection — only common items
print(team_a & team_b)    # {'docker'}
```

---

### 🔹 Dictionary — Key-Value Pairs

```python
server = {
    "name":   "web-prod-01",
    "ip":     "10.0.1.50",
    "status": "running"
}

# Access value by key
print(server["name"])    # web-prod-01
print(server["status"])  # running

# Add new key
server["region"] = "us-east-1"

# Update value
server["status"] = "stopped"

# Delete key
del server["ip"]

# Loop through all key-value pairs
for key, value in server.items():
    print(f"{key}: {value}")
```

---

### 🔹 Nested Data Structures

**List of Dictionaries — Most common in DevOps:**
```python
servers = [
    {"name": "web01", "status": "running"},
    {"name": "db01",  "status": "stopped"},
    {"name": "web02", "status": "running"}
]

for s in servers:
    if s["status"] == "running":
        print(f"{s['name']} is healthy")
    else:
        print(f"{s['name']} is down — restarting service")
```

**Dictionary of Lists:**
```python
deployment = {
    "production": ["web01", "web02"],
    "staging":    ["stg01"]
}

for env, server_list in deployment.items():
    print(f"Environment: {env}")
    for s in server_list:
        print(f"  Server: {s}")
```

---

### 🔹 Conversion Between Data Structures

```python
# List → Set (remove duplicates)
servers     = ["web01", "db01", "web01"]
unique      = set(servers)
print(unique)

# Tuple → List
creds       = ("admin", "pass123")
creds_list  = list(creds)
print(creds_list)

# Dictionary → get keys and values as list
config      = {"tool": "docker", "env": "prod"}
keys        = list(config.keys())
values      = list(config.values())
print(keys)     # ['tool', 'env']
print(values)   # ['docker', 'prod']
```

---

## 4. Functions

### 🔹 Basic Function

```python
# Function without parameters
def show_banner():
    print("=" * 40)
    print("  DevOps Automation Script")
    print("=" * 40)

show_banner()   # Call the function
```

### 🔹 Function with Parameters & Return Value

```python
def check_server(server_name, status):
    if status == "running":
        return f"{server_name} is HEALTHY"
    else:
        return f"{server_name} is DOWN"

result = check_server("web-prod-01", "running")
print(result)    # web-prod-01 is HEALTHY
```

---

### 🔹 Types of Function Arguments

**1. Positional — order matters:**
```python
def deploy(environment, version):
    print(f"Deploying version {version} to {environment}")

deploy("production", "2.4.1")    # correct order
```

**2. Keyword — order doesn't matter:**
```python
deploy(version="2.4.1", environment="staging")
```

**3. Default — fallback value if not provided:**
```python
def start_server(name, region="us-east-1"):
    print(f"Starting {name} in {region}")

start_server("web01")                    # uses default region
start_server("web01", "ap-south-1")     # overrides default
```

**4. `*args` — Multiple positional arguments:**
```python
def install_tools(*tools):
    for tool in tools:
        print(f"Installing {tool}")

install_tools("docker", "kubectl", "terraform")
# can pass any number of arguments
```

**5. `**kwargs` — Multiple keyword arguments:**
```python
def configure_server(**settings):
    for key, value in settings.items():
        print(f"{key}: {value}")

configure_server(hostname="web01", ip="10.0.1.50", os="Ubuntu")
```

> **Interview Tip 🎯:**
> - `*args` → tuple internally — for multiple positional args
> - `**kwargs` → dictionary internally — for multiple keyword args

---

### 🔹 Lambda Functions

One-line anonymous function using `lambda` instead of `def`:

```python
# Regular function
def square(x):
    return x * x

# Same as lambda
square = lambda x: x * x
print(square(5))    # 25

# Filter running servers using lambda
servers = [
    {"name": "web01", "status": "running"},
    {"name": "db01",  "status": "stopped"},
    {"name": "web02", "status": "running"}
]

running = list(filter(lambda s: s["status"] == "running", servers))
print([s["name"] for s in running])    # ['web01', 'web02']
```

---

### 🔹 Variable Scope — Local vs Global

```python
count = 0    # GLOBAL — accessible anywhere

def run_deploy():
    global count          # declare you want to modify global
    local_msg = "done"    # LOCAL — only inside this function
    count += 1
    print(f"Deploy #{count}: {local_msg}")

run_deploy()    # Deploy #1: done
run_deploy()    # Deploy #2: done

print(count)    # 2 — global was modified
# print(local_msg)  # ❌ NameError — local variable not accessible here
```

---

### 🔹 Nested Functions

```python
def devops_pipeline():
    def build():
        print("Building code...")

    def deploy():
        print("Deploying to server...")

    build()     # call inner function
    deploy()    # call inner function

devops_pipeline()
```

---

## 5. Modules & Packages

### 🔹 What is a Module?

A **module** is simply a `.py` file that contains functions, variables, and classes you can reuse.

**Create custom module — `devops_utils.py`:**
```python
# devops_utils.py

def start_server(server_name):
    print(f"Starting server: {server_name}")

def stop_server(server_name):
    print(f"Stopping server: {server_name}")

def get_status(server_name):
    print(f"Checking status of: {server_name}")
```

**Import and use in `main.py`:**
```python
# main.py
import devops_utils

devops_utils.start_server("web-prod-01")
devops_utils.stop_server("db-stg-01")
devops_utils.get_status("cache-01")
```

```bash
python3 main.py
```

---

### 🔹 OS Module — Interact with Operating System

```python
import os

# Get current directory
print(os.getcwd())

# Change directory
os.chdir("/tmp")

# Create a new directory
os.makedirs("/tmp/logs", exist_ok=True)

# List files in a directory
files = os.listdir("/tmp")
print(files)

# Check if file exists
if os.path.exists("/etc/nginx/nginx.conf"):
    print("Nginx config found")
else:
    print("Nginx config missing")

# Rename a file
os.rename("old.txt", "new.txt")

# Delete a file
os.remove("/tmp/temp.txt")

# Get environment variable
db_pass = os.environ.get("DB_PASSWORD", "default")
print(f"DB Password: {db_pass}")
```

---

### 🔹 SYS Module — System Parameters

```python
import sys

# Python version
print(sys.version)

# OS platform
print(sys.platform)    # 'linux', 'win32', 'darwin'

# System path
print(sys.path)

# Command-line arguments
# Run: python3 script.py web01 us-east-1
print(sys.argv[0])    # script.py
print(sys.argv[1])    # web01
print(sys.argv[2])    # us-east-1

# Exit with status code
if not os.path.exists("/etc/app/config.yml"):
    print("Config missing!")
    sys.exit(1)    # exit with error code 1
```

---

### 🔹 Subprocess Module — Run Shell Commands

```python
import subprocess

# Run command and capture output
result = subprocess.run(
    ["df", "-h"],
    capture_output=True,
    text=True
)
print(result.stdout)

# Check if service is running
result = subprocess.run(
    ["systemctl", "is-active", "nginx"],
    capture_output=True,
    text=True
)

if result.stdout.strip() == "active":
    print("Nginx is running")
else:
    print("Nginx is down")

# Get uptime
output = subprocess.check_output("uptime", shell=True, text=True)
print(f"Uptime: {output.strip()}")
```

> **Production Best Practice 🔐:** Never use `shell=True` with user-supplied input — risk of shell injection. Pass commands as a **list**.

---

### 🔹 Shutil Module — High-Level File Operations

```python
import shutil

# Copy a file
shutil.copy("nginx.conf", "/etc/nginx/nginx.conf.bak")

# Move a file
shutil.move("deploy.log", "/var/log/archive/deploy.log")

# Copy entire directory
shutil.copytree("/app/config", "/app/config_backup")

# Delete entire directory
shutil.rmtree("/tmp/old_build")
```

---

### 🔹 JSON Module

```python
import json

# Python dictionary → JSON string
config = {
    "name":   "web-prod-01",
    "port":   8080,
    "active": True
}
json_str = json.dumps(config, indent=4)
print(json_str)

# Write JSON to file
with open("config.json", "w") as f:
    json.dump(config, f, indent=4)

# Read JSON from file
with open("config.json", "r") as f:
    loaded = json.load(f)
print(loaded["name"])    # web-prod-01

# JSON string → Python dictionary
api_resp = '{"status": "ok", "version": "2.4"}'
data = json.loads(api_resp)
print(data["status"])    # ok
```

---

### 🔹 YAML Module

```bash
pip install pyyaml
```

```python
import yaml

# Write YAML file
config = {
    "app":         "web-frontend",
    "environment": "production",
    "replicas":    3
}

with open("deploy.yaml", "w") as f:
    yaml.dump(config, f, default_flow_style=False)

# Read YAML file — always use safe_load
with open("deploy.yaml", "r") as f:
    data = yaml.safe_load(f)

print(data["app"])           # web-frontend
print(data["replicas"])      # 3
```

> **Production Best Practice:** Always `yaml.safe_load()` — never `yaml.load()` (security risk).

---

### 🔹 Datetime Module

```python
from datetime import datetime

# Current date and time
now = datetime.now()
print(now)    # 2024-01-15 14:30:45.123456

# Only today's date
today = datetime.today().date()
print(today)    # 2024-01-15

# Custom date
custom = datetime(2024, 12, 31)
print(custom)

# Custom time
from datetime import time
t = time(14, 30, 45)
print(t)    # 14:30:45

# Formatted timestamp for log filenames
stamp = now.strftime("%Y%m%d_%H%M%S")
print(f"deploy_{stamp}.log")    # deploy_20240115_143045.log

# Difference between two dates
from datetime import timedelta
past = datetime(2024, 1, 1)
diff = now - past
print(f"Days since Jan 1: {diff.days}")

# Date 30 days ago (for log cleanup)
cutoff = datetime.now() - timedelta(days=30)
print(f"Delete logs before: {cutoff.strftime('%Y-%m-%d')}")
```

---

### 🔹 Creating a Custom Package

**Folder structure:**
```
devops_tools/
├── __init__.py         ← marks folder as package
├── aws_utils.py
└── docker_utils.py
```

```python
# devops_tools/__init__.py
# mark this folder as a package

# devops_tools/aws_utils.py
def deploy_ec2(instance_name):
    print(f"Deploying EC2: {instance_name}")

# devops_tools/docker_utils.py
def start_container(container_name):
    print(f"Starting container: {container_name}")

# main.py
from devops_tools import aws_utils, docker_utils

aws_utils.deploy_ec2("web-instance-01")
docker_utils.start_container("nginx-frontend")
```

```bash
python3 main.py
# Output:
# Deploying EC2: web-instance-01
# Starting container: nginx-frontend
```

---

### 🔹 Third-Party Libraries for DevOps

Install all at once:
```bash
pip install boto3 paramiko requests psutil
```

| Library    | Purpose                           | DevOps Use                          |
|------------|-----------------------------------|-------------------------------------|
| `boto3`    | AWS SDK                           | EC2, S3, Lambda automation          |
| `paramiko` | SSH client                        | Remote command execution            |
| `requests` | HTTP client                       | REST API calls (Jenkins, GitHub)    |
| `psutil`   | System monitoring                 | CPU, memory, disk checks            |

**Quick `requests` example:**
```python
import requests

response = requests.get("https://api.github.com")
print(response.status_code)    # 200
```

---

## 6. File Handling

### 🔹 File Modes

| Mode  | What it does                                       |
|-------|----------------------------------------------------|
| `r`   | Read only — file must exist (default)              |
| `w`   | Write — creates new or **overwrites** existing     |
| `a`   | Append — adds to end, creates if not found         |
| `x`   | Create — fails if file already exists              |
| `r+`  | Read and Write                                     |
| `rb`  | Read binary (images, PDFs)                         |

---

### 🔹 Writing to a File

```python
# Write mode — creates new or overwrites
with open("devops_notes.txt", "w") as f:
    f.write("Python makes DevOps automation easy\n")
    f.write("Logging and monitoring are essential\n")

# File is auto-closed after 'with' block — no need for f.close()
```

---

### 🔹 Reading from a File

```python
# Read entire file
with open("devops_notes.txt", "r") as f:
    content = f.read()
    print(content)

# Read line by line (memory efficient for large files)
with open("devops_notes.txt", "r") as f:
    for line in f:
        print(line.strip())
```

---

### 🔹 Appending to a File

```python
# Append — does NOT overwrite, adds to end
with open("devops_notes.txt", "a") as f:
    f.write("Always secure your servers\n")
```

---

### 🔹 Context Manager (with open)

```python
# ❌ Old way — risk of forgetting to close
f = open("file.txt", "r")
content = f.read()
f.close()   # easy to forget!

# ✅ Correct way — auto-closes even if error occurs
with open("file.txt", "r") as f:
    content = f.read()
# file is automatically closed here
```

---

### 🔹 Check if File Exists

```python
import os

if os.path.exists("servers.txt"):
    print("File exists")
else:
    print("File does not exist")
```

---

### 🔹 Log Analysis — Count Errors

```python
# Create a sample log file
with open("system.log", "w") as f:
    f.write("INFO: server started\n")
    f.write("ERROR: disk full\n")
    f.write("INFO: request received\n")
    f.write("ERROR: out of memory\n")
    f.write("ERROR: connection refused\n")

# Count errors
error_count = 0

with open("system.log", "r") as f:
    for line in f:
        if "ERROR" in line:
            error_count += 1

print(f"Total errors found: {error_count}")    # 3
```

---

### 🔹 JSON File Handling

```python
import json

# Write JSON data
data = {
    "app":     "web-frontend",
    "servers": ["web01", "web02"],
    "port":    8080
}

with open("config.json", "w") as f:
    json.dump(data, f, indent=4)

print("config.json written")

# Read JSON data
with open("config.json", "r") as f:
    loaded = json.load(f)

print(f"App: {loaded['app']}")
print(f"Servers: {loaded['servers']}")
```

---

### 🔹 YAML File Handling

```python
import yaml

# Write YAML
deploy_config = {
    "app":         "nginx",
    "environment": "staging",
    "replicas":    2
}

with open("deploy.yaml", "w") as f:
    yaml.dump(deploy_config, f, default_flow_style=False)

# Read YAML
with open("deploy.yaml", "r") as f:
    config = yaml.safe_load(f)

print(f"App: {config['app']}")
print(f"Env: {config['environment']}")
```

---

### 🔹 CSV File Handling

```python
import csv

# Write CSV
with open("servers.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["server", "ip", "status"])       # header row
    writer.writerow(["web01", "10.0.1.50", "running"])  # data row

print("servers.csv written")

# Read CSV
with open("servers.csv", "r") as f:
    reader = csv.reader(f)
    for row in reader:
        print(row)
```

---

### 🔹 Log Rotation

```python
import shutil
from datetime import datetime

def rotate_log(log_file):
    timestamp   = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_name = f"{log_file}.{timestamp}.bak"
    shutil.move(log_file, backup_name)
    print(f"Log rotated: {log_file} → {backup_name}")

rotate_log("system.log")
```

---

## 7. Exception Handling

### 🔹 Why Exception Handling?

Without it, **one error stops the entire script**:

```python
# ❌ Without exception handling
print("Script starting")
result = 10 / 0        # ZeroDivisionError — script STOPS here
print("Script done")   # NEVER executed
```

---

### 🔹 try / except

```python
# ✅ With exception handling
try:
    result = 10 / 0
except ZeroDivisionError:
    print("Cannot divide by zero")

print("Script continues...")    # this DOES execute now
```

---

### 🔹 Multiple except blocks

```python
try:
    num = int(input("Enter a number: "))
    result = 10 / num
    print(f"Result: {result}")

except ZeroDivisionError:
    print("You cannot divide by zero")

except ValueError:
    print("Please enter a valid number")
```

---

### 🔹 try / except / else / finally

```python
try:
    with open("servers.txt", "r") as f:
        content = f.read()

except FileNotFoundError:
    print("File not found")

else:
    # runs ONLY when NO exception occurred
    print("File opened successfully")
    print(content)

finally:
    # runs ALWAYS — exception or not
    print("Closing script — cleanup done")
```

> **Interview Tip 🎯:**
> - `else` → runs only when **no exception** occurred
> - `finally` → runs **always**, used for cleanup

---

### 🔹 Common Python Exceptions

| Exception              | When it happens                                  |
|------------------------|--------------------------------------------------|
| `FileNotFoundError`    | File or directory not found                      |
| `ZeroDivisionError`    | Dividing by zero                                 |
| `ValueError`           | Wrong value type (`int("abc")`)                  |
| `KeyError`             | Dictionary key doesn't exist                     |
| `IndexError`           | List index out of range                          |
| `TypeError`            | Wrong data type for operation                    |
| `ImportError`          | Module not found                                 |
| `TimeoutError`         | Operation timed out                              |
| `PermissionError`      | Insufficient permissions                         |

---

### 🔹 raise — Manually Trigger Exception

```python
def deploy(version):
    if float(version) < 1.0:
        raise ValueError(f"Invalid version: {version}. Must be >= 1.0")
    print(f"Deploying version {version}")

try:
    deploy("0.8")
except ValueError as e:
    print(f"Error: {e}")
```

---

### 🔹 Custom Exceptions

```python
# Create a custom exception class
class DeploymentError(Exception):
    pass

def deploy_app(version):
    if version == "BROKEN":
        raise DeploymentError("Deployment package is corrupted!")
    print(f"Deploying {version} successfully")

try:
    deploy_app("BROKEN")
except DeploymentError as e:
    print(f"Custom Exception caught: {e}")
```

---

### 🔹 Retry Logic

```python
import time

def connect_to_server(server, max_retries=3):
    for attempt in range(1, max_retries + 1):
        try:
            print(f"Attempt {attempt}: Connecting to {server}")
            if attempt < max_retries:
                raise ConnectionError("Connection refused")
            print(f"Connected to {server} successfully!")
            break

        except ConnectionError as e:
            print(f"Failed: {e}")
            if attempt < max_retries:
                print(f"Retrying in 2 seconds...")
                time.sleep(2)

connect_to_server("10.0.1.50")
```

---

### 🔹 Logging Exceptions to File

```python
import logging

# Setup logging to write to a file
logging.basicConfig(
    filename="errors.log",
    level=logging.ERROR,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

try:
    result = 10 / 0
except ZeroDivisionError as e:
    logging.error(f"Division by zero: {e}")
    print("Error logged to errors.log")
```

**Logging levels:**
```python
logging.debug("Debug details")       # lowest level
logging.info("Script started")
logging.warning("CPU at 78%")
logging.error("DB connection failed")
logging.critical("Server is DOWN!")  # highest level
```

---

## 8. OOP Concepts

### 🔹 What is OOP?

OOP organizes code into **objects** that combine:
- **Data (attributes)** → properties: `name`, `ip`, `status`
- **Behavior (methods)** → actions: `start()`, `stop()`, `restart()`

**4 Pillars:**
1. **Encapsulation** — hide internal details
2. **Inheritance** — reuse code from another class
3. **Polymorphism** — same method name, different behavior
4. **Abstraction** — hide complexity from user

---

### 🔹 Class & Object

```python
class Server:

    def __init__(self, name, ip):
        # __init__ is the constructor
        # automatically called when object is created
        self.name = name    # instance variable
        self.ip   = ip      # instance variable

    def start(self):
        print(f"Server {self.name} ({self.ip}) is starting...")

# Create objects (instances of the class)
web_server = Server("web-prod-01", "10.0.1.50")
db_server  = Server("db-prod-01", "10.0.2.30")

web_server.start()
db_server.start()
```

> **Interview Tip 🎯:** `__init__` is the **constructor** — it initializes object attributes automatically when the object is created.

---

### 🔹 Encapsulation — Hide Internal Details

```python
class JenkinsPipeline:

    def __init__(self, job_name):
        self.job_name       = job_name     # public attribute
        self.__secret_token = "abc123"     # private — double underscore
        self.__build_count  = 0            # private variable

    def __build(self):
        # private method — can only be called inside this class
        self.__build_count += 1
        print(f"Building {self.job_name} — build #{self.__build_count}")

    def __deploy(self):
        # private method
        print(f"Deploying {self.job_name}")

    def trigger_pipeline(self):
        # public method — this is the only external interface
        print(f"Pipeline triggered: {self.job_name}")
        self.__build()     # calling private method internally
        self.__deploy()    # calling private method internally

pipeline = JenkinsPipeline("deploy-webapp")
pipeline.trigger_pipeline()     # ✅ works

# pipeline.__build()            # ❌ AttributeError — private method
```

> **When to use:** When you want to **hide secrets, credentials, internal logic** from outside access.

---

### 🔹 Inheritance — Reuse Code from Another Class

```python
# Parent class
class Server:

    def __init__(self, name, ip):
        self.name = name
        self.ip   = ip

    def start(self):
        print(f"Starting {self.name}")

# Child class — inherits Server
class WebServer(Server):

    def __init__(self, name, ip, domain):
        super().__init__(name, ip)    # call parent constructor
        self.domain = domain

    def deploy(self, app):
        print(f"Deploying {app} to {self.domain}")

web = WebServer("nginx-01", "10.0.1.50", "app.example.com")

web.start()             # inherited from Server
web.deploy("v2.1")      # WebServer's own method
```

---

### 🔹 Polymorphism — Same Method, Different Behavior

```python
class Server:
    def restart(self):
        print("Restarting generic server")

class WebServer(Server):
    def restart(self):
        print("Gracefully restarting Nginx...")

class DatabaseServer(Server):
    def restart(self):
        print("Restarting PostgreSQL — waiting for transactions...")

class CacheServer(Server):
    def restart(self):
        print("Restarting Redis — cache warm-up needed...")

# Same method name, different behavior
servers = [WebServer(), DatabaseServer(), CacheServer()]

for server in servers:
    server.restart()    # each calls its OWN restart()

# Output:
# Gracefully restarting Nginx...
# Restarting PostgreSQL — waiting for transactions...
# Restarting Redis — cache warm-up needed...
```

---

### 🔹 Abstraction — Hide Complexity

```python
from abc import ABC, abstractmethod

class CloudProvider(ABC):
    # Abstract class — cannot be instantiated directly

    @abstractmethod
    def create_instance(self, instance_type):
        pass   # every child MUST implement this

class AWSProvider(CloudProvider):
    def create_instance(self, instance_type):
        print(f"AWS: Launching EC2 — {instance_type}")

class AzureProvider(CloudProvider):
    def create_instance(self, instance_type):
        print(f"Azure: Creating VM — {instance_type}")

# ✅ Concrete classes work
aws   = AWSProvider()
azure = AzureProvider()
aws.create_instance("t3.large")
azure.create_instance("Standard_D2s_v3")

# ❌ Abstract class cannot be instantiated
# cloud = CloudProvider()
# TypeError: Can't instantiate abstract class
```

---

### 🔹 Composition — Combining Multiple Classes

```python
class Logger:
    def log(self, message):
        print(f"LOG: {message}")

class Deployment:

    def __init__(self, app_name):
        self.app_name = app_name
        self.logger   = Logger()    # using Logger class inside Deployment

    def deploy(self):
        self.logger.log(f"Deploying {self.app_name}")
        print(f"Deploying {self.app_name}...")

d = Deployment("flask-app")
d.deploy()
# Output:
# LOG: Deploying flask-app
# Deploying flask-app...
```

---

### 🔹 Class Variables vs Instance Variables

```python
class Server:
    region = "ap-south-1"    # CLASS variable — shared by ALL objects

    def __init__(self, name):
        self.name = name     # INSTANCE variable — unique per object

s1 = Server("web-server-01")
s2 = Server("db-server-01")

print(s1.name)     # web-server-01
print(s2.name)     # db-server-01
print(s1.region)   # ap-south-1 — same for all
print(s2.region)   # ap-south-1 — same for all
```

> **Interview Tip 🎯:**
> - **Class variable** → declared inside class but outside functions → shared by all objects
> - **Instance variable** → declared inside `__init__` → unique per object

---

### 🔹 Magic Methods

```python
class Server:

    def __init__(self, name, services):
        self.name     = name
        self.services = services    # list of services

    def __str__(self):
        # called when you print() the object
        return f"Server({self.name}) with {len(self.services)} services"

    def __len__(self):
        # called when you use len() on the object
        return len(self.services)

server = Server("web-prod-01", ["nginx", "nodejs", "redis"])

print(server)        # Server(web-prod-01) with 3 services
print(len(server))   # 3
```

---

## 9. Advanced Topics

### 🔹 Iterators — Traverse Elements One at a Time

```python
# Convert list to iterator
servers    = [10, 20, 30, 40]
server_itr = iter(servers)    # iter() converts to iterator

print(next(server_itr))    # 10 — first element
print(next(server_itr))    # 20
print(next(server_itr))    # 30
print(next(server_itr))    # 40
# print(next(server_itr))  # ❌ StopIteration — no more elements
```

---

### 🔹 Generators — Memory-Efficient with `yield`

A generator uses `yield` instead of `return` — produces **one value at a time**, saves memory:

```python
# Generator function
def get_servers(count):
    for i in range(1, count + 1):
        yield f"server-{i:03d}"    # yield pauses here, resumes on next()

# Use the generator
for server in get_servers(3):
    print(f"Provisioning {server}")

# Output:
# Provisioning server-001
# Provisioning server-002
# Provisioning server-003
```

> **Interview Tip 🎯:** `yield` is used instead of `return` in generators. It saves memory — only one item is in memory at a time, unlike a list which loads everything.

---

### 🔹 Decorators — Add Functionality Without Modifying Function

A decorator **wraps a function** to add extra behavior (logging, timing):

```python
import time

# Define the decorator
def log_execution(func):
    def wrapper(*args, **kwargs):
        print(f"Running: {func.__name__}")
        result = func(*args, **kwargs)    # call original function
        print(f"Completed: {func.__name__}")
        return result
    return wrapper

# Apply decorator using @
@log_execution
def deploy_app():
    print("Deploying application...")

deploy_app()

# Output:
# Running: deploy_app
# Deploying application...
# Completed: deploy_app
```

---

### 🔹 Context Manager — `with` Statement

```python
# The 'with' statement automatically handles open/close
# Already covered in file handling — this is the context manager

with open("file.txt", "r") as f:
    content = f.read()
# file auto-closed here — even if error occurs

# Used for:
# - File operations
# - Database connections
# - Network connections
```

---

### 🔹 Regular Expressions — `re` Module

Used to **search, match, and manipulate text** (log files, config files):

```python
import re

# Find email in text
text = "Contact admin at admin@company.com for access"

email_pattern = r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b"
match = re.search(email_pattern, text)

if match:
    print(f"Email found: {match.group()}")    # admin@company.com

# Find all IP addresses in log
log = "Request from 192.168.1.100 and 10.0.0.5"
ip_pattern = r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"
ips = re.findall(ip_pattern, log)
print(f"IPs found: {ips}")    # ['192.168.1.100', '10.0.0.5']
```

---

### 🔹 Multi-threading — Run Tasks Concurrently

Use when tasks spend time **waiting** (network, API calls, file I/O):

```python
import threading
import time

def check_server(server_name):
    time.sleep(1)    # simulate network delay
    print(f"{server_name} — healthy")

servers = ["web-01", "web-02", "db-01", "cache-01"]

# Sequential — takes 4 seconds
# for s in servers:
#     check_server(s)

# Multi-threaded — takes ~1 second (all run at same time)
threads = []

for server in servers:
    t = threading.Thread(target=check_server, args=(server,))
    threads.append(t)
    t.start()

for t in threads:
    t.join()    # wait for all threads to finish

print("All servers checked!")
```

---

### 🔹 Multi-processing — True Parallel Execution

Use for **CPU-heavy tasks** — bypasses Python's GIL:

```python
from multiprocessing import Process
import time

def calculate_square(numbers):
    for n in numbers:
        time.sleep(1)    # simulate heavy CPU work
        print(f"Square of {n} is {n*n}")

def calculate_cube(numbers):
    for n in numbers:
        time.sleep(1)
        print(f"Cube of {n} is {n**3}")

nums = [1, 2, 3, 4, 5]

p1 = Process(target=calculate_square, args=(nums,))
p2 = Process(target=calculate_cube,   args=(nums,))

p1.start()
p2.start()

p1.join()    # wait for both to finish
p2.join()

print("Both processes completed!")
```

> **Interview Tip 🎯:**
> - **Multi-threading** → I/O-bound (network, file) — shared memory
> - **Multi-processing** → CPU-bound (calculations) — separate memory, bypasses GIL

---

### 🔹 argparse — Command-Line Arguments

```python
import argparse

parser = argparse.ArgumentParser(description="Deployment Script")
parser.add_argument("--env",     required=True,  help="dev / staging / prod")
parser.add_argument("--version", required=True,  help="App version")
parser.add_argument("--region",  default="us-east-1", help="AWS region")

args = parser.parse_args()

print(f"Deploying version {args.version} to {args.env} in {args.region}")
```

```bash
# Usage
python3 deploy.py --env prod --version 2.4.1
python3 deploy.py --env staging --version 2.4.1 --region ap-south-1
python3 deploy.py --help
```

---

### 🔹 Environment Variables

```python
import os

# Set env variable in terminal before running:
# export DB_PASSWORD="mysecretpass"

db_host = os.environ.get("DB_HOST",     "localhost")
db_pass = os.environ.get("DB_PASSWORD", "")
region  = os.environ.get("AWS_REGION",  "us-east-1")

if not db_pass:
    print("ERROR: DB_PASSWORD not set!")
else:
    print(f"Connecting to {db_host} in {region}")
```

```bash
# Set environment variable
export DB_PASSWORD="mysecretpass"
export DB_HOST="prod-db.company.com"
python3 script.py
```

---

### 🔹 Time Module — Delay and Timing

```python
import time

print("Starting backup...")
time.sleep(5)    # pause for 5 seconds
print("Backup completed")

# Measure execution time
start = time.time()
time.sleep(2)
end   = time.time()
print(f"Execution took: {end - start:.2f} seconds")
```

---

### 🔹 Schedule Module — Periodic Automation

```bash
pip install schedule
```

```python
import schedule
import time

def check_servers():
    print("Checking server health...")

def backup_database():
    print("Running database backup...")

# Schedule tasks
schedule.every(10).seconds.do(check_servers)
schedule.every(1).hours.do(backup_database)

print("Scheduler running — press Ctrl+C to stop")

while True:
    schedule.run_pending()
    time.sleep(1)
```

---

## 10. Simple Production Programs for Every Module

### 🏭 Program 1: OS Module — Server Disk Space Checker

```python
#!/usr/bin/env python3
"""
Script: disk_checker.py
Purpose: Check disk space on the server and alert if usage is high
Usage: python3 disk_checker.py
"""

import os
import subprocess

# ── Configuration ──
THRESHOLD_PERCENT = 80
LOG_DIR           = "/var/log"


def get_disk_usage():
    """Get disk usage using df command."""
    result = subprocess.run(
        ["df", "-h", "/"],
        capture_output=True,
        text=True
    )
    return result.stdout


def check_disk_percent():
    """Return disk usage % as integer."""
    result = subprocess.run(
        ["df", "/", "--output=pcent"],
        capture_output=True,
        text=True
    )
    lines   = result.stdout.strip().split("\n")
    percent = int(lines[1].replace("%", "").strip())
    return percent


def create_alert_log(percent):
    """Write alert to a log file."""
    os.makedirs(LOG_DIR, exist_ok=True)
    log_path = os.path.join(LOG_DIR, "disk_alerts.log")

    with open(log_path, "a") as f:
        f.write(f"ALERT: Disk usage at {percent}% — threshold is {THRESHOLD_PERCENT}%\n")

    print(f"Alert written to {log_path}")


def main():
    print("=" * 40)
    print("  Disk Space Checker")
    print("=" * 40)

    # Show full disk info
    print(get_disk_usage())

    # Check percentage
    usage = check_disk_percent()
    print(f"Current disk usage: {usage}%")

    if usage >= THRESHOLD_PERCENT:
        print(f"WARNING: Disk at {usage}% — threshold is {THRESHOLD_PERCENT}%!")
        create_alert_log(usage)
    else:
        print(f"OK: Disk usage is normal ({usage}%)")


if __name__ == "__main__":
    main()
```

```bash
python3 disk_checker.py
```

---

### 🏭 Program 2: SYS Module — Python Environment Info Script

```python
#!/usr/bin/env python3
"""
Script: env_info.py
Purpose: Print Python and system environment information
Usage:   python3 env_info.py
         python3 env_info.py web01 us-east-1
"""

import sys
import os


def show_python_info():
    """Display Python version and platform."""
    print("=" * 40)
    print("  Python Environment Info")
    print("=" * 40)
    print(f"Python Version : {sys.version}")
    print(f"Platform       : {sys.platform}")
    print(f"Executable     : {sys.executable}")


def show_command_args():
    """Display command-line arguments passed."""
    print("\n--- Command-Line Arguments ---")

    if len(sys.argv) < 2:
        print("No arguments passed.")
        print("Usage: python3 env_info.py <server> <region>")
        return

    print(f"Script Name : {sys.argv[0]}")

    if len(sys.argv) > 1:
        print(f"Server      : {sys.argv[1]}")

    if len(sys.argv) > 2:
        print(f"Region      : {sys.argv[2]}")


def check_config_file():
    """Check if a config file exists before proceeding."""
    config_path = "/etc/app/config.yml"

    if not os.path.exists(config_path):
        print(f"\nConfig file not found: {config_path}")
        print("Exiting with error code 1")
        sys.exit(1)
    else:
        print(f"\nConfig file found: {config_path}")


def main():
    show_python_info()
    show_command_args()
    check_config_file()


if __name__ == "__main__":
    main()
```

```bash
python3 env_info.py
python3 env_info.py web01 us-east-1
```

---

### 🏭 Program 3: Subprocess Module — Service Health Checker

```python
#!/usr/bin/env python3
"""
Script: service_checker.py
Purpose: Check status of Linux services and restart if stopped
Usage:   python3 service_checker.py
"""

import subprocess


# ── Services to monitor ──
SERVICES = ["nginx", "mysql", "redis-server"]


def is_service_active(service_name):
    """Check if a service is active using systemctl."""
    result = subprocess.run(
        ["systemctl", "is-active", service_name],
        capture_output=True,
        text=True
    )
    return result.stdout.strip() == "active"


def restart_service(service_name):
    """Restart a stopped service."""
    print(f"  Restarting {service_name}...")
    result = subprocess.run(
        ["sudo", "systemctl", "restart", service_name],
        capture_output=True,
        text=True
    )

    if result.returncode == 0:
        print(f"  {service_name} restarted successfully")
    else:
        print(f"  Failed to restart {service_name}: {result.stderr.strip()}")


def get_system_uptime():
    """Get system uptime."""
    output = subprocess.check_output("uptime", shell=True, text=True)
    return output.strip()


def main():
    print("=" * 40)
    print("  Service Health Checker")
    print("=" * 40)
    print(f"System Uptime: {get_system_uptime()}")
    print()

    for service in SERVICES:
        if is_service_active(service):
            print(f"[OK]      {service} is running")
        else:
            print(f"[STOPPED] {service} is NOT running")
            restart_service(service)

    print("\nService check completed.")


if __name__ == "__main__":
    main()
```

```bash
python3 service_checker.py
```

---

### 🏭 Program 4: Shutil Module — Backup Script

```python
#!/usr/bin/env python3
"""
Script: backup.py
Purpose: Backup a folder by copying it with a timestamp
Usage:   python3 backup.py
"""

import shutil
import os
from datetime import datetime


# ── Configuration ──
SOURCE_DIR  = "/etc/nginx"         # folder to backup
BACKUP_BASE = "/tmp/backups"       # where to store backups


def create_backup(source, backup_base):
    """Copy source directory to backup location with timestamp."""

    # Create backup directory if not exists
    os.makedirs(backup_base, exist_ok=True)

    # Generate timestamped backup folder name
    timestamp   = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dest = os.path.join(backup_base, f"nginx_backup_{timestamp}")

    try:
        shutil.copytree(source, backup_dest)
        print(f"Backup created: {backup_dest}")
        return backup_dest

    except FileNotFoundError:
        print(f"Source not found: {source}")
        return None

    except Exception as e:
        print(f"Backup failed: {e}")
        return None


def list_backups(backup_base):
    """List all existing backups."""
    print("\nExisting backups:")

    if not os.path.exists(backup_base):
        print("  No backups found")
        return

    backups = os.listdir(backup_base)

    if not backups:
        print("  No backups found")
    else:
        for b in sorted(backups):
            print(f"  {b}")


def delete_old_backup(backup_base, keep_count=3):
    """Keep only the last N backups, delete older ones."""
    if not os.path.exists(backup_base):
        return

    backups = sorted(os.listdir(backup_base))

    while len(backups) > keep_count:
        oldest      = os.path.join(backup_base, backups[0])
        shutil.rmtree(oldest)
        print(f"Deleted old backup: {backups[0]}")
        backups.pop(0)


def main():
    print("=" * 40)
    print("  Nginx Backup Script")
    print("=" * 40)

    # Step 1: Create backup
    result = create_backup(SOURCE_DIR, BACKUP_BASE)

    # Step 2: List all backups
    list_backups(BACKUP_BASE)

    # Step 3: Keep only last 3 backups
    delete_old_backup(BACKUP_BASE, keep_count=3)

    print("\nBackup process complete.")


if __name__ == "__main__":
    main()
```

```bash
python3 backup.py
```

---

### 🏭 Program 5: JSON Module — Config Reader & Writer

```python
#!/usr/bin/env python3
"""
Script: config_manager.py
Purpose: Read, update, and write server config in JSON format
Usage:   python3 config_manager.py
"""

import json
import os


CONFIG_FILE = "server_config.json"


def create_default_config():
    """Create a default config file if not exists."""
    default = {
        "app_name":    "web-frontend",
        "version":     "1.0.0",
        "servers":     ["web01", "web02"],
        "port":        8080,
        "environment": "staging",
        "debug":       False
    }

    with open(CONFIG_FILE, "w") as f:
        json.dump(default, f, indent=4)

    print(f"Default config created: {CONFIG_FILE}")


def read_config():
    """Read and return config from JSON file."""
    with open(CONFIG_FILE, "r") as f:
        config = json.load(f)
    return config


def update_config(key, value):
    """Update a specific key in the config."""
    config     = read_config()
    old_value  = config.get(key, "not found")
    config[key] = value

    with open(CONFIG_FILE, "w") as f:
        json.dump(config, f, indent=4)

    print(f"Updated '{key}': {old_value} → {value}")


def display_config(config):
    """Print config in readable format."""
    print("\n--- Current Config ---")
    for key, value in config.items():
        print(f"  {key:<15}: {value}")


def main():
    print("=" * 40)
    print("  Config Manager")
    print("=" * 40)

    # Create config if not exists
    if not os.path.exists(CONFIG_FILE):
        create_default_config()

    # Read and display
    config = read_config()
    display_config(config)

    # Update version and environment
    update_config("version",     "2.0.0")
    update_config("environment", "production")

    # Show updated config
    config = read_config()
    display_config(config)


if __name__ == "__main__":
    main()
```

```bash
python3 config_manager.py
```

---

### 🏭 Program 6: YAML Module — Kubernetes-Style Deploy Config Reader

```python
#!/usr/bin/env python3
"""
Script: yaml_deploy.py
Purpose: Read deployment YAML config and simulate a deployment
Usage:   python3 yaml_deploy.py
"""

import yaml
import os


YAML_FILE = "deployment.yaml"


def create_sample_yaml():
    """Create a sample deployment YAML."""
    config = {
        "app":         "nginx-frontend",
        "image":       "nginx:1.25",
        "environment": "production",
        "replicas":    3,
        "port":        80,
        "env_vars": {
            "APP_ENV":  "production",
            "LOG_LEVEL": "INFO"
        },
        "servers": ["web01", "web02", "web03"]
    }

    with open(YAML_FILE, "w") as f:
        yaml.dump(config, f, default_flow_style=False)

    print(f"Sample YAML created: {YAML_FILE}")


def read_yaml_config():
    """Read and return YAML config."""
    with open(YAML_FILE, "r") as f:
        config = yaml.safe_load(f)
    return config


def simulate_deployment(config):
    """Simulate deployment using config values."""
    print("\n--- Deployment Plan ---")
    print(f"App        : {config['app']}")
    print(f"Image      : {config['image']}")
    print(f"Environment: {config['environment']}")
    print(f"Replicas   : {config['replicas']}")
    print(f"Port       : {config['port']}")

    print("\n--- Deploying to servers ---")
    for server in config["servers"]:
        print(f"  Deploying {config['app']} to {server}...")

    print("\n--- Environment Variables ---")
    for key, val in config["env_vars"].items():
        print(f"  {key}={val}")

    print(f"\nDeployment complete — {config['replicas']} replicas running")


def main():
    print("=" * 40)
    print("  YAML Deploy Config Reader")
    print("=" * 40)

    # Create YAML if not exists
    if not os.path.exists(YAML_FILE):
        create_sample_yaml()

    # Read and simulate
    config = read_yaml_config()
    simulate_deployment(config)


if __name__ == "__main__":
    main()
```

```bash
pip install pyyaml
python3 yaml_deploy.py
```

---

### 🏭 Program 7: Datetime Module — Log File Archiver with Timestamps

```python
#!/usr/bin/env python3
"""
Script: log_archiver.py
Purpose: Create log files with timestamps and archive old ones
Usage:   python3 log_archiver.py
"""

import os
import shutil
from datetime import datetime, timedelta


LOG_DIR     = "./logs"
ARCHIVE_DIR = "./logs/archive"


def write_log(message):
    """Write a message to today's log file."""
    os.makedirs(LOG_DIR, exist_ok=True)

    today    = datetime.now().strftime("%Y-%m-%d")
    log_file = os.path.join(LOG_DIR, f"app_{today}.log")

    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    with open(log_file, "a") as f:
        f.write(f"{timestamp} - {message}\n")

    print(f"Logged: {message}")
    return log_file


def show_today_logs():
    """Print today's log file content."""
    today    = datetime.now().strftime("%Y-%m-%d")
    log_file = os.path.join(LOG_DIR, f"app_{today}.log")

    if not os.path.exists(log_file):
        print("No logs today yet")
        return

    print(f"\n--- Today's Logs ({today}) ---")
    with open(log_file, "r") as f:
        for line in f:
            print(f"  {line.strip()}")


def archive_old_logs(days_old=7):
    """Move logs older than N days to archive folder."""
    os.makedirs(ARCHIVE_DIR, exist_ok=True)

    cutoff = datetime.now() - timedelta(days=days_old)
    moved  = 0

    for filename in os.listdir(LOG_DIR):
        if not filename.endswith(".log"):
            continue

        filepath = os.path.join(LOG_DIR, filename)

        # Get file modification time
        file_time = datetime.fromtimestamp(os.path.getmtime(filepath))

        if file_time < cutoff:
            dest = os.path.join(ARCHIVE_DIR, filename)
            shutil.move(filepath, dest)
            print(f"Archived: {filename}")
            moved += 1

    print(f"Total archived: {moved} files")


def main():
    print("=" * 40)
    print("  Log Archiver")
    print("=" * 40)

    # Write some logs
    write_log("Server started successfully")
    write_log("Deployment completed — version 2.4.1")
    write_log("Health check passed")

    # Show today's logs
    show_today_logs()

    # Archive logs older than 7 days
    print("\n--- Archiving Old Logs ---")
    archive_old_logs(days_old=7)

    print("\nLog archiver finished.")


if __name__ == "__main__":
    main()
```

```bash
python3 log_archiver.py
```

---

### 🏭 Program 8: File Handling — Log Analyzer (Error Counter)

```python
#!/usr/bin/env python3
"""
Script: log_analyzer.py
Purpose: Analyze a log file and count errors, warnings, info
Usage:   python3 log_analyzer.py
"""

import os


LOG_FILE = "application.log"


def create_sample_log():
    """Create a sample log file for testing."""
    lines = [
        "2024-01-15 09:00:01 INFO  Server started",
        "2024-01-15 09:01:10 INFO  Request received from 10.0.0.1",
        "2024-01-15 09:02:05 WARNING CPU usage at 78%",
        "2024-01-15 09:03:20 ERROR Cannot connect to database",
        "2024-01-15 09:04:15 INFO  Health check passed",
        "2024-01-15 09:05:30 ERROR Disk usage at 95%",
        "2024-01-15 09:06:00 WARNING Memory usage at 82%",
        "2024-01-15 09:07:45 ERROR Connection timeout to 10.0.0.5",
        "2024-01-15 09:08:20 INFO  Deployment completed",
        "2024-01-15 09:09:00 ERROR Out of memory",
    ]

    with open(LOG_FILE, "w") as f:
        for line in lines:
            f.write(line + "\n")

    print(f"Sample log created: {LOG_FILE}")


def analyze_log(log_file):
    """Count log levels and collect error lines."""
    counts      = {"INFO": 0, "WARNING": 0, "ERROR": 0}
    error_lines = []

    with open(log_file, "r") as f:
        for line in f:
            if "ERROR" in line:
                counts["ERROR"] += 1
                error_lines.append(line.strip())
            elif "WARNING" in line:
                counts["WARNING"] += 1
            elif "INFO" in line:
                counts["INFO"] += 1

    return counts, error_lines


def print_report(counts, error_lines):
    """Print the analysis report."""
    total = sum(counts.values())

    print("\n--- Log Analysis Report ---")
    print(f"Total Lines : {total}")
    print(f"INFO        : {counts['INFO']}")
    print(f"WARNING     : {counts['WARNING']}")
    print(f"ERROR       : {counts['ERROR']}")

    if error_lines:
        print("\n--- Error Details ---")
        for line in error_lines:
            print(f"  {line}")


def save_report(counts, error_lines):
    """Save report to a file."""
    with open("log_report.txt", "w") as f:
        f.write("Log Analysis Report\n")
        f.write("=" * 40 + "\n")
        for level, count in counts.items():
            f.write(f"{level}: {count}\n")
        f.write("\nError Lines:\n")
        for line in error_lines:
            f.write(f"  {line}\n")

    print("\nReport saved to log_report.txt")


def main():
    print("=" * 40)
    print("  Log Analyzer")
    print("=" * 40)

    # Create sample log
    create_sample_log()

    # Analyze
    counts, error_lines = analyze_log(LOG_FILE)

    # Print report
    print_report(counts, error_lines)

    # Save to file
    save_report(counts, error_lines)


if __name__ == "__main__":
    main()
```

```bash
python3 log_analyzer.py
```

---

### 🏭 Program 9: Exception Handling — Safe File Reader with Retry

```python
#!/usr/bin/env python3
"""
Script: safe_reader.py
Purpose: Read a config file safely with proper exception handling
Usage:   python3 safe_reader.py
"""

import json
import os
import time


CONFIG_FILE = "app_config.json"


def read_config_safe(filepath):
    """Read JSON config file with full exception handling."""
    try:
        with open(filepath, "r") as f:
            config = json.load(f)

    except FileNotFoundError:
        print(f"ERROR: File not found — {filepath}")
        return None

    except json.JSONDecodeError as e:
        print(f"ERROR: Invalid JSON in {filepath}: {e}")
        return None

    except PermissionError:
        print(f"ERROR: Permission denied — {filepath}")
        return None

    else:
        # runs only when NO exception occurred
        print(f"Config loaded successfully from {filepath}")
        return config

    finally:
        # runs ALWAYS
        print("File read operation finished (finally block)")


def connect_with_retry(server_ip, max_retries=3, delay=2):
    """Simulate server connection with retry logic."""
    for attempt in range(1, max_retries + 1):
        try:
            print(f"Attempt {attempt}/{max_retries}: Connecting to {server_ip}")

            # Simulate failed connection on first two attempts
            if attempt < max_retries:
                raise ConnectionError("Connection refused")

            print(f"Connected to {server_ip} successfully!")
            return True

        except ConnectionError as e:
            print(f"  Failed: {e}")
            if attempt < max_retries:
                print(f"  Waiting {delay}s before retry...")
                time.sleep(delay)

    print(f"All {max_retries} attempts failed for {server_ip}")
    return False


def validate_version(version):
    """Validate version number using custom exception."""
    class InvalidVersionError(Exception):
        pass

    try:
        if float(version) < 1.0:
            raise InvalidVersionError(
                f"Version {version} is too old. Minimum is 1.0"
            )
        print(f"Version {version} is valid")

    except InvalidVersionError as e:
        print(f"Version Error: {e}")

    except ValueError:
        print(f"Invalid format: '{version}' is not a valid version number")


def main():
    print("=" * 40)
    print("  Safe File Reader Demo")
    print("=" * 40)

    # Test 1: Read missing file
    print("\n[Test 1] Read missing file:")
    result = read_config_safe("missing.json")
    print(f"Result: {result}")

    # Test 2: Create and read valid config
    print("\n[Test 2] Read valid config:")
    sample = {"app": "myapp", "version": "2.0", "env": "prod"}
    with open(CONFIG_FILE, "w") as f:
        json.dump(sample, f)
    config = read_config_safe(CONFIG_FILE)
    if config:
        print(f"App: {config['app']}, Env: {config['env']}")

    # Test 3: Retry logic
    print("\n[Test 3] Connection retry:")
    connect_with_retry("10.0.1.50", max_retries=3, delay=1)

    # Test 4: Custom exception
    print("\n[Test 4] Version validation:")
    validate_version("0.5")
    validate_version("2.4")
    validate_version("abc")


if __name__ == "__main__":
    main()
```

```bash
python3 safe_reader.py
```

---

### 🏭 Program 10: OOP — Server Management System

```python
#!/usr/bin/env python3
"""
Script: server_manager.py
Purpose: Simple server management using OOP (Class, Inheritance, Encapsulation)
Usage:   python3 server_manager.py
"""


# ── Base Server Class ──
class Server:

    # Class variable — shared by ALL server objects
    data_center = "DC-Mumbai"

    def __init__(self, name, ip, server_type):
        self.name        = name
        self.ip          = ip
        self.server_type = server_type
        self.__status    = "stopped"    # private variable

    def start(self):
        self.__status = "running"
        print(f"[START] {self.name} ({self.ip}) is now running")

    def stop(self):
        self.__status = "stopped"
        print(f"[STOP]  {self.name} ({self.ip}) has stopped")

    def get_status(self):
        # public method to access private variable
        return self.__status

    def show_info(self):
        print(f"  Name   : {self.name}")
        print(f"  IP     : {self.ip}")
        print(f"  Type   : {self.server_type}")
        print(f"  Status : {self.get_status()}")
        print(f"  DC     : {self.data_center}")

    def __str__(self):
        return f"Server({self.name}, {self.ip}, {self.get_status()})"


# ── Web Server — inherits from Server ──
class WebServer(Server):

    def __init__(self, name, ip, domain):
        super().__init__(name, ip, "web")
        self.domain = domain

    def deploy(self, app_name, version):
        print(f"[DEPLOY] {app_name} v{version} → {self.domain}")

    def show_info(self):
        super().show_info()    # call parent show_info
        print(f"  Domain : {self.domain}")


# ── Database Server — inherits from Server ──
class DatabaseServer(Server):

    def __init__(self, name, ip, db_type):
        super().__init__(name, ip, "database")
        self.db_type = db_type

    def backup(self):
        print(f"[BACKUP] Running {self.db_type} backup on {self.name}")

    def show_info(self):
        super().show_info()
        print(f"  DB Type: {self.db_type}")


# ── Simple Fleet Manager ──
class ServerFleet:

    def __init__(self):
        self.servers = []

    def add_server(self, server):
        self.servers.append(server)
        print(f"Added to fleet: {server.name}")

    def start_all(self):
        print("\n--- Starting all servers ---")
        for s in self.servers:
            s.start()

    def stop_all(self):
        print("\n--- Stopping all servers ---")
        for s in self.servers:
            s.stop()

    def show_all(self):
        print("\n--- Fleet Status ---")
        for s in self.servers:
            print(s)    # calls __str__

    def get_running(self):
        return [s for s in self.servers if s.get_status() == "running"]


def main():
    print("=" * 40)
    print("  Server Management System")
    print("=" * 40)

    # Create servers
    web1 = WebServer("nginx-prod-01", "10.0.1.10", "app.example.com")
    web2 = WebServer("nginx-prod-02", "10.0.1.11", "api.example.com")
    db1  = DatabaseServer("mysql-prod-01", "10.0.2.10", "MySQL")

    # Show info
    print("\n--- Web Server Info ---")
    web1.show_info()

    print("\n--- DB Server Info ---")
    db1.show_info()

    # Use fleet
    fleet = ServerFleet()
    fleet.add_server(web1)
    fleet.add_server(web2)
    fleet.add_server(db1)

    # Start all
    fleet.start_all()

    # Show status
    fleet.show_all()

    # Deploy and backup
    print("\n--- Operations ---")
    web1.deploy("frontend", "2.4.1")
    db1.backup()

    # Get running servers
    running = fleet.get_running()
    print(f"\nRunning servers: {len(running)}")
    for s in running:
        print(f"  {s.name} — {s.ip}")

    # Stop all
    fleet.stop_all()
    fleet.show_all()


if __name__ == "__main__":
    main()
```

```bash
python3 server_manager.py
```

---

### 🏭 Program 11: Multi-threading — Parallel Server Health Check

```python
#!/usr/bin/env python3
"""
Script: parallel_health_check.py
Purpose: Check multiple servers at the same time using threading
Usage:   python3 parallel_health_check.py
"""

import threading
import time


# ── Server list to monitor ──
SERVERS = [
    "web-01",
    "web-02",
    "db-01",
    "cache-01",
    "lb-01"
]


def check_server_health(server_name):
    """Simulate a health check (like ping or HTTP check)."""
    print(f"  Checking {server_name}...")
    time.sleep(1)    # simulate network delay
    print(f"  {server_name} — OK")


def run_sequential(servers):
    """Check servers one by one (slow)."""
    print("\n[Sequential Check]")
    start = time.time()

    for server in servers:
        check_server_health(server)

    end = time.time()
    print(f"Sequential time: {end - start:.1f}s")


def run_parallel(servers):
    """Check all servers at the same time (fast)."""
    print("\n[Parallel Check using Threads]")
    start = time.time()

    threads = []

    for server in servers:
        t = threading.Thread(target=check_server_health, args=(server,))
        threads.append(t)
        t.start()    # start thread

    for t in threads:
        t.join()     # wait for all threads to finish

    end = time.time()
    print(f"Parallel time  : {end - start:.1f}s")


def main():
    print("=" * 40)
    print("  Parallel Health Checker")
    print("=" * 40)

    # Run sequential — shows the slow way
    run_sequential(SERVERS)

    # Run parallel — shows the fast way
    run_parallel(SERVERS)

    print("\nBoth methods complete — parallel is much faster!")


if __name__ == "__main__":
    main()
```

```bash
python3 parallel_health_check.py
```

---

### 🏭 Program 12: Multi-processing — Parallel Log Processing

```python
#!/usr/bin/env python3
"""
Script: parallel_log_processor.py
Purpose: Process multiple log files in parallel using multiprocessing
Usage:   python3 parallel_log_processor.py
"""

import os
import time
from multiprocessing import Process


LOG_DIR = "./sample_logs"


def create_sample_logs():
    """Create sample log files for testing."""
    os.makedirs(LOG_DIR, exist_ok=True)

    log_data = {
        "access.log":   ["INFO GET /home", "ERROR 404 /missing", "INFO GET /api"],
        "error.log":    ["ERROR DB timeout", "ERROR disk full", "WARNING high CPU"],
        "security.log": ["INFO login user1", "ERROR failed login user2", "INFO logout user1"],
        "app.log":      ["INFO app started", "ERROR null pointer", "INFO request ok"],
    }

    for filename, lines in log_data.items():
        filepath = os.path.join(LOG_DIR, filename)
        with open(filepath, "w") as f:
            for line in lines:
                f.write(line + "\n")

    print(f"Sample logs created in {LOG_DIR}/")


def process_single_log(log_file):
    """Count errors in a single log file."""
    print(f"[Process] Processing {log_file}...")
    time.sleep(1)    # simulate heavy processing

    error_count = 0

    with open(log_file, "r") as f:
        for line in f:
            if "ERROR" in line:
                error_count += 1

    print(f"[Process] {os.path.basename(log_file)} — {error_count} errors found")


def main():
    print("=" * 40)
    print("  Parallel Log Processor")
    print("=" * 40)

    # Create sample logs
    create_sample_logs()

    # Get all log files
    log_files = [
        os.path.join(LOG_DIR, f)
        for f in os.listdir(LOG_DIR)
        if f.endswith(".log")
    ]

    print(f"\nFound {len(log_files)} log files")

    # Run all log processing in parallel
    start     = time.time()
    processes = []

    for log_file in log_files:
        p = Process(target=process_single_log, args=(log_file,))
        processes.append(p)
        p.start()

    for p in processes:
        p.join()    # wait for all processes

    end = time.time()
    print(f"\nAll logs processed in {end - start:.1f}s")


if __name__ == "__main__":
    main()
```

```bash
python3 parallel_log_processor.py
```

---

### 🏭 Program 13: argparse — Deployment Script with CLI Arguments

```python
#!/usr/bin/env python3
"""
Script: deploy.py
Purpose: Deploy application with arguments from command line
Usage:   python3 deploy.py --env prod --version 2.4.1
         python3 deploy.py --env staging --version 2.0.0 --region ap-south-1
"""

import argparse
import os


def parse_arguments():
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser(
        description="Simple Application Deployment Script"
    )

    parser.add_argument(
        "--env",
        required=True,
        choices=["dev", "staging", "prod"],
        help="Target environment"
    )

    parser.add_argument(
        "--version",
        required=True,
        help="Application version (e.g., 2.4.1)"
    )

    parser.add_argument(
        "--region",
        default="us-east-1",
        help="Deployment region (default: us-east-1)"
    )

    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Show what would happen without actually deploying"
    )

    return parser.parse_args()


def run_deployment(env, version, region, dry_run):
    """Execute the deployment."""
    print("=" * 40)
    print("  Deployment Plan")
    print("=" * 40)
    print(f"Environment : {env}")
    print(f"Version     : {version}")
    print(f"Region      : {region}")
    print(f"Dry Run     : {dry_run}")
    print()

    steps = [
        "Pull latest Docker image",
        "Stop existing containers",
        "Start new containers",
        "Run health check",
        "Update load balancer"
    ]

    for i, step in enumerate(steps, 1):
        if dry_run:
            print(f"[DRY RUN] Step {i}: {step}")
        else:
            print(f"[RUNNING] Step {i}: {step}")

    if dry_run:
        print("\nDry run complete — no changes made")
    else:
        print(f"\nDeployment complete — v{version} is live in {env}!")


def main():
    args = parse_arguments()
    run_deployment(args.env, args.version, args.region, args.dry_run)


if __name__ == "__main__":
    main()
```

```bash
# Deploy to staging
python3 deploy.py --env staging --version 2.4.1

# Deploy to prod in a specific region
python3 deploy.py --env prod --version 2.4.1 --region ap-south-1

# Dry run — see what would happen
python3 deploy.py --env prod --version 2.4.1 --dry-run

# Show help
python3 deploy.py --help
```

---

### 🏭 Program 14: Environment Variables — Secrets Manager

```python
#!/usr/bin/env python3
"""
Script: env_secrets.py
Purpose: Read sensitive config from environment variables safely
Usage:
    export DB_HOST=prod-db.company.com
    export DB_PASSWORD=mysecretpass
    export AWS_REGION=us-east-1
    python3 env_secrets.py
"""

import os


def load_config():
    """Load all required config from environment variables."""
    config = {
        "db_host":     os.environ.get("DB_HOST",     "localhost"),
        "db_port":     os.environ.get("DB_PORT",     "5432"),
        "db_name":     os.environ.get("DB_NAME",     "appdb"),
        "db_user":     os.environ.get("DB_USER",     "admin"),
        "db_password": os.environ.get("DB_PASSWORD", ""),
        "aws_region":  os.environ.get("AWS_REGION",  "us-east-1"),
        "app_env":     os.environ.get("APP_ENV",     "development"),
    }
    return config


def validate_config(config):
    """Check all required values are present."""
    required = ["db_password"]
    missing  = []

    for key in required:
        if not config[key]:
            missing.append(key.upper())

    return missing


def connect_to_db(config):
    """Simulate DB connection using config."""
    print(f"Connecting to DB: {config['db_user']}@{config['db_host']}:{config['db_port']}/{config['db_name']}")
    print("Connection successful!")


def main():
    print("=" * 40)
    print("  Environment Variable Manager")
    print("=" * 40)

    # Load config
    config = load_config()

    # Show config (mask password)
    print("\n--- Loaded Config ---")
    for key, val in config.items():
        if "password" in key.lower():
            display = "***" if val else "(NOT SET)"
        else:
            display = val
        print(f"  {key:<15}: {display}")

    # Validate
    missing = validate_config(config)

    if missing:
        print(f"\nERROR: Missing required env variables: {', '.join(missing)}")
        print("Set them with: export DB_PASSWORD=yourpassword")
        return

    # Connect
    print("\n--- Connecting ---")
    connect_to_db(config)

    print(f"\nRunning in: {config['app_env']} environment")


if __name__ == "__main__":
    main()
```

```bash
# Set env vars
export DB_PASSWORD="mysecretpass"
export DB_HOST="prod-db.company.com"
export APP_ENV="production"

python3 env_secrets.py
```

---

### 🏭 Program 15: Schedule Module — Automated Monitoring Script

```python
#!/usr/bin/env python3
"""
Script: scheduler_monitor.py
Purpose: Schedule periodic monitoring tasks using the schedule module
Usage:   python3 scheduler_monitor.py
         pip install schedule
"""

import schedule
import time
import os
from datetime import datetime


def get_timestamp():
    """Return current time as string."""
    return datetime.now().strftime("%H:%M:%S")


def check_server_health():
    """Simulate server health check every 10 seconds."""
    print(f"[{get_timestamp()}] Checking server health...")
    # In real scripts: ping servers, check HTTP endpoints
    print(f"[{get_timestamp()}] All servers are healthy")


def check_disk_space():
    """Check disk space every 30 seconds."""
    print(f"[{get_timestamp()}] Checking disk space...")
    # In real scripts: use subprocess to run df -h
    print(f"[{get_timestamp()}] Disk space is OK")


def backup_config():
    """Backup config files every minute."""
    print(f"[{get_timestamp()}] Running config backup...")
    # In real scripts: use shutil.copy to backup config files
    print(f"[{get_timestamp()}] Config backup complete")


def send_daily_report():
    """Send daily report (runs once per day at 08:00)."""
    print(f"[{get_timestamp()}] Sending daily report...")
    # In real scripts: send email or Slack message
    print(f"[{get_timestamp()}] Daily report sent")


def main():
    print("=" * 40)
    print("  Automated Monitoring Scheduler")
    print("=" * 40)
    print("Press Ctrl+C to stop\n")

    # ── Schedule all tasks ──
    schedule.every(10).seconds.do(check_server_health)
    schedule.every(30).seconds.do(check_disk_space)
    schedule.every(1).minutes.do(backup_config)
    schedule.every().day.at("08:00").do(send_daily_report)

    # ── Run loop ──
    while True:
        try:
            schedule.run_pending()
            time.sleep(1)

        except KeyboardInterrupt:
            print("\nScheduler stopped by user")
            break


if __name__ == "__main__":
    main()
```

```bash
pip install schedule
python3 scheduler_monitor.py
```

---

### 🏭 Program 16: Regular Expressions — Log Parser

```python
#!/usr/bin/env python3
"""
Script: log_parser.py
Purpose: Parse log file using regex to extract IPs, emails, errors
Usage:   python3 log_parser.py
"""

import re
import os


LOG_FILE = "nginx_access.log"


def create_sample_log():
    """Create sample Nginx-style access log."""
    log_lines = [
        '192.168.1.100 - admin [15/Jan/2024] "GET /home HTTP/1.1" 200',
        '10.0.0.5 - - [15/Jan/2024] "POST /login HTTP/1.1" 401',
        '172.16.0.20 - devops [15/Jan/2024] "GET /dashboard HTTP/1.1" 200',
        '192.168.1.100 - - [15/Jan/2024] "GET /missing HTTP/1.1" 404',
        '10.0.0.8 - root [15/Jan/2024] "DELETE /api/v1 HTTP/1.1" 500',
        'Contact: admin@company.com for access issues',
        'Backup sent to ops@devops.org',
    ]

    with open(LOG_FILE, "w") as f:
        for line in log_lines:
            f.write(line + "\n")

    print(f"Sample log created: {LOG_FILE}")


def extract_ips(log_content):
    """Find all IP addresses in the log."""
    pattern = r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"
    ips     = re.findall(pattern, log_content)
    return list(set(ips))    # unique IPs only


def extract_emails(log_content):
    """Find all email addresses in the log."""
    pattern = r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b"
    emails  = re.findall(pattern, log_content)
    return emails


def extract_error_codes(log_content):
    """Find lines with HTTP 4xx and 5xx error codes."""
    pattern     = r".+(4\d\d|5\d\d).*"
    error_lines = re.findall(pattern, log_content)
    return error_lines


def extract_status_codes(log_content):
    """Count HTTP status codes."""
    pattern = r'"[A-Z]+ .+?" (\d{3})'
    codes   = re.findall(pattern, log_content)

    count = {}
    for code in codes:
        count[code] = count.get(code, 0) + 1

    return count


def main():
    print("=" * 40)
    print("  Log Parser with Regex")
    print("=" * 40)

    # Create sample log
    create_sample_log()

    # Read log file
    with open(LOG_FILE, "r") as f:
        content = f.read()

    # Extract IPs
    ips = extract_ips(content)
    print(f"\n--- Unique IP Addresses ({len(ips)}) ---")
    for ip in ips:
        print(f"  {ip}")

    # Extract emails
    emails = extract_emails(content)
    print(f"\n--- Email Addresses ({len(emails)}) ---")
    for email in emails:
        print(f"  {email}")

    # Status code summary
    codes = extract_status_codes(content)
    print(f"\n--- HTTP Status Code Summary ---")
    for code, count in sorted(codes.items()):
        print(f"  {code}: {count} requests")


if __name__ == "__main__":
    main()
```

```bash
python3 log_parser.py
```

---

### 🏭 Program 17: Generators & Decorators — DevOps Pipeline

```python
#!/usr/bin/env python3
"""
Script: generators_decorators.py
Purpose: Show generators (yield) and decorators in a simple DevOps context
Usage:   python3 generators_decorators.py
"""

import time


# ── DECORATOR — logs execution of any function ──
def log_step(func):
    """Decorator: prints when a step starts and finishes."""
    def wrapper(*args, **kwargs):
        print(f"  --> Starting: {func.__name__}")
        result = func(*args, **kwargs)
        print(f"  --> Done:     {func.__name__}")
        return result
    return wrapper


# ── Apply decorator to deployment steps ──
@log_step
def pull_docker_image():
    print("     Pulling latest docker image...")
    time.sleep(0.5)

@log_step
def run_tests():
    print("     Running unit tests...")
    time.sleep(0.5)

@log_step
def deploy_containers():
    print("     Starting containers...")
    time.sleep(0.5)


# ── GENERATOR — yield server list one by one ──
def server_generator(count):
    """Generate server names one at a time — memory efficient."""
    for i in range(1, count + 1):
        yield f"server-{i:03d}"


# ── GENERATOR — read log lines one by one (efficient for huge files) ──
def read_log_lines(filepath):
    """Yield each line from a log file one at a time."""
    with open(filepath, "r") as f:
        for line in f:
            yield line.strip()


def run_pipeline():
    """Run a simple deployment pipeline using decorators."""
    print("\n--- Running Deployment Pipeline ---")
    pull_docker_image()
    run_tests()
    deploy_containers()
    print("Pipeline complete!\n")


def show_generator_demo():
    """Show generator usage."""
    print("--- Server Generator Demo ---")

    # Generator produces one item at a time
    gen = server_generator(5)

    for server in gen:
        print(f"  Provisioning: {server}")


def main():
    print("=" * 40)
    print("  Generators & Decorators Demo")
    print("=" * 40)

    # Run pipeline (uses decorators)
    run_pipeline()

    # Show generator
    show_generator_demo()


if __name__ == "__main__":
    main()
```

```bash
python3 generators_decorators.py
```

---

## 📌 Quick Reference Summary

### All Modules Covered

| Module       | Purpose                          | Simple Production Use                |
|--------------|----------------------------------|--------------------------------------|
| `os`         | OS interaction                   | File/directory ops, env vars         |
| `sys`        | System parameters                | CLI args, exit codes, Python version |
| `subprocess` | Run shell commands               | systemctl, df, ping, uptime          |
| `shutil`     | High-level file ops              | Backup, copy, move, delete folders   |
| `json`       | JSON read/write                  | Config files, API responses          |
| `yaml`       | YAML read/write                  | Kubernetes, Ansible configs          |
| `datetime`   | Date and time ops                | Log timestamps, file naming          |
| `csv`        | CSV read/write                   | Server inventories, reports          |
| `re`         | Regular expressions              | Log parsing, IP/email extraction     |
| `logging`    | Structured logging               | Error logs, audit trails             |
| `threading`  | Concurrent I/O tasks             | Parallel health checks, API calls    |
| `multiprocessing` | Parallel CPU tasks          | Parallel log processing              |
| `argparse`   | CLI argument parsing             | Deployment scripts, tool flags       |
| `schedule`   | Task scheduling                  | Periodic monitoring, backups         |
| `time`       | Time delays and measurement      | Retry delays, execution timing       |
| `abc`        | Abstract base classes            | Cloud provider interfaces            |

### Common Mistakes & Fixes 🔴

| Mistake                                        | Fix                                            |
|------------------------------------------------|------------------------------------------------|
| Using `print()` in production scripts          | Use `logging` module instead                   |
| Hardcoding passwords in code                   | Use `os.environ.get()` for all secrets         |
| Not using `with open()` for files              | Always use `with open()` — auto-closes file    |
| `yaml.load()` instead of `yaml.safe_load()`   | Always use `yaml.safe_load()` — safer          |
| `shell=True` with subprocess + user input      | Pass commands as a list to subprocess          |
| No exception handling in automation scripts    | Wrap all file/network ops in try/except        |
| Forgetting increment in while loop             | Always add `count += 1` — prevents infinite loop |
| Modifying list while looping                   | Loop over `list.copy()` instead                |

### Interview Quick-Fire Answers 🎯

| Question                              | Answer                                                                    |
|---------------------------------------|---------------------------------------------------------------------------|
| List vs Tuple?                        | List = mutable (can change); Tuple = immutable (cannot change)            |
| Set properties?                       | Unordered + Unique (no duplicates)                                        |
| What is `__init__`?                   | Constructor — auto-called when object is created                          |
| `*args` vs `**kwargs`?                | `*args` = extra positional args (tuple); `**kwargs` = keyword args (dict) |
| `yield` vs `return`?                  | `return` exits function; `yield` pauses and resumes (generator)           |
| Threading vs Multiprocessing?         | Threading = I/O-bound; Multiprocessing = CPU-bound (no GIL)               |
| What does `finally` do?               | Runs ALWAYS — even if exception occurs — used for cleanup                 |
| Why use decorators?                   | Add functionality (logging, retry) without modifying the original function|
| What is encapsulation?                | Hiding internal details using private methods/variables (`__`)            |
| How to store secrets safely?          | `os.environ.get()` — never hardcode in scripts                            |
| Difference: `else` vs `finally`?      | `else` = runs only when NO exception; `finally` = runs ALWAYS             |
| What is a generator?                  | Function using `yield` — produces one value at a time, saves memory       |

---

> 💡 **Final Advice from the Instructor:**
> Python is a **practice-first** language. Write every example by hand, modify it, break it intentionally, then fix it. Practice questions based on these concepts especially:
> - Exception handling with retry logic
> - OOP with class and inheritance
> - File handling (read/write/append)
> - JSON/YAML parsing for configs
> - Working with os, subprocess, and argparse modules
>
> These are the most asked topics in DevOps Python interviews. Subscribe to the channel for more DevOps and Cloud content!
