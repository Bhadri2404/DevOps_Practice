# Section 8: Modules, Packages, and Imports

---

## 📑 Table of Contents

- [8.1 What Are Modules?](#81-what-are-modules)
- [8.2 Why Modules Exist](#82-why-modules-exist)
- [8.3 How Imports Work Internally](#83-how-imports-work-internally)
- [8.4 Import Syntax Variations](#84-import-syntax-variations)
- [8.5 The Module Search Path (sys.path)](#85-the-module-search-path-syspath)
- [8.6 Creating Your Own Modules](#86-creating-your-own-modules)
- [8.7 The if __name__ == "__main__" Pattern](#87-the-if-__name__--__main__-pattern)
- [8.8 Packages — Organizing Modules](#88-packages--organizing-modules)
- [8.9 The __init__.py File](#89-the-__init__py-file)
- [8.10 Absolute vs Relative Imports](#810-absolute-vs-relative-imports)
- [8.11 Standard Library Highlights for DevOps](#811-standard-library-highlights-for-devops)
- [8.12 Third-Party Packages](#812-third-party-packages)
- [8.13 Import Best Practices and PEP 8](#813-import-best-practices-and-pep-8)
- [8.14 Circular Imports — The Problem and Solutions](#814-circular-imports--the-problem-and-solutions)
- [8.15 Project Structure for DevOps Tools](#815-project-structure-for-devops-tools)
- [8.16 Distributing Your Package](#816-distributing-your-package)
- [8.17 Common DevOps Module Patterns](#817-common-devops-module-patterns)
- [8.18 Section Summary and Review](#818-section-summary-and-review)

---

## 🎯 Learning Objectives

By the end of this section, you will:

1. Understand what modules are and why Python needs them
2. Know how Python's import system works internally (search path, caching, bytecode)
3. Master all import syntax forms and know when to use each
4. Create your own reusable modules
5. Understand and use the `if __name__ == "__main__"` pattern
6. Organize modules into packages with `__init__.py`
7. Understand absolute vs relative imports
8. Know the most important standard library modules for DevOps
9. Follow PEP 8 import ordering and best practices
10. Structure a real DevOps Python project for production

---

## 8.1 What Are Modules?

### Real-Life Analogy

Think of modules like **toolboxes in a workshop**. You don't keep every tool in one giant pile. Instead:
- One toolbox has **electrical tools** (wire strippers, voltmeter)
- Another has **plumbing tools** (wrenches, pipe cutters)
- Another has **measuring tools** (tape measure, level)

When you need to do electrical work, you grab the electrical toolbox. You don't carry all toolboxes everywhere.

In Python:
- One module has **file operation functions**
- Another has **network utilities**
- Another has **math operations**

When you need network utilities, you import that module. You don't load everything into memory.

### Definition

A **module** is simply a **Python file** (`.py`) containing definitions (functions, classes, variables) that can be imported and reused by other Python files.

```
module = any .py file that can be imported
```

That's it. Every `.py` file you've ever written is already a module.

### Three Types of Modules

```
┌──────────────────────────────────────────────────────────────┐
│                    PYTHON MODULES                              │
├──────────────────┬──────────────────┬────────────────────────┤
│  Built-in        │  Standard Library│  Third-Party / Custom  │
│  (compiled in C) │  (ships with     │  (pip install / your   │
│                  │   Python)        │   own .py files)       │
├──────────────────┼──────────────────┼────────────────────────┤
│  sys             │  os              │  requests              │
│  math            │  pathlib         │  boto3                 │
│  itertools       │  json            │  pyyaml                │
│  functools       │  csv             │  paramiko              │
│                  │  logging         │  your_module.py        │
│                  │  subprocess      │                        │
│                  │  datetime        │                        │
└──────────────────┴──────────────────┴────────────────────────┘
```

---

## 8.2 Why Modules Exist

### Problem 1: One Giant File Is Unmaintainable

Imagine a 10,000-line deployment automation script in a single file. Finding anything takes forever. Multiple engineers editing the same file causes constant merge conflicts.

**Modules solve this:** Split code into logical files — `deploy.py`, `health_check.py`, `notifications.py`, `config.py`.

### Problem 2: Code Duplication

Without modules, if 5 scripts need to check server health, each script has its own copy of the health check code. Fix a bug? You must find and fix all 5 copies.

**Modules solve this:** Write health check logic ONCE in `health.py`, import it everywhere.

### Problem 3: Namespace Pollution

If all code lives in one space, variable names collide. Your `connect()` function might conflict with someone else's `connect()`.

**Modules solve this:** Each module is a separate **namespace**. `network.connect()` and `database.connect()` coexist peacefully.

### Problem 4: Performance

Loading all possible code at startup wastes memory and time. A script that checks servers doesn't need the email-sending code loaded.

**Modules solve this:** Import only what you need, when you need it.

### The Benefits Summarized

| Benefit | Explanation |
|---------|-------------|
| **Organization** | Logical grouping of related code |
| **Reusability** | Write once, import everywhere |
| **Namespace isolation** | No naming conflicts between modules |
| **Maintainability** | Change one module, others unaffected |
| **Testability** | Test each module independently |
| **Collaboration** | Engineers work on separate modules |
| **Lazy loading** | Only load what you actually use |

---

## 8.3 How Imports Work Internally

### What Happens When You Write `import os`

This is NOT a simple "include the file" operation. Python goes through a multi-step process:

```
┌──────────────────────────────────────────────────────────────┐
│  import os                                                    │
│                                                               │
│  Step 1: Check sys.modules cache                              │
│          → Already imported before? Return cached version.    │
│          → Not found? Continue to Step 2.                     │
│                                                               │
│  Step 2: Search for the module                                │
│          → Check built-in modules (sys, math, etc.)           │
│          → Search sys.path directories (in order)             │
│          → Found? Continue to Step 3.                         │
│          → Not found? Raise ImportError                       │
│                                                               │
│  Step 3: Create a new module object                           │
│          → Allocate a module namespace (dict)                 │
│                                                               │
│  Step 4: Execute the module's code                            │
│          → Run the .py file top to bottom                     │
│          → All def, class, assignments populate the namespace │
│                                                               │
│  Step 5: Cache the module in sys.modules                      │
│          → Next import of same module returns the cache       │
│                                                               │
│  Step 6: Bind the name in the caller's namespace              │
│          → Now you can use os.path, os.getcwd(), etc.         │
└──────────────────────────────────────────────────────────────┘
```

### Key Insight: Module Code Runs Only ONCE

```python
# utils.py
print("utils.py is being loaded!")    # This print runs when imported

def helper():
    return "I help"
```

```python
# main.py
import utils    # Prints: "utils.py is being loaded!"
import utils    # Nothing prints! Already cached in sys.modules
import utils    # Still nothing — same cached module
```

No matter how many times you `import utils`, the code inside runs only on the FIRST import. Subsequent imports return the cached version from `sys.modules`.

### Viewing the Cache

```python
import sys
print(list(sys.modules.keys())[:10])
# Shows all currently imported modules
```

### Bytecode Compilation (.pyc Files)

When Python imports a module for the first time, it:
1. Compiles the `.py` source to bytecode
2. Saves it in a `__pycache__/` directory as a `.pyc` file
3. On subsequent imports, uses the `.pyc` if the source hasn't changed (faster startup)

```
my_project/
├── utils.py
├── config.py
└── __pycache__/
    ├── utils.cpython-311.pyc
    └── config.cpython-311.pyc
```

You don't need to do anything with `__pycache__/` — Python manages it automatically. Add it to `.gitignore`.

---

## 8.4 Import Syntax Variations

### Form 1: `import module`

```python
import os

# Access with module prefix
current_dir = os.getcwd()
files = os.listdir(".")
```

**Pros:** Clear where functions come from; no naming conflicts
**Cons:** More typing (`os.path.join(...)` vs just `join(...)`)

### Form 2: `from module import name`

```python
from os import getcwd, listdir

# Use directly without prefix
current_dir = getcwd()
files = listdir(".")
```

**Pros:** Less typing; cleaner code when using specific functions heavily
**Cons:** Less obvious where functions come from; potential naming conflicts

### Form 3: `from module import name as alias`

```python
from datetime import datetime as dt

now = dt.now()    # Shorter name
```

**Pros:** Shorter names; resolves naming conflicts
**Cons:** Non-standard alias can confuse readers

### Form 4: `import module as alias`

```python
import numpy as np          # Industry standard alias
import pandas as pd         # Industry standard alias
import matplotlib.pyplot as plt    # Standard alias

# Only use widely-recognized aliases!
```

### Form 5: `from module import *` (Wildcard Import)

```python
from os import *    # Imports EVERYTHING from os into your namespace
```

**⚠️ NEVER USE THIS IN PRODUCTION CODE.** Problems:
- You don't know what names were imported
- It pollutes your namespace with hundreds of names
- It can silently override your own variables
- It makes code impossible to understand

```python
# ❌ TERRIBLE — what does "path" refer to now?
from os import *
from pathlib import *
# Both modules have "path" — which one wins? Who knows!

# ✅ EXPLICIT is always better
from pathlib import Path
import os
```

The ONLY acceptable use of `*` is in interactive REPL sessions or very specific `__init__.py` re-exports.

### When to Use Which Form

| Situation | Recommended Form |
|-----------|-----------------|
| Standard library modules | `import os`, `import sys`, `import json` |
| Using many items from a module | `import module` then `module.func()` |
| Using 1-3 specific items | `from module import specific_func` |
| Long module names | `import module as alias` |
| Common industry aliases | `import numpy as np`, `import pandas as pd` |
| Custom project modules | `from myproject.utils import helper_func` |

---

## 8.5 The Module Search Path (sys.path)

### What sys.path Is

`sys.path` is a **list of directories** that Python searches (in order) when you import a module:

```python
import sys
for path in sys.path:
    print(path)
```

**Typical output:**
```
/home/user/project           ← Current script's directory (always first)
/usr/lib/python311.zip       ← Standard library (compressed)
/usr/lib/python3.11          ← Standard library
/usr/lib/python3.11/lib-dynload
/home/user/.local/lib/python3.11/site-packages  ← pip packages (user)
/usr/lib/python3.11/site-packages               ← pip packages (system)
```

### The Search Order

```
1. Built-in modules (sys, math, etc. — compiled into Python)
2. Script's directory (or '' for current directory in REPL)
3. PYTHONPATH environment variable directories
4. Standard library directories
5. site-packages (where pip installs)
```

### Why This Matters

If you create a file called `random.py` in your project directory, it will **shadow** (override) Python's built-in `random` module! Your script's directory is searched FIRST.

```
my_project/
├── random.py        ← ⚠️ This shadows Python's built-in random module!
└── main.py          ← import random → imports YOUR random.py, not Python's!
```

**Common mistake:** Naming your files after standard library modules:
- Don't create: `os.py`, `sys.py`, `json.py`, `math.py`, `email.py`, `random.py`, `test.py`

### Modifying sys.path (When Needed)

```python
import sys

# Add a directory to search path (at runtime)
sys.path.insert(0, "/opt/mycompany/shared-libs")

# Now you can import from that directory
import company_utils
```

**Production alternative:** Use `PYTHONPATH` environment variable:
```bash
export PYTHONPATH="/opt/mycompany/shared-libs:$PYTHONPATH"
python3 my_script.py
```

Or better yet — install your shared code as a proper package (covered later).

---

## 8.6 Creating Your Own Modules

### It's Just a .py File

Any Python file is automatically a module:

```python
# server_utils.py — This is now a module!

"""Utility functions for server management."""

DEFAULT_PORT = 8080
DEFAULT_TIMEOUT = 30

def check_health(hostname, port=DEFAULT_PORT):
    """Check if a server is healthy."""
    print(f"Checking {hostname}:{port}...")
    # In reality, you'd make an HTTP request
    return {"hostname": hostname, "status": "healthy"}

def restart_server(hostname):
    """Restart a server."""
    print(f"Restarting {hostname}...")
    return True

def get_server_info(hostname):
    """Get detailed server information."""
    return {
        "hostname": hostname,
        "port": DEFAULT_PORT,
        "uptime": "5 days"
    }
```

### Using Your Module

```python
# main.py (in the same directory as server_utils.py)

import server_utils

# Access functions with module prefix
result = server_utils.check_health("web-01")
print(result)

# Access module-level constants
print(server_utils.DEFAULT_PORT)    # 8080

# Or import specific items
from server_utils import check_health, restart_server

result = check_health("web-02")
restart_server("db-01")
```

### Module-Level Code

Everything at the top level of a module (not inside a function or class) executes when the module is imported:

```python
# config.py

import os

# These run when you import config
DATABASE_URL = os.environ.get("DATABASE_URL", "localhost:5432")
DEBUG = os.environ.get("DEBUG", "false").lower() == "true"

print(f"Config loaded: DEBUG={DEBUG}")    # Runs on import!

def get_setting(key):
    return os.environ.get(key)
```

```python
# main.py
import config    # Prints: "Config loaded: DEBUG=False"
```

This is useful for initialization (reading environment variables, setting up defaults), but be careful — **side effects on import (like printing, making API calls) should be avoided**.

---

## 8.7 The if \_\_name\_\_ == "\_\_main\_\_" Pattern

### The Most Important Pattern in Python Modules

This pattern is so fundamental that you'll see it in virtually every production Python file. Understanding it deeply is essential.

### What \_\_name\_\_ Is

Every Python module has a built-in variable called `__name__`:
- If the file is run directly: `__name__` = `"__main__"`
- If the file is imported: `__name__` = the module's name (filename without `.py`)

```python
# my_module.py
print(f"__name__ = {__name__}")
```

```bash
# Running directly
$ python3 my_module.py
__name__ = __main__

# Importing in another file
>>> import my_module
__name__ = my_module
```

### The Problem It Solves

```python
# deploy.py — WITHOUT the pattern

def deploy(service, env):
    print(f"Deploying {service} to {env}")

def validate(config):
    print(f"Validating {config}")

# Test code at the bottom
deploy("api", "staging")    # This runs EVERY TIME the file is imported!
```

If another file does `import deploy`, the test code at the bottom runs — which you don't want.

### The Solution

```python
# deploy.py — WITH the pattern

def deploy(service, env):
    print(f"Deploying {service} to {env}")

def validate(config):
    print(f"Validating {config}")

if __name__ == "__main__":
    # This block ONLY runs when executing this file directly
    # It does NOT run when the file is imported
    print("Running deploy.py directly!")
    deploy("api", "staging")
    validate({"replicas": 3})
```

Now:
```bash
# Running directly — test code executes
$ python3 deploy.py
Running deploy.py directly!
Deploying api to staging
Validating {'replicas': 3}

# Importing — test code does NOT execute
>>> import deploy
>>> deploy.deploy("web", "production")
Deploying web to production
```

### Why Every Python File Should Have This

```python
# server_health.py

import requests

def check_health(hostname, port=8080, timeout=5):
    """Check server health via HTTP."""
    try:
        url = f"http://{hostname}:{port}/health"
        response = requests.get(url, timeout=timeout)
        return response.status_code == 200
    except requests.RequestException:
        return False

def check_multiple(servers):
    """Check health of multiple servers."""
    results = {}
    for server in servers:
        results[server] = check_health(server)
    return results

# This pattern enables:
# 1. Direct execution as a standalone script
# 2. Safe importing by other modules
# 3. A natural place for testing/demo code
if __name__ == "__main__":
    # Demo/test when run directly
    servers = ["web-01", "web-02", "db-01"]
    results = check_multiple(servers)
    
    for server, healthy in results.items():
        status = "✅" if healthy else "❌"
        print(f"  {status} {server}")
```

### Common Pattern: CLI Entry Point

```python
# main.py
import sys
from deploy import deploy
from config import load_config

def main():
    """Main entry point for the CLI tool."""
    if len(sys.argv) < 3:
        print("Usage: python main.py <service> <environment>")
        sys.exit(1)
    
    service = sys.argv[1]
    environment = sys.argv[2]
    
    config = load_config(environment)
    deploy(service, config)

if __name__ == "__main__":
    main()
```

---

## 8.8 Packages — Organizing Modules

### What Is a Package?

A package is a **directory containing related modules** plus a special `__init__.py` file. It's how you organize larger projects:

```
# Module = a single .py file
# Package = a directory containing modules (and possibly sub-packages)
```

### Real-Life Analogy

If modules are individual toolboxes, packages are **workshop rooms**:
- The "Electrical Room" (package) contains the Wire Toolbox, the Meter Toolbox, etc.
- The "Plumbing Room" (package) contains the Pipe Toolbox, the Valve Toolbox, etc.
- The whole "Workshop Building" (top-level package) contains all rooms.

### Package Structure

```
infra_tools/                ← Package (directory)
├── __init__.py             ← Makes it a package (can be empty)
├── servers.py              ← Module
├── networking.py           ← Module
├── monitoring/             ← Sub-package
│   ├── __init__.py         ← Makes sub-package
│   ├── alerts.py           ← Module
│   └── metrics.py          ← Module
└── deployment/             ← Sub-package
    ├── __init__.py
    ├── kubernetes.py       ← Module
    └── docker.py           ← Module
```

### Using Packages

```python
# Import a module from a package
import infra_tools.servers
infra_tools.servers.check_health("web-01")

# Import a specific function from a module in a package
from infra_tools.servers import check_health
check_health("web-01")

# Import a module from a sub-package
from infra_tools.monitoring import alerts
alerts.send_alert("CPU high!")

# Import a specific function from a sub-package module
from infra_tools.deployment.kubernetes import deploy_pod
deploy_pod("my-service", replicas=3)
```

### The Dot Notation

The dots represent directory hierarchy:
```
from infra_tools.monitoring.alerts import send_alert
       │              │         │           │
       │              │         │           └── function name
       │              │         └── module (alerts.py)
       │              └── sub-package (monitoring/)
       └── top-level package (infra_tools/)
```

---

## 8.9 The \_\_init\_\_.py File

### What It Does

`__init__.py` serves multiple purposes:

1. **Marks a directory as a Python package** (required in Python < 3.3; optional in 3.3+ for "namespace packages")
2. **Runs initialization code** when the package is first imported
3. **Controls what's exported** with `__all__`
4. **Provides a convenient interface** by re-exporting from submodules

### Empty \_\_init\_\_.py (Simplest Case)

```python
# infra_tools/__init__.py
# Empty file — just marks the directory as a package
```

This is perfectly valid and common. It just makes `import infra_tools` possible.

### \_\_init\_\_.py with Re-exports (Convenience Interface)

```python
# infra_tools/__init__.py

"""Infrastructure tools for server management."""

from infra_tools.servers import check_health, restart_server
from infra_tools.networking import ping_host
from infra_tools.monitoring.alerts import send_alert

__version__ = "1.0.0"
```

Now users can import directly from the package:
```python
# Without the re-exports (verbose):
from infra_tools.servers import check_health
from infra_tools.monitoring.alerts import send_alert

# With the re-exports (convenient):
from infra_tools import check_health, send_alert
```

### \_\_all\_\_ — Controlling Wildcard Imports

`__all__` is a list that defines what gets exported when someone does `from module import *`:

```python
# infra_tools/__init__.py

__all__ = [
    "check_health",
    "restart_server",
    "send_alert",
]

from infra_tools.servers import check_health, restart_server
from infra_tools.monitoring.alerts import send_alert
```

```python
# This now imports only what's in __all__
from infra_tools import *
# Gets: check_health, restart_server, send_alert
# Does NOT import internal helpers, constants, etc.
```

### \_\_init\_\_.py with Initialization Logic

```python
# infra_tools/__init__.py

import logging

# Package-level initialization
logger = logging.getLogger("infra_tools")
logger.setLevel(logging.INFO)

# Version info
__version__ = "2.1.0"
__author__ = "Platform Team"

# Validate environment on import
import os
if not os.environ.get("INFRA_CONFIG_PATH"):
    logger.warning("INFRA_CONFIG_PATH not set — using defaults")
```

### When to Use \_\_init\_\_.py

| Scenario | What to Put |
|----------|-------------|
| Simple project | Empty file or nothing (Python 3.3+) |
| Library with clean API | Re-exports of main functions |
| Package with version info | `__version__`, `__author__` |
| Package needing setup | Initialization logic (logging config, etc.) |
| Large package | `__all__` to control public API |

---

## 8.10 Absolute vs Relative Imports

### Absolute Imports

Specify the full path from the project root:

```python
# Always starts from the top-level package
from infra_tools.servers import check_health
from infra_tools.monitoring.alerts import send_alert
import infra_tools.deployment.kubernetes
```

**Pros:** Clear, unambiguous, works everywhere
**Cons:** Can be verbose for deeply nested packages

### Relative Imports

Use dots to reference relative to the current module's position:

```python
# Inside infra_tools/monitoring/alerts.py

from . import metrics              # Same package: infra_tools/monitoring/metrics.py
from .metrics import collect_cpu   # Specific function from sibling module
from .. import servers             # Parent package: infra_tools/servers.py
from ..servers import check_health # Function from parent package's module
from ..deployment import kubernetes # Sibling sub-package's module
```

**Dot notation:**
- `.` = current package (same directory)
- `..` = parent package (one level up)
- `...` = grandparent package (two levels up)

### Visualizing Relative Imports

```
infra_tools/
├── __init__.py
├── servers.py                    ← from .. import servers (from alerts.py)
├── monitoring/
│   ├── __init__.py
│   ├── alerts.py                 ← WE ARE HERE
│   └── metrics.py                ← from . import metrics (from alerts.py)
└── deployment/
    ├── __init__.py
    └── kubernetes.py             ← from ..deployment import kubernetes
```

### When to Use Which

| Rule | Recommendation |
|------|---------------|
| **PEP 8 recommends** | Absolute imports for most cases |
| **Relative imports** | Within the same package for tightly-coupled modules |
| **Scripts (run directly)** | MUST use absolute imports (relative won't work) |
| **Library/package code** | Either works; be consistent |

### Common Mistake: Relative Imports in Scripts

```python
# ❌ This FAILS if you run: python3 infra_tools/monitoring/alerts.py
from . import metrics    # ImportError: attempted relative import with no known parent package
```

Relative imports only work when the file is part of a package being imported — NOT when run directly as a script. If you run `python3 alerts.py` directly, Python doesn't know about the package structure.

**Solution:** Run from the project root with `-m` flag:
```bash
python3 -m infra_tools.monitoring.alerts
```

---

## 8.11 Standard Library Highlights for DevOps

### The Most Important Built-in Modules

Python's standard library is massive (200+ modules). Here are the ones DevOps engineers use constantly:

### System and OS Interaction

```python
import os          # Environment variables, process management, file operations
import sys         # Interpreter info, argv, path, exit
import platform    # OS type, version, architecture
import subprocess  # Run shell commands from Python
import shutil      # High-level file operations (copy, move, delete)
import pathlib     # Object-oriented file path handling
```

### Data Formats

```python
import json        # JSON parsing and generation
import csv         # CSV reading and writing
import configparser # INI file handling
import xml.etree.ElementTree  # XML parsing
# yaml requires: pip install pyyaml
```

### Networking and Web

```python
import socket      # Low-level networking (TCP/UDP)
import http.client # HTTP connections
import urllib.request  # URL fetching
import urllib.parse    # URL parsing
# requests requires: pip install requests (preferred over urllib)
```

### Date and Time

```python
import datetime    # Dates, times, timestamps
import time        # Sleep, time measurement, epoch time
import calendar    # Calendar operations
```

### Text Processing

```python
import re          # Regular expressions
import string      # String constants and templates
import textwrap    # Text formatting
```

### Concurrency

```python
import threading       # Thread-based parallelism
import multiprocessing # Process-based parallelism
import asyncio         # Async I/O (modern concurrent programming)
import concurrent.futures  # High-level parallel execution
```

### Data and Collections

```python
import collections     # Counter, defaultdict, namedtuple, deque
import itertools       # Combinatoric iterators (chain, product, permutations)
import functools       # Higher-order functions (partial, lru_cache, wraps)
import typing          # Type hint support
import dataclasses     # Data container classes
```

### System Administration

```python
import logging         # Structured logging
import argparse        # Command-line argument parsing
import tempfile        # Temporary files and directories
import signal          # Signal handling (SIGTERM, SIGINT)
import atexit          # Exit handlers
```

### Quick Demo: Key Modules in Action

```python
import os
import sys
import platform
import datetime

# System info (useful for scripts that log their environment)
print(f"Python: {sys.version}")
print(f"OS: {platform.system()} {platform.release()}")
print(f"User: {os.environ.get('USER', 'unknown')}")
print(f"CWD: {os.getcwd()}")
print(f"Time: {datetime.datetime.now().isoformat()}")
print(f"Args: {sys.argv}")
```

---

## 8.12 Third-Party Packages

### What They Are

Packages created by the community, installed via `pip`, and available on [PyPI](https://pypi.org) (Python Package Index — 400,000+ packages).

### Essential DevOps Third-Party Packages

| Package | Purpose | Install |
|---------|---------|---------|
| `requests` | HTTP requests (API calls) | `pip install requests` |
| `boto3` | AWS SDK | `pip install boto3` |
| `pyyaml` | YAML parsing | `pip install pyyaml` |
| `paramiko` | SSH connections | `pip install paramiko` |
| `docker` | Docker API | `pip install docker` |
| `kubernetes` | Kubernetes API | `pip install kubernetes` |
| `flask` | Web APIs/webhooks | `pip install flask` |
| `click` | CLI tools | `pip install click` |
| `rich` | Beautiful terminal output | `pip install rich` |
| `jinja2` | Template rendering | `pip install jinja2` |
| `pytest` | Testing framework | `pip install pytest` |
| `python-dotenv` | .env file loading | `pip install python-dotenv` |

### Installing and Using

```bash
# Install
pip install requests boto3 pyyaml

# Install specific version
pip install requests==2.31.0

# Install from requirements.txt
pip install -r requirements.txt
```

```python
import requests
import boto3
import yaml

# Now you can use them
response = requests.get("https://api.github.com")
print(response.status_code)
```

### Checking What's Installed

```python
import pkg_resources

# List all installed packages
for pkg in pkg_resources.working_set:
    print(f"{pkg.key} == {pkg.version}")
```

Or from command line:
```bash
pip list
pip show requests    # Details about one package
```

---

## 8.13 Import Best Practices and PEP 8

### Import Ordering (PEP 8)

PEP 8 specifies imports should be grouped in this order, separated by blank lines:

```python
# 1. Standard library imports
import os
import sys
import json
from pathlib import Path
from datetime import datetime

# 2. Third-party imports
import requests
import boto3
import yaml
from jinja2 import Template

# 3. Local application/project imports
from myproject.config import load_config
from myproject.utils import format_output
from myproject.health import check_server
```

### Additional Rules

```python
# ✅ One import per line (for standard imports)
import os
import sys
import json

# ✅ Multiple names from same module on one line is OK
from os.path import join, exists, dirname

# ❌ Multiple module imports on one line
import os, sys, json    # Bad style

# ✅ Alphabetical within each group (helps readability)
import csv
import json
import os
import sys

# ✅ Imports at the TOP of the file (after docstring/comments)
"""Module docstring."""

import os    # Imports go here, at the very top
import sys

# Not scattered throughout the file!
```

### When Imports at Top Are Inappropriate

There are rare valid cases for imports NOT at the top:

```python
# 1. Conditional import (optional dependency)
try:
    import ujson as json    # Faster JSON if available
except ImportError:
    import json            # Fallback to standard library

# 2. Import inside function (very rare — avoid if possible)
def heavy_processing():
    import pandas as pd    # Only import if this function is called
    # pandas is huge — no point loading it if never used
    return pd.read_csv("data.csv")

# 3. Avoiding circular imports (last resort — usually indicates design problem)
def get_server():
    from myproject.servers import Server    # Delayed import
    return Server()
```

### Tools That Enforce Import Order

- **isort** — Automatically sorts imports (`pip install isort`)
- **flake8** — Linting (catches unused imports, wrong order)
- **pylint** — More comprehensive linting

```bash
# Auto-sort imports in a file
isort my_module.py

# Check all files in a project
isort --check-only .
```

---

## 8.14 Circular Imports — The Problem and Solutions

### What Is a Circular Import?

Two modules that import each other:

```python
# server.py
from config import get_db_url    # Imports config

def connect():
    url = get_db_url()
    return f"Connected to {url}"
```

```python
# config.py
from server import connect    # Imports server — CIRCULAR!

def get_db_url():
    return "localhost:5432"

def test_connection():
    return connect()
```

When Python tries to import `server`, it needs `config`. When it tries to load `config`, it needs `server` — which isn't fully loaded yet. This causes `ImportError` or `AttributeError`.

### Why It Happens

Circular imports usually indicate a **design problem** — the modules are too tightly coupled.

### Solutions

**Solution 1: Restructure (BEST)**

Move shared code into a third module that both can import:

```python
# shared.py — contains things both need
def get_db_url():
    return "localhost:5432"
```

```python
# server.py
from shared import get_db_url

def connect():
    return f"Connected to {get_db_url()}"
```

```python
# config.py
from shared import get_db_url
from server import connect

def test_connection():
    return connect()
```

**Solution 2: Import inside function (delayed import)**

```python
# config.py
def test_connection():
    from server import connect    # Import only when needed
    return connect()
```

**Solution 3: Import at the bottom of the file**

```python
# server.py
def connect():
    url = get_db_url()
    return f"Connected to {url}"

# Import at bottom (after all definitions exist)
from config import get_db_url
```

### Best Practice

> If you encounter a circular import, the correct solution 90% of the time is to **restructure your code** — move shared utilities into a separate module. Circular dependencies are a code smell indicating poor module boundaries.

---

## 8.15 Project Structure for DevOps Tools

### Small Script (Single File)

```
server_health_check.py
requirements.txt
README.md
```

### Medium Project (Few Modules)

```
my-devops-tool/
├── README.md
├── requirements.txt
├── .gitignore
├── main.py              ← Entry point
├── config.py            ← Configuration loading
├── health.py            ← Health check logic
├── notifications.py     ← Alert/notification logic
└── utils.py             ← Shared utilities
```

### Large Project (Package Structure) ⭐

```
infra-automation/
├── README.md
├── requirements.txt
├── setup.py                   ← Package installation config
├── pyproject.toml             ← Modern package config (PEP 517)
├── .gitignore
├── .env.example               ← Example environment variables
├── Makefile                   ← Common commands
├── Dockerfile                 ← Container build
│
├── src/                       ← Source code root
│   └── infra_automation/      ← Main package
│       ├── __init__.py
│       ├── __main__.py        ← python -m infra_automation
│       ├── cli.py             ← Command-line interface
│       ├── config.py          ← Configuration management
│       │
│       ├── servers/           ← Sub-package: server management
│       │   ├── __init__.py
│       │   ├── health.py
│       │   ├── provisioning.py
│       │   └── inventory.py
│       │
│       ├── deployment/        ← Sub-package: deployment
│       │   ├── __init__.py
│       │   ├── kubernetes.py
│       │   ├── docker.py
│       │   └── rollback.py
│       │
│       ├── monitoring/        ← Sub-package: monitoring
│       │   ├── __init__.py
│       │   ├── metrics.py
│       │   └── alerts.py
│       │
│       └── utils/             ← Sub-package: shared utilities
│           ├── __init__.py
│           ├── logging.py
│           ├── retry.py
│           └── validation.py
│
├── tests/                     ← Test suite
│   ├── __init__.py
│   ├── conftest.py            ← Shared test fixtures
│   ├── test_health.py
│   ├── test_deployment.py
│   └── test_config.py
│
├── scripts/                   ← Standalone operational scripts
│   ├── migrate_db.py
│   └── cleanup_old_images.py
│
└── docs/                      ← Documentation
    ├── getting-started.md
    └── architecture.md
```

### The \_\_main\_\_.py File

Allows running a package as a script with `python -m package_name`:

```python
# src/infra_automation/__main__.py

"""Entry point when running: python -m infra_automation"""

from infra_automation.cli import main

if __name__ == "__main__":
    main()
```

```bash
# Now you can run:
python -m infra_automation --help
```

### The Makefile (Common DevOps Practice)

```makefile
# Makefile

.PHONY: install test lint run clean

install:
	pip install -r requirements.txt
	pip install -e .

test:
	pytest tests/ -v

lint:
	flake8 src/
	isort --check-only src/

run:
	python -m infra_automation

clean:
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
```

---

## 8.16 Distributing Your Package

### Why Package Distribution Matters

You've built an awesome automation tool. Your team needs to use it. Options:
1. ❌ Copy-paste the files (fragile, version chaos)
2. ❌ Clone the repo and add to PYTHONPATH (works but manual)
3. ✅ Install as a proper package with `pip`

### pyproject.toml (Modern Standard)

```toml
# pyproject.toml

[build-system]
requires = ["setuptools>=68.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "infra-automation"
version = "1.0.0"
description = "Infrastructure automation toolkit"
readme = "README.md"
requires-python = ">=3.9"
authors = [
    {name = "Platform Team", email = "platform@company.com"}
]
dependencies = [
    "requests>=2.28.0",
    "boto3>=1.26.0",
    "pyyaml>=6.0",
    "click>=8.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "flake8>=6.0",
    "isort>=5.12",
]

[project.scripts]
infra = "infra_automation.cli:main"
```

### Installing in Development Mode

```bash
# Install your own package in "editable" mode
# Changes to source are immediately reflected without reinstalling
pip install -e .

# Now you can import from anywhere:
# from infra_automation.servers.health import check_health
```

### Installing for Team Members

```bash
# Install directly from GitHub
pip install git+https://github.com/company/infra-automation.git

# Or from a private PyPI server
pip install --index-url https://pypi.company.com/simple/ infra-automation
```

---

## 8.17 Common DevOps Module Patterns

### Pattern 1: Configuration Module

```python
# config.py

"""
Centralized configuration management.
Loads from environment variables with fallbacks to defaults.
"""

import os
from pathlib import Path

# Application settings
APP_NAME = os.environ.get("APP_NAME", "infra-tool")
APP_VERSION = "2.1.0"
DEBUG = os.environ.get("DEBUG", "false").lower() == "true"

# Server settings
DEFAULT_PORT = int(os.environ.get("PORT", "8080"))
DEFAULT_TIMEOUT = int(os.environ.get("TIMEOUT", "30"))
MAX_RETRIES = int(os.environ.get("MAX_RETRIES", "3"))

# Paths
BASE_DIR = Path(__file__).parent.parent
LOG_DIR = Path(os.environ.get("LOG_DIR", "/var/log/infra-tool"))
CONFIG_DIR = Path(os.environ.get("CONFIG_DIR", "/etc/infra-tool"))

# AWS settings
AWS_REGION = os.environ.get("AWS_REGION", "us-east-1")
AWS_PROFILE = os.environ.get("AWS_PROFILE", "default")

# Logging
LOG_LEVEL = os.environ.get("LOG_LEVEL", "DEBUG" if DEBUG else "INFO")
LOG_FORMAT = "%(asctime)s [%(levelname)s] %(name)s: %(message)s"


def get_env_or_fail(key):
    """Get a required environment variable or raise an error."""
    value = os.environ.get(key)
    if value is None:
        raise EnvironmentError(f"Required environment variable not set: {key}")
    return value
```

### Pattern 2: Utility Module with Retry Logic

```python
# utils/retry.py

"""Reusable retry decorator and utility functions."""

import time
import functools
import logging

logger = logging.getLogger(__name__)


def retry(max_attempts=3, delay=1, backoff=2, exceptions=(Exception,)):
    """
    Decorator that retries a function on failure.
    
    Args:
        max_attempts: Maximum number of attempts
        delay: Initial delay between retries (seconds)
        backoff: Multiply delay by this after each retry
        exceptions: Tuple of exception types to retry on
    """
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            current_delay = delay
            last_exception = None
            
            for attempt in range(1, max_attempts + 1):
                try:
                    return func(*args, **kwargs)
                except exceptions as e:
                    last_exception = e
                    if attempt == max_attempts:
                        logger.error(
                            f"{func.__name__} failed after {max_attempts} attempts: {e}"
                        )
                        raise
                    logger.warning(
                        f"{func.__name__} attempt {attempt}/{max_attempts} failed: {e}. "
                        f"Retrying in {current_delay}s..."
                    )
                    time.sleep(current_delay)
                    current_delay *= backoff
            
            raise last_exception
        return wrapper
    return decorator


# Usage:
# from utils.retry import retry
#
# @retry(max_attempts=5, delay=2, exceptions=(ConnectionError, TimeoutError))
# def fetch_data(url):
#     response = requests.get(url)
#     response.raise_for_status()
#     return response.json()
```

### Pattern 3: Health Check Module

```python
# servers/health.py

"""Server health check utilities."""

import logging
from typing import Dict, List, Optional

logger = logging.getLogger(__name__)


class HealthCheckResult:
    """Represents the result of a health check."""
    
    def __init__(self, hostname: str, healthy: bool, 
                 response_time_ms: float = 0, error: Optional[str] = None):
        self.hostname = hostname
        self.healthy = healthy
        self.response_time_ms = response_time_ms
        self.error = error
    
    def __repr__(self):
        status = "✅" if self.healthy else "❌"
        return f"{status} {self.hostname} ({self.response_time_ms:.1f}ms)"


def check_single(hostname: str, port: int = 80, timeout: int = 5) -> HealthCheckResult:
    """Check health of a single server."""
    import time
    
    start = time.time()
    try:
        import requests
        url = f"http://{hostname}:{port}/health"
        response = requests.get(url, timeout=timeout)
        elapsed_ms = (time.time() - start) * 1000
        
        healthy = response.status_code == 200
        return HealthCheckResult(hostname, healthy, elapsed_ms)
    
    except Exception as e:
        elapsed_ms = (time.time() - start) * 1000
        logger.warning(f"Health check failed for {hostname}: {e}")
        return HealthCheckResult(hostname, False, elapsed_ms, str(e))


def check_multiple(servers: List[str], port: int = 80) -> Dict[str, HealthCheckResult]:
    """Check health of multiple servers."""
    results = {}
    for server in servers:
        results[server] = check_single(server, port)
        logger.info(f"  {results[server]}")
    return results


def get_summary(results: Dict[str, HealthCheckResult]) -> dict:
    """Generate a summary of health check results."""
    total = len(results)
    healthy = sum(1 for r in results.values() if r.healthy)
    unhealthy = total - healthy
    
    return {
        "total": total,
        "healthy": healthy,
        "unhealthy": unhealthy,
        "health_percentage": (healthy / total * 100) if total > 0 else 0,
        "unhealthy_servers": [
            r.hostname for r in results.values() if not r.healthy
        ]
    }


if __name__ == "__main__":
    # Demo/testing when run directly
    servers = ["web-01", "web-02", "web-03", "db-01"]
    print("Running health checks...")
    results = check_multiple(servers)
    summary = get_summary(results)
    print(f"\nSummary: {summary['healthy']}/{summary['total']} healthy")
    if summary['unhealthy_servers']:
        print(f"⚠️  Unhealthy: {summary['unhealthy_servers']}")
```

---

## 8.18 Section Summary and Review

### What You Learned

| Topic | Key Takeaway |
|-------|-------------|
| Modules | Any .py file is a module; enables code reuse and organization |
| Import internals | Check cache → search path → execute once → cache → bind name |
| Import forms | `import x`, `from x import y`, `import x as z` |
| sys.path | Ordered list of directories Python searches for modules |
| Creating modules | Write functions in a .py file; import it from another file |
| `__name__` pattern | `if __name__ == "__main__":` separates script code from importable code |
| Packages | Directories with `__init__.py` containing related modules |
| `__init__.py` | Marks package; can re-export, control `__all__`, run init code |
| Absolute imports | Full path from project root (recommended by PEP 8) |
| Relative imports | Dots for relative position; only work within packages |
| Standard library | 200+ built-in modules; know the key ones for DevOps |
| Third-party | pip install from PyPI; essential DevOps packages |
| Import ordering | stdlib → third-party → local (PEP 8) |
| Circular imports | Design smell; fix by restructuring into a third module |
| Project structure | Scale from single file → package → distributable library |

### Production Scenario Recap

> A team builds an infrastructure automation toolkit:
> - **Structured** as a proper Python package (`src/infra_automation/`)
> - **Sub-packages** for logical grouping (servers, deployment, monitoring)
> - **`__init__.py`** provides clean public API with re-exports
> - **Config module** loads from environment variables with defaults
> - **Utility modules** provide retry logic, logging setup, validation
> - **`if __name__ == "__main__"`** in each module allows standalone testing
> - **`pyproject.toml`** enables `pip install` for the team
> - **Tests directory** mirrors the source structure
> - **Makefile** provides common commands (install, test, lint, run)

### Common Interview Questions

1. **Q: What is the difference between a module and a package?**
   A: A module is a single `.py` file. A package is a directory containing multiple modules and an `__init__.py` file (or a namespace package in Python 3.3+).

2. **Q: What does `if __name__ == "__main__"` do?**
   A: It guards code that should only run when the file is executed directly (not when imported). `__name__` equals `"__main__"` only for the file being run directly.

3. **Q: How does Python find modules when you import them?**
   A: Python searches directories listed in `sys.path` in order: current directory, PYTHONPATH, standard library, site-packages. It also checks `sys.modules` cache first.

4. **Q: Why shouldn't you use `from module import *`?**
   A: It pollutes the namespace with unknown names, can silently override existing variables, makes code hard to understand (where did this function come from?), and prevents tools from detecting unused imports.

5. **Q: What are circular imports and how do you fix them?**
   A: When module A imports module B and module B imports module A. Fix by restructuring: move shared code to a third module, or use delayed imports inside functions.

6. **Q: What is `__init__.py` for?**
   A: It marks a directory as a Python package, runs initialization code when the package is imported, and can re-export symbols for a cleaner public API.

### Practice Exercises

1. Create a module `math_utils.py` with functions `circle_area(radius)` and `rectangle_area(w, h)`. Import and use them from `main.py`.
2. Add the `if __name__ == "__main__"` pattern to your module with test cases.
3. Create a package `devops_kit/` with sub-modules: `servers.py`, `alerts.py`, `config.py`. Write an `__init__.py` that re-exports key functions.
4. Write a `config.py` module that reads 5 environment variables with defaults.
5. Deliberately create a file named `json.py` in your project directory and observe the import shadowing problem. Then fix it.
6. Create a project with the "Large Project" structure and verify imports work.
7. Install your package in editable mode (`pip install -e .`) and import it from anywhere.

### Beginner Quiz (10 Questions)

1. What makes a directory into a Python package?
2. What is `sys.path`?
3. What happens if you name your file `os.py` in your project?
4. How many times does a module's code execute when imported multiple times?
5. What is the purpose of `__all__` in `__init__.py`?
6. What does a single dot `.` mean in `from . import utils`?
7. Where should imports appear in a Python file?
8. What does `pip install -e .` do?
9. What's wrong with `from os import *`?
10. In PEP 8 import ordering, which comes first: third-party or standard library?

<details>
<summary>Quiz Answers</summary>

1. An `__init__.py` file (can be empty). In Python 3.3+, "namespace packages" don't require it, but explicit is better.
2. A list of directories Python searches when importing modules, checked in order.
3. It shadows Python's built-in `os` module — your `os.py` is imported instead, causing failures.
4. Once. Subsequent imports return the cached version from `sys.modules`.
5. It defines which names are exported when someone does `from package import *`.
6. "Current package" — import from the same directory/package level.
7. At the very top of the file, after the module docstring and comments.
8. Installs the package in "editable" (development) mode — changes to source code are immediately reflected without reinstalling.
9. It imports ALL names from `os` into your namespace — polluting it with hundreds of names, potential conflicts, and making code unclear.
10. Standard library comes first, then third-party, then local/project imports.

</details>

### Next Section Preview

**Section 9: Object-Oriented Programming (OOP) — Classes, Objects, and Inheritance**

You will learn what OOP is, why it exists, how Python implements classes and objects, the `self` parameter, `__init__`, instance vs class variables, methods, inheritance, polymorphism, encapsulation, dunder methods, and how OOP is used in DevOps for building server managers, deployment pipelines, cloud resource wrappers, and configuration classes.

---

*Ready for Section 9? Let me know and I'll generate it.*
