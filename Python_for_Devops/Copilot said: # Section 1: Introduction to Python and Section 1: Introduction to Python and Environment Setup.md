# Section 1: Introduction to Python and Environment Setup

---

## 📑 Table of Contents

- [1.1 What is Python?](#11-what-is-python)
- [1.2 Why Python Exists](#12-why-python-exists)
- [1.3 Why DevOps Engineers Use Python](#13-why-devops-engineers-use-python)
- [1.4 How Python Works Internally](#14-how-python-works-internally)
- [1.5 Python Installation](#15-python-installation)
- [1.6 PATH Configuration](#16-path-configuration)
- [1.7 The Python Interpreter](#17-the-python-interpreter)
- [1.8 Pyenv – Managing Multiple Python Versions](#18-pyenv--managing-multiple-python-versions)
- [1.9 Virtual Environments](#19-virtual-environments)
- [1.10 pip and Dependency Management](#110-pip-and-dependency-management)
- [1.11 requirements.txt](#111-requirementstxt)
- [1.12 Section Summary and Review](#112-section-summary-and-review)

---

## 🎯 Learning Objectives

By the end of this section, you will:

1. Understand what Python is, why it was created, and what problems it solves
2. Understand how Python code is executed internally (interpreted vs compiled)
3. Install Python correctly on Linux, macOS, and Windows
4. Understand what PATH is and why misconfiguring it causes problems
5. Use the Python interpreter (REPL) for quick testing
6. Install and use `pyenv` to manage multiple Python versions
7. Create and manage virtual environments using `venv`
8. Use `pip` to install, upgrade, and remove packages
9. Create and use `requirements.txt` for reproducible environments
10. Avoid the most common beginner environment setup mistakes

---

## 1.1 What is Python?

### Real-Life Analogy

Imagine you want to communicate with someone who speaks a completely different language. You would need a translator — someone who takes your words (which you understand) and converts them into words the other person understands.

**Python is exactly that translator between you (the human) and the computer (the machine).**

You write instructions in Python (which looks close to English), and Python translates those instructions into something the computer's processor can execute.

### What It Is

Python is a **programming language** — a set of rules and vocabulary that allows humans to write instructions for computers. It was created in **1991** by **Guido van Rossum**, a Dutch programmer who wanted a language that was:

- Easy to read (like reading English sentences)
- Easy to write (less typing, fewer symbols)
- Powerful enough for real-world work

### Why It Is Called "Python"

It is NOT named after the snake. Guido van Rossum was a fan of the British comedy show **"Monty Python's Flying Circus"** and chose the name because he wanted the language to be fun to use.

### What Problem It Solves

Before Python, most programming languages (like C, C++, Assembly) required:
- Writing many lines of code for simple tasks
- Managing computer memory manually
- Understanding complex low-level details
- Long compile-wait-test cycles

Python solves these problems by letting you:
- Write fewer lines of code
- Ignore memory management (Python handles it automatically)
- Focus on **what** you want to do, not **how** the computer does it
- Test code instantly without waiting for compilation

### Where Python Is Used

| Domain | Usage |
|--------|-------|
| DevOps & Automation | Scripts, CI/CD pipelines, infrastructure management |
| Cloud Engineering | AWS (boto3), Azure, GCP automation |
| Web Development | Django, Flask, FastAPI |
| Data Science | Pandas, NumPy, Matplotlib |
| Machine Learning | TensorFlow, PyTorch, scikit-learn |
| Network Automation | Paramiko, Netmiko, NAPALM |
| Security | Penetration testing, log analysis |
| System Administration | File management, process automation |

### Advantages of Python

1. **Readable** — Code looks like English
2. **Beginner-friendly** — Low barrier to entry
3. **Massive ecosystem** — 400,000+ packages available
4. **Cross-platform** — Runs on Linux, macOS, Windows
5. **Versatile** — Web, automation, data, AI, DevOps
6. **Community** — Millions of developers, extensive documentation
7. **Industry demand** — Required in most DevOps/Cloud roles

### Disadvantages of Python

1. **Slower than C/C++/Go** — Because it is interpreted, not compiled to machine code
2. **Not ideal for mobile development** — Limited mobile app support
3. **Global Interpreter Lock (GIL)** — Limits true multi-threading (advanced topic)
4. **Runtime errors** — Type errors caught at runtime, not compile time

### When to Use Python

✅ Automation scripts, CI/CD tooling, cloud infrastructure, APIs, data processing, configuration management, monitoring, reporting

### When NOT to Use Python

❌ High-performance systems (use Go/Rust), mobile apps (use Swift/Kotlin), browser front-end (use JavaScript), real-time embedded systems (use C)

### Interview Perspective

> **Q: Why do DevOps engineers prefer Python over other languages?**
>
> A: Python offers readable syntax, a massive library ecosystem (boto3, requests, paramiko, yaml, json), cross-platform compatibility, rapid prototyping, and seamless integration with every major DevOps tool (Jenkins, Terraform, Docker, Kubernetes, AWS). It allows engineers to automate infrastructure tasks quickly without dealing with compilation or complex syntax.

---

## 1.2 Why Python Exists

### The History

In the late 1980s, Guido van Rossum was working at a research institute in the Netherlands. He was using a language called **ABC** (designed for teaching) and another called **C** (powerful but complex). He thought:

- ABC is easy to read but limited in capability
- C is powerful but difficult to write and error-prone

He wanted something in between: **easy like ABC, powerful like C**. He started working on Python in December 1989 and released version 0.9.0 in February 1991.

### The Design Philosophy

Python follows a set of principles called **"The Zen of Python"** (you can see them by typing `import this` in Python). The key ones:

```
Beautiful is better than ugly.
Simple is better than complex.
Readability counts.
There should be one obvious way to do it.
Errors should never pass silently.
```

This philosophy is WHY Python code looks cleaner than most other languages.

### Comparison: Same Task in Different Languages

**Task:** Print "Hello, World" to the screen.

**Java:**
```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World");
    }
}
```

**C:**
```c
#include <stdio.h>
int main() {
    printf("Hello, World\n");
    return 0;
}
```

**Python:**
```python
print("Hello, World")
```

One line. No boilerplate. No semicolons. No curly braces. This simplicity is **by design** — and it's why Python became the dominant language in automation and DevOps.

---

## 1.3 Why DevOps Engineers Use Python

### The Problem DevOps Engineers Face

DevOps engineers deal with:
- Hundreds or thousands of servers
- Multiple cloud environments (AWS, Azure, GCP)
- Complex CI/CD pipelines
- Configuration management across environments
- Log analysis and monitoring
- Security scanning and compliance checks
- Infrastructure provisioning and teardown

Doing these tasks manually is **impossible at scale**. You need automation — and Python is the most natural choice for it.

### Why Python Specifically (Not Bash, Not Go, Not Ruby)

| Criteria | Bash | Python | Go |
|----------|------|--------|----|
| Readability | Low (for complex scripts) | High | Medium |
| Error handling | Poor | Excellent | Excellent |
| Libraries for AWS/Cloud | None | boto3, azure-sdk | aws-sdk-go |
| Data parsing (JSON/YAML) | Painful | Native support | Good |
| Learning curve | Medium | Low | High |
| Cross-platform | Linux/macOS only | All platforms | All platforms |
| Community for DevOps | Limited | Massive | Growing |

**Key insight:** Bash is great for simple 5-10 line scripts. But the moment you need error handling, API calls, data parsing, or logic beyond simple commands — Python is superior.

### Real-World DevOps Python Use Cases

1. **AWS Automation** — Create/delete EC2 instances, manage S3 buckets, configure IAM
2. **Kubernetes** — Deploy pods, check health, scale deployments
3. **Jenkins** — Trigger builds, parse results, send notifications
4. **Terraform** — Generate dynamic configurations, validate state files
5. **Docker** — Build images, manage containers, clean up resources
6. **Monitoring** — Parse logs, send alerts, generate reports
7. **Security** — Scan for vulnerabilities, rotate credentials, audit access

### Production Scenario

> **Scenario:** Your company runs 500 EC2 instances across 3 AWS regions. Every night, you need to stop all development instances (to save costs) and start them every morning.
>
> **Without Python:** Manually log into AWS console, find instances, stop each one. Takes 2 hours. Error-prone.
>
> **With Python (boto3):** A 20-line script that runs via cron/Lambda, stops all tagged dev instances at 8 PM, starts them at 8 AM. Runs in 30 seconds. Zero human intervention.

---

## 1.4 How Python Works Internally

### Real-Life Analogy

Think of a **simultaneous interpreter** at the United Nations. When a speaker talks, the interpreter translates **sentence by sentence** in real-time. They don't wait for the entire speech to finish before translating.

Python works the same way. It reads your code **line by line**, translates it, and executes it immediately.

### Compiled vs Interpreted Languages

| Aspect | Compiled (C, Go, Rust) | Interpreted (Python, Ruby) |
|--------|------------------------|---------------------------|
| Process | Entire code → machine code → run | Line by line → execute |
| Speed | Fast execution | Slower execution |
| Error detection | Before running (compile time) | While running (runtime) |
| Output | Binary executable file | No separate file |
| Example | `gcc main.c -o main && ./main` | `python main.py` |

### What Actually Happens When You Run `python script.py`

```
┌─────────────────────────────────────────────────────────┐
│                  YOUR PYTHON CODE                         │
│                   (script.py)                             │
└──────────────────────┬──────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│              PYTHON INTERPRETER (CPython)                 │
│                                                          │
│  Step 1: Lexing (breaking code into tokens)              │
│  Step 2: Parsing (understanding structure)               │
│  Step 3: Compiling to Bytecode (.pyc files)              │
│  Step 4: Python Virtual Machine (PVM) executes bytecode  │
└──────────────────────────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│                   OUTPUT / RESULT                         │
└─────────────────────────────────────────────────────────┘
```

### Key Terms Explained

- **CPython** — The default Python interpreter, written in C. When people say "Python," they usually mean CPython.
- **Bytecode** — An intermediate representation of your code (not human-readable, not machine code). Stored in `__pycache__/` folders as `.pyc` files.
- **PVM (Python Virtual Machine)** — The engine inside CPython that reads bytecode and tells the CPU what to do.

### Why This Matters for DevOps

Understanding that Python is interpreted means:
1. **No compilation step** — You edit a script and run it immediately (fast iteration)
2. **Runtime errors** — Bugs appear only when that line executes (you must test thoroughly)
3. **Portability** — The same `.py` file runs on any machine with Python installed
4. **Slightly slower** — Acceptable for automation; not acceptable for high-frequency trading

---

## 1.5 Python Installation

### Why Proper Installation Matters

The #1 reason beginners struggle with Python is **installation problems**:
- Wrong Python version
- Multiple Python versions conflicting
- System Python vs user Python confusion
- PATH not configured
- `pip` installing packages in the wrong location

Getting installation right from the start saves you hours of debugging later.

### Linux (Ubuntu/Debian)

Most Linux distributions come with Python pre-installed (called **system Python**). However, you should **never modify the system Python** — it's used by the operating system itself.

```bash
# Check if Python is already installed
python3 --version

# Install Python (Ubuntu/Debian)
sudo apt update
sudo apt install python3 python3-pip python3-venv

# Verify installation
python3 --version
pip3 --version
```

**Why `python3` and not `python`?**

Historically, `python` referred to Python 2 (now deprecated since January 2020). To avoid confusion, Linux systems use `python3` explicitly. On some modern systems, `python` may point to Python 3, but never assume this — always use `python3`.

### macOS

```bash
# macOS comes with a very old Python. Install fresh via Homebrew:
brew install python

# Verify
python3 --version
pip3 --version
```

### Windows

1. Download from [python.org](https://www.python.org/downloads/)
2. **CRITICAL:** Check the box that says **"Add Python to PATH"** during installation
3. Open Command Prompt and verify:

```cmd
python --version
pip --version
```

### Common Mistake: Multiple Python Versions

```bash
# This is a common confusing situation:
$ python --version
Python 2.7.18

$ python3 --version
Python 3.11.5

$ python3.12 --version
Python 3.12.1
```

**Which one runs when you type `python`?** It depends on your PATH (explained next).

---

## 1.6 PATH Configuration

### Real-Life Analogy

Imagine you're in a huge library. You ask the librarian for a book called "Python." The librarian doesn't search the entire library randomly — they check specific shelves in a specific order. If "Python" is on Shelf A, they find it. If it's not on any shelf they check, they say "Book not found."

**PATH is the list of shelves (directories) your operating system checks when you type a command.**

### What PATH Is

PATH is an **environment variable** — a piece of configuration that tells your operating system:

> "When the user types a command, look for executable files in THESE directories, in THIS order."

### How to See Your PATH

```bash
# Linux/macOS
echo $PATH
```

Output looks like:
```
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/home/user/.local/bin
```

Each directory is separated by `:` (Linux/macOS) or `;` (Windows). The OS searches left to right.

### Why PATH Problems Happen

```
┌─────────────────────────────────────────────┐
│  You type: python3                           │
│                                              │
│  OS checks PATH directories in order:        │
│  1. /usr/local/bin/  → python3 found? NO     │
│  2. /usr/bin/        → python3 found? YES ✓  │
│  3. (stops here, uses this one)              │
└─────────────────────────────────────────────┘
```

If you installed Python in `/opt/python3.12/bin/` but that directory isn't in your PATH, typing `python3` will either:
- Use an older version found earlier in PATH
- Show "command not found"

### How to Fix PATH

```bash
# Add a directory to PATH (temporary — current session only)
export PATH="/opt/python3.12/bin:$PATH"

# Add permanently (add to ~/.bashrc or ~/.zshrc)
echo 'export PATH="/opt/python3.12/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Debugging PATH Issues

```bash
# Find where a command is located
which python3
# /usr/bin/python3

# Find ALL locations of python3 in PATH
whereis python3

# Check what version is being used
python3 --version
```

### Common Mistake

> "I installed Python 3.12 but `python3 --version` still shows 3.8!"

**Reason:** The old Python's directory appears before the new one in PATH. Fix by prepending the new directory to PATH.

---

## 1.7 The Python Interpreter

### What It Is

The Python interpreter is the program that reads and executes your Python code. It has two modes:

1. **Interactive mode (REPL)** — You type one line, Python executes it immediately
2. **Script mode** — You write code in a `.py` file and run the entire file

### REPL (Read-Eval-Print Loop)

```bash
$ python3
Python 3.11.5 (main, Sep 11 2023, 08:19:27)
>>> 2 + 2
4
>>> print("Hello")
Hello
>>> name = "DevOps"
>>> print(f"I am learning {name}")
I am learning DevOps
>>> exit()
```

**What REPL means:**
- **Read** — Python reads what you typed
- **Eval** — Python evaluates (executes) it
- **Print** — Python prints the result
- **Loop** — Goes back to waiting for your next input

### When to Use REPL

✅ Quick calculations, testing a small idea, checking how a function works, debugging

### When NOT to Use REPL

❌ Writing actual scripts, anything more than 5 lines, anything you need to save

### Script Mode

Create a file called `hello.py`:

```python
print("Hello from a Python script!")
```

Run it:

```bash
python3 hello.py
```

Output:
```
Hello from a Python script!
```

---

## 1.8 Pyenv – Managing Multiple Python Versions

### Why It Exists

In production environments, you will encounter:
- Project A requires Python 3.9
- Project B requires Python 3.11
- Project C requires Python 3.12
- Your system has Python 3.8

You need a way to install and switch between multiple Python versions **without breaking anything**. That tool is `pyenv`.

### Real-Life Analogy

Think of `pyenv` as a **wardrobe manager**. You have multiple outfits (Python versions). The wardrobe manager lets you pick which outfit to wear today (which Python version to use) without throwing away the others.

### Installation (Linux/macOS)

```bash
# Install pyenv
curl https://pyenv.run | bash

# Add to shell configuration (~/.bashrc or ~/.zshrc)
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
```

### Common Commands

```bash
# List all available Python versions
pyenv install --list

# Install a specific version
pyenv install 3.12.1

# List installed versions
pyenv versions

# Set global default
pyenv global 3.12.1

# Set version for current directory (project-specific)
pyenv local 3.11.5

# Check active version
pyenv version
```

### How `pyenv local` Works

When you run `pyenv local 3.11.5` in a directory, it creates a file called `.python-version` containing `3.11.5`. Whenever you're in that directory (or any subdirectory), pyenv automatically uses Python 3.11.5.

```
my-project/
├── .python-version    ← Contains "3.11.5"
├── app.py
└── tests/
```

### Production Best Practice

> Always use `pyenv local` for projects so that every team member uses the same Python version. Commit `.python-version` to version control.

---

## 1.9 Virtual Environments

### Why They Exist — The Core Problem

Imagine this scenario:

- **Project A** needs `requests==2.25.0`
- **Project B** needs `requests==2.31.0`

If both projects use the same Python installation, you can only have ONE version of `requests` installed. Installing one breaks the other. This is called a **dependency conflict**.

### Real-Life Analogy

Think of virtual environments as **separate apartments in the same building**. Each apartment (virtual environment) has its own furniture (packages). What you put in Apartment A doesn't affect Apartment B. But they're all in the same building (same computer).

### What a Virtual Environment Actually Is

A virtual environment is simply a **directory** containing:
1. A copy of (or symlink to) the Python interpreter
2. Its own `pip`
3. Its own `site-packages/` directory (where installed packages go)

```
my-project/
├── venv/                    ← The virtual environment
│   ├── bin/                 ← Python and pip executables
│   │   ├── python3          
│   │   ├── pip              
│   │   └── activate         ← Script to "enter" the environment
│   ├── lib/                 
│   │   └── python3.11/
│   │       └── site-packages/  ← Packages installed here (isolated!)
│   └── pyvenv.cfg           ← Configuration
├── app.py
└── requirements.txt
```

### Creating and Using Virtual Environments

```bash
# Step 1: Navigate to your project directory
cd my-project

# Step 2: Create a virtual environment called "venv"
python3 -m venv venv

# Step 3: Activate the virtual environment
source venv/bin/activate    # Linux/macOS
# venv\Scripts\activate     # Windows

# Step 4: Your prompt changes to show you're in the environment
(venv) $ python --version
Python 3.11.5

# Step 5: Install packages (they go into venv/lib/site-packages/)
(venv) $ pip install requests

# Step 6: When done, deactivate
(venv) $ deactivate
$
```

### Line-by-Line Explanation

| Command | What It Does |
|---------|--------------|
| `python3 -m venv venv` | Tells Python to run the `venv` module (`-m venv`) and create a directory called `venv` |
| `source venv/bin/activate` | Modifies your shell's PATH so that `python` and `pip` point to the virtual environment's copies |
| `deactivate` | Restores your original PATH |

### Common Mistakes

1. **Forgetting to activate** — You install packages globally instead of in the venv
2. **Committing `venv/` to Git** — Never do this! Add `venv/` to `.gitignore`
3. **Naming the venv the same as your project** — Use `venv` or `.venv` as the directory name
4. **Using `virtualenv` vs `venv`** — `venv` is built-in (Python 3.3+). `virtualenv` is a third-party tool with more features. For most cases, `venv` is sufficient.

### Best Practice: `.gitignore` Entry

```
venv/
.venv/
__pycache__/
*.pyc
```

---

## 1.10 pip and Dependency Management

### What pip Is

`pip` stands for **"pip installs packages"** (a recursive acronym). It is Python's package installer — the tool that downloads and installs libraries from the **Python Package Index (PyPI)** at [pypi.org](https://pypi.org).

### Real-Life Analogy

Think of `pip` as an **app store** for Python. PyPI is the store, and `pip` is the tool you use to download and install apps (packages) from that store.

### Essential Commands

```bash
# Install a package
pip install requests

# Install a specific version
pip install requests==2.31.0

# Install minimum version
pip install "requests>=2.28.0"

# Upgrade a package
pip install --upgrade requests

# Uninstall a package
pip uninstall requests

# List installed packages
pip list

# Show details about a package
pip show requests

# Check for outdated packages
pip list --outdated
```

### How pip Works Internally

```
┌────────────┐         ┌──────────────┐         ┌─────────────────┐
│  You type  │         │   pip talks  │         │    Downloads     │
│  pip       │────────▶│   to PyPI    │────────▶│    & installs    │
│  install X │         │   (pypi.org) │         │    into          │
│            │         │              │         │    site-packages/ │
└────────────┘         └──────────────┘         └─────────────────┘
```

### Security Consideration

> **Production Best Practice:** Always pin exact versions (`requests==2.31.0`) in production. Never use `>=` or no version specifier in production — you might get a breaking update.

---

## 1.11 requirements.txt

### What It Is

A `requirements.txt` file is a simple text file listing all packages (and their versions) that your project needs. It allows anyone to recreate your exact environment.

### Why It Exists

Without it:
- "It works on my machine but not on yours" — different package versions
- No way to reproduce the exact environment for CI/CD
- No way for new team members to set up quickly

### Creating requirements.txt

```bash
# Method 1: Freeze current environment (captures everything installed)
pip freeze > requirements.txt

# Method 2: Write manually (preferred for projects)
```

Example `requirements.txt`:
```
requests==2.31.0
boto3==1.28.57
pyyaml==6.0.1
paramiko==3.3.1
```

### Installing from requirements.txt

```bash
pip install -r requirements.txt
```

This installs every package listed, at the exact versions specified.

### Production Workflow

```
┌─────────────────────────────────────────────────────────────┐
│  Developer Machine                                           │
│                                                              │
│  1. Create venv                                              │
│  2. Install packages as needed                               │
│  3. pip freeze > requirements.txt                            │
│  4. Commit requirements.txt to Git                           │
└──────────────────────────┬──────────────────────────────────┘
                           │ git push
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  CI/CD Pipeline (Jenkins/GitHub Actions)                     │
│                                                              │
│  1. python -m venv venv                                      │
│  2. source venv/bin/activate                                 │
│  3. pip install -r requirements.txt  ← Exact same packages!  │
│  4. Run tests                                                │
│  5. Deploy                                                   │
└─────────────────────────────────────────────────────────────┘
```

### Common Mistakes

| Mistake | Consequence |
|---------|-------------|
| Not pinning versions | Builds break randomly when packages update |
| Using `pip freeze` in global Python | Captures unrelated system packages |
| Not updating requirements.txt after adding packages | Team members missing dependencies |
| Committing `venv/` instead of `requirements.txt` | Bloated repository, platform-specific issues |

---

## 1.12 Section Summary and Review

### What You Learned

| Topic | Key Takeaway |
|-------|-------------|
| Python | An interpreted, high-level language designed for readability |
| Why DevOps uses Python | Rich ecosystem, cross-platform, rapid automation |
| How Python works | Source → Bytecode → PVM executes line by line |
| Installation | Use `python3`, never modify system Python |
| PATH | The OS's search list for executables |
| Interpreter | REPL for testing, script mode for real work |
| pyenv | Manages multiple Python versions per project |
| Virtual environments | Isolated package directories per project |
| pip | Downloads packages from PyPI |
| requirements.txt | Reproducible environments across machines |

### Production Scenario Recap

> A DevOps team of 5 engineers works on an AWS automation project. They use:
> - `pyenv` with `.python-version` committed to Git → everyone uses Python 3.11.5
> - `venv` for isolation → no conflicts with other projects
> - `requirements.txt` with pinned versions → CI/CD builds are reproducible
> - `.gitignore` excludes `venv/` and `__pycache__/`

### Common Interview Questions

1. **Q: What is the difference between Python 2 and Python 3?**
   A: Python 2 is deprecated (EOL Jan 2020). Python 3 has better Unicode support, `print()` as a function, integer division behavior, and modern features. Always use Python 3.

2. **Q: What is a virtual environment and why do we need it?**
   A: An isolated directory with its own Python and packages, preventing dependency conflicts between projects.

3. **Q: What is the difference between `pip install` and `pip install -r requirements.txt`?**
   A: The first installs a single package; the second installs all packages listed in the file, typically with pinned versions for reproducibility.

4. **Q: How do you manage multiple Python versions on one machine?**
   A: Use `pyenv`. It allows installing, switching, and setting per-project Python versions.

5. **Q: What should you never do with system Python?**
   A: Never `pip install` packages into system Python or modify it — the OS depends on it.

### Practice Exercises

1. Install Python 3.11+ on your machine and verify with `python3 --version`
2. Check your PATH and identify where `python3` is located using `which python3`
3. Create a directory called `practice-project/`, create a virtual environment, activate it
4. Install the `requests` package inside the venv
5. Run `pip freeze > requirements.txt` and examine the file
6. Deactivate, delete the venv, recreate it, and install from `requirements.txt`
7. (Bonus) Install `pyenv`, install Python 3.12, set it as local version for your project

### Beginner Quiz (10 Questions)

1. Is Python compiled or interpreted?
2. What does REPL stand for?
3. What command creates a virtual environment?
4. Why should you never modify system Python?
5. What file lists project dependencies with versions?
6. What does `source venv/bin/activate` do?
7. What is PyPI?
8. What does PATH tell the operating system?
9. How do you install a specific version of a package?
10. What tool manages multiple Python versions per project?

<details>
<summary>Quiz Answers</summary>

1. Interpreted (technically compiled to bytecode, then interpreted by PVM)
2. Read-Eval-Print Loop
3. `python3 -m venv venv`
4. The OS uses it for system tools; breaking it can break the system
5. `requirements.txt`
6. Modifies PATH so `python` and `pip` point to the virtual environment
7. Python Package Index — the repository of Python packages
8. Which directories to search for executable commands
9. `pip install package==version` (e.g., `pip install requests==2.31.0`)
10. `pyenv`

</details>

### Next Section Preview

**Section 2: Python Fundamentals — Variables, Data Types, and Operators**

You will learn how Python stores data, the different types of data (strings, numbers, booleans), how variables work internally (names pointing to objects in memory), naming conventions, type checking, type conversion, and all arithmetic/comparison/logical operators with detailed explanations.

---

*Ready for Section 2? Let me know and I'll generate it.*
