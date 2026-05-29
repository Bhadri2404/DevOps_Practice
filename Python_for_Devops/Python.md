# 🐍 Python & DevOps Complete Study Guide
## From Zero to Production — A Concept-First Learning Journey

---

## 📋 Table of Contents

- [Module 1: Introduction & Mindset](#module-1-introduction--mindset)
- [Module 2: Python Environment Setup](#module-2-python-environment-setup)
  - [2.1 What is Python?](#21-what-is-python)
  - [2.2 Installing Python](#22-installing-python)
  - [2.3 PATH Configuration](#23-path-configuration)
  - [2.4 Python Interpreter](#24-python-interpreter)
  - [2.5 pip & Package Management](#25-pip--package-management)
  - [2.6 Virtual Environments](#26-virtual-environments)
  - [2.7 Pyenv & Multiple Versions](#27-pyenv--multiple-versions)
- [Module 3: Python Fundamentals](#module-3-python-fundamentals)
  - [3.1 Variables & Memory](#31-variables--memory)
  - [3.2 Data Types](#32-data-types)
  - [3.3 Strings](#33-strings)
  - [3.4 Numbers](#34-numbers)
  - [3.5 Booleans](#35-booleans)
  - [3.6 Lists](#36-lists)
  - [3.7 Tuples](#37-tuples)
  - [3.8 Dictionaries](#38-dictionaries)
  - [3.9 Sets](#39-sets)
  - [3.10 Operators](#310-operators)
  - [3.11 Conditional Statements](#311-conditional-statements)
  - [3.12 Loops](#312-loops)
- [Module 4: Functions & Scope](#module-4-functions--scope)
  - [4.1 Functions](#41-functions)
  - [4.2 Scope & LEGB Rule](#42-scope--legb-rule)
  - [4.3 *args and **kwargs](#43-args-and-kwargs)
  - [4.4 Lambda Functions](#44-lambda-functions)
  - [4.5 Closures](#45-closures)
  - [4.6 Decorators](#46-decorators)
- [Module 5: Object-Oriented Programming](#module-5-object-oriented-programming)
  - [5.1 Classes & Objects](#51-classes--objects)
  - [5.2 Inheritance](#52-inheritance)
  - [5.3 Encapsulation](#53-encapsulation)
  - [5.4 Polymorphism](#54-polymorphism)
  - [5.5 Dunder Methods](#55-dunder-methods)
- [Module 6: Iterators & Generators](#module-6-iterators--generators)
  - [6.1 Iterator Protocol](#61-iterator-protocol)
  - [6.2 Generators & yield](#62-generators--yield)
  - [6.3 Generator Expressions](#63-generator-expressions)
- [Module 7: Modules, Packages & Imports](#module-7-modules-packages--imports)
- [Module 8: Comprehensions](#module-8-comprehensions)
- [Module 9: File Handling & Context Managers](#module-9-file-handling--context-managers)
- [Module 10: Error Handling](#module-10-error-handling)
- [Module 11: Regular Expressions](#module-11-regular-expressions)
- [Module 12: JSON & YAML](#module-12-json--yaml)
- [Module 13: Logging](#module-13-logging)
- [Module 14: APIs & Requests](#module-14-apis--requests)
- [Module 15: Threading, Multiprocessing & Asyncio](#module-15-threading-multiprocessing--asyncio)
- [Module 16: Type Hints](#module-16-type-hints)
- [Module 17: Python for DevOps](#module-17-python-for-devops)
  - [17.1 os & sys](#171-os--sys)
  - [17.2 pathlib & shutil](#172-pathlib--shutil)
  - [17.3 subprocess](#173-subprocess)
  - [17.4 argparse](#174-argparse)
  - [17.5 boto3 (AWS SDK)](#175-boto3-aws-sdk)
  - [17.6 paramiko & socket](#176-paramiko--socket)
  - [17.7 collections & dataclasses](#177-collections--dataclasses)
- [Module 18: CI/CD & Automation](#module-18-cicd--automation)
  - [18.1 Jenkins](#181-jenkins)
  - [18.2 GitHub Actions](#182-github-actions)
  - [18.3 GitLab CI/CD](#183-gitlab-cicd)
  - [18.4 Azure DevOps](#184-azure-devops)
  - [18.5 ArgoCD](#185-argocd)
  - [18.6 Terraform](#186-terraform)
  - [18.7 Docker](#187-docker)
  - [18.8 Kubernetes](#188-kubernetes)
  - [18.9 AWS Automation](#189-aws-automation)
- [Module 19: Testing & Pytest](#module-19-testing--pytest)
- [Module 20: Monitoring & Observability](#module-20-monitoring--observability)
- [Module 21: Security](#module-21-security)
- [Module 22: Performance Optimization](#module-22-performance-optimization)
- [Module 23: Production Engineering & SRE](#module-23-production-engineering--sre)
- [Module 24: Interview Preparation](#module-24-interview-preparation)

---

# Module 1: Introduction & Mindset

## 🎯 Learning Objectives

- Understand what this course covers and why
- Develop the right mindset for learning Python and DevOps
- Understand the career path and relevance of these skills

## Why This Course Exists

Imagine you just joined a company as a DevOps Engineer or Platform Engineer. On your first day, your manager says:

> "We need you to write a Python script that checks the health of 200 servers, sends alerts to Slack if any are down, deploys new code using Jenkins, and manages our AWS infrastructure using Terraform — all automated."

If you don't understand Python deeply — not just syntax but *why* things work the way they do — you will struggle. This course exists to make you **confident**, not just capable.

## The 80/15/5 Rule

This course follows a strict ratio:

| Component | Percentage | Purpose |
|-----------|-----------|---------|
| Concept Explanation | 80% | Deep understanding |
| Simple Examples | 15% | Reinforcement |
| Production Scenarios | 5% | Real-world context |

**Why?** Because in 15 years of production experience, I've seen that engineers who understand *why* something works can debug anything. Engineers who only memorize *how* to write code get stuck the moment something unexpected happens.

## Who Is This For?

- Complete beginners with zero Python knowledge
- System administrators transitioning to DevOps
- Developers wanting to understand automation
- Anyone preparing for DevOps/SRE interviews

---

# Module 2: Python Environment Setup

## 2.1 What is Python?

### 🎯 Learning Objectives

- Understand what Python is at a fundamental level
- Know why Python dominates DevOps and automation
- Understand how Python code executes internally

### Why This Topic Exists

Before you write a single line of Python code, you need to understand what Python actually *is*. Many beginners start coding without understanding what happens behind the scenes, which leads to confusion later.

### Real-Life Analogy

Think of Python like a **translator** at the United Nations. You (the programmer) speak English (Python code). The computer speaks machine language (binary — ones and zeros). Python acts as the translator that converts your English-like instructions into something the computer can understand and execute.

### What Problem It Solves

Computers only understand binary (0s and 1s). Writing programs directly in binary is virtually impossible for humans. Python provides a **human-readable** way to give instructions to computers.

### Why Engineers Use It

| Reason | Explanation |
|--------|-------------|
| Readability | Python reads almost like English |
| Speed of Development | Write in 10 lines what takes 50 in Java/C++ |
| Massive Library Ecosystem | 400,000+ packages for any task |
| Cross-Platform | Runs on Windows, Linux, macOS |
| DevOps Dominant | Used by AWS, Google, Netflix, Ansible, Salt |
| Automation-Friendly | Perfect for scripting and automation |

### How Python Works Internally

```
Your Code (.py file)
       ↓
Python Interpreter reads it
       ↓
Lexer breaks it into tokens
       ↓
Parser builds an Abstract Syntax Tree (AST)
       ↓
Compiler converts AST to bytecode (.pyc)
       ↓
Python Virtual Machine (PVM) executes bytecode
       ↓
Result appears on screen
```

**Key Insight:** Python is NOT purely interpreted. It compiles your code to bytecode first, then interprets that bytecode. This is why you see `__pycache__` folders — they store compiled bytecode for faster subsequent runs.

### Where It Is Used

- **Infrastructure Automation**: Ansible (written in Python), SaltStack
- **Cloud SDKs**: boto3 (AWS), azure-sdk, google-cloud-python
- **CI/CD**: Jenkins pipelines, GitHub Actions scripts
- **Monitoring**: Custom Prometheus exporters, Datadog integrations
- **Container Orchestration**: Kubernetes operators, Helm chart generators
- **Security**: Vulnerability scanners, compliance checkers

### Python Versions: CPython, PyPy, Jython

| Implementation | What It Is | When to Use |
|---------------|------------|-------------|
| CPython | The default Python (written in C) | 99% of cases |
| PyPy | Faster Python with JIT compiler | CPU-intensive scripts |
| Jython | Python on JVM | Java integration |
| MicroPython | Python for microcontrollers | IoT devices |

**For this course, we always mean CPython** — the standard Python you download from python.org.

### Common Mistakes

1. Confusing Python 2 and Python 3 (always use Python 3.9+)
2. Not understanding that Python is both compiled and interpreted
3. Thinking Python is "slow" — for DevOps tasks, speed rarely matters

### Interview Perspective

> **Q: Is Python compiled or interpreted?**
> A: Python is both. Source code is first compiled to bytecode (.pyc files), then the Python Virtual Machine interprets that bytecode. This makes Python a "compiled-interpreted" language.

> **Q: Why do DevOps engineers prefer Python over other languages?**
> A: Readability, massive ecosystem (boto3, requests, paramiko), cross-platform support, rapid development cycle, and native support in most cloud SDKs.

---

## 2.2 Installing Python

### 🎯 Learning Objectives

- Install Python on any operating system
- Verify the installation is correct
- Understand what gets installed alongside Python

### Why This Topic Exists

You cannot write Python code without installing Python. Seems obvious, but *how* you install Python matters enormously. A bad installation leads to hours of debugging PATH issues, version conflicts, and permission errors.

### What Problem It Solves

Your operating system doesn't come with the right version of Python (or any at all on Windows). You need to install it properly so that:
1. You can run Python from any terminal/command prompt
2. You can install packages using pip
3. You don't conflict with system Python (on Linux/macOS)

### Installation on Windows

**Step-by-step:**

1. Go to [python.org/downloads](https://python.org/downloads)
2. Download the latest Python 3.x installer (e.g., Python 3.12.x)
3. **CRITICAL:** Check the box that says "Add Python to PATH" ✅
4. Click "Install Now"
5. Wait for installation to complete
6. Open Command Prompt and verify:

```bash
python --version
pip --version
```

**Expected Output:**
```
Python 3.12.4
pip 24.0 from C:\Users\...\pip (python 3.12)
```

**Why "Add to PATH" is Critical:**

Without this checkbox, Windows doesn't know *where* Python is installed. When you type `python` in the terminal, Windows searches through a list of folders (called PATH). If Python's folder isn't in that list, Windows says "command not found."

### Installation on Linux (Ubuntu/Debian)

```bash
# Update package list
sudo apt update

# Install Python and pip
sudo apt install python3 python3-pip python3-venv -y

# Verify
python3 --version
pip3 --version
```

**Why `python3` instead of `python`?**

On many Linux systems, `python` points to Python 2 (legacy). `python3` explicitly calls Python 3. In production, always be explicit about which version you're using.

### Installation on macOS

```bash
# Install Homebrew first (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Python
brew install python

# Verify
python3 --version
pip3 --version
```

### What Gets Installed

When you install Python, you get:

| Component | Purpose |
|-----------|---------|
| `python` or `python3` | The interpreter that runs your code |
| `pip` | Package installer (like an app store for Python libraries) |
| Standard Library | 200+ built-in modules (os, sys, json, etc.) |
| IDLE | Basic Python editor (not recommended for serious work) |
| `venv` module | Creates isolated environments |

### Common Mistakes

1. **Not checking "Add to PATH"** on Windows — most common beginner error
2. **Using system Python** on Linux for projects (can break your OS)
3. **Installing Python 2** instead of Python 3
4. **Not installing pip** alongside Python

### Debugging Tips

| Problem | Solution |
|---------|----------|
| `python: command not found` | Add Python to PATH or use `python3` |
| `pip: command not found` | Use `pip3` or `python -m pip` |
| Permission denied | Use `--user` flag or virtual environment |
| Wrong version showing | Check PATH order, use full path |

### Production Considerations

In production servers:
- **Never use system Python** for applications
- Always use virtual environments or containers
- Pin your Python version (e.g., Python 3.11.x)
- Use pyenv for managing multiple versions
- Document the exact Python version in your project

---

## 2.3 PATH Configuration

### 🎯 Learning Objectives

- Understand what PATH is and why it matters
- Configure PATH on any operating system
- Debug PATH-related issues

### Real-Life Analogy

Imagine you're in a massive library. You ask the librarian for a book called "python." The librarian checks a specific list of shelves (the PATH). If "python" isn't on any of those shelves, the librarian says "book not found" — even if the book exists somewhere else in the library.

PATH is that list of shelves (folders) your operating system checks when you type a command.

### What Problem It Solves

When you type `python` in your terminal, your OS needs to find the actual Python executable file. PATH tells the OS which directories to search.

### How It Works Internally

```
You type: python script.py
       ↓
OS reads PATH variable (a list of directories)
       ↓
OS searches each directory in order:
  /usr/local/bin/ → found python? No → next
  /usr/bin/ → found python? Yes → execute it
       ↓
Python runs your script
```

### Viewing PATH

**Windows (Command Prompt):**
```cmd
echo %PATH%
```

**Windows (PowerShell):**
```powershell
$env:PATH
```

**Linux/macOS:**
```bash
echo $PATH
```

**Expected Output (Linux example):**
```
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/home/user/.local/bin
```

Each path is separated by `:` (Linux/macOS) or `;` (Windows).

### Adding to PATH

**Linux/macOS (temporary — current session only):**
```bash
export PATH="/path/to/python:$PATH"
```

**Linux/macOS (permanent):**
```bash
# Add to ~/.bashrc or ~/.zshrc
echo 'export PATH="/usr/local/bin/python3:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Windows (permanent):**
1. Search "Environment Variables" in Start Menu
2. Click "Environment Variables"
3. Under "System variables," find PATH
4. Click "Edit" → "New"
5. Add `C:\Python312\` and `C:\Python312\Scripts\`

### Why PATH Order Matters

If you have Python 3.11 and 3.12 both installed, the one whose directory appears **first** in PATH wins. This is a common source of confusion.

```bash
# Check which Python is being used
which python3      # Linux/macOS
where python       # Windows
```

### Best Practices

1. Always put your preferred Python version first in PATH
2. Use `which python3` to verify you're using the right one
3. In CI/CD pipelines, always use full paths or version managers
4. Document PATH requirements in project README

---

## 2.4 Python Interpreter

### 🎯 Learning Objectives

- Understand what the interpreter is and how to use it
- Know the difference between interactive mode and script mode
- Understand the execution flow

### What It Is

The Python interpreter is the program that reads and executes your Python code. It's the "engine" that makes Python work.

### Two Modes of Operation

| Mode | How to Use | Purpose |
|------|-----------|---------|
| Interactive (REPL) | Type `python3` in terminal | Quick testing, exploration |
| Script Mode | `python3 script.py` | Running programs |

**REPL** = Read-Eval-Print Loop:
1. **Read**: Python reads what you typed
2. **Eval**: Python evaluates (executes) it
3. **Print**: Python prints the result
4. **Loop**: Goes back to step 1

### Simple Example (Interactive Mode)

```python
>>> 2 + 3
5
>>> print("Hello, DevOps!")
Hello, DevOps!
>>> exit()
```

### Line-by-Line Explanation

- `>>>` is the Python prompt — it means Python is waiting for your input
- `2 + 3` — Python evaluates this expression and prints the result `5`
- `print("Hello, DevOps!")` — the `print()` function displays text on screen
- `exit()` — leaves the interactive interpreter

### Script Mode

Create a file called `hello.py`:
```python
print("Hello from a script!")
```

Run it:
```bash
python3 hello.py
```

**Expected Output:**
```
Hello from a script!
```

### How Execution Flow Works

```
python3 hello.py
       ↓
Interpreter reads entire file
       ↓
Compiles to bytecode (in memory or __pycache__)
       ↓
Executes line by line, top to bottom
       ↓
Program ends, Python exits
```

---

## 2.5 pip & Package Management

### 🎯 Learning Objectives

- Understand what pip is and why it exists
- Install, upgrade, and remove packages
- Understand requirements.txt and dependency pinning

### Real-Life Analogy

pip is like an **app store** for Python. Just like you install apps on your phone from the App Store or Google Play, you install Python libraries from PyPI (Python Package Index) using pip.

### What Problem It Solves

Python's standard library is powerful, but it can't do everything. Need to make HTTP requests easily? Install `requests`. Need to interact with AWS? Install `boto3`. Need to parse YAML? Install `pyyaml`. pip makes this possible with one command.

### How It Works Internally

```
pip install requests
       ↓
pip contacts PyPI (pypi.org)
       ↓
Downloads the package and its dependencies
       ↓
Installs into site-packages directory
       ↓
Package is now importable in your code
```

### Essential Commands

```bash
# Install a package
pip install requests

# Install a specific version
pip install requests==2.31.0

# Upgrade a package
pip install --upgrade requests

# Uninstall
pip uninstall requests

# List installed packages
pip list

# Show package details
pip show requests

# Freeze current packages to a file
pip freeze > requirements.txt

# Install from requirements file
pip install -r requirements.txt
```

### requirements.txt

This file lists all packages your project needs. It solves the problem of "it works on my machine but not on the server."

```text
requests==2.31.0
boto3==1.34.0
pyyaml==6.0.1
pytest==7.4.0
```

### Why Pin Versions?

Without version pinning:
```text
requests        # Could install 2.31 today, 3.0 tomorrow (breaking changes!)
```

With version pinning:
```text
requests==2.31.0   # Always installs exactly this version
```

**Production Rule:** Always pin versions in production. Unpinned dependencies are a ticking time bomb.

### Common Mistakes

1. Installing packages globally instead of in virtual environments
2. Not pinning versions in requirements.txt
3. Using `sudo pip install` (dangerous on Linux)
4. Not updating pip itself (`pip install --upgrade pip`)

---

## 2.6 Virtual Environments

### 🎯 Learning Objectives

- Understand what virtual environments are and why they're essential
- Create, activate, and manage virtual environments
- Know when and why to use them

### Real-Life Analogy

Imagine you have two projects:
- Project A needs `requests` version 2.25
- Project B needs `requests` version 2.31

If both projects share the same Python installation, you can only have ONE version installed. This creates a conflict. 

A virtual environment is like giving each project its own **separate apartment** with its own furniture (packages). They don't interfere with each other.

### What Problem It Solves

| Without Virtual Env | With Virtual Env |
|-------------------|-----------------|
| All projects share packages | Each project has isolated packages |
| Version conflicts inevitable | No version conflicts |
| Breaking one project breaks all | Projects are independent |
| Can break system Python | System Python stays clean |

### How It Works Internally

```
python3 -m venv myenv
       ↓
Creates a new directory 'myenv/' containing:
  - bin/ (or Scripts/ on Windows): Python executable copy
  - lib/: Empty site-packages for this env only
  - pyvenv.cfg: Configuration file
       ↓
When activated, PATH is modified to point to myenv/bin first
       ↓
Any 'pip install' now goes into myenv/lib/site-packages
```

### Creating and Using Virtual Environments

```bash
# Create a virtual environment
python3 -m venv myproject_env

# Activate it
# Linux/macOS:
source myproject_env/bin/activate

# Windows:
myproject_env\Scripts\activate

# Your prompt changes to show the active env:
(myproject_env) $

# Install packages (goes into the virtual env only)
pip install requests boto3

# Deactivate when done
deactivate
```

### Best Practices

1. **One virtual environment per project** — never share
2. **Never commit the venv folder to Git** — add to `.gitignore`
3. **Always use requirements.txt** — so others can recreate your env
4. **Name it descriptively** — `venv`, `.venv`, or `projectname_env`

### Production Workflow

```bash
# Standard project setup
mkdir my_devops_project
cd my_devops_project
python3 -m venv .venv
source .venv/bin/activate
pip install requests boto3 pyyaml
pip freeze > requirements.txt

# .gitignore
echo ".venv/" >> .gitignore
```

### Interview Perspective

> **Q: Why do we use virtual environments?**
> A: To isolate project dependencies, prevent version conflicts between projects, avoid polluting the system Python, and ensure reproducible builds across different machines and environments.

---

## 2.7 Pyenv & Multiple Versions

### 🎯 Learning Objectives

- Understand why you might need multiple Python versions
- Install and use pyenv
- Set global and local Python versions

### What Problem It Solves

- Project A requires Python 3.9 (legacy)
- Project B requires Python 3.12 (latest features)
- Your CI/CD pipeline tests against Python 3.10, 3.11, and 3.12

Pyenv lets you install and switch between multiple Python versions effortlessly.

### Installation (Linux/macOS)

```bash
# Install pyenv
curl https://pyenv.run | bash

# Add to shell config (~/.bashrc or ~/.zshrc)
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

# Restart shell
exec "$SHELL"
```

### Usage

```bash
# List available versions
pyenv install --list

# Install specific versions
pyenv install 3.11.9
pyenv install 3.12.4

# Set global default
pyenv global 3.12.4

# Set local version for a project directory
cd my_project/
pyenv local 3.11.9
# Creates .python-version file in this directory

# Check current version
pyenv version
```

### Key Takeaways — Module 2 Summary

| Concept | Key Point |
|---------|-----------|
| Python | Compiled to bytecode, then interpreted by PVM |
| PATH | List of directories OS searches for executables |
| pip | Python's package installer, always pin versions |
| Virtual Environments | Isolated package spaces per project |
| pyenv | Manages multiple Python versions |
| requirements.txt | Reproducible dependency list |

---

# Module 3: Python Fundamentals

## 3.1 Variables & Memory

### 🎯 Learning Objectives

- Understand what variables are in Python
- Know how Python handles memory differently from other languages
- Understand reference semantics

### Real-Life Analogy

In most programming languages, a variable is like a **box** — you put a value inside the box.

In Python, a variable is like a **name tag** (sticky note) — you attach the name tag to an object that already exists in memory. Multiple name tags can point to the same object.

This distinction is **critical** and causes confusion for many beginners.

### What Problem Variables Solve

Without variables, you'd have to repeat values everywhere:
```python
# Without variables (impossible to maintain)
print(3.14159 * 5 * 5)  # Area of circle with radius 5
print(3.14159 * 10 * 10)  # Area of circle with radius 10

# With variables (clear and maintainable)
pi = 3.14159
radius = 5
area = pi * radius * radius
print(area)
```

### How Python Variables Work Internally

```python
x = 42
```

What happens in memory:
```
Step 1: Python creates an integer object 42 in memory
Step 2: Python creates a name 'x'
Step 3: Python makes 'x' point (refer) to the object 42

Memory:
  x ──────→ [ 42 ]  (integer object at some memory address)
```

```python
y = x
```

```
Now:
  x ──────→ [ 42 ]  ←────── y
  
Both x and y point to the SAME object! No copy is made.
```

```python
x = 100
```

```
Now:
  x ──────→ [ 100 ]  (new object)
  y ──────→ [ 42 ]   (still points to original)
```

### You can verify this with `id()`

```python
x = 42
y = x
print(id(x))  # Memory address of object x points to
print(id(y))  # Same address! Same object!

x = 100
print(id(x))  # Different address now
print(id(y))  # Still the old address
```

### Variable Naming Rules

| Rule | Valid | Invalid |
|------|-------|---------|
| Start with letter or _ | `name`, `_count` | `2name` |
| Can contain letters, numbers, _ | `server_1` | `server-1` |
| Case sensitive | `Name` ≠ `name` | — |
| No reserved keywords | `my_class` | `class` |

### Naming Conventions (PEP 8)

```python
# Variables and functions: snake_case
server_count = 5
user_name = "admin"

# Constants: UPPER_SNAKE_CASE
MAX_RETRIES = 3
DATABASE_URL = "postgresql://..."

# Classes: PascalCase
class ServerManager:
    pass

# Private: prefix with underscore
_internal_cache = {}
```

### Common Mistakes

1. **Thinking `=` creates a copy** — it creates a reference
2. **Using mutable default arguments** — this is a famous Python gotcha (covered later)
3. **Naming variables like built-ins** — `list = [1,2,3]` breaks `list()` function

### Interview Perspective

> **Q: What happens when you do `a = b` in Python?**
> A: Python does NOT copy the value. It makes `a` reference (point to) the same object that `b` references. Both names now refer to the same object in memory. You can verify using `id()`.

---

## 3.2 Data Types

### 🎯 Learning Objectives

- Know all Python built-in data types
- Understand when to use each type
- Understand mutability vs immutability

### Why Data Types Exist

Data types tell Python how to store data and what operations are allowed on it. You can add numbers but not divide strings. Data types enforce these rules.

### Python's Built-in Data Types

| Category | Types | Mutable? |
|----------|-------|----------|
| Numeric | `int`, `float`, `complex` | ❌ Immutable |
| Text | `str` | ❌ Immutable |
| Boolean | `bool` | ❌ Immutable |
| Sequence | `list` | ✅ Mutable |
| Sequence | `tuple` | ❌ Immutable |
| Mapping | `dict` | ✅ Mutable |
| Set | `set` | ✅ Mutable |
| Set | `frozenset` | ❌ Immutable |
| None | `NoneType` | ❌ Immutable |

### Mutability: The Most Important Concept

**Mutable** = Can be changed after creation (like a whiteboard — you can erase and rewrite)

**Immutable** = Cannot be changed after creation (like a printed book — you can't edit it, only create a new edition)

```python
# Immutable: strings
name = "hello"
# name[0] = "H"  # ERROR! Strings cannot be modified in place

# Mutable: lists
servers = ["web1", "web2"]
servers[0] = "web3"  # OK! Lists can be modified in place
```

### Why Mutability Matters in DevOps

When you pass a mutable object (like a list) to a function, the function can modify the original. This is a common source of bugs:

```python
def add_default_tags(tags):
    tags.append("environment:production")  # Modifies the ORIGINAL list!
    return tags

my_tags = ["team:platform"]
result = add_default_tags(my_tags)
print(my_tags)  # ['team:platform', 'environment:production'] — MODIFIED!
```

### Checking Types

```python
x = 42
print(type(x))      # <class 'int'>
print(isinstance(x, int))  # True
```

---

## 3.3 Strings

### 🎯 Learning Objectives

- Understand strings deeply
- Master string methods used daily in DevOps
- Understand f-strings and formatting

### What Strings Are

A string is a sequence of characters (text). In DevOps, strings are everywhere: server names, file paths, log messages, API responses, configuration values, command outputs.

### Creating Strings

```python
# Single quotes
name = 'web-server-01'

# Double quotes (same as single)
message = "Deployment successful"

# Triple quotes (multiline)
config = """
server:
  host: 10.0.0.1
  port: 8080
"""

# Raw strings (backslashes are literal — useful for paths and regex)
path = r"C:\Users\admin\scripts"
```

### Strings Are Immutable

```python
server = "web-01"
# server[0] = "W"  # TypeError! Cannot modify strings
server = "Web-01"  # This creates a NEW string, doesn't modify the old one
```

### Essential String Methods for DevOps

```python
hostname = "  Web-Server-01.prod.internal  "

# strip() - Remove whitespace (critical for parsing command output)
clean = hostname.strip()          # "Web-Server-01.prod.internal"

# split() - Break into list (parsing logs, CSV, paths)
parts = "error:disk:full".split(":")  # ['error', 'disk', 'full']

# join() - Combine list into string
path = "/".join(["home", "user", "scripts"])  # "home/user/scripts"

# replace() - Replace substring
new_host = hostname.replace("prod", "staging")

# startswith() / endswith() - Check prefix/suffix
if filename.endswith(".yaml"):
    print("YAML configuration file")

# upper() / lower()
env = "Production".lower()  # "production"

# find() - Find position of substring (-1 if not found)
pos = log_line.find("ERROR")

# count() - Count occurrences
error_count = log_data.count("ERROR")

# format methods
```

### f-Strings (Modern Formatting — Python 3.6+)

```python
server = "web-01"
status = "healthy"
cpu = 45.7

message = f"Server {server} is {status} with {cpu}% CPU usage"
print(message)
```

**Expected Output:**
```
Server web-01 is healthy with 45.7% CPU usage
```

**Line-by-Line Explanation:**
- `f"..."` — the `f` prefix tells Python this is a formatted string
- `{server}` — Python replaces this with the value of the `server` variable
- `{cpu}` — Python replaces this with the value of `cpu`
- This is the most readable way to create strings with dynamic values

### Production Scenario: Parsing Log Lines

```python
log_line = "2024-01-15 10:23:45 ERROR [web-server-01] Disk usage at 95%"

# Extract components
parts = log_line.split(" ")
date = parts[0]           # "2024-01-15"
time = parts[1]           # "10:23:45"
level = parts[2]          # "ERROR"
server = parts[3].strip("[]")  # "web-server-01"
```

---

## 3.4 Numbers

### 🎯 Learning Objectives

- Understand int, float, and their behaviors
- Know about integer division vs true division
- Understand floating-point precision issues

### Types of Numbers

```python
# Integer (whole numbers, unlimited size in Python)
server_count = 150
max_connections = 10000

# Float (decimal numbers)
cpu_usage = 78.5
response_time = 0.045  # 45 milliseconds

# Scientific notation
large_number = 1.5e6  # 1,500,000
```

### Important Operations

```python
# Division
print(10 / 3)   # 3.3333... (true division, always returns float)
print(10 // 3)  # 3 (floor division, returns integer)
print(10 % 3)   # 1 (modulo — remainder)
print(2 ** 10)  # 1024 (exponentiation)
```

### Floating Point Precision Warning

```python
print(0.1 + 0.2)  # 0.30000000000000004 (NOT 0.3!)
```

**Why?** Computers store numbers in binary. Some decimal fractions (like 0.1) cannot be represented exactly in binary, causing tiny rounding errors.

**Solution for financial calculations:**
```python
from decimal import Decimal
result = Decimal('0.1') + Decimal('0.2')  # Decimal('0.3') — exact!
```

---

## 3.5 Booleans

### 🎯 Learning Objectives

- Understand True/False and truthiness
- Know what Python considers "truthy" and "falsy"

### What Booleans Are

Booleans represent **truth values** — either `True` or `False`. They are the foundation of all decision-making in code.

### Truthy and Falsy Values

In Python, EVERYTHING has a truth value, not just `True` and `False`:

| Falsy (evaluates to False) | Truthy (evaluates to True) |
|---------------------------|---------------------------|
| `False` | `True` |
| `0`, `0.0` | Any non-zero number |
| `""` (empty string) | Any non-empty string |
| `[]` (empty list) | Any non-empty list |
| `{}` (empty dict) | Any non-empty dict |
| `None` | Everything else |

### Why This Matters in DevOps

```python
# Instead of this:
if len(servers) > 0:
    deploy(servers)

# Pythonic way (uses truthiness):
if servers:  # Empty list is falsy, non-empty is truthy
    deploy(servers)
```

---

## 3.6 Lists

### 🎯 Learning Objectives

- Understand lists as ordered, mutable sequences
- Master essential list operations
- Understand when to use lists in DevOps

### Real-Life Analogy

A list is like a **numbered shopping list** — items are in a specific order, you can add/remove items, and you can have duplicates.

### What Problem Lists Solve

You need to store **multiple related values** together and be able to modify the collection:
- List of server IPs
- List of failed deployments
- List of log entries
- List of configuration files to process

### Creating and Using Lists

```python
# Creating lists
servers = ["web-01", "web-02", "web-03"]
ports = [80, 443, 8080]
mixed = ["web-01", 80, True, 3.14]  # Can mix types (but rarely should)

# Accessing elements (0-indexed)
first = servers[0]    # "web-01"
last = servers[-1]    # "web-03" (negative indexing from end)

# Slicing
subset = servers[0:2]  # ["web-01", "web-02"] (start inclusive, end exclusive)
```

### Essential List Methods

```python
servers = ["web-01", "web-02"]

# Add elements
servers.append("web-03")          # Add to end: ["web-01", "web-02", "web-03"]
servers.insert(0, "web-00")       # Add at index 0

# Remove elements
servers.remove("web-01")          # Remove by value
popped = servers.pop()            # Remove and return last item
del servers[0]                    # Remove by index

# Search
index = servers.index("web-02")   # Find position
count = servers.count("web-01")   # Count occurrences
exists = "web-03" in servers      # True/False

# Sort
servers.sort()                    # Sort in place
sorted_list = sorted(servers)     # Returns new sorted list

# Length
total = len(servers)
```

### Common Mistake: Aliasing

```python
original = [1, 2, 3]
copy = original      # NOT a copy! Both point to same list!
copy.append(4)
print(original)      # [1, 2, 3, 4] — original is modified!

# Correct way to copy:
real_copy = original.copy()
# or
real_copy = original[:]
# or
real_copy = list(original)
```

---

## 3.7 Tuples

### 🎯 Learning Objectives

- Understand tuples as immutable sequences
- Know when to choose tuples over lists

### What Tuples Are

Tuples are like lists but **immutable** — once created, they cannot be modified. Think of them as "read-only lists."

### When to Use Tuples vs Lists

| Use Tuple When | Use List When |
|---------------|--------------|
| Data shouldn't change | Data needs to be modified |
| Returning multiple values from function | Collection that grows/shrinks |
| Dictionary keys (must be immutable) | Order matters and items change |
| Configuration that's fixed | Processing items one by one |

```python
# Tuple creation
coordinates = (10.5, 20.3)
server_info = ("web-01", "10.0.0.1", 8080)

# Accessing (same as lists)
host = server_info[0]  # "web-01"

# Cannot modify!
# server_info[0] = "web-02"  # TypeError!

# Tuple unpacking (very common in Python)
name, ip, port = server_info
print(f"Server {name} at {ip}:{port}")
```

### Why Tuples Exist

1. **Safety** — data that shouldn't change can't be accidentally modified
2. **Performance** — tuples are slightly faster than lists
3. **Hashable** — tuples can be dictionary keys; lists cannot
4. **Intent** — using a tuple signals "this data is fixed"

---

## 3.8 Dictionaries

### 🎯 Learning Objectives

- Understand dictionaries as key-value mappings
- Master dictionary operations essential for DevOps
- Understand where dictionaries are used in real systems

### Real-Life Analogy

A dictionary is like a **real dictionary** — you look up a word (key) to find its definition (value). Or think of it as a **contact list** — you look up a name (key) to find a phone number (value).

### What Problem Dictionaries Solve

Lists access items by position (index 0, 1, 2...). But what if you want to access data by a meaningful name?

```python
# With lists — confusing, position-dependent
server = ["web-01", "10.0.0.1", 8080, "healthy"]
# What is server[2]? You have to remember the order!

# With dictionary — clear and self-documenting
server = {
    "name": "web-01",
    "ip": "10.0.0.1",
    "port": 8080,
    "status": "healthy"
}
print(server["ip"])  # Clear what you're accessing
```

### Where Dictionaries Are Used in DevOps

- **JSON responses** from APIs (all JSON objects become dicts)
- **YAML configuration** files (parsed into dicts)
- **Environment configuration** (key-value pairs)
- **Terraform state** files
- **Kubernetes manifests** (when parsed)
- **Cloud resource metadata**

### Essential Dictionary Operations

```python
# Creating
server = {"name": "web-01", "ip": "10.0.0.1", "port": 8080}

# Accessing
name = server["name"]               # "web-01" (KeyError if not found)
name = server.get("name")           # "web-01" (None if not found)
name = server.get("region", "us-east-1")  # Default value if not found

# Adding/Updating
server["status"] = "healthy"        # Add new key
server["port"] = 443                # Update existing key

# Removing
del server["port"]                  # Remove key (KeyError if missing)
port = server.pop("port", None)     # Remove and return (None if missing)

# Checking membership
if "ip" in server:                  # Check if key exists
    print(server["ip"])

# Iterating
for key, value in server.items():
    print(f"{key}: {value}")

# Useful methods
keys = server.keys()                # All keys
values = server.values()            # All values
items = server.items()              # All key-value pairs as tuples
```

### Nested Dictionaries (Common in DevOps)

```python
infrastructure = {
    "production": {
        "web_servers": ["10.0.1.1", "10.0.1.2"],
        "database": {
            "host": "db.prod.internal",
            "port": 5432
        }
    },
    "staging": {
        "web_servers": ["10.0.2.1"],
        "database": {
            "host": "db.staging.internal",
            "port": 5432
        }
    }
}

# Accessing nested values
db_host = infrastructure["production"]["database"]["host"]
```

---

## 3.9 Sets

### 🎯 Learning Objectives

- Understand sets as unordered collections of unique elements
- Know when sets are the right choice

### What Sets Are

A set is an **unordered collection with no duplicates**. Think of it as a bag of unique items where order doesn't matter.

### What Problem Sets Solve

```python
# Finding unique values
all_ips = ["10.0.0.1", "10.0.0.2", "10.0.0.1", "10.0.0.3", "10.0.0.2"]
unique_ips = set(all_ips)  # {"10.0.0.1", "10.0.0.2", "10.0.0.3"}

# Finding differences between environments
prod_servers = {"web-01", "web-02", "web-03", "web-04"}
staging_servers = {"web-01", "web-02"}

# Servers in prod but not in staging
only_in_prod = prod_servers - staging_servers  # {"web-03", "web-04"}

# Servers in both
in_both = prod_servers & staging_servers  # {"web-01", "web-02"}

# All servers combined
all_servers = prod_servers | staging_servers
```

### Set Operations

| Operation | Symbol | Method | Result |
|-----------|--------|--------|--------|
| Union | `\|` | `.union()` | All items from both |
| Intersection | `&` | `.intersection()` | Items in both |
| Difference | `-` | `.difference()` | Items in first but not second |
| Symmetric Difference | `^` | `.symmetric_difference()` | Items in either but not both |

---

## 3.10 Operators

### 🎯 Learning Objectives

- Understand all Python operators
- Know operator precedence

### Operator Categories

```python
# Arithmetic: +, -, *, /, //, %, **
# Comparison: ==, !=, <, >, <=, >=
# Logical: and, or, not
# Assignment: =, +=, -=, *=, /=
# Membership: in, not in
# Identity: is, is not
```

### Critical Distinction: `==` vs `is`

```python
# == checks VALUE equality
# is checks IDENTITY (same object in memory)

a = [1, 2, 3]
b = [1, 2, 3]
print(a == b)   # True (same values)
print(a is b)   # False (different objects in memory)

c = a
print(a is c)   # True (same object)
```

**Rule:** Use `==` for value comparison. Use `is` only for `None` checks:
```python
if result is None:    # Correct
    handle_error()
```

---

## 3.11 Conditional Statements

### 🎯 Learning Objectives

- Write if/elif/else statements
- Understand conditional logic in automation

### What Problem It Solves

Programs need to make decisions. "If the server is down, restart it. Otherwise, log that it's healthy."

### Syntax and Examples

```python
cpu_usage = 85

if cpu_usage > 90:
    print("CRITICAL: CPU usage above 90%!")
    # trigger_alert()
elif cpu_usage > 70:
    print("WARNING: CPU usage above 70%")
    # log_warning()
else:
    print("OK: CPU usage normal")
```

**Expected Output:**
```
WARNING: CPU usage above 70%
```

**Line-by-Line Explanation:**
- `cpu_usage = 85` — assigns value 85 to variable
- `if cpu_usage > 90:` — checks if 85 > 90. False, so skips this block
- `elif cpu_usage > 70:` — checks if 85 > 70. True! Executes this block
- `print(...)` — prints the warning message
- `else:` — would execute if both conditions above were False (skipped here)

### Ternary Operator (one-line if)

```python
status = "healthy" if cpu_usage < 80 else "warning"
```

---

## 3.12 Loops

### 🎯 Learning Objectives

- Understand for loops and while loops
- Know when to use each
- Master loop patterns used in DevOps

### Real-Life Analogy

A **for loop** is like going through a checklist — you do something for each item in the list, then stop.

A **while loop** is like waiting for a bus — you keep waiting *while* the bus hasn't arrived. Once it arrives, you stop.

### For Loop

```python
servers = ["web-01", "web-02", "web-03"]

for server in servers:
    print(f"Checking health of {server}...")
```

**Expected Output:**
```
Checking health of web-01...
Checking health of web-02...
Checking health of web-03...
```

### While Loop (with DevOps example)

```python
# Retry logic — keep trying until success or max retries
max_retries = 3
attempt = 0
success = False

while attempt < max_retries and not success:
    attempt += 1
    print(f"Deployment attempt {attempt}...")
    # success = deploy()  # Would be real deployment logic
    success = (attempt == 3)  # Simulating success on 3rd try

if success:
    print("Deployment successful!")
else:
    print("Deployment failed after all retries!")
```

### Loop Control: break, continue, else

```python
# break — exit loop immediately
for server in servers:
    if server == "web-02":
        print("Found target server!")
        break  # Stop searching

# continue — skip to next iteration
for server in servers:
    if server.startswith("db-"):
        continue  # Skip database servers
    print(f"Deploying to {server}")

# enumerate — get index and value
for index, server in enumerate(servers):
    print(f"{index + 1}. {server}")
```

### Common Mistake: Modifying a list while iterating

```python
# WRONG — will skip items or crash
servers = ["web-01", "web-02", "web-03"]
for server in servers:
    if "02" in server:
        servers.remove(server)  # Don't do this!

# CORRECT — iterate over a copy or use list comprehension
servers = [s for s in servers if "02" not in s]
```

---

### Module 3 Section Summary

| Topic | Key Takeaway |
|-------|-------------|
| Variables | Name tags pointing to objects, not boxes |
| Data Types | Know mutability — it prevents bugs |
| Strings | Immutable, f-strings for formatting |
| Lists | Ordered, mutable, use for collections that change |
| Tuples | Immutable lists, use for fixed data |
| Dicts | Key-value pairs, foundation of JSON/YAML/configs |
| Sets | Unique items, great for comparisons |
| Conditionals | Decision-making in code |
| Loops | Repetition — for (known items), while (until condition) |

---

# Module 4: Functions & Scope

## 4.1 Functions

### 🎯 Learning Objectives

- Understand what functions are and why they exist
- Write functions with parameters and return values
- Understand the DRY principle

### Real-Life Analogy

A function is like a **recipe**. You give it ingredients (parameters), it follows steps (function body), and produces a dish (return value). Once you write the recipe, you can use it as many times as you want without rewriting the steps.

### What Problem Functions Solve

Without functions, you'd copy-paste the same code everywhere. If you need to change the logic, you'd have to change it in 50 places. Functions solve:

1. **Code Reusability** — write once, use everywhere
2. **Maintainability** — change in one place, fixed everywhere
3. **Readability** — name describes what code does
4. **Testing** — test individual units of logic
5. **Abstraction** — hide complexity behind a simple name

### How Functions Work Internally

```
1. Function DEFINITION — Python stores the function code in memory
2. Function CALL — Python creates a new "frame" (execution context)
3. Parameters receive argument values
4. Function body executes line by line
5. return sends a value back to the caller
6. Frame is destroyed, local variables disappear
```

### Simple Example

```python
def check_disk_usage(used_percent):
    """Check if disk usage is critical."""
    if used_percent > 90:
        return "CRITICAL"
    elif used_percent > 70:
        return "WARNING"
    else:
        return "OK"

# Calling the function
status = check_disk_usage(85)
print(status)  # "WARNING"
```

**Line-by-Line Explanation:**
- `def` — keyword that defines a function
- `check_disk_usage` — function name (descriptive, snake_case)
- `(used_percent)` — parameter (input the function expects)
- `"""..."""` — docstring (documents what function does)
- `if/elif/else` — decision logic inside function
- `return "CRITICAL"` — sends value back to whoever called the function
- `status = check_disk_usage(85)` — calls function with argument 85, stores result

### Parameters vs Arguments

```python
def greet(name):       # 'name' is a PARAMETER (in definition)
    return f"Hello, {name}!"

greet("Alice")         # "Alice" is an ARGUMENT (in call)
```

### Default Parameters

```python
def deploy(service, environment="staging", replicas=1):
    print(f"Deploying {service} to {environment} with {replicas} replicas")

deploy("api")                          # Uses defaults
deploy("api", "production", 3)         # Overrides defaults
deploy("api", replicas=5)              # Keyword argument
```

### Return Values

```python
# Single return
def add(a, b):
    return a + b

# Multiple return values (actually returns a tuple)
def get_server_stats():
    return 85.5, 2048, 150  # cpu, memory_mb, connections

cpu, memory, connections = get_server_stats()  # Tuple unpacking

# No return = returns None implicitly
def log_message(msg):
    print(msg)
    # No return statement → returns None
```

### Best Practices

1. **Single Responsibility** — each function does ONE thing
2. **Descriptive names** — `get_server_status()` not `func1()`
3. **Docstrings** — always document what function does
4. **Small functions** — if it's over 20 lines, split it
5. **No side effects** — prefer returning values over modifying globals

---

## 4.2 Scope & LEGB Rule

### 🎯 Learning Objectives

- Understand where variables are accessible
- Master the LEGB rule

### What Scope Is

Scope determines **where a variable can be accessed**. A variable created inside a function can't be seen outside it.

### LEGB Rule

Python searches for variable names in this order:

```
L — Local      (inside current function)
E — Enclosing  (inside enclosing/outer function)
G — Global     (module level)
B — Built-in   (Python's built-in names like print, len)
```

```python
x = "global"           # Global scope

def outer():
    x = "enclosing"    # Enclosing scope
    
    def inner():
        x = "local"    # Local scope
        print(x)       # Finds "local" first (L)
    
    inner()

outer()  # Prints: "local"
```

### The `global` and `nonlocal` Keywords

```python
counter = 0

def increment():
    global counter    # Without this, Python creates a LOCAL 'counter'
    counter += 1

increment()
print(counter)  # 1
```

**Best Practice:** Avoid `global`. Pass values as parameters and return results instead.

---

## 4.3 *args and **kwargs

### 🎯 Learning Objectives

- Understand variable-length arguments
- Know when to use *args and **kwargs

### What Problem They Solve

Sometimes you don't know in advance how many arguments a function will receive.

```python
# *args — accepts any number of positional arguments (as a tuple)
def log_servers(*servers):
    for server in servers:
        print(f"Logging: {server}")

log_servers("web-01")
log_servers("web-01", "web-02", "web-03")

# **kwargs — accepts any number of keyword arguments (as a dict)
def create_resource(**config):
    for key, value in config.items():
        print(f"  {key}: {value}")

create_resource(name="web-01", region="us-east-1", type="t3.medium")
```

**Expected Output for create_resource:**
```
  name: web-01
  region: us-east-1
  type: t3.medium
```

### Where Used in DevOps

- Wrapper functions that pass arguments to underlying tools
- Decorator functions (must accept any function signature)
- API client libraries
- Configuration builders

---

## 4.4 Lambda Functions

### 🎯 Learning Objectives

- Understand anonymous functions
- Know when to use (and when NOT to use) lambdas

### What Lambda Is

A lambda is a small, unnamed (anonymous) function written in one line.

```python
# Regular function
def double(x):
    return x * 2

# Same thing as lambda
double = lambda x: x * 2
```

### When to Use Lambdas

Only use them as short, throwaway functions — typically as arguments to `sorted()`, `filter()`, `map()`:

```python
servers = [
    {"name": "web-01", "cpu": 85},
    {"name": "web-02", "cpu": 45},
    {"name": "web-03", "cpu": 92},
]

# Sort by CPU usage
sorted_servers = sorted(servers, key=lambda s: s["cpu"], reverse=True)
# Result: web-03 (92), web-01 (85), web-02 (45)
```

### When NOT to Use Lambdas

- If it's more than one line of logic
- If you need to reuse it
- If it reduces readability

---

## 4.5 Closures

### 🎯 Learning Objectives

- Understand closures as the foundation for decorators
- Know how inner functions "remember" outer variables

### What Problem Closures Solve

Sometimes you need a function that "remembers" some state from when it was created, without using global variables or classes.

### Real-Life Analogy

Imagine a factory that makes greeting cards. You tell the factory "make cards that say 'Happy Birthday'" and it gives you a machine. That machine always produces "Happy Birthday" cards — it "remembers" the greeting even though you specified it only once.

### How Closures Work

```python
def make_multiplier(factor):
    """Factory that creates multiplier functions."""
    def multiply(number):
        return number * factor  # 'factor' comes from enclosing scope
    return multiply  # Return the inner function (not calling it!)

double = make_multiplier(2)   # factor=2 is "enclosed"
triple = make_multiplier(3)   # factor=3 is "enclosed"

print(double(5))   # 10
print(triple(5))   # 15
```

**How it works internally:**
1. `make_multiplier(2)` executes, creating `multiply` with `factor=2` in its enclosing scope
2. Even after `make_multiplier` finishes, `multiply` "remembers" `factor=2`
3. This remembered environment is the **closure**

### Where Closures Are Used

- **Decorators** (the most important use case — next section)
- Configuration factories
- Callback functions
- Data hiding (encapsulation without classes)

---

## 4.6 Decorators

### 🎯 Learning Objectives

- Understand decorators deeply (this is a major interview topic)
- Know how they work internally using closures
- Use functools.wraps correctly

### Why This Topic Is Critical

Decorators appear in nearly every Python framework:
- `@app.route("/")` in Flask
- `@pytest.fixture` in testing
- `@retry(max_attempts=3)` in automation
- `@login_required` in web apps
- `@property` in classes

If you don't understand decorators, you can't understand these frameworks.

### What Problem Decorators Solve

You want to add behavior to existing functions **without modifying their code**. Examples:
- Add logging to every function
- Add retry logic to API calls
- Measure execution time
- Check authentication before running a function
- Cache results

### Building Up to Decorators (Step by Step)

**Step 1: Functions are objects in Python**
```python
def greet():
    return "Hello!"

# Functions can be assigned to variables
say_hello = greet
print(say_hello())  # "Hello!"

# Functions can be passed as arguments
def call_twice(func):
    func()
    func()
```

**Step 2: Functions can return other functions**
```python
def outer():
    def inner():
        print("I'm inner!")
    return inner  # Return function, don't call it

my_func = outer()
my_func()  # "I'm inner!"
```

**Step 3: Putting it together — A decorator**
```python
def log_calls(func):
    """Decorator that logs when a function is called."""
    def wrapper(*args, **kwargs):
        print(f"→ Calling {func.__name__}...")
        result = func(*args, **kwargs)
        print(f"← {func.__name__} returned {result}")
        return result
    return wrapper

@log_calls
def add(a, b):
    return a + b

add(3, 5)
```

**Expected Output:**
```
→ Calling add...
← add returned 8
```

**What `@log_calls` does is equivalent to:**
```python
add = log_calls(add)
```

### How It Works Internally (Detailed)

```
1. Python sees @log_calls above add()
2. Python does: add = log_calls(add)
3. log_calls receives the ORIGINAL add function as 'func'
4. log_calls creates 'wrapper' — a new function that:
   a. Prints a message
   b. Calls the original add (via closure — it remembers 'func')
   c. Prints the result
   d. Returns the result
5. log_calls returns 'wrapper'
6. The name 'add' now points to 'wrapper'
7. When you call add(3, 5), you're actually calling wrapper(3, 5)
```

### functools.wraps — Essential for Production

Without `@wraps`, the decorated function loses its name and docstring:

```python
from functools import wraps

def log_calls(func):
    @wraps(func)  # Preserves func's __name__, __doc__, etc.
    def wrapper(*args, **kwargs):
        print(f"Calling {func.__name__}")
        return func(*args, **kwargs)
    return wrapper
```

### Production Example: Retry Decorator

```python
import time
from functools import wraps

def retry(max_attempts=3, delay=1):
    """Decorator factory with parameters."""
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            for attempt in range(1, max_attempts + 1):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    if attempt == max_attempts:
                        raise
                    print(f"Attempt {attempt} failed: {e}. Retrying in {delay}s...")
                    time.sleep(delay)
        return wrapper
    return decorator

@retry(max_attempts=3, delay=2)
def call_api(url):
    # If this fails, it will be retried automatically
    import requests
    response = requests.get(url)
    response.raise_for_status()
    return response.json()
```

### Common Mistakes

1. Forgetting `@wraps(func)` — function metadata is lost
2. Forgetting to `return func(*args, **kwargs)` — decorator swallows return value
3. Not using `*args, **kwargs` in wrapper — breaks for functions with different signatures
4. Confusing decorator (no parens) vs decorator factory (with parens)

### Interview Perspective

> **Q: What is a decorator?**
> A: A decorator is a function that takes another function as input, adds behavior to it without modifying its source code, and returns a new function. It uses closures to "remember" the original function. The @syntax is syntactic sugar for `func = decorator(func)`.

---

# Module 5: Object-Oriented Programming

## 5.1 Classes & Objects

### 🎯 Learning Objectives

- Understand OOP concepts from first principles
- Create classes and instantiate objects
- Know when to use OOP vs functions

### Real-Life Analogy

A **class** is a **blueprint** (like an architect's plan for a house). An **object** is an actual house built from that blueprint. You can build many houses from one blueprint, each with different colors and sizes.

### What Problem OOP Solves

As programs grow, you need a way to organize related data and functions together. Without OOP:

```python
# Messy — data and functions are scattered
server1_name = "web-01"
server1_ip = "10.0.0.1"
server1_status = "healthy"

def check_health(name, ip):
    pass

def restart_server(name, ip):
    pass
```

With OOP:
```python
# Clean — data and behavior bundled together
class Server:
    def __init__(self, name, ip):
        self.name = name
        self.ip = ip
        self.status = "unknown"
    
    def check_health(self):
        # Health check logic
        self.status = "healthy"
    
    def restart(self):
        print(f"Restarting {self.name}...")

server1 = Server("web-01", "10.0.0.1")
server1.check_health()
```

### How `__init__` and `self` Work

```python
class Server:
    def __init__(self, name, ip):
        self.name = name
        self.ip = ip
```

- `__init__` is the **initializer** (called automatically when you create an object)
- `self` is a reference to the **current instance** being created
- `self.name = name` stores the argument as an attribute of this specific object

```python
web = Server("web-01", "10.0.0.1")
# Python internally does: Server.__init__(web, "web-01", "10.0.0.1")
# So 'self' = the new 'web' object
```

### When to Use Classes vs Functions

| Use Functions When | Use Classes When |
|-------------------|-----------------|
| Simple, stateless operations | You need to maintain state |
| Script-like automation | Modeling real-world entities |
| Quick utilities | Multiple related functions share data |
| No persistent data needed | You need multiple instances |

---

## 5.2 Inheritance

### What It Is

Inheritance lets you create a new class based on an existing class, inheriting all its attributes and methods while adding or modifying behavior.

```python
class Server:
    def __init__(self, name, ip):
        self.name = name
        self.ip = ip
    
    def check_health(self):
        return f"{self.name} is healthy"

class WebServer(Server):  # Inherits from Server
    def __init__(self, name, ip, port=80):
        super().__init__(name, ip)  # Call parent's __init__
        self.port = port
    
    def serve_request(self):
        return f"Serving on {self.ip}:{self.port}"

web = WebServer("web-01", "10.0.0.1", 443)
print(web.check_health())     # Inherited from Server
print(web.serve_request())    # Specific to WebServer
```

---

## 5.3 Encapsulation

### What It Is

Hiding internal details and exposing only what's necessary. Python uses naming conventions (not enforcement):

```python
class Database:
    def __init__(self, host, password):
        self.host = host            # Public
        self._connection = None     # Protected (convention: don't touch from outside)
        self.__password = password  # Private (name-mangled)
    
    @property
    def is_connected(self):
        """Property — access like attribute, runs like function."""
        return self._connection is not None
```

---

## 5.4 Polymorphism

### What It Is

Different classes implementing the same interface (same method names) but with different behavior:

```python
class AWSDeployer:
    def deploy(self, service):
        print(f"Deploying {service} to AWS...")

class GCPDeployer:
    def deploy(self, service):
        print(f"Deploying {service} to GCP...")

# Same interface, different behavior
def run_deployment(deployer, service):
    deployer.deploy(service)  # Works with ANY deployer that has .deploy()

run_deployment(AWSDeployer(), "api")
run_deployment(GCPDeployer(), "api")
```

---

## 5.5 Dunder Methods

### 🎯 Learning Objectives

- Understand all important dunder (double-underscore) methods
- Know when Python calls them automatically
- Use them to make custom classes behave like built-in types

### What Dunder Methods Are

Dunder methods (double underscore: `__method__`) are special methods Python calls automatically in specific situations. They let your custom objects behave like built-in Python types.

### `__init__` — Initializer

```python
class Server:
    def __init__(self, name):
        """Called automatically when Server() is invoked."""
        self.name = name

s = Server("web-01")  # Python calls s.__init__("web-01")
```

### `__new__` — Constructor (Advanced)

```python
class Singleton:
    _instance = None
    
    def __new__(cls, *args, **kwargs):
        """Called BEFORE __init__. Creates the actual object."""
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance
```

**When Python calls it:** Before `__init__`, to actually create the object in memory. Used for singletons, immutable types.

### `__str__` vs `__repr__`

```python
class Server:
    def __init__(self, name, ip):
        self.name = name
        self.ip = ip
    
    def __str__(self):
        """For end users — print(), str()"""
        return f"Server '{self.name}' at {self.ip}"
    
    def __repr__(self):
        """For developers — debugging, repr()"""
        return f"Server(name='{self.name}', ip='{self.ip}')"

s = Server("web-01", "10.0.0.1")
print(s)       # Calls __str__: Server 'web-01' at 10.0.0.1
repr(s)        # Calls __repr__: Server(name='web-01', ip='10.0.0.1')
```

### `__len__`

```python
class Cluster:
    def __init__(self):
        self.servers = []
    
    def add(self, server):
        self.servers.append(server)
    
    def __len__(self):
        """Called by len()"""
        return len(self.servers)

cluster = Cluster()
cluster.add("web-01")
cluster.add("web-02")
print(len(cluster))  # 2
```

### `__iter__` and `__next__`

```python
class ServerPool:
    def __init__(self, servers):
        self.servers = servers
        self._index = 0
    
    def __iter__(self):
        """Makes object iterable (usable in for loops)."""
        self._index = 0
        return self
    
    def __next__(self):
        """Returns next item. Raises StopIteration when exhausted."""
        if self._index >= len(self.servers):
            raise StopIteration
        server = self.servers[self._index]
        self._index += 1
        return server

pool = ServerPool(["web-01", "web-02", "web-03"])
for server in pool:  # Python calls __iter__, then __next__ repeatedly
    print(server)
```

### `__enter__` and `__exit__` — Context Managers

```python
class DatabaseConnection:
    def __init__(self, host):
        self.host = host
        self.connection = None
    
    def __enter__(self):
        """Called when entering 'with' block."""
        print(f"Connecting to {self.host}...")
        self.connection = "active"
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        """Called when exiting 'with' block (even if error occurs)."""
        print("Closing connection...")
        self.connection = None
        return False  # Don't suppress exceptions

with DatabaseConnection("db.prod.internal") as db:
    print(f"Connection: {db.connection}")
# __exit__ called automatically here
```

### `__call__` — Make Object Callable

```python
class Validator:
    def __init__(self, min_val, max_val):
        self.min_val = min_val
        self.max_val = max_val
    
    def __call__(self, value):
        """Makes instance callable like a function."""
        return self.min_val <= value <= self.max_val

validate_port = Validator(1, 65535)
print(validate_port(8080))   # True  — calls __call__(8080)
print(validate_port(99999))  # False
```

### `__getitem__`, `__setitem__`, `__delitem__`

```python
class Config:
    def __init__(self):
        self._data = {}
    
    def __getitem__(self, key):
        return self._data[key]
    
    def __setitem__(self, key, value):
        self._data[key] = value
    
    def __delitem__(self, key):
        del self._data[key]

config = Config()
config["database_host"] = "db.internal"   # __setitem__
print(config["database_host"])             # __getitem__
del config["database_host"]               # __delitem__
```

### Comparison Dunders: `__eq__`, `__lt__`, `__gt__`

```python
class Version:
    def __init__(self, major, minor, patch):
        self.major = major
        self.minor = minor
        self.patch = patch
    
    def __eq__(self, other):
        return (self.major, self.minor, self.patch) == (other.major, other.minor, other.patch)
    
    def __lt__(self, other):
        return (self.major, self.minor, self.patch) < (other.major, other.minor, other.patch)
    
    def __gt__(self, other):
        return (self.major, self.minor, self.patch) > (other.major, other.minor, other.patch)

v1 = Version(1, 2, 0)
v2 = Version(1, 3, 0)
print(v1 < v2)   # True
print(v1 == v2)  # False
```

### `__contains__`

```python
class Subnet:
    def __init__(self, ips):
        self.ips = set(ips)
    
    def __contains__(self, ip):
        """Called by 'in' operator."""
        return ip in self.ips

subnet = Subnet(["10.0.0.1", "10.0.0.2", "10.0.0.3"])
print("10.0.0.1" in subnet)  # True — calls __contains__
print("10.0.0.9" in subnet)  # False
```

### Dunder Methods Summary Table

| Method | Triggered By | Purpose |
|--------|-------------|---------|
| `__init__` | `Class()` | Initialize object |
| `__new__` | Before `__init__` | Create object (rarely needed) |
| `__str__` | `print()`, `str()` | User-friendly string |
| `__repr__` | `repr()`, debugger | Developer-friendly string |
| `__len__` | `len()` | Return length |
| `__iter__` | `for x in obj` | Return iterator |
| `__next__` | `next()` | Return next item |
| `__enter__` | `with obj:` | Enter context |
| `__exit__` | End of `with` | Cleanup context |
| `__call__` | `obj()` | Make callable |
| `__getitem__` | `obj[key]` | Get by key/index |
| `__setitem__` | `obj[key] = val` | Set by key/index |
| `__delitem__` | `del obj[key]` | Delete by key/index |
| `__eq__` | `==` | Equality check |
| `__lt__` | `<` | Less than |
| `__gt__` | `>` | Greater than |
| `__contains__` | `in` | Membership test |

---

# Module 6: Iterators & Generators

## 6.1 Iterator Protocol

### 🎯 Learning Objectives

- Understand what iterators are at a deep level
- Know the iter/next protocol
- Understand why iterators exist

### What Problem Iterators Solve

When you write `for item in collection`, Python needs a standardized way to get items one at a time from ANY collection (lists, files, databases, network streams). The **iterator protocol** is that standard.

### Real-Life Analogy

An iterator is like a **bookmark in a book**. The book is your data. The bookmark remembers where you are. Each time you say "next page," it moves forward one page. When you reach the end, it tells you "no more pages."

### How the Iterator Protocol Works

Any object is iterable if it implements:
1. `__iter__()` — returns an iterator object
2. `__next__()` — returns the next item, raises `StopIteration` when done

```python
# What Python does internally when you write:
for item in [1, 2, 3]:
    print(item)

# Is equivalent to:
my_list = [1, 2, 3]
iterator = iter(my_list)        # Calls my_list.__iter__()
while True:
    try:
        item = next(iterator)   # Calls iterator.__next__()
        print(item)
    except StopIteration:       # No more items
        break
```

### Key Insight: Iterables vs Iterators

| Iterable | Iterator |
|----------|----------|
| Has `__iter__()` method | Has both `__iter__()` AND `__next__()` |
| Can create an iterator | IS the thing that produces values |
| Example: list, dict, string | Example: result of `iter(list)` |
| Can be iterated multiple times | Usually exhausted after one pass |

---

## 6.2 Generators & yield

### 🎯 Learning Objectives

- Understand generators as "lazy iterators"
- Master the `yield` keyword
- Know why generators are essential for DevOps (memory efficiency)

### What Problem Generators Solve

Imagine you need to process a 10 GB log file. Loading it entirely into memory would crash your server (or at least be very wasteful). Generators let you process data **one item at a time** without loading everything into memory.

### Real-Life Analogy

A **list** is like ordering all 1000 items from a menu at once — your table is overwhelmed.

A **generator** is like ordering one dish at a time — you eat it, then order the next. Your table (memory) is never overloaded.

### How `yield` Works (The Core Concept)

When a function contains `yield`, it becomes a **generator function**. Instead of running all at once, it **pauses** at each `yield` and resumes when asked for the next value.

```python
def count_up_to(n):
    """Generator function — notice the 'yield' keyword."""
    current = 1
    while current <= n:
        yield current        # Pause here, give back 'current'
        current += 1         # Resume here on next call

# Using the generator
counter = count_up_to(3)     # Creates generator object (nothing executes yet!)
print(next(counter))         # 1 (runs until first yield, pauses)
print(next(counter))         # 2 (resumes, runs until next yield, pauses)
print(next(counter))         # 3 (resumes, runs until next yield, pauses)
# print(next(counter))       # StopIteration! (while loop ended)
```

### Execution Flow (Step by Step)

```
counter = count_up_to(3)
→ Generator object created. NO code executes yet.

next(counter)
→ Enters function, current=1
→ while 1 <= 3: True
→ yield 1 → PAUSES, returns 1 to caller
→ Function state is frozen (current=1, position=after yield)

next(counter)  
→ RESUMES after yield
→ current += 1 → current=2
→ while 2 <= 3: True
→ yield 2 → PAUSES, returns 2

next(counter)
→ RESUMES, current += 1 → current=3
→ while 3 <= 3: True
→ yield 3 → PAUSES, returns 3

next(counter)
→ RESUMES, current += 1 → current=4
→ while 4 <= 3: False
→ Function ends → raises StopIteration automatically
```

### Memory Comparison

```python
# List approach — stores ALL values in memory
def get_all_lines_list(filename):
    lines = []
    with open(filename) as f:
        for line in f:
            lines.append(line.strip())
    return lines  # 10 GB file = 10 GB in memory!

# Generator approach — produces ONE line at a time
def get_all_lines_gen(filename):
    with open(filename) as f:
        for line in f:
            yield line.strip()  # Only one line in memory at a time!
```

### DevOps Use Cases for Generators

1. **Processing large log files** without loading into memory
2. **Streaming data** from APIs (pagination)
3. **Infinite sequences** (monitoring loops)
4. **Pipeline processing** (chaining generators)

```python
# Reading CloudWatch logs page by page
def get_log_events(log_group, start_time):
    """Generator that handles AWS CloudWatch pagination."""
    next_token = None
    while True:
        params = {"logGroupName": log_group, "startTime": start_time}
        if next_token:
            params["nextToken"] = next_token
        
        response = client.filter_log_events(**params)
        
        for event in response["events"]:
            yield event  # One event at a time
        
        next_token = response.get("nextToken")
        if not next_token:
            break  # No more pages
```

### Common Mistakes

1. **Trying to index a generator** — `gen[0]` doesn't work
2. **Iterating twice** — generators are exhausted after one pass
3. **Not understanding lazy evaluation** — code before first `yield` doesn't run until `next()` is called

---

## 6.3 Generator Expressions

```python
# List comprehension — creates entire list in memory
squares_list = [x**2 for x in range(1000000)]  # ~8 MB memory

# Generator expression — creates values on demand
squares_gen = (x**2 for x in range(1000000))   # ~120 bytes memory!
```

Use generator expressions when you only need to iterate once and the dataset is large.

---

# Module 7: Modules, Packages & Imports

### 🎯 Learning Objectives

- Understand how Python organizes code into modules and packages
- Master the import system

### What Modules Are

A module is simply a `.py` file. When your code grows beyond one file, you split it into modules.

```
my_project/
├── main.py
├── utils.py          ← This is a module
├── config.py         ← This is a module
└── services/
    ├── __init__.py   ← Makes 'services' a package
    ├── aws.py        ← This is a module inside a package
    └── monitoring.py
```

### Import Syntax

```python
# Import entire module
import os
os.path.exists("/tmp")

# Import specific function
from os.path import exists
exists("/tmp")

# Import with alias
import boto3.session as session

# Import everything (avoid in production)
from os import *  # Don't do this — pollutes namespace
```

### How Imports Work Internally

```
import utils
       ↓
1. Python checks sys.modules cache (already imported?)
2. If not cached, Python searches for utils.py:
   - Current directory
   - PYTHONPATH directories
   - Standard library
   - site-packages (installed packages)
3. Python executes utils.py top-to-bottom
4. Creates module object and caches in sys.modules
5. Binds name 'utils' in current namespace
```

### `__init__.py` Purpose

The `__init__.py` file makes a directory a **package**. It can be empty or contain initialization code:

```python
# services/__init__.py
from .aws import AWSClient
from .monitoring import MonitoringClient

# Now users can do:
# from services import AWSClient
```

---

# Module 8: Comprehensions

### 🎯 Learning Objectives

- Write concise data transformations
- Know when comprehensions improve readability (and when they don't)

### What Comprehensions Are

Comprehensions are a concise way to create lists, dicts, and sets from existing iterables.

```python
# List comprehension
servers = ["web-01", "web-02", "db-01", "db-02"]
web_servers = [s for s in servers if s.startswith("web")]
# Result: ["web-01", "web-02"]

# Dictionary comprehension
server_status = {s: "healthy" for s in servers}
# Result: {"web-01": "healthy", "web-02": "healthy", ...}

# Set comprehension
unique_prefixes = {s.split("-")[0] for s in servers}
# Result: {"web", "db"}
```

### When NOT to Use

If the comprehension is complex or multi-line, use a regular loop for readability:

```python
# Too complex — use a loop instead
# BAD: result = [transform(x) for x in data if validate(x) and x.status == "active" and x.region in allowed_regions]

# GOOD:
result = []
for x in data:
    if validate(x) and x.status == "active" and x.region in allowed_regions:
        result.append(transform(x))
```

---

# Module 9: File Handling & Context Managers

### 🎯 Learning Objectives

- Read and write files safely
- Understand context managers and the `with` statement
- Know why resource management matters

### What Problem Context Managers Solve

When you open a file, database connection, or network socket, you MUST close it when done. If your code crashes before closing, you leak resources. Context managers guarantee cleanup.

### Real-Life Analogy

A context manager is like a **responsible friend who always locks the door**. You open the door (acquire resource), do your thing, and your friend locks it when you leave — even if you leave in a hurry (exception).

### The `with` Statement

```python
# WITHOUT context manager (risky)
f = open("servers.txt", "r")
content = f.read()
f.close()  # If an error occurs above, this never runs! Resource leak!

# WITH context manager (safe)
with open("servers.txt", "r") as f:
    content = f.read()
# File is AUTOMATICALLY closed here, even if an error occurred
```

### File Operations

```python
# Reading
with open("config.yaml", "r") as f:
    content = f.read()        # Read entire file as string
    # OR
    lines = f.readlines()     # Read all lines as list
    # OR
    for line in f:            # Memory-efficient line-by-line
        process(line)

# Writing
with open("output.log", "w") as f:   # "w" = write (overwrites!)
    f.write("Deployment started\n")

with open("output.log", "a") as f:   # "a" = append
    f.write("Deployment completed\n")
```

### File Modes

| Mode | Meaning | Creates file? | Overwrites? |
|------|---------|--------------|-------------|
| `"r"` | Read | No (error if missing) | No |
| `"w"` | Write | Yes | Yes! |
| `"a"` | Append | Yes | No (adds to end) |
| `"x"` | Exclusive create | Yes (error if exists) | N/A |
| `"rb"` | Read binary | No | No |
| `"wb"` | Write binary | Yes | Yes |

### Creating Custom Context Managers

```python
from contextlib import contextmanager

@contextmanager
def timer(label):
    """Context manager that measures execution time."""
    import time
    start = time.time()
    yield  # Code inside 'with' block runs here
    elapsed = time.time() - start
    print(f"{label}: {elapsed:.2f} seconds")

with timer("Deployment"):
    # ... deployment logic ...
    import time
    time.sleep(1)
# Output: Deployment: 1.00 seconds
```

---

# Module 10: Error Handling

### 🎯 Learning Objectives

- Understand exceptions and why they exist
- Write robust try/except blocks
- Know best practices for error handling

### What Problem Exceptions Solve

Programs encounter unexpected situations: file not found, network timeout, invalid input. Without error handling, the program crashes. With proper handling, it recovers gracefully.

### How Exceptions Work

```python
try:
    # Code that might fail
    result = 10 / 0
except ZeroDivisionError as e:
    # Handle specific error
    print(f"Error: {e}")
except (ValueError, TypeError) as e:
    # Handle multiple types
    print(f"Input error: {e}")
except Exception as e:
    # Catch-all (use sparingly)
    print(f"Unexpected error: {e}")
else:
    # Runs ONLY if no exception occurred
    print(f"Result: {result}")
finally:
    # ALWAYS runs (cleanup)
    print("Done")
```

### Best Practices

```python
# BAD — catches everything silently (hides bugs)
try:
    deploy()
except:
    pass

# GOOD — catch specific exceptions, log them
try:
    deploy()
except ConnectionError as e:
    logger.error(f"Deployment failed: {e}")
    raise  # Re-raise if you can't handle it
except TimeoutError as e:
    logger.warning(f"Timeout, retrying...")
    retry_deploy()
```

### Raising Exceptions

```python
def validate_port(port):
    if not isinstance(port, int):
        raise TypeError(f"Port must be int, got {type(port).__name__}")
    if not 1 <= port <= 65535:
        raise ValueError(f"Port must be 1-65535, got {port}")
    return port
```

---

# Module 11: Regular Expressions

### 🎯 Learning Objectives

- Understand regex purpose and when to use it
- Master common patterns for DevOps (IPs, logs, parsing)

### What Regex Is

Regular expressions are **patterns** for matching text. They're essential for parsing logs, validating formats, and extracting data from unstructured text.

### When DevOps Engineers Use Regex

- Parsing log files for errors
- Extracting IP addresses from output
- Validating email/URL/port formats
- Processing command output
- Configuration file manipulation

### Basic Patterns

| Pattern | Matches | Example |
|---------|---------|---------|
| `.` | Any character | `a.c` → "abc", "a1c" |
| `\d` | Any digit | `\d+` → "123" |
| `\w` | Word char (letter/digit/_) | `\w+` → "server_01" |
| `\s` | Whitespace | `\s+` → spaces/tabs |
| `^` | Start of string | `^ERROR` → lines starting with ERROR |
| `$` | End of string | `\.py$` → strings ending in .py |
| `*` | 0 or more | `ab*c` → "ac", "abc", "abbc" |
| `+` | 1 or more | `ab+c` → "abc", "abbc" (not "ac") |
| `?` | 0 or 1 | `colou?r` → "color", "colour" |
| `[]` | Character class | `[0-9]` → any digit |
| `()` | Capture group | `(\d+)\.(\d+)` → captures parts |

### Python `re` Module

```python
import re

log_line = "2024-01-15 10:23:45 ERROR [web-01] Connection timeout to 10.0.0.5:5432"

# Search for pattern
match = re.search(r"(\d+\.\d+\.\d+\.\d+):(\d+)", log_line)
if match:
    ip = match.group(1)      # "10.0.0.5"
    port = match.group(2)    # "5432"

# Find all IP addresses
ips = re.findall(r"\d+\.\d+\.\d+\.\d+", log_line)  # ["10.0.0.5"]

# Replace pattern
cleaned = re.sub(r"\d+\.\d+\.\d+\.\d+", "[REDACTED]", log_line)
```

### Common DevOps Patterns

```python
# IP address
ip_pattern = r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"

# Log level
level_pattern = r"\b(DEBUG|INFO|WARNING|ERROR|CRITICAL)\b"

# ISO timestamp
timestamp_pattern = r"\d{4}-\d{2}-\d{2}[T ]\d{2}:\d{2}:\d{2}"

# Email
email_pattern = r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
```

---

# Module 12: JSON & YAML

### 🎯 Learning Objectives

- Understand JSON and YAML as data exchange formats
- Parse and generate both formats in Python
- Know where each is used in DevOps

### Why These Formats Exist

Systems need to exchange structured data. JSON and YAML provide standardized, human-readable formats that every language can parse.

### Where Used in DevOps

| Format | Used In |
|--------|---------|
| JSON | API responses, Terraform state, package.json, CloudFormation |
| YAML | Kubernetes manifests, Docker Compose, Ansible playbooks, CI/CD configs |

### JSON in Python

```python
import json

# Python dict → JSON string (serialization)
server_data = {"name": "web-01", "port": 8080, "healthy": True}
json_string = json.dumps(server_data, indent=2)
print(json_string)

# JSON string → Python dict (deserialization)
parsed = json.loads(json_string)
print(parsed["name"])  # "web-01"

# JSON file operations
with open("config.json", "w") as f:
    json.dump(server_data, f, indent=2)

with open("config.json", "r") as f:
    config = json.load(f)
```

### YAML in Python

```python
import yaml  # pip install pyyaml

# Read YAML file
with open("deployment.yaml", "r") as f:
    config = yaml.safe_load(f)  # Always use safe_load!

# Write YAML file
data = {
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {"name": "web-app"}
}
with open("output.yaml", "w") as f:
    yaml.dump(data, f, default_flow_style=False)
```

### Security Warning

```python
# NEVER use yaml.load() — it can execute arbitrary code!
# ALWAYS use yaml.safe_load()

yaml.safe_load(content)   # ✅ Safe
yaml.load(content)         # ❌ Security vulnerability!
```

---

# Module 13: Logging

### 🎯 Learning Objectives

- Understand why logging exists (and why print() is not enough)
- Configure Python's logging module for production
- Know logging levels and when to use each

### Why print() Is Not Enough

| print() | logging |
|---------|---------|
| No severity levels | DEBUG, INFO, WARNING, ERROR, CRITICAL |
| Goes to stdout only | Can go to files, syslog, cloud services |
| No timestamps | Automatic timestamps |
| Can't turn off easily | Control levels without code changes |
| No structured format | Structured, parseable output |

### Logging Levels

| Level | When to Use | Example |
|-------|------------|---------|
| DEBUG | Detailed diagnostic info | "Entering function with params x=5" |
| INFO | Normal operations | "Server started on port 8080" |
| WARNING | Something unexpected but not broken | "Disk usage at 80%" |
| ERROR | Something failed but app continues | "Failed to connect to cache" |
| CRITICAL | App cannot continue | "Database unreachable, shutting down" |

### Basic Configuration

```python
import logging

# Configure once at the start of your application
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler("app.log"),
        logging.StreamHandler()  # Also print to console
    ]
)

logger = logging.getLogger(__name__)

# Usage
logger.info("Deployment started for service: %s", service_name)
logger.error("Connection failed: %s", error_message)
logger.warning("Retrying in %d seconds...", delay)
```

### Production Best Practices

1. Use `__name__` as logger name (creates hierarchy)
2. Use `%s` formatting (not f-strings) — log message isn't formatted if level is filtered
3. Include context (server name, request ID, user)
4. Use structured logging (JSON) for log aggregation systems
5. Never log sensitive data (passwords, tokens, PII)

---

# Module 14: APIs & Requests

### 🎯 Learning Objectives

- Understand what APIs are
- Make HTTP requests with the `requests` library
- Handle responses, errors, and authentication

### What an API Is

An API (Application Programming Interface) is a way for programs to talk to each other. When you need data from another system (AWS, GitHub, Slack), you call its API.

### Real-Life Analogy

An API is like a **restaurant waiter**. You (client) give your order (request) to the waiter (API). The waiter takes it to the kitchen (server), gets your food (response), and brings it back.

### HTTP Methods

| Method | Purpose | Example |
|--------|---------|---------|
| GET | Retrieve data | Get list of servers |
| POST | Create new resource | Create new instance |
| PUT | Update entire resource | Update server config |
| PATCH | Partial update | Change just the name |
| DELETE | Remove resource | Delete server |

### Using `requests` Library

```python
import requests

# GET request
response = requests.get("https://api.github.com/users/octocat")
print(response.status_code)   # 200
print(response.json())        # Response body as Python dict

# POST request
data = {"name": "new-repo", "private": True}
response = requests.post(
    "https://api.github.com/user/repos",
    json=data,
    headers={"Authorization": "token ghp_xxxxx"}
)

# Error handling
response = requests.get(url, timeout=10)
response.raise_for_status()  # Raises exception for 4xx/5xx status
```

### Production Pattern: API Client with Retries

```python
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

def create_session(max_retries=3):
    """Create requests session with automatic retries."""
    session = requests.Session()
    retry = Retry(
        total=max_retries,
        backoff_factor=1,
        status_forcelist=[500, 502, 503, 504]
    )
    adapter = HTTPAdapter(max_retries=retry)
    session.mount("http://", adapter)
    session.mount("https://", adapter)
    return session
```

---

# Module 15: Threading, Multiprocessing & Asyncio

### 🎯 Learning Objectives

- Understand concurrency vs parallelism
- Know when to use each approach
- Understand the GIL

### The Core Problem

Sometimes you need to do multiple things at once:
- Check health of 100 servers simultaneously
- Download files while processing others
- Handle multiple API requests concurrently

### Three Approaches

| Approach | Best For | How It Works |
|----------|----------|-------------|
| Threading | I/O-bound tasks (network, disk) | Multiple threads, shared memory, GIL limits CPU |
| Multiprocessing | CPU-bound tasks (computation) | Multiple processes, separate memory, true parallelism |
| Asyncio | Many I/O operations (thousands of connections) | Single thread, cooperative multitasking |

### The GIL (Global Interpreter Lock)

Python's GIL allows only ONE thread to execute Python code at a time. This means:
- Threads DON'T speed up CPU-bound tasks
- Threads DO speed up I/O-bound tasks (while one thread waits for I/O, another can run)

### Threading Example

```python
import threading
import time

def check_server(hostname):
    """Simulate health check (I/O-bound)."""
    time.sleep(1)  # Simulates network delay
    print(f"{hostname}: healthy")

servers = ["web-01", "web-02", "web-03", "web-04", "web-05"]

# Sequential: 5 seconds
# Threaded: ~1 second
threads = []
for server in servers:
    t = threading.Thread(target=check_server, args=(server,))
    threads.append(t)
    t.start()

for t in threads:
    t.join()  # Wait for all threads to complete
```

### Asyncio Example

```python
import asyncio
import aiohttp

async def check_server(session, url):
    async with session.get(url) as response:
        return response.status

async def main():
    urls = [f"http://server{i}.internal/health" for i in range(100)]
    async with aiohttp.ClientSession() as session:
        tasks = [check_server(session, url) for url in urls]
        results = await asyncio.gather(*tasks)
    return results

# Run
results = asyncio.run(main())
```

### When to Use What

```
Need to check 100 servers?
  → Are you making HTTP calls? → Threading or Asyncio
  → Are you processing data? → Multiprocessing

Rule of thumb:
  - I/O-bound (network, files) → Threading or Asyncio
  - CPU-bound (math, parsing) → Multiprocessing
  - Thousands of connections → Asyncio
```

---

# Module 16: Type Hints

### 🎯 Learning Objectives

- Understand why type hints exist
- Add type hints to improve code quality

### What They Are

Type hints are annotations that declare what types a function expects and returns. Python does NOT enforce them at runtime — they're for documentation and tooling.

```python
def deploy_service(
    service_name: str,
    replicas: int = 1,
    environment: str = "staging"
) -> bool:
    """Deploy a service. Returns True if successful."""
    # ...
    return True

from typing import List, Dict, Optional

def get_unhealthy_servers(
    servers: List[str],
    timeout: int = 5
) -> Optional[List[Dict[str, str]]]:
    """Returns list of unhealthy servers or None."""
    pass
```

### Why They Matter in DevOps

1. IDEs give better autocomplete
2. `mypy` catches type errors before runtime
3. Self-documenting code
4. Easier onboarding for team members

---

# Module 17: Python for DevOps

## 17.1 os & sys

### 🎯 Learning Objectives

- Interact with the operating system from Python
- Understand environment variables, process info, paths

### Why These Modules Exist

DevOps engineers constantly interact with the OS: reading environment variables, managing file paths, checking system information, and controlling script behavior.

### `os` Module — Essential Functions

```python
import os

# Environment variables
db_host = os.environ.get("DATABASE_HOST", "localhost")
os.environ["DEPLOY_ENV"] = "production"

# File/Directory operations
os.makedirs("/tmp/deploy/artifacts", exist_ok=True)  # Create nested dirs
os.path.exists("/etc/nginx/nginx.conf")               # Check existence
os.listdir("/var/log")                                 # List directory contents
os.remove("/tmp/old_file.txt")                        # Delete file

# Path manipulation
full_path = os.path.join("/var", "log", "app.log")    # "/var/log/app.log"
directory = os.path.dirname(full_path)                 # "/var/log"
filename = os.path.basename(full_path)                 # "app.log"

# Current working directory
cwd = os.getcwd()
os.chdir("/tmp")

# Execute commands (prefer subprocess instead)
os.system("ls -la")  # Not recommended for production
```

### `sys` Module

```python
import sys

# Command-line arguments
# python script.py arg1 arg2
script_name = sys.argv[0]     # "script.py"
first_arg = sys.argv[1]       # "arg1"

# Python version info
print(sys.version)            # "3.12.4 (main, ...)"
print(sys.platform)           # "linux", "darwin", "win32"

# Exit the script
if error_condition:
    sys.exit(1)  # Non-zero = error

# Module search path
print(sys.path)               # Where Python looks for imports
```

---

## 17.2 pathlib & shutil

### pathlib — Modern Path Handling

```python
from pathlib import Path

# Create path objects
config_dir = Path("/etc/myapp")
log_file = config_dir / "logs" / "app.log"  # Operator / joins paths!

# Operations
log_file.exists()
log_file.is_file()
log_file.parent          # Path("/etc/myapp/logs")
log_file.stem            # "app"
log_file.suffix          # ".log"
log_file.read_text()     # Read file content

# Glob (find files matching pattern)
yaml_files = list(Path("/configs").glob("**/*.yaml"))  # Recursive search
```

### shutil — High-Level File Operations

```python
import shutil

# Copy files/directories
shutil.copy2("source.conf", "/etc/nginx/")         # Copy with metadata
shutil.copytree("./app", "/opt/app")               # Copy entire directory

# Move/rename
shutil.move("old_name.py", "new_name.py")

# Remove directory tree
shutil.rmtree("/tmp/old_deployment")               # Dangerous! No undo!

# Disk usage
usage = shutil.disk_usage("/")
print(f"Free: {usage.free / (1024**3):.1f} GB")
```

---

## 17.3 subprocess

### 🎯 Learning Objectives

- Run external commands from Python safely
- Capture output and handle errors
- Understand security implications

### Why subprocess Exists

DevOps engineers need to run system commands (git, docker, kubectl, terraform) from Python scripts and capture their output.

### Safe Usage

```python
import subprocess

# Basic command execution
result = subprocess.run(
    ["kubectl", "get", "pods", "-n", "production"],
    capture_output=True,
    text=True,
    timeout=30,
    check=True  # Raises CalledProcessError if command fails
)

print(result.stdout)       # Command output
print(result.returncode)   # 0 = success

# Handling errors
try:
    result = subprocess.run(
        ["docker", "build", "-t", "myapp:latest", "."],
        capture_output=True,
        text=True,
        check=True
    )
except subprocess.CalledProcessError as e:
    print(f"Build failed: {e.stderr}")
    raise
```

### Security: NEVER Use shell=True with User Input

```python
# DANGEROUS — shell injection vulnerability!
user_input = "myfile; rm -rf /"
subprocess.run(f"cat {user_input}", shell=True)  # Executes rm -rf /!

# SAFE — pass arguments as list
subprocess.run(["cat", user_input])  # Treats entire input as filename
```

---

## 17.4 argparse

### Why It Exists

When you write CLI tools, you need to accept command-line arguments properly (with help text, validation, defaults).

```python
import argparse

parser = argparse.ArgumentParser(description="Deploy service to environment")
parser.add_argument("service", help="Service name to deploy")
parser.add_argument("-e", "--environment", default="staging", 
                    choices=["staging", "production"])
parser.add_argument("-r", "--replicas", type=int, default=1)
parser.add_argument("--dry-run", action="store_true")

args = parser.parse_args()
print(f"Deploying {args.service} to {args.environment} with {args.replicas} replicas")
```

```bash
python deploy.py api-service -e production -r 3 --dry-run
```

---

## 17.5 boto3 (AWS SDK)

### 🎯 Learning Objectives

- Interact with AWS services programmatically
- Understand clients vs resources
- Manage EC2, S3, and other services

### What boto3 Is

boto3 is the official AWS SDK for Python. It lets you create, configure, and manage AWS services using Python code.

### Client vs Resource

```python
import boto3

# Client — low-level, maps 1:1 to AWS API calls
ec2_client = boto3.client("ec2", region_name="us-east-1")
response = ec2_client.describe_instances()

# Resource — high-level, object-oriented (being deprecated for some services)
s3_resource = boto3.resource("s3")
bucket = s3_resource.Bucket("my-bucket")
```

### Common Operations

```python
import boto3

# EC2 — List running instances
ec2 = boto3.client("ec2")
response = ec2.describe_instances(
    Filters=[{"Name": "instance-state-name", "Values": ["running"]}]
)
for reservation in response["Reservations"]:
    for instance in reservation["Instances"]:
        print(f"  {instance['InstanceId']}: {instance.get('PublicIpAddress', 'N/A')}")

# S3 — Upload file
s3 = boto3.client("s3")
s3.upload_file("deployment.zip", "my-bucket", "releases/v1.2.3/deployment.zip")

# SSM — Get parameter
ssm = boto3.client("ssm")
response = ssm.get_parameter(Name="/prod/database/password", WithDecryption=True)
password = response["Parameter"]["Value"]
```

### Best Practices

1. Never hardcode credentials — use IAM roles, environment variables, or AWS profiles
2. Always specify `region_name`
3. Handle `botocore.exceptions.ClientError`
4. Use pagination for list operations
5. Use `boto3.Session()` for explicit credential management

---

## 17.6 paramiko & socket

### paramiko — SSH from Python

```python
import paramiko

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect("10.0.0.1", username="admin", key_filename="~/.ssh/id_rsa")

stdin, stdout, stderr = ssh.exec_command("df -h")
print(stdout.read().decode())
ssh.close()
```

### socket — Network Connectivity Checks

```python
import socket

def check_port(host, port, timeout=3):
    """Check if a port is open."""
    try:
        sock = socket.create_connection((host, port), timeout=timeout)
        sock.close()
        return True
    except (socket.timeout, ConnectionRefusedError):
        return False

is_open = check_port("db.internal", 5432)
```

---

## 17.7 collections & dataclasses

### collections

```python
from collections import defaultdict, Counter, namedtuple

# defaultdict — no KeyError for missing keys
server_groups = defaultdict(list)
server_groups["web"].append("web-01")
server_groups["db"].append("db-01")

# Counter — count occurrences
log_levels = Counter(["ERROR", "INFO", "ERROR", "WARNING", "ERROR"])
print(log_levels.most_common(2))  # [("ERROR", 3), ("INFO", 1)]

# namedtuple — lightweight data classes
Server = namedtuple("Server", ["name", "ip", "port"])
web = Server("web-01", "10.0.0.1", 80)
print(web.name)  # "web-01" (access by name, not index)
```

### dataclasses (Python 3.7+)

```python
from dataclasses import dataclass, field
from typing import List

@dataclass
class DeploymentConfig:
    service: str
    environment: str = "staging"
    replicas: int = 1
    tags: List[str] = field(default_factory=list)
    
    def is_production(self) -> bool:
        return self.environment == "production"

config = DeploymentConfig(service="api", environment="production", replicas=3)
print(config)  # DeploymentConfig(service='api', environment='production', replicas=3, tags=[])
```

---

# Module 18: CI/CD & Automation

## 18.1 Jenkins

### 🎯 Learning Objectives

- Understand Jenkins architecture
- Know how Python integrates with Jenkins
- Understand pipelines and Jenkinsfiles

### What Jenkins Is

Jenkins is an open-source automation server that orchestrates CI/CD pipelines. It's the "traffic controller" that decides when to build, test, and deploy your code.

### Why It Exists

Before CI/CD, developers manually compiled code, ran tests, and deployed to servers. This was slow, error-prone, and inconsistent. Jenkins automates the entire process.

### Architecture

```
┌─────────────────────────────────────────────────┐
│                JENKINS CONTROLLER                 │
│  (Manages jobs, schedules builds, serves UI)     │
└─────────────────────┬───────────────────────────┘
                      │
        ┌─────────────┼─────────────┐
        ↓             ↓             ↓
  ┌──────────┐  ┌──────────┐  ┌──────────┐
  │  AGENT 1 │  │  AGENT 2 │  │  AGENT 3 │
  │ (Linux)  │  │ (Windows)│  │  (Docker) │
  │ Runs jobs│  │ Runs jobs│  │ Runs jobs│
  └──────────┘  └──────────┘  └──────────┘
```

- **Controller**: Brain — schedules and manages. Never runs heavy jobs.
- **Agents**: Workers — execute the actual build/test/deploy tasks.

### Jenkinsfile (Declarative Pipeline)

```groovy
pipeline {
    agent any
    
    environment {
        DEPLOY_ENV = 'staging'
        AWS_REGION = 'us-east-1'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/org/repo.git'
            }
        }
        
        stage('Test') {
            steps {
                sh 'python -m pytest tests/ --junitxml=results.xml'
            }
            post {
                always {
                    junit 'results.xml'
                }
            }
        }
        
        stage('Build') {
            steps {
                sh 'docker build -t myapp:${BUILD_NUMBER} .'
            }
        }
        
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                sh 'python scripts/deploy.py --env ${DEPLOY_ENV}'
            }
        }
    }
    
    post {
        failure {
            sh 'python scripts/notify_slack.py --status failed'
        }
    }
}
```

### How Python Integrates with Jenkins

| Use Case | How Python Helps |
|----------|-----------------|
| Build automation | Python scripts for complex build logic |
| Testing | pytest for unit/integration tests |
| Deployment | Python scripts orchestrating AWS/K8s |
| Notifications | Python sending Slack/email alerts |
| Validation | Python checking deployment health |
| Reporting | Python generating test/coverage reports |
| Infrastructure | Python managing Terraform/Ansible |

### Key Jenkins Concepts

| Concept | Explanation |
|---------|-------------|
| Pipeline | Automated workflow defined in code |
| Stage | Logical group of steps (Build, Test, Deploy) |
| Step | Single action (run command, copy file) |
| Agent | Machine that runs the pipeline |
| Credentials | Secure storage for secrets |
| Parameters | User inputs at build time |
| Shared Libraries | Reusable pipeline code |
| Webhooks | Automatic triggers from Git events |

---

## 18.2 GitHub Actions

### 🎯 Learning Objectives

- Understand GitHub Actions architecture
- Write workflows for Python projects
- Use secrets, matrices, and reusable workflows

### What GitHub Actions Is

GitHub Actions is CI/CD built directly into GitHub. No separate server needed — GitHub runs your workflows on their infrastructure (or your self-hosted runners).

### Architecture

```
Repository Event (push, PR, schedule)
       ↓
Triggers Workflow (.github/workflows/ci.yml)
       ↓
Workflow contains Jobs
       ↓
Jobs contain Steps
       ↓
Steps run on Runners (GitHub-hosted or self-hosted)
```

### Complete Workflow Example

```yaml
# .github/workflows/ci.yml
name: Python CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 6 * * 1'  # Every Monday at 6 AM

env:
  PYTHON_VERSION: '3.12'

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ['3.10', '3.11', '3.12']
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Python ${{ matrix.python-version }}
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
      
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt
          pip install -r requirements-dev.txt
      
      - name: Run linting
        run: |
          pip install flake8
          flake8 src/ --max-line-length=100
      
      - name: Run tests
        run: pytest tests/ --cov=src --cov-report=xml
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3

  deploy:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Deploy to production
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        run: python scripts/deploy.py --env production
```

### Key Concepts

| Concept | Explanation |
|---------|-------------|
| Workflow | YAML file defining automation |
| Event/Trigger | What starts the workflow (push, PR, schedule, manual) |
| Job | Group of steps that run on same runner |
| Step | Individual action or command |
| Runner | Virtual machine executing the job |
| Secret | Encrypted variable (for API keys, passwords) |
| Matrix | Run same job with different configurations |
| Artifact | Files produced by a job (logs, binaries) |
| needs | Job dependency (deploy waits for test) |

---

## 18.3 GitLab CI/CD

### What It Is

GitLab CI/CD is GitLab's built-in automation, configured via `.gitlab-ci.yml`.

```yaml
# .gitlab-ci.yml
stages:
  - test
  - build
  - deploy

variables:
  PIP_CACHE_DIR: "$CI_PROJECT_DIR/.cache/pip"

test:
  stage: test
  image: python:3.12
  script:
    - pip install -r requirements.txt
    - pytest tests/
  cache:
    paths:
      - .cache/pip

build:
  stage: build
  image: docker:24.0
  services:
    - docker:24.0-dind
  script:
    - docker build -t $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA .
    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA

deploy_production:
  stage: deploy
  script:
    - python scripts/deploy.py
  environment:
    name: production
  only:
    - main
  when: manual  # Requires manual approval
```

---

## 18.4 Azure DevOps

### Key Concepts

Azure DevOps uses **Pipelines** (YAML-based) with stages, jobs, and tasks. Python projects use the `UsePythonVersion` task.

```yaml
# azure-pipelines.yml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

steps:
  - task: UsePythonVersion@0
    inputs:
      versionSpec: '3.12'
  
  - script: |
      pip install -r requirements.txt
      pytest tests/ --junitxml=junit.xml
    displayName: 'Run Tests'
  
  - task: PublishTestResults@2
    inputs:
      testResultsFiles: 'junit.xml'
```

---

## 18.5 ArgoCD

### What It Is

ArgoCD is a **GitOps** tool for Kubernetes. It watches a Git repository and automatically syncs your Kubernetes cluster to match the desired state in Git.

### How It Works

```
Developer pushes to Git
       ↓
ArgoCD detects change (polls or webhook)
       ↓
Compares Git manifests with live cluster state
       ↓
If different → syncs (applies changes to cluster)
       ↓
Reports health status
```

### Python Integration

Python generates Kubernetes manifests, validates configurations, or manages ArgoCD via its API:

```python
import requests

ARGOCD_URL = "https://argocd.internal"
TOKEN = os.environ["ARGOCD_TOKEN"]

def sync_application(app_name):
    """Trigger ArgoCD sync via API."""
    response = requests.post(
        f"{ARGOCD_URL}/api/v1/applications/{app_name}/sync",
        headers={"Authorization": f"Bearer {TOKEN}"},
        json={"strategy": {"hook": {}}}
    )
    response.raise_for_status()
    return response.json()
```

---

## 18.6 Terraform (Complete)

### What It Is

Terraform is Infrastructure as Code (IaC) — you define your desired infrastructure in `.tf` files (servers, databases, networks, DNS, etc.), and Terraform creates, updates, and destroys those resources automatically. Instead of clicking through the AWS console, you write code that describes what you want, and Terraform makes it happen.

### Why It Exists

| Without Terraform | With Terraform |
|------------------|----------------|
| Click through cloud console manually | Define infrastructure in code |
| No record of what was created | Git history shows all changes |
| Impossible to replicate environments | Identical environments from same code |
| Drift goes undetected | Drift detection built-in |
| No review process for infra changes | Pull request reviews for infrastructure |
| Takes hours to recreate after disaster | Rebuild entire infrastructure in minutes |

### How Terraform Works Internally

```
1. terraform init
   → Downloads provider plugins (AWS, GCP, Azure)
   → Initializes backend (where state is stored)

2. terraform plan
   → Reads .tf files (desired state)
   → Reads state file (current known state)
   → Queries cloud APIs (actual state)
   → Compares desired vs actual
   → Produces execution plan (what will change)

3. terraform apply
   → Executes the plan
   → Creates/updates/deletes resources
   → Updates state file with new reality

4. terraform destroy
   → Deletes all resources managed by this config
```

### Terraform Workflow Diagram

```
┌──────────────────────────────────────────────────────┐
│                    Developer Workflow                  │
└──────────────────────────────────────────────────────┘

  Write .tf files  →  git push  →  PR Review  →  Merge
                                                    ↓
                                            CI/CD Pipeline
                                                    ↓
                                         terraform init
                                                    ↓
                                         terraform plan
                                                    ↓
                                    ┌───────────────────────────┐
                                    │ Python validates the plan  │
                                    │ - No dangerous deletes?    │
                                    │ - Cost within budget?      │
                                    │ - Compliant with policy?   │
                                    └───────────────┬───────────┘
                                                    ↓
                                         terraform apply
                                                    ↓
                                    ┌───────────────────────────┐
                                    │ Python post-apply tasks    │
                                    │ - Update DNS               │
                                    │ - Configure monitoring     │
                                    │ - Notify team via Slack    │
                                    └───────────────────────────┘
```

### Python + Terraform Integration

```python
import subprocess
import json
import logging
import sys

logger = logging.getLogger(__name__)


def terraform_init(working_dir):
    """Initialize Terraform working directory."""
    result = subprocess.run(
        ["terraform", "init", "-no-color"],
        cwd=working_dir,
        capture_output=True,
        text=True
    )
    if result.returncode != 0:
        logger.error(f"Terraform init failed: {result.stderr}")
        raise RuntimeError(f"terraform init failed: {result.stderr}")
    logger.info("Terraform initialized successfully")
    return result.stdout


def terraform_plan(working_dir, var_file=None):
    """Run terraform plan and save plan file."""
    cmd = ["terraform", "plan", "-out=tfplan", "-no-color"]
    if var_file:
        cmd.extend(["-var-file", var_file])
    
    result = subprocess.run(
        cmd,
        cwd=working_dir,
        capture_output=True,
        text=True
    )
    
    if result.returncode != 0:
        logger.error(f"Terraform plan failed: {result.stderr}")
        raise RuntimeError(f"terraform plan failed: {result.stderr}")
    
    logger.info("Terraform plan created successfully")
    return result.stdout


def terraform_show_plan(working_dir):
    """Parse saved plan as JSON for programmatic analysis."""
    result = subprocess.run(
        ["terraform", "show", "-json", "tfplan"],
        cwd=working_dir,
        capture_output=True,
        text=True,
        check=True
    )
    return json.loads(result.stdout)


def terraform_apply(working_dir, auto_approve=False):
    """Apply the saved terraform plan."""
    cmd = ["terraform", "apply", "-no-color"]
    if auto_approve:
        cmd.append("-auto-approve")
    cmd.append("tfplan")
    
    result = subprocess.run(
        cmd,
        cwd=working_dir,
        capture_output=True,
        text=True
    )
    
    if result.returncode != 0:
        logger.error(f"Terraform apply failed: {result.stderr}")
        raise RuntimeError(f"terraform apply failed: {result.stderr}")
    
    logger.info("Terraform apply completed successfully")
    return result.stdout


def terraform_output(working_dir):
    """Get all terraform outputs as a Python dictionary."""
    result = subprocess.run(
        ["terraform", "output", "-json"],
        cwd=working_dir,
        capture_output=True,
        text=True,
        check=True
    )
    
    raw_outputs = json.loads(result.stdout)
    # Extract just the values from terraform output format
    return {key: val["value"] for key, val in raw_outputs.items()}


def terraform_destroy(working_dir, auto_approve=False):
    """Destroy all terraform-managed resources."""
    cmd = ["terraform", "destroy", "-no-color"]
    if auto_approve:
        cmd.append("-auto-approve")
    
    result = subprocess.run(
        cmd,
        cwd=working_dir,
        capture_output=True,
        text=True,
        check=True
    )
    logger.info("Terraform destroy completed")
    return result.stdout
```

**Line-by-Line Explanation of `terraform_plan`:**

- `cmd = ["terraform", "plan", "-out=tfplan", "-no-color"]` — builds the command as a list (safe from shell injection). `-out=tfplan` saves the plan to a file. `-no-color` removes ANSI codes for clean log output.
- `if var_file:` — optionally adds a variables file (e.g., `production.tfvars`)
- `cmd.extend(["-var-file", var_file])` — appends variable file arguments to command
- `subprocess.run(cmd, cwd=working_dir, ...)` — executes the command in the specified directory
- `capture_output=True` — captures stdout and stderr instead of printing to terminal
- `text=True` — returns output as string instead of bytes
- `if result.returncode != 0:` — checks if command failed (non-zero exit = error)
- `raise RuntimeError(...)` — stops execution and reports the error clearly

### Python for Terraform Plan Validation

This is one of the most valuable integrations — Python analyzes what Terraform *intends* to do before it does it:

```python
def validate_plan_safety(working_dir):
    """
    Analyze terraform plan for dangerous operations.
    Returns True if safe to apply, False if dangerous.
    """
    plan = terraform_show_plan(working_dir)
    
    dangerous_actions = []
    resource_summary = {"create": 0, "update": 0, "delete": 0, "replace": 0}
    
    for change in plan.get("resource_changes", []):
        actions = change.get("change", {}).get("actions", [])
        resource_type = change.get("type", "unknown")
        resource_addr = change.get("address", "unknown")
        
        if "create" in actions:
            resource_summary["create"] += 1
        
        if "update" in actions:
            resource_summary["update"] += 1
        
        if "delete" in actions:
            resource_summary["delete"] += 1
            dangerous_actions.append(f"🗑️  DELETE: {resource_addr} ({resource_type})")
        
        if "delete" in actions and "create" in actions:
            resource_summary["replace"] += 1
            dangerous_actions.append(f"♻️  REPLACE: {resource_addr} ({resource_type})")
    
    # Print summary
    print("\n" + "=" * 60)
    print("📋 TERRAFORM PLAN SUMMARY")
    print("=" * 60)
    print(f"  ➕ Create:  {resource_summary['create']}")
    print(f"  📝 Update:  {resource_summary['update']}")
    print(f"  🗑️  Delete:  {resource_summary['delete']}")
    print(f"  ♻️  Replace: {resource_summary['replace']}")
    print("=" * 60)
    
    if dangerous_actions:
        print("\n⚠️  DANGEROUS OPERATIONS DETECTED:")
        for action in dangerous_actions:
            print(f"  {action}")
        print("\n❌ Plan requires manual review before apply!")
        return False
    
    print("\n✅ Plan is safe to auto-apply")
    return True


def validate_no_forbidden_deletions(working_dir, protected_resources=None):
    """
    Ensure certain critical resources are never deleted.
    Example: production database, VPC, Route53 zones.
    """
    if protected_resources is None:
        protected_resources = [
            "aws_rds_instance",
            "aws_vpc",
            "aws_route53_zone",
            "aws_s3_bucket"
        ]
    
    plan = terraform_show_plan(working_dir)
    violations = []
    
    for change in plan.get("resource_changes", []):
        actions = change.get("change", {}).get("actions", [])
        resource_type = change.get("type", "unknown")
        resource_addr = change.get("address", "unknown")
        
        if "delete" in actions and resource_type in protected_resources:
            violations.append(f"BLOCKED: Cannot delete {resource_addr} ({resource_type})")
    
    if violations:
        print("🚨 POLICY VIOLATION — Protected resources targeted for deletion:")
        for v in violations:
            print(f"  {v}")
        return False
    
    return True
```

### Complete CI/CD Pipeline Orchestration

```python
import os
import sys
import logging

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")
logger = logging.getLogger(__name__)


def deploy_infrastructure(environment="staging"):
    """
    Complete infrastructure deployment workflow.
    Called from CI/CD pipeline (Jenkins, GitHub Actions, etc.)
    """
    tf_dir = f"./terraform/environments/{environment}"
    var_file = f"{environment}.tfvars"
    
    logger.info(f"Starting infrastructure deployment for: {environment}")
    
    # Step 1: Initialize
    logger.info("Step 1/5: Initializing Terraform...")
    terraform_init(tf_dir)
    
    # Step 2: Plan
    logger.info("Step 2/5: Creating execution plan...")
    plan_output = terraform_plan(tf_dir, var_file=var_file)
    logger.info(f"Plan output:\n{plan_output}")
    
    # Step 3: Validate safety
    logger.info("Step 3/5: Validating plan safety...")
    is_safe = validate_plan_safety(tf_dir)
    no_forbidden = validate_no_forbidden_deletions(tf_dir)
    
    if not is_safe or not no_forbidden:
        if environment == "production":
            logger.error("Production deployment blocked — dangerous changes detected")
            notify_slack(
                channel="#infrastructure",
                message=f"🚨 Production terraform apply BLOCKED — manual review required"
            )
            sys.exit(1)
        else:
            logger.warning("Non-production: proceeding despite warnings")
    
    # Step 4: Apply
    logger.info("Step 4/5: Applying infrastructure changes...")
    if environment == "production":
        # Production requires explicit approval (handled by CI/CD gate)
        approval = os.environ.get("APPLY_APPROVED", "false")
        if approval != "true":
            logger.info("Waiting for manual approval...")
            sys.exit(0)  # CI/CD will re-run after approval
    
    terraform_apply(tf_dir, auto_approve=True)
    
    # Step 5: Collect outputs and configure downstream systems
    logger.info("Step 5/5: Collecting outputs and configuring systems...")
    outputs = terraform_output(tf_dir)
    
    logger.info(f"Infrastructure outputs: {json.dumps(outputs, indent=2)}")
    
    # Post-apply actions
    if "load_balancer_dns" in outputs:
        update_dns_record(outputs["load_balancer_dns"])
    
    if "instance_ids" in outputs:
        configure_monitoring(outputs["instance_ids"])
    
    notify_slack(
        channel="#deployments",
        message=f"✅ Infrastructure deployed to {environment} successfully"
    )
    
    return outputs


def notify_slack(channel, message):
    """Send notification to Slack."""
    import requests
    webhook_url = os.environ.get("SLACK_WEBHOOK_URL")
    if webhook_url:
        requests.post(webhook_url, json={"channel": channel, "text": message})


def update_dns_record(lb_dns):
    """Update Route53 DNS to point to new load balancer."""
    import boto3
    # Implementation would use boto3 Route53 client
    logger.info(f"DNS updated to point to {lb_dns}")


def configure_monitoring(instance_ids):
    """Register new instances with monitoring system."""
    logger.info(f"Monitoring configured for instances: {instance_ids}")


if __name__ == "__main__":
    env = sys.argv[1] if len(sys.argv) > 1 else "staging"
    deploy_infrastructure(env)
```

### Dynamic Variable Generation with Python

Python can generate `.tfvars` files dynamically based on environment, time, or external data:

```python
import json
from datetime import datetime


def generate_tfvars(environment, service_config):
    """
    Generate terraform.tfvars.json dynamically.
    Useful when variables come from external sources
    (databases, APIs, SSM Parameter Store).
    """
    import boto3
    
    ssm = boto3.client("ssm")
    
    # Fetch secrets from AWS SSM Parameter Store
    db_password = ssm.get_parameter(
        Name=f"/{environment}/database/password",
        WithDecryption=True
    )["Parameter"]["Value"]
    
    # Build variables
    variables = {
        "environment": environment,
        "deploy_timestamp": datetime.utcnow().isoformat(),
        "instance_type": "t3.large" if environment == "production" else "t3.small",
        "min_instances": 3 if environment == "production" else 1,
        "max_instances": 10 if environment == "production" else 2,
        "db_password": db_password,
        "service_name": service_config["name"],
        "docker_image_tag": service_config["image_tag"],
        "allowed_cidrs": service_config.get("allowed_cidrs", ["10.0.0.0/8"]),
        "tags": {
            "Environment": environment,
            "ManagedBy": "terraform",
            "Team": service_config.get("team", "platform"),
            "DeployedAt": datetime.utcnow().strftime("%Y-%m-%d"),
        }
    }
    
    # Write to tfvars.json (Terraform reads this automatically)
    output_path = f"./terraform/environments/{environment}/terraform.tfvars.json"
    with open(output_path, "w") as f:
        json.dump(variables, f, indent=2)
    
    print(f"Generated tfvars at: {output_path}")
    return output_path
```

### Where Terraform + Python Is Used

| Use Case | Description |
|----------|-------------|
| CI/CD Pipelines | Python orchestrates init/plan/apply in Jenkins/GitHub Actions |
| Pre-apply Validation | Python checks plan for dangerous changes before applying |
| Post-apply Configuration | Python uses terraform outputs to configure apps, DNS, monitoring |
| State Querying | Python reads terraform state for infrastructure inventory |
| Drift Detection | Python schedules periodic plan checks to detect manual changes |
| Cost Estimation | Python parses plan to estimate cost impact before applying |
| Dynamic Variables | Python generates .tfvars from SSM, databases, or APIs |
| Policy Enforcement | Python enforces organizational rules (no public S3, required tags) |
| Multi-Environment | Python manages deployment across dev/staging/prod with same code |
| Disaster Recovery | Python orchestrates full infrastructure rebuild from code |

### Best Practices

1. **Never run `terraform apply` without reviewing the plan** — always plan first, validate with Python, then apply
2. **Use remote state** — store state in S3 with DynamoDB locking (never local in production)
3. **Lock state files** — prevent concurrent modifications that corrupt state
4. **Separate environments** — different directories or workspaces per environment
5. **Pin provider versions** — avoid unexpected breaking changes from provider updates
6. **Use Python for orchestration, Terraform for infrastructure** — don't embed complex logic in Terraform; use Python to drive the workflow
7. **Treat `.tfvars` with secrets as sensitive** — never commit them to Git; generate at runtime
8. **Always use `-no-color` in automation** — ANSI codes pollute log files
9. **Use `-json` output for parsing** — human-readable output is unreliable for programmatic use
10. **Implement plan gates** — never auto-apply to production without human review

### Common Mistakes

| Mistake | Consequence | Fix |
|---------|-------------|-----|
| Running apply without plan review | Accidental resource deletion | Always plan → validate → apply |
| Storing state locally | State conflicts in teams, lost state | Use S3 backend with DynamoDB lock |
| Hardcoding secrets in .tf files | Security breach | Use SSM Parameter Store or Vault |
| Not using `-json` flag | Difficult to parse output in Python | Always use `-json` for automation |
| Ignoring return codes | Silent failures propagate | Always check `returncode` or use `check=True` |
| Using `shell=True` in subprocess | Shell injection vulnerability | Always pass commands as list |
| Not pinning provider versions | Upgrades break existing infrastructure | Pin in `required_providers` block |
| Running destroy without confirmation | Entire environment deleted | Add safety gates and protected resource checks |

### Debugging Tips

```python
def debug_terraform_issue(working_dir):
    """Common debugging steps when terraform fails."""
    
    # 1. Check terraform version
    result = subprocess.run(["terraform", "version"], capture_output=True, text=True)
    print(f"Terraform version: {result.stdout}")
    
    # 2. Validate configuration syntax
    result = subprocess.run(
        ["terraform", "validate", "-json"],
        cwd=working_dir, capture_output=True, text=True
    )
    validation = json.loads(result.stdout)
    if not validation["valid"]:
        for diag in validation.get("diagnostics", []):
            print(f"Error: {diag['summary']} — {diag.get('detail', '')}")
    
    # 3. Check state for corrupted resources
    result = subprocess.run(
        ["terraform", "state", "list"],
        cwd=working_dir, capture_output=True, text=True
    )
    print(f"Managed resources:\n{result.stdout}")
    
    # 4. Check provider authentication
    print("Checking AWS credentials...")
    aws_result = subprocess.run(
        ["aws", "sts", "get-caller-identity"],
        capture_output=True, text=True
    )
    print(f"AWS Identity: {aws_result.stdout}")
```

### Interview Perspective

> **Q: How do you integrate Python with Terraform in a CI/CD pipeline?**
> A: Python serves as the orchestration layer. It runs `terraform init`, `plan`, and `apply` via `subprocess`. Before applying, Python parses the plan JSON output to validate safety — checking for dangerous deletions or policy violations. After applying, Python reads `terraform output` to get resource details (IPs, DNS names) and uses them to configure downstream systems like monitoring, DNS, and application configuration. Python also generates dynamic `.tfvars` files from external sources like AWS SSM Parameter Store.

> **Q: How do you prevent accidental infrastructure destruction?**
> A: Multiple layers: (1) Python parses the plan and blocks any changes that delete protected resource types (RDS, VPC), (2) Production requires manual approval gates in CI/CD, (3) Terraform `prevent_destroy` lifecycle rule on critical resources, (4) Remote state with locking prevents concurrent operations, (5) Slack notifications alert the team before any production apply.

---

## 18.7 Docker

### 🎯 Learning Objectives

- Understand what Docker is and why it revolutionized deployment
- Know how Python interacts with Docker
- Write Dockerfiles for Python applications
- Automate Docker operations with Python

### What Docker Is

Docker is a platform that packages applications and their dependencies into lightweight, portable **containers**. A container includes everything the app needs to run: code, runtime, libraries, and settings.

### Real-Life Analogy

Think of a **shipping container**. Before shipping containers, cargo was loaded manually — different shapes, sizes, breakage during handling. Shipping containers standardized everything: any ship, any truck, any crane can handle any container.

Docker does the same for software. Before Docker: "It works on my machine but not in production." After Docker: if it runs in the container, it runs everywhere.

### Why Docker Exists

| Without Docker | With Docker |
|----------------|-------------|
| "Works on my machine" problems | Same container runs everywhere |
| Install dependencies on every server | Dependencies bundled in image |
| Conflicts between app requirements | Each container is isolated |
| Hours to set up new environment | Seconds to start container |
| Heavy virtual machines (GBs) | Lightweight containers (MBs) |
| Snowflake servers (each configured differently) | Identical, reproducible deployments |

### How Docker Works Internally

```
┌─────────────────────────────────────────────┐
│              HOST OPERATING SYSTEM            │
├─────────────────────────────────────────────┤
│              DOCKER ENGINE (daemon)           │
├──────────┬──────────┬──────────┬────────────┤
│Container1│Container2│Container3│ Container4  │
│  Python  │  Node.js │  Nginx   │  Postgres   │
│  App     │  App     │  Proxy   │  Database   │
│ (Alpine) │ (Debian) │ (Alpine) │  (Debian)   │
└──────────┴──────────┴──────────┴────────────┘

Each container:
- Shares the host OS kernel (not a full OS — that's why it's lightweight)
- Has its own filesystem, network, process space
- Is isolated from other containers
- Starts in seconds (not minutes like VMs)
```

### Key Docker Concepts

| Concept | What It Is | Analogy |
|---------|-----------|---------|
| Image | Read-only template with app + dependencies | Blueprint/Recipe |
| Container | Running instance of an image | House built from blueprint |
| Dockerfile | Instructions to build an image | Recipe steps |
| Registry | Storage for images (Docker Hub, ECR) | App store |
| Volume | Persistent storage attached to container | External hard drive |
| Network | Communication between containers | Private network cable |
| Layer | Each Dockerfile instruction creates a layer | Layers of a cake |

### Dockerfile for Python Application

```dockerfile
# Dockerfile

# Stage 1: Use official Python image as base
FROM python:3.12-slim AS base

# Set metadata
LABEL maintainer="devops@company.com"
LABEL description="Production Python API service"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# Create non-root user (security best practice)
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Set working directory
WORKDIR /app

# Install dependencies first (Docker layer caching optimization)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY src/ ./src/
COPY config/ ./config/

# Switch to non-root user
USER appuser

# Expose port (documentation — doesn't actually publish)
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:8080/health')" || exit 1

# Run the application
CMD ["python", "-m", "uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8080"]
```

**Line-by-Line Explanation:**

- `FROM python:3.12-slim` — base image (slim = smaller, no unnecessary packages)
- `ENV PYTHONDONTWRITEBYTECODE=1` — don't create .pyc files (unnecessary in container)
- `ENV PYTHONUNBUFFERED=1` — print output immediately (important for Docker logging)
- `RUN groupadd...` — create non-root user (running as root is a security risk)
- `WORKDIR /app` — all subsequent commands run from /app
- `COPY requirements.txt .` — copy ONLY requirements first (layer caching!)
- `RUN pip install...` — install dependencies (this layer is cached if requirements.txt hasn't changed)
- `COPY src/ ./src/` — copy app code (changes frequently, so this is a separate layer)
- `USER appuser` — switch to non-root user
- `HEALTHCHECK` — Docker will check if container is healthy
- `CMD [...]` — default command when container starts

### Multi-Stage Build (Production Best Practice)

```dockerfile
# Stage 1: Build/test
FROM python:3.12 AS builder

WORKDIR /build
COPY requirements.txt .
RUN pip install --target=/dependencies -r requirements.txt

COPY . .
RUN python -m pytest tests/

# Stage 2: Production (smaller image)
FROM python:3.12-slim AS production

WORKDIR /app

# Copy only installed dependencies from builder stage
COPY --from=builder /dependencies /usr/local/lib/python3.12/site-packages/
COPY --from=builder /build/src ./src/

USER nobody
CMD ["python", "-m", "src.main"]
```

**Why Multi-Stage?** The final image only contains what's needed to RUN the app. Build tools, test frameworks, and source code used only during building are discarded. Result: smaller, more secure images.

### Python Docker Automation with docker SDK

```python
import docker

# Connect to Docker daemon
client = docker.from_env()

# Build an image
image, build_logs = client.images.build(
    path="./my-app",
    tag="my-app:latest",
    rm=True  # Remove intermediate containers
)
for log in build_logs:
    if "stream" in log:
        print(log["stream"], end="")

# Run a container
container = client.containers.run(
    "my-app:latest",
    name="my-app-prod",
    detach=True,               # Run in background
    ports={"8080/tcp": 8080},  # Port mapping
    environment={
        "DATABASE_URL": "postgresql://db.internal:5432/app",
        "LOG_LEVEL": "INFO"
    },
    restart_policy={"Name": "unless-stopped"},
    mem_limit="512m",          # Memory limit
    cpus=1.0                   # CPU limit
)

print(f"Container started: {container.id[:12]}")
print(f"Status: {container.status}")

# List all running containers
for container in client.containers.list():
    print(f"{container.name}: {container.status}")

# View logs
logs = container.logs(tail=50).decode()
print(logs)

# Stop and remove
container.stop(timeout=30)
container.remove()
```

### Docker Operations Automation Script

```python
import docker
import logging
import sys

logger = logging.getLogger(__name__)
client = docker.from_env()


def build_and_push(service_name, tag, registry="123456789.dkr.ecr.us-east-1.amazonaws.com"):
    """Build Docker image and push to registry."""
    full_tag = f"{registry}/{service_name}:{tag}"
    
    # Build
    logger.info(f"Building {full_tag}...")
    image, logs = client.images.build(
        path=f"./services/{service_name}",
        tag=full_tag,
        rm=True,
        buildargs={"BUILD_VERSION": tag}
    )
    
    # Push to registry
    logger.info(f"Pushing {full_tag}...")
    for line in client.images.push(full_tag, stream=True, decode=True):
        if "error" in line:
            raise RuntimeError(f"Push failed: {line['error']}")
    
    logger.info(f"Successfully pushed {full_tag}")
    return full_tag


def cleanup_old_images(keep_latest=5):
    """Remove old unused images to free disk space."""
    images = client.images.list()
    
    # Group by repository
    repos = {}
    for img in images:
        for tag in img.tags:
            repo = tag.rsplit(":", 1)[0]
            repos.setdefault(repo, []).append(img)
    
    removed = 0
    for repo, imgs in repos.items():
        # Sort by creation date, keep latest N
        imgs.sort(key=lambda x: x.attrs["Created"], reverse=True)
        for old_img in imgs[keep_latest:]:
            try:
                client.images.remove(old_img.id, force=True)
                removed += 1
            except docker.errors.APIError:
                pass  # Image might be in use
    
    logger.info(f"Cleaned up {removed} old images")


def health_check_containers():
    """Check health of all running containers."""
    unhealthy = []
    for container in client.containers.list():
        health = container.attrs.get("State", {}).get("Health", {})
        status = health.get("Status", "no-healthcheck")
        
        if status == "unhealthy":
            unhealthy.append({
                "name": container.name,
                "id": container.short_id,
                "status": status,
                "logs": container.logs(tail=10).decode()
            })
    
    if unhealthy:
        logger.warning(f"{len(unhealthy)} unhealthy containers found!")
        for c in unhealthy:
            logger.warning(f"  {c['name']} ({c['id']}): {c['status']}")
    else:
        logger.info("All containers healthy ✅")
    
    return unhealthy
```

### Docker Compose with Python

```python
import subprocess
import yaml


def generate_docker_compose(services, environment="staging"):
    """Dynamically generate docker-compose.yml based on environment."""
    compose = {
        "version": "3.8",
        "services": {},
        "networks": {
            "app-network": {"driver": "bridge"}
        }
    }
    
    for service in services:
        compose["services"][service["name"]] = {
            "image": f"{service['image']}:{service['tag']}",
            "ports": [f"{service['port']}:{service['container_port']}"],
            "environment": service.get("env_vars", {}),
            "networks": ["app-network"],
            "restart": "unless-stopped",
            "deploy": {
                "resources": {
                    "limits": {
                        "memory": service.get("memory_limit", "256M"),
                        "cpus": str(service.get("cpu_limit", 0.5))
                    }
                }
            }
        }
    
    output_path = f"docker-compose.{environment}.yml"
    with open(output_path, "w") as f:
        yaml.dump(compose, f, default_flow_style=False)
    
    return output_path


def deploy_compose(compose_file, project_name):
    """Deploy services using docker-compose."""
    subprocess.run(
        ["docker-compose", "-f", compose_file, "-p", project_name, "up", "-d"],
        check=True
    )
```

### Best Practices

1. **Use slim/alpine base images** — smaller attack surface, faster downloads
2. **Run as non-root user** — never run containers as root in production
3. **One process per container** — don't run multiple services in one container
4. **Use .dockerignore** — exclude `__pycache__`, `.git`, `.env`, `venv/`
5. **Layer caching** — copy requirements.txt before source code
6. **Multi-stage builds** — separate build and runtime stages
7. **Pin image versions** — `python:3.12.4-slim` not `python:latest`
8. **Health checks** — always define how Docker should check container health
9. **Resource limits** — always set memory and CPU limits
10. **Scan for vulnerabilities** — use `docker scout` or Trivy

### Common Mistakes

| Mistake | Consequence | Fix |
|---------|-------------|-----|
| Using `latest` tag | Unpredictable deployments | Pin specific versions |
| Running as root | Security vulnerability | Add `USER nonroot` |
| Not using .dockerignore | Huge image, leaked secrets | Create comprehensive .dockerignore |
| Installing dev dependencies in prod | Larger image, security risk | Multi-stage builds |
| Not setting resource limits | One container can starve others | Always set mem_limit and cpus |

### Interview Perspective

> **Q: How do you optimize a Python Docker image for production?**
> A: (1) Use multi-stage builds — build stage with full Python, production stage with slim, (2) Use python:3.12-slim as base instead of full image, (3) Copy requirements.txt first for layer caching, (4) Set `PYTHONDONTWRITEBYTECODE=1` and `PYTHONUNBUFFERED=1`, (5) Run as non-root user, (6) Remove cache with `--no-cache-dir` in pip install, (7) Use .dockerignore to exclude unnecessary files.

> **Q: How does Python automate Docker in a CI/CD pipeline?**
> A: Python uses the `docker` SDK or subprocess to build images with unique tags (commit SHA or build number), run tests inside containers, push to registries (ECR/Docker Hub), perform rolling deployments, health check containers, and clean up old images.

---

## 18.8 Kubernetes

### 🎯 Learning Objectives

- Understand what Kubernetes is and why it exists
- Know how Python interacts with Kubernetes
- Manage deployments, pods, and services with Python
- Understand the Kubernetes architecture

### What Kubernetes Is

Kubernetes (K8s) is a container orchestration platform. While Docker runs individual containers, Kubernetes manages **thousands of containers** across **multiple machines**, handling scaling, networking, storage, and self-healing automatically.

### Real-Life Analogy

If Docker containers are **individual trucks**, Kubernetes is the **logistics company** that decides:
- How many trucks to send (scaling)
- Which warehouse to dispatch from (scheduling)
- What to do when a truck breaks down (self-healing)
- How trucks communicate with each other (networking)
- How to gradually switch from old trucks to new ones (rolling updates)

### Why Kubernetes Exists

| Without Kubernetes | With Kubernetes |
|-------------------|-----------------|
| Manually decide which server runs each container | K8s schedules containers automatically |
| Manually restart crashed containers | K8s restarts them automatically |
| Manual scaling during traffic spikes | Auto-scaling based on metrics |
| Complex manual networking between containers | Built-in service discovery and load balancing |
| Risky deployments (all at once) | Rolling updates with automatic rollback |
| No standardized deployment process | Declarative YAML — desired state management |

### Kubernetes Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      CONTROL PLANE                            │
│                                                              │
│  ┌─────────────┐  ┌──────────┐  ┌────────────┐  ┌───────┐ │
│  │  API Server │  │Scheduler │  │ Controller │  │ etcd  │  │
│  │             │  │          │  │  Manager   │  │(store)│  │
│  └─────────────┘  └──────────┘  └────────────┘  └───────┘ │
└────────────────────────────┬────────────────────────────────┘
                             │ (communicates via API)
        ┌────────────────────┼────────────────────┐
        ↓                    ↓                    ↓
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│   WORKER     │    │   WORKER     │    │   WORKER     │
│   NODE 1     │    │   NODE 2     │    │   NODE 3     │
│              │    │              │    │              │
│ ┌────┐┌────┐│    │ ┌────┐┌────┐│    │ ┌────┐┌────┐│
│ │Pod1││Pod2││    │ │Pod3││Pod4││    │ │Pod5││Pod6││
│ └────┘└────┘│    │ └────┘└────┘│    │ └────┘└────┘│
│              │    │              │    │              │
│  [kubelet]   │    │  [kubelet]   │    │  [kubelet]   │
│  [kube-proxy]│    │  [kube-proxy]│    │  [kube-proxy]│
└──────────────┘    └──────────────┘    └──────────────┘
```

### Key Kubernetes Objects

| Object | Purpose | Analogy |
|--------|---------|---------|
| Pod | Smallest deployable unit (1+ containers) | Single apartment |
| Deployment | Manages pods — scaling, updates, rollback | Building manager |
| Service | Stable network endpoint for pods | Phone number (doesn't change when you move) |
| ConfigMap | Non-sensitive configuration data | Settings file |
| Secret | Sensitive data (passwords, tokens) | Safe/vault |
| Namespace | Logical isolation within cluster | Departments in a company |
| Ingress | External HTTP/HTTPS routing | Front door with directions |
| HPA | Horizontal Pod Autoscaler | Automatic hiring when workload increases |

### Python + Kubernetes Integration

```python
from kubernetes import client, config

# Load kubeconfig (from ~/.kube/config or in-cluster)
config.load_kube_config()        # Local development
# config.load_incluster_config() # When running inside a pod

# Create API clients
v1 = client.CoreV1Api()          # Pods, Services, ConfigMaps
apps_v1 = client.AppsV1Api()     # Deployments, StatefulSets


def list_pods(namespace="default"):
    """List all pods in a namespace."""
    pods = v1.list_namespaced_pod(namespace)
    for pod in pods.items:
        print(f"  {pod.metadata.name}: {pod.status.phase}")
    return pods.items


def get_unhealthy_pods(namespace="default"):
    """Find pods that are not running properly."""
    pods = v1.list_namespaced_pod(namespace)
    unhealthy = []
    for pod in pods.items:
        if pod.status.phase not in ("Running", "Succeeded"):
            unhealthy.append({
                "name": pod.metadata.name,
                "phase": pod.status.phase,
                "reason": getattr(pod.status, "reason", "Unknown")
            })
    return unhealthy


def scale_deployment(name, replicas, namespace="default"):
    """Scale a deployment to specified number of replicas."""
    body = {"spec": {"replicas": replicas}}
    apps_v1.patch_namespaced_deployment_scale(
        name=name,
        namespace=namespace,
        body=body
    )
    print(f"Scaled {name} to {replicas} replicas")


def restart_deployment(name, namespace="default"):
    """Trigger a rolling restart of a deployment."""
    from datetime import datetime, timezone
    
    # Patch the deployment template to trigger restart
    body = {
        "spec": {
            "template": {
                "metadata": {
                    "annotations": {
                        "kubectl.kubernetes.io/restartedAt": datetime.now(timezone.utc).isoformat()
                    }
                }
            }
        }
    }
    apps_v1.patch_namespaced_deployment(name, namespace, body)
    print(f"Rolling restart triggered for {name}")


def create_deployment(name, image, replicas=2, port=8080, namespace="default"):
    """Create a new Kubernetes deployment."""
    deployment = client.V1Deployment(
        metadata=client.V1ObjectMeta(name=name, labels={"app": name}),
        spec=client.V1DeploymentSpec(
            replicas=replicas,
            selector=client.V1LabelSelector(match_labels={"app": name}),
            template=client.V1PodTemplateSpec(
                metadata=client.V1ObjectMeta(labels={"app": name}),
                spec=client.V1PodSpec(
                    containers=[
                        client.V1Container(
                            name=name,
                            image=image,
                            ports=[client.V1ContainerPort(container_port=port)],
                            resources=client.V1ResourceRequirements(
                                requests={"cpu": "100m", "memory": "128Mi"},
                                limits={"cpu": "500m", "memory": "256Mi"}
                            ),
                            liveness_probe=client.V1Probe(
                                http_get=client.V1HTTPGetAction(
                                    path="/health",
                                    port=port
                                ),
                                initial_delay_seconds=10,
                                period_seconds=30
                            )
                        )
                    ]
                )
            )
        )
    )
    
    apps_v1.create_namespaced_deployment(namespace=namespace, body=deployment)
    print(f"Deployment {name} created with {replicas} replicas")


def get_deployment_status(name, namespace="default"):
    """Check if deployment is fully rolled out."""
    deployment = apps_v1.read_namespaced_deployment(name, namespace)
    spec_replicas = deployment.spec.replicas
    status = deployment.status
    
    return {
        "desired": spec_replicas,
        "ready": status.ready_replicas or 0,
        "available": status.available_replicas or 0,
        "updated": status.updated_replicas or 0,
        "is_complete": (status.ready_replicas == spec_replicas)
    }


def wait_for_rollout(name, namespace="default", timeout=300):
    """Wait for deployment rollout to complete."""
    import time
    start = time.time()
    
    while time.time() - start < timeout:
        status = get_deployment_status(name, namespace)
        print(f"  Rollout: {status['ready']}/{status['desired']} ready")
        
        if status["is_complete"]:
            print(f"✅ Deployment {name} rolled out successfully")
            return True
        
        time.sleep(5)
    
    print(f"❌ Deployment {name} rollout timed out after {timeout}s")
    return False
```

### Kubernetes YAML Generation with Python

```python
import yaml


def generate_k8s_manifests(service_name, image_tag, environment, replicas=2):
    """Generate complete Kubernetes manifests for a service."""
    
    namespace = f"{service_name}-{environment}"
    full_image = f"123456789.dkr.ecr.us-east-1.amazonaws.com/{service_name}:{image_tag}"
    
    # Namespace
    ns_manifest = {
        "apiVersion": "v1",
        "kind": "Namespace",
        "metadata": {"name": namespace}
    }
    
    # Deployment
    deployment_manifest = {
        "apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {
            "name": service_name,
            "namespace": namespace,
            "labels": {"app": service_name, "env": environment}
        },
        "spec": {
            "replicas": replicas,
            "selector": {"matchLabels": {"app": service_name}},
            "strategy": {
                "type": "RollingUpdate",
                "rollingUpdate": {"maxSurge": 1, "maxUnavailable": 0}
            },
            "template": {
                "metadata": {"labels": {"app": service_name, "env": environment}},
                "spec": {
                    "containers": [{
                        "name": service_name,
                        "image": full_image,
                        "ports": [{"containerPort": 8080}],
                        "resources": {
                            "requests": {"cpu": "100m", "memory": "128Mi"},
                            "limits": {"cpu": "500m", "memory": "512Mi"}
                        },
                        "livenessProbe": {
                            "httpGet": {"path": "/health", "port": 8080},
                            "initialDelaySeconds": 15,
                            "periodSeconds": 30
                        },
                        "readinessProbe": {
                            "httpGet": {"path": "/ready", "port": 8080},
                            "initialDelaySeconds": 5,
                            "periodSeconds": 10
                        },
                        "envFrom": [{"configMapRef": {"name": f"{service_name}-config"}}]
                    }]
                }
            }
        }
    }
    
    # Service
    service_manifest = {
        "apiVersion": "v1",
        "kind": "Service",
        "metadata": {"name": service_name, "namespace": namespace},
        "spec": {
            "selector": {"app": service_name},
            "ports": [{"port": 80, "targetPort": 8080}],
            "type": "ClusterIP"
        }
    }
    
    # Write all manifests to file
    manifests = [ns_manifest, deployment_manifest, service_manifest]
    output_file = f"k8s/{environment}/{service_name}.yaml"
    
    with open(output_file, "w") as f:
        yaml.dump_all(manifests, f, default_flow_style=False)
    
    print(f"Generated manifests: {output_file}")
    return output_file
```

### Best Practices

1. **Always set resource requests and limits** — prevents noisy neighbor problems
2. **Use liveness and readiness probes** — K8s needs to know if your app is healthy
3. **Use namespaces for isolation** — separate environments, teams, or services
4. **Use rolling update strategy** — zero-downtime deployments
5. **Store secrets in K8s Secrets or external vault** — never in ConfigMaps or code
6. **Use Python's kubernetes client for automation** — more powerful than kubectl scripting
7. **Implement pod disruption budgets** — ensure minimum availability during maintenance

### Interview Perspective

> **Q: How do you deploy a Python application to Kubernetes?**
> A: (1) Containerize with Docker (multi-stage Dockerfile), (2) Push image to registry (ECR/GCR), (3) Create K8s manifests (Deployment, Service, ConfigMap), (4) Apply with `kubectl apply` or Python kubernetes client, (5) Wait for rollout completion, (6) Verify health via readiness probes. In CI/CD, Python orchestrates this entire flow — building the image, generating manifests with correct tags, applying them, and monitoring rollout status.

---

## 18.9 AWS Automation

### 🎯 Learning Objectives

- Automate common AWS operations with Python
- Manage EC2, S3, Lambda, CloudWatch, and IAM
- Build production-grade automation scripts

### Why Automate AWS with Python

The AWS Console (web UI) doesn't scale. When you manage 500 instances, 200 S3 buckets, and 50 Lambda functions, you need automation. Python + boto3 is the standard approach.

### EC2 Management

```python
import boto3
from datetime import datetime, timezone

ec2 = boto3.client("ec2", region_name="us-east-1")


def list_instances(filters=None):
    """List EC2 instances with optional filters."""
    params = {}
    if filters:
        params["Filters"] = filters
    
    response = ec2.describe_instances(**params)
    instances = []
    
    for reservation in response["Reservations"]:
        for instance in reservation["Instances"]:
            # Get Name tag
            name = "unnamed"
            for tag in instance.get("Tags", []):
                if tag["Key"] == "Name":
                    name = tag["Value"]
            
            instances.append({
                "id": instance["InstanceId"],
                "name": name,
                "type": instance["InstanceType"],
                "state": instance["State"]["Name"],
                "ip": instance.get("PublicIpAddress", "N/A"),
                "private_ip": instance.get("PrivateIpAddress", "N/A"),
                "launch_time": instance["LaunchTime"]
            })
    
    return instances


def stop_idle_instances(max_cpu_percent=5, min_hours_running=24):
    """Stop instances with low CPU usage (cost optimization)."""
    cloudwatch = boto3.client("cloudwatch")
    running = list_instances(
        filters=[{"Name": "instance-state-name", "Values": ["running"]}]
    )
    
    stopped = []
    for instance in running:
        # Check how long it's been running
        hours_running = (datetime.now(timezone.utc) - instance["launch_time"]).total_seconds() / 3600
        if hours_running < min_hours_running:
            continue
        
        # Check CPU usage
        response = cloudwatch.get_metric_statistics(
            Namespace="AWS/EC2",
            MetricName="CPUUtilization",
            Dimensions=[{"Name": "InstanceId", "Value": instance["id"]}],
            StartTime=datetime.now(timezone.utc) - timedelta(hours=4),
            EndTime=datetime.now(timezone.utc),
            Period=3600,
            Statistics=["Average"]
        )
        
        if response["Datapoints"]:
            avg_cpu = sum(d["Average"] for d in response["Datapoints"]) / len(response["Datapoints"])
            if avg_cpu < max_cpu_percent:
                ec2.stop_instances(InstanceIds=[instance["id"]])
                stopped.append(instance["name"])
    
    return stopped


def create_ami_backup(instance_id, retention_days=7):
    """Create AMI backup of an instance."""
    timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    
    response = ec2.create_image(
        InstanceId=instance_id,
        Name=f"backup-{instance_id}-{timestamp}",
        Description=f"Automated backup created {timestamp}",
        NoReboot=True,
        TagSpecifications=[{
            "ResourceType": "image",
            "Tags": [
                {"Key": "CreatedBy", "Value": "automation"},
                {"Key": "RetentionDays", "Value": str(retention_days)},
                {"Key": "CreatedAt", "Value": timestamp}
            ]
        }]
    )
    return response["ImageId"]
```

### S3 Operations

```python
import boto3
from botocore.exceptions import ClientError

s3 = boto3.client("s3")


def upload_deployment_artifact(local_path, bucket, service_name, version):
    """Upload deployment artifact to S3 with metadata."""
    key = f"deployments/{service_name}/{version}/{local_path.split('/')[-1]}"
    
    s3.upload_file(
        local_path, bucket, key,
        ExtraArgs={
            "Metadata": {
                "version": version,
                "service": service_name,
                "deployed-by": "ci-pipeline"
            },
            "ServerSideEncryption": "AES256"
        }
    )
    return f"s3://{bucket}/{key}"


def cleanup_old_artifacts(bucket, prefix, keep_latest=10):
    """Remove old deployment artifacts, keeping latest N versions."""
    paginator = s3.get_paginator("list_objects_v2")
    
    objects = []
    for page in paginator.paginate(Bucket=bucket, Prefix=prefix):
        for obj in page.get("Contents", []):
            objects.append(obj)
    
    # Sort by date, newest first
    objects.sort(key=lambda x: x["LastModified"], reverse=True)
    
    # Delete everything beyond the keep count
    to_delete = objects[keep_latest:]
    if to_delete:
        s3.delete_objects(
            Bucket=bucket,
            Delete={"Objects": [{"Key": obj["Key"]} for obj in to_delete]}
        )
        print(f"Deleted {len(to_delete)} old artifacts")


def check_bucket_security(bucket_name):
    """Audit S3 bucket for common security issues."""
    issues = []
    
    # Check public access
    try:
        acl = s3.get_bucket_acl(Bucket=bucket_name)
        for grant in acl["Grants"]:
            grantee = grant.get("Grantee", {})
            if grantee.get("URI") == "http://acs.amazonaws.com/groups/global/AllUsers":
                issues.append("CRITICAL: Bucket has public ACL")
    except ClientError:
        issues.append("WARNING: Cannot read bucket ACL")
    
    # Check encryption
    try:
        s3.get_bucket_encryption(Bucket=bucket_name)
    except ClientError as e:
        if "ServerSideEncryptionConfigurationNotFoundError" in str(e):
            issues.append("WARNING: No default encryption configured")
    
    # Check versioning
    versioning = s3.get_bucket_versioning(Bucket=bucket_name)
    if versioning.get("Status") != "Enabled":
        issues.append("INFO: Versioning not enabled")
    
    return issues
```

### Lambda Management

```python
import boto3
import zipfile
import io

lambda_client = boto3.client("lambda")


def deploy_lambda(function_name, code_path, handler="main.handler", 
                  runtime="python3.12", timeout=30, memory=256):
    """Deploy or update a Lambda function."""
    
    # Package code into zip
    zip_buffer = io.BytesIO()
    with zipfile.ZipFile(zip_buffer, "w", zipfile.ZIP_DEFLATED) as zf:
        from pathlib import Path
        for file in Path(code_path).rglob("*.py"):
            zf.write(file, file.relative_to(code_path))
    zip_buffer.seek(0)
    
    try:
        # Try updating existing function
        lambda_client.update_function_code(
            FunctionName=function_name,
            ZipFile=zip_buffer.read()
        )
        print(f"Updated Lambda function: {function_name}")
    except lambda_client.exceptions.ResourceNotFoundException:
        # Create new function
        zip_buffer.seek(0)
        lambda_client.create_function(
            FunctionName=function_name,
            Runtime=runtime,
            Role=f"arn:aws:iam::123456789:role/lambda-execution-role",
            Handler=handler,
            Code={"ZipFile": zip_buffer.read()},
            Timeout=timeout,
            MemorySize=memory,
            Environment={
                "Variables": {
                    "LOG_LEVEL": "INFO",
                    "ENVIRONMENT": "production"
                }
            }
        )
        print(f"Created Lambda function: {function_name}")


def invoke_lambda(function_name, payload):
    """Invoke a Lambda function and return response."""
    import json
    response = lambda_client.invoke(
        FunctionName=function_name,
        InvocationType="RequestResponse",
        Payload=json.dumps(payload)
    )
    return json.loads(response["Payload"].read())
```

### CloudWatch Monitoring

```python
import boto3
from datetime import datetime, timedelta, timezone

cloudwatch = boto3.client("cloudwatch")


def create_alarm(name, metric, namespace, threshold, 
                 comparison="GreaterThanThreshold", period=300,
                 evaluation_periods=2, sns_topic_arn=None):
    """Create a CloudWatch alarm."""
    params = {
        "AlarmName": name,
        "MetricName": metric,
        "Namespace": namespace,
        "Statistic": "Average",
        "Period": period,
        "EvaluationPeriods": evaluation_periods,
        "Threshold": threshold,
        "ComparisonOperator": comparison,
        "TreatMissingData": "breaching"
    }
    
    if sns_topic_arn:
        params["AlarmActions"] = [sns_topic_arn]
        params["OKActions"] = [sns_topic_arn]
    
    cloudwatch.put_metric_alarm(**params)
    print(f"Alarm created: {name}")


def get_service_metrics(instance_id, hours=1):
    """Get CPU, memory, and network metrics for an instance."""
    end_time = datetime.now(timezone.utc)
    start_time = end_time - timedelta(hours=hours)
    
    metrics = {}
    for metric_name in ["CPUUtilization", "NetworkIn", "NetworkOut"]:
        response = cloudwatch.get_metric_statistics(
            Namespace="AWS/EC2",
            MetricName=metric_name,
            Dimensions=[{"Name": "InstanceId", "Value": instance_id}],
            StartTime=start_time,
            EndTime=end_time,
            Period=300,
            Statistics=["Average", "Maximum"]
        )
        metrics[metric_name] = response["Datapoints"]
    
    return metrics


def publish_custom_metric(namespace, metric_name, value, unit="Count", dimensions=None):
    """Publish custom metric to CloudWatch."""
    metric_data = {
        "MetricName": metric_name,
        "Value": value,
        "Unit": unit,
        "Timestamp": datetime.now(timezone.utc)
    }
    
    if dimensions:
        metric_data["Dimensions"] = [
            {"Name": k, "Value": v} for k, v in dimensions.items()
        ]
    
    cloudwatch.put_metric_data(
        Namespace=namespace,
        MetricData=[metric_data]
    )
```

### Complete AWS Automation: Infrastructure Health Report

```python
import boto3
import json
from datetime import datetime, timezone


def generate_infrastructure_report():
    """Generate comprehensive infrastructure health report."""
    report = {
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "ec2": {},
        "rds": {},
        "s3": {},
        "costs": {}
    }
    
    # EC2 Summary
    ec2 = boto3.client("ec2")
    instances = ec2.describe_instances()
    states = {}
    for res in instances["Reservations"]:
        for inst in res["Instances"]:
            state = inst["State"]["Name"]
            states[state] = states.get(state, 0) + 1
    report["ec2"] = {"instance_states": states}
    
    # RDS Summary
    rds = boto3.client("rds")
    databases = rds.describe_db_instances()
    report["rds"] = {
        "total": len(databases["DBInstances"]),
        "instances": [
            {
                "id": db["DBInstanceIdentifier"],
                "engine": db["Engine"],
                "status": db["DBInstanceStatus"],
                "multi_az": db["MultiAZ"]
            }
            for db in databases["DBInstances"]
        ]
    }
    
    # S3 Bucket Count
    s3 = boto3.client("s3")
    buckets = s3.list_buckets()
    report["s3"] = {"total_buckets": len(buckets["Buckets"])}
    
    # Output report
    print(json.dumps(report, indent=2, default=str))
    return report
```

### Best Practices for AWS Automation

1. **Use IAM roles, never hardcoded credentials** — roles for EC2/Lambda, profiles for local
2. **Handle pagination** — most AWS APIs return paginated results
3. **Implement exponential backoff** — handle throttling gracefully
4. **Use resource tagging** — tag everything for cost tracking and automation
5. **Encrypt everything** — S3 encryption, RDS encryption, EBS encryption
6. **Use Parameter Store/Secrets Manager** — never store secrets in code
7. **Set timeouts on boto3 calls** — prevent hanging scripts
8. **Use sessions for cross-account access** — `boto3.Session(profile_name=...)`
9. **Log all actions** — audit trail for compliance
10. **Test with DryRun** — many AWS APIs support DryRun parameter

---

# Module 19: Testing & Pytest

### 🎯 Learning Objectives

- Understand why testing is essential in DevOps
- Write unit tests, integration tests with pytest
- Understand test fixtures, parametrize, and mocking

### Why Testing Matters

In production, untested code is a liability. One bug in a deployment script can take down your entire infrastructure. Testing ensures:
- Code works as expected
- Changes don't break existing functionality
- Edge cases are handled
- Team can refactor with confidence

### Types of Tests

| Type | What It Tests | Speed | Coverage |
|------|--------------|-------|----------|
| Unit | Single function in isolation | Very fast | Narrow |
| Integration | Multiple components together | Medium | Broader |
| End-to-End | Entire workflow | Slow | Full system |

### pytest Basics

```python
# test_deployment.py
import pytest


def validate_port(port):
    """Function under test."""
    if not isinstance(port, int):
        raise TypeError("Port must be integer")
    if not 1 <= port <= 65535:
        raise ValueError(f"Invalid port: {port}")
    return port


# Test functions (must start with 'test_')
def test_valid_port():
    assert validate_port(8080) == 8080
    assert validate_port(443) == 443


def test_invalid_port_raises():
    with pytest.raises(ValueError):
        validate_port(99999)
    with pytest.raises(ValueError):
        validate_port(0)


def test_wrong_type_raises():
    with pytest.raises(TypeError):
        validate_port("8080")
```

Run tests:
```bash
pytest test_deployment.py -v
```

### Fixtures (Setup/Teardown)

```python
import pytest


@pytest.fixture
def sample_server_config():
    """Provides test data — runs before each test that uses it."""
    return {
        "name": "web-01",
        "ip": "10.0.0.1",
        "port": 8080,
        "environment": "staging"
    }


@pytest.fixture
def temp_config_file(tmp_path):
    """Create a temporary config file for testing."""
    config_content = "server:\n  host: localhost\n  port: 8080\n"
    config_file = tmp_path / "config.yaml"
    config_file.write_text(config_content)
    return config_file


def test_server_name(sample_server_config):
    assert sample_server_config["name"] == "web-01"


def test_config_file_exists(temp_config_file):
    assert temp_config_file.exists()
    content = temp_config_file.read_text()
    assert "8080" in content
```

### Parametrize (Multiple Test Cases)

```python
@pytest.mark.parametrize("port,expected", [
    (80, 80),
    (443, 443),
    (8080, 8080),
    (65535, 65535),
])
def test_valid_ports(port, expected):
    assert validate_port(port) == expected


@pytest.mark.parametrize("invalid_port", [0, -1, 65536, 100000])
def test_invalid_ports(invalid_port):
    with pytest.raises(ValueError):
        validate_port(invalid_port)
```

### Mocking (Isolating External Dependencies)

```python
from unittest.mock import patch, MagicMock


def get_server_status(hostname):
    """Makes real HTTP call — we want to test without actually calling."""
    import requests
    response = requests.get(f"http://{hostname}/health", timeout=5)
    return response.status_code == 200


@patch("requests.get")
def test_server_healthy(mock_get):
    """Test without making real HTTP call."""
    mock_get.return_value = MagicMock(status_code=200)
    assert get_server_status("web-01") is True
    mock_get.assert_called_once_with("http://web-01/health", timeout=5)


@patch("requests.get")
def test_server_unhealthy(mock_get):
    mock_get.return_value = MagicMock(status_code=500)
    assert get_server_status("web-01") is False
```

### Best Practices

1. **Test naming:** `test_<what>_<condition>_<expected>` (e.g., `test_port_negative_raises_error`)
2. **AAA pattern:** Arrange → Act → Assert
3. **One assertion per test** (when practical)
4. **Mock external dependencies** (APIs, databases, AWS)
5. **Use pytest-cov** for coverage: `pytest --cov=src --cov-report=html`
6. **Run tests in CI/CD** — never deploy without passing tests

---

# Module 20: Monitoring & Observability

### 🎯 Learning Objectives

- Understand the three pillars of observability
- Build monitoring solutions with Python
- Integrate with Prometheus, Grafana, and alerting systems

### Three Pillars of Observability

| Pillar | What It Is | Tools |
|--------|-----------|-------|
| Metrics | Numeric measurements over time | Prometheus, CloudWatch, Datadog |
| Logs | Timestamped event records | ELK Stack, CloudWatch Logs, Loki |
| Traces | Request path through distributed system | Jaeger, Zipkin, X-Ray |

### Custom Prometheus Exporter in Python

```python
from prometheus_client import start_http_server, Gauge, Counter, Histogram
import time
import psutil

# Define metrics
cpu_usage = Gauge("system_cpu_usage_percent", "Current CPU usage percentage")
memory_usage = Gauge("system_memory_usage_percent", "Current memory usage percentage")
disk_usage = Gauge("system_disk_usage_percent", "Current disk usage percentage", ["mount"])
request_count = Counter("app_requests_total", "Total requests", ["method", "endpoint", "status"])
request_latency = Histogram("app_request_duration_seconds", "Request latency")


def collect_system_metrics():
    """Collect and expose system metrics."""
    while True:
        cpu_usage.set(psutil.cpu_percent(interval=1))
        memory_usage.set(psutil.virtual_memory().percent)
        
        for partition in psutil.disk_partitions():
            usage = psutil.disk_usage(partition.mountpoint)
            disk_usage.labels(mount=partition.mountpoint).set(usage.percent)
        
        time.sleep(15)


if __name__ == "__main__":
    # Start metrics HTTP server on port 9090
    start_http_server(9090)
    print("Prometheus metrics available at http://localhost:9090/metrics")
    collect_system_metrics()
```

### Health Check Endpoint Pattern

```python
from flask import Flask, jsonify
import psutil
import boto3

app = Flask(__name__)


@app.route("/health")
def health_check():
    """Basic health check — is the app running?"""
    return jsonify({"status": "healthy"}), 200


@app.route("/ready")
def readiness_check():
    """Readiness check — can the app serve traffic?"""
    checks = {}
    
    # Check database connectivity
    try:
        # db.execute("SELECT 1")
        checks["database"] = "ok"
    except Exception as e:
        checks["database"] = f"failed: {e}"
    
    # Check disk space
    disk = psutil.disk_usage("/")
    if disk.percent > 90:
        checks["disk"] = f"warning: {disk.percent}% used"
    else:
        checks["disk"] = "ok"
    
    # Check memory
    mem = psutil.virtual_memory()
    if mem.percent > 90:
        checks["memory"] = f"warning: {mem.percent}% used"
    else:
        checks["memory"] = "ok"
    
    all_ok = all(v == "ok" for v in checks.values())
    status_code = 200 if all_ok else 503
    
    return jsonify({"status": "ready" if all_ok else "not_ready", "checks": checks}), status_code
```

---

# Module 21: Security

### 🎯 Learning Objectives

- Understand security best practices in Python DevOps
- Handle secrets properly
- Avoid common vulnerabilities

### Security Principles

| Principle | Description |
|-----------|-------------|
| Least Privilege | Give minimum permissions needed |
| Defense in Depth | Multiple layers of security |
| Secrets Management | Never hardcode credentials |
| Input Validation | Never trust user input |
| Encryption | Encrypt data at rest and in transit |

### Secrets Management

```python
# ❌ NEVER DO THIS
DATABASE_PASSWORD = "super_secret_123"
AWS_KEY = "AKIAIOSFODNN7EXAMPLE"

# ✅ Use environment variables
import os
DATABASE_PASSWORD = os.environ["DATABASE_PASSWORD"]

# ✅ Use AWS Secrets Manager
import boto3

def get_secret(secret_name):
    """Retrieve secret from AWS Secrets Manager."""
    client = boto3.client("secretsmanager")
    response = client.get_secret_value(SecretId=secret_name)
    return json.loads(response["SecretString"])

secrets = get_secret("production/database")
db_password = secrets["password"]

# ✅ Use HashiCorp Vault
import hvac

client = hvac.Client(url="https://vault.internal:8200")
client.token = os.environ["VAULT_TOKEN"]
secret = client.secrets.kv.v2.read_secret_version(path="database/prod")
password = secret["data"]["data"]["password"]
```

### Input Validation & Sanitization

```python
import re
import shlex


def validate_hostname(hostname):
    """Validate hostname to prevent injection."""
    pattern = r"^[a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z]{2,})+$"
    if not re.match(pattern, hostname):
        raise ValueError(f"Invalid hostname: {hostname}")
    return hostname


def safe_shell_command(user_input):
    """Safely incorporate user input into shell commands."""
    # NEVER do: os.system(f"ping {user_input}")
    # INSTEAD: use subprocess with list arguments
    import subprocess
    validated = validate_hostname(user_input)
    result = subprocess.run(
        ["ping", "-c", "3", validated],
        capture_output=True, text=True
    )
    return result.stdout
```

### Security Scanning in CI/CD

```python
import subprocess
import json


def run_security_scan():
    """Run security tools and collect results."""
    results = {}
    
    # Dependency vulnerability scan
    result = subprocess.run(
        ["pip-audit", "--format=json"],
        capture_output=True, text=True
    )
    results["dependencies"] = json.loads(result.stdout) if result.stdout else []
    
    # Static analysis for security issues
    result = subprocess.run(
        ["bandit", "-r", "src/", "-f", "json"],
        capture_output=True, text=True
    )
    results["code_security"] = json.loads(result.stdout) if result.stdout else {}
    
    # Check for hardcoded secrets
    result = subprocess.run(
        ["detect-secrets", "scan", "--all-files"],
        capture_output=True, text=True
    )
    results["secrets"] = json.loads(result.stdout) if result.stdout else {}
    
    return results
```

---

# Module 22: Performance Optimization

### 🎯 Learning Objectives

- Profile Python code to find bottlenecks
- Optimize common patterns
- Know when optimization matters and when it doesn't

### Profiling Before Optimizing

**Golden Rule:** Never optimize without profiling first. "Premature optimization is the root of all evil." — Donald Knuth

```python
import cProfile
import time


def profile_function(func, *args, **kwargs):
    """Profile a function and print results."""
    profiler = cProfile.Profile()
    profiler.enable()
    result = func(*args, **kwargs)
    profiler.disable()
    profiler.print_stats(sort="cumulative")
    return result


# Simple timing decorator
from functools import wraps

def timed(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.perf_counter()
        result = func(*args, **kwargs)
        elapsed = time.perf_counter() - start
        print(f"{func.__name__} took {elapsed:.4f}s")
        return result
    return wrapper

@timed
def process_logs(filepath):
    # ... processing logic
    pass
```

### Common Optimizations

```python
# 1. Use generators for large datasets
# BAD: loads everything in memory
data = [process(x) for x in range(10_000_000)]
# GOOD: processes one at a time
data = (process(x) for x in range(10_000_000))

# 2. Use sets for membership testing
# BAD: O(n) lookup
if item in large_list:  # Slow for large lists
    pass
# GOOD: O(1) lookup
if item in large_set:   # Instant regardless of size
    pass

# 3. Use dict.get() instead of try/except for missing keys
# Slower:
try:
    value = data[key]
except KeyError:
    value = default
# Faster:
value = data.get(key, default)

# 4. Use join for string concatenation
# BAD: O(n²)
result = ""
for item in items:
    result += item  # Creates new string each time!
# GOOD: O(n)
result = "".join(items)

# 5. Use local variables in loops
# Slightly slower (global lookup each iteration):
for item in items:
    result.append(item.upper())
# Slightly faster (local reference):
append = result.append
upper = str.upper
for item in items:
    append(upper(item))
```

---

# Module 23: Production Engineering & SRE

### 🎯 Learning Objectives

- Understand SRE principles
- Implement reliability patterns in Python
- Handle production incidents

### Key SRE Concepts

| Concept | Description |
|---------|-------------|
| SLI (Service Level Indicator) | Measurable metric (e.g., latency, error rate) |
| SLO (Service Level Objective) | Target for SLI (e.g., 99.9% availability) |
| SLA (Service Level Agreement) | Contract with consequences if SLO is broken |
| Error Budget | How much unreliability is acceptable |
| Toil | Repetitive manual work that should be automated |

### Circuit Breaker Pattern

```python
import time
from enum import Enum


class CircuitState(Enum):
    CLOSED = "closed"         # Normal operation
    OPEN = "open"             # Failing, reject requests
    HALF_OPEN = "half_open"   # Testing if service recovered


class CircuitBreaker:
    """
    Prevents cascading failures by stopping calls to a failing service.
    
    Real-world analogy: Like an electrical circuit breaker —
    when too much current flows (too many errors), it "trips" 
    and stops all current (requests) until the problem is fixed.
    """
    
    def __init__(self, failure_threshold=5, recovery_timeout=30):
        self.failure_threshold = failure_threshold
        self.recovery_timeout = recovery_timeout
        self.state = CircuitState.CLOSED
        self.failure_count = 0
        self.last_failure_time = None
    
    def call(self, func, *args, **kwargs):
        if self.state == CircuitState.OPEN:
            if time.time() - self.last_failure_time > self.recovery_timeout:
                self.state = CircuitState.HALF_OPEN
            else:
                raise RuntimeError("Circuit breaker is OPEN — service unavailable")
        
        try:
            result = func(*args, **kwargs)
            self._on_success()
            return result
        except Exception as e:
            self._on_failure()
            raise
    
    def _on_success(self):
        self.failure_count = 0
        self.state = CircuitState.CLOSED
    
    def _on_failure(self):
        self.failure_count += 1
        self.last_failure_time = time.time()
        if self.failure_count >= self.failure_threshold:
            self.state = CircuitState.OPEN


# Usage
db_breaker = CircuitBreaker(failure_threshold=3, recovery_timeout=60)

def query_database(sql):
    return db_breaker.call(actual_db_query, sql)
```

### Graceful Shutdown

```python
import signal
import sys
import time


class GracefulShutdown:
    """Handle shutdown signals gracefully in production."""
    
    def __init__(self):
        self.shutdown_requested = False
        signal.signal(signal.SIGTERM, self._handle_signal)
        signal.signal(signal.SIGINT, self._handle_signal)
    
    def _handle_signal(self, signum, frame):
        print(f"Received signal {signum}. Initiating graceful shutdown...")
        self.shutdown_requested = True
    
    @property
    def should_continue(self):
        return not self.shutdown_requested


# Usage in a long-running service
shutdown = GracefulShutdown()

while shutdown.should_continue:
    # Process work
    process_next_item()
    time.sleep(1)

# Cleanup after loop exits
print("Shutting down: closing connections, flushing buffers...")
cleanup()
sys.exit(0)
```

### Retry with Exponential Backoff

```python
import time
import random
from functools import wraps


def retry_with_backoff(max_retries=3, base_delay=1, max_delay=60, 
                       exceptions=(Exception,)):
    """
    Production-grade retry decorator with exponential backoff and jitter.
    
    Exponential backoff: wait 1s, 2s, 4s, 8s...
    Jitter: add randomness to prevent thundering herd problem
    """
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            for attempt in range(max_retries + 1):
                try:
                    return func(*args, **kwargs)
                except exceptions as e:
                    if attempt == max_retries:
                        raise
                    
                    # Exponential backoff with jitter
                    delay = min(base_delay * (2 ** attempt), max_delay)
                    jitter = random.uniform(0, delay * 0.1)
                    sleep_time = delay + jitter
                    
                    print(f"Attempt {attempt + 1} failed: {e}. "
                          f"Retrying in {sleep_time:.1f}s...")
                    time.sleep(sleep_time)
        return wrapper
    return decorator


@retry_with_backoff(max_retries=5, base_delay=2, exceptions=(ConnectionError, TimeoutError))
def call_external_service(url):
    import requests
    response = requests.get(url, timeout=10)
    response.raise_for_status()
    return response.json()
```

---

# Module 24: Interview Preparation

### 🎯 Learning Objectives

- Prepare for Python/DevOps interview questions
- Understand what interviewers look for
- Practice explaining concepts clearly

### Top 30 Interview Questions & Answers

**1. What is the difference between a list and a tuple?**
> Lists are mutable (can be changed), tuples are immutable (cannot be changed). Use tuples for fixed data (coordinates, config values) and lists for collections that change. Tuples are slightly faster and can be used as dictionary keys.

**2. Explain the GIL.**
> The Global Interpreter Lock allows only one thread to execute Python bytecode at a time in CPython. This means threading doesn't provide true parallelism for CPU-bound tasks. For I/O-bound tasks (network, disk), threading still helps because the GIL is released during I/O operations. For CPU-bound parallelism, use multiprocessing.

**3. What is a decorator?**
> A decorator is a function that takes another function as input, adds behavior, and returns a modified function — without changing the original function's source code. Uses closures internally. The @syntax is sugar for `func = decorator(func)`.

**4. Explain generators and why they matter for DevOps.**
> Generators produce values lazily using `yield` — one at a time instead of all at once. They're memory-efficient for processing large files, streaming API responses, or iterating over paginated AWS results. A 10 GB log file can be processed with constant memory using a generator.

**5. How do you handle secrets in Python automation?**
> Never hardcode secrets. Use: (1) Environment variables for simple cases, (2) AWS Secrets Manager/SSM Parameter Store for cloud, (3) HashiCorp Vault for multi-cloud, (4) CI/CD secret stores (GitHub Secrets, Jenkins Credentials). Always encrypt in transit and at rest.

**6. What is the difference between `==` and `is`?**
> `==` compares values (equality). `is` compares identity (same object in memory). Use `is` only for `None` checks: `if x is None`.

**7. How do you handle errors in production Python scripts?**
> Catch specific exceptions (never bare `except:`), log errors with context, implement retries with exponential backoff for transient failures, use circuit breakers for downstream services, alert on critical failures, and always have a cleanup path (finally/context managers).

**8. Explain virtual environments.**
> Virtual environments create isolated Python installations per project. Each has its own packages independent of other projects and the system Python. This prevents version conflicts and ensures reproducible builds. Created with `python -m venv .venv`.

**9. How does Python integrate with Kubernetes?**
> Using the official `kubernetes` Python client library. It can list/create/delete pods and deployments, scale services, read logs, manage ConfigMaps/Secrets, watch for events, and implement custom operators. It authenticates via kubeconfig or in-cluster service accounts.

**10. What is the `with` statement?**
> The `with` statement implements context management — guarantees cleanup (closing files, releasing connections) even if exceptions occur. Uses `__enter__` and `__exit__` dunder methods. Essential for resource management in production.

**11. How do you optimize a slow Python script?**
> (1) Profile first with cProfile, (2) Use appropriate data structures (set for lookups), (3) Use generators for large data, (4) Use concurrent.futures for I/O-bound tasks, (5) Use multiprocessing for CPU-bound tasks, (6) Cache expensive computations, (7) Avoid string concatenation in loops (use join).

**12. Explain *args and **kwargs.**
> `*args` collects extra positional arguments into a tuple. `**kwargs` collects extra keyword arguments into a dictionary. Used in wrapper functions, decorators, and APIs that need to accept variable arguments.

**13. How do you test infrastructure automation code?**
> (1) Unit tests with pytest and mocking (mock boto3 calls), (2) Integration tests against test environments, (3) Use moto library to mock AWS services locally, (4) Use testinfra for infrastructure testing, (5) Validate terraform plans programmatically.

**14. What is the difference between threading and multiprocessing?**
> Threading: multiple threads, shared memory, limited by GIL for CPU tasks, good for I/O. Multiprocessing: multiple processes, separate memory, true parallelism, good for CPU-bound work. Asyncio: single thread, cooperative multitasking, best for thousands of I/O operations.

**15. How do you make Python scripts production-ready?**
> (1) Proper logging (not print), (2) Error handling with retries, (3) Configuration via environment variables, (4) Health checks, (5) Graceful shutdown handling, (6) Metrics exposure, (7) Tests, (8) Type hints, (9) Documentation, (10) Containerization.

**16. Explain how you'd automate AWS infrastructure with Python.**
> Use boto3 library: create/manage EC2 instances, S3 buckets, Lambda functions, RDS databases. Combine with Terraform for declarative infra and Python for orchestration, validation, and dynamic configuration. Use SSM for secrets, CloudWatch for monitoring.

**17. What is a context manager and how would you create one?**
> A context manager manages resource lifecycle (acquire → use → release). Create using: (1) Class with `__enter__` and `__exit__` methods, or (2) `@contextmanager` decorator with a generator function containing a `yield`.

**18. How do you handle configuration in Python DevOps tools?**
> Layered approach: (1) Default values in code, (2) Configuration files (YAML/JSON), (3) Environment variables override files, (4) Command-line arguments override everything. Use `argparse` for CLI, `os.environ` for env vars, `yaml.safe_load` for config files.

**19. Explain the Python import system.**
> When you `import module`, Python: (1) checks sys.modules cache, (2) searches sys.path directories, (3) executes the module file top-to-bottom, (4) creates module object, (5) caches in sys.modules. Packages use `__init__.py`. Relative imports use dots.

**20. How do you implement CI/CD for a Python project?**
> (1) Lint (flake8/ruff), (2) Type check (mypy), (3) Unit tests (pytest), (4) Security scan (bandit, pip-audit), (5) Build Docker image, (6) Push to registry, (7) Deploy to staging, (8) Integration tests, (9) Manual approval gate, (10) Deploy to production, (11) Smoke tests, (12) Monitor.

---

### Practice Exercises

1. Write a script that checks health of 5 URLs and reports results
2. Create a decorator that logs function execution time
3. Write a generator that reads a large log file and yields only ERROR lines
4. Create a class that manages SSH connections with context manager support
5. Write a script that lists all S3 buckets and checks their encryption status
6. Build a CLI tool with argparse that accepts environment and service name
7. Write a retry decorator with exponential backoff
8. Create a pytest test file with fixtures and parametrize
9. Write a Docker compose generator in Python
10. Build a simple Prometheus exporter for system metrics

---

### Beginner Quiz (15 Questions)

1. Is Python compiled or interpreted? *(Both — compiled to bytecode, then interpreted)*
2. What does `pip freeze` do? *(Outputs all installed packages with versions)*
3. What is the difference between `=` and `==`? *(Assignment vs comparison)*
4. Are strings mutable or immutable? *(Immutable)*
5. What does `if servers:` check? *(Whether the list is non-empty — truthiness)*
6. What does `yield` do? *(Pauses function, returns value, resumes on next call)*
7. What is `self` in a class? *(Reference to the current instance)*
8. What does `@wraps(func)` do in a decorator? *(Preserves original function's metadata)*
9. Why use `yaml.safe_load()` instead of `yaml.load()`? *(Security — prevents code execution)*
10. What does `subprocess.run` with `check=True` do? *(Raises exception if command fails)*
11. What is the purpose of `__init__.py`? *(Makes a directory a Python package)*
12. Why pin versions in requirements.txt? *(Reproducible builds, prevent breaking changes)*
13. What is a virtual environment? *(Isolated Python installation per project)*
14. What does `**kwargs` collect? *(Keyword arguments into a dictionary)*
15. Why never use `shell=True` with user input in subprocess? *(Shell injection vulnerability)*

---

## 🎓 Course Summary

This study guide covers the complete journey from Python beginner to production DevOps engineer:

| Module | Focus |
|--------|-------|
| 1-2 | Foundation: Python setup, environment management |
| 3 | Core: Data types, control flow |
| 4-6 | Intermediate: Functions, OOP, generators |
| 7-12 | Applied: Modules, files, regex, JSON/YAML |
| 13-16 | Professional: Logging, APIs, concurrency, type hints |
| 17 | DevOps Library: os, subprocess, boto3, paramiko |
| 18 | CI/CD: Jenkins, GitHub Actions, Terraform, Docker, K8s |
| 19-22 | Production: Testing, monitoring, security, performance |
| 23-24 | SRE & Career: Production patterns, interview prep |

### Key Principles to Remember

1. **Understand concepts before code** — why matters more than how
2. **Python is for automation** — eliminate toil, reduce human error
3. **Security first** — never hardcode secrets, validate all input
4. **Test everything** — untested automation is dangerous automation
5. **Monitor everything** — you can't fix what you can't see
6. **Fail gracefully** — retries, circuit breakers, graceful shutdown
7. **Automate the automation** — CI/CD for your CI/CD scripts
8. **Keep it simple** — readable code > clever code

---

*End of Study Guide — Version 1.0*
*Generated for comprehensive Python + DevOps learning, revision, and interview preparation.*
