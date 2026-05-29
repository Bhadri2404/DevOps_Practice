# Section 6: Error Handling — Exceptions, try/except, and Defensive Programming

---

## 📑 Table of Contents

- [6.1 What Are Exceptions?](#61-what-are-exceptions)
- [6.2 Why Error Handling Exists](#62-why-error-handling-exists)
- [6.3 Python's Exception Hierarchy](#63-pythons-exception-hierarchy)
- [6.4 Common Built-in Exceptions](#64-common-built-in-exceptions)
- [6.5 Reading Tracebacks](#65-reading-tracebacks)
- [6.6 try/except — Basic Exception Handling](#66-tryexcept--basic-exception-handling)
- [6.7 Catching Specific Exceptions](#67-catching-specific-exceptions)
- [6.8 Multiple except Blocks](#68-multiple-except-blocks)
- [6.9 The else Clause](#69-the-else-clause)
- [6.10 The finally Clause](#610-the-finally-clause)
- [6.11 The Complete try/except/else/finally Structure](#611-the-complete-tryexceptelsefinally-structure)
- [6.12 Raising Exceptions](#612-raising-exceptions)
- [6.13 Custom Exceptions](#613-custom-exceptions)
- [6.14 Exception Chaining](#614-exception-chaining)
- [6.15 EAFP vs LBYL — Two Philosophies](#615-eafp-vs-lbyl--two-philosophies)
- [6.16 Best Practices for Production Error Handling](#616-best-practices-for-production-error-handling)
- [6.17 Common DevOps Error Handling Patterns](#617-common-devops-error-handling-patterns)
- [6.18 Section Summary and Review](#618-section-summary-and-review)

---

## 🎯 Learning Objectives

By the end of this section, you will:

1. Understand what exceptions are and why they happen
2. Read and interpret Python tracebacks confidently
3. Know all common built-in exception types and when they occur
4. Write try/except/else/finally blocks correctly
5. Catch specific exceptions vs broad exceptions (and why it matters)
6. Raise exceptions intentionally for validation and error signaling
7. Create custom exception classes
8. Understand EAFP vs LBYL philosophies
9. Implement production-grade error handling patterns
10. Apply error handling to DevOps: API failures, timeouts, file operations, connections

---

## 6.1 What Are Exceptions?

### Real-Life Analogy

Imagine you're following a recipe:
1. Preheat oven to 350°F
2. Mix flour and sugar
3. Add eggs
4. **Bake for 30 minutes**

But what if the oven is **broken**? The recipe didn't plan for that. You encounter an **exceptional situation** — something unexpected that prevents normal execution.

In Python, when something goes wrong during execution, Python creates an **exception object** describing what went wrong. If your code doesn't handle it, the program crashes.

### Definition

An exception is an **event that disrupts the normal flow of a program**. When Python encounters a situation it can't handle (dividing by zero, opening a missing file, accessing a non-existent key), it:

1. Creates an exception object (with details about what went wrong)
2. Searches for code that handles this type of exception
3. If found → executes the handler, program continues
4. If NOT found → program crashes with a traceback

### Errors vs Exceptions

| Term | Meaning |
|------|---------|
| **Syntax Error** | Code is written incorrectly — Python can't even START running it |
| **Exception** | Code is valid but something goes wrong DURING execution |

```python
# Syntax Error — caught before running (parsing phase)
print("hello"    # SyntaxError: unexpected EOF — missing closing parenthesis

# Exception — caught during running (execution phase)
x = 10 / 0       # ZeroDivisionError — valid syntax, but impossible operation
```

### What Happens Without Error Handling

```python
servers = ["web-01", "web-02", "web-03"]
print(servers[5])    # IndexError: list index out of range
print("This line NEVER runs — program already crashed")
```

The program immediately stops. In a DevOps script monitoring 500 servers, one bad server entry would kill the entire monitoring — unacceptable.

---

## 6.2 Why Error Handling Exists

### The Core Problem

In the real world, things fail constantly:
- Network connections time out
- Files get deleted unexpectedly
- APIs return error responses
- Databases become unreachable
- Disks run out of space
- Permissions get revoked
- DNS resolution fails

**A production system that crashes at the first sign of trouble is useless.**

### What Error Handling Provides

```
┌──────────────────────────────────────────────────────────────┐
│              WITHOUT ERROR HANDLING                            │
│                                                               │
│  Script starts → processes server 1 → processes server 2 →   │
│  server 3 fails → CRASH! → servers 4-500 never checked       │
└──────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────┐
│              WITH ERROR HANDLING                               │
│                                                               │
│  Script starts → processes server 1 → processes server 2 →   │
│  server 3 fails → LOG THE ERROR → continue →                 │
│  processes server 4 → ... → processes server 500 →           │
│  Final report: "499 succeeded, 1 failed (server 3)"          │
└──────────────────────────────────────────────────────────────┘
```

### The Five Goals of Error Handling

1. **Graceful degradation** — Handle the error and continue if possible
2. **Meaningful feedback** — Tell the user/operator WHAT went wrong and WHY
3. **Resource cleanup** — Close files, connections, locks even when things fail
4. **Logging for debugging** — Record errors for later investigation
5. **Recovery** — Retry, use fallback, or fail safely

---

## 6.3 Python's Exception Hierarchy

### How Exceptions Are Organized

Python exceptions form a class hierarchy (inheritance tree). This matters because when you catch a parent exception, you automatically catch all its children:

```
BaseException
├── SystemExit                  (sys.exit() was called)
├── KeyboardInterrupt           (Ctrl+C pressed)
├── GeneratorExit               (generator closed)
└── Exception                   ← Almost everything you'll catch
    ├── StopIteration
    ├── ArithmeticError
    │   ├── ZeroDivisionError
    │   ├── OverflowError
    │   └── FloatingPointError
    ├── AttributeError
    ├── EOFError
    ├── ImportError
    │   └── ModuleNotFoundError
    ├── LookupError
    │   ├── IndexError
    │   └── KeyError
    ├── NameError
    │   └── UnboundLocalError
    ├── OSError
    │   ├── FileNotFoundError
    │   ├── PermissionError
    │   ├── TimeoutError
    │   ├── ConnectionError
    │   │   ├── ConnectionRefusedError
    │   │   ├── ConnectionResetError
    │   │   └── ConnectionAbortedError
    │   └── FileExistsError
    ├── TypeError
    ├── ValueError
    │   └── UnicodeError
    └── RuntimeError
        └── RecursionError
```

### Why the Hierarchy Matters

```python
# Catching the parent catches all children
try:
    result = some_lookup()
except LookupError:
    # Catches BOTH IndexError AND KeyError
    print("Lookup failed")

# Being specific catches only one
try:
    result = my_dict["missing_key"]
except KeyError:
    # Catches ONLY KeyError, not IndexError
    print("Key not found")
```

### Critical Rule: Never Catch BaseException

```python
# ❌ NEVER DO THIS — catches Ctrl+C and sys.exit()!
try:
    long_running_process()
except BaseException:
    pass    # User can't even kill the program with Ctrl+C!

# ✅ Catch Exception (not BaseException)
try:
    long_running_process()
except Exception:
    print("Something went wrong")
    # User can still Ctrl+C to kill the program
```

---

## 6.4 Common Built-in Exceptions

### The Exceptions You'll See Most Often

| Exception | When It Happens | Example |
|-----------|-----------------|---------|
| `TypeError` | Wrong type used | `"hello" + 5` |
| `ValueError` | Right type, wrong value | `int("abc")` |
| `KeyError` | Dict key doesn't exist | `d["missing"]` |
| `IndexError` | List index out of range | `[1,2,3][5]` |
| `AttributeError` | Object doesn't have that attribute | `"hi".append("x")` |
| `NameError` | Variable not defined | `print(undefined_var)` |
| `FileNotFoundError` | File doesn't exist | `open("missing.txt")` |
| `PermissionError` | No permission to access | `open("/etc/shadow")` |
| `ConnectionError` | Network connection failed | API/DB unreachable |
| `TimeoutError` | Operation took too long | Slow API response |
| `ImportError` | Module can't be imported | `import nonexistent` |
| `ZeroDivisionError` | Division by zero | `10 / 0` |
| `StopIteration` | Iterator exhausted | `next()` on empty iterator |
| `RuntimeError` | Generic runtime problem | Various situations |

### Examples of Each

```python
# TypeError — operation on incompatible types
result = "servers: " + 5
# TypeError: can only concatenate str (not "int") to str

# ValueError — correct type but invalid value
port = int("not_a_number")
# ValueError: invalid literal for int() with base 10: 'not_a_number'

# KeyError — missing dictionary key
config = {"host": "localhost"}
db_name = config["database"]
# KeyError: 'database'

# IndexError — list index out of range
servers = ["web-01", "web-02"]
print(servers[10])
# IndexError: list index out of range

# FileNotFoundError
with open("/tmp/nonexistent_file.conf") as f:
    data = f.read()
# FileNotFoundError: [Errno 2] No such file or directory

# AttributeError — object doesn't have method/property
x = 42
x.append(5)
# AttributeError: 'int' object has no attribute 'append'

# ZeroDivisionError
pods_needed = total_requests // 0
# ZeroDivisionError: integer division or modulo by zero
```

---

## 6.5 Reading Tracebacks

### What Is a Traceback?

When an unhandled exception occurs, Python prints a **traceback** — a detailed report showing exactly where and why the error happened.

### Anatomy of a Traceback

```python
# File: deploy.py
def get_server_ip(servers, hostname):
    return servers[hostname]

def deploy(hostname):
    servers = {"web-01": "10.0.0.1", "web-02": "10.0.0.2"}
    ip = get_server_ip(servers, hostname)
    print(f"Deploying to {ip}")

deploy("db-01")
```

**Traceback output:**
```
Traceback (most recent call last):
  File "deploy.py", line 9, in <module>
    deploy("db-01")
  File "deploy.py", line 6, in deploy
    ip = get_server_ip(servers, hostname)
  File "deploy.py", line 2, in get_server_ip
    return servers[hostname]
KeyError: 'db-01'
```

### How to Read It (BOTTOM TO TOP)

```
┌─────────────────────────────────────────────────────────────┐
│  READ FROM BOTTOM TO TOP:                                    │
│                                                              │
│  1. LAST LINE: The exception type and message                │
│     KeyError: 'db-01'                                        │
│     → We tried to access key 'db-01' but it doesn't exist   │
│                                                              │
│  2. LINE ABOVE: Where it happened                            │
│     File "deploy.py", line 2, in get_server_ip               │
│     return servers[hostname]                                  │
│     → This specific line caused the error                    │
│                                                              │
│  3. ABOVE THAT: What called it (the call stack)              │
│     File "deploy.py", line 6, in deploy                      │
│     → deploy() called get_server_ip()                        │
│                                                              │
│  4. TOP: Where it all started                                │
│     File "deploy.py", line 9, in <module>                    │
│     → The script called deploy("db-01")                      │
└─────────────────────────────────────────────────────────────┘
```

### Debugging Strategy

1. **Read the last line first** — what type of error and what value caused it
2. **Read the line above** — which exact line of code caused it
3. **Trace upward** — understand how you got there
4. **Fix the root cause** — not the symptom

### Common Beginner Mistake: Only Reading the First Line

Beginners often see "Traceback (most recent call last)" and panic. **The useful information is at the BOTTOM.** Always start reading from the bottom.

---

## 6.6 try/except — Basic Exception Handling

### What It Does

`try/except` wraps code that might fail, and provides a fallback when it does:

```python
try:
    # Code that MIGHT raise an exception
    risky_code()
except SomeException:
    # Code that runs IF that exception occurs
    handle_error()
```

### How It Works

```
┌──────────────────────┐
│  Enter try block     │
│  Execute line by line│
└──────────┬───────────┘
           │
     ┌─────┴─────┐
     │           │
  No Error    Exception!
     │           │
     ▼           ▼
┌─────────┐  ┌──────────────────┐
│ Skip    │  │ Stop try block   │
│ except  │  │ Jump to except   │
│ block   │  │ Execute handler  │
└─────────┘  └──────────────────┘
     │           │
     └─────┬─────┘
           ▼
    Continue program...
```

### Simple Example

```python
# Without error handling — CRASHES
servers = {"web-01": "10.0.0.1", "web-02": "10.0.0.2"}
ip = servers["db-01"]    # KeyError → program dies

# With error handling — GRACEFUL
servers = {"web-01": "10.0.0.1", "web-02": "10.0.0.2"}

try:
    ip = servers["db-01"]
    print(f"Found IP: {ip}")
except KeyError:
    print("⚠️  Server not found in inventory")
    ip = None

print(f"Program continues... IP = {ip}")
```

**Output:**
```
⚠️  Server not found in inventory
Program continues... IP = None
```

### Accessing the Exception Object

```python
try:
    port = int("not_a_number")
except ValueError as e:    # 'e' holds the exception object
    print(f"Error type: {type(e).__name__}")
    print(f"Error message: {e}")
```

**Output:**
```
Error type: ValueError
Error message: invalid literal for int() with base 10: 'not_a_number'
```

The `as e` clause gives you access to the exception object — useful for logging the exact error message.

---

## 6.7 Catching Specific Exceptions

### Why Specific Is Better Than Broad

```python
# ❌ BAD — catches EVERYTHING, hides real bugs
try:
    result = process_data(data)
except Exception:
    print("Something went wrong")
    # Was it a typo in your code? A missing file? A network error?
    # You have NO idea. Bugs are hidden silently.

# ✅ GOOD — catches only what you expect
try:
    result = process_data(data)
except FileNotFoundError:
    print("Configuration file missing — using defaults")
    result = default_config
except ConnectionError:
    print("Cannot reach API — will retry")
    result = None
```

### The Bare except Anti-Pattern

```python
# ❌ NEVER DO THIS — catches KeyboardInterrupt, SystemExit, everything!
try:
    something()
except:    # Bare except — no exception type specified
    pass   # Silently swallows ALL errors including Ctrl+C

# If you truly must catch broadly, at minimum use Exception:
try:
    something()
except Exception as e:
    print(f"Unexpected error: {e}")
    # At least you see what happened
```

### Why Catching Too Broadly Is Dangerous

```python
# Real-world disaster scenario
def get_server_count(config):
    try:
        return config["server_count"]    # KeyError if missing
    except Exception:    # Catches everything!
        return 0

# Programmer makes a typo:
def get_server_count(config):
    try:
        return config["server_counnt"]    # TYPO! But error is swallowed!
    except Exception:
        return 0    # Always returns 0, programmer thinks config is empty
```

The broad `except` hid a typo bug. With `except KeyError`, the `NameError` from the typo would NOT be caught, and you'd see the actual bug immediately.

---

## 6.8 Multiple except Blocks

### Handling Different Errors Differently

```python
def read_config_value(config, key):
    """Read and convert a config value to integer."""
    try:
        raw_value = config[key]            # Might raise KeyError
        return int(raw_value)              # Might raise ValueError/TypeError
    except KeyError:
        print(f"⚠️  Config key '{key}' not found — using default")
        return 0
    except ValueError:
        print(f"⚠️  Config value for '{key}' is not a valid number")
        return 0
    except TypeError:
        print(f"⚠️  Config value for '{key}' has unexpected type")
        return 0

config = {"port": "8080", "timeout": "fast", "retries": "3"}
print(read_config_value(config, "port"))       # 8080
print(read_config_value(config, "timeout"))    # ⚠️  not valid number → 0
print(read_config_value(config, "missing"))    # ⚠️  not found → 0
```

### Catching Multiple Exceptions in One Block

When you want the same handler for multiple exception types:

```python
try:
    value = config[key]
    result = process(value)
except (KeyError, ValueError, TypeError) as e:
    # Same handler for all three
    print(f"⚠️  Configuration error ({type(e).__name__}): {e}")
    result = default_value
```

### Order Matters: Specific Before General

```python
# ✅ CORRECT — specific first, general last
try:
    data = fetch_data()
except ConnectionRefusedError:
    print("Server is not accepting connections")
except ConnectionError:
    print("General connection problem")
except OSError:
    print("OS-level error")
except Exception:
    print("Unexpected error")

# ❌ WRONG — general catches everything, specific never reached
try:
    data = fetch_data()
except Exception:
    print("Something failed")    # Always catches here!
except ConnectionError:
    print("Connection problem")  # NEVER reached!
```

Python checks except blocks top to bottom. The first matching handler wins. Since `Exception` is a parent of `ConnectionError`, it matches first.

---

## 6.9 The else Clause

### What It Does

The `else` block runs **only if the try block completed successfully** (no exception was raised).

```python
try:
    result = risky_operation()
except SomeError:
    handle_error()
else:
    # Only runs if NO exception occurred in try
    use_result(result)
```

### Why else Exists (Not Just Putting Code in try)

```python
# ❌ Problem: too much code in try block
try:
    data = fetch_from_api()         # This might fail
    processed = transform(data)     # If THIS fails, the except hides it!
    save_to_database(processed)     # If THIS fails too!
except ConnectionError:
    print("API unreachable")
    # But what if transform() or save_to_database() had a bug?
    # Their errors are hidden by the same except!

# ✅ Solution: only risky code in try, rest in else
try:
    data = fetch_from_api()         # Only the risky part
except ConnectionError:
    print("API unreachable")
    data = None
else:
    # Only runs if fetch succeeded — errors here are NOT caught
    processed = transform(data)
    save_to_database(processed)
```

**Key Insight:** Code in `else` is NOT protected by the except blocks. If it raises an exception, it will propagate normally. This is intentional — you only want to catch EXPECTED errors, not hide bugs.

### DevOps Example

```python
def read_server_config(filepath):
    try:
        with open(filepath) as f:
            raw_content = f.read()
    except FileNotFoundError:
        print(f"⚠️  Config file not found: {filepath}")
        return None
    except PermissionError:
        print(f"🔒 No permission to read: {filepath}")
        return None
    else:
        # File was read successfully — parse it
        # If parsing fails, that's a different problem (don't catch it here)
        config = parse_yaml(raw_content)
        print(f"✅ Config loaded: {len(config)} settings")
        return config
```

---

## 6.10 The finally Clause

### What It Does

The `finally` block **ALWAYS runs**, regardless of whether an exception occurred or not. It runs if:
- try succeeded
- except caught an error
- an unhandled error is propagating
- return was called in try or except
- break/continue in a loop

### Why It Exists: Resource Cleanup

```python
# Without finally — connection might never close!
connection = open_db_connection()
try:
    data = connection.query("SELECT * FROM servers")
    process(data)
except DatabaseError:
    print("Query failed")
# What if an UNEXPECTED error occurs? Connection stays open forever!

# With finally — connection ALWAYS closes
connection = open_db_connection()
try:
    data = connection.query("SELECT * FROM servers")
    process(data)
except DatabaseError:
    print("Query failed")
finally:
    connection.close()    # ALWAYS runs, no matter what happened above
    print("Connection closed")
```

### Demonstration: finally Always Runs

```python
def risky_function():
    try:
        print("1. Trying...")
        result = 10 / 0    # Raises ZeroDivisionError
        print("2. This never runs")
    except ZeroDivisionError:
        print("3. Caught the error!")
        return "error_result"    # Even with return...
    finally:
        print("4. Finally ALWAYS runs!")    # ...finally still executes!

output = risky_function()
print(f"5. Got: {output}")
```

**Output:**
```
1. Trying...
3. Caught the error!
4. Finally ALWAYS runs!
5. Got: error_result
```

Notice: `finally` ran even though `return` was called in the `except` block.

### Common Use Cases for finally

| Resource | Cleanup in finally |
|----------|-------------------|
| File | `file.close()` |
| Database connection | `connection.close()` |
| Network socket | `socket.close()` |
| Lock | `lock.release()` |
| Temporary file | `os.remove(temp_file)` |

**Note:** In modern Python, `with` statements (context managers) handle most of these cases more elegantly. We'll cover those in a later section.

---

## 6.11 The Complete try/except/else/finally Structure

### Full Syntax

```python
try:
    # Code that might raise an exception
    risky_operation()
except SpecificError as e:
    # Handle expected error
    handle_error(e)
except AnotherError as e:
    # Handle another type of error
    handle_other_error(e)
else:
    # Runs ONLY if try succeeded (no exception)
    on_success()
finally:
    # ALWAYS runs, regardless of what happened
    cleanup()
```

### Execution Flow Diagram

```
                    ┌────────────────┐
                    │   try block    │
                    └───────┬────────┘
                            │
                ┌───────────┴───────────┐
                │                       │
          No Exception              Exception!
                │                       │
                ▼                       ▼
        ┌──────────────┐       ┌──────────────┐
        │  else block  │       │ except block │
        │  (success)   │       │  (handler)   │
        └──────┬───────┘       └──────┬───────┘
               │                      │
               └──────────┬───────────┘
                          │
                          ▼
                  ┌──────────────┐
                  │finally block │
                  │  (ALWAYS)    │
                  └──────────────┘
                          │
                          ▼
                   Continue program
```

### Complete Production Example

```python
import json

def load_deployment_config(filepath):
    """Load and validate a deployment configuration file."""
    config = None
    
    try:
        with open(filepath, 'r') as f:
            raw_content = f.read()
    
    except FileNotFoundError:
        print(f"❌ Config file not found: {filepath}")
        print("   Using default configuration")
        config = {"replicas": 1, "environment": "development"}
    
    except PermissionError:
        print(f"🔒 Permission denied: {filepath}")
        print("   Run with appropriate permissions")
        config = None
    
    else:
        # File was read successfully — parse JSON
        try:
            config = json.loads(raw_content)
            print(f"✅ Config loaded successfully ({len(config)} keys)")
        except json.JSONDecodeError as e:
            print(f"❌ Invalid JSON in {filepath}: {e}")
            config = None
    
    finally:
        print(f"📋 Config loading complete. Result: {'Success' if config else 'Failed'}")
    
    return config

# Usage
config = load_deployment_config("deploy.json")
```

---

## 6.12 Raising Exceptions

### What raise Does

`raise` intentionally creates an exception. Use it when your code detects a situation that shouldn't be allowed to continue.

### Why You'd Raise Exceptions

Functions should **fail loudly** when given invalid inputs rather than silently producing wrong results:

```python
# ❌ BAD — silently produces wrong result
def calculate_pods(requests, capacity):
    if capacity == 0:
        return 0    # Wrong! Should be an error!
    return requests // capacity

# ✅ GOOD — fails loudly
def calculate_pods(requests, capacity):
    if capacity <= 0:
        raise ValueError(f"capacity must be positive, got {capacity}")
    if requests < 0:
        raise ValueError(f"requests cannot be negative, got {requests}")
    return requests // capacity
```

### Syntax

```python
# Raise with a message
raise ValueError("Port must be between 1 and 65535")

# Raise without a message (less useful)
raise TypeError

# Re-raise the current exception (in an except block)
except SomeError as e:
    log_error(e)
    raise    # Re-raises the same exception after logging
```

### Validation Pattern

```python
def deploy_service(service_name, environment, replicas):
    """Deploy a service with validation."""
    
    # Input validation
    if not isinstance(service_name, str) or not service_name.strip():
        raise ValueError("service_name must be a non-empty string")
    
    valid_environments = {"production", "staging", "development"}
    if environment not in valid_environments:
        raise ValueError(
            f"Invalid environment '{environment}'. "
            f"Must be one of: {valid_environments}"
        )
    
    if not isinstance(replicas, int) or replicas < 1:
        raise ValueError(f"replicas must be a positive integer, got {replicas}")
    
    if environment == "production" and replicas < 2:
        raise ValueError("Production requires at least 2 replicas for HA")
    
    # If we get here, all validation passed
    print(f"✅ Deploying {service_name} to {environment} with {replicas} replicas")

# Valid call
deploy_service("api-gateway", "production", 5)    # ✅ Works

# Invalid calls
deploy_service("", "production", 5)          # ❌ ValueError: non-empty string
deploy_service("api", "testing", 5)          # ❌ ValueError: invalid environment
deploy_service("api", "production", 1)       # ❌ ValueError: at least 2 replicas
```

### Re-raising Exceptions (Log and Propagate)

```python
def connect_to_database(host, port):
    try:
        # Simulated connection
        if host == "unreachable":
            raise ConnectionError(f"Cannot connect to {host}:{port}")
        return f"Connection to {host}:{port}"
    except ConnectionError as e:
        # Log the error for debugging
        print(f"[ERROR] Database connection failed: {e}")
        # Re-raise so the caller knows it failed
        raise    # ← Propagates the SAME exception upward
```

The caller will still see the `ConnectionError` — you just added logging before passing it on.

---

## 6.13 Custom Exceptions

### Why Create Custom Exceptions?

Built-in exceptions are generic. In a large project, you want exceptions that are:
- **Specific to your domain** (DeploymentError, ServerNotFoundError)
- **Carry additional context** (which server, what was attempted)
- **Easy to catch selectively** (catch only YOUR errors, not all ValueErrors)

### Basic Custom Exception

```python
class DeploymentError(Exception):
    """Raised when a deployment operation fails."""
    pass

class ServerNotFoundError(Exception):
    """Raised when a server cannot be found in inventory."""
    pass

class ConfigValidationError(Exception):
    """Raised when configuration validation fails."""
    pass
```

### Custom Exception with Extra Context

```python
class DeploymentError(Exception):
    """Raised when a deployment operation fails."""
    
    def __init__(self, service, environment, reason):
        self.service = service
        self.environment = environment
        self.reason = reason
        # Create a readable message for the parent Exception class
        message = f"Failed to deploy '{service}' to {environment}: {reason}"
        super().__init__(message)

# Raising it
def deploy(service, environment):
    # ... deployment logic ...
    if not health_check_passed:
        raise DeploymentError(
            service=service,
            environment=environment,
            reason="Health check failed after deployment"
        )

# Catching it
try:
    deploy("api-gateway", "production")
except DeploymentError as e:
    print(f"❌ {e}")
    print(f"   Service: {e.service}")
    print(f"   Environment: {e.environment}")
    print(f"   Reason: {e.reason}")
    # Can take specific action based on the context
    if e.environment == "production":
        trigger_rollback(e.service)
```

### Exception Hierarchy for a Project

```python
# Base exception for your project
class InfraError(Exception):
    """Base exception for all infrastructure errors."""
    pass

# Specific exceptions inherit from the base
class ServerError(InfraError):
    """Server-related errors."""
    pass

class NetworkError(InfraError):
    """Network-related errors."""
    pass

class DeploymentError(InfraError):
    """Deployment-related errors."""
    pass

class ConfigError(InfraError):
    """Configuration-related errors."""
    pass

# Now callers can catch broadly or specifically:
try:
    perform_deployment()
except DeploymentError:
    # Handle only deployment issues
    pass
except InfraError:
    # Handle ANY infrastructure error
    pass
```

---

## 6.14 Exception Chaining

### What It Is

When one exception causes another, Python lets you link them together so you can see the full story.

### Implicit Chaining (During Handler)

If an exception occurs inside an `except` block, Python automatically chains them:

```python
try:
    config = load_config()
except FileNotFoundError:
    # This line itself might fail!
    backup = load_backup_config()    # If this ALSO fails...
```

### Explicit Chaining with `raise ... from ...`

```python
def get_database_url():
    try:
        with open("/etc/app/db.conf") as f:
            return f.read().strip()
    except FileNotFoundError as original:
        raise ConfigError(
            "Database configuration not found. "
            "Ensure /etc/app/db.conf exists."
        ) from original    # Chains the original exception

# Traceback shows BOTH:
# FileNotFoundError: [Errno 2] No such file or directory: '/etc/app/db.conf'
#
# The above exception was the direct cause of the following exception:
#
# ConfigError: Database configuration not found. Ensure /etc/app/db.conf exists.
```

This gives operators the full picture: what the user-facing error is AND what caused it.

### Suppressing Chaining with `from None`

```python
try:
    value = int(user_input)
except ValueError:
    raise ValidationError("Input must be a number") from None
    # Only shows ValidationError, hides the original ValueError
```

---

## 6.15 EAFP vs LBYL — Two Philosophies

### LBYL: Look Before You Leap

Check if something will work BEFORE trying it:

```python
# LBYL — Check first, then act
if "hostname" in config:
    hostname = config["hostname"]
else:
    hostname = "default"

if os.path.exists(filepath):
    with open(filepath) as f:
        data = f.read()
else:
    data = ""
```

### EAFP: Easier to Ask Forgiveness than Permission

Try it and handle the failure if it happens:

```python
# EAFP — Try it, handle failure
try:
    hostname = config["hostname"]
except KeyError:
    hostname = "default"

try:
    with open(filepath) as f:
        data = f.read()
except FileNotFoundError:
    data = ""
```

### Python Prefers EAFP

Python's culture strongly favors EAFP because:

1. **Race conditions** — Between checking and acting, the state might change:
   ```python
   # LBYL — RACE CONDITION!
   if os.path.exists("file.txt"):    # File exists NOW
       # Another process deletes it HERE
       with open("file.txt") as f:    # FileNotFoundError!
           data = f.read()
   
   # EAFP — No race condition
   try:
       with open("file.txt") as f:
           data = f.read()
   except FileNotFoundError:
       data = ""
   ```

2. **Performance** — In Python, exceptions are cheap. Checking first is an extra operation when failure is rare.

3. **Cleaner code** — Often shorter and more direct.

### When LBYL Is Better

- When the check is simple and failure is common:
  ```python
  # If 50% of requests have no 'auth' key, checking first is cleaner
  auth_token = headers.get("auth", None)  # LBYL via .get()
  ```

- When the "try" operation has side effects you can't undo:
  ```python
  # Don't try deploying and then ask forgiveness!
  if validate_config(config):    # Check first
      deploy(config)             # Expensive/irreversible action
  ```

---

## 6.16 Best Practices for Production Error Handling

### 1. Catch Specific Exceptions

```python
# ❌ Too broad
except Exception:
    pass

# ✅ Specific
except (ConnectionError, TimeoutError) as e:
    logger.error(f"Network issue: {e}")
```

### 2. Never Silently Swallow Errors

```python
# ❌ Silent failure — you'll never know something broke
try:
    process_data()
except Exception:
    pass

# ✅ At minimum, log the error
try:
    process_data()
except Exception as e:
    logger.error(f"Failed to process data: {e}", exc_info=True)
```

### 3. Keep try Blocks Small

```python
# ❌ Too much code in try — which line failed?
try:
    config = load_config()
    connection = connect_to_db(config)
    data = query_data(connection)
    result = process_data(data)
    save_result(result)
except Exception as e:
    print(f"Something failed: {e}")    # But WHAT?

# ✅ Small, focused try blocks
config = load_config()    # Let this fail naturally if miscoded

try:
    connection = connect_to_db(config)
except ConnectionError as e:
    logger.error(f"DB connection failed: {e}")
    sys.exit(1)

try:
    data = query_data(connection)
except DatabaseError as e:
    logger.error(f"Query failed: {e}")
    data = []
```

### 4. Use Context Managers for Resource Cleanup

```python
# ✅ Better than try/finally for file operations
with open("config.yaml") as f:
    config = yaml.safe_load(f)
# File is automatically closed, even if an exception occurs
```

### 5. Fail Fast with Validation

```python
def deploy(config):
    """Validate early, fail fast."""
    # Validate ALL inputs first — before doing any real work
    if not config.get("service"):
        raise ConfigError("Missing 'service' in config")
    if not config.get("environment"):
        raise ConfigError("Missing 'environment' in config")
    if config["environment"] not in ("production", "staging", "development"):
        raise ConfigError(f"Invalid environment: {config['environment']}")
    
    # Only proceed if everything is valid
    _do_deployment(config)
```

### 6. Include Context in Error Messages

```python
# ❌ Useless error message
raise ValueError("Invalid value")

# ✅ Helpful error message
raise ValueError(
    f"Invalid port number: {port}. "
    f"Expected integer between 1 and 65535, got {type(port).__name__}: {port}"
)
```

### 7. Use Logging Instead of Print

```python
import logging

logger = logging.getLogger(__name__)

try:
    connection = connect(host, port)
except ConnectionError as e:
    # ❌ print() — lost when running as a service
    print(f"Connection failed: {e}")
    
    # ✅ logging — captured, timestamped, configurable
    logger.error(f"Connection to {host}:{port} failed: {e}", exc_info=True)
```

---

## 6.17 Common DevOps Error Handling Patterns

### Pattern 1: Retry with Exception Handling

```python
import time

def retry_operation(func, max_retries=3, delay=2, backoff=2, 
                    retryable_exceptions=(ConnectionError, TimeoutError)):
    """
    Retry a function with exponential backoff.
    Only retries on specified exception types.
    """
    last_exception = None
    current_delay = delay
    
    for attempt in range(1, max_retries + 1):
        try:
            result = func()
            return result    # Success!
        except retryable_exceptions as e:
            last_exception = e
            if attempt == max_retries:
                print(f"❌ All {max_retries} attempts failed")
                raise  # Re-raise on final failure
            print(f"⚠️  Attempt {attempt} failed: {e}")
            print(f"   Retrying in {current_delay}s...")
            time.sleep(current_delay)
            current_delay *= backoff
        except Exception as e:
            # Non-retryable error — fail immediately
            print(f"❌ Non-retryable error: {e}")
            raise

# Usage
def connect_to_api():
    import random
    if random.random() < 0.7:
        raise ConnectionError("Connection refused")
    return {"status": "connected"}

result = retry_operation(connect_to_api, max_retries=5, delay=1)
```

### Pattern 2: Graceful Batch Processing

```python
def process_servers(server_list):
    """Process all servers, collecting errors without stopping."""
    results = {"success": [], "failed": []}
    
    for server in server_list:
        try:
            # Attempt to process each server
            status = check_health(server)
            results["success"].append({"server": server, "status": status})
        except ConnectionError as e:
            results["failed"].append({
                "server": server,
                "error": "unreachable",
                "details": str(e)
            })
        except TimeoutError as e:
            results["failed"].append({
                "server": server,
                "error": "timeout",
                "details": str(e)
            })
        except Exception as e:
            results["failed"].append({
                "server": server,
                "error": "unexpected",
                "details": str(e)
            })
    
    # Summary
    total = len(server_list)
    success = len(results["success"])
    failed = len(results["failed"])
    print(f"\n{'='*40}")
    print(f"Results: {success}/{total} succeeded, {failed}/{total} failed")
    
    if results["failed"]:
        print("\nFailed servers:")
        for failure in results["failed"]:
            print(f"  ❌ {failure['server']}: {failure['error']} — {failure['details']}")
    
    return results
```

### Pattern 3: Configuration Loading with Fallbacks

```python
import json
import os

def load_config():
    """Load config with cascading fallback sources."""
    
    # Try source 1: Environment variable pointing to config file
    config_path = os.environ.get("APP_CONFIG_PATH")
    if config_path:
        try:
            with open(config_path) as f:
                config = json.load(f)
                print(f"✅ Config loaded from {config_path}")
                return config
        except (FileNotFoundError, json.JSONDecodeError) as e:
            print(f"⚠️  Failed to load from {config_path}: {e}")
    
    # Try source 2: Default config file location
    default_path = "/etc/myapp/config.json"
    try:
        with open(default_path) as f:
            config = json.load(f)
            print(f"✅ Config loaded from {default_path}")
            return config
    except FileNotFoundError:
        print(f"⚠️  Default config not found: {default_path}")
    except json.JSONDecodeError as e:
        print(f"❌ Invalid JSON in {default_path}: {e}")
    
    # Fallback: Hardcoded defaults
    print("⚠️  Using hardcoded default configuration")
    return {
        "host": "localhost",
        "port": 8080,
        "log_level": "INFO",
        "max_retries": 3
    }
```

### Pattern 4: Safe Cleanup on Failure

```python
def deploy_with_rollback(service, version, environment):
    """Deploy with automatic rollback on failure."""
    
    previous_version = get_current_version(service, environment)
    print(f"Current version: {previous_version}")
    print(f"Deploying {service} v{version} to {environment}...")
    
    try:
        # Step 1: Pull new image
        pull_image(service, version)
        
        # Step 2: Update deployment
        update_deployment(service, version, environment)
        
        # Step 3: Wait for health check
        wait_for_healthy(service, environment, timeout=120)
        
        print(f"✅ Deployment successful: {service} v{version}")
    
    except Exception as e:
        print(f"❌ Deployment failed: {e}")
        print(f"🔄 Rolling back to v{previous_version}...")
        
        try:
            update_deployment(service, previous_version, environment)
            wait_for_healthy(service, environment, timeout=60)
            print(f"✅ Rollback successful: {service} v{previous_version}")
        except Exception as rollback_error:
            print(f"🚨 CRITICAL: Rollback also failed: {rollback_error}")
            print("   Manual intervention required!")
            send_pager_alert(service, environment, str(e))
        
        # Re-raise original error
        raise
```

---

## 6.18 Section Summary and Review

### What You Learned

| Topic | Key Takeaway |
|-------|-------------|
| Exceptions | Events that disrupt normal flow; handled or program crashes |
| Exception hierarchy | Parent catches children; catch specific, not broad |
| Tracebacks | Read bottom-to-top; last line = error type + message |
| try/except | Wrap risky code; provide error handler |
| Specific catching | Always name the exception type; never bare except |
| Multiple except | Handle different errors differently; order matters |
| else clause | Runs only on success; keeps try blocks small |
| finally clause | Always runs; use for cleanup (close connections/files) |
| raise | Intentionally signal errors; validate inputs loudly |
| Custom exceptions | Domain-specific errors with extra context |
| Exception chaining | `raise X from Y` links cause and effect |
| EAFP vs LBYL | Python prefers try/except over check-first |
| Best practices | Specific, logged, contextual, small try blocks |

### Production Scenario Recap

> A deployment automation system:
> - **Validates** all inputs upfront with `raise ValueError` (fail fast)
> - **Retries** network operations with exponential backoff (catch `ConnectionError`)
> - **Processes batches** without stopping on individual failures (collect errors)
> - **Loads configuration** with cascading fallbacks (try/except chain)
> - **Rolls back** on deployment failure using try/except/finally
> - **Logs** all errors with context using the `logging` module
> - **Defines custom exceptions** (`DeploymentError`, `ConfigError`) for clarity

### Common Interview Questions

1. **Q: What is the difference between `except Exception` and bare `except`?**
   A: `except Exception` catches all standard exceptions but NOT `SystemExit`, `KeyboardInterrupt`, or `GeneratorExit`. Bare `except:` catches absolutely everything including those, making it impossible to Ctrl+C the program. Always use `except Exception` at minimum.

2. **Q: When does the `else` clause in try/except execute?**
   A: Only when the `try` block completes without raising any exception. It's useful for code that should run on success but shouldn't be protected by the except blocks.

3. **Q: When does `finally` run?**
   A: Always — whether the try succeeded, an exception was caught, an exception is propagating, or even if `return` was called. It's for guaranteed cleanup.

4. **Q: What is the difference between EAFP and LBYL?**
   A: LBYL checks conditions before acting (if file exists, then open). EAFP tries the action and handles failure (try open, except FileNotFoundError). Python prefers EAFP because it avoids race conditions and is often cleaner.

5. **Q: Why should you never use `except: pass`?**
   A: It silently swallows ALL errors including bugs in your code, making debugging impossible. You'll never know something is broken until a customer reports it.

6. **Q: What is exception chaining?**
   A: Using `raise NewError() from original_error` to link exceptions. The traceback shows both the original cause and the higher-level error, giving full debugging context.

### Practice Exercises

1. Write a function that converts a string to an integer, handling `ValueError` with a custom error message
2. Implement retry logic that retries `ConnectionError` up to 3 times with 2-second delays
3. Write a config loader that tries 3 file paths, falling back to defaults if all fail
4. Create a custom `ValidationError` with fields for `field_name` and `invalid_value`
5. Write a batch processing function that processes 10 items, continues on error, and reports a summary
6. Read a traceback and identify: the exception type, the message, the file, and the line number
7. Refactor a function with a broad `except Exception: pass` into proper specific handling

### Beginner Quiz (10 Questions)

1. What keyword starts an exception handler?
2. What does `finally` guarantee?
3. How should you read a Python traceback — top-to-bottom or bottom-to-top?
4. What exception occurs when you access `my_list[100]` on a 3-element list?
5. What does `raise ValueError("bad input")` do?
6. Can you have `else` without `except`?
7. What is the difference between `except Exception` and `except BaseException`?
8. What does `as e` give you in `except ValueError as e`?
9. Why is EAFP preferred over LBYL in Python?
10. What happens if no `except` block matches the raised exception?

<details>
<summary>Quiz Answers</summary>

1. `except`
2. That the block ALWAYS executes, regardless of whether an exception occurred
3. Bottom-to-top — the error type and cause are at the bottom
4. `IndexError: list index out of range`
5. Immediately stops execution and creates a ValueError exception that propagates up the call stack
6. No — `else` requires at least one `except` block before it
7. `except Exception` doesn't catch `SystemExit`, `KeyboardInterrupt`, `GeneratorExit`. `except BaseException` catches everything. Use `Exception` to let users kill the program with Ctrl+C.
8. A reference to the exception object, giving access to the error message and attributes
9. It avoids race conditions (state can change between check and action), and it's often cleaner/more Pythonic
10. The exception propagates up the call stack. If no handler is found anywhere, the program crashes with a traceback.

</details>

### Next Section Preview

**Section 7: File Operations — Reading, Writing, and Managing Files**

You will learn how Python interacts with the file system, file modes (r, w, a, rb, wb), the `with` statement (context managers), reading text and binary files, writing files safely, working with paths using `pathlib`, CSV files, temporary files, and real DevOps scenarios like log parsing, configuration file management, and report generation.

---

*Ready for Section 7? Let me know and I'll generate it.*
