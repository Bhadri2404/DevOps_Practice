# Section 5: Functions — Definition, Parameters, Return Values, and Scope

---

## 📑 Table of Contents

- [5.1 What Are Functions?](#51-what-are-functions)
- [5.2 Why Functions Exist](#52-why-functions-exist)
- [5.3 Defining and Calling Functions](#53-defining-and-calling-functions)
- [5.4 Parameters and Arguments](#54-parameters-and-arguments)
- [5.5 Default Parameters](#55-default-parameters)
- [5.6 Keyword Arguments and Positional Arguments](#56-keyword-arguments-and-positional-arguments)
- [5.7 *args — Variable Positional Arguments](#57-args--variable-positional-arguments)
- [5.8 **kwargs — Variable Keyword Arguments](#58-kwargs--variable-keyword-arguments)
- [5.9 Combining Parameter Types](#59-combining-parameter-types)
- [5.10 Return Values](#510-return-values)
- [5.11 Variable Scope — Local, Global, Enclosing](#511-variable-scope--local-global-enclosing)
- [5.12 The global and nonlocal Keywords](#512-the-global-and-nonlocal-keywords)
- [5.13 Functions Are First-Class Objects](#513-functions-are-first-class-objects)
- [5.14 Lambda Functions](#514-lambda-functions)
- [5.15 Docstrings and Type Hints](#515-docstrings-and-type-hints)
- [5.16 Nested Functions and Closures](#516-nested-functions-and-closures)
- [5.17 Common DevOps Function Patterns](#517-common-devops-function-patterns)
- [5.18 Section Summary and Review](#518-section-summary-and-review)

---

## 🎯 Learning Objectives

By the end of this section, you will:

1. Understand what functions are, why they exist, and what problems they solve
2. Define functions with `def`, call them, and understand execution flow
3. Master all parameter types: positional, keyword, default, *args, **kwargs
4. Understand return values, multiple returns, and when functions return None
5. Understand variable scope (LEGB rule) and why it prevents bugs
6. Use `global` and `nonlocal` keywords (and know when NOT to)
7. Understand functions as first-class objects (passing, storing, returning functions)
8. Write lambda functions for short operations
9. Write proper docstrings and use type hints
10. Apply functions to DevOps: health checks, retry wrappers, config builders, API callers

---

## 5.1 What Are Functions?

### Real-Life Analogy

Think of a **coffee machine**:
- You give it **inputs** (water, coffee beans, and a setting like "espresso")
- It performs a **process** (grinds, heats, pressurizes)
- It produces an **output** (a cup of espresso)

You don't need to know HOW the machine works internally. You just give inputs and get outputs. That's exactly what a function is — a reusable machine for processing data.

### Definition

A function is a **named, reusable block of code** that:
1. Takes in data (optional — called **parameters**)
2. Performs some operation
3. Returns a result (optional — called the **return value**)

```python
def make_coffee(bean_type, size):     # Parameters (inputs)
    result = f"{size} {bean_type}"    # Processing
    return result                      # Output
```

### What Problem Functions Solve

**Problem 1: Repetition (DRY — Don't Repeat Yourself)**

```python
# ❌ WITHOUT functions — repeating the same logic
print(f"Checking web-01... Status: healthy")
print(f"Logging result for web-01")
print(f"Checking web-02... Status: healthy")
print(f"Logging result for web-02")
print(f"Checking web-03... Status: healthy")
print(f"Logging result for web-03")

# ✅ WITH functions — write once, use many times
def check_server(hostname):
    print(f"Checking {hostname}... Status: healthy")
    print(f"Logging result for {hostname}")

check_server("web-01")
check_server("web-02")
check_server("web-03")
```

**Problem 2: Organization**

Without functions, a 1000-line script is one giant block — impossible to understand, debug, or modify. Functions break it into logical, named pieces.

**Problem 3: Abstraction**

```python
# The caller doesn't need to know HOW this works
result = deploy_service("api-gateway", "production", "v2.3.1")
```

You can use the function without understanding its 50 lines of internal logic.

**Problem 4: Testing**

You can't easily test a 500-line script. But you CAN test individual functions — each one does one thing and can be verified independently.

### Where Functions Are Used

| Context | Example |
|---------|---------|
| Health checks | `check_server_health(hostname)` |
| API calls | `fetch_metrics(endpoint, auth_token)` |
| Configuration | `build_config(environment, region)` |
| Deployment | `deploy_service(name, version, env)` |
| Data processing | `parse_log_line(raw_line)` |
| Alerts | `send_alert(channel, message, severity)` |
| Validation | `validate_yaml(file_path)` |

---

## 5.2 Why Functions Exist

### The Five Principles Functions Embody

```
┌──────────────────────────────────────────────────────────────┐
│                   WHY FUNCTIONS EXIST                          │
├──────────────────┬───────────────────────────────────────────┤
│  Principle       │  Meaning                                  │
├──────────────────┼───────────────────────────────────────────┤
│  Reusability     │  Write once, call many times              │
│  Abstraction     │  Hide complexity behind a name            │
│  Modularity      │  Break big problems into small pieces     │
│  Testability     │  Test each piece independently            │
│  Maintainability │  Change one function, not 50 locations    │
└──────────────────┴───────────────────────────────────────────┘
```

### The Maintenance Problem

Imagine you have code to connect to a database scattered in 15 places in your script. Now the database password changes. Without functions, you edit 15 places (and probably miss one). With a function:

```python
def get_db_connection():
    return connect(host="db.internal", port=5432, password="new_pass")
```

Change ONE place. All 15 callers automatically use the new password.

### The Collaboration Problem

In a team of 5 engineers:
- Engineer A writes `deploy_to_kubernetes()`
- Engineer B writes `run_tests()`
- Engineer C writes `send_notification()`

They work independently. Then the main script just calls:
```python
if run_tests():
    deploy_to_kubernetes()
    send_notification("Deployment successful")
```

Without functions, 5 engineers would be editing the same file, causing merge conflicts constantly.

---

## 5.3 Defining and Calling Functions

### Syntax

```python
def function_name(parameter1, parameter2):
    """Docstring: describes what the function does."""
    # Function body (indented)
    result = parameter1 + parameter2
    return result
```

### Breaking Down the Syntax

| Part | Purpose |
|------|---------|
| `def` | Keyword that tells Python "I'm defining a function" |
| `function_name` | The name you choose (snake_case convention) |
| `(parameter1, parameter2)` | Inputs the function accepts |
| `:` | Ends the function header, starts the body |
| Indented block | The function's code (body) |
| `return result` | Sends a value back to the caller |

### How Function Execution Works

```python
def greet(name):
    message = f"Hello, {name}!"
    return message

# Calling the function
result = greet("DevOps Engineer")
print(result)
```

**Execution flow:**

```
Line 1-3: Python READS the function definition and stores it.
           The body does NOT execute yet!

Line 5:   Python sees greet("DevOps Engineer")
           → Jumps INTO the function body
           → name = "DevOps Engineer" (parameter receives argument)
           → message = "Hello, DevOps Engineer!"
           → return message → sends "Hello, DevOps Engineer!" back
           → result = "Hello, DevOps Engineer!"

Line 6:   print(result) → "Hello, DevOps Engineer!"
```

```
┌─────────────────────────────────────────────────────┐
│  MAIN PROGRAM                                        │
│                                                      │
│  def greet(name):        ← Definition (stored only)  │
│      ...                                             │
│                                                      │
│  result = greet("DevOps")  ← Call: jumps to function │
│           │                         │                │
│           │    ┌────────────────────┘                │
│           │    ▼                                     │
│           │    ┌─────────────────────┐               │
│           │    │  name = "DevOps"    │               │
│           │    │  message = "Hello.."│               │
│           │    │  return message ────┼──┐            │
│           │    └─────────────────────┘  │            │
│           │                             │            │
│           ◄─────────────────────────────┘            │
│  result = "Hello, DevOps!"                           │
│  print(result)                                       │
└─────────────────────────────────────────────────────┘
```

### Critical Understanding: Definition vs Calling

```python
# This DEFINES the function (creates it, stores it). Nothing executes.
def restart_server(hostname):
    print(f"Restarting {hostname}...")
    print(f"{hostname} restarted successfully!")

# Nothing has happened yet! No output!

# This CALLS (invokes/executes) the function
restart_server("web-01")
```

**Output:**
```
Restarting web-01...
web-01 restarted successfully!
```

### Common Mistake: Calling Before Defining

```python
# ❌ Error — function doesn't exist yet when called
greet("Alice")      # NameError: name 'greet' is not defined

def greet(name):
    print(f"Hello, {name}")
```

Python reads top to bottom. The function must be defined **before** it's called.

### Functions Without Parameters

```python
def show_separator():
    print("=" * 50)

show_separator()    # Prints a line of 50 equal signs
```

### Functions Without Return

```python
def log_event(message):
    print(f"[LOG] {message}")
    # No return statement

result = log_event("Server started")
print(result)    # None ← Functions without return implicitly return None
```

---

## 5.4 Parameters and Arguments

### Terminology Clarification

These terms are often confused, even by experienced developers:

- **Parameter** = The variable name in the function DEFINITION (placeholder)
- **Argument** = The actual value passed when CALLING the function

```python
def greet(name):          # "name" is a PARAMETER (definition)
    print(f"Hello, {name}")

greet("Alice")            # "Alice" is an ARGUMENT (call)
```

**Analogy:** A parameter is like a blank on a form ("Name: ___"). An argument is what you fill in ("Name: Alice").

### Multiple Parameters

```python
def deploy_service(service_name, environment, version):
    print(f"Deploying {service_name} v{version} to {environment}")

deploy_service("api-gateway", "production", "2.3.1")
```

**Output:** `Deploying api-gateway v2.3.1 to production`

### How Arguments Are Passed

Python uses **pass-by-object-reference**:

- **Immutable objects** (int, str, tuple): The function gets its own reference. Modifying the parameter inside the function creates a new object — the original is unaffected.
- **Mutable objects** (list, dict, set): The function gets a reference to the SAME object. Modifications inside the function affect the original!

```python
# Immutable — original unaffected
def try_modify_string(text):
    text = text + " MODIFIED"    # Creates NEW string
    print(f"Inside: {text}")

original = "hello"
try_modify_string(original)
print(f"Outside: {original}")    # Still "hello"!

# Mutable — original IS affected!
def try_modify_list(items):
    items.append("NEW ITEM")     # Modifies the SAME list object

original_list = ["a", "b", "c"]
try_modify_list(original_list)
print(original_list)    # ["a", "b", "c", "NEW ITEM"] ← Changed!
```

### Why This Matters in DevOps

```python
# ⚠️ Dangerous — modifies the caller's data!
def remove_unhealthy(servers):
    for s in servers[:]:  # Iterate over a copy
        if s["status"] == "unhealthy":
            servers.remove(s)    # Modifies the original list!

# ✅ Safe — returns a new list
def get_healthy(servers):
    return [s for s in servers if s["status"] == "healthy"]
```

---

## 5.5 Default Parameters

### What They Are

Default parameters have a pre-set value that's used when the caller doesn't provide an argument.

### Why They Exist

Many functions have parameters that USUALLY have the same value. Without defaults, callers must always specify everything:

```python
# ❌ Without defaults — verbose every time
connect_to_db("myapp", "localhost", 5432, 30, True)

# ✅ With defaults — only specify what differs
connect_to_db("myapp")    # Uses defaults for host, port, timeout, ssl
```

### Syntax

```python
def connect_to_db(database, host="localhost", port=5432, timeout=30):
    print(f"Connecting to {database} at {host}:{port} (timeout={timeout}s)")

# Using all defaults
connect_to_db("myapp")
# Connecting to myapp at localhost:5432 (timeout=30s)

# Overriding some defaults
connect_to_db("myapp", host="db.production.internal", timeout=10)
# Connecting to myapp at db.production.internal:5432 (timeout=10s)
```

### Rule: Default Parameters Must Come LAST

```python
# ✅ Correct — defaults after non-defaults
def deploy(service, version, environment="staging"):
    pass

# ❌ Error — default before non-default
def deploy(service, environment="staging", version):
    pass
# SyntaxError: non-default argument follows default argument
```

### ⚠️ CRITICAL: The Mutable Default Argument Trap

This is one of the **most infamous Python gotchas** — it appears in interviews constantly:

```python
# ❌ DANGEROUS — mutable default argument
def add_server(server, server_list=[]):
    server_list.append(server)
    return server_list

print(add_server("web-01"))    # ["web-01"] ← Looks fine
print(add_server("web-02"))    # ["web-01", "web-02"] ← WRONG! Expected ["web-02"]
print(add_server("web-03"))    # ["web-01", "web-02", "web-03"] ← Keeps growing!
```

**Why?** The default list `[]` is created ONCE when the function is defined, not each time it's called. All calls share the same list object.

**The Fix:**

```python
# ✅ CORRECT — use None as default, create new list inside
def add_server(server, server_list=None):
    if server_list is None:
        server_list = []    # Fresh list each time
    server_list.append(server)
    return server_list

print(add_server("web-01"))    # ["web-01"]
print(add_server("web-02"))    # ["web-02"] ← Correct!
```

**Rule:** Never use mutable objects (lists, dicts, sets) as default parameter values. Use `None` and create the mutable inside the function.

---

## 5.6 Keyword Arguments and Positional Arguments

### Positional Arguments

Arguments matched by **position** (order matters):

```python
def create_user(username, role, region):
    print(f"User: {username}, Role: {role}, Region: {region}")

create_user("admin", "superuser", "us-east-1")
# Position 1 → username = "admin"
# Position 2 → role = "superuser"
# Position 3 → region = "us-east-1"
```

### Keyword Arguments

Arguments matched by **name** (order doesn't matter):

```python
create_user(region="eu-west-1", username="ops-bot", role="deployer")
# Same result regardless of order — matched by name
```

### Why Keyword Arguments Are Better for Complex Functions

```python
# ❌ Positional — what does True mean? What's 30? 5?
deploy("api-gateway", "production", "2.3.1", True, 30, 5, False)

# ✅ Keyword — crystal clear intent
deploy(
    service="api-gateway",
    environment="production",
    version="2.3.1",
    canary=True,
    timeout=30,
    replicas=5,
    dry_run=False
)
```

### Mixing Positional and Keyword

```python
def deploy(service, version, environment="staging", dry_run=False):
    action = "Would deploy" if dry_run else "Deploying"
    print(f"{action} {service} v{version} to {environment}")

# Positional first, then keyword
deploy("api", "2.0", environment="production", dry_run=True)
# "Would deploy api v2.0 to production"
```

**Rule:** Positional arguments must come BEFORE keyword arguments in the call:

```python
# ❌ Error
deploy(service="api", "2.0")
# SyntaxError: positional argument follows keyword argument
```

### Keyword-Only Arguments (Forcing Clarity)

You can force arguments to be keyword-only by placing them after `*`:

```python
def deploy(service, version, *, environment, dry_run=False):
    # Everything after * MUST be passed as keyword
    print(f"Deploy {service} v{version} to {environment}")

# ✅ Works
deploy("api", "2.0", environment="production")

# ❌ Error — environment must be keyword
deploy("api", "2.0", "production")
# TypeError: deploy() takes 2 positional arguments but 3 were given
```

This is a **production best practice** for functions with many parameters — it prevents order mistakes.

---

## 5.7 *args — Variable Positional Arguments

### What It Is

`*args` allows a function to accept **any number of positional arguments**. Inside the function, `args` is a tuple containing all the extra positional arguments.

### Why It Exists

Sometimes you don't know in advance how many arguments will be passed:

```python
# What if you need to restart 1, 5, or 100 servers?
def restart_servers(*hostnames):
    print(f"Restarting {len(hostnames)} servers...")
    for hostname in hostnames:
        print(f"  🔄 Restarting {hostname}")

restart_servers("web-01")
restart_servers("web-01", "web-02", "web-03")
restart_servers("db-01", "db-02", "cache-01", "api-01", "worker-01")
```

**Output (third call):**
```
Restarting 5 servers...
  🔄 Restarting db-01
  🔄 Restarting db-02
  🔄 Restarting cache-01
  🔄 Restarting api-01
  🔄 Restarting worker-01
```

### How It Works Internally

```python
def show_args(*args):
    print(f"Type: {type(args)}")    # <class 'tuple'>
    print(f"Value: {args}")
    print(f"Count: {len(args)}")

show_args(1, "hello", True, 3.14)
```

**Output:**
```
Type: <class 'tuple'>
Value: (1, 'hello', True, 3.14)
Count: 4
```

All positional arguments are collected into a **tuple** named `args`.

### Mixing *args with Regular Parameters

```python
def deploy(environment, *services):
    print(f"Deploying to {environment}:")
    for service in services:
        print(f"  → {service}")

deploy("production", "api", "web", "worker")
```

**Output:**
```
Deploying to production:
  → api
  → web
  → worker
```

`environment` gets "production" (first argument), everything else goes into `services`.

### The Name "args" Is Just a Convention

```python
# You can use any name after *
def example(*servers):     # Valid
    pass

def example(*items):       # Valid
    pass

# But "args" is the standard convention when there's no specific meaning
def example(*args):        # Convention
    pass
```

### Unpacking a List into *args

```python
def add(a, b, c):
    return a + b + c

numbers = [1, 2, 3]

# ❌ Error — passing one list, not three numbers
add(numbers)    # TypeError: add() missing 2 required positional arguments

# ✅ Unpack the list with *
add(*numbers)    # Same as add(1, 2, 3) → returns 6
```

---

## 5.8 **kwargs — Variable Keyword Arguments

### What It Is

`**kwargs` allows a function to accept **any number of keyword arguments**. Inside the function, `kwargs` is a dictionary containing all the extra keyword arguments.

### Why It Exists

When you need to pass flexible configuration or metadata:

```python
def create_ec2_instance(instance_type, **tags):
    print(f"Creating {instance_type} instance")
    print(f"Tags: {tags}")

create_ec2_instance(
    "t3.medium",
    Name="web-server-01",
    Environment="production",
    Team="platform",
    CostCenter="engineering"
)
```

**Output:**
```
Creating t3.medium instance
Tags: {'Name': 'web-server-01', 'Environment': 'production', 'Team': 'platform', 'CostCenter': 'engineering'}
```

### How It Works Internally

```python
def show_kwargs(**kwargs):
    print(f"Type: {type(kwargs)}")    # <class 'dict'>
    print(f"Value: {kwargs}")

show_kwargs(name="Alice", age=30, role="SRE")
```

**Output:**
```
Type: <class 'dict'>
Value: {'name': 'Alice', 'age': 30, 'role': 'SRE'}
```

### Practical DevOps Example: Flexible Logger

```python
def log_event(message, severity="INFO", **metadata):
    print(f"[{severity}] {message}")
    if metadata:
        for key, value in metadata.items():
            print(f"  {key}: {value}")

log_event(
    "Deployment completed",
    severity="INFO",
    service="api-gateway",
    version="2.3.1",
    environment="production",
    duration_seconds=45
)
```

**Output:**
```
[INFO] Deployment completed
  service: api-gateway
  version: 2.3.1
  environment: production
  duration_seconds: 45
```

### Unpacking a Dictionary into **kwargs

```python
def create_server(hostname, ip, port):
    print(f"Server: {hostname} at {ip}:{port}")

config = {"hostname": "web-01", "ip": "10.0.0.1", "port": 8080}

# ❌ Error — passing one dict, not three arguments
create_server(config)

# ✅ Unpack dict with **
create_server(**config)    # Same as create_server(hostname="web-01", ip="10.0.0.1", port=8080)
```

This pattern is **extremely common** in DevOps when reading configs from YAML/JSON and passing them to functions.

---

## 5.9 Combining Parameter Types

### The Order Rule

When combining different parameter types, they MUST appear in this order:

```python
def function(positional, default=value, *args, keyword_only, **kwargs):
    pass
```

```
┌─────────────────────────────────────────────────────────────────┐
│  ORDER:                                                          │
│  1. Regular positional parameters                                │
│  2. Parameters with default values                               │
│  3. *args (variable positional)                                  │
│  4. Keyword-only parameters (after * or *args)                   │
│  5. **kwargs (variable keyword — ALWAYS LAST)                    │
└─────────────────────────────────────────────────────────────────┘
```

### Complete Example

```python
def deploy(
    service,                    # 1. Required positional
    version="latest",           # 2. Default value
    *extra_configs,             # 3. *args
    environment,                # 4. Keyword-only (after *args)
    dry_run=False,              # 4. Keyword-only with default
    **metadata                  # 5. **kwargs (always last)
):
    print(f"Service: {service}")
    print(f"Version: {version}")
    print(f"Extra configs: {extra_configs}")
    print(f"Environment: {environment}")
    print(f"Dry run: {dry_run}")
    print(f"Metadata: {metadata}")

deploy(
    "api-gateway",                    # service
    "2.3.1",                          # version
    "--enable-canary", "--verbose",   # extra_configs (*args)
    environment="production",          # keyword-only
    dry_run=True,                      # keyword-only
    team="platform",                   # metadata (**kwargs)
    ticket="DEPLOY-1234"              # metadata (**kwargs)
)
```

**Output:**
```
Service: api-gateway
Version: 2.3.1
Extra configs: ('--enable-canary', '--verbose')
Environment: production
Dry run: True
Metadata: {'team': 'platform', 'ticket': 'DEPLOY-1234'}
```

### Interview Tip

> **Q: What is the order of parameters in a Python function?**
>
> A: Positional → Default → *args → Keyword-only → **kwargs. Memory aid: "Please Don't Argue, Kids Keep quiet."

---

## 5.10 Return Values

### What return Does

`return` does two things:
1. **Sends a value back** to the caller
2. **Immediately exits** the function (no code after return executes)

```python
def add(a, b):
    result = a + b
    return result
    print("This NEVER runs")    # Dead code — after return

total = add(5, 3)    # total = 8
```

### Functions Without return (Implicit None)

```python
def greet(name):
    print(f"Hello, {name}")
    # No return statement

result = greet("Alice")
print(result)    # None
```

Every function without an explicit `return` returns `None` implicitly.

### Early Return (Guard Clauses)

```python
def get_server_status(hostname):
    if not hostname:
        return "ERROR: No hostname provided"    # Exit early
    
    if hostname.startswith("legacy"):
        return "DEPRECATED"    # Exit early
    
    # Only reach here if hostname is valid and not legacy
    # ... perform actual health check ...
    return "HEALTHY"
```

This pattern avoids deep nesting and makes code easier to follow.

### Returning Multiple Values

Python functions can return multiple values using tuples:

```python
def get_server_metrics(hostname):
    # Simulated metrics
    cpu = 78.5
    memory = 85.2
    disk = 62.0
    return cpu, memory, disk    # Returns a tuple: (78.5, 85.2, 62.0)

# Unpack the tuple
cpu, memory, disk = get_server_metrics("web-01")
print(f"CPU: {cpu}%, Memory: {memory}%, Disk: {disk}%")
```

### Returning Different Types Based on Conditions

```python
def find_server(name, inventory):
    """Returns server dict if found, None if not."""
    for server in inventory:
        if server["name"] == name:
            return server    # Returns a dict
    return None              # Explicitly return None when not found

# Caller checks the result
result = find_server("web-01", servers)
if result is not None:
    print(f"Found: {result['ip']}")
else:
    print("Server not found")
```

### Common Mistake: Forgetting to Use the Return Value

```python
def calculate_pods(requests, capacity):
    return requests // capacity

# ❌ Calling but not capturing the result
calculate_pods(1000, 200)    # Result is lost!

# ✅ Capture the returned value
pods = calculate_pods(1000, 200)
print(pods)    # 5
```

### Common Mistake: print() vs return

```python
# ❌ This PRINTS but doesn't RETURN — can't use the result
def add_bad(a, b):
    print(a + b)

result = add_bad(5, 3)    # Prints "8" but result is None!
total = result * 2         # TypeError: NoneType * int

# ✅ This RETURNS — caller can use the result
def add_good(a, b):
    return a + b

result = add_good(5, 3)   # result = 8
total = result * 2         # 16
```

**Rule for beginners:** If you'll need the result elsewhere, use `return`. If you just want side effects (printing, logging, writing to file), then `print()` inside is fine.

---

## 5.11 Variable Scope — Local, Global, Enclosing

### What Is Scope?

Scope determines **where a variable can be seen and accessed**. It prevents variables in one part of code from accidentally interfering with variables in another part.

### Real-Life Analogy

Think of scope like **rooms in a house**:
- A **local variable** is something inside your bedroom — only visible there
- A **global variable** is something in the living room — visible from anywhere in the house
- You can LOOK at the living room from your bedroom (read globals)
- But if you create something with the same name in your bedroom, it doesn't affect the living room

### The LEGB Rule

Python resolves variable names by looking in this order:

```
┌───────────────────────────────────────────────────┐
│  L — Local        (inside the current function)    │
│  E — Enclosing    (inside enclosing/outer function)│
│  G — Global       (module level / top of file)     │
│  B — Built-in     (Python's built-in names)        │
└───────────────────────────────────────────────────┘

Python searches L → E → G → B (stops at first match)
```

### Local Scope

Variables created inside a function exist ONLY inside that function:

```python
def check_health():
    status = "healthy"    # Local variable — exists only here
    print(status)         # ✅ Works

check_health()
print(status)             # ❌ NameError: name 'status' is not defined
```

### Global Scope

Variables created at the top level of a file (outside all functions):

```python
MAX_RETRIES = 5    # Global variable

def attempt_connection():
    print(f"Max retries: {MAX_RETRIES}")    # ✅ Can READ global

attempt_connection()    # Prints "Max retries: 5"
```

### Reading vs Modifying Globals Inside Functions

```python
counter = 0    # Global

def increment():
    counter = counter + 1    # ❌ UnboundLocalError!

increment()
```

**Why the error?** When Python sees `counter = ...` inside the function, it assumes `counter` is a **local** variable. But then `counter + 1` tries to read it before it's assigned locally → error.

**Key Rule:** You can READ a global variable from inside a function. But the moment you ASSIGN to it (using `=`), Python treats it as a new local variable.

### Demonstration of LEGB

```python
x = "global"         # G — Global scope

def outer():
    x = "enclosing"  # E — Enclosing scope
    
    def inner():
        x = "local"  # L — Local scope
        print(x)     # "local" (found at L, stops searching)
    
    inner()
    print(x)         # "enclosing" (inner's x is separate)

outer()
print(x)             # "global" (outer's x is separate)
```

**Output:**
```
local
enclosing
global
```

Each function has its own `x` — they don't interfere with each other.

### Why Scope Exists

Without scope, every variable would be global. In a 10,000-line program with 200 functions, you'd constantly have variable name collisions. A variable `i` in one loop would overwrite `i` in another function. Chaos.

---

## 5.12 The global and nonlocal Keywords

### The global Keyword

Forces Python to treat a variable inside a function as the global one (not create a local copy):

```python
deployment_count = 0    # Global

def record_deployment():
    global deployment_count    # "I mean the global one, not a new local"
    deployment_count += 1

record_deployment()
record_deployment()
record_deployment()
print(deployment_count)    # 3
```

### ⚠️ When to Use global (Almost Never)

`global` is considered **bad practice** in almost all cases. It makes code:
- Hard to debug (any function could modify the value)
- Hard to test (functions depend on external state)
- Unpredictable (race conditions in multi-threaded code)

**Instead, use return values and parameters:**

```python
# ❌ BAD — using global
count = 0
def increment():
    global count
    count += 1

# ✅ GOOD — using return values
def increment(count):
    return count + 1

count = 0
count = increment(count)
count = increment(count)
```

### The nonlocal Keyword

Used in nested functions to modify a variable from the enclosing (outer) function:

```python
def make_counter():
    count = 0    # Enclosing scope variable
    
    def increment():
        nonlocal count    # "I mean the enclosing function's count"
        count += 1
        return count
    
    return increment

counter = make_counter()
print(counter())    # 1
print(counter())    # 2
print(counter())    # 3
```

This is the foundation of **closures** — covered later in this section.

---

## 5.13 Functions Are First-Class Objects

### What This Means

In Python, functions are **objects** just like strings, integers, or lists. This means you can:

1. **Assign a function to a variable**
2. **Pass a function as an argument to another function**
3. **Return a function from another function**
4. **Store functions in data structures (lists, dicts)**

### Why This Matters

This enables powerful patterns: callbacks, strategy pattern, decorators, plugin systems, and event handlers.

### 1. Assign to a Variable

```python
def greet(name):
    return f"Hello, {name}"

# Assign function to a new variable (NO parentheses = don't call it!)
say_hi = greet    # say_hi now references the same function object

print(say_hi("Alice"))    # "Hello, Alice"
print(greet("Alice"))     # "Hello, Alice" — same thing
```

**Critical:** `greet` (no parentheses) is the function object itself. `greet()` (with parentheses) CALLS the function.

### 2. Pass as Argument (Callbacks)

```python
def apply_to_servers(servers, action):
    """Apply a function to each server."""
    for server in servers:
        action(server)    # Call whatever function was passed

def restart(server):
    print(f"🔄 Restarting {server}")

def stop(server):
    print(f"⛔ Stopping {server}")

servers = ["web-01", "web-02", "web-03"]

apply_to_servers(servers, restart)    # Pass function as argument
print()
apply_to_servers(servers, stop)
```

**Output:**
```
🔄 Restarting web-01
🔄 Restarting web-02
🔄 Restarting web-03

⛔ Stopping web-01
⛔ Stopping web-02
⛔ Stopping web-03
```

### 3. Store in Data Structures

```python
def deploy():
    print("Deploying...")

def rollback():
    print("Rolling back...")

def notify():
    print("Sending notification...")

# Strategy pattern — actions stored in a dictionary
actions = {
    "deploy": deploy,
    "rollback": rollback,
    "notify": notify
}

# Execute by name
user_choice = "rollback"
actions[user_choice]()    # Calls rollback()
```

### 4. Return from Another Function

```python
def get_formatter(format_type):
    def json_format(data):
        return f'{{"data": "{data}"}}'
    
    def plain_format(data):
        return str(data)
    
    if format_type == "json":
        return json_format    # Return the function (not calling it!)
    else:
        return plain_format

formatter = get_formatter("json")
print(formatter("hello"))    # {"data": "hello"}
```

---

## 5.14 Lambda Functions

### What They Are

A lambda is an **anonymous (nameless), single-expression function** written in one line. It's syntactic sugar for simple functions.

### Syntax

```python
lambda parameters: expression
```

### Comparison with Regular Functions

```python
# Regular function
def square(x):
    return x ** 2

# Lambda equivalent
square = lambda x: x ** 2

# Both work the same way
print(square(5))    # 25
```

### Why Lambdas Exist

They're useful as **short throwaway functions** passed to other functions:

```python
servers = [
    {"name": "web-01", "cpu": 78},
    {"name": "db-01", "cpu": 92},
    {"name": "cache-01", "cpu": 45},
]

# Sort by CPU usage (without lambda — need a named function)
def get_cpu(server):
    return server["cpu"]

sorted_servers = sorted(servers, key=get_cpu)

# Sort by CPU usage (with lambda — cleaner for simple cases)
sorted_servers = sorted(servers, key=lambda s: s["cpu"])
print([s["name"] for s in sorted_servers])
# ['cache-01', 'web-01', 'db-01']
```

### Common Use Cases

```python
# 1. Sorting with custom key
ports = [8080, 443, 80, 3000, 22]
sorted_ports = sorted(ports)    # [22, 80, 443, 3000, 8080]

# 2. Filtering
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
evens = list(filter(lambda x: x % 2 == 0, numbers))
print(evens)    # [2, 4, 6, 8, 10]

# 3. Transforming
names = ["web-01", "db-01", "cache-01"]
upper = list(map(lambda s: s.upper(), names))
print(upper)    # ['WEB-01', 'DB-01', 'CACHE-01']
```

### When NOT to Use Lambdas

```python
# ❌ Too complex for a lambda
process = lambda x: x.strip().lower().replace("-", "_") if x and len(x) > 3 else "invalid"

# ✅ Use a regular function — much more readable
def process(x):
    if not x or len(x) <= 3:
        return "invalid"
    return x.strip().lower().replace("-", "_")
```

**Rule:** If a lambda doesn't fit on one readable line, use a regular function. Lambdas are for simple, obvious transformations only.

### Lambda Limitations

1. Only ONE expression (no statements, no assignments, no loops)
2. No docstrings
3. Hard to debug (no name in tracebacks)
4. Assigning `func = lambda ...` is worse than `def func(...)`

---

## 5.15 Docstrings and Type Hints

### Docstrings

A docstring is a string at the very beginning of a function (or class/module) that documents what it does:

```python
def calculate_pod_count(total_requests, capacity_per_pod, min_pods=2):
    """
    Calculate the number of pods needed to handle current traffic.
    
    Determines the optimal pod count based on incoming request volume
    and per-pod capacity, ensuring at least min_pods are running.
    
    Args:
        total_requests (int): Current requests per second.
        capacity_per_pod (int): Maximum RPS each pod can handle.
        min_pods (int): Minimum number of pods to maintain. Defaults to 2.
    
    Returns:
        int: Number of pods to deploy.
    
    Raises:
        ValueError: If total_requests or capacity_per_pod is negative.
    
    Example:
        >>> calculate_pod_count(1000, 200)
        5
        >>> calculate_pod_count(100, 200)
        2  # min_pods enforced
    """
    if total_requests < 0 or capacity_per_pod <= 0:
        raise ValueError("Requests and capacity must be positive")
    
    needed = max(total_requests // capacity_per_pod, min_pods)
    return needed
```

### Accessing Docstrings

```python
# In REPL or code
print(calculate_pod_count.__doc__)

# Or use help()
help(calculate_pod_count)
```

### Type Hints (Python 3.5+)

Type hints tell developers (and tools) what types a function expects and returns:

```python
def deploy_service(
    service_name: str,
    version: str,
    replicas: int = 3,
    dry_run: bool = False
) -> dict:
    """Deploy a service and return deployment status."""
    result = {
        "service": service_name,
        "version": version,
        "replicas": replicas,
        "status": "dry_run" if dry_run else "deployed"
    }
    return result
```

### Key Facts About Type Hints

1. **They are NOT enforced at runtime** — Python won't raise errors for wrong types
2. They are for **documentation and tooling** (IDEs, mypy, pylint)
3. They make code **self-documenting**
4. They enable **IDE autocomplete** (your editor knows what type to expect)

### Common Type Hints

```python
from typing import List, Dict, Optional, Tuple, Union

def get_servers() -> List[str]:
    return ["web-01", "web-02"]

def get_config() -> Dict[str, str]:
    return {"host": "localhost", "port": "5432"}

def find_server(name: str) -> Optional[dict]:
    # Returns dict or None
    pass

def get_metrics() -> Tuple[float, float, float]:
    return (78.5, 85.2, 62.0)

def process_input(value: Union[str, int]) -> str:
    return str(value)
```

### Production Best Practice

```python
# ✅ Production-quality function signature
def create_ec2_instance(
    instance_type: str,
    ami_id: str,
    subnet_id: str,
    security_groups: List[str],
    tags: Dict[str, str],
    dry_run: bool = False
) -> Optional[str]:
    """
    Create an EC2 instance with the specified configuration.
    
    Returns:
        Instance ID if successful, None if dry_run or failure.
    """
    pass
```

---

## 5.16 Nested Functions and Closures

### Nested Functions

A function defined inside another function:

```python
def create_greeting(greeting_word):
    
    def greet(name):    # Nested (inner) function
        return f"{greeting_word}, {name}!"
    
    return greet    # Return the inner function

hello = create_greeting("Hello")
hi = create_greeting("Hi")

print(hello("Alice"))    # "Hello, Alice!"
print(hi("Bob"))         # "Hi, Bob!"
```

### What Is a Closure?

A closure is a nested function that **remembers the variables from its enclosing scope** even after the outer function has finished executing.

In the example above:
- `create_greeting("Hello")` finishes running
- But `hello` (the returned inner function) still remembers `greeting_word = "Hello"`
- That "remembered" variable is the closure

### Why Closures Matter in DevOps

```python
def make_logger(service_name):
    """Create a logger function pre-configured with a service name."""
    
    def log(message, level="INFO"):
        print(f"[{level}] [{service_name}] {message}")
    
    return log

# Create specialized loggers
api_log = make_logger("api-gateway")
db_log = make_logger("database")

api_log("Request received")           # [INFO] [api-gateway] Request received
api_log("Timeout!", level="ERROR")    # [ERROR] [api-gateway] Timeout!
db_log("Connection pool at 80%")      # [INFO] [database] Connection pool at 80%
```

Each logger "remembers" its service name without passing it every time.

### Closure for Retry with Configuration

```python
def make_retry(max_attempts, delay_seconds):
    """Create a retry function with pre-configured settings."""
    
    def retry(action_name):
        for attempt in range(1, max_attempts + 1):
            print(f"  Attempt {attempt}/{max_attempts}: {action_name}")
            # In reality, you'd try the action here
            success = (attempt == max_attempts)  # Simulated
            if success:
                print(f"  ✅ {action_name} succeeded!")
                return True
            print(f"  ❌ Failed. Waiting {delay_seconds}s...")
        return False
    
    return retry

# Create different retry policies
aggressive_retry = make_retry(max_attempts=5, delay_seconds=1)
conservative_retry = make_retry(max_attempts=3, delay_seconds=10)

aggressive_retry("Connect to cache")
```

---

## 5.17 Common DevOps Function Patterns

### Pattern 1: Health Check Function

```python
def check_server_health(hostname: str, port: int = 80, timeout: int = 5) -> dict:
    """
    Check if a server is healthy by simulating an HTTP check.
    
    Returns:
        dict with keys: hostname, status, response_time
    """
    import random
    
    # Simulated health check
    response_time = random.uniform(0.1, 2.0)
    is_healthy = response_time < timeout and random.random() > 0.1
    
    return {
        "hostname": hostname,
        "port": port,
        "status": "healthy" if is_healthy else "unhealthy",
        "response_time_ms": round(response_time * 1000, 2)
    }

# Usage
servers = ["web-01", "web-02", "web-03", "db-01"]
results = [check_server_health(s) for s in servers]

healthy = [r for r in results if r["status"] == "healthy"]
print(f"Healthy: {len(healthy)}/{len(results)}")
```

### Pattern 2: Retry Wrapper

```python
import time

def retry(func, max_attempts=3, delay=2, backoff=2):
    """
    Retry a function with exponential backoff.
    
    Args:
        func: Callable to retry (takes no arguments)
        max_attempts: Maximum number of attempts
        delay: Initial delay between retries (seconds)
        backoff: Multiplier for delay after each failure
    
    Returns:
        The function's return value if successful
    
    Raises:
        Exception: The last exception if all attempts fail
    """
    current_delay = delay
    last_exception = None
    
    for attempt in range(1, max_attempts + 1):
        try:
            result = func()
            print(f"  ✅ Succeeded on attempt {attempt}")
            return result
        except Exception as e:
            last_exception = e
            print(f"  ❌ Attempt {attempt} failed: {e}")
            if attempt < max_attempts:
                print(f"     Retrying in {current_delay}s...")
                time.sleep(current_delay)
                current_delay *= backoff
    
    raise last_exception
```

### Pattern 3: Configuration Builder

```python
def build_deployment_config(
    service: str,
    environment: str,
    version: str = "latest",
    replicas: int = None,
    **overrides
) -> dict:
    """Build a deployment configuration with environment-specific defaults."""
    
    # Environment-specific defaults
    env_defaults = {
        "production": {"replicas": 5, "cpu_limit": "2000m", "memory_limit": "4Gi"},
        "staging":    {"replicas": 2, "cpu_limit": "1000m", "memory_limit": "2Gi"},
        "development": {"replicas": 1, "cpu_limit": "500m", "memory_limit": "1Gi"},
    }
    
    defaults = env_defaults.get(environment, env_defaults["development"])
    
    config = {
        "service": service,
        "environment": environment,
        "version": version,
        "replicas": replicas or defaults["replicas"],
        "resources": {
            "cpu_limit": defaults["cpu_limit"],
            "memory_limit": defaults["memory_limit"]
        }
    }
    
    # Apply any overrides
    config.update(overrides)
    
    return config

# Usage
prod_config = build_deployment_config(
    "api-gateway",
    "production",
    version="2.3.1",
    replicas=10,    # Override default
    canary_percentage=10
)
print(prod_config)
```

### Pattern 4: Validation Function

```python
def validate_server_config(config: dict) -> tuple:
    """
    Validate a server configuration dictionary.
    
    Returns:
        Tuple of (is_valid: bool, errors: list)
    """
    errors = []
    required_fields = ["hostname", "ip", "port", "environment"]
    
    # Check required fields
    for field in required_fields:
        if field not in config:
            errors.append(f"Missing required field: {field}")
    
    # Validate IP format (simple check)
    if "ip" in config:
        parts = config["ip"].split(".")
        if len(parts) != 4:
            errors.append(f"Invalid IP format: {config['ip']}")
    
    # Validate port range
    if "port" in config:
        port = config["port"]
        if not isinstance(port, int) or port < 1 or port > 65535:
            errors.append(f"Invalid port: {port} (must be 1-65535)")
    
    # Validate environment
    valid_envs = {"production", "staging", "development"}
    if "environment" in config and config["environment"] not in valid_envs:
        errors.append(f"Invalid environment: {config['environment']}")
    
    is_valid = len(errors) == 0
    return is_valid, errors

# Usage
config = {"hostname": "web-01", "ip": "10.0.0.1", "port": 8080, "environment": "production"}
is_valid, errors = validate_server_config(config)

if is_valid:
    print("✅ Configuration is valid")
else:
    print("❌ Configuration errors:")
    for error in errors:
        print(f"  - {error}")
```

---

## 5.18 Section Summary and Review

### What You Learned

| Topic | Key Takeaway |
|-------|-------------|
| Functions | Named, reusable code blocks that take inputs and produce outputs |
| def keyword | Defines a function; body doesn't execute until called |
| Parameters vs arguments | Parameters = definition placeholders; arguments = actual values passed |
| Default parameters | Pre-set values; never use mutable defaults (use None instead) |
| Positional vs keyword | Positional = by order; keyword = by name (more readable) |
| *args | Collects extra positional arguments into a tuple |
| **kwargs | Collects extra keyword arguments into a dict |
| Return values | `return` sends data back; without it, function returns None |
| Scope (LEGB) | Local → Enclosing → Global → Built-in lookup order |
| global/nonlocal | Modify outer scope variables (avoid global in production) |
| First-class functions | Functions are objects — pass, store, return them |
| Lambda | Anonymous single-expression functions for simple cases |
| Docstrings | Document purpose, parameters, return values |
| Type hints | Declare expected types (not enforced, aids tooling) |
| Closures | Inner functions remembering enclosing scope variables |

### Production Scenario Recap

> A deployment automation system uses:
> - **Health check functions** with default parameters for timeout/port
> - **Retry wrappers** using closures to remember retry configuration
> - **Config builders** with `**kwargs` for flexible override passing
> - **Validation functions** returning tuples of (success, errors)
> - **Type hints** for IDE support and documentation
> - **Docstrings** for team collaboration

### Common Interview Questions

1. **Q: What is the difference between *args and **kwargs?**
   A: `*args` collects extra positional arguments into a tuple. `**kwargs` collects extra keyword arguments into a dictionary. They allow functions to accept a variable number of arguments.

2. **Q: What is the mutable default argument problem?**
   A: Default mutable objects (list, dict) are created once at function definition time and shared across all calls. Fix: use `None` as default and create a new mutable inside the function.

3. **Q: Explain Python's LEGB scope rule.**
   A: Python looks up variables in order: Local (current function) → Enclosing (outer function) → Global (module level) → Built-in (Python's builtins). First match wins.

4. **Q: What is a closure?**
   A: A nested function that remembers and has access to variables from its enclosing function's scope, even after the outer function has finished executing.

5. **Q: What does it mean that functions are first-class objects?**
   A: Functions can be assigned to variables, passed as arguments, returned from other functions, and stored in data structures — just like any other object.

6. **Q: What is the difference between return and print?**
   A: `return` sends a value back to the caller (can be used in expressions). `print` displays output to the console (returns None). Use `return` when you need the result; `print` for display only.

### Practice Exercises

1. Write a function `is_port_open(host, port, timeout=3)` that returns True/False (simulated)
2. Write a function that accepts `**kwargs` and builds a formatted server summary string
3. Write a function using `*args` to calculate the average of any number of metrics
4. Write a `build_url(protocol, host, port, path)` function with sensible defaults
5. Write a closure `make_threshold_checker(threshold)` that returns a function checking if a value exceeds that threshold
6. Refactor a 20-line script into 3-4 focused functions
7. Add type hints and a docstring to any function you've written

### Beginner Quiz (10 Questions)

1. What keyword defines a function in Python?
2. What does a function return if there's no `return` statement?
3. Can you pass a function as an argument to another function?
4. What is the difference between a parameter and an argument?
5. In what order must combined parameters appear?
6. What type is `*args` inside a function?
7. What type is `**kwargs` inside a function?
8. What does LEGB stand for?
9. Why should you never use `[]` or `{}` as a default parameter?
10. What is the output of `(lambda x, y: x + y)(3, 4)`?

<details>
<summary>Quiz Answers</summary>

1. `def`
2. `None` — implicitly returned
3. Yes — functions are first-class objects
4. Parameter = variable in function definition; argument = value passed during call
5. Positional → Default → *args → Keyword-only → **kwargs
6. `tuple`
7. `dict`
8. Local, Enclosing, Global, Built-in (variable lookup order)
9. The mutable object is created once and shared across all calls, leading to unexpected state accumulation
10. `7` — lambda creates an anonymous function that adds its two arguments

</details>

### Next Section Preview

**Section 6: Error Handling — Exceptions, try/except, and Defensive Programming**

You will learn what exceptions are, why errors happen, Python's exception hierarchy, try/except/else/finally blocks, raising custom exceptions, built-in exception types, traceback reading, defensive programming, the EAFP vs LBYL philosophies, and how production systems handle errors gracefully without crashing.

---

*Ready for Section 6? Let me know and I'll generate it.*
