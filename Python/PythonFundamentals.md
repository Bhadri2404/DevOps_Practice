# 📘 Python Fundamentals Complete Handbook
### A Beginner-Friendly, Interview-Oriented, and Practical Learning Guide

> **Source Repository:** [lm-academy/python-devops](https://github.com/lm-academy/python-devops)  
> **Python Version Used:** 3.13.x  
> **Style:** Simple, professional, teaching-oriented

---

## 📑 Table of Contents

1. [Environment Setup & Virtual Environments](#1-environment-setup--virtual-environments)
   - [Installing Python](#11-installing-python)
   - [Checking Python Version](#12-checking-python-version)
   - [IDE Setup (VS Code)](#13-ide-setup-vs-code)
   - [Virtual Environments with venv](#14-virtual-environments-with-venv)
   - [Installing Dependencies with pip](#15-installing-dependencies-with-pip)
   - [Running Python Files](#16-running-python-files)
   - [Common Setup Mistakes](#17-common-setup-mistakes)
2. [Comments](#2-comments)
3. [Variables](#3-variables)
4. [Numbers and Arithmetic](#4-numbers-and-arithmetic)
5. [Strings](#5-strings)
6. [Lists](#6-lists)
7. [Tuples](#7-tuples)
8. [Sets](#8-sets)
9. [Dictionaries](#9-dictionaries)
10. [Conditional Statements (if/elif/else)](#10-conditional-statements)
11. [Loops (for and while)](#11-loops)
12. [Lazy Iteration: range, enumerate, zip](#12-lazy-iteration)
13. [Functions](#13-functions)
14. [Lambda Functions, map(), filter()](#14-lambda-functions-map-filter)
15. [List Comprehensions](#15-list-comprehensions)
16. [*args and **kwargs](#16-args-and-kwargs)
17. [Classes and OOP](#17-classes-and-oop)
18. [Comparison Tables](#18-comparison-tables)
19. [Python Fundamentals Programs for Interviews (30+)](#19-python-fundamentals-programs-for-interviews)

---

## 1. Environment Setup & Virtual Environments

### 1.1 Installing Python

- Download from [python.org](https://www.python.org/downloads/)
- On Linux/macOS, Python 3 is often pre-installed
- On Windows, check "Add Python to PATH" during installation

### 1.2 Checking Python Version

```bash
python3 --version
# Output: Python 3.13.3
```

### 1.3 IDE Setup (VS Code)

1. Download and install [Visual Studio Code](https://code.visualstudio.com/)
2. Install the **Python** extension by Microsoft
3. Open your project folder via `File → Open Folder`
4. Select your Python interpreter (bottom-left status bar)

### 1.4 Virtual Environments with `venv`

#### Why Virtual Environments?

- **Problem:** Installing libraries globally can cause version conflicts ("dependency hell"). Project A may need `boto3==1.20` while Project B needs `boto3==1.34`.
- **Solution:** Virtual environments create isolated directories per project, each containing its own Python interpreter and packages.

#### Creating a Virtual Environment

```bash
# Navigate to your project root, then:
python3 -m venv .venv
```

- `python3 -m venv` → runs the venv module
- `.venv` → conventional directory name for the virtual environment

#### Activating the Virtual Environment

```bash
# On Linux/macOS:
source .venv/bin/activate

# On Windows:
.venv\Scripts\activate
```

- **Indicator:** Your prompt changes to `(.venv)` showing the environment is active.

#### Deactivating

```bash
deactivate
```

> ⚠️ **Warning:** Never use `sudo pip install`. Virtual environments install packages in your user-owned `.venv` directory, eliminating the need for elevated permissions.

### 1.5 Installing Dependencies with pip

```bash
# With virtual environment activated:
pip install boto3
pip install requests

# Install from requirements file:
pip install -r requirements.txt

# Check installed packages:
pip list

# Freeze current packages to file:
pip freeze > requirements.txt
```

### 1.6 Running Python Files

```bash
python3 my_script.py
```

For Jupyter notebooks (`.ipynb` files as in this repository):
```bash
pip install jupyter
jupyter notebook
```

### 1.7 Common Setup Mistakes

| Mistake | Fix |
|---------|-----|
| Forgetting to activate venv | Run `source .venv/bin/activate` before installing packages |
| Using `pip` without venv | Always create and activate venv first |
| Using `sudo pip install` | Never needed with venv |
| Wrong Python version | Use `python3` explicitly, not `python` |
| `.venv` committed to Git | Add `.venv/` to `.gitignore` |

---

## 2. Comments

### What Are Comments?

Comments explain the *intent* and *rationale* behind code. They are ignored by the Python interpreter.

### Single-Line Comments (`#`)

```python
# This is a single-line comment
error_code = 0  # Inline comment explaining the variable

# TODO: handle case when argument is None
```

### Multi-Line / Block Comments

```python
# Block comment - prefix each line with #
# if True:
#     print("I will execute")
```

### Docstrings (`"""..."""`)

```python
def my_function():
    """This is a docstring. It explains the function's purpose."""
    pass
```

> 💡 **Interview Tip:** Comments explain *why*, docstrings explain *what* and *how*. Docstrings are accessible via `help()` and `__doc__`.

---

## 3. Variables

### What Are Variables?

Variables are labels (names) that store data values. They act as references to objects in memory.

### Rules and Conventions

- Must start with a letter or underscore (`_`)
- Can contain letters, numbers, and underscores
- Use `snake_case` for readability (e.g., `max_retries`)
- Case-sensitive: `Name` ≠ `name`

### Dynamic Typing

Python uses dynamic typing — you don't declare variable types explicitly.

```python
# Assigning a string value
var1 = "hello"
print(var1)
# Output: hello

# Checking type
item = 101
print(type(item))
# Output: <class 'int'>

# BAD PRACTICE: Reassigning different type to same variable
item = "Code 101"
print(type(item))
# Output: <class 'str'>
```

> ⚠️ **Best Practice:** Never reassign a variable to a value of a different type. It reduces code readability and causes bugs.

### Common Use Cases

- File paths: `config_path = "/etc/app.conf"`
- Server counts: `max_retries = 5`
- API keys: `api_key = "abc123"`

### Interview Questions

1. **Q:** Is Python statically or dynamically typed?  
   **A:** Dynamically typed — variable types are determined at runtime.

2. **Q:** Can you change the type of a variable?  
   **A:** Yes, Python allows it, but it's bad practice.

---

## 4. Numbers and Arithmetic

### Integer (`int`)

- Whole numbers: `10`, `1024`, `-5`
- **No overflow** — Python supports arbitrary precision integers

### Float (`float`)

- Decimal numbers: `3.14159`, `1.0`
- Uses IEEE 754 representation — small precision issues possible

```python
import math

print(type(1.0))
# Output: <class 'float'>

# Floating-point precision issue
print(0.1 * 3 == 0.3)
# Output: False

# Solution: use math.isclose()
print(math.isclose(0.1 * 3, 0.3))
# Output: True
```

### Arithmetic Operators

| Operator | Description | Example | Result |
|----------|-------------|---------|--------|
| `+` | Addition | `5 + 3` | `8` |
| `-` | Subtraction | `5 - 3` | `2` |
| `*` | Multiplication | `5 * 3` | `15` |
| `/` | True Division (always float) | `8 / 2` | `4.0` |
| `//` | Floor Division | `5 // 3` | `1` |
| `%` | Modulo (remainder) | `5 % 3` | `2` |
| `**` | Power | `2 ** 3` | `8` |

```python
print(8 / 2)       # 4.0 (always float)
print(type(8 / 2)) # <class 'float'>
print(5 / 3)       # 1.6666666666666667
print(8 // 2)      # 4 (integer)
print(type(8 // 2))# <class 'int'>
print(5 // 3)      # 1
print(5 // 3.0)    # 1.0 (float because one operand is float)
print(5 % 3)       # 2 (remainder)
```

> 💡 **Interview Tip:** `/` always returns float. `//` returns int if both operands are int, otherwise float.

---

## 5. Strings

### What Are Strings?

Strings are **ordered, immutable** sequences of characters.

### Creating Strings

```python
single_line_str = "Double quoted"
single_line_str2 = 'Single quoted'

# Triple quotes for multi-line strings
command_template = """
I will not be indented
    I will be indented
"""
print(command_template)
```

### f-Strings (Formatted String Literals)

```python
math_division = 7 / 2
print(f"Result: {math_division}")
# Output: Result: 3.5

print(f"Result: {7/2}")
# Output: Result: 3.5
```

### Essential String Methods

```python
course_title = "     Python for DevOps    "

print(course_title.strip())   # "Python for DevOps"
print(course_title.lstrip())  # "Python for DevOps    "
print(course_title.rstrip())  # "     Python for DevOps"
print(course_title.upper())   # "     PYTHON FOR DEVOPS    "
print(course_title.lower())   # "     python for devops    "
```

### startswith() and endswith()

```python
filename = "file.yaml"
print(filename.startswith("file"))  # True
print(filename.endswith("yaml"))    # True
```

### split() and join()

```python
path = "/usr/local/bin"
path_parts = path.split("/")
print(path_parts)  # ['', 'usr', 'local', 'bin']

print("\\".join(path_parts))  # \usr\local\bin
```

### Indexing and Slicing

```python
path = "/usr/local/bin"
print(len(path))    # 14
print(path[3])      # r
print(path[3:10])   # r/local
print(path[3:])     # r/local/bin
print(path[:10])    # /usr/local
```

### String Immutability

```python
course_title = "     Python for DevOps    "
course_title.strip()  # Returns a NEW string
print(course_title)   # Original is UNCHANGED: "     Python for DevOps    "
```

> ⚠️ **Key Concept:** String methods don't modify the original string — they return a new one.

### Exercise: Disk Usage Percentage

```python
server_name = "webserver-03"
cpu_cores = 4
memory_gb = 8.0
disk_total_gb = 500
disk_used_gb = 350

disk_usage_percentage = disk_used_gb / disk_total_gb
print(disk_usage_percentage)
# Output: 0.7

summary = f"Server '{server_name.upper()}' ({cpu_cores} cores, {memory_gb}GB RAM) Disk usage: {disk_usage_percentage}"
print(summary)
# Output: Server 'WEBSERVER-03' (4 cores, 8.0GB RAM) Disk usage: 0.7

# Using .2% format specifier
summary_formatted = f"Server '{server_name.upper()}' ({cpu_cores} cores, {memory_gb}GB RAM) Disk usage: {disk_usage_percentage:.2%}"
print(summary_formatted)
# Output: Server 'WEBSERVER-03' (4 cores, 8.0GB RAM) Disk usage: 70.00%
```

---

## 6. Lists

### What Are Lists?

Lists are **ordered, mutable** sequences defined with square brackets `[]`.

### Creating and Accessing

```python
servers = ["web01", "web02", "web03"]
mixed_list = ["config.yaml", 8080, True]

# Accessing elements (0-based indexing)
print(servers[0])    # web01
print(servers[-1])   # web03 (last element)
print(servers[-2])   # web02 (second to last)
```

### Slicing

```python
print(servers[:2])   # ['web01', 'web02'] — first two
print(servers[1:])   # ['web02', 'web03'] — from index 1 onwards
print(servers[-2:])  # ['web02', 'web03'] — last two
print(servers)       # ['web01', 'web02', 'web03'] — original unchanged
```

### Mutating Lists

```python
ports = [80, 443, 8080]

# append — adds to end
ports.append(5000)
print(ports)  # [80, 443, 8080, 5000]

# insert — adds at specific index
ports.insert(1, 3000)
print(ports)  # [80, 3000, 443, 8080, 5000]

# remove — removes first occurrence of value
ports.remove(80)
print(ports)  # [3000, 443, 8080, 5000]

# pop — removes and returns element at index
removed_value = ports.pop(2)
print(ports)          # [3000, 443, 5000]
print(removed_value)  # 8080
```

### ⚠️ Side Effects with Mutable Lists

```python
def mutate_list(l):
    l.pop()

new_list = ["a", "b", "c"]
mutate_list(new_list)
print(new_list)  # ['a', 'b'] — original was modified!
```

> **Lesson:** Lists passed to functions are passed by reference. Modifications inside the function affect the original list.

---

## 7. Tuples

### What Are Tuples?

Tuples are **ordered, immutable** sequences defined with parentheses `()`.

```python
host_port = ("127.0.0.1", 3000)
red_rgb = (255, 0, 0)
tuple_single_value = ("only-value",)  # Trailing comma required for single item

print(type(host_port))          # <class 'tuple'>
print(f"Host: {host_port[0]}")  # Host: 127.0.0.1
print(red_rgb[-2:])             # (0, 0)

# host_port[0] = "192.168.1.1"  # TypeError! Tuples are immutable
```

### Use Cases

- Fixed records: coordinates, version numbers
- Dictionary keys (since they're immutable)
- Function return values (returning multiple values)

---

## 8. Sets

### What Are Sets?

Sets are **unordered, mutable** collections with **unique items only**. Items must be immutable.

```python
unique_ports = set([80, 443, 22, 80, 8080, 443])
print(unique_ports)  # {80, 443, 8080, 22} — duplicates removed

server_names = {"web01", "web02"}
```

### Membership Testing

```python
print(22 in unique_ports)      # True
print(22 in server_names)      # False
```

### Adding and Removing

```python
unique_ports.add(3000)       # Add item
unique_ports.remove(22)      # Remove (raises KeyError if missing)
unique_ports.discard(22)     # Remove (no error if missing)
```

### Set Operations

```python
developers = {"alice", "bob", "charlie"}
admins = {"alice", "david"}

print(developers.union(admins))         # {'alice', 'bob', 'charlie', 'david'}
print(developers.intersection(admins))  # {'alice'}
print(developers.difference(admins))    # {'bob', 'charlie'}

# Operator shortcuts:
print(developers | admins)  # Union
print(developers & admins)  # Intersection
print(developers - admins)  # Difference
```

### Sets Can Only Contain Immutable Items

```python
# set_of_lists = {[1, 2], [3, 4]}    # TypeError — lists are mutable
set_of_tuples = {(1, 2), (3, 4)}     # OK — tuples are immutable
```

---

## 9. Dictionaries

### What Are Dictionaries?

Dictionaries are **mutable, insertion-ordered** (Python 3.7+) collections of key-value pairs.

```python
my_dictionary = {'a': 1, 'b': 2, 'c': 3}
```

### Accessing Elements

```python
print(my_dictionary['b'])            # 2 (raises KeyError if missing)
print(my_dictionary.get('b'))        # 2 (returns None if missing)
print(my_dictionary.get('e', -1))    # -1 (custom default)
```

### Keys, Values, Items

```python
print(my_dictionary.keys())    # dict_keys(['a', 'b', 'c'])
print(my_dictionary.values())  # dict_values([1, 2, 3])
print(my_dictionary.items())   # dict_items([('a', 1), ('b', 2), ('c', 3)])

# Iterating
for key, value in my_dictionary.items():
    print(f"- {key}: {value}")
```

### Adding, Updating, Removing

```python
my_dictionary['d'] = 4               # Add new key
my_dictionary.setdefault('e', 5)     # Add only if key doesn't exist
removed = my_dictionary.pop('a')     # Remove and return value
my_dictionary.popitem()              # Remove last inserted item
```

### Merging Dictionaries

```python
default_tags = {"Environment": "Production", "Owner": "Finance", "CostCenter": "10000"}
custom_tags = {"CostCenter": "12345"}

# Python 3.9+ merge operator
merged = default_tags | custom_tags
print(merged)  # {'Environment': 'Production', 'Owner': 'Finance', 'CostCenter': '12345'}

# update() method (modifies in place)
default_tags.update(custom_tags)
```

### fromkeys() and clear()

```python
new_dict = dict.fromkeys(['one', 'two'], 0)
print(new_dict)  # {'one': 0, 'two': 0}

new_dict.clear()
print(new_dict)  # {}
```

---

## 10. Conditional Statements

### if / elif / else

```python
server_status = "running"

if server_status == "running":
    print("Service is active.")
# Output: Service is active.
```

### Comparison and Logical Operators

- Comparison: `==`, `!=`, `<`, `>`, `<=`, `>=`, `in`
- Logical: `and`, `or`, `not`

### Truthiness and Falsiness

| Falsy Values | Truthy Values |
|-------------|---------------|
| `False`, `None` | `True` |
| `0`, `0.0` | Non-zero numbers |
| `""` (empty string) | Non-empty strings |
| `[]`, `{}`, `set()` | Non-empty collections |

```python
servers = ["web01", "web02"]
error_message = ""
default_config = {}

if servers:
    print(f"Processing {len(servers)} servers.")
# Output: Processing 2 servers.

if not default_config:
    print("Default config not available.")
# Output: Default config not available.
```

### elif Chains

```python
http_status = 503

if http_status == 200:
    print("Status OK")
elif http_status == 404:
    print("Resource not found")
elif http_status >= 500:
    print("Server error (5xx)")
else:
    print("Another status:", http_status)
# Output: Server error (5xx)
```

### Guard Clauses

```python
def process_data_guarded(data):
    if not data:
        print("No data provided")
    elif not isinstance(data, list):
        print(f"Invalid type. Provided {type(data)}; Required: list")
    else:
        print(f"Processing {len(data)} items...")

process_data_guarded(None)       # No data provided
process_data_guarded([])         # No data provided
process_data_guarded("abc")      # Invalid type...
process_data_guarded([1, 2, 3])  # Processing 3 items...
```

---

## 11. Loops

### for Loop

```python
servers = ["web01", "web02", "web03"]

for server in servers:
    print("Pinging server:", server)
# Output:
# Pinging server: web01
# Pinging server: web02
# Pinging server: web03

# Iterating over a string
for char in "SUCCESS":
    print(char)

# Using range
for idx in range(10):
    print("Pinging server:", idx)
```

### while Loop

```python
connection_attempts = 0
max_attempts = 5
connected = False

while not connected and connection_attempts < max_attempts:
    print(f"Attempting to reach server: {connection_attempts + 1}")
    if connection_attempts == 3:
        connected = True
    connection_attempts += 1

if not connected:
    print("Failed to connect after maximum attempts.")
# Output:
# Attempting to reach server: 1
# Attempting to reach server: 2
# Attempting to reach server: 3
# Attempting to reach server: 4
```

### break and continue

```python
# break — exit loop early
users = ["guest", "tester", "admin01", "admin02", "dev01"]
for user in users:
    print(f"Checking user: {user}")
    if user.startswith("admin"):
        print(f"Admin user found: {user}. Stopping search.")
        break
# Output:
# Checking user: guest
# Checking user: tester
# Checking user: admin01
# Admin user found: admin01. Stopping search.

# continue — skip current iteration
filenames = ["nginx.conf", "app.yaml", "db.yaml", "notes.txt"]
for file in filenames:
    if not file.endswith(".yaml"):
        print(f"Skipping non-yaml file: {file}")
        continue
    print(f"Processing YAML config: {file}")
```

---

## 12. Lazy Iteration

### range() — Memory Efficient

```python
import sys

numbers_list = list(range(10_000_000))   # ~76 MB in memory
numbers_range = range(10_000_000)        # ~48 bytes in memory!
```

`range()` stores only start, stop, step — generates numbers one at a time.

```python
# range(stop)
for i in range(5):
    print(f"Retry #{i}")

# range(start, stop)
for year in range(2020, 2024):
    print(f"Processing logs for {year}")

# range(start, stop, step)
for server_id in range(10, 30, 5):
    print(f"Checking server {server_id}")
```

### enumerate() — Index + Value

```python
servers = ["web01", "web02", "web03"]

for idx, server in enumerate(servers, 1):
    print(f"#{idx}: Processing server {server}")
# Output:
# #1: Processing server web01
# #2: Processing server web02
# #3: Processing server web03
```

### zip() — Parallel Iteration

```python
hosts = ["hostA", "hostB", "hostC"]
ips = ["10.0.0.1", "10.0.0.2"]
azs = ["us-east-1a", "us-east-1b"]

for host, ip, az in zip(hosts, ips, azs):
    print(f"Host: {host}, IP: {ip}, AZ: {az}")
# Output:
# Host: hostA, IP: 10.0.0.1, AZ: us-east-1a
# Host: hostB, IP: 10.0.0.2, AZ: us-east-1b
# (hostC is skipped — zip stops at shortest iterable)
```

---

## 13. Functions

### Defining Functions

```python
def greet_user(name):
    """Greets the user by name.

    Args:
        name (str): The user to greet
    """
    print(f"Hello, {name}!")

greet_user("Alice")
# Output: Hello, Alice!
```

### Return Values

```python
import random

def random_number(min_val, max_val):
    """Generates an integer between min_val and max_val."""
    return random.randint(min_val, max_val)

result = random_number(0, 10)
print(f"Generated number: {result}")
```

### Positional vs Keyword Arguments

```python
def check_service_status(service_name, expected_status):
    print(f"Checking {service_name} for {expected_status}...")
    return True

# Positional (order matters)
check_service_status("nginx", "running")

# Keyword (order doesn't matter)
check_service_status(expected_status="running", service_name="nginx")

# Positional must come before keyword
# check_service_status(service_name="nginx", "running")  # SyntaxError!
```

### Default Parameter Values

```python
def connect(host, port=22, timeout=30):
    print(f"Connect to host {host} on port {port} (timeout {timeout})")

connect("web01")                  # Uses defaults: port=22, timeout=30
connect("web02", 443, 60)         # Overrides both
connect("web03", timeout=60)      # Overrides only timeout, port stays 22
```

### Docstring Convention

```python
def check_port(host, port, timeout=5):
    """Checks if a TCP port is open on a given host.

    Args:
        host (str): Hostname or IP address.
        port (int): TCP port number.
        timeout (int, optional): Connection timeout in seconds. Defaults to 5.

    Returns:
        bool: True if the port is open, False otherwise.
    """
    import socket
    try:
        with socket.create_connection((host, port), timeout):
            return True
    except Exception:
        return False
```

### Exercise: Fibonacci Sequence

```python
def fibonacci(n):
    """Returns the first n Fibonacci numbers.

    Args:
        n (int): The amount of numbers to calculate.

    Returns:
        list: The first n Fibonacci numbers.
    """
    seq = [0, 1]
    for _ in range(2, n):
        seq.append(seq[-1] + seq[-2])
    return seq[:n]

print(fibonacci(10))
# Output: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]

print(fibonacci(1))
# Output: [0]
```

**Dry Run for `fibonacci(5)`:**
| Iteration | seq before | seq[-1] + seq[-2] | seq after |
|-----------|-----------|-------------------|-----------|
| Start | [0, 1] | — | [0, 1] |
| i=2 | [0, 1] | 1 + 0 = 1 | [0, 1, 1] |
| i=3 | [0, 1, 1] | 1 + 1 = 2 | [0, 1, 1, 2] |
| i=4 | [0, 1, 1, 2] | 2 + 1 = 3 | [0, 1, 1, 2, 3] |

---

## 14. Lambda Functions, map(), filter()

### Lambda Syntax

```python
# lambda arguments: expression
square = lambda x: x * x
print(square(5))  # 25

# Inline usage
print((lambda a, b: a + b)(3, 4))  # 7
```

### Custom Sorting with sorted()

```python
services = [("web-app", 3), ("database", 1), ("cache", 5), ("api-gateway", 2)]

# Sort by replica count (second element)
sorted_services = sorted(services, key=lambda svc: svc[1])
print(sorted_services)
# Output: [('database', 1), ('api-gateway', 2), ('web-app', 3), ('cache', 5)]
```

### map() — Transform Each Item

```python
my_numbers = [1, 2, 3, 4]
doubled = list(map(lambda num: num * 2, my_numbers))
print(doubled)  # [2, 4, 6, 8]

ports = [80, 443, 8080, 22]
descriptions = list(map(lambda port: f"Port {port} is open", ports))
print(descriptions)
# Output: ['Port 80 is open', 'Port 443 is open', 'Port 8080 is open', 'Port 22 is open']
```

### filter() — Select Items Meeting a Condition

```python
ports = [80, 443, 8080, 22, 5432]

privileged_ports = list(filter(lambda port: port < 1024, ports))
print(privileged_ports)  # [80, 443, 22]

# Equivalent list comprehension:
privileged = [port for port in ports if port < 1024]
print(privileged)  # [80, 443, 22]
```

> 💡 **Interview Tip:** `map()` and `filter()` return lazy iterators. Wrap with `list()` to get all results at once.

---

## 15. List Comprehensions

### Basic Syntax

```python
# [expression for item in iterable]
old_items = [1, 2, 3, 4]

# Traditional loop
doubled = []
for item in old_items:
    doubled.append(item * 2)
print(doubled)  # [2, 4, 6, 8]

# List comprehension (equivalent)
doubled = [item * 2 for item in old_items]
print(doubled)  # [2, 4, 6, 8]
```

### Filtering with `if`

```python
# [expression for item in iterable if condition]
numbers = [1, 5, 10, 8, 2, 15]
even_plus_one = [num + 1 for num in numbers if num % 2 == 0]
print(even_plus_one)  # [11, 9, 3]
```

### Set and Dictionary Comprehensions

```python
# Set comprehension — unique values
numbers = [1, 2, 3, 2, 4, 1, 3]
unique_squares = {x * x for x in numbers}
print(unique_squares)  # {1, 4, 9, 16}

# Dictionary comprehension
servers = ["web", "backend"]
server_ips = {server: f"192.168.1.{i}" for i, server in enumerate(servers)}
print(server_ips)  # {'web': '192.168.1.0', 'backend': '192.168.1.1'}
```

### Ternary (Conditional) Expression in Comprehensions

```python
numbers = [1, 5, 10, 8, 2, 15]
categories = ["PASS" if num >= 8 else "FAIL" for num in numbers]
print(categories)  # ['FAIL', 'FAIL', 'PASS', 'PASS', 'FAIL', 'PASS']
```

---

## 16. *args and **kwargs

### *args — Variable Positional Arguments

Collects extra positional arguments into a **tuple**.

```python
def apply_operator(operator, *operands):
    """Applies operator to operands. Supports 'add' and 'mul'."""
    if operator == 'add':
        return sum(operands)
    elif operator == 'mul':
        result = 1
        for n in operands:
            result *= n
        return result
    else:
        raise ValueError(f"Unknown operator: {operator}")

print(apply_operator('add', 1, 2, 3, 4))     # 10
print(apply_operator('mul', 1, 2, 3, 4, 5, 6, 7))  # 5040
```

### **kwargs — Variable Keyword Arguments

Collects extra keyword arguments into a **dictionary**.

```python
def set_options(**settings):
    print(f"Received: {settings}")
    for key, value in settings.items():
        print(f"\t{key} = {value}")

set_options(timeout=30, user="admin", retries=5)
# Output:
# Received: {'timeout': 30, 'user': 'admin', 'retries': 5}
# 	timeout = 30
# 	user = admin
# 	retries = 5
```

### Parameter Order Rules

```
def func(positional, default_param="val", *args, keyword_only, **kwargs):
```

1. Standard positional parameters
2. Parameters with default values
3. `*args`
4. Keyword-only parameters
5. `**kwargs`

### Unpacking in Function Calls

```python
# * unpacks a list into positional arguments
def connect(host, port, timeout):
    print(f"Connecting to {host}:{port} with timeout {timeout}s.")

params = ["db.internal", 5432, 10]
connect(*params)  # Equivalent to connect("db.internal", 5432, 10)

# ** unpacks a dict into keyword arguments
config = {"name": "auth-service", "version": "2.1.0", "replicas": 3}

def configure_service(name, version, replicas=1):
    print(f"Setting up {name} v{version} with {replicas} replicas...")

configure_service(**config)
# Output: Setting up auth-service v2.1.0 with 3 replicas...
```

---

## 17. Classes and OOP

### Defining a Class

```python
class ServiceMonitor:
    """Provides service checks for a single service."""

    def __init__(self, service_name, port):
        """Initializes the monitor.

        Args:
            service_name (str): Name of the service.
            port (int): Port for checks.
        """
        self.service = service_name
        self.port = port
        self.is_alive = False

    def check(self):
        """Simulates checking the service status."""
        print(f"Checking {self.service} on port {self.port}...")
        self.is_alive = True
        return self.is_alive
```

### Creating Instances

```python
nginx_monitor = ServiceMonitor("nginx", 80)
redis_monitor = ServiceMonitor(service_name="redis", port=6379)

print(isinstance(nginx_monitor, ServiceMonitor))  # True
print(nginx_monitor.service)  # nginx

status = nginx_monitor.check()
# Output: Checking nginx on port 80...
print(f"Status: {status}")  # Status: True
```

### Inheritance

```python
class HttpServiceMonitor(ServiceMonitor):
    """Extends ServiceMonitor with HTTP endpoint checks."""

    def __init__(self, service_name, port, url):
        super().__init__(service_name, port)  # Call parent __init__
        self.url = url

    def ping(self):
        """Ping the URL."""
        print(f"Pinging url {self.url}")

    def check(self):
        """Override parent check with additional HTTP check."""
        alive = super().check()  # Call parent method
        print(f"Performing HTTP check on {self.url}")

# Usage
http_monitor = HttpServiceMonitor("web", 8080, "http://localhost")
http_monitor.ping()   # Pinging url http://localhost
http_monitor.check()  # Checking web on port 8080... + HTTP check

nginx = ServiceMonitor("nginx", 80)
# nginx.ping()  # AttributeError! ping() is only in the subclass
```

### Key OOP Concepts

| Concept | Description |
|---------|-------------|
| **Class** | Blueprint/template for creating objects |
| **Object** | Instance created from a class |
| **`__init__`** | Constructor method, initializes attributes |
| **`self`** | Reference to the current instance |
| **Inheritance** | Child class inherits from Parent |
| **`super()`** | Calls the parent class's method |
| **Method Override** | Child redefines parent method |

---

## 18. Comparison Tables

### List vs Tuple

| Feature | List | Tuple |
|---------|------|-------|
| Syntax | `[1, 2, 3]` | `(1, 2, 3)` |
| Mutable? | ✅ Yes | ❌ No |
| Use as dict key? | ❌ No | ✅ Yes |
| Performance | Slightly slower | Slightly faster |
| Use Case | Dynamic collections | Fixed records |

### List vs Set

| Feature | List | Set |
|---------|------|-----|
| Ordered? | ✅ Yes | ❌ No |
| Duplicates? | ✅ Allowed | ❌ No |
| Indexing? | ✅ Yes | ❌ No |
| Membership test | O(n) | O(1) |
| Use Case | Ordered sequences | Uniqueness, fast lookup |

### map() vs filter()

| Feature | map() | filter() |
|---------|-------|----------|
| Purpose | Transform each item | Select items by condition |
| Returns | Iterator of transformed values | Iterator of original values passing test |
| Function returns | Any value | Boolean (truthy/falsy) |

### append() vs extend()

| Method | Behavior |
|--------|----------|
| `list.append(x)` | Adds `x` as a single element |
| `list.extend(iterable)` | Adds each item from iterable |

### Generator vs Normal Function

| Feature | Normal Function | Generator |
|---------|----------------|-----------|
| Keyword | `return` | `yield` |
| Memory | Stores all results | Produces one at a time |
| Reusable | Yes | Single-use iterator |

---

## 19. Python Fundamentals Programs for Interviews

---

### Program 1: Reverse a String

```python
# Problem: Reverse a given string

def reverse_string(s):
    """Reverses a string using slicing."""
    return s[::-1]

# Test
text = "Python"
result = reverse_string(text)
print(result)
# Output: nohtyP
```

**Explanation:** `s[::-1]` creates a slice from end to start with step -1.

---

### Program 2: Check Palindrome

```python
def is_palindrome(s):
    """Checks if a string reads the same forwards and backwards."""
    s = s.lower().replace(" ", "")
    return s == s[::-1]

print(is_palindrome("madam"))     # True
print(is_palindrome("Python"))    # False
print(is_palindrome("race car"))  # True
```

---

### Program 3: Factorial

```python
def factorial(n):
    """Calculates factorial of n iteratively."""
    result = 1
    for i in range(1, n + 1):
        result *= i
    return result

print(factorial(5))   # 120
print(factorial(0))   # 1
```

**Dry Run for factorial(5):** 1→1, 1×2=2, 2×3=6, 6×4=24, 24×5=120

---

### Program 4: Fibonacci Series

```python
def fibonacci(n):
    """Returns first n Fibonacci numbers."""
    seq = [0, 1]
    for _ in range(2, n):
        seq.append(seq[-1] + seq[-2])
    return seq[:n]

print(fibonacci(8))
# Output: [0, 1, 1, 2, 3, 5, 8, 13]
```

---

### Program 5: Prime Number Check

```python
def is_prime(n):
    """Checks if n is a prime number."""
    if n < 2:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True

print(is_prime(17))  # True
print(is_prime(4))   # False
print(is_prime(1))   # False
```

**Time Complexity:** O(√n)

---

### Program 6: Find Duplicates in a List

```python
def find_duplicates(lst):
    """Finds duplicate elements in a list."""
    seen = set()
    duplicates = set()
    for item in lst:
        if item in seen:
            duplicates.add(item)
        seen.add(item)
    return list(duplicates)

print(find_duplicates([1, 2, 3, 2, 4, 5, 3]))
# Output: [2, 3]
```

---

### Program 7: Second Largest Number

```python
def second_largest(numbers):
    """Finds the second largest number in a list."""
    unique = list(set(numbers))
    unique.sort()
    return unique[-2] if len(unique) >= 2 else None

print(second_largest([10, 20, 4, 45, 99]))  # 45
print(second_largest([10, 10, 10]))          # None
```

---

### Program 8: Remove Duplicates from List

```python
def remove_duplicates(lst):
    """Removes duplicates while preserving order."""
    seen = set()
    result = []
    for item in lst:
        if item not in seen:
            seen.add(item)
            result.append(item)
    return result

print(remove_duplicates([1, 2, 2, 3, 4, 3, 5]))
# Output: [1, 2, 3, 4, 5]
```

---

### Program 9: Count Vowels

```python
def count_vowels(s):
    """Counts vowels in a string."""
    vowels = "aeiouAEIOU"
    count = 0
    for char in s:
        if char in vowels:
            count += 1
    return count

print(count_vowels("Hello World"))  # 3
```

---

### Program 10: Anagram Check

```python
def is_anagram(s1, s2):
    """Checks if two strings are anagrams."""
    return sorted(s1.lower()) == sorted(s2.lower())

print(is_anagram("listen", "silent"))  # True
print(is_anagram("hello", "world"))    # False
```

---

### Program 11: Armstrong Number

```python
def is_armstrong(n):
    """Checks if n is an Armstrong number."""
    digits = str(n)
    power = len(digits)
    total = sum(int(d) ** power for d in digits)
    return total == n

print(is_armstrong(153))   # True (1³ + 5³ + 3³ = 153)
print(is_armstrong(370))   # True
print(is_armstrong(123))   # False
```

---

### Program 12: Character Frequency Counter

```python
def char_frequency(s):
    """Returns frequency of each character."""
    freq = {}
    for char in s:
        freq[char] = freq.get(char, 0) + 1
    return freq

print(char_frequency("hello"))
# Output: {'h': 1, 'e': 1, 'l': 2, 'o': 1}
```

---

### Program 13: Swap Two Variables

```python
a = 10
b = 20

# Pythonic swap (no temp variable needed)
a, b = b, a

print(f"a = {a}, b = {b}")
# Output: a = 20, b = 10
```

---

### Program 14: Find Common Elements Between Lists

```python
def common_elements(list1, list2):
    """Finds common elements using set intersection."""
    return list(set(list1) & set(list2))

print(common_elements([1, 2, 3, 4], [3, 4, 5, 6]))
# Output: [3, 4]
```

---

### Program 15: Merge Two Dictionaries

```python
dict1 = {"a": 1, "b": 2}
dict2 = {"b": 3, "c": 4}

# Python 3.9+ merge
merged = dict1 | dict2
print(merged)
# Output: {'a': 1, 'b': 3, 'c': 4}
```

---

### Program 16: Word Frequency Counter

```python
def word_frequency(text):
    """Counts frequency of each word."""
    words = text.lower().split()
    freq = {}
    for word in words:
        freq[word] = freq.get(word, 0) + 1
    return freq

print(word_frequency("hello world hello python world hello"))
# Output: {'hello': 3, 'world': 2, 'python': 1}
```

---

### Program 17: Flatten a Nested List

```python
def flatten(nested_list):
    """Flattens a 2D list into 1D."""
    result = []
    for sublist in nested_list:
        for item in sublist:
            result.append(item)
    return result

print(flatten([[1, 2], [3, 4], [5, 6]]))
# Output: [1, 2, 3, 4, 5, 6]

# Using list comprehension:
flat = [item for sublist in [[1, 2], [3, 4]] for item in sublist]
print(flat)  # [1, 2, 3, 4]
```

---

### Program 18: Sort Dictionary by Value

```python
scores = {"alice": 85, "bob": 92, "charlie": 78}

sorted_scores = dict(sorted(scores.items(), key=lambda item: item[1], reverse=True))
print(sorted_scores)
# Output: {'bob': 92, 'alice': 85, 'charlie': 78}
```

---

### Program 19: Missing Number in List (1 to N)

```python
def find_missing(lst, n):
    """Finds missing number from 1 to n."""
    expected_sum = n * (n + 1) // 2
    actual_sum = sum(lst)
    return expected_sum - actual_sum

print(find_missing([1, 2, 4, 5, 6], 6))  # 3
```

---

### Program 20: Sum of Even Numbers

```python
def sum_even(numbers):
    """Returns sum of even numbers in a list."""
    return sum(x for x in numbers if x % 2 == 0)

print(sum_even([1, 2, 3, 4, 5, 6]))  # 12
```

---

### Program 21: Matrix Addition

```python
def matrix_add(m1, m2):
    """Adds two matrices (2D lists)."""
    result = []
    for i in range(len(m1)):
        row = []
        for j in range(len(m1[0])):
            row.append(m1[i][j] + m2[i][j])
        result.append(row)
    return result

a = [[1, 2], [3, 4]]
b = [[5, 6], [7, 8]]
print(matrix_add(a, b))
# Output: [[6, 8], [10, 12]]
```

---

### Program 22: Check if List is Sorted

```python
def is_sorted(lst):
    """Checks if list is sorted in ascending order."""
    for i in range(len(lst) - 1):
        if lst[i] > lst[i + 1]:
            return False
    return True

print(is_sorted([1, 2, 3, 4]))    # True
print(is_sorted([1, 3, 2, 4]))    # False
```

---

### Program 23: Count Words in a String

```python
def count_words(text):
    """Counts number of words."""
    return len(text.split())

print(count_words("Hello World Python"))  # 3
```

---

### Program 24: Find Max and Min Without Built-ins

```python
def find_max_min(lst):
    """Finds max and min without using built-in functions."""
    max_val = lst[0]
    min_val = lst[0]
    for num in lst[1:]:
        if num > max_val:
            max_val = num
        if num < min_val:
            min_val = num
    return max_val, min_val

print(find_max_min([3, 1, 4, 1, 5, 9, 2, 6]))
# Output: (9, 1)
```

---

### Program 25: Remove All Occurrences of an Element

```python
def remove_all(lst, value):
    """Removes all occurrences of value from list."""
    return [x for x in lst if x != value]

print(remove_all([1, 2, 3, 2, 4, 2], 2))
# Output: [1, 3, 4]
```

---

### Program 26: Title Case Conversion

```python
def title_case(text):
    """Converts string to title case."""
    return " ".join(word.capitalize() for word in text.split())

print(title_case("hello world python"))
# Output: Hello World Python
```

---

### Program 27: Sum of Digits

```python
def sum_of_digits(n):
    """Calculates sum of digits of a number."""
    total = 0
    n = abs(n)
    while n > 0:
        total += n % 10
        n //= 10
    return total

print(sum_of_digits(12345))  # 15
print(sum_of_digits(999))    # 27
```

---

### Program 28: List Intersection, Union, Difference

```python
list1 = [1, 2, 3, 4, 5]
list2 = [4, 5, 6, 7, 8]

intersection = list(set(list1) & set(list2))
union = list(set(list1) | set(list2))
difference = list(set(list1) - set(list2))

print(f"Intersection: {intersection}")  # [4, 5]
print(f"Union: {union}")                # [1, 2, 3, 4, 5, 6, 7, 8]
print(f"Difference: {difference}")      # [1, 2, 3]
```

---

### Program 29: Pattern — Right Triangle

```python
def right_triangle(n):
    """Prints a right triangle pattern of stars."""
    for i in range(1, n + 1):
        print("*" * i)

right_triangle(5)
# Output:
# *
# **
# ***
# ****
# *****
```

---

### Program 30: GCD of Two Numbers

```python
def gcd(a, b):
    """Finds GCD using Euclidean algorithm."""
    while b:
        a, b = b, a % b
    return a

print(gcd(48, 18))  # 6
print(gcd(100, 75)) # 25
```

---

### Program 31: Check if Two Strings are Rotations

```python
def is_rotation(s1, s2):
    """Checks if s2 is a rotation of s1."""
    if len(s1) != len(s2):
        return False
    return s2 in s1 + s1

print(is_rotation("abcde", "cdeab"))  # True
print(is_rotation("abcde", "abced"))  # False
```

---

### Program 32: Exception Handling Example

```python
def safe_divide(a, b):
    """Divides a by b with error handling."""
    try:
        result = a / b
    except ZeroDivisionError:
        print("Error: Cannot divide by zero!")
        return None
    except TypeError:
        print("Error: Invalid input types!")
        return None
    else:
        return result
    finally:
        print("Division operation attempted.")

print(safe_divide(10, 2))   # 5.0
print(safe_divide(10, 0))   # None (with error message)
```

---

### Program 33: OOP — Bank Account

```python
class BankAccount:
    """Simple bank account class."""

    def __init__(self, owner, balance=0):
        self.owner = owner
        self.balance = balance

    def deposit(self, amount):
        if amount > 0:
            self.balance += amount
            print(f"Deposited {amount}. Balance: {self.balance}")
        else:
            print("Deposit amount must be positive.")

    def withdraw(self, amount):
        if amount > self.balance:
            print("Insufficient funds!")
        elif amount <= 0:
            print("Withdrawal amount must be positive.")
        else:
            self.balance -= amount
            print(f"Withdrew {amount}. Balance: {self.balance}")

# Usage
account = BankAccount("Alice", 1000)
account.deposit(500)     # Deposited 500. Balance: 1500
account.withdraw(200)    # Withdrew 200. Balance: 1300
account.withdraw(2000)   # Insufficient funds!
```

---

### Program 34: Convert List of Tuples to Dictionary

```python
pairs = [("name", "Alice"), ("age", 30), ("city", "NYC")]
result = dict(pairs)
print(result)
# Output: {'name': 'Alice', 'age': 30, 'city': 'NYC'}
```

---

### Program 35: Filter and Transform with Comprehension

```python
# Get uppercase names of servers with port > 1000
servers = [("web", 80), ("app", 8080), ("cache", 6379), ("ssh", 22)]

high_port_servers = [name.upper() for name, port in servers if port > 1000]
print(high_port_servers)
# Output: ['APP', 'CACHE']
```

---

## 🎯 Final Interview Tips

1. **Always explain your approach** before writing code
2. **Start with brute force**, then optimize
3. **Handle edge cases**: empty lists, None, negative numbers
4. **Use meaningful variable names** — interviewers notice
5. **Know time complexity**: O(1), O(n), O(n²), O(log n)
6. **Practice dry runs** — trace through code mentally
7. **Know the difference** between mutable and immutable types
8. **Understand pass-by-reference** for lists and dicts
9. **Use Python's built-in functions**: `sorted()`, `enumerate()`, `zip()`, `map()`, `filter()`
10. **Write docstrings** — shows professionalism

---

> 📌 **This handbook covers all Python fundamentals from the [lm-academy/python-devops](https://github.com/lm-academy/python-devops) repository. Use it as your complete learning, revision, and interview preparation guide.**
