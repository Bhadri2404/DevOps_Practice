# Section 2: Python Fundamentals — Variables, Data Types, and Operators

---

## 📑 Table of Contents

- [2.1 What Are Variables?](#21-what-are-variables)
- [2.2 How Variables Work Internally in Python](#22-how-variables-work-internally-in-python)
- [2.3 Variable Naming Rules and Conventions](#23-variable-naming-rules-and-conventions)
- [2.4 Data Types Overview](#24-data-types-overview)
- [2.5 Numbers — Integers and Floats](#25-numbers--integers-and-floats)
- [2.6 Strings](#26-strings)
- [2.7 Booleans](#27-booleans)
- [2.8 None Type](#28-none-type)
- [2.9 Type Checking and Type Conversion](#29-type-checking-and-type-conversion)
- [2.10 Operators — Arithmetic](#210-operators--arithmetic)
- [2.11 Operators — Comparison](#211-operators--comparison)
- [2.12 Operators — Logical](#212-operators--logical)
- [2.13 Operators — Assignment](#213-operators--assignment)
- [2.14 Operators — Membership and Identity](#214-operators--membership-and-identity)
- [2.15 String Operations and Methods](#215-string-operations-and-methods)
- [2.16 f-Strings (Formatted String Literals)](#216-f-strings-formatted-string-literals)
- [2.17 Input from Users](#217-input-from-users)
- [2.18 Comments and Documentation](#218-comments-and-documentation)
- [2.19 Section Summary and Review](#219-section-summary-and-review)

---

## 🎯 Learning Objectives

By the end of this section, you will:

1. Understand what variables are and how Python stores them internally (name → object model)
2. Know all Python naming rules and PEP 8 conventions
3. Understand every basic data type: int, float, str, bool, None
4. Perform type checking with `type()` and `isinstance()`
5. Convert between types (casting)
6. Use all Python operators: arithmetic, comparison, logical, assignment, membership, identity
7. Work with strings confidently — slicing, methods, f-strings
8. Accept user input and understand why it's always a string
9. Write proper comments and docstrings
10. Avoid all common beginner mistakes related to variables and data types

---

## 2.1 What Are Variables?

### Real-Life Analogy

Imagine a **sticky note**. You write a name on it (like "age") and stick it onto a box that contains a value (like the number 25). The sticky note is the **variable name**, and the box is the **object in memory**.

In Python, a variable is NOT a box that stores data. A variable is a **name tag** (label) that **points to** (references) an object stored somewhere in memory.

### Why Variables Exist

Without variables, you would have to remember exact memory addresses (like `0x7f3a2c`) to access your data. Variables give human-friendly names to pieces of data so you can:

- Store values for later use
- Give meaning to data (what does `42` mean? But `server_count = 42` is clear)
- Reuse and modify data throughout your program
- Make code readable

### What Problem They Solve

```python
# Without variables — meaningless
print(3.14 * 5 * 5)

# With variables — clear intent
pi = 3.14
radius = 5
area = pi * radius * radius
print(area)
```

The second version tells you WHAT is being calculated. Six months later, you (or a teammate) can understand this code instantly.

### Creating a Variable (Assignment)

```python
server_name = "web-server-01"
```

**Line-by-Line Explanation:**

| Part | Meaning |
|------|---------|
| `server_name` | The variable name (label/reference) |
| `=` | The assignment operator (NOT "equals" in the math sense — it means "make this name point to this value") |
| `"web-server-01"` | The value (a string object created in memory) |

**What happens internally:**
1. Python creates a string object `"web-server-01"` somewhere in memory
2. Python creates the name `server_name`
3. Python makes `server_name` **point to** that string object

### Simple Examples

```python
# Storing different types of data
hostname = "k8s-node-03"       # A text value (string)
cpu_cores = 8                   # A whole number (integer)
memory_gb = 15.7                # A decimal number (float)
is_healthy = True               # A true/false value (boolean)
```

### Expected Output (Printing Variables)

```python
hostname = "k8s-node-03"
cpu_cores = 8
print(hostname)
print(cpu_cores)
```

```
k8s-node-03
8
```

### Dynamic Typing — Python's Superpower (and Trap)

Python is **dynamically typed**, meaning:
- You do NOT declare the type of a variable
- A variable can point to any type of object
- A variable can be reassigned to a different type at any time

```python
x = 10          # x points to an integer
print(type(x))  # <class 'int'>

x = "hello"     # Now x points to a string (no error!)
print(type(x))  # <class 'str'>
```

**Advantage:** Flexible, fast to write, less boilerplate
**Disadvantage:** Type errors only appear at runtime (not caught early)

### Common Beginner Mistake #1: Using a Variable Before Assignment

```python
print(server_ip)  # NameError: name 'server_ip' is not defined
server_ip = "10.0.0.5"
```

Python reads top to bottom. You cannot use a name before it exists.

### Common Beginner Mistake #2: Confusing `=` with `==`

```python
x = 5     # Assignment: make x point to 5
x == 5    # Comparison: is x equal to 5? (returns True or False)
```

---

## 2.2 How Variables Work Internally in Python

### Why This Matters

Understanding Python's internal variable model prevents subtle bugs and confusion. This is also a **frequent interview question**.

### The Name-Object Model

In languages like C, a variable IS a memory location (a box):
```
┌─────────┐
│  x = 5  │   In C: x IS the box, 5 is stored directly inside
└─────────┘
```

In Python, a variable is a **name** that **references** an object:
```
                    ┌──────────────────────┐
  server_name ────▶│  Object: "web-01"    │
                    │  Type: str           │
                    │  RefCount: 1         │
                    │  Address: 0x7f3a2c   │
                    └──────────────────────┘
```

### What Happens During Assignment

```python
a = 100
b = a
```

```
Step 1: a = 100
                    ┌──────────────────────┐
  a ───────────────▶│  Object: 100         │
                    │  Type: int           │
                    │  RefCount: 1         │
                    └──────────────────────┘

Step 2: b = a  (b now points to the SAME object)
                    ┌──────────────────────┐
  a ───────────────▶│  Object: 100         │
  b ───────────────▶│  Type: int           │
                    │  RefCount: 2         │
                    └──────────────────────┘
```

Both `a` and `b` point to the **same object** in memory. Python doesn't copy the value — it creates another reference.

### Reassignment Creates New References

```python
a = 100
b = a
a = 200   # a now points to a NEW object; b still points to 100
```

```
                    ┌──────────────────────┐
  a ───────────────▶│  Object: 200         │
                    └──────────────────────┘
                    ┌──────────────────────┐
  b ───────────────▶│  Object: 100         │
                    └──────────────────────┘
```

### Verifying with `id()` Function

The `id()` function returns the memory address of an object:

```python
a = 100
b = a
print(id(a))   # 140234567890
print(id(b))   # 140234567890  ← Same address! Same object!

a = 200
print(id(a))   # 140234567999  ← Different address! New object!
print(id(b))   # 140234567890  ← Still points to 100
```

### Interview Perspective

> **Q: Is Python pass-by-value or pass-by-reference?**
>
> A: Neither exactly. Python uses **pass-by-object-reference** (also called pass-by-assignment). When you pass a variable to a function, you pass the reference to the object. If the object is mutable (list, dict), changes inside the function affect the original. If immutable (int, str, tuple), a new object is created on modification.

---

## 2.3 Variable Naming Rules and Conventions

### Hard Rules (Breaking These Causes Errors)

| Rule | Valid Example | Invalid Example |
|------|--------------|-----------------|
| Must start with letter or underscore | `name`, `_count` | `2name` (starts with number) |
| Can contain letters, numbers, underscores | `server_2`, `node_count` | `server-2` (hyphen not allowed) |
| Cannot be a Python keyword | `my_class` | `class` (reserved keyword) |
| Case-sensitive | `Name` ≠ `name` ≠ `NAME` | — |

### Python Keywords (Reserved — Cannot Use as Variable Names)

```python
import keyword
print(keyword.kwlist)
```

```
['False', 'None', 'True', 'and', 'as', 'assert', 'async', 'await',
 'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except',
 'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is',
 'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try',
 'while', 'with', 'yield']
```

### PEP 8 Naming Conventions (Soft Rules — Won't Cause Errors, But Break Standards)

| What | Convention | Example |
|------|-----------|---------|
| Variables | `snake_case` | `server_count`, `max_retries` |
| Constants | `UPPER_SNAKE_CASE` | `MAX_CONNECTIONS`, `DEFAULT_PORT` |
| Functions | `snake_case` | `get_server_status()` |
| Classes | `PascalCase` | `ServerManager`, `HttpClient` |
| Private variables | Leading underscore | `_internal_count` |
| "Dunder" (magic) | Double underscores | `__init__`, `__str__` |

### Best Practices for DevOps Engineers

```python
# ✅ GOOD — Descriptive, clear intent
max_retry_count = 3
ec2_instance_id = "i-0abc123def456"
is_deployment_successful = True
pod_restart_threshold = 5

# ❌ BAD — Unclear, too short, meaningless
x = 3
id = "i-0abc123def456"    # "id" shadows built-in function!
flag = True
n = 5
```

### Common Mistake: Shadowing Built-in Names

```python
# ❌ DANGEROUS — Overwrites Python's built-in functions
list = [1, 2, 3]          # Now you can't use list() anymore!
type = "production"       # Now you can't use type() anymore!
id = "abc123"             # Now you can't use id() anymore!
input = "some value"      # Now you can't use input() anymore!

# ✅ CORRECT
server_list = [1, 2, 3]
env_type = "production"
instance_id = "abc123"
user_input = "some value"
```

---

## 2.4 Data Types Overview

### What Are Data Types?

A data type tells Python **what kind of value** an object holds and **what operations** you can perform on it.

- You can add two numbers: `5 + 3 = 8`
- You can add (concatenate) two strings: `"hello" + " world" = "hello world"`
- You CANNOT add a number and a string: `5 + "hello"` → Error

### Python's Core Data Types

```
┌──────────────────────────────────────────────────────────────┐
│                    PYTHON DATA TYPES                          │
├──────────────────┬───────────────────────────────────────────┤
│  Category        │  Types                                    │
├──────────────────┼───────────────────────────────────────────┤
│  Numeric         │  int, float, complex                      │
│  Text            │  str                                      │
│  Boolean         │  bool (True, False)                       │
│  None            │  NoneType (None)                          │
│  Sequence        │  list, tuple, range                       │
│  Mapping         │  dict                                     │
│  Set             │  set, frozenset                           │
│  Binary          │  bytes, bytearray, memoryview             │
├──────────────────┼───────────────────────────────────────────┤
│  THIS SECTION    │  int, float, str, bool, None              │
│  NEXT SECTIONS   │  list, tuple, dict, set                   │
└──────────────────┴───────────────────────────────────────────┘
```

### Mutable vs Immutable — Critical Concept

| Immutable (Cannot Change) | Mutable (Can Change) |
|---------------------------|---------------------|
| int, float, str, bool, tuple, frozenset | list, dict, set |

**What "immutable" means:** Once created, the object's value cannot be modified. If you "change" it, Python actually creates a NEW object.

```python
name = "hello"
name = "world"   # This does NOT modify the "hello" object.
                  # It creates a NEW "world" object and points 'name' to it.
                  # The old "hello" object will be garbage-collected.
```

This will become very important when we discuss lists and functions later.

---

## 2.5 Numbers — Integers and Floats

### Integers (int)

**What:** Whole numbers without decimal points. Can be positive, negative, or zero.

```python
server_count = 42
temperature = -10
zero = 0
very_large = 999_999_999  # Underscores for readability (Python 3.6+)
```

**Key Fact:** Python integers have **unlimited size**. Unlike C/Java where `int` is limited to ~2 billion, Python can handle numbers of any size:

```python
huge = 10 ** 100  # 10 to the power of 100 — no overflow!
print(huge)
# 10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
```

### Floats (float)

**What:** Numbers with decimal points. Used for measurements, percentages, calculations requiring precision.

```python
cpu_usage = 78.5
memory_percent = 92.3
pi = 3.14159
negative_temp = -40.0
```

### Float Precision Warning — Critical for All Programmers

```python
print(0.1 + 0.2)
```

**Expected output:** `0.3`
**Actual output:** `0.30000000000000004`

**Why?** Computers store numbers in binary (base 2). Just like 1/3 = 0.3333... never ends in base 10, some decimal numbers (like 0.1) never end in base 2. This causes tiny rounding errors.

**How to handle it:**
```python
# For approximate comparison
import math
print(math.isclose(0.1 + 0.2, 0.3))  # True

# For financial/exact calculations, use Decimal
from decimal import Decimal
print(Decimal('0.1') + Decimal('0.2'))  # 0.3 (exact)
```

### Integer Division vs Float Division

```python
print(10 / 3)    # 3.3333... (float division — always returns float)
print(10 // 3)   # 3         (floor division — rounds down to integer)
print(10 % 3)    # 1         (modulo — remainder after division)
```

### DevOps Use Case

```python
# Calculate how many pods to scale
total_requests = 10000
requests_per_pod = 500
pods_needed = total_requests // requests_per_pod
print(f"Scale to {pods_needed} pods")  # Scale to 20 pods
```

---

## 2.6 Strings

### What Are Strings?

A string is a **sequence of characters** enclosed in quotes. Characters can be letters, numbers, symbols, spaces, emojis — anything.

```python
hostname = "web-server-01"         # Double quotes
region = 'us-east-1'               # Single quotes (identical behavior)
log_message = "Error: disk full"   # Contains special characters
empty = ""                         # Empty string (valid, has 0 characters)
```

### Single vs Double Quotes

There is **no difference** between single and double quotes in Python. Use whichever is convenient:

```python
# Use double quotes when string contains single quote
message = "It's running"

# Use single quotes when string contains double quote
html = '<div class="container">'

# Use triple quotes for multi-line strings
description = """This server runs
across multiple availability zones
in the us-east-1 region."""
```

### Strings Are Immutable

```python
name = "hello"
# name[0] = "H"   # ❌ TypeError: 'str' object does not support item assignment

# To "change" a string, create a new one:
name = "H" + name[1:]  # "Hello" — new string object
```

### String Indexing (Accessing Individual Characters)

Every character in a string has a position number (index), starting from **0**:

```
 String:    P   y   t   h   o   n
 Index:     0   1   2   3   4   5
 Negative: -6  -5  -4  -3  -2  -1
```

```python
language = "Python"
print(language[0])    # P (first character)
print(language[5])    # n (last character)
print(language[-1])   # n (last character using negative index)
print(language[-2])   # o (second from last)
```

### String Slicing (Extracting Portions)

Syntax: `string[start:stop:step]`
- `start` — where to begin (inclusive)
- `stop` — where to end (exclusive — NOT included)
- `step` — how many positions to jump

```python
text = "kubernetes"

print(text[0:4])     # "kube"     (index 0, 1, 2, 3)
print(text[4:])      # "rnetes"   (index 4 to end)
print(text[:4])      # "kube"     (beginning to index 3)
print(text[::2])     # "kreee"    (every 2nd character)
print(text[::-1])    # "setenrebuk" (reversed)
```

### Why Slicing Is Important for DevOps

```python
# Extracting parts from log lines
log_line = "2024-01-15 08:30:22 ERROR disk full on /dev/sda1"
date = log_line[0:10]           # "2024-01-15"
time = log_line[11:19]          # "08:30:22"
level = log_line[20:25]         # "ERROR"
message = log_line[26:]         # "disk full on /dev/sda1"
```

### String Length

```python
hostname = "web-server-01"
print(len(hostname))   # 13
```

---

## 2.7 Booleans

### What Are Booleans?

A boolean is the simplest data type — it can only be one of two values: `True` or `False`. Named after mathematician George Boole.

```python
is_server_running = True
has_errors = False
```

### Why Booleans Matter

Every decision in programming comes down to True or False:
- Is the server healthy? → Run traffic to it
- Did deployment fail? → Roll back
- Is disk usage above 90%? → Send alert

### Truthy and Falsy Values — Critical Concept

In Python, EVERY value can be evaluated as True or False (not just booleans):

**Falsy values (evaluate to False):**
| Value | Type |
|-------|------|
| `False` | bool |
| `0` | int |
| `0.0` | float |
| `""` | empty string |
| `[]` | empty list |
| `{}` | empty dict |
| `()` | empty tuple |
| `set()` | empty set |
| `None` | NoneType |

**Everything else is Truthy (evaluates to True).**

```python
# This is why you can write:
server_list = ["web-01", "web-02"]

if server_list:           # True because list is not empty
    print("Servers found")

error_message = ""

if not error_message:     # True because empty string is falsy
    print("No errors")
```

### Common Mistake: `True`/`False` Must Be Capitalized

```python
is_valid = True    # ✅ Correct
is_valid = true    # ❌ NameError: name 'true' is not defined
is_valid = TRUE    # ❌ NameError
```

---

## 2.8 None Type

### What Is None?

`None` is Python's way of saying **"no value"** or **"nothing here."** It is NOT zero, NOT an empty string, NOT False — it is the intentional absence of any value.

### Real-Life Analogy

Think of a form with a field for "Middle Name." If someone doesn't have a middle name, the field is not empty (that might mean they didn't fill it in) — it's **"Not Applicable"**. That's what `None` represents.

### Why It Exists

```python
# A function that might not find what it's looking for
def find_server(name):
    servers = {"web-01": "10.0.0.1", "db-01": "10.0.0.2"}
    return servers.get(name, None)  # Returns None if not found

result = find_server("cache-01")
print(result)  # None

# Checking for None
if result is None:
    print("Server not found!")
```

### Important Rule: Always Use `is None`, Never `== None`

```python
# ✅ Correct
if value is None:
    print("No value")

# ❌ Incorrect (works but bad practice)
if value == None:
    print("No value")
```

**Why?** `is` checks identity (is it the exact same object?). `==` checks equality (can be overridden by custom classes to behave unexpectedly). Since there's only ONE `None` object in Python, `is` is the correct check.

---

## 2.9 Type Checking and Type Conversion

### Checking Types with `type()`

```python
x = 42
print(type(x))    # <class 'int'>

y = "hello"
print(type(y))    # <class 'str'>

z = True
print(type(z))    # <class 'bool'>
```

### Checking Types with `isinstance()` (Preferred)

```python
x = 42
print(isinstance(x, int))        # True
print(isinstance(x, str))        # False
print(isinstance(x, (int, float)))  # True (checks multiple types)
```

**Why `isinstance()` is preferred over `type()`:**
- `isinstance()` respects inheritance (OOP concept — covered later)
- More flexible — can check multiple types at once

### Type Conversion (Casting)

Sometimes you need to convert one type to another:

```python
# String to Integer
port_str = "8080"
port_num = int(port_str)        # 8080 (integer)

# Integer to String
count = 42
count_str = str(count)          # "42" (string)

# String to Float
cpu = "78.5"
cpu_float = float(cpu)          # 78.5 (float)

# Integer to Float
x = int(3.9)                    # 3 (truncates, does NOT round!)

# Any value to Boolean
bool(0)       # False
bool(1)       # True
bool("")      # False
bool("hi")    # True
```

### Common Mistake: Invalid Conversion

```python
int("hello")    # ❌ ValueError: invalid literal for int() with base 10: 'hello'
int("3.14")     # ❌ ValueError (can't go directly from float-string to int)
int(float("3.14"))  # ✅ 3 (convert to float first, then to int)
```

### DevOps Scenario: Why Type Conversion Matters

Environment variables are ALWAYS strings:

```python
import os

# os.environ returns strings!
max_retries = os.environ.get("MAX_RETRIES", "3")
print(type(max_retries))  # <class 'str'>

# You must convert before doing math
max_retries = int(max_retries)
remaining = max_retries - 1  # Now this works
```

---

## 2.10 Operators — Arithmetic

### What Are Operators?

Operators are **symbols** that perform operations on values (operands).

### Arithmetic Operators

| Operator | Name | Example | Result |
|----------|------|---------|--------|
| `+` | Addition | `10 + 3` | `13` |
| `-` | Subtraction | `10 - 3` | `7` |
| `*` | Multiplication | `10 * 3` | `30` |
| `/` | Division (float) | `10 / 3` | `3.333...` |
| `//` | Floor Division | `10 // 3` | `3` |
| `%` | Modulo (remainder) | `10 % 3` | `1` |
| `**` | Exponentiation | `2 ** 10` | `1024` |

### Important Details

```python
# Division ALWAYS returns float
print(10 / 2)     # 5.0 (not 5!)
print(type(10/2)) # <class 'float'>

# Floor division rounds DOWN (toward negative infinity)
print(7 // 2)     # 3
print(-7 // 2)    # -4 (not -3! rounds toward negative infinity)

# Modulo — useful for "every Nth iteration"
for i in range(10):
    if i % 3 == 0:  # Every 3rd iteration (0, 3, 6, 9)
        print(f"Processing batch at iteration {i}")
```

### Operator Precedence (Order of Operations)

Python follows mathematical rules: **PEMDAS**

```
Parentheses > Exponent > Multiplication/Division > Addition/Subtraction

print(2 + 3 * 4)       # 14 (not 20! multiplication first)
print((2 + 3) * 4)     # 20 (parentheses force addition first)
print(2 ** 3 ** 2)     # 512 (exponent is right-associative: 3**2=9, then 2**9=512)
```

**Best Practice:** Use parentheses to make intent explicit, even when not required:

```python
# ❌ Relies on knowing precedence rules
result = a + b * c / d - e

# ✅ Clear intent
result = a + ((b * c) / d) - e
```

---

## 2.11 Operators — Comparison

### What They Do

Comparison operators compare two values and return `True` or `False`.

| Operator | Meaning | Example | Result |
|----------|---------|---------|--------|
| `==` | Equal to | `5 == 5` | `True` |
| `!=` | Not equal to | `5 != 3` | `True` |
| `>` | Greater than | `5 > 3` | `True` |
| `<` | Less than | `5 < 3` | `False` |
| `>=` | Greater than or equal | `5 >= 5` | `True` |
| `<=` | Less than or equal | `3 <= 5` | `True` |

### Chained Comparisons (Python Unique Feature)

```python
# Instead of:
x = 15
if x > 10 and x < 20:
    print("In range")

# Python allows (reads like English!):
if 10 < x < 20:
    print("In range")
```

### DevOps Example

```python
cpu_usage = 87.5
disk_usage = 92.0

if cpu_usage > 80:
    print("⚠️  HIGH CPU ALERT")

if disk_usage >= 90:
    print("🚨 CRITICAL DISK ALERT")
```

### String Comparison

Strings are compared **lexicographically** (alphabetical/Unicode order):

```python
print("apple" < "banana")    # True (a comes before b)
print("abc" == "ABC")        # False (case-sensitive!)
print("abc" == "abc")        # True
```

---

## 2.12 Operators — Logical

### What They Do

Logical operators combine multiple conditions:

| Operator | Meaning | Example | Result |
|----------|---------|---------|--------|
| `and` | Both must be True | `True and False` | `False` |
| `or` | At least one True | `True or False` | `True` |
| `not` | Inverts the value | `not True` | `False` |

### Truth Tables

**AND:**
| A | B | A and B |
|---|---|---------|
| True | True | True |
| True | False | False |
| False | True | False |
| False | False | False |

**OR:**
| A | B | A or B |
|---|---|--------|
| True | True | True |
| True | False | True |
| False | True | True |
| False | False | False |

### Short-Circuit Evaluation — Important for Performance

Python is lazy — it stops evaluating as soon as the result is determined:

```python
# 'and' stops at first False (no need to check further)
result = False and expensive_function()  # expensive_function() NEVER runs

# 'or' stops at first True
result = True or expensive_function()    # expensive_function() NEVER runs
```

### Production Example

```python
cpu_usage = 85
memory_usage = 92
disk_usage = 45

# Alert only if CPU AND memory are both high
if cpu_usage > 80 and memory_usage > 90:
    print("🚨 System under heavy load — both CPU and memory critical")

# Alert if ANY resource is critical
if cpu_usage > 95 or memory_usage > 95 or disk_usage > 95:
    print("🚨 At least one resource is critically high")

# Check if service is NOT healthy
is_healthy = False
if not is_healthy:
    print("Service is down — triggering restart")
```

---

## 2.13 Operators — Assignment

### Basic and Compound Assignment

| Operator | Equivalent To | Example |
|----------|--------------|---------|
| `=` | Assign | `x = 5` |
| `+=` | `x = x + value` | `x += 3` → `x = x + 3` |
| `-=` | `x = x - value` | `x -= 2` → `x = x - 2` |
| `*=` | `x = x * value` | `x *= 4` → `x = x * 4` |
| `/=` | `x = x / value` | `x /= 2` → `x = x / 2` |
| `//=` | `x = x // value` | `x //= 3` |
| `%=` | `x = x % value` | `x %= 2` |
| `**=` | `x = x ** value` | `x **= 2` |

### Example

```python
retry_count = 0

# Each retry
retry_count += 1   # Now 1
retry_count += 1   # Now 2
retry_count += 1   # Now 3

print(f"Total retries: {retry_count}")  # Total retries: 3
```

### Multiple Assignment (Python Feature)

```python
# Assign multiple variables at once
x, y, z = 1, 2, 3

# Swap values (no temp variable needed!)
a, b = 10, 20
a, b = b, a    # Now a=20, b=10

# Same value to multiple variables
host = port = protocol = None
```

---

## 2.14 Operators — Membership and Identity

### Membership Operators: `in` and `not in`

Check if a value exists within a sequence:

```python
# In a string
print("error" in "FileNotFoundError")     # True
print("warning" in "FileNotFoundError")   # False

# In a list
allowed_regions = ["us-east-1", "us-west-2", "eu-west-1"]
print("us-east-1" in allowed_regions)     # True
print("ap-south-1" in allowed_regions)    # False
print("ap-south-1" not in allowed_regions)  # True
```

### Identity Operators: `is` and `is not`

Check if two variables point to the **exact same object** in memory (not just equal values):

```python
a = [1, 2, 3]
b = [1, 2, 3]
c = a

print(a == b)    # True  (same VALUE)
print(a is b)    # False (different OBJECTS in memory)
print(a is c)    # True  (same object — c references the same list as a)
```

### When to Use `is`

Only use `is` for:
- `None` checks: `if x is None`
- `True`/`False` checks (rare): `if x is True`
- Singleton comparisons

For everything else, use `==`.

---

## 2.15 String Operations and Methods

### String Concatenation

```python
first = "web"
second = "server"
combined = first + "-" + second   # "web-server"
```

### String Repetition

```python
separator = "=" * 40
print(separator)   # "========================================"
```

### Essential String Methods for DevOps

```python
log = "  ERROR: Connection timeout on server-01  "

# Whitespace removal
print(log.strip())          # "ERROR: Connection timeout on server-01"
print(log.lstrip())         # "ERROR: Connection timeout on server-01  "
print(log.rstrip())         # "  ERROR: Connection timeout on server-01"

# Case conversion
print("hello".upper())      # "HELLO"
print("HELLO".lower())      # "hello"
print("hello world".title())  # "Hello World"

# Searching
print(log.find("timeout"))    # 22 (index where "timeout" starts)
print(log.find("missing"))    # -1 (not found)
print("error" in log.lower()) # True

# Checking content
print("12345".isdigit())      # True
print("hello".isalpha())      # True
print("hello123".isalnum())   # True

# Replacing
print("us-east-1".replace("east", "west"))  # "us-west-1"

# Splitting (string → list)
csv_line = "web-01,10.0.0.1,healthy"
parts = csv_line.split(",")
print(parts)    # ['web-01', '10.0.0.1', 'healthy']

# Joining (list → string)
servers = ["web-01", "web-02", "web-03"]
result = ", ".join(servers)
print(result)   # "web-01, web-02, web-03"

# Starts/ends with
filename = "deployment.yaml"
print(filename.startswith("deploy"))  # True
print(filename.endswith(".yaml"))     # True
```

### Production Scenario: Parsing a Log Line

```python
log_line = "2024-01-15 08:30:22 [ERROR] disk usage at 95% on /dev/sda1"

# Extract components
parts = log_line.split(" ", 3)  # Split into max 4 parts
date = parts[0]           # "2024-01-15"
time = parts[1]           # "08:30:22"
level = parts[2]          # "[ERROR]"
message = parts[3]        # "disk usage at 95% on /dev/sda1"

level_clean = level.strip("[]")  # "ERROR"

if level_clean == "ERROR":
    print(f"🚨 Alert at {date} {time}: {message}")
```

---

## 2.16 f-Strings (Formatted String Literals)

### What Are f-Strings?

f-Strings (introduced in Python 3.6) are the modern, preferred way to embed variables and expressions inside strings. Prefix the string with `f` and put variables inside `{}`.

### Why They Exist

Before f-strings, Python had several awkward string formatting methods:

```python
name = "k8s-node-01"
cpu = 78.5

# Old way 1: % formatting (Python 2 style)
print("Server %s has %.1f%% CPU" % (name, cpu))

# Old way 2: .format() method
print("Server {} has {:.1f}% CPU".format(name, cpu))

# Modern way: f-string ✅
print(f"Server {name} has {cpu:.1f}% CPU")
```

f-Strings are the most readable, the fastest, and the standard in modern Python.

### Examples

```python
hostname = "web-server-01"
status = "running"
uptime_hours = 720

# Simple variable insertion
print(f"Host: {hostname}")
# Host: web-server-01

# Expressions inside braces
print(f"Uptime: {uptime_hours / 24:.1f} days")
# Uptime: 30.0 days

# Method calls inside braces
print(f"Host: {hostname.upper()}")
# Host: WEB-SERVER-01

# Alignment and padding
for server in ["web-01", "db-01", "cache-01"]:
    print(f"{server:<15} | Status: OK")
# web-01          | Status: OK
# db-01           | Status: OK
# cache-01        | Status: OK
```

### Formatting Numbers

```python
# Decimal places
cpu = 78.56789
print(f"CPU: {cpu:.2f}%")       # CPU: 78.57%

# Thousands separator
requests = 1234567
print(f"Requests: {requests:,}")  # Requests: 1,234,567

# Percentage
ratio = 0.856
print(f"Success rate: {ratio:.1%}")  # Success rate: 85.6%
```

---

## 2.17 Input from Users

### The `input()` Function

```python
name = input("Enter your name: ")
print(f"Hello, {name}!")
```

### Critical Fact: `input()` ALWAYS Returns a String

```python
age = input("Enter your age: ")   # User types: 25
print(type(age))                   # <class 'str'> — NOT int!

# You must convert:
age = int(input("Enter your age: "))
```

### DevOps Use Case

```python
# Simple confirmation prompt
response = input("Deploy to production? (yes/no): ")
if response.lower().strip() == "yes":
    print("🚀 Deploying...")
else:
    print("❌ Deployment cancelled")
```

### Why Input Is Rarely Used in Production DevOps

In production automation:
- Scripts run unattended (no human to type)
- Use **command-line arguments** (`argparse`) instead
- Use **environment variables** (`os.environ`) instead
- Use **configuration files** (YAML/JSON) instead

`input()` is mainly for learning and simple interactive tools.

---

## 2.18 Comments and Documentation

### Single-Line Comments

```python
# This is a comment — Python ignores this line completely
server_count = 42  # Inline comment — explains this specific line
```

### Multi-Line Comments

```python
# Python has no true multi-line comment syntax.
# Convention: use multiple single-line comments.

# This block explains the purpose of the following code.
# We calculate the number of pods needed based on
# the current traffic and per-pod capacity.
```

### Docstrings (Documentation Strings)

```python
def calculate_pods(total_requests, capacity_per_pod):
    """
    Calculate the number of pods needed to handle traffic.

    Args:
        total_requests (int): Current request load.
        capacity_per_pod (int): Max requests each pod handles.

    Returns:
        int: Number of pods needed.
    """
    return total_requests // capacity_per_pod
```

### When to Comment and When Not To

```python
# ❌ BAD — Comment states what code obviously does
x = x + 1  # Increment x by 1

# ✅ GOOD — Comment explains WHY
x = x + 1  # Compensate for zero-based indexing in AWS API response
```

**Rule:** Comments explain **WHY**, not **WHAT**. The code shows what; the comment explains the reasoning.

---

## 2.19 Section Summary and Review

### What You Learned

| Topic | Key Takeaway |
|-------|-------------|
| Variables | Names (labels) pointing to objects, not boxes storing values |
| Internal model | Name → Object reference; `id()` shows memory address |
| Naming | snake_case for variables, UPPER_CASE for constants, never shadow builtins |
| int | Unlimited size whole numbers |
| float | Decimal numbers with precision limitations |
| str | Immutable text sequences; rich method library |
| bool | True/False; truthy/falsy values for any type |
| None | Intentional absence of value; check with `is None` |
| Type conversion | `int()`, `str()`, `float()`, `bool()` — know what can fail |
| Arithmetic ops | `+`, `-`, `*`, `/`, `//`, `%`, `**` |
| Comparison ops | `==`, `!=`, `>`, `<`, `>=`, `<=`; chaining allowed |
| Logical ops | `and`, `or`, `not`; short-circuit evaluation |
| Membership | `in`, `not in` |
| Identity | `is`, `is not` — only for None/singleton checks |
| f-Strings | `f"text {variable}"` — modern string formatting |
| input() | Always returns string; rarely used in production |

### Production Scenario Recap

> A monitoring script reads environment variables (always strings), converts them to appropriate types, compares server metrics against thresholds using comparison operators, combines conditions with logical operators, and formats alert messages using f-strings.

### Common Interview Questions

1. **Q: What is the difference between `==` and `is`?**
   A: `==` checks value equality. `is` checks identity (same object in memory). Use `is` only for `None` checks.

2. **Q: What are truthy and falsy values?**
   A: Every value in Python evaluates to True or False. Falsy: `0`, `0.0`, `""`, `[]`, `{}`, `()`, `None`, `False`. Everything else is truthy.

3. **Q: Why does `0.1 + 0.2 != 0.3` in Python?**
   A: Floating-point binary representation limitations. Use `math.isclose()` or `Decimal` for precision.

4. **Q: What is dynamic typing?**
   A: Variables can hold any type and change type at runtime without declaration.

5. **Q: How does Python store variables internally?**
   A: Python uses a name-object reference model. Variables are names pointing to objects. Multiple names can reference the same object.

### Practice Exercises

1. Create variables for a server: hostname, IP, port, CPU usage, memory usage, is_healthy
2. Calculate disk usage percentage from total and used values
3. Check if a port number is in the valid range (1-65535)
4. Parse the string `"192.168.1.100:8080"` to extract the IP and port separately
5. Create an f-string alert message using server metrics
6. Convert string `"True"` to boolean (careful — `bool("True")` is True, but so is `bool("False")`!)
7. Use `id()` to demonstrate that `a = b` makes them reference the same object

### Beginner Quiz (10 Questions)

1. What does `type("42")` return?
2. What is the output of `10 // 3`?
3. What is the output of `bool("")`?
4. How do you check if a variable is `None` correctly?
5. What does `+=` do?
6. What is the output of `"hello"[1:3]`?
7. What is the difference between `"` and `'` in Python strings?
8. What does `f"Count: {5 + 3}"` produce?
9. What is the output of `not True and False`?
10. What does `input()` always return?

<details>
<summary>Quiz Answers</summary>

1. `<class 'str'>` — it's a string containing digit characters
2. `3` — floor division rounds down
3. `False` — empty string is falsy
4. `if value is None:` — use `is`, not `==`
5. Adds and reassigns: `x += 3` means `x = x + 3`
6. `"el"` — index 1 (inclusive) to index 3 (exclusive)
7. No difference — both create strings
8. `"Count: 8"` — expressions are evaluated inside `{}`
9. `False` — `not True` = `False`, then `False and False` = `False`
10. A string (`str`) — always, regardless of what the user types

</details>

### Next Section Preview

**Section 3: Control Flow — Conditionals and Loops**

You will learn `if`, `elif`, `else` statements, `for` loops, `while` loops, `break`, `continue`, `pass`, `range()`, loop-else pattern, nested loops, and how Python uses **indentation** instead of braces to define code blocks. We'll cover real DevOps scenarios like health checks, retry logic, and iterating through server lists.

---

*Ready for Section 3? Let me know and I'll generate it.*
