# 🐍 Python for DevOps — Complete Notes (Beginner to Advanced)

---

## 📋 Table of Contents

1. [Introduction to Python for DevOps](#1-introduction-to-python-for-devops)
2. [Python Setup & Installation](#2-python-setup--installation)
3. [Variables & Data Types](#3-variables--data-types)
4. [Input & Output](#4-input--output)
5. [Type Conversion (Type Casting)](#5-type-conversion-type-casting)
6. [Comments & Documentation](#6-comments--documentation)
7. [Operators](#7-operators)
8. [String Operations](#8-string-operations)
9. [Control Flow — Conditional Statements](#9-control-flow--conditional-statements)
10. [Control Flow — Loops](#10-control-flow--loops)
11. [Loop Control Statements](#11-loop-control-statements)
12. [Data Structures](#12-data-structures)
13. [Functions](#13-functions)
14. [Modules & Packages](#14-modules--packages)
15. [File Handling](#15-file-handling)
16. [Exception Handling](#16-exception-handling)
17. [OOP Concepts](#17-oop-concepts)
18. [Advanced Python Topics](#18-advanced-python-topics)

---

## 1. Introduction to Python for DevOps

### 🔍 What is Python?
Python is a **high-level, interpreted, object-oriented programming language** widely used in DevOps for:
- ✅ Automation of repetitive tasks
- ✅ Infrastructure management
- ✅ CI/CD pipeline scripting
- ✅ Cloud operations (AWS, GCP, Azure)
- ✅ API integrations
- ✅ Log analysis and monitoring
- ✅ Working with JSON/YAML config files

### 💡 Why Python in DevOps?
| Feature | Benefit |
|--------|---------|
| Simple, English-like syntax | Easy to write and read scripts |
| Rich libraries (boto3, paramiko, requests) | Direct AWS, SSH, HTTP integrations |
| Cross-platform | Works on Linux, Mac, Windows |
| Large community | Tons of DevOps-ready tools |
| AI/ML support | Future-proof language |

### 🎯 Interview Tip
> *"Python is preferred in DevOps because of its simplicity, rich ecosystem, and strong library support for infrastructure automation, cloud APIs, and configuration management."*

---

## 2. Python Setup & Installation

### 🐧 Linux (Ubuntu/Debian)
```bash
sudo apt install python3
python3 --version        # Verify installation
```

### 🪟 Windows
Download from [python.org](https://python.org) and install.

### ▶️ Running a Python Script
```bash
python3 script.py
```

### Running with Shebang (Linux-style execution)
```python
#!/usr/bin/env python3
print("Script executed successfully")
```
```bash
chmod +x script.py
./script.py
```

---

## 3. Variables & Data Types

### 🔍 What are Variables?
Variables are **containers for storing data**. Think of them as labeled boxes where you put your data.

```python
name    = "das"         # String
age     = 25            # Integer
salary  = 80000.0       # Float
is_devops = True        # Boolean
```

### 📦 Python Data Types

| Data Type  | Example | Written As | Properties |
|-----------|---------|-----------|-----------|
| `int` | `10` | `x = 10` | Whole numbers |
| `float` | `10.5` | `x = 10.5` | Decimal numbers |
| `str` | `"hello"` | `x = "hello"` | Text/strings |
| `bool` | `True/False` | `x = True` | Boolean values |
| `list` | `[1,2,3]` | `x = [1,2,3]` | Ordered, Mutable |
| `tuple` | `(1,2,3)` | `x = (1,2,3)` | Ordered, Immutable |
| `set` | `{1,2,3}` | `x = {1,2,3}` | Unordered, Unique |
| `dict` | `{"k":"v"}` | `x = {"k":"v"}` | Key-Value pairs |

### 🧠 Remember These Key Differences

```
List   → [ ] → Ordered + Mutable (can change values)
Tuple  → ( ) → Ordered + Immutable (cannot change values)
Set    → { } → Unordered + Unique (no duplicates)
Dict   → { } with key:value → Key-Value pairs
```

### ⚠️ Common Mistake
> Beginners confuse **set** and **dict** — both use `{}`. The difference is that **dict has key-value pairs**, while **set has just values**.

```python
my_set  = {1, 2, 3}           # This is a SET
my_dict = {"name": "das"}     # This is a DICT (has key:value)
```

---

## 4. Input & Output

### 📥 Taking Input from User

```python
server_name = input("Enter the server name: ")
print(f"Connecting to {server_name}, please wait...")
```

### 📤 Output Formatting (F-Strings) — ⭐ Important!

```python
tool    = "Ansible"
version = "2.15"

# ❌ Wrong — variable won't be resolved
print("Tool is tool")                         # Prints literally "tool"

# ✅ Correct — use f-string formatting
print(f"{tool} version {version} is ready")   # Prints: Ansible version 2.15 is ready
```

### 💡 Why F-strings in DevOps?
When printing server names, IP addresses, or status messages dynamically in scripts:

```python
server  = "web01"
status  = "running"
ip      = "192.168.1.10"

print(f"Server: {server} | IP: {ip} | Status: {status}")
# Output: Server: web01 | IP: 192.168.1.10 | Status: running
```

---

## 5. Type Conversion (Type Casting)

### 🔍 What is Type Conversion?
Converting a value from **one data type to another**.

### Type 1: Implicit Conversion (Automatic by Python)

```python
a = 10        # int
b = 5.5       # float

c = a + b     # Python auto-converts int → float
print(c)      # 15.5
print(type(c))  # <class 'float'>
```

### Type 2: Explicit Conversion (Manual — Type Casting)

```python
# String → Integer
port_str = "8080"
port_int = int(port_str)
print(type(port_int))   # <class 'int'>

# Integer → Float
x = 10
y = float(x)            # 10.0

# Integer → String
num = 50
s   = str(num)          # "50"

# List → Tuple
tools_list  = ["docker", "jenkins", "ansible"]
tools_tuple = tuple(tools_list)
print(tools_tuple)      # ('docker', 'jenkins', 'ansible')

# List → Set (removes duplicates!)
servers_list = ["web01", "web01", "db01"]
servers_set  = set(servers_list)
print(servers_set)      # {'web01', 'db01'}
```

### 🛠️ Built-in Conversion Functions
| Function | Converts To |
|---------|------------|
| `int()` | Integer |
| `float()` | Float |
| `str()` | String |
| `bool()` | Boolean |
| `list()` | List |
| `tuple()` | Tuple |
| `set()` | Set |
| `dict()` | Dictionary |

### 💼 DevOps Use Case
When reading config values from environment variables or files, they come as **strings** — you often need to convert them:

```python
import os

max_retries = int(os.environ.get("MAX_RETRIES", "3"))  # string → int
timeout     = float(os.environ.get("TIMEOUT", "30.0")) # string → float
```

---

## 6. Comments & Documentation

```python
# This is a single-line comment (use # hash)

"""
This is a
multi-line comment
using triple double-quotes
"""

# Best Practice: Add comments explaining WHY, not WHAT
# BAD comment:  x = x + 1    # adds 1 to x
# GOOD comment: x = x + 1    # retry counter increment after failed connection
```

---

## 7. Operators

### 🔢 Arithmetic Operators

```python
a = 10
b = 3

print(a + b)    # Addition       → 13
print(a - b)    # Subtraction    → 7
print(a * b)    # Multiplication → 30
print(a / b)    # Division       → 3.333...
print(a % b)    # Modulus        → 1  (remainder)
print(a ** b)   # Exponent       → 1000
print(a // b)   # Floor division → 3
```

### 🔄 Comparison Operators

```python
print(10 == 10)    # Equal to          → True
print(10 != 5)     # Not equal to      → True
print(10 > 5)      # Greater than      → True
print(10 < 20)     # Less than         → True
print(10 >= 10)    # Greater or equal  → True
print(5  <= 10)    # Less or equal     → True
```

### 🔗 Logical Operators

```python
x = True
y = False

print(x and y)   # AND → both must be True → False
print(x or y)    # OR  → at least one True → True
print(not x)     # NOT → negates           → False
```

### 💼 DevOps Use Case

```python
cpu_usage    = 85
memory_usage = 90

if cpu_usage > 80 and memory_usage > 85:
    print("⚠️  HIGH LOAD — Scale Up the Server!")
```

---

## 8. String Operations

```python
message = "Python for DevOps Automation"

print(message.upper())          # PYTHON FOR DEVOPS AUTOMATION
print(message.lower())          # python for devops automation
print(message.split())          # ['Python', 'for', 'DevOps', 'Automation']
print(message.replace("DevOps", "AWS"))  # Python for AWS Automation
print(message.strip())          # Removes leading/trailing spaces
print(message.startswith("Py")) # True
print(message.endswith("on"))   # True
print(len(message))             # Length of string
```

### 💼 DevOps Use Case

```python
log_line = "ERROR: Disk usage exceeded 90% on server web01"

if "ERROR" in log_line:
    parts = log_line.split(":")
    print(f"Alert triggered: {parts[1].strip()}")
```

---

## 9. Control Flow — Conditional Statements

### Basic If-Elif-Else

```python
server_status = "running"

if server_status == "running":
    print("✅ Server is Healthy")
elif server_status == "stopped":
    print("❌ Server is Down")
else:
    print("⚠️  Unknown Status")
```

### Nested Conditions

```python
cpu_usage    = 80
memory_usage = 90

if cpu_usage > 75:
    if memory_usage > 80:
        print("🚨 High CPU + Memory Load — Scale Up the Server!")
    else:
        print("⚠️  Only CPU is High — Monitor Closely")
```

### Shorthand (Ternary / Inline) If-Else

```python
status = "up"
result = "Server is UP" if status == "up" else "Server is DOWN"
print(result)
```

### 💼 DevOps Use Case — Deployment Environment Check

```python
environment = "production"

if environment == "production":
    print("🚀 Deploying to Production")
elif environment == "staging":
    print("🧪 Deploying to Staging")
else:
    print("❓ Unknown Environment")
```

### 🎯 Interview Tip
> *"Use `elif` instead of multiple `else if` blocks — it's cleaner and more Pythonic."*

---

## 10. Control Flow — Loops

### 🔄 For Loop

```python
tools = ["docker", "jenkins", "ansible", "terraform"]

for tool in tools:
    print(f"Installing {tool}...")
```

### For Loop with Range

```python
for batch in range(1, 4):   # 1, 2, 3 (4 is excluded)
    print(f"Deploying services — Batch {batch}")
```

### 🔁 While Loop

```python
count = 0

while count < 3:
    print(f"Running Build Pipeline — Attempt {count + 1}")
    count += 1   # ⚠️ IMPORTANT: Always increment, else infinite loop!
```

### ⚠️ Common Mistake — Infinite Loop
```python
# ❌ DANGEROUS — Missing increment
count = 0
while count < 3:
    print("Running...")   # This runs FOREVER!
```

### For Loop with Else

```python
servers = ["node1", "node2", "node3"]

for i in range(len(servers)):
    print(f"Checking node {i}")
else:
    print("✅ All nodes checked successfully!")
```

### 💼 DevOps Use Case — Server Status Check

```python
servers = {
    "web01": "running",
    "db01":  "stopped",
    "cache01": "running"
}

for server_name, status in servers.items():
    if status == "running":
        print(f"✅ {server_name} is Healthy")
    else:
        print(f"❌ {server_name} is Down — Restarting service...")
```

---

## 11. Loop Control Statements

### Break — Exit Loop Early

```python
servers = ["web01", "web02", "db01", "web03"]

for server in servers:
    if server == "db01":
        print(f"⛔ Stopping at {server}")
        break
    print(f"Checking {server}")

# Output: Checking web01, Checking web02, Stopping at db01
```

### Continue — Skip Current Iteration

```python
services = ["nginx", "mysql", "redis", "apache"]

for service in services:
    if service == "mysql":
        print(f"⏭️  Skipping {service}")
        continue
    print(f"Starting {service}")
```

### Pass — Placeholder (Does Nothing)

```python
for i in range(3):
    pass   # TODO: Add monitoring logic here later
```

### 💡 When to Use Each?
| Statement | Use When |
|----------|---------|
| `break` | Found what you need, stop searching |
| `continue` | Skip invalid/unwanted item, process rest |
| `pass` | Placeholder while writing code structure |

---

## 12. Data Structures

### 📋 Lists — Ordered, Mutable

```python
tools = ["docker", "jenkins", "ansible", "kubernetes"]

# Access by index (starts at 0)
print(tools[0])    # docker
print(tools[-1])   # kubernetes (negative index from end)

# Add element at the end
tools.append("terraform")
print(tools)   # ['docker', 'jenkins', 'ansible', 'kubernetes', 'terraform']

# Remove element
tools.remove("jenkins")
print(tools)   # ['docker', 'ansible', 'kubernetes', 'terraform']

# Update element (mutable!)
tools[0] = "gitlab"
print(tools)   # ['gitlab', 'ansible', 'kubernetes', 'terraform']
```

### 🔒 Tuples — Ordered, Immutable

```python
credentials = ("admin", "p@ssword123")

print(credentials[0])    # admin (can access)
# credentials[0] = "root"  ❌ TypeError — cannot modify tuple!
```

### 💡 Why Use Tuples in DevOps?
Use tuples for **read-only data** that should never change — like credentials, config constants, or DB connection settings.

```python
DB_CONFIG = ("db.prod.company.com", 5432, "mydb")   # host, port, dbname
```

### 🔵 Sets — Unordered, Unique

```python
environments = {"dev", "staging", "prod", "dev", "staging"}
print(environments)   # {'dev', 'staging', 'prod'} — duplicates removed!

# Set Operations
team_a = {"docker", "ansible", "jenkins"}
team_b = {"aws", "terraform", "docker"}

print(team_a | team_b)    # Union       — all unique tools from both
print(team_a & team_b)    # Intersection — common tools → {'docker'}
print(team_a - team_b)    # Difference   — in A but not B
```

### 📖 Dictionaries — Key-Value Pairs

```python
server = {
    "name":   "web01",
    "ip":     "192.168.1.10",
    "status": "running"
}

# Access value by key
print(server["name"])       # web01
print(server["status"])     # running

# Add new key-value pair
server["region"] = "ap-south-1"

# Update existing value
server["status"] = "stopped"

# Delete a key
del server["ip"]

print(server)
```

### Looping Through Dictionary

```python
for key, value in server.items():
    print(f"Key: {key} → Value: {value}")
```

### 🏗️ Nested Data Structures

#### List of Dictionaries (Most Common in DevOps!)

```python
servers = [
    {"name": "web01",   "status": "running"},
    {"name": "db01",    "status": "stopped"},
    {"name": "cache01", "status": "running"}
]

for s in servers:
    print(f"{s['name']} — {s['status']}")

# Filter only running servers
running = [s for s in servers if s["status"] == "running"]
print(f"Running Servers: {[s['name'] for s in running]}")
```

#### Dictionary of Lists

```python
deployment = {
    "production": ["web01", "db01"],
    "staging":    ["web02", "db02"]
}

for environment, server_list in deployment.items():
    print(f"Environment: {environment} → Servers: {server_list}")
```

### 🔄 Data Structure Conversion

```python
tools_list  = ["docker", "jenkins", "docker", "ansible"]

# List → Set (removes duplicates)
tools_set   = set(tools_list)
print(tools_set)   # {'docker', 'jenkins', 'ansible'}

# Set → List
tools_back  = list(tools_set)

# Dictionary keys/values → List
config = {"tool": "docker", "env": "prod"}
keys   = list(config.keys())    # ['tool', 'env']
values = list(config.values())  # ['docker', 'prod']
```

### 💼 DevOps Use Case — Parse AWS EC2-like Response

```python
instances = [
    {"InstanceId": "i-001", "State": "running"},
    {"InstanceId": "i-002", "State": "stopped"},
    {"InstanceId": "i-003", "State": "running"}
]

# Get all running instance IDs
running_ids = [i["InstanceId"] for i in instances if i["State"] == "running"]
print(f"Running Instances: {running_ids}")
# Output: Running Instances: ['i-001', 'i-003']
```

### 🎯 Interview Questions
- **Q:** Difference between List and Tuple?
  - **A:** List is mutable (changeable), Tuple is immutable (unchangeable). Use Tuple for read-only data.
- **Q:** Difference between Set and List?
  - **A:** Set is unordered and unique (no duplicates). List is ordered and allows duplicates.

---

## 13. Functions

### 🔍 What is a Function?
A **reusable block of code** that performs a specific task. Instead of writing the same code multiple times, define it once and call it whenever needed.

### Basic Function (No Parameters)

```python
def greet():
    print("Welcome to the Python for DevOps session!")

greet()   # Call the function
```

### Function with Parameters

```python
def greet_user(name):
    print(f"Hello {name}, Welcome to the DevOps World!")

greet_user("das")       # Argument passed → Hello das, Welcome to the DevOps World!
greet_user("rahul")     # Reusable!
```

### Function with Return Value

```python
def add(a, b):
    total = a + b
    return total

result = add(10, 20)
print(f"Sum: {result}")   # Sum: 30
```

### 💼 DevOps Use Case — Service Health Check Function

```python
def check_service(service_name, status):
    if status == "running":
        return f"✅ {service_name} is Healthy"
    else:
        return f"❌ {service_name} has Issue Detected"

print(check_service("nginx", "running"))    # ✅ nginx is Healthy
print(check_service("mysql", "stopped"))    # ❌ mysql has Issue Detected
```

---

### 📌 Types of Function Arguments

#### 1. Positional Arguments (Order Matters!)

```python
def deploy(environment, version):
    print(f"Deploying version {version} to {environment}")

deploy("production", "1.2.0")   # ✅ Correct order
# deploy("1.2.0", "production") # ⚠️ Wrong — swapped positions
```

#### 2. Keyword Arguments (Order Doesn't Matter)

```python
def deploy(environment, version):
    print(f"Deploying version {version} to {environment}")

deploy(version="1.2.0", environment="staging")   # ✅ Keyword args — order flexible
```

#### 3. Default Arguments

```python
def start_server(server_name, region="ap-south-1"):
    print(f"Starting {server_name} in {region}")

start_server("web01")                    # Uses default region → ap-south-1
start_server("web01", "us-east-1")       # Overrides default   → us-east-1
```

#### 4. Variable-Length Arguments (`*args`) — Multiple Positional

```python
def install_tools(*tools):
    for tool in tools:
        print(f"Installing {tool}...")

install_tools("docker", "jenkins")
install_tools("docker", "jenkins", "ansible", "argocd", "sonarqube")
# Can pass ANY number of arguments!
```

#### 5. Variable-Length Keyword Arguments (`**kwargs`) — Multiple Keyword

```python
def server_details(**server):
    for key, value in server.items():
        print(f"{key}: {value}")

server_details(name="web01", ip="192.168.1.10", status="running")
server_details(name="db01",  ip="10.0.0.5",     status="stopped", memory="16GB")
```

---

### 🌍 Scope — Local vs Global Variables

```python
count = 5   # GLOBAL variable — accessible everywhere

def increase():
    inner = 10   # LOCAL variable — only accessible inside this function
    print(f"Inside function: {inner}")

increase()
print(f"Outside function: {count}")
# print(inner)  ❌ Error — inner not accessible outside function
```

---

### ⚡ Lambda Functions (Anonymous Functions)

```python
# Regular function
def square(x):
    return x * x

# Lambda equivalent (one-liner!)
square = lambda x: x * x
print(square(4))    # 16
print(square(9))    # 81
```

### Lambda with Filter — DevOps Use Case

```python
servers = [
    {"name": "web01",   "status": "running"},
    {"name": "db01",    "status": "stopped"},
    {"name": "cache01", "status": "running"},
    {"name": "web02",   "status": "terminated"}
]

# Filter only running servers using lambda
running = list(filter(lambda s: s["status"] == "running", servers))
print(f"Active Servers: {[s['name'] for s in running]}")
# Output: Active Servers: ['web01', 'cache01']
```

---

### 🪆 Nested Functions

```python
def devops_pipeline():
    def build():
        print("🔨 Building Code...")
    
    def deploy():
        print("🚀 Deploying to Servers...")
    
    build()
    deploy()

devops_pipeline()
```

---

### 💼 DevOps Use Case — Disk Space Monitor

```python
import random

def check_disk_space(server_name):
    usage = random.randint(50, 95)   # Simulated disk usage %
    print(f"{server_name} disk usage: {usage}%")
    
    if usage > 85:
        print(f"🚨 HIGH Disk Usage on {server_name} — Cleanup Required!")

check_disk_space("web01")
check_disk_space("db01")
```

### 💼 DevOps Use Case — Log Analyzer

```python
def count_errors(logs):
    error_count = 0
    for line in logs:
        if "ERROR" in line:
            error_count += 1
    return error_count

sample_logs = [
    "INFO: Server started",
    "ERROR: Connection timeout",
    "INFO: Request processed",
    "ERROR: Disk full"
]

total_errors = count_errors(sample_logs)
print(f"Total Errors Found: {total_errors}")   # Total Errors Found: 2
```

### 🎯 Interview Tip
> *"`*args` is used when the number of positional arguments is unknown. `**kwargs` is used when the number of keyword arguments is unknown. Lambda functions are anonymous one-liner functions often used with `filter()`, `map()`, and `sorted()`."*

---

## 14. Modules & Packages

### 🔍 What is a Module?
A **module** is simply a Python file (`.py`) containing functions, variables, and classes that you can **reuse** in other scripts.

### Creating a Custom Module

```python
# File: devops_utils.py

def start_server(server_name):
    print(f"🟢 Starting server: {server_name}")

def stop_server(server_name):
    print(f"🔴 Stopping server: {server_name}")

def get_status(server_name):
    print(f"🔍 Checking status of: {server_name}")
```

### Using the Custom Module

```python
# File: main.py

import devops_utils

devops_utils.start_server("web01")
devops_utils.get_status("web01")
devops_utils.stop_server("web01")
```

```bash
python3 main.py
```

---

### 🏗️ Built-in Python Modules for DevOps

| Module | Purpose | DevOps Use |
|--------|---------|-----------|
| `os` | OS interaction | File/directory operations |
| `sys` | System parameters | Command-line args, Python path |
| `subprocess` | Run shell commands | Execute Linux commands from Python |
| `shutil` | High-level file ops | Copy, move, delete files |
| `json` | JSON data handling | Parse API responses, configs |
| `datetime` | Date & time | Log timestamps, scheduled jobs |
| `re` | Regular expressions | Log parsing, pattern matching |

---

### 📂 `os` Module — Interact with Operating System

```python
import os

# Current working directory
print(os.getcwd())

# Change directory
os.chdir("/tmp")

# Create a new directory
os.mkdir("test_dir")

# Remove a directory
os.rmdir("test_dir")

# List files and directories
files = os.listdir(".")
print(files)

# Rename a file
os.rename("old.txt", "new.txt")

# Delete a file
os.remove("new.txt")

# Check if file exists
if os.path.exists("servers.txt"):
    print("File exists!")
else:
    print("File not found!")
```

### `sys` Module — System-Specific Parameters

```python
import sys

print(sys.version)      # Python version
print(sys.path)         # Module search paths
print(sys.argv)         # Command-line arguments

# Exit script with a code
sys.exit(0)   # 0 = success, non-zero = error
```

```bash
python3 main.py hello das
# sys.argv → ['main.py', 'hello', 'das']
```

### `subprocess` Module — Run Shell Commands

```python
import subprocess

# Get server uptime
output = subprocess.getoutput("uptime")
print(f"Server Uptime: {output}")

# Run a command
subprocess.run(["ls", "-l"])

# Capture output
result = subprocess.run(
    ["df", "-h"],
    capture_output=True,
    text=True
)
print(result.stdout)
```

### `shutil` Module — High-Level File Operations

```python
import shutil

# Copy file
shutil.copy("source.txt", "backup.txt")

# Move file
shutil.move("backup.txt", "/tmp/backup.txt")

# Delete a directory tree
shutil.rmtree("old_logs/")
```

---

### 📦 Packages

A **package** is a **collection of modules** stored in a directory that contains an `__init__.py` file.

```
devops_tools/           ← Package directory
├── __init__.py         ← Marks this as a package
├── aws_utils.py        ← Module 1
└── docker_utils.py     ← Module 2
```

```python
# aws_utils.py
def deploy_ec2(instance_name):
    print(f"Deploying EC2 instance: {instance_name}")
```

```python
# docker_utils.py
def start_container(container_name):
    print(f"Starting Docker container: {container_name}")
```

```python
# main.py
from devops_tools import aws_utils, docker_utils

aws_utils.deploy_ec2("web-instance-01")
docker_utils.start_container("nginx-container")
```

---

### 🔧 Third-Party Libraries for DevOps

| Library | Install | Purpose |
|--------|--------|---------|
| `boto3` | `pip install boto3` | AWS automation (EC2, S3, Lambda) |
| `paramiko` | `pip install paramiko` | SSH into remote servers |
| `requests` | `pip install requests` | REST API calls |
| `psutil` | `pip install psutil` | CPU, memory, system monitoring |
| `pyyaml` | `pip install pyyaml` | YAML file handling |

```python
# AWS EC2 Example using boto3
import boto3

ec2 = boto3.client("ec2", region_name="ap-south-1")

response = ec2.run_instances(
    ImageId="ami-0abcdef1234567890",
    InstanceType="t2.micro",
    MinCount=1,
    MaxCount=1,
    KeyName="my-key-pair"
)

instance_id = response["Instances"][0]["InstanceId"]
print(f"✅ EC2 Instance Created: {instance_id}")
```

```python
# SSH into remote server using Paramiko
import paramiko

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect("192.168.1.10", username="ubuntu", key_filename="/path/to/key.pem")

stdin, stdout, stderr = ssh.exec_command("uptime")
print(stdout.read().decode())
ssh.close()
```

```python
# GitHub API using requests
import requests

response = requests.get("https://api.github.com")
print(f"GitHub API Status: {response.status_code}")
```

---

## 15. File Handling

### 📁 File Opening Modes

| Mode | Description | Creates if not exists? |
|------|-------------|----------------------|
| `r` | Read (default) | No |
| `w` | Write (overwrites) | ✅ Yes |
| `a` | Append (adds to end) | ✅ Yes |
| `x` | Create new file | Error if exists |
| `r+` | Read + Write | No |
| `b` | Binary mode | — |

### Writing to a File

```python
with open("devops_notes.txt", "w") as f:
    f.write("Python makes DevOps automation easy.\n")
    f.write("Monitoring and logging are essential.\n")

print("File written successfully!")
```

### Reading from a File

```python
with open("devops_notes.txt", "r") as f:
    content = f.read()
    print(content)
```

### Reading Line by Line

```python
with open("servers.txt", "r") as f:
    for line in f:
        print(line.strip())   # strip() removes trailing newline
```

### Appending to a File

```python
with open("devops_notes.txt", "a") as f:
    f.write("Always secure your deployments.\n")
```

### 💡 Why Use `with` Statement?
The `with` keyword is a **context manager** — it **automatically closes the file** even if an error occurs. Always prefer `with open()` over `open()` + `close()`.

```python
# ❌ Old way — must manually close
f = open("file.txt", "r")
content = f.read()
f.close()   # Can be forgotten!

# ✅ Best practice — auto-closes
with open("file.txt", "r") as f:
    content = f.read()
```

---

### 📄 JSON File Handling

```python
import json

# Python dict → JSON file
config = {
    "app":     "webapp",
    "version": "1.0.0",
    "servers": ["web01", "web02"],
    "port":    8080
}

with open("config.json", "w") as f:
    json.dump(config, f, indent=4)   # indent=4 for pretty formatting

print("config.json created!")
```

```python
# JSON file → Python dict
with open("config.json", "r") as f:
    data = json.load(f)

print(f"App: {data['app']}")
print(f"Servers: {data['servers']}")
```

```python
# JSON string ↔ Python dict (in memory)
import json

json_string = '{"tool": "docker", "env": "prod"}'
python_dict = json.loads(json_string)   # JSON string → dict (loads = load string)

back_to_json = json.dumps(python_dict)  # dict → JSON string (dumps = dump string)
```

---

### 📄 YAML File Handling

```bash
pip install pyyaml
```

```python
import yaml

# Write YAML file
deployment = {
    "app":         "nginx",
    "environment": "staging",
    "replicas":    3
}

with open("deployment.yaml", "w") as f:
    yaml.dump(deployment, f)

print("deployment.yaml created!")
```

```python
# Read YAML file
with open("deployment.yaml", "r") as f:
    config = yaml.safe_load(f)   # Use safe_load (not load) for security!

print(f"App: {config['app']}")
print(f"Replicas: {config['replicas']}")
```

### 💡 JSON vs YAML — Key Difference
```
JSON → Uses {}, [], "" — Good for APIs & data exchange
YAML → Uses indentation — Good for config files (Kubernetes, Ansible, CI/CD)
```

---

### 📄 CSV File Handling

```python
import csv

# Write CSV
with open("servers.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["Server", "IP", "Status"])         # Header
    writer.writerow(["web01", "192.168.1.10", "running"])

# Read CSV
with open("servers.csv", "r") as f:
    reader = csv.reader(f)
    for row in reader:
        print(row)
```

---

### 💼 DevOps Use Case — Log Analysis

```python
def analyze_log(log_file):
    error_count = 0
    
    with open(log_file, "r") as f:
        for line in f:
            if "ERROR" in line:
                error_count += 1
                print(f"🚨 Error Found: {line.strip()}")
    
    print(f"\nTotal Errors: {error_count}")

analyze_log("system.log")
```

---

## 16. Exception Handling

### 🔍 Why Exception Handling?
Without exception handling, your script **stops completely** when an error occurs. Exception handling makes your scripts **robust and fault-tolerant** — critical in production DevOps environments.

```python
# ❌ No exception handling — script crashes
result = 10 / 0   # ZeroDivisionError — script stops here!
print("This won't print")
```

### Basic Try-Except

```python
try:
    result = 10 / 0
except ZeroDivisionError:
    print("❌ Error: Cannot divide by zero!")

print("✅ Script continues after handling the error")
```

### Multiple Except Blocks

```python
def safe_divide():
    try:
        num = int(input("Enter a number: "))
        result = 10 / num
        print(f"Result: {result}")
    
    except ZeroDivisionError:
        print("❌ Cannot divide by zero!")
    
    except ValueError:
        print("❌ Please enter a valid integer!")

safe_divide()
```

### Try-Except-Else-Finally

```python
try:
    with open("servers.txt", "r") as f:
        content = f.read()

except FileNotFoundError:
    print("❌ File not found!")

else:
    # Executes ONLY if NO exception occurred
    print(f"✅ File read successfully!\n{content}")

finally:
    # ALWAYS executes — error or no error
    print("🔒 Closing script...")
```

### 💡 Key Rules
| Block | When it executes |
|-------|----------------|
| `try` | Always (contains risky code) |
| `except` | Only when an exception occurs |
| `else` | Only when NO exception occurs |
| `finally` | ALWAYS — with or without exception |

---

### Common Python Exceptions

| Exception | Cause |
|----------|-------|
| `FileNotFoundError` | File doesn't exist |
| `ZeroDivisionError` | Division by zero |
| `ValueError` | Wrong data type/value |
| `KeyError` | Missing dictionary key |
| `IndexError` | Invalid list index |
| `TypeError` | Operation on wrong type |
| `ImportError` | Module not found |
| `TimeoutError` | Operation timed out |
| `PermissionError` | Insufficient file permissions |

---

### Raising Custom Exceptions with `raise`

```python
class DeploymentError(Exception):
    """Custom exception for deployment failures"""
    pass

def deploy(version):
    if version < 1.0:
        raise DeploymentError(f"❌ Invalid version: {version}. Must be >= 1.0")
    print(f"✅ Deploying version {version}")

try:
    deploy(0.8)
except DeploymentError as e:
    print(f"Deployment Failed: {e}")
```

---

### Retry Pattern (Very Common in DevOps!)

```python
import time

def connect_to_server(server, max_retries=3):
    for attempt in range(max_retries):
        try:
            # Simulating connection attempt
            raise ConnectionError("Connection refused")
        
        except ConnectionError as e:
            print(f"⚠️  Attempt {attempt + 1} failed: {e}")
            if attempt < max_retries - 1:
                print(f"Retrying in 2 seconds...")
                time.sleep(2)
    
    print("❌ All retry attempts exhausted!")

connect_to_server("web01")
```

---

### Logging Exceptions to File

```python
import logging

logging.basicConfig(
    filename="errors.log",
    level=logging.ERROR,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

try:
    result = 10 / 0

except ZeroDivisionError as e:
    logging.error(f"ZeroDivisionError occurred: {e}")
    print("Error logged to errors.log")
```

### 💼 DevOps Use Case — S3 Upload with Exception Handling

```python
import boto3
from botocore.exceptions import NoCredentialsError, ClientError

def upload_to_s3(file_name, bucket_name):
    try:
        s3 = boto3.client("s3")
        s3.upload_file(file_name, bucket_name, file_name)
        print(f"✅ {file_name} uploaded to {bucket_name}")
    
    except FileNotFoundError:
        print(f"❌ File not found: {file_name}")
    
    except NoCredentialsError:
        print("❌ AWS credentials not configured!")
    
    except ClientError as e:
        error_code = e.response["Error"]["Code"]
        if error_code == "NoSuchBucket":
            print(f"❌ Bucket does not exist: {bucket_name}")
        else:
            print(f"❌ Client Error: {e}")

upload_to_s3("deployment.log", "my-devops-bucket")
```

### 🎯 Production Best Practice
> Always log exceptions to a log file in production. Never use bare `except:` — always specify the exception type. Use `finally` for cleanup (closing connections, files).

---

## 17. OOP Concepts

### 🔍 What is OOP?
Object-Oriented Programming organizes code into **objects** that combine **data (attributes)** and **behavior (methods)**.

### Core OOP Concepts
| Concept | Definition |
|---------|-----------|
| **Class** | Blueprint for creating objects |
| **Object** | Instance of a class |
| **Encapsulation** | Hiding internal data (private variables/methods) |
| **Inheritance** | Child class inherits from parent class |
| **Polymorphism** | Same method name, different behavior |
| **Abstraction** | Hiding complexity from users |

---

### Class & Object

```python
class Server:
    
    def __init__(self, name, ip):    # Constructor — auto-called on object creation
        self.name = name
        self.ip   = ip
    
    def start(self):
        print(f"🟢 Server {self.name} started at {self.ip}")
    
    def stop(self):
        print(f"🔴 Server {self.name} stopped")

# Creating objects (instances of Server class)
web_server = Server("web01", "192.168.1.10")
db_server  = Server("db01",  "192.168.1.20")

web_server.start()
db_server.stop()
```

---

### Encapsulation — Private Data

```python
class JenkinsPipeline:
    
    def __init__(self, name):
        self.__name = name           # Private variable (double underscore)
        self.__build_number = 0      # Private variable
    
    def __build(self):               # Private method
        self.__build_number += 1
        print(f"🔨 Building... Build #{self.__build_number}")
    
    def trigger_pipeline(self):      # Public method — accessible outside
        print(f"🚀 Triggering pipeline: {self.__name}")
        self.__build()               # Calling private method internally
        print("✅ Deployment complete!")

pipeline = JenkinsPipeline("my-app")
pipeline.trigger_pipeline()

# pipeline.__build()   ❌ Error — private method not accessible outside
```

### 💡 When to use Encapsulation in DevOps?
- Storing credentials/secrets as private variables
- Internal build steps that shouldn't be called directly
- Database connection details

---

### Inheritance — Code Reuse

```python
class Server:
    def __init__(self, name):
        self.name = name
    
    def start(self):
        print(f"🟢 Starting server: {self.name}")

class WebServer(Server):      # WebServer inherits from Server
    def deploy(self):
        print(f"🚀 Deploying web app on: {self.name}")

class DBServer(Server):       # DBServer inherits from Server
    def backup(self):
        print(f"💾 Backing up database on: {self.name}")

# WebServer gets start() from Server PLUS its own deploy()
web = WebServer("nginx-01")
web.start()     # Inherited from Server
web.deploy()    # Own method

db = DBServer("mysql-01")
db.start()      # Inherited from Server
db.backup()     # Own method
```

---

### Polymorphism — Same Interface, Different Behavior

```python
class Server:
    def restart(self):
        print("Restarting generic server")

class WebServer(Server):
    def restart(self):
        print("🌐 Restarting Nginx Web Server")    # Overrides parent

class DBServer(Server):
    def restart(self):
        print("🗄️  Restarting MySQL Database Server")  # Overrides parent

servers = [WebServer(), DBServer(), Server()]

for server in servers:
    server.restart()   # Same method call — different output (polymorphism!)
```

---

### Abstraction — Hide Complexity

```python
from abc import ABC, abstractmethod

class CloudProvider(ABC):     # Abstract class
    
    @abstractmethod
    def create_instance(self):    # Abstract method — must be implemented
        pass

class AWS(CloudProvider):
    def create_instance(self):
        print("🟠 Launching EC2 Instance on AWS")

class Azure(CloudProvider):
    def create_instance(self):
        print("🔵 Launching VM on Azure")

aws   = AWS()
azure = Azure()

aws.create_instance()
azure.create_instance()

# cloud = CloudProvider()   ❌ Error — cannot instantiate abstract class!
```

---

### Class Variables vs Instance Variables

```python
class Server:
    region = "ap-south-1"    # Class variable — SHARED by all instances
    
    def __init__(self, name):
        self.name = name     # Instance variable — UNIQUE per object

server1 = Server("web01")
server2 = Server("db01")

print(server1.region)   # ap-south-1 (class variable)
print(server2.region)   # ap-south-1 (same class variable)
print(server1.name)     # web01 (unique)
print(server2.name)     # db01 (unique)
```

---

### Magic Methods

```python
class Server:
    
    def __init__(self, name, services):
        self.name     = name
        self.services = services
    
    def __str__(self):             # Called when print(object)
        return f"Server: {self.name} running {self.services}"
    
    def __len__(self):             # Called when len(object)
        return len(self.services)

server = Server("web01", ["nginx", "php-fpm", "redis"])

print(server)        # Uses __str__  → Server: web01 running ['nginx', 'php-fpm', 'redis']
print(len(server))   # Uses __len__  → 3
```

---

### Composition — Combining Classes

```python
class Logger:
    def log(self, message):
        print(f"[LOG] {message}")

class Deployment:
    def __init__(self, app_name):
        self.app_name = app_name
        self.logger   = Logger()   # Composing Logger into Deployment
    
    def deploy(self):
        self.logger.log(f"Deploying {self.app_name}...")
        print(f"✅ {self.app_name} deployed successfully!")

deployment = Deployment("flask-app")
deployment.deploy()
```

---

## 18. Advanced Python Topics

### 🔄 Iterators

```python
tools = [10, 20, 30, 40]

# Convert list to iterator
it = iter(tools)

print(next(it))   # 10
print(next(it))   # 20
print(next(it))   # 30
print(next(it))   # 40
```

---

### ⚡ Generators — Memory Efficient Iteration

```python
def get_servers(count):
    for i in range(1, count + 1):
        yield f"server-{i}"    # yield instead of return

# Memory-efficient — generates one at a time
for server in get_servers(5):
    print(f"Processing {server}")
```

### 💡 Generator vs List — Why Generators in DevOps?
```python
# List — loads ALL 1 million items in memory ❌
all_logs = [f"log_line_{i}" for i in range(1_000_000)]

# Generator — loads ONE item at a time ✅
log_stream = (f"log_line_{i}" for i in range(1_000_000))
```

---

### 🎁 Decorators — Add Functionality Without Changing Functions

```python
def logger(func):           # Decorator function
    def wrapper(*args, **kwargs):
        print(f"▶️  Running function: {func.__name__}")
        result = func(*args, **kwargs)
        print(f"✅ Completed: {func.__name__}")
        return result
    return wrapper

@logger                     # Apply decorator with @ symbol
def deploy_app(app_name):
    print(f"��� Deploying {app_name}...")

deploy_app("flask-app")

# Output:
# ▶️  Running function: deploy_app
# 🚀 Deploying flask-app...
# ✅ Completed: deploy_app
```

### 💼 Timing Decorator — DevOps Use Case

```python
import time

def timer(func):
    def wrapper(*args, **kwargs):
        start  = time.time()
        result = func(*args, **kwargs)
        end    = time.time()
        print(f"⏱️  {func.__name__} took {end - start:.2f} seconds")
        return result
    return wrapper

@timer
def run_backup():
    time.sleep(2)   # Simulate backup
    print("Backup completed!")

run_backup()
```

---

### 🔍 Regular Expressions (`re` module)

```python
import re

# Find email in text
text = "Contact admin at ops@company.com for support"

match = re.search(r'\w+@\w+\.\w+', text)
if match:
    print(f"Email found: {match.group()}")   # ops@company.com

# Extract all IP addresses from log
log = "Connection from 192.168.1.10 and 10.0.0.5 failed"
ips = re.findall(r'\d+\.\d+\.\d+\.\d+', log)
print(f"IP Addresses: {ips}")   # ['192.168.1.10', '10.0.0.5']

# Replace sensitive data
log_line = "Password: secret123 for user admin"
clean    = re.sub(r'Password: \S+', 'Password: [REDACTED]', log_line)
print(clean)   # Password: [REDACTED] for user admin
```

---

### 🧵 Multithreading — Concurrent Execution

```python
import threading
import time

def check_server(server_name):
    print(f"🔍 Checking {server_name}...")
    time.sleep(1)
    print(f"✅ {server_name} is healthy")

# Without threading → runs sequentially = 3 seconds total
# With threading    → runs concurrently = ~1 second total

threads = []
servers = ["web01", "db01", "cache01"]

for server in servers:
    t = threading.Thread(target=check_server, args=(server,))
    threads.append(t)
    t.start()

for t in threads:
    t.join()   # Wait for all threads to complete

print("🎉 All server checks completed!")
```

### 💡 When to Use Multithreading in DevOps?
- Checking health of multiple servers simultaneously
- Running parallel backups
- Monitoring multiple services at once

---

### 🖥️ Multiprocessing — True Parallel Execution

```python
import multiprocessing
import time

def run_backup(server):
    print(f"💾 Starting backup on {server}")
    time.sleep(2)
    print(f"✅ Backup completed on {server}")

if __name__ == "__main__":
    servers  = ["web01", "db01"]
    
    processes = []
    for server in servers:
        p = multiprocessing.Process(target=run_backup, args=(server,))
        processes.append(p)
        p.start()
    
    for p in processes:
        p.join()
    
    print("🎉 All backups done!")
```

### 🔄 Threading vs Multiprocessing

| Feature | Threading | Multiprocessing |
|---------|----------|----------------|
| Memory | Shared | Separate |
| Best for | I/O tasks (network, files) | CPU-heavy tasks |
| GIL | Affected | Bypassed |
| Example | Health checks | Data processing |

---

### ⚙️ Command-Line Arguments with `argparse`

```python
import argparse

parser = argparse.ArgumentParser(description="Deployment Script")
parser.add_argument("--env",     help="Target environment (dev/staging/prod)", required=True)
parser.add_argument("--version", help="Application version", default="1.0.0")

args = parser.parse_args()

print(f"🚀 Deploying version {args.version} to {args.env} environment")
```

```bash
python3 deploy.py --env production --version 2.1.0
# Output: 🚀 Deploying version 2.1.0 to production environment

python3 deploy.py --help
# Shows help message with all arguments
```

---

### 🌍 Environment Variables

```python
import os

# Read environment variable (with default fallback)
db_host    = os.environ.get("DB_HOST",    "localhost")
db_port    = os.environ.get("DB_PORT",    "5432")
aws_region = os.environ.get("AWS_REGION", "us-east-1")

print(f"DB Host: {db_host}")
print(f"AWS Region: {aws_region}")

# Set environment variable programmatically
os.environ["APP_ENV"] = "production"
print(f"App Environment: {os.environ.get('APP_ENV')}")
```

```bash
# Set env vars before running script
export DB_HOST=db.prod.company.com
export AWS_REGION=ap-south-1
python3 main.py
```

### 💡 Why Environment Variables in DevOps?
- Store **secrets, passwords, API keys** outside code
- Different values per environment (dev/staging/prod)
- Required for **Docker, Kubernetes, CI/CD pipelines**
- Never hardcode credentials in Python scripts!

```python
# ❌ NEVER DO THIS IN PRODUCTION
aws_access_key = "AKIAIOSFODNN7EXAMPLE"

# ✅ ALWAYS DO THIS
aws_access_key = os.environ.get("AWS_ACCESS_KEY_ID")
```

---

### ⏰ Time & Scheduling Automation

```python
import time

# Simple delay
print("Starting backup...")
time.sleep(5)   # Wait 5 seconds
print("Backup completed!")

# Measure execution time
start = time.time()
time.sleep(2)    # Simulate work
end   = time.time()
print(f"Execution time: {end - start:.2f} seconds")
```

### Schedule Periodic Tasks

```bash
pip install schedule
```

```python
import schedule
import time

def check_servers():
    print("🔍 Checking all server health...")
    # Add your monitoring logic here

def cleanup_logs():
    print("🗑️  Cleaning up old logs...")

# Schedule tasks
schedule.every(10).seconds.do(check_servers)
schedule.every().hour.do(cleanup_logs)
schedule.every().day.at("02:00").do(cleanup_logs)

print("📅 Scheduler started...")
while True:
    schedule.run_pending()
    time.sleep(1)
```

---

## 🏆 Production Best Practices Summary

### ✅ Code Quality
```python
# 1. Use meaningful variable names
server_ip = "192.168.1.10"    # ✅ Clear
x         = "192.168.1.10"    # ❌ Unclear

# 2. Add type hints
def check_health(server_name: str, port: int) -> bool:
    pass

# 3. Use constants for magic numbers
MAX_RETRIES    = 3
TIMEOUT_SECS   = 30
DEFAULT_REGION = "ap-south-1"
```

### ✅ Security
```python
# Never hardcode credentials
import os

AWS_KEY    = os.environ.get("AWS_ACCESS_KEY_ID")
AWS_SECRET = os.environ.get("AWS_SECRET_ACCESS_KEY")

# Use try-except for all file/network operations
# Log errors, don't just print them
```

### ✅ DevOps Script Checklist
- [ ] Use `argparse` for CLI arguments
- [ ] Read secrets from environment variables
- [ ] Add proper exception handling
- [ ] Log to files, not just stdout
- [ ] Add retry logic for network operations
- [ ] Use `with` statement for file handling
- [ ] Add timestamps to log messages
- [ ] Test with `--dry-run` flag before production

---

## 🎯 Common Interview Questions & Answers

| Question | Answer |
|---------|--------|
| List vs Tuple? | List is mutable, Tuple is immutable. Use Tuple for read-only data. |
| `*args` vs `**kwargs`? | `*args` = multiple positional args (tuple). `**kwargs` = multiple keyword args (dict). |
| What is a decorator? | A function that wraps another function to add functionality without modifying it. |
| Generator vs List? | Generator yields one item at a time (memory efficient). List loads all items. |
| Threading vs Multiprocessing? | Threading = concurrent (I/O tasks). Multiprocessing = parallel (CPU tasks). |
| Why use `with open()`? | Automatically closes file even on errors (context manager). |
| What is `__init__`? | Constructor — automatically called when object is created. |
| `json.loads()` vs `json.load()`? | `loads()` parses a JSON **string**. `load()` reads from a **file**. |
| What is encapsulation? | Hiding internal data using private variables/methods (prefix with `__`). |
| When to use lambda? | For short, one-liner anonymous functions, often with `filter()`, `map()`, `sorted()`. |

---

## 🛠️ Quick Reference — DevOps Script Template

```python
#!/usr/bin/env python3
"""
DevOps Automation Script Template
Author: Your Name
Purpose: Brief description
"""

import os
import sys
import logging
import argparse
from datetime import datetime

# ─── Logging Setup ──────────────────────────────────────────────
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.FileHandler("devops_script.log"),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

# ─── Constants ──────────────────────────────────────────────────
MAX_RETRIES = int(os.environ.get("MAX_RETRIES", "3"))
AWS_REGION  = os.environ.get("AWS_REGION", "ap-south-1")

# ─── Functions ──────────────────────────────────────────────────
def parse_args():
    parser = argparse.ArgumentParser(description="DevOps Automation Script")
    parser.add_argument("--env",     required=True, help="Environment: dev/staging/prod")
    parser.add_argument("--dry-run", action="store_true", help="Simulate without executing")
    return parser.parse_args()

def main():
    args = parse_args()
    logger.info(f"Starting script for environment: {args.env}")
    
    if args.dry_run:
        logger.info("DRY RUN MODE — No actual changes will be made")
    
    try:
        # Your automation logic here
        logger.info("✅ Script completed successfully!")
    
    except Exception as e:
        logger.error(f"❌ Script failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
```

```bash
# Run script
python3 script.py --env production
python3 script.py --env staging --dry-run
```

---

> 📘 **These notes cover everything from the transcript — from Python basics to advanced DevOps automation patterns. Practice each section with real scripts and you'll be well-prepared for both real-world DevOps work and interviews!**
